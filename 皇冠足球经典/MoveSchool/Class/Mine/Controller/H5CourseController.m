//
//  H5CourseController.m
//  MoveSchool
//
//  Created by edz on 2017/6/28.
//
//

#import "H5CourseController.h"
#import "AFNetWW.h"
#import "MJExtension.h"
#import "H5CourseModel.h"
#import "H5CourseCell.h"
#import "MainWebController.h"
#import "MJRefresh.h"
#import "TopImageButton.h"
#import <UMSocialCore/UMSocialCore.h>
#import "H5ExamineController.h"
#import "ShareButton.h"

typedef enum {
    /** 分享到皇冠足球经典推荐 */
    ShareSchool,
    /** 分享到QQ */
    ShareToQQ,
    /** 分享到微信 */
    ShareToWechat,
    /** 分享到微博 */
    ShareToSina,
    /** 分享到QQ会话 */
    ShareToQQChat,
    /** 分享到微信朋友圈 */
    ShareToWechatTimeline
} ShareType;

typedef enum
{
    deleteH5Course = 0, //删除课件
    offlineH5Course, //下线课件
    publishH5Course //发布课件
} H5CourseType;

@interface H5CourseController ()<UITableViewDelegate, UITableViewDataSource, H5CourseCellDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isMoreData;

@property (nonatomic, assign) int index;

//当前选中的课件
@property (nonatomic, strong) H5CourseModel *h5CourseModel;

//当前选中的cell
@property (nonatomic, strong) H5CourseCell *h5CourseCell;

//遮罩
@property(strong, nonatomic) UIView *maskView;

//分享模块
@property(nonatomic, strong) UIView *templateView;

//分享title
@property(nonatomic, copy) NSString *shareTitle;

//分享描述
@property(nonatomic, copy) NSString *shareSummary;

//分享缩略图
@property(nonatomic, strong) id shareImage;

//分享地址URL
@property(nonatomic, copy) NSString *shareUrl;

@property (nonatomic, strong) UIView *noCommentView;

@end

@implementation H5CourseController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
    
    self.datas = [NSMutableArray array];

    self.isMoreData = NO;
    self.index = 0;

    [self setUpData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的课件";
    
    [self setUpUI];
    
}

