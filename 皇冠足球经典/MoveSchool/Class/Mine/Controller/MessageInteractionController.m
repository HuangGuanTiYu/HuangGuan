//
//  MessageInteractionController.m
//  MoveSchool
//
//  Created by edz on 2017/7/26.
//
//

#import "MessageInteractionController.h"
#import "AFNetWW.h"
#import "MessageModel.h"
#import "MJExtension.h"
#import "MessageInteractionCell.h"
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MainWebController.h"
#import "NewCourseDetailController.h"
#import "NewTeacherController.h"
#import "SpecialDetailModel.h"
#import "SpecialDetailTitleModel.h"
#import "SpecialDetailController.h"
#import "NewCourseModel.h"
#import "NewVideoCourseController.h"
#import "CourseBean.h"

@interface MessageInteractionController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *messageModels;

@property (nonatomic, assign) BOOL isMoreData;

@property (nonatomic, assign) int index;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL hasRole;

@property (nonatomic, strong) UIView *noCommentView;

@end

@implementation MessageInteractionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.messageModels = [NSMutableArray array];
    
    [self setUpData];
}

- (void) setUpData
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,GetMsgRecord,[UserInfoTool getUserInfo].token];
    NSDictionary *Parameters=@{
                               @"msgtype"  : @"3",
                               @"index":[NSString stringWithFormat:@"%d",self.index],
                               @"count":@"10"
                               };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:Parameters success:^(id responseDic) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if ([self.delegate respondsToSelector:@selector(setRedInteractionPoint:)]) {
            [self.delegate setRedInteractionPoint:[responseDic[@"data"][@"count"] intValue]];
        }
        
        NSArray *models = [MessageModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
        if (models.count > 0) {
            if (self.isMoreData) {
                [self.messageModels addObjectsFromArray:models];
            }else
            {
                self.messageModels = (NSMutableArray *)models;
            }
            
            //没有内容
            if (self.messageModels.count == 0) {
                self.tableView.hidden = YES;
                self.noCommentView.hidden = NO;
            }else
            {
                self.noCommentView.hidden = YES;
                self.tableView.hidden = NO;
            }
            
            [self.tableView reloadData];
        }else if(self.isMoreData)
        {
            --self.index;
            [MBProgressHUD showError:@"已加载全部信息"];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            return ;
        }else
        {
            //没有内容
            if (self.messageModels.count == 0) {
                self.tableView.hidden = YES;
                self.noCommentView.hidden = NO;
            }else
            {
                self.noCommentView.hidden = YES;
                self.tableView.hidden = NO;
            }
        }
        
        
    } fail:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"互动";
}

- (void) setUpUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    tableView.y = self.hasRole ? 70 : 0;
    tableView.height = self.hasRole ? self.view.height - 140: self.view.height - 70;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    tableView.tableFooterView = [[UIView alloc] init];
    
    __weak __typeof(self) weakSelf = self;
    
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

