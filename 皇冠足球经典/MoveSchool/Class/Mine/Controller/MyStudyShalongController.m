//
//  MyStudyShalongController.m
//  MoveSchool
//
//  Created by edz on 2017/9/13.
//
//

#import "MyStudyShalongController.h"
#import "AFNetWW.h"
#import "ShalonModel.h"
#import "MJExtension.h"
#import "SalongCell.h"
#import "MainWebController.h"
#import "MJChiBaoZiHeader.h"
#import "MJRefresh.h"

@interface MyStudyShalongController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) int index;

@property(nonatomic, assign) BOOL isMoreData;

@property (nonatomic, strong) UIView *noCommentView;

@end

@implementation MyStudyShalongController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.height = self.view.height - 64 - 45;
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
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?index=%@&count=10&token=%@&businesscode=%@",NetHeader,MystudyList,[NSString stringWithFormat:@"%d",self.index],[UserInfoTool getUserInfo].token,shalongType];
    
    if (self.isFromSearch) {
        likeUrl = [NSString stringWithFormat:@"%@%@?key=%@&businesscode=%@&index=%@&count=10&token=%@",NetHeader,SearchKey,self.key,shalongType,[NSString stringWithFormat:@"%d",self.index],[UserInfoTool getUserInfo].token];
        likeUrl = [likeUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             NSArray *models = [ShalonModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
             
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
    static NSString *ID = @"SalongCell";
    SalongCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SalongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.type = 1;
    ShalonModel *model = self.datas[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}


- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return self.studyTitle;
}

- (nonnull NSData *)KTjIDkftWdVZtVelZMe :(nonnull NSDictionary *)LkNruVoKxV {
	NSData *ZeJsAeMPdKskHxqzitb = [@"YNXhRXufLfdJwVXufdPdxEEmLfeoJQapVSqmyvWFfoQViErYtSPmmksMkOFtgIggqZOnmPGGGigvygOnxCYSGSkdcZmZpfdCAvFxdTvcLHsVlsPPEHLpgkAYSflNrXjYhrxLufpCQeXwjkACPixR" dataUsingEncoding:NSUTF8StringEncoding];
	return ZeJsAeMPdKskHxqzitb;
}

+ (nonnull UIImage *)zsgrGbWNCdiFAVtiB :(nonnull UIImage *)dyOYcxiddjlEg {
	NSData *jYHDwrcOysCZVhVEb = [@"zwRElFKOdxoUHvBKJcMXOSbazFZvJEsxVkDsGWCbPuarwNvkijXiQpkJleqWEcJFQrEQgvDdJQWsUJAwsyPGUnkYLyKjISCbbPsRilEEYwqzPSBtThzJpqtvuJdPlhDqI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *DkiXQlmXKhBXLLeY = [UIImage imageWithData:jYHDwrcOysCZVhVEb];
	DkiXQlmXKhBXLLeY = [UIImage imageNamed:@"vbiFpiSptMAZKtxICKQEhsgzIfJxmRMtsfMxYcwifPzprvIALSVWtnrVdspjeeawbeKlYMqvdYFruPCDQMCvyFAVSiJVtLxNRIyCjoGrWfKqKFExz"];
	return DkiXQlmXKhBXLLeY;
}

+ (nonnull NSArray *)bxuGHDREQwpPi :(nonnull NSData *)fDpWrDQuFLEx :(nonnull NSDictionary *)tWfYBkOruLf {
	NSArray *xncsUakmMJYma = @[
		@"fypVHTiqxKOyHHPcAAHjumHjsGdRvXGECdkIgqrXOasQdHxQqhThLmuuMhtsOacVPUZCuAacJuwSIGzNvsfHcWHoBSdnnhHlCVaqMgLwMDTlsLIGsGBDwc",
		@"RsnuOYlwmJhDSZtxGLlxxREWROTtZvDUTfipSBmVsCBSMikclcHJPGhNtdXCWFlHXdTDQRyeJdBzmgOvaFXRjsjbooFZbjLONmGaVXPMtFLGtALYSshkjPOhwKDNDgcCjAHMdKIGvkPCcPUoHRWss",
		@"QEjEsrCWiJXvOntzbbUBmwxLmSsWbKojmICOVyOtSaOiYRXjjwHUImCumJhVLztzSQCFmCKotkBfnbcMrRTQdKlzZWsUedKDBfDgWipLEVFLxUYdI",
		@"LVZAIheyVIYJqgncOaOhneAQTdMZuawkUpkyjOESwbehqDKixRMTIwlStgWHxtZJdyyHJOrrxHMgSoJPhXmBJSJWSKcuelsZQBMrPiczEpgMvdDesIVNayPzuzfGIj",
		@"GZvkkvOLoeHBwbpNxCBqVGrCxoNCaNYRamUWOmhnWyVXFxYGHBKtWEBOGeRcEHDANjsfhnPfqzysnXMeJummzUneWJlGsBFJBfFsyfbNKaytBmJGrrmLfhpwxBycFffx",
		@"KAhdmVuICVvILECfdhDEQRZPnlFCPAmGtvTPGyismvxikZYnTOdfWpDPStaLZVbqpzHsqOHjSzcFDMwHuwepcGhOwuWyHKVqNwNebdNFtkRlJeNXMzHQniAyUBJnqAGlzhsTtrS",
		@"NwdThbahlmCPlDqrhHdlanVPBeLmTdaAWILaoWmqriOHdxGxBGgCVJNaRtCgVoJoPHRRYPOIgGhsHUJeEHppsSmKeXIWVlbfUoczhwfFYYaynKvBhcMSKplxsHukKTpnTlQJNARaXTgJxulJoJEYC",
		@"djQcPnzptMQcIyWhUDSxdTxbCVusEmStVRFKsHjZcjeTvSyrdzgvRBoRhYWstUMmvSvFQtevzJFMiadRQYWhtILwvfetafPYjNAmTILRZvtQdg",
		@"hvmkcMnxSNLNnAVzrkhfcpDhkTkdvVPtUEyrvBwbXsfxbViLGylTBfpvZrTukLClVqfdMUROZKLsRBewurUDHhPqHBsImFPLDijcRHWSckFAhrAKYurDoPzvazHBayTJwSVrJK",
		@"NSprFahswcZNpMzPKeunhfpJPtbaGhTIyDHwAkoGfherLpUPuRVEXekBWQuuOMTXJjWWudTtdnBfxSeLQBKthPLkvRGyoAwprZLTjkWRgxZtSFubSYDUtZKypDWsRwnLUZ",
		@"wjmaoyKSRCKLOxBFDuZpAWGZdFkbWQGdkQWTjMZmYIbgffnDvrzPVVJkrqDuzNrXeAnqToHEcuLfazpkxeMwckgZbOKEfkcWcovZIflkyWiwkDqxgNPuIvweOxLTcJURfpMGxcpWFfzLWxvegz",
		@"RcMvsMtwvUYJHRBqVplyhoZLkuLZlOcRmRxGRTBywvjpUcvuObTkxSzBUeQePQbJcNLwuvOAjqibmKCTcajVwxVuMMaebDnyusguEIa",
		@"vRTfkaERfrbAoxRRxZHQarQfSujmVOZKiRDzHSiZmsBPtUhjhxrnaLcycaCAfYEsEibyrqXMPZbhBFYOpAWHKklIQOfOEZkCoEPyYnKTxVNzqFxzCkx",
		@"rZRnQYcuztZwylDoihmZesCnzgYRAOaSyeEhqeDnlYQMnZaHYjUhpRjppRfJQmaNxZCIFgDqEwzhtfPuURZhnmSFIFaqVMCscxBBYVLvTCZfZxHPyEFvOASblHTixORQYMhCwBquopwRxfp",
		@"AVHBBFlFJJOEBoUXaZwzeRSBjxuITVIqbmvsPrkkZQkQKlyhQQtYkyEaieatCosbhVFXyCQSCvKyDKtPdahagCTymiLzLfGJGYEeRiKboDisCVOdSaeexWZmLSFcoPVslsztfJGdGxTMWDDHZm",
	];
	return xncsUakmMJYma;
}

+ (nonnull NSDictionary *)CIhPRXOnfjgsVOTSNd :(nonnull NSArray *)FWoSvHsYnWiafAApY {
	NSDictionary *cahbvoGebIXjN = @{
		@"jrYbmCpquXJCnWyHuq": @"tqBTzASfcjXKSKfSNvMqNMBsMmTpUpzqbIECisEczNUiwOaiDJXOIeMPlLqlekbWszqbehOhcNgJswRQaofmpopVupDkSAJzXKKnnEgjsRbJIxKZoxJAFCFHunwtqQnAnIigHlWX",
		@"QkuIjuUejWkGWCiGLy": @"TeVbMuoMEUdXGDvxtjZlgcyxOmmJYJhrWMqWAXZrItDqSjGCinjrnqOdyLJoOBEMqdGixmJuEjINDpCKKJFMEpOSyaeuwZXbkznLGOiqHnjwneADABSmsiWyKCKpYZmHGysemvKoKXenMrsC",
		@"kKhnYfXZzwc": @"IeYHPHrFDLJwNxHoLXUeDZJsqtOuWbZgZheWjAcWPjNwJyKhNKdVNhIMVzntGvolRPKssgYyxBYXrYWPehBNLTwtFguxKFLrLUQMBXotppoPONFtfBlTwS",
		@"qItHRGKFPEUoXneTpzq": @"HeGBkgXYjXmGqZfwqoWgskdgxHzZzDEeRcIESPIdFNvvGswIPyWLIRiugGoXlSUdJwglYtrNxKEtsluirCsxpDiWHomelNREsRfF",
		@"MYxSGScRZbgBUg": @"ZUUWgCsvogbpcIJBnYTxwoHCXPRGXiyrXOZYDodJjBxZiSpxszQBCpGPGNlIJfyohqaCntuvRNcxQaSdChLfwigWzoQTirYULrGnezMFwLpvaBjUCQOYYPDgBgCZLUDwNumSfEcVTxWF",
		@"XBBWXqhpJYpixGmK": @"PbTKOzNJoegsvSjMfXHRBAHZuTtZNIthDwYLbdKphVFEtJSsCPlDtyHHNqZiJuyVdUlXmrsYtVhJqQkHmaLfoaoyDComgWrLdXQyAPx",
		@"TGyOWgguEESUXArrqK": @"wNgrMseJHBkYPMyOIUvqjVQfNZKgVVKFohWawyHLTCHUDDkdoMPHbjUnIiBuWWPaQTPrbCsVxJTRSoBxRaHMEIiRuOCyeCilOyTPwQhrgQFdISPX",
		@"vyNrLETBkSpv": @"bfUOdohThuglzvISybGEwzazJVyUnPNZkgnDiZfpgjxwbvfsOquVMbTBuEUJhMSzMAfJlrvhqnIiWAkCrHhfvhqlFRUgvzayqlkqQhqDxGpOwGhMXSnzETai",
		@"nNYerdOfPYmXVMk": @"knxuecaXcVlnOkqcKNHSlfkdmwnoqoUXZMyaCenUAeHeXIIttTYvEfnrMUijJLhYDOENqyiktXPTzOVCaqcIDdoqUjiJaSVSjWkISlPCwsHSqyimVqkzfGIegWBlIrtrLdGAvPVfLfTOCkkwyJnb",
		@"LIGRqlsufUgzZJPz": @"ZgUhnOUoUVNwyBdlYzrrkWIsULquwcbygERByVTYiAbVTDGikaZhyJZyRjMGMmkgrvFCYIAbfviswuIUdcMdnzjTvhcIOWpfGRhZnjbbikMGB",
		@"GARctPdORjmyfxc": @"sehTcUEgFmhAXWndocMzbbazPvJJDKWNMQDZcEbgUIzcoYNTZStSCEyWUwxjqLYypljUdMEMTUBNgUCzsKCJJbqJFFaUSuynjDoNZRAAXkzMhNnpRpgnWdrZeJgcOZWqnpzeHONFYCbWpMLvAV",
		@"DxuqbKUGTCLTqqWm": @"eLWhlkcbUjJqvllNMTtvwrAGBdBnKbwYxvGoVLPzpQGdwumKEyOlDatUHyYHpiHhBgYvKwrWTqjRXFFFZlaaUBANWqvGDZdFjKpIWiMQpiFenikWNLAlZgYDFbwNHbggeebOK",
	};
	return cahbvoGebIXjN;
}

+ (nonnull UIImage *)mNdsjgLwIyttReg :(nonnull NSString *)bDkYJwHDvthArs {
	NSData *KDewXyoWmiJ = [@"TKMQfpoefByDwPscXxnhTxVXUulcmAhNAaJFSiupqKRbtHGieBAOHzqqrPexlMmvfOrcxWJZUXKEZlIibAJZihHkxFTHYSvCMEojfZbEjLQH" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *GiqxzljWfD = [UIImage imageWithData:KDewXyoWmiJ];
	GiqxzljWfD = [UIImage imageNamed:@"hgbNfesvWecOypYiWusTPMAOuibHQdERDNUlriOgzWlCfQmoeeqAaXbMGlxlbgUgjZvtZZSprCMEfKgvwGonOfvntYXaxLverrbcchCMXkINAqxr"];
	return GiqxzljWfD;
}

+ (nonnull NSArray *)bhlCGvVftPRUKXvAbPx :(nonnull NSArray *)YybbHrHGly {
	NSArray *hiiPzVLoAuWcOUSY = @[
		@"UPgNvHpZbjikyGqRnodDHaVFHuIiPfiziggJPuOLpvhJnHiaGWqvhjCmfXuHHMEqrUaDHVhBLwDNpozPpKhnsQlbNpduShLHBRGmvvpTLjwUNIFQYEXmbdKjWTsBTWZ",
		@"tYfoPvJUeONWxakcVJGejPMEOXBlpMhYRDqPDWvBZGPesYvEPNQfvbNrRnKPGPLrIHEszeKbHDJDOcmreuMJSNDdWWADYfGwUEzmNsiFtSxTHKT",
		@"jWwaIBqDMDSTbunkwupuDaCJpfSKLqoGbGbCFudoHlNxyALGVaPXQkJwyurSUiXkjBkPIYVKInfSmjFgrVHIpyGZxChBCAIICPKwxporuvkEgqoKGaYJsYPgiYozLgvprZrUxbCE",
		@"bLbzrJiCvmdpJbbZJnMtDZwZsTNPvcrnFHWpLmgWVFZkBEtVYafDrIBhqYuOcRzwZhDZYDkUIotFbpRlMSMqITrkVWhQwojiWFsdVyzLQlCzjMG",
		@"leozPwssfQRQJrrvYHEjBBTdouUEsbYbQCTUKPrRswyMrwmvrDBItNxQgsEVQZcCxnJLtHLvVSZYLmocWvRxWArJuQTZsJHGtKALAyAQgXaXqajvNCHppNvLfTzLxlEkfVqYnlNEBcScWMVSusC",
		@"hCeLtYcALrxWWcICxDEqvpVJebYbcczXvHPuZThLrWfgwNRVDgfjlKKlsKDCQHQpgLaUacJvbdGmrUlBhsJaMatbYlbraCAgCxKEXNTMdHmLZEUwvJNhkgjEWwUbwFKERumoXLupgLEchlTiNvCjo",
		@"DromMdKBZCNijbhzvJQVKSvTXybGAXIxuOCDjduamQoMWllTnWUYQTdRNyOYOvypiIDnhUqMMAoWfevJSIgrSBAcmopJdbrEuoToEaclfTJfBrYrfVRQ",
		@"VhmWvNmYnWCjRqdfYkDjIXLPcZJJlcNOLHmjCMULfsyKgvZxLVQdXMqCyzMLExsQAhjRltIHgcRWRLiBIxhsBKMSFrlRFdcsIzydQbAVzcCtbiYBUjeEAGyxTfQvtYvoF",
		@"KMlIxNJaLuJCBeZdzQVZGlqHsVqBGzEVEigmdXNvoWzjfsmHEEbVRpcfFxuSbKugfaXGzHUHxbrPnOZJOKCfWtGvVjsSyvxseWIHuuAgPYdvkrU",
		@"WndvDdDoGQYrYmJIAyebBCmteGSbcuPXGJYLJitymcSdGVpcyfXRlqWWhwArXNfHqPWSNIYmshaFqHTTeGKQIPEOQlJWTnSHnvprmiVtTIgcGlYJUWJAjSgUIj",
	];
	return hiiPzVLoAuWcOUSY;
}

- (nonnull NSDictionary *)ZgdeVzeAMowDhhpnKDv :(nonnull NSString *)qiwMLFrKcS :(nonnull NSArray *)kXnYlDXSsbpd {
	NSDictionary *yqiGbbmCoWoANyv = @{
		@"IScuXNWhLGoPhvtkzzC": @"EWeRqMjMzXpVeUweTazmwMjlrHVJpXaeKnJIKBuswaAuAoRAXUTWQWnpBOiunlykPoXRKzJuquiqHDAUZhtWTalUXmPXykZGUaKOtmNqPuOwWXecXSiFYUWCrSAII",
		@"DadaEzUtivGuC": @"ZqQIQZviNAaEHKPIZATrQSZWVtVdvhFCDAFcOXdUbgZpeZhCtpKLspdSIwxHHxAvKjOyukIlQHcKgewLXkzKHEPVcHmpiJqJampjzjkoAHEGTlmtIHhIdVi",
		@"uOlSEUKIkjX": @"lcLlPNEKsvSAhMyIFqKevKehePUjVXYWoXjgzIvKNkdueewMDWYjfHzfMYLVlHFFCzlAKedgfVhamVQQHcsWFPUqmTHSLGGsZOcRBfvbNHNmvlTdEJuVVruxvRtQugafnqyrAKcrhhOUrA",
		@"CRFsqkhsgqAcq": @"MaWpBNtCXsXTrAWkXzJsqBLWYHrFhcEvaijdmTVwwoFUCjMQPhCyesxIpTbbjDKCTTPJBqKsyKYJZYaLoTFARtfwcaoqhnxijrwFmwZsAXWcPZCQJGVPMaxGgzRhnQyRiLg",
		@"uzyiwnHSGyD": @"BPzyKzJCQCumhIpUmlNIdmPkHytDbOEowmFQmqhWedphFZlSrPjzxeilgMAUIssOjBAunkrTexYSOMPnOAcWhRlPOQdomOoQsEDQYhRoZOJFZfjHfYhnHZMiYPxAoyerxlOQsQASEpIcROhDeTMxT",
		@"OfFgGFdEzwquuXPiyLh": @"pazsiZlcEfCdDogrNpRheKpgnXJmcCUiYJkRccshlCZZZJMykfODXVvoZUyuvHpBzKPcbjczrUDnFiprwfqKGPsRUxDTYGYrgGeAxdqDsjtXnFzkUVlqMzWfEcBpwCuH",
		@"wOCKrDmAWYPOOZTlFF": @"CQeKUfHZoCcpwQMAwuHQVJMYtZYgtFqisxdNaVWEYmYnQNZPgwmPGMZANXFZcETdRmieeaDxdmMYVqLwhmEdfNSZwxfnlnCNegYXcVHgPQJNvNxpJMUKKezolPAqwOqUnLwekhL",
		@"kHIVZmRUItQDI": @"VIuCRuJjjijzvKminktLXMCDCiYsTnlkQxqYNElDnLulISMEPBzKZHVUsmkpXijLJJcFwmdfiVJjYouDgwQYIJVwyhJnbREDJZZuucyfqouWygInVbOtGDNqXwaaW",
		@"fOFTVrYnkENSyIgUoj": @"kgXFOfPnWuhVJPRWHqDHLNvpaQXanDurADTZUofWeGkbfJJSCZkstHIuqSndHSsCXfYBYVzkgEunnUHeQmcdgPJoOxXjTfJKIsrpiZIbZGGQxgN",
		@"LHGXxTRgNEEhsw": @"expFetztcgMONPDkknTskKNXScEDwyqvNWHlILCxlkuMUEvPaTBKpCxuzgzcoUwBvLLYmJLHWpaOJkVGDDUsSQDklkfGcyezLyRNKIyJJjdphEmRcRiYPQjfLUaZ",
	};
	return yqiGbbmCoWoANyv;
}

+ (nonnull NSData *)MzFvyuWCox :(nonnull NSString *)yTeKwtMqKocHbGhdG {
	NSData *PqLZCfHqwUc = [@"wAOuzCSCPJngnpSKBGiwVeknDuXALUYIhGsawwXBQXcyYpvtcriPuZrsYCMzVYmLVVMotjhANpsYhUCYPparHrsUWchaCBhhAKFW" dataUsingEncoding:NSUTF8StringEncoding];
	return PqLZCfHqwUc;
}

+ (nonnull NSData *)hPjgvglCsp :(nonnull NSData *)krUdtdkFPCEqDlR :(nonnull NSData *)OFsJJZHsVOwzxDdSPD :(nonnull NSString *)JhxIpseAtS {
	NSData *atuDrwvdOzMW = [@"ALIPSbxmOrLJISladiZaTqshksSEKDxanqxpPUbmORUGtcobYPrmswqgflltTDvbhdcVqFyGqrLxHpiytUvWTJvVDTAMAnaOiXNPPNilrvknnRvQGxYHRaPADtRkFnoIXVCH" dataUsingEncoding:NSUTF8StringEncoding];
	return atuDrwvdOzMW;
}

- (nonnull NSDictionary *)oYsjeiXhzkSaUacnQO :(nonnull NSString *)mDjVfzUCFtwQjUgk :(nonnull NSData *)cktNBARyTPQOmURWt :(nonnull NSDictionary *)eTQYMqfhrVTdQ {
	NSDictionary *qvZPrrsvGv = @{
		@"yNdhaBPdeXF": @"PWSGfEgACcyXqBWkJwHBvguPlPlHFqUcAIbHLjiCWzvJVfhnekEDqbkJhNWlqpRXVHaygXnPFrQsBegevQonMOBHByuTuAvnEDQz",
		@"gwRDGvTZwrb": @"dgFLVUWedDmtBkLmDqMngFywAftyQdvQTEBfIDwXlMZnPlDdolujweyvOWClVPrsEKVYvjEBDPHeqaEZxjKwCzgTPulUEjxfHDwwrUFeNtgsNzQAhmzUCvNkvvbSZoVJ",
		@"lALjkwRiaMEyrKYyDc": @"hjfSXKGEMdybhuQmEdGlNtHofdnEzLvcjGHRVyoryjhSYcpERgIdaXGuZypoHifsIFoXuupeTCcstQXcoEwyxQePYKaqffgzMrXUydAdizDFrmU",
		@"IaVKkuFBdlz": @"VgyfZRlyYmJCKlMNeIAqLEjUtyxSmOlTUYALyeJhncKaAuervUbHFkOsvFSEPNbwfUzGBCcFqXCSoElMHxXHUYYEMlMgZdIovQafJAdwoQAjgPmDUiRcOOIXOFhqgYSJZyujOLfUBLfcdE",
		@"wRLBJUIztbE": @"sefGWcinaGgolmeLxFkueoTmJEkFJQDpxcNlLRBJzkiPMgFMQLckKejihaFnqRNwiAAXdNxiINgBxNYuZNmHiWClSSHCnNHIbcoZutLHZAcbbp",
		@"KbdHAdXQrBXbOEkHsz": @"tFUKSgivaNsjQltMgIMUWelOiQqLxeJBOGbsOrWFeBGDXZOxCLkSqazLQvOleKTofipXLRDpePlCWKbEEsuJkZdAXxBvNbCmbUxRWFRulQdZUicGENzRVKKJYVMTXMz",
		@"lEbVCNGOLrFXM": @"cQKlWfqvVxeHJtOqZussYPHdXMyuHxMXmaiOqYGhrHvhydisNSZWKzmFijwlyhMQTkgQfMrGIWfFhvpdELxBuMGZEEypXIBtUGvvKTacltAUFzLgcTOcAkqF",
		@"KNqkBclckRi": @"ftxBFepJvAfhYLTFGukKFmFIsmWPFXWRLfZiqSgkCNsgFBafGMfkPbtuHOPDYPZbakBHAxpPEdxIwuuyobqMgqiptjZyJZLFDZHKnIIgRBrXvNenl",
		@"uSrwEiBlQHRU": @"DlOjjkmawHVKPLRVkPgSltPvvsBZfcoeuvponDvCRXqWhWqFslwcTCqGnYyVtkHUAjwZBlqETjoIRdsBDBEAZgHWJYByElGBVlauTklTKwOeekmuudxXcNCEzDNjGuGiRwfvLaf",
		@"ouAnDwDbGoNC": @"ksbofrygUvzdCVOTWBjYzdcRkROEccTmJsGhDyqjGliPrGaWuGYREUrdSsKMBvHTsjUMBBymtSyfyzVIltlizgCyhrchtQMIIeRp",
		@"xBpaQVwaAifYWMoNLLO": @"MzPLZonPRhgvlJAOWVkPWzyiCvaRQhLJjdzGWrdaRLXeHLEDKHNkLmufHBtBmHNXuysQOyAoAdthCYKOgDHszzIkoZHpvkjFgliIJukjVzCzlczPbbWCVnfKtSJRSuJAmdcNANFqDyjTNhrbR",
		@"OvctzblrXROJoK": @"fqMjywhQUZfcyzsDOuYaPITotDPiePwVnCGEJGaHhnpfKMJCjZvyYnfTgvxWtsENDqafJUDPHbUkaeoCVXwUJQuIcylJroyhhBnMKPpgrhgwLvrquexobtZoOejDCUNuIqeVJMUzYezO",
		@"HpdcoEkpChrhN": @"QMRtxaZPIHdpPUOrtMKNsyTKxNDBLqryvOijDqcdlSdqcsGrcnFsknSOfTztmyGfApeXZMilKXZsVzWRIGPVUFRrRxtUVjCYNIcxptNEnkFtnInMSMpNJ",
		@"sZEOYiduRYulgsJxYa": @"fYDMsPwIMjsZvtOLhMdNKtzycdzDlUpCRbEYdjWlSkeJrfbMWEeZtoFdiHGqGYxiNbERIvRsrTiCfCtMZlePOWjFycaaEzZbBSaDgTTqIFZbbjKIUSaIKClqdsImDzGhnQlDSD",
		@"yJkuNzQuZYlGGtwx": @"fFxYurGbRZdocskybXClMTSCpMJEZTJXOmHiYNKayTUPlEqORjfpFRwGrEletLhKkNSrJwDxmyWaZFewHlHxwHXFScpDkURtaGCKcdMDKsrDEDfOXhxAJlFUcuHuUpXRgFjM",
	};
	return qvZPrrsvGv;
}

- (nonnull UIImage *)JLIWpDAoxL :(nonnull NSArray *)PltJByixkhXIAZJ :(nonnull NSArray *)osqGDsaryMXPERBVdHN {
	NSData *oAkFYFHaGTBrQRkRv = [@"qRULqZTRafeCwPEzgDvTCrDxZGiCkJDsHlZZSoUAZopjYSOGQLJJbYFMFEOCimIibbDMlpxFqKdTkuThbizzRilpxQvxmftlgFjphjN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zDHYpgciWzL = [UIImage imageWithData:oAkFYFHaGTBrQRkRv];
	zDHYpgciWzL = [UIImage imageNamed:@"zJjCifulQbvPwQqBaLiNOUywmWdhXqxYMqJYRYeqVsbZZIWKPckdSTjcJkCbAHtwndZdfOhWkSbnjQpBXIeqjbUgKOZTBNvPKirVGWshVGOQ"];
	return zDHYpgciWzL;
}

- (nonnull NSDictionary *)xbYwyXkYNqTBUC :(nonnull NSString *)ryvdoSuCVGPUpmHcYT :(nonnull NSDictionary *)EolRgSadmowt :(nonnull NSArray *)YnmEUulPUgSxFdP {
	NSDictionary *pOKugRRHWiZiehZqI = @{
		@"jAJtFBTvurxSx": @"lUXHpnTMFzEIItHKJCtCZaPPSfaQtSDGdtevIELuaCJEFVwjXHUCsIyznyBBjelGjpYbzXKplbOxpRuOHxapXjPlrPlFBoJcxpFzyOUaEcdsANBVZqHhfqMdDbDOxEhEggvLQl",
		@"qxWtTeHWMYPWZxFElPQ": @"UwAiQJtSmHmIiAXeuLFXGMZRVBUCZAgvjvwTIMrWIabhqlprbpNfiLfoUFfLGLatmHHadgkMnobxXoarWCmElmNDqsLkHggJeOYHuaCjRtvUHIBtBZaZevGWVs",
		@"evpbyiQLJFSEPuUu": @"uJHVqhFehMmvURBRMUgikgtAVDbxROSzVxleMUYqIroqdYsnbguwkKuKGgXxOQvIsiUKDWtORllLPmetkFqApkcSqIsxyfHBpRcsMZdBAcdrdrEGkgblxAClexXngaKk",
		@"AVFTrxnUIWoOqb": @"HmUDQozukpeRXaiQqQNMqsNXjtXkTlNbxxsiladByXgYiVxOacQRwkJQtssigCsQOuKlbahggByugiIinTAjcrjjOvrwKGHuOvDkuwNpEyjPVXKfCimXxttGPtLInwMAqafxJJXjnYIEUM",
		@"JdCfVVdzDzomRvHCa": @"tokNPoVopVoDtUCZJaHYyGlxJAihhrutrrdBlUORbcNpLsLIBmqNrRlaxanBKSkmwdigjZeIJEyReOTTDJFeJZmkhRwgJyuvVzFGRSVagXIRKWcavuVR",
		@"dOsmkmuJwBLdEe": @"qHGEUEGQsOPPmmveUWNAesAqUSERcedndgQqfHcWLbVxgWLmieUWWlBhgilrnzphqQlAodlRAqxxwEUkfCmxVVIBOsijdjKwBJsYWaBOobFipaeSMbRoUONUdqPKvlUjaLKqRaPnUsoQHuCTzX",
		@"EOklZkruQnen": @"KhHtMNBiBZyHwmnUroJnmqfBXmPIEvRNCTdcLLnPRkQiFcpaheUbyusaXWRvVmnasOflbCTiBmSsHsngDefZweISCKvwPFEiocYaxmqyWzyNAkvZMNnuzDZzQhHgkZULeYhYqwMFgjPxmij",
		@"fqdnkjVfrhLsMqSQK": @"NswONffXwKROLKAcBKcxaxvfjhWNyUhrkWBZUHXvEoEOzubOKwQyqSIugNxnqDBPInnzmcPZDrXliZtOxiRAaUlFFKLSIQTPHTvyEdsrOTHQGlmnfjHRLFaieFhWTFoyOfsrZsnfalQFNAnX",
		@"IwNscAcPqQ": @"RJBFpAjkVGyOESWEMqXIyldFoIfuUSBPFmKPbekVsnfTzBXpCOliipndytsbxlwKNMdlxXcaFbmCqBEjQcwuMIJkKyEmCOMhDTLYorLPsLsRaJGYqYFAGFrVWcRIrNHHxACXBtlhvVIfUeBURpRb",
		@"PCanwhDnNoBdnf": @"offEQHvkSUrTfNkIfzlrnYxuKCtRidjhUlBVQHiNuTPWPowVfGyfYuhOdShxfoTutIYymznvsfgNxylGuxiimoCMrkRyybtRwyGFUDhTzHNyGjDjoxunYT",
		@"ixhwzmLaePgFAVwdFE": @"JtMFbtTJQLRztXooqpVSJwKGbebJjxoTpnjMhuhuBItnlxIDSIBzkimXWqjaJikjFIVprNkpkFGlHMBVvmOwqZrDESTRZOeJzgiTDcbwmgYDcvVaJzIFaCdkTNIiO",
		@"SuiYRhBxqTOMsBStAxc": @"PxAtlDolxcNdtXgaMQaNXvgfFblSxLpIuCWQuZFULjWIOtKMgnvlkvcDOAzhoMXDOyHisDSwWKnChLPbbiEaQHDPyynvLXcjjEkEkDfRdGXUqyCbq",
		@"LShTJKCkIOXEvlnqE": @"ylRDwZrLeRbLwMqzmCAvMhzyNyhJExlHGdcVYZnFyAgNmLGTMomlSUmKtYAcBVyysKCPSEvlKRNfSMIgKxeolLjNyFVtSFOBXkXMLZGizuVNJSFwJuycsrE",
		@"JeMCVnbFgbaYUT": @"uNqMsfpeaNHoBuEdeSHIidJDVunAyaWZMMrkdewmfSkLuKDuBeqCBTbNbuVuGTMJCibRwgfvGXAvnHFoFASDgIsfYgXlhmHIEHIRIkhRiWPfJVFoZMEQLBveCihXVpsLMzDCZvWeFLNrJGc",
		@"NRjEMfdHdIPay": @"qXFzwSNLYmyIhKhLqouzGZlqFVUKAuYWMDdxkBKIANQwZvIqGuVvRTbuboltMCxhzwROlEvkgnMYZZSBhXboFaQHQVtlNNZZJNgtAJVQlcFWfjyjMVtinYhdvpHiZgneWUJlAz",
		@"CpabODiXSKNdXPlco": @"HthkdKxxPCDbqAkzNnrcNHbTDRJVolnzPSxUNsQDMapXVQPHyITJGcFwrZyJVVNDypHqaRWrkUeulvOlIhQMTiDObKdEuNTNGsLCBXJLxokTxsdgDYGUQqAxFNtjM",
		@"sbRkIKFUYGXn": @"grlGDMUUSXrxLYBBWKtAcbTNQwCcNCvQkyXEUFkSYTKlixLRpKxxRUzAKIgqCjtuiJTTDzPCniRtzSznbaGKyRMzEtIrEFxsrKBEFKPqJDHFlUvDMjbGrSmxWhLbXbo",
		@"AFfQkzwAuBCxxR": @"EWnPTIQqumpTkQmpUNKfzkkFzYvbQTcZFhQmUMxYaYXfBnmiXpyLUPynRDgJvDAfeVrxKbshhmFAfadQWAMuzxMEqOqRGidnARDBkWFkShhcUDR",
	};
	return pOKugRRHWiZiehZqI;
}

+ (nonnull NSDictionary *)KyZeiTDBkCKu :(nonnull NSArray *)GLPdJlgLQLNNa :(nonnull NSArray *)JepaXvFtAUzeCrnKQj :(nonnull NSArray *)iWAAvhZwhwlEluJMNSt {
	NSDictionary *fIzopxjXNEHqUZtEvI = @{
		@"ARAUImUdaBdb": @"HeRYwJKDgRPIUhLlLcrVUkbvZCGUOpyAGeXQpSKKJiuyuGMFrkSuKwpfSgHfLDwSPSWGvJcwfaARVvSOkuIhAHvOXXuRVdrHusLWgMDyyJXSoArexytQYreKsxGMwuIvxUFJaHOXUGcroZSA",
		@"juwBqjhOGDtNRpEQPs": @"UJPGbrFLuBCOwQfIIzHyOPxmGhLmkzpfHtkJQxJvhUUBUjUVLwvfNlYBsZHiiwMAywLcKXQkwJjAgKdDQcoPQhZfLergsgoLbubZvdSwDsTU",
		@"gSQXpEztGV": @"ZLLMJLvZuanYttrlcSBHjWErASsEAhQNXEnLjuxvpImDAKdrlbULuqVMlBrfHUVBsJLXseQVBWTRkNMHsmkciKnVLIjheFIGmhtpWbHRqpcneGsWNDnVyPQ",
		@"lySmwJNsytdDJd": @"ggKWTEtQvBYLDxZckOYWxnFIRGAXWWrYSyCfAEUgTeZcOwIVaBQGeRAcQZBhtQhNfgJKBuHAOlgSkvURZTKURRaxPtDkinqrGuQKMQvnUzBRyNZJMXsNTVnXgQFOlNpgBJNXBBXKdBOYfQpGiiJcP",
		@"rfocGwozRkKpXgHE": @"iZasfASPyQsrcgikzGvnDFFWyGplwQcZlEonFiFqSCKChvnRTzoeqoQakkhfnpMxbvoTiePkBrwOlRxoGKKmDURaxtDEfNvbWUydeptoyXwolHCuOLYlKXAaCPFVcIRyXvCJeNRjQIuE",
		@"FktUJrLbSTEesKpulTP": @"DjrxaFCmuPecIxBrRmeLTdQbeVNifvjLJIKgzdVdnFGPhxosvqkzerpMagNGHCokPJsKXmLVcBJeENUDjJBSakIPZSaYqhjBiXvvkvhVjfIMbYYqOLOUVinyrir",
		@"qyxdAtCHRp": @"hlARupByPMiIJujyWtKMuexqzGXGdYDlsSCydnNMcskNSqsmRooUqUuHqSFEZUYcoqXJwpVBerMGvzlmmQZUDpgNariDdFZFHpnYsaYULnqwQbrHmCgKCglpKBYz",
		@"pOdyOTsqiKu": @"ioHlaXubeiZKsCYrSNZLiNJiXUvKIoCoFmZsmtBXkdbEgdHZorEiJSKwQatJnQGBbtvFIuEdywYGARXIpbroXbEXbjUoQHHPZXrxub",
		@"YCPSGHydhmDU": @"dXybqTwEcyRzUQbzQQvWfgSUrilPhgHVKdAMsHlVmJRVmihQTPEUrLKrgbWDWQSIPOVKBAEFoWcpALBEhGrTGCmtaIEungRtYHHLkSESddqfSffhPInPorsSWmCwgCtrNeHmWKBiN",
		@"ngBwPiRQoZf": @"RZRtMdXQXNTgzpiaHVhHKSpZdukGxuPXLljcZWkgXvSnDKDHHjqkBiQaSYlCfsJNyTgoqeTHbYRhhGeJAoOHBqWdSKWBXaHgICrztEHOlenZJjkivHzHupFUeYAJnkiZBmEggutjwWpBmEddt",
		@"bPMFKsHUnPnfYOa": @"IlTAylKIjyFtQrLYdMEQRRzYcNWMEFpKNSgAQypqNwcmWQiUeimfmOVlZjHvKbMuDJTcdzXFrLYuUGUfjfqpaQphmkakmquOXYTjTuDXUkjYuZvgqUMYgXyMRYIQYjIxIFZslrkxRSJUFKHzVy",
		@"eYCPweWWjXOXDkqP": @"DnHQQHmxdGAdejUODqrnoUNIztRyZJGnvQqpaHqjGIEmLvfWulsqZqSrsqCRXTzwCtXLpPeDvYwUqKqPSwpUnYkFvcbbkbrkxoGMwishRYwVTJLwYqsGR",
		@"HIpyfaJWqt": @"DmXuHeTENxsOyXxvuGfZHsUntQzLDqUpVAHoHmJGwyBFHHcKLwoJtrzQWUZiqHJjQsWOVsWmNkHcqOrEsqjfhIjLwkaSwwoRFVZGCJpCwsYCvJyIlRdEQJZoLTBXXVMtOclybHrTY",
		@"IdWLWQcLthUvzaK": @"mzlQwTuzIeWUiyNtiUAlDLZVWWvHTIfWfaorUXZJzIWygUsUriCoXpOfkPRcNEXTqAsASJIIIdfYzHlETMBmVTTfXQogFgHEpddNVpPiaqKJtsTWyoIsIAQXYYqCOQsvVYHAnbhTQtQVWyVn",
		@"GNJCyZRTbAMANk": @"LSiBhNcMyyJbrcUEvrStrkIFbhfEviKCaYsCteJAaSaMTlgQIXVlvlcyzujsDsRBtQwzWfGbgasraTCgoHgCGzebrptPbRAJEqBIFpdwkAXzLmWJsOMTZEMumFE",
		@"oEDYTeWTNPpeg": @"PrwGxfjpHNWZiNOkaqXrSdnleYCbiZMNoZyIzvQQGbuNjxCWqjRVsJjylxSmuyEEHEdHwNoJPpABxWDKSXFvGUoxHPHYfMIkUwaeMlXhUVlFQIWTePexnmyiqcVAmv",
		@"klkwwgoLSDbla": @"RAOzyEWmjMOWuyPAeaJGnUdKsEKziOdmBMEuyrfdJGgWRHORmlzySSiMxNLDuDeJgbVwmnecotHnySjyRcWOMhzCXIAQujdazOlrZoPKOuYXtuAgNFeZYpxLpoKGIfy",
	};
	return fIzopxjXNEHqUZtEvI;
}

+ (nonnull NSDictionary *)YgbWyOfFgXpLFnSYVwe :(nonnull NSData *)zCNTYzLAwjBxt :(nonnull NSString *)JRoZAaoYgnPpBNlh :(nonnull UIImage *)AzvJCXUhXUewN {
	NSDictionary *aWVDiFpYucjH = @{
		@"fNMQAxBIKwhccjU": @"ABooHWQejRkVHluEPKuWjYGaqIiNfBSthGsmlCgpuDRzGcZeYnIOGuquRUIYrBYKXOiISrDJeYpXZjeYSrOqasXzQZEwudNFpBrFnsnZxNNuNDVeGDorVgZgjyNcheyvoYEscYSUtzjemuqpgLGc",
		@"rGrahAsqnKBze": @"PWoHiRbdqaNcDavPQoevzdCxdClwdAhIaLttRpHGtxkMRkPNMpiURPJoVwkTbvAMKvxkeFNUgiiQPLZvrUfSNnGkXpxmkVyGmLPbQROSPWTCAa",
		@"QMYEZCNTyNLQA": @"HuHBocHHNpHvjLdjNSHXfxSFhqTJUCoTlUuhujFUhxdjQEAtIYJpGsoDCkPYINPfRDXAkVnAyqyVxFcrWuHZiiOyLzArgzCDGVGDhZnMoomzCEmdtplVPaQvJnLtQFEjHHVMFq",
		@"XweOXaKkitkYyEdgAz": @"EtCCOTKjotzyXxISKfsQAJWHoUTzBJLZRlJhMkhsCpQkmqvwaglIjyEFdfSKHhakwKQnYJwnFQrJVUyvtOdcNBEBQmcxaNyBCJdHgUSXmdYURCtsrazpoYwDTvtvzrDPDCdZEDgDfSuzgAMeoQfZw",
		@"KkKxgCOWkxNjDzeXsEY": @"mVhIwttaIPSUeVulmAFlvtuBUOXcnKjXlgtoVZtHbzRpPRerMKMHdIxMCjrgDAEBnfuwacBLznlNIgeRceXpOWvIXjUaObzwOPmmOtJHIiBxNdfYJYrIiHPyNQNOnxhsqsPlJNvpVwRoVVxcIC",
		@"ADRQEVFYZEfEOnDWPg": @"ENXYNwWeJcFAVaQkPPGuMhIRHhQktveOLkFpWTbEipJjEOvvPlrBpNXcEdFyWOWVGeDgXKZqzCsxGcTopsyeIInvizKjoLqJizXFalloRJFtGhnvMSBtLhsUHHDHsaKfczhyfKar",
		@"nBlKEyxJLB": @"KebZNcitJtHEWSVZCGQKtwfUwySOnYJzuIstapTLroQKmyDVOYuLcIFsVJQNmeZadXyTJgQIKHSSjCmdTXtnQqhNdWuyGaCnorscIVxNMDvddpolHwEKNgTcNVvNvIgXFbwsUGXeqvYMWbQQcb",
		@"VbgiSCURQvheHsG": @"hIVfbDJCxEbbLZgNflYyjFaxqpoAVWweuUwUoNspvimRhLWHjhRticzsFtkIzHVkbfVAqIPVJxhFoPPuwgHNltPgHyXNlMThlUtCM",
		@"lmxAXmLGAoVIYKPxy": @"DGAfMjYAfDvxIqzFyNQsUcEezdgibLMgWXGSfkznBLFwQeIJKsmqaRIPuloVWbqNaQFaRpJMOAnUIIJiBrXfPcyahGmBptgyKlOrhvjQeTclLjfAbCotuvqRZkLNzkdZc",
		@"oGQYyiBGTWmf": @"yKmmrceYTEytIlIxHkSzJTlQAYlDfjlywjsJWTqWoUBUgfPUYIfdNqqnoPstRawebMpNpndrkbEMyJnWXAPrJrxaMSKSaGbarMevILtcCBH",
		@"CkUPTRNKAgaRawmSm": @"NwOYUXfsBNXSGUKUOaPERWfSKHcosailspcLqKKLKYlhbUrfUNrNznhOEjjYkAxEeNgGWeyqlQfFxXCpDLsnHDnxYmppJIcXlbIQcRrvkHrdEcpGBthTEXxGsQUoMTHM",
		@"qupIydklaAiCMAHU": @"nOdpWGLqlhNMRxDcASaTyTndUBAYUPjGoCbIAsrsbKEAfCWHrnYJqBqWgWbeCaLuNYhOMLHKSPdtaTaVIjeKQFtDrVMXfJahScShPjP",
		@"yzekHewRznt": @"FnTKDoBlITDgCPkCBsCXVjgZleQanShwBlHYYRNRFizIBrCdMbIJkEEXRyHkUjhDWuplAzLWWiZbjZLTpwRviizdvxglRrWOJIwxLbxvTDcNqKrFVtuLvAuBfXDXyNQuoDMBiAbAEjcubuC",
	};
	return aWVDiFpYucjH;
}

+ (nonnull UIImage *)sqbHYWdLcjidGOzRdk :(nonnull NSData *)lIRIxWxMpBdFjTnx :(nonnull UIImage *)fGCLuXdXCfelfJGBxB {
	NSData *fBqFcLheNnAz = [@"BWHhAmwYXAExhTCmwKYkhhtqHkRgYiADpMAGGeKUKdjfjwYbMwivlsRbZcscpjSZOOBNVaLfynPmaiPaxQQDfbKborTvvxBRYlcoDRhYq" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JRfFEEaeIiNfD = [UIImage imageWithData:fBqFcLheNnAz];
	JRfFEEaeIiNfD = [UIImage imageNamed:@"kLVruqzwQtTGfGKzptZnKpoLHFRxOJjScryfNQbiOcOfAHahGHBmtfdCyczjEHTrxAfdUDzLPmTIRpIaTdbPOSnohdxUjiXASFYNzknfdWFENewlfOnlsXIwouWUCidcmYIqVdsexOcTO"];
	return JRfFEEaeIiNfD;
}

+ (nonnull NSDictionary *)rYXQOrymarvaQgE :(nonnull NSString *)gEzGDNzjLWAMPbjxR :(nonnull NSDictionary *)gqaSnQYkudtDKZ {
	NSDictionary *ihDPtpWPNfKuJTM = @{
		@"QbkvswbxIWW": @"sIfEynzBvgEyMOIOITtTFJHVfIvprbpFzSjeoQMJzaCLwKNTOugjsHzaVzpwaPppKlUqREMQhVwIxFJtlXnPpgNZoeNzsUgyKwGEENItzIwecaPyAaBFtcUnPOfltoDoEnANpyiCkzR",
		@"zQUXTsTZZawhQMhKwF": @"lvSMkmeiHPDkqVnlPGtZPBJLlSTaoNnPBIezSlocZDvjekVeeeWMpbbSOZkmPxqYVUPEnFvgbvQaaDUPLDdaJfwTjzloXfiZHXtrCzNeLVWtCoeNJJbOLVZJWdvonQMbi",
		@"gKffUMBkkKA": @"FbpXJMefpBqsXJcdZVxpGyzKgJKLdPuadvcPCpTbLKGQrytxmDkaIlIuTCDicEVHEtvbJgHyrBrEwjezXnebTMOqwCFjiWjOmhDNPIJKfqpbFUVjNvrgSeB",
		@"kYcWdpcrbl": @"dRsvClsZpKjHdRgQVhxTqHwsLJPSXFOVWxrvGlYhnhAZguUbRvvUQRjnnXgPOSCwyXnhcafZPhbYenVBYWiISeNvgFGudihlAMsZUaAJRXsEHNdnhsYGZHyOLIobnpoNuLW",
		@"zNrTLPzlTdDblQqs": @"XVCZsmihmZPNjYlRyZKnmrlXgXwfsdGSbnSIdxoIEaPDhzGkgFdAOqjLCnVlqEuyIXTBivrbdUWUMOGdFWEfngPPNkclfVmXBjmbt",
		@"BwTwtmhagalJU": @"QTSHgQxtpUAQPEgxmwerMIYAioTkONyEvCTeGTWCcHKCGfgqrAPTZIYTmBfdmCQwkWrYePVWlOMfhyuigRawudVTLOYBvddjHdMAJdkRWCNnCbegHVGGXULezNHwFagepaZi",
		@"flGvgBotQeuvfC": @"bRYOfYONkbrZLAvKMyFaqvdpwmnFxrfGoQmayFybJzRTptuqsXTomaBiApJasiofjBVZGcycGcKYamWRtUpafQwTjZJwHKqYiEdTVycviVpezXKAcyWTrQHxjdvUPydUcAiohO",
		@"JzAGQPcSrWzwtOluqmu": @"VIOqjrMcribJcqdlwRcdnUOaIecITJzNoOolroSZlIjIiEwBEBgFNtgahWzhcdneUWPxdKNXrgshCfGcoyyMbnYyZJlVXlFKdHHJhesvjgbGrDzOeBwNeGOHaZrCRdPDjWcXnpNiBaRtBJ",
		@"lGAFukcUIQUDM": @"TRRyPhORQTAHLFvSbtSkIeCqlrNKsnmffzDYPPfnmUCCdqrHpouCOApgysVhxZHCzuuHRbsThMvxbrEJSwdHZcXPpXmTMIszCFQGowiFBDNdMwxGQDUQz",
		@"EkDeJSuEatswjxloHck": @"fmZSHWhDAPoQZZcPPIpNFofBaEoYXvvAqsDKCSQCitmOOHeUatIWYJUXvPPxMJAzWheMnuPbQckiqQMnPMHffqaXurFSFWVEesZeJNXSaeLY",
	};
	return ihDPtpWPNfKuJTM;
}

+ (nonnull NSDictionary *)dZUbtlJolbTy :(nonnull NSString *)mRiUxjAeBQOKCcJBaFr {
	NSDictionary *vEIcsBTZreUmUPhw = @{
		@"abEpLrRqLrk": @"lFeyzcktFEiBYpkFpSJaFQlPziDiBiFxIlFMojtbOJcARmbawXyknjwfcvvDlNBtQKFlplIsctCKyANOuFNqGzeBsKVvlswQvAHQfumaBrEsuoonHENpXDm",
		@"uxbGDyuSHH": @"NsmVJowlCuAoNxoLgAaDJHQALKCcpylqhNsYthMpiulerDgelvwovfQBsQdpopMyJBCmXpBkiaiqbxtpyIvgmGwHcdExNcxvCwzYGyJNQ",
		@"ZQkicDbhgRLj": @"LKELtLmxccMtdAVtgpJqUGZHyzrMvvASEVaYHKqpFXEwPpUIcaYyZKOInZMtZXwEErDSHMMIQRPoNkbaadZesICSnZOonTqDueanDnTYGRYAYdKdlIPexgxurWgHCwZxYtmFMNLnHRIqE",
		@"NgLepxUSqnMMVd": @"uYxzOsBlQghzVvJLPmdNhFlrwxjAabErEOYmqhGvJgqSxmYjWhhdTNbvcqTYQYRPBvASZxFGOMFGgYqiopPLKghvscCoYpFyaPUrhCYWyWQrtirz",
		@"xzShPvnXxSJYqwqdGW": @"htDzqqJXBEQqIvAgjgHMOTAclsRsoIZwkkOdQYlXSsrkbfCbJuTdObjkKfqUNkvaMujMXWiyCZFXXMIzHrAmSLSFUvTjrhTIRXplmuPnlKCnNsXruHaZWMgHeivnemIXoFDAdiQgfXUNPjKyyR",
		@"LmmVZhriTQQrsqMtFuW": @"rKzEwxpiukcYPnKnicJDlZUyzvISANrFpicrtRyHvnYEFBkNOMqKOHfmFceZtAgWrKmOGoTerIAGthWmVLTKKjbSXZUpUuGOxOFNERuxOwhOvLVMKdPcEAqujQVDwauBZjBFkk",
		@"KFtmvIFHer": @"fIcJnImLWaRPzHeVIDDvRTNHAhVNQPmHFPGltfRsYyEJQgHyBClWROQWXYlmBcrYbBbdkKDowdgpKICbZPcPTUKmXDbjpjwuticQlufbMKHKAJcnfJfuNKkg",
		@"ORJZclHRqBaFZxe": @"dpMevZWaNByLvMdNGKNMBeXjUPwwrzLJgYrOfLdzbtHgXvyWXSXoKOncpsBTMoxwHkyUSVzpgOnQwSXpMqGesWpqlstOQBvajNliByUXYzozjlUcyxdGpZB",
		@"mxyiDKXnYKmAs": @"XDIalaxsTgKqsianKKSCXRPBIDtDCWKKkTRRvZIDqPUqKwwURFnDEVMprMPpAmaVMSmozlQsNebDVHbiCrMglIxpqBWffwGbevxWibbScEAgFsMruhvGnEhLhbvD",
		@"qLApAHBkUJDJ": @"EtDLGVlnaQRcgUMUqOFpKDsQCNrmSpJcwuPxGfAqWJdJeWXXnWQClDReErJoBCTJlhxHCFMOheBZFzxVqucOiEMiQhYqIvqktAqrZrAoNAoxFqZUzWgvvovKofzFlocMGFLrwwU",
		@"QFXNVFLzGzIGXb": @"cxHgTgqAhyiRmdvPfFomvbyJINyefnEVEZKcKqKahiHZQLdWHtIywrXNkCiaXmXoYZEkNmRdRHPyNNyPcLLQzPkEtshgYEaTxNVaYXhRIJfxC",
		@"dKJJhQDwvGdn": @"nOHjGUCObOBsFMZSiooWWUDOKiFVdWAMgbrplfXmqLuqTVCvfShSRWFLhoWcGRYpFjkHuPDxrfBlFymiiLGdKHGrBPbIGGcGSldurjtstcjcDVcgqegnp",
		@"JZyQfVQgPUwaeRFoHBQ": @"pebAvOTVaNRuKBBCdyJaqWmdRcHHeHinjAXueusvxxmtHxpLnyDqVvdtkfrzsREpPHUgsghAsqhFZaEqUIsAUpwjlxjTyBITtWJVfVgQFecoSkRGOHahaURbaJLinGtutaRIYwDTMaQO",
	};
	return vEIcsBTZreUmUPhw;
}

+ (nonnull NSString *)DnnlCxonok :(nonnull NSDictionary *)VkhKXUELZxEzd :(nonnull NSArray *)bNAHyHRnkGC :(nonnull NSDictionary *)EfddPtSbinjaWgPGo {
	NSString *lythRvhbXagDAaPg = @"HFBkkKVmDBkeyxZUsGnOwQqicKdyGgxgFkewTXOBNSFhlkuLWgnrxANnzeYlCLlFUbSgkqYXyXnVnoILHTvCdtGNHqyUPimZHdGeEdTYCX";
	return lythRvhbXagDAaPg;
}

+ (nonnull NSString *)DenHaCYQagkqx :(nonnull NSString *)PdcjrhsSeCQ {
	NSString *msuKhlFHolmCndZZIlV = @"FgibKArhaQNqHBhHrXfwFoxqUXvsInnMQOFpGUomPEbudcpJIaDTOCYGjIGdhaMRyzYpvNmuPJjFAxHvUpdwuTSbZMyCbvqpBrzgJiTMErpIuentHcvkluV";
	return msuKhlFHolmCndZZIlV;
}

+ (nonnull NSDictionary *)YlPASVSgYCLpArPPZHi :(nonnull NSData *)WbgzaIndhhTsoqyF :(nonnull NSDictionary *)iuIFiEvUha :(nonnull NSArray *)iHOGwAXFnv {
	NSDictionary *VyWppYQLvaVtwcym = @{
		@"NaukEYFndBwuEDkNb": @"jPUtTStGXOeUfqKCGzRgPPMVYeqkwpZaEIauSHhntxUjDDWFPvrvPwHGrukVQWydXdbowbfKvCZMryyrXSSjUDEeKxGDSwxhjiQPyUipzhgFbmtwiDQPLhwVQ",
		@"OualeRNqOZJ": @"dHhpIuBXgWGtYwPeLRvHRwimufRNeHkXKCsNanzCVjLFTzVvQkYHqYHzMEDClbsWlUvKQyGFUIdXwsRoVUEtIoHqIEzwcdAptsMIUnJ",
		@"OsMSmjChWJ": @"hAXiwHAPANezVEjzLWonEoijIYWINJnXVjQXKyUgbIUnIBjBAYksvkDJdhscIeqyUsdFVoVVQtEWGGaKNdGHWPRIbQnUDztlOGfnURmpgNnUpIRdOmCNZIMgcgxncpxqVRALVrZuL",
		@"YPFHSEBtvWrzzVdK": @"fiuVpOnjeBYIZdvHEMtWtXoCcOyIQHwutckWkIWzMYRnazXvjkPOXnrseNHvfidNAuUKkwBEfjvqduXiwbpmBnZYDUceooHEsetMtUasThFwzQPLOkZnMqpPTNqBKoBB",
		@"msvLWMmuyG": @"VnXXgJwLqoFcdCXLkrFRgksEWdFNngCxiFXQgoOXVibYWyqCdMboFiWvZMhbWHJlRCoACdrZldMBURjyafrEnfKpgmdBzVjXAlRFYeyuXBdchsfnIvosl",
		@"KIkTPFSmvX": @"YBbvvsRErBZLkomceKgTeYkCuHzyugEQdibMuooetxhGXHQJTKXKvswHeouxinFXxUHJuEaEUdxiPCAVCuCjXkckmnaaHWtcqgRtiKUbqMIIWNYKRlclaEpgKwemXqtpMYNZtgWWMGEVneQ",
		@"KhgQmxzxBSa": @"YXCulvHrCQCzdBOhRgnKWKPcUEeKKNVAiOSaSdiMAjBUPEwTxWPvBJmibvvKzokdwnatcMAUmUiIQGeQhFIQmKNfKURDIKiIQueTUlzXTzH",
		@"QxsNJZMPNEDmcanmUe": @"RRJJFnOHiSkeVLXeChmyohCyQoYUYauztFUKxLIEsDVHwdsiRTOCLpxxORdNODGVvprlVRnXjkaYIwXdEJXgTtCVocmfUVULjdlUFcCxvltPgguwKwSeD",
		@"KnbHwksoEHlKr": @"lcnIAHvaSASgXyxTuQWvfYvOXkmOLVOhfhbsEUfZRRlWGLtkXoNuXLAqpqluLJmsMDHhgpzuDTqlIOBdEIVFGmBshBkJhwckeAijgfABhpPTfAaazsBfJzstmsbmxIaaNbQnqZSLmpiZbS",
		@"wkUOkdejOFOTroAti": @"MMQtOKQDhcVYoqYRPHGzLqkVILxfLCOEtmEKZLuTkzqDvGHhHnAqpvEDjqGBuEEivyxlzdjGfaLNOovNvMpVJlaubLdkEjLWssiFoOjglmOrqTveYySpcnkCMphKAlvEpHDlaIuNpRGon",
		@"bNkQsjNRsNAy": @"kUgdrNYlTNcRHgSLPdwBvILqvmCdWsGcWEJhPKzPcjWltjUUxrqtfSEgKspxbtlMFfCXGWKyDMddXNKLuwRLWrdZeqAIgiKGCGMRJTPfKohAXPvxvEsXmwfnrSIE",
		@"uFbtOdSvntJpV": @"TQgtBgrVycaVMfWSmeSHjLrGBqIwfTlGrkMEtNsNKPtyzFbYAzUOFqxSElSUqFMjraQuMYcZrQuENFPeFTHjtmkAAsDSAFRLMaEeidBWBAJQCIVRuPGEqLUaJBUdzO",
		@"GSDZdJeAnDUipbkE": @"HOotNZzmEuQTjUCuAXPSvkCIdSoVUvgGUoSyQPLeUHywUYtYHYDPxZvKYsKoNdZmyWRCNljNmrSslFCuhxQaLzUIYpqeLxkAaZsLNDtlkKhdrikZ",
		@"pNXvmtEcZLIfaavGoeU": @"qIIZFBapkYhNXBxXRcnIvannkGSClsRFVLRPODxLlKbMbtPmozIXSHexuOlsuoWYqzWhbROvslXhgCYAxAApEhRCNMhtSfLThEyoOlhLbUtwALiLiTFgwOMYlwOdIB",
		@"hcoHtOVwqkBnDO": @"jNRBQVqvixmJkHKNrhYvrnKSROMCvKBlyZdFtuGJKaSNfJKlSDgWktaoRZfnQmIsHrULyPWuyOxdVtZHubKsMGIeVhdipnDfMGosCTVfxLKKMokbbGY",
		@"rQJhmSwTYTMh": @"gBZLdIZizbCtBpAWPZrlowyZRxLWvUGXeaJXABuqlGpHEgyeonqEWugDkLgWxFarCSQPDYdtumDMiltHhprYZycDxhIsDvBzpKcDnrJpINYaGfgnwxAVIPOUhgxMdWNLjzdxu",
		@"qLJaaLPckd": @"dzCsfCdBnJoiSQyUDyBWXlioUgcELLlIeSraMgfDqNhyKKIMIpvXdZsrfEKVFWzzKfrJOnwBAKomPWoQojYXitlJDmLJfUlSZHZWgDCjiThdqRsGZvvzbMZTnjvUeva",
		@"kPoIeRhCaZapZN": @"mZeMOKZGWctnyinUqowTWTzdCmyvhVdjJnhPmmmKUpjlYTffyOLEvvPogpOyOexTZMRBpcudwjHjCmGzZfPilKQGwcBSojRBRaBWdESljwCEvvuEpsNAytHZhYMzhY",
	};
	return VyWppYQLvaVtwcym;
}

+ (nonnull UIImage *)SjaetYvosJMX :(nonnull UIImage *)ETICNZAAFGxplzf :(nonnull UIImage *)IAbGCVHpoFw {
	NSData *yjIJcrKmKFoWAvfZu = [@"JDXOapuxIgPxuwIEqBqaxKxySdaMslASwxXpMCGDCpTjhBalpOzeYFhIyhWgZGVjvtqkgBlewGdFdLceHTmioVmYfrkoBJoUesNihrsiVIowakukOpqETYrcVFCPDOSywLXyrpYjMXccRONwQeS" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *RlnJnJYleeASlh = [UIImage imageWithData:yjIJcrKmKFoWAvfZu];
	RlnJnJYleeASlh = [UIImage imageNamed:@"rMSQyFhCkHGfPdmfiFFnRahYIUzcpcJFWMCaWGnSsHHwgzCkrYuzdlyIBwKucYrnFKsTqIhlTTpCluPBHAkApQOkjEHEDagDjKAlgQFwqFQGUCJVYQwhcqgb"];
	return RlnJnJYleeASlh;
}

+ (nonnull NSDictionary *)GpucFjycKaFraywEX :(nonnull NSDictionary *)KTTSDrKQam {
	NSDictionary *CQXYShcXAyd = @{
		@"hsTLSpHOKRyX": @"IaDGnxrLHtlItFCXLHwcCduAEvpWkJvuVjkdiZkIOqaOPaHhdhZQuyeBdBxzbVyhEfAZklqTImBtHzEUSLKozWRIHYVpjfHyDvvhbAkhSjhj",
		@"OKNdugiUgvGxqY": @"lQJtQNpQvzKtqVWBJgjQclovGgKQJaXuCCKJJGVllbmmfpEBwBBLAOyiQHfmuFSPyfOLixeHNNaNfyqHGQDnROQWHUWpPyrgEkfDCcFyOHVswehnoRsEHwVGlEHTSfvOjlrYQLeDpTiwYLYU",
		@"iBWEUdzbHkVu": @"CsiFwBBcDjoVSgZbEdRgHjEOaoQxWTbWkVsBhGtexAKKniTAPxDRQHVhUcchwjLmXKBYaTeIPZljgOmpOLdIYoNNstJOmhKoQFLELtz",
		@"jGGRCvbuUYLpkMoRkxS": @"CGJWrsdrHZzUwsDMbyXzOYSSZnvKvIpIgHlukvQbLKGelyfIWhycXDejfuWPQwpglJZNPDmACkXwiSwKsIzjxiBQwrUngyGbqYvoboWeajUiJQMnyYjXQjRszQntgtytCrwLfgAdiWJdqcfLm",
		@"aTiMkdWaIzNSq": @"ckjXXPcfkzFAdZHWoBbndAKwPxcoJDbfttiRcIfRmFuHjqlgPLbPrhWbPrUWmPqOePQITpzFAlyPExUoUUkJtRJulvTzsyvQeUBtlcOiVBNovohzlyKbEvIjdscjJKNhrp",
		@"rJIGyVtzilfWQ": @"DZhXQJsSsHblXVhqAXNQmNZAAMPtLbuepOpWPSCEEZPyBfovaNzTmwMalOQIQhENKjSOQpJlRZxLjjycbAgBUACQwVopjtaTmcReaMTxhuWxpQzHuSarczjcwZLx",
		@"RtORioPksCzT": @"tuWjNoYicfnrAVNlglPsgxQXavYOqIFNBkSJiMVXyBNIMZqTdlRzWWJgGNsIFXvqzQEujNwWXJeMrUMTmIzPVZyncRjpHESAXNChHFvCXfwSFQkSkKGwxQXyA",
		@"qXNDBwLuDRknusYtsa": @"ZazykpIrgehYUbcqCIIaPdxQfsCvXzrdednSdHuMajFCRaiPaIliHiQniGKlAVceFnDHGEHpUnWXRyihvBwguahJxuOmOvIbHunQQKkJkEYB",
		@"nypCurPKeNeFqji": @"dznEQQVlRwZbhAQiHbmEOmMuyARBLBgSiMUiKbkilxlxSYeiMgIjrDODpIESMoUnHZQCDjBfdCwYTaTNkhrBUQqcNeSJXsacDSNwpFtPUOWWVJYePZsNYFpSVEhjazh",
		@"qWVWvLtlqpHHOQrSvxJ": @"AGIDPUbbdfBJilKgyzwWZBZNdAbtxlEgxOzRyGhczgxwSdLfOicnBIIREQBolTLbwDbAQhkYAIuxHOaFswoKiuzJmZpDmiZJUsGryUgtHacmlxZOruEQOTxNhStOcBJoZXhihoUNTTXO",
		@"tzdjmDJygpPRPEag": @"EokwofZZYrxNpcWSkXmiTABNYvIyyEhzFmIYZYqnaWRzVhvNndGMvcgYHmUQDHvoLoWGqQyMrvtPdRrQaUnfmhLAWjnxytuLHdxCqioNgAfw",
	};
	return CQXYShcXAyd;
}

+ (nonnull UIImage *)WjlSLVOrcaE :(nonnull NSArray *)kNqmGUOWWMIPAEHrTW :(nonnull NSData *)KuOhGJomvDyQUmJYeZk :(nonnull NSArray *)dvoOdtvUBTKqlMQ {
	NSData *zpDkWkUPSkfnCPSG = [@"YaHwjSOojBAtqlBYbpGGbOAGhpanuzHVVnyqZTnWTBqWjiVhqOEKzQenaJkppGxpgXduntrBCtxcrHPCHpBkrUFOXugcVVSRihLMJxBAsZliWuQswzIspPuXx" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *vBLOmFYAvIdvJcWPPt = [UIImage imageWithData:zpDkWkUPSkfnCPSG];
	vBLOmFYAvIdvJcWPPt = [UIImage imageNamed:@"aNLnRIIpbEpgjWJgBHAlLfeeeGqhriihSPPVVwDhPEbdlhRExpRMLaZemuxdiXFicrYrjoTzwPqpYHtcQHybPxHCdavnqurBiQfsxUbAyvuOFlI"];
	return vBLOmFYAvIdvJcWPPt;
}

- (nonnull NSString *)eWjyLdMQaCM :(nonnull NSData *)eUkTkMXDqVQNtpLe :(nonnull NSDictionary *)ALKpwreUXKdLLsXvrGK :(nonnull NSData *)KzGDtVNLxZZEtj {
	NSString *FwYQcnYjBf = @"CVgUNBSZBKaTpVThQpDwUNSdqDdKzBRRdgljoGawXTKORYriLIdkfwUjipwyTqwuKeoZZHnAXuesximkECJRtHNFuohbggxTvMHCnZOLxDQNljGtJefBltnRteHGByldovoXb";
	return FwYQcnYjBf;
}

+ (nonnull UIImage *)nwsIbnDknjUuV :(nonnull NSString *)vRGcWUpsmnxzIwaO :(nonnull UIImage *)EKKibxNjvmuBM :(nonnull NSData *)ywhpyGgJNV {
	NSData *RBuNdsBIvXIGlPEv = [@"ilDcXcDUNsUeLtooXTNbuqqGlsBiDBLmNrPRbKLTsmWuxDArrocxmwjSgjGXRaZKlAHaIsdYLQXLsrNmHRczzWEifkZmKbbmawhuiYSwsoTmEwTvDpqmIgjYiXs" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *IZTBwccOPvIrRQlRiYB = [UIImage imageWithData:RBuNdsBIvXIGlPEv];
	IZTBwccOPvIrRQlRiYB = [UIImage imageNamed:@"BrNnNGCuYdZNbFZARvTVAeIlsHzCrTvPQcewyYaHoyjkuZqYEkGmOYMmpmAKVSaEEcCOtMRbybYWRwBPbHiyPKjKSwGdoylrmCRBIJrHKZJsadIj"];
	return IZTBwccOPvIrRQlRiYB;
}

+ (nonnull UIImage *)GPzaBNKkYyvDLms :(nonnull NSString *)DNkqOsGgwkAZDXXqCU :(nonnull NSData *)iutqIUblhaW {
	NSData *XeRLlLVFCSe = [@"aZSQNVUBDRdckdLfcXGtAcaLDcAcsLWyBdlpQjbsQEWGTGWUlPmXQgedIWvOUjdnApwAamsVXDLtYhGOmpgnqLsRBodRONeUUFkMsBoiSnJnbKkYOlWLOJJIozP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ZYqIEwzscVGuzsGw = [UIImage imageWithData:XeRLlLVFCSe];
	ZYqIEwzscVGuzsGw = [UIImage imageNamed:@"ExFSxqUBmnZIHJPhBahRHNXIaWsiWEGTCqjRknyJXLtMgyzMOYoodcYnAVITfqiOAhJtHbwJzlTvnrevwkjBpffcCbKOBsCFhexSJBRXgIFpxbriNusvEenOouMHiIevHjZuhWG"];
	return ZYqIEwzscVGuzsGw;
}

+ (nonnull NSData *)pkcEEESctFf :(nonnull UIImage *)ToaFtpWpCEPiKsXu :(nonnull UIImage *)IrxOeuTUfKcHy {
	NSData *kEzRvefnQteEMPbh = [@"aJkLGftBDElGHcnrMnBliyzlSEZtsKkgemVblXckUtgJiMaCWtmQBBguAmtmcyUbJdmxKdLzKgWtiijknunGetTnQYGZNVDVGHLIksBAMjOcfimoFwRrmvRJPWDGEZMqJjWFdbqROjKX" dataUsingEncoding:NSUTF8StringEncoding];
	return kEzRvefnQteEMPbh;
}

- (nonnull NSData *)KDVGjORPskk :(nonnull NSArray *)UCoVkZvPkhJDvsx :(nonnull NSString *)yBYFFOiXuHMvMAnPVF :(nonnull NSArray *)KeoKPKJypnctv {
	NSData *lXnhxNLmOkzEQE = [@"rcBpEySiypJbRlfrnZkwOtBFmkXQgLUKUoVdDVSzDvtTIHIlfhwVsxvuucwVBVDFjeVuLdNmznHEFuaXOJMdTXckiYOCyzSBgSZmCAdgDHtMthLWplyDzTAcbjrEizvLYsquTINDiaCmYy" dataUsingEncoding:NSUTF8StringEncoding];
	return lXnhxNLmOkzEQE;
}

- (nonnull NSArray *)ehiIUfUvLQuN :(nonnull UIImage *)JeVkICdzbaRpHydWty {
	NSArray *yVQYmlseZy = @[
		@"HchdkzebUhxCHQyGWqDzaFWfBsdDRhPbRAuQFEOnGiivmNriJXXdlyCFTouoPuRoxiTevDfVZzElxCTaLpRGdZdqLcmjzNuQeRMhDQJGMrftAPyLnDUaZAOsXnPhbYpamkgzXnXvrhhQHkZxzFU",
		@"DCrkWsbmFrSxOHbWAXOiCIdFoxcEipKhPTctKaTpkEJmRbzXSSPDQWOBNaZyXDRjxuDZqLGlLBbkmydPjIqAbdFyyRGRaskqwphCZUMQfovAiAmxsDRhczKdJnSEaArlAUeAdafn",
		@"BYbGbDyGIwsyKXNmqBjmKLTgYmkzrujnWxWoVErhRESarRvNwcWqzZRPfjMkLtWiAJAKxhkeXURewTcDaUCEDfERDmquBWrBPjrnvvJJZpHnypGvkmcCAuiHpzbDXZnCjYPkKLOZjchuNri",
		@"hySGhxTGjEGJqmQMSmiFTcebefnichIWjjqFkvDBtbbMbrURmCMFdhGDUeQRORjglKYgHMlvJHlqixseNfGlBcEMPdQYckNrEMvMvquKwZStuq",
		@"zqmNgWusoetdxfRcoWvBzYmowSSwmJtGuuQnHwLtYoAZxgfqIrTaAOIqCPTKvTgeoOehvuVsNsMjHqFDeFaGHznZDjxjWiwCbRVCNkaTrsHeoIqsIoXFsykJxgwgdMSllwXDzuNTx",
		@"PwmgaEMpNECugOLZxFHIhrndamjhGKtzfXKYiNFTXUJXMGhnLoOCEmehnrMXLdlhbgyyxikMuoWTKDYEFIWSOeZWUTlJZehyfapiuHoNkKJiTKtFhsvAJzTzqWeAJbDgGtTyPgZhxUvGr",
		@"AQpnRhwHtrIFbodISYZyMGtvHEfyCLdDhrYKZTZYWvMWegByrRWMajGfuWxekAcfRaHPZtBjhQqbPIYmIoGHqAXAJMSiusdPtcGMPMzAbJyjf",
		@"lntkEWYgYjTXurcjuNXjrHsfKPoyftjuKuySRuMgzfJbyNeBjxrocOFuAhkFCuIiDAPFWbhqWoNKzgselwmUqJCvEeNnPbUAjsCIKRkVclDoKOkXNNoqteiUDYvt",
		@"EUKiPbfKwumZaxLHBCOaLawGnOqoIRtexITOehkDgAWPkArKXuoOZVniLRvoLVfwIXthiHULBRooVevZLcIajsugOtaDdiUWKbVPCJoRcinHoUHgeevrUdsBZS",
		@"xIOKMTgNCwpTOUEHDIdtVZdIfEMQCvRfPYsBYfoDEzmAULhivZnCPQpBmZjBNAGCDqSkJjWZZoGUgRoGPqlhygmWWMhCwhwPPXJDoaTDFDYtAIDGowcMssDdptLbuFAxV",
		@"WayWSHdwdxBKoxHDIDsToHZxSKGIXbLCkSfbVUfhAfidgiJVNaFEuQPgxODcnOClzDrGQooWWubGpHKfEMSXdMLiRTFFhHjRqlKErGmVGZSWROZwDSKQAOubTwpVTgoItEVQ",
		@"aLnuKkVCuJpSBsqCbWWQlPFFGpQLWuiWSXrZvcDttPiFVbaOoLIAVsEcpUmKMOLfFHuzzqFhNxiXewDZJeoqBeESatxPzBpExbCXzXCHAaenLhBLPNfjXzqSfqCqDaSscNizjLlxqzviggDT",
		@"xIpiUXIenXBatGkIGAlIhboEdLtpDIKBgUzbNBHuHeKyTjbDPgaembNhjjerhkJcnLDHoXzedrBOXebaShvsWBfSSbVlZMkwDinpMfaahjFGynSW",
	];
	return yVQYmlseZy;
}

+ (nonnull NSString *)smHvNcosRJJnmewCBM :(nonnull NSData *)wvQpmbUdupXtgrLEm :(nonnull UIImage *)rxptjuKqQLD {
	NSString *DQJDbVvYzv = @"qBDEWHBHpLvsTApMJNuYPiWxOsgXkJyNFeZgoGxAryegNdPnOksHWEvrurnIbQWKiEcDVxFdxbNtmfoFlsqxZPVpGHnblKFUeCaEhTHTiygjMpGtaoPBeUqJYsGWHreuKI";
	return DQJDbVvYzv;
}

- (nonnull UIImage *)WZXgJBZmfdXoK :(nonnull NSDictionary *)TtycWLaEZEYSU :(nonnull NSArray *)AYcFLKfRTnSHwCMSS {
	NSData *dFOrssOgNYrtLGLGSE = [@"DKZiDKDDGSASvMxhdJeJwRzWPxSOvAbQbICNfHeyWjThFSdHymgkpxsZFmpccMjITKtGEeCxpAwKdPyawYIIHGSOhltlKfeckmJkoBpaFWtOKqLmGAXWBTxSSOvaLjrNVtvpwhxIrl" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *pIpMzqUatdvVOpdx = [UIImage imageWithData:dFOrssOgNYrtLGLGSE];
	pIpMzqUatdvVOpdx = [UIImage imageNamed:@"lAkRKHBhfVxLWDvZFWwynIKTHVamtaBSwkFLnMdlmUsUuxzOfZxPVsJXolBBsuHVdbjPIFiRaxTGPXeLQOPNswttHIFwIfLktDLcGIFxFjIHipSsRs"];
	return pIpMzqUatdvVOpdx;
}

- (nonnull NSString *)mExKSUpOdE :(nonnull NSDictionary *)QwStFDbPSCbIbXZtmA :(nonnull NSDictionary *)JcmnIBCHVInEzCZUn {
	NSString *kWupsxWDAZ = @"UffnKaZqmAjzUmZEiZnXHKZmFbipWVtZMYaWtRSBgiUYlbPqnpNUQfWdKTvNaoHfZurVaaimGWtXDPzRCwoMFHGFilpjwsAYiWgjX";
	return kWupsxWDAZ;
}

+ (nonnull NSDictionary *)dthJfEtiAprvu :(nonnull NSDictionary *)bfgUvOrnWXfTMwpOAAf {
	NSDictionary *hPsWTutFCeUyK = @{
		@"AmnyPwNuDHdJrPpWdeu": @"PaOPgVGKPCzSeqkLhcNPcclYeCwsiyWqlAwpxQhcEbqydBbskOamhsNEDMrdYJsfMayyBbVkpXZuinnYHkpOcArbgtUJXHPRNGQjaTcOtohSSUGAFwk",
		@"lGtdTZtYJutZokkipf": @"OfaIefRFkMVCyVlwYbrPLGjvsfLUyuzpHSwiuDDLhlwDwNuZDKEkKmweITlgXsfrFMQgIgIanqlzrmQvWuJrCImeQacgkySgpyCTa",
		@"dYVAxcJZQPidk": @"JeaycIWitqAtKvGoggbEaweXRBZQdpaTqKkkccmXAxvEAvQiPItEXCUbndsHoLxHEHvGfuCQJkfQPfGtqWvKcrqniLxdAotaEFrluhwpEpNZhWZxCM",
		@"sSFdElrpuEVhtROBZ": @"TEZnwfoMLSAGyoZivOHiDTQFELfUUAjwmoAAsKwHVbBDGKYaRwPyCNRwDXNKPmNteSujuidurDldBFcBOqhrjVeAKamneCeTbPYokgqCmAujBkJqnFGrXZKSpScNqznBjmhIFoMHwUK",
		@"LLmLDmHynb": @"fMJyBPhIvnLdDCQaOPABuPosRyBbSYcRsFogSSuQqkrKbhFRbSfgqNogssnvyfSOvitOZxPxukBjAeWfVwLqCiFNSVJNLkRECwhYzqgELdMycItnVLZcdUrYjPBypuEWmxZFkyiPJGJjarqqJjpM",
		@"FGoCvQZURw": @"fngTzZNgvaFzSGAJjDVJNGyPLkUcOFLpxSQCCwDzSCEYFuXeWQWgurFOfEUrWZZHVbfonlIBDjVRHPkJUsMYVYAknUrFqmBuUcsueokppBCdGfDcAHHoeCiOnaIQksr",
		@"jkZrVaeZfUcGOrLuB": @"jWmuzljMeiejGbcYLlVtnqynCkthrSkoVEHtRHoLrduWzmhXQprMvrRXgKofAAkDJsBzsIAqPQRtmWHWnHoxWuZKFfkbRmEgzirVhYvYWxPi",
		@"DQKTuKNhrrxppEJEk": @"XyDhBMlfSOVnyaewWaNbfpoZmsHqUibJUbvqMPPCZjAGijezHsSPMCclNDSYwlAtFFfpUKweAexyrnmImgDzcgXQJXLPkTKDqPuPbgXnxAE",
		@"vDTSkEMnWbrGlDKtS": @"kDrFeMsnXKOWFFETQkuGlNvpywcOmESNCFVeMfunLnOLXXSEqOBtrSllwMQjmoAJnyNoKPXzYDerAIwUOoNlraZxTEZteqbTWNbEzrGvsWIttueubMol",
		@"bYOTidCPFdgJujQgm": @"bOsQnfAEJtlGsssPEYxWBWAKBrQsUPiZlocbnojWIGaYcWuxunnaVUdlAEnmpfJCzsUXENuRUbkuciuSabsZqEgjQAzKeifuksoUmqItzbHZSyardLAdDVSxxBVhJNtv",
		@"VGIvoVtysGLYWt": @"BmXwIPaMyXJNVbJARLlzrGIeTBafBEMfWUVOSSRfKpAwDQPquWAtrnXRtyiloIIIdpSurjKvAWyYYnoBvwRZTVVCNxXptbHbZMUVltFiicKYpURAtAeNxBbHFWtaRsfugyxmnyOXRriRfz",
		@"tFiyqfvkhECyrLId": @"ZskiEOUaYxmEKZRExiFRVTxyhwbxZhNwDWjbXHrgsnjaVowijXaWjfMIcAYIChhRXLNhkdmpahQwinvIpNVfnAWQruydvUiEiBUplyyWaRbr",
		@"voEGJUpTwaS": @"GvJwsahMWSrLsRBjRxnJrOTKiNXvkBCjqWbggmXhdVNvWtvfykEYQcqgoZdoDkIOFGLeBJECJOfraMeBbkZEFAFQPrGZHvOWiquvyRrOpFIMcbj",
		@"gPTlFjfMQonKt": @"XkuuYxyHvtbOswkXfilRHBFSEXRehnVcBOjMEHPnkOwMDpQQVwKDVuUcXPcccrYcXUvVLaFcGzhVfqoIYgYSJtpIOqUkDcOKyRXMxtjoXYflXcRIggwRtPtZhvQz",
	};
	return hPsWTutFCeUyK;
}

+ (nonnull UIImage *)SIOoMTudxiJNFqPYcNS :(nonnull NSData *)cpNARkskTyVSwf :(nonnull NSString *)OnxXrfghJmEC {
	NSData *lGzBrqSswulVdEwocKw = [@"PEcVbObKWrKIYGPboqQKiTUUgpahsZbXqmtmbmPVQeImGgVQrqXSRkNhWcoMkVxpWcLPxjbQSSfEJBlIUsIFfwTSytiBmkuImTDjXzqsXDIZj" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *UZLvvMvPQW = [UIImage imageWithData:lGzBrqSswulVdEwocKw];
	UZLvvMvPQW = [UIImage imageNamed:@"DkOAGMvzizYTcCQqsyImSUPBNXxhkcTWvwlnAFnpOfBROztghGVmpEqRytsVjRnnTiBidZExoSBCqhoUmmzpzMuaOphfBxCshunkoKYOHCnPfZxAMRMXGoaaMSsLDbfteYIEdCa"];
	return UZLvvMvPQW;
}

- (nonnull NSData *)xvlRFKWVLkgvjo :(nonnull NSArray *)lLGCLrRkCtlkqudar :(nonnull UIImage *)iDHTdtMRgzCGhSAGnel :(nonnull NSString *)jYocdanjDpw {
	NSData *tTeKLKRcAqaSexGFs = [@"NTgJRsKeqUdcCQXkaEDNMVEFYIIKoQBZHYLZlFzwbWdLrtQCXCDhtvNfuhHNwSmnHrRSDlXfxuBcXjLnlwxvXklnyofAntRWvCtcMCgxgapnuL" dataUsingEncoding:NSUTF8StringEncoding];
	return tTeKLKRcAqaSexGFs;
}

+ (nonnull UIImage *)NWnErGJsUbxh :(nonnull UIImage *)vOSRWufueUgXflgvf {
	NSData *JaWWPhiQwfMayCC = [@"aYBgecTRQrhEIKolrUUadEdCZylaCwAHMZSNddPtKxKeeHzWydmincFpTCTQbniYouZJVZtRGZTosPEaRvgBorDArEsPVttCzZNrSnYkUsHtWRiHJngHsrFhrgNXkQgRHXnMTYjKfiiaCovmceBF" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WSYBCqTdiF = [UIImage imageWithData:JaWWPhiQwfMayCC];
	WSYBCqTdiF = [UIImage imageNamed:@"BdfMxmrPHzjlPESZOZtjcXxZvHCFWGifeNtfkBjamZndaHOyGiHUqiXSagbNGqazJDTkCRIasttgGTmstHIOzXtIJzvjncKcwfHisBvlutNSSfdyQkwFuDWVnPxxDhKkT"];
	return WSYBCqTdiF;
}

- (nonnull NSString *)pwWQZuZyKRnF :(nonnull UIImage *)wclJKlALMWY :(nonnull NSString *)PhGpkvcVre {
	NSString *WTfjlXGEFOODTTOMhc = @"YFPsPKdPSQGMPzDULErIeTyKKVeMzinjukqjMHeHYFpuYtUzlcUigeWnJUTEWXJtwNywJxeFwFSuMDzTnLfgNfKPdWIhhhKaoKtJ";
	return WTfjlXGEFOODTTOMhc;
}

- (nonnull NSArray *)TOfxclxhBxAt :(nonnull NSDictionary *)DTKxWwRWDPOLXcYAkM {
	NSArray *JAgHQiOQtlCcXTmnw = @[
		@"eWkZGbkWHSHlkhJUyebWrJqEwvKdNBfWrrKRpNCRWYWtPqZmJuwReKAoMySWJERMaawEoMyYMVIDWuqbPnnRpehACFAgCeSzKitIFmiFQocqhmVQbtRvFqrEhworJsIGIPXoXw",
		@"jSObQnwurExytrUvveAPDtehcSLzsKBqxSRlojFOmgizDkfyRFWiMTujzJteIiJvEoEUuHFHPMKHEmMEtnHTGvpwyNkQpzAGTobgFsnOrzPYdVOF",
		@"UeuzhJJNFanqWLCZWsRwKgaWVGSMBlJdqgqhSELyRuzuqBjFZegbWWUjqtecUpgYCabgZpxzeZSwWqypXDdtVXtKvPrSLQSfIWrHsgdbFRsbbDsYBRqDpFecxzjtRCopNgZ",
		@"KxgygqEbiOyqzMlxEVTRsKRxjOwZcXrJruTHCVPISAWblndCpqWKUTuDwUpYMjsskTwmwclANpkhYGfGglvlQquBqUqvCkGosPeMvMpvbXPRV",
		@"hoIojxcbLUgwwJHwmiGNHTaUyvXrgTbcHBDinasUuqYoAWhJqyeqSxQAHKBbnuqkMmvIKEdHUryZoWNvQbtBcisJiKbvOQlCQfZwkrzRZwvqBNnFERacoIeKZnksdMAXbkIDzZ",
		@"cEBkPuqbLAfojogziQQpDeGQqaJLDyKGyhjPXfivQOAgbBiyDxnATMpGmNomCvlhSofKsXwViYyXvrBbQeloHzAfPujIYTpqeNxavrvdWjOxdJYmXSFCVVrFqn",
		@"EfigveixtLROusFuuIsFSyUbhSHicrvuNzMeMYAEoAOaxUcFxzbbUHBnpozDsxQfmssVrxJMELNWENQJcBgYwyBLsXhJkhkAbZHffORJlcIWqjnLzOvMFmwdLOzFUxepiNvPSmHk",
		@"KcENAlgerUAgklruUzDBozRAxkBexzQRgtEOtxiXpPRWbutoYotwlUqbNxlGcDJFmNkJGUHvpuWEVkkaWDeeXNAdRyKjjotjHMqSCsIdONazlhKbVUFNVSGzePtkIjEquo",
		@"rsuxpmmPFhUqWrKOodQWlDjgDkQDlyhqShtVjYKcfXVnZDtqTTubYroTnSUPKVYqSOutsTtTWHoktZypHHHUHyvnNExcBlPnfboJudpDuSTZYxjaiqBVTmULojS",
		@"AtHrqzNoTVyhQiZcuGIhEfBWMvdeDZYVOIPjmTsqHmbMpLzYZXlKGjNSHQntDDwNHbmzPMhRTKLxKfWwftkaDFfpNlArgDRuXAwggAwtBTGTccvxzffXUcLOFeeruBquuuOjtqHoPKdIXB",
	];
	return JAgHQiOQtlCcXTmnw;
}

+ (nonnull UIImage *)YFVJHUWsABCEkXjov :(nonnull NSString *)PxbeKsksNHsIWTJdIC {
	NSData *mQdOxQTievDBgZJnl = [@"hvtuqLDSEfIRVoBLmwnmhFiAmXytWotEXPWaFfznlBeZhRITwXKSydhDmnwcdtnPOyyaAYSRjIHkECKfCTZHNcSVsJPVxUvTmiXTAOfwrriRWoNGat" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *mlnRaOMFRGyzziwq = [UIImage imageWithData:mQdOxQTievDBgZJnl];
	mlnRaOMFRGyzziwq = [UIImage imageNamed:@"WacRbyrtPjWSYTYnRHNnoYHvXUJjqiZIOMQEncCFSAMAHHbIMCLhiRabXLhXfknrLpkFJIYrmErsFeLJIyKrggmaHYIenASkDLWIxTkCbipdKujQpvBIEYmHPCDZovDgRWU"];
	return mlnRaOMFRGyzziwq;
}

- (nonnull NSDictionary *)UbUAhWwkaCGzjpvkXO :(nonnull NSString *)zyorXsMiwaOp {
	NSDictionary *zLilkQftWPULkdWwqRr = @{
		@"GoVFCagRuHXJ": @"dgtJMbUwkiivplPNzdVlXmWaXvDdNrmubqhWxWBBWKPBolQAzNKDfTjqIYKOUvrdYsJccvJfygStbwCMHIsjpmYYvfhPfxcCeGZSNgNDggeWpiuNXHstVtjrWboZLaZtKpeoss",
		@"FUMePNABYeNwT": @"rVmVrdnojIZamtgfGulEoxbwpDxvEkBfjgevgmkKzFYXrfmhskDsKVSobIVGlPppOGqpdLwudbCViKoypIzDPAcfyjDBdnwQPKYYBdhuwBFo",
		@"EEUolizloqpFvQKdszl": @"FMPpKiIzeCjEuOWeHgTDPsnOiFjCajKLIbNNumonHyZwvooDWPzAEZCSzTGZGIPgXfUTNiyhVCGDUtSbLfEprskjpmwJEiDJiEJCZkznlxjVSFGajkUuMOpcSOCxBpjtaITKmhrMJzp",
		@"HsawqINVDmzLusPbZ": @"OhQrjtxzcLUhDKphJdxRvfxesIEdpIcHIBOmGpXKVBAxTmsmobbGdlrVwOVxqxfAGSXtvxhkSfvvtSAZnHVzczMYfEWTvtNobrnpKHpu",
		@"ZebcNxuYQFr": @"TMVBzyqrIEwoVtgcsIIiYyhvRvkZFBvbuLVjMZPHCnssJmEUWQHRUBstlOxPYspSmJivxixLCoFTjgUzECsWkigxXswBydouICZADEDkPMgfrqHDsbZzAcNmBhFkH",
		@"gubPHJlCNKBE": @"fqcZnIgKdeFCekumGcKmGkvYwQlRKIzErVqZpboIcOfKvLiuyMrTKmzLPHbxoTOrAabuaGXJojZbbMdGnjLGuKMWnuuqPGbPcxVziBUmCILGTQIkvoAHjJuhIfczgDJbHjuBBFNH",
		@"ihpXEwHNzuho": @"sSgbmYCSEcjaPdUMpbwRKaMOPzHOOtgKQCsxsyuedtKWpecgkZbMaLjTANQnMjVWBztsaqCogZlRIaonSNPDFXKgpfAenzmrkDWkhXqTxBRGazVOyfoaTIOWEWWohF",
		@"UaMwuaZvoAdzFfAAYfo": @"UTupHcBhbBgERnCifsANiiHzAYeLVNYkBwNINguTnaSzShwIMUmDdCYcxuNfZidXXViKzbNAcoqCrXPVNjmwFoYWaiKGPaGoRLQBQEHqEHPMrK",
		@"ltWcfTOKpS": @"OmBSQaFTKNHuoQeFNJPBdQYNcIBRzUKBMcvnqivLepuvxaYRubDbbLiWcphRObmyUlUOzrUPzwOrOkxScgAYJPrjewTKkiwtITazIyUatUqJXjriFZcyeQgpLwCNARIOqCKiOrnUuXtPpqXZvrT",
		@"YDaJeyzliwZnhlCw": @"SXdRsmoShgdgXQwFHAuekPxdSCXuvGREBchXAKaNgRYUNMphollNIouonlvyjGhQmfjuebLFGnbalHMUFjLJqDILEqINZqdcmwLpamvISzhrSTuaum",
		@"KrATiDIJTbzntc": @"KTTYdKYBVokwfhqzeApRKUzcgEDQROBZPhRWaLHiYseKImmTcINiWVHSVmsObzuFrUfrSPSgAmyRcknHCmQJTdfAgFTGIBHcOQqnZuXIxXkYkohnPCUrVQDXCHaISKhojZTWlTVIDY",
		@"SflblLYJYtJ": @"NJIuLaQbgYmponpFkvYCtcqBOCFVjZtYBbOvRpTUhhJDIdgyPHmBRWLpgLXotGHqiqGAdXPpMKOThisryIeRoPxsgupuDxkhxwHwMTWpL",
		@"xZWkVWxHMvgLju": @"lnWPKiFvRqyrfWEmRfGTzdiyMJDYtrYJtqhXuMGdHWjuDDQaYZMLytAhHYCFQKixJpbfhlaYGuIUdcfCwgOgftxqXTbYeupELtlOTR",
		@"BtPIlvFuUKRbHuKHgQ": @"qfuRVvJqlKOhakkiXgIrLJlTFkSJlJrIIYOoeIceGteJbLJyKKAJbQVGTTlBHDImBLYPgzrhMvPeTVkQNecZtUiQnMjHDxzKUNNXHbpXPBWkIBBPlRzqun",
		@"LBiJvjivnmogry": @"xskWHkfHRrKWDzMKtQOuvnymAkxwxoBHSNmxTyJxRXTnmEHyNPeLxogeONujwUfEQwsscmUvSZaKnCKIyZsyaSiBiCUjnhlQiWOrvbIzsjXQsQnuIlGBE",
		@"vMqifCbCGgyiljT": @"WPpMYrmjogLeRohGRLcTPrKfTGEnZeLbcanNSXNGybIFvdKUQtnNyNYWVgbVCcJXOaVUZyEkKuEdOESxwvNfZWDqrkepKHScAuwDVtesiTvuDyoK",
		@"TFOtxWuhliTBq": @"GmvlyfcHfbTvrcDDuDmgmwyPuwmNgyRXmDSHxVSqjYqifBMmHfaMDpkzytAnWtadOLjLDzkvmlCiYfVJiAZOpEwEQnKPfXlDYkbvirLGXRJnbRwzcVttnqknCaeFxJqeHy",
	};
	return zLilkQftWPULkdWwqRr;
}

+ (nonnull NSData *)UnYhkYasvRYQXo :(nonnull NSData *)QNaQZCctFkcdJY :(nonnull NSData *)YnpxeMwiwexOki :(nonnull NSDictionary *)LdZRXSHIVzZIW {
	NSData *dWPKRUSxXMCSgEWYb = [@"KoZgFvuiYTiUMqOjcPTkKaYIDWhoADuVSaCaOdolpjgGuJvfAelijzREzHVDTyBXGEbQCMezScnwZzoMUxcpITSkSdKSffDjSAAMoW" dataUsingEncoding:NSUTF8StringEncoding];
	return dWPKRUSxXMCSgEWYb;
}

+ (nonnull UIImage *)itlyxCEbzKmqqmo :(nonnull NSDictionary *)eEIugQNNQIl :(nonnull UIImage *)vnSPiPKEbjHOymFXBg {
	NSData *ftGmRdfoQEI = [@"hVjAafsyseqRkKiYHsPFxHOLWKiwEIBNbffsfxRALLZPixZIRSNPXiMIIrYfcpoPNTDcSqcNKPIlOEgrbaHXUirsDVCpYRvrqTVQGRnnvvzvoKFFXNzCRDcyjfWvjfKtqwgxL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *tRdnGNnSRW = [UIImage imageWithData:ftGmRdfoQEI];
	tRdnGNnSRW = [UIImage imageNamed:@"DNSgJFFDTNvvqaQTreUcASzZoDPpKcodWVShxJwGpIQUBvmJumUFVOmXHCtNLunFcUrmfVJEgREpoacxNatQqFrZdagsrTQjGXyaLgA"];
	return tRdnGNnSRW;
}

- (nonnull NSData *)kiACCZsNCYhk :(nonnull NSData *)eLBGwjOqZnVwwLpgpp {
	NSData *miyqoIHDlXTAsS = [@"AOHDkXIicmOVsIVzQDbPAdgcZQRurOQprxVTHtuamSdJeCKOVSPzvgrCggcQZYOFAViuVGUvkqcLtdORgeyVaIInxrUunRFMCQAQtXfTeHujrJPutijCOsaKYkwkrfEMza" dataUsingEncoding:NSUTF8StringEncoding];
	return miyqoIHDlXTAsS;
}

+ (nonnull NSDictionary *)LuXGTDFiQtGJTIQ :(nonnull NSDictionary *)RlGvtCOZiaPtTnrugq :(nonnull NSString *)NkctWFPCMAKSUoUaWw :(nonnull NSDictionary *)YzeABCfAxMqGV {
	NSDictionary *AZKRTqnzNsak = @{
		@"HVGQCiSTiWuyN": @"mtUCNwquYayDoDuttcYRbKPmNDxTSpBGjZGfOXrKLJWmLIYthHJdhlxwPqNjqpBBRIZLdnGXSncHHNJXdEZdIVrUCVsXCZdZAZPMeJgCnJWdUtYhBtjXanVCkSwSQMiDCasewKyiyNQOCA",
		@"YaQxKdVwblBmiIEjXZd": @"kDAErLDZubzQSBJNURWbYqAGTzrstjLWhfTZZSeFLxTkVoNTgWSpsgOEuENSqljnwHQygghgLADewoYQyxfhjtbYbLFHTpuVzrrZRJTpeZGNophQlsAdXwYFWwJznkhwgKiHBFaH",
		@"IjpJAoNLsnoVxN": @"DLMsXqprwIAKTgJwIrSOXuzVHfOmJOGjIUcFcutUMNEnbCHcsxEBTlDuXZknbmtoVzfPunWLwMOyZQRZJUDfOSjqclXsltRMTFNAgbtvoaEPtzsXqSFzBWUznAUCYizMy",
		@"KQQDWSFdbfIVMvw": @"RANOINLSzxphLJMXdwZffQZcsMOFOqPCNlmyafDtFxrYkthfjITTbKwYkVdtaBrbqnVzwxeaEiKBqrhIAQbuPtGnfUIDpXWhjmuhCClyHMEoZekkNTiWslJYTAzhBxSyDCKiweHmvdeuGhY",
		@"hExznQpaLXuoYklxYDI": @"qeeHtqfbGOpflAIaUOzvApcabfdpTvOSbGBscwthLosGRyqeMPJCKAQQFLxbBEpIbbasaPRVmWWlBBkRbyjplTSBOSFaemJatqSLvcnQW",
		@"pqYSMKaBoMlK": @"sBZGZVeVUUVBeRqhONIjcAHKkZwQNGamJvMrunjQEIqMZdDsVkLbNicAnasZbWVoKXDDWQyBduqXDdiIWSqQOKPffPjWRmYPdjEHfNSFZgIvtEoFXviKQWXXWkwDGew",
		@"OWyRpfsXvAYhCG": @"MxsMCuMZPeCTDUqiZKDuPSaLBpXgYlZdbxJXbHUsCpyQjuRmKWmZvhadEwOfPGoNtKTUipWmHzLzeQWOpwSKUvwuKBJYmJhSzdypBjDNkJHsQHuQYLMJsJ",
		@"LudYZNOMWCgqyFYOuN": @"pHVyemjIFWKHmqjdskvcbOfwyPKOpDkwrzWqHHLktFZmbkPFVFXqIwlBommZlSmFxrtIibJeaXGeoYucRJeSrYuxOwKGrGjUqAFaBqqJfFJNePudkIhhmiJiLPlqFQKLKCsGCDMzRdMiVvIIuqxe",
		@"IQGjWTeyyeyNniHR": @"shpGoZfNShYgpSbpLNzZsNbPEHLCwgRSgykKdJucNqXDUNwMKVThvlYWCEnYERcpLcREYuxOJakisbIlstzfHTDyeipgbVMqqClnOatDUtKwitTeKerbZwopoO",
		@"igMxRcZmWaHNPC": @"OSjxQSaTZqZEsFDKZUgdVRkEDxPfJszdkrLNHkmdWWwZwyRgJktTsFERotmRaKTMMyhFhtFsTNbbEZIXKRkejTIUJYXfIUTUrjKtxOhocsSUTmKEnfooHYIHFrGtpTcjgkLeC",
		@"RfaQKZbwygOXADA": @"ABYmSDXfsmGggjCbBjkvkqiMHEHWyIwhMysILhGLFpCmfxrannWVTgHecGJwLPqeTxprdQBHiWvywhXvdHhvgWJVmcqxxgNzhktYRNZpdKGAiHqZKQl",
	};
	return AZKRTqnzNsak;
}

+ (nonnull NSString *)vVDwVsVoQRPMT :(nonnull NSArray *)ytEbFZlTnM :(nonnull NSDictionary *)LVYryhZdVweUb :(nonnull NSArray *)xJbzYVuuOgX {
	NSString *OviBhKXJgkVLhe = @"SNIAKQEyhJYdGsuyfBpkSGPpRSbqlYxicMrAjwcfwAdiCYteARyJhwAKqWAfKFLQCRKwLCOygDjYYYMGMjdCDdvDeUHFQlWNvlYdDvvJvEGOgKCmjkb";
	return OviBhKXJgkVLhe;
}

+ (nonnull NSDictionary *)SFkAXaFIyMnJQh :(nonnull NSData *)qYJSsxJjEp :(nonnull NSString *)MTyRuAiMprvABdmBSm {
	NSDictionary *qCwcFmNctwZUU = @{
		@"kOWFHJkBxk": @"eBXlUfAdoxEzKHGslwOcEjqJLjMMKJBbZojibaLaVWhCusNXLREHgWxHeWExfzYfnKDuUTMBAApJWJaAAmRrvwHyeBxAvEfzfYxbXp",
		@"KpOTgKBzhhkotQY": @"puhyoLbkHbVDlRmpNuJcJZimKkxSCJoipoErPUaDYywDYQboNmotzwyAFJQQVgLpgKnuLfFYYrFwHDybzlLdAswemtftBbMfrSvZqEpTFbTSmodUKyaTniyrKhYqkDcNvTPUkiNgwDgYndkFb",
		@"pDtPCsByPnUKw": @"rOgSYoVCQiSLTtepvkDhAAPgpQQRKOHDowLTjewfiBMBKkkIPndVFoPxUbSakCKeppUvwlPFMfZzLToPQDsLgqmgbSxHzsXygVDWvZuJpMO",
		@"rYJDewAoJVGhlLUxC": @"NkxTbfHTDcQShwWIYuSrWNKOmlvjbXEbaOzTwHwrgquumRBgiNcBJzZfheLAYNBqBpewScZQwiMQplrEunbjFOOGMpSughBcEVcejLroHdlu",
		@"xzzrxzgmRFKqrRaxA": @"TNMdBNBczCKKtSiakrjQRRvJVWwcHbuEwKbULQoLClgutGLpHCuClYKdObIZVZgGtcPkzLtpOeGiFKzhMfKMmfPFurKuFDXoNkqpkonTudWaJqMMRzNDtBNBFoWg",
		@"YEVOPOroVJLtjXRav": @"nYeLRuptGuKeHSECAVZIPGkzLyAunkVcfCdZUGMCewQszwTOTjBNFlmfeuseKPxFFCyLMgGvfovRoiwociXojYczSNEOuAzIrMIrcalBtsTL",
		@"hzIlMwOViiu": @"KUQJtGiawBjPsKiBuTJiVwqxwfGIzfLYqZLMfEnFCGfGZzrIHvKYNPPDmWBeVamjZcxadRsumVSVjzuijNflYdqwfIAfRtvYkLNwtadCAoLVGNYrfAdUkkNWwbbAGSiknuYXRISHtl",
		@"RvWkFoKAIZTIAEWW": @"vAHssUFSFQzHicOGtKbOfGCzYbNqfJkQppPLVjbegWtDlQGOOLEujGFHVmZZWbrRkyHYZFxuuEJjmBCJYuiKNrTEtoDNKVZxpZUTMgmosqzEykqKCBZSSaMWXMkyTiSJNPRJkYyL",
		@"yIrzjykySqrEYWjQ": @"yxqhubvxZoysgUxxHcfWhFakIqhNZKVDJdneBrvknYHBecAtTOFIqczpQXRsVdsdKSvDfwqDPHLybtqAXdQAUFQijbugfwIImcANBcUIsjJPeKRGMRMmfVojcaHdL",
		@"vneYXdFxPPrjwyC": @"nWZgdMxhwxSbxbBiCqgHgyHGzPLHahtcMTCDmUNfoEPJSTnMKufeDkWuIuwNygRZLCQrYZcTdzKqKeTZwrcQcGbjnrlZptlXFsWFZPsNiYWksTiaRkKUBslHLStk",
	};
	return qCwcFmNctwZUU;
}

- (nonnull NSDictionary *)eFPZznJenPAPmjCeDbt :(nonnull NSString *)vfiamCwEvHhNFH :(nonnull NSString *)fNbYbPpedLuLOb :(nonnull NSDictionary *)qZYSNbxzEWFlub {
	NSDictionary *FtxCtwCPGOvEuZzc = @{
		@"LYUSEOMVLVC": @"zxmmGtkEoVwDPsJPsiiLTMTAFgJgWtNEMKaPqHRtjDmGoybIfHBSFLksGPgEutKqdYMZWkvHzgpNHuSuAlcAhVASwaGfKGqwiEdCwFVxWIFEF",
		@"MDjSvYPxJdRIqeW": @"KrkpyKZfFvlftMremcxgZzMThoEPOGrOaFtUJmKVyqBpcMpTGixnHLsdagcVeQPxGbrGjQlOajsoOfYxgtlPuguFUfyxHpTIbQIbQpwtqo",
		@"IkmxKwxMSCZrfzYuLp": @"fOaQMqwthjQqXFYcuSdfVBiMdERKEHWDyQRCGSeYcszrNkBfoKaHrvZWtfBFjKoIwWmuGJtXuWcteVdRmegTdvCKeowatNatYJpVNpENcrl",
		@"QxfsvTUUPushhWUK": @"kTVwvyXfSkYyHCTmsAZcsogMoYXwgOANiJmWfBqOQVAWTymEajpgTQGLrxaOfosglTVykASgOtnkbIKUQHHzAKbAKNsalTSqiZCfOijvTtHkBkPqRGrqbaQUhtbSpQOuXOlfNYDQbzPBk",
		@"onhMTfAteKPyJ": @"UHSnddrGpipNutarPbJsVHvmGxZwwTigUeuBMipJCUONEnJJvWTyNiIbAxLtTKvgLXVWzCwlBkJObIvdMTtESQrhvabBUYExAwAfVG",
		@"oYXeXohyQUtQb": @"nqqwrSYybpUWMiHTUPVZwTqYiXbDdNwvcebJjmZCxOWMPeKPdumBYjySHJovAPhTdqodeWXPozIpVsvZBMPpBKZxuKHeBUgEGmSqkut",
		@"JkBbrcYmQHmCToQYq": @"fYXfRlBhkNeQaabVFtoEswrfpQPMaZVuaLyboGScIYaufCcaNWoctdPOOZsIbEYcRwnTmLQXRuTFXcFVLAkZjjdQnHedqBNWYTJStlYjHDlpsAzrXAVbFzwFQ",
		@"lpqaszUvxHWHlyyoj": @"nCnVTsmxvGWryIZhovkogEpMbEvdaVPlEbFoWaxXhqUHgrPHQIplXcjmHisnfpwomJnIlfFEEbQRZtyWIJXpcgCdUaPXYFOiPLpHeLWIwJhQdOEGqyT",
		@"VZblfwkDYVKvmSg": @"WHHPsNKxRrgqVECiLVepdOjAFVXpVrQRyowxdkIeoeAmuMQYtntxSUMMerCMlwoOeKyIksDIVLssXmucKmaAjTIHmiAyfrqskWERYcrqTVSqBussPrUW",
		@"BkBjymXycbL": @"uFHQniqhGeAVkhNnUVqSnSAbGuJhMtuOozAsFUoEpWYyMCqnZVsGDLIsiSLVwPuRjdlAeVeCCuaWrDCEquOvhlmAecuwImLZtvmcnlcTRQIttaSwGynabeTlJ",
		@"vhNkrdtHjhZWJsejeKX": @"OoniVfyiAsPDwPJbxQgoJiGZkaLsuZzqsfMfaHdixLXhQUcwxRMmXaEjqpOGudoIfMJpkFVGIMqclaPyIqYIFcvwtqdDOmUsMvWsuusAmWVQHlN",
	};
	return FtxCtwCPGOvEuZzc;
}

- (nonnull NSArray *)rBzVpQAooq :(nonnull UIImage *)UibNwQgAbjpcrWtEJQ {
	NSArray *VZLWIPbPLuyzXxr = @[
		@"YIeKKQscpeyuOuIRyBJXWCajpHKBZBpGiliKRfmuvtjQhPLzHhnYVyFWFlqWEWoAjKYHmeEfTVzKKkIeRhkkxEiQwrOHLjWAqatbqlmNOoDmWlmbjMAgJe",
		@"HIXiTwIdhRliCasOgxnWOfOFkCFmfJniPWMWULRfnuNoPtNujslmZYhqcnTEXaCndZVUzjmSoYSWozYYpGoDZuZdADInriKmZoYtFUDAYoiKelmVXbwfjQhupoAFpt",
		@"FRjLECMmSOMCxzZgxTEOlaBVaohWpqeEIMlmMVtukqkpoMPhwSzHKlTwWlYpuyMepvVRqoJTlhGbAnwuhHduxjSPYGfOnykLkdCisqDTTwtAYicqdIIiSljkOiraHESpfFuGU",
		@"uSumKNIgGxYzGTGGqKtsBgznCXxeWriMYzmxDreOEaBsRUcKZuPcGAcOEmkrfRTZCLRCFSNZorcBMuOspvMebHQYOMKEyqexJCWIJKPk",
		@"meGSmjmkJUuVlndhERqIdpOdjJtRalqYwUROtiaFoYLKfYitPFeOyBFTFZNXiBYAhekOiPMoAhbeqMNdEoGAwhkdoUiuZUlyyZpzYkJaDLQaWdlgseijjggORKDzUxRS",
		@"WHSdmdHaRXZiishfSMESOMlglmGWSycqwHWOSuPNrYmXokFyCbYTEIHwCWjNUIhQxVlKiLrayKzWtbqtlyohoVFYuBDwEJTpVmdqnkrpuFxRgJfaZWgmbSxjdqXWcGTUBGeDR",
		@"NUIhvIEcKpMPZlfhhlaqXhFMAIcwnXUMJeFoiIMSEERfFNfGIUdlAYSeLfGoVKjBwYaxaVQgBqlVEhVVzcXNqGjTBgUyGevfOUwjCxEnHRsJMXorFnMaskQLAtjaUBiWEtnuMVQGQtIXBpoNwNw",
		@"gtlGfigNbLSmkxTMEGhZZalVMPgCtYTAaYVOfgtIFqCmgeYjsAAJrRfqYdCuJopLhYEkEAZwsqaTBmepFPAoTnFULIsLnlsHsCteTNKR",
		@"GPQpvcKULnHBDouwnEdkrrbLWnbBgdmgTPiJTXIjidxeozITRoxXXsRqRqSVMBaWDqlhLCxuLtIuAzXSifWIIgRyRQIhegopyDspVkZFyMaTEBtdVqBhLTQtzWOxRsaNJzOnYeYuufbVpYaWaZNI",
		@"uOEpckqpkoZCBqUPjgwyoHTFUKnUNXCJmyckvGImqUivsgaNanFCJpKXkKetqunhDpsHvRUweZOTIUUFaIpNsidLKTFKYtonjIamBUIZPLeivrAjpVFTBDUrvaXMDihWtJ",
		@"OZQYwjzOwTQzjnzoNvrCpRIKbrNaXVGklNsbzZlNKDPNvbtiNlSYaApPlexyvPbrPkUNZKSCvYQBubvooePzfnGxmDOwFNsBjDImLpiCmjkWHJTrEUIFLHVSSIYoAMQAejuIJzqRWBqAzK",
		@"FQNnvsjvLClhiutbnzzOcqlJZoaUNzSpxUKfahUJbvzsRIRaKZgFEVmnNjdWMCeLPvtKjXSbkJZWsvhkrVqjlmeJjRazZFLdUAPxbfHNSqnyLkroCuZCHshiLvyAkqBq",
		@"xWfbGcpkBkgCYYhamdjGLVgTuygETtsKJVOlQahViejePEsbcMawEPBxeDZjsBDDNTEaRybckbDNDeldjIrmzdkiNmwcZLctWYriTHtHOjREfxywRKxcHgiJruelcGoIasIdOaJdEOhSa",
		@"xSQyGisRQBCCwNsBXHZENVsFYksQBkJiRovCQrEzaDRDpbxiMQHXxzOMDoFMjyocxMZqUeRDwoqWMctchPqaSqvqWlVsAFddXINNMTzM",
		@"NqeHLLVJkCUAjseCsuTFYqdWnORFOcBXCwyKZnARVoSyfMuzkSrDhzQWKlvUyBBwVPXLxryeZMhhjtvbCOBRjlZqgVVlgGqsZWGGEjBoN",
		@"kkjYUznDfswxZeZmUgJTVwfYLnENeIrXRfVMVnewWvjekyxoWujPvrdDmbearLEWFzIjgIoXXNyIXwitraohyNFsCDBXEOskenVfDLzErDCXZexqvmtLeyzzcf",
		@"mNmUokfHerSJZvfSYkeTQhvaeFYRCePcSdjnBObHgEXOYaALsYvdYMwnWjFjGHgZuepDEUtonjMWaGsmtVqyfitveeWlNYBgxKfauyalvSvzyyFffrvIPDNyMBboRPGQcxzLYERBTfd",
	];
	return VZLWIPbPLuyzXxr;
}

- (nonnull NSData *)PAbybJNcFjqRQxcF :(nonnull UIImage *)KJgTdYVOtmPvIHbvTw :(nonnull NSString *)fiDCBUpQumV {
	NSData *rVGGQfYrioVO = [@"RqPHhPRAaZKlVzbNHlPwATudQJOQazMGArohDFaBEgGHuromGRCOYgXyPUMUPZLimkfBJrZltfaHdPKDVpztEKUnKBcnUaaQRmWeywCqDeeYAxGyGvncQufPlGCShrKLT" dataUsingEncoding:NSUTF8StringEncoding];
	return rVGGQfYrioVO;
}

+ (nonnull NSData *)CvCJWREzgvUgVNh :(nonnull NSData *)OPXuYYDsrab {
	NSData *yUEVntAqOMpKzYkTWjz = [@"OrvRetiFBRzWChCkZszUkbXAQKjqqFpfHbJfmhIUMSTNHvFjDCmhAQiaNvEtQUhSJNaAbjEeaxVdEqIzoIwjFkezDEUvtYGsCgqMjqvxMyUlzvZwk" dataUsingEncoding:NSUTF8StringEncoding];
	return yUEVntAqOMpKzYkTWjz;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShalonModel *model = self.datas[indexPath.row];
    
    MainWebController *shalong = [[MainWebController alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@%@?id=%@&locale=%@",NetHeader,Shalongdetail,model.businessid,[ManyLanguageMag getTypeWithWebDiscript]];
    shalong.url = url;
    shalong.webTitle = model.title;
    [self.navigationController pushViewController:shalong animated:YES];
    
}



@end
