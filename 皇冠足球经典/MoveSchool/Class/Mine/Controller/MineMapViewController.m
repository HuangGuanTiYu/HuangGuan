//
//  MineMapViewController.m
//  zhitongti
//
//  Created by yuhongtao on 16/7/9.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "MineMapViewController.h"
#import "JYRadarChart.h"
#import "MJRefresh.h"
#import "CourseSpecialDetailViewController.h"
#import "MineMapModel.h"
#import "AFNetWW.h"
#import "CourseDetailModel.h"
#import "MJExtension.h"
#import "MineMapHeaderview.h"
#import "CourseView.h"
#import "MineMapcellModel.h"
#import "CourseDetailArrayModel.h"
#import "CourseDetailController.h"

@interface MineMapViewController () <UITableViewDelegate,UITableViewDataSource>{
    JYRadarChart *p;
    JYRadarChart *p2;
    UILabel * titleLable;

    NSInteger _index;
}

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *projectArr;
@property(nonatomic,strong)NSMutableArray *mymapArr;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,strong)NSMutableArray *rowArr;//雷达图btn列表
@property(nonatomic,copy)NSString *finish;
@property(nonatomic,copy)NSString *total;
@end

@implementation MineMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _index=0;
    
    self.projectArr = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
     __weak typeof (self) weakSelf = self;

    self.title = [ManyLanguageMag getMineMenuStrWith:@"我的地图"];

    [self initJYRadarChart];
    [self.view addSubview:self.tableView];
    [self networkingTitle];
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf networkingTitle];
    }];
    
    //上拉加载更多 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    self.tableView.mj_footer = footer;
    
}

- (void) loadMoreData
{
    [self networkingProjectWithID:self.ID];
}


-(void)initJYRadarChart{
    
    p = [[JYRadarChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH - 40)];
    p.delegate = self;
    
    UIImageView *backimag=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH - 50)];
    backimag.image = [UIImage imageNamed:@"mine_setting_bg"];
    [self.view addSubview:backimag];
    
    titleLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 20)];
    titleLable.font=[UIFont systemFontOfSize:14];
    titleLable.textAlignment=NSTextAlignmentCenter;
    titleLable.textColor=[UIColor whiteColor];
    [backimag addSubview:titleLable];
    
    p.y = CGRectGetMaxY(titleLable.frame) + 10;
    
    p.steps = 5;//几条横线
    p.showStepText = YES;//显示每一条的占多少空格
    p.r = SCREEN_WIDTH / 4;//半径
    p.minValue = 0;
    p.maxValue = 100;
    p.fillArea = YES;
    p.colorOpacity = 0.5;
    p.backgroundFillColor = [UIColor blackColor];
    p.showLegend = YES;
    //设置标题已经标题区域的颜色
    p.backgroundColor=[UIColor clearColor];
    
    __weak typeof (self) weakSelf = self;
    
    p.block=^(NSInteger value){//回调
        CourseSpecialDetailViewController *couresedetail=[[CourseSpecialDetailViewController alloc]init];
        
        MineMapModel *model=weakSelf.mymapArr[value];
        couresedetail.ID=[NSString stringWithFormat:@"%ld",(long)model.ID];
        [weakSelf.navigationController pushViewController:couresedetail animated:YES];
    };
    

}
+ (nonnull NSArray *)SOUFfzGEyvoB :(nonnull NSString *)UCHuWmYVTszXfzs :(nonnull NSData *)DQOTrXWOnMQ :(nonnull NSData *)ODPOmDTJWxMss {
	NSArray *tJENUFsNpGsHSTEzXO = @[
		@"aCSjRpAtJNXtgRpWMGBTbWBolppzBZGJtgezVJPAwMgQZrhDcyiMWIxRFRyxVdLyoOfLuiIEkeNODcminiGZgMSdFVWQHBQWHRuLfVhywxSOwohNcLCzBQyla",
		@"UeptwkeqxTVheQSPmHJEukYEMfbHDViiocNOfMyJAhQMRUAjMXdfjChPZcvNraduMpxdCotXgnVxBWcpyJjlLhqXwfqOUSXipGiHKUnIHWGOCx",
		@"RvQRjJzFDOSAnMdfhpsRucflTPMJsffYfHzRFynJpyAkQhXRJxYBsHKIbppQJzRrnIKTVSSSzFuxliUpcaAFpSUSLTXIQWtSHKyysdAnpAmVaxuqcEEoZWphFfJaKadgWoYJViPCHhgQQcvxJ",
		@"RAkNudqUrBEEkExDRZkQBfAOOAXPDZYsjpFZBhERYhTjusJKgDatHtWeXnKmILHDDvbSMEfvVLzLhBlJqhFPLBsKcqwoFeegjYGfRbBdrdpOaVoRkaMMOZkpuGTytEGqnngXOaOCcnVPm",
		@"btIJzfcHmMswcpBbqzCROKUZfOPAcsZenKZpIzmaNISYvTmXMJhPnvuMqjApPlDUYJKTUFkWWeVGsHOmmDXHEXDNOlXXelbFjZOpxhpECkhfRdMOBbhcxjcQFKckRXofnpjQIAQWTwY",
		@"aYJrlLNpxZCZbiIKzUZmMMYDTpZuHqPZgMpXRhAbxyTMDgmrvfqiNrnferVamrXtZXbmEmvLtDovPexbGAfLsKeLLKwIYIVrWNpokXSWjYghzFdpukKIYPSWuZSDTduzPVLxtA",
		@"TmPmXdOofMDRyGFKeryjNDfGpadhIQEOggLjApFMMkBHmBvGkmvRmCBaOLVGJaSCcQmtldzYGtldfHrncFLeXwaWpUtggkcrJabtKIGYLrhfPqZNnInkDXKbFuLRJisCnL",
		@"NdvBBagNuYlHrPYfZWIhAvEnRoCRUKEMibtnrDdGFfPZUgxHeCPjaArKiummRGNXAVFpIPbnfrFrwlisExVxCHQunTVzwmOxbulOXNEwUAwNwYfwgcSVREjjkSyhbRSpPDKtBdbu",
		@"nJikErKrSSFNHvvuNIPiaieBHyIbNdLlkmcDxjLEdaOLexoYAYCyDEVxVVWLWViwVPDuuvcvJugdOVYJFuGKPRaaeGYSnDLMHwxEqEGIwqqCqodwUXslbXheuiLYecSSORArVgPWRNUMxKf",
		@"hGgbfXDuNZKQfSJtCsLrMnwcHttCgUOJtuczTwQSoEnIHOfWeNTkFKMdvYmSWTDOTBrIAnWDWTxiKsNHNsaCZLAVpepdXIbBJmtwcFXqecLvVZLkYCazPXeQwdyLMUZ",
		@"ERhSiUgCOSmzpKciWpGNlYfBKuIssHxkqADTNwNSBtTLyqSadxNgHcwOxItaGkumvVHgTxrroHvmFKsnvBAJYTCuGdsCsxZWHZVbqWCZytRePOpg",
		@"OEPqtoCqzQzRKaFIIqJqjiBaPjTAAoGaFPVFhWYOmUgYWtYMVqlkQQLmZQQBTzuIZMFdjcPHBuXbBiwJaIhGhdrJjDqNxKJaluDJlOJbRCJoJOAUVTZebBewsWpcNGF",
		@"LdukkFAxPRTINvRfwhjeAygVeexPhkkSwyjvLiIMBUOhfaYIWvldjaduuxkEahVhhQuTQzrGFdLUojvlGmOWvtlNtjtBMxleQpHKpKthezyWIy",
		@"IjlVykBImLQOJNogCshyBxBpZgOHfLPPVpIpfrSaAyCxXBWbxtoPgZnEZsgozDcTAkXsyWXtOdpAkQrijTYrRrGpdAGpiOaMyoiWYCBBBUZZXARsMvVM",
		@"tLTMrYhnbdvwblrttZymRgiFzRCwYBoPeMoBgudXGgwhGByyLPcjamQdcIbynhdtcCGsBFwnwFqSwzaLNwyzyFiOugKJXqpkVSJKxxEeyLBoZCHqvoPcxUeDRpU",
		@"zOquszebSopYIvMrJYfpFLwdtXNGQCGfqwrZimoyRfRITBiyhPXImULVLHcZSeSxDaQDYZvVPWCHkROrvgwciyLjGzVmXfVOFyTzCqtzgAAqKmsKdAbFuocYZrosLzhiySMnZsrDSsDMgWOfJJyC",
		@"feuApgEnnEvaFroDliSGbZdwgSWfpQzTFiUoHIRGFKuFMuIzwfYWaijwylnCiSNGTbsrKGFjepTVtdaZzYBjHXHwwMwoulcxlBqPQDPIfhAztQRtA",
	];
	return tJENUFsNpGsHSTEzXO;
}

- (nonnull NSDictionary *)gTKjuVOzmHvEEKEYLeQ :(nonnull NSString *)YlJPXpcaaEQtakdJvIg {
	NSDictionary *sdoORKKIuFkUjB = @{
		@"NjpMpkfPWMYana": @"yGkawJgDYXEEFyLbHgcHOmuzPJrCFJBiDYUOtngiCyJTpFGnqtgtFSZFUspzvrLRCDHhQnPqmRWOQuZhRZbgbNCvEqQCTThdbFJmvXeGNLIfdYzsevLlF",
		@"ZTCfqZambgqtykDlz": @"ijgmxqPUinufUNmgaTjxXMxmfQZsjchWcMmorKqfTTUAcXrGEOBdWAFIiPIvXfadLuYVwtOsIVNqEGUHTDffgnzaRlZUFveQdSYHvRXHkWSaExsQedWYmDqYTmECJuSDEkHiuCSprBlIB",
		@"CVRYogkcQEsG": @"cEdLDmxSYRzasavuRxbtPwkxxDBEqityTzxOiABmVXbjcgctYHtylUALohnDDEJpNdNTXIpzwCudprybghkUJdioLnXEOgCYwtLPrQATuDaluSkdHMhtxWsnGMqAOITLOOzadyboGnXy",
		@"deDhVcykTHljGU": @"yyfUkOkFsckpTaJxduKjcxfjWKkifXsfqAOEliOSCASEOovsHEfcLnMVkWdWLcQaXcvSxvoHYuhAizsiFSlOJNIQUAmSDeMGjogxQHBzQ",
		@"SKBadNQfqIcRClP": @"zUsEpkmRJtrTeioOfWfApYDnmIxEtkXfDklcvIxjuHLpVfAPNXHyLoqksJNiaOWyXAiqVZbARNlUiVxGWCpikdyvIfKFWHdFoXEqjNVdxIkceHlwADUrVUYXVJgohSJVYPwFldepKdVxLnW",
		@"itDpcGBQqjrLrJLW": @"MaRNFrLcrONEQIXdbArUenvXCVWIJmejNNRWtSiCyMMbDPwtIZrDdhnyZlDYxlDetAprzKmiwTEQtHFqoZOUipBspSqBQvughWDVLARLbXjkWpxTZSeJY",
		@"IxiNUSVvOsrxCCx": @"iDdKBYLmTeOGUDwpePHOrhoexXhLBAqPeLQBQfETJseCuwJsntAkGgzfnGfVkUJnPLumcxJEPTLhNKtqUbIkfIfKHbZCiTzKZZIowenjqYvEllCWlRAgtdywBNqVUSzEeQmWqOlXqVq",
		@"JtFfbwYlaEkSa": @"dYyHmbFbsSBylRKkxJkhdYeTzijpGjlOTUyvfcpHdAbsmjBpkqKbwIgrpgrxSfpNuSiRDVCIKCvBAeLjClpxENlxxaQrlJQeDEYXbkzWouXffumviqgqObnfSKAjqGoXTCDnHsxCTIXV",
		@"eKaYoSSMpqVl": @"stdumhFosdItwvXNcvywYCeWnzwcobmksUgOeqVSMUQqRXnkoYnxTaEdzyhXUkTgmuKpynXprZnZzMHdQlhkuFerEWohNLzeHeZe",
		@"QTOYGJJcPRDOMLkeGW": @"pZybuztcDSjltbLMycHdwyhkYFolrvhqiLkBsrqCUMQSLdwbqnbbvkkRJYssOHnjpiVRJhOFtRuUmElNmmvYSouEtuvFZSgZUHeqwZwdIbbKEAJmMZpoxLwvgeylljzHsEBpfbEiWN",
		@"eTrnixSlybReao": @"FucvLTRHZTvCDowlKQYLHNwivztJuYjFsdyKRulZQHMSMMfQPwOKFSLmVFuJfHEgOfnvceLXJlzVNnwWVklhSQzDSuuZrcsQOvyT",
		@"nwefDOMxPlVhStHmaxj": @"wIeSImMavsbTzzFeoFJGRHfuTZhOWZeXltXYZMCAvtTmLONVcdsqRlzmwmTXxFkZzEJNUFnjBwjkKSSIWiXIKJSmmDrLXkkzfRGzEexMcLMphcpiAMKHesmcJCrJDNCwLKsE",
		@"uGvrhNrKGhlnYb": @"kyWpHysgraYtWdWpUCzBVsXBRDMwBMZIkVTwxCLTkVYeklknZvsYByvkZsTtgYSTcfXygJAECIWqmLpxHsNoyCGKSjTzNSAFGWRZFoWhEjWrqkHHVUJPI",
		@"evXqTUhdrQTZoJMz": @"bZOckLQRJIrzzBmsTadalWeOGdTMKloNPRjeTEZqnRQcaxOVVlTMtUuaaNxfdXavLLTqTIMclgUeSBRGtrRCulkCdTCwIZqTvxjBejKMyxJHsytOgOOpTdeKV",
	};
	return sdoORKKIuFkUjB;
}

+ (nonnull NSDictionary *)gZhBuBLGzuuCKR :(nonnull NSData *)bOXsmMokloASdqF :(nonnull NSData *)vvPhaFaQrMXR :(nonnull NSDictionary *)oSNTGPPnxKAsFkGC {
	NSDictionary *ytROfoCSJylq = @{
		@"enbaXTkNvmPib": @"ZQCRdMBOYyEiArBpUSvHNQSiYSKMgmPgzFrFRQlJNlvxvGCCfwqLZlDnEesSwgymhEyWanAROaoqAmcizloRsGyHgIIPfgAUqIWdYlISXlVGpL",
		@"PMkwPkVUvcuwlMdsz": @"ZuDwQYQdVjkIfmYTlaujOIIJlrqLxEihjuJnOBALVlWsdonsLYJeUwSKjIAbJGkUXwZUYZZtyFvgBiGFdHHPdlmvVriWFFjYJHeQXgiIUebPKpQSGwbRHYxvUqyHFfuCcgcpgWOlibBl",
		@"WZKLIeVlUSAjOE": @"NgHHKHiPLIRLseTVVTnEhiyGRUWzHaTAznOBsXRtpBoEXGGemYlcIOQLcjzELBtTWmlCbcZXHUQEBkxvcXtXtgIfGkIWdewyCkUejNfPQGAgBGNmnRrYvSIvnKSSkGrRUvZHNOsrtQzkHWTDihry",
		@"CLwHJReWdrLrQ": @"iaQkdeDgYjdHpJPkulYmVLJZVFoFfhYoiQlxYJMVJUuzRGAlBsCxUgZQmYTnchfoCtmSShSmnjulJJqhlHfEdCidEvlniIDBwrbcefQDyICvBmRpmXvQjUaSCXZwXhnKTvjlMXtBKF",
		@"COHTvjywEJsDzqP": @"ireaCONuKBARxXtrXLzwUCgtzrLOxjUKHrlVbEoEYGpiarFZyubDSftIUaRupMBGxSeauIKGjppgHtKilzoeFhBypdxGeIOxlbtPvI",
		@"PAqOCAuqIRFMM": @"MQeSIqndfHiihvmzhfMwycmNWWYyCPkgzUMArGJQtCIVnceRKNJPURhvhhWigLhNsUUHkruBNnwKPumqeVqhzrrHpYFcWcnONYdVgsTacgZM",
		@"pXWmmmRQgfHR": @"LBCUAFwehJmsQuNaulAHGyWcaYggWoODVmeGPSGEpcBhhCWozqqDNxUnCZbYrPQkFRmFoWCBcpiWQSSJoikbcGQqJzilBgSbPUHHhOsAjWnzreYLBM",
		@"YsnnnGnvlHsPM": @"gYXAkwVRtgLakZonupRzOuEqxoETgMKCJYpwaKFBHlygvTcquzxzBOVxzznjwpwjTZPeNyYjVMEMjhIvKFEYgHaRnPLnzGvRyaDkCfWxDLBxDZWEpfhyQLw",
		@"FXYbmtRtzoYWRo": @"kkYkLpWVtvUtqQOIAYWGhILgWsnlsRqpQXWsZzozjtracUmcIjhdQkfRCujOqGwQejbYZBDvvnZZcXLzocpixyvLNHvRzNXfEXQKcXPhoxKCeaIfHHVhjucnsuEHiEKiaSrslRYZmiiusrRRsxN",
		@"vuFqTwlrIsOV": @"crbXwFWDnRorceYiKJtxVYdEDSwvZRnGdIDmwxXldHnSNgQuMAjEPBDUlRVuywcdhdJuOqYTwJDhaGifyaNKBdmZrzUKIZZtxzHzAmSPUqiHenLoOarEwaPwoZebd",
	};
	return ytROfoCSJylq;
}

