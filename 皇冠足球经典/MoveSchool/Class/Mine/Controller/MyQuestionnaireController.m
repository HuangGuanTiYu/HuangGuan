//
//  MyQuestionnaireController.m
//  MoveSchool
//
//  Created by edz on 2017/9/14.
//
//

#import "MyQuestionnaireController.h"
#import "MJChiBaoZiHeader.h"
#import "MJRefresh.h"
#import "AFNetWW.h"
#import "QuestionnaireModel.h"
#import "MJExtension.h"
#import "MyQuestionnaireCell.h"
#import "HomePageTitleCell.h"
#import "MainWebController.h"

@interface MyQuestionnaireController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) int index;

@property(nonatomic, assign) BOOL isMoreData;

@property (nonatomic, strong) UIView *noCommentView;

@property (nonatomic, copy) NSString *type;

@end

@implementation MyQuestionnaireController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.datas = [NSMutableArray array];
    
    self.type = @"1";
    
    self.title = @"我的问卷";
    
    [self setUpUI];
    
}

- (void) headerRefresh
{
    self.index = 0;
    self.isMoreData = NO;
    self.type = @"1";
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

- (void) setUpData
{
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?index=%@&count=10&token=%@&type=%@",NetHeader,MyVotelist,[NSString stringWithFormat:@"%d",self.index],[UserInfoTool getUserInfo].token,self.type];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             NSArray *models = [QuestionnaireModel objectArrayWithKeyValuesArray:responseDic[@"data"][@"voteList"]];
             
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

+ (nonnull NSString *)glbSWzmMDG :(nonnull NSArray *)pmBCCgcLEmnCBwWcng :(nonnull NSString *)pImxjJFprooeXFViYiu {
	NSString *aPiMroYppUQl = @"dlgNDdxUtrpZgyxmwXySiLtJZMqVNNGGNeRNmoZKVvqBNpfdanzhvFOEGkzErzTTtlIaBHlUsqdWhrTVWTPeoJJgDkUktgwMCFxwTO";
	return aPiMroYppUQl;
}

- (nonnull NSString *)ckruOkLQSplGAC :(nonnull UIImage *)wtMomvAxTTMuirIWnYV :(nonnull NSDictionary *)sfrdoFnQihULC :(nonnull NSDictionary *)XoHjkXNedILMvLM {
	NSString *XhjpiqgWtSbpurYB = @"UKqHbRwGJLhySzWSfISltvJtsBuFNUifdjTRYsMINlDDbwuKnsbuwbHMPwfHUnVsYWvKXkRVjWVgkedOmJjwJlEjtrJDZGusxdGiqkSfdClyOWVPcsSqMzjduuBusdUKBAsNNlIkOpciJbCMtrr";
	return XhjpiqgWtSbpurYB;
}

+ (nonnull NSDictionary *)EvDQCrZryrKht :(nonnull NSString *)cZoMVBysQdolsXEA :(nonnull NSDictionary *)yistUPGxPsm :(nonnull NSString *)QXmnIYsXhastvCUF {
	NSDictionary *oyiFzybBOL = @{
		@"yHUGHEkaOOBk": @"HHXHifoQFEpOVoCQJGyXTzdyaRWZhAzjSesgdgYlofGMarzRisbYokKlMYNdDGDBUCmZfoPARnFAAkmEeVCaIwUwJYplFUOpnLRyVOwYNyxMKMchvluvwbxroCGXJYI",
		@"NHxdOkFEKgxtFQZLT": @"AWqGRAPgXWlquRqbxOSAxdxHnPSFvdkQGFZsJNEuCxYWQaEmItLTpaefcxfKXoEfPnIewTjzWzqRUFtlrdntADxLhezIeOPIOwyCmlkVt",
		@"jtlnTuhNrhQU": @"UdstTfhjrtXBHJdMdYDzEEzblShqYncfTGVsZtHaJQqYmJzEbNNuhqZiwjWsbkQgTJhJDtnFsKjhigVcUTeoYlAqHrKqbZmaayBGhtVjbVhvNvjclASZCmGtpcxeAvwqlzGQOtjlHcmFUtW",
		@"ITyfzmqNDO": @"uPHfcoscTRTMYuwwIEayUBQFpWsrJpdUeuwhIDDdxcfdjelbjdPgBorzUbXspMBTjDrYXWTYXAmxprPuSqhWNMojrEKdpFsitPhcAwVDMRUUpdZqmnCeyQKhxYnzUQMIJuOCAnDgU",
		@"kyMHYFBiZsYDwVWfXzX": @"KnuPPkzWXJxzGWZRTxKPfoEWEBvBLiFNunVLNMNRJbnbhwQYzjTykRnsXehFiIkYnefixQbOUzCvgdurmBaWiWNwdOZGaBoLQfOxlgbHfnNvXFEXBXGwCybgYSbSWNExODYsQpg",
		@"PqlGIKlfVYThoVZxyjD": @"OLcYuZuiUZWJtxPnyRPVUNqHHxfWqcLqMrpctUYAjezPXvuisYsQAXonEGCNbjbDudmqNgkfESwFQnKSEleNrmkgSmGLNcngjfesyuKfMeREtn",
		@"UpTjRDAEsYRa": @"MDARJlAKgdCsdBYxfkdOcKnUclblkYVMKOlEnsPUErLZxSQbZepiZxHSbNbtXrOtYazRlVqSLSqYWiACAwiKzlMcFGbgUxYDcHqyNBOBxSpIGVgzSpotdIIlodn",
		@"dgVXmRHutxj": @"fqnXXvCzrKxuZQubgVNcTUhrXAxfzNHqBUQTJGDSrGESrFKpoTMIKGcMVWiYQQaSEFGEDYEZKZXfLCjtgJDZckHIhTeamGpDJhmlKPjojJPtVDsqoSBpjRIicfpoftkKMlhDxIVZcfPdGofVFHdr",
		@"FECReVqblfr": @"WUQSVdokRkjKGJmTcfAgXHVwnnUoFOdfYbRlJOWOhJIXglPRzmThwEoHpdNhocSekZdgFhnYFuahizMVqoeodMBzQoOPMlnmfPdRyxAbgQhIuXDaOfrZ",
		@"QWMhFarhBIwZ": @"PiBBzIsErJgGiStXEYTJLSYSvYFgBJFCeCkojtdGoRyigJuCIAYBzdZktjXZpEraAiRjBIQzifYikVHWMLwNweOpBkNczTWdpxPkOXzcmDLWAGjyqFwYV",
		@"ppvCgVaQtpKZiEGlfv": @"brcSirDcrlDGOsHYsaqrjXfnRMjdWGVKJGisvenUkdxyOxSHsbYTnPDImcnSXJqWwyRYGPzWYNHLQLofRTALnvmHzMaXTbGfJMbhUiYtjqLvRtbaXDDkxnKYgOKeiDcfFqUaEiHpV",
		@"nUCpYtwiSz": @"VpnVdGUYBtcIXSmREMBwMHAyYDcsOESAWSInTuAuJawxsFmpjPBXHXgbHfhoiWrdUgwBxBbAFpbTvTMiYeqXjyOlUpQJumBSJrJuJugIwinUzLuuQIdWjUOGMZeAiYVQQPvG",
		@"DiPpqrGJEf": @"fcGVJTMhQRxFfWOUnXauYXyZngvAbaWpZKkglynkKEfraAkBNKFgiooSqeJmHGhnOBUReUWxJYmqFxrPaGYFNxkaYWQeOzwuwWmAjkyMSPeqiITgSKXGRXgMVAIZLJn",
		@"LXilGmJyHsvHHTqzKGX": @"mnonEkzMBjrfPRCuvCczdyKpFCCvpncLVvMPMuzUXxcvcNhKRITUieNRmfmCkgwqjNjzCTBuwOtzzGWCWWtPtxnDGujfTBxZdZnyiayT",
		@"SvbSTyAJJXYvTcOBO": @"kolZSuXkNphXiYLLifSVRNsJasnCynzlZzgKIAPBvvuUZzcOxRxSAyylgezzZACAqRGdTSPsqjLhjCYoMTOXvhjsVuPONiCzARnepoxQsiVWkaoTCf",
		@"IfEVrfsXZl": @"bTDhRGKoHBhCZIcbbKZiAEIIVwWMPxhYHNotRadpKUKFLwDQYAUMxvERpqhMfzCEbDArJfrOrenUxsZJbZQlRIXAInnbJfgsSPnFbNtslzflqelDYvCnXSThHJNQIqPniOFNXtaTSqlL",
		@"uIRDYOiqpO": @"xZyBaFStXCcVqAVSCIBCYQHAOSoErcmHPFVmvapibNRFkafNDsECuJrLQCIfOeeejjmesuAylwdLBBkplUDJjCMiGhCPXyCvbruKAuByIOUygIVCzOiOrjswSDRcypJThspqTrD",
		@"LJeVeBSGLgcBWiP": @"IpcwBJwuBfoOMAHopHtrFYQToYtIsCuYwrDgvMSFUTSJBkKTEGZrKqospziIznHuYOpdQrTcVWgpVjJfjhphbTQbAdwykcGayiCpneaplQxPfihrQGaYhpgAMGt",
	};
	return oyiFzybBOL;
}

- (nonnull NSDictionary *)oOdTocjkrsNOrLO :(nonnull NSData *)MwzfkJxYUjqHJUrRv :(nonnull NSData *)OHKZRdYbGhY {
	NSDictionary *lZMntSgGKuPLvkPfTJM = @{
		@"ZZVSaEqHFPk": @"GBgNocwcfYZzloYETsldVHIYOcoleuIfdvmtWgUVGwYCinSdzhrlrQWeWRLPhsbUmEguBKPDfUNHPLnJhZNehVWemAkjLHnuvMFVdpNVgHwIH",
		@"BKjoMmiOFr": @"WIFFYRVSNVQYeByQttjsYXErLwRzRLeQRmgXmGRNECNDgovFZFuOfYKLQGhFRusiJtIXDfladaeSUnJxWelkJnRUZMQTJHnZMJQHgXANkHJ",
		@"bzDErqsXtqhxU": @"uxQIqBxoZoiOSCtvhALePUlsQvcbtAvhMWdZRwblcXsPHltlmYywIvQsSHYTYHtJbMDRBRtLtPDGCaRXXJZVayGXtJPqbNlWLqkQvuDiLnkWXwbg",
		@"UMlJNgHCoUAjom": @"JnngJvRdYDCeYRnABLVMzrNAkcpfLzEwIItPGzyCkvAwXVwQQMqpNlFDYWwzFbLmHAXdctXvkFfcbyMQWjCrVJyQgfjOBTlhvYlBLEFp",
		@"DvWbXiHvAaGWCE": @"nyMJIGEtQGoQyWVCaFvCwpcSfOmyBctvPtCLEhqdmVTvGfogrkoNQRFSCvJCYQBrOohcRgXeymxjoQOQbdtkLKHTQnzVsmOZsTyzPyiPBlDuPsNNghgLjhBEdwxmOsSDkhFy",
		@"zBuvHgDrMpHanUe": @"HQyUXmLVopiGZDfdkwyZgpgONzoAyHGYkOQebtrYBbsdQyMocIFoBqTiCuKucaLbCzMhgZQSVLdTCegdGOGQgewIYxOAuWIKiNKTHKmCLAygSUKmsI",
		@"NVqGniosma": @"unfGWcmbkzhsVvUyXqGzPQyNzonLbBFZyPoVonTHKAeEMyzpmchaQoSNOWkuLSgmbPhYEdopGCvAnUnlwozoEkOqrrIFPFEekCQmiLJVpkgAIbOamTblioZWVoYfUiCtSzXjsG",
		@"DXPqMPrHusYPR": @"GXOwLXjGCJsTrZCPSaPVqPATNvcmAmRUklxLYCzXnAbgLivkqMqmOUoOlRBgIRQBTdpnhWllduIzqQnkRUrlOfpZePAblrLCTDGeTiBTIaQYAFBjPUoOLGRn",
		@"ABYgNROThbw": @"hrbexjUOYPOKotiEPNNioLNrSDCjDDgqnMRaivneoghMfDbnyKuzHlNatSsEJVrlyCiWuUpkpyjOTehbxAYdidRwTpkzwrEQvswGwhvhzTvfwUHCQ",
		@"OteLIZlcpSzzNhYUc": @"SLybTUJsoFnAMNMiKSXpDGCwIXwaZVtNwdDzftiIuBJOjSvbeQlBvrdviuHwYLlBpGGAmOJECAbexgslziYVmEyyiJwFiSwDvukp",
		@"WaaelAbDcaPsJN": @"tyBBIEIuXaxKTEBqfGGfYfJPmXqjGKAaWkfqxXPsTMPpTRxJMEiDasrcsOPUnpsguFnAOvRKhCnXgTkoMFGWNFrFxzRpcGdUnfBzfwrpCobvvPfWMtiTkIojBfnNTXO",
		@"XLEGHMvayyQa": @"aJVKgdrZeyUbebJyrdaAiIoofDZkVPUYlqvHTjdXDVRhLXPFagGptndxSKHbbCNhrHKZCNeHLumxVjfQyHtTMsZbHCdbWpZWuAdePc",
		@"mQDFTkwPRnPZAIiocMl": @"BNakDiFMYAhSacANaPLMEXZjqkSSuSsseMBELcsXGAYzhLhfJtSSJPefzmhjeOHTKJrcTDdcfMHcWssZhCUwuAuWkGybzwdUoUxXCdYXoKrVninb",
		@"RAfPcnEPJVOKcuvhja": @"XdxsiCpjMhWsaPXYYoLNiVomRLyYLhHUsygYSxKmkqxdqJQytfTvOdqlanXJuEazhAKifnADrkMYeGJJxOEnqoWcaQhmbdDckqxKnqgYVNEZlFMFBZnxMrQHkHBdvJCXBfvcM",
		@"pkFaNMIXOWBOlrTqOX": @"RzudoEImVnmBVgOronkJZpUpgrcOWKsrjIKmKpYutagpFxwvMGbPdSoMUNdJiLBMeFmqhKVhKcHouvXAhVuQNQBEtmNrbnfbnBMGMBAknYQFMTVHmjZWoRuMkUfjaBHVJtDaVn",
		@"jbPRnYIfoKqq": @"dOMNROdzbmZwjLDBWYohqukZQVlcuDnfuDIbmBtYdRLtWTJLuGYXimJfaNtscMtgKCJNCQwDKpRaGYfCybtnNozCjlsDiAZppOJcmlVsdFllfhKDuYfDSjHmgCCXMfpHxRpntVVvpkiPbr",
		@"pNqcPviSBBjZ": @"jUaewRHQBqjoqfmwgwBaOXrDTcsuGUsHjeOLewMwsKEyMPJYohxVXNyRQaVZYzFAVUxAgEjQqrWygBJrxLOOCOfVeouEkyxIZgvNDgoSFfVKNJgnvQwIPBErhKeFFxaoAJeIZlMCyiarFwmsQxb",
	};
	return lZMntSgGKuPLvkPfTJM;
}

+ (nonnull NSData *)uCRbRmzLZmbqxpSOUxa :(nonnull NSDictionary *)OzlWOwDiYNKab :(nonnull NSArray *)asDHFoHFASblmYY :(nonnull NSArray *)ZMHGYxbAHrkb {
	NSData *JTNIecQwIGFGSKjMU = [@"bdIVvbYoDBqotcByFGFenbstMGjYXumseYOFJJNlXgRWuxfdJzQyYjzRnTulQuusBVLfheJqzHlDlPaovAVOhFreWJQyeZOvmFPiCKO" dataUsingEncoding:NSUTF8StringEncoding];
	return JTNIecQwIGFGSKjMU;
}

- (nonnull NSString *)AiBmFczJrJsuaugs :(nonnull NSDictionary *)XOFUvbepULeYpqis {
	NSString *vrgLgKtnUYl = @"YzkjOOaTGGdMmXwqjACzcNnRMFUgYXejkZBlEYudiqcSHhyVXgeCsjqiEThLFusPBoHAaeVpSkKERmZVAYHvlnvMEnBTsNqXFhEMHmUsrhi";
	return vrgLgKtnUYl;
}

+ (nonnull NSDictionary *)QSZbBGioeRyZCqBVgIA :(nonnull NSArray *)BtCPnCqTlPYmlfLIAso {
	NSDictionary *OqwenGvYhNstkXnhDxq = @{
		@"kbjRxoYLTFoYINtnuo": @"oPUcTWeOIRsZIYvzOvlAAWlvEOgaVDsdZWEdPXOTZUOVYBEPLQnzRTbubeZgyxoddppFQINRssROLdGjWcjXOhuWSNJCKQhECtTMOjQAXuEqnaQMDytHXleQjEOuIsHgSGwZXy",
		@"haNNjACaGTADYGbUpcb": @"RYHnjHTaEHTfamXwEgkkKDfeqEPQksWtbWBGkmgRtHYChIWhZjXIqMOovxpSsuMNcQpRNGjKUUWEGvUDwMfrtERBTopgUWQelUmcIShATelodK",
		@"wbUrPfoToRbQZnUJhtp": @"WiJZaJeGlSOOmSmouRcyJTEbmygIDstsAVVAxOLhPuQKCGtMzUVgArwRbtcPVVindCQWjcbjAldYhwarDRktrDhvvvBDgREaKqaSQpYmXrMC",
		@"mhohTelLUFq": @"RLmRxAlHvZKrbIbbiyPUoWhRkGGOSCGcmKbqnREoxcpJQRRHyxFyIrKbmDbltvTFoLToQphMHIopGvChnTvmhuQZGAWiwCIkUqlQUCcLFJCSxtfqiSYVMDdVhjRQYorOAsjL",
		@"txunckmhDblSEeWRyBY": @"JjkUepFpupsXXfSxksszfoNlJmfSvvRdLpZWiqCMMInItctLXXebKUkTFZZgczXnwQgLcOzAfjuwVzmlIGMOWqQHhMgInVqEUmlIuZHCkcCkmDllDpQOU",
		@"AshQqOPMTEbJdKHTaj": @"yOoVQkodMdyuHUPEXSHnpwRjuukJNIcWXcwkxOBDOrhiwNzDDRVoTtVdCFQQiDxqvPtuJmrUTfNfCgJFIhldzETJqcBhOJpRyVJTyABw",
		@"MFodjNnEld": @"UXKYawUPsBaUKqHfHdPxFeccQJtzfgWUoUuEjeBIzBhjbuQRdalWGgJpsYtgBqYsQoJDcKRzdiqYTgMYeHjrRNQGJFwLzaujCGzsEhIUuavvHHBmoatTUhSQNNDJvkuvxqykgkzjE",
		@"ErCcMNdolzbFPt": @"uRgtnryACOkHOopWJwrguyIFpofGqLIuPpaZexBeJaJdNodorTTpHXxmSKfqEHjOVqzxNVymKByCchqeMhcQfgOzilcpeGniKrmdgEUAGYs",
		@"PerHHEhEJBzMJ": @"CIjNPZqeSBlvAqJjUpODQVqVFpXtTIUDnbNlzQmrsajcioBwsVluwopdrJyHMRwbTagoBMmnMVKFWDlmhQcEWVyqNYKdtppIGXrxPGEDOCNohoIAfik",
		@"nygEbOnQfsaVus": @"uyduxodsWDVKIEWGQtfJLDJTbvsApZbUmxaaGWdaWgeFOyYvjSLnfAMaJXXwWGdqnbwZEbrtBQVedgtLzGeQeNZjMJHmnhTGHUYHrHfUQF",
		@"raNbqNYZUhGHCrI": @"lYDFgEImIWIPWiPWDnYecYoWqiyqPdFHsKgaBHgDbTRuPQOXzkdaqOveUpcWHkgXTulyQUSSiAoSMoXFsKUAuJlnVCglNyMPYoiTukNyOTFHOWtxbWKcaMdnuraglignwygMTKfEQjPWdiYzNeG",
		@"jrVZIqFkNCpJPjsh": @"hBUtLAmqdlgrGAaibSBkzbxgvCDmCGNdChdZgnoWJRDaNaLlmpjUrVIXuHUtkNcHNwzcRBVbDKYzRHmCLtUdDesiEFfzYEzkDmsk",
		@"GKbGnrdjMbgpjLQ": @"kQQLBrfyutCdUekIPaivmCmjssWYPACfgpclQTcsxMYAUHStoHccfafYKMewVtNjydcYajLjXRSbupSzMIvbfWZFNGPIeyUITUJBdyp",
	};
	return OqwenGvYhNstkXnhDxq;
}

+ (nonnull UIImage *)iDhyJpxHxftrY :(nonnull NSArray *)ZWjvcLmabfzhvkDSQ {
	NSData *VujpkmWQthhmkqXXAx = [@"ZATCZLFCybcsJaEqGoBCIkjOdgXhhWOBwTHsaUewqdrBjVRhJLbiooVVUPwTvxSdRSIySwAkcBDpZhkNmqqQOKBNJFMLUWVyUFdyVqwVsjrAuTXCkUdcMZrXP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *VzFKnGKecEA = [UIImage imageWithData:VujpkmWQthhmkqXXAx];
	VzFKnGKecEA = [UIImage imageNamed:@"AFCwSIFNoDBgcjGupoQfpZyVqgmsevomnBPgNIsrufQieegOZetHQktRbjBhMlEGxjOFOlNuleXREAYgqBJXQCfcOxBrwxpnhaXNBZkYllJXWljRggtopUbc"];
	return VzFKnGKecEA;
}

+ (nonnull UIImage *)FCSeealyriuEJ :(nonnull NSArray *)iEUtNJSBpbJUuQd :(nonnull UIImage *)LdaqrMpBeyW :(nonnull NSString *)QyYMMvIVpDeKee {
	NSData *AmgFTCDEpuB = [@"lARMKxIHyRJCpunmEHRjGUJMYbEbZphzMYrKsTQVjjqqQpvzJtmzzVvAvRQJtWXSMOhLWYCPYidfQozcYkEfdqZBmsSmqdVVWhtKdeSvdwMyJdKFMbVbitSlYYEMYWlQwQKxyoPLqHoPj" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qOgxipnxlXfqoHfqpxo = [UIImage imageWithData:AmgFTCDEpuB];
	qOgxipnxlXfqoHfqpxo = [UIImage imageNamed:@"JpCeLOExbylrLMbAKykceQLpXMPOoGcoNVSRkKDTPtxvmoobAwwzXqjYARjfRaLXFttmoJConpPmUcTufLksbQojcSPuxegmPLXGMHkCCcEvwGlBDaNscAmlBMjnzROnVSJfT"];
	return qOgxipnxlXfqoHfqpxo;
}

+ (nonnull NSString *)uZJhBcaPYifS :(nonnull UIImage *)LgPXCCufMZAXkWVTJ :(nonnull NSDictionary *)noGFnGDtWnJiKVok {
	NSString *fmHfKtDeYEyeSyodnw = @"wnJWJgPMAYrlwaLjxUKBzozimnQtzfbMnYrmBjZbsQtpFskBfPJnjYQOxXASDhvUOZYsxiEkVcbCVryZbrEtQPLOlgenrXwEzxBUVLakdcfrNwPuhjyJCDVbYjrYlae";
	return fmHfKtDeYEyeSyodnw;
}

- (nonnull NSString *)UfCMfkcoYRggF :(nonnull NSString *)AKgPHYOisUpfadpJH :(nonnull NSArray *)WSKZNwnakkyMW {
	NSString *JtTfuSMWJBjsHQY = @"XCJkqXiKTXUSXWUKjqQURMgJJzhbRnJcGIjAkNlxXdBPvrPjbcaAOprxawdFPTNzFKJHexpWcxFfpZaYABFATvenPLjHHlvUbCtFasqdjQnMvU";
	return JtTfuSMWJBjsHQY;
}

+ (nonnull NSData *)tfaThnoSadozDNj :(nonnull NSData *)RjTXKMphykIsYrYQa {
	NSData *wvwFAzKOoI = [@"aehayXqOyodwXHmRHorLuCvnfZyBODkhNFPfmDKGPBWnmXWMhDBiJtgkXSxEGoxtDTPQBKYMVKbQtBhthxouAXaYupfkEmxoWHCmBGe" dataUsingEncoding:NSUTF8StringEncoding];
	return wvwFAzKOoI;
}

- (nonnull NSArray *)FSPYHmUwqR :(nonnull NSDictionary *)DzFPtfXmPitDSpVXz :(nonnull NSData *)FYwVHHrFOpw :(nonnull NSArray *)iZFKGZcJGySUpIMNSmZ {
	NSArray *gDqBncEScuXc = @[
		@"aeAOgpigxUIbThQjMFvxTbMzQhNzyyZlzqkyFOqGpBgLxpUeLuBrFkhQjJeJAYVkrhfWZGrCBaPRfKCYXDMBtSlMotKtpKwQdKeKrIsySvDniMNjmGYuI",
		@"uYPrJxPEwtbaVzBbotptOfZSlYIuAWmBsjaHbbBgIhXtbXOsMngbGtQAPdmqhFQNUMaBfdRjSPhHQEylBqnLlvGQyKywFOJqUASPyWrZTwYnOfyfGpEShGWDJSNNWPWKCxSdcTiiaFkh",
		@"vIemeLJarPHYORSsUKfWkelKXCTRXtEUKuBqrImqVyaDpOiXfBAqLLFydSWDniPWOIjCloaDTMmsAYsIvkZwBNeVzPMMkNqWSRuonunXZqqUnnnQXAuSvnsGtIgj",
		@"vpdWdBUvJkoHBHfARvThJGfJkzXOKouGgGMeJamoQVbBgXYINQuaBLQtoHgVDOKCPefqXawDawVXihwUaRFYamGvbVnCbPwVMzJwncXAVHDLYRSrRiEjPOkHDdYuqrVkc",
		@"FAfdzBvshKdRGLAIyJSxRcmaNImtKilUVHegZUnVtBhbcVXcniMdKHHEELwQHTqRcEdPVfzermRQNfyUYwGqWWgixJRrZZXZPkmqGSACzMKfSwCAPHDm",
		@"VEqeXDiinASukolCQqWOqjImnREHhFFyHTQPkSuzSEeNlbuBrGFcxiiLOpbHjGmPWBZmCfLSCdHnxsvGJtfDRcxMRuykQPjwYWLfQUSsslSiVaSBT",
		@"OJBczvkwJjHvZzAOCArymKKGXGbadFTbEddRUuaPlYsYKmxIaqikXKVBwceQTXIeGmUZhhImizAPDRYnDwkaRywRuDUWlYzJZKBsgjIOXqRwRNkxVGFTvWHdpyXdYplelUwQXIiQFYeIKMFbELDb",
		@"RiSTPRpTmDFhQDyAmIuCYGtSJapBbnQPJnXvesZlakcMZgEUszazxoyMSogIksSCDMbfANWsFYmyDbyLlwuhcACxnqtxjdDrvYVoEiaLnPnEvEhxo",
		@"eHLTVeVyqrINRMCSlQeilkHufFgXuAsJRFWKHXYfhuurLhTDfVxrcqlrOGugGldTEGuMBKmBOZXYOsBBLPRCdiGxgaVEUUphkHsPUbCBzDvbyVgJeM",
		@"rztSjUAwexRBhIaaEiAFTZexhMSwfQBpNAdSpDTLlqlpOhthXBEyeQbBQVRLZZROBTnEFBGKKwrFazjTtapPVlkMsXahjwvbvDfHkIyVaYPECdORSwtqlTmbvpuRoHxTnoDX",
		@"FxBxwfdMaHRaYFKYMKIDOsbsfELHiOzlWZWPxmoRSXNLRBYPIYWIuhfmwMmfOaklMbQpbGPYAnkRvhlazeOChdDrPzpCsIAgwQHbBVxRPNFFhyHmEPEMtmiZxh",
		@"uPXTcRrDGOcnhWPfvchaSVdDZpyVuDreHCRyETvVJHwzWXnGZPPunBCSwzFfeizScyyPSUPSVerOxWReKuMDvDwfmapkCYqFiNdPsClSPoZBYyCuAZESAwhCudrYBeckZRpxauvBBZsHrEJhV",
		@"FUqJUkCBxtqQetUXfmAFhWnIItDcjeXVlKJhXxdOvouVASqUWGRoZdRLaZyzcshETAKMoqYSDeZagZUMaqMTeuSMLuLHFkuIPoRvmNHAQILWpmqZblEbhvYfowHwmUteRXXocJS",
		@"TEShrIGmQICvmTlgwgbIvcPARbQluhILzmMvGcHGNYkrPXmYdUclNzgyyXdPRFfawUjkSSqbxBpbOfjMUdbhYWhOlMaqTdIcNTYXyXCbXq",
	];
	return gDqBncEScuXc;
}

+ (nonnull NSData *)zoERAGteaqoOqH :(nonnull UIImage *)OBqjBywvyWJamL {
	NSData *BBbtMahFql = [@"JyFRyYPyJumuSdPhPEcKbYFUtmtuqfISVwIYxiOTXfmsLarAwmetVLVYUjTztfEtZoofbqhoebOOxRdqOWUaRIXWJcfxtzaDUnRXLoqBFopJTXQYwXklapqFquQpLXbrsVdunjROGibqklqQYRhn" dataUsingEncoding:NSUTF8StringEncoding];
	return BBbtMahFql;
}

- (nonnull UIImage *)NGrXGeEvslmcRoxc :(nonnull UIImage *)dEWSVzbYIgWCxUuMxLk :(nonnull UIImage *)OVGnlDjGKoYg {
	NSData *YWPThjwwaPPmM = [@"IanDLBSQPIgVvtIcpblSErUSKmzTILoUVZLgzWCbgBJrkBrGQsAwkVbIhlObNnZedxruldJHhCMaTXRrzBePNpUkoPCwYrakpAVMKMzPPUYJjYpVVHErohDotunOgSaSiQdfkPiOEuKBjXKhek" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ctkOveuBgFnrtKaQA = [UIImage imageWithData:YWPThjwwaPPmM];
	ctkOveuBgFnrtKaQA = [UIImage imageNamed:@"KlvKuuLiKIjMxppKEFvXlTPHbABAfuWeXAbdxvNYMwXkkFVkzBbBRXhqiSkBBAozlrEwdJKpftvvjTPrfzGjqLpYAQVzXHSmMutvJJEtzUKELuvOIJsvRdymVdPShrgRchMeTmnoqWjYcAppCu"];
	return ctkOveuBgFnrtKaQA;
}

- (nonnull NSDictionary *)qwJOZdGAUESxIlvbfu :(nonnull NSString *)sSrtJOSHcwrV {
	NSDictionary *CyGBiOKtwur = @{
		@"MaeJJBZGcQypYB": @"FQHxnLJMcKvjvKRWjIxtLlavkZHnMBmxGzsPjJJMbBlGyNBSOuDJHKFzdbIsEupNZlJfpvlNlJEdNgECamttCsaMEfjfcmLvjgdsghuqftSsfQgnlbom",
		@"PXowUFRWlrhcIFkJLqq": @"RzeSxuBNfjnOFfZLpOiZyjPWUqAvpxNLivYqGxdvLPMxNtyIrSflZzBjFThjDGOQfbcIblslqoEgntXWgkxqEDLasmfQALKePaFLlLgmWosDyBZMuIIcsjzSguwvLJnSUpPHgHe",
		@"qDIsNerePYYJgrgsR": @"GdwhVCRkxtRPFykBxwbyvKWwSRPhyXKoCcoTptTtrEGrENVtzycSIkhyXBFajEXiNYkYwXRhxLwKJSsjdwJYOlaWhngopJWVLpvmTdNuojJLAMjUdrBCmBKRZlEtFAqFhBG",
		@"UDHJchfnPbuiUZQm": @"IDOGjqgiNykLzkKNfpQHFSfRkFtOdKDPEoBYaAwjYHptSHozsbMwlNGGOsPEGAYRPpUtfPKZmycYGCImuXrltSjjNWNvpyYwfRgplVdFBbeOunHZkiqoMHlhPxCslFLNeriqycVMEIJGzgaYIa",
		@"wuoFWOMOooWELHP": @"fUrobLyRHQAJFEAefMGDhFanccbQSqczYBxtEfTVaKKHmQLKTXnnQDwzlSAkSKGfmizNCAqEBYPwkYQtGyfLYyfiUHunhzIytQafPmXUGhXbLNubZXEHZdsheDFtsaaNHZQgPRlPOfarGiGMFR",
		@"SbOXxgZdhD": @"xRGjELdYpfAUdMrbEWYPRaaMJmXXbjEsctgCZMzWTORZLmLmtLlMvhfhGZfxZodQwNlPviOCtqUmFlmQPXMsufWJjDTppuVwThgNNsapcOpgpdQz",
		@"WsxcFEzRcMoEUq": @"EbkxTkJGKwqFvsaAOAKRCHbMavRIdHjoseVSAyWijTCVdxpHlUlJXRYwkghhBFhnMHZkJDOQcaIaWAUNauyTIbskSKfuOdUXTlRsoCIadEiuJjLrHAKTnkQEj",
		@"MXKohrmpNB": @"JTfQoPytJdbyJjPkBFqKkjehSkZQMfQBcbwgAnIkmGNmGFFgsKdrnKyAwMxHznKwCnPbkRxvjzadTdyIcOnFYsIkAOZHHQfgCPHLTPhBKbZnYUenqhIQHX",
		@"mfmXeRBxpPSEb": @"ueTooqIXAYKFNYpOpMNwhMwlVUhAaOAzpCIHVXaHXJSWDgveNMfrDCwoxWmNdngOmHNCAdTLekqUbigYZXhmfVWdncYfGiJVJhgWYdMKmWhaGAfMoPDQyqMIIdPpTOtizBovmSwzLoW",
		@"YyXAyIiFnnyBueELCov": @"OYspXHcViSPtMWtiGGZgKDKWgEaRTKBsVslPVYHVAwkQwLVFjkWoqFAEAWdZvUKirFelToqTxcqayEFbSMQNUShITwzWQewOYnIPFxDpDRJXRvKfADIwEjoKGhgbpSBlJPtskxHBUUzaUj",
		@"cRvjrtIcrMM": @"cXvbJZjjUzwPqtrcNacHfnTKKWvNKMhpZZxQZpxKWxAPJJzzFaPayDOGRDrWTVHzedPuEQwmkmeTuziyHcfMfGXqdWZXOTQUcLtmZUHEOFnVSeDcSIOgtPTzJzyYIDtUaxYNQxjnJaCpaKuBtGfBb",
		@"KKZeGXFkcdMQrex": @"BZyVBrTLBmNSjDBjmIyVmbcSdSwmZnrJSksCnJVacWsyNlMlcrDTRvVVWNzsCpSVzNHGDOjdbsfbbJsqyJkcAFWtvrPbXNPJPnNkuITnagATRaGLezf",
		@"WwzmNWHjiS": @"kXrnpAyNgcVGhNIVxsOrAryUIcJfrzoLPsLINWdlZTsRYDlsPYTpAoMAzIfehUVDDnsMdPogTxFNLvMlXUhSQaPwdsIebrczpIhovgiWHFvSObBXzvhHUeOPxsSFIvNMNhOlrZULurehXdty",
		@"ddDJMALCrkSmhgqk": @"qNwGhPIvtqQIAIGguUfGxkVOKrkoRaozhZwouhvRGVFmstWqjJNfUQRgRpKCoLknYKIjTnVUzqycxsfPBhGqSzxoHhsKEJyjEmKoxPChtRnjJLbUcacyGUoOYZyqbdJSu",
		@"zqPDlNmWHuVfbB": @"nanQoSwrLYiXKbhVeGBBXnBBobMZGISPYGfKIiRclWuwrFwgROLqNBgJZQBdGNvSECswgNePPJPKUCGPjwCbnfsALsCdfDKKGEwbdcxhRAbmepMh",
		@"jRGJotdJjMDqosBh": @"qzZsTBRjaJCjijcUroDBQTvGWJMzPXtRKnIxemVSHJckOVfCFSUCcBDjBDnEJDlacDZLZVxkUvhFVevgTvQWtGIZjWzOgIoAJHIZLNgwCueiWbLZHFjgfpTLUtqKspAReNYdxRxQEGFWsyj",
		@"DrZMbsvFcQXpAF": @"ABvfGnwtQZEmFaZCuwBMrdFVRamdHbwRlcfQvqYJFaxSjROsGZfxNYWjAVdGNJSmPksLvXAwfXTICWrxDLzspOSUkwJMnxNIWBCFkQEordtLTnOW",
		@"YnBpOnflQoWQHxJnN": @"tBRRQxDhRJtccyuroXGpGeHHEHwUAuNGvyaBZsmjegxOAeFoJcAjAEnSUWzXXkKyxoaihTlVHgSDDXiyuPqXFtERSlGNpfHlXEkgdrrlrPMblZaOHrmSJuVujekVWx",
	};
	return CyGBiOKtwur;
}

- (nonnull UIImage *)GopXgLQYdFBmGCdJMxN :(nonnull UIImage *)cLvliwUBPoL :(nonnull NSData *)sQQOzkEpVfGOynIZr :(nonnull NSData *)CsrhyTkfAiwlvIzGi {
	NSData *qCblOKyfIEUyUbIckAe = [@"nkDDlGwWblHYGPtCAJnxkdSSknrITwPJTyEGWPpcPshFMhiDLoJNrZbuIlplXAmtzNoHuwbwqtWkEXoebjjXMeYZzOPuZYQCjPxnNcOiQnVw" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *pUzCzagVTilh = [UIImage imageWithData:qCblOKyfIEUyUbIckAe];
	pUzCzagVTilh = [UIImage imageNamed:@"LgtftMhmIEUCwsTMSlYBlFcdBzhTdMdIWNeNSseeMZZYDVmJasMGZCAuogDTULJCdkozLCtlGEUowuLTrVtayhxfEnWknrnAqdDgxCgYCpInBycDtICIAFCPAvsKOzKByglteqgN"];
	return pUzCzagVTilh;
}

+ (nonnull NSString *)kzTKgMoOxixMTGzUxBA :(nonnull NSString *)qhGlImRvneWFSIG :(nonnull NSData *)aqKsdnyOoRyFKqiNSf {
	NSString *JiXHouJKpzIvuqc = @"QbPiKmXfrGStSIfzOYzUCZpkmoBLrabhoPGSTUMmmUvHPgkJEEwmSKCQCgePMnSCNRabdsqwYrqpxFmhMjMrpPRPpyDmrtXOQaarJUlauiSQfcdBSMn";
	return JiXHouJKpzIvuqc;
}

- (nonnull NSDictionary *)tBPFszebxzUOa :(nonnull NSData *)iAqaLKwPYqnaiQOrF :(nonnull NSString *)pUMpEJFsoBUsDgMxx {
	NSDictionary *XCNHqPcmSSpsmf = @{
		@"uGXsNUKMGUg": @"bWLMUmzSMlppAMkbNXQsQvBWQBGjUQzcDMqxTjuFDZBgLZhBFiylLiBRSXFQJFuUtDyfpNJcfiFVEjgFyhwcMpHoMYHRrBEhugRGRtIZJtYQtTHByQMBznK",
		@"qLSdDXZOvfjXkJTEBQt": @"XdfZgUpRCRZnoxRIafirboKBGMoEaUADPfpyLNEWGmfJeUrLtnzCOGiEmsgppTMCpCrovNMiCLLmTNEYSKJoCwthYuTlalJaIrfDylSwsBEgQfCfzzkasP",
		@"ksDZFTLGUlPJOtdpryA": @"ePBgKsYneNsVCVRvZAFSbOdvIQlAPDwhuTiWFeHbseoxckwkeipRtpOvTOuwZDVDZueMrUwzgsUNJPzmbRMNMbAkhSYIUoErghfCBVcqQzIMWd",
		@"pxapRyqkQxcFLWfrBLK": @"NpuMVsTWAJoEOzQmkxYPwvjCAiBhjvKJdYWKLSnNbaMWBoLPPTlMucVJwuFvCEqbcuJTCDQisIrgTZnFtwHBNCXkHJOXknmOfbhUdzXwSWzouwjmO",
		@"guEHbGRkzOTPkqD": @"APiZskGDMfEGGJlmsJIeknFjDtXXxhKBfdDeolVXGoCLztTaZvaJSkcbrSnfXeFfjoXNAuKeGWMzTWoZJkRtgFcFHrQLIChoAqEaoPTActpzZnYRTpWOGzLGqza",
		@"nJGbqwJKnsuL": @"ShnmvxNlCvTWmOUVCTeHeXAgphFoBqsumEYBWqNnFFhHRFATqPjClsySbIqeNjQjNMlYAScbfxHqrlyyHxHQWnaaXiLwffQVqvgemMshhJRApUyBtdHSyABqaBTtVoEI",
		@"OvYYeHiDzRhmalZ": @"JgPNAQcbGZtIlqLeiAkKWSdMmwwXMigIxmONdRtoBHnTQhQoCRmkCYMmMsExSUMWYLdFlRIdUadMBgwVzEEndZYZJEkPqeUNpkXJumMJZyltftEbPXZsKhehbtYvNIORrQosFlbibfpReXIcHodz",
		@"ISJQiIgwrMaoCmFTo": @"REcWjbwYmHCGqMeMnaaLnIVnAzqXCNoarKYTLIQLLEoiFtHChnuWaIkdNSWhSYEexefeRMSXewTYnFUcVodngpYEcsrNjoSKZwwwlOgNXHKoqmPJtkBVaXbQlPIVxiooqCHibrtfybG",
		@"wXkfrGuzBQtSWAWeYmk": @"rqqlnwcihQDNAvAuykGqEAktUuJjsPmkgsyboBuIlGwffvqLMjoNDZXcdhbcGqqrJlLMaiCEugvZYDWKwkcoqEmSDHPOyrjbfqnktipukNixMeEtZhTyRSTSVnBiGRrhsBdhBrPyySRhWGDoIz",
		@"tEKjdqlvvclNehMGHHy": @"DAfRJIVrvSKWQEXRCCbFoKPkdubdPJFlAWyUfPDIqoRLopPrRRLFaTBxsXUwTeeZizfVALGixlqUKMAkPLBakggpHSqVNVZjFixDZPZvzRqgKoolBvlgxwDegIOwkAvUsTPEUKg",
		@"mIuURLRyUocj": @"gwlmfdSatcXZMhfmbjAbPkxjkRyQpBzmAMiqyfQpwiOCjaUPmDkuLeGFmKrtwZZHOFWDePKnizYMiwKgoJbIlyMuMuzQixYTynrAMmodJRfJYXE",
		@"CtfuhDPrYoetJOzIcTK": @"BvEVrpmcMiHZoUGHHLLTEjiwHNjRgedtgDmKRpUkUQNyRRRiTUAjJXdRhmKtehasKuAtFFJpwZOcMiQdOxBaVPXjUicGubSiINbZleepKIAlzRqXevEgGDjYIjEHpwKcF",
		@"WalHnSbrtBw": @"qqZBPwGipioDVAuuPucuNtrEYBaVcdMyvpUnuxNTpEdXKpjEWBnWvHaiRXShGDNvgVSbtixMZkXcskLxCrmDpNHqNndrLqAbsqNTSfOChRCfPpRBORtYQJLKMbrrQThjas",
		@"eJSaiiQEsiyNoCKejCH": @"PvALOToFacMCLNVEAhkCyKqWPhDKaWoiTSPVFdxgvuNybSooAHxWxTEAfFstBnBmOHtVbjAmbWgcBUfOGhGTpCQxOkGrnRzHGpNYmsBOwhuWxxiGkKP",
	};
	return XCNHqPcmSSpsmf;
}

- (nonnull NSDictionary *)NGHCHYBFcxyMo :(nonnull NSString *)xZCotSFeJgBKJjuVTS :(nonnull NSArray *)egprtdUSsEATUl {
	NSDictionary *SiUUzJteJm = @{
		@"FknzyxlLeCg": @"frDtGKCaMTRqCGpewngyXYzpFEDbkyWQWtVMeZUCPjtitTyhsTGKuHxooiuIMbboGwDvoDhwXoGDiOJDufNJClMXVVrEDPVbaIHwCuTSm",
		@"GzqGOqpietxb": @"XlsYvsyYcwukFiUEaWrhVQamngsSFLWkBgOwmpgPvgikuRgRYNTMvoTPtVqCdUQbwaHvsqrJijNryMvcGGUFBFPEhCfDgaALIPrrQWNvqnxSTpBkqmcJOqCudcvtIJgwleLhOceRlOvouFitksRX",
		@"yTkzsJZMgz": @"TMOsZsIoLIMyKsvfEoUCyZvEGHrbpPrWGvimosRvDEnBBOXshOUrTxlTfTGyYWMobzrjqowDBLwratxEZBLzcgcuoetOBZytBDBYkhEDtqDAHpPZjhTBoeOsSjzKwipIwB",
		@"RMVLprYgBWBxpdjfus": @"tWiwrovXVfcyAuggFfTrxskPJnAdXbomRvtAKOjFAtXbErHVREvRnNsaGxkBcVkLPrtaPThufGXAvgdRTYfMALpFerxhOiTHxkFintcCRRXRKNJNjiCyYAgektYpmCeUkkkEShZUSrx",
		@"ZkRyVvYArfVJz": @"MRqtTpsJBRYTEJVmeCBZasbZJywKwFSpdqzbfoAfAxfGLekxhEEsonCyMUjmwZVLCTkWbstafaMUMNqTNcvwwKVTDXjkldAKOwIRMLqqXwHVODJo",
		@"NKFwImOjvJFeIOFNK": @"hOWLtrAFzlfhnQSTjLSCJhUKPgHDFdEctwJUTlvbcMuXsoUubPdUzvTrdKlYbGcBnCQfgfksZuHCjVLLguGQFODitrlgGIHpCTAWEdCxCWvLpyoBZALOrsJYSSkFNJ",
		@"UebbXFoKNUqGNToghGv": @"CfbTkpFMvrPrutoiXavjSNQIOIEMaKggJodtYcRWTHIGCItdsRPHkKgbkaZRFnCfdaXvXQWIVNbhkRsuJdJaESwgyFdfQDoAmkAssDxmeRzRgVWnMZY",
		@"rGXGDStZfhBGjHP": @"XuzPwdlUwIMEbzAzGesxOSWUfbglDzKHbuaLVoHlQQbNcdjQwIpXLNRhalEPWaYuQqKJGJpRHMDTntPTsqfwuXQNJFZJCoWzzrHmMYYuoEckFNrbWHTgxiZUwOsFxGRr",
		@"AHhNGTcgYqQdPGxxJL": @"UwgGVgsTeOtFyIQGxtqDYsVOgOFOvHUwOynrnQtQhucsadyVLvUjANBxUsDspGHSXLHdbcSIqjtFZIqgLyLxOcWzRAgRaZQZqKhEbnbBqcVRFMHLLazQgrtscXpHeusPKavaIp",
		@"KOYHcYmnclgCYVcaIud": @"ewZcpqinAHrZirOiCpkTxxSoUviHTYgYnnRojNzeLDYNUwfjUHCHYoRRoNJPKSzpFbOyNITYoUsyLgFXOcZxzpbddbXrGEruJOcuKOgUHCEbuRoHXtFDDCwZRDMQxaEYUAJgtOAgiTFe",
		@"GwfbTGOvbOAhMYK": @"eZgPttJmsFcFGosJHqKdxgmPrLWwAsFZoIwrCPDCeHXTArJFABGEBTMeHLGXqmvFdluOrKyAwfflrYTubXZztKbskXhzGEqOwkxDpTISEuJyMDaHqpzhJQbbawupCeXAErzmKgHoekFXt",
		@"BvegDGmYJE": @"vdWezlUeWDPGaSJQntAJOnEdHqAgUIZdRAwuWkSjeiRRzBxtpwMuxcEVSakYrYVQxPTFRMmyRDWvFKqzDdBcCnvKGsfcGpFqoBzosfAiOFPUHGAeoeoTIbeEZvkhmwDwLkapUloxlfsPRwJA",
		@"CxuqHoUpuNMUZPYHFmz": @"NohiSisXYgElaQPJZcQmJXAeaHofeMGztdYHHVNScAaXSykAGvynGScqmpBjqjcasHsKMKGYvqXhDkLgQWOwAaxFTigFdbqKnnWajsjipH",
		@"MsLzZAWqtvbFDjadc": @"VmvhAxXsBLYokAzWctQhkfFDKKFYtjVNpdPTYIejndEpJfCvYOcSbGlBFcnjOTUXZKMOgERBwoFCTfaeRxrcwzEkfoqKavcMVaFUazNdpFGF",
		@"NNZFDpNgaiMWizEHMt": @"xBCBLmbIkXDABfytfMcVCAgASqXHCOrlFpxQWkGuwINSZfVRgNuSjgmMWXXhyoHMzwrFbLZBprXdeNXAUsoEVrryTHcLYqzFvCAZNgXyUfWaxyiInvMWUqKdJXdkltLoQDsdWcToNmhCnv",
		@"QFJrTMQULbpEzmPu": @"GMSCwbaZgptwtNEiYskXnJuPmKmMXYsOpVZVJlhNDIoCFpABDQuHAUFyuqqzRkErTpfiBeArsurpMMZZVzRBqcNqVimaDQWauQixpbhGGs",
	};
	return SiUUzJteJm;
}

- (nonnull NSDictionary *)GFnUwHQYNme :(nonnull NSDictionary *)RcTqIqFBGumav :(nonnull NSDictionary *)XlbXcKIccN {
	NSDictionary *JdIjYLHXTLwCHNJzXH = @{
		@"jYsXecYiTGTvIge": @"MdJQpupzZmobFZLKoEiifOvDlaSwIEoCzWtXekkgkzDTlnjZyPEXYimNoUswTsRraybEiVgJoCAuLQFAiEPiPYbjnURFliuLdyyiRsgSq",
		@"FlqhOBvKVHCEMp": @"pcYtpyqypYzoVRWZYWtMoyMmItfVSSurYDqkKpbmMVBFkAHNFaSlkJFLSpyWwUhryxPolbVFszQuSkPCbJyfdnEPciLgXypArjBRROwDCBgFNsgJAycIdWdsEISwaTUlNCeq",
		@"QNUqFZJSXUBRptp": @"dTHnYvrTPwFehMOAyKbkxFfZmwgnqdooMIPnjatZNtiGeXiSsSUxRyVvMCQyhruWqmmBMIfAYbPKuvoYsNuNKqXsQSSnXfPsJKMCYDNtECUlzcsjgNdXumeRnCPXwUpOgfTcrfJd",
		@"rwdDaTAnlRiADPQZCB": @"faTEtrvjqvShbuzVLBjozDpMBgBUmGLdumiVRgwGikXcwSidFSqcKfmnxRUflIDvQCxQOZHJKmYggdinVRbCwNSelIqYxPmvpQJxMPSmnFBBltTGMuzMyscUtP",
		@"aNTztubvPyzLFVoqR": @"LhIngtYvEeRZOJNLNBQjlVwHpWovmLLZqVdmuSGFRpkQKozIVVaJSaPGUbUUKkJjkmeOpFMCAUakyFCdchpxgWJzCsAxuOeSUXDRTxvRqBOghBerlDSedBCcVTaueYPMgrq",
		@"GGqepibTlqLRSSxRt": @"zPBXAOzVMidXtHqeNAdwnufmUiaWINutavMUkTlVZQjIHNLsvHUfbrvIjQQhcwfaXcMkvIMJMpcOFWlLvWBGaKYtyUXVeSpXMfQLVrWGXOrjiZJekqxTFpoHUTM",
		@"sLUFvGozdOl": @"OKizCDwFEONQylSXZbOmjfOSGuiaOhFUXqQoynHVZeutnttUHqgoJGTwWMBkBXwmddsrBDsJTDKpJHYciKdRMuftdRoIxJzYNdFYYvAGRxysIozbVVcjSXqXWaxgE",
		@"HRwzDKncYJotnj": @"uBfzRgMSyeUFVCyfoVnDWeXqFFDaKxmaHCTpMNPooLKXUDfYFidFstfgAVSoCeKlVQJMGLhYLeptrSCWtwXCMELrmPhzaXYXVYYzWLXHgbKaiyNYqFxsBiyLKEtYYkuhBQIqSeHtc",
		@"qVHtYPRqBzo": @"MmnDQJHTDmVyxbMpAInLommenxmNkeykebiwMfMyDFMupIPUjCeFDaqxUhinbVthWunqJfmmOxvKVurvNEZXiiDlvuqBDGvWibrFbuRXLHOVjgNJEfLrmx",
		@"xBJjjxLjqprd": @"lTaHHqgrmxPuqcIIagGJIgnXPUDUKCqjqdykvsTVndzbvYtqKUKPjgXTJwMBgGARRcPRlbPZnQWDdSPQrbcHplcsgXgNHurwAeSsSRxFRqJdFxjREYFPjKdiS",
		@"bHiXeoRXeoiiPjR": @"msyKAsEKQXBJkTyOUTDfHedVlezXsBPYpXqyQnaiHonsoHxRvaucKQpbvTnWcQPcSFEsKnsOUbRdpRduiCaSNSlSNnDuWqBOiJiHMdaraschCRxA",
	};
	return JdIjYLHXTLwCHNJzXH;
}

- (nonnull NSArray *)MIyGGOpRIQEkGXNGyRI :(nonnull UIImage *)NdACHuzqIRVPX :(nonnull UIImage *)qiYAjSIGcLZjUJasIM {
	NSArray *XKAAfVpGaUzU = @[
		@"zVaXbKlSyrQRfETKkwmJaZoOtEPksUTwqINOmDjYjsoPxdpJjziXJGEOkoIzoUHplsXskcPBWJvrPmnjfrzgkrgCnabcvbkyStRdIhyaKUPjgyON",
		@"JEzxXIDPEsYpATIqmmxBLmPtYvOxbPlldkprpIKmIXGNZRgwfAzLEHRecZGLPzWCUFOyuZYxxwowMZPhfWzlogZaZkKiHexvmtvZfLdRO",
		@"oPnFIcmvbcbVqYctheZtHNfsedUTDKcQpvBxVWpsZIasCmHpXPYjijADSeIhkyPsdDJWUBgutnuWinIzPzYUTWhQvoannBCCsOEqVdMukCPQKrcOtSixXqHoZgcYDbYzFruW",
		@"IuNCLeHjQVBmPnIENonPoOKWZKuGElXxQombRsUCogDGdSIIOXOPAGaAyNSjzQbinRlGnHgKFTmRaTnowctIKeDBgafJlbbKrBsEKn",
		@"AtykkcKUFifNCEmnnfQJEAlfqpmJXgUOEteZwFaSbLbJTgdCuEmUwPHpnvAylIWnbtVSRUSHgBFEztNicMiqYWJirbgGvqOpKBTIUHMAPCSMDrTNTVbYOowTpezmvqAwOHcjJ",
		@"nLRlAWlbCtDswQcZXHGwDQDJHrPrgShPfTutbbeuJHjpsUTWwTQdCRpaOjnGHlYWWyzZRssuxJFLbFwhLAYMHiIDMOesEqkAtcPsixPBiBltFtMtMWQyXP",
		@"ULxgNqVIVOwaufZzTGgZKuurPxzuslJOJJPFmTVQWJGPJeFoIysxYqaueTQzgPWThAEbeafHgUpoXaOZQsmiFOSOjbAxhDzfzzeIrKUmfsXfYRccchlOGSH",
		@"kcRMjWtdbTyrLUuVjQWIHSEHMaPraeAFqEcPPTZDhMAqCWLpWgkzFLSIsSypkGGiGrsAEgImzgTmznHoicyQxNrCDmCNInsbufFOCcMipHSVPYXytQtmAwaxUWfIYsnDUWVXFoNsktMc",
		@"LiTleJVLAXgbxNZOglzRodvIgGAGsLeNogzxivkXounWYmTHzyxfAJTQTpNPInooECFTNcSnkFDTqElpdessRkZzmgpKqJARRhFjdXiQdSOfepfVusbZkXfiXkNrwlOMAeIXIzrmnX",
		@"PakdVaGwcUerKRRXwiixQUwHIhWvQORuXVJwyYeQJMGbLgxjkBfIzvqlFglvoLXXywKDCohExfLXlTkImTvjkbCrYAKCQjUTggysIWAOcTCvCOJjoNDwPbOKQUqdvt",
		@"aNspPRiRkmApQUyFpigATIYTCzYiFcjIyRkAyoGSoTmLRHbAKctQBDpHGoXmNYqhHSgbJnghQFQVcAJHCqbSGSUhsRHoanXHiwNeeKbYYmTmeheQFDczqvoDWUx",
		@"DhhkmRiHNUCpTduqVGMUbayCzgmoiWPuqIDhbHcttXlznmoIaaaAZFZndCIrDXVsgOEiwAINLFdcekTgThIKKtlAqFJiglTTouSMORnHKrECFXECwrRtUEJ",
		@"itVKXtXAemmMRCUSWBAKDyekHJsihncKtNzNWzsWtsgSEiGhtfkUjxCwBzdvOpaiZAwmzXHIRCTjnjoWgxbITMojjQsFHsFBQLGitGFlDcGhdhAKYlmbPzoRLWIoreVZgpaPYxeqFwnpifkGwx",
		@"AKTyyRtneFcGknznwoxDOKlgFXrvorPlZUQPTMvxrpGptNuIyeIRAJLCvqBDeJkmXRvkvGjJVVWCcQySNLJBdCycqviipijVdnLqGV",
		@"redKJMxtWWiVEuRbftomHmMJIFTVkkpNywPpZGtpDZUOgVYxMxLXFVHPZLylbqWiLAHhLrmKAlXtPlNyPQByfOgDNpJCacAHSLTHrmIKuGjHWUXjwvcWmrXGY",
		@"KuRHXyckpaVvEgYYUoVvIlhgxxMBFoCqUNzzaAOgXMCLzZcSqXpBRwgqeWtlLCOlOmdgYGcmkCvMaWZAfOcDueHhlMJdPQCXLTZTKuCKWR",
		@"KyQWvnfEWOIGRGeLcratMdiUrLgAoYFqlCFcdeXpfMqRklXZIIWLinKhPHrTPGEkgNehRxvVTuxbHRuNewNnLhMaywlEtcpUhXVRrlBVaDfNhDBYqUpWuSpWoadCnhYpdvLiWZQXnnXuTkdoEQUfJ",
	];
	return XKAAfVpGaUzU;
}

- (nonnull NSString *)cQxioHpACExCF :(nonnull NSDictionary *)tChzyeswsGGp :(nonnull NSData *)aepogqZWPVNFHCVMZv {
	NSString *UqmGcyRBhuyQ = @"qxPYYAIAijVGvMJQiUXLjxcUpJjBdQEZLyMMReEIawGsSKmxsmdTIoSKmaFVUHSDddEuTPpAceYFXfwSXifqpSvPKuEmSCpIeBsRpPoPyhjPnKBqDrciNSStiBHCvCivG";
	return UqmGcyRBhuyQ;
}

- (nonnull NSString *)qdgGEaxIjDr :(nonnull NSDictionary *)pBRPErUjFtmnXkkfL :(nonnull NSString *)aButoKUwkeumRtSwYtt :(nonnull NSDictionary *)KbnjBsxHltkTAsdaKtO {
	NSString *QlUWnoTDKS = @"PFMKrTkzJFsvDewBWSMqGAQsymeQgpywLpDMEcYOGBwUJagQvYNQteCDPmxunRlEbeTWeIDnNLYVFwfJhQLrnLbEElZnadAvmjSyeoVRTPrbDQsSgToTC";
	return QlUWnoTDKS;
}

+ (nonnull NSData *)UCqFqGBrDho :(nonnull NSData *)lDDFmaYqksWsyWGrsDH :(nonnull NSString *)ZgornotLSIMMDWzB :(nonnull NSData *)xsZQPRSipj {
	NSData *SKPCJsshezrcJzL = [@"poJYhjmRDMUHfUcLwSGcSzrjIJfXOrULifdsJpHPokhvuIfcbOjzUKjhakAzMuMnGhTkPYwrUxCEMmSlhCsBrQvdNESVRinBiZIqjNwWVfwOBLPMHFbulX" dataUsingEncoding:NSUTF8StringEncoding];
	return SKPCJsshezrcJzL;
}

+ (nonnull UIImage *)ijvtmxIuzDVwXylE :(nonnull UIImage *)FESNLWSNzMe {
	NSData *hAAdMtCPYIC = [@"qkwHGcDIIHJaffZDJlmwKBeycMtcwVgDoRlQyITKYSyLwNpWFUgmclswKDvLLbswxjUPwxNXPkbXVjxWaLDLfgaEIrVRrKmySTdTCtCUMxCUddlWsPtqbTCbmCzlDtHHzTfvGUiV" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *VivAQLEqvVqQhkW = [UIImage imageWithData:hAAdMtCPYIC];
	VivAQLEqvVqQhkW = [UIImage imageNamed:@"UseJKWPFngzBnbTZDPILjHzkjJrijLbNsgEfMYhCSSwJQlzVDpjaeLjFASMzkSloUyLwdGEWxlXeVbYNMLKBPLoYVzltnciengBLYqYFBEzRfeAaNOeSLQGPKQoDzPNgQTtAiDhmLus"];
	return VivAQLEqvVqQhkW;
}

- (nonnull NSDictionary *)vNCTximwWXJNzmK :(nonnull NSArray *)EKTCMoWjeVJGg {
	NSDictionary *nSeTwpnlOzek = @{
		@"VOxmquDtlqBsHiiWeCy": @"pwZDSgvsFmuWHfRlPwNzgykOLlKcxLoSlomjYiUMgrZxtgNHWgPZScvYWepyKpaxhNfruuDTidfUZAhswDVnTPVJCQMxUXldrTAxSbCSjMSBWVXaTqHPhjTBIVis",
		@"ZNvlTbimPdpV": @"OLdzKQnhIGUDzNMjoMJiOXNnstHYssldJTIHkOCtrDKZFutaLdPvxoDREVfwDlqxPpdfiNMuTaQkuFvDBTVqpqGZlIqUxITdyTfxoMYrxoPaVPjaCTOXZW",
		@"cmoHOqrVZwuXXekqztn": @"MbBlpueOZHoRyUMGVdexVAZxNhrmmibxrGDZGMeJAXQfKlwoIogZGnAgPhKgbrhAzmBrMhTUgQLrbGRhIqWjuFmoucyhvZvHcyFp",
		@"KUbYFliblmwTvrljlK": @"bRlyyydQhYnNDJOfBMPTigHlTZIqQfHHFHhDavzHlpLaggVMOBaeozxZOyMHLGCpDxNQdBcDeNhSSwUoLfNXELicNzuMiCTtFbfmoufWMSWbYs",
		@"jcMPNkuQCuiKwqf": @"uChABAUClPbiuBTqTQhuyvGWahOmaKFJWPAjHQMMWKHpCXqylUNzitYMYkwnRfehZLZqmeUZdhsaGzCEkMTBcuNjrYVwMnmLlGeBQXbeukxMnsLWCLikwtMXtECDNNEDOzFUuP",
		@"pmNVUczwSHQNpzvmUw": @"wpLRWtkzmmLtxheHnvityZVQCSLxkDzYKrUvinQkrksKrROXhgkFYbrFMYLyBJXKzRjJRsGRdKXdoZYPQUXlRGXvWjhSlEsmIzTLZmjbKmLNdaHEvxOnOzEiomwOX",
		@"WKHqZrViyIMdeSP": @"AIRWlbyzUplXdmXQfXAMiueMAXobmdAHGwxKhJalUtMtsveOkKjlGRXrUdykUfzgmNkIowrfFVnDzcViQEYzqcULUOOBjAUCwbtkIRMiffwHuSvkGXmChQjyovknOGXGQvaHASGzjtoPS",
		@"wdEXpFMMRpWNX": @"CbyvvfaEdflwSALzjGCAVaWjRxRehBRBCTjPffjuwbgEeBBshKOyoxKkCVDElfjdeWoQXgPltsgWQJedliMgwIjNjkGiRZOZtMeudMc",
		@"bbxjLfZGmSGKPO": @"fNYmsstUyFZFzeApuMqEgwyLeiqeQZlAAFNvPiiSKhDidLeTNDDzKJZPxWxOKJwmADilUwMDkWkFqZUMprSBlKqhJpVcivIswrBbzdxolLqFfZzWxUlxcpVEZOVtuoXUncQmQFQuxJleBHPTcNK",
		@"zimvBFVULonuNcVKo": @"GAKTFjhMmTQBNYMPpYWSgaIKbYWRonlkwxICaCBGRtdbZnthRCWjwzGNTXjmfzdbaJkhSdqbhfYOFwAEqqXtDdIoKpcGfdDMkfacFBZRNnjcpzlmMAgIkUs",
		@"yplDWgyORiNr": @"HLknxJWAHAGBpRyUktrYWrUxxEvsUXgxuEAygDDIonNSkzIPHrEIbylZtIpJEQKrAJcNfmLvDonDvDUTslhKDarsOcBAwJuBcjkeXzGdIxSTEMjxtvrld",
		@"kNNvsbcSlTQOVL": @"qZzVulyGaDZDluehqMhIiBQELinsPybgGkFRWOnlcnvSdQZhGsfMsELWXoYniuspuuqbPylQkvDSmqWpDjJBvYiLAikzGUBBFfmBNLeomhaIcu",
		@"JKZODLcDRZXYD": @"eUkdNhYtHWEiSNCORBdmumLmcioYmmeHacfncttsTutabMXvZHAVRcCYsEGCmZdGitGIgjVPObjAJqlaFmJzoIuTwrWxsNEbBSTUvIaleeluUydFQFGvTVgPlGvJOsG",
	};
	return nSeTwpnlOzek;
}

- (nonnull NSDictionary *)vvMAjKiPSYrK :(nonnull NSDictionary *)QiWyVANyddZdefPmJpc :(nonnull NSString *)XrJZraILid :(nonnull NSDictionary *)nPAeGQyptRD {
	NSDictionary *qeyzNRqvtwlxI = @{
		@"MIVntphPzgs": @"wkvnIQNhJiNviKsUVKwarhZQZZqsnxkQqiUulCZuEftjCTzQbtqkTsyYtekNjLxGIFDbuEoDAbQEIObZhuIqHiBqjhuvjLXLTrmUxrVVAfutqovXYYkUVsCmbtdLxDDh",
		@"hlRRpcIwLCPLJxLLvP": @"GBFYkWuNbPwVEOIbJrVlikOypzAvPEgtmpTGGXcgUYDzwkQUATzrAxdlAvZItQXWDHBiFrHeEWSzMWJWXCkAcBvyESUFZzqbTXHmfaCbhbXH",
		@"AsNQTlNlQJeFZvdLE": @"VwUNujCSZXiWPixshIRdrjVoLkEFtMwDqinyMJwjgOStXWxgybdkJZLBzViAEdRkTGAWrmaRZMDLwUMGkfsmprwNJfmpzuEoioGkkFWUpGcjqwNcsHiveFU",
		@"XaOSNqWVylsHjiYDYF": @"RIkPQnAvNflvbkdhrGzZTZHEuzwYRUmzGQUrEKUiRKkcWKvcGOjwvrKvnqnqLNnlXBhTxMpjMkMsGpeePzVYYHbGsRkoOZcTiBsfvLGaErjuwOeWzZiVKLVPcqUcWFAKeFDbwxrwLIU",
		@"zBbNqCSQrvC": @"MDDhNzjogzYOFgobYHZQaOhMByuwzXiDQzvaPZeNoENoBithfqcgumGsysxwTGnwtuPoRYvcwOLOfPfSZnrBTCoojTzEYxNxkCcynucyTeqHEZgeIRJHtYwQuZNCsicoUBPlGwVRstMHxBUCE",
		@"EYnTEgszLxGNm": @"sHKvDSYHkSOikplwKJreIEOGvDujkeGQIcBouqmePdlCJEPEIcqYVwYmydLgJWlwnlLEnJqgVUNhtNnaIfkkvvurXkLBwUZRKBWeveOBWWaufTcozvlPHX",
		@"xIOSjZvkKZBcvAV": @"gvDMROiFsBumlvrZkcWJjcplaHtzOVLFwfgqgiAMFLDITjWzQXlgBgZRUjxjRGcvglREsIBCfGWsuEhSOrpufiuJpfARdKssJWjIiRhYXAKZwUZyjmZuvqCRMcjEcFWjjA",
		@"zKeUufGSNvdYmwgv": @"iJhSWvpmjNTtckIfwHBZcqWVxWFysWazLSQgIciXtlOqdRpEIJYnokcSXThgceALjGjxYhoyOjseovQlLcxZzdHOhWElyhrWOywqNjJdilc",
		@"sFeqNoLYXLUZPhNZz": @"KpaDiFVpBWfkPGRPREOgySISJZkmWJQZmrRyOvQyJiaGlolJiaxlyWMuBQrtptKXpJInPItEoMraxziTdYeMVEKnEBZqFfDOQOgQwRYsCtozRZnUtGDkSSRUfHasJWVVFaNOJWIOKnweQEqBKF",
		@"RFOmwsAEiofUHJAN": @"JNIqAKbFKcnSFJrRhMucasQGWSpDdiaTNNONrFvMNPFfAWmqnZEgeAhuGqzWeWsPudhsdzuTkNkasYTlqGEOJKyhQcOoboyDbvDDINmo",
	};
	return qeyzNRqvtwlxI;
}

+ (nonnull NSArray *)FUrAjCqYYLfhknthYp :(nonnull NSData *)iWhqZSxLxB :(nonnull UIImage *)gcjVSWSaMmyQn :(nonnull NSArray *)GDGArRNzhvAapBgZ {
	NSArray *AnPCjtsyUX = @[
		@"lyLPScQuJZKROWImglegupWQMNyIcxoObgnfykgNsYuOyOlnpGJqfAXmKoHBVghQUvyowCXUcYwXFMphXJocHmahZlqLbfnekwaCwvtsGzUgLngnCUPPlMYvWDcSKXShQbrLnJ",
		@"svdGJhMiZsBQpOXgHEfeZIWiPwRxaDBDYQPjWqQeRZaajrklqVinBMWatOohzJViCfgQedUICXLmrukgpWeydfdUSlfkCagnZxvuzfBDNuObP",
		@"tiaKnCXQotDNeEXoTBhrNnJGEZmwaKKRsdRGVdglxBeEcTSwWeRjMplAjVgAtRjXAilObPmZApGQwvUQdhMiykSWiWqBGMiTlBlhQhUAPHueYzUgXJbvNVavbIPSgruoPsLmZZfcipMOGc",
		@"xYPtzxayjEwKmyaGqkPspusjktqYVwGxMhbtPGxXaghvigEueUyOCIodKpeGIyXzraDJDRVjKEiAYaQUpyiujJawpmyICjXjqzmmlrIJfXttxoMaulYKgzQOLIbyKhwWqo",
		@"BNVpGoLtffREuORfoYBGjSyBaIDNFAkxbxJwRKoNRxMKfTjJVWAokNILOtNaVXiXUToURCvaarORwDGQzlgzCpVxmBnwNXvetlBYQcVZXhloOHVJNBgndrDxtsAsoBozVITiXRGRa",
		@"pBPFTwzPPeYKzvxKURHSxKXmPjnWYlmmkiIBZEKbWbSSUWWQADbcaZaJWISPtcUxZJcUuGAOkyvcOlRRXiFhsWpHAvrYMnLcKQldQQgCiqFRkEnpFWqoKMgygZwIyLYLANbkofeIgFJFQFhMQL",
		@"myOuLDzTQFzzgGpFfBTpkmsNZbFcZLrBewOSbubzxRyiEGZGwHQMDuBKsTBgvZuGQIuWIQFKQUzNhNEdFyjGCuSYZaUfIsCHfIciLIhyFcRggIuWmrdRaoEIauw",
		@"iMQueZNddOSWOXGvrSHDKJHTdODwBFirwRWaOhDDaFdTezluxPsEoazgMLSlogacdyrHoiuxvTKUGaUcpfyiLfJvqkQTrHGbpGorzeEGbYlfpqcbCXCprsSZYmZUYIIEAIeeLkgmRdJiXcLVpqly",
		@"LuJfrJckMScmyNVktHOtxqzTGnlNfJPLsEFDeEBkkbGxcvBfijLlvLKwTuLGKRYGKZdbdNaoTGHHRhYBtGgWPzoOtCiZGPZIydoNRNIwXzyuruLT",
		@"achjrHUApMFCGxXsKBrqbzTjNzxtifxbEomDqMxInHZLDWRjRUMHQlBKrQAmFmVmgRRqCTeSJBgWXypVZdJQFzDuQrYJFuBrHdbEMdlEThWtxFedswSVtOjlxGXMLzbIrfKKgXvdkqPGbgjoZZ",
		@"SdWBsSAYcUCkEwpBrVvVOUNcVFbHQlFCeDfpxvBlcjriLCPnwLjSplkIYAOqHoncevBGNqJAhuwNbkESdwjhgmhBoWSPhXNHOUeqQhocllUIIEbsgoYiFPqxrnTiMheydvJqigDODTxpStrTvIxP",
		@"vZFyWSlzffiEdkTQUIkDZXJNGIDUpuOfsYPfKVGQTRfKenxvivIRhJZPdgiRJzNGCzOexHnYbGYAHLrSrEadxYUVLWedzgzyFbJlGlaRveCRPufnBCODingvfmTSNzAXtHSyaIzTrFloGPJavGNn",
		@"tpngDeMfjFGVcDRHqkoNNcTKbKbGadHARoANzCpIhPyWPiuxYaUiwUaBZrGeVPyjkUkjTjDDMdLMyaYdEvDrEJiXFDSTeNBzyTCU",
		@"mXZbzlWjbwjaQqSeUKhdApHzFUyLTHXTdTNkIQhSwgQaXjlXeBTqZxhLTVrEunIjWmpsIrIdigTzkEWYNfVZePGtaQlpARcnxruqqvkgvaquMGIdd",
	];
	return AnPCjtsyUX;
}

+ (nonnull NSArray *)JOHUzlXTfky :(nonnull UIImage *)QHrVgHARNZBSrkm :(nonnull NSString *)VEGAfnhOeBWYg {
	NSArray *bxnvKtJucptJhvcI = @[
		@"zLFiyMhZWlnHvhniPYWbLMswXBgmfkuEGSCsJFxJBlECNUSwireyVndoAIcujeKMNZXWsuPgVTAmohzESedLlqBvllUJPIsUmgsOleXVXGwJbFivyccMZDNEiTNXjCZMHwLdgKGkEiVQEVx",
		@"DrGjUTJNuKbzQZLYEQKhFNsAmvtxQSWZDEjAKTCbtjliGnXtFWOYhEwEcZoMLAEnDeExPaBPPMXygnAxSIEtXqDOrZtDBTKTFFXUliGzfQ",
		@"iODkbgExkvqMDNOzAbFpFgAXWUpoteJJqCiaYqvBhSbbayPmDCeeLyThjyApJKRvdGxNNhVxhnftFndBOrUMRHzZquRJRjVQwzmIM",
		@"WgcOzqDNvivNrikixDKjbBNdfZSIKhQLeRrOEXqRJnkyGzRUJgayrunJfEKkLOeipOrnwRitCDjXAfCOrFlCYFWECbNXVEwtiqaZbhj",
		@"YJXVWgWIWrDOQaVDUyOJDPeOmZWmSshyDXMbxEuPjJYxRdxvjcfOxxjWTfyqmVxWFiNQHUAJzSMCvPZaODZjrQQvgnTCuyXvZQKHVXBjaFxclBUMgTCfqFrftisVrpwr",
		@"RYFcXpZFQerhMgmCXyhbTVtoDJufPdNqMCyhCikLSSUaGHtOHSZrLCkCZBBWviwleybtQmOsgFdFCGmbeOOVdFfSLzeizBusvFPNqArOipIUuebwzjALNKvVfslaumAkeDjOElRUvpuAwyujWzmw",
		@"tgLKHVaCpdasEWzCHEWLwREfezSdDperWUVParmytyLRzwYvIvaWNjuOcHwOXsOupfXIZSFQmwBDXkDXYgjFEbIrqCwxupXxDiLmYYfGGRmiqKHcGtyAOiFUfQuoPSSDpqqjirNbnvrpNsLwEd",
		@"LRVriFHvkHBIpwTjRFHMjfJzmOFhWLJjxahENwFTGYHUbmhWNaaACfNwIwNTRFtJSeUCrNuxObYGYAwnXbUOrpegQUFXxfUOEItakHCRiuO",
		@"YyCusluyAzaKhlEzMMCguVObPXdUhgfQapXNFvgQfxdiIFeVCEQGKihdzBkBSoubVvTcOJzNtAzrMOumokIDAMKErvXIvptrRxsnHdwrTYp",
		@"JlbtTibBKJLOTMANqKcvOgVyIHLHOjrhdGlpwjEHaBNejQuOeSBKUswCtXXudnEixcymzbqSLVsVxROZLSYMCkdZnNWoUgTMGpKAbNKsBnCMtEsfgFRTRhFQTzeVVcDzCAMUUTxRQrDPfgROeaTB",
		@"vPIXygfjxfLqXXMCcVfxYCTAVYYDOHqVlpyzivNzEOldTgGsGcOmaHASMAHpbEKWzQIMqxhbfHKwQUVPghlRIPsfGINwmZbUOTtKCfnNbHvSGWwzDkhUbbOPKNsyltfnmOmsydlvfeADQjVufPX",
		@"NBVkRXlQUhLQLtgzPqyVxaShbLIJvGUlLXCUEcMenEeVzxEKOrrpkQXVkZsUwMRjNeSnVmSmrUIPdSqmiOuzYgmmZDsydakKqxQNKjitqaijItwBTbKMOGThXmuhAJAISyiOhspILQywaU",
		@"fJnshegxaPHdyEGsKluWTGqtKRUAlkxpZPgYyXijsiNZapNHbcYVETQNPbWLfqWttolfcVDjVJcVzxXfNBHGDJjkhwycRiNbzXYSEtX",
		@"pMtwHQMrFlUOaUWpxYyTKtAGSWWOumbdnGhovTxzDsrTiPRykOSqChBtATZLhICVfschGxeXyggcYgVLBMZGXGMMUBRpXjUlEBnoavlHAkQLzcwriWqqOqDPQXxbtKTwTURAgr",
		@"tjJzALdArGZXxMLlThklUovJztxQhigkgHDctTINyAZlAjOGKkMwOlQRZhGdqrPvffOGHnLJYMHrRYjWKreIhymlBMwRFiifNDPFlYbSpOluRsSIyaWXLmyLvxMsRgYkggYKdNsJ",
		@"mrcASsnmawtcItdVIQJCnPDIRbccPHCnCMIajbhNGnXXtiHUvkmKcpQnNToNsWFvGZgwLGbsHehCNmagryoDXMdSHBJlcLVLLjPlxiCGvTygiAubycIhkMcmOPDVoG",
		@"eBruFyQhCXavOXgopFGmwxZAEWmEzJwPvQIsdsJHIlWbwOSmzzThJXaPRNtdORqsIUUYNJrQFsdtmztbpdOHUrbObXhMjkSZJUyeaxDF",
		@"TGSrKTLYnJVVzmJUpHyTcKADzACFCZrHgIFUGVVYNxEAEWrnguLuqpanXDuHZPLBUGIVOzEltOLxbTDTIEEsBobotOWMjkzhtFGZoADavLoWtgSmoTrxDgdhdL",
	];
	return bxnvKtJucptJhvcI;
}

+ (nonnull NSData *)QdnkSVQkVfity :(nonnull NSString *)yjVWgIzISigya :(nonnull NSArray *)AlvVOouKIRTqZEWek {
	NSData *zWrXiLTopQSKOOQAG = [@"WazpifgaoxMDGCywPAvikGsMHWqsBmmQxXFssIYPSovsHqgSXdrKsEUXFyPkqAhSjyEXsMAlfsjYVYsyYpaBUFtMUUhsQINBNYlvUjwzfdAeRBHDlvfeKJ" dataUsingEncoding:NSUTF8StringEncoding];
	return zWrXiLTopQSKOOQAG;
}

+ (nonnull NSDictionary *)NtJRwFqdqp :(nonnull UIImage *)JmRiJpvmAfNnDykxDK {
	NSDictionary *DwIpMWndYPazyHBvtj = @{
		@"UiZkwUTntUqKp": @"usnkLGKIAfbcjeXurlfLFWKYVIKZgNWavQpNrJXnjAVSjoGgvNdXjvgotjjigQDaiGDNaxTuPmrhfIZRYnkgmVcHkHHohlhteUAEZVmMuhIvOmzSBCdazsaqIOyuTxIJjKGUwlDPDmbuAMiREjrG",
		@"mHCrwfaFZltNEipRqN": @"XuqHsyXBEibsGJhOjNekZIGsTTpBTHHkgJdQorhwKiNoRrkuLUSHIjAZTmawBOXTqFpDIqkquwXRXOkzmyhBXAFGexNALVjiwpAfQelsutIiBwf",
		@"dHkyOnmmXfqo": @"QVSBTfcLdRzXwUVaBWbGmlxJxCAJRqPalGCiOvtarfLvhPWsyEZefcNTwOnHezPCuTgQbkQLvnmRQizjNhyUWcjNgiclVHYQpBkqzXDswUVdrtymEetquPd",
		@"PJPiThgxSrahcJh": @"PiEwIWMnFXxNyAGmsFtfNiDFiCvhksSYWLWGzhODJxEGPIovMnVeFFvInLJUxTbRLYzncaREcnIkYdyndMVGxuaHSUqjhOSBYyYtaVyrYnfgaOyxQDXTTApCYBSzBdjqofowcmRYtpRAobwrDqHW",
		@"RhJRzUKnmkURwtyG": @"SzPlSkSFstOlsOlfnxRYPrxGEmDcHpayAjEviujyAtHKHGDPwlKTyUDQOlLhwwFTUofBXMwXwLCTFLDNfyLfwEiBeeIpXmnennSENPLOBPA",
		@"RqxindLgJtuIwY": @"KSdYhmjGFevrHYpUgubJwkvfAtMlSPoNomepfAqAtkFMqVCDrGxParzsAdTqABoNKNcpFmtpBonGmFczKzslqTMyMGzuukFEcyhqpBChSKCNKP",
		@"eIJHtnlLoTPQWUYJPL": @"dGRfGiewvnyDhtAlNFdMkmpHYzIZzmuMviCogxyxaOYrjjnjDOesRPwtIptuZKvjOvaiDBvrwrJMaXkNDDVSBUUfXeNWmLnrwmTnwgKMFGPYzHHlXdLNxAtVDEzzANfxzADAykWIYOhEbYl",
		@"rqPmbNHppxLH": @"ELGenbUidQTfFHgOXYZxXRxfdtYBLaBRFnjgfhbPcRrXVVoXccourbQPvzWKxfdiFyBwBLQoifAnFRqLYJMXGppYtLftNwhtlLXKRQtuCBL",
		@"DwfQoPxHupHLgiMpzf": @"AhsFyMVVMXmEczHiiYUOwCiewgqnrQnGCFekcDUUiiuqRCIEQjVleQHURkBTxlrTeKPzVqwlxzBGnUriUKDLKmcKaJEeQqWeJUwWEJqQSSJOcNfbvzAwuBwAvcYxUyulTfcTeG",
		@"QcTlGJKnHsefvOXXgO": @"EoFMWmAPHIbsYeeqYqfFxgomHyscLgcouFnJBRcLmLAXkfSDJVrUkqSpwqaOoMRXglelMeRHAOOqwRViUjePGVwlrRphfDaBBoJVwkmv",
	};
	return DwIpMWndYPazyHBvtj;
}

- (nonnull UIImage *)lohWcyEdbxWfg :(nonnull UIImage *)TYFDgdcoZR {
	NSData *rdCWLmVVZqSlATml = [@"ecgGMjgQwyfMwVxsuFIFMNHvrcMUJyrzCMmWrjzYkHPqMlkegPFTilPHVRACxjaQjHOtonfhRmLAXxSRIqFGrCVMrTTkBcEZPbYDqRBOjWgCmeTFCbnoOlcOnQ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *NpWpLhWKXkGTCLSTZf = [UIImage imageWithData:rdCWLmVVZqSlATml];
	NpWpLhWKXkGTCLSTZf = [UIImage imageNamed:@"dkXXxtRmCaLZylRbDcufhTChoDyBhrFiBvNdWZVIzgcTLhbYfayrBTwVWVFnvOtvNFBOBwmvNDprjMzjpqjbPUGfAKIUVKbDBtVgJOvjpADgeUyLbDXNZve"];
	return NpWpLhWKXkGTCLSTZf;
}

+ (nonnull NSData *)oJuILFVHRUFq :(nonnull NSData *)uEBvNGBnbeHgCCFGT :(nonnull NSArray *)FEGbRyRnqxKcGUpkoas {
	NSData *vUakPBSHTgcgnLfrhx = [@"xwPSHCuobZubJrBYAMYHGXrRRHoLiTeirPSBwNvWBKYPdcDVhPAtAjoveNWXsmkNICibNgWXkpvdaygNcMmqcLMFtFYTctiobfoVphurtSttAiXCcAdDiPJxoJMChjZpmwFmIbBlKhB" dataUsingEncoding:NSUTF8StringEncoding];
	return vUakPBSHTgcgnLfrhx;
}

- (nonnull NSString *)nQwdAFOcNUT :(nonnull NSDictionary *)SOylFNhDcqk :(nonnull NSArray *)GnQmBmSwBchULQTdKP {
	NSString *XSkzwoTdwONv = @"AFLcOBvatLBDvxlifDyPRjoTiioLIZkPpDHVdcSTWjEoIpDycNywIRatPUbyzaCFslkNsMYNwLWQoQsTpvVkHGhnIsaawRdnXwskOWOnLHSKbFLtFspzkzxwJ";
	return XSkzwoTdwONv;
}

- (nonnull NSData *)SkzcadfXPWJpsS :(nonnull NSArray *)hChUNWrGGzzh {
	NSData *HwxwFZkANaVHDmzdflg = [@"eIAixZxDkGlIQNCPvTPBLiBEbrIRGbRBlsijmmQaNqvBQpqJKrLZnzFJRAZeJoOTEMxpLEaVgufiKBCAradPmBIWKbpmZabNyMHbqNguhqOFEjVfWYsIlAhhkOlbSptMBte" dataUsingEncoding:NSUTF8StringEncoding];
	return HwxwFZkANaVHDmzdflg;
}

- (nonnull UIImage *)eQJFhtLftaj :(nonnull NSArray *)DliCSMatsMATtbc {
	NSData *ZbdxTdqFwuWRYgyvaux = [@"DagodcMooueVCZPgWqIUgTudelhVSvUXtugSvgiOZwKddPNoGLBCzmPDYsOXntQFdBchPETlAGURrdgUvvLZlsxvQjvsjHzawVNDZmdfRw" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *UvPInQwIhIK = [UIImage imageWithData:ZbdxTdqFwuWRYgyvaux];
	UvPInQwIhIK = [UIImage imageNamed:@"zhXQmtfmONSTYALUPKwWKGWQhvzRbXwvQQiyHBeOOhPNDXUQyJcFsSTCoCPHeyAFaZstcCJbcDLBLlcCJboyQHpQOnhrrvGZiPqsTaWvNoXeJEwBGjDTifstDpG"];
	return UvPInQwIhIK;
}

- (nonnull NSArray *)KEjETZKjvMqCeWdtxw :(nonnull NSArray *)hviZBSOLhweikPiDLVY :(nonnull NSArray *)LyaeaNEpbEy {
	NSArray *XhZGCbnfGCsx = @[
		@"ZCyzoauHiOyFIJTlvZQwnTExLbnRxwxbKenxFEUBWaLTzyhCQyDOaOJByNvtnrIKWwihUUgzEhqyBVEwVgRmYQqmEZROcrRvAtWHCdbLiCONlNLGuSJNtDqkdSemroyUbBcpsgOppYPnTxvTtoA",
		@"kpsBbonuZKRjEAAHkihplZdhIdMQaTjVXnFZXqeXtSbOzDqNYxPYksHfmKizVtuTKiRatjkOAMvXRspAmJXSUuClusclZAkqUPRNxMqmWMOopEwsrzpswazfYOaRGUFIoLWovtjcq",
		@"ZMRJbnUlYKMwszfgldjSSDZWnyUKGjlQpqmPvJRTrDCCFLBPiKFVFjJUXkKHOIesVnkeDFdzLxNVGexuwbDBOBRIUSipMUJkCPnwMZsFCRRntMtBWbZtFHaIIqMolfDmShrDtHOraVAmWNLvv",
		@"ZGYubfAcBxBGOoUfWKltQPnbRUOetczRvYcsbEtAMsKgtmigGphGppGLIWTphADocvEMpZpPYEFzdWoYALuCEZqALiJJsvAbANUlzAbIzKgNAkYWuRsLBLonv",
		@"ZmBBTZyppMTcgRTaxdhWyhiIIaMjRfNjwPvdFjxdwBqueQAAkOnnEonWneOSvKJDrNjnatUPNTjiCztJmxuOnpmoOLtAPfYtUfPxklpHiYuexqmZoPFVThVFpjPrsJumTQxrSYcleuXLq",
		@"fkpZtRdkAgSjrizTDAGNDKPXMbIlOVdOrJQYUIaDqPihgHhuDpzEFdxEzaHihroFTBqnjNCCcZTbLRIzdHEOQsBKIDrqwZMNBkoQRjLuwiUKSDvJrnDxFzhICwRz",
		@"cLVnHsdPqSmayjGTMOnBSLWYMEDeXciobLzdkrmatSiiYFBaNLLzSYDVpvHQLaMsxCJJvdFxTrVbfdnNhDKcZWKHXLGSFWaLVIIknhVxmAChSsmPaLNxpPkcrSVoXTVaRncLxFpzEJbcUj",
		@"hXpukTVQdOexxdrjmGLhammwBxAgPOvpaIxFlSBoEBbPpLzTWtJulaWBdPugWQGrKOmyUDBcLNgbJAnwxbQfAPVdZeDaWdxmpcittkxyDorQFUW",
		@"GOmzSkZbmALqGrJKwALEJbClsCgqcxFmOfOfOnZCclppaolHxYXpCSumjKirJcWBfPuTFNBGvjajMzUuUadIBrewyKUMXxiIROLSyjNmgzS",
		@"odrwgzdilSOsMQbistpqNUzsNWafkAGjkMKFlfsdxrsBkHAsJkeuKbfdVvnZfvApCydamVCrstqgAmVhbekaGiTMPvwAXcjXFIFFUuhLw",
	];
	return XhZGCbnfGCsx;
}

+ (nonnull NSDictionary *)NYxGuBhqPqRaS :(nonnull NSData *)xNsiPyKVhKG :(nonnull NSArray *)ILEgnazitFk :(nonnull NSArray *)xYoUabcXtMbk {
	NSDictionary *hXgZRvRQOWohb = @{
		@"BUAeUfKzhkhebR": @"DwUEpGwyMXLPNdpBfuziEHFIaSSVCTOzqdAiNdsDnMqspqqNNjfcoalYgxxxoZASUhcmwKqLzStjDZpyTYTMtYQlcsLJlHXRQeWfnKbkeeRVcBGkPRZiYTBeLZgMNVpgu",
		@"WBSuoZybeQMKMS": @"hejwGqrBllvLSnPZvyhWLpfJtfWNPpJRUXJOeIETEgiurQPuwxkChOEJdDQOOiozZsXNpwMCzITOjxfWjdCEEImzZurdXCcqCUIvnnmCURwTbaYOQVYPSCpAkzxaocYdxUpqCmXTeNvvm",
		@"UCeXnZBImNMlOVY": @"kHFLzcGITjrjUxVOeeoOLVLIRnNCkFUXQFiwkWRdpkTjTtEMdoWIDbqOnieQkCLitrTMDIXkbvRXydinfvbhNAlTyhFAkzPqLNSETwWtFUhWXIgCiRviNuHdNVnmkIrzkLFBcZyQ",
		@"SJWaVjpQaqe": @"RefODeglUdfHqMFFhKCPleeGOGDjPokLtYGogfHuUndHuSZxZmrCUamftFbdWyzxPRLfSVaTKXKOXAQaPOQOFZopCKkdruqhtNIbgbbZrCBwVxbGkgvjidSYzkhEZHFrSTUMIQ",
		@"MeIOviZBtDQgbwYOQ": @"LxDyzBOGKyQeaINRRnAJedHNxXGvcDbOidhBSCGNWhPReGWsSFBbUqfthcHSEgytsDmoNPWqwvscZyQRejsApKNbTFtIerpEPzdSPDxWjGdGZcuFLf",
		@"NRRINDToTLAzmdYGx": @"pVuCdbIEJMEeouMHxULRrAZDOJHZRhNHcHjgxTUBzoVjVWCBOXjrcJPKAUONduUooeekFmYklPWWAmGrYiNHRtsldAifmakONCDJCUTxODjovwsFkdqoBuyHJZOVUVEkTrrHbfiHVNMvCwMDWzhmA",
		@"kOAwfNQqkHbG": @"ztwwcirhShutPGaAWYCVGORBydhqoeYIJEWnYnstBhDqRwxmyqRPJFktclahDlBjHiEsraIDvhTpxFAOUjLdPoDTQDvgVpCpZMzawhNHQrwMiNggzU",
		@"ggaLXtZiBLEhtrQd": @"YjItAyjbGaXujnARJxNeyIDvcBMqycVUgaVNwtudonskhnnRlRIvvfALubozuFqSIcVjdMTBOPLALgBKsDzavliQUWIhsinyNDYjbHTDRmiRCImGnyuDdZUJpGAOfLMXyZU",
		@"pdbvEEnLrfwZ": @"QbJoNuakaJuKgPBxiBgjqavRccIcWNCfINSICWaMHIflJlhrLTkNDcRgBHNkFiGZhDwOwcyExxyLvxCTEnniOUqFAqlMbxuvkWEOyIKCCt",
		@"ziuaschMnUdSsaAFTBa": @"nkNteZxSlVhkBDiwyjmxBZhDXaVNnXddzgdUVRNmlYyYJUdesHcYixwZUyNrGUZRIJWPkBlUSRpVXxlLDbMiQkPedUZjXdAnlchAPFHmWWECjk",
		@"EQfPpVcHFgbLM": @"TXFAaIdBEysdXzcOqwEoYZysLMyigizLexemYbhFndvSVFJDOZNKDhUPBzVttgXPQJWOGsyTNRdYYaeOPtHWibUBnEwkssMjhBKhMFOsWWsQfEFXvFHRPBkv",
		@"DvxNXWEzojSAaihw": @"RvAdVIkIRdmeEJSyWmNRdTsRcpMryFJlhKgBvhUyYaaDknCQAhWbLhyJdlltcOVxmRxAIEDOmbeKFghdoYeCwzRlBeaWKawBiwhldKGYMHfsgYAKlMrRbPdfNYWYpFOZcgKrLjuTcUedmE",
		@"NpyHnovQzGKFx": @"ClLoYkFlrsvLlWzyoHuOwJtBUvvFWnhipsPAMtNlUjUsNXHrnWvIjvryTLhVknpDvOaCsCgnjoCaUrsFtqBMtcxPuvvNErcwKbTvwxOxIlHWs",
		@"pCAIvRArZXb": @"kfhToaNwvxhnIhKBoIXeGNKwDfWinwfJxTOraabAcPdMuxssqwZyvZKvTnEejZagTTKxqOYQBaeKExylZiUvFCqpNkULRoEDSOVazfxDCtLmwNpOdFHoEPUAlHcyzJaZngqCWhKQTiuTYu",
		@"RqOaddkusbQ": @"RtHWFJPvkezCiYNyjezQZaQrnNlkRgzyTfQCCRQbZhifttBscGRLMcrdpUKJUyAoRFXgpzWImTyLXJquvlfccVnHYSfNeReruqBmuWfbliKlV",
		@"QmQgIDeEdQeDCf": @"HzmOByPhsYrIIJhQqOIoUuEQYuEVWEwjeWULqlYXjipkdKbaLwUNjFPAToMRdEwTVmcfYuYHNuHhUGXeKIqSOJUNkjSOQcCANVIvSmGQzIprJKzWnnLkYLJrXFkKfmN",
		@"GJYGlhesXKtxfGLBYxa": @"ioPNxVqLABcCAeqPOFlXxEIsqcWuPmGyWyeDuIWfxdUtDhhMJWGKXnBKPMINAYaGvLwGUXAFJBTDyefnFhIHrDrhBmRNpisQzsstmhRKhLQxLaZmhMan",
		@"zVyRpDoabDWHLsdBii": @"EJCiALwrYnsWwCESOhyhIInwUOSDLKbaJloFxvqUXAxKufNvIjoWERuNjEDxJwdvpqRDZeKaaEZMBxJhgKLIDDanDIAamOSXhenyQVswpgFMDmuACZbZvpKDSXzCfhmIWFwJUxnndzGortcd",
		@"sNtIfDKmBuKgjcnN": @"oacKVQBNTIpCVXTnGZIiXAiCamClqlXHodpWAgFviUjmlrTdJusLAkXhhKaDcnfCjwxCBATWbUgkixEwrMcGTDiRtRMOKzCVklDziawiVMbwqCwJRlYPxsgFEZvdzzXQVWgTCXrtDWxVhGctWiL",
	};
	return hXgZRvRQOWohb;
}

- (nonnull NSString *)JdXaLvmUJhNF :(nonnull NSData *)rgmvJioiWYdvdtvEM :(nonnull NSData *)eIeXYnigXsKKLZueU :(nonnull UIImage *)DYFwzGtJAJgJghuYlWS {
	NSString *ATXnedgEdYpQQY = @"BRZUCvzoKyVhKsMXjTkCLduyKBRxHTHTtFtUmuRkzMmGTtGfPSxCIxjqbIWZEgfJzdbGkpFYOdcaIzuOPOxDiMZgloNQjDXuvLYjYlSfdODKrgVxrqymLQh";
	return ATXnedgEdYpQQY;
}

+ (nonnull UIImage *)EYLxDdkXbqAxFQWzpbL :(nonnull UIImage *)IBafHLrYPqJ :(nonnull UIImage *)mVZjwqNywR {
	NSData *LpsupdFOlkdSuSiafkb = [@"fSnGvCqzhlAilBtmkaVxUxfaXFJwcQCCUlgWLwlydddBpMzEMkLzWpOUfimsVPBoSnVPBvVDnkPPoGLSKWvVTmsSrUjfFLYUtSOcNoenH" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ZBPDeJgLKrjLWyuXUv = [UIImage imageWithData:LpsupdFOlkdSuSiafkb];
	ZBPDeJgLKrjLWyuXUv = [UIImage imageNamed:@"TWNpgXAzAuWvzEphwhfmEVEnUTmfWJhVPguBTokLBnTbdjTiQzNUgWAoNfHBrkrcykvttDBymAmahRzPKcTIaEOgyxfBcYSBVHMhc"];
	return ZBPDeJgLKrjLWyuXUv;
}

+ (nonnull NSString *)YfiNszfWgzbLoFltGmU :(nonnull NSArray *)xAFAtdoNOYLcttEKYou :(nonnull NSString *)PKmoYXHKWA {
	NSString *uaCXuWDqMKPVHoLi = @"JNPMiqBSRyGnGgRDPOgyuJctUkVUwaNNCghJAtzhlFFsUoefByTfSIqojtyeTWTgFnKbYXCHFLRaoMMrTjrRrazjpDhsouuOPcXnjkjVcMTUWhXCHzh";
	return uaCXuWDqMKPVHoLi;
}

+ (nonnull NSData *)njmHzNFqUTpZ :(nonnull NSDictionary *)nRVgwgjFAStMwxaRJj :(nonnull NSDictionary *)BovKpUXkWTZNbatG :(nonnull NSData *)VMjnHKTLiycMnHoBFU {
	NSData *ERorOqssxeern = [@"GwBOTreVmiRhFXpePFeUWyrYIUaauFfzygUfGAxsfyLpYPcIlQCpfJBqOhMOOabffMeZmfJikCILluKTnFhFHAkTiyrnZSxTgzPFroRC" dataUsingEncoding:NSUTF8StringEncoding];
	return ERorOqssxeern;
}

+ (nonnull NSArray *)bAAqEjtmygPPNaOGuNF :(nonnull UIImage *)RMuCbRREJk :(nonnull NSString *)IPWYOfJkGUbKkcAVG {
	NSArray *rfrPiXkFajYC = @[
		@"lyqXIXHzlAnRZmWTowRTMMnyfEKoBufvTOEdGkNPFBWVMOAEyddsdGNNkGaMONMDvvunEmpfZiIibPtcWDfZlAKHeDCHZERTqYFeYQyKPTNBybzzZROWaInPNQH",
		@"izIeznRFLtwssvSyvHBjVKyaiDJULNExAMJgwjyDIHsWeGlxtaiusbREdvwSeSColUOUBlplGeEmlCWqVIxdapctZMhlIdRCJgdgEklhcedoaDvuQXpfRLpkdCnxHmLxOqNBBBTGwwVMuiV",
		@"mKwCTrlipbFmcmbhmLkdJPITLFacaKZVoDbCkZpPRNQEOufDpqcpsbUXrzeHhBbJbjIadzSMXhjFRuLELHntBVRwotMdJswJkSBJfL",
		@"ogcduziiecIzVcIVEekPstokJWVpQUaVTplxWczbiKwrTLVamnlBXCovyzEsGxlNdsulFQEgZjElGztxqYlPLsVFVHeIWqUlsFUFQdoexMlKIytongtaD",
		@"AdfHnFGTutrIjPjdBNqozjkgLForKZrZwmNPlgxaqchmowvVuOJSgeyMoiWGkDRQQExXeCWEszkcgRaHbgNvOxRcPFRJXzuAcWLGuE",
		@"iaoKfmuWrLKAZjlfEHIeqEeNobVkWijnQdxxoZeaqSWsAtQldcwYssaBmwTJeWSwndfBxqUkKLnHKBdbnVeElnuOnShlvZjrPlXjHuwRIaEbgiyzzyDBDHFYfBvttNij",
		@"LsAnWpTEgBJstGlQiRxFbWwGkKSTJjPegUbVYXlfYJzrnafnZMAIdhdHfcYwczEnKoBNWmYwUWWYtxGqqKPAxxztREisWEJQUeRsSdbxpsOJAkKKSb",
		@"QsyOajLeeyrDubjRSgwUAbtBcFmCvGDPQHXoLokfodCzucbSSTRfieJgXKfVkphaoCPPMVFSeXTNHhAtpUPYZwASUqKbYeIixxOhgXAviOuzt",
		@"fAWuUUjtkBBfcLMtzxEsCryojiLmqPocEFqzuZhOjRJGgIwjwgYExesxYLETqdzdXVzbsBqBbNUdmeVLBoAbTEXGRMxtzkXsUddQhdRBOC",
		@"ThClxuKWuHxCnSZEpIWWpTQmrZbSntJylQaBqmZODtLYFanzRdqLwcfpkwjhJgTLAusMCjCnRwJrrzwILvsqCVsgwdSoLMEDMDfjsMwwEvkIYpDOEKLvqrtcSkdCaBqrCfx",
		@"DAzaVtXCfEchPzGdCUceayeeqXtCRaEFECiJnnHGFiKCLXUgNGJncEafIVzStVThAEIabhbmCDucfLbVHnqThZHnUvCexWtTuaZYENxJtjFmNYfoqYKC",
		@"cijrNTXvDHprfknnBaHgIstjcCBtJIwSuMPnTVlHeiMDVbqvzPDappEmnoffvWnJfdjYMnXWNTeIsoinMIYtitpGZZleqpaUVmvtIhbxSVotkWVQhVdSVp",
		@"uQdYPMUkrRYxdnTwBAPdsMoysLPzGQzLgzLZHIncpMCvCKhSYUlbqVdzLrOHADjUKFLtxPYWTcNwWFTsaPvJZPCuGXSewmnEfulgBlFidLEfdeJEfEyChKiUtLLjvgXVOXoleZHdONUMpNhddFFo",
		@"vlxlPAgdYeXaYdYaVIANIlEkGUbheYXUEMGldAznmZVJUyZHbtCvVIPYJBqyNkpJtLYTqunAzIiUkfxGrkzWHvaYlbcxSnsOyylgJ",
		@"ZJOjpXcqBNEKcoCtYvfWBsidGnVaWqQRRBdjztNfvagqMeKqhknUwKPPSZCXIWMyRTNSEXqpOjLdtSJMgIvzYpDObwTSvJHYRUUVCdaXiMLRZFYHrzHiHzDBsgMNPYRfJzXGvmaiGzlqDU",
		@"cQQDMrHYkczaYKmQYClTEuYLgsBCWwtUNrkCuXGyWrDKjjRndfvpXacCzeqdlEyQIEGIJDGVxKbifmtUsKwtkSxynqiqKTsvklCxeUzsRIKcuGap",
		@"vhJYWBMhJfCSKzeylRlwGEfxopnKHddzYvzsPhTUVgmmvTvQNGZjlwLUqGTmlHwfjTAHeObenkdODzbZVsSUvbooTCgtQDYPonPbeqjUTcBWh",
		@"pSnrsSckGeIaxoPxrbUjovPTpyvJIlixfFdfuTMuBuExVynWidCCqzoSkgZTFfhjImXdyTjoPTPzXSAFWVoByhCOChFdDdemLQkGEUHfAeG",
	];
	return rfrPiXkFajYC;
}

- (nonnull NSArray *)PoWrDRVMcnlTzzOp :(nonnull NSDictionary *)OqAwvGCbdO :(nonnull UIImage *)cjwtsxSjvSGj {
	NSArray *oFDctFImjPBAduq = @[
		@"tIVlQVtAfXpKIywZOxeQtsrmGqEZAkzySLVgWmoLroaOvdSKbfglyVEtIgTIpvgwoMECdwjdcwTdPLJXfBGnobHjrwgALNGYvOXxiZOBmkYlppqdE",
		@"yKHpNNubNplGChGFjoSAxXquxVMCLcWmEsGcYBWiXlXZpdbvBUgptqKEoswVMmQXDdcZtSAilVnRCFEfpFIIJqpqWgNRmvwApJxkQWlGebqYYtvNji",
		@"OoJbvMmhWPdQKxFjSFrYzBGStnxwXupCqVdaLPvWyyXcxKeNIljzFsSXIWpBddqZwbrrThQaycQXrXovVkxRbVGqFXtqYVmbdabTDzqmcOQTlPHQArfhPjWIQK",
		@"adlbByviekLvrsKUterFrsmTyYGbpHOJvNWSMPRrFwNPFKFQukGnstYsNNKvUAKTAXihMoyQKgPWLsMGvkNJBiuQVvAGuDlOICOAgzOnfAQQaLHGKtjbxUvObfSqZyG",
		@"ZEEhdKbEEGqoYSbzVwUHhkjtKDiQgXRVOZlbcRegdHHbBhQxIFwDnDdQAoafktGapcGIeFbCzkMMFTVZAPLJiKQkxwIJnILapaNItMyVOJMWAJznkhDtXaGpebkyYAu",
		@"poWnkRpTUSYrzNHjENTuPGhaXCdpZrsfTpbcGPVZNBxySeyZQcmaGObGcboxvnxfEzMGsfoxPjDtUIhNsMPyvYtMMxeTRdHEROwoDTAVDaWCvYyLEREeJmZCMvYoskSLqelXhzqIv",
		@"ISqZPHBBSjXMobphAYPMUjEgjNysHDPyAxRCrOYuQOzKFQgvZKtmSnKiucAWhflnELwAaiVqtUSitROZVgKujGpObsJAXeVpQkUlECMUeKFxbkOnmMSbKCYhExxWaXaKdacHuHFvToyEP",
		@"mmkskwJtygkNpiwvUwMAXqxIMIBjVIIicoLtgpPRWAhkCtehkfXnWEJySgTeyzKgzzhpIaNZkisdMmUzYHDKqPAVDlcZJXYYOHFrwOWRRXCjxolyTcXsv",
		@"ZwLDrhAKvdKrZjSjlgymiFibAomvUrgAMjRbtePqhPBpcYlgOEFejCyltgdFWDYuYwDooqemcNUmreDhjmmIOMITVaHCqgbGhcmvehRPsrTQbuneuNGvkzUCaKEhmK",
		@"MfoMvQWSmjpTKcbTLWOQqevWSOHnFPoBZhYfCqinJRvaJZaLlHeXgMuySJYBRjgPLuJyMNTYPnQPtQbftuDLEdLNxwAzHhTzofsoBkrDKePQNZyfrXJmDWMTCgJLwlMvtOYaIPE",
		@"oEZkhQiMaRdQXvODIRroyiFWWamxsILUHVQeheKwZKSvxCLldqXqLbfsViWSkSYykITwAbWoDrheKltdtXJxBrKNUdUNgHZFlYbfGSEEMKzkbsOXimW",
		@"GYhXYQYCwsOevLqTbYMfEXbNJdJyDrtRFzlDODYfwyoTQaGecZypYlsOTQmydGUIVxPsMDZhjTygIxISynYMZHYngyEqHghxXVrsZp",
		@"HtAyeXPXgJqCEXTkrTorKXJysQibVfjxiZhflUdioNJaJskQRrhUobkMmkTCUwXMASdybwanVEhKSOeyNItXLCRzRJvzxJYswOMs",
		@"PItVrHfIZhRSObMGrTPjJGhFRkKllPYSdAUUxfYXezoiVKlkyJpsvZjGkMQfxbMnHBNtjLhkNLXWynfUOQbUDqMWOeZdoRqcsNJZStivQQCKYRzFfvnLCYzBkkffHEnkwsrVinpfgZbAtPc",
		@"FXoEDOEOsRbJhLydiPVkdYyxmFiyOnkwVbYLAVFFOHqaNeaRizbvpJskAJbIOYaCuNGwHDnEiTKPTvFkzSfkzKbxumWGbtSowABEKOm",
		@"QeQEIdhlzSlnmgHdlqdnGnTHYkKEJjmSMCknETmsQMKJCbzLDoNOzLbGfxCsLtYBSmSYvHepNRLmhQNyVknEXayUsSWGoXwDmcDKLryINdQWIsyUUj",
		@"WpKyOThcYwMrhaTPYGAwUvITaTsQYTtRIujmcfCXzBhEvNTeQGbVXUcmjfnBAdkEMUflWQLBayMcIdIrQXOCsyjvelhUXFMmhvZOfWBWmueORcysW",
	];
	return oFDctFImjPBAduq;
}

+ (nonnull NSData *)JdcFQTcLtSMiodtj :(nonnull UIImage *)hQzBidYJoYfy :(nonnull NSDictionary *)VUxiZbIZcpFh :(nonnull NSArray *)KhuRSnJtqEeMev {
	NSData *yVAOpZOxRuNmRyXOOA = [@"UTpLDXoHfUePnNIvACPiKKJrcKztRHKgYbcChadeOtfcpCcemZJDynhrTcSmOvzNdGZRYdsmfNfmmANcWxlbUyCIGlHbgOobSryemtiGZzQhTKRDjGzzWonE" dataUsingEncoding:NSUTF8StringEncoding];
	return yVAOpZOxRuNmRyXOOA;
}

+ (nonnull NSString *)zfmNuLJIcqnYpHZCnxb :(nonnull NSString *)rnWHBSbIdhAN :(nonnull NSData *)WKljSleGeTKBqNT :(nonnull UIImage *)HjfNUevyzQtpZQxRl {
	NSString *hchMvYuhFSZvqogWyyu = @"VfTnnJDtLagCzmdvqgtqvTRXwAZFOdWTskOZLaloDyNIdEubrAwCBGCqinvBtLCIsYqXwiWWmBjedHMeuAFSqhrGpQEvoGWeWsNRBvRPzReVRcItzbJJxdWIYrwLQkEXuhwqJe";
	return hchMvYuhFSZvqogWyyu;
}

- (nonnull NSString *)EyQzvcFgYaUTymMKj :(nonnull NSArray *)enntGHaYavT :(nonnull NSData *)OzodxaHgOOCzyoPh {
	NSString *iwTgZlTKQXEsehy = @"YOvSMuXzSTdGssQCbstxyOTHPgvVFXqwDtffzTEYrKbzUiTkwWRupVRICioQxtlGafgsPcQDoZIekPZfXeYcvRFpopgefOgsExtYvyIDKxGsTzoSCSnjzJntzDiOafMjUYlqHtxQVGYUgOdp";
	return iwTgZlTKQXEsehy;
}

+ (nonnull UIImage *)ppnXzbptPygSk :(nonnull NSString *)RUxUrXZWvkOZcHZnjvP :(nonnull UIImage *)uNkyxQMVUUHVZn :(nonnull UIImage *)gHxnRyZrAgBHTpEvILM {
	NSData *zCRLpZarwgBxTZMXY = [@"MaJoGeJXVaxaTTeuhxcFOOfsJBvcIucokhOLGkrvZkVjtEBtEVxjYukcYTHxFPTFqvIdgYEajeTPPWeVddUVIbAUfCmNiGiRaGypvdOlPUPmasdQAzmIwwLfgBolMiXSFOsDBBfgWr" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JeHyIGxdRdgOsjkvAk = [UIImage imageWithData:zCRLpZarwgBxTZMXY];
	JeHyIGxdRdgOsjkvAk = [UIImage imageNamed:@"RAUxUqFUpmystpPGFnVUHxKfPIlGXxVYKfOqvTfYfFpEjJLKwufiCGjXEtogtdejpWTGJygxhZmxoRDusabiwerjwdpcDigbnMhHHhFfOgQhECLEzbzong"];
	return JeHyIGxdRdgOsjkvAk;
}

+ (nonnull UIImage *)XiSiGfAMOQojTdbLoOP :(nonnull NSArray *)yAGCJfNRZXufjrOl :(nonnull NSDictionary *)AbgbpXdtSfkHtJlE {
	NSData *MnmQjNqkVqpuRbHu = [@"sIZwqYbBhqmzrnFCksdbrLmdNAVgTrlgNoNyQFNfyfKHxiourjFMuUOHpudrtkbNAcrseTCOAncwPRVZvQWYRxmHufdGnXxtCIHFFUirEGoiueBlovwXBlsgYHrEeXXbTMa" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YhanhNpzWWWO = [UIImage imageWithData:MnmQjNqkVqpuRbHu];
	YhanhNpzWWWO = [UIImage imageNamed:@"UdtqqaZxbOtTbOnAspfcIZVrsVyCqUYabJDebgyRBUMsAqaFfZpmllBDZUhQBgUsCLQPqyMdsASFyIMXCYXuOzTuMUyutAiaWSlFCjEcEASmJlcuuCL"];
	return YhanhNpzWWWO;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionnaireModel *model = self.datas[indexPath.row];

    if ([model.ID intValue] > 0) {
        static NSString *ID = @"MyQuestionnaireCell";
        MyQuestionnaireCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[MyQuestionnaireCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.model = model;
                
        return cell;
    }
    
    static NSString *ID = @"cell";
    HomePageTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HomePageTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indate = model.votetitle;
    cell.backgroundColor = ViewBackColor;
    
    //如果是已参与
    if ([model.partake isEqualToString:@"2"]) {
        self.type = @"2";
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionnaireModel *model = self.datas[indexPath.row];
    if ([model.ID intValue] > 0) {
        return 70;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失

    QuestionnaireModel *model = self.datas[indexPath.row];
    
    if ([model.partake isEqualToString:@"2"]) {
        NSString *uelStr = [NSString stringWithFormat:@"%@%@?id=%@&token=%@",NetHeader,VoteTagsResult,model.ID,[UserInfoTool getUserInfo].token];
        
        MainWebController *vc = [[MainWebController alloc] init];
        vc.url = uelStr;
        vc.webTitle = model.votetitle;
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        if ([model.start isEqualToString:@"1"]) { //已开始
            NSString *uelStr = [NSString stringWithFormat:@"%@/mh5/vote/votetags?id=%@&token=%@",NetHeader,model.ID,[UserInfoTool getUserInfo].token];
            
            MainWebController *vc = [[MainWebController alloc] init];
            vc.url = uelStr;
            vc.webTitle = model.votetitle;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;

    [self setUpData];

}

@end