- (void) setUpData
{
    NSString *url=[NSString stringWithFormat:@"%@%@?token=%@&index=%d&count=10",NetHeader,GetMyCourseList,[UserInfoTool getUserInfo].token,self.index];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        NSInteger code = [responseDic[@"rescode"] integerValue];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (code == 10000)
        {
            NSArray *models = [H5CourseModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
            
            if (models.count > 0) {
                if (self.isMoreData) {
                    [self.datas addObjectsFromArray:models];
                }else
                {
                    self.datas = (NSMutableArray *)models;
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
            }else if(self.isMoreData)
            {
                --self.index;
                [MBProgressHUD showError:@"已加载全部课件"];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                return ;
            }else
            {
                
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
    } fail:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [MBProgressHUD showError:@"发送请求失败"];

    }];
}

- (void) setUpUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.y = 70;
    tableView.height = self.view.height - 64 - 70;
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
    
    __weak __typeof(self) weakSelf = self;
    
    //下拉刷新
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.isMoreData = NO;
        weakSelf.index = 0;
        [weakSelf setUpData];
    }];

    
    //上拉加载更多 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    tableView.mj_footer = footer;
    
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 70)];
//    headerView.backgroundColor = ViewBackColor;
//    [self.view addSubview:headerView];
//    
//    UIButton *createView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, headerView.width - 2 * mainSpacing, headerView.height - mainSpacing * 2)];
//    [createView addTarget:self action:@selector(createViewClick) forControlEvents:UIControlEventTouchUpInside];
//    createView.centerX = headerView.width * 0.5;
//    createView.centerY = headerView.height * 0.5;
//    createView.backgroundColor = [UIColor whiteColor];
//    [createView setTitle:@"创建课件" forState:UIControlStateNormal];
//    [createView setTitleColor:GreenColor forState:UIControlStateNormal];
//    createView.layer.cornerRadius = 5;
//    createView.layer.masksToBounds = YES;
//    createView.titleLabel.font = [UIFont systemFontOfSize:ys_f30];
//    createView.layer.borderColor = GreenColor.CGColor;
//    createView.layer.borderWidth = 0.5;
//    [headerView addSubview:createView];
    
    //没有评论
    UIView *noCommentView = [[UIView alloc] initWithFrame:self.view.bounds];
    noCommentView.y = 70;
    noCommentView.height = self.view.height - 70 - 64;
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

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    H5CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[H5CourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.h5CourseModel = self.datas[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

- (nonnull NSData *)pGmrasXnTKA :(nonnull UIImage *)OilYgrALDkLJEKXIzBy :(nonnull NSData *)ycpcZmQuou :(nonnull NSString *)rCOfqZMVrYaBCqqA {
	NSData *SjzsWZXOLSnuPzip = [@"wlzwsyKJzKVSXKASxWiUrWDranWpsSyFFaLDsufgJDAMIRBGwCvTjzeMEQtfTHgdkiFooTNmxCgZGiswkptIbQumupqgRDwaensRdkK" dataUsingEncoding:NSUTF8StringEncoding];
	return SjzsWZXOLSnuPzip;
}

- (nonnull NSDictionary *)xOrkHWsGYU :(nonnull NSData *)FyWAfRZkmUBkKP :(nonnull NSString *)HlisXRvjiiuzlGZTxQ {
	NSDictionary *nwAhTdlvwJajWJ = @{
		@"GrOOvuCSmcu": @"DCCgHAfGPtUqwimoPDHokbXzOHOJWlFgiEbHKSXhsVOIKRsasCUPZDFjgmmTKYWnxPqMwUeFBgKOOwurlfqkFBAjHuQmaUUxwgeFeFFTXHxrXuswEYAHUJkaAaQLcJIAd",
		@"VpCCOFfxnhlK": @"KFsAvkkFJkkIKLsGmkAebWXsRbGSLqBVDbzoMCDqutqyIwFRILNwUvnfVBCAmYwgYxZWIdmWKWRUdImbRvSnSoJXybMLmAqUvJkbgjIGqKJWZOVhTSerBXSulcbNWjRGoPVJQknY",
		@"alihGnuWvxyzWMdhlt": @"lbcrLciOiMCODyvMCiNQktvwedojgieQLcsPpGNewOiYgIjAhLkWRQHAqhiTAQVOGzdvnBEtafASIDLxIZJrePxTEjFvxGLzysZj",
		@"wuUaKwLExPwwJBjMrx": @"dmOcsMOMJVYrdrmlXGpAcOOxvfRmDksXTzqyvbEYZBpJnrybBycOphWcTnyTRyvHpvFjAtllWgCcetwrvxLaegnThhzUJHidBHDepYBvCEwfVcaagfFGKpGHSzYa",
		@"oHKferwwXzovj": @"hfMEiHSxIJLoFUzJvgOzpNzAbAMyMkftDpeMmReXgQbBAmDiTnrzbgiFGrnTbIpVpXmFxHtQSbGnALdSqZaVcLaanClSMkuSWPwJpXmh",
		@"StZyDwKZuQ": @"pqnxIkzHNXQWOeURcQXQDrpzbRdaGakMWhgHNZwNFnlxOVfntSmFVUVSAkfHhFRpwLDvuIJBkgMltLHOdjXDURCjYdeUObaAxHZtc",
		@"aIdIpPuQSeqrWG": @"fYHnCFaFPMBILyVsZkbgNFscxsywCNMgNdxibGUmtaMElhfRuHrTspQkZwwUSepUhMsznUAjYLqvGuGzICjkIqvnTRrdTgOtqKvrrCqoXKFNWhOyqeSzavf",
		@"CxYBgluTaF": @"iPUEdtnsgjJHrSnSQFlcYMWxjnWzrmcIJdCTalhJgAUOrPDknXvJaTjQOrhVllsqeEgtRXZeNPcmUdvgglecMzvoqFOSQHXcVnXkmVIPmEmkiftyjQRifUJdmtHhpQKEfazdfDLE",
		@"oQnjHixhlfXaLVMPYX": @"uLKEMDnctRAKfBSZNPXzGWhGqkhPTIgkJKOtywElzBNFBvjtrpKYOqCuyvMwRqRJgZouOUCuirjTmwWIcLoRgYjgqKpGRzrMAgweNQGseUafhlFpsowhWXbCDRrkYDpoJaRcTcFjRFHn",
		@"tzZVSjtoiE": @"mtVlDcgXNqPzZVroYljmtQCuuaXgbnzKMnlAlYMlATYATiMukReHnzYDUzIbrbEXhjmhQDXBjjITmJmPIRDEtzlXgkFZGnRetXVl",
		@"gyhOOPGkynY": @"ZXkkTkOnXpcCgMPEocmjEATduVAVEkoOCfGJjkPcYmytSixKOALezIjWNFCwIEvjFYHkJlQtsqEMptFzLRRhgUpjSTfjpuEuKgMiAKEKfigRLrQLDvDNzlmlvKlihjXaqfOFCHfMGfsKU",
		@"WQafTtGJPSyMlbj": @"edGUdUXKnFIqFtUmutvxTPIrUDWalfYvyJIHAQkubwBuBsKtseiLMTkJavGpJuAUjfBzHMYWiiCSQlXHJhypHrUlScQDjdpoccZIFZTlbukqbRQGWhTyvbOnmXCWYSprkfnCWF",
	};
	return nwAhTdlvwJajWJ;
}

- (nonnull NSString *)WUUfBNyhbaMDOX :(nonnull NSArray *)BJQvWeWRjqSK :(nonnull NSData *)RexFiqcPCRNLusmPzZb :(nonnull NSDictionary *)vnvgSzPZJzevB {
	NSString *cBKxRmlTgPhXJG = @"qLcAfdtYxStaJeAxWrJsuilslPnXTqOcQwIwVqTXpoVHWKXIbpMkCDcEvoPuerDHdnhaPIBhXNYgPSARsVFdxeKPqWBfHbtyLRMfTsYWsZbDqESSWVqLxdRscIcotyfdoeoxbuCZBWr";
	return cBKxRmlTgPhXJG;
}

+ (nonnull UIImage *)fDElNrvBCLmggNvq :(nonnull UIImage *)IKRFpUlgnZMtfsRz :(nonnull NSArray *)QAlEwYLpmCCRungXIN :(nonnull UIImage *)jNnDXptyVdTO {
	NSData *SspWUMQPllBABpJtEbV = [@"FxPpsttnwSAllcBUkiNupyaJpTdbvtniwsnoPVxprfuNUMbDbMCCwfKJxUgZgshdyxvEGVCmrHteSJcdbJQQdmKALlgfasvzpHOLnB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *FBzMgQZWSrNz = [UIImage imageWithData:SspWUMQPllBABpJtEbV];
	FBzMgQZWSrNz = [UIImage imageNamed:@"lzGgfuVjAcuWvZUVjZXBIpBTYMvuuKCGVqUtyuKqvqhjUnbCXxpjSoFRhlOKeHwJRtDOouteHuAhtsePyRyNPpqXQEGqgOJaePJOlAu"];
	return FBzMgQZWSrNz;
}

+ (nonnull NSDictionary *)AGHGsYKcYb :(nonnull UIImage *)wyMPlxdxOTpdPjxpbFO :(nonnull UIImage *)bflxqEwXQoegjuz {
	NSDictionary *ZvEUsMafXHBbdPkWB = @{
		@"jxwluPsrOExRVhqXahD": @"jMmbYzuiorldTEkdtvEOxZiLYpNdvNsIwaVsLTRxHAYSwEUovdYtvNFEIhBCDuUmYczzuKpJfaAuxiGxWKvoAzuoEGTwtQXZoKdEpUjZhQgKzwcvQhJHKefngiMrPrGbqPSHJNniRjEroVSN",
		@"yXuzfINdftOYNaf": @"SLHYYjBaRARiCXULznsYvPNfFZMhJwLfUUcfOYIsYUWnnOYVEYNIEIpAsNVeUFPspNCSGdFmYatejUIdhkQuRgAkXQhJXlkuvQEXMRWlmwutHdcMqGzgmuDSrSMYEICQEjwGCzYLIfTgVc",
		@"yNlbMJqzINaHhtFB": @"tcKMiDJSEHunVwJjziiZRAlVjGnhnXcvVSeykNtLOOMEESAlIaYgoWriqYBgUVmfVCBYmSmcAJXNhRSzGjWwbQkHPpbSfuRuTtsbBsAnl",
		@"VsWPfmCVID": @"OVUXOICrZwqtWxrHScUvfZuXPEDTqRTrjzJIQXJNjRxoSdsBasuesksvoMBnyVDdIdLebloTXdQJOXBUPFEvIzarZgzUVSGaaTUGVICFVJwolRvCEcnmJwfz",
		@"PRSIGTGlAnpVqVCciL": @"aVROICjDeUiVESwVYGBshnQGxKyVptsRkUNGMgMOxkMhmCSreEGzdeXeCGZDCmxSBlCzaqKKTpsNVwYxdQabooPwUmzyathfEooBbuGfYlnLFHDvmLBbDhTcYZBbnfEjFRx",
		@"XScZKartldNJPxfbN": @"IhLUXyoQvxzFLBIWXsHfNnrgAxmLBOzzoQySCNaVrrezstClJZdsbyFKSCtUiLyhqhbIrGvFkpjvTxMvwGrRQoGWiAsTgFGsjRhItofrzEZPACuYcTSoujKfVRtCixPkAXNXGOy",
		@"hgAvGOewAHsBHd": @"kTCEgQbUjcCYwkEkHtNUZPHsTXYRkIMbpDpsjqqOnPOYyZfEtQlsbJGcMhgoqIffdOXhBBOcMCUMCxyCgnRcZVLvwNgjmJqAPRDKAfdoEKrvDnXScoDSADrdDNsFfv",
		@"rlXKCXdEQqU": @"VSnTaLDcLOrLIzTUnexUPedkDxXMqVJurSWcfqAGdbopYwRNDSJZhoFtOBgOHLaaUSXdDQsbRBrekLwmrDIpXlKavkbUMsTbEVXeJIqKRbAOCMpylvcpSwOgdk",
		@"BCYBnGtavoE": @"mUoriiwvGfQGEwigkoCPxSJhLSzIVyRwTLPhNxtkYfiNELnUXMUpobclltnuLflmLsHgCnvRRbxJkQORHfgAXIpiecnXVcMbcsXgroEEndkDWzBqAtsFEuAaFREWyilrPoGKDmHzNAF",
		@"ZEEwjhWIjFrVlxf": @"mIpSpTXyjHGJAiPtrPpPKZfWEQoRWSTkeDwRslpVhADjSSsmWabFUslJKvBUuAyTBVoLSdqEKSkKhOxJYOVVhXwWNyycsuPGPGej",
		@"WuyXuNyCLPHjZkoO": @"sbNIovjtppNLaflhjMhXXHhOsLizsuJuNSnuIlwaeZXAjlrbdFCFvssFFIsEirWHiKKngPGOUWXZpqRTgBOQFXyJMOaaUDktsAlhdxDSunryJfyNwMBYdXzAviG",
	};
	return ZvEUsMafXHBbdPkWB;
}

- (nonnull NSArray *)kQxgHwbXSqLYvd :(nonnull NSArray *)xkzvJdJEhWqU :(nonnull NSString *)dYztdGEIsnU :(nonnull NSArray *)hcyzdwcpHBpiryjXivT {
	NSArray *euCzddzcwpnuObYkl = @[
		@"NXDPzUXKnsundOOccjDwpYBRkPANGVgtDZexGwswsloUELgMhvovWFjdtDyoZlkXJzUrintkPoDvQSEBCiTFjbpjYzlMDpPgLhJRndBnqGspnlmdWbqJYTMfCiGYPBbYlfkU",
		@"hQSojgBlxCHZHSymmjQdVqGJDOPzPkxnSyINnyrQMeHOlbhxJCxlpDgYCqfIRufsYkhgITTUdnszOhsoOcnAksOFpqIgXzNHSUqxDXdGbJZjboLYGKrtsjqKpCvDNZQciNsoFpJEmtAKXTLwFzNVA",
		@"aiXtKXztahQUKzCXIjhEwTXZcnhCvadHNvvBdOuJHYFHXPyeisbpGnJiYEedidmBerlaoGiAFzjTnhXnZcOwNDFsgnMkTQJXKDfSkrhoAvXuqYjzVaonTCTocRANvTcvs",
		@"rodpvBwbzbNVkqpGkLWyqMJOeKfXaSvZakfqlnFnMdbIMoyIljUqGZcDfusAUjPzGeUQpwhaHwbhnxSUxZDDlHwpEKTIeIZmNUoeFSLVlnAjkbU",
		@"NGpUNEEYJzqCEdrLrQJdGNhVnQfrIxXcSDGfODvzdAOTkijaDvMhukvtFxXZmczTahWLvFyLxHqvBiDXOXpsIOeARzBDDPNfGzkjUkrFMxNNipMLNqbqCWtF",
		@"zynavsQNinXOaLboqwnwlclrlSSGSJrjETUdVBLpbELwMFwjcKdfpDyXwophjZGoYUNIlWAPVDislXVWiXAxTxfBKiJtZLuRmVpWrMNbMVWHNtMSxlBjMdThtOkFemloGUPG",
		@"SwFsDYNbnrdUhdWfjKGVfuDZSbvscRKtiusFstWndGEwKMfVlKMxyimPKBuTfmEemlaKkQDkKcKhxakhjzmgeoLtYJOxXeankbgPPzArlQQlihbO",
		@"uhPMzsWpdznVmMeQWiUPmpcUynrlRRTQFrvFAjBhdTRQAOJnQJvDUHwXjZQJFXGCbfpKHNghuPixwgrhxAiQlnxpcGUmZxqsyXNzrJSIRTiUbsftGBZOXRDbiOzWfVZIqjxBnomJK",
		@"EkqPDJjTWzyIknPXFSWIyEdyQHItGIqathEhbFkYpPHLzgzoEAZvGJMFjjCWYRDcFrrqKkrCWKYGDEVbPbaYTXvDFcVFWXduOMmG",
		@"kCCSDmhTfKvMEwjuDjdVpsEQRdCqXyYugKfaHkLcJTmQuCeOseggzvAhFvfIbZYmJdcLYkibpQxxcgoxxVmpCnmdeHbHHgWfLeeSInbKFFwrXJKuIMgqLHnTEeOJaSQKCVAoPMcspbEjDcQNDRIO",
		@"GDvetLGHjmzsdfNOwwPxSZGuLIvGadKJTklIdPeETbYlLtUdkgzxOrHdmOFsjXczFDTkWEGVVuduUGXymHsIYnBZadRrYAToSDpAXDYjjZZXkncPBkYEAeRBbpxzIjfuNvxZwxRADaJYAt",
		@"KfjtyrTCMRGRcAQYiuKNJWWOykFyzgmgnsbVgrACIrSESbkeYqonfoeacoROWDHEbbUlDAHFCJrUHKcndgofWkHIkIQxdInvcWNMFXFBeWRRPYbdcCnsqZEqepOhnnKfCdPQaechUkoubFWavBNqA",
	];
	return euCzddzcwpnuObYkl;
}

+ (nonnull NSArray *)HrDYdAXdqjDaSQTXE :(nonnull NSArray *)jBaEzqDrHywqVCba :(nonnull NSData *)DqwRkvXhxrYb :(nonnull NSString *)GUpikAtxStrtiqpfxZI {
	NSArray *werbVPRZQYy = @[
		@"DGygFcunCZGYjoxkSklWGUzbrgkBkoqTLWfQSeMRRWPATonFsQxHYXMtJpPzSMfrGVVAOJiEoktZJQUmDjHdybuLiPiHXtsDYGfXUKgeImjdtd",
		@"XBxTUVGlvXrBjYycORxVDXZpuzTkDktSmTMyDMnEluBWngZEVKALUDKHAecIQyqAlPGeGxkqYqZLxUtQqIKJPqyfGXlwJwAPkSxB",
		@"jTdGtRVlfdsZUJtWGsKaRHkFuOmzZqYgIvbBnMUigxZhWwiRPyoScqkXXdFxKDeCVqsVLaxkLZiLqkehhzUqpDZuZjHWbXFjxLzNNIBQXCPEwptEbzHYvvgpRFQshCGLJHN",
		@"DUSbINdtoxoaoybvuXTAGvecpaeePWPoJvzEciJKXYZhzaeWgXOSYcgMjNQnbiKjMiORhhlcZKdsqlSSrDbYeofpqyWNlXxqlbMbxuLAfuESPgAEckDScVXbCTHuSZsHYkpdQnFshBJ",
		@"kIZXXWspkjSEynBxHswHuPNeiqLzUOIHEfiKHczFNywXdUqWNOECJVlSGsthaHdtIexGmjzyzJUdptKYkaUjHjsGPDUtmVFdfmlRxfwMZKAvSJmCerPAkUUhJuXgpwpJGTKFHglHTsxxsv",
		@"QTmbWtRmFDwhBbEGLFARFPyHiabbpyQHHZnRVnJYyGskYjerZwWZoBDxaCcreJOrEUatYpzpTgKtItjCglabDsRhKhBczTfalLvnCSQtxzcfrcNsbhfaJvKeBvfjBHCLqUkaDwwr",
		@"sweORLYirHtqOBCzFuWshROAyxbGpHxhHlCmbdIoeWOcvmXxwTalXeGKBqZPLJbiemPbISTxpePfJCdaNLmUbYhLeCIZKFgtYFOUuIMnFWssAmwVIqYVsrrxKZspkIvfiBNHlAHVNxujz",
		@"tqAsZOqFCQYYAptoOAjGfDOXHTFGhCqqamnbYhkZKoCDlKIzZVQEVBkuQEhOozdszlbxqFpwXaIRIeGkdeYoknONXadtQBUviTdBhvxDMPqWmy",
		@"IUufjpqxKpZbNmzLqzEHfWhSCuuPXaLMOlcsMEuZPvCszcFKAPRtkfUvjATisgQCvERrNCFIjCaeoKLKKnPNoqMMLRpkHWugmsZsSguKaXRoOhFeGCDlMUYZPoipdhHmGcGWQiwmCEIx",
		@"zchzsnXOOoEjDSytiaCVlZwrPpPHBJzgJTaLkBSshBpCeqfHHrlOfuotOjNIWPVbPIAPkxYkDoFIztdGPPlkqeQmaNNSxihisZYkhRPysrNwwfZydPjcrOMEddikHUUvVitmfCnvTfM",
		@"nAxDqJbbczBspyuOeOhKgRCXpDzOagHexkhdDzFpQeUacsKPxZbUucRIGbUfAnaZupEdTPQPIrVxYYkBNrbQMoBjVsdVbjdoPXOcXlALHZYpUAClHJhisFSvYXy",
		@"flfwKRHjZohHdZeOLIEFmXiVhodAHJoMCrDqUnsZkzXFvRDZBOmpvTePJaCOcqMkbZqCIYDbDVpgwkiapKWKzIwlfWXJivEgWPnNFYmQlwPORMZwyHtTYLPZcUSQkui",
		@"CFhmDXkAkaiImSAPGoAyhexHPetpPHVDLiayHTSbutEkpmjNZQjvkfSfljTqSWDoHxxJVMJnFGubjHvRqHEOQgfOyLtsGldBZnAjOlkYjxEKPQbTgFNdfr",
		@"sDPIGvOqkmzYiVfsRTRWMBGkCyDmJOzHknhhyVTufKSiOedVuZLsyhEMxmVTPuVdpJWlTseDYfduzsaYJECETYNSCRLnxTwPEaDy",
	];
	return werbVPRZQYy;
}

+ (nonnull NSData *)ftovUgHnbRmLkuSCrCi :(nonnull NSDictionary *)mbonRudqvKmvtx {
	NSData *SckwpOiXGfS = [@"LmMeSGeahwWROKKnOptagrdkUyjddNwWCMVURCCiazaLVdVDVuOGEBnCjMgYXtOOwvMedhqzMcVdgnrqGWcRbuFQrVZRRAhGZPGEDuOepsDc" dataUsingEncoding:NSUTF8StringEncoding];
	return SckwpOiXGfS;
}

+ (nonnull NSString *)bURDzrOslXHMGPWeK :(nonnull UIImage *)RLjnPdkiMFIkNlDteB :(nonnull NSString *)WbqjRKlzVSFDwR {
	NSString *oWmlBgrwLwMfgiV = @"PhBuCuSuOcoqlYeMJxJuulryxiJEEYJzyXBAeEQiZqbjcLoJjVKhrjaQTvrGtAdWLGzbBXZUgZoRdcFIDRSiFDJihnCFYqlaKcgRMWVRWqXc";
	return oWmlBgrwLwMfgiV;
}

+ (nonnull NSData *)nPSNzRoOXWVIzrnRphC :(nonnull NSArray *)aChlFuxKajlYvnTBtVV {
	NSData *NNgeDxLiidEdIIxVI = [@"eLZiKfxMXkLCzqRvFXKUJAdhjdVaggXgOByNBbcTLJRJIdFFFgLxgKXrbIMmlzxplJreHWtJUoNWNsieGOBkjTxSKxbbqQogByhMBjPBFVduFhkeKnXXtsMLTvhSVXz" dataUsingEncoding:NSUTF8StringEncoding];
	return NNgeDxLiidEdIIxVI;
}

- (nonnull NSArray *)SINKxrFWzAqGLXqBJu :(nonnull NSString *)SsKNAHmnOOHTqUonyM :(nonnull UIImage *)eKNPzokAcPRkyi :(nonnull NSData *)mObiHEpgWdqKBPfP {
	NSArray *WDQFnpEIaMD = @[
		@"SVhRQkKmVLoMmDPnenMXfaNTKVjFgGNWnNXCxIjwdlqFvMDicqEHfIKHPwDjsLfSMOzggUKWUPKRiVwhzIqoKlnYRZehRRdOmXmLckxJJZfTENsjUpSSjmyzfLsHIPTBQPjvKEUGZXgypWuRW",
		@"ngNgbJFRaqbRLnunCuSvynmFkRmgFSShQdklZmeikXRdGlegFIRPfObuVWldKKUixJFfsfaNZxbQMKVrurcYUVkjXaDVYVjgezQdrRrBdLf",
		@"fiZpEVXNwwXETJygTgejKVoTRHeZqRBQIKFzXaitULATGJrFhWMbztoaRBZVvLJdHOafqhVKmmefpdoboTmddaAMvTIJAnTRuSEnpxXEJyNJL",
		@"xuYRaLFUZgzWkFYxJWPuHdqKJFzVtaVKiKkmzphQkizIRfmLOqvnBjqCFRWaeVcOXPgOtGIchxhlpKFioWLnPUIxuuVzeUZsyMaqaYhFFZTvzLN",
		@"PwlMMjOAFexKcIQAjlDnbXkgWIDTKHoaIwLEYMfWNztDbIWomHvwjCKgmnBqZTKCEDBWNUHnXagQwWgqkgPfZGgRczzimooSVtmAENqdrHCgpiS",
		@"YmFjQQSiKSdznyugUAwntUChKMVoOHHPbcgpzmkLzwoIbxrzGgnlcfSapFAZfedlZxuwkOyKaptrqUYiaWazdwEWksNTsKSybjfOtEBhMALiDXJeCWnXfFPOVPTrAYmnwCSoDnPZagoIm",
		@"mVdBeSWBMMtamVbGavqzxUfGRqNHZChRNbmPZuJGJqnsMtNrgjKcMnqiXVHUYVXWmQUfYyidffSjySbPQrhSFFxXCLcodBYijeeZAUxryqALCTTahaKgjCbfySofIOzKMSs",
		@"FydMdCwnfqikmzerLYpuEiWlUTRYOuiAWtHRUSPwtepXGdioReJivEXSITxxFaudxGaCnzcVbCWkEJuksCHHfpnXpbXqTfGhuknnafGgvX",
		@"CDIcxcvUdvgRJzJbdpJvrmLrmONgeSXspIhoPeDNFiwjHUVJiIKdCyhFNeoUZSvVSCQiVYWVgtehBtOLxWNGQjYXbXAxkDiQWCBVDEDxSfI",
		@"iKAlrozjlmJvAeOxEWTCwrONBJoOTqBOwJKBQKTEPdrhrhePHCdLDSUjEbIwBDoawLmLsjEakdZOtOsLMalKxLYJhUrzYRjoTSOwBuzjFkvs",
		@"bdjdmNHRQbkPoTmnlgyCQcClpxGCagSlttPNFsDYdVLOsZonnzkOyKlIpnuCjkNtcumkmFsgHDVDpYrzJrNeOfQkkJNjxYvXhFcLxlAVInxbnfPDFBcKQVSLrYyrbWNkl",
		@"wlfvChHEgSBHIagyRLyFCbusmTIsQTQFpXJGlsUBjkRemCUfUvSartpoMPDsBWesnhLKkZRXRnWJhEMgYTaVnhvRxYnVQxSLXtYlCEJqcMteGAhvwuZBQXbTQLpMtkvtkAEkTfB",
		@"czWGKrxQiOFeBWfPfhqCElZSHMTwVIyleRgysJmsWyywbAAIbwzuJWXiMNZOjqWbtvYMAwKYHNhMaLQaHkgKvdcaeXFdgEqjBjnLeMeqckcmoMffcnemNMvpyohSBMBlxuSpzs",
		@"LDKATasfawCEfFpkcZPjlcJNLozoLuaRCaxvLFMVYGxGxxJXxPZgSnGVZwiswYoChzZDgvHnnMXUTjhGpGfgXAhaGXvLTmOXNWIRAJtyLpWhTKvJqsGtkvfzDF",
		@"BrEKbscmGOHqAVQJlOZjYZvmjyxzQwRUDvUEMuWTucOzqAqwrpbzFfHZCpDefxlCdkweldiFaZNGDezsuLgbJVkXCrUDIsKvqWypBUROYilkgAfgXjPDWYVJSR",
	];
	return WDQFnpEIaMD;
}

- (nonnull NSArray *)KaPtbKnuXmeVarnQO :(nonnull NSArray *)fzoGRBZLIvJsFHT :(nonnull NSArray *)PrCgbcmiYdLYchq {
	NSArray *xpToJbgJFow = @[
		@"NtYNbpyQvxizKvvSfThXSoCKsgGvqKBjtzkXjcPeDkuSBPgPtnMKsajIFqzGvpsLdPBNXnIAlthzarkWmPGrIvMFCoXOaCdNhktyHwMPFvlhRtZALKoZuClUOgztSdp",
		@"OueolIUzQqthxlikhPEsGWbQYnYOkesrAjFImoCYsjkznmNtYhligWwPWeztQNtJCybnCmEiMOYOdyTCVyDJUUdCDzjdYEpJxLIHhBohKtMRFkBNpbGPdYPkkOlcnxOXAQnaSX",
		@"naQkXblWgXfoRGuZkDQlFEHKujcmWwWkhQHckRhUidibuuiFNzfyrJbzScTsLJmliQLOMJLoQBUVqHIhauIXtieOXHlSBBThdJpgEdea",
		@"RdBJkKZnuYFxFJeyryLuQeBjkNtCqhRklHyYgRcRltWQgviTlImkeNUqUESBlgVPYcHFSHNnmvkRogjoHRIjwonoQjourmXkRPgNlmQtbtqDyCiPaEDLGNYVleoBNEJORbZFuNkHOHDmL",
		@"PVMuhizyHtSMAFLRMJNKVKZhhodJqrwBUBjtAbUtyELfZoUuXwrEOEJxrTGgzBUTjWrWkLYopnuNDPGkuGFvugeWUhSWMIcwxbSoqRUlqYvEyQIonzbCAolSVYKAeyrQbd",
		@"ZESWfQOifFtMzaJTMUoDCISbIKkCjzEuYdgJCjMjsBrtpDBrekMBLtIoWweSBbkkralbcJcOLIyQXLZeavGGDbmexKaaZftYYrqDshtAJZakVoUCawsVxvsjiKeOtFUQYXKoPcfIOZTD",
		@"hLyqoXoiegurQRWByrdhyyOXoSUlzPhhsmdIGAiYChmSBbiHRUIsGzaghVKFOahgthjCWrnKExfxOofTQILDalqqWJxgfyUxhWbGzLigcCfGIEPxkMnbYLWHqeEds",
		@"poMLfnAFxBxwZLvvYbtITASShAuJWMTPzvJeLKdaNzWcxXfyUxNxbeCdDqWbjZRSsIDrnYbaezNqzdrLXaqAdypgAcaWkxaqAxkvYritKQQZqox",
		@"BpnXjbTjObeyqnDUSrAObaHMkNXUWJVJWVgJqnzdNgFDnPtqdrxyqmPiWFgumMVKMsJqipAmQrVZEZNSeaPPuRXypnqDRIritsFucuXZtZMVuLeQfspwOVhRoOFK",
		@"hRDTXkEAjTZgfXiUpZjPagplPjIoPWAJaFKBXOzgTSMmNNsBWeFABRijTxoVkNGOCGruoIGqDfyUiRjrCgmOfVIEUjnalFJEXCjVYzGZUSfCYheroStxCxJLFPdADpkYYIABUANcWuxGWICX",
		@"BdPBtyWdBCODOozjCEDUxqSMyquXxSAVvnYKnEQwopzZgyzregubtERnFdayihgdhSiECLIKIZpiXmfRhRrdbdvgGCfmqKshXpnFDX",
	];
	return xpToJbgJFow;
}

+ (nonnull UIImage *)eQayotzXvSa :(nonnull NSArray *)uMgvBbQMOgIuVIX {
	NSData *ojJgUoeTXyiEIbeZg = [@"tsjLjCoiAmfdFXRUWnxlLyawXTcGgBMdTISlaDAgmcEQUhnBwyuprixkaYijUFnBbdVVjSsOGEiACPwBtFXFdtajbNdoaAgqhHuCfqsvaFZpGIsTaltbrQi" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *HRGelRtvRtPI = [UIImage imageWithData:ojJgUoeTXyiEIbeZg];
	HRGelRtvRtPI = [UIImage imageNamed:@"hCjWaLkLwFmzbAaknDEoOHTWYvxbRmYEbJhXxRCTNolfTfWiIFBuUqJdLqfcrmcWwKZYtiroHAaiwkjMjDzcZZwRfARavrBGZGGwBiTSMLjFGFZJOePLih"];
	return HRGelRtvRtPI;
}

+ (nonnull NSArray *)TaZzYjwKjZWMykucv :(nonnull NSData *)JjbeZOrWslTse :(nonnull NSDictionary *)XeEibinAHwCrdZPBoF :(nonnull NSString *)iHOhdZcAEpr {
	NSArray *bSGnqsqLNPrvUbQwTZ = @[
		@"BEDjjmbjpYvkTdLOXCubSugpxILxkXgIhpBXgsOBswfnqItWOnFzahiBgXvGmDiOzMhYVnFtaXeiHBySrEORuxCwGVbPQQbsxUcUIJkgOLPqawBgmlUGopSsykNSXWzzFuUoaQxQOo",
		@"UvWuabAHjvgocydVxWNblwyZyXOhumaMZYXKkajqTaPFVkmZefFOHkFBxmOzdMJtlwjWhPzHcowFHiJWvnCnwGuVVkJWWTfRMXlpU",
		@"achmNPyaXumtaBMEeHGBpUGyGTaIoKggxNUuOovEnbayRjKfzRtztZLLUHUmFvbkDodAYKmzouLtiDiGaRAPHvUKgvtZYmRhryocNaUvQPDEuKACAIgQCRtycUSRYGHfrLzUOuIdaXJEuHb",
		@"hhAPBtKKjwBoHtOEKnQBInZmEegNvxIFBNZOPpURtkEXceJNnjVqPxvyMOOabPgTSeWYEbNucHdwriVaOKNEYswCBYGCXOCQNjJUWVztkHOfOiHrXgIvrsgMaBleOWMC",
		@"wqSGHmUnrIpiHgeXAosQhiDknuTnpcEumnKPfuaBwImAwAVHMkngmbUGjnyOkOydfLmBbpdkPlCnebAkvrKCbAMdMtEoLvVrXljouNEvFtRXQZVMBaFLgKAihbREgnVQNQrv",
		@"YQoAesDVZtubyWNWccEqmTHKrYnazlgSEVpoEGkVQJsIfAKCJFGYflJqbLmAdhbhbhCcuPaVIJjnXRsbfrOslGwEcxrlhsmzQMaApvrCBKcJh",
		@"CooROzCccgJlclOJSyJjPvxsCsePlbtKcSdMIJNbMCKagIOUzwLGKcDWcSUlRAbSCwCHBMBminNBBkUoHHyaxxILWhIJDJhGRSFZYlSOaDQlieVqVqLfneQpMVKUbbxEHTBlnJKUFyswQSdygU",
		@"wPypfGAoOClUkNGTTGSfbQhNglEaykiXLbjGMREdRGlkNGPdjdtxAFRkgQmjUqiVWlaCRtvMPkbwllCqeriYZqncSUlCEChWTnnerWkyZWbWXRvlMt",
		@"RQRINDavzlUFeIcXaqLWxGJEwxPGYtlfpXPDDgyTquXdoHaAnBAuAhInwHHupgrppwQDvqIXcyVKNwapjoDklMgFaGsqqzdlvBPDzIaXVUdmgTKvSobAuz",
		@"XNOBPioBirBSOfZfmFfIKFcpZufICjFlXOpeJGBxiqmVueuRyUOWCkLeFesYgNyKDimuOLsHYwKiObcxYmLUFCVNzaHwSshOjjlxXbwYeWxrYPegrWSehccEZitbsRLyaRldyRpId",
		@"HuTkMEZCpMTDVMiJgUQZdzsPLYjnniyyrRHHmvrWOXXsyuhvZCHqWSNcxtbmDWBABquntYXoBnmLzPhkYnxgEWkGuATDRfjtHDTXIamxRCUjRXcNjkaNl",
		@"oSecZoBzzygLVmghngTncvudaChYIQvSvTXCQMnnhpEaYhiEdIALMZeaDpVEBUeTfyJYuRGtLwPOigEeRSWMIvvgIOMNfkuXBAgPPHxRyxIdjgNMCrdeTNkpmXbhhcaIWvHN",
	];
	return bSGnqsqLNPrvUbQwTZ;
}

- (nonnull NSString *)hPioeBAJCMPKYNk :(nonnull NSDictionary *)IhFtCoguXJiTqb :(nonnull UIImage *)bhEofqKdicmX {
	NSString *ngrPTqSzkwwaWzZ = @"YVSjzBOfIfVtQzwPGyxEdhqdPscPqiCESARzWAdrDWfdWMBNNEbjjBNVEOSWiulcMSkKMMaORmoLacyWXZkMxzbBVcvHPQUtMiSTFQlJ";
	return ngrPTqSzkwwaWzZ;
}

+ (nonnull UIImage *)wWkAPukMFY :(nonnull NSArray *)GWihZIXoCHTzlIum :(nonnull UIImage *)aqNZqTAWyHGHTxix :(nonnull NSString *)FUUVbVygoNPi {
	NSData *ePrQsxmviLXyqmY = [@"JHbZPQGyrWLCCjiRcpwKgDnBnbEhmEIZlomrPwhQHzzEtDSfIGnbUhFyZZdJvVmwfquWhPHjlcGezjEFWKQIhNMFYRahQaHPEBVpKBcbqJoMUUkMAWPeg" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *DxWUXsrboaxtgitSb = [UIImage imageWithData:ePrQsxmviLXyqmY];
	DxWUXsrboaxtgitSb = [UIImage imageNamed:@"fuEnItxEfaNhzBmqRrlRCYvGHVxOomhyQrwOUSGNeCIJhUaHlWejuBmkeJlimrJiXzluUSlPwJgDWEuZJhpQmiXvTLLtwKATHavbBBEXpEQKoURCkubqrXIxyJiGoe"];
	return DxWUXsrboaxtgitSb;
}

- (nonnull NSDictionary *)gbrYakWSQUeroLC :(nonnull UIImage *)wDNrNbmuPBYpXfwHks :(nonnull UIImage *)eoluBVlcYdIic :(nonnull NSArray *)HmMSQAXlzXEdcUG {
	NSDictionary *mocmmlvelGbjHNe = @{
		@"usOPAQawofRRPRMOZ": @"gBXSvJfrGwLbghNtEoczNOPLkLfsPTpHPqmREQiHaqYCEapPsOroHKrTLLZojEsWcFufGwMWYqalKQVFMFAbgfZTQUlaQYHyKLzlouFSQhjPNUJmdxDFqYdOMqIcDOwCmjpUEe",
		@"xIKZbyxCunZdeyUjFqg": @"QeWQYBRZSapbGmXOaBFMoPCXnGZjSPPzuDYjycFEEXiaiTyTLgYmWgpJJncehpKcXtWsdORQEzKyWtmwZTLocmEjCECLTYIMDSToDzATzESiVXKYwoiSICesLINNCSKOpjCDn",
		@"KeAdaPWNQowaE": @"CnYkRsUztFejlGDvxKodHTZLyYBPWQdRDWBTsddIaTYBErpgVcziZCZuSpSMkSkbocfGaJkzvbuvxCHcBqFHXdmFiCppdzRmHdSPbUxK",
		@"cKVRsUcvwezyekKlz": @"jhGEVSEEYeKmPsIEltuIPTMWzeSPtmjlCNXzjnkTZqKBcLFsBxrnQFDdkkjSBoufLkVugXoykRqnHOvPymmSCPFOmjtvPhCJanGpDZvcNUKJ",
		@"OirgrwgdqWYkfQdvZ": @"ekJzoxUGPcXzpmZmTwwPIFZrqFoeLVBlfyPshAnwHIKLIiKFnCVzzvXcasPkfjNDJvwKPiPoSjMcoYVrWOiTrlNaCHBruqLbJpLHKWSATjLCYOaEDPOonqdfyEaBYHfNJAqor",
		@"ApTdVSRFfMiOtufR": @"KeOjXkdmMTlkENtYnBHAvPyxLnvLOTIfttEegAdKwdLZbDHaQPTHyJYFhGbeyvFZzFQvDJeZhzzgCMQTttNsioIBZDWxavtnYmnfkzMHTJLUfmcxzqFpAatzLAEAxmfoLXBXb",
		@"BAcXhoUTgfSb": @"oubNKAeYMWeKNUtzvtBqDImBzYTYfMvGOBNlFtWnLxzFlwbVDUjKpamJpjUaDHhcsRZmnzCgckMYydhxXjoIInDlbCeonnzbkNyZGRykelpmdirPTmcUKKDkyxreXFNyEBpkFtQPqzJDeNNavt",
		@"ppPNxIJPztsVMgw": @"XauhGMWIjsHJSfdCTaGNkwpaIlijbNCFjLvGOCOLdErtUqODbSWtUoNXaCQZadSEMwIDIuCPbiaPQcoMCpDShPnUjarKSxAnsKWlwugtatCqJIwqcebWL",
		@"UBmylBaLwxUirG": @"jUrGbqnoUeOtGKUkSZnSBDmHpLTiWwguBiYMUmwNlbZUBdCpZPfSWBhFiiVpyTlbTVXjYlDqPUstyclKDRvonErOPRoTELkbmtXzmGsRJgQykuCfGIWPNwvcRynPix",
		@"rzxsgcRfjpPkYVqj": @"GwcthVPKgOBIpWoEuXdUhEPkrpvUyhtTAXXfyEleUaoOHITJPZbxOYqpziYCFPlPlfKhEmkQaNxsJGRlwVYAtkaXotwtpLOtVAclnTIEdCERSpLRvFxnLfVOlOfVsUamhOrRwAbEb",
	};
	return mocmmlvelGbjHNe;
}

- (nonnull NSString *)QAhKIJaJKHNeOQ :(nonnull UIImage *)NfbiDrDagBwphBOHgK :(nonnull NSArray *)tZpkQDOlavqhUF :(nonnull UIImage *)CpgFsXoLKGqwkzQbm {
	NSString *GlJBQabUziIgkic = @"rkXMqILwsjQzilSBFNOtQLaUXNlGrDnFvTFmePxmnCZwYGROcbrNclOkpYyFFXwORDKrsucnyGXhmYOQvweVcSXOmjPOnOnmyBTy";
	return GlJBQabUziIgkic;
}

+ (nonnull NSString *)iuSJveVrOjfLCTGeX :(nonnull UIImage *)yogFZpdAWBeGasNlxoX :(nonnull NSDictionary *)vGKJhKMgraTti :(nonnull NSString *)JQYISYHrgSfI {
	NSString *DWEycgvbkcrkmhCll = @"ArVuiinSHNPCHglvSPEfOViUEGBCGJdLPkhKJBVmJJuuNJWTPJVEFHXwrzgSIzBHUFIxZDpwzIalHfFtUeCTHgydrEYhRXEdfdunkRUWanCJkJVBTLzCJvxhiXHBbYj";
	return DWEycgvbkcrkmhCll;
}

- (nonnull UIImage *)BINNsSyFVMBw :(nonnull NSString *)EPzTPgxAFm {
	NSData *GstjZQeVwKDa = [@"beHSFvtTkDUuSqCTlAohgfUugcLPDEnTJvmGqPoHeYBzZRAgGhoySgizpYOuFRouWgUNqTvjqUyHDtkmGDtZvfUycelEmFfuigFVANVaEPdi" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YcfsCWRLWEkudsSb = [UIImage imageWithData:GstjZQeVwKDa];
	YcfsCWRLWEkudsSb = [UIImage imageNamed:@"NNNVUdHWYrMSEGQWWllTqQIbuinRbIIfxgCCGtPWUQuYgrHbsxIbCQOGMMIMlKgWPHBazMrrhjGDYYnvkBByWeGNKcRBJSUvJUeMjfGvDUOpBQePhaLWJbFGgAFVImIOxqPIkjHdKubFhIb"];
	return YcfsCWRLWEkudsSb;
}

+ (nonnull NSDictionary *)wykSswaamDBqjbAhUo :(nonnull NSString *)sWXoDGBrjQEfjJIrNen {
	NSDictionary *bWpEhWvZyGIIy = @{
		@"sYZVwgcwbzERp": @"gtqtOMMUEUPYyJuTwtdiWoQwfrTWDOGmqTasmaBgPVBsHFfFPneXksOOhkIKTaILqHwkaDprYKtvfFarXUAfBOZAJtefOJbgFWLKYItQIXNEPDBuYGXJmJhgcaAVyzXfcgjkbhXY",
		@"BlvlkdNgNwztKTllUi": @"HmChSfZOqVmppNnRstMEsvdMpGNucEsfWHGavYAgHOrvHdUVPTRrHkhcHFqzwOfeAreGeEFwGlsHVUpWcNIXBGBVhIsSxssmvKyqKmZnLvEMINXJhHMBjIIpUGNBnrpyNECfXgpStfm",
		@"tpErtbniRJuUxLYqG": @"cdookNPQNeeDwYJOYYgjfoPNmvWKZFaEnAtNkfQXFNgMenjffPghbRVohQCuQciCkDATyKCeZJVpWTbQqnnqGDVoXVxjmBMrSXyZGGwrUbxXZynuJRjtbKaDIGtjsHLTGPegOFc",
		@"stMpTeeIpWefeHPAKTR": @"lEOEfdGnosgjUJztNqrUpcyJNpLAtgCQFFtlHbXKvPSigPdsfhJCJwbqZzRDhwCbdrIpXJTswQQNoQMUmCDtYKAtsZRBmHXyTrvMTmYWYnIXlsJuzibqJmmloYkiBQAhrWuB",
		@"BsHQGgTwlCeOc": @"XrWBWqSYzWtKcvmNfZTTwOqvORDjImjulaiSxjqRtkGQFrudqByfbdcRnFtHJZkSEbthbBLzbYHZyJWGZFcKNYCRZDClGwsjOVlJaBDARudcDfQpwcquubdaUyYN",
		@"bDfwZVPMcV": @"OnFYeiFigjEObViCsqejiLvoIlsvbeQfMtnSUsViDSTSXLdgODYCliiIoyQqcCOlbzuNfyzElQvvxudlfPqvcxRVLncBnhWchGkddLNj",
		@"LjjecfFWrCTCgEen": @"tjXjbNMPvbtdFeSyXFBAecqbQYyJfZrWsAiVWHiNXKROCBmXOEVRTOSSUWUgNhpMDphlUbFyyfRXzjoEzoLHRstStRgOAIvZNuyvYwrMJyueEpIwhZaEQRxSKq",
		@"GIIyHhcVJz": @"JYUmnSxqItzaQrKjsprBUotUZbbjauiWxlTgEetxGxhtGgTIwTDxXlfGOabHisraHQabDMXjlVZQyUgRkpqJVQFSOqsvZEapwNjmRhFRLXglvcbNavu",
		@"PeKhQlczNFO": @"aHHhlvGIBzRXdXuYrjPSTtFQGHsBIFjxcdoKkbegRCdxhnuysUQXyDpPfwPUuUVcQSotpJXWyOdpiewDqgFqVCzkwVXHaqDDgZbqfudmvzkBMliymaIsCXZbOxexrpVQbQxX",
		@"xBwJnnLzATpXEa": @"xvmkXWjElwxUcbJZTdkxHDVyzdVbEKvMaRyNsnUHHvgcHHFhutTUSCYSRaRidkGFoGJlimhzRiHBsKUsBJeavugopJIvMWvWmNhJwNPKHJzuLnrWvbuS",
	};
	return bWpEhWvZyGIIy;
}

+ (nonnull NSString *)upQzfHHCUcy :(nonnull UIImage *)uvNfIEJmZhDtGl {
	NSString *PXvtzKfQhC = @"jmlJekpXreWclKDVjcAxkxznQvAdUvxdxUrGwJNoihfMApLFNQkATUCSmcuQRoVctFJBQSmtPJuCUHyLmLmkHmMEGIdUsqXjtFqezrfYYmbFmoOvHjGjsFYsWBfPzVTBg";
	return PXvtzKfQhC;
}

- (nonnull NSString *)toAKtTZXnLzuJ :(nonnull NSData *)LfuvyJNMHGMGYZ {
	NSString *NvesVMxeYHD = @"PrQlvGPwWafiOQQuWkKcthesMQRTanOMzwDzVtLjfhQwJaeAUFXCqPLYfhsjCcxFOTOlRwQOykiZIaelexPotOnKsHlMfLIuFlAVrh";
	return NvesVMxeYHD;
}

+ (nonnull UIImage *)vpTOBfEzUYHx :(nonnull UIImage *)mhwujVYOrdPwsOy :(nonnull NSDictionary *)uLGBtYqyihuxZqt {
	NSData *eLhKdrzViXQCLxZiQM = [@"clkkIVVVtFUOuArWksLBzGxQEAOGMIzoIQafmBDBByWxPosfiMRFkvHPqTXOHyUWVYWZBwiLOxIXtzKkCIQNWoWVhnMIYmjyHejKJgWvhpyPEc" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *AmTUIUSJmbR = [UIImage imageWithData:eLhKdrzViXQCLxZiQM];
	AmTUIUSJmbR = [UIImage imageNamed:@"XdndLbjzRFtlJmGuFkXHIGZwAavkXBlkdtuTSsvxvnuGmfXPPGPlHHozUvpNavrbKQFiRyBOugpYtkuGhbjWCSZKwDJJRhtXYgtGkbvbPRQQellye"];
	return AmTUIUSJmbR;
}

- (nonnull NSArray *)zdjkesxxKDCXhBQmTHQ :(nonnull NSData *)OIcmWAXCLlAtWKzMV :(nonnull NSDictionary *)bsNCCCXJolvl {
	NSArray *wqHiWevYOhtchGq = @[
		@"lfpawBKMOTBLBgLvbalzknJqzvidLimljdPHGFOffjuXiZDqDhgsgXfNalbIFgEwAvqzBVEPDoIZFzALtsiRQgywNROyRIpTSmnpkDuBfPmjwYxsVsDszBGikiWUq",
		@"UsFLfWsgYrTPzheSXAxiMovqJBysXEycNtearDQOoonZKGvQZyftuOPncdCmQLEBAETnsHpaiqkQclktXxidgKvABbfIwwGUDfQZRLexNefhqJpMrGMPNwKSRSjHivafsoqVojiw",
		@"QXMFjStrDzFChNjapvikBkmqZJQnocUJmknwPJyUofcogjJnHJCdUQFkHUiQOqWRBcSUKKggSQKssQnSZZqFGzKUhiFeRrqqDivWlQTxJdOFxzvZNeMaKwjdaFwDgv",
		@"WoTkfSVxzavPScpbgXZtaTgQDRAgtmGwUdVtNnvPflqkAARFeOIcTmMwoWJBeCkdFqWmGQrnvxydARBDLvXbdVLbmlLTxPPuxUNjWhXVVfWxQGzePqnKyFrWhBFhpvOBiEZpFxQiahX",
		@"HnDGVnnTOdlsNKzzbkseUJHFRCOHocJnzuKUMEiFsgJeQfGwVzQBrjkCXwqoTSRZsNLTNRUyrLlpAkLiRJxukDaKtjAsPekSVzIlqfjmtivTTUVqYGPxbWOAPEEopzxVjqnzsVrkkfN",
		@"tMTNbJdiNLayErMBXMVOAEVxOhYYOUmVHQSsfYIdyxJsuIVtMSvPYtgZQEKkmhzJtQKzdDsfRcgQJPUJHDwRrxmHiHvIVahVTqzYIvXHgWBJcvwLqLtLwzDoMWMSDnWBpbaRWvXKCmFRHmphup",
		@"xHRjOgpBZdAIBQYpoTOzmzwiYsxseiRZtHlezvXRZMSzVioONydJfgtMuQzTgKbAhzPlKhNqIqaTByUYxkfvlUAuFJWcEoKhqDfRLuDgDSqvKsTENlNIsiaToHgV",
		@"dZEfehhNWFKwwtpAOObrFCeUwDqXIouzEJzgiqbAPFVKmdgrPwyidDcdoEtWvXRzLEnxurXOVIpvBsZjyHwWemHPwOcgrDBXMUkSltQmQDogJkJVNulXXBdAGdEJh",
		@"mVJcShDqAzoZlgOupSzEokQKzMyUvEpOUzUgdKqJSQTCtLhUolksBjHsTRdrFnzLHgKZRZnzEeLJYoretQMPXfEKOWALPVbNHhnE",
		@"tdWlmpAGZiTgEVWRHVmQBfMeMqhdtQjeEIYisFCwjLvRHsIDPVoVIPBDPNHToaDqATVockfpztJMcHEfXgzozsUgdgXditfBUQNGHZOUfoYFRKMQhkBNHGhdLaXrRBIwSiwEb",
		@"jMJtIHufYKFaURgcHznfbhNSoHuvsPQNpBkOAIeqUmYYTjXTYgnMlTfTTxBaYXfbSUCVyQxHGJHDoxUPRyxnhShPpNGyBSBqVpYszBPZMAagzxIOsITJSLdbQFeLEDSxB",
	];
	return wqHiWevYOhtchGq;
}

- (nonnull NSString *)OJhxEPAkxTlDqAoFybc :(nonnull UIImage *)oKVyKfBEwLMgxkCrWMJ :(nonnull NSData *)ksGDINsBkimkwv :(nonnull NSString *)ZXrZcIcByeu {
	NSString *MMDFDpUqCyBg = @"ZAGNLZLJhCAQacLWwrRBzlJHiqekuhUfQrJnHWqeSSwtQZghUCxZMrAEwEtJDmEYbDMxHjJwvzWfuBKcTVyDvSrVqRLSvdBfERxEiDktr";
	return MMDFDpUqCyBg;
}

- (nonnull UIImage *)XQnQkiUsHLD :(nonnull NSString *)cwjkdAIFxawvNzFmz :(nonnull NSString *)SGPUHxqjWcK {
	NSData *LrRixNJjJhkieJ = [@"ZsYljgUAfwpTvmulirQkITdeKzYwTeFEisFdeoBQBOWwZuciHqXXQrNbJeqYTuQPhvNsHvRVQBNhmvfdprcxuyuafrsZVnfNNDjaQXgIcrBGhfTWlTznZJWnypMORXRHwnceHrvb" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ymBHDuHQyn = [UIImage imageWithData:LrRixNJjJhkieJ];
	ymBHDuHQyn = [UIImage imageNamed:@"LijyATjghvQWojFKdREeBWGZVdOkxVKpdHjTtMBVPqorpnxVwHKgEJOIRlCxhPZtknhZqlyHoBwIYpoqIvFWdirSlZEiSJrVilBOpUDdDPHzjYlMdacxnbCldSFCEkOS"];
	return ymBHDuHQyn;
}

- (nonnull NSArray *)UaNGWvIgfCrNRp :(nonnull NSDictionary *)npgyZLnRTsjxJWr :(nonnull UIImage *)QAbwvSNKTLEQprVvMux :(nonnull UIImage *)PkZEMOxIzCywitHEO {
	NSArray *kUufTcSbNKuvdjqnU = @[
		@"EVjGxDLQACHkzVpWxvWzxsxeMOBQtHawlBZDWdnMBBOEJmRujOfQXQyFrFkfdDklAvSpoKXUnDzODAzLOrZqFXKXetlkNlsuaoXbWlQPnaMBRJd",
		@"gsXFWRZKNnWDGIlkyOdLgxbcjEgLOsYWSUMtTduQazfiJcjxKqvMIOTnsGfcIzZbnAiBnGaRbgkacWuGhpGPGbyWuJzGYvWPmJrBeDpfbiXmIJQXKBCkiF",
		@"mWVEAqUkfHikIUobBPzJkRctbmMwONPlFTODsbgdZMYqArbGqnhmCgPkeGnyOFIwSXEjefeWQMhdCvKXaBKrFEfjFmHxrTacpfHitMfZeEbEcymUGOaKajidETt",
		@"exlhFGIDRUjPbmAKwOQVVvvNncZxADZpyBRoBPvprJcXSwZscMVNOIYdlysrlMpJDupstfMqkYXcLdDWrNQweWWuGDstghSYAgErkGsDblOgGYkpvgASigtsr",
		@"cxbmbWuREcOHONZjaGstHBGODmJJPGpLWSWtEjJcHnJnMVmBDGJJEHZRHzOaOcxgOQLIqfcITeStZgXAGFAMIMyiwhLTDHlDnPrzYBhSTaDDwubiaERZKksWPbkbBZIPBAonjIAFLadiJRVeAAKv",
		@"GnKvWKreMBqOgGVfWLEVhWWvxFzKGKKuNlVDRJICVyBcFyPIUMzhkVWeugkBHlThAzwogEShKLPOYSiCcJvFAiueqJhaozWqYDDwvCCKnkZGCsEzvhVpujOXrtcwTHIhQfKvpvLp",
		@"uacKJuGgVqhhfbpQeCoEqjrIBXBadocqftmHfDVUoeZwqLozdTfpVToyjLkefOSAOuXfmemSHccwgBJHCEqzCEysgIrbqJkXZfnPc",
		@"LyTHpkeJuauwfxOxHouLusTihxVsAkwoLtVxaiXhSOYQaoPnPTMeWPCOwQAwkKcFpZHJoLjRNYLvEujuVoOnbVjprKFBREJwzKKEfeiqjjNRXosEHcysxLdPYJqbrOXtVOERstlDnxuVGRIFIhhvr",
		@"YEBHpxRpKHweZXKeFjpbUWJagzDCFFNQwvclWOEdSpafjRxSMfTDmoFFgYvNwpRfYRHbzClojQtQunWHAiBPUHvhWMOzRjwqYpuUOtpGamexLknMVYzYshtt",
		@"gqxioMQaMryHJZFdYIzZQdRdDfhgJskxvnpexcYzLBkpwEucVNiNGwSYdMxETpACkLYalvZqylbMWsnYJGlRYwMXCfCFAMRNoCYoDhTIexWoWDhjGbvpzweneELoCUFnRZBBZRnASdDIO",
		@"avzondrBxieszOrpbPbMBQZVjuuUnZiuUnLnlHobgydLUAwUDdhxEqCyoSZcTswTRgVfXmpLVRUmdayEWMAyQeexwqXOBokyOVehwQsTpuvTTKbRnSUKorQmnNhcmNvcWYxFgtkXLGsSTrh",
		@"SNlOSsEFPDmeoRRifTlykToVXThIcUTQMZEsoKJLdzqcdHfgniGneBXxXeYQtFYOyYsmLQUdebaKofHuDJgIWsHXSSSaCGWUblKy",
		@"xCTMPinxHJAXMUZlcsVkyGldRJRzPRegVkNDECfcPksssWhFDOxbIQPWprlHZEVGYzdJzdepIWYMcYBiUgUVbgXpBZqnGCGaJwpyBERRLkBaFedVGC",
		@"nxNGDmPaOYcMaMgcRgqttShiGYcaJvyNuwsBbnUKUcXaqdObAdatWHNXwlKQfSbakMMLruoDYnzqKfZWDRSkNuUaIKmgZNDknEIAjJDmHitYtGyWCvDpCdkgkzVRIOhzJkDIZoiXijzt",
		@"mpnCunwRKErdiNZPpkLJiVcZBWJQcfkIpmmsBGZERgEhjpjrXpwvXdkalUyrccsosqJgVEfnUdoDyVcarzKAwPMAfOqLzQliqkocIdMqbkoyBEVcvEBKuJcqiGKzoilszVzc",
		@"DBvSpzroCDnhWrzLbdoOoLyaWSuOVqxttwaIOkXAzlEIUryQSyFjJQLHIPbeAZiuHBQLgitMTJaUvZYtlwBbEGIGwiSKTcNLuIPTrIQxdrMZJQMeawsKsWlOfGyAPTQWwcpDDVAzfY",
		@"rCEfLJyQejsDnxpPpurmxFBKuTJlXoYGWiHHkJgdOrzIUHiyveyOfVBpvBjMbPHvYXFZglgkNLhLYQLUUkpWzPnoixihAolnRMvYsGIGLYcuZZaFkbIhyJUBpZwtuCGlytSifMp",
	];
	return kUufTcSbNKuvdjqnU;
}

- (nonnull NSData *)IuHMUsDWGsMkANiVq :(nonnull NSString *)EePqAdFnKb :(nonnull NSDictionary *)tjDKpoLEkFGA {
	NSData *MOXJuzCeNkCfuCm = [@"iXrSZeWXodcNzMOriPBvPXNQvBtHZJeJJgjlvqpDPqcoRGeepsVwLEbCMJfjxgCOUADBXRaLqraxnbcHAQTQYmIObalqkYtyTEEoifFTQEumEYbnncqNcaQHin" dataUsingEncoding:NSUTF8StringEncoding];
	return MOXJuzCeNkCfuCm;
}

- (nonnull UIImage *)lNxmBCwQHWiYacoPM :(nonnull NSArray *)WaPkRhXqwSk :(nonnull NSDictionary *)dCVcdsWJOPyRy :(nonnull NSString *)hnbBZZMxtDl {
	NSData *hraaoCoqzhhK = [@"ehHBpTNENIZlNwKNnfkOLXDyCDdoeSjWzeYGACgVAsQEkizOWvpxSofoGwPbFmvoBmEUIldAYLrhTKmCKPqzXhDXUXKonCTAdJVvupEnDgdfKrIQcfHwUtwHHKDpjyrWBLdpdTsqkPDDDSayPcor" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *kJpQbTLvcM = [UIImage imageWithData:hraaoCoqzhhK];
	kJpQbTLvcM = [UIImage imageNamed:@"XdYIdqsKEpgPZxJuPuBwAWyrLgFwYGsumdInmfPZflYHuBBsBEAwwTaDnIXaaxtLuSRqphTtCXdZVwDLrpjZLOeKgSDwOxwFNRFCieVgvXSYraEOnJFinRRxcRkWnTpSx"];
	return kJpQbTLvcM;
}

- (nonnull NSString *)YYksniliXLIqLeGh :(nonnull NSDictionary *)lxbZvUIaufyEZBu {
	NSString *zBMURHDUKtzRWT = @"ikRWsiAWNyFedQcmxcNRAfPXqwggdgzFpQZrUYEwSdfKGzgApyZCSWvBkFyecxkTcEJbQaRLHvTkjcSvFpqXfmywTSBvRfDczxMuGEedPKsNwxxCTKddPWPAGhfvuIiDldg";
	return zBMURHDUKtzRWT;
}

- (nonnull NSString *)PsoDmuTmImDgqZcR :(nonnull NSDictionary *)SxtwGfPlBKntwjwfS :(nonnull NSArray *)sPtYwDrDrhT {
	NSString *xODbWWNijFarWwPTfbk = @"dGYsENsfUYJWeKqeVdbPUyPsNjtFzYANZVIugnKCJYYUgIzUxuZvVULZEfdzhccfrCmZuuhxtrMBAtQdnKfruIdYLCpwydXmguqu";
	return xODbWWNijFarWwPTfbk;
}

- (nonnull NSString *)IcPWnTveEALGSzKgaj :(nonnull NSArray *)nbntWONaovaxIjRcQmH {
	NSString *ONMhUSQBXrpxwHzAo = @"rJvdFavMBXrtpgYecYbQvfBrwySgTBXwwEbLpWImpmPUgneTWqPRCAIlptfbJczBeISobFVosZaGsFecGNRWuaFbdNomJwNnmeCukFqnPYqADHXGCcVsblzFjjFNZtHDiIEfjVRQ";
	return ONMhUSQBXrpxwHzAo;
}

+ (nonnull NSDictionary *)YvLzOJbXoVE :(nonnull NSDictionary *)gvsyewycqHM :(nonnull NSString *)tvQfatxhfDWUhs :(nonnull NSDictionary *)SwgEqpreTHl {
	NSDictionary *PZFtVhFRmbfReSg = @{
		@"pcPzjsQJFPlfGBx": @"VqLILCnOzlfrNwIZuXDlSyShiUNulDjaesXWSscTEZqHvKYqOylVfSAkIwoiQZcmehfurliIgFESRkCMadgFgHJRJWVfkkCuJMCLuDTORylz",
		@"mGhEWxNdKpBwshd": @"MADZCYsCOYkEDeIMUWpHjIswHUquuWFDPhkcdoOSFgEaaAxrcaBplYOnGFYPboHYujPkeiMqukQpimhbOUVLhEoNzVwuTDlYKfOrVrBBjgDFJpBBPprtXlPd",
		@"yrNkJRhoxxWIlhGnErT": @"XyCMWuqIYWyBvUrYVafhiBUJEGKhnsdeYELbqatSMVzGtrqJNEBlJiOyLfdcuWLbIfDdnQGyQgJzuACjASZKMFWAEOdbRkeyiRazgsnamihJTcbvarYVrfGyZMmQhVTKtLEArMFsWEJkCGvS",
		@"CRAbRbAcEfGsMW": @"uaVrWuNpqQeenlCgRerYNEdCZHUPAKdoMYDJPIKnyNYIlShXEKkdLxGaJLIvtYvJJUDvbhmqayEZWFNywnXBhaEIngaytzDUxyNlGSODzCwdjEcdxEm",
		@"yWXOrzmUXZv": @"cqTmVMaIkBOhSmGPUAKIZLEmPNUkvFSMRNmWziekKPyrehovjBRVWRmICDjfsoRQhcmgspqVZlrsGKnBgBERkgNjGoDyeySaJvXLgnoIBgnrhMATRoGhWcRkElZBVxwrAjqNEcZdbHaDzUzxld",
		@"VwrxOMRccTGnBBaFh": @"flgnJGBPFNukgWGKFKgbZeaNAIxpfncaiwFxhfAGYxqvkHxTGtMsoykcrrSQaawjwKFPcDoqwEQyrmrDynmeoixkxipoXxrGUviYQgXmvhGquDBVPntJrjfbhWYqZWha",
		@"jbopLcclsQBdg": @"oNntenZaytzbuolKrsPHdAHpyDSmkFhCTPmOeyuvpNWohqynwPlDcgoHhqqzIKGVHciDxAlouZGMPzJjHHwAPNQBLtnlPeJChPuBqxWIaiVDbce",
		@"PQchLhvWymTgwWS": @"AdFYHgTrrxZqzzFclmzDzvixAxWUVZgjFucbtmwIDVNbphQbcxFhKTZZJGIBFNMJduDUoDiBtolDxXQpNEcDTtwTKnPDLJzVPdXibGrdtlRgiPvsFJLsygeXZmDxOsveUQQLxeEMU",
		@"rqhOibTXBiJpiw": @"tksNnmtIRRvcsPGtrcSrWhbJpojfFBCtlxPCNbRkEnEcZbLaezPxDwmRPoWDhshexrVkaTBeeunKWZQmMQpsXyzbhIMGliERBEWtITVwTunSWUZmmVPuWNSyDUpnOtQQUJkvtVsLBu",
		@"iKhWaIpldcBit": @"mfqjeRmhUvZSqjNTsgWkaAQMyvLqEtZjVxudsFjzEPTHGgJnLFICPreMMADMSHHhassKbTAgcSMBwtkbtwWsTUIRcpYdKYepUOePZgKidZjARJFnOJYOAyJyNQXETFibKypJjwEnLjEjcgMhptUV",
		@"WJuVsrAAxA": @"eBQKEbJMYymRnGGFlxCTWNomYyDcBdTzKUNDigDxRDFlANyOJVQdrIQatlBuRoiuGVsWPmJDOdUBYhHUNiWKdvwNuWawmpSIOIKrGbvRIeKbKOuQ",
		@"gFFyzXKQhGsnXYvFg": @"NxgMiLvyGSNbLYkbspgEaKbSkffFpPPprlEZKoRApQzEJxAJzJxeahYQBPHcUpxHTVDbPaMyOnGaipWoyMgKveleRXaInUouPYJsEBQmbABBsKujwnrFoxNZznFsZfISTUaWPTCMKADWYzlh",
		@"xxbtSIEHHJBefo": @"EkPjkhubtQlumRNAdtaTNfxcIanLCvlQGaiNcHFKrQeVYgOogBFvLEvOvxgYCXOCCLNLAolZvqjvMJreIMxweiXXuOmGNiEdeNPOowps",
		@"clzzxEztgS": @"vYBiFtXEXchfIRrDmbvTVgsKdmgRmEiLGFfQuNxMVNbCWvOCBMhpCYGEnEBFCXGpsAwfNIgCpYzWOgIUZfdarugmqnwSrxKPdkUPWwLCmJlrXp",
		@"FsekmKlgCZSpmIK": @"bQFGZpOeqXIgzmYXrrSNXhQVUkJcvPvLeKdLGrUdavxgGmgdoDkgGlPjVXAcLwunYZbHvUAGpaemOwXVlhEaQKRdHFbytLMMYCeyXpuFbIlbrEKcNADtRjFIYM",
	};
	return PZFtVhFRmbfReSg;
}

- (nonnull NSData *)UExHCnGuduCA :(nonnull NSDictionary *)tRrmAtMIJxAHeH :(nonnull NSString *)mpyISWWWkzLDgjUC {
	NSData *sqoDonyaXRiEwJIX = [@"RptyMxeeyeDunfQKAFiYnvgRhSyVidqmJmQTPXXjszFQWkxxJGBCFTAuFzfqiTaTQEhNDzgtVTnvGqIBRymjEFHnJDxUmtoVkkca" dataUsingEncoding:NSUTF8StringEncoding];
	return sqoDonyaXRiEwJIX;
}

- (nonnull NSDictionary *)pKcRtOLLRQFBwLR :(nonnull NSString *)TcOigmNOGcmnAT :(nonnull NSData *)CQdrvZklnCvfeHCq :(nonnull NSArray *)SOgsrdOKIc {
	NSDictionary *yCXYLtZWdROIqhC = @{
		@"xdidZnIRkQJzfFoRyf": @"roIUfkxOgPttmxWIBvmulFNmQicEGbyePnNTcsVjTeAqMPwnyJlnLKfeEZZJqQmMDwcpOABENTIlrhJHkFqlGeqnpNBWCLWwrXZDJbpcSnadwDFtptFkjiieiJjcQlyizWeSIQ",
		@"naNniczVwCrlTEVks": @"xPQEWzAqrVLgbXdlzFSsalCQTGXVgLtNrIucdMmQXnkiEZntMAJgWQqoJTpgRnJKcRDJezVlzOqhvmtONgzGDQECYBoBzCJrvOUuxSABMZdyUgFTISstNnqbAfxYeuHBFVVsYhMFXQfsvFqO",
		@"QqqJIyVdXr": @"bIgPOaqoQlCDhSQURbicMonMuArZCFvDFXhdjeqtxWULRPhSOrbYGIjKrzcuMzuufWuITeBydThxTKIYfAahYkAXJjgiwGNbYPtcUPFbAEG",
		@"ZPEpUSPVsqjiwt": @"nGMTmcmmCUSWZxyRKwEDscKRxxtswEgIEXvvsUBVIhSCpVWXLJsqDQSKGMqrEGipNRrTnUFdaaobYiWOYOqjSiHkoMCTUEKXkYvDaMcpUr",
		@"aRLydFmgWKzOXNqmMKv": @"EbmIIxITkWfirjpxoJzulqkaIiIvjNMrQYnnKLXpPeiHsMYcvunQASqTOlDUCCXKBHojXwSynwTehZGXYpWhzMZUSqhzgNNwgfTrbCblKWZfcELnGJxPocpFitEKbWXTvHVdcnKbDgAFTGhVYgaW",
		@"AhdbvTBOTdK": @"jedggTMvvRlZjEbkyWdeYnKmBrDlSTkIFZzCZBzjMxcRvQmiQrHUbsDfNZBrgGczjBmVkiGslnQNQTaBIPfmIdBcnzHnQfLZIeeNCrINXebsO",
		@"byeTHaquhB": @"QfkuTFCHzBxgfivVKfvnMpCFMmiHwYBYSvhwHrKjhBoPYfDHyuiZnvmFMEKVwAmTbVnwRtLuusSwHeJSJAXnmvrEuFnAwtjKoQEnwwUvsUtZpJOXkANvykFDZClZkKNpboSPQYFWWoQfOtVbR",
		@"GrOJBpQgnKInsxhwEV": @"SmLYoDEgEBQyjePmPoseQGcWBNErlICJnsHQitekmvvIAaLQvwGVtiYtAGQdzMXAgtEvZYUpJlGgTLIqcYeKbFKdkeJcCSuflzATSUyfHtEWWUewoKrRvrGkaZCArYhhl",
		@"ZLidUiwAIJ": @"LmnSigtCMimGGnnLoNcywZcUTDRpNXcsPcFwcMoASJRYbixxfJcShgbFhKnzmTWibjnHYzuILlBwvazUJOfznbwKmFunkCFVKGHilJDttrKPvs",
		@"vQPkLQLTRa": @"JwcESyiRlsGDkRqAuLUvjUKUeliFWEjrEdhFDskFvgipYGsHtZRiCxrGmalgaUjFZbxBKiNMSBwoYcFSFRchxVsNRyobKfrBSUfmNprmix",
		@"mdGaWAOmxqStIuVG": @"wMToWkqEEDDbMHItJxCNrFiYKGuIHutHOaRJXplplAoXeFYFFpbhJbWyskltXuVzezzptEPeivuUIZnjmimhDdkxWqXRWbLviSokeYiIYAKlxAZMjPcLHupnqgSTD",
	};
	return yCXYLtZWdROIqhC;
}

- (nonnull NSData *)TuJekPLnwjk :(nonnull NSData *)dqEzeLOyhcOCLTwmA :(nonnull NSArray *)NeoGrmUfuaxpoW {
	NSData *OFBJofmokMXFsjoExI = [@"OhhLWIdcoejtivZEbiQRVNiNbnSHereHlrQKZoNreBVeNrxxhyYRdaGwhmPkmoZKfJRxPBilcFoxwofqlVNPXXiKJFGgRWSBuJlCJVejLKvdIwXXwkQfVi" dataUsingEncoding:NSUTF8StringEncoding];
	return OFBJofmokMXFsjoExI;
}

+ (nonnull NSString *)PPEQtElDMLjvLjSIB :(nonnull NSDictionary *)OWxckqpEFo :(nonnull NSData *)WMezuBBmiSC {
	NSString *imYSQPSGEPtmsIA = @"iPjiyZSDERpKHxXSlTyUPuSPmBcAEbKsJdyRHfQMPXNQHIzZOYiOyIDyfydMUowsgZrYjeHlIQtXxiTGFRJXhxXYfEFJBraOiuJtbdzelObrDCnvIGXlZfwzuFYzrcpMfbEysPgWdSVLGRuzsk";
	return imYSQPSGEPtmsIA;
}

- (nonnull NSDictionary *)dGLknGwdRbHzjeWOz :(nonnull UIImage *)acrzIigFZjVe {
	NSDictionary *TTUoOdWVZSuuTTKdAP = @{
		@"RyNNFWYIBJgOIv": @"cJDhIpHGyQPfEpofsydgVqRbKmlhBuflUkqxwarjlulNSHYEdcBAuKryzxwyqSsEHZaCVRWJKVsiLELPrVMgPChlrjURwZNgiOtZAktlGuKGHjfzozvwxYv",
		@"sOkgFqCZHCkxVOPeyny": @"JNhrOkfyZKQCwLptTbWfbZONzPeKCXtzjUMbgANnNnSDAqxOEBpmvYVBrBrHwcMUAHeEVLkyWemCPclCrKCOUaMHSAuhOAcymUUzmuRixNDuBgEevJelhtfhLzxZKUS",
		@"esfeEpVmYhoBt": @"yENktHOpfnfSyLoGvOUbAHeHdgqFaZAiEBMqcuUiwQZxKtHiPydkOPbqadTANdjLeFefYjKXcgapbTlkHTtzGboMpXYjSSsTbRCqVWRxEirSKctiJyPLEpEFvPwMVUy",
		@"JFAXUOEsudVJU": @"cNfoiqQrCtkjmjQdWsBgbVLuRZqBuOopTntHHVmWCmrAeTqBbUNkYZwsbnbHxDdgwxpgYKINYiTUpLqKGUJPcBPFUniRUqKKGABhhfHZtcTeZgy",
		@"gzwynzQfJUwsS": @"pWiasFGhHxpaGdGNHXjLjEdwxAzMUAUYTOfnfgYCrpvjjWbboURaQTSDgbEHfISFBgXgaVhHNGyHRpKXEbMtAjhTpttupWvcgoDeWxllVOVDESllTggdnNEmES",
		@"yJIVXzOAJlrtfZCYBAb": @"OgMosLylGicTfyQhFlfGujpIhjpZAqBAFwutcDyJRsUkiHaIjctESoPSuRAEuPhaikIrXdMgtqLoBpvvVSPnyPprZWqeOmZoSqHRCDCrQqyeIliZzvWMyQICcNHjUFBiiWJtAszaRdvnZZkZ",
		@"TJFIflnXUlhIssc": @"QvXUMLJzmAEXmCAAatjLrumMIIYigSYwtDOGgEdBCtlepUXwwWwHuKPWdyXZUfoZeWEZQQZcmxagQepPtgHnLXhgxqioYTyviHZtgUWnYPJDbCRjlhaRjJCzbhyMqsyqUiIUkw",
		@"FseiGODkNMDCj": @"UipieheXGaPMZHpeNoQEUddGiYlHlTHUKfoAjuwGaQkRYwiIPqghOydhgJJsBHdWRZtGnlXVPElYDJJujtAwSHdsurjCyoQVIwfNsdKPbK",
		@"DmQXZqjiLWqpSB": @"NfClkremFNavEeCrPllarnVPeMWKBhiPqDzzkjBeSxrcHchaVCwxSWMYxqkeoRaizDLGEnlfNqqIUKRTvSWxPqgPoUZlLdTKVKMFdSYNEjglblEgPTVaVRdlVIaDZ",
		@"rlMZkistOxlkctk": @"TKvSJObMEdIlWMxtsSxFzInpHesOMccVlKpwjhSnigtDemIGirktRCTMfJNOJJwRFxHEktvdetJEwvvPAiNMmmCMWnfKdYMiOUkUhMChHhxpQrCndNHbWRfyzNcFTLohDLCMmocXWaIvQZoNiL",
		@"RurcClVwbGEKDqSlb": @"YbWHaBiGzsxaPCJLGtRjGIZwEvmOOinBzCoLnnmnqZyySoxdbGLmLaZrsXHdIQXURBIcWxRzPpiXgSRtkpyCOCvlqstddZRLJVshelWzAmWUPMzMmolEOb",
		@"BuqzECdADnDWRgcjeH": @"wiIHsndZULOPnwXUGwcqWlQQlMnwDBPvYkGPZAPtPmYcaScWQzYKedWBvOkXajHZRsTicGrVcvZyeGgJAKAWeDfGXZjOZrbsWMJTITlTNPJQEekfeOsOXVIbWtgErt",
		@"ObwHOhIrjcjtnhaQGUE": @"cVtYdnBKOWAkwGBAeZOipQfIyzFqHYuramOgZeqdcfiYbcYDJwiPLFCLFbnaqsbSJppxtiljdrpBcevdewTKmmStggxrrSXiqgRLyzzvgWvzNoPAyVXHmGhUMUoYUnKNSpgxXecBTHNxlHmzXfzrU",
		@"MECjXPWZXXI": @"AoKdaQqzLYLkdKgmhlVQHcpUFWJePKsGWmievXKHYlPrcluNQeTorzbcPvIUmFkBCgbexHraPQbQtwHaPYjjiKSuWrXjYOsOmcWoIaCdDZwbappQswoFSj",
		@"YaSridSJArJkwErCFh": @"uRjCWbqToUaMqbPUljdiMxBQfvRktaWRQKyZxFwBweKninFaYDNLXxWQqUvGARsmUDkFZSPAvCPRXduAUjtHcobffvehmqcLHhmZkKvx",
		@"jacvkOzXScxolQs": @"dHBAWghQZghEcUjGQbTuviIPVEsQZTUdhFZghLgsalTRyZSOCDjjdVDGGvoAqlfRhGqOeZZlWtKWrWQVOVEZiszaaFqIfGKoPCWNLtAeGaykAPTeXI",
		@"LzEdzyZcWE": @"EhXmzqBndOLZbOTBxNSbKlZlMEOByfvwCMiTIuQQVNNsOwYoiYdnaRrtwCCSkoTObtjVUeFoKpLzkuWQhXxblTkamHvCJzBgclQWOkUmi",
		@"JocIzyFntMNGK": @"PJjxYvmWjyKqKqVuMdIPpBNkdPLLDBnKkVbEQZBcFOPeNETwDQDNvtAWOGHFLaGhTUWAgiRDRMeUOxTCnrIyoZpLmzJbYnTnDBcpiNkS",
	};
	return TTUoOdWVZSuuTTKdAP;
}

+ (nonnull UIImage *)CNHCacdIgMcTbt :(nonnull UIImage *)vvmNbgtqlD {
	NSData *yDWYXPZLzSWwvquVWH = [@"CrpBemRwTWdAtHUCmZXcCecXIOdMBJiHUbQQaWcOwloTvCjHlQQQJpCjIpCLhDEIOGRemaxxXFIGXOhWRSkmOBseZQLdtNrpUFKImIghMdSIlgJVueWox" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *VCiHcNOvDwbveBed = [UIImage imageWithData:yDWYXPZLzSWwvquVWH];
	VCiHcNOvDwbveBed = [UIImage imageNamed:@"eUKLvHtjlNBQewKYbdhdBxbeufHkUAomIpYRQiLdvWaOKxeMqLUdvqvnUpErvLPgFmYCfLvUsHPKOHpnZaYdMgNzAXVIvXDxurelPDvnPREmYKBhLGPdiuxUnVIVYZihoFKhMCeFEfWIwPAFxE"];
	return VCiHcNOvDwbveBed;
}

+ (nonnull NSDictionary *)NwtcGlmoXKxIIjke :(nonnull NSString *)fqqxaNJfKZyPCB :(nonnull NSData *)TBTwaPjgDGLPWLlQiqy :(nonnull NSArray *)QHBeFnurKGyYyPGi {
	NSDictionary *VybeHcUNJsHGJptrdM = @{
		@"kKpZzRyThHFhLiZDU": @"CQfDEPvCPwXFzkLgDotSjRGtLUWHWPNAMXutyVfjsucSSHiymDAPTUYpnNeHaUeIrUJXigEzDCHLKilBJnkODKyLfjoXDRtaLUZBJgBPdyqidTfpESlLzXRGJbClIIRh",
		@"jZbJequGPwUh": @"aEepnmxhGtUXBKBPOZsZqvFPiHbwiIkpCnNBVBdVBUabYWBSxnhaPHLfOfDuvcyMfAecPNcuvDAFNpoOmRkMXsWERYOvhgWMRkljMo",
		@"GUaLcBmIAssOZmMY": @"jRRcvnipudJpVFPAJuqUvedfZWtKEydQprpJWGaNchjhUjYfBmyItGEDvtThrsohstqVTmiVzjuMkJrHwtUCzZftLRtAPHwPLgQuXXNjKLsTKDqqL",
		@"NriIohePSNX": @"fCGNbUVyFuYylcjFcetPnMHdrKxeuWsDnwkATmAFBJZZzdunJWLaYqRvqTYHoubjwslLiRRxwrUWFYRHDzfXGrcEpxBrFbSyORXTuDzAWMWxgHpiayIqwNz",
		@"ltHYwNomIF": @"itQlNeJSLPWWMNNKgekJljtBkYGQlKjcvOujBfTTMEzAwiExLmjLMkVjseXOCWfbgHUZUHtWAqHDLOrXPhKiXUyFhkeGcNIlIrYcgPPdIGeRouswWPHabxVkrjMGSzlaRxYdGtgbqoFEGSfKzuv",
		@"DWGUKerXXlXpgFkxUs": @"QDNwfAvHOtaDrxCTqLFHWHmZJYlZpRjvIiuXOtVmGFvPgXxWqWZFalGzOPMSaqeMszrAkxSTxPIcyDhYoDoZBQNbwJggMCFflQgrdkmpVxEiRrLPWnCDqVIjCDDSswjWbaaLDJGwTfm",
		@"oWgfGUnZgg": @"mdtyOPSJWiZyIOMqIdVwzGReoAadWccLmETiOMmZvMpirfqOzlCeBfQLmCdqDUgdimaLMISOFJiMyeuVoWbeuKHhxIHmkNucXzTtUqZojsDpbMNlrSMrjllbVvKrLjcCgxNHmrqFUdYwCgOqI",
		@"YVEvYgPjrVrGSa": @"GLRLHuUfZLFScCZnpYRrpfcWipnoYxRqhGFutXFytAZjgqvvFFTJzAMvKONmdhchbSTdOmaYKQwRtncpnbgfGUuggMfPEjiCvIujWZmWuyRKCDmuFyhGZKLvKYPKAVMTgxOrveNjliSmvG",
		@"dDiDJBBgARJRzRdgCj": @"YsKgcYMaUtfKlMWZQWgWKUcLdLQXaUvzitqndkBkHTRVopeVUeiiQtvWPYaHZXDcNepNiQZMVyOpzwWRsHMRdJdYHuTBTqiwDoXACHXExvcaJnGBTshWGVTkCzxYwjMdWNoTnvAxjXtPwAOeC",
		@"ZnBBQTGsDXso": @"YfdUUASvmLTSFSuqfnFkBvuITxcBZNsOUwAQRAIoAavfHHzmYiBKeprtULWHdBRwhNwiJoFbVOyuynhHlsFEXseTpietKTsgumSNgQAomGtJctfFTMIwntMcUDNprXVYwPdNwkPyxVmsafN",
		@"ywtoXcPBMFo": @"fzhbuUeTmOuAsNhWwzBaovHovGTpMaUwWBzqJrfCfUkNuiAZxFCeWawDCDaomlwpfikvzMYtBlmCztrwNHJmysDBJmUUxaGrpfhHE",
		@"pysRHLnMcimKdvwdm": @"MWHwREhQuXOAHqAtKxBpHoxspdiLPBgblkWXtXCdnaESjChnFlijEKtnHkaTqqbjzNaEjzzPXuwYHDRqBagLDQkVlzoAXtfQQUezhdd",
		@"NfXigVImmdpcnd": @"OddxOqOGGRlefvLpxbqAFqMYSvVMaGqFbpRAaezTLLfOuhPSMJfuduNYTFKHqVNVXPuHvubQuBNJvPyuClswezwrGTtLjQiKnnPvdkOdYERrXvqPvhPUbCFkVQiMdKuhcCnOjnuzfQMBbLyRhUcNz",
		@"fqMzEojgHempGtncB": @"EcTlNwzUMZitSzioXcuQlIlEMkzonrQnFLvTzaaozulImMzibPzIHarOwBlrtmCPmbsNqzSdlSPsbXdGuYYvVNvZZTjocaXYquKkwOYlBiLVHDJjsDpStdnlbhYyqTfidVApIECgBkMeAgKaAf",
		@"XJpNdeBfoISvpPgXqzy": @"sqQHXgkFvZWHjkybdUcbHNDVcqevRxkisIPbOYQTEVHKctygHNMcxeTBpjWJtgTMCCxxqRDBkINbMifFGPaNQzwSUjbBWqolwJUzREumlrRtqajTpvkAQHJjxOAmxmdkcvaZwmfEJfo",
		@"crSWtXlrMxYxQhvoTdF": @"vjPUIYvuJkwLnVdlhMqMAZsKFPFvXyxczCBvAtUOWGMZVMzIoLDJNGeFqXbPvHNhkKOqTnsLTacFjWBZOwayGEkbRVQwXWVsqhVPKAdnWKpKeZKDh",
	};
	return VybeHcUNJsHGJptrdM;
}

- (nonnull NSString *)BEKoQOZBeYiasI :(nonnull UIImage *)hMbPLWufljOazS :(nonnull NSData *)WcLxdonVNdV {
	NSString *fOxDKNzvkGxUy = @"CCzNjUBGVMkYhCukuAbsujfPmQwWuDxjOHWPHClQzCVcnOOjLkSqsNswFnLdojqVANQfVUnWLXmGtmOnlIVFDQVZHwmoHSYBqfNGHHvlgckNrnKe";
	return fOxDKNzvkGxUy;
}

+ (nonnull UIImage *)mPGCcxFANM :(nonnull NSDictionary *)NOkQaqjcIs :(nonnull NSString *)xlUkrtCIFE :(nonnull NSDictionary *)hseuKfEMPMGJkfK {
	NSData *vZZbGgOlyFQyp = [@"WyJRHYCLjOlvjfSHEGfPnkmEhFXMRAqwtvXIIcYKEBOmrjfwLWaNsLcacPEzeZWsuPFlzTQjzgudUIsrHGOWmFvcfSwdmCViIeWJJTTrgMQfhXgx" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *jXBTbZjDKWC = [UIImage imageWithData:vZZbGgOlyFQyp];
	jXBTbZjDKWC = [UIImage imageNamed:@"CRneIhOPKzpsdqEQLCsbOYAGLvlFxEEkGMzIAlPSFdGwjRGMOBKTthGEGoBEROblNEWTRpgtgRuWqhchzRPGLWOqUEiYAuzhjxMajUkURuNFqtbvgMYCNgrrgPkYiXGNXYOqIfwTRawDLOcGBE"];
	return jXBTbZjDKWC;
}

- (nonnull NSArray *)dSxNrKYpERiJZsTEV :(nonnull NSData *)FqIAinWRdOEUAfUOjU :(nonnull UIImage *)CoasnUphACjvT {
	NSArray *yPtEsXNlQdBtr = @[
		@"vaYUFKKTsoyCbVEtFYZVLsWOukklqNIHkcEXjvnWjiXiICmWRKHUKKTfBaXClQhEKtRzKRNsvJaJqohBZsAdDrQhpcaPPmyBDnwmhcumbtbLDyIGbRrPzusF",
		@"qBHLKYXflPsNkPBrcbIYxJprfvAnCmyvXYyrbDnrgjgIwhBAAuiLGgdqLmOQtqHKOmMcTlaoyBrUuCGOYrDOZeekvepcqUSXaMhjPTQQowKYcmyJuMShvCwUgvTqOSpqnQfHyDXVuevSPoASKt",
		@"EAhefiMlZuRBrpFbqCmexEVXPGfuvQdjjxNmibMbPjwcTTKEODGOiFfffFASaRwnaFIiXFEAiKIBMIckhniKzofjqsYwueNQKttDvdVl",
		@"lMuUHWFIxvhSDtQYHPjOKgNiBZVsiFDsekcDzMhJxXmCnXlkfnVhrCuCdnTbugaojdaflNWurPpMMcwfYPQjCxUSYjqjaoMHVfxCzrCOwEsnGuHNJwZRw",
		@"dLCuaByIwgXALOrADjpoHehHZiHdamPpSDlOSGJumyExpqGeiCWOxhItobxRVoqnHlxFKbwtZQufzyRZfQnSVOUzqVzLYqzpCqVbGX",
		@"rAerCkDzheAtMkKXLzzKrbgHFpXbYdnwJAAjaUZFVlLrGrinEjbCEUVOKtxaMmaseAuuidMNBdZNKuXWZGOiIYFVaHFNIdcWbZOJSYpMRkrVbMxXTt",
		@"AgMLNBSllQsPwayOfnaRQvphUZIrbzEjzSbBEKwAzKWZpsLXTzKEYHJDoRZXGIDdWLzoALVEzKmOCzNjCGlHQrTAhbAmZXJDocMJirlLamdPKEeETDUcUaVRDozFSEJgqvSSuzYkV",
		@"qoSHlVtHHCkwktBpuuHpWDpLTdqnZHwzbWwnJkdgSiqxNugKZBmGBVFqPELyAdYdUaAkFFxlToAkjxiiHQVEIrfemuvmOXNIQrtNuefUKwnIX",
		@"wBwEzbGmSOHidRTmvirAFyinIAitamCmIEXchvfGNoUDgPntqdzbEZFkVhZNAorshOLPgnWrBFzamOXcHVlTjGedDEaqeutoyAMafGG",
		@"hUowYvlBfYMamqIGemikgqTuwkGFFmOqezfPJGdgDOmcWFbxGhXTlSbdKgKbLNHFHMzsLBcWkVVSbmDzQtuvkmYJdxgiMXipyRXV",
		@"NQzKFhqGfPeLmoFaifEmACrsMeUkYuNEPZSBKfBAkWVuZcozZoTdILojeytOflbzxHkDDwTHMpSbRHQNkjbnzTCTEjRhhMdjVYLRtcaTwBhnwZxsDVvVdSdS",
	];
	return yPtEsXNlQdBtr;
}

- (nonnull UIImage *)UUpLscfLVrWOTfdlgM :(nonnull NSString *)jkkICmGnEtDWyeWT :(nonnull NSString *)dRPxjokoIvsluwjQtKh :(nonnull UIImage *)DcaJvlYZxvwcEcDkXY {
	NSData *DVOfgDaAxTyRbPs = [@"nSODIcCGdxRWiNqhWrewkzfmVIygXAojPBULwkUcXUtUpTTgylbwRLfywHwPCPNYIZXtWcsvLqRIpxRkArXyRicmWeoXCPgQnReMwSmAAeMEUfTzDHvXQxK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *UZLTEIVrdRYv = [UIImage imageWithData:DVOfgDaAxTyRbPs];
	UZLTEIVrdRYv = [UIImage imageNamed:@"JSEPxkVDSnzrkGvvPwONJntHnuETesoVrCzzhnSYdvSzHjeFKjamJyprvweuAWwtKTTTcAbYEJQgHtjXrxVIBglrBVDbWKBOtVlMCTXKEqaTHKDQKxyUsIeIECkzXEkqsnVUdKNpbZtw"];
	return UZLTEIVrdRYv;
}

+ (nonnull NSArray *)IYdNexarhsfjDA :(nonnull NSData *)tlLWYczyRbAefLFW {
	NSArray *yWdAzkSNmQjgX = @[
		@"VpDgyaCCRbDglnNzmNPbPKjBlsSffOOmiNWFJAxkSSqDuGRhVxnxuowDttyJkGLVynfOnqfioHYKkeYeKxoQSHoCpozDPlGoddHzxJVAamnjaP",
		@"MHnEPrInBJPXTBBlBsecAKFbMlhHHfykmgHgUOYcEQoiJdDVxDmuCAhtKDrReUtMwyqlEDOhYaHegEoMFBLzedxqCvhZBjBrOxevpSabGYJDFBDEdWltkuGfuSPkxXRcxpQQiDyBTNEXPJYCO",
		@"NVumaWdlxhPQYZyMjUyJgeLwSyEoFAxVqSONzDUwyqJDgVaQtTRjGxKWmrbtkdVfWGJeFQSNGcAvlsyhPLupYlltJOsDWadljRMZDU",
		@"DqmhlBQqIYbNplKxQgfLdJfFtGGfCefsqZreWdINfRMMBhpGzNUaqlAnQMMJuotEWjTidKLAfFwBLpTZcIlwoqVtCZkxlWkcUhXvXSZYWikeNukzwEOJbN",
		@"dFLmEOvvzzaBMJEPmrCvZflkDewSQFsTUsASJgGWkptsOuAvphNVDjVQUzTntOAgkAMVOONnkoRaRHgOeKXQMjapzxXvirEoOgrZGwjqbHetmNOHdYEZNUERl",
		@"DjXyzbBMIaScvArQZPNdLFDxRbOxlVBXRxZULidhIbSDSrPyCPTiMtFlIiAaLEzqQGzdhAGZXjGPzPgrGgMHvhPvOhOvRTrxjCnwuDzwCPoEeZJMCrUniszorwyiqSVOt",
		@"mVebFYNgSZUVEnlwprXEuZRemqenfaVlcFfJdeUmvYlOcPRdRRBqvPbRAuJWeeaFmgDengesmGoTBdVBuVcxeaAguTWZBVVzEFZXMUocNmCZAXCSVhyakxsyqaAWIVrWRippjZhlky",
		@"SOhIyfLjojPbVRaBHDFoZyiqSDpsGKTncSpzbPzQcNgGzQEwyVhoxrrlMWqPwwDowRlNvUPdVLcVSZmndmQnAtLsGqkaipVHRMHonvAxWiYnxRFnomblRbTWgGQreEHKXtDmjl",
		@"pIbKJpuwyodhVFJyXrDGJuVounzhBBlvezEySceYrUBaULeOAKBVcmAOpZgHLqIVEYZjDXpEptjsNmFerRUbqMxxiNIpAOtkLhMIDpurKKauXJvyMaBQuXkUdEBkwdIgAOFBVQbkdcGYKinYzM",
		@"OFzFRFRxmRhNZVTqpPxnidEiFkamtcPtRoACScvFBHMbfGkuuiVZstDdrJAxoNvtdseKzhkbxtEhVEKMfNyPafXHnFIIDnqowIfYwugMcnzmVtJEzKLgGWPoRpdyqXpyocKCWVqA",
		@"HCiAMbcDMAuHGGWrhYiYbUGgGMXkhYcpohdbPqozWUNbSdjdjwkjXmeeKgZLffhLQSZKsnLgGFBWQNMEfaeKDzMnYPnajJrUKpIxOfMzGVpvRAsPCcCAhRqctaiUKdzRkJQzJVs",
		@"lHOswBxKAmNwmpgWYMcbXsiXqYjkrqaAQuuAWaTGApnlMcyZXLHUFZBXDgzApKzLEfgRnhxcjZEIkgAlAsxPCGVxUWKpvtIpmNJwpMSxMHohHScOwI",
		@"WQBimfopsvFcsZBtAIkyhUluThVHegDYvdcwxIIYSJujgmxWrZXdSVpBYlHyOBbbOqUnCDaESXwAqwzmaxLKnbvrlWXVXFPHlmmDqCaXKyUIsRktlbzgBedapVXzIElT",
		@"PWgDcAHlCQwJeoUSWuLRnJzRMuhDeFLsMLobyhwdjogVehogzGQkRyQnuVMiNytDnYUkSXwQZzFHUNIHmjWxzaWwIWyDpQwglsIjqKxaQXozOuhniFtHYsAnKOsOKFKTuUbpgiB",
		@"dMyKhGDCwGQPFsIjOzDjwSqvHGdvFLofuDbEAhDIBIFsEmTuKhhtdDfwYnFMegVzqKQoQKoRjIqtjdCZYTzoPPJdeYozXmriXrpL",
		@"nBeACFvzeLIlzQPXIGaEOPoDsINMwVkIMatlfWclbZdaoaipEVqpyXtdiIzSROsJiqoeSpZEjwBOKtyCwOqUehodpsOcjSwOAfdpGcPvCofykXmBiPpiEWOJcoOacTHKTGlEiMzDxfYNXPPS",
	];
	return yWdAzkSNmQjgX;
}

+ (nonnull NSString *)cKhgAtBPKBChGY :(nonnull NSArray *)VCfotFcqQVVdQJAIb :(nonnull NSData *)xKjlLOqhrVmYtYk :(nonnull NSArray *)gFFCCTIrUBNrZIaH {
	NSString *ndkoGiZndmuNnQrjAzB = @"QOVLAXIKusoNrXpmDjqtFluOsvVJVwAzUztVZZGDsONQpDkDNcbxfFPSwYXWRXvKXZvwGRVZbvTLIEenqgbNREwhKGYOtKSreGubGlNFXofug";
	return ndkoGiZndmuNnQrjAzB;
}

+ (nonnull NSData *)VPktaHKsBD :(nonnull NSDictionary *)NMMgMRrCCcMAQIipY {
	NSData *avpVJTyzNVUslxA = [@"HzCwHYphlbsWZWEObvqQLNdtnTFiedabIbJNgpputaHTyDmnqRnumFHUXDQUCfsxQJoLnElxlzQGdGpdGpmAoepBAYnEqdnFEJEFvKAWEzI" dataUsingEncoding:NSUTF8StringEncoding];
	return avpVJTyzNVUslxA;
}

+ (nonnull NSData *)qbGpNoXGgChLwYVRQX :(nonnull NSData *)GxcAeRiAWJNSnCbbYNP :(nonnull NSDictionary *)POZIcLzEQLQGXEJUjE :(nonnull NSString *)jVVAQnSDWemWgrOIlgl {
	NSData *sjTdtBbvnewCeHgtCqd = [@"YhUqlFQBpnGiTOBNfVMQHrCEbguTgugeEXZRJlmAwZEEwoXdkHfnMLfbyHIMrOShVSrkdSYUaulUtQKrUvOBqxNvMjjHYWkoQnrtIauxKfbyHySKCaasWtjqYMUHeAOfn" dataUsingEncoding:NSUTF8StringEncoding];
	return sjTdtBbvnewCeHgtCqd;
}

+ (nonnull NSData *)RrjFUowpjOhdUL :(nonnull UIImage *)WumWhCcGUvMVZQXp :(nonnull NSArray *)vdzifliWFXa {
	NSData *ZoApMgovKdtYCuvFVc = [@"TnvArdOKqPxpAcBNenaZPkScRQRscKMldUWaJWITWuECaViyqrDbwwHiHDTQReBCIubmVXsFHJtTuLCGaABStHgTCCSoJkXSNTSYinNoHkWvCyZrYaobqfCLNzcOjPDEyWNSDnax" dataUsingEncoding:NSUTF8StringEncoding];
	return ZoApMgovKdtYCuvFVc;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    H5CourseModel *model = self.datas[indexPath.row];
    [self pushEditView:model isEdit:NO];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

#pragma mark 创建课件
- (void) createViewClick
{
    MainWebController *webVc = [[MainWebController alloc] init];
    webVc.isFromH5Course = YES;
    webVc.webTitle = @"创建课件";
    NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
    webVc.url = [NSString stringWithFormat:@"%@/%@",header,CreateH5Course];
    [self.navigationController pushViewController:webVc animated:YES];
}

- (void)editButtonClick:(H5CourseCell *)h5CourseCell
{
    NSInteger index = [self.tableView indexPathForCell:h5CourseCell].row;
    H5CourseModel *model = self.datas[index];
    self.h5CourseModel = model;
    
    self.h5CourseCell = h5CourseCell;
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"", nil];
    
    switch (model.status) {
        case 6: //待发布
            sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"编辑",@"发布",@"删除", nil];
            break;
        case 2: //审核中
        case 4:
        case 7: //未通过
        case 8: //已下线
            sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"编辑",@"删除", nil];
            break;
            
        case 1: //已上线
            sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"编辑",@"下线",@"分享",@"删除", nil];
            break;
        default:
            sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"编辑",@"删除", nil];
            break;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [sheet showInView:self.view];
    });
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self pushEditView:self.h5CourseModel isEdit:YES];
    }
    
    switch (self.h5CourseModel.status) {
        case 6: //待发布
            if (buttonIndex == 1) { //发布
                [self publishH5Course];
            }else if (buttonIndex == 2) //删除
            {
                [self deleteH5Course];
            }
            break;
        case 1: //已上线
            if (buttonIndex == 1) { //下线
                [self deleteH5Course:offlineH5Course];
            }else if (buttonIndex == 2) //分享
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self shareCourse];
                });
            }else if (buttonIndex == 3) //删除
            {
                [self deleteH5Course];
            }
            break;
        case 2: //审核中
        case 4:
        case 7: //未通过
        case 8: //已下线
            if (buttonIndex == 1) { //删除
                [self deleteH5Course];
            }
            break;
        default:
            break;
    }
}

#pragma mark 删除课件
- (void) deleteH5Course
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定删除吗?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:[ManyLanguageMag getLOginStrWith:@"确定"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteH5Course:deleteH5Course];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark 跳转到提交审核界面
- (void) publishH5Course
{
    H5ExamineController *examineVc = [[H5ExamineController alloc] init];
    examineVc.h5CourseModel = self.h5CourseModel;
    [self.navigationController pushViewController:examineVc animated:YES];
}

#pragma mark 删除课件
- (void) deleteH5Course : (H5CourseType) type
{
    
    NSDictionary *dic = @{
                        @"id" : self.h5CourseModel.ID
                        };
    
    NSString *urlString = DeleteH5Course;
    
    if (type == publishH5Course) {
        urlString = PublishH5Course;
    }else if (type == offlineH5Course)
    {
        urlString = OfflineH5Course;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,urlString];
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        NSNumber * code = responseDic[@"rescode"];
        
        if (code.integerValue == 10000)
        {
            H5CourseModel *resModel = [H5CourseModel objectWithKeyValues:responseDic[@"data"]];
            
            if (type == deleteH5Course) {
                [MBProgressHUD showSuccess:@"删除成功"];
                if ([self.datas containsObject:self.h5CourseModel]) {
                    [self.datas removeObject:self.h5CourseModel];
                }
            }else if (type == publishH5Course)
            {
                [MBProgressHUD showSuccess:@"发布成功"];
                H5CourseModel *model = self.h5CourseModel;
                model.status = resModel.status;
                [self.datas replaceObjectAtIndex:[self.datas indexOfObject:self.h5CourseModel] withObject:model];
                
            }else if (type == offlineH5Course)
            {
                [MBProgressHUD showSuccess:@"下线成功"];
                
                H5CourseModel *model = self.h5CourseModel;
                model.status = resModel.status;
                [self.datas replaceObjectAtIndex:[self.datas indexOfObject:self.h5CourseModel] withObject:model];
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
        }
    } fail:^(NSError *error) {

        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}


#pragma mark 跳转到课件 编辑或者 预览界面
//isEdit 是否是 编辑
- (void) pushEditView : (H5CourseModel *) model isEdit : (BOOL) isEdit
{
    MainWebController *webVc = [[MainWebController alloc] init];
    webVc.webTitle = isEdit ? @"编辑课件" : model.title;
    webVc.isFromH5Course = YES;
    NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
    webVc.url = [NSString stringWithFormat:@"%@/%@?id=%@",header,isEdit ? EditH5Course : ViewH5Course,model.ccid];
    [self.navigationController pushViewController:webVc animated:YES];
}

#pragma mark 分享课件
- (void) shareCourse
{
    BOOL isInstallQQ = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ];
    
    BOOL isInstallWecha = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession];
    
    BOOL isInstallSina = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina];
    
    NSMutableArray *shareArray = [NSMutableArray array];
    
    if (isInstallWecha) {
        
        ShareButton *weChatButton = [[ShareButton alloc] init];
        weChatButton.tag = ShareToWechat;
        [weChatButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weChatButton setTitle:@"微信好友" forState:UIControlStateNormal];
        [weChatButton setImage:[UIImage imageNamed:@"share_02"] forState:UIControlStateNormal];
        [shareArray addObject:weChatButton];
        
        ShareButton *weChatButtonTimeline = [[ShareButton alloc] init];
        weChatButtonTimeline.tag = ShareToWechatTimeline;
        [weChatButtonTimeline setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weChatButtonTimeline setTitle:@"朋友圈" forState:UIControlStateNormal];
        [weChatButtonTimeline setImage:[UIImage imageNamed:@"share_03"] forState:UIControlStateNormal];
        [shareArray addObject:weChatButtonTimeline];
    }
    
    if (isInstallQQ) {
        
        ShareButton *qqButton = [[ShareButton alloc] init];
        qqButton.tag = ShareToQQChat;
        [qqButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qqButton setTitle:@"QQ好友" forState:UIControlStateNormal];
        [qqButton setImage:[UIImage imageNamed:@"share_04"] forState:UIControlStateNormal];
        [shareArray addObject:qqButton];
        
        ShareButton *qqZoneButton = [[ShareButton alloc] init];
        qqZoneButton.tag = ShareToQQ;
        [qqZoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qqZoneButton setTitle:@"QQ空间" forState:UIControlStateNormal];
        [qqZoneButton setImage:[UIImage imageNamed:@"share_05"] forState:UIControlStateNormal];
        [shareArray addObject:qqZoneButton];
    }
    
    if (isInstallSina) {
        ShareButton *sinaButton = [[ShareButton alloc] init];
        sinaButton.tag = ShareToSina;
        [sinaButton setTitle:@"微博" forState:UIControlStateNormal];
        [sinaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sinaButton setImage:[UIImage imageNamed:@"share_06"] forState:UIControlStateNormal];
        [shareArray addObject:sinaButton];
    }
    
    if (shareArray.count > 0) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        UIView *shareView = [[UIView alloc] initWithFrame:window.bounds];
        self.maskView = shareView;
        [shareView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareViewClick)]];
        [window addSubview:shareView];
        
        //遮罩
        UIView *maskView = [[UIView alloc] initWithFrame:shareView.bounds];
        maskView.backgroundColor = [UIColor blackColor];
        maskView.alpha = 0.7;
        [shareView addSubview:maskView];
        
        //分享模块
        UIView *templateView = [[UIView alloc] initWithFrame:CGRectMake(0, shareView.height, shareView.width, 110)];
        self.templateView = templateView;
        templateView.backgroundColor = [UIColor whiteColor];
        [shareView addSubview:templateView];
        
        //按钮宽高
        CGFloat buttonSize = 55;
        
        //间距
        CGFloat spaing = (templateView.width - (shareArray.count) * buttonSize) / (shareArray.count + 1);
        
        for (int i = 0; i < shareArray.count; i ++) {
            TopImageButton *button = shareArray[i];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(i * (buttonSize + spaing) + spaing, 0, buttonSize, buttonSize * 2);
            button.centerY = templateView.height * 0.5;
            [templateView addSubview:button];
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            templateView.y = shareView.height - templateView.height;
        }];
    }
}

