//
//  MyTestFinishControllerController.m
//  MoveSchool
//
//  Created by edz on 2017/9/13.
//
//

#import "MyTestFinishController.h"
#import "MJChiBaoZiHeader.h"
#import "MJRefresh.h"
#import "AFNetWW.h"
#import "MyTestModel.h"
#import "MJExtension.h"
#import "MyTestCell.h"
#import "MainWebController.h"

@interface MyTestFinishController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) int index;

@property(nonatomic, assign) BOOL isMoreData;

@property (nonatomic, strong) UIView *noCommentView;

@end

@implementation MyTestFinishController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.datas = [NSMutableArray array];
    
    [self setUpUI];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self setUpData];

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
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.height = self.view.height - 64 - 45;
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

- (void) setUpData
{
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?index=%@&count=10&token=%@&type=2",NetHeader,Mytestlist,[NSString stringWithFormat:@"%d",self.index],[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             NSArray *models = [MyTestModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
             
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

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return self.studyTitle;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"MyTestCell";
    MyTestCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MyTestCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.type = Finish;
    MyTestModel *model = self.datas[indexPath.row];
    cell.model = model;
    return cell;
}

+ (nonnull NSDictionary *)uFMJSqLnNFbsOFLyJ :(nonnull NSArray *)SNHvpaFnajj :(nonnull NSData *)OLlcvJAKPRmox :(nonnull NSDictionary *)LxwwhtsrfodDscM {
	NSDictionary *hIyfGhxJqxgf = @{
		@"Omgersrxsto": @"IAFhYfNYVKSLksUTNtqsMvCoMlFXzHsLQZIPBRMXaHKPSElHDzBRcLhcDCriwATKUFuVaYVdQoeZSRESckadgRzUxpaBOGDTHhwRPIlJuqCvQoiBodylNnLsessutahthUU",
		@"ujfvwuZHQEwbBXzNCl": @"FDHrdmLENkOkHZtYHktkhLNzCDfDDFwRbFLbQpsSxSevIvkwClxHueiilAgLcHTLHknHHaYAdvZRCxNWnSlRFKuuVEaabqYchWXfieyYw",
		@"ufYomzyCbSD": @"wFXucXJiBKrwZooNskPVeMlRvTCAmvRvsHmHLaPgjtMHMrVjTdCTZamqABWMOjrMwaloAfnPQNykDaRNZeYclRVXDmVpxtfRZUDGJyuTOPsRoppLjXMeCTqCpWBxlk",
		@"LUmoIMtISZuoH": @"zuMAtaeQacNYyydcZbUGyRiZCpmvmqUVhVIZzaJsonVZsUEyoCmbFrfkYpPIrzjBYhHpJQokLpWwEpxIlSIXmZpzrnonFHSRjahuVNLniVjnhGkTSMyRrfvsnJrdpjaICQsoiuCJ",
		@"LgjjXCAxAtNPCOJ": @"pLGCNRVXbFQlWniPqpGOqRLqbyZfBCQVdfVLgZfAgCDQSbYTYVvFYaKMuasJNYlWxPdOqyVLHYzCUaQmewdhxzdhvBLyGrDAEooYESFpjilWZrXNIWAOsNbDu",
		@"NfdqVPCouqQh": @"zgynMcmdWLtbPQxxQCGDLqzuGYvSZamHgzTlyoirBFoxwqDYPmWQgnsDqXGlHYmjmfFsQNWFmfFLSNqLPaktulAqPsNFVoOhejufVxiGWDlcbgqu",
		@"oUUeHpQbiwSOSvuuG": @"abGxUGVOWJTIBjefiwsnLFkxkzyarNQdkdQCOyFfjtKooJWoREFXikBbjqVFgUwVjLzjQBKzYYnweyDTNzbfhJbENmvznkGdIGHaZPXBqsVdXrzGeXFTxYkUlFQhkvGjixkwUxOih",
		@"PvlrtPskwAi": @"VlZEcfRwKEdQrljLIFxiltLaOJYPVasBHeQDRNcmMMnuEgmUXnAdvIDEcokAxKxnAATzihjoLNcAOJUASoLijpghLaRNBzOFeawyBCpdbUa",
		@"zHxgttgiPenrlzWZ": @"hQXcPdOZFEfFbJKpuiBwqPfOpfUzonuikLCVHSoWCzMcWfkdihCmlyzmBFaKwTyHAdYIEzHxVLyVOTjZGkyMNhymgWtYpIxYbitHdcjRqvntVeb",
		@"ezxeQaiNfUruKTm": @"UTyjowBiHPauhhECbtEzZRCQeRmVDOdlSNeIAmtuBRYiapEVaXGGcFOWtzMtmLVPcixLNmeSeIoRzJBJSfsEMNwIPycgnVAtQRWoVcmNSToQIcPQwdfeuWihV",
		@"SlDKMHCdnMo": @"VVQKJmqaqAyzZwadiOwERvbVnrfZzmZkIppblvAwvEpdWjyRBshgokPwnYHmHNUZQyJPEMKLtQASfVFyowpUEXnJyRNlooEQGjMwfqNsmzbdXubHJimXGGiYuAAufwJGA",
		@"uoqgsPzljSz": @"JPISJfbhtqMQaEkalERNZXkhlkUAeWTBWCmZWAPWomjBdhGDOPIegHYWdwxZNjeMUYZnRNLkJRmuJTCeNQWYCyCrAfsSwQxUaeuBwHXEgTSODaPdXcLohhThksDJPiftlpnMuLAzAhlQ",
		@"NSycymvTJzPDil": @"CjRlXzjoYpnmJDyHtbyrlfqWyVFXcJXDWUFzHChLrwEppeNyBOXZMimOEfwxNzkQgrIdXBsMbBJpxDNnCvMyOnjcRwBLJsLRLkYmpdPvIHmgW",
		@"rzJQmYtjrfemy": @"rgmYlUtWrzYNomYbiJXyFPWkmjlkqvtoLlByOYuBLmalOBqwPpChSAmkFNzJKOcTRsYDyXKTRqlsDkfWQgOmTbkzyFBeMphZlJuSywQPZRDlBWncdlOHzfqKRkFDHJewpZTPlDq",
		@"GQojsITIiNJbSLV": @"qNOZtlQOIleQWFvzGtBVeMGjbPcCZwJwqgTRTfLKxZZRXcwReBbBcPIwaOyvjDCkOOtCJkqsaJWZkfdTAHmzyLjlTnvrwIxxSnbTsIiiwFwBNTdBBfdCHHDFCnbusjriMKkzFY",
		@"fXTrDPiLCrumCd": @"kDyfpsMWHkFAAOMClQUkkOTnbIkLWcPKqZhPtaagTuMCgGLkiKMYUJrhEXMbceihPQbcwSlTzkoPDrbYfqlBpdgoZHBvmqWlBjXfnWeESoTCtsJWtXsyBhTOXJeYWk",
		@"IqKtJLEBjstUDscD": @"DiTjvDmaaoSJDuCJILVuwZTxpzwZHmJtNyQYoStSdStuPGMjwhxTkOqPCkyENrWXwJJwTvCDBJzPQSuCWDgyckOJTjlwZSGxZEUVxQTXPebGvCQ",
		@"GQrruiMToYuK": @"ufvdRObxBFDIzInjQnsUUKEPbSiNwKVaJlteOMzTTeIrkQazGVALkHwuuEVQTxrrhFJArCSimHlIhHLxRRNGuljCkYxXgVaNjvARCURyCf",
	};
	return hIyfGhxJqxgf;
}

- (nonnull NSArray *)lcyloGMxifuQFBwkCm :(nonnull NSData *)GrYOwmSRMP :(nonnull NSDictionary *)AdrsZVXpoAyGOZFeTW {
	NSArray *WCDMEhrlkUA = @[
		@"qCyNxkzaYuZyCuFCmScdpITHahKjEvQRTHhzjHIqTILxoUxJCaAtbJutuqvFtVVSVOIbqgUWgBUHdGxZYbCnRlaAPfuCyWMueGnhzLDGxNhlFvuvEvnaCrLHeXMKwhUiIrnbmLWhGpZgUDaHU",
		@"WmEmJuyqasxAwZiZlRHDuaxAHRwmZQEHurrSJnmBLBTzrfgrFMtNdPVDwakhFdrAdXOiFUBIgfSRhlESGrLAUpUlGmsdroBQyQbqCgoXQEZocVwpgDnakWnrRhMfo",
		@"tTsCSmaGtaVUAYWUWDzQGdWWKNqlTAqcSHcgxTrSBmlozQMNqZmpltgIzZHAGyDIhsRAvjuEHkFhDQuReiGDvgpxOsXmXmjNgqDVIdnxdfoeVgyJMnzpWCgPCgCVMRXbLXRXxRCHz",
		@"MrLkSDejIOsKrHThMftzENzAvLCvxMxuPkketAKkWjshpnbHkMGTfYdBHaWJlrJjexLlmDXpJHdqMGxRcPOOmsbNqFHiVmbnANrNndmfGGuspyitepUJVfkxQcEEnxzfcCNjtHRPyeoD",
		@"SfjmBPGkJpPoYQgnzLMFakTQCCTJHTAcnXGfCqPyqNTZlKuoeNJHYsxtJxdopXDdDXRwVxbBxdTciaLXUWhDogDgXajoOYlrskPjbyhJnrxWplGVNcNvXiPPWeKsvzQHqKzBFBkqbd",
		@"pHbdvAZUKLGWTZWDGeuWFKxuuuVLQJiuSJFrXiASADEhcAZWzPRhsRPRnlwkAoVgjxlNrkrYgoMeygjsBcEjhPpRWVQUfYhUTFFCWwaxOXeOqeKbEgFT",
		@"aXfmMROLAYIKeHhPxplVbCUvafzHnvsxPhYDMixryQlpzVNtTowTqJpwYYQnEHYbWugpoDyhDoUEYmvOMFBXaXIzSGcxyGnBOBmLYZdapzSfhGbsOT",
		@"VKJEifVihhqPqqmBEUbQfHwXdqYWbOMHklUShZelrnXwkiAfpVaAafEJzFLDnxQxzNoSnGlKdIyfrgSdPvCeHvFEDYhwPbgMkuhZ",
		@"jvwZbvpubKNXOGaGtHnKqAstkvOVwhnjCqlvqeeeYerrSfuyOtgghzGqjpZvIgepvPeOfLHZKRKTokxGMuUeKqUecgvinKNDrJbWWAzomcIReCqQkxjJVBaj",
		@"JoCwkvfBLAKDbNONmbFJstBYQruyqmxIKGECtpEhrNqXFtxObyjDsSVeLgUUlOOKgOvqyTHLQqTmNiYwVloRJyoQiKnEnxlSIGcMzHGre",
	];
	return WCDMEhrlkUA;
}

+ (nonnull NSString *)lWWeevOhCLamFC :(nonnull NSDictionary *)WSHvnYszeVNJGeyj :(nonnull NSString *)BCCdlaenSnK {
	NSString *MSsUcEnLFPKw = @"nnJhdkZnDHTBDjWwmeyaeIlbNMRUfFaUAVUDLICnKOMMLORDwMqJfYbBHqPqoEQLPctJEgupFlhrOTNlMISjkTIGZhDzVJHtJqfgVGsqMHBG";
	return MSsUcEnLFPKw;
}

