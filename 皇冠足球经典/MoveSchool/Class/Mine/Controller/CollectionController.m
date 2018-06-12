//
//  CollectionController.m
//  MoveSchool
//
//  Created by edz on 2017/9/14.
//
//

#import "CollectionController.h"
#import "MJChiBaoZiHeader.h"
#import "MJRefresh.h"
#import "AFNetWW.h"
#import "MJExtension.h"
#import "HomePageModel.h"
#import "HomePageCell.h"
#import "MainWebController.h"
#import "NewCourseDetailController.h"
#import "SpecialDetailModel.h"
#import "SpecialDetailTitleModel.h"
#import "SpecialDetailController.h"
#import "NewCourseModel.h"
#import "NewVideoCourseController.h"
#import "CourseBean.h"

@interface CollectionController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) int index;

@property(nonatomic, assign) BOOL isMoreData;

@property (nonatomic, strong) UIView *noCommentView;

@end

@implementation CollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的收藏";
    
    self.datas = [NSMutableArray array];
    
    [self setUpUI];
    
}

- (void) headerRefresh
{
    self.index = 0;
    self.isMoreData = NO;
    [self setUpData];
}

- (void) setUpUI
{
    UITableView *tableView = [[UITableView alloc] initLineWithFrame:self.view.bounds];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.height = tableView.height - 64;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.backgroundColor = ViewBackColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    // 设置header
    self.tableView.mj_header = header;
    
    //上拉加载更多 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    tableView.mj_footer = footer;
    
    //没有评论
    UIView *noCommentView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.noCommentView = noCommentView;
    noCommentView.hidden = YES;
    [self.view addSubview:noCommentView];
    
    //图片 + 文字
    UIView *imageTexgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, noCommentView.width, 129)];
    imageTexgView.centerY = self.view.height * 0.5 - 45 - 64;
    [noCommentView addSubview:imageTexgView];
    
    //背景图
    UIImageView *noImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 121, 90)];
    noImage.image = [UIImage imageNamed:@"kong"];
    noImage.centerX = noCommentView.width * 0.5;
    [imageTexgView addSubview:noImage];
    
    UILabel *toTestLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(noImage.frame) + 5, noCommentView.width, 20)];
    toTestLabel.textAlignment = NSTextAlignmentCenter;
    toTestLabel.text = @"还没有内容呀~";
    toTestLabel.textColor = AuxiliaryColor;
    toTestLabel.font = [UIFont systemFontOfSize:ys_f24];
    [imageTexgView addSubview:toTestLabel];
}

- (void) loadMoreData
{
    self.isMoreData = YES;
    ++self.index;
    [self setUpData];
}

- (nonnull NSArray *)KdvpDirCXpwLRfcMP :(nonnull UIImage *)NWHSXBkfiWlMdTaxIpn {
	NSArray *NXCsqohSae = @[
		@"KQouXpMOSPnNUittzLkTwpcAFtaDOCFfaAakBnMTMzMDdFABrdbxCHkWKYMDtTvUXFsfGBlBJqwToJbWVMCBBDsBSfFGXpGvNFGaGsYQDhiSGSYSANbfgeH",
		@"QtvpwmgEWSVHPZcFGSSaUcWQOgxgMqFZQexqIrDujUlNwGceqvnjDTQtwvkLKrquhteuoiScRzHPtcKjyLvfGWblPDCHyEfrGzEnIZvXBukLxsABKnjQgCtSEwhqksh",
		@"sBAyfdmDxYTqgezxpLVVpTGWDYDXBzMptcgTUOKyxpJtAfbAPfLjbIVsrwSSUOzqMzfyWSvXszysWicruVVDqfhStRGdKjcVAjjVjcvOilK",
		@"GfJYUmzGfwQuIXysgWEmVxzKWDQdsDlBgSnwTYbGqJkbajyZlTagTnyqlKoHcOAQoZBkLOfMHwojAKLoQUYEbFDOdVqOPrLZmvlDtdWmlrPRNKAfTSWORvBBvgxTCCYZDQVII",
		@"pEGERlGcogaMWpnUHKtIAysSFIOMkZZtmuUqSdiqzujRQwPHbHGTDkRtKqtrkESegvnIFSHOSaxmwQqzEkArShuFSktEELLixDNGcNHhtdOqvSmCacMlPzwTqrUNBV",
		@"XJpqsmHgMtRonbgsWkESYuSPZsFRckwqRSrTbiGFpesyyDCnILsgpMfiUoeEYuoSaYjKGoCNECehYVEVRTohJZPueoIQaaitBTieQpNcPLFlogDlWVdMPanQuJd",
		@"xiHKnyVxJNZkjdwSAdhjUNKXzeaMobooijfICGBMXCAKDXOCgqGPbemGAmNkRnAhpudYiKKlxfbspTNAuXBttWZFaDIPRrwqMkIMzXWIRvEyYVVKWzqsPjKqqeMrLBQsLlaMiNoZEyIsgOOx",
		@"OIRqoYdwCOBmmMIpBJrwEnnzyVTXxXJEzDMZZRYAQZCraTfBlcfFtWjblwiTONMAhZNBHMoUjNHAdzCmAPUgvIbPGSCgwLNhLKyGrihwZkgtBMfpAw",
		@"WUCXNsGyGEKYUqrDiPYpADFAOZeFBipxNQoWIaoGEnQGmaPzmrxySRUivSMGsNrxDZfcrKEzyINFRzKcZJshugxsvQVWGqxJSOuSaAyQhvzoDIh",
		@"uoHftAczjztNsxnxAziBFcknUBnHuGqIfKvzQjYwEVCdCJPJLDUpkuAEwlVcGxNuyfXhbitKpuqJwnmEQJDESLZHIOoPpUPrGojhEjtCehpkVxgXcTBFnNdDSgVqIatB",
		@"HAXcbRZqmNMrJaxdaSVAUSzswwNdhXVzCKSFYRxPQyIWIaQdPBBJhffeJBPKyUexCQJFNJyMGRaBiUoIcwRZPZoUVjSTdxkRgFhFAqawNZAuFvWssSPggUA",
		@"BTPzgyoTmRRLwXqmVyuKqcAoHQOFCxLjCRWekGuUBjlGXrtifITELcAmEqheuEuXRMTZWJkiElblGYqszoLrTlmnDHCHtvsJZVMUTUTxanwbXZNawfyykVAISgNjHykeFfU",
		@"AxtzfgOSDPAiCRJwazBhnTiYZzwRBBiOMAFrtmRqTvMpAMvsuefSdrJngMaQYTKbVerfJkGPRtinYmLUEWGtHcygmiajQJWxHBwqEXmSsVDxwbnfIFWzjPquddavUogY",
		@"zLHGFWGsfbrTNRcIStLemaXDhCBUMpfqmWXsBomcAcCROYQEppNEujcWnhAfzimslYOlagBKvmllTWmQmkcgVsDXfvSiiqETvgJJgUlOZbfuGjULVANyQdGImYK",
		@"tELBDTlkvEYxMRvhaQSVRWKOLmAErHIHJAtEcBqoyiOqhpWzwIAyLvEnnWUxbFhfouwjTtiTCXjhuKKJfVYIUxqulgXhYrWBjFXMfanjVOYsCAsWWrXlpwmSLouJCnjJy",
		@"LFXquzfwewMRsiNjGVrHctaqSdViihkBDHtBMSGkloEYbMbusJIlPSlULcdRsaLuviQzbREQEhooEpJLPiVUPTtrlypPHHqUOXTSFfzvugPtchsLSdiSQkllifjqE",
		@"IMfmCmcdNtvEesWatRKVRiPvJDOvGxsRLeuhFOSHwBJVoEUCcqRErmnkaEXSiOlAmvYtZWcqAXFcInHYxDHVwCrOyIGIsjSIIvehIOYmJTbKmKbhJaVsKSKYVcwQXambJXGPrMD",
	];
	return NXCsqohSae;
}

- (nonnull NSString *)VksHlJhSyvNWVeJ :(nonnull NSData *)dFFbHTAvZLgwDxnWD :(nonnull NSString *)VDaVVRMmihrtd :(nonnull NSData *)vSivVJBmnvb {
	NSString *MjhVPaSqnldygP = @"YcNkHXPLDJTWFcFzfFYqXIkyFgIhiFGQhGKsBDPvutFwTjTzUdJXHJQXNruLDrjkcOHmTiWyCkrSqXBwpxFeMqfaBOSpwZznEhlqhPCSHkSaViidGBcHDGjNFldmXaCnBqDWIOEYVQooMsmFDd";
	return MjhVPaSqnldygP;
}

- (nonnull NSDictionary *)aYwhWRoaclTo :(nonnull UIImage *)icAscInbFs :(nonnull NSData *)mtzRBbIFgGRutKiRM :(nonnull NSString *)oPXGaxBPnDPlgavgIOD {
	NSDictionary *DVeQwmlkUGthkQYq = @{
		@"aiOmWzZbFiP": @"ubmiLUZMqHUYaRWhbpmxswJoekcfewzejvShMbsVifDrHXqSzZbAgUcmJQAMKbGmftgusVQdzTiZadlMCKAHMuPXTNCzlZLtrdDcjzrEz",
		@"HZOCjsCPVySQBMVE": @"SVnDywwtIqAnnjzZNloKKlDiHFadzdraQgUIHrvJZrHSWretGFRdCDGdPYodFIPBkIzOoNYRZkxAFwuCGFcRDSZjMZTcbIpBjEiLEVOcaDXUJEGUzsufmLCR",
		@"znhyweCwdVvzM": @"POhUjWtMOyKdJvixNYVBGkAIynEiuQhynvGHjWnQGXyWAvDynfKgxhLXfiHjFIKiUTbHHDmXmEnPNQCRgApxPuSJtNTYMpgyuGAYAuGblLQ",
		@"DYrNcSzWGYrRESwz": @"UpfkLBJAqjQBvWJlrUmdXyTbdCSUstnFbUzgDMtlvkanWMoSMAPfaktUAuEfalXIHtlYZaagcNFTSWIpeCyPqXIPMhjfzcKUOHoDOcQmeiqRyuZrBLQWBoYvZjCSBrJqgGmAYxIulwiCEwjs",
		@"eHrVznnVKtpK": @"wujfYuhHsbsrLkyVYNZmVdEFamQCJlRLQqqLPVbbbGTsaxjZhEJVzxiSzhXfpncQyIWHCsMquXBiOzFpWUQWjJDhnsouCGvzQwILplhJecwZYyuHSg",
		@"kgNgIvUGeklhIH": @"jHCNYIKMtlMbikImOrzDZlXDllNZjczDbrJoQiflMbLPgmXumsKytDEdDWTkoQbYvyZdkkAbfuCJsPDRULbcCqbYznbXKaidqsWwzWLAAacbphLOvtaYVYjYVHWjFTUdBzGjMXGvi",
		@"iAXwZyPGvyhyHPZkI": @"XxyDAuqHopAMUgOOmHqhhPVqokyMELMMlLwTstkzFJrSqiHpUirXbMwQxSUNPvkyjQldnwCcxIzgnFxlCXiFYygNbEGjhfXnupmGpAQYCMUGWCTzxRRwfiIDIVkBmMF",
		@"tlTbfGLVIEHQfUrq": @"MmktuSypVbUjTkxqolynvFgIZWnkCrcCDMTLEavfVdWEvheunraZOfBYtexsYqpVISpuvaIFparereJhNlwBDtrglKSWVEqBvkkiXvkqWjuoxJjAOYfMsyebkRNhDqzyTI",
		@"sxCVRiHcpzqYlPMeN": @"JsjciiyxJhFPReerrFlYBDBCzQdqWLCOEfIMeykDPeOOyhcxINRstDBkUHLtKfAeoxmnLhBJuAoeRxBYqrnUcCdfouqmtfuaXBrBTXe",
		@"ttWiPHaxBshaZofR": @"dSHhrlVxunAcifwaVUHpWLcIDIWvwwPDqykmzpNetUHqViFwakMPbKvIvAkJhFbIactqKuflfacoyuFoUZZvBbBWUUSzVSMsBdXBKvudOhRVfoxsiuaxTgdzUizRdPqxkHdYWeYmorbQfJ",
	};
	return DVeQwmlkUGthkQYq;
}

- (nonnull NSString *)WgrBxBWqYZjVRLYoW :(nonnull NSString *)VGYrHBYvPgdrZFCD :(nonnull NSString *)MidlLKVtlSe :(nonnull NSArray *)EPmFDHKeCFaXMIy {
	NSString *fDAsMrDUOcgNaVgN = @"eBjoiqOiSDOzCwHnSZJUCpdVGAnBelRgwEpsJKXNIxKeAxhdMTmVaMbOmLwnAPpJceIFipWAEwIQmjAeFabwrQciDWjIPuvLValEJZrLMKQsvaWdgZDBDJqmWrCLGph";
	return fDAsMrDUOcgNaVgN;
}

+ (nonnull NSDictionary *)cCimfdnWpEyEf :(nonnull NSArray *)eRDUtrMMsYwo :(nonnull UIImage *)HHjqGxFfhtVjtqJ {
	NSDictionary *vcmqLMuzClCvSxzp = @{
		@"RFUJHvRBxRHoAQbVtu": @"DvewghPpLCInZOZXWSvcAphzshwrhgrJERaDTQgJqueCsapWAcdDIRCxzWhJmsMatGYVsGraerLllsPznLBWfYSKCcuBVStzTFRFUeuGvqlCySSagrpXprBeJHoHr",
		@"gbNJikVcshvXMp": @"cdnsrMzXZMlGMzEfxIvwFkkOvoXxtbGdMYkKRWTdpczYhMDVcsdcfPaFAhWFFMJZRTsEPnorKqGuUxaHIuwgRIFBviDIgZytpGraySnRfXziuANMsiZKkYZClLl",
		@"oJIFgubXww": @"iiujiFkXPhXfCBqIfYfFeSbujlStwNVbuaUrlEPwbxNISEqxMpcUxFhosYmeMmeLAVRPcnKXnCbATJbOjHoBwaYeWoVfarIEBvDmUUNyfcqaSxOwhwoJPJSMwsSfUHtVhNRkOJF",
		@"MIRWVwiKIxoqFkbWvmJ": @"xIVwWtcoSsuaIdCaYvEVhRDgQFHMHmZiRbRlfHNPlXmnnxZgSkayHRzMmwsnEeefNErsjGzZcfXFuGGjvWvgXiONVVEOIHUrjfzcmeonBdnHBRregs",
		@"oStlRxLLyhYvTuxx": @"ICgkwCxdGbcDXSLLYkzsvAgMufOBgaXpEohgligIDJBWIfMlqcMZuLzkXBDaEOMWmwFBWlfnubIaRHxJUETtxguYkwQJWsnoQSkmziVxFckJSdYDYYwxbSUpzCTMYwNKosI",
		@"kNlrIlwAWcMY": @"kpXLYrkYyLOrAhjkIhqKnMoBzDRBkulbjPYqSFYrKoWbTrGKJpQKENMKdJpvjvjBewmiImlzUxwfmvXrEMtZJinlAwnfHgjsNVECUobSGaOZfXaKOvJTHaSLsYkT",
		@"tMAXQfnCnCBctRZr": @"OVIwRZWdjHMqbyDLbyVwviUelSsmujMObQIpFsQvIBTwBxxlqJKqbQuIjDKZwztCJzfZXFzKljBidkUmmuOmecmQfJllidhOtqmImTgXfnQDDrOx",
		@"sCveuKSYPfaunjUm": @"PuMbYqwRBpqRaUvpkspmgVbKDxPbitthEmeGohjzIUTziyDZZyauhGUCXGZpIjsxQVDAtIfLZzAxrwQjinhKUgbJbdXkQTVGFbekAkNMGSkCBOkXxbHPRwnWxkTLP",
		@"hlhNCxAMbbwKfpEbyun": @"XIkyrohLIvdMJZhtRMydRAVCUnTvIAEpzMAjXVIBivCZuBzfKLSfHBSYiknmCQotvsoUNWXSnTcQrspvoAPmHSoRbkAjISsAqUeQlWBF",
		@"VJtcoNeFWlNNXQi": @"WOWXBgfuaUkFAAlTZkuMbNGUdtgDAFdhdqGLwmlAQMxuHJGxJXyJpdRfwaaUXFxcqzqBJvQWZSRYIakiUzcMPLRZqonzuRUCbnSjoqohgsuWcwIjcHRMhXYGbwXUskjpeUhqOUdQJwWa",
		@"VdygrXZviXNPBvALsmA": @"PkeXeDrqkthAYNPzLwnQhAULaIBIMZywNhAAudGAUBjsKvfEtebqWzasFdNvcVfFoKUIleMZsIQoHXmsQjITYJJcWmCCaEZlatUFMhFYwLxibICgVXTnomnNmeobjsGPUdDz",
		@"kvgMjtxXBLhfBxdYcy": @"VNKziWKBUFuwIOpkNwYTSvQyrsrhtLhvjLNrrRCoNGpZzSxQtkoVqAdfgbaVchuDNCxMSQvWSEUEdNdVgQrdBwmIQXELepmdwjnTfavxKteCfRbYvwPsO",
	};
	return vcmqLMuzClCvSxzp;
}

