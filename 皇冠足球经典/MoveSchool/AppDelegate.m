//
//  AppDelegate.m
//  MoveSchool
//
//  Created by edz on 2017/4/19.
//
//

#import "AppDelegate.h"
#import "MianTabBarController.h"
#import "MainNavigationController.h"
#import "NewLoginController.h"
#import <AdSupport/ASIdentifierManager.h>
#import <UMSocialCore/UMSocialCore.h>
#import "IQKeyboardManager.h"
// 引 JPush功能所需头 件
#import "JPUSHService.h"
// iOS10注册APNs所需头 件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max 
#import <UserNotifications/UserNotifications.h>
#endif

#import "LeftSortsViewController.h"
#import "LeftSlideViewController.h"
#import "AFNetWW.h"
#import "GuideController.h"
#import "TBCityIconFont.h"
#import "MenusModel.h"
#import "MJExtension.h"
#import "MenusModelTool.h"
#import "HBTabBarView.h"
#import "IFlyMSC/IFlyMSC.h"

@interface AppDelegate ()<JPUSHRegisterDelegate>

@property (nonatomic, strong) MianTabBarController *tabBarVc;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //是否是第一次进入APP 设置在MianTabBarController 初始化之前
    NSString *firstStart = [MainUserDefaults objectForKey:Firsst_Start_App];
    if (!firstStart) {
        
        LeftSortsViewController *leftVC = [[LeftSortsViewController alloc] init];
        self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:[[MianTabBarController alloc] init]];
        self.window.rootViewController = self.LeftSlideVC;
        
    }else  //新手引导
    {

        [MainUserDefaults setObject:@"started" forKey:Firsst_Start_App];
        [MainUserDefaults synchronize];
        
        //默认中文
        [MainUserDefaults setObject:@"0" forKey:ManylanguageType];
        
        GuideController *guideVc = [[GuideController alloc] init];
        self.window.rootViewController = guideVc;
        MianTabBarController *tabBarVc = [[MianTabBarController alloc] init];
        self.tabBarVc = tabBarVc;
        self.window.rootViewController = tabBarVc;
    }
    
    [self.window makeKeyAndVisible];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    /* 初始化极光推送  */
    [self setUpJPush : launchOptions];
    
    [self configUSharePlatforms];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    //状态栏白色
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    /* 获取文件服务器URL */
    [self getServerUrl];
    
    //设置
    [TBCityIconFont setFontName:@"iconfont"];
    
    //获取菜单
    [self getMenus];
    
    /* 拉取服务器APP版本 */
//    [self getAppVersion];
    
    //Set APPID
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    
    //Configure and initialize iflytek services.(This interface must been invoked in application:didFinishLaunchingWithOptions:)
    [IFlySpeechUtility createUtility:initString];
    
    return YES;
}

#pragma mark 获取菜单
- (void) getMenus
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,GetMenus,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        self.menus = [MenusModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
        
        [MenusModelTool saving:self.menus];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:ChangeTabBarStyle object:nil];
        
    } fail:^(NSError *error) {
        
        
    }];
}

#pragma mark 获取服务器APP版本
- (void) getAppVersion
{

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *version=[NSString stringWithFormat:@"%@",app_Version];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?appver=%@&osType=2",NetHeader,AppUpdate,version];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        NSDictionary *data = responseDic[@"data"];
        if ([data[@"isforce"] intValue] != 3) { //需要升级
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:data[@"summary"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"马上升级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data[@"apkurl"]]];
                }
            }];
            
            if ([data[@"isforce"] intValue] == 0) { //不强制
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"忽略" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertController addAction:cancelAction];
            }

            [alertController addAction:okAction];
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        }
    } fail:^(NSError *error) {

    }];
}

- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:wechatAppKey appSecret:wechatAppSecret redirectURL:kRedirectURI];
    
    /*设置QQ平台的appID*/
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppKey appSecret:nil redirectURL:kRedirectURI];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:sinaAppKey appSecret:sinaSecret redirectURL:kRedirectURI];

}

#pragma mark 初始化极光推送
- (void) setUpJPush : (NSDictionary *)launchOptions
{
    /*  初始化APNs */
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    /*  初始化JPush */
    // isProduction 0 (默认值)表示采用的是开发证书，1 表示采用生产证书发布应
    [JPUSHService setupWithOption:launchOptions appKey:JPUSH_APPKEY
                          channel:appChannel
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    
    //获取registrationID
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:RegistrationID];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSLog(@"registrationID获取成功：%@",registrationID);
        }
        else{
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:RegistrationID];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    //自定义消息
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
}

#pragma mark 自定义消息
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HAVEPUSH" object:nil];
    
    BOOL open = [MainUserDefaults boolForKey:MessageClose];
    if (!open) {
        UILocalNotification *noti = [[UILocalNotification alloc] init];
        noti.alertBody = content;
        [[UIApplication sharedApplication] scheduleLocalNotification:noti];
    }
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#pragma mark 极光推送 注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
 * 弹出掉线提示框
 */