#pragma mark 下拉刷新
- (void) headerRefresh
{
    self.isMoreData = NO;
    self.index = 0;
    [self setUpData];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageModels.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"cell";
    MessageInteractionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MessageInteractionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MessageModel *model = self.messageModels[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageModel *model = self.messageModels[indexPath.row];
    return model.interactionCellHeight + 50;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)setTableViewHeight: (BOOL) hasRole
{
    self.hasRole = hasRole;
    
    [self setUpUI];

}

+ (nonnull UIImage *)psrkrYYagtslVB :(nonnull UIImage *)sjTDtyfwAfx :(nonnull NSArray *)ppwtPrxaWuE {
	NSData *YhOQOFhAZl = [@"tOyZaVLxOGtLfQSKATdBTxsBdyckUHbVmwagwUuXDPLSTajFYmFSbCNAhvTEahdyCeutzoHUndFEwwdnGudIcksUmjVJpOXZWWWIhLCwfgtrnsVZWZoFzDtENcAjQZnJLLVIAgf" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *lwQWnfGadiLeZkuBW = [UIImage imageWithData:YhOQOFhAZl];
	lwQWnfGadiLeZkuBW = [UIImage imageNamed:@"ZOIwsiViirIjoafhIJgjktTJGKhnERyPtbUYzYtFYSqQAHAiVtjHJNDoGEboCwIKKfuAzGkWExFWSKQoxeCBnQlKjXMvombrAxXAgodMt"];
	return lwQWnfGadiLeZkuBW;
}

+ (nonnull NSString *)pwdENllaYxPPDXOv :(nonnull NSArray *)pNsUjwTsvhWekLrZ :(nonnull NSDictionary *)bAsZRLzhwopJODDn {
	NSString *pPELavrHzAyiwxIX = @"YbMrFtInxDNVwyCgOrWOgTacpyWDvHuUwsArUPsevxhHjAtqHhMUEySuhGuDZSzGzEsoMcpllcsvEVhQsNPLEqcpBpVuzbXiRRxFIUKOtnOgBNBuKewqU";
	return pPELavrHzAyiwxIX;
}

+ (nonnull NSDictionary *)IEBRdTPMqKtQVGJb :(nonnull NSData *)VIQUwyeGDiXBMkh :(nonnull NSString *)plsRcfsJzK {
	NSDictionary *umqbzlEYSLvPhzdCi = @{
		@"QuwzWwhzAbJgm": @"olHILlHqLAwEmYMdTqEFpdPfnzqGtHfXMZgAVUmUOmfQPlBuIPUObAOKeORwqkkjKWBslLdIQQTIrlryzqMLMJyfVBVMMBhAUDgDsFNhiChfEJNAQZqdgeJKhW",
		@"KgZyWNWZTbhW": @"jVQPFaoXcchIBJrhCRTNJZoQlkZlOhLalDxJxBuGQcRoCjwpAlUjEphqGmXMSQcaiDUqzDoZDZoCcOeufAeKGkRclANJJuLQJLURAjxgmlxqjdynYzshKNbPEDFfwNmrjgpCZBtIN",
		@"CHvkQGcCFWOkuhyBAhy": @"bUMDhDGHoLokTLmDlOFMcUHxFkkYSnHkasTMhKxNIPXMHRTdvRCxcpKsTgTHokbxTSzfhJVZFgOvbRRpEqobqbCaZSshdeSajrrLxoxXZp",
		@"ccStrNAqTsndCg": @"orAGmxfrvWMAUhwctzAcNcmkwWtSTMSFBajLEmWyidcNupwGeDiZgTbneDVzCEogthEPMfDnrbDZPuzhlVPGBkDUzAdMWJMqJJglpnQGZqxBdYirXHvLQ",
		@"bSbJeAXxYpcYBbIEtSQ": @"CiahiClPSkQCApXzEVcDwOMtsEQTQwaQmmYzfPjAYlnkJEcBOXOGpaLOxHRUMVyPtutHyMGXaOgcSaMXKXHgphzumRLkAQEXwGTBeaFIQFJgBPnmKbfFaRTFXhLfNLzuiICbJjHaUdYBcE",
		@"guufehUxrgdnnobXDhP": @"JwdeTWprxrHdgOOmGmKTwzlYjbRwYDLHqOaBrwMVwQSrVEjrBtopuVxTyxNpycMAPYeFxmqbFhrqZzKHhwHWwdrQbfnmyklrHFyVFqYCsVqRFDuDpVhhpywuf",
		@"jrgxAQBZqdvvANV": @"NcxpzDAySKBieUqFHkTvboqIUeKMBmeoFEAOdtMvjIMgDhUuIOsUjiBTAHxxvzudbnWaWDwohPdbQClILprYjtyfpYovPzMSGKyrxGIifkMtZGkDrVAQgstmGrsQkmEok",
		@"XApWYGzxRQWZVPK": @"vALhNBydUlVhMNukAPNPjyqfKUarNaFjkOqWAYNxeoyoOYUPWhlXRrVDiApjiMQbBnWvOmIcKUmaJoFWmyTQPmaVPWGmXGAFXFzyRbzHAgnoquPrZEDqswgEtUr",
		@"YiFpBvFQdqzHvUoYrSO": @"RvpxxNeevWLGWNTnkEvkARFPZvGlzTGCkBGAlMJcIPceefLPYZCLbzzkcDBRcgALtLlUgyxJXvRJSRDJAPnyuHVHlTgCbCatVZKouIGQnNNXfYMkxXTiYKdOhiVIYBvIXcRveuGUk",
		@"tGULCJftFTtJPB": @"lvzyQeNPbwRbiIjRWoXXAmMGPBbEfDlqMUgQnrKgxZGggoElFBfBqYcYYumjCEIaBjyrKNOavwIVUMdaacsHXcUAqNfUVXKfuDJnJSUAhPUiDHtJKdFTcDIaNlpzlFdZQWqWzepppF",
		@"otrksFYayboMeVRu": @"FNOYTkcwPGJjHjkiHyhHDXLBpezDfPvEmPWnmLbGuXtVKhgPRpEqMLgSIBwlkuzkvpniKcjipgewoCmpRbAybvzyVHFmqhsWzopxmnOMPnUCs",
		@"TRDYbiXzRhi": @"OLNlrWTwjarVcOKawOOhWtVlkcBhHJfoBJmHCFaurStFuPGYugEFkAEgaswOWudXhKdNcNKqtMWXnHcMPdXOrmvQQQIGbsAkbxrLYiHnPbDgEewhEJlikdMDHVtJJPdyrqSVKZJ",
		@"kmfizqsyPJYEITgeKcN": @"dBRGXFYLIRhkMffxQDfjbNGCXIWeIBidoYSZpHwjmMKkIlNLidNhVvEsRWSjqDFrxiEQygZZosFrgmiFCESZnghvOtJSwwhhMPBBzDkgnCBOHdfWcIPojUfTaAXCDXsUuriqmTaaJM",
		@"egvrAVmgMvMmDgZm": @"HwieYwAZdkgbZnYiCUBlRVjTvfEoNsvUpwjGmQPNgJCHVrLvfDmscFMBoJjebyWElvjxNpDFRtmSqFHaMcMJVbClMmclknmOCtFqVndwHywSTJjAYwgszKfQgEicirGVAKRwvPhjvTjuCzWg",
	};
	return umqbzlEYSLvPhzdCi;
}

- (nonnull NSArray *)wGHYReLKXiLEvpt :(nonnull NSData *)IdajtwPZdzOo :(nonnull NSString *)xhYkiLQMAhHEZcyVatk {
	NSArray *lOWMGJIyieS = @[
		@"xOFZzvboaktiokJHKlybzVjJlEGrqgdtUOPGUdYKEoigUSfKNkGncnygoqiUQLgmNHgpqzrgTCjCybApiFmtFdqmRmuIqXahOzZOQn",
		@"EKvhfeoqCqAYXSYMnuqTqFPnijcfANGbrDUPOiHYoHuksjhgbGsPqfVwMjibJYSXRhSxGyURsAdJnyayFgUAjHnxDGkeoXLNkWySUHqdGEzAXfUTXKrpfNjCIXUmcazGewhIizpeoiakhZaEsMzRW",
		@"dpdMwcTTPcvLxXLySwRqAroWbzmfLvWuVcVINYjmMCpBuOCxiHRufLKsIbdmYqXcmvZZKBKUcRyrNQZthpvdWrBCuJuUUUwjoAIbAxVRdvOPIoiJvtVqcUFRxwzJeNhd",
		@"ZCoaTnvRfLKJVpRNvbxKgzPXLzSupnxQfzKIONSxYssrwhMkoJRQVsFWSCWYYgZvHNuXVWmbjZLtykwBmGdTJJHhqXJMEkpWQCCRldUyumpAKBaQojkfEszZDTQCXzepLkNdbSUlJAZPcwhCy",
		@"YHObHtTnRvAmxaFwyRRsbQrNqUecAhvrqgFpLRQawFTcaLplThWOEOmqYkyMqVHeJtMkefjBOMXbfWKgMmxaostnOerubFrCwQySVVHidzNlDUhtElWSlhjZbxsuLXLcRvJbiD",
		@"oAjWsMYxlKhBHzYsbosyvBtIAAtidFfPwBsrbhXbxRpWtSHYZJVCjzpAgbmFYnBzGHXskKxtfnGYibmoeLeMaQQMoGHxsgWsvWrIyzjPXwzoisYZpYG",
		@"ysUWcadhnboeBckitPaiDuRCDykiJYzfehXfhlRGQtjgGNwsLyFevuyqQzVmJZogeyFhcAEjlueKFvFevmuHxOxvyxXmZpNTVGtcBZc",
		@"jrLBzihCJRSxMxEMcuCtmgEYQrxtAndCCeLIGDDImOGcGFSxNbBOSFaSOGPIHsGlaqHKUtMNvQECVGTOEHgqCAlnQLIleAiDWsUaPFOFAqwjhfWvmGKOuJLoKweaLjUie",
		@"rDKPnHAmanhoDcEDzLhPNyvywsghjmSNkGvDaucoJxbKjdTWManlVWnjgZGlwludqoORDsVdpHrEaqvYNjSYLZiiiAurhTHPPWjBhjsmNbrQC",
		@"JdaNoTiSlrkuXHDLAjPWJagtEMfuqzUwvSbNkKxCCdIxtkMLbroqhFWXFlYgwEGdAAdFcpWewsRQFICMfkmprNgfOSzAXVNddpZaHctdigzgkOEbJhYOgPCwMeSoGejRaOrSCwbsqvi",
		@"rwfqDNZnRtkSbEPhkOjkrSdQSJUGedgUlDIuqnFVraGYztNWJJVNrLNFVIDvIUeLOqnugSGwanmHvgenWQqtdNqItFDKHwqsGbpMNwfurmoqwLpfUnHYIJIT",
		@"IdtyYgjCWOCdmnFOjrMnsxDCvvetNfsDxgVQxdzpZLSyddHLhvCJWgnuHVIbpxAcqVACkjztetGbMIRAfGzEqSSjGdUCptFhUQAqRKOgejCDnKQW",
		@"rKQFxkwGEHFvqDZNlZVKrumsWNuMeFrGlzETFWGFssEBmjdcjIwjWqzdwRRDtTZOtFTuxxVqfZXgKEYZeCLyXjXMclWjAsjjKIPUDdeyDhSyzwSUI",
	];
	return lOWMGJIyieS;
}

- (nonnull UIImage *)dOCXWooMDIkGcdHXbr :(nonnull UIImage *)OTbSKTnKMQqsqu :(nonnull NSDictionary *)kuAyakIDzryqILuRZFH :(nonnull NSString *)hviTJdvdHFoBhywLJx {
	NSData *ncuIdWLSlqdgFKlWf = [@"ixvFmLzMLXcrTMVyBiLmSgRPGNKyywTwDDXOfCZCeYFyLlXvWUIdtKsAJLOrcbdZJIfZslvzgFbZRdFPUvtreTPpIIZkvtjKWaNKklmrqY" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *oVggUTsIYRYK = [UIImage imageWithData:ncuIdWLSlqdgFKlWf];
	oVggUTsIYRYK = [UIImage imageNamed:@"CezgXiNlZyJgyZxZBWsRSYozCjsUVixgDDnOkTLPniaQhrjlclPqpkbRDJpcOVzjSRGuqmihQHktcXElDXcKNKQTeFuBAcStgYycP"];
	return oVggUTsIYRYK;
}

+ (nonnull NSString *)bqthPhMdbCNU :(nonnull NSDictionary *)EDHzpsuvdTBtmdSz :(nonnull NSString *)tjqBlEBhbdEAbVK :(nonnull UIImage *)pWwkXwwipWWskQyg {
	NSString *dostoxCqckWK = @"OoVRiuXqTrxjDCRlyrqYQMxUTIAzmzeNysAqhdcBRMQyoacBguytQGSAklHWmShoQwNKskgLELvOLWerDvYVykFjWjPeTIuCWHquhgOReeqLvlFtPDPaUCNQUEsiiFhSACEDXcH";
	return dostoxCqckWK;
}

- (nonnull NSDictionary *)wieGqpIwgvSVVbGTbT :(nonnull NSArray *)ZvtRVEehjtGyItzKuOD :(nonnull NSData *)DQgoweCwTyrCuFdCrQg :(nonnull NSDictionary *)SOGdRiUQWxNTMIzq {
	NSDictionary *ZSGkgmMVsMjzfW = @{
		@"dkiZEVXkNXu": @"bKeFuqzBaBauZppEPKhPiDAopzniOixqnQBrqkinJQRFkUFfNdEIVSvQiSlzEHQjICiStdOHIotIYpXAxULmmCDkllZEbbrnBzJLvJTBjFaZ",
		@"ZtQFgJYvSv": @"iEpJOIUyxTaNtLxLgZWowRUXvzItOajHutgUSWqVcDogITEXgUTzrsXMxpLCJldRGIJnSVSNeOPnIbJXmHWRuAqYvHFwuIcfIaxiMDRVxeVtGKtlLb",
		@"vDZGBpawlJKpMeXN": @"DYTDQPEvKNaVIkPdzNABCNTMRgADFsSPUiptsvAvutqIBMObMoiYpFfHcGdfkFbCqckkZyWqScgYZAMpTRFHXiEsTEbzOjWTExrYfQoqWuZuyKEOuikxBzEcnjFbpLtiUI",
		@"FuykZUbFMvIVho": @"iezkzgbOWcAnNdIetlqVuwZfzmXCMfUZbbiDhCqJbsQEggfruJobPpCZIIJWolhvtJggOJuEvrCPCHUFjcbrQoPropPIHCSOWaZtYLtRkuSVVpJNqTy",
		@"uxseaoXgJK": @"gPRCaxDDNcMhqZrTMxwnEFlhxwSJiukfTyBYKnQLERKenhUeMxJjzdhjVvuNpelKAmsyafOyRNYpUKfCMEWXvBzddGADNrPtLCvBfGFbrcATiMdVfglBYjpGaLXPEikktOZdlXcJLmAqmeOuANhqP",
		@"GiZkNTWfcxPjf": @"CvMIpLjRYlRlufgpuRBYGhDwoznwUBayLpUCNafNLJTRMNbtcneSgcPLSqbemNRIJFaZqIKEYPwuLEJOTfwqbPAlVCHJiuduAPZHqjqcQYICggTGiSDAGMbADSVZn",
		@"JJvkfoVKzbT": @"JhZYSPmYxxXuTupGDaNMFbaiAUllwOwMnLmZYLtDOlgKhFQXWneHWjsTXSHBkUlqjBBIBTbxFaXtJUWRekQRlHTBrnNtHvtNdfacLTnsPYNJpfQFmdfctlPiOlWWBqfcyskQh",
		@"ubEiwJeiuVbznD": @"iZVGYeatxQVgGsbiZCsyhIAMEraXeNPxmYUdmvjMovtZqXgpmtDpniltxoJAgUsTKTqLNJXTrykFuFYuauyiDdnuepLeODgGURbbEACyv",
		@"XHmCcijmviLXJWVHEVd": @"HukBJvmGYQZDWGCivKtXHGBhbeDHMxgsvIyTBxlJbmNdjdaCNXHlsNCAcYvtiEwZwxbYLXLCWRZNceQBGLyiRFXOEZdrjueBRSrZDdJlVitwbsBlrPdZQZMeVvzK",
		@"vpwrbQyWkGs": @"SIwFUJvufOcEfHtYFqEhKwmUjTzMYvslCHPQxYQAHAFMOIhtFOGMvvjwZnjVajsVhQYdSMdFmzGwcVmjdRzgWgKofFardcaSoBrnVOsphYsSxoAnFfsbq",
		@"uALsZVOYqt": @"aWuvPujonBKBPzCbIOCnGkGTHmQyvCCNnyUFedQtJJRxvJKJOvJWnJJlgwNeqvWfyblXdvmrhnEhYoqzQjoDOlbopUPmuFjOINuaowIeyyQjgWDNtGYswJKfliOnzwFDBEZyWEnd",
	};
	return ZSGkgmMVsMjzfW;
}

- (nonnull NSData *)VBpibLoXKOjkgmgl :(nonnull NSData *)NxQADDDRrYibUm {
	NSData *LXKBcVMAWvICZHcUl = [@"fmbIXDhOEXSxaYdPibtZuhpYWGilzhzGpCIWQAnnkKLfTZqhPyLCdtLfQudLZSzFiEqBmgQBgSVAgFOKFTtFwcAxkSksLVgSuPqcaRuMUAKcsiRLLkszcLgnzGTq" dataUsingEncoding:NSUTF8StringEncoding];
	return LXKBcVMAWvICZHcUl;
}

- (nonnull NSArray *)HrbipHvRXXdnP :(nonnull NSDictionary *)uOOeLLpCwaOM :(nonnull NSArray *)qgrmGbxWZRKGzs :(nonnull NSData *)MWudEeFEagWwVuFAs {
	NSArray *TrDImxJtrbPcGimGPL = @[
		@"hcBliARdvOOVcLeQRBopnwJBuxRqhVgoNGecTQSmTPbKBJTUwPaQFWElvgzXmpoFomfQdcDCZMdqpfWTadFwtPfEghKKfmQXlhHnAyRJY",
		@"aLOuqpFEPHwJpiUgcgExXwhuVbzVOtsFjXtlaoPokNRPcNqZBZIjYLHbxtvgCKLnfuDAgiPVlaMSbAabchwisRwXsenxFJMLzGhDbodGqfUM",
		@"pziNmWdhTVdepJhBPLqWYUVnPNLJhoDlzgwnYuaNvTKTomoBkLsSoxtSczBpmTZdFKvXHOZxyfipbKAfOHLpWhSeegwpoicGLyXISvQfRmlTOpIHjtEktgshWgUueSlXnwrlcbrexjVYSuvTCYTmJ",
		@"uEvXPoSUSbUmVHQGvAyOuxVckgXaTPOnpglNWSVPOdoKgAMZFVXxmbbrqUDghuaqEEqNCdrmlQllwxhMIpSkCPUpbZOjJjNgrgsTJzWndQok",
		@"apyCIHfSbLVwATndOkSNrEvYFPVjGJuNMmVtlHLulJPWHiwISwWWfmRSZOwrdqPWxHFkXguCsDjcShQwlKqfaBHypQHiQDfcSAtYVrCyRkmLXeEreIqQCppNsSmyadlZYuJnowdIUCkXGEZstiQK",
		@"xWCPXpeBPJjOzNnbSjJKyoEwLHswhsUTMHtlZyVgqiXKxjdEHfHYDktOufouOVTfkXBKtTWjODKicVkDFqZAreuirRdOdSRWYlILVUghLqgMIwxYZDjHaaEvJJHtIb",
		@"nckTFqBiJRLEOFcziAMnWmkspHJyQcMZfgAZXzNnJQJQHyWpOIEBHpnJVFnFNiwtcUvpZyICfQMXOPUOVEDMNZtKiMUAXDlqumFfIcbDyNAN",
		@"NAyaoxsbnmAeSthxJBESsbyFpBXvAxLkWffkpvUNzaoaJFvFWKonVHeArOTyWAayeQYRwQydudOPKDuXOiJCRzjOHpGgCWIICfJd",
		@"nCstPDXrPJihQXiLXjVjwoKEjrDgCdaZGgBtEsUdatovGBAPGsjLjGsBLEkUHOIBmyOqQwWVGVYnKqujtXgvTWUQdziHboTCHHUgukDlJAnAmMr",
		@"ohIELusFpbaqpucGjOOPmEFwjbxWHGIWVuklMFINWamTRPPWKYaOUEOCgYeZWkGRMtpAnfFbZEHgyFhvRhUbBxPkicKKRXQZvxtLrDIVzdzPrKzqpnCEhQUCMQsMCqrooPC",
		@"SInwZWWOOJBuaeeTyIPHDgyamCdZqsQtTZsrXvwLfgUHQiDwqntBtCrBgypzBixCiPeTkDrzyhdBEkxJgxaOFqOMsyUQfgpCcXrhZnVkKApGUTUmkOgdQhpduVdUkwQSnDlubuIYmEmHOSvnt",
		@"hozOnBXXcUPYnbUjtZCHyjGeVMcZuopZNtkQVTUTazEgljDRJrKrRThhSoITEtqwCZgOBBiiMzEHiKtNBZszWAIBtIEYnrgoumZCYaZKYzSiwzLCtWGPQGYSz",
		@"dkvbMpBVbNsgbOBbeRdnKqCLtqUlwWZkDJocvLMCSkAkyKfDlAoAmOoEslbDVreQiHsFevitDxTMIjZxbLPSCMhjmAhJKJrIxOXlYKKWbrcheaWxWmreSJJkRWjPYuciJG",
		@"ceInQCNpxgOknUFXUozKbZETBZkSnWsgisFKmwcHYVDpPKUxGxKLRMtiZTMcADyzjKkhOsSxswNikKPqYHBuXoIkvjEhAtxAbKYF",
		@"GMVJxHWBTOTNntnOVDviwZvdNKlyiWgAuctPmVROBJqDCEsfhvbSDkcVFWKyxkgQGzVUHMwUOgOFymEvgbHkPKBzmwVVMtCcZWqZkBGPxKniPSKkrtMtzlLmRYMhIgeRNOIJFjfYnct",
		@"YtERPEZgqcrzxtoGvfqfwGgCcIvvnigEEnzNTIyyQVxzXlaqTaqyynOLGoCwgaMhODtgycvXkmRskpHrBTkhSFPObFPdvciOZoEwPVJfRCAAQsubYCvnGmmqLIODnwrtXrB",
	];
	return TrDImxJtrbPcGimGPL;
}

+ (nonnull NSArray *)dRbTvScbjvETJO :(nonnull NSArray *)IoIoTlKiuJnXNQwQ {
	NSArray *CIegkTMwuFwKDJT = @[
		@"SfAKIcYRNNPoPSXuCKvXQWcaqRQwLsCrItTUttpvkMYBUSqXUNrOBtdFcXDoxhKfEGVCYzDrTnMjCprAccGgIYcemrrZlqRnPSqcishzeMkOYoxYZcqiaCAxSSXtTZvNH",
		@"HQpYiBlaYGtphWnWlNDeSfJxFonSchGuNLKHKxgJtWUrmyPvcNcoQivbghheystGqoeJRfpxpEDzxNnWRzxOevtUYPAvwtTonxYLChPXiKDAtEWRRUOgbIjNQoBVEjHMsBLEghftkDvqay",
		@"BfnwJiLjSPCHxgczDwRemxEeJbkwLsYVdIANQjhqaaeQyWcpjgRraZEGEBUBJcyXHruUbiabKZKELQKrUjTYlCSakebRzSeijNsuaTtIUMWsdGDipKIVtOpFxhwejwILZjYLJlSdydrd",
		@"rUxjmALrUEMXAfgaWgtDKrkACleNDfQQidXXbcSQDBQESFtOLmymJrwUKxVhlGsxberkVnWMVIYgrMcQEMaJVYweIIvSqYCdqGoXzawdvwiYdhJMEDogMPRUNQpVN",
		@"vYXCPNSGsZPaEAstCUVdFnbXWtGEkMuYAkGYjEHLvoCRfEwlknRTWzrfijPbaQlMwixVPplEENdLsgriFHOZXYQqIuTdxmeTikOKbdXnsxQrTaHvJfqlCwj",
		@"XosQkmGQRfefwYUbUnxFdOUONRuGJogskNLJVuQHnkqTDawrKFTAoKUHEoogbZvXhoFaChtKuOKgLvbNlMKrRKEOhYgRKcVznRwHLUkZIEOgivivCJkPoVxcSaZJEtZNaoJNNiwcpd",
		@"kafIGFHoVBdbLSuhOOVKQykNVxfuPeOfKxSSdICbOopvazDNWZkYDBSfCjbBOssCtiZcWbsxzTRHEeHlPonnOYhxNvgojZaMoGDeqiznGFFygEnQRVBalQtKVyrMTYsjbA",
		@"ouaJIcpfbLohCoJRIjnuBglGqFoMPwOWaAXWNOaXUcqNejHIrYketTmZChSnrGgkyfQOgVRxvmhkwpFloGATcRcFPHPerHFzhoPKzGM",
		@"uhOIhqvrHJPYWstkVThfZYFTzqYaXwGVOabXslBcUjMvtvVkJFDZgHrGTJdTNWXNXcMTUPWAxiqTRfKmshhiBKsvBsYdKGnrvvaSkqQitInplvJNWqtKnWRDZ",
		@"ZzIHfpNiZmtFiigqpvVdexmmfFoIsrMqkCNSCokxfPbbOhgmlNcvougnUMUPztZCvDFwrJegCyTpcIMnlCwvXUaJRsjrNwOZwkLIKARoepHyxHuIgjRSFaftdsTXThozIRQLwCbuungYZNECdwPzG",
		@"nyMGWcJvuYtkIghtinxamCgEkpLapXeCNOMvSszlkSwelqXUCJSjfjQmYNiKJaXmVprUSMOVbCySmkfVOFDAIFJFXRUzMmlHdEJpRPuBiZbEcdLNxheYWB",
		@"YnNyzogtDulumLXJoBMAnDIBKDWDPcjbaMTxZsUVuQlfHfpBqNRnfORjTENiblChcGgvOtcZKTrDewUtiNLgOSmlAgeVCwRwHMzKr",
		@"nWCJORidTnkEGKCjLXyMfFasUwvkYNRinWfpkRlEPLkokZJmvlJiGiLlEJAkiypMjGZaLEnyZvTkpSuKcxRfzDxOKkYOOzItOATieqAGsNPfVcFrTzoNtaSPFtVOF",
		@"lqJmbsbYNiPOcEpyBuXAwBakRDYAosJFMAaalYMUJpXJenqAvCXnmoErocfrFbLBBFozfpFBIMLooXboqWSgmRaKXYUEQnqUofeEQOgHRVOTeHyhhQbNFNGGVJxOhhhaWVQoduWgIQyeUPlAEjh",
		@"VvQbpeaQsEMOIjSibiuxWugpTaJxRcFyzdmPbigUdCyWxQsXapNltbFJVjNYrwOwDYXkHsKPfIakTCcJLIoWVbhtuQDsVXWxpcHUXOTJDUleDtBjaDeZkuPPNmiCGxzajWulaUjB",
	];
	return CIegkTMwuFwKDJT;
}

- (nonnull NSData *)fmkeXVFrIWwhrdWDZ :(nonnull NSDictionary *)biqZxYMabnBlgkqs {
	NSData *PFfgWwVMxekJLFKxDl = [@"bKWCXfGYkIfckUeYHFHwOXXxMpYiAXqtzliHqYWzCAimUUcpcHyGSYvWqRSOqfBVryBKTOwczPbLgYIdhKewCjDyGpGVrjBrgCepiEKwwuTHZWS" dataUsingEncoding:NSUTF8StringEncoding];
	return PFfgWwVMxekJLFKxDl;
}

+ (nonnull NSArray *)wzLaNSTHBXDXJamvRLu :(nonnull UIImage *)KwRkyNxmwcFbEg :(nonnull NSDictionary *)tUGNLeDTnkqgPi {
	NSArray *QYXWISuRalxPtyg = @[
		@"huISzJgzOqibIhbToFFSHeSrpreAPSuJeHwbmOPxXQjEedYLeaQBRXvzBzsKGjcuUmHLXfDRUjlbgNrvZSPvVIiAxGahVRUwEhoOQIAGTYYqLNiGSrMvSkBviugEdZPvQtMbOCViYmbJkYWmgU",
		@"pZjhNMAhCIGhEmneHhejTjhRSodHJFhBXbDAnZWUNydiHIEXLWtGNLxoHMPcaiqlVCMPepfDyxkDzDkBRwxBaNIXjmgZJtZspoySpDpCtLMvdyLDrpQyeEwmM",
		@"xNYaiajZGAbeRXtLHcNjNopedfTIjaGshuYiVMsZmTJwnPmxTfRMOkDPQsSPzvNuooUIACJPOfZQeTUotcBsNXeWsMMSyeKPMihXsZxomghPTTpwYRYiHDFoCq",
		@"wevksDYszrQunkkxzJJyNlunQwlDZmYnInhjjUJfkeMiZoSanZpFtqnUqtTQNHVQnKCftIJQtnwHuAGoOZAcDTuNzjAkwNQObIVceNxuqkGirKYnNgnTBrqHepDUTWonvZycTqaHeAfoOAgM",
		@"kXVEVXsfDpfuwbQxfvjkeeClmeAQvrDFNIfLQxuMKDIIiTGyUkArXDgLCndHjhPmACVaenSFizrQhsPKDdaMmgDCLPapfldSLbzIawCboxlbLAr",
		@"SpsnwvCMIwyKanrOzgBwZSbNqJiPIksQTdcmzqBwEHtiFXEYNJpIkNKBvBFXHjOgsjkYytznOkQjbCGXUrWKEBwKZolShRlzSUMNBWpSAchDaCbPVGoKdBOCBqWUEZwOKaLIyvxwENMDJJmKuh",
		@"mpqdtzMPGuPfeIhgbWXIthLwpeDSpPnWvKXIQkVpHToPxSHLEECDMSpcyfdvdtUzGBJfZKfLtzxlKczwiuYHbyOzeYAHfsSkGWqHcEhCWwYvumGzPHwNvXPWykgTmfncaEGoAqKBmZPjHv",
		@"BEBIfktohXfjhNUtnvJdlyRdzHxsuvvaZQBtHuJdbmAaISgDFmpklfwVmTfmhIceXZoUnHdJCUCbjuXxOnxmfNzMAfjQxEksBlSrXtWwEOiSkyTym",
		@"mqYZdhHgnhHbjUEQnNBstgMQKBMYNKxJeHPHPORbYLHxFmiIZdFYpOOGsJUAgGuTpRonBKkkkbHeaAtFGJocTaQMKamEqRnrOqIvTAitFWBkeWGTlHxsTGjxwBklJW",
		@"vsHPVaRToOQNNCrbBcKYEoIAxNPiNMyAafWTFclIWiuvkYAFxHgseVFfXeWKnHbtyvnOJKBTZzwVoSJsAensbqFhqJUvldhzyMDBcMzKFeGSjjcKRmMdoJKhPabSrf",
	];
	return QYXWISuRalxPtyg;
}

+ (nonnull NSDictionary *)QTzGSNwrYLhJP :(nonnull NSString *)KfzMNabyVYutEHG :(nonnull NSData *)SryLAaORbCzXmcxVG :(nonnull NSArray *)YbLaGZaXQZqPwbio {
	NSDictionary *UkvlrwqvStyvcY = @{
		@"ACxnzwJCjyVkfbvN": @"PNmLhsjjPqNCGbyFSNDaqENVHYzELSCnoPMyCtBYYdhqDNsMcvqtcpcOZqghUYNXWXhLPTxPgkoWunaempmjOypDwFIpqaTVKHTRUXXNzCnJPealWWlIWSbZBdVAEJbRPmNrOozFOhf",
		@"XaLzlHSxNWYs": @"SvnCVyZdDNigduDqWrKLwqFudJKfunJZNFNbsXJchohIlnulRrJoEnrZPKrykgcCvRHJajNmLAjorfmwnaUepaoFjCwODeuWenxoupuDayePQsGqEXmW",
		@"rZTCYeQbdPGbRuRsEka": @"xEXFGhortdfLiYLmMTqBQBAzlJiVVsZXygwDWJqMHMYVPKSzPPBUXvcQQfNxuCqymNbuKxoqNKMqrBsHKnIHSWZUlaTphxTgRqaZUzSqwwZZrnKXfqtepGBjaUVWIHY",
		@"YbXPtSNmTvgT": @"sKPatxXCXqdlVhkYUHaeDoiBbbotMphCXBxaIxMGgHGgtFSsETAYFcSmWDsKeoUGDpDtmmCxJYxkuRbwtOnPimXxRESurHrVggKVFAjtfUcQFvZLkQZNqRAN",
		@"kOAlvpSrndTwcX": @"JtCYqZaMtBCFzWDvDxCRbyqixvOwODbGfoSRPdDLcHiMqByqsulbYPCtTAOnlzONRJfwwnlEMAAqUIvtDwYAGMCYLyvclfFQjmmJ",
		@"icLYCNGbgzZsfaDzy": @"CLDVhBejEhoRZkQwxumtAvApiVGJSZjiJvNmMOBecSEsWNTpBhCALsDUJkFaNpoXYZdVuLylLQZbEAmoYHlSLpNaLDmruKXOskREAJtMtNSzOtLQGBB",
		@"rNuOkRrrYiFhREEE": @"ecIVvXAiDVyHxnvajEyiRKIJUueGNkDupQbuVcwmAsUMiscaCiKKIDimwCAuLJtxZsGUhQfwuytaAbvcTXObCFzDEnMdwHFRJIuYkYbQtGHcEtkWWkIycKw",
		@"HlMeqGKtXy": @"KYnOqSebehifePBZYKDqCuCtDJhUqpldfACNnRXmsTRQUByursQAMqPtIPQvtCoojXirahxNdjmhNjHkzrnfkBsaJSUJWrZvAJpJpTyuvAFqiTGfPhwfWqvjeg",
		@"UrDvXaFeqFfCacehsZ": @"VDFEoyJiGIXGgdeiXOmlEYqWDUMNDSPlCsszMiPXNBgZYsWprQAoncxjEeHePWnwjgzILjHNYLOJDlWERfesFyFESdTczmbOWNTShkJoDmYpLdktiqezWDEmSrnRTeXrEtdazKvZzqzfwGeuayV",
		@"COEnAqBhUY": @"UIFfsQTtNTGSGahsSMGDGZpCGSAjDBaCaxFjXCcYrdlpDULXfPcjPYQOogGyZMSAFpgbNHdeGvjfzGBdCeQciugmvhlENxDOnbBTDGLVlHOJYcunnMfWHRCuIZNbHhRB",
		@"CxlanmZMmXawgG": @"OeJGYMVUVYjIFHLsyMcFCnhyqHOQoMbqRurMVUDMWvxQJPoQDgwdOwfVehkjqUjkhunbinQshmvxPZyYZlQUboKKlFZMtwWTTxOLVXHdQQEvpdnhFaYOqiJhZeJXeTtATDawcBpFJiAj",
		@"nMkeeXMSefqEk": @"ZsuJNlcvAGlZBzzUscXvzYoLZExWLjLMwLyFTiihjHeFWykMsHkPrWWFMpyzfKrzIETBHuhCODAPZNXjFCUfQpeHoEspRFSalGgHKtNGPLvdXhmODcCKAwCMZiFGLCjqNsJNK",
		@"wtTGaqjdRwCsK": @"WzsAJgiFaOBxRDedXyjQknuMPPabNumCfrRpXPuPHipNWhQzHQSJtlZsvjhtSFrqTAUSPhwUjXoxdyVIifDtYxhrtUCkQhwQStxSEOdXGoQdPefoaoqagDaJnprLVHVJKKMPn",
		@"SPBuqJrXPm": @"uRvpApciyGjZUoRVnqxqvCgGcgfNnlsuDQYBSgunuIxzhmRuKaiCLiWMSmgIQcLXrYeiVzGFTMeGIGuaJkgLQEjILiAaQbbFOshgfroOBXoNfGqoqbCdQcNv",
		@"oIsRJQiXUKPQflge": @"jCLeXgoGcnKVIbanCLcPzjKXKgKNGtbUQWTJdCFuDtjGlYIqyceauuoStLdsNemDjJtUlxHeSZKrABVswfrzsKoFIJJyhaazyhLnuMXjalxIrUUWvqMXdTvkOZvfHEXVeQejgLPKcUyWHtsrLwO",
		@"WtiZJdzevY": @"EXHuMjMRuDRRSbXLMFHhITNbclQBXvzcYMpQxoLTjCnMPYWgqUqfxwfqUdWXkxvbkoZCZOttVTZQhHmlVRqBXqCRDcgTHqFeaRzQcowSEsdSUqTTWCgN",
		@"RxcgQQGoxLY": @"lLSNalfPOVRfgfnPfWUcpeUSBQTuiuMvpgbVAnRqjxOLQDLmKLeXTLgOYoftJZNNxbGmKOaxtsHnVJBWRcKlYjFvvwbvphjJWigjjIqzZXF",
		@"jvxuXgiMxtUkQQxDYu": @"qXVxRpWScEwsfVCTygULsOdlWTNADRKHFwSDIVERbLmKFWQakECuEqRfovmXLPJYaWnyDEqgckrpssdqqrDGwJMcjBrVyHDbKucDvuEFHAcoYda",
	};
	return UkvlrwqvStyvcY;
}

+ (nonnull UIImage *)YsUZdywrXaRgWe :(nonnull NSArray *)xLHDfgWddQlFwv {
	NSData *bflSrXUVaEzgp = [@"okArReOVmEZNTpifmMCpQorEAJkEHpnpkbnZgJgFhMyLiunOCYDZyZtOcHEPzdQfcpQnGcnNxvQNylhPSTGinpcELAPzRbQTuewnCxYHrOXCgSHuMkR" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zxJsarDBKZBHNoKqpK = [UIImage imageWithData:bflSrXUVaEzgp];
	zxJsarDBKZBHNoKqpK = [UIImage imageNamed:@"NmCQrOYMMalFGArLGPreqyoGvYWwfSTexAtUvpJTwfUcIbabjuggOpQbNTtKzpeFGgFdOrQWAVNlrgkIiJYQvmsPUcQJliyAshBoQMdlJKERqzRXfQTOUBKhoMaVtdDSyfYbOLYfVnbhen"];
	return zxJsarDBKZBHNoKqpK;
}

+ (nonnull NSString *)KGFktEOHGUYHgOhmIs :(nonnull NSString *)jJjEqqlERvZcUJyol :(nonnull NSString *)dXRkZZAgRxjpwnmT {
	NSString *IEvaHefsUvFPGFQutl = @"ekISmHemdiPRwgETyjrQEepZYfiUszLLgCdgAmvlRuiITbZxSipdQvBYlJHQHPdCWEaDMXtvaYSbGVTQLcshQTilzSXWDnCCaYVBroEdCNrJKfAZabMtxrqMwyRRIn";
	return IEvaHefsUvFPGFQutl;
}

+ (nonnull NSArray *)VTqcJWiQwkdgadnDIN :(nonnull NSData *)lgJTrMApdL :(nonnull NSString *)pVGRNKIvAft {
	NSArray *qmVcnslEUuK = @[
		@"ZzAWSVtVKcavuVMsxJqFnxDQfowgRWnyWQETsvaVQUlCIqcaeMUDfMJvNUjfmKBygYeddFLFKufOKmgDfpElRNSVyAwaoDinBGkGiwrVlG",
		@"RhvnNcGmeWishrzmNOyALsVLwQcxVgPRkQjrIBOpfALAPmfJnbPhKacVLNMmXqFWFlECvVOhIVlICSSRZHVgASVmBmzEbuIqjswQj",
		@"uvsTZhuTqseuSwgRetNjIAcrkwEwjIFvhKYuXtslONGaBkXEKnKCwhXPlpxAgYjeIeuAGGUqKQgGLFzdTNdmqoRiZMvFRtfTWroetjoZHzamBauFJgJfhxHFJAmQDHUWbNHIkRgtRnmYNJcEL",
		@"SZtRRHzCHTzyoCJrcvTBIcHBtRGwWaXpTcXFOCsPLmGPIgtgQKKfpgPtFJKESncuqcNuAWLjPTDxVuyoEPxVUxquzATYvJYkEWJmDYdERJrXqqHLtJWOZJDNqgYnGYLtXqYkXwZrqWvKkfkM",
		@"TsidLEJUGrGhNVVTbjXbjiAnEeKVTJuhDiAoLzdxGsRyCLeoCSUnrjZPFkhUZrhJLCwrlbImhZbGWWCrGUZvETwkIpPtIFozxzzkSeDKMRHAAKLHCYsfVQSYNylzyfeASYSng",
		@"tIaipqwRMfEQIRGRNdlfZwLKYTOPufGmKEcwdeEzTtFAywdoZwfvPGUNKjoLLsUWBxowitMiYJvqJdmoKjcmoBmBqDFMCPSnUzqQNSsdnAwjwMbccPcqrfTKXtrThTFxAIccwafGdYvsmlFmjz",
		@"dxsMEhNyzuwWhIeQRPxvKTZNomdYEMWRQPYFZsEQOTNINHtSazmGdflJKhemqQVmpKtgGIhcNEGUcFhaFdcYBOLBGEbbpWLxmCLyvMqgfKpuWEukvruXSagNVeBjhQyhLgiFpdbdKxxbMKB",
		@"fpLrURBxaHvmoSkBFMcASLbWfHQncZPMVPRdcSjVNNsvMHwrMBnMdgQEpXZkiqoxWdhNWFSPkvjACqByhEKqayVGDbmVRBXKjoTwYEhSkfDeZcjJa",
		@"JWKtDEshOVOvxEmkSYIQkPnmDGONBCOWoXeTkoljREEfNRRKhjWbgnXxOazPcvDXKfMpKbNrWLCisoUfAJYqMiLkxbxjyrViIdcvJxbAWBso",
		@"bnzverGwzQWUuWJYtBxHcWiKHGhgCbEdGIlOUkFVtFLeQzaKbimRzDQRIisODdLcVYDtXZiNUChPaMfADHRFtAXGVmdBkbOgNGLrOnromOBJLFHRycJOjzoKrMQLSdqHlBgj",
		@"FtAarbFyFblqRpMMAtLZUPRMDjczDdMDIcdiOOHSHDONQOKlYQHFDzIQdAXooVXmNRVISqBniKgpVIMAzNUFbrGiPxIMzVOQoukyXZlxTwwH",
		@"XzCuNxiKrsEtxgzPQQsCFWtKMahBBQkUeOLLlgVpRzRHVjLAkAZwGTktywNiRUnJneQbIzPTuLgAwaumykKUlbEzrpkFDCvqyLKDccNlyqTDOukKsEATYjCceiNmP",
		@"vnjfvrJrMsBxreDujQMTiXEdkiCRMLdJNMUywxaTuzmlMHpLmZEYmUfDGDBSvcYuWqGVNylATAqwQnfluAkvyVOkhYRELSHFNDuuTnfeahtOEcEkQfIQHfzECxVKQTYCMyDgzBWmOQMP",
		@"mgcUvZuAoXrixoTKfzJGTcppGvGPKrGSkuXRCGxaBRunGSbPxghjUCNbuvqWvuWbMOCuzqoAOGzcktsnEbGfIqSgSucTSncgArQpQAmgdqfTKWTirSCYVfutwmJBJBvtdmmODkkKQyaKqXlMZCzi",
		@"EnBVTEumQvoGBadYjZkNQETIEqxCCspxhAAXJKEuCCKncoteMCtmXenyShHdaWWadMbRlYtEmvtcTDTYJVOcMKXEarfOIBtlDzZbfJuiUdzgcNPkTpyvlOcrWkBvftHhyxGXXmzjLPdLkdr",
	];
	return qmVcnslEUuK;
}

- (nonnull NSDictionary *)UzkHAgtPNAXkLlU :(nonnull UIImage *)riQCAcoYvf :(nonnull NSDictionary *)VtEVGhflyfMqm {
	NSDictionary *FOZilZNhMwkSs = @{
		@"YjPBUMlVHAgxeW": @"DTWYIBBbJsjtpCiCfmxfOhanExIgQRqHazCXskVnzrLOdfSFdRKByAkYWRxLPKrZrylkqyNMaYJoYcSJLVmPHthFEFCGEImtejBHdyQqJGAtQuiQAUc",
		@"OZzxPLREFs": @"QXcynajcubspyhemgyfSJKugnkqroClQgkiqoKptXQaxgXZckEsdHCvDNuVKDwlwUUIkLxxbvbmBqhzuZCSZdZZwHoIFCSVEHLrys",
		@"zokLQOGHsXXr": @"cBmotKXAmgexXmCbcxzbNUDIbbRLGmaaBTnenlDIShImINWwfLyaEjFpsdobMNDBqwCkmUaetQMOiWZDtINmZEEIxEoBjVWXUXLHxvYVoEwONMmrKdMX",
		@"ycSmbTYLqwgnVA": @"jrCqRSmArrooLODqRkHSTkEdHMrkqCOKUTrQiIahBPHmOHfexoyqpoloIGnfzfIkQYLuhNdJMOuMZyRNuNPrBtAiSJngPmWMckHaljJmLnhGeiSiJnSqCsKuXjSgeMqnbWDNxhBAyYEIUki",
		@"QGpELLBBOfEqCFFMT": @"zmajLywKpYnuQkHyooqChqGdkhhyFMLHeArBPBAWzysVELKUUHlrlPIpmSAHdXCinniKMgdjesNxeucNAqHisfABhcUOrMgeleCvEhFH",
		@"mwcVDttoENkfrAWSV": @"VCGWjLoErGTOTFDtqvznDryvCRRxoLCJWGllPoRPGVcAIweNYtMicscJwrNMEfTgiLIBoWRfmjjPiGDhkvMqcdCoOZsoSfSemtdQ",
		@"rkDcJaWHuspmAGqv": @"YBMUlKWcwVhFqZSaZOPZCNhkxuzvgGnCjHHIeVEulvUMzCgexQdcGivqtqEzFBnJNRIvpEcmnoPOyRfNmPUQhxeQLvfsYVJiSxqFmIQrJXdStKQMzZCNiZ",
		@"QxOBiAhRjbhJelh": @"mtYjdBBOHXlhwVgShbYGkwGAbSXTtIoElShDqEjQYHiBliZrtfMqZXDtXkKaHXSzAJBULJFfZijZxoOnEioyzaLKXnRxyMhSreWipESsWVLBigNq",
		@"zKlOMtmGvuBoiUlUev": @"IuflfsDRYczoJYRKAyRXWpGqBSJUKuOGNQdhiKqypwyjaxyZmuSHrSvMUkuMqmOTYTFKkxOwnErUpftwlVANgNZQsRdgBQStYTmwL",
		@"ACUBmOUDdSOgWKvYNQ": @"GIpsLIfYDtvSIxJWimbiUNrvBCNQTYMKWZNteuWVOjhqgusRzFEOMhAAVeBFEwDHOzRRxzGtxrRQeCypaISYBFVoUioVvrsXUvhSJebTlRYWjC",
		@"havwtIuqAZiukfdh": @"YLXDZvXSmICrbzTkgcXejSsdjBwBEuUZtTrrhfSWHZQzpsdSQTRTKhvUNjvVvmCmhrjdvLbSgvFCdMxzESglGIFAJoqcyQsuYqNeMctY",
		@"SeaWdpINsoPDTHSwU": @"fBGRsdBrmHMuoklNCkqdGZekkfTdlymZwtcaqZkaRSCwkychxsOAyoOUqQilyGGCvFVocYbmxCggHCNlCRRFWIXBPXoJgCoiRjmrWpwoQIonYGuqCBacLmJodMLEqsRRKphMnKbTkOEIWJk",
		@"LZQszlEQaqbEzduLWAQ": @"SBhdTNTGuZGbTiLcRMdueJTjcUSyOInLYrFZWVwqksxikTiQwYrIkWjbPfyqlxuxFoRrLfDozIXzoWCWkurnpdedEiMgNQKzEYZYNH",
		@"WlsMzqlAmMh": @"COawqYFGJHPOzGcFJHpGTdlkkPoRZfZmZNlEhFBcjshmqPiicACrBAyCwdKEJSgooLjshzKJwBfgyNgpzwFfDwEIsITVQithHWqOnSdPGhjKlAhVoZALmPpLhmorEkXTzOPCHoThPQLSwtXQKMKvI",
		@"JPlmHIbRsqxSPRHK": @"mqOSKOZWGjEqWSImqlXbfaBsezuMtowVmzbgaurrXxdkHZuIiqevpcwwnZrdQGjqfuwRvCpAkVzFciZAzTNKbrOPGjhPtgpVdNlkPpcwPgnmlNLsIkhjjbqSL",
	};
	return FOZilZNhMwkSs;
}

+ (nonnull NSDictionary *)hGXajrgfFwGd :(nonnull NSArray *)EtEvVipzsThJfMkPWh {
	NSDictionary *PiGeeOvuPvmJtZWArn = @{
		@"DpCLqlJIhJdGBDFVL": @"KMYpwmcWHTmgpkfjWxomuZaTWsZJkofrCeTBjrmuqDImNRFiLpHZKXLBUGZAWzQoxwHVnGkwZOydVIZcYcIKnDnqbYGRsVHPsgmamkjjHNVKZGmpo",
		@"XdjHEozGJLFr": @"vFutfRIYVLqueiQPbCwIgWovGLSZUumiGmxmyZESDYylEFXFMdIGcmWsUoBHDUjKhZbnnMZTbNaLkTBlSoMvqSFVCygolFXjOveBcnoMTLaYfhTxYPHkDBlTHTUiTLRjGiJGlyS",
		@"SyRYKgYhdZd": @"JVAqhXDTrZHjmohaAhjuTCONpimHIKWwilLKvGCRWwPDwOdRWgwVjHKtNTdenNqYPbpjjdZlPwqOgLkLhlYbOElDVCgCvivIBZYvHHVoBxDjzlWrHze",
		@"JYUVEiVqJAPpnASPo": @"PsmLfPAWPRdBATCLipJTeGssXnuIXANaimBeDxqzOzZsWQTFlkvehOCPGvPhSMDwYxjydxosWKnylBeYOEjrIvMSspAZBTRvwusFN",
		@"ZEFecFseOGB": @"GeGViwBETFAXuYwKJHwkXuxgdBIGGCTsNUYLoSLnLntWhGbrjWyCioVyFGtwddkYZcrYgYEezOiIeyUlCLoQgWjBzJlbfySTibiEJoSpsMAwjneZ",
		@"yUNmJhLwuobGO": @"vBcWSxsJDyWTRoovEXhVSqOWlnCKuzoamshIpGmDDKidQgjDJBpNyBdQyHHaPdxRBNAYbicFaddETzbjMWZWJiaUBwUvokSNnPMIeYbjIIwpVwrtNpSjzQYJDlYrNWLTOZl",
		@"UaInSwNwCrUqZIRJ": @"ODisGGoQhJpgqQQhkSortSsPonOeteeeWCDoKwvoHDUWnKYDlSrqZFwhncLvzhXJtMnddvTUTvwfKDOUfBaBAdVvTqzWlbXMeCvnVDjGVPZjMdRpRXkDdFLOeVPIRBpRPCHaFZ",
		@"lHZnWuUsVjijimri": @"MXDUQrHQlmDyhcxpJhHFHAvcNVsvdgsBKEiUjKSQMKqToiLzvgprFewpjvUsuyqiFqgMYZyKSyIZMNxyKQYiMSEfecJcVShxMsLImAAYAEQLPNPFyKeLfVfyawGufbgDVGcayvaQGMeTfRDWckl",
		@"gmzUNSuJgLLBQ": @"YQbWKsaVNMTiDbTjaFHkLWvaHYnPIhvpmSkQFAvkQgUOjPUogPsCQqAUzwYYGOqoEYdvzhRIyJwEYabRCyripHyHKoSuxfQLIqBgmGrylBQOKZgjqzIeDBGDIyiYfMkUWJHwwrusKUXcKUNGB",
		@"VTHGNTHeSCvlEfz": @"DRvXUBpCBDkcbXgfctNyMOkeTNqSXlWGUCRONaBCcHGJyzdBKLGaYcwKkRbQvklaHivLNPrsAVFRgfotilKwyglsQtYVPEiiUfwRhbLLaPbkREzZsWGrBTbXFqqpR",
		@"eRUZejRXRzxQlG": @"CbPkXZAtsbmgcmgsPPyrznpUorEvbDpeWtdLVRjAWzOTMhZDTQRCjsTyZRjRyJBfGqguGnjKEpUNNLbfphVCiiIQTNvRsZRfFQPtOnSWUHGDNaUzuFAHKGVfPNzhfPIebUTJsxABqrNej",
		@"atIcTWpsISSNAEdWXv": @"nlZHhYAkgRmPxnJpEiCQKDCZuSmSencCiXyBlKiJoNVrddkBaFBujxDtBQQQMfAUhIilLLsdosnYNLgwqMoDUGgoqlFyJnGDOZtrcUpFaPIAoGnbiJyjNJhUrAkidTbSijZiWGmXRRtXqHQEHxoXQ",
		@"BCKNZQmOqjHhpBuZF": @"EuIKgtTeiiULHnHDOflNuuGGBmMyHFZUogRohbSpVkVinnCYXUKxxnVgbFrCfzKRFVefpFArCvtzKhaEZRHLCBmVLIYeQnogNKACrUVUDWBAcVAbPKYgeZMTqZLkNosWrLYn",
		@"lGxlFjNyEHFPcecpkE": @"HOveVfLObhxqlLmZhxabZxsOvtwMzMNpnOxOEQfFYAlkVLasHldRWCMhHnXIUzldQLjyEavWOXWALFKgasvlABCcozhoGoxHTTalzjpmvIRYSzZWNRaLIWRaVrwiOPcJAPJbeOGgBOzQpU",
		@"ZTMWyVBdUjfWHsEWaw": @"JewGHFHOTqzbgObbBceRKWwgTEyVjsrqjlEaUAoJhVAZIELyEwVnaqTRGDAgoTKQOGvTkeytLOVOBRWyEgdklIWIcDOMJXgoECZkDILAUhwBsnnPyFiKbmkVSLGDaHLJijWEklYmLA",
		@"LdJRxUsYZA": @"ytSZVQuFnyQVwVzxFQLNgwwZVvpvzPDeXXMinqxfKlauwoGyDKjAkWNmpgRLKnTEiGFLaglhOaGvHllSXxnZvhzeWMFPpBtDpYCcOtsTNYAqjxpvrRLLCxzFTosKJfwFzLvUxrJOFgWB",
		@"ojJfSyqDJG": @"pUZvcltKLrjRxNRVMrqUVCCJjjjQMukeFVdclTXWzcyJDaKBbYWbyHtfnpMcswzybGNptemFDzlFEVzNyYyRMBiobOhOBHCpjpquvQsrPDyoSFVtmMBADOYkMwpjDiJUnspPLmSELP",
	};
	return PiGeeOvuPvmJtZWArn;
}

+ (nonnull NSArray *)KQEtkTGTVhXVikFo :(nonnull NSString *)MfyCFdhnEwTALtUlLM :(nonnull UIImage *)pyvvmfPTsZMbXr :(nonnull NSArray *)gzemdlHiZDHWZK {
	NSArray *StgUNPZmDaf = @[
		@"cfkJMlffLDUIGyJukeFUemVOoxfWdemLCxiJLFRRtOHFtPoeNizDTXDktdnwYDMqiQlqinMRJwJtIVyzHlHqAODVoSkqzAAzZREMrungIqeACjSMCJXUjoksmhJWlIsqQCQRar",
		@"sZAsCGiEwQxstCiShJzrzWkXwVXFJLmGjbhXzsXWjjvPjFwBZjRaDagEiDGCRcYeqbhfGPViwIlIyljZzXxavMfYUSJpnStzQWYsIApRaitVYoNTasVKGFxNxgDjqBFwmoIodXSiGDouKCX",
		@"FIGSGaCUuHNIBzmJWtQhoiWkAcopjpMBWLQDIVFzvWqwQqGcNsTTfVcuYPSnnRetSTyphBXqCppkcfwkVHltRsvCXCkEGXeOnTBXSqAJeADWheJpykwyPPBglomFiLnGpHJUVfjdRHaSFzQKvWpE",
		@"xnWnQAMzvLHsksxsTZqwgoUUXNJrYWNvHwKIbZRdvPQmhGfCZtWccMgQjZkbFZNvLowxgzecTNdYuzPgiPVHZhtABERPXmzcEZgCHgQNgHkxhpoxsLi",
		@"vOJVtLKFPNMrtJACSyGQUyaBMmfwcjHGqWrbMTWxljhahDNUaAmVNfCEUcwClaizugkkvcZIeCaePYkxFTlEfLxStNcvldVbavFoMArIiAoBisZ",
		@"BbLXEenzoFmgMwkWuUPtTMeWhAvCJTTEvGWxxDQOumDsPNECmOGIlFTiGOwPQfpDxTFfZMnTQjnCWQorXtEgpPYafaAgNnIydFkiyNHNpOitdubKotqdxjbi",
		@"FOOdigCQiLyIQXvmlTnIiZCgqDgxbwtxEgRoLoqxyMhTXMrdPcyEcnCdoITZFHwFXdgemjJSWsiCplAQAuLNLwaMABjAwVFpavgiDqkgYYrwDRrTeJf",
		@"bYqEFsUsatazGkRatGWPsNMfTlOYGxYiPQjEqbdPgDpkWrJYSNXSxSUEuNWbJaapggEXZZUzsrSpMZzUUKWNzfcKDBOnZVDFwWRxVDuPwkjTrpFKqBcTNNxMZTRGkwUXZQUhtubrIivgCtjVL",
		@"nLjKWzGUvTstMVHCfNLdOMdzlwhaYLnniiqaMYSnkXtOLqSZQpTUBPCUSZYSuovHhaNTMphKyYgcFKzyRtVcQJnmLLnuFIHDaLeVliXimgRnzUQlwpIldBdOroaTCLyabjURWzSLrWjHlX",
		@"UsXmFtoVXdsjMXxFoVIPVugFsTzMvcNETCblZqNoRFvBpcFcDwxBeUjfYAMdEDUATbHjYBAkSpBvBUqtRIAzALGyTDHZMMbmDhLdPjGOeLzHheNfATWrDYYdvpQRvttesdnWVqVkMmLE",
		@"XzaPfGkBOmZSAzgLvTKMCBDEezaWhbOfXhJvSRcUIkAjGtQlqshQayWcvdJMXaewQtIRoCrsdsTsQXeeXqngXpzPmulSHaOlxKVVIExYohSHwvY",
		@"IiNBxpHDJWVWeYRwfVSYopSiDJNYtMoyelztFUthBrwxypIFLYSEjtxSxlliJLbRnGVIEhiJqZOoQUnScsorilbHsYnmBFofdrnclOOakuKSvsisCWqjdXNUNtGIKoTLOHFBWwTnPYzyplrYto",
		@"dnWIKkANrpXCADvnXMsbAipbsOOLidUWYvgPdKGPqhPZvDHhSvDgRrpbiRVMoBaZQmLDNMMGwUiIvojnjqfqFTjTBXqPGlKPQhAiWTtcnctftAgvXGZwXCvyySOcoBKJLZ",
		@"WJRdedtaVeCkNiOvxwTJMctEfeTTRNjrWnBYbmNtzLywgwayzXprhAbOBgMulCdIdnfWRRsJRNCtZBXDQQJlQyzuYJDJhslrqdtTkvzGmcCyrFNYcEfJkdvMnhQlSppNl",
		@"mMZlyoqGyZEaFBAGnMKmdglQTtAQpihkRwlXcWXlXUjKwvsQQKFKgWrfgRRWAVDNuZDCnSEvbPLgBeULRPtFsiIftFAWMrxPBzcITknWjUDcO",
		@"XRRPtAfKHSBAACghrFpbGiSDhzGXDBQQPrOHAouddqTyrztfCLnHvkaTupSyFljzRLZGpbOQBKiwrJBLJNRswPILwRNwgQGVyjXZHwnLHKISrRGqFqlCcHnYGenftmZiDZpinh",
		@"nTOqSXvTmLQbTyNSMgfhLIfTwsJhDKNjOYtzDCjyJCdXkbNhJahHoFZIVNjtmFxXjvimQNRMoEJSHhgrvYqoWBHkXLeVJoZcQXKEjcXsSTMDQbvUncWxhwBvotybUhXsQKDq",
		@"vAwStFJZHfBgNaEVNbpffcuClBkYSxTepcslNtbLAAnhuGqiXudfENZSQCvCUHLvbTZztpkQEsKbQZtDKTufCgfECQLsEavepNFMyyYkcsQpULNzfqkMzkjaGyUdbPvAZiWdjMZZ",
		@"cnUtOrymnfrYhRVGWncyvKwJhmjgqCiYkbbPgVRIrmlzvzTZJomPLREEkpaPegGyVWPtdGoLsQAwmPjEVnqiutehfGhAyXDIGNpavPTxmxIihDjuxyTcPOBupLVWUnaK",
	];
	return StgUNPZmDaf;
}

+ (nonnull NSDictionary *)WjaxergOswRekz :(nonnull UIImage *)qhaWiGGXADy :(nonnull UIImage *)ZIzwuoIweJYjKkIHO :(nonnull UIImage *)mXiVrPptyseNb {
	NSDictionary *NQVYpxEnpXY = @{
		@"ctDkrIUhczRzMdt": @"vqiPwHHZPDMCOfqbzqyqKnNuBFAZhmnrcRUJEDOLnNkWzsoqFEmiraxZfEdgXnTYxYhGXfeVTcMDlPcImQRzXgYyJdaUoqHuYkvkxClBBz",
		@"rNUxqXitry": @"xrcTGxgbiWMQloAtXdmqwpMqIOavjqjRtbAmzrayZvEAwITuvsVhsGCAjZWMypTbpapkapxvPhBxeiyXdyxNnGbaYoKrVmKLDWqTxSvsnMBPCiVl",
		@"ImpKpUlUrhHVolxjtuO": @"qLvjqBcXaxSbtTegZmjizOLeTvHbbHvXyTOhVssqtilCrpmPLVerkLmVPzMpUbvQfPvVWHoOvJrxnMjRPWaBLSmWERBVabsDAKVQmFnuMexUhIhICIxYtwmkjHTUIzDgaUGISlhbeTLaTpf",
		@"miiwBuXNFQiHJqVLXmi": @"vffKgCfppaWdmVFpmdYhZspciyRdtRgdezygZnyjZvWxzMuDMpIITOIgHaxHNiNBfOzfnMgTjGpJZaxyzCfnkDONKzebVacjEfBOqSVKRvaonzqREbjqFFTanywkhjwJpdzZCvSWw",
		@"WJsXijNsKRrfMbURKD": @"IROqckeXTsrGrajTnOaCaoRYHSDepKAIWavSHsbDgxzIBSSoZHycHKQszCTxJAVYKDItuOFbsGFvpBhEmgMIkcVayUvaaZzydLgNsxlIWXhAFJEYPLJkJybphg",
		@"smibIleKVZM": @"VCqUEbsFVCBuUerQQthixhiGHzOmHiYzqKqijTGhUhOCaUQmLBUiMgroJaXcuKTfuhnzJpGRBStYYxCabzgqQNJKyiVsIzdBbLRaYVgMkTkmloSaKdUTbIrTBsGCAhU",
		@"HjcQHIXCZJ": @"PTgFnjEOyPxIBFhcULDPorcnzoGmnWHJwiWcEilcewqaPsFgxvIHVcjjBlnjlUHgpkttiOTKXACcqOHfWWZtxZGzCNryYGvuyOBAPzF",
		@"BOVMWRAGYEtDffVt": @"tTibtsGMfFRYFdGmSUFUotuNkZSZKJzTUTVeTfrpgqdXbzOApwFYuavaClhWNviZUwAvEOcPiWoxAEOFsVnQPvhGSQRYMvJvFkjyvYHQSiUiUmOvsiwqsPhsyKf",
		@"ZLQIPWYjDKQ": @"TyNfrAjpwGlfacrUTzrHDVzqVxCGHhGxDsQukVmNEEgdPmusFMWuoAnIsPrglRilNXJnmkMoqOMJvbzSHCxFavqxVSXPEprFnrKDCdbbpngDypywdwUcUIekUxlfHzlsNaZNI",
		@"qqzXiVjOnfWlmKckvRS": @"nscLtTUPqeAqLFsltRVFWyyUJvBLdDUYDXgFtQvZZjGIcCuvmwtVGRwBmhPBQkDIliJCmUoHUDKyULnbBagucLTiEdIiXcVkBTGgbxCLkgXuaf",
		@"bAieWNRNIc": @"hanUxCTdLzHKXxpXEJqvuYgXcJvpkmRpspEkPHdYyZmilQXYeDsOeXdSKNTpCkQNFfLgvVtlplJZjrJitfVQVyoPcIEUvbTVynPgCGxwYgGHbAAwDdoLlqSLbIzWDPzOFiJeFlnwQtggridywYBjs",
		@"JzPjmqIVkJGAOhJYqb": @"dIQILeOQSDoQSzrrmNlsShmsBHkpfpNZjmZHAmbvwEXVtahPcEFODNuegKDDdOmcpfaaQEsJkyoNaTyUojuhRLsvYvbhWgMXNAmzMmEgooCHgXcTCWbyjmAJ",
		@"fjHkBCOesibLC": @"FvMZvtDtHvPxjSBOmloLfZUMinfGwRMJJAKGPCCGqizrHiwmUayVKDrtozKYWKcBWPymopUroIJWJyqjYXyAaRrHtrjDzjdVeVwtVDwwQtpVQGNYUvPxMrAnDFWzwrYhoYDrTgTWj",
		@"FLeBomYrWVAZMnnfjom": @"TxTcTqeXaXmXVRQkRcoCGSSjTFVBZJEdiHKIqIXjXQFKIrBOMuYMCuBJHzBFNgOfdVYLWjmOAUCGukJOxFWNsidzwYGLbJfLcJdmxoejCrtQuKLLImSNUHljxkLRbHbl",
		@"carnLFhRxuxixk": @"UXtHmQyIoHPiwUlhBUnaDaYmXqVdDUYbXYmpkESWgFtHivUeTYGYrRgocftoopbxotyMdMOyxdPQvCIIZdjlgIRJSQkjFmdCYcSqmJLfmtpeoADKxPagTUqoaAohDwkyvSuPDvPhImtfsQYJg",
		@"mpRexdZPzikqQI": @"dztUDkFXsjeYgrBvTtmFssUOwjEHivFJgiROaKCCdQiRtvBwMVLCgQuSvpzRCeyWMyNzvKsEcslnDwtXgEVXAlrZkBQbVUhtYnxUNEsXGlQDshnrwKsTixQsGyGCZ",
	};
	return NQVYpxEnpXY;
}

- (nonnull NSString *)CLHgWiPtXh :(nonnull NSArray *)TsItUKpHQUsQDwWS :(nonnull NSData *)vXPIBOhcYtKzktxIv :(nonnull NSData *)nfyyYjibJlwYd {
	NSString *VCHHmMAyVjsyu = @"xozGytYfYiQkWyQbNgAtbHQrJFxhmjaasPYnXchfnHHrexViEsbZXCfCTsQOyqQAygOXMuCMIAnsbLluNXlDCDeZmPofGKAkrARZWtTcspbPhsaAkpPptAsiVbOCTGYqgtSIrPgjnSzb";
	return VCHHmMAyVjsyu;
}

- (nonnull UIImage *)rZUVeTQzrcvoN :(nonnull UIImage *)lfPfejNdeOkxfvBGOvX :(nonnull NSData *)RLMrwZvckM :(nonnull NSArray *)bVwLAacdisB {
	NSData *KOFZMfGZMJeu = [@"bWuvQpLLFGDJlIoPIDuLyVDWzOwTPHeSImGecVaeQbuUEesKKUAwgnAQgTizHPEEbXNgEntQBEMJhrRPheQzcsbOtlhchJYqDeqJlqNuFBkPyFSn" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *QbhddulbQjOmg = [UIImage imageWithData:KOFZMfGZMJeu];
	QbhddulbQjOmg = [UIImage imageNamed:@"OwBtSjqDnRFuCMITWXfcAXQTSslYZPWhaChmZvmBLkcMEuLHOofbqCuNeWYaesjZQwLlVuOeWEUmceHFayGxPgLlCTelLHhXEcUiIpQtmDw"];
	return QbhddulbQjOmg;
}

+ (nonnull NSArray *)nSDKcdQGifadMyFaS :(nonnull NSData *)fWATdCSzrKslGvUdfz :(nonnull NSData *)LDHBVCXRABoJ :(nonnull NSString *)YzNceNpxXKPrreIcHm {
	NSArray *PYydUfEJEjLrBFuoA = @[
		@"qZYmDpSMlDycZwikgvitffFDFkcZIeECKPbMyrTLGjcTpgvpgHSWjptXaOTXeNduhhlrpxpVjsnTMNRmrluETQzAEyhDuXPSNSyrdSiWQWzvfzxzeIFFYUFdFyLduI",
		@"EQjXeCztlMGBzmxHFbIspRkQKpMkLdaSOhVqVbuuHakjnsxkmvxCXfkqmjTvKjcPfKYXHJlQpbhPVTXqpnaiiHTcciKNIMZKOonQ",
		@"cDJrhmBkNrbomADbsFZdIXpGJqHdmyEGQAIcIznyGOvpCcCBShMBCxnrutMcBVDVQHrKyAKfAczehpKsMbsBnvQnueENTvIFcgKHPBLbkVwSapsawV",
		@"RfyBEkGMVVbObctrkdCVpJTSaHZHgHqeWCJVNsZukjWqnjNEWcqtMppDBqDUnFEJchDBQWETZvQpqKDpjcKtHOqqtNOBWIKEaVkqkyPhEgfTAWJJDjPBvDgzg",
		@"KPPMkAFSoqFkhStaXaryyTpuoYRFGdSptjZCkZhinTQJKScrMVMfLoRCrcDnpNaRPAoHMBFQQZZJNAPlMaXvuSJUwhcktKzjYDEKEAbPbBOtxM",
		@"xuXlqituadnWtItDxnPqoGCxmLPpusljYTYntQzNapnFkUHKdgsnLJGeMYaFKlHDbrwACazeBylGTyMQxitLgKslKzzOunyZlTkLbScUyApSf",
		@"zPlUrVmPXxiaOEvoKzBGPpmFeznMdpSPvbGmjRIbVgdxOnjWpPaXFntOLyxXouqczXolfyDEnyEwRaHPUjtMQCEbBljMfqxnfzCwaBmYVUpxaiIBtxsRiebMgBGvOYphabMkHNv",
		@"PObQjapXHNsnXhyAsDmnUtycHHnkTIpCYbnGnUUyZSQxzseSaUoaxEHoRftVaXEgapPUeHMuYaLfVncmTVPIokCqrrrjRCffacIruFNlrBkVhTnhSMPfyMJNTztZtczekTXVTDnsIuP",
		@"MGFDUyoCRUBJCikoNOtsLFsSImzSPeoqpowizSbVAdpCSrLakkDZUKBKbXeDMgQWpKvuWAwFsTueeaTDMlOMUflrzGSrZUrWiByDNextJVdoXWm",
		@"DACOCoeuCdLfmhxGKDahpYgWUWZVPwHAwusmwnHLCptUjBrhpkqmQGIUPdzJAcLFUFVSdyVhlYcbUZPJDGJmRCnQxUQfdpxnCfmdCpMHVIGLJGtEUzoBxHopedTKiICJgbMbmAqHAlFYns",
		@"aGBStCjwKlKqmKZDfsgazzbesvfVITsSgeLkyELssfchGePYFoUhxgOrOnerfVXxjoDYUamXjsKSNFBTDmiYlodZcmWrJjqumqmsxESRqU",
		@"tfnkESoYtZXVQFbewYjCpLCYvYXGMAxrIGzFaWkYQUPUoYzLAzGUUxxMFLXiMBvwTAvxaoTxdbftNimkEzKIOdatmNhYWGGrRVHADJbXcKqohzWXRzrXlCxdKYWgVjUUsO",
	];
	return PYydUfEJEjLrBFuoA;
}

+ (nonnull NSData *)twRwczdeAVIHXgiur :(nonnull NSString *)AFswlxKxxw :(nonnull NSData *)MpnUxcuFfbHECQpFVpq :(nonnull NSDictionary *)PVEZsDkmrKPrVd {
	NSData *cioLGhBlcHyQPHCveb = [@"heQPNkFjurDxucTeMQzxRuBMwWnEjjBYVtYfTNXuMPdGFVVPqEauGvNHgMdNvAkrYmIRKmfTFehuKmmxtxOulsTZKKuEFPGshtRsMMiFBKBySDJkJWRloyUCpa" dataUsingEncoding:NSUTF8StringEncoding];
	return cioLGhBlcHyQPHCveb;
}

- (nonnull UIImage *)HfnXQDCKxdvlZUF :(nonnull NSDictionary *)YNgercTlboHwvqV :(nonnull NSArray *)QzDQidNkFj {
	NSData *PDLMioxJnGmkkZAj = [@"zjoXtpbvQagjibZvhbcOnOdSkahXktigztgjObSYSTOTGuwkoXglACDLGkJKRATaIacvEOOuJxfRFotjhrFleGcCaNTztWKPqylwaYKqQa" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *mWZPRbcodBQ = [UIImage imageWithData:PDLMioxJnGmkkZAj];
	mWZPRbcodBQ = [UIImage imageNamed:@"OUbWfqezZZYThfOVdWxhgyXtFbSNTjoCHdjefeKEQOGxVqUsUJursUwqjKCAukQmeIMXnpJhqntNHvcnbnKZfiRJPoOGsEilXLXemTYWaTtIiNrOBnxLBbmKxblUiLWWUcBcrneGysDBoIbjMX"];
	return mWZPRbcodBQ;
}

+ (nonnull NSDictionary *)xjmbkQnbfELVdGm :(nonnull NSString *)dZRXBDKnfHGtLmP :(nonnull NSArray *)idtJDFlZSCNWYieuxu {
	NSDictionary *MjezFAAGPpkWsvqY = @{
		@"OicUvpxLfcgaxIOu": @"lMhPTahqROOVhwpEkJSGDhiKDNeACyjoQUTghwJFKYViIRAEKrfeuyWoIgPvNAOQSNKWqTOfepEpzlooAOTZQQuObhBznjOqzsMQEuWIdyuGLlAIVDCiaux",
		@"CqQJGdZggrLVMYOXf": @"OZsWEjCRTwRCIKJtmyWaigAIcrsjEVLUUaXbUHlMXKVjiXjYGVFHHUYOapfhqRvsDtgcSTbsdvsMZJktQmThquntDLKZehHbvXamMSOXlUcUhCwz",
		@"fFeNmyhooGnLPlv": @"OMLHtFqjlfJxGJkXnzwAejIWvDQrOPgFnSFGJimEnaBQgdrMViwqEqNouVlmDyYUcKCwDuoiUwwKUOyoRGGahejYPwdWLKrniBWLjYRuPFHKVgWFpsYBUzznpKGMdnkCPSNguZHVNWObevc",
		@"RNAqndLePltyqJzNFFs": @"uVrErVbVSEmfuwVqUJCcwtbjGItaKTmkXOJLyoLcMPuRKndQakXlrLOXHgFrmSdhyUECoCBgPhbbZfeignfakEFykmgVBiJFBnDgRQzMnojGL",
		@"uKcJMxBzWpQybLEWI": @"fYBvdEaDnfhtxQPmiJypMAvySeLdFNCIvXoxbMBqOYCBNIemNKHkCANraSeFBydQUXIbJIPiCZSGTnLRPtoySWstkSkaTDzTXbyoZNIKB",
		@"jXYNiXAyjYXwrYdH": @"TNLepYIJvuekiSEdYfKeissRIHnjDhgqlPsAQiLVodqBfLbdUNhxFWFzdFkNPRdLSdVFmmOcrnthJcpyLPxhiwISUcaPFBbPEEUPgNdvlzNLLvrnNRJUgLGqKFoFbjfUHZVkGks",
		@"DnhYjOvpCymRiPgUL": @"EeOEvvASLSpvYtqHSFZffvZEXVtkuVQLkrAkLuluTAMasSSamLOCCvNktFlfhutHatGrjmBHPDqcKlCrzEXhMyEuEtWytiLrykhmxyRtQYwobdkQpOQQAzxmFdOfpRvKHZBgAL",
		@"wLezjOwihMJPnXquedX": @"pTVIhHgoKXYumKZjylFfxQsLPfAimFlbAMtnpUVgGRfCYkctggcdfVaUUlTxBafbPyXvUVcnBAuORlOzIgUVVhIAKtrJgZnnGpZyOwvkOanngKQHAZXNCcFiFjvSZRaKpEmNOQJxdjN",
		@"VvPefDKeBtcAvlg": @"GTOIGYeErVQCdxVqfzWXfJnhiCaTODJzDFQieIxQggqorlDQrvMsAFCWbcmsHgdxJdNfAWOCOdZqlCTxnFDGGfjLJMndrwODJyXhjrcJIhCuaej",
		@"SrTjFcoOsEgOFkfEfH": @"fpoLAgZgLwKdDOeMJOKfczZUZqgRkrlsBvxNnKvjDWjnkUrawZRwUbrkjatnfuJJHrgdHJuHWiEkvidKKzmGEKPGSrhcWjxWTgGwRbdeSUDYTXfRbuIDlddhnyaUINZlGGyQzWRtuUIpVqQuBLe",
	};
	return MjezFAAGPpkWsvqY;
}

+ (nonnull NSArray *)SZeekajzdCuOCMiyJbe :(nonnull NSString *)FLRhcipnepgIVchT {
	NSArray *jKAvPkBJeDamXzC = @[
		@"YRSHWtIjYoZquAFKJBIXMEGMQzDJtPLqKDJvJVJKXLTGMsMDUaVSIlwpVBbRzIprlYiIJaNyHWGsdPYVijdhxOzkshsfvGJrtseuVHvhoUpyRdWXPUVgnbUqvfOhKEfCvbEfFEkuu",
		@"XGjiLtuoldOZzsMJmcHrgHphlTeVPEDKpPlARXfeoOpNcjkOMJAglIfLhNEObymPioXaMIwILJgAMAUUKrrhqJRecZdZUKlVlFzsZIklOqkcIIlOAVqJmVBeLVVTkrVt",
		@"PxaJPYaZqlvpphqSeCRqMstRYdbfymKdexcGpkppwIEMNjPqbeCRmnNejypunRRnrMcPXSIosYkZMnoRlHSBXrAjzlisjbrUjRvtXnkDsaFODNQRfZxRVn",
		@"ALrwYSgEzTROWacAgyggMooXWzDhiCLBWtgMONxyGPyETgRbIYaHSaoHHMwyBqfmSpTFhyRcxUnpdLmakqbYNSfAMBVrzSfyWIzyrngOcOqSzrLXJMpHIMnjxopOCKFWuwseLVzozfbQmzMtWzxFE",
		@"NFpllZbvPIhhIgKJYjkxipZjcFIpijAgbVEmNhFvqacKDeVMKnmcsFBqSSZJaWrbZyyCFdYzNPlBNiZuMmQapMDIyNasdUkltTRpiaxnknvUwtvHxdhThWDC",
		@"CMbqLCYDmwvyaTZZRKTnvTOxkyHursKAXFWuNKofEYbWhuVURdAdmUdPYNaPyafDWuQmPIdsUWMZjiaLxinffQhCsHUpBWQyefMSxVawKmQmksfXuUhdGNt",
		@"aINlqnmoZiIOENcChvfVzodXZFUodGOTvTXEeZqZrIylPWhhxwmXbRuVGHlntnalcZzYCETHnbBkcafPZunTVMCcrhNxGrVmKKfyUxmFVIgYPbxCkEsJzvdSjwSlqzCrfwxdQdcswabkfmaun",
		@"BstEIBYKfeVgTGgkJZdjXqZQYiRHcGXkRtdHJXGvYBNyYVcnbDxuDrdmErlMculgHoZLvDGrNtFRuyXHWVrnkKJjDwwypUdaYPzkjSGSgfRKL",
		@"pttvXUpIgErMJLAYRWiNBLVezjxfYOWQQrERCIWRmcRxpvCouOAAEcXUDlwJYQlWwVwOnoqYrhtWnemWGVDsQDOrUxzUUAuxJsrHbjFnKeuqGYOtEMWnwHAlPhdLKHjNYWiVPtOUQHGeUIoO",
		@"lpHHqRydthotvsIMwAkcWvIrtOsHQLnAiBdOtoGOyQpPvOnKmAVKcboyxUSrvzOoZBzauHyKcfCeuLnhoNXmuZOOfZTIcirlELpsbUxSsWAdnsYYLDZiglUHzxNBnaubwBRDEPbiyxIc",
		@"eTIryeylxlsLCIuQgRRBvXWiPJLXfhiObVZmXMNddoohMDDOgiQgedZMbrHdVsUPPhXyKhAWnkFwBuxdKqvfRMtKmlPdsmzurvHGihyneSaKc",
		@"VScoQvtpFIuZGErEYnVnVRPqUMldQlvMYQoJVeXLNvksAhZmGbbdQnzbMWLMjKIFlVEjZixwdQRlLDhxjlDEzTOcYWeJATtuAguvleEIBHebjsNgJaEzxeRci",
		@"hanXwKEXxxhUwsVPMTKXhHFDfdOfQDKGSxOkANOQgdQIWiCjTdjqSZtwkadFoSkXbeVPqWBgRkmvTkFHNRHMRvUWiIxnOcKmaoKVtPHjCUhYbWOpSBfRpuGqwIFyXpCNgNIfxmbnzmmyrP",
		@"gfOzVOHCCGyeLOeunDACwLoDnHPwNBpBfjWkuCucRgbvXeuKwlROAgOJLNImmexWaJHZkDTWxVVAsMmUkfeEzrPwLndFcYVRmEaZmwXzi",
		@"ZKtcgyxjqZmIfAtfxwncvdHCRdJRlCCIHrlzvCGiLDLQHXTgULyztaLAkJEpoVqBfHJPnoflShfgQPohCINosWExGvJllqlPChomJFLhFeZlt",
		@"FwcqrsQgphquaPXbgukQckJgKmJyrLsRCphPJKviUhMfeaDFszlmrKvMcgIouREYFXNmwKGoIBbLyIGxmgcKNxqLHykjgTRolOoumaUYveqanofEsLEvKkusmKrvDbZYUTwSKsOoMFClNHUkhpZVx",
		@"ZWzRExjyhxUMYYKxDfCaHnWSpTRUoGZbgoCQrgpJHmeAtzzIwzWEKSCrGtikhDVNvqCSGpVihVGUFaLNMcSBADgwEssrSZcmMlsdvjQHjCDnCgucMvTGBdmibFYMT",
	];
	return jKAvPkBJeDamXzC;
}

+ (nonnull NSString *)fEUNLBYhrR :(nonnull NSString *)PUxPjzhDuSvQCWq :(nonnull NSString *)JZOaRCykbcGIPI {
	NSString *ClzFKjmizhjSMwsm = @"cowUXJjoFoGnBoVmCZLJJEvBvEdWZwsGzKRQPxPnKskJQTZAkfyddPadfCoKbfiubUsueuJJSltnyrpLDCNpeYFjCbOqNNJRKJkmUwbZWXltLHjXFqypgXEfVhxmJWRRowNlmcfHbJpCNCFWn";
	return ClzFKjmizhjSMwsm;
}

+ (nonnull UIImage *)brmGITUyyYwKHCWmiX :(nonnull NSArray *)CQAEDDWhmNldYFL {
	NSData *jYncxzhfMyRvWHW = [@"zUMYkfHqUfwUknIEwevNquSYbAGqIwweXYjtssRDzxSlgCyuHLmrqOshHWcPLACEJvclvCKDoiDrEKBarTMoeENqUnmpFYHqQjpPMruBgcJUxMRTVLeGSypgzSFQTbkCdIvturRFGuhr" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *GDKAhnoRHjXqY = [UIImage imageWithData:jYncxzhfMyRvWHW];
	GDKAhnoRHjXqY = [UIImage imageNamed:@"USzwXDctVOxVRkrNkPnnqIbdxCDHEpggPgSNwOaciLiDtbkSlWHWUGKMdYpmXnTjmTdBmglxUThBiSPEWKLOuADZATyWeTxKAiknOmVTcqGnxOFCHOSDIKIpqGaP"];
	return GDKAhnoRHjXqY;
}

- (nonnull UIImage *)LDKiOLvSVYylbMzMyJ :(nonnull NSData *)kLdfkpjlNaat :(nonnull NSString *)MRnknYbJzTetlGVRx :(nonnull UIImage *)IoAvPvpUiLhbqNJQa {
	NSData *umJSxffHYm = [@"FLhnnIuCUXBmVjscQnpgMyRKgFieoJiMPrWJGJpNxHLHzQecNrzTXZqGqDoxjoBrGGwFdjFBbSSBKoQotyEkzMfhubSaiRGLJKVxQVwWufiTCusOaXfRWDVXfyTYBWerLdYPimIXISlYPqILZI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *lIeounUNSFP = [UIImage imageWithData:umJSxffHYm];
	lIeounUNSFP = [UIImage imageNamed:@"LjOUptLjZPCumLJKgiOdRpjRVTYKTheSeXmYwBUCyEbegAEQezmQuBzTTDvuPquDBfzaTzfULkogTkpbtxctGPmHYRdQWdnNAHqFXSSEwAzvKujxHMtgiZrfGTjzVWWNlBCFYhoIfjPEwGkAM"];
	return lIeounUNSFP;
}

- (nonnull UIImage *)OSefZMUEUAlZUr :(nonnull UIImage *)hncTBTZtksmmTXQc :(nonnull NSData *)RPqmWYEjyd :(nonnull NSData *)KJszFlmmEJ {
	NSData *ejOOgetkbLszKxyCH = [@"DYDDuMmmJncrUUMbizpLVUvCAzaCYdRZpfMEwZNdGqmEadsnYGOCGWQFPjTvSfxvvSEcZvQrXsOPWWTnuRUzHptOpqtyLsSRwgJo" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *HNhulqeRCOXBlwJQNGP = [UIImage imageWithData:ejOOgetkbLszKxyCH];
	HNhulqeRCOXBlwJQNGP = [UIImage imageNamed:@"xHXPsZSvsFoZpIBdLzkOvePQGPYJXdBLaerEHGtWcmXqnCAFAVeeGiTpHhtjAoWapJbdzVCPiQZcSvRmiGCtCGeWwRgwBDtFWGkGFpLWsJhiddZYnFfCRcwJBoNHWCkWIDXrjDMAzVmaPAMdrOSY"];
	return HNhulqeRCOXBlwJQNGP;
}

- (nonnull UIImage *)HCvDqSMrGdbGXuiE :(nonnull NSString *)webWXKtGuUNobaiddi :(nonnull UIImage *)CYYSEsKjbvvT :(nonnull NSArray *)BvNitgJnBDpW {
	NSData *otTEUoRqoPWVcaY = [@"srKzjArObLLspdAUiNuCRHNArMvqStExmMaEbHtoXndNySsefDzFHRyPpIIbhiDPbZyIqnTYRtDoPCnQkQCjvQKgGJAIueZsSQFiBhFtyjgzXBbD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *IQjaukPfBNEWtcj = [UIImage imageWithData:otTEUoRqoPWVcaY];
	IQjaukPfBNEWtcj = [UIImage imageNamed:@"OvOqztYQqaTiMOmBqMLXciPYvQppjahFSackasPIEFZECeHjUJRvazRIJYBfPEPZKWlSZlWIfgpVXnBtGkwiTyOeHbZfZLMxrqyDWW"];
	return IQjaukPfBNEWtcj;
}

- (nonnull NSDictionary *)KqdGroyiEmOHrkkGRZp :(nonnull NSData *)HEWGnWGkAOWNtzKNoF {
	NSDictionary *JKllOspWZopGCnmphqE = @{
		@"unfRmLbksSuFXjN": @"XsJmypiUcpNoUXFuIJZdncmAsxDTFEDqVJUmzGuBVaNvCVPWlxBPXDPqYqhMkxUDPUQaaSTOZRBvGumxZeuaJhdmiRkskdZVBernogWabbxsIwQgjZgKaYucrn",
		@"KaGHhQWILsGi": @"DxzalgTPuKNxBfxPpGpacJSGerZkmmSWmVgcYCutJTIKvbcriMHJnNhzYgezeNlpHoYDAkhfMfTRtCPiwMfZkPLMBTGLJyODIJFlBzrQFyTJBuNsYHqduFxTRDZzWmdsXKIFlNiTO",
		@"TIFpHrRDhYqqavL": @"tDKNmTCCZnqvpvYZFFvwGZfUwpuCzTLguOVMqIdpGtaNJeDhnzOCNJthhieJJtUHWqjzxRLmVgxyMDUjkJhGUcMMMjoXqoNkxRyIQFXGIwGvqfwghPfe",
		@"MsLOfbbhNFWKYFcFNR": @"xueGLfyfSbTbvGaZVIlfISzabZRikosaSIKhCsIMFiHbfFMCvvpnbyFONWsHkKULNejRQpogAnwwawCtknBsPiKcnHQuQsFzospdUsFSGeDOyLQdaSapMOhCQRHgRbuNtctZlid",
		@"xkLwTrSAlHCEdky": @"KsVFWFfUwGbkhFyGnogHsVJAHpBLUWEjllqCPngBsgNoSmhsFPNpeIhZzXbUjCcXBRBJZProilHjyKfqzUSpTsbegJbsUoshcghHwlYGjgffGiqtUsVnFKJJYXqEkdtUxfRtefCYiQLs",
		@"atOFjQsyCTKTykUcP": @"bWOZVOEAUxKfyMlunYXRkwMESEcWnPseqHttRwTyRqNMKpQkTtfJbJUcFdBZzrFzBoSZTURihMHRyCKpTKCMolWzjKAYLYAhVWlObQFO",
		@"yrSBQwyyqm": @"GLIJnHeBjHhTXodAUNfSwLWYyAPrgMTcMsJCDTtokhzxhYXuxoVtiAWJsTJvvEcOuFFeMHjfPfzcobBpIQBzBuunROhzdpjFHZFjxiJhffyCjVBPZkuaLIWbVeUbPDtouNryHraKutjKLt",
		@"LtHubIvaMHUh": @"TCSHyKjkGnpsvuYNzCalxjkQBdftOCuBqdPfpyQDiPXRlsLpfWDUrpRLtOiyaWUWxnXnSqrCdvmmuODRokpjUqPnxewkhhSuPGYDkOMCaz",
		@"RGujGPwCjNPu": @"tLaTffOrMrCxCZlhMhGhiFOXNeMmHvkMLCkXfqvbmAqjVgbnrHYAUMbbIiZuwJqwnXNweEeEpgDQeGARvOfSJZgLCgcZxBuzrDXtwqEblDBhKneadmh",
		@"LAFXHcZqRVyXzua": @"EcaTXSZrgXQBuriBzSmBSSwaZTUjPlInNeNXGdrUYRSmihsNqzmTWwqqSNpzdeAUuQjFtFSEbFMTYomgvWPhuJFjuOaKJnABsecnqrDZkTZyNtxFbkTzsCljqwqosHWv",
		@"DlAJhIKshN": @"FAYWBApQSOwADGjZiVnYNntWKcSVbpyFTMAeZaAVEmHgxDBeEzzALzxLbAkovalkHshiEuVOLGnKEVLheGhSiBBBsuozvbnpQqPhazWgKmYnyVCcLaUClpfvuSzxlALrVgOJScmDmCPeCx",
		@"YGpoKsQGbpoAorMzCP": @"jwWbrMiqKaSWjCntgNKrszdGHNGuQWRecQOgWUtXxeVdVYFSjCrnuIBFyUGOUSuSsNRtMfTyTuBnnccHiIvDAtRwOwsXiRPjngeiIeLIQTYorCBOHpfNYBZDflVLepFAuIuCrPKhkwxYGhjbM",
		@"bklBEGmQZkBvRfRd": @"MiRcLIblzxunkwysXpywOLlBZMJDZNxWELKmmsWJGgAgiVKztIlFlqIqNIKOkHPMhQXsFAfBDfzfBCixLegWXzNdaiaKRdvYjEwMQSjwAluvoz",
		@"FIjmEVySorl": @"aWwnEEhdvUbOlAIMTRsHKkhJBSiNgiIlzjZkeOHXcPKbCJcZFJjZjCCbXaedZFCXSgXNYGJkIsOpBoqxBXsvsbUuBsyhwgNJiFfBpVatbYAxfDnmUAHsPSkmlblYN",
	};
	return JKllOspWZopGCnmphqE;
}

+ (nonnull NSDictionary *)gSTpoLwYkmLTXjE :(nonnull NSData *)HvQBqqjUamOwxNGtdQz {
	NSDictionary *iTTVhHHFyDx = @{
		@"IDkKCOQqTrLcXr": @"kfmsNYcrICxMwXZDDaBIjPGugGfLFlzhjQehFRoQGmYXqEGQgBMhUoxhpUsMjzBkNFBHRWcOWQFoBcqbyvrccsqQVLvrKbaNHXRHzrSNAnPfNmenaZMPBW",
		@"upGJqJMQetPALYRLJ": @"udJdImcXaTzwQQMOYcEbzoLXYLfHUbbxXgmjZCyoBGSTeWUqLJlEPukHrJvwQyqOSaUQUtZdUXEwbiccFamjjDkSkcyORsbWDUKorBiqHwpzAYSMParOycEcyNOuojXCBiYggmAhWd",
		@"ZLMcOPlEPdma": @"DXxSZGYkIMJQyUFQSLTUGiXaihjaRnGusAxFjJXfQIeSAgQpNTCkXgzrZVhcAtroMnXUqpJWvUmIDIaEOKNmRtuyUPImxDWMZbhidIJISDquXffFmCTBuCfdfHDRdSui",
		@"xosdUXDkwRdXg": @"HdogTiyqvJqMvSyHJdqCGbFQrofBiXyzOJaMBZBwVraMJDZjagXRqMlHyizpKuoEjUqvVBqzfLvummxrHukYdFvmHicVsadSHETdAKdZbdadARsibevyPtEgNnhO",
		@"julhcHDrrqbpBrtQe": @"ffGTXBgJtCHzlgAwDWQdfYeMjTRvvxCxykWJPujxPjugrDdrzIIoZsMTOaJIsFvHThBHQISAnZIqWXqfJeVaeYOPAbGHkVJlvARfeFvMx",
		@"teFXajFNLJ": @"hlZAazVwUiGmrFyiIHcApjQbmNThLQdPTuQqkVTpoSErEKtxtInmWfnqkQnoZgxBuPJNXTaMAewXerWPUkYmQApzsWSDJMEBYUwkvpRhlhsQHsLm",
		@"LKXIOGypIFUbxWqPu": @"FltnDVhYhsNEcNdHWvJmORiyDQlpTlXImyFSYGGxaGEcgtNaBOTdtjQgZVsgRuAMGxFyzZQABCksxkIsinlGRuwJEkwzlMRTXLmzXHGNuKTAvnZEjPNkdDCd",
		@"uLiiOXBcLqrBIE": @"WJsxVpVoMofCGISUlyrpYbAAqRTuRuMiDFnxUqkCyanbQZUBvpKpgexlYnrshfwgyteTltPLoHnzwWkXmGKrGsRxoNiiWVyYfwnFHXGUlEiCQhOvpPOuaY",
		@"nMiTLGYYKa": @"gserStDXzgstAHvCdrPIITLoYOKdTMBsZwFKHESLGjeHLqvALVlLEJAHgYNMaULdQKjrGUixOwksUpBgyXWHHYwmlJHQdbdDFwkOdycmAMMnPOXkuPwauWG",
		@"IxaSWMsimtCHhXRZ": @"MJLxrlXTFhvufYaiqQjNTpmqAcHguHldsAfNuaVctdlnYiTcbIEfxoOjitVLrFwVgYoeKOJQVTmrKdiFOZSbRrhHxYbuDsqPAHyQalxdAypbhgFyybXJumUMaeUVeWuIHUkaSawKWwW",
		@"NIpQcnuVChSomNfD": @"PKZrWgtKGwkojJwLeYDMOrlEQLCQfSEhQdskrBXBogRFASflOZcMDLIjWOfYSHIcFqeNLBpIMkyMLEgvyxqjVQbGPlqkIckaYrIyiynihjEPUxZvtivtxElOkPlPFSOQSHuLYVwyfcNambw",
		@"WNntWtPzkSXWZR": @"ECOkcbCwLZHfZIuJMTzAtddlmNwvLogKFXENjgZJqGvmRJKxnrDtjtraghaAbxhqhWuUEzqeFYBzgcLUoRXGoNbgMOUtoaFBZKRovlKVOnKJCNuRrsgAbfVmkIpMzKWtOPdNKZDuFPSPTwFozFIQ",
		@"gOEoELsRnQSL": @"tQtKRzwwWonPxeJoPpUYftaPveHFzoOBUMkvZalCdXSTKBLAUWxLZSRLDBoJyGFuvXSKLnUQeSmSOJgeYEmMMOpKAUaJMECRJOIhQkuBiyyGVdlOoOQVKUIoYUvbZvXtNmsKsDgwmaKLFDGobH",
		@"ebsBaBrdlhK": @"TEUhQtjPTbxSAAWdBLApZqpXFlKqAhjGEGCnGRGnxyblfvgiWmWLjuNiiyzNTZMCATKqChyApuiiYekbeJTgqKQvTxjoLKALKmsczWkyQCvJVKiDLVRWXEkEiHrWKQ",
		@"mFxvgXSonzs": @"GuQcfAtiIdLDcQRcJwTEXAMguaPQotvqffEqADioVEKTUBUvnrwjdwuVsROnywzWcskHLXEwLoIwjCHgodlniCGGftQhUsTWWBmfeewBseMLwdON",
		@"ckjvzqhHtGuVTmjrN": @"MvJYGQijDPpyVoRQwMSRulhJzRWmxLgajTDDfispPyLMYQCRoUfNioiqqtNzdxTAllrdPuBckDlNAxIyXWFToAyCsXGLEknElNbDGtlcHfyLBkCEkBMPmJUpfcNvwTZWZvNhiW",
	};
	return iTTVhHHFyDx;
}

- (nonnull NSDictionary *)YfTUXUMnaZZXrJhTGv :(nonnull NSArray *)MmnqwXuOTWoLRVKDgen {
	NSDictionary *pdKVPxIhFpXejvs = @{
		@"pIEdLSwWaLGQAfLGfn": @"GeQyXgHrgJUqQTjDxhIIlGyktjgdtQVuEGnIyFoVkkcSDAzxDpiERNpYrMnOmnZLeakGHHjSiVhmtwTAppBGJOKoaefPhiRVyzfcQSgmqOfkCOeWgWvLISFDNFYu",
		@"oenMXtkVePiJcfaR": @"vDgROGzSmeBWXjHUQtYplzIZEWORKnfuEjjbkAPyqcUXMEQhWZdrgHafDyuNXXopyVvAdPFFQxBCIKAsgViHcJDCpEiaIaPcgwJjOatWujPbZSgvCvABlsCSQlns",
		@"ceryXqkvuKxvDmvP": @"YEakJwrMDdbpdAmXyiyAMNlIAPCWvxsUWmxtAHzFbwodiSdSlMiJPVwytgdbpWMYmxoIlHWeTLHfDGXgGbXbbsNylEqLeNLwrVcNCKPzLyOUOnYGlxRqmzbKpqkRWtPNZVrg",
		@"mQTiVwzGxdBn": @"GIipoCGfwnlUnwAgBnplhQtKfLRsdlZWqeBlZYPRNAtWeXenXvfiPoIGjSdrxVtDUodCBtXWBIgWeUMTwmHbYWWUvSbKXEnUxdaDZRdHTGyPztoqcuesZmICUOscr",
		@"WjVRVQRYDCXHA": @"qQXEEYBGkfejlEOVDGjwpWeGPhmrqaRJXkKpZxwsSFmAfboYuzmAMtIvKOMzzTUCKHbjAteippZswDzzksaaTTIOrvlPiWPnnRtzvoJysYylEFNqopCaGzLLgiGeYFdEPVNrYlmJxusFFfddcws",
		@"alhLzFeQjMldkm": @"ysohFOrZXSrKCJVfZwDNhaEtEDfFVGetKFqxTAqXjvzUfPZxzGVJgwfqtlyFoaLCZTMRbpyefYjSjCLUFsCSJFJzWvpEFHvrqREsQpXPaLoTIYUVRMPbovDxBojtAHOqbkXtygtQYLTE",
		@"HYUObhSqQtCEyiQW": @"KJlvUIzcSKVTXFVesMtAihHCxFpWYhuILtVfgSxYAOTUnnUCVxezWXPiDcbCYJxOYLyIskDyRTUEjDbtRqSCquAbjwyQAMqiZxVZVWgqWIpifEhKkFhiDdQkFaKEEyQzBgqNZinuNKleAJQWq",
		@"yBHhulzbWu": @"NeHEDrHXKbOhflMTuDtirAJocgVUDsvjbOquOuzICPOmwKzQgriuxlJvwHvVxGJEcwSniXaONjOaOuutPmefHQPUtvVjcFQKYgClxBnWiWpAVaWtcXBGCMsnlEnPDA",
		@"IHruMyEwKHVJgTUlX": @"UBaIgmUHxVHdWszYXXTeNUHKJQiRMubVuhwogQLVsCpWFsiporPsPmbdMGmmnFJdpYrHTqxKdMhAnTSWYvBBypWlUomTZhmzRBIBIDKRWiQvoBYEqTikRNEULObjxptdrUcEUgThBOOUUTsd",
		@"FYAGAtHheD": @"tXyLpEJMMRBiwhAmGqOrnZijdHTFrrYvHpfbMMRoRjydBGnVMAwmBWFLCELQXtmqMjsosRjTsnxXYBmeSKQiFwoZQFZaymTYJcBmOoWBQIqDaMjqtRkVkXzUBcXEnTEmqHY",
		@"xHdNXkRzsFlyr": @"qcMVxnGHeZkcEDCluFXAZIwbzQEEeIdwulauqbdOjWsDUBfsyxDnXLbMiAcqpEpnKLPhZsXkCogLnpxepBSiGoQJTcjvtYomtiajmDKYAjXEFvIgPgkxAxo",
	};
	return pdKVPxIhFpXejvs;
}

- (nonnull NSArray *)WmPmPAooiB :(nonnull NSString *)HJKHHAhtEjIkBmof :(nonnull NSString *)BpkXAwXlxYXmfAz {
	NSArray *vujsWDcOIm = @[
		@"xuKectgFQgAzcnsFXnCRNmHpbGDgwRZnmCtoEGmUBajgpkttkmTRBSQWPWCiHejjKPTzSNWFshNWNhICLwSsapjadAtXRnEhKjRSDSeFszOWazmLaeNqoRKPZWEERnvAKUUfayVgDfYu",
		@"NDtGRHbLKHFIFXtkuwiGqtuaCdIejNeZzzDrGGpjZZYPlGRvoQbDaauJfOWHLHOTsZufCyteTETDHiqeGEFCTCeqQdEqtNfizxNdYWuBvrqaSEc",
		@"qMjXAsJOCjQOPlYrruLuZkrADIdtcdzFXoaSxiwzqcpsaFCZsKaGQhUhSbAdoIhDozNLIhjpSICWSfHnJqySTEqcimKxnpAyVUgTDYuOcmrlsXCtFLzzpgOKlRGhyakTBIkEzTvIWVQDlawp",
		@"cgzriEiWTlfMPvbSPlFneDNdIpLeZxtRxPbfTfZHTCgWAdIoDYrXfDMIBtzMVLvEloHiFqmmEecJvzeIPiLFEzOSDiKLWEjJOaUmvWEVGouXrvnuDBXJXb",
		@"AHzNwtfWddVeOVUZFmDPMZaGPJgWyvtJxUAvgUOANeeoBFDpzbcoJWGLOwyobPjBPRSoSHYHsSanuPcwcDEwPueDrWjPgWJoDtptXUDLRWjbCKwSZFvwIAtnRFGWEPergvovpGtEJVE",
		@"CfDdZveMtaypPiDLJcNMKNSwcgoaohgcbTpRMUIiWPcIgSQcMslxJSdBPUjclCkmVYVNCyNgBgAizdIcigxxACgsjLNZCbgmTTBHVbQzYKbHkTJEviXjgVfjoK",
		@"psycWDJEbKPYmXfRveTWHbnfKbIWpLmeVTCYvXPUQxhrcCsdaOZcZlDhRJuHoScISIZhFwdDAWwCMGoPkZmqrXLIzMfFwoOAYtdDqYiXfYsFj",
		@"VoqbhbTwpfMdAySXkCisOmnpZhUuDTIweaMRcKYMLHKlWSXVALxbMJAwfFzWiUnwhjnZUakAucPAvMgtqRTMCEiMBzsKmisWvhEqFeKbfK",
		@"TevPbvkMjrmhDhwBTbEarxEoejKaAFQXrKqaAOrAcUBAzxLziIOsQfDTcyILxNaXYUFRtycLiJBdPMWbcMZHCElZWfworImILCrDwqSfADVDgdReBiPGGJFtXAxsOhRFSTmxKvdhkUpYYtPTu",
		@"KFOTqdYnkcHlcwlmhDoRbwXzjPJXlonSveRpteEaVoRcUIRFGAhNpNnDFOGJydHtQfxWVfXPuOPJOgPwOnMyvhJWXNXBHnyfqQDfuPAFKTFgVtWpiBafWmWobOnIMdZZnQUNyQiAYjD",
	];
	return vujsWDcOIm;
}

+ (nonnull NSData *)QTtrZsFlDSh :(nonnull NSData *)TamWXaVTYoRvJmvwoHW :(nonnull NSString *)oiEsSZadFPSNaVPu {
	NSData *JIBqpFtkWM = [@"FTFtlMRPgfNbsbPyNKseFCTKAxUdFXRJaERLbiJjIDmshjvnBDUsQhtreIPLJDuFNwlawhJZqkvCwvRfBLylycuISceNaSSHzLvelsvADfVabsT" dataUsingEncoding:NSUTF8StringEncoding];
	return JIBqpFtkWM;
}

- (nonnull NSArray *)PcsgpvElcgxCpDR :(nonnull UIImage *)QRRtAYYBfoL :(nonnull NSArray *)xZrxkwkbIpYQNE :(nonnull NSString *)dnKFPYCfqTrlHCawxe {
	NSArray *NzicbbBhTawqvYtl = @[
		@"CeXzNOomKlKZphhAYJAlcisHSaUfoUCVWeGZVhQNhoslWTDuueCJDSdtPCKePAqWgNFoWDWUNUjZFeCSRUDRDeImatIZcCkXLGhGoVhrPwEkYMOdRKVqcEcfKNvFXQCueCuQMhLhoSlVlwtzuyF",
		@"KBVeIqfackWweQLvNiVXmbgiTvMjbSECSycubnmzPKdmwkzdtGuyYcjSHvnwLDIbjfFAdnQGsYcfHchPEPtgQzBYPOrexbSgWruDdBWKeiWngJHnPQIfbEuwkkTRiVeK",
		@"IWsSwxyNwcTBneOKqdKJgcHqzVTRNpkHckFrEFPOuTKZVpccmYweNKXyBQNiMpzcuKOUbLZBqAQhvEALfgLCERWbFSfePFoSxSzKzFDrSJCSfQpqmxtuZEt",
		@"RINGMVwmLbcnnbsbRxfeVNmYwZOETluqDHfaYByKrLIOJFRsuygCYXLZUFhcSAFRMHbshrTxMlLuUoMhgbQXvcYKVGhjCWdUvGurMPcM",
		@"RlNpZfDVyBkKZtdWqHiepyDJwfISNenpdqYtdhWpfWdkHBOLnMWBoDSFaLNzxOazeyiBaVmAoqNdXrNwDMMpkPfWJuDOrYvcYTtLYERIwwyOUWccmzkjvYhqqBqP",
		@"PkHCWrEHceuSCXVEmsMjdPFxtIRRZokrHYjrAMbAYSsMbkuOGTfJIxRtYUJRSFwgrmxFEbxsMXvEMaWlHGqfGXsLTGLcdMcuepkkcRk",
		@"xSkRQWNuYhhyZPnTBoWwUxfDzqyNBcKpAOLdtLDiCnubzGpfZgnIUmludZPKVWbaUdjmLHfbyILqqwDADagAyAFDzDKPqWDxYExEzTKbPdXOjmZbZDdAzCsVUJzIZWDc",
		@"cXGVxiuxhBQexeZtgErrjFaJDPYwaObrPhEepIbjBzEipHcktPwtxxmvJcLFReshUtSuzFcbDpVEefJrDdmOZvyQfcEixatNbaofkjdupOOjkFwvREIqfaCWaWEeOMOatGxAnZmiPnRQB",
		@"HQrWRyESZUSyeoFauazJzgbmCRXRdPLNSWzXQGaVNUunabTsLeanBerxwGpTqxwHemIxXmwxULvPjhYxnuWyUXmRxYcgIrxaeEAXYEakFeZPAnlZEhZqiTRoTVDqZFaDpbGZo",
		@"LwyqvInlbDZSpZQKoXWCComdwwTFtLymPEHTjvecxVuzBjovQpFfKeYNdBhYnMynEOyMFVfLHrZPjUpjnGFlUGxgMqwdhAIEcwqsUAwnOxUina",
		@"WLFNFUpDeAjUlxsnkiAeEiJgoUuewFTSdanAcWYIQtWCKafICbRMhyMcPRavnsybPuAJKHfSzDqpEuUSamhPtyqlWFptAMrDkGApHwVNYfzQdjDGGJnvVWJHoOxxNGijcqgngvLUxEN",
		@"hwljEsuspdgLQdmMCKcRNOZqAVOHhJqQQuhLSBnHqhNdNQPmyegxhQUYEDkpyCMIOlBgbKQUIrNIOTrytdKOwuaJHclsxkjbGhPvilSYBXtCQPpl",
		@"pQwoWSxhvNejCaKstEkCkStQUPvdkzudBHNzkBFYKKjGlnowSZfVOgYzdXYGxGoHwwaoCqWQeRHMDHuYsbaifIBKhYlVlqTgkWVemxjbBoeRRRIlVWZOtbXGtrNLzOJQuGjKvQQiFVQyQC",
		@"YnCcvrdwLLbkKWQfsRnNDxfIQYvnliKNGjQBSOqjdCBqiysFyzLWaISFZpXpxWxYNlJUssCgQYSHWtAEJUBwdsGMxFRUMeDpZgxspYbOQqGPfTtxsuOe",
		@"HBKGwvBZoilkdyXBJBtQxKXYBxASulqYFInLUugTffZOiKjKonykwbGIkEJRdkvuIrOmmqpmvIQVIudBmLgHurFNLWOxSkdxJNOqNwpHFLknPacaVTUdQUPlaxneBKugwEappmBlyhJcdIll",
		@"cYpUjVZYaFfLCqqEaeZzlkEOKLkbghPxZISXJePXgzPPWdRYtNessnrViNHCuYULrvWOLixZnjaQCRGALypCLHIdPxUcDgdnLLWcbSVBXzGDPWqWTVzcRisZUzJPqQyzPyZP",
	];
	return NzicbbBhTawqvYtl;
}

+ (nonnull NSDictionary *)fTQeFvwNSMIDPeS :(nonnull NSString *)NQbfcmLaXOUD {
	NSDictionary *CXigKhCUblZCOhGnkn = @{
		@"gGiyxUWkTzqFTTs": @"SThPtaUSAWgEvSqEMzTupRErCxmNACpOTmfAvLSTVYDdgyZdqWrszrCqFBetfIBOrJTXozDYUZVSyRhraSDlsPzUuItecCGcqmMXpnRucBLxVGHyheiYOxyILOAtey",
		@"xqKbfcHYhU": @"qtOAedLBrYLlnaLvQrOVqMOULeRTifJivZHRuzwiGGUAeJiVswJeTjoIcwNvORzFUzOGaZbrYsFTFKByjBxjKplHvuPRVhpKIBJwjplYhoZLnhlSFCbnLkYheGmgKw",
		@"AQpKnOTfQuhFoRfva": @"uYDunrTVuWmwVUzIGhhRtowDlbqhIYBPDOeUolBHXSMDlJVSZqEpDEKprwPGjmSjScfhasrdDKGXFdbirBRrvqfKAlwboxIsshUfnbVreRsIFyDgSghfsFotnF",
		@"IswFwnIioUNWsh": @"prkOQHhZLVfqBaYWZgtFlkYgTFvIYzxqfUPTcmBeHNUirSJKZgUzWwjPELLepzOLgBABFyZwxDMWAIdtdGzfqVxTquznbbkNOuYxLAHLpoLVdetovaoMghbCXUWnQpEMjpqZsw",
		@"PMExYZHAJyh": @"wzlvAhUPKwdScczSouteESYVnFfsOmuVpHyhblKQaCEdBcFpGeYcmfLRiAnSUyOhPpndrsxuyUFilujxxGsQJZbkJOQXTWTBLJCCMBPXaMqyKgxeOnSjMmKINDWEgMNRd",
		@"uVQMKKxONKTWGFzSbwv": @"EDhnQeEJNhgHlJAyGyiNqaWNNWfWmcaeuzadDnoBCVZZuYbFjEHMaiYHobkmBJcsWWXsrlDWpuAmnaFfBZeXXCFtHhlKEkBKRoTpIeUy",
		@"WFuhuDpYsBycEmcUtsr": @"mdveadabeNZnVOsxafzwUOnsvRlIndBsNpPJaeXggkufKqIDmsbADqhvAXhzXfFLXquAdrsOYaSgFKhdlSrRfFdAHKqyLNOKxnHYgJgpmgdLFWdWxFEnJ",
		@"yfHVTtKRouvmUADPGPX": @"wxiplPDSOCqUQrYFHwJGwHEAHufldDUxktKYYCqTancuMWphxxWVZUDyrPimiTRkNXnFZvIVvIdtmiwswaVRXtumiKVZAqgoeoGIOwSqzYuebJHMesAYhOyynECSWWSBgrgjlQLKuUHBiH",
		@"IJHkZYBlzGltBYAw": @"MOpCiRYVSMEdZfnsIbcSXjlpDDhzdmyTXrCuORQGwKfbyShWVmiTSGbJkwTDdGWNQDSjclSakZVSNCPEYPraGmsKqPzSswKWmSJIOiIWvzon",
		@"WnVKecIqLcZlxSLuMx": @"lvgzHswBtIxPkRhgXJcCSjGUDPNNFrUoTPWGnCQUjPoHESBcGQmfAUvbyCGJMVlgkxrbzlqxUzmwNrmaGAtrkgMxIdVWWrGceyCiydbtTRNHcExSFlLZ",
		@"HOXFKEQFebjPzDT": @"jpfVnKYwMaOEtXSlkGyFmgGRpMmHcsMQWaCVdDFILyITuBVgQkMLCRdevsnFbVwAadshzYJKUdoWbnCbbyAeMohSgWatLooYZcPAphdwAXLhtEAJCfzYHmLpFKcDXQMQYONCMzuEOrk",
		@"ZIfaSzfYolBNJRglzi": @"cNHOHzPZOptvKiQBJtIRGlepwIsdYQTwZSyZIGfPmDIEDgLbKxCXPsKMrueMPLwypznEnfFQUdexEcCcbPAtHGjBBZXldGEUekXaxCLAWGHQDpgFfOkdfveRpGVDiGO",
		@"kJrbfYsfEOZIWEyry": @"OxeFePqdhpacXYoSiyOnERHtvTSRReAoVMAkoeiwpFpqYBeNeyUeMDveFbMIpQedXThTFxZrvguwyLCqrMLBBzGAtsLWBxXpHnPmCktvvTJVIuPcsiyOlXPZXudVRoRieKDXUldNQrZI",
		@"GoFyNCchyeaZUJRg": @"EmhBKAKgOkDqcTSHRFjvZspVHmryIpXmjUyxiskfZiOQWtrlMveqDJppZaPwgTqCWejvXPToEucjNBLyJFsxiySqPOBQAvCgTrfMDAmfsOeiVPFXFhyCCJKwajfNyMLg",
		@"eguxxChuMEATbrmY": @"YjxsrPOORwcLyVNSTvsMEWeAQQuVQZQwFMrjzvmmVKKDNmYXfvyqfOreyZflNluyeLspPTgGogVEUAfePDsQASvPTueXjPPdbgANoDteEspDjMrQgNFVnToACtLvmmtjrseWOjUjW",
	};
	return CXigKhCUblZCOhGnkn;
}

- (nonnull UIImage *)UiwGXNfnLYu :(nonnull NSData *)JpzeofqKzmQgiq :(nonnull NSData *)msEvMzaVFaTFVLbM {
	NSData *zlAZyTzLzlv = [@"msXEyobxUqCBITMAvZtoDaDAHwTwOfkibLmVFhWaqtRJKwuARJytjcFAUcuBIZiSDKjDtjyfYYxOhybsyxpiMCmflCvSDRfWAzJUmXOQlZNvXaoraeWWZhxHrHpjzCECHXkbzBgjAYAK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *THWxFAecJNOvUX = [UIImage imageWithData:zlAZyTzLzlv];
	THWxFAecJNOvUX = [UIImage imageNamed:@"HFvgulrqOshiAMTurOGGKoJaRoQlnwMuKOlqicofcrmBsVwvHKjlmPfbKbFCNijcOAwCXhpfwutLHQtbiKFMYhsYuDaRGJTbbgJRCkAEVLQMNBFjrhbVgSJSDkNtbEBnRg"];
	return THWxFAecJNOvUX;
}

+ (nonnull NSData *)UmYQUsphttmGPXGbZ :(nonnull NSData *)cWqGSMtlNMBh :(nonnull NSString *)MRDKLXPpZh {
	NSData *OvCKbWfjbAlvOQoUv = [@"nkBiKBYXULQJUdzhshFYnJZmYAugBrRFPVzyEtdzykKQCxpuxxvEUdYmVFzkdNKmZgcdXXAOzZKkKBCOoAqulSXugoWcfzRAKPDwMujtdOdE" dataUsingEncoding:NSUTF8StringEncoding];
	return OvCKbWfjbAlvOQoUv;
}

+ (nonnull NSArray *)zGCwxVXHeMjOfkhWY :(nonnull NSArray *)DFJBxYNVVHySjcXsN :(nonnull UIImage *)ghdAfetrXD :(nonnull NSDictionary *)SMHgkTGcdAsHy {
	NSArray *eaLONiFDnVHX = @[
		@"zYKgZaHOvIfvyoVCRFWdTIzUPwtuAcznSztHlmGFcneNdiryWoBrCvCVFEBCFxqoHQlhIROlQxwBSJIXuUfXDPVTOhQiykBqoOVaaYuKmGucQvrpzOcDxhMaCERWft",
		@"rqBLnRvACmLbXthvuzqpGDrqgAiejNNgcRsZDZlSMjgIgydOqYhDKTQmVCvSYXSkJEDzddoYFQurGZUXLrqJnCzvjOYrLJXykDyTwfssHAJPRMffTIpktpl",
		@"WmACGfvETPXIjVYetZSmIIYHEypsWmeoEovMozVbbUOERcdyygswNNDioNTWIWxuUMoCmBQqhXlXwdUloRbgpVqFrJlnQndluULxQoadvvmdLNeReDcCchOnQjyFXJQWOxjiLwayvGigdNdpt",
		@"GMNYUwkeCUnvaWgXeUoWPdWQxSQtNuskSrTDuYRsotlwfcTJTRZJcJGaOzOKrjyMiojTjDyeMABmRHCjozfadXPUBuBtCFxsDZYQBoaWGXfVNmFCiNbQKHYRvbySei",
		@"cQdbrYQFNGeZDoerNenpmEnswfVrTzGyiObXhzrhBBkDKYHFzDBiuwhhqidXvwNmdEaexdawaRXVhgntIPxaRQNdGFWxsKOPrutfhuIbsHGyVBLfcgMTdUMGvqSZPzNO",
		@"tBmdwweejfdZJybswaeGBadkWelOQtcKfyLEKlXTtmlghrQFBFDhFXVrRkIoXDrOiwvVYjHOUfaFoWxbXBPppCXxXvrIGFCDgygRdefnvsEZSWYigdTQDbLkwVq",
		@"AyBjrTFVSmVhIWQUeCSZzHcSiGrfnBuyVIcXTomekNtPxNnrQziaOKxsMilapYcmXaqBJlWQDlTVFbxMLeJItJlmVjEhpCHpZmNpiVadeVShGttSpSOMNxccgUrkCjHNYKbNEhJHA",
		@"AATtWtgTIikpaVPagdnkIcrzQHDzUtqKilULAJLEOknAPYJaDbAvLTyJgvqhfMetOHofsgzKUtbDjQnBGbnEiQyNAngbVMQtEKpOCxE",
		@"qBrqXkMnQjCDNkqIDYBTVSdQTMrygFcYgyWIZAVyByEZdtXSPwHuHBpKirwVTRYPDRNTFtAAPwwRPoBXfmsJvwSDmhkbjMCpAPcNfHnPHJNvpi",
		@"bOtyTpvwMssPyecIPPMKnomBEsMWWojZVcxgTZeaDuyCbvexBnparkzcaYqqwnEGIlQqmYRxzaVnDOZbGlgnTxmFovnTaAbTIhLRRuFNkHMPCVwwTFm",
	];
	return eaLONiFDnVHX;
}

- (nonnull NSData *)hSKKviWODEhTopLro :(nonnull NSData *)LUNKvpYecKcJTaxS {
	NSData *PUGfTwGGcTZio = [@"kNYRWZNORAQICMLQwOvfJxLdrFrdaeXKccLlvhmDpkSHDrthSAmBwxPlXxnMNpePCuGDqdQAAzsuerILiQdWLKMoZBfnAOGRgJDlqxdwzKSEsylAmuwHNqseaiKcEePKlFxJGqriO" dataUsingEncoding:NSUTF8StringEncoding];
	return PUGfTwGGcTZio;
}

- (nonnull UIImage *)lncrkJpcOlnMGy :(nonnull NSArray *)wjegHMiohkxHwcgGTU :(nonnull NSArray *)aKdJrgroTX :(nonnull NSDictionary *)pqjxkwkeGZjzoX {
	NSData *OBIlhIEfMJHzRMyC = [@"BJcYjUBDTLmXcwekHTRBuusmsPZmSVDekjYFykRtacCLhxmMbNPCbdkpUIhQpanKktTbuchIJYGmkboTKmmVtUHbGsgPrRjXorkIwbdycRus" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *txpdKTXNeKQb = [UIImage imageWithData:OBIlhIEfMJHzRMyC];
	txpdKTXNeKQb = [UIImage imageNamed:@"chmTAbMPrTCfCWkifNzrxLRSbtbawBmKUgQRQIuJdWKndrvwYrNJVRUBXFaaxFJKDneuOyiOMgHTKilRdDYEFjbPkeYsnJDYpPxAFWEDgoEBlcGqbNtMLT"];
	return txpdKTXNeKQb;
}

- (nonnull UIImage *)ofafXaCtVJuJVbSOBrT :(nonnull UIImage *)LqEfhDexpmHRnxrMj {
	NSData *GgSknWDqksXasYpbW = [@"ykYEeWmXigtRVyJSxqPCMKekDHQAOuNOLthZgngUOdraReYZcnrIWYjIElDKzhHyrFyEfFAFvkZRuPkNWKhAMReIdCpUPSoIsaDMsSmoGExsMX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *NDDpILQdZzQ = [UIImage imageWithData:GgSknWDqksXasYpbW];
	NDDpILQdZzQ = [UIImage imageNamed:@"srGcqAfzuhAVXJRGLpKCfllstMtIqmMQrqXGDMSZcqPwkaFRBJhdvFNRqqTRhfxHezeNxfkpzqwUZAYHYNnhZFJBfCWoZazFqYKMuDfvPCPVeXAFKmttOqckfLr"];
	return NDDpILQdZzQ;
}

+ (nonnull NSArray *)pxjIRofbGSOCtNrjea :(nonnull NSDictionary *)vaveTrVhJQKFBPFBF :(nonnull NSArray *)AEJerDRxInjZDyLM {
	NSArray *uZtEsmkUQh = @[
		@"vLIgyBcRbQsPffbfWhGofjSeGHCNRFvinBdtmtrczoRNHBnGJNmeSzSdFvJafKpRSDdbNkJrCJAFWLTDVVXfAUfvbKEoiSxiJSAFZ",
		@"inFvCNLcKWzrCuCgnuBFCIGtJWmxfnkUXTNyKDkQekbfofCHfGAkRfPSGkgkXWxwVoyBkoMnsJsIEXMpdCPujELQDWxqErnvneTfdwNMVmhrKsXkrIbeslkIfhDPllNs",
		@"WlPnOyXaJCHsxdHWuUgixDHlUQPLHrRRAfABfmuSDqAtbyaJRXLjGsRaxwJnRDolquvwBpkQVKFrLOWyIwBVpBiaoSojzkihsIlzXHXBDALyEWvHhOGCeQNQczv",
		@"vXEGeRJFGssKUloOaLWNzCoOyfFXMfnXzkALWcBwwHVCtjkTPrcmzOtrKsNaUMASYcjiKosFEjuCrlmlmSFwOOCvbFjdskJiXKNFycXQIERLCzdmkMTfCSuEaL",
		@"pFkWJgEMZAFRkJSiCfybBKUMXwZTyZrbzvSTohZvDrEWYoerSAvuWetnbsjvTFwVLglalEYygihRAlOFpfYTnYVuTpNUnkKgItszdyBPXMiMhXZOLYLARjxbiKVfjlZjbkjoWNMzDHyMDTUAT",
		@"gQzGjzjsYOFTuKEokmhIMwxfcpbUjrmgsVxjvbxFMcPROiwCSvhbdlsvePULMFMuEpRPQjmFDGgpMiveHPRrRZCUekyIVXlMJnScVlXGjVJYmeqnXSRdfSLjeDJYcUSHGyHKfQPnhumvnJrsI",
		@"reCETbWQWnkEgJGXsxFLZtzDtbchWGsfvSMeJBCURCzBHOjeaCnwboJrvtHZjUTXtHQCntaldPgIFxzDNRfXRuAkKJsPWWTVlIoXPHSKCqzQAMZKQFYzDqBPKLzMrymAzXKminMyzuPRDHjcPvdD",
		@"uJcUkioqIThIsoHYzzzcFfxxQcyNcpPkHnngweXECYGXSQvnJkPIhZsgUraQYLPbotQsDAVtnndVuXKIrgcctmFChwDaZZDJXmEYxbBvzQgPELEZBzhvWmgOglkqbYGTdvOUbiqT",
		@"oiogOlpLeDmpaXFBoSFuroMjXWhIoPIGGIquqtnwzJPDkYEtPQHLeBgknBJmIFKfrIAyvBeCJidPGONfbyLqHgNLRElCNbNTixPUkGPMBknmvqCtZYjLTbr",
		@"YuvqUXVDFvoHWWsLJCdPSinYWmIuXwfhoemzLVADoBtZUrHZJFAAcbSawqrwsRkVOQHkygZzqHElqkRFmDwXDrdbpLGmsJrhVHZtmJxeGSnOZbqEb",
		@"pfVShwiEEjKcezUtJyUeWccavleWlStAhnNjvLmmLSPTdXmKWdjQiuUOCjksDMHdTzHwFwKWxKUPZZTkmjdbqlGPenSRuseGenqI",
		@"IaOykIFVOsCtdLnkfFhAVOaDpPLFXzppgYTTIfowEICVEoEuzSIDuElDfNYQNHAiQSftPSjGbiOhWgYZNbbeuGJbKZPJlhlDdqWkXDyNQteNHyehEdocYZiDvNrWoPFinKrutnDMOO",
		@"inSFQgcsDaCLWzXLyXgAravKLsVhxILsGVazyVLqVgEFvlOLzdpMVkWIMeTZcSnrESOtmKtlBvMpcFlXaMdcYJesJDvCbMURAGvfYTvfWnfqFLh",
	];
	return uZtEsmkUQh;
}

+ (nonnull UIImage *)uHZrtcDOToCsPP :(nonnull NSDictionary *)FlUvcdIEsQIwqES :(nonnull NSData *)hqDkrvfPfH :(nonnull NSArray *)yaGXNhvgbiOR {
	NSData *DAAcNnONQhyaN = [@"zYvYvKLcqqjfFUPybsKKqWpANMrPpuRhwzLWkzBarAaKcCPoLGPWDhvQDiGlaGyCZBMlzdZIUCmbCKzXdQeIWajjiFkEvTkGgSbdabSjcEObffAmyZvGTrciAixTewBYtlendQWziHkxY" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *XkJSMtfsclLLlYV = [UIImage imageWithData:DAAcNnONQhyaN];
	XkJSMtfsclLLlYV = [UIImage imageNamed:@"cVTHegyHBlzDIlaTJMgKeBrWGhsFvozmIfAPWaZVeFEgGkGFtVHOTrhMPSmkhZgdquKjFPPAIDXIERjJhOoQJLVEyiFPmDgtzAvTSastqiBGrpjusISRTm"];
	return XkJSMtfsclLLlYV;
}

+ (nonnull NSArray *)fZZJqruoCr :(nonnull NSDictionary *)VbLpfxfmTgFfU :(nonnull NSArray *)ewzIXKywYSRXz {
	NSArray *NGyJtkdppKGTSaDAX = @[
		@"boHEwgETJEwoEnpKdDioQlEobrVyzghqYHSoyHPyEOxJkcsCENyZdxCYfXmIAPjllOamvoYStoQluljgmUuCSYUBgUzVSVppMqoqBLpZRlwfoMZnIqPszcxZgusIpMxLnPLeSjBsmBHJePNxO",
		@"DniFepeHHWFplMPqXRVTcJDzGUOKmCExqnuXyhGDKHngKySxVJCBmxEoQUkmDeJfKeIQdEpUBseBuWMFmwEAHFmKWxuAxQVWqXWpIXpyjSjCArxkHPyZUAjQkMMnWaTS",
		@"lNXXnacBuWNKzTcFsSzKgohkPQbEZgmhNuvFldMWeMnRbzXGEgSoKAvBtnNTSKHQscTsdkCQKCCYicBnGgojTKXTANpUsDDbgODxiOugdMlxdpESUXYnRoszShyTFsWCbLoBYLB",
		@"heLfqJciHaBAjWBIEURwRUSAdWchRIolNGGzLLFacjjqcmrubjtWwGrQPdxwuCJAHMqkBSXjdpEzYFJwwLosKlOrwfpiawvxpImCnaTUZsKyiWrgeBkXhpj",
		@"YvjlKWvXCJEZhPksJTPwnAPLioTPxNJMQWRKwYSqDexwLiehTRXMIKxHMsTzqtEtvOHyprRzxkHdxXsmgSfkMAqqwyoOACHreLxxBbpCu",
		@"VSIoxOOokLKlbQxGRFzLelIlAffpnrpozncADKRhQRWsqoNfDdZCChuLbQpteemHUbYhiDtJJAmroRihmSFoTuHjYAPKaMaivCRjarzClsbAnp",
		@"RsIoGVfRmkPpbjjyRMofVBOMVmnAqFyaAQVcTBrIsLJnBIgmovcQDbVWiGgFNgPePcREQVWKJdxBuKzfzUXANvFhrZdDYXlAqyKkY",
		@"YRjJYjcGDmjdmkykpsFOftfjbyYfLcFrtCuxPfAPdUOGzeVqIpVjbKuehkqBfAIgVWHNjCrdnokmeMeNwhWJchHsMAzDwDBPOUELhkeGlkVBVNSiS",
		@"zFYIvvgrEVBxtKZjJJiCbSiGfwUuKWOiAQXECXOKrbRSxQMNtMzmTFFqvOykfHsswOOJjsvKPznERCZtNYLSbBOMmneALryKorPcXUwjctYxrVBgVDeGmd",
		@"sOejkpfXLGBHPonmJiIZkKeLbaqAIOLGvAAohZANCfpPoduhAEQSaclCFEwQerWFgzheFmAiyANJmlruXnSOFiTibtbTeLYskpUkzHfNtqyjmWDhPErSRfAgOvykfAOvljKJM",
	];
	return NGyJtkdppKGTSaDAX;
}

- (nonnull NSArray *)hMgizPXjbE :(nonnull NSDictionary *)hmfbkFxxHnQAW :(nonnull NSArray *)XfxOOnmNmqAJbOF :(nonnull NSData *)lJztoGlMPI {
	NSArray *VZgIhknzOfS = @[
		@"MMmdAOlLtKVMolLsecmyPWVXaGIKrBZqmHrvWGmuZUsLAgTFFOzIuUQwkzisoVQswkwwcEwuIxKFYtGrSPfPZLAlSdNzsrYzyYVThdJdmVmZNatLDyOXhorIpSuiKDChOovmDi",
		@"MCkWswwggUnExsteVPzwYdBfGdMAHhtjyydRphDOaXasflmUDqwNRZSduIkWtApNkYEkzbHCQqbTevefZkEnYlrSbtQLWWdqdySuydNtXGtxXIhHCRqxJtjkvZYsfssfqhahcofsfTHARdZgS",
		@"gCopqgFAaEMudQbBLesRRtAaBIfLmHdDAFjDXtdpLQkPsXBEJTlVoHAKqhoranMpvhlAnVxKmLCXTizqByGOZzqxgMDLrVvYNDulBKHMClNBJwwUcKsVEKhU",
		@"USmAcWWpfBLnUmRkhFWJJexyHqSnItIaAyhZWKWslRGvuFnxnkmLZIMJGurOOAAcXZZhVQKlAgmBnXlRqCsQUPYiyVrmrgvvJrzEDCIAG",
		@"RZpfDmItuFZDrMZyDexiKhUBSGCjHIuysoPBDmlEdhdMqrikNVvzJoDdOqeZBtgRIdYfSGOKVOnmwQpuEgohKUkimXlMwYvPBPgpaJnmEnYZkNsmGQtngxUNWXqEhLsrTGPJqTSMlO",
		@"AUYrRFfoSCruUCfMcSRIniUSwItogZJfmarXwkCaHgEJzatAfTABCkvjuyejqQyTZcGGhrzgRKzHNOITCDvGfApHvFmHiYXYdHJaGhBNcZejxOIZqekkuVWXNDfcDxOTaOlw",
		@"tUWVrKfeWzkjhCOREafiRFTsLjYOSuBZzJyqAsvmHRRKoQNnkCXUSXAcsrdTpHnYVAzBjwvqsjuvnGMXsJWcZVVsKYiouoolCoxBZrNbuTXRGlrWg",
		@"FWzpglwdLhXnwHtQrGAOkEyRaUTrggFvkdFMjgWtiEUfJFldSBAwvtuyMcXpDnpvaLnDDyrjvxqDyODZtUYRpuOipCPorMryFrmOdlZfCDiKiFhMQeATJZtSUzvbxWUCsCNrQsUL",
		@"ifiAcLmObndnwsnIODHBSVbwTBHdfswocEqimgyobraByGgbeOcWOjZyWNmqPsVOuyUHuvLCRZgsvuUAxzGJKOlGVsIsjtZZPHtYrrege",
		@"tjCeKMUBJufIxIRByRVVJLXMnSBZwSXFvNldAbmUAbJJreuTtqdKDJYMKcAPPEfLJfbChPbCkFZCLYcuTxkWeWOewmTNUxpnDLmWKCjeGiFhSDbaaimCgFjgEauv",
		@"JQzROChcmfWMZrZqvmVFDEPDdJtFIYBVJqxxlxSVgAYQkZZoolKKbgDcLOLDXkqvamUhOYZcjEaiprOTITXwqFAnlExuznELVlUlkTLwlcF",
		@"PLZeEtpullpvmhteTqqpcRohlGitIEGbxkqCNNOwjiLQSSAuVItzmODtYSCxhrXsWkGGwolsPAabHeEIcVpeksJDgYuefWAorlQuDgsXrFvtGtaVDaRwJfYbyOgbKqdsUmZmeZDwTsakITSosZP",
		@"NcKPzXXSwwicSONIDJNzQMcBPAzKSyFPVPPOHBleMCbdcLiSGYhFEezMfuNzXxLbSWfzhomUCCzSbFhzMMDKWzKrGUnWreLgnwJLCTFKmqQgWKwZYvIugTgOEIKvMuefSr",
		@"QrasQvkkoaoiyXbxnGdfDQPZjNtGnJwEXVXarudlWhYcltSuBmcXJnGsknqJVcxArANMrWwsgFceopmohGcMsscKnxOVsbeEMiJnFBpQkivwOubUSfRrgRxElukWbCEXQYMZDuGkAI",
		@"RnThUqMxiLnCLWwQUlDoklwbKlYSdLnMHFUDqaAqFksLZFXrtFcxVidDCRmHuJRJZJYMsNihVyhvWdCoBKltFzXxzBKLIAtriOUhTN",
	];
	return VZgIhknzOfS;
}

- (nonnull NSDictionary *)ugSEpTYjtwqlzWAFdcq :(nonnull UIImage *)cdqzhBsvnRBEDtVjM {
	NSDictionary *dYTQzPtrgsCpOSo = @{
		@"HktKdowsxvkpxWpsjl": @"skcPoDJpFcpNKCrMqzKXEbrSuDbIlKhpvuqKYHDBQwsiChQxKVSSGkONYuGegasLtHluGxABzsNcqnGYrrHokajHDZojSvRcPCIkIFDBXgXPCCiSBXxKKKhDWpuMXFlWhEJ",
		@"FhbOAkdeHTUnttNmko": @"UCzjbDqKVBdogKpxYkfGmdqJfaiQFDNJdiouVhmYkPmqYPkxNOPlSAolFrmXEamLyfpFQPZJSldEFamwaMDCZUbuIseiBgvfatSqvdNsANdcSsXcdeNjPFHsTJjCMnSdqNunGzgKchitAVjG",
		@"xpzAuydOhQ": @"fCvERTtEKctzkEjvTcoSzVhzQDiqbAxVLyRLQoqahYfJMXabLaHvDTBguxIZHMAwwhrmwKnCrFqygbiDPrHlgZwDeekuILxzBBewSfwxSxEhxqlhAKfaeyzhoqkFJcrECAfXkVRowG",
		@"FyhNvzMemBeUpXNf": @"oRVEhOURoSqPgkfsQCmKTzNMKIBQsoSvWTBrfVsZrPdfrugnCVbxNRgfkhLlHHMugnRxHRtELSVDbEwbVfriWKWLuWjkwXWbQXyZYEQJizfBXwJpdwILyNEapvssU",
		@"AwNGvmCVLIHfmJIobm": @"bODmUaBZBOsoetAaoRoiBsJYTmKNHLuoXgZtLbTzDNhFaSenRlKeUJjmWeOUNCvlGVZyGGsTGdANdQfYnRSvdlYCxzzWxCDKScjRkrnXygqrNwSKltDsCYLfJofVxRbIJUv",
		@"MlQaKejSYAdWnTg": @"PeuxRVqZwtPGXSShysvdnRFLCYVzuulxkCoQpRNiJFDdpXzzfEzHPSOiDZFUIbWmREYYNHmEQXUoKdoDoaklnTGBfxXiJtEDMFRhYnZJAlzIQkAomcdSudFzNFnGrtuKdDS",
		@"gSOjHzakcqspeSu": @"echwpGXXgSKNWPxIvjmgqFiLhpZVgawpaYcnzoAvpbQFJIAMtKmLiZvDTEPLAywJVPrnujreONynfoCcNOECzxbkxtcTZNQjgNverorRVOFPPfEKrZ",
		@"FoNFBtmjEz": @"MNRGqLvwCwHYoHNmLfCGVrlraEBQPApXOcdoiBuIvGPmIgjjcAPyJtbnhxyWgmWFMMtsbLOBpugATUzyNaFeuAyUvxtlXQqGPzIwucfdzcnCziOfhdxJBJ",
		@"ByenNhdRXTZxJZvbWV": @"eYQXywyBwGoAlSvCuheDFbVKLjMZBKwcAhRnxCazJTTsRDAAwMwYnAmkdOeSZBAmtgaKelhXoJrcWRsqzerebjBlZnydOhptAWkwbtkeMDlYNTfjyGtDkqUACprSBERSTUa",
		@"bOpTYovPcmYWi": @"DHVqXHyhjimeCLxVzOczceqXbdiuvgMUDRBZfOKkUejcwfDjaDyIGPbQFDEgXtLRXxveNshmVhykqOBtzhsWqBwZAbABokShwROICeYCqecVJwnAePmNUzDnHZvIreUvaulTldflwPKhT",
		@"kipEYyNlFof": @"rfWgWyllealvSvaMjiaQZUMluOEshluycUpOpDXTBOrUvsZNlVgCiqIvXwAIEsaknNIdpDcDZTvBcRFiWLGlMFgDsIiZwLiyLOYipcWwdRksevtakkVjeNUIbreXDPKcJsHRazchrNaAKlCYwwCQ",
		@"wgmZOWehJXsCWNhlhuM": @"TViGWTZCoHjWULrYSiYgpMDMeTVIuLoNKxHBCJxgDlTOkfoGFWpMFZzOPYSSVBJnpGZbvAlbHTbtToVxvjyiulZqGVACgdLWEDbEYuIHhMlSSnsYCPMfXtXbDbhwwnEcHESYn",
		@"TQbYbHzYJoPCWzI": @"kuLQklCGNbHFlPUGccPheRgZUdlXOLmgejMXOvUQAYXWgcFjhCURaadBZHzdvECWjgfDMMFCzOnijeRLBniLWKgsEouoRfRzsOkIFttwqTLdNBxGiyHqpSxAWwnTbuPmuVeaRrVbPbIknkAglj",
		@"JpQejWqeFtGZbKqYn": @"wgGoVFDGXhfVeDczQNfEkGvFAtTAbdPsrVhaBwdozjuQETVZtUMZrCkFEwHoIxZAbIBjWbhXFtxpJjRgUIfIZRaEmlgHfRtviLSYhklwnSQljPggxsPnEXeWiveDWDGRLKmewIw",
		@"HAjwqlHSdZTpU": @"lrKUMhFZvgWOScwsmPXpYtKHpNBUjFuvkCZnrvZYXfVTpINhWHBBLZpLbziPkWQufZjlDTnCkLplbKlcmvDZvpRgntaPnyseHLbuLBjoOgNoiYzMRJqaRmDouKHjbKArSzqYDSq",
	};
	return dYTQzPtrgsCpOSo;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MessageModel *model = self.messageModels[indexPath.row];
//
//    if ([[NSString stringWithFormat:@"%@",model.targetBusiness[@"businesscode"]] isEqualToString:shalongType]) { //沙龙
//        MainWebController *shalong = [[MainWebController alloc] init];
//        NSString *url = [NSString stringWithFormat:@"%@%@?id=%@&locale=%@",NetHeader,Shalongdetail,[NSString stringWithFormat:@"%@",model.targetBusiness[@"businessid"]],[ManyLanguageMag getTypeWithWebDiscript]];
//        shalong.url = url;
//        shalong.webTitle = model.title;
//        [self.navigationController pushViewController:shalong animated:YES];
//    }else if([[NSString stringWithFormat:@"%@",model.targetBusiness[@"businesscode"]] isEqualToString:newsType]) //资讯
//    {
//        MainWebController *webVc = [[MainWebController alloc] init];
//        webVc.webTitle = @"资讯详情";
//        webVc.url = [NSString stringWithFormat:@"%@%@?id=%@",NetHeader,NewsDetail,[NSString stringWithFormat:@"%@",model.targetBusiness[@"businessid"]]];
//        [self.navigationController pushViewController:webVc animated:YES];
//    }else if([[NSString stringWithFormat:@"%@",model.targetBusiness[@"businesscode"]] isEqualToString:liveType]) //直播
//    {
//        NSString *uelStr = [NSString stringWithFormat:@"%@%@?liveid=%@&appkey=%@&locale=%@",NetHeader,Liveplay,[NSString stringWithFormat:@"%@",model.targetBusiness[@"businessid"]],appkey,[ManyLanguageMag getTypeWithWebDiscript]];
//
//        MainWebController *vc = [[MainWebController alloc] init];
//        vc.url = uelStr;
//        vc.webTitle = model.title;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if([[NSString stringWithFormat:@"%@",model.targetBusiness[@"businesscode"]] isEqualToString:teacherType]) //讲师
//    {
//        NewTeacherController *newTeacherVc = [[NewTeacherController alloc] init];
//        newTeacherVc.teacherid = model.targetBusiness[@"businessid"];
//        newTeacherVc.nickname = model.title;
//        newTeacherVc.userid = model.targetBusiness[@"businessid"];
//        [self.navigationController pushViewController:newTeacherVc animated:YES];
//
//    }else if([[NSString stringWithFormat:@"%@",model.targetBusiness[@"businesscode"]] isEqualToString:specialType]) //专题
//    {
//
//        NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ClassesInfo,[UserInfoTool getUserInfo].token];
//
//        NSDictionary *dic = @{
//                              @"classesid" : model.targetBusiness[@"businessid"]
//                              };
//
//        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
//            int rescode = [responseDic[@"rescode"] intValue];
//            if (rescode == 10000) {
//
//                SpecialDetailModel *detailModel = [SpecialDetailModel objectWithKeyValues:responseDic[@"data"]];
//                NSArray *titles = [SpecialDetailTitleModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
//
//                SpecialDetailController *specialDetailVc = [[SpecialDetailController alloc] init];
//                specialDetailVc.detailModel = detailModel;
//                specialDetailVc.titles = titles;
//                [self.navigationController pushViewController:specialDetailVc animated:YES];
//            }
//        } fail:^(NSError *error) {
//            [MBProgressHUD showError:@"发送请求失败"];
//        }];
//
//    }else if ([[NSString stringWithFormat:@"%@",model.targetBusiness[@"businesscode"]] isEqualToString:courseType]) //课程
//    {
//
//        //根据format判断是课程 还是 音频课程
//        NSString *likeUrl = [NSString stringWithFormat:@"%@%@?index=0&count=100&courseid=%@&token=%@",NetHeader,GetCoursesDetail,[NSString stringWithFormat:@"%@",model.targetBusiness[@"businessid"]],[UserInfoTool getUserInfo].token];
//
//        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
//         {
//             if ([responseDic[@"rescode"] intValue] == 10000) {
//
//                 NewCourseModel *model = [NewCourseModel objectWithKeyValues:responseDic[@"data"]];
//                 if (model.courseBean.format != 3) {
//                     NewCourseDetailController *newCourseVc = [[NewCourseDetailController alloc] init];
//                     newCourseVc.courseid = model.courseBean.mainid;
//                     [self.navigationController pushViewController:newCourseVc animated:YES];
//                 }else
//                 {
//                     NewVideoCourseController *newCourseVc = [[NewVideoCourseController alloc] init];
//                     newCourseVc.courseid = model.courseBean.mainid;
//                     [self.navigationController pushViewController:newCourseVc animated:YES];
//                 }
//             }else
//             {
//                 [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
//             }
//
//         }fail:^(NSError *error) {
//             [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
//         }];
//    }else if([[NSString stringWithFormat:@"%@",model.targetBusiness[@"businesscode"]] isEqualToString:voteType])
//    {
//        NSString *uelStr = [NSString stringWithFormat:@"%@/mh5/vote/votetags?id=%@",NetHeader,[NSString stringWithFormat:@"%@",model.targetBusiness[@"businessid"]]];
//
//        MainWebController *vc = [[MainWebController alloc] init];
//        vc.url = uelStr;
//        vc.webTitle = model.title;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else if([[NSString stringWithFormat:@"%@",model.targetBusiness[@"businesscode"]] isEqualToString:testType]) //考试
//    {
//        NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@&testid=%@",NetHeader,CourseTest,[UserInfoTool getUserInfo].token,[NSString stringWithFormat:@"%@",model.targetBusiness[@"businessid"]]];
//
//        MainWebController *vc = [[MainWebController alloc] init];
//        vc.url = uelStr;
//        vc.webTitle = model.title;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

@end
