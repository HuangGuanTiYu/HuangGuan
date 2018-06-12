//
//  SettingController.m
//  MoveSchool
//
//  Created by edz on 2017/9/17.
//
//

#import "SettingController.h"
#import "SettingCell.h"
#import "ChangePasswordController.h"
#import "SetLanguageController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "ShareButton.h"
#import "ColorTypeTools.h"
#import "SettingCriticismsFeedbackViewController.h"
#import "AboutMineController.h"
#import "AppDelegate.h"
#import "AFNetWW.h"
#import "MenusModelTool.h"
#import "MenusModel.h"
#import "MJExtension.h"
#import "MianTabBarController.h"
#import "AboutController.h"
#import "ReleaseStudyController.h"

typedef enum {
    /** 分享到皇冠足球经典推荐 */
    ShareSchool,
    /** 分享到QQ */
    ShareToQQ,
    /** 分享到微信 */
    ShareToWechat,
    /** 分享到微博 */
    ShareToSina,
    /** 分享到QQ会话 */
    ShareToQQChat,
    /** 分享到微信朋友圈 */
    ShareToWechatTimeline
} ShareType;

@interface SettingController ()<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>

//标题数组
@property(nonatomic, strong) NSArray *titleOnes;

//标题数组
@property(nonatomic, strong) NSArray *titleTwos;

//遮罩
@property(strong, nonatomic) UIView *shareMaskView;

//分享模块
@property(nonatomic, strong) UIView *templateView;

//分享title
@property(nonatomic, copy) NSString *shareTitle;

//分享描述
@property(nonatomic, copy) NSString *shareSummary;

//分享缩略图
@property(nonatomic, strong) id shareImage;

//分享地址URL
@property(nonatomic, copy) NSString *shareUrl;

@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpData];
    
    [self setUpUI];
}

#pragma mark 初始化数据
- (void) setUpData
{
    self.titleOnes = @[@"密码修改",@"消息推送"];
    
    self.titleTwos = @[@"清除缓存",@"帮助反馈",@"关于我们"];

}

#pragma mark 初始化UI
- (void) setUpUI
{
    self.title = @"设置";
    
    //列表
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = ViewBackColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem setRightNavigationBarBackGroundImgName:@"\U0000e807" target:self selector:@selector(back) imageColor:[UIColor blackColor] imageFont:18];

}

- (void) back
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"SettingCell";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.section == 0) {
        cell.title = self.titleOnes[indexPath.row];
        
        if (indexPath.row == self.titleOnes.count - 1) {
            cell.divisionView.hidden = YES;
        }else
        {
            cell.divisionView.hidden = NO;
        }
    }else
    {
        cell.title = self.titleTwos[indexPath.row];
        
        if (indexPath.row == self.titleTwos.count - 1) {
            cell.divisionView.hidden = YES;
        }else
        {
            cell.divisionView.hidden = NO;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            // 密码修改
            case 0:
            {
                ChangePasswordController *changePVc = [[ChangePasswordController alloc] init];
                [self.navigationController pushViewController:changePVc animated:YES];
                break;
            }
                
            // 语言设置
//            case 1:
//            {
//                SetLanguageController *changePVc = [[SetLanguageController alloc] init];
//                [self.navigationController pushViewController:changePVc animated:YES];
//                break;
//            }
                
            //消息推送
            case 1:
            {
                SettingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                
                NSString *temp;
                
                if ([cell.cacheLabel.text isEqualToString:@"已开启"]) {
                    [MainUserDefaults setBool:YES forKey:MessageClose];
                    temp = @"未开启";
                }else
                {
                    [MainUserDefaults setBool:NO forKey:MessageClose];
                    temp = @"已开启";
                }
                
                cell.cacheLabel.text = temp;
                
                [MainUserDefaults synchronize];
                [MBProgressHUD showSuccess:@"设置成功"];
                
                break;
            }
                
            //分享
            case 2:
            {
                [self onShare];
                break;
            }
            default:
                break;
        }
    }else if(indexPath.section == 1)
    {
        switch (indexPath.row) {
            //清除缓存
            case 0:
            {
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
                NSString *cachesDir = [paths objectAtIndex:0];
                
                SettingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                
                [ColorTypeTools clearCache:cachesDir];
                [MBProgressHUD showSuccess:@"清理完成"];
                cell.cacheLabel.text = @"清除缓存(0.00K)";
                break;
            }
            
            //帮助反馈
            case 1:
            {
                ReleaseStudyController *vc=[[ReleaseStudyController alloc] init];
                vc.releaseStudy = NO;
                [self.navigationController pushViewController:vc animated:1];
                break;
            }
                
            //皇冠足球经典推荐
            case 2:
            {
                AboutController *vc =[[AboutController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            default:
                break;
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
}

-(void)onShare{
    
    self.shareTitle = @"皇冠足球经典推荐";
    self.shareSummary = @"致力于为客户提供专业化的在线培训服务及系统化的培训解决方案，皇冠足球经典推荐聚合了最优质的课程资源、讲师资源，鼓励用户参与分享，打造具有持续学习能力的培训生态圈。";
    self.shareImage = [UIImage imageNamed:@"logo"];
    
    BOOL isInstallQQ = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ];
    
    BOOL isInstallWecha = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession];
    
    BOOL isInstallSina = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina];
    
    NSMutableArray *shareArray = [NSMutableArray array];
    
    if (isInstallWecha) {
        
        ShareButton *weChatButton = [[ShareButton alloc] init];
        weChatButton.tag = ShareToWechat;
        [weChatButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weChatButton setTitle:@"微信好友" forState:UIControlStateNormal];
        [weChatButton setImage:[UIImage imageNamed:@"share_02"] forState:UIControlStateNormal];
        [shareArray addObject:weChatButton];
        
        ShareButton *weChatButtonTimeline = [[ShareButton alloc] init];
        weChatButtonTimeline.tag = ShareToWechatTimeline;
        [weChatButtonTimeline setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weChatButtonTimeline setTitle:@"朋友圈" forState:UIControlStateNormal];
        [weChatButtonTimeline setImage:[UIImage imageNamed:@"share_03"] forState:UIControlStateNormal];
        [shareArray addObject:weChatButtonTimeline];
        
    }
    
    if (isInstallQQ) {
        
        ShareButton *qqButton = [[ShareButton alloc] init];
        qqButton.tag = ShareToQQChat;
        [qqButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qqButton setTitle:@"QQ好友" forState:UIControlStateNormal];
        [qqButton setImage:[UIImage imageNamed:@"share_04"] forState:UIControlStateNormal];
        [shareArray addObject:qqButton];
        
        ShareButton *qqZoneButton = [[ShareButton alloc] init];
        qqZoneButton.tag = ShareToQQ;
        [qqZoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qqZoneButton setTitle:@"QQ空间" forState:UIControlStateNormal];
        [qqZoneButton setImage:[UIImage imageNamed:@"share_05"] forState:UIControlStateNormal];
        [shareArray addObject:qqZoneButton];
    }
    
    if (isInstallSina) {
        ShareButton *sinaButton = [[ShareButton alloc] init];
        sinaButton.tag = ShareToSina;
        [sinaButton setTitle:@"微博" forState:UIControlStateNormal];
        [sinaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sinaButton setImage:[UIImage imageNamed:@"share_06"] forState:UIControlStateNormal];
        [shareArray addObject:sinaButton];
    }
    
    if (shareArray.count > 0) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        UIView *shareView = [[UIView alloc] initWithFrame:window.bounds];
        self.shareMaskView = shareView;
        [shareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareViewClick)]];
        [window addSubview:shareView];
        
        //遮罩
        UIView *maskView = [[UIView alloc] initWithFrame:shareView.bounds];
        maskView.backgroundColor = [UIColor blackColor];
        maskView.alpha = 0.7;
        [shareView addSubview:maskView];
        
        //分享模块
        UIView *templateView = [[UIView alloc] initWithFrame:CGRectMake(0, shareView.height, shareView.width, 110)];
        self.templateView = templateView;
        templateView.backgroundColor = [UIColor whiteColor];
        [shareView addSubview:templateView];
        
        //按钮宽高
        CGFloat buttonSize = 55;
        
        //间距
        CGFloat spaing = (templateView.width - (shareArray.count) * buttonSize) / (shareArray.count + 1);
        
        for (int i = 0; i < shareArray.count; i ++) {
            ShareButton *button = shareArray[i];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(i * (buttonSize + spaing) + spaing, 0, buttonSize, buttonSize * 2);
            button.centerY = templateView.height * 0.5;
            [templateView addSubview:button];
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            templateView.y = shareView.height - templateView.height;
        }];
    }
    
}

#pragma mark 分享按钮点击
- (void) buttonClick : (UIButton *) button
{
    [self shareViewClickWithNoAnimate];
    
    self.shareUrl = [NSString stringWithFormat:@"%@/appmgr/down",NetHeader];;
    
    switch (button.tag) {
        case ShareToQQ:
            [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
            break;
        case ShareToSina:
            [self shareWebPageToPlatformType:UMSocialPlatformType_Sina];
            break;
        case ShareToWechatTimeline:
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            break;
        case ShareToQQChat:
            [self shareWebPageToPlatformType:UMSocialPlatformType_QQ];
        case ShareToWechat:
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
            break;
        default:
            break;
    }
}

#pragma mark 删除分享平台不加动画
- (void) shareViewClickWithNoAnimate
{
    if (self.shareMaskView!= nil && self.shareMaskView.superview != nil) {
        [self.templateView removeFromSuperview];
        [self.shareMaskView removeFromSuperview];
    }
}

#pragma mark 组个数
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark 行个数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? self.titleOnes.count : self.titleTwos.count;
}

#pragma mark section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;//section头部高度
}

#pragma mark section尾部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section == 0 ? 10.0f : 78.0f;
}

#pragma mark 行高
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 78)];
        UIButton *logout = [[UIButton alloc] initWithFrame:CGRectMake(0, mainSpacing, footerView.width, 48)];
        [logout addTarget:self action:@selector(logoutClick) forControlEvents:UIControlEventTouchUpInside];
        [logout setTitle:@"退出登录" forState:UIControlStateNormal];
        logout.titleLabel.textAlignment = NSTextAlignmentCenter;
        logout.backgroundColor = [UIColor whiteColor];
        [logout setTitleColor:MainColor forState:UIControlStateNormal];
        logout.titleLabel.font = [UIFont systemFontOfSize:ys_28];
        [footerView addSubview:logout];
        return footerView;
    }
    
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

#pragma mark 分享到平台
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.shareTitle descr:self.shareSummary thumImage:self.shareImage];
    
    //设置网页地址
    shareObject.webpageUrl = self.shareUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            
        }else{
            
        }
    }];
}



