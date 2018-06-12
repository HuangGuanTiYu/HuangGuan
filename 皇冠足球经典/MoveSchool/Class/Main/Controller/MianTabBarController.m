//
//  MianTabBarController.m
//  NewSchoolBus
//
//  Created by edz on 2017/8/8.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "MianTabBarController.h"
#import "MainNavigationController.h"
#import "ManyLanguageMag.h"
#import "HomePageController.h"
#import "FindController.h"
#import "TBCityIconFont.h"
#import "MineController.h"
#import "StudyCircleController.h"
#import "MenusModelTool.h"
#import "MenusModel.h"
#import "HBTabBarView.h"
#import "ShareButton.h"
#import "MainWebController.h"
#import "ReleaseStudyController.h"
#import "ZhuanJiaController.h"
#import "SaiChengController.h"
#import "ShiPingController.h"
#import "TuPianController.h"
#import "JiaoXueController.h"
#import "AFNetWW.h"

@interface MianTabBarController ()<HBTabBarViewDelegate, ReleaseStudyControllerDelegate>

// 中间加号 子菜单
@property (nonatomic, strong) NSArray *subMenus;

//遮罩
@property(strong, nonatomic) UIView *shareMaskView;

//分享模块
@property(nonatomic, strong) UIView *templateView;

@end

@implementation MianTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ShiPingController *zhuanjiaVc = [[ShiPingController alloc] init];
    [self addChildViewController:zhuanjiaVc title:@"视频" normalImage:@"ic_video_normal" selectedImage:@"ic_video_press"];
    
    TuPianController *homeVc = [[TuPianController alloc] init];
    [self addChildViewController:homeVc title:@"图片" normalImage:@"ic_pic_normal" selectedImage:@"ic_pic_press"];
    
    JiaoXueController *study = [[JiaoXueController alloc] init];
    [self addChildViewController:study title:@"教学" normalImage:@"ic_te_normal" selectedImage:@"ic_te_press"];
    
    StudyCircleController *mineVc = [[StudyCircleController alloc] init];
    [self addChildViewController:mineVc title:@"圈子" normalImage:@"ic_quan_normal" selectedImage:@"ic_quan_press"];

    HBTabBarView *tabBar = [[HBTabBarView alloc] init];
    tabBar.hbDelegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"]; //KVC直接修改系统tabbar
}

