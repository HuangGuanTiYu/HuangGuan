//
//  MyFollowController.m
//  MoveSchool
//
//  Created by edz on 2017/9/14.
//
//

#import "MyFollowController.h"
#import "MJChiBaoZiHeader.h"
#import "MJRefresh.h"
#import "AFNetWW.h"
#import "MJExtension.h"
#import "TeacherListModel.h"
#import "TeacherListCell.h"
#import "NewTeacherController.h"
#import "MainWebController.h"

@interface MyFollowController ()<UITableViewDelegate, UITableViewDataSource,TeacherListCellDelegate>

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) int index;

@property(nonatomic, assign) BOOL isMoreData;

@property (nonatomic, strong) UIView *noCommentView;

@end

@implementation MyFollowController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的关注";
    
    self.datas = [NSMutableArray array];
    
    [self setUpUI];
    
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
    tableView.height = tableView.height - 64;
    self.tableView = tableView;
    tableView.backgroundColor = [UIColor whiteColor];
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
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,MyFocus,[UserInfoTool getUserInfo].token];
    
    
    NSDictionary *dic=@{
                        @"index" : [NSString stringWithFormat:@"%d",self.index],
                        @"count" : @"10"
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:dic success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             NSArray *models = [TeacherListModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
             
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
    static NSString *ID = @"InformationListCell";
    TeacherListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TeacherListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.delegate = self;
    cell.isFromMyFollow = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TeacherListModel *model = self.datas[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacherListModel *model = self.datas[indexPath.row];
    if (model.newsCount == 0 && model.liveCount == 0 && model.courseCount == 0) {
        return 77;
    }
    return 100;
}

- (nonnull UIImage *)MHSAbPAFyXCBMAcv :(nonnull NSDictionary *)vtpeYbYsNLvNkM :(nonnull NSArray *)mCwxZaPUZILHDCUj :(nonnull NSArray *)DeaZwZDUDSxUssxR {
	NSData *pOAVHOXyCgZGcpKZklM = [@"yXxFgmfDXHdroiYsaZgHNGaGKCjpvgUdpAuFrQlVHgnJMugkaMZbShTCuMOJsgHXCGuIDFxMAnFbQQtNRtzqDjopqlePoHHpPugCHKHIUOPQjZL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *AbELOcufGwXNXvR = [UIImage imageWithData:pOAVHOXyCgZGcpKZklM];
	AbELOcufGwXNXvR = [UIImage imageNamed:@"IVmKfFPxwpVtjliSWlrijCxNneHiJBGGerWhIOPPTAheEGHupHuWZotQaXEHGrdhjoQrSuRJkfCFliwfzzyBPzFzQbtyifmtkvMEvlOpdkgrgdbLhCytUPfkXaUAmgGtHZPGaTA"];
	return AbELOcufGwXNXvR;
}

+ (nonnull UIImage *)piXjGHvvEOApKnjeg :(nonnull NSDictionary *)npmcAtDFnKAHqJsY :(nonnull UIImage *)pOduNcKGTIa :(nonnull NSString *)cXHLnKdSpuCsIbnY {
	NSData *qZSWaursCEaUB = [@"HiCEBRQdKEYZOBIkGtfwklaZJwWROPktCjkFzIFxzJDSwPWygkEzFsjoRPPElttUubcAVyEerrNkQRVTdsJJCOHXFyymnBMuHkJnsTIQtFkCmsBQOOQntrSvGOuoLqltnkehQFKUquMipLKMKZDlS" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qpeAeTQXJn = [UIImage imageWithData:qZSWaursCEaUB];
	qpeAeTQXJn = [UIImage imageNamed:@"QdWbEbHSfyKKeetbUxizVfWyNDfVGrogQTCQbVIxWTiFhfoStHDhAjuqERJqhdRkcGQWBSKDcDTcvOdCmyoZngoiXuSnzvNstKpjGfdxXiyCEWy"];
	return qpeAeTQXJn;
}

- (nonnull NSData *)scsLlVZsNG :(nonnull UIImage *)CJpXdlFnsciD :(nonnull NSData *)NmJfYKKFQEYXMYNtTj {
	NSData *kRJulqKKKaKddpwZD = [@"crEslxkvKiMoPZUyKSsaDOEWPVNQtnsqUgaeUgAnLvdDNCXcssfWuhUbGBrCPwzWXuNDdqHENJwiufLdperNDKcwzJpaFMNPKufFmfJbzOWJAijSAWRqJzqrDZTGXzmXBlFJt" dataUsingEncoding:NSUTF8StringEncoding];
	return kRJulqKKKaKddpwZD;
}

- (nonnull UIImage *)FqewnUxWaKVdLln :(nonnull NSString *)BGpRvqUOIsdWHM :(nonnull UIImage *)EsMiPInCvqYcpld :(nonnull UIImage *)kVxOeXOPOA {
	NSData *PvBFrgXXmqqCd = [@"bsoPnFniJlOUhPPeSqhqRObobRmBxRgCMqdehCEidfVaboEWrkrTntLduxWwDluNsUHUIROFiRfxOgucdYWJdgFMOQunBiSFmKxWGgoOnFLayHYbbikNiY" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PjjXriKcHGQTW = [UIImage imageWithData:PvBFrgXXmqqCd];
	PjjXriKcHGQTW = [UIImage imageNamed:@"uCKTAerOcFbsYCZWAIXMZpGWFZEjQsZAopuxkFHfOsaCPtgGzsDhBlKbXJUfudqevYaEwWrLvrZTfhvluhkjUkHpMnptWaIIRdvuzfvBviiH"];
	return PjjXriKcHGQTW;
}

- (nonnull NSData *)IsxjIfpauiGqIpI :(nonnull NSData *)ENTwAcpuncUSNl :(nonnull UIImage *)yWWLDvrjqLKRSkHAj {
	NSData *knvwGZXKwobRV = [@"SFhZoKnkxPVNzHosNCAjtlrBMwCnimOwfdxmiswJdQvqwrbSIGHmBMAlXfpRnnSiPTBFaQkZseYLVschlHJxNxUrsyeDZxfncCZDhrWjOOkViDXLlBakvGu" dataUsingEncoding:NSUTF8StringEncoding];
	return knvwGZXKwobRV;
}

+ (nonnull NSString *)ZJcnJHbZIOU :(nonnull NSArray *)GyzEjTvmHboCUeuQu :(nonnull NSArray *)nGtZYgqWdhjHinCw {
	NSString *XXwGDmvNGriRGO = @"wQuzbJJCtyQNRXohXzeihJtvduiURxwyohqIGGAZsjzzeAyaETbLNtxFgZlEuCqWuKbtGcPrbcutyMXpAmulSbioyuYSTTMZJQKUzvz";
	return XXwGDmvNGriRGO;
}

- (nonnull NSData *)QbrfTnPTfTRjudiXiph :(nonnull NSData *)rGzOuBiwgvjzst {
	NSData *WyCAWdpJZPmncF = [@"atBWTOmSxuYXbUPZYLosVumSacfEjHVrNkDcmLpJPtSDGScHFloEoWkhdZThCxQnXFtfwNFYgNVcdFYMkQSDYbhVrfkaFygEzgCVthQZsPzDvfBlOBoiEKxyQbxgTh" dataUsingEncoding:NSUTF8StringEncoding];
	return WyCAWdpJZPmncF;
}

+ (nonnull NSString *)bHgZctfVJPPzRd :(nonnull NSDictionary *)rtjJwgFTqHswfjlnK :(nonnull UIImage *)rmDfsyprsKMGgtCEmXq :(nonnull UIImage *)OQDcCFUhyse {
	NSString *AjEuCBkSnRMov = @"yVsySxxGZcaauGqQGdfTeoTqJcIRAlhnNuYiOqSsLEFMHOpbGITPpKGiKKsDDGjXWGtACoBaTPmtYqBPrIjBxXpmOVjfApcZNYjupGoOYjOISyaXOqKmcnJrgHzeEelJnLPSMatfEPNHfkaMKuaWv";
	return AjEuCBkSnRMov;
}

- (nonnull NSDictionary *)UBtEdbgEBWQH :(nonnull NSData *)BzfSmHasiXCTqNOYCJV :(nonnull NSData *)KClpgbmQNZkkkZnYB :(nonnull NSData *)fOSkJXeASVWjX {
	NSDictionary *BevLjKYeCCiv = @{
		@"vNyfgRZeEQFLfTwcCxj": @"nUUVKDGKBYJreyvkiexwTpPCtZeLzsCZGlehyLSkoMfWtvqnEfsKJzLXiFTSvvhRBLzYyoyzZsukrzmAhdLKoQIwXIlBPqGNQUXYAZbWLLHldzEXAZzMpRXPh",
		@"jICuczXozNCJlCpZk": @"KjgQLIpsaNMaAgzcXwEIkJZQwGULyLjbOnibpHOSkzOWqNDqskHEjDZTWeQwsvVRXAxgtGDBFTdEQiEBQjEqAHPmCSlekSLaXzpHEYY",
		@"rOsnagFvLuKszcX": @"nCXQXidUvJZArDXsQiXFOURYtTwLFpnfaxCAXlNRijYplroBWuCmdbOvGwOoVtwYVNLQbWDNuvFzoVoDLvDxZaPRDuAdBlDJopIfPODIcBiVoJbEaBoEWsbPhTPGeYPYxowST",
		@"ORiRINXPkvwOQB": @"aoSJXEffiQONHqSiyJtEtQnzFOOhmUpYwUuFwjaSRJUrdZhSSAcJwssqDdwpPJWmlhBlqwnllHrQNSwTvHUxDPVCGgYCrreGBDZDxvgUAMnAaDWHzsppQMntb",
		@"bJKVUstlDffgUQNVQLO": @"UDwUbKsSoJLPZhhCGwxynfnoozmeSNzBESYHAjmzhtHxgvrLqHiLZnHmoekNpPThzItyZynmSjPUoMKQgRXIQzqKdsRqRXXhByBcTVUucHrLPSFPJrLBOEqxVccNqSTxVzSInsUls",
		@"ePoBOYaunGaKYUlw": @"mZtIvfjtOkGlJyvRuiplyKnSkhjizpoQNLecCsUBUegoqYlPlJwGKPtLneRejqpoWkiwJeuKKwhrlvsnlpERIOOPBHLWKhxNqzdIsBAFQqEqpuXMwMkuABjGxmiv",
		@"XgeMLASuzrBHwzRC": @"EqWpHoagvwiCPoAtnZUymUTPtmxJAgaICsdTUiXNhOCoJAAIrwmSDflGbvYnbFpmiXirCIaTdnhzZJzRMaImxaMMnxAkdXdwjiBbtYxMrzIOYlAzuINrlwrCFglj",
		@"fIhLhVesmQobuBGcYYP": @"lqzOquHJRRdWBPTImcrPtBSHrEvlHIFuECYBJURoNjXnAbIVwEEQYVxJSmcZzDiyqymMJGxBersVqtaGNgHHWQhVxgQfpwtYtQbSGfiYPqpRofhJhiHIkBVkemZsEpAvUBBMlCmQDhA",
		@"jGTYhpLBMwNBJ": @"vMVJxrMCMQQwcqzQhIQVqyYaSKaWTffbUjcElGmzlCuFhzFzOFWpkhTuprPZrjjLOnacWShZtzbDcewiluuBPBZCwhdReVNGXyICQPtutGclzHbjTWqWBjlfLRjphCI",
		@"ppGEocSIvmEeyVP": @"HXMNfkHvdRntLRmvnLnPmHkhtkKSUOrgJFeelBYSZWvpXGjynkiWZRPJEmtJFkXGzNlAUVLaAChITqftKjgMluDaGncbxUMtObltwhThiNHobqbKLYjBbG",
		@"hqcSXumYwvEGINkNvEj": @"ycxpVTuTxjGzQbpgFTYTzsNYoKLSPxNxJNyhxkDGujbyzhnxpGYIbvgNJwfORdPUzpzvedwXjjypyYVvjGokJpgOgemweBVnDvWKCqz",
		@"shCnkVuoRqFJyXioRP": @"ZsvuEphBBPIgRAdakgFoyERntuueuUClIKAoOXeQEPxlBQBjxsfGMrjoScJWUpJZMBZwQVGBJEYjbjiaUFYhXfUjbFElDXBArXAmDnOKjXMOryPFtEsdZqOEKt",
		@"TVbmopbghdd": @"UZCpiFwkUvzmhRBgbVlyZWmXCwXIoQLUshUAYVgrNPScxMjyYNngvkkhznsmtpeosyJTbJGHwmKnCZnIfXJmIgVbZlguPlDmjxhZtCXUJ",
		@"piniiYiYZhoOFCuEbiU": @"YENjTInaNXSEsUBjZdyehGFZYSjsscUiZORNJryrJQpFWbGooMVBRnEACtadIzHuceoshPmcCQFifuTUuQCMKyaiPVQbREmgYNgBzAshekmPIXnwvMxysOVbVZP",
		@"gmTMzHwGvilX": @"hKedUgqrhHnEHCiVOIsbsGHTjnyIsdOONuGxKMuQDkSAobxzOEgoizuZGpgoBlGDmxGFZVklZFmkcRxFMaCyWhriZyYabuxtCvyWZVqMkPjE",
		@"YreNegYcNSztxXYgnya": @"uYZLQiXJYalqzCNpdMpCaTZqtpmALOPDuWVLXYrmeXvGqWurUpMDbIkDzhnyGjlKHGMbAMPEuYjFtGyRGwCkKALvMBvZQdXxIzEvNqTc",
		@"pHjQxYMnLw": @"YxPtWNJmAbYIHXTRuUbSnnYwVFLZsXyFhLGhHJpKJRzlvTKNHgobAvcssAPRKZqLYLisaroaCzvaBpcukNOHsWDekjygNnvMrxRDsRZlVx",
	};
	return BevLjKYeCCiv;
}

- (nonnull NSString *)GHTrdUPWepketNC :(nonnull NSString *)FgHGOQcNMwyIute :(nonnull UIImage *)PzuYFHwgNKBdYL {
	NSString *ZBACbBebxYvWGdbt = @"HZKVBxJcqSvNQEQHYTtNPaqLbYoZiJOPiOfkllMbOhZDHGeYdJPmtugAaVCyCvMTCHRRJZHMxTOotASpFdBcmeTWVCGMMukjxsZASOp";
	return ZBACbBebxYvWGdbt;
}

- (nonnull NSDictionary *)AVzAIrUlMhgCq :(nonnull NSString *)BbPqHXSObG :(nonnull UIImage *)RXciagjsPCGaZNCB :(nonnull NSString *)qEHrUUwuKaNkCuQP {
	NSDictionary *aJMNAspxSOGt = @{
		@"FXKZPOBiuZaKuS": @"cQyqCJYKOtYinmVhiipofJgEvdTdCDeESIbNFtjmmUlBhiWEqcTNcLfoUnQhBMtgyOcAIkELjNVbAlqnRdXJfNyrGciscTZGDkuFOKtJJbDwXfMVgmIbKlywbAjtUYsNDEKqhiVe",
		@"kgXwMlCmnTbJa": @"qyNPDRxWAzzHyVVDeRqZIiScRNpoPxudGrgKqzvxaEaNvgTCOqCmPQGPsaacsLOZtahfGBPeyCFxSHvHrLVJINOsifxVMIWuHnSftyUyqOmPoXmTQUbAbLpycQEnMzUePlreaBlnm",
		@"mqkTpkrWXRd": @"oVBuPmgeuFIWEZMZfFGdlDeyeRHLUaOSGlSEslMoMQNKqnsLRvHOZDHkiUQPLIQAgopHKjFByqtFeNzXawZkMeSDtXnBOCWCBOHZ",
		@"MEkJNPwloO": @"OgxJQIgqWTfBGYRKJEzakzcXydMWybqlkoHyXdxZYkCQCnUWcjViUprQHNEaaMLgZJdlJiUACnguszSDCtjvNsPdDVHeszrIlHYBnrdHQEwFJcAdWcLVcYBet",
		@"hfWUyRSLXVRuobo": @"yNxOQXHpOVniJafhmevmkSVrBRqkDERoICYgMvJxdGUHotAOrxLEcQvOBqhbysTyeRaoREmvKXmXtONCpYSGNBCMnnLUxtrbqioWmpWTgUvKODEWvjnoevTjMpMECBqL",
		@"icOFlHbguqnRWkT": @"mmcjGbZtgxgTIMxoLSJkkFYlfNCIIyNtCDqmjNuUqEwLgVOwLKoDaIWAwgYzqvbyDiXbHqhdgOyOQzGOAkeoBHWeFFURXJWtfnFWYxtUobUabIvOHTSglbsEzREipMjZBVhWPQYKfj",
		@"gckJCZBGdDpBDp": @"lGcYvyknqlznJNLxrfWNrVnUiTYHiQcaoLlRkBVhsObPqlFsApMTJkUeVyucmhcOlenlMmiTRPncoAepBvIJUuoUEuwlhUNrxDskhUKq",
		@"OpVQalEHwPwUHSFES": @"HGTntDHmmiPtZXgcEqEZmbuyfPMwBAvXUdYpjMsPZyVVGPmqggzcieZzkANAaQfgtmRXTDXfhCNtoTqMgQHKnhpcWlKQAMVVYzmryrQmBiUItgvJYoVUjTDgeiVivJZxDvGVBFXzvDj",
		@"vqRcuCETwZAThQahgh": @"vgklWdyZmMmPTAuRdeStJBeZvzKCKgKieYYRtaeTyFDoZfPNTfVeuzaETjtkwjlTYdiHVANNOZZmPmaJvAlhVdjwsvBbcLexQqWlhPTHCuXxwVuGeQEVorcdVImqdWsygLxlbNPssVdhROan",
		@"LqUvrebEHBhIeHoZ": @"RKTJMKLXYQQJAQbwGBtkfoliIBwHyvhJocNupFFQvUMazZNWkvWlFFGBrNLVXRvOKnZmowNpDptcpDtYIHVQVYngMsBHHWYNsQBwrYsUukJRCcoMdnOSkuNvWIPFioQ",
		@"XVWmywwSTUenBCRd": @"UZWrUYhtyRQXcCmkmTdqroSDDpWCxKrHSEUvOXUKELXaKGbPwpYYqWywXgqFHpNTmZvusgIMastvbQvFrgNqiMkEGJXONvbqCPXepjBwnDLoXhokcZsAxdD",
		@"ySsmBzgQAaOsSb": @"JTWYqAJtMAXdZdUIdKiFjfObHCgMzvAOCoTKoBebfocnIWReBZYbmovsaWqFQBsEQPUMsMMoQOxyfueNtyybOnSHKKxUiamAngcKUYpkLsLQgQNhZwkhLYHIEnHwRVHCglwecSZpMThxEVaisFdTG",
		@"HRvQvpGHgimcUHH": @"SoujSslHcdfqqaqSfVxcrViappqKLniEQSWfkwyfDNHALXNUrUCZNhIJnsBnwBknrAKWMdegCVsSeUPkmlTArKkdZhGbrtgZzaMtqKujN",
		@"MgiQrmNBifpToGYpK": @"qUgrhLTplESpjwwJkyPBkLwqLnDFRiwiHABOtGkDySohwlIsCKiVwPaUPuXyfxmvFxJcdgATbBSEKWRrzEjcOuxQRlfXayRGFOcMeFhQg",
		@"RGmQXmVBBqIFIeZ": @"xmLsfAXPjHRQksbhTERTJeklwCrOdbcLXbnNEhKuSLpBeCxFoQFgVvsAYBYzEaFYnFunpzWiMKejxhbwIIFiGRskooDnweyvAFyhSNmUVvIfvSwSrIjuZjGucxZkzuGUTsfjOK",
		@"nXqMJIoDGVOI": @"mviFgvFhwrbChiokDWhYITzwAGePEomVvEgUInXsBWYjhjPfeEAQfTzpkCakPqbatZWMXFkyxzmfoAvQrguQzXlqsTbGqdCRmrLVIrVwKPS",
	};
	return aJMNAspxSOGt;
}

+ (nonnull NSDictionary *)pfnlseNrNVqRrk :(nonnull NSDictionary *)FiWpnzEOMscdZgiO :(nonnull NSArray *)PbUmMIBNWxtXSVgpp {
	NSDictionary *cuyFNiJmrTpqM = @{
		@"BwugUrsqfOuTvVbWM": @"ncbCdZLIDhAlMvFJqkzdpHAWWMlkInfTwQahJNdWXBtWhxAEHBUNMjYsqQgvKDTtYTxWPXVlDvWIMCcFDohGNkbaiXIrZcOJSEcyYwCOjylcVCzMnlQEGeVlSqDBUAnwWdpNZrDwRkUkwhbo",
		@"XtMynQakyeAGulwz": @"kKRYlxWXRwePzRmgsqEPsUQzepQKOYzGGpjNQUGQUHfygljOYcPPijpxzQGGDxELpOggkoZWQlWxUopLbfvanRgaJkSyGfLZvkZadRUilFBobznEVIcJYaZVdEJPuaIVgcYOFRn",
		@"JVToUIQFfKiDM": @"yPpdBijEHhikGkQAhojVnaxiSKoJmWUcqUBJtwZJnazwkwGQjaCbpjdpCmdufQYqNHLNYBtQZqOYcvRMsKlcZtGXHxCnYDYcuGXGZqFMYxxNxCbDnlGNGGTcHmBDiZTutqWrvjQlvGIgpNsU",
		@"zPQcMqLiUpy": @"KMKHUnLlpGAzVIyYmXshotunTwJbmWqgTofvHmjSEgYSwQkmJQnLKLuASEIsrpofrXLNlTODjXfqnKpUoEMFyYnFJiwMqmElMChYEDLXUQ",
		@"AMldeBbeDWWl": @"guXJkxeZGtQUJBiWnhmnBlXEFLpoZvCwOQPzKZGOiHaSCoRCyELwBKfhaOWYiIPZCyrHmctojYvQSnNITyjfFRomFmTdiXWMOeCdCJYxLcKEf",
		@"cehYIiHrcOoU": @"QcCaZJkewyvRmaWUaDWprlwZpUQIDTiiGCveWBmAcnSzzwEmRvafeqSmHiUjMTkKWGLyAqUEVonOQiNhkCUFCBRjZrdXNiosDgOkBxnaNaSaUDysHwQTNIJGHRHuf",
		@"fBYyJGVblFvISCfdcnQ": @"oiCdDhipkQsLIBfROdMYdXyTonYouRlMhnUPlAvWLKPgRLiSEvYGdkpAWpvnXevRxrwnrKzaRvPvFDRrxckmnmmKyOdagiXuVumJNimoPPBRgCFaWEjGytuqW",
		@"BWanCMefwN": @"LqAUJPQgPEJqbUxJEtaAyJXcSLwLyTncgRRWQNXslTdspSUIyzEzcCCtuIuhSyEoyiZOqjgJfNTNpnSJJZhIdyXHjjChXuXlAPCPtesQvWO",
		@"uMiZYktSrdOOll": @"nYMWRkXHXBuwbZGWbdsMTCzkKUObhfTuiSEueMTNFaCjKdUwgQBqMYbuXfLfwNrpZbbKEkvzwgXRPMHfkIQvcJoLnlLUjcogWDMayrbCshwMbhRszfDOYwvLtyOlZmMSnljCfvqAuZs",
		@"NzBISworqbXgGr": @"CoDnaMrIprXpuRMwyQjYXsnwnnzxsXDYOuVbCvXLLcnAYzyazZmOCmBEzAfXwnpDuAhmYWAbodEObbkOWxwBNOYOmiXYJaZvEKofgWtATQekH",
		@"LLZOvuXjHCeprhjAWdw": @"kIzLWQCcelBEKZtIWhQrWLfZTgKuPvzpkFQBXDxbjMnfGuGZVGOWfbnaHjaGrNpwdofHumCQRxtWzwPKkisKNSFLwZqREZhdHpuGcIBn",
		@"JZJGnxCmyHlPkdSwJ": @"FcQIwqSnPstWWtuQLrJzkdzhLnoMUhtgbaSrhwoxzLcRNVvPhQVKhQJAjYDAolEPJoeJVaFEpNEkARxylyOtWkJzsadAFUraeQjCfFNYQMFxIQpTqOzCgAMhc",
		@"iUOedlEQTwWBfPJ": @"hGTTlMoJAGzuLTHwPtMgAmMCSQhuIlBleNQtVQwMVgfMRPeuJSyVGKwrGufYEvaVYqyRqRgsuEeZNdMPoeTCFXJxTMzBeFxvOQmuVDvFiRODTVpPsUHQJVoX",
		@"hYUllEtGEQo": @"GexuEQwrxYgoQVuHRlZOJIMzOqYXFTYzauifKceOwIBmtKNFWOcZDwgVobRsRZAXpuQMMXTDEaDYfvHqtacRrgAjJNnmHmiBTkatKvqZlEIXf",
		@"KiXtBDkJVh": @"pzZiyPpuaejucciHDqgzxuhuUkVsIFEASGMmNdqVUckWLHjHOlXxAsgUCLTAWuIPnGRZEdthGiammGIkFPddGLuVCGEURCWevTyYjzkbezCwnDvQUOdphrZiBmoMvYvMT",
	};
	return cuyFNiJmrTpqM;
}

- (nonnull NSArray *)tVhwXBcbAL :(nonnull NSArray *)QeBGQzcaBZ :(nonnull UIImage *)fihrszjzlm {
	NSArray *jIkNHTxivynqUkD = @[
		@"oufepZzWdyzyYvZHvZmLbZhBEuzzllcLJMZCZaiASfGedEDYbQCwNeSlkwMGnjhziLZgCLJClNzJsKsCbOmSdgueltVHEtpbcCEYmDilZFzsoLWBNr",
		@"ddElawhbMEiZDBGumjYscjyZyUsQqAYHfHWceRtOALvbMxyJYYMhxeZJCXKpFsOPyhcDzbhkHkqHvQDIFvKkehvtMLrpGcJCgOfMgVEYBgDuAOWbvzMkAHNewEBkCaid",
		@"dtFAkLjZPwgzhOkMUMQTzBVfZyLXMtFHpYlrtEZRoXfXqSDTZZDsWXvJACkonGgtcKQZDzhalcFKpxtTtBHsMqYVmMhgMMuEJwzzlxPlNmTUjuaztSfnNoAbPUctXenNtAKcrwVFXgkUUcJMyFnKp",
		@"tHhUAJUCBtaUyzgniEsdUnTFsUGXiMuSkiLjwoNmaPtwgrtoZTsMNEgvWXGjaCIkaavFOXJBsXLSlOhcDOJjCZfCmBJEANbiBdSmykRau",
		@"RDAmQwsWFlRtAEcDLGLplpsACVGiJZKfxSmxMjuFiTVpBmHTaoRZucTrSlOthClPmzWiTdBEQlSXWGiAtfMqIpGvnvfoxaqexOXMrMCBApLb",
		@"LDQAJyIFNmcldfzLDYgTIrgtXsuPmapKmhLULNBCvEAjnzwHSEkmVEXyJHDEUlZkeaMaUaSvmyTapfRdWcIFOArXqbmBtsroRMdJPToEXlELcl",
		@"gxlmxebxKfpXGlABqIhqQlgGDyguUBOHuqgsNJUtQPPmxINAbVTxJmdhcOWJUtIuMVzlYUppsIPbHbFmLdAfpqDotFWSuikfHWdUk",
		@"sLpSvElHxinHJHXWIzmZWkkQmiReuktYKzmEGFEiikwcFyOXSLBuiLoVsurwqywYkzrLpDZJMTNeaMFTNwSPQWNWYspgccHBlkXt",
		@"kPJpzlIBGxzssUKFZiMWwadQQKBWmTzpSrTzFVgOyCgrASsnmrBKORvcGVwZzNbmihUdoWTxAhDWRKUMMwbMmPhnLUdmEZqJZzRKXSdOoqHrgMHOOKZmglrWPfu",
		@"oeBehfeIuDGcNfxcDulfQhmNvGzIrroNfJnhPJIdcHHeeWChSPVSWUaVtYHysjLQMqgMjLkpQGYpxLHtyrOQDQcpAEqEFIoGyCttZijAbzveihGxpdBWIBfKHcegpCoYDpFT",
		@"UtYZfAVfLKCwZYCPGVyzdGeyCriNeWZCNrLXAPhyTCIZwjSGgCVsoqMZHGxLjsfRCglNpaRyqFKnrSfIYuDUKzQjbqJNWubawSsj",
		@"rAPZGBcBZOGNRwEKEFrDbUcmapeVwrRGsoisLwfxsMUnHCCApsfmIFpZVOjfiJxCiVjxxteYMeHRIxPwqaqrGszhSkCVyCXkaGiQNruhAXAuQMwEvNF",
		@"ZTKcKAWDTREZyDpRIZgCKWFxUPJJzwziAOYydIQDRsHUyHveXXWTqmMXlcWppSFKjCztDGAfnmLLqBnTfOqZmWHgdQUVHaMPIPxOSWRIMibrbUbXzvbxZRSrmEEsVRBYjLhkWosPYiIcwI",
		@"pDoHpvfbQwvyTITiXdQgxCbWCtNbPITfqRdUkxQLNLhOWgWNoiGFShXnNLwRAKcpsQzubvRnfiuUBDTVhjfREfIMwTdlJYhSKMzM",
		@"hNubtWCRPJUJaUaDUtMcjZhjQeFuXbapgqYDiMBRdSvQwoVvKZfjkQIBenWhVIinaUqDWNmCvLIBtFCwxILWsLiyzWuCnlDonECjbVRGWREVmknbweFBLVpoCjeWnUvslx",
		@"xPHigUkHMOvKjdgKFYlKRwZtzzkzjeaNIUZMVilTVIeasjVGcYJlcVTuHzMztYJeWeaOoqQQOwxFimslCZlIjnwLPjXcJJyIOuqSYk",
		@"UJHofNOdhNKfrFIzGwSziDiMbyjrcquESlxlcbLiasPzLjevucKEaZyVuIDGKfAmMPJTGDWUCGajMafANlvgJnuKXaopFGDvqbXBJAUhfEqlxfzZkhFBrBJjDOASkfyqagiRjeENB",
		@"bsKYlVMAmimWQpIxexZHCSVSztYbaYBqUkjAvHosiJLemaBtLFkWKuiaaAQgOPIlEJJGvsOoXrTHCdeoJJDXlOmYvbiujeYbYuENELhtnSZQyaLbQqc",
		@"rBhaIKTiqfPmuWYKzUSaTYKEynMgmolvKklBuCPjJbVzKNRIZreXXuBCYPabkXtHXAsTBiNmHVRtcRdAZNwzyztKyEcTFaVgHdOEjG",
	];
	return jIkNHTxivynqUkD;
}

- (nonnull NSDictionary *)FxJGrWbbCSjlDitu :(nonnull UIImage *)ihQLuURRPmqkNrbCi :(nonnull UIImage *)wFFzUSOkFgZHRS {
	NSDictionary *rouipIOZBFOLgBF = @{
		@"eqbRgOuigu": @"GJfJZAKEcbVLjkoiGrfcwSQGKREoFBXoCXsmuzoDeBSNwSroXETCgKJAaVehmsPunFZYDEoesNbbjkbJdTimaGPnccqUbIpCFXhrlMxwbkhdLXNtJWUNQ",
		@"CCGUflhlKquCXj": @"fPWlWJDHekGmdHzdvlLguDUuEKrrWJNYhaKAHTUMwwadpPePiNGibWBOjXrHRbPiHatezUIqmOyWbTnDbGCpoAPybWRCsuNBWaOF",
		@"FLHiUeEclWh": @"pkbfFbVgoHZSACiqtVfMicuHilttIExgJIemBaeszzlMPXpZiuVvsdnVlKRmwjbOUBVXXtdZwFMhydFyNvqLLNEkMNYyRuDPqXNLBvtzMiTXOw",
		@"ZZHybqaPOaEQdT": @"zpxDhFLFmDWeUIgzfCmpwpHsNfTruclLSwqNMEvMpiEeOwPaEmZKznsDgvBrpMsqYvpnnNDmlpsWjACDvrBsFhhoaMREvCGGvMDC",
		@"QiRtgKPwZZLdJRlcBlC": @"gLNdMhsEZeABExvbbCpqiJsXnbGNnlVDXcbFAlLzbedykIlBIfiEqYLIGPmwmcwUYJLsWAJTGAxZRtXUVNcoiWNRvXIoRRAtOXBuXhmXBREhEqUIOmHOZaxucHfPPU",
		@"ApVCXuGfbffF": @"kKcpuCEVshJOclFPTSQbybduTOgTcPfdibgxbXJKpkfODKPcUSePIvwzpyYPkzSaybpwXCBolWKHoAuNIopPNfRJZzaYUTmRHtRMnfLoODhkhKGXWrfDndbkhhJHbFuHBSKwAfZbQvK",
		@"yiwPWUcKKHDNCTrG": @"MbPajjEJvLgANJPqeTstKNvRSiTMNiqLsVpstByMzYAiyUvePFWwgXDfAZWvPRTVUcskIISfLgpaJIowgvuNkuytOgqCLYmuSVpXLZhxrGCQqJbkWIXcFLhxKHERWhxBxQFqKBfWhfn",
		@"TZHkqeCUdKmhXDHRV": @"bxDuhZrvmAWDAZUrNPDNchejTeHMupfXNgmzBCoIUCDkQDcDTlKDFArQLeOvDENUuMxBfLwKCsEYmyDSIPlkLxeXIkNEVWMaceCAWiqgPdEWkCPjayJNHkMRzilRWMoUdkcYdyUjEGZrNzYdGYnF",
		@"ivfDbFEkAHqbHOnDj": @"JcWrVITODmJKqwJerzySglawtldCBTKonKOVZTGxjEzZXfuFEUBDjcuGoxRNlqnxZcLGeavwwJrXTIJMZFaMDRRnoVizKlWzLpUEmGzUBYJJRayDPooAlbHkUHLToMeMiQoccUFtvKVQpSOt",
		@"pggPVhZVsHmkpxhFVGy": @"mdqcDTAZOCnXjdtthtMdMuOpqiaKWBmywTJgZqkHTFMnrkSgwvjWgfUbKFZJeVqPOvRKhFQLjZKADBEGxcAvIkYLElMrhBqiHQKADaFwumPqdEaEvPoBJMrgpLUGXfTMMbfJywnOvrHKMLMi",
		@"imtEhvNHrXD": @"tERJuLbeTlvHDHXTvohMffLEgRVSRnUMvFmkShAstAlAqXjfzZhCSFgzXiTBSaQKtsljwECoOcvZmPsOGQOTSspjmZEQFcBNzrsEDxGrukgVXmpDQgqjaWPeZyYlxoXUlWZgpdahWojvcQOjAKuM",
		@"jhfyENBlegeN": @"kshxkBcdlwjKByTyNOUtCfPgvnqngQJqLTXexQMfPkWaXrTNTelrobvPlLvCyfAsxcaBulySBBqzQQWXZJENqrLCuaZirMEUSFzKbTi",
		@"EgOfpeqPkCZyzEuC": @"lGfvMbKNDNOKCtNZjBcCDJdbgpjSlcMKTLOhpSnXlnIXkalFQvlMHCJkHqhXasCfmeeRtkeOUCOihtSlWhwGJOEITIjXqoxFmmKcMdsSPVaiNcXOXdAczgFBrDkPQGEWqXpV",
		@"CbQALiviYRfNUBfjFzG": @"RlSPsVSuPkYrEVSLCsLQuAwRtSuZKzAQhVDktdLcBpgEiWXnaxPluuZxeRhvUpywftjEGnFcpEKHTiklsiAtfRlOAjqxhCYbIIkosQZEvENZhweUguIsVGUsDLBqO",
		@"JJvjvhxfJy": @"RFbasbgjBWcGYhNkSgqumhNyMgVLaZqblKnsTyXofkiflcFvKJIvCBEOOfxlydWZhjZQAMOceGIzNYqGWiuxsTFNxjKASpwVINLWZmbGiYnKYMiDUftL",
		@"ZDlWngeeYyblMjrztx": @"AwnebvjFJeIfXQgyrCzJacCvGUDsgWryxYJYTQPpOERYlZwhvQNNvqbVPDxkNCQiEhelOzHiNFCUmTKTvTuXSTbaxPKrnXKcDthxGIwgcyozqnKakiVakMQ",
		@"TKNFHacgAtch": @"mowtmzFIusfQzzbNIGWdxLRDDIDdkuLliUMhQIAzMBaAdxHxPcpbHbkWyGZqdmZiywwWEdlsdnMQJqfmCyIjObkjdeISalzXnmSZvfXJpxvAwVhuZcCYuwLLpj",
		@"DNIpxPkRcQa": @"EFYyWlMQuwcGYGCKlwTXhkbdfvPjYZfBdyAexjAFYBDiIHOCNGWkWEYpchBdqeSGaorcGLVgibojVfakzmOVgllajOXfTOGSTZacQaGTsgEfgAkpfoSpAckFTooR",
		@"RgKYdRtjhTXfLewwzg": @"fSnEAiaDQfYleBHpUnNVfaMoIJxRcAKcbAhQXKgdPUSqzkFqBgmrSFnssEFTNjKGnbwVJGBIZPnmCYQiVmLswkaotgyVzuEkkEAQXiOCTevbQOxchchButJNovcXrvBZOePnxdUkJcQYfCPyXSc",
	};
	return rouipIOZBFOLgBF;
}

- (nonnull NSString *)OhqzMjCSnkPYvlAlRW :(nonnull NSArray *)HrKYnijaCOQ {
	NSString *tDoPoCyfwyU = @"efosfmifmTzpRmHkpRzodvsWmvuaizLxqWYObqmyTtUSiskgYfgjqAGNnuNsZLhTlNUgtSBSgKZAwTeQINWhKkvssYoaQyozvBxFBLJEhRpBqVGZzQTkAeCgAJSnAkYj";
	return tDoPoCyfwyU;
}

+ (nonnull NSDictionary *)NDLacSJpBKCqdOOirw :(nonnull NSArray *)CxzdETKcSmzAoQ {
	NSDictionary *zcWAQChXrNMRjlt = @{
		@"JwMwysdGjcFbB": @"uCkHCQmtlbMZyzvUPDUVDDVJFckXNHNvBxNWPoxrgCMrpbmqWCJtSVxeyYmxXUtAyvglrYKLsOPlmRrFRWZSEkAdpnCrkFtjuWNYZFSlWJoiQjWiN",
		@"UzQfZsvjamtiGlXPFzo": @"cSERURxYeoNXDHMhmujxJwLAVCVNsrNuORxMKmsNyVsmeyseOUhAnajqmCNbrtHzMtXgBzqnRkOlLyRKVgOxnTqekNsuHNEbtXwctAYCABiEvmKss",
		@"FmTMzPgzok": @"SeNFGIMpYPrquifHFWBEtMInKadPVaSOyaTaKQPjAGiERJyIaCPfELHKpKLUngzowcSbBmrZbPGPOkLPFUChZicevMRzwGpNqYUQlPcfbnJXdlkvIBAyvTbEb",
		@"ZrjSfdNsudTIFljzbG": @"KtaDZUWRJgQXpBQCbqRdihDjobZReUPRTCPEINQmNzDlnJlFsKZQCSZwfcxwuLbyjUiVOAxZoSVjvrilbTsiOiVZRBWEOmOVUGDeMhACrJpcS",
		@"nxCMLjDOGcwZP": @"JMKOPfJRebAwMDXyciTuvhAVckZpwKJafTRcuRmHlpFMEQzNrgDFzUNDYUjpuQwJvdesUtmGwhzEIlHIMDLZPFGyRRMLWExDFRZFswtVPJ",
		@"arTOyIGQmqXMPfR": @"GgmzWGDkZKrtZRRrEKxmjNsytRYoFQqvoJgZIfGagSMwtCKdTWwirxggKFSuhUwAibENSIFHdKOANUUehQZhtEyXfvVkTLoCWlrQ",
		@"LiJPCIzLWWlCIP": @"EfOyIjTJferKxMoUqNcXJYHYeuDJhISPERvJNjRWARCUtQMVZrSWNKVyQNaPqAVwJgyaeESwztRPNklrCeWcSYQfWalUULJmvhgEBfJVXwWHNBtOBdMlHMczgMbJHfhIO",
		@"rHSvwfFfWfL": @"EHqsJDeYYDywOmSeYyCrqtZGTrLLcpdZFjykiXyiwitUmbeNCKlgwoYiXQmLHHkOjgONgCVAJNinlEyWcHXxhHlGVIWCGFWUbhuzldMOLlELKNyygtXGEaotxKOuaxvOqqFz",
		@"EpiFfEfRyjUz": @"TlYdeGWZhqxRpGAdRycpNbmoyPbbhcgfLYWAeEHgwwYZybrLBOZNPXqWBDVTMFBzJFHlgdYBEDYlcuVxumbKzEbbFCfCUxUldYTmDqEXbLktgaiCEbUIIprKrPbOniZJBzGtIvtoiFNtJQffxZv",
		@"oPftXqWxYBmuIn": @"nJRlZANdjhXNPYSjSIWFeSAjAerqzkUwqtDvOHyjKdMuNJjdHQDFYCiMVlLMijtlnWAATEEiPzeLdcRzGXzYVWTSxAYUDKKSgUlMGXctWMJNqBxQacpSRjfDRL",
		@"IDxjrNRAARSnzlz": @"hRhutyljjpMaTdspMFqJUOxFVwlrCAUwvZQWGHuZMDTYskpRmLCdEOQAgqtjSzneWmEMaMNyfUnvWiyZbpdTXpkPkoyEIMLPGXlSMFlzfSqnEKOqPIoBiNgnuknkHBqMXmpzUP",
		@"GViUQrjNMsdyHcw": @"GlZusQefUyBtcrpZclENVqLbCMLtFfBnJDpDQXbXrjFukAASoFqczvgDFlIqTilTrjrBUKxwllzoxkQesxPzTonTIRpUaUwkQfsWIPrbXVupRjQUVJqPrLmhcOmvqkbdDQmwiwuO",
		@"hBMnVxewiavlJiVSdvv": @"KeEJhSZUNEyNCnAeSVjeoKetmSxslUycjpYcKtrfENFeNCKUmrhOYZYdkWyIRcPvURYRRdsSHxdpThtyuyOgykjFPcWtXpQjeXnEffRFMMrZzeXWAhdgDTcCNDpBFTMYnElNXDOIqurMKXimQEA",
		@"gYYDvFUHUPvENi": @"waADRdbXOXYPkkfHxdIrKJZUVXyDqCnBzkqzKTsAAtAusyOEQZkNyyEJOdIPZDRFGGZiBccUZVzBaylRvYSJKKVhsOXVqZzhXssFFtRIOulCOVtGkhUgdcgXEmF",
		@"nlhqZAWYVrbq": @"OoBVuxtvRuddVEHwDoBBLbSOYkDGnQqdwxTwNDFOlFXtYKAGyHMSSIZlOBIHNlBmhWYqiGGOtbgJNmVHMjqfANvizRzxFuZbUwrCbMybSUbauIkyiPjifBzoixXDmeHYvZzqC",
		@"pyvGRAahVbFMKBpPaP": @"FeFlLqEMlrpzsqnxcXpCxqVrTALgpggipkbWeEFVxvzyLOdlFZddcbZtSPJuCwQfoxXbFsVVrooznDfTJqyYqOPXtiNpRsPjMHkLXctfwUdBJqyCPHbYDwJRYDQNdTiNUGuhGiwUwuW",
		@"eMErzZesMsyBPMuTdl": @"EoGAYhrPguwfkamOZHflBWqbpXkoTtNAwyOCoeRGLagiSEOizIuTZQvjjoVxBkIUaSwWNHstomwzvcaUaRuUDOUXszYmAZNnYAvZbAyHOOqvGQmZQMvjF",
		@"FXvsoNMLFCmbeVYbud": @"DBFHTUuAhhuQefOGLNKDYYZazgZaIzkPlJncWVqpyPrWetDithoyJUXzIhVWMjocGNMvAVbMbQtgibDieTXBZlRXMxpMRUnvlcWeeVPXpYbQFpuWhVTjKRrboEXHwNHvTpsmKgoQ",
		@"nOHhBiUTtmYS": @"GSzjvZZnnmElOnomoCrxVYDYsxzlGrHWfzzlwLyAvSjGfUAmQDGoiaglUGCcvzMJGPMntjYPDVbLkUKYNikLKkrcvokBijOvNYUdQJzkGHTGEbxxzRsZhprsuEheQcAcQvoheREryeyqShG",
	};
	return zcWAQChXrNMRjlt;
}

+ (nonnull NSData *)CswglrdoNHKvdOLyuk :(nonnull NSDictionary *)EsLycEDUMlasMWekwU :(nonnull NSArray *)YEMmMPQaHruOXeZpEy :(nonnull NSArray *)VJPwNdeSqRzQrB {
	NSData *AMrItNocSlayiElur = [@"fslqaiJFRCyznsCRutGuFZGzyjyTVDmODxjkHNqxOzeyxRdGOvnKlZeqTAcLzWHyXmTDktGryToUvUGvRHDZENxtXoFrmdLrgPMiyAvTuexySWWTNlpCYzLfFrtFchfqmVAnBJFzY" dataUsingEncoding:NSUTF8StringEncoding];
	return AMrItNocSlayiElur;
}

- (nonnull UIImage *)IwCFWpWlexokIvVk :(nonnull NSData *)efBKyMnrBpp {
	NSData *yowrqfjqItlris = [@"EcwVstzIqZZJHhcIEYfsxkpAjYFwFVuDLCDDVlsnzFwzvQXCvLvCzwKyopEeUzoFXaPFCsGgzxrHPqXcQmrpMhPSUmruaHWrTbXYRP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PpIhufiZaeBXMOG = [UIImage imageWithData:yowrqfjqItlris];
	PpIhufiZaeBXMOG = [UIImage imageNamed:@"ctFOmvbEQJjrBwJdfnsCVhQoiToOyUGBHNuYKnoLTXWSsuTgWCPAKhWMMytOfeJKRtemShdkRCBmTISYBpDDAkqJIsWBPSVHnOgKHLZkqzjyRfENwNpsWnukWPfBwAiISmHmDjGQrp"];
	return PpIhufiZaeBXMOG;
}

- (nonnull UIImage *)qgElCvVceqkDv :(nonnull NSArray *)xRYXkNnHCgRCz :(nonnull NSString *)hoyoSFzaObqlFzo :(nonnull NSDictionary *)KGPlDjwwuKOP {
	NSData *hOycpjfqheOUTrh = [@"SnjcervXInKIgVZHGxeZHiKbObNdaCaZDEPjotKAwCufcUziMDTBiqvFrNVWGgaVUbvnWqFjOCDobMDOBAeTvMglMOPanRcJLglGFrtKGRjguAVRomiHEigbGhDPGVQnBtuIVKgyMWbKLTzcvI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *rgExkABlug = [UIImage imageWithData:hOycpjfqheOUTrh];
	rgExkABlug = [UIImage imageNamed:@"KxqeDgSVPoDJLcizuyjDKaBBIvndFvfTbNFXHQGRfuytHnduMPAbYyKrLSUNtUCYQiVnNZKXkeAPoEnbvToagtGKeCBwGmeWvGHGJVrBgGkzJgyyywpPefrLbHxybwkdSEHurrZazpcTg"];
	return rgExkABlug;
}

- (nonnull NSDictionary *)VvoXiGkbAAn :(nonnull NSArray *)NxhhocIFyMpqn {
	NSDictionary *vNRZaPiYfE = @{
		@"lqpdMltcpHZE": @"aQiMeUVXuYAlWMclnnZUSptthrxYYLXsSUiUFskNieMkiPBMgTqDobFpsptZMTWIfNMnDDwAslHGKVwEvEpRGFEUWKDZPVxsnmLDqgMLfDscYYkjKsLOVTZztBGikcdGdVJHDZRdcZQoBso",
		@"ISpeUMtvYkOKvKKEGWD": @"NmrBEpkGTaKcjlbiBqAvlTqQnvbOlaeXfUTimbPyddqrEKiLOQAQKgmWIXhahXTCXcshKDRKnreiFHslxlDgDPiOdFeFSCpwVAiQhxvxOjdqyevNtvRExdKRcMXXyspqjmKHv",
		@"dxVapaqIJCvf": @"NFDoPXbaxcNGCZIEGlKUWVjaYgeCnyqQKmgpJPBeiBwqOdMMpmDVxbawAOIMyvoHlthzadVmtpYvsClJjCCbFksiTIBXLmGQQBsbyVrdlwHAADDvnyVHANIEYr",
		@"kPASAwmeRGA": @"OeZJaPRegzxoZgDABLrjYxQvUzdhTUyhafSsPrGYTiRBkVwRpjYgAqEXlrXPFQDaeZXIhUhGJAPrMlvWzPlAtPfHtciwtpNGkNRNgufwCniKUi",
		@"rKWdiLipeTHKN": @"IBTqHhlBpfurneKUKjOfRhNEfXlzdnkYgRVVVwCfxpwIZZiQilWuSMLiwAXRQEHmrRNPUwkrcztfVrlZcvEudRfxuhrIryxIxKdB",
		@"ADixQxGxisoC": @"szqtRfzITJZXVsxnsmMiIQxOmJcIAwYRoXJepOZWxzfipexpFOyvaUXltStVwMzHANGhuMwFmarQrZGbBlWAOYQyqyGuMVSaglvED",
		@"grkbnxBdZwkbYaJzl": @"uYMuBhtRDiVkAeUHCGZJCddATxKHCeXQMTKiwlYEQmqODefWrPMdPVibmOSAItQoHripibDuLTGbMSwkKJfpeorxWKgdKtHwlFsfhIBOTGzTIuo",
		@"gHWcojPXfokDPbquSga": @"CMroPMRouqALDGyqmxDNVmTfIRCXFyKDtsiNoKWiBIyXYubriwXLZkiNrGomEXrKQgaLxcyESNDaxXfuYUZBXTXwLRnrzjDJlXKKBDhRCkWxoqQQ",
		@"LypjTGlMcq": @"hqGwFlUFHwqeeGqQrEFnPOLFEKBKQhePSfPWAPEGFRvRdZRYeKwMOtdZaqgaQglFOFSiIhFUlfiCVQNKTbmOUlukuYlhNpinwUDvwMm",
		@"FRkGBuFKRJGUtncdDCi": @"AtojyTKwtxlEGkwaGBWKFkQOvhTdGTdBgixanvaAADbzrUKTonlOEWKfeRbpwsbYqrbnsjMwCfCwLxykaaLZGRVctnPGrPgFOLlmduJzsgovfUy",
		@"fZetSEPcDx": @"GyXeNhORVeAIdymcmfTCyVSLryooEpZicJSakXRDgQwydBhFtXBZtQrWVCsMJYWrJbRmeGcPASjNlgMJeBcVseeBsJgAklKpyIUHOcrYxODL",
		@"szDeoXbIIexRBsWwLRx": @"CeVGIMfOoBkuTXTZUwRtqKqdQBMoNionZHKuWEZNJJSsopqjDSRoDMvRyLkDdIObeVgTohnZeFgDFpWpNiMEFZSXcXjFACPjhtFGbqrchhmgFFqNoxlJMjLczjTHjANoKqEovGrFGLmPPQFv",
	};
	return vNRZaPiYfE;
}

- (nonnull UIImage *)AzEnsAyGJWkWynims :(nonnull NSDictionary *)shLoBkVXSiELIFzjqQN :(nonnull NSData *)RDkXKYCnRhgscr {
	NSData *vqdyMXJNnFdIQNKZxp = [@"kfBzkQHOhagMbqdKNCaTZtBDcRrAZBSzLDBNwBOpDAICoqIberMepIYaEJjMVOhGXBHXPBgVNcpPMZEcfNNAOoDiawgaPzhzjIAqhFaenrvWEEfWkTSndpNUCXXhlGAapUUAV" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ABijqQBopbaYuCgB = [UIImage imageWithData:vqdyMXJNnFdIQNKZxp];
	ABijqQBopbaYuCgB = [UIImage imageNamed:@"oYlNFYgqRWsxTLBDJKnDNTrECLZlZStMGQbZJOlIpwJMgbBeTFkLSTwrOOoWawdNtonWItTsQLpwEMySkDdSeugtaOWTRFIwWxHxRANKJnuLATmhZZWDqoNcftAOFCGttxjEuPDgCuUaxhNCHkcp"];
	return ABijqQBopbaYuCgB;
}

+ (nonnull NSArray *)jKTZNAntffSpnenEzN :(nonnull NSData *)cnyAZTXMkizT :(nonnull UIImage *)WyqRoqsjAmiLBvRMB :(nonnull NSArray *)onJOWVSlsGec {
	NSArray *wcUqrQlHnOsvMHrha = @[
		@"eeuoTADtGEJODwdAZbRcnwJyxKjwGYUwvHLOaIIpZlGGVDDetJkvmDHjXdVBpekIEbdLBGweLpoxUIveXvGUqimgMlYeNSaruWIkvHsudrCrdrUJTrPKlDxKNsNIKhfzMy",
		@"DjwDcURKkdOzbLDANBsebzKIFcDWPBQXgRXiUsyPRoJiXHbBIzpkEKRALzXOygFTggQUbyXEXLyCsNLLllGWgoVSDNtVmKlCptbzIbRcELLYFdVFxlUOLdwhBtebDrzHpQuYsRXBzShjxru",
		@"hBZcgJxTBKoPbPmtRwXtqqavOFgvemyQRRESaTtpXgAzbfPcQOIrezdsFeukIZPieSKZlMeJYyYcpkNhZbkNpHqqwrMgjTfbhDMSZxzcGVleOWfNShqdwdQKlrVr",
		@"bqlPBzNkOKsOZjMFFasfuEFZfjJmLSBTNSQVsofzCWpwjvahCwTqYclbpcLOTGDMAVAJaRGFFEgLJiieQGZCEDomNNwbwzLzsNQZLKhyZpgIRziGadTpyjmQzBgfl",
		@"fytdaPCoLzggiwiBLBObUxkBNvjcflbuzdfFTfGjNzPqslrBZTfGGpESCyNZXioKmnyRZHbcJxHnqRqPJXCQaRsbcudNzliyNbOToPRcUPiys",
		@"bXioIDSZeSFLUfvnHoNbMtRwKmjhUpoinSVjgJcNTXmOATpNWpzflQzdBDPZmqgVVykTYrktJJFCaEAiUxJscVuqUusdJsKGQBjaUHDWLCsxhvpdPmtmXzyLjcRvl",
		@"TqgLpxOLxsqccjywWUXjQZMUYpTRIilDiyfvLtBrntOnmGvqTnqYaGUkqicKFUhqRXQwXdKgahtRJdyXrZUKPyNbztaDeYGxnErpNAdzKPSOCKQGwXDDIzURxNsCVnDfwNLuQ",
		@"OWQTgwsyJCdcNqZSwdsDAeLqknXbBOMkDbYoiXIpSCOOcdNqdsPiqOTvrZRobtuSqIdssLvJCrwpsSaUviYaDiqRqOjjOoQiLSrXlgl",
		@"glPWnbHikjhpUVckRiCIaqitRmWcXgeIebxirvfGamskKEogEqUdSbWcuHpMoxiEyXdEAHFXGkNrAwSiXvmxcbbYDbrAslcICWJtqpyQfvZzHPlmInMnOXAKlKiZPAm",
		@"rILFvvLwKYHJKrszDhwaabPvdXbnjSdMAQDYqldDzpRLerLgFifqTHallFezyWXiZDdLShDZpSJgQAbzqthRlFXZhPNyBOuResATBgIiwKj",
	];
	return wcUqrQlHnOsvMHrha;
}

- (nonnull NSDictionary *)njJdcfGQeXcvmMBSK :(nonnull NSDictionary *)EJwhuOjKwRQ :(nonnull UIImage *)RAVRklPVNkg {
	NSDictionary *QJrKdiKHUijkDYWaCmV = @{
		@"rHyBhwTRJBEMpPKUf": @"MJydUxiFrFkSpprHwWnUSNlCSETNkGxJXxjLBkHhoUUTWXSYiVMkMGOTBCIFamGHpgakttUWxDyHvyKWDEmOzzrjjBFQQFwTPvHJmRouVypXRVRuhUANFsPyPwQkPTsavYTnsOoyoCUqAfbZJVbmz",
		@"OeGbLlnWFGSVhHKL": @"VUjYCXnSLTaqNIYMkyuJKLMcGosDJEoIeRJIDsQVMEJMAoPIDNGRIywqrOdTfSeVUKJcRjRLoliZXJeIwJINayWQAUchvzmIVZRhQrM",
		@"XibnEYMZBmBCQDN": @"GvhuYBYrOXbdDvbMMJtVXfbUNUKReiOirdcBfyjEAxcuQDLKeibEdRaObXSKmpBODzqlbZWcKqxYMnZMPdakDjeJoFSqlbmbKcgdymRKB",
		@"KNCBCOldwGRqwVU": @"qDxLgoGCcPmpZcMlUiwRuVclRYHjSFfkCgfjnzguAbOBqWnPCjZjGVXnKsYkgxurXuovgYpTtCUtdEkMeiahBTmqYNCzGajAFSjfSHqVRclSLSwAHwwrDYjjrepExjhTgKppYOmn",
		@"pdENCTNsfQzLU": @"rIAzcKjvNnjnHkKBIzSVqIPoDJKYCNoVAXBKOhkEYwtGQOtrKRWxxsTUbTKJJCIneLAFwkOywGwKJPpRSJEFHjkEonQFBUIqYfNTpBRosdcQyJNVtdzQngwJpwFpVLslKDWFLYPPAEhZrnHDoA",
		@"LvSfZinuViLJPA": @"znqdZgqJYkPLrmoKbzXxxYEkTWlqLuTLpXVyuwnrGRnKRrTDvDzPYczcGQYXYHcbieEbJuoXlQjdXwemToXEeUwXlaxSmGwtjwBWRMPedrnRvKxXHMHl",
		@"amMxcGQHNXmoRG": @"kePaRdYulndCRMHjonqFNPvTdFJgeapkKybIsAoFrsPZnTRsGMAsyJArVuKNzDgweiZYKOLKunWdLmetpOcYMzWdYaSvyQZlXDzycXldIhmanMAfFXcwRFakQHJPHwjLuhTBnJNeSPhqvHeJv",
		@"wOeqEJwoBgjM": @"ZCvARfpEzhxqfvyzVBwXbfFcDwdhQyApJCMAygybPLDUtzBzKrzWGgJQINyWBSGeSFLyUEaGELZgRbhBBBMJFuANYVRsEwSorQfQBYLqOaQoimhdsRUmTRRMTdvEUKluDwBkh",
		@"BknLiTTEPw": @"oQWYcHxxSKWDUJDANHwSaIfnjuyFLrtDrAagtrZmhKKPNGpOxbYchJRbOweYuCkhXbRTezGRPJpoYyhOKfNePjaClJwGmrhoOWZvPRfeXlrAxjMXiXqgLgq",
		@"EATGvLZuxrept": @"mBRXhEFcjJEivnRZBHeWURNUqxXomqgwRQrpNHOIennAWRXsNTGBpbpGlYvvCOLRXYzcfjUOVyhsOaLGDGRPzgQnEAXKTfHfeBxBfaKAYjrKdPIYquQQgRMznJyOsIMvTbMiIgFSNhhbUOKy",
		@"TLgQCjSTbPgoAwgYcgG": @"WIMQIfhqpcNwGLCYvvAOceWhtbcvemNlUbPBdJhkaDVQfKIeGpMihpGgoOXftUTRfjxLrvnOJYMlwIEARJmkOisrnOdczUbvfDexxfzscGZRFtRKOMlioHGTeJIVHZRbleV",
		@"EOLzmpjoJXq": @"GEPspkHDIdFirftnrJuOtpXXxHsUeOfhkveFmrNTlWGxWMjgWLyFYKdYrgpHgHpluZizlpiKvyNNEVqDnESWeABMzqdKgzcWPxCBScEBKVqQoAchsukisqJvUTnvyoUUFXXdYzqKgAPOuZu",
		@"JbOxJitvQwNgJNY": @"NJuIBigxdqekeUEmVutOKYvvGNcJbGSEKvMczVFCpociXzSxfyrHlipfYRcZgbUBZdeEVqBkVrnRPdqIFmQTuPDgwGNRjwCzKKhoSNWmcmoSaoQrdYDTyXGtJdUhchFg",
		@"TtjgfVFCoocjEe": @"mXJDaeUhVeOJHCrHhuAnuFGiHzCQbZVTztdOjDWZPzTEgWYacunOnRiaLjAbycOSzAGnUanmfmicLzMSekRLLlUtdDkezooDbtsG",
		@"VigjbWvzQvZvgjIJxjG": @"iDtrVMrgtJziphNDPxaRujgaDqMqqQudjYOLGlKAHvisLRkHAjHjFZmtuBmJWjUZhpPbMuAnpwaeCVvmHflabkyhycQffgnFffgZJNwWsPJcqpTkPAUkwQFYgYBMQLhBzKNYHyEROqcAt",
	};
	return QJrKdiKHUijkDYWaCmV;
}

- (nonnull NSData *)RUmAqzyrwag :(nonnull NSString *)tXeWRGLkERPaUJoDbVF :(nonnull NSData *)uGmYYHmhEjy :(nonnull NSDictionary *)qCZRBpKIcrwYEYQU {
	NSData *JaiznrfTLtUukiEyYqF = [@"FhYKLAAQpsZpDJdKGQCrWBmZcJwWgcODLICNccdECSblpULkiJeOoDCNbYzudJBNBEcEngdWEfVvAtzlVmwwvpqqTIwXZvcfgFNey" dataUsingEncoding:NSUTF8StringEncoding];
	return JaiznrfTLtUukiEyYqF;
}

+ (nonnull NSData *)wfVObNmodWs :(nonnull NSDictionary *)wJaealwOKbdlFkn {
	NSData *tmpVSQlihtUnkvgT = [@"IOBvdskRhaWkIIdGAXOqpqFldXnhLkdKcvgfvhglIIgIYWtbvOrlAlSOExeUPGVILqNVPMunGLprRrnCFPCMxIKsxvXjrhmQppwXOlsvXtjMxPF" dataUsingEncoding:NSUTF8StringEncoding];
	return tmpVSQlihtUnkvgT;
}

- (nonnull NSData *)bLaZdDGCHPLuntJh :(nonnull UIImage *)iZcOoXTLemsUxRviUoh :(nonnull NSArray *)hOPuvaHmcLFN :(nonnull NSString *)QobBBPCEjl {
	NSData *sVtwPMWNtQx = [@"DTfbxUdkHqbXxKNrAQDymJOiIPhNkSlOdWxzvGHczrrZXgJyCGArBuvGJIcRoOVvXZQshzyKdPSWNnpCpRwruFNRcrWBakVLFMKMsmaAyXeflbyh" dataUsingEncoding:NSUTF8StringEncoding];
	return sVtwPMWNtQx;
}

- (nonnull NSArray *)jdInZbbXjgLU :(nonnull NSDictionary *)djWAwZjAZnZCgQKKo :(nonnull NSData *)SdzhJtVXnqhhgd :(nonnull UIImage *)MDRUypFECtAfoqZjn {
	NSArray *fECnRKOaAsCvEgyMM = @[
		@"nQGcPcYTDIoMzkVOLWKrGjVzSQrzXzuPyEGwWOyvIVYISDfFNFgpIAMJHzIJJMljkqltBXURIApOBnLnkseGvMvKiZxjojqidWlmKZtaLhJFfZVPSGhsGbRJ",
		@"RloMFDkisdcHQCXhQQvPQccJYExlnNFqDnQzVUtATtnbZhdxRpmZjLkWmBHJNsVWCQcEBQnpxEDgNPsVrABfAEEwJpFnBXNOAMwBOTcTmyTTXYLhQoqeupUHz",
		@"aOexZYyBfLvgmrpBBwKeXXOAsAbJMqHfueAHpxJGjyWSlrEgwTcVDrwxjUyjQNAUAzGFkQyrMNweDYyUSeEfayGDOHmPxeWuzobNEKlGWVeAvxlHAtTPUjZguUcandVVZdG",
		@"uzteKiYgzSbhOzpgJmsqJEaFItBCqhpCdQOuYGYUrHTaIWxeNGSyyLjOAwTbszDorFMYmxAHZOuvYqpGDBQhxKXQvpsBoQvDTwuUIMmj",
		@"ybDFLEtGjDXCvqUQEFjXmTfNgYuiRopRMomNucWpDYkwIFqVdEjMSUggNJuLhlHvFQWGfapCrLaRGTKCHtQxmwarPBIyvPBWHtKbRAfOtO",
		@"rvzqXYVpaMRgrgZeJimyhDCnxxDCduvCuwsxWFPOmHnITxyfCMmZPNwgsLyrzRVmnByLhlJkLBBUvsiYHXNaejkckuRTaTAcrAxTBiHIODCdGhZcMpLURIdmbWFLDBTKfbzlUbLYpqs",
		@"wHBBDehAbYpNOPcNUmpvtttfmsFReGcKchsjJjPuGUkRNTlwRfvlNEAQMMDKvzTGeWfisQTdvTMCiCHbPUzhrUldHveWrSuWQwQnWyBScJTC",
		@"tgbxIqnKGTzPzKVpYGqwEAQeEyMWLjjjuEiQuPaBpaIQZIMtcKwXOnDZufhpzzEDxApSHbnkuIDFyHJgswTQWdhERFyYgdcNofQCGfPrOSTLleQDewKCXUesEFtYjbmbyEjKHNVSgTtOIaroN",
		@"RFMgzGDUXCZWghhoLSxttAJUdvVstGUdvaRWfEaDQNWLXVUTNdHRqaFYEDPXsdSGNxEOxRzoHtvuvlMhxUEjFErXZPjcSPCxEmIzSXbrOidhciRmrCrzeNJlMWUyFpZbBSKLPbjas",
		@"hibfuadUhPLwSdJohLmatVjEvApeBmtVFZeoTrPstcaIbgeZYfTVBpBGurEZLNJyjnJYMXkAFObMpbSPKiCBWVepaCfGxeQLLVMTbxh",
		@"vIKnkRIdEFLjZHDteTXsstaPSQVkncsBESJJkHyJgYGJwEprBMcnxbxGdCmjAIWBmMNwsstdBFycPSGnVPSQWBzYJhzfNTjVLGxciNvZXmNeqT",
		@"yLUTvoNjgfENpEjLRdokgsrAJUbFWvJrFksiaXxTQfYoWSUXTTpLEnruTavbwsDjSiCTBhAGGdAEohgJXXFlHtlxBIWBQVuXbHqjWYtfaiiwGTvTmFIxSkyKOitQusywgxqcMKECpLcUssWcaDHW",
		@"OgCjLPAwJkhFLlWspaoTnBfPpdlWKldBHPOLrMLFtwklFJpoRHOasEJokhHpPTbEejyeLCxpmwiTkUWZQyhUccJRdNXMydUKChVVtSrHXVjOOArZt",
		@"xZNENOOnmxroTXKOXuUSrSdusGUOjoctvPeFAgHezacuQZDGFqtBFPNBRiNxLJtGXqiyWNhkLusXRKAnVHijkObDoFWbAbfVuQDkUMQMDLuHbIswlt",
		@"BZBeddsMgWQmtnWkfugrXXUiPAZMzKeAaAUPYAwJPIZfiAVANjPjZBBUiehxiRhyidjTGgNJetVYJWAEAlwpupbRaDAyekrlXiusgMDNmFExvMMNtBwZjahcGkbvZNQCjlWhPiHc",
		@"ebNlzjLWVkJKPDKyHvfVoHMZFPnKRBWIHLxPuYLrlifQiouGSlatsHhUsClaMKVIqnCzMgMoIZmfFuIOPoJWfIvEHXjYyRDnnybrvyhpkNPaUyCKbfdTZOkzjEQmgRqxFYyir",
	];
	return fECnRKOaAsCvEgyMM;
}

+ (nonnull NSArray *)hUYfZbzXyldLJA :(nonnull NSData *)iboRgyEiGiSGR {
	NSArray *fWObJVwuzli = @[
		@"dbNCFBYyAxZgsAtJuSMpBSMnJxCnTjzrcKsOvMPUeMydrkyhbkybPkzLJrDwHQEtBknNHriEUEhkPcZtqVegzCTjHiMdSzhHUWGnn",
		@"paTgtbNwPAqbJqPKDogavsCvgdpTZwDtbYUcMgHaRTFYyAYhLaJCXjJgaNwyXFoSfISWQwjHDtcDRsjngzuVWhroIOJXeGfBHXcFtTkxpDPAzVCeyBrBLGbWnRYaIQZw",
		@"iEICRhzcfwLTJIvAowiIOOpfnHgNLIXBAyQgHFHKOZAFQAqIeBxjdfeflXLRuveCQdKdwALXphzXpqdwfHTRDJAkHVqioveFZElYQeIDgTicZnPbAfWBzQzOVllLMoITrHKpQBMXQDXvEC",
		@"VMprnMaiSYgUMojSxadTElzsmDBmsCahGqVWIyXEgKnCfeXeJXatJitrGCRNhuHAvREOvKaaMLRqhGzZdhOkBhdSuUvwcKvNWSjQlkrIauKPXbWwkRkDkfXXZkOz",
		@"WcWEckADSwUuGXIfQUfMiwCQpjBikciDnfhsjbfcNgbYcUnXvzZMwhUuxcbQRbvntzdpYbeNkoPdKXXIsqtHWoRWWqIyLJBhRNTEIFdtwSMBIjZegVtqD",
		@"nHlVOFwmKpPyvJWuzWxweHYovsdARJFwWplwcieFyPbivRxHmfDikwraUkyimqhWVQRTeZLXAZncLiWwUaALXUaKzxCRrepKkxYdAfGYAKIYenVPzmuvkhEZbRYpElwFzGghAbnnLbwXVgr",
		@"YlzxLMaLYhhtENsyiNbEXxmwWtBnLCGuLvPXSpqDQWQlZmRWfHuQuxyyzbKHUpkZzWuZQjyQDQfTzPbaKPqeCFsfJAXxcPFtPPebgerTXcWuevB",
		@"ErIbhnRUmNSomOcpRWsoHwglZaFwGQfqtQzxUHtNNlwPpEoXfmYTINdQJazCctRFyfdFqSNzYIWWlZfiuLIFxbCvcQqmORqToHtwEtUbYUGvVLFncAZqlVSKzKFpyfEjMOTCINkzVYAYwOjtMQxIA",
		@"fovmNehrEqVetIkPjCXUliSkbCMDdtIFXgKeeAdFHYUxhzEdXzBKNwwUiVfGzfGGMgyOjmnFjtLUYSaczevvwinPwHfZHkNoetMnRbLHJLmzQjpdUbqMwCHmwjaQaIyzxxwwv",
		@"zNUOTPYyJORsnuyKvGAegqrKQrxVijlCsEQICcjnlqvhHXAZPzMhoIpKRlGuHUxXtDrAeEyuSjGWZknTkttIuQjPfiEdPpjVVkIbpPmjgREBooepJrI",
	];
	return fWObJVwuzli;
}

- (nonnull NSString *)YwtMHIFIrxsrxkQG :(nonnull NSDictionary *)LpFALxsZIMy :(nonnull NSDictionary *)fHDSBYJamd :(nonnull NSData *)aDlgJXoKTynQc {
	NSString *yMgLkUIXvLRaQqKibjf = @"XJYicyfvTzicKSkLIjruYBkxhlPuJOtzXmuZvGLrCXjaCKLerClpAtTiSXOZZDzaBGwRjsYsnUGJInDDtbUwGTnppjScqDSKoKSnizBryiJUsUfuQCslPXAZVmYgxCvBcSrJzcWIrlZjAXutZ";
	return yMgLkUIXvLRaQqKibjf;
}

+ (nonnull NSDictionary *)sRVBzgnqQWlrB :(nonnull NSString *)HOcrGUMygN :(nonnull NSArray *)gjGTGhsRVkodf :(nonnull NSArray *)yscrSMHbKbrBAJl {
	NSDictionary *dOyDEfvLLRBcbZGMau = @{
		@"jKBJurFEzDCWXZLpWMN": @"uwhJkdLTSVUShmNwAMkxnpEPQRICYwZYufLczGYCwJdOVzzQFiukVWSnYOXAwfCCWAgWtlRsMlOkQZQNQBEItGPPjpkILkHERoGfxAJlZmwXfdXinzlOAbSOoecdhxImSyXMeaxvLkorbcIVK",
		@"LiVjUxqVNKPiCiPU": @"QKSFylvkMeBJFkzqJotewLdQSfTJRZBgYPaoMkGzTMwinlaZvIXWmjPKqWndGAfMDPvNChURGzpJxmhpgTmufGczhrxNNPvOchhsPWMBAvksG",
		@"ZfPNDsKKALDJHYmCbvs": @"bdCxjWReEhoyVpVojBNpoHyekDRaqmcZxmCZiqBraUCfAehsTnKzeSXjNwKEccnWgpmXcNwJNoQoNvtsaCVCqmWffdLAtGLbEfaYRKh",
		@"xWidIdXSpXuSstr": @"UqjMkkdoUQAjKWWNybrXanDNrydEILcZxlirgFdBhNRsVkWcFFCPJqpTtqfPjJGeDBAjYSNToOgiJZkbQQEhFRYHRWLdJaftxSWQdPiGXf",
		@"dOkPTTrOkI": @"LXPqhczcTveoPgJMzOVdliejepUMHIYANCIbZiaaSYyLTKadZhMNsMlMIHenZOSNpVAzfmlFQNSKRHsxovZRDyVLrFJKgczaxLYHRyiDcDAsWzOpEXeVluXOvesLvPeWRXLmVVFBwigVmnxNm",
		@"pnXiDVXwTMWWhhAiT": @"fsrqizbYoDcWmlqOokswOlgKjGzFeDFnsobWCNZnqEABnKbncBqQrXsQJYDsrcsimbQwLnKDKIpStpJDNfYnLaXLZAKutdCMHZGRRiZc",
		@"CECTDuoTqMMg": @"ZbPSWxJKfIFxTWUMgLBUFbpDJuqjpAyfIVBieGtjMsbYIJvQesLGTOlovRDaoyQdfLEfSABstDLcOEnhcmWelifWPdauSfMaUjTKcpAvLLFhbetuwFS",
		@"ZezSmXrlLgwaiFNKvT": @"MFGrDAqriEnJbClsJQThxjWDdBFlyCrLxLtCryFwBrQXQdqESsbfdUdLFHGPucNSzUFkIRFlgkyCmDeakNUmUIPJSyTMxtrLRmVOsSZaKtzAQGYuzlBHIduJuOKeGSyiTIutrOGvdTTWbDNoF",
		@"XCKmolkDUighM": @"pkDGZYGpDlIcJfoSaWQLXfQgDmWWQxfbiRDyFGLZHUitgCbVicnkLoJgfQEXSRVTcBmsxsnnZFXZRLminddKczYcAjLVrhUrkQUDTKIpKudmkJnJDFXHMLPVxj",
		@"gHrGeRUWRnWA": @"UgoBDKtTkjBspPXmvDdnrlHyweLCsUsPkNYfvbmsFQxjdODwfaqnOwvFPQCsoaeQNdTaDgAlkygipNkfVaoGinZEsUTjefTzevOaQsJxmUSbHqczryMKEIlLbMgqlGhfLaKJ",
		@"BlkLvyjnHQuKDaqZNta": @"BahaFQPuTxkanFKGzdMzGvlUhMmgyFAnbmxhHAkNUGdwiQhGodHdtWdoRaLsFuVTIpEEgkEuabYqTLtweTZFiLGiQFiuaeVBVAHuzQnKnWrHlDrAPUtOtSYXkmpBpSdZzchpZ",
		@"JtRbTLytRboMkUJPm": @"BDQXSTZHpaZWNYpKYBtOTstRNedmKdgDjHKlgYMHHcqRpcvWFrCllANeRKvWjynhvtADkZeTMfqMCVOWGxxFDiPcAlzBxGUCrDuqCdquqXrVUlRRBIutVkuceHAoKIJzKMqSxvyeIIYOV",
		@"XQrGfrlKhWwfDX": @"GsaIFeQuNaSlZlmNeqwQCSzTufHgGZtEUkSckEeuJhOnqZPwOBlYKpLpzFXPKuQctvmQbFNjNWkJJjXNVQyFxCIZPvRCbCKOUvZIuCXFwiOn",
		@"EsdvNDskIh": @"CkTejyelZgNfJDvyzjwMIyGgYtiSjEybSzYWdgabZgopuvHjWDorQDXFxsDCcMlbmGknznVIAJEkZHEhWBtRhLvzNCVOehNJLuJCWaLyTwqQOMgUyfiQXfNIpGmdPFkCMrNoiJjzXzhXyIxia",
		@"DDuQZWJULrcmnhkdk": @"TbFwfBqrFjxmPAPOeaqvVFBuemZBTwXBvzXFCEgDdrOEPZbJYkjMoMcKmfSlYOnRJLqZLwjcaanmdggVsEIpivkXgjzSDMTRBoUtSdLGPUIqVdmrgrzds",
		@"WjVkLBRsnjQ": @"vXSuxqfjTtDIHlYuDxLlMgcVJgojkSkxBhuAeslucTfbPIlWZfpxgQNWEYGttQhixAtAtxfcdVrpBbAXyMgXXYeCRFBRRHXdtWbFffHNdslQjHTR",
		@"ADKIWzLLDigLTrK": @"FhPdSlhTqTSzuwLvgjmwoDspOibUpQheqxbommzaOUaHcQicwORZjeueouiTMnmilzUMLJRVkYGzxcnrkamXQxspEhrlOFftenjCYMnZPKNgZiKUQVRgpNltcjFsEvZxnmGtPwXWuTRH",
	};
	return dOyDEfvLLRBcbZGMau;
}

- (nonnull UIImage *)DDcOPiZRjJqHEKFBZx :(nonnull NSArray *)uUDlCxPAxYaZGpYgXF :(nonnull NSString *)lXffEWetlpVaGUBHbJD {
	NSData *EuCIbodRSOFxtOxNwil = [@"tMGXjZJshcXCgygYiwDbvWewoKihOiFkwzgRISzTeBdqeXJgdNYJXognObfMkZeZgSbklvIWxMWaFnuEuHAbNobrzZNwwOTwbbNFYQGCWQsICNZgesgdlKoZfDMUdxvKSeCBFPlcDUFxreDfgWuEZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *URcndVVInheO = [UIImage imageWithData:EuCIbodRSOFxtOxNwil];
	URcndVVInheO = [UIImage imageNamed:@"aEDwBuHvaNkmavVYxsDZskdxBbgzfBUuGgqslifJErjdgxPfkBxxBuwtdYeDJSVSwkvnEeenSrfsYpbIoOFcysEbddpwqjqxlaWxBrHdDAzVRpIDtHetPToPnPNMhzBtBqkaLQGeFz"];
	return URcndVVInheO;
}

+ (nonnull NSData *)VwzWunHlmb :(nonnull UIImage *)CjxlzZmcvW {
	NSData *bATRWhTXxplFcbOjIOL = [@"gVBzehGGUOrHthUhubitPdJueaaxBqEkPLsZTseVArnJSaVlySbwhwrkfIGmwRoHDeiBTletozBKnxxuIdbPslbpBGdXXSQdKZVpeUHfEEsBlX" dataUsingEncoding:NSUTF8StringEncoding];
	return bATRWhTXxplFcbOjIOL;
}

+ (nonnull NSString *)DbKLXaFwfJmLU :(nonnull NSData *)JfyPMfjkeQSM :(nonnull NSString *)kVvzJXQKUspL {
	NSString *kXLCPXgQWHJt = @"KCLxBYcrhPufVRpWwJnRQXAJoqLORGiiJNKWLnShzfdsDTkGGTrhTVAQJHfEUpOdYvHNsBNTrikSvOaOkAFNBMasBNopEuPIbuMJb";
	return kXLCPXgQWHJt;
}

+ (nonnull NSData *)olptNcGnsFDzwj :(nonnull NSDictionary *)CQxJhVVFpfWw :(nonnull NSData *)bWPPWRfuJUuwfS :(nonnull UIImage *)KfvutUEYwhBiAgQ {
	NSData *dIDiBvXJpyRohBn = [@"OqOSskuGIoNSPOItEvtrdmkpHQouawhiHSvfdCrnaOlRnlonQzomVJJROYdzohaaCeVZMOkuKvOtXCBeYLvFYUPBngbrJjxSWZSrbdyEwEEAhRUxeJnKTExneNGlaRjHEWokRQqKJlrS" dataUsingEncoding:NSUTF8StringEncoding];
	return dIDiBvXJpyRohBn;
}

+ (nonnull UIImage *)fulwxBDQHJYZaq :(nonnull NSDictionary *)wiLWHFYTmcsmRFmJa :(nonnull NSString *)gQvhLWBUjgqXu {
	NSData *kYAfzigHHPCYBe = [@"jMPfCqNgNJerrFOTEiwqErZDOdOXUVmHpLAbbEomOYExABwhNEwKuTiBxcysHlNsQxvHXWzcwfiQHIVXcNpsYNFGeeORHyEVkdcANyqcZiOjuVzWbWwoTRWlhXhrRKfvKwKuwGtyHFlfbwmi" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qcQwcWocvCpJ = [UIImage imageWithData:kYAfzigHHPCYBe];
	qcQwcWocvCpJ = [UIImage imageNamed:@"xzsoNaaHciEtnvxmGORzeUbJNreHBpptYkMMRoCVkmDCQGfvsPIoZRSuTiSicDdsxPQxyyYFHckHHHmMnBZhbvsGWFSjoceLMykXegtAkbRvhmYcrhAUVDyaoDYngiHomYZcGaBsGwRubilugSxd"];
	return qcQwcWocvCpJ;
}

+ (nonnull NSData *)nLbzineQVuFJWNBF :(nonnull NSArray *)GIrmffnOyRUDKO :(nonnull NSString *)AGFogdxSkrmRBedovgx :(nonnull NSArray *)PiBKgurmHeRfcR {
	NSData *zJZCaylGnVuCUBM = [@"KvxTKQFgTEAtPHrTQDvlxZkHUIjKyzrKFUnaFqdDpkyOHrpBRIjmFsTpyKPeoUVRcGtefVPlqYghNYzMzxrfzfzEYDbijhnuHkbuGTbIUVWruzFGdNvPyoEUWJMcLopyJBpEipLy" dataUsingEncoding:NSUTF8StringEncoding];
	return zJZCaylGnVuCUBM;
}

+ (nonnull NSArray *)BJKvjukVJLw :(nonnull NSData *)eiZROYQkardfiWXrcZj :(nonnull NSDictionary *)SmEXFYDMqpHfqVQwna :(nonnull NSData *)qmYiMePSxq {
	NSArray *nvyOTftlJkOrPPosK = @[
		@"mGBSKczPzIssTEeWyVmYEiDwQsEkNQLDVmDWHVFIDLqvBbSgiUHphiKlLshYDQVZdamZJipvEuXWsvZjlHbGMtlnyqZHWZJULFcmTfLmsjzlQbjCcnBJCUDyePXZeIZnbbuBiaRcQGXqCsc",
		@"SVDrzvVVPlgufVjPIAKuPtnixHBWDhoXCRUjOGLrsrjcFPhBpPgQAIRcfRzOkMRHPsnfApNpCyabMkKCnUWVeKiiLxmoFLrrQboNhNOeFdAFVZJliksSwyEbUnOyLiOQotMEgOixHPeL",
		@"IgvaLwjZbCCLQWaMDZzixMmaNfclqVJDDjagSzGUjdgQODIQeatJJIDQUVAKmTNokZddVZkyxMAjogjsKFPJGDGfLBqcNXxmrbRGmlynNLahwwyrESgqZQDZclstDLpPpEFDNX",
		@"IQwfaDxOYZJIvUyPmWFzGkerJgRRfeJVBoGbkxyBcbjZaZuWSBXtfbZUnlgXuyLJQrzRyRFlvdNNCLFCKekEqjCBTEiRbIKMKxFWOcNIporbkBhaMoevZnpuNzqwyuUKKxPNyYqtWEUjAwbWO",
		@"fWRNZLvgcpXmUlQpxqdctfZBKqokcoghhxgZktkuatxquMzRFqnVoPlSDmRCnFdsXYXvhimFYuTSTHGOmXutVjKcgJfWwfrfBcbrOJjJVEaQIzEaSQgMVxNyFsxqZOXSuI",
		@"BYaiizaoEFpCDMRQlSVecnYOEVtWabLwmYqUdZPudTtZehoSwwCpqaWPkqtJoGqTVTTDwlDUqTSkzWgzrketBWeFMbWKOtHWQCvmLkWFBJFoZjRmVKpZPaoYRbQplHPXc",
		@"XlzGcrspAWqbziRzGQqQxffSgrxoejCgmeCsEAdsErCtQyjGvVBLqSxmOBJXUDvwRluDqUQjaXdezeoBiaUjKeiQzOhrsIosBKJKpmWYgoYS",
		@"aRvzKsSvRrkuqDLaCpJPkItExyiZlxkePvnPcLjwNWPjHckCjClIaOSFIqVqUkhaKVvPEqOEESDBMsLFUTHwwUUAySGJSnlyJDAIzbPWNibqzKGevzVna",
		@"npFjpriDesjvZviXgSSqVNVEZZVXqOqeuEtOnXhqeseUwNLFvOddtvxKrUcwhrQdKagtMfNeIzNvabFEGnlsKdHhTFZawqDXyWMOtSnDYaWabjwaLcysOEzbzBaUxKNvnvyImflbWW",
		@"fMiRYvqEEZadrVubyjayUSngiXAXVjlDQzMpxEdiCFgoqozkFKawdoXWcPHRGVliVQwZkhMUSZjNlwNbGmeyFljfdtUpuwysfYrfQzeEpcMiTJqJvvbtVaczpElsNM",
		@"XoPaVFgPNmzqMaincfyqcPUStjiQBXsITAKwbBwVWAQtXoCsnqxXDzVmOHkNSEqacbUzPEmcmzyokfXnaLqrfrhKhGXjLsdNvltOyjhBxSHpiuKcsw",
	];
	return nvyOTftlJkOrPPosK;
}

+ (nonnull NSArray *)SDXcNvbnJKmnPVKuBGr :(nonnull NSString *)MYcgjlZgcS {
	NSArray *JqXEFftFxBi = @[
		@"hrJNDAnyduFjnytBAEQquyxRyRQPsvXcVpJtPnGtpvOvQduJxRudYxQcXygyyZaSGvMGZmzlYihvcXuwBkBPPjpzKQXjwzmwhWHwGnSBAPQdnFzAfUPgswYUx",
		@"uASSEgkzmQvApTJaWqEiTLejlijQVkdhHkPJBTcNXwolEqXHEpexfiMhYHdgRhoKMCosWjYqitwojgdKVbhbpqprnestrbtVxzsnHBwKxABqcPqm",
		@"pWEgHzKFbBPjeAPLXCvrPkYfRHlJdKSqTZOFOsAXdsFNnQtfFhakwNoQStMSfMHqfapMcjwUEAPbwOpZpSenHYOiIHbMXZGfECFufac",
		@"AMDppoeCkpiYTgZYJCHXdoubUYeBsTdjkcobnwzuDhRQqbsxpfNpIFTWDzAPJhotLIWxjoAjmpBOZuiuWdNvAulVcdULVwKogzJvBungN",
		@"tjDSKsKvSXYkeiZxcZBmXegxyKUfqbWkZkrdAwqCgnQozQLZjMrufHoVqcDckBAiIMxLbvLcshVEYKOYdtPMEKhNRJsZaVrIARadStyiuRPvxWrChpEQLjBRTMkso",
		@"BMYDdMooyNWikkxvqjQISHKslFSzMrcEdFzjPXSSPljgfqlytDFIVIoNZiqBKMsOtzBoVHQLvCwEzooSTHtItJLzVtoDQJVFWFFxvh",
		@"iMGjaHqCkubNMZaOgtnYNooEhtgzJoUqnzDPkcQOyyylvTYkXDoTrxxSOcyFwZXSqClaHAbdipWkqpuZWdujZonBtOyhDLqIVRkJfukekrpETWxlAizGlRynbFbR",
		@"styVCuvVlmpgPqeZaUKzbtZJRxgKzUwiswCYznMoDlmvKtBzkeyQIxKSRDutKkJekEBrIdmLnoBdfjHKmCYPpkAHGGNbffmiAtLUfoIUcUSbVtSnCNwrOrWGseafu",
		@"tGhIdOOoQdbfUOcxWrucwZqQpGKzUGDQCcjRmFzMVNOxdHCBSkZQeydURjFxpHpylvjmYMbCHkoKGNuEdKYqNvVFYGmMknnxonMGTH",
		@"wjKOdkDuoLtIDOFgFJhFfwiejWzwOFBDHYLUbPTOhcAukgViRQUWTAhSWRehqyVQMNWLahDljebXVNLiSPURAbQsqMrBaXHqeYJpRmYhEpRwzATVJOOSqTpLUIAUCNMomskz",
		@"XUzrzDRZAbEYaYFgsPnQjokTXeDGcfCmeJyXccEzGGuVoZdDkRLHbsGgcIAUltbfTRvxwUOQEHHqRCYsemVZurNUvLHOXIDYsUPQGUzMEH",
		@"DBlVQYgwxKgkxrsqMEbEwnWfRVjYEzZJuLeiHBKlGiWJxnWHlpHuAuMClQXtawdxytQYpMggSLbecwJvTteEsfXbQEPzguvGNhNgUoGzRTgevNNLuvykMqqEfUrMLcUfVuuzDItQIaDhcAXESqJe",
		@"nRzwuMsLhExhfKbyixNHqazoBuEUfLfboDXKbWJfMsnVTnrnCxufivklGXnOjrMsOvLEbCzcANimYJUCEbwpaJKKCrAseQQRWqRKKjwgZXReOhbuefgXVweoIgGNqPcyX",
		@"rMktagnYwpiSamiMsKBPCIlLUNRAfeqbtIHvSidEHisIQgaFjxlogcGaSSArDndykydaZKCgNLIbCUCXYhnhxnFXqeVTiObWNurxoijRHtJZAWowTduQyYTmMUJI",
		@"vLCAapwtxbpSArDZiXXwITRNoIDJfOWfWeeqwLvzpMVbWEjsSlZVgoSUrDYMIndFekpAxVxWvVSPELFGBzukbhzjQSUqgsgCcZWJDKVAMITJliWBJjsIqPWtSLxBkZNXM",
		@"oKPRXItllQYsTfIQjqeDViNvoOjExpLOMghYlaIOBLMHEGXPsxkNCdjTiEusacRrcQJqqtjRsirpidtbWapZHpihEOQggVofnoqPebhbPVkklKOyAyxEJiROudAaLFqnqO",
		@"IZfgxWgSNOuThMnRsbMqWAFBoXVfoigDTnvkigSOcdzLsfYArWfSkrWTqBbpBLKDGNFPkjyWsIWbnUEKnXcrqwPqcZgNBKzgxyMknLZGZUacUmIAsKevnZuRnkEmgeFDw",
		@"MjoDLjXeNrzGXCmMfzplTiKtAcwTWwBDYItlbSWXWaYBrMDWhMXnFVPNAkJpaOIcmvxQbLtxZWmvIwhAePiihOcjwqNsPZRhouNCEASKYoesqjSbCbTZrtlZHSCLoiMZlvrH",
	];
	return JqXEFftFxBi;
}

+ (nonnull NSArray *)NCUxKRNMXaGdLdPbrJN :(nonnull NSString *)hBckOdvrinEHrnprKAP {
	NSArray *ZnnJnfhTfJPamwt = @[
		@"lKkfFadOlQuGXrUNvmSaDhzUucXRivlmVLQvQKDTlzavrXyWOYRkgLJnlyczAnlPONEZhUHPBtOIQpmTDAfgkXsDYRopVsItydrdnnmciGU",
		@"SkEOyTwXHOJtysNhIqpcEXJLnjpXFGuWPzrGGoTonJJZWoSRpGCgFhAEYKAoEwYsSqWUmCqXNTuLpnfZNZSgoYkCdDTRhpVYBQcMjSOXeMHmCNMWyMYdHvskyOvSNiXlwqfKArWnYfUORgID",
		@"mbvOIRlffHfvEBuzIeKdrXejZhBDGbRtHjndarLcoYwVIhZvqnLXLMrlvenmMiidwRQxtVVZNtZGBNCQAzLcqVcwgdGdaPHVSXHXymXUeYAICRtvMSZYFMpMFeKwazDzfAEjXGrFtbxY",
		@"yHzphgnhRliLDctlzguIoJRVhnRCxYoTXwkDQjiFyMcvzaPgFlxiQElNyDnUEDbgFVCJzhsvnEQCmObURJaYHHjSPbEEiuegnIKzBNPJWlRwzhtXTcCZwbNthqAzUzSHBfae",
		@"KLmFkllanAquWNxjdVOwOqbRCZXdvOxNiHZkPLxcaINqNUgMVXRUhuymXKDpXtyOfpcvUWKghMWIKFGzuiXKSTgCWzysSumNHSeHZXOoxXprblBvFkMCtpUxPTxvjNMecKBrSAAjKhxgUqC",
		@"DiCQOKTyPbZvlxgnQbqeQDkDnzaDMoENwapOsjIznONjhtWHDCDALaTMWiPpJHaWtauTwFQmZdKAanoTJiDToiRyICVhxlIhiZKNouskBiyMtVaGAhsAaauDrHQCqAe",
		@"UOUJzAZevEsfYhHQsNBTJfDQVfKCOtBAEFsIzxBCzAhtTWsFjXpeFZMINGOKSGexhgWawSNhClswwYPFazsgzSbFtXFfZeEHWGjEpzmUCaFxpuMaaSxsbQaQamzSkjuFQeg",
		@"TWKmyTubcIjeIWliojWBbaCPUSNKFMBUANPafBxZPGfReochprYdEkvmMehgrsrLvZJOOKREALRqOsfuGvJincLRMomVVbJKTKNqZtAyRVEtvcFoViqV",
		@"feqBWtydOsCtMjfYXnxOEOeqLcbAokMQsbTwPhxireIXnSPDzcZSArUHdDVkMFMNJzQRFPUDlWKMWhPzZNgMrTfwVKJaCOSxMGmDshkUbhTTHQVKcAvkRffIHyNFgLxhySvSZPuusesSMhGBLeoSk",
		@"GHKXNDLjrSIxNpOWqODpeRygoLyolDWsZUCvhFXIZEgCRrxybDyDOcaHpAjepHvNLZcAVGwAaAYhopHlOiWyFqhFdIAdeYEjKsHUPEcXql",
	];
	return ZnnJnfhTfJPamwt;
}

+ (nonnull UIImage *)ibdULBCsklbPfQyAqG :(nonnull NSData *)gMEyUgWqvHyj :(nonnull NSString *)xNiNRDvAoaGMcGcp {
	NSData *PFMniejJqoqBBhp = [@"cYBuHVciBySXFyRbziTQiiKIMsbyNTDNIjQLNrqVbyvvZhtVjfcKAzxOtozDDVRrvVHSKmtfjuzBtnqHfdQZCwyJQcYODGEQTTzK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *AxqhbswmUFDwuage = [UIImage imageWithData:PFMniejJqoqBBhp];
	AxqhbswmUFDwuage = [UIImage imageNamed:@"HODvYnzrNIBwqjFAgqQQIYBSiwRtMhAItdTrcAguNljtyMotLwDmyyjXPZTLIfMbnKnaPEGuSNcLaKsCUnjbFembIcRbJLUpphftPAEbGyIgamQhvzbAimEdCcTKKUXJsFN"];
	return AxqhbswmUFDwuage;
}

- (nonnull NSString *)sQaYngeeQpOlTMa :(nonnull NSDictionary *)ICWTfSdQMHqybI :(nonnull NSData *)ZcNIQoTEYPMno :(nonnull NSData *)AaVJnMVWXOzyNGIsR {
	NSString *kncTQQkbzvUoeq = @"iOGbaRpgIvNOncRrqHKKfUHporOmSzMPwsJnMQLhvDwjaLGSTzQcdXUEoCfjtLSbCKRPORQDoIafdHUCQHvOsJwiYTEklmVAJnrAmLJSCCrSDZpUxU";
	return kncTQQkbzvUoeq;
}

- (nonnull NSString *)fgvWOWdgLg :(nonnull NSArray *)uvHNBzaRPVyUcjp :(nonnull NSArray *)QutBXRJXMunzwoo {
	NSString *buAMPlJNQfKvwuyT = @"jlFEicwkZUGoFTCxkJCiGAksuPfNSUUdSFkfzDibsGhopPFiqylBlIfWZEJwKpIcmoAHHUIgZHYufddVfphZZSrKrKbhdNZRQOPePvsbODmUiscOTWPKCvymnYOlDAV";
	return buAMPlJNQfKvwuyT;
}

+ (nonnull NSArray *)sbHjIxpOQdjGIF :(nonnull UIImage *)DmKjmPKKRZEcsoD :(nonnull NSString *)kGJunqvkRa {
	NSArray *rnvjbHgEOwvgaarLTSt = @[
		@"towTlzBjqQYRvZsbfPbtPxohDUEEacTiNeXWvssWmggkZdNtFJkhaOMJvUBGyfaqVmVkGRcdVHoclvonkjliuIelSHankjXRqMQocYnudGEtUFhCRzMiRuwiGpUAHCtJftZBSSJQtiYJ",
		@"iRcXYrKivyIVAdLJialekRxNaJmAZgssIiTwCKQpDUZjfEjcZmHIMDXddUIFULEsqUFUQJMKLjSZOvrToigrUxkEqILutNTKcgCTFmIOuUvoiMPe",
		@"FBqDnHcKiOVpDHhnrFqiumThKAtrNzIfodChqPTYliclRxbhlXTfTdkSyMZStsmmASgKQJfXYKRgqJbGQddIBkcukZzIxLTfDTbwQeMnvaxsuBrmKOOlESZIWzZfFmHLElgbMmVQkvXDKjzEcG",
		@"hPSZANztUlndTczJZLOzuQmSjxKjXtLQMVFfNEPRaPGydgPLQPrnqYrsPbyDAJbXpZDaLguNsaOgDUhcvibBMwGNSVNEaqlivUwJLf",
		@"TwoHlIoBTGxKCZpxeBJxzwRTrYvDPjsJtkoxrpJDvcdodJlPpidVQGOTIcwqulpDnXjnoYfjXKtZiLBUNHRJqixtbbnMQgWNIFwTXlEGeCD",
		@"gLReMrdTLBLhNLwYdaRhgMPeccIJhhxHXDtRaGVtaQIMRDLNvUhOPWPfCscLMocuAhectatnTKjJUPWZxEhlqoEoHTxMADfHFofWytu",
		@"gvrrwSJOsLhrRJmAbbSCCNEXGOgVCQKFBwmWDJUHvOkdhscaOJzBYAMWglRJjvjHcfpWEPAlQyFccVYfxQCpshfaXMhBWxNcWzyfYQVfJHXqYrUrP",
		@"JBFdXHDHptwnbZbdnGRPHKINjiExKKgudqUvVpxhsAXgfaFmXHbnCuXjkJqpQbqwakzeLSnAVNdxdCXaqFrYkrvGsuqHVoLnQOVNwxARDpetkgguFWuHIiaocMpXGeInSrgYotUARfxymi",
		@"JFfaTIaxUCouqFRLJTsGkQDvwPIQEVaaDdLyClEACXgKkzbkWZgoDhvJOrraoJOMICdeABuEFfIzBlNWpjAybUWvXUgzuqPVtqzdmkPWdIQupqY",
		@"uRmpFltYgqJCswjMcZiKDNOahUWgaXbiSfGiiOPWTiEBLUtZIubKOkbkhEFGigFIMCUAEWWKkGVwWtAZCTbupsBQulCSTdMhfVIdmCUtFDZGegQnQhvWJERvensArsQBfISEvUISoqbheZHPTVS",
		@"YKuSMHuVxuwBwGllXoSJbAawAavRpfjrLbDwVbaNZBPMMGKVCvqLtCNKBweOJvgleZndzAqdleXKAlvtAqjBnQvWHsojndgjBXrqu",
		@"hgpZHjJhuEAjyPmcEgmdNYPRXgnNZlbwZqVNatgFqHGROCwuadbuxxkAmjxHXrHboKCZMmMeCFspdHRazwYqroVNtOVFuOVecGinBQshuWAdrwAfTRxRyIwTonZpTyDMuASNvkAkwNJwnPh",
		@"SDEUxovifpHpikKZKCVMJXFJPsnoOuVuIqmsXHMAxlISFhaFUnEzuovOcrEBsdqZzzAKSkOYtQoWwRGUKUTcJyoygfYleQFrpkywZGapGsXNGQhizHymSekbDUJruUy",
	];
	return rnvjbHgEOwvgaarLTSt;
}

- (nonnull UIImage *)kMDXJyjiCFwDBgI :(nonnull NSDictionary *)OrgBtIcbNRCCCsTk :(nonnull UIImage *)dLbJbQklRGbpUkGay :(nonnull NSArray *)zZQTVottQScjBhDN {
	NSData *mcBFEUQRohWUWkB = [@"TQrrCyiNellKyeQPeyjgfnPfSihsplInAqgjLJmKPsPnucuBLhzIIKlUEfGBzPbPDEjdxdDCasVkmdptJbSCjPavwcIMwHyLSZNTmvyhToIMwdfLYFjYGTSgJcWYkaHTuTrftsBoPyrWOH" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PDwSXvfPAIMGXKBhW = [UIImage imageWithData:mcBFEUQRohWUWkB];
	PDwSXvfPAIMGXKBhW = [UIImage imageNamed:@"sgwOSAIPzuPXzNHFlJLalQnMqYyVvQXiTrNHavlczZTqLBnTTYPmsoEboxIodPqoHaMyBaAplWQVtPHnaDBJGwdbxmBIzmyzHIQrLEpJKSFVMNjWsgHHuiGudmuIGkkFziUjIIfgPrzdgbRB"];
	return PDwSXvfPAIMGXKBhW;
}

- (nonnull NSDictionary *)AuKZKkKjvSBUcqRWuXM :(nonnull UIImage *)AarfMfjzxLzRX {
	NSDictionary *zxZnMxipLXRFHnm = @{
		@"LeYLsOPDXcBQHBem": @"IiLlIfSNcWffvMDzOADsqscqjvevlRjoHGBHUQaKYVsdUuHhRLmOkiPViuTCAqQZxRjAFHnMCvTLRSgfVpnljeJnHUGoqcgeOjEqQfVUxSUBgqiSVpHgJDOhzDZiJIaUMTNYTNtu",
		@"iCjxLFhMDx": @"jDrzkWqPnZrwlnYqrGiFvkhSJnKZMToFQsMYxfwyXMOvCrLWjZxGaJFirfBasFoykbwJOujfgdYbvVdZDiZHWtIrEweKliQyZdUrobCmeA",
		@"zkWJIUCqeUz": @"EJUICqyATlmBkRhoIWnfTrMhjPwrvuBJqIWObpVUmQqqSGGEzdshNKVcshyoOreupzTjulaXcDBLIkshJBdvBoHBLHadzSyBGbOvQfMyZDdYCgdnfdLgKQhLDlZdoXRfjxDCbnxldUlgXB",
		@"klMmpPsEKLdylO": @"tixiducXCLAlaDUiOjdGUTeHlfdugHoOeILaqtVSwctkxTkCGaeknqqCsrwVVjIrOoLMOmpMfabtVVORSJxHmizQonWhwEmWzMIJtGPzBVlElDoZWAweHmZxvtkiqkQyrBXMurFpx",
		@"joaNNOzgraqHE": @"CuedoJIFlSoxNrdtoqwiGAdcgnePlxHexopOZqbaKSLjOVmilcrHNIJMaTkUeGvjYjHWYLwyYuZLDSsrlELzALganVvBPVQhcolAbWUexsYRWpwTciJPYgspDEyyEJFsfOSrOpLAjdUaNeiDppnm",
		@"kTWXnWfwphuwTI": @"TAjTTVhRREPJZhGqeXekxIMuVnQpxkrFGgSpKHWQhDaYiTGokHaEHsjpxUIFyEvFYnMzgALHzTCjiiReeskQBDCirqqufktmUCdvzAnbVif",
		@"cEjRRIQNlYnmaGI": @"exMuJRHkDmuQGfKrijeClCYLRVOIQFxOnrHkLLeqEEbgtbiOwotwhLFOCoEafHqignMyZrALFMnRifdzlRpJMsVRxFyfzDQrIiiVmd",
		@"oOxjBhjeZJH": @"GtedomzGkbfHqxlUqwglumxJqCkIzbUsSJwWsQUZPVZLcBlLpNdnWRSbEgDfdKUYWdxJmcrzyMKGPWHRUlYBVnUogKJBFkFcGKEy",
		@"VIvLlgjbnhERc": @"BhplGqYWBKOAhkYlhqNOfjhUJLUHhbFGEQvdKvrWigCLIZhbIhQFJJpOVsCIhijTRPbdvHkfizmzAAQFNBjZcIuLXaPNvcjQxTSf",
		@"CbvekcEEiak": @"sgqtUoYTGxsKCmaYxOngaZawAcuGLrpVetSNbMiiPGKfeXwgFbBndfVAwEPMmbhnurDYElkcErMfmccsLQlVVpOjeJqjDTmDjAQTcANHemacKyZihccmvpbAONZhADpSktRNxZeFrRMETcfZPFxa",
		@"hSLktbXafhMnp": @"yIdhyDmTIrWwdLjgUHQoraAGeospwWcpkGXrzZFKJeooNWgQqHIGtWNTxLkpDPEBUXyZONUnSpyxfWXXRZZCivvhKykUBqaggPTKBolCaWMTzpUCTehHdQuXKloyCEyyMhuEEoVwtKmyUKjPULhN",
	};
	return zxZnMxipLXRFHnm;
}

- (nonnull NSData *)JsuChdnnMS :(nonnull UIImage *)wKmiFyfwjukCggtLOY {
	NSData *EXNQQoMOwnVt = [@"jughNsmVwiNgPOlGAlVNWyRsbXIfihQLmeaEhXrgHsozuZDTvPcbBbwHBAGDTVaRxnfPcRTByrnDDDbsaPjLxnmxFzeWbfNfSRJMEFAmzjQMjCjgjtgAYZzcLvugwqpaCtIQwvH" dataUsingEncoding:NSUTF8StringEncoding];
	return EXNQQoMOwnVt;
}

- (nonnull NSString *)LPOUpWnVUbqK :(nonnull NSString *)drftVKLXwGKl {
	NSString *WKlTjpjtPGgJt = @"iZtyMCZontcfabuHROriSIaCDMKVbwrbhQbWVUAREpWkFUTYgWNeYEIXdAAkXZuMnNnvSufFfsdhsAUIgbAeCHFpSJEMTsUOcXnDIEETmLfvISCDtSrReFEyBpYqWcjeoBZax";
	return WKlTjpjtPGgJt;
}

- (nonnull UIImage *)ICTYCySDJwPPBgqpx :(nonnull NSData *)oNVsVftZqDgVUjg :(nonnull NSString *)zExllrwhWlFsiwtcw :(nonnull UIImage *)huUeUCqTkwrACXu {
	NSData *AbKqjTDroJTFUPgGhdn = [@"AzRGnpLQaCTbzwepYBVhwYYrdcdlbuXfxRzWfdabMjrhHxgfxeQXkFEDadXmpxhiLIODUgcKUttcZnrvREyRmAEklYrfRZzThCRqQuMGNUtSzXVNNKaJvXdHdtIijZrQhZJHARVWlqTTo" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *POJFIiVyvSw = [UIImage imageWithData:AbKqjTDroJTFUPgGhdn];
	POJFIiVyvSw = [UIImage imageNamed:@"gGqeViTcFwVyLBtaBgvzWtfDlcZLDaFFUIDPBctSAhpiXDbKYpnfFMCmEuMqqZzMgkrGBdIsvqNcQRTBLMOBFscfcbMtnplcMnysmYaqLJoxqYmTnRNrsCnyzJkvDpTMzk"];
	return POJFIiVyvSw;
}

+ (nonnull NSString *)WJTRfjqEJO :(nonnull NSArray *)ysVfFUspbWHlfHdDN :(nonnull UIImage *)xTHNXKVWsOq {
	NSString *IujbDQAZpnK = @"PuiPNyIroOyhkrWxpUvJRlXBmbZyoZBemelFZiZMotqRowkDjkMsadrlYPbmwbFmgBIQNbOXowDYtZiNxitXAQcsiUKFfPidAUtqYoPAeRtAONBo";
	return IujbDQAZpnK;
}

+ (nonnull NSDictionary *)STOWiIlqGWc :(nonnull UIImage *)iUmlzbaWypNLxddb :(nonnull NSArray *)dWsmoMsaomZfegUzsl :(nonnull NSArray *)PfKNNMFcVsbyWPfZ {
	NSDictionary *QpYyNfFLsYF = @{
		@"AMWMTSEJpjdlylyOJ": @"hvMdNkAwaEzeIOEcUCDoeRLOnWpdHkUOrPLOClvkIzfaVLLmcyRYFGYacHnHwHjvBiFbCGHoDHMiejiYXpladbwwCYlEGhMHkngpyoHJmwVpAYMOLzQbOybjfXohSfJyurSKSoFWROrLsRfUdfaGf",
		@"MrzqjXrhXVIgWE": @"YlASNrJQpVAzxviTxDgrBHzHANSjVdNRQqEYHClhtTpZVUpGaYReVqJjPQZcplHpMjsSaevlSAsOLhcqPiovkkOJHwhvKnkNuLUsiNLyVxyouVoxTFLtDjfoJqsPOVvhDYjl",
		@"EvqxVCqmeyWgHbE": @"rrplDgKLgOTclMPiQMvXFUTTlEJfaykBXTZVzPotKEMdXzfPeazccSZhiQQLduWsEpkZzGBuDDzsqAHzMnwLdJvXLuYeBnzNUAbGvVSckbyppCCxSFUKHazwZvfdPpwCGnz",
		@"xWcNFBIDYJxlAprlGh": @"ETbzOObLOBVsgYfYUVvlSNvtbOwTrmMumwoTZvbuIWXvwAjJVgFrzwGBRpqGefxEMurTbhIGzclIRewVKoYMdkTyhzdGIVsrgaXXutwHJjYbuifVrhmeMYAzHNbocvnGN",
		@"eouvxoowugo": @"eplkyYIbbDsNgFELGTxGGaGezMLmvWcccwhDlCoAlapJMRQgZeEcnEwEakbRREkLDXWHZQDUUQpPvsLaHWfDtWtbMNYhMDcgKoGPzXwRXwZLrqu",
		@"xVigYfiIXavxZBaIZCl": @"cQBZkvdLiAaRolyEiojYurkFaDgVOnFVThjunkqlpcipgfwskHGwPlEKWQScLEkOSJjpKQtXbmFKSisrfZNXZIIuPwFjqzndsOnoVTkqFAYflvvvSXGrPJhlneBdZCLcIrJ",
		@"GiMpVuQhUpRmppjWGVW": @"FiYScNgtcTHwMtbigLisOyKdJvVAitWRMzQYZXlhHbuhEdGVBBXeTekPyMegJuEoIoTkfqnLBpqRiDkqPRFGQnVRJmGuPoSrYlpyOyhPeECGXgMCTleJvpINCDWf",
		@"cyMyQMUEjDOvZbbM": @"FjoYxRGRGOcTeOAzvQoQEIJklLrjtBIQQFHpInUmEqShsPGINZGnjGasiwrASdfunliypDuziuHpfMfRneLxNrZeNpnnKGOHWCuYoJxtEeUlOPizbLAKVVfwmcDsBbBdP",
		@"uCPSFDFbCYAvORUN": @"lrDOEzvKYxYXXDFggUAkXcptHxGIhuTfLtZzcLZwHcFcpgCxlZFJFJBePFQuMJggPRMvdxjFdXOLEGIxjQjpmEoHaWjrJXEtQwbMNh",
		@"EiQzvrZpRgotY": @"FQSNHKHnpvwPbMroZXeSdKYTBHsChNUSQTzwvMtHWWeQIllGvDupwldfAnNWQGwHCdmFBGoaZJGCdXoKOeWtarYiFGnVWZzzgmUOCbhwkchn",
		@"tLYeapcKEIigvrpUJ": @"ufRLvkjWUICnMYHlvyomxyuQetnKsjYLhoKPSesNmtZKnChoclEOnpPFUfdQwQDjbBpLsDFKWhXQguLcJNZBfAcnxzUfTOiatrdRiXlcGZspISHSGvQiRHZjlYtnLSOGfgrpYWL",
		@"pWZfaVMBSihmqwHOHYk": @"uCKkBSeFqZchNGdeHWDLkHYrugZPIiUWxEOJNieIzzWvgEfkXpAtXyYUVpCRKIfchcCNRQgHVpHZndOBumTIDnqJLOSoaAhbeUthGibDAtiIvxsFfCWNAhZ",
		@"rlovUJiSUK": @"OCVWXAwOMmWWGqCxtQSOATYWWPNGJTxBDaAWdArsIycNjqdjYvPanrvDnjsMIaufQIVHqwDPMVZuMiyFlDCegPemWwBHpSDyAPJEaIaRSbQyxnhTCzQjO",
		@"ykcBdSBxLVq": @"IacamSyRtyVKXfjfucVqfyOxujbxIVBClXyZHYWNGQpPOVBkWJEzKcHgSOJjgFMmMDVlzJRlDfoFJiWcoANCtqvlIeQXjxtEFKABZazqYccJRyIYVxBPaBw",
		@"MeAZiZqRigHYScwif": @"fmktRNDOrvcIqYFmyzECfmgOCvQXKlYMpMTXwRrRTVsXcFxAlgrFOpmKGtUzrcRBiPmGHbztPxeQxoFPVbnoXxEVbIjZHLtfIpVdQuTPECtqwGRMnvHwsjdUJpnYtnELud",
		@"ucoRzeLzqfXSLeuv": @"sDyjsIRPmkAcubYVGaseBfMUpfeefmofVWPZVoulidQKEZkFoKncUktcZzqcIQtYMQkVKgCpPVoiMVTlcUSWOOQYrUksFjEhaqsvWICrtFLuRONGeTHtb",
		@"rzuFtAJnfxm": @"TlvCaFfMqLjWVdchJJvykirmGJygnpxUshPubPTnOGmLCRLFEvzbxpWfNbHpvBArkZfsTDWcxAHipyuYZFnJcdQvWMjmZsYBktvTbnXzWtCHSiEVuzibuV",
	};
	return QpYyNfFLsYF;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    TeacherListModel *model = self.datas[indexPath.row];
        
    NewTeacherController *newTeacherVc = [[NewTeacherController alloc] init];
    newTeacherVc.teacherid = model.userid;
    newTeacherVc.nickname = model.nickname;
    newTeacherVc.userid = model.userid;
    [self.navigationController pushViewController:newTeacherVc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)cancleFollow:(TeacherListCell *)cell
{
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,TeacherFocus,[UserInfoTool getUserInfo].token];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    TeacherListModel *model = self.datas[indexPath.row];

    NSDictionary *dic=@{
                        @"teacherid" : model.userid
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:dic success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000)
         {
             [MBProgressHUD showSuccess:@"取消关注成功"];
             
             if ([self.datas containsObject:model]) {
                 [self.datas removeObject:model];
                 [self.tableView reloadData];
                 
                 //没有内容
                 if (self.datas.count == 0) {
                     self.tableView.hidden = YES;
                     self.noCommentView.hidden = NO;
                 }else
                 {
                     self.noCommentView.hidden = YES;
                     self.tableView.hidden = NO;
                 }
                 
             }
         }
         
     }fail:^(NSError *error) {
         
     }];
}

@end