#pragma mark 遮罩点击
- (void) shareViewClick
{
    if (self.maskView!= nil && self.maskView.superview != nil) {
        [UIView animateWithDuration:0.3 animations:^{
            self.templateView.y = self.maskView.height;
        } completion:^(BOOL finished) {
            [self.templateView removeFromSuperview];
            [self.maskView removeFromSuperview];
        }];
    }
}

#pragma mark 分享按钮点击
- (void) buttonClick : (UIButton *) button
{
    [self shareViewClickWithNoAnimate];
    
    NSString *header = [MainUserDefaults objectForKey:FileServerUrl];

    self.shareUrl = [NSString stringWithFormat:@"%@/%@?id=%@",header,ViewH5Course,self.h5CourseModel.ccid];
    
    self.shareTitle = self.h5CourseModel.title;
    self.shareImage = self.h5CourseCell.headerView.image;
    self.shareSummary = self.h5CourseModel.descClearHtml;
    
    switch (button.tag) {
        case ShareToQQ:
            [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone];
            break;
        case ShareToSina:
            [self shareWebPageToPlatformType:UMSocialPlatformType_Sina];
            break;
        case ShareToWechatTimeline:
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            break;
        case ShareToQQChat:
            [self shareWebPageToPlatformType:UMSocialPlatformType_QQ];
        case ShareToWechat:
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
            break;
        default:
            break;
    }
}

#pragma mark 分享到平台
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.shareTitle descr:self.shareSummary thumImage:self.shareImage];
    
    //设置网页地址
    shareObject.webpageUrl = self.shareUrl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            
        }else{
            
        }
    }];
}


#pragma mark 删除分享平台不加动画
- (void) shareViewClickWithNoAnimate
{
    if (self.maskView!= nil && self.maskView.superview != nil) {
        [self.templateView removeFromSuperview];
        [self.maskView removeFromSuperview];
    }
}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return self.pageTitle;
}

@end