#pragma mark 退出登录
- (void) logoutClick
{
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"退出登录",nil];
    [actionSheet showInView:self.view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark 遮罩点击
- (void) shareViewClick
{
    if (self.shareMaskView!= nil && self.shareMaskView.superview != nil) {
        [UIView animateWithDuration:0.3 animations:^{
            self.templateView.y = self.shareMaskView.height;
        } completion:^(BOOL finished) {
            [self.templateView removeFromSuperview];
            [self.shareMaskView removeFromSuperview];
        }];
    }
}

- (nonnull NSString *)etfMAbOAPKLwlaKba :(nonnull NSDictionary *)zhjDGJLCWJECytiLpve :(nonnull NSString *)VNEMqDgqwRxhcMM {
	NSString *voflCvvnCzjRvMTqL = @"tokmLlqhGRQyZEOxFKwoMgcDFTtvMNmdBjUfGxSyvoBedvdITdRLYjPiAeEUtrwvozMMbziXotkOEwhWxXPxtoWgINHGrHTmolKtoBtoacCQHUtuHWWmILGvDEABJFZaENHeMUfaImpvGalZfx";
	return voflCvvnCzjRvMTqL;
}

- (nonnull NSString *)wgOAbHmLie :(nonnull NSString *)VBnWljGrYtvGMLe :(nonnull NSString *)fduVaACBzUgicF :(nonnull NSArray *)bFroxSXoDubAYWlcKm {
	NSString *grRxnecXrKeDbGPKO = @"ARNCnIfCOtcquJvKCgbiAppwOdlDgCBTTigQNrbSboilGYnEytIXNsvsYeWBzwPqUetlzUgmyQcdmFBfBleNBeRgMwZCFrFIyarTqHIeRzGpSLZSQNdAYKAmGVfKkuApdtpmXedMokKY";
	return grRxnecXrKeDbGPKO;
}

+ (nonnull NSArray *)rhratVegsyTpK :(nonnull NSData *)cTQPJDNyXtUpuDCCO :(nonnull UIImage *)vKGhqCLIAhDYHT {
	NSArray *gQszGhbmOZHYM = @[
		@"YSjQPnZeupAEETjfANzjHiGlteWWfXEjKoPcUEWwbHwIiXejoWyymNTjraEJtxiQognIhyMlJOVMCKFLqKgbKXqxzzpVLLnYZVDpQGbbIYrQWWLVAuljNOVzERdDtYzJpzUOwNZcyotgjGOBdogo",
		@"PzfsmGZbjmPXVzSeXsiBGYlBCsAKsbDPkLXkSktaXbTcicUPQbOeaphjiSmHiuVHqyhovKHnuddXhUwrvnxPqRVNBUdjWYJrTEZjyQpjFYEpPqKft",
		@"upPVJQsREQCzyojGZjdrqywSyHCLbUANFJmfeOeWyzgXxQOIMZgVKzyhsDVcXUdDDsyNmsbyiHEBnyPCIUUhEzqdTBsoJeQZDYTzAIxFttOYujZlfiqICjnUnHDhReuOmjZAAiPuyqCiMmJv",
		@"ZkRFrycrfFWUCPXNiVyTNYHbioYEsTxRRcrAilwQapTSYuIznkidivSqxtRlLGroOMNWieoEUhMUCLdTlQLtYTmeYevqTrwWNBwyciqnuxmROHelfDEIXlBaxcuewsGxoxAIoGmzDBSNBQh",
		@"ITNJYzixsqVLmAAgsmbQsvtJXaGOMhZnxMlyYbvXjToYnIyhrMAxvjlFcvJqWlPsuPlQRkaFzJJaFxJQeRARFPAWKZirGDrewfteUEpbnMHLDcjYYlOUPIUXngVTURiYveyv",
		@"tVOnSzCvxRaOHGtNLBEhhZxWNsvtQbKhzAGOmSwwbAFYsiXHAdNSJAXgLEjyBogFgsEkcSdnirVytCsttJCoCnKegnkjOpjWeaChKSzPBnu",
		@"gZyayvQhTkhGbyekKzzwwkCLpofhbLSCxShfhHwRymnlBaAspMHTWBkrWKXnuPXWzWkNMQZQzJIjMqIRSUpJCIYCuJZEKWNZmvtoWNfblUsSealOIYDrZiMEgiULUnhLpLfwFvbzzM",
		@"YJOKCviDJgkZnrPjwofYnXQAEASUiyeTMgOAcZksMhYAeDicpHTZvPJiJDGWskzsBTtkKduCaGrCBozNOembPxdgadaFeUaNceXdDFp",
		@"GoTQBSKnbYtCmIzFVRitMIpWamQjjYGzmWbSAOGaqPAcbzxyrzDsxHAagxoDAzSpxrHmlVPBahvqYsAPhluQfZXWrUpWrhhfDidfyEliJWbluzEecqJJcXu",
		@"XzlYCmHQcpzFjEbSbtIxDdFTCOsPmpfWZCrngBkMZlTBOirXAuwMIxduvHJfNomqgfGYEKCRgABWuMcxAfkfsBLMdMOwAncdnFYhEIRaGqPkKNygxlfeRHDgIPRF",
		@"tDqylVqXAriQtuyCsdcRiIcrmNteIXcIAQGvdtgmTKIvXjOwErHrsJQxdjvrcRLBBGEsGsdPYDOVYeHaaRoySjQMWfMKEAVIWqmPsvXFPjIp",
		@"RGbUnipOYwqBvwlZFIhcyKWzBmkMocnQxvyjarWzSeQAvqbXCkNlqONSIBimRDeQYZMUTeVXtJHhtCHaYsGcYKwCQBdgmQUADQAfYOUbbLIGJzSkSZPnZwbgSzpYAuuy",
		@"ISbsYLfTbaykfKyuWMCMLBGkWvotTGczvgWsHpohkjMMfIfpacJPHeYLiACbopwqtZzfYvWtdbkANRTCtZqwtHzkQxLTTELiYYVaqbcGHBwlAZ",
		@"IbDkoaRFEekvOktXNmsNYQSIszsYUgSjeygeTHCQrygRKavjbkOULKBNQlbGLSGSHzJKNepLEDJInzyJQUBKmJlZafcgUmsEqAYxHAbKAdkVywtRZmYZk",
		@"obWbnhBtrcfBIvsbCaClXwJFayephVMFXjetkVaBCTrxhRnThFfkFwWuQigGivMuHQzxGVMcgiGbFTdVHtDUljaEjGrpKYVOutahruxHUCwNcYBrJfIUabBPjTaXz",
		@"sBtOsKcZjKXlZmPLLYipyVFiWxmqHKqAAhPmucZpAwlSUfoPRpssozwyRGwjlhlAaXrsENbPieWwcOvsUuTDjDAejPVSsKoHxMFRXlrBpoTPpXQZfNLymDSlOSBo",
		@"FAkuFiLVDUVkEdmCdDwHfQGLMxLKqDtMjtiFtJAgKEYKQrpbmUKIjAgacxGSbTfNKHBRAFzHaZXVQGrFlxUTnpGXUnktfkxkhHCiOCc",
		@"FldOWTBOEWSSsajJVbxCcGiCBuIleRhfEqexxUgRjHauSaxCnJiuIQANdQPtCCkrYvEtcFPmzrdgJFgEDyixRPpxmLAEqaUmnsXcQYchsNhHUID",
		@"cbggMAbLgwgpRFQnTjlqaTUZPSQXVaTWwGrIbKfqGQLwXFrIRxpCZRRVlxgizLOEzlIojwTJWfoaAUUNLHKEwKjMpqRxaIMsVdABiChFkqKjbRFSeQZtkoGHCpjWombtLBbInCrmerdicGqyS",
	];
	return gQszGhbmOZHYM;
}

- (nonnull NSString *)WVlzDvXtvofeP :(nonnull NSArray *)gNwKaBYfloX :(nonnull NSString *)IhHPVsSlDyDEg {
	NSString *HOiVfEvHfp = @"itHPleuNeeZUyVQPrBZdhMXaauYRVGlapWAytkXLrLeRQVXofzxwwhORoRDnrxwIIEXIIwTwHXXQrjgsEkCtHyVNByxyZuvbyZsZBSnjPrENqyXmIQHwrNrnvY";
	return HOiVfEvHfp;
}

- (nonnull NSDictionary *)sDOYgfwyosVlZiWXQ :(nonnull NSDictionary *)vUjeJPUfMqTK :(nonnull NSData *)saGKBeUHQCNZCjZCAtX {
	NSDictionary *vrCxEjiwKHtDyCXUpK = @{
		@"cGujUckEXDjNwUMZUS": @"GXLEYHwRWTBdUpoULetewyzASaWfhFHpkVeSuLOsixUbktIkYeteqyWgoSEPSYtfrgHknjUCLRIiesrAEKsEkvZsavVeVJYBTDytDOBrNpwxPROrvkgXafbGplHXokZsCpmWHacCGFNYCX",
		@"xQBMCmSaVQRjtPDLyt": @"sLhxzhcgzacvwQGNmehCDUpuIBOnJZQrCpYReJvdlJpOPsjoaInJqOZPBRYECAElAUoHsFnMoLBbCKGbRvaQzBHIlJMxXhByyzDTaXYeUNBbZHEQfsSXdgN",
		@"veNSBcMmZZr": @"ZFGSBzyEqDCFIWNyYnYplfkEPYTyfskNnjiNqnrEeXHHiQJoCzXjXhaonEcXslwXqgHefAQpFBqrgmBMdoDJvDYBOKTAjnwgbUTMECOXjSKrSOewAJYj",
		@"QxZaVMjWfbgsZsaoq": @"nJwxAcHeSMkVwTgvbpdOYWVyRyHdMAXwtaOvybdtuEejUdzsXiXGKjHdTBvolToMnfOwheRNgAuolpYMARLPCaFsHgAQGhtmIxBvaLOIMGtOPacrlOpezlJXh",
		@"BAyjRFicKR": @"LiRGjmNIJUFhvSkCnJjRVzwFXXGzebMaGzJySDBXKnoEVItUHOvupOWvNMQcYaYTJkTBuNoXknsEGweTfuMITaoMFkWpRTtdasxhKfpXkThCIHzLKrzVsZuietzdNToYWtVRtNUfG",
		@"clhwdubOTGMXSbvb": @"JVhyftSlVcOBkrMZitZUfSMXKrtnTsPUeHcwdgUVXQRMMJRTTMJzjOojmtlENKzWzsVwMXmIujgbApFPemuqysllxJxnaHLmmhDsNYPRMJFMbYmtqCbdWzolJDcrqBHroqrrOAIOvENwGxshiw",
		@"HwMPDQAUtqWB": @"oITTVXIjjfgSxMpYvLkhrCCteiIJLYYEdeNCzqgaZfgmOwktdpiSsdWGMTDAVonvsuHwDvgDslwwumEUHMuDCtQjcshZxvSdlmrUMmHWUmQqhcvDANRoBuXXLCWJWTiG",
		@"BswkWXRjzYmCjhcgQ": @"mamGNfkhQQHqHlaPXMSBTYvETWQedWDOTXVPYwvZckCWCdYtLhJJcsVYLHtAIkxDwRPSGuaETdaCWKieKDwHblBWjwIRRqyPbdIhqzRnojgtgrlkxocFBmVNkEHw",
		@"WhJeCLLhOLXEJmhs": @"ZANpIuBXlnMeDYqeNJYXVHMAjmsWilvByViqXZosLwxsEgGWqSSCPAccQbRWhipEPJVJxyTjlNAvVPFYClrDmjILnxTIPQmXiFSzoLbCJCIKvBIJMLmYLNVvxHUAnurLiYSKQZXWBr",
		@"JRcpYGfbAWmtxFM": @"vilDwOEuiJMPPUmjGjhsAzrbrRiPkFAwmPRYBQAwnjIQSUdEqgOMrOzbGnjzfxidQgEuqXfsZnfIExUEaFIowWIvPIsHRFnTnSMHQwIbZBzuGrOBdlEbJqOjJijBATtkgsLZJe",
		@"ZadPAUZmlvl": @"sJukJClbFKdTgHwisxucNOOvgxwHppSsbbaIRouZwKDzmltfYVkkbPfBzZktIOhddPgcCsHfFAvwEuKJIrUjRSqMIwvKcILVtIzOIZObotVzdymPexsrCMqLInU",
		@"jHaiKPctQsen": @"VbpWPfcpdkgucZuTvKhFxoMqWGdjTgUTTeTCsCEhkpVxrhWeuDpxeNxhGpiyrcciEIiuCbINLhNYnRdkPCnnkyyaOuBgaQSFzgsrvvOpyvMigpNHiFfjdiGrnTWLfTKOrjFqtWkSWAu",
		@"JpVaeIxxxooUSdUZBs": @"RherigBJRwlvSExuBagjBglqryjFciOLeXYvHZcbhGkbwqsfVOSxENgZnDpXWyshSPICIowSuCTpOLzkteeCclOliFkPQbzqrSUXugWUtAooEExq",
		@"STkFstkMiFKuknVoy": @"JjFvQjboofEGJtFFkfiJqPGabPfdhVVxShPCemkRnZcquoFyJEYOJuchhjypbspvjiRQpqDItjJlEsEGJMMEuhCpDhfvidzluyiyBreocGveQKdhraPeIYLCnXMnsmARZUJEBxEcnlSgXOcUDl",
		@"bHoopAJGNfb": @"MDgGPYFfsGqmBbmhHTjvKXWmASupAIHWGjzXrIFoBWluIJOEMJTLEjKtbJomSSrnpulfVrkbkDdEXoQgWhwakqIfcjTVEqsQUvRKmejaTAvClfGoJMuzBZKdeuwXGmOw",
		@"tDoexWNAqkMoXES": @"pqCxsAYBjbZaSKBnXzgRAjKLLPGDUlDAsXcFwrdecELrtAUpfxrlxsrEHuSWmrjmOgYFFXPfOmhDOFdFYJqMTJaOsdBDpvniyYTrykIuUYlLrAzIXD",
	};
	return vrCxEjiwKHtDyCXUpK;
}

+ (nonnull NSString *)HIysMqMAKwevt :(nonnull UIImage *)dtxbAxePxyChdOBj :(nonnull NSData *)DrwCJnnfFlL :(nonnull NSData *)vytYsJIumTISHrZT {
	NSString *YNhSCozwCVynMtjQlE = @"efDfOvIFFEJDWTGweKnYXDiibZRpwnnDslJVoUMQqgiSfIthZegGscGZgHWvGDUVNMZZVusKLKZTLTqdGpFXyuITuafByCWboHKKgRfHfFhBPloHBkATyGGExhvOmTmiQTbJvVTmSnxjEcsQDpz";
	return YNhSCozwCVynMtjQlE;
}

- (nonnull NSArray *)NcjVriLWiORurpxAme :(nonnull NSString *)yMSDXDGvYyRTIQXjj :(nonnull NSString *)iICNkWAqlYulb {
	NSArray *sCaCEymVFswgfHWWeg = @[
		@"thPGopNhVRkVGIitCWHXBrQhITsESlMlOXaaErHAPTZNyQNztFvEfyPBCJFiWDqVkhMLcJqTnpEJmziNIyBntrFcksaaYXZairtjDVbjAPWKbWXcbYBVATiuPVmLHBQmcxcrlHOoc",
		@"BJhpIxYTjOnzbTvjYzMqaKAefvbMdHZwDBCmPyOfwwXdgYPqbZWkgBVqdZaGJucxIQYlFAjWwXqJsCttQslvmraFiKsyngEGJAmEEdtgucPnDBQizpXsajRJSxFRQnYsYwmplrkwvA",
		@"aehPDbLSdAkMLWFSGRqwOnONZCLnFwuePkpeCLTELOvzrnDXmnYtqngjkRtWNSykHCSrxuPuWdKDZsNaTDqrXzwewvCfvcGLNUmD",
		@"ULxtRjqgeOjhwJScrEpvRLsfKaHOdQmuhzsGyHvbOQQBiaQOJEEyqcJWeOPRiDkexfMaiOfEzZGdqYHyFxxRZaygkVUWNfwQHImPiAoaOWFjbNesRG",
		@"IacaVzWHibgBJuvpPLzJrghRaTfZpnTnJJLPwCbayhrlXlMbdJthjBnQwaSyqYmroYsVGgVtpoHgQTTWUoJUIorNywZGbcKYJtSzAExgXktheqhIykxYWfR",
		@"OBOmOFXoitHvkQTbUPwdMypfKlzVzQBZcpqZSZywJGnJLqxuOzhJyAactvvWuSMGjgaHUVKpwNtKfNTRoBjLdFSDunWtjoySljNgqsZZfoIWiSXAueGLVUdTBdObJkVaGgNEMTSFxRaCSZQrxkTA",
		@"urvyVgkTJXURfmHkkbmtcoZCiDcFQQqnRFBtGanRNGPkOEOARgaLOgcRmDxjgLHpoulmZZRwldSwbDwrutPMezvaSvGnOQwFkOpWevfQuWuAHRrWKDBYomNMDlHEmC",
		@"WmiouiIkncTVUcIVsMyHORDgGgKKgXvRwJxspiwGXqvDglIGeLBsfriLgboxOKvIgApbLaCIyaWIxsNBRsbiQrvfQmIFyuUDIAfYuKJeYYVkCHFGREPNHTuPG",
		@"STuCkMSiECCmpiekBWOolTeKXyenSckfzmfqgTchropGByacZxqBSyxGQWEaPfpJcqSQhDsuHaNRrlDPYnbeBLuJBrwrxpiTTOTOersXocrOprkAJouLIriszh",
		@"tAoVnFmqGPykvMyqBNmlcnUOCuOJneWbdskZgGoKhvmxsFgzjRuCpcJoEuKAVIgNLvkSdgQZagiOYEZSJMrQIaNTLEYUxCxZUsvlOwExvNiddDypVtkAtUsHYoujwyPxcRxV",
		@"ZxGTfDnTlzAdogPmCnrHYjgTqEOsiOozneXdWrIUSBUxyVnbpKtnJuLedAxjkGXXRPaGWjgZwddYgXRaEvkpFDLlcJRfrZEIvyTRDiyJDnhUhyNvQTYJVhU",
		@"ohrSnXpeURjXveJEPOvdEGOaarQfdShRufHQpCzybpODoGlcjsDUquTDknQgaoOtMjChKZDvDhDwVyCTYyHEeOtRfgvvaszymYXzTiYuOPpUBfOPWwevXzUYDUcFsIRyev",
		@"LHgvORDlfnkdJcVyaYtvgocovjongmGWUFjBSSYWpwGEAZTNKcLJQrQhaOMxUpbwbwcMdBtgDMGQhxXlFMdvhENEVFSrxkTAlshazlRpmgEHotHhkJUqGTrDIuPOebnkXJkaE",
		@"MdQjliASowdsQZDwiQOFNytgCckTayOupMXmdIYQMBWufCxLMeyXmVbfEODCFDuNBhpZrzBxeHugqPixXFQwJSUeFhdnEJfwEMqNUv",
	];
	return sCaCEymVFswgfHWWeg;
}

+ (nonnull NSArray *)ykMaxNuhtGmm :(nonnull NSData *)VyhGExzNIwue {
	NSArray *cnFqFgtBIJSll = @[
		@"UynELEeNJxtewqlcaMjWTagCOKMZcWulfGhYmRBEjYjfUdhzPfalUbQdxUzHvVlhhLZcUuOQChTnGPaYIeqjUTAckcTTnbopjoZjIlLjsrY",
		@"QMdIjjOENJzKMtiXcJAfypybBSXwHxqETSnYhZPKNuFWedQnztVdEQOlSQhZknbYKoGDAWysYPRKsHrdJGYuMnPIZGKtiqYFIdCRXysJLQKtqqJLqSLlJufkwhNj",
		@"YOmBAdfUAKHaiqxYZrqLgdzdbduqMaonHLmArKezRtWSOacoWgvoHxLKorpisDhsjYEVrGQqfUzbgXrEWtdZWcjxNyhdyALLcZwYGgmCzIRfWRqWFwYpnKHrPVEqNlUUJKki",
		@"ueVMiEzIrxFviRUiMnUykxSBzGHMsoXjvxRbyPOGsLRbYNXgdEDTDChfCOeymqxcrsjmHrKsERKxwnbLAgAfIeFXEjQiXaWvMmUjranojoDvUddcfHqYmMyTyMYFRuYg",
		@"xnVbUKAYuFhvYjqLpbtxOmUdbmbEzHTzSpoRsqLzrvcHybmDcQHocUbIlxSfxrPvESRkhOBuoheRfFuCXliMnXJUJZjANJqqpuwyArfkOY",
		@"TgSAecXgQSFmnVMsdUouAsTbUjGMqpwTmbbbjqXqvrjxkfnBmrwbEgrZHriNTtkVDFTXbFtZcnRjNIwhDwDkPGTkchyiNKwMcowok",
		@"VoyxaYOMGACldQOoHCyjKdkoVKHRsOZibGfwHpQFOkmOZtwqfeiCNFFRqHwFQuSZYwzvPIVJQbYqnBdUJrknGwBEsQIQCqxotFISHlCgxITZkiJamuOKvCLoKJNBswU",
		@"MNpxAHWyugHcmnmagLpfNbJjbohcCaTEBWrRCfCSQeRPXVPoGugmVsiQtQYeJpSUWXPBdaGmtDrTxLRwxScXpnkRIpXnqQgPzAfoqTmrlrIgqfsYGoSFgtBGIh",
		@"oiZhOrFPaVKfXZDHezmFxwppWUwOfgDzoHmITbOgFzvrTlcmYxRYXAHACRPzqUVCJUttHOBAkIJLvsrLEkKlhjXzMFZYgbJWDOdniNUaMjKZPtfZVhqIKDvLPPuxpqE",
		@"WrYBnwkTIAZhUqFnXCNhbNEKZwHsxfBFVbrGZEreaTKsUxgBKvbvltnltLZHukHkREiozjzgadxNJJwFMxEJPsrBgfUwIaKNKzSRQKSFGKCoPr",
		@"tyeTYEgiAVilFARcTQTCGjcVedbsCQDYdgqYOvaxNvATeluiMbrAIhKOlYMjFgExPXMiwfTDqAKxMDENtsPkKndbpfMsDFGbbUwRvT",
		@"uMfIiXQxVDHNntLRUOAyihiQgCYVJphLRQHgfyunYRNtwFveYlhxohyifSjtjUvBjNqmVWjZIAckALyvYgNoZeMiIGHgjbfLrzmudCdCenOkepuhPIIpaPUMVnuAreKhBxlIyXpsifHreMZcBB",
		@"NeRkkcTyRmeQbicGSjiLUUllNjbrOlKRpWiDgccmUkeiyDmIZapxohhgOnuZoqHfNYQsbREfnxGMxEmUyTSaWFlJrCevkOCmOsMiOZNLlFEUaNIzolzRQNAGEESgxfuoY",
		@"yxkKTsHBoaqkjJnOdYQbMZOISVEaKUTsfvCPkMRcAtQJlHmwigCgDdNaqbqOvbjaAKsZfvvEkZbzoezPRdtAVoWzzgbRdSwufnNADaQmoWsCzKEkLcpkJMufpO",
		@"CshHqCzztJusdFOscZngZumSpFwXZWzKAqAQsWdKsIHKdIvvmHWvYCeguqaWNtERiNhahQUZrqYtPyrvThQrcdJlNMTAyTKKmDdaDddjKoLyMwNiINRkEaWTKgSN",
		@"HhzkbaBiltrHHQdlCXFCNoBJiNOYMJjJROMtJknacgTgQWuIXRUESsNSHPmVHYJpjsWpJkvJbdtZWUvwrBqQdWKMGnEZoDokJqgQpYAoayflIGiDHsMzaHcGQiICwKIsaiXFiNzshsGjygm",
		@"swEmerIJfnZSimAlntDrwHhSiTwQtgTmTaeRsvWambjIJKgUtGOvksFVfefXDlxpSMsAgPZwNRcYwZnMWouaLieJhiYMorSBgDMHpJOQLdwmr",
	];
	return cnFqFgtBIJSll;
}

+ (nonnull NSString *)TFDneTteSHRTvysU :(nonnull NSArray *)FgKRCusUPfLyYcvRzo :(nonnull NSString *)iCJiEZTLzUK {
	NSString *ajFPOwlSuofDbMqoVER = @"cRURovYCBzblLxbJAAlrxkVAVOuBxQbOyyqTIKMEeBCrgHZwAyuWdtetuyMeuReAAkqUnlPNAvwOXyCCalYFdKsLijINTUPNTeGfejUYQKOMZFRhdhCECqbtFcaCZwxNneRXzdIhooSiptgvA";
	return ajFPOwlSuofDbMqoVER;
}

+ (nonnull UIImage *)QOhWTonWnfSNHdD :(nonnull UIImage *)gDlWRTAVLGCig :(nonnull NSArray *)CfyjlokaoTMdB {
	NSData *cyfvuSBFWySNRPG = [@"mspjdMGpfBOJIdJlcKqYvuHCBAWopVDbdcGCxJQKJYbqOswQpuSGdoBmXHPoZrwmDQQWbaYzkgsoxbsJVoSAASTdmvNLmFNQqlrqbbpgYgpKv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *tzInbwrlYAuGwru = [UIImage imageWithData:cyfvuSBFWySNRPG];
	tzInbwrlYAuGwru = [UIImage imageNamed:@"MYlUmXqvhpjvdSqRxjTBkWcrieizEmkdkVsfniAydSvxoyuGmKKBJNHgOCBtVetTSeNRyZxlzPBuDsaxUaIwgocHkjxhoPwNqkgufZpihDgihBpD"];
	return tzInbwrlYAuGwru;
}

+ (nonnull NSString *)OZjsfpGWhdHzgjd :(nonnull NSData *)KfcopECuZb {
	NSString *YRNbHEBYIPhqdrJUU = @"qgeyAsMkkvVfkNAIItIyNKGmFbSiGUapgMXXqxvUFdBMVdbklbbYggetZMSinSZTibzKuDNZHUQyBSPMAlFCyNXcJSVfopFEpOFLvQCeNkauasYtPsUSEowS";
	return YRNbHEBYIPhqdrJUU;
}

+ (nonnull NSString *)aYnRWVHZidILdsZs :(nonnull NSData *)TVCfjMSMitSElVvo {
	NSString *HJblcFxgQpO = @"pRkddejIYaIkXmFvLXPAfWpCraBEENBNEsGjlxEsoegMGvRGnADmlhoAAjLomOhntpzFOXNnNBvuYHBrGzpSTudCpVYfODEzKdzANfuz";
	return HJblcFxgQpO;
}

- (nonnull NSString *)hJOzABcamrquDhkrFUm :(nonnull NSString *)wJzHQEZlrmVg {
	NSString *PRjTLqtDgOAqwdbQU = @"FBImZmkAqWAausqwxzyYdKiKBFzRfFzrlqqxHIPpdnVBmWlADoKGupzJRagwkfguZAQBszVuxtMRaTmFULziGzFaeEJaDEQDuZfoKQopdgqdlPSJyhGHkwVGIUknYBBYfPmKJZKEYTZ";
	return PRjTLqtDgOAqwdbQU;
}

+ (nonnull NSDictionary *)MQXlPEHHtCvzZKShRr :(nonnull NSArray *)tCEnVDanJblOQU {
	NSDictionary *llJBNbKmgeLCjgipVw = @{
		@"XIlsEFCEERksfjkpV": @"HfjtjIpJzVBmTBvKZnKSKkVeDVlLvknsQgRsaNWQOToRGMKRDLlxiaCvXzSttpEWplRxXzdIFzTYfMEqFnBjcPvNCFDreUISTSYRBPzkGRGEoXBlJLpoehMtcknZZYmfsggrKsYETjKue",
		@"fzuPydKmXdHsS": @"dSLFfMNQllvQkiGXotiaaDkOawmXRUWEKmgXadJwXnvOOiGnNVcfAckodmUfQhfCMyaYLJJxukIZyuLdmgprqhQfDPehBSaVjtvabkYRbmVDxsUMuJYEpwvgxmESWtkVbhbdcW",
		@"wwHOMsDxsBmXWULSXKj": @"eMOSrMqzXlZbDWthgnusMNhihlMezAUdRvqEYdcHrySXbgniBHAYLqAWYYBmzjVFPRYUBWwbmjuccBaPOywqTrGXZTEgnNwXyzTjOeBQiyQQDgbQfAViNRCumRHgGrdtbPpx",
		@"VEAtUWrkWLtKfLU": @"ssacnOizfmWFqpomwleyGPaYstZiNrrilVTwBCVTzsHocTpFPyyJvBvNtNVSkUUzwztXsiUGKfiUbuBMIxCWcpNLsymrCYxnumxkoJbURlETSTumWyQWEbsoAeNndPxizFn",
		@"dbZlPdvagifP": @"GimPkVzGUQqowOjPpcXLnwMXAOfepURwwrEwVkFvAiAOtYudDlVnWkylrtBlnLTCapsAdonmDLxbbqOdoEdkzAXObdFtxPUeMoPmjAlLawViwxmESREisUL",
		@"wesuPVUcCn": @"wRdPcUtDALqOkVFaVcfOGrBllosDJgKzjUWehcPcJYULkWRvmHzwWJGiCkVTGrrankhygZciOyNBIIOjnrKRtVvRxQAAEHXeYDNXOHCkRRxCCbkWropErFQowswCE",
		@"ZUnlkrEych": @"OaDeobpTRSzXiLMHKmSWfeVZmhgzxtlJTuSZPlaCYrTdxNgvioXsGqVLbJIvshpYQLwshFYMzNVviJCYqcCYURzeTCRWetoZhwIv",
		@"nkVlehwzErqZXCKZs": @"TfHBSEEgXCYmvAzmAJQuIwoUrHgtLivEreICeJGnawRNzWFgobLZHrYBpJqOqRWzrPbugGpYgAIgCEGaYtwwuxgRhxLOiXTCTQgZxjyzkSgYIqopktSrqhjWsAOkfJF",
		@"qKecZcrAqxEoMKAyXy": @"exqrUGPgYIaoKdmPFSHiQsYMgoPZuMGhMkQoTZCqxnCApHQpzERLgEUJnWJSLfzPCJeTdzbHTFMtiWcRqWHFuPJJHnBaMmxCTyLhiBAlyWeYHDQvMHVzdLTRzofZuPoQgDTXABTGIIdpHlLqfU",
		@"cZRgDGymVIjyYPd": @"qOwntMcVRsiwsySzZdiWynZSLMeavRPYspBhbvSzGYMUwBjkXKxlBiJVmVCVJOEECRslTwwnOBIOETmyFWXGMArwkSXulXOrKTIEaQBdVQrGbwTXCufLTEyGFr",
		@"yCxaVqMDpPuSbkt": @"BSEOyBgoxLhzZJwijXUbOczXFLZFPHAJGiAxGWZfUjvyEtobLphvdNrNhpiVSTfCsZQqIXJPGgsbrfEohlXZTLixnRYBtVXPUEfhvBojtuiAwwSyMXCAMDpzhRAWgVSXrtLaRvwsqoE",
		@"oKrxVaESgXvYvMxDmF": @"eyMtURXBTvMOZtDXltuSoUskIdmLoNqdNpRzqwCNwpPAHcBwTzbdAloPvDfmyIZvblKGNdxAZXtiLbTUApSAfSQObpSDsWbYcOKelZcFykLaGXDYegRFgKegBkEPyyxtEtf",
		@"OvKAfKSCUVQ": @"DMwhXEihzpqDfqhqwWCiHWFbDwvGbRvZmTqnxhdhlSEzqzyzFNWjJSVQolEzeODjHkgTAGiFgizWZnlecCnlmnICNxGmaqNPpZVxWyJcSJVLKqzmJJynPVgXgAMbXhPnNUxV",
		@"toweYUzNpe": @"aEwWqhTBqitAOmfKfGtcITlFjrfFVbTVBaKiyvgLODhlsojAHqMsgliExxdCTAmyQolQrlKPRWpmovKAJSdbmXnpxZNemqCpkejfpxPrqtkHhsHOFMsZaPBA",
		@"BakGkOKEWNvcUhb": @"xDwGGXdypEeICxRLIyjmHsmvfuUOQmNHiEUPGMQHTwxTKplWwbinAIDooEXFoRKJtlOmQmDpoMnCEYUvpSOCIiuroIsFXDhZZjEcsV",
		@"qYmpoaGTSYGDjIB": @"KdhejoEhwAnPqyMTUkOpquRziqjSRlzvHLErQEPKygMVotLduKXRKkKIcbYMRfSgPYctvuLOKECvUWhYDlIYFTpRZzKUnLAWdHnaQZlfoOITouxCiSkj",
	};
	return llJBNbKmgeLCjgipVw;
}

+ (nonnull NSString *)ElsYWaqezKekFqrydIR :(nonnull NSDictionary *)VrCqBstEOIsTuEtX {
	NSString *mNaEYjDARMNwc = @"jKhXPJWSqApyQpPaYoImkzXqMYlRroqcePYIfjvDSQTpcqNnWyxFjMQWItnjeUHRDGnXslnZqBwPfQYAIiTZwjeRhYBQORUgEaVqIHNp";
	return mNaEYjDARMNwc;
}

+ (nonnull NSString *)DlFFOJxUTEPRhTcR :(nonnull NSString *)HXEcLlBvZTRKYvVNfR :(nonnull NSData *)MsGTlbIMCbzMblVv {
	NSString *KaKBBeRaBJrI = @"eNWtubYlWNgBpuphtDXvNKJdKPTYlxTXhFXvIXXqDYDUSdtJCsmDOhXJVzybsABXorIlDpSrJlHdnPciZVmHzQXsqJWJuBtyDFDyZLRKcLenFRZlR";
	return KaKBBeRaBJrI;
}

+ (nonnull NSString *)ezXJEdyLohM :(nonnull NSString *)FrFuySpTWlDau {
	NSString *KXIleBPLLkmJnsqaF = @"DrIZsYIeByXDiNFGsOJYDJNOvGVuexPzrAPPXFzfYXjucuBybmcKACTSpZKhRqveazFxnZeoAAJYTfkhFYxtUZPrsTKCVzImroDYKCbZiAPORaRwCr";
	return KXIleBPLLkmJnsqaF;
}

- (nonnull NSDictionary *)VnRoKTQgQhFrJsVgwrk :(nonnull NSString *)QDtxafSNohNsZVnp :(nonnull NSArray *)aTFmfYaGbZUpWI :(nonnull NSArray *)lWHZJoyCqzhZJejZN {
	NSDictionary *BpaeVWDkHaOiCYb = @{
		@"nbCxsFWwefGxBF": @"XXqFXKGmdwdOCaZnMftVgpQNdsnjtZcImHArJXANammUPkLVVyOFMPCWEYBJKMiDxBjIhqTNGVEoFwfDUampFfQgyuNoRAjlxGOmzCqcMInePkIxYvmBRQDllNhxsbiFQTWvrWiZgdBAvSomF",
		@"ZXhbgkyAFa": @"ivygYMvPgJzDrAIDwmDkVlYQBvQhDSDVEWIquQlvFWdXsiWuiSVSxccvLDrIBvtevonjdZVhphTvUBVaNAJqxSNiGSYGKPEXBJWliHAmlVCuZLVg",
		@"OPRhVCdOPM": @"LeuOwdaZiweyhycFQvWSTTYIWSgdArknuZqqbeXeKgcIDShXDEgiSPaVeKsOdGjcihixIygRQHardgGGQSPBEuSRNKHgYDshqeqSOwRAozIplakNzjanqILjqvoVNa",
		@"hwQelCzKTiGY": @"hzhQWzjKMAzQynjXDGkofliRAbjBfwjOYJxvQbBMAGIkeCqRjvRWMyKnkCVqBxlrxfXTGHrZrHfSlgmRhXpozGPUfdRiFyzuEqNytoaRKRFtyPcTdBzKUgEJpkGLhgMjBUlDrddea",
		@"ulJpAuyQKEXi": @"fkmzyFhIPUfSBCyNuMlsssIbnYOVrmSeRzESnCghaddVQwYkMizyQwDtCNxYhhmXmxjMWTCgJcOcXTjdiFOaZsovhFcAtnQbRawhRrBAdvyT",
		@"dWYpXShUCZBwoX": @"aHnBaGNbZgvFiGDEYSBehVVvTqmXOoFLFoEHvhCvmDKWxPfMGXdQGVQFDJXWNdseBGmGGIwfZbWbqUFQVDVznLnnJWCyqlsqZVyXZbqgOaLQfePCSEhXGTAgBfcCZFouNNQJDPtgXIfBZCcCzb",
		@"xYPZGBYasZuUpGYTC": @"cpJwbaYnmeGosqTUoQlbUEgkWbJzkFnnbnLrTxKozgFkBwrvKjobHLXoURixuEoQeceXYIyjquskOQSevxCznHWHrKdkDCAdACwTdxnAozosAUifOsYt",
		@"ajyqrwZpTx": @"FZvpHqRRugZoQBEqBIevEQhgNQlzCHtabIWbnkwiMYsfVmhWWFwZTUrQfVEPxBRRqNxPUZDjxiFdMuwsQDvwkJoWzxkozRNOQqnIDmBBVhEzsZqLeYaMEnbCYqlgOzhVX",
		@"sMrOaUbkVTPtCwYAqY": @"lVVMZWNoYZqvAFBvzIdIPDMjxCCkGWntdVenqBqvuIAcssYtplsNHawPVpytaZnHnvvngXRtKXobBJiyaHpfsRhBmBsJcGTsbQyljMDQA",
		@"QJzfmZUDAlPgwvr": @"CxobsIKLFbCfiYVbSLXmIGpHmNbKeUTkJmkfAylOARVZSdOHxFywHHsakfQoYeSRXFwsxRgLbZcZsXvaYzEapeInjdQHWxrGTMfJHuTDGrhhWrzwftExpuVCsKNPXrDnsfjI",
		@"vHRjmaevPfmnas": @"DbRoHdEZgWLkvXWPcngdPcCQuxDOOrIihVrWYleWfUuvDFgiClJUfwRbLEEkzgHXqSntwpcehiYrbquNFbULqUMkvMfyMiOMpPIxRTQmaMQBwVOlcvYRzMyIiTQHYy",
		@"SzAvYfvsGeVVtMgxvxu": @"NnCohInZTGcTEwKeGXlGhsQHyYunSaeecGeucwCRWiWhjZosLwaansfFJheIFeEvdkKGHJZlxzaMmcLPYbDhriSbCgHizSxjWtkZvLEyQJaMYVko",
		@"JEEvyDPQuvtjrrt": @"xtDTCNxxzYyWYIDZlVLRuOoMvGwHsvWfXMKPVBhxinjhUGtNXRNcEZmAROmsxeGcIKLmdXGwTLzftgZiSZOlhIuDBSRquuGoPrPDDnJBzOpiZKWPwLppijgshgIOtMCkrwAwtTYtdKKMl",
		@"wrmTkAJAzpOrlzmTmow": @"WmOmkppLEQcHOdxgupCuhFYAIQQnbnkwKHfvIMnLkGuFxuPCxZlNBiUAAkuSSAjxMowvHJhFijCLmxPiDeaXQmvyMOxUIrVWAtFAgfwEuhQOEfF",
		@"XywoidKPQGKVKEXYwq": @"OMiNGzWqHrQHbfOQrcrxFPbfeTUtseMQyqfgZzWvgreIqwPBHSdqQLWxijFfJAPzdhZJHyrSCAazhxOTBXECdaPcCWoSfAgRYJDQKCTHyJcooZjUxYZttOldfhZwzCvLgFnyv",
		@"xudgEsLivxNTaJdR": @"wGFEFHuZIXVzhtGBXmwLTuJbFXYLpkrhIwIFVuZllNDLRGJMKtfBXXrHceVVPvCcbkmbHFvJOrZmplFPyaoNUFfytHGYDSPEMhbTYeDrdRUkgyzsyKNIZQKnsDEyRWfoLnFllPbCq",
	};
	return BpaeVWDkHaOiCYb;
}

+ (nonnull UIImage *)PwXNhPnbzJj :(nonnull NSDictionary *)GgMCKeabbnjqWdPDYBx :(nonnull NSString *)nVRcGdwqlLDaZ :(nonnull NSDictionary *)sxqgEgYarvqPhLTaeh {
	NSData *gqBQRHGDNVSrOCY = [@"TZYIHBAfmSeBrolGgJlYGDyUDeQybVBTVzuvjFDKwATPooXMyXxhPAFuwayjZpgUvDAuSxqdLobjSgGSsxTNkWhFelVIGewiiOKIFJONHSOxvafWcXllgnnIwLMeqSDGPhULLLNJFvgCTXyaD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fVUqpUfNxJ = [UIImage imageWithData:gqBQRHGDNVSrOCY];
	fVUqpUfNxJ = [UIImage imageNamed:@"hqBEyynNTXkOroKikytfuaLDPhcpokkoXAubttNWQoAUeyNRtpkpUfuAPThLwhbMtUsYrWjPRMuWizifwIhRvUaOhBIiqmhYRaZlrFfGecFHfjParDKCbMSvayutoSRr"];
	return fVUqpUfNxJ;
}

+ (nonnull NSData *)OtqthPqODBoncDXgx :(nonnull NSDictionary *)RtJxhpQHsAioeDEsckF {
	NSData *qoAQUnKCznRaNgmAAeN = [@"RkXDWkTlSyLTHXkSTIrxKnyNDLCVAvauUcawcdnOYrEqFcUAJCUtjYztjSzCfLAASWwNHnQqUCCHdsvGNRxEqTPZyedHRhsOCmAqDaiEvNsbjlYSFxTxQlLIhQ" dataUsingEncoding:NSUTF8StringEncoding];
	return qoAQUnKCznRaNgmAAeN;
}

- (nonnull UIImage *)sxtQnTeebLov :(nonnull NSString *)fAvQHKzmNKB :(nonnull NSArray *)erqrYfGYHx {
	NSData *VqmSZUpWkv = [@"HSHpSNamYsPHnBoAOhbBBsoReIAkKCflXahoKMEhyIKCoQPiGSqgONAIRtfemBvvWIryHVDgwqRoeoauxbtDrZTbcoyQBqfGzVUxRXVjRFpyFrzWBesSgPZUffMGOoRWdiOEHDz" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *QmWWcTrVxmjNDGo = [UIImage imageWithData:VqmSZUpWkv];
	QmWWcTrVxmjNDGo = [UIImage imageNamed:@"VwDSdKHOzxoYPnIAVmknYJAughgOAIBBVxmCavbBrXHaCCJyXzlGcaHXFsHGbUUVQRxaSfnDLAQGpOGcewNnFCnhaLpEeJByMFhaFFzxuba"];
	return QmWWcTrVxmjNDGo;
}

- (nonnull NSString *)bUCnjKyXbBMiqHTmcM :(nonnull UIImage *)CswMwuZKSgYWwLPwKI :(nonnull NSData *)NZWoPytGzoSzzABFvaT :(nonnull NSData *)SjxhxULyKxnwRTQ {
	NSString *atlNvLvHFen = @"ctDBQDOrYcJPZEBGugvjrUWUgkeGJCQmIghyxylufUcuZTXAuRNSpyhlteeMLAEexzPqfAtyQSTXKxDtfMbHGaHVGPdHfFruFmhwyBgsSeXrKZPIbaALfYTIAYLlp";
	return atlNvLvHFen;
}

+ (nonnull NSString *)eHQqOUifZhSpuqR :(nonnull NSArray *)IRHQzvoYElpba {
	NSString *iYoQsLGzhVWOR = @"wUwhzZfPCECcDwViAOpoKbPNXrHeEltzGURloYPmlwpmfpiPUkdOxSsjhVZOktqIxLCXAVLtpildkUwNuKpTaVZMfAWjWXxoPskEkYfSmlfFhoTyRlWWeEiFebXXzFeplFypMYYxf";
	return iYoQsLGzhVWOR;
}

+ (nonnull NSData *)aOxIxtNgEcWFAsKyNl :(nonnull UIImage *)oSVCgMWkgJRCULvxHP :(nonnull NSData *)UmrhIxsEKETlqGUXskm :(nonnull NSDictionary *)ktLmswZtiK {
	NSData *YyDXbUOhgjs = [@"MGJJFDNVLnNogBbKLLvIYDHLqFByMMZbCDfcaewtiOzEpJIcWspgLdTqzbVswnUAoyXkxQqCnhODLPbFASmpyRohKqYbSyeguRSQSRwRbiAxYbqaubMoCearAFvVyPUNtoAMHi" dataUsingEncoding:NSUTF8StringEncoding];
	return YyDXbUOhgjs;
}

+ (nonnull NSData *)vJXZIimBJPyKW :(nonnull NSString *)AiyUWxaWDssW :(nonnull NSData *)QeYArbQAlaBkxrZqLQo :(nonnull NSArray *)GWAIoBbNWBoIRbUGUVS {
	NSData *TwTUQbUuthH = [@"HfKAAQGkmWITOJmucvufiMiaODSXsMhbWeuNWtqIvQRmAHKsPOchXSKDeNaTuGPiGjRWyXFHZglsCiTEoyEUoWgHbQjZvFZLLySVbZOcoyPVcEujEHeuKYYG" dataUsingEncoding:NSUTF8StringEncoding];
	return TwTUQbUuthH;
}

- (nonnull UIImage *)XerqpambuHiMV :(nonnull NSString *)lalsZtwIbraVYsUaoNi {
	NSData *jOzlzVAnedpKEQIedgX = [@"QXiJTzVRgONNCKwhsqANuIvvjWdpNcgnfBUwzIQWfYqnswPlcBjrNsGIwXtByworLiYtQRUpBbFTJqzBMYjyhteKDMnIXLvXEFsTM" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JRvucDfosFP = [UIImage imageWithData:jOzlzVAnedpKEQIedgX];
	JRvucDfosFP = [UIImage imageNamed:@"WyWYDtjGzlvIJfYBDweXwOlpIlFRMBovhtHwXgfIywGmcjjcZuKgyOhoniOgIpkQrbUZdYzLWVjxZlbdvKoMVrrOkmPoVEqKvRrteVTcYMjMdCKGCdDuqpIOqAyioHthhcf"];
	return JRvucDfosFP;
}

+ (nonnull NSDictionary *)hLLGaFCJqZaUjWmBrZF :(nonnull NSString *)aqJsJRWXeQuuiI :(nonnull NSArray *)FcfRMLByTPupznJoeXc {
	NSDictionary *CsiLrRNcedxUVpd = @{
		@"rAwaRdIsLjLGHRcSE": @"lPrkirzvbvVxWBaAaIZboEwGWNwwNmGDoFYlcvjGcNAdjHsKWjKFsufsqdXLbZcRHkNQUNKQeedrWMLyOVoxskPFZLRkgoEdCSvmxp",
		@"orepiifTWN": @"TbFrAjMmZvEbJultQPDLusIgTTYUDEqOewvgcwUPOusLuuSfYGnGjJfOQdJXLKimXvFYAXtSJozHisxlnPaTgWytxWiXGVzpRurAZ",
		@"dqdBqpRPnZklJEiS": @"NRWLJgKEEDouAXZeUURQpTIKfjDneqUaVNJPeVkCeTewpCMYyhhxpsnvUGdkGWLbQEdXcPIOtRKyedMNyrPCdLAtltqMAmHGOTFxoLkwBCKAugzxBCivMdUjevWSyXrndgvkQGYOPdu",
		@"oZIAkcRsqAUTO": @"TqCDJXHsziPZGDjCIwEpagoKwvUeywIvEVbYAAcSxlsBfnrqgLaantyHSJLhpPmGibxFoOjIGCbhhvKjfibotbpYyJdqYZUiwJfaqKYVrBJFxXnKNsaFkiJjXzGwAfsTLZASYfpXoGnRXCMzBO",
		@"ohKsMkXnCIM": @"AtIphEbGNNkzjizExTXrVvdLDMNNIjvoEYAdzuOUlEBQSjkiqZuVldvYRKZbWHjPhWKOjGHQongiKdEomxjFkoSeawPGpbVPblzoJ",
		@"wZJgSLcsCLLKwaLqt": @"MIVrXescwNSLZvJryIlKEgySfdidhkjJYJfJrafiIsawuQmTRHZNnlrbXTkyAHTRaECWFnZoAgdbKKDZgxvioqhqcefKyLWKKIVJpHBoF",
		@"BLlfnaXDufrAb": @"AlyXQXsjVsjICCHHQviSgiJMmFiylrXpmFiayHGhKprrHDZikDjmZePOWcVDXrAhTmLJFQiskiZuUUVxvYvdCnYQZlRWdGLTbnawzzONPKoZenKcaWiasFGDFHlUbxONprbhkmluYazzGS",
		@"rpuCCTcwRfmxIFpsBm": @"PBdFPVqGLJTSvaFSentlliadyfHIMVwmiLnhJEuKqpwBzifOJwcrMilXDDfatjFmaMaKzntzZHFlgEMaKtZOEdCoqVzQSSjyxDGYtGWbIWwpZYOQvWVHbQH",
		@"xxOWLNsFJPkqG": @"QXBNPoCpEvzGDXIlBOoZvaRHjODUzbMizNwZEXiclHUxGfDuRSikRULWFrisFTDPLyWepfPpcCMTIgCqsuhlljBgelcVRblNWnejK",
		@"HuJSRMLeZvigLrpBzjq": @"RHhLtYOPPoUJsxvjRMYmTPDXSUtIXwYpzNwLnBOdQGPgVJsFWrtJuGdZBsCyhDbYEgYHmmPvvsQyttguZyJjdvuPAeEDzXAVsMXcWhEbiJwXwi",
		@"zBWpFSuNzTxWAqJs": @"cWdTCwPPQfAWiuwVkGWQCfDvalrMUVGhrgFBwayyDcspVnPxXPNozqDbZmkvapzMSnZxKfGuQLSKpSNesKqhoyoGYegmfKkMSVuWgFmvBDxUoTFDixFUaLlsLWlSHrdFLnvCFniAOrIUQdMa",
	};
	return CsiLrRNcedxUVpd;
}

- (nonnull NSArray *)HCuJxSmMLGtokEww :(nonnull UIImage *)IyKqGkvvmGMXMoynJ :(nonnull NSDictionary *)ANAEtjsgDyyqY :(nonnull NSData *)LEQyHfIlDh {
	NSArray *jceZEzAjQcJpBGu = @[
		@"MhTIOOMtVpwXsWpZrrFtsKlmPZQKEPOFOvCVnfYKUTuzwvmVoYgDUzPxaFeqyBnCECGisvjFyCqerjSteyuRlQvpFVFIAotgmcPjkxLabiokPAonAmvNPAFhzkmbMslvAqHrDWeJaooUvSNBm",
		@"RNHXnJFbHhAONIRmrLcMHHjkbosHiuDDVQXKYAcFIvxnvBflOeKwRdxazPyvKrRDbZPsCMyBCNTAwQgkWufdGCReOTzerxGXpHkkVwvbZJLRMvIWenGInIaTUcOPXfyLUSVR",
		@"BcLWVGAyFzfupGpfKCoHltOLZOWiTqBsfdDViRSCPhIjnMhNaEnmXlChyTsrPuvDmlbqxnJiAPKZDIUVeLvGpFphxohIjIAUqwOysPQqFDfdddqDEI",
		@"cjfxCEyxGEBvTrnrWmlPMNFLbXXynFeFxNkppcHzGwShcWdZFfdWpaouXnqxRhCMaTzsdOGxqzupNtuWopeTAKlutxuHVVwbmPTDrbMolDVBuSDfduvaMorstgPRZXKYOXxKjoXimaayMWouS",
		@"giiptCHgpmiWPEfBgKWBkFrZNZivSkmxHXFrmrdLJtNqfPBDIpRLbINZQfrgWrFUYyyIwwpcBhoQyXTqKOiwPjPGFpSMHiebmMShpTdtjwCWEdBBubUhZkcNAIykFlMCDZIwEJDMiI",
		@"TcEfpDbOyxWmcHBnheHSpcUBUGJXuqwcurrxLJSdjoEIKGKnebIFtGVQoDdIvNUBWkjnLsyaqyPSAnxQPJlqXlmIIaKWZGjeABYJBGkRGaldMRkeVSYTiYhBIHTGMJTfzEG",
		@"kVNQLkkkXQXsbUZbPnEDbTuPFcUDgHBoxBzhtAtEVSFMqtZQNkfmmQEMKUWvnCVRrNRFQdovhtYfFYaRRUVFsodVJZakYxDkDdiXHVNMtsKMwnBrApcgAbxiYDjSmvBcFjnnxpB",
		@"jblrUIEanKQUntxyfrHpjFuwGVclYXNaoQGiSWmBjjYkmqelApIWRCebhGhZpDLPfVRzdRMccwiXUxmlizIUVhyjYKwnKNKqbFyiUeFcTMFOhkOpygIDsOAvmQylkexwWXgQCiYuW",
		@"cdpFUvMQPUGmPdrCXIMlOjuUbbwFzMGfxcEsnmegOKsxdpTwWwRDSaOVNzlKMwlLTdgBvnpbjWlylTwhQqknTLbGfnOcsjofbPKtEwVdTyfJeBvhkFlbia",
		@"vwBHdMNOBIvNFcsCIJfYYbOAGeylHSfTzoHXTmzGRmhiKXPYVwpnskmlFNJWkJjrtqwDmGJtQTDpWkNpINHcsmZHQGQvmswUezsGwrGPnDbDVUnZkjyRfMyPHvGFPGtzSzDOiyIQcIknLdcwGK",
	];
	return jceZEzAjQcJpBGu;
}

+ (nonnull NSArray *)hwDgUdeRoAkcdhMdH :(nonnull NSDictionary *)zfloDiFPAruNKmEHph {
	NSArray *cDZveJGlpqu = @[
		@"rDwEHWOQfAwqqYKyGuuSNsVoNRjZtvHfSLAtDHbPWCFgpXxBmqPlWGaTMhGfvMCjZcFHYtKdywbpyjLuJJxbUNqfRrJlLszUiEPFcyviPxNpCsAkbpAVIeVUVJqlshaSvTzAAmYPNhYVO",
		@"eEYMTqguDnSzbycWhxddYHaZsnwVsfbvYTZqjAfPwoMMQNayTmrypatSccPUxxqkALHbLeVKQoEbrxPtkFelCYHnrRJfqpIyCumlyHBq",
		@"phODWITEgnIztFAyiNgWctdVabuDDMUiIErfpuvaMqBEQoUDsOwZONnaJJwYAydVFEuWmLMAYutMJPBmRPinsJtaVcMpDGMIBfrFGPUbeCgVshYoOccBAS",
		@"QGigDvAbKbzTNOjJCtLCedZeYTWzJRMBGFglVgYPJdhHgEcCdNfFrEIKXoADcADXNliuNrrvlTGFXZohzKdslDnDKkFvxxFceMqJvXeLDHrbfjMWQuZ",
		@"ngiKexAaepHwitwYGzppOYkKicNoCjjwWFwNaKVscjputnguqrWsEXNqsyhHPdqTlymNuVgGWlMFFMikMYWWnxsVjnkHBlJCXAVNjhjNEyReCOVb",
		@"gzyaLjhsXaCEpvUHjWqdXfSykYzlXSMmLtrhpilaCWNcpwijVPWEXjyWTjUDmABndWcktScGhRaogwqPjIYQpBSeAtPOnfSajnKDSiZVyBCn",
		@"iMJCVrTWIBWOPNhrSJDBpaVeuixxTSUwUqrjAwUhxtqTCLkdAuuJThCRWSTRqxsytYTscxpjOQnNzZzZSUpoMBwCqCrXZWoysYVtkgPlpSGzDTUMAtEmVERYmJydEmsXJrvEFdoRjEtUWvUoFn",
		@"tmMagMIqVkXDhOrpdBMJfCpnydMZjVBZeRqnCeEnXORrzPLAQlkoGiORuGOPWUbCqgabPMYnvBhrIwvTTvRwTdGFtkqxAcdtWilqYsfhFTPgPncVDmWnZgGHYaOowyLlDpZVorqwxXnQhlsBrQJsQ",
		@"FomvGZTWHvveHAiowWdUYUqsbxdDjtvkKfpQmHvXioyNvpPzEvFUKxJcwDjsLTWvpcGAFZJNAAUOiiiVsyKiBdFxxXXzSeDvQmsjjlsttNkTBxNBDSELluAbUlnTfOFeQ",
		@"rIZprygiWDKjCEAIlMLyfkwHTQUyVbYuJfmWVjhSlzLCeDNskyQEWoUcxSdIkPGdqcQDkPLOEGLovjPnxlCHGEoVnHpSxquWxkxouCSzHtGWLQKxQBGFcfKYDhGvVMceJLSJQdFzG",
		@"TvVzkGiwjDBnOnGMicaAocLgQIhNBaxtPjGsoJYhvAwvHtvvyJByAmsoxICpAFFhgdjGGtdpYfxxRHxkamXtgapJPNLEQglqgxumEvMrxLkoFbShtlnzN",
		@"wQUQUVgaSELcFVVZkuGRfmjPLivfjfAuHtWTpnrQOTdYMvkDTTyEDGVlMcxMyyUYrIAxqnqwHmQNTPYPeVivRamfXgrtveyriIUvBtPpIRBYlzfGDoyGQpQfPHNILsfzkpkUXAbBNg",
		@"VhmtqUkGiTJKlOTCjbWgMjTzIaIAzqcudROJqyFcevzRMtdMoGysSjQyVlqtrbnTkYFAsSzpjqIshcPfyTjZIQtmPiKcufbCMMJIGyYKLhEFoCgzKROFexiBSxwbiYZtBAktUXm",
		@"FTRymfZNMJJplmsduTvpcNvtrEbNFOPKJtgYNWIcajQlHlLTPHvjGYZdvACYmomasQMnTlmmGRzpgalODmucLHdDSjGpqgffMeFxtHYaEoKjfXBtmkqpJLEHoPGBaIdXgSwuxifRC",
		@"DfrBaHZvgVyQuEBUbKVtdBcKRAjPqAOXATEgFCziWWaJFOTwbclZiAPZGLQrQeozdRRmTCKOOlwrgUSjuzVpoNhPHnluwALdrIVqVdwNBfJWDvepUkEAcDmpSoIgezBToZTzIjwHCHdiMTBG",
		@"faeZjpZkHxLuCcIpHHgTUioqJpWdCXUkOSkopZdWlIeztWDGIcgNTTESgRkiIuEXFoigQKPeoXwhaFasLXCesJXutnYwGKAulAOhnNJZtZbGtUCeiSe",
		@"NfkHXMqLPjOPtFZQkiAYRMNcIDHfBufYjxedFhYYIgACxYIYhbQLbPmkulTmIBRIWMnepaRiitYWKSMlsnBKnFjPpXjQyIQxUiFHsZuGKaPfISSUPZeMmeQNwHNn",
	];
	return cDZveJGlpqu;
}

+ (nonnull UIImage *)wmtpxEFLUV :(nonnull UIImage *)UaEOYVkINNsk {
	NSData *UHlRENefZHZEAqBS = [@"BxaLZiRxYTYmqcIFxKNmISCHqejBlKkFXYofixFknaUwwPwNQgysysDuOfqDmuKuqHOanBndhbrjAyyoylcMgdCqyVlzqVIXRTKi" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *geDKHyIRfebQKGTbLN = [UIImage imageWithData:UHlRENefZHZEAqBS];
	geDKHyIRfebQKGTbLN = [UIImage imageNamed:@"shpopXJvvIBrxAMJUhbHFjrLlHHvkQYFpNKgExXcVvwKUMUbwfGeGUoLgsMDzTHARDrpSOhEFdUxGXxaVlaikkXJKYgsohlGNQYNNgBsrlYFaGBpuTlflsIarWeAXRM"];
	return geDKHyIRfebQKGTbLN;
}

+ (nonnull NSData *)tNJEYLffPG :(nonnull NSData *)hQrGoWbzUiIrGwbMb {
	NSData *PqYPTohpMrBCBaElU = [@"lBEgDUvznuUogoTdbMXjiRSAOCqlMXqApZTWVxVOmmUWhkGFprqLXDOeJBBgOAlTQjUGFXZaXFSOXOgfDMUeVPRykyYRMIpbJITbgwxezZsjTECoSS" dataUsingEncoding:NSUTF8StringEncoding];
	return PqYPTohpMrBCBaElU;
}

+ (nonnull UIImage *)owVyabwogleJmcXtt :(nonnull NSData *)BLhdkyzJIhBjdwlUQtJ :(nonnull NSDictionary *)TVeBmlRhQKXDjNqzFo :(nonnull NSString *)UJXhgaEsSWUHQC {
	NSData *GvycietAvHJm = [@"jGkRdbHMtXgugfNwnICNHdTWSItCyvlgfgUuUtEEixZwglhrCDmOkdAJDvbNcEWIrAclScBcaXGZiSJmsnxeDfsbzWWQFurpjKKzzznzaefwlgQlCuZqZyGpq" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *TgnaVINjIN = [UIImage imageWithData:GvycietAvHJm];
	TgnaVINjIN = [UIImage imageNamed:@"lfJTbqMnHwoVNwQqVSKqJEOXPAwMOzHuLERjekhzjarWnnEQlxOygumICWvQEIsoYuEdDVtlTozuMHFERHgEIWadcTXoLKAMcjLBJCZxzuFi"];
	return TgnaVINjIN;
}

+ (nonnull NSString *)JVHzyVgSbcir :(nonnull NSData *)IrYXZskWxt :(nonnull NSData *)CtRAVszXbXvJCVpvN :(nonnull NSDictionary *)AmgvOXoUly {
	NSString *PEKNbeBTjplhD = @"vbWQsORUmQyDSlGTYMzVjLWdYuotKdLeSDuvIgJSXQCTbxMtRBziWbkwEODHntBgHxyaLdERxoNjobscAKVUOyaCoYgWtWPXaZfSBCipoCzGOLJK";
	return PEKNbeBTjplhD;
}

+ (nonnull NSArray *)lClDAXZiymEOGciJL :(nonnull UIImage *)EvlnSxIBdVP :(nonnull NSArray *)ebOCNOuVFtdGyq {
	NSArray *ysprtEbAhuIxLsZESEK = @[
		@"uJUiTbGthUalKtQHlADzkaimzBZXhXkRKurZzZxGooHXjgmrwtxyiOkoXVBwXlJxPRQLihaYwzVdCWhSZoruoehcZrQJWplFgQLbWGmHqihZJqUXvKYxkZuEJITVl",
		@"KnGPJMSiOjPyNLclEbxhCLYWsCedJWGGGZOXkLajnwSFhctKNVbmtwfHIBPvkfDoMXZPBitPjmbDtWuPNpeZsonqfHoTPlHNrugBIIbbHCpEnwnDKaBYdw",
		@"TaiaOYDiAOJRBkvuPzguKtFOYdBCCPWUdeqmwVCUieLaYTbUFiYxUiuAoWsNvovGUmZeFjMqtGSWqIYJHCWNntNWKuolmRNoDPbrhJFLYmSyqptYJXGHZCvpHCNjmetYEvfeW",
		@"lBTqwbGfwZiAwyEpgaZOfmWoyeIWtjcPpFDQJJfzvVgpeLzLHGmzGXJyXIGGZjaILSWGhtuhPiggPmnniGlbsuuseEYricZbQfLaOFoa",
		@"GhLZnHygVFdMhOBeVGrEYOwPFVrgANAWqLYQaKhCyCmSgonodbTyDQCdZuaRZyYyeTTOxpdWPQsrDGLqTEKitiVFsYKQfhptvBQGTfV",
		@"ejQzWqAYTqhLJBEiHhefZompAaWkePMyDjQiUoOngIWacHHpRkhAqhcFRRYcBnmZxxnvfMNZUNuwPrkTgEonsmwyupuwojUAcSpt",
		@"klIpMxlyXfEOdMbInXFyHIExZaupkGQrUzBoiSZJjvKZCZDnnEuFtLDNzUOnIJbvAkBeWoTxPBeUjMCSxDYevwiGtJWoaJshYQODYYZJdge",
		@"MejEBmwRbVlFeLvitifaffvlhGDLUyyVtoIVzPQaGyrwuFlBzkvcllwxRDScQzwwTDJZQoyhsAalFtrEucGwsquKBnXDkhiYulHvqTgxvNoY",
		@"StUcjmwJQluQPRpbJxhXSeqoAOsEFGKDLJbUDQhwrTcijwCFitfRvVXUlrbIHFpPbnhXlmEiYOrIdBlVolFyanDpISQYRhcBHLsXPnHbdJlnEbxEnxZFehengfomxALmo",
		@"lFQAuZCJRrfzpcGnRnOoNiMzSnlAVyHZcYEwIbFkrbMNnPxyhddQAZWYYokYAfxQRwyAmFpYkeIWSDfIPPTXkJWjagwaciNaWJWDNDmHxFwbjOuYQVDTcHSQWMNOCSyZmDbiX",
		@"dUAIJYJvhoeHijtaXBmMhIkEDYClrdfHCmYHqrmCZgjUiLMlJRINjsUivFCiNKBZFBaLKNqCfwkZpiHYOgpUUaWfZfolZMssOaxFvzmbhTNHLZipqmQVIOlizRFJsPqe",
		@"PBXirixJDYJVtcpGIGcWemEhwLyzRHsAanfPUgJNkrvsUNJthbaIqvgIWTgVWnQTyYkRPJDqkQCKfWKKDrFRlqIZcYKIYusKGLBIu",
		@"QmtTYnDtkycULIuDATuADnVxukWdVEOxLgftvisNmGIaiPNWegFzQprCyAdEpBqOrDipQgGTgMYSUUaKINmjEpjbzljQskHAPYpqKHrjFGWbDxnURmHznEsgZxIwOJQwVFzK",
		@"QEXsPzhUpmPbOnDEbcYdFTQBvhrxAFyVJDciNRyPwGreousgdkLBpoOTaxUFxYmZwQnbaohMzzdAHoamIDYZWsEDOPjHstOBuGxreDDnINGmecAsdZkKfGxehjNyySdoMiw",
	];
	return ysprtEbAhuIxLsZESEK;
}

- (nonnull NSData *)gcvahfoHBFMHoMg :(nonnull NSString *)SbYCRLUHzv :(nonnull UIImage *)RwoWVKsQwmkLVJyL {
	NSData *rNqLFEjTGGooOk = [@"WVBgmCfhiTmSlQQNjmLYHkflotNjcFIUWlMrhsGWRqrAJDOzGSONwsdVrQFxrnkOsSKanyhJgCPvzpOfTMZbqWHfUoQCGWSMCcquiRJkptW" dataUsingEncoding:NSUTF8StringEncoding];
	return rNqLFEjTGGooOk;
}

- (nonnull NSData *)jyRlGxWgjpmMCZPPWy :(nonnull NSData *)GufWcAoJsahgBETMGDm {
	NSData *pIXEBDXxSXRoVKm = [@"EFaMjmgKMDLBHFzTVtUWBZcCnpmgtykntwUSjIqDteuJpTbJpEDOuanHandrlVRYnOALCPzYtZEglIzjCtIhUbonLkKllMlnEOJeBXvQXOApGsykVFEAcrSyiuN" dataUsingEncoding:NSUTF8StringEncoding];
	return pIXEBDXxSXRoVKm;
}

- (nonnull NSData *)mSpdWajVGAdR :(nonnull UIImage *)uaycgnQUeqtP {
	NSData *cTpQWnhSPRA = [@"ElZLYOzKczIkcaVtmAOJOafZJnnYMetxyGhAQHYgwcXUeCnbACotyszLtFGqnbYcMtaIlleDxaLlcxiVEfYYDkGvtCgCUWgKyeGZlm" dataUsingEncoding:NSUTF8StringEncoding];
	return cTpQWnhSPRA;
}

+ (nonnull NSData *)ewFZIQLKTnuJDDxlC :(nonnull NSData *)RPLTjLAoicj :(nonnull NSArray *)wTgQvPNQhc :(nonnull NSString *)xDAmDbrwbCNpmER {
	NSData *eWwRhFVlNqLO = [@"tLsFKKYxYGANilGjWgXJWftBYaJNvjVwJkFvofiYusuFuBZNACuNpAlSXDhOjruTVoijSDGfLVYIiHeShwrkvmmDMiksZMYQNUPPIEpFvFHTFilfgQxRiRZ" dataUsingEncoding:NSUTF8StringEncoding];
	return eWwRhFVlNqLO;
}

+ (nonnull NSString *)BTknuJqTjsArJN :(nonnull NSString *)tKpaKJfFWaMSIXfd :(nonnull NSDictionary *)yUecUWNXUuUWeNEMX {
	NSString *gBixVCDkOB = @"niYEIjdIfwmWBwCOBlbolhauTufjeFCqinhxCeRxlvyfNjEoPvsEekdlvvnBYGQmnSasoUEKHkILWdhRlUhVOPsXEhlcJQHKSGoNiZahTQdgNsVVnxVLEWLEvktxRF";
	return gBixVCDkOB;
}

- (nonnull UIImage *)eBxOUIttejOZpO :(nonnull NSDictionary *)oVSOntopwlvSCEpkGr :(nonnull NSString *)DCnRIefrHwrlQN :(nonnull NSData *)ibpcSzUMUY {
	NSData *IxLcikIeDkdUjq = [@"NnXBJfdvPJKQftPDjOgkQplBmiZRcZtvTuENCSYMFnESKVKflbNsWtCDYsaZyzQBhpurBQDgXyEOFGzmAbNkkKPHWvAKhoPGAYzgqafmcmEt" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zvkzvmhBNvr = [UIImage imageWithData:IxLcikIeDkdUjq];
	zvkzvmhBNvr = [UIImage imageNamed:@"OHRRJDSGNAwNmjgaLCAIjAtNoAWlCTbgotzTIVKmXcTFBZvyaQsYRhlCpbNiTZwZMDDEEIJjCIlgMxYKFEDiyKTpfffOWPPGLblQzDhTAYSLgjMilmmFVpoauBZLxCk"];
	return zvkzvmhBNvr;
}

- (nonnull NSArray *)otozoTDoydBVBgWyY :(nonnull NSDictionary *)HePiTiFMxEDUsC :(nonnull NSDictionary *)zdvXncIYvh :(nonnull NSString *)lABKPLKeKnh {
	NSArray *CMXQwXcxaa = @[
		@"MqoCvMsyBLDLXeNkrNiVhRvLfJgPqWJzZOXAKvPdctnwReRSxuSmSPvStGeZiGWMZmeHtmWOnzVtytqcsacFWrLIgayhJMarMVGifoWfaJCFYEkWplPVfAGkNlQhSabduNJvGPquduMF",
		@"vGLAbSKVEJzwQePdIcXfjgDGDbXIisVqrnushjHIstBvtrPXBRDMWvKjSvhpkQdipIrEOnvxbeabsUdEbkKUzLPHJvdUGzVUEXKVwvnVKDH",
		@"WRwnHjaicebZHYonmVcrTktFwNfQPWJzIuIvarbnBvKKMCWGirRcYfWsjdBblZqUrVyCYCPcDxSCtdKyldYGdxpMnAtoGfeKBtWlWwyeRLcxCilhMQyirSnyFKwPuAbNeLDKYOYzFkRcVAwCd",
		@"yauhyOxWBeazWNxIoSJYNTPCQokyuIPGYVyInbqSOdDxPtBshZGkeEfcqKTRMCyDtcvkPgFtVCmvuEEMHTiTfjtxEXOzmXypxTEPDKskwzC",
		@"dLUeqlNtrquCcAiQwStlCUdxBMfOCCuMKaECmfvNPgIEwwOfUfEwKeHhOLOqWKNrdvXanhQHWFqXTAgpYChnnPhVPtWBRgUvPXWqGCuwH",
		@"zKIEQXKOyDbsAcBfsvLHAkMczwVzDmXGzoJFLMBReErUaCWQEOazSJEifgiBHbshDWkcnFhpYbbtNlkdYdrvrerXtCgXwHLLBevMBcHlieDZZvzQDvdIKIuAPLpebwsKFMPlugPacURtTNigRFk",
		@"KliGgeStbOiVSSImqqClVOkQkCIJpQsHmmfCZQnhTaCppiLtrBadviaQVqvwMiGsJEyWENOeMXwSrWmsfSdRaQKDdHaTmAOJNXOMbNzo",
		@"LOYOrNpFCDXCgnJcMdUvwcCGynKKBZoBXXSqHtrRAIebKlyQfUxFdriSkRBywxYQDwZdHLAGkwSjPgjzyAwYIzubmwIPPpoomtRwTjVXicBvJyNFbkmNXiTxWCZngQTCcGdgz",
		@"yBPTSyfpfrpdvTZTqqbxdfodJbTWcgNynkxZVUDeYldoJEmMgjGktRHtaTujlHnsGXGGidoVYKMtWoRMHDkdbRttZqYcDeZLEswEJAWCeYYvDCQQmirWVoGLmaeKveXybwHokuxvmcQ",
		@"njdmxnstKIJqSMMIgewqItFKoiDEewSeiksZNfJuvAdGHMSXsWYGhtOwiFFPQyTRlhfKkrtrLdNvBULBZlcmcxFrwckuPgoEjVLy",
		@"MWULVmrErTPrfuEqfcjkGQQhfkpKDTMfOosUvhpHDVqCxpsfspSEAKCGclhHwQunrRuxylaaAWXzRNNudKcBrNTnVPRAkodPUSlVksEIMbIZIdJwnuQuNAhtfQjqlCDoWjQrDbPCPyGr",
	];
	return CMXQwXcxaa;
}

- (nonnull UIImage *)TZCBXwSapkw :(nonnull NSDictionary *)AXOHNvQeDrhBWwVa :(nonnull NSDictionary *)ZVbOiJXwqjRKRUriOOt :(nonnull NSString *)UypYpglSxATCA {
	NSData *qfqpNXLWBKdIU = [@"DMKzAFGptLWlpIWTxYyVXwvNXRzWIkHdczrbnzWXmqDCoczjwUvQmoSkawenjNZlWsCNfpOaUaHQiouDMdEKDOnqeKhBzXYyENKwemgSchyfsnFjJfdBWdDwFQetJFsrstBUDEcy" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OmHJJybcwHyEFSQV = [UIImage imageWithData:qfqpNXLWBKdIU];
	OmHJJybcwHyEFSQV = [UIImage imageNamed:@"FbAiyhKdfPfnFzxoRRhfMpNFyMMluAULnOCaqOvlNviGaIZJXkoBiOSOkkkwmqPutKtSgiLrKevEiFYWYPLFbJBNyXJYwfRGkyRhYxsAIctStLHHmJWJtVzwQsjQjENIwtduKSoLblqZEXaPQ"];
	return OmHJJybcwHyEFSQV;
}

- (nonnull NSDictionary *)POsDRlXGYfXcBIHNrLB :(nonnull NSString *)URfPrwCQcIFEtH :(nonnull NSData *)XoTzfOffLPrwBZvUav {
	NSDictionary *WJoNgVpFkDwVSVgFuU = @{
		@"ZoymbflJWC": @"HVTggvheoOIQqAsTbMtoVGMcgwNPZYyyyoHIzeTIrpwaZZreBdkvpKtIYdvluRkcVhUhLSpsxneJjOpLardjYMofrVSfyRqRaFtP",
		@"zerHOndnuYgAJcfESKQ": @"zIEQSWaQVTurUXNKWCNzxFgvMJEIjoFJbKcaEcHJAVphwfLVjrRENsHHtPhXqsgAYgqfndJySwCzKLoQEEkXJiaUyvpIdpZokiVWfziJjmxnEwiXgfxgEGOldQyWjRIjvnGbmFXxyBNWJwGHjRcTU",
		@"focqeGOFlDeEneCxr": @"SnNrCnfnErLFdzponzbBYsgDrmXupvtBRJGuXQdCGVRfogWJlsEIIiFlDHnYFBMhJIipJiRpfnMYEqUEeCwXGxBFESToGbxrzoMQvfsgQYBVKVVpuBXGZCcGdi",
		@"rfsFpCkkTmfDnN": @"LiZrIwzoMQkvxoolQNKkyiRTfOKaecmajZqLFIcbCtBBQmsYPgBrSxJZkhlEXqZabOhYnwZhyvfTbOUiQHltBeLFGOMKiHOCnFyDjbYhPKkqspUgNYYkCvm",
		@"nvSWVfxaHuAZ": @"UrnUvKNyvglIEohSHJPIoLLgDeUPaIofncUwrEIxltQFaFNoGwjlXfTGNZDKyZGVIssvNDbquATRjFuCAfQxRdkKkeJbMFtOfkTYbyBEaPLlUSbcof",
		@"NWKjlKFziVvNLOR": @"cCCOEfvGlgxUdNSwqCQVuHHlcyIxKRDNjHOEQeSzUwEzZklhvtsslhudLMrSlAnYseBvDDxKornpnYejHUHjnkfdoJnCdffyuBCsJdnW",
		@"XnekLiJxhROCTIgcMhh": @"KECWhUkLgUzWKUPeBYVyYNBNZcZVSvAaYZoQNPdhKzVaeODGKUvxTXxiowzzpNZFPiZfvdVVxhTuTPcSIUivxwMUYEXpcZcpQXOtapBMyCOojtPiaCoNuQFFJaV",
		@"SAbVFWwhdi": @"tmHYDqQYfifdUtrTsTSontLMrTmsLxhKvZgFQnEjzDIRreUrNdQLuJSBAJnpgNmaGsQzbXWskVEStoWFrLgeuPPKLEXBvzvMDxlkrNlYwytYvMVXwLhuqySxBPllMkgnzgkssOJOQGc",
		@"iOVCxyeJzOulCZ": @"IktDybqDZtIyAQIfOJYqRdBCTJKtUOGpUVyHETpjQMBskemjwgYIBwBOtSQhTHtkvTWofvMcauSBvLkDYkwJAgzTBjQygJQFptruoOPMUeaZhTzayRcFRCgGnwrFDkHfUjAIWiRyQGB",
		@"hOdQihPOxKoyuNqldPY": @"HjIDEvTShWkpKWKKCIKRwdOqOhgfIqBSUvHmeagvjLxwExWfFmIpPJHqwxxSZFoWGEoIiRkYmtSfXBhJHVYSPbQVVxebBnorkMoMYgQbGCMcCQaOfTDFYuSbLzzAVu",
		@"jeOtLmlbQYc": @"aLBpMSDGUPlKwwGbLhqzPnvlWcmxARmInjeFyJsvuaEKCRCVbJficaoLSrOmwsvAUzKhsBMSpgTHeoSOGQgAQpTSRUXkNglkGuIpHwGcljtTGjwzABKAYUp",
		@"hHnpPxFGGJcj": @"yKICAkWWvuXVkulyXhSaRmNathFBUzPaWiCBIvaFsBTmmkjPTwvlsgUlLIxIklSfYNvdnzzsXgrtiLHeYAAMZvYVetqUxWfuXClAbXuLwJowv",
		@"yIRTscrQmhcxoTH": @"mbTHJUDFwVqNgrssijtktkBGltaQSdMdhYrBZIiPOItpliZYyAYiwjyOtWhsTfePYDDVWojUGFBGzcSmzMKGwIvfyrEBDHaGoaOKIFGYfxnISyjDdbFWOojMvQxJrMjEQ",
		@"eemtzFHfxrNn": @"cyZhFzpNndrlABaCxBeXkwKftHqRmCLOpxQrvRblxRiEFhcLZIicNRgJEssSFsSZJNEHOPttzujEONWqbPRzqjPhiVcvSlsoWagH",
	};
	return WJoNgVpFkDwVSVgFuU;
}

+ (nonnull NSData *)lUHHaEIzIe :(nonnull NSString *)vsVavcmGYoLMwnCMgA {
	NSData *rrNDVEQexqD = [@"ArMpYlVMdtQGgharUCPrrXBBChFGOYrJCVOyoyvDFbIZEQNDZQhGFNTDasesDzAEWdABXOplGeaNGrkwFpnTZBvIsWVtfoEBJPbMPTKFCSKKMocMbIVVxJtRZNLkKPKUWAfsgDITwKJl" dataUsingEncoding:NSUTF8StringEncoding];
	return rrNDVEQexqD;
}

- (nonnull NSString *)UTIVzWuQIKhPiWFJk :(nonnull NSString *)JuYyBwNSBDndB :(nonnull NSArray *)IWuKqjqrzk :(nonnull NSData *)NzkHBBotRumzhm {
	NSString *yOKeMqNsLyBbYjFlE = @"PcwOHVHBwMOHOHdnyLChCTKrVKGCoYoyLBuBKwQrvAFlKuJFlJDasLHucMRPchIALWwTkzqCszNaXlzNssdluNMQGNnDMhDmrnZnLkGaOVTIE";
	return yOKeMqNsLyBbYjFlE;
}

- (nonnull NSData *)yTZxBXVTQDpzds :(nonnull UIImage *)ERfEuRlXFjsC {
	NSData *uTMQEUAalWWlI = [@"ZRzsjsDViQzmMRrcsoSWeADiYFXUbCADYpTbtRlkQQSQbPzezNSRjQBPqfjzZhTbfhnGoBRakVkqpyHXSzQtTgtQtoJUhYaBPDoBvMbBmOZqpuxzGnEHe" dataUsingEncoding:NSUTF8StringEncoding];
	return uTMQEUAalWWlI;
}

+ (nonnull NSDictionary *)GZeuaZoRZWKg :(nonnull NSDictionary *)gKlyDhwrVinD :(nonnull UIImage *)bWLkbOtgJMoLgyrSe :(nonnull NSData *)KhwPJuZayjiUor {
	NSDictionary *RgStrLCUqLEcNwLc = @{
		@"jabTRyiZQLeR": @"itKrECntRbCGZtggAZduvTbyTrBHksfkliRtOiIrAEiezwbDUQQyJzrZnGIsugvhueEMRWysRadlhWOKTkiBLOHYZTyyquYzzhHOmvionlxAjgKbHsZ",
		@"WimGwvwzIzEE": @"AdFRkgYvYqHdGoyLKNQEXVmyROFvaxisqNazPDkDZbCDXFwqYJVeuCaSfpovSaheeKtXynlOIMheLLBkiOpcpkIIiiSNdLJnoMRuJIYakcuiLmqMbqVU",
		@"zEmeMRFbqVstKWVZHYi": @"hjdWHYBHSWFoPCkmHqkCzCpluWgSQusvvrnaflIStgWGwIJeWYndpeQORhdyTFstGyPjegMbXKCQLTPbFHYAjpTFkjxQXkonIagCadjbFoRSoN",
		@"rPYKiMvNAk": @"FZmvXkAEFsPapRuQJTzWnbNJykbDmEHyddhDSrZwFWgVlrjlPLgHTMaIiwnbubwTGaQFTgzXsYUGFyTnPzicZNeqzPbZDryTaHTPJza",
		@"SgMDdNFwjjFZXB": @"IibGmAInYBhaMJgVSEGTJPadtEuhTZBRsaihTnuyvIPNKvQUccwvrjuzmfFUBzzopxgxVJUOEVCMuUNrlaGxjwzLppZmWFuaHJFWUQhaKgzDPLBZpayGwahiNMjQvwIGCgKjPFbpRlgsud",
		@"zcYZLTfIYHSFqbuK": @"mODxLGluEpAHfmlPybIpwZTcxqUZXxQNwkOGQibruihRZbxVpfdZQcnwyaBwtGzCmETrxsGPjPUsWueZxxTEEereKUmerAVlgJGNrogmvamFEChdmSOg",
		@"SoEDRhhxkxiyNspC": @"jiCcHvXvjSQBjHiEedhqNOqROuGoaCsmaYbaduQfuHrqeBDAnUGjjfUzwcrkVTngCdhZiLjEmxEQhTAtXxHXVzNSpRZGWLtRQDbviiTQQwuYtdmfBGgYwJhXpQtYp",
		@"LbqJKjJyONJWDqgJ": @"mXiMDLYjtfGpeiHRczZvOHBVniOpLISFydmzOsWxserduBioFcmQAepjLWvxSGtiRCYcHBsRwPRxxiCVqrJpBbTmNUWZEPymWugVXFk",
		@"jwABQhSNcdh": @"kSYBnryhQGFqQEbeUNMcRKwbNSzempliGXIIHpXvQmajgFRcrEDRhSCfmTarzFMYVXTAUmvdyKXkrJOdCdDvvkcqQBCyQBsXqqqewmeAtPEIvcuUCpdVPKXflFIUoqjCXRPOGH",
		@"iTrfNZBGqYgJabWX": @"RFFdHHRWpOsZIUhQwTMrnlXWVXtcomAbydsZvdnYtsdLKjygrKYvBfwJsBHIrFezaQumBmlCqxqpXFwtqDgdNswDYYIjwXBqYumRjPWNBuNhRSdHPTIrOiTOrdzVbEgmOoLCWFvOjZQjKLJZms",
		@"UyNmaYhbvIIJlpeAzZr": @"QLZRNozIlCFvwmuDUjBSgitqQNjbOuiBFoiTfSVyVteSvBeeXNTpGOGPzYWvykMXtsnKKYzJrAYePAYgFSPMfMhyYsEtSPCnzKxVELjbHbeeyZNImWiMZXzuyUzISm",
	};
	return RgStrLCUqLEcNwLc;
}

+ (nonnull NSDictionary *)NeNoZKGXGYlgKdtdoyi :(nonnull NSData *)cUgtMoOZolome {
	NSDictionary *uiqkcAPGdTfxxdl = @{
		@"ZemKCzkaTANfYNEW": @"atGLlmvNfikzMkXuLKGaFEUCCrfYYpNkHKkFgvoDvzxhTcemvgQcVdYBfWXVuJwIHaOKFLAzFLkKEthRerDhxIRziTGpBWjPODskskuGmYnMvnkfcKRFuADFIjzSTKUOOtqRcfJZRRkEmzhJOGN",
		@"wrQbgyKJKWPvARcRj": @"NnMfQRpzdPshIwANuWmttoWzSuNuJfnNWqUPmwPRHuiVUaDLkbWGeOLZjHpDaumqICAhiqvlzAxiSNGnTGHJmkkezZwYRaVeTcGyEHyXcNKuKjoJzsNLAkjIeSuHUiwRUkYTwXX",
		@"HrbAnSaMfbmTQnndY": @"CyIclISFhShUobmJOgSkOIEKufVnoOXmoNJDXiXVmMVnJUwDuHbLxGlsFtfkoQTstMQUtkiUzfeTWBHTCsHJdzFNHjZeczxtawHfcQerYjSWAaXBXLCEumKOHxbKQpZoonCfFdYNpoOjZeHGtb",
		@"PGskWbWEeGp": @"XSNNukhIloLasecSAmtnTZBYMkSpkOlzhZXuveeuutCWwJPJbdtcgxZmGdirJXVTlqmZivEADEtumZZPtfgbpbLmbfbhBlLigNdzMIjYmPCIRpSwPPluYDOvqBVxNfRzNt",
		@"aUCAoMbvfyudKjoqL": @"mcNnQUuYJZfAVXtbtqDzUaTPqcZFvKdvNtWpbkZBxOtRfxCAqZDQGENoNlXIwZgGMQKHeieXwGeNpEfnTsmwXzDHAIKEShUmJtzlVxfXjqPrcy",
		@"BnfRtOLeFOyM": @"ZbUfhUzmgNgIQImcmnViqsgxNukrZlkGnQrzArQTkZHBrdaVDiaUMtQWsPjHFmbHMVHDXMuztrSLijEBQYRmgRknAladVXHlLYHzZgqtUT",
		@"tZoHplgymUyl": @"bNUoBWuBhOUbfpiywqDkOAkfmLNVAarAzFCqAqkYwBozFWrnTTcjwWaoHwqwbHKoWeSpAZvgcLDjGYlcwRFCbBkugkuqVNrCejJLUFzklsFiKsYuITmZD",
		@"ZVKHAVbgOguuJzR": @"kMdGUjnZWuFZwDXzIRGPqHZyAuhYaCEcaXnJPiaIdyiJXDLaiqBSRbVVwJcBcmmZfecoCVJmetrqnoeXHrlZXdPxwDTnHPlPxhAmYxhnrkrGyYXXGPuoWzCledszrBBQwMdUKHUsIjuZN",
		@"BSyiLDkMENWxxKABWsb": @"suCyViUwJsFQGoEnDLNmLNxbFgHuXYVzzQPSUHsILBUfkFsUSwlYigSnJwwXcThDJDhoavgrLTuxMRSTlHrlHFZZsKmwfZvjUGbwBJSfsgbCGkr",
		@"WDaywiTDHPUg": @"opIUWNxUoOqYHEbfsABCLNhNHLdqrAKMgherZFMRSqANtzqZslTYSwpBUxDKYWlpKQAuoBTnMPwBqveSBBbiSyVipufxtUmwuVkArxTyCJxQYGLxJvmJZxsAKwHUDYnPKWJlmUtLgahj",
	};
	return uiqkcAPGdTfxxdl;
}

- (nonnull UIImage *)iabeGzXZnQfvas :(nonnull UIImage *)qtAyWiULMfrUgv :(nonnull NSData *)nDEWfKCYUgYRwbWkc :(nonnull NSString *)yyjWbUQZLLQNaEwjte {
	NSData *GqBFlZyZgQp = [@"TwUobTKSdgeWTHJdYNGwuTqiWAsXUqpXCuDNrVLufvZntFoiRMuiYsgOnnhItqYBevnUrXxVWNSfxAdsLNGbQEbFCCxWuQfMfXBYYDZTpTkFTutjSbTjFIYWHCO" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fkVawUdmQlNQ = [UIImage imageWithData:GqBFlZyZgQp];
	fkVawUdmQlNQ = [UIImage imageNamed:@"uWluZSfRQporcNYJKhlaDyTlyczGwbmfAhuDZdaCWagthWDWHGqrTRAGoIdCyCwVBTYvNlrjiYfkqgZlUGqjyPsJAQxIwyQhxRueBbbiZRxYjl"];
	return fkVawUdmQlNQ;
}

- (nonnull NSArray *)krcGiwrBpQrdbJ :(nonnull NSDictionary *)CUoBHOPVOyxVCNbF :(nonnull NSDictionary *)RVqMITfGTR :(nonnull NSArray *)ZcDIOHhBZbqVIk {
	NSArray *NbwfQeuwtQMtAJR = @[
		@"NaYgfftyZqFxFCWIowjYzxKYTYmDrZEzUHMMvxtwgSOFKqubniuMSAMxgLWUOmuvUXuHJluBkmeoKyMBVpktmAgetOPREkIvrJDFCGIUelEmyWrCENZqrUSQZASndwgeXLePNWksDts",
		@"JgVJOTfMlDtkwDAvbaQSqGIiljtfNPRBIpwNAvcAjfgESqvkvscGpIviXqkddnuKUHRIqolGUzstzkRlqPZWEeUZPTazkQMqyxDECsHdtmE",
		@"cuvsdFcveyCGcdObzBSLkwmYfiNIBjNYIWBcCYYxwqdVTLTnkikCVOhPaUyPScHxFTKPEIGMvuGQnesGiSlnYtFFtWkbFWfMyOfjhZ",
		@"hgauODKLBXIYukECsiZCnjNCXQvOHbaoqFQJkDYTxxKyINGlMVQvoIkTOgIhjPVipeZDQgkZdXcVMCRSxFKYjDIbmsbKQlfdSYCcAkPTbPLSRnrLtGxqFCrXoFHLqaUFVVyTVtpjk",
		@"DAAZGjencpihSQGtUjsNhDiwFwQqjVfdWhMHDoJPpsJWMOkAhiOcFwVUHTpEAGNidSbHkbVbXLTWVgTDVRXZtJJfIfhgUPudNoreuKHxCtafSWr",
		@"wuaDzIwHmmLhEwDQIIYXIfhphSVKaWJBHPrIdHInyfJpdwXjaaJdWkKzvseWidgYzcPUOoZMrhEZNdAIdGBfyHdefhlJJXuxyDgTNkybyIUfYMUgaEFX",
		@"LtkbiIUxMYeCJaDQgxDoJqsISbJRstTRBeNMIqrOknbpFQtkRxOtrBHmVEWPEUYKhfbmybDADRfimjReKTXMtXlpjwkLMTbaraPZwzMhSt",
		@"IVldbYtOZDZGEuyLKNfZujXlsBcJSaOaQZFCvhYASaJugZiIRoxQevadMlHevwKAUnpSRVohOLrRPLBHMIYCPeBnsJXUnrlHsXXJwNlGRwtJPkeX",
		@"IydlIrnJrmjlgEPuTHCrJmeXaKbKvdPREptSDfQCeGXfHzEPZPXhhAEuQYlPNlGtAEPUuXRihyOXIHmpGGToVIITyKGshhGUOKAOgLUXZSvvFLEpVlwua",
		@"QtwdlMxYerGqQOWejqnBhGIQfzFVuZgVKXYvacbmRgzDkqkQRKHcQEvmeNBiNBEEneCMYKVvKrBQytMggnSxgjQPeBqMUDUWLdXzLuytPtNYdDV",
		@"CfnjiYzlJscpnePTfxAQMKbbrAGbVPGuJSSKxzMBjmyexbXdbfyIPYLWjeCOUsQGktYwZEQkqvvKZtpMpzZkNZYUiYeUnSZuZZMlovmLPwcljyjPmnyUPIMjXrHxwwxukpvobzhk",
		@"AujYWgaQepqizxwTDpRQeJSFjXZDCJIXVCoHVYisrUTZytPfVWeQfapleKivUSHYHqsuzfRNEfLFkxytjBJFeytcMbRwDDLPrmbsNYrYECRHmeZliQINpsFALtUKTnmKJRli",
		@"jEmkdXrqpyaTAkBmSXYcCfkBFRfXYJlUssFLDOUMJaagLkatPYWbKUshIxTsCPahUxNjqGXSGdutAeFPPHGSJNUevPfqUMMcbfGZdOPcxJCTwvJzAcJcZWVbIqFGeZzziLEgTirqtPirkHv",
		@"tmURShNiSujzWNpYwgRXCmfPiXtwipHyxTVCfqJrsZcECTsFzCBUrElpQLJwluJLrqYMriHvwJsKfIEFKAFqJRLOIWPmaikBfIGkxClfLuhqFJha",
		@"XtyPHOpRxOMnsYooQmChwcIrmOrYARLDzFWNQNtNvrKCyygfnQLHZqgVaNlhlHFiTaEdtuRoKbBDDMDowtvNaJVWnKhsEjfoWKfCFNFNMHyCLFRVJKWyFfqaadiJxrOeCQVThzeCrRXyP",
		@"HbvmLcxBycAuoVSkMYyEwWdPKUCiilhSbKYFmBchreMBKIRpUgcxYbEuSMWUHTkyIgNMerOLliRmXYDztahJWMjZbvQsRYJLgKDupqNDMWXNTnuIQftk",
		@"unDxtKBMmoiMkIeEfFgMczExVeInYoUhMVpNqPDXdHspicskMhZIgMLvprCPUOehgKUNFJLFIcfcGkxLpnlTWkiDEUKbgGiIIirrrKychPqPKQqjaTCcDkGovNvHdog",
		@"OxPXadmmCwQwOmCQnCGIFlqbMLPJNgPomEPWdyRUMmEerSxNCGUbKSYpvCJxElXdEDtNYQAVytiGigVXYyAPbLfYnOXYelqExKNuNOQloOmeosxRpNYijpQtcBTajVJumPPVmBQCKJcDyskZ",
		@"pQlZcwoAembYGqWiTFyxUkJetFkEoxlZicFxTSbouINVeyPQmDPjFInFZWahSJYHhDnbLTucPKZBagGKASYdlWdqLntgivlFmUaoDWAduaTvMdXZL",
	];
	return NbwfQeuwtQMtAJR;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        return;
    }
    
    [UserInfoTool delegateUserInfo];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,GetMenus,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        NSArray *menus = [MenusModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
        
        [MenusModelTool saving:menus];
        [[NSNotificationCenter defaultCenter] postNotificationName:ChangeTabBarStyle object:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HAVEPUSH" object:nil];

        [self.navigationController popViewControllerAnimated:YES];
                
        if ([self.delegate respondsToSelector:@selector(logoutClick)]) {
            [self.delegate logoutClick];
        }
        
    } fail:^(NSError *error) {
        
    }];
}


@end
