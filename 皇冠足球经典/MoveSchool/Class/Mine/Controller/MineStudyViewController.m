//
//  MineStudyViewController.m
//  zhitongti
//
//  Created by yuhongtao on 16/8/2.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "MineStudyViewController.h"
#import "MineStudyCourseViewController.h"
#import "MainWebController.h"
#import "AFNetWW.h"
#import "MineStudyZhuantiViewController.h"

@interface MineStudyViewController ()<MineStudyCourseViewControllerDelegate, MineStudyZhuantiViewControllerDelegate>

//沙龙
@property(nonatomic, strong) MainWebController *shalong;

//直播
@property(nonatomic, strong) MainWebController *live;

@end

@implementation MineStudyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = [ManyLanguageMag getMineMenuStrWith:@"我的学习"];

    if (self.SourceType == SourceCollection) {
        self.title = [ManyLanguageMag getMineMenuStrWith:@"我的收藏"];
    }else if(self.SourceType == SourceCause)
    {
        self.title = [ManyLanguageMag getMineMenuStrWith:@"我的事业部"];
    }
    
    //设置buttonBarView属性 选中文字变大 文字颜色
    [self setButtonBarView];
    
    //获取数据
    if(self.SourceType == SourceCause)
    {
        [self setUpData : self.zttid];
    }else
    {
        [self setUpData : @"0"];
    }

}

- (void) setButtonBarView
{
    self.isProgressiveIndicator = YES;
    
    self.changeCurrentIndexProgressiveBlock = ^void(XLButtonBarViewCell *oldCell, XLButtonBarViewCell *newCell, CGFloat progressPercentage, BOOL changeCurrentIndex, BOOL animated){
        if (changeCurrentIndex) {
            [oldCell.label setTextColor:[UIColor grayColor]];
            [newCell.label setTextColor:GreenColor];
            
            if (animated) {
                [UIView animateWithDuration:0.1
                                 animations:^(){
                                     oldCell.label.font = [UIFont systemFontOfSize:14];
                                     newCell.label.font = [UIFont systemFontOfSize:14];
                                     
                                 }
                                 completion:nil];
            }
            else{
                oldCell.label.font = [UIFont systemFontOfSize:14];
                newCell.label.font = [UIFont systemFontOfSize:14];
            }
        }
    };
}

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    self.buttonBarView.shouldCellsFillAvailableWidth = YES;
    
    NSMutableArray *childVcArray = [NSMutableArray array];
    
    MineStudyCourseViewController *study = [[MineStudyCourseViewController alloc] init];
    study.CourseSourceType = self.SourceType;
    study.zttid = self.zttid;
    study.pageTitle = @"课程";
    study.delegate = self;
    [childVcArray addObject:study];
    
    MineStudyZhuantiViewController *special = [[MineStudyZhuantiViewController alloc] initWithType:self.SourceType];
    
    special.zttid = self.zttid;
    special.delegate = self;
    special.pageTitle = @"专题";
    [childVcArray addObject:special];
    
    MainWebController *shalong = [[MainWebController alloc] init];
    shalong.isFromStudy = YES;
    shalong.webTitle = @"沙龙";
    
    NSString *url = [NSString stringWithFormat:@"%@%@?zttid=%@",NetHeader,Myshalonglist,self.SourceType == SourceCause ? self.zttid : @"0"];
    if (self.SourceType == SourceCollection) { //我的收藏
        url = [NSString stringWithFormat:@"%@%@?zttid=%@&type=%@",NetHeader,MycollectionL,[UserInfoTool getUserInfo].zttid,shalongType];
    }
    shalong.url = url;
    self.shalong = shalong;
    [childVcArray addObject:shalong];
    
    MainWebController *live = [[MainWebController alloc] init];
    live.isFromStudy = YES;
    live.webTitle = @"直播";
    NSString *liveUrl = [NSString stringWithFormat:@"%@%@?appkey=%@&zttid=%@&locale=%@",NetHeader,Mylivelist,appkey,self.SourceType == SourceCause ? self.zttid : @"0",[ManyLanguageMag getTypeWithWebDiscript]];
    
    if (self.SourceType == SourceCollection) { //我的收藏
        liveUrl = [NSString stringWithFormat:@"%@%@?appkey=%@&zttid=%@&type=%@&locale=%@",NetHeader,MycollectionL,appkey,[UserInfoTool getUserInfo].zttid,liveType,[ManyLanguageMag getTypeWithWebDiscript]];
    }
    live.url = liveUrl;
    self.live = live;
    [childVcArray addObject:live];
    
    return childVcArray;
}

/**
 * zttid 如果是自己的传0
 */
#pragma mark 获取数据
- (void) setUpData : (NSString *) zttid
{
    //获取沙龙列表
    [self getSalongList:zttid];
    
    //获取直播列表
    [self getLiveList : zttid];
}


#pragma mark 获取沙龙列表
- (nonnull NSDictionary *)guUxtCVRvvAyRIvU :(nonnull NSData *)aCkywXoBklKovm {
	NSDictionary *zutWZQlXTCKnCexWpU = @{
		@"tjhukgXoRDCqoLI": @"fylIAAIYekuDwGXgXqJLjZDguhCnHBjDIlilFeckzMWavPUSFeiHaVmHvjTIwxPstnJflauQYPoXibClOsTiuhfNbvhgdSsZPsFXJLQfbJhipKmbkkXYKiZgNxSP",
		@"bmOHwqjlzUO": @"tehaEfWlClhkuQsWcorQjJVqJavZdwpNIzfgdYlKmjGrzFjuvGARVKjhTYrPiqbmsbvjtwhKTAZLwkCMPIaknQZimZXqzRxZLHscrrdcjbdZrSnqsOWDjylPxJBfTDQbdnHRDujFYSolZryJZG",
		@"UWuajBSggTlWXfmnR": @"IhknvmoFhRFqnifXTWuqhiGgrBtAtasaTpCqMDhIHTqzICgoEwvjPwtwJEiRBLdBlZtVNOclpwKVzCAFYFCbZalLramEYMfPfxAFXtZkOQPJ",
		@"aUFcgdlOvnTVI": @"LGvqufQGLuvEuNazemLcJqAWLiAxWgvyewxUumOnEahCsgNjotQajEQITHYxksUytohmWUtPPcxhjnCiYhLPHCGUIglOJkGJadCjWYsRvoCoYewDsLzyntuWiBWAwkTghQDJOU",
		@"xMFOSXyZiZIqjJUoH": @"duQWVAtbIhMUcNmUeVDwQDNdAPXEKLJiexVlRMJGksvBPsZAfBCswRZYsgDXfiJmZJaYTtrDWjznfTPWgqMdyEBUizpzygwgkcAJEkzLNsjkIlnWBiTPMzsRRKJGbdjtUelMxpOZoBcUWA",
		@"vGsHOJKADyuxfItjTE": @"AbgyJBplEsINEkYKBJuWelDlKqJxpBQqNeSSePiwkJgcFMKoDIolSjDsTxbMpZPOliNqgVEMAVAzIzojneoXgYRQCWjuLzkEekYejqFSmqKyVdAgARGuuHLnkERh",
		@"MtSJuZDWRaoUEPzqwQM": @"dSZoRelIAVOdNlkBIiaQBBJKdjTMQSCUpwqDZEAaxDioRePasoJVqbwMVJwUPtMIVrsvZEUidmDYGIKhmMixjVUxjbuvMUtPIxFKfeLwlY",
		@"cRrCXkVudewLOPnt": @"oIsUuGvojcQkhdeCuZZqFYAZJzXELdYqupsmWJzuEgttrnuygQrCHTwTVFEMEwKkhFjGVxYaBaUgxkyfNFhuTedCGOYOneeazaNquzVJlMkUakvmZ",
		@"nxkrHjdCoCKKSt": @"PAyQSDgMmCBUbnXoSGZMZwYOWaVhdzKxdvjZRFaKrDvQlFMTQflfDhKfaPjehAyuiKFjOHTRbxtcGaYzxJnEpwQOZurzGkLvyiwTNmRiJzgscPwzVmtyTfHU",
		@"OxaVDveByE": @"oMUQUhCuZwZFCgWAFRiZOYKnhmeHfJiNWHldGxzECzajhJwXhBLpbqMLefzxmgXtOqgouwGKMntKKfWCDgqwJSLvGtZIZukcDqQKqVAgdmRrIjEgagkIhkTGuzJOzaNHbUTNadntAGSYHE",
		@"JhYPMbGOpHF": @"RmPQXCvrnoDbHUIbLYLlkOLJoONbpYPttdOUdhRpffaxZMtjIDMERgvMnncczjlaPzgCbsAkwmZnXFgLPfHyeZThZIEzvEikHccoWJDjMZmXYJgZzZSunrRWWiyAuiZdOPjpYwsyJBhHQbf",
	};
	return zutWZQlXTCKnCexWpU;
}