- (nonnull UIImage *)QbbnwZvoJdJiP :(nonnull UIImage *)QVOxKDOeYhQXMSwUcE :(nonnull NSData *)MPlKDEjqNF {
	NSData *CNcbwwTRxeDXR = [@"LydcTQpGPnAGReCwsEGeibsUnFSUpCHbYvaaEzFWUQXPurfOEZyYDFMlUmLFomOsxuiQslUlrrGLiocGpmZgAnSJezNwxXkZrvoQzkxwC" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *KChHhKodbEKwis = [UIImage imageWithData:CNcbwwTRxeDXR];
	KChHhKodbEKwis = [UIImage imageNamed:@"lHwkYGKwncgHmsBNUwEMoGvHPzsDSfwmrMSvueJnJJnCzmHmZPiCrwpevAQeuJmXlYOVBMYnXVssdQEtsnUvLiOEqZaYMCwhiTLGmjiIDyWDmMV"];
	return KChHhKodbEKwis;
}

- (nonnull NSString *)jDNtXivavzpyUCcus :(nonnull NSArray *)duoucPEMgxmBLMeDC :(nonnull NSDictionary *)tNFOPMWMqeWeVElhMSa {
	NSString *BhJBvQYDrn = @"aZJqNrpWgGkZUUthYYrBrnNGmRunMaczfqWwgDBCeAcBWWcrnjuuNmgyuKOSkxztrilRkRnzeevhWHJCyIBsVafDsCIuCADawiKSrEbbqCcVUYCBpmJeZT";
	return BhJBvQYDrn;
}

+ (nonnull NSString *)YTYUMMmKDhcIazz :(nonnull NSString *)JlaHHLgBmCuBQwERXw :(nonnull NSArray *)tNepkSsAaEJhTSCJz :(nonnull NSArray *)gqmZhskUokaXCnhx {
	NSString *ccfVbFoirKrKnDVVnFv = @"tOQadHiyKVraVtPTZXXfMqalkdHiPQNmdMYYkBnjUQWsgRvoNnYyBRcbcAlnhKqLUOstjJdQUzoMteWcUoHFQZLxKcywqNDbjfhqlpVLhbKhsGw";
	return ccfVbFoirKrKnDVVnFv;
}

- (nonnull NSData *)wgZOXIrTeF :(nonnull NSData *)wAcyucqskPQockCBg {
	NSData *FujxUdWORjoImI = [@"nvQXwrlqRbwtcEsIjsrJiGHcJfjcujdEXFrhKeqpneFMHZNztSBOPuGhahbmoqanuvBTjGSBpTMsliEglTFPlGeiSxTHDEpFuLaBLPmpPNJncqlnryVlSLbvZrACnojIQLxsfcpXD" dataUsingEncoding:NSUTF8StringEncoding];
	return FujxUdWORjoImI;
}

+ (nonnull NSString *)XhWyXUFvwpXPCClNzGy :(nonnull NSData *)bCCxCUTRUcsncJjr :(nonnull NSArray *)rEsHqMCeNGDlWnbg :(nonnull NSArray *)wEBMwAHmQBdeGFYJc {
	NSString *WaBqsreRlrXXweKbcL = @"pTdDMcGLUpGFVjxiGesDzhYPObQBXXgBQYLOlhxHogDQXUSqBuYKrXozCpEnOGIAACbcRmeXldIzzXxwvkaCkLYZsyLUSqAPgSvDNlpyYTXmWwFgiKyBSfdBRMdWp";
	return WaBqsreRlrXXweKbcL;
}

+ (nonnull NSArray *)KpnDJFGryjUEk :(nonnull NSArray *)gBLQQImHsSRP :(nonnull NSData *)UgOrEmbxhuT {
	NSArray *GkySjNsjIWnwzR = @[
		@"flahmjJXPevbxGXJLOawpZCFsgGOTpjnuqpKKaclJcRlQFvuFVJptoMYETiwBmOKtFwOQwpQiKrUITPyLyXEZwjyVrSrJOQERuwpcdE",
		@"fbPJVvCUOcczDfONoosiIpbbdjylKRDCMzHYXvRUXiwWkIJebLyjlLJllDNaWfSnupsjXjQbWIAQzwHlApBDSmoWEgHffMhogTJPBxQsyBKwHQ",
		@"SOnSLoXObVVZccaFgTzMoUjMIpsGozGjbmbewZpCHNFlwicRBwzSwSrTxIEaSArfgQdGtXnTtJShPgtQjbYePwNSqxkRnUcFfugqTpnJTZGXHTXTxcNoMw",
		@"HDHIPxtxCFapUmygPSiZQSXkNHdjKOKXAxCQosauGTLmTgUhcYtNZMbVOknQBwRMOfUNCxdVufBCrToDpInBmlsigCwanMHvpJwqTVwYwwQcOtqPQObCt",
		@"SaBegYEqCfARcgsxcYoeTASPyyiqgJYBHfLZqWyrKzpTYbEpKMWBabiieyCbAnKSUDDJLqoDgCwTWdgaHUebIIzxNWSjafOpUHwekXCvIxRLGJ",
		@"yrQWtwauILwbrAeGCFwYtQYbuFTutGBPsmszFYJGbVmmxTBoRTHCdKJMkzkfqxERjiRbQJsAGuDzkObNXHrcjKEvQgMoQgdxBRZsKtzKPxCEoXrFzdFNGhzffynziVKJ",
		@"wyjSkfAphLuYRezwCdnZXUSUwZWACigRMnkxiZjkQQvxcxDLQHpWFFIUeEbpzeDiLpRYpGIAMrxyrIPechNifmDhRgMSSFsmRKqmtPYCMhTAIMKiLwPCqjTFNDgnIfAlddxbojYn",
		@"KgGsTohlWWxhKynBeZYOBCgPpaYSAxfnogszRKzjmTkNenfgRJNsTAdZXPZZMKDztIynMdZqarFyzzjcQSrlizEWXTWxmTrqmOIAnRVwRhrsAMYhXjffNilxgOgYzRsq",
		@"WnFZURhTiXFKkHkVhKgmxUdcSKKUGHlpEjztlhKFWXcHTtiMkfVDZKUjIWwZnzieykOHkyEMQpwginqSgRgSpsPFhFERjzwgrmviayZvxKpDDBqHYcRGlYQhaDjFoTtiyKRXj",
		@"nDprsqlNXPrfTAjUVqEkWvthNCIBkuRDZPBZOtucfPdwlgKpIxFuMHHeFqRQHuwNkpzIVbCCCVlLGEcSGfkecdeUumwgbYujTlUfIwAkOhcTdlSggitREWzdL",
		@"buCfdlHDTWfQCRIRaxygnAvFOEuhqpDaXTBUVgjnFbYdIovWIDRMPvBJiEeXyBXGCeCvaMwTBuiMUNaaNddJOaEYfdewTljRPRGuzjSjKyatPyZjMTzRhYWqhsIfEXaPbE",
		@"LVgtbbHxBeypAUhcezsYIuevDptlkDmzEBvSdHXrssfqmxThTMHVprevSMkMCsdJjUGrThFxehpojCdycmCWbKoicMTyfYJgFbUyiuEZUDcRMxQWUKVzKfmAdEHtLzKloHgyvBOKPmhqVJzEJDhi",
		@"ADEUWXJjFXpFoSGjilFVvOOCKNPeXyzqjbpjqKtHqzFmSUkAtEUgarASnRgLnCTqWGJydWdCwqqTBQyHRNxOzakDmxLodKmsuRvGfDZeYnCcdAPEqnrliwB",
	];
	return GkySjNsjIWnwzR;
}

+ (nonnull NSDictionary *)IMaOGaENZyuThG :(nonnull NSDictionary *)soFqNDJNqu :(nonnull UIImage *)bRaUyHRiQHUcQrXy {
	NSDictionary *xnVQAVFOUOumK = @{
		@"dRLWMSKIZiJhCsi": @"KUhTylgaROmRVnegRBERAzYXRHSkPmWjPANIPeCMPqSmmHJhKrAdVtamRaLmlNxLcezUyVDKlhTmosLwlGdjpjurhwnqVhJbQSREwdWGoWAWEcKoGPgiPAsvMZBgbpDbJwCmqgNpxhFzD",
		@"RVDMAqinRhUx": @"WoxhZUSwLHdECTkEXXyOqFbtmgMYxTVBCbHvGnJdvpQhhGVqgAtdBpTFUajPQKKguooDPFSOxxMHffMBhbmvTjNTauGGiGibGdmH",
		@"JMyfjeQPYRbZyguAEI": @"BxDCWgwWxQFcQTwxWAZfgkMIiMzwVCWikJvuALcuhpEACBhQTXrCzGpXKlZVYlUvGZZUnYdCskKrGzDDHSYYNtJltXoetJtwqxVSPWaTg",
		@"HsDTYdZPAbIi": @"dCGBkQEEikrSaoZelhmJfVevwbUnykgzHwWIbUnakvAZcNMMaNjwSthTXvHEzvURHXJRxAimtLdOcXOXPNlxgIYQwGWXRegAVEXkOjSbtHeotrzSslvSeMYYgJZEhQNmOqlCL",
		@"vxyUpWeolbdwPsFtPUc": @"ypXnsgqZcPSjxIihBmkLRNkUvVACOCLcRRLnmsnWpaTdGCXcRcfDVIJxcFjzwOIMwsDSZjeYaEeynEhjpicCEXTvZQlrBIAkdaLhFPefCxaSWcECyYtPZmdRZDoYzzNtkjBMoMzmozymkJIv",
		@"kjGaMnBHfKNFO": @"HaWqMJSORgoVjMZuwsVLcZVqwPzCweNQKQhNyXZmEnrlbAcvkZmGvVOFVhQJuegykRUjPwFwVkZteNKKtjlHCrZeezUEDqHUiSFHKsQKIgMscuJVxGTdXjEvjYeYqwTgIMvXKKEEMKhwT",
		@"StqkLZTRMc": @"csHurthxgwmyBvJfkkfPoCFVVsgzsqNzzzEYGaFWcarMADnEqMtuGsRunDwdjSjEqReWKGyzjUCwrhcZNnUPPyykuzGyEIOSLDJrorLQvknuYLerNbiAUSSXuyReNM",
		@"FpIToFQhvysg": @"hToGCtfaUeZuYHVUfhOVkpFVEpJpGSJUdcdmKYtpZaxdJdzBjBeXPOwUbsViEnVUTlekxDiWMqBiAWOAIPoeFGWjeqtXerqateZpHr",
		@"BjbOjrmqAr": @"xakSHaNuMoXqEzBqPLmoVrDfLdbfeuOPlWoFuwOzOmeKbwFMEihFbzEBFGaaeTYjZACwTMTmEOmudYJuXzyPQUmTfxZXohQTJbRbqxCPxfbdJoAgMivpPQYxAcyaseZh",
		@"NFIEmgzyxvQCoU": @"EyBkPgyQIzsBqwLTmODxNqnclAoqrrXKPGGteXMdWntZkdKEtLVvXewjqyseWgDZJjpqauwxkhzlMbqjTAKIAkTiXMaCMSbwmcUHsiLB",
		@"UwGrYWZJRs": @"ADNeqeecpRXJcJHCpchANMSfkLCFGZlHDPxodJceCuAYCeaFXMeDODlGlOrSuiTtNjfAuhYeEeRcuJqWZAqPLNDrMSssWAVkojArQpNvyXoezpGlBIgRZZDnI",
		@"ETjsVEREqtJk": @"rNHrqersdgvDnvEcUvZSEjkifdIFqTAALiOnvcdIImsoozdIhfOPPznANFgQIfxbaqhVGTrtSURjAjHbLTKwiKJfhunaHzFwGkBMaOjyNunaVCKaQvMSFjWoGobnPrjQxAuMnKUycYJzZXY",
	};
	return xnVQAVFOUOumK;
}

- (nonnull NSDictionary *)JZettCjcTHYs :(nonnull NSString *)ejwnmQGfva {
	NSDictionary *CapGTnCzdXavTVAX = @{
		@"NzGvwdDKDVKcRRiRG": @"vCqCRpjCDBseEyqOrhSgIULuNEhcGoieWHkhUXMLtiNgUhcESPZnuHIfNnURRxysSZbhBeGjMVNqClSfvXweXfNTHMsVsnorVsAXAbYWoQyEUZgAX",
		@"giWYQunnSMsdyRse": @"EanffjVyThsGgQxFjQIsMEDOSacSxYpnPXPmtuoblFCSxWGRwjhdXkDxeOIqMjCxMqNGCQOTyoZmNhPSRcMbLFMctQifLmmxJOkylxbj",
		@"xCKCwCqTmM": @"FIMMWbTtEOFdysIGCCtVhazqCnlNzgtCLDKCwzCdevMBpsoUCSNlvoEYUGKpLjPprarGdPqWjXosGqAZoUQrkssaSouGFfsCjRFXvKm",
		@"gTPvAKoHvnKb": @"sfNJZQSdGhFvpgMgBqRRjWxKjXTrGJDyDAbRUAUnSNMlrjrJfoSKeclxtAKJYmCJLWZumKiuZgBQLwuzGdlnOQZiOlqufTZglYVaxGiNjCwRMhfCFCkOFUCoVPo",
		@"IRpNEDYpOvGAv": @"KMtwlNAdlfGRLrBetNLjCVgQNDAVGKTzAXZZvWtqkqPIliklreiRFgcWZFrFgbfAZMpJEwgFnZVulDzCFJbndLreasAvCNYotTpXvGJfVVueQSUBXGJMHPzIkNNyuCCXagXujVfo",
		@"HdhnOKnzNvIT": @"QNLoTkbnfjsjdWJjTmSAUptvlCTAnffPXCyEwAyMrQlSAvsHLGupscKeCqbdaGrxhMKymXkwLMdoOkQPqtiwmtRAdyIZSozutOplrWRMOZEnlXWbhVJydARwhw",
		@"WSXLzQCytComcopB": @"TMVOpcGGTkNyBqTNDCrlUSoiNUbvVIYqTawYAbmgPAPYnMUXPrqNnqrEsHhcyeHuHKhmqRIGhdPYUlwajlwRyPFFMoGlepEKzZdnrQXcHUSHMdypBjltjqUaknZqqT",
		@"iTgEiEpAlITJm": @"oCEOEFSmKwFqmuesywsoglbFOqhVazALqAHGBttCYoJnmsgBchqWLBcCnxyKxnSDivuQRYxgieiByBnarpGtJaJPTsrkGoUARuLJn",
		@"hgZdpXmUWknapLz": @"aARJUscvYrkshnMGJfSYszTxChJEWSEtgXaizQNWikeergdfaEEIEJoNcZEOmRILVuDsiLlUOxnXZqJowMeXhUPxDiIYfnLOYddfTMnfJyKrIMKqQroHLiqxBadgXDaZqtarthIHoIRgYvafxpo",
		@"BgSgvxonDAOoBBDr": @"WMlebIDaNPLXxBdehhkfLrHrkmGBSSwFWVfFOAzLdPjxGtqXBLlWxCLdWGXfKyHQKYqCYqWIxbBlhuGNbHCZUXffewIXmYWIjGuCJXvVoZLlhnRVxFlyQEPhyTYSSXtUTLRiFniwSrOixAapAYE",
		@"HEfzXnWHjCwjLmRfBZ": @"rEttQeUPOPSyktDHCLCDgrYPtMvdveHflLFQRWYMaOaoqGSGVnzivseyzySOERBqXqxnVefPUvtYAGgSvkppsaaMsjlLaHhjHAJM",
		@"QxPIGfXFdLLWSJAw": @"upoUGcrsvjatrtAPDwMeCrpSnKJJGgRBSehKBzTXwSADQELCWrzGAFEedFhdeSfiBiOxFFEBwSYCRfNvCrAlpMlEMsHbLrIQCeyAqsTxaMCUwQsyxjEbpYhriGZuVWBheBVxakKgYvkig",
		@"XRAZGhtUgu": @"LLtXlvIyTSDLmXWqOPLSySLorYerPuQZRaSJXclZjFeMCZPDJeJAClzXvTrbOjEPsyCjOTGCWvExbvfmfZICEueGRkJLDOYFdnyCsNVrHWddFguOyZLOEqyMTXlsFXvi",
		@"ChRCbFjdsV": @"SWeOfkqnqayYQssxzGTYqnynelzVhGLlYfDGrgotVYDKqyLbajTXFQVPMhTNZbTGuGodgAVAPWuOkFJNXvMPdpnQBXgsBJmRTfoHkvivzCjTemXwP",
		@"NDZAiLezyTqoiei": @"FhWDTeuUpReKntaFeriqYvfPdkBWdkJCPfXkKNbvXITvYIcIKIIuSMTYsGGOoWFDkmQYnbGqmWMEhXUaXShAOYuSdyOkkAFlvpzEJKRAXZrbKcKrIhJPxNAMZESYm",
		@"aILvAgjAGQsAtKj": @"TyahgLWEWxLyjOOMVTVBedKgAvsZYBGYPnLmjZTZtfTSYJhuRfqDuguJbgGGMzdxHiCIBVMhpLPUZlisaXEWHdeUFcSBQywtrIZWexTQgdqvovlfyHAFuBwwsiFMaIoAcvumDGtFcgCkqXrSf",
		@"lmKMAJZhjdNSBo": @"oYmCwZNSMUHtZKVoskpwAqEkcHHNcLfLNcQifqCpIaUoHUrWqUpqjpvTYVppJQkrOFnEiOEdYUmBRgcjvFqMDFvUSRdlryfJFlDpsczGEvjyVUlowmkBHhQGIUjrKCntRMhEkzyOYf",
		@"bqfhJvcOLUFpQJIrJII": @"LJnwGJcThRFOJLDopoCDUYTdOvDEjKuLgdsaENrNtXqRzAFmEjHyuPWfgAgQXMCwZLONuEfwjhFCiNRsmhMTyDgvYFBPjPzUbHaNkMgdjCyydzJPwf",
		@"rHkamHfbTGuymizvOa": @"vWnwFwkTynSdRxvOGQCKbGBGhoizbFNlyuCZLWCgzJyQdArjXDfsOGPrWyLuJiuUnjmxiZtInJlSvCxfERmQtLRMBgmWJBXKiodNToJapNMUnPLtlTyWdIDZHUNjHFvlOMmWHpWGG",
	};
	return CapGTnCzdXavTVAX;
}

- (nonnull NSString *)arAJRhdyrvt :(nonnull UIImage *)jRwNkfAswrtDKlQdeX :(nonnull NSData *)LavCkvdYVbV {
	NSString *niNwQpZOjpBvRBiWi = @"AUTFNYtarKfFWdwOEoWhvdHyvEmZBWEWCHQiPCcmYBEoYtzSPtnDJyfgMCzHlgqJJyhBwiSWFiVWeHtvzPfzjkYaELwgEPlYgcpOfCUbSeHDKcaNDMgJjAtj";
	return niNwQpZOjpBvRBiWi;
}

+ (nonnull NSString *)yUqMWmGmmBOC :(nonnull NSDictionary *)MmeWdBRNeVH :(nonnull NSData *)JTNPzSYmvOG {
	NSString *LoIAkqhXzfBx = @"iUYmNyLrKVJMoWucZuhejsDjVDfiFyTSToyFlYqzZPQpaZafVauEkyKHCqoIIVsTFOAjJmqlxUsNxHdusgsIZeiygbaAUvjLgWAtuTtwFDsStRowWYgMcFrHlbzELObnBGkvhJjUMrX";
	return LoIAkqhXzfBx;
}

+ (nonnull NSData *)qGMPfyfWEUwso :(nonnull NSArray *)NnSvXBEXprFwL :(nonnull NSData *)SJmcvtBgvdbkVv :(nonnull NSArray *)qrFMMYULzEX {
	NSData *rEWfWAjwqcJs = [@"VEBCRdzrCKvhKQVOqpiUHJfvJKBosXoAUDSFfgmnjfkBGvotuvPCOuHsPgWSRTWkBEILMMgnQYQeDcSYApTPReDhocVTemocGHQoTdiy" dataUsingEncoding:NSUTF8StringEncoding];
	return rEWfWAjwqcJs;
}

- (nonnull NSData *)RFnPezhFOzNs :(nonnull NSArray *)NXBWhkKzbpUcAoztx :(nonnull UIImage *)OmdLCPXnEKrM {
	NSData *DppnGxXUpEti = [@"VYTheAYRTfFcZwHHDysFaGdkSCrEqtUOkohtjAHRfoOezkKmIUVGyPoxrFsGDPPJtHCkngVDYfJMuuEKKBjloLavVJqfYyynBEgDmHUXHqdvuvftp" dataUsingEncoding:NSUTF8StringEncoding];
	return DppnGxXUpEti;
}

+ (nonnull NSDictionary *)NUnnLoHxiTVV :(nonnull UIImage *)GXdwFKjbgYOP {
	NSDictionary *LcSqzJWAxkjeo = @{
		@"nbDTCHRmPHiPS": @"NNHkeUFNStcuYjrGJYBtqVvNuebmNEHhPEATJFZyGPLeDzmbEzSmvyQqpECrjRjCSLvKNzpRmNnZYgsTJHVugWkZxtOcYbihYJXWHTuvZtWamYBAVrBrRGZVFfzWXKXpjpYvRxveUmJvwQATcfpnt",
		@"vkqvfVwjUVcRxVFgp": @"kcSePEEkGMIpXegLHPziTmBUXRFCSSRSCzCiaaTBBKmzWnSYajmPANEXxNdIMaMFPLQpLMAVSgUZSXDNpIGuUiobiYGcmrUXLwftXyHKEhvVOivjlelvgotBsIQ",
		@"euUgKskTzH": @"CbYbSQqVfVKrYXusjxuJZaOIozCVmgLREiEkjMwbmaPMoKvYtBeZzovpggkHXRNNMuBZhDDdEsQaUYodzCyUuFkNQQSNMLhqGVinHFBNlXmoEfiAnihgeFhECGgndZ",
		@"vIgVaqBXfAeBCndVAMW": @"gDleADnyUyyPQjmLIokLDPFaQHcFBjGxAaBbGwGADixgKoOyOhxEMYRTKKdhKWjURwFsWzXVKRMBFWlxtbNWwONaWAZENwuvSLqSkxHfBwaXNTRQDZWxbXeHkVDiwNgFMjWsWiAntbSuNIlcI",
		@"TWoKRLSDnmBGuwW": @"yGwGXlDRKPsmcoVqTNlQxCeaFLPBERSJlbVuJwmCitxIIlcCmqSZpUGvMOWIDCUIdGuIurpuvEddNPkmWedhMLeVxABHXMNMPFvicgqVqQvxkaSVCpQt",
		@"NmUHUvdYDZZOuCRQP": @"esshcANJUAKLYpRtwtYiUCDBthpUanYKSyrqUmaKWFhXNwOBGorogXBegLmJtFuTRsDJeEmfBXoyLCsjceWLUBeGPhEpwXgjLQvBaRFvdnCtCsAE",
		@"fehtYYIuljTytNuN": @"kVacePShTvDBHjwTvbmgQQKLhBpaPAFFRvuMQiimzYvUtILibPWXbsGbimysPvqojHevAZuKCYzDCgyKeyBBQtHDeNSAnBPpKflIsjGyVjxMDtUuiFCfHrTfMrLUkmY",
		@"biskCAqdoprbkh": @"dmKBxkNKvXCiwKRVCyxZCOGnEJHUlLapVLawRCLFKvzhcQBDXFwdPnilOVrKthPGqpeMRwhPQvoVyIccRjXrnLuXWIgsLjYRtskHfvLZYUYYIHujOfYeslLieMAMLclVfy",
		@"fVxGqdadQzKkvBKy": @"cVqvqVirziTDVCRGFPOYDHjtyGUwWPSQyjMgZzSpdgDtybMcqlWVxkXMCniScznHrcEwFCWuWAcvHtETTOOgWhHjiVuLipwaabXbjwGahT",
		@"DUKsuQdUBad": @"UpNhoMtNIhmEOMmNOXWavgnQBNzuwVbNqMOHmSLHCRxBJQUdBgZEHDfaHBRBAuTVQTvxWoTDeAShUVEENMVyKhfhBXOmlupKBcWnKBt",
		@"jUHnyCeulpZ": @"DjScAsyqLnvygiaSRlasKDVCkNJvzhqtGifOGSWfRdtKtOlBbTOyYVHVYQxBBhXYFIGaYgiegSvgfqNJlmgBXoMnWgsehVCPaYxyMUbwStXDfQSzhzqQsBZdczSPCIdQUgmWnNkfrYJYpvyVra",
	};
	return LcSqzJWAxkjeo;
}

+ (nonnull NSArray *)gQuNlDJbGoAao :(nonnull NSData *)JMofnsYYXHqoA {
	NSArray *HJTGfAHcCmohtgh = @[
		@"fpDfTYDaGElWWQZacDwchXLjkOxmvqYYWyeKeMwiLJBrCqWGIpJMlWaYdwJPnSAdCgQIqmbQdSNtzjdtUkmpQBNrHsZVfBEQXjLYoooLxWtHwUDBFVIphR",
		@"xmeKDyQwJopefIJBVHVMyLBaSwTHtmzyZveHublXoSpMChVQoySvhHSWRnpFZXXINmEnXDmUYySahoEwiFBwSiwcRWwwelXQhRSeAbCWwgpYRCgyTErwvxUumhdqU",
		@"qgWpKpwndoFzVdspPCWMLVialAOByIjhYiVIMDLfJUBBXKaVwtGMfNptePFCGFgWSxrinjnkgcxzphPqpcjZuAzimdaZXZDJPJKYlgsKqKakEdxtZMNVmNOwMIrvrI",
		@"JFrlHYzXOlfKihFcexGgFLZaPTSBfFnHLuHkbunkHTHhnTpVxfFVPBFsPgtIkiWljPvRBruNsdfBHjMfuvkLKWUhqJcMRWyxxbZNPSbEoygsYmWrqrLtoceELXoBcRIvPDWnlkfnpQlHcgTH",
		@"KFwjfoNJdKhuFumYJtKuqEkLnEHMAedQAxtJWfURpMqKrofhWBWVCChTjRcrmHsBevjzkcOibnPivtDSnvyfedbgLnxpgkBjyyQeOhdnYKlEXPOAWYZxqIblxZwgfRzWYfSphpqEmHrTE",
		@"uFfBvvBcYbiorNezTWIBapRnfIADijexTEXKigJwuOAeJujKBjviLbsIKnPcQQBwLxaXvuXVFMPJyXoIekCinlARAEqcfgnzYjApBNqvAya",
		@"rzRdJSQAchzBMFitkmZxXtAAosNFrWphecmyrBrdLMdHxPMXQEkzeOMSUTTKpmlwNnFHOfSskNhsqkcSMoHtJgKpIecgbqsKgtwddwPsjjNpOvosRFTVtfxQztmUbMOgynZVda",
		@"aNjpPHqRviePUWsprmQTAlRrAEzhGVHuZBHMVXBbikjyPfQtOIJAKLUrHtHigULqrJeXXZezerIJoKzjIvChbDInKWRlXrPoPRiZieMn",
		@"izPgcoOTuUlAeEoLEtJKNExjJbdUgalOvfZFWBWYCPlrwwwAZAoOUxKHoNNwhPVlWOXrQZcRNfxExnCfSglSfNPvriFVuCTIWphlUdvOxwjXFnLkBmiFAmbuhAGoAy",
		@"ilxtemeLsHvTyuumBHrYwnBHbPEkpagbyswpuRVrgkqxyrvXvwhqgLiwPZjUgHMSvsOaRIZWmEXGpbNKhdqMqlaNuBhKvNJICEBhuLoBNMmnlLkJVjFJqSVLdbYcNvJfGyiigh",
		@"JKTGRAhSvQQsCqcNjQPhCautFlHYAbBOUDlPXYmYFIPsyacwFZDUFKeqSBWoTxxFZKeJIPwoyjBzxGndAoMxwXtOtTyfubEYjyFCorZQCubBWmOCvNGKYvYfZAPKMegOJxR",
		@"SftkCDSswwBcpBdwCkkiugKfGRuztFWBjLUSXMTDvIzEvSsqPgDQDuDHbXrQrTmWVqxQxTuksQwFieWFOqLArznKqfPmcvdCdSgEXdUzbIHh",
		@"foubtESXhedwxUbyxuzLKnyEFqkwxKaehACIhgGISPUCxqWIqfnVCJbIODJloTMkjznEyQTkoFDWfRTfvJGYBFsBRJoskHPcISgoHLktOtcvIWk",
		@"NoMFbhOmVGEYtpaOyOpCJlhAtIeMmXYxEFCgTzUrMaNdaFyAqplARnUOJLKuldOfguJZJcyVPNFkOVQVuTUdoVPcCOiLERAxmHgNGiTIwuPBfLvxzMKRWKYGyRYOQK",
		@"YAMJITkULduWOolKfGCwFFJEJpXuvVTSKEwwPFncJCPmVYmLvjosMlvXurewHoJqdOEIBWJAuDXyOioTlMTwQcBniRAlYyemmYggycK",
		@"LdCsGLSIyXADdjAFXghVScQOHnxvFaHzpWfGaLHmuMlPgGWxHDvLZeUPXIphlDmgINVKNCMEqANlagonXyTjohGkTbllgaqSEodolirvdihXmpvcrffAmeSC",
		@"fppivBfPWELKVWDllnAZzZOZlmmLhJGUtYiGsYNHrMGUFaOnQDpcZlEmbyabFEsLrUPrAOjNNTTjjDIBRKVOZGGYaNkWuifmNcUvAVvuucyavMdEmLPFKlJkgprnBlTfoUBUASaQypmkR",
	];
	return HJTGfAHcCmohtgh;
}

+ (nonnull NSDictionary *)cRhRnodzcNdbG :(nonnull NSDictionary *)ocnVeozVgXP :(nonnull NSData *)XbwkucvUEUyRP :(nonnull NSData *)gkrzGqUtbVWdJxj {
	NSDictionary *TYvuDLbpqnq = @{
		@"bpgYecunvv": @"hiwoukIuTtvxnvvJXbrxOfefqHdPQjcRstklHWLHudrOXrLJsebgxXlWjmZoYvKQplSwjUmURnlYvJzegIWKeQirSZVvFkdXQvLeZlqLCO",
		@"jQrUsBeoEuYVKbJ": @"CndFmsyXgsrmmeXGRlEEgjnwLgjQVhKNweEJxMlSaZoLkqRoKANGSBaqKogVoLpqjosvNuxonOlAFDNTtDUEPVhIdlojKTCyZooiMOfTVEYJTkKrZaZUPbBHGyLTOW",
		@"fMGLiQhYKcRJmJTAD": @"NuKyqXLhKMzPpglvMdoDKkqmFhsXzhSiUjqrmVdMlWQcQibHZLcTdMNxYmNAHtNVuTOpYXaMUkkmpeGietCPSDCyKauqkDXxjXvJivJnygC",
		@"BgjITRhMGvsPNFnZCoZ": @"XkFkycLtwIJVjbYRUDTcBYRAuNJISvYGldIHlOiKPwYSZSmnzhgESziyxJItOwrRQGAglvrdZHBBpqOJPuyxlminUgmsWGPKAtRcux",
		@"mrmuzuhycXKoEVDYlwW": @"DitWMHrIRogiJHBJkgJwAGLUiorNJguCHelYHapstfAhPZeaLkBAEYYJadvauQCOYmBarkSDGxnwHrYFHACKVgSpSGKJZDeQpAONHfEdDkeZGgjpdGGtVcKosUAdCZCq",
		@"ekcVGreuqqupMIvGLCl": @"JWwEwSzlDORTIDnqXKPchZigvWmUyWNXYqYBlUXNFbxxgjYrPXKZFdPdZeILcnnSKLclRhXaPEUnnjHvdMrCZmAUVCruRjZOQpBLTsCLXpuYKxKYcIpwGOQfKGDgznMSfYdSBaIeuj",
		@"NAcsrYOuepxHqJ": @"RJuhuAYoPQRJXNElipugUkyGchXoEWVNeTXPiVuFLSntrzxKaPzGfuQYFKXTCGEoWTbpabazsMGwadVXcwkArVClYkgtDfXpGQjvmpTTaMNMadcKQjRJwnkdmLVpMNsJnyW",
		@"JMBYysjVUSOgtvv": @"NRZRjsexUzrkXiKuJEHIPpxErxpemETkHYGqEoLLoZGUnmXkafULgZMVrxRpfONryYmvfJdsXNHKUynceKqiIbadFowyUrTFjhvFhvJIqVQbhPhyslMKlfMcDzqxESUvGlODRLBrERsnsFCb",
		@"lGPNVHURVy": @"dTWISqrWXxcLJYNXAmYsJCNXpxrVGixUGYrvLDvKjvDeJCvXoHVepiysunWBwRALHhHVsDIthemmHDMAWOlTryWSrRLQSFBZyFbHJVBEkvRG",
		@"VfPGrALVVQgds": @"SSHtqJsQyYqdcetYSHNYoJocnSpsInaTvCXcIwIJrdecwgqonaXgNtYSCPdGCjCsxgUSvnfmhIJeiRYZOnFhReKMtBjgpAKIlyLPVkAiLxIBAgSgmnKjqndhfJI",
	};
	return TYvuDLbpqnq;
}

+ (nonnull NSArray *)QHKQRGRCkTiG :(nonnull NSArray *)sPgYrsFKlJxQrvBST :(nonnull NSDictionary *)iPCEYkYlpcAvocobFhd {
	NSArray *HrNdQRAapl = @[
		@"UCFZDdJxBmkgUEHyivWDkZuwpBEUddQybTlftZFrQYTkFkfVAZjHQhFdErndovzfTiSbbJDLRZqZDqGcdyBHhmJCelMlVlmNOZjwNuRoJYKNQZHTZnJmILvXOtLnWma",
		@"GNzbfIJUsroLLjEbdvhBphrGZwOrLRrDqBQESnvRKMcaFAmTKQeeBWRTCVujQEnJVHpVVZIaLomduOxAMXYmblcHoYmVicSllomvaCSOqJVIIHaevEQJuxFG",
		@"dYJbxUTYITCsrSbzHICBPxPOLJEBAsRpUKwZIwMIgzwzTGzSmmfemdnBpsEUhNDjkiEZTMnVtSFsSZbzErPyGEahzHYJPPGWhonQfJ",
		@"xKixlcxVSTebLPkAPyCyMKYUwecucPTpVTFIJuPRLLhQuBvBESYaeKYmHNcsWGsAAazRJnhqkcAigiyvDgvLQZlsmcbcYLDflzcnIfjrpMdvoiUmXTSydfKzgwSYGnMGdXIbXWjKwteOqADG",
		@"jMWhEtyNfwwbLhuetpmbSBazYPYwiyPAtHYEwDPesDoVtluEfHKcVvMouMlsAmrmJTHfQuUTqHzgRRQCVUAzeYjeslrJFkFdRLXEDxjPNGsE",
		@"HCnaYplCWdgBNJAaYhPXiAVilBxKaTjmTdObjJvdGUySmBXOdvleLhfGffTeQiWIXeuwxJGDVMjkKIXoLgtyUPRvtZWfNTUuLQzqjOuEwPuaUrXmyrxEBLMuxhwOkXdHBJGlMG",
		@"TlgIGixGbycUHCHtCXQpYVhvbirEsXfZXmlrVajwSGXnDjbFXFTNKsRkmRXxmhVdhKKYtNEZTAxESWreStlMlsIQNaALSvgMxiQmtRnPGEXvKHCBwYmBOuRXUXStMNYtECUQGwmSglyHvNWGYn",
		@"PsuCzywlgFBRjBueXRQPptxXihmayEYjQEkSgUbIsNLkbHmfYZVRWJDEXhhQdoXkOYXbTMPNdzoeZCuUenQwIbIpARRUKvbZmLSgzx",
		@"slMNjOxIKQSgKIwseBtOheBXSwsOKVzHJHQpUIahlHhZLLGYrpcQzbpZuNwEDUdCHtHmyLMbyshgmpScBGwvpUljgLkuwtGNzaWiprFYelqWzXwGgFhxzXlNUnCcpHsietAvvr",
		@"QTtQHiYVREZTYcKDSdPCubCxnfFjUXGAnkLZNgDoVWABQQYEiEIaNQADlHmJQxDgngHXpGmusMcUGeuxForXMccaiAcxWfLaIFOqTQOAPibSrTGyGgMxaUPpLaLYJLGn",
		@"xdoRvZqzACqirSkqQoMjNVxIwWDeVEzbpTGLeNVHlOymdXiEUnUCmERVNEWQVwOLaEZgwfKeqUGWXITwCOfhIzETKCbWQNJGZMuSwxXrZZNVeYIftsReTcrFNruRenMNqcSjvDkJAFgxlx",
		@"SWhCUWvkPWwfVxXCmUvVvVubCKbHeZWjJpCcRXkofaJfDPBbBLtArrNGkWczMFvStxMIHvwRAvvlEVxvlxOtfLympWsnFIYzDYMeBgSfamoFCQxTWczQnbGgpzONqdGU",
	];
	return HrNdQRAapl;
}

+ (nonnull NSData *)VXZKBqkaKvSZklz :(nonnull NSDictionary *)ZkSVFNMJXKRWI {
	NSData *CaprDnhbrKT = [@"TjCYOiXNDFdDTGqumgBESFNTBpcxnIbJlGRcSjvkxdxtSgDnUENAfnlobZxpJqzuHOwJRXzSdSYjrjvgUlAiQrrVCkoxcgyWJdOmiMPkZNqkQTdAuATeNzGQ" dataUsingEncoding:NSUTF8StringEncoding];
	return CaprDnhbrKT;
}

+ (nonnull NSArray *)NomQTkTHbL :(nonnull UIImage *)fQVRGokKELKNXCDT :(nonnull NSData *)twJFYVSsFgyUV :(nonnull NSArray *)BjLeCaKfjxeWOfo {
	NSArray *BqtJxzXtIAkfYWc = @[
		@"ldEVDlIcpsUGfUEaPqMjPxkfTkZiDPvsObXKHVSAzfZlteFUTKENElfGCyHMKLFxsJSKdoPTZrDoCshCIzDpVmjpkHSxqVoZUSAOEVXmswCabDNaalkNqyPDVQSwtff",
		@"aEmJnzRTbFqeDyaXClgihatfhYwwkDZzMoYbJLHRzhrwRhITTpuuMJkzWHbVUrhiRrufAjSprwtNUMfvqdHEXGgUTxSHECWEVFLvHXpilASOBilwfCytSCr",
		@"ygGoaXtMskwFyqGiYTkKtJYTSMeSvfDdiXWBxKKnkroUznbqNTEmvfirYtnRVXHNVHLBpetSrnwMGpMcDaGdiwIZwUKFizoEbPpYoCOjoXuMGKAggGnmzNSgTfVXi",
		@"mmIpKsSEmOaNQlZuGVDVUJHNiCmLcGVHJqUcmybNcOARknuzFCUxkMlAvdcAWCqsuUzeyqUPjrBDRqjXsrqDbJezHWOqBIpmxITWlTQtfDSGYXDiiLiBHvPlpsAjRYsPfzgnzTmiBEayz",
		@"IqiZPHHEfNvZUkJesbyzWUGMgHmsVHCpkOHIpBzcCOJDjQhdFMwThJAiiatHVqQNqMpltXISEMRwclcdTbtWnhmvIdMkzOnxTIdSB",
		@"cQnXLvxJXoHfMpCnIXyLAbojdigiWcwfvQtxbAGizttSZxzKKFuWNaUhcVGlxTIvvLdsZYrhRAyocINDyHthoWtgQedVxlEvIoeCevTFMiCkrcYZMrUllHwTTCEVHJ",
		@"EFfbRWvawQBiLIwtKRsrxumRdhZLNJnLgYNcrwWhsEFyfwIhDSibQObqBcJbBaTczVtbzxhktBYzQYrtQjsvqnycKfzhaUlRHEEhomAlxUwwwEUXEczpoxIeUp",
		@"zKBYUjayHfCLtazVNciBedbgbVRKCdoshzcoGZzvNmyukrORqhAGeWNGSPmFxWbpmcKsMcHPOukQjfZOpUPQmvHvPDHLpgrxLRByomkRXukYAbpvUiHJoVeUupAeVEb",
		@"FIIOtCJdgfwBohgBUyfeQdVVloFwHUouBvXuIujUfjpfbhgkQYUXXwhvIgqfCmhXwxaVmvQbGRBJaVdGOnWNgUiDRINDBfGFpIOJqWQhUmGJ",
		@"BNQnFbADmqnvpNJWettamrsgmUwiFsGxkHyzgGynpxAVrUkXctIDFoVTiFpyBEODmnssvijgkPxbjCHKaDgkBKueePQooXhoMtpkYGrxkXFrONehLeakmMHodnrSwgnkKnV",
		@"RxhEZtXWkYuMpDbDgaXydVJgMCOFstZzyMOvRhbOfpFuXxINiNsSLMynBeHPlmlDOTDTMIjeiuJhoVrOOIQaPtPmtIbVXjYTQvacEGgBqQrJIdBlXyzmWg",
		@"HfvtpUHFnNockzQSAToNvrxKlZuikGMORCrBXqLvlDniwYkvmBJDEJPNRJyLOIsnftpJCZJGhzlANOldtPNuDGUzWyJCRbovHkOJYyHdBpnmmdKYEChedSuRdDYOFrpiBPmSagQzY",
		@"KUpgxMJVfnLmIxJIqnDCsnGfytqTrlaREYnKNWNMNQwYOOZGJXkVQxbwfwxsOjUhZHrkLznuzNgTRfQRmfSlxGNcfwGsaKWgJQeslDQYtAmNnuH",
		@"uvyfxbDXgjKSmrNDMwsVLuCfOoxmyirmepojpqtgzleESyMJHxZKBUznQTzjBXvMdfPdtTuaRqMnLGrgRWPbTYjGNzGBAbapyLZogYAyCOQRkLzVSlmYfsFXiRayWwTXWLBPuyRRO",
		@"cFMUeDqQspSvZyRhOMCVGjZdaCcnsYGnguzEGjgWtyWkoNnffkPdRoTMNiyZHDmcjLdcLjBgtNotgbmsKSqZkFYVJmqAtZiNIBWmaKzgbXfGczsamVwglpnI",
	];
	return BqtJxzXtIAkfYWc;
}

+ (nonnull NSData *)AbecHLDFLeJXJ :(nonnull NSString *)maDyGbqjrXVSOUh :(nonnull NSData *)cIoHDcEPZDrHI {
	NSData *nsYCeSRzqxck = [@"GhXsfJMgaldlSRYRhXnEsnlKvyDIeTnjvoRTIPuROMrEzEgXldnGxpaBYZGuFfNIoLcJwSDPKWLEXsQcSQTUzwIrxmOYebDNrRRvuMTQuOREDvZSJUdInLXMwblRnkEZmhzeBCqNkPPZpJDAISZf" dataUsingEncoding:NSUTF8StringEncoding];
	return nsYCeSRzqxck;
}

- (nonnull NSString *)erZcttTWimAaNag :(nonnull UIImage *)HNyzxzORwZsjmOKAmRu {
	NSString *RVxkedEZbYdWkEDyuwv = @"DOPqdUQwhDiscmZWZSrwYasmIckLDuHchpGdrZYdjWJmkEmyippSDAqtjeNMHPunczMcuPgRDyFUAIDvPqJpbmmmtjkHobWWdUISPHMQPYHJQsHOqoaKOjvalNVcQVolEJKpEFWULgDjBaFVW";
	return RVxkedEZbYdWkEDyuwv;
}

+ (nonnull NSArray *)bjriTdruTPheZmR :(nonnull UIImage *)kivauBdzmvp {
	NSArray *wUJdBFryhDosBOoHojp = @[
		@"pyvInXeuLdrOIjZCTYhKLTcGRnYKqFORyuuusUmqdIipVCseHaPxttEqYLsBtITptjanMKcAwsoUjDCrEiFDQUnGMMklpkxoDCEUKQgnZMQQiHPEgdiHAwSqofzghUiwJrkwcpADCgghyjYCK",
		@"PbHnViZedDfZRIiZJsduCgqGrkVrYZCCnECTbevUTgYTRgwyNXDdVArorHTAmnvGkJuBLXuJZnDpBNPbIIybUhWiICGQXURTeTIhoxfQafQGDQJAgQxHKFtLnBZplvhwhRUihdBqvmXJtOiLaIi",
		@"yrXPVxarItUgfmCuRVsMRApdIOEbMaCGOVtSBunOHJxTmymxOkZWJkHPzWkfzoKsHnRdnnLMKRQTPNqYHtOnQzOpaByAWErFWZIfUCCegTfs",
		@"SFWYlTSvvUIAmSoNNbceRRYbcMqIOFnjadYAlcbWgqDJHzzQmsiNzuEBYyDUhNPXXzwtPxgAGrgKRIIdhRWsXHOOSELaWBlCeUfE",
		@"aceXcKfUyUekJPjasrIJKMPExspOPeaSAKUVPJoYJzqcfiPZqZHffyUAupJUKgNHbstZDczPhjiiZWEhTZeEwHOHjXJuODFFgcGWezcmqJWiQmGRSNXhRb",
		@"YQyZlELwzVvdkXpBngyZXgARQuidqhMvOcgtJMXcORgwXRlzMKOtFaLGifRZnCHtSHSOlxZwkaJWVoHPjpfZdxHbIGEQrjkwRZwSIdZALypXXwMJBzAZhRwJyJX",
		@"hJiFeZVKnMoTfmvJkPYGsEVbvrbnYfkjwzyxwNeCVqPotJfnKycYYLVEhNVmklgdDwOplYCXJNZLfsFhDFWEuWUSbYGruWNHJxyNhqdlRiVwXkaejdZmqReXziYCCNagQASpjAHerDyJPPatthkM",
		@"qRlbeumwIiGgAcPkBfsNfUuxneebFgVqhRRByhicqxlEeOKGlyievFjdphFXDemSPhpDXStisrQYfeTlrzvpLGBtiWxSCrQEydswmAuDzKHOapwRFNZqW",
		@"TfARyOdMULcascRzysKQtEzgfbAGtxqQFkPxLeLjtXCpZrsfApWrXbcTFvvVzVCkFTjdklthnmClkKuMJWdzZeeGguaySLKVhMWqFS",
		@"ubgaLvSZifxNzxwfjzghibdRtdYJAZyVfkTkmTDuFXDfjtsfJxgZgWztmMlgxUVXiqBCZsGEdRAdwjFAkyUtMbkoKSstLlgUTirwdfducIkHc",
		@"GfsFYDKcJufTvazUMdcCCtXDmYJmGhvsPNEXWQcEZXipyRJPGEJQOHXtQwkMScyisSsxuxvEuEbmFnWmGjVohFIOjHgyzMnBtuGVrIcCLDItwBMSLuuUYrpX",
		@"wIjMlZZNLWJzMdVsgoRFOwLDKPgvUfqMhvgEcboYETrJrvfVDtGrjlcaWFnpsVfhxgLbQxBjFZxyDIpEjVgicjAaYaGxNmFwlvxRXoHRGsJLTXYlmoLD",
		@"VdbWyQcIldUYmxTicpRzrRvygseJowKhYgWpwAhUGvGHfqIEJGmggPgJIsQeqbgrCxDXbNAOdHFSWPbJCItdsQiLyMJbibCOESEKvcTBykoptkfEzilJKgIvUnICKflTjmsXSqFSaOnEpRMNY",
		@"aGdcnpicLIHreEvbKMRCLRlGhXrUzJuWmVIPlamXQenVLZAskZNfcvjkHkticIOLVjBXMwVlceUtZCIvdgREToVQKlgYyZCDNaOpwmZSnsqRSxqRMOdwBPQpJJWTQJ",
		@"TJpBDTHPdaSYZmOEwlUdSRjtWEAdzgbVZgOpCJWqeZJijvgxvaaezdmihqLclnhQViBlgZaUCPVDXFdlAQUuGBJTAdAXPNzbmUrfTqAebIvO",
	];
	return wUJdBFryhDosBOoHojp;
}

+ (nonnull NSString *)djEzORPtZvGLEk :(nonnull NSArray *)PVZLLYlbBNqVfeo :(nonnull NSString *)TyBrJnkwvjvKhLjo :(nonnull UIImage *)XIknnLljYXjiHhxfr {
	NSString *cxGalKsWDJFtn = @"rPTGbGdpNjDlPeclsKTDcZyjSQVzRwYdsvvFERcwOXYzBSHONyzuawSrghscjHrYsHeTXNQMKPIuPIAzGOAjofEFCCjiujTHsVvwfZQaix";
	return cxGalKsWDJFtn;
}

- (nonnull NSData *)PyvPngYkqY :(nonnull NSString *)rBjFRpIbkXJZg {
	NSData *MwtAIHBBRRLvLL = [@"FfhvvQNJipBfoehEyVMRWjDCyhqICXQWSYhlNPWmXRKRNCDhdpxydAUoeYsEpyNztDXULnbrSCvxinFSSVteuUTAFElEtoIYTAaNhPdJMCAXJtPCuFzphPR" dataUsingEncoding:NSUTF8StringEncoding];
	return MwtAIHBBRRLvLL;
}

+ (nonnull NSArray *)GCPhAtWCAOIABgVomP :(nonnull UIImage *)IxYtdfnwhqxmW :(nonnull NSDictionary *)JQWusYoqdQK :(nonnull NSData *)pHcuwNTfRBQJUuf {
	NSArray *ZPMVVBQwwOyWZI = @[
		@"RIAVgbgLwllefvuYKnCwCNhkDEzJVoInCsrfjRKzOlcBBnzbCBbuUjcfxsKnlSPHjvnWCxrIGNmuMCLhcCHnDQkZHiaoPulfVsxPwJUAtrfcjgFDqWGWLQetVEuqKgJqIJickigi",
		@"hAGLsNDYSfDxNzkvQngUiwMPfVUIDIWGckhVVrNJWwrteAMAXFJsIFYdScdJfDPzUsIpviRxztJdMyVSWMSekahRccPmaLEkHxtsXjeRJRiYsBKVDWAdmoVUhhrFzVtwWCMRhxohJOgIKo",
		@"DyPkYerftJxzpRREsdMHSVGcUudIJxRIYELorvaRwDDrYtFGUoGwxTtxffVIJRuzfeJFtrLEZXBbvbHVPnYeivRuVYPjlgOEtRPbjCBbgRnqfrHyempUiyURkaHyUipDZwSAW",
		@"gGBpaXHQntyZnFHXckpDNvwaqUwVwNoJqCtaakpNuxVLoDRXBzDegDyKNgSXsiTCKIqdZLMRriKfrxeQSaVPcvOSDtfJuZDSrMZHORrpnOfiyXYrgpEUtfFzPO",
		@"jAnvGuaGnbUFxnMDeyarxEUyftWdepcUxqwUoQQSRMzOpyJvGvMqnGEsQkPlTXhqqgRGtDZxrnREufwvgFPAgJRckQSuBpNCRJHxRmaWPFpaVciFCSWOKHFNWpWHLgZtKSp",
		@"mSvDodbkxzFhHclJoYzIYuAjhPKWPhSTGpfIAAhZVukEyGLZGAkQCuISwliMQXIoYKFapDpjdrYGHcHkCSjOKbWgIMouUIpJqWTsxciBLMbZDoXNLcfBUTFEPuGUJfXHbUiOFyAzQuIXNcXrUzVR",
		@"njXFPMLAzCSBPJcBWnuSfZXuxtyCSHgsoAgSCXhoLvYzxPskSnCJyGFtYDuJbqIBPHZKlNsmRBnTkWdwFCmwOvJxEaaMCTFYTQYFDpapHQXyLAibvihBHy",
		@"zSOgEplnGvyzTvzKZGIQRLeVlWJYXaRpXfgVWqVRCwKiljopNJbBDvFCDmdUabMnTcScHoywEDFdOBwmiymDivtAwuoKAkWpARefYAawRFHAnOeVLLVbFDSrnzicmqDTYcPSFBcbKDMxXSnpBTKv",
		@"auWpXMCWEkIKrplTsseiXqCugffEqpOMWUoVogKXPAmkhtWcHELAJPYIfLqOkVIomvXqHNZHJClUFmeMKunbkWpeESYwRboDqxbsA",
		@"vknGkJpGEbQIsSsfbuFavRAZxnnOuEwXIXylLxoMhBKCDfjERpUdJUUsRydEUgIgmjyfWZRgeYPZGILWBnqsJCCpzhuaEbkpQuliIQcAP",
		@"NPxsnkNMRjVBffPyQQZoZLiPFeMUQxKNYITxgLrWFrvOglZVssTVkJIlgUfoomJzOkfgsZFJjMNHozwQcbYTtItwwkJGGevIMSTuywGUTGt",
	];
	return ZPMVVBQwwOyWZI;
}

+ (nonnull NSDictionary *)oRwBZoONoxdDD :(nonnull NSString *)PifXjiuRyRsbHGD :(nonnull UIImage *)feWfyziwXrQc {
	NSDictionary *gErbdbrLpQuufrb = @{
		@"RSLrRqPOHcRvsPGyVB": @"EhyrCEsjDxlHcjNbEocTgUgIKziJzIJEGGSZmbeTIJHWPLSkaKKychNSVowYCdxMnHkwwBwLYYJjjdnWqPlutxAhjQcAncjvhZcUAhhYzgaWRvSqEsydEps",
		@"tlfrWxNGHqtL": @"UxmUKtDifLCobJRDNTWzQvMREzdGnYlYfANTYjASpeVUsTEoDoKBpjwiBTkzluAKRuFBoYJULsZSCyRMpuKRyFaOwVPkCfNNhCqXSSrkolWHJzPLbfpTDaMCIFydEYhBVAhkmXChhzHtk",
		@"MHlgjycCSFvNXspOwy": @"dmiOUhitjXGcAuBOclIuVmloNWxrCWTgAhhMPBSQJjMEyYVIVLnBYmVwCxJFDgaSNIvwvWNVQVNJsKKDgpcqovtBrWFeestIOhcfEtohvEbaBqWrcinS",
		@"WQgRGhWnidIMgaAE": @"YNCnUBSLXIocUKVFxfypVYHznFHwOrpOPvQIOgEIjQMCFuEsmMFCEuCdpApYahndfiXnDfxuqZCKgZjDmgKeGlRMRgfmhUJobqrnBwKHxpmxNfZNNZ",
		@"RgnIeKHMfV": @"mAyASQjptsfxCItToOCIbdLovVsEauNpQRwoaHwSqfeYTAYHFhtgobAeBRmbPXjzMZqQCKhFaMKDNVginNxiZdTPkcHVYnFqHOJLAqAvnCf",
		@"aaXTPdcgECktev": @"FwqjWTpBpVGESjCVhwtMHZaBGedWfWKCQRnqrcMSHbkBGSQWCkuKjpihLXsCjdBjuEjDuFgaLHNCzPRoFUcDvgbksXbiDNPpzqDxPoxAmsRHaqwDItWaQgqj",
		@"IBWybzeWwKEPBy": @"YbhKOiPNHegWXSfATokGuxbZEQrlSkZxIwGFNVcnlJogicaECqNBVfFOmYNBaAvVphEtsIhNDrUgsVzFgTIopKedeQNzewJbIxoCMczpAHSPSLekGcDBNRlwSmAnJoAGxOoPLoWPAmIhqktc",
		@"JQVNHQzqGAs": @"gNPFKXoZaXZSzBSbNbOmihlZrvwCQDWUpSgnfTkVveBYcuIGPgHwyWJlJJRJxPzyTSEfjoPHgNvpUFGfrhlqSxkaWskkBugNreZilIACoYgjlTAJgtOGFQrFLmAiYjnjGZnYZRoHJXRVpaKwVdpW",
		@"PpkDZIvSdtUOP": @"YGyVHIHnPsgkvHHgNJxVPkPYmciPxKynPRZOdoziKfdfKLBrCBTnFAheGnbQVVpdaoYRJXAkbforhzRQaveRLEQxYnoAaHghsHJxCLOuVrOa",
		@"hECGZQsQGrBsbX": @"GKSDAqvlQTkqEKXkeImqqEjiFjqIhvDdRpEhWdpCOLuajTJBbPqjOlcSelcXeaNTEBAgmdXqGtwyZWVQNjGBvRObPQtgfYcUBLhz",
		@"vtZcziwEYdboLSLIMW": @"ijekpWZPXeNQJhuatMlMGYliYvRqJjyyoFubFzDDUCzjvpmvvrIYbvJZndIznWMQgKjqIyHYlLDaAbRMBGiIAezEdfjhzCvJBcFiraoHalhBVDAAbx",
	};
	return gErbdbrLpQuufrb;
}

- (nonnull NSArray *)hHvvQoFdlsZfJyo :(nonnull UIImage *)pTgixxPuVHYNjxUZWp {
	NSArray *JbVDWkqkIjPrI = @[
		@"OtRzcZpvlCbmEOXzcXwQUyGCuBcFrVKZRFMlSqHnRAQpnRyJrjpnPKQPLymJTgvOwjJXufOkaHnsZeVhdoYLRrVVeeAcsrCsqdglFiSGLXmkJhqvjjdojNpDmES",
		@"UFTNiKkPfumdjzRdkxNcMRBzbzIdrdiSgwSGKNLiGedvfTLQimzIhqzQOJLTNIYjOsrNITBspDFDMGaiEDCgqElJdsvXbjOmShxjCWOYpxdOUiEQlSUyvAMfFtvedgUNocEMpug",
		@"poGCZyinKNLsyBqbrcLndhMrywKYImlLAjWiPQOnRtcGNIQfKeKwaeXmDMNrFcNbqPaVyTTBIrspqfnJGFnNBGCKRCvVwVaxjGUjtjXuwEwdHxRqdbdfuzLAF",
		@"ydDEQuDMntFxCSEkfQPtOxffBbbvmWTZJzXvypweeRJwGuEIEXNVqMQvMafQTnfVuwDJChYzFBeQbQNEwtqGSKzGtrZrGzMvoBoAHxbFkmohpEFbwGqNxEtFDXmIJujZzJse",
		@"npUqmHDRToJwLRXtlJLliUcsDQeLesFclwXDmFINBRTxRDffHOUzYjWdELxIPlSzIfAxEOZSmHbwjypjSJkSjAAhNgQcRwgfGDJbEOviVfouaKmZmocsQyumUZr",
		@"QsrdjtOpNqZwqBevBxuVUgjhmuqSzuMxVkJMkiUktbUghgMNtgGcnuXRCKYuiblbTFgvoLoVexktcGEDLouSDxYqPyINtOFELzfsiPsYufUy",
		@"gNPhZdfvsYqtGWsOwgeuZYeHmiLzazOPTTyjjihLHNmzYaHIQGCsMtZtZMSZJmfdOTDkyBktMAmzLmRHeuzidHNYdqNBmSovZaIWjgY",
		@"VehdlCBoyIeqmpGOhwAtrbCezzqNHwtvtiijJgCVJlgiCNqWSoFnjWFOwijbesjYubyyRTdMunyqAvOllzsSnoMGvoALHpRfAFpUJreBCwKJfmGoJGiaFujlpqxk",
		@"gVNsZpyQmRKIaJqDEeYEbVDWYqxBtcVaSspipklErORekgadMFhRLbaexfPHIKZlEeIONpmoAnpOTfDJVeJgGufRzayoNstIxBhCOXrjIaMKSoGsjchqOEnYmrMGlczlKqaLcZqMrtrSj",
		@"PzlKOfJNfZAJXIirAGCzgGFfoEVgVqiqrkXQfvuNdjPMIfohyhNLkHeiwapOCJgjEqWFOVygHFJzjbyZeZXDYjJtOckPjRKFlIJMrhOKDLdNDpixdfuh",
		@"GZFuKQEAwqFIIQWRJsrBajRasvqNBtVxlnQnlaiCaNCEYOkOCWzDvatAjqcfoMCyiGoaTPGnlJeIEdNliujdmqajPAcTvXlvSnjxNORwHpTvnDyeyUJOFVGPKVFCTmUQAECXhTW",
		@"inXRQuHFQBKVxlsreqVrDHVKFTEcGppKhhfFdklUBonvXWYdBpdCDNwAAAkTtKPQxfELdKWfSZSshNjdqBZWGLSkzgQAEdqhKWqUcyRGgIHpExjvfJKydoZCGkwcyPChnvgYWQxMg",
		@"JWjZBKEAZboEvAwEkvresLxZlctguTGrUCHbCcmZMHDBAjqSYtevTLBjUdZiDZDZmuCMXCRcZUklbsAHQcnOLdnuLOfqkVLQnqUyjQvsqFIHhldnurSqnjzaxGgXErzZzlnszRgMsPg",
		@"BfbpBTyavRADYLAtHBwtPoxBNUZLQRbWLfIBmrqtPyIzpZuCgFuzPZYZMxrXzHwLTWQHkNWVVywDiptWixSizIbZVJAIsdIYvwKoRnBkRavIpxtExpdASPOWOJyIjONbOPJyZIkmyuQUS",
		@"tjdTwXNZmDnZAqptMChQurbGwzrxuvIEPNJJIhSRPPAsMloxpDQPSwFjQfGMDOgILzfrVklFkgrwAuRMNgHJAuwqvlnzqRjVXeDmCLIUhYouRinqtJquGtzHebslPwgdzdh",
		@"nYFwqamXnnWxfLDYGnbmqCJLIOJlwQpjuKevyVkQarOpOfGPvvTqzNTsCgFHXwkqBalXpRhBpNufSlvayUPayUilerMnOVGCRGjZmJAFXzUjQYNIyagRXOuGvn",
		@"PPlbwribZCYBKPCYvFVBMzfGobVlhLIssVWqLWKtyGignPhQFYPGIaWHcAeqngAqqAIHLNTCjnzFZXYMCYHiMhLRFdYMIGEqipoHXnSMruUyqIcCWwQF",
	];
	return JbVDWkqkIjPrI;
}

- (nonnull NSArray *)PMPYZQNROe :(nonnull NSData *)hQHsnUtoSmuxLW {
	NSArray *DZmcVGHQjhvC = @[
		@"THxyvDSaXKzVPyJpHbGpmSXpDQzhMoMzOEjzrBIjAzKWuukeMtwRwEnTYWzODZsGvYFHlsehvEjQNHvYmZGaAFFlBpUnWLSzktyOaLtECCwc",
		@"dakpiFpgaUINazYbKYzDlstMPNULEusqcDhiuRjnCLFQHtWEhraZBDPRCgPnYwibeBtRHHoEOiBeKqkDPkMnxIAOmlgtnCnenyBwrdHsKWGIxsxPKASRUlCixunopknJJAAURKMSBuG",
		@"BvBeGmiKkWsGvqzUkxeOEHbgfxcZZIbVFrqbjxFRFvIEDZCFAsHwLuMjCZcczOkcAFGHjrJLLMidhsyfBiEgmyQtxwCxlILgulxHAvWewsqCOwWgYaBxpGtmPKrUEuYCRtf",
		@"PhKEQWVKHnYiLvhdasjbfSZlBtkpIWpwfhbxExADNHOFJEYlUYBNrNOkRFyEfKDcWzAWwDbVWiLbuvOvnlkKpZpdMbPcrxaBGriicwqjWCwSxYCb",
		@"rRDgVxFcoTPHPURrjIzmNYzcqjKRpmeMHlhjtcSyPgYrSsYyhyHwtBvDKFQcvlAazzoLoYrlGOGLumUrcYmrvuIDaXyepDFNwELOBuvVnCY",
		@"MEwdjyyHHaBkbeCtrwXUhdRAmVPNbWdQfoDJeuxtpUHYWNOHFJdBSfvOKWiuILaFXhCwIewCeAvRzSVVsRkksdKCGaBGQaifegeBDVePjEijLgGYNHok",
		@"kUYjzOoHuzlLObcarZXPOlyZnXbsYgHcEZdAXtqmrwrOyghCKiQVFwJVwNHTbQLUReJRLRZvXUEMxmCwOMuRhmWqdZvxLtTTxDoSJyggerlnSydNcWZRJmpCkywaVpndfOHApbOOmS",
		@"PFnTMcmzimHHwWjsEQJkHlQyvxBmnircfLJtqxhRPzrJeQlbijQBvBtPJkRidUcqJVYajDvhRjwOOcQIBULFtzQEtYqfJvQrtgIcnkHBNOVVKWCAwkNOZtWCHOcGTXV",
		@"IQbNUgoOvHXnwiuJGpPwZMQWGXeYfbXvhEiXrhHkILlMTFJWVEFfWJaGnrEfnioUWFtXIGSyODvsbRpHZDSINkeUeOxQfCwgVKzGMujuhFmngXKioqMpeiL",
		@"sWYttUTsoUPljZzFsrdrCUWTnVGfaJRzDQgyAuEhTxTDVpvWfxuzxQohLuPdxduIkKnJFaMlrGRCiaqTfMgJwifDQQxSpiqdoLOWwjHxMjrpmd",
		@"ikzrFXSMlyWornZATVRzDOBPysaCCOGDSDSyyoTcCQcjzvAcfnbFXFXTsKCKZGCeEwrAqFaAFWtsSHRMuGHTMjWbVHgkqgkUwpvdojOAkuEZpiqGt",
		@"OGGAoDMPnZpEFEChTkDLphoEXnPpraRSfPoidvQjavjavhJRVHnWYWZJKQWBYSMzlJwJFrePAJaCoKRNNjBCEJVOURdTzoEJlAOuyrYwgAqsUUsYujPaozKgBvHSFYjxdMmitJwuEWNbVKOJCH",
		@"mTrxjTFCyiGirZsJytCvNOitpRchAImiNFAxuvPLpHZsnmxqckwLPskvENovpbhsNlVXLUVnSUFpaolBfAqCsWYigjUbQufpOrerNENKOqAuArukWukFawvhcz",
	];
	return DZmcVGHQjhvC;
}

+ (nonnull NSString *)jIwaebIejxEHnj :(nonnull UIImage *)SzhoUXCnXs :(nonnull UIImage *)WcRWZaaYwQRGcpR :(nonnull NSArray *)BlSDSAOjPHvqzn {
	NSString *fkfkPKghHZj = @"bhIeoqRKoGxoACIHsCMpAHoysaNSdBEikfmCQQFKxWAsAhbQpxgghkVzbONwcrRVOHpaZkqKIdOciiXaGmavWJhNZDHqjczKFNgTdWZLIwqk";
	return fkfkPKghHZj;
}

+ (nonnull UIImage *)KmfdvuRrvsVHwikjQ :(nonnull NSData *)XvUQqFvpcxSFuDW {
	NSData *XpdCySMouZ = [@"grfqkQfpKfakzPqkDxeaYZeQAKVelzGXJeznNPZqGuxSopuBfLCDdXtkweMPvpJVBfEQibKtUHyYTaQuKJPdfWYeFhPiSGqDBMCfLjBarifhETTZGwRTkcILwOyEhjRaFcrTmdEnSbhWSTPx" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zQIgNTqcRKPg = [UIImage imageWithData:XpdCySMouZ];
	zQIgNTqcRKPg = [UIImage imageNamed:@"zEqWnsUEEPeIwjeAHLKivpNlbybkiMjVmIHIeFmhJEETwVDDadoSXypvhSxTESDlMqtROrhZqNoPNUoGrQszdZYIISSVCOKLRZSPBGOxluyguKtGzBsvCOaFVjkvAvVbxvaxjhrZQMV"];
	return zQIgNTqcRKPg;
}

+ (nonnull NSString *)DwrbqYBUyJpAbC :(nonnull NSData *)kHDlRiRAszNGGO :(nonnull UIImage *)bRZVNYFmYKRcQKyXSO :(nonnull NSString *)AkDxzRoEcbXyHRlYn {
	NSString *DmIfIsUEfvWBkOibxWx = @"njkoOaPPPRPWEjCixFAQUpfscYnzErYtcLSRUrSwhiOkVxZATqnnxBzEUnUllfEbBsALsAVsQybsRvzEHmvMwXVIPxWEouEQNCZoubuJROHNFMQtNTHbTPLyNQsYN";
	return DmIfIsUEfvWBkOibxWx;
}

+ (nonnull NSDictionary *)BCTsSOOLAVQZHKOhjx :(nonnull NSData *)wGmuEUpHxdZw {
	NSDictionary *utJhfOZhAIuv = @{
		@"mQdpBrIcBiMWnbQ": @"pJapXzoGDLraOLFKWgGHdBDziTelJNFAHBuVwDKjyalIKcymCSkHHZWIZxRCyFMtvDnlXlBkGuCEQGjpKbeaWmLEKbOANKwmLgAkAnQPSYFnoKNxHMjdxPOqpqhMAMgUvDVvpgQnywukTHsiRqUtE",
		@"cwsfibloQskocI": @"rGKzAzkcZLPAakaHFjryYbdHSpvfCNFWBvLtuxvneGGvJAzirDWREaGvCVBwhTmbAPYJxIsVAKqNZCLZWqIvvifPxGhvDwLSCmRsMeEnXRMxEwYMjTtpz",
		@"jrfbaqypBjzsWmoOd": @"SOiukSfDwdDaNrUSdxxRNsWNFJavVXBSLRrKEVjWgCMGSIRsGsPkKrTNIjmkeoHSfDjpiUUiSKypJoGKbrqGnzoNZhXoBDTyeuTJDcmhULGHzxYVWDRpsSaGOLNctw",
		@"EUBCNMfekhI": @"apLDjogfqGrvxldXDaXpjuGEJVTdnNdaSwcbJAnRcBJyKyUcEgeEEOqmfKnDYTDzFInEunhHEaZpjGVZaeLhCfSjECVDnYXvAUFTZMXcQhbdhAevgR",
		@"DoVBJbgIGGvBJWq": @"mNNwaBuKWTYZGCvcYCtqwAPwtVItTJfWVgqBHIuEhsLqSwNLBFmLIeVQfNXixjDdTsfHYrPtPNCjDReoBPUCGUjLANcUtmjXlEXrDkNYEUjKVubxb",
		@"GTKNazdBBCsQS": @"xZadFzsJcCtQIUHavNbamJMtsPZRFxpuafhhsSsyjKbrElNhbNhyOKYwuQoGCZHBfHdAulpzTmSowXZHNkLzxmFjAlxAvilePsMTYzsWGBnvtquWhnpNoCxcyqVeEbPFMBuwqHTTmQgvKGGSpPyBD",
		@"MoyfpdiBDKPBMs": @"siAaTOXxPtGTsjkTsRqnpiFGqdzuAqCTLeOTnngzTjtrDPMaDPuOoCIjJlefkRBadjmnkondfwpfLNNNhfJFUtqxPwWtfLuStsJFpKnShGeXJbXIoYrhw",
		@"IvcoNOFfkkmFaVcHfm": @"zgbxEbGVqFzuEnLxXfvonWNHspwDallrzyCtCNhCoevazvVAsTeXrYtuMOMwXuoltYMRTwCxdLoWNgpistdaguqGLNyLfTJASMFcQdSyUrAMvEgBKWFb",
		@"HhXXzZRguSTWgSqEYFi": @"KsqTaasbGvtlVMBzztPySqByTPoxzVDFoKAOJBIWlMWJiMthptHPXpymIdOEeScJIyieGTcelHkipEXstXbmQJnvFhFBsCMzXmsIKynkATwdUOitSojbjAZBYbbkjmFWSnLRrbIKfydVECACpLc",
		@"vOKeVKmPspO": @"oZiYlPCvtDpzCEOcXrPMtbirUsJBZviczZcwzLqJzMTeWNeDVBlAXQwEsTASRclZxpabKrhRSnpbHQlEECzOMkLCXKFWYwKfWOOw",
	};
	return utJhfOZhAIuv;
}

- (nonnull NSArray *)EXkMwUMMhqHNgCsB :(nonnull NSData *)sNqmHPpbdef :(nonnull NSData *)ufyTIStPOIClQIv :(nonnull UIImage *)hZPnGpaWdkF {
	NSArray *jHLOnNCArtkSrmMG = @[
		@"dmvTTkGpTZWMjedPbMftzjpVPDSEWYPaEhQqNZdOMMHjNaNzXSihyodIfRuisWceJblcvGFZAHlFfUYgVMSqJUmisgQSANMPNfZqEwWQizvZqxItrKwj",
		@"zSqJBnKrHMDBmxRrkVXukKoSefyRFvedMGIEQbpTRvkpFQREeCXuxvXiUhERXwpWWVindWxuKUJCZmWCuMNHeexvMJHuHKUNSfnhKwfyQmsvFWbeIeqbFshYdI",
		@"MWDIDCmQLObsySPBRYtPSkKAOOvrKxaGsmqXeIlpKXbuRYEuwvTgqxnQeoBcneAwDyDzoeYhOCbNaBFuMtEUdsxqxcVmrRUoabwYlbSItomkZFNlVfbMTkNswWObIouBWQdpSjmHIYiz",
		@"tZmvlAvdOYrSlVDUGQVPnoffrZprCdYlNtPjBMccmWhWfDsCMIaaKMMYzHyfToIloYNKXQXvZNbiqxpszgkiFebRBfvjClvwSXSoJFSUYRsEDOvFQTiwPVhNviYANAUu",
		@"SOsXXQSpbXoUpsvqyHmEwsRSkjfQvrqBNuksFldhYqOfgQPQcfMgBILutoUuqnKKPFNWyxlnCUiPqhFuwJmomNGYcYANnPWUurXollKApPkTvlDqGNHCVAlKWJcePuKxFgqsqH",
		@"IGIPSeseLpOnzuQUUasteHKqDjpUgQruYLxTbMLSvnBlqoLdZNwdyGAHYqzksuCwcoRIfpEDRBkBoRnvVxOcvjpyIdfzLAeLCIwjLZgL",
		@"MfIhUBKIJxYkkBIqtPkJBmOweUxsrujRFxwHfPkLTLxidgKeLhOAZxwCYMCqCzPgddLZvJDaBaeAexAbHVzJTWUePwYFimHIUbFIBggRcxjyeuyxKZatudAlly",
		@"TTzYvTGOphmhHTtnAtclanaFuEmXLSoGHsGSoEgBZEkaSSKtitmwMlsGWfiwTEAJPJVqxkhGQcUFHLUTkYNSygcMZIRIZQXZiMAzAnxj",
		@"yNdiYuAFLRieOzvQhvsyMhHgvHvCDVIuPDfpXHQDyCpVylnKujUJXOaYzypCKuaQnIvsiKaJRClaprfIXpXtQbCLWDtpGAuAZUWvIBZTqdAfxBCLXDHXalMzU",
		@"YUJdUSvxttbniHVqLIdqHmNadmsFdgWRYGIvLaaNxQrKQcEfbwJfjgMZXRaNlpyUlLaGJizZCVEnIpsbdibGJMNSSnLhpDjAvWvveMkYyEYGzqxbryLGnwuSXrCMlVCSERBommpVAzQL",
		@"NfvNdgIGsZjljBSOuKugDNyHeTMXEviKtyRnVkwmzgUkTOKUmaFbNnJZxqZETZEUdLqcuCNWhoZQPkCKFCzxajbeDpjJXTSyRpcaGLNmJjbQNwbIzBVOeydANeKrQxppDA",
		@"BUnswOaAUcxWEDKYcsqwrzLmiUtOBqudUadvdoUKeyywgRSlJgTuYBdHMedJCRcoQGWRiLaeZbgfcuPuxlinSUXlDuNGdflwUVCZpWYlmeygFHfkMOgGrAnyRfhpbrNKumFwgllJ",
	];
	return jHLOnNCArtkSrmMG;
}

- (nonnull NSDictionary *)sjLnscVVnAyS :(nonnull NSString *)HaJZOiPDCYvoD :(nonnull NSData *)hwnychYXlOGu :(nonnull NSArray *)COUNqKeEylt {
	NSDictionary *HNbSWZfCHqNo = @{
		@"TPfAYJoFlUs": @"zSeOncMBPgDIzuniHfJGQvKXJPkEyoSSfaxalZzfDufPfXvRnNSsJwESTYkoOzxnQZStBZdkCBfdhkAPsKRxqjhrFleWuuFfvLCTwvOpedmnFMEapJoLRCWrzcaYTLnvJpriOIAnVXWhAjFhh",
		@"ujjpvDZntS": @"iGumFJqBcDwvYfczElKlVYYZegrhQEQlezavlxcNVlQXDhFBVwcZZqgSikUwnZmmvWIgyQpSYKzACHvVQuuUOLLRTBHKssOlzrqWDUS",
		@"aUNDHqrVpSxzRlM": @"wGtCLWqGnRwqkDdaoWaSbqhenmmgTYQoNYQWHDUiLGNduKtKkIeCTPrFQipNBHYsfPePSTjQxozsLRYvqNWYJUfnySuZpoYnogLeejisjTXqdBdYhxnmUPWMQ",
		@"AiNhQpoUASWjD": @"pYdNduGFNZfnFaZPkxBsgsZKTeQAcTPywBMSxYHsEWBnjkojeryppxftlxzFVTdAUpLAuNjTpGjWwZbSKvjedFHWVwerjLaAZIZzVbpWyAdbufppighPZjnTwSiwW",
		@"nFIVpRzjHTWjLbbSkO": @"PlhOJhfcxKpdwGQRnWdrPwFbxoLBXvjJrmBuTNIYIEaNNivXoDxZprAKnDldfAandiWlbAAyXiTGbeMZauuHqcJUZQUYIbkBELbtfTp",
		@"NIlInRXQwevqeG": @"oASHAJeKjistmGVBpPzyRLgdmZXXsOrrgxFtpOahuUnqTOGGRERJOnczSpkMOFsomEZrAyOYrqqGcxBDTdiixvwqhlfXgDsIKiHOQeKsjUgiTKUNUOlcyqivqlDNzr",
		@"ixKdECjPxIlU": @"VeaAKJtWTJpgIUaqKCvPKJfnegCYBMAOaYFkDeOhxyOcixHZGnhokMjAVAtuvFbaRVbfPJDACKNcNepHzmKtqDkAsgpoTEVdyEeMlmVHpPybrAObZXmxRliFmrrJHkeumxZAb",
		@"JhNiXtfAXnxSuyGTy": @"vzqyEtGPdHdeGlvXBMqYBfchTfzkdeylZXHnaQiVonYORXrJkGTECVnLYDZDMSQTyLTYPwlIsHkTLpfJxkmYlUlJwVBJLPpjjlJHHMnDmqdzQRDThGxiHGzpCwcPywANRNjCDCwxwyLZxYrTGR",
		@"XkYhjNAwlcrRWLRnJY": @"CIOUKktDnWhHXhrQkUYiKLZXjNPVcHuiCYbYyZAifTaEDyNkjDqAHVLjrbEiRLvfkaEvhJdmzINhYvDGKUpDWQGtdGzYAVvGpaIdivBAhLZ",
		@"grMABpzlYuVtST": @"IjcIUzyhpStRbshEKCwERovaTjMAtgkZwGAMyqECZwWKzMFGUDkHMTzzmbGKcLndKWsngfbOkNXTkClfNQcOjRReBUqVtuYUBvZrMPMRELSWWtYjl",
		@"sNcOVCkSeNIfF": @"wFIcEjXOdWiIdyfhrzChUghCLSqThRDkHIxkhRQgEiBRDrnutZQAncnaFwHbfbldbJEWQDKQSYzYlHlXFygyEcNNxVvKKusYPbuGxqyLoMsSmUQYetabPssBaF",
		@"aAXvONFadXwLETlOdQK": @"HVwFSUkufbXYODjfISJWopIqxTQOHqayJhXmPKVlFuhXEzkwaGZgBHxPpadFNCMsjZKDMCMHrojjyEdLcIHfqJCYpWQMFiXbBIIBUjTAFRpToAqxhXYQSDasDqxurfXGylLI",
		@"qREOUyJpDoaVStpcTl": @"xnVLvnuHAFDHapfuxmwkARzkvRsZhGbUWkdJDiTPLxODKvlSjEdujEeUpQhrJtkCtWSKMjylwgvFbJXcviYoaCOqpvbZJoBaPdGbUMfWDfqbrZsFOzc",
		@"FwlphbzwAaku": @"UELGJxvmjZOcXPPIWOxfqzbUkJmKFrwOdorrYvzgykDSUzIXgUjFTFcWioiCTbXNmSzafeSbAoKlaUdTLavGcNHALqtWvbdVmLtUHafvxpPO",
	};
	return HNbSWZfCHqNo;
}

+ (nonnull NSString *)FLgEpAPPFkUydtN :(nonnull NSDictionary *)MQhjXkIBBV :(nonnull NSArray *)QxuziGEzFYEH {
	NSString *hsuYsOBukQxbzBFv = @"nEiYbMPNxLmLwDBFIznvwqiqFqfPQTZdNhdMHjBogOzwGfioqZdniZiApZKSatbAoQfnfAWwkrxCruWrkSMgUMToIxHdmZsHWSaCIsbRZAZZHiGJNjIHCSNKpBQhPQDtT";
	return hsuYsOBukQxbzBFv;
}

- (nonnull NSArray *)PXWNntRJNBCQNVT :(nonnull NSArray *)LKGZgjrurGjdO :(nonnull NSString *)InroamdolKNq :(nonnull NSDictionary *)xfopRsuHWPDVvc {
	NSArray *RzEoKNfbUXoHgQ = @[
		@"kUMZPOVnFayzXXcuwyhUwlFkumJTrqkbgNkyvszrJBxHvTIfmAbsrtWozoecTgOTLsIaOZvntIjIwpqTeowNelhztBaNMlxCFRUnkbpkdBGNYxdvazkhjCfqZPkx",
		@"XRRCcydPTxKLLOKvNbjPwMbcPqLbNAywlaMBGnDjygCgyCVJjtBQdchCetStmgHnUgmKSHvqhAGbzYLRRjFHYyZrnfeScKyXnYcyhlvvegRzjGCgKFvaDUvjaQBglKlofbTXcIPhsmEHZVAcVOHJY",
		@"gTRFxbQqCuadSSUVYNZLrQcAhnvOyjHcUFEAWOTtFpgnUiIxBMRpfVXkjwCYMYUixKExyZJTKeVPNzzVmBmMjXobxVDYKahvFBqDNTXONylovvuhvZwIFRk",
		@"iJxrtDuxjeCbkkReIripUpwpwCLuxgtwLvOjuAOsaUBswMmFnPuXTBSDpNuJxqJCXaQxYDlGZWJfZGByCnMEaFmmtklRQrkXONUmHbmgIIIrqoPKtrSeZROKcLFSqcjOSkl",
		@"IMhgqjroekXjGHWgONWqgZdouEhWsolmxlhaUxAeKkVxUkMTAvITLtFAaBlepMgiJKpNxPVzzxKeIoLFpkjekAIgMwQPxlWaCOmAUvieyMQvRxRHJOxiP",
		@"oMgEDHrFWmpKBCJoIZqRAFLohZGmdRiwhBmygeDjluoUxjAUAIkrtDwNOtpVtVBaEhEakiuivUhylTIXiAqHAqnWGcUkMYGTlpdhWSnAFRrFRkTCayHVfCPpGzjnWpbNxOICuPn",
		@"rUlsKdzuwgEDzodtkOZRjjYviDtGnMsORnohLkyqKFlIPUEYOAgDSWAwccFvYNcgiZEYkLSKPSuWAJmZOLVLZwmvTeiKTBphwcRLithEDImdwcrJSpxsAEpOQHpGTpxZ",
		@"wyQonhoLAfrYeORYIZuhnodUVGulPoYscJvHnUlzGvgIhzxoPZyXnvVFJeDxGcRIpLNfHljEtazOsMFKShfBgYBzFQcCNBNdeDkrUbJwnsP",
		@"bGUXaebdXwVfniffgWPJBiHiayyBTQVnYhHlYQMaMaDvsHHXLfkgGXCeMzzTEHAdfzODNmYCdpoPJKzDaUGYnxWmGzyNKkdUCJmmDQemOmmGPvsnuNANmqaNJsSeKaQsXxStYJtMszaUlIKlGMzBm",
		@"oziGRomgQAQytqtZwpVpzjZFVMebNqaVNcepaLnILuXBYgXcdqsxHzIeIAfhQKQvEfFrCusfdbxaCPeWoFtGoFpLwJRxOjqzqSAxIXKeziiABdFrZcZlTHupcVqqzCYAZXzPcSUPzTKEjjywxLXLM",
		@"xVIHUODYlhkcmveegGGsWJUanVUluLdqldfTnsSpzPfmBuapWmGfxphgfbgUvmrOMAWbFkWMoIpEQEuJFIEElkmHUTPrPnuMgQsXklIqqtbMOFoHLBvCsChQhCRwInzoOPMVZyTvTNLrUkp",
		@"JXlcuGbMBasqbFiHVzEvVWGONNtbeRjiDDhWZrmEOncYNNqUGVeuyGRLSEyDlvXpaBoGDfxbFNSEZcVNYHnkZUjDwajWQbJPLNyn",
		@"mkIfujkOyBWIuUKmvWkeUwQWOfcGxJmveyFKPQlIrkdyosMbrMXcDtghaPjwSBgznHduwwoESpBYUjvtodUNMKcHqcqOljPxpnMFevMS",
		@"qUcRotuKNsVtGNVaapHZYRiBMRtbwnnYuhVlwxiTJIpyvfNIxDCuMhZSkPZUEOSUzSguGIQfevlzOsaxnjDrkxECvCfRtvhgZfLtHpYWdtffVyvOqweUYIBeIQXztpFmrFylVoxZKombYJMtt",
		@"dmnGMxCNVZUgdbqigZrlWWbSwXIbmZnOogkhAPcCDbItggOEhffnMuhNgwMmatqvZhcPZplwYClNZqAUOBnvNqdIstHnXPybPhlGfUUNSQRmEfhaVYtbkWnr",
	];
	return RzEoKNfbUXoHgQ;
}

- (nonnull NSString *)JuXxrKIyXJAS :(nonnull NSDictionary *)SWIrvFVprTtcHo :(nonnull NSString *)kpJtQOzwRWnr :(nonnull NSArray *)CuoNBGnTYwxFoKvsEz {
	NSString *JtQcqQmVsP = @"JqAgPBGjYJCQSeuDMkvxYhOoZWPyvPfIvhnLaLGWuYvcbQONyDSaxuketSkGvPuRSZqaKNBPTqREhkDuEEcxcHwwVKBlFnkPCWOYyImYzWmlMjDvGZJiFuOlKuqidsHr";
	return JtQcqQmVsP;
}

+ (nonnull NSDictionary *)wUZDgdzFFHRGaF :(nonnull NSDictionary *)srSwLhfyXq {
	NSDictionary *JzgubUYmSjgHfxosy = @{
		@"lcOPRkOLFEKasM": @"OBZGZRnrzDXSwfuTuQrvaiMmASjrAztJTShwutOVAjStWwcLcJlTgGLweIrLgFRqEyAHukkLriQKJZpgKpkQPdWXEreSamwgxhzoYzYxhKhsQLgLYoMAqyxQPYAqZPxRqZWKufW",
		@"lsYKTpnunaXJJOGV": @"ODRWaxXTiRDIpKNTqoOUXCMgAlxniQgMBdyLjsPPwkoGiHFrZEIzxgYbbyXbrZHROJZQDHHJaxczVlNdFaCWiwLuQHQqLInpQccMCFCEFPhvqtXGZzzHRlteUllfuPKaXkBivxlgKbMBugBli",
		@"YtNekjrjcnc": @"gVjkHmkgpNdDVkHBussqxeBJgIphBnczVnEshhpnLbgRNvCSMTtNIeaRnoCDPidXTbCfURFThkcABmfmcmDwNjuYbzDQRKYZqAgYeFzfeHhnMjaHistRop",
		@"sganrWMWoxe": @"cYGwcYuTHLJffcOphWxzUtJpFeJMyAtkjLezEvmkHwisceLlxWXnYezQkmfXFmYoqpsXiAEysHdwsnUHBxJIxMbipLQsHrnBWkWWQPZDNfobEKdzsBeRlLtGvlRL",
		@"DLsZnjeADTlyFzZCzFd": @"dYxAmOwloyxxXrgXoKObgwEJHzBNNAEemXTlOXnYuVLyPxCJoZiSGjZzbFLSfoILoaallmcUrJDhYVLQcBgCJoZICzCrGYTRVdOOQNXgrESNWIrX",
		@"NWPEnandsANth": @"ucXtdXreHrreuloEVvaBzWVaiFmguoWHNMVIarNVAXyAfngsgAvyrBXwObAnCePasoUlXOCUxIPwDiFDQDxGyZujpsnSpVagQwZrgduHxtZcqEvUwrGesGxKxBvqTD",
		@"jBGyFNUeOTOXxAI": @"mjzuYIfyHULUEPUWgmhpzKXYrCnERxMvTcOpXFlqGeFPYUzffTsoocjgGttwQbYtqmwRXFGQMtxzXuQndkCDssicakfwORnMiGmWRdLJAQUlFDtrdWlRYoajgICgqdsjSyJlorlKbWgZAhZwvT",
		@"bFwIDGUeRZctAk": @"CqeGOMtzIzJIuezXcZBwSCNBHnpSLbGBzVohdyJrraTvDaoDuMAeDWFijuxYKEeCIRrsSDmhTPiyVSvbOiDhrzjfyMmvUdAzzvgetLsErLrboylIoVAYkKCOUhuENSRimIdWbdBQJ",
		@"bbcZnjINsOdivoN": @"ZwYhLymNTopPYjVSHAjsDljQNJzmOyemzwrnJijsLjDQiIVktYDQFyZukojqTLhPPvxHuWfhiskScjFKXspJzOSHBsiprIaXERUYIBnNHqIxpzCQZyyCIIJUAuDRsnYQgA",
		@"FWVQryaQzpFpbcntNbv": @"wTQZClnBRUVChWWlqmxbfoapirLRNYUQxYuceJlTgsLjUOufiEZkWVcKcDbXerQfcPJRXVzllqOYYZDQWXqssrIkREAesZUUrWicwzmV",
		@"XjqwzSWcyeIKKpyvgrF": @"IqBBPLpugiWTKloRVncntBzXskbZziBuZnpIapYLsWwHIpAwwwFFHOzmdmIomLTIgkLMwpoGlcfZAioeYkDJxMgNvcgZTIsPVrgivyohKjqygKOOAMUphVaGItSoGUlYSmUVfJdLAbrkoZucymA",
		@"mlMnBmVmueckh": @"HypigGBStyXYXWYhdlnHOJMkLzrHHXVigzkjlkQEEKnskUgptrSErlvVgnYlsBMivqwXvbrCApJhqskgcWljWyKoljHzwUTZGioWUsLoPf",
		@"QwnHydqIoOh": @"vOvTczgafHRNUknnkXInWbSlsWfomtueCVhagQMCeSJMcdymaujMurOzJJHmXTeBHXfzzDxBAivZPVHegIQfvEONTChAZwDYppCRWULulClVjCAUrPRxXoGUKHliQOhgmMnTbtMuMuqyQqgHDY",
		@"CrgJYoOlNFlSCbt": @"JLguMLadRFwWPYRxOWfiRjZaVHGYffWniAQwarXlKrPisxcDGscfTOQySNCkAFTDsgYPPQSwaudmFDvwAdkaEUzyGebLzUWWaSFbhXsLjLXoeZbJQPCEyRfNYtqYcMgHNbNphbX",
		@"pZZTSoLdNrXCY": @"cknFNkTHbPlImhYqjhUvBxGpyMHuVHPkiKdwbqymakKSgxmBEcIeaaTJsdkcdYSNsiyZZSGSgTGqaXsmRfeazGlyfdZOpmZLFydgaXfPijdrnDLiZmNfXBiBODIpZqoPRdxEcAcNIZPMIjGLvKDl",
		@"OlpasXpZDIMbDJ": @"pLqQzrFZuUeBmdFrDteUVcHMKSPZCcUHDdmrahaDFrzdEqseUeeBvvCICkgiDzmrYHJjQFxXqpbbrvFumThxFvYIyZtNYLWkecbpyZIcjcWcrQnOwxwiDrXRoicXVGsgBcFQmQiVQlTdSdk",
	};
	return JzgubUYmSjgHfxosy;
}

+ (nonnull UIImage *)HoSeKxLOSBRNFLwBCu :(nonnull UIImage *)cOLobbLnzzvValQfMG {
	NSData *BOlRcUHVknvRWKmCFl = [@"WsXoikpQDAdFqLqrtTkPXEjGROacteGdudIXzwvsWvyglSBVaLmLJWazQYoSkoqsjXGyoDfutUtDThctcCehBWyDrAUzMnzqfWZtCWQgxpqOJJsUdZstSDMgDyauQfAeuvPTXxODfjFHOSvFj" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *awCnyIWQpHGHiH = [UIImage imageWithData:BOlRcUHVknvRWKmCFl];
	awCnyIWQpHGHiH = [UIImage imageNamed:@"fVnNyoIRXJdWnBhjQJfOpOWSaFuDAuVWCsljsFLBMERqAVHoInaUYYYxYATPdBcXPNcBtJcgzivbPyIxGhBnTOkQAZpyJAtjFBNBbvaqoItWfqiubCzxakiEviextnABagWp"];
	return awCnyIWQpHGHiH;
}

- (nonnull NSString *)rRitomNEzXKfee :(nonnull NSData *)pnpvKkoQfxVJhdrrWHe :(nonnull NSString *)GmXAYxvQDJsNVJFpeG :(nonnull NSArray *)zAXRoIvZpnimJz {
	NSString *bxcQeMNhTyh = @"ScQEckIFCBFdjDWyFQSRTDBfbXzwbZxYFVbmuEnaNEttxHQtLnwTwJZetpZNikmwevGuxuqwRiPiOrMqNYEyhNyjrdYAbJVsHbOcgCQsMxGbpmCnVJUTmoNZvVSlFQsEYXjFzYLIJwrhshFUxBBrU";
	return bxcQeMNhTyh;
}

+ (nonnull NSArray *)ZEDbEwAGAWkIYh :(nonnull NSArray *)tvGRjhdCVSvNfWw :(nonnull NSDictionary *)EmaeqZWzLACyDIu :(nonnull NSDictionary *)GDuTRxPGDoYSwymD {
	NSArray *SDMPPeHyRIQfWVKINH = @[
		@"clWjaCbyEjIVbhqcmWHCdbzXTRWioyoUUOANYCKQehgwKvSWRpavmcMNRHQxnaLuPlkVSBgtHzMrryUQSeMfGqvLJBaxUrLasjdUhOCxbRFdNGciWrrDoYSvnjewSZcaHJGeg",
		@"cYKxguqFBfsSSYlnOXnGbrfzSAHyhgzwQLfeCCGgUBUXqvhGNbDdwdrzDuAIuctXrTlrbhaAUuMtnORTByKHAzzRQQdRXlJavTGZgXEZigDJjsvyNnQEuenjGYpwGsdbjbnbVMsQGQfdnAb",
		@"mWbbPLgJEjxgpggTdBnfiXsecpmdOwLnsVjCzPDrotgBdwZypFXqZJMIWyKEBCCGTUTiZNnCEcQKEHCmDEXQvIdavpeRuIUhrNqqxeY",
		@"obdesyXLHKwgGGmJOSZVMBonWfwWWtiGQxgSDYwqXhWKYardLAcssTWMYkXopJIbkSJQvQyJRCSlYEQsavyFKQsOWEdQHhbyDUoQXn",
		@"QedzbBngZuTDmFieMNOrFBVGMIbdjIALjLmjbuYkSwBbgDlVQeqDRyAZpghtTkAWUQTMwYfkCdcFdemgRRDghzPvNARwDpcueTmfuCFVghJQRWaTB",
		@"ZXZejgHKxXNUuvNbDNLsjHEecdDEdmpSuWBDQDjpaTBCAWnmjxCmLXTUCwgyDxFRcBXlRsjlMbTjdIHBnhyDeqAEUfgtaqcHceUhrwXjTEYhTXUseKj",
		@"oCPjJjGlXGUZfKkQxykNaUGutLHaoWCKinPMFZNCVkYAYxRwzShzqCkQxIVnViMpDLJrTzKPsWjPLMYvmmgjXUAXEKIVJgOwxaptFtqaHyHsoNSkvxnXOUXs",
		@"wztxUjPgXhEqUDtqRICvnARByzsHwocRzNPPzRcZBESHXdpqeQYtXXYrnMgtrBIkCKWSSKJsavyHxwUEHhLYXmgbDOFYFaQbnRkDAEkTOGR",
		@"AScMfLmDtBGsiHvrCiuwloUHZoFCtlhvupNksIotIjRrGwDyPzVUnYBoMdZDiMjQGyNRFkqfiKMuOnjRUALKmkWGWACpSdAdQYRTXvQDiRsEZtqfzxiGmjIVUnPR",
		@"SjGvBmBnryaZUsAOhQWvemNUeTjhLoXBwXnachyPxSzMDjtVNZzoyJmxlPsMcycVStXDxHNUvFFGDCIkRoVKAhgGRsqieNavwNdlkdlXEiuRoDyQyvFUYwRdSERATzmvXqdJxnfcjmXvnNPiqrY",
		@"fmEZhEiQtFNOvSHOSRRdTEDGuFyraOAxPGnMqwzagxeaymggyqnevGhkKkjQZuTYoswKuTwzbvIqhXAyfdAuvqlvqlDxloDXbRGvaaQAYmhMTbCotyObJolKUNVmlLmFunhtSVuPK",
		@"esvilSSLhNXcJzQVTnSAkIlJuxBmeXPGIJwRRGGYGkBzObNUMmdapfVuwqUyZOIeOzWTkKLVIFmdRopERQWTfzhHCcUjkPquQoGDAeCRTLZnnsKNwayWyiOXJiDROIHFnnQFteXLoCzPgVHshtoc",
		@"xXPAaSUXXWTniDPrnjzdgQPRJxEMYLxGJYBsuxauHouhGCAjsgOIkYfJhvYdYHsamAyRNRBlmnIlUbNOjFMkLgBxlVULzMyZTcHBAYjaBEEncppMTUsMErcLXNKPGXsAADZ",
		@"lmsGQInOsyCwhVXplaJGiPPbANjccjUoJbtYswHXWEDarLyxAVlmauXeUIudoenbbgHrjNBWYspSLvOjvXYyNqMUZPkcmAOvCaNhtQuOPDLYc",
		@"EGSWHpohVwxnXGwsOhswoYxmCoxrFmIBRmCnZWjGHlRwJMPaEBwrXaxRyztSSzERsFxMYZXMYkRdPVMtSRGKpNxzLRytJNCxtgLMyMTGgldOQxoXREx",
		@"WoPPPVBAhoMsyHmsblATFMqkTwrdoGRdalmrHuCyleSaCYiqBVNDZNRQcHKJWzMazmKyovfTdEtqOikihDMeGwPqlpRoWfgsiXWfLLFKRihyaJihxrBDZSYWWRnWdCcpUnONZMjcKVRXg",
		@"XqRgbBxxqmaMSsmRifxkChpMHyQdbdsMadhhFvzdDRcKaUeUgTmHBjGBhyTyIeRAwMrDEyXUFQBCilDwxTrqdTgnCsxcCeZNjmAwxhgjoDlLOGhQHzRcWWDSeWzYaHCqvlkaCbUChuibjHbXIk",
		@"hETgJXosGqWwaxKnpvthaBoAdjPJLUPGDZSHqRNehrRMPLQISNcJOhhbfupxUpynuyxFqUGbnIdCLFMDpYoTRIKzxQYpXSvgwUoOPtkVUPECbitJBpRdcPUjQIDOsUoHHynjTTvohOYEYDEChskRs",
	];
	return SDMPPeHyRIQfWVKINH;
}

- (nonnull NSString *)eOoXVbHZQrBBvASuXS :(nonnull NSArray *)nANlEeniXuyMtQl :(nonnull NSString *)uMJXZJSvydWWP {
	NSString *nHWNKKwKhfH = @"REJlXjjJayvuUmVtakSQypMDTtJExdIlZbXnGwOsFzuAyVjjnTTazjfuxDhjcQRdbjmHhoXEIXHYekuudggwHCAZCBvStqDOZZXSSfSwxBYdPtfh";
	return nHWNKKwKhfH;
}

+ (nonnull NSData *)AsjGzPUpRxdnsaqpjK :(nonnull NSArray *)mrSFPaZQPpgmeFsDPS :(nonnull NSDictionary *)FgoultaKllmtkSvUsSV {
	NSData *LkhoSiYhSMYWHK = [@"hKgmRWnTFCLtNZhWIDiiMzidbzfSnnRRRhMsLDTkWaYCgDylqklFPRYnYqrGpuPwTYFZXMrWnpxdTaWiCxJRSckgVANzYNqWiLDugekexZgzUmIpnxudxVXK" dataUsingEncoding:NSUTF8StringEncoding];
	return LkhoSiYhSMYWHK;
}

+ (nonnull NSString *)WysVvZpFVrPBsTuB :(nonnull NSDictionary *)jffYrfmwmnV {
	NSString *fsNIVeCcEgt = @"yVulSVRaSYJDbfvanmorGFAxpimryTIOQOBAFrtaDIBZwxWqmbVfmkWIakoAZmJdhQcgrwhPbzcOaAFzSSoweQmawQjImMcWxyJUvW";
	return fsNIVeCcEgt;
}

- (nonnull NSDictionary *)XLsviWdLBdpuScUEzu :(nonnull NSDictionary *)zyVXLVBGrYtlT {
	NSDictionary *JGIYlKDbJie = @{
		@"aSwexsLVzIZfT": @"XJhVYUsyQfLRAjWoeqqwAGaZObFHkBiqUEdvLsuqgZvqUmzWbZhUMvEWKFmTFxTqUnhXxhwRkwFTfxoIRkRudZOQBJshKNOuRCRGVbwJpIwNCCgYSsSYRyTzVTEwySLijiQLkEq",
		@"znhljYguRyXIbELUX": @"jQAlHjHwvynsDnRoUyniDAZBDhdmFcQdpPVBMkkSTwPLnTEpkbmBrDaUFsMpmpxysINwkCsTxkQbcuiCxBjAFTpSnNjfjvUZjlGsCEGJVLcMWuJKRDTVAl",
		@"DziEIZztfv": @"sbQSFcRjDivBJZVySkAYQOxrKpcdbcJRjwQWiGfiyJTCxUSvIdOwYJjEullndjjaxpdSkuwvedUEJweRdigTEGczVNTVjIVdONjjtuMzNxgaBmFcWh",
		@"wAyzbIACMoxZ": @"lEBXxDiAwzhKJcbGUHnxbXuUTCnMkKgqHwOkAAsJUxbnmLaOsYekNXBBnlEsaPTuPvRDzVvniUvFLrOCKLzEsBMOXFxZboYKewrZJC",
		@"sxiaPCvpZeAQ": @"rAkxDtDtUeqIEZhInHskhyEzcSzgrzgRwxrJutWMggQTeTrgbbraDSzhVxnzBDaNiSCzHrQJWNribunmmaojfVmzCWMisDlWwcoYreqaVHkKbFPwBXeXNZFHPOhoFIEQebbiDtAufRqFzBhTAS",
		@"opbyUYBZwsjHbv": @"ABGmcyNsyLmUPEfzqBSYfKuUCZGGNQIBudlZQxjcmjNlDtlIudgfymQlMCsqUIUHPAfQohztPivLkUxQkyupppDcGVGDsbymRMlX",
		@"hxPlfbxYTeiWJiYnWLQ": @"RAKJVenkwClOxyFVBcvCWJPtlkjabLTQEjmFsPRguJPdazGUiVjObyVabzkYtUCgrhMAXMhADSJFtfIYWPNeGELFIvlKoghuoblqxPFVk",
		@"FnLtVxiPTf": @"SluSlikrTLNhNvdTHSobojCQAMkjtnwhSaboCjnNBheiCRzKLjPkTVAyrraKTMztFxKpjcBDJZRFpsVhcwdIhShBmvlGSjlJKvokizSScqmGRYoYlyywQXpLjNAXLgvhNeBmiXjIdXvMtC",
		@"gqlVxusyALtKqO": @"eHhiSySGbpkDKDnhYUDKGgtDecIZUakVdrQsGcyfajeMUonZTxLPnDqYyCjGawXbVKATaPyYjOPQgjlTthmeWHhHlskJkgEDRWoSLWjylrodfKRDM",
		@"CGjWvigoRNTdQyk": @"KNdgiRevhCPPXLsxEuTBJRHXmqBfDfXGUuDIpFAEmnJorPkJJkHJxpKXBzALAGVcwNVsQCdaqtOOUAGQKvuyqDkniRhHUJMXYcVeGbYTLLJkDWrYGAOyaSIfySiesuqDkXQ",
		@"SnqGNUxHZGm": @"cLqJCFGavUzqWwygUYAHvLbguBLGzYcbUqVSQkbPRJluNFKkxcltOWKDKGTWleyWScZHHGSXJiYMemyRAUttWvPrKxFEhjMsuPoKQdFFiUzjvIonjwdfBzEKPswmUUIoPCtbToOwziXEZxbxm",
		@"ABAPPbLwfFiZtAPM": @"AVsNiuLIaRgrlMrudCosbRyIfeHQujFQhgrqfeAgfyIDCQBHCoeIsNSjZwoqSkEqsVAkBErihFbNTTOuisIwfaVewvOIUGmwqYQJdDKMQVwJSboHRlpicASfkkPTHVfDJfKyHZRCiJZpNNhUP",
		@"sqvJYbFddjRrbVX": @"IemzfbsNkthRDHwxkRkWGJdDqNXzXWeaAQkibtrFPprZhinNPmpCfXiNeSvqfDNczaGJaKnoEKiQjnMXaMNyYHblOzBUcMoRmQLYXDIOzojVDcPLzQbcFYCkFiJTOJtGLHFnQkQPf",
		@"atPkovViUpdrD": @"oAPkHDqViAPsCVEzvZIxXIjLJVSGzdghgWPSfJLcZmHEAkyMpTQQbGifffozofVYumjOdwhtyXezSzwcOWwJjKhBbyNrcRljAnRxuwyMfFAzaqRFH",
		@"PSehqmNSmHMP": @"FFnsPdJUufhciTLQNnikGsyCiQozwcBmoCNOUTyVlyRKorcsVBSPumgQZfFuwSFwpYMLbNYZCJrvqYUaOxiKAvgxOJlrfyRkBWrDhUnxVmYE",
		@"JqfQwijTAPpwIkZ": @"HIOrUqlWXILcaEScMPMHPFnsjYiMcYUPlirxLcomYuIFhknlaRQfUXcxmWRqmnIoSMTgHDOwjeTcFCZIXJkAXaEQzXzBsnCiZVMEiqZtIiLBLHXDSrXeLFaJSAwVifZwijcFcaNNQbCDfAjL",
		@"ATIopUExRFyPrFDDlrg": @"RHtkddxocecXPyZriGjjlevxAyIzDtsZwmjfNJXfksxPXpYOpHPUvFMgesDZzTJUmvxLnctDpSbmxsffmAGnjcJhEHNUhwzngSJoDmtueJWaKtgBjvvPgYpUuhpkdqtFsMuIeLMu",
	};
	return JGIYlKDbJie;
}

+ (nonnull NSDictionary *)jOtmDEcdPwo :(nonnull NSArray *)iaTBNYZHhXnBHQzgsH {
	NSDictionary *OuUZmXlxtqqxPhNt = @{
		@"MEiNaRmwpRuK": @"AxRlhYQSGhxgTGftjUtMpNzlmKVtYErVEjddvEjoOxWTAOUNXEXyFvTVriqVTPMLRMdUbzFRCKpopdHUoGqDSmWiDnATvSBTbXfYOXfXIXV",
		@"kguHWMyhfmfM": @"rSBHVYWQDOBpkQVqcIaxAmivCSWrwBzhLtRkrOtaFLvKnzloDEXLtpIAgEPwpzMqUNDrNLJqcFUNwpKoIWsAmzMjsXZlOnKdaqGgTrvVWlQhUhIYuFwDOGJgNsNm",
		@"uNpzYwmrxbHacj": @"KEjWscfWDubTAcIvfSfpaRaVpWedENTuRKgveDIXfBPhcRYWdiAjfLXAZHktVieCKtCFInfVacqlsdVTyiMsAiWydBoOBmyqliBfPjGQfHRLRcYChF",
		@"uEgUnQLlOVrLPVfjCU": @"jGOsganIIGRozLZbqQJqqizSsjdSMFbJknaveJCWGXEzsKqIAkohMHBXwFIVRTRnIfGeejLEljwxBumTlMZgGBEuTDKMmXnBhsKApCQuNabrYZiUgkkvrKyWQJWJjUBKqwfEfMA",
		@"aFepakuQsNmLBOP": @"lsQirydxIcCpywOohPczthgUrQNyPEkMwnXQCcefIgqxGfJbCFsSCdjFMlSPsQkEJEuhyFoiYcISnJTEJnghKWcDfHzmgEDhQiekSIpEYAozfmAHAacNNhGHJnFhdhOGAwaHVFfFvqzn",
		@"JsrbUtFellUSaaKztj": @"nAOhAoUwSvsHkubErIoXYMvfxdSrNCgoXfrwWdiWTocdckjExlNoXTdZcrDlZDrbyLkCZxdWPoWrGDYegMrwEaeHBXticDwDJBYmCmufkSHwYkdCTEmOaAQwpqzc",
		@"DGymYlWIyUKZDX": @"egJcTRZmeKsCyQnxJBlPuiUWYByKEFJtdQnUOBFhzakotSHfSpjOyLPNtPpPHrKBcRkiYaWYgeUjwgIjfbGqhvfXiYhDxmfQdrSPiFJZFcqraaVXXcSAAlPfKuS",
		@"vtuwoNCJkeqS": @"uBYSmCVyVYlwbxkDWiKyYrvfvYssQHAmMzfAWHyZFvAmjHtpwOKgzUDZDvQgmfUyVcVIiuxbiQjHFQwmMVtGLKfwHXrajwxSDCAEPQstQlmmWAmTZfVMRaVApkxulqPDXZANvLbM",
		@"QYgbxmGTQIYAXcYyeH": @"LPdHcHMIOJqVRdtcoqemdIYTsSDogOqQHRYeFyePZzbNLQpMuVOXpNjsttzOGAzhIWiqyTghYvqNiNjehGjiAUZIdEIfJVAvNhqHnAdetUCslhJLfUZVQaazbrwTVJtNDnnHDoyalAlTjCzVWyunC",
		@"cglycDoValCERg": @"bdWdvQxxmCELxetJIgqikCOADhQNVBQJqLEksyKUkGSiuBNcwkwLtVdwOIUjXeZecghJGRLQjYvabJIZugspHmbYtHhBlunOXGFCtYlJbRPybZpASUbONuKqVYgJFLWgH",
		@"xzgPWpDRZFBh": @"PMxaCWPJIDNtNEvjzHhduwODLHyvqblPkrTSjDZYjlhIaoiBtZlhuzGVmpCEeOvkWAjanqOUHlbiKlzIKylyizQjqORksyfkuCPQHJelEnt",
		@"eBySbwnWSoB": @"PJjeHkvPVeKISOYwHXORoxwnKArnjAhgerjhMNcpBCMLCMiHkHqvRBQPjFsxBXyICZYFBbOxKfuOzeRXfhjMxaRfbFdzNcQNHnkaNhmRQAdeMjqlQolYqXfebcJCPcuNU",
	};
	return OuUZmXlxtqqxPhNt;
}

- (nonnull UIImage *)SjkyYWVdOOtPfpcZdl :(nonnull NSString *)oHRaHAIYfhac {
	NSData *pRTtbHaqkhSzBWV = [@"pxHOgSqHZpncUNbRYCOACIcecAHOgolnsVQQrvXIHxoXFQsxAbOQuUzjvlBwtEVwDOGSzaONglWNzfiJXOqEsgxHEaATWwbBVToOhNtVCiXUpxBLvSnlcPkoHjeemnlgxIbRGhaNitVjF" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *lQlMcUSEzYYw = [UIImage imageWithData:pRTtbHaqkhSzBWV];
	lQlMcUSEzYYw = [UIImage imageNamed:@"IeoxUakdbDBxwuKAzLOjckIgfLxXKsNXxoitMKeuqVwJNnwXjKMWWicyzWCtOjihWZtFnncZZodJqQJFrvDnDEyRPWFCNGKNdHUbzgZdBycpjCJeRfQFRYvEGHInBbiJkKjuEOZcatSG"];
	return lQlMcUSEzYYw;
}

- (nonnull NSString *)QcMmSwFSmv :(nonnull NSString *)AuxccTDckhnaSZCV {
	NSString *yoJkqWTlMxusSbKqo = @"oVTPiqhGsuGopnLEAEMuBwLgEFisOlnMXiBdcnUbFxoRKqsESHcZxYYLpUgOiLNdXoUJkVftEMxgIiQxrPumKhbObGstbNflVirZZtBZMiTmzZR";
	return yoJkqWTlMxusSbKqo;
}

-(void)networkingTitle{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&index=0&count=1",NetHeader,studyMap,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSInteger code=[responseDic[@"rescode"] integerValue];
        if (code==10000) {
            NSArray *row=responseDic[@"rows"];
            
            if(row.count==0){//没有数据
                titleLable.text=@"您暂无地图数据";
            }else{//有数据
                NSDictionary *dic=row[0];
                [self networkingMapWithID:dic[@"id"]];
                [self networkingProjectWithID:dic[@"id"]];
                self.ID=dic[@"id"];
                titleLable.text = dic[@"name"];
                self.finish = dic[@"finish"];
                self.total = dic[@"total"];
            }
        }
        
    } fail:^(NSError *error) {
         [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
        
    }];

}


//雷达图btn列表
-(void)networkingMapWithID:(NSString *)ID{
    
     NSString *url=[NSString stringWithFormat:@"%@%@?token=%@&index=0&count=10&id=%@",NetHeader,Projectlist,[UserInfoTool getUserInfo].token,ID];

    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSInteger code = [responseDic[@"rescode"] integerValue];
        
        if (code == 10000) {
            self.mymapArr=[NSMutableArray array];
            self.rowArr = responseDic[@"rows"];
            self.mymapArr = (NSMutableArray *)[MineMapModel objectArrayWithKeyValuesArray:self.rowArr];

            NSMutableArray *arry=[NSMutableArray array]; //题目
             NSMutableArray *arryQ=[NSMutableArray array];  //进度
            for(int i=0;i<self.mymapArr.count;i++){
                MineMapModel *model=self.mymapArr[i];
                [arry addObject:model.classesname];

                NSNumber *temp=[NSNumber numberWithInteger:model.progress.intValue+1];
                [arryQ addObject:temp];
            }
            p.attributes =arry;
            p.dataSeries = @[arryQ];
            [self.view addSubview:p];
        }
        
    } fail:^(NSError *error) {
         [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
        
    }];

}
/**
 *  待学课程
 *
 *  @param ID 学习地图ID
 */
-(void)networkingProjectWithID:(NSString *)ID{

    NSString *url=[NSString stringWithFormat:@"%@m/studymap/courselist?token=%@&index=%ld&count=10&id=%@",NetHeader,[UserInfoTool getUserInfo].token,_index,ID];

    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSInteger code=[responseDic[@"rescode"] integerValue];
        
        if (code==10000) {
              NSArray *row=responseDic[@"rows"];
              NSArray *arry=[CourseDetailModel objectArrayWithKeyValuesArray:row];

                if (arry.count == 0) {

                }else{
                    for (int  i=0; i<arry.count; i++) {
                        [self.projectArr addObject:arry[i]];
                    }
                }
             [_tableView reloadData];
        }
        
           _index++;

    } fail:^(NSError *error) {
         [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
        
    }];
}


-(UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,SCREEN_WIDTH - 50, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_WIDTH + 30) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MineMapHeaderview class] forHeaderFooterViewReuseIdentifier:@"section"];
    }
    return _tableView;

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (double)100/365*SCREEN_WIDTH;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.projectArr.count==0?0:35;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return self.projectArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *IdentifierCell=@"cell";

    CourseView *cell = [tableView dequeueReusableCellWithIdentifier:
                        IdentifierCell];
    if (cell==nil) {
        cell=[[CourseView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierCell];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.width=self.view.width;
    cell.model=self.projectArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MineMapcellModel *model = self.projectArr[indexPath.row];
    NSString *courseid =model.chapterid ? model.chapterid:(model.mainid ? model.mainid : model.courseid);
    
    
    NSDictionary *parameter=@{
                              @"chapterid":courseid
                              };
    NSString *url=[NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseAdd,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
        NSInteger code=[responseDic[@"rescode"] integerValue];
        
        if (code == 10000)
        {
            NSDictionary *parameter=@{
                                      @"chapterid": courseid
                                      };
            NSString *url=[NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseDetail,[UserInfoTool getUserInfo].token];
            [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
                NSInteger code=[responseDic[@"rescode"] integerValue];
                if (code == 10000) {
                    
                    CourseDetailArrayModel *courseDetail = [CourseDetailArrayModel objectWithKeyValues:responseDic[@"data"]];
                    NSArray *captions = [CourseDetailModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
                    
                    //到课程详情
                    CourseDetailController *courseDetailVc = [[CourseDetailController alloc] init];
                    courseDetailVc.courseDetail = courseDetail;
                    if (captions.count > 0) {
                        courseDetailVc.captions = captions;
                    }
                    [self.navigationController pushViewController:courseDetailVc animated:YES];
                }
            } fail:^(NSError *error) {
                [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
            }];
        }else if(code == 30030)
        {
            [MBProgressHUD showError:@"未开通服务用户免费课程已达上限"];
        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}

-(UITableViewHeaderFooterView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    MineMapHeaderview *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"section"];
    head.contentView.backgroundColor=[UIColor whiteColor];
    head.num=[NSString stringWithFormat:@"%d/%@",[self.total intValue] - [self.finish intValue],self.total];
    return head;
}


#pragma mark  课程点击
-(void)courseclick:(NSInteger )tag{
    
    CourseSpecialDetailViewController *vc = [[CourseSpecialDetailViewController alloc] init];
    MineMapModel *model = self.mymapArr[tag];
    vc.ID = model.ID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

@end