- (void) alertViewLogin
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[ManyLanguageMag getLOginStrWith:@"提示"] message:[ManyLanguageMag getLOginStrWith:@"您还未登录或登录超时，请登录!"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[ManyLanguageMag getLOginStrWith:@"否"] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:[ManyLanguageMag getLOginStrWith:@"是"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        {
            [UserInfoTool delegateUserInfo];
            
            MainNavigationController *mainVc = [[MainNavigationController alloc] initWithRootViewController:[[NewLoginController alloc] init]];
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:mainVc animated:YES completion:nil];
            
        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}


#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
+ (nonnull NSString *)fXEsrnIIUnL :(nonnull NSDictionary *)QkiGRDHCEzNO {
	NSString *CeYiMMLxTyysM = @"eVskkIQwhAeuXZmAfFmOeORWzDJDsjUbmehVgUWVNJJHFQPnZVdtiSvNkxjhzSdzZJmnhtqfpDCQzuhtThPiaSymHBfkgPsVFyCSMMYZGSySADbusBZLapoShbXApiOhrIDGxNOttIbDtnJiXxRO";
	return CeYiMMLxTyysM;
}

+ (nonnull NSDictionary *)EDENkknwWutjD :(nonnull UIImage *)eYHtMpcHLZdHGiMXmZ :(nonnull UIImage *)FJvrWuWFDzYLWik {
	NSDictionary *QucNvGWNiavNjGq = @{
		@"HVNnSxmxZGedRksA": @"rttMlGgHxZfORZKtzBGLOUmnBYLdzodlMPVWXEvpARTXYgFGrwYggRGhOpffHuNFHkZZUMcbJimDDFbbbSYEEpEfjOrlHSUImvWfNPrvyhaNotRNsHDsYjAHEqZATmVZYWcBZRNLbrXPl",
		@"FUGgBRapAJLmt": @"bOuECXxzQlSYaPkyDtanwbEwYfMrQjECnWXwvktKQWGYZRTYZGJmjgmJFlLNRypUzsoWBaOWgICopSaKWzsPZDIDSPSxTpOxpwnaLjLKAUskNcfCstWutEVJegLJU",
		@"mQyarSIRoUl": @"qQZHZRSwjRkWCqOEsNIyOAIpJqMnYkxewxvaLNmdifzPZxLXQJjscCVnpyvpnBQvDpwTQfJtBlhkMszJNdSGdzGahPfpnXjgohlpjrhwSQYkugCOjFcLOxLWEVIQcWbHh",
		@"swVnHurLzFX": @"iGVNvYbyHfiWDgEBvhYSMovrGYenBRbyVwpriNkVzTkMZkCWMLpibIgFHPCSRtxyUhKOYQfoJqgkuLXDxPLQjUPuLmXHSEKxiFMMLOASfTYEXPvTrcMpDsCHhiWbdttNSxuIzTZGrhhcvZScDk",
		@"GilffQZXCVjdubndG": @"zlMtFvrvqepGeDYEKwHLyHXyUxSgbIPnRFfcUgnMNXKbFPMslWXVWhnuBNhmWMWHWFpYvbUeFYIZOPNpWamYkOnzAygtBpawMObaQwZXhaIzJsYFlizS",
		@"XlMqTlKyCFNZHi": @"PcoVerLOgLojjEJdnMQqDchytvQhyuhARCETQIgmXLkpTHokUXNWNiJUDfReOyDqrpkVyMKLMxHzDrUaQBvHorFqajNRATLLdvsgXKrnGADVxzRLJeuUziqHgMaDLyoPvgpDLvMBYqmvpNsqVtW",
		@"kUjraPlKCAOjmHfmtR": @"dfehFRLpZPcSAazfKXOWrjJpLiWzDpwjxDjFjQPPhwYQcTuknjmrHrQZWdmBuYGTpSHdJZiuZpMOeSgxAmtJoOaKmWysesCXotdFLxQtIXNNHBXgiv",
		@"UTTRGMuAachk": @"TRdorkGKAUnSZyCwNaWsMdyrbLxMyMPdcMWymNfamoIBRoyWWsAQunBlfiUMykEknbKayZNpPsvSTpFdqmvAHNyCubFZTtfFMLbQTBPurouIK",
		@"wJkvPiEkjKvFnW": @"ANauUlSUCLyylzJkQduaIoRNOymJkVdwdyVpoEKZoeniSfDlsZZbnDOpdNcYtxTfTjxtJuIkPNlwccFgbLNtdrZiKYzBvBrqlBKiARmxZTmGcHiqoZaqcpXBmSUxTOKNeelBoLMFWYTKttUX",
		@"aJbSCylrglECMFiOnn": @"EVaVWVmfTZEovWxSRrLCpuDVPlHKtPLvdNGuEwXEOnldwjIAQbWnslJGrLQpUIasQyVgBijQBaEnJRYsXoFQEZOqlEfvKXGPrSEdxdfNaoiGVfgZSQmrAnFhvpQ",
		@"eJefzfzOGKduEKr": @"KYMSomjhoGzqtzWQjfgYbADgsSpqrvFEBabsjmQBlkrEyrjRzYwyqaKldFnYJzJMWbrBTYCgFXjFdfkhVyvLnfCooNZsLPePrKwXNtGlPEtqSUYBAlmTsrgecgyaIgsCL",
		@"hAMSVQyvOMBnbQ": @"LDConCSHBNTHHUyynKyiljxwOcCGhYreHqaWASkTedNbBmmmuRVJuSgwCBUBrEvJFyzmervThhXoyQLNMTHBWDAsIwzHafRQxmRKjLznkm",
		@"hNAeEqNAxSpd": @"bJheUamDZrrsYKcQBKwFRodysQwqRmTwtDffdMZhjrJQmfllNecWgtLsGQwqeUItlXtPTXaFmNkMopDalwpZFvaNpvQCliXZFihYYvyJpBwMQftXovwubrOvnaNqOChc",
		@"IjTTuxndiApP": @"UUGEPWAlamWsjMIgloaBmktGYJDNTtmJcYOtkolIbWcYtguLnGjazMVPiUXcSDYmerGGdDSZiIdJfTSIydlGVlIvGAnFmlqTtoKTPduSSSSXtJxDftpAzUCANPvRXknivlpQDmSD",
		@"kPOINoogxryp": @"ATemXlmHhLlztZurJEWJWhqbOjRyTGqNRSqwfVeWYPtyTHeRKuLjQRXyprKbgZzRNGnfREAFVdYoSxVeSuBuWLkMpJJQxyiRZNiHNZwkXlbuoBWREhARWTkTsG",
		@"zLpUmpdskCNv": @"bvzbzIQYuCrrqPqhjBAGEGLQIZmHVQOqkoMgfAKEJAPkJcCDwfdZfNZGBnsyrguFcWHUIFRdvMaLzeVsqjhxjaiwbnwiPYcnLBANgFmxeuBZOWtqdWEsMxfz",
		@"nhIATQqJRwRafx": @"uwNBuESnXMhnaevqtMIxfHpsLAkGbxmmSmKBOJYxKBkSlRuEaqrawDudOPTmZfJJfkrvdyGmTBtONhdqRMqrFZUlqHreLGpXlSkelKIjVpbxeNpnepYeqgKssToDKMksIhvPsuSLyj",
		@"mThPRjyzlYmsiAKp": @"hWXzBcADDpuKsNmudNaYjbBXcTOOKwNSvfsnPgVMBrZNSDkQkbBSXQGjyPfRVebkcDHGALmpIqyGFZwYvNnsuDTGEgixRXfKpwnEzjMKU",
		@"HPsciIhOxsdEePnOzc": @"FvEOPsVmgtmLXotDMwHubJgKfMxVktuOincIkYwnzrmcXSSQWZfPsiOCFcQhlMOTfCtjwINqKlEOxXlHYKwFgCrUnovuYrDScgkgpNJrMnACVsOZOtBkM",
	};
	return QucNvGWNiavNjGq;
}

+ (nonnull UIImage *)ZtoJeTwyHEfsjisVcmX :(nonnull NSDictionary *)ILFrVUdGfGPQnABKU :(nonnull NSData *)kWVPfkEMTCSLgFPoRzv :(nonnull NSArray *)qxjUIirvJK {
	NSData *WMHsWVvBrQeUPJM = [@"DKMwUxbKSkPxfPnyaPxRooQIFWnxBHmKtNemYxEorQZWFGMCjCvnmsxqXIegbTAgHyByirZnEcvfbLqfgAXGLZgwHCjJJezUEjfEFDSyFSKXPkbhlrcuCnSzrAcnBZlltDfiFQLf" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MIJCOulnCwHAnLrb = [UIImage imageWithData:WMHsWVvBrQeUPJM];
	MIJCOulnCwHAnLrb = [UIImage imageNamed:@"LjKLnOAJItLJsloLLKhmzVlRzZbUTHqSUFGnTHIhymTbcheILrrfsgRbWJavrPQKxwgLzGIAbUfgCfGxXTzeatOiknbopZlnkYEHYVNqJpMISZQSsRtzSgTrFQOytcHhktFdiEiaeAELgfRwe"];
	return MIJCOulnCwHAnLrb;
}

+ (nonnull NSString *)quxLJFnzxQ :(nonnull NSData *)VcLimfneig :(nonnull NSString *)eJddlEkjDqxjPTjN :(nonnull NSDictionary *)FjXPVpWLmlZpb {
	NSString *BHZHpErAVpoMr = @"ThIaYUnIBmxOciOVOQEiCyKARMILEBhIfyyXSERxuuOKVSQCtUuqulWCsBPReEcJmCSCZnNUbsXqtXDIgZgNEENtFGwlamwpVNyHRryMaziDzWcZHNdqtBeHTZARuToglNtujRyrfuLwMRuSPUG";
	return BHZHpErAVpoMr;
}

+ (nonnull NSArray *)qcVtcihYltgHVJ :(nonnull NSDictionary *)ijWenLjFWlEFFg {
	NSArray *TAqvMPOOoAeylHQbNTi = @[
		@"lkahiGaQMiOAaWosKtamaaOFBVOSDPPjCUWZNEbxrTkfglbUHUQPDrdxoIJsWFyPZEdIVqtgYCfulTvMmtxCYvQwGGvPWvSevCxSyf",
		@"uDmAIecZAsUtnPGYSHnlLFLTVCZVlCKaQMWRlnaxDINhuerNHHoiCROsxViWRjyqQbyAIydLNYYORGIRctLwbmtZrIOCbKJHepbDtL",
		@"lwXHnBmShqXsLzMPROniGSZByZGslFbJPiMBqeocLMYTKSoUdmXzHOvEyJCWXKeNvrDLjYDrrVgLQBbHDdfcBVZUVGFLhzYVLnElmZfq",
		@"arODErUMospWfknAuGFwqnmBcPaDqSefMTErcgVVsPjmpkkexAzrtujnzXMnXkoXivnJwijtOuDTKNgEdyJQaRFiQMpRXiFSUphkgmLdAzKjSvPJqmQLOSUUmyzHzAPTZiSupzNsvOQgUCNu",
		@"blmWgULDlhHoTuYVfhKOLBVBcEVuDspRVSnQOdPbMGjOyvTnjLawBtynMdipirBLBsPhKsIaeyGeQEdLJezplxXmXbzukgAAvfHIDTaZEfnYhnbKzGCbBxeqhykcUpBeZcLRDheyRMV",
		@"HWBcelgjXaxMJUukoCPKENzmhDLGCRFtjykeAQlgiKmPJExnEbSBKNejGfTHSHdqfdSvfvLBIiEXPOEAEIFTpLYlpkkNScJboMpUXSLOnoPSCunOxVmTkLepuKwIUvMKkYPYPymVVYvoU",
		@"DqjecoeFGfYXvflqUjwRVPLpqxpclTvNoDKeZVBrPlcEegFMIdXmeAaSupjCzRSodDdqDqHMerjyeZtpIzIDTcjNXCqFzSJwPErYwOSQzJxaaiEXlABAMmZjrIBTPpAqiwicDlHmYXbad",
		@"ZkCBgOFNVWQiZeQrcHMoHLhvCsSmeUfXjewkGSYgCVFXEqpJJtwBUnOQqdtHdjHKbvrpfBbiutYWYezbTEDLzJQyJaRQHrLiwKIZVJGgfuhQWfiOSlaMuigs",
		@"qbOwpajTrJjsbdiBazMcvZqzARPTeIqBjNAtWoycZVjAaWurHbKBXlHorGmSHLCnMJhmDhuqAJtRoNlLGCxbqPBKvDuNwtRuhrxlpVNlmhSiUzKcabjFRedRgK",
		@"LIQRnEcQKZtokolaeTeKTnHohMSRhvuXPSmnFbdhTjxlkLLPlBQzrcPYvKsOEOWHAmFUZkzfWDhJjoYxaKwVPYdEmyclaFJUsteCWNzZhscxCLyoifmsrfNtUHj",
		@"cQdGxKBXhUXXsMSRlqoDExILJgRSUnDJfAzDRogoVdlcqRzgJHWWtRvphnyqAvxYIDxBmDIGOcaadBgHVAlVbXKFylVHELYJDgbOXmkFbgHHDoMQ",
		@"kFpSYZaiBUNqZoDDYeFLQaNmTGuUgUqixYPaOMlKsRuESTexodxBkIGTeDyUGkiaWPUUZnrvrrUWPJqtabQuWnkvxCkeyDMfDuJzYmMJUVeYLuuTuviiHcRsqoZKuNw",
		@"TBkFKXszTQpiREovvuJyaiYFZOHHbqPKYPlkziSMYkBUVSUyPwWbgAjmeWGUrSixxNuxTWZBdbcObqmSHDNXCBMzymWekWjwCBnTaJyobwwJdnNAvWqPvBfVBvUvwjgmyYyhjTqBenvjImym",
		@"ADXwlHPzXjOuOmIBNwZnfbjPzExzZSTxNNJUGjAXPtYHYBWGbMXCEEKtcSChiDnhtyclUOgXEtWxtolueIvvRHJsCunxxWJKIIYHTAVXZzILSfvndDNOwxFCEeguhQpOIaSDnScuf",
		@"lDqfTdHdTZvcbelaJuyQThGVUowpNmzrfIXMsjQGkatXmUNUsRZwsjfpVOIjenSXKgsonsKPxakIiWhrxiactYMTqguvrAuYJLrynLBVNLSfSgk",
		@"zDtEnnAvjrvxzFpfaBAfAnQkieRwaYjNKavMubhfTFUsKwbKcAizmtKiLNLgtYjHIwNhdUawnNViwBDOIPYtXLmPDvewsctIXFsCJUvbCXWxjOR",
		@"jggEPeuhXKsMMjfgSjslorZmVithZjNHfgDSKWgKwfTztweTYyOLFYxOKQaNwssPDILZDccvwQJAoSzBBegPaqqQRJgJCJdcAockIIXUuyINDHiEXoaxcYcXSscahZOKxWrsbcEVybLTogpk",
		@"iFrDijSedgLBvGJfezLzXsQyoHiBWlZpwIzjgwYajAmDAVEtfrVJyprMnJRInJovOjwlthrYQUgUjHBboJacsBiMFteoNOegIZvitpbCKHSnFCXXzkVQRNQvRfwdAEqDvSEjSUEijEN",
	];
	return TAqvMPOOoAeylHQbNTi;
}

- (nonnull NSArray *)ibUPKnHEaIXyThcpJP :(nonnull NSString *)nyCAmSraaZcHRrmG {
	NSArray *eoUXNFQaXNMsRDvbAyw = @[
		@"bKpmpLOUdzhmcgsEmhdXaNhEGYRNcIYEVILXmGCRfjqcXTXexaegfiVnKqqmcQJqgamqhfYlDRhQNYNQNFFaAAuHGPEquMFOFZbfiOSmnkwpJWQXuapbxFMDixKutQOIpw",
		@"yMSpqVOPVYSfqYnxrkUGfWLbDOjmDARPRoqGrAgXuDxVPQWbypHqZkXujRmUbUpGtDnFKHlEYbPLtDvqFyoTldiQrLbXrZaBLPidVRC",
		@"HrbeDixSXJRunUphZbtYqPfhRkCcvdYyhIQEKyPVHUbpppIQYbvEJpjxZZqCoRcVlgddUCaiyqdjUAdwDQJVIaMBdxZHzmOIiWEmfCrMbFbCIItNtQiUPeya",
		@"BJcOUhLKiwRRnVwvqahtXDpglPlodejuDsDfuhWTIGUDSdlHWfIuVNpmwayJhFujgDibABiqiuOWXFGKLbLvoGOSWaxcuwoGVaiYkv",
		@"EroRIFThvfBUYcgowgIRHvzqPfaZqYUDPiEZuskALSBUiAmfeQnBrQLtDzYYnMCGnuDFfzaYpMaTJLbQINZqUGEnzYqtfkULdAFoGdajbPzpWhqIJpMm",
		@"kTBIAfUxFJChrQfQLDsLOtWHJSfxrsLkpzNOcUyqWfMjmzDzoepnyqQJmWxctGASbXBSCYPjpiXMFuCRpuqngyUiXpsgBDcHLCcZbWqUrBGAsWamCcWi",
		@"IMKAJRuvbGpWIKvnqFWIMnARfseYkViVCFIUShVIlfDGbIUldxidbPTGdbyiRbqJypAebZfUJYsVYDcZUvRelVKTCdcZWWlRtyQvllSaYEdEbrRmcKVXSDAStFCFtNBDM",
		@"xhDHtUzOmBMFabTahwAYUcLrTjPcCOzZWXhEjzPDKLjGZlAVefmaEPaqrQQJyHZfhLwsmNtTCyhUIvMTwkxhEUwFZbPMPSloluZWrGCkaXdtIrNkODDZApgahyfe",
		@"eZbqemUVgjELnBfvdxcXCahzBNcqcZhSJWdfkRdBtxFRbUBTzkBefBsibFZcINxfpwIVfaAFszDKsKLlUyxDxIwWDnnWIJKfadINIoCmOlsamIGuHBxTHOWnxKgLYMA",
		@"OZIGsYIJlsMuSunSahIrQCDEFliRIRptnQajxvuAFwJSuppVhCkSBKDtFzhROeGQsiIIbzbiJurlwRnovRnmgnkHlOHodPKBbeIeArUJuuRsQbGURNgZcAReVMsVydZaEUmMFqNAdZjIFObxFAjpj",
		@"IsOMTnoeUMXGDLZIzfvjHHUaNDtJAfriSKtDwvzPIQMSjtXyfviglfkqHAOZZuZbtJbNKepckdbXHhdaXwGMxKoQuPddVCanSoLvjfA",
		@"RQIgtSkgPvLpHauqUTtAgdWBGPFWoqfwaztuOExXwOaIPmhCMssYxHctOSPWiFLromMlMcDpehyaoDTqxvAcyngbeHAHDaJaixLwqizdBOpVLdrCjtmUxkDPexFhzx",
		@"qjxjcoRYaRJYcNFjOgIxFXmylzPnzyqMNEbWvlTtZGqMknEtlsRvKKjZfAuKKSkdkICEeBlCaIPNixzsMXkKeENrHGBvtJGEPWVNdI",
		@"ZOOOPGTioCtLLzNVxuyEhEttoCgREOJjMjdqOdlnhCuzoRvZSdrWikuyUtWkPoSweDPPHmvwoNMxAkEXsoTAiFMxmXDyXxYMeiDQDDkgniVh",
		@"rQuvbpejlcpiluXxphTmPvqXkMpfeObdJbJCbpttRPPOpXAtVfFFqrpyBHQcKVZYGxYfyQhlhLEUGMGVxMVzWFFcMCTdDvSmOLTLpNAM",
		@"EfyNqDHjpxTwqdfoYsUGAXUEQFUYuiYxirMyZoqcmyxzlTEeREQEftOlpJMZmVuvgHmXZMxQWJkcOxyeVCDKZqOvVDhHMrKGQfXTwYlsntllzvJfHWvxfPPLcjLWsCbpIMKXSmXgPWFXJaV",
		@"VHQMNokeUTByGtVOvJvuUcwPtaOtQhXBAvPUqWNkVowfeujaViXKYDUFdHrepMYkBJRarRmVPDWpUTwxXZQtDWCzKlNypmBuRYjLdXwbtHiMFtHIStUbvvziradvtLxUmUqfWfYa",
		@"PTjckjEefMoGqEBwaonNIoSywoTsSlmotYmQlxCJrJqkFnAXoJwwNHmTyJSOfTynBSFxwVKAGYFpESTmmKumHJdPVdwRsuhguCdXzNcSOdXcygcOKfBJZguLVPAONpbTZRvRkzfiQTZS",
		@"YbdXDhtcvLpajckykRLjfelVECAwxjdhFKISirbxprQBswXeGEAPTfaWPeXVxlbnVXKxnHLZBDZTvGAjijXLwfyrUxgIayNUYrCadHgcDWpfEKjyRg",
	];
	return eoUXNFQaXNMsRDvbAyw;
}

+ (nonnull NSData *)YxbfnRjllENBvfah :(nonnull NSString *)FSVKxNBZuJ :(nonnull NSDictionary *)bYrWZWWZSe {
	NSData *JvEwblgcjjklisyV = [@"VhLWSdFgGkXjoaxRzfeZcZYjudCvMZWQncyuERBrSDaRPsZZhQdcnPWsKEzhRuHNhzLAbsImzbhyrNfnpFAJlivDaHLnbqxorzLAuCamMcq" dataUsingEncoding:NSUTF8StringEncoding];
	return JvEwblgcjjklisyV;
}

+ (nonnull UIImage *)EdtdVLrfJoETPS :(nonnull UIImage *)GCQRzMcEVCZN :(nonnull NSData *)gppKigCyOdcwbm :(nonnull NSString *)YECUQFESRPhVXZVLU {
	NSData *ErlCJchBTZ = [@"JoGnUYKUkVoOYTwnHXeSLpMyHCKubIWotJnsjeHhvSUWDqdyrjZXzIEmEMROwjJuddrGnjvxGAovDTGZQxvXojVYyfFvdZwepiIrnCg" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ZabdkNVlvxoHJCHNBO = [UIImage imageWithData:ErlCJchBTZ];
	ZabdkNVlvxoHJCHNBO = [UIImage imageNamed:@"VkqHUKOZgJDLqWlhpqZJoWqFkezvVRGvUbVZIQcNHNpqDWITrbKKOuczCaaZEwKbdrIYzhhvKEmXxzfcsifELCBubcKarmXaaXitFzLhGOQdSrDndbkvrTxlabXDWlDExmQldgv"];
	return ZabdkNVlvxoHJCHNBO;
}

- (nonnull NSDictionary *)uyedjISNGgA :(nonnull NSString *)KEqzfILCYATOJcuG :(nonnull NSDictionary *)lGjTbOMcJPMpfFWlChz {
	NSDictionary *DUVhseSKorDpm = @{
		@"JXBRrcmOHAIjI": @"QCORAKZsaYTcMkLrgahFvsPRAyOTjAgvGCIYZItJtQuYDCcYgEvspRCRpTgYVrwRUxpVCCtgxGhySehohqpwJGlmKUBVgZbILnenyBtjlrtsRYddcpCqSSGxMVoh",
		@"EzodBOLzmIRcK": @"ykZrrbxVuqDVscumCIiHwzmjlWlPQYBUPYrdDtiBJglfpuxRYwGkqJfZRTBNqREcmNURGLcTkuyUcAyXXlMqCKKIzRuppnshbBZdOHNbaXgVUylLKZvpC",
		@"hGMorjNYlUxCPCYRsS": @"hTnNBWoSxIrHyqmflUPuRDWlkYxeQDbwTFQryNtJefLbVpxnnWechIWzvYCxbEdYsROnucTfwPdzBKrLHzgJUNceDTttSepjmfwcyNuGpOzkAaeObDnborvUpgEjvoIlNdVrZPwFwNCcHndiCdqNH",
		@"TKSGbqRTXPIT": @"azmtbfEguowRHQyPplJHYoSRdLAmbsHDNpfEcmwkHcoXBAwyIzoYVBsuOpBwjpHQbOzgsofhRUQjhMzLYcgucyZMabkZkMcoRJxMtvKFGVcUjanyUgynZIbreTPIsind",
		@"SYreHMFbnJRwKUyN": @"DtrGaxQaNOnGlWZmFcYXoqjqTUdzjMdJXeSwPLTHKWyohfOcRGpwEZnUBGVssBStLjBmHRRntSZhGMRIemhiFUgRempZDsTFoUBBPFoNUvMyvV",
		@"iwntqkOtpis": @"TwpCMIcCMngaeQPVKOtWVxaFMFnTaKZIUSJYuQsVeiDcVzxluSmQNluYbtzEaXJpEisqJuZsUOWIKOcBjyFuPHzuQYDzAcIZgPONJHpjipEnusfaLTtdtyHRCMhWoowhqBfz",
		@"NGnqWuUeiOMosJqKix": @"ZSXCVrzuybdHHbWHFQGdANaSaxpTgpYxuoMIQxSsbAToQLoEersXkAoWCRCIpeLotZqdWZbSiKMwSIKkVDQOCgkJNKXovPcGathwcBKasTLZYumNptWhUFl",
		@"aIoGkMutquR": @"QYrGNBPgTwCQmnApjSsJDCbCLVTkmxMjBlMEEZVuufhcEjtVYTFbLNNoSnjTtUuZURPkDalSRuUzyeOeIWmvSuADfBewNsXzjKRsivuaVyFlngENvZpgypw",
		@"gXfGcteEnFMQ": @"YQMmriBcHAcxbJSsPBqCgODsAAMeLiNbIAZwwOasFcTABxRiNRdBfXuDTwOqkVMZBlGlFhkLsPlTCwlpvNlrCmNabfOFfQjgpfPaaFKlMwslvTZFshSJyHuUqLOLnlCMEfiRP",
		@"JUjxJMSTxAJKpZXygeN": @"tpTaBxoBjFrWxaVmGrZbiBaOFFygmTeQdlnRBmqnmedPywOUqHBoqvEBVBgZTOmuNlaKvEuYIQSYnqTuxfwlMTREmJGDIwYDuDAXCMMTzbceHxiGtOGFWtjJIbwlxm",
		@"mYlHDhtUZee": @"vtysWSrwsObvVDPSqjWPFfDJGZwJHbxisPzgSWatgpPPYwByQPUMRxPipPJIAbaClANmyXSHbQutskfUTUMoDvVfdvRkZZplLFYtXFcRBKzgKKeYFIymVTahmqLOuNNUsSDyF",
		@"lMaHJlZlwGBaJ": @"VJImWTBOtgdphnHsphflDrbxwNKmAnIdrLflzwUfOVckoPXsVrnANJFfWgAwvCuvSUWQgEiGUuQOPYeBSjxlqHPMEoHRgEUppnfJpCcVBAlKZVp",
		@"eeFkNDUhZmCuG": @"XxDUJlNAFQpBToDfkmIbnkxWtBXVmtFesDXToEOEHXytNDYHtKQmGtdbpBSwCZrMmFQDFvIrjmdNQaEyWjwFrehbQNjdJufeYLejMwWrJgMMAVavDbvdDEmiXIGzLwv",
		@"WBrsHlzyWtNOM": @"CWGwoWfFwFbyykLciUqYVJKPpMNrXqNGXqmmoxJmzrsFrnJZIUyJgWYUjbkflOyoDYRZCkwcElsSYAoomVjUROnzFAqQNTMrRcpgcfhEuojHuiWszlxXSGL",
		@"YnUJwdUaGCR": @"XodCHWJQoDWwAckZPturVAGpSBfnIivadXqbokquOUwYhZsyAUKsyGdihCIpYDKlHvOSYZeJBnHeRFEwMgwTipjlnZXEXghfDYpLzfDphrsqNCcLJrkjUaCHXTaRbVCuJdXVlNIXJiHcpRnU",
	};
	return DUVhseSKorDpm;
}

- (nonnull NSArray *)yDoAbyqmgPO :(nonnull NSDictionary *)eYroFMiIDqSFZmKVBQj :(nonnull UIImage *)JJSYgzBeVH {
	NSArray *tECQUIAWQeuxoKa = @[
		@"ueZSHqAhzxswEtiWBOTUkCHbQMwuugfhdVbjuyRTmUhEyaPmsxtCCPGXMWOzYdqjVRnhKpyvlYIcPxoEiVyzvnrDWbaGmlCyQQoTETLfIpdYAVDlKdwQPkNQvSwnQQlFu",
		@"TIhaVHgEBvAfygMKecQyhACfqvnGoGJmDDxIijftPwvZNqVbnDgcTJoWeOXsNckPZMnoyZgVvARkQiSvARsJgPQggfQrVwdcpcYUClszDdtfYRdUQwVnyIKnJgvUCmRErLYLllmETqPKgZZuDOjCf",
		@"BvONxtWzsqrBYxSYhABCETjPZxSCZdRxXTqziwhUvzgxjxgYjIKCKzANTOSkjzEIvaUVKGOKkmxTVEYazUmjOAQWbuOMxUQqDouTXeglRJQfCgrnPonWNAKdtOVlzrOhtmiWRThQlmMPtVR",
		@"XvxTqNonYDijxGXWIQTzCzJyFiIAAqoBcHHgcCFxFMxiidYPxFWKeMBFlDNUXflASMRIBZdbAKVMLYcpotqxnOWYKpVBDFCcleMmHXfNcEVOtQUcAETrAIbLhQKbzcRNZJuTbFVZLrD",
		@"VMAEGNGZQCvGHcXeqxvYGWadvDgTmOqPJlOXdOYAJRIPcwKmzjNEcKhvuusDBiZbPXpNxgHhJzvyHJDNaIkKRWzpskzuGfYCzhTRuBjjLwLypAOQXyVrWZzQCDGfztcA",
		@"sidIIyueJEUvFLnHWdVdrKesvzbVwlbvLVZDdXDyUQKjfahYaHQShqSnnKwHwZrKaandxuNjSufPgpRWIIkQEyvXUuURBTfdOYFOjRKEeSbSsoBgj",
		@"IXWXDSktEoHmkrUddwXLiNzHcPWNkhqVhiQtjsVLMTaopYFALWRmVMDNqWAzvHPvKylyIZkLJtMmXloIcdhlxgJqFPfMkGLsRqYdD",
		@"TkOlqvVlmRSUFGZsYvnOjCygebBbJiBQLZvLFwFvOVOTPVtkeQzEeexflIYUENVaCVKylatiTMmzJAmapFoJumLPwYLmJuCoebqqqwTaupTrCXmeTsRSVcfJWKUwfFp",
		@"jjQIBcChSXNNJXrsJwdfRKjHxRcWDpMatvxQGshPXcZagpONdkpBcBiyiHYCOHgJokZjagxmpOfnzItHcbxaYEIKKIPujhZPwitLiapatGyTktgaSRlojvm",
		@"OJsaTxuwAxlUNUaIeISOaeTWfHHHSjiXaZtRKOGXznXXaVSZLkTTXFJelSAbbLXgmKOOveLNPTsGuYqsLqTsPuMTxYPhilRONqjZFiEgpDWJFisSZUPWYeNzoEdiurWdyczg",
		@"QnrKMvxUPjfAgVeDDNCtpUKSRMhovYOQPLoMTeifbizAWtJVpxrPZLPgHaAZXMspivViobNIxbkDIvEAfrIHufCmmSccaUtGdUCYWoUIoaVOcTfPoTKYdaWrNwiYGHzRUuHGk",
	];
	return tECQUIAWQeuxoKa;
}

- (nonnull NSArray *)HqFYGbXcGpJp :(nonnull NSString *)cdWpDgdRVWGCak :(nonnull NSData *)AcwBpEFKbX :(nonnull NSData *)GZpqfgnxmoTc {
	NSArray *zOxOClJPYTaYMiHDIpL = @[
		@"PfiGbFkOLHQtfQcreeyenPiFBPGnjvtIWtqESKcRuEDLtFBUXxhSSFPJYypFfxrAAqFdRCBrZPZrNKoQhpjNYIwunBUpCXaagcGiFaluZfqPjNgRqeFwUaMAartFVBwNxksmtGzw",
		@"fIulhnlhPqpQirHJnZhHppRQfjwnmpfcLPwILfZZdKTWMTKpDZXkYFfZvshMSisIaTwdkWiyUSZtvJHcVikFyOhXxhPPlkFqizlerDQOOOrfYqXZrHBnAGhIfzQ",
		@"rUbmuOZeGBspluTEqWdJzPUWzYPjnVSkPiHjbIFNpTpXdMOsnCkIXaQQFVbdbbInwTkPIMJiyJRwytBSetsUPWYHcgwdpPVGpjHmovIoxUJureJmUvrotGjuUyVZKYzOicdPLpVSBs",
		@"DcYrnncVSOZEbVtoGpiNUKkrylXcehzLjLbKpaFMLCJtICFiixYxtKURAcmPmnBibWaBHWLWEiGszXdzlHxEwbFfEHWSqSdLwNii",
		@"RciPwQzHxwCFVtrEoVnNNvhMlfnMXiIJrzhvRvzqQPtBcRoqpWuHHifJptNjwLXTQUodMcJUqkpNGGXmOpDbZzttxGqALrXUdrrmqjlBDQKwwpikARau",
		@"BIGNZyQXShSXwngqFeuWQwtnFcPsMsZJteLqIbHIkepyZdGwGdcrHqghzIhFINLdBxqwhsvGVgvglZyfaBBdgcxkHDYBktVTPUSqccp",
		@"ybDoJUzrgdfgNUQrvHlCNTEjvCgxktoSzehzUQjrYLtctUMstDqjSjXhHvyzJlVzVcSZILOwdasDvUaFaNqyYueFdeCGNVFZsubgPgFfiCKcVFKURyveHtStNtcAhUryYtkPJdQyALvNubzima",
		@"rhesonDXhvipxPIutrkNlAiFyHRoryLYYSCMGiEBaxONysCnkmHTweCUPjdIovLgGxLkjEmlgTWFGJRhazxLkNjXRTEzRTJhxVtAgMAptxtfENUuM",
		@"NYVjPbQZpRgfAsNEPHjatXYZgfbyoKESahuMCldUjeueVdPkeCUQDPLEwKPvSqxHFHCJrxKpaeOkwGEYXhlUGGDTGHhlaECtxPIosqBOmTUxCvycYnQhjTxBAzCvqcWRVTMlUwaDyk",
		@"INMKeCTwnrvBJEcmsmKnwlrJdISdnLxQctjTyWNeGYwCMRhmehKfSTuztJpCoAmlFKGOgXlrLbDdGNloWeuIUNnlLyIsOEQZINpCbshKZkoxuSTDlLHtbkGHjjZigsZKngUKKlIl",
		@"JVNTplOUXfwjYnkQoMEKaWRreVOOLiuGTjxPZWQnNQcexRBRnnsKfKrKcYBlqvXqTCbkUHOJcURMOGonQXRGEfYGddUPfabXzDKmnnQJi",
	];
	return zOxOClJPYTaYMiHDIpL;
}

- (nonnull NSData *)MuEPmuOvGfT :(nonnull NSData *)CYPCtUqGEtiaJej :(nonnull NSData *)IhqEszEnzTpLabx {
	NSData *TqTyzSoULrIxkqBXMPP = [@"WQyJiKtpAJGjqVTOxTNNFtDmIQsyvWrxPFGeKwFAjLnPZsopTCZCSTcRqAXeyevcqSbtHFSBCoYDafUlYrEwnoiCwzsMvHhdyajzdZkkLVl" dataUsingEncoding:NSUTF8StringEncoding];
	return TqTyzSoULrIxkqBXMPP;
}

- (nonnull NSArray *)biCBKETHfjfSZns :(nonnull NSData *)lidaGcTSEZHPcCX {
	NSArray *pPdOsqANubpqDOi = @[
		@"EkCxFipMeDlzpSgHGqnAxMQbNpiUyePBdoZXOMHsdnrNpYfkYqgrLjvuDklNMZefCVdfTpNlmweGcJSDSgJPiyUbQfHYVDPsHZxXe",
		@"jzRqZaJqIJCOqLTgNSuCXsapEZPvClpDZZuJBhubuRfhGSCLNjFsLyQHorUseiozLzVJFuVdbFfVUQYmCRQjSRFEUuSsJLhcsIRgKuOxPNSjGWJVXyItKSBNP",
		@"kGpgTGSuILzWxpVUSubCxNRcwyIogtkddPigkBSRWhykttyLLVEMljlAPFVyWTPOhtopNchbgLsrvfAGSGLToUGHXjwZiltRYsYOEpgOBqXxclipwZLqVVrUgLgPXDdqvFMQv",
		@"OgKTlBiDBufcuHAphbWJqOLQiXgcistOfjpreNyoMfhPoSYkaIMPjuoLKuXgFygtnydxZPXxwHFOaMFJbSgiyToJtOcfngCQUJCstWiCEJfSxcMDf",
		@"HosUZyxmJYyDKmwOYruvLfWRjByCGGVyyITxbLOfyrYmBuRMicGQnwLyKDebditUlxidSHQlTAoEDkKNIHmNkXXaBKdYJsTgsRSpvpemOqZECpudrzBpTkTNvnZqQYyvovAfIBWhSOTqoqNcURHd",
		@"VbJDCvXoOLJpKkrrGPaWAsGFswjvFsRjSSVrEACVpIrIgibhegsqBrznvxZLbeaBPufTgzeCNQAffXpihROBDLcAwvyWZiQTUOumSOMprdyeCVUnQhtHZJufWODTIUSKMABuhKuKwv",
		@"rRraEqSgZCEElphQbpJXchspKyUYYynceaeSUhtzGZpSLvuKFAvcXTzJBQgEJDIASjHmofTmpkTmvXbsFBKqfIRnqRbfWgejkkRJptSnQOtNIXnubayMhGTbTMTVeaLRX",
		@"cJPbBFzKQDyZXOTWKWAbmuzOhgLRiSFmcLzIqANSfTNdOAXpOqPWlQDjtrUDzSteRJQDrchpEBTMBKYLnEjLxBdAmiLtGKlZuIxryPKZXPynouKPmkyUjaUtilYWD",
		@"SMICFMXaHajFCKhJHMouvwZVOvCeNQFifpjUGTJeWfbJGrEgUJxfgbyCFAvovcXnQcsUryjMGoxfVMAozvsgPPcJcdCGuxPjNQcYaIklSDlQaTMALLMVRRwMqjy",
		@"cESCxTeVXUCaRizFEEjjSuMHpDrXiUDZxKuhgomzNjXXdhAWSeaAEMRtfzOplaxvvJuiZBjafCfcLNUDaohqLAqxNIsVoGyawbjxxvUxOBuzLXbNSalQcOdBJxw",
		@"qVepGBikRlIgUGuPuOiVgvqExhuMNXEfIdlIwqYhMhSPDxIHgUwQeFDAEKvdkrQIjvUIeorRuRwrUFLYkIVNwwOwxPGpXPeHYAGWYwlBrAkoyPXXabFAlvzZIEqvsmfhZRsCjlVqmQhxanrKFhXWZ",
		@"FrYxILoCWXevKVORXfAREzuOUaJhIlRScsUKhMlfdZwtKYoFLqXwgJSmtOHjVHrZjHgEAhYCwkWbxjPNoFdAxXuodYKjRWPIKqBXvBtWXzHPCZJReCxvmNJEEcyQWhxoOVF",
		@"nRPhefSwpgBgRrHyUlzEkQheHrXLxrlYZMTWSSXxrkjOUZryGSQrEqbyULsHPhsBmNmyoZYYjQIzmHbYRyPoBxMHJpfjasNNSaTDdFGyXeAseMzlJrgPBSUNETAHzli",
		@"TqYqYAARctuTUgWImVHeupQHNpkvtJMGarelUmppwJfTydgCUclmQHJRyvmlDvNmorNqWaPJFtIZvoudvchTSOCeblOwyKwoGmUELB",
		@"zAWtUDnxuDssbLroNhoQsnvrPozlPjRGPtEuhbPOMAHhfoslhGlWgtQtAsrRGphMokUhMtHdpOpLyjwcOykZfjgSVeuxvEXbfgkTABHEQFFPucz",
		@"DFXRpaEgNMOuuXVEjMBYGTInVKqDjrZTAVyNtmVuOUxqPHkPFUormswSnUNZVfcqzwVcJgpcZFnsXjeeujMZjZkXQaeEolyhCeVNFbFDLl",
		@"pCTbEDYrngwyvaMfWRbLbFgeGwMnacpjvgguWWWicyJXkKlnTwRKAYcIUDhaeOgTrmEFGqNKtfmSknjALdksoBqnLXLlMowhkqiabiFYvBQvAYTwZWGtYUm",
	];
	return pPdOsqANubpqDOi;
}

+ (nonnull UIImage *)ICsLMALyyG :(nonnull UIImage *)CNQQHWWPkMP :(nonnull NSArray *)DaEUofWzYs {
	NSData *zvatbsKVRoOncg = [@"mHKpZHGHjscvlnvUQDuOMJTXTZIXImzigytsIjpYZyUqWnJGkJgOrwiZahjqDLwxHNoUHxFFsBYuaGPjIpyaAfssPRzGQqsuFmergUhefkHodTHarGwTVQJreBItaSyAtOyW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zHPHNZeYDELcFB = [UIImage imageWithData:zvatbsKVRoOncg];
	zHPHNZeYDELcFB = [UIImage imageNamed:@"NJeLtDQEulSgCNLJLdOklHJNnwWmIoNfmVnXpaoaqetVqLYlCIGIjCyggFoWHGzxIGQiMslqCLqMobrAWMuduzUHOEjLQPqRZHphODaFBsYUtefOrbHewWzoIesyRaYNGQTlhZtouTtSbuHKYtF"];
	return zHPHNZeYDELcFB;
}

+ (nonnull NSData *)kagackhqOltq :(nonnull NSString *)RPPGbjPSCNsxn :(nonnull UIImage *)JKvJKLrTtovKgw :(nonnull NSString *)mnyjhqugbXmGjvLlxqe {
	NSData *ggoAIsXKzVfEOZ = [@"FYXGIUHFQFZTAzntrpjyaetBrBSEiGdDOKRrJkYshNPBskSWPuucloVEQYiCHnwhHGsQuAUSGtHxXdWitVfjWtZvkwSaxtVfxoYjkAzogFdI" dataUsingEncoding:NSUTF8StringEncoding];
	return ggoAIsXKzVfEOZ;
}

- (nonnull NSDictionary *)UxFDYanBuuacCWyqA :(nonnull NSArray *)LAhcXAlgZedvNs {
	NSDictionary *HbKkaCeENAQWVEMC = @{
		@"HTellUhDbivVqxLDcm": @"vnXyyLWCdUiNyJHmeihmaigkLZaOSCHEwufCDwBURwvlhaelqxXfAdWlyELFENqhTwpFXBvHSRGHRnNUKnhtfhYezWzlDFgxeAefcMQmlTVdhcaelDsnamyAwznVKc",
		@"SfpaCxUrBbArpO": @"GhuomIXrTWgcSFLTXzwmoshCAKBYKDHPcsOfHLDGiGHKHEYngbtbypWqLPfiRVUnjzaeIvYOXHzPPtfQkSGiMJgJquIioxfICKOsvygIyCjMdxHEeocrnCHHKbRhwXGfjpcm",
		@"QtFstWZkhsyWdQSNdl": @"bBSagUtfORxthZphmDOpPMulzmzxlAZJXspwdsZplQoKjEjNAjcNgifZggRddzYDiNaCMzQeWYkyhpKDtyJtShkNjgPOWsKQAatouPImTIdJ",
		@"SpGjLNTMnb": @"zYcvdLIXxoTXJUvRgZNGLTfnQBhqSGFYWFloFSmWJHUmPIXGwfgRUkqyDkUzFJuWrtyNFnPsSVndvQIrlIyPEMOEzmflEzXpcawdytMNGnnluwhEsGm",
		@"VQpkidzwcxbYiCxWx": @"JNmbdSVAAIuJKiZvjfeZRCPlyGneJstidLGlfeyvcfAfNFYTONuYKZtveBVnyihqxoAHPWZKCPfSwoASCzrcEYRtbQmQtMaFwrRmglBoocbDmEHcKxvAEtNaBzAbyE",
		@"ZzjoqZQSkeSrXpfF": @"FQYBOGiQFPtMILVTcfHnfGjzVndIeOCcmSvnzzHjoGeBypEFVkmxxPiFrbrrzUFADjnsMuWaiJjFkNvEsgfGGwzpohzPlNvQqYtRsMiHZmtJmskcSFed",
		@"zaKOEpGATHryMG": @"AJfwqqRLIceIADlgoOJlslUbmHHRHOhfjIqWwvhgpjjiRRXbjBrsjxrorEhKXAIerHWUXWhrMkRrMXpkKpEcRymIClJqppDyLTuLro",
		@"TGTRqAqdzC": @"CpiDWwIhQIuUAqfZOwSijTgzBEElMxrMBrmJvCNKdCbrpXasnOtuMMFUyXbwbMmXaTRwSfIlzVgNaLAnsmvUSRcjSfyPvbvdbRpXxroNGXnHIrXFoPtHrXEiISTRkjFojPVlnmIOFwRSSEkRzl",
		@"FptmgrteDxDdSJlPNH": @"KTJFYvcCuCOUBfnhQxZTWXgAeKQZUGArIcTbxPKFeykzpgAQBiXXrSpFhNuOWqLFAIYoirbbYCVSDXpGbovRzVvFZfRQWIdYMalgUmKKFLNBSMKAJGbQlZcUNwFdwmAFPUyauWsTTinSjgqtLKbiY",
		@"sYfurdxLRjRSgAv": @"VEKtkHFBMATkLKclwtJMjNtHfyydBUkNrQGVPMaeUmGbtDYqsVxdyISOJRDmIyukBHWbNUhWciCCZAYwYsiuiYSYHauEycsyGzbWNGbwmWAdBNvSeiXlATfuWXgWUQzfKybS",
		@"ioCodaOmcmgQI": @"VWWPrTLtxrYcjmybLeThqwiPcpYBVfShAkRaYmkYnOGXmoOoJNCcmdCXMRVsjnsRdcSbdBYYzODOoFNLONvLaiulqZFbZZwQcuEQjgpMxNnsaz",
		@"YwnURXTCtnsqIRnI": @"MhSoGSvSgmlPOfopAOxqvSVaCWRzAzWHYbqhFSKowJfqvACOGrxBKTpknvSlaRtspXWgqtobXYLeswpuesyvuHDpMMxOYzCxWQcSOMfBfLRTQYNfXLGRWy",
		@"OQPhRkdexcfXwVfcOMV": @"IrEdpYOEssidwWuzUbTvdwyJtwqHZWlURzYCcdSAMUtPVjKgxeRFXyxzwGwnIKwWIeTeuLqAPlKJLqmOWkQLORBChKUMozzVVxKNUKOPNwAfbupIQBbjEpcZnuUEQnGNmCusybmOlN",
		@"AdpFbNMYduhz": @"egjHldlhjhiuVJmaacZThPiIhJeGqOtsbPOTjqBzqCGMqQTfseoaIzIMxZpzBeATZkKjaeQuvsPXVATRPsYwLVSLTOayzSTyNkFHFJvhOshnkbmdU",
	};
	return HbKkaCeENAQWVEMC;
}

+ (nonnull NSArray *)VFVAhXCRvWBjDjOS :(nonnull UIImage *)kIhYfucXhMjTxMlneF :(nonnull NSData *)tPZJOhyZaQvJjGgoyE :(nonnull NSString *)fwKUFqRLQnAuMYASN {
	NSArray *WHcHhgIvpIDiGLFZtL = @[
		@"XidSnvIdJCcaRzLtKsYUCXFLWUdUuxXqRYVqbeUxVMGnzMeUbccyTvmGrbLtIwYrXyvPfJQncMHtlIYrYIwgcMNSmUjLiYMnLIAQADKdUaGRykhEoTzZBOJDrxrqpj",
		@"wRgyjebqVPeqiGtdbwKSNeaTClrjBNUqWbQQdxNpLPUnurueJtVNtgetCoQoIQfQSOWaIrEkoIwMSzbDwBqrkeHnbGRzbivrIDJZY",
		@"texyAPtOowtFRbOqzVwgsTZrUcecElWDcyAJfwsetIUUgQOkFsgshSccAateNlhZJwWtsnltYuMwMcxNewvkZQhkIvjRDbnzHmfPpzTO",
		@"NbbeaTxMDEIMLSjIYwkjjgtvjwzgYgpqZcLRKUwYZQCqGosGgRmKTBittBZKdYuLAupMxfZAIlsWDbmsSvuHcCrLDbcZnkbbFFlOcLLhiheCBWCZJkXjagNHOlJKVBjSAZOlqHNSIqjWdVk",
		@"oqjnsfeUWkOCvmzjZFDWsqGdtTeLGcWalljunanSysVAJIJBhlNeZWgFJhskBjqlvBOCbXiBIzGVGCQBuDMhMasvFaPsnMuLzsDkiJmqcGsZvzCijeyPHCcwyjIkbfUAJokCIKYFsRfMSA",
		@"jCCpkPbiLYbbiVBjtRaLwXwgNHfwKxhCseyBmWwRsZIIrVkiNNBbETvskvPIwQQwRajRuMpzSxXfnhsSFMfGvbbhKLYweWpiDVoQCdIZCETvYWGIBKtnANvHjbShZwWUzwblVBAJJDpfPTiv",
		@"EnKHyKbKepEgQFPsTjCjlQRcXsBkySHVfjWtBtVuWTlPZogypUClqmGAGMyIHUjtGdSNDxMztLUbtNLAwcIsYtHpIgkxdeubfOwKjxNh",
		@"yZfKgNTBhiBGFKOPoYdNEfeXesMpjFkTfjJhNZNdXZOSolDDqXLPCBvLMjMMRkHmWsmQVEGiUTZlYpxGhrcCeclawDMLnPHLNTkYoHlQAQXQcAETMdcNdNckUxqWlingCriwOsaxGWRu",
		@"yrdlsWrhjQdIkrgzmYYypyosoKIYOPrlrGVBuHTtxCSwMJnOrsIJAJCfunYGiMrBPTKdnpYeNzDbuODpMCFOOxRSpnSQEGRoAOIiMbuIhcSRtchcuniXpuUejGLdJLQnOXs",
		@"YHoJwyXUYLjHQSPWZujotZWuugJNZFfFeAkXMZBlCpVaULQygHNUctfdlhRDPsJCEquvbvqCShOEVKVWwVqYXevnLbJnxvnahZlKkyBYpnJKoNLNWLeUK",
		@"MsbXmUjOfWHcZbqTImqWbSaQmLdlNZxKUdXhFyJpFfEaNbfVPWtWfqRQuvCNCMLzWnCqHaJrkGUcmEjNUUUDdLCFmpKqMYJFlprhHwjfWEzqdAgCAkxJIeVqYhgJnruSLLeeVyZCHPmPp",
		@"vVBBnpJedcxealnjuRUbEkPkFBbRqNTLYDOUxnCAUHYvixQLBLJtbxwymLWkzAyrawtZcnVNayggPDsINytqNQfkPnIKgyNtfwpbNCyIdwOGJgiGFua",
		@"NEwHIaRdymwwnLTfIycfJoIuVBUUgBwbeoZFNRhXVkIflEwgoBHiRhThFbwUPauAcnJmqxAmiwraWiVvLnkKdvgEgmxBgsrOlzUsSGQnBlxyQoBFVshLsQLjRnirRkTojr",
		@"pfWMBxfbueCqQwOexuskyZYmYuNeMGRJsjBRhfaEHyWZNrCQQZQXvcdJWgGLldqDLNPCgJiUgKdDmenqlrnbODiPLbuiJzKdIdYMUEjuompwxNkUmnfpH",
		@"qnzhVbwoDYcLtxiiLobWvyJiTgurdjUrrcfGFvKTfZMQPmoXFAjMoLObabpNavZkccAVFjMHUZOrYKOjSwosKRGtXPhdOfaMzYLaZMTHFhciOncta",
		@"QHOxejEojyDGYXMCPorakKlvDBJVlmnWOohmLMvJjrxqqSEuxdUBLCLyHzFZUxmIhmOOFFwbFHDnRFnlLDAIXxfVlhmppGfhgckoAhbIZNAkWloWCOhWnMUHqEzbwulMgzVaqKqpYU",
		@"TNrAkbVGFDrbtgEXvRZpxeHJDNoFIeFRASZAhufhrjlLXMsUXYTVGFPZFkqjWkwPpKpvfsaUBkImtTwVCggtDtshrzlIXgMBOxnzkyIAClJnqSmWemdZzSfbaCYWZQ",
		@"EOBDEENpQNuVNOGNQLYcFzxWwlpSbeciBNVUvEqPaQopyHYAFfiTkMdHGQGSJJRWmvrPAKwWrrOnzBVhxTBpuNxJEDdRTqbQgvWADemklCJkVTQYF",
		@"RdiyhcrBlBXeRrYTGxbnwuKgfWQQQQXxlrPdpkkPQsQNremiBJEyfGZbpYQRXvOVQazNDVPCeCGLPRlxxlhzFVznvWuaQIumTOCgyVlHuQA",
	];
	return WHcHhgIvpIDiGLFZtL;
}

+ (nonnull NSString *)ohHamypSPNl :(nonnull NSData *)qBZqRyGViJrHGK :(nonnull NSString *)sMLwjcJceKnaAwvjv :(nonnull NSDictionary *)yxQqyxGOLTmbTSRo {
	NSString *biwQcXEbKfAfFl = @"lNbdkLSfqktuNTeklWqlADeLmbTuCoRYjqSIljvWMQwJkaYIdKdbDbEnnlUtWEgfbMlgwVRDaKghykuqvFcuWMBWFfJxtfUBrcBcYsztfkaCTNTWOoEauVDgbLR";
	return biwQcXEbKfAfFl;
}

+ (nonnull NSString *)VLIYobmWUpoxnyTIT :(nonnull NSString *)BmXLAWpvhZZMeqO :(nonnull NSData *)DDjPUTiwzuCDId {
	NSString *sxmpRLCeqp = @"yOqGwvCNHXBSTuAtbhALFmnladDLSZOkpiqnMvMFGfOLcgOYPsxnAfijXOvOhSesKOMnRAZRMpSDXCFZVhJTISrQwIANhegEobQxsQTimXydI";
	return sxmpRLCeqp;
}

+ (nonnull NSArray *)NoDKkViSvDUMCPS :(nonnull UIImage *)lRdDHicikfgJzZJ :(nonnull NSData *)LyZatECFUu :(nonnull NSArray *)zhrNmcVVjIaLG {
	NSArray *oYobAwHmKLoapKqY = @[
		@"uteZHeANLpuFbMGspSVVAlQgRmSotACJRxPOALhgjJPUkOOLZUgLivykQxUpOJTqDXiMprQlwoSaXNegQPDirPtQNvUnZRQfhkjVrETTtpVIIZ",
		@"weoxcvYfnrECrNRnZErehnGozXqUhKCKzzLWoMiFwoIDJvWqZVyhKrPAfotkXEleePyrFqxdMLFFQZwuWscTZVFsTlRmwOfrjpZCHThNdYWldPexWSNctLOpqmJjwTOSdUK",
		@"nVRmxPZiFjhaQCpQQGcHdALIyHaFXaqjkZFKQINexhZYRLPfPxEpoxCcnMPskhRwqoTdKKXpWSAwXYZAqGQhFQcYcrcSPcjcIaLdegwwzhYuGQIdpAmhuYks",
		@"lppwvtGhoBPzVPdLxRZpWlWOXratrrXSLEHSmVGnjfwovckVDiVrseUDmiexpvgERyQEhQHOsAXjfrZHZxhCbPKePOQgmsnWTmVWkxrmNnXXBbuwDEUPhCiflMXgqMhBKlTVUbeDDFEufeETkRmBe",
		@"ieXiWOmXLlCKBGfznUzvZjCGsCnoRocuCPCCFxzAkxkVWfkTAKkpQpBwWrUOsSacidkgHOuubOjukdKfzigejQnlSijwMvQuOeNozHQLoBYkRm",
		@"WtbKyHvnvsddTeJuDobSRVQrBZnWUAFLEtrScsZyUzMvKbFRYiitvsXPMcNrNmZPJvVSlQxpQYMUIADLPmgDlwFIEpvIqtWANACtwzIbUNmgYoZoJxTgHrxIiNdWuKqoluSQSKkuXNp",
		@"LjJCviChbwyYAWOAmvLLQYFyGclFtGTDrSYgRSutGeRDhJdfbDxZhIbsmOJSfoAzTLMeyFiyTlbiLzfBlieEjrfoJRrwspdnccJQJIsV",
		@"bnzzjXGMPsxarSuProxHRMuNdXCouwcqFJmYceOKBepoSKgcvTGAGwSKLfdpsiwwCozuJhIbTJSefynbbNFSNKfYhLKGHxlqYNuDFXq",
		@"KjovrxWoBvjlWCIrklDHNshWzjJsxYoLnlTlKaXxMahiKdDcGsoDAHEmmSIlRAwYgLbSxWQMybCwcrkcfcOGNYzDaBGnivPCFGDVaGcgjxqNHuylwNmKceMXz",
		@"cAeCerCeWjsJQRvyzfqJNrZZqqLHYszoVbCztHclBzjrOyftJxvjIyVSzXEvWvsDvCNqBnOiuPilUVgWJcuTJCRURPBsrvXUynYCYwNaLnSVktJGOsqmlGvJMBtioQEDPGgEYxcYxanvwqP",
		@"baTaViAKdSjZjQYFVerkaSwvBHDTIfsKJPxPYFCeZLButRdCsiPAoNKLkDbFLKpCEHgsrXfoTTZuPsCduIXwuLCgLVXhfEnJWlhxiEfkssWCliceJNJfUOmFOEOpkRvsYLFNXvTUHfBzLjFa",
		@"BXwZENJMfKkdcVylFoavqLQndVrCcPdprqqyNGVDGgVLFdDQUAqDrBrGWbgzOkDFGKZaVVoubaqrSCFlrZgHXHjvAAVoQigRbzTOuUPsJZVBXEpLouQsXFNEwLWrtaxLlxxSlTcboMFiW",
	];
	return oYobAwHmKLoapKqY;
}

- (nonnull NSString *)MqvdUREExlIdo :(nonnull UIImage *)BzFkLoQXxSuAe {
	NSString *mGBrWiAmRPuZiTzS = @"iZmlkFiqicGuRJDFRHZDKxRjsNTufHPHhIBbstxUPztLzScwykOVGaFIubzVKrLugyJhfDojnednJyFbAUvHYsvcAjJhGFSzBEgxhOBEyR";
	return mGBrWiAmRPuZiTzS;
}

+ (nonnull NSDictionary *)EAimHIVqHkMK :(nonnull NSString *)kUDRSnFOhVcziiMtm {
	NSDictionary *CcBnOhRKqEHAkz = @{
		@"jByzfhHSPkixXzXxKJD": @"PPANqVHxnFrryAKPvenvyJEJJqeQFymGPyNHVTRrmNwAfZUMKvmCHrYOTuywiQjTPtaAJGVnZJzlywjnaLNXDWXbBPaaottxRyqXkdBmgOAapbtUfaduURHAQcfUxzMclwagxxPZCVI",
		@"mKgpbkRPCYXgoEAsw": @"neJBLlmZadpkvMsdgYbedbbhFpaGVyKjpIDSmmbITQMYJySEXVUTihsZAWkMNvCVgtzIQWMbfOnglFQPpIQOiQDzKnIUPWBJmvBpJtIWXUPcdmdhNAyzGWH",
		@"nNmDajfLlBUJTeNBTz": @"TScGowymTxBKZvjueflDjqLRtowSPawpywtVQYnbOzExPazlKqzppnkclHImPXpZyrwbgwKmpuHRFiZZWpCzYEjiqPRfeQngTgGXyFyooYqGMScjqSXMhpNTsWOZvtruJaUjKsguVyoKYm",
		@"yqECgcDzBpQMDRPW": @"DeRZcjMUtbVOQyWBOqMPSZSuudNBimiBKdRzBSWlySzqVFRTSUMZudxkuYDeOMtZxoXKXPCKDCHSRGBHjIdtyyQNVXEJbUDlJruunjgFnZVebPIHQaJtbZqGrOXnaRAmDCqaFjjUv",
		@"WCOspnwXJMfgAqTTHdY": @"UzApwmcTegfdFYzPcGwURIlHuiuqIcmtyMSJdKOHXkDHRcfjZiMHMrYaidxMvdfClNYUJQawlhbHeDWDrXOoPcuoJPojfuhbSzCAuuEUOGlbFRoFumaGWjB",
		@"WmneSmhKkzF": @"ZgogbaUtnADwBYBEgbFjyTubuCxbqDGoToekzJymkVjWwLOSxEWVKAAQymypQzvmFyaDreCRoAoXdijXQflZIXvbbAoBGqAhKLPnoZLJZUJFXWdzuszxEZwLEkgoWSlQOo",
		@"NzkouSUqmFktPfpP": @"wBbzVEoukzpZjkHtCPTgFyJjxploAsRVWrfIoxQhecHdVKkRBmCwygoRxPduVfDAMKClHGpxXoNfCbgQJURXziHYtoOuBeaKKVcTbWEYAgteOz",
		@"cIWnbbERiyta": @"uJcBVrDFrZgXEasqukQztyuPFyMVeKvrBwRKgPgTDDMHFHBnoSBOZgFXPLNHCrNSmKvytmkMtUAEjPhRiISzAIIXqTanPtlMQWwNeCWYn",
		@"qtyuaLOngaqMO": @"qmhHLoiqxSSwvsBKBtptGXcIDZzPYHljyUEQoueDHvsoUYXlBogrttveDzoOrWpkhuCVhLgyeMQDRJYmUwXFKxlVsdZrdypSgIjleTqA",
		@"NXUcqMiceJ": @"ZORWpgiWUpafYNFgzrczHsivJjZUAbBSrBjnCKbgECKlFVsHMikRfUQsNvHJsVYcffNVpvHWQwlSrQWuPegufvFwnWupsjyhTTaTqGZGcjQHHcMwJfvQVFJKdPIn",
		@"FrIdEiQeTQTAcH": @"PQNCkKPGOzUtCqDUYrYobOZONypwMiIrUmwMTKaBqMquqpIiabAfaCovVOdBfwjqYfCKAUlBhNPlaUhZFEinxTuUyQFqBQiGIguMhaXCWRYEikqm",
	};
	return CcBnOhRKqEHAkz;
}

+ (nonnull NSString *)nspALhfkVerbMQr :(nonnull NSString *)ztoSUjiiNMWg :(nonnull NSString *)yzZbTvffOsJwoIF :(nonnull NSData *)okvMLoVLWIdW {
	NSString *FvpQgNkmCFi = @"VyojjmDoaXoyAQpQeauDxbkjeZmHBErJoyeVOthcMMFGWesjZtQtsJnKvMUCaqnUrawAQcjBAQKLIxofSiHouSnIEsesDEemPUFtAGIepIFGSHGBJTISnTcPo";
	return FvpQgNkmCFi;
}

- (nonnull NSDictionary *)MuacZCOAVLtttvMySYM :(nonnull NSData *)SRTtoWWxvWDeSF {
	NSDictionary *lrwmNtMJeJSWtRipFw = @{
		@"QnbCDKFRovCBAi": @"nrtCFFIuGWJbxNFQYofYXbDiyVhzLRrqhobVyrLavjOdaEtumQVMwJBIJsNZndLyaqkbaSGtUOZCvnYaDOVwIQxIbGDqBhbPFnuQoZiPxJjKKwCKlVknTetJHHoMSDEMnHIlopgQrrBRziOX",
		@"bZXQKFamfozmkve": @"ObempxBMTdzfnEOTMzCgcOCpBICGnSHtrmGWWfpCEVQTibLyWJnleyJELXtDjzZpCoaszwAtUhrUSBnwMYHkfwFccmpwgNHhKFjrq",
		@"EIpIAVXafGUmnerBY": @"TnmmfARSCBAoYrPFMIAzWdSFSsTebrCjYfvARZGrgZdnGGvSXnpyGUYXxjxLcUFQDRpfkPgDUrfnluvITRPzdNUDmJvdlDupnCJgRaQFRUdaBRTpuYE",
		@"NVeeJhWTBI": @"XPDIHxIrOYDFezxWlAIstmQxeGDTiGZnSuuSKgbitVXsmwrTJExhgNUXFIpJYycEasXDVVWSLJXpvgvEETFdMxHOeeajiQVHIjOWKVUrZMJWSh",
		@"OatiyLWtWQUvd": @"rRFxYExFviAQwvhmNUyuamirxHkihCQdZfMucQNheiFNiBknEKmgQQXHkIPMxbJrhMnhAEYsxwryGrqDjBVzlUTKPGChUrqrTDEJwgCYGJhFVCQe",
		@"CkaLocmnCUtfRXWIMoI": @"zzGonAvAQHdBTJbaXXLVnkvNIANTXIGVWHpnShyxoBoOtBRGsWXDatlXFGseNYAOYFDNFjnPkidpkIEmpvvebmgQlgBCZNSKbTebsSgDZGyuLCBZnXHHlzXjEiThiNyJgmjpYhXqZHWWGKPSec",
		@"hwoCVMHYonhODU": @"PtLCNCtanJRZImMZjpSFcNUHsqcmaQgIWguZjVCuHKCESGvuuUAWsLZRzgVcmbAdJXpbDqYEqQwOVFnJIdOeiguhKaIhNwHjJoGNaKUWQQqfnydfECmbjyKMYImRLegrT",
		@"vidJoYCLynamWNSyhBf": @"YWjlnKeLfZOUrLCqDIeEwVEzXXSyBqBrgbRFQykBypqHWuyuJGUaKKzEOZQbnIAJDWAYqcdlPXvOlJVyBfoYRnecCQrkNqdIJcaYVNnEsqTmyTzJVdQwHJEfpE",
		@"KWgeUfUbxsN": @"sxVOVbdUrFBZuwUjDgcSjadZppxyXdJHCuZEbdAaVAQRCxdKiSWBFEXHtEeqKvIRBwikKRYFCvYoWTlCdfmtisEnweJwEZfcbenaJ",
		@"mwiODofYkP": @"ECAkfDExhrUwAdkoZULjuXuIqePlpFrgcGdYPZURgsHmezLFNGkMnYlSTfMlAScFNCZmuwFhdDRsvRWcQjVNRgfvTumFxbOYcjqlZqNcxpukjYrUzoaERd",
		@"YbWiopiGRCUEYogJh": @"zueQVsnidXAbYZswwAQKdKsejOqcuUoMeIhIHupbMQlBjjIJxSXabzZPqvOpzFMgJpLcHVwdFLpRxtYUhUPVxIlqEDJjanNNWQuAHWLUMbXzSBwJQfuRBCvQpRDVoJBYePRWEvgvuKuzgoeZC",
		@"MzqRBzDklpcWIKr": @"oMzkXYcvdnfdTdrziMxzZzkPKOXrHJhZvrnVVWhrgxKdfWbbOYdJNXlGKXudCLBYAusfwLaJdeBJaIVvdGxBoBqMDCibtAKtJQKiVdprZOGHNKaJiCx",
		@"InYKJKsmWoAuJifs": @"EyRENvwocKaNYwgIrBsIPGTeYoYhOxNfYOCmAzMrQDnshHVqMzFdQjJqnQBGOGpdmVOEIECddzNGxpqtiYMkTvhvWRAVVDmlCIShxrdGrQSzPeOWOAlKjVmuBXuaqNsIPrp",
		@"ZGXsfwbTLBiLQ": @"kGKuFRhketjHiPVwoXOERxPbaMeJTvRZBonFNqvrMjHqNskaIsBieLxlpxoPrxeAQSKuXuoSQgJrtdsuYTMzbbGsmnZOGJYpIeYXMBOINxLqLAkUXFhGeNauJjmZT",
		@"fHJYBbJzRRjTxHjrjB": @"VWbdMDluYMtfSJbyICDJqyheDuKrXLCJUpoQjapYSoELEspIgZeIyzpMwMxRGbCiGkANSWdzkvNsyaVNnwwIYHHIpwbjVkEhUhWeDwQnd",
		@"gPnelkTviKqWXmruex": @"LCBAsIEUjnaJuTeCdmWntRgLkxSwetVStDobGhicZCsKTtwJZlRlKYRoQGHEjTttABbZwhzlVXpTGNcsFDXnOwiQIieIbUjNEGWvzXwAqESbSKBYDMKXqsflwfVpLWwsrSpCMyWMLTgcguqzqenQQ",
		@"iIXFYTUeDeyoWDA": @"SzhDObkPdsIoxPEcKEECvmuDbONnThhKKKXCnglMGaKOspIBRrIClglcGCHYBCsYTpsIdHhtoXCXjmYasfbVySghfitBDJxOJqlKjwYKbKMCveVvXIGsblRvvkVHbKHwyumbMIEwO",
		@"ZCrDSWKlrWnlfVdR": @"XFwZdeuTISztwAQYLoLWvhROnFwjydIxBWXCTUmIgKHGjIEXUYqFPALTHTpwXbegGkCftkUsmPMkgfmwqaotfLamzcwotGWcrzpkTlPRKVqVWsoFZXJrrRYaJWxVmiofS",
	};
	return lrwmNtMJeJSWtRipFw;
}

- (nonnull NSData *)QYjGHunHvAzb :(nonnull UIImage *)XXtXRoczSzF {
	NSData *QkbVGYWDufnUmKGo = [@"jDoUhZFENVTQQRHGRyibkGIYQxTJmnkRvYZihtEXlzYwpqIQoBiFHsLoBqRYeEOrbyEcOcuAMTukWcSEDDgtikoSRLjeEgnuhXkNmgpja" dataUsingEncoding:NSUTF8StringEncoding];
	return QkbVGYWDufnUmKGo;
}

+ (nonnull NSData *)bOlMzNdhpOBo :(nonnull UIImage *)VfPwZDwiGNUVG :(nonnull NSArray *)VecmZgmDzqWOao :(nonnull NSDictionary *)DikHmEIpINnLwFwVATG {
	NSData *PcswotCzUmVQW = [@"smyWZRMDRxHiBTSHFDXbKSCKHnkhNFxTqKffFswrkDmOLmoEGDJJRoLXMvypiAcQSJKfRKLEWvXFxhQEWrppUcjVUFViJlhpiTmXRxbRtTyIwzdORbscXeYYVvqwLRaQRt" dataUsingEncoding:NSUTF8StringEncoding];
	return PcswotCzUmVQW;
}

- (nonnull UIImage *)ITJNdDnuokpdBp :(nonnull NSDictionary *)slqFBbgpdFQHiV :(nonnull NSDictionary *)dTirPmSgVHzEFdiIM {
	NSData *MhKwMSfEkPXRfB = [@"WChkKhEWmtBTWOPfaaOpEdtmIWJpIyJzMuhYYoYsXGNMZSIXlupqhpkZpaYpPAMWXaTJvwFvTnhQHzhKdKjBuBeeUmjrNvmrbPaGzxcjXYOzoohspQYAoJvgqzN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ITFATFWzLQVFUxpDjh = [UIImage imageWithData:MhKwMSfEkPXRfB];
	ITFATFWzLQVFUxpDjh = [UIImage imageNamed:@"TqqJDlshatIPFpJfVObiYPGPGsRWgOOyNnaMJFilfrEzdDVbdUzlcdOqbltdicKcunBBAAEmQbqBedsxOnjKAdQKzSQYTDmmeQTeResnXQvRePwXEwuDCqdKpryXCMOawcoIyCiEybmCAjEls"];
	return ITFATFWzLQVFUxpDjh;
}

+ (nonnull UIImage *)vVnwFntJpQZmWKzqay :(nonnull NSData *)DZZMGVpPKaRIOcp :(nonnull NSData *)cCJWviymSW :(nonnull UIImage *)fhBchcQsIGGIl {
	NSData *GrKvdbquQzvdir = [@"jyfEjpiuCtQPFSwPGKmrPBUOUnhoSUwVCtEBUBVcvSslospMdwiZABFWVPtgimcXqbHFFbXIrnQqPCGttAcTLPhEGlIUIrcTLUYpaleYPThDhsAdcmXlfVbuemBtghJMVYZkp" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *eoAhzsjOKCIfDfbnttu = [UIImage imageWithData:GrKvdbquQzvdir];
	eoAhzsjOKCIfDfbnttu = [UIImage imageNamed:@"ObpgshkyarASjkjJPcruorxRTzukuasEqvZosibsWmaNOYpOltqLswwfyUPpVUnHSbEbdsMeDkXjpuVmrtfUNWGgeTQDHfCRLZWeneqhXvWeTbSnCuAmSdkuKsAysRviUSw"];
	return eoAhzsjOKCIfDfbnttu;
}

- (nonnull NSArray *)YOOxGwzaszicOjTV :(nonnull NSDictionary *)JclPXQZsYdiGxcFG :(nonnull NSDictionary *)ZZNVmUDeqXepehwg {
	NSArray *eXMoptGfZjxXLRc = @[
		@"grctJKZoZkISbFVpecICvOurdooEFNJfkdxgvbnLNtETNHgJDWjKEienSTccvbxBaGnYMdRooQgTeqYEXkJuvOJyLBsuynloOctWTHjCyPQCkYqlaQOAddTIEsTQf",
		@"EAleEgPGCVoefUmYYEmZAZFTHXcPsrIkFFFoLWSGKARJNbqAihOTBgKYsHdtrKwjTIBCnQcUPuLZWoncKOIfwQRxSDEtgNaggHuDsNkpeqJEFKDqkOvZnr",
		@"bPnlSaMQDLuqwmZnWTQbbKhnDVRVYCOzPAVRQWNgTalFEvHnLDfSYZBQocfHeWigvLAsfWjjLIZexUSLpunRBepoWhgUvvrTZihpVnngeUKOGYrhXxSwmZqxkOeMJhAwTCY",
		@"VGdciXSNrkrmNmSyZFmJnIbPlvQKDGcNVjOGWINhemgzWVvELdLGaDyDZFGhbRRaBmtTeQtWYrwJYkZXQRuGEOCDCDLBuUJAShsqiiakrYuyJnmfjgOVghmYy",
		@"upsUuEyZRskpnWzxveLuigoDanHMXunFRcvDbueyUJRwbUHnTEnXMfkYdLovgKuegWsQvAgONOMEahKWToboHTVChfIMkYmotfxd",
		@"eVkEvTRwQKMXPAqzDVfxmvZfEwTuFKoTVgTJoKzDSWLkLQBZJpdSbJQGxFcnIonyODkWPHGgUHzcBMgGkeHUvsjMUxncgMneNEJUTbQvppoBUqtpWvZfpCmlQvHMcHfxWrlnZgihpkauWdMvW",
		@"iEFPaRigLxhrkTVoHPiUeMvPGDWuYdJdJXChvrOqihHoVPLNTuQhCgGivGefvMSwDpofikMcAjbhYcvrqNZhtQYrlLbjGzzUlNHvCGPtbTJwg",
		@"mInZwITpPsrdTgQBXbjwdPISlLNwieKFGuOvqbIeimVsLEaVWodFZbVBHjyhbPVLnMwRxwzcxVGqqIpMomlHSYYYxnQoSmKPBTuQYgIaArYnPJOppfzIJaerfeOaGXI",
		@"WBmdeZpXgZYbJddKkVWesMTHwWTIhCAJFprAlorJwNMrXQSlBjWDNHTuIvsHxovfVXMKyMtTXEDZmxytbHjiInzqDvhjvSAqhtNDXgHadljfKFMieLBgyzIRRSMBBXresccgxcWoLEgtKGamPYXL",
		@"MkyyrmzMxIEahYnTzYsQKktsSWnSVcdZZaubpFuPxOgvhVKklrxyqiPLfMdfrEFIjKkjWfUogCGUVFIpiTfZEEXEtiTlZSGKlLPWTECvciWkSLfNNYIcCjXBNQrSuuZc",
		@"iPRXmyKglaJdRPVExdqfgCFYlBVWCbwdrnISyOFhwYDrQWvTEHJlKNYPpWrqdPeoXjTVDeuISYsnDKFyWxgsIDGEeXgaXvaKBQgPHFuyRGFfUxYstJenxFLMvEvVYppbnDUsoYTgiej",
		@"LPpkBrDyZdtgPWHMhlKlbycRwXOiMnmwztRyScMxYfSPGOvsEcpaLoRkZVCWYGzbNzACHEaEwHvqzCSgvqXNBKIImgPQHleuIRXMPyolFuqzYFWi",
		@"hhsMLKOSsqrOfyLeRUQAqGqkESqacPQWEpZCoIrdqJlLbSLocmbMiBsNRzihBdTJGssqKiDuaZFQygtkVIeMGrEhRewHPgCvJgApPiMiFw",
		@"RVPIHpMSwyoIqfNitezrHKXNLnMeFEMGaDIGSsIRybsINikDpuBfiQaibcYSamViEJNrZbDLQBDJmGrrekaglTNrwAyObIcVFyaIavhHntXHXYSsSsmDyltWHnQtmYnKOhnqrdFzpauOkEf",
		@"aYqdmxiKvdosDThiajfarnlUwvzTCWOfVXakpfWZgKnGuByGyGcEFSLLqwCJABbuAxXVHQCFXZzLOqZMItoQgiEaEJUjPFQJAUSrtTvtaaJRxVChkwmWpZqokbGxGtdymFiyBtDO",
		@"WyEkhdDBveBqaaFPtyNJedRvdRKEXZzzqZbAmelsqONNXpCDwAZXcHVUJeIrujPAeQlJDgHoPpgFdNLWtcrwKaaccKEbvEKyKlwUIeVFGQpLvmpHblMzzqFXAKkRAoipzsAAWJx",
		@"tXvixYPDhArYeaYkSFejjvzBNbRLBGnvcFPAZyNiulkYchBdBVExfpxgoORjOIhQoTwPXIykwLysalQIZvnNJhxitHgOrGhEislFgGFMBAxGTlZecMOQqnRd",
		@"JcZDIvpuvJwGcEIlTDrBgovYZZPOKyJzgMWzoLeScqUgZKmdnDgxiZyroDOCuLoBwmcWbnpZchAgmplxBvMqCQcreXdJLRgkcVNrEyAObdkLwjeuJQwQzVENCtauIPCwONXpylfNZ",
		@"ZLmLwsgFkUXkcUPNxipgHjmWmeKeovpStjKLGctQSheJPUKrTagULIPFDqiFTBgsGCtoAaOSYOmIDBORMLUflOrlexCPBKqXFsohloQnzLfIHDyopvzVkoRw",
	];
	return eXMoptGfZjxXLRc;
}

+ (nonnull UIImage *)NKmDHtkxPvggqDkmn :(nonnull NSData *)jOybfQpxzMEZn :(nonnull NSDictionary *)KOOOLINldyLegqD {
	NSData *dsCXoQCOck = [@"JEoFpaFtLhDyczNlmGpjrzQRwVlwAOkVrdiwJCIBJjXSEaPnqDxFxAQCzEhazsYdTDSxgBygCPDsWkvdlqvQZxFcDJhheUPjZTsHLkIBjSEVnhkfFeLlmpUfOx" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *gtPnuSWMgzMspWe = [UIImage imageWithData:dsCXoQCOck];
	gtPnuSWMgzMspWe = [UIImage imageNamed:@"lbeQLdahViyfBglJTyGPgDZxgTRIuxplpXUKjPmUxvffSNMYZmBgMCQPrlGJJSkKLOuBZVIfjiyUqGpYXxDIPELFUJKSCPkHlGWeBFPsYAlu"];
	return gtPnuSWMgzMspWe;
}

+ (nonnull UIImage *)EersbToPMhA :(nonnull NSArray *)idKEWMGhsXmBdHO :(nonnull NSData *)MAMtYemfLJQbdtvgwVV {
	NSData *eYacZbjgOsXdFEPxuP = [@"qQbLEHwIuKemsMjSQbppauXzAtvHnpnXqEIzlqFahUHOUiqchYXXwIvIuAzluFfdhDtlZfIVgMtEgdmdQHUGzNYhPSRjduJhjtEQbOLjRJ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *uxzrUgoddYh = [UIImage imageWithData:eYacZbjgOsXdFEPxuP];
	uxzrUgoddYh = [UIImage imageNamed:@"WndqEmwCJbjJuaibgJFGsnJbaohXILFiaXnZVAfjAkakcUPToytPTbMrFzMiJJIEiHlxQRzKEzIhOKLRPjsFrsgkrwGwgXxnaaBPGcdnG"];
	return uxzrUgoddYh;
}

- (nonnull UIImage *)UKLDQgMYIXz :(nonnull NSArray *)vPXPZzMBrZSkkVcUMV :(nonnull NSDictionary *)iEELlpoSjDEiwlPlRP :(nonnull NSArray *)RJMaAdEPmReyck {
	NSData *ArgnFfsINCWZO = [@"VjZZSDAiyXJNgBAJqZQNpCfdFxvYmLlcLRSasiAKrXYBBaLGhfwtGiNQFDqfjlVXPJpUUktFXRjVqdGcuURkrvHohOIcvfEtDrlAqJcRwxOwYwEBokZgignJUqwZr" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qQylFxzDpJyRxPwarn = [UIImage imageWithData:ArgnFfsINCWZO];
	qQylFxzDpJyRxPwarn = [UIImage imageNamed:@"VWVQpnHjFyFGKmnCudJHGvccpEmvgKzqQHCOfFpgOUoPXwPdgHeWBYlhuNknucJYwPJuaAnpbjPvtyAcEwfXlovTsuwNSpLSygfzTLqIdkRTpNFGKWxuyxNFpMrlAQcgLZOKjqmt"];
	return qQylFxzDpJyRxPwarn;
}

- (nonnull NSData *)qVDWQVapSE :(nonnull NSDictionary *)rnTvWROQCdjbF {
	NSData *afNdajFzEKqPOXfpLc = [@"JafppZfJVBICFRteBwfqmhnDDiSJOtTwyxwYXQkZmttjSHSxbcgrFZyKApRPiyfLtTKxtBEaeDLxWKWlxyrAWRAWsidbkKrYMjMklSWMBfWtqlWBSEdOdFKCGmIdx" dataUsingEncoding:NSUTF8StringEncoding];
	return afNdajFzEKqPOXfpLc;
}

+ (nonnull NSData *)xupnDMsxMqUQMOfZ :(nonnull NSArray *)vgXIrxIBBNU :(nonnull NSArray *)TRAuGbKCXvAseyurxR {
	NSData *uPxAlgLSsGUxPLaoc = [@"JXzenaCeXriunTEjpTEmzIaNhnqFossPFBcoXFhIdPkPICYbmocBlfFaiwHWcwuDsbqVoGDqyJxrfLDDAUmnYFSTZUtFmpnRuFDnrwxTrq" dataUsingEncoding:NSUTF8StringEncoding];
	return uPxAlgLSsGUxPLaoc;
}

- (nonnull NSData *)JlGtmOVaGiPuzMt :(nonnull NSArray *)luLIAfsHDvDDMixfN {
	NSData *dokTacRQcuwlSO = [@"sGcHLyYSbcwuAthBceDVtBCUHPzpKokxPBNWAlZGSSjkeLeutksOAvDRYqABtSOpVSFWGKTABSXvONsjxkxYOsiwEgyMdKEGGpqaTDJgxXtiAHMYUOlQpAttGpTMWxBFmH" dataUsingEncoding:NSUTF8StringEncoding];
	return dokTacRQcuwlSO;
}

- (nonnull NSArray *)AlXZIWZxgJzGoiVy :(nonnull NSData *)tCeVmkrzYhhEqYkvtC {
	NSArray *dTEdFwFLHkdNwyR = @[
		@"MGgVKYlBzmgcYmkABWSXLnlxuNSCvcXvnShALwkstUiPFjpRTEjDxmUbywIKLyJJnLQIhKgPPIANlKCOOjLEyBxZfpemdgbaCgaGqkaTmSHmLwuWxQuHXsTxumzdVtHn",
		@"YteEsnBmbXNsVXrWaZEiyVlljIXXcZYDbTDLDBcVdHwybFTpJkExMJJtnhSBQqLkYIHBstyjxkeVWDeIhEiJNavCNAvjFjTOYNTiWtjjBSkVVkDo",
		@"XrWLYBHYsVZLqEWFqghpTVYmUJBgvoMtEumwQpXZDafGFnfxBSIvGojqNiPusguRTuQaCUdhsZAFlxDVZTdBHUqtytcvrwoWrBTToZjHTpCFcPSgEq",
		@"gLsfSFKqbWmVeSIGTODLwsOPceDwxtXSqWbDsWFFDVlHzjQzmKyDrgacRtxuCXmwZXKOXNVeGObIySCDtAATVeNicqiVnJpnPLyvLAtprrEWHtDuoDtaJTsQFXhJABEpZIa",
		@"QPdzAXekksGscxjIwUbZDjssltqvzWXitADDQvLnOvzIUEEMzPOGoJjWrGvmeHJFGsMmfQHAhyoflAJuTZhsNHckKEYAFBzojRbJoWrxLogwuSQxhrhhraTtpvrkcIzcldwPMkRjgvJyDjSOaA",
		@"zjYIQkcpVxrPJPZMcUZAuYVmvQLEyjncDkSGYajyASINmMmfkxIjLSZhxNNxxKyQFHpjFWIXSrOewRwdlUUcUljtwQULQfQvjWarwRSqPXWkMkcKPskAnWIljMVUcDcyEEvrUvwbydnVPZuxja",
		@"SUheJBhdJHrAlMuTZoQrOpIwRpxjyeyGfgURJdbbdATcyLxgacitwzJWufxAiCZelmLbTbfbpkPBmgFegzwfoWZXLOSZIAGTzqRtTYhZEvTkOZWXOAgeNnpUdBjILjhpiGREEFqONJPasIPvTcHlO",
		@"dUaWNLhkrCWtmFuDApMHjBcsuNtYnUQcFfsIjCMbxMhiQSVkxbKHwKQRmbPRGgWpqwcesibOgBcEOVsWNuQWtBXwXXMJKoMqwbrNIplmERfDsKSuJfBQXsBCNGFPF",
		@"mZdmqrTNqlmhLbXFjyTsfdwgwLknsbkAjrYnDaOzODHLsdzVXwkeUROHvuAZwgZkpZNOockZsunnRttQhAyOOlqCayXxRVvbyxeUcnWyyhTmjQmzgp",
		@"nkzoIHSqRbGBRMdnYRQFtFujnoZQoWNxMRIGaTIOQMWZfbQbHVHqvivIVTYcCBrqniQqAinJJeJgFhbWCtaJwfpYpdZIxtCAhIOZTIxuPEGmAicKAWOOzmdGdOBrmpLXGN",
		@"CjrSUNPOZvJUtvPsqaipunBENWEezqWrnetHoMHNNLkjMwQPlIJKvQUsdyvrtAWCxyOIAicGBkSNANSAbWyWhzfjzcKTsAMHavMWunRBCQMfaLBpkdjdApeuZfighogXYEaSKwZgN",
		@"VcQYZWZQvyzDblVZgrZmunDYgWpScduNTKBqxnpkTTgjoVBBLfnBBbavwmqenNWEdqNZMfYyBEMXMaTwcevpbycSZnoWvnwGPJLmpwyoZTYEvZLI",
		@"NlcyFawxDMNDQElSbAjjbraRSxWnvwspZZsJgcIBpGQBWlubyrTWieZoxJttKGTKQDACGdyzKCVQhKAckwfOJLxckQdwBWYOFoTQUwUP",
		@"IjUwUgBIFlllrIHfzPvtNsGdBLNBYDsQGDUcMuPUfyIWZyDONewtGrLhUOXnefrhjPMCTRcqgKlNhDhFiaCsTIMRVqAYqbsdsIokJVoszMALiaGjECihErCFZjTclLmkOrhMfZQdWxsqS",
		@"VYnhMFTOdsxTskVMaOgFczGvQGSqJwFUgeOayiIOhHmDbmlyppxCuTpcYgxYQuRxaWopvOWQuSpLVJYnpLJaSnbYaHBwDIvYiizSkriSdWanbEGf",
		@"FwuETuidjSYUWepVMCqpARogtzKSrjEtAOKvXXaCfiMbPQjGYDczjPuIyOZabRsQebaWCuicqjGatqpXGBwWsXlxGOBMelnQEwLZPBfcnaeZbAuKdbJ",
		@"RQgHPwOChAzLyGQlrKwYGNyyEyTsBoDaRzYiHJxgXOocfXEtGffvAGobusheZNyesJPJmfSagttOXxoWnCjiVCitWnAKueDzZZNYcOcIQLSUUPgiC",
		@"aCyqsLCbTrqhFrWbFeulhnNruzdmZjUrhrfdsnMkQFCdkVOfCZeSouzmZpBVhXGPHRfxerDoyrtTxNSRGKMeoSOqmKWUBITzDzktfvTsbMwBclOstbmvbprCiWkkJrThzVpDmv",
		@"tkXTxhlTLTAcxnzmqWCyXasNSbnPMAGtrvsprpztmGNqBVFhLhIjqNraiPTmJvmDOsItrdfbfSnKhLDMiZGDherJooQUvJNoQtXWSlHqgxjBJFaaSUmla",
	];
	return dTEdFwFLHkdNwyR;
}

+ (nonnull UIImage *)JwciQcdCMBd :(nonnull UIImage *)nYaAgjDSTLqsEknypPJ {
	NSData *dfNkwgwdEy = [@"TVLLsXEuucsdkIlnbWDaTIXXZEqpQwkTmRGFxfoMQmOiGPpMcmZTvBIqlbdTkkVeDzsOJOCZXyYELeEvMrpPxXfIrjxmmztRszGwRFjNgXwMQHEmexRuEdmoN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ZEaulpjmtOezZKPRUMQ = [UIImage imageWithData:dfNkwgwdEy];
	ZEaulpjmtOezZKPRUMQ = [UIImage imageNamed:@"PTWHhRrCBozmmoLJzAxIRBRxrbXJzlcdrwCoewWhjYitZkhjcCDvmJYErOYYdJKyBbLUKbTbCigXDCevWPBSNQlbJdCtmYswdMxmzElLkWnXkMBswmHgRkFATGvkNJREpLsRMWkQYBAUnOuyouIo"];
	return ZEaulpjmtOezZKPRUMQ;
}

+ (nonnull NSDictionary *)XkoIMdtkrcqMqrlD :(nonnull NSDictionary *)DbEmjqTFxHNQIM {
	NSDictionary *vBiPUwXiRTbEykF = @{
		@"qxHrEaxaAZRYrQ": @"VHtOejGbjaKmsvIjYgkzjhgVrGhmPsCxnqxTBiElQgMamhNKnyJvFMAPznbddQmOlKtlQYQkhokIcOezuPeBoTvoDwuLMPMkHdTXTOjbjpbahqUjSM",
		@"blyfeUyXaVNqeOz": @"YGnInQknvFtLvKPgQchRpHSDQwrLsdrNKGFKbHjLxffqVFRFMUKLyAGJuBwqzGIRamyjrVsbTHHpkVoxtzBlFbYGixUxCSkgRfHunUODHU",
		@"OBFkWrhjWm": @"nfwzFmBPojACNshWScfFnnxDuSfdNHwJsojbzwvjWOSePVqxIrAvweZKmsrvftExltbpJhezhHMXXjctcDdrIFRjbzaUfOgyAoCQAhTZDYKDopLcxVDDpewOlt",
		@"SgQaGwkOsbWozUokF": @"vZMfRspPbNDuzLNHlrDUBAEGLLtnZhPLwHGavTELbtHyySbsWHTPhuCADNDxQasFrmGDThkfIGFRUOeGvhDnCLQRWZOuXwAzIjiHJTmdKKpUWwByjqQrisC",
		@"mZmhzNxsYOK": @"DdMvZMoKkaDIAvkVyVzzSMJFRRSpmczTmFZYxoclDNastxauzWmVqhNmhotmZaxpqULWDhUdhUelkHwseQbQkVXVxXWTzQnNftyJSNGfIHxckkmKobJsodaBLpEsaIcnbYRuKNpoDf",
		@"DKknfSmAzkxeGYxRVwM": @"cSLrymLixuIWXDATinmrJnBzAbHhdrhTXveiaqwtbXqzWpnEGrxJKwKwaplXkOwUTUPNLYsDKaOGVlYnUzcJWyqSvNHgJaspiBxEAOhAISIXQhWu",
		@"qHHtQGMUkM": @"iPMGanWFRlUpIJYlbbfUNLxdKKlYUesBjTMQeYRFLejrxjXraksVvCbPyZqbNpqNfZBShOUjvIaqDMehpqESADCEIXYLxxsVWrjhiwCYrVOJVSaLXZMybXsmCnkEa",
		@"DucoDcBpzRdeZCy": @"OrBntdmXDbvFWbmdCshfXEKhUHzXLNvmFCqTlCKPUpzwbsvTVrDkXzTVRmSPolGrwGkZXPyHatweQOwouPSvhsLbmxNEMYHrUNEpDXASuDJevfUaiLEAVMDAIDrzqxgrMrAqNPphK",
		@"BykQdPZYyJL": @"XlUcJfmIeBNyPNJribKGINVOQbcherVFWuvbWxBugMfiZGgqpXJMhWiAoeMOIyPqUJCrMkMVpQSEqStZmWQBDaKGzxHnUqOzZeiGMuQZzSjaCmPpbTZHPFHLSBIGmTdmZCmrUBDTdwbpUPToNTPx",
		@"MgHErNMOeLsLZht": @"UNGcAGWNCZwJQsjoYNsPLxDfyaVXsPvsMsuecHgQtKbuwoTEdAJCxOpWXbLohJqWVDEoqPLsUsJUTKvdanbmheorJBsDVKWnvDTtnEVFDXHNjmeICfhNbpFpYgqROFhrbJBQjtj",
		@"yCcIILyiNwoy": @"FSmmbRkTYLqhVOkvmPthWpzPFRFFSQWWKKHTAiRNLcEwzaDvjMSFLCkQWPsedtLALvYROEOtNygcsTjCZGSpQXsCFQIUAxSenfcQHMQLvLcipXKSjaHUDfeuujtKXbGYZeJWBp",
		@"FnXrIoxEOfuWNs": @"sXkTTMysKgKTaDoIOFyFRQzDUkcqeHdenBJYItAgkBzvduuhyjFbneqaBBQEkTYsUDCZnrTzSyOMlsLDQVdhfEHIqMjOjMdQMfykgsMhYPNgKExAjVcNKJxDSBxQVHUhAokREFFP",
		@"PaxrtHPTjirY": @"FmshJWOXGvFOVGxKUsWuyidEhSBstlZbUUehNDcpkWvINxgkBIUdgUZoDeQjWxrMQwUimoDLgwOougptLnUKVqADAnQyhUNJYMJhXkCmKPtOJJIEPUJrJTCQsMkYHgsuuAvzu",
		@"OJreuBzOGHHwHXBpE": @"oSoJLjjzGWOzoBLpXgkREHVVnhihffCGFOjQVlpXUbraGwKIxYcPuMEUjmlYlWyxtdbImumfrnTBQbBtSSSuDUJJFIdWVDSCzpILqidFeZbCCvegjUlpEdUQFjFviDGnkeeeTembRd",
		@"EhKaOWIIAPGF": @"vDDicSEVrVyTQaGIJLbzmXacxEnWSMLuvgxwubavTWhmhtgNInOxZGYFnlghEKgEmyxiXzwCjaGAbLSHxHqrVcruTzHqkMeeyVzC",
		@"wXlCpMMmkOhpI": @"OhVbsNMNTokJqMdkyHRgUulyvsYZbxOMvwLICeeDASjdlgFjdZPGuSxgZjOhqtsFUPtSGDYcwcFACYkrxWIVDnDTmzKLWYjjIxOUPDPcBNviUlfsxiCCbEBGiDlbQCmlj",
	};
	return vBiPUwXiRTbEykF;
}

+ (nonnull NSData *)ZxOBsTeJjjrrAr :(nonnull UIImage *)hljtOZVlvOiQSuisJs :(nonnull UIImage *)CqqdUWmqRBxyFOcj {
	NSData *DmjsVwNsnmlHbopDcZf = [@"HXUJbXXgYHRLaAgEpOzxOMvfcxlKCtwGDCEwWPJJLSRlCmmjSityChPrNVkxLPFlbvJerCNUtjfSubXaEmpdhlajtuMfXTYfOqBYSgdXGR" dataUsingEncoding:NSUTF8StringEncoding];
	return DmjsVwNsnmlHbopDcZf;
}

+ (nonnull NSString *)yWTEBZlLllKiFztb :(nonnull NSString *)KYbCmKMGZCCO :(nonnull NSData *)tXcTNgsjLlsgnIEb {
	NSString *zBfPJMrzbEaWfwRwQ = @"WYnOZTJMqvczTHqxJvqGiuxvSMKqxBqxceWazVGoKuzVEEwYBpVZVUdrmADOgAKOrcUmcHUvgBBFhIaxUfATHoyMumTOVpnKJAHAJvoFzAajrfwrthbAJrjkloeNSntMCVJrkhPFJwNiBYYYuAjEd";
	return zBfPJMrzbEaWfwRwQ;
}

+ (nonnull NSArray *)iYsJYyRYjIF :(nonnull NSDictionary *)gDyDcXPrlLlPjxT {
	NSArray *XNJKjilRddAv = @[
		@"ypUxIxdhOXTxpnlwuLChajcRhVlblMbVvpFGHwNScklLkUdPmECOeMTOvWTkPwyICgYPFALOzNyyWgeimxVnmSsxrDcAJAqjudbbTSfULwaPydUKUUhp",
		@"VDpNUIORGSAlinCHXzdyqXYEtukwhsJBsFgSFJdqdzdFwieUSfIzYzOIdExLCdrJjdcICtiMamQWgzNhARVgTuqMqdLchRLtuyDqZhrckkhthtgqtGzRgp",
		@"CJregqZtFGlIJyojUrvmjTzGTchbJPSKjudwyntPrQrNiuPowLOFDtmstFfKwABjCbDmSJwQWLEhRjTKfijWAiaOsXLxFuxOxrVZiITqBUAOqsmmZYMDoIoBAVCHwFuMoOAOUfVwCPdc",
		@"fpbSsdEPinnTatFBCKWIvFGdNpFvJwmVmHfebCogQgNPFSmFwuGyTnvZdFjxmLcaqTaYYFcwQELnTVjrRFKMOFWBhVJSGXyYxIzNwriOQBqwActoAueOWylqXOWndnPwYXjZbYkEHFvmDmDdzpZ",
		@"FqUahiqFhhHCcYZlcWuHErBTulVgACXZOqqTVQPmNLKXqQORZYbWFKDlfrSFRwxaCTRGDVLibpNflUVoqTvspyLFwtWrEhrflopXPqdPA",
		@"oNdvTVBsdrnfiGrzTjkbKtTWhgKXryCFlFxHitetavHUqAfGrHxJXfFQbRTwBKEOPsllbFYoDPhITvKuSEoRdYjkAlgcTdlHMFAlvpWWvNvOwwDqV",
		@"BHdIeRqcbhlVVGcOjtKtYXhqTLAGSvtHhGPPEhhdCSRxdzIequvlYzjMPeJqXntpAchAGMHuqycljHVXUfWvQIpgxpopPCyDicwUlCnqerAwepcGJQLIBViR",
		@"jgKRsPfrKyuNulBxCfhxkNQzFSZyZaVcjjyEGlcRnVRUNeQprsqqKdjHwGsFpBAVbysJaUTHzAQdcGaLcllalChjXExumRbzZbHGevTeGsXAfgSWBfAjOaoQ",
		@"fpqfgKYOZEgzQYZfyNqEfQaRpnHXrIixtEjohLnECPCcQlJcHCajEAHNIPXiESRlUXvYJXQetUFSOsrLpxgYLJBlcrxWQSlMeGiGkiNpGwJTZVVWfTOvgqdIwCTDkbJ",
		@"sZvthBAcELLQPwqKNthGQeRxCMIbIODrbuPPrPWOoOaKvDWJWoqwknBiuxMnoflyXDnPoJOlKqBgrMrLymqlyyNCMYIWTyUxyJPoXnUFADRigUJaRRccRxZTjxkEuLGOrOwhIPRROLKMEEGgUFsR",
		@"pCHodEDyqmuUhqebNPXCDesKxSzMrrApvaLSADiPuhFPazgpVinwGhIjdRxiEEiCxQrrPGpotPmLpbodvtIwyyusNbVFljZvmNIQyVyYwvQifFBrELHruSYLOzJmoarAYxBAkGnOxzSjDwbyiGn",
		@"AaPiqKFjtfwQhBMofmoPfzDEXjPlwCOkALhzlYxNyynRgwUyHTIbSPerYJwSoMtKmyrnbYLrQWjMpxMbOXVlgdYqZcbvyqzacuVkYpFBYxqCymAwgVnrDOpxaPl",
		@"NODrMRNDGFsMBUEHCUCaNLvMRIsRaPLUarSRkNEVTbGKjTEjeWNCOSxmGMEEZNAUdAwsuAwBDsXeQOUcaNsRbuSbyYzKedhTQiWlLhGMbN",
		@"HvcPgreenSINOlLdiLkrtEOeZkhxVHZTzqrHKStidIlHNcDADiMnuCkKdtUlLKoKksuyFlaaYtoPmpPBYRSupWotsrnTFkGzVQlt",
	];
	return XNJKjilRddAv;
}

- (nonnull NSDictionary *)qshznySuWD :(nonnull NSDictionary *)bgJEojzxZYLJWrKKM {
	NSDictionary *afOKLgOQeBaj = @{
		@"QgYUTjQTVRIKe": @"YOeeQPlBNWdXaCjIzTSnJDHXmrvzwIOgcwYlnOczbeorzyRONCazuURTmCialKENFSmcDKmpraWyHMestwyjEZOlqGrbHidnCdFeKhcUXocbcLSxrtivzdgZiQZtnvxpdakKaciMQtRAYKw",
		@"vpfTGeHZuYZdDCCJOAR": @"bASfLgsqZtqYniwUWvOtUollNNBGIRBAAyzgvJFpfFWlngZcuKqSfJCnmGslluaxIoLdoYAIDrsLTFdrnXZcIMvNDLmjjvtIvvgsZXunQmJdaNEgSZtfiyUNX",
		@"tWztLrWLrrHA": @"yVTtFwnSbAyFTpLpBKvpSlhVEtMHImxVJOFEoHkOhSwoVIwgMsSHhlSUbBrDIeqgDGYIIbHaTCLcXrKgzSbSjqQYWnlWMJmWtGkmjkHIVbiNoXSvRoWKIFXoHhyyceQPMGJf",
		@"VRQqDBaRPJode": @"VBVaGTxnuazEJBARGTJTqHPyfWJRgrJGfnrrHVffeVmIqUjHAeFRdjlQwJLKOIGmDoWXajILMONTOaHTUBcRoRxctLHTjCXoAwsEMEJXbUlSwFQnXATFFyiXXibwUZXGHJZEsvsLvCnCyrRiNxIUv",
		@"JBPlFrDkTGed": @"XpTabzhtwjaObMPqYnVMkXxVJsuhaVyRTXIyYBAoEsesiOZEApPRbYQgWfsgqjCcJXgYoQratwLWaKAlAgMHfDsRdAzAsTBMUoBYhcNITSQKddisxahTTdkAbpFDZmAPRyaBK",
		@"OJGJVDEvvfqCJOT": @"feqyxKdoVjBEhLQvCYFjeLDOhbgRcRIFUxxMcRhdCyPhmOPKTtDQUHkjRknYIJBDkpcJXANYzpQyoMMPAAbLwkPUxSnOPFNzUodQkfbzYsCTECHaHbMiaKmafILTk",
		@"oQZzxTZBnwJQCTeo": @"oBxPchNdcnUooaJGNHThRVjTIahzmTYOoYYJRgeZWnVNfGhjzdbVxBcemHLSdQBkyjaebCuswaPLXenvdqdnaHQPQmLfZErHRTlSiTHptAEdSFXnOzZ",
		@"CaKbXYuAvxFhyusHFi": @"RZAbdTvOuwAyRZIdptwTSRwuoCMwEVyYSbrLUOjazeTngnXIzcYNQgPxHPuEgJAqjfRRzfPCaZzbNFZDTmUqIpGSaGIbDrOIVZlfUFDXbsXQKZRaaIlJZmyUvoTSKvyhF",
		@"APUaDkKIgnjREKAT": @"lbLphSbZipJchEiCXxLCeqVasElIlVsQxUFPXdZpahgbOsAVTXrlFoCCEARRPdipuPNNnrNjMztHrJyMMLuIXBazsrJHJoupMvIzecFzsaL",
		@"wknpHfscBZOdCzg": @"npGLLqGdzbSCWpoiTWZmmctnGuamkRGkwWwaGcJNYPvPgATGZbKFoFfsWIRRFGfBsSyzClvDAgNwDLdaHxkOQniPjRIbrsndNKKRWzNQHxKrMWsfzvIdhoxfURdrnkbkUzNaSwFAm",
		@"xcajetOkBMBh": @"KxnKnZjiMIgbzzHadklYylnayePwRJzkWFFKYyFhktBOCJZHwQmkbbdAkwBnBuXZBZkrxcmpJEUUNMKIEwBzPptmLhmyVOlUCqNviRgOuwVQTkZdLVZAFMmRkSKvpBKakZrMquVbvPZFkAmU",
		@"aLFJIDLvhwUkU": @"XfpkJKzAFoDvVVcGsZoXECTuztWYAgWoFoFTYuesVblyKTIuZkitcedtKAjxcnaGPDeBTHadxGAjjRMuqPTZueNAkmiQtUqCkXGLrXpeTOIHOW",
		@"hIMGSCwfOArPECCCs": @"DVVzTOZYjOjAoFRaUgVKtFOHPwjXjVPMOISqBdiQcxogGxqIjLkDwzvyjLDEfWvYJxNXISFaMpVSmXRJJsOjhkTTIVwHQOXqrLQubNAwqfSdMIltmTymsBCEVIoAxlTUzXKrpYXm",
		@"gFyeHNQAtvUOLVGo": @"zbFddBGebSdlunTQVQERCuByYMlAHIvdiFcGZGYeHFepHOThdeQZlJNTtzANrsOCuItdvkIgtwLwTKcNYCmBmLTWpuAqlHKIbaYXEKZGBItwAdiAXYIhW",
		@"sWZGwjJtBPDnViE": @"CecVHfHQeRrUWYBNyrRDIkTmVQbcUldWEnyjLyYqLzZrBsQpCWcKOVQESCOXAmlZFvxJXFjgjeuMBWYYkLUATNXNygdrxRVtIDLDggxyIj",
		@"xTauWQKAFz": @"wlqDKMUMLsAKXJkZEmYboetAvXgCgqNCvIsITsPkqePaResWoQVflcVvrolExfMuGpXrZPzedXFqgjCdXmNSDfHkxfxzgenUdYtjOuStyBqlCcgDggnjteGh",
		@"HonXeYsLMxrkNmEJ": @"CHGoTJYXsGxlhzifVBpzyVFwRlhwPgtfOlZAfYPKKiDnDNkKrpFxsGZqCIdbPdLaXJduNiZDDYmJaVRjhZcWxAkbEcyIxKeoJiEaTVRgIXXhpnvfZTWFkptMngHiQPpeQAmWRuyAAZZffUWTvVTX",
	};
	return afOKLgOQeBaj;
}

- (nonnull NSString *)pzDDWcDUhlDAWseF :(nonnull UIImage *)ilytemPbynOPtzy {
	NSString *RrKTyAdcLq = @"oaLXeurmRnNZnYzTsNTmAaKkfKNkGyGzjfeKKmnzXUjMoDSaWvZXGmDcKFNzAcmyakllTvkvZPKqkBkbNFMZQgzlYAouzWmpcaKOGJmpqS";
	return RrKTyAdcLq;
}

+ (nonnull NSString *)pPWAFNdMmAb :(nonnull NSString *)QFQpnQJtsxexikdbBwK {
	NSString *UBTYYdmTftvMrhncBHq = @"ziXlrGMwMHPdvnSxnzKciRKtgXaGyUxhyJdmmlgkFHxDmlbJjvWPGyQDeBGtjfEdJWkeZjFCtPTLYWyFWGwKYCdxgQgAAJHIqWbQxFQtXsUbZjFdewwskRjP";
	return UBTYYdmTftvMrhncBHq;
}

+ (nonnull UIImage *)XiHqdnUmffXPL :(nonnull NSString *)qdWEdszVLcm :(nonnull NSData *)duzQcufQyidl {
	NSData *wKfcPdTHgCsSjsJorlm = [@"HobdBzzFXsOXzGPtKhqRdFJXHBmOZZFFsXGIfpAjypdoRxUudZwKxZKDitCbLDsUBlhYLOcUtzlLrXMYTXZViYOJyhoYBQDMuROpdHzWyJaTTSpWqIHhtFaEXnuXnCkIQnzAwbfOoWvIgo" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *EqgdYBaZeGJxoS = [UIImage imageWithData:wKfcPdTHgCsSjsJorlm];
	EqgdYBaZeGJxoS = [UIImage imageNamed:@"qoyVDSJLAUESbTDGvrNYiFZTfpDSyAMlpkfdxQbVijSgdYmRsVTwfpQpfpEBYZCXAJNpaRGQhJvXhqBxaMBZIVxzvAgqpFTyckZPSavuxXafKVNXVIQZkKMh"];
	return EqgdYBaZeGJxoS;
}

+ (nonnull UIImage *)hLfZBPTkIYvUft :(nonnull NSDictionary *)ADpWUpURlkfFecG :(nonnull NSArray *)mYcbsdEoQLO :(nonnull NSData *)OUSqzgOOhqQIpm {
	NSData *dLuOUJyHub = [@"CtPMPaAmjfrNFUWMyBhNapKRrhkdtPgqwuIBgCwoWxtAuehvUvrsgzeqKmnCbswRtVcveVfeYPXKMWCvWlelPGPwhTkBbpCpDrvcbDjbFNmsOrBWpIhrsxnuoeFfVqzRfyBNFkpvQRruAL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *CRBDUbjEUajFYb = [UIImage imageWithData:dLuOUJyHub];
	CRBDUbjEUajFYb = [UIImage imageNamed:@"gWFJagEWvJYtkMAuZklhNcKBQFcXcQSVymXCmdBaccAyEiTjoupdolNEQgeKzAsHAHXnptSgzzCxKQxwptimALsLvlaYeyGVdyva"];
	return CRBDUbjEUajFYb;
}

+ (nonnull NSString *)uSXZncTcSDIU :(nonnull NSString *)KXcKrrlJyrUEdmu :(nonnull NSData *)QVqPUKKUVFqdGkzXlr {
	NSString *ImneRvymzpCmGtDa = @"sWmESatqATkWOoKIEKYlJiOrGXFXSIdEAknVCZQWDTkfDhYNbZhZYoSCtnzxcLglKQMMXclofePstYNrpfTWXVxLsnlXRLijcfhVblkQWdpRhUiaD";
	return ImneRvymzpCmGtDa;
}

- (nonnull NSDictionary *)ieETQetfvWg :(nonnull UIImage *)HwmDMfwQhM :(nonnull UIImage *)YaKyvzbcdQWN :(nonnull NSDictionary *)OjvSCLoPugZQQE {
	NSDictionary *vNWPNdISDMGIlMAufj = @{
		@"sDrOQVctkPUgBDRyq": @"tUGEnPaBGOEBZvRhPGTaQoOBJEnaxDLfOgECMSbOPAlnYaSduHhuIDMKlwfRqawjOieLNdbHpdIVPXRsqVbmjLYolpUcXQgxtgupoqSABcGfEnYRddKlhEncjEiEQrHLHqOhpbi",
		@"BFyZbnnhQUCr": @"pzJLpIcimvUMkIsnZkGUfcyxVlmfNBalCMXzVHNJBrxIIYLkQiWYeoWNhzPYBMgClojwutnKkbCBYLztByVknFGWYOcKzjZsmAVUZdpvInndNRONNHQ",
		@"LlmcYbaWBRm": @"AOKYXsVbWBRIjmGhMoyOKtjdksPGjCcrYDFKfOCERsDzbbqHaMMnMvvTLunDQmHocPLjtAsppuhFEGFOoihEUwWKaTjoUOIfHqRnmPMmnsVlt",
		@"SskBiThhAVlFDAo": @"pHtIumyNTxDGQCMuApKrILBNkQTcjesPwFSOdYjCbduVAnopgCYWtaSrhNeKlaqKXVDblTUIhBkPZUMnLPYtfAHtSslyiECPgPdliq",
		@"nfrdfmTQXeacDSe": @"lXmRebJByFkDRqtcWEgEzyCXWPiiZPqBIzVImzYKtEdyRWRTmoKBwFQPbwAsQCrneVLQVsQedxxnSShSVqscYIRoKzrOCedmmkPIHQOGDIXDoOTTRowoLKfznIeeOKWKyiHsiAbKAlQuAnWSJr",
		@"hIXKCRWWpN": @"faZGJqRbkADXEWvdUrHJWgnJJpPvbNPoYVEgQETpxMWlCuERcdStlaSqEhpEmqoldrqBzaSlMtaDclulGevrNTKbqfFGtMKKRopt",
		@"DIETcOjZHMERjFzD": @"UfhZPZObbZVHajHunJRviqvtMDvkCPvWXTkdixSwmjovZTWgiuoJObKiOAJVopfMNVZbfvSDNpbilBNDaGQDKAgHpuxiRjCseJyEfUJsXSkiEZlcckxuIqiwcptMhkwcQFeITbPSp",
		@"PQGYsloXHagfjecc": @"zpShzAefTbofkgsTSXqKIwFcyuGXqjStZvLAqVGCSOcTYFIRodNTsmHPVHDlbUGvvZbttKKtJGjSkGrxtfMoetVtYZNlNlVhxVwKBwuGFHvJGXoaJjkvjSxrbMpmzEneR",
		@"vtcloTBYIMr": @"mdZcRdaklszegCoAuUAlWsyvyUJLbzXxgkZaFguUcFAZLCYfrXpxaJfEvwUwfYmhAyWoDpiLSqqVqPqpJKsggwrSNHMTgNLAzcwDkpDokGMRHDGWkcAadpBLPTdIXKnKpKCWbGmIqEltpDsu",
		@"wMvaTzNFwXIzlAay": @"riJnzcxyJAxiBHZWGbbOVukUctDucaiEmCFCxXUSkozZwxZRRNucSYMtXaICQvlqkTlmBiUckSXLMhWXAoOmFgpMijcErvBQtrWKJOQMujXoKGYlYQsFlkiCrYRPVSNDnxWXsXCNwGpd",
		@"HCknJZNNFfhkDLX": @"baSmjCGIYXZIzfFntbJnpkUUDhmYoOVbuzSgcMXlrSYxvEtibsAxMHLMrRsYFSVwLSRknedDLMhYMQtFkaLRJoUXbcXimgqyMfXksKTUXFQnnFZKUbqHWSmP",
		@"qJiCAAmoCD": @"mIXsoVOReOmltoBDJBZRDlZNCDedCkrMzSvJhfatfzjeBVxYiPjhtLSiOMKdYDbTPYTQVvbZluEHilTjmQPHwuenZLXvEstsbAmNFZoyzhKxpLWBPVwRI",
		@"tWEXjPSXfPGTQH": @"VpazeLOWVQUjAWaMlIazxbTfwlEOaZCwLymoEnPyBphmDMfRJMMwoWsexSXCNtmOnACaUGjkuoLyURVTYVhiUUIuGmXqPILYHFCTCgFqpFvZOHarHvAt",
		@"FqNqPKrmwNElmh": @"OefrvcpWDtttxcMlvssCCsNCOVACagflcOFupcFheRnKQMudoSBaReQEaAOhcnIwnoUBtmGopEyZxHfAebTPUXLTdORfxqnThcHZttRRb",
		@"tUjwMcCGRrdp": @"gCqXnslUtrYMcMHCGzZxOhqZRMhEXymmvMSGczrYbAHlsdmCpiOeNIuQjqNlTZEFPSJkbxTTIWcmvKUueTYIOzLeJbPwnVpNXOKlJAiNlzkMgR",
		@"OoKbDxHjhfhKGSg": @"CdZQkdBVYmwGqYJIlgIZSGhnUlgqjVAfmkrIFFzVgHKGUdzvXayEXXbwYkfHxhrXPEGZaqnXVAsBXsOBkuapZfnvhPNBCiBWiaIaXhzUMRkphTcofTCISplXmvFCkNwYfgWnWuPfqw",
		@"kLDdQUtyEo": @"LfVwySxjGEJgfcMGNHYFslWrUVxnNEtDaSKBvkkyKwarjEDDNxmqojqrvXLpTbthNYqMFNzQYvanReFNmCIZzYJtZbyAiLzxaeHySelQOZqKSlNXGZQyHlLQEiMcCbQaqoyQvlyfLFZvFKg",
		@"SIolIKrgmeErZRAO": @"tHVckndYMMFjtfkqsHkZVNlDKWsFxpIYnFqmyfmQMqJsIDVLynvNPgYbvdLTXIRRmvVVEReikhJBCRXjGYbkKrbELpGEWBFexPJjrbUTcDZNnWtVfeUaGyrwtpneNmkVUEqYlroRhtmIgOkSwf",
		@"yMXDNyHVdJusksR": @"WzIBCRIlbOlXChTKIVHSgIJuFfxCrwZbDAcJGvRBtArhtLLBAUPCMRuXISgFpgwLZIsKiwcQUlWrIjcNLkMREUMDVqGeuKJERWtmSHZpSbAVDvhPExlopsuOMdDVLKkLoexpyjmIMHok",
	};
	return vNWPNdISDMGIlMAufj;
}

+ (nonnull NSArray *)UOuteUdOqinSVahq :(nonnull NSDictionary *)JeIlmpnSWyoS :(nonnull NSString *)uChiYqfMPjbXFzGTjxf :(nonnull UIImage *)DlMnUuTsFNqaCfQ {
	NSArray *oOhvnaMGchxtau = @[
		@"SQoQDXPVhcJklpjVJMDtLdSHFwSLGRevYBkWGPpSDJyWTAlaiMTMtFPUtYTpPVpGxjLVvhAJjFfNbMmmgpyGxPGcjUVZWWmnBYzFySwGbf",
		@"zzAaRoswvuvpGjUusaZeqhTmuAJZtYYNhuVbyEtaixrnzssmJeOVbiYpWUBIeUBmxdUiKZceMXkEMpCbbIgPIeufKFAegtzhiunFmJbSrkkekuvqvISadZKWwGuMjCAjMCSsLggVOzlQyyEFtimcM",
		@"moiRMKmnxqlZweAhvOtyoddqNbjhRFqUrIbIzcCDuSCIpXkqwLHmYoEcKoHfoYDeqCppFYUuGEFBKwULieSVoPFqtBydbbXTgWxoKwGrdvAZQXUYfuLGptZJaTzGzbGSIYzTdXWukCnhlGixug",
		@"FPjBmThOECUogJLqPMNqZhsAsipCLGRfqFwooLdIoUVUSbhZZfBxNugaEIAqEACdbPPPmNlnMCMobYBXjgresODetVWsYkpWIZKeiadaxaobbYqJsgndlVRxOUBbBHmovkeuMVoJxBPmzLTHB",
		@"WtVafiRalsvcKwjJDadDLbwLZLNOzmOMfnJKxNwtLBXIuYVeHEuWhUfisiQGcrTOGopyeGRoZoNvXDkAwreQJLYEdvPKmpkNZmnoQtwuhZXqXtWFTAOlOQyFUUPjxm",
		@"crOvMLzwiVgbeVAInDAXUOElVUjoNojorEgOWKhEJxuDvAgcpthCsgyONDOowewKydHEgOwwKQbnmDFEDFOsmptKepHiwqdaFialALFrcIBUXTSauAGZrtVhKAxoFxwnRD",
		@"fdUCCuOFgWOKXGbIHjcYdIfNGkXiYVVjeZBtZefzNAKBiScNulNAPrYKkSvshYNoDGXFMDTDDrzEVfkFQsqXxOqPQjkumVRjdQyMBsjRyTmdQxRfGfhJktfkiMworeowELTDaYNdmyuo",
		@"KeBVnhYrJPVLIsgXrszocLyUvKLYnWDDeIZQAfjDNgNkNhOEFhRJyrxSDoayBPiTObMxqZDzjACKZYhFegmDPbpZDuXNaQdlWxEUZHutpjVYYYBthYv",
		@"KpXYoFZMcUDzlzNnxngccgtiYHuNIlyfMnfnAzPdlsxFZgqNnBiHVJTqWhjOYnpGCsFumGcJBSplaVNiegDNXKnXNpZpWseeNFRrnrYOBtfGlaKLtYlsJhFiGTczShQimGZDhhIkszf",
		@"LVDemggRWOmZYynidoeyYpxOoYsXIDEBGDnDOMMEcpQiOXPRPvOynbgGeOhrWMFRtykHDkkenvTYsCHfmphlscggPBvPceIwEiTQiyOzebSxTpHko",
		@"qIhorXecRibOHieCQcWYMmkbmQmbXYGVJlDbLhacErGOcqAOyTqhgVvVpiKslfiwIVJYIbgWUZWNmaIOIxiAhhtQBGkdHbIQoDrqCfuveWDRJyR",
		@"kIYojEvwGuJTyiAlpwpOMQyFWDwnXEDILgZoYNphvTsVPJmBeHcNhFnRxMHWrgjQbqNappshIkoeeHOBjWPNXmCNuilbvVEkjwEDnRg",
	];
	return oOhvnaMGchxtau;
}

- (nonnull NSString *)CJRyJPZqXYIWSkV :(nonnull NSData *)SMXTWHOSyJNVtEMlo :(nonnull NSString *)BtnAqSNPnZ :(nonnull NSArray *)sRVFAsiPmaTp {
	NSString *IhhpLvmWZjcjcHHx = @"RjsBgUhSiXJayYnfJOKIAqveXpmoWyZHVXJbNqIRglnWzXbAWLiBfQTDVIAGMQPLXsbQAeoEgloCalOLTClsAVBYFWALApbbCvoY";
	return IhhpLvmWZjcjcHHx;
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]
        ]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert);
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HAVEPUSH" object:nil];

    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
        // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
}

#pragma mark 获取文件服务器URL
- (void) getServerUrl
{
    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,GetServerUrl];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:nil success:^(id responseDic) {
        NSInteger code = [responseDic[@"rescode"] integerValue];
        
        if (code == 10000)
        {
            NSString *fileServerUrl = responseDic[@"data"][@"fileserverurl"];
            [MainUserDefaults setObject:fileServerUrl forKey:FileServerUrl];
            [MainUserDefaults synchronize];
        }
    } fail:^(NSError *error) {
        
    }];
}

+(AppDelegate *)shareAppDelegate{
    return (AppDelegate *) [UIApplication sharedApplication].delegate;
}

@end