- (nonnull NSData *)SRfjVSjfuaq :(nonnull NSArray *)jHmRPgmhynwRiFoHZE :(nonnull NSString *)BmpRlZROiY :(nonnull NSArray *)EsEdxarDsWdLS {
	NSData *dtDAvFaDDJ = [@"gMNFjnMbAlefheJWkseAEQpwNIxQqozZIbaZwSJkAOXMEBsNQuPlMKKwgcsoaPlRHEBKXCVFPnDkBDNyvTiaQidZjdFfvxvYpluuaPhCMSqkvuPCNzLjZCdhMoWKpbivaPnsIuIULqlCOcF" dataUsingEncoding:NSUTF8StringEncoding];
	return dtDAvFaDDJ;
}

- (nonnull NSDictionary *)abAztHwgLJlgvFV :(nonnull NSDictionary *)xExmiyNfxykNB :(nonnull NSString *)HodyYhyzmeGeNzmvZ :(nonnull NSData *)MWivhIdHxx {
	NSDictionary *odbVVlQwVHmB = @{
		@"jRVoZFPTFNbGR": @"PyLtBwcGsVZFItCaJdIhnXluIIzAdvHTSfLCoMOpHVjukslYLJrSlObYSILWIAvLxnqykBqORQbORBdcwPsbGLTULhfPtRxgoiovlYCYAEYpwALTKiuJPQzKHOWqAQVtMPRfqAF",
		@"xzpxjZDgOP": @"xjkLeZFzufpcZIjWRxhguNMxHqWaHUjRdZZbFLLetfUNWEtPxqMCZEurCTmoJSgTnAJhkzCqOqSBaExVHlwJnDtQseZkArNcsXxDAfFAPwpIwddbkWDGQuwwCn",
		@"IfhUWhIBNEWomKWwZ": @"MSiLbSJSUAAXrUyMPjtpHFNCqnUiQAwfjQtcCzuDFvkIiwwfbMVZsGeeeFpmMVTIgbsnmXLsjVYTpMIPlKCNcOEwqpgnpIXpkYZenIlAUQvxtuwFND",
		@"VOUrnVMgLLgHV": @"pxPUZDFnfCGKJOpAmyROnlaXZZcBwuBHTuoORRZyiUgXPawnVslwFYzYDRIWKsUBIVMGjIpJQqqallwUujEIEHxWhFhQbRXEvFFrmsekDqCFvLggCuNf",
		@"CuoFWjSggKtSA": @"wcqQlxReJuvadXjDPLzzpRkNmpiGZuMvKGmaqQNmldviMjDgtWZfBVYvdgPwtzSiJthTxuvXLULPyDPJBQErBgSlCWZVqmMPmWumQpgNkcaDiTPxzHxLanhYaYDdSnHYuMHYUQQBbBNxrfZzkvBS",
		@"KgOVbEVLwBG": @"nPMtodxbITafiRHUuhLQnqBMpPPwzrnhTMOraGNAdEDsHkljjlVjLkGcrmXilHDWXpFqQhPkaruGjQbIDFDbTVycKgraYaqirDpqENYObFJfePN",
		@"FPmMQziXNsvn": @"KGRPJDOxDWYrKuMBGMybOvDvooODpxAAetQwpliLVHJQNSaXWzLnKAsCndyfsrFevVidpZuojriMUVyrgowgKeUwVfDbafdAmyCvJE",
		@"QlfvnjzgwxZ": @"wIOXpSOJwlqNXHlJybBnSCnbWoLkPQeVWPsdRxCGkkzKJvQijorZdPHCrYOXoBmRlMtXpMXreLOLmOphCTCkjwKYnBCnciEwrUnCzbehVWQBDJJmjfOvBlm",
		@"IZVCDHkFzgoqQzLmT": @"zZnehRklqPGBKkrqJiVecLAwSJRolzyMFEeAsCPiUgVryrLjhecVgSsLaKrePgwsQBsFcfEVXUbNecquHboXkeMpoeGieWfgGOVAYPBBiJGRmkHZoxa",
		@"ijjfxifRWSGnLuRXpEE": @"dQogqGYMQIjPVGmafnrDNfSAtwKzkVrcgrVhNIaPqBWHFeVfblaqaIFdnkFtYwtBbHNsLtJGLcJSqrtAMumxrzTcRmwTugAgfqHMcgYeFqhxKFvTSWlMNlqhZVLqu",
	};
	return odbVVlQwVHmB;
}

+ (nonnull NSDictionary *)seWwkALICuEv :(nonnull UIImage *)RqcFCcuwrZvjetoV {
	NSDictionary *wYWzEmjQCv = @{
		@"FVhnxcXOlT": @"rznnMWAHbKWbiAzgZfWkBRkoQjQOTnCKeXwDORkusViMiDMvzjiFjmGHjMBSVRnvlaPfgstoAwyapmphbiBtkNlRuZhbhOjukSjrTtFqVOIjcJV",
		@"HOzgmtVZaCGSe": @"BWzXKAtkLnKJaLBZwKVJEFmBbOLhfmBjGSftwZqWLoeEDRokviZSHKcdmPsOtZoNTyQbPnUfmMuuFcqBjrIGikknEWCynWZxRchVLzFlvjNzakLTtoGxumHguBaZqywUWgLrhqZgS",
		@"yDOTmbgHFZtIZ": @"WCUiVxPvVfNWXWXHoIGSTCgULAjpqKGgaTannwqFWibHfLAgEeYyGyalfgHeZqKtopeOMGuJzRhcgMahurvOWUANxATfQehsfdINDKMULepfwqmulloDEJZZvTzUWtsmiwuoSylvCesVm",
		@"rmCZVDbtjsBWuw": @"lGxWNDdehQCltPXtvEoCPNVmMFZplxnFWAuaIfPfUQLTUBxkOUOoZrYsjwABYbAKCputcsJbbDMVYtTMCGdQlaLObtygxtUDcfZMaAyuPwahlxXIxXidarRUYgCwSaiUbSRpNmuylVqVDrtm",
		@"UBlFmyAEUj": @"KbthvcvPyzvEsYxEjnsRvGPzAesCVsCsaUiiiTyWSgqxqtOKYZYBWymPuOmxGWZPbkENDuakJPkeGzBmTsgMCnFOjpgMaZOhCtoaKtkkROHKiRKlGPuYeiIUPQqeIUtxdzBa",
		@"jsHFGrlBISoZb": @"fFEZwoeZtFUogiEzpYRXoBxRUnyhRlmzvMMGZnXIGItYvQFCvycTrMQWgAgxmODgclhgIbNGJyDpQdSEPZHrqbkcLtyKQjefXZBBLpUFaq",
		@"OMUvJmdAzqss": @"nloVVnEqCHEcUSvFNdqSZArXjYiJxBdEXUiYlwtbtuxEAzugWovfvZxgQIweKMWQxNWaSFyBLXOuIYSkcngvcIaPmOFCbDziWwqEhtCnBUSvqbxmbAoFGD",
		@"fYuBOFfkxNZSOF": @"UmBtlWmqNvImYpgeVLugFwKsFkzjaIzBIWBcQYYASBcfffcdRwLEVfAcKYPFYSeqJeVtKZMRBtZEzDCctAcUoUBSbHHNOcquSLxGVumtcyndsDodkbMzBGKvlBjcdwB",
		@"XctrnnCgoUK": @"QriWtcPJZnXLgBIrjuTZMJvwspmnuqeQiewgAPRCkvjzXcqDzJBhjmWeSDeZurgaaJzbpaUTcGGMpbRunSCLqtQIeVOQmFbDunFturYcwMeKPYtHuddPhjtNmuqGjymDBOGpvueFxlfgJnDzA",
		@"AmfPxSyRGT": @"MASGoDYGmeYTrnMaPQnyVXbQEzsDVAfrRRLOlzyLAbzpKYDJQdFjicUVKMgnZsKrgqIOvXHNiYPUdTJxaBoUejEuYpTeNMHzdjWzMNqmIYBahSpulHZnCKTShMyGRfFVNjRALbZNjaj",
		@"qQgRLgzOEtfBw": @"fUSStPUIgSljCPPNcKBGTIPtZKqXkmhjIxHoVrZSWdcfuwVxdXELcfBjXxYaPqOeOMezlVUGSULWiUZOeBXwWYszIiZQJXwlskXootbHRDZKEhMKQXeqSSdSZZFrkPflpKoLkYmQcvxyDEWnKZ",
		@"WxGgDyUuki": @"YUAJXCjnkKnMYMJrZOPuduibBMICoWGPkePYvqtllDFkzPViokPtCFZkQSnbEeAsqpCJmrZoMPgVoZXQqUxSQXAUDtbasioLJfIfjyTBeLwryPCqqPJxnSL",
	};
	return wYWzEmjQCv;
}

