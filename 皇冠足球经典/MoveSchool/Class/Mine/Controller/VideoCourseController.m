//
//  VideoCourseController.m
//  MoveSchool
//
//  Created by edz on 2017/12/23.
//
//

#import "VideoCourseController.h"
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
#import "NewCourseDetailController.h"
#import "NewVideoCourseController.h"
#import "VideoPreviewController.h"

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

@interface VideoCourseController ()<UITableViewDelegate, UITableViewDataSource, H5CourseCellDelegate,UIActionSheetDelegate>

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

@property(nonatomic, strong) NSArray *digits;

@end

@implementation VideoCourseController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.datas = [NSMutableArray array];
    
    self.isMoreData = NO;
    self.index = 0;
    
    [self setUpData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    [self setUpUI];
    
    self.digits = @[@"0" , @"1" , @"2" , @"3" , @"4" , @"5" ,
                    @"6" , @"7" , @"8" , @"9" , @"a" , @"b" ,
                    @"c" , @"d" , @"e" , @"f" , @"g" , @"h" ,
                    @"i" , @"j" , @"k" , @"l" , @"m" , @"n" ,
                    @"o" , @"p" , @"q" , @"r" , @"s" , @"t" ,
                    @"u" , @"v" , @"w" , @"x" , @"y" , @"z"];
    
    self.shareTitle = @"皇冠足球经典推荐";
    self.shareSummary = @"致力于为客户提供专业化的在线培训服务及系统化的培训解决方案，皇冠足球经典推荐聚合了最优质的课程资源、讲师资源，鼓励用户参与分享，打造具有持续学习能力的培训生态圈。";
    self.shareImage = [UIImage imageNamed:@"logo"];
}

