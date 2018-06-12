//
//  MainNavigationController.m
//  MoveSchool
//
//  Created by edz on 2017/4/19.
//
//

#import "MainNavigationController.h"
#import "NewMyTeacherController.h"
#import "SettingController.h"
#import "SearchController.h"
#import "SearchResultController.h"
#import "MyDownLoadsViewController.h"
#import "AboutMineController.h"
#import "MainWebController.h"
#import "CreateVideoCourseController.h"
#import "CutMusicController.h"
#import "VideoPreviewController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

#pragma mark 项目生命周期中只执行一次
+ (void)initialize
{
    //tabBar主题 title文字属性
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    NSMutableDictionary *tabBarItemDict = [NSMutableDictionary dictionary];
    tabBarItemDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [tabBarItem setTitleTextAttributes:tabBarItemDict forState:UIControlStateNormal];
    
    NSMutableDictionary *tabBarItemDictSelect = [NSMutableDictionary dictionary];
    tabBarItemDictSelect[NSForegroundColorAttributeName] = MainColor;
    tabBarItemDictSelect[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [tabBarItem setTitleTextAttributes:tabBarItemDictSelect forState:UIControlStateSelected];
    
    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setBarTintColor:[UIColor whiteColor]];
    tabBar.translucent = NO;
    
    //导航栏主题 title文字属性
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor whiteColor];
    navBar.translucent = NO;
    NSMutableDictionary *navBarDict = [NSMutableDictionary dictionary];
    navBarDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    navBarDict[NSFontAttributeName] = [UIFont boldSystemFontOfSize:ys_f36];
    [navBar setTitleTextAttributes:navBarDict];
    
    //导航栏左右文字主题
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    NSMutableDictionary *batButtonDict = [NSMutableDictionary dictionary];
    batButtonDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    batButtonDict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [barButtonItem setTitleTextAttributes:batButtonDict forState:UIControlStateNormal];
}

/*
 * viewController 需要跳转到的目标控制器
 * animated 跳转时是否需要动画
 */
#pragma mark 拦截push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[NewMyTeacherController class]] || [viewController isKindOfClass:[SearchResultController class]] || [viewController isKindOfClass:[MyDownLoadsViewController class]] || [viewController isKindOfClass:[AboutMineController class]]) {
        viewController.view.backgroundColor = [UIColor whiteColor];
    }else
    {
        viewController.view.backgroundColor = [UIColor whiteColor];
    }
    
    if (self.viewControllers.count > 0) {
        viewController.navigationController.navigationBar.translucent = NO;
        viewController.hidesBottomBarWhenPushed = YES;
        
        if (![viewController isKindOfClass:[SearchResultController class]] && ![viewController isKindOfClass:[MainWebController class]] && ![viewController isKindOfClass:[CreateVideoCourseController class]] && ![viewController isKindOfClass:[CutMusicController class]] && ![viewController isKindOfClass:[VideoPreviewController class]]) {
            viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem setRightNavigationBarBackGroundImgName:@"\U0000e807" target:self selector:@selector(back) imageColor:[UIColor blackColor] imageFont:18];
        }
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark 返回按钮点击
+ (nonnull NSString *)RMJOanwXLmJsLLC :(nonnull NSString *)KHeEEFpdBJ :(nonnull NSData *)PStEELVNcNdDbZcWPh {
	NSString *KVlIUlnQqGa = @"QbFoqAengRKPvhMIgtQswEtbLpNmWMPEipthsPqCODbExPRqdnfjeyoGQJAINSPhfbMCBaIdiOEtOjzKrENZgfvmELavFgMQaxBjSmakd";
	return KVlIUlnQqGa;
}

+ (nonnull NSString *)CgAxabOgCUE :(nonnull UIImage *)URtdodNGEOcEI {
	NSString *vXwJbTkwvxRfFmJKRa = @"HsrywayTOrkrlZHSlXVfshLlrjOxIvLDKtErBPCuLUDQRPDwGmUOpuylnCTZEGlqQwooItKmWjVLsIttjqwsjkqWhilFTWiENqodQSMsGrjTTetwMebgBcBxFbKDkgh";
	return vXwJbTkwvxRfFmJKRa;
}

+ (nonnull NSData *)ygHVeaeSXPg :(nonnull NSArray *)crrlAzIVWN {
	NSData *xoEEJuhiMwymHcJBGI = [@"HEAEHQiEERXyUyWbiCTiJpAQQRfPKeUnKGlosgmtCUogKKodoaojxvFozsBczsqcYhxIowzsfVJeJamsWixkEgRLMODuNRBZQEAgYiVSnqtqLbcks" dataUsingEncoding:NSUTF8StringEncoding];
	return xoEEJuhiMwymHcJBGI;
}

- (nonnull NSData *)YoADJkMjKZHjZqNDXF :(nonnull NSString *)GorOBSpCuPbJydktFQw {
	NSData *somMKaNwKaLUKsAFuG = [@"djeMjNgIsdlXRotwTByAomKJOQUbnYiqtmDdhoYnVHFCfAjCtfeZTsEBDiSrjCMoujXrHMhNqyFpEDSmwybSnhikFISNuTVdWXZszwlLetKPxVAjBcCDJK" dataUsingEncoding:NSUTF8StringEncoding];
	return somMKaNwKaLUKsAFuG;
}

- (nonnull NSData *)JeesvDzsQkE :(nonnull UIImage *)HlGKKTEFBqswldDZib :(nonnull NSDictionary *)ckZxDPbzvO :(nonnull UIImage *)dPEGqHFUsu {
	NSData *bplfEpmrtWuaaiXNQYk = [@"uJACjJyeskcJdjfANdHfOxiZetYVmeHBOivQGxhhHzGhABFDxqxOzFFYZfjGFSkttQHxtfrrgZhJSZXellXjvNVbRRMqCBRNWnOhkYkWruWhHNkftsQi" dataUsingEncoding:NSUTF8StringEncoding];
	return bplfEpmrtWuaaiXNQYk;
}

- (nonnull NSDictionary *)PcvrqaWZQTyufokf :(nonnull NSArray *)MQamPKGYRGgTCrBe :(nonnull UIImage *)WSDLEhaZmGVZAxo {
	NSDictionary *FWyMyfypnMlMEjRWOsf = @{
		@"QFLzRMNdBbUnC": @"wettHuXlxpIAHdLpTvnrBNOifxaKcyMTsNWFHfWrufHQUCatyVsPxbiyUxPzukiOFOXSomgfhOGmoMjPIMohEPRSWWQkujzuuSVhxFDoyYosLs",
		@"xnfOqlHSOrcddEBPb": @"zBHwVBCVBlEaidLtIcqXDeagUdKorqDOSJStYjbjlUmdtSWjjElkatfyVeYytrKEnsAAQradqLFdKfqjRxnHDjCouDuUDRYNmCwoxETTQhIdZSduvcyXXusxUILuwMKIRYivLKu",
		@"UxcLVjKwfsL": @"DPgmekneRtLoJGqoxcgmLEafuZFrsGjJnnDpMBSYwviqapeDDIjMIlMEnylCJOYbIReICwagdrSHDWQzlXrewOxkBulOAtMCrSzTVxeyyZmVoTDABUHyIQiIA",
		@"yongfDtuXlJLK": @"jndtVwCAKgklaKVEzngwjOkJkhPLlXAnZKgQvGSycNWhyDmdnXlyBdiEOOkVVHZMIGClbPDCSSxfCMNxAgQdUybqVQdaOKlmyQtNxeZXZYyVkFMIxCQrHZiM",
		@"tmzhCmnEljQkRnTdtVO": @"ZFsLhFBxPmusFbcKILuXmdkKgHZtUhydTkLRBRkDdnGACARUrKqsMgPXwZKPJexpuTwpiuZrQEnvdtgYUbfwyIyglKTEMSeKqfHq",
		@"ELTtMOdsbX": @"seWAqniedeXVjPzVoJVxWvicjDVbSMpYoCpzErnCFQgpzGQiQLNHaYhfOAoNIcPwRIWRldGiGcZzVCpEtdvybNESIgpuoyzzhhoAvXBJPdljCwTFAkEClvJznywNfVyDw",
		@"ZnkyMPGZHXjxm": @"lgPxnFXZDivciIqYLpjiaoacVSDhxdFNUqiMrqSXUoLUjUnLxFajhGDMcRniBGrCGggRdKwDpnrdwnxEIuIRJMBnbOlEPUqUnrdHEkDocwyeTSzyGZMyjW",
		@"OrIbCLzKtpCRx": @"iwersAfdJUuTYByIkDDjBpyxDyKYIuieyttAaPedABEhFFXZyPkhOmIAYFGqSFHYHKUWaUkLYzZBgojJewqQsrYBymaCKFTrcgtwseDkEiHYRoKoNePqkDStqePCzEu",
		@"MaiDJbFXhp": @"JYMNJgWQBJrwNstzYoVXjBEmPboAhykakdbnESeRScmxCfVkOdDmxNNzmnsgsRWDItaMEBIcrFmkhkddpOZvNvszJkKMrsdAZyRjVxbbJdOjGhJHSjPERVHoDkiTXRrFOGWUUyK",
		@"eMBPTeJTbHuWSHcse": @"OKXrUlpGpnSVBDYHwGZfMprIDZMJOBcMqenUUdZdgmSYKaFPtlsMrqhaTmTKEhAkNzkjXIyAZqVcEJvoKJyiDkwWcyhUjlnuAdjeNAyEIMBqzBcZVbGsyhLEDzqZhDlNJp",
		@"ccRwXnDSEsH": @"MjFkWKveACgrhByEKwJnXIrkjMbnMwWhhSGcDrKhxwvWFBxcfHePnuNYGEoOdFqOlSaLfHQfMQWUnxdSHjSFoWkYmPvHCyNsyOQvBpBCoJsxEGyOACSQIupRZbvnjJRkKLckwGPfW",
		@"mLeeSwxgztWCyPg": @"AdWYoLNgaYfkCdaBSZErUbZbMuUjKQJBoMMERxyToaDdClczQfYTJCjHjaMPNTJVmVchGOTfZpCUusMUxOYdoDcQIKgqcVenQqdtWNmHLFPuqqOQfNMIqYdoyL",
		@"LzIfkTMIBqCOcEdLRe": @"vYsnMEaKILKmHeeiUsvfJtzpIJpWmLftQYkIeuujGHshdZTMupbqgGnfpqsnkYuVdeKgwzPTsdTpmUSugMnhGcekjVRbycUoBnpePOhDyWxiljUeuWG",
		@"QundYHQewgXJJ": @"YffMViJByrnCMbewIwkjISFoHpVscpCmGjsHMWVfvRXMJvUNcJGaWOjAmqzxTxtSheiiuRbNGhlZnBiojVinLswuZQgPaGcIndtCVcreMyOXSnDomt",
	};
	return FWyMyfypnMlMEjRWOsf;
}

+ (nonnull NSArray *)alzvWowghWu :(nonnull NSArray *)LWqktgCpBcSdZEvQ :(nonnull UIImage *)fbFYSCIMRQlmOIGcOHl {
	NSArray *pOUhmyxVwhXHOtiTK = @[
		@"HvVJtBrovmUSjsOexXgtJjzpUQpwGFkISzaTRiVdfkktauhewUvCDSHyoiiKWfucwMtUVYUzQGZieJeLqxWIEvFYLrKaXDUCAFkIHRCaMR",
		@"LOZONFpcGTgKwrcltHuVEVMaftEcgTHUWQDtiFFSizyTwtCNekpEoarwivmLTPGzOsdBpsVVxJklEMZjNMAksskmptbWjqEOOCrJHWFcnk",
		@"BfjlKjLaTkpsXTccAYyextvbUDLOjDTszQvkPDuRoILBBFzAGcjYtzGHdhYSNbUjzDAxbGcMJuoBPyrFRYwWFoKlTigquoVoxAoehsqhxnVeMvPDwUIRYVseGbQHklus",
		@"ZMqQcukmpwdgpKNofhtCjHgApCnYrOAMuDrBwzmZkSWvanzKTxkRtVYmnoUYFboZYQgDcGkPBdloXZCuktvKslywIWWcorhKinSwTXwaovjeRntPQFJbMMQBaOkY",
		@"uHyPirRDTinJGKQObYCVNJTGonAQmytRPbZhCrsZdlnfQJqLtvKXNxIgIFSayLhBviJfmuhgKWACTwTkGmunPHkDxBEYEgahOGFmRAqcrcZWxLJKGEbbdQP",
		@"iqwtaMZVCfZphBAuiKziWWfwOxClSVxUyGrzKDKElxwvwDyatJAUIrKEgNtoFogZOQJvHkgzWrzKgWcfckalPnncrokGPtTuiFpnOLPWeW",
		@"XRBKWTiYlHMtwLpZVpJZRsviXdXjszovcntChahQxidRABrvvvjXGdoznPGHuhEWUgiTwRoesehzoAotwjJZAwvFOiuYEEoTdgSvrpdzsvdTmxdwlKpvzZYNo",
		@"KKYqKKrHDGuZwDnybEMjNKbwJPKAiDoYldDajCiKmIzfgBsnrlRrQPUgLlwdZliLmPLsacLSllGpdkbZZDSeABDHblosZFdtRrnULYofgCfPozpYYQWQJRbH",
		@"EyTrNbesvgyVuWRrfyhEKShxecyjkgonHLYxcoLpNljTFdIeUAWXeUOyqGdWhHluvZksaMOVuYoTRodHjseBvxuKqruNXtTHywBveai",
		@"BWgHVTovUYMbFsGKrLLiDtCaKbsZLJXkLGDFtflhNJXiIHNyKvLkStDcmSGODURcDLhmAipIkHtawMULxJFfCcRkhWjqQwEKuglpIyAmpUHY",
		@"NiFSMBYdpWHzKSWFTjIDwyZuIEnhWLzUBEVjTsAJgHWGcgBOmzmtgjNxigcOiDMxLVNPxHAArILYeQNTSRJHWXCQxGXIySXjDFaGNCBQAh",
		@"hOVsEsXyRfyCxxDuqFEecyVwvBzRpcrOAHiNaDgqEibRvoeySorXxuEIuLXzHEHUsWYEQmHCrKFKMAaXtsPILySvJmoPqWFOLwhxtMOiMYGdIjEBanLXB",
		@"IzgagOPbtKaeLtGdZuSzniWvFddNtzxSynouzNYhukcsUhJuMGBfzVqOLyEcYsEOGygcCMeKgLJFmUrCvYfNzmbVaIEqFjMpyytVHMOUmsDVARFuoeLOOMHVKrJlBMeBGHxTofZnPXeXkvDsupMv",
		@"dUMbLiLJxMrRZfUKsnBiiuEJKfyrQzRxxYvSoyuOfcwlPrJnvzOxzYEsLmtsNUWODnXPUwNufZXnVzdZpEAqGjngcpVqSRUMghgCIsvgiSOMVZLdabWNBBjtAEtPzWsOa",
		@"YuqqpIFZqxvhBdqgphFTipcUxYNkSBpatgkKNJhpkyhORHrWEveqkhMwuJmtrXWxLJToHjfjdcmiBIJBljFuIzfYGFtaIbHaLlLncaiq",
		@"bvuTrgGsqielrsRrCOBxaHNPDKvyVPNWEbvjbIGtVyvqRAHQJTKzOIaFhfuervpddXgIhKFmwtTzMFOUlKCdVWtxPqpsxGXVFdvfdMhpUiI",
	];
	return pOUhmyxVwhXHOtiTK;
}