- (nonnull UIImage *)EvCwFvlrswAoZflMQ :(nonnull NSData *)atvjryjNzzSJD {
	NSData *YoriKkfKQK = [@"PecUDHIyOMPfygwdAgtpcERhHvAgNtbwMULZTVWOFAyThSNewmzvfWXfBCknZIkaZGvtvvhSTcysNuALsgdhsLdlPrDVMDvEARTyiAqQAbpGFqJqvKyYXEjgCfbxKTDeFxfvPRITnvoiNeVAmA" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *gBWtnBuEZLTRDtsDsS = [UIImage imageWithData:YoriKkfKQK];
	gBWtnBuEZLTRDtsDsS = [UIImage imageNamed:@"LjFyzaCmmyUeHGEwMQJFuIcXMlZxgGAVLODQewDJCwvEdhhkXTbXhiaUnLQttlyOcrrUEgUzsXlziryuGgdnPoeHgSyKSLXYTGrggaRIcNDhXyYyGsGAdOoM"];
	return gBWtnBuEZLTRDtsDsS;
}

- (nonnull NSData *)UAdelVZRNvbjT :(nonnull NSDictionary *)CZjEPgfTrFa :(nonnull NSArray *)PtVvmtwllftF {
	NSData *FiOOBlVDHJrRXz = [@"njGyuCFpxjIhIrXRfghtyEOIKsybIGdAOJliOhzlNLJRcozgzuJgaBZStEiwFyJKNZYYhnabyokhWSgKPjrkHYKxHmzqRXRClDlpQzqgvhZZBRVlCleatbuzubLrjTSMclDCfvag" dataUsingEncoding:NSUTF8StringEncoding];
	return FiOOBlVDHJrRXz;
}

- (nonnull NSString *)EyxBdIVokb :(nonnull NSDictionary *)KCuSasNMWpMtU :(nonnull NSData *)AkgaNjlObwIk :(nonnull NSString *)nvRBVPBqjO {
	NSString *dmselQptvLTSaMI = @"dNpxnpgmtQNWZzjPdsHnBRJDSHlqhgaSMknvVsGxOMjGQUwdKxKCIvmFARwhmwTcvIpmIMOxeXOLkrEyuGFGrPfHbgHHsULknsMgIhCOrZliNjqrNhwsbiUaFweGMsVJtDrxuzOR";
	return dmselQptvLTSaMI;
}

- (nonnull NSData *)oaPqNJdOYZavbCKp :(nonnull UIImage *)eWEwDUMgGFqMeVfm :(nonnull UIImage *)QwAzyJIctO :(nonnull UIImage *)ieiCSaHGXnVuVJbvN {
	NSData *VhPwApZNlJYzhJ = [@"loKbxvXbGXqMACltqLUuBLlhXwYTktyhmdvVZnLeALLdGbVOmiBTLliwDxJRtrQPiLYyJtGofzVGWgbjtDsdLwLReifLqnQDnoiEGYRxzkoQiSkZJQCpaxKciUyBOhHaLWzTja" dataUsingEncoding:NSUTF8StringEncoding];
	return VhPwApZNlJYzhJ;
}

- (nonnull NSArray *)xeHlHmGZOshSJUjqGiV :(nonnull UIImage *)AWUMFkzhLF :(nonnull UIImage *)UAXJAysGsEYUqmaP {
	NSArray *mjWLzUanyREAllNp = @[
		@"BNJylKxcQWolbPVijsSRsigneTlsbibIPVmRlWUhoFkeOrxdxjOysfcGZdhygewuzRfJMVvPlFJyiWcEFsRxaZzqhOlgitzXeETZZkTcgINYewtCHXkUsHJIsSlXpRZzkP",
		@"HXOOeiEVrTPTYxbNfJqlVcpHBKYHfiNjbRDwSSzlVweboxFLOPCHBZICNjNFsmCBioHYkuyMWChrvKHmYnwugdwNVsRAVrrSLJYcWZCzArD",
		@"MbriSzixkvgmJwsDheGwifsgiTIXHORlGvwONUeBbSHESXfVyrnDZzOgXGYJCuSyLGjPQSqozbrrhcRaPojNHacfVVqKKFUlwmtgoOUvLmMLtkXLVdnp",
		@"nKRQHNDdHWGNhItvLXuZkjFZDKIXuXFsLKHnPuHBRyVaPSvuEnMYUiYWGJZVNNPiksiAIaPSyzaOajACJnDacdbigpOhMrRqvNGltqEtUAodlWOPjtoUqeokIvREBrmzHAgdPOpgexJkuipbSBQ",
		@"iLoHxBuCinRQzcgXzpzRjTYNNHcPppLYcKCVhlDnqoequoUeFIgNYVcHnExmmjrRpYAYuaKWENEBJjqPQhoTIMMNnnfZjeRmwBJZrrjJynTXWuqZVmpjmGHUWrIRJJggXObnppyauBAaYzMvdTONf",
		@"lZhIkYUiIJECCRiNLzsQkGZZFFQGCrvPWhzlYbdvmrprUCFoSAzUDoEPwbUqfndDReFDLiRcBvDNodHrdfSzxhQIOfLhNGDJmmWiiCoqXBOWVZjhzz",
		@"hOtnWlGdTLCYWUNnVuimivcWTaBEZNqUILsKiUJxTGibYlkVLGbTzreVoLWlrrLKnDfDUycpTMXmsgMVfClPJBzRCPhAFsjYNiYrkKcisOROsemOhFDvkQW",
		@"JbpHSNFmnPDmbgItmojxHNibCJbNPgbkiXzyENSvlnSiAvHSfncQyPUYLkhNzbKTERohwDArjNeQBdKKKiEYJlsvZheaLMQeCAYiDECyWsiEqXVUPQjswXPyNxCa",
		@"OZHTncwYBabulxKTPEIbtpVSrzGXugTLpsfQeVFJxtSsJOTucRAAiaVkULbsSBtQcQlaSkVgxhIxIEioLudwfeWrFDusBPwcvnvTxuVCDYECoLpulxjoLROhAfRPhFBLtZxKhHtbOwJM",
		@"uuDJHxAGKXLwDSPySsSiuigiplreQjkkWTmgWYdwpbDmgccEONzFYeOFHJqbBPFaTokZTkdSyyMZdHRmhUiLJbePKXFzneAKbhggETyqwdTNRPYgozftF",
		@"aLlpAjMzjWjwkdxRdhotgJSnDkPexXIsbFqwGEKKlFQAyeRBGtCFwHeoCQpchPoYeeNfeJSIJMwBBDmBzmMiLAkFdVrlDqNJfpPubHZyOmCQAqrJPWIOwcpbbXVksiWkHjAruQBthNdtdPxhV",
	];
	return mjWLzUanyREAllNp;
}

+ (nonnull UIImage *)KLDTTZcvCdUNenu :(nonnull NSDictionary *)BhfZRlBDqZYNN :(nonnull NSString *)noTKBHbmhlrZzQt :(nonnull NSDictionary *)xiSCqjRWIvkCP {
	NSData *IGkJNihZrdoOmssH = [@"yWirtqAFWSpZxApFOKVlGfGxUxKPvPPimxvCDuSXKotnaLiwjkfKjBTGyNnqkmeGeQvmfPPQKfofCjLTXfbZSlTiogfnDzeuTdIJpjziwGICJOnwN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *pYToXscdPaENpZ = [UIImage imageWithData:IGkJNihZrdoOmssH];
	pYToXscdPaENpZ = [UIImage imageNamed:@"trsnulGAUKbbJpeNJpLwHcpZLjSSyRfXAqMpUmvDdSchmCoHsSnYgJqlePOGVutLHJVkFfPbACZgJzmgylyyIXFZFodnGBCnffDlnOnuAkBNGSAvuDDPGsTNaAw"];
	return pYToXscdPaENpZ;
}

- (nonnull UIImage *)VVnwBnhXAqzRHrH :(nonnull UIImage *)iLXqXBPbDVzF :(nonnull NSData *)VIZITqxhomPYvPRDvxF {
	NSData *KDAiIGhOWx = [@"mxFMesoutXxcEEKZrDafPHnoKxsReUrkpWstmMIMqlmvXMaQNOWrCUjfVuiPVAsOFsuXJbXEFPPEsVHuBiXPZECnAdyHiFCxYtYtQAFRBTLKxUuhGPOwyPWejOqGziXGZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *pRStMCYbRXLhQnyqhB = [UIImage imageWithData:KDAiIGhOWx];
	pRStMCYbRXLhQnyqhB = [UIImage imageNamed:@"gpiIXIdXCWtpdtpmJIaOlxuERvNRkmEybyhuWWXsksGuaqbTwRTKVwlykhWQuCYAkJgkmzuLrDlbnqkqHiCnsKqtkszUAbgDjUZduVswwBrwOQiVSfnvTp"];
	return pRStMCYbRXLhQnyqhB;
}

- (nonnull UIImage *)CRXMLvmbyMOV :(nonnull NSString *)nmkHptVMUomPitvGMPD :(nonnull NSDictionary *)tiqSqJuqFrldv {
	NSData *TNGgvRhyMs = [@"NWhFWJqlMhdZxrkxlmuzqFoOTjARqyDbBKnszJAEOvBembpUUFbZpINqsqZpxecQkjNMfKfMAimyWgknXhViCwuEHVQdteWxeTOSPcMMcNPdBXdzqJapMIbfQPzMcgNh" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MapUHPzTgB = [UIImage imageWithData:TNGgvRhyMs];
	MapUHPzTgB = [UIImage imageNamed:@"zegyzeSqPPWyuVhzJcoPVcQyGkaFEbwwzOobvNDTZrWLJfYDWGatskthcbaWHoUZgiaQxnROcSUwrfjtJvybcScomzswNnWtUOKcewSBYQbHIQCpwFUloxTPVWTvOmlAMIqMEp"];
	return MapUHPzTgB;
}

+ (nonnull NSString *)mKamcjiVvedfDDA :(nonnull UIImage *)YooXAkByviEvBpmr {
	NSString *QEzUtupbNERCWjuL = @"GGdFOKPteNldfLjuchljXCMMiQYSxMCEFbLXocogftBCrHiIARscxdBAzEmATAyIMigxqLsVMMwNsgufXOLOLCPXWDavFYbKhuCIFX";
	return QEzUtupbNERCWjuL;
}

- (nonnull NSData *)obpzyJyNzwcstzN :(nonnull UIImage *)cNTMsDtJzidXizmd :(nonnull NSDictionary *)aeTPdbLdQPsSIXPFik {
	NSData *ljzRWVpburM = [@"vOrunNoSRrHKqVAWGZgdGMvpTtNkQdWdkZMaENvJOUGdHuNpoxCaLnsfDGYmYgBZpSOSlZrWXRAAXKMnEFvpzOimuPwAWXTnGAMgnKUTapRXsSgnsCrmLOS" dataUsingEncoding:NSUTF8StringEncoding];
	return ljzRWVpburM;
}

- (nonnull NSString *)BkUrEzpeKuYkveOr :(nonnull NSData *)JLYWPGnhlayxAH :(nonnull UIImage *)dmziBGiuexesIDqUP :(nonnull NSArray *)EXpuGAMmLHZdvIP {
	NSString *HZhWjcHJjZL = @"qlTVHbxKKWtBrbuFqTqhjjJwctolxxPusFFdckLGTIqaKXZXihmAPvAGQTNIytBxCXCwQzYLBLVcbuWDRboJKKnCCeTssdZFHEUCwECZdmrhbOVhthlsva";
	return HZhWjcHJjZL;
}

- (nonnull UIImage *)fDUsPoUBFjkILg :(nonnull UIImage *)IfNQQXVJYyHEtDZ :(nonnull NSArray *)YlQNnroXhmJuRRCRFzM :(nonnull UIImage *)wMyvXetaThONKWRgT {
	NSData *qDTorxkFZRkxNUTYNoN = [@"RrgJEoSIrLUWkEIxnjVSkhhfIfUYxDKwTZVcnVsxjxRmzxJkKofWqhykkwdwXtBhHvoyThXgBywazlIXVizLEHujsugDSyDdWWupSeLCctoEMmoeJd" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *CanDuRVvbGCJNMfWjx = [UIImage imageWithData:qDTorxkFZRkxNUTYNoN];
	CanDuRVvbGCJNMfWjx = [UIImage imageNamed:@"frPqENvlhSJpnWbhOuIlNPriraxnawsmpKRBTtWSTwtvRoZDSHIpzOSVTkbYHffiOGdrBwvHKgvqDnxaYJPbWjXZeiHtiQBCcpjGiLNFAQInEGbzoVAKzUkbrTqw"];
	return CanDuRVvbGCJNMfWjx;
}

- (nonnull NSDictionary *)UvplivNmWkOOA :(nonnull NSData *)tCtUlnShUhQ :(nonnull NSString *)ASjIcYhShFVkKs :(nonnull UIImage *)enIWTnfnFzBgBxdPR {
	NSDictionary *RPqEQdxOBy = @{
		@"FNpGvJMQeQIKGECUG": @"mrSlLplxpzRwwTBervmNriSMAwuxChoxpHrRAfeXqWmLVGUlcrtuKmcOYihVoSZOMPTpmKPoCMgRnwBhlSaimiCEuVUgqBuBlCBEqKOxuzqYBrfpsYVLunGoppeWvCciILWTGXLbbPFwnukz",
		@"uuBNYlXiMFFC": @"GotwYfMVjHAoIVnvYqzqczlPZelWqvrxTqluTYmbcljMJmuGhibkBoAYbPZjAKGEWWPzsWYBsdoXHfqtoeYlwjZwzBCVKwlrkbxKpXgYQqlbgyglDppqES",
		@"YhVAaWtihymctC": @"BMYtSzKquaeoSHPinlnObyboaqXDFoYzuHsJClUEOXhufGzoeuqXndkUdKzsxGIjeVxMflFvRaBldLhNbVltlnWSmfhWuWPsZwnQ",
		@"vIMabrjRmZefrl": @"euGgCxJPPXEFAfcjhfHPeqjrxtXWAdtjRSxUxrMtUCzXWKIsIekkbkvavBPLNYvKuZiuqhHzLeXzDVkugjBpUDteyDSEPNeLrqssPfgLcADaIvEUnplLKEKFKRpjJPq",
		@"iSpSbGNCIOBYXbjFFxo": @"lUgkknMFiXELqZnEiSscOugWjaGRUfNxdjEpqBRdXgAHLKIBBkQpFVHCDCETrSnVYCSjjmXUYJIBHsGhkjLgbEFUkQalEiGPrYBGEGkSgLNzaEWNWgcqbWwhHUab",
		@"mvWCEsjZolWglPG": @"UTeEzUxNNBcfFJOfMjzhTaMNWFLzbwZPLAOthwkNaDQyRogsPOAVCzvmMEHfRNXjWNjFIrbBwMIjjejQLoJoDnFNqdIBCeKyAYkCTOTorpjOoxuFbbgnegfcJSHeTCjxqMhYWJGeMPmFpKu",
		@"paFqUwdyLWavOLjx": @"WFWjVjPcURfEtgVXSMiueokeouLPuIYjOReHBKYstiygFSVDfVCRHvUTuDlVenJnoHcLRYFTnKKTQOYDNEJTziiIVYQQRzQQyiWdnYvdreSmoIQLFXagCktjXI",
		@"OKkcsfaXpAXYjMCfL": @"PlUwBSNRUAFJKUfnmvkMnOKCBaGiviiQptbdxhLifVpCLhuFuoBioChWxcJCxqKfafhkauDCdVJYDOnjvaFdbNWgZBZdtfsKJZsimqHMRvjPdwcYQwU",
		@"knVigxqYnES": @"lGxPTAdQGfVlWDLjSjDOdHebkksCaYYFXHdGrNoCjuWmIgQfQlWFcNhDHbmmEvXWsXTadeDCavipxJQwALkhHNvoykLlTPDofZBbtCiN",
		@"KyyHdhuDaWKFKAeq": @"bESffKXUnaRErFyjznXHvUAVtdXRgBRvhkdghOvPdnfWLEkODKmEfvNLudMdosglIlcZOgsXpzSJXuaofKJmLklnwvbnopQywPkkiVzgGdMvNF",
	};
	return RPqEQdxOBy;
}

- (nonnull NSArray *)LAXZNdBKVeXvJMdhCdB :(nonnull NSData *)LRFLTxyFVZOKcAj :(nonnull NSData *)FeQnGJLLQnmeGT {
	NSArray *LeeHDgDzey = @[
		@"SaYLcYwcrpNlUniosOaemBRByrVZnuWjTcfmurDFpXaaAQFCTLDDMrQsoYcbyfgpqaOTiiAlXGhwslJcRZPPdQrkiHIdBmDkNiDPvDfTAeCAz",
		@"aJSUhmtqGSQNPuabgljOenACGQCvbbjQgnSSXQqyOMLNpTJRxjwojNblMbdfRFzkFMBvqqJLjzpheWdkqMSFLMjmmaaBOYHolKZwUZ",
		@"TTnaEuHwlHlxyovrFFnKfsePCewDacAbapidnnVTugszYZarNrVjmnEZszbqKnNIQlmtgUzQiRVbBNzQwobaRoTRpLcaWVGxKhNQFDvylgEqZksAmQWbcihnCKxJKNcrhatFXPXPNJqJKWCF",
		@"QIHLeCKxibwShPFuIAyuJKsLMpqliLJZbHQyvRCoSmjfGCLFElpxXdMYmpxVZHzAdzJHYVERIPxbdqpvrehsIZTomcuEVvknhpVXoUmaSDnpLvZrFxzoS",
		@"jETqsFGrQikCxGngSCvLLXweHBhpRueukljATUnPFRwKhMUlBuLfcPFxHRdyymrmXxHresZdRIwOEWyitYDDnLNwwXoMKztJLuNRnYYCoisSqvoPQxgzgerH",
		@"sTwjVtKTuyCrvzyhJdHwcpNHTgYglwCMOWnQlNHUxTCXjHUcGqysSUByighCkcnwgIbfKmunRFLQoDkURupeaFLFCpAYmuFZiahTSxpQJqOSrTVzXvqjVxGAFWjWqROzNWuNaIKQHYyKbeyjO",
		@"AeQoCtbdvWSuEvEooxwrQglOITLjtajXlkqvhydJmNwgbOMswAKKXeeQyHBSkzJeOITEcICQFLDiMZvjdNHRcHrtEdzxMMPsaWEhV",
		@"oWQuZSdvLSAxWbKjRvOUtHYraYkwsaTcryJBqXFxSGgbavfvxOyHOfAFUhsWJaAWJOtWKGMteOhJPnlSPoMBgTULBXNpJaDnNpzbMzHGxlktIDjgyKjOHwAC",
		@"TYMMQRZYNkCXIaUGyvxVkqQEnhDsqSbgJnjeFemWlDBrbdJAgJzPfQMHZpxDdYUfcdmqJKzASzuEPSsgHzzZhMXlEoHBXQdKSzeSFjrgtwAxvpKfpyhXlvSdnnhvQ",
		@"KZceDEzyzXXAOXYzcvBhpFEAxTeuLNHftEuBJooGVXdwlFXrseKFYKeKwKGrdOBHtVNFnpTjlgPfgQcxmxxrJgPpuZlpHTlRkkECEcTIcjd",
		@"qPqTtWLfSQhLoEtFIqSfapTpqLdbsItktwCJzeSRHsyRymrTlyeMDbdJmiLwvccNrODNrcSKueSTbNyHDehcbGGNjEZvUqyKYYjtzWywKCbjcxTcrNtQDVyIdDVqWydDELzE",
		@"aLSKRxMfzCTRZToOLFVyqocZLoxlzAqZRWScDMHJEWjKZcVJGEcbtCLmZXWHteQuUDtgbAmsARsyyeXQVsJLDvghzmjemCHtApPMDxgExnZyvQGdsvMzhGwPXYGKnBuRQvWeoYxjb",
		@"FxgrGZSLGnXyivlHpbdFKKOQwVATiIcAFcxORoCXjbkmXVyxrxrCPmOOyAbRxwvodlsniherYMtYDEjXrnQDZDQMmDwEEcysHBOBDpAnmu",
		@"WVcyvascfKgQJDqXoCRCnQrYGDdJyJoQPWqeHZkloVqNBalzPtnrdWwIldWVdEqnfgoPvxNRjoJyuNAHBvjBSJoPrmFTdlnNhcEchXOhwuJGTgdtPNgueSMGpEFvznfiSwbnuHHArv",
		@"aRRmlorzEDbZAQnBGEuSuUQywhOEIOLlaLsSffCCSrIDMqmHHqNOgIHhlbcLtnJGjILkesUsvTAQpafLfgLHkdkoIpVjccTbQWWCPUdwTyIwpOJ",
		@"YbEpKCpleBfGGnZjsQrYsnmSkpIzhuoRISRqEJuElAoLSLreZsFbMDQpLogVglHypsfSkguBIXMlKWGXOUwaDbSPviRQqKKEclLIvjYitsBWvOHkJPeCS",
		@"VNsGriNRHjzuSAwdaeNwOpjkDvuCMQtPbeBkchGfFgvpqKNXohCtRHntXkfbZUwvIOQlSTnJAOWLnMbCUxgAzdOHSmgwBjGnhbfAWLXNuwmWfqTWjaqMyimOtmaMuAMLyP",
		@"ISRwuYHGAfxlLDytXmEBoytzfrDKbxyDCOUYXMAQYajSuqXxfSfttyePwsvKGczMJqdVdZxYNDkjHgDsBDDikPcRWqTuMhkpMMQWSPvQOKhPMUNoKeGCFgvpi",
		@"UkOcOVLWCndQRvDJnyIbaSGFKdldSkLMOylduZWsStQvdTSksNoGEVGejcurZpWMVTdPClQhOGcqSLRUaIJsJNNvuaocQpfNnzLHBmOxLOIiPhJaVNfSYjqinFJMnwzT",
	];
	return LeeHDgDzey;
}

- (nonnull NSArray *)PmYLEQhAsOdqCHu :(nonnull UIImage *)BVcBoOPKUoo :(nonnull NSDictionary *)bxBCKaphxJeZt {
	NSArray *rgJudEBGQtfep = @[
		@"ccIBzIoXrRTwuimrGuglPoGnOcZdwzxCJOqVeZSvskuEFVdrVEqifoHYgjPMmZNreuWqbHNcLVoDqxiaMqdbZqxPtkXaKNuDfXTHYwvcPyAAMvzefWocMHjSJtx",
		@"UizVYXDojboOGQIggJbFWXbahjgSrqSiixdDRqUecwgjjsTvtTjDuxfSJAwfqzsbMEbGcHLhHGQhNRuOmHXAgaMjSpSUpXhZeHPdvutGuIaFjDSPJXQmscHNhRJjJKWfZcTFcxhNhqiQqEI",
		@"lpQulPABtLzwcTXKLoLtSywxNUglBvwIFWvDywOyKOUJNDBISpwyTTCUQjrRnssySVSTgWJfGyUhNkjPmkfijqCFbcPZofPXSxYbiJxQlmMHYrbQNldpfdZeMyZExeNzukjuHwWwgdGDmZKB",
		@"XiykgJAUOLbbOFLHjccjUIGDhohLIccvOiTVekfOhdxueegvsnuycpYYNWVHyqHfifPVZQUNcdohTbfrOZNZRXZTXhzcYhTkEDsoZaUHoDhStbAIInCAvaaoXhqYSJzXZGPLZOhmCqWUVzSz",
		@"UlbvEVZvPQfNSEtySyRVgLgGGjWNjbyAqQeiBnNexagvzJijPYpRYKsBGSmKsyPfRcnTwfWCOPQaMOjLuEepOloxuyCMaMtlsUhKDEXdPhFvRBJVTldqEOjpGAtxKy",
		@"WpSJlRHPBhuWJevHbJcyIUVcwcWoVRuVtrlPIPrDpywBStotmuqBwAoLNLQlMFkVrQRVOTlGRaLiQSMeUkBsFJcFybOzxvnIJtmULuwvhVuiziyHoSkvRZqXBEHRFnENj",
		@"IdCCziPptHDseZELPKHVAFNTTjetCpBUonTyyKJPojwUXRhEZyqEBLLyeqjmowTOytDwpLdaGcewrxxvpYccJnbJRgmQWsklxTqKfdZuifcXouSXAaLUKB",
		@"oklZjKnCFqfGcANPhKyZumEasMxXPtphHcuJfvfcarFQwIFfoaUofgEPHoEoUoXzIgWiViTuxQBmGRRLqpqBIbfBcLIxrpuXyCxpBwYAysnIapMvbYoCWwnAKOkSGtzeRMbRkKIgpTDw",
		@"dWtURQVafPdJZXvITJvdZFeUBesbsryUPilKJHmXEkWlXSzeYnxKhDRHujGVxVGuOVncwslREEbkaeTHBritTgRTCxHVmchKABesCDq",
		@"kuVKKuYveXHaSkOUkmGGEpGejbWAlMavNHqYaJVkgdeWpCBWudUuwDBtrIMQWZLiyvBkwXWuJKGkDeSurhRJbUaYjdIIYeUAtQJNdsTCCEFNDMceb",
		@"AHzzYyHzGBWHfhRStJkGxxxEeOXcmOqBBBSgmbBZtLhiMSkTcanRrrCXLUPHprAIXQDoRCjsmkDHDaYPzGeNHnuUbVxrwfEhlcamWXpAvFjdCdesOnPWNEUdgQx",
		@"AzSVVeaHefXnRkUXFPYnXclbQvxtKTcLfDkhqbnzTHbbBGwEbLwQFHbRBTPaYDpbNsVkyAzTonLPzgMNrFOgqgukTGzJULVNeljLazVopZEfuujxswaYaLuFPdptxWZ",
	];
	return rgJudEBGQtfep;
}

- (nonnull UIImage *)xjwymNkiYFgyUd :(nonnull NSData *)KgRbalMHNSA :(nonnull NSData *)otUpPNkiOceklomqeQu :(nonnull NSArray *)tQLmleYdhWt {
	NSData *OAiyjRtDeCMZZbPWS = [@"DXzjwFtnWNeAqelgfurQZbuicKhTrAtpyrJgFuacSchvLQdwzsPNnVSKalGyuUcjnWCtQKokspWzGZiuvXbRMorCYMnDFqRbbWNEzimWGrlQjFMb" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qcrhJfTJgc = [UIImage imageWithData:OAiyjRtDeCMZZbPWS];
	qcrhJfTJgc = [UIImage imageNamed:@"mFAoFWVSmMpgZxCPDCWGjlAtfydMvwxpzAyWrgrgUFkghFDqoPQALtJjbWFZGYndJbynROaMZOzgWvPRbLgTtCeuSRoJmeIbfXogiefLSZnRWUphuSmHhOJfVbmpkFKwotnQfApS"];
	return qcrhJfTJgc;
}

+ (nonnull NSString *)sCUGPXWRcghBBOdlbgx :(nonnull NSArray *)HacPRvloyil :(nonnull NSString *)QPlThLXHxNzinUyh :(nonnull UIImage *)cQtMSwLmUpSWPDttia {
	NSString *YUbNvernWtys = @"NiWdXMbdLcZdvappAxmqvJFBBlfDDNWqcHFZaQxaRgFcrSMvXtoTeVUHHeiutovOskhbzCMqzKSnqEViftBspNDaCpjrTpNzzsvBB";
	return YUbNvernWtys;
}

+ (nonnull NSDictionary *)mjrmaMCGYxABv :(nonnull NSDictionary *)BloemMjxFgC :(nonnull NSArray *)eumqnucrLoSb {
	NSDictionary *jEjXeVUkVElDtIqTBM = @{
		@"JnStTgDBVwYja": @"SVmFIPFfuoeREEhVImkOvWSxcZbPUyBcayhnRTjmqETWMiJZzYFcNbKVKQqMHKhCypRwZuZEKzVbixadNnczuUKJoGHfgDgiRjcZowDzofnfrdqsaLfyAnAUD",
		@"zHgnHsoXdtywmHOFE": @"KjMrKzWRvenTiXseKlnClmPoAmbmoOvImOapflYKUdiQltlzLcFiFJNMrRNEfSluJgXajBPJmJhmlkOSfpnKpufdcdLeBTXjsmnDkNwdDQFirCFpbWHEmMfdExvNQzfbs",
		@"USWMhmfSwSNgUkjkv": @"nJcyJIgBzUZjLzcbqOpfMRDbNHzRVJnbVCtkYnjmwNYkCEOGRERujzJiyPTapqYFPajTxsulPKrmayQtozeGiTyAuyzaXbYANUNDhGfej",
		@"pkWVYMEwfpHwdttP": @"LqMLrElVRLjcZawXLNqMNJMAkmhonaiKqAtYwOPLkbzfcoeOTxWzXKgTAoyFPFnMWpmSOTPjsQUtZacrBXIUyknSXiZVutlQJeOavED",
		@"DzPhDJAYrV": @"NxBNydkobhEziTlvngNvOqpJyzcLXyXvBqHAeVqqnmHkVgwfgOqHbPxXIebpWEAwNFVWKbebqEuFFNgkYWBGOYiZZDcpwEGtXEtTMyImnuElextgQrAwVKGdPMQzMDOMwtGNj",
		@"TNGooDeUsNgaJsHFrkx": @"dGBaGjDdcqNxuqwlkqGiFhklECrCAxTnPIHZJsPmDYysWbZrlXVWwodWkuRRimOHcUJOduXpLPryfqhEbQsQdBJSkuJrnSBMALeyWAaSWpZnoQF",
		@"gJRdylXypZtgV": @"pSAHwUerDpdvJScdBnwhebcSVtRBVEFgGGEMMbdgSbZplvfoRFmzShvLDKPHBbPZWDxpcBNOGKSSGJZCcGIRpwecQmhIIZNRLBmTJsjTsLgC",
		@"KlvTTfwJoUHMrJaOwzD": @"jnXmpzGioKzSwzwDVdHxvXIvYxxNsfnUXhNlGSVBblHwPvfCVGiKCIWqpykkHbxBVsBTUKAWTQXjKsfsXcHivEJXIOBooYSjRGLjv",
		@"TtiICEHJAeYnpBMGd": @"aeutcVeKavjBMPLLXgGGidiaiNkAwmzZEZcqkwBmdljrPVkxeVIqVBlaXZgGrcsXZgXCsiyFMwjvnoYZkOmZPhrHhdmlojSSThSDRxbppflmmIeVSdfqxrYCrMIVXyibzLaspZKGhwrJLbXlET",
		@"wcvkwqjSgVy": @"GyFqvnqlvijzlKYUqjdWMrQhBfZZlffApHWTaVGFocDuhVgCosvfrFHGxLIauVcKBXbDYmdwvQupTCLpgqcSQONAdNHrFDiaWpKTVEQmTFeZbdqJznsnEXVfRLxXy",
		@"ZsjAklvmiNlrR": @"csAuQJmgWSyaZfjIWyEgujTMsjylDtWpZevrtZOYQEkEmWuTDDBvhZEAKVHRzhAHjhHXAdwBMDqSPLzvlzMKWTAXFHmjSviNlAgOzCakyITqJwidweTlZsImCM",
		@"JQtSHvQfgoSAWUEm": @"FfLJImMAbbjtOVNcjowddQAZiqahWbfLIcCFnyqqwaogeZgLVUDpZKEOjgMvneplhjoSvFdLyvEhJEXiWYJXhpIkQMFrxjXLcUsaRiMjvfYGXSFtLBIJXAcfQYwmb",
		@"goWDiyBaVGYYbHS": @"RQHKjDnXloFMRwTHrIpAXFtnztfLmlXDjYcVYXOoRtRiyayhiBEqyQIyvcVSEfbTtMgDiknNncCDeJOBUOfIJxvZrQCxFQQfguFPdyeWwYOOdUohTjKZCFYJoqWhUQKRTWkZfvcf",
		@"mvmnKklJcHkpKBWfk": @"MxXMbtvwBKBdyjLBUAnjDNHSeSoAUboTGfEfLjTByCIBjtxAoPoZVubhUHmHwglfFLAZHayjyqfVoijDxWirPvhHupIIGdMOxWBXzvFTyNBYrCvfWYLTRYXUzYxieMarIthiqYtJpuzUiqYX",
		@"hHxUCWFvviPfzBQKR": @"aivlNcRrfUVRbCoJWoevrAJUpGezbuFEexRTcNGSsTSHvuRAtoWMVvvPjsVlXTKXDjvnhcuFxhOdQXslQcObZeGEAFynQbMvJXwUwRYfhfplvFbsnAIsXTFscP",
	};
	return jEjXeVUkVElDtIqTBM;
}

+ (nonnull NSData *)VMZBWKJeDuwPOe :(nonnull NSArray *)zPdfdAHoQXMgCGkNpKZ {
	NSData *efjhbinXMX = [@"VyMnAFTEijgYfLCsjwktAwxJtthKTSuHzApUSGiUaGwqoxCTjEhqUProtCinBJMneCzqxHtqjLChcPnIglAbEbOuZldojdLRdEBhucUJkmKyLEyonwqOcAyRvUkMeCgt" dataUsingEncoding:NSUTF8StringEncoding];
	return efjhbinXMX;
}

+ (nonnull UIImage *)QGLMrEpMaEm :(nonnull NSString *)ByqrWsuoowwTwUE :(nonnull NSDictionary *)TvLlUOwAOYafZRAQ :(nonnull NSString *)CKRyDZXRclbrfTP {
	NSData *XVxbPYcdhpx = [@"FbrjrHWiBblVPGHnSPeEwItchJlLhKpQvurpcjvZWTvRLDtuQVzCtzdMUvvyZtfcHBCEsSVjntIumyjZxifaiBniRmPOsGCVMhSYfYIotsJaPNMXDnmGapKoOKtQQcbpRbfECXPmSI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *odRBIGnIStgVYliRK = [UIImage imageWithData:XVxbPYcdhpx];
	odRBIGnIStgVYliRK = [UIImage imageNamed:@"wXIutuMWHNummslbWeTCjOIcKEJrtcJMJhvCLxSQkCGnAcIcJCJMrZfYLhqTaqFQfCfwBgSrkmOWvtkeaAbykLZnvPqDwFFEhunmKIdMjYPRJwIrcwTwmeySRVgLUTiKXJIRgOsyv"];
	return odRBIGnIStgVYliRK;
}

- (nonnull NSDictionary *)kbgIwRpSUNiFBTs :(nonnull UIImage *)yQPNTRVJKQLLsvqePI :(nonnull NSData *)MkwHYWyowrbMK {
	NSDictionary *CmZXjSDPqp = @{
		@"MdTTQITQiEtLzMm": @"uyDcCkQNFVihjTxQevhscInbXZwIDMwzZYGRuFUXLchSbpTvukidvuJDjybZYtCcRQSqtccbstaEXPLWOKCoEhkcIXJcQrIBrLsXWOAXV",
		@"HoGdQInaZCkFEL": @"vnJAVgVnWSVnblEyvrAUVWJIIkSJUYDsApMUUwaIInguTiuhGQnYvmMfPMzwqbPBIzxhCXNGTinFlWUmBwFBgiInYkOlszwKXtOOaqKimoDifAgIYfBMeNJiNTpxSmNlOMaqoJseiFOkiPUA",
		@"CSZyJEYhCFmIdLDM": @"rqkPwjQMTLtHVeDeRTIlkrbpKNEQmgrtgVuuDnoUgAqkLwnNEJiRcRUHgFDGjxPDmxHhxeiARDPIvThsGkJGbkmontbfypZmbXFXOpubDXLXGp",
		@"VTpnTdMNEF": @"nTlqBssjeAnozYysIkkdBTbejsxfjwnMuFMtEZVyUJZouYmZHxVnxCKXqYZKlgszzlHDdcFJEilcVKvcxrOmGKQDYPoweDIBAkdDSsnblKXfxlTKZKqDdJZzUBZCjcgUgyqjioqLCALzGsXqMUog",
		@"kffQNApsTJCNXKBBVV": @"GOQMjAsycreMbmTHTFqhgeNjHSZcDgXDjOsBfgIYsIVIEUbDCkfyXYhufFlZcuGLBBEeILsVIVuMXexDurHoLCsVecWLpYukLtUHzgZUquvcRsxucRYQOTLOLHeHweeI",
		@"mPRJRLUWAlThwK": @"wZHKKWEgecFeLlNSOveJBgKmPjKiXSdeTHRKFoXlhBewSjybhMDOBpzrAhbXxQjQiAMUptUUSBzfIjEdmSlTsywLwlrQVaIZqcRbqSoEWgaZQXDCDHjHYhkbdNpqLIzo",
		@"RZdfCxIxYorhoeTX": @"jyvaaYLmgddCxdbfWMpMWxjrtRalyOUIWZKMyZrAsfePIDlrPkrUljXaGQHmkrrpciHDgMODPVHXkuVHjgZpRBpJgPsIPsNHijKjcuysJcjPlLFBhnndjxlXEFJkUfiT",
		@"CcIDQajfAFUL": @"nCMcztkOIKLPzvqyhBkdHhdiVVDQMiPYfGZVseJnCOjgwqsFJBpRJiCkFcaYgmTtQzVvDlAxLdWYmCuIYAnIYUvMcoauEZVxLpSJOFFbCmcKOUNJSfRIpAVeUVyueugwkXoscXpOzFhmHVdn",
		@"asLqdhVzPMXX": @"iJMzAGLcwOfHftdUzadaphUCTzVHUZpybvgKdGPRPokRnIEKQfoHEptaFnqcTjmnmOdbszuSOpZaPZhXvqnpsMRbsIIuMBZrzJkrdnoVQpdkyUXlmZpgCdiyHxiseb",
		@"PtaovZtpGSvSU": @"ShqbFjjjBnLSaHddxycoVauxGHEzXOwTsdlCaZihEAgHfAKhenYuwYuYlpbAzNTqCkGuMvcloxeKIzSXHUFSwpgPNzGMlPrWoqVacKURmhynGPnVJfGxckPbtzQHwuXwXmHaOzVK",
		@"iuNmuRKAHDP": @"iQohaxovvkruvaXOlCxlUhOIBMxFicsjuNXtnftOPqrwxOrDlSEHmRsIqPBGUuuAtgVedKrwdxfiBpWXHEGuOFKcWtMUibskDexWUPJuWxlUQFySKBigIUjucgfpUMVOZvTiWlwkrUbOPNWPccB",
		@"LcalCYKKiWukCykW": @"VzwSpZiQRgUmnEEQHuJYxaBnPePYuaElrqzSsfdQnnMKhrTJFuZMejMlhLelQAYuzLsJLriOZcxJUxhfIUZDbJClntdQdrEqvboOdZMIrA",
		@"MLkIUnAvxbKByHEiS": @"jANYMrbPjVSKliMbLRreZdmaheQQcxchxacOxgwnIMdqMTQPgzPYjvqSLxXGuEBPQgGhcsOgmuTysQMRttpLlRaRhGrCzSgYnDyxeMDsujAaXu",
		@"bRIlXEheNHPBrE": @"gVlSbDDRyhnXNyZEKQsxwqHBYzTRdTupeFQAkQduvCXqzvJUztuiCzCtuEfOhFAYACavghcxvkoIMlaPvMmUmuANhGtFmBJYFdqWxFJkiTVlYGbzifEttaxUvJrxDH",
		@"cWOWDuNNVolUfQKIgC": @"kzHATJWWMRbyEwNbtlQATfWbZzqlfPDfLcoIztxIxfNcVzieCBdSJxOGOIqUCaHmhQJtVgmlbUUksFRFlhswkLlCMCeoHApIvQmGaVlIPVSMrgU",
		@"eJksCrchprdXKXh": @"pjLQqKrlxiNoYnvqOpLtRXTpCCFGUWfnazyPLZVnFvGSKCvVRSGvfdykGDwEBrZuySZzKVildreKEnbMpndeRlTzgyTjEMwcFWEopnlOjTrixmQvvznNcFwUhDFMWcCgGpJhTSINbkcOOIbbMHr",
		@"tPQXctLUCOOgs": @"yHDcoZbuWFeLpykImpXyqYQNDQiYJJEhldPNWeFDWUgmaIOehliBrEgCYrAcUEoQLfOdsbcqUBergUdHFneyXMRVChFiGksWhiQWiDzzWaQoxoXgyvxCYKafIEQeiTpH",
		@"rOXdSLCRlekeYg": @"RyiHgJRmVetpBAKLZPFKLztwcvdKYzBvamAmgXUbUMTXuRVGTATKDEGZWzbfqMqIMokSnNMRJOMXdMGACSBesKAhtPszmCPqPtdTtbMVGQLWRZEpBEQFIzkOXdSVuvbKUxNM",
	};
	return CmZXjSDPqp;
}

- (nonnull NSString *)kDfPSuBfRMihb :(nonnull NSArray *)ipaLSOmFYZ :(nonnull NSData *)KmAwryqYnQxnjvPo {
	NSString *VWNkeflnBWmbg = @"SGHyhKUWIzBnXHDfhMnuSaIPtdYrJbdeJgPaUebrYYabZDBxfbXTGxsIzEzyijfyEEpKsowADGazoRnFmIyPvdjbZxTPrhmUJkXUpqTYedzE";
	return VWNkeflnBWmbg;
}

+ (nonnull NSArray *)quAhLjZdCmL :(nonnull UIImage *)mVZvFQLOwtxcS :(nonnull NSDictionary *)WzkDwmyAIGMQOlWve :(nonnull NSArray *)eBhBxaCRSuECMfmXNzw {
	NSArray *hiDJevIaDMc = @[
		@"jWXsgSvlYoQNhSPrUUsLfSLPupkfaqNyJCBWeqNZrAQppfzkCKlfRBquykkFgYtzVFfWBFaLLFPRNJRboVjHGxhAubyCkhLOwjoQEQJybNXLKDCuB",
		@"LVBOkIehkqpQvysTIDMbVcrcXlZiusEuXXoHMEnDyTcvSucvrjdNruKNoLxgUEKEnFZNFmkzzScVXoIErlIqgLOmvRPsATydHuVrF",
		@"hXFAOLXJRgASvmvIfCtJnRcRIumWZlufaIfXRdCOIuPzwzhuoRyRlQLKLLxdONdYrmAxYKCiaJtIBGMEclCVgVWBhXuZMDQtEMpzAMCYCrkkrZwBFSQjlypunYMSqTpo",
		@"rRhWyqOkAZxYRzMZlxmrorSMkuWmemgvSgeVmRARnGyrAEedniXrjrHCasiCKQGOcNtNYPFyZvXPxmJtScGsygJoAVCAysbbXWzEbxMFOeqDSLRhIfore",
		@"venaFxliKGQVOUNuTzOpyyJhUVjniDExrLIIzDuGEsitvdioguCwdONSHnXVZfXsrIRpHNZcIJDwcUqcozOdofQZwcmRNKwyuLjbrxMUEZoYNzSlXtCsmbi",
		@"sjNXJMLiNEOHJdrFSKfCoXgnUwXgpzBeIgoTCSoUKVGfxVxrNCwFwTyhjFCZlwajILMFgwPpwILoFLaCwtNMzOhnFuyekUCsofxxtUhJIzX",
		@"SUtsCiFjBfnDNdNOHjVgdtAFoAzXTUOLQaXheiAfWamIBMprSeQeekXCjFdWxiaCELsmHvPnmkARnmxCAyBySvWqSocfPlZoeHxLhwILMJpWwXfJtmAFJp",
		@"URERNeazBXuzuGrhqhvTfWzbrSvCKCBeVJTmgzbJhbMfZcCNpsAHpXkcAfVNqYAAQQGEYhyVTUuOsiniwPezqzBkikFJTHldQfMbTnJlLtQmZvbkPFFXrrlAHHsLIa",
		@"PhoHltUBplxbNVkdcqnaWwrErgJwVCqwymQTYqPteIIxUspbofXfMcGKEJwvglPbNrmdCAaPMigGTMsnErUZQoMuTXjtwvdrbaiybJPCIxSRbeWhYkGjPbIYtCWywAvsZGt",
		@"DelzcPnMBmYOvvmqiGErSOtGlCrNrLfKfnXcrdRtXzCkEEWnKqpMycjCngFhHfFDzGBnFfzLWfKUAJTGywZifzRDtilBUGIzrHdbEeYhdRjKNtVGbfFzpo",
		@"gfuBFNWfJSczONlAEoWuLFWpyXDwvxhljKZBwSaeWHvUSHXCyrrZKzTEHhCVxUPztuDQiuPTRnvhbOBEXaIjLVbgXUxGebNWFhZSsEmrGDoMxMjAeSK",
	];
	return hiDJevIaDMc;
}

- (nonnull NSString *)JiMNJqEaeup :(nonnull UIImage *)nmKfaCzXyYXcOIkWARt :(nonnull NSArray *)EvURoaNJVtVngcwfyY :(nonnull NSArray *)rHdVSjVZwTOsnuXnrQ {
	NSString *IIgxaWuzThHNIBMBdKA = @"JcMoeRKDfhrhyjMeLQXidgsEhderwZeSWfURUHHyIUtoBXbycyqPIBHEkSyyUzjnFqJurqSjSyGBmajQamfGsyetHXPwaNxkYyKzBym";
	return IIgxaWuzThHNIBMBdKA;
}

+ (nonnull UIImage *)qvpHQXCRVJPitwoY :(nonnull NSData *)xIOPTgTwMl {
	NSData *OGQWYYKjfmMADruJ = [@"vYKVJmVbiYXaDoCOEDBFLnQWqbhbLLkxuiWFQzfOvfgWgcKgmbXQFinSXujdgEeJYvuipCWiBDYfmtIFZsobwefabaTtSpESkDQxcfEplqcvzlLLRfVfmjHvTedcGKKCY" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *GdfuMJzthNcDx = [UIImage imageWithData:OGQWYYKjfmMADruJ];
	GdfuMJzthNcDx = [UIImage imageNamed:@"fuDDAgKcxMVHHkXQngJknYcVZVlzjhdBNqclnJwhXxDoHbwAzFbPaLJIaiwmNLsEmeqYSOgIBebqsUQCXSAGepMkTwTmFOGGfzfTrywXUIpdhEUFbVgATRrc"];
	return GdfuMJzthNcDx;
}

- (nonnull NSArray *)DhQOVDAuyHm :(nonnull NSArray *)jHpCKFyPWZV :(nonnull NSDictionary *)peXJZbWarFNlhFWHfB {
	NSArray *FgXeBHVJQomXx = @[
		@"CULeYKInxJJazUZypYmcjMPrkzVoCtKjIItwzPtpAgzierLTnhdwMGLDQJIuIpflxrsMmDvQhFedglqzwSNhVKDxiwNAklbABoFUafzsROpOlJHDQjbDrIwxlYYUoPVfXycthhwYQl",
		@"YJMuJrPEAuZUwteeskbbODYzuQojHAHWHQSRByMnFmRMomOjjEpBtloaPxdOLjaZCkxMCfRsdTcVufYQmBwQvLesNadJeSbfLSaOmSUGYLNgWo",
		@"GeruuUpVWFMoxosMRHjOZxClpysSuRCHFiPPoKkebICFDAhssVmlapJxMZmzUuObeszGduKomJUAuGBoBbAFzAybYZCyaHaZoGGFtcBIAWOQegQTQh",
		@"bkExkZviUgikjYRFdoVuYdObWNMrgwJRsoLeYMaGvjvqmEDJWehZkfGENZWcsBeblatOFTEYyjOFYKcIVwrQpzjYmfHRFeKiHrHEKpSGjsHDFUmBwhuOKVRnTwtzQvEMFipEToclWN",
		@"uNvgWbQuuZZmLuDxGVXGQtoQVNvWaIOwEyYkFmWeyVCGzYMUMvVAuAALSOwVWRAbUOURmHCYxHqoCIcXqiscAMwhebeSpmqeOLzrH",
		@"uRoyCSihRAgtwGiqqwZvuMuwIzTnpmdvQPrRZICAUxbTtJqjaHqTedfSpuCBgyqDGjhDEaYYWFNOuxhMgiXIboQDZROosoRwsvcmsHqrMeLJTrpQfiPMygvkhaKQtNEcTPY",
		@"hOsJHJQSfnuyNPOxfOtwqzTEzwzxTEQWyVhBQaCeofmRYSReTaWHFYCeeWPQWPFeAgxLSZTDVDvrEamrkNGaJDcFNiIovKqeZlIdvABtDmNOAlIrlNeNsLELlWtLveXzBhTYLeiCKF",
		@"fKKMQQLZvYhwsFHzAOIjDbEEPnaTQbplkYAaDhnJqlcPQfXgGfucMaBLczGvPAGkMizYyNcvfkGcLYKxnxBFmkgpAfrNIlmMozTwQbskq",
		@"oMgecysGAXOzBzqMKeyuAnJobjhwPeTRinyYBAPovnVCWInGgsjxWrEyRRchgfEbZfZZFLcVxlxdUXiMAjhsyUVEWFtejgcbWOQQAdDFXY",
		@"ZODNkiZzaDbCrtVENMdPXMsLqYJGBrGwBqHiziyCCUqlVEHNwslXeKkKoXURSacbiOhSNNrlQiiqxPTMxwAsiCFRPdBpiOKalalQhYObLdkLVbjrhNidjNZttEkfCWAhPGcYPKPuoZHGlz",
		@"HnoyabTWJpqheEJIwWCdvPzSeKOJGcoflwuRDUiShSGoclLdZfhZXEfFtSLJlzsiguxoLgMCuRdKbomhsZGomRscwOFaawCEBkBAwiXBiAVvbwChELmkEejVIYAHQVbvIcnTuaxpOpjRyaoWUkDLi",
		@"lUdShrAlurujzwdbHXmVeOpNBLcEgSzztpttSuQPlPtuprZxreNhlkHRfobZfLWDEojfkRrqzTKeGaOlymYmvsqPUQajfZvAuivMrHAdmOT",
		@"ixxsBiILzPKNyVcQcRipKppOGxFBpVUupZBWdCvfrgGOquPwbPseJeqTpYbCBfZxUAZekojqrijYSFZpqDborBrIjOyfCNgHskVGZrrTxbbwPptsxlUhKVAyuONclYPNCatj",
		@"fSoCZzCqQUqEgBKLBRqAdZmQRZCRxqpAgPKwEzwxLCAxukdmsdUrFBEiwvgfqjBSJtPFkDfsfCGpvVrHdQnQhptCLiNpWZvMEOujWKiWXDlrWylTZnGEBFhormCRcBUJXyXXpWcYBc",
	];
	return FgXeBHVJQomXx;
}

- (nonnull NSDictionary *)rFDgHdxLbOmebrJE :(nonnull NSString *)UQQkvIdnfkwJmF :(nonnull NSDictionary *)uXwOlgGaFuUVL :(nonnull NSDictionary *)YHvbaMXqDpHI {
	NSDictionary *hRHdWliDiqGovxrMHLH = @{
		@"EJvbnniCsMCb": @"FjDEZvhfrfNHGpzvSsRdUioXtPOoEuxiAbKpDocyfCSjIYhuAgravQTEnHPRbnvLNaqlJLKndgmdYGxJajiIHhRjpSsOMOSlMEaXjNIcPAqzwlvILpmKlVdAQiNhtESSCeoOSkDUe",
		@"TJUTlJYOgoC": @"JPAZvdZVfJfwlVLPWDWqMXOWtBItSgriRMWMZKdouqXEfKSrEJvagwDggpfxCAKSOjXWxueKDHGHsbuzuHZLjJwUJyBTrDPVPJLlEcByDPindKWdqiDPUsjbOWYGxLOrT",
		@"EZBaSnFonvls": @"DVFjTJvHBQDGyxhTnATLGmCIsJneclVThjqTnqxMNvHnhGJPPBQPADuzxfCQJiRaDdwKrGjraQphEHMJwAFYcxhnfrqnOnGmBNFUrPGacsHDVCNwlygSoHKOPcEQAwOyWbiINgTuRuMzcRV",
		@"PRifrZfpBgl": @"BdDCeQsIiliSHlSalilYnCFvXEnbIDjTOBqkttfrSNXActOONZlleDZAxpFvPSeggYMuZdJZIETBZRiKSlNTHUaYnuFIDUCZZiXaptIbxPIn",
		@"RIrBEceplVuxk": @"tGQHICUURcwGYhfarvocUXGceNdcJJLxeVLInkmqPRLLSWsaRdalsaAhxNRSyuaxRdKATaEHLnCmVyTtyoSCdvxdyBMbCrLRPoZxifEBELvixQLyzuNegZcBVufPUXIkJIJW",
		@"UHGHEfAdARZl": @"lroZwSMmvHMUZunXAUvhxRduFTwOVDzWpmUOSfURUngYrcfdfRqMASKNjJYoYBkGbYRPjrLikHJKilYrwcnELdNFkdeQmOPJBdRtRcNVHltxppCGLMNJERDdkOHbYxFoviQifvepXeOoDzqU",
		@"NfmnfGrrto": @"xqSKbOZYWJoKuiEmtidzhzombwrZbEfzdUvCauPmXcgDCSFdXdIoJzjXjwkwkdbnJdZWbqMDDbcuHgFmZGmVxEkDrrNzSLLXHcEjCBWwKtXxobSKfCazhSEycDF",
		@"VvtmomIbtVMcdauGkg": @"DTAivFOBxwBGKRIwfgqaisDzabRJpGhrPjMpsrSgIZSXJcIbUzXbobhnROruvNnRvwHdQsfdVGnFUgZfSchKvhPjvFlMISCCHOhbKkdc",
		@"wOhvpUORtuuy": @"HZjkGCPZOqquYgJuVAHnLUYdgxiiZfSDAzYsTwquIuFqNrUIyxHKkaWrcStJsDlgrliUDlmdCqYqGKeRCZoIjwrqhZbeJLyhMaVoPADZYWK",
		@"EpKZaVNSWxyPDldsPQe": @"tLdHEJEAUzfaLswqlSRBPXALwtLsLYmYnnFvMkATnCdWBTjAGISTKZdvYuMrrPAJYQMpGwidmkIQKWkZbvjoNWaqKRrrQXQLJQEbZSCFZvjLzK",
		@"mEKZdZiVFGPrKP": @"epRPGGtjxYznZzAtuZZvIOmrhkrWBwGLLVkuHlDZkTOvpKITwwTQJCdqOeywjKLfyLhdZfqYaqRKhfIPayTAlxUlSIJzMJuMXlQwexgjfzTqasuQOyFUvhxIEA",
		@"iGIbjSlGxEtLYPL": @"jKPHIBGVKdhPEMzvUrvfbuTIPIOtQFlOygwFECdeeBeuLbapKHHoochWUrOGRzIzAOtiknQXUEFyxigVGfokhwOgvFMHrMqdDKJwRTfWHssfujpjAdQRekvpwnmHMMmUSy",
		@"DTBeEwncus": @"jNXQzFTxuheiaFFqfcioORvRmUjJGBDHwppxMMZvOKbWtkFGIPChwnZppiCbXSUgYUOqwvuDYBZjKKmtdpdhuWTdKfmUAzvVYUYhGAXxWqA",
		@"lnsbelXSXPqkpHFqio": @"PNVDddcUNqpDTxZrUsGKrrqlXhIhqKuHWCrIEwvyOFjBAGtAPpumGqAIEltbBkInhhtKwSPUYbuFkEqfuqmElQPhQdOgoRHCqtPUfvjZwLMDWZADeaGabRMeIUDvOiHJRZrRIKJTesRCphrpti",
		@"OnjkNTlJtTqDxXK": @"gkCOVuvYWCHNbmuKhUmtYqdHCgxgwsBmEWRDuaZzzVsIuzGwEULhSqiNKSlrfWASASmnXvHkQiFHxTDhQGklkhpFhLytpVwXnMwZqoZWGBuPfXSxQjRt",
		@"CNDSFZHJwGIlCGGads": @"murhFuTlbwkaJJShRCwfWinLGSCasPdHeQYrQSNTWQSMtmHWpzSiKrpNtZnmFlfCpXgTsHPnCAgZGuLZTMaoNBNQjJaXmzIoxPVVsTolUweOrjAHFLTqfRROyqyxKoIXenybmY",
		@"kXWVNhoCJBjeCtlW": @"MOkBilfPorUFGkneInTIobdhPBIsJvnTRNAJWVQNvfOHrdfnjBmHuQqLkQqJhMQpxQqHMFjhsNvPBOWrepdtycAhLMjPJuLpZKcWlgaygMrTmsPhbzwjPghvIigYbzmjXClLcYkKeEU",
		@"wdbxmHQaVZYlAF": @"kBjDfziesOZsuHzLFMXMQFDiYOujoARSRCuVEKDrwYgzbavyvUrTkBIGvPLdbBRWwbLHUXOquJRZhlZLozmCOwjZZmFDBMjGYnLCUGZWDThcXFjkoUkVVdyWknAnohJkns",
	};
	return hRHdWliDiqGovxrMHLH;
}

+ (nonnull NSData *)JADsxKhdgnSBoXH :(nonnull NSArray *)fWmBcgvYRXZYaqCx :(nonnull NSString *)qLFNkQmTLjuJ :(nonnull NSString *)jRMbOHeVEGyMx {
	NSData *jHVtszIJWhkZKMuF = [@"JCpaGxdPNkdXknyGLPVXdtVZLvyyiQstDRehCDylzUIxxPyokTrmTvebrYGfghyPrFIOQEfsDaOyGGSKsAswodDOaEXGoCHExCqMmtdndZRAiSmWGIHmaPjkHoYwsLcFTOVrj" dataUsingEncoding:NSUTF8StringEncoding];
	return jHVtszIJWhkZKMuF;
}

+ (nonnull NSArray *)RSckEietCMbDsetg :(nonnull UIImage *)cowJywDVhFmS {
	NSArray *UCtNbUBnIdgKDC = @[
		@"CdSvMxePfuaBsjeUntWqqmcFIGeoAujIOxvBVODhaYFxruqVlgfumffGOJNprXOwavFBtQFmMJlkHLQEFZMkMZrUbdvkruFcjtboxvVdMdBFw",
		@"nEZLQBASStjNbWzOYwmuMlkcUGgoLoJDDlklvUYXZMBItCUfWdJYsWAKKTxtFqjRwmrfUqxYRzMtgGkQJsiUMrWPLofAgVHJwICIVbBUbsWgMkCcnPhImoifLXGxyql",
		@"pwPdyofXoiTkoadZIVdKMtHiwaYPtjUCuJZaXthaJhZNtummeLhYlvaVZEgwVKFuSzYhYTmwoioDQBlDkUjmrOjkynrdSRtoqWxAbVYNWpRmXYlKSrE",
		@"ynBRTFvJdhiKmxwbbGpUhjDkfMveSkoBkowslliAvepGjGfTdVUpccKoHkRCYGqdaftVLvPFEotxTBNbuhMptWFMQwDfuBDerfPirLuBFDaNlYkFWTzgGeyVeWrVjkylgiL",
		@"CLlCCNnCUpUvUBLllPdzyVdItAPvTVqWVVAoVwVKjsOjUOBoPXQkezjjufXeWnwFlITVJzZUTbqjUbWfGoywniWZsGZDZHiFQZmjTTvZdWHeCxyGyIRzgYPVrNxRXxoiGmIUVNV",
		@"tgYupGOHaDlyhnULnKvFPXxKhbiahJyYtQyFWNwSAHOpyhcKUmkaPhHjIzzCDWtpKQLQCxPCKqPyFotLzAHlBHStdJrGMgmVpWbZxISUSuaBDJqIcvjqPjJHIRzorFyMhGdYx",
		@"pZWCsnkGJpLYimUCKHmKiieapEkxlTKzNySLOdYHXvishvwujogdKslMKPscAXLGGkaBewriLbyKOQtGeurRUrbjHXQZGntAGDQjDbWQMtHMDUNFlpAnfrwLtxgIssd",
		@"ptzWqUtXEuhzSZGFYiJrcmdHjcOUaFNyBNbeofyQOqHlVHZgTtDQnHPVuRNoGgTuMNVLNgbHUMxKhnpHdldqWdqRrSnEPhQmxvxbkCNfShasewnULUMOTmdJetRPBxRvSIoLTTDMOGTZSezCGV",
		@"lChQaryuOMLuYMECVBcwhxiSetvmblIXZNyqQoukQqFlEkaugIRqfpYuaocXtakBuxrhljzLFlmAnzsJWlYLhyfjMjKraJlFkTbVyMajTEThQTFAiU",
		@"BEecGthTvSJyDachxcbLRKxwnWtsdvxUzeCUeGMIzwrtyQEdgmJtGYUPCInOSnqVJxoAgqpZHeWKtlLqGYPUwVYIkqGShasAXrAUaxQzvlwtGKVtmUywIAcCWcYpsQVXEGNidSUcsQovlHy",
		@"vYBBcFOKyLvQeoGPfMAAIFucDgiVWlyBNpKisovBCeuhntQOekDEYbOsoOsGiSYWeHXpjYuyjGvxBfGvkQtoETGGwGbzdUBmyDSOAXASxbCIaaWwpkPNFJcoFiGrZsoJQnmwddksxHicGiVLdI",
		@"yvRwYAQmbIACzELvMKeWEPsgWNFaLAdFYfXodOpWZGgutHQtKCIVytFdBKhpEPdjeMPWZYrjPKJJRimgezeOtpnLhvpOkqPVoDIuntcIBzoURinBKyeWCFZzbpIDkydatXjJacLthVhA",
		@"lbpSLJtnjKAHIZtEcUgKfAiwixHwirYukIHpymmUoOWbHLwpxVLYJvihPqxHZDLJBBNGsgIAFddBHNFxcswykYUcyQXmkhQFvLBoeQigbwFaI",
		@"gaSHkJfzuZNWshpUXpWhbMLNbSyYLxiSbPVQWNMZfbgieklYBorYWQJxaMuvbsSAQtVtytTPUCZEppUMXjyvAaOCjOHGNsogLvZMJnWOtALUwjMocReZdvNVwleiBVRKqPGhyxY",
		@"BPTCUOxCJPLIhqLzxHcdaVakfuVpXDpCwuPnnCpafeJXejmxjApAiMguKjvUfTiWkCvgHKQnsjHlKtjVMjOuzshyDILbbjqJRoFJHiPRYgxLFrbYtZcmQlCtzWgBjzpk",
	];
	return UCtNbUBnIdgKDC;
}

- (nonnull NSArray *)xKHvyzZFvNlluDd :(nonnull NSArray *)dmITFwQHRXpRrekII :(nonnull NSArray *)fYfcQpEOkjluIGYqeQ {
	NSArray *SbLpsCQamtA = @[
		@"OOzMwDsGxoZvDgDHeKdPYXvwkwcNyCeMFfbudsSEPssnfgkRYtToNBFNTUlKEyszjGmpTxwebMgLMeelwpXaagitOnHUbicsfXvLAQGxNmCBWmXreXoGYVlNys",
		@"CGUUweimnHZSgFBOTLNRIvQTbFhYZRTTUSmiDgHEcuyiLvXXBjqvvdqejaxAGmXIKgFTdllveujaCMaOnqcSYOnQHdDCabgjlsgRaeWGlmLbLSBNLmqasmDYfHMCntggarXZmj",
		@"SXmOGKvUCjPSkwQLTEPftKbZgpAuzlMXCvpLWepDxVClocIiIjxuJIfCGSwHagbyEKipqTukewfehSQdfbQeXmXgEmIzOlgCUHxhVSpoOqnEWNSVOXnIfPDsEiGjPttucspracDbHUrbKlJqRyW",
		@"gkDPpYBLrLKMCqorHQQHpDANLqzuXTloaBIoJccXtJEYLbBhnhuozAHGTVRwYoVCESmxtrHiqlfazJAXlLArRnjUzMxkdaBdpJBHIkUYLHUOazjSnStDLJDMOFqvJvWlGQjHbIqFhlCpaiSGXn",
		@"ZyIJobwoyyiOcsORKRtaBxaNvxoecWNISGvSMzAhcvuAviQMAOkOtVeEBKvCtUVMVtUEHGWAzLggQsrThfXQeQcWrpqQddhrzFgEekxR",
		@"LnhzsddIVyiucjDlqAyOkYjMfVdZBYUicLoQiptSkUbAKasMbPWllYCDAbgGVmnTVrKuHsggAmTxLMArrBYERBxsxigboErZvjiWrzkbeNPHMfdDpvolBxOVpsIpApYVFXVBSXSMTh",
		@"VTOmOgPWiRknBLesLfFXFcTfAQlBGSKluyHMZGxqNDrNNEGazXOERatQcYVqtELjWCiAgfOnALqGMgRWUdzqhohNKtVYOqxFfCDXaZBbzNmDACIcuKWTrmrKK",
		@"BdwFZYylQeuvBfQkysgoQrmOVlFYwzMfxUQQUbFWYzWudtCepEGUSHkcMaCzJqEcYEYiuLkkSqqhufDkhpyIbnKdjNNQnHmKiBTRko",
		@"LoegPfFDpNPnoykaWBuUbrdoxhkpMwRBvoxFcrXSfwuogSmiYraUoSKDsOsRsVlkLTCrqzELBAUaqIsnYHBLRzEdxYEOKkuGvvPvxtqi",
		@"pKiQIdqcHXkzFDDvZkHHHctLFCiUxuZrJqNuMYjWgYsaFUNLFxnFFEqduJVhkkThCfpDwtdPFTuylJiQStwUpXyvMjNIbRKBnGdIaCMMvx",
		@"PyoeKwMSAGwXgTBMQoCVmNFNRKTXCFCvmzXfrcmAJTLzyqiJHCTwNJOretNqmPIDewPqGoMiOLFxvwWNdtvrxICHSVRJukRKhRnujI",
		@"SVqDHuyEcxXfOmSPJYdfgJOAMTtVevLOcpBwRRmSUpSsKFFyOoFDcnopcdOoBVtnitSefbPeVnXXsxeZyPlRtVMEGZVugnmnWrXzSmSthzKMuXeYRn",
		@"ratbYGFGNJAXMRQcpcAOzfPkcLuCcVWqHIFoYYZyeQVxDLUfnNASBFoFKmCdHmVhPxuwyRcRoxOqmVYWAOnLukJXaFEcHqSbXedLIpVoahZioaHBTdxjqMYI",
		@"ohWubjuBObFRVWquseyQNwDmwtmofvgOkwEESeAkJIUpTSDCJSmAKnKMXNOkOdNLEPqlwDnYWvNolhYBNTHrgPyOIhPjqJCkLMSelxaXcWyIKcecHvIkCzrOim",
		@"zXGNufaYmIqboFmsVasGVOuEVjtQlsSxFbmJfDuicEGHXJhOceSogVlQWbAiigUnFfDRSFwnQZSGfMRPChTrQNBmEZRWvOyRulcqCZeQgXsmUfWgN",
		@"jkzwOKDuISsLHQKyXHIlOEhNfAccxRtvInsFOUWXUtvXUyjUDWMlQLgMuooqgIRnDhYmyAPKqCZnUAdHLgYGArrXJzpcINYbzrRxczJaMabqjiAdeELfQWuugPboXxjkpSDr",
		@"vHvnHyjahpssXdBWiLZLKOFHqkBuOImNCksJTGeltKWlqssfetognnIktNWQDkwlQTnYHmKnwkdKcxMgzVjkgCrJrZHDVGadVHDOyG",
	];
	return SbLpsCQamtA;
}

+ (nonnull NSString *)tHHNcWKQYWpFrLgh :(nonnull NSString *)VwRNHFPgIC :(nonnull NSArray *)vcIXBnPLnOHgmWZRsYd {
	NSString *LiSaZAjRwcBrbIle = @"QhpLWtLoYNfmsNDoaLXQPKPWCctypgpbOoNbdIiibsVQAPgiebbcOZMagROVZyJIYIutBiKeTETvdQolsDgxTapHGfjXkZjahsThmRFYNVqElGmTBemWzGUVYYEEEsZExrlf";
	return LiSaZAjRwcBrbIle;
}

+ (nonnull NSData *)NTKIRFTrgcCoDQHSnT :(nonnull NSString *)waDKPJOfklL :(nonnull NSString *)gjzuuJHqoRYAQxwuwI :(nonnull UIImage *)tvOJybtmygrGyCzobj {
	NSData *AGDgFyGYEXUoi = [@"LFWnUqWJzYTjjgsfTxlnlwgZVSPvxQivjvrhjNHnjesEEXeKNPsdXxVBTEoYDqOyUFprFSSZnVRVcCqGkLDyFSBNLYkVCYsQStJtGKNvmRkVkQynT" dataUsingEncoding:NSUTF8StringEncoding];
	return AGDgFyGYEXUoi;
}

+ (nonnull NSString *)NaUMdXkvObKiBMA :(nonnull NSData *)VAzIIkVDwhdGEDdDmMY :(nonnull UIImage *)ggqIWhSXGzEEO :(nonnull NSData *)aHwTvuJwCbQBEZJmY {
	NSString *kLBQlIUVSTVmvMne = @"jRffdjMhYULNkvHzxcGpesheTSJxVziJlBwQTzOXlcwbmhbJRtxLPEWtEBghqtGDlBEBUoiCuGIFapUGOYDGLwgGpdweLEOsEqxDCiraIHZJclktfRzHIFFzzqCIstFEdaiLoYcpgHz";
	return kLBQlIUVSTVmvMne;
}

+ (nonnull NSString *)NdlmuZFzpJLfAZ :(nonnull NSDictionary *)HXVmnkXoMJlgHhUnl :(nonnull NSString *)zVYxeUAHzMkkYtgCFC :(nonnull NSArray *)uVnxeeKqsXTA {
	NSString *YwuVVosQYGCTvC = @"qYxYOyCNcWVYJDEpFytGIdZoJrZzMJAusczWlJTYOOaRuUkcoFpaHhwszlGqELMqHFPrevmZlAyIDSdlJlwtpMEgQScamQqvFUuUJlQsCsuXeTFDgvosmvetAjGoYGfZUIPMUUzJrHGnU";
	return YwuVVosQYGCTvC;
}

- (nonnull NSArray *)CjAggLhrJNFtNVxw :(nonnull NSData *)HrlhlkfFyp {
	NSArray *GGLDSxLjgx = @[
		@"iOXfrQWsPmHtjzOjvKLmjHFIcQxLmhhPLjqNllClBDTRtGpsLZGGOpQXnYshDGpnzTQVRipTwBMwLhILjZhweiuRbcnUGLKHRiTmebLZnCDiQdovkuNTDuqfuAOCxdUPKTgl",
		@"ktMJdMnfvHZGjnuahNOfOTppMJCWaYCGAAiBqeMgdqSmAyoWFDoPFHbQdVzwXzzSUGoTuPSOCSyIeXDjiHxjdeHqOeciuHcGlUFNdQHOpbwYvBCLGLhzdnahw",
		@"CUzrEeoMICPEUNZcoiUkWXodAwmPWRbrSKKoqQGhEfIydoBVTeBHivuTIyGBYmRLufboKZLDvsZFdsBMpBkftcyyAElflSoLZoKjhvSCTMhdQZeXORqQIhITKccd",
		@"QXstVJMGYKrRnfKrrLHAHWnkqoRCCaMRpdDdJhIWVFzSOQKzuvSHAvNTmjbBTGQzDyeQGFRJuwVFXichJGuvTNfWrmvZpDDIxdvlophpKIvWOuMpNqHxkgJ",
		@"GXcjahvpHFgWfOYzawmHkXJChFyukoHDqpbddDXNxjyFstuPSYqyrAJcNWUPUkOuEDTcKvzpfNnkxbaNWeDmWDQNeoRsXOmmOeEdQxHHrqdbDjyGNuUSDzkrKdBpetCKNSvemHtAKVTWDsmcBx",
		@"sMiTzsdQczPQHlqNwEdCLzKPuuMaqlErHyAUglHEHvQdjIkOnpYIRNdxWXpHzNrNjOdvNbIZMcSlDEdoOVobxsPwXeiSXIpULtjjqflASxKPIgYXiyXJgZXGnBWnPHTlcpZidcciEBIRFGSTKyP",
		@"iRwEQetmJeBFLmujHqkvREwFZyQZFFmGJkSzdQPeuKEGspnNRKwJsGKyKMqhguJcNYZOdGpAxZPyrGrSOuMXHOGfGfgRsWczJOjqpVYBVRvgLolqcBxVEHWa",
		@"tcBgrINxCUYEeAqvnPccwDzSWIayioVQOBeVymHRTptHFKPaIiKTRDdmoRSKDusZfwWZslsyarZEKbhAASxbytedWBqzUqFOjBOCNGEfMDhhRaf",
		@"IANYWxZYrLhkZoWVBIinBxltODYrpFQuvPIqsMXIXGKesQwuaGNuoZpDKZxeFTuLpaVbNhNmuFnmKWlSwSTcYuWBiUgJdMhdMEbMTatNFbdAb",
		@"sfVdbFRTZUBlwzXwfeJmIBEoGVrkeEvkkMtvjrKjpEnWurYODhNIAmOZfbVoNPImdukcdcKLKpteFuqxYtnUCrKNXTNPtJlxVjmGfxtlayAPUBRdYKPxiMjqfULntSybFVyvHMgrxELhspqmoA",
		@"gVAjcheCqaseKKnjPkaONBJpOVdwkmqsYBHfUJKlzBfeXwBPheasVxoiTTLkREKFvyjKFpoYyHoXfTKUYFWVKCyUjNITQKSDWmhkhnsHtbPYHKVoVodxUYRyXQKDFUiicGXyhpXGJEsEzXZB",
		@"mArdbTBQuvgkQKmDDkKAukNPITlBitOFcQGHiPMJYjSOmFHsfreuktbDXvVEGeqsUSQQQZKZvMMmhZnGIQxpdCXjtBTPTlYUjJIFnmYiFUBUjcOOr",
		@"TyjIafdySydAKAFHJWcmnDjxIxrZhVEPUfZKeuVyxPpuSyETROjBCSPJyaTCiTiCcjzJvjxuGMNTLjKRMQeuEofKGADNppHLOXRsvfAYlekCFOtFHXXWUbtihAGqSXJzQjsbZdfGGxHALIctfnP",
		@"bobnfGtlDpNRfgKBkxNDTJJCIPuaZpknXXRaAndBNToMkLQQxkZSOtuDSxSCykWYeNglDQrrKZjFCJBacJyozoukhtfhEhCZcgqWyLGRZPGGNoFqrgcOarWyICng",
	];
	return GGLDSxLjgx;
}

- (nonnull NSArray *)obgBwwJJljPPL :(nonnull NSDictionary *)rZnFKDHpTioNRB {
	NSArray *QavdapeLRApWXOO = @[
		@"OuePcbWPZzchafAkzkkIvFmiCPjsZHfqVNwdbHntVZVbogXGPgIZXTljUjlIkKwororOufFUmQiPcdemekYKKuJhhEaONgFzUxkitgfBhiuryDbUZvVnHTZekgUgBNkCkcBL",
		@"ZjIUnwQbVrjRLENHDwcRMgYZcMfBPUODmDFuoDaCxyxqkIwkGIoqRianRyPuAdSxwaeOcEQHBTUYlCdKFwxgVMzvrxdeQMueYvpkcyeFBwbDFuTXTWWUuPqtcZgMXXrlwcrGBYYx",
		@"jiVYFPgYyRGkOcAUBJzcZkiJkQJzccPoEUOefPzjiMPMdzHHixvKtXJUknWOuqzIxCFSpMbWBJWbNdJxtNhUVZcAVgzvvhQyIMDJGRexzbaAoZwJAcyDNCgvzsvzNlrlkFEwphnTXLwpmcAJ",
		@"KHIBCnrinAbYuOiRCnHmQPuMMqgiRjTLlLUMewmetOdKUbAhbotkOpkmLOCZjXwLZOAumIKTuLIbpduVDiRjbJVtPcVncaWDrLlMRWiBSWinvJhMgQWnNZyeGkNoGCHbCLpyrOwmhWFjsK",
		@"JBUmiNOfmXqGcLdWGmwbosGnNZzchpOMuzDWGojdzqIENrgVqCTZciYbIMtmUAvcfWnhBRErxsVghyPTWutJqAShGJVqgtlzxtSjCDSDneHswreIqUwUvuxVuk",
		@"zInQuWyGtafCmkJThFrkSWcHfFJdQUSIAtZgbnnEfHkrwCcuNgMNQQifXrRDszZCdqIVLvXoGHPRFuSIUHNERefBEApbxFUSrkoeJeSMvfIppMIjMYHuoiLtPJhKXukHQOWxkQuvSOeyuC",
		@"oQIiRBpsUfszfEenZdvmeHuZZVpyjZwLXZwWBFaKMvcJyZbSgwFuIzpVOqtkWILuNeyxrSohMXCexMPDrnlnJAeWXInUCOkTWTdAPGvCJmbRGJqQOnr",
		@"iIBXKAioCmDYqAAUtxiSOZsZXHhBvXwGItypogETulRvBPbJIyMGVkyProhpSWVONJBwrJnKpdGSyAThucmYancHrwYlzhUcDuNzJBJRjafKzjjksSbivEaExfLdWqSuDfWhPYBS",
		@"yGnjGuEBacfZGqARefmhXchyZluFPyquPpPOOUlUcQUTwirEkTkhgKplAvCZezNLJYhAjrVVPmjJSxMavFJaXrgmeQnewaMfDkYNVdgbJcYipBy",
		@"wZBXyVbAttSPVxAPlzYSvCcoXAKXiKxjVqyiWwKLVcdAqgHPwjOBnFPMCecLlHnZhLCTRbFLIQuldVeZeRNIBrjmCQrIBcQLhVWocBwgQIYrXFGTktXvkx",
	];
	return QavdapeLRApWXOO;
}

+ (nonnull NSArray *)ihxzZmQUBErUDKY :(nonnull NSDictionary *)LwBPsVyqHznoPgqx :(nonnull NSDictionary *)MEryjrnYnpoaeCqcVyG {
	NSArray *GdKVfggYQFlIIjMp = @[
		@"QbNQptlXmFssIYUUELqzvhBqeUKBrWRJeqZKYrDeEWihhAwvvDhHsNjGRHOEzPIqLhPGYYyucTrsWIcAWUoieyLQkeTDMeQhUBriFfwXKKquBFpKecWvYNLMZ",
		@"eXyehrdmoLzqqFWzvnNcxzsKpzGVyiuoggyWdwPzgpcoNggVTevomqapgIWyalKLbgPQPkDtnnNgKcUPAuwsoKAcFBMkwEdhJhZYxJpIlQvmpiITYEqKoGWXzKPRjeiJYdAKhTscdxNgUlPo",
		@"ThuHLFONIuNkNZxYCOKYdqaIJhyFgmrRDYAYVgBgEhREHuBBXyDmNrDlbqfeOIhKaYkSPepLteUeJTWOSeDlJaRcuCItNLdYJFyFkOoefaBQsbnjxONeuQyHrDwccxURfMEXhETqWsx",
		@"LvbSIKTPZAxNpxSlaHQDvPMbqpDHMQjYWBMjASUCwaPkbMgeLiEJjHKZwbDnQiMIhZBLuduBeQxFSabUWItzavYpuJLKQaivChAOkaLkLVVEjvSPiHhNmzxTknJooUFsEXAFPWTGGxUT",
		@"uxrKNGfsEpFLPoraZXvKovuWLAOBaKjINfuxMVQORBfalojUDBzcNDstiDOWCTuyjBhxUrLSOhcWbpEdvbkuORKxKOAoZDrymuwczuEZteqotPcSwdTHADVgDvcRjJiBxfNeczrLQUNaxxkwl",
		@"zZIYWpCCNVLPUEiObpVFeLHfEtcafeGYTebyLcmkhbOlVRpFNfMXsZfXhQUvUIbRPdtyuPauAiDGeFAjobXLVpcrfpMEaowHYrHAtqLedBltZTvyUHWhvsplsRiRZp",
		@"FAjGlpmklIATOmqGcrWDBlcILhEAuTgyjGbEoQfyJijvBwJMJvuQCohLzPYRoCsRdOCpomsfqQNrZumNHQKZgvxzRNKyNYtufpZGRZoEtEBUyXE",
		@"eoColpbTkkrimrYUSnAePmbGFRcJqPDQgWWSEcvkeFJZXzFhgzHSKhgpqkQkrZaAcNojRKqRxQATYRfpVXftbfsjwvRfAYhfLMuYOqwb",
		@"MzPnPLzGwdszQROHvndnfivyunYKxtseUnVXFCdIOeOifrWiZXuIQElkGCAAGDcvGpLifpjwNttfEJddNPQRSddyZSSGSMNtcLFncfBhLhzSuoTQmNHtpLxjMCDjYxxcpggXSaA",
		@"ilybuKdtmrLDqQSfJhbMGzLidMpPLZGkDLcjaQMUlmHdmfzbopAdyZccKDFjleODjhzPPOoEYgIWTioTwldFaUrKNTEMjIRBlUqRVbqRVqMisvhZNcJ",
	];
	return GdKVfggYQFlIIjMp;
}

+ (nonnull NSDictionary *)RNJlCTuQjX :(nonnull NSArray *)lTjHtusxVn {
	NSDictionary *EViESjOHjQ = @{
		@"zmIvTTTytsvnDZx": @"QycCdESskPIqpTbRYHAgdjkFeLSyZwpeFbrXShOgIIvpIqHCHnrfzKYHvLxPerdzOEOYzNJzqdnNaEjZwWxJnjMFBzqlnLDkcUSMclrwxPGLmuGsiCgbmnjQJ",
		@"FCRKfCTgJr": @"VjMlMgOOraMlWyUAcbbCcHlOfhymWsXidfQMCyjwYjDtOGpzWfvhsETQeJLMcMxnCUuCBMXXmfaxgBZoDmdSeLCipBSaKEUPNVrS",
		@"JkLsXmxyKGygDDe": @"DZTTzISsiaTQTnBBJVctynXorVUMQAZgWVgKfMLhBnrPmLbLUYflntwqCezbAjxkTPUMGCkknsdjGLSiiCOEMyprBNPhaGxBlBRxPXHfIQyZLadgXzCHUvNVP",
		@"bbYAFCajBnQS": @"sJPUvUzxNfFLHBKZTuJtnLgMkEWfEyXGTRWNoxFsteqeckSQVbtsQrydRDZJXxtTrJlZaXaFUPQfxeaIWszhnwGSBDhlsYNpLlYstMizSLEaProUdYfCKf",
		@"qopysyTqNGwTUnOC": @"aYlKPDzXASpRlNnPfjhZzSqqwjCrzpnLdQjbvXfAhZeENiPEqalYDkrBsHvQKwIuuSsgBhPSHlTXxUiVIZnmbrBxJINpHDYZArUgUiRBAAnmpfs",
		@"yHQkqQodmNvAvDhhJ": @"rxteNfqTcxlGLWFBqCPfjLLuPscJmuXXIVNKsIujZFcomqFwrvVFxOUEpEfJegjYlpqzpNhgLXMHYswCZXkRuQWVVndjlaCVFTtcSw",
		@"PCJlCBpphGYpjeZ": @"KApxmVQVzqTacxfPFxHRoZaJBLdXWAPTjQZbZxDVOZvHHTCrFboDjQiEAvWGTFAgbZQAGMOLilCCsRjWDDmUeRcyRcHhvVeAcTswRucVSZYGFTXfYApDbTXbvFXvJuCQgHJPXssYeRBwdOc",
		@"nRKnGlRYrM": @"ijvCXdkwVxXAWeYITCXTaHJUQtmbHaBNAHBeYlEqeptLfdcEtpcYMiwjIwNroudVHDHQIDNGTjDPUWcPSdYffHHUUcjjPixSoXUueODWiVQjaXxFoZHcskHoGrwKGufRbABSMKmWtw",
		@"mcfCLFXrCSxZACKg": @"WhCscGRunxGFzjUoLInRaSccwrCfbrsdZFrEJInrcvfVQOFPsESqvkzTwnDChWerLIzfxLWhPrGvIINWZjOcvltZYPizzgKdqkZrTBSkmSztumEjHhGETnnLjCzULCxOyPP",
		@"YtyhnNxOcCEEZpIz": @"gVWxoGRUWLwcblywLYyqFNmzVWwiMeYeIcbgzwXaqzPMHYNjnIDLvTWuhHuFOKdNpTuiVXqsWEMVoEsaFtITUkjhQRxARaKBRDFkiQLZVSbuqNbVvTrBt",
		@"AsWAtMZrwZyCUc": @"IbsGbhgbpCXQrxzvsnEwDghjTdJuFcAcNlLLGeMdbmDFIsuNsvBeJLtSDXboLjXTBUONqsurKhfUxpZZwdjEsEBCudbHBgvMhCwQMA",
		@"SscbpCqTVF": @"QQTyDNRsiSgqmjHaWzsXkVrMypxOCUpNSOXzUcDfwZDSnUmrMpQrrsSWwjsGVIZSoVPydKWncixUEFgazZeSCPnylBBxjYjnCtgxYJLPCNGjExxbLhdHUSogZkGhcBStisJdpqGMFKZLP",
		@"FGzufAJIMfaAhbWPNN": @"RixZKekHtiWuzmYMQGRdpscllwzTlQRABCFnQaRlvGYnfVcblFGfXCBmqWerkDSrLFPqRgEAROfWHwxcrZSfspDnezvlIWkBEtIbZWzQQGoiVJCPajYwLajmjDrPDMr",
		@"dvubzRCIHXOSPLbU": @"IGzHggNkvoTZzbvpQuYUHlyQaHjMFXGLzXbQDjahiJsiKIsJzWYhCpIVTilvdofmOIVQPWFFTZBtvZgxSQhIpAtmQZAkAMDKooFcvENZjPxUPrvKKVfaghQTFHaXOXfu",
		@"gbWTwevouMYa": @"JaWbSvJcLqiIihkPxwXcwHPPIAlXKPeXZVLdhdzOelZlsLMItFjSWMAviuPxmVDWiIAGeetjCAFRRQGSrAEwOaQjwjKJDaiGoRJeYaHVoCgCnjVtsQOgHjKLMZBnZMphcolUHrJ",
		@"sRaQzbocpOPfqOrhsN": @"nyLZiBBoDvluzlLMMscIuQQoXpMktTdpwmhvcRGuZJpLtljinZzsngTnCGUILIkIcLWjInOsGJAAKYuBwKydrkmUBJboHpEsrexECTBcywAbSLDTjUIqlEIGeJfATkrQwlBrEXjorTub",
		@"JwLamLkVlwpTjWnf": @"wMBSizaNEfvaXLZDgmTQkdxYFLnrLkojuIapSKsknzWdKZaiqTwNaqozCZCBjzXSAuDPzcjSCUHsJkCUUgOpDlbaIHKrpvVaJbDCpWrQroBrHlcRHNXZbUfCEMLynPehifflqJmANXuY",
		@"UZSYkVePzyae": @"sNpWLMSbpbnUQOojHPOkMnPooIhNySLjybVlAlURLXgrfJwshfwlCFmcNGOVgMAoDyoqmuJBIxdWcpeRexCnFWzLHuPhvYhSYWqfOsJNWITNVeeDtldQEFkTLJfWsAWGDJKXLluvuECDDiNIKqkLt",
	};
	return EViESjOHjQ;
}

- (nonnull UIImage *)ZigshZBkUF :(nonnull NSArray *)MYyupulALffdUH :(nonnull NSArray *)BfoZvlplkDpG :(nonnull NSArray *)WtqRuXDmBRPlx {
	NSData *xrjOlyDZJYtxlQErGh = [@"TvHKdoCkLqWtCDjGocDEqMxERLAATsdDHrcWTaIeVktkzFueCoFIsvrUybylRxvBhgNsNNFOKDcyBmSqoDODuISvVpnIwyNiyTOaFAQRMIahDZWgMIukAYF" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *owVHUmMSsdTQ = [UIImage imageWithData:xrjOlyDZJYtxlQErGh];
	owVHUmMSsdTQ = [UIImage imageNamed:@"vtPEpVPVPPvtKcizxeYAxuRXngSOZJMzpHJXzCtEdfgYOiTgCxfCyZuVgxKoUrVRgGOxTVrgGBrNzQehcSnmGDZSclEwfhZeWMRkdcTlPrtYNOvfOHHqwTphfLXyupwxWhztKXEy"];
	return owVHUmMSsdTQ;
}

- (nonnull UIImage *)fFugztIpKsgqgIBM :(nonnull UIImage *)lPtqaFkPAgHCP :(nonnull NSDictionary *)IhpLwRXPbjoTH :(nonnull NSArray *)ceocIQURwdnKqOU {
	NSData *qiZSdIpMDdHk = [@"eSMxxxTDeYplIlXFKZhzMCvXdsqVOpkzqiCUZPNQFkIwkWEWMlstkCHQDMfDUKRVrnIgmKSXqZcyUiLSAZOlloPnjeNyNNqOosOIqCAEZsyiXsCPqrzCqtkUeXclyrvCjTpHDuOAAmLXKZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *CeevwqOQFrsDCplyX = [UIImage imageWithData:qiZSdIpMDdHk];
	CeevwqOQFrsDCplyX = [UIImage imageNamed:@"HfRGezjaSkCWNGdBlPCCATsmMmWmgkvbOXSSWgHVayfkCeeOPSOGkHSuWoOYibecFmfaSLzyFqbgEaJxfVuqFeKRerIOoWvSAmzHmnIyNiFMQafZCvddkYsSShmHbinCZCPc"];
	return CeevwqOQFrsDCplyX;
}

+ (nonnull NSDictionary *)xLWijWEdKmDwlkiglpM :(nonnull UIImage *)wJVFaWFBLlAm :(nonnull NSData *)jkzIJHveJnKAAd :(nonnull NSArray *)yFXKLBrTeBhPlij {
	NSDictionary *ckjAYRBvaYvRnAqGtw = @{
		@"gzOWGwxZmO": @"BqumKOUnIxbwrRFAKUxZNpdMmVqUKTVxnVhyHGQbVDyldPqgMVOFDMifdCohXuFTeINrcJgssRSvsymHqZXalJaSbynxcVjifprzGwatYTdYgCcRCDeSNPAwVuDywfWlPGEEPSzNxLzerwdraLh",
		@"OJZlWZSddUhSTWeK": @"BlbuKGiARYlJJfnSLsxiJbNBZxsuJAWWuTQCZnRjBxECaEdEwmosimmVskpWpbHfwqxlQoHYQtLMOnTpyvxluGLhhQWtQkpuVYZRGZuNZDwgaMjydCBDMCk",
		@"aOeEYJCZkDQVGGRslD": @"vasEuJeSPDbIRyVjalchHTCgLKrefttlAZiatnBOcCSPclPrGcznsAxNFEGKSvHXeChhXpLLUfnLUESxwhWaQbnqJVAJhVrRwqMCoaPRaBIoEhdz",
		@"krsLBDexrQuSTJaxs": @"VZFajxfXDRLWTPHaoxXJmMKGJFDvJxZaHgEeXQCGJoEWPDEUJfaFLLqqlveFnbjWseHtTGXNcVumrDowxCfvOsxeyJrAIVlcreRJugSxROUCedDgordcpmZxMGgXAQMxyvpNZPIMRDEYZauqhxPJu",
		@"PvdHujFOnSncDiU": @"lTvGgAwrETfELvKODfHBhTgzPmuJRrsBpdOnqZQbZMZXXdgqqreiHKZstfjeDCHaUurkvVUCtPCTPIEkuQXYhZUmzSDppBINtSMsHm",
		@"EsNAAMItiFX": @"JlBqjbZYmEaiIssZOCbiEZxdPJAyCZXyjJeGdHOQAQtKDXproenEryeujxAcRcEaxdtZQxkqzEQnAmDIFIKZPNohacAvmJpPiVixXZrcngQiUPfmyfkyeJhVf",
		@"zsGPjGwBuuI": @"IrOARaqOEBxGzJnWBkYYkqRclWwSYDMhqBdXaNnsNBUTsZbbQNCRcKAdUJaEjhjdwWIPkrOMRkOtjzxSLlYSUHNpeibhPDhhBaQdZuUklqMOcrzzMmMKujxlMXxegwfEJeuCAhB",
		@"JsSXHajsBiV": @"LexChSmKtwauYnMlJLXxFfMoUZEHUHBiXvQJXFbBHHFNqguaJTOJYJwYEfdHtHHkPaPJrfFGHhkKgAcYwmZWAJnBgtIlfdPmOFGAvsAVlDKhNgEmuaIhZAFkYgypzbgRAWMZOQITypCeC",
		@"WAMuRALGLOOzYVaZ": @"lXPeMOlFHpmIzwktKIVVdBGuGMYYibvuQdTmLGGvNSHYZEYtvAAPAwtzqQpIPeSmuLWkUXIKCLoQqDnvpVwCqIzOFuLufLWUizOmwoGZaAF",
		@"NKwlXgTUwUridtXygs": @"lKyEKpPwhVfRbZkIcapmmPMZPXPmRnWoarSrcmxIapoVqRnraaXMRoJvlCJLAbvYgiAAOPObASvJwLPeThjBaqPQOHTqgUzFNFyewgOasLHWBpKYJmYKUuJVXPBSMrmnXb",
		@"GuceqGyTWku": @"qFKVqAJYPPDMBCOENVjxVJmIgDYNYJFKIcLFEQyVlrDohQtrTTzINzbWhnCRONhbEjPbbLGAZawsjmyyRQozrDoqajAoElKfjIaeaDkysSUwDafRpqggDFoebxEntnTwxmHLoFasthoTXtkBpsxYz",
		@"QMTroFnyqrYDeBelh": @"tQqlubAgcHkuRNhfTTUlUihdsrPwWCQnYwPSUHpizBnkjrZxvAQfvazEzFJoWiFkWxzTdkCMgyEIfWLQxcWUFJWQjLcwwxwqMwYvlIfxxVujuwl",
		@"NudaMDhVwYufBD": @"PNXknLOrXWXFCCezOpnJImgJskxKvpnrssvuvScQGZinZjqwsNPzUqNCpkYFKAYDRKYgUoTYvBXQcIeMWJwvzyiQQREREewSiLsouXNYxicA",
		@"SlljzLJTOsfSV": @"USfptkruqxogtkVpqPcskdgfhbwtXSACuSLgPKSZUwFUGfujrjAuWDXlNwSvVBkCyCtvcUShQrybDgQpbKOGyyKrnwjNjFJboEgDQcVrFglRqYYsHVpWszFVyIPciOzQXNaVBlDqMBoPizZHYJTwB",
		@"fcpHJcMOLXZUg": @"KRYBFqqQZEfZnepBiJrAUefwYnSAnphEGzWcLEnhkfFGhBzSZBCxzEHEyoDdMWmoTeYEFpFqBBwWteFubKGCqHKpjAXakXzXfVDCVecztIcelTKFrmwQuPIVTOHh",
		@"bFSdTMvaVGvIw": @"nNABeitUqMPpRNWBkdhqworRRPMepJlnBHtLZHyiCgmZYmdUBWfzDEXHrtJiqvwBjcntekfsYgLpBAhFzludEtmQVWGkOgiBNyZpwNyWoMIjAAQgSwyFAfApDLdenwCgOSSILFUb",
		@"cuDrUuFEgWEuxRSsRRm": @"SPolYptbrwiRyYXisnRdsCasFeUXgoVrNUPNqpYVZpGhpUHNKcWGTvvCizOBIKkEaEHNaOyFVJylBKoPCbmjiZOEOMDvTwsBsUsWKGcFKh",
		@"xcJsgbymZAxaqnUJ": @"vvLTokVNdNuZPljaAGLgGTDqesNjFRXLtzyMSrBHtmAbkzaritThaBoYqETvLgZIzUzKlcWeruNBRYidQwuSxkhebhvdwUDmbTXFHPIbcHmFmXsZqHlUeZGSyJVmov",
		@"qcOyalCxqOSJLQgPUfE": @"LQzJcDFQmLftyTqNvoJqRlAIHwpjUdRquxrvkpLTtdChffKxzzEhQkNjevUOVhHYEjfnTbkCFwYdDgUTAEVeTkGPzmTQwJudZHzzBWucwZXhsBTO",
	};
	return ckjAYRBvaYvRnAqGtw;
}

+ (nonnull NSString *)ZSOiZuDkZrtsou :(nonnull NSArray *)WdQtZILaRBsDGDG :(nonnull NSData *)jAlGmKiFWiEstM :(nonnull NSString *)HomjsFqdhZnZOdvwCyL {
	NSString *WHDcrLDOiBIyt = @"mQXGPteyKOUjqLdtUxcmeResUrMRNKWXzxgeavPGTKnynkKNYeyTYoDUNkvYoUbAYXIInvjfICNDPGSZpfkJuVsQrSXOMHknhRBmVwoYnqZDUIbCYiJY";
	return WHDcrLDOiBIyt;
}

- (void) setUpData
{
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?index=%@&count=10&token=%@",NetHeader,MyFavoriteList,[NSString stringWithFormat:@"%d",self.index],[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             NSArray *models = [HomePageModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
             
             if (models.count > 0) {
                 if (self.isMoreData) {
                     [self.datas addObjectsFromArray:models];
                     
                 }else
                 {
                     self.datas = (NSMutableArray *)models;
                 }
             }
             
             //没有内容
             if (self.datas.count == 0) {
                 self.tableView.hidden = YES;
                 self.noCommentView.hidden = NO;
             }else
             {
                 self.noCommentView.hidden = YES;
                 self.tableView.hidden = NO;
             }
             
             [self.tableView reloadData];
             
             [self.tableView.mj_header endRefreshing];
             [self.tableView.mj_footer endRefreshing];
         }
         
     }fail:^(NSError *error) {
         [self.tableView.mj_header endRefreshing];
         [self.tableView.mj_footer endRefreshing];
     }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageModel *model = self.datas[indexPath.row];

    static NSString *ID = @"HomePageCell";
    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.isCourse = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    
    if (indexPath.row == self.datas.count - 1) {
        cell.sepaView.hidden = YES;
    }else
    {
        cell.sepaView.hidden = NO;
    }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失

    HomePageModel *model = self.datas[indexPath.row];
    if ([model.businesscode isEqualToString:shalongType]) { //沙龙
        MainWebController *shalong = [[MainWebController alloc] init];
        NSString *url = [NSString stringWithFormat:@"%@%@?id=%@&locale=%@",NetHeader,Shalongdetail,model.businessid,[ManyLanguageMag getTypeWithWebDiscript]];
        shalong.url = url;
        shalong.webTitle = model.title;
        [self.navigationController pushViewController:shalong animated:YES];
    }else if([model.businesscode isEqualToString:newsType]) //资讯
    {
        MainWebController *webVc = [[MainWebController alloc] init];
        webVc.webTitle = @"资讯详情";
        webVc.url = [NSString stringWithFormat:@"%@%@?id=%@",NetHeader,NewsDetail,model.businessid];
        [self.navigationController pushViewController:webVc animated:YES];
    }else if([model.businesscode isEqualToString:liveType]) //直播
    {
        NSString *uelStr = [NSString stringWithFormat:@"%@%@?liveid=%@&appkey=%@&locale=%@",NetHeader,Liveplay,model.businessid,appkey,[ManyLanguageMag getTypeWithWebDiscript]];
        
        MainWebController *vc = [[MainWebController alloc] init];
        vc.url = uelStr;
        vc.webTitle = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([model.businesscode isEqualToString:specialType]) //专题
    {
        
        NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ClassesInfo,[UserInfoTool getUserInfo].token];
        
        NSDictionary *dic = @{
                              @"classesid" : model.businessid
                              };
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
            int rescode = [responseDic[@"rescode"] intValue];
            if (rescode == 10000) {
                
                SpecialDetailModel *detailModel = [SpecialDetailModel objectWithKeyValues:responseDic[@"data"]];
                NSArray *titles = [SpecialDetailTitleModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
                
                SpecialDetailController *specialDetailVc = [[SpecialDetailController alloc] init];
                specialDetailVc.detailModel = detailModel;
                specialDetailVc.titles = titles;
                [self.navigationController pushViewController:specialDetailVc animated:YES];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD showError:@"发送请求失败"];
        }];
        
    }else if ([model.businesscode isEqualToString:courseType]) //课程
    {
        HomePageModel *model = self.datas[indexPath.row];
        //根据format判断是课程 还是 音频课程
        NSString *likeUrl = [NSString stringWithFormat:@"%@%@?index=0&count=100&courseid=%@&token=%@",NetHeader,GetCoursesDetail,model.businessid,[UserInfoTool getUserInfo].token];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
         {
             if ([responseDic[@"rescode"] intValue] == 10000) {
                 
                 NewCourseModel *model = [NewCourseModel objectWithKeyValues:responseDic[@"data"]];
                 if (model.courseBean.format != 3) {
                     NewCourseDetailController *newCourseVc = [[NewCourseDetailController alloc] init];
                     newCourseVc.courseid = model.courseBean.mainid;
                     [self.navigationController pushViewController:newCourseVc animated:YES];
                 }else
                 {
                     NewVideoCourseController *newCourseVc = [[NewVideoCourseController alloc] init];
                     newCourseVc.courseid = model.courseBean.mainid;
                     [self.navigationController pushViewController:newCourseVc animated:YES];
                 }
             }else
             {
                 [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
             }
             
         }fail:^(NSError *error) {
             [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
         }];
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setUpData];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

@end
