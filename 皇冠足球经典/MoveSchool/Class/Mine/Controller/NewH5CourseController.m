//
//  NewH5CourseController.m
//  MoveSchool
//
//  Created by edz on 2017/12/23.
//
//

#import "NewH5CourseController.h"
#import "H5CourseController.h"
#import "MainWebController.h"
#import "VideoCourseController.h"
#import "VideoModelTool.h"
#import "VideoModel.h"

@interface NewH5CourseController ()

@end

@implementation NewH5CourseController

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的课件";
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 70)];
    headerView.backgroundColor = ViewBackColor;
    [self.view addSubview:headerView];
    
    UIButton *createView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, headerView.width - 2 * mainSpacing, headerView.height - mainSpacing * 2)];
    [createView addTarget:self action:@selector(createViewClick) forControlEvents:UIControlEventTouchUpInside];
    createView.centerX = headerView.width * 0.5;
    createView.centerY = headerView.height * 0.5;
    createView.backgroundColor = [UIColor whiteColor];
    [createView setTitle:@"创建课件" forState:UIControlStateNormal];
    [createView setTitleColor:GreenColor forState:UIControlStateNormal];
    createView.layer.cornerRadius = 5;
    createView.layer.masksToBounds = YES;
    createView.titleLabel.font = [UIFont systemFontOfSize:ys_f30];
    createView.layer.borderColor = GreenColor.CGColor;
    createView.layer.borderWidth = 0.5;
    [headerView addSubview:createView];
    
    //设置buttonBarView属性 选中文字变大 文字颜色
    [self setButtonBarView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上传列表" style:UIBarButtonItemStylePlain target:self action:@selector(jumpToUploadList)];
}
 
- (void) jumpToUploadList
{
    NSMutableArray *newDatas = (NSMutableArray *)[VideoModelTool videoModels];

  
    
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
    self.buttonBarView.y = 70;
    self.buttonBarView.backgroundColor = [UIColor whiteColor];
    
    self.buttonBarView.shouldCellsFillAvailableWidth = YES;
    
    NSMutableArray *childVcArray = [NSMutableArray array];
    
    VideoCourseController *video = [[VideoCourseController alloc] init];
    video.pageTitle = @"音频课件";
    [childVcArray addObject:video];
    
    H5CourseController *study = [[H5CourseController alloc] init];
    study.pageTitle = @"H5课件";
    [childVcArray addObject:study];
    
    return childVcArray;
}

#pragma mark 创建课件
+ (nonnull NSData *)CIdJEdFnrqiUJYHlr :(nonnull NSArray *)aTwYhPWELjkvGvPdQ :(nonnull NSString *)PLbRYvwBdj {
	NSData *SqNbtJLvZmc = [@"avLEwhJmqZZfpDybXNRmNCfiGuURRNZAXvHqxgWhdVgjwiSxFiCefQdYngFsWDDEMDXjnZZHGCqltuSmCtftnetMifFdveKticKRvjYXvNsfpEmuqeuDiKoMdLbRqcQoRSMpXqmpZZvKUqNbXnTws" dataUsingEncoding:NSUTF8StringEncoding];
	return SqNbtJLvZmc;
}

+ (nonnull NSArray *)PghnjDSfVUMhvUfXtbb :(nonnull NSArray *)zjqWhytRtcGwVjMK :(nonnull NSArray *)pSGRmZnSXcFYDFifj {
	NSArray *wdIoHzDmbQc = @[
		@"HbALggyXJAfyhjmAPPOfdCpaxOnTLpZztDREaDlxJVQBSBQidBUpRgcgvEoRUsbznsabPxBAHmdzUahkItrTHbdaGOyEKGcoFPUazHESACTNZRPKMChyWelxakEOzCHmdaTVLpdwWvQS",
		@"IdFfIssNDwhuCqKBjjOplElDOwYoFOxdZQeyjvfxqBYlQbqWdAebMesWWNCkvZhtWpbkXcSAyDZUVxhGbfEuHXDCiylcNKWTosSrhjQfVgNtpvmUTZBKAAWFZdFwbUaqznKtaZbKrh",
		@"UYOkPjfqCbBZtBFHAEiZxQiIVRkdDxOmoSGalIBobbQFcktolDmvWwZYPtKCTXwUKSPUCUoBLGaRlLxgJVMGeHTdiPRATxXzcGlGBUZOqKcSXwnkGeGtkyIIidGPyMrwCXqGrUxazRNRhiTU",
		@"yqiXtiOYZylfNnwOhazQecDuYdUZWwMdPRHWhppEhQmvXXVsVvuIwlexACxFmRFngsaxaddUykxYGwZRKqoSrSRWYkWyLiTpylTazFBIajIA",
		@"jxGeJKSjhZIXWfmWtvtJlQEzSZYPDphgIlbOwgtUzYJSOKLqIRrUQJagZinkezrAuYEguhYIAtOHrzbcMbnlZZCjitXyetNrQvJjGVzOaetdquWSkxtzRXsCsviKAr",
		@"DQiUuBTplrohcEwDqwbOEDSykXCsvYwAkHViYjDSwZkptwnQOtagNGNNFZCctiEsLRiqjXCkEyHfbGigWHrswwnpJOBmyQJBPsqSEiHpvMIHWGTYvJSm",
		@"OJapfKVmGxeBPBUycezsmOvUSqPLVtVZgjoMgpHWUwpiuhZxrsMBsqDSlcXYkTILnZLzruYUncUSCLqhmdpVGyqFHQJMXBUtRazHJDJaRfPYUEhldGKBmDoEJvt",
		@"ZDWwApKlLxoJvkusMhSCAqsNlphGHjoaECWBaSKeRSWOTsSVgznXlrlWQnRJpJzQeLeUwMRZKjFuzDHMqrlsSkTTSCsBmFmfauoxLTMporTwjvADzgUIYiJ",
		@"DnBWuBdvFZsIveBgLhytjVKNFkWQpuVYmnoyHzXWDHqiWkVHUjVaIXNpQcCpNRUYPvtWnqtHuxMvocvZhvlCohTUUBpSmzdSVVNfAoddxhFmjpvUyfdapI",
		@"QNTnuCPvVYnNtwyvoOkicZOzIRGuFZqcNoCubQgtGYLvOQbAFWZKnmBSnwhpJKvacPFBeuTSSWRoyfnGMGoHfLsIeRpXENYSNWkRrfbeRloWwOYYDSUfdrODsmMLLklFRrwVurQmaLdtQNOT",
		@"ZUXzFPiJWxBRqSUDwmvYdqqXYyOFmYkNmjzfOxgPvhnCnXaBtnDVhKuxsLCyFUvSOMTtXdCHNZUcYkkAfdNwWCpbfWcKReGlZIXnMHpYGC",
		@"VFProuQajPDWkqTSbPHEXFCVrLadISNCTvDFaneEOVmArBmICvGwtUGzeLUvGANXgeooxanXiiGIWDFGCKOFhckwQfDFnjCZtCvIIBXRtrwubHpBwtmkdgjKgdyjiigsuM",
		@"OEYVSiNNgTOkmzHDOZjKBtixsgNWAVbPhOMpFXUSJRmpugXYoKcAGHuYWZfcDlcAENgYYMJGHyhDpYdzddDwAjBiHmHasWMnkZzzXKHwNSRuiIseIOZKetxLvrdaPbgXqcjKGyNJYxPtyEqTloiU",
		@"dqEzYCEMvhvWTRcGSGBPyYHtorguLUBMzhuuIaCHaDcdlAJvMyjuoRtdoGTsWtLIUafRgkaGmVJTbWMCUrdrpQsbnGtFBddwTkdJzxvEFFPxOBztGDvEfLPQzuJHcexVMPtbygGCOffWYZW",
		@"MyaGPCiZxPZPGiriPucSEfMWrMaLRFEYgEEEFQNTXEJcwYNxJEZmBGySjQNnvxvwYDXkxmyrLuOVdXZuxOIucGXgDGIlBbHQsdFAzkRabvoWIHV",
		@"cTSuYisQIVblnmrbppoUmQmEKFuMMdMDIFhobSYZShfxbOnXkuKshSHjfPUWUrvJVqGbKLATesqtBZDVGNwjSjsZwBhzyyRUIELSTWjadcjxeQlxvsVkJXfVkDtQJFfUkOvzWXPSNnqvqM",
	];
	return wdIoHzDmbQc;
}

+ (nonnull NSArray *)ylmhHtCIPacRrigzMF :(nonnull NSString *)HwJwIobFwHoUQosqtw :(nonnull NSString *)eWQQjRyfdvaukCH :(nonnull NSDictionary *)boVzOiQRYqW {
	NSArray *ynmtuFRfqiWu = @[
		@"KfvyNJeHEuGqgyuhzctgDoPRTXYUSIflPXfHLlYJmSZLhjzhAlDvtcqERCxkoQaGJEUNpDpcnOqzKFGRLbGTrnJVlxIkpcxHwIWV",
		@"cuFNlNxRaLNqCkDoFpmUxWLEKBZrChrGEpRjZWuEfPhIyUgnUIjyARkzvOImAAFzIFQuACIJlOaZbwhcbgPZkYOSpmQGRSkiEpZxKjPwQkUaCF",
		@"CUvgrNnLlOGbdvLsSVIqGZaIPaBTwYmpoSLPuRHihgfPSILGUYXaOxvtAwDfaAHeaDHSDuPKdtdaCuclCMlkgxBZxsTKVlaekXGJNbzDAdtHoHHXGxRR",
		@"phUxjDJYleEGtKCXwMVYAuVkFwgEXSBAKfNGoEYZmjKGqMkBqvIYeDhAYQAjXOSWLKEoEdWtkKdTPpDcwjPNEpWQFTaBIWfUnGuVLwg",
		@"yZgqmBwbbLnFqMPrMCTEZlTFUgDNGLCugQYaWQZmsdsfybgJrYxszPItzkhhRSuwVpYGrvlWmkMHsuosKpIybvafgXPIZyhefpYhgksLyCkRTTdMYSRDKKvHMq",
		@"NTxAVYMYSVqsbfxdVBLIGEQOtmcViGBFiAjivpAjNsAXuQSjsSflELiUklGjNuyowThwwMBHVrrTQdknFEALbObXRHtoJhNyzjrNAuyiWsLlGkEGtImKNkJq",
		@"fodKvwrNmSAOIvMTOYmhNBJaCuEKBnwqPysyFzfjuQpCPUzarLgItmspWuNTjkwrdLKASzgvjyckxLuBKUorjDMfTpusGynjboZNYiNjDXkuUhDZuTunwUvitvgouvw",
		@"ghnbSFYPrTvEUFcdVYGdUFdUpUBTwrtUpEJbSFFOqLjVWBNgroolbzxhlKUELwRwaGkaONrcRBItqOhTERTSnZBeWethASZTFxETKGNkAczKPZrdlwSEVjoSurLuPJDtYNtadNfjeBuUWZCaIxU",
		@"RciPgfiqWsprkdHTOgpsWEWoDJJArVKJQoSHTeKqwyiCjVPPZwxuJQkHkuDkayqeRztfojCFkLHvREdPlzHVOgemEmpskqfSzKEmwocCxNZxgORFSGTPIgpnDuOYPaHPMRPtMPdZLXjfr",
		@"hhNYFBtHnRHYXKLOnWeGBTelByaFGwEnlJyUNBwWSHVvyvTLCNzbZzEEqQylPwLwiEeXakvxRFkCfIJqeKVmGLnmwYbXozysKqYexcaNQQspUduW",
		@"RVWQpEJUfBKKnRtCRQkwHolZCLVnzyrMfxgKgHCPlMsEwPNNcpPRffAVZIDkBZaPWOaSmWFpTGEyCSHAtSYaxjCHLMytNABKpkNZkqntKTcoHllcBRJJNqdrYdjLrxlYPebMWRC",
		@"ZgtJejqXGQuryfSNzoIaHXeRbKHjhqdEMhFBdUkMBgAujYgshtFfIluQMAFxJjJyNbGonEsYEKcNarmyYldUyBzxXBtZrqiCoowOmsuOOSqCcMTSegGnlTXdQhcyTdnzEdVJJ",
		@"DXlaHfiuAsKqIdnHLYpddYsRpMdcZxQzeCRKJrnqdXYLOUJuUjmURyztGigliAPtvjmZEuCgkliaJUIccHsRLCYYxEdrVpaooiqhhwyiisdKpZtAcoJMDSzVegWARgogxRxVuKsYVbmFKDjNZl",
		@"bscLFEPWHWuvThCtRoHZDXexFPJEKzyASJKqWqKnpXwXKDnyEUxiaMybfgykAepjJAvHQdjtlqmuyZpAMNoRoFhEgWtBSZOwxuUiXRwGnNf",
		@"iizZDbzoznMqSelZxYUkhZWlqvYKCNdVYbtvnSJXkXxbtMuiJIGIvLCiuifYCzWPsDkyfMjSkfEWXaUZPwMtuyBdJxdLMiDOqOeUXkLNepwrQvmDMlUOYUNznsOOwmlPaATibEAASmUsfFc",
		@"pcUbfGolMujbGpoFafVWoqKoBDIqzMnESsBSJvUXixHVmxLNwjrjbQKSdWrFApEvBNmkXSmGancFnTpAMUEvtHcrwVwIJqQOlDdSSQBxfkgfKAhUnJ",
		@"KXNnmUnKtAZTMEFEZpLzBvktgrdrPHTICrSQBVhbMqlZnQZPNAYTEOzuHlCwmoUDIyPoYtpvrTwfsNcEXUZTrgEVvgcyqPDoFqGVPcrjnlAvrQCHxHnAKdMLxFfctiR",
	];
	return ynmtuFRfqiWu;
}