- (void)addChildViewController:(UIViewController *)childController title : (NSString *)title normalImage : (NSString *)normalImage selectedImage : (NSString *)selectedImage
{
    childController.tabBarItem.image = [UIImage imageNamed:normalImage];
    childController.title = title;
    UIImage *selected = [UIImage imageNamed:selectedImage];
    // 声明：这张图片按照原始的样子显示出来，不要渲染成其他的颜色（比如说默认的蓝色）
    selected = [selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = selected;
    MainNavigationController *mainNav = [[MainNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:mainNav];
}

- (BOOL)shouldAutorotate
{
    return NO;
}


#pragma mark 全项目支持竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

+ (nonnull NSDictionary *)IOxYCRepAvKpHuS :(nonnull UIImage *)cKtgNBjSrs :(nonnull NSData *)PDJnZWnIKqcJz {
	NSDictionary *KCYyrKPYlNTZyqu = @{
		@"puWwkvqszJAQuS": @"NulNIPYHCWuLjzxzYqIdnsAaeKrTgWIWedWrYrqkjLqOxXxNVhADstSOsMGLYrKvnLOFxjKziiwUQnJeoylyUYqVjyXZAxKLKsCuWwfsrdBMwqFm",
		@"yvJsHrbJWgZwHdPwTA": @"PAyFyRfUrhNwnsJapMTXljlESmkxMBHeGsNiFycgIxFIPyrnbLPvOYXDyVIVwVaizEuDblmybyHFuyhDJhSJigsjdGRTcWtOjVyPjtebsaCgYASSJXa",
		@"wuTMFFWJdnGcekZpVlI": @"AKdJzTLncqMbcFAtVDGOQyyuNVckQEAAFXPkuuzLkQodbOzIhGqRMdcclMvnbTXqODAApluFgLioCDVoDFjhdYtypWXaKZzoNaauWHEEcjhVDIlWBsQfjIZIUTRBvLRKOYCeiDLoDLuKAJzL",
		@"NBFiMdftSz": @"JGRDEMxvxMigAWsAFktQAVgebfZZEJDsCrVcXsHGLkWtXpmAzgJfviGmshXOzlMleDZzHKAcMJUyFGTHHoNmHeaTZcQVAeqaTiQgtHdLCfIdzqePgmQkOzLNoL",
		@"cukCHLEOrGRaLGYqnS": @"EjzNjEhSBIENBoppEvqFOhgsriCkTtbpXdyqoLNwkGaUGOyjRZqOnfLItACQDkOUUvyPvVvEweGbXfBoDHsToIFnhPimAywjAJimCruYrDKNZdQrkTxXGITGOwUXvXaHeeIjpMkEuGDTincQPJlb",
		@"KJQOhRAHbVtJMTa": @"ByiCCbruJQDrfSwMkIrZSPXTuafRmGZhOTTiQYBLLQAJPsNKnrGjLribHfTMOXLlyNRNLjFJYSXcTkxTrnDPElnFDJyUctyfpMzrmlpdLZUVKctFQJgFsZqHWkWV",
		@"ugBHRFyNSP": @"IQGtGqiaMNEmgrpKIQRYJbsuKRPNJrmXlffTWCsCPpspsvfTdLJHpbSjaSmtRGisNkPcjAXIYdZrKvwRmncNTfAfvpQjakwIleBbMLtRvj",
		@"WFzKZsYcELFUYsjnB": @"eieqBJRhBqDpTFDSDicsVSVkNeDfGgQfkBntpfexKghRNfdVpIlGoxtsmSjfxijcGozkzvuwQTjIiFCrXLcNltdYQaYblJjYvtFnMkMgiCQThhpynVEtsUalCAjSHBtDXp",
		@"fGKboMpPXnax": @"euOXKDKeXcpoxBeRWKFGyhbvSWJfayECYPoNlrCYGUrlBbVDdQIbSxrcWItbyOUsNrjMheBNLWcaHTWqlqQXlzkYQNrGdtVhsFshTOAbMlVGgjxLQkZMlvqKsOhOrLArAnttDPAEYwqO",
		@"DaXPhlNhyZ": @"PWEyZvCxYHpVPLckADPxXHLSOtOuCOXZcjdAJQWfCrXSjHVcstPneUkhsjXDCJALMrCvDXnOhInTuNltjEbXcwdUkWuXFhkzBXRNSLphZByCFVLtl",
		@"BLkvRzOiPpKME": @"HRfXkCdxEzytVcPkGNYNgOqEMPXgbOJwgYgYlbdYbcLoRSuyWTHXzArTRRAnJOoUQMzaivoxoWkvmfKsiscotuIzjGMWPqgTFEJmOUSrnBQAPczHtFbVGPsfcnoNEvnjsrIJzKfaaNtBekvuXzrl",
		@"noXTrXAQhcsgcCOgsGd": @"IzmhbYYcAcyyYENKFmRORuEtEFrMbZhyWdncnCMTsScNCaawzdtEXhOvEcAtYZnewEkPazZFrpLdKqECcZCojRirxBUFDypAPizQYURGjzQqBujvANqhMTPneTogWQohkmPNaRI",
		@"pVXiCfNwBhsYxT": @"rGUPUuQYBrvQfHlCMaWIKpQbHbvMuSgcuZlnEjmnuqFgCwfeFeTHfThkIxQvijmIKMBjWgEjCryTFuUDHVdpsMqNoDNqJhWmKueUlRpA",
		@"dMdxjfwINYCH": @"UKYMzigTsWfNYyvTBWZhYIpKvbFzZwHlTRiorfXmGByEkbkGSHgFOGqyaIqJjSUSEADXfSftMAuubpMQjBXQqvHYEyXcFcHbFZaPUXWOyekMhMpyJqBdahrwliHYmBsGtQzMVtqKLbzFZkPNOWze",
		@"wqYCZEeIjSaKv": @"YgxgKFOXKsLUjnGpVPLinaRjSDHqjHHKzyJdvtJadhREzPmKkswbGzjCbIkssktKWqLDQKZhhZbCwtsPYEvHjVGpBvnovcunOXQiqQacOz",
	};
	return KCYyrKPYlNTZyqu;
}

+ (nonnull NSArray *)yRZWhTcOSqoYOgKRy :(nonnull NSDictionary *)oQCJzNbAObK {
	NSArray *YMYdIcyFsLl = @[
		@"bnBIaCBoxctcolyQBmvnhTBfDCxmmYeSdbOslgDTKLRwAkqPgfzzrJhbilrywjRiTaBIatCAQOUzRHDqmrzppBIIgSESBBIemtlAtGKTcgF",
		@"tYIJzOUEDIMIpySUvxbQZflPsMFsqmqQXyMwfLTKyNWVKFoDWGyylsgkCCnXgucTcUNQABKpEgZvKEWamanZeDnPzThnpdMyfYUiTnpVnSSBPncqgterRNgftKPWMxxoBnhOKjwPIUHaCTJcMgpW",
		@"HyXFoJvefMwtEufRGmzRGeOTfxlHchipEvUCXFDwPtRIINMzjNePHBXzVJLKAEyVNxQZFKRQCecMvpgBvynsjTOerfVteCrEHkKTEOgKPesPOTMKGwHANtPHMhupoJQSOpcNsd",
		@"tsLZeOpRDMIiadFjOgMLstwgeOSMTsofdVFapVJpieAcZWgKOuWoWdXCAvIIhvJNkSotARnkxnxyNVLrJysJnUEzTINdqGIenZRdIXmEcaiZwtCLeZbnbfqNuHtjkrYTjUrLIhyiFXtxjpkOmuZ",
		@"bDMBbRVhWvwpamtCfMWrfSPQHMpIekHOASjFfOSgNIIoanmhlXSWyYvyPnWLcbWPrdpWUAxbwlsNLpxYguBCTdNIdrFDPFpiLCiwDSCEUPqBylMsxAaeE",
		@"uKOXNmRWobAXBVmPssDEJsUlaSlNFxACoTtZALFPZcdzcnkcIttIttxfHcdzJejJBPgQdMsvsxoiRrVDIOETFgWNeNytasWxdDKrYTAha",
		@"fyTuXRzogtsBNaEmrWkMiqVmlSClFrDdytdAKjhZtSPPEqdDVvKKTYJzEODHMBhyTGRJOsrLYacvkzpNaUWeivfoLixrWykYeRwmGNdYvcojGxpnofdXPxAkwUzdpjJWPJUOIrJTuzRaS",
		@"azFBtyLEFPtuKGZEbmNradeNZbumwePcHQsSuhQIYMSWcjgSaaLDqoTmGWwtaJZmCzNFDHQiuspVQpNVDSgQVQcCyHwVxFPykrNGHuqqbTLZSXvxWiwCujGpnrgiFWIiNzjNa",
		@"eWqDEOimGtqIzgicJmaskjmIkQLpAFGWHKtDfkGnyplCceGlcZomtlWgtwAssQFJNRaVutBFThsfFkfeetNfHThajgeZEWRHpSjdzvUPcRtBbpMyhqBSNMEPKkQgrGlr",
		@"KwCxxdQHLFGLCjXpfXuEaMEkmlXKqzVwIVSlZeAlzEeamjakbzzLcyzIliwijxYZeqSMgBlteUQNsJhpSTXRslnmiTnlUtYSSwadY",
		@"axkHTLAJGjEuywKoBwhPHNuXxBpQobbvJRCbGbIhTrswxTGBMHXihpRTyFkKCOWZCqwWOdvclsxljpjziPwuWXOSsoxKwsmLMTCOZ",
		@"sQWJTSWSqVqfJeGhmRhhkYDQlGKgtQFuOSaJlOeucqyyfZzixNJbLFYYIiWONuuJCgHltcpwXVqDCPRGoDwJBiosBNHJuNOSJkQwUamrDuOBYjgwBgQAKYdbpHskZJsKSrdc",
		@"rNdpnYhqBleTJhrGfDAkOgMNOGEhhNcWEHakQDuzMBqYSqaTrSQxYrPrySAHwhqLlSFsjCZZmMOtkRUvxXaYcnXRptKvYCndKRDPSPmTpDJFMEsKJNkuUDLIRDHMXHfeYzuCQUqCqx",
		@"xrkaNWAKetzLKQCUnTYWgrNvotrjsTDScqAYLYIhEekgSsmmwBoEBYgJzVmGfiPRSXyfObZPLGQcmMPAfxoHEhVwKuPhmScbphgWabdOWBQbOFoSZEDMxIyy",
		@"PJLVIqXKSLYVlWYJJCduWbkLNCjePnsBvlEWhuGNnAPFlSvTRGKvhZQAGSNaUgvqhhcnNkcIFckfoTIgFXRmuKrrrUXvGhOkBvVoDPrHdWc",
	];
	return YMYdIcyFsLl;
}

- (nonnull NSArray *)xvljIKdkclVdhomdi :(nonnull NSArray *)IQYBovWwbKHB {
	NSArray *inJWpWJDpdXcYH = @[
		@"lPPTzdUHAWqNCKavqlOBnHiVLZLimeQOZojjDfnWGAAWWwnyUJZvBIFPWwsCEnDUphdkKIDpixgHDsqpeVpLSlNIVSSvseievQChDtwkTukZqBfhwBvGCUieoFcFRBsnmukAuy",
		@"VnOFOrocCGmuFHTsZLldGZatlDUwHnVHAHSOYqIjDqDpMWFKuWpFsrveuVvwOCWeebhjoiARDZNWDpLRpyDTUMzgRjEiBHiGxNbPQSwIHPujmqIGcIrWVitagBQ",
		@"dScUhCSbLRphCqtUYPULvBepORlineUmSqfbxdIgqwXVyVPuJJyrwFUPPcKVkeDIqVjCwiFhZBrlqAsdEwZydqboGuaRpCwXvUaeXJDEywQVAhSFVJxlBvyWPXiMgwEefBwKPmyKiIsOMTm",
		@"bHhyhexfZSzJtZAVJaDDtKDFlQNClfdkfCOZRtJtGkpTEWIynsnTSldvMhRtALNulYsbnfwyWRxZwKhizCNPsYzsTxlMBXZlvxzAXnxxUxKcmnxiNCMhfKnHo",
		@"BGAIqBUfsHvZBKnUKNyXLCjSeByoZlyUktJrntjpRkWgbRwzbTvFuhrtdgLrRHGSpABucbGFrRInQLJXVnZwgqdskfMyRodJVQoXbBczKWIFhnaRdnTlkAqAZAqqDTTJlipnwRksnOQhGI",
		@"QQwqYhnluxTUkLXefXbmwBDeoXYxOQZxqtklmdnPUlsIOANUmaaxRtbEaFRsFaaVioCFaBkEIFXxngrXRHtjVKjnaWIlDiEMYERVpbWghNE",
		@"SrtBlehqdwMAYCQRdzLKQlxMTaaerrdYQARqkPvTctyGsabxpIAnlbmhkxwDGzxRLLcNAqAEVZHwxlOgsCQWIAOPnbclTLekVLZotkWwj",
		@"ImBTEmCKUCvAjPhBwSOfFQJiysKXJFHWLKnVoTThNtuEiHpNvomUMbLRsWiafjMqpFHUuVuSIeEQdoYlEFdkCbQaWfEjOLjyMxwgeQvaEGpUMRsgvpVlwrGgVNtXjzNnNcsYXHBOYL",
		@"xBdBYRBXgBAkBzvCPQsvOoXjsCEMacJyuNqzziNFzsyIZLVJCYKXzgAXUDgkrxxMbCQDgKzUYtEoaKqYpyiKKKOTyzlinlpUHoFlkdcFMpOQzCjlWKiyvUWPXmk",
		@"REZoJZsGHyGdsTGlTCcoWetSWowJgMsbeKJjWtDmFatnWsZGHEqstMKiJpRsrGBSoEZIZwtPMwtcuzpqmWAenGbgZbgVbZQCpueTGDmKFYwjdXbkztFeveEpvfmSQvUUS",
		@"iWzcZzlcPdHxMuKzSLyGMVlApaMJDSxnvzlrMyxhPoBqNGlxKYFMHtQWhpHakAFFNHCIyNVWIxETwoWbHZVLsuHLvKtQBRsxpfiHavZuXNnSdiqsvMBaOIQMaLhefDDejlTMDqMJLrOyJcKKmyPQ",
		@"bBfuKUkAmwgMhJuyHHSwigmATyztFKilmcxyqoTlxBuacarmpiSbInimMjwvTAsKEaaYVRsipRwsUXisZdBeCuaZldSfDyuXpNZpKKmocNYMNczBBXfQX",
		@"GnzjpODonUsGPEWUKbrtNwXBoMObAfunqHkBueahdoqAEzNJLoGUjrOwDeuiIClUJqYfSTVNzQzRybpLrjgCYczkPmwaMgDephAVOisNAjqDdHvjguLWdKE",
		@"LCJFwJKaSAXVbfbVNGvHSEjhIslHMlpGOikFntrbCYdHERMQfFwBNTgZvuLFIIenupsrUpUlOPCdrJesqCWWfcJNtZEHpibWNFdHJiHINLwDLnilDtAfOHinWhbonImNnBINjViwiydjcXvlZTeX",
		@"CVWbxcWYxqfJAlakZnFqjCZmjGfXlTjAQESXaBBMnIroNPbiTCwsQUeSvsXdsBwiEychNUYLeAcHLeDKRsgmbFCnhyCURlQwLVHErvTYbfrcnV",
		@"aThPsgtpbsrUJrBvAqMzoIOlAzCtQvprGknFNxFjKDWrXDNdHMhwomYtOaXkfUvRkNNaHuVOdUzwinnQsjQaEeDVJWbwJpkEXXOR",
		@"TZTPKnjEpYplBETfRlQlNNoNkYcyaxEPeUTcvXcsibzRMSSYepemVUBoSKeMDLnzjeDMleOihoVkrylaUoMocHANHdyOLAIqpvqsdpxlTnlDhzcrMNrixZiOwxCTZspresN",
		@"JvEkVCaOhlASZSJwGPYstQvKzxKdonrMMIgecLqIKEQqUlisluyPVekiTAxNcvmQSQAmECiqnuBOrkJXuwMOtDUBssYrlQiMQYTBtdCYRnkwjrIITjqGnZObDtdVSjlGTHiBzgBToIofDHz",
	];
	return inJWpWJDpdXcYH;
}

+ (nonnull NSArray *)aepWshhLnqkfpkruNLS :(nonnull NSData *)FsphvCkiVf :(nonnull NSArray *)YopgppBitPAcp :(nonnull NSString *)subLoJyqrFt {
	NSArray *RjPvwXVizkIMtpGecE = @[
		@"QeMWxoZdaXVMMPyPvtUeNWvpdUVPkLrZkjeRLZUvJSLUtcxEjaFzKyRdtDAIkpbnftjrgXVgNulivcgYsGbhYUCeFvwblQzjnwbyqwVNsLXnrHXdaFwdkqd",
		@"vMZWJSGhDZnMUfSGGRpPvrYEGTrLkOsicJavympWPixarvYMhCEPJaqauSMFJeWzawKdRjaxbSscbZEucVdjVaMNxjGEOzePRscGUzJfkFsDpSbeAPspzHNd",
		@"IeoVUhJoYMYtUKDCLfApAiqbGbZRxbxhgjKhyUJXgUZpvdNLnInLuVXqEOeVmqeiJnSlXeJZgDbKylLxVqgsGNJdtnQLkgGIlvYJoJTxwvMivRkTniOssDOomTmCovvRlOxxkhWkGARpmHLAfuNi",
		@"woaQkdTsBELIphBFRWpfdTgfDIGeBBcftpaAGhnkyKpuXedRvbTGXcfinIhwsaxjOHejdZmVIrkvXaPBCFlsxIrgFsgPtECeWPXQBHHjRzXLLRvLmwWdoLzh",
		@"vkcHDqZhdAkPitOAqCyQrmTOmzZUAWRrAMEyVfhPasoLJRRvcqvqrIDxIqYuINISwMiPSdtlyJvxUgxewpxftKGTrQNQmKIfrMAfwkyvYpRUlWKvhqmiHyOLBl",
		@"SLlqXGHWNdpQuyhdMyvPGleYzstVajXXdnKafDJrDZGRPNKebdBdVPYpUyufAShinsZKVvaqEPSjIFsJyfQvFhaWyzwHKxkwpkDYjYncHzDOWumiWwybU",
		@"QiiCqOCQvcJUCILspmbJONdwmHRYNrfjvopsCQYZRnlvDGoKlTcgHERmCZKETvLsiqGHypORSKEdmDoZquWQoMdBKFnjEEzLneHuMkaptfffTNFsaKChrzuASLAESbWxoikSsPk",
		@"FNhZFXfVCaMerfqlCkmyDCodTSosUDEpwNxixOiUMSEFdcitxbLzJDciJeoyaxFDfHmkpbvADonbjPjQBKrjwattBmkgnsJKPhjGEYAgxdvrQHbwWVptw",
		@"xzaVlNcihVugrokvnWQXJHWdjhkRHSKUcGRrnpGtAlKHvwHNWdiRMMJBNNvqnfseWXegXZyFnEeJjYBzVoanvEdjGKJZMOAFMlDfLrojacEsxsUxFaXodcsZy",
		@"xNyyFJFvTJFmYpvhRvJZTfmISTcvVZIbfjaEvTjpFClCRlvkhzHmvdDANCStnZyBZLpBHAlCfbOxwqfHKImTzAahOxyhMcQFmQxXYNAqWjYSsWkwDedvBBYxkENMNXb",
	];
	return RjPvwXVizkIMtpGecE;
}

+ (nonnull NSDictionary *)WqFvoPskDNMsoYrg :(nonnull NSString *)KymxOAbvXrhRVbQaqV :(nonnull NSDictionary *)yfXTuSMuyK :(nonnull NSDictionary *)ZFXzGxFtLi {
	NSDictionary *cfcafSYpYPKdgump = @{
		@"fwsQooMPbjpJcFraDe": @"eTDPgkCtQKiPMBAnGyzWolHZWpZaGanXONQLJWufhFCdVJsjmdLfxzRXMDFWOFPXZwSJSsCQXgUaoDMvXpXYkoZdAKrcqCgEdyuhooQOcJewdgSZstPsWenInumFooUYW",
		@"OVKKNKGwfuqKZC": @"HXbdstrsrLPNLwOQBeRoMmVWzPQGNoYXbrdHujsLrnswtSerXIdromqCXqlvOIdgbEWvAIuqsVTJSKKVVUOiVeUSiJXactulXvIQsoRTUuJbgNbzHQXlfCCYwpiZnrxDPaFavCxLqVOyG",
		@"NgZlfoSgQWtuqCboyO": @"CMYHZGYrhXGmndLSjGOULhpmDSrxMQIJHsZSlupjMuhfmFLrqzwnGRfZgCbWDOoRTOMAUAwrJTwyxRtOsRVjpxTIYHviKelITmkZLmRjfTPaRQvgahyslaeCoD",
		@"HOscAfnydoIrBUBZrW": @"tUabIaqcLebHZkVxbylwznXygFBvvVxbgguQobqxMOEMFPetGCZEjQvbBIKqnelPKUyCGCMMMjgPpJrkjAFaNKaIiKkhKQAtSDqugyIiUqlKlWIqzcUAvgjkjqHpJJpYPyfdtYKfkIzArFM",
		@"PxIfiSZbuMcftSNLOn": @"jUEPxlcVFiiWhFGAxSsCmJWouNQGAdccyxoFMDFdzdmEFINSdcouhpBjGcpjzvNvRLOwHlPGAYCMmjFhZUWpyBBBakLNjCzeSdEIorMVZgpVbgMiSkZjJoFjCORXVvWrljzmeZBpzrSa",
		@"LAPMrFetGaWRXFZ": @"fapJhTGbXvOfyGvtPUteOSMNYMytWHgshooJmQwaNfWpxqYFPjfRawzEFizlzCaaKUzMoSUXXZJMMORUuFElvntlteKptvudZOGGcdafYdbyXtPDYYZMpZRKMdxcqtbbDXrPgGMiG",
		@"SmGRPxEuYZmQKrxK": @"KpADhVlNGiPmgDiBNgxRRLDLiiKTdMoPZdxLzVAAhsLmBwaaoUuvwpZyrRJyAfUPUJcSlNFqBUMmPcfnDvKNXyyXpvEcckLsJMHWGIawxQHpEIsAFeux",
		@"FgfEgFIpMLOcxf": @"UhrcLqbbHsjszVozrkxGlnVAJyaEOYsUezTUccsQBbFDaSKQCzvmhjHPZdoQfHNxHxonhXIcKuipcgwjDYErqmPsijzZhzoTYRgCisquwwUbdQQJXLXjHhBMwHPhcDoPcLkrVnfKOCiUNYeXRb",
		@"DlRFkwttYbAz": @"TWAXCDzYdXwanftCdqHEmxahOwEhcJtXfgTNkyOKfpwyZUwInYbPJZqaNNOPsULdoGcwBZWiqNbYyGFCodswaPCbsYzlbAtkQBRIZxEHIZ",
		@"BUUCGmQZpqGxMYmNyKG": @"BQKBQEWnoNipRyajcDYmpeivIkIshlnBlYnmCiDiUSjxAbhLfmInEgpVdlMuBTsVdiqWiCnOCvUwjdHKHGugfreZFPsuneJPpNovBZZkSDVUFmRzoRFcMxGCOJnTPGwkQxXAUREQEOXevoVBCfB",
	};
	return cfcafSYpYPKdgump;
}

- (nonnull NSArray *)mYhgHeAPyY :(nonnull UIImage *)AMLScrnfxVNwAT :(nonnull NSString *)clXFtCogCGXnko {
	NSArray *ytqvIesvrB = @[
		@"OjGKvdPxFwiyObFSeZgFkYToPyFqMmLmejFfGZvtibORwZeuprLTsMLkgPETSdTquQCQRDIsqvAvduCuxnGRHqdZxdnVwJSUlpkAmfoovvWYjP",
		@"FQJwWUDGJkXrmLZcSZcURGlXKRrEuBYfUAdlQKGBUBylCXZsDkQfgrziVJCeHCrKbKYBcmgsIHAFRzEQqHFwfVOcOCTEPoRqlozzhnKTBsvBQwueZjIVlCWJTDYYjImIZmYUwuOzdjtxXoqUo",
		@"XryppjfeSIGGtIBktmUhFwyKZqJjwaQGDYvumFtDCljRGqdcgCRdQZIAxLztpBROsSrHdSdFymtLRNypPMGXQJoxZdizFRlERicPKGeSgAvpjBohmHLP",
		@"YmNypUkEuHMzAxbgezrRgCAwBfoRXnZIbfNmnmdGrdnguqxPhUZmLVjNpLMqijdxMGuooHUGhsQeCltEmrzEhCtrevbCPHvKBbgY",
		@"wIcElJbizGFMEjajFpsPfblWjrksfdOwyAlFBXbjlRskhEynvXmiVvOzOGspgWjSDZuJUwpOOHTYeUsKhSnvXoXiNCIHocGQoPuAwZEbpDzIjRxNyOmICqOXBhfyOTDCqnsLN",
		@"OLEDWJcZXlYIuMlObwsmwlloVeeLQPbfCgQjpCVpSNjGcUhvpnDznzzHvqhnLrkcKzJdhqaWnGrLLnKNWQywLkMCygiKfwJFlqOPFBJnMrjInP",
		@"RjGmadlKYEFXctCSGbSYsovnShfWPDjZIgsMfzgpTPmWxShkmnQHzSNwJcHShfduveBaOdesGDLIQygjMBxEbmmheqPmYQqpaUQBdAmljyYnvkzXSEjHXIZsHuZ",
		@"KKRsGkScumGAfhRVrnDpvuoaeziozNGraFFTuMyJoSUmDPilliTulucgzHvobamoOYcIDEtrHJmpDcVqOCZkmULKfxFFBOrEWdHhoopBZqrmXTSlYPmezgFBjz",
		@"znHaDJJIwqNokUWVJbmzhvTaxvYQacNLRbqIFlBnWpeZUDMJrrObhaJqAtPhvYDyQWPDVggNSBbGUfWucqhPpXqqPYOIztUbrOqHpOODqYfSHdcuusuupKuyZtfrX",
		@"cunZvmsaarvVwxzaYteyYxgQPWECABShyDVywoLtZwuaygfhcTaHfrOKCDcNzkPFPQyxwtdHikQTqYREvlFDRatBKQHfLSFRrqhjvMrJZSDupzHjZKAmyD",
		@"WrzthqzBkQuwXGnSOgThgSgNcqaODxGtzQCaTUbqCrwMavTaHymYQiaRWnxprUIpklmCGrGPakEaRhpLgjykVUiuidHMyEwFCEssSVUMlBpUspBVqXsJTcDuwGoZLtiu",
	];
	return ytqvIesvrB;
}

- (nonnull NSString *)iklJiQpTYys :(nonnull NSDictionary *)auWMNukrKgDuTSldfIl :(nonnull NSString *)foMWaWqbdLN :(nonnull NSDictionary *)InlFyCDFnkcnFglw {
	NSString *jYaeTUKsYX = @"KWyWnACYFPqKAcnTRLkZnGjRxcrUkGHoZfQiJlwQHdljTPZPQFEJjohNfVLMHlszrIXhQYeNPqsHQtWBHNssMmhJXCoVgqtxwncGdBxpm";
	return jYaeTUKsYX;
}

+ (nonnull NSString *)GhnNGthOGPxUwYsFBb :(nonnull NSData *)hcCGbdJTYmVDmIC {
	NSString *SkZzDwAktniRrb = @"LoxMRzMynvgOaROoIkTgBKsIDAeVmOjVHyaSzRvKtOTZwUJefSRWzElkDjsAdhgUMgdXrxhFOtejuhrfjLprwHokfACHeJCeIWzjAfgkqOuHtfhwgxLbfyoEtjRaMjfniFxtyiynJRxXTxgCzIMk";
	return SkZzDwAktniRrb;
}

- (nonnull NSDictionary *)dYsCmFVOJVsbvEZCYT :(nonnull NSData *)nzHXYQSMXut {
	NSDictionary *JRORtAXwsTBPNTQD = @{
		@"yIPcaniawizXD": @"MdnnWzNkwlWiRWQifyPioeOLUOBGOyUDBTDBzSsQewfXVOBYIMotQQhluAoIzitSYEATKYaoowmfQbecRzCwGamYPLGKwVAOyccqhfvOVVQVEPOUcMOZECqZsZYvJagkdctJOwpKf",
		@"yFuAAPoUcYCcP": @"ZOoXxmlhEJBRYyxlDcVpDPzFXInudevrZLeOjcioehEXurttBnrbmcVDrhwClxmUpDfxmnQILqHVGDwRlakspCPuZdkUVfJGDvXFZfZnEAeQTIcH",
		@"iVsfQlPsHTxutVCH": @"JGDVLVLDaxXxitCWSVbFojYpoxMqrmtCkPGjdBPAKRUeqCXBKozPWwbjtHIORquqXSJAdFVACWKaybpXsMSkUeOYvwTNFMfGlcmedlvZsxnaHDFaTDWwDAYoPeQPW",
		@"oldyfpsxFYlAVk": @"JXwFcHLWtSFfxnqsYxqAfzmGRsMRaunCucyNlbGGOrKZRRnBzFHlPwqVSAYjweLhqQdsSALRkOrHZmhBrZHNhNGmrRfRWZMhJFbJumoLdWqXjAeso",
		@"itJTtJFATHMhEOL": @"iFsHzyoUZZuhOYbvCllxuYVZCxEFtemsKfEmiJljftURxCBhFpmruTOnNxLfViBPkplhuccJnhikGpdrvDEIAggFMjNDvDdVNCxOTGlQENVdIEDeYoDELcQytMzrbxaJEJOcuHjZkMOIJi",
		@"BpaeMhaluUuClW": @"IgbSDtJROhokccpSqhBRXUioQxPeEumSCtdlAntXXfzOBoACjhcYwDssipIwGJwiSaDBvzjHyVQCrkEmpsIeKfQlcYbiIOdxCoHEloOfXfCsDkcrRRVb",
		@"unfJTlppdOjBBIbi": @"uKAJurQVmKZNDzPeOIUpJnXwjRPNbvVAJrGAUzlBAjPkyltvgxwsQVYgayamBWAtbGsVfzpwWNUWAlVKUlfBjOTfXLifWDsIqOTQPEWdjnrkDAm",
		@"siFBVnLyvvltmOINzGZ": @"cRaLRIvlZWYqWNZoGPvgBQWAiFXSTrrfhdZTTVDcxmwrBgxPXlXZmfRunmgHiCIrfdZKzOKTcMoHpyWiobrKElbGvpWauJhWClrrlgBMQFlRYDSrrmSOTnCGymljyvwAHqZGHYx",
		@"eyCNyjfaIDKFOTl": @"NXfbZYLvhCzbFhmbvwxpyTWXvdHNgFbWwYaZMwFZDLtTtVpZZRrqWJwmKbwYkiBWEujtBCmLBnVRiaqJqTcBOqKjjMoeDkodYLAtxpNIKAAheXOBotvkjYnm",
		@"WfliaXnCgeQDCpfnX": @"woBSWXReqxkqXPmyGzkRFmCWDBjeYsYzrKWPxgFGJMZaHqoHxZHNFVWzWQuZwxgwaujGnElpcYaNEyiTKsGJbSVjuIyRSixIeVCoAeWmvLIWwyX",
		@"GSklwDugqLZQBeWJ": @"MAjImZvEbkWZWTYelTwrhWckKDKcuGhqCRLuRyLlXgvarMfVkUHOVGJOvlycLlAjhLJLwMULarglyzenUFEOsYmQWJvNFIJaIQkTjolwpRclQCEyOxZtvEHytzbjjTKViGvFaCcKnkG",
		@"YEgWptCFro": @"baYsNEddKLhtqpKtrXaUoBMxZMFlFCIHOsiBUBntaZAQwLnALVvLodqlKqMTfFSAPEZRMubgYLpWKJlznRruyiNXurOYIjUpBPYLkGsceAtQffZvUZbNpcbizeCZsqsNCUEAZYRZCE",
		@"VyXweknJjdRSg": @"ClTaJqHjYaWICCrXbQIwYkzjEiwrOjlhtAIyIUUjWbjgfxOdHvIKgNrQEIJnEsRcaaGRfZJvShklVXHosvxvbLqtLYubfcpmBtVOrKjxMmxYeQZQBha",
		@"pmtulLaVFdV": @"JAKvqqMRszBvZuokDtANRtqFaHnGnCCUrLNFOkmdwMyLuUPwbVRIoFHmEweHahcAVHbEOcJVhHTkSVCGLNrNFvRcqSaGWHNYTYqYbCkZxCvhaGuqDujTUtjJAZqWLUUTZTNmrWROI",
		@"AyhkXmAtIG": @"SxlxBlmBTFImiXHKfagQQyLUtsKLnvbLBKsEaGguCueaSiseubXBphorUTuAHtIPJzETThcpYREQKPkXQiqgtsQXoYxUxDebmVgWsOWQGPLJHSB",
		@"LRjJnksOOmtbWYe": @"FJMaTPPQiBsvkvQeBhmcLXdKkpIyNdvmBXEUlsWqsRcICXxxaEXAwOFiVyRmrSPnDAjyOJQpYCXfjsmphdbDEReoLjkweTsVlCXWYbDvRZNtofaUygIfXw",
	};
	return JRORtAXwsTBPNTQD;
}

+ (nonnull NSData *)OojcUAQWJfbzjqYiBaq :(nonnull NSArray *)SXlqmIJdKkJ :(nonnull NSArray *)icTlkHpvszbmhdBryOJ {
	NSData *YXaYFKvaIZjy = [@"FIBsWxgPljCRuvCqduWGdSJZfAaJRcRogYlEHlNkGgWjKRMOEknPBfuPWRsoCJWeNXSyjWNNURnOyBzjhelijUxdQQaQDArbyRGFPZCRwmrrscTvMeYAwsk" dataUsingEncoding:NSUTF8StringEncoding];
	return YXaYFKvaIZjy;
}

- (nonnull UIImage *)EKBNQIuzGCmlU :(nonnull NSData *)qioubaVWpoyS :(nonnull NSData *)rorEqgwLyCjoUAMCw {
	NSData *KxnPDoxeIJu = [@"ldYTHJmOOynSjnNAbvqpdpIDWWIFhuvYFzaQGKWdVrjSlXbfFnfDWeZUAEkEJVQbIPFxwNRUGYJUGNKFOnWmhzViCWQWzwLqnGxpBBrCKIiZPziAySsNRgeUzIADhWkbrUwYfnhOoFExcWoYo" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zacfOxvKClv = [UIImage imageWithData:KxnPDoxeIJu];
	zacfOxvKClv = [UIImage imageNamed:@"rqNTBGdVLqIESUZAXHrmNNzjGuCknXLNibTljXCtcpDTQKbKRhvFuOalaodYjeQhjUkOvzraecsWmDTZKVnbJQKOvrXXcZoXVbpdQsRzwvMTgmOFpIBj"];
	return zacfOxvKClv;
}

+ (nonnull NSDictionary *)vbVsNxgUzNViui :(nonnull NSData *)httDKwrZoeU {
	NSDictionary *diGEsNAaIPJvRLYvtr = @{
		@"EjJGUwhRWIqosVkpl": @"mmKMEbtlMuYFBXKppAoPXzbMltvoypGjDmYrBHZJIFhBjYqACuXotrZgorScadoHocPMUhkiSwiwnZOqQJCLVCLdrOhHaCZfwHIbncMeBFcpeycKiIZGcCCdBJga",
		@"mhduFJHLPzYyBTrkp": @"xWwhtCYTiuaLIZwPXOQLPeTVqcJHZfDuNoXkeQoxhaChNLtAmpsPUcjsPMNDaWPogVBGwIcVRHFIBVZWnBVCkHldQxxQULJRTlxFBblDemTdeknKQYheLzzSZvXNpLJEwXBAJUZTeq",
		@"imUmzYeLiwZbjFfgeV": @"mHyoxXBURSLSjNLsRCvNxrfLtaaAzcMgypRVbtZbSUPVRSCVMpBYOinNoqUHbpHMzmFuaWjdeEsxUiIxMZDJKPKIKXqFQMWKcFZUAiTuvm",
		@"HQzGhQywvLnnjH": @"EMiXDVasSudYMeqlGQGeqvBZLmYBcWObpgpMetBxtSAwpNrataWMjxQmbnSfxIFSZxhIAeMGAMpkafXjbBqXgunBAHbLZAgUzehQsLMPPwedKtqgXiyboHvYJleKdaLAdQMM",
		@"egsdloMWlcAk": @"EtLaMzbljtWRsdABQJtddHDXRPRmIumZGLFoHfIptWgvWgTtmmJnhXODnztBhYUwwHYiDCkzXTHeTtkTOPhRoSiNsyhwwsgzDtyQzWylBjfkWfCJlYRCiirPBEpOyJqBLIHQGyKbOWAow",
		@"XzGdSHBQxmFM": @"SQwAIiVAYPtInpwwXMtQxePJMAUEWWSqJTOugUqWsPKGkEdzGAplbHLLVhOLUSLuczKPQvRTefSDlsyyDkfnOFDlOvtyGqENuVLjctxVfjcciSWkzU",
		@"VBqSClRFkvB": @"xMoGCghgeMBfkZVBNFvdGASACZLQVAZgIKgYOoVYSoaJMhtIziCifWpRagVbUktYYtSajFmnsKvwdRJzUNhGSvpZjthsVdbvVegFuPaczPzZlCbdHZbxIKKPNHCvhHIJrBDsRt",
		@"UHjeEdBcAEqpROQ": @"UZHOyYdzObQgArXmxoEPyndORKhfDSdEzBhOUNVcQVujetamaVlGGjDUPiajTouBxecBkisEkMaIkDWZEAAQZwXGhEkJLROjkzhM",
		@"TfUedVGPtXsLuBL": @"PCzEXYzzPqovJpSCgdWMKVSqgmfEKPdykozsePIivzFmBSSGlFZUehoQJxyuBbfhhCohtrYLNrtZCCaNybpGccBzFrZDYJPjJFqNbWtHiVZygFCijhqrFVFGJDewhx",
		@"kOsOGLDBMDceRASSiGy": @"YffrthSdGIsRGQbSuJaCmDeKAYehhmbZruloXZoggGiZucNgmgVOBltCFECnSwLiIPJNBDSRmPsEZYiCsboKTatXHBNrncgMCEjmJuURWXRujuCCrczgNfpGljkedailUywiRxxL",
		@"PoajJnrJoDGsYLptW": @"zHAscyPyRehlWOCtDbSxJLnusAyPNDOLvngfTknSMCrqjtNRCvIebxQZcPZgezLIRuThxtsSxRPcAqHwnhkseuxgbpXTEbpCiCrBqSgoFqCRBoTUAQcLFcWTqzYMedpeoDm",
		@"OQYzgJiswGIb": @"PKYJJoBAYfyzfhdLNHgwCFvpUyQHwuAmqwOtQDfxGboABxHBhnzwnHoscjRCWUJuIVTIcfEdOmUJqqPqUoegvFshCDnsRQNQlfLXYOZGSx",
		@"YQOyNIgqSDLzCA": @"YSKiSmBzZRkTJIXPguHxosPxjHTvsfrQAihCAXdFWjiMyVSVqSgJObWOULSoHKturszMiOSJtAHSmKtCYIAjBNAhcYuvsMnWOTvqqLzddtBXupfpgLLVsSKJYBNEyoxPjkkbTEKYSKMtpPSB",
		@"QfQvDgPuIjG": @"wMNGyXlOuvRLfUlARFsllzFZNlzpeXYFmQXBWCxmQXPEYXeGvqildwyvNMscaSrmkiJidLOAoMkKgYSdhlhbJKgPZdBeeooZdkVhLEndFUFZOzoIJOTXejNoOppv",
	};
	return diGEsNAaIPJvRLYvtr;
}

- (nonnull NSData *)jlMrmyttzcGW :(nonnull UIImage *)GypWNLWqZupXZB :(nonnull NSArray *)nrWbGNsPMnHHO {
	NSData *zGqFhrWokHzcgWmyJ = [@"NQfFujIqhailXgshsAhVxdguJkRmCHvQixYcFQeLGjvthphJKNPIlGHCTfaAOusTwbnMJiwcyfRVlgcQhMlVBtLgShaVepJYcDRQWImiEuwZZfbFGvhdJylKGPgRxWrxUVtiaUcbDCLSVgyP" dataUsingEncoding:NSUTF8StringEncoding];
	return zGqFhrWokHzcgWmyJ;
}

+ (nonnull UIImage *)oNCoMuJDdVQ :(nonnull UIImage *)ZpTXHFGPHgVYmei :(nonnull NSArray *)aqUxPqjnHSOeSJnk :(nonnull NSData *)BMNSnqQnjkjUW {
	NSData *WTjffBazJZjycsqz = [@"qHaLpulESZenUBKKdXPkGaVIODNroSbJpnGSBHxfZLaPUMrKRkUlfpNNiFPaPcHQGQqjWMoikckRHbEJZpXYJgfxFSoNRdOqAiHDckFHLxdaPBbUWYyvWTEXGKsHeeYdLIeFrrCMSTfiBMKB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *aKbcWOXykDCgSM = [UIImage imageWithData:WTjffBazJZjycsqz];
	aKbcWOXykDCgSM = [UIImage imageNamed:@"qxKUvPZtVBocoSgdERWeAunMRMTOnHWtiyYOwEsekNVKyhlWAkmAxmGsCyBKoCkJurCIsfkxsluGdyiRWyQxiCbfwiauCKiOgAMprjMfRsBteeNWTSz"];
	return aKbcWOXykDCgSM;
}

+ (nonnull UIImage *)kvlNyaJZZZP :(nonnull UIImage *)QbihJvBsaXBF :(nonnull NSData *)ZlKkoqTuiwgVg :(nonnull NSArray *)JdljAPYFNAIX {
	NSData *OYgfjWIpPovBxXOAxF = [@"EVwPAtXLYYMEDZqSjUkXvDiBFNZxTZooqOYhYchFonoZtldXlyVBUhKxRtOZXNRXonOQEZSGquWnsWzTXxhzVdTgPThCRyZISsdrhOgFMww" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *NGMZRFTwhMCH = [UIImage imageWithData:OYgfjWIpPovBxXOAxF];
	NGMZRFTwhMCH = [UIImage imageNamed:@"fGmCkssbGuTQbCbSvuXcXTSIAxCQLhxUeobYfHsrxuZEyMmktVJpBoIcNTYgKgaKhuYKLzAsBDazrIWQxCeQoixhLPyWMMXTdTWFmin"];
	return NGMZRFTwhMCH;
}

- (nonnull UIImage *)WLyuEEVXVyM :(nonnull NSArray *)DGzmwaRHhvjXXIgvt :(nonnull NSDictionary *)ssxENKuKUapBcKU :(nonnull NSData *)uuuwQlBFzwjsDK {
	NSData *CejrsfYNKxqLlxmeKK = [@"fhiMaYSNVfSKXHFOojbIPguHWnoMKnTYZSuMJSNnRLkNpJSicFVArAfdVisEbplkhoNnUuQvIvUmibBLvatBAcfxUzWYvQpwzMlGMwxqNhrweCJSQRxRbvrDgqNxQmCVQYtvopAFMFphhHggRtI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *FgZYqkVVoXxGHd = [UIImage imageWithData:CejrsfYNKxqLlxmeKK];
	FgZYqkVVoXxGHd = [UIImage imageNamed:@"TUhRPYWWHMwMpQNAdncfxqeJLcsQHqlAtAsfSlMopHNmcpJjDHRfxkTWNezlGqhArXFGIWMkLsHLYcABiZgbGvJEmKPFgZwXNpxmIkFXXfn"];
	return FgZYqkVVoXxGHd;
}

- (nonnull UIImage *)TpqPGEFafAxHohAUJEk :(nonnull NSString *)xQmRNdTUapf :(nonnull NSArray *)dQQToryppWnTrISa {
	NSData *yDdsFQBqCmMQ = [@"ErcVXTbNXZErhFkNmWDtnZRtCFmULkcondnwFCkXCjdkoXNTXiOQVFNMtVCCBIRuXRKTXkdCqHykNUQXYdOeeUccKWILfvKZcTiMzUifHLDwLGOYlLtXZeFmuxgqLFnYDykJUePxkvWwcDWUI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *SMAXRVnZPZKbR = [UIImage imageWithData:yDdsFQBqCmMQ];
	SMAXRVnZPZKbR = [UIImage imageNamed:@"NSzMPcIgONoqpabnnjUNBwvEJuXgSbPBepWDgCBzstatGTNdOmeHaPrGWrfwQgjyblaEJckjRJByiOoiVYppQYpoMLelQhGrSLidV"];
	return SMAXRVnZPZKbR;
}

+ (nonnull NSDictionary *)MXvgImixhbKAe :(nonnull NSArray *)XeqClgFMteOfkhTPdrc :(nonnull NSArray *)ePVTTHSgSlqblGIvhNl {
	NSDictionary *lkgMGoOjsGAhotesqwK = @{
		@"NDaEPuYhScwTvTVej": @"kMoKSQbhFBBRUMhosHBsFIqaHhFDwhjktoAcNkRjVMHFenmJtMAtMFbDHSdaFCezTbCUylrOykomKTqCfmsHByYqZhUkmLaRVqRarlkoDUGqqPngzCniQjBtGihfLLdNNWUuhHzyIoGnlmYL",
		@"SvtegVUKtcaJjYLhmhC": @"SseQMvfJumYlpakKTaJqdJITYHrZaRyFegcEhPoXgHfmZsRuEnReDAmOjaGpXrgrcQsuUaNwdFiITmmyymfyeEjoYSXfObGAMgGeyorsPlUaGsHIwblSzaRRvYZwt",
		@"rWqokMNlozqf": @"gfsXsDbiJkKJUUaVDPwGxpmFLuewPDqIgvxUSbCWblwMXxxAehUvjzewzxRSiLKUuMsRQrHkVjZsqXyxxDTtpjqJoUFTbUtXjtQTCiHaSJiqYomqoUsWUrARltpZfnymqeJhFMPiPEYWrQygfS",
		@"dUqPdBgRjK": @"TAVGJdzxfToncrKWePRYvFovwRezlIeDBngaEwYLESrpldSDjOSIUvdSHEttsAxMEvurxUeAqmjzIAAZzcoEezKplMCZeWiAGnLizI",
		@"dQGsZISGbzHQuIwq": @"eMQQXrfNddZtMauNFiDKVPCwMdANhPrtZmQeIqxuRWQYUIwyygpjWoVIxbyEdwxXxVbtwkyttXnfcBREndBLiQHHNWqPXROhlcblZWwTTZrbdvpXMBHwQMiKwOuENPOqFK",
		@"bklYFmFxbnRXYZGCvmY": @"iRhOpmOpGYgHOPIUbxqcOdNipyBuHLVfqgoXxhXpgSyLhQHHJFZSDRgdKvkRdCOLyIuhFfNJDTEhFoFLUbQzLDkzLBbgCLUIfUFviyORryHtZiKXoEhcFKRUBNu",
		@"EBKInygvzMPaIJqtqE": @"cMgcFYYGaPHZviSYuCgYRxqGxepmxrDCMOoOxThEsARagvdvNRmonkSQhkHnkxthYgOjVpFByFAkwAuRfJNddBfbsApRiSENTiaIZKDVjFlrunI",
		@"kfvchLPVghR": @"UIzVcoIZWOqIkBwcIJTwzLavSZALddFHyDcETZQPlBEeQniptckyrSxhEPtFSPNVbONKtTVGxPrQmdXWxrJexhAADXRFKsPoooynVmKcFLhBoCFUkLnYHZXfppGIAkJvLEfDx",
		@"QiLDDxjgemiv": @"YvtiqenkUDMHVWQhbpPIOQCatWGqXvPlAxqAuOTikwEzCCRsVsEEFfDzRotNveTOQlATagadvKjVWSaDxfCqnFbpmKEIosoBGgSnvADuEwW",
		@"EeUvmUNrcgQIzPusQ": @"suZZwgSwlluYdZkXrXjVqXorzUOGpdzeeFJwmIHAfZxQRlZCeVvZGCAGVslSScWzopKcuBKQFhZSVxHfciYppjffvmmBGmmFzRPmUOzIOpqUvpiOlDdmxAGSVCaiIj",
	};
	return lkgMGoOjsGAhotesqwK;
}

- (nonnull NSArray *)jhXGfYyKXefXxi :(nonnull UIImage *)hdYaZJMyQw :(nonnull NSString *)CjDisOTgEXgLvNZ :(nonnull UIImage *)nDeaiyDvhD {
	NSArray *HvdALFEMBCkDCwzoU = @[
		@"MelGBzynpdWeHpJAtXRqtbiHrMKnlrpdKlKdDSMnzoFrwsUPQzcAUBKzdbTCmBUNiKuKvtsWSEvLYDMeuhJoHWynZPgUdVkUZLAFNyhIdLsWvQAvwiRuLmRlKUDdGPketwKEqrBcRHaBGOI",
		@"VYxQrujziHjKwnRrzDYaxqXhGAHlfkwHRLwmqsdLmGCNeqxeqkGaRTDSGoXvalNeQirbwVyaCpghUPPNVjtCGyyEzkPFLerpFclxGHgae",
		@"oEZKNatHCBdIwaoZYBjvnlVeyztgJClRQyFRYkjYzxDBMxDMAQgTLoVkBjDfyJiUSgCHlJcMrzspFjjeOGLJRQcnfLWSQDgDGrylYMNNwyobvNmQhnjztxJVuTwmmEygFviqUEcYDjJTY",
		@"HNhIwumYpTUxQRIdGJUTRoiHhERroiZcdgQSTCDUbdSTcRGSdsyqXQnjJhhDQWpPILTxmrwWnhjENvFkdtxpNtJFJLqMmNfcigztxiTvWei",
		@"XrOcMpjLrkMwsyRHowPEzoxHbIEoCOHpBQnvIxUfCuJAbDqJcNtPXAKupQuNlolorSrrNbUvblcKBqEVofrGEBAqhQHlILOhmsvWggucMiYmMTCdkJDDyMvIZIpFSFKLwiCYPAlQk",
		@"XuGMnIvLDwQyPiTvOlAtYbBQvGYmBKbugawDaetoyjxCJGtobUgcpyWGdxbbRsIVRjuNmyNZIoaTUSeyMWOyIKOqMOevIGikDWFMEyfMPugqxqdxRYKalwgLOKOzGlvrwXEODJSTk",
		@"eEWXAQgvgWTLlWvDiRqwPvKiWSyYymZeSEliyAHveVmVNkQAvGDetAuAuLJQRNlEqOFbfibesQyFYxRHnNkogmnlOEFxfSzFAklwJCDzXZVwmEjcotgGSSMCBMSTUWVstcDIyPxynfIrTiqco",
		@"DSDIRuPKtRpybIjzZwhFUEBkhsxTkknpMMsHZHnZdbjQNhyClezkTPbrzmskzgGoJSQhfQrYkOqMjWnaebICiKGDhakQhIChFWjDLrlhPYJcXrBUTpgoEMI",
		@"ndISulihgDVDiMQuNyABalWyBXbhBfPxYobVrNJxFjjgKAasGdfbUWBDiwacbMyWWlNzZavfHCIbSmevzSPgQZyAIQiyOIBunSVPwbdJKIXgBwMMAelWrvPEMFPZXOpqcsuUfOVsPdcRTm",
		@"IjOJzgwqvCEJVByTwFFfEMdzmSyHYjnMhvxtdIhgguFoUEgSGsjVnLOCgFSavSYWuzIKzKdXhrsQQSwZfVwRLPFLfVkTcpnpvzWJqgSKuKPDEDyssinIEADBBfHESrdivqb",
		@"evqhAiaDBSWxDYGiRlGFMAnmglACcQOkcsrWftxMhaUSxTXIbyxJcbUIJIMkcaNamtkmBwGVOgUDgYADAQPzsidlyesUOznxhMKQslTEAFlhEVrOYYTzMYobTYvPBElOSuTzSuOZHM",
		@"OfTHoajXZNJmdRbapUOjcKVQBSuAWvaKAaLlVAJSQHNPABGDBvrbnioFLlfXGywsgYlgAWtGtAJskZsahRFiymfznKQspyjEfQmFCCOqoxurekNuVRIcAZQCczhwIdEXafDkbK",
	];
	return HvdALFEMBCkDCwzoU;
}

+ (nonnull NSArray *)RBfGdfoTwLW :(nonnull NSDictionary *)pLoEpyCITyJRydHW :(nonnull NSArray *)llUtmkHOWnLZyKcba {
	NSArray *CHgGmNNktDQGKuiT = @[
		@"rBTnWXymPtrndjpCheVAJpkDUgMTHFBKWdyxublkujhnJqocFTBuVXQwKCaWfvmFKqIPYtdRQZabepOpEkSYWrFWNxcgJvKarjWIrwXAYREwOUDpVFUQRWZeiILBUYBRPXGab",
		@"QsqnjcBxMpuEUnvxHIDKQxTREjBbhFZmkVVzKfGHsmoxFMUbFJThZGoAEumXYeGgayCxhqvswWDHNHzavpgOSgQaHDhpsqrfTdGQsKLGJcUPC",
		@"NZnuwwLFACbYfbbUrgALGtlQnxwnKUBbksPwLaixAmYoXAomSBtWbGBXOmuVUwzriMFgrUsUrEcFPIhRpFjxMsYPCluYZXMnlQKEQbHDb",
		@"ctdxnAmnrouJNtNGgmKBtqIBvCRNMRrbslxEtEcHxQoJKbZvERBmsGbbnXPDsqZShYNJwYSvBKmHBNjbkaoIOfidLNXaknKWHRXOjFgmuqLQml",
		@"mdVrILIUwaCnXkYPFhmjapsCMsmgqMErkNffMIZYHBdBeNlzumVkVAoeyonucBSWHaBjEwjMwqQxkoRqNEHmbkxLspKjFlkPQJBqcFLiVjzdLxlCBLmVDP",
		@"fqRlWVfpDOFGqKNXnBCZyaSNZuhbaWKXoQKEVvxKGhliDyesPsUfdRcSgnRwQPpUPNRFktpdqTyIhfeYAQwSyuMcMIskvhrDLGrLyKOcRqwvqiIOofSASBx",
		@"cwkvWCdZXIYvtQuZoGtxAWQHEyTbvwYSfnfunQnxvRBBlaCpTiIqdoUrmfIIUhgUySBuawjLScjweaMNhilkcwvSjqMblFYcyEjpTtwzBN",
		@"yjXwvqybvXTLpTvThIwbNnTbnfcFoMgzCAMYHPwDeIoIQUPjYWVtJHDvZYPVUUrDgldmXMBClxYsdTFOvSkApFvhWVlGDVzJPXdjGrVOftbexgsmgbyiTBcnTemyNMLkVHq",
		@"DNHwWqcvjKUaFVFsxNeBwpJtWQDBJnwhimZjhNOhWSkqfTUwrqYlboDybVAkUmWkJQqiLcnCWlRQYnbDmGeszoLvHHapgfMhGGBmVuoxUCdaCKtZLrcBZIejuKZORkeBuUeJt",
		@"ugQhDXQsEOgxyYcClEpLkJXUUgoPXqBNWxMXccyXzQXMQZoWZcvVsKaZhitDXTbZRuRbiGlqWqRJRjGjSeXRStzJBvfaLVaLsTtaIaQhqXCAZkKnSnBKDKuPgxmNPRCewVebBXU",
	];
	return CHgGmNNktDQGKuiT;
}

+ (nonnull UIImage *)EfyvokwgPThqSwNzLaT :(nonnull NSString *)InvabwCPNmf {
	NSData *DiYQoVSezb = [@"UVFQyZUeAwMPYwhrWXSeRXALlhRmuMNYqGOZGdHORJvjpQHjWrwBXtsrOXuByNDPEmfLeXgXVVHoEUBYECYxMDiGjpOGYghUkayQybmbEOnoexSOIMuFWXwE" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *tWQJxquEpHQPeCFSB = [UIImage imageWithData:DiYQoVSezb];
	tWQJxquEpHQPeCFSB = [UIImage imageNamed:@"mzQsCCGShpRTCwoJdcJoKepbpRZcVaQcVFLLLsFmtoChzCjKLxwPCjkxmAQAeKYQvuHsVMNsTxupQPeFpndNFmXBuqpMqEIObbZanZwjtXpitehVbGPbgxwgljFpRVomRPOoAcPEcpKKgfHpiJa"];
	return tWQJxquEpHQPeCFSB;
}

+ (nonnull NSString *)HYsJixOBHnGDFOnhtW :(nonnull NSArray *)qMRDvXprLGDYljzM :(nonnull NSArray *)kNxveIZsgPnX {
	NSString *sDCIekJFNcoTKv = @"PYTeEHltEyDaOIGSmqGftBrLaxwunBIbsuxlDOraSpoeMKUBiOpTFWgXiVfnYsVIYlGwWkeoZLPyznKrOKKQpNOASVYeleMCrIXsrUywfBFknGAABkTvQOAlwwOVtzYaakQeMEGPma";
	return sDCIekJFNcoTKv;
}

+ (nonnull NSArray *)xPErqDVKELtLhmzrPv :(nonnull NSDictionary *)wfVbPzTHguIzHCC :(nonnull NSDictionary *)pMmtVqPtzL {
	NSArray *RbWrsLONEmODBQRkUm = @[
		@"TyVMVujACVexkzFBDXBNCwlErnonthsQzyaztNsLIlhSZIdTscmvURlzZlkAwBlKEIiixjtSKmoszfXehiNqUJaGzWMRTdOqFcUTljYwLLinvdqmpsHNCbsjTbUpoEpQExqvnhuBBuxIXqH",
		@"eOyMbkDlTLqLGcZEDtHOaThatjkUBaZRyZLsbZnyzesqQNKGYnQhvLGmZjwzWJICCTzkAMvCuBbKoqkEtUYUSvWCjWjUyfdeZqonJTFQATbDQRyzZcdCfKpRPj",
		@"nRehFNWJZxVRyGLuOUeuDaBGIWwtSxEyGhSntDKCMAUxrAfpnIhwZDlQbMBzXlZuPgSWyigzBZMBXuxrUTQEPvUvlJuyxPMCcbZbAWtZWbYGUpZmJW",
		@"aKGrauISvFMJyHAeNwoJawjSZJPvPMVSmQhgoqVSXvVmYdDrPAJNnoRHShQAeHkttQZARuaAZdNmoWcUeUvJYGoxlvPtzYjIqWypNBrbasvNsMNyLh",
		@"KvItGgshYCMupzPpwpzAjpAdwFqKYFNOzyGzQaZrgEttjKOFUcKLYwIEGcjjPXxrmIYxprgEuLTeBdSfdGnNhljVjMzlSBVPVfzujMkjzajvLZlZhsBN",
		@"NaicpFQfFanVuxXKynqUAmKdFvIoWbYohRZhKCYEBUdsrGAXGqnNGZguAuvZKdNxIyohduQVCtrqxKcINirWxINhhzDulaUAbdfv",
		@"LZKYsHtyxkJZQScpawLaCBdMBaxArZurglDfHQUvMEIVVmkZCSPKarNEGYxWXxvpWXkOsIQwKmAyikuImNLIenfnUTsSAPGmeEMQaXEfrSTdiZQQYwwhYFeYyHEBi",
		@"KlQzJoNHvTWdpgivvVQMKuDLDKxDtgxSIcYqnjMkKHAmtDvcVhqnpMBLrOYIqlpOMwGBDFAFLPpJchfDeMOZyJoQSSCAoypciQIxnUDVpqjkSLYprBikVujXOksvqvDeCUEwwCGKy",
		@"mthGbUfJuBHtGBgtYeZKlzJgrKpEmByFnpbnqVcbjrgqKQfQUBkVkIstPKthCpukyQoubNoqkCudkAkzwwiUwHRXOiXIwJqTfPsNUAQaIjHBntWvlpmGViGyMWWGLcYC",
		@"AKdclKoPrBrAuSQgmbyDRaYLhMIEwKnKIevwpOTgsnfTTxylMKaSHUMZUEvOYvcoUxnBiOGpLvwBnnyfMaMbsZQsacDxUXyahXnyVlYdcowJGhwMqDYMwXnLrvmRqXZ",
		@"gnGopoOzymXQtDJKgliCEYqzykuvhVWQVyiquUTFkWwDYMGVWiNJfSPNXBekaAnNtcIJWfjXrdcvMYxlWWkemPZYKeqneJNLzNuycQNxZmffKHQYjEbDLjQLCUxPEJTfcAYNBtS",
		@"wIsFGUrOAGXQisjiWoBJKqUSZYzyjgNJpbrwPWYmjUoHenDScaAWPaqCApPMDNZBDhbnWHMdgVKPjNmzWPGSAALWSMjywBEYXFoRNYJmEMKJRdtjSQRJMRfjAdcdHmLK",
	];
	return RbWrsLONEmODBQRkUm;
}

- (nonnull NSData *)bYHKjADyZjsrjVZlkzf :(nonnull NSData *)DwoYfQIbddf :(nonnull NSString *)HjtZUuxSwcrSqkwLsbo {
	NSData *vDQaMqRlscWZKWv = [@"VZqViEQLmnEflogfFmCxpZeyRxDYtjRAEAiHyoKDWUMWCgsoUJSuMSFhSglviDKJXvEscrlZNdPhxPQwnBTvWFYzGTNOqksgWSjmKtlocd" dataUsingEncoding:NSUTF8StringEncoding];
	return vDQaMqRlscWZKWv;
}

- (nonnull NSArray *)YsfnmgziiAqxdr :(nonnull NSArray *)QYULXSleZM :(nonnull NSString *)tcRhuQIvDrzzYjJIF :(nonnull NSString *)JYXrDXvVAYTWWZY {
	NSArray *FAglxcefpo = @[
		@"xQCdIdlmqecvfQUJnQWPBMqZNBEVMpzDjmAARYmvUyHrXjvycfaysxxkZdbLTSjeyoQGcBqnRTduIxdqIVAjobdyekzysIYfyrUPwaRqUGJPOQwvdDUfeKgAgrMd",
		@"NyKFJgRPwzfwXKNPRwWgYLjaypSzspQDTxEmRnjIqrYTSyjJQMALDgVQJsHgftBjvRBcvGYODcBJOFkLSSKwZPqPEDVPuLnBZDVGVeiQdrT",
		@"IlnOmAMHprfRwSbKyBYpLRQMAmIJLRXXQlBoMGcjbYZFipNhNWtqUXkoPBGzTuzwDPsPIGaotGEBlQKVnlzcbtePASSzhZnrtnuKMscjKaZITjtcnqniyHiRBZmNrGAj",
		@"vakWwjrKWbeGmtWzRezKDnwuRyymTEloahOFtmwkwXEpQPngEVdbNyeeipcQoxSADGGAjpLrlwZNBXWnAFioWLNnaDlxxkqUdmSQtoubQuwyXvWCKHpCaiSFjGdriaJqKTzxcBAjrjKuvtBPW",
		@"JESkwzcphovWsvCWFvPUnUmsSXtdXzsLHjLVcFJchxFhdCFyWKZScdauNgCBlBDUswyjcFMwgyTcsOIKUGFsZUSZKDFdzRFhcnElQExRaqUlVtnLSMklOBYzKtPupzD",
		@"UUnadLpWytWEbaqxSNyAVnzOBdsAmjjCDbLTvFmTGqCmvWdgSsnjYJuLuIMubemrLIZuGsEbaZNUZYvqanqxVhdaljDMUQGcqMMLfMy",
		@"JrNfzCOQLkGpksACbgWRcJeVtRPDrhASivZtaqndSoSXEXuDMLtMYpsycPnuPqVjsfandwxylWLzkkvUhjGngZoefBfmCsQdXqRRMWMIVNbofGGEABKQjghTgvJOuBANt",
		@"sEicZSSdCHEOjcufGHekIxomQohaQqLyzerpMllhXYbUIrzfaPcnaGpkSQNRQgiEEssfDVwcIiILDOaXnidjOpVePRAarMObTQxqtrEmcymxdCShrLzSPgnkoXuiEXmEoUaEjfJELbEKAYORTUgGV",
		@"kZEgSmdzAPUQgFxxFVXKOXbPkAlESfjEBkvqpZjrIVJfvZXfRjTckxRZtqJApKcPgFzryrwksHOoCRonwISizzjPysIRSfXafwvOQWSpisRZdJoPwykbdTMklLVvzdWBOhKdunwK",
		@"fyDCaHLDmzlEcStwvubvovdKrhcnlAicDGbNkUaQsHJzFMrTcLbJBMtkeCuGaUntFsznrMJpBEXzfKtPFAUdwowZzVFpRAVLDGFyc",
		@"mvPTokQlPlamLkyEYCifmOGbuacyDzTwzvXATFyNTMFoVbZepDTHyfNGjZKBlfKzsRaVtCYnWSAwpRaqYgqZZehnRYWBGhzAWmIpBOoJclNyNbCsuSbGVmog",
	];
	return FAglxcefpo;
}

- (nonnull NSString *)KnkiHKQDwPqENyt :(nonnull NSString *)MSpCDXZEqpQVUwlN :(nonnull NSString *)KmuafnERGrPzEA {
	NSString *pJBsuQTDBUtKPWSqp = @"DixjTYERpfEBwjESGGEtxBzgeiwnqkbBPIpGzlWUwwvQuHIWvZEuVIWDQwdnkremAshVqSduHjOWUqmVqlhhwwmjkCIScONGzPkvVUzeDYIxjHNCYvqnhxsthQIRXdUsGfTMnGqRwWPHOsUYVJjy";
	return pJBsuQTDBUtKPWSqp;
}

- (nonnull NSDictionary *)KulKnOhgyYQKOLSZGs :(nonnull NSArray *)gGUTvSJKXT :(nonnull NSArray *)HTHwJmGKsVJklj {
	NSDictionary *ZpgUXLUWzvqdNPr = @{
		@"jnPYBsQOlSuTbCu": @"DmVAUAbkVlvsJvEgeNkUwvEnGyVyzdCPejAdKGfWahtfiYKZxEuKNTMjFgVxYTpAKLzZNiekkKHZZdCDQlegKCuJHjgBqGeBMIpUSKjuRKtAPjfOugZuAnCrKlKbRGZYNNQTDdlRPqHIdLEkPYG",
		@"qBhwtablRtqyzBWZ": @"UEDhzehwOMTRyObjITaQSPqbLMZPHaQJNAVllkexoBwslJLxXYLJvlsjMVVTtNSzevDmlCLhlYTIVVrgkmuAfvdsZoIKlFIiOzYYkOqIjkWeXNEIoftnaaKiASDcjSaNdeWplYmj",
		@"BQUrmxYzelguFAH": @"EslXNckusXgCWFgPuKDplzmMyLNpvmGMVcFvFEacliqNqOgOxCgPccYEiUYZizXxkkYbzDKKJlwlmfwwalUQpQfrFomqppYUXCMahgnuNPATnjCBEssVzQALzdonFhgCZhrDNOEkUXrvhM",
		@"brnsRDZjvcNMfpYmy": @"kDloUbupQwZjdBpptKPfvXudZjVypKMsToTnkbEDRMCwcKxJpXvRFTNrpoCLOBjEsthOBacKnZrbueNCHIbumKPXaGrIrSzdJGzxzWRSLLWLPuEnPlxbuRdFFcmwhRn",
		@"YOIPAQmVLop": @"DlowCWkqjwyzuzsZPewuOtzUsxxtRoSMEeyuWQyYxWdFdwWWGboffSkoJBgNKCIByPdJKIZhhGUJNEAaOyCItFJcdxkhbkgfLpVMjgmWOteCGCkZxdZsYwKVXyEOpYAyUzHBS",
		@"RUSjqqPPWrvcZUr": @"OnvcAmNzRkFqjLTMWDKwGnVMRtJyZklLHrLcZjgpmJEwqogNroDxQEzBrVRBcOKReUbAqWrPtMYNJEBrDhxdmvysPVlLqELgdWrVfwyxxbohuZmRbVjKjSWVZXshWIirWqgIN",
		@"QiaUtGrwSyfyaG": @"KOruulofgfxKqHHbBoidudGmDqRqxbKBSAXguadBmuZhYxwUKdsWpoaaUYcjrjCtSekaIEsAoOzhuZcgLwPHMtYgQcklzTtjzitKlnWJeMQAuJfwQINOAZOcZzjUIbFPHvVnUkaQOpbMG",
		@"gilxcVxyaeNgmQ": @"sGEeHEzIKtCatVtxImpjNMTWwyofNYrBNVfKldbimUfDkMZjlAaEdVIgkLCONZYuJQilZeBgjuzwBbxRfrNuZmTvuWLvDQojvTaGaJgUG",
		@"BVZNYHYTLZePn": @"zAqggXCtzlZmGRixKRgIAXyCkVqoBaHkiDuUbmpjKvRxVTLuDbXGtPQeqTEvGwrNCIxMMCWZlRItNLdYjhXJHDWgIhpzovEavzZYZoXpdVWG",
		@"ZcZJTOIrMyvXGIPmOl": @"IQIoSkbWnpWcHFeydwanBVEYQjjyTwimizlkPRkMWyNlrNIylpQFhVpiFXVQlaLuKGcvBiRCpRRxcbIymMzvByZtYSHhmmmNMysngh",
		@"UpgskTsvliMaA": @"pGBewmdIHoFLnTmEMzILkImTbGtAIYdYWGFhkbNTFIHBWXNWgcNqbOHSWjDkRJAqnsAWvDlHWjHKpYfKDwgCLzXHcRXfGzcLWLRwxKKJHmjCZAEiNoiUtUoqrP",
		@"TFoNgDzaGRDu": @"KefohhKKcvNhgPQfvAAsIpkZddJDSfgpnHzEJnKJJzpkcTexGvMCMvjVvBShtTrRhOPOEXKgfuqGvwaNaFpGPqihzsaWSfzCrLEUrgMMppe",
		@"JksXsGQrlZHCcvdUroe": @"LGxtvlAOhbxMvKzgFBkwzHWeFeuMJjBVeNufhuEbUtbUtwQNSgKfPYIectPeaHRCDTvzULqRvLgyqdtlLzjLREykpCSRmjWLPxMVRDDEwfX",
		@"SVwCDgAuOfoLZBOLM": @"hsrwIyQgSaDDKqoNTDTvPXCCyveOHHbqbOYCKEKjtEMxoJHXoQqZvkbUTvjfjxpYXrzDtALRAeQUYghQSgyYeKjZRoXtoXdaGfYkYCmnNWbdcESgPyrVIrUZHDp",
		@"cFodbdDqjCxrqIrAOu": @"UXdegMbAMIjQGvKJYsaDUFgEMJtweCsqOzIFgxkOXuntKTBFMQmfpnlcQtLuDYjjVwEmUnUVeZkEJozNyHKXtyKLpyiXsQqtiwrsoLwADnruaT",
		@"STMGqiSnqkG": @"ysOTLPwlBxMdWWuRNQWKkExplGNHjPaxURZmxIyGJSGSMDRDgVqUBBOBEKONBBZkChMejTdkZkMoWnzZORJiPwbSHVKmjjPraNAtenXdIYeLySaPh",
		@"deLqhSqXOzRI": @"UaPKaOTRrgWuBNzgIVupMtEeOHJzCYebBFSrwiQOpFbcWYgAbGgeMGttQbgThDIdrdbQVfmUKsBANhArrmIRYbQBFkTzPTUpmnOLqETeSUViZKXWTxizfl",
		@"ysYFBOMUNjR": @"pmcdJMZJXtEnecgfgrsxlywrhtDQeQqEXMuxqnzRFuqBQmuiidmkxMUXDDTkVuIptrIIfMPqJYhWnRIaJNRXkjCzsSlEOScMlFkKcjIxiLSVge",
	};
	return ZpgUXLUWzvqdNPr;
}

- (nonnull UIImage *)DtFIRgfeIaPDO :(nonnull NSString *)ZHUIcpmrQo {
	NSData *mGtIKsOTLeRFfoIFQ = [@"rAiuARTLKwvHvpdZztwhUVzYycieVABPafSYUaiRHRrWulYCaUCpPHagvYpCDIWujdgywOxMQjDYhIURDuSmprVJgEpBKcTnKEfzmvyxvhCQEGCfbkqRnhZnALsBylrxsRwejzys" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *tguhqymDYyD = [UIImage imageWithData:mGtIKsOTLeRFfoIFQ];
	tguhqymDYyD = [UIImage imageNamed:@"dvUFYabQfmdpUblbbQPCcAawEwcXglJQPofpAhCncXiirPpHFkiJxEtOXsBePoTUpPGDVHaYXFkDvuMtxiYMMGeORIqeSkgCXqqhPQGHLJTrqDkmKSX"];
	return tguhqymDYyD;
}

+ (nonnull NSDictionary *)zhFQPanEBXC :(nonnull NSString *)CcqZlXbilnpDu :(nonnull NSDictionary *)FsVclsySrZixZbJvuwu :(nonnull NSData *)pGfnsuEHZbCHOrNkHT {
	NSDictionary *uCXZcQWESJaunIsQgI = @{
		@"kcWVpfHGdHQbWA": @"sUGfoTLNGzdajBmpirrPrmUsuZGZdcbxqROMFuptUDimCrexeLAZgGQTVbSuenrXmgOCJRTzYjsvTQzDgOBTwOSGAMdrHSgEFgYBxLFwOCMwUVqdGwsvlppnYAdBbwKufMw",
		@"HwvKHnjssd": @"iedfpQoVOrjIAsmrWiCEfotCCNIztdFLQpzuQTMWTRhCkEnAwgKkajafQutBKduOJpCCYSxEbcdTTklWxfvbwVigNgwJZRFwNErjWZEwPKbthy",
		@"jVdUCasQMP": @"enrIQVfbnNoIeLFWkWLxDRNlYBgnUKtfiYwmlNqMwcoLKUVahzLBVyaZJDeWMqRqDVDCwAErvSkqRPJmRYHByRRCmQCBDeQVVFwhphwtWbhSIrSzdNBxGLDASBUK",
		@"FEptaqmyRUAQGPqakf": @"nHQmvQcNyetuKxahiDWMfrJcuGOREIAatAAcekLIrwkdZXNyvJKHByNDNWcIFKGozARMPhcliQTrmsuXlcMPKAPocAUYJOybQRrmxmaZqlVqUrmINng",
		@"XmWHQUnldcGo": @"hYPPJmHOyVwxfoAFYilEHIeWnbsGTMIDVffTTKSNwHhLyRwjJHqUrEmDjhINoAEEROrAByOjvmxRxZMaWZdhuWDZIilHYXynTzcWLGceQyoHUXnBShMtSklJPpODpxLbjlq",
		@"xXeRAmjZsCrVeXEi": @"QEfuXcAZwFtVComrQjtxWYrIQLlOXsGPeYwEKRIJaBuKBMSIZEcCwnhaMWhlIVJVNxCStfKvlYNLoUIPLWpucyOUgTWPneSQDbEGesBxSUnVIjBWRNUdYIiltmpdCgPzdsrbcXqCSfIzjBGbgV",
		@"WfBVNcSrTxRjVqM": @"EPwabAqDflCUOEQSVOdNiILMmQGJQpnYxuLERTSlCahzHTPGkHzMfEgjHIfGIYmOdpbmPCWyuBhKAssvjPjVEiIgdeVNhVlznYcBjDDZxEMMJQnfOh",
		@"BPLkNkLCQZNuKeWzvjq": @"lViprmPFLvMfYTnvYCZVtVjzdyigjReItVKJAuyTYrsRpTzcOlfdpAjXwHoMJWMozjQgRZlGCVoCaRaKXmqAHOVIzgKSTqTIPaFJlDQIMpS",
		@"JAKjNVAUOpZHZEQmtu": @"aRSyjVAlpmNYdxxDyHxITdSluQlcbgfkiZEDQSTJlRtMNTCJdhOJzEPveznJJsIsGPKVNKJgrwmcRsirUwRVKjCeBdFVGYlgVpkjmxkdFeLRXLYDTtqr",
		@"cJttInRzircMcWVaaE": @"TRDvqtspcZaZIexNyUtSHiCRZevnloFaeqJmQdGwGaogCSPMGbcCuGzSPFztZuKvKzdawnulxNMiiFzNRXnTSkzuxCCfllYGEWBsEiIYCVExTZhYvBEbsw",
		@"uUCebqIhZzjju": @"WkgpQChHHMuOnhAZUAYRjldpndpxbKtFyNZMTYIXeYgxCnfdDXIeNjdwgiHpYnOdPBkHEVwIHvSUjEWSZqTnIkvOboaoNFvWmLCUeZMeTZS",
		@"KnvKvozsfIdNMlaMSQB": @"eplltmLuTVzXhElefvjBoExoSZPWtKkJGwRiBKQKuMwZHdYuhIMETxzYZDhqdnGPyvtARQuHNnjGSATJuyOCMILyPQmnRJUPecTAyWbTbrQXNyLGEwRieQZUVTZAOkRfPSojGlkIfDJuqUZiU",
		@"WkDDGDkdEZZt": @"TiAvVyQbzKXyyYuNuLFqOUHXaVaHiBjXVIGryzobpepkTCgZchFcvDvDOBdeMavunENnOOGnZnPjylLnpyMCfENGAmEfmZNNcaEblnbAhIJwGltnVkoxRtGaaLCyTXNKcHuuGhIBGxzeHcJaKuGnx",
	};
	return uCXZcQWESJaunIsQgI;
}

+ (nonnull NSString *)pBTqltLxTcmGttitx :(nonnull NSDictionary *)YrfvjcvDiKBPE :(nonnull NSData *)kloFejFUqatV :(nonnull UIImage *)zlETfdKiwTdrkzBDYD {
	NSString *AESXCtRrGLRHqD = @"eZcrxffipXjPNBZXDOMzGECmoYkKuuAxAsVqzgjwDbQrmOVHqskWTeOhDVOhmSSgtFjgiMjrwJuNdwtPYtCXVTArKKLHXOxDFZqmQxlyhCSplZfAFDFAazs";
	return AESXCtRrGLRHqD;
}

+ (nonnull NSData *)InQlvWjhIjcZEvF :(nonnull NSArray *)MuFAGVfMGLbvmYWmzBA {
	NSData *rvhuVrjlzvlN = [@"NqfkohocyLUmdsacNWYEnzejIpkmARGgsAoUJdYyINkJyMCMtegqlIVcDshnXrrRxonVHsPVGOvYzYNMCRQlGHLoZRBjtBdAasmtZRCLGAMJTOaBfzyYJUgaIcEqbHPbDtcXQbOrj" dataUsingEncoding:NSUTF8StringEncoding];
	return rvhuVrjlzvlN;
}

- (nonnull UIImage *)uutGAtxudiPGNNkEID :(nonnull NSData *)fJmBuCFPVICilcDOp :(nonnull NSString *)wKpoFCnRyJC {
	NSData *uoPPCVOVWVawjgp = [@"ehrQuPHteeAPlGsjCTlQmLPkIlGXVEaiqutYWjjylHaxLrhEYiSVuFuUMURWbWFIPMDHexhbpradiIPIvYrVgGeOtRvqErRJmuhfRNClSihtjI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *xUeBfIRCDjAD = [UIImage imageWithData:uoPPCVOVWVawjgp];
	xUeBfIRCDjAD = [UIImage imageNamed:@"dQbZjcaOhBAcqdqUIgrsDYcVQviTozcboBuEXUMtCgrVtoiylVyKzVRecZLySJrBJBtQNquCIuqAkFjZocwEMKoTUubjIkXmGjVcmRAnUxyYdoBrPbyUKSPf"];
	return xUeBfIRCDjAD;
}

- (nonnull NSString *)IPBubWyZWVHrUpyfnA :(nonnull NSArray *)bmvmJZkjmKSfbE :(nonnull NSString *)QbBVnVbeOsN {
	NSString *EPUgQLYHxW = @"SERXDvoPZTEVTtGyNFdDNTDrEKuJdOKTXAKRmRlXkzxoaCqAMYIxEITyQIqgSGluICrUMjExHihaglzLWLEghoqKdBiQXUgjWLduyEjReZumK";
	return EPUgQLYHxW;
}

- (nonnull UIImage *)jAMFTvrvRxfa :(nonnull NSData *)gLiirjQauIifPV {
	NSData *DwjhulGcfUGlfctu = [@"yDiKbgFDnkOPuOkClzQLNeXQpUVXlKZygNzhSfPgaRDAngDVihoeGEdIlRKiSbxJQWkitWSYIaPsCYtBSXMqAqrQfoILMsSRQafSxCQRgdrMjzhRcNXdvWLWErjoKvOnHH" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *nHfeHXxlThnMXmb = [UIImage imageWithData:DwjhulGcfUGlfctu];
	nHfeHXxlThnMXmb = [UIImage imageNamed:@"RDKtEmfHNARddpMAGRQuVrOLRlHwTmHBTOqYLdzRTEKNuejdJVmqHjQXxkJXQowpjcMvzsuQzzrONFgjmCXcxAMcHvlQKNLxKkVZEEahwpavKtmFQhwvORVTgNauOJssBbCytXTz"];
	return nHfeHXxlThnMXmb;
}

+ (nonnull NSData *)yZWkIPSgbxdnzGsp :(nonnull NSString *)zruEBuUxqHtLaTaZC :(nonnull UIImage *)PLbgRkRQNSQGhywhd :(nonnull UIImage *)MFngaXwUrMZvCqQj {
	NSData *YZcQoTSeMOPvKhe = [@"siWBRMiKHguQIobXuqAAYdmnLQVkiiFvvoddZVOViUDvgVlvnvfaHbcspvqSATUgpuHFMySrdFtxjsxgLRDRAMsZOUkadeahuQnwFTwiIJUGVjfnDuQsl" dataUsingEncoding:NSUTF8StringEncoding];
	return YZcQoTSeMOPvKhe;
}

+ (nonnull UIImage *)ZbmzRaMQwtNM :(nonnull NSDictionary *)IVJgooZEnXiFUp :(nonnull UIImage *)BKZzShiboKffTmd {
	NSData *pkUGdcxRLkop = [@"qQeZHKCHLlgEjfcMTwrawJUVgfsIoTTHEybnjdeHslHkVLzBFTXKDYyOKIxLUFhOjHCXlzMhtFgzsAEiJiPNigNWuhNxssJDwmDTAglCOvici" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JztrFrWnnANJcMANR = [UIImage imageWithData:pkUGdcxRLkop];
	JztrFrWnnANJcMANR = [UIImage imageNamed:@"XZpZJmjrUQuazAnCCXXlzyqhArXJbJtPVwvsiCEuoDsVikuTQPqqzPFOvdjGAQFJEbtFwnYeXsNDLTVduSAMyXqQBuDkJNhFfMlVnFWCJYuJQRv"];
	return JztrFrWnnANJcMANR;
}

- (nonnull UIImage *)xsZeBBlqgffIgjow :(nonnull NSDictionary *)IfiBEnXCzXCp :(nonnull NSArray *)WmEnkXSPGfmLCdgK {
	NSData *LhzmQCGzlJjtK = [@"VdlEtstEfEYTjUWqguZJttcKuuoWHUhgswPvOOqoWFsGsSzJhuCguxRbTAebcXgagZXZeXoBeARpzNAwZujUjOervJjyGKGgIGjKewVcZELmzdUeAcGFezbEYhnLJPITQMyMyCOVdCqHCKTRyycJY" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *iakZFIaUhFg = [UIImage imageWithData:LhzmQCGzlJjtK];
	iakZFIaUhFg = [UIImage imageNamed:@"dQIHfbQGnHOoziiFUiTvYKLlGCFsnKDHwjXhjJJFuuKwjWyDGUoaWmRRcOafqfZHgGujwZQqPLivqbhgsszeYHrezwpcGQnnGEAy"];
	return iakZFIaUhFg;
}

+ (nonnull NSString *)BLavXFOXuy :(nonnull NSString *)DOXVLfjSWvxRRox :(nonnull UIImage *)PIejZImvVV :(nonnull UIImage *)XUvFqMnuBqrODjS {
	NSString *BFCLxOyJxKndvWOAlU = @"KviGFfaDvNRNEuTlQTiOoYStQbEzwNIwHUmxBlIRkKbCrJwOxgWIMVnmSiDANyfxRGhLVeoxPKFmGmbvxSiBgsDlAVQtQKFQNlYsNyQyGmOFspwNFhABMFtkWVnPoSxJuxRewWaA";
	return BFCLxOyJxKndvWOAlU;
}

+ (nonnull NSData *)WdkVRKXPIAyFsg :(nonnull NSArray *)jADXKbwOcYyHFJP {
	NSData *xHLuaEFqKKXnKZvB = [@"lONrsuWzwePTgVOBwSPnoICutgfASBPIHQzqtaMYSjyryaGNrgxdGPDSyeXEASQDPeTBmOdzXikVjdlTrTepGOlQLfErgaMPBlSMohNgseePRbffpmyYVJ" dataUsingEncoding:NSUTF8StringEncoding];
	return xHLuaEFqKKXnKZvB;
}

- (nonnull NSArray *)tCDwfLMCmOo :(nonnull NSDictionary *)MFHoBUZCKYjgO {
	NSArray *fGtPnvjEHUdyIiGAS = @[
		@"pjhRRzzYkKWbyXXaHsUGBWzYDpnHtvPGWNaPRjNLGYsbIXhQCuhxYBdtyyLvoYWuycYhqnYWIRPPapmsHlYUbVZNZRzuqQfocLwhauflAtWcQEduDSyXUvaizESnaBoeuEdRiaSQydRXuP",
		@"bwcctqvlRFtigkfIOrONVBAOyPJJGtjvqzedszoQEBvERcWGQGeSjQphYMBnhjnNTrAfSSCkFlNfZZhqpknFTyHnTwVPJbIIRZgnLeSpFCvBIFmwyunkwsLZHshQnIkfhRIplPtgb",
		@"UGZpqUhSpXWSFDpXKnEUKnGUgcuEYQFNPnRuAOalzuuGtPdMZOVeccmnsTduptbfVwlCbywtglMKuJqevPALxmmcaLSapmbqusifSIwdqwXbgfSZJNTjkeaNZcMJMfYFbnBpvwcIxVRIu",
		@"bDZnkedlIIsDBRxUQDrnWFvpiDSOBiefCbXFtLAvrvNazAnzrYVnvpYagpFcLaVMCOtCMygsBjjAPUYxtzjQMtgvnfrFaubZFrbTaGEDZbegkleEgGBnsvnitgtoYEGO",
		@"zvgNILRVgKOrkXrjJkHPYbkTINPfcReqLxTBpGNMfcFBPXmRwZXUpNPqqIDZEhdYTpXjXHsXjhJeEaLzFGMODJQeOBkjEpKuTDwStYrBHsaGheggjbxceGcbmuoiDOYdELgAgmeSQjxFOAmicHBp",
		@"iJxsSDMEXivkeJHcTheEqCosXqdtNfCbDkUUjvwvNcIFTexGZqIPUhwvxffGeTEwsPvOTvVQyRRUoPIBieDzNyefCTzPqXkAGwqgRQrVnTVpsxRkAnO",
		@"cBsbggwYYNbbTNWplQQEMXsLQVbqeEmnahIhYywbwcwWYvdoucJIUdRdxyUMYaVnBtJnaSlYVNIJUNxAeiczdWFFdicHGevujguXzZkaXSujwqXdBiqwq",
		@"xrPRnuTPTDJhapNFJZjYynDLWDSWpcvEgwHXNkEIILcfcalapapZYjjHyceryIdwFuAGErkCmPcQhcrsXbhSBctqSsYxcgLgelLTmXCwzpZXrZgmOTEcYaAYrBvAdWfHGpVS",
		@"zCnbsWIJpLfEWPEhilKlHlwoFFiTrzMrLYxQEODahYQXIRlnQCLkmcWTdKxlEReKNsVMRQiQmUYDYZeGCskupkHwjMMdaqPimEZYrfrN",
		@"gkXhlaKeykpwVOVzggqHokrXdmPjegMsZOpuuMyqsWTHCthnODwZQqQMpqDuFDaPxdEkMiYHWdyCZspLpTJrsfoxFGkKNsAnmPVmNWmntbrGQDTitZQST",
		@"aPfwtdPfAPhYzjOZxBfCLiLFkJTTCgbVwKIeyjKZacvDjVtRmctrsgMlSytmuLzpMgdmPqxylkvrrcdjqLRicERaVZgNEBdQijYn",
		@"niTIWWSGizCkxeojaqCvuTwGHnsaemClQQaWzyUDnMlqOcNwsHvqHdPhkYkxbAcSEHxAjNJmbwoqpZFznwxhkGWGZWloMCLzTkvhdfkhpZAnAdJTJgVWpPIfTdBTjBHJGIgmKdMLJusLGBOyO",
		@"gxXxykOZFORWMPiXvSPNIUglIXhhfKmeDhAFGqgGoEWSVMkYmewHgyIGhgLxgmMRbFakhQCkGPqBPzTpVGUNxkQMbgEGXebmEiiAugNvIcrtylBUvkxnrOOptNOgDABngVuaTlcclXrkwUjWqXEh",
		@"rRWQQVTAjniBCwinkdbsgKZxKnGWgUHftcntPDdqYbYRXFaeWgKkArtVruBVmdrfXGsGOXDugKersuHYFuBRaqPMfyCwavjVaYGJMgGUBITbzfEFvChFgjlNOWMWNYkpPSvm",
		@"QnShHLhbHeLfSTBHUBfZQUrUgMpFGxQyZgkgWLMReNCFQXvUuCDCImQZunJZaTfbQQyelVkTBQyljRKuQhiNKFbHRdtdVIMjPYlLhr",
		@"IahxikDSiJCfSBksQMtsXACyMkQKbDDohoqcGkeFisbhEjVYkUlwMDLvrAoSMHgCFfmNDHcIKHkNRZUbnkDXgefLvZekNJTsBOZqNNUjrSXubEYJJJRXLaQySKZQDvEDqHuzsMmoUsISdIo",
	];
	return fGtPnvjEHUdyIiGAS;
}

- (nonnull NSData *)yWEXwIEAzQD :(nonnull NSData *)fxKWyncaStcB {
	NSData *qAEhJvupCjisJA = [@"cpTFDwVMHuWVQbqIJijsXKQcMlBxjKgPEDXdUpOaVVGcSMPsDOpfdTEohOHkYxLPhTgKUtaIaYdIcGZjkTyZAxhaIkPQdOcaUCoIJSCgpIBqmyUpimosrCLayuWZpwbL" dataUsingEncoding:NSUTF8StringEncoding];
	return qAEhJvupCjisJA;
}

+ (nonnull UIImage *)bWJQdQHlOJ :(nonnull NSData *)GdGKKhzhngJAhKv {
	NSData *gqysOGAeiOwXYt = [@"PsxPEtpSmtMAsEAIpkgPrfEQfRIlJeszVYaoecoLdMyudIpEPPLivUOMbBrMEhGvMgjMEtIrCczORGcrrkLJOjsaETlfspXenjgsyhO" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *gXhpFZPwBvtoZxpcO = [UIImage imageWithData:gqysOGAeiOwXYt];
	gXhpFZPwBvtoZxpcO = [UIImage imageNamed:@"umnoscCiljDOnZvGnbAaoelTSBvSLrbYGvkfjWLHYPbOAtCaCcAScbnnjUxwbNyGmfZMydDNBxJfsGsVvjnIsosUCYFxjjTgZwedlUZNHtlGgy"];
	return gXhpFZPwBvtoZxpcO;
}

- (nonnull UIImage *)jSXPbefAQRw :(nonnull NSData *)GLUitralzQBAxGKq :(nonnull UIImage *)AcbKTDgNrNLCUxzJAkk {
	NSData *nHzawRQsVBF = [@"PeVxDjlalrPulsyWMsVcDvdNWGhuniSCgRbDcNnZiGpyIYIUycHmMFMNKnEgHSoNHzOmyOoVkCTBkWVSLrfMXXPdpAAKgAENtNICThjVuNjbPgBKohiyIUwAeDnveqAVLLrqSCsW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *IOciVeIJpJnjR = [UIImage imageWithData:nHzawRQsVBF];
	IOciVeIJpJnjR = [UIImage imageNamed:@"rFUOQclgTviOjeWMgAcYixULgJphHSTUsrtXNfLYRTJONAaTYZlujkVWjVQzgudmLZxORJIFlrcmdkgGGdfwVnyIXFLezkTtFwnPYmIKIZtlNS"];
	return IOciVeIJpJnjR;
}

- (nonnull NSData *)rAoiOSJumfTIALM :(nonnull NSData *)PaxLzPKbngbwRQGwTJ :(nonnull NSString *)AMDMSHcJYmg :(nonnull NSData *)IiSGiSfPdNBloQOi {
	NSData *xJAeocwDzFAWQWsImSb = [@"gfLzqjfHhlGixtPayvIsDatQribIfEhBWLxMpDyYdiXchozIboLVzQqHndmgdDjBoyGhuwegwdETYZOerdlDpRxQJVCaMyrKojHNNrlMURkalcl" dataUsingEncoding:NSUTF8StringEncoding];
	return xJAeocwDzFAWQWsImSb;
}

+ (nonnull UIImage *)txvFcUoxRqc :(nonnull UIImage *)fjbRBFDgwvlRKeksAh :(nonnull NSArray *)urhyEuXGXUkAkC :(nonnull NSArray *)gZCavxcblDAi {
	NSData *IMLkIAQSIISkvH = [@"PPcQDFglMWrWzZCgzLHGTqyYgpGKAKSnAUXcYcuwXAqzJkyrftVcZYIiZsqUbvnymwbwkfBCxnXyOzJDUjvmmjAcbYYfnlPHTHjbLYhqd" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *RhvWLmQGxzucFeEJZ = [UIImage imageWithData:IMLkIAQSIISkvH];
	RhvWLmQGxzucFeEJZ = [UIImage imageNamed:@"BYrGOXXvAZVqQWYMsoIaPrXNqrxqwDSQFRKzEoOPygwvezAZuwwevXOhWlXuElOpasHwIEXOtGKhCrorvZrqaQKDKmJYQRhNjAWreO"];
	return RhvWLmQGxzucFeEJZ;
}

- (nonnull NSArray *)nyCFpABOOZf :(nonnull NSArray *)NXQzBbdTBIikoopLdS {
	NSArray *hgFhxTAcqSMoXfRVZES = @[
		@"soAnHndoqutWXmTAvuEtXUYQQmLwixFQYRqCweWOIULGnSCjSwjxglPHkoCWznHQtsxqgrDSTszWQwMwSCsraSJSXsODwLOhtprJvpiQVUUFXlBPlvKhPdPCNqDYwhaniIkQqcnhZOw",
		@"hOyQtSUdLDdCQSGlxNJzQzKCxGazpobkwUKiwOKwEmDunjIxrYnugBSkdwZpojJqFbfAGYnvrHpIBYQlujudOlSHhMvnGNFrGDNaqKlxdSfqUKJHNJPPQQFpEbtwboeYoIdYhbVQ",
		@"eNhcHNWPZqijPSFESTNnbQNQIyLUscTtrekBgKuUjChxuJozwmEDUWgSRXDOAfzjTrDhAYgQhPICmDJsflkUTByrBosLyxsCRblpLGuMvaRRsubbaVuYZbTOAOKyirTnTQrxZB",
		@"EblKJjQXNTfontEcsbPHjsnnKYzdhufQvstWaOwOXZxFJXgVHyRlcDUYNKHmumSWzgeUKgzvpDuaPADEBrlMaSEKMspmnNnAxyBiTUTTHKUbthwMMUwjlH",
		@"lVzCHdZAiolPjmMFHuspHodRJxGTbdLonIuYTKRvnrNzxaChPpBYArdlyECeqmIFZLzBmTrOlCpTiPkPJuRVBejJyaBEYipGCaUSMSalOdiIszOwoNgghTlBNpjXNFaRmyYweHojITaPlYJE",
		@"hHndGpVwZLGjnpwRtOVicjykpmzxmHECvxFQGwrlqyBeysdCphVwzOcSJCvusBFIpOpkxONvIhLcYnGeyJuBeGBbgEkWeSBKOxvvtMhOBe",
		@"TrtDBrJxTXtphwNnPnNjKBUHMlWQJBnIHRXyiUwIsQEWKSUviHKjCzUQDaJiXotnPMBMhdIjjVRTvTNwrHgfipXYFBsfDCOvaMHSaCuyadFSlCZLanGDnyCWLoCXSNGiqSvxvVvaOdh",
		@"FKhHpZTNzzJXkaWZqfqplHfQiSBcmQJpYdbtetaNiHiSYvUSybYqDBmwOlblxVZVvCDCtmObiRnOrAarPxGHnddqFEtRprwOJatVDYiEmNRUCsSWfY",
		@"qwXcWIfWWjrxYOInoGXJLjqGFiWNtmOtukjDQxskIubnLaUxfIjYXyQTYQhbUkRVRGblapErmDpdfguvTmPWcfVPnCucCQleLLXQjMQqiURwLRedCcHPkAW",
		@"rXqOQLXzwPLkMkgstxAUihCjfmciNOBcjGGQBxASasTDtFEJyybySYkBzkgNFDOivnRuhfbHSLDejjNGyEzIfmzMoRZxFNJQDWztGWuBYAYaFkwdolILlsDmfnF",
		@"hpFemninSmBGhcXrTELEANrHtRaCvuehJJSnRmAVbusvoPRmyEgFjHybJUUPLkBvYPsYiAzjujyKdTrSiepiJFLTVxbGHbBcUSJwJUukpwFUhVZVp",
		@"VaNRHPEDESrhHsQsRYoddIMgsNWjlPcslNrjfPeJOBHLieBlQtNWhDmJGrEZkoplhgdEfTZvUokaqoOudyyKjDTevGLkRbfQuZiGUKQKJoNgxt",
		@"MtpruQzzsWMOuaWqzpeGhhoekHyKpxAmmgPOkTLfftstCiQwVsrYeWKUciRGMocIglDkXizrBmTuLnjZGloTaKpnXuWupubZUSBrUoUdBOgCj",
		@"HxsPPaIDNmGxoYnxPQADTvwlobzIVJMYjsFDypuHQLObtVjgVfxlqtvpfnXSknQVfnrjBLRIznIZQYZUTDBmOYSQjwMBQovZXiglPVYxJsEsdUNcYBYDXeVkcoJeXZLxGSoLP",
		@"otDVMYNLnRnSJDsCHsSSAABJIuOFjJamdFIIVbHvsNSQrEGXTkuzFuQoTylxvfzwBshoqwztGNxNxYZuSffjcGIzZKMPKnhEQYypjwiEHHxFMBWANmOppmPEZuQyqahfimhEJLYs",
		@"yomKlhsWUejDluSTRhVvdZvjbGOliuDtBhPGnsHjxpSzDiJvuQCzXspYNmQHuklMZtoQhJMzTwijyzEnvzeXhNomdeAtyQtowUNfDYfvrDQhMjRTJndxQaKURJLEiw",
		@"oxIMDblidKHLmNjAGDkhJODODdqsQWfoXOhULecxRXBvLMhczCflOTOqkjvccrZuuDDzZJJUMvRWQEbhzzwRWJgdxAeMwRrZoOPypyngQRYMLimCdyVFaYZswiBIvdfnMVirxIJTlRhqSnX",
	];
	return hgFhxTAcqSMoXfRVZES;
}

+ (nonnull NSDictionary *)MwIcpKsgeYQCwRm :(nonnull NSArray *)qtdqJxhEcasCjzNOm :(nonnull UIImage *)TvjmSggeHPSSx {
	NSDictionary *jtygwpBKzYi = @{
		@"WLqZkzOcsm": @"rVTpvumSbbunhqqivbKVAySCxkdUmOBpGEszulssMcWwiyUHoopEoCcLEQszFlFJBUqLbnIpaeWOYcwZefsLBeOLQzkRebcbBlaaRNNLhXeYZJDuaJAnWnq",
		@"kZpCMrbBwhSzT": @"iiXQCWIkietqCKxskbEUVTcEkFjjWoiEkMuhAOgcRWDazBCHnWXobsTCMXPwnOpzKcWoltgXFtHwnMQBkiUJcdChFIHXamwIjtocYZkyrrdDdVJTrRasPJMYB",
		@"nIQvdVOrxf": @"BmRKxJIiapfzbHgpiDqsVaRnImgBptKFvKlPbReWrlolIGQjqmkGhqoQLBABbKdUCKWmmsjhAExSYEBWjEhFKmqJGsSoDNCLIFlRfRyDNsJLip",
		@"wZYXGwycKXlmV": @"kSrwqKAdPIUFWKAllMgCFlanlFzSFSevjRHMYShSmGOPKUShWGwNZOmmQhkicPKdysuiDKdPcyHdEWhhIGLULtssdWpAKXJVsDEPQmYrjWwNqSBAFUHHAyjIALtocPgGfHgQHt",
		@"wzchrAqLcDn": @"lDUyDUAXbnmdnWqnzrPKTphjShShXkmYITmMEKgMvmNPCDLFlYzLZZYMxHuCgRxdLLFiytekWykRIbeFfuMLAFLhBumlogRdsxobtpAzOQ",
		@"KJgBMORoceKUS": @"jcrihDIUovMZyFnsCRPnsrhCbygrYNIvUFpHZhDlihoWWjAHwwGzpFJZgckmxcRFmeisgeEszXBwScoGjKITznflnAzVPibwwEwr",
		@"JJNvxvTUCLQy": @"QzHQLoPadVXkOVjFhoKeqKJTtvGCWWGtkkIPaUKKMFcAfKxpSnPdaiEVpfNMHNxsBgeDtpCQkZqMNmSQYQISDlJRtSnIJlSCnjQRSPndjKUaa",
		@"iAEAhODASOl": @"zzZCEuMIrylQZcochhblJIxjHgMgPrfbnXttTziwupKSneyrQAGIDTSkGrRLomRHXTPUKyGzUrImyeRwOxingrfDeRWWhOXHRbNgqmPBWxRYAJgBKg",
		@"PJgAuaSCYQMD": @"CHSnZmApOQULSymQoYiVHXJMxmMdnZiePDfYWtnzdRAyphgHYWoHnbgrvqsnbuyRsMqUNjvhSlpLQXoftnxnihdMwcAmFnSFAsisvbPiUwZojfeSXouG",
		@"pMArLvOgNmRLnYL": @"ygvOzSJAMqfJbxipHKSRIiwqSrCBcyeRymdXixKCWghqPQMsKEdRTrOtBhuljbiScAYLFYGVXJnefWAdyVAvbohtCDXNHZZXNtQZXTZjOnxkCsrkzuCJkeSdgdnoRT",
		@"BZypGIUTEXxAu": @"OmKdLJqpmCFOlhlDwZKTuMwheZUKWEjfXgtRPwkRurQXOBAfiYUSPLeueqQrhheZNCIgNKSYrmPIMGfauQogDPIDQreeYoNoLXHgkimbOEYqcb",
		@"AoZHSwUuQJqAbBQf": @"RUudUsgoazQxQiwBpYvbMcdnaoqOjWMcVhZdpeqvaLYYfrnKLhintSVczGDtRAcohFHmRchzpaccclswgstDxDJtkHTmniSfkPWmkKgRUmecCDXMmTodT",
	};
	return jtygwpBKzYi;
}

- (nonnull NSData *)NdCKSaYacLo :(nonnull NSDictionary *)blFauhzaqcRrJ :(nonnull UIImage *)VhmePGaTcCWwGf :(nonnull NSData *)nzQtROJMbEUZjEO {
	NSData *GKbcafLIvzjhJ = [@"iqQUUqUlJPwjyYnzfggCpfFKoGMCyIQiVLAcjIBQKpttjBfEcNFQGFgMXlmsOtulnRKdLmBmyQDFRSdNHXJeqnGcQWZVnhvwYiaFlGkQfwZyhmyrdhOKvRQkGgtnKtbbnb" dataUsingEncoding:NSUTF8StringEncoding];
	return GKbcafLIvzjhJ;
}

- (nonnull NSData *)espLYJmRxQTlkKQNc :(nonnull NSString *)hRpnhfzfUSq :(nonnull NSData *)HOvlomraUxpB :(nonnull NSDictionary *)rSwAanVnUYzuzzFD {
	NSData *yJgHEPruBEQdqQ = [@"FqhkXaaDXEfpFNRUMTtDBBDlRlDRaaMLuZEvZzzIZrQilNCVtPnxWcYfvYZESoyKpajxRpSfEWXHqBusDKGaRlMTsoLgaiIAnljFayXZDKbNCoTjUlfSfOFpafTiSjFLBp" dataUsingEncoding:NSUTF8StringEncoding];
	return yJgHEPruBEQdqQ;
}

- (nonnull NSData *)kOKPuZbTuOfZMdBqlT :(nonnull UIImage *)uWMDBhctWvqLBRWrgDP :(nonnull NSData *)afmAVhOjbZcAAWi {
	NSData *BWEhqlEyRtBOfkpAOMc = [@"tTDzmWZbSMaCjLLobrJQsABmvvhBWsZciXhcLqjWnXmCbkKPyoIarXcxqqZLFhmiRGakxHKFjKEJwUGMHcwwYHqJBdXzuPIkiguaQxBOrfQQicWKjVPVYwwBdgucoxkCpsZCSgtdQziTYfkMtgn" dataUsingEncoding:NSUTF8StringEncoding];
	return BWEhqlEyRtBOfkpAOMc;
}

- (void) hBTabBarViewDidClick : (HBTabBarView *)hBTabBarView
{
    NSArray *menus = [MenusModelTool menus];
    
    for (MenusModel *model in menus) {
        if (model.ID == MenuID) {
            self.subMenus = model.subs;
        }
    }
    
    NSMutableArray *shareArray = [NSMutableArray array];
    for (int i = 0 ; i < self.subMenus.count; i ++) {
        MenusModel *model = self.subMenus[i];
        ShareButton *sinaButton = [[ShareButton alloc] init];
        sinaButton.tag = model.ID;
        [sinaButton setTitle:model.title forState:UIControlStateNormal];
        [sinaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        NSString * iconStr = [NSString stringWithFormat:@"0x%@",model.icon];
        unichar icon = strtoul([iconStr UTF8String],0, 16);
        NSString *name = [NSString stringWithCharacters:&icon length:1];
        
        [sinaButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(name, 35, MainTextColor)] forState:UIControlStateNormal];
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

#pragma mark 遮罩点击
- (void) shareViewClick
{
    if (self.shareMaskView != nil && self.shareMaskView.superview != nil) {
        [UIView animateWithDuration:0.3 animations:^{
            self.templateView.y = self.shareMaskView.height;
        } completion:^(BOOL finished) {
            [self.templateView removeFromSuperview];
            [self.shareMaskView removeFromSuperview];
        }];
    }
}

#pragma mark 分享按钮点击
- (void) buttonClick : (UIButton *) button
{
    [self shareViewClickWithNoAnimate];
    
    //课件制作
    if (button.tag == CourseCreate) {
        MainWebController *webVc = [[MainWebController alloc] init];
        webVc.isFromH5Course = YES;
        webVc.isPresent = YES;
        webVc.webTitle = @"创建课件";
        NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
        webVc.url = [NSString stringWithFormat:@"%@/%@",header,CreateH5Course];
        [self presentViewController:[[MainNavigationController alloc] initWithRootViewController:webVc] animated:YES completion:nil];
    }
    //发布广播
    else if(button.tag == SendBroadcast)
    {
    
        ReleaseStudyController *releaseVc = [[ReleaseStudyController alloc] init];
        releaseVc.releaseStudy = YES;
        releaseVc.delegate = self;
        [self presentViewController:[[MainNavigationController alloc] initWithRootViewController:releaseVc] animated:YES completion:nil];
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

#pragma mark 发布成功
- (void) sendSuccessRefush
{

    self.selectedIndex = 2;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendSuccessRefush" object:nil];

}


@end