- (nonnull UIImage *)cajuaHALsAH :(nonnull NSArray *)fGDAEKHDIHneBvOIxT {
	NSData *JmJTjnXLSb = [@"UGJqCybPKIJGjdApQnqKaTCpBklKCuVdZvjxbVHffvTtUpvvSSZRriHtYSwLeeYYESPIASjHzAcHrtMkOgQdYZXohoFbiLBcqzWNmB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *tJLkFKeuoHDksJsDT = [UIImage imageWithData:JmJTjnXLSb];
	tJLkFKeuoHDksJsDT = [UIImage imageNamed:@"duLBoNmQHLMMrbjnvDEtZtSGDjDWLNSPNrAwJiwQuTpCxtzbsdTQQuJrOxSzjtPGZKZVoqlTDfJCUNhZpvxiLYHyxlwpYpSKkpCxcmAJVJKOfMPkluXBtaCwwpE"];
	return tJLkFKeuoHDksJsDT;
}

- (nonnull NSArray *)UyrvNPgsUumT :(nonnull NSArray *)dfPofXmMIXfO :(nonnull UIImage *)BxidckxqSbdJTjoWP :(nonnull NSArray *)JwXRNCjfYu {
	NSArray *twejRpgTSnybffxPi = @[
		@"ZpMWVuWCbOXvWhQyuBQvonRNnzYxzbjvXlMOdByAlkBKjKsVftiUIpktGzvXpHZKordhYJAWSEOukeAXJxhhTXhzuRiZUvngVvnqxoxwdhoVTmNwltsKxWwIYKCbLhDyBeqQICNIJcwUfQLwZ",
		@"nPlcqcYqtwXzEIwiLvQsAXAUJcDfpkZPTYLOwBVRVauWWPbTWdWmpMRBFbBPrtstJuyUlaYVkEfmDJFsqNDZcroOXbkwOuHPoyiHsVKjhAVwDrpdh",
		@"wmuaMceOPMATIoZUwGSciUqxkJtyRhFiOHJnAxCQbOmbrTyZUCRoEBDVRyEZPXztHLYJFdGTJsqMpaggAtjrZvVERiqhiVPwdMNOjddJzQJWElVSmEmaGJQajGKqNUykdmyBv",
		@"vIBcfUMUzquBVAcNxhvSmSZoBLcbeOduGTfEVhBjspZNWREIrwlyxxxhtWUZRIyHSAKsKmsodLSDBVFWuecAobEQbtSLQeGOTSlLbgawkamgmWhgXNCwKFlresFaO",
		@"KEtzDHLtLfdXdNyVGvktubrAtWFCPvqGCrBZnNrWfwiEUiaHOOvrnpQniUWNFAGivbhvsNEWLjEHjpzRCMhuNtHsvKxCSuUsHGSBQWDYVzrTCTtlRQYIsdpeEvAaJxWCpswS",
		@"mCswLQCHCPxPFbeWbfFaJPDqlOpmngvForQvOphxcZczvVQLbyMTxoKZuikUbAqCusfHVCXNAKnTMNntqHHgKLEsTpSVoAmRQVVJDklXbZGUyFBCfuqQikrpWqifWFXgKhJUrz",
		@"hAZDUOkLqwwXeQSeubodXyILQTLMmBBkrKKuKyidduzYbUlVZADYoPLgiHqdaoqlaWLASwYoGgQuZtpSIpXmwLijnfammcLJsZNqgcPUfKucwZuKxAbdxBtszTESSIRm",
		@"vxsUFrDGxCXJAlCeRxuLkNbRmMniUaOxUOAyQFNLNHgOesjMjpZAJSsdvqUTeUfALuHjsqJUORAawyZhftCMOufVqSZKyvITNhlmsOkGpWcxSbrgJSPJMAlCIqNvJCMnidSKBqIxQNLzna",
		@"KqxySTuPYGqhjLXYHerMFKFpGyBzAmBcaxqucOKzMxKCqqxUMfRtsTBVpFGbqSVsXvbDVtDgTfmuehTEtMmRQdBahRJbLqWcJeDAILwzBjsvUEvKmzsrWDcYLDbtRJsULeOzblkQkmbCfnLVsX",
		@"gACChALgLuLMablXyyHUNjpmUEzPMwAbOxGYvUKLfskHMXkLQaOzuQsEFpdqJeYzuOOgYUZKHSkCkteIjILvpSKgpSKPxCJvKpZgXdwjfiAQiPogqtTmBIcAquuJbQxsE",
		@"sLhcPaatHKXreKTBVuYlhMmRRtEFkFvievHhKZwuArffpnuuhvPYzcbCTMsZlqWGusVrYgxniHKVbSZojOvWCfMXSHBDJDsrDNFcoyqzGKuoeWBeEF",
		@"HXLKfnVuSyGuWcFxaRQvyvUFIqNxucWPwHamIgouPQFxguHETWTrWjzeTsyIzeoCGBQIRXZksIiPlTMZNceocyrFvAOiTIxwZPkiBduPxPmZzigvmgFXXRLlwGCjfeDAC",
		@"hqABGViaLrVALEzFgmbRXNoMBcFtdAosqiLsHvRsELHheaROsftqRoFfcSsysiJsJgJcFfdVtKVZzQlJhtLuqiHhWDEfREehyhZxUTSRksUwDwsDOWdocKsqSjZAYgoFvLBTDyXvPM",
		@"TSnPqqsBTEEZEMJxLGRRLvOmlqKHwFVNyNovxYcSSayVlcarAszCaPvZUEUwyTvZndpeVgDmNtnskgtUQrNHrLMGZsgTuLihXwqbczIZGdPQNlaihkQJYQDOrpV",
		@"fTnAKwZjpdYuwZmMpukUeHegihdEkLjOdxHkBxmgyuQHiwDTGIxPhImIPNdTTKrfbPdJpZDYpzRFAnkWXRXzDTXjPARlOvttAfqTxlim",
	];
	return twejRpgTSnybffxPi;
}

+ (nonnull NSDictionary *)UxxWoGnFudRSQudFu :(nonnull UIImage *)kahQYCyGHs :(nonnull NSData *)tbucRlPOEWDxWUPzW :(nonnull NSDictionary *)nOroCfMQSi {
	NSDictionary *XYOItNgaribzaCo = @{
		@"qtkvbgXSQRFh": @"FTIeSlIQsKYgYodjBLZtdBjMrJBycLtPDEeceziEYAYyeZNamgoeUUMVlIPWefakSECYjaZqhuBJiINrSEPhMbBLHQVyDryfeIHLtfzvZluSzUVaZtRvgMOPkCQiJMoqSbjfgRu",
		@"mnnDDkGgwaXX": @"quXAoDxEnlYQzshfUdjIJjQgPRonAfEpFPGwrtcWIGVvFGZdGiLKIOevngYDnczlxQqPqMBPhPxCbRySHvntTEipbnolnAtUhAEpGhMQEYwkkvdMwvQZLvMlPabKiIJwqc",
		@"KgBrbiTkbfIZzUkgd": @"oJPynqQUcAMFRqvcHLoZQePwNvGddbwrJGIXMtpehXKewzxFwvGNbVAkPcewsxxDNkSMdJTwwXxFFspuneowvVwihPkTeAWyEHPICUUupMVLeZvUjZXdDXqbNk",
		@"HcobUrzRrUulNqsCD": @"yLRSCZiRycLbiWLMnLtmCpeAEZvLCLXgbfFdXfPglKsEbpvSfByDhdwIhgZKiSdinbMYxTVSopArikXegnZFiVrlWjFeIVJPcGUVBMLwkvxWiEwE",
		@"SRIgktVqEnXAej": @"GDUAoUzSMQZYweZiSuQUwMuipIhBMDbZFxqWBEWDaaCOnNBRXqocAjQPjDilYlsNXwKbGCgIympVDRCguQGvyfiDzUlYkJQJOpWwukODXlCfDJjOKvbzuGcXSVkPPXlLXiRChwGPtFOkZ",
		@"DNFmJLtIMFAhe": @"uVNUIFdkMUYDVjoakFRhsUPrApQyFcxCiDCUFiYIJLrZuWhWcmuWgtqtfUvIEgSAjlMFSQUyKsvupAOozsWChbFUGtBrmPRrYAfarogOKxCeRyRclxWmyQZ",
		@"sfURqwXjeMDm": @"UeEEmJjpNQBSyVQsRiJiHDmjNQbeGIKKSPcDsYNxPdHEHgQomYdIIWPzjajlUnRszXfJECkMPyBhIgzqXkyOsBiCThbwAgLObwGqHxeXhKVyEqQYotkzAaxmhyQHe",
		@"AgAfxndenaQMwaeZAvT": @"OejGuRzTnWMLOCXvzEBZZBywmZiNRUmibgYpwTGnqRtRJlKLfISXdfxKtDDtpKGZHazwLAEwRCTcMNKdDjdpCCWWxbjZfCdphCgQXxCorQHdLSfr",
		@"UtkQyKqIvpbTZQL": @"RyoRFsOpuwrXasXXflbdYdHjmAylvZAiobFvaefTUUXlqKLXUSoYMmMDKSXAsgdzciclnmVfvglKhEZuQWmRHUQKMhIwHlVEVTvqSqaOJczIDpNF",
		@"hUUSMjXQLLXD": @"zwUawAVZPxAwZrjIrRVzSFGILxFGOxztIPaXzjIoDWfdIjEKlcBshoGCqUKvumzJnlHVutWgkHySShvVcJhlzrNAqzMFOGRutWuWzLxzKvKMdEOktqwGdjXisLdIGMEYYyHcw",
		@"DayOpErEMZafS": @"nXYNwygCUbGyuDeVwibQpiuCxGbcSPOFlhBLCLzqLhCiBuLsEgCiZwURFKfqNuhGTBozjkEfZZlzPggWNMEZKckiCshfIUdOMhHNGYEHhEomQbIqjvmYXwpqEMOaoOiYZiLTdw",
		@"RtUPjxkDtWRipyDr": @"yrsPjjAipjfhbYrFVxFDwoLqDhYDFymIQaiNvGbDYeZDYEAbwehLmsmFthGVlSNXXvKOIOmpruMsyzPyDEkgrHFJiBWeBrAQdzsgvLUOsUCSABZIVQSipIukyrqekkwREV",
		@"QhjDiFnfHcVrjKONQ": @"pmcCVNrJrsCSPiRRIVUynmyqKATjTeSxoBnlnNywhAmXQdNYvdbPZxOIEdfflBTxGdeHNksuBwwPOtleKiAZKVXOxpUgaYSKquVNNDoNMINNilrKftstpmCGjyqtjxhZSOcSIsMBuplisfyyGzfQ",
		@"fzKCyzquCTzrnAp": @"nBmcSFyPTbNdrVgSwwotTIhXplJZDBRGQmlgeAMhgTLZsHpDfvPrWabhyhZxGfzgZTFzbLdaPACRBqoYBFWJwMXxMvLBxeUoyhzD",
		@"VrJFjYnpuuuo": @"KjMKvqDpSQMAFXhNWQiVgHmAjFVJSuFjKymIsZMskoSWkZjYVEDQrpKMXLabzaugldclvVluzMUJwVBwEzGutDdYrjXZlDBmbbFeulVtLRQfnnJMJfswZCeDjHUIdQeKWCiaOHkHlcgNqm",
	};
	return XYOItNgaribzaCo;
}

+ (nonnull NSDictionary *)OhRIQthENdJHqdxY :(nonnull NSArray *)YVzEXJYcNdTf :(nonnull NSDictionary *)gnVqfxEySXFDjE {
	NSDictionary *uIOQajQddDyLRvbiZAr = @{
		@"BraAmaNRYESmNMQL": @"wGtPXlsEqgGCGpoFuUkaegdRHWHFcRxvyhSiNGWtBrhhVFmhPFbNeXnbzoQsuymOHlvpaDfRHVilbuAgUDrJGZmGVtEFufHsCXbnaLPejwUZyWirQnDmZjaTSXOsotbJBKRqstIHCSdcSOmOG",
		@"eMKcQpjHOkE": @"bIeuoznPafFCYEHzMcvPGSKmgiHxVMkvOLGlKcLtzouFXFhhrLaIPOgYrlWbssUcgbapWXRHZVypnwtslHSbeMbrHhIhTewqsTrsmrVtGJZdqKgkfTxyBrexnfoyiZvQLJgmnMlSaKjF",
		@"qgMPzLfcgCkpMlNqmpN": @"ujnjKFUkPtDIcegxzmuipAoOUMTpHKegiDsmnfvOqqqiGJmzwuVupCroXyXyHYuuILOCDduEEMBsBHEkARZVLjEaFCjGVqAUZpsrSuGkeXmF",
		@"IeuNOyXCYGhxgHzyvOj": @"KYPcxoucfIrIsvaLNwjOLFzsBvBrJUWWkvUeGeLvJePjRaKJGYYQFOtocqJzwEMNyEIjnICzTksVRwozLZRmLXfxfQZcZBgtgxmSqhDwBEetYYwMOylmvnApWhrIlHkizhdKWPtgNyzVaxXv",
		@"zpBbvQLutl": @"vHakOHhPIGxvVJrKtTaHVEsxcQnGjpBcLiPWrByqhoQqSPTUpdxYFTCuVjjlMhvVBassaaPYQnzDFyiQILEFeKrSZkXnYWXEudhgpl",
		@"WzsRDblcbcsvsPxiqT": @"qqFkGEZgzwzyIbEkJdaKcktvBuNIvUKoBDbDudSOgDplYQrSCcTVftyNZcACJWVoLWQTfmNIXeQYGvDEIMjtDRUVwLUpKStpZBoHeiqJBZuefJPjOhXzSJIJiOeljIfKPGsxvYmBSqf",
		@"wkLPCmugbpVhtUoVE": @"JzUAddMctuPGVodGFopkJOzVTpyGoxqjRwZARmXMyEcHrLtMCZxUCQQUlpNHRsGgoloxRItjoQqDaJAitSYVJwdGbCdOLngRkblnkUkaZfDxypvlkqLwlxVuuZXtRSZXULwq",
		@"WSWKuiDJoinP": @"tVDywRmJFoBWVjKBPpZELZmYCtjBWDVApEAkTgcbYJGDUJFnzhiYmJJGFamlXiOdbSBAbMduJKLYjRKnltjpYDvVHheDpBnCGEvQgbffWPmdVNEEccxolZtwkQMJU",
		@"KaHffgqRIvCTyaiH": @"wgbeUBnAZJOAzrWdjLuMRQfajPdkaTxCVrAYJnVARhlsksexEQgbVTxuWlspwXmAThRCdglfREVoJIXtXQcnXbRrehMPhNVszjrpJaboCGwTIJXWDMUXPhMOeIL",
		@"HDkXFiKaZt": @"WolknkfDJVaTDIeCyPWuWPSnxAADFKFyxEdrKQlxNIYKXvxbjIFlEVYlHnGvDmkwHEdzeNgIOylGmdnzYToHjknWwRogVgGuoGxxRJkkrmNpDIhHYzKxEmtqEApTFCFHLTqtYX",
		@"zJTVhTDBvzVAIEKGB": @"VaUsGGjsMqGUdjfqemHLuwfwjiBOnJNtkiJyYoHcZQuWyjHauxVVoWDAXqBJtXesrvupWtRxkAEmHLfjoqRWQgBDMyZgBoIUBVUvLcpUdcpFnqckYDbxvbjNFgDdTqOkR",
		@"IFZQwHfedR": @"hydIxjXgDLfTKTKtXGaIccNzWgCyKLGOngLYJhKyIkGkoHbIXaDDcWSZzVgdWZgyTzPqGPrwyQmDlMSIWLJUECHPMHTxqLvqsftIEVGctRAWQGJrwMdOtl",
		@"tWPhBKlWQTYRVZ": @"HwyIZkPzCuvkmSwDjQjqlOUCfClackOXPeLEKtXxqdnZXWJRGWUEhFUYwhWkaULDxBauRzDLbmhHOcWIZHmDkObidFumtWRKOJDzbyVcjcezanASDmUBEmjniPxtDairAxFwX",
	};
	return uIOQajQddDyLRvbiZAr;
}

+ (nonnull UIImage *)saarxoxdznpaXsLHtbA :(nonnull NSData *)sBxFFeyOzyjpttfIG :(nonnull UIImage *)JzRsEdAHeENOZwxl :(nonnull NSString *)IgjoDSrbOMq {
	NSData *udXmrcIuFiqly = [@"vZZwrUHJaTofYfieXJXMCBkgBuYbOZivwMNfgFPLHJRYpIrzABtjfssOEXAlnKyEpTLmjVzGnoOMGzBNvSQWzSyFWnZAbamhRHRLYROquKgzBycFlmAOSTrdqsHXdGwP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *LDygmEJPmd = [UIImage imageWithData:udXmrcIuFiqly];
	LDygmEJPmd = [UIImage imageNamed:@"TYXmyMMePCLKETgesKphSRYRStqvbBVwiVWCZdHviOfmcZWeoEiBUQeACPYbjyxnZiYsYscOhqGweLurzrzERZWYouEByIaoiLBAvoLhTPeYAKeOMWbJEl"];
	return LDygmEJPmd;
}

- (nonnull NSArray *)FsOQomZWpsKhqQU :(nonnull NSDictionary *)BPuFuEguDbJpCAGTsFc {
	NSArray *EXvWIyPwrFw = @[
		@"CprdKAxdendbzPvBwYGKUkAsUOyeurbAHgEkZoIXGABbpGOTuuwRdVfrwfZQWEDlkCxvDzqJcoxLCxLpKtGjuYAiwSOrfIqoJIyGyImmnWdAIBtds",
		@"bLSitpETeyXeCXNSKIDRyBNErQQZeaHfCeyFzVqnqxjbkBhrrGSJJpeqSJTBWGDRfRtNndLeFkDTiTuGbvpwdSyzHqVsMmYLBBEHWEhMnOenxIVRZEEcTPmqcnTIJNbItOUdajbqWgaPDSnruoRS",
		@"smQehrxDvqofQelCxBYKKKExUJJFItwMNXXDRNQbmvsaEFdHQYElvIrtlBvdCbtufwWmBeTMSYARjcKocEgtqereUBCloEYcszNFkZpeRYpkND",
		@"aWDjSmJYuZkwYItvSEMOIFQBjeJIoukCfILcsWkEBUxbOxPfWmuPwORnMqPJwWbKXENEOZgOOrRMsxbebXNAkMEuMybgRvITLWhKUFKqDirwxmMKeLov",
		@"HjRYQjcDSimTzzbMFijHDwZqTLqFEoNeBwgCOlizfxGRjELNPXEnSyHWsPejHihQAvHwziJZBEddlcUddNlfEZjRsTltkmmStYvrlfchJEXcxProwf",
		@"htRVhxYcRmmptWsGmnLRoMtTzwIGAfRkRSibkRkgeazRrIzJVrUjgwbpgAgcsvONrxZExTIkzTtaYsSHmVMfLnYdntJDpNjuPovaDcWFnqT",
		@"vWyvVQgOpzARNMVUKRrRlZGNRMSkMRJTHrkCGbTFXZztEfIkEoaYqdVExDqVYqnNaILFTnENfmBaNQycVrwIFciHBpnIMCAwtokRFZHB",
		@"ycnLPHbXeXxVicTJYbCiOpKFnrkIgjVUAGCYGWhIkFmBKBthsbfXLvFrQLNbdDIfRXerACVtMDtzNetvJaFazxAwmORLCJcLIAxKYPrEJdzDckEkbWb",
		@"TxhHhVbLKbEmXatDSmrkAmJmKipZvCgnWeVLTxIVRfNDFLNBiRbZmptagwkpjuAyJUUQtmPgbnbgnflDtPjkmliDVbBsbQalCUjUoyApjDqjdqKBM",
		@"lRezRbNQaGUgohVFZrtWiRjDDgWCzVgHbydoFBDzYByOybREXsXgrUUGkCyDGgVYkeDvxgDqnPqrnHPxiJAGwaLUnvQnozzebUoxjKIyCehHRNvySxGiwrIdkiAiPIbetFKPJn",
		@"JMyFcLltxCVtOehzgPNmPFNvvstegexIKCnHqRAzDMgAxaLPsHXhAGfAdyeiEmpGSRKimhLVLvcWTaHqAdRCaPuCclbKtVoaCDWDBBVTzcvtfoKuMMRcKPoV",
	];
	return EXvWIyPwrFw;
}

+ (nonnull NSDictionary *)SYNPaOYLdUehl :(nonnull UIImage *)IKdWAbAbXrPk {
	NSDictionary *vUSePGgjXnv = @{
		@"LXrtBKYYrqrOVdp": @"pasUhHInhUKyPSKLriqqbHSYIIegDPPGylLvwQwPXLnGrAEpnvHKCrasWWyLGQhMTxSyhOmVoPWgXMHcBjvVLHASaEWoFufuzAJypWQTdeZg",
		@"CbwKbLaOtZZHbPFFkTu": @"cpjdKjrtfDnfbhgUSarkskjTlcaQqoTwsxPJhSmdHZbCiiblxmXYDkVaPimJZSZXrLqvYNqsQOwafWqLZuDjIhnRXpoouocAXXEXVKQPgp",
		@"sXSDAKfUkNnZEPcSlrb": @"QaXAsdFbUcNkoUTCYruPMoRInxvaRKziDplcbtRUlMsWuHIotflzawjZUHWLEYPolpsfTpsCAgVZEwDVsNCqiAfcPcxUogkBVtMrYSjBZrxynalJEdCwKJWnLbtPekzYYPtevfKgXwUUfuw",
		@"iDZpxsdhgV": @"FsIuNonBKbyEftVLbbwXBQkiTBtIHbSQyGkvSZGezMqJvwZuscucCEXBUgKmUMekYqtIpdSkJGyRcaLRMaIKsFrXILYBssfCGMrdSkzZf",
		@"HcjGtGQmbiE": @"WFYOwnhguliOtOcwbErNnsZidHUCHUjdPEmMbNcBsntbRTdkjTQHxuZSNJjVTqobTOoOrEsLmGkYMrDuGkxhXoVjsdemBCUTFhaRjWDlmmRpTcAvzMoBGCADSTFdcIlEVOrVpWPX",
		@"OFmcWBbVBepYs": @"YVciADoKbfLgowsZNONPFvBwJAhdysuXlmBkLaYPOSFOuLlheNHsLhuYYBrlAZnHfChnbeKHrdhrFJbyDAbQeDRgvElzntALPYLryUwzXNBNMypEVhRk",
		@"YfLOjAaRYSGeR": @"ZeFSGovVFHbQmFAJapOckfrlxtxZWjjnjCGeHTxxvpaZFrSJYyxOWlcYMsDigcFOGPUpHyOkyoUmsecyQqkKiwYTqvVNdemPiuwjVeqxvKlRaMpiXRARvML",
		@"FDJcKrtOOxUeWK": @"bzHMkoTJGfJJGTjoDdfMijlbLlLVmqXgVTKVGQYvlenHipaZqjUNPgcaJDuBoQIErLghfCbhJhXFZnDrfNVKmszMyyAdFmRzYUqIpUfJ",
		@"wXQlbMLdxlfSktOk": @"qgWQXdSgLDWhxgumYnJsZmOBkIHZVkIVMWnKxsKhYEeRUnKSvqiHWwNPEeHbGQkUvyEnjFsHOZbwIrMDFYEqOJfBDfklXevEJWhrhFYErAjJfhKcDnvEMLEINrGZvVSOEYwZWedFC",
		@"TJAtGlMzNeSwoAZSZw": @"YtyowdRovdXEgEvueUcTBDABTEBMeaybxTaXcdycQKtEttYSYEKWvORLNNXYSnvYVjFciPvLZdbCXlEGvnluauLSbKmtKVPkDyZuFPsxnQrsCQrSuLfKinacSTYmWHVSOOivud",
		@"STnNuNnMuHy": @"iHkDPoagGNOZEvZkUhCgCmfibZsZeeyvZXUixOzJfRINVZJrSofEbxXZyWLjxZKEkagKzxdRhmbzMpFBlOrKOACjxTJWcVSlknjJPfOdmphXcXchzyFMkPpSFVsvOYlnX",
		@"bTLNeLwTQyW": @"VqGQViJCstUsiglSYomBVkyhqORpewPWmdmFypUvElbburDGbYAOwpxuvTlpwUbpcZnGiDMTkaBmqQrvSjISSkkpzlpmHnrZujRPyixxydL",
		@"qoYjNUraCAMSFg": @"udDxPQBUOrGvdCipoxiAybTRINbSWnVSbjZmgfvoQYlukAFijsPoexOkDhXbDlekUtwPxHHZFsYZIaiwmwoXcUWcsPNjGOdQERvD",
	};
	return vUSePGgjXnv;
}

- (nonnull NSString *)ZRoNYrPSkNeAWmDcrg :(nonnull NSString *)KrmNNhBaRtvXRk :(nonnull NSDictionary *)mXwERMxFmUdUgclliu :(nonnull NSData *)DxbOGngPRHhi {
	NSString *TvZvpUbhYPWlU = @"JkLNCkDCiXlGDkmGScdjhhHCNfKwlriunEpNGnzzEnjHYZpZLedcDVjzNlnEPiIgwjfErMBqKPljxNYHAloeUvXqrirScAoVtHWXiOFrrrgSjVZOkVlmlcrYBTBCjaZMNL";
	return TvZvpUbhYPWlU;
}

- (nonnull NSData *)UstZABCWbtwLEVH :(nonnull UIImage *)iWKBTJdmUovW {
	NSData *zNUryZFswpz = [@"KxWnCfiRWnSNoeLfrwTSDNyWuYGsNRnDZKkhbtGxYmnYBdBIykExPpFBsbgTeKCdfHTwfbXaIJxYoqVstTUmxJKEpgYAOJOjmGlaJtinXcavnwEwhqrwpnVLdLOJoMluz" dataUsingEncoding:NSUTF8StringEncoding];
	return zNUryZFswpz;
}

+ (nonnull UIImage *)oeOKNVSirhOfM :(nonnull NSData *)xpZEYtJZPJA :(nonnull UIImage *)lkrjnavDpHmQXzJ {
	NSData *YfnmVokLBzV = [@"WmsYFHvbzksohHaItqBhKqYSRVmGDghuGHxxODIRBjTenFRUYvdvFhPhDNqZdgAukhTrVQHmHLfLPRwYCISTwGlTFBFHKwXUTSDBOqjfogCxjdlGuYmdsQOiEubFAhRfhKcmuAHEDHpXOWYQFQf" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MXnAtmPGSuVjaJ = [UIImage imageWithData:YfnmVokLBzV];
	MXnAtmPGSuVjaJ = [UIImage imageNamed:@"PtXbcNONLmdAyfBNbnrDGqDMRfeKffGxDzubVjyUyhSfNoIZZzQQAwjCfJUfruJKDadGSvJYhQDSYZwOxFnRbwxXLlTVXmwYfCCwfXpEYIDeFuRZOVAFEPfcqlvwvUTqddrruGnIggldem"];
	return MXnAtmPGSuVjaJ;
}

- (nonnull NSDictionary *)geYtLYkJMQhnkQBaZ :(nonnull UIImage *)JBYrpiqwzA :(nonnull NSArray *)swmiHvWevtfJmfW {
	NSDictionary *oGpgNnAkMbhVrelYg = @{
		@"gCTsCcLyGpLq": @"tZHjMWdpdzQjgAZJbmNHsQZBvLvMGsnNDdDuoMbsLJgSAphhxILimpXCpDqlnJPVcmKezUWjuAgGfnfcFtCfLhJHTcmvzHmEmFIutKHSVigyqefUVmJzyuBtVgRsU",
		@"HbTViiAaqXYI": @"HoiqiycMlAHvKymYAAvHJmLbXAGYMNGRZFtKZHHlEWvTYkRTPbRVOpqdlELqhJoltolomDFmFUEZmuBfGAhhLmUnCfsACVSIbpwZe",
		@"lmsXLACUeKxWBjhlNy": @"JeSXAUiVlybJMfdHSezOafMwrlOePOncGgGtoRqSAwQssymTZqQWIYXNQGZOzomrKQHBzxpjYhZuwgIvnBTYtAvLBxCoUzJQzhLpUFghGrbnNEROReFBzLMOCPJttFOU",
		@"BZNsaydggXkI": @"oCFyhgUsLjPhlaOYmtZYKWVjEnLfejjdPUpTqsCswXWYJTaweGLZDwXDaDkfDHGYTIXUScHeebHeDgmsNqGPdccEUbbFcOmFgDmOOjSVnPeWhksOeGuPtEOFFJfIdXnseiWPioV",
		@"gUhMSkpqqGpkgNUW": @"OMQSsSzMCuoeoEzgoDrYeXHvkggEBFyRjqmLkTMvKnqEeuKGfoaWZoNocFtisIdjYvsiMMVYZEnTUfsHkyMTEpUswCwbJPENrwCATGkkQHwjSYFBVrbIfoynqcroxCFhRFNyQSj",
		@"TiOtgUZdfRDeFxry": @"BDdlAftDzsDoDuzFncYpBTPZSyXpNISMymlRjHQXULHxBDDPCpkUbeakguOKQLFbyJxBWHmeVBUjMTXDgUBxPReixEZDZFQjUXdipLCOAaskwhOKZHXd",
		@"XtmYzhJuXYlTbtadNeG": @"JfBAyHHwdMsmAhgyHsgAvDPiUYqGzuIXQAJFwiWTffdazfsQWxbHXTuBbxVMxqLyWlSyYqmCtVkQsDTiRojJTgxClHlpJSqfQUJgVVZzLqvoKAEmYdQnFyeteTqhGiIk",
		@"SWepraxHNFnMyzcRP": @"nhASTszFpmlJsxMvvVNxEXKssChVgLPlhwiypPLiXWUXeIyyjBOqJqbdbEXTymuOlLboogiFLqilGZbnFwrBPphfkSkVnlvlzsRDmnIZhgOEAcYsTNLDFGzZccoFf",
		@"FoGWdYEzPzRcfeeKIf": @"fcbsjpEUJJHIwGPxUEBOjUrbLydXcIVjbrLhFDYUYsVjttvJEZjcVjlWCVFhAjQAnBJLKZQqFArzhxLiIRzyUvPqaTRkbDEdOGXntOxwiovTETZetqmXutTgRHkvLseChBpkexXsKEPs",
		@"SGQgszWtxfDagLcTT": @"rqtfGDGdGSzcfzjsSVlOkmXGgjMjXsUjqBOVwhkBVXPWWXlfhMVXJshNakVgTFyGsXSDcxrEUThDCrVHmBsnFHSiLvwzAjlFnESTDBHpGkE",
		@"xPkDQDkKwDKcWgbdE": @"qikwpJhMPEfbwBGOLXiYlftpVCpmlFHPHuNRaNSpyTSYwPLwopmwSFuXTsDzScFuCKtkZFssAQhXviQzbqblqihGipFIEXLvsIbCTmxVQKPhhTDPnakYqEwsUXDMaVttliPGpyUCXhavmeRKCqEUx",
		@"AzNxyEzcGFkz": @"pWhwrzWZXncTiEtpayrijZsSJPQhNmSMJtLLtHhFQuPtSKuhNwIwnXduavPeiPiXGxeyeFkZyOLlxHOTyKCemyTkkeozqoqSCSkXccuSsLagrahWVXKOXcVFBkLZoTr",
		@"jSYrRMZhNedD": @"fTzoMdUXbZtycAJxWvRaajeUIkvmnvDhDOmaoyRaIUPkSUNCGvErhOLvcSRzcDtZvzsaztXQUDiDfhPDwCtRtQdJFFZtuEONqQcPReglCbFMktftNBTvXyrcWTXzibSbnamau",
		@"pFvzAHotQWUzqbKR": @"GocZPuKKHegSVxtrUHTQlYMhRyRFAYYhtdGfjHJscwibFdbJnLtVoRnndAlcgsFgBiTMldSmPckVcSLLtEusbYoXuRjquMXdUidmyYQmwzEKRwVKTKqOJHLMN",
		@"HHAaSteEjQzDpCs": @"PqVXNGIoeAergZIckRZeWkbTPtdSOgxoRBjqwhVOYrTGJLdovCpiFubxmBuhNNPzPBqiRdNLhJLqQTgrnnfFoJEQkTVPTMboCLhlJXUWakGnFYsIHzEPfgQ",
		@"gAYbXdLPvZnAVoqZmn": @"eiXkQHSuvmhhoQCBQqGZSQuurwBoAQEWVbDcMYdQdRwNNrxZxCVzFiKsaADNmHuRFNCBaAUBjpEXSITusndqsphfibnbRDUIyIGBRZkzJnzNcDzdcaOisHKUw",
	};
	return oGpgNnAkMbhVrelYg;
}

+ (nonnull UIImage *)QbPcHAzhLdGKKtonO :(nonnull NSData *)vDAridaAjH :(nonnull NSData *)OTuNwMxHixj :(nonnull NSData *)lHPmUMGoCBcUBDDSx {
	NSData *upLkGQMFnCI = [@"cIBYUWIYNUZvwXLGAjIsJTnPdDzwHFmdlffsxYzBDINjJwBPglwIyIFCVkNgTUOtIthwwawymEOIHYtbihBBbWzqeTeilVmrlSrwliyvBgJM" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qTgKlQAZyZetvNTNm = [UIImage imageWithData:upLkGQMFnCI];
	qTgKlQAZyZetvNTNm = [UIImage imageNamed:@"vfMjktCxFSRlKLwJnuPbtbKEFwUWsvvQmMLCLrvOBXufQdREaIyXoJOlNBRoCijNNWHlMpNIacJOLWVDPPzbRJRVUraftWsBZekgYEykBQdLrbiftLqPtumsOQffskyzbGTitoZlAPKAjoffehI"];
	return qTgKlQAZyZetvNTNm;
}

- (nonnull UIImage *)XJYzCfuhXSoZTdM :(nonnull NSArray *)hdnsJseurK :(nonnull NSArray *)LuDPGqyFQhL :(nonnull NSDictionary *)XdTHPsAKxPDvM {
	NSData *jqzvaErYeyXNZErUz = [@"GMfiLrAPNELltiehggNpXpRlXbbavPAdUhiEzUoUOmzCFyxjHFfmulMcwREELkIqWtKmbTdnnCgowfxoOKDXMEPjZzElAMzfGxGxbOZEEbWyrqCEHlDlmpJuGEXmHcNZmllbDbqIdhTlNbSI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *npJqkCTNpmftMB = [UIImage imageWithData:jqzvaErYeyXNZErUz];
	npJqkCTNpmftMB = [UIImage imageNamed:@"YdEyzoOZIXpFjYivRZIOuAcdXEUFIfAhFepJWseggLZvNQvDFQPrJQnKYejaAkXeFhdJPptzfcsiKigaMysTrMOQjSIJIycqxlCKLCBMKmiXtv"];
	return npJqkCTNpmftMB;
}

+ (nonnull NSData *)nlCqkZWjMkTTxSSE :(nonnull NSArray *)GQokYomgTCvmDXTw :(nonnull NSDictionary *)cGuiXBNXHkh {
	NSData *GdjxmIsVgvPgvUbVR = [@"OQlNWhqOHISYGIylyggifEvxrMeWtRmjQBrrkuzTrAWcCJZxDPivUEjHSksUfqdOmThnOpkjSPRgBvmHMTDLsFjmrebUOvawsRnExbKVeghoIBwDlATyuYuWFAOXMMUNwN" dataUsingEncoding:NSUTF8StringEncoding];
	return GdjxmIsVgvPgvUbVR;
}

- (nonnull NSDictionary *)RoVOKUYIxoxKAtTf :(nonnull NSString *)mNnhuWUitoxtfw {
	NSDictionary *uUxRcEJdquzzCyyg = @{
		@"AorrONBWnYPczBw": @"hYfVFCakxZJogNlqnRmtuRTffxPAJdIpcFHdxHydrstOvjswEvBMiXHlezZvwxOEoYfLMSqnjVxCisEeeFHmzKdvMcUNPWEEPtWHQNkoYF",
		@"ENxGBQOAKAqnxO": @"aIYuluJOYjNYMoLqwjkhQQjRKKPwsePeVbGFilHljUtWPuAbpvvCHUbqZLFReZQQmhDoneApRsGBZcAwIOJULCSZQwWdhGDsorYEkOCSuDJOSuNFbugkjyCYKvar",
		@"aKpvOFjPVqalRVxnz": @"ZDGiqUHtjarzTApjbbCczUebViWjlJSclAsUTAlooXWovWzRDXPsmVTYxHjVeSuSNjndPPCHclfjbMthNmmygVOUjGdwZadrbNQxYkuCBwujcZqIdwqLrEvLwPIBmYtVY",
		@"vmxvZuesIhmSFd": @"piqGMYMhtHayXBejPiclCYdKslZrsGeNMXLafVSWqprwxNOnUuiJkRWylltqOiclkaDpuYpAmzPcoZblcpsrpxdEisYlVzwiszRazWQkdnIJoEvZcjcikBFBfbWtSkNF",
		@"iTdYhwnGHTZAVc": @"ajTqzGGRJFkkGPzQhuXULqkZrxOdBqhOETFFClzuJFDtHFdrfOJxHKWMivhhhkSBVyfPFGVmMviulGFhqdbzoItRrbCqLctPeHITYpqZcJtZAnDxjXOnPmPNIPJDhstapsyjEvl",
		@"dgGLfHcWEnfHhyBZ": @"ujozGzyjRHmDANtLUIxYClyOtBMmAqHgXuxfuirJPLSZIHIcvldnyjNVzzonvsCWNhAfmErXaFvQDtMZchiTUcKgIwTHWqEhyDDTtLSrfPXhi",
		@"okALRYRLvcAVu": @"dxHSiVRVZjToWuhsZnJrBQxcLLSgyygdcflzyHHqVHIaLcuEpIFCrODyPpakkGmQRnmfKlbUKaQGpEuQLsODkKSrtNgDadWsCeMTHWafwzJJudyFqYEaCDYoeGdignKsxRTOhidzQkbbbqwTrXuC",
		@"dYlvLkCXrfRKIXFqTTh": @"eQkrRNeRbpZBZxNfdGLezrWBecnejnRVIMFLTyNKapONhYMoIngOAtlnpSsbFxFkIPOyxcMOnKSpZSImvtxbRSdfUwMCjuYnswOabYesdBmRHmdPijQboZaIyPXIfWqhuvlKVdeCRRjPqJbbyOIY",
		@"nIIKsLNpFP": @"yqhNUCUETgUjeNjbSfdynFaPDJAEPNNtNaHsJPTDPCIcwCdBZMpKaZQujNqiemVgFQNohxihSTJalweWrgaSBkEWrYDeLcboVVAMXvPbzfhY",
		@"pevOBYFtdKkvCm": @"WgCLSWGmSDBhePGbQKiohSqzQXeekqldYKjtKXfMiCwrqdJSRFCCpMSVDhfwvAfiupoJiaGNhiOKmVwHUwIKixQpkkejaRBJfaYbamcNWIFzWLhNVnPLmKxMhnaDk",
		@"OImLOdRxMcSfcQQhb": @"PjJmSvDHOHdakZKuudhFdXXdfrIatbbwLilvoSwQjGHdnKrDlEVGthwRsuuMPIoMRHUsgrxXsRppvlyYmfWMmGDJxtQFzZDncMtyHZxbFYYNkCkyMgocMUBDHkidP",
		@"CuuRktpKxyn": @"syFOHxPXfBFxiPgunntYszmisdqKuMQnaSswVdxQdOrvRsQJdYuoIwgeHUVtiQSkBSLSoqQXYVRqoAkvSiJnXSSYxNQHibEAtscrfsQteMkRoqOJtEaCOLWYhcFC",
		@"mXiFENvyvdpRfGZH": @"AUTrAsliRWKnGtDpZTPJgkuJecyHNHhzwLUaTYMFfddxiniNvjTQwZOmHMPuANAdWepugxAHuaDDYQgZLKvEXKAUwxDPHpsFwiOOOIVFlvrax",
		@"qMaMgCGsWEtiiLgKCY": @"xgFASXdaToAfceLNFnnkByVpJafFEymcwdkwIVBmPgiAgCQMZMKyziwYDGkbtVguOcyRaWcdWcKgzeiZKgnVAnmsEhSqrCnXJuUBdwsGSIASdGVxJuOdzcPBPVYcwcJIdSbKz",
		@"hXLDNeoQirgKmcq": @"HNsktbihxbNAMNVyKKjkEkSNWhlylFiPxNyVARNsgJWcYrArVLjVsQofKtKVSAiDAmawUXUpPsSVvUBvVFZPWUgdsXxyFOWcSdWFrOTjMlIxTZnJCmGZAeHVzMFswfdeAM",
	};
	return uUxRcEJdquzzCyyg;
}

- (nonnull NSDictionary *)zVubWDwHTSmzl :(nonnull NSData *)eWbUCLXjLgMnHawW {
	NSDictionary *uBFjszFlIMBxOjf = @{
		@"BccUjZxouAttz": @"jUuEqNNBexRhRcjqyjxavZCPRovdPaPCNaUhdvDcphXnOSEezNMxASAUheCBkBukSprmXRmKjGFlcDgEbYuznPyEpVPjOzOPAPzJPYgBLjq",
		@"aOQaKoZChRO": @"VvZwfvSEtIqVTZQoyspoMmTnypJkbAXbJJifklKgCUrZUbVcOtpRuPjWMlrkwzenHCPwawPEOfOGknBYgOMHTkDEjxQsVsNywSokdpzJOHKqtBRLJOA",
		@"ZFSCrEXaonK": @"sAUwACgxGsvcmecLsnpnmxhTaxIIzWQDfrgvrrSeiDOUJsnOFzDFJuQPlVxsNQCPXkBtsbxjxBIWwTbenJZQdTGauxWXHYhQbXsJBjQrhIFIhKhsJksvYmCqgMjghLqWd",
		@"ZEoXXnSIdLYWHeUPFZX": @"CIOogqjrXMWxBOleURfDMHBUjlFqgdGVwhjYarYfMVcvnnmUntnoPbtYtMyyqZSmbADnjVYADHFFczBEEQIANIKAchIzvxWeZcJZFrGXcFE",
		@"HXDzrexpSrbaUKzW": @"nPEjmWemezSsYqNlGzLkCCEbknvDQYxTPqWHPDuLcnYGLoUaVBSZYvLsxclXmgMnvhukQWInEPUicRObdOqsbpHAcqFlhKuqmqCahn",
		@"SmxqJSQwsHkWvMLF": @"QeAtlbsqUuUEdfhRuJAyZHQoDcwApNwNXBmAyFovxxgTaHyXZbxsFLYnmqZpQRlcdxYwhrhXMvbXsdjGfZFMGwGRPaBMlEaSZFDCZv",
		@"mtvimJiVVPppbJPcL": @"cGThHNktnrbEMnBgEGjDOLlCujVzrybTZHhhScVYPlfbPZyeHGBfQRgyGlipSckDqfKAlNLOrFINmYIrKohvHClbUvXdXxvEDgNAUgJCjonIwQjXmcyOLBLdofMKURMAAkjkohAOLrLJPVfISIq",
		@"zwGMXiTMkJVo": @"xGzMbaTvAVPxhMDNjBzvwxpCorTgJuPEbQyRvGwgSCxbyfKHISYHZvqPVVqAFLjlqgpJhHUpSGnTWpvOktvtgvvAXTtXVaMxEHhoOfBtapeBMUoDSpUDZFfQrGjYGaFWMDJTgZosBKtbWMPAycaWM",
		@"mcXiIPtUGScIDxunvU": @"XYAkbAXVJZBDwlDwomkfsJxNHNBuNNDCBNhOQdCBBpXDZmJHAoirkBBpzcYnEkxPLzOhYAQVHzgZYFgPIunsyxFnykbVAwLsBUIpZVWpysdbpGwYrDnMRxE",
		@"ETcqjMpGzyPIBwgfhSd": @"IvnJsgOXbmjgvRFucyeaaiZsoqDOELtMuHbBXDrAMCbIkSMSbKZGwkbIEpiuhcWMSpMdcWkehRHAJEfNuNxlpHgDkbiTcCHCFZthrmPVQGmTsNAQPaFbspzvSkwMmzzoU",
	};
	return uBFjszFlIMBxOjf;
}

- (nonnull NSArray *)xSvsKGamDUbEpO :(nonnull NSData *)IAfVeECMOLb :(nonnull NSString *)PbSGsMpDSSEKI {
	NSArray *wMcskuybNSVOD = @[
		@"DMvPufhAPPBfDtTOMlGYVUOiXnejDPMEEqwEIWMXEwOvmQbwALwveBFGpZFckvydOTlEUVjdZzWyiEnmODzIHRhvhfOMCvfEksXDjefFQyWszjIw",
		@"SKurBenKKsKaTCQkumCmxgSJFoHjEpmdunHPDwQIqgDPmCiInimcYFFBCnuUHXWaMXlKSmBBAMeAonnCyOzRHSynibQoWBrXpMCxiyIEOfZIWRoRsvOTiAtUrpGJZioQZbT",
		@"vLKHHATjZdcQCWxcQKrsLwdjDBQROKhfPnhlTYkbthMCzfmVxUXghFGvbJnEcnovwhLREDSVplYQbgZQmGLhhfohkbWZsQfssTkZGugsCjeAFNvWcciTqmNqJiitwTlRN",
		@"QBQAoeXbScgccWUEMNCypHpNFHPbrNoAXPGyZDOBYLzYSgLtNACZaqShdDsIycrQrohwHNTomQdHTqPewxkJgudvNCJHGTIEhRMPsPmfhFvQOUTBOdQroxzxiQFadi",
		@"ZcTtUhZuuWYRyOEaytVYeZXUwJnNYVizvTmMntSeTWlsnsJDxKQMvdjsugxWKzWtgPfEOJERCdjgPbwjfwOiGkGujDUXPdEeKobhTQoQqGUFojaAnpHDokxUBoMDTnZCbMaupzdbwWaazFRdbjBj",
		@"luDpIsZtAaRTktlilMqmGMFgCbIbbRIlEOxFbdAlFsqiJTicBtkammBdDnTyuQvhkaswCxpjXaDIJfIWuSmZwOVGpjCNfogvPCnDTERcQjwOAyCsgNrvlQTTAeEOnZi",
		@"hSywEspBkxWqstKgJYyFPZRvtYqDCBCFZbTeHmDchQWSwjjEbvpjflwWxEbxBgLufuIRhlBWHopTpKOUUtOtqDDnrDZXgwoGJXwRBSueLiscudMxSPglTZxLhRLYteQnk",
		@"XSnzjhPAMnacOvBQZvtRZCgvqumBdHUsBfUNdgWhskEKwUKfKlvFeOAMKwRdEFVlXgmgBAeCmwFHsLbnfKQiaWklQoMBAXZfNmahKyLvfKHMBp",
		@"vNITviDmSNlvlwYhHmIxWtmylcuQEZABcxQBHcfHMBmqnFqrPJOiglnIayHOxZvQZtsvaOfnqgnlKmzraFLJHAyzdTDeaesjnFKJIHGDYLbyXpHuFLyUsCdWYxXhMhPcNyxaPaDUloTdhnAykTaY",
		@"fccuqbNAIPWgEItjNqhvtEjjRYUaOPJsClRBLsRCjyjDVPtLhCmhjzngIRSvdilvXrcdCZhNrEbVyLnEkEurLbCvznvCGhMneWgkUrQGSgOhqJiQGHroVzPzWvYLwutsvNuQYJgbCyZ",
		@"zOrQglABnFYsbDBPnlLSoOrHJGNIyCqdCHebjQlFHziKeRpxnEGbKbsFVdkfmjVqKexHKltGCEpbDMQDvPoQZjzlGymSUMAujUdF",
		@"dJWFOnWzIyxYsnIZsCkzVHtuHFsszzJaOQcwMxaheUDeepTHHIJEHyApuThkhhlWAIFSwvTPdskHSZCFDXTenejEeDVuYMmKQYNXwYXJRvXMsfUXwYDXMOtuPAQWAlbUrBwmfCVpmOsAH",
		@"YZmrWZlXePWJJEvabWjdRpEIYMdohumhSTyqXgLLzpfkRkxvfBUMrczjYVHCEzjKAXsxzCTqZHjSycOsRHARkKjVXNzTQTWLxYOAIMXnOGiOVQnQuzxyykTq",
		@"RfxVaVRpQPpXwdWCUVgThsywxikJbdMwOKgUqpaVRjTfjRklsLHplShWXhMwCVXAqQitREVnxuqsJnpyrjEVNBFTwtcDUFNnzxnucCcLalmSwwrSkiTopwzi",
		@"GojGPNyAPYXrGOORoFMeruvQVDegQFlWCyyLJCTXHgPUWabIfsBVpXsbqnFlYVDZgXNeDOXklnAaJTbuUStNJPfLnEEwXxvBVBagTuIdRPJlrUhDShEiPjzhrKyfoNysmFqkEIFbdNRfjqCUv",
		@"aopNHKKxOkhgDZnsePcoVeAUnACcQVBGFFlulbBILbsPCqyNqiYjCQYEFtIfJZNnSHVTkPnxFAWaRFTroDoOilcurgZZiGaZpCBqGrVXVybJCDBbcSMvWbnm",
		@"xMfwZAybTdnVxeiiiLepkxLfgGhinjpdFbtsniGczNFCwlhsxOKWvhHwrEmriKJHuAzcdUwdVnhrjJkjMygZqvoPMIiFToTbtJlWngDEMrzWONwfaQCGJDqQwIIPlkNKhBgxDCYQfAZ",
		@"RAeKWwrLoNgYKwZcJXRznEcyIGPvtmvlrQtInlzzjNAtcWKRvcxIkfLsBsjkaleywhRadMFhPaCmegndcOlLUZYozuVuWdcRNZeeg",
		@"QnnuzMgYJDUkUOunepeCbRAjzTvJmsxIlFroBXNWYSGgpHGKhgsfEMkHqUmPqdyaYAwNSiMcbEaNzhccpdKoIewuFTLNBHTrWPOhcUWCsWzYQZWsuaSneFCLeVZBHmCxGRDiEbERYZSYjxfWII",
	];
	return wMcskuybNSVOD;
}

+ (nonnull NSDictionary *)CWBYwgIdtNI :(nonnull NSArray *)bWoOeDkfvk :(nonnull NSDictionary *)hdmqGdZDSkGbA :(nonnull NSDictionary *)xlrqwLOzthfkJvb {
	NSDictionary *xDTxZWKnjWypT = @{
		@"ktlhBFYDpxdr": @"YfojklSjfHPAexmkCjWNUjbHcIZICoDJKNRQAEjUwFrmbrlWoecShHTeZvoLedRrsQLeBwbPnHnNgLmvLyelwnKJHZjXqFxdxFupOEO",
		@"GApwGmowFsE": @"JuXhKfgBMNYqgyPlYjKCjlnFjZYZMaNIyNUBRTjiNYpQYwGDwLGuRjfCYTrWZawuctykslGikpMuvOdTrrhtPPEkaxWpzDQvwTomPuDnSwormfrGSmfJXCEYgwTjYGMFUJORhlQFqbMO",
		@"ZPISIICXKWBukwn": @"FnccYbIDYAEQCyULhYEZqlwnfslqQYHfWNjtTavqXWkQHLURSjWkrjexaZAHydUoLJyzXUfTUihDDtcHqhsJeCvAaCepIGQVJfTfVigUZrwMyaqDaFSHwpQYBhuETOdfY",
		@"YoTGjSwskOlqFD": @"bfJCIRxqNWNdeJmaZrAcNHYTdaZMpLzEDwumuvROVsXSQyRDRYAMjezQjvkcXYmaFSZmbEjUGmRHLNMIPYdQWQVzXqIAbIXnUmchfQySEhXzukyOJdjPVBKKWZOuBsdaMKl",
		@"ThbKVjHmktY": @"AyrzuUjiCdUkXtQXFETTQyyXRlnUlzopkOWUzMcoGyCuSNuKnSkDpyBrImsWzmmmwirAJOlpufsGIczZgqNNgeDIONTZsrkPOVIHndwpRGZ",
		@"NOfVKVNanDCDTPhvfb": @"lxUIYidIcHISkLQkVLhCyYaJMpnOftpRwIiEIPAAWVhXdTimCGTgkhQxqUdjNGzJkGplLPyvOMSlnpZkrjuArNFVHjNvNcsnyrpynpgjozWDxqYifIkBCnSzl",
		@"xNrwwlfhZC": @"ljuCdIGoIxjFGxYQDxstUHnDUYpzHbcXtjVKOCUSpSsrzqOQOGYaeVSxVNobmUGvbIHwDOAcQGFjScUGAiTnGYRzcFxQAVBvrQKjhgNOuuOmimbQqUGCWvLPCaiiQiSqEHr",
		@"EwggjkkTlmnUZNaJA": @"OzqDQTzAsilHvIbDlDjjKGZDwJcseAFrkPKMneyxrTUpUpwUUAKFdtCXCmIpzMGkKSXJDcnaEKloNgkLPwXModRLzxhyLFIbwuqGTLqCjndWaygb",
		@"sKhzwXRulkoib": @"zkpoNroqyATMaBxoYVIdqhtnnzRYizItxqnXZVtaVZMdSypfiZelgOAtBypIsEUaVklDzUEFDGcvKSvIbeAdcBaHVcJBHWvHnVQudZxVBhvUJ",
		@"RiLOpAvvbxoOWUc": @"LLKAkBIjLZJZbLwZxLnbhSLjoGMsAhOCBgImuEbehoNGUrnHjTBYxIyoGUvpyeLYypWpebLYCLgdkIdGUHPZMOsOMIqEZkTYIAnxuZPTiDYQP",
		@"CnxsRLCrGTa": @"BsgRahShaQjoACWcpZTFiJLoowMGNwjwhslfMtDoQxDBakAVgBSLOiNalUmgjtaBjQUbyTvzmXlPZsGCWiECsNOhjgoAqbGCNmxTHKhFGKghGXOJMcXbNUguzMD",
	};
	return xDTxZWKnjWypT;
}

- (nonnull NSArray *)BUOOTDofFIgkls :(nonnull NSArray *)GdtfnHNSGnddVtvO {
	NSArray *EbGLcGWRmJO = @[
		@"uLQAwVtQUUHJblgLMxsYoHyUZXfGeaierRvresROGxvGNUiuetROyucqHmJIWNpEQtCKbOkEkzgTcdltJEuRHuQqYedsnzlVfkZRThfwtLzBpeyptRyIcVecBKAWIKkUMFlqpHChrVJPQk",
		@"hsDUBzWbyEOvJMiiskpLvUAJXBxFnIDJWlWjHxAKxJcbWRAoiOJoqbwbVnwVPINbpBvILDKXcQwHbBrWvqYtAzfkZIkFAczgpEexVbRBYkqPQGJNxNYqbcKlGjZBmBTPiqYEEusWAj",
		@"EsldKJTEjAoMnxRwWwpanTfjtreyYGdOcJQljdXgLNexRddWQlpFavOQawerOnIdGwirtIwYnirwZxvVsjihtwwEDjKKYxbgkMFWbpxTmweUOVHvxccxGYmDZBAt",
		@"HBSoRdncsNWSrypMPHkuVEPCaWIAOyHrySKuwGVEQtWaLRrXWDjjQFlZCDFNxZxzBqsAmOLqXZGKjqKaepLAQRwgcjBmMFgyddqaWBmuDVMPzqXIAeMSfABPOwjhqJFBudGafudFyRiwxYaGpOR",
		@"RycTZpNfndbfVqcsxVyaRWTRPwfVWNjCBmkzVruPCETHgHUXhsxbTMMffHdLynfKoUhlstAydaPVSbyiDQDGkVwBGesOCWqUwdiTPqhMkBpmexbwSiIjPZfPgbxvnTkSKYmcwphdViw",
		@"RLYKptNXfXiywoPJXTjsHETTEAsKieNjbbtehpOeRfbHjkVzCeCNLKhSTRBScWjEycUEAvcGMSwGNLFTbWTirCFaeWNUIvQrNyfiSwiWApRkvQQpxNNttem",
		@"tVmbxqGbKQSPQmmRXWVkywdAGUPriEhDyxnWpaJEUoaikLilGquOeFcyzbtKxucgMIFSbxcQHDoQDOazhWWAlPPdaAgOSkGtdvlTFJpqqZtGkuExlndOQjWurV",
		@"NRonNEkAvLZsrhrcjSzMSEODESQXBrYArzSsSrieyNwfDMvxarboPDeHmRCJrbgEIWaBjROPwvHcheTNhsMyexzRGsjpNcxBMrsAwGQyVBmlnuDHXshGsBcXfFxgHiNwISBmlGRWbKXPCJu",
		@"HiUnFvBaYPgTmMCTyRSxiNpStpwEOyEVbXFGCRAegjqqpqNgXIOGSDkekOMvUkXAgMIRtNDvrvaGOZOwBhezWzsNDycccSpGrozzKxvHYHgFalGhbOn",
		@"WVmwrVNuVqykEZzKhQmTaKHhfbXLdDkrfWCwCYNjuaSCrgSStKKITUOgXAYUHUSwbkVFIhjXJWpQmUGLksbjdApbRDfZKOUXBVxdklGDJoLAFPtqdpeLpjPmTNSNRqzwdPgNCfueBL",
		@"TJdOCFyummqlwJvsFBZGBlizKayZYsjcKVIoTSLURDjQDsUjRQnprmOGkXLgPVXxoRflgoKvOPydxIFTpyrYyiDcSJliqPmwtjgePjrknjiiyoHcwEAIkHTftIJcnZhtDjIBkEAVHdKy",
		@"vsGmoSGRrWJmHOzCRMaRhyqRlNCoMjHPZusfdqnCZOyDUBVaOAjtIyMneoXUHTyLboXDFFhIfZIrWnyQEkFhzeIIJutjpCQlhqgqxinjukYOGKQnduxMgChlMW",
		@"WJRLBoAVNocLFsVkOSNsqIGCxsCRFIXjLBGpsEYJHWmZYwbxRKlaLPjEXXMnsfvrnIHICoazWjVIxxpIfiiLYnMxxnSBLNuZbBND",
		@"lCSlftPYjjLEmRSwUOxkJFIynHKfWMFjLpifmzBIsTVKFMmqwcCthwZycJhGEloPUdSxyUZtFfuHkgdgfrvppiSqkJssYTZKCRNDgaxraqIvOkuKcJdCXA",
		@"vifbdVHqoHUdIMvVtVpHDpzdIjeAHyBNqAMOfKWthDLnhGCKgVPZlzoaaCbqIDZIFWcmjXeLAWcTUNZBdZYYSqfoCqzKotLZGZvZvlLmifoMHBhPgqLfhAky",
		@"BqCZeggaNKUjGVsendtUVdIlIczAFcUqodbmwwFEgpvamlUnZnCpKzsbcPOKNnmUGBgHRlPSyNoVXzPnbhbIyOicIrHHoOHvzutWGkskEc",
	];
	return EbGLcGWRmJO;
}

- (nonnull NSArray *)QRxNHAoblJdbUxiWzh :(nonnull NSArray *)YndETxxynIYpbSj {
	NSArray *SulUgqjDkXTdgvLt = @[
		@"CrkOVpDvcOFfjJkBdtcxXCTLmgEklcUHGRXLwxhsoaiPdwiqMyxTeRshYrVsmhJXnsrVyKbxsCDKdJLfmdRkVlPezxJILGBPACRjptbCFPmnzMtlFRMMrjwKBjPOHaGPbmayMBkZ",
		@"FZZMaySWKSVwjHRXHaqIQFrWdtrFwODIRFXnrEeQgpjWYYKzthwbkLfYyBhSwcoHLXLUJrbwjyAGSIdDCBqDxpSVVcklnFTnnqHuUNjvMlXzRYEX",
		@"HJmHQfFndGCdrsexGrTVADUGFmOHnvPwrOMxhqyvTEYloWnlUggAIgzKXQUWDYFFqWAslUmrOowhmCeLbbvgUoqzzdUPDUlxnwaLWIkNbGMuWnjwtzsIpngXky",
		@"XMcDjXKrYiWdOVptnHfOkawLhtTvxSONgoBukoHNkUjNjYZkVABBhnFKjivNEmhWXsMpykcmHyVszyYpDoqLMTYscSENeVJqShJRAmpmQxDyndfibZeaQwAQTBVRicTpKKDTqcWssNqpbAnDIAdY",
		@"CKpeyBjLyjzqlqTTFesqBceKeTmPpBSmKvOXoPvbrSwIkfuypcKVeEMcntTyhmHSKSlodBpKLIHEaDCKuNHqaeLlwXEsyrzJzSNnnvhnqJhLvEiOwmAtJAyQceZaeAHeJDWhBYvwbaeVQkXEE",
		@"noQUhMYXBZkDedffCUhXrtcNWkVgGmTmOYJDmKAwZSVpqTqdjsocMkgIVfiUVQhhubcpKKaUCKBJBxxQLfsVCkoOUcDAWwMGJsVBzBjCZNLhQtaSKBxdqIkaf",
		@"kmGMfzdwArLkAIHPNCkUAFRvWDXEPvOUXkgaPwOkLrarhLBzCxXaXeMXznUklrPCwnsRjLLfaXVlVpDgQIvKbMXonBZWEfmEiIsCejKRSpjcfCIoWSoAUdHdZXcTYelcixsakBMlCQ",
		@"vVmFDAeXuQJElBRPsVkCGPIqxgJTlSTUMAkXjMcuReILxDpXUTZQiAuzhApHMrmLEvbqcwvGhdnAXbgOVWunOgiKpjShpXgTBWmeYlHOiLeYcWTJejEQkTRDSiarfSrJrUYAEL",
		@"qtiJSsYYjwBWGivdiFLXqUtJJfwqdMdScuGijwDperHPkondoGSrTSgsgHlHopEZaCCtsjerLOWPtcwopRNkAvtOvIMqHoFzbLdFSjMXSFqURqWCGMTqYlKTvnbffUzwceKCTyiMgpbnrbmRlnFJU",
		@"zSaoAxOKxfLHuHahQhWDcICNtSfUrxlxMrJYvndyujbluyxQsSfWWVqyUDusrnxzXcVPPHKkVvgZLimSySplQtdWEuGfopobWUNluGoCWLPZoNZMIgGcFbMSkKAYDgpTSUZXRuvJleQOj",
		@"pujxACOBDEuzSRsSkVMmGQUgfHAGeXYrmTCiUHAFpihMmvehFmIzRXpplZEFXOLmoEcqYqCsdjctqRggOYfaTFxBWFBJGpguNGLBPcrcRNlCsyBjJYlmNqDutPKngCHxCGyFsPB",
		@"ZEcTiLuWAPoGgSddWUVlXMmTttFhYpXrKSBsEdPoWhILqjFOYVhaOJszzARskFGqBsDOBLWGoKGVwOcOvQDbAmaUgHGWNlYJpjTOYoHmpcycluwEriIoFdIesHvXwii",
		@"asxMHanCroflBLeJOIVJwlMZRUnYZZLKZwrFUAQEWqJyiLwPZzzyuDGuLcIgMnHdOvWoiTQySOaQZHqYbcdspCFhlFVHaJGNpkZCbJDaSqjGenmdzorApeibOwQXXgNmkKNAXSYUuNcbqsB",
		@"hlRaeYjUukMzwNTXDElSgGOUfRJJAtDhaFKwzRCyvUAcRYggInRbHsGLJqvEPLaQFyEMHWrhndMaLYKpvkVUwBceSCEDcGZOQuizb",
		@"UYvQvWYfuNKFWkfYItPXHmWOIEaHRCFQMvlysEeyDMOiVFIqNprmnetfJGTDDgxqZXLwhVVOhQePSwamjwkgHgRBLysRmGpXKbbRqMrTFurOdCKpKlpHfsQPeMZKZVWIoknTGJR",
		@"AupCUvFhzWNmeMFyztSXwuUMizIMSgYPOnblwzetBcDvoytdWfOeTJhIfOvhvJdaOISrCEmqxBAKELPqQIPtOsoTXmvuLpEDllOOfzLlGnMSndLbFiuAaowXFztFSHnYwWzBGcw",
	];
	return SulUgqjDkXTdgvLt;
}

+ (nonnull NSArray *)WFpasbktoQRvBCPdRn :(nonnull NSDictionary *)tAuFJGypklbboZwA {
	NSArray *jnvgMSLywmdOKfOwvN = @[
		@"eXqzUmJrdCaYLBiuioRinSFhhJGWwLOCMnBxghQHUEKVbljSGglcoqBpVmbZFukusBKYHjIajTKpDgJYfwwSnSpDxkschfGwbrygKXziTuQcDDhFkEapDBSNpGICfZVqFMIuJzMDhtlvwUE",
		@"vdEGzzewLbTPEvfMCFTMKzNzmvgiadCSfzEUgtXAUQmgZIyvDzAPdxQsUEnzPbVmZGbayWbLYenhylKPXvoNmWgNMQiTlCIhgXrTWKiePDmFpYQkwaQozMgUXVLaVrxzYMvoHsdA",
		@"NPaxzqPmngYXrMYYfZgSOMminDuLvaeaMUAGhbQVUNzyCfcZApwyAQbCHJlffPrMhMiXviXiEqyqRdwLgnwVYiBWuKXzttlzPLXECzjkhQffEGuGdxbww",
		@"hGQyNRDRjQivYAaefaPfufDlXjmIceIVsFmQKzvePzoiodSYrXAUPnqMFrcKmbkTiZwdorYGJlcUWflUYxLjwOCIfXmMxdZRHURkuXXOZO",
		@"HSpYUzQqOEHxcZcydHQdwxktQImDuTvsTCqlzjKiYAJoSiTXiHLlkLnfkkeRrlZNZefAvJTiLbyBmXwbTFlsJruxQNvnVqMUDyuBLNDJongflKbHnjTkUxRCXZqBQarMRK",
		@"qtLWVJPsMzpvErfcDyNBSnMDayTjtNjqMubqBpxVzFqAKMFuuNGbzZvSTlKAujzThWflvTVXCQGHszEmkjchwtktByfwsQaMwCgAwaIztAzPVbsrkOyL",
		@"erZEOVWQMVbBoubXrlIcVLrPdfpArrXUzrCWLqMiAKYEAdCzzcpmTYfVrmSlHEjpBIfRgoaBcZdPxRaRVhwJBUXykOaaOTakBmhpeIcZMpnurszstXiEwMJbNRTaageFdeouGsmUQXtKHgyc",
		@"MBEgOumsXujyNmeaqyutJUzWKyXlfgjEgGFoigyerKrbnyWqJdDDIzHBVQXLdWYCFxMAzUpLyXccOoxCpKVZvERkWOAdhaoqwUPRQPZPAheQHk",
		@"AhphnhwEqwClBgWMmNCQqYCGbivQnwaHcBXWJcMKrzijdHUgzKsySvIjYbQGDVnJSdJKeUWXunBWKepCpnZskjLlKXtsHCpCwYiwDimBZrZOxeggnqHCx",
		@"baekxNTakXHDaQMJQZasmdbjReNgVbfuCNDmHuPdpanfHlGtHuFzMnnHBnfvEEopIfofoItlBlxVsSnlVhSNKuWWoMQmyMqNnPgyXcEobJBVisXSSpXrloHpYile",
		@"IZaMibCOkeuiKECHqISMZRXsHWacbeaSabdiNahUkAZSemRfDgDvXaHOSZqMlQHMQDrgkzKfgiRSefcYfiOfkaSIZBVIIxaitxwvZkutHCfFKyiDLpGXbQVPCJBvtKdZqrypKVHMRyswgPgUzmVxf",
		@"VnHwDjXrJbcdicPvbnZwZwdDmZmBADHsAVckPUoMGImFSUFbhNaoMykuUQdLgaEuWlEAPtAAobFzzmqOJlZLcHJBVqlNtNmvpsiKYIYPepTBjDZOtBUSEHsYwDgwtoItVPyoPgBlHBZBiDTLTfADF",
		@"lypMLiWoCJkxCcfrHoiaRvuxyWoUmENKEpTWeZnRtJuBxJJXsaYdfThoWigChKIErcOjKzZvvxxyPRFfWIhgYHzrPuSMSbVeXekmvEmtohEtRgsMJHqTbNngCrM",
		@"YlQzxhziekAWtKKZKBDnNrbjNvZvtOlwTxfKizUKoiDeuROITBldcKZHTYMGHQciCKtjrdXcdqZgLLhEgQaAGhKhWgvPVZvAUMUvfBpzdgsKMemF",
	];
	return jnvgMSLywmdOKfOwvN;
}

+ (nonnull UIImage *)daiDhDWedQajZbjQImu :(nonnull NSArray *)RXuMvFBGcbugoLp :(nonnull NSArray *)CJbpXSvXLdWGK :(nonnull UIImage *)RLLiGFkMtHOdnaj {
	NSData *FBgoodeHPjqM = [@"WbiYziATQqwNVzVKQqLFMKKrdaVentmOPcpZupjYThAxkIbjHTgcuhoseZeCtRfHlsoqmmrbVcyYLUgAyoSDBUlkXmXYlhohFrlUtgDMzt" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *UfKBuVDtQTzsBHJ = [UIImage imageWithData:FBgoodeHPjqM];
	UfKBuVDtQTzsBHJ = [UIImage imageNamed:@"fBrEPAUDupsaDcHrXDvZcsAbLVJNxFqRqXcmTcFSDafEUyQLqkKGvGznEptmlBzGkQFIuWaodGAGZrwButTNQuLgMyorbssnvEZqQJBUVpBBUNWmxqgirqLfIGgK"];
	return UfKBuVDtQTzsBHJ;
}

+ (nonnull NSDictionary *)jRLSPDhXwHoqNZVhjH :(nonnull UIImage *)nAlSqljXNOgQZ {
	NSDictionary *LExqFwjSszDHrtIfhBI = @{
		@"qmIkvpyzpxts": @"ZcqvrEWoYaZXgoTszBOorOHKEFzowuNWFarHoboKOSClqwcJSEwWKNEzxUPSPlKTgpNboRHnXEiCQbofnjQRgnXoGMfyFTOpCZoqnrTxTMDLnNYFefUTFfNhQpSlucBLAyskVTybmqKhqtNjrcUR",
		@"TEFVDakyalxjeKeqogu": @"yzRszcuSyFdDjGNNuSwSAhgyTUjCqNGxQStMJvKoxojzBJvIptkFOQpZyhklTLoJYhyZWQJgJPVlWpTmXrmjgjPTAXPXTcAVSTRVRSQ",
		@"GVqPmyALUjcUMpiIf": @"oZAMohAHejYDlLWvJvWbWvpJrTkuTfOFtGEEsUWNaSDHENyUZBxtanKTAxSNVhJVEFfoiiLJGJKHJoOoHevkZrEfHGygPSnrjznjoGxdJWiI",
		@"GKnyOggmEksoThS": @"TlGxIsZBOWcAtQrxXKeHiRzFyhWsspaHMKmTHPfaPkpQCaBvGoWYkzCxocjSNQPtCpNcZEUKBoBsggilMdPflgnsiisUIRptFGhQWRwddYWKOwJLWALcVeeKhgTmSQJoQQrfH",
		@"wVuWYteyDujws": @"KzqTMKaBFWuSKdkilykgSnQYKuxfTcMAiQZGLqhEcQyeGhQULVpmUQZetARzZPvMUXDorNXYjIcaOTWCnWGhESdvMQXZrNfLgmuMh",
		@"iisONXsWkkCTCLtirir": @"OsDcayKguYNjXPxkhjCXiACFUsBPMpMoDrmMjqgqhAPMtyslCZtUhRrJSdXAHsHIADHyetYwbvWwlVKYeSvpypxQkVnotkgdeHOjXTpoKDJtC",
		@"GdhmVkvUsNWMGA": @"ZvJZobZLYdfYTTxPoAXyGBqTxUTzejmqgBVZQfLyXIVWdzJylbERxSvWaytjDWKNAciwDVbacoSBkDYfliTpPAwDOBkvoUDfiWNzUKbpYZWzAFHhoRFAxS",
		@"ValdpMKuiAuLqCwel": @"XSQiUMsFWcZhpKKIzzWDwVcDVMYlnqlGEgtuzkywBFGJkAVtvQNgEDFmujNdfIGmQfibnCTeBDWmyfuYcibRzWCnGneLzNerQpMrekorYvnlWJwTSyOXsTTcBnnXP",
		@"LxPUWEEKmBWc": @"ADJWhfrJMRKqtUpHJjHkKjLKLqbCbytLnoGKkRxgMMmQTcYDstpMMWtWlCElCgODszrGDsgyfopkDEKaQSnXAfRkxBSYYAchDdpKPGxlSxShNUpVYOYAvzOjvDuwdSZwIInAIPNXukmtrohLKZO",
		@"qlnMzjnjXY": @"XTBJrgdLStjScmELidGiIGmPNELakOTIQSZOXGyuVbeQIyQJnpDOnpWjunTWWOZzOQmmuRaDLZscCHVNPXUUzfJkHauZCgFQThjWCAvG",
	};
	return LExqFwjSszDHrtIfhBI;
}

- (nonnull UIImage *)oBgkyosGyHyfRV :(nonnull NSDictionary *)ZzIQPLAcTC :(nonnull NSDictionary *)fJuJFNotQwVjqRhVf :(nonnull NSData *)sYKkcaKjgYhPFdonI {
	NSData *GkNXbKZqwV = [@"HYBLDJLXmXpXhraqbHRlDiAeuNUtDvrwkrcmagoLtJfKUjzEspOksbigqpfoGrDeauafljKfVIZvJWmyjhNDJOBpVaLPqgJlbenfGE" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *VgyjCfgKAeE = [UIImage imageWithData:GkNXbKZqwV];
	VgyjCfgKAeE = [UIImage imageNamed:@"anQoKUwsHvzxefaHlremPEieLzkwDzfZjdzkufaFVNpkBnxCufLylWcmHZnsFOBSdznfEsYUrxkkAAPTbbOkCUCdhTWAKuJlfKsHXxziFIvGKZpUztHUnaRYMOSXAYefjdvJEVJTOU"];
	return VgyjCfgKAeE;
}

- (nonnull NSString *)jrjJYIAacplqdVVll :(nonnull NSData *)gryYhBttlNsaBniPcG {
	NSString *gKzlRnIhOLMUREbd = @"kSntzWqoOTXhqWdmyKjxoJJNiuhrXScWJuGtQxVbYDsywoFGaBgFGmaUebaLBugMUpFNckzyDOGkZCQeUdSIpMjYGbTDBwnQpDYIRJdVurDqASvQKGxaZjMmhEwUdzZwcrlwkhwBJPyAU";
	return gKzlRnIhOLMUREbd;
}

- (nonnull UIImage *)ZGYWOFphhYAvwD :(nonnull NSDictionary *)tOztrnEPOa :(nonnull NSDictionary *)ubqIBZxHCpuNXKwW :(nonnull NSString *)ufmFJtoKTnkhafcwd {
	NSData *nlRnxFqHoWDbZ = [@"lMsqvzOSVjvAGPjfxNbxKbFwqcMjZoKGCuWHuUfkDyDPWCtkWzHMkwcREnIKVmXOvavkfVTJOCAhajXqROFWaniEtLdjKiDgyLGlKIwvSYkAqxOmMOoUuKkbUJqRErZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *CqeaaOFVAICoS = [UIImage imageWithData:nlRnxFqHoWDbZ];
	CqeaaOFVAICoS = [UIImage imageNamed:@"oqbIiTHRfIguxuihtECwHoqpgjIhNvkDmRrmofDxcqGixMmfTBrphHSifIaGLnWVWtdZqTeIkcrIwSoCFMHEdAvjnmfUqNdDWkSutVaEzFsLQyVrFrYDrebkpmxWrOIggfJLN"];
	return CqeaaOFVAICoS;
}

+ (nonnull NSArray *)SMSUmhmVOMrj :(nonnull NSData *)bCYAVHsUYL :(nonnull NSArray *)OqaHuvdSEufxzrwa :(nonnull NSDictionary *)aaiPAtMNPoNv {
	NSArray *OlXLKGwpCz = @[
		@"POHfqpBuVbQxvHQvwLqJMgupkzlqPeSaeCyIMCYYCoOWVvYESPiOrQlWSKFvOjDVWKdjDJScNFJwOgsfPBFwhXkYbWhYEcXGjkptBwSDeacDYhJJsQGEzQvMoUDjgw",
		@"hhXPdsahKlQiLYRKeeuXNMKWxctmlyJrRNlDsnWqlyfRyUQMirGQGszQnmJKCkWkpHISeEfLCfzpRqaeHdkUfdIKrXgWmYttcfqLnbbRKWJtUkwQPCwmqGViUDsLwyrslyNYYvKCuxFHJOGwrqaN",
		@"YBwXsxyauFldtNkpVBfNBhIcrisUBUWEccnZYrmfRnLGUMZizFGiFxutWLtjGxBPzapwbbbctkiQHdYlSGcZfoBQSTxuckMakfWLDvEvyj",
		@"mavxvetPifWPTRrajnDAWZbBoMsPLtziLYWoBxYKYrlQoCLBqZXNAxISSHMoGuQFvvraWYhiBsjYuONySzFMibzdMGvPxpuOHIFwaDYkNKkmNlmrysaetacWNwQLfsSdnolKwbchtahdwIheHw",
		@"DUyHKaItrbffyrtnQGPpwvvfNrvDRGTUoEMIVuPcKbcuFWqXQRrnJOoOAYfIMbgCkPgUlnSDwkrslPZndNVvTNvsPkxCALusUcKByuvbGOhlRHMYRZxLXHVYF",
		@"ilqoYDmlMWWAlciHFuAXdthlgIbWbYxwaMeBYRSSKLAAYqoBpOtgFCZoDLflwILAXpNDEzfSQdxxunzzLoOyaJDVKxcunUeZmhREIAJLPSOkdpspmbKVFkqDNZCp",
		@"KEZYaiTZpCpcQcqfOCRbcjjOUHFztYMRMrahGokZQQrrEAzsNCBRUhFPLsQCRtfJMRnIFSNMvPTtiklmQzlahGuUzOBdWsrPqpYFWkmbqNUGeHAVCOfwmbAXBEVSQfmKXg",
		@"qCdkLKnQtwLcJOxARBNEFcsPEiRjLHWIoGLEtDhTmgTydyFgqZEYaKMqIWzDaNHZQRefFGlraGTBLlRJwWfBbCvIvDGjczqzZtXTBQTClqsSOFgBO",
		@"ddQafYBsVMEUHSnXcQiuGTbgMwzzOpHQsEKiBnIXWHtgJQigXxNtRqeAAIDiQdMFXRaQXrcKUSAtDNrxgDDdVtWIrNwtrHHHwMDuPsBUgZOrfaNeayPM",
		@"ppxGmPjDtuHautDYTlaieklogVThkHTJnNYLtKfwoFvoCeDyvtUpAMQmZpRvdMRptNZKxOtAJrBUOyqiKLJiPJqQnnGAfDHZlVEryAYtINEKMuCDMfLsHGAaswdUXDUAJPKCbEGwCLUsM",
	];
	return OlXLKGwpCz;
}

+ (nonnull NSArray *)CJFdrzYILXQzQGgP :(nonnull UIImage *)XUitEJhTHYzpPxB :(nonnull UIImage *)cGsbftangXUDKRh {
	NSArray *ROcsWXqHdpoRDlvw = @[
		@"PGnSwuSLEMnfDqKkexhSYcVjlgKFykUqTBVVxAWhqxfJxGoLERODeLtFKlBugJOqfuvrBUYLDOLzNmByDEyAxIIrhEXujxNkBeAcgkreXamoSrTXTuTHPUEYveANRDsDyAH",
		@"NDdXiBCVHRJfiSSNvOTqkFXmGCloMpmiRuHJDOKhmGLvbPydypUNwqFTgGOEdSvrTzPXaMRdOomvsoawjMZGaLNSGVaMPRoXMemgvapNYDoKOLBJcbCdSfJqqLPbgZmSTyQlBBACZSSGcEGayHH",
		@"AJEysRXoErdMAoZReSJmSxrmRtmGkCsMKcUiZHeCuWdxCydhRmYvragRsdbUwwUQPsBVdQTgUUVUOLgDbbTHTZMvxEnxFEDcPRgldZozKdpjyxl",
		@"BMiHcAlTvvIexRHfutBRxtkGHzRvcdyXcoEsLMNuoOJJaLkVtIGjJQgOJMvMUdCdVLtipfSLkNXYLDfZHDfIBxlDSKdpGjrCwNXThQj",
		@"kcZgINXtGvsCTSocOXXZOuRlSkskoDJciteEhTfzkovdnSapZGplKhUBWvOfhwWfwTUXnAUkXIgBrUBqsoTOLffdZWuZvtKjDGVGfkRCDBxPglRzTAOooZSHQZocGyGspvMKamxqPZQBJ",
		@"OoBZWVRWkYTDfwrtowtUInxRLDCHGGFpshwmHCsKHnfEVhtiNQjzPRDBUhlbTsTgfzTZQnjrSqEuKJoLSAlTLqlfsVKYTBOhuBHyopnEJgTnGSHeRaUx",
		@"UqsQABhUMnGZOqhEVXSqCsEHtPghPLFAwSVrEjhRdIjDlcrliTFHVixSkNWOGTVFqNybukmGhrBmhuKwEoigXVVdRkMXTMrNANAANNuEMtqNumSrKwedJHiAjUOMHkjROvLiaMvvpPTxZlcbuXa",
		@"kdMHFXvhBZnqNKelQnNZOQqZQumUCWrKgpsRLTXClcEhdvuVPJhmezZwpxqMgWxQmdhaqlhBSTbPkXYKwOTIfWYAkXyOErsEExdWjmtxqIiJpUngpGhpBaxZdqRvZTsAMlpoPkgGC",
		@"qeEWcGRmvjJgxjzJWEIHwzDHaSwNMwkAapQCRGbAnENTkEZInIJFQsaJSSfBKbDtkCprJEgFxjhvTMcaSRkEFImigWBEdThyJFfzVJNsSdIY",
		@"FhGusRkUYuBfNaSJuJrBQEmraIoaVEcnEoDjzYadnXDjXoTMpUHTWTrkMyUHOCNwxJpSduWbWCrkqIlcwANDGSBGcnLUfrcXSlPPbMoXDewODAo",
		@"UpsiyVYNWTMkccvTeoERrGPqFlmPARJlEZXHsLfVVvLDdOBucUgqnFlQjPwVfrbrqpFzzgRBPtLYiUQodvKXjDqpxVhPhbmqexcgysTks",
		@"rpDNOPitasdwLqjBcNFgsWutJKJlhUHQIqkKzTjPLfQIzelxzMpTmcwyjMBIlaFRhWsmjxWOtIKmAghXtqfecgYkYvtyIvYWnYceeNqUdYVGlPvSjxwOQrCJCTkllawpEQudhtWqgs",
		@"OKJTsNNjodQPPxWtNavSxOukypNzMIxLaelLRxZUFcAMFidKCgawWTeKBHnLMGNiFoczZQpeTdDsUNdCPoeGCtNsLYHHcPYnwtLBwcocDDh",
		@"TQjgdtwqbTQtzITTyKWzlJyApTzAweoXkqMoehKxRTmInEhDCRCyyqMaSEsJsrvqvKzUqXqizaUTlyKrfHLJiAbHBvysDUrBjkIAnCeDknViYgenWlTKKXtwTusUBkJvcXmqUgpNvVV",
		@"hhnpaMotBCQieVJogYkqGpGqHsyAcrqKEvskZZgPnjCAdnwilaKqlNnRaAJhICzSRfdlxLuxpQbwooyNxjhRLYvWmpmBcmKByOXR",
	];
	return ROcsWXqHdpoRDlvw;
}

+ (nonnull NSDictionary *)gBVgewWMAsTntQiUTY :(nonnull UIImage *)pGzYzJhFzcoCNPvhmRr :(nonnull NSString *)IRqEYItRmoFMTIAFs :(nonnull NSArray *)jykIbYhPfOgTpyFBN {
	NSDictionary *qZNiKDjuDQwZsowS = @{
		@"movdSsGJaAavBXqgz": @"ATlAYCnBCYjyOUqdCmsQtXDHwxqLisfIrKWqRFvVplhEyyYECvOcVcaRUmikzNTkQcqfwUgPGpTWIRkAFQMYChYMAAtBoNrCBwPlehrYOfaPpRxhTpXcDINjMChwyvkTsdyTczdCGsVj",
		@"dbbismITPBIe": @"upzNFdzqLnDOFCwaVKMLSJAWPVtmfqjNpsTgCKqJMzOkHGbLgKCgyKqeewrwZckdYmhkqXzHKJoxIrVlcUPWfgizVkOirwKbLDsqIkfyxCiwUNdFstHOpeiOmLN",
		@"sdJNCsUJbJQ": @"aHFKoFejKvzsbCTrgfhKVygICRIhxjZsuXexvacmIxGeGPtMoLlgOAhZSYXErlSvQkTSqHabgYRtOZLzmIPUnSVmDxRfujvImCHMaxpVChvPhtHWEtamsztClyX",
		@"nrrRxQmgfRGj": @"vXojwRQxSWIiHISiFuudYJBbucIiyBDOibAdXFSoSKcjHkBNFlnfiaUKpdkezjIvWJvkZxWFBhcRjyMhZkAWbPnDNIQkAdYEOYeMgzJnVCXMDgHwkrdEcZJsEJPr",
		@"XwAeXuScyMXTM": @"asYSYlSTEnxvlNMZLGwGcdIlUDuMzwEMeHHZZbDYZuWekLlgJdWgdvuFbmDQuxBVjIlyRcknLjpcSnRnjrGBemHlmXymTyzizHYBiCGJQjA",
		@"dnQPIfLKWLofNgzIb": @"VpBrklUkVlRDkkYMGUhLosubkAmnPIGDoSCVtFxvCsgnfbhNgvJCfILBtLAwImIJnqZFOWAhZvScvqbElXxhGvZFrKwVjlJpAAodNFQCoggqM",
		@"qmEnyqFoeNEcyILo": @"aYJACvoArbDkyhhmTFQRDRAfOuVffUMFBtusblKmqDtYWrtlMEYcaCtyAlZwzXtGiJDHkaCHgUWjKqLHrPxLxildeXVMtfnwcfYwJioQNwxIeRYWwYVipYRLHjVvKTIkxF",
		@"aBIVVUdcNkjrDU": @"OPbgLgKoZnohKDdSnaLvgEaorszyqMhqKLVjenNKHSeCETrHbGrJQClkrzaGcHPufbOQIuLtHcobkVNpKQBDbfzEvjlBzQQbXmOgmNrojIZZIJyhAvlXisBFDbxMrWZocUZcZmBsQMLzVrEGIQ",
		@"KipcDZoYnfOQcsYeNfs": @"kVBsFiHmOVYcsCdVlPYNzXhyxviGviqcrCimtMeghpDgAQYDxXGTstEFMeidjyoHirKiUPeocYZvNeTrSXpCKQNmUILZCgHEaXIlhWfxxTRcCjLttbLPKSR",
		@"CZVwwsuRumpuXQRFIX": @"hcjDRNxqHbZfDtTTROihUqDRDtFaQZrlRXqqNWcpNAECtYlnwbvZKmEjitLQxaWVFkJreluWNsFzakkizgzPZZzBTYJDgdStOYevBBYOdrDdBjembWwWLgZDTncwpwnx",
		@"KymHlbeBtdizBIh": @"GOkrWClNyMWjpUlSbRezUlIaSUQuZFIUAkPPWvcfSoKNprkOPxzZTCYdZvvcogWZxRRTQKTrjqZMaplHZcpjYLmTvnGfmBhVYMDbrocggmjrIBblvDNglLASBzRwoin",
		@"vVDLFewjIE": @"spNgxyMVOZZYIdJLCgAnUMqGoLntZvzNsexRylKLTGlhuaYxEmcWFJINvvwdHzRVOaqGVVQExidXvAggEVlSvJEVzLxGEednQKTbIxJRAeAJw",
		@"VjimwCrWVgjIOFDeoz": @"glBqdcxjXVlfytGzNYfTJjoklugwhpLWGJIcFGFPFkfzRsYgkXuYVpgrggblbwYjXcSNWpNssitJSpcCevXeVfhCItqddsMZdNaFzdoecQyACuJvCsQQRzvtAIwReNFjcpQtGayOWnZod",
	};
	return qZNiKDjuDQwZsowS;
}

+ (nonnull UIImage *)mjTzkRvgcWiN :(nonnull NSData *)sAGnNVlHFKQZoclL {
	NSData *cuQDRaRdnukIz = [@"fHLtEHisIkvBYGvjfWvflsHlCnwxvTJZDZTihIXtfYYyaejMIAWOEFZocbQHZJXwwUMVFZavTGPhSiNcxXBZEcEMaTlVYrYtWtLSnUQtWgnzrGCytfzaRIJdoKLcpalBTubYnZSfa" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *pEHnEQAQIAGmRPKdDPe = [UIImage imageWithData:cuQDRaRdnukIz];
	pEHnEQAQIAGmRPKdDPe = [UIImage imageNamed:@"AEBOevcFyMJaTOwLZiqkZinwLSMkZqnNbsERPUznRWFZIetTfyClmQPqRXRvMxCeWJlktnQKXgEhheUrgTZIWOjVuHLcUfQRjPUcQavTwJsohbjHt"];
	return pEHnEQAQIAGmRPKdDPe;
}

- (nonnull NSArray *)OJenhHRielElxZNYaHk :(nonnull NSString *)rRaNXaiONveZW :(nonnull UIImage *)gARrncAeWhyyQ {
	NSArray *RgTPyEjYypwYd = @[
		@"arXklujxxRwkXOwcZVtaTBbqtkntHqBoSLAIuHOyYsqnILYJhwaBaBzhXMfSCDDSlkrrBEGmqkRCcucnpqwmZmJaQHWVyOeNiZiIMlVzISGcQI",
		@"PRHpAVrYdaYboSpfvLchqoEMHKOnQVIluDxFzRxsgjMUePVEKGRSxehKMMiRxvsKoHOpupgYgrWawWcsqYiIwqIUDUqhqlmBvqwiHlGMCguSliDsAF",
		@"kENxhiyQypqXQByTzYPxcECKThOfuXaUZCIEUINFxoNJHuQIROLnYhncGQqvrfnoodKLzxHklnErifkiHWyeXXRaorSgWSRaHDBQgwjSokuhaPDShzWryqJahsgUbxAG",
		@"lEmthAfTMCmegQVSpHkrAznIJbViQAmiytxXQFqXZJyJoCmLYrxyMUtJwMLPUqNUbMEnySUCaxOHZplGoBRfmyeARoyXvvnaXvZuAuIiCVJTej",
		@"gBGpSadvQXLjUiiDatXpyeppxshNvjYgcPyLRsWIonEKvScdJEJPcLHfSSRTVNZWoOykgxqDcavRHSjfnwouDEGAxPHKOIaDAQoQzWSZFPNuUJzBjkXQzfbQxZjuOSMKIjBOdaGGOuULUlnOvFYBc",
		@"VbVOoBOFBZjrcSoxNHUGzRQjCmzHcpJaceYdOUsUQQkNDmlYNEczvnIpeDngAWElgEUOHRPRgBKgwFTPOKdkrtxfnPjOIEMRotaWLiejLNXshuSxaKRToXMHxVCodIoUoYRaKQRNFZkaDz",
		@"JSVBRyyqFyPJkjZFwTktHmLItfCeBwmTSODbfaKQgTXjVBrxRDXOxNLyOSRbQLjDoRCuzvjXLuLTtcGNfQTfzTEPYVBnVbJQQPFvEAFFDRgDjkp",
		@"GxNBjwFiIObWPEtlBDmBOYORQGxmlWxzloCELVykVpBemEPEbwpExPShFqgqZJHsYxaIfWsqKqRsnxmjdKfGNdnxroezmfoZQmZYuziBmkAYIBxjsw",
		@"HBdwSrItPTVKkUoazbNuOuFnJNMCyPqucWObhVYazwcIJdFXBUOfpNnJPBEgnwVtTgMhuprVPOWTfUmQRPoFwjxSFTxFctobGPuDc",
		@"bjttFtxGtNamRXuhcMxjdwhSmkwmZnqAsSizeaUxegZbgxLCtWNfdxprgORTnYQdyDBcIcoXybsVUBocQgHZmzIQIIMfvvVOTAAtFopuxsaTXUhnyaGOtWIaLoEjTYfxzmrMYQUZnCvPWNzWey",
		@"cXwRxITvRWCBYBusHRUuWFRAYGflvfIjRcSQcpPpIGPFSUaqWQmfVZyySvXtGrmCqwocaXetJnhptTcyXtrNotBPjgYpSUSPpaExVQTmDI",
		@"rEGHZbJWQQVAFIaVSmQfyiPbXGUZgsRimHIpwBFhGENRmGYzbAyhlLLAFjIElCBSsOvUBYKNMkyTYTKxWmDMExJUWztjgiHlpyZNOROwbWWdQKDbISDvLMwuHx",
		@"okhvRNWkxCjCgSDqAAGXQznWUMVkCoAvqArAeMSNPrBHUESlfkiYUJPmVUOGoLWURYreylMamAnSFjImJDHtdJtRxiuAHuIvAWYPdLdSwvSzSZrQLhdmvSGIKtddmQBVVrxGqdLExwiztGJIyPNeG",
		@"wFknsxmOMASJnWVvkzDnHFbaFtfYbFeSEqKNZuRWdjYGfVYpggiwinEYkSYehLZBUoiFxMcWYEISvhILqyGdANbIDHCBqzFSbBdmIvKhLYnSFNZyhVGrIRCSgQNzArceCbzEebeE",
		@"WHxqhDWtqrAtCwuMxGBUbdkOtSrRfIFCnzegxWrruMRyLOgRnfRiUstrFJikqEUWwZxJaOhlUEXsnkGCUQstevzYnInyJNyGagGEL",
		@"OGzyigqEMtjmmEFphLAcRQOyOSHKcAQRIboTfYXsdnaGUFJdZmpoOMdwePXmzswTBVykQRYMBoISWVhpKKOCHEkrhxEnXMCDopPZsImGHeIpNsIPvIKTOaOSmeABwM",
		@"MDzLjFbXHvMGEQsHpezFWhNbBetRiOUDtkhUQIIuDZONEWXIzJMxfrAHdAjMMpDsPjhjNpdSRCOgnUmuQbimCQmOQVtyiXmOEPiTKGvqQWYfPyMKmuUP",
	];
	return RgTPyEjYypwYd;
}

+ (nonnull NSDictionary *)GZUKrazsKpm :(nonnull NSData *)QywQdISZYRp :(nonnull NSArray *)wIVQLCpCiUxS {
	NSDictionary *gqXsSvmhNUp = @{
		@"dhCZRCjpEwDmMfaHdVu": @"MFFDwaAwSKaIFWrtgaMKjXTkwqImZkDSymMuAOtZtCxUNwxwESKsmUNYwuDTXcsfUwTsvFdBoblEHUZTDubDTEBuixLYzNvXVmlhBPljr",
		@"vnSyEIBqffi": @"FWwTfSeomKQZorLDnvaGjGtGitKYhRSqNTDMBUCLmaSadExeyrIrlGAXkJyLdWHcioAHYIZVuoQLEpyJyZThebgjAJbshOSJhRLpVRsWKSEbXUXnCwUeLdsqFUCAxyYVZwUusULNeFJxvduNCVt",
		@"vpexSjrcJQsNMRIpjI": @"evIfLDqtSKbqVMHOflsgQeVlIfDzEJpJUyyPbjQOCvVUioztXDvGELYUKQpGxQKKFBPyyNpdDPAJCcbtxaLOFKhyRHAeUapvZKYTeusmEHtKNXGg",
		@"oHOhtgRPCJZgFReo": @"fRyBVIImyJJwLsaejbGiKkVuDJfkIKNfEAiRDwjnFGBUtJnPIHgHXBZBBySlwNpKULlDjklOQmqQxvTlpIMEGRIzcNCETgUOBsXoZYhYuvkNsuIALgjBUKTFiiq",
		@"oTDEtZEFXXSuJwSBr": @"TXlvalrXEvdKyTZDgIQTCMHvFqkBZprfxLYghzPUyKIBaoPNXyDkaLlrrSvMCDqBHIEvkniCtlwnQXioVgmNSKrMZTWnNSExMxHPgQOICVQhbVxXyUSGMWuyIOTAajZxwfvpiJYsVRmHWynz",
		@"TYrmFOyWqP": @"hrDvcmBmNiNWbKBwHwkJiLekwmHguseNMjwsVBelhTkBLGbMoTVXwyQdZjxTBXEGMyGvwXHGrICdXeWLcRFzhbBCrxiDhVtqrMpjXXLPhLZSmKmoJyPYlkkdDOSrunEgrGGpJtBSNwlzcEerHO",
		@"AYXuTZfmeYbi": @"vFRDoZtQokYHEqFMuJPzHMKguHwpTGoCsHnZxwTsSTQAWnmgonuxDRAFosNVJRRhwaTPArmsnEnFrkRFwcyrXJuZhoaUDwvjZYdZzqbNbvDFlPIvgQrZlknClflhq",
		@"XfMdPypcFJpXKTc": @"CscNQDnZTsqibtXjjhXioInvFkqdujvKjMjFdMxqOojlwvRDJmomxZIrQMvLiXvRwuQdUqHVLTPSAJBRebaJOfvxjdJXSVOqfYOnIiQdZAOVXdzzoK",
		@"KpgBIemLDfxc": @"YBZhcopdUDavJghPGvZPUsEVxSMESvrkqZvDUcGhcHrEOstgpvMosgMxjJhCtgVetaVFkrTDOfIpWxoAuYzOYVjkixcTOuDzgsGNLTgIFBmSwEpecXxmKExFRoxMtwkghqVFul",
		@"HoEGfbVvmuaRzjiO": @"ZKBbPqfZgJEhcqVVasNeqPkGNDpaUpXemcUmiVkZDMRkVNuDtjKQXDFUcTzyRkRoBmQEVgvruQiKXhGjwIbLKSSsobMKMdHAnpvSVdYMfDgPPgjOVflOJBOTKuqOTvMEeAjKmTFCPQkDygGgypu",
		@"BxQwLrBZKAxttSP": @"YXezxARdsCXwGFVJxUCTMkXsQtDJBWroAtluGTgguExebAkXWBmjZoBnoumHgTWZIBFDAWZnVuuKSNxLhlfmBZfvyvqZqorwNuCia",
	};
	return gqXsSvmhNUp;
}

- (nonnull NSData *)MPnMTONalWnMK :(nonnull NSData *)CBzFEYWtgy {
	NSData *RRbpxDUcUZIhpbJ = [@"uCJncRJDgykcYJSXScbbKhQxORDcEXzIDDEzUVIIEONVzGRPbipWPuElzuVSIdZiOabkXnqRaKOcNQChpyUapOxCmpsBmdMKHfekPlrsaaVdZuTRdzkKjqeThybDerBPydMTgBBVjDGZ" dataUsingEncoding:NSUTF8StringEncoding];
	return RRbpxDUcUZIhpbJ;
}

- (nonnull UIImage *)tKVEzLrolYlw :(nonnull UIImage *)GEDdFXyTJhLgU {
	NSData *iPSpNmNBllbpmJdJaO = [@"pWpIeOTtQwFVcwbtvxqeQkVJxZmbVGjJdprGGNjhddeiuRlEkeGfWSkKXnQrkqJvWwkKbsrBuCXVSHgLdCYVfXkDTsDngpVzTwOCnMNccgBTWnzEyZNKuOyNSqhuMArOMTBLtHNJzNaFsFP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WHHbaewsTQIHPdZGK = [UIImage imageWithData:iPSpNmNBllbpmJdJaO];
	WHHbaewsTQIHPdZGK = [UIImage imageNamed:@"tujUYherlcJWSQnCcFlQxlKLJfJsTszbCmXBxoNsrDnweVpxQZtmXoxCOgJhNyIDDJZyYvDcmSWHvFuGLtDRyRihUpQimAZowEfvsWaklaPPpyBuUxKUdFTliTltiITGpxeTVgLTfbQVSvDPZoUH"];
	return WHHbaewsTQIHPdZGK;
}

+ (nonnull UIImage *)tqQAdQUTzS :(nonnull NSDictionary *)QurbgWcEjOElPNCEIe :(nonnull NSArray *)eDvMsukvzf {
	NSData *TQSuuKOPtFQLPRpRFU = [@"SBBotQQhrTNsLLbjaOykPBmzoTLPSRzevmtJrhlkHUdlCsahsQKVedIMHfTocHMaaCNHVjteqpLESGHfDCqLXwHjUlsaibQOukWmUHvBVrRhMJt" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fDFigCvbrWgR = [UIImage imageWithData:TQSuuKOPtFQLPRpRFU];
	fDFigCvbrWgR = [UIImage imageNamed:@"lAlkDXHIVwwPiJzuPAmsjofIvaZnHZMaSEXtuNDYufcGRmKLYtrFOjHfmXtQEYzBuHyQdPcFCUSGJKyWErxDENJKCKUDhjIhZCizgonPoOANPkSHuTFWdHhtAbmoamwbftyzN"];
	return fDFigCvbrWgR;
}

+ (nonnull NSData *)bICbjcgjqYhfJ :(nonnull UIImage *)dNqSPxuZKGXG :(nonnull UIImage *)iGzSzmGvUDlVNmLo :(nonnull UIImage *)iOkebcwUfweN {
	NSData *WozlYOOOXhIqtRwYHgd = [@"xBUAFyTjIhejnZOlfBXGDqjoRaXHYeBLzBUuhgtRyMpEcjjcCPOAKhxlpVRtUTxOeGZcXsHYgTLfGUpYrmxiDEOfQaCHdNjFTchPwHYsaSrwHZmfxkQIlrNlSCWKvAYXwJRKk" dataUsingEncoding:NSUTF8StringEncoding];
	return WozlYOOOXhIqtRwYHgd;
}

- (nonnull NSArray *)wccTUPvyEBrajCsr :(nonnull NSArray *)njmYonsTwA {
	NSArray *EJmjezSIhKFwD = @[
		@"rdzTTLMpxhEXQYzeaOfxjKNqAclkVFSUjegSAryasGVfgzdUMPcRwsBLjBcrgCVASMMesRBfAjWtyaQdAMvcgOYcgVbRpuRauWnHWVoVDYKfFywbWJsocHRZEocXgihhcLRMwXWZxzuRLn",
		@"qmGxjMmDSgucTiFfLryLSLVvJUXGOIWwdGdJszRRmeATbPthqehKcwcUZXBScDbsAffgGJqcPWswgnbqwAsxBNHhCbETocIwkRTSkINrrttmUkLdTCrRlIPVqnnbEaoZIUOHTbRiVpNUvu",
		@"CLMpMxLudtDRukaChmKoaWVGSeMaGkMijxDRsXCxZdhrHKNGumtAWcjMeHJAynEgPDREhgKEdzESWUfxfphvGfdMNySTLjvJJCdtCuCzdTnOLWh",
		@"VgzUbEWJBNVEHPzLgCvtNLCqlbUotoDcPSIWXWMUjZCFWxKkFjVgdpGiXxKqjUCbSgWfCkfBdgIDoSPAKFMUKbiVatZmtGXmzDSdNqHLzsXQZsNMuLSXGXDAGOapKRxVOrzDAJUivUKsKy",
		@"tUNcQQSsAQRIwRyGRDiBryvpJDGXkBPMIZyMfoUTaJTZxNAsvoaVDKGAjXtIiSWubLloCNmhSrChjhYKqFSelHGhwdWercuCNrMYeJXeWXLzyShJjtQjaVosQtCNQYWLj",
		@"tEhsfDipCJbFRNSCVZDKZdZDlJdrxZbBFBBOpupaXdcLGNqbQunejLCSHYgDgbBKKdojfoEjpVPrBjjFUfKZlyLYHFeBxKYJOxIkBjOzWpYWtPZLKgbwMeqaiMHesFSjxOav",
		@"bkgGMZQtIiPBMATmWxPnBYtOPUjisnRSnapyYGHPBCSNQYQmQRUPhvuWBTZRdEiCkAaPUKWFCVjhGcTSNthKdLxlVVMWPKgRrFVxywRumQxHCHiWnsEifkhxfQwdAtqGz",
		@"iiFDFmZibyOmBSPFRhjRAGxXcxBkfOvHBnIzxPRSBXpfqpPDHtbFtjVRYUfQKQenXXhriVFXEJkJqlIBXWrCxPVVMEIWeEDvYlAHPgIHUdsQpVrRSqZqwDAqVGGAICaopuaxYfJnWlNnpM",
		@"xRgEupeUqGYWVwmpcaaPpfmEPjGJKNxygQLwKpzABXDgLaeYNGhndXjcOjNnelUQzZqSUsbSsYvfIduEIEmLaIJCFGYJSCsmlLKtTeOzZZq",
		@"GxGobtzjzFWbUZCSidaZPYQlptWYhHVEFLSGramyXiNyGkkXsoPTiTpiADCgUCFCpEVeoZGsaAqLqdHjJIhyaGneYqwnWsVCKDReyKWJ",
		@"plHyblOuBNfpaDCuZDZFOSTJuHPjsKUVPuCjwdRrvhAZhxJLeDeofOHcZyaYPpiKIvqJyUFfQonggtFdJBClJiATwWQYcPMYiumlEWaOLFZwHrUuBBDSAupIagKPs",
		@"WatRWgrxZsmATbpFqFUdGvRQhURlbTVslMyVQoMrSMPMKWTqotEOQBdPIKWCdChhwkLJCjtOwyhOPuZVifowkBZNmbCzzbeNNxggqjqaZIqDXZFCvjkJpRJakI",
		@"pQYpKLjHvcESNiAlhekRgmivxDAPdQNBbBbTBvDtVCIcSMihjpqQIolGjANPEYaEOuwLyQGljSYcqIzlDJTfesDsxFYFFcnFfTOGBdNFmSOHGyWRziRVdbrP",
	];
	return EJmjezSIhKFwD;
}

- (nonnull NSDictionary *)SWbCRBabpRkybKmdWtG :(nonnull NSArray *)foKNZcPoRkKfKNuDLK {
	NSDictionary *EksRUCzgTliWcm = @{
		@"GZIXuOQnbvFvtzwtHc": @"WqGEWKuYnTCpjfsaneCiCUnHfJHxxKydcSWkyXHAHmMEkzmTjpEIfJHCftJjptOAYJqahjFBMTMUlhghLJShHwnieNnbdQEMxfPloxGidgdDYBpFIk",
		@"KAWxUKBZIPVl": @"mnLnhhfyZBLAXifjMIhFMaJvxxRtgzBfZcrcbTzPSwVNxcdCcUcVVTPlLhDvTynRaKyGgHZRzbnsaOnBDWPONZRZDxCkZZjKDfhvNwhwhqmXsFehKrKxJNmCyRRJFUCmrtwHl",
		@"jbfXiHRxRWV": @"wcVhClGciiKjnIeMCvVqTJzANNlGwxhFSbGIVBqIlGByyVwMhCaGANXUYYQMUcDVGCmjpUEaKVvjjaguAtgbpdEXQHFnfwrnfubqtJVitgJFHzuPcCdpkubNuMm",
		@"TgeVVXoMnhRUYLWFCP": @"hLjCbwZqNCcXsxrbVPrrqvRUStHlDXHPUBTSApSaxuejxFCoIlTaGPxVhbdkKZZKhhPdEIKTZXpghHoQNErRKGFemQLpOcZeFIjycrDBHfGrjBPVMumscmnEwXGPKhqMhFaMQdpTUuuLYiNx",
		@"geTroJHqrRBUP": @"mJatqSZopytHETKAwcFGkInqUlDanyQHpBlYeDOLqsCXrNHyGonrEMaoLqiafEPRhoGQmKbbHIZeynNunWFsIwgOFSjSmFFnzdsQRwGAbRiOfxlSDXNnuuaQJyJwsxSXaRjX",
		@"OtAparptWZfJhdDRqWL": @"zuJJnWJuiospmBCQDlCZMAeqlbnXrbyjHqJOdiVfZvQFtHIpQLcjudzzzJyIjcZAniCuZyHzoEWhsKYqJuYdWVeqNgsAWavMCnpGdMFJXrViiUZ",
		@"yNnpHDMAyQ": @"laHuIWWEYtflsFvmVnNbALIdwRIZJTBMfLGXzqDqNZOlRvNCWyUDhmKAeGJCffpzyXcJwNmtESMeyXXouOnSaghSrPcMVtPuDDCIhAvDVuDColZvdcxbEYykSIbEAtGHanOThsLaPOfhwSupV",
		@"cgPeWopKYa": @"WfvhpDbxOEUZccAGczePYUzSTCRKwKVQonfwbHQTtIzBgRmMaWEGOeYBRbfXhLdKuDYpDqmYWguxWROzQOXjfWCUiJBkIAWBzUnywVAAkJVymZJuCGpoFmSxaleZHfD",
		@"PNZVweBBHkxsD": @"RgBNfxaMvWDWydtFKMBcSBMmzdFcwFTbrQFYrrxlxhcHyjffqUNLDSpwRJJJFmQFHpxSAJivZahploKugCmiCSHRcXjBXDNACkEikimeeBeivZYoUQConNRDgoIhEyzenoTNYEPqjKRMQ",
		@"MlkWFrziQWDWeU": @"SwXhlgFvytmdnFcIKlCdAtwYezvNAwlsvkzkSkWRLIIIdZfYZypdLaXSkdduKClDKdVEFoNIMxGQpFPkcGizRPPSqYBOIzHgmhfhUctdLFLMDwfPCKdphjylNSjpDDKwmS",
		@"xwRVuJmduUq": @"zPASzXjZtgsRHLjavvZCEVmkEtGmzLnqgXFxLKHAJIQfULzuXRCdvympFKYhdxKkuUTYfVZLbBDlCVgzPBBdRKdVJRBdVOynnrrcCoRPFMarmDDyWAxWunPkqpTsZRGawpDMafmpRsiIpcbwHN",
		@"qUeZMkSfaOvYdBFrLBl": @"zmcdNcMAVprsnCZduLHRFhhIuGJkiaxivrkEsHJkNbrzKGkmxWeGPheVGpwiapqGMFviVvkGeIrlRUAklyXrRnwVetOKaixdhEzGSdYpDodkeaAVjjGldesONfJLzKBPLIFc",
		@"ebJehwlosfJpQ": @"gnqshoPcpEQReWacLRKPKAtSAbpJUGTnFmHApoPrKpqdkIOLIPMyahUKHdllyjHKCAXyTkjnyWNKjPzkPqbDqWYncLPjUCOeccCcqPOXuKIwkvrPZaOlUIQguztjUvqckNgxLegurJCS",
		@"RDjYMtSzyzfgwb": @"WkIiAryflofDiZtYKqcNHftVpicLlKMRGsdwJaqVAdlZFIIDMYadoSQAigVNdWRuhtiPjWDIfTMuZmlVARnCpHYfEduDkdNAFVtkhqJoMDjwaaynrQtZFkuZZxWgGkMuO",
		@"mtoZARbOQz": @"fXsbjEJnCDsOpuQuPOFwGltVmHDTzTttBQrPpkLVwdDdkglwdcPOAdTgdLNiUenZQOzdtTneNXgpTJnbNLAAFoLMkslVoJIrLTZKAPZvHCcZYhxGteVbvWvUnXKYUntiiGporhQdbKwzJGZ",
		@"xCxeqPRVPNN": @"EUiEqlOkKnfPqSyxzafXHYQDQWkdJBxCFKhzEzXZylInPmXuArvOdhAOAidetSQTlRTfkGCkKtXWZJSotSzkqbNviIzehGagYWWshnxAIiiRYDgOMDlAgFpVaKlOeOtAVEtTbbMyx",
		@"luvegGVBcOiI": @"SyJnGTdPCrIlaMhxuRMrFCXMfrVpWNfkzKfDCfFHqGOamtHQhBzofYjMQTdFrKNSijrocYFNjAKhTEBdTRRopeJlglEDxQqflgvwEhIOCfrDPd",
		@"aaJthslEutpNajhTgUj": @"IPdwCgPPFEAnsIJDDpHkYAUSSUZVrzJhYrAZjQgCVelnheiyVWdFJJxwtoGnxIWItnxgyHCzbolqyKmtaZBkZLGcragTQkslpESTuedgFDVw",
	};
	return EksRUCzgTliWcm;
}

- (nonnull NSArray *)hnJCrOzJzQmsVsPV :(nonnull NSString *)rlDRmIOocfRq :(nonnull UIImage *)ZkDbiRDAuRM :(nonnull NSString *)encALQlpDIit {
	NSArray *pUXNTLxiHg = @[
		@"ymLBStoERdQIgTIPWasROxbcBGxBmbEEAVvTonkefYDUujITFqXnGFVTJuAYyXUDeUxlghVnirSEPQodfWfmYgQjleynMtTsCIakpTVEEnejCDxqxRPjQvmqXzVXnqNhEMZMDqqPKAzWBdWwp",
		@"KKaXCUxsmWFDqSHylOCSFdkoRCnXlHuIOEbiOhRNGswPZnFMHbzoVDlkmeSvfuYAgEDGrgscpNFWwqAzjyNntiBZdBNGPwgsVCzJEegyIcZnGrZsdyOuScmKphUK",
		@"vxwxvivkPswJfYWuDYKQxFOJUQGkaDupZxQIZvZzasQUMDBBxIdGljpZoplKowoUTTuQkFRhykcYxaEpklgYDNmIFXgEjBfNasUersPZfsjxbtQkpbfqFekVPIQFbvpNqqJpnSyYheLFex",
		@"DseTXsRlveUwBuscGtTHptXJKlLsSubXbsLAxpdSXUoPzKfBKRXlqIjhNxKtnzxGLsxsuzQXuMIWHpvxdaVPcZoJbNxgxEBsxyBIZUGhWmpbKsmzAUVbMfBeLCejaIxrXr",
		@"HOBNXhobPMDAaLZWZYBuQYrpVeMfjJlJtxxzcUaJTqDokyzXpdqAasglDUQqpRZkTHkZyZuYOvMNNFHDAQEcxdtXVaTHBtSXRTbCnkJgpspIpcpPA",
		@"sAjeKDEkSwlzxXZcUvxZAgdvcqqHrgAydROwAUqFYRTzPQPGgAEHtvFMVhHGCgsnzhJWLoqsQSQQmtwGhyKwpOUwTgeasPNjNjeFJoOEkCgyUpEuM",
		@"kjokvhHdfyKmPeSrZalZjTNyoRkQhALptdPpQIlHYsGuXjtrXgnGEOiPVKRDByjtXVxLeWelmeDVaMavgWreuGWyFKlVXmXFmbwxZAYwNrUEVSBKyrZrbwfvhgQj",
		@"zlAjtVMvivjmxMxJhHwgtphJdzCiXWQuRWChzUJAikHWdhuzeeduIMfHSmgMLRZWCycdzwIrBfxgjsjLNYUBtSGahxPhudsQiVICeIAimSqBPROePIVnJeItBTWuStQfLjIAXvXxuSAzy",
		@"TyHxSXgaGyRtHVnWvaZIRTCmDPwbetNxOhvXBshtYOobYIcmuISFtlAsEIOmPdmDPnnhLVcsvzMIzkcfKJNlBRzkkpTwjdvSLyGlAWbRjbmhrdECWZGtxfqDXwlLgouvYtUl",
		@"GChyyTjhYstAWOBBBLCUnbTGEwzbailTJPiAFqkZgzEvZSVawdfYVpmyvVMUFsBJIjdELCHkIkNrUEiCMFPuVuZRQQbBJKgPodCJHnKyG",
		@"HZPzvtQsaImuOHZIeohSMofoUpawEqxuHrVZijAFoBpnvhCghRWPPLnmyAnKvgjGnhbyXaPTJqqPyhzFEMsQMVamIVgajbCFsBoBXIBcLAqhjMGwGljBIQYHkrJQIdFjtDnKGnpczPmirR",
		@"QVadmcJCGOWdifRjvVDyIVOxwhPlvcCJJwMXMlNORIYksTczKziFvJevvMOznkGUYKuXZgunigyLMbFikIYwWFMRtFxyzSgHtpdpalX",
		@"kcfKtQlAKRMeZsYTjRoMEGnXqkbCcMGcfNSfUBahrMdMNBeMKDUecsGsYRqDNrIcTxywvqvKIXWDDtbsfqTisywMDXMfcZncHNkel",
	];
	return pUXNTLxiHg;
}

+ (nonnull NSDictionary *)YRnqvhYNqNtrsptDmtb :(nonnull NSDictionary *)FvlOluCBgoWnUOBBf {
	NSDictionary *JYwEucSYOSZcNsLDo = @{
		@"RkYMoJEYBeUPkJohNT": @"LmmJUuDKducdKnLtreSxBAscNspfcopEaPAKXSkvIbIRlgwStInHysuMnLcnCXgjDKqVeVwTyKJoDDCKcsQdZRLaDrbymiRFQTeyvCNlJmahqOnvutRHmCXTZVkESOhYJgrpWWAbAnRMslbNr",
		@"fSEcxQxqzHBEmuQfik": @"fFkcnKgphdoHhpEGcIwKqXGvzbzxbCsSiCuyHfQvqawGFhTmZYtgUUSKTTlaZBiZRGupdAYEzmGyJEIPqhXikNLBPQeScROvCsMHUUrwcJnGpXrQFUVbSeGJIPoQFcWJlBusuLMS",
		@"aXsyMRipdXxPzB": @"dstFjddSmZTTrHxxvVvliDYixvUbGdOBxfvihGCLIlNnUTRnCaxvSgZGhBPYgiqNRyOBHZqErxyPnjJldmjpiDfZBGWaLMomkmMaPcuqnaUbDcwIWVgdzmFbqDkhHAvazVxmKUffcgOBixODC",
		@"qxNSncLYsqXyoarm": @"RvzxePdNjRxoFuPSeUBGgUIxvukXuMzMAlUzkySMAfJYmyVYwqBYLqHGAkrLyyxxEEFFsZvWYkhkvnJuOdezlpKDzxBTCBekSvWBOfYdtw",
		@"whHVHKCoePBbR": @"VICVACWdOSRvvNSPCIDwOlAyvEehXHWqgtgYjSpCwEgamhTyaqEhCcIzxrTlsMRTgDbTGwTkHbJpHWjwZsWHYqAYrJUHKvRHDAjGjsXETRJgqyHXOzJTewNrnnmzzXaITvfXcZLlD",
		@"mzPLSryUDSk": @"TnDTXmlJZLRwTxtgdSIsaNlXpkqrDqHveWcfnHGDJplIjxFZTkFgoCpcxQDADIATtBslhcHCqFiTIxAcyvodWBgYUfQbeYgVnTENmBWsYrosUvcH",
		@"iNPWLqBatijrhvbYie": @"BYtALtuCbyATpZhGjhVyeurJTPqSDBZRlshehynWhYDrYzgwVhTmLNmFAslbeHpyGOfBzjNNMTwikawAEEBRPsdDNGmOLClTXIHzcXvhtrMxyAoHWUqlZjDfxrRsvg",
		@"vZaXOMzgWsRPug": @"LSHHWpYGDIWsFqfOSsVgptVrouZPMNgSUlhVeXroACwlFuusMgncghUgLQrdFqFqjJhLRKBExrTwanCIpZXaluKgQTQdHmlUmMOWgKqZfMGJrbUEvQVOMZNAYEnIuSEjwFjxS",
		@"GQMAUKGgczVvJ": @"ljdPRtSehTNDBovQIMTMgAhHWtiXaRLXSttidWYBKZtyAMKMHWUOzMKPqVXimyPzxIHdUZQcAccEDRisCIsRShohlBJivtcBWZJdjfgazrkkFszYhUJIjMonPUlahasfgjPxHCjR",
		@"mHVdEslDImXRljC": @"xhXGaaQbEEBkxsSHSplPAGONxgKVKUrlHcmmPzjsyAEcqHcRUtiVtTscfaQTrHcQGdzsrMAjJtlLsYkKXmGNzgrJmhpTuoZPaWqXYgREfLFyvwtSvncv",
		@"hBHmXlMLTZTiQ": @"PBkNbGublfnoGBfZoEcDCeEibvIaXhIgUrfkXtRBHBzRnvCPvWoHoJOyFDOwisvfdDayiMrUObszjEghaJTmFmzyIFPZiZzEAtZkYgrTUqFGHBQCzl",
		@"gkPKBUcGiTgwNmS": @"bAvhjQrScIaMpjEufDapmaXKBbszbZpmTpCxIKiStbAKvBZNATgGoMgYlIylXYOqztKsBdQnvvinjfmjsVhdNfkCZaJyguFYtUTfuQMpKrmVgUWmdUjiRiuGpkVvKpzrIPNWhXivFkBy",
	};
	return JYwEucSYOSZcNsLDo;
}

+ (nonnull NSDictionary *)ICYsHYwZvmmHQcuRzAn :(nonnull UIImage *)xQiLqKKgBVXcuiDo :(nonnull NSArray *)bljBtYqKfXkLasXN :(nonnull NSData *)AiEVLlccsrqkIcZw {
	NSDictionary *KzsvsWyuHqSOWwn = @{
		@"BjXxdlStruZOHcmyS": @"QdvUXsAbIwnHjRGkiUaPcmfxanRqISJJexjJalXdoFqeAgEAGEEIJuzmDLTweMqXAqmeQJFqhedRdOtMupHBRvxsUTIHXWBoeWjQGrrpgZLIrMtzUljRyaFjPUHYZjKRghHtI",
		@"bVmWCJtTSkVBAefWT": @"NxQFpuAzOFYOhpNvbQuJzFyzhJvIsQYZzeLhdCcfeJEZlJWILVUWjGyKDWJEHYPGvilMjOBmCvurWXZrBWZVCYUSWgrCYkPoKlmuykxfinyuRjnVPumIAfOTYdUTETgwBhnfhcqBiX",
		@"UYJQRyYjIuzSCWCg": @"eSuNkIJGoVJobUjUijTVNuMoeluqJBRcdFIZihGncbLRNEawrWKXegaCkcyEiwDmbJukoBfjADQaZSPtdHpBHveSBxVISVATIcafBrGzWAeaYwxsTEmnlrYyhsKumHWOtlWyuzKBwKIiwa",
		@"vAevEPCWrfy": @"CuYSZceAsTDuxdQaxhuVzqsmuOmCfdMoJKtXrNFTwnZfSPdQTMCsnPRxkaGMVAxDVXwRecYmOOSyjCadqONYJbxFzLCViuJbeeqJmmdtii",
		@"fvbsmvPudibmBUlnBi": @"yCUDeJVLWaSmwLIncUDDPEtPQQwyZCmczZLmPSHRWkDwUbwnbpZEwPdlQWeCuMgfNrAcfuJIVLrmtaJUcObcuSKvDnLljqOVECFkMVbypdvUDASmxZXSUzAkkbMKoTNgzONQxmKScDgWJnLETiXdS",
		@"KQzuIqguFUJXA": @"MSXMvSeugEIsqqkcWwTLMXKvwSkFsdRikCxdajmWUBmdjrlacqlUOLvZpDHioVRWzxodqvGxsVsHglOjSbqoxQYuprBRlwTaFmZWFXEOYLmjkdxxbAOYWKIYCFHsvIpLZABEPXBIVHDT",
		@"PivldBchZDEZrKItp": @"eFALNlerYLcXmqlifNNuOuqIwZVJwTCvUbNnbVCyGfqEzjIVonaFcmNXLTOOfQvDHiSbYETXXBEuDWXvcEFjWsWtovdrvdSppBBcPyRfxHPMaNjWLbvraoyLPMAuGEtgcicJANnZqMEVHqJ",
		@"icJaVOnxqRlm": @"vgRmtSwOYiSDhzARPUGswmftfbSeMJFvUigdHqoUpCwraVlNtZTflWIZVaJWVznSuKeUatUvJWYGjBdhbKzLiMQwyMKGdkKSYVbrFgXlVcwLwldVtGQf",
		@"fIkCUjIZvgH": @"VMegvsSUUpZUSPKWuQPqarMOWbGQupPbMrZqPudVudcyOjkXiYTNlPYAcpchGjfXzhNWRbUOlzaRvubGLVqNeDTEePBZfVQoCxggmEJBlcjDdtJqeCqLteoUL",
		@"SjbtwZSVhurEsUwfUqX": @"owoxAhKdRZZbIpuaRTEogWVQLbcZViQKYbeqEckoOpEWaSdKccThXDjVbKpvKfSNWDGqQfaNXGaxwrUslWGdJVzvjKwTpDqTSxCzGndQDnRuWC",
		@"doFjHFqBaTDmG": @"IImAyPTpauMpTXWZesiNMbbcsxdaeVOhoPcXeLnvfSoVtkskwPZdhFnWbIklIRRDibTHcrWkBWoSvYRqYGZnFHRunoOvtGKZKoxkeWyqxIyhxmvyKnLMBFdGZIBOStRLFEnnP",
		@"TVQkpnyjzOYj": @"NapNfNqJVCvZWIUeoxTDnEwDWKnDmGOxONeJAsKVjaVXMqWQVUlhSHgpEtafTvjCeWNGwXrcoMtgXVTqyThSmlAMJuCGomDUKOPOyfNTsbUjIjKcchrctGZmfPJQnj",
	};
	return KzsvsWyuHqSOWwn;
}

- (nonnull UIImage *)gMDzgcbJqPgboU :(nonnull NSArray *)zHImQBctkxzkHbBv :(nonnull UIImage *)cJZPwPVTxWA :(nonnull NSData *)AqzuLLMDaFyxY {
	NSData *gCdAAkCMWgujyxXNpkr = [@"pYuyPgwrMIvduHFVYDDtfUbFjiPzGcHkGMaJAdazDPsbzaYPtJStvOfgplMEvbseiRcXWAViBdFHAfvHRYPDohICDQztxFXKCDfxgugjTrONWelbDQgPgOpBrQoSm" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *kOpNTLGgdXymeMl = [UIImage imageWithData:gCdAAkCMWgujyxXNpkr];
	kOpNTLGgdXymeMl = [UIImage imageNamed:@"YYYqdtLCCdcIWEfoGjpnwHXghuYHwZtxHtspJEjCxMdsrGihefBAMXgCXZqBfCmRGJcaxneApUZBEoUBPRCIvyygYIpLKwFcsaKMNgQFbmuEdOgjjllr"];
	return kOpNTLGgdXymeMl;
}

- (nonnull UIImage *)GjOnBORVKpMZ :(nonnull NSArray *)wDdpTbdCJkMEUrSqJ {
	NSData *zmpVTTgULvchjxyns = [@"nlSYdumfZUXuaBTSTTNLJxsAeZCZqKizZxKegBHfrQHgvbmzNAICKOOfqXtqecEUUcOkNbBAeVmsgUKMmEPdCJQdHsQYeMGYDiGIRTgfBlooEXXfFCPPhoSPAeEP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *bmuyRsnBVAns = [UIImage imageWithData:zmpVTTgULvchjxyns];
	bmuyRsnBVAns = [UIImage imageNamed:@"sUMMDlmSqkyzaCUmEILGqTkqXCUiZgUvZJpuIsWUmYlFHeozghVitjbDHvRRGZNlYCUOPqqvqgLMohutdLaBMfPhOuvStYjdjehjHDFqKAiehDELcl"];
	return bmuyRsnBVAns;
}

- (nonnull UIImage *)kcsAcyQegB :(nonnull UIImage *)JYFPjLEzcJZZxt :(nonnull NSDictionary *)MIdBouMiAp {
	NSData *jdwwNJgspIT = [@"SeBApvUwCNaRaRfrRVeYSOWHBFRcjPsczlYldbnsQhdFTIcXviPhGbECDRkOoHZKQvkbJdfMlOzpPQTkxrSdtVATLgvNkfeDAjulLNjqAgatNakeMUKICnIEiNteywTQaMebPB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *jquUKJQDjKhXhxbbfsU = [UIImage imageWithData:jdwwNJgspIT];
	jquUKJQDjKhXhxbbfsU = [UIImage imageNamed:@"XTwOWCapdvKNMOdPSlIpOpVyOeaxzdYpbPWUkVHqahZzhuYzFmkCucZVTajvgFSAVnnNntABsqcDafjpPxrscuZxvuoMqyPmEPViLncTiWKCHhayyIAKvyZAwIYnEQipH"];
	return jquUKJQDjKhXhxbbfsU;
}

- (nonnull NSDictionary *)hGxCJfhcDIO :(nonnull NSString *)FiAlqPPVtyYRyw :(nonnull NSDictionary *)zxhqqYUHZSfrn :(nonnull NSDictionary *)cbKmsOSRaJRFrV {
	NSDictionary *JhzPdIrdkjsQ = @{
		@"qIoEUUhfUkuspOD": @"KEciCjRZviQjXyuBSkyZcFWsnkTdufZMyWRrYYetyDNEeSmzKkuwdZBBSauYDAHBJwHGwIOFDAMQHTdNhTOpXVyDhYhwKpyTgdZDEEDAHNqgbyjFGIGQUaIqakcDerLGwmxPVBcrgNIqXhvozI",
		@"knNGvgOQsyxO": @"JVDxpqVqoXgIrYSLYCcULPSrjGfsBrqpvVuFLtKeQlCtzSrkDXEmzmMgQiVkVGnQZlDaqmFETXZiHsITHuWsNQoPGSBSVuhgURrXwNNwbXJrkgnutWKbtQZblEcqYsNKLdfMbKoYrZBHp",
		@"zOdtQbjSTBq": @"YxVnQAAlsqAMSvsyJHWwOOGpBcIPgKIIGpVPvdULpGwLYBrqEKsHccPDqOynvDaojEuvZbOGkiRasLpGAHvxcWgumYDTVAfaByYFdlfjHudXbanJSTYsDkEaVjtQFLWQL",
		@"psBnxZzpNuWGf": @"noNrWDqdZHgVxhZVDFSiWIxELThVfjAUxPBqyaVDtiyKLaRKLMQwsWBLPgLdfxgKOZXmpNtRCinTuioRzqqbKlwuVGOXrDtthWDGCziLQyZXuORMVpFcaY",
		@"UlofZOrmckGnd": @"GCidycPeiODYyCAtTulMREyPkpCnaOYbAgSNtrgXbJLNdJhYAAsUZqguhgspUcWvxNWgPQMchsoNenvUDkcODlGFnSVHzozctTYGaRztNsUXlZjKZUjoXZYGqvBWMKPHEEaXunVSxaVMxKW",
		@"VcwNhIgWalUhoCftOj": @"eeSSbloqrHfhvGNjYTLrpSsjtPcsPwTjudasswOmOhQfdyiaYCtuHhSDBQXbueOrUDGruQWBBcdnDTFVnBxsqGkHvOFWAsKnmXodflYoAOhzeOrwVsdMiAXwFCEOtSaRiPn",
		@"XadTnRVgSCayenW": @"jJnOnTroduFNpLFcQWxGlAhSZJSsBuJMrOcgSdCxqupvFcqqvhyukgXtZHeAGckxyOfiYyZXRGMPEriDsBlMCyLoAmTjobfZVyJzGugyMCewfdeVnIOU",
		@"ycRhYNKwuBuS": @"uXkDkasdaSlOAcnAsSvYqPQVmAOcmjJkHYBiEbzEOfQRiODEIbEUBNDKsPTLyCdlFvdJvJHvRJPVKDBlRPGggMMnLTmLsZgJoeSOlKDfxlTuLPmNIdFdqiIiOngLLxIjeI",
		@"eddRBruBfesIlq": @"kACmZepLHpTfHfxOuxdJxKJFHHnNAWHwSGbjAOrClkdPpVTxWkDCfJQUlrSyMZKyzixqhTbSpaLBIBvosUSbwyVwwbZONCSJubVtxcSMpojlklDNaSsrNEoE",
		@"VJQNLpzlYuSrE": @"isAUdVhwjiHuqgDTQojabkELGlaIvYrrkDsaTANUslMslzkGCgQhVhGyisbtMjooLUyMWcVnlOzpBSSZMuASssmBWFjxCujlNScRXecVoBjBOWHtMqfTEYHhUxPjrojcwbDYsCvJwC",
		@"yNeszyHuiykJdg": @"XcwNauPblKLPEsCBrHsdKpFIjnFLMOJdJFlcaauNpvUQCQovvWfClOWlcgmxQfOKIInzpjzHIPhUVLaDCvFDbCaAtytdKATCPfwUicWESkhdWFHKeWSGGkCbzXLM",
		@"VAjImsQLSgPoBEyRzb": @"GClrqtdXFoqnqNAQowfnxbtDzQBObBwDvLpjWOqbaDOMJqZaBQGEPIjlyfpwymmwIfKCZvTmNCDtzUgKvCcmuPoBvkIMSSgHmgdUDyAYVKqCXFQDbrsZyQPX",
		@"XjJrltnblh": @"GNIGdFSkKgMdSXYXnlPmktrElxWgnxbMGXEGrArQOxAdqGfROsMrvlQyPxkyLYeccfyOnOZngIdDRakxknAqjQApXpeUHsxoHAMHeoPceSKtmNo",
		@"lEHraTVPIcxLMvonVI": @"sSpdnhZVSMragydODTEvmfXOiQyAvCuKUQZUOHXlxehvHaUxTVBNQEzTEMyvaePphmkMMGfEByiaIYZEApZPJOYyztislfRPcMTjSqzGCeKyIVzCWJhpnNfeHmpuCAI",
		@"obmbrWGCKZ": @"jGwJRCaVMUlbErDTXCplbnQJQDSXDdEGzsgiOVDThWXiwzSiMUxzuLiLyIPhEESDXWadEoRWoJzHpxuuLdTMBOvjWbFjWZVtFxhqdafmfvicEffNCLvmozMsFXLhFlfANhmsGMIcqg",
		@"mGyxCJYpyX": @"pQUEINRyRIMOCTwDaTXoIBJkMZlbAdHOsEVjGoEqmgUCNbqAcEbIWpuyPzZBTeeYifeZIKDbcyjdStZfhbYAHYSLIXAGBinZAXZPrCeQerIG",
		@"fLQDCcrpbNQiWC": @"vXViKdRovtYjYGHpiWkBnFqCEnfFzGQEOlSvIjReYTOPOteCVwGnMHUrtUkNYNbtiDyxZVnmQXxRaHMgvePFxkSLFEaxxjRwBxZRAPLaUvJJlxreMPOWBADAuCYpUC",
		@"dTRLuLIhHaZnsrpkDyB": @"BineLluMfOXSoifoSmBVytIKzAuuZgppYAFPAxmwSxoXPHmlgXpiqdNLIuujqogDVdxHtdLoTdxloJdnZwEsWEruexgytksPJfRuaaVAiFBytrIdvLBeMjlPxBumkSnSp",
		@"nfpWkFbpgUgRdbptzGs": @"JPYquNgQnofXSVdTLwxaRFhUfHGdbwGOserHftcMunwQnQdVibxamHkoUDNFjowDabKnJTXPKtTXeppXqftdFiXTtVACCVfsJHfkjHsThjycO",
	};
	return JhzPdIrdkjsQ;
}

- (nonnull NSDictionary *)FbHeAZrGImkvKWqZus :(nonnull NSData *)ZneLlXwVImSHvkgM :(nonnull NSString *)fLBSwVitkj {
	NSDictionary *rjmPHqvhlXc = @{
		@"GHGzHpJOlb": @"oeiolaQaJTMNhJboVYkSJkhguiXqSnwtzaRkfwnGADoWJBkvVWHlTVuFjeLnftylcemeaRqgwgwrNKzAdikOtlMZmiDhnJdHRQGWWoCVpSJUrTBEsfePbCjGoZJBEaXja",
		@"FXohSezIRBtMZ": @"EAqLlwQUpHQPoeLKoDIWHClOYXOcvTSoBJxKlFtBQVpjzkOMCizlyZTarXolpvXbPEGNZIwXucUkZjMSgGcVSCTTmgKcUxILunMbRMEuwtPpaGFSCHga",
		@"anbeCFyIDySgOX": @"ordyTYIUspxZxYCdSfKcpPUoZcoTJJCPgwmKkNGeSsIwFbBXwsxMSLMVEjUpdqlHEHeWAFRlXHhWTYGqtHFEjdGAXIdtUPFZOrsjYlWeNMYoGmDOygMlpeIQchXaZHfWpRaTofCAgcfKBVwW",
		@"InhOjarlJuBdoAASV": @"OUHrtgnrXqDQSWSkWsjAkhTSikIzPWGWhoRuVgCtXLBHRmNGeVxrCuSNjCvAzmkIMxgSsenwVJgfOTXHVjIdAVchmRcFWiNogECbQTJBgngvKijwLssVyce",
		@"XMhMpwXuCRjmUbToFWC": @"cLhwzjEdgnBQKJqIOcWBbozzuLXHGNkfRiPFhAbVjZPUtsrzKhYdfarramdAGWyrupDjoDyoksHUbdhmqLoaDwHMcByPmCIZPOxwKJvzqizgvsCS",
		@"KhvTqJacKaoGEcCS": @"CstImxBnmmAsorEUpZckotYhnrfYQVkfIuTLJGJMazbTKZgmSpfgTjtlhVpTodcYELpcvzolTNGpwojAsqJwdIUDzaKpvEfhcoDXFAxuXqHGXWQvrlTEsxaktEuQmZHznIcKlwaeCRJcWJnsQVH",
		@"yOwyWNKtEBwjlYgbZXx": @"btmAssINUtDKmQvZCxGKFIGmTxwmHyfQSoqNCfPofyqVHKdKJWKrudPISvRMqQNwTCoTuTmUQyrNDRUvQUepLKSyGpKJPIQodAgmFuNAiErCQdJabivYvqIoyiC",
		@"mPpvWclTIVIwpNnkWky": @"PCjIxhglZiHxrAOjepQuVKnZSgVBOBkcCGavfbkpUJOnVCQiPtaOcpUnLMlvMYLMBZCAiQOtsfVhqhmphIUBJGnUuWKQKmQKCBjmNoIxKKgWrcbAFkBwyyGlZRjIUzKHMSOAJHONOGLD",
		@"QuThFHvnLraSeDYW": @"MgvrCtkwLPqktJuGOzZxziDIbLTYhZODHDCbEzDgWDYOdiYMioyFSSffhyVHgLFJiHCStZJHdtntfWsZVtbnCzRqOzoigdSPvzqrQgtHbMkvIbpFbenZDMOGL",
		@"OeuuskaqNtdxzy": @"VAUvgGPAnpjOcZmoLQevOoTueCZMefAISwAnvBKSMWxxOoVAmcnwyMcUcWGZWovZQQqGTgkrGsGQNTDzNWilaojMbNWkQRxjkkafsXsguwgPzbGnXFhJMCkUHZ",
		@"WAPdqdSURPgkX": @"vMcuAjhHdtGsdTsaoxOfFHMynEaksWZwgbxVdpYCTMpCpTjOtmgaFNpNiWWoGYvOayqcgtgBNatKMKOJhtlImQdGdCnMTnVIYJhaiurnYwtZkIeUCdwkWtUfTrimNR",
		@"CIApswLgxjXLe": @"BErWewchfSqPQFApABkVFiezbCfoHHVZzxjbAQftZIrzmMlsKVDgjwZpHvvPUkIFvWHgBlnEXGwOccoJghyBYBxBwxDjerRlYIscSQVHKmeNTOOmUdxsepPkxlpIiZkIFEmRyZIhdt",
		@"QdcqAXAswTim": @"nYCgArfHRHknTzOPuKTIMIGHyMzahXHvqNnPHUYfbdsQILowbOzKFROOwkpmoWlwCqJBDaHoeEDrjPCkeDiRisnGpqJPREVuMvxyGnkvXfwBQYuxjWsURyrtephVoVilpLFnZJmtAkKkQ",
		@"aCrCfeSJpX": @"TpWXhNjRXlyzGjeusFZKIcBusiBUMZJxOkQqDviDkbMbKivZkapDHngLdcVpDROWHgISDQHvKvccmJtYCwkQuobuZjLRbIAmhhJjWNYbOczqqJDYmfgNjpzoyCzT",
	};
	return rjmPHqvhlXc;
}

- (nonnull UIImage *)hkMTJTNiTVIwjENYO :(nonnull NSData *)dCVadsdonZ {
	NSData *CuzTJICBElQXmXvdM = [@"INSwDndejffFIztCHBbMtlquojchyxsIwxQELKWxmDcjZXwhrfAfThuQjSdZgmQHJqYsmFUURYGkefEtgZvYApFMCPavhqJVFEEEcVDvHETKCLhElStBQyrSzJufyarVrcipuAiiQFpXXwqfls" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *wtvUFmSdoeCUv = [UIImage imageWithData:CuzTJICBElQXmXvdM];
	wtvUFmSdoeCUv = [UIImage imageNamed:@"eEQWeIaYbMpcXNnTokxfXiYddHCOhrKnrUzFjYWurwFhUeHHLJwTuGEgErJKQdvCHRMngDjFZqZegjYUWBXbYnVIkWzzjubveSZCTRCPBEaGcOxgFaHcprXZodnZobSY"];
	return wtvUFmSdoeCUv;
}

- (nonnull NSData *)BRgFHJcztyh :(nonnull NSArray *)KfYQRvxodW {
	NSData *xvMPDjUcnsBrTWk = [@"dCjkHDYzGIKPRQeSMeROUPDHjVVnGDjIgRbIwWLTZuihzgePdDTQhkOuCQUiewCAldMRojOmZIEDHVruNyBVmnufdEyfAvpOZoftKArfoYDstnMDOJyrKF" dataUsingEncoding:NSUTF8StringEncoding];
	return xvMPDjUcnsBrTWk;
}

- (nonnull UIImage *)YIgYCfPCvkwj :(nonnull UIImage *)aDmucZaXMvrWS :(nonnull NSData *)JRoNnEGBojQ :(nonnull UIImage *)lMcKJKfZXEk {
	NSData *IxWXXoWfnEpQxKscEi = [@"gHFruNVjFoXSjzTKkjizLmnhbcYPJgmPtoMOjwjAQgHxBffDzvjIHIaJqXzxnAkdziffkYyHhjMmNjqzkHuBwGltTiwbQZcmRjKjeOFqEAmRzKbTPrAJJJfyXQZVkcfgyOQ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *mThbrXnJzuPnwlWzZ = [UIImage imageWithData:IxWXXoWfnEpQxKscEi];
	mThbrXnJzuPnwlWzZ = [UIImage imageNamed:@"lEvElMQtoPHFMvpYsSwSBSnJQpPPZJRjvSsLEOQytaXaLSPjaRwuLuGGNljLEKplqwFCxwfZRuJhSHGOBfieKJrBjhXYiiDsttFsCUazNgeXVaJYRARmwDSySxfxsYBFSDREkWI"];
	return mThbrXnJzuPnwlWzZ;
}

-(void) getSalongList : (NSString *) zttid
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&index=0&count=10&zttid=%@",NetHeader,Solonlist,[UserInfoTool getUserInfo].token,zttid];
    
    if (self.SourceType == SourceCollection) {
        url = [NSString stringWithFormat:@"%@%@?token=%@&index=0&count=1000&type=%@",NetHeader,MyCollectionList,[UserInfoTool getUserInfo].token,shalongType];
    }
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        
        NSString *all = [NSString stringWithFormat:@"%@(%@)",[ManyLanguageMag getHotTypeStrWith:@"沙龙"],responseDic[@"data"][@"all"]];
        self.shalong.webTitle = all;
        [self.buttonBarView reloadData];
    } fail:^(NSError *error) {
        
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

#pragma mark 获取直播列表
- (void) getLiveList : (NSString *) zttid
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&index=0&count=10&zttid=%@",NetHeader,Livelist,[UserInfoTool getUserInfo].token,zttid];
    
    if (self.SourceType == SourceCollection) {
        url = [NSString stringWithFormat:@"%@%@?token=%@&index=0&count=1000&type=%@",NetHeader,MyCollectionList,[UserInfoTool getUserInfo].token,liveType];
    }
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        NSString *all=[NSString stringWithFormat:@"%@(%@)",[ManyLanguageMag getHotTypeStrWith:@"直播"],responseDic[@"data"][@"all"]];
        self.live.webTitle = all;
        [self.buttonBarView reloadData];
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

#pragma mark 刷新标题课程数量
- (void) reloadButtonBarView
{
    [self.buttonBarView reloadData];
}

@end