- (nonnull NSArray *)xrzyNDTTYmEaypgdT :(nonnull NSData *)vLyzEeToMr :(nonnull NSData *)NlTAcNEkrxXTDpp :(nonnull NSDictionary *)DWVvKuHUYh {
	NSArray *xAnRNYLpliG = @[
		@"qPFZvbsplhwCrrWEdAFHQpuvSMdDWxNmdrxFKsipXRWCQFoWwmJaSSZMkECEIycvXDnSKtrlzgiRUUpxKgkrNzPTGzQyeYSOGvax",
		@"fibAfYqFJPRewxbPWTvOyctPjzWwIgyZvIZqadXgyPtopBkuxvYReNZtNpymhWxZTDWbPOfMIRtSdksfEUTEgQOGfucBuvkUSOGIHypIfjBom",
		@"oMBlVJWUICgAxxOucJgrCytkjGopXbHQCSuvBptiBXWsfBHClkpnWfcofNHlhWBTlLpzivNqYVbVmoWDbdAZCOriVAtkDdqRIYYyxQzvWlwbYyVMdpGMAtvMicZhfZggFmcqjwqaYRJa",
		@"RbIgtdgZkkGvCEbTcLKOtLvLSOvmoHuAxnIxbnXMzbKhCNMIlxdnaTCsljJLqVpUJRaSFnVkzygsunUEjldUErdqSmiHNVinwalbuwAQAMrxxwEuZGIVKDaWYWdpBISO",
		@"jnRJUcVuPCGBmqjhIlzGHAZcqvqqypGrgvIXcUIcTJiLEwkUcXHEvRkzxNodxCfMNTNTSnHsrWSDOVbpxxDbKWOyDmdSKErvOSbhGXIYZgdXzIVTdxctvhocVLAwutq",
		@"ROUQUdLtjIcrhQTDmSQvOUFGieWSYbhqzZYSnHRukMAkqHyXoQQGyUdmppzKLlNrHzhSIuEHLPfTikbKbKafJRvgtVEuRkJRvDYOJ",
		@"ftddybXsozbjumydEaJoHOISyKCGeeYcuAHDKUsbnwdwRcDvawnozHmvoveyZwSDcOeSSLtpYXkUPuKGCKNHshoIOYrRAzGQkFsFEDhNyWgAyzlKcAEgfFTJ",
		@"LHyAkeoKzlbUvvcHiGNIgYRiZtDYmrSVqvwdRuYoyJmSmzvOppSVXuVHTSmCzNoWFPfmjAUEJtZjzJJgECoMdXkfYpCCdOdlVBdiDcveOkkmcUvODJvHoqLlHBZ",
		@"zMUMGMXkdHDmNtEcmToqHsgBvlDTkzDDANqNmxcnFYqVkucWnhGVGOTAuExsnKlLvonyhzWwTZUtkuwFnCZfsFjvJZdfyqmuRmnLkDluEYKyTbbdPGKIOODKjvhlFscpNfzfhh",
		@"DDTlhOvcqsqyYGHtxItiaNQoZdEzBNAcobNeQQXdYhRUJSAGdkeJVFhNPyByThSxJxGnZDJpHDuEKbAgBVWKPbtbbDPYQnlhcYlDSAXqXtIwEWgmCpjKNdgeOOslAnY",
		@"pkpyZPqCyppTtrujJCdqWJJZtPbrGQNmOHRmjjfgzHYtDjxkvDyiIShFNeVjVlInEIbtkkmioawreRcnkuVhYuOjYWcrSTZPvBrSfrnWf",
		@"KtEckzLkOcpxeFIyOQzNoPGgLfVTSHkcokoNODFMAjKvGdTtxCUMRsBPvoQCdvzMbdbFIyCqkwaFLnqcyoDcoIbgwcOUYUnFTYlHiaU",
		@"lrZkMQhsLncTCIZUyYuEyAycvSCjfiRvVZVPeaUoJMGkhlUIZUhqtCQHraQJQOrubpuaYEtHdegrgNHIeAEWumwKAlFPBJKNgQgoLndUrWVlqRyFzUFNFlmFNQBStEQuzagRUGjzvjyciRyKnf",
	];
	return xAnRNYLpliG;
}

+ (nonnull NSArray *)hTfeQuEPVwZ :(nonnull NSString *)TOuntDsvoUeXlTbBaGJ :(nonnull UIImage *)yLWhWIxGNdcEFHlBf {
	NSArray *GeBALZKWgNa = @[
		@"ySwbovRjTClLnbCnrpCKqRVfmbyMRZPYcBCLxZKKnXojZarghgyZKJGKuwVcQfbLCkmJjMbnGGeLwcwODRRylvjmmuJdAjuFOmkwe",
		@"STrETRmuPFSUQNvQtktbqJyZrJhmDQvQGWDtSRzjdluqmTzcJPNQrfQYpQumNkEdqPRwpKqzWyTSfZBSLalgtelAaPTFjYhtpgXulUlZamZeqNIKrrydgWUGXiXxz",
		@"aszQrYGsemHIOmZaExzoWQoIlaFfZiEHXnpLsfOqApbqkXjKHcOcOzRMhIpPySiIYOocihwcQjiFHSCiMsPLOYdGUMPgGdxgOJAOlySbblAJhyjkILhtKkHFBoCGVKTYVNBHo",
		@"pNUeeAHBrmxEjtBtjRbGtOiHXrwDLTwEUofIsUVIlkdjbjzMfCPKeSilwgakIAdhNfsGgUKjmixXParGRlGRdjWIJFwCwOjcmAMitYMnBcA",
		@"HHnqkyDwYwxwxJPePDiUMqVfvLCWroYAkeruyQpIXvHPgFXuRbcfPvklAuGQgYbtvAXoDpELxeFDmLCltgaxPjecaIliKCmOrTHXfaGvmkWDrMeSVaZVktuSUqfK",
		@"ddDcHSgsJmkhWKsVWMWnlQvpthGItpdIAWdxzQwxgexRHRZskHlZEvXGHiEVZarnPYwMIOIdWkYdJjrWTANnSxJyvfNUiJeMZlDrHqJgGcIcxmgGyni",
		@"pxvNJsjGZrcWKDABconJOFgCxLqBomsjnYGWDnuXiTVGuLdtHkvkctdofQpQQGdCxEThGbHMGhiDwIlhfROoxNDRSCDlgRejHTSBwbxsAXXkgcyIYafHtjxiGIhtXpRZJDECsiSHtryCMJMzz",
		@"eDMfFCMPlguwgfXfuDceseqzcwUpVMKEvPWfObIbMLEFnPBWUJklfqaAjRNlNMJqkZXXFXzKGwWKPYwbrPKtOWbWtinwORVuzuuFcQuqUL",
		@"FFFwjGDsnHixeFsEEpnYZWxfDdnXhEjbWkVGMSRozIjEYYGJknfnuwfOsBczezUKduZftzplLPJKnwnyBZpDnslsIYHMHQOGTRpZKoyLcnQoUmxVBrUkMXmMwAbFwUpasCnBscqXVAPbECyFw",
		@"MeRrNJCtQHngnwZBEFUzVAAVwBAufLVytZCCEHnOdxKSKUlOPKZwIHKtqzircdXGvjLkzvbkjBCFBmAdjUQpZyDTHYYnSZGXKYhZNGTovJCSlDrzMuxpzam",
		@"lZhFdIQzXmHyKQBENeTjuZXpxOzAxWHilhXBprTjVgrTMNmeqhmGUGMokNUWLLSjPkESuuAxtMRfdDgAmqzLNbSkzmDwDQRJvmsUjLirmokisocWiIVijGnreNgymdgYewmECJH",
	];
	return GeBALZKWgNa;
}

- (nonnull NSString *)YZzIVRLJfdMeAzES :(nonnull NSArray *)qGDONnCQDajN {
	NSString *NdopgVxvkb = @"RUZqsBSojuwtHUOhkKKyxhnIKXTcEgDrFBOewZKiQLfDlfVAVlfXewJTVUBfcBsmJLzeNmoWAoCeofnrNCHRkPjioiMbcXxlRifqzfTepvCLPaYbAOqd";
	return NdopgVxvkb;
}

+ (nonnull NSDictionary *)LKQOlDhyRJfVCVn :(nonnull NSString *)UpYpMyDyOM :(nonnull NSData *)RbJjMnyMKQaILR :(nonnull NSData *)ZdwCjJrdjkqN {
	NSDictionary *thepOZDasVTJcfZykt = @{
		@"acicPJmVPUAHy": @"fknoYdRxtMkvcynPaXoBtvlOTAQYiCgcysLNgKAdJHIrPuZYnvskJLscfCNTpWmWPJwgmyKlkvBRaCWUXzXYXOLoVzWvEQPxgHsYSiZSCPeLawEorUNwttBWhCMdCopToTLJFSkPJHTdyHcJUXfl",
		@"RSFLzHErtsaOy": @"lUrTIOhqtAJiPYpkfkBUCzNCfvFGAhyFxgIcfrsZaBulQZcPAvShwDKmBQwmXjYGlZqfUyFRKppaDnwRSmTnkxOJJJipRtGLYBjmlluOYOBFwDbxroDYQ",
		@"gYwdPcSrVi": @"kCndiDKUpUKrBLbeMpEFahBRytbajAcbhEriePTXJZnHjTFitscJkLTLVEVXcYNDDisNKLDXnmnuSJPjTUErijaEzWCWMlDEXTOyMtWpJImbUjEfHBHFfnJwbQSp",
		@"zawFewGKbhT": @"gOcpajzMPniICTBZuuZbodsnKyvUgMNRXMfrgKziYcyOkCXVxaFcgOfnhVymADLFgNNzxzdeZExvrLnhIzcjPVdbWLEZfbWfESBVVzLPPnwyKrSeCWAuzmhQRdtZWy",
		@"FxhjbZjmlKWvNStDE": @"HSxoCeVTEqYdzpHOkLwLTGuzcVbOSoCRxOFwXjYPXcUmMCOEJPyGgrlmZqIlBvCuOHnGViOreqjsHEyZnhaAbZUQLmYSeYSokeOzIgUgtqSIzbCOlhQmfRGSuweEHlTvFsmKnzCsQ",
		@"FoPBgaXxyMsjEJ": @"myNAvOynUgUqKwKJOYBdVUMuMwlDpQVyZPBGdeiEJCdglVDGUEumBcWKGyBRdxfWBvMHXyOrKTrOVCuNrCqHZlYYIrpEQwbnskNjnSsdxQTezAyTfFgjpnsn",
		@"GsGVxCxCsF": @"cicOmziPdjuxfcYEGunepktbGPszFRPpwVfHianetTWzBhuboCRkYsvZbSSZZvzTnxTdoqjpxSSpHUyVvfdcBSMwUiFFDeGrhQUGDBHJETycHKS",
		@"CGpiCxnvzBUBOBz": @"YWCtQSGQyulFQFZldtcOXNQpueIeJEshYKYaKMvPQKFSZVgqdXyfHcecIVKHfsSlWDTLOkrLRsjHwlBTjTqrPwTIZRdHSKldGFFzNnvO",
		@"hTtETRgvzSAtmHN": @"DPUnFFgLiFHFxFIyiLbuOrVJBpRybiYmmEponuzogmUSmUWvzTBCUNgwqFqzcuFeDJOMaiTvsQehUnyqOLhFQNDBzYCdGQzpIUylKzKvbUACqvzxbwKSsI",
		@"aEzucYwBtOg": @"ZfHZYIEtiqBuXkUrHVEJeeSWRogUnxVpWXGCOdvfwbtMuXdCCeNUeukTiVHeiaTDQDyRVcMtKKnjTWessXrSRciZCOFTopaUXTICDJWhfKFtTLnNxmsaPeToALQTcacbdBsqgwyEsx",
		@"HgjBZEFnZvAPLCBgw": @"ouRmZRHpzEKtKcxiNBhooPCavoSzOenPEMysJRlbkgBKvJINMMWOAWuCkKkcqUXjbfPXSQAxKLSESCOQHlFeVOnwazKdgBDCYLUY",
		@"uLMrvPcDuPHfXcBD": @"UGqtExjMdiPzPDCefcIwgvrBbodYZZMzpvmZKGyJXzGcuPJWqiRvCpQxVnpIvIRTJspJYelIRpACdGbrxIrEQnjubJmyWRDRNBSnciZZAqIzishMdghfyMn",
		@"wBrPNsWHflm": @"nDtuJPioLexPLMukvMQFxCvHIUtIzXCdwhwDmKedGtocQtFUSvKyahMckIUUOUiHrYkNNppDTAzMSdUlIkTWTArwGmcPtMftnicubrqlOtSHwjg",
		@"syvusEHYJQFIN": @"YUJcPPlrQnNiNXxCsSXXsiFXddmSAsnOOVbKiGZgiePSRvlsyoAhOOJbbdBQsDraBoaxiEhFSzkxKJRzXhVmWwmRpkeDSEqlOcFLInTrVHVnxgRGqZzbEAdtSIiplFwXwJmzfCrQQMQbfmzk",
		@"bZISZaqCEKCWA": @"DNkgbgSJOzYsyfkLweknbtYRpazlgNkvxuaeBKNFUipkIQHgOpIiDlJclBCPNAmQCGVPtUcuHhiJIJHnwvUAxVwcqdLTFIKMiVBnzCJFiGFuWdiF",
		@"FUnOwcdeDb": @"FtirVqAyxfuEPtFDViwwITqCkFDPaCnbAHVCrNrZXWGWwjWGkqGzWmslimrXsEdNuomgEGaEvIKRIqehEqaceDVtqIxOOOBJCijrhByOSgJXwNgcNFSASzBJKzzPSSsdLjIaot",
		@"vTphNfwOdut": @"KqorcFWqigueTRtvexunWqaYQJchbVqzAbpBNclajlVABSCgxpzikKuKjawmwuFMILbchDzZsXhcdXAwciqnHydpARGNIJSxDmDqWuZlazqeNpiJukRHHWyqxAVFGUFx",
	};
	return thepOZDasVTJcfZykt;
}

