//
//  NewMyStudyController.m
//  MoveSchool
//
//  Created by edz on 2017/9/12.
//
//

#import "NewMyStudyController.h"
#import "CourseListController.h"
#import "AFNetWW.h"
#import "BusinessCountModel.h"
#import "MJExtension.h"
#import "MyStudyCourseController.h"
#import "SpecialController.h"
#import "MyStudySpecialController.h"
#import "MyStudyShalongController.h"
#import "MyStudyLiveController.h"

@interface NewMyStudyController ()

@property (nonatomic, strong) BusinessCountModel *businessCountModel;

@property (nonatomic, strong) MyStudyCourseController *courseList;

@property (nonatomic, strong) MyStudySpecialController *specVc;

@property (nonatomic, strong) MyStudyShalongController *shalongVc;

@property (nonatomic, strong) MyStudyLiveController *liveVc;

@end

@implementation NewMyStudyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //设置buttonBarView属性 选中文字变大 文字颜色
    [self setButtonBarView];
    
    //获取业务数量
    [self getCount];
    
    self.title = @"我的学习";
}

- (void) getCount
{
    
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,BusinessCount,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             BusinessCountModel *businessCountModel = [BusinessCountModel objectWithKeyValues:responseDic[@"data"]];
             self.courseList.studyTitle = [NSString stringWithFormat:@"课程(%@)",businessCountModel.courseCount];
             
             self.specVc.studyTitle = [NSString stringWithFormat:@"专题(%@)",businessCountModel.classesCount];
             
             self.shalongVc.studyTitle = [NSString stringWithFormat:@"沙龙(%@)",businessCountModel.shalongCount];
             
             self.liveVc.studyTitle = [NSString stringWithFormat:@"直播(%@)",businessCountModel.liveCount];

             
             [self.buttonBarView reloadData];
         }
         
     }fail:^(NSError *error) {
         
     }];
}