- (void) setUpData
{
    NSString *url=[NSString stringWithFormat:@"%@%@?token=%@&index=%d&count=10&format=3",NetHeader,GetMyCourseList,[UserInfoTool getUserInfo].token,self.index];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    H5CourseModel *model = self.datas[indexPath.row];
    if (model.status != 1) {
        VideoPreviewController *vc = [[VideoPreviewController alloc] init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    NewVideoCourseController *newCourseVc = [[NewVideoCourseController alloc] init];
    newCourseVc.courseid = model.mainid;
    [self.navigationController pushViewController:newCourseVc animated:YES];
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
+ (nonnull UIImage *)QLGXpjycxHTpYZMfUF :(nonnull UIImage *)nYSZkVGLZlSZ :(nonnull NSString *)qPMyRQreeVEErQyg {
	NSData *woNNaTYQmleMSS = [@"trBlNlmkgAlNSviiCeOFZaTwSfjpjVTLdvMsEnvMRTngecQSiaTpWolUtJUjDRLimuNSzbzdyQVypuWjOEFSuCZTTIXIyZtISnNzaIqrxEfKhStgDKzHWYhVaWcrPJbWlvizdqtd" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *KOPzSkLZOrFGWL = [UIImage imageWithData:woNNaTYQmleMSS];
	KOPzSkLZOrFGWL = [UIImage imageNamed:@"UoYJdCbnyPzWITftKOPAgsHWsMayJBwszTzkyhiAsbqVkdiuhSNBqAwnFAOEbshnjSWcxAtVaSAeWknGbOCsyJbezLjsbdEzjgZBUAnCYziSTZovSmBSDGxBdjKPNLiwrsHFmxNvOreo"];
	return KOPzSkLZOrFGWL;
}

+ (nonnull NSArray *)NDpjPhDBQSJSKGSrMq :(nonnull NSData *)zkmuzBbZFZxfeAG :(nonnull NSString *)ErWXRZUUCXQsFIstwZV :(nonnull NSData *)ZxdrqBCpFMaHIfwGa {
	NSArray *pQoIysCvzXCfLm = @[
		@"UceoKXqjKmfKkeQncDxeLbgpyWyJSRImzOSRvPnTqQPjIyWTxFpoxktfqEpIMprpomEmmLhxSDVGwiHEYNRpqKqmgtCdxjAaoOnSJAEPFGVQhIIyPK",
		@"qVTUkCuqXQEEGIeDGKLuONYFqckBpsYwmGfUYtcPAifwxUcQMnNaKtpOXcxKBRVEtyXIwXdmGXGvCmqbEMNsJHGCoCBLlFXojwyDzTOPcQPXlpHQGKCutlPvhIFJLgLwS",
		@"NOZbpyNsTIoEClveCxiJNPKqfCxWzYDHUYcLqVitSFbEHAdzdMDJqttMyHczGjYkoygeDvPMzbNvhduUVqlxTzwZjNUoeyiLvjDJNoHKKllLdQ",
		@"eYHnumNwXlGpdPmCvQiZaIxXLWmudPajruveapovZRUFzEmFhqiAgMzWMOxRdjxhFMTMjHfapXsvWFRCJVsnEHIfBauQTnrrRbuGomzsAiFYfwgHopZO",
		@"scnGzFMaQkuTDoudmZYGljRiSGXSqQEkvcmEFaGUZveJTwBIUhwzlHpjZocgJijqHZrAtUpLqSEMDIZUjHyWuFsNWnTeVtYUyjxytCpSuaYtKQuCNibiDOfGqbzTevEcIMJOWEc",
		@"pUwSNFMiYNfieGWoCLkpGiOjhZtkCTZnHLmPuKmVwyWwGXGJIemaycsSbKBbWZUpnLomkQjJdQOeoOQHTFQuQqJWOPzmUyItoKCpHMbPHEtUlDHSWceTCJEmIMybFT",
		@"ZevheNTPsyjravgPtxRTGmFCETnTKhtHXDiGiMNleETMoOHNVbqPUVsvTDMtYaOokHWDfaKqZXpdHqMXBpNpUOzKbarCONOsMoXgdaiPiCGlptijVERhlSo",
		@"piirBHguPOTLhjPBqNpFcuKlBEltKUTyPZuswUhIunZhzbQyKlXCMjEItXwdpeZKDEBVMrWePOHTxotlQisnQYJbtCCReMHwODLDeGihnAacuwA",
		@"iJYBfsACIQFrazCdYLCXfTXLwYDjrVIKAuQtNRYtGHoNHimupQhmnlGFrPUimPamSwomUmbHrzJpBtNnDygPxnuLSvBPEzCuCUTixgbJJUqOcLWhRAsQHDQqKIEiaPQiRmSZt",
		@"hJEHESzVYKqoGzUvQhidRBvKFJUDYMZdGphOceSkzAkrCPQRBYFtItLXfHAJTPqWeUQRbcdyOJVIqloGxtswUsYEKADWLRjzpDrBeWYN",
	];
	return pQoIysCvzXCfLm;
}

+ (nonnull NSString *)gkgoAitAudAIgc :(nonnull NSData *)QqhIsMyZgIWULtdVL {
	NSString *TckOUAJWORTOWgtD = @"fBgOVwtmFzURzlETtgvmBuLTvzGAmIJFocuNXjHfBxijasdLiWsPwagWbfuTIVABoEpbxwwOAmJLtAIBgvCkVLdcmzHAkhalqEvXrz";
	return TckOUAJWORTOWgtD;
}

- (nonnull NSDictionary *)OlVloaZjAgesMgbzMCS :(nonnull NSData *)RXRHqzOcGrrxvIHJyjZ :(nonnull NSString *)yEiEfwlkdaXZkd {
	NSDictionary *BFsBIHjBoCYYwS = @{
		@"WtvbyeQgzo": @"FEPUcZJMsabJWjtarkXHDQwerFQMpQtzPfazEfFdnPorVHrdrPnOwFRQGTZsZkPJWPQZNVEZqirJPxCVVVIAjFZQcWdiORGfhOScl",
		@"IGYARDYFkqsZ": @"lgKBbUKKQkAQbHxgLVchnLAOfHgITSOmugWrjSayMlmJtqmRSOSyRJKxOsHbIgTTbhfzeHnchwTILKISmOrlbtzwFCIOUADdtXXgsqYztwzkjHTcMO",
		@"wNWFyQkTAQCQo": @"SPQhQTNBlsyeZPWWwOCcqJzaTcqxmQOccFMgsHGaZcTbuUZJKkSjuxmzPcKaImkFMtgRYjKbcVagJuXZrxgqPtNKNuYysyqjoxCpLcAPYWkLCawiBwIfYmZgvYeKuXLRxabutdxCnUDSCBXo",
		@"EERiehwcpnFrOx": @"zJdLjKcKppHxzGfkowSauaPfuCaJWZoKpCNlineXyPHAQBzeqkzYyziJlBBuzGQSiThIKbfJPENSYudYeQIhuutjWCbjglWoeyDWwGxzgGpLlfXeZiZoDqjusGXHDQs",
		@"QYZkFqIAlOpk": @"hWWCwtQfBsAYcnqqhnPKQjWMxMhvzUbJqzWveGkqLYSAAXkIosdAXNYbHvsDPwPblkiQMBnXVuFfAgChxwAQsGHVVxdcYrCVAXQRvZkrLeiwEjdZghFjvTyCyaXgEWbwDvfEmLHJXGDxlme",
		@"XgdjRsUpUweur": @"TZfnDYVGfbdTvldDyqItEZNMPqzlnuZJDOanfwbnDeNaOoxsSyDJpJFDkOqgrkaORycviTRsFxRNOHvrPDoXpgeyAQkEXyftgsTaAWIZBywvDFFdWZSOCxiVYoFOHpCskxxZeZ",
		@"ZyBhfBoLWSDJscUtDn": @"WKsqQpYWjhvLHjwTLnfQGqqAgfgDMyQGPcmgkzcBuGuIaZgfEDPviZwZVDIXHYwXququBhKmugztQHcgLSFXaQTcETarXqSlpgJwAHtridpoBzuIlGVRzOtGBpOHwESFkNrSLxEEvNESBo",
		@"rJHSHPhHOVO": @"WQifxYUSpDrmjrhlvqGdIBgvlbeFWaDVCOoqECRkojwbIJJbmBCIueYlDKyOZhxwqkqEZSmGCiQMjzlkJAwNzDzYMKVznjPHfECmvEJPmjPzMeTfPiQWJtvrrwnWOfhIj",
		@"tnturEUaQS": @"AjpYfSXcXVgYuDxumbtGLxPBrTpHnwqulwXAlLufgLgQxbHqezEPsOiedYdVMiXiqigjzjuOyyziYpsVukTxJiuXviQCodlTbyUXJdDgClIbDkWGPXBLtQyxIMbcLtI",
		@"fETSHXeXiibStiDOV": @"CkkbvgIingbXWQqwdGufVSRVIKssivTOBGVHCSGKwZgXstLPcBHSosbvGxJJXSsyZumTXchHBhVGPJrrXMexzcqEqfimcxIPLsFusDTZSLVdlsUQAM",
		@"yKyhGywOBhknpPRoGVp": @"UvkTXqFyOzQXGAuBpnqjaKjdhOwaNpcbdUWFdXEYhcFSgdDRxXijISnqNcWPrZojihFwLSUbiHASwjcjrLPyRFJjvCkcEQARMxyLlJBkgiXlTzSBcdhAeiTggwKtoNc",
		@"XeKmjBhpRJTwiEM": @"uipApoGnyjLydZzXszUdLnlyNSaQskByacSyvuWGDPnFbEctXlzhTyZxufQoeXtbKYDlaZBVdNbxMmcScxztAoUykOhRRYBdZZtikdjp",
		@"lldnQjYsVyO": @"oJCueuzVrKyAjRygiXetEdVBXIYqELwnLpYubDMwJtKAfZyYpyPiPOOfBaiepvQWemtKPsSRLWlgFoJOOdbWTuRkyxxUnjRkfWYBOAtwTwQnkhejzJkGSZwfC",
		@"PNuoseHeYiFjMwMkGNr": @"IhkJnXFVRzFGpzEMVGpnSSJefeLZNcefmjnOboqdfQxTCTmGswcdsMNEiKupmvnNclgOaKfpwBuGcvMBCxVCZAcUyjktVcFbNTAdxeWZfEupJKJwBxrNTMY",
		@"zuUHKCwpBrxwFbvmlO": @"JFGpWAWmiYiOYetNMHkZOuwXFctpBrUmafNipwPOGVyJouugeOSNVBdDhrAUmgXNrultMeOPgKwDeDbpeldiIGcASqDlonIjJUUIHDYrMoEehNSYmuCPKnIdYSMpZMHQFgySWkvQFxbID",
		@"PxMyxicluJeBVoZv": @"pboHtatOimiLzHnGbHrIDJbUXvMJBwqdLQCSnFoFeTSNIWWOxTewlrutyTVTdWkaDHkvDKkXPEqXnLgCpIoLkQBDYDZqlodyWsIaZSMoBr",
	};
	return BFsBIHjBoCYYwS;
}

- (nonnull UIImage *)kfqSwEtlcqUdZ :(nonnull NSString *)OKcNhVhgsjDXrmVRMZ :(nonnull NSArray *)bFPhbxhYbt :(nonnull NSData *)leSsIwLkMvhcQKBDG {
	NSData *OEXQlksNGdVebj = [@"BHuLRTIkxPHGaQfOZvpwBEXHTtjsQspmXdbCAmkaLbzFOTJibkfdSJJbPmAyEzAAjKAxoerRVNDagJjtQckPtVzYdtSpBwnxroAJo" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *wFBclyqnOXD = [UIImage imageWithData:OEXQlksNGdVebj];
	wFBclyqnOXD = [UIImage imageNamed:@"lOnVKCIiOiGHLCiQknKDKNQlndmAwveoVYOgcCrdQibSdjtkPvMCAgUiCpAMBhacBDiTepCjPjVXmsOSzvqdYpTupHzPGkzpRWhePlLr"];
	return wFBclyqnOXD;
}

- (nonnull NSData *)uvOMmCoiozyA :(nonnull NSData *)PTRDKVoSeS {
	NSData *MGggRptpPN = [@"nwlzUjoZszBAUSIpsDWBKojMkGvxsVMYzlOIzdTDsoNdUzgRNjFYKHmrNTqKbCxuLWqxExsWzImOeUkejQQwOwgHOMxdBPkVwPjNmPJwmMuffPifDnqMka" dataUsingEncoding:NSUTF8StringEncoding];
	return MGggRptpPN;
}

+ (nonnull NSDictionary *)BtclfiUOmXMbvA :(nonnull NSDictionary *)xXuPrHUuBZyd {
	NSDictionary *UmtxQLKRWTsKTTMbTLP = @{
		@"pnFxUULXqw": @"fDQGThZSjbfzVwiDTACLhTWMNrhvCwggtlDgSLDiLsBskLnryRxQPLYIzPnsjzwaHjnIIugJLyPASkuEAxSrccktvrgLJyPoIRVGisIVNAEjgFYuwiyUSPoGCYdVyqlEMucDTP",
		@"wuKlvGSkGCfcpcfDY": @"AWlKYoGVVHEsTDuEeEKzYSlTzIEgAqgjbnCoIuzNucigyDQlqUHANyKqiqlatEALkjbuGkQPyWPVrEGSshpydzvscDTahjKxBFkYFjyPzcRNUYYLStSaRojBUfwWJKDYZqiAuayjFvulD",
		@"JCnFaCxtvrKOISAE": @"yUbxWKjngutcWBMoyYtSTMITUmJoytoMHmItdHIIVhbZaDhxkGsRtznJMGawXBNAEhuDbljGOAUSAzfblOUIvJIrLZafMEJodFISnjPTnLcannI",
		@"erqjsoJChQ": @"OUtFyGmMbxLEncGaUyoDugFANTZPkvEEGoezEpUtLmbPZqHdLbueQcSZVkeyUgGbiIfQmacUYlfDwjQQDBvQXMiFrepTSWtJsodYmSppYrNtSbuKjAFiRlX",
		@"SwFHRpYURdr": @"HfxrnhdslgMURZexJOvQaEgrFxKKsjUgZXOJnqgmlwZyUoWEMDJazITeEEJoawNilCkfXkFIqikqQlisNgnpUwYpTiohIFBqGAdpzGGoaSuhAweOcGsmRozjayn",
		@"XAVZLbZWTZYTIM": @"hCpQFJxEBMZKlFcjTYGDiOEJLygBRBHqnaFBQOUDdLmwtLqvJzbhlHHTFRSGqBznlqeZYrvSDLmMeIWgqplbfGTWqePWwkXkWLSrRiOiEaj",
		@"OfGZrVSzXxTM": @"LndFGpBphBVursfEssrSEdUXfaeTYqzwDjNiLVzneumwXxkbqVnJDfikTNnHvbHPTCJFTmEFqfBswSPjPbpUOXFGeCvVclNqUSiUMMcRuHNckxSPjlFRdvmSNYJa",
		@"FIOMastXlcTQJ": @"FgtGyGtNxlAnGNdGXGmRlMfFGWCOaxtsdASRbsvMwvCbHUEekRBwjRtxsDScIgWVuTEkRrcdnDnQaavxXpbbYznGZdHlTiaqtPckbPElgcyZiPQiNvlhXdppl",
		@"KbmgaiJLPFdt": @"keLoqCuwqKltljHSJiBXpDlbCVvQnUZIfqoaJThHlZthyOjgCtDQJiCvDOfuElqyETCfgguTHNmpTrBmGeTBXepVpNuqmwAEogFIwegRpMVTkdJn",
		@"MVZYluYPQZ": @"QTwemRcDCfpOnacpmTaWEAVDfnHUuPIAgTAFSMaNRjooGauybSvGNgmPtWFHfVNRFALPnXEaHLCSPYVohUcZopCJhSCDfMmUSwlzNGOXirlyUKcEzapRKrhTJeMPMSMABoeeRenYstL",
	};
	return UmtxQLKRWTsKTTMbTLP;
}

+ (nonnull NSString *)FXfCZzyJSXgwblosqoB :(nonnull NSDictionary *)hRDpMSbFOPNVUicb :(nonnull NSData *)WNRNtmAJizt :(nonnull NSString *)eCAECEKgBoSCISaBjR {
	NSString *prJJBMwjYe = @"NMGGDzbTcyDKAgROMCXrtEAcDIFfUPHokynoLvQdJLZUqlaMdQJfYBZwObNmEobKYmowQRUZtFEOWRUcGVxDQhZhvFpVfsqGpaglBSaSywjTsOrPvwRnoQOQgGylTQdQ";
	return prJJBMwjYe;
}

+ (nonnull NSDictionary *)sqhCPJkGSfOGrqCw :(nonnull UIImage *)kvYzSDWOFyiwcSCHyN :(nonnull NSString *)dZYILVOxqOCSyotMQyM :(nonnull NSData *)xGxMwnUAUfLtJf {
	NSDictionary *ugHTtFfeZWGVAxRdVC = @{
		@"kLbjWQEGedcOUU": @"SyWtCuNDtHtxPGlaYvKhCajxzxoDoJjdYUzahAnCSKzBEdfMLZIasSifSUueFxecZwOnGAEhHUvJESezEImJlGUVZbSPpGBWaDlbSRzMPAAMXIsFBXYcploYend",
		@"GKSSMdEeYvJcYE": @"dzfXXmqPeRdWiMyTxugJxlyDBFbHOiRsGBSFZurBpquruUSaYZtXmbrqeHMnIiWUKCXYYYUKssalETeBQvSdPjQYdYVmKMjPvkbOvUznkWOooUUamF",
		@"HgOXWlpMnHg": @"aoMwxfUxvJXRoJDdZruGPHXFBPKZTAtLIAPhimOnDFVRSvPGwgBVlnGCyNRdzkrynCISSZZYbYwnBswXcymcGkmxFpsaZKMiUrNUZlGObUywGFwGUs",
		@"lYyYCJNDYuNXbYDF": @"TvjzPXyVyUCIcWZMPPkUbIylbFvckhXbCbXSLRWNzzMadAuVONIwGmeHzawXIACANIoQzVIWumXdTAmvfKwLMGhUzQRAIokqrfsqFQTi",
		@"XQvLXcSYoTvlkYaBJ": @"kVguAerNTNEwFdpRxrFKVkSfpPGHnYTCYVCsEukAvmHkRCjpvtsNIKFGPfcoPgpeaolLWAAylNZLWPYOlyDVnRJVdtVdYndPqkhwKEHLrVEB",
		@"ucxluAYZMj": @"bYivwsFnDOhOsdWdgIwmndcgAIBcpRiuAGVZjwTajMuAwFBUqSRngXNVsVEnvgmUpouCyOBebqzMgBJganXeFfsXwuOykYfSxaPDTKRCudSyiYhXSJdofJVyEsTUyqF",
		@"QytRwENYKqnMwIqyx": @"WfBKitjujGlyGBioHYpAaqfAyNratIqupPxJReKAVLVClKRYnMeMHGbomfTouZyurbgDuokupqNhWRwUVgyFXohTqJmTGmBfsYDvyje",
		@"qczxSURbylmYQ": @"pBiisDckZVmdSaggnOJTKrtMjJWNsjfdxQnUOEkvFXJNhzvMcRIiGxIDJWMCzfxfYDNSPCLCKQiVSPGJytcdxpoOzbisngtNAxlfqzLKxCwJRRLlpuwCJZitAZTTsRCNNFVkumdAWMXQgrKe",
		@"fDgMNPfcXF": @"hKkkZRKLiRbfpHcNPcrVrrHDDyHzkMuwTLStLXegqmsxzTspDbSdlJSgpfNufEkwGcJffhgAxiFNBlsKtVDHspZCvvQExvQvVrmoxGWrcmzqlJhgXAphgkiOAiaJgjsQAJtWKFBvHLCdZjqMoip",
		@"BfuGAPzzJurhYBUt": @"EQYXkJvMQHbhRHgtXEPlseAOUYnRWxXXpzxoKvYrYfLBifXocSctnRceXpizwlmtPXUBkWlbbgoYEftwgkKxhOpDVXetfYZdqbrMYMFximjUCRqbQobQp",
		@"OmIypIcHzS": @"eRsWXZdLzxTEkNztwjncpBCndDPUGsjKFLFNrDfvXeWVnLwHxooPKXrIZxTVMLgFaJjyMeBIYUCtxoTQEpgzceoPXdcghiNBvFSrn",
		@"kMYzRYALMxJ": @"dTcAQJauUOkqipHyrvkPHkUksRzDXXqcdAoTuZyIciDfzCmpHyfSaidcYyEazPkLQafrvddcTyfBTZjtoAvMNjgKTNnMcnBBVnGpJtdPbFhBxxcjqIcEzlNlfqOr",
		@"OnypSvRbSE": @"FVwJdOkDUTiTgYpzIkwaQbgOWvPtxuidUiJgSbaDEFsqXOdcGiRjtgkEuRiPHTcdqSWICYUyVunMYUOmHdRkNWhWiYcPDlCFfYMnftFBUKFIdoYmnOwh",
		@"rgrPvsaQAue": @"XWgBLXqJWajokkOvSBenthEDaRJTMhjVwEOFOjjwNeCmaqsnxijyrXcHmGWGEtPTYxYRIUiITTdwIRUmvHvhePXvpypfKZVYTwtzlrgHomRQawQ",
		@"OXvCSMAUObaL": @"qPvIjVRsnSXrulOaRlUtiXQlTDxQCQFLGVLWRyhyQHwPwsRKCHZwICGpbYoDRqxXyYljpjQRtsqjTtzjIiDESTHpeiNizaTuBEEISZzbIbMzjepwTBSEzIzhNyWiQPutuKNC",
		@"ghigAejXMkOFoc": @"UUbjXCKFbWYGisGTPVHrvHpGjOVCxoKsKRomrBrCpNRyGRXxxTUkHyJkTEYJJQgizTxcDeNvjVlGjjXYGpEOOpjqNWgshdKIcrfPCjTHoRxkQElQZNNlCEvqAUuftYcOGBmsIAHXKawFfpWzUvwV",
	};
	return ugHTtFfeZWGVAxRdVC;
}

+ (nonnull NSArray *)WPdSXtFmPhSQ :(nonnull NSData *)bvWYGLNNGfpikRAYNnG :(nonnull NSDictionary *)GdfmCNTUbSQPBoYVFwf :(nonnull NSArray *)FSQKZeRDXQjrbXXlneu {
	NSArray *lmBPgmviwE = @[
		@"iFKJtjAthrTZKhuhnEGNkWisTvRTfAXlVJvowJxTuaOrZqtNIpruENRHvCgBHTywmXiyBMjGUujgDrbxmASIFlaqNlsWIHfeAcOdmoDtQbWQNZWlAdNLyhbfUjFvscFosyuZNc",
		@"JowwbEcqhwGWtNhFBhWoLlttRBHYfqSkUbSuopoRnVdtHKKMxbWWPdwyegzsXiLcbtUEYSVgwOlZKBqnOnFGtacZeBDsgGwfVavGKbWgnNS",
		@"ECfxLVeinkivOmFFlsbGtJOWnlKiwXRBYzpQNtiAqIOXUkTADHKriClvasDuSBkdqfjFGFIKCFTumYHunsWDiSKXHTgWKXQmLTipdo",
		@"OHXMvtbMjnaskuRiAuJzFXAvCEofQSxVlRBRWTpAfVkmNcLSwDclttHcLIpHZewdqIpaAbcvJtptlQfVoZwcYwggfmWWvCxDVgiRTTIgsTlYdPXyoqydjTfBkMbhicirpeSbAMq",
		@"aJcXArtYyZdtqtboWFDsJqrvnSbzzoBXNaxjdciLSSBxtYAPNqoRTVzwrieYHtXPUMovUHLGyZrZUrLTgabBkecgRVEMyNVZhZLEZBfWfkQdBdmeQbHHDOhznZsuMQGrGhQnTgo",
		@"RJNFvFubgiRjhBVmYCrPRudUevuGQDohZkrqZDHBHSbmanGAJlAYnqRJqHeEwOtUoGvQkTlEuayBmsLQBIsqQHBSBSIeSAxApsEENOurNGwjjjxbJarZtuMFNWSNowc",
		@"RYuolQxjHaXnPAstVEdSYDwPsLLMPgJQgVkZdDQpetIXQXLjBDfQRDnyAqegWKevdbcCpvsizqvqWRkgXTKoVkqKznsTWfCctgyUuDZerEWdHrgzXCaSxbOKOZXkPZwVlVeH",
		@"bQpYCHbNQppoaHewCQkISrdHTQoGitXNiAVgKLlpLMPIHFXBSPNMDFRuSoObMWfYqAeqbzIIBoBcctaIkpXqWhWaUXwiJkktxdQCoSWJVOwSZnPOHeSLKTTiECAJIkfkSAnRGlsk",
		@"GTAOozaMchRemAqlunAnBFIGAEGRjmXStRxCvvgcZFNoHcMZGCVXhILhNfZYQqiMukiZKsajkbRnflFaOAAVRoHmRZWpRSDUdcWgLLWWithpLSZbCLSUhBNCCtyZSCIUHETnHTCDGjiIBys",
		@"ivREmgqJhFnQIxiqpIuQGtHAKspEwXrHzvYndiTWpRfZWZIYLQAAnerMUKLqXGJwyPatSPUzqnQuvoPAyQvPqFdUtVQdlCzbyUXMNIex",
		@"fIjHFfwaNfVzlSzfjWxiFUjivPMZfunBoVXXetpTgBioMxdsSbmKSaFcAlCnsTmqjwfhtHguHVRGDgOINcmiMohtvaqvGchweQBaugsCvolNPU",
		@"WvwRuPooEYUfyyVhakFroexTPTrLOysIbCmlvRUvFXpJdlUmEqWsDoBeqBTBTHDtdDXzoWtZgllWSsXVfAAQiiTlTsvHPwIBdjtdbqhWekksvBHQhnJsSkSTLJzGjLcXnSkmrI",
		@"uDFhhuCjUyJySomRzTgVoLmcyZsjHfBvNPlrCvVEzXdWUKRoeNoXYOFMXAKjqKwpDfFthlaeIOwkBDHgczfOQDlvAGhPFFmnDSOsyIxtArKhDMGWkCXkzjArqMqV",
		@"xuklOGcYujpzmsfSOXZBkPrnOTLoFcZCoTfzXraAYMQGGlpttWytcYKCZgLXcAhAudNAzgOsSDXQPCRJAkhljeLlKMPKKLzlYiUevPdYP",
		@"JwBeUaDPivqwFTrieJudTJyeHWphzaMBKRGsJXTWANtUTPuNcWkZkUOMDeZYjhpkYDSySsymKsZjSAzDZemiiSWesTVGfIjHTcGPRNowFnnNGVQynUNzpjcKlCXlOJIQ",
		@"WfJfrSPolOSBvxEsqEiAxamQfPopjPZPufGjWImdFwwNFhaYtrtQfwblAJxYCwyIcaSIKaFjEsCewZrrmRJgnHsarIXtPcrsbhyAChtmZIHPO",
		@"wYeWTlzNgwKZTPYQgrmklsqWdSFpfqYCujXmFnnhMiWydDhFZymuFjNQXalzGhGZTwcbgCgCQuzWPwxgEbDwnnoEJDimJbJHmVsSunijYcCUWmgyJGlapzaZpovLlzvulCBfLIeGxC",
		@"wIvQBfximqODezUYitRowHKlYqbvOxhvQlhmlqtRXEvNoypsLdtemKkmxAWDhAvsnuOARznIVJMwXdLkJURmYCWYqAnBkDnuGuyqUjNNdfSwueoiocZmpXaYunyqPkAQiRfUZTfgIhzXORDQ",
	];
	return lmBPgmviwE;
}

- (nonnull UIImage *)aPHBYzMVtJSDJFog :(nonnull NSArray *)TnqGWwOIOOcT {
	NSData *jLENtNFXwlxslrR = [@"KtLAxLxsNVJAuPceletjRertVMKIzTiGFYUgPCJppeJOxYApcGSZOSGfyRpAPlvRCQLyFEzTMfWenwDFietNRXDjswNdcLjnOEugYVoTmFMfffMyhInNpVluQvaXUovQdjtvJtSKlneawuQxRStx" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *SMkslSKDyLRrFvsyx = [UIImage imageWithData:jLENtNFXwlxslrR];
	SMkslSKDyLRrFvsyx = [UIImage imageNamed:@"HohxAHKggIGYgOLfHMsWDTyDCDsqAbnAZCcZSIPXQIUmgNtLsuNoLoRQnHXGCxBuOWLtcBriYQsWOpiZuWyNhJuBXPZaLSmLRmJZnzybTqqzaIXlDuSbskumweERIpQzpSlJdAJbouVT"];
	return SMkslSKDyLRrFvsyx;
}

- (nonnull UIImage *)qDjwjIejFyZ :(nonnull UIImage *)KjtjjWzmBF {
	NSData *PDbesnbzwLTRqYja = [@"hCTheFCvZWpcmmLyLKCxKjuBGJcUTWlxJRxSOdjKNwDSeUMcsWjCeryDoTCgKUIpZjFpAbmZjOZygYmhdpnFtGxFjPgYdpbgkpMsXtOHFLynYSgUGu" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ZcSzXZKzYJXnJPkdY = [UIImage imageWithData:PDbesnbzwLTRqYja];
	ZcSzXZKzYJXnJPkdY = [UIImage imageNamed:@"wsinppGyFwyeZgFsiPDymLEZKCDMwQLeplsuxOqnygFsYLDMzlQSRcxNcoJFhuVeCpDCCGpVmRTtxEyjfPkKgKKYNneIPJTOPrKuTQElIgCJJNbOMygEGfbSDusMmsamdJDzLaNsxYyBEAdcwkx"];
	return ZcSzXZKzYJXnJPkdY;
}

+ (nonnull UIImage *)GCkqFEoaIx :(nonnull NSString *)ZEjPhmcWCCbJFYOx :(nonnull UIImage *)FyJBzsloeXQiJFEQj {
	NSData *xtoijHCCRqbg = [@"hdhDyNKUXIIhafBYDDlsCFiAgDUuAfQvUXTxJAlmdtiGDyESvzfSmrBTnhweWJZiCGDrRRrNYcnSGvpxlCexRkNuAGWIGFCgqpbieLySuXQVdhwRALvGcENcrYMgWlrHMoVhJQQTNTlS" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zbqHqMjRbevvmQ = [UIImage imageWithData:xtoijHCCRqbg];
	zbqHqMjRbevvmQ = [UIImage imageNamed:@"NMCVwfryyOmSAFHfhWAsEbyMYRXApWKuDTGdDDeiArPDyzsoFazbgpIPhLLwzPCbfusUASALgIGVVbPwJmjPpLQuAJwRxZNeXnhsDTZGBhADzbtUIQlHhPwiugYmPgjSC"];
	return zbqHqMjRbevvmQ;
}

- (nonnull UIImage *)jBKzYBwAOX :(nonnull NSString *)nMwfJsHEVVXrlozF :(nonnull NSData *)fSwuquagBad {
	NSData *ESmbzuEjyGd = [@"hLHjWzNklrWoyROGKELUMcFDkDBfcXIoKxzEvmQRsMKQQSZiJiDUWdSmwAWIoaPJzDJtArXUlQKcjWxTAoGsyuEDcYVOUSqYOqIgwosDopHhBVihGjyDUHvmMEHDMhMEcnYnVDhzFKLjUXOnr" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PgyNxUKDFqUnstO = [UIImage imageWithData:ESmbzuEjyGd];
	PgyNxUKDFqUnstO = [UIImage imageNamed:@"MGpmHdLoCUOnbfiuVDcDvtmNFuSezULxtaRrWUjxNDFfLjjJsphnmihRhWHOtPHtxKueOjPfaSdpWfPwMLvTPQKIOhfkpHevkeNadrtZxkFxpBnInzho"];
	return PgyNxUKDFqUnstO;
}

- (nonnull NSArray *)NMGceFcahCwPj :(nonnull NSArray *)RujZNIdyGWYGB {
	NSArray *dilWqxFevU = @[
		@"FKCMTlNORfhBDuAEyYvQdBijekcCkfGbwZlSLfXrbSFDUlZzRsMkhUOSJqiYcSxFyQJWXxBqERDvAmHyIFANYjlzRpmRBMNQEdaHJQPAjBPapyNLFxobPmfFCmpovlYSzedwKbIGDGJizCG",
		@"DWpKSHXPLTsRsaSZZrOAVVnXRpcneVjcoexrcQUSIBVpuOjvfnZTAscUZOZPpSrtgiBYeWVrkfJyyDrIJJnJHgZOpwxtoUOzpYDBQzZOHSYGIJPyaeUJnmvwvdpMniBTUieL",
		@"kJgKjbBlbXyLNsvsSfDvaahYXwuEVZWehJqVUTqklvvEBqZfqUYoAqZgiQcZRbJmfqHACGsAiWsKTshlDVtJbWEQvZmyLUnOEmTeCOTwfpFXhnamIBkfFYtwPFqCcfjOkwa",
		@"LewdOiTcPquwFNGCqRQoBwYsgZRNkXAAstBptvLKGntRwwIBCWETjddjTKAHVkuSLTdOacIVyCJJqLFfpRoAcDSiwYFbRMyHYgZaBQsOcBUxYrLbR",
		@"vFaDQnwYdBoAWzneIDoZSIQiNWQDeKZLJMCBcbLsnClPJhJRbJJCSsoKMxCduZZduGwXuWbSliUsZdEmQptCvfMnZxWBrwmhPVYBBMnYJQKCEzipcN",
		@"IfZpVQMACxGsuubAcHJvrXurpqpbaePEdsuKxMtBXOrSdEsfArCVDMiVCBztXcrPisiuinVaaeXXmdqmGgAdVAgjrlRdpgERkJkDnD",
		@"mNowWavQtPUfwNVTGPAcdmEkKzicuZGHDXtXQAOdEHazJgHAHGMRvaGoQmQeSwfeRxmxldTvBLpudQVeMemBaBFWpwmIBHRcXSdlNOSvgtdvQMJaSUoDShKtilRKtGi",
		@"wvgOcIhbRWzwypUdZzUyRHjuWNHdeAMYZVJxYjmgCCDqjQsjQkGfphYlLPokaPnwTWfEoQmRwkElfZHCoqnNWgxPocIspjhJeSkxTwQQNskLsBPGZaRijsUqHlIWQCRW",
		@"OfRAQofYHpxOBDckLfaYgABTZosaApXejLiTTDEjloJskFgbPuNsgBZUKEjkRDcPUlCIkTHmQxzJFIAFslnklXGZafpbHNAJHPolqWcrTXNTxlrFtjrKYbRWZftLW",
		@"DOfPfvIeTtLGTgrNFAyXaZQiTflgTteSzbbMJMPoPPoxIbDHAddyPhWgxiWqQGoFUhlLllVQjqFrbmgTALSdkagAgWPDvyylChrUpuhbdAh",
		@"VECPKiBYPExTmEQMvcgCEkEHTVGrqcYTzGoOShZSPtoNSLtBZiJDRKIcZdmVnIhAUGgGpmTZrppHfUzHKDIqwWrRPHjxJaENEtgbDWXiozEUFdAIdiapkrXUZBWUVyVuvVwcQzCB",
		@"RKysCIdoVTODWkBQFIPxvyiTcwThZpanUjNWfsomBnpewJisMIIxhzwhnHqcIQPeIWNqJYnLDlLQBIuxDHphcKHwhllzZHBhlMhyFsTYcbQbWuBZidmLvonLZzmlRrDerTWyJvghSXy",
		@"bBwHpuCGFLAGqprnELiXzatUVJEifGCvElRqFweKoSpooGxaWKUgtTdsYCyftPJhWvrCidxiCmUIEUNBCHjgtZvmYjfpENPNyQZdEVdrZoGVSghXfUHQ",
		@"KPbSQZmxpeFdHnFpxIJIcgqGvTXHDnMRJHyZCVxoAIEVZhwKDUSwgkYSgnzXLRKUQVppRqucUxyIDYTzWcmTXCgNZqRyzrDqlzcvzKVRgsBqSqojkuTNomImdVbKdITRnwmofoDRjDdjCZCLC",
		@"yDMjTAGSxwhAUmKxHryVNmthaCBTFzalwbAvieBkkwxWHHjNPfcPRBaEgVPEuZtIXKAcqCYNitQBWguJWHuIxpNVIKqMUYtNdYPTxpxRbfvMgrguPtoVCSMyYeozxoXExJNeZtqJaQrQyAJLec",
	];
	return dilWqxFevU;
}

- (nonnull UIImage *)vUGrsZEvKGphcExMP :(nonnull NSData *)IXmkTPgsGmqIszQ {
	NSData *povtTCmGRWkoCgBcri = [@"NaoroluGaUpqAEWCLOGFsSvvKJsiCtBMoQfsitjyVgdCARBPOnqxlEvfqTdLGzqOqavgEWMFLLGyZtGCkBUbVdwEmLeOtJqgcwrCqDlklifG" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *cOgRxwTmWpWLpERnXjE = [UIImage imageWithData:povtTCmGRWkoCgBcri];
	cOgRxwTmWpWLpERnXjE = [UIImage imageNamed:@"toPLJxXxhhlsAITLwHBfZSdoGqLIjeFVpjWzfsnmmltZSDQIhJnVWlvWnNfoYXtUVyxoateJcjAIoWFrMHMgCCcsElFKbByeSNEnYBIdjHlXQoFgWyZMrRWtsKMODYt"];
	return cOgRxwTmWpWLpERnXjE;
}

+ (nonnull NSString *)yBndOfrCJShgTZpiN :(nonnull NSString *)KttPyXsePasVGRK :(nonnull NSData *)yGThACuLFKk {
	NSString *GGYdKrvfXKPix = @"KBnnKYRNzdTyhIeuPMTmTJpGFnPhGNktAsfqNGLzQgtYxOHvndpYkPeYJfEaPfoFyylJOywUiSkoskAihXpNNntUawihXbffpZSbiRylwuNeptxMpZvSWjCMwQHnlYTcw";
	return GGYdKrvfXKPix;
}

- (nonnull NSString *)JhklupIERIEFL :(nonnull UIImage *)tkmTncIIknnKzY {
	NSString *ctSKjxKJTYWk = @"eGQBSeMlSOuOsVFFzTtERdIfnXYEOOIVxfGYyvtoqAGvzKHKABpINKzLksuvEkmxoMbZzcrvWxBSJzSzuMZcNVLNbcqSzXOkzOcjrDUIdXekxGrWIbSqlesgepRhjYbL";
	return ctSKjxKJTYWk;
}

- (nonnull NSDictionary *)lIcmfeBoNRuhMBv :(nonnull UIImage *)kDWnsztpoUwuI :(nonnull UIImage *)uSkFLTWNanDETtp :(nonnull NSDictionary *)jnbEtuBFOBQBnjE {
	NSDictionary *fvfyPXiTKcYsZglkV = @{
		@"cRnQHABRWd": @"XDdYlsSHawXpqlSWgNjPWdXTUgcSZYJgyZvknYtvGUoymHQARsMdncfmvZCmkVjteIEXNGCMlxTkFVXDdzvJWXNOuOpqqEUrBmwGhAALycGeJRdmAVMhjHHTOXXfSTMGuHzi",
		@"mHvxcZRyripkg": @"FVUTMseKiEuWeEWUMDGyrGuWePIgQDVqLETYPvTgROPbjuywLEXxyPZGZoaetlnDmbxkXJeAysCzgZcfWpIxvGOobLLeHGSKnerBYOQpTTXMXXcvREffzkuKIdsedk",
		@"mKQbhhixjqpCYYkzHpm": @"kZuDrFAfeizjtiTQIhrsWxkiUQYKfNUyVTGtwYSBcoaYHKNBEvmIDSrFROfMRGinqoZzAJRKOkUUJZcuEebjjeHLtsdVdZEGmFLfrORanRKflJtGthUAtIrRwMvfFGNRSyfusFIuVEqpFHzMhcfV",
		@"satTfxUfTAqDQvb": @"TRSQXgoJIemFAruRALvbaXmhtTUsXjtrleuDfZeIEhmKSnTLCyZzGADgPqNHQdKqObfKbFIuImJGGPeytkYYUAYDTFpGoCGqJyJnV",
		@"AQTRbFToSqtscStcKJ": @"NlCZXYYhFcvUTVKaNsmFLASjlCjDnnATVcYEGRqxbvASZBEIxiBPWhRtDPvwTmFvlZkkuQPqZGboNfvRYuDeWOFIQXFYMFPZdmRR",
		@"muDSDODCORONfMA": @"toyeAdMYCLxUqaRbSRkpdcDgIPQsnDgmARuROwIoAOzoXukNtqQsePmnoXLeEkhEPQbDzBRwHlmbjLHzHdrMCQDKTpEXsewGzjjBkYAlRaMAZWwUNsgBfvqYtwSSIkHHoKxoCvNs",
		@"PvuotIBouzgW": @"TocwrvNNqUSXcHlGFCwrUgGSCgOIohIYHnmOyLnEaEsqDLbmEtrsNOrlFgQGGVBEOsZFfXGjdLdEPBcbRJYbCyFpsuoPmIJICfaaXdjaWNTIwBKrvMXWCSBebBjPPsMpmJhwtKFNxaCiNLckhb",
		@"YwMZnwshPhDGeFVeLo": @"gBFvnuyAcNyqFBJCAHqKGddXkpOVlFhBdlCnoYZaVTZeNJeiOPFIdUPsKpoUpygWWQwkpSlQSsluYAxlyNNmmUZdOyXpzWCClynpAwKYcUlEwktZWMPCTdSRoiaplFctLKOPYUpegvHkXmMQGFhl",
		@"rVFHceDVDUH": @"XgTqZuyEVyhjjUMERMnpSVlSNWpoohWvQJvGPuyLnqwXKbVKgnLwDWeVoNNTbCtCwjdWBRMFszPVopRmLPtAGjtBYHMnneNprPvQxZ",
		@"sldAfhNmDErc": @"jMldnjXtJooMyynrufNABVPfPrtEvPCmcjhUMRSLEjGzyPdIHNCqXLrvKSxWXUlDlItlwmrZgDGBZcvRsOWftzMOIhGgJXKiJQmlWUUEyXOBlcolBwYIUjlL",
		@"dTATSBxclEM": @"SALDdqkjDLxjyRyAuMSgUrVuzWTrAhWylLaATMICSDsSIlyfrZkQCnwHBIJwNPEoViwcDNAJBmqKcRvimbXByEzOPutvkkXJgPfGNJWThNJuAygZVchrdmXwrudtasgyvKYYdKSylsBn",
		@"zQIVuTERwAloxBf": @"VcuwAeHjiKFwapqkQGUnGwbPOhEmeFjGHQvqWBFRcNnoKcVOHlmXBOwEzHgydNbgckmnGYbKOHoVXUUUriTgSwcOaKRRUtqtipAMosQOjdkHNkkoIDXgvAEofkCjXMgvYdNdRDYOcXZqsFlE",
		@"OqpvMpJnvXQtdhom": @"mWiXAZLoSQDIQCZnBZZYJCRCROSfxlPaftthHWEcRbwarPXhoDgtLrbmlywaZPGZUmYJsQWfGJereaajnovhOOVrHcuNrQfIxPkXHIulafgtnPWafbarwmhgfshMtSitUsqrN",
	};
	return fvfyPXiTKcYsZglkV;
}

+ (nonnull NSData *)igSYQvJfNDy :(nonnull NSData *)WrbWxTaJCbfVe :(nonnull NSString *)bOsQQFRfEN :(nonnull NSArray *)vNBMSyfQuUydjY {
	NSData *fatBGsKuxzkMq = [@"JPedNZlrxJjwzQsmVlytdwgQgcHishcbCTUFEXfBaApYxVfvijDoGBcCkchgKrdrWQTDBNAmXaAnzEaPcskRMHkaqLjTkoWXEbWeKiIuICGotPOFvzcoUdDZNpSAajor" dataUsingEncoding:NSUTF8StringEncoding];
	return fatBGsKuxzkMq;
}

- (nonnull UIImage *)CBWUmFTHsWfbBRnKZ :(nonnull NSArray *)kYMBgBdgdNmuQXBt :(nonnull UIImage *)UowoxCbKtKHZ :(nonnull NSDictionary *)tKPDxePqNRD {
	NSData *bkvNfFKOdPiLUeTYB = [@"IOPGuMGRqGCFRJhmIjvKdizCmbSnhtwtjsRRfYCUPjzwdLTCBspmEivZuPHCsVqlVyZZHpbhCzFsUCdaYOAAMZCCRffYEgxPHDhEVIaqvPvbOqVsZLLjFqqJBelkpZRVin" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *FQrfPILUJGViM = [UIImage imageWithData:bkvNfFKOdPiLUeTYB];
	FQrfPILUJGViM = [UIImage imageNamed:@"bWlZWiNNXkMgByWGcgntXUTXopwDwyrHpOOrGrZrnIrxgRgxgKSvusLKjkAlYMlsTTEgBrgnfLfVhXYOtpANQGRKGRTIabvILbJrkGvNEXpnvZGTftbUphSBdoNUlsnkBnLCVfUGPJdbihm"];
	return FQrfPILUJGViM;
}

+ (nonnull NSDictionary *)sKigkFbAbEJ :(nonnull NSArray *)HIizELvnUSxcboUCA :(nonnull NSDictionary *)tbmLHPrVGLdHfTbcVh :(nonnull NSArray *)bjxXiiOGFaXL {
	NSDictionary *iITkExAnJZlI = @{
		@"BcsqxbjqoACmmPr": @"bnxoWHvidnJiSPGKwFGxYVvvJxDDVYSxluScXhNAuUtgnoLIpsMXuoxLWwLPmEbIpPkTRYUzacoNZzNZjrMQeAXvfBrLuQJhIjUOqmyMCCHqGfSdIZRrIEgeELrlKDAJvLwDAvdDtXFVbFOjq",
		@"FJlcupMdhqXNeSETHd": @"RQCjRgXmeXNuMAItShPMlJeCinLFuzyejSRBBqegwoqaDxhATxnhKtBfXdTqwkpRwtEeWBQjHJDIFxCpJDUyDKMFZJZTJYqYfkumeDprmwSjCjB",
		@"urjHIDcXOCbOBppBzgt": @"MioWAUWNDDRsZbeUmUaOPVtSiDZjrEypJjynmmVOtUGXWPWXvkaULOvhqmahKOgrUbEBDpUOsYLMVTYRERbttIguuQqGXpkVPnTjHUTDpualAGDVAdcoMbzAKUQwERORnZgbPLMSWgMMZujTeAbI",
		@"NwEYsRcymoRmCRRflLi": @"KvAloFCfLYYeijQesdSRnpzuEzGtHITJObaDaqhBzjkSiDTboQGqVMmsbSCqzMPaLKsBrjZNmPaYeNBbIbJhDpNEnQgDHRBsrWQvzjzsyN",
		@"beTBrXUicQDmQtFFjyk": @"riZDIRAJCjAGIWCbZvGALVyCmKsHhcdEZAOOwbFoRDuOEKSkPdNKKgRsOfURCAdnZixObtgquKyGWNEHKGBmSphCeYspqiARNlkcpliBSpAABQAqrmJzibHKqeo",
		@"TfAwtjlIJGITOeh": @"BuKPXCSlWoXqOfKeAWnWiHDfUzZltCXTTLpSsYJCsPhOVpdnzJdSwlhTAapQRSSzyfdfKGDgXWjfblIERKfEBJgHdfpZYemRcSEcUgJkwpprNZzczY",
		@"TZzIhSjvwlpherVtR": @"LqXuUDGiebmfYUJQKDdwjhQzMyqzALUUsUJRvwLbuKEwivAciOantUVRgyzPqNqXjUoSPQUKxOiPJDQkWSyNlHEeptqOvxurETPMWuLNcrebnHbNCIPMkpyPmINOqgGRxANJWriKwscLji",
		@"fiNTpOEWezwhXWiLm": @"dvfkyeaaANKXFwDDSBFmmHAOFCzaEHSqVOOloaWaECtmBrJBMFVXsSrAokxFRnjbKSdRCTQxOBuhHccQmISXbRBcOXPeUaidHPBFXqbBvHKQaSHJcPAlAV",
		@"BSGIcigqkIbq": @"WsaxSprBiDUGBnZvhnmvAxvnPXznzNqnMyYHfqcsMXSXQgMQeGSZewMcJvagjwkHkHVYGnebvhqMSvSRXraCIxdOSNEUNGOftllEJqaKwjbIuZqfqFAoWhAkPijwMD",
		@"OahaXEQeMURkxLRv": @"rAMieBOMuecDmUeeBqBWRhRJlDuXppglkYCpqmHClZIgVIHGbPPAOYvMajAkmvzGIxPSprLYzgRQBxNXaXJeKmOVIIZGdMdOWsRQyennjqOSbjLpNSDdcqPLRr",
		@"zYYMaUMhGlEkds": @"CTlWzHXwygBWePMYuKcyXhwFdFintwJwxkHpfDwsyJbDZUcyHfXSvgElojZcsAnIjPFvwVRDzLKVSDkqdMvVLUCrdmPEvszIVrvJfADgYiHPCrasjuBjacfnoVCOtxJUFIHleimmxqirjJTfXMpIj",
		@"VxeiivufBA": @"RcQrIlFrTzeNgPhKBDdNimoWVppBszplNYaMkThndvYvEwEkbgFGWjXDNnMRZCeyAsgRmAHDXjPRginvgHiPudMFhxTMvSelvHXgrWRgfrRgADhSknFgXvGQcLCrlkHzZBiHIRqhjGkIK",
		@"frafWEsvxVFWW": @"dPyvPJiLnoODxUEnDxoGBbIDQYYCLoCVBLPpxjSNoPsnuLfZwEravcYsDoYzotSjhUnQFtQBhdezbVujOomqOClqUddGcCgpYNbLhOtgNJfjEUWBaBISvCdxavdBGShQMPGNEmZAVseYjnuzyE",
	};
	return iITkExAnJZlI;
}

+ (nonnull NSDictionary *)PjmxbHKXOIqBuia :(nonnull NSDictionary *)moOWswYXhouhUa {
	NSDictionary *DelTYcpDOvtssJbjP = @{
		@"untTrCaHSIt": @"bUghDINBBsEXnqcbXKOuzhJJzndQTORNAZexcNIznVvtWdiduBBLeyefpRdKJbqRNEPKscKACgJDjbxThZNiZOPbgYVdYCjAyxUVouMAzSu",
		@"fUkUtZITVLrnHsHGhd": @"AGLANZXdykitMtbXmKfFUtnmcqFkknldrrfVIOEDpzJxGgsGJJJEOBhOaJCYutJijhBLtAiUyNCKkqwnRkECvrjdgCohwFWBeZwyMxUyqpsFvpjiDJQsgjdRiUWZphfSzuUMxeDYwKDiGXskpbn",
		@"mkKIpGNjFETSeBQ": @"phWbLjrFlSvWngpJriBSHuFSkXqHFPFAAwEAAUYAnmjikIGHuniLqpMYnRcpnkyFIaMSRLOMcYndGvvEyybIvIqrHaPZveTRnlvhBrevzWaGqOdHKhNFfIGaZtzzwGCXrReYylgoMtTxFiejVUZQa",
		@"tQSSFEXsNFoEvhjRxG": @"RnetVmwhWODKRxZquYNVPrlGFzeXopVcSTTykasnNVBWzOitZBZzsofgzebkzaOgQJMyAmHmhVUuxHObbBQpcVZsEnvhAddVntqI",
		@"yqEAQWhlCdaVYro": @"aVppeqHTjZPFgLjqIDVPdsSlSdCPqHyweKWOlgehgYprbXNUPIcaJxdTbsZuWDvrcKbkLYvNGEMUVvNeFfrAhjruOVofAjhYHIvocDCadHofmbrRmtLBhJnRkijhiPVJTHuGCELKAmixFGCREtC",
		@"YgKwNfFVGX": @"wRvfMZMNQcimLrfgGhfFhxJyIfxFCXLYnuJqkZTHBiflqgZYBgNPKZlEvlFNeNgfKhxGFjBMARkhwOmdnRWqgaXRaeqiBaFuIRucLeoHIBL",
		@"dSdnQTvhyvFcJwsatny": @"NACPxWMwIhovgXJQtAsAlfnGBrwGivPNsdtIyGlARqOpRhYjnOQzoBHUyAQVGfykEJAzbQZdAetCiCbzXHleCkVQzasToPtOQIoFVkBSuoTvZZFsDzcvdmpkPXCViXaOCoutzyVLHP",
		@"JOTDdAtRPNPQU": @"tkKWHkLoPZOGOtFCqQDzcWVWnjTJTUsScQRQGgQLVQTtRLFiorfiMwpDAflbcsnkqEcMAnNXuAocdQiJSqcJoozuJMSsdcCwueWPnxmuqvmPCwTmHDKpLcIQjaJNV",
		@"dtmGnGZGmlMnloLNQKn": @"mkDdndxPdWoZlRGHjxmhwLOLVnHZnWZnYQyQDBYqBieYSUclhPBxcbFBeYrPGKERRfvChmoFZJaJOhzgufDebCkOWdoqsRnvslbIfTZXyWaqDOUfhftsSfQpCYqhieOhYjMzbC",
		@"XzMfqoxSefGfOc": @"FLLCkbuhfXIuglhOzgwOtnDNKOARYbYGYWiEnkYFZtoeftpdttPcnzyNqvxJYSWbEQumsMzNdhldybntKfjrKMQRNILfjuvLzESSVk",
		@"pCNSDsoHkBbBJjtlKMh": @"QPFtPhDYWHQzrVnJMRhCYqSzJXwFvsKovWHNoLbgfNNhIbPXFzLLKsStEOlOKQLYzvXuggRewxRlJPWApgPetTMEEkbtzveQiyjGVupzGxiupbsJgJRoAOhrpFaZJfIoRjJUczWSl",
		@"MMtbvVXXSD": @"GkvhgWaGebNfgmygTABroEBXWlpOXeCuXvZzVhUDsRNoSIinsSJfRHPwRDHEqkFJxQsBXVZQiYmwCYWVDIKEZyuStevnjRLjXjAjWLUCNhYloZGbBNxyahFkArMUWYrJXrMaOmIC",
		@"lAtrSKazTblPMM": @"wjCDlUITSeFsbPBhmqjuBqIKUuQirOPFlJIlmJaivkPmAhVEydwavyqVHwnpEaKefvQqiWHychOJWgAVgDfRUzSGExLlVATQaeJKFutuBdZXY",
		@"FhMcGJjTstrYcm": @"nUlDRBJCvShpSGBuqUNSPFmaXMbSuEXXFrYtVqhzBOpJIZxNjNHFAKdqFXkzNwQCeTPmBVufNGDUqOLfVGUHkJGsrLotSlPoQsBQYQutWVMuRlIVdzoT",
		@"BqMgUGZNkeNSD": @"rFBJJlmFOdEMTzcTODESBUaBOfrmjGibvBWobQzEalRadpteOsmSLKkfhfqFMFfJVmKuTKhaYUAjoKSyvFRQClQEhdIdwItQXVwgBmQXuflIVfQiGmUAcmYRQLPDJYGstzisJnuhXtKIdFe",
		@"AEtQgKsIFb": @"xTwbhQTGolsdTwYSUBKTyatkeVcbTFIKFrHvqXgniAWVbBMpPhivBdEaDcaZhkbIWHTWPCywTCuDJtSxnGJgZSRqMCJZBmNNiSbJisecaRAYlHGZxDhDXqWdiKdPQ",
		@"mehXSQqKYVFjdxBq": @"JabDSKcHJeLNGPezYlFcAtdGVowEvhkKRFAjxDOyNnkgDqShFeRCGOuNIrNAzzxAZkEkvovSAtSPeuFkCnHZxqgkgCprKueCCSAbNpmqlavLBErZU",
	};
	return DelTYcpDOvtssJbjP;
}

+ (nonnull UIImage *)WTfIBFsNkyXNdwZZbE :(nonnull NSString *)hwjXKZewFhRnyWwyeF :(nonnull NSArray *)xfimSkUDmwtgBB {
	NSData *DZPxLjAPXtEMyBYYgD = [@"ZRfeItIXXIfgZasuxfNkOMGGJzmUjOGCmqxKiYZlsdyIKqIgkhmXVAnGEOdBzXJoQFcKNgyqMALUFPuGaWyEkJZYhRHWeZZZPVraHdzYqFSZodMTMU" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PwpGxLplEduG = [UIImage imageWithData:DZPxLjAPXtEMyBYYgD];
	PwpGxLplEduG = [UIImage imageNamed:@"wEzEGZgxSwYqfCQZBLSWvNqEcTfZYCPLhKHXbgvqaiMKEloUwADNoCmQLiEpexZQTellymtwjCZrtsrnRJGnSbjmFuXccExsZqLfeWAEXCixqyj"];
	return PwpGxLplEduG;
}

+ (nonnull NSDictionary *)vfnhUUdoZBUUZbRbA :(nonnull UIImage *)aCAIwxbvrBncdapsWn :(nonnull NSString *)szGRTmsQsjdOKQujK :(nonnull NSString *)qyQAJeqUHpfTGATzxkX {
	NSDictionary *VXZebkaUBmCEnh = @{
		@"hAtcXPPKIkPdfyZ": @"RlSuDeUwlJxmgNlwQrEKZUCxnIgnQppVPpgZRcNoTwkQhpGCPXZErCboKAkgPdbzwPXgqwNUUNNUONeHBHqllnXSyysAKWpTKoxQuGWXYPUeecFnWoaVLZdsAxtyD",
		@"bfPkqHtFchC": @"XUMIcUtAdxUiDctDjRvqbDtwxbNZHNMZFbdNOXNycrcMgsVKKJbeYvQKfDhTviyFEtHqMSSpGjnDWVjDCLjMAhGRNJZirvoBfoWURQykDXzJstnLrprkxcENK",
		@"xwOjFZXoJTtY": @"JQupYayrNVnLbNZIiRFXOLmFeGERjioPVyalgJLgiHXyzgrlbuensSPCzzMQDzDZpscpZxLdGUzebinpIwhYiwreSXVlZlZztBOJGkdcBTzygyZwOfdiR",
		@"gTCCNiRgSLOiCRXNCYg": @"APnNESBkaVHNpNiHMpTuSAvvhRitiLQZFpvELQJNubFsKtsTgijyWSYNjggtZGrJJbeGUFEWOuOiKVNcGttDFvJsZnTlzGDbukQNyUXuXgdqANHuHYxkckglQFekITrGtzcvprJLbdJvSQ",
		@"EYvJmzPxkHw": @"NTTdrNVrFPEdfLnGmHEDjfQOrCpxmenJPublyoJWhiHWwQWUNbOQntGmslMDkIwEzWkAlyhNOENHwqOqARUBKJJjJhbXIXSbhtmGkNtHtNsaRIfDmSSOmLngvpFgOV",
		@"KBEVkfaKVZOgfoDw": @"bMsFKPUhBQBujRvTRLRKpzEwdEzQdULJkHvymNTVezyjUCmAMlvTXHAzhNMoHJVROrUkLlBPXXuodfBPlsdYVYUdzeVvpfWCmiEnNEPsCtkBZIvVmWRZxSEqaqRkkDsog",
		@"hafyGnvSbLE": @"HkfDULpMLDPQcpUkIflgccbWFqAeYnHJIUfCuLpCNvUKynIHjqpnryxywEqtIiwsQmCDXYfMQQLJVFLNmmQeqmfzrPXqNpMGnZczjtyWZuPsb",
		@"lcElyktkFcfGooYOO": @"qkmTcJTlBsOHPdBFrLHFUyvdaUGQRgoowJSNFdavaXjcwvQoFMhKgUXZulOpVrsdUdBqpllYOmTEJSmpPgJcHNTTUCKBpgfLtGOPlyrOPQqjREgt",
		@"xvlIfACEXTwFjxtMBpl": @"hSKqTJLDRuItSLFNOvejmcswTNyKzhMdSLSJpvGXOSVUBuLZfhJBpyqnueIXfJarkdkyjInbdzXapEJUfiutEIFjTacddSHHIFdBeDxIypokI",
		@"StamUTCNXwOOOi": @"mKECXHbYHdlAgWUGOJXhASURBdtrCtsNRZxuOCuVVfKMqhOVEsKreipGegmtzDwQAscyPVGiKrhnDUOJtFmbvefxmsoyZGySwKzzPCHSieKsdcMxkpzINUUEZqWRW",
		@"JhGQuJgXQArbumon": @"hTjVdKuWTpPpMmUcaMXOAloSbygjZwBoeEgrhYJyqGGBjqRzUqFthyxgVhZQVsnrUmcuWRVXIhjVEHjJJzNmNJsFrryEkEsNawSNmDlwCIjfsufGFoftvNBCO",
		@"qmyZZwzCUptQr": @"yuhpoFRplAunHqyZNTzZJMxcYxPiRCSyVlOJvOXwCbnLWiOCYzWRkGnzLvRkkNwOVqIqpoEKwBvFGpEONMPPrMGXGxpJcXGSNBfstmruefpZnmJarNWgfjfPwtCQFoJtnlAb",
		@"XFqsBBPdiDHIy": @"pbJsIoeeuEgExuOvibaHgxiSdKIBDXBHcNRvreoOOIahIQkMqqOmvCLhFFPRhnyzumGRAnBlKFQBBlxboXLIyGAvikxLEiwjKZdbrmRvojZbxZTkTJMBakldqqKhUXsUrHgsYXaHqVlfJBcPXXIl",
		@"fsmtOApFxDZoy": @"lbriOgIyoaNfpboiasMnXXUscBPklmvOLiBoEUbdwvgfGOCDGsVIlJfYlbSElrhdzRlTPqrxfhmwCwPWNSiSCDEUctYxJgNuUNCweGzNe",
		@"PsKXRFwokPhvaw": @"ZidgSdoopExkEkYHNzqFFwQaDGAjdvMokMmWDJFdwLpInpRyqtcCVlQbYGGDprZvLZECSxOgaXGchMjREyyYZySpLfvYUYINVEFIMOJQIFRZSrByCdaTDXmZAhSPSdpXNDZkyaZwbxfqBTDRhHT",
		@"TEywSgnrkkY": @"gENjadYdaedOqMkZrBpWgZAzlgaVlUEjdAyFtSTTYfVjPREgNNTtRUCqUcURvUzEueEUkatVbyVfjdPFXaqOIfjpvjIbFerQZnWIZsEcwswHPGFOLqvOnPWewcExixFUkhtUIBLDZBKqKr",
		@"mLSAPgwtHtxdBt": @"UagdAdUrfIIAidxBigSHXOMRXwumYpBzixLgojpziFjmibpLnqbFelnOLxuqOMrrefoODmlAcTjLpyVBDuvjERPcsFuSYpIjfUBiWhVwascuvxsYrCKwbbrsuHMchDderAmTcfgtQmWZaOqXvi",
		@"GFjdSCFGPRb": @"TrXPNjMPSCLybrviIOBejSCxFYWgbLCShThwgHDIDbknBsvgofOOHEYvFSgwrGiWkTEAtRliaIzkmrIpkVVtuqJwOvjsjgpEWTCr",
	};
	return VXZebkaUBmCEnh;
}

- (nonnull NSArray *)qTaIVyoygiAqbYZere :(nonnull NSDictionary *)RXtrcSfHDhwCWGbt :(nonnull NSData *)gqSqZnqqDPmWrPc {
	NSArray *yvoeKSrWdZKvTi = @[
		@"AOHgiulsVRFpQJZGpBVGuIVFqNqygPdBlTtIZeKLLjsdYmrOxefHAkfquiyBBiYSVDAGDnMaDDYGHofInbkkmPTJdLSBEGpkceEeWZBzwhievyHyJOI",
		@"URyAMltzSQNTfXyzqZRcYGFJLuJqmhoggfxdnYZgKnFQQKcCRsnzsgwiTtaKpUxKGaHlbbDoIKDGGgsNsYYOKZgYsOvPmhkKTrNycMNBMhbVU",
		@"ObeacFeZdFOQkRycNwIvvUEjjodTdVEbUqXSrffxosSYpFuxfbovBKQADsGOHqieaOyGuokSkUJKzYeIzrijitjsLqeYooSPEudaQeFlUu",
		@"lHIYkeFhFCXDPizVmySMnQoGOmFNsPlzpFrsBPLIOPRzwuIdDdEGqfwGwiWhTQpOQOrripPRpKJmjnFGBlTTRVCNRshadxnqKkEkCFRPXudUfBDFprnCDCc",
		@"ZLHaMSHHvNwkTXkrssJlokRdvfNOtGlFLuBjVYjTYUESoIZxFxCPZKrkDCnbjmofecjmgQoMqTiOndaNRZjgqdYEonaaeQmEcJCkRxYfowcpdlQBiIQDUMLJhlVzluKhedtaiDrfdXpy",
		@"sANaksPTDiZliViNPycZASqODxFkaGcjmkHQMvcFGmeWATNCGNkhCyjquHoaiMoYdPvEOIXnHLlvVpDzmggxTSPTKZgxqRMcSYUlPMtbcDgCkZiggwzQevdqMpdtvNHlNvHlOOSbZOtGCRGs",
		@"pEhVXCpZvsrTxIABObqzrPmFFClqamqMjjTVXQZhDfBZeOmUEyrtsIYBIwkOuXOBvRxOsNkaIkENnKruPHfuHXHFBdrFCLKBbxYwbron",
		@"qMflmqkBekSrqvHXytpgAhLcwbTkxEEXQbDaVfxjmzZyAQBkerTBHxsTYjbEkIBJnQxLJyugOHQgqpgrLRSqGxDhawTfCSfkbRnuJODPbUfrCIlGEPUQiYXxMLetBMlQPhgeUVH",
		@"dkTPduLjePvuwKmWjZCwMobOSHjNuiCeryuyucZDpUYjskBVdqwlmXABSjswTVCKvtHEwJHHLmrIXRVxqduazznneGCoITcoguSdoElEfXQ",
		@"jUNwrFnYTtaGYCJkBBxqTUJhEZcppzJNcJxebAsYmzXJtgrdHgSHNkgHMGUpRYdqNdzbbqnqKpreOGVABJIfkVTuvNndMYvgLoqlmBmW",
		@"ABSqKocbcKcyJZZUgzsYKZZEqTlQKfgrlznERvdfAuphbzoxIAWCmmxbPilypdqDohxsFDcOjSWSUALEjvoNhNnscTNPkpnrjSvpGnLvHvsKaeoDTUXMdBCJDyDAUCAnLMpi",
		@"fZumXCtAZsxvkTJaYNRjdZTCBoZlWLZPlzkJrlUCpnCKmJyhunyEBCQcIuCoJzReXGBOXdCBSiIclUvGsZUaDRhDDiGCOnsHXqUXjGwQAvLhjzJEiPGtHqJXaE",
	];
	return yvoeKSrWdZKvTi;
}

+ (nonnull NSArray *)aesEOUThpYaMgsMn :(nonnull NSDictionary *)YNgzLVFsTBATVGaanI :(nonnull UIImage *)xVwtmkaBGOmmkRb :(nonnull UIImage *)tMYIvTWRaltvVRvS {
	NSArray *kvNDWeIrhTbQHHOLke = @[
		@"KHZGmEKSLVknnMEuvjTCxnZnYdksxKbMbeLiHtRbjVkkQmfxgJUEIUCGDVVZahMEjFYvGzsVDQZYPoItvkbHNbCoamCdwkfxgeDkSXABKDQkHWMndZTA",
		@"rmbKbTlTYoPJZxOEdZIHuFfHdHevdWGlyVxvLqYGFdquzilkBTSATCEhYbJtyokHpJPUfPolvLizVVFyBnsZlTCAeLwXVJwUcSwztLCVLdoLwnVUXGkMNuvccGQxMXHMjqzRZaVEFDTyc",
		@"GdaDFwPXEVgHEekYaqcrNVAhvmkSbSGLQfKCKvPYOwHorZrnVUNZURfPdYQwufedKJiEimCbGUVpsRmxwnGIhQmgmjYaBSdWUvHfKYntUIyiTSXxJrxwWeKqMekhgePZRxKPOvr",
		@"IEaFoMBGclFaPEoRehcNNtIMNlGfcFmMZufrkhhyBLnSDKQygHMRmrCxeHAgXivAaUTQSsZihJiojoFvCNGZQQFECuqXBWUUltlPgCKHcoRSISbBGSPvrDxhmAXZ",
		@"AhwmjbqBxAIJxSAZWSxwcBeCXYbrSLbjJIixzcSzknOLopOycLrXsutEDUrhDRdSnqxATnHMPBWvWtHBKRXhGQvsRGGVZnnguitdtJdOUcdwCBBDJsVCVlgmHzYFpwRRGwMLSYEOqBheHsTZmz",
		@"CZvqqrDiwsccyVnGphzFpVvJioGZSEXmijaNwjujWEdQJntFFZEoHyPOMdqjwxXRubuKJNicdVEGyGHOgCdCabMUkCyGOmFiGzCSzqZTwJlhj",
		@"JxGrPXqKnRANEuJWjaExNScezKcivZpGSdReScBZwDRXSJuztfMJgKosbYbKUmRGxzxfiRhUFRvFeGWHXkpsRDYAbymzsCKvyPWMjbrJdeyVvLQ",
		@"PRTxUurdJCXlycoxhTSGNFARXagsHXWNjxPYcaiPcSpwHQUIwlppUQRFaLXJTSXxzjrFJbEGpBLSXAStcFLaddMcRHDcZmybrSwUOZbtxGUldLPLaUEwzeGDCLmgjGDKdbqEZJYKTvey",
		@"PEJjrfGevJOLxrosEpgFuMNxKrNhJnoyhseycdfiwDHMbRMybRkbLjwHhSGlDebwsyGiVqHjAkSTlfjlTnNPYNIAtekeDwSSesojSUDioKI",
		@"yqrrBBonVTOoyqtTpLYKMzBUBbHXoWoniESMSaLGEldqEKiQWVhFhrdvXPaYyqDHTooxnIBjJDwOCHbCafYLkxkgbCDbkBtGaffc",
		@"SavfbXZNHfJasrfUVxNlxPleOaBzbdMllJXYBiRSfDVNmCQvTHNeEbJUaspUQxxdoJfkrpPNUgJCKOoOmWpkudgCqBhcltfkclUzhOmjBfoGeRhAWODFHrGXVZjgyFzOlUfYEpentHZuKEWjJzBv",
		@"zNTEenHRLQrdAQJfxqXqNaSGudjqiHomMKqJfMolBfTfsdrSABMIgJdWEWJJCQcjmKzIPVNwZsWRstIYtLmeoxlFaBFImrymZvflitSvTKQirYMyKITsyPeETsqCizQdChjzwIzDFz",
		@"vxCleaYRGXZhenoxXFTctZbhzoNbmSqkbHeDTbzPpttXjHduKUiQjenUKjueQnRBGEzSWxWDRGOqIvmWtYRSEQxoWXcVtJasMDTpg",
		@"ffbHZFzLXVrfROScOeLlfzbZRuMurHdzmGrvAnaIdbNaecNBMBFUHlMkBvOquJJSoYRcCHOiVMyeEaFCQbXrmUVkqKFZRjgjovBJgGeMPPzvXXXUJonPQLVIntOekbyFGmeOPvodz",
		@"SBFbJPViYEPTPqfVRfkJFXwiLryDpbzJzRzqbDkGjprPJQBahCrEGeshuRWgMqVbCuDysmDtcYaUosPouHgflxMuTwItoLddDtYlgmBzpy",
		@"IAzpxZSiHLYjeeXPvaRnZvVZwnULYWmMogYFoXbqCGONnYgZQVMNpWTwrMposcwibpPjZcgGqfONwuyWfyHtTrZcPyLGZmEyXLBslYwaXmihqqXntlljDCMfghuSOglpepYU",
		@"QXGOBrQIVYvhnxWDTJnAPzIlzoWcBkMGLDkaXPPvzPJyJHDXFkFgZXzbgIoNLhSkzACaBiLsvbzBAEYqxZRmtvyAJrTKtWQXvjIfBRPg",
		@"yHYZHIYJShxqoABeglJTruyxwWjwLqOVvygFOiZoFTXniyhWaLigPiWcokfCrRkHDaJfEvlNQEmHZrqbrBQyEaeDjFpwxogxqffTQOrQsnyjXYcJgaAEEz",
	];
	return kvNDWeIrhTbQHHOLke;
}

+ (nonnull NSArray *)bIySmDklddhuhU :(nonnull NSDictionary *)YsOmEjFiXfbYbOHixUK :(nonnull NSDictionary *)gWHOdusTZtOmIbFYYLr {
	NSArray *gDmNfbRVDOEQsF = @[
		@"hLafKrViOXGjnYADoJtdjGfRTwmlCLMLbHoSYhfxOymYyltXlnvKRyRvqcCjhQcwxiJGTDUYPWFGKpVMzdmSFBvpnAIzoQZHwrpFkvSCfDhCRykIIn",
		@"APkHVuTWFknBlOwayKvGLUBfKWgqmLMpjEYGttOzMUMDnIZRoSeweZyRhObfmsjCRpAuWNzVexcyvJRmgsgmYDPdScLrFkswEOEmDAruovbhkWwukJEXVoLVLXIxFoeRoirsBctXiATQevGLhbW",
		@"KQXofNVGFKiSbAAYVfhVZYvCLgZyDdPKRzxosdaMKEugJrvGdkmJBJeGaEwTqoaAZWGLQxxVYxJkPCrKdzeDZjEeEOVLEqeUgVCfBUaSdZPWyHmVhdyvQEyFCiSzLrwbVZhXTzVGvUOrnSyhwMD",
		@"vehCiYegDzhwySXOLbunKdDKBlYdZEpSoFiBvPPBkSOSrvdaSpNsSVbyhdAAazaCGrhgqhWnYNruWfAqokYVogvTglpiVLbrmiybLExpeUJJOglyWWwHAgQzaaTUyfAwOiZdEzAUQFSAHGQKv",
		@"CIFFqmOzeyjPZRGrnxducWPGcoNSEOeKQVTLYwjbjyFQNGjcIIUywuqJCMRBFIvyunbaOPvIinzjGrqWtccsBmKtPXgsrLCuYgDEOpnPlNZsVeQLBWUhzZPFOtvXZaovDlyxOsLorYWuHyqFc",
		@"yDwiVDNksjcjiESgVZdHmOkaxgPxQLlJHjeMqSvlumSQZafPUXEgoyCeTnBMBNuCVMsOwlCfFgCotJtUORKDTegEFfJmtGpJtooCaWMrwZbgVFbNykgaWYjTrKFTyjMjmOdlsFyVtDX",
		@"HAAriuvUcckKLuKMBAiUnKsyLssHYfNvWZxhOXxoOfLmGuozYrPxafgHxjULhsYWGNVlmqiwgfQRllPrprcvZbGgnGYVdfnzQyBWbZ",
		@"DFXjDRACjktlMTacNhMLiFYiDMcyxPLcShfjfSbqDRRmpTvrXTMNqUugVhQMveYpNUFxzYRPfwzFXlSYjgTWJMWmCdiWXBicKGtIggSvYJUvcCTvIXAebkpPxVRsB",
		@"TXZGpECglOjzMWKjHYFvGOGCCUwJKCuCLqfiaZSLsiCQvqzXNfYWwpNkKEfcpFqUBzLpIbmhhaONdJGvpeRypjumbPSZZsxZTNHmmSbOiwvEkmXpteoBYTlBAniIRZnOczgre",
		@"SCpUicSipKFwLIUtOkNiaFNPuQxRYVyWofVeHDDchDnKipPBUZwDuOdBcnOXgHApgllYRmQfxZXSlbMZMLMCcqhHdKvmzptkqVFquSJypDUmOBsHh",
		@"iEncOCroSqUVFVEvFayBOZbMqVjxkpSAprpzPkcRNPSLranidKZIcZbpvKRLKFZSDfHYDQuVQeeuGEXMNZkzOQPSOzuZkBamzkHpqFTPStkOEYcCLpKVwoNtvIRPU",
		@"UrSUDlZemgObOHuHHWWQqZLgHVSDXDtaCcxnMMbanGOLlQPJAhSSMwDIIfvhWJBAlRYhmocqgJELwrViJCzIQzWTHWpYIXurXWCfHHFBeGqqXkaXkuJRHmQdcAasYqurxcYFmeeIevnFK",
		@"DaRWKiPcUvYDpjmZKrZDdTonBwWFRyXrLsxwudBIGxearcBqnqmAUDfCggJKUsrcfGHQnloSOqAMkKQlniwAIfXidjSTrbpNcKqnNVqGHbiWPNUyQ",
		@"wyaVKZXbsMfDNBbSReKJfarhwOczdjeEXeOeiPQmNwKeHXIWifHHnuhJtVYBbZWiEmMdHjDTZALpsjFpQFhkTegoaoJXOOPSrGrcpLf",
		@"NBnnpuhoysrgxiUSTPRZWnEqpOuzCnIvEsCVDSnbzfxOQcIejUJnuUndEcKLsiMQcsDqIPpTaBrfYntdRpAoVLFVOaVBMEiPUAeqsxhCvytjbeKTTTsatKhsRUfVKYjLPQnteWa",
		@"RtZjkWAGDKkRGaXBVMJThJrPHdKzrrxbmAShNJHnaAnguwCCLFrzDrWNHEPfoRLrEQEfKMjWjAePzpfqNrrqWEazYPRVRbCIcqNxYirfNFRrex",
		@"UBiLeYlQHybpZEZZJumPgLejkkvMzzowPROqeFZcyAgsNEYNvwanSPRamIGWnWJeQMUPMXtiRonzpxRDridreAXexcsruBJMXyHwmqCmlnIcYDZRzHrhHmtfl",
	];
	return gDmNfbRVDOEQsF;
}

+ (nonnull UIImage *)MeaquaEVFwciK :(nonnull NSDictionary *)FDdZBrMsQJTi :(nonnull NSString *)EiXDzYjKxymLQlPu {
	NSData *IUjnLRpKJgepat = [@"jSCOdPeyxodzedMMVmVXblEzkUYtKxafXbLAwaGVlOPsNrMrSqWGUOpLpVpFKPyAPpoEMNVpdwLTEALIVmyWsCKMGvaCsLUCtkGcnawjlEFEGqUuKjzQzPG" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *moXCKujhiVgecMDt = [UIImage imageWithData:IUjnLRpKJgepat];
	moXCKujhiVgecMDt = [UIImage imageNamed:@"YcANILtIMNyMmzfoDTePfAMlHAzqNkOTgHeztQVkRoCbFKPxwGcJGUGENopyGimvbXkqBaCausjDlWRlPAVlhmFXXzbtGpIfBteljQZlP"];
	return moXCKujhiVgecMDt;
}

+ (nonnull NSData *)dULjWIXPIoTF :(nonnull NSDictionary *)MEUAURGTdyK :(nonnull NSData *)ldxErlsmSZpAFO :(nonnull UIImage *)diaSqPrrTn {
	NSData *SwiIDIEqSoxBtZyW = [@"ejbhfXXpgVWDrDOzNQMXFjplCrAPVkEwnFMSstQBuAbnJZrFrKpyMYbwMMNbjGnnHWiEqGizNqaSpUAWANezQOjDbFwPMZojFhrZGziMnCiQHQKGRBmvLP" dataUsingEncoding:NSUTF8StringEncoding];
	return SwiIDIEqSoxBtZyW;
}

- (nonnull NSDictionary *)DwCfvWaVDSHFHxgCrbv :(nonnull NSDictionary *)MDYbiJEJIY :(nonnull NSArray *)fzYtbfFAsGP {
	NSDictionary *AzNRysLydt = @{
		@"TvDKNQZqcMzfcjR": @"mMudMibmjZLoShKZjaUbrSgWOohTVAiSOjbUoMaZPgqRHGfMjfsvuyMxEESQzohaxdddTiAHEndlNybYTCuuyUwogJlIjbrAyOIWYLVuOwMeScLqmczKZlGQprrQPOLjRHdFjTRBQRMp",
		@"MVvnUSSSKYrrQQpgU": @"WHxzUpomadaZeOLVbapsVywJiZqVCxlNBqoYoxbuGAJazMxzWiUAzPeFPydSWmDrlAZFIrHNBQpyvmiZaprDkfyqJDPPvsXhUfWbumLTJKPfWeMqWJgTHXBDXiajensPgmsazVGosVCW",
		@"vOuqKyqyuuFOQTAEnAq": @"HabbBKMiZqusEurPsWEzglaTzLkEAGbwPWXCAHThHlvlfKbqcaKaudcnuMUQgLkGuQIcCpIiIQbfTYHsGYTvHDMteFwWGLdbhKQKdChjwh",
		@"WlyBwLtFaIyllyVotq": @"KKuKQxeGoQirFymBFlyWldqBgomldIXDKlOJgdJepMCzNuuANfbzvmqJNOhaDOBpxIKvzjLLycoEpnnCyaTnBoWHqKBmTPhLKhagAHrczv",
		@"CCrcgsHyHXuX": @"SHdmZRYkDrhbyRutoKgvZCFaTGCxwUsuXMXgmHkJRfJitUUQrEZTViXYFAllfRqHXPfvTVIcmgklaueWAZjuuIlwadDnwtuElwGZWLfAyuYSqIBLhnnYkVRUYCgEHhhxXVmSsfw",
		@"rIExPEboSrFdfOt": @"EvRSqsnquzwPLUoROCzNCyfSwgRdQtzePnaRgLbYjRFiEOuDKQbzOvOlNsMwILGiZuSKXPbqKDhXhRxoNEzimqadLEoGfiuZzLUUIjxMmjryMNzvxRw",
		@"wSaAHamvWGvvl": @"JhvvOmtxpYxBozwxGZPjotecHjdfHWKnwYODzaKoWTLTeSCoywuRVlQjNzwSUboJYAOZiCVfoYyHuUMfGWDbFJYRIogBFzpmBEYrwFdjkcYeDAHamgjZUNFXHvbikaORgzMNkBZonNwBHxMAI",
		@"CogycIzsbkuqzFkhOgl": @"WYSmcBzlIzLrnFJIkbYJHlZRVxQzkQwCuxgexhmMaHDMhsnwlcmiHvRBtSozeVrLazsEnSJBGsJrwxZtijhtOUcxTjFBhBMMRBCpfXRQuaeeOKBToKQWCVQvRlYWFgGNwcvnvEFYggcHKi",
		@"aduBYjmOQWCjXeCULZx": @"YUjFnznobwZxrwHFOJJfUpvVkZHLktKksRYTtpGCEWZtPjwshczjEyvPdJwcXxzaZMhOkAIOIGWZEvuGvLoCzoWyzhcVkuEFVgFeXDfIjlEjiZsHKb",
		@"uxxICcqgNeey": @"JnWUwMrMrXohKjwXnHCrnOVxQrvHGtMVYzPtxmGwnaebDFQrQoyLJfCgraneTCkHceKpqenXwLajhNlqtkuRdVwRmcGtvCOcvNwtHXNyltWcRLzuCLYOLwfGnfGMdjdEQORkCL",
		@"cLNfCOSBqErp": @"qfNtkeZUkEVgbwRVBFMtHjQQdbKyFeSAnOKASCELzUSnLDTLSmaobUVxIykDOhlfkDSLNmLHlqrMirdWAIndSyKbKsjWXqyVFlTbQLXhyfUpRnzXYEnd",
		@"TIdLEVmNLpVvlsTEy": @"fZAIaRYVmlbLjQHBrHRrWLETJiLQydIODYAXLmbOfZsvGkzcLaaSPLlQdewspAdzTHioXNdjXlGuDawOEukXvXtQndUHQZPWdcVpqBODiZoSraHURRRZxbHAnGnRqpGDOJvQEB",
		@"VOcgWUCWLi": @"tmijjTVNAdDOdPUGiDjtFNtfGcmyhihStiXIvthmcsiJpiEwtZsZuYCGJLdqmsAwqvdeYUgFiiHUJKhwvDTBXTMhmkvcKvQOBlhMmVMEhoijkOnLmPvYo",
		@"oxVdIhaTnFUFL": @"yFOyyiLmEhwroocYiuJrkVGzqhhGXPZgKoqBhLVQBtPfKczbcEmMLVEBqNoqSXkYhSxftarOgcByuIyCTFInlADtIUtXWFTBPuwLTouxYgDfmqnkdKHFnJcVjctpaETjcsIQlEVnkdmgryzsQ",
		@"IvLUqpIGUUIeXzOSO": @"iPiDwFhhOJHQCyofmyvlaagwdRYahdWeKhjauVSDisowudnaXXQfsJnDvGbDTewFnFQbJNpPAjnmuJXqgSAsTMRqpAFeGXcLtJCAdJehvNlwIVEBnaRKXpfXQmWfiFxrYNOnOZpiOYNRNK",
		@"iVwvEKiywlEbh": @"SApsrGBhwluwgBVvhfwQqYBiycOaGPlcdUXTdUdAaajwxhXrhIkbUFXTHyAKWSWMmZwyUQaEPTrvazePHoqKJuujcdmoZwCMJcGLyVaNjvqYAvALuXJdmAUfOcdRlRuGyAwwwUnuZBJFaIBMrRtD",
		@"BYthQFFAkJQnSh": @"LsggbkaPAfPWxDgtBlTznrocGMeXkzIuBMlmkZXwSXHkudpLlUGRKwXXisTFbbBzWoHRXqZjpLjKnGuNNdngJtyGgAHQSMTowqpwcVHjdUnJjNySvBhMBOtWJUjCFjnftWVXHwKftzIW",
		@"DERygwgLPhCSE": @"eHlDuSOBYFekhykulcwtJoCjUviBHnlwNPYXLjMGMoJDplEkkjFkdfZYEKwOcIgWZpzzwgWzzDrrxntaurWQAQxdtgKiCsPvNTytxkLJgDDTaFvOhrqIEDNPdrsnkVSuxcmAcH",
		@"ZsMDkrpJHf": @"FfkTJXFgPlMSHPQcYhjVwwfcAYbXDIzpMDfmzMeAvXeKiuXFwJGaAZsSTwTjZkiWyrfUlbDmvyNNJrTmuVBojlTAKqRmRghiXEfhCcLGfyRPxuGGMcrofevOkEtBTeRSrIVQZIDx",
	};
	return AzNRysLydt;
}

+ (nonnull NSData *)smPiRiikACqvfqrQV :(nonnull NSData *)SMfhizHKdskOePJgMS {
	NSData *PTDhhzrQziRw = [@"RWMoAZvVVceNeCgLamFsiCZURQaRrZtpPYudzyhMhhioaborbDJaSUuBXcFlLRCsxyIjBtLZcaRKpdgHnISJdGmmnsjfMFyiJVZyKCJTEKXwmlkPqDpOTJpjPumuUfFGDtfSv" dataUsingEncoding:NSUTF8StringEncoding];
	return PTDhhzrQziRw;
}

- (nonnull UIImage *)VvYYDkSqjVxVy :(nonnull NSDictionary *)BqcugXPVZMf {
	NSData *lLelCFxVMI = [@"yslCKZdgorvDqIlRuDuCkeKWDdddknxEANFimlTqUPrkQiBkiKtrrzLEfMVIoVpmUMnokJdKUYXYNvtAbuXVUDQycbeSxGUvEkYBa" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *oQDbZKNHhVWJc = [UIImage imageWithData:lLelCFxVMI];
	oQDbZKNHhVWJc = [UIImage imageNamed:@"aqTfkJTbiNFIXyigEEuSzDodvQMALXcbbTYlEtCzlGCcRiWHSLDarnWffkubKyogRtzutOjDLywizKMJRjHjovTOLpoAziTjgRBqeivgRcJcgYrxTSrvdGdavPWkIhgCQtZtCOCqJopZcSXJK"];
	return oQDbZKNHhVWJc;
}

- (nonnull NSString *)yjrEQaBnFzglTTOS :(nonnull NSArray *)XlNLiFsJyznPAIWAIAC :(nonnull UIImage *)EnySPGFRKMwlokfYYq :(nonnull NSString *)tRJsaSnLDAwYGvCoO {
	NSString *XNotEmxEjBZTRXYKr = @"UimJBPQiXDBrUzRvCiApRIyKDBKwmmYmUzLQBMyRyNBcsPcrLpnuQuYFJAkpKwCTqtFHGzSDhsoQZHWjeGqOYGNfcAaZukLjYjnoHfDFrYnJtNJoLeoRdlILczr";
	return XNotEmxEjBZTRXYKr;
}

- (nonnull NSDictionary *)TzwaOJnEpdHcUW :(nonnull NSArray *)XlmhmmuXhSqil :(nonnull NSString *)MKlWmfFQJppmMhdvTY :(nonnull NSDictionary *)AwCBqSKbDBkZhsw {
	NSDictionary *TkQBcYBPFSREDZdoNok = @{
		@"RwMqFmNaHGLKRPkOuv": @"SwEgJmETHBqXxlaghcOeLppTwiuTPnLFVhgzevHPMYkbqsvHcAFbTkbSvbZQwhRSlegNKZiaLvPxaDSyiPrNXpInPIUDlGJPYKWLXDqscvHpjvXGkwjWsjSzsLQMpWArAUeBKLmrVxBpOCFejkZ",
		@"PEeFyJNHAi": @"TKCRGeEcQasDoNFXdCzAEjgTcneSNXZkuoolhEtYkvmCXvEforlHQgNNHIYbZwphuBLJzZvOFcGtkXXvUdkSVUmdlxzxHIowKFtvcrPiCED",
		@"lvOiDapzlEpQYPLod": @"cjAchyBNQrYLIMZMPvLoGnVVvsulStSSHoXBTzqHxBUwsWmhpaUzsJRHRumlveHynikewgLqDAvpVtxFevgKMqyrGamTzQgLwZmmOyOcPQDoQqiqEnuGDWaVMIZUXovQbkvvGdDmreZTbHfF",
		@"nzuCDaYcnwhqNOI": @"rEldoAlusNBYGcSGOmKGlwSNxHYvnPDqOtLzmhiunfowPmMBNQiGzzaKotdkURZHoRLCkxtuIsXNQSCctsJAJloeyMMekcwGOhtZTrVjxbUYwKvGhTDYznWmtnTCXtPJvkwIfsktCtxozpAn",
		@"hJKPkavcFGdFbQ": @"sdOxOwOjrAtDeBvfTZqImwAgqducBCSbGkbHpgkZwUjWRdwvgiMRAhOgNOpnWceokPiMBiMDUltXCKAGyLdbTiZRORhbDHdtjRrBWEU",
		@"CinedmhZklMrZWz": @"ScHTRbxPWiZxClMdMcIaCcGkoiZcVOjhgFZeFeGsvGeStXwQIbtNWRFAVLVfzVyHmSFqPYOrZUcJekTUFcNwBLZppimWeduaGlqEkygedDHeTErqQDtQnUcvAuDPyuROWWkQ",
		@"AaFZVOeIlVa": @"snmMbtfxEjHIuVmwOYiqOKJtaeCOitwGzOhqWrxXoPJFUtecXckbPHvcFseBMuejDaBpbhiNwWUIGjIKzkKZlWuMwMuMDLSjpKvXUrSBtvTddLyUWacoZaHihWqqSWrwwFKcXeKeMQA",
		@"akbkDnGthXa": @"OerKrveyJBytBbZkGYKQCBxvVHYrDPCkQXzUplBPrxTZSIdjciDZNqSsVQMSaServWtPtquhwgQvlYiZtDCsMTQEMqeFDSCUauvhNGwYwsRLRdfaKWSuJZa",
		@"ZeHyDNONvtvreqgy": @"CNOxeVQwXtuyWZSYwrurDmHWLrfNIlJdJRVHiGtbxnYjKtWmiAgQgpJXKsSGrfurpDnQpVTiALrrOaRZjomUvZspjdwpqJonBfCJHKMKDBYAlOSMBOfLPxFqxoqoqUmLwNhPfZHVfjf",
		@"XvCdkaAcVJTQIy": @"EmOkBWWeMVseiSTFbbgbAFIyUWEBZRSOZSJddkZthMQuMSRAsddqxXLqsMsSzAPBqXRfnUoscNpiuozZUaLlJUamDPdlRpTNkUXxRnlxRQyERypieKGQzICzXAjh",
		@"DQfwlhzDwHO": @"SDWINnZsHrqsPntKtmdOtpnBUbuHaTnerCUySZcnFYzSMitGnpsKwPZKpoxZssTbDMhlAOXknPfTWqsEbrxgJbzeqlBydoZAwCwgwomOFWywmINACvvbBUeiuglvuMxq",
		@"HlBhZcICnYvfshF": @"mJkXoOyiJVjXHCrdFZHJnCxBGTtSppDzZjpREOBoNCkbjSbmtAYbHPNzbAbjYpWGUdnjQVLShpMWchkJySXGEkyTMHNEWfrwsjdugyPWQuIaKMLbUpvJUEIaGKRGKjUqdqSkNKNYEA",
		@"IutvkLQQNpmTeVbpRz": @"AzdntPuuhFNGIqrMumRjEjRBscpqHunzUtrKetlQEdPMsePhsudfbkDHYZFjIAGrURAKsdtGdpAMxpHLWTGOxfrVBviCkVrAWBQrDjyUOCWhDyxtKBhDuyUCFFnGciJQGBuHKG",
		@"fXCfulcHCGaNWtgZFEz": @"rvQukXfIChMfAOOOlNlsUhukKpSyLiqAxQglKWDtQShgEuPPpUNLzWXslIIVeeKvzgzuOYdnnNCKbIIAXifyqqrwnTsQAPrAmBYGIRddlrjjbSoLC",
		@"WqFnAbmoJdIAin": @"jprFoKMJcwQRMlRdSybnaFAnieqGDusUCxcmKwBsggNUVcWbDmhNXziOidbCJeCqrwJPJOCjNoireVqTKyjlwOCJLKHEVXUZijdnSgZXHEXdKAHcOzGPpXlOxGlfzTyTKep",
		@"MvOVdqhfGxomNiYAOA": @"ygJyVmZtJDPfItmfpvNmftgEUutjAWypWyFjnhmPPVfEcSTzejSyvzXybMcHKqEQiwzNUUwsNhISKxKiRNOMFucfrxGnoaUpwUYqeTrOxabjIHxNzqEEjCSYIRsdHhyDFuNdbUCeCxQUkwv",
	};
	return TkQBcYBPFSREDZdoNok;
}

- (nonnull NSArray *)bzAyvenNitvHhCZf :(nonnull NSData *)YsJFMNaWKnr {
	NSArray *oCTIPFIqgIqROLCnaHZ = @[
		@"QifJHoHCeYZEozxwmCtvmTYmZYtlNtgqtMqyFTMOYWLHmHOUHbKMPmoOqYAYdhRqiyJNWhzUlTKkkAjeRATsrPtzgYlKcTUINlHfsYFVvjzIWpgkfLwkMkzmsFxEiotYuXozBtwidbBjkWTDWemq",
		@"uDFdVnjybtalJeQurjGzmwLQfbalthiaRZWFdOJBPgpDnWjzhzGSbgHXHSweLgFgpHTykHuHJHnEnOhpEvZTUbHemUlhiqBNSBjsoGgyBEVzBXJuooSGZkxKnCcbKJMhe",
		@"CYYrVFELTXlqFgFugWqCTOJUbGzeBTmvuIwWZuLLkWMkwjDRutADZIUhvqwLKKhLHmipxqSGcxiQSOIksinBgcpNgIFyMcTXNokyhfMXFbXhL",
		@"PxpoWGNGMcKMNGWeXhhvfHNftwJfkkEaohtaUZbxoCdDTuyKMnbebKOAIxjTGAXjujnRKohoiQyyVEitRLhWIbzlQMHYIVXwaTwSIgNZNbHptPjgTNsqsRIjptEOwwVIIfhSXfLcE",
		@"jdXVBTbFLPybQasYXepdgGZtuYCwOlYntYYyLzNcyYNBLfGcJRUvSMYfHfkSGyqZRyXqebKjbqwWUvjDxUWbrGAWFqXEifEyGYIHvsVlkNZxj",
		@"EVdvhtZYJTErTfuMydTHxDpHaWFhelrFCsDPQNkbUtqfIXsYkQRRLeLCfZYYxypqMlcuQHQmfxsdhqukQoPJEaqhOTHgEFXAPMKrdFkFYlTlBsImx",
		@"XHiNvomFqzMxrrHIJZwdJQDCbYdOhLZjlncwkjDUsWzrMgVZeGOpjrzcIOQeJTOzKznxGkiRHmiTRLbHpOvBZuITEXGTmNOotuvwKqZlIBgIjvOgfPuJXdHZIYWUwqLYQdK",
		@"pGEByGakAAzXGFgeSCeXinyTLvJdCaUAHBOzizmgrysoZcJPLgIweGAExAcfWHBwGIKTEZcKIPCSdZnLUzwYQuByGwTqnwXulRRzATopnshweVFOHCxHmfotYk",
		@"jhRShoYTdTPViiFwkTTygOAsylLgnsTiKSSvnureCPuujcRmnwnyNdJwWDQpXrXcJkFNvLWyNBomUhYFMAWToiEaeCvRLKCTrDHnvHFQayPGvqnyFPMiVDzHrmyFGSRTwoBbKNyuAeMK",
		@"lvpPCTeXPGFXblyZsqNUXyWpEuOPFpRktlcZakZKsNjmVGdNimUjGNoNSWJDFbSGJrvXBTyuPSylNgGNUCKveIpyWPzzHzljQcdEAAFNIcnNwfFRBsvXrrCTZTPQBnWjh",
		@"jBCZMiWzHzQPSjjuIKSdPmmBWDOTsENDKZooGzYXTfQcaEeyGXfgilhdImNmvFaspNbTMXSBErAnHsqyHikxIIecrpKuUVOdjziPnQitYaKHagbqlpYYiCiHmUDfuazzUldqMRXvLaSlzfX",
		@"JZPmlcijlhqskdnOdqAzYFzVBDWQWqYXoHCxnsSuavKrcYCLLvYenijPvdZNFtfSSHrcYduZUuBcqwXgLRFqqMteaRiIgvZOzdvjCoLKvBZ",
		@"eiZMUmLfhIOUxdZJunMmigoZMWmXkDBiRoPMuEfGlHxYZsAimfgUsbHgiZDPycORepiuXXaxoWdTTWMoWBqSBbTWsnxkjoEPvQdyPPtQW",
		@"lEvPDrNFadCkJLPaIbgExAVzOwVINabSgjanJvQXOGeIuUefCKiFgvNHGIAVVDXEKZkzgwYTcKBqYYhhcuCYmjvGqYkKzbtUhZphBprt",
		@"JXthbHwrCEtTpxXjmYwYdoEGjNWCTVPKvMERNtBsiEghKMmdityLYBlBehRSvWpNFJOAPMplJWYptSntzgFZLycDzZCDrRStlgVfKvMW",
		@"LQTnYLgzCrxPgRqssgfILMDcsTAyDbUrQmHAptxEXDwgHThieMHsVYwKxrnBHcjpwCdIkVlmQeEVxHozoeaxEfOXgjIYVUPkwPmWGdWKGsDTTHJeculd",
		@"akbZpFbUCTRTZvtTZnDefDOJgnfWTSMmVMEvInwYIZEYqSUGviFKxnBoPxMzCSCfGzHskNLJXCxGQVwvqyyysIDyelNrPQjzdEuBPoqiKNLVUQEiPQkV",
	];
	return oCTIPFIqgIqROLCnaHZ;
}

+ (nonnull NSArray *)MWfOVCmmmFswgKJVbRj :(nonnull UIImage *)dJrBmAHCvckVCksVN :(nonnull UIImage *)atnYjbZDQD :(nonnull UIImage *)lhsAtNkSTsSmm {
	NSArray *fSbuQojqFYjdYRdGw = @[
		@"KXmDstLhaFKBmOhwoNHsZlFsXnfEtpchENLOTyonrtWZupVskwyTRBcfWidVYcsTPDjaVSJUxCgdTrYigcsrVSrRyUdatNjuLqKRjluYapjrxXtDhkWDerJZDbi",
		@"ykiEbNgPUnoqztownmMNbFRGiLwmUIQYeiwUmIzepZmzFODTHvRSnQwooIxCYHtBznWEEAIoBTRyTSxPLRfFkoFLlEjZXYucWmWxW",
		@"znGSlcRAAPNboMkqcVttQVZdrcIzwuIzaWmHTsrfKjmcsAERayhDmTVOKOehakopIewNRwPEckuWgbkMGmyelxnSAszQhONlLJBgWefnhzTeIZVAGiCMdTeajLMIa",
		@"jhbEvKyjyTDkBEhKIYjcjuVsZEDiytBeizMqOFCLgEAyYdOxyOhGziBuGRXtLnlSMoyQfrTqBqsLbuAuvtPjJcKEGUfJAssyzplAQpmZThmRyhvpAaLnwyVaIeQhzZVayHTJcql",
		@"gbHjUYsdvWUwqIHHkpUnkmpTPVlgjScXlUjpqeXXuMvIARvLfvfhJepuvqpHhciwWLEisDrfouMHdJBGCkGughxuMXXOljJjGLzhddbVc",
		@"sPWRROJFaciwJkKJUYCXNdqstXekFrqXGXrzwmhqPcMsVqOZtyuhfuFAxzYoPcZrQsddesCcOKVFskKTZfOmWMxwGejEynvbMrgJWucHPmeDPfhubsWdTLrrSfhSfPQomYSFifj",
		@"fIuhPrMKeDKMAcYNHUdlvjokqupoppEWCQDxqscCoVSBYaQKIAOZePSDKoyfbTLrMrUJFOluxfdFqhlqOzQrnYqbEpulmBJSpZuNEzEZFduSvzmamUovjVCjxVBenphLSFbqq",
		@"pVyiIlhwEsbpyhNkvyWrRXPmlJzWghyROEmAQVKuhJrCIuyTqvZAjlTbrojvzURhpGCpIHkgRRaFUZzUXMeipWcVSnEqMesOFsAYixZlWQjHG",
		@"XHyuozAeaFhIlgbZywcctNRHJyAZExhhrxmXYqbvUaYnixwDBOPGklUsqAEpMiZLTRZthyFHMdnBPSEMGnjfGOGRVNjQJIiqsfscNABKXwEfuMXPSoSaHeqYPOPfkhIpCHqJoQDbnqDDApkx",
		@"mTyWOCgWNpYVKASFJHfmKVFmztlmhSOkuthupgSdYOuxwnqOOGzsZqJMFJuyEFylawGAwqDsvGGMxvlnCdSrTRTNjiDIpxlYhYqOVTws",
		@"QpprxWHXtGQYxGMQlSdpKXeoJrTyoObLYMMUFPKgVvDvpUjYLBqrlpKPWUHTOekcFhAludjuBAyRjgXVZxaofJaNAqYPICehNyyRWfRmJnHrZkdAcwj",
		@"oFwNHdNaFXxsApuGMKAMzCcJDjsiwiRnrkeggaVgNlNBJBeGwvyFZZURYajXABdVOUCMJTTqrlsqzFglaygoRVKGylUbAScjWFTbNXznMitZIsWiedovNfbbpXRwmIvTcuIOohjmcnSPKfQvzsUh",
		@"FjafdTTrwQXtBQjFgLvFfVMpoPhZBVRMLMJLwkXmmRyPkpsaqFWNjPudmfJsUYbdmlxogVktSzTdgLswUBGLkbYDAgPbqxwrsdzIrWvVtWEGGfSuOwfscKpQzkjHNoFXdXU",
		@"iCXkVEzerTtDLEiRkbaPtVActevHGysbPQSVcUphIaDkxrIlnYbJXuzrtnGoMSCQkPcMQexzCuMgbbLxcHicfsLbvEAOeORZEewZrKigyDSlYLD",
		@"ujtzzTIdxGbcgYtbSNesfTymEXrldmhUCXgeIUizUfSVqvnMpgwJWZlqtAEvNAbfPLMbFtbjtHTVvrfdxDOOORpfwDmlLtWhWeMlsjmqhzMyMWyxFYQvpEVZBRzGIterFyGLUPdrYCFFB",
	];
	return fSbuQojqFYjdYRdGw;
}

- (nonnull NSString *)zdFpotUfPQwLovnj :(nonnull NSDictionary *)ZMrAryatgiPcj :(nonnull NSData *)JaQYizsZrglbZCZ :(nonnull UIImage *)VKlqcGUbZmmz {
	NSString *HHbPDLnAQzypsPIHpgO = @"MzxerEwykhUdbhyrqTFdXWzTGJqqXtYmyunVViHzchlGTVVhSMAivVkLmaivKeqlqOnzuOaifNibRCMMkbHGsmiUseIqyWYouHDkSROTCjqtkRKsXvvkImqwXoyfLuBjAjmgejIDRRR";
	return HHbPDLnAQzypsPIHpgO;
}

+ (nonnull NSArray *)opazwgDZsOCzLxF :(nonnull NSString *)XoLCEpNvXimZi {
	NSArray *PDiXniRvymBC = @[
		@"IMcgupFKZtqgZyzjdlZyDQLzzRvTXZhMGXurOozkllzUiZTTwPBitPCxCltpEQGKDIFOApHVReIPwabQQkwNlSzcNoXWcpiocbLcXLZQiCGdXssEMJbq",
		@"uwsXHOFzhMcdCLBjcRJxIzJTYikXkxjHmkehQtWgeCwrYYPtaxADUudMjGIfQUjesRIHFTHAPAipXFcsjkTqSSBzkBbJWzmNNcWHjRcoSVwnzTUQaaPIYbEQ",
		@"HcowXuXCWQqROsTmOACqnlxcZGCXimAJOShPqkTwoSqRzScthFJLdhSPUZQTrDawhzcCbzEmIGhvTmLBSRYzBtWERyTzTCVuLswGuCNtiRhZzCcaRRVyiugVUzdflWKcsBMilWTG",
		@"ZraUiUVCnpLnbipIXvRKkqEQoPSOfyNIikunlVOQYAzNPPzufExwIcgbVjAHDcivyzfmWKtzHxXVBHTaOTjYgByvNDOuSmyVWzBEsrxvGsZNjkHqVwiYvf",
		@"NXlpfEDjrLnETLIIvTpPWAxSJqVVmjdFqrGZuIfnfyAeXhEexAUVlvQRPYhgUuUNIGFvrAbvDKPrBcITZrJHVjUzOazxccPxecuhCfVFZmQdIGRHeDK",
		@"byOMTyXYXgUHxYPSVzJOAlchaNoIlBqCRtCSSQEuDicGjSXLKYqHGQduYzyCuXJDAtsaaxDyakaMCwxIIUrvSMFtuJjMOXasiggvUlHZrPvbpOrkIVVpPIMtpXXAURPLVVZqOtUsZClIg",
		@"eMSXFiJWoUwTpQSvuREqYQLvxxZJoHtXyORHUhUvmVdbJxKBIxCNbfuPcneUaZpidrErSbbUNbXqNNDxHzBAuEAyyIldpFhJyElhrVWPDgltjxHL",
		@"HkQFymHvSHmiwNoSeVyRjlUzfsInjotXcQoCoeZonuxJDOkZFTiuSuwCYyXVugJBffynQwzLpSrcNchYCuZsAFmUJTLiyeUsWrmIgafkCTVfYcrlGgJQGlEWqMWwaxA",
		@"XRyZynaSlgZCbikyBzUCsLdZOmVQdNWgWfTVlAxBsKNJqbHcExsAnqoOvAsBtyNIMHaPtdSuxlAAPGwulGNbnwquZdDtSxKCYsOAvKwYjtcuAQQAoIqqHXssXjJnYJzOSIyQVpFVnxEMMZ",
		@"oXCONmnNiqvrXMDXQyJkMYTBCctACETPHOcaWoYbEkPLvmzFjfjVBfulohFDfZHsDEVmaRXuljPTvUlkFCOrfiiHJIcyKLELXbzC",
		@"QuIQPsDoUtTVlRAmhmHQkcbkfkCReqOanJsqTWpKYxRGbGMiqfheOuiyRPQxZtnUZBJwtjPdyBfAMSCNRbteMSqEBkaEQzaHkcnnTnsxUmQecmAnSOrRFfwUFEtnnRbqcJLETXWxaHgtp",
		@"FZHBgVIQCNrgkqPZHSLuHjpqjocKpnMGcVoJADXSIGiBFkIvICzaygoWrgbAPFOKcFSFjwCojtADkfuhwjuROYMcclXJYMipenZSGvZHCbpwZqGkSoGWSLvvFVLbEjCcxAKYQgrdVaBighQWBIc",
		@"lhueIIKsZJyfLLZEpuUovQQnAPBDCKKbTmSbgItHIZQguKWljoWSnkFWhqNLwlkMmMSGVRTEwNrACyJNxUHcMaRRcwSWMVmoOQXIzOVLxZCcPOMuuTbCmlbRR",
		@"YLSvhkJQPpsvdlveEMSvyqWZrhDLnHKoLBKgVhKhMugEMYdRQaqxAyMkcLrWUjVGUGnoWAsxWNciDPuondVGGpMrLFbsvGUJeAnQkKAHEnrTVpIXeWHkickyhqDp",
		@"CFmvmVNAfszTmwgsoasAipejVNKgbIdkUcKzKffdqaGsYRMULCXmgFIhwEYYzwkOaywbUaImRzbfFZcaIsEseNTErcygCbSGZFLoPmMRTNIMKDWZlIONOfn",
		@"wUwDVDqvJPWVIrSJsdkYfoytipGZadwHJKmIWvghTIlURdHSQIlyLYRiNOKDmbSfFHAUmfGDYYXZYZhgeSAkrSDIZPaaqfGGUmwFmxEShQ",
	];
	return PDiXniRvymBC;
}

+ (nonnull NSString *)kQfgslyggR :(nonnull NSString *)npTBidfROEDQqPy :(nonnull NSDictionary *)cmSjPmQhbGPdnZt :(nonnull UIImage *)LkQOmSxeyEGu {
	NSString *gSaDzaXiVkeEpvqDP = @"ofgRNlOpVVnqobvCiLNyUFRdSTNQrocIVTQhSxeUZMWxhgBbPiVDxBzKGFVtdQYftxOwywepDduFNNMkvjrowHPYlhSvfTMBBzrNLdZSlfekXgETxEFOXHFmQbrzuyytRJzAtumfkRdJgLkAcVO";
	return gSaDzaXiVkeEpvqDP;
}

+ (nonnull UIImage *)foJwhQiJfyfORAjGB :(nonnull UIImage *)KCtDfnjnrNlBO {
	NSData *iouLudwrVYGYBgQyIqB = [@"qdXROwTawPgNKBBxBDNiXGBIqiKdsKWurrfslFsaTGEtzhTUbBEWWfKaGiVctaPvfidlcKBxENqQtxqvfiPOXUNOQJEahTxCMebswNSYnCtuyVuXglwsXtoywuyGfYoppYvUlzi" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OKevhUHmMPM = [UIImage imageWithData:iouLudwrVYGYBgQyIqB];
	OKevhUHmMPM = [UIImage imageNamed:@"aEEzCPgjhKIyudwCQHOscUTAbHnbofxZjflbcRrVFpmjJERvAFORrmZsivQwkWgvAQqvCVwsEfivryMUXLLryQbgwwcDGTzPVXzVGnzfFdIYtdQmzfQCjbismMopiKIJTmVtStz"];
	return OKevhUHmMPM;
}

- (nonnull UIImage *)BicdkuqShYiylZt :(nonnull NSDictionary *)nSRSgwSeeQZTvoT {
	NSData *lqHhemjIKkVdFa = [@"uSpXeMrlGrjFjZnsVcluTeIZLNAGWlTsvKkjCdFZxAcjbcqbFIXxVvEicvpejqGBPIHGCwnLZLTCvdbMSrjMPsAgSeRPNhRnlfvGFzMfOxEaEBlsFBGhCRDpjIjTk" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *SQQhJLajCZKTqVc = [UIImage imageWithData:lqHhemjIKkVdFa];
	SQQhJLajCZKTqVc = [UIImage imageNamed:@"IWBjNrNTUNoFUwkPyVxgGVPLPTnVqfMeWRRNQLanQovprsZoATYAvhLpoLqqHcuUuUvFGIiLJTxtxCofgrdXcOHpOdvLjzSgeTULrwFBbi"];
	return SQQhJLajCZKTqVc;
}

+ (nonnull UIImage *)mHweJnMSeesMzc :(nonnull UIImage *)YTwsGlsRidcltzXoWW {
	NSData *BAAdOkoKflLE = [@"fcRMyZtsQXQQkbdeacwFBqtrtJZPtsAXJCFmBtXMwyLlXMWUYMzwIVpFSvolWOxLWgYJILrqrUhGhJKaqZieTmnJrGDGAmbFAJTBVQqmsfk" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fioabalrPx = [UIImage imageWithData:BAAdOkoKflLE];
	fioabalrPx = [UIImage imageNamed:@"RmdAcewRGDOSnMwUILLashUnkjdGdiFlVYhWOeAMsjLtnOHLgSISKCYyEiylTleAatOzDDbCevooRosVQlHpHfwZMSdjxGhjGREwEWlAPGhcgetfbfzlSWyTIQHkiXBtLVgysIgDO"];
	return fioabalrPx;
}

+ (nonnull UIImage *)mCZNZGAorfMfi :(nonnull UIImage *)tcJLflOOnHtgOqK {
	NSData *oDPGHbiDxNFdRQhpLH = [@"qMNMQZfmQicAMnPSHdPPhiVljVVoAEljaCzdndugHOojRNMMLOnUYkGGiLjFQYeVAtxlgZZJreIZchjVpMypIteHoqRpRDlcndxYhUBgbmvkzLQzwlLFBcObjNANKfJoDpzSdqCWgoEaBhXCPC" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *gTKXxyNHrofujLUUZ = [UIImage imageWithData:oDPGHbiDxNFdRQhpLH];
	gTKXxyNHrofujLUUZ = [UIImage imageNamed:@"kYWjzNvqmManeLiFvKHEblMbMGtOsWaMmEOstquGBmVDLEeCArTcTJmmgmPirHHegTPQXQVDUqwKRJFFNmfEMWIKFnKiFVwJrjYvgmXSTzKowULtnJXHOJronQZVkBxpy"];
	return gTKXxyNHrofujLUUZ;
}

- (nonnull NSArray *)rlmUPfbyGnOlmEjB :(nonnull NSArray *)ZEzprNDGug :(nonnull UIImage *)hJemtjmPVLbXm :(nonnull NSDictionary *)BDEJqCEwnQ {
	NSArray *BgKykewkinQGWbe = @[
		@"aMUpGWhYlrqqITRejLLEaVjeiWAeUvvKECcCTzhrJpUdfFJHTxHSBmNXPvySnMVJxbmOObjuCXpEngIJMvzhpsTwvBQmIpJnSnuicbXQdVrLscXNAn",
		@"AthtcAZyGBpJnNOUhantndRpIOUgUBoOhmykelWQvdVcGuYBWpMxlaWtnfHeZzrukmAVadIfSBgQoaDwwuzBVbcMvAneUziVVwiCzSAElNooqEobOHnYlLSBsL",
		@"rnejwAVIjfIWvPxscQdGKzBfbiURbImzylErRNakfzMvaGKiONYmBBBYqdbponTymKpwaNBQdOUsiwOKhaIFFtvdUfenLaYTLJkIPSqpFctxCwWuiOqxtDgcsbXcsDDfS",
		@"ZdbKRwYimCFxpzMUpUGNYILJtjwuujXXxnEAUTbfnXYDvZbNxYJzamqSqvViOsRmgtVQkwSXdfHmXTIycwRsoMJkcLIyKQilCIxKwMKueextbHrbjYxtjtkrEszlKetQ",
		@"woAuZGpcOQxJVKFCzGiSSqDDmShdgXYqbXBnJxaWUFfmCZhjbmZeppKcCBskNMZEyuzEJGownLhahJIcfFxwHmhHvJSpNLRILDQQkGokgQGfleajHQsWPLsXqZrjZqnsogPNriBUZphzVamAu",
		@"FtIJKHlvVxaBJNosKbIXuNVMiXVNRsJqrCQObAHxatOkjwmBbfjwmUYHmwDImSCEajhcjTsTmlZbpURDDSnwzBQoXgcnGlmFUfpSxeX",
		@"itkvRfEfIIMhHwJkenvbxTVkQytIJqCIkCMCtrJlPuLtASKwFfTCeELaIEuPfsRoKWxqjrXQBHwfQYDiPepDtDcqKBGrIzNHwagKfdGzbBnDAVvHuVqdvEzRgmOiaabwVep",
		@"iJTPeFWMLUBllbwaFZriHbmFmKdaGQJcBbgAEzoaVAbBaOpAzEmdcwzWRQIIUzzFQXUIZFbyTpBeNaLDiJLBDoUXEfYdXhFYdvxVP",
		@"vbyilVgPeGRPANYmMRJBoByVuFVbUkKAzATznieHwWOAhWdbFCHaqasbegHHCbFUVvWwJXanicJBocVzRluKQttkmPBijunWWbzKRUjnz",
		@"TdHSINqWHWqJTqiYgbxpwxENtUBJSwPlnyeentbvptHDdFKlziWrdVZsFodXwsdPhsxhuUYANaTUyEPixdQWgQqCGseCkmzdGOCmACCdZcfZcOHYhSczyAxWFVo",
		@"WcvAJUKvYiOWUNMfxDFtmjQvdnUGYoghYfzMfXOcSBlVZNnpzGkTYNvZHUTDLVNWUMkHcmiMreZajSyYtFAYvJfYsQmlDVErPaArTgG",
		@"evVmQDsqLlTmXvsSyZsJwdEdRxGnDItsCZbkCiGxvwrlRmOFoUfQiCioMKjJsgOagBMHOPsrGXOVqKGXmoZhnIMeDDEMDvbTDHTbpFdbBHqWFceSHSvduZLMxkYyvaZCNBjJwFTwXsGgbohHHW",
		@"VyleUyYjhjjdrHnzHuiQxEynaWpUuYAuMMAxANgWblZqFmbPJvJoYrLIKmZlgodWrYaDPpmOWbUxlfIvXZxPRLeKjAknHIKhoSrMgPTfLhgRqOBOMpaccYhTyYvkERqptVOfpRY",
		@"DmtZfOHxeAbaYxQSTIOyTEKcMOdYFdTAEwggUbndFgsQeSVEZnsfbLfWgcRKvIFdyouDIqoDyqEkBFgSlHmSInVjffCPxFXvYwIYanfVpLzqrNmiFdXuOqhtLcXSyJOJNPS",
		@"GlTtxLBkmvvlUmqgCJlUWtJxFvkDDNKHdlcPCIyLwwAASynRTCZmnytvNQtlLgyrSzdkaxjRCcTLbLbtGagSPYOexnuBeWzHmEDWrYQdmrzTlXjrfShWJhLagZJrPt",
		@"NbwYCIQItXozjdIfSMxkLZiGeiTPAnnmmihqCsdXndNCiYTKtwvWAfTxaIGxHmtYhdltqhbdfOycRTbZTsuUzbxQHYxjkGMIXuwdnF",
	];
	return BgKykewkinQGWbe;
}

- (nonnull NSString *)XGHWNoRTdLnf :(nonnull NSData *)HLlywNvhDUwvo :(nonnull UIImage *)wjYmLXyfcVcn {
	NSString *MDdKkzDAImMEMjEvsaD = @"piZjvxPoeHXIkvUATZRbubvYvQmpGcpFBeqZFAklBNmLxuCCnOUUqiVTsLlyesONkiCZXdaNGalLDaqgAlCJuiUXrqgJjSSGoKSvQbFpeCyuSLCTlXpAfEQytPsTGb";
	return MDdKkzDAImMEMjEvsaD;
}

- (nonnull UIImage *)nrCCCQzqieF :(nonnull NSDictionary *)seqRDwZehX {
	NSData *rNLzPYlWZoOuIC = [@"oEwMSQfkVxQvvhmclsyUqKHmATgBORHFQzFjyYwTpOwlvDuyTuNgdYpqryxTjiOyYPSrPOVQeKhGjiPHipqjOjsIXnwksJuSgUNNpzAkmJnJhdOeWsydjqcZIR" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *XTDWkfzMQIXM = [UIImage imageWithData:rNLzPYlWZoOuIC];
	XTDWkfzMQIXM = [UIImage imageNamed:@"QUkVrUgwewHzkzbSXyQPpjLhkRnpXrAomIkjZOXdJnCtLwnbysobXPAGxjgGedwxsEvcjBWeHhNLYjkYffdhadcJjgGnqbZDEGMONMJXlVVLIGEpsktQqABFSvsCWjV"];
	return XTDWkfzMQIXM;
}

+ (nonnull NSData *)wGZWQqZmItVHWSixpZq :(nonnull NSString *)psEVnRssfaGTEVgnO {
	NSData *XBmUJBUaXlIJmK = [@"qrdlgZgoCCgHjdNTJGjYVqsWSnrjTavyEgcdSWjfNcDiTClazybhmWdypbJWhvxNiETbSBiQywvOwGTNjuHGpgpvKlVEWJADVOlFeESyFHgEaH" dataUsingEncoding:NSUTF8StringEncoding];
	return XBmUJBUaXlIJmK;
}

- (nonnull NSString *)dtLLrLnZaJA :(nonnull NSData *)YhYBqjAdFCaFuJwbC {
	NSString *IDkotkqzdOFoOxr = @"NxBNdncxEFOtRVWIVhBEoDHrNGIfCeEAUMDPgJFWfiVveTsMXjmIHwxZVWZKlaOiobGArvbgYMnqisxaviOimGrvNWcWbZtMalDDzYEzFeBAJtVjhebChHtMGwlFdnXvnBAotb";
	return IDkotkqzdOFoOxr;
}

- (nonnull UIImage *)tiwroDlhbjpqGjP :(nonnull UIImage *)eUiERcaOJKgvJoKBvm :(nonnull NSString *)iKsrGNVTDbWVXbTH {
	NSData *RjsbmRaOGDPRUIByiZ = [@"tynIiOxSSuZpAZJVVKlvHnAQmWbxDwEyZKIjZkppaXuHlsuSuFfWERiBNHOBknOegEGxAdznhvlHNGIJekXPQQgnqoesyRZQbHeDW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *cLyioRKXTVX = [UIImage imageWithData:RjsbmRaOGDPRUIByiZ];
	cLyioRKXTVX = [UIImage imageNamed:@"dEeUadWwnPHOaYeTkptgwpkVOBuOyMWexcpztpeWyFAqXAFNcTmiudfqipXLNZtXICYMuJiLZHszWTiqWEnjCKEtEkfDPhgcwQsKqKRVRHLQxKORObKRyC"];
	return cLyioRKXTVX;
}

- (void) pushEditView : (H5CourseModel *) model isEdit : (BOOL) isEdit
{
    MainWebController *webVc = [[MainWebController alloc] init];
    webVc.webTitle = isEdit ? @"编辑课件" : model.title;
    webVc.isFromH5Course = YES;
    NSString *header = [MainUserDefaults objectForKey:FileServerUrl];

    webVc.url = [NSString stringWithFormat:@"%@%@?id=%@",header,isEdit ? EditAudioPageTemplate : ViewH5Course,model.ccid];
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
    
    self.shareUrl = [NSString stringWithFormat:@"%@/nodejs/h5/5/discover/course/courseDetail?id=%@&zttshareId=%@&audioCourse=true",NetHeader,self.h5CourseModel.mainid,[self getShareId:[[UserInfoTool getUserInfo].zttid intValue]]];
    
    self.shareTitle = self.h5CourseModel.title;
    self.shareImage = self.h5CourseCell.headerView.image;
    if (self.h5CourseModel.descClearHtml.length > 0) {
        self.shareSummary = self.h5CourseModel.descClearHtml;
    }
    
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

#pragma mark 生成分享zttshareId
- (NSString *) getShareId : (int) userid
{
    return [NSString stringWithFormat:@"ydxt%@",[self encodeUserid:[NSString stringWithFormat:@"%d",userid]]];
}

#pragma mark 处理分享userid
- (NSString *) encodeUserid : (NSString *) userid
{
    NSData *testData = [userid dataUsingEncoding: NSUTF8StringEncoding];
    
    Byte *testByte = (Byte *)[testData bytes];
    
    int key = 26;
    
    NSMutableString *sb = [NSMutableString string];
    
    for(int i=0;i <[testData length];i++)
    {
        int mm = testByte[i] + 128;
        int p = mm / key;
        int q = mm % key;
        
        [sb appendString:[NSString stringWithFormat:@"%@",[self toNumberSystem:p radix:26]]];
        [sb appendString:[NSString stringWithFormat:@"%@",[self toNumberSystem:q radix:26]]];
    }
    
    return sb;
}

/*
 * 将数值转换成对应的进制
 * i 需要转换的数值
 * radix 需要转换的进制
 */
- (NSString *) toNumberSystem : (int) i radix : (int) radix
{
    if (radix < 2 || radix > 36)
    {
        radix = 10;
    }
    
    if (radix == 10 || radix == -10) {
        return [NSString stringWithFormat:@"%d",i];
    }
    
    NSMutableArray *buf = [NSMutableArray arrayWithCapacity:33];
    for (int i = 0; i < 33; i ++) {
        [buf addObject:@""];
    }
    
    BOOL negative = i < 0 ? YES : NO;
    int charPos = 32;
    if (!negative) {
        i = -i;
    }
    
    while (i <= -radix) {
        buf[charPos--] = self.digits[-(i % radix)];
        i = i / radix;
    }
    
    buf[charPos] = self.digits[-i];
    
    if (negative) {
        buf[charPos] = [NSString stringWithFormat:@"-%@",buf[charPos]];
    }
    
    NSMutableString *result = [NSMutableString string];
    for (NSString *s in buf) {
        [result appendString:s];
    }
    return result;
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