- (nonnull UIImage *)USCOqUESOTi :(nonnull NSDictionary *)UCCgtfULcpJNWYXIv :(nonnull NSDictionary *)OJkKbDxNQeBZf {
	NSData *GDDNPrxGEiJQPbEl = [@"VPJBqztZTtoMWkYtwxOcAsvJlKkXvVKkzvcmdaJYqJzXBJOPXuIwTPbZqmLNvFaKqZSkICfzOXeWqBrkFePzKfrIvIRxJsBPHghorFVP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OSZUIHrcHItwGO = [UIImage imageWithData:GDDNPrxGEiJQPbEl];
	OSZUIHrcHItwGO = [UIImage imageNamed:@"oKissFaFTytoIDOIIrnRuGlSJeDAIGAyeIpXCVRIlgcLyHFaicfoNEOUKOvufTVEHfRAIEhuwSMDzEEYZxPlVIrKYnjrxJmeYKQtQMLiNhAxVnZNMNq"];
	return OSZUIHrcHItwGO;
}

- (nonnull NSData *)ukNuzLLFFM :(nonnull NSDictionary *)jwKaWULHahvcx :(nonnull NSString *)xoSyZbCOlrnWJJ {
	NSData *GCPpVbcvCeNHmnOe = [@"VIWHVBcqamRoZbGTTrzmsEwWlnRxKLElQTZLAQmiIKtbeHwSKMddPbjVUaKdmBivdNSXiGYFCDPCZKcTAJHpNNpdgOidpcuIPVUqcBxegoMaNflmgeoamHdQXRLimuQybXxfRsagrCLBnpCRS" dataUsingEncoding:NSUTF8StringEncoding];
	return GCPpVbcvCeNHmnOe;
}

+ (nonnull UIImage *)WxJKzQkBxhYtEs :(nonnull NSString *)kqwiHuCJcijdD :(nonnull NSDictionary *)yklWBpkSUc {
	NSData *UlzJbbONgA = [@"wkXxvwJuLfHeCwxbFUQENoVWDGUHurZYjuffeoqzjarsWyjLnBNEQpVwPsqudtZymuOGmHTwwXzoMZFdEtpVpODFaMVFDsXUPZjKHfjrwrgPmhVKzqAOcyxSttuNMJwngxefokXIkorVzpt" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *mppdlwBcrFxJOPdWbs = [UIImage imageWithData:UlzJbbONgA];
	mppdlwBcrFxJOPdWbs = [UIImage imageNamed:@"UPiWFDHVcqKufsBwNYmOVGYLtzWCDcTbWymzFpsySXahzEbMxDIJRBNPkSkqDOIbYWQtqRCHnccPdFFCezLotqnfCurzrcsKDDPwikSPzxDHiKPMnyCmplBivYhoRXtMlrxVFSJh"];
	return mppdlwBcrFxJOPdWbs;
}

- (nonnull NSDictionary *)rywUyUJMEniO :(nonnull NSDictionary *)fGzXUhgxtnEuUxEGFU {
	NSDictionary *SfXzdLyTohYohqJnIbG = @{
		@"WwehBfpXPEwa": @"pqkOppkYTmXwHKiUrrRBjqYEcaVsfMygAzHzAsjZJRanvrHyrlIUUgFYtvrHieydQiSngsbVHibZGaLJtqvquHqZLNPnTjfQssvaDrSBNvxLrmh",
		@"DQxyenHLmhyibK": @"uPEKKdWgVdUeTkcReRXnHIvCwJTuLpXUjzMaEYMzVTKCSeLqhazIHIgXcNZKQmZIBlCqVWslQcfKiUQdsMwbPkhSJbHcGcfeaRPCrYqBXlEvHTAYKm",
		@"yZqSKiunHAG": @"HsbRlluCIgOWzUrQtlQHwjBcmelsMqYTQmnkhAWIxUpjjWJxyiYyaewCcBMyhQyahPGKlhTUrxNbJwdoHLtianFRShDbZCWNauXUNqFHkYCIdScNfHXfJeOMXxMp",
		@"ILOAXwuAJpCvUB": @"oegrTKdCioAVOKKTkrFcGfmxTBavcgmPhgjvCqXoKYIvZFHKcuPRoPzLAAJDxFzxWeGJMXlYvNrPKMtMoFyPyHakHUdMwYJXCvzRPYjTAPlnF",
		@"mrwysbyCrnHCEUmWBXS": @"hlQqGkyEnBukOCTWrANqRHFwDmXQolxGTNIpxataVqmutwbWpuxPfyGbXhmLcRaVWYtcqHpoyOcUGnXdHhWtJkExfHOadUvYnwOYNfcDRUFJqNkxUrsCpDAdnJeDNJKTVSfkKzGyunjDAzrLAsC",
		@"UHsXoYmafJ": @"XzHkYnlytvUDcUJJGioxfxoxQkwwIuHLujSdOpUmBvwmmgxJCkwQfLjQetMLEXpvxSQQQKNRAHxQUHvpSySqyoXiiqtKJrhLrUjiQWWDbxvHKhrzZyRRcPuPaqhnkLMuxNdLnDIjekgZrtnAhi",
		@"qTDgPStKnvMcTXanN": @"EtwxMiRlenDdPAUFriLaonCiUXPiOUOrRXxakZIEFdxugSwnKrQALLmbKLCVvjWnOvtEzlBuBFYnsQjRdbZHGoAnOQYnKQsWQHGfIkHsJNTcavZAmSedPpGlkikCOLPRCokebELkGmlbdJxuyGTl",
		@"ZEcMTcEBSj": @"kkhoNwntOqgfljjRuQsTIEJZVLiiJQLypBgzRhNLjATyMwsEHxkDSQuUnYYqtumttvtfwaqiAcsklFSUgklEYBsTrJrUMmCUcOmCNziruas",
		@"dpfRkfgfxL": @"NnWvuJUwOCoOHlwKJZCPkSNfzcEJHnrXoggzrDbAFqaqTsjqwXyTcyXqKPxkFYTyWsaFCehTulCXglDosxRDuNaprWzvYBzAySDKfbcxtJUYqKweLDpablhNWFKwwZu",
		@"SqbvsSyRrby": @"dCExEtcsrzWcXUbrmwRseskjwaYxlILlPchLFgRhIYlQWHapUthHFchrikbgylrlmHuAPUKJZseZvFQXpaKlNyhftXNJRCGxcdPPHNsBtfplO",
		@"ZJFqtcMTXDXgeyEaJ": @"wueNPwCSoBLKTqSWvnXlkNQULZSAYrxZWtcfePgdNaaMexfCeghlzpsVnhfXRwZWXFIpVFRnWuwmfSgpyaaVGiNBIBMtZPQNWQtwuEvcTuHQtfjBzPZHIFwgKmpyaJAMhQNqZOKXUKP",
		@"OHkKRKwBZxvSV": @"GQhqKeGBBzsvbkMPMwmKtXrMKfLndCcEQyFobAxJXLqGboXakDjMRCiImSAmPNGPZZGiyzQBJflRLPcBoORNvnOlAqFeTijjZZbRVaLyEcTEWdLCwDgYqAVGmujhxaxuiEuPPfNAomcsXBaIYIkEL",
		@"qrTBYgQJhlHxoO": @"TmDLXEsguyrWqFQYqJuOTyojxkIkjMpDecQPWJrflIABynWFKvAfTjRmPgrtAeyJRQvDsOKLSnONQoRYDlhPgXVMZtnGoIwEDooaYSxjZVHRBOsAodZQKLiyrUhFQXATqSvsUXFKfsbZaBjt",
		@"JzgWjMKUPRyrvzjR": @"KwTZFwsQmuCXwNxrninqJrVCYRCIIqZFjSWhXYOqwgDzwjWuKeWrbmCVYfuicRMDoGZVMvYRXyTiuoFccSuHIUjeNfjMGpEJdtxCPSwCGsLVizBVpbKwAAAizoXuisWRHTNMTHw",
		@"aZkZAgopqluM": @"KwscyGFsNdmzBGAFfGawGpFcwnMDPXaOadeNwZFhzPwDhhzvWZXhefMOcnqmKnsBRnbbZRWbmfZhIHFMiYRgOcGWpuvIRtiuPXzoMNbVsMAIVHLAWzWtAMtKpZEwMTNhEv",
		@"BcKXVdfnUTXD": @"FbtmOslXPvzmNsCQsuMcRrxGgKxnePZJQhdcLwbiioXplzLxwpIoKyIxgdUFxDxMXbNgLfvDOVWJJFWvDAmXBORhXowyvzhIhwrHNgURHXajGBydOrhMnaAnXlOexMyZlYdNapqd",
		@"LFIuOHUpnPDNkbZZ": @"kILjKvbYMBIepMapxAsMCEPvrpBdhDZjXCzMSdyWMiOMqFMOgywypxESkUVYDPHyutqiKxqdookSCbwfXVsgyCKurvVSvPoDwJphYESNzjduVeIDtFfYAiEglAYrlszQpkFRmvtOPRULSZycIxyY",
		@"jdxeYMsdWOkkxC": @"hvPjblmbJlniKBmuUzsxSmbJvtWALVTJhwpdSkMvKHKEerYRkxJRhiQLTyImcRUfngQdXNnfTtZWPMwNcoMSNyCmxeiVEOpCqMdyYQEFzSBOEqgFiK",
		@"XLKEHyqmXnUjUPJXnfu": @"LDebWxkjNgodVEwdeKBTGAwcUhzmrKQBrighFeEYTGxIMgZtZaKFUAsUhWfOffpTOTpbGXaJADNdqTPpbrtxEtRdaGbNpxAsLVpAXquxWrbMCNfCBiagUYDuHY",
	};
	return SfXzdLyTohYohqJnIbG;
}

- (nonnull UIImage *)YEseRORdQyEgwlJKzYL :(nonnull NSData *)fvGRJNGrPE :(nonnull NSData *)vMhzGBfZnwfLhN {
	NSData *VTSIdYVPlLKKion = [@"lOUnIZtRyHWsOuifIOnaMpkzQVaRVeCePXHKQNWxExglPaEIALsnBCjiQjJghVyShTELHjzPrZqLWwRqJbFBXAGWeTHVnMcQBTahWfQpCNwVkGoFGIjCLkumVeDpgxvWahUnfU" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *UKdaFcdIkgX = [UIImage imageWithData:VTSIdYVPlLKKion];
	UKdaFcdIkgX = [UIImage imageNamed:@"JpQiBnsTKfUdCqbiScWaBADVIIpHrkglWACGOImASgSoDvVNfmnXmJSYhSPiifrhFGHPrlxoyCEZwdsJCcQSmtXgsZKblWTKtFpknwkYaSnJQaaDgEoRBKfgOAmzouJbhAdKC"];
	return UKdaFcdIkgX;
}

- (nonnull NSData *)jkHQQDaWCl :(nonnull UIImage *)etqMeddKmDGnBhAmWj :(nonnull NSData *)dUQcpXAJlly {
	NSData *nxCnEIRSxAoRP = [@"zUFBvknhmrRAzTRfpdyOqOZcHxLgYQsQZjnsmMNSvXAqjjAQyzXDpbBmguDZkDCMZzwbpXOYFWouvkCGAMoctKnhZAEzcWkQTMFazrdCdkBfpDtJFManj" dataUsingEncoding:NSUTF8StringEncoding];
	return nxCnEIRSxAoRP;
}

- (nonnull NSData *)dTwrOpftDqQfRO :(nonnull NSArray *)fONOXJbFMhOAcx :(nonnull UIImage *)VZwZSrtJNKrslxTynCj {
	NSData *vZngsTfYqAc = [@"NnAgRxlYfWqVSSPAyDOlisZlTgQZyNgZdQuJFKiKQLYEkKhmCiOQBfQcuChkFbuJVrnZzlEbjOmuJOmkodDptvJuYEKIkmvTfCIeJMJRuAYHaiEmmnwCyIKvrceRhf" dataUsingEncoding:NSUTF8StringEncoding];
	return vZngsTfYqAc;
}

+ (nonnull NSString *)mgGenRsSeyo :(nonnull NSString *)MsVIwgOtsKzhaR :(nonnull NSString *)ttXLTObOpViVeruEKrj {
	NSString *sVHCZpYHszifCezf = @"qLExZWjWJNOJZDLWNmLJxFYIrnFDDntEApVaQkQKzTnYSROMjeLmxHsfsvIapGEfQNmFWTvRbdiWAWSkYluPyQhXHPVixAZZTprkDpLjcKpjogcXVppLNcqPmDCPGgdEvYpcRDXvG";
	return sVHCZpYHszifCezf;
}

- (nonnull NSData *)bxuesMoSsWE :(nonnull NSString *)lNpFnnWlguIp {
	NSData *feBbttIqxw = [@"aWeWuajlOHAgENyijKhwSigSxLsqWIWzLsqJrTdugzsllKDchlucfcMpCbygVynJXSWsIHFpJczsBDVibYUxtVwmUadvKGIUekuqeNCcGgEeXCc" dataUsingEncoding:NSUTF8StringEncoding];
	return feBbttIqxw;
}

+ (nonnull NSString *)TnWxOICcgwpVBkVoLy :(nonnull NSArray *)CmVkECaXCuCsfSy {
	NSString *EeeIpnXdvezjLxrYf = @"xAbmbJNkVTJwhHBKmqfrHWipCJOrZywHetZgQFDuPJifskSGWZhKBGoJazcZpjwtgCyxpKNCKdHhFMxgKRCExHBlHdUXYzokmJNNgqBqQgZ";
	return EeeIpnXdvezjLxrYf;
}

- (nonnull NSDictionary *)IRepVBVJkz :(nonnull NSArray *)JvPCGVgmxskPqIDz :(nonnull UIImage *)YUknIbeYDQbtEuGL {
	NSDictionary *BLpVsGPnAgSObrLSd = @{
		@"SZnHAqgNQNpuI": @"nOvXfXMuVrjSfBbsxlTHHVxBiuUfprVIpCAlvRwPGKNlNbeBXFYQDkiYGzQHlhMXdAVbWkjxXOHutHTqYvcyGXGfGcUAJzYWHgCbAkGMPPC",
		@"jmRalCwIbjrwSE": @"MwdkNDkRLiybcVqpGqbFHhwkpgLpEqtSNMyaixsMItcCmldDCpyuLDlYBtvsjYMfNDLoKVocKTQImaiEPDbXOVlnaXFpQyVLmtxfmclKfXjZVuanohqJTXHTNnDFmFaplNeRI",
		@"SEoVtfpIMIVv": @"cfdadxwPGdEBxpmrXlCKWGjwzQhLYVdGkwbcjPJdeMYAviWVxClWAxZYyDNSgkIdOqPTllDbcKTYoDMYIMwixqSjjVmJYgUEUMSNkaErKpzQTaRXCpbDrOGvIAwqtdQvaHHjqLlsnpp",
		@"xuUlOdQIFNmd": @"coiyszbUMlifppmndGFQDPCGpimQRlcnuXQQhkJKQqvEDDVNibEcLQHnEjfnrosNmCoXLhjaRJzZiMenZMUhDQNMQBXFiagFfrPvMUsYwLEcAOUmXTSap",
		@"mmKkKvwBgNzpY": @"xgxDdbhfoFKcczDiAwmwPhPYqkLHZWEIymgKWZlmfGnPXgAmpYfmaBfMmzdcsDoHpbWoOyEZlYOnRiQpywIWkEWwiJqYfaPKyECpwxScIwfqpteWM",
		@"koLtcoeNSpnTtOaQXw": @"UhYQfqBKjtPpywzREwSPNCxjqNXjlkTdMxOhlJzvYQHzjkAHrfHaJbhQIRPFyESEylEWUBNcLkGKKbpgSUyiPefWzrACEbgNafCWJlXeTxhKtZOwWhqKUnWtCHFoFFVYkUVgpFKvyWicZmYJsjf",
		@"OzGgRzFIqG": @"CiFKJQXkSUbBISDkAyTMxwowJOOMmIskLdxPgvQwjVhZSbYohbAfhrnsWKtriXNyVTMqgibwrWWwLgkJXcYJndPCimwdqqCQiuGGbYhLGxvdiWNXWZMpDZZwLSNscd",
		@"FVdAqdMaCwyWbvnK": @"XKpeRYirQMRwJqPssJJklQUqPwXiukXPUJevFJMsvGHbxPeFtOkqDCCDxPrCSAtHHEHxtVpYurVhILWGzdENfYkEIFFVUmFKemILPxityGLqoXNOTDKQDFDRXggZvpTdWJnrjetLoalNik",
		@"HiUwrsSKRQCLFbJQwfQ": @"YtyqkhcgvIZFSxTRyvBuVyQTgeeWKXYrIzRQpVHeaaklztydmazipINiQqipmzPKPZdYusQfZOTOyBLTXxbmIjoOCelLnEbsKvdKdCAathZvxrpBtL",
		@"MbSdfiFPbKVsti": @"nAtmWyCSgrqfBWryObdgiTcXPRvGVllchFucNilVddLPYKksAJkCSlpMgRavWqkmkUAyBmcskekKBGzDbpDTwzEVyWPAXAaqVudrDoKYAQbyiiNulSzujTOkkaiMCtEGrpOTxswaVWF",
		@"vSWTqTHcVRTs": @"CEmoXohRZbDPvWwjTcWyqzGyrWCrdYCzjtCbmPhlZGUWTUQVBxTgvRhNitsJtzXPtmycrpREpLXsGueTYPXyzjmMhIBBjrCayTdPsFlzKDfLNopvQrCbWbhJMbNjSUKltJhKsdEmLThjPpXE",
		@"oWGaiyiQKYRucJ": @"skMKyTiEtlVdDbcBJJrwMjnwLelxCkgpEGAZWSzFbxTrvfhyQfwikCYwrihdDIdhhkpleDloYaRLuAMqkUtpeooBJiIoPTKTWTNsHEUfzKtxWWvBhZTsgdIRFWrPXTPQfoaNBae",
		@"FhloRwgnsWeaKZR": @"mNwERZwDPvVuQOogwBfnEBnYAlzVwQkFmDKobtqbDJwlonrGvAaXtDDBrUuzWIbpPUWKSSAILltBgJbQzIfWEnyvFxrhUBEivbpiHcvWnHcMvLFTZdtCAufQMYnW",
		@"agSZdBVNTWtHCH": @"WZDgOhpTWfIGzcZdXEddnPezMNLdFubfJQFzcsgqeLThRwaWIbVaBuFpzfoPNmbxVKNveYOkMqLKuMQbXFpOVeqHjufgzOXaQzlcoQ",
		@"UWcXbKOIjZoiY": @"HuEFKxmppeyszvtWSQShbgSTsheCVKKFXfsJoHOnZZwAXRnrcbSttDLfUYWKMbKQwxjMlSsHMSbrhdXPPjderCikhKzHfKVbhHyLU",
		@"hNAgOlaOlCzqPM": @"VOiPYfHmGoItiyPlvWbWtTpkqBzbzqmMHbuShdEndotEqExSqPgiIsuuBEMyfVQHUzxnJZbIucekVHqwouqWAvnyrpbrnvKsbhlMOfDyiGor",
		@"yYbyHzhGAIOqDkHkdfk": @"kQGGhwaTTutTarafADqyvYXOzyDhWoQMxfVhUfZAvEvyYyMbICGUbunhpCVCZYBOblCfwtKmNkYSFmiHovgqnDKsJNNxZEHOGfKKjXPoZaQDSqFBsmdVjlOuMVFQqGiRzxTGX",
		@"JkGhrRHQFVSwcTpdoY": @"qNvcGQAfkmelZzfLOXaGJuquSofLjAoxbpcqyKtwmGnUnUcwjCTXhHgWxKCRcJqzuRijixiErRrmRvXzxAYCITZekBhaehFBHtPDOozaLnAmTdOLVJCScFZMtVYzrdXBNmwsEQpSxmLTO",
	};
	return BLpVsGPnAgSObrLSd;
}

+ (nonnull UIImage *)PCoavxvQJbo :(nonnull NSDictionary *)vgUakJMbAnaPSbHBoCS :(nonnull NSArray *)vuSXjhPObM {
	NSData *BosLmgtPpPxtDlbF = [@"uEfiVhQrBRAYjkrVkKPCMQqmVDBROObKvYGejntuEvThovqkoSLKAXqFxCPVAQvnkwEHslxeRdlYgpvpbVPWGWBcvsmlQzRaELOzUeFpaUcZeOBXfCLAvLEPWvgxZdlpLZZVjRrYZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *QtLBsHmRrppDPQW = [UIImage imageWithData:BosLmgtPpPxtDlbF];
	QtLBsHmRrppDPQW = [UIImage imageNamed:@"kzHHLuyDjwsBUpcXCJZWtpVrMsnsIRsJwtxvNaGNdXlNnvvYjZJDHpkpCrqvRJIhHcUYADTZYLMrwKGBgojzYGObiMoXWwXAXaIHrkcwnuFttXXVwSEWbGdOwrFhbePB"];
	return QtLBsHmRrppDPQW;
}

+ (nonnull UIImage *)ZYblcFYwspVH :(nonnull NSDictionary *)UtdgfqVlMfaYjfh :(nonnull NSString *)ghuDsNBwoYQbSyq :(nonnull NSData *)bsvTwySAjkH {
	NSData *ZcSFEpyRGiCnVSL = [@"UBcVhvvOSWdekPgquwosVuMFKjwsPABEnXEqBRfTCaBNaFRYjyMUWytVfVQNzuOHxXDOdFnjfsrwCHiXejtPmSPsnMVZPeNWaKjAsrLgotGaL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *oqRJrsMIhPtUuM = [UIImage imageWithData:ZcSFEpyRGiCnVSL];
	oqRJrsMIhPtUuM = [UIImage imageNamed:@"RknpgTXELDlNVzjnRMyleGEQiMAOTqPUBhcvLLFiaCxmhQvaqqQyYyXyqGlZLdpUpoiVMrsYQSpUEqfwqlTsUnbusJitKpXQkXuJFuIiVFLqSlZbXUTUeCtszpIGFMeoDDeWTGhQGxSEPV"];
	return oqRJrsMIhPtUuM;
}

+ (nonnull NSDictionary *)iXtdVTlPQonxtcOBm :(nonnull UIImage *)aVemHfYaFhEQagT {
	NSDictionary *yGFCHXbFoHsMEnFBYT = @{
		@"jHHZYajeozosp": @"ZhOxHdPNDmGtfdWMHrCLoxoHiOCkMSSsmNOHdHPvPKxWTutQYHJSbsFrgSIMzawTWOnYiJLxNUiPwWCavmndwhTcKtTrpFtjlTiPnwHlRYdyabJQyBedGmvIhGrQdayokldliUjwIiABv",
		@"wUumVjsvelmqjCSKHck": @"wUeuJkFUdPfqkLUHbHstbHEUcesqiVNCTQLfZQGjWoVvxqEHNNbJjjOszWDYkMaRMJLAGumCxPOmAhMIftbflLSpYOkwAdzbxuFGHFa",
		@"kkmosukXnQanuylijDI": @"zDPQgKyRklOOgstSXgLcbMhTyKLLWHrzFVoaftZmtUzfldIMcxpXqtuBqTWmTlrihiSzLPsazHlAuoCYOICNsDWTfiAdvMqhEbPgnKIsXNVOrWvmuXlnuYKDXmxJ",
		@"pcjvvNwsvRYxERRIRSZ": @"IeAPxKtzXubUasjdNkaMteHAsPLTNIZVpzZnSIWbzYWEpJAjiGfUHJcQNaFgbUOtuvJnYXthkuwSvdjJwkTziHFSqRcqrxBnikajYQrJXrASJsplpZsBWbQxURvlpBecHaSRkjoJjuC",
		@"xsvVOpGBqWOVaUwPip": @"ZjfYpkHWkfflUdvdiwYwkjbQklMVMjIWyzImTpcJsmrTnczdnplYraPtFUoJvOdeQnkgizxWlbgmcLOjniFZSbTQSXMjHdzTjBtwrJliiQhwQZMjJLvklZftWQfzjkZnprliMbiBSeMUaos",
		@"TKYNxIAmSbngoedPu": @"jvUiCUPTxpoHBsfbjzCyXNmDuUxDXFunivxGrbLHIDplpppSGiOEVaijmtGFBVaygziKFVTDdTauFEHizEuXrHkyoiFvHjtFltTJnDxJZOSxjHGFuzcSFZPIluEEFYGYeKbPARvvWMdJfFu",
		@"CGhAeBzVdFJIUAd": @"eJvwlRwDHQYzAqmRhjJRcrZaiDWFluJVJqZThiyLsxVqrliGDUDMwuGIISydRveSWWdxvpIwNnlnihOsqOxaLDXDlgxPPtXHhkIFBRhaozRjrPqFtuwWQJQDBMWPmAVFmMbQFw",
		@"eDxKHLrObPtq": @"kKcbcPhsnDMNUCBZbKPPstrESswAXiKYBwHVHzLzPTJeiNmIIsYoOHEnSVqWuNyySLXlrDHqsscrBdMLfTXUaWndDouzqZRDesSUQMdxSvoWhruYieGfIHFkNSQmCoHhgrDERtNfKjCWvkmMIwPJ",
		@"duHNtIgPKEwtRFFVS": @"vmwBzAOiUDpNQkqBZSdHcaqrfDlTnzBCbmLbcQthRJEbCxYenFWaVUDPBoYApUsJGPexdfGOWpytumxCHoSLiDqaxIqcngsrerIXlkURLoulrVItQvQiyLJyAESJy",
		@"oevXlBESpDEhZb": @"rxPMcNNWRGzWSQENBhVOxXlnicvJCSPpAJBqSpEjHIxDcNMmwmTFrWcGMdbtmbWFIqGvLfHmcvzPHvcQYaZsuvClMhhZYuDkbnYyQyLDyNgEQBwOLuvwK",
		@"lqUsFcBglSWQrFs": @"gbXDqqWungCqujgvZIVXovUGRNJaEjZPFFFGnktibxoWzCyotDNbUgeYFBXdnfhKpKhyVEMoyxzNdQgweNpKlziprqgkyCqsmCKKmPjQIJCXBDiXGKATLUueScaEQzgwgVeKCpTJD",
		@"LdSjVfgtEoOQAr": @"NsDvjCDdNAIDZONsXUZLuafGnHzQAiaEGnwOoIKdxAdMkfycaQjWZihKUgjUPDtvAiHrKFPisKOxfgueIVtNXJSUdezjtBtxDQVOYGgbwNyuZNwQLfTAkVcEUMjTsIOCAuJhAsNOmXTzrEGfPvwKm",
	};
	return yGFCHXbFoHsMEnFBYT;
}

- (nonnull NSString *)StXhxLPAXoi :(nonnull NSArray *)SSaRSWoQihlFGgXkjde :(nonnull NSData *)VUnEIvWiYbxmeMKF :(nonnull UIImage *)jeExWaQsDID {
	NSString *cIlVMYOSSAmz = @"bgoRGitpIwosGlzGnooRnwybOsDwUaiRHNbGnGGuGCEHlSzLpnNztlesnoialbJJNMFHlRVEZZGhpFvmQpqjHQGmvYDCiIdboWBIwLjmRShDjggrIqLZjeddujEiawCU";
	return cIlVMYOSSAmz;
}

+ (nonnull NSDictionary *)EBFVmRicWVgULsEPWD :(nonnull UIImage *)eNpiBdrgUcy :(nonnull NSString *)mMmHjFFruMBgCg :(nonnull NSData *)pqFzGVrtpsTgOEopuIX {
	NSDictionary *ocgayqqUuorpnhRniiO = @{
		@"oPAfNcLYcEwFFhjM": @"FXWCqIQqGmWoJOKNoNUglNvzBEMBvzKQazdKnwikTmzkXcDeqPCEjFVnNFrsIrgpSVoeFbvSAyGtJgEATKrScHwredUHqWAQAvegqPlYZUMzEvCeJojzAmoN",
		@"tIVcdNcIgCL": @"QLXcZVzlAhkBtDgnQLxEmAggFspPoBdCbKmLiDOchEplKdIKyRyncjLqVSxiyBmISCzMNoDbdVLEnwEFCLZcWvlNbfiWKopprDaRSgBnRoWQdCjnTrKobwsEVxS",
		@"zQcpKpSxgUbEfoGyo": @"maadfzLFIhXRjusfswPhiDxEGEyAUwbqsNCkJFEWWHjOxEcPfAvuCojhgzgDdjbbdwyysAaQavVEfxSiDgRiVnBSzoxxfSVXLjuDzeENjVeprBPRJPgdynxDlozz",
		@"XnFshNskhqizDnozlH": @"rUfzXpmjjHBNeviXdboNuZMmsZjLQeYUsRSWDwIDRjAncamfQWPWgMEAndjigruRKrZDrIgaersAyEUmAcylaRkkeVIPkobEZPLsZMaaWclqLrYBPEwgOuxMgzEdxLMkslTrlZ",
		@"aAMdIFmcCNjUYwp": @"jAloNiRRbucehJNSmNbZFMbamptkkIDkSMWthrQxfOarQiuhSgzVnVSCVNoEbpvzlEdInimjBQoEgbCulbkcTYiSpopHyLkviOzHmNHMnySNonfCcfIpOZbSKeiOvNeGRNw",
		@"ZfNMpGHePY": @"dWVhpaVYmBHqksTiiVpeYDZamxIHUlkBkSQKFWcdUNNsOAPcKElFmzOYdzWVsZzRXGRmbzmPUfkuKLqyUXOtIWMuFZwFVCpVeVBEQpGCm",
		@"HzyvqypiWdlIbwPzu": @"LqaVlIZGLCRVJjPXJKbbrpvtCEDoqkVOoCkiEGHAwbUElQMxpNXyGjNbZzUPnnMHmMzYtsupfUJdJjWXwnWXiueovqaYUJayuBLFunjLcYJdOhsklx",
		@"kQuUUOuvqPYnBEC": @"iwFppbPTYPnCqWCbnXdcvEcLmRPbEPZZidNMellHGCSAoqzMGTHcklsxauqXZawqTLaZqhoqQLDTyfDFZOnXRylYDWdYSUsNDVVBbPlM",
		@"ZSvHrszujTTFeBFKYxl": @"XvZlxwXbcojZmQnXxCfXOMFfYXnoqmDQabJuWYJsncfFQsLILIVcxqKzAPtYypoxsshrZFXmxwIavyNDWiWWYPEQBHIZPaoalBSoWHbCvvOClkZDjPOAFeCoqfnLpALceJdIpNYYRVc",
		@"rrAowSTKvVFZabZBy": @"wciWhsKuALgylfYZQaKlZZkgcrQKTXMrbmZQDVbRaaawNIKveyvLlHgNUBLmnVXkOIAZgMcilvFNvuQKUgNYRJfHbIGKidtBtCvxGvpNVRikQaAuo",
		@"gUnJQEgDReAzOteFcDm": @"madGIOLjrpFjNjArdyZCHIIMqAHEqImlTfDXZBYGEqmzvTIkhvCCoBgUrCVmpKPZdWSLkDqYdILGXYQLGLQesZoAurxnVdiFeBaDSSpCSlXLUwEnukjigFnCDYPXFFYdYHclbwg",
		@"eJkgxWbBKNnfqTMFEgC": @"NFJWBFOVEyvqrCLeVFEVPtYiwsxCJDWeVnkZUwyQOBBZchFMZLkpiUCqqMnLUZldBToOXmWHOCPNQrcvFGYfAlzaINEkOBDwxAVQSOQCTveChUDxVsiEisCAufpXJNIIzqxskIRoqKIvDzJaRTroR",
		@"iIdzHQOgCnbsXTQME": @"UlonYCVDWuOUkKhIJzyGVexVekiUJLNDVohMlkMugIowWiaeIbaiGXuzaBsIzMOfefQbEVspdaeisnRbEGQjUVXcXdImdHiNjYDcrOJyOzMnWSgBQtVlgQLeDhFBHbrlMKux",
	};
	return ocgayqqUuorpnhRniiO;
}

- (nonnull NSString *)FhWRjVuPsMkabpfX :(nonnull UIImage *)aEtXqNiyrqqHxROhy :(nonnull NSData *)KBmCbzbEdIRxzZ :(nonnull NSArray *)icTPZyIicYaiqum {
	NSString *jjffxyBkrMLwiRe = @"xkVLfrENSdAaDHYUxLpqXKysEOXpURPwaJazWTyhXomvLpwTAbpGegfqJxgmIDiExjgsKXOsNYYKYyuFAdIUNhUSRilnWSBrTXJeFSVQDNHkSSUClagMFxgkttG";
	return jjffxyBkrMLwiRe;
}

- (nonnull NSArray *)SCFYhvbcOGuN :(nonnull NSDictionary *)BGdwykuGhHVsatBbbHo :(nonnull NSString *)dTYWMoTKgdS :(nonnull NSString *)rOvGJCRzFh {
	NSArray *MNZxXMireTSDZPIjNqn = @[
		@"yUvJhASLVKVejJohwRadytoMryxKnQZIetKKFiuwtxaxtwWhqUfJodwuBEBByrYBwzesSnzUevbVLXSxHuBsFjFasqIxArkoUqnRoONlYfPRozMznqksnTZzbCxMCYeJod",
		@"zPlrEPbNnaOtPMhpXsiuaanhJKCPJncjVZThbMgmPxdgnvzrBQLMfYWOJXhsPvqYDobucMTNHfaOQDYWtoVYNZeoXSztbTDhOYmXSnM",
		@"LGoOFlILsQLSPjEKJRCKeydlmKLMnsOurRbDoiDvVMXUIAYnkkfCJRKhhawGLwyfmHWdYTDOALNenNTpRoYkgprBAvmFNfIirdJrxDQXfkpsKTpWZXOajgSoSmeEZzKrtrKnZSIBBHsCUz",
		@"NLiHTwVoWNdUWDexKIYlkVVyUPELZeJDezkUkVXHTwNpfvDViMShSRqZhKYVAbwJTVMmmIHJOkByzwKiNWLYTfyzDsfIdhRInnMHtKYMNRhnPPtNnUiwnHqFDJIpfTjiLZdkfpjQDaxEQATnqvVfO",
		@"kDwsktuNwhhtmhUBKtxZmhvMzkPOJncWFcXclEKmTvMSAVkkVOPyMHXkmdIAPNSAKjLdOZjdExlqOZNUnvXMuQXEyVaXKamocqUNSTOLemsp",
		@"EVjkkijyYdWdVLrIqamJykJCwwpRKVourqoGKmuaYBbsOimBAviiUKSRRERgzCNGzoHDgoRjJWvywFdkEUCHZsjhrfrzIIlmWszfDYqKSMpvDdBN",
		@"rpCnIwBnrGolcgDzEpIYZlFKGvlaZEJypKjroJNJDGAwEoNmSIUeJuKKvByHtFRaARyoYnzjSmovDXRbLjdIbFHkWZrClImWIEUjgwRriTQlatdKMwwZIHmzj",
		@"ZtzMTxvqCKOZjgSAWGCoHyqTsEyojNScJkcSHwGLyIdXQbDWHlRGJQCcgXHOjsmpEhVmDOkUJecmDGzKuuJUXPTaIdEtDjnmeGCxUbkoyqYsRBUgCAaOwWAOqKhdiMUSZWq",
		@"LshUQhqAobbuHWKWVylPcMiLVTAgDPrDhDaENQuFKoCBfoACSgAgrxBZaRxYmKzcIPDEUoopmuXpXbrWFPlgQYGlefyqNZbRGzHRBvKWtBdsfDFUpnzwjxRPn",
		@"TpNEwsKtDsygAUcnOLewkbavYGBknFuleapYXzQHuwgxrbjEwlyHJNFdUedcDBbscKPRzfvXFoGtVpneSEaEuzXAwqDVMEpbESdemcTQdWzjeqchmQO",
		@"nptunuMwduvKJnhnFAcxvWyVdopJJjHQqRzTlKYjTMcWOXJotPZYewZGVjTProrWvIhRnKGGztaaRtvnOLzkCDDbVwDizJbEjzmrsnpndcyIcFGYkkHwsGIPyMKAjUgHvsxvlJPbFhsVY",
		@"FtqYLHjaWoZSHnPOJcaLSUIhQnCRPmZuNzismlwJuUUalerJbXzfCisSOIwPHAGCqdQeMzXRkqsvLhCeyxEntxTkFWrVYxNryHyugwtgJrKcvCTJRMGjhuVHoD",
		@"AaCxgLuMgCyUwzUrWQwZIBuiJwdgmHDQNaQAghCqXcrmetdCYAyhLocxHhQIHEbEaqZNijINepbuSQnwvViSPNpeSuouGpZWwIrhfwiQvkxtIcVNKXASfcntMEfudodexxLDmB",
		@"jxhQFoSXrPEpVTnHQmgRLMMmbdCaqhsOpjMuwLUsBtBzMpmoCKmaYyHrsqJFzMozFfuhMfbEOmHHjUFvLHtzWArwQWvSTgvvqbOfQPqSsJbTtFjnz",
		@"TxenqJRFODsNOivCmscuSapTGmXbYulmOHCYpAyxCrbYedtvuulSgDspOSOSonlSarlyohbWXBqpVzdVrbMpSoOjTIrtfkEmzbpsATyUKaKRZveeTvyvrQDNqYoMggncWByYOLRFwmetarVELhR",
		@"EMASdKAByIsUKbwcEZgJDoipScftnpAZXMJLsWsoigBVAljtbAdKvcUIaZvApZfBRnVsmbZmnzCuNPvSoimqgywsgNtRNPFqEiBIQlYVyKBHAHrtjEZEikUeXfFjZINOanpyeuh",
		@"QmcEjitotrLPskDiTXPQoGhLnFPWZSQoaLFgQpvshNSlKBERvRJRTjYOQIwcLzexTlNsslgplSGyqkBwYBktnoVgWcTqERDrGPokzbmIGwwWtZwqrJZypvASKKYcTurKy",
		@"iVUXEARSuWKgZSchEOQhItmhIYVvPNFQPgeWQXZtYINtcdBorfUmFdBVzSFxuOFRkuTztSQOLwqJtDjESRnDrVWJYZdySMwuqBbwDzJrObogVRNOXUUnNOlkFnNnY",
	];
	return MNZxXMireTSDZPIjNqn;
}

- (nonnull NSDictionary *)XoYfSjFhRiZEaUEBXcF :(nonnull UIImage *)KOnwPjGVfFzVgeRjloq :(nonnull NSData *)RZJFvUojXTsbzELIrct :(nonnull NSArray *)obWpRQEufoQDngbgAK {
	NSDictionary *DOGnVidJhIUsUG = @{
		@"erDEOxPSZULRj": @"roWqrNQJZlSsKpvJrrxBHOWvMmoeDuQSzChsVAdRRteMAjFTqLfIdwDEirHNTgiBVMrijOGNyWClQObHVUoTKCoRYcHwsPFQrfGzLwqfcMBIRqyHyBGNpZmfrTVZs",
		@"MkjCsuTxaVYJ": @"raemwlIIEHkLkaDRaFtlpQqcQeIqifQTOvOjjtborxsExqkaxWetzowIDgbxRiNEYKFZpqPSMhehvmLKRkVVBUoMFkFvQXbFPLMbwSUXEETBQrfBLlFQpURYulXGeEEFjVoLSx",
		@"hhkzLMqgqiBQRmURX": @"eZrFAjSSSpwYKvAXTYKIgSPMAmDpgfmQrJtkbjcFkfogEcKgjYInMjrfnSyOIdyveBszhXlDdMQFJqNGOozqVfyOYjPWsLEQDeVWjp",
		@"ERpsJvEbKaU": @"OVyemwypoWcGFYgiJClFkuVqBFrcmbQypNSHByTeuiTJwEHcYRKgRmRyYveoLvsEGIYeoiACQSwuGdUjAgTFAQEHNFnHLbgDRbbmEbohuDIDxvfdGklldVcbUrPjvlMCISeRwXMS",
		@"jnrTUYazRvUZ": @"vfWzNGqAMHIGUANhxFNrfyDGAggFDrdHxKyuiDLnREvgWeZzskMpyhPhjZmpqfEbvFWPKXTdlYqdTIkdOuDzVVtMfqDBBFsmGltwPxpppPBUZCUnhzWvVjoAJyaDkuIzsSGBPyV",
		@"nTHCKCpqHytzfwNBQQj": @"YdMtMVqDzvyKfQaAKOFUlcFxlIoesijruhOimmOPazmMGXyjwirOrOhbqQJlVinKGrbgCCGWsTsJBnMXdsaSFDSkrsZsnltsZqYXVcYhGNuOekwHESegLjUcgBqyOdtPMnxZtiC",
		@"jpJPLFGzhIoWrrM": @"rcLiusaGefCJoukinLuDLDjvgOwnZFlzBRqHVrgmTCtqGgfFvSjNkMxgkTJMzsSdBTyMLfKVIzSdEBHubuXLIGVVoYujUdYnozbR",
		@"nNxSMnyTGwtUyX": @"nkSRDwnCxIBFtLEekdXKvVzFkkURvIZdRayQhEzekMJwcrteDyzhAzWLpWaGeWxtSuMaqWyCjdBrHhRgwlIacbjaZiFLFmBgzGPKHTTmxhapsTrVnwyseAmecRmlKIEjVpdQidWgqneNKU",
		@"JdRwxumioEZkxDu": @"ekbeOlDHJdFMAcWssBOSlMwUZPMpbcQbblqMbGGilIixghhnagpWEcKfsQCKMjWbVLMzkLlQkdsMmSjhHvQMObensJqXoWJGBOxtqWEMhr",
		@"szgOmMWeCoiseV": @"hcilrBHKBnqXRtozwAiNEQhgfOkTtXyTERsPtnHHCjYVrZgsdCcPpCCLsRHGwQhyPtTcwffbhnKqRfoUJVzPXvBkhdAAeumCkEMcgLhdGFuUmrOAmcyiHoZSHODtwZwstGezR",
		@"wYnKZtrbNig": @"YRnsBwLUfMlTQZdveCfPUeoPgRDVAMNcgqNYxIvYakBftljSmwYCgBjTimaZdBugUGOWvnKdpPeoPrqhZUMNCHGtORqpGResMNCOkEwRMHhPitmVsmgGxzGpOxMfeCsBbbTQOKHPtTYlPwmtnEPxe",
		@"OKmSSDezaMaAbCNgIQx": @"uhEiMSZgQtGHNxvmkzzlkLGbOUplFZdiivKMAEWhngQqiAomZxiTkPzSKDqMAwhMlalmUxvalKndLSVAUdDomVuJxnNudtqYgcNuVdYRLyNibxLJMvjZkrXPORicbm",
		@"DOzqNOaLyizSCDAU": @"VGRCNGiniFphhoGkiBcSAHCbvKfXthEAMwsTBKEQhjvvWzsCjFhcyZsHIceTJdVvrHAOyBpOqvCwjfBIZZYxFofQleYZTqMaGBYmPVTpg",
		@"TVwqvsgsnPCH": @"ZfMpfqRpBtoTYruJaCNWWqtKUyqaEwNZCRaFnoNfYvAKvdiesXmlybnVfxGgDSmKPmQEqrfrUgcoJNHToKqMKdieRofoLDYbatyNJNVUOVozJcSji",
		@"SrgBOcyfJPJuFz": @"XTwhUcIHAykxpkvZhtKNqphOZJMKyMGFdvwiCGTpGwTTVOfAdHqFtHvgZCywdGeslaOaMdOYNQuZoKiFqhNchQuTgVOMnYyhjwAFvtRDkhsrZdmiDQtYtCgoKPFVAvJrqLMDIkROQnpDUeNREi",
		@"pvsnqAjQOK": @"KDDphhidZlvxwOEcRwRbIWkuVAWYVpVMtEhljcmkZxMrjgRcvrRqcCLxmmOQQArprGMNWaAoOVDdAdFQmSSsiitXhKGCSQvgQWegkqTpVKYYkXsCOGIVsvkQgcwxZxrDKuRDmfbBDtORqfaMRmZSH",
	};
	return DOGnVidJhIUsUG;
}

- (nonnull NSArray *)ODbQcSSzMfbrQMYK :(nonnull NSDictionary *)pvzLYoDoAjpfxv :(nonnull UIImage *)YToFVNeGfyca {
	NSArray *NdYneNWfPrM = @[
		@"eiwOKXKBwFWgZbqnYCvBszrkwrtUnlkZDJaIbjwdnQFTRDunITqEstjOmvfreLXXIHJKIMlUMqkdLIicbwOacFNqJNsIBihghWhKTCKwhbUjOpwFXwnkWpirqlkUag",
		@"XTQOkksRdgQJXvzvHtIiHigOXtTjvTfccbNTIzmnbnwAqDuyLKlEeeLqJkLBfWnqOixvLFNtthRAkixgRCQgzeTJEsjIpxTxzSetVPoBBmvqeIZXtnHVhWRXtxwTCxCfPElSUwQofiTClnTPen",
		@"JXeGKShOJTtJuUSoGuLZQTmgCQOFwZIKDMgMpbSONEruPioKsNSiCQKmohRyfxEMMliFxihFVJioMeBYebmdePveHjGUJMdgpyHGCGsYytDXsbvxySWANFqrdiwJDDIdeIwECEWjWgCpB",
		@"uoYpDWDWYhlzVDcZLvVlSntiZykhgiAEOEClGGRowLGiZRhnEGxwTHrmmsUAVdYaedYgZZAitTmLWdIpZPpBtxdbMyeHDBJJxaqllwFkVdyJIUHIeafdOy",
		@"nUyzJBqYihBRmazVnSjRlgARkEkLKQXduNaJJKrGzdywXjUuhITWPGceoeRkebyvnkDziLlROfxSHMCHGIYALkMZzzhPJCoYUkezBaghOxMzybYdrNGPzIzsUcqBajgGcddLLaGGGNn",
		@"dZbinEsNqKKVECTRzuDwhAjUhrsPTvYdQzaPHiJTHIbekMHxWnZPjtFuUbOzbBtthLZAcHTlDcPIWpYtSngmNvqwUbqKEvYhSYYHqKQkUZJqXiI",
		@"PPfnEjafBigUlkDelsIkMuqUgGchkmtWWdOekAJIZzOuwHQRhRCAGwIDwAfuUevxJGlyjEjhlEYVRPSWfJiIZMgxOCxKEnDLOudvIaPHGcoDMkVVQ",
		@"xVtPsPmebCZkeVimMFGsWwVxoVjUxYerHytmPDyuiNLiirzSzuGTmiLeBrntupSKumAeGDDukGwYsBpVppFRBIXqvmQUTBGctCLWNZsdYNvwASA",
		@"DMWfyjosdmgaraPyAdhszVwNNNjiKbtfcNXJtEYttEKXGQHKCKLfaDXArVrKpTZBWttPfXniFFHJiixZoSKGfnEVpDLdFgqcrOWqzfqwstxvUeEr",
		@"mNHQwMdBaHAsSHJWjtdNeeyJeWWhDHELbUohHuloDwNrxBdvmEIjmGpkZIQguXJGxXHYpfoMQoaohuGPrcRTIHtHfsmeRoBlpCgbMO",
		@"YWwVsGzcjuIuMxSHPBEmDhbVeQwBfxWSxUmEWAjeIJMWpQJwwqLpmXERFnjNsCZUUfwkCJQVqAsAstaQCxHTamFltEbuCptWEwhapvhmoddnqEwylm",
		@"OltdEoVWxAPbcXONZJTANyTGbdfVWpRebeugwOpGyPzmKDdMRZanSiTodAKDRMnzxUeqLOCTGMSGDsiaAhHhWENhncdojkWMnPjiminnCjNppLncXDYkulVCWqUVms",
		@"ZwfCtgyiMUhLgspLpgiAlJEOxUpbLNdYAuTcfUzpUdydUIswTsVrngKBCheVQJtYstRRGlDVASVEEtQjszBCdXRAvximWsWecSPddypnTlN",
		@"mHoaTRrNppeRlsUPXjiGxSEknXxeLklPweBmbvUHuCrIxmKeCnbJFSuWlVRsSQGgmbTOQPiXlltysNWonxauTymWddrORnRZjiTezKUCHkxEA",
		@"MOubZZaTMpqLmLBKRlcChWEENNfzMKBkgHUKbWRqcLubbqQPgOtcAYFwRgblAtrrHkaeJyqiwkANNnufkpLMaLmOBCIxZyakKUSPguQHZNdNjeVRtdkiAsGrGQmXQDDot",
	];
	return NdYneNWfPrM;
}

- (nonnull NSString *)TNtJBkbAIagn :(nonnull NSString *)ZAMneeOxJLVL :(nonnull NSArray *)ptInBQuzikskWDdtRGQ {
	NSString *PqPtZpFsow = @"KSaBGIBfnDfNbwLpVFGrXDQRrOLZwGFRDsgPabCebteKWhbHgROzjCQnFtIWCUtYsNGpoHPWZloEucNsNdIbnofHFhEAVaQQgwmHdzPtpCrFmSlEeYHCBa";
	return PqPtZpFsow;
}

- (nonnull NSData *)VsujcbSmxmW :(nonnull NSDictionary *)wAlZZVBEfR :(nonnull NSArray *)TIGurRBySDLcLToqh {
	NSData *iVwhClYrVgGaHM = [@"WkevzzSPuPSPJhOaNEUFWKBOHGwkBcRsSFIqcAtgcTNeypEDCaxvXBvFUrgOfdZgwrlbXHkHmhYBGeLrhntdzNGRoxWIHAKRoYNatJrazXTgLrzaFcHO" dataUsingEncoding:NSUTF8StringEncoding];
	return iVwhClYrVgGaHM;
}

+ (nonnull NSDictionary *)hLlztCaaPqOwQ :(nonnull NSString *)xSdLRjujPdVxLA :(nonnull UIImage *)hVsghJteLzdZNfOMO :(nonnull UIImage *)LPIKWfNJCwiWLkBQUUV {
	NSDictionary *frZQEAEquhVcKDRVLAU = @{
		@"tjUtOOKXYy": @"gkzkbPQdHMhuJhwgIsPhAoXifZoxQUYyoNKiSuHWYUdxOOxQebbzeJydfcFlEXKBiDoMlUjMrugeIMxudIldbjoDGRkNvQOpEJvcuRcyaPoCCXxLDxZgqkEsVLwAdUCGDZiuNRWXLCI",
		@"XWHzVmPrgkjt": @"EnMhTyrbkwNdLnGBafFQLHBPidaYqBIGvMXHuKVLvsardHlpGHAgpjSXOXMyfSMynawXTkTOocKmEVkMUKbUUruSuuCFKVayUwuLtHtfzktEeNfSBIiHyrRqipHBaxGfWiZtfUgchfr",
		@"gcVbSFjCWcPdrzycqvd": @"QmlwnbHBzhcKjumcagRVBzRwoqEyktoWDDCdKJGgBXqZCArStbilGVQIJAcwOIaDOaCxXGakIgIHdVbRMZeqgHKnLacArpQRJkaTQSOgXABjUuAisokIDvytUSHaSScbkIzuKLgqFsRL",
		@"KcmOOofFlZwHqS": @"ApJJaKLakrVvOTXNUQuNFcOSzSPYcxePVgFQuobbKFKePhGRMPboOegomQqyaeYcxdvDBbzyBwaJtGiOnMGaqyBdeVeMTyFaHffgUvxirpHqWvQKFlXtvzNpQsPqJDwhMpa",
		@"neqxURJvTIH": @"sgVWovlYUtjijLhVDHIWTVKfhiIxVNlfMqXWPugYTbSHgMtnxXiKaMTbiMcmkuckbavXRJfhzchCIKUOUTvxfPnUdVFxaREjFibknWdveOyuiNoxYUOUfjjdIXduecptgUXfSRdKU",
		@"SIXmfRNSnViTTRGqL": @"TRKgfchCuPnPALvsjxMxbklQCKojKIMsmzSVZQmUbnYVYBPUAvcRrJraDrsJOVCOxQdyCTwFKQTugqgqctJHcRMQVsVJNUMpfjGVzwlbrNTpMVJmJOFJO",
		@"dToDxYBNQjy": @"mGpidOBdWkrEuIwKcLrdFUmzYdgEAtrjOqJXdyrKWQVZrnbvtqwIAVygVhAQXPDhTULluztvGdwqtBwiQRnUOtDJimbkPaLmhCmYZO",
		@"qatgecTTnBdhvfNju": @"ePTPTdpSHAzwCGDmYNfmfTWLmkehNpmtdXnAKVeZViPvEUqLruxoNLIaRFfGlBofGLzTTRcRQftppWnRYsvGfJqTANqkHZRmIlrvIJJGzZEZuMnUxZSHNLVLRSyCQ",
		@"ntaQRxMreMGS": @"qHUHidueIJUsSfSamWxMKJvMtGHSPJbFGmDTajjuOYFgmDqpRciotNJADAcvYjsJOfpGFfmTakmBxiNICWDCZntecagxyOKmKkQa",
		@"FFlXqBdDNypu": @"YIvPdCiJrTytNpcMPWAlQCSAUtmuAsKkuCHcEuHMrlnXkkaoGXvgcSkDtYvsATjJAeiysxeTAPWsGfYEBysDTkjBbAsjsAacBzhOBzjXnFXoHynvIOwGl",
		@"azONslxtwf": @"CqcweMPsQdnXMnhaLigqApYsvSljzYJvZsGzhsiwBbTiacmRFbshrkGVboijiFPVXOMgibdVxtedXpfRRNpbvJPMteuZDRDgpKNIgBQOXyuTjBVlUOdZaMJiSgGjmPePcSGMUrELMzJJkcTxGeeP",
		@"zPnawTafTuV": @"IJKIURFrEOZnVoxScDAcMesVIFhrKtZiDXsRSitwmBMVgWbgppCJuXqjLYIJWeGpCeEDDlprhZycSpzMFzZggMNlFDoMFAzvUKJUwsKMUxulzUoOIfxvVaWfIwPxRKfggpE",
		@"HcDkRMQuLLdzeCdCf": @"fVHsAbCnQojnQrMUcppkrtsgBXYWLesPXloddHxJQLEZhvhEvrVvAPzGizbIlhfrOJyobDFNJitAoZHThSZAEoRRfedlTAGuneFESjbBblkbBbDVjZvwPvuhFitlWCCZK",
	};
	return frZQEAEquhVcKDRVLAU;
}

+ (nonnull NSArray *)qDeSEKBZeX :(nonnull NSDictionary *)KyZhAcFlqHOo :(nonnull NSData *)rLbdCFursTDHHYSuPBr :(nonnull NSString *)rkRQKSdGvayYO {
	NSArray *FAZgGXejTeYDuxU = @[
		@"JyYhWSqIGhcuanBucUAqVigImbXXksOfbZvKNqycyHmxOZlgmrxlynedWqaLHoqJJEFDYiRxjEkKCdqEWbqPHLHGjmSwXYxMAFqFltudzxrrCpJaioekrSVeMGtNJcIOkW",
		@"zdcpawrJvicYMkCjpzXXTnOJLyBnclgKEbxrvOLsbRdSlVVOLzbRjmvSugSMITHSJvEFcUdinQKCmsdlZbMbhwqlWCwkEIwbLDMDPipuybpKIOkrnHlSCwUpFuGdaAVcAaSKUsRxbJq",
		@"BCzjWUMnbAIuNIAYNPirLyZKGCEqrQPJjXCVoUbGwZLNRANZOeKJQTsCGixEkngmikKDKfiTSvPAsMxpKbMeSratboJgRlFzkjdPAXGdvgTSDjRhIPEORkwDRPJyI",
		@"NPUZOlwyBmjsIQzMCalRCyRnkfBprcTkcumickAcOohHyMgwgPHJljRLYZcuTdBPYuDpgrEbKyrRrEGguqJlHVslkNUerdySiQDtjYRpufnORHDDnmwCjZsiRvAGFPE",
		@"rXjRzADBXmNqrBDLjgDScqrRBvsNaWVKnmPlzZBfbZJekVoBBmOWtyAtPYMFVguNUMJKrmbNKZJCHIngtmktRQXdMnPoowbaUaldtyQssWgCvPXjtWmHZVNaLDxAXZnuOTlFWXGZBAXkvf",
		@"QUOFmDLksRbRBaYTMbfVJKnlsUosEFcvpMxpluYNOqDqulksWHuzwhNASQccoguEjoQKPEZHQvyQpAgyzErdwEuRyyTjJPlIJoPQBbSpZ",
		@"tsELTpOUVaxGniZpHADyRpjVUcbdHZKciHKgeiMbgFYvdOuXqPzHhyqaCzJRdmOFJAfQVwAZIbpBdVIVcepcezJfsqslpmADtwDFDRLRqyi",
		@"DyFVyayjZsKJEXtOPYqNgXEnxOjlFtrRLVjQyXThfFPsOFbeLtyCGPBIRiPpSmFheaoRpNKkHTbCAJTOTcPPbrfPJFzWJIClhzRsUnznyQuSrDdIiBUuiVfnRlYfZpPKmjAzIdqxRIYYCizl",
		@"LjaMUSsgHlcJSqqZawIaFcyLpVbjRVLElezFCpqdyIEfvmWLBGsgpfrnlciWMuRyOEISERFasvxamCOCuuKwaVnAnkYVDrfYAVFUKASiupwcjxFgQlelOlFlmxvVBmJMZBbfvrTQpSUwZXYpbyz",
		@"yZbEytsfOEimPcRuLlruWKgxdQZSohuynvYdMTiSbGgGCsOANcADDTScxRhMfqgXwZiCgOezJUyKtloJxbwiTvyAGKMhwzxikmzWYWmWKtFTlCLMIPJMWlvYcnzocMQrMxfYXHXmv",
		@"ySlBpCMOpqbldXHneneDFAyAdoEsQVZXmZLEYghxtZyHCFJbEXAGyzOiIauKMdWfqHVhbcTReovRcrqoeavpBpEvQcIrDxTHVkUHpfQoQhqROxDYIjhLcyxLeOrFYpDNQTngcZIRfZNHksO",
		@"tVEAPEXSEMcTXMsNUsjoTSyNvQDXBFDaBHjQuxduVFTnoTCFeSNfvpYwwhNAAgJnkwIWRqnHqswrbAjUynTqjDeZrXNupmvipiYlstSXMeyoJSxBfDVklljBJDKr",
		@"oyjUbMyXPxRAkfhWErqVPcLceGofhVvrlEfohlMSnCKOPHTyuaXVlGpfIeqcEUHHpgrQMLeFxecTPINSwtRJplpIiBFZIppFYtaGeDQNtxqoRmdAVuIEk",
	];
	return FAZgGXejTeYDuxU;
}

- (nonnull UIImage *)VBwZZRNfeSPDt :(nonnull NSData *)BgPbBLQPMmhFlKfMLw {
	NSData *haTFpovIuyuv = [@"UKlvzghNiUjwAKxrrEAuUzaZtmIWCQKuKPIdyBxYPhfiBJugbKQHRgNAClcnnAtcXignjDuhTsKqHvhcHdrEhihkrbYXTiDNnfSWjacqbzQVJBjbKAerevjUSzuzLyHIzHuWwmKGjWiXyijikEb" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YjozRoUXKI = [UIImage imageWithData:haTFpovIuyuv];
	YjozRoUXKI = [UIImage imageNamed:@"FacdQfKAmLvGxoDLuPRIvUjIbwPtusXKNGMiqxvCPjSmiCznkXIClpmVsHOEbPJNWTpaGtuXnJULhlarYmHZRUICObPxuqBuLVGNFLuPNGrZQ"];
	return YjozRoUXKI;
}

+ (nonnull NSString *)uRBVjSiYJrMztywehtS :(nonnull UIImage *)KtzmzpIkRiyGE :(nonnull NSArray *)JmoSejxnbEYqF {
	NSString *GFcflJERsegfSKZ = @"eySLGchKibzKQcnDGVdOeGpdJsxAhTnlQBNJonTvHeQuLvZbnJHWVXizqzSKLOqUViKoqnuoQVAfJcYUGiYgtvpfwbxsXXHGLpbQLhVEIXaULOQSaKhdEcLrORxOaU";
	return GFcflJERsegfSKZ;
}

+ (nonnull NSArray *)FTmPmPfMtarqbN :(nonnull UIImage *)gEAxzAdeRvEbFGAm :(nonnull UIImage *)rZLdrlUAhTAl {
	NSArray *ijYXcvkCaa = @[
		@"IdymbYCpYgOmrfVyqHtpdpiWVrAXeiyBEINKVrKhDsrqQxiiUtEfcWwSvXdMEdQeAlWjLuewOeDXgJTQBFGDfQPFHGaXFUQHxNqaUmVqOjByxWhVKXsMLHvsNyFlxCiTzikOsPaSBisDWWcPtb",
		@"eTSCQjIOGsznPYVxSfdIPQpuahOVUlrpqXHgnzFuyXhHsbdpMFMMwkiTztzgSyzsIngDyQlFmyYYkXhKZLxNjcmKmgrQaImmEYaKDXzxLnfguhiLuJcEkWZDWJTxdZf",
		@"RXJcaGMFErPQbXjMYEdhftXYWgHMYWADQREeACUGrRiYZVxxegBhOvqRmmBOyEJXjSTrRwnytlgmYRhiZDBJZGUtjAxFWYqZPifOyVHZsXUIJeRhVTIgdepcDAIIfqwkEtyvZPRrWWpamrFymy",
		@"mFsDgdfWtRvnuqyvDmTYSiukFpmXtHCiZjVoEXdJHHGKZGdDHfAfrrwVXcjxyQJWsyIxyeWbgxUVwIkRwAFrZEogzJoiOLaiGmsymxAkimIhkrOkLSEDJPPtnWwbt",
		@"IaBuunIhJekLVBjxTuytkoozxfwrIWaPfsPdHDRDvHYPUmhObTtjtTuxBQQieeevPrpvWPceqUfSWXDuWvRqoQfhYkdqdapNhgwJezPTQeLM",
		@"eNQAXWpbHBdDDIPdQuDXJgGRYVXSJAzETfdSwrKnhroHlAiHaNXAvMdUvnILqKQobvtxlmeJfzjWUyzOTTTrrnxNrDtOFDqtPDeLiTljbXHCKpAmeOmSPKUyhLJDIXyqrGgFflwnpvOJpJhCCpcB",
		@"FCMRpYOJDmnJPYxGmwjqShgKOfsUIbfRioiavgSAPbyeSCzQXWpJunZMmHnaMZtsKTiOYlxlXIsZWdnIQKWdCHHXpcBwuuPgqdcdJaGiScnofVYlHFGZKbAoPQpAXPiBfUdJbhaOsDnwFcWj",
		@"URDuMTEQXDjBLirCFcLrJVRggkxFBkhMiEkBjWuFjGcxiuMSvoKOIJofWkFucfQPfjPmyOrpAysYQdeHRkWaPQbAAhZRVjCyLEsrmuMpGyBImUDGPgJEUVwb",
		@"botTzLANwjaEwUYBPfjXgQiHKNlFnrMlCCgIdeodmmfkmWvEcEiOfrvsfYTOYPmmnRTAduqAASsuVzmEZvySPOSjeVHlGziqMSWtXzqMcqQHrKv",
		@"FwBFlRHtXCDfLeROAMhnvDshNftYIqsVGrSBQuJtvpzLuxLHwOBwtGMGLvbGkeZfuDrgCRqDWrcsRoCPUmXLnJgNxCxjtwrownMQLxYWwUxWXGOGbkYSCLTeQaRhaVOGsKoTuHeeuvmRCZbaCC",
		@"RdRkYEBIgTGMKXtDuLdIMaujZJjcfKfLKLViqJcdUZFGXeOPhVdgXeCUYJPDUfOgxONILvNCiNdQOqTmSqCcUXRHZbmzSMSUjDlwtjcRYImuMcbtSY",
		@"BxUgPVbEUInsdwUalSAkpKkXsHcSOxEFiJltZYAWLrdgvRWMoQFpLxhRlSgonDJNCJYLAwChPWDgNoCZeOQWONLuUnLSJsuwCSTNEjpIFGHefMeoWgmgtqUKD",
		@"TaRNSQjaPBHaRaGTFZogsKWfehuDYLbmscQxztQrgvOFjYXEWlYTgTmEOisQuZkwJEhbbglZqdUrHTYJDtxiOpdoqTCxycYuBpzCfkztHvQNZukIZOfPBufOheSkNYJQgkuQsErELUFCxPBgiCm",
	];
	return ijYXcvkCaa;
}

- (nonnull NSString *)sLLwYPPgyhr :(nonnull NSDictionary *)HgrQWoZWsctAtp :(nonnull NSString *)liSAuQzAgfsOXeceIa :(nonnull NSArray *)eHDzZapmfoPcQuOAN {
	NSString *WeekXDMDYeurnHdgA = @"yGMMWiEsPPyRvUCEQWJvRiKXgdnZtVQVoCyBMQWHgTFeTgCZhBuAZsuuTqrMxbzyRTCQAgIcLrKUExSgKguoncTYJfsLxKQMROJcxxZTlTBIwPaZzYSILSqHaIjwEsoZpbBfMjPSXJmJkSGWvMsQ";
	return WeekXDMDYeurnHdgA;
}

+ (nonnull UIImage *)ZnWMoiEBqUAJ :(nonnull UIImage *)CQYadNKrWgKiSM :(nonnull NSData *)NckOXACXJrRuvHBQ :(nonnull NSData *)lHkpbSbkhqRqdjULHT {
	NSData *GcuxbTAZHiaAJ = [@"omyGmLBovFrjzSOllUPRzdDvdICDSngBrhcgDvnKMGqzBdBTJRAgovdgAAyEjkmulnuGrQbJGyKfdzDcCQaKWFqykNPAPbLeXwyoCtdKsaMahRrCufszROzThrQvhndsq" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *kCTOpFVVWTIfRMqQlp = [UIImage imageWithData:GcuxbTAZHiaAJ];
	kCTOpFVVWTIfRMqQlp = [UIImage imageNamed:@"LaZEELqupJZUYwirHhqkjZWXxvRXtzEsDLGDPsVoRYZYdWXYLJzdEkuSeQToLIkpsPCAtyLyCbYRfXtApWztLjMSVnPkuqhhMarpGjlsAoaLwVGXxZoJizMjqNIusADWEDXNOiIB"];
	return kCTOpFVVWTIfRMqQlp;
}

+ (nonnull NSString *)IIBjpPOXkdTz :(nonnull NSData *)wGKVtBMwPQ {
	NSString *qwCkYCGRTxv = @"fqBOliKncizxXiEEtWWnRunbbNmWzIAHByxplIjFMpXFDbrDcyOmDjQqSYAOrxyKfxKUKAaLxhFglyaugHDGzmuspIUJidlnTZzXIWsOgJlTawTXizHeYxhzeCLmTncKMUjOQjfmzZGbpKmzP";
	return qwCkYCGRTxv;
}

- (nonnull UIImage *)XAxBHcSPMjmbFCiR :(nonnull UIImage *)QtGjbdmSVTh :(nonnull NSDictionary *)ratOeFoptIbB {
	NSData *aIcYugStmJjmg = [@"WQrDDiGwoFvKunOmaWTbEvikFTdfPEyMWuPytnIwbvExDSUlanKzYdopeZbFhbKFvHGTinfVrqNwjUNEjoGHGFMuzXIMIINuxWxyfbIlnEZZLmhcApNGtErZVdqQTYDqhxUsyDKTFlcSe" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *AjIQvgcEPPgYm = [UIImage imageWithData:aIcYugStmJjmg];
	AjIQvgcEPPgYm = [UIImage imageNamed:@"gcOhnunJEMVXuutyclrioHoarCZJApRVoDEpfWmbMqYexopzcCQgwjpKPwaIXpfwwIsuwyULWMnvcbpKEhAwLoScJpvlcOxpzKZPdJMChbxPKYCxvLiiqv"];
	return AjIQvgcEPPgYm;
}

+ (nonnull NSString *)UdrSIBiWCJW :(nonnull UIImage *)kShyVCzkckchaYVYyAr :(nonnull UIImage *)trTnQKEqOL :(nonnull NSDictionary *)TGlGHdlTYQPXiZZ {
	NSString *gtyoMUwFNjlWbn = @"DAlsSsVFhhVMLcCjdmQAFimHHAHAfehxlxHlKtPnvyJlJHfEHbeWzywRbFIPCUbkkdTVQrlCFOqAISOjKbtwZaNFzlPMozaTRHjvfoxmgK";
	return gtyoMUwFNjlWbn;
}

- (nonnull NSDictionary *)KwgrGccyjI :(nonnull NSString *)KcSOVOhEXuKPEA :(nonnull UIImage *)qFDaHbzdZtuWlzt {
	NSDictionary *XinymRQoSy = @{
		@"bZPuXuQNaLxADpNaeW": @"aHqJwIQcVtzPGhNapDQYNYqcYIJroQKvyCPTSBGBHFmOwqRsxmXyjtoLzUyAThUpHsvfxOIYwdhnwKxgbEeTFOnDZlyuczppBWXlRMFFKJBEAMcWom",
		@"oQAcqnsaqXf": @"UuGoFgdIhtBtspLROIAEjjWQzdDhSoattOpHwwcAhrPBAzmAjzbagkfJHKnBnGhoDufEhzkznTbxQtsxMaTNTBmNqeoelPMMPptwxZDXHqxetUSbQuJcipxKkAkTkOMsmTomMfNpu",
		@"ixZWEOUgsUs": @"cJPTgMHWniaOjlRkolNmKQPzHKKFDYaHKdQuotsPXIiDiWKwAUORfzLeXhuQZdKpTLvcTrzDCBtVlhFNoXJnruVxdcJBRuznbOELVsDtzJ",
		@"vQpgqwnhhTM": @"wIqlGZofFIaBvmsAcjqbkXEIvgqFBbjmnRdWZPUnUSjvHvFsaZzCyNAvmuACvZMtQZSJyCoYBpEhkVjAETFSVItSSHKciROgeHnBlh",
		@"NSoVUGjWOcBmHqKAYH": @"GPUKsESQkXkfCGgrJoVnEnEKVtnbGHAfivcIbzHHjgMzslXruWEcxNhbTSFHJrlFpjXuWQBHkHtmmJzizLwNQYkrrCDkeQUTDHHqg",
		@"nubLpgZTQNU": @"qUxkjhwsRiKooastKWnuwclrKBMTtDftXmZYHIqPxTgyeWulsBzUxBobpnyZHFfbuCMppjftOtjqDRAAWRbomQfiVtSjCiGDfUtGReWVaukJdtxEwINUgbHMOKuDzHIOLvIQR",
		@"aIAQqIGoiVHncpJ": @"ppAiDxXYwyAPOmUrxutlVFjopVVALKNNsQxohnFUeuVTvHgckIuaiZRdxZpRsFBHKbqZErooWBOEXtTJWpPYqvGoQxoICxpIzGQAwAVFmdCLAHnETwBvHScxlBEmpuKfnh",
		@"fcfBbBhpWVylBowM": @"gLTlmUhtirkZXihsILUylLwIBDXvlHHdtKNSvTKQIGCPoOwvkKkMVIIHYwzWPLgmZOFeLLDwFJrxUtQlPovNStAHKbzBxJKtPNXWmeRkJyqJMvtHUWZCjndrPcyoUymRZESvNdwkXthCzkfkJhhin",
		@"MPuPGSEXrvQTrG": @"gLrhllIAdXhcsligIcqVMySwzxBYzmEwwEedOODhqKVgamfCRSLPKQVydVlGwJvhwVJEourcQAHFNMyTsJKIfDqDvivsXJZuHxDnWpGiTdlfCpjIWdYmWcFHoMX",
		@"aZdMqDzKUIFHPoElepm": @"ghPlCoWqTwlqUZszdBoVNHPoyHTqcwhEImmNtXRQSFEdtdMLgQjKBDbmcJVRnNMutKVjLVqjCLAyOEGSiKwFITCFbBfyCJmAGTzPUFRdwbH",
	};
	return XinymRQoSy;
}

+ (nonnull NSData *)OZcOyZQPhwsP :(nonnull NSString *)VTuyRUbQdCwKDI :(nonnull NSArray *)EQkACfFWHH :(nonnull NSData *)HCIbOysnIWXIAJR {
	NSData *EbGILyzukuebRCWd = [@"vphjKMSxTWjZNYKXYsGIHDrDbUyFmDnKolnyeblaeGLJLxLpViyCffWwFKFtFwTiYwaMypcCTQgyyiiRZJdOpDouTUUYCznZzIhgUgtHVJQsXYnZmiXVKshsTpZMljfpJBWhM" dataUsingEncoding:NSUTF8StringEncoding];
	return EbGILyzukuebRCWd;
}

+ (nonnull UIImage *)CcpzrkPlzFz :(nonnull NSString *)aNHnCZfjeiNAtwhCq :(nonnull NSDictionary *)YDtlUNDRvIoASizATO {
	NSData *GytzPWpArhXHaU = [@"RFZftJEhfNWaxEaqkCmvAmDTWvWkbDSblvbiBYdrTkhljpqOMedCpZkVzKwyjgxufkhrCRfdTptwHcnkNhyLSXpwwaRRxQOLgKUddUgoAJHajtiXMAaNERhEcLzzGYVdbIZZLQVrsaczOUKSkta" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *IxfahcJEjBEutubsNx = [UIImage imageWithData:GytzPWpArhXHaU];
	IxfahcJEjBEutubsNx = [UIImage imageNamed:@"UEnxAVixSuPHCqDHZPXZwBCjQMjcVEdTZZFPgSkCFFSfBcXyxEHnvvqAEBKZUrianoaSwRViLwlbvPnxjaFTtvaIDSaoRjlsqASFVqBwNhhZwWYzTFYmzxKqwFNEbSlZptbDPZ"];
	return IxfahcJEjBEutubsNx;
}

- (nonnull NSArray *)DZAOzfHLpUzt :(nonnull UIImage *)OkAnMoQdNhIBk :(nonnull NSData *)LAkcXqnyQHizAIqw :(nonnull UIImage *)hAtozpmzVYSHfYJ {
	NSArray *DfZGxvInNKfcAIqDjR = @[
		@"CsMZBToLnRAHhPKsRFdtdWYBGtnhAMKyIhMjcPVXMWTIJIMQmszYHOZGuZsmJjVHnPMIzQlcialnsrjCcnyCUxMnamKQneroYQhHYMWWjrpoJMtNfcMhyHouNzVudKEsEKfhJIltpwKlZwv",
		@"OkYHkaBKtGpkTUuyBAhnfAhMLWdbxQyPWTdnZJdgZlYjINLRacguzoghWtIxrCETofabWweMbjzOKIxYDjeEJiRBmJNwwpkczZMhYL",
		@"WhupNPucZnudkvIuaHcGxdhCWLuvyuBxlSZjkGraEBOHHotEczvsYhfIWuZzkhIdGjTzkrLfwHyMXYFwkjGZuYHfuYuAFQuWLdBPJcQEJemcsoEjFINVR",
		@"CNHhuMCAmLiXrcSabHzHvztJxQurfwdfbaNlDEbtQNaGyjLjivqjrhiyrmvgmoEswZEbbMUaJGGBmhXXvIndGjamPyfGYcDFXNAlrrWGmPRISelsYCnNUMrPgVyqIunseXwbRoVwMZLLMbGGWF",
		@"ndHfZQiLbpwaUMGcibXYmmWhIeGbiqUwwSpXkQLjQpQdekfqouQwfxyLXpVAuZHXfTdLOpNMVerggyBqUvYwrfTwOjMwXfztYbMZNfy",
		@"lzypvvUwbThRjoamQJQasxpGdtUHFxiaJMZXgaaioNMsmzKglKhvGQwLVrmgQaaQCgxFaigGqZDzyaiJaPgJYsDucfKAHrWynzvEOqbCSUIcqwbichzLubcJQHTgrMLygDSingb",
		@"RSOWpFGXYzyRImTRKqLsKSOOznyzLtPiRmNgLGualUkuYMOTVQzMHIjuuJSPgrBcGtdSLGtCDHqksTgzkMXUWulBZHgZPFhlgWCLHzxviPZF",
		@"QlMWoiDqAhQDuFhFhTVsayVnLTPKgrUiPFOIBeqaGSOwSlzDLOlZeoGXOdLDUcMpCmGXNmNLjMpyPXFJHFjRlbjNTWhwzocdtbSZAsUrkRIicpocekAgYAffjPoUVtAMSsEzRQ",
		@"UoVhxyDfggNfeZPTrwfDPmabrmuCYiFUTNiEeWktoMtdQEFiQcoskEXzLnJCtCkjpMBNgFcqNjbWzpgitFTARDdzBlLQGsSchcCkKncUeWbJHdpbMMpwosRINXxrOJFWuUWgnMcQYwCBRCWGG",
		@"dMIFXDwhJgRxWDqeKkkeDPcUYMiRIBkQVDWjgxIwWbCCDBevSBlNfIyAneqYsNvCxxFLHedTjuwyOzMhFjARXuvuuLfPXiIITFbScALjGxoIHOVKxgapsNbVXLjTnlnHLTOdvSRQaoOBmPo",
		@"uTsirzmRrWZduFQpHDdKVRkMXpodILwRZmCSFxQnwzIHlUEFPlrvqJqqteruWvAUsuxMswpYxIQSzbUzJgzkniLfPyGBbpqPxruRdfjVePsZsPgKGwxwkjmbYPGOOqlUCrUvclAJrZen",
		@"IekUYJAVaUdcreCnTROqLAgImwlslxPjzpWwoLqrbCYHtBqEgVSvorohTeVHFpHpuJqwlcmnwoyJsjJYBELKhbVdqVZxcQYIKQrwNBiL",
		@"xpBMUWaUUUMCgNsJRckYrGLupJsHPOVQhBADobXYElDtiHOexSMZlBywUQbNyaolAFutNIQGlnbsdAlNLXDaykeORCPKMYdZEMFtqgUlZsPlcraEnRcPkSygKCuMFEWhsgEPtqAI",
	];
	return DfZGxvInNKfcAIqDjR;
}

- (nonnull NSDictionary *)jvdgPRVlVgJihCo :(nonnull NSArray *)ADhaiiTIpUaTbfnzCb :(nonnull UIImage *)rVyQzhEnstG {
	NSDictionary *xBhFxwUFGPlWe = @{
		@"XjRyIarabAK": @"GFExmuTuwLQmaZoWUaQzBeILNibjJsgDGbeHYeTePkAnLIsyJBNkfJYcEmKUsjvBPSqdxYOnSBFsWGYRSIlhcwnJIlUAvXeFXuqFx",
		@"sbmMtgBCHVGGT": @"RFZqEmLAtgwiatjhmjgKZTxUgkGqlFhjnCpTFAohebKjduMLfYkAQfXjHhTlEhfonCgeASYCYWjJdshDcUyqejpHxOEHKHLKJkxmHlwlKfUOwAx",
		@"hFGvuUXNTLpPyQrim": @"kWXuehmLwoyTPrylnTcdtJCfVtAnbobBsKInRIqpzRYNAxRGofIBLpcBDagtXdeRxpcIcRvDmRlLOslbCicSAtAPaHTWzaUCWEMVJmWWYZlISggLgo",
		@"XiTYuewoIQBaX": @"JnGvSmBknBACfBERFPbynovjradaOwDwpcpIAHHARCGZZAWsFwbpLAsGKrMuMEsUDUtJiTAUntvZKNtAAGMRyUbwGZiEUKBcJfjCygnpxuOQaSKYXwUuJDuawbFtQTyVpNlbqMXQd",
		@"XqRXMyLUjQsFlom": @"fEvwyYJKqagjmPtEEKTgHBArzEQIoCRcMmzwOKKlYYYZesAJlQPbSibPpiRAwzkLjIDpdZcoMwQQDbFVZrtQmOoscJqvflaHSfLJSLc",
		@"VMdUjWzgfCGLNGeU": @"apETLxVQzOpttJZnoqpgcUPlQUlTcFsUVhWWsnBdrufdLBhZqHiwiIvGSZakyBYdyTsnnIfAQWZzmQOSzXgbuGVSDKEQTyOsbNpModRfWelChDHYCL",
		@"CJZaaKTimbtVjMvd": @"fWSEvpjhBriawNFNMnIyzOBnKoWVKUQRpYxHcSpHvjSXWCBOSSRdCkIauSEtRUhpWWDjlBSQXUBekqQLXKwfszImUaEXAozNGqsIdJdnYbgQtmerKvqbWHneOzrExtkTskClY",
		@"KClEYRgqwgsivXl": @"ToulckRnbpSeKoZkAHNSEjRGHDzMpcmXACpDkujkFlExlJRLxtEPiIHZHnKvmvVJdFvaCPQUqivzfKyJwzOQtXVCQwvVCkMEgLAZbYVKDExCiqsFXTeKNbNVUpUcsUOiaPlZaccQcBnDp",
		@"XAIDhGBHfKYFIw": @"fsHdSeParTMMtylsTtQXbYliDUGlbrILxvljCXimHhuIXirwvqxnmTQHjkVXIfSqdCTnQDHwbJryTIiOiCyFNzewlyrHrYNqcCzzXFdlZvJkRMIeYfLZcPGiswplszeH",
		@"BeeSNpsCMSPja": @"jmpifIjEqbzguOowlGiAATAjHIEIOKHKvQnPtAMLmZybhfzRpfYkkHOEMccTiRINOTvCCErVmuXafejawPDUeEkWQDVPucjsjlJfgOGJFTYYbVJNyDBIwsltEdFOccQtqYvGgXQDPqMK",
		@"buRDivBixDIboPr": @"jeRTqgsnHDdVUXZTbrwtXKraWWMGtvQNwTaSEnSGvPUszhScoBOiYJsYPZnNXkxfijrfEoyrGyHEpVIbmwKNMkffZJutQXKPCxaqIGtkxoxeehHsZrTtWvBYYsItDFpjCtQZi",
		@"yDlCsdUcJhmu": @"mLcunWOViDhzQiooyBbMhqPnpzHOMeowEfvjoXiKmtLKBuWIxqufYcvNakEWGfNDjgtLterebTGdorGqqrykQBiHXYeyrckjgcveVvNcSaQZXZfieixfC",
		@"JpDJrfxLYGdPyEBL": @"TReDmXpozwRswGOrFYYnixIggOhtMCvBOhIFhuOWaUfJMYHrXIAPVKTQIJPrYPlDGqdVvKHorfMvKRKqcCXIpaDZcisoHGrDjdCqJsXJaxnPRmqAiINfUIoVCr",
		@"mKAVDCedlo": @"whzSXWwVBJCfoyiMneZCtbXRICNhIimVGZUrEKGmZzsMNOCNXLvtFpTmsMGcxGlnPeKCEUNVVdqmPzyLZdYGgrJGiHHDYrYXCTQZtdUEBgjKecESqojntUMGupNkOEPRxjYEO",
	};
	return xBhFxwUFGPlWe;
}

+ (nonnull NSArray *)WamfuiaLmJhiXcX :(nonnull NSArray *)wKhqDHQMcmKuEx {
	NSArray *eobzRorFtgxdEozleCU = @[
		@"uNOtQPeHAMOOrHVRccrrKLvalikKzVHQXVCdKyKzNxZXRGyfBLoGmvUsTMnNlGRBVlwrKsPHVhqkvvDXtMFSOClpxuiFfFAIVDwlAUHjTLUISoFkmJJunfpwSmW",
		@"nzchHoIPVVQzjCmhsJYtwIsQNpLghuhpdRyAasxbPQAKFQpyJdQmNtJqURsJnqRVdGFyEBZHPqymxMeEhtFsidzOwqLeznIIQvRlTtAWiO",
		@"YpsQNPIKmUpCEsQLkPZeMXIjyWALibrbrvWXbhGioraSbvsFdKcrexutPkdxprzmvisgfmcLHqGadmvsBgyKBotcRuzpkLihjjcYEtXNEuCdK",
		@"ruPQFEUOWfyaufvKMCgaZpuzwcEUyCRTzVHiLqPuELApwXrJjRDFCGauDOSwbfbnCaxEeTLCgFFiiokmjwoNfdAYxcOTGSvehLbzwzbUMMiGnJxFpMpCRkjdMQlDojblJ",
		@"TYUjXeMwtyJEztLkcWqTgLyNUhahIoLOEvzfDVqrDxKeJssJFaNpifJPyIebOjDtBDhTdQoKsKkAIwTKUDcTsiNnswaIsVFEMVTyrpRfzaDFiQctHHWypDdimAXlhGKIO",
		@"stLrogUvnHlXUubFtRlEnSzpbXehytbwhuamzgQHqMlibUleEymvOCHblMZIaEQpONXlxdnluUJhIxAhITKlbAefVgUxmMOWRANsrwDezLrNgvmIVrFVZDTwAxDVkgxozGkPxSTxBb",
		@"poAXWqkUpWkOWEpMGFvLPmSmFLrJMgNUbCJfGRcbJpXdGNpUyhrnZXgkdctRAuRpBadpzcMNkanDVPynTOJiuzLMcumhJzFvNiXjNIsaAcIVCtEtePODwpWmofWQbOhTgw",
		@"WzIsXwolQxrnsiGINKSvOpIyUOOVgFrJVXLnIoRvbOhxvIQfCekgGlhoBCGEIQLCRoTfTwsPMhtLGoiipPxJCIAdyfnhRuYIlHnERLAMHWtSiArKxgCEYhzGtgrTPW",
		@"itOlIQsuVOmqDvrYcmIEdVXeAEZDnEmUHXCmrVVnoMCCRvRyyBkgqfLmkWDFEknQFyRpCDhZmgxbqFaTspdLQAVAIaeNXASVzCHnxJrXFQSUwGvEtjcslQtUmHMzQlmDhUExteTRHraq",
		@"JxHJHOTRmeYBvHhuuGdMEjEnmLdVmUKdhDxeRWrnODiYPYziteHuzmKMOEIOkRuwSOzOgvsDOKaSlryeTxDVSxXZeAFhWOABcAdXdwdbHpekSHAfCGXCSdqbeXaAaNnxdadr",
		@"AFhnKnlcfHRGqkCWglNfalQrSQnJpuKQjoTsaLHmpSwLwWBrWYzweYOoiImNMaanWMMlQtzQukmRxRzMrjbDGKbJeABOFfrwkXdGMgeJASkdsXgwVGKuUEZIQHdQAfxsre",
		@"WKWoPtFtPvPhjLmqUpdElpsjiPjbMuLrpMcavdueQojbouNurrkhzomaVEOVJJVGmLeHEUBdhuXyvojvfjZDfaWOJWGrQYaYmncfUxjZIkiZOhvwJjGlfifzJqtPHhojuepWoP",
		@"WWDldTJMbxDDdQMdKzkSJMGlZZccmcQvgosQeWiiogUxNUFAlidcvHeCcBSxwqiLzPyGyYDmeVJxXuhsNZKDRmSnkcqWnEbvbEaftyiMiNUCjzgScaFiv",
		@"dAuHHfABuBDHxhpuGBwQADNhYFBuUCgNbYlRLeiLjVMuljsycDswFDHoVfaDnxblQjSoDuYCDIJlVQxJQfTqVefSSeNNNfmEioyFWkSV",
		@"CKmEkWtSoAYQWpxWJraEAiMGuXWYeEIhfKcMdSkQHmqiGKBQsDENGYXWrRMTXYdOgjYlPgttmmwyhLmtCosgrKZxBXVFyEMbiYODxDgJRcuUcrxRthZekhGphTXRqkLaiamqDjXScNqZzPOLIOQ",
		@"DnvZEETjmoYvMYKXMJRJNMZGachFKokgSNfFngsGtFKkxeKTRTrHiGJgAfmxoOedwXjttvwXNAvfQDJOsvPtCRPmeHyyIwauWWutMGiuePxLYDNdzVSnWbsDyFEvQyODc",
		@"ZpenmeTkQvDzssdLHEDGVxisjWceUXSGjGwZAdwJpPBXIusHRLkXztRvnByGxTRwVGsoLLzyDMZMWfLONIjeRzZGCCtQpqVhXtzbPTAkADmJZlQbWcQoELPFPsgZ",
		@"CEtrUavaJeecZxKHSeJdpnXOsCAFbwfQAWeDxIDQzzMPuWrmobLxRDaeYlqKQSQKOlZjeRlGrCHtJDwQQRnLJcqtSzwXeFcPkXrCMqVCQKyFgghT",
	];
	return eobzRorFtgxdEozleCU;
}

- (nonnull NSArray *)hqFjRvvUfBNMaSETcoD :(nonnull NSString *)GATKyRJYdBO :(nonnull NSArray *)cowbzRBxbdPDTJxQup {
	NSArray *OGJJZAVEsqLmQEVcY = @[
		@"jhrlsLhOGRJDBDyElsUbBlKwkSYeFGDoLXuWPPuhptdGJfPDVYCzIUhfyclzGlJgEeHYYRzyMxiFcjGnlGUMKTVyGWdtSeErVyOdsdXwNFLSIBN",
		@"rTAJftjAhxLZCfcxVoyqJIMKVJsTqgFmnLPNClDzHQTlWdslPjpIggAPzkxwmnkAYRtPkpsdKAbANAFEzDIZciRXxceexxPzptdvPxWgjcodVaQOkFChFKUWwURAPuisdFl",
		@"WhsbIIMvIUwOHcFhXocEdcPklhJIesjrcwSLjRHdcVnjnRpLiAKDJloqHqcWmzPrgoKZAbnXDVzfhFkJUrcsSySBseEvrqhUQqXXreak",
		@"HrnWAgHQBUXtidlzFyuciPPhDDrSmjZgNdRCZSrkzuMhAgeDEqQPRatqKrjVIvzpWfRHkifnHTpTjGZHhLaGvebXMzIpFbzbMLQzcmSJesbKtAjjlHhZikgzJpuslOTtSOELgNpI",
		@"ASDiyqBYGNUHhdJiZhKgzeegsLRaYvURFQawgJmqdKZXbQtCyeohTKEDVkZvbwwrSzXcjrJYvpTfiVviqvPTgIBhbGMVPXysXBSRUuccqbvfhVhShxyCBqeiTJmzE",
		@"sCeAWVudKvoHzOVVrjYTHWpcuceeQWOJBkvSRxkUmziZawyLIVSpVNAoDcUALHIIAuoYFSMahSfErHBxicKmOzjXikptluxfBGpXeyRhQm",
		@"EjaPvlxyZkKwYDMsvqXBdEnHOwOSshOapbhzIcDOYGfRmFVufLMMRfDWTIlNaEOnUnplCFwgXBDNGGwhjVbZsYnmfCvoFEKrkUSTdTvfSSXMxKxvcOysLWPqwYZvJsuLOpZVeY",
		@"REhCOKvmuHVheNetqCBHmVPmiwyZxSVYPKeUwEZOTMQLbURcYvrKHIbhzrdiObaSzjvlFvoOoDRnSIUeOhiYlLLKVuOCbyOCwDlBWvslcnubVNosUkulVvZnlOsahowVHktJlPjSnOOr",
		@"GIEiwIlMRztRSEPRezlhbSsfWsVqEeeSMPOckshSEIDrVCQAOFRysUtxQIVVsTtRNIhtANMeZALFWykNFnnQmfmCwRpwhFzZUQzcizyzynQVBjXcrYkZCDfBnemnNWHeoZN",
		@"YQYfQsQQFhKRjnqgujABoEZZEAzIhxhAJEIIbTIDIGRENTNoMCbKbwIlbUulfxHSiWEdCnuKWvTwTOwBQwEAwPZmPnwPBmbwwrfrkytkuwKUyXxOVGOltQGJv",
		@"zfZdTOmPMeSeJvzlChhyruMZvDPaOCzukSzAEHIZAUOkohwaIhzVQmnSPyjDyCyccvDNuOSOOZcwFcutDlDgNYFNzQxulrElerpiDmT",
		@"ureLTJaROiRJnxOekhSzShEMWBKdhIUkZzhizPExteVbpHwjGtKOroYTOLYsbxPophyOHzLgdsFUvdMETCBvuvrAneaHjIaNuapHFcrFX",
		@"jCNrQokuNRPnxwycMGhjrVXlQVHSZOrgYhzjhyyzpKVcTWKtDkjLTJkZnXCRusTcXjuRpLYiQZQmgSiZXXsFNOHolhRxZguxfEHMxMTCeZRFrIVknqStQLmBWajLmHdewogwidaC",
		@"fTkqLTMHqfSbxcQnIIvxDrTihMFGrGyDdhqMvTYuwhdezfAwKktvyPfmzSRBsDAxZBHbBtVwHSWfvLfUYWDVeOsWHbzxDnhzYUNJeHngAmN",
	];
	return OGJJZAVEsqLmQEVcY;
}

- (nonnull NSDictionary *)egGahzGuMyerEuvuNM :(nonnull NSDictionary *)MeyfJGikwOM :(nonnull NSData *)MRyIJsTWMktvDvuX {
	NSDictionary *yuyBEiOsZtfw = @{
		@"JCtaeHffXkgIckGji": @"yyBXXhbzVVVJKLwSWwCsvIcCKvZRLYreasuWLyAvTGrYyfxgUaQSJvlmEJjmaeFImrHFEbOKPLcCdrtMOQkPSZHmqUrQjlwTNPTjkEZYQoeIiQhKKzhLyMjNmlYSPxRGHTrLpO",
		@"ptEMHSVetRdIz": @"qbXgiwnMWqByYwnmhAhblVVcTyavNLtbCGKKaCMJNhWJRVdbuHPfEFkhxuPijZPpPfFkLPWbZsghvrqdcAzPiCcYTJKIlGYLbKSKuouUmpxRnzPbRFajMGPppxXHOqyruJC",
		@"rchVwCggunFyQG": @"OTGpkGCseYlbmoTsWfbXmEnQPcdDpLqVVWnziFgRSUJJjqIgEailRtxJISsrnLuRDQpBqpqhyPatYimnQqcCwFEpJbbGLGptidEyTiSrykBBlagmDSYTtXkTFKR",
		@"whijpcebGwZg": @"CXptSupWURnZemRkZnSjkyWyjAkOwziDnulBhFKIiQepbWQXxeuDOwNcpWfICrlJifGbFkKzUXXufQSijWyPZqONIpwPTkOJtCsnSCwkAenieeAzgGuGHKkJYkJEVhNEHbABDlghhhVbXcF",
		@"UAHSnIIjkHBzayEl": @"pZqkKSzlAaxRhQvZrgWctBshqTSWddLjNOqBcZliOgYqtTTymYdVMMKSIehxVFwCdEzWvDjUvAQgTWcRwSCGKWganexdCFoiMdMaQUvfpWXKRnBaUO",
		@"YZZGuNHZNFvg": @"uIfnrVriScbaIeObulDBxKffXBoQwinHmwrAFFAPellegZYZlLCtHMWfXMOofFrqaojESoRMFSlnMciRtlybQCRwukiiBnNaAKgfOybDyZxnsIsT",
		@"RbhVbZrBtjZS": @"RwJPkZGJtjvfVVuvScwMdJOfGuilaXClfbuoirOskBReVXCeGYcmxwMAvRPFDGdZgnCWvQYfhgrNhbSSsbKntSItYFCDIXEcIpYFpojnKQxXebNuskIKZ",
		@"xCiCposIOZgj": @"vbptfDbDIHlLtCwzTyXxGCUAnfkheIQLaFMNgWEPzZZoIaDxWneHTWlXuldwuKWDsVnAymrKeJXFSOrTKTGJSHSDurOmnBJXqEhCWTcRcvDcSSEycKabpTYghDwtJFMSsBg",
		@"uPAWDSZsCZjN": @"fryIPXjlaCJVtpFflAFxvHBbZlnzpsrOoiEVfCrHibnIUIEJNQJraKThxkwzWcHoBYduOvmrQPusIOMeIqXqMDoqlXHtowBsQWUTGngzFllWvhhS",
		@"MjQwOPXwJubMr": @"zNLXyFOKAkiybStbZWEnYGxgzgMcdwtdOJhVVQReDwEtwwZfvIQZdeBoZTRJDiWzWPlRPfSaaTgymnApMVYWkemUgYcfqFraWFPIcmBsmmTBeVfwOqIn",
		@"kCdooLBLfXScvHU": @"UWLlYDaafALDxhsAAdwIurUghDgQTbbKPfbnqSVUYmYTIijklvMFqgrNmeYyfKnqEDngmZITsdcfrNhvNdmavtDketCtkOswewrEmLRqzrJVjjr",
		@"UnkLmgUiqP": @"gsjeEWNfCmZVpBIdebMMufaDJRjIUqvswHVQwufybJzVtGLUlaZllvwDVmJtaSioWUiCMhGpHHPcUPyWNHHnelfAbjWYQUjIRurbKbKkfHSVwOWcBZwWMiBUFR",
		@"pYqJVkUAvMslgPNdSET": @"UIBvkxJLKLcZjVdmcKZWGQOiDkbySKZxnfRYDeCmtDyYhOvrhTBvrvSkLzLPLpoNbLDaNjWUtjLfqQzaMybSYMYSHJpsfoPTwWFHKNJUVeHdXoeuJaaTjMNlLZaBBacwiODfjTsmf",
		@"AAzlxZAtbNFWhHA": @"DFPMlfUCmmJuijtCMFKlDejebIyUFgpDYIyFZXbgdsaVKYagbcmDHvqRervqovGzHvltYkVUnLcphiauBFHslTEMTISLECeTakbsUXWMOWvKIVnOKrpWtVlIsjOpFKQmQAAGCAusPFhoAsgv",
		@"qWNguwsmTQpjxtPpqUN": @"wkSjcWVWsgIAeEBjgaSKshLgVIzgYVekLhliVnMmvRmKEDHgUqUyUhuPMkYdgrbVnxWUBDrphlkXTwOrFCpChsCCTuMReZlBKlJkDCclhTxKKYCyPmcXuHlvHDGgJyHhUOgahbimVGGQXfrlmB",
		@"uNdIteQtOpugsgQ": @"yrpHnAwXhVCdqrQLKYgHqXyPyrnKqIkdblZkkrsghxyTsVfMslatncukuuxPuYgPHBUWnAChaYkkiuUjxWCgWAtfniKuQJQFamfARjVazjDZpSLuLOCTixfmQcOTNzMTpLB",
		@"OCaZFgTAeydoDHu": @"JGDQFJKdEjXJVDFxneAQOFNOlRsNviOhKewthnpFxsntcggspMySVnEmpXCAjnHCbGoehkggvoQYfRlawOEKHcejtYsqRdkHUhFfJobOcGHBKwODbStMwUsKnJOBfHcfjnKGARJ",
		@"eJhdybGdMr": @"eaUEltRoEleqJyfRraFvHwPBpYqWfrOcBVcXRKhwqvaCqNZZEvygerlkuQtevwOpCvNfTaMUSRVPwpuRXMJSbrPjxifWIfOFFYyEocRmBgsBGAVuvyoRQAbzquXx",
	};
	return yuyBEiOsZtfw;
}

+ (nonnull NSDictionary *)TjxAsXxEtD :(nonnull NSData *)plYNyojYtoZ {
	NSDictionary *sLemwISQoiiygqWNoL = @{
		@"YjxOFrzfxKdBLTP": @"XOIfuIcZohmQWWPLIZbYondRLfcOQPgQdAPSSMzcSZyzEbeOSXjZVKAqrFNJOqQIwJdNEgzNoPNvATQGOqJSAqnvtUpFDXVQjJKLqRmXYApdSqxOqFRTcNlGgcWHWcZyjynUKz",
		@"tLOSTeZYdmnwOVnMPj": @"IJiBxHAiAWwPXNMuHqjEyDITcjfwyNYVWPSWkCoPcbqBMlgBdXVVUbinZvINsJMnCExoKmLAzwwVLrrEVBSMwCJooghZwbGDJRdqszUKSilLoGqiFDDjfMppknVT",
		@"sTsUhHJqSmiQkxPrur": @"pkdfZAayplEEHHWWdkQkbgVkDmMZZeUzLpnvhlXaFLdSguQPbqlxvzJFYYsfTbFpBLvZolivdLvctrGAbKuAQAvlfXfSgrAihzUmuOcqRMQLNHWmxrGTwLUkCYmfFyBOjtqExRGbRWPSJfEfb",
		@"EqcnLmgeIaKYB": @"nlbcYnunwltYGxkCdYadYZuPEcVdpGOFFfSJbqjHHuZlCSFzKnYMGSkTyOuxyFHntDbuuSLdrrsoKrXUgRxzOoTvJcePWpFmoUFqtvGkDphiioRqzFAyiok",
		@"OQuBztJvJQI": @"CVQFeDEVQyIZDQAnvadHgbVHKlzpwRXISPuAmMhVrmDBulwXpaBAtUmExwCtZLBSgIKmZqMLMkwfUpIKndnLIVGUelMDGWKsIAsDgqvvebxJGNfPNnwaJCesSgHM",
		@"meWfEwWyKKysf": @"aOMZoJHjbmYtqIlmCHoTakzZEehrlHoKesGovLzbnOiJVeEolEDSAqQaPskQYXHxoXampGTWjebGYLjQcxCLjWcMnWASMgoAEGqUlePPiXTVyOislgHplQ",
		@"MTnYnmUhCXTIIKwlt": @"RzhXbCAeehthUBjbfSuZZpOccMhuwKsIvaiqYzhKHhEhOPXAdyaHnlZHzfTpUcjoRDsazvrUnagJYQaPqjdhxRzepuYuVCXxEhNbpPAZzuLy",
		@"TRQomYPynT": @"dzCBHaSbxErxvBPadEeQTBHRmjSjMCSLpmJmoqwbwHGWwCpTPZWgnBGoqsWRQNaarqGFssmOipEmKsYHBurHeIqpQmLOwXeNeGVVmtWaVSzneVdPRyFNOXrsawwoPVnme",
		@"ADyugLucoLtEKQkk": @"FYoHWibwICSbIFpUzvilimhAlZYvpggXJDrwjuwMxfOKlBeZoxpDHUnWKvuuVNSUqkzNPrTNDQTbboBicHSXhITTqnJecUhonauusUeALjsSqq",
		@"bQdmeTquFlsnCIosBc": @"rXPkTfuzvCjjClpdpznDdIXRpXKqYZjVPEaTLaijWPbsxxqtPrSsJqFxuioSxlCmajqvAIBEYzQpoGiHkkKJOLWrWMfSQRNUMKCaBslXlZsOXwMgPVzGBpdrxzFZuJZqWnJD",
		@"wibOjWSYNLVhzDDhyhw": @"ajBnKKlHIiTosYurCkBISdAYtxMWshqcuuMPjoMZqwzpmPDBqmvZTtZgBNxTgriLxgjCkCyZyVqMpENtRcIIqrzHhgqwdBZwkCJJpXLkQtba",
		@"kHXVqEulQVTg": @"VfKFSZXhUGBjPmecVJePYxByALRjFOHXJTjWLrRWlgEythecdfeyYmKjmKUAesjhuvURZuvSjayyNrqVhlxuhQHCwXRgTnwXWqveeeMfbzNjTzLlJbAMEgDEDLhrKdVNifY",
		@"FizBwiJZLDXD": @"sdLPIoXBWxxsRcGzLeDufYdSjCjXFxuAfPigKYKXEwKkMGDNSaQIykLBkPrTpNDMyJERxdurrZEDdwaVBKtXHJaNdKByUYpXIzFaNvtagmnAWQLfksMxvNyMHOzEy",
		@"gYjhYvhery": @"yfAtQECtKSUNyHJUSWpNodfTCWceBIkXrzRQHgHhjPMgzmPgXvQatTbIZpLyUFelnddMPOzewkdcqmsBCFcxMazgpHHLtTVJwMEmGxGjaTwqDsqVYKjcVWqFJCKscrxmjQUDUzAqUDFKWaqSfEzZT",
		@"DbNIfjMQJPQHsTF": @"HqCiIEKrFYCrEzLBdZEfBfkcSHjPEIbsnJvIUtXpkFXFKYHcfcZniflHvypRxsImxpRBeuBbqxLlZzPqXygDpBQDBcctTtclwXCFLanlsMqQBgGhtkUVdOVYap",
		@"FNlRANgbuLhKr": @"CxFoDdjwkAkOCUaAFvEWafQfuSlSdkByiXkYpuCzGbJLyZzlGeLFSkmksgSeFvSqaGwdLZhzcvRPGYoXxZrNQwbkwDESnEiALGLnIclWwNTwZvXDsJ",
		@"fRdeBTibtpBuf": @"KMhteKBPdSomAfUCBwtLSdxgYQfhoOYutyIoiWlyhlaCehlVHhadqGmLSpdEtuebAvrIadyBaFOewGYnejYagzUsdMxuwGWEAtiptQanASAcKLc",
	};
	return sLemwISQoiiygqWNoL;
}

+ (nonnull NSArray *)XxQWunvMbJZkJTx :(nonnull NSData *)WFsiFXtvyAzvo :(nonnull NSArray *)UKHPmGUFbwfjUOtklWJ {
	NSArray *TEzIYWijfgWpBNd = @[
		@"WlxRhcdMlkXwdlXzBNGNIFUCIfQCMMQIQxetdqSlCHiyQkZSjhjFXODPwQWXCELdzmFnvdQHIRrRtmTWloQZZEzRcvVnSeDrHalCzfNKxf",
		@"NmjnKqOqSAIPJXSYRDipHJWSzMeeulDuZpWkDIiWaOPdTOYZnLdMqqOAuHCbaAavrjNadqECSocqnDPZGTRQqhhpcNTUKgJzuwLtOmfjSceMnMKvHCeJFhOgcwhLYxRBhBtSRRSUQvswXaVp",
		@"jqAmeLitexTCkVYLCJrhXXuzQJrDCjUrhxZOLYaYxoYGHMpVEKVttNOSjVNtbHjmotEBLGDYiAwWpDfvfmRWeLNfLVDJKPRyiSOOTaeXQnDgNzBxLNiSQMWzgGVVAYsIsITktAcMfFlkIR",
		@"WIRUjoNfibhlFxMmIdrzghdQsVDFYnMflmbDLzAgSqcOyDfbuMXtAPeGgcTEWRzJjQwGdTaDSIGtpUVWkShKhKsVZIwPZlDzkYQwdATadsw",
		@"ZhYkMJkTnvrfHnOgZqtkDwenFaLbkfbXGgspivtQcCKGyLQnemQOheBmbGxvLTvTmcQaCgsSlgqjoBPRqXUVSATmBjyAgSGaZtAQSzhGylLPopegSRFIXDWJcQzprMBAMSlKyIRitwatBK",
		@"zDyERoIZyhVJBOHaPCiCVnMPpeKnyxKCBeAMIfHVoGrhsUrsDZkwWRCHeqdaRXwaIhxmOfEnNrWZjSienYZviFIRKeXUjJhtQkviAnHdGUyEvJmfmmGrxZmugTktRnMJJhMbxYv",
		@"OGXGMnmJqmWdrvQANuPwHdtmuoSNFMaPZhOIUVTgClTsUlXJpaHRGZzZLhXbPOHIfsWmOUACmeMMTjGSwhLoZLlmluzfClUwoGTOlRWtmVkOgpCzFhHiQb",
		@"EoHRTaekWJLBvyFVTxsZBRltUZsQNmSGhNbSmIXwqWtfjeXhaOWflPCQXKVqlsSzyKAwxBoVrbLzgcKbykUmbZXgIeqewABXnPtzXfGTiy",
		@"xtVquwknLmiLZvEpMhXsecUSNgelUevnhZDuAMOxVIdrTQPWNnAexurvPVhGSxgTPnROZHGBcPdutLtqIyLroJoWWFsmpxsgZNyruaqcmUPsZu",
		@"kJdOjWJbCNPHnnuXrVPRtYBxsbVjUuFypldTxmWlwTvVtQyksPpyRZQRkqBoEZpPCGZPSTqeWUtElcBGafcxgIAxNaeHEyccvKAQl",
		@"TiMHldFeSJFlWsijFUQSstVAAVnMdWdPUShWOcWwplEnuTbdUgDXEURadYPkHdPFbspuTqtasUgQXUzQsMOkZiGnNolwUahkiIHIfexCHYSSrqHItuyuKbEvLEIch",
	];
	return TEzIYWijfgWpBNd;
}

- (nonnull NSString *)baYFIvQEulpTKJZDVs :(nonnull NSDictionary *)KUNOEHABclUTxJe {
	NSString *ninwBfxDRONYdDhDh = @"GWQDNQYlDmRxgRwpuhvrWUHHgQIfcHgAHvSoVKarUFMtQdKYbVVhXSbDLfhWMTvNxGyFKbLvAIsYDqXAhhkYJoDcKaWxOVkuRMsqNCeMvgVfiMysm";
	return ninwBfxDRONYdDhDh;
}

+ (nonnull NSDictionary *)IbEFKHSuQdOUva :(nonnull NSDictionary *)UGyUcNyeeR :(nonnull NSString *)gidHlcojUNi :(nonnull UIImage *)emFkRWdcIHLkFl {
	NSDictionary *VuWfznakcsscLtn = @{
		@"sXfrVlbyDUbVwVYMP": @"UQKRoIwEzLLXpkKEqdapdKCxOayiLUBKLftDJOSIOjNeORBGDkNuMNplPHwDVYRIKMcSgCsAbhOJIjWyjwlNFJSDxhCayAGJYLBuetRWxZiUMocgkfnLvuOAx",
		@"ODsNlhUMIPIRKVDXo": @"pAhCiFVcoAddceCdzPPaZRSdabpoohWYBLInmhPRjVawKSDedouEZrkurBxufVWgiZHCtLujCTBKdCyfJtyDXcPLgCkdXhadLzWFrEB",
		@"NwiqGdHAtCb": @"jDJUdZsmSKrscmezGcmNtPmKttMHsiGkWQtIFKGBVARdeaIzrKErxBpurfNhFxiMtVUAeSuJVTjDejywkzjehwsBRQbZlCOdXeitHpbYJWipXjNXkHeEjPazCzWftBzsxgwjpIXnE",
		@"HfspsrxOIkURcCIek": @"huxTzCENSnxrnDxDhTqEfMXuuWwWMUCpjIjUaKnZIVcPUCxoDAgCckUpyVsQTyEjmQiFjyEhoLGzwQbVpWpWyATzuAjZKPmUmGbXGienOEkUrrxCWsPWwOxMrilQzrGXJytMbrQyKkxZlunh",
		@"LtcBcfbSYcnxHEYTYT": @"cuMEZiryDoEEvtrMTneUzHXAOOltzMLltfVWVRGXPQGVkTuxMyeieUpQXOVeIakfkVXSGUkgdCbfsmqSfslBUmqzpsxCbdVBcNQdpaBTEGBHjwaayJbsFkGTIvXZkFtvLaDZagKTXHRHooBs",
		@"NdiIfVWMPVhlqDdqqnt": @"wgRgXblXYXPylxmAsMFltDvEXIfMxWIRXYAcspyTFdOnbHvHCxnMjOciBgrPjQmpAwmymhOdOKdqmYzQMsAzYUXXQnxoxeZffHgdUcsYmkArcnhXy",
		@"UsvLyKnYXkKGxTnjwyK": @"RbzxqiECOZzWUzmayorzUWQIHTkjIgVazetBnfhIhCRGtPQjpXoOjwFRbTMIECazbFJwlKKRvGIZoyhPuChHqCuAYiosiUsPbwgexAPlTLOMXGqjrDFGNlpEbEHRzpWwtB",
		@"JXvMBLexmk": @"pCcurXNKLUUsKHeHhPiUbwcUEcGlmkMJgipnOwHJsortqBblbaRXXjSBJZFQYnQqOlLDNeMRCMnVflQWYAkOCQwdrMyYAoJJUFVTKetnJWAMzECFGP",
		@"BwIjNyaRiMsMb": @"EwxegIDcDJqVfUlQFdCvcscaGNLqbNOEcsVtMEmqOAAEKgXKNkAyNQVTEEJoBSJbTJesFGUbBQChrDfCSzZvmmcqKabukStCPiplCzKqawRUQvwPrRpqzOEonrNHnMqTDVawa",
		@"DXsbSMGLpolBWi": @"YCtQyLLNJvIZaPdjcQbeIVSKGvSuSzxgXnYnFLwwEKEVYTAKLXeSrSurKzvJDIScPfKnvfAvpueHaOWYHLdDgfZUHPKMvnOURsXzCYbUKMTjJGIMvWTRjNdfBQzCBGSVIVascYVJksG",
		@"HJnPfnccboP": @"rtBclqPLhoQizHLpKDlWyMPgxjRkGxFOdpKBuUuUEMkWUfTmZrEoYvfQqPaBpBVaFuYnSHzwczwVVdqGmYIPztrUFBrCgMOpNCybuOQKrEftKsClFBmQIUGkM",
		@"JlNgyykSWmzcRTdyRc": @"znLSRLRXEYQthZLXFxQkrZnCwCMyZOxwyXEPILYQAvFAyzNtiKFvdjFrMkWmmOdqUZHiqEAWJDDWBbePbUGgfztOhLakcgGjKKNjwkKuNhynKGcwbFBrbWtcPAL",
		@"HXjNjolzzUyKvWPoH": @"CHbOfyHBSLQunPmhrxawOLsxNcaXbtdqOWcIBwitsYPHrSlCTenyqBidzQbdoeQlFTZxFZEmoMIBzyHgirewJISWXTERpJrEltgeaFXfs",
		@"IJnpEcKFxGNKhlHS": @"VppryBMJvxVrTskZvtRESjTNidgISjjXHQEbwVqPLFRDAhawHQNKhQYAwrawdnAXHdvJghbmdhtAZxKffpWFNMhiOIVycXDzAHzQDLFkHvvdFWBCmZuaTXJhxHHoUvGrmrPxCEhEmn",
		@"bRIUnpFtQRifF": @"DuUVbjwEopODvlMWpfTSSxSTfZhRpUVvqQUbXXSDZXzWSFbEowjMfGSBISscBsxlABYyDZQOtXEzbQvEayEeGOWmfVCfpkEjHPRzoOSGFfhjSEEhiORoRXsYklYEoVYNzqAsXeYPkjbiQM",
	};
	return VuWfznakcsscLtn;
}

+ (nonnull NSArray *)NWVKQeHzvW :(nonnull NSString *)HhMrtJkocJGB :(nonnull NSString *)UyphZKTrhXg {
	NSArray *tpewrCuasCnAMt = @[
		@"MSiAtGkPDUMJQlvXVoowevfBJoDDRAJiQwcZdXhCZxEqLDgmkmzFkTZswctElODzrhdFOyzskzKnNAYOTjDULapXsuNbMbmZfdUHfegplzeDHJiyyS",
		@"HUIFifjJByOIjlKiKbUvfyALlvAhRpyIJBHRsNzmFSykyjxwphghQPeqkIBOtiClafRbSVSbZkGyjiElokuLCMtIGfINiVXNABvCStGPtfFDdnvWDUxZroXdOJIXIJLnSKEBFWBREULxcyGmZYo",
		@"sCmARusLpbjbNxqIkOMzxymgBfmZQHgjLUUpETFUlnHKewFXLKqbqauXRTujLXqgoJikGzOCrsRPDIgdckyarMjFeZGRzvxjBxKnAVrorxZTI",
		@"HNtJkGaBFVemZSZtAycUuWqXmIGLNAswiHVDkILtVqzvSuwOKnVhKSFDbGADbujOJjytsSpyeljRsgeroSdOxcCXSzcMnsOBuJDrhhETKinOKGzoQyrIpkondq",
		@"ldkRpEJkDqHHLkPrbSTFUqgizMlUWLHemtinXDvPiZryEwVwDMbyjcOMthNKsWawMOMKCpiEzwyJrNlSunpDmyPlepYFesrtmeIAMHHkGBaMoLhTrheOzJx",
		@"CVbbvVrqpnPAkytCBKnaCbPcZIsiBfyQTSTswXWPoxyMcaGmzihdecKflcRKEqlfzduksLLsWDfPBTjIeoRBtgBkfdyolvMHKYTFjrboDavozgXqlRCTNqMkmeZkOZehkRRwmxVLjezFtDcjKQAgA",
		@"JTSvQbFoSKNEUzUgkbjYIxfeiDZsGLQjJpyFEgshiDSnHFYZgbufeKaFqeXAocnLMESDdRhCcuMblKocWAizTKsKEGrGoQjGxlpRwrthhflRsBxvMCCQWIQKTCLKCLfDhNYwQurTBfsnHKJYs",
		@"qkgZUiIAMuShsUXIDYNIbtWOLhaDTAeIObRlotaKzFoczAThzEAnfMSFnqUAGDGjMPQjkiKfcfIHqAUPKlNmiryyTidLBldnbxlKLfVlrWYOEkQhjxmoXwZpuhQNlWsmuiNlNUvyAkCzOWePaSRr",
		@"bbTFKnrezLRgQdvyrBJOHOIDkkEgKBCsdlIEaMjDfXwLirNlVoyUjakPUDvUcHwzHOiOKrtdFxlrjnAGXwLFOPJbPPnofyeZHbyzRHeLAgWRJJAXMoMIxbylXxwkgjFSUolE",
		@"qDOPWXzrtwAfxkaChlnZDpVHBsxmTeAkcKyxRrFJiVHMgPfYxDZdnmErApecgQTBIQWwsLhZEuIyYwBSzttXniqmFbmyrjOWeBuDHxcdtCLLYeHJAjRsmsaYZBuuTvFLMAsbBfC",
	];
	return tpewrCuasCnAMt;
}

+ (nonnull NSString *)qvmziocWVuNC :(nonnull UIImage *)PhKcAzEtDC :(nonnull NSData *)kRqXBtUVdPjibOP {
	NSString *BxZxvcxLVqoOplekPU = @"RYlPUcSXJeFRriZJLVMtHAHiPZgszdtrijRiwTEfSmyFiTNVhbfzuXPjZNNKDekoIEHnMeMJDrHqddfphStIEhjOuaSmrDlHAdpyhVDQhmDEKynipBStBCBZDOCSFUokXgWKpQynemT";
	return BxZxvcxLVqoOplekPU;
}

+ (nonnull UIImage *)bAklalQBZQ :(nonnull NSArray *)IZjQmVSSmnmzpR {
	NSData *FeVLOhHiYARmtCLmnGd = [@"uHgmIdSAGyexvkDvWbGRbnsrchQuLIyXcQyQhpxNEXgmWTygTmdbdWSSpPJiDkftCqImtvuNNWEUZeKssVfwUtZyjMgbHDbwNhACdjQdFXEFBtvPjvTMH" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *lCynUQwDZP = [UIImage imageWithData:FeVLOhHiYARmtCLmnGd];
	lCynUQwDZP = [UIImage imageNamed:@"FJWivpEuxfIAokWPbNnMjLxRrmdnxpWGSVZjvkLAPgLTPKKiWIJhtXZpXobkVvuwPvXtvmBdCDwRvqUsyZxJZvkXQIWUKQrQFQIxwk"];
	return lCynUQwDZP;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    MyTestModel *model = self.datas[indexPath.row];
    
    if ([model.type intValue] == 2) {
        return;
    }
    
    NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@&testid=%@",NetHeader,CourseTest,[UserInfoTool getUserInfo].token,model.testinfoid];

    MainWebController *vc = [[MainWebController alloc] init];
    vc.url = uelStr;
    vc.webTitle = model.title;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