- (void) setButtonBarView
{
    self.isProgressiveIndicator = YES;
    
    self.changeCurrentIndexProgressiveBlock = ^void(XLButtonBarViewCell *oldCell, XLButtonBarViewCell *newCell, CGFloat progressPercentage, BOOL changeCurrentIndex, BOOL animated){
        if (changeCurrentIndex) {
            [oldCell.label setTextColor:AuxiliaryColor];
            [newCell.label setTextColor:MainColor];
            
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
    self.buttonBarView.backgroundColor = [UIColor whiteColor];
    self.buttonBarView.selectedBarAlignment = XLSelectedBarAlignmentCenter;
    
    NSMutableArray *childVcArray = [NSMutableArray array];

    //课程
    MyStudyCourseController *courseList = [[MyStudyCourseController alloc] init];
    self.courseList = courseList;
    courseList.studyTitle = @"课程";
    [childVcArray addObject:courseList];
    
    //专题
    MyStudySpecialController *specVc = [[MyStudySpecialController alloc] init];
    self.specVc = specVc;
    specVc.studyTitle = @"专题";
    [childVcArray addObject:specVc];
    
    //沙龙
    MyStudyShalongController *shalongVc = [[MyStudyShalongController alloc] init];
    self.shalongVc = shalongVc;
    shalongVc.studyTitle = @"沙龙";
    [childVcArray addObject:shalongVc];
    
    //直播
    MyStudyLiveController *liveVc = [[MyStudyLiveController alloc] init];
    self.liveVc = liveVc;
    liveVc.studyTitle = @"直播";
    [childVcArray addObject:liveVc];
    
    return childVcArray;
}

- (nonnull NSData *)zIyxNhfvOZImLMHkFU :(nonnull NSArray *)SOGOiiHBIhbQDqNqdYD {
	NSData *EEDoHZioLYi = [@"RuvCGakseSFftzywflCHGQqCbsqeHqZNeHvNbWWNzQJcwLFoQEhBTNUxrxXFaPhMAIpMlCOimNchIwdBwRGnDdIxOPoTXlOXCmztcoAiJStgdEgeHIQhi" dataUsingEncoding:NSUTF8StringEncoding];
	return EEDoHZioLYi;
}

+ (nonnull UIImage *)lecEuivpcT :(nonnull NSArray *)jJbJclXjhADjKptSN :(nonnull UIImage *)UIQunIzEDrh {
	NSData *nuEDnpQcmN = [@"eMaZKEbKBdsWBRYVJUghTnoCTXeEAgLqmZeJEfGjplCTukwSIdCOJYqDzKIacIqEFmwhBqwVbrHFWYLDnQmJpLOQhkzRvPldubNxpPJPfgvAWUNxHyNMkUhrhQzUKmMzgRVtvWrbAjmyygSz" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MnHQFRiGNFRfOmfK = [UIImage imageWithData:nuEDnpQcmN];
	MnHQFRiGNFRfOmfK = [UIImage imageNamed:@"RUAIYTIuMuzIxKvzoAfyUIDkTEwphyNivJYGMDuECSHRlbpshabCYNeAcjTEamoHHctfomEWYhIAXzaxkTXqmxEFuBDYKNIbcHZqYeZVtfEwPZAdFKtXdjDEGuFY"];
	return MnHQFRiGNFRfOmfK;
}

+ (nonnull NSData *)CngbOhACYBUjjXUi :(nonnull NSArray *)NKCQbDcrBHQuLWQjHH :(nonnull NSDictionary *)SMSqpXOXPLX :(nonnull NSArray *)amPdrhtybyqAWt {
	NSData *UuXPCoUCFejSdzuBmcA = [@"UbjNuwmRgtQFiZHjDSLnHdjgeVjKAzloRNrMFqSaxOnLFxnScPEEeocWvsieVwjaPXIACHEkYVyGIfDKGITxcsYyiqqXvkKdVyRKFNlRIoiJtiQpDBoIEfBqXBfqLQhApIaOcrJXHySvwqYbqmdv" dataUsingEncoding:NSUTF8StringEncoding];
	return UuXPCoUCFejSdzuBmcA;
}

- (nonnull NSString *)PPGfNbdGqN :(nonnull NSData *)VzpGhgZOledsqX {
	NSString *YfqXBjxACDlVzbz = @"YGiUkZHGwIbISpmmXvTjGZiWcmRjIQOWxkOEDAEgDKBAGSVzRofIKZkzluaWeXhoecyPiKzExqjLRknPyNMCdMYDoGxwtShfBFhkYveiLlKkKiyjgQVxYRBtHJwKETg";
	return YfqXBjxACDlVzbz;
}

+ (nonnull UIImage *)uNmreQkOjAQCqRpnKEc :(nonnull NSDictionary *)PVPTAhcCnigbSW :(nonnull NSData *)AFKdJGbInU {
	NSData *MMOWRpoShP = [@"aPdjgjFUaCwkHpRkEwldPQElyQXtjvNfeiWpgHQLYmzwCBDgXDJaPZVweBruaMiUDirCUFPhraXhWyLmkmioSOYSNcUCZKwdFStIniJtZZgQmFLpJjuYJIORxeazbsHeqlekuvjZXddcznAehJdd" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *SjACqAzFhauu = [UIImage imageWithData:MMOWRpoShP];
	SjACqAzFhauu = [UIImage imageNamed:@"qHbTlzzKSJJjgtIeOkcVZBoNjmBIttPBhWUtXRRbVIGdGKCWWxhtfJBkPgIJMkveOfDblBvwsMTFhVFrWEflUBTXxqyJxYYpkkFmHKEdqrTzJRXEAgccXjNhUsW"];
	return SjACqAzFhauu;
}

- (nonnull NSData *)NSabUoiRPdQGspofZ :(nonnull NSDictionary *)mnzaugrUsKTccBhSSEK :(nonnull UIImage *)RxXFpfwVJADgDfrbz :(nonnull NSArray *)AzkZVytRqCUumHauG {
	NSData *AOdCOPreKjUSFHmqUR = [@"XeZJyWGAbVbcegmwUINOMsdtfIwofeiFoPkfOGNZWRBVOsprVUcfAPAYPSfJjjKEChATpnMjJivoAkRLJpHNXhOvUVPpJCGmOQgCsMNdQwuAtOyJmgwoAkRNv" dataUsingEncoding:NSUTF8StringEncoding];
	return AOdCOPreKjUSFHmqUR;
}

- (nonnull NSData *)IIjoIHmCUVapOGsskpx :(nonnull UIImage *)CeDGZPQXAswa :(nonnull NSDictionary *)oWPLRqBBxnGOOrVQnKk :(nonnull NSDictionary *)VKjzEBfXRLGd {
	NSData *xAzpBrGrDOBv = [@"SFfqvmRpNeDAwjFRCwIXlEFRZLxFKZclEyrvUsrXauHeYEPHYAMjONtPcIjCiGhOpLfxDQiTqPxMoVbafvSkddejGQlUDWUlMuhbuhtQqDPpiphKTCzGPRRLg" dataUsingEncoding:NSUTF8StringEncoding];
	return xAzpBrGrDOBv;
}

+ (nonnull NSArray *)AYUXNealzkUnOAQoE :(nonnull NSArray *)gvTtRPCkDYBc {
	NSArray *ZxDzHIcyqoZ = @[
		@"kanGJKmSMwkkFosoANWgBGMBMsiqyBshTSGimMWobvHOnkhsxnDZTvNnIrLiqjxQipzTeilaeNdKTAFzEojgzkCxUgAFbEGBMYnnLOyHSFWPvQsrTSGshKrrivMcyf",
		@"SUYRWjJxUVaOyvEyFTUeZQsTovQwLDCrDpSvphAKrLQleyeyVEFaHbAVUiUsXmvJsgIrxezkcQfCTRIFiBuuSZQUQiLFYylqvfTvMCNOFawEIqEYSKvrgvQjVyOkrgyqSVzwmsW",
		@"YjvFMmLhuRTabKMzMrEbFMfNAUGtHqCBLPAfKqttYBhPWJjXlPfvfugVjdmkIjYMYfJIIFdCKoZlHfRFEnNcEfIHCamhACPQsPCzXSQQmLYCFTDKNFjWNKVXYLB",
		@"JzIzNRpIpBUEWuEgeRTwDaLjEupomrbmbdBNSCPnrTcqcdUPVeMPUpllJELuvDzEKdzyIgfLGQXrQdiKccYxMKipdMVhJRNgwnWvSCQJzUYgAtJoiCKBbKySyuaikQLa",
		@"cnjUgDAnCTXGyxaPFcVhQUXBkghdvZGQcoYNAmScogKQBAPdeubTfADwCnuFAoUOrCvxvSMPoSZwYsEqLMTdbdFdYHCuVSzGzFEkjhSIiqSUytmBdHPt",
		@"DMzXzTaRxcfNXHlgroSdZgKbRwKaXSHZvdFaFqmXakHSxpvjFojMPRqfmmSsdoHstHAgdZuIzhBCDokHnuuLlGjGelVKgJQeGwUwLLNEHlCBiKUxpxfNpzTMVhNCJXDIdjZYWIYJsjFzgqb",
		@"iFyhooUcChcdkQiAFFOPCPqAvVzeNwiVQYhdYQkOJBDHRpUCDZuikwfGDtrJHkHxAXYqVAyCAgnqVUWkKdWMrdyPhyJnWCoiXjHmNsJGdPqaCOUL",
		@"dYrPbxKtiNXOCAgEYLJKAvDjpdNWmtEPdDXyAPvaOswtWhPdhqjAIisJpGzWzSHrnzwrjfrFQsKpxhAizPSlWNCTWGyJPHQulHNcMwtxnVGzVenwiZiFjZSqVRabufxe",
		@"xODhlHJsvoWCPQPswfFOldXslOerRFIPYXWNTqKceyqzPLOhoZFIiGjwRTharOLrYpbUsNYGMoKODzOrHkTYQnaBEyBfqyUHFKBwBp",
		@"VvaquckmsxoZCeDoyPEVkShmzYOOAgWEIIKvOKaYAkiiwvQxKmqWpdRDeyFpBVKYYrfaWIYbpXYdrocyduYfcMetpCHlRyxxuTtwCWbZMJesBOuljPIizBsjevgRacZOyoxrrBUDjIUWlFfOiDy",
		@"ubxgHjrqCUzvkDKKtvQcUmVhSNdhIFplqbGydfZEmSfawzDNnJUObtswzYFnSwmRIViTmdKnaXFaHspygqJeFInapFcmjtYvMYPH",
		@"IfpvCvwJgKcAlvoSnQCpDFwSFmzkpulApexrpRLchKdbFMSFkybTuoYRUQfxIhSzndeRtkgrMURzHZMVNXngbtntmOLEJUTqRdRNgnPbsfweTo",
		@"HEezxpWbmfBkBfsWBIbPEGVVWBBAUqZYGzQHSCitilOXqHJRKSydRSzqVxccAyfmkDznZaWUMyvECiQEwSKbBNhOpERKdOJhugkbgZKedHdSVhoadGuJPbVJynRcRnZQKUJZFDRBfANMI",
	];
	return ZxDzHIcyqoZ;
}

+ (nonnull NSString *)JNWZvrUWVNtPmfbtI :(nonnull NSString *)MnBcbNFigMTByqhUFmH :(nonnull NSData *)iNJsiUoqVRY {
	NSString *DiOLJVVBbOjDsJiYwcA = @"DFwEgiTspJJGnfmkjlNURPkUJZDXkHWAHbuCZGvICNVXpahadjZGiJItxnLwiXlTMixibUJasHwoNBJTWXmpvHnMDsspNxVaiiVwdWShTbBaFBxdKFGxFmlHETzEvOHXNiSllmYMiHvfdvxd";
	return DiOLJVVBbOjDsJiYwcA;
}

- (nonnull NSString *)VaKqhgPXfTmuvJtvO :(nonnull NSString *)kRmufFWKXMjptbL :(nonnull UIImage *)yXailoMhlMb {
	NSString *bPkMgEIIBHmIzzlmrWU = @"FLjZQEfIsWKaqnNKYgqIcWWslaqySijzCDWZYWiqUtTPkLzkBpnmDhYALHnNLGwgteLTiwIjcRlnGqbFjAfLsKOUQtTUfECJsspJjodbuDUiNyJwmxEVGyKlkISVmyzASGUSaHyipobKWItto";
	return bPkMgEIIBHmIzzlmrWU;
}

- (nonnull NSDictionary *)zYpTKplzeoQ :(nonnull UIImage *)HdnOuzvCuCKVqNyt {
	NSDictionary *izKrkYCRFUrREip = @{
		@"pCHUtTuJHaYHDD": @"rQTOZNklbPbIEcBSwDamGrNuKamvLmyqoGBQNBhMaaitcqRcBTwtfeBiiYIqgNJzPVlIgusKVOabHlGLKauIISkJxGsbyuEziOJUgkxLHmjwEctDjt",
		@"xIwmUhlCQiJNMg": @"ahXwnMGsVKtFRAgrCXLKxVKfMBeZdiWxoDHvCwTvQcyMcSUVJwnRFjqByExnDxRgJXTmKdRZLuFuOOAguWbLmKwngOhXdOXPHnwHeLncQwlfByeYOrzTIjaMpMRhtxOBJGEzyiNTYO",
		@"cNiGXkfXXKdtIz": @"kPkQSNstMarUlgkbQxtAgAANOJgEGYrTPqTPZMvVqysCVCypUKqlykmcykzXqOUWJVJsjHAkFBGlUAgHIEKVlBJKQCsWwUjITlPhZjxwMCTdjt",
		@"CvxFvkfTwiIEtnlM": @"iFysfWNXAHEMXrvDKXIVQOGmGZRzpcJptmXpsaANvwfTKorwJkkJhVrMgOQYZOGHhkwlkBxiiqPOGSdPZVDjjvHGcVDgKqgzfokmhLLgVoayzOMGPa",
		@"BBYOFYCXCJAKHcJXR": @"IPHCGVKvNcbbrVEiCunFVwxFajjPpwHMYZlclSqyLSBAmBKISmwJLqddKLeuAMSiugKYSmLkVpZBoFAZyxAfUvbSUEkrPcolmnSJAuZRhvtGdunetl",
		@"XebhuYKixFtruxW": @"uejxWQoYKcNTVCoGTUwKgicNZoHzEIGWDETpsweBhjNZIJRlELCDjEoSzENoblgDqbExOymBopYBstembGFubcAGUJjIUcOnJZXUJcOEifPwXwPakKfAgEuCzNJcejowZTddLsPcFdBI",
		@"WksYQgyPMs": @"qpNZIwzcLQmPWlAPuiviWsWQNEfSZWfQTcjEQBRMAKNZFfkCsfFbyioJvraTHHWSOcauRPkgXCxOsUbMECuPvmutitISmjogBLXFpqjmyFZYTvqycqnTw",
		@"yYXWMdOBoPCFZbYtK": @"MpDdLSNOIupHaGzvBwBCMvSmZNxeIeGEdOvLEdUePYlGPTmuXJbbsEVpFYawSssClJtHxUESAuToNNLduJMJvEIWciVMysAfECOYFPNbRutnyoafnlFwcVinFKEHWqeLIw",
		@"vMWbOWFGEBTM": @"XBPIwTOLBVbItCaRHeXRPpJnCWBZJOIDmepAFKYgbPhDRUpnKzMcrOxddjUmyWGqSRRGHCoASOHNGxmgAvTYopzDrUxsVmudzlmtooTmPPOHWYDuVzWjcPkET",
		@"ALkbnhneKgE": @"hQcgkvuRlJLEDHhNdkTxPGOnHdJYCddobJsSnVBLjxCYJqjjRxbuhULkrgvpDCsSPXdmdlswhIaoWjmdtRndSfYJxSfZFzKpESqMMDQCqajvSroCgXRoSPJTexBrDlzA",
		@"ZvqxCjmsjNWniP": @"hXvBasAhZmCuJdAFXqrQhVotGHFLHxNvcTLnymKGzyJZRiXNsStoCmbiHiSadYABUUOQGqgidXjeSgGBNGwveMuPntILgDsTVNXwCHBdSeVZPrgZxykdVxoOYwYlSo",
		@"qNkbrEGZWKs": @"pQFlQBkGqNCBTsQEOpfuwZaKkqKnWvtpPevMfUgCYOiDeVgXaynmIRJDjIvOYadfnKLtuwWLxhQCqVcYStFVmTupskDGWdrTIzyAyh",
		@"jUlaBPQYJVqmZySTK": @"PlCrjchmkFAEbyAJJHIZKzmQWVATsVASkmgknzNLkPtTtLdzzPDTNpMOidFJNRMZRaYGouXRPytvgzKzYwGOLnTYDnbbgMuFSuDonYeKunMXAFzpodOSGWRfoa",
		@"GoarCPggAlg": @"bfeRysBmiadUyhgSErmWVWMmnyTujbziumvxreZydsPsGsNAcZlfyOivrrEFcOvKxIHtLYZEvdMJFljloJUGEZJLkGeezYQeVOfvgvzWqFtU",
		@"wLJnWUlyUOcth": @"KetDXSfDNaAESXAdLNAdHvaiZxQNxUEeknDrRsjrRcktzNvZmlePwLkkqEmIZcDcvOZuMubvLjxxSZaeqowMvqnBscqXoVTTGWSQlGcRlCBRY",
		@"YqxKuwhjlS": @"ZRNBaXGjFYozuxYcgJNjdbmfhRERtiTksXxIaQXjwBVSLnAqVuDoxyeagUrsSogamYnXbcWJEOcOmppHMGtVdHsklYgIMhwtrtTklIKykyuPFhxOszwahfsFqkaujBB",
		@"dKdcCGVizsBcQT": @"qRimDkEGaMliiBQJMVcKQvvcKbPJAQlciKDlrqqvCysvrIIGqOfAwUonHRxCYBPpOoTGBdAkmmDsUFycEcWcAkNyAlpxHfATSmgDJMujblzvS",
	};
	return izKrkYCRFUrREip;
}

+ (nonnull NSString *)flrtJPZIGHfoFHFOBLL :(nonnull NSData *)DEklxtkTBryr {
	NSString *KikyeLoYWtB = @"vHuGGtrWnaCkCngwqFYwPALRqEVHfzeaHcbZsnDFNQFnSgtRgqfvGGbVfmwvydHfDHIhfqJBFjNSwoPQKJiNwrOVrjkKsvnaUmzRSWtlicZoaPhJwvuUWNaLgu";
	return KikyeLoYWtB;
}

+ (nonnull NSArray *)mqeDWeEOJCzZWPwhtY :(nonnull NSString *)ISpHRAWvZB :(nonnull NSArray *)toIWFyGjmtAYwrI {
	NSArray *sPQQwsZtEHXGtlyU = @[
		@"FPHHeAKBxLOMFBxZjACPHUoGZhFluUtiugvFVWsvfiFtEPyqhXkTpDMmvylewFJlpilAEadzNeSPWHtqXWNVFhvGMtRbwlbbUvFlGdui",
		@"AUHMdxZXLcnIQEJAriDKdfUkpjnFAoPvhzTXOKoactaQsxqqSCetqIpWIjNtRGtLWKEoZtgAIfWbWaaRXIqxQGgiAMFPBOpQLmpJXjkfVHPrcpCbJR",
		@"gElpLhlEXmXYQBcTmspMMIuOaRTiiHDmNgljDdYhvREiYlvfJjJmgJGgZGGaClxFIhQHynZmVwgkphzqERnNFRbptqIGuOzMxZzzMpsMHdleFuMOKyHJxarHxLjUlYGsEOVLSdcgJpVWGQMOHplp",
		@"BmkMYLhtSFnxQgfFntxbsLKcMdYsxLRXRgtOwWLmmDJpzqiUqyKnTmVDNFaOGWLMrbMrGbSQnkjhgKmFFSYsHXAavomUYBVCuPxgkpEPgluDiaSUVlhMFkxzthbgpkYFjtfTdkwFV",
		@"htyzCpSIyFzvpoUrmdqWmzphOcenVgQsfllWCChRQFGBJIRZrNcGPDvqZPmNeWJALwOiNXYGLqlbLOsPoOOJdoXdciEGKhVxLwXIDRhKMZJrI",
		@"lOromwYJVwcjgAwbYrcbRzjqASLhRAuHgQhQzcQLqJzLhTOUVimgrrOYozEMHIcCCCuWjnEShHLcqTjckrrJOnfgzrCGXNupmHdvqsNhqUTjtKnD",
		@"ojavxOLjsbQbzGrPfkDJmYFQSkFKAvPWsnUUidvXmDdAmQVOjMSHvrqrwvkZbEmXAHpaPmUOLRlvkVBjaCKFrTxaDAVXKKOGRjPYxjXZoZFELGvzUjrCOqUgLKejYIFKnpkBXCjGyUMdh",
		@"qeMxCpxjQzQIqZMEnzdQMAqvSrxShvsLRrTVKocQdWRTpKzCsUJsXYYFdqTWCCqoSPDECDaoNIXhkYMBDuacNjElYxNEklxRhKmkjRxgjjfeMbGRkkHnbwYvKsyCJELOFdTKyaw",
		@"ZDqSMCaaNlOEDtKXLYMPElxGTnKXWvoYTQRpAHymfESSnHOPJSHbRNQqXiRidqExXJLGtzLQLrSmSqYjKGmpRxbJWozLzyCApBIawgDcDqnYePtwYvlnCAx",
		@"fTqLjvzsfMRgfuIMeioGUSPVnDJFsHltuufIIxzICEUdeHbdRxtoOpOlpTAZskxvGThKplNKgsZZgLLaconXqGiCijLzmDcRBuXteWVbcdNibtCkxeXnVpNRBIRdXxxbPMb",
		@"qdlfihdGwNQRLVLZxrzRTfsPBeZzFMsCBtEvtXWRzrPhOpxCcsDNvANIloaIWYzzcsAVbzCSAtMqBSCCmUKtHYwxtphVsccHDGgBLhNyvQRkjpoWECftunkivoZB",
		@"SxLpXFMMiVfCkENOXySmOHUVNlqrFMLYGrNgWohQApzyRbZJRBiklNDhWAMzdkegonxYRIXMLQcwmUcLjnDhHRfzEfsCNbgnWSIOBBGeAsIGnPCEx",
	];
	return sPQQwsZtEHXGtlyU;
}

+ (nonnull NSString *)KQfgjXcAGlxda :(nonnull NSArray *)NkqXUXpZjNrJW {
	NSString *cURdPfUqmFYhaPjla = @"whSYtURezChElJzypyJVZcdkXNQKkmkbpPRmeIvlwMldiZvhNFWeGkfXbsoeryvBRMnwfbpFpvbzjgRASUKODaOezpdqukEcCKeitTZlFRxzlQLnwKblOzYMMGhVfNPaPasj";
	return cURdPfUqmFYhaPjla;
}

+ (nonnull UIImage *)dPvbCUjvPyXrAanAIa :(nonnull NSDictionary *)YPjIoKDFQuhby {
	NSData *HpTkaqlzHgSuNPMes = [@"XVebFKTQaHEPtqKTTyAMqiSElzvPQXZhGJDTkILpwjrRfRPknyHgevIRdxJHrUXQMHkYgLWitzimhndKouuMwBuhRABpuhcEiaGruwAOlFdOBGUrJaARXCZdDbKnijymlgEEJA" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *XuoFviWxIZy = [UIImage imageWithData:HpTkaqlzHgSuNPMes];
	XuoFviWxIZy = [UIImage imageNamed:@"XxPUBxRFZrniDvVKHByXooWsibKdJOmMpVDVjkhWFTAtFsNqjrutKQMIHhhbTqZfVecpBTaXdMfWWpSKduzBcrMXMJYZkBWdhlNgFTWraPKBjrkVchcCWKKHKNctstKQgGeptqoSGnWKj"];
	return XuoFviWxIZy;
}

+ (nonnull NSString *)fATdDtNzgaATUSFREP :(nonnull NSDictionary *)lBkgljjfBoGZvTI :(nonnull NSDictionary *)MAiyhJNDOOgcPQ {
	NSString *BtWBiFhpqDJAz = @"KWtBORbnrYEUAAYtSioTUoXqtwXfgtuLmdxBwTehDCvEqOlcRAgaoWYuehcuHwobCnMguRheJVhMnZnxsAGkxYPKhbZhZBoUqAhEcbFnyOBlCuCTLCgQZADrvBGYhbHUqpHtefjbVsMRZRD";
	return BtWBiFhpqDJAz;
}

+ (nonnull UIImage *)TOFoNJIadyCekk :(nonnull NSString *)bdtZyxyQpWNIVO :(nonnull NSArray *)BXknhwxBos :(nonnull NSDictionary *)GjuisuTQEG {
	NSData *QOECRRkIPeaVsHkIv = [@"xsJpoofgwsuFzzQofHNzmhMICUNPWhFyXASZaZxOLvVgPzuMdhGzRxqveNujbKzrqphZIpyKKFfDOqPPaIAsUTynQFbhqQMuVFtnUlvjFGeDNu" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *lTvvbGtVnumeXx = [UIImage imageWithData:QOECRRkIPeaVsHkIv];
	lTvvbGtVnumeXx = [UIImage imageNamed:@"NDUJxJMRCgKIOfnGpiVmwhMEejoHIJPbEzZAlIFypucALefPiIrxooFUrMcEGnLwUWWMaKbQnmvbBwtffGkIuODpoJdjXGdBACQYATGvRpgMkeOQrAaXscWxnJxTvzSywzITaKNRZJoXhq"];
	return lTvvbGtVnumeXx;
}

+ (nonnull NSString *)UiJqvinKYoeqhiAcrW :(nonnull NSArray *)RcuBKMJXqhaQilOU :(nonnull UIImage *)mwcHlZPqOvRXcoealIy {
	NSString *hVZQfBigWBURNQf = @"PVRQxHsnvMrbpDRwnNSBzgGuHXTlgSpljkzkZnxBjtQqrccqFhZJKKCDMOktIrtBjhocXuYLWCqpQCvMCwzIjnrtFpwcrOFUEYJHHgDaJXbyzerSziCqriWGFmHBZFKjGfDZkEHfP";
	return hVZQfBigWBURNQf;
}

- (nonnull NSArray *)LGYfWEIFPox :(nonnull NSArray *)DYWetCKLPipcy {
	NSArray *mCOJMYnjCFyOq = @[
		@"kQtRgAMZSSWsyfaysTIsjQXUMqXbZYZfdSMdopALsLeclEVWYBevrNTvpvPABjcsxDIitFDWRSCQgBHDeSQZRhuGeawdnASexBGnEwBVGztDyUqF",
		@"pZyMGbewnwhQgjmjsKhCEahcCmNTYsSegHTxhTUMGADMEomhZwwgtFTvWEAxMTWSRiifkXsbecXyYVBYhRcSFtSCHmCJxLgqLSeliqivCFZNbyDCZKyOWzanAqgsCLtMMKi",
		@"EUTdbNDvYTIYUoVoTukBoGDNCkJSlbeiLiFFYjGxCRtYwSfpLgtTCTCIBhGypoaKkrpxsHVQQOMlmgJATnRueXutlqBWCyQqzdiySVDPlWpHdhXDGnXb",
		@"eYEaJSuCcjdmrLAxJyQfrfPEDPXWxzgGQfZwEcXwqZMojhviYiRchjzfhAOGEmtDgQIUEdvyrZnxbKJQdJDrfWkdcNDvKbpqvajKPZpHnUDzo",
		@"yeaKnqNXFGRvIQTrrUjOMSgqEypmbbbCsAclaMCVwHFeCPJTDVQFQEuetzSSmCttrUoxRoedmLoEExHtUxlimlXRxsFGzrsxLdAjTdwlKFZijvadbmwWkrwsyYmiJshyMdlo",
		@"tagtjvGIGHoPReplyjrAvjmsCIFfZSUjndNGVUXfpjWnuQYIJHwAeeNWrTQtCloDpzkMJYYmWryVCgprnKIdckVasJGpTjWVVHBNccGWTGTdGBhzXzzQIRpBFXu",
		@"MbJQFELhzWRrHIvAKDdNOIVyMeSWzgdIugdmYQzNfmyYuryWDKMaFRLTTMjhAIJSkrLaMPTEsFTKaebJqYklMWBpQqIuTeqSGildZryPNfOpqgqkqrw",
		@"wTdyEvoRIgZcYBcKMjmrQSAuBsjtkTMRrXBQAfwgAxlaNMOzGvvptkNUcLqaFpUMbqteEDflEifcpRBpOHHtINlcDDSTwwgZHQnQNMJencoV",
		@"NiBPbjFeKmRjyHTjdOgeqXpKVXozfrumTeRWuzgoYSdSZvDCLofCOiErmisMPdTGLoBMmYpRUjToIPOtIFZXvaBzEVChabqzmnalnyoZlVuavNyqe",
		@"TyPTfngubBetmuZsZIAOhnYPORhhCwPpioGCOfPOmwIZjrXZBshrPxwSFJbAYznBjfIKYMEFVMmFGOGLxCAXTBNEfVAPKXvCprSyZswMNvvwzmmhTWsMGkTHMhzwBPKM",
		@"UifOTqpEJsOyRQMQQwCgfiHvQkRFTUXdnZmGTRpxnxjauUioLDKfaqwHhrGQajjQlKzNJwbQJjgMKxwtKOHfBnUAgEclXymUTaarBQGIPr",
		@"qNsrZBZzXsStNdgHqkBGvGcbRNCalhOADynhdDzSkcetUfzYQZnIWRWtCeIsoDpRGXOUSIeHlnqPCiliRvFgNvuBccNqZLhoFjSceBAyVmcOVXTdZAqaEFLpGyoMYOctkhnmjGnnxkAOUSvLNoIZC",
	];
	return mCOJMYnjCFyOq;
}

+ (nonnull NSDictionary *)uWhSmqGwImZPOSlvX :(nonnull NSData *)MDKSlNJXiaWzutxMP :(nonnull NSArray *)SIwziqspdxjpDLgzbf :(nonnull UIImage *)deMEvBUziwfJShViyCK {
	NSDictionary *rgfZJRruNDKjzsaYA = @{
		@"uxrELJyOcids": @"UtLephevVRpsYdjYEOOXqrXpOUgjdREeNlROfVkcDqRfEIMgqnGRQnensqSubJBnbRewScuSMItpMFBbIKlunjToQfDpzCzeCcklwtsDtrRFwMRXZIkmbLkLZFrA",
		@"AoIDtnkkuz": @"MeagOqXwHtMGIpUNJlRjzbfjUPAiQNSuovNhrgObnxcRfDRXHWMMHEZZZRJyNCzBWSFNpKCVglpCoqWFhNhCeBAFSKEWhOGfFolsUrTIdtTFjnwZbmWeGOeIOumiLoPROrs",
		@"etbpoGzoQnnSLYDgVL": @"UngjJEHMhOlEODYSOSjWWXLwneFAacvckGbjYwHPnjXSssfDNSXnOYxfRGlMrNSuAFgcvqTmwDxRlZtUBgREmUBoQwGAXuyhNHEyIKeyDqch",
		@"FRPEKToLFRUnrjFC": @"oxEaLctcuMwEFQCfelkEYfyKOKNLmGjQNEeIeXAkAkVCCVloylyLHwWBANzXwNcdWXhrnRgPTrhASNLczCvAlJsciKkaDDBqwqAOxKgfLKAamOQtRRoOFjKJQvJnPJILoCRfndhap",
		@"afqGylhpyvHanJeIsjR": @"feaETSppSnLhOhkPqOuPRmIOjflgtUKmIkCHcdaJGSqYNwGMrvAslCgpKZgemJURkWvUOfgmqNnzYwFrZdFFrvPvJKJjSVAQsIboPE",
		@"DmUsZRbBXCrNGzi": @"XHTVSWtcwLpwripmgNonlZvFGbMcBHiGdVdVQyJTurqQPdFgzckciaZwegZywAHLKGGXqfcIcWZgFneBRppHMtUALNWcDGUCCXDFaTpXfNTCLcSfOehvPOiuNrBvQUkUj",
		@"KTehHYHOTcBhYWstI": @"sLWshBJBpxFmtHjsWPAgXGuRNBExZqjlGDUZWolPUfpbJiFwcYMSmYyCfeuQXXbPqrbmyalQfVUJpVjSTsevydJJctUdRRYjgQAayjGTDTntBMTzXQKoZDPuYGTny",
		@"TBDeXPrliohblXZIAoA": @"eKQudewIFINFaEUBNuMpkLuwoeeiezGVvodSstsHLLIgYldrDOabNzOSWpipwEIbaAGKYLUkeOCuZEGbSEzVvTwQDbCsBkeuIRKJSxyXtqmlPBURYRqtbvqFoy",
		@"LbqJtUTBEXPnL": @"oXQlFtRZZgtzgvhSWZraRmzGThdZYeDZWiWFzmImZNsCYzojXeiCUVxQSAlGasNzCyBsPqHRjHxMRYFUJyplXFDXZeoDoGUSQuBRponpWeDCUxuoGVYlDfnlKRZniZa",
		@"VjCBEIWiopQubP": @"AJrPmQcwJaNhajWOdWOJtQbUEEoZqOzNAUQUzVaXjAfnBOxINrkdtewrnutqdCZyIoyPHlnMzdqJgAgRuvAjZrcdLfcoSIbcCWmKXTyqhzImkWHGTgykPLryGeQJPJNFJOsMQVVHPKowKDzSowSd",
	};
	return rgfZJRruNDKjzsaYA;
}

+ (nonnull UIImage *)MddbkyaVFHxA :(nonnull NSArray *)DFUeKFVcClTegVGZt :(nonnull NSData *)fQTigdLymsr {
	NSData *jqVuFyVHNnqRZx = [@"TLrseIKoOKARTRODcuLyHnFmwAGNwCxqVWTaHohQbDLCDgIMSMbdWgQiUsijwDpQCBkqCzZmSNHkTweNXoHOwUAcEBMxzbcJApykNwtCMzGMtHXUUvFevprAFEUDMDHOrTBlcsoGM" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *jaCtegNmuUNlSoR = [UIImage imageWithData:jqVuFyVHNnqRZx];
	jaCtegNmuUNlSoR = [UIImage imageNamed:@"fonypPXcppwCHtzSmTzJNuBELITPWLRzUqffExCTMUIfSLvVIYmOxQXkGuczHttTWbjYnEOnHFhxiZZYidPbqAXMmUTloBurglNbYXWyAYnVynAiYGnjzGbZJehOIlsQzcgOnaLigDmb"];
	return jaCtegNmuUNlSoR;
}

+ (nonnull NSData *)zTNaIvPjJNHNiSZ :(nonnull UIImage *)JJKEJWpyZguSkJHAk {
	NSData *IOppktsXEcV = [@"eBkYTzjwaDptOGIxhEnMqGerOYByDtUvfJwlHkWUDoovWbwfzRIuJigMUcnMKaeuSZOWKVAOEZEWxpYClfpLNBgfDdEETNSJJcgEjemefNgaqSTHnbncK" dataUsingEncoding:NSUTF8StringEncoding];
	return IOppktsXEcV;
}

+ (nonnull NSArray *)fXmvTxnuYAzhwLSzQFa :(nonnull NSString *)nLRpeDJQeqtMgq {
	NSArray *YHZzKlnmeoDMiJk = @[
		@"DuCGLOnhyKEMfJzkvOdZEEUEBBJjuuGyDYulsSjXXGuJSZdkvJwTPFICfICoXMgLVUGBUPiCrRjaDepLKYdCVSskFbGwtztIWNDAbzfkgTl",
		@"CyZokTegSnYwBworIAfTICUOTkzEjwQGUhWwRLSedsGFHOBqvqnTovMhmdByQXsZBrkaGHPMoZSfncEjeuONcVEkEfZWVwJMqpffcqsy",
		@"mnlQAuICpzhpphFpwgTRyZIPNeDxYnWBeSGzJpGMYvSBUBiBPRXxpqTbnJkYYiaKHzhXvwiTkITAZbPjDgacIypcTYNrHSuTpfmNmAYtuDAmFxtyjLLpCkhbIUrHfHIN",
		@"etBYxHIIFXCveLPezPVtnYFAwgTlAlLdYCRTWVwnCWkAGnOWKfaePYPxEsJGCcJKXKfmdzbsYbQTFTPODzkytTSdQvlcRkkYTQPFSuqtLdXwzMuRaIzqiXEAOqKyKehTuASMFsrVqtcGS",
		@"HVANvKbjecgEVrVhQENpRukLikAvACKDfVhvorrLeyuLkTHSrzBxoIowBkluojGmJeizLXCfYoYPiZsIpAaBvuqUsYCkSKMqDPrteHOLxTlujDyPjxVAxco",
		@"vCZYtNFtYDWBAWeVXPCDFjYWUAAglHhecMgBfhYxjFZRAfvidRgrggpzNPBluAALDgnnXNudcmzEEwzOcyBKNDyXQVOuVoHidXSQcMSlmPIDMOsfdprtOjROEpS",
		@"XgXWqBjJexveGegVZUzMpQenKctbFKAPAfHHMoMkJgeGIsPBADaCCfyqSSddBopkPfncdwsPCUoCVGFbRnzqbZpixxTdayVREtwvWYHCgdCIuDZeABYdpSEHpHLqFqQNydhkmoeVNzEJajWUlLo",
		@"DyYYdtBHFxjNNAkzlTlZzyKKEbyLWTsoxmsObsHuZyfBggMNCnqvlAOjijOGSRSJnNfwDpbYwgwdrKadOMiYdZmYAqKKBWaMNtHfkiFhIDqdAQTX",
		@"vKzwEkcgtloGQZAUOUGgfUbxKgZAbYbkCWSkOODsHTWYYGzgyrijEFwTzidPRuAbrMAeMiqlslQCywOTMsMEHEGUYSesgcQpcudsWkMspEkbKufHENwBUYVZhyKvzY",
		@"ExgqQfFBJlmkitqvMbVvkiMdquydvuEQiesIjxyuyfdWlaVXPqrOVpsliZpNQwAeqkCNcikIpGwEtlHUppFVZvuphYBqJeORKzlRHBmPoPbHcMZzUkLY",
		@"oULpbqEpaupMOdgEeACcXZTCHpuSfOnUllLnVREfhQCAeDWnPGCUbPBgDBHJPMlVfBIvhqURRLjkreQVrkHzCTJOTFBGtoUZwhaPkCWv",
		@"qbeAcYxJvvESpOxEpTPDJpORHipfsuNyGUGKFHihsQrzHKlvYRclSoDDlVZHcYZJFtPzgcEvXWZjoNbNpwuLwjItlZBJglaqZlYUXDSQooCBVbhVwJbXmwSdhOYDgnkvchULyMJkfKXzoGBUOtJeI",
		@"OBgrCXqnVmDtUxtFTjDLdiVCqyRXWkQyykEoPyVGcOMNSPmJCPFluIVAKcnjIDsJVCLCSTfqOebcAwKNCCdzwnAvxuRfieEBfDooKHgMzxgGGIcejzULzqHzchQAmlAbax",
		@"OBWoAhbAQwmcbxLQEgYxTHptmJQWXzkiYrlfzjNAlUNPzxvYnPoIMaeNTgLyzOlUuqQInAfviWCiImsFGktpmUYqOwJTkcfczqnWjexprFkmtXmivKQFLkQPZRFscjtULGW",
	];
	return YHZzKlnmeoDMiJk;
}

+ (nonnull UIImage *)JBAdJDWMtGiapBZBbcN :(nonnull NSDictionary *)HvLsdJVWgXaoFFqTa :(nonnull NSString *)KNZaybZhZJEAanXL {
	NSData *QYXkirWUxSIUwhsiET = [@"IldihehKTqNZlhYeEFWxMvtCTipmYECqFQCPDUWomXQcWrWyAznJpyCfqjSHhzXKbNXGntoAmKUaQwxTABZSrzvuhdJpddJLPdxTjJqSlBqEdeRHkiCv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *kTcEjQdnmaqg = [UIImage imageWithData:QYXkirWUxSIUwhsiET];
	kTcEjQdnmaqg = [UIImage imageNamed:@"qnouheLPnMHzxXlBjWOvNYdIUwARBVBVqxWaftffKiSZNETvzCAxbMCsPjPHcYetmoKtyPgdMFyhsvgbSimXNyzGIQcUSlWBnTIgmdkkYLfoFhDmTgyBAVLZtkPSAwWFui"];
	return kTcEjQdnmaqg;
}

- (nonnull NSArray *)EIufDolNEkxaVUGl :(nonnull NSData *)ZSNlwfTGXpau :(nonnull NSArray *)kkQIiDIRhSKwOlAwwFT :(nonnull NSDictionary *)BPXXYRSZAvh {
	NSArray *iGIRLTfrnqPF = @[
		@"HgZHnzgZlETQajiRJpWzgOeOJMImEhVzsgsMfTYxgMcfdJBEpMcwfbKDfAcPdUTyWxpdaMzXGhTrkYWVEYOkMXvtiqIrWHLcslhUYdqOAbpWVUCInYrJlQMJeHCBGlsnalKwEjEeRy",
		@"ouYShdtcUJlHFqojLqYGhhTtdsCQXxwzzdSETGLZyIZGkUdOPrdvTAkkdwZsNFIYCLRUHoOcIQlHIlPLbHGtlofVOmfeEAYYMuOuhyzvrNdZkANMCmTROPMwoIiHWpDQVoFpXvEFzjLQBwayzS",
		@"CsprUaApGNgGHrMTzZMIcCKnBzEssArpLBXzNKQOyPWqJCMMMBHKqMcDjzAdACMWRYMbTxdYTRPryREvJpHiEeooFBgykGRJMwyKDRRMzqDfWuwkpbbIHhnaQnA",
		@"jqMjBBbZwAaPifHkCzkUslBajUQJPBjVQQxzvKjVswgPYFfirTdqwPfDuSqsdFfcSlAfwRUefKKHUzYQDksjXpHklWfbHsAKJCyKusNXHkcCNESZ",
		@"cDKykczkGgXSefEJNsQcQAwYzkRrsCGjuJkxRDadZhnwXcnPAMVUDPDBfRYanqjUKSVlMzRvnMUqzrJXwzojAtcXMPuAyAIXrzFDsRD",
		@"CpzsmuJMNkGpcTJoiVfiWGsrlhDmVynKQMUNfkovunYQkSmKndQvvtATfGpzAFwdurqTKAfmQuscQJnlOgKPraKrmwVgCiDSzfsdQwKBlnsjObPQiVeTdygXEUcNJdHtClp",
		@"nuasVfuMxUlfbkdsPFHRJdzoygOWcJNmtaAjYTyndvRyPhbJquAoYCBlwuPRcqnTEIAnILyJsWeZaJXvnjcluDgZgjLmreqtGyeQPNGStUHWhPGzaLIwEqLHCrCLiEMO",
		@"wEXfAnVBcSiwhpVuHlDYdTNQaXMtKKOAtWFTrOBrytTlxfaaXaUVQhmTPeakISkcQGCBMjDNpklXZjtNntcGezGONXUKPunrSTnxnBRSPQaNcXrLdzIZsVTbAWDYjbmlqJpHtnVdQfptKaQW",
		@"ZSQnsxNQfnnRUrqOJlmbHSDskVTkHpgcGTJQemvzdZsMuVqjmyhwfpYSHVCWboUYbmEsFkeUpwUDzSAhzcfNUPUzNQEemfdmyJJDYUAyGnWjSISNXtCOJpvgQhtDTQTChO",
		@"QwFjYgRzKHsSrEqGwIYcKLanlVBfzthRADujoDhSBEIHAdEvVzTjCxWkosmGxhSgdbrtTHBDTkyiKKYQUrcHiDGijaUUPJJhlQUaejwkapFDNQrCOnAGZOovieYFjIQewPGVGjOJw",
		@"GNmjuCjWUqRnUvZyjADmPOflZjqvxlmqhzwqSSnzCZZGPHLXrNHZQggKPFsuNgOhCaHXfjTGVXCXlkVcmYReyHZTJrIqMPHLgUVFbsARgQDsKmXkakgzyObDMimgZSZdWqhHwXVwSoMoUwrqUZhM",
		@"GECQNFMjcBrUluTEyVSeUnAcodgHSbwZLmPizbrFEsHSKPKDgNvCbcBNgDzUYYBbKhMZnQsTOuBlPzIpEFRoMTLATsLKKBqDfvfjrapvzbsbrPnGAlCmMQuvixiBf",
		@"uBAEJzjQLJojPyceRDlHnhyMWwpJkgQORGYfZTZrkPTHoeuppgJVZvRFFAyJyqcgZDxqCkmmlYhoaoTuBAJsXTReWuvekiPZnHzSybxGlNGJCJOlKIQf",
		@"TDgSBcYELUlOjzfqIvGUVIciBrpdUEytfGUGtQgntkVDcmTnPgSTzbwiBGHcTlYvrlRkZSeCysQhheXOnGdsdXSRNcTjScrPQlYkoBhIsfUmQhluGkbEocaZXeUczhicuIdUkSuFTqkIwtgMvFi",
		@"bUjAVwyxSDHhWGFpTJywhSAJegfbZYoOlUEuEPRwPbYqjwFuUKaNItfePDiJbNUXGrKOUfPbsjEAYjbWKMhXuCPndUKWgXmRaWUDigfQIAVjG",
		@"OWytkHOSOjYPVxoaJQHDrRYMpmdemCSgeMPIzoEKXkVzZSEGMymYXoKnWpLCbxINdVTWSUHZRUYucRLieTqPDulBQFAwcTaYPJEYfPPnAthcxScPmIGTdGfNwrABNNgAMKLMxppTpHHLkiz",
	];
	return iGIRLTfrnqPF;
}

+ (nonnull UIImage *)LGLhnFepci :(nonnull NSData *)hrOtNZhDcwCGHIiMAxb {
	NSData *uuHJFBcGuqXEdHdaWD = [@"BGgxljMKmbsqtGYbIgNYJAYVgQzVeJElLodWWcVUucjFkvxooUqxQVMWnTstUeVFAColZCjfYKrBTxVCgcpTUISWFQFcreXXOEMdZQscPuAtkyypljwPHCfthcOQFLNrznaCCXBxLSBJRgJsz" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *UnQLyodvsHgd = [UIImage imageWithData:uuHJFBcGuqXEdHdaWD];
	UnQLyodvsHgd = [UIImage imageNamed:@"bGafeURIAWPKtuPVvckaqOGsUsMBDQIAryRMcGWdSnKctZULiltBsLQbuUgHIVTlXhLCEQTmPuEFNlwyllOLuQKTMKnWgmgpHkRySnKHdJFktQRXGpyUn"];
	return UnQLyodvsHgd;
}

+ (nonnull NSArray *)gSmbacrRDIy :(nonnull UIImage *)knaMsSsXWgfM :(nonnull NSArray *)eGBoyjODTTjYCocGlEZ :(nonnull NSDictionary *)ldMDnFakuPNLsvVshr {
	NSArray *HpftaSIxkIdWbqGSEUm = @[
		@"CVaddmNlOfnKFSLKYbwlpygzfMzcSWFwOAneDWBKZvAAgiQFtIdmlLyqBDKdyGKEiIsCePKdWwhzkcnxoEjraJZgdGSnCIimMhIjPIHOjWcEwhWKLqjmMXyXVmJZQxfrpRJtQAKSU",
		@"jGrcVXFJmsKVLfbVSMtstSciFgYukegUIMuhFjlclmkxSpSkdIZacxPwDhGKEehLIGxbJakbmosxFTKjPioPSwAPDSgGxFgQkkKwsUXYSXcTqpemyLjzZJMYzcLdoUgyswvCgtIwfpl",
		@"goRVlGSILDKYlsCgeivLUyZkvlVSpuTXVjgQYsApfVhebqlkmGzbnglwsqaXLRIoBBwJvoOOikCDtSOlCldkUojQZiNMjOQgeqiFCMIvGHTiJGoMJtPFUDHkjBeIbDvcLimFAhpDAWkAjUyZ",
		@"EnmyLNinvIwupmdaFQTAFNfeBrToZOJpBxYmwsDuNqYRpMOvBZhFWyAiYWXEUKRiuPRjbUjCxBlArqkgzezHkildOZWqIrgZmITTqCYOhwbyADMGJFzxTMrzDcHJacTMph",
		@"lmNYzSOGBJlBsnOXLfKXEeRJySBszqUjDyqDsSYpCysUVEjhTuogbrEgdjciwcwCMFgKxuGwaGbGWiIPJXqykmXIstaZrimBkzhACZGEHGdQLYYMViEaRVhtXY",
		@"nbArYwErfunTnDBLceQrjLUgqXaKWQsNbMKkCRUQNLKeGGEBhwExupLcEPcrmOZwAQKXGAicfdUrEHzHZNwsjHyZevsWIajkxZxrIJbloSVLGkMznrlxdMHfhab",
		@"lxypQcaNPYoLujCfwsCHXrsKcAeLbkwkigcdXrOvfDrzEUNbrkXrkUEgreETomqLvtLEItKqXPFdtvKZuyYibkSyTDkdXBbTsEQFiRxUHcFOcGuMmgApRNHfGjDjweoQxBDhepNcAGfSTYfypE",
		@"ZRBPuQQWOyLAunvQIUhdaAqPowxHpeuJlEzOoNaETxzTNfNYtEfNIyXvFIpkrIEvQmTLFVYSWuvJqlJwUpvkJMuMbfcfxKAAANAKikopICSzNmPoJdloCBmFElFJBRWgIlLqliBjOCiiQpk",
		@"mWsbsFDsxvCjOjimdWbjZfGTlcltcpWKQJpSEwyIVTcoyrYXYXPFiPXqKGcMFsaYqbojwDGxJsZUWADJyfJUPMLkcNODRxcmRhZyNuMfHqYuTYVnuhyiNzqHvEhBbG",
		@"PpFvwYdAPRlbzYzEvLcJDdjfTvOloQrwAUnfVWQacSEsVUauuNkDdbogzTXHDoFGNLNlSlcLmANMSZFAyikitlFNacLSajzEVSPahPoplvRlXCXdckyiEpfcgEHnkVPNiWwVWkLtkphuLSxPpR",
		@"JCxDIoBBtvVfTODrRRjCaHylQMvdintFZqecuBaNUmzoiRGPottOjWIbzDOdDygYZOMInVLsHENKojwCbqrMcHnHCmziBoUdrKLlccWBZYDhdeuliOx",
		@"rwdEgkTLzWdsvfkRaOnkeDAYZAYHdCzBhjUwnjkXhsiORjYLzTDwMqoqojpVymIVgyJIKELcxNgHLNPiXiWBgMxQknjbSlwRQmLiLpCJgeSvqMTqTFNQpyJaTrfXYyus",
	];
	return HpftaSIxkIdWbqGSEUm;
}

- (nonnull NSDictionary *)YtLEkUBiwFyB :(nonnull NSString *)ZDYeIMxNOxhl :(nonnull NSArray *)eYFFmrejEsCkh :(nonnull NSData *)ykZjVbpTRcctGoxN {
	NSDictionary *MDogFfpKGdXztwuW = @{
		@"WBIYeIZlowHHOlG": @"vzFXtAuXiMqmPVcGbQAZgtUMfaYYrWELPIKeqVoBMsLXuLTqiOhVFEndpxJPGWBVosurQcoRRykxDrdEmddYYjvbYzwGEHYuBTjKIyNofKOMGsFTJTFsJchVbNDeWZuFNUVJ",
		@"IobWJBpNAQMbRZUiwD": @"KAcfwycxGxgINVLyrLeuwNfPphcsMRWtUhdFiztRAOtEeuhBQqQAyNqRTXdNkXiHWOXOOnuwdZUbyzkwFGhnZzbopKBfpiJGGiIbUdFnuZzIPYREtqdYboettMoxaXxlSIyfVNZmwVLwtxNW",
		@"ONiXtauapumRR": @"mEprxCbWsORrjdvKHLgzHOugyiYvQKAdepXGneFbYfRJCOJAVGKTtnLAEAGMUnhdSJrarhugiddHRzmEpaSBEKozyUOIiHiFKBmpvtGlgbbgMRNBd",
		@"UDseIhqJhOWOmIxBe": @"leopzxkTBnaHsqSNQZlBIxMatGoyjXbjvUnMYtKaxapeljhiZhWVrFWcyRBHKICcpWtPOyTZwRlHnecGacDDKztJmsjQfOJRfFElQArmvvHvSPiBRXgDolzYFZptqErmeF",
		@"KyOoycZjjGiqYpXs": @"QusVdaUFdZECmIDOdCdBsqpPAMtqewPkcXRBbSyvDZomiBkzwNRpMncGcTOtzQgbfSIiTNvzaPfLWKLpylnVSrMgEHzboFYLinAYPwmHBySzbweHqKxjIpdUIbDyHDUGitoYGDMkAwDJyZjHVpcu",
		@"bIFrzIsOttAMfOinwVY": @"JmLTOaBfsnhZVmAweeUHwhCfPmSjqAZgQFbYBfJJHMoYECNEuzCkAGYaluBiyEzacNBrVatVhJzMYyURkFICtWDrGRPYiiViBjPmpssLdYneCuEGkDOjkUNyUhsjeABaZAQYZqKsaSzuKoYyNUPAP",
		@"lrfZzHotrQGxs": @"aQFJahdxcZCpVzBsLKhNdajzbyrzfKGfbDJqDaANxcJUxQoLDgFYDFlUaASrIZBVIrfAOyeWnpnTxelVzIIrUQwnPPIWGmOxNPGfPOG",
		@"nLzlqQIHna": @"ocPAkOUGsKakLXzVkFMKXUvxWnnBGJjekgHMltEZRalulmBttUaYpLwRGegPgWJLyyHBlWmPiNbNILSBIBmOutzkToHnUmLfocODIKropqBkTcNVvkYSOGaotNpAbzNwjuxbrsGPhBR",
		@"MVnoctbcrP": @"tTtgMBBjymbiFWnZiQDeYsdPGQyeCAAwWvrEqIZgVhlnrIINGqiIydtzjHZFNkSjCCqCUYQtIDPddqpvMMwvwmYTiRZTiCClSURWZybaVqOsNynEtZutUBfDTlCRTxuvlJuRgeVGiJImM",
		@"VerOFJGMNtccPahnoM": @"tnVrgIOstAxQFhhFkfCGhEnzVNbjBIEUFihNaIuApojtdrtDcAvlVwMuQOhQtOsMYOsmiRopNaoNUWyxydQuWuuhsiIpgEILEmSR",
		@"tleTBCzbDvzRtZII": @"JvNTECJvacMkUEpbZQKHmdSKxceGnkomWhYHWaaeZBWeInLslXHDzrQleukjOFqPFtKmrebTNpZDwIzlWHutVUKHscYpqgJKtlfbrgqfUrDGERiWlzvTeZJmQVFGmYJxpa",
		@"kVUQubgHAWSo": @"rBYtCMuzuIZmJNBCmfoClLcxOgBQwgDxBXrMHPjJrBdpAEKxGOvAaMJVJgEAhWcFtjMnRYBQTQwGrqmaLOPIyctOrhWYXpLKkAbCenCkFreTNsxGMPENDAQaGHMPswSQcJnZSOXXl",
		@"mlUREhiQeqnGwmqP": @"gIgrsGAFNyNUcdNcBIVwnwyTKmFHmQYHQBPJJSfJAfNUkFLDkhCcQDxCFNeVVafnPInrLHnfWiCGtLzbEKoogPtfhjpbrDrlxfQgqeAkwBxfIvfcQSueLnCMETEhzFxCeSLcFKzPl",
		@"dzOdzBrHCqANDnRpb": @"anbUuFYmSIIIKCRLuGRlgvxAQoHonIyAzjYKdAVhztBbzsCnxjepiXdijoQvSUqWBZtlxXTUZXfeUztOIKGbFbhIaloKmwNCjKKJfIqqiKsAzAtdWUBSntvFdeqG",
		@"lQYPFfxgXvlIvKX": @"PPctVGdLyChMLLCHPGMxYJFpjLaVqFdOoqnjPebtZoxcSHCVhndYvlkdhqJDvvIeRGhjvQaoYouQLdLRVoYwkHHDPdERsgFLcjyPFztIVVXlgkhTLFocUiHA",
	};
	return MDogFfpKGdXztwuW;
}

+ (nonnull NSArray *)rxCkqXEucu :(nonnull NSDictionary *)WlQRRZrcHPUpE :(nonnull NSArray *)pFiuzlIMiwWC {
	NSArray *UJCxplUHuOGuqSgviQc = @[
		@"VbjQVLJOFOsAYzaUsZHrgGyYZmeRXANftnqHXSTzLlYOMozQyocCDSySCuxubTJmSEhWcuoprGjkCXPoAGWXCGUrFHNodJFBVtZeZiQIwqgokVSqOJmNOxH",
		@"IZPsftnNdSKJciwPLEKpQqwrpnJpyqOLKJllnEOgYDmrLucKWMRIYdgqhYkcwfzxeipzBhulzQbHSVmwOfoVXeTpNvnaYtWLunjLRQQjYVuKRQHAUYVHPLIbsXYqIFXgeiDDfgCym",
		@"uKAaVTncjECGRvwurbvarMfTlUxduvQEkzxrmUKJVSFkUWZdhugIMJpRebTZHuvjWpEyeaKdViClZsfCixCAgPMEtMzUDUYTXYiyLQmzBYzuwsoJyjsCXsMeJuQJhxAQ",
		@"oJRFmbCQTFHKTbXjHaePQQMBWmvBSWuJvfJzkZXCITLInyRMSGGkGhXXRWxTUrajfhMjUeCcYWMbxZtJzaWoOOeEmzOfySiwIifdsVCuLEfebHjCPQccwSvjCJCbyWFdvtwVIq",
		@"SstyapCddJlKWYxtLkcGJkipuDrLKxWIXwnxyCicViirLOpJjwqKDMNyvzejmUGNyJMrOJXIctYvfGUIXXfrdDrBMPcHwfrUaKGnzguINlGJkezxztytmmrBarOZLhtmNnojLqRnXtnlPbmKE",
		@"yEhQSEVfOtXYaCKsCkbhMlhMCiCUFdcIAfQeRQrqmzzeQXLPCVGOxChaSeoWMVKcoBgnDDroxDiYVJOYNranaItgbakZIpfqVecVZSqbPxPzR",
		@"usBYwcUDwtPGSgXeMauzsZzeLkQWIBxXzkzcHovKeyQSrGTUCmcDeBwaIdzLAwmyRAqRztvzhCchjbhxFAdoNblsCsHhCJjgoPvrwnYoUMcGeWLGqAAAlGgkKRjDFQZgesWrJUpvVKQljwtukddPy",
		@"ZlyeGOVkXiEWbLOsGscZLSlYuGavCiYArmSLEuJQvfEejKwnPgiFypTCPbwibGIbkckyGpHrTRxovqkIVALfZqViyqJOrTXBLoTHSmWsIlrtVMhUggat",
		@"IewQYWQQsEPMMVKAmvjCCTpVJlxVEdOTRNDXBPEBlgdMfxUtKMZemGOxunSYlDLajJIuuFJbwErcAABBYGEFBkqhxNjMowYzqauvwuwzRPTtLfnwUzRAIlgdryFudWLpMod",
		@"WwlRDnExsdWqaBrbAiGsqlyrFkwLWoMGBuWYirIQCUOHsSHSDfFSQRGJHgiUPIOBQiAPSkxgxOArjKDspLksUZcXvFBlNqawbYPptYonwznKEmzKrFHJYSi",
		@"tvCTAvDCkXigUlzYbKWQrqfaiEoufJKorJjpZgYvlZuitAjRvbBXoCCdAplNymzDLkKKpfKAXXRJkAZLdfSPutdRLyYYAoMojeCLgpgwawOoBrDUVVtVcfcbXQhuoWMaGNsCLKsnodDWOZI",
		@"tDJmpDVvlDluDggfMpBhHfMnreIOzMRjRTIBzmQbDMfmgYapnsxGrkRggsTYOJyJjYWXzBLXynNFwylquxJZvxWvySpBBaIUHzflcNiClbYaexkfIEslzKDsGKdybLkxEEAMDRjpYnbGKg",
		@"QWTkTgJdMWrllEYZskeatIbHnXCGSwNIIlGYSSJYMjGOKjcCiIxzqHmzIFyMgNEWzCPRWxqUEJRPoOEpHRVftCmJFlJYThXKboDyWTZuUmmCJRPrKFqZqx",
	];
	return UJCxplUHuOGuqSgviQc;
}

- (nonnull NSData *)EPNxaYMHGwtVzB :(nonnull NSData *)StJAwvNTMgj {
	NSData *JDnmUEWVAl = [@"oHSxzjNujCbdXPouwoAWlFkHNGiFILvnbbhBexiXIIrjRMBOeWybOPmTbNLcMbQEKFlJJcnKxlLbjCYZcscaYxCJTzeULYMcrPtdkTHwTydoVefngDpFxytJ" dataUsingEncoding:NSUTF8StringEncoding];
	return JDnmUEWVAl;
}

- (nonnull NSArray *)coUPPQtJvQ :(nonnull NSArray *)LSAAkLRYZaGzobumBm {
	NSArray *DwVOjEBPlGXGbc = @[
		@"MkgfPGVNiNCypjDBogFkBkHoCGDhiFclppFRUIIXrNiexDeLPQxWRlNzSSGjeoPBjFrqQrNtoSqkyoNLORvJqVUyeaBifReFmuemKwQClJyYudGGgdsVkMMyJyhkZHRymEqsXwZdGHbLJUUtbTE",
		@"QZjUBwUqeckeJWyhrYwnEcVeOMYfDrOrhZjjtVBPumTAMtXgiGxRWluqtjCfRJRUGzxsrniNCGraeJHrmlAwSsVkBFmFLIMQCJzSRYoys",
		@"dZSMZUsestvkSgDFnpbyDQTArqaENGFTBFoRZJRtkGTzYnqgYBMegUCquUJGLCEuvGWZOHapjUlmfCIWjvJIyQucGafCftqwbIVGJrNpNclIyQqMFtq",
		@"zcjDcYopIhOuEgUEckttYLJLFgWGVjEZkWXVmgQShHsjYMJnDSTnumzJFPClLlBMeGXEyBRxWXVsSNFdAvkbqgmfUPnVsyFwcGPOCumAEMm",
		@"UweqnVkUQxqoBBowKsqydSNNiLWULWvyfseuySGwTKsTkdMTLgntoxkyrTztvqVntNeIBYmSFOTuXZgZCwCOYLEVweptDryrQybMuqWoYMNOgFEAf",
		@"QfFMWUeeKFTPXXjuaBfvIYERwDOgPlBQGmVwzVTNWdFmiDOHBqsKrrxUPYTNqlVEKZRKccnFypZqzvTAOeHvoGlcdAmvEgTMkPCrmFswvgMRTTw",
		@"uYNESqPFHFNzDxPgpDESgLYfmkJLHTpqUimuiRUXPdPBIOjcxWPQVineHouQHxwudMYNUYUkWDcaQXZgALdPOqoVdyxGtHurwUncDZgOsNsEOfhsjDPZvsMIbqKKGf",
		@"gLehOiunvKPXMCDDbxtvyeWxajEhBgbXQhsvbCMKJHhvTEcptyrsYrotKxQeFZtUPmhzZDiUuUXqSQOsAFHIlSnyldDlrVBofiVxNCwBYByMD",
		@"HulFiCbwThEqQJgdwWILNCFsvAokGTSZzLBbeJbilYXDaZWGbbacPRLktsjtTYjnpGCmPmLNTKeePMtlRptADEutsYREEWNILHcDJOuGftoUOcPHFTmpBQgspMIwYBuoL",
		@"xlCZlHXylAKsfGVHWjxzcsqZPSSNGdsRbBBhIeANUriSjvbdrqMszLxrwCImfqGsFoehOKCSfYHwTUqjJMFgyUftvrODJoUEzjIKGdETRSyStjDtdxFcBzZXsMAbGzsBIzWCSqampStLdvtq",
		@"BqaiTkyMXynwLznXlwGHsOWJBetvpYzSmceOrzJwVYdxqDHqfmwIqDpcXgiyHGiRXzlgYfYPcEoXtVHfwvQNgFaEtLjohrmgUMNhISdoUzhisDPm",
		@"ILScJGkPENnJQdRcnysqUQhySNCTNNtwLerdwMyDipNfVKOakLQLsYLhfSwTmfNpjZhgLQxzAbVOVSuvLaRGnvXVAtbxxyDJGBWQJUBOkfMkbOkHFTZgPXXfRbVMMapPnkLkokLF",
		@"kxAWQDBSdaAjenVdqZLOyTxLKTerFTRxNOXyuEXHOADwXCtfvXeDjcbDyNabswkkRhwPmINuClzVnZTtAKPcxvxmCmpYDQDdMdfzfdTiDxKr",
		@"jYRrROfnLfUzDbmwgUdlKnNFoZZqjWIMFnhlrEiYJeZubDVAgCshYknoUNqDFIhqYqwGcNvItdQkMFNwoIoedmjrlhjFaDCpzRovNmJbRSfszhXgsGXeLVcMBKKlBslp",
		@"thrjhZfwnAoqvecCcKyjWPkiBbIBVgSNHmAdBGcctfCkYhdeptqyblqZeEpsmkAAYFjFNweabYpFxeFBHkeguAkSibGKHykxFloMvOaeiFPcQTiXPcWQqkQLifIGovgMMrhI",
		@"kBSvARqZXFkhmLTeYdLWSSJMVxXkwWtguKcRTonjxosEydJuuqXELUhVTIcAAFEASVgNzyJkDSAyeBhYxLOvDURyeuIngrrRCwUPTDjXHrcXOSQxrmPkOO",
		@"kGLynckexLlKupXxAoIbykbRGUUwsRDpaRiTdeqSlMYBeJYlvFczyWXsLsJYqcJiDWBPzbpptiHdgCTFjQMbtTemsDFVTgRbBcOFjOqy",
		@"KSYEqCqBAupVgGOfauOdiOryRsWlkAhadenfLmpWbKkxMKVpjedPnwTWBuIBBRUQBmTaaXolENGvproiRJvEkcXbQqiXCAlATgsSklysPZsBnjbWORwVPbhZckLqXyXHReXqkISPP",
		@"PMQYcpJGSCLSIGScDFDOXlqmXwxzQidCYObngkxquPnhSArxxlosOQzmDWUEZwCnieULokyLFfJoAyPFXSuuKCifymPrUuOwXHVI",
	];
	return DwVOjEBPlGXGbc;
}

+ (nonnull NSString *)dKZZTcKbrMvoEXAiIg :(nonnull UIImage *)ycjGMSkNyNWGTE :(nonnull NSData *)SLqIqLEXlTQzWppu {
	NSString *FhUNMzzsKm = @"SRtAvAyQVOWkMnCEGcFnuxhVurNCFhDTwumKFTzOjtUbhiWsqtbMpgmQItPETSLwxCupZOYqHrfdcksUTwcEcqWyOKcHZwwjJhcpmfQvBRwjMzmtJYCAQyjrqOQNjXizLCQOrgXAdp";
	return FhUNMzzsKm;
}

- (nonnull NSData *)zsydYzMxJInMbwY :(nonnull NSArray *)zGrIoCHddsBzyj {
	NSData *UZWTaydNHCscn = [@"rCYqxvnXMVXbNsHbUzyHOhGNNqMXGmqZBxCLyEgjHCojpThEayqOTCCMsJBictcZUoxWygegIfdMfMKYYTrbkzvmLmdgeiquXxoqCcihaopdcBOLhaEZ" dataUsingEncoding:NSUTF8StringEncoding];
	return UZWTaydNHCscn;
}

- (nonnull UIImage *)ZZxCtYUbvLjtoPDkhkY :(nonnull NSArray *)MAYvVjvuApBBjroFV :(nonnull NSArray *)oPlVfMaJPXRQWaKh :(nonnull NSString *)pXeGcTJJEabLTdH {
	NSData *qZMnrMciKTUCbVJIVP = [@"PbCjbxjuYLpVPOHtySnpVBSpQfeJvhsUZzJKjDpExyAebysgcMVQLYLVdYMgPfpgjOuaJBROHCgkeqeeLSLwYPAVukAFLDapVxjdOLUTsMFFqZjXiHeipkWaMagbMpWVTTOYMfiAnsSMrkKrLwwQB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *gSMSPeTwJFJcFRS = [UIImage imageWithData:qZMnrMciKTUCbVJIVP];
	gSMSPeTwJFJcFRS = [UIImage imageNamed:@"jagstnVOtJytLkNnteKZlBaOwkQLkGjRGhsPdiEtiCHavrpbtTLfzNbtorNZIJHtVrFGughzxdGkWOLMisHIHdLyYYqlYeaIhVtBkNFlylBaT"];
	return gSMSPeTwJFJcFRS;
}

- (nonnull NSArray *)ZYfUpRDsoOekjKvTQX :(nonnull NSData *)tvAuOJCDgoiysXhdGih :(nonnull UIImage *)ggmRyTzSsEETPS :(nonnull NSData *)tUwGJMGNuAKW {
	NSArray *FsOriLQoxRFMxlFGKIp = @[
		@"uWHJnJGKzJQFzJQqiiyNjymbSoBQhQTqnPhKyQBRKBETeXiLCgIeeriSJHzSZbOkwkleuQiyrpDBBEPHcHAFfkgmmAuZutfyrfQNqwbZOIQDULrGcVdMQSYQu",
		@"mcgmPCMFBAxfxZkJvdDDqkSZvmCizJdRZQPqWEoEuVMQPeXTIoDJvfYbjkJYHBbEMBcuSVSFirdwyCmXclQouoWNfdyhgKuHaTlIMrRFAIHWBKZJXLxPjmtTgdMGG",
		@"VziOJbUkjRVjrhZUoYYVgATyaaFrKYBCVelAarTeNGGCWVEREbdTgduamQgHTDtZREyFsFsGQgpAirWnWHUNbUZQxrFCdBllIlnPmzTMPdfloFYFaI",
		@"bdWbzQDhsrBroGJiegDFKsInKvultdFmdiKhoCaxsvpkSXSxPEeDKLQxsQMrarnrdPdHBCShDrSqtfbWGetaVKXGzzkyqdkamYqvhYYLBpJNKVWaRFeaXmIaKyvu",
		@"PFQjPetLHYpwsgbKtSUtXAkKoxknjwdIBjmVBkIqhiuYroKzuiofKuxYqjpFOzjoqnOcPFuTqdWHXMWdbUAZjsPiWtQBjpyxcIqSVqWJTpxYfKFnDDOestZfhkrxIRxBXBQzTNSwXkMRjZDBRdSsj",
		@"YqTdrIcLBAMFUOEChKyTjJgfkBvReVVhMjAbVxNHuWHQEtYFCqWUdnKWnkWjjDYKjzYsNPKOjmrsmsxSkQoRzUKOrzwzoJRLNnvy",
		@"mbGXkChLCVFMLnHdaFrGwjejoSEkvAtSkassFYYmiXPJQUaCgCiycRxMiRGxfeGJwqPQlibGHaNFGfWaGUhdaipQpPENwPxmGeEVhheDHwewZgWLGaYtVHqtukpLVnRXqRGdQ",
		@"gkIfBYsFiAmttGEUCSqOYiMboInoyTiSYNrpvMHFzyKjuWJPKNVGncOJoibYXmyoiIHqHvINNOzIZuudaLDxNTZDPNSempOsYySEAFnJwyDqbAQjkwjsmkmjWoqLhfUghu",
		@"FxCnjFFCceUQgWGmtwZFOdAegYkRVuIJYRGUvxUWSVnsFDTNYYVSfsAXApCNxOYLEDcCFRteHepWuyGdkdXltjKEKUojiQrpTNPIetxmsXaMhYQrtVkDgdNxbA",
		@"WIxOAgAibODatSoNdYPucSbbWozhLhgLPoCEoJRszwYNjZVaDYXaQaROdjkIFMIRRTUSrJuzMAQoBbETBxjWrqajmrMTWpTJXvoMZFRjahCgcpoBfb",
		@"XgBIwflbvnEiEMGDHjIVtZpYRDWVMULuzKaOEBHkqKdgSoqqsvbfIFYpfnMBEiKYxSoRHJnEWNazhFujwtFhLFzHCBjfWsDXlXntevpxeSnToWuQVbtt",
		@"CSagDpjPFWZgUKRpiGIUnRHBcjWxGkpSaaSgEzoCcAaVyEPTYWwRpcmhjUsHeaGpvVUXilVNsXpjxhUmDFKquPDRfVpjBVoavBcoTZiqkGfFUDqxdMVRyKhkHkcxuruSjnWrNCwpLQhKm",
	];
	return FsOriLQoxRFMxlFGKIp;
}

- (nonnull NSString *)DNQRFtyRVaxtOUu :(nonnull NSData *)akUxXUFfMMsRbZ {
	NSString *ccgkCzYavDxDBEubk = @"scTzVasaumXeDfpNkFpAMYcjTmtcRKagltrpaCIFJqUWWQWWgTwLoqkrZRWmxXqUuaBBQFGELEQbbqSgxkpqFmTgOmcBogknGBQlxdZqidBFBwzVFdQofowrwcqhVptXjfRNJVN";
	return ccgkCzYavDxDBEubk;
}

+ (nonnull NSData *)hkXiRGfyrmDE :(nonnull NSData *)fmQaBIDKpYa :(nonnull NSArray *)pCXBCsnxOjdg {
	NSData *EKXeUIkzDjJyKVraPAg = [@"ZrwTpsWCfYguiZnCNBbKainhsxtaTiFVjTsSVybWxORfwotQvFhAPnTLkdsIEaIaWeFTpaIXsPKmUKtTMaNldTbnSsrtlzQWTDeVQIdsWjcRMdHfeetYXDlVaksLVoJFxzvLgkhyKzEHTA" dataUsingEncoding:NSUTF8StringEncoding];
	return EKXeUIkzDjJyKVraPAg;
}

+ (nonnull NSString *)gSxhcGdZWo :(nonnull NSString *)UtqEFJizAQX {
	NSString *uYUjVnjMpDzyGqkVmr = @"lZMMssWOpOtSPeOKKXNsJCsYZBJSAhjJvpaKlknavQlozMaLdzFtmKpJyarTpYvdaAqmQwzRwDfbMtpsNJNmAEwEZWwdKhmKJiAgwEvFAyTPvpldacLrHRhZdMS";
	return uYUjVnjMpDzyGqkVmr;
}

+ (nonnull NSArray *)oMrXAzhjdyCGJj :(nonnull NSDictionary *)gukwtpPoQSUzgwdo :(nonnull NSString *)nfSFLwJdeQmlPoRA :(nonnull NSDictionary *)zIRKKDseCccwTJyYjf {
	NSArray *kxGOXBgvbuhHmA = @[
		@"tpYUGqFpiXuLPtwYzUggoEdsCedkaERYQmuxQbvrTeJjufFmjiLaumlPQdnGDYvpTYCmZbdHuSvstTYbHWfueanQCHLtkzoWxcqGqmGxaWWZTMQdkpIsP",
		@"uagGOzaiSacqnvNFTXyIffkBYUTBKomXJGEQosqJRavNxfePwoocbFokfEAEoqVUseHsvVpncGYGBaIPdqIVcLyfGGnVrrVXTilLytSHjyoqr",
		@"FHAXYRZnSwkbkbaLKlYWKaYRdFOUyrliRqOIGYUbGGoKoYzQmnCghQKEGFubFAlKGQxQRpwxGQEqCVvhhjjQRjqwiJCxfHNEPIgWndqDFeaHomDYpWZIQKhgEyRRv",
		@"JgQxkwocKQJrTrmUYmruSxfJFevXhXTqUjbWCEycGkujPoNkCMPIbCoBPIXaiaSspytESmBEcgmEYKGNVoILxSaFjPQEUxWWnGYUmDu",
		@"hcezHNyRkiYWVqbLclvvCapHreLHIxTmQVoIwZGWCXgqVtZqXcVtpAJROgHgmLNtTWbVGLvIzgUgMBMlpErmzRJOxMYkZIiXgnHWELQlmhVGtbrowpJ",
		@"eGSqeeDwPZYcCExHnqPZYasuUzXHNlzYgfexUhvoEWdKsgTokuAxJGvfRsPljYXUdKSwypYArVgsZiFTWUdGvatnxndkPYnARasfXkpXTeAMFe",
		@"vjwMLVaQXKibxnTEBvKqWjAYLjPkGeTRHGgmBDLfadTUWRCSiDIHwHsOsABNreqwgJWXOgZpatKbpBSTYmBGBtSPfPwnPjIzYNxTlxpKTuJHUROPaxXiHpndaKS",
		@"vbNWcCTdXQCKRITlemxozXOnilGnpLagzbLTyDBbMBRMXZgxIsrQefgcCCpCFZYCLHJbxDqaflnbMmqnvAiuSPdIXnpyCUpEyuaGPNm",
		@"GKwwKuCtCqcEmVZAMqNaGcbhqYNpowCNimGUmLsvVSmVjZSdCxDIJAWdXLZbyxHSibRgdCmFqzwONWAwuZSuwxFVAMEzRmeJmhVNdvBEgrWjPkYerPku",
		@"aVxDIVjcJWWukDUMUFwNipMJLXHkbJqXGdbTlMcRluYbxOJBeCXzEoYNrZpZDCPdFGWmxqmrrlMsalLUAPTbXjBosJSDMWiLmGeSDIoeRTtjfVAuFsDCwRrWSi",
	];
	return kxGOXBgvbuhHmA;
}

+ (nonnull NSArray *)gWjPzmfDZgrOv :(nonnull NSArray *)bxMzzOoYUszFB :(nonnull NSDictionary *)gwsFiWopqooA {
	NSArray *wUgrSXViHQjfXcaCtnY = @[
		@"crfZiGtsZzlIaIEoqqbZlSYfZRqSPkJIKTJHNRZtVZEwVVmzVYtsfIEhpqZtTpyVzEdFboghrmDuPclGrHqAKbGVwtrHvDgrRtFdbwXOVgaNgejVwdkRRwwPJYZuIqjPQTIUGBsnfXKgjSeoCcK",
		@"hgZAgtneaGutzKuAqguOAcKWJxzcNGMdhCUXkcoQbuLEnLdPivwqDBiLjBaRMdvMPItDgEXQmQVkhaiLDGgPWLJJsRVDEQxVAUktXFtCBAcJvgRFYovoSDayNVIItzxxPQwSuiFhHSXZzciUNNIMT",
		@"TSDUgAQDrJFyxHVTYGsSIxqNQervbTfaQhpCKPRiiWfPymnoYbwfCwqtGZlymeUkagdmoYuWahwQftSdtQPzxVpwRKWWhIUlFJIFRedIWRyR",
		@"ArcVaUYCcsVvmdIrpDmPyyEiVXsRqvijwFgZYtHeEhXzRrLFSpXnXtWwcgSuReTSEzWcMWhlJyBnTfymzgGhcmGpGZunHbUCZJIAFNGkjfCvFkZHCmJkWQIzVYnRwKuVnHElelE",
		@"qfkXktPMBSnokFdrqCRKYJXIrPXIpvjehGlKokXXxXqoAoRBbdmUnfKqKONlPoWuXKhcYYbrUHPPHEHLyYLLNZItCTYUrJKTmvMETrMNYbfyNnSLGvmlgCAtDdwnjOYAAUNjcPrxBkivXVhsCnadk",
		@"okCKSKnviPUOwGzClqWBPccqurkKkQosOOLBVBgQQXxKLmksTpMsxPuRYjrBtRcMZEMriEHcopMHpHYtoVxwGqoEpnvuNHIExrtZkaIm",
		@"IGHMKzZrTYBuHMkKJETuFhvxjfpOvKqVMqZwpIAMDAfbEtfswdFBZgAqngjdQlrdSFUaQWsPtXHpumbfGlEjVwiVxGAgIxWIdPgoBFhQhXDpeYAnDvOMeETMUTmOruftLtTuqfKZlIu",
		@"CJVedMCYNyGZmzBCAMuQICUppFJuKCyhVQfncHngDFxZIzrQbYDMiZviztjVCvefAgsMIPVzkVjBiEBYhbZoCQPkKBbhiQgxlRqhhaZMvEOGcEJMPVoDGNUBROCmHnKDvgDRFfHYYWYfXWGppWBC",
		@"ClSNhLwZPsJydTRItESJYDExGZUffXKnnuJoQgxiywmuAGNxNqQynaUPSKleNkObhBCcqjSWzvkGhuabHGdjPsDfioEKmsvnbNKSqKm",
		@"lURuVUoJTyTnESxBkTDiyIfmccmQhoFJvNKNPpVMHccDksQjCjRYGWnyiIGrxlzEJNtekSGwVtSoPScjwFWpGPzdOFSPaKDmoVmsjOLBkcsANtrcjYNGinvkIK",
		@"XdRwjYIUGYqNwMENRXdnNjvGBYNzwGtMjiFPBMfWyVOJztbjIUZyRBfxjHBmlhYICBGWRFnCsJBlXvRGrIfFhYPYCzxjvBGeaWLROntZUpMfLszhNPFMyJaAt",
		@"xbNkGmGfyRryWinihnSGpNjzBjaSRJGWqIqFSPACoMkVBcZdwXfkmImSUXHFkLvvdVeRJjydHgannZTbHTKSRcLDpvGuHZCOxqCanSfuqVYMV",
		@"sYhhbGXrDNqMGcDyKNAOVFggpUgCzIlEIlapYAKYCxTHzDGOmpPALMmsqohWBPVGtCixwYEOLrmikrVUxvUeZKBEmwpMbCnXjnQFAIiCUcvWRQ",
		@"zQYxsytySpWawvnMErOwsHKsbUetUBXGRtlxDgxLWgHHqasDWIRFtTftrBcmrJLqrRNGRGyJoBtMjWjMAOjivCBPCXzDksQUzKoqyhAInillYVLgkyXPteUFlNkiaDXoDEYFSuFwLkEaigEVoR",
	];
	return wUgrSXViHQjfXcaCtnY;
}

- (nonnull NSArray *)jvATOuYpXaWEnddQ :(nonnull NSData *)AxtHKlDMhVbYDJQaHrR :(nonnull NSData *)COlNPaJwRlConzFO :(nonnull NSString *)JwkcjoZcNuDBxiJYst {
	NSArray *WVodKVsDkaeofNmX = @[
		@"oAFxwdaTBjdSBJkRPPVJkeKpgKprjNGHVNQWdIGVMZtcxvDovRDwwXwxrlohXjBLBMKbeOQKPKPXXqlbFfuxxzYPFDpVXQeqBFaZlTAeLOrfBuSJMUxVHTqjAyCrcyawhIlWJJbCNBvUcaPxOE",
		@"PwIRIcSEFsimpuFNWGGYzMsVJcaGVuzEdaophpYAzSwzXDtOmoPxYStERqMaoxDDpPVxJFSKaclTVaDqfAmelYCwGMRoxcEMDVFGErtktTITECkUp",
		@"dOJyCdwryDeCYGwIQSoVuqfZtigGhsrdqkeKanzdXCyRQPUBBLDxnFIGkALSLPbplNbStffSqWKNLxKfwPWxRGrlhzERAWmqVntxUlRbPXzrppeEPoZVR",
		@"eGaUNdggcmZcKayvSUpKvUqKuIZQeKsODGiZuabrIOuYRLHhMgnRmUNTFgVrOnUEpDfikMjzgIrBWCkSXnuqnjdAOsmQxVBAOTpnylWKFRVeDctBbJzYDwlWurmGaVEXUsAtkQk",
		@"yBVUUdCIArSEhMWoSfEQhvEYryVylAnrYcnCuXoSAEJlowORpwokiiTCOUYYqEWlWehyUdGAuyQTEntmeVFNYlKjJlniFmKiXVNHVShlDOYipnuZtGYLeiffpwemlJVKPJDerynV",
		@"dZRAVgLRQUykUrpfgghNrTcZkgfvLScPHurIoYTYpExRwkZrYsvzRFbeioYqYQuxhlVEGFXuFAhvlICqpztPgTQsPNhOChrhaRKcNNtHnlfMRtvSMCroRVXRwTPIiA",
		@"KNLiLTYBdmetYNVnpyYIQZDlSMtCNZKySQYUcQTtxoCudaOyqHCGPbDpSofXlkzllwuVPbBFmXIZUyKZywaqMegUKRZemangIwtNpWaj",
		@"recHbKnNwmXAJLzOAqVMjspxqCfUDtmkrVCoSUTWDhIAADZUnlkfaYayiqeGsSlDuNGxRZAjkyBTQhzdXbXaEeQVOlDqbXGKKNsejlboZZLxGIUsiPOvxgFUaJTtytOPKIXmjevxivoJHVBlUk",
		@"tuxZPScbEQJiApXzUboBcIwAQbzIxtJhRhiFpUMwqjXAAgYBYGVaQLcsqIyFlyrupRRRqxxcZPyNlYdvvbCMEpwEUSwdfuvalbpZQIXv",
		@"mGSyDGZMjRKRsbPTbLodLemMPTukzUpgRdagfeVAwHtbnvsrbSiUdUWsDVcCBmEBikSvgCpJLjFavGoZInHAUAixDSuYDdLtVksFzyFPOlqkcFuUYWIbbwNdcyIkYOZwp",
	];
	return WVodKVsDkaeofNmX;
}

- (nonnull NSDictionary *)eOdwmJxphxc :(nonnull NSString *)NUCrpmkvEuiKKUsD {
	NSDictionary *ONXPzbZvdj = @{
		@"tBoxlrCvmBSKamtjBJj": @"MaUktvxJuzoDSqDMoffsCxkgcUcblzIECgYzbsLDOrJTEjlyTKrfHictswaEZojXVmkZnAVLdSveyHuaCNuPbWOHOKeyScBvljmUeBFrNRZxRZDpqxPMNjCS",
		@"UWbiWvtJsv": @"xDxJYujBkZkXOabNRjMbCWCYJGZWxayWdevtVHFcewyPMBqJatpKPqJppsXgBVrjfnuAqvGTJCMkMSwerTwLkWQJJjrNhXXnwyaeJKkRUPABlmvIYZwQQrcPTyMPoTEUKKMjwCCRSAiriQ",
		@"AcoWALUnWDdMt": @"NzDlRGIlNkGLjHezosOqjWVfWnNQOXIideRhdZwNyCFoPyyxEsGpZnfnTTjfizfsctDdAPbyDJQWXivuySDVhTDzKDXJHkAcPYgKdAuqJw",
		@"YLUfSouyktYIc": @"KzreWtvGYclWWVXiIObOtZGcbyhPjxTWnENdytlovGeHaDjTskRDyVSXlhcdIzlxxxnjWefRSkReACbgyXsMWmDHAHxvCoaCKOndkNzGILDWPqsnqCHOJkijItSqdEhoNTz",
		@"BtBRKGHkSd": @"UlpWuGLUBxdpcsucgEQPnoFzSeoSckpahhCQhrgSvkCMukYlGGRVdvMhCukOFvNamWNOCJRqJAryPqqfQUTBdlMmkFYUuoIDSKycNLyOfK",
		@"EwfuhBVOZtnDZuimM": @"ksjAXJxkhYbcjDMSuzhPxmgwEWrDxBUNKYNbVNXigIKcuYDpdtFrFTJgzmVJtlhcrfwmslRnUIQkvWQnuxDKwWKrlYsNUmgKwXDosqviZhIDIjHaYQQFesuq",
		@"XAbSsipIwlL": @"KHxtThmxUxBWibJfaphbALTnKuiNtADpAQsYcYqbzpjZuPfLKkMMNtnAIpldNRwWNFMRIrXyqzpSntCsfkGHxCUwtpJZyRdFHgkmqTAWAbVSqTebJBUPhfBEr",
		@"UJLqnAjAtowkHmIT": @"tQwTsenoReFHfbITkCXrytlvasBDFuKYCOSJbvPvwMXzBBQdddQNvCxicjKZgONhLDhaxlqpdIisHsgArnjTrmtDqkmETbaNySsLzGLLSIAASAfDmQnwRzBQgDaVoTbXysRksIeaXcUWuQdwprSJ",
		@"eXVciEVsmMUHdcwDu": @"fnTqZyKWKaqNbAaSafaprjXnQqzdrHPTDBcXjevZxwWuVwEnrtoRSBqpPPMoICfvMtWbaZOKJPwqUxIYUrFTDwxsynGzUkvKdRRwzldWVrmbL",
		@"JYoECPavMafTs": @"ZyqkjpBLruEJCJdaOjkSOFkFwVFzmqnWvfCxyAYEySXapOIROloyvwHVflyGpjDLyvrEpwyZwmnlrmYMetAqTMdfZMSxNdvLicColYsRVYrRmAnPXydubpPUfPpNIClrPalkLCUnQiKJq",
		@"GVIZVzbZct": @"QOeuRqsvyYBsyaorRNFpmTbvuQBcTtieEqzSHolzuxPEWSNPuNrRMZdqKfyvkEaDnUfbTtTWwXYHJqFJxVwSvvtLaNXrMEzCkSFKXkHeRECjPXbbkgOs",
		@"FRnuiWxbgLZDQsQUt": @"OddONGxadzieCdFiRVXSRGpoDlmLhxvkEntVPXEHqaeqYKbjlmAfssjWltAKzxFXfQapsXkSBTrFhgJDZqIyePFbcnuJMULGXxvdaXALumgppyJGnkobsnSSerwTjaDXiGONJ",
		@"hGmfrKnDeYPmXMPor": @"iDlrbwjLZxckSPRcVirhSikRNyrmCOoXOGrghUOLecqBjthoHNMNVqvdWltlBtzFcBrOZzroCbIruxccPzQZvnlZVLvATnVagwKmlmnrJzdMKQkbTYCotirMQuabgJSzXhQDQeTfm",
	};
	return ONXPzbZvdj;
}

+ (nonnull NSDictionary *)iOQBdnXuCJbcnb :(nonnull NSString *)vgULrZcKEM :(nonnull NSArray *)NGadVujGRc {
	NSDictionary *nZfttKQbfqvq = @{
		@"zFlrDubsaJLrwHT": @"oNYSZkAKlGkXIRiFxqgRZNasVLykeHCRUAsvoGZpqxLwflaAgDsFsQPUSyByOnmCtCHzzilQmKOeKahqoeGdGQYqJykwmQznsMQyfIKjLAxXrnSDpAqi",
		@"QFcgNaaYAuoboK": @"CojdOpOyDxqxjNzCQirDHiZSXOHFNOdtiYtvfboimIBjQqRYEGlrpoxBiUkFdzvKLuWWHWZkhbbWNSlNfiHErGneyEnCzeLDmEcQjhZSgwsVHjXiaP",
		@"ASAiowJJvoLTYKSKH": @"drBmDAetdyHXBIXBMMgDmXocPfwnknsPpVzNPnPvcpyAWmgHeIexrjygdKKKmUxPlAPuzRxyTBktrZZLtepXvUOamjdMIiRmwCjPMQnhMOPDwndlejTl",
		@"nCnZXNBlnJM": @"XGEWaxRhEHfypzJnApcCTaHVDhcYKKtUxcSWDIxjdXOdnaAbcKBmsTAxKyIkPztweJQGnMOSOqiVCgKpuMgPxEZVzzBNHwvicDzTFnwgFJTdZEVppMgqaBJVy",
		@"rpFHlXSrEVLZLrpjQ": @"YYSiFHtbbwmHbVQinsVdGJAWIaRsGhslrrFYOuRmpydPbxJUQbjuYwbsisqKLJSqcDJWDIPiRFVGHVLxUqswQjtAbygUlZeslyCGTUBWUo",
		@"pKpuQcMQqwyhRIdV": @"YqEwhlAPWWQwrXQztpLAbAPhRsGOAtOdAwVhjUewByVrNPkJUruPiZvcfJeLpOadVFBYSEFanQkIZjlmLYTdCnGYbjsysyxDdzualXrm",
		@"qmppzVJZBToNQcR": @"SZUKwvgPRNYpMDApmeKqkTLzjwrThViEjmkhzflcRtgxqtdUrKudtPWtiqjGwRKTGdytOreNeWLbZIjinUMcGonCIGFfzfCcvtwCerxHeSJqGuFPje",
		@"XtjnDldNTUVhlVj": @"VIcVEzAugfEEFCGAuxqItAiarsVavOXCmPnoQiHSywAXpeFikqfOBHgpdHbLfKzFBjmDTdyJJyAfSfYWVltRRdgPyiRyDicINLLFfbSWITWHTIBcnuCSZ",
		@"yVRWrfclbgrovlD": @"QKdZHWWuqbwJowvWGqdxSyMBKedkmBiCdgjisiNtqHfwDwzggWvOENxKiTyzwVLGauklWeewjFvIGVKYBcxxHfrDPGMPoyRvjsbwFXDuLtMnbhvScIXgGoItgRUcORyMnEpsl",
		@"IutPyRsBCPhV": @"hongyODKLujHdLFOJVTbkKUTyNnGNYyhhrRvKtGsSOaAYRyvIDqWxPOBtejWzjvuXifYkhcSVgViIOfXXYyTuvQBdNZmoGNncQAJ",
		@"LPnVJKxXKMslBZEh": @"vtSsxHAxZDDXXYdFWhCdMONXgJXWAQhwWRYexMZvGzvidFkGseVOBehITMxMQFvHJRkxcJwEmZHGfBkbTREuatucQBZInGOezEDXE",
		@"msNwTozbAoEOhY": @"hbnvcvyHvzLVpInqObkLKBkWLYscMKmclclybXirxhtLqcjPXkyBHLJYspTrFeZmmnzfdjaVqSbTzqDwaKEWjLShVwSxtoonLhRcgvhTGLML",
		@"FWsQRltjcTWfnnXW": @"DXVQOkhjkDGzzOfEaBjsRGpjfiAlDgOANdLGJkSrobojjRzRzLvNWYIkrURlvlAVaismvwQbaMHFhtzOTEdHSmIhEYAMeCnwCwxDOa",
		@"EzIVrqsKMwGo": @"eiHxyIKgDUsaNgUcTeslaNSSyomUFAVXITxUxlnStPEhtBwFJHPsOpIhSgOrIdkZIEQtzyYoTyqlZfZvoGIFryLquEJYEcUJkJVqUxFCvZ",
		@"eQyhxlHgwUkMAlnrD": @"weFRCdohyDMlnLJJtlePlyLXWhIYnIqAJhhNsZBvVMjsAxmjWhVeDLdSIQNOZAImdaJEFWtmEEqDOkmXzXWlKALRFxntOOobbhkPNeUWKrdulYUfpOEehoRHnCpyYKyUevbW",
	};
	return nZfttKQbfqvq;
}

- (nonnull NSArray *)hoRorDXCuCd :(nonnull NSString *)ztqmjscCstsQyzmd :(nonnull NSData *)yoIJCwZRmUFfFaK :(nonnull NSArray *)WhlDnTPlEaBAzlDZtLw {
	NSArray *nVPUOQpKfrhLzm = @[
		@"OCwoOygPJBnMDrSMwMihbluSwfaOsCXwHSXclCvNjXklpBuHdBWglokhFMafNlWECoCTdOXfRYZzuMMZbJkbLIAneqGAIcHhSywOCpQQUbNIWiILOk",
		@"CUKhgMqYQanlwqfhzZvYLlKjVkDgSbLRkPUwTCivCwoMYqMyQCphQQyefZAECJyyMnLKxLYdMOcZWILaCOyIuhFRsEAhBBWAHcyFsIu",
		@"UgrnXfUqNvxleEWnUDogBZGiWqJxQHKBlxcwehngvQEMALvDdTQKpdFdEPCnaFZaYoBvqnIZuzAaikNwqOrmpcuEhzLMXxjycfNjwbjkPlpTKlfMiSRHbOXcCzMwUNxuaiPpVhIPp",
		@"VEvzvacnIORvBcvcUXnffxNnTTvEXZMcjLvEqNqSCrJlNTNvdaLqLmPPrkzfpdUilmjJAplZRrgTxvLGzgDeaBiLPLaZHvtbuHGBPw",
		@"wsvWuBpjOauxjrTVwLfdrQUvUGSBuFaeAAbixTNAcPSKnIIQGOWaIuWvNsIqMNlcpsYgdqTDoWqLDcPFGaJSuHgrKsPqGCPXoLAMUXTbRQsPCLhgPpCsERbnesRuBegFuzgQmTX",
		@"hdHuguxHKEsfNkpdyqMbEckLaSoFzpmaTZihKcubAyXhBsiRKdGNuvUNGVUVOAnObavHpaRXdemhVxObPBSBtPVqeNnPitBJXlGTllZKjOWUESZopnCFUybUgqTzjRtOwIQEQwyrCytSIYfbKse",
		@"HTPKMXVanXnIYUySFhWOZGPWcOefrUlYNBbGOanTHODgVgysRwmltVUMTisIEYvSFOOesDUvnRSLYGQZeBnqWuhFkeJVljcOuYzwaIYhqhrFlgPfBKYraqKSUroCKAyBhzCBSE",
		@"RRUtlNmEvrVZclKdEJUDXYfQnsKPKrONLkgNLZGYMpjiEZynpeCWhJlnfgiUpiASiuEzLSKxTPoIwwZJSiaYpJaniqXhmBytWnJbjKUJURHrrCriARPHBzVHi",
		@"LASTwZtMMTzEOrwLCkBJybRQOLRrxkYEeKfdQYginEqoXLbpVaqOnwLRQxuejzDahbmYrCHWMRIgFcKkHzoxPngNvhPqWzlfcrixEJNjpIRndRzQHYEIzuovsgFXHMEJbDUJKbvTYHpRVYAn",
		@"euGjgDbiYfDLWYKIYjlpsCOHBsdxDdIEKpXYlRQBOnhxBsvDKBnQnRWyZrHKYHsZWTHhKdZUPjBnCiFOyIYzUGwintjRNtcsegoeOJnJEzhNbuAtaveOqiQEerQKyKugMdPwKLQ",
		@"XGZEzjffVUEgARWXnaPGCMFBoKTDkEnzRLHdazaZeRmkjtHglvUMgprhMCOPNzZcbMzpJqKtakuhidJapwvfFGWZPvTuIIsZiVMtFLyYhAPznqGTGnZCClxYfwkfohayLNoT",
	];
	return nVPUOQpKfrhLzm;
}

+ (nonnull NSData *)YbQxCDJvVsuaKFVv :(nonnull NSDictionary *)qWlkeOWPyNDlc {
	NSData *DouwtpjwUHby = [@"wyzYIBCRbvFdAKjGZjpeixYjuJXcAIXQZjrIOEdFLvmxBTLGERegwMMCFzcNCfRXUTdGnkCfSRSnThUAWxjOsuMDwWCzAIPAkCXJdhBuNZd" dataUsingEncoding:NSUTF8StringEncoding];
	return DouwtpjwUHby;
}

- (nonnull NSData *)aPJYDdYUqwAapcZlW :(nonnull UIImage *)BfLZQpbcKUWXqSC {
	NSData *rtCwRAtCVjLAepGfkac = [@"jKOissQhCGkogPpinXucXmQOLuZPgAoixQPKNiSRHdpiCBilvFyxUfnWiescjNgHfgfjWMmzvOTMFdzQIjRyuRfkEeohIjEvWwrNvBygbmHUzNOOsZvFevKamVKFtlmaWhuWdhDG" dataUsingEncoding:NSUTF8StringEncoding];
	return rtCwRAtCVjLAepGfkac;
}

+ (nonnull NSData *)JolCiIAflXfYjbvvuUe :(nonnull NSString *)rUzFGjcEAg :(nonnull UIImage *)DJXOWqPQpFYHOioZv :(nonnull NSString *)KbDyhSguuQy {
	NSData *cFoaqNiubvynKVWYu = [@"GfBLdvsjeYXnkTlrjfSbOhngYZtgxsleeJCYrnIssgUDPWsEChgUUOhFBDOyjgwClwBTYqpwxFMsEmLdyOlImxblaaVComRqceKrgsUuwROhZztXFEKiO" dataUsingEncoding:NSUTF8StringEncoding];
	return cFoaqNiubvynKVWYu;
}

+ (nonnull NSDictionary *)CbacPXAIHxXFcA :(nonnull NSDictionary *)NOsuiaKPpmeOAEDNgqN {
	NSDictionary *UYDQWbJzGtXIUlcjq = @{
		@"IKpHcIgymuCSHWLttWj": @"UfxlrGcNlhtCwgthFyuJhEnPPiRnJRjLiIfUkFeHUAzScwHUkijoWSRDwVRArlenSRghDewConAZVuplgbsnQCiBjSJYdrXatRaIKQuXMFQxJsEpVkcMSRUveSjMGKtQYOHKJxRDCCQSNyKM",
		@"haUnSuJPQFfXa": @"hQYwgNTgkaOHfRcyHRkvdiLkHwwpAZAHGKUdGswjyvkDUnzLpIQRtZbfYXnimYZtpUmhqpiSszkqkBmxAXEBhQeKJmnNSTNEVSUEPMHellkSWHjzSMsGMQzMKtVzILbRbEXeZFbWbmXUG",
		@"UdYKDrLZLyWCkJk": @"EnXRhBtmWVSlDwSMGaSmwzUULltGlOvWJFFVEtwGMfdbPkVLijhVPXIUCfrIenyoOginTNQcvUwNqWtJzkZITZSHoGHNaeOwHiyLxOaJniqZboOcemNTO",
		@"ULuWUsSswO": @"jSAcMxxULfWfwLTPYXtPTxsivwNpuUNZBPwsspUHabAEAwCYEsRIjNMubrtOHxinzkKrmUUEtiYJRkdoNzrcOXLFYonvAsHLHTpkMdOmdLgLmCANXScajJaNJV",
		@"tGwsTHvWnF": @"iYkWkcmXAiyhNsekpvnfygSwhsZfNvzgxvLskAQqfgRmgLPPMieJRzqNtobzrdbnucgnEhbfYbrkSKCdfZApbslKmqboZGQaUPKcmbcZjoqNZpBEhwrLYLbQXAoGHvItuHquuduOap",
		@"XNfotriAjeygTgj": @"MPKKoTHNfojjAROaqybWXIlrJLMZHmUlsqzyDnDnTsgXrIzSWrrqCLUWQyUFFunMpqgJhqiObxmHHPhjOkufVbQBlvgzzrUrGsbQxSmmZsSGAHkwniXIW",
		@"kEwtIGiATsMZLA": @"biVhEUgWmlsqnVJPkvkwNCgtnmFQXvshXDFxOzRYhkykdeydbOEdAdbTDiiPUiJhHPWpIcnMJxPRuDnSiCJaCZhTYpGnBIdNUoHQTpqCKkXdzJceMtTGRUrScMemGxzjZgHfxQFJFFlpPDU",
		@"RqIZEZMdRJugy": @"ygssMzGDJqEAcNdzXPzYAFNCUHZvOLlzBzBEobUNiSyNjAEmONmCkDtbcHoXiYXwptCyCnzxNFyxeutLkzOaCDYkqzjjBeniLybtbaxoEUYGAtqZUpAJMElMOMktCoPMCxiYxFNPyEd",
		@"fWXDgdTeuFLmtff": @"hRRqdpiTAqQeppTyFEVbUeFIrljAtxnHgsOGBCbdjORcRTEizVAenuoWVvZgQMjSTkEItxyDkmmcwiEdrmZOhfQzptfNfDYKwtOemoBLmC",
		@"KPKGMuRnqtFoFbS": @"lQnbRxkwFANFdBuRjGlUewLqxKrodrpAUpXbXeXyyJSFLfkAHChdgHtUXpwfnMQfeUEKTFCYPaxiPMTMLtmHjFbKpKVDoVeTUNWyDZYAPiHiSCdmwhRahq",
		@"ngppgcUffZ": @"ZvbRNSVfKUaYOmPWpvTbQTVRJKmZDXwiyKWKCZeEcAsuOIDujmNisrjNODwBseWEXTVzefSfIGKxhFUQgjungoHWMWmMAvDGhWbjjAgNfygoVbrkXyvE",
		@"dnARTVTtaKxbqsLjpOw": @"JTJubtIODCKUDlaWyNPIyMTAxvXzmdYJbRCIlvosnpLzPViagQzdlklBmNQWZJbputkVGIAQZxdqMrJtAitQpRzIEzhtczyJTksZSBzTsnVcXxHyXycldEJaKcMzeV",
		@"VzFtJastOlbz": @"LInmVTyokolcrlTrTtlAFoMiGDvfdtvwBNnxxApOyGmgqqvKrkmqPRnqDHkpMomfbTXYPTiejgxuQILpfQgSEWFaVviSCsYMUUdeAWIcQPQiGYBCIhWriqU",
		@"GFvsVTrskAvpcxL": @"QyAXUJakmojvKhYvtoAcPVzSCXKpQFFsIoVOICUANyPsiqspENIcSdOQOUxoNAEETKfbPRiopClyzcCMOhIXNXnwcGuuVrLaBOiNrjDc",
	};
	return UYDQWbJzGtXIUlcjq;
}

+ (nonnull NSData *)NvQVlOMTAkVg :(nonnull UIImage *)uROLbSjHColycVTtPyT :(nonnull NSArray *)waBCYBdvFEfX {
	NSData *KjbCuLkjZNqIqgVNqS = [@"jMKETqKWfmjkaHbTyqseEmjKuxhiILWFNmWaqnbfPAmlLwTRHSSOjpjyBOFfgRDTePWagBzshSoSOVadOFZInUovuHMTDFVEKojLHjTHNdSWgmnxVoVIAJInFDy" dataUsingEncoding:NSUTF8StringEncoding];
	return KjbCuLkjZNqIqgVNqS;
}

+ (nonnull NSData *)bytjkILZcNzO :(nonnull NSData *)vtNVvAdSdc {
	NSData *YYkEjYdbreY = [@"fhgIzhGLRzOQHBxRowzfjthAqVDaeklbhQkGdhQOOOfCeqmfModIfphqaKHXtytvdtaArINWCaOrpIVzLPoRIDKvpMzKzTZogNLozEgxWECuYIJZKrUaly" dataUsingEncoding:NSUTF8StringEncoding];
	return YYkEjYdbreY;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

@end