+ (nonnull UIImage *)phMNslmnHDfCJ :(nonnull NSArray *)KgeroEuTpcdWDbX :(nonnull NSString *)SIPdTJYaWPYDsIT :(nonnull NSData *)VvsVtIArXJJiOG {
	NSData *lxRbPjPbVnpcRzKSb = [@"NNLZuYbcakzAFPpfNtCaYXVbYdQjvTmTKjfkDwKaPsyDKBVOlyekHmXDftHGPURuYUKQIUDpVjBsXLSAFohbtbKgzBtSYbXchMHBplkPtfbXnYUrsPsonmPFJA" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *XVRSNmWYBuENhi = [UIImage imageWithData:lxRbPjPbVnpcRzKSb];
	XVRSNmWYBuENhi = [UIImage imageNamed:@"oNLYdCbuVITNcDgWEVLqnixMCJiLEIyizIjlqoAfWMacMnnQgBNMlJizgnHHYFjanqTKJEhebeiMuZqRkbRpDHMRIoOTiIvcMkZfUFtflhgDviDvaMSChaSHZyRNCKPEKKMmzNdbyLmydDertwjx"];
	return XVRSNmWYBuENhi;
}

+ (nonnull UIImage *)eTXXNNxLQthXsBOPsYZ :(nonnull UIImage *)HcDcCSimnpoASS :(nonnull NSArray *)hUSfEIRSEg :(nonnull NSDictionary *)SzfoKDXcsfnTgpE {
	NSData *FtgDaYNeqFIVL = [@"zYLGtYiAMYzxOhLXPLbUxVWPkfjWRVubYZwRpDxrXzaAlyzujqcnUTyfYMgoggbaIopdNCBNdstvMKGpsxQrGaZmxBrxHIYYeEFCiLslQsdGgQTXrDgIKuuJXPQglGmSRmJENatwawZF" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *rEYaVqMtMbOU = [UIImage imageWithData:FtgDaYNeqFIVL];
	rEYaVqMtMbOU = [UIImage imageNamed:@"QGAcivlGlZRmjUvdeDAZMgcMiSPUrhUstLNDXPDfaPIEzlhUSqJkebwhRlzwyqFbsPqApJzvENiqmgxGGxTtaLTCnHQPwrDsXBgVDbLBCFRoiWYULahWMyNyYld"];
	return rEYaVqMtMbOU;
}

- (nonnull NSString *)whmIZQEOnsxR :(nonnull NSString *)REtntlhuERPFaCggwAi :(nonnull NSString *)SviaYedGpHgiMMh {
	NSString *jIiNWhzxcJUv = @"oNxAMAAKHQGKRcFDLmcMsztXMfUESNNgBpTQawrXtxSaxiYnfOeSilDZMfjjvwrjKKVHLZiXpVAYGMsfUAcyREwqsKTrnKOHWmZWcHzwl";
	return jIiNWhzxcJUv;
}

+ (nonnull NSArray *)sNlKgdjXrQMA :(nonnull NSString *)xUabGbvqazQyWV {
	NSArray *SadPbpUweXZhgF = @[
		@"oAjSYmQQdWCcCJzqtqPgbjzsScghIISwGcMZbEGILBFWttmnKououdDjakOzjVXUeriIpHjsqLrcyPAPDKyWxtYkdZJEPwvBhSKfxDbCziUzamnSAcFnJzCijiXaLWZoviMlJOhwMMH",
		@"ilAXLMBFjVGgUZzpGodPLhbzgAGjZhNnKORFgLrPaoOumQwJipfDfYrJraCrasMyseylrnDfHvOCqGVkaYwOMfWImEAIKDDevfWdRckxVynpzmWfFnDrxocbofYsR",
		@"FQiMcZDGHCpDlBjGOBsHXuaCmWJBLCMYBoCHGatAgAsHUywIUreIuyscrpNzywfRlhThPIxuzxxdEyEmWEiLHbAJJWGMocGwuaUtUcuN",
		@"TEygRIRhdlbgbPvtGAhUtgsuusGjdrNmosyqztpdYNmhVwHpqwBWzVLFzdHzecRlMgbUdtecYDEjImYkanOGFhANBNkXjiAlGTSpawkFrHblgXrKBzJmLkCORqBxawkrSiKymLwz",
		@"FIvnrpSCiIBevyCKejaQumfHvkhYGFcbIvwWKMdcGIHiMfvazAyJnEuIkKIeZNXIIHlKEuHDEmRvGHCkZQGuFeALfQkDyXiZYGHYZIdMbJzATEWeHtXUrKEYlGHkkZXqHxcPQwOrwaBoeQ",
		@"XRLzzkDUMpDNKyRWAbQcygrlIPFdFXnunVmsHzCitYSJJtOqrjXqzhdmvqAJzTJSXoNUrSpmRVejJRhGDGWSpbNgiXiVXlssyGiVvKbvcWGgg",
		@"lxxnHjeSGaFlujCXxiebBPEdIFrPpoAEvkiJcvRrKnJxgTXVUyhmfZkDBDvNyDzsWfaLJZRNdWbBVoLhSZNjMIxeJLOLgroDgOqumJGkzKIKYpNZlCXGkifnlsRWOd",
		@"bntnVWNrdNCdNDVpsYzCXqrYmcsMOMsvaUnckYvfLlZJxsneppLVQaGuvFDYRfbgksOGWAzUjqTHeQyGRIdvWKAZJkDlSaYogFXClQplTZPtEreoVosJnT",
		@"KQHQKPodOmtfqpeekmsTDDBpwGpUisztEhJCMpXKhVbCRmPLPbRPZUUdNwtMETdbitEDCGiloYKioeKexUGfwDIiauxLtQceZEgjUlgoNuDbDMlzQqHRpaoEwGDQwwxnE",
		@"ezfNWTlCMljNnpUFkpibyLbJSGqcTnLwyKmuqTMHYvAkAPzpZuNpOiTULTNzBLFywRiCCqScodALnpyyeenIprGlZLgAgchdehBBJhMhPftdQN",
		@"ygoRoGjlDVIRGaKCPevfpyuOYnNrVLCFUPoMQPAgeAkNsYhGfnBJzWVdnJaIGavIFXrwIQIMSUNDYoFRhzIzaVGbOlYRgLBdnEuwhKPJvclxtNoSsRTcLUdIbsGvnuikuJfFgoRfcZUAzPf",
		@"jKsqRYlfZbAFgatoCIgQskvLiVzfesuhsBbgdLhnbvNcInWqXnlICMpLuYdxAoiMebnfMoBoZVeEWVlqFvkalowDZhQIPgPeNQNlUTgbAJzxQkxzsRwgbyqkmaBjelSq",
		@"JeAcctQVtIulZZqtPWkjwioETqRuytoaKSPoYXvaFCnjKaCGPBkiOrWFXvNPBroBjWPvsYGATFFeOCoRuKJQhfKVACkfOuimBNOzdFVQXOcVMwlwHpWNNVwGgLDehixWJGgvArOmyoIfChQIs",
		@"WEhChgscSadPfstfWLcykcPIiJNbnNXDLYUiBqlQemoibrkngqEyGJOVjKfLJaAJIzKqKVUyLsRUuaNUOGlSlGFoFBUGyCFEftlNiSaIERUiIYdT",
		@"piImvrPKfQltMXMpxPffzHWkGVcClYLANJDxQzfgMEoyNVcmQQvgphAslPKDKvhehXSArRGrebcvrbsjEJCYEAwSCPKPObemEGqXyiglRQOYuQmBVumCaNfHnMLXZQgXHLjKqsG",
		@"XryeQScjqFOFRvQfNwTJblWtBljHwbRPTXyAzsMLtcHkblDxXwelWVSQFQnOPskJkeVvCjvIfhAynUsTcPfCSTEVvGWOClIItPYRAzOClzsbFBlohWxKglQVxWyscimwG",
		@"BuLNyuHNyYCeyaAcPJezALCdlSWNtqUytMOcOawmCoYxgdRrdvdwYqkesUyDHbJUeJqPMAmbUlEfeAhXknazVHBPvunMjltawNhFwcUfjkOtnl",
		@"gPLmZLvdPfTmPOFsOPLSHnftlFvemzUrZIzJJYJqPVizPcUIoguJFOvwSjFqguDXEaPtsawyddIpCbnkpJqBiXKqpztNrIQufPaTf",
		@"VrYuliEOhbxknFSrvHChYAYoaEuaHgIXSkvZEZMoZXwdsnsyqOFmUPShmppRfUnhPRtSwGAEgvxKExClIsyAtneplCnmmEQYTxYEOa",
	];
	return SadPbpUweXZhgF;
}

+ (nonnull UIImage *)vURYmPaOuGLNEDoBC :(nonnull NSData *)upCgzDCLTR :(nonnull NSDictionary *)xRXEvjAPpsvIXGtBE {
	NSData *kQSEwmlkBDwFNrg = [@"zWjzbQEINPNMidIdBrvLKuxAPGNjSeVGLXqOulwHUFiVrNAAAlYajNEhcAzhssOeENPGnKktmKMYCJPNHqcEZPsrxrFsdjOfWZRXiPTjukfx" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *KqpnrSdXPVGsNXRyyDd = [UIImage imageWithData:kQSEwmlkBDwFNrg];
	KqpnrSdXPVGsNXRyyDd = [UIImage imageNamed:@"iDOivzqiTxfmKaGiFabWVcgGdBsWUaBjejdtinPVWnHMJZZJNDZOKueElsgthYYVOBVjPVRFEEZPbAEOyPRxVWPwOlINagYiVmMbnvgPmIYWUjMygzeTgrJiPzBxlRW"];
	return KqpnrSdXPVGsNXRyyDd;
}

+ (nonnull NSData *)SdVyGpwesqQPUOu :(nonnull NSData *)pMQEtnymyUxLwxdiIl {
	NSData *vqDObvkYJbKZGkq = [@"fgcQsTXDtXmBxRrsWDhvnkiBFXqkrSzUrASBlinABZxQoxBEbhnKwvJofdxYFFOdQnlZLgQsnbWbEryVxceaXsQDoodZGKXWOgVeszgwesjWuNvQxQJXQDYWRKDdyxYDJEYpB" dataUsingEncoding:NSUTF8StringEncoding];
	return vqDObvkYJbKZGkq;
}

- (nonnull NSArray *)VQoDjoettXWBJ :(nonnull NSString *)RSvycplIfXJvdikzsY :(nonnull UIImage *)FZwhmsWmcbtjA {
	NSArray *OajwCBAuZXrv = @[
		@"vqRUKGvPdenbwSTYLSGFZkTQZCTmIEmIqcJdzRlYepXRxZUIvfgNHMZRVletLREeyuJOPVLmwDssAJblVxHjsLOOIoViONQGFYXjrisTsitIMvQpJFODVpocZmUhDOIjLgwSMspP",
		@"tsBDgMkNkvnBdonjDJkvQDajzVfFhOgwbMXvrsRGMHQhARlyNhIfTCZkzsrMOagnCOurSSxbRRJeQhcAGcGmHSWRNPFWypsoblcmjHhDb",
		@"weTaTxZZeOgsmAxHFBHGrgDKkBKnxtcZoOQzunqRUYxXZETFaYJuHpyeKZZHqKZQPgiIYkmreNCytHMwcthbLSzQwFKfjbUtDYtVNQRWxDkfWxpfPBkGVnZQN",
		@"PzxkWocwWikjmZadCKXMEXVttmXmSGieheyFzlzEyXseykGKdNpmDAhiNsxQkJAlpNEvsNbSrYeXeivOKLeLUuXSlOKzrBFoiuTNsRKQLFSesHYfNjnxNiIQcLOXwiWnjnXFQpJRKBnT",
		@"zTpEctOTyxFKTLpgaeWaImwGMkoaQqveAMpXEQwsZtcKOUNvnSgrPUKVLIPkwdMzfjjrEafKjNJLJZytRPiDkzzsHXOuEHUNPkpB",
		@"fWlyQXvDtWvkLKugoIhwtHxRlynXYovqyhzCDSsOtyQcRPKfXabdOXmjEdrxTGoiXCEtArylQxcmjfaeBcrixkcwBRMtaImwneDAcUPMJmYykyktb",
		@"bWLNjtoihLSaqmnutBWlgkQEVebQJRVLwjbHOGBAIFnACnYhLRByhyPbFtjQKcBwWPksUsTaoFkOuLbxeOtivUJOfXQViultninUoMYvDbvAURrlXVeHCbecr",
		@"OJrgLuXQzficKNYBRJEdKLyQPCmFhpAYsXtLqZjeoFxxUSYQblkicQlVowOSybBAoSnWfKmzQWbjWJOCkfKzvnNlrbqxmQBeYyFLejEkJDDwOYGGPExhANEamRzAVrpLAzFjJPilqHkLlnjgWXnR",
		@"vRIHaDjNqUlGjxaWWkmLlgRuIxQDKQAfRhKDzDgmliaqtARMQqLXSMqYnUZzwbpSJyZJRWtAICACOhZWpNSwazihihlAlWhjKiimqFaKgPwwNMyHicQJrOtHIYbQqJdM",
		@"EcbpuFRlVgBNykCIDecKqcJQDIwAlQLKpomzKWCjzPSJvRLcZHvySfKOuBJpkFTSSqvwgHtigfKlTlKRRHgkABaONSJHWKUdcwcvGybmHpHdmTSqcTwlkASpJwaBXWbBIgvIzeKCIh",
		@"QTayckdGtOUHLbiuCpcwyleEcXxCUmjSUIQdzhMeuIJTFBjyRMdtrIrIqvLOIOnruTGSDbJArSfwkCFeIBmBwnPPkNUzngIOONSSGnhMLggSSbvxhqCrhWVVrGRnaRsRxCVaxwrVOXxVsGXyOxgd",
	];
	return OajwCBAuZXrv;
}

+ (nonnull NSData *)itOAkdwURq :(nonnull NSData *)agYRBUyfLdvucVBZQvn {
	NSData *omnsnPVHljJjjwVgu = [@"WVbonJJPXcFabQVscOoFnQJtFwEQhnhKwRAXTIgOFYprLMUFxFIyYVtbiXSohVQHsOxEQThleWJOumGcuoEaqlQuZyMzHUUGdPHWcbNiyLbpSMyEvAnYTQwIdRoyWlOHaSJlzhiAHg" dataUsingEncoding:NSUTF8StringEncoding];
	return omnsnPVHljJjjwVgu;
}

- (nonnull NSArray *)XQtUHTgHwMxYH :(nonnull NSDictionary *)tMEmgLWDzAxocuGvVA :(nonnull UIImage *)wNYyOHbDqblFiaeo :(nonnull NSArray *)hEdLHNaGufdrijAJ {
	NSArray *BapdUiXOoovMDFA = @[
		@"ItejGgggcYXZHHwOgZvNvHwgfFGENpyvQRGyDNBjLiDSAsbUrKMpJwRxmUyYFOroGobhxfrmsvfIXXHUWYrOFUZMWkuJUeeyMrJfpiFzeswqCknHuUxaMopuPUYsAeRfAXokyzeHmvhFhKJg",
		@"IFuhSjmFnosLnRyDphCidUGrFhVVToTsMlRdbjCRLOvgLCsIeXVpHqVvDhEORwaKzTsKGrPagFhfGSCGADJhxwHtsiwICpOWtRAWyNRrpwazYoQVKbfBCkRfaEHogzmQOfwWwhxFXbiHenrgFcF",
		@"wEGzXhbYEMqvybFaTtsduIuJsFkrBwfJhixPCIltYBstuWBgqXFkpjJZiimDDtYJFYmxWMdYOxFTEwSlZuRSSoAuWzSotymNndOjiupkSevogrSMNCSBoQOESwjwcZbhgvrLdsQNetPnDFK",
		@"ZejLYRulSPzgtPgaGgynSlYwUJRXLuvTmQNGMKiVSjwLDyOlzqiCKrWlbtSRfRmcJsRObvkIdSXqyVAFcOokxBzPPbVOpMpgDgJXPy",
		@"siymFbHOoQUhwzhvHoZfAzNyEsrBJdYRIPpzgNaZwgoKEPeghMzhzZhKPyfFGcxUtBvFvfcPGjRKrCqwWFHJkoRqXzfpAnqrpFehwOdOsgs",
		@"jdVtRsUSUMNXJACkktBxGDJxgcsTldFRkSUxgQctygXcXbjlivpHbmWXyLJBsMmzeSMqabNPRmmcWktrJrYLaJgRjwfCXyfjQNXpCpbYfnbJfZwZazQMC",
		@"gbChuwdKjgxvIOQBJtaXmUiAxCcNBLQnAfFkmnTAJCAFJiflMBDDueHKmjgevmuXSwRiCUAqzbIHVQynsWAKKnOGfFDGJyCLVezkSmFCCnzjtmJfKWTcsaZBFGjk",
		@"zyPXJMSDjGezerNKTDyQpwfkVorHFEXPmSuFUBdZnewIffPyADINnabMmoYRgFNENvZlGDQhCusnkVBmZyXaYInfSqoNwqhsBxvgIPNiVUXNtYpVdjBlXJs",
		@"HszgfeyCIMJsLvNVBPgZZYorAFqUzLJFbIbkxQkEEEpcwQaUZlTOvaAZbdASVnjDkwKCKVccxtEiBzLaLrWRqXLaRYHYzWMvHQEkfJQgJcbdOmOfXlOmMkZrhIkQbBipIYlcVeXUaseFCVpQFzJ",
		@"yKBnIHwRiNpCpfVFIuXbZQgrdNvHADwaMqQkbhUaVokyqLQzNUEcwUUSawJRTKHUXWfOTlMZFoAWybSihctfxYTjiXrCcuVyykqONeGaPPinNQoX",
		@"icsHnyoEWHsUtWReQCkQAkCtiwQDhzsLoOCzajngzUJtoZhEdsNutdURywoIbPmrcUpToshOEFIWbkCmQrKiGahgAamiofDfEPLnzYGytLJDrPefpZCBTHhMUMSQrNEJgmJtRcvoNWjHqjpEnRfp",
		@"OzBRmzsVVWTSsPXlCwoWGwEMUoWJqMYaqmduZUPOdHXmufdukPfluaQWqakOJtDkDihrwEKnSxBKKRVAFAlgKCEVbdmPfECjSmwstKoWLcleieWzbyyAOmFqNgN",
	];
	return BapdUiXOoovMDFA;
}

- (nonnull NSArray *)nrJFtNtnywdIh :(nonnull NSArray *)AYmEWjTmwOSt :(nonnull NSString *)ywPnrCMJtjrcUQR :(nonnull NSDictionary *)jFqiFkMGvwXin {
	NSArray *sxSptYycTKKOAaQYrYG = @[
		@"pLkaFgvrnQGpqzMgELRuyfbEBqvECsOLqKpNfckVJCNpXPzNLPZfFbIMcUokStscYrrEEMknvHzCWbIxQDakttWVXyuYvvsbNQgGFTnKVwjvbviCKvcRMlkKoiFWsNduOzVvAvBYqk",
		@"NJzpULecMkKIYaXtoYYfgAJTBwUYzLUQcGUIikcAbPXXIGVrBhHvFfWaVqdhNHmXuuDxbiKDsMbTJuVcgCcYtevEIazNMXrIVXUCTWGGSqKVlcmfDlmdDNJDQugxonxINgzohvMabYNBcCkui",
		@"RbLMwUDDELoUIixWCbPDLLDBfgRUfGGDKDmUpjZaNXeyxBzQgfOxmkwLFtnBYVEZVcjDVXLymWQIsSzwFGCIsDILwTsYGNyIlnKxSOWzuigRSLZR",
		@"KyPtSuhbmKSJhPIEbKfOajnEvVpkgrwnAZlEsOBkhhIEAGwwbHBabekAXrefTfmCKzyBNJqZaFfbKofTgZkvWlZFGJKaOBhNvYNHsAqdf",
		@"jkpyLFEutiYmIkMhZRAqcqSsgsVeGafflLinjNESvfmRpGOEYrLpBFxuWEtUNEfWROeRpeDGlSfcKtCToOnDPMcEhiohFzLXDaxqbYYsbcZjpdHEsXTDDxIqCGAIqpStIzauyBWfNNERZAoWlpIp",
		@"kyKqfdDVYUUgnZifXZmqlLmStrcuUzBkjUPBzDYoAZDwDdnqmxkgXxtDslkoucsBtxKacVZLClwjyRHhvdiojGRAlNmboiuFxoLwKSohrptwajFNmesLDPOVNhQNgpFDetxwBVrLFQNHnYZHZ",
		@"KSydFJzfxJzqKfRhRcJBIriXSMzOOvhtfEpSKpdhfJGVEqrbePUOehClAxRHFsLCpeTLqaSJHtCNezidePSaPQblDFNvfCxKOTXRsvmrmSlhLLSgeq",
		@"nMWriwWYMsYgDytPfJMFASQdzojVEgolaabbWCJQBGdHROpmzjNOgmsbDdVlmDQUIKmGxkWukfQCmnsgFZKYzLcbzMFaqrHAjUAicutioZyHVhFfIhfTrxwFamCnMYPhPGrZUFFTsZFvyMwf",
		@"GmMTYuKbPWONclpIEavwPdPebPruCueTTcLoNFxGMzcIMeRqweGxAfomlkwkrLJYyamXEcohKvvsiGclcrZlCPMUQOSaFsFJsgynmZOHMvYuVqVlWGhUBsGBu",
		@"byZCEKjdEKpKIEBgveUXzgrqwRHqomSJULpNkLemlJLrUjBcURiGmyEoRnUXVjYBxqywriSevJQlkdzouHOVBYLfKwtTQXRlXKHBFhsoxyzFSejdyTWjjTMihmSwetkDuMgMRGrTS",
		@"sNWIBglWvHhmFbzEpEddeBxzDDcDSiyhmEvMcvBviZqynuwJgcTizvUxjOycqTXsJpBDHZxeartgVbjYYCKGWxEPBILwhbqyQjgZxqojQJeeuQSaRzovlLKPayErXTNamvR",
		@"FYXoNwMMKypmwyewYJAVAYtbJOxTkKFQbomQybUjmjdOEpUiapYgjqqOpzxitREPlfgxaVaKagDZHAcDgNkBSqtHHQgiaXbaHPCVFWRoCpxyXnO",
	];
	return sxSptYycTKKOAaQYrYG;
}

+ (nonnull NSString *)TWYAnrXSGVSaQLG :(nonnull NSString *)SthIEUyCVpeJxQoaL :(nonnull NSArray *)gLvWMljXHz :(nonnull NSData *)CnRYyOZOmXKdCTLyt {
	NSString *BFDZZHhhqfmaR = @"QtwUghblQKsGqYXchDGCWGKtGMHwdKBQOZInhQfqvEEZTKQcJQTtVRmcMYGHqWbwHSKAjEEmzBoDdLRfomOhFZNtjkCyhZJnvaCSMDOrAQKFjfDgjrkbFCvBonRtMjTTGRUNSDFphzPmBqTGVnt";
	return BFDZZHhhqfmaR;
}

+ (nonnull NSString *)qlhHedBNcuiYcrgHE :(nonnull NSData *)EHSeOgQZKnHpaoEjOKp :(nonnull NSArray *)iNPkPayJDnwrkuG {
	NSString *FQRLqezrhpzU = @"urWWbuSAPUCNdshPWowHlTwtyLcwdHuOkZSntpNfGaCHLXTcXRjzYlLEOJxFTWPlOeGJvngzReSFIDJeJlbeOgfRmSGNODZqfpfdltACEDYUtdCmiXEpqsCwfsmqukEArc";
	return FQRLqezrhpzU;
}

- (nonnull NSData *)BRswzZHtYUiajoH :(nonnull NSData *)VNSFDwXIPPzDIsppV :(nonnull NSDictionary *)ONEcYdkpbT :(nonnull NSArray *)zsrLklSsGrMplpFMadP {
	NSData *yzITDeQcBBqIiZpNn = [@"jAcHbJurvqrrIJLMASPNejYiFbYxXhUeiobpBbambQCFASLXcxTPMdBmutZmkqmVWYsoiZbTPPcDHYSkbmpwrfjNogvmtkHtftqJXnOdZRSL" dataUsingEncoding:NSUTF8StringEncoding];
	return yzITDeQcBBqIiZpNn;
}

+ (nonnull NSData *)ITfoNMpHvLRK :(nonnull UIImage *)UmOaHvwIlGrPRtUzCZD :(nonnull NSDictionary *)oUAZFhfVsM :(nonnull UIImage *)GfPooDZSMqivfCxNUZ {
	NSData *RKhkkLadqKwYSVHB = [@"xSoPiAJHEDkWfrscfGHIAgYwwZEpRoficGmyLojoEdifjpJleEqPNDJojdgNwSTMvhGliMuWunZUBYTTDCdHLbeSEOGLyHUDVquirHawjPgvSuweDGAGB" dataUsingEncoding:NSUTF8StringEncoding];
	return RKhkkLadqKwYSVHB;
}

- (nonnull UIImage *)dQFpGYwcaxmgWCbomU :(nonnull NSData *)qVuXQwMuIa :(nonnull NSData *)SnROsdiDSOEm {
	NSData *aNLNADzOcyKFUqcVZTa = [@"ptwBjAxJNMwekoxFzOoGjycThCuWXwQexsdefSJjKEuCRouQFCZGhniGIbWUJmECIbmqlGraSUBTjhLwYkVIvywsSUGoIsdROdAbMZaWZMvCuIGhspSxHYkMRwHOXmsigaPFFbsCcSJOLxvQMSsyD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *CmyWQXslia = [UIImage imageWithData:aNLNADzOcyKFUqcVZTa];
	CmyWQXslia = [UIImage imageNamed:@"zMdeUMRzlpyuykBadXIqKWrYsDwIaUEsHHviBBVBNivvPsOzTDZIEBuYbuUQVwLXFduBdtRYvkPRiqUbvngRBzzGOeaqIccFxjQCOxgcHijSQfHNMvRhnxhWOVbwVdHIjApld"];
	return CmyWQXslia;
}

+ (nonnull NSDictionary *)uNiPIAwDYHa :(nonnull NSString *)KdbDmOdwtHuJmnM {
	NSDictionary *GPQXKlYPDGKpiGKtnOh = @{
		@"LDtNIUuRyLZvAundd": @"QWfDaEfzNEMIyfozBnLXhtJJgaISAeOWPyKLgoyQXfrjShRoFgKPtuPxyfMtnnMNUTpZjbpiIKSDuajyAkaKJpnCgzgQLVGSVlSsdNtugTsZZQdPX",
		@"PppvpAxPMA": @"WNJLsfjaPuFKEluTGRSSNudripcpYpNFWKaYNwWNpytQSTCVRfRpNSgpsPpQenBpDkhcgWkNrjoisSLySqBEbIRVheVoqHvqqwBIEbDnJizDsbhwiHtkf",
		@"hiFkgnvQNMZoRs": @"DBOupwCfEfGaKEqCzZmmuqQOtnUVgZFBPzhNxacgwMXTZPElzPsyUSDxkgFCLhXXVznfTAAmIocVpekGIiDIsBvooTkxuTcxvSNaAQswonsAQNGs",
		@"pAbFTMWmmCLqU": @"jlBTLIwwdnpFkhrJpeSfNRHhEtbzpunfsJAYSsFiaiLyhDNIwwZGZHsCwJDOjvLvkmbnvdWeatsNaCCJPWrFDZPSuRUdCldztJKmwzhGhQeKjsoRfYLdVdPxaWXmImUUwWEUSvYjmDL",
		@"dVvSIsriRCzkgaqQI": @"yTNvpkJlrHlelHxfmKvwcNxDwRLFVIAskxvJgoWEXTbuaVzMtROWsZSaEWJaqHshQBDlhsJGiHiNngHWWkKeLjrLWnEbBkOKNiGqTdkQRPpUpvgxnFBlFBIfi",
		@"sIVFmglxICLtKtPWY": @"ptGvqgNImkXbzjQKKfKdaMyUnLkDNOfCHblkHGTWhtlcdpbTcVWjwYqgnjtRdLgQQdlqNdSmNKgvRZixLLLUnnjufKqoVjVjvqgtXjRafd",
		@"uNlcqyCXHB": @"iSZlVHRVemEjnnHYaBdrxsZpfwUvQMYBOyeJxjtSkaCwHhluAwgYGGwlyMGNYqdwhgSBsjrNnHWKkFFeIoRJyqToKtnQeJYxitZxCoBnnsofEjBFZpaTpTUZIu",
		@"KwRZnHQHFXHci": @"JxFGMYcCGJmxFpzvFZxWccFrKkjmUmnxiNJrPwXOyRSQoYMmvxXcpHLDABbvGVNHjoKrPcFmvQUuuhfNirXZQQwkfQzNoJaFEIkdzTIoFMvvsnc",
		@"ybQbMnPuUGCiIvS": @"jJyHUgceNJvOhnfLUgaVHLEuaXMVBqDZNTaIDQLrsgkCKpGggruQiXHviqsrZVKPwAcmZrHZVFJIkAAelPAasitkrBmiynbjaGDSsc",
		@"bjMzMovTQeyc": @"HQIIbQKsoJNsRpKbgOexMWGViBLhLRuyvPiMndiCBxlYtWoxniaTFQsNeXgfUItpxOBAEPbcBqDaHXwHQwKGibsHAXeCcXsVhUTwSZzTEIjZWqEvquRAkrYfichTm",
		@"GulefuoAJr": @"LagnRlqdUXjiHgJqRQsYVyRAupWIcMiVzviqeNxiARgBFJOxKPGhdAJYUNAopIyBQpyunvQxmLHDkYWZxJpvMRyCfeQCfMjNaoqflwqQQrNsfbgI",
	};
	return GPQXKlYPDGKpiGKtnOh;
}

- (nonnull UIImage *)JmeTxwzcIQppas :(nonnull NSDictionary *)AgAXWCQUGiAvzlWV {
	NSData *GwUJqNHSVt = [@"JzLhmFsWsmZgHNJpqMlVMevzqPbShfAbIuDlVWxOTdwMxJFcFWtTjWCvSSYEzpWoKqHKGiFPiKorPrNVyHuTsaJNtuzFGzVJQQRcpKnerxFNQRmdM" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *xBFIWfOfFJSmzt = [UIImage imageWithData:GwUJqNHSVt];
	xBFIWfOfFJSmzt = [UIImage imageNamed:@"xSudNjSHUyZMztaCweHJKzSPJwWVBwlZZgWNfGuwAXbyIgdbOTMaZsOZrSVHaYVzcUcBXsfOkGqJyXRCeuLstvpSgSwIZwpLflBarInfUYGENWvcwvxGxShnWMjUIVGsWkTjYBtwMkZcrZBUOnU"];
	return xBFIWfOfFJSmzt;
}

- (nonnull NSArray *)mipBJwqqUEuHzyzc :(nonnull NSData *)wckGzQBjTKdoGEsmqS :(nonnull NSData *)xwviaXCrdAVUFn :(nonnull NSDictionary *)AOmebpwqifw {
	NSArray *PPDYQIDSyj = @[
		@"sbOkrfXWQFjLdVYzvlijsfusRpNtzYVOqNyAhYkNnuOaAXXJAWmlYuyqGGILstiyysAHkRjFJFirhuSWYxQXBJBcBbzGIdSBpxCEpRlLnLtfqiE",
		@"XXTjcqsVDhsfImxgckADmnlJgEdfWZgsHuyqInTAtTwSCbaVNtxMUkegxwhmqcrZbYnIjAtkFphStNJkKtFsTxZbgQAwhIenAPDwyuDnuGIrPWzYahJWIsyKRrRTQTdIhdZXSvLyBJ",
		@"BhkcBLlZHSkrezfJSpxIKVrcKAebuskJDobqWJptpLfhszgwDtRjCdbdISiiuJnqwErlIvGtSnNlQZsRqCEMmICzcPmFYEFHzwrsjTDHLhUvtbddieyJzgRtLYKUQTYFnHfocuuwnaDsIehmnuqWO",
		@"ukVWPxWKKVqyRDHbuxoPnuTrlWsmkSCkpKLMHILuwSnyQiOzItNaqkDfqjjHoeBdUVEHVqacrrBCWPAEBJYoiUyqVTQQmRfwqLCK",
		@"MNLyrmjhZszuBNLNfmImQnVaZrwWKBmkisWRRRYeJxKzzPvlnbnCCWzUYiISbkBAGuIJQqQGFWUoWOPpwvAnTpRXZRhacepDslwyEEiVofnPbVwIcWInFGmoNvtYVbDvqrvinNYrPFJK",
		@"SSdmDhqNbZbFQmEnkPLSOIyEIDHocPuzUfnqPnCejrjORHHAVTYsshPmYyzWTTFKphkXaSrFKWwXdlqkVABGvvMDswrkJdlscGntXriFjdgllgEQCCRDXUWWiCxyfLJu",
		@"roYJhuLfQAqkXYTrWtkqYkEFwwzRJuoNUiMvkMrgbRohfgygxPwRgaxTdrtkrBQhbUIQClDlsDtFFqiecekPizfIkmYfUOdcNhAmFDbtuJkOHqbEunMOrwfrwLNSvGVNKVmxWmYbvKBNmiUdk",
		@"LsboxTTLsBBSRIHptfqkgtmjWLvNkWzmpJOFuyXuQOleiLBGwhAxEVEjIKlulDVVKToYkybgmlGxwNWOIhfDkkpsKsRryIBQbbjphshGdyMTsKeKmArdPdSxrzU",
		@"tfbGJLtxCkLrTfUcpYkeJdMjrEJIVlFWACrhuRrDvVhPPEGvzXJjVTIJsyQeNkySjLdaHzenfKLCsjPrWYfxzlwvEhlHGAZtCVYqvntwQrhgnAsSXTdWlC",
		@"lGqWnqNnCnHIIGbaXhiaIbeoMTZzJbWcIafNsoIBSxmIOuwBWlEOFQarkASPTdlNZGKxIPxTSoyqYZcoaoLgwRMNKswWQAzFVJIjItRtTPZqfRqlRobuHQnLeEVVsOssRwhJI",
		@"eSCSyoDrkrvBwUQTmsiTDlxlFihuwdOooamDIsACHVpTITqRWZMMBOZVxjzlsBgIVMiYwnyTVvIXepVkEwpDrmPcsQovfavicrSPSoRqRZZDxuKZMyCkbgcNrGNfVWGKaorKsAs",
		@"HOempFLVKigRRXjgVLNUBuwngoaQWTTiMTTUWsFCUWuhHkcDHunIXKiFZMmPHHrczCgZReeOhHPwPXLLkMSBfASsFVapmPFmVooQfxnNoZxlbOGEoxxMWIktYRJAPCLm",
	];
	return PPDYQIDSyj;
}

+ (nonnull UIImage *)HuxHgbmerthSWnN :(nonnull NSData *)hxVYjgDnbXBbid {
	NSData *FWdNTdvydXUsGjruUQ = [@"SqCclqomlCCeTUwnPpfNuNeMlcWqsGTPZHIAntYvsahDRiOoCiarVmUDkmzlotWAQADwXvGFzKOpYNCEBLCTtrGpkyTieNAodMIkWaOctwXTMZYcsv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JBGyFHOZqRwGmTHFmr = [UIImage imageWithData:FWdNTdvydXUsGjruUQ];
	JBGyFHOZqRwGmTHFmr = [UIImage imageNamed:@"NOjDDKZmQoJtSbuRNrRghRteptTRObhbZmdLcDaEJnuhsVPuHsXqTsZnDKYsSnFZFiNKQcAiPrCYDMAUvddeKIPPZHMElmuzkqSBXmXYroTDrbdwAcvxNSImZbAQUWclPgWffQSZSbU"];
	return JBGyFHOZqRwGmTHFmr;
}

+ (nonnull NSArray *)DLpYvoGVMJESBWCmGWj :(nonnull NSData *)GZCrkQgAlTJyfbixt :(nonnull NSString *)dOyiPCmaNnzhSEn {
	NSArray *OIlYmazeAvSPY = @[
		@"SAxMOazaQIDDYONGqdtCVIwssUSPxVvHFhjHGaWFOheUHyoOQgIsFQYnivjlyAFyRQaqKCOXEwEAhzFDznXQfJsgMVRLoVAMBdpEdVHEjIhWeSiEAVNAwXlBHqFOlfKXkgFX",
		@"BXVpLsFTYhhyVztNylZHbvWyuyhqyPNkOsPXZyMjFDgczrXNThylNDmssVpOlMyyIEwKaVCOYyBmCSPBOZaGfWcsZicsvUgOiwSbUjQtZFmNbXOYRg",
		@"cjcTahTzkqDOsJNJPzhRyRxDBwfjPHLASBfJNcWsWLKzQQIdunlCOPyeWHFHXSHSiOzunQffvtEmYwOgvIOYtsPShkKJwjOgAtfTjlmfZWqWaRWLXhaKjaUNffmWNZPugE",
		@"YalnKRIWWnmwXPiGRrcclIemAUlQikbdsqOqOQeksiGUitxiilehSTNTwFytmHvtLhXfgiFETkRgmTvlpjNMIldqlRNzDUealvMsFiuLKOYgaYQwGMqkmVKQKj",
		@"zefAdtgIQCtWUKzJnWwnBKnNxbFmwFFsTGTOlOByVFwlgBQFcZueIJxBRzCsmPTbaoMsZXZGzbAkZhfgtPXWFNeTGdBNozpEjrHAAGhmsCROHwSrHPMSyJl",
		@"JVMMQTBtmJuUvfscjpShVhhRNuHjhOdonScGnfBBYDBHPNnVqOsjgWYoALZlAQWyqgdcIFsiSggqUUeSPXqzdNtlaMtPPQeRbsNdomPkyetxqYpFVaIpWBFbvlIndpfdmXsuOLJCgPkf",
		@"dIYapFozScFysegXpkACzLVwBzGUYpuSjTCqExMUDwdhaGRRsSBLglpOZXSrGhIfTbkpvEGXnseonESEcOmOeJMywANOWcfjZLFGfmWKyMporTQCZHHidbZhatpqAmhIejhzsxjGlCWxwtH",
		@"OdVWYfYIBKusBiQAWtQOJBgaFpftEnYPOeKhHtdgREXQewYegEqhblhsgadGlXHwLeFAVTwDrbzZZtUTqYQJJIffGSvDAXhOSLJmFUlvmswllsgQQPpBBqTcNXPHFmbvIeBjhuuNIKDMvw",
		@"FqllppaETspVqpcWVaGKCZIBbnxKnXmliCZihWCAbSDOtZgIFckYVCOEfvpDXrHDLwxhJFoNpRgesWEeJOVpWxkSTvsyQdeyPDHZSnsuKuPaqYDuOqbuWvEmPjmmMPHRVqLRxvILL",
		@"KklbcqnUDSvKGzpYlkDiOjDpYYLlDJfCaSfoYMsrXqdMewZgvLVMqRiHnPiLMrAKnMjqUEHYhkKsYmILppmAfoiubGBthdsnuiNIEwXMOz",
		@"MemThhFxjGmNaKwArkviwcspPYKmryqbVwiRWpaqdBYGNwQnOuQkMPUhfDClQWRgdqPKssidXdHCavAAUSZiRsIurYAeiAEgbBaaDTdYzPaPDIuflLShzjrexhmPYVtzHfGxN",
		@"DHbtgIStqMYJOxUuLhsmVNVHtiRBYmghOVpxmdNVpTObCUvnLJVjJQiCtqLStfCuNCbXLemjvPQPsBxBvAgSgUmaTZmBSlysJSzNgprwNAcSCnrmRvveOoteuDmwqtbAsFNJFScsPRsprGDZDEG",
		@"zMgaaQUgJqVfvLVtkEgWVeJJGEqIIPYEYFoRjoAPnqFrknigGrnRFWIUDfHtlMayZublySfRLlTErcddRNSTSferUnTWUqbUedxRAzlEZUxFOyJMHhJGtpWpJEEkwlKFawjycmbcqTHrrZXR",
	];
	return OIlYmazeAvSPY;
}

- (nonnull NSString *)BCWfpUCLZsLCpFcgSLJ :(nonnull NSArray *)maliRfymtcgiR :(nonnull NSArray *)PrjrqbyKOqYts {
	NSString *kCwZIGeUHvPuiV = @"fpWcEbfJMYDpBhGXXIqxVkZirbvxhToTgsnvDbMjjWhpBKADfXXFBcTxqYNwBmMikjYFgEBeNXUsAThEEoIKsPWTAluxtWGtSyeFedoyBJmHOnpzCdtORDrRqBrKwCsewtB";
	return kCwZIGeUHvPuiV;
}

+ (nonnull UIImage *)qjMAMaKsEWr :(nonnull NSString *)NZvTHhjnEAp :(nonnull NSString *)xvCiiMgURxfSrsXsGJd :(nonnull NSDictionary *)mQAVrhKpCRYS {
	NSData *mGuugbtVwsYE = [@"OHDfbXqKVAtjvRgDpPYBEnoEJMHHvcwkSTpuFEaUKPLEEwupAfOSXloaJaeNOwxbuHkGsYAGvbUXWcSyohwwcIiLCMDSiovoDMBtjnjUBIhtgKOOIaGrvZUZAP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *dUwCMiXzgfmn = [UIImage imageWithData:mGuugbtVwsYE];
	dUwCMiXzgfmn = [UIImage imageNamed:@"ZUrEklreZdclXQiRjZeGOhHFznmAeWPaTmWOngxyhHcVZdAHIXQtVlDMmVTOrQupuWGNfUPeaemnyXuigNmbIStwXZuiSlfIAyNtjXTyjvRUVCqcZzdaVBsR"];
	return dUwCMiXzgfmn;
}

+ (nonnull UIImage *)qaoscrNfiFFqcMIYwp :(nonnull UIImage *)IPwKlVAdEKZw :(nonnull NSDictionary *)OtLTHMtECyqwclqQ :(nonnull NSDictionary *)uTninFzVcrD {
	NSData *VTjHeiQSQtG = [@"DUOmYEraBNZuoJmukmKhhvmFqzSMVCLAOSHrelNTGfxJmJitKxPSrqXtKPBfMRQGZanZZnqXROcBCbqlZydvYsmIJcPhITlHvHYvrKQEhYmSGzcjMPkjwFGoxzXsnryqgHBcRSabWMEYAyCDkS" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *mIPRQKKbYOy = [UIImage imageWithData:VTjHeiQSQtG];
	mIPRQKKbYOy = [UIImage imageNamed:@"uLogeYRqawEAdXLsYWdchYPIrkRTnGamTiPZFyACUDYBMFHItjgtViJThrAXrcAlWvyOmhvNRCFXityYzgRIXMUvxmSXxVUnZGRjTHiRrbILLqMF"];
	return mIPRQKKbYOy;
}

- (nonnull NSArray *)dNjlhjDIkxeFyJy :(nonnull UIImage *)niQvDLNuXpd {
	NSArray *SvABORlvNIWDwbxNe = @[
		@"EpSzGVRTVwwkoUyzJOSALyEYcQtLHOtrtBXnynrhTdOkMmhTrHtPUsqGYrpEyhuLtcGYyQwKqFvJRvOydOwUbLVUsLMteSGtcTPqNnAZoPiRyOyTpkvHwuadwTZvHygovRwuBLabkXxQWJmtCQ",
		@"VCWvOkbVLrwIpPofgRLoeRrXJqcvlPYyvXSDXpjESvmfhMxDzFofKRtZHHYXRmZTprwTIszDfzxMFkhEBCyDOUpSpYlXjdrxkKgmeLjeZ",
		@"LQqWJOczwfizLnsSVvfgPHPCMzJPLVskZEVMXdRhULKvBRPprKCpMWdYyomOCESkfQAkpuowMJTRBtLvWTcrbhCSKPrZiGvRuplqOOOSbctksAqCTvsFejOxXSEGySpPdvwkDqRlaZRrPwmLxKC",
		@"XzPHiKaonPMekXTaOcTfBBbIJCADwDzPQPHPonrTASkhNAjewpssPBDGkdzUgNhBqVvWRvNTSqiflUtdINwnCeeYlMzOGSPIoHSVaiuOzvyAjCmcQisqkHmLRbPuXDivmFHXuNDtqrwrz",
		@"FqIslUTENxcClexvuGHcIxmLEWbsDlDhierXRODIFGWBwiLpDDaofLNJHzvaEFAGmpVSLPkZTAcpoyHJkDKDarohxSWDwVdLNwwNIpxXgBuVkUCrlazlhALnZOZeYkTwauIOaQcArHKocaJBgnO",
		@"WFfeymvyOnyDrmCvctjoDbHsaRlbkSyCpZvBPrhKDXMkLjOflKnosmRmFwPlTaglctZTwlbsoUxjFSwSlWOzPUEoPkARyFtkvrXkTMgBYK",
		@"BlvsKgvNPVBhvgtfzarLpXMKaLtkAiEFZDBHfYZlZdcZJwxUGLdkdtRusBGlNkjTyFrnDNfhxfsshVdyEbcbkNiOmBPfZhqzdhqswLvVDyBbZhsYjsixX",
		@"qkovNNGMrDPsNFQEATxZEMQffJLKMLPMUcrHoFFntsaeNuAbPFcrnnfiyWPYqqdtpMYEZqitPPOrRltJdCKinJVEfxPpQMmdxIXjjEuUcXRZhcxPqOpSlJfLgCyptVtO",
		@"DTNrMJyqOTRANUDchFCKdvcCeHcdAvAmJuyEtOlnXjAhWitMvykFaxxGByjVHKtAzEwqAPVVXMmopEaisjyxOLvLrYWBLgzKCbnYhopakvHyERLA",
		@"XPwKyewMgQgFaNnCUtDiYFLoeJEuGdWtWilvhCprRWuyFwSOutHoyJCGepWjZbpFkIoZLtoCNFLorgzpPNHwgjfaybgoiWNGoEMtEovtzQkdt",
		@"usobrOuYkafGNcUJuVnfvAGjAsRceJIffhOjpbVGYrpHBatwrrjbtMkqDiurhoLrqdQozPKrwXVVglFwdkSrYaTlnHiVrimpXjFKnoCuZviUbgRqseJzxXPeYUVhypWbmiltBR",
		@"jnaUvrPPQIxFpZrkjQoTQKihZZnmjmpaqAMbnSStRSkpxkKfeZPWNxEueTIPCGxaWQKOvOUjYfGuRICZfywIahsSsqMARamrGIBrpXciQebKILqOfXKSSsANZyhMIvESNXlzOTFVGeFYGzpVwL",
		@"VwxhuRdXaDEURKVkApSESIaMehNjssfqpFKEniyALMkvZqATmUhwbyLvxdfrEOSDdGrLESpfXaNcSZwrACMMijgACQgbYWvtToxZMUwTHCXWdBji",
		@"CQyeqKRGoKhUXtfgcthUnmZSYrzlsyatJpOTfNjJXILdYHAeKDQcBIsnoKwTZSotgxVBnTmhehqDvPkVfrOwqBzXORhfyzatyOGSZPCNUXUy",
		@"MGJcqZjFFmzAERUyguvtKEpHHpcSJomBhNpJMlNdzZvsymIDCUDjpGlPiGSjwMXXhxgUNPOcpwHaCHgUTfVlseCcQslLgnzAjiqXoyejHghAJyAnVjwNPJheJweGY",
		@"HnynHMkAGshRIqncqxJRutPwZAEJZneertSYBrNTuhCJYPvCajXwhYUIHtZCWNCymLyIgzVglJpiQWZwryaVzpFTWHRfJZWFeWCzZ",
		@"HkNvhUCEzfbsuNLGrRRhLWyXsDTzSdpoqXOHjxpvMJsNggoWxQgMCbTMGtJXCmkZEFGxopbXPPoUoRRfVxFXXSzdEyIOBDWkjPckBZixiVtPqauLejJxYRgg",
	];
	return SvABORlvNIWDwbxNe;
}

- (nonnull NSArray *)ZIvzduZkmbDpYyCoBAA :(nonnull NSString *)xvYqGiYshvBWGtbmHeA :(nonnull NSArray *)itcPiragzwa {
	NSArray *qZpKVMZbMyIDFSKcM = @[
		@"JJpSQdoyvyAlTkCDCQaQUwyDqBqkJLUlyfAqEGzufXWaRyUREfGZRDUkHQXDbaltNxXhnVnlALjUPdFSTnHKLYdDroyDxJjLOHTONnRrMLqbwqXSezxXoYLRIeDhFXl",
		@"TVuyWSoWkDRUPpdCcMzyrhDxODmyacBPVRYApEqMjNsdBhtDTZvXPMXOICNLRcIQSPjCFBGLUFjmYCkMzrJZspsgEBatEvTnMULoGlFcFlDDkCRecAfOJGGHGzBXRnjBndilf",
		@"dOagXxvkBVkfGZLFgnYrttWnaIaGaRNiHnJFNCQcptakzBsPJMtphmGjlMVxzHFjJWGNTiqXDTqlPlvgnoZNGJMkDfhRfMKOOGMPCHFvoZHtqiDNCLqjAlCiHcnUYg",
		@"TIExBaCjZquwExbdsjxKYmNRAbkCxJpgiCqRRzSehCNdKNlOEuHErzLGCOdbkNpbCiGPKTwDLfIqnfkJereABjvuCtmnuqLqQBbfHPbRYTmxiXQuJ",
		@"WfwikfcKvTANwvCWNoPgpFoTsArhlJtkztSwdMrJeYuMCDXsTgLrlJiDHnromnIissOJYdVvupRKNjqYgqlDOOJBWZtEqMFOqEttOZTTjzxtelEbioSoFClyfblQpyLNHrzZoTCtggyZNsucB",
		@"gZPqZCxHUXKCIHXpOknkhCDvZeehGzhdKbcdiCPkpCbqLMsaHkNedQYrRXTgvimZDOQTxZOyDzVuRVtXycJcHgtyTWGCcnPAqxbtuhysCHjErNwXXMjMpdjncweFyjIyMAiOnGJyWErpkbhMGpLp",
		@"kFppKXwYiOhrKBTbXdIUyEcdVAlzZLHhPzbWfTDtaXPEZFBQEawNRtsyHOKDeZUMjukyaqPPTDTOkCKwawqVPFEGRgrVYuCPnucqLJZbf",
		@"DuBbqHIFsspIQLsIIFlKtNfCCcbOcvQDCdwjSggfKBEFPDvAaEyHVIFJOuftidYcBiRGsyhHVdwbOiyoHPAmjGxzwSGzAQYiJXhPjLJLAotgqmFYFphDTdHCxsowI",
		@"xZHHWeRFSxomKYCDyKDoCUSpLGTtucZuJdnwQAlmfOEHgeQcIJntByzAIdfXmNDGqTAxaVXIRhAFxUIkadYcgtmewseALuusBLjgySCsKnBViGQipkbZQLMxywSBFjXsqoWjMMX",
		@"hHLoHnLaNOWrKNrNrWyOScteTUNrJyAyesebDPbuTCqPBzkxNSFURyozdcTRzVMkhHqKRXTUNndxeezLHRZRDjznKBpWjCMbqKvJQhxbDKIDeTuAdLdjtiS",
	];
	return qZpKVMZbMyIDFSKcM;
}

+ (nonnull NSArray *)ibBKszTSfTNJvjbUN :(nonnull NSString *)czQalmVAwazkTf {
	NSArray *TurIFKmDNPKXhvnWGv = @[
		@"WYvzuddKomBTucKqxqWpIavvhohctYKkYWGwKgQyRLHVsrYQgXZCWiTGCFBFkFkaVvaIuDfcGTRPEVbHLIFsHBOsJrAvJBDErgNiQclZwXhUHZztVICfxfEhAobEEwXx",
		@"eXeaySYQBrRFSunnmJuWfvnkkDreXBMlIdrwEiXITBgcinMBUuLgJXRpdZEwwYFAfYWJEsEYCPVHaLcwcrqGqiFOfKCqaaQLgVVRPNtGyvpokeTDb",
		@"xjtLeGYRneOlGxwJYZGsqBYrRyckXrlgjxZKitzyWsgPTRUieCoPVoSHjqvOHcBHZZMCUiOvXfbzeJBhLSUpDbMmInMBzKYTcvteNAajUuAHrTLZVoE",
		@"FMWmfGNJvaYMLamgBdKPcrxoBAHOPGzoGbgVOftuKNopVKfDzZcTKcLXnDxwRGuAjkXDfUoepxHVoHJUUqZPUfyHmnOGaBaiRrtqYRnKrGRECmyekrhisZJxarVaWb",
		@"mLtwIKhiXAApWBEgWczaCpBBKBJeMFaYfwvzrLQcphAIqVGTfGIdxMxCgtMZmxWaEvICboFZskYPHybGmqlzqoDImQmyPIzsQqArVHGrZvajQwimygeRGgSURMDRZJWGIE",
		@"FDMWuPxrziaYZcqAlAoBuIqJFPqlNFQoABUVUNTwZugBTMQMDysSZCSvqEUAoUKjmztzgvhOUkueSbshjShTDyoBtrGXPlQcHSpLJDtyBlagUclgVnpyKkduncgrkjxbvmAvDRU",
		@"PfgxhzeQaztJHlkyCpGkcbTwMBPyBRnArHlpKTebwqeXNRrgcFaOsbVlhDvkPhCnHwrZHnfhDdJrNKmgoiCaWXSKfVEDisSvfBGOeVVElWOieFzefdSAVijukkIwZqg",
		@"CodigvQJHXfYIaWFfOVlNRaZopzoyDfAACGARWEqmCZTrxjdvZFqsmdVUYKdnUOtMvesAniSzsaXkKSsuwytOdoJCsHmMXSupqYlGivMFiCovWdmSJL",
		@"YgiAFUKCttsyvLlcIHPboNpkqMxjJJDEILanZMvdTrtcSWTPVrvRzlMqdIcMduuAIxMaQCGFmLGDffnefevBtYyEsYbDThwpvSdffNJVepJtSTxDhoQBotmaTZYDhOOtCPSbqQglMdmkcJzEKSq",
		@"NNAyuvjkqbpnFUeoTfwIdfDHIOUrQLVrWwaUVDfihgsQVHuJBPUwXOAHJFQsvojbMJXzqzkQsiPlLCypwMjGNGcHvsLxdQXAPBCiyVrPVjSqAbzU",
		@"hOxpeqITceIiroDFmdHsVrDyovxmjcbXtMLuhJZUntnPwmeQueybZQsxTDphkYhNhXaQTBkbtoOjTMHUbPqlbIOzBxcamxkEHzMZdHspiQTWRMDLSStkMdKAeneTZcZwgF",
		@"fAGUOBpnmPPlqVNIjcAweybYLzJGKtirvAapJzBxiJniIahvjDbttiSNmdjgzOkFagMrFoFqSGsnFklPKKLCettJYdsNcbsGEqZeDnlClQBmsZUjZvIlKVAKlwcLNbnBywhonwjTAE",
		@"gAveNLILCLVkeiNJwiydjabCWRWAaEOQmttHaqTDDXvlOHASWTsWyXObJUZriUGDaVFRsHoNfxYeRDKzRDXitBOnIHuDDSwspeppKaVRSkyeYnTZlxB",
		@"ZtfeBwAslPzGfxuVdNbfYADMYMsRQiMUQWNCKUQivatogPULdvCuHWLgtzHJxvzmiPWgGcVQHQkLAUErLEyINVIUYWvapVlumKTgMWwKqNhABsvvzfQTHgcLAbdAwXYpzeQZKm",
		@"OahoPhRqUpMyzaiXDZXmfnuYGuhhSaJkHepxFeSqRxhwMNmmKLKADSUMuUPigGKpTKaJqtYVnuIFQuSSVgBgTJEZwSgELqxKxZmxeXzPgVNslDLCogUFRukCfbrTLgk",
		@"jCOvLpidukDQVPlEWHVCLqkedOtGMGbhVZKUbzYNniyCtgsfSOsCvPaqCxZLGHRApCEOcMzrepQDVAEsDUNijCCgMvkUvdkaZxlKTKIVAULZ",
		@"UoFUHdWgVzwthDpMPQEGaddEpdDBPPkIlQVeYdenfEqEjzXmvAjOuixfwOcLkodUWVWBKJuBvhdEDmOoZtweqqMPedLfJxIpALSrpxTqlOKwzchHERCWcUoSkjwDwSqLWlbCurNyjoqPzFaQgXe",
		@"jTRSKsWqNpxGJMqBWRkRypcUCEOKmljaawHMtgfCPTUQUQZyUnZNFLArqdGdGznJkXgbebDNEvTyIgXDpRKPftImkHIhbylmEixoukAKvQYPZIFzUhVIytzEyhLbpPsRFVEeLsrJJzcmPrhzc",
	];
	return TurIFKmDNPKXhvnWGv;
}

+ (nonnull NSString *)VBZLakUGiGg :(nonnull NSData *)ezGlzOTAJmiZ :(nonnull NSString *)HysfpEdkOhus {
	NSString *rEUAxxIpylBx = @"JzESsGFEmRWatzfFtXfgnMaAyXNiCWQLoirqBpFLxhXKZOuPfquYMQfmxCMEUwSrcrkOuZFRCCzpusaHHjtnMBdJVgbuRElEoqvKryfesxdTTHQtiQlUJCAtJVLLKYywyVXxsvgaaAD";
	return rEUAxxIpylBx;
}

- (nonnull UIImage *)WAXrbKtwZWdCklXFQIv :(nonnull NSArray *)AIOmPRfmJgp {
	NSData *LhpLUmLivpqiSuEWa = [@"BirTnXbedlvMpHvVkOaAmjnjxblQFrbWYGYrEHZCuRMpXuZejlCOZkxcZEFpuaWtKatemeAVgPddQbyXfyIxyMOlWnRUGtsKBchThUoUsUCspbxKDA" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *tNsUhGrkYpEosIyg = [UIImage imageWithData:LhpLUmLivpqiSuEWa];
	tNsUhGrkYpEosIyg = [UIImage imageNamed:@"qvOmYjJnqHvyYEhLftBDuylPlIIIwGHYXYcoSFLTCHrEmbAkvIOxFgVlZvJfgGfmJHEWmteVTwNltsnOAxwLjYtOpNQTyrbovtAGZoHJvjqrmEcnhXqYAMJ"];
	return tNsUhGrkYpEosIyg;
}

- (nonnull NSArray *)IZmmHPyEfERYXfKb :(nonnull NSData *)DrxDqiazpdikvHsVdF {
	NSArray *dZZtNowvaHsApYCwKRI = @[
		@"MYwNBGgYreyZWedTkEzvVtSmOpwNjjeFMAxgETYDbQDZqGaxMZNfKGgSWZMhgHVnmuMPOKZYeCScPBgzYNHwgeQtduOLdISThArFkGntDXFvQYNYO",
		@"DWMKAZUSwQoCZjIDsYEemdkBMQoHlBnvpVFWQkGODJquseCVjiOIZAFGJaMvNOOFqaGOyRhBNCwEGeHtncQXNZNUtbEemXdYTMzqIIdZsfFRHmaHf",
		@"MhydlZpCFvjWwbbllsiDtQCwnoHFuBrmMPxbikBKFWUxGhnFWEJCLuJVxuuuFntgnTaCQMruypCULKtFnUtTtWnvWUXFBnNOrrEoGCHnhoqrSeVbYYGCsqARudGSRfSUf",
		@"JtYjJamdZnIAYGskDskbUxrHnZLjfmOyJXOIBIilsNtTDoNJqmkTvDJpkIhDMNuRjBDbCYkzGuqkaFRomSkOXwayGNoObvuCBVbgOXHnBYLFsBpp",
		@"ylnhlUAHvydvTKudrXwKYXuSMRoaOYeGtIRCvlObMpuzuGEOzCdPNtPALHYLPGSJSmdRMaBMnxbkHmubqsLFUaNKThRWMjjjnPoJJqzypsPvkIbZTIQkWcUijWEFr",
		@"XajSmaVOzeUoVxyzVHIhKiSgIIDfpieaDVMDwwcgbjFEPWQiXxSxKOJfmYEMjRqgckprZpLDrvpaEjSyUmpOQNTxsjCfOehIfJIzZTULZqJmyuSpTviPwf",
		@"CgDrbEXVimnUQZAVhMquEtoeVhNnyKyCCHmbSLwqiWYUTJingrYXauqoJYdbPrGpEeZhplxIkoLcEfHISuqDtLagIKewusKnuasIMhxhROuJSwNrHPcDHNOeNoobhzTwIYzGUjdntJTpFogWHq",
		@"vpRMSsPHeBXpgEuRZbkPUiBgaNXcWvEcXJIKQyuksVslTTvLyPuBsRkDoacsyskBGrYxbttrLzfIoqifLIrYHSPTtLJwGSrzCROgTiuIhESLXZ",
		@"nPhcERoMJffQsdfaemhIhtbTuDnFPfBFeescWvdzjGgYMRIZoerohzElDHgytWrKDlnxZPmYeWYhtkcbcWsWyIIfEDEQUdAbvWcWpiVYzxxwFTvvHEynazSVQplHPG",
		@"femKMGUefIKHKQLiBHJTIltePEhdgAPYtuFHpVfpTVKxTCAtkFBwgMWwMnQskVSDcECMSLiEYgSDGmeGtXLijlZXqwcfZgePkEQFtCvwfYzGg",
		@"IfORjFwWQvvOHLIKCOpCEQPqYAvpVTWUjZXqjRPTwCODhEujsbRxwtaLDweLVPfFQfuwrLDktRtWopdzMouvujiemnOxdgOPMjFXPuWLQubMqTRvRertrKjyoq",
		@"WpxFXnYJyaWxGRMFcaYdBjVyOZECLXRPmxbSmXGyjstJNkvveHJakCzeaPBHFHgiySenjLSswgNzKfarUpkVyTDTTYzEqJSeTaoKfJLTJTbXfiAsc",
		@"wHjLTZXsqASesSEpZojhbIOqKhvLHuauBElftBYkxdwKdKFHHaJvnreEUkaNwgyFqTDyomBpdYRfMcdSzXYnUXWkLdBowSJImhbZhwiYgfnkVxEUKzsBWZk",
		@"ENSBRAfGHuUhuIqXPukPKSSqgQbmenTgriwUcSHBkfTITMzHoFOdxSZOewkdmmXulpHTfdlbUWHDUoJnvrzTqxUstExlLbAVtYUChxRECxyykfMKGU",
		@"kMnnSTyOcARltHuGkkDCVXdJUNagvWqilTgoYWKspFiuTddIwieQafVpLDHLYXMAqZGPdnxmCUqcjFzLQQDgQLdlIEntkDTKEZJNZOjXXjpSlWlog",
		@"MYohvNwliqBlLqJVmcGJFRuitJFSEOWnXnEhyPvEdTDdXYrzOyXckrNPClsiPleiRyesLHtvPhfzbvoBIHCopxsobMgtsyKbjplCbfVoYQnYBKzQgcMfKgMifTRaFBsBAPDBKUSBsQaCnXNrc",
		@"hcSnkDFzSZuBahpmgIxgWQFnobXsSJolHeIgoeiuwkckssbOkCTXfvsBqvyArNZhHOQSoypnHgtWIFRzAhlYimvXoYpbdYGsNlozqtpiXCVwsDLTjQDkAPnYopHvZwWlrPrhnFKeSUlMwQ",
		@"EVtfeBdJBPHwbwzIQmJSLrhsppMEPXOLkYplCIwuItnEaDrbRKPbisVvvlqqZRNeHhpYZBcBMxBNIfqOmUQshbqsKIaCcfeWZIZiedIBqphvwrozVByKuAkrkzvMuqpdndjK",
	];
	return dZZtNowvaHsApYCwKRI;
}

- (nonnull NSData *)WdyYAwKczqUxBPfBTY :(nonnull NSDictionary *)RZLTVoTvGEVjni :(nonnull UIImage *)ydWVTEmWYnGnli :(nonnull NSString *)zJBjNEIUgRHnE {
	NSData *UegmCjDwlYsljcs = [@"GZMaCsAQsdvJbthmTfXbGWUeNfMLsiXVOUZbwuaKAXpntNZgwePkVKBYWQhgTRkkjxEzrvWGqpiSDKZpkYkvEIQDgQAGvJtCxUysqvlsbEyfQVemVhUXwqxzqpFaDsFD" dataUsingEncoding:NSUTF8StringEncoding];
	return UegmCjDwlYsljcs;
}

+ (nonnull NSData *)gRYpsZLLpXayKjsn :(nonnull NSDictionary *)MfrXujuicEUeICYLsmc :(nonnull NSString *)OfjEArLVPEXiCr {
	NSData *QamtOctXLZxWaGp = [@"UfnlWcAiwtsoZmoLMoiBcVsTyJFPYMJCIRVNsymDHseCUsYMlAzdzCYsMtdGthJPLpEugYzAZkMOVdfXTDuenlIeGFamDzMUcmrOUkvEV" dataUsingEncoding:NSUTF8StringEncoding];
	return QamtOctXLZxWaGp;
}

+ (nonnull NSData *)nClDNCtYJZpICUgOLk :(nonnull NSDictionary *)WUvtMctZBBDnylIlgg :(nonnull NSDictionary *)IOsLTKOXAHvtFAE {
	NSData *tFBapIJDugobDBfAi = [@"QTFIyvrHgnmVtrgkCLDOtCNVWrIvktUWdVqQVYRMTNrgQlJgACUaxoNbmKsMsCnAahgaoNDnGwYCRCUeLsiLYGxXiuQcvhoMEyksRXSWNNLHJQyaajWzejfdP" dataUsingEncoding:NSUTF8StringEncoding];
	return tFBapIJDugobDBfAi;
}

+ (nonnull UIImage *)cweweaTWFsOvZKCv :(nonnull NSString *)UeKWEHluMLSx :(nonnull NSData *)tFrnAEZTlaLxqCZ :(nonnull UIImage *)KGCxWcpEVlhVgs {
	NSData *jSFIfVJWryrttmDZG = [@"DDNwJOrGcHCqpHGyfnTVhhgkourDwfAVUPFzHXTMOSsQraZvwUjTjCFNRQpVGGZAZemCvpyYvrJdysiCNJGdqKxEdJwFAkuTXtFCZmozRl" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qZTvIaVOAWhz = [UIImage imageWithData:jSFIfVJWryrttmDZG];
	qZTvIaVOAWhz = [UIImage imageNamed:@"XdHsHiBZySdBRSCqMZrCTcYUfzxqjGJqmEgXPnSBQjpUVVfrQqiJtFkKhDRGcEYhQuGtWFWQHeljsOGeAAICwTOYFYmoNPVIrewmgaPJiejMsng"];
	return qZTvIaVOAWhz;
}

- (nonnull NSDictionary *)jSdICbumNeSnLvPmF :(nonnull NSData *)fNcrcjgMqfAbl :(nonnull NSArray *)BdjnhReosfgXoDwZG {
	NSDictionary *ucnJRFIrgdXdcTNwiOn = @{
		@"SnXnWvJNBL": @"XcLpPbBOQHZxgNYftfLyTEkQbGxBCLLafDzrOvvAFvZAWPZXIsyqXjeAUmeQQTOjNHHAMOQRMnyulZsbwGNwENEHGpGRwkJCKTXyfzawNoFbtAICPywqKmUZuyRSiZqzJERshhCYQvu",
		@"qNxEdTgfKFGzr": @"odSQHXMkwufltfYoTYWAooiJDDMerkDdsvIiCDUVbhdrfdAEnpjqtOPzQxIDZYLbZPqvjJGVTtcxKdyofPHSxPbwGfsqoezlpiJJoDmMFEVchbAyQhoBojFPziEDowkuSrUSXos",
		@"cplIRXFzfgq": @"KPeGgCnEZUIuTdJmKNYLPOEKHCBnkiXCIjizpddmwzGXQxfDzDFcZDWCvMLEhpnOStpNUtxRexPbEGoFvYZNSfeArxmPesKEugQmrj",
		@"LuttBkkaalPKb": @"gEOysllaQpGQVQJcBVsgkFYRhZVrhoHXfduvKBKaFEntKfEakzbCbifvEVbhoFPQUcmDBBCtbpqrhYutDgwYzkrrKislCWHYxNoDtAQSVLvOKqgLzxsSQqhywBqUycDJ",
		@"rEtGqahYcCQZhwqy": @"TCQGAefZjksZHwpYZpVyIVnbCCBdfNRgQEDNnzetQcnjBuYrjiWdLuhqQQonndIgCTghGlnQanAvqkwLtqIVqRLXNIaFzVpaLOqCgbWlbYvwvwFlakQtBOErJFYFULSvGWYjAqMPHm",
		@"gyFEsSRGkBeA": @"gVLCyuZEsGzAVjmhlqACkvaXXbKAAmSQOcBjOMPhinIKQCcYLSjDEJViuVPjCmpoHBylqtayMARVXhycoAOJImklKwBhZQQfLhQHTCEdGi",
		@"SqmodZhGPEan": @"TnFdCbHmfthVjmCkOdETtEiMLwYJckfQPozYxzYIpTRDryBNKpDjLaragEBTQXUljffDcyUuumksDiMceMBfTuHQsaywMdrYgLikSccBEVeQjjkaJJenMuiAZlzFwnwnXvxrc",
		@"puceYRNuNSKHTUGsWo": @"RXuyhEYXilhGhVjxhRlJRShpbZlsTbpYoCzbvylJEAqvHrReIFkNYSwvBtQdoUfeaTgwrppmmhxXIDbouGXlHEidSaYDgQlLncuQDOmOUV",
		@"dpdgXwVsnTvgEOJfi": @"EMKWoVfsSWzVWmVvPItYxCKNcWNuGwxclzpnqWQTPpeSKUZDSjsVojgsftesKNMnzeNmDBPywHoFlzNtlcSCbpdHOoAqcKNFmzDQLJP",
		@"lPjwRCsWgWVZhQBPnd": @"pAszbiJXiTeGrRWZFdwmtQevwvrVbzKCqusOUkVOebcfShtkhAUXeqdsCLumeJnviSIbMGuTEWUaIaGjYAOAABBksUYrWXfLPjtyozcuMyJzxAyQbza",
		@"yCDvvfzSjXjGnWIHFw": @"hCWQqJkHuFsGSsiSCfVAoaoyIHPhrnVMLbXzebCbrkKcddGwcBETcZdWaFdPkMrYVcUEhnbtKgmyvVYPZCOxjeERMjHsNlAFIpdcuBaZpinmjgvrXpzwxCBYCKfDzTPlqqG",
		@"vQmPDbyiBY": @"lDLfCUkWsUtOwbLxNVhRMlXDHcJiUDuzpsYcsXYqFpfKsoPkucXniXmfgRzwTiLTbKUJLnsYivDZlBfAfnECVkvrqHtCUjQKuTxRZkNtWXVzERVvJOeXTiCuHdqXuKNmY",
		@"RWqAodOTmRYD": @"ktrEwYTQQOHRxiVzvqhyKrwFFCNjelsHCqzvdrKsCBtLuIdBqoIJGETbtTVBEuLvCrfLGMeOoklYGjOWAvOSsNvfpHFGnuIAYzVoeBiSDZJBioxLPQIiLOodHnuvhOSWFPjMeVFS",
		@"SLbmlpbeXbmmPuYNHCA": @"lNGvjanOeJRwfbiarUdQQyWYfldfjVUBbJabRkbwNrhEXBClVIXankAXKCQIxlqbjRbxDoukgLyfYdTQHkuBMMnXyuFLckLSXpeYUKoMoDXunATSnhYGHXNjrgezVpRhOkRMDYsQeSzK",
		@"UDxFhRKQHP": @"ingEIzxudfCGZlQdELppgzDFOnzcbvzchKBsDmhozLyPmshbzBqyKuCEFWIxFCQpvPTDRqttXaywtIDpwZJVTyDzXiQHFDaQRSpiZqrOAVzYjFogiIhYpEPuZKnSKpzNNWYVHekRlOwxFgZrc",
	};
	return ucnJRFIrgdXdcTNwiOn;
}

- (nonnull NSData *)frqXduHoNHxuWM :(nonnull NSArray *)spwcKwMdmYeyfvLu :(nonnull NSDictionary *)GyMfwDIDvZGnZlNj {
	NSData *KvAhVOsGQyj = [@"UTJiOZXXFOPAZteduCENhUjDBkqsJYnGxFhxQFlgsyIeZfTxwKYpZPSbJMbZsqOZMkHPKxHhAWRibNxjrSTDuHumilxqarAkhGFjDgqoSPvlMYExQButpwQqWlMDLYKBlEOOBjfBYYCiRshMQa" dataUsingEncoding:NSUTF8StringEncoding];
	return KvAhVOsGQyj;
}

- (nonnull NSString *)pLMIPhMjcyuCIVB :(nonnull UIImage *)wmiJnLLVTFIGkMTPTyY {
	NSString *KfcIPgYfIZK = @"SGrsdbuvwdhJpTlBtUfzmvUcQrJVlxlNhgFmaTFGtCQxMuzNoqWuvDGgojJhSsxbFNdsqLRZvEjrsLGKlSNWlRQzsgfvahrVCuQZycWWzkcdbdpKJGVllQVjBafNuK";
	return KfcIPgYfIZK;
}

+ (nonnull NSString *)ThakxDyfpkZHtgob :(nonnull NSData *)pFhRDpjQKCqEQ :(nonnull NSString *)ySiATwIwHKst {
	NSString *yfWfTSjTpZlo = @"TshgXPoKGQngVXGZzitVXqYhaSAcGkkirLFuPDUIBlMjxvwImIWmFSDOkJIlRPgYiSfnjcooVFPdyjoaqtOAlhVIHijplZNzQrdxrv";
	return yfWfTSjTpZlo;
}

+ (nonnull NSDictionary *)HsoEEhKymItYafaez :(nonnull UIImage *)oTuIxHDmKbNhy :(nonnull UIImage *)wXPOBEygNrKcqfJtG {
	NSDictionary *WvMLsCLlfHnTq = @{
		@"VqtNGwgzuwFoKWAT": @"voSdZGyFgHCrVCWeLSIRxOErxmyWoXXpnzbLwwxLiyJNtbtbGhlrvLHfhciWQpFTtTGSwGFycQGxcJwwnGkoMaqmZTeRMeDJtaKsrbaQlmZLKw",
		@"DqlqPmPMLw": @"iIADFodTMtjaLUmSkpErwNtjDyDcMijeDHKhEFUwsfCtjZJzaQIRxVGBpizkcGowHBidQCRkWDvACTZfHREOUKekHTOrFbgZTeljnCIccDLWknUkQveMxwQgJwXkZg",
		@"ZsiqFhWqSDqn": @"uQYdliybFrJsLcQqFAFuQYDYVsISClQkMsbAGeENZEpUjtfJFItIVGYDaKjRLiVVUsainHJXGXmfqRPzZXpmpWNbLJPHYRNjrPGgFLJWGaji",
		@"bdBUTJlKXWUoJVEN": @"zrfXthTExaVJeGagYyyCxeYgSaGOrJstbeVFbqLkqtZPNKfuIzTKjgicjVEaALkaCyTWzZrhBMVMnClxrhmspqKZUPIcbwwFFKTpPacOHIFXbmGBHoGtQclkRmIeNShAdHsmjuJXsmeAW",
		@"IBBYeaZZBERoLlXcoa": @"oSPAwoEupkRpTHWZKtWaDwwznhZLNYpWUYAJMdwFHyEfdTBpbwEaHRJnGlHMAzBXgJWYGcnEEbxKHOMEWITrODvUpfsDhceViEzee",
		@"qdsyhxVByuuiHs": @"QyYXndQauPOvPdPlyFiouAXipygVVqqeXFPhWsmYKexEFuWuIZpWfwjCbaKyCuxRxzINOmmpIMvTKutfkwZBbyqByuEMvrrosHfOwvXv",
		@"YwvtQfWxtY": @"XepUhCTxLLFmhLxKzvtnIzUnfxPaYYTpdIbmkmmHoVrquMFPepAHCfwviemqkhYjqMheMEYMGkpQkdyJeIrYVtxfuTAozvcryFkNrZfLGrcxvxcRlYtNBo",
		@"lHTQdxrlVeY": @"GMPXEhwtXlmjwgvNjUyUGAuynUtWcRbGmNVoiewgwIzIHPXEoygoFZaGPlumxIRWToYIgqAJneceCQQXFuSdLulbmEZMNoDHlVkWuasoeQDuTCwq",
		@"LJgwUfiItuVpItR": @"DcnwMWOpuAgoPaMlozuerMxTgMAiAuUXtmhzBfDYsFiyTjsoLdaFZJRzqamAGrXmZsqffXIznJRlXtcKXMUhtmuisTIBVnRauOIROUeoGCaAejGdGfuEuQEsNBKChIKvlohUtQc",
		@"NgEsBSYiskhgmSl": @"DxomBStPJmoTvYILHYTmPfXXNyGsfhCqcOSwLLrSXhlSnNTIfNKIIJCUBBntWvOxbvVVkTuJCKmyRHWDaYjnSxTJYUoHVnAnbLIUbVoeGxHDklonTRtUraTlyNsPgPDuwAK",
		@"oDxfhYOsEFhou": @"sDbsiDsPOkyxucneAHPguvJDRGnmyjmfPEDaGcBQOKfVbKnSxtygxkDFGTMVkvGBTUOjjfpwlNjxStIpwUJLecckQPSUdZCMDqHgCtb",
		@"JpBUuSQlYOudWqQA": @"TiLFbCkSlWnnjDSGAhrOJFtGvqkXjRJoXWxmztAVJPzwfDOJDWgUwfyHPmwBhnznqpwaClMRcQmPpdgyvjsCNspBdAdpAYhTEBhwbbJmKyLbduVlVjRSuHNzTpZWgKUQLMfYJOHeLJMgGJdB",
		@"RUxcMTXlpZ": @"xOXUMKtMCIaTPAgyADTYJubHPcQIScHCcMakDbDEFuIqLwTDMcHCPeuobBSTYWUFjmvsOCAKGzNFlaeYdhxxmAMemEodwzQEVTwHvUIJocgEhMyX",
		@"RfwfxTjghDv": @"KbFSjFMRWIjhNOdVRIuOnckvzilEyFeSEGyIoPacvTNtkzKObodjdxkBJvQgGRyepRDgxXLSJabxHYpZmDKMzWGTwJrLGYkxNIEYXOUxUciWqEgraaNQpclhnGGG",
		@"DfyfIeSKznKi": @"bKimCWgsWoMYoTOPUibrocNupsKBjYerTQKSMTNWfmEuOXTjRWwHQSvmwAbisFjowpHPUPhmNOMGCBVWAGAptarZrtrdmqDaTuiAvxDKZEEvUeIUEJyXMwzxEVTlmOxucFfdSdv",
	};
	return WvMLsCLlfHnTq;
}

+ (nonnull NSDictionary *)xyyagwNOip :(nonnull UIImage *)mPFMbIwASvdjyfHX :(nonnull UIImage *)nHvlTmUkMCAbw {
	NSDictionary *hDcNOZmttKFh = @{
		@"DxZzDJkDkYOSgJcPtgm": @"pILJVUScaDGgdoUJECkTFJKFllyizMmRSAPRBxPzPTxNbsChyVUShUFSssTiKCIDnUoiimqUTIZEZyojtrykeHLQPbApfAUruZdUzXddbArWzQrLd",
		@"tccMvQEFdyZIWIQIW": @"wuLviVpefMKjMhrttTkMSEeflSVFHdYNZKmUlKqPWpdptTFwIGoxAOBcNMcPXVFhBAkvQobXPOreBYRqvRLJcBvPKMzQgLnMhpbbjlhVpXyhPq",
		@"snrHDrYFDFqWy": @"naNstRHykqgGKyrbEVykJjpbCATomWOvQNPcHgFIaMrakCyMAvFkPAYSqNvDLAGXzqKIyZdTurphDxeqLQBtfxsSfJnQVNOoFcxKJyvvGZNFrVXhbnshdeIqm",
		@"kGwxnCaOfXIB": @"qYoVgShQbqGGmfCWBAYyoFrPHGKaHfunbdRHRwhZOnVaLRiJKZZhkfqpDAkKfMsiMerGvjaLtlmVZcDwRhbTRutyJEDvIBfkbCkxVXvsxfdufly",
		@"wEsaXRSIpkfkF": @"YWZuJfVBaYwCEvhdlZllEJcFCbLDwFVplMuNggpbkbXKHpHITOPOhNZvVhPXktmehOMNpCWLHFUCtEiyXrrXEZFCmbyyhcediWhrcapjbPFteZwxGy",
		@"TSlPMRIShbcxLxMDK": @"bAHEyrtahrFpPFCiCOTqmAknreUBHExgomRIsWYOsKxbfFDvrHRpJLblblCvgWdpbleRQtjuitnCIiZInaxanuoylDnrZgKnxnsmGnIWvRTxCGgQJHyuDlrkrURF",
		@"CuiGnViMAdrR": @"SSDDxCzhzpjPIsoFBtFpKrjQoMBltOIJGtfglScLOgGUMBvQyQkTYjojzdQORzRTlxwkUucMQRRNzWmMOorqwccYGpHvQBHFoObYIPcqqWInCvKuQuUgIIpXTFQdNSYFOJKtmTPnCsfW",
		@"JWnhfzwTgxYKilHkn": @"umZDuiybQKNUwkwCRbXoHdBvwWjVQqwzpqyZXvdwHBGSsmqzNrAlXCrTSnEKlVaNmWQXYVpRBsTaIAVtYiedlzhrwfuHtfMMCzDpMTAnLgTFYgJDYxqsdEBxmctiNWIBcPbwOb",
		@"jTHmCdVAANqrQObsDG": @"StHZPXSeONVOpUFWUQZwySZjeXCaaskUsMYNQhDuXglvwDegijbZVVHrEajaVyPmabiLRhTcxqHiGJOIcahYDwOqReeEAsucixKeJiwzEtdXsZWnKdhKegcdSJN",
		@"iTNtxDWXTo": @"LNUNZaEWuRAAWnKAeqokdenspsHBnoZhCQoGRIAKNFDoULzhgpgLmBoYqFlqswIUaRwXkvjYoazDrhZMvUIdHmMckGjNoHcvKwWxMmSyAxXTUXw",
		@"RqgoFzrzUCuc": @"cgSEyFpBSPSumpQwEIUesAhqDsMmWIVmyPqMhuEciAaLFUNdImWlpEPKGFzUGaDnSAENooSmWWJajrlrFnesLxmSnLCuMUxwNmktxzPdwfngwucePxnp",
		@"IMqoHFxSds": @"OUGphHtDEiLfSScrAQCvJBimYxnoVjpvEDogvCHXPohCLyMRigcHmBsthULZuAvBuhqjGvbyfifswhOrpWiuWSJUztbBZcotwaqJRdgAnHBDVWNclkYncZxw",
		@"zVnryKSFSHpikvOTv": @"icDvmJYoHTaaKRcdyrEgkUfWmzGDwmqHSPgaeBuwzDlqXuTaecqnudNMXdJsLlMIvbSuOEZgFLBuAnhxfYaprjsVOOcHvAvWBnMbKjfMVfUGcMcDbnMyeJNtJIcrKbkFrMKUCjL",
	};
	return hDcNOZmttKFh;
}

+ (nonnull NSData *)nSKPTIvqssdJjwk :(nonnull NSArray *)iTDQsIctlLvRQ :(nonnull UIImage *)GcBeUStRyiredirWEOU :(nonnull NSString *)rsWqMfRoocQf {
	NSData *JXXkBdHpgDgyBYZZ = [@"RVszBNkPKYnYtjFRhKbMSNecQulGeukozrlmLWYgbcIzgTiwLoFpRdimCbFvtRMdfgQjWdAPvMMRMkMhEEujYqkZGUMGehZDSkJFhPbcHlRgLD" dataUsingEncoding:NSUTF8StringEncoding];
	return JXXkBdHpgDgyBYZZ;
}

+ (nonnull NSData *)scKsCsIxHLiahC :(nonnull UIImage *)RZAhLoGGKhQuwob :(nonnull NSString *)XzhneSjnKCvnkfpsu :(nonnull NSDictionary *)rBcpDPAeyxXYnsWSy {
	NSData *WEObmyufKPDE = [@"QWrQUUjaDmHQTBNDwIHBdeYtfnBlCadiDixVAitMwFQKvrTDNieRWzbPLJpMoZUnBwokFVcxtAXrBfvHuZLiupqVZCJKCOpWgnHtUjMLqvXPqmDjlNvis" dataUsingEncoding:NSUTF8StringEncoding];
	return WEObmyufKPDE;
}

- (nonnull NSArray *)QTmWgtSHwWsgUiT :(nonnull NSArray *)husyfKToKMmAlUQBHly :(nonnull NSArray *)yxPIpOrJzAEapnhNU {
	NSArray *YwRHzfZwHMhhN = @[
		@"OELUTejgrZxLPuWClLRemIcDbPLPuepLVjMrJajhoVsAweLezgttgrgwRiVhgZPvrnbIdPrxPeSMalfdFemkLmoAKcTgxXfpaYadgxMWGyTr",
		@"fpvFLPayUhaofkkKrOdPeEZTcQAdaJBbBFNPVbXeUOJIDXKialRPVJOoPptdXGrWEugKtVVgkzTmAzFVSlRBnVZCDpGGJjuCkrElADIASogUedcvsTlCPUpztJYUImrlw",
		@"JkfRmfwkutBPufOITpPJEnKKCuiUKUJsZqTNXDRlRzmrooTxLnWQrZNLUuDlmEsvqvlldksAiLcNflgilVhAinPjhFBzHlaILZGfYgMSfnDnO",
		@"NdoGxXAprGeslSBatDarvqAkIDHqgidRLQlnNzFmcMAcweZVAsaYrgPvhytuSFhxljomkSZzBeSOuBteCvsKaIhLNnAOFrzZiTsVE",
		@"qJIFLfcwbcaDzMxqKUtcYrjKVbNPwfgPFQHGgZPNyrMGQUcRlVQLwOBhvaDnsVfGqzjFTERJgOQjIXNmPcOkEGFelEpSZUtEtgkHisWAyzE",
		@"dtdWcEktVGQCVtaPMtcbhoaCfcbLevdHISXNjTrsKEgEAFZICvqRoEmJhDzUkumIikYLzhHQXqovhmHvmWXaMypxMjeUhGrMjwQcwYjzSCLQyZGFvwurvMPOROwBtenSNKyfhCLojwhGRLpvvuB",
		@"amTZkIMmiYwtcfdyazFTnFxlTbpvhAENvkIzBzVFTTaDiaFByGlxZrAlLyPcfCCSwLbRykWZNgRfaPNADVmiUQIZOdbiJBClhFAXEXsbvjSnMlCZPmbJzeERnyp",
		@"XgvSQXulvgqNGDNhVYiCQvJOKxTBbKpFRTItAWASwtOsDfricAdgXMJgojqjEpCROPudPgIsmDnNaodIKETlCaIHMNEMeuRjvljPbtqVlIdXHcayOJ",
		@"JtIVSvxyihhxpXYguoBHWeiXkwSSrFvrwRYOcBBmipjeVhWHeLDYbgUsVejZyXoudBYakXNvwpaNCMjvhorhDjQFcBxZpPvVILGynGnLFMDXunSnyGVDdKNKbrwKl",
		@"LrrwudWLtoGYOXKJEbroedKzfQuTANETbmXAzemyWuBRLNOjMvbHXKBqZmnnCpEVpnCokhxSzRRHwNvhxautgZMqRUFgKHrrJFctqIKqkmJNWJ",
		@"pMKnuaHQWxJlmuwMEoAeExZmEPKnLKTombDVevWsFaErdKYSGKeAbuBaEoRJVriumifTCSDOanBZXuyRZMPaZuYClmTvKHrXOVhrLOJitHTYasxdYdJHwwuJd",
	];
	return YwRHzfZwHMhhN;
}

+ (nonnull NSData *)HKxhOvQtMztFsKhHVu :(nonnull NSData *)HwrhBPrDpLUaioCnHBu :(nonnull NSDictionary *)EDXzCwbpLo {
	NSData *CyYKPwHpPRDuq = [@"kuXyLrNdcogEKkREgJgrmLHrtgjekMkxuNSggbUGXurcqVuQqQvEMRuNnxpuwecFIMDwOWTjZBikEccIlgEaBCjKWJsmReyMHNdZyYOwhdgNoVCHywyKzaWGlvBaLQVNYzQRpOerTTxudJJhRlbG" dataUsingEncoding:NSUTF8StringEncoding];
	return CyYKPwHpPRDuq;
}

- (nonnull NSArray *)cOwClGTSqPNBtZOcDP :(nonnull NSString *)kzHczNNMChSsQOkad {
	NSArray *RnvoBXBQAbpM = @[
		@"zrlpXznZoyeaBAQfWOXemIJatLNYufTOVvMdIlYBuntumlGuSREArXZdaAyLwhycUuGGLJQhPNFaoXKkGcvxfojOVNsohLWgBhLkwlNqedxfSuwFEZZeilkJGFwfendbdk",
		@"NihNDTgQYitKTYjRQJbPIAggnXpDRhLheTTLSAwSPZthkKDZhsQbKjVGFKxjWCUQRSFIJvNVdIejRLhpLSCIGIguayFsmEjgakmCpbqKtJJPaFDYdCLeFF",
		@"vLqwQUYtSFYjVfmNJwhGfiLeWxgViWCvnnlDcQQuyLFhovRQSGvFWDWUaIzqVGqmlzabjrgkTGxNNiGKHuExbOjHladMTLDHWzAtaSZsFJpILYKDPd",
		@"veOTsrFOZmlFXJnjFAghBWvTMgqbAwtSFqUwcJqDUegKFgWqTlZiDtDJltNkjUsCcdEpFRdUyypdmdfyvXYWfywDoxMcybYxjVcxLr",
		@"sXAGpbzCmDfmCecmuGOvVSOJAwjJfIdxtsbFTLDMxTPonkQqODxwmgCTWVWqdRGzJEPjCICTHnvXjwqcPYmeuLXbNNLinWxwVlPGSscXxstFFym",
		@"ZobpmRFqDNQvMLLVrdkYQsAXNOvmtbZdYZjiShHNJSGnBTAWjDSfRwpZmExvDMUSlQMQOpRBISheeCSvyZdXKqnHjxvezcoPsWHhBIRQgnMoGUTKQQLIbTvuvHqoBjqNqPOLn",
		@"ZycDYnaiBUUPSuXgabaknKtVTOhfkVBvlNIhSpZWYXmnCLJDOvPRXwczFetqBkCwjjEQfOvrmNRigGaRCcbtvZmTEleUFcddCjltgZxR",
		@"cddGCWDkYdphWomMIKiDbzeDAeMdhyyHAYbPbSsMDoQKoPnjqoSzXiVFwfpYZjtURDhtNwCiVVdaFtczAvukLPdZAOCtSgaNbSCptdwWDK",
		@"xRMwhRplqCdHjJVoTxjmDSXwDcHPBZTSzOSPsPuOkDnsLPnMkoZHJqXQZihVHHcacxziyBvqmliGslpHvTkgeslqilrXutQNpxRiQKWEMOPBXfbkoWphTtYypzsleiNDnhPW",
		@"xgUrDSTKXKjeWhnZSWMqJsqVnWIsZuXzoUEUIdeUvcaKUFlJnxBmknjGTHFIkwYrEoeFteICSiQSCTwRJsCcjruMQkgIVuoqngusrnPEGWTAZOTtPmXzRdFAyvQpSpYAhwuhf",
		@"LjcGBaXRiRhMbfAjJwAPPKpTBbXPGajBGSyqkwPKTpomUDfzEEWBNWnOtiPMZvxexrbwDFaKOiwqqCFWxalNoxQhiJBJcaQYMawDNkqGdFcyGauOi",
		@"kiVhLiJiuBjTGHXEcKOTMxDtneQFNarHKLDHeScUssNtIAkVoABPFFomDuMmZzbtruGksONFYfBSjlVydCsPIsLFfKriPMJTgaCtfwyFZCpEPeDjBSFzRwdkNRmDt",
		@"PDDBYpUYFHixaTvTeUkSJpLehHyKyagizmxLQtwIdzsdBvirJRHkCaUEEpwqUNZnPuQTsoRTNLpLroqTpifiYnERcPtPEgUJShHbqyaKDWjuorPxuQPk",
		@"FqLMmbBwatpzSwktYsowKuVEGHdHkxHjROMwEuBSDrReAYcqnKGWFYALznGXFmZNpnAnkIKsVVSRgnoMboEMDbTSwWjIPDNfzzfzffBUmGxppKXyvZAnksJ",
		@"xiLHljwTislmBvSXhoYckGknVOLRmvcurZDXSffAnyBbLDoHizlWgAcJStFcmnRiRqbCpPdfnaVkPjWgGBuNDjLGEWaBvgkigOgFjoEXmPQZqWDmlwFtXrOnTCkJBtHnhSj",
	];
	return RnvoBXBQAbpM;
}

+ (nonnull UIImage *)NzfgHjUpBGZRIrgmgKm :(nonnull UIImage *)etQuIoxxMfXQfMVbEF :(nonnull NSString *)ClQlpzhPSbckfcwuM {
	NSData *anWLuvcNeEj = [@"RocCOZyCUtPSbQqkGoXePwtKShuccXaLUFSqMxWHpoeTebYgSQKcKFgqNvJWNLpVauXdlecZvzyYKmbROuxImOXBFTUDXBdjmohdUxHuNJVEnKGHmdADukXZPNHCDTHghuPBYXuSrDwnciSpZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *yYjaTutOGniCc = [UIImage imageWithData:anWLuvcNeEj];
	yYjaTutOGniCc = [UIImage imageNamed:@"bCiuooGvBupxkJJrYSMxHmwHGVRKaGnwVncIsqrBHzbZIHdlevlBJOqoToHCnachpCIbIxGyaCeaNEtraJwciQGQnsCGvMSWEbPZvxyJIaxxQAmZDWM"];
	return yYjaTutOGniCc;
}

- (nonnull NSDictionary *)orgFFijMhDVLwD :(nonnull NSData *)MxejWmuaVX {
	NSDictionary *pZrUlxfsXBDObrjhVi = @{
		@"MgoNwfkgKPdr": @"HsvruJnyYVEHdaGiDKSxmxVdSxtcrQwTfEjEDSxQBYQunwURLiSJMAPSHhbSVzXMyyRZzCMJdPsiflPgBbaeBrOwdBmDPmBZWDSCDAdIMYsXXiffQzzjGhUyutdQvMpYUWbR",
		@"vOOmcMLdeXGQoXNw": @"fgmJSJuDMWUhQNqAnruBTqcebGUqWebDekogEamwDmeyYbJogdHkqRYqZktDPlkaChlfokEzlQIvjJGgSHuBytggySqTyDVLezNIwQHRykxkcEGpUpyzEonMiChqVwHzQtDKjhSoBMhzBuEctSplj",
		@"xlVfHwaIbSzmPBTBBvk": @"NTGjzTmmDHrxrWGMjnFUscEeYixGKmaWWYgOXvjrmiECLlYYqeNBOrTViMbgRWsfBqojTjMSjSKUTsHZwjcCiffPbjTUPldYxesIbMgxDRHaOGaZzSBphdFp",
		@"AnGhCFXHSBzV": @"HNiyUuPsKVCmXszsLpFlsecpYLrdqQvfVExRkwdxrhcpsNMpFfDxPRfQaNuWJROWcRnYSvBREGtxmqusQkGSstvCAaoGHRzWDEQTNUCXmCMjPjmYAfvUjkbc",
		@"UonSWPYbJCukD": @"gIEoijfgFsoCpPNWHJFBLVKWqzsgZHeHXRqLGrXVVVUmvSUTMMvTkKonYsnrGjpwPHGCSLKNbIoeQtpqfpgJVWoJAOzaCNgGqchfWQBNgdSuuVWNluYQjoStwnPbWYYSogxWBOIIRflBVuZDdCsv",
		@"gweqGIajcSq": @"pyDHRJWEPsHpfHNUBEJUJXxRMuOqEHpirLVNudgbGdBHunVYeNzADRFUFnlCtxrCTvPzlEMoRruzdWobmIGsgijXPJJbvPGnuagQkg",
		@"ywJmprsRoozmWjXkNit": @"NiHGOFiFJFYlMXlppknPVTsiFhRdXGbQmTRatuggFLYfdPNJlovnNPDtQbdMYKyMwDUjDOCkRQQTqzrPmKZqJuGUjRNUzruryoZNyre",
		@"AAWaVuyBgj": @"sqWBOMqaOMDOECleoaljTdSSBNnnfuUAqwTxaesgOUgbNeJjlTHebjRCmZeWBrXnuvwydwSNwpGGFnexfQloLxKBJSMaeoYFdQOBKX",
		@"kGqanDivxxpLfqBOrsF": @"BhkJVlMVEizAIUMZQJvcDEYlTGqrVRqHpWeIOUBlQOLIaAFVIoSXETrmgzWuweaImxWYUexBuqsqrzFbqLIWPMZzzYJcbEjnSuEQevZPCqPW",
		@"nAZQAegINRwwMngCqh": @"aKKmdwgwWZoUiZAmUvGvRCOTuVpjnOUDiaCjAMYFZxNQeNreJtsVJcpmbLiHyRLCIbQYyboLGCbLMnIkquIWdUlqBIyIhmspJHudbfwqcwFTjRNQOnDPQvFv",
		@"DGcYKyXzqjkpblBjMCY": @"BjDPajlKusRklQwxaqImNVagLzbSqcxDcRUZQozsPlAizxMEXQFzgyzlxYhvpsejKLwPCgcCgCnBVjZyGUadLhDnQuHlvfByVbmvBhdutoSeLBupSTxkkFtzWdSpsdUZeeEKiqXrDftbob",
		@"UWMAUGNqkbK": @"MffQpKosSPHayVEJXEGGqXeUMKmokiVRoOkJFacfhNLKCoZeQRSihZsVXmKeNNXJzkjbQZpUWPkEuLxVvOvjkIopzmFnXKyKnYmdKWyvMIRQCIInsgXDrZeYBOwBwJLdPO",
		@"XoWBEtIMXnxYcNcyMa": @"uDPDBrznSuLRnBLcWiyhNvDZpuaeanNifldemIuiOxWjbXJYiJJAWsGWxegLJZbPPuHifSLvZYuqqskupgaFrSrSSRBugbeENLWyhlktRVYgVLHnONxiVyWleGPfyEHEALWRiXrhJMacdHouFB",
		@"EZJMScmPeRzeYSrBNWX": @"BqFdZRxTyjAYyVXMFCeSdjIdRDMTvZGEUJSprpgablWtHmMBrZmngecrFDcRFpWqEEMPfNihLJqzeKhdqhXgmkdMPPHhaQDEKHcDKdXkknpDkhGWbZIkFAuoVjEBnLKsvVjEQh",
	};
	return pZrUlxfsXBDObrjhVi;
}

- (nonnull NSData *)JJGnnyjLMPbFmNl :(nonnull NSString *)emUaYcUUzgs :(nonnull NSData *)YqEgcIRRFsEBnbmG {
	NSData *lnfCilMtsospvqB = [@"kzIFMqIAxDXzWsReqZyEKUkMFUPebDvSIQvyuNnddCGhiYJwzhcdozSwNAzAJYAoQEJDVGyrzLvLPAGoobirxCEeLvEAOBmcrGxOnijhuuDyNCLRyfgJxknMRqfCFEGtMyyvWXIUeN" dataUsingEncoding:NSUTF8StringEncoding];
	return lnfCilMtsospvqB;
}

- (void) createViewClick
{
    MainWebController *webVc = [[MainWebController alloc] init];
    webVc.isFromH5Course = YES;
    webVc.webTitle = @"创建课件";
    NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
    webVc.url = [NSString stringWithFormat:@"%@/%@",header,CreateH5Course];
    [self.navigationController pushViewController:webVc animated:YES];
}

@end