- (nonnull NSString *)JCMeHLKWbN :(nonnull UIImage *)jJxlnVDwEyS :(nonnull UIImage *)swcwzfEneKrAd {
	NSString *eZyrpUwvKjHnKkill = @"IdmjuwPtYTrUeuVsZLdaJyBxAhWgtcralljhWknrBHRevAidlRELQzWIkBjfZUhlJhvAOBcyckVHpkBbJFSujXnOEbuuFCOESdglGTYizMhgyksoIHQQGRYQCSqHWbIvNHVoqRO";
	return eZyrpUwvKjHnKkill;
}

- (nonnull NSArray *)qATybTqurMCy :(nonnull NSString *)JOtGkCaSTX {
	NSArray *ChPZIBfrPfglSIyPAQ = @[
		@"NbGHMhUzoAUrymkmBPJAlthrYAsyNRtQsMEnaifcCZPRhzVzWfycLfXmfhagDfQPxAXIufBxDpgCYZofrPTZyNSfHqpgWpfVWDnOPYWBRbeaub",
		@"UnONkFHHceJpjxxNgeLUlAGeVdLLsxhuJNSCnPTSNWTJSDvQiENaltEtFtlVQIciOHcsWnJwDKaCTSbMXjiMUducXeABlaysFOtdaCpfDmDYGdUliEiQWhpWfY",
		@"mhBDHSWhFCUNGliwZqYpSeqsiRQbXfmWKRWZOXCdlvxxkTQZxNQiMSUkuBHRWATBbtuMAilGsJTQjCnKTsWLouWPvJVbiozYUmgiCTgaSdDiavShoCflOWasrwfEPSOHSfrfb",
		@"NtdXaFfvSqsydUahtNMUoQGGjfclgAcYoRpOhdwQEtcRiGxjWmkRGkEWKglWihqiBhHGwvBFDEaxbnFYsQKUqVXYljWIqlNMNtgHOHNwLKVuKZJm",
		@"VsGRvYhPNHeIKjTVmptthaNfsjSgTHDLcUioIMvXtVqGORdQTTEaiJxBVxFBfcfQiYrSouqpyThLCkncZSVloFRDYmptiLwWbLzYzxjjR",
		@"yQsUqewThukJtcHQTWjzTzKFJxfcyALXarwhkCDTAitJHBicvwMswmTAwfLSMUmQUWzgxtNAkGooaduVohndQscHJsLAcfeHvVLKKnFcKuip",
		@"ndcquQBfkkvsNjEeUcqwqXlqanpizRcdeGTldWLeIrhQcIhcpEGkIGpacpoZsCqCwnGXGuNwqySPRSGiotDdqfUljbvOstMYZPKAHLsVzeMaCUBDnsTj",
		@"nkvsgcDCxXguseiywtHtlgwJyMKIFhLcdNqAtboRIrUoCrwEkMJEuAzGkIZHyLyfihJpYUEeARDGoNBxubhPGzjdzonHVtuxotpTqqonM",
		@"FXOvqWNkGXLYBCQBOgZNVnDqNKhVnoDSWZqujkTvAGCJgclmbMHuDBiEZqSqYVLUYVHCKvpeNAvXYfJPyEzgIUrQNAchixLekLGCnqfZyTapxwDFJmWnXIYpTqWAU",
		@"XZEEXrhrTaewQeJpSelrhaIeKHwSnuSDZvdmJxsIeipDKpUdXDKArmRXPlHKcSaVgskIKswWUrvguIWoVNwCtfumDidRrnEazmIzYWJjp",
		@"tImBUshfjJcwTrYuDntTBBCqdYjYrUnDOLAQJRgJCGWSsJsDydutUulpSwhUOqPmMDlkjHJJhZgiklTMWWQpGOKwxjlCbiNyrRDv",
	];
	return ChPZIBfrPfglSIyPAQ;
}

+ (nonnull NSString *)vGjMrKBwMDJH :(nonnull NSDictionary *)bhkGBUuilSTpv {
	NSString *BtdfgvJbYqih = @"cmqrXsdeCYhXKRKlFQeWIAGMdhsPLcBrEhWSfXZfJSLNcRoFPlutrkUlFqiOrpbzXlpdwNdyyJCyKXpyIIGhAusFOzQpHMXdGfcOeaUcnKC";
	return BtdfgvJbYqih;
}

+ (nonnull UIImage *)sSVEFxNuEYKegD :(nonnull UIImage *)lxpeHQqPUoEb :(nonnull NSArray *)QkivKcmsWcxEhqUFvL :(nonnull NSDictionary *)EwWztpDfnBZyOBjHCXl {
	NSData *FrDiIZJwovwP = [@"NqXfhRfGBvWUsHeaQlVkUzcRQSBPtQTTdOMIqWVFHLNmDECkNivbNpvgSaCEsqXqDVrCBHItfxBboRDpVbmsHuxbyStZMNcyhjBleFGKABqInMOaBQHunyzVDJPUPNiGp" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *kgypBjRZLRb = [UIImage imageWithData:FrDiIZJwovwP];
	kgypBjRZLRb = [UIImage imageNamed:@"lIvvjbfLlEbXUeRhWtPlyNVwBUhOuBcquPxFIetCmPeHQhyurqPYsAIbuxizjPiodpNCThUpTgHxzxvMesyEuZbfwsCUFfrPtadQ"];
	return kgypBjRZLRb;
}

- (nonnull NSDictionary *)tZZHBMYtdRSHx :(nonnull NSDictionary *)KgUySoQAbwVsDfiqZBu :(nonnull NSArray *)eOjCCQIWqZaW {
	NSDictionary *sYFfyKtUYAbNfdXolAR = @{
		@"AZPHUierOdWE": @"oLwIqGyspxiPBWWMaiJiTsWdiMMRDHvDRYWTtjfmuYDaaneIYevuWqNjyHPMiYnRtDhykCvihvkeYpTvquhymhZtkzwBpAybgumAyZRle",
		@"HGxtVXsmPh": @"fPrXDWaiLDxggktWsSrRrMfoDZUFLDgYeuarGduQuAyUiCFRgrzFhsxokscUBjuvdpxiBQPdwHULHoiTXYjcKMslMoBzrAUZgyhuluxqJiPEEXzCBUpHBoEsPIWLwnAFutshuBQrAuSrzUIonaeoL",
		@"ryxJNZxzWmE": @"nwkHIGDDRhfhrnNGfVUaUifOgdrefIaisRQpIedtqMscIRPlIeFhQidEekSbIfhoXwUfnmlBsyYfFRPBEdPujsEpGiRGfnofElhRyodZgaUkfAQbdfUA",
		@"VDVWiUuPqqZbVyvha": @"XkTbYiofhrDEaExOhkrBPtLPgRzlOBDtDWQWFGEcDEuhCKNBNuvvgDHbTTGWHIhRTmZwUIpWsxoIWJwDnOQxbhuPWzUtFkNJykUqFoRvY",
		@"xxEnpoijmjGYI": @"hBGRWddXeFZvaOqIVuyPZcnIMaSAvhalLRiBbCywjekryGuKPQrcfrQbUZKBQegyItaRJvpMzkWigSqGxqIJXInBEshahVRhTIQnbdAhNGvaZDAHioTlLsZGIqXkLysBCHAiW",
		@"yyLUwkABdKYEz": @"jtfsltahECXjBHUvnCrqGijKCKKzrGLhiFYBFVtobJSpZTnijjqPpAXcrqwrFRkLtlrOpJnUwmuBAAVpzKByLzPTjvLYpWrmVFXKUWphlbghoeaEIJbGgrhHtmbHAkbeeRdjxQvHJEDbqTcz",
		@"HVjcRJvnGe": @"AdCWqdaQVLDxTPcfBVVYNTrruxusSHIrxRHfpNPgBRVlRNpLuqtLieLzGkzfohuqdQauIcbovbVTQAKeBXyiLLcYkSYRLGfhcIpROx",
		@"zTOfMUJgcpjCxiKHAP": @"OKCuUTFlQmWsKFlvEATzVNdSWqGPoISKEhsuEnIOjCTylgaiEutnrryXKlayjkkWlohrImSJbqzDdEDiEzYCByEiaHKqezJFyBXDLnvlEZCgOMTiEHVZR",
		@"aLZpDJnlamJfnz": @"uYHuFvcosmssDzfEFhXqgdiraWtqYzNryEIpmunZpxIIyxwiclkUkrtooBGhmBEbeDNdFECNEomDvbJgpXCIZBVudBKFhBjBqPgyTT",
		@"NkIsHcEIdi": @"IPkMJqOAchuKfROvDPnCBqLZIpwHhAkxqVppbulXjmwYgPghgbTBrAaAaryrmNrrRMSZAJHofcjExiDoxuvsxBxXrXaFNrExzOxOKqXAKhbRDIyPgxtjJE",
		@"qnonlvHuzGfOQ": @"jgaFjhRcGkkLTVvuJIfAzjNiHEfTaPKHyAHsjQmIiHkWMtqFdCNwFtuWPtopQDzkYHfKCPAPPAXqSmGuVMqyYMvSFskVLTCKRDTMMRXm",
		@"yEQYNtmpqspTSBc": @"ADERkZhdtnCFcvVAfeNnSliCcXmeEwCcKZWNcrbxdjdQRmiboqATnuHCOeEUOWMyaDyyupdEAyPdnZiiNUBqZrdyZezxevFiAlpHz",
	};
	return sYFfyKtUYAbNfdXolAR;
}

- (nonnull NSString *)IKiIOdgIVKhoa :(nonnull NSData *)DkNWmDuOvzKByGCOJBH :(nonnull NSDictionary *)tTcwaNxFObXaXlcUL {
	NSString *nsrIPBJVWvVBnYybyaf = @"sRWixhPlsFVQWPZGrXtBYJvICYZsbGEdXBtlcwVLNpZgPPcbFktxttBHdENDPoMCpCBFHNwkUetLzwziVBXoEBciqxTbFcIbznYjBhjLDEbohTXFZj";
	return nsrIPBJVWvVBnYybyaf;
}

+ (nonnull NSDictionary *)GOZSFcHBNPMwrqsLZVC :(nonnull NSDictionary *)yNofNPJbOzga {
	NSDictionary *lxZkCVzkaDM = @{
		@"RXFxaVFJCK": @"ITLVGAMZKzhlIVwioSnajLPhiMAfbUKgMoEqBkPxNmUcxBwUJqiDkhyrwoPNhecNGraXgeYJhGQXRqaXwzqHFrAAlVJfcybQDAyZJDxgSU",
		@"aGPxOaWzRDDi": @"zjGrvpOhrYToLfbjRrXKtyYsozoaDwPyzzLoeLJIWgwrNwKLJnxSLePVukJeNyWtMPtlFWLORuEoNUojRFHbDrnsMaablBYoLcOnsRwEHkAKeczAdQbSGMYELa",
		@"gcPYxyCvGZCQxnvfw": @"TNZSrdvxshLXnWVHfTbSQWgYbPCDluDHGqipkTyhXlnHENTHZaOZpkFYCrnTSiwjVCiSniIFPnjBBwgfNhATaTKCRndDjOaKaOeVwrzOOMXiuUueFgmOOFFFl",
		@"gXDpgOFFIpab": @"nTKkrjakIVapZdKbyZNzNmdhswVBsuBqkFVjmJaBQKnOGUhEuIgHpAXSWWpzpYlFTICUKILLDVjztssYpFHwWlQVHFOmxfXEdmdMThVDC",
		@"ucGiSkacLNrSqKQyB": @"LyngzPJkPbEMEBXePZHDrtibuunptqUJynvKeBXGpeeuxXWERTIYGOShRtEdiRSTGzbXWUYcXyvjIkNOxmAoYwPGxxfFqKFRWYdIYZFbTfxbDsUPG",
		@"anXVfaMaLXhBLVSmE": @"RaYgRJeRCWwVuDLDVLeBvHxFzxZNkuNlixRkHvVnBGPUFGgJSZjnJDPkojRNlCtrFddwdteqTFhXLNuNeNCgXdfUqdBjmhJwxWxykZRWzSaFgEtF",
		@"UPtSzoTvCHABY": @"TpqAFxLqbhsovgTkNMoikkkSpNXokVmTfHnoImWAjHUhASQHrXMdeWZUWzqXGzKwPiducGKQTtokNovTTStDrXImGiqGKjBCVcJrbMXuIPeODjQGdqBhSGICiQtRxztgKlQwU",
		@"KfWcxwaTHWBkT": @"SCtIvpraaIjbHjAhjVfmZvaKTROsBHwkAjYyemqfpvqHwjGhwidNSfHcXiHsVkkptEwgEDNjPSsgaiAmguMuCHRedvKbtgfHFnjFhmVTwMEyPHblXOoPjyVYBqHVtNcJHAZhB",
		@"GZJzuWypoZIvU": @"KLCOMOcSNzcdcLxdtbPzIZmaPxDXnVfykqbCncLFCKQRFBdZRKgqaelaBsWYMFtBSbYfpFZKfRNXHRymrDBZdzckBHgAbSnkzkCxAPR",
		@"UPcZsHbAmMOFNDN": @"CHMoiNrmyfqKzitCxbUltCqewGfOawGJcZhuHaPrTVVcQckBcSksuooNQiWJFYRlTghjZCCtATsXZMIOSrCSKeDhUfndMiyIpTWOgKOcAs",
	};
	return lxZkCVzkaDM;
}

+ (nonnull NSString *)vLzouUFPyJP :(nonnull NSArray *)pfYPSuxnhDzr :(nonnull NSString *)NCHMkIVOuoZsETLYpA {
	NSString *qpGIDZunHDtJjWl = @"tIJhBeoLnRHsSeuZIrAXEQdWgNDKlQbHTmaoBJHZoygiIuetGGUNJchORTfrieeEXxmMNwsqZqjPPyMMZIbJXMkRdwyHISUCFNelopklRGnVSCInFvoaHGMJESmoRXkmePrsYlMH";
	return qpGIDZunHDtJjWl;
}

- (nonnull UIImage *)dmzOlhXKLtjyVMsDZ :(nonnull NSArray *)tUegveOrtVJbPzGQdnU :(nonnull UIImage *)ZesCcGaMFqbIJte :(nonnull NSString *)SyyhlSuNCXRflCgeaN {
	NSData *WhFiiJkaPgUREUga = [@"YWqxdjMWeupNtUQDyQwiDkIahaRuLbATzsYmtTUIlFIuIcBdNJXpINXfScObWpuMgPnIjTlxkAdjOvrZsUcqcoYfTYUqVuRzuhVEuBMrYH" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MAyJZiTbncEoPMAlK = [UIImage imageWithData:WhFiiJkaPgUREUga];
	MAyJZiTbncEoPMAlK = [UIImage imageNamed:@"qPMVJmBCKGYYRGErTuqajCfaKygMIGXJqWmuAtQqLlumsDBmdGKTIYhbxWwLkeFXkgsUyGTecHuhtUOVNvnSANrdzHkhTzWFnnlqZuZuVvqAaFvCKUQEy"];
	return MAyJZiTbncEoPMAlK;
}

+ (nonnull UIImage *)pCWlLAmymTcX :(nonnull NSArray *)ZRvPRtbBFtQAZbrC :(nonnull NSArray *)IdaHMYGXsMb {
	NSData *JdtAMaqJxUcw = [@"AUWKnrTqdDCXQsALgWSJGsdMwWThsjHPEuPhtXPLaoWacungIZVlHBIXISvWxByLmAxkPnJPglVZafylfzqplUzTQwxKdFFIzSBiRXehhVzMKTHSFvjSjjcBntHTmyHudjEhabEjAolPRjq" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *BAjjshKkkFlA = [UIImage imageWithData:JdtAMaqJxUcw];
	BAjjshKkkFlA = [UIImage imageNamed:@"exShqJhnrKeccsRTNqlvDNskaWYanbsORKLGzVhEJBDIULcwIDpsQrmSLdODhGzlXWFgWojmsoqpyXmJdIEwZLqaUFAmDJFSxiTFSLIcKWjqJlViivjisveogKQOAqVhMZVdkoKWEWA"];
	return BAjjshKkkFlA;
}

- (nonnull NSString *)RqwCSSuarFFuwC :(nonnull NSArray *)WvcOgMrvppkJoL :(nonnull UIImage *)xDbSgsPITjOP {
	NSString *RzTTGuwgpmVtqo = @"qtKjyEQiGjkrIDZoUvybdtlzrSgCnltCAgcjnwavPnKDQxVVrbcplQtlwEvXQcAwnXASTRDOJGldwbefsGZtStAhFYmmGmFlYCrzMiyAyXOGmsoGcAtPFDwIaXEVXVSoOvlGaNfDZTNwUfc";
	return RzTTGuwgpmVtqo;
}

+ (nonnull NSString *)waammBiiRhLlPbXhxL :(nonnull NSDictionary *)jqxZpXPnNbnyWjKq :(nonnull NSArray *)fcubCliwlfGCsqhWuGT {
	NSString *NQVwZlxSTMzydLMO = @"IwwKRkNPGbzNBCOkgRkIeQJuvZwJPOrkCQKWJEqagfsnrZrLkXpFLxEKJWLwvoGhMzAPpdtYAhJDiMTsQdoGxbPAeNJXWPQtvukGTaULqhDSDynbVxtMuhhzMfkhTjpsEgoCvFWayHUOYXrG";
	return NQVwZlxSTMzydLMO;
}

+ (nonnull NSArray *)LCVsVqjestzFRJBJ :(nonnull NSDictionary *)AufDTBIiAeCppqm :(nonnull NSArray *)oqzWoOZbCWOkLfy :(nonnull NSData *)KjEZQTLAyr {
	NSArray *pHBriwdoXVbsKQXIhIm = @[
		@"bjVdzCvKCXUZbmYVbElWSQYCRYXkNwexquLzjGWchzewNdWYjEzjfbxriEJSeCmBMtJFFXQiYSFaiCVIDiQMrqSYKbUWSmHyeDwuEMIfrBUSgZMZpYFFBx",
		@"DkinlVrjvVuMPHZPfxlWYtdwPEWoNkKZoiFaunytizmfRxbArmJosEWYfFnzQHKuwnWApfSRYHUvYaICyThIcdcjHVIZlDyfNpoveIfhtBxbUwuYdrHemuxgLSakABxhPKwHYvGP",
		@"aQTkjaFhekNVNQMUQgOJGkpqmSVjvvrRVRRWlzIQWOZeVIIFcdWXwsGtRqhMuihOZkAmEVXJBTjLSQtXlXPavLYmGvCkgEWxsxwwBFCfpHChkZWqtpHbJigUOlpFbRwaVOsvZPNcEMN",
		@"KumnRrRuWtBDHQxrzICZPeElTYwhUjqgugXxUSDfAoaGaebDGtnCcWihJSDROPhaIpRRdWRjqLXfGkrwHmFkjHuYvDMusAVaWJGhPcqumGressnzNuMMRzdxTfUiOafgceDtkvqgKFVTnUU",
		@"DIeiFhkTpLfNRRgdISJtKHMEQpUNBibzGJLttHOWXuEUIWhceSrVyOPTAqLqqPsRxwXLZQIPGiFvQusxrjDcoDSawzLqyEXiyXocVEj",
		@"QcpcEhlZgSVCgnFLBDhKnQpXZAhwMjbFwTFCmVzPGPdqYpmOkxBkhaVcTKAwXowVWgXtkxNLDlFJJKFdxpgLEklrOxcnYfaIsljKfxiOhpSsHPzPUOeGCsihnUDIjhlMLG",
		@"evKWMUIjGcWMArXKbFvzufImQsKtHAdCbtCpqifZdZtkNvHSJOZHBLFKcreSVzSjxwQipkRzscTUIpnyVZutKbpegXvzwcFoYKFqpxfrIapnIoSfXmeiYtbZUKVuyE",
		@"FQKXGlplvhuFaCHbrAKoEgPaInajuIzKxaHMySvyCtvyDpMNYagJnkumvMUVEYkCQQkBCooEPQhhtdadYsfjgeYWHUyMUMiXYLRZoupVkMxgyMJzXhQwhAJxRqiiCXwlhmpwg",
		@"JWClecdHRnxINcHcOBGEgudrRiOKEZOsyEufnrNiyGcMUkTlkRFQXaiFcNuTsvwHzPchKEXulstgTcSKbMaZmzfHEMLOfrexMDOSxJmPJLWtgnIfYZPSnqOihZodwHyeVILSdjOmYKywgCIAbICrK",
		@"VIpQhHwHcclBUmwIZTupRBjuLpSgAPEsbpUoBtmHmmdFxYLwyeQRNPjaitFGNwdkDYHSQdprmVOCPhnVaTtuQWYRMWOAXfaZMIkPzxXjIwrWBMaRHawWVfoX",
		@"UxhftIrtABHTELaqIiIRSXgTIhfvwJkBTtqIybrLiyapkmrddwIBKpWliIRopcIzCwDxpnIjjGZgTKjYEycxVLcCNMEMwyRPqTjOJOVtcgWo",
		@"qggmIPXXSOzlBwfMrViOkmuJcBPFaqpCyGZnNZYpyZbPpQSHArpaIccITzzhxbGQoaUSppvDKYBfTMUjrFqknNkkUsujScDdslrniNiKZqizqHKHKjDZMPMqCHUnodulHDsnEkOD",
		@"OIdAnBtZZnDjepoLWlBVyVargEcCQckbubMKstxmHNFXvqrrTqGMHQVcpadPbXCWGfTFAjiScSBCiroEaFJVIvMnkqSaHhgazUqCpMkVCCCgsVeCLxYMXcXWfttYxItrf",
	];
	return pHBriwdoXVbsKQXIhIm;
}

- (nonnull NSData *)GDnYnoAwzcNCQF :(nonnull NSData *)oXxjiLLtDYoGk {
	NSData *cTvPmUMlRXOcR = [@"jedyQwHqztELeFfsYNdCUzosdBJXgyNMAqkNTRJlUlDKEpFSUXvphMJZdRCkRIagpDcaJqFqpskvmqDdYtioUhcNiAxYMSKhosSXoUWOXTQoUvlTIHiLeMLPdCmthShUMjWYWqKejqBEPn" dataUsingEncoding:NSUTF8StringEncoding];
	return cTvPmUMlRXOcR;
}

- (nonnull NSString *)NuttvGQujwnH :(nonnull NSString *)GqKKHKHbfqUSPK :(nonnull NSDictionary *)GxLdzlXdlI {
	NSString *PyEgQWYOnOpZYNjgJ = @"lAYFnCPXYQxbhmqfNsgylTbRhkyJGoQZEMtRhrfYqTvbZebTYzqfhptDcFeyNvIssgLCMgVPRINDlPLFwCGHdmEerGPfcVViFXPlI";
	return PyEgQWYOnOpZYNjgJ;
}

- (nonnull NSString *)nrxJtBkehIUQAxkd :(nonnull NSString *)BLNdWGDKaKDZPtkV :(nonnull NSString *)iskbLwckdMJQxGMxi {
	NSString *JTBLeJcSMmd = @"jMdRPbqMgVwIQPSFIXCUPZepqRNYTXPMOuzAUoFzFuSUXBQfIaGvYerCqIiMEXERoaiwRWCloUfnCfgtPHOxWyQbbvpbcsberlgWkAvclAxfcX";
	return JTBLeJcSMmd;
}

+ (nonnull NSData *)xgxKJHeaDrvuRGpcv :(nonnull NSData *)eqfJbdbHrzUkhXDwHex {
	NSData *HWgJEzYPtCMorUkia = [@"RqIemGGfEunVDUyUmNzBjsBBmNtvBiNlqWQfvyjIVKDGcFuvLZNrbSgUyGSUhDXQytJqGHxzTuJHHfmFyWIeJMyeAbJVSzlKGjMVHuTUTOcQoDAjonNvGcKuzxRqZjZlZ" dataUsingEncoding:NSUTF8StringEncoding];
	return HWgJEzYPtCMorUkia;
}

- (nonnull NSArray *)biFsApceCU :(nonnull UIImage *)IHdYAbiKbCUvJEPQ {
	NSArray *RmiMGAFmdD = @[
		@"eVCkskpRklAfSXtESgoYcsGJfdkGOKmnkMaKbbgeENHhupNSUunBHbbEUCevGuxbUqxUbIJQFYiEFwDYRwAjLxBTDjtFqcYbcskGZWnmgnhmijIcXUSIbLR",
		@"OBVcJWLdYimHskaYPeNeiSnspoeGUVgIJXHfVLTKOkzshKEbaYsQfQKUfXcqLJIjCmWPtLSzrTpbIhCHaSKgPcdEVxRkyOXKLyYptCLlstJIpwMITyOHUAXqqOPQxgLheJynSAvykgDhBIOriqh",
		@"hjRDtPaLdmKvibYPvhuJIeAJwDyoPTQasXsUZblfjNJAcDjfZrpNNOpIcZcKdGYrGmYxHhwpTLvKvPeJSdposTGRBIdwATHzKJupKOaKNDLbYBlCRWOlRikYLXl",
		@"qqveJvcKdoVESulOEYIpXnSUteDerMqAdKQyRiVCDbDChacwQdHrZhOJZfbIFgyZsegKDFanXeJGYqDTaQyZtlZUMjXFPnkbddTWjcuQiOWtwyFSnXxVpXVVNgxxAdaLyICBeyxX",
		@"XpTWmMxlYLqmnJAwAumjAbLcibITsAqVODKtMwwFSMLSQfEefwapiSnayStWClPektZsXJrsSgqhfcmPWHwtxzGdINqzOhrtfAfKXZfcpcSdRAkivnXTvWojGFA",
		@"bcPObFyqdLPytXhtmDubyEBfARtSCjCcbRsaOLloIxOIrleGtYLYLunkvpOtEMZedXFhyPgfCvLKAktfqHJsSmAGaTszoWmtLTcdfZJGYitLVUVnTzvwnXRXlvOD",
		@"nUWbzbWIZqIrFofATFeorKlocCSuaXPYGxLgfyvPSmyvPItflHiqWxyolMYsJkWUtCCQmsDtMFxSGJelpJVhoyobYssSsJjoLkzqdfBFNWOctDkQDFBdFhkEl",
		@"mfNFrkcCOOsIjpRVagBUCtTHfXzpbKVeZsdKNcGBIHgvmDfnglAYWvgbYSfwEkaaiMSuZRAHxnQyxqhDBXQaRPmyIFXxnRplSaueKKyhcdILQUtnLmDJimzPwL",
		@"yIyEbPKHCQHQQtIeGbIkuzvbwTnLBpcHywExfUzHAqCCgImczlfijCtcneEghCtoWEiTEAZmjijaSnmTUGYQIfsANJEEeTjKjsVQgZeUdtSkHQOgAEsYq",
		@"IDcPcEPoAqxHSCbdWGKEEUcdEBbjnEAoWcIFCuEAjBZoNOVqdPUeUZUNgZOFWmEmDMhcetgdVJlWZDVUvUdwADJpjUmErMXXRpSVyMxYdVkKOD",
		@"baWmvuTMVucqtOwRiZXADBPWdqZkJnroGHZZdenilIrjIIOnKFiXHpkBgIMHbOHhnTJHYZHQkvmEBqIGornjLybVGEXkhLhQQtuuHJma",
	];
	return RmiMGAFmdD;
}

+ (nonnull NSArray *)UZWbtRcnRgQoP :(nonnull NSString *)daJYPtyKXzpgQDcZ {
	NSArray *UhuhhJryFQl = @[
		@"OMctOWzQRcKLaFhfnGhMkWcDImdVZiMQLshktTjTUfsnLzgIJWDQEKBIRssPvfFrzlaeRqumXgPXfavCVrumJJDzTUrwzbsFHjphbETc",
		@"qryvoqklgIjWHMVslWusjFjjnYUhDdArcbxBRRVOZXFPyHhgaZgTIVAVZbNnlQMLvInEjlzthPeQCtPWHcZXwTuDbQMAcWcByHzkpKHGiX",
		@"NBTFkVTupjGTRDUQwNubLbZgRqSImNagowtXUBZhDYcZvPOSXnYBvfgMTWwliWyXyaJnnbkrmeQgZcbbkKFCWAyUvAWJdJlDsddGtUfWLFXeHAyBzJJXaZulh",
		@"rmZBYCXwKqKVxqtGqUWJvOweWBAMKgMEuAhOPOXOHFNGafskSzPYTkFfLFakdLLOmGpbZgevLRfkUHNCJoaTlJbjOPSUcBsxFwlWTTenCJfyVcAQVbTqtqUtgKJNSTDGjhNDg",
		@"NaWCfSrMWpvytKXOXOliOKqErdRwZsLsREnSzsxKPdrTZgBBhCDORSzuiTNaDKwvzRXmKacUQuVIrqhGBNKzmzRXYmjEqBQSOhndPMIOMi",
		@"OLFPiVYHmmdldixlObBEOlJeiycmZKgfAuNLFYRJotLgltJevFjLJvgjirbfvSsQjuazgWPezHypIIPsHFKBJbjdBYFbuREJEkavpcQTwYAPdKkFVVxbaqfoDHMJaxfvdzlDMK",
		@"qCPyrKLVsUfAvDjKUSotMDsrWhqeKsUDPMYvTxGzFCYQKcuiyWfECAqoDVRJZXbsHaPEuZXRDOsIfXetKOJwLPZxnqrYeoJMuWSvKlMxMXdqqXrgxEOCVrDLuSSEXlnKreaCAtDeodWbZhoqXYnfI",
		@"EmGaGvmQfSrmeGuaWFpBCOXxssuFuxqBixmyrToiMUSDAfGIYdfOtlIifIrmAUQgjdDoCycnvUIctNcuuYCdswYNLSHSewudzkQntYsimAnnaodgUFjflWiw",
		@"iZAUfdxiJdwCROusDYWGQAorNDaOESGVDwUYIvkzuzDPfmpQoFNuqxszMWpISfaxgNKVPjejkUerBhtDmFckhxnvqTniMOVOJnQzvAsdwiHsKmEZsqYPUAsVXj",
		@"pdbzSqHvgDhsqbGUuAfQGooybwWvTOXujvdDuXpFqKBXTCxZQMaPjrSdPpytKAfOMkbGmHUkadJpXdkPXNKssCxmkXbHRGuEaVturNPJNNInhLHpUvUBBLJNgvSJ",
		@"ZetuNDAzMSwAfhJYsdpTULJMUEzVWUYGzbMhLiKGrbFbnSgzjBDyvZVXKUIeESlCbUQWmWcPgxnTsOGpKlcihAWKYwqxcUIZBIRHVctgvIOPyXNIQndOKhXXi",
		@"jOVLnwxNQWDOemhnEmJIpNRbfZJUvEnKYIMEhwRqImYyoJnNWREUMhMdiksFMtetjPeSnUtnjVOfxaqTqmaXrehmvxwlvAdgOtVtxQmUkOIfPPMtLqkFFvHcOxkvCjgXJgpCZVAnykVlCOITrjaiT",
		@"PPiqOgMRcShBodkdwCqxIaLOMcVwaFKigUtAVmyAvWWXqtIlQdIolLsaSPrDNQlDkduWxnMfSwBUKKOmqfNGFzPXKrYKdLKlaMYtIXOzNlX",
		@"ljsFuPpKQuYkmwOIlPSBKLldeGrzAiOsYyueXpZXMkFFlhTEcPDpCcRCoVTqFPchahjHQrvXcExOTwVZkKrffCPtgMpgHufajDlz",
		@"sUTayZkyVlbYxUEVPGnOJaLWbQKGLEkKdFfqFmrKAaOkMbGKSeicfekkxOWeTgDeINPmGhGWmqYwUlvlDxvYiFWgcrczfjSkIqwXkbF",
		@"jbxMdrSWUcwZvlKbAfEVpmpwBdRUuNThWgbAjTuuTCbhPKRPicZDYIzvOIpoRISWDNwcJHsCleWLMQrzJzJJOPZLhxJnemqpeSUhlgBQscaVVjDkdtvRidp",
		@"jQEKkJiIqubbGZytbdzPvRdpayeIJtLIXztPubAmPzBSLBDdIEHOBlYOxhWpFacMIBMSSzRRUZXFlsWdcPffEIzqmTzPKSHvMbbNantTAqpm",
		@"EKZQMGdSwTtNcbYLgAwwCKXWVyYrjcKCBNJIWVUIwhFBDemBnYfiXfquskSnCorjDRJjQOFBWMfJWZPeiVRrTqitlCWToqkeJvgoOibsyNNQIEKlS",
	];
	return UhuhhJryFQl;
}

- (nonnull NSData *)IeEwrXLIcpYWsJjpuwW :(nonnull NSArray *)mDfCyHyHaYOD :(nonnull NSString *)DdYSqxUbFdt :(nonnull NSData *)cmsWCUbJfMWvPuIwQgk {
	NSData *FSDAsKNlhVhpWoco = [@"QdIVRMnjdigATUVsaMNCSCfdnKcysqBGqcGSJRKZQkCDqHsBYpSeHrKDUJSBHmCErtBduLeREGrCElMlmvJqqrLpDacUUzptxBcMzvmwJcSLNDJEVyccRQLefQWYveJBKmqJXmEdRj" dataUsingEncoding:NSUTF8StringEncoding];
	return FSDAsKNlhVhpWoco;
}

+ (nonnull NSData *)zqdUDruSXTEKxhogS :(nonnull NSData *)BkEZFshfeOemwVccGNb :(nonnull NSString *)uCqHClzsGejvrRcA {
	NSData *klgkPPQoslcNeaTlQ = [@"RxAmuPFWNBWgpBBllhxdQWmOyYDpjhyQlfQvothHsTtpamXrcHcPNrqwIBRMcGrTLXfJVAFCqHiyDDbaJugYDxbsNAaDyHmSHYENUGJoEYYonjyDgrmTxipCUq" dataUsingEncoding:NSUTF8StringEncoding];
	return klgkPPQoslcNeaTlQ;
}

+ (nonnull UIImage *)eWnOwCchkHe :(nonnull UIImage *)uCaiEYfWwXkjXU :(nonnull UIImage *)BsXhAcGJrtLQC {
	NSData *osyKucdIDgh = [@"ruWADDpjOxDqhsYLkfNicMgkUJGnEqFeZSvIOPWaaLZhmXZEzWrkXkOqTdqKPMxvXRCJjXXxTtYxbBoqCuGyuiSOUnEDeinMRzojwhNOkzLNDWXEjXiRNqABjlzIeeNLxtUyGREHKQd" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *dfYJPSWVGkpsJmZztS = [UIImage imageWithData:osyKucdIDgh];
	dfYJPSWVGkpsJmZztS = [UIImage imageNamed:@"xpUDpnafaFigjuwQqeCVRMnifQfwqRXAMTHeZBYOyxLzAGnDTLzhSihYuMBJxsxUNJvfxIJmQRtAMharjfMKxlljTGcbekgHAUiYhtGFNbloSWQRDPpYTmdDhcfVOK"];
	return dfYJPSWVGkpsJmZztS;
}

+ (nonnull NSArray *)pVIKUmOAOblDoI :(nonnull NSString *)jlJAPxPIZllV :(nonnull NSData *)ShLsWhaAAHrXS :(nonnull NSDictionary *)pftsGAgJuHNUMRpnFg {
	NSArray *YhJRQSeVDVKpsLRzf = @[
		@"EiXPTWRqmBKgLsKfZupGtowhaeMWYNcpmtAnVhOQIUNdPCIoXDmxFjRTukosrSaIwPPBBsfmFHVCxkVooVLzsevJOsYklKKpsTSIWXOLw",
		@"uXyLbKeCHtOgJElzOtRECmqHePITOFEDqYPAAZCsAcoDJihoXwsWrYaUQJNAIWAvKlPjvHoaTYBGVXFlWMpJmZsMVRrqwDuOSohLAIOsQeQmPUrOBBLDPd",
		@"uGUVkOEZfYtpHafTXnpgGdeMozWrzqkdNpGZRcTKSoKDzUgPGCgOmSALIUIqCpTVlsZmeXUAXluYeBweaGYXeSLUKEIYfLrTMctxcoqabenvCdJPzdLLRFNFJGZeTR",
		@"jNACDuKgQjZkZtDOHHZyPlocwMgwtRvLJNlswOmoZNRWkvRPjjPDhXlYifvFKHRjMTSJwBBwyjuHLnCICLiTUwzJuEBlYTryzBsDoYkUbhJevzAxVIwRCsldzexy",
		@"IkAVypkJLCIYKKWKlXowIquMlthhMdvyBWxNWyHMIvsPvWTkftXGCnKBfxhtNvUOlXNoofhoADzvynVIZKYqyZzNStCNAgzFIoiIMEVKiFaVJNkUMNquhIRqYcZxNGRiHmqjlX",
		@"oCmmUfnvISyulaTgTHqnqmURwklPQBzuvHwyOsiLiGwcPHGXeqfSgSlPjjGkSYdfzrcckLSEZCLckZmMIJkacMUmykbiLafgpCsm",
		@"YcOSEGSWcWeYwnyeTQhWetxAeTKvOYrKYRmiKjRdSevmVcFOvZhqFiOfkKTmPSrbNwVQaqYMKoNmsiYBkRCeSORBXNsdnAfDmqvXft",
		@"WtJARqIEdyuDslTPojTyKNrmRXPvzOtwymMYDxLaiKZzfiLzbagzWaCCURKlioCBsGqWIZVQvBEJRArLZoFJqHvxoLliSkmxrIThMmxWTIQWLDyyUzRhMmfFzJSsQtDvxTaVFyneS",
		@"phSEtrZHrVcblgivbgYIdmJUdCHoOePQvldMVCopMdCdbHSVmRWhMxOsLbDgGIxFAnDZBVATWULwMyEiOpzjLgNWyxGpIaXVZTzeVlovmwhMDmGNZzJfZrCjDTyDEK",
		@"STdhVDqhnEoNsnLLNnLWNxmsBrObudGRoiqzoCUeEBqOhUbnHZlQxrJutVOKBmzGOLsBueweZNQhLXZpwqlbhomimjZHeGOchsKBjKrtqQnciIvVBcmaZDT",
		@"tCPgDvTgnRAFKIxtKpEhvopYlcwUGbfPxOSQqrNTcAXcExmOToYenQgflthabTeUfMdkgtzQhqaSfEweZSQNdxCIoyxDSUNJqSRpCHQUlGQNEhpmZBPspZFethGbShNPOBQlAghgtOLCMxtiiIYW",
		@"qLrpGkGXmcOqEiMuQHWUpKPiaRKQKXjcCKIgEVcZxGvvdANpaDGOODUjlfLQUPifwjrHLKOQLQoDkNbxCLFZAsYcbtackQfqchMCffPeaWAiVCfggdqMaGESBelcda",
		@"pLFwIeEucVWlahQakzbScBSPNhxDiuAMWpHuarrDuWgBQfnlnuezyztirBZIrOZXvokXGdUWARhMbjceJucrvAJnJodKXnurdONOFFoL",
		@"AgEMEbQBVnadQQhqtbGeXGKtbloTBevbfeRVGNBcSKDdJAIFsPAHvIVeqkHgBgXmPEmfWiVdqrumAgxcVONxlJmMzBLzGKnTcjfaLTRNXVnxItfegUWvMImYDUFfNjfQrYtMjDcve",
		@"hGVCLCXLpjrfooxKeCigjoeIvjMEWaiiNVwvgTEzANpLCiIWyCDYotKdmaZRMUdoXbCVAbGigCrZCBoFAejSuwUxzbuZhiGJUhHBZdDvYQklHlWZbFKHgMqUCfjwLiLpLiSrVcaDU",
		@"xmbDHKVXXoYxiWyCxZlQaKUyMFYxBVKGAVVPzeRDiYppTLtxwSLBMrSnikarGtASzWZMnvTYmzqcodnEasBeOrFcAaPwXooMehKLLHele",
		@"OkhzezLioOietfAsJHmxlFpFQSulHVuLjACSnsEsORqHNvkCAcfgxPXgCywxIiSSyvOBcYHFoCOFyFEyUgMFhkipvrvACQuZQVbojvwwVHMigla",
		@"NxBsnyYosKKXbbZeqljwCwzNnDNkpiTeQwJDDNnzndXbnspSoTuNCbDZbUfwungbEzKoHLCdEsISaXYtSTWUTXYOmoVXdRsjkuIhUVTwYDWgiiBdiTwNpwDrHOxgDQbYqazksCCtlj",
	];
	return YhJRQSeVDVKpsLRzf;
}

+ (nonnull NSString *)nEnmrYuXkKOMFTT :(nonnull NSString *)UKIvRSoZEIIDjoxuSb :(nonnull UIImage *)vHNrfvQgZCEImSGmmT :(nonnull NSArray *)fthOZeIEtDl {
	NSString *RYGjTueiwuvpiOKbezr = @"bVcSQxoGoHYbrmjKGWvedfOUVQzgyyJWPmrirNRMrxkWrCjfPCFxTVFvDBuIIdvesvcCdIKkqJOfXtRCQcYXqptLuOxcWPpBjopJgKpNTKkKIjhieKZOzLWJPmdgmbyFTlAtwVUjTq";
	return RYGjTueiwuvpiOKbezr;
}

+ (nonnull NSArray *)YfiKvYBZkwlEhxC :(nonnull NSDictionary *)bjKCYWQxqWeRX :(nonnull NSString *)rDAPeXTYwwSkWu {
	NSArray *LprtHZpcybYKJ = @[
		@"XlDDSrsQeEZyESbqegxWhpSBecKVDujMVRMGEbarPUrtDZFzwDfuQgvYgvkgiUchnuFAoAjukeneoZnXDdsvBFpdaWKKIVxoAoZGoZNVsVyDTZwsqFadsflfHwOzLzrsb",
		@"feMyrncXVzpCjJFamiZpaJknEtUfRykdUCMYyTNFUWLKqCxGJoRFEQSXWoHEiVyBdmNlGOdOVVASYPxZDYPPQINiWsQqhXuiJevoi",
		@"jlAukljHgxPCVXdagkWAFuNcwMtKZVEDAtrqpGYbRChuJCEgIpZhwYXIuliZQczROdIPvwKboWVxDAZggmXZuZUeYeJAsVbtQaAHdjJdkwVEHEFPn",
		@"nWbAgZPZkphXeCDntAiAihZyRsXLMUrqhMnDNUlzmgIPJzZsDeuMjEbiMgVmXYhExJhqSdSmTSpvkxHlDbCQhhJnHraQzRfUEOuNfvabdTs",
		@"chfOHzwgsTJVpHlzlpMJJXNSMSRErhUSBGVfXCFBOtgVFLuKqsNSSVVBPZDuDNGBlfdAqvPMRcZTiBDydxhzduRozbZpCKPouALlDhjbefidUJOHDasiaveSmwYkuoZXDcwieQDGEubGU",
		@"GWvpNuPcOVGvFJzNZzQohGJtUYcALPMewASgEpRgyInxIAiUuxgysdRnNskjNhTKorrubMShErjhEIOxfrCDXPDeaiVrmEIPouDXANpmvXIrMhdjDIBbvvQmAr",
		@"YXIDnXIHoPeMNiueZZFgjvABJOKJNOZxKCmGOvmDRyOzFRkokaagklvDTNAoXTlBAZfSYTEwqSapMdncvglpshxynDvvMWyRNXIvEtYOqxthMKCNTyTGlQrioZudDLQOSKpz",
		@"OWZALamVhPgRTaobeAeMpqAhgmHqsiQskvdMfSCRfaWsccvdxnbBSNYkYrtRPwunMtmByYBBwhTFfOQCnXBOCVQBqfTojHNPQjhYiLjLrvDYLcGtZHhZJAROLxp",
		@"LOWzZVcEdMZupUXwCLtVpSMLeWGKmjZwEAgOtidMFsYpNbULUVaSyHKUwjZPFcGcueNpFXJwAgBCaQHcAAiOVKJWkbKDptDXSVUWhyKkwHEwnJHFMidSVQiteUvXyLkEhBlhyBTQQvavF",
		@"dYefDalXINGCZJUYSfMuOiwZGkyZBuCBKJMunjGexIvYRsOPhKpvsFQPerZtJezdLPrudAGoAjKvHsjqSMRPCBWleadHnmhIqvxImRjXXtkQuMDUgBVqLpsHAmzJuwjaropWaCbBFdvWbOr",
		@"KmYSddnOmkedcnUMpeKrkYPNpGJhQwEcMLvaTZyYaxpRbfwyGIiLcfXOERfPZgMYkZKpHTQRjfBrPnoeeHiWUCaVdrNcoseDTJTmtqXXMKxeADKxqOwQoAZNDqSlzjjxHPLWMeyCgVbxkBfgSj",
		@"jVbOmblYJrVPuQmGMWNQnTwUDEeXLNZOYpHgeWiXXOrhaeNcQxXwxEMtqqVhNyuehhWBqXoboTxIogLpYMOYDOxrmpYQzdiBNgCGNyseYQszkMqhAwfJJmMjltG",
		@"mwRSjCzxpVPuIbLkkWGaehheWUWQDWKsguUvsqTzBYyQlzphKFxijpXNlqEwiiMDHPMbanyhEpDScmQoEjwYWMPwPpRmLSaZRvggAniANImcuKjEyShUK",
		@"tIOlGevsQiWQcctXcwLbxxfJsADwxtyHtDIcEWmtswwbrBICqZPiRMquxTAjzUNNmnNjySNqfnaZITcTojyMTIARAGtyENugSXDazBtiVwpSqKAodCikdxwhResOZCRgCXkqWEw",
		@"AcHvllxxIoOEkoeWqKvIlOpmhVITrCktOwvvytKTZGoLMltSrkNOuoJEfAuBDBJsunjmzvWfDZfqTmPdLodGoevkBHnEHHhIXjMiGlNRLosQ",
		@"sbJiNrkFChuOBgnyZOeaSmHVLZPjIsUyCoeFWEuHlGnLQXpybKYrONBGABRYfFCFTJErHKQbBSYemaGGFfcrdboxCnMEfRfbBtWMnvrMUqTFigUckyAOk",
		@"wkDrrLrKylIRVKebdysAkKljuszExZBYOBZhBFhqnqGJYxlZweEmUlqrZABKeTacFtFTNcBiIgoehhFNZqaIEBQgouqxuMkSYKHmXyytFsoDDdTAoAsgzYz",
		@"GCUPcLIwpCaGznyPPtHfHFQtiefzATgoMYVxeqprkJBblNGbsOXiqJcljRndqXdKDfhFQNraVgUceEhQbvuKXueiNaNeSRFahdHtzrTCnmHDfoHOibQChcFHLjhoQXIlnmray",
		@"gJbxpxiGullycoBkqfKhhhRSeeITMUCplfHZiUeNBqfDCpEHUlzvBWVzwJhIffTPpbzljkNsqcLnthcSZScpodBBfQJlkHwpysJaDaosYHBLNxSPv",
	];
	return LprtHZpcybYKJ;
}

+ (nonnull NSDictionary *)LorgpyiIlCpKFL :(nonnull NSData *)pGVebqUdye :(nonnull UIImage *)fEcnSFuTHsjDHMqyWX :(nonnull NSString *)czsckRjEFrc {
	NSDictionary *pFPjGtDkxxmsSzhn = @{
		@"BsIbMkiZULfwSr": @"YxFxNcqskWPgxLrDDSxuVdYoZdVxDynJbCdKRYXpAiXsCwtZsDuBzbkfkapTplYUvzKwJtyAHzVMGWutYEJZdHuFLTRZgYwMhjawAMoXbjmt",
		@"jDoCfUzZRDySPsGr": @"SUFoaAvyGIsEFUMmMWTWRsrdQlROJodaKXOZmQRzhHDqdeudJgjvevMlhddvQNsTCkJSBFEfbcSPGQBUaklVUKsjZMaIlQNKAhYYtH",
		@"SZOCwdAjAoSLyJd": @"mpkJPJzvDNvxwuQzIOlezzphBiURBTybKksdlXWUprhyjPltiDCDcPoWWmnJFILhQYroSZTPzFbSsQinrahZfelzjAaGoOgVxElEiAAzVyXrrpMZptNlyYoMLVBoGDWvcukibAcY",
		@"DehYZmSLPI": @"BqJZNKQJJABZpUmgDuvkjunVvTOJJxqboTdmGDXjUWVoJpqBbuEZhmowKlFMCbfqzQoMCOMnXptwtteEbRwNTyVhKmitgEZbViLopDdTSRGeYmZjxOiVrIuIaZxEDXvJRUGiKvYrMtCwJGT",
		@"HWiBKogIalMfiosP": @"mubISOMsZFjbvkiEfpvMerykNIxHPpcKoDcFkodZIlZWxLHJPuiHvZHcSHkltpYoyIgjvGlRnxtfZIawTLsdfACQriHtGYTIgpfQByIwlmtPbYYNuDISFMOZFwczgNbmRgVJmAByUwpDAJEXvb",
		@"bWoZjIzUpXQMizJ": @"COMYtrkhLDaYTxUAEiNKhDNuiAGoJzMzoNoUCEbUilCpRRGITrcEEVXurvNseexhRfOndeoiMvsNMhgHnJkCKKncHQPWUrSkAMSZOcdQlpcSaQSyzrzmYFzabYJWWwtBSNBqeQMZMQuGNct",
		@"sHnyLZQGwpKPoRp": @"SqkWpCaGrFhbWAANuUmHbJBdtxANMrPYzjPURdqNKYXHCFoIHtKssgixyVHXXzlluehtrbSTfQKlHXGXdSzbRempHlBNylbzOsAIlKKMQCPidKLnpaiU",
		@"ynSlcANlXcxeFLJ": @"cIEkYAySTGCOZlDdECDSEGJdJbyauukHIWhBOqQYadMUpCiridBDYUaDUFdcpgEBPbzyebLGYactomXAZMwEbIqDvqjOiDnOAMJpeLHiPvTOQhu",
		@"uhDFGdbVWRFHPAW": @"MMrwhawCrNwZBZhllxUccfebPWdgfZofsNpCChRUcwtfEUwKBiwNGohGcfhDVyDmnoPxkrgEeeKZNejrNntGcbSFWDawTwzfHbUKyPQNqTpY",
		@"dlsCYKDPYSZzHv": @"TOWnscUZInGQReuzQYwKFgmbpKZQHaeNYlnHEmQFolTpWRSUegMPwSdkDEeKjdeMdjjDmXsBXIYUjEIHctdMOViNCoWUTDlTddItnZqilMyNvjOoHYnnxTeutYPfLDzPpJYBMiEcOObshpvj",
		@"GTTkrSiNpSAOjO": @"yXIEgWzLjrGjysLzvgLeWDZhDRMERiVpQTbNgVRyNXeUZyEvTXofKDhTCbDeYVaTrnliVNqZLqVXCwEHaPZjSiYByvuLRMqnEmOABpLrwjoLyLbjvchrMewcEKvdBNjaCRgJEsiEgwTtCYjdUgr",
		@"ZiFhbpaVPBjFxerCAgq": @"IxPvqaKjrsPNDuKlhJjlEQAMnwQjHojXAlmEaVAkqUaUxDTVVEUWnDtGhNSYLCcRNmCfnnTLblgeZuKfnZzMUoAeNfWZRKpVFJggfJOAYQZCEaxcSCCrTnRoeVawuTLcijgaUmKeYryhsh",
		@"kSXTyifEuXCC": @"anCyCWGqHpTvYcjWVVOerentiiAQztNjsrUhVZxdfhvMbSsWBQJckybMSouCTRXIJbvaLQPqpZycJVnJuWwnRrnFHrHDUaRtdZbfzwQOWYnIWcgOio",
	};
	return pFPjGtDkxxmsSzhn;
}

- (nonnull NSString *)iLIWQQSRddXOX :(nonnull NSArray *)ijYdEweAkqUZnAKfL :(nonnull NSDictionary *)VUEywDcsboH :(nonnull NSDictionary *)LnnDwXnCKx {
	NSString *gaFZiMtFQMlwvPS = @"eRrCYJLdyHUpfsqedAnzcTQYXdkcJuRBqklKdeXcfydmhUMtcmRFZLZYgcRatMidPPTJkfcpuqbJHVPnjVgjOjKSisXxNDPRSilfnRQiYlquauWCfXvNkkYbXoWxaDZMQSKbVpEtaLookmjFzLdW";
	return gaFZiMtFQMlwvPS;
}

- (nonnull NSData *)yKZbubaoHYVs :(nonnull NSString *)HSIpVJCPEBnYRdIMsr :(nonnull UIImage *)dczVXjaxcMbfOQG :(nonnull NSString *)NpHWROGVYCGn {
	NSData *pdirKnTnvIUkwpyWZ = [@"YGaShOAKTatBvMmzdkxtuRGfGSPKMimJrtPRnRlzFpjNucUCzrLuAENYySlROOqrkTULaHPXWhixrvPmciCrVogQHkEodLUDVfcTGSFtBFzClDNQgqdGaaoUDHZEWSxHRbKgFAoVgvFF" dataUsingEncoding:NSUTF8StringEncoding];
	return pdirKnTnvIUkwpyWZ;
}

- (nonnull NSArray *)dlaflHdcJXRfimdu :(nonnull NSData *)QmOEmJZYPmc :(nonnull NSArray *)NSRcWGZSUlCLfO {
	NSArray *PGXqLOThHO = @[
		@"IQBbQkxagMDSojEWIpLBlQTpHhbOgtaMlXidawLoXJdczEcuJSOYbsDgKcXNgcrOXMJtxlburZkhMwVtbVKIhToyXprehqkEPfMkYbBWbTwAfsOPSZJduZEMbwYFtOTvEMsgAgHhifdOvicW",
		@"iMUHBWIXfECbiClVMnwQBMFCunQwWITBdkxcrkkFvAhKfZFnfvhqwFGnXUXMvrGgFzhtWfKDxaiSBDIEvowpokwmrCWLoedsizIUpFpdPm",
		@"bQHBenVOgWijblNOGWBzQmFvhekIqRKGbavFgcdpKdtzYUdPRJTOWTlXwikiTFyXhfUiTzEhCjIPTuhdOamsbTMDHKsaWywkFYJVEOCMFcTzFnXqLCWfQQEBrYDEVgzeMDThNuVu",
		@"XCLGSfKtkYvJGOzegwimXBPpJWMGbVcKuZaYsnttBBdqKpffFJOEwtANHxPXiKdtxIJtvvyMzNdYuKOENyPlKgxtlTpissvbMGkgnfrhxznMZlHfhmEyFrUUbwQiBKyOSKQIyQkGjx",
		@"CfJJQSpyQixmwgsusgNwTHZwJKqPTLBrSFUcVVQbWsXyxayLQnYjsQFOiNfmzTnEtFLbYTcPoColHQXTsrSLjXniQjpPUsjbyTLpopNlrUlwCoiOCOIFAttyEWboRDparoKAz",
		@"sTJCsPlYRdxLVWSqvOMcYPINQwvfeKkZZawWxUdTwvSRBhTpshveIweaauToVdezRRuRESEsPUcuNOXLpABmqwDJTbChTDyDBbszFBHPoClIpVmdajymNDloDWXCmflnneQOkYYsLcVWeyUwG",
		@"JANZYZgFLxhbeSVIsOxorsBeEsrbvptfGdSUHpqtroUZjtRoJeklDMXZDapPnexWeLQeaEMIcevFUFFHimjskXBxiRrPyMapeBTgisbRAmwJsPCWhMqBYdUWHzaLSua",
		@"esaWYyVgImjVluSrTCNwLFyKEHDbbdmFWBaCUoiDKVhvfhTJcvHYfJBWIyaadCfKnLfcfHriyaqDcBhdBvVflPtsuzGxlGWWtHvrwbKpQhLEULkpCVrNOzNeBigcCZLxmPVpeHaItNDtXPsBGFKkZ",
		@"XeXrqSbLmPlkpYSlenDmFiKKvUPmNraVFYITKvdKHojvXmlsRgDtKuaBYMGEJjNqyoJHEMQTcyGhewGkoMYVEEpOsooMhshbgLqvYDdvonPSFQbIBIaW",
		@"AobuYdlxxNWhfMCDhzNMcIgOGhbfbvfHmjLUHGclKqrXQuzqWpfEzZbvijckpyITBxeoNSKCYTMeKurkUDhbwVflaLOPlObuGpnwCoLYApPgUiBQatblJJQzjsHpqYEPvQdek",
		@"lFDITgbfRJRBevkWCdaRasSFYEOVvZWoWHfndHaNkGfdQcVIyiPjHQEaflEQFxjofPBIXWpeRkwCGemOhoBPQeTiSIqElcHBYsMYqQxpvXzyplIKWNyjxNsyrwxpCjJbwTIC",
		@"kOFXAGkEBnaHibJORZrMAflAhtWLRIPOfhhjdDeEAvxqNbEmwcIYrqIBzFtvHvyQPLObNXoThJLpAdMCkLhmdjaCBGXsViEjaUkKBigtxtwBfPUbcCeqqduqoW",
		@"MOBTgPDumHgKedVdMmaNHhdKCNxEKYlRqxeMVCdPLJFTKPzwmqJUyAAJHBNAScvGmbhVROVUBbuEoxzJVkxDWKsDWUzVTTuZfBSiuMaRzGpigxwZOqhIEcYHBQAYKTKcyRWRPeXHiB",
		@"eZPAWxItbleshDmWgvSAoKuFpeYiUkgkpJhTcbMmtkjkRclapKhoZjtauhMNvZNkyhjRMjTzBnCNUDUECiBdMDHXFYtMXUAScrLdKPaggWffJrWhTEYhfeFgLrHSfCDOgDRmJoQ",
		@"ZCnLBDdbQypclbQaJxRqiYsUYYqRngpJLOMGOQgtorrKlLUnvBhWOyecsQVNdNVGBvZfiiMfWWwBNBTeVBVzeZhZgTZAdeauoBNftIyiIdvRRsxgpXyuhNELzJdtABzWMFR",
		@"xsRVtlTecuQVdRUdHCqPZbZbsEpwhRlJyJmZCRWzcyhlzhdlUSrLlCiedzAKakPpoyhobkBDHNoZIMIpYulGQodSDlmwLpBthAllWGcMOApNYlg",
		@"lHFMLgwNlLQSjXnNWHrwtWqxiyhHaVwHNLOrXYiidVWXkLIIRvPtCVfSczixupGVztUrbXDfAUxfVnIJCQYyexuCjBexUcQGqiFHjAwkqRKSOMSyJqwvrSv",
		@"HAruUgFLtBTWCIhkCcZDiriJDEYGKAXkTsdusKyDpTibTIkuxUriWlwwxBgmEVAZMEBUufEOBvLmdPJGfsvBUuKONsYbVLCSLtNseycrQBDQXXzgOrJSZYAjA",
		@"VuZHVEpLflIzIcoRiPyqHuZQPeepZrMsZYRNHdirJfRXkjUTKHQhaRBtyBzUvdRhRyTcDZNURyXJwPziuOyURZwRsNaTKaLoLfYpTFYlEPZwioAbLBbqMzZWddeqbHBd",
	];
	return PGXqLOThHO;
}

- (nonnull NSArray *)ZxhlzxpTBtcaYbQzh :(nonnull NSData *)PIPiuzOzjcgEgFfg {
	NSArray *VufFzZKxAnTsxRsv = @[
		@"UGuHabqZMLReLEMnHbSrJpUKCCQTcKAaCtvHSJWhWZHGRikMSzMuDqMhyVAmxujyLvHXuDXJOvIfeobKSVjXiUesEQxyhGVvWLeutMRdPyUSxvBRJQXkeMfUFbIEOhthVlJdpraIa",
		@"TeuKfYewBryuuVQgmFOkuIUQWxwsexrPvzRqrLdScuIWSKFACHjJcpViSYZDEZwSGZknbBnnTsrxsOlsDgoTeSGIPYyxcSlGnLmbHnPnJTbdWnB",
		@"FHEOgZpTYIkKeJXWlgAkPWjfbfhikhzeWVMVVsxxnZkBEWeWrvutePzKCliQAGUlhMZqujLIceXiixFInjRosAYslpKElPwAokMMKouruXqPsieGqVyXStMbtebgLVGKlTGSoDIxnfEXmSpPVDk",
		@"onNhPoWsDyvIOeYTaXaCbhvvzKNtgTroBoRQtokgHMdeSCNKkerxfpiaJqozbkbdCdtgXCWskNVBcWmbMqnrwTUwPxeVCPzNNJyNrGJAwtGCptOAMhstyfhFLuUoVYGFTy",
		@"iDKpTlGRfhwROaoyDetNjOlnywIMLwMbFPbOLfYCBrZUNjnqWXeLzSspaRyWndFtRIENHNUogJXgojBjKnBKKukwZesFmtRbZOzDqvcDmArxlGFCofDUFZrIqMOJjqZt",
		@"gRDShhSRrpKphpQnkhVGYxsrcCKSVTAeuyxoIhAespZTegFtCDgejrDBjNkUqSohHNvJWTNHxvYIfYGMJUsEBYPfrOUCIhwAomyHmeBzCOStttPwgJWdawrIyVRNNUikhk",
		@"zchrYBYyqAwLkwGYCrNraTvwvcbOgrkxWEFaejIfVVmGhwSlZYnvzxXIDrNFAphGKQfaIEBlGBEBDSGbNhOTwLBNqVXSxvCCjqVLWdcBShIlPIhoiiGBaeyaCDpJOdBsIDhAjG",
		@"ZSOgqjhSDowcNcUsOAldQmLjNARvSulHsXxcJNrzCAfBDUDSFLGFxYLQIbxcMepncFSXtUtDIeAlJcrGioJZvQhMPmZaazGDhnpKQAINAlHVZdfBjFaSBdGVStzacyJUoUjEoymfkKdCvUmjoVg",
		@"VYGFthSpPmrzIjYErbgzEIjvJmJLGLAwxKavdRJJxPSekzuJyZPLGBMXQSuvYunxPghILfLDdQshHTmskCfnFKzoGtXKxbskUlyGZjAVNqOerUnkdZDKRNYweuTcIMxEZdWHCuIvlfoqlDZBXmwn",
		@"GKDTbEQGpGdQlNrcjKUXJeezzcSqJpVNtHGpulPGjjZcLWmBJzcKWWYiYOtlsGyBSNrTldLsZLPMovzGSOLRwgFodakPMkYPCURttfaBpvZLApC",
	];
	return VufFzZKxAnTsxRsv;
}

+ (nonnull NSString *)ltRbVyIxyjDcmA :(nonnull NSData *)LXTkeknkHptqVXn :(nonnull NSString *)zqcWpAYkdBw {
	NSString *SVdIjcqbiCsfxpFlgAK = @"hqlnSdQVOOWxfWVCZJHPTlCDWNLAbIqIBCaqYGZeAQWlKdneAgPHqdyzqKGSeSXyoSbjqxkshvvegMLJEORmKkNGKLeXZVNzRdzsdAdQUvIoNVqyYpYdLG";
	return SVdIjcqbiCsfxpFlgAK;
}

- (nonnull NSArray *)bAybLHaeQRJ :(nonnull NSString *)yqeAHmweQhSpysYH {
	NSArray *NrBJRPYsKJAkA = @[
		@"sdBfAnfKVVCedlUCFYNsDizdXuPLtpvOzhvfNVCMQhMGGoFFwMKAbqBGTdStGeneiBVnihcONnUjpSfYgGLfizDrZAeCcbRYQuTzrWunyXWDXvdShSLWLViacUrOmYKIB",
		@"lsqSRLaEgGwOiUXhMjLZvzXfRtOdHFmcWfxQsocjuGsIdOsPCuRtEKviwiGXvmMWCoFwjcCPMKWUecyEWbFmggKXBQjxJPITlmMG",
		@"bRLftHoioDaHPosuZNMeakbZNdlGeNlKLfAyvUuYAJlePgFNCSvHEkTkUJWquOcJoQiigoMOOweKCMkdqFbSXWsnMurgKDvjgTBKGqeDAeFalnMziRtjrBSEoAeggCByEPcgVDfwo",
		@"rVwYAWFCpOhPScRicSPWssuNntuBLVIvVtuxmibCziPgjhdxnoJyyZOHicRGVlBXiqJCPTayGffyUatHOWnXacXYHqStCiYhegXmHhkBhvvutBqxvBqVes",
		@"xZOSLMPxlrTVJtxLPCtyTnxPJPdiBuGUMHSqCFjAXcbAEPpkzOkkzwdNUAyofiiNBMBjAjhnKegtyydiAAIEPXhScEiuLKomterzDnniEOvgharmETcjlmADLZSIt",
		@"PvnUYTbWZkLqVUGWkRloHGbBhUkdznoNIJHqoLORGismtmjoXZafKpeKjxuifJSJyvNYeMeQPbrNTlXwJUaLHnxSDUhnmLwkRjrqvNRQnLkWfoqmGqR",
		@"oUeckwGhQtcEMrdnvvLTSaoGmgBDvdlPxkcQlttCyjWbzpvadaxESdDovFvrQMZqQIQVxvmtOVxfPycuxtXrzIrhJykfVaVmFQgTsoNDJvNCJNyeZcI",
		@"UdJGZIDIwkOwkOGdPqGhSdWOQeOiKOClcEoTfagxZdUfqRvgtwVuHMyDCSEyoBKMQRvIwTlPWtqOyNHYdHXUtrNcDrwWhpYkWBdoJpSbthBucH",
		@"QqWJfgnUvBoeniQtKzYOwGVtjTuPwaUvfWsnCxJBUfixJmCJMdKdvrvgarVUBuKUrKOMHhOiGLezSizNdMvvtcveOSKxHnXBLTGgHgzhaEzCkoccCEDaWukXJsDVgbmsO",
		@"yegxBXsVWhnHCgikpzhXbDxGCafLNZhNazHjbDdtAbZNeJdcqwnXTJOfdRFigzJnKxGUsltZFoKchfyjecwPeHTcdsuebqEgAvZsMQxjjwzPxPYJHMWKNFBVDuAf",
		@"kyDLVHPTWBcnfZTxXmaRfnGEdffIdVpSlkUOoDsdTraJKSkubZjsRdXtJZliPBybKtCsYNfmEImeNZFuAGesRkoMMDOsFsbMdWdDLrMGPDkYqLTqrIqMUAkarWiKufDEpegGKdRaFMWJKeVm",
		@"YGKZWkAbXXIVEQcBJrPoHLPYbcvIGbCakuXpUpOdVyarcluSCFVRuacYkqUMwHppXubiccbygTsdPosvpvJrNiAgRFtIYrWGrgfjvBGdlvsRJHxkeTHfWSuRflslAephbUMqHFMekzy",
		@"rBqxPGlNLdtDqtnoOHFhhypmTAaHJbHZyOvYkwtbUhzYVqGamjPSUHXDCoTsMFfqTmrHfNXzfdxJfrPMfTTuyRdmRqdWUNUnslcvUwkFlhK",
		@"AwOHwuUdGZTbdCKGFgzyfvJHLepIQhyLzlhGhiHqdvdSLwwWnVsZbezKVMDFLttZYMXuERGSXdUjharbBwhbDraCpSFXYZxHLhXERUaAHieyajLseVRTRKPUkK",
		@"OJWPMRaBPFzxVeMxOceYcsaqzFsFLYyOZpzmdrEyeuOwEoDvsKWPYgaNEkFvemjYptuwGyHmOuBcYGYLcQRbYlkYeuZHfImhZwMivQnHMxbusFaFlRvNwItJAffJHS",
		@"fRCauWpeBOrgESXopcJeXhpNWcrZqKSKNaXENgNiZGVgDtlSLKBjINcZpNIuLxVpGiyQcGHFWesVQytFPYDrVeDFVTxvSoxOazdmOyscToaszxJnGktuZmBQQJAdpDdyoaMniARaaSykRz",
		@"UQSmmRZnZhkllTtgoQFeIQIBDoieXTGSZMyTUGdKhXEwxVoIlLvLMaYazbZalXfYKECxGmPpXHYHmeZlGTjzCiHExheZgOZpJgBFMJgUDkNtWrBrBpePpRakLTFcCYADRVnQSMllMfABWxp",
		@"tNeTljWJfgdzEURpFLyqQxYnfuQvyLTrHrqTNsqyuPGXngWZVyVJHoqsaqjsMPwjMYJLwijXtyZxAzZUXRSNzENtQVVkczVnXidwGwntnIVUysBoYexXAsoV",
	];
	return NrBJRPYsKJAkA;
}

- (nonnull UIImage *)GtWybjRxnchPoAKqIPl :(nonnull UIImage *)uEantpGRXeT :(nonnull NSString *)YkptMFRKUINFBhF :(nonnull NSData *)ZMGrnUcjBb {
	NSData *qxcsObQPTdMjGUKsm = [@"fqkWFevmevJCNqFNomFNeMOFonqIUMzTUdLKsMopECDOHHVtGKTtPIQiKfAcDOZugEkHgJSFgxoQdxJUgowmsuxGNUCxHqGplhkkyKldiQ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *xEJHYchvoGHkeAzDzt = [UIImage imageWithData:qxcsObQPTdMjGUKsm];
	xEJHYchvoGHkeAzDzt = [UIImage imageNamed:@"llgnkyuWSJEwQkMCouZYtFbmpuFBngiNRlotBKEEynOjdjgkgdOSMFfbQtULPSqJXaTuuUkdyYNnBNnlqwCiEmEcqMdGfZNELrEvZTniLrpiUCW"];
	return xEJHYchvoGHkeAzDzt;
}

+ (nonnull NSDictionary *)XeIMsXChQl :(nonnull NSData *)lqQqBdbAhWZYsaO :(nonnull NSArray *)bKKIDAfRlVgCHZLSJK {
	NSDictionary *AFhBzojyJN = @{
		@"sDRjxKhFovlE": @"fbGAwOegsXmCAJjEgfgZWmDbCUyepOpyYWVaUfivKVSGRVbPITyqNJRFMMrXIbZcLcDtIIRuJyHTtSHeeVTDONDdUpWiMqngEZWErSbtrUEOxgpIYKaOnWGnmEwwHpBDryG",
		@"CQaxANaQkshVOrR": @"WJIiGyNXfKImLSvJnZjNhvDRbfBUxPUIGxYZDSEratfmnfIUrTZtYASORedWBAreQwidXvrFjHoHwIllpVqufXnRTrzxSwirPUvSCZDtSrdPRUoTpPDMwBnqzzXrpGLRpZgxG",
		@"YxyIHwosqwgAuzg": @"dRCXXEQQukZjyqvdFwTwRWyXONkbibZmSyfVcPONDUeICrsnDctclSbSxHRRrroxsMbZIHVRSIEHACpYSNOACKjXGsiNoOxZNsVnpKhDHJIbVGiXcKPkhRDkHBEouTmTedGpHiw",
		@"nZKQHQtmdYtQ": @"gEOkqCoOmqDipUtUahrCErKOdiXKwcCtRVpNHlbDrXRcycTECqJYoHaleKVlONMhwhJcobNEdVUvZMgijqhbMqhBcxwmixecFSjqiDjtmAGZDeYPaDbdvcBBtajDMFGrTpdptWNHKTSORE",
		@"ZHUDgIMIsVeAaqfGFQo": @"jhbmIHxtYjmcPBCkrQbxnhJgcuNkPEwYTJTeyFOMIXvpubxWdJGIEGVLFyCJkZEBumSqXgGFqseSpaWPYnLDcIkBuvjXUFdgZzkmRCHBmLnXJPwsJCbbABoK",
		@"HCzCKXFdAO": @"AzwhuiKyzemGHwenFmTSwtnBNkKKfEXuDoDxWEjcWjJdHLswNcKXntfQwhGsieBEahbSrYwQvTEeZpvCHBKOrFhSlTNvzUiQincthnxLytJgBiiYRnveemvhujkKOGULkQtMTa",
		@"olGThjerBkFPnWHMv": @"oUXPrffZPISwsrMHrqnNgcnUlLUAVzirYSILFlQlXVZSgmfXIEqEgexELqMoIhtcWxuJxYfDpgUYdAUCVKGTuKAxkSuWBirzlHXCwTKmbPwFTolfhvThLkqicIOCuzvAuUnBl",
		@"TpRkwjoGMwOF": @"uxOdmoeYzBZuYjvwsOhAxHLYdqzQLLPaRxeHljnWLROaKTHOoipYmEEMeVRRMngkmSORhEvAMqwiPXDVpFMxHTIRDdQFANRzQYGOemvMfnLOyzfEjEVFB",
		@"DrmaTmCmlLYKwlvsYGl": @"meIdJdAdiCJtJGKxVcjQcasYAsLoSmOFrlzPnFDNLQgKJLRRFeVbxDhzarIHXfcbkXSFJApqLykUvMdwLIweoDbChhBRBIvEOcENmPxHcDAUICgmpAbKxgqEKxRxWUhOuoxtQ",
		@"yKEWnKSRQYWyFAv": @"SKhCDhxrZuxvMemtgckGDazpHagDoBpvjpUGacSpVpdGikAyMKzmgjaelKNOOLyHeNoaIFISebmkeltdhBNFUWtcFREbKGMvfJIGmyXNhcvveUNHlOFnPLjlPVfHevs",
		@"LuNxXPYzNiEzL": @"ifxosdcpKbJDCWTvzstRpiChQHJiVKAzQsaKtpKegJnEJSDTwqbCTzkLnwJoiOenilRkZRNSUkxzJKzEMsTQrHLDRamproxrFhukijtccKALFWFjFo",
		@"yGhOgRBIdozswQgonz": @"NZpqJdnolatGLclOTGuvNbWlsPQwFZxjLgKWjFXdxGZnugBUiugCVtbnFcPiItgabDRPeZkEmzxCVmaxronTTpipspriCJSUjdFcpziYViYoLqYtbVBOHGpVfSDuUWvaJJcvq",
		@"XCuRgDsrcuVopX": @"PpAKavbcJkDymAJIjUFsSSnmRtbMXJEoghGAdjTNfrmGTTPChgujLjTWLRbZOxoqiYRiPUUhxHVWmbmuzCRMoMxIyUFJFdjwOfMLhUuubUvnimNBEOaMilBFKPHvaxrkygBxxTjOpkTqGsl",
		@"KTNRPSlhfJuXSnZA": @"TmoawlpfIpsbYlEIPntmsfjFFVZiOGbdoPOVFBUSyThgxduCcBhYUdXdxyEPBeXGTvEcLCNsSJMXqwYupXJeSPcUJugtibGKMRaPZhtokOdVzvDNdGBAZthfxuZBOPxUmx",
	};
	return AFhBzojyJN;
}

- (nonnull NSString *)qwvMIZNKpEXZFpwX :(nonnull NSData *)uJbMYjwKdsJqfnWrZd :(nonnull NSData *)UBKmKnJJse {
	NSString *PlRmigrvFQIoxJDn = @"pJBMXsDzzMnLkCQlzMWoYDBJXTRVsECshnoKRaqAHsioUtKAhaEHjPGeFwstNtmeSWPRjoYAVATjsmyqrpvfxcSZtbBVzIndRvtyb";
	return PlRmigrvFQIoxJDn;
}

+ (nonnull NSDictionary *)DFHlbIFhdpuZigCrAg :(nonnull NSString *)ewruGmZtTgZaFEWpCmJ :(nonnull UIImage *)gmDbYTvukTA {
	NSDictionary *IcRxuHbsBXfnHUm = @{
		@"lOFMOXCUfqfY": @"smEFMOLzZjeIqZbtlJZhTUIFndPhgsMRFRJdWWdPoCpcRuQHqbPkzVFLywZXvlulABkZpYaBRJJrWtdbuDYwaJlKZhBMcWWLHLVtoSUFJmZmZDTXgyDSdsFXY",
		@"utJezDPFPXtK": @"oHpLQxULOXYPwUoBXJKcusbnzBXegJvGeYqlErTLmZOEdpQtXFyJblPHtIhmqEUIOSKHzlcPfDHzFMCeZPqmDDiAxUoLYwjYgptbpmZndrGJWoazUnZoNvVNxDigzHGxBbrkIixOZwwYRCJGGxYEa",
		@"OtHwrcczIq": @"qrasRBFWSxpNIhCtqSnrVXcszUkDFaBLqgEkNgmKDNzPEoSJxGFRetBuvVrMceTQCCLbWIsdeURnlIksqaZlTrFXJeXRcsWVlpPtYScLFwQrOsLltcIPgMMxgnclnzimLNEohrPreklH",
		@"yrBDCSlRFwKeW": @"QGVsbCPHsobyhPZAgCwIQaenzFisEfGDEmXGgSEwsYyRPrQARaNMCmofyXJCzfpiaoqMESDbrIJnzeOvqYRDQQkgiMxFyCizPOAsVbEmaISiM",
		@"VwWrpEvkeNjLjc": @"vuKgKtPAuRmYGGsaAUWrlYvkljePRuUTZMgPgMorPSXeBdxsGIcjqzeEqXIiGipxOxVVYwozjjLPSxhgyvqGLQxiwIQCVeiMILaEKyTcwaHa",
		@"isDWQlVcgqgbImp": @"NohhregtrDhNygqdKSfUzMXTggEoaesjBrUNSItwuXBbaGtUEzconTgtHLqTiHOJSrllTKWscFSOBIOkXVWWexfFGcarmMEdXNnXUjrfXMZkRWlfhwWHddlOLDbNCqeDxfmbPaLWGwQCWFN",
		@"vICMGpvYqNYZ": @"jCZMYIblNwJGLEkybkIbWoucjyZEcgroHHKMoKVEFHiJtVgGEmhCgqRZQEJOXcEqxBPoipwOVQXRADXLwczpEXwmvjgwbLVORIwASnohVRBQRHTaHyezbqqWJOoCTdwm",
		@"tkhBeXrDzakdCPiL": @"JkIEVJZiHwHADeWUVWmDSbYrvBMllHbPZVKbDOcmXutvqPJJFInKHVbRIyQdupWLvaAwVULfAycGDRgFbyqbJhOqRaKTdtCmRwrPAF",
		@"TPGLEKiKGNrAd": @"FrOCSJNxvKmLlWIsvucacNmQWLqGcRlqOrJBkyjieZdHgXiJeoAbFJCrbqYUMsZrvooKxGFUelUDxUxWlRKumZgaVUpDfyeUvHGfNcTXAMCbOqrTblaHCOrxknllzjhbZToA",
		@"RlJgkAjIFu": @"JBfADVJbVixlChBpzTuWxudvyCwHISTOebhWtlRzhriWjpVrRhoBRKefrYOZMRMlqEjBGRZUCEPmAjCYhSJOhnAIgLSmCORRTLXWwaDeMbBvuxybqYuUsaolOtwGsDlwLhQerFqrxwZJRWKquAEX",
		@"NvZVmgLRfgGKSvTLNu": @"QBlmjIoLKVevFkCzgYbsgjWAsiJJHljDimpTMHvssNURCgJzCcYtJAHZLNtUsVUwXdAjzflhVYCQNGumUIMzyVATNEyzsVoeAYCnlJtlAspPvPpapqsBzAs",
		@"emklWVEaek": @"WQbobrEfwtrubkVdtTpXgVNQNnPaarNAzpyXWFGAgDftFdQavjdxMWuvuSeunXMAVsPTooUOYpMMIOItzNqafCVFVQmqlkffxSzsCSuhvRbmsZbxzluSMmgnsiHVnthUOMeSZAVotgEUNKmGAmFUY",
		@"ZFdKxhnYRUG": @"vyerBjuPSfolRDvekAzPCcWJWkiKXZgBYmXeUIKLHKcJMxykfYcIvXVEvskCDtsiZsoClItqCBqeHVqrNSvZaqmFpdyauDnUvWCcNbihjatCSDGvkRcI",
		@"rmjPxBLoPVfxRUrSy": @"ZjyIGCTfPWoXATxYrtZyXBNIRvOpmeGednsaECyMIkoAtRTuaLGQKCgeEFUwPRtZJaEOUsZyPALjeUZANjeqdWVnKHrgFwtDiZQTmQ",
		@"jqUXgTwdwziCFHE": @"fksVfKJMtfJNtWvbiCJGumOBwftjotqZoPYHMplEraGIAREIIKuGOjuaNYIVBOENEOEwHTmZjEzHwWTSontmbAHgaxvPOannmXoetJPyHoEGFwHanvtvewIrFrWzPfytZtdanfyL",
		@"GdYHmMTTqBPEvq": @"fwmcvfGXpykKNsQezYrBXZGXjdZuuFFagGWAafDvgYSjFolTcTwZsBtRQuGeKhZqYGoltDDrSjftnULkCeyrIrnDzsbfkaYOjAKPewDqtcwPRslfNYGiKHSEEIPoXsYeyJ",
		@"fTETKkNxvP": @"AYrtFOxupPkGTxoTCAOotBblXwHpKnNwVrOQdTwTWAdmdkDCOiFpHNNEVRSjhCqKqAVsYahZRuPVbocoKFrzBFutnmBQkHrFlMySxMJqlWKqVkbmWZnsjoy",
		@"zVDmXZxXnSJigczTRC": @"XHlqFrzcyfIBNZBFbWOCMzrqesgduprFpgAvUiJhsfqGPkMarfdLfISoDlxdnfbYrWcfFmLZZyNEQjHJNsYLcsYTqyhFHMMuXRFIJrFIzGuZXxrVSzpdCAJGJEuFievLNlWAiFgjrbAjqiNeI",
		@"mOZUptsUYeHFLAb": @"tDaZNLoITzZhBthxosBvwvrmmQLMPLXXkltswZNdEZkCMjnhWLvvKCgqrsyChogRRBytrVkTfugSOlDMsDNTzpjbAWrJUHkQptUNmGwhEQgbAxxpcqXrOlEvU",
	};
	return IcRxuHbsBXfnHUm;
}

+ (nonnull NSString *)KZlMLPSxcjCFQzR :(nonnull NSString *)lgqMgPNiWtPmNNoMzU :(nonnull UIImage *)nQiLokZmfLqqp {
	NSString *ztZlnNdZPHdgtpOW = @"aEuvNUmZFVgsEcOXfpKgPOpSvtWdVuCDYVhMQFkWBipIXyhEQLTFtBSDUKxxFrxtrfbNJttZrKDYUnpRZekjXAlYMPhtjrQzCVWuGCPgqtcDIupAxHcAk";
	return ztZlnNdZPHdgtpOW;
}

- (nonnull NSData *)YaATdgAfgOJtq :(nonnull NSData *)sMXKxhejGKQInxXXhvq {
	NSData *LpLcPtHVKgHxPBOTAU = [@"jXMuldvKHZUFlBZmepCdUuFblhlOYbwqPcDhjlPtvBQxJwrvUwvqjbwgBTSwKtQHsxoIVVaaTyDmcHUksFtcPsZHmQXrFeRHUNnyqXwuwUEngxaSLyGPxJevANfYEKjGdKAjH" dataUsingEncoding:NSUTF8StringEncoding];
	return LpLcPtHVKgHxPBOTAU;
}

- (nonnull UIImage *)mnJDaxnoxVVfczn :(nonnull NSArray *)KbmJkwwASfOnrgS :(nonnull UIImage *)swdidTbozueqx :(nonnull UIImage *)QJPoCdxIXbEAMoUNn {
	NSData *TNXRIPAmXrLB = [@"iFRZFoLbHWoOLWYDJgIQUWSPheZVJLgPPTXQVblatRQBMePMZHwJfkVshcErGzTaNbHMNmMMiKbwmtPjfcCmZlXUuLFKTmImUvcsGwnXfbAigPqrtozGumzIaoHLyUdGsENLDQc" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *FBujqMDTaHp = [UIImage imageWithData:TNXRIPAmXrLB];
	FBujqMDTaHp = [UIImage imageNamed:@"izpBkjVLoPUlKkFxuijWPPKOWKdxBLGDivThneukmHDhjPWAvWcdwSABuYQDvjIWwoySPBGdMFXMvyOdgGrBKabESeVWBbDSGqnHbkEcheHADniKONvKT"];
	return FBujqMDTaHp;
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}


@end
