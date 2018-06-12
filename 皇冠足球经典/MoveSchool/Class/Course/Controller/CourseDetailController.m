//
//  CourseDetailController.m
//  MoveSchool
//
//  Created by edz on 2017/4/27.
//
//

#import "CourseDetailController.h"
#import "AFNetWW.h"
#import "UIImageView+WebCache.h"
#import "CourseDetailArrayModel.h"
#import "CourseDetailModel.h"
#import "UIImageView+CornerRadius.h"
#import "NSDataEx.h"
#import "NSAttributedString+Extension.h"
#import "AFNetWW.h"
#import "MJExtension.h"
#import "CourseStudyCommentModel.h"
#import "MJRefresh.h"
#import "CourseStudyCommentFrame.h"
#import "CourseStudyCommentCell.h"
#import "IQTextView.h"
#import "CourseAdModel.h"
#import "CourseStudyAdsCell.h"
#import "MainWebController.h"
#import "CourseLiveController.h"
#import "DWDownloader.h"
#import "DWDownloadItem.h"
#import "DWDownloadItemTool.h"
#import <UMSocialCore/UMSocialCore.h>
#import "TopImageButton.h"
#import "AFNetworking.h"
#import "NSString+Extension.h"

#define TooViewHeight 45

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

//弹出的类型
typedef enum {
    /** 发表评论 */
    AlertViewTypeComment = 0,
    
    /** 回复评论 */
    AlertViewTypeReplay,
    
    /** 分享课程 */
    AlertViewTypeShare

} AlertViewType;

@interface CourseDetailController ()<UITableViewDelegate, UITableViewDataSource, CourseStudyCommentCellDelegate,UIActionSheetDelegate>

//按钮数组
@property(nonatomic, strong) NSArray *buttonTitles;

//选中的章节
@property(nonatomic, strong) UIButton *selectedButton;

//简介
@property(nonatomic, strong) UIScrollView *introductionView;

//章节列表View
@property(nonatomic, strong) UIView *captionScrollView;

//课程图片
@property(nonatomic, strong) UIImageView *courseImgae;

//简介 评论 产品 选中的按钮
@property(nonatomic, strong) UIButton *selectedCenterButton;

//中间三个按钮的下划线
@property(nonatomic, strong) UIView *underline;

//评论
@property(nonatomic, strong) UITableView *tableView;

//产品
@property(nonatomic, strong) UITableView *adsTableView;

//评论列表
@property(nonatomic, strong) NSMutableArray *comments;

//产品列表
@property(nonatomic, strong) NSArray *ads;

//评论弹框
@property(nonatomic, strong) UIView *alertVeiw;

//评论遮罩
@property(nonatomic, strong) UIView *maskView;

//评论输入框
@property(nonatomic, strong) IQTextView *textView;

@property(nonatomic, strong) UIView *commentView;

@property(nonatomic, assign) BOOL isMoreData;

@property(nonatomic, assign) int index;

//间距
@property(nonatomic, assign) CGFloat newButtonSpa;

@property (strong, nonatomic)NSDictionary *playInfo;

@property (nonatomic, strong) DWDownloader *downloader;

@property (nonatomic, strong) DWDownloader *loader;

@property (nonatomic, strong) UIButton *collectionButton;

@property (nonatomic, strong) UILabel *goodLabel;

@property (nonatomic, assign) ShareType shareType;

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

//遮罩
@property(strong, nonatomic) UIView *shareMaskView;

@end

@implementation CourseDetailController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.buttonTitles = @[@"简介",@"评论",@"产品"];
    
    self.comments = [NSMutableArray array];
    self.ads = [NSArray array];

    [self setUpUI];

    //加载数据
    [self setUpData];
    
    //注册 键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShowFrame:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHiddenFrame:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void) setUpUI
{
    self.title = self.courseDetail.chaptertitle;
    
    //课程图片
    UIImageView *courseImgae = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width / 16 * 9)];
    courseImgae.userInteractionEnabled = YES;
    self.courseImgae = courseImgae;
    [courseImgae sd_setImageWithURL:[NSURL URLWithString:self.courseDetail.picurl] placeholderImage:[UIImage imageNamed:@"common_no_image"]];
    [self.view addSubview:courseImgae];

    //开始播放按钮
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    if (self.courseDetail.format == 0 || self.courseDetail.format == 2) {
        startButton.size = CGSizeMake(60, 60);
        [startButton setImage:[UIImage imageNamed:@"course_player_btn"] forState:UIControlStateNormal];
        [startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }else
    {
        startButton.size = CGSizeMake(150, 50);
        [startButton setImage:[UIImage imageNamed:@"01Read"] forState:UIControlStateNormal];
        [startButton setImage:[UIImage imageNamed:@"02Read"] forState:UIControlStateHighlighted];
        [startButton addTarget:self action:@selector(readButtonClick) forControlEvents:UIControlEventTouchUpInside];

    }
    startButton.centerX = self.view.width * 0.5;
    startButton.centerY = courseImgae.height * 0.5;
    [courseImgae addSubview:startButton];
    
    //简介。评论。产品
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(courseImgae.frame), self.view.width, 50)];

    //分割线
    UIView *division = [[UIView alloc] initWithFrame:CGRectMake(0, buttonView.height - 1, self.view.width, 1)];
    division.backgroundColor = DivisionColor;
    [buttonView addSubview:division];
    
    //按钮宽度
    CGFloat buttonW = self.view.width / self.buttonTitles.count;
    
    for (int i = 0; i < self.buttonTitles.count; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * buttonW, 0, buttonW, buttonView.height)];
        button.tag = i;
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:self.buttonTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:RGBCOLOR(170, 170, 170) forState:UIControlStateNormal];
        [button setTitleColor:GreenColor forState:UIControlStateSelected];
        [buttonView addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
            self.selectedCenterButton = button;
            
            self.underline = [[UIView alloc] initWithFrame:CGRectMake(0, button.height - 2, button.width, 2)];
            self.underline.backgroundColor = GreenColor;
            [buttonView addSubview:self.underline];

        }
    }
    
    //简介View
    [self setUpIntroductionView : buttonView];
    
    //评论View
    [self setUpComment : buttonView];
    
    //工具条
    [self setUpToolView];
}

#pragma mark 加载数据
- (void) setUpData
{
    //加载评论
    NSDictionary *parameter = @{
                                @"chapterid":self.courseDetail.courseid,
                                @"index" : [NSString stringWithFormat:@"%d",self.index],
                                @"count" : @"10"
                                };
    
    NSString *url = [NSString stringWithFormat:@"%@%@token=%@",NetHeader,CourseDiscuss,[UserInfoTool getUserInfo].token];
    
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSInteger code = [responseDic[@"rescode"] integerValue];
        
        if (code == 10000) {
            
            NSArray *comments = [CourseStudyCommentModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
            
            if (comments.count > 0) {
                NSMutableArray *frames = [NSMutableArray array];
                
                for (CourseStudyCommentModel *model in comments) {
                    CourseStudyCommentFrame *frame = [[CourseStudyCommentFrame alloc] init];
                    frame.model = model;
                    [frames addObject:frame];
                }
                
                if (self.isMoreData) {
                    [self.comments addObjectsFromArray:frames];
                    
                }else
                {
                    self.comments = (NSMutableArray *)frames;
                }
                
            }else if(self.isMoreData)
            {
                --self.index;
                [MBProgressHUD showError:@"已加载全部评论"];
                return ;
            }
            
            if (self.tableView != nil) {
                [self.tableView reloadData];
            }
        }else
        {
            [MBProgressHUD showError:@"刷新失败，网络错误"];
        }
    } fail:^(NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
    
    //加载产品 广告    
    NSString *urlAd = [NSString stringWithFormat:@"%@%@?token=%@&mainid=%@",NetHeader,CourseAd,[UserInfoTool getUserInfo].token,self.courseDetail.courseid];

    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:urlAd WithParameters:nil success:^(id responseDic) {
        
        NSInteger code = [responseDic[@"rescode"] integerValue];
        
        if (code == 10000)
        {
            self.ads = [CourseAdModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
            
            if (self.adsTableView != nil) {
                [self.adsTableView reloadData];
            }
        }
    } fail:^(NSError *error) {

    }];
    
    self.shareTitle = @"皇冠足球经典推荐";
    self.shareSummary = @"致力于为客户提供专业化的在线培训服务及系统化的培训解决方案，皇冠足球经典推荐聚合了最优质的课程资源、讲师资源，鼓励用户参与分享，打造具有持续学习能力的培训生态圈。";
    self.shareImage = [UIImage imageNamed:@"logo"];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        static NSString *ID = @"CourseStudyCommentCell";
        CourseStudyCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[CourseStudyCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CourseStudyCommentFrame *modelFrame = self.comments[indexPath.row];
        cell.modelFrame = modelFrame;
        return cell;
    }
    
    static NSString *ID = @"CourseStudyAdsCell";
    CourseStudyAdsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CourseStudyAdsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CourseAdModel *adModel = self.ads[indexPath.row];
    cell.adModel = adModel;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        CourseStudyCommentFrame *frame = self.comments[indexPath.row];
        return frame.cellHeight;
    }
    return 250;
}

#pragma mark 章节选择
- (void) captionClick : (UIButton *) button
{
    self.selectedButton.layer.borderColor = GreenColor.CGColor;
    self.selectedButton.selected = NO;
    button.selected = YES;
    button.layer.borderColor = [UIColor clearColor].CGColor;
    self.selectedButton = button;
    
    CourseDetailModel *model = self.captions[button.tag];
    [self.courseImgae sd_setImageWithURL:[NSURL URLWithString:model.picurl] placeholderImage:[UIImage imageNamed:@"common_no_image"]];

}

#pragma mark 初始化简介
- (void) setUpIntroductionView : (UIView *) buttonView
{
    //简介View
    UIScrollView *introductionView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(buttonView.frame), self.view.width, self.view.height - CGRectGetMaxY(buttonView.frame) - TooViewHeight)];
    self.introductionView = introductionView;
    [self.view addSubview:introductionView];
    
    //内容
    UITextView *contentLabel = [[UITextView alloc] initWithFrame:CGRectMake(mainSpacing, mainSpacing, introductionView.width - 2 * mainSpacing, 76)];
    [contentLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentLabelClick:)]];
    contentLabel.clipsToBounds = YES;
    contentLabel.scrollEnabled = NO;
    contentLabel.editable = NO;
    contentLabel.showsVerticalScrollIndicator = NO;
    NSString *content = [self base64DecodeString:self.courseDetail.outline];
    if (content.length > 0) {
        NSMutableAttributedString *attributedString = [self attributedStringWithHTMLString:content];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, attributedString.length - 1)];
        contentLabel.attributedText = attributedString;
    }
    [introductionView addSubview:contentLabel];
    
    //章节
    if (self.captions.count > 0) {
        
        //章节个数
        int captionCount = (int)self.captions.count;
        
        //章节列表
        UIView *captionScrollView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contentLabel.frame), introductionView.width, 0)];
        self.captionScrollView = captionScrollView;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, -10, captionScrollView.width, 30)];
        title.font = [UIFont systemFontOfSize:16];
        title.text = @"章节";
        [title sizeToFit];
        [captionScrollView addSubview:title];
        
        //按钮间距
        CGFloat buttonSpa = 16;
        
        //按钮宽高
        CGFloat buttonSize = 28;
        
        //每行的按钮个数
        int buttonCount = (captionScrollView.width - buttonSpa) / (buttonSize + buttonSpa);
        
        //计算过后的间距
        CGFloat newButtonSpa = (captionScrollView.width - buttonCount * buttonSize) / (buttonCount + 1);
        self.newButtonSpa = newButtonSpa;
        
        title.x = newButtonSpa;
        
        //有几行
        int rows = captionCount % buttonCount == 0 ? captionCount / buttonCount : captionCount / buttonCount + 1;
        
        captionScrollView.height = rows * (buttonSize + buttonSize);
        
        for (int i = 0; i < captionCount; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((i % buttonCount) * (buttonSize + newButtonSpa) + newButtonSpa, (i / buttonCount) * (buttonSize + buttonSpa) + CGRectGetMaxY(title.frame) + mainSpacing, buttonSize, buttonSize)];
            button.tag = i;
            [button addTarget:self action:@selector(captionClick:) forControlEvents:UIControlEventTouchUpInside];
            button.adjustsImageWhenHighlighted = NO;
            [button setTitle:[NSString stringWithFormat:@"%d",i + 1] forState:UIControlStateNormal];
            button.layer.borderColor = GreenColor.CGColor;
            button.layer.borderWidth = 0.7;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button setTitleColor:GreenColor forState:UIControlStateNormal];
            
            UIImageView *normalImage = [[UIImageView alloc] initWithFrame:button.bounds];
            [normalImage zy_cornerRadiusAdvance:5 rectCornerType:UIRectCornerAllCorners];
            normalImage.image = [UIImage createImageWithColor:[UIColor whiteColor]];
            
            [button setBackgroundImage:normalImage.image forState:UIControlStateSelected];
            
            UIImageView *selectedImage = [[UIImageView alloc] initWithFrame:button.bounds];
            [selectedImage zy_cornerRadiusAdvance:5 rectCornerType:UIRectCornerAllCorners];
            selectedImage.image = [UIImage createImageWithColor:GreenColor];
            [button setBackgroundImage:selectedImage.image forState:UIControlStateSelected];
            
            button.layer.cornerRadius = 5;
            
            [captionScrollView addSubview:button];
            
            //默认选中第一个按钮
            if (i == 0) {
                [self captionClick:button];
            }
            
        }
        
        [introductionView addSubview:captionScrollView];
    }else
    {
        self.newButtonSpa = (introductionView.width - 8 * 28) / (8 + 1);
    }
    
    [self.view addSubview:buttonView];

}

#pragma mark 初始化评论
- (void) setUpComment : (UIView *) buttonView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(buttonView.frame), self.view.width, self.view.height - CGRectGetMaxY(buttonView.frame) - mainSpacing * 2 - TooViewHeight)];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.hidden = YES;
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
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
    
    UITableView *adsTableView = [[UITableView alloc] initWithFrame:tableView.frame];
    adsTableView.tableFooterView = [[UIView alloc] init];
    adsTableView.height = self.view.height - CGRectGetMaxY(buttonView.frame) -  64 - TooViewHeight;
    self.adsTableView = adsTableView;
    adsTableView.hidden = YES;
    adsTableView.delegate = self;
    adsTableView.dataSource = self;
    [self.view addSubview:adsTableView];
}

- (void) loadMoreData
{
    self.isMoreData = YES;
    ++self.index;
    [self setUpData];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return self.comments.count;
    }
    return self.ads.count;
}

-(NSString *)base64DecodeString:(NSString *)string

{
    //1.将base64编码后的字符串『解码』为二进制数据
    NSData *data = [NSData dataWithBase64EncodedString:string];
    
    //2.把二进制数据转换为字符串返回
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark 将HTML字符串转化为NSAttributedString富文本字符串
- (NSMutableAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSMutableAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}

#pragma mark 内容点击
- (void) contentLabelClick : (UIGestureRecognizer *) gestureRecognizer
{
    UITextView *contentView = (UITextView *)gestureRecognizer.view;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:contentView.attributedText];
    CGFloat contentH = [string returnAttributedStringRect:string size:CGSizeMake(contentView.width, CGFLOAT_MAX) font:[UIFont systemFontOfSize:15]].height + mainSpacing;
    
    if (contentH < 76) {
        contentH = 76;
    }
    
    contentView.height = contentView.height == 76 ? contentH : 76;
    
    self.introductionView.scrollEnabled = contentView.height != 76;
    self.captionScrollView.y = CGRectGetMaxY(contentView.frame);
    self.introductionView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.captionScrollView.frame) + mainSpacing * 3 + 30);
}

#pragma mark 简介 评论 产品 点击
- (void) titleButtonClick : (UIButton *) button
{
    self.selectedCenterButton.selected = NO;
    button.selected = YES;
    self.selectedCenterButton = button;
    
    self.underline.x = button.tag * button.width;
    
    switch (button.tag) {
        case 0: //简介
            self.introductionView.hidden = NO;
            self.tableView.hidden = YES;
            self.adsTableView.hidden = YES;
            break;
        case 1: //评论
            self.introductionView.hidden = YES;
            self.tableView.hidden = NO;
            self.adsTableView.hidden = YES;
            break;
            
        case 2: //产品
            self.introductionView.hidden = YES;
            self.tableView.hidden = YES;
            self.adsTableView.hidden = NO;
            break;
        default:
            break;
    }
    
}

#pragma mark 初始化工具条
- (void) setUpToolView
{

    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - TooViewHeight - 64, self.view.width, TooViewHeight)];
    toolView.backgroundColor = DivisionDivColor;
    
    //下载
    UIButton *downButton = [[UIButton alloc] initWithFrame:CGRectMake(self.newButtonSpa, 0, 20, 19)];
    [downButton addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchUpInside];
    downButton.centerY = toolView.height * 0.5;
    [downButton setImage:[UIImage imageNamed:@"common_download"] forState:UIControlStateNormal];
    [toolView addSubview:downButton];
    
    CGFloat spaing = self.newButtonSpa * 1.5;
    
    if (self.courseDetail.format == 4) {
        downButton.frame = CGRectZero;
        spaing = self.newButtonSpa;
    }
    
    //收藏
    UIButton *collectionButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(downButton.frame) + spaing, 0, 20, 19)];
    collectionButton.centerY = toolView.height * 0.5;
    self.collectionButton = collectionButton;
    [collectionButton setImage:[UIImage imageNamed:@"common_colection"] forState:UIControlStateNormal];
    [collectionButton setImage:[UIImage imageNamed:@"common_clectioned"] forState:UIControlStateSelected];
    if (self.courseDetail.isfavorited == 1) {
        collectionButton.selected = YES;
    }
    [collectionButton addTarget:self action:@selector(collectionButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:collectionButton];
    
    //点赞
    UIButton *goodButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(collectionButton.frame) + spaing, 0, 20, 19)];
    goodButton.centerY = toolView.height * 0.5;
    [goodButton setImage:[UIImage imageNamed:@"common_course_praise_default"] forState:UIControlStateNormal];
    [goodButton setImage:[UIImage imageNamed:@"common_course_praise_active"] forState:UIControlStateSelected];
    [goodButton addTarget:self action:@selector(goodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:goodButton];
    
    //赞的数量
    UILabel *goodLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 22, 12)];
    self.goodLabel = goodLabel;
    goodLabel.textAlignment = NSTextAlignmentCenter;
    goodLabel.centerY = goodButton.y;
    goodLabel.centerX = CGRectGetMaxX(goodButton.frame) + 5;
    goodLabel.font = [UIFont systemFontOfSize:10];
    goodLabel.textColor = [UIColor whiteColor];
    goodLabel.layer.cornerRadius = goodLabel.height * 0.5;
    goodLabel.layer.masksToBounds = YES;
    goodLabel.backgroundColor = GreenColor;
    [toolView addSubview:goodLabel];
    
    //获取点赞数量和状态
    NSString *urlPraise = [NSString stringWithFormat:@"%@%@?token=%@&id=%@&type=%@",NetHeader,Praisecount,[UserInfoTool getUserInfo].token,self.courseDetail.courseid,courseType];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:urlPraise WithParameters:nil success:^(id responseDic) {
        
        NSInteger code = [responseDic[@"rescode"] integerValue];
        
        if (code == 10000)
        {
            if ([responseDic[@"data"][@"isPraise"] intValue] == 1) {
                goodButton.selected = YES;
            }
            
            int count = [responseDic[@"data"][@"num"] intValue];
            goodLabel.text = [NSString stringWithFormat:@"%d",count];

            if (count > 99) {
                goodLabel.text = @"99+";
            }
        }
    } fail:^(NSError *error) {
        
    }];
    
    //分享
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(goodButton.frame) + spaing + 5, 0, 20, 19)];
    shareButton.centerY = toolView.height * 0.5;
    [shareButton setImage:[UIImage imageNamed:@"common_share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:shareButton];
    
    //评论课程
    UIButton *commentButton = [[UIButton alloc] initWithFrame:CGRectMake(toolView.width - self.newButtonSpa - 70, 0, 70, 28)];
    commentButton.centerY = toolView.height * 0.5;
    commentButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [commentButton setTitle:@"评论课程" forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commentButton.backgroundColor = GreenColor;
    commentButton.layer.cornerRadius = 5;
    commentButton.layer.masksToBounds = YES;
    [commentButton addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:commentButton];
    
    [self.view addSubview:toolView];
}

#pragma mark 发表评论
- (void) commentClick
{
    [self commentButtonClick:0 alertViewType:AlertViewTypeComment];
}

#pragma mark 点赞成功
- (void)courseDiscussPraise:(CourseStudyCommentCell *)cell praise:(NSString *)praise
{
    int row = (int)[self.tableView indexPathForCell:cell].row;
    CourseStudyCommentFrame *frame = self.comments[row];
    frame.model.existself = 1;
    frame.model.praise = praise;
    [self.tableView reloadData];
}

#pragma mark 评论回复
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        
        [self commentButtonClick : indexPath alertViewType:AlertViewTypeReplay];
        
    }else
    {
        CourseAdModel *model = self.ads[indexPath.row];
        MainWebController *webVc = [[MainWebController alloc] init];
        webVc.webTitle = @"产品";
        webVc.url = model.link;
        [self.navigationController pushViewController:webVc animated:YES];
    }
}

#pragma mark 评论遮罩点击
- (void) commentViewClick
{
    if (self.commentView != nil && self.commentView.superview != nil) {
        [self.commentView removeAllSubviews];
        [self.commentView removeFromSuperview];
    }
}

- (void)keyBoardWillShowFrame:(NSNotification *)notification
{
    self.alertVeiw.centerY = self.maskView.height * 0.3;
}

- (void) keyBoardWillHiddenFrame:(NSNotification *)notification
{
    self.alertVeiw.centerY = self.maskView.height * 0.5;
}


#pragma mark 发表评论点击
- (void) sureButtonClick : (UIButton *) button
{
    if (button.tag != -2 && self.textView.text.length == 0) {
        return;
    }
    
    if (button.tag == -1) {
        CourseDetailModel *model = self.captions[self.selectedButton.tag];

        NSDictionary *parameter = @{
                                    @"content": self.textView.text,
                                    @"chapterid" : model.mainid,
                                    @"title" : model.title
                                    };
        
        NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseDiscussAdd,[UserInfoTool getUserInfo].token];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
            
            NSInteger code = [responseDic[@"rescode"] integerValue];
            
            if (code == 10000) {
                [MBProgressHUD showSuccess:@"评论成功"];
                [self commentViewClick];
                self.isMoreData = NO;
                self.index = 0;
                [self setUpData];
            }else
            {
                [MBProgressHUD showError:@"网络错误"];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
        }];
    }else if(button.tag == -2) //分享到朋友圈
    {
        CourseDetailModel *model = self.captions[self.selectedButton.tag];

        NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CricleSend,[UserInfoTool getUserInfo].token];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"type"] = courseType;
        NSString *content = @"不错的课程,值得学习!";
        if (self.textView.text.length > 0) {
            content = self.textView.text;
        }
        
        dict[@"content"] = [NSString encodeBase64:content];
        
        NSMutableArray *newAttachs = [NSMutableArray array];
        NSDictionary *attachsDict = [NSMutableDictionary dictionary];
        attachsDict = @{@"url":model.picurl,@"title":self.shareTitle,@"courseid":self.courseDetail.courseid};
        [newAttachs addObject:attachsDict];
        dict[@"attachs"] = newAttachs;
        
        [self commentViewClick];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dict success:^(id responseDic) {
            NSInteger code = [responseDic[@"rescode"] integerValue];
        
            if (code == 10000)
            {
                [MBProgressHUD showSuccess:@"分享成功"];
                
            }else
            {
                [MBProgressHUD showError:@"分享失败"];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD showError:@"分享失败"];
        }];
    }else
    {
        CourseStudyCommentFrame *frame = self.comments[button.tag];
        
        NSDictionary *parameter = @{
                                    @"content": self.textView.text,
                                    @"chapterid" : frame.model.mainid,
                                    @"rootid" : frame.model.rootid,
                                    @"upid" : frame.model.ID
                                    };
        
        NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseDiscussReplay,[UserInfoTool getUserInfo].token];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
            
            NSInteger code = [responseDic[@"rescode"] integerValue];
            
            if (code == 10000) {
                [MBProgressHUD showSuccess:@"评论成功"];
                [self commentViewClick];
                self.isMoreData = NO;
                self.index = 0;
                [self setUpData];
            }else
            {
                [MBProgressHUD showError:@"网络错误"];
            }
        } fail:^(NSError *error) {
            [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
        }];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 下载
- (void) downButtonClick
{
    if (self.courseDetail.format == 1) { //PDF
        NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
        
        NSString *urlPraise = [NSString stringWithFormat:@"%@/%@?zttvid=%@&video_type=%@",header,VideoInfo,self.courseDetail.ccid,self.courseDetail.format == 4 ? @"40430" : @"40420"];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:urlPraise WithParameters:nil success:^(id responseDic) {
            
            NSInteger code = [responseDic[@"rescode"] integerValue];
            
            if (code == 10000)
            {
                //下载
                [self savePDFFile : [NSString stringWithFormat:@"%@",responseDic[@"data"][@"url"]]];
            }
        } fail:^(NSError *error) {
            
        }];
    }else
    {
        CourseDetailModel *model = self.captions[self.selectedButton.tag];
        
        self.downloader = [[DWDownloader alloc] initWithUserId:DWACCOUNT_USERID
                                                    andVideoId:model.ccid
                                                           key:DWACCOUNT_APIKEY];
        
        CourseDetailController *downloadCtr = self;
        [self.downloader getPlayInfo];
        self.downloader.getPlayinfoBlock =^(NSDictionary *playUrls){
            NSDictionary *playInfo = playUrls;
            
            downloadCtr.playInfo = [NSDictionary dictionaryWithDictionary:playInfo];
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择清晰度" delegate:downloadCtr cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
            
            NSArray *definitions = [playInfo  valueForKey:@"definitionDescription"];
            for (NSString *definition in definitions) {
                [sheet addButtonWithTitle:definition];
            }
            
            [sheet showInView:downloadCtr.view];
        };
        
        self.downloader.failBlock = ^(NSError *error){
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择清晰度" delegate:downloadCtr cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
            
            [sheet showInView:downloadCtr.view];
            
        };
    }
}

#pragma mark 下载PDF
- (void) savePDFFile : (NSString *) url
{
    [MBProgressHUD showSuccess:@"正在下载，请稍后"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {

        DWDownloadItem *item = [[DWDownloadItem alloc] init];
        item.format = self.courseDetail.format;
        item.chapterid = self.courseDetail.chapterid;
        
        item.pdfUrl = url;
        
        item.imageUrl = self.courseDetail.picurl;
        
        item.size = [NSString stringWithFormat:@"%0.1fM",response.expectedContentLength/1024.0/1024.0];

        item.title = self.courseDetail.title;
        
        [DWDownloadItemTool saveDWDownloadItem:item];
        
    }];
    
    [downloadTask resume];

}

#pragma mark 播放按钮点击
- (void) startButtonClick
{
    CourseDetailModel *model = self.captions[self.selectedButton.tag];

    CourseLiveController *liveVc = [[CourseLiveController alloc] init];
    if (self.courseDetail.format == 2) {
        
        NSString *urlPraise = [NSString stringWithFormat:@"%@%@?zttvid=%@&video_type=1",NetHeader,VideoInfo,model.ccid];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:urlPraise WithParameters:nil success:^(id responseDic) {
            
            NSInteger code = [responseDic[@"rescode"] integerValue];
            
            if (code == 10000)
            {
                liveVc.videoLocalPath = [NSString stringWithFormat:@"%@",responseDic[@"data"][@"url"]];
            }
        } fail:^(NSError *error) {
            
        }];
        
    }else if (self.courseDetail.format == 0)
    {
        liveVc.videoId = model.ccid;

    }
    liveVc.model = model;
    liveVc.captions = self.captions;
    liveVc.liveTitle = self.courseDetail.chaptertitle;
    liveVc.chapterid = model.chapterid;
    [self presentViewController:liveVc animated:YES completion:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //获取PlayInfo 配对url 推送offlineview
    
    NSArray *videos = [self.playInfo valueForKey:@"definitions"];
    if (buttonIndex != 0) {
        
        [MBProgressHUD showSuccess:@"正在下载，请稍后"];
        
        NSDictionary *videoInfo = videos[(int)buttonIndex-1];
        
        NSString *definition = [[NSString alloc] initWithFormat:@"%@",[videoInfo valueForKey:@"definition"] ];
        NSString *playurl = [[NSString alloc] initWithFormat:@"%@",[videoInfo valueForKey:@"playurl"] ];
        
        // 开始下载
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        
        CourseDetailModel *model = self.captions[self.selectedButton.tag];

        NSString *videoPath = [NSString stringWithFormat:@"%@/%@-%@.mp4", documentDirectory, model.ccid, definition];
        

        DWDownloader *downloader = [[DWDownloader alloc] initWithUserId:DWACCOUNT_USERID andVideoId:model.ccid key:DWACCOUNT_APIKEY
                                                        destinationPath:videoPath];
        downloader.timeoutSeconds = 60;
        
        self.loader = downloader;
        
        downloader.finishBlock = ^() {
            
            DWDownloadItem *item = [[DWDownloadItem alloc] init];
            item.videoId = model.ccid;
            item.format = self.courseDetail.format;
            item.imageUrl = model.picurl;
            item.chapterid = model.chapterid;

            item.title = model.title;
            item.size = [NSString stringWithFormat:@"%0.1fM",(long)self.loader.remoteFileSize/1024.0/1024.0];
            item.videoPath = videoPath;
            item.name = [NSString stringWithFormat:@"%@-%@.mp4",model.ccid,definition];
            
            [DWDownloadItemTool saveDWDownloadItem:item];
            
        };
        
        [downloader startWithUrlString:playurl];
    }
    
}


#pragma mark 收藏点击
- (void) collectionButtonClick
{
    NSDictionary *parameter = @{
                                @"favorite_id":self.courseDetail.courseid,
                                @"type": courseType,//收藏类型，业务码
                                @"title": self.courseDetail.title,
                                @"imgurl": self.courseDetail.picurl
                                };
    
    NSString *url=[NSString stringWithFormat:@"%@%@?token=%@",NetHeader,Collection,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
        
        NSInteger code=[responseDic[@"rescode"] integerValue];
        
        if (code == 10000) {
            self.collectionButton.selected = [responseDic[@"data"][@"isFavorite"] intValue] == 1;
            NSString * msg = responseDic[@"msg"];
            [MBProgressHUD showSuccess:msg];
        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"] ];
    }];
}

#pragma mark 点赞
- (void) goodButtonClick : (UIButton *) button
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&id=%@&type=%@",NetHeader,PraiseAdd,[UserInfoTool getUserInfo].token,self.courseDetail.courseid,courseType];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        NSInteger code = [responseDic[@"rescode"] integerValue];
        
        if (code == 10000) {
            
            if ([responseDic[@"data"][@"isPraise"] intValue] == 1) {
                button.selected = YES;
            }else
            {
                button.selected = NO;
            }
            
            int count = [responseDic[@"data"][@"num"] intValue];
            self.goodLabel.text = [NSString stringWithFormat:@"%d",count];
            
            if (count > 99) {
                self.goodLabel.text = @"99+";
            }
        }else
        {
            [MBProgressHUD showError:@"网络错误"];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}

#pragma mark 分享
- (void) shareButtonClick
{
    self.shareTitle = self.courseDetail.title;
    self.shareSummary = @"自己不学习不可怕，可怕的是比自己更优秀的人从未停止学习，智同体移动学习平台，学习从这里开始。";
    self.shareImage = self.courseImgae.image;
    
    BOOL isInstallQQ = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ];
    
    BOOL isInstallWecha = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession];
    
    BOOL isInstallSina = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina];
    
    NSMutableArray *shareArray = [NSMutableArray array];
    
    TopImageButton *schoolButton = [[TopImageButton alloc] init];
    schoolButton.tag = ShareSchool;
    [schoolButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [schoolButton setTitle:@"皇冠足球经典推荐" forState:UIControlStateNormal];
    [schoolButton setImage:[UIImage imageNamed:@"share_01"] forState:UIControlStateNormal];
    [shareArray addObject:schoolButton];
    
    if (isInstallWecha) {
        
        TopImageButton *weChatButton = [[TopImageButton alloc] init];
        weChatButton.tag = ShareToWechat;
        [weChatButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weChatButton setTitle:@"微信好友" forState:UIControlStateNormal];
        [weChatButton setImage:[UIImage imageNamed:@"share_02"] forState:UIControlStateNormal];
        [shareArray addObject:weChatButton];
        
        TopImageButton *weChatButtonTimeline = [[TopImageButton alloc] init];
        weChatButtonTimeline.tag = ShareToWechatTimeline;
        [weChatButtonTimeline setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [weChatButtonTimeline setTitle:@"朋友圈" forState:UIControlStateNormal];
        [weChatButtonTimeline setImage:[UIImage imageNamed:@"share_03"] forState:UIControlStateNormal];
        [shareArray addObject:weChatButtonTimeline];

    }
    
    if (isInstallQQ) {
        
        TopImageButton *qqButton = [[TopImageButton alloc] init];
        qqButton.tag = ShareToQQChat;
        [qqButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qqButton setTitle:@"QQ好友" forState:UIControlStateNormal];
        [qqButton setImage:[UIImage imageNamed:@"share_04"] forState:UIControlStateNormal];
        [shareArray addObject:qqButton];
        
        TopImageButton *qqZoneButton = [[TopImageButton alloc] init];
        qqZoneButton.tag = ShareToQQ;
        [qqZoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [qqZoneButton setTitle:@"QQ空间" forState:UIControlStateNormal];
        [qqZoneButton setImage:[UIImage imageNamed:@"share_05"] forState:UIControlStateNormal];
        [shareArray addObject:qqZoneButton];
    }
    
    if (isInstallSina) {
        TopImageButton *sinaButton = [[TopImageButton alloc] init];
        sinaButton.tag = ShareToSina;
        [sinaButton setTitle:@"微博" forState:UIControlStateNormal];
        [sinaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sinaButton setImage:[UIImage imageNamed:@"share_06"] forState:UIControlStateNormal];
        [shareArray addObject:sinaButton];
    }
    
    if (shareArray.count > 0) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        UIView *shareView = [[UIView alloc] initWithFrame:window.bounds];
        self.shareMaskView = shareView;
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
    if (self.shareMaskView!= nil && self.shareMaskView.superview != nil) {
        [UIView animateWithDuration:0.3 animations:^{
            self.templateView.y = self.shareMaskView.height;
        } completion:^(BOOL finished) {
            [self.templateView removeFromSuperview];
            [self.shareMaskView removeFromSuperview];
        }];
    }
}

#pragma mark 分享按钮点击
- (void) buttonClick : (UIButton *) button
{
    [self shareViewClickWithNoAnimate];
    
    self.shareUrl = [NSString stringWithFormat:@"%@courseweb/shareios/%@",NetHeader,self.courseDetail.chapterid];
    
    switch (button.tag) {
        case ShareSchool: //皇冠足球经典推荐
            [self shareToSchool];
            break;
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

#pragma mark 删除分享平台不加动画
- (void) shareViewClickWithNoAnimate
{
    if (self.shareMaskView!= nil && self.shareMaskView.superview != nil) {
        [self.templateView removeFromSuperview];
        [self.shareMaskView removeFromSuperview];
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

#pragma mark 评论课程
- (void) commentButtonClick : (NSIndexPath *) indexPath alertViewType : (AlertViewType) alertViewType
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *commentView = [[UIView alloc] initWithFrame:window.bounds];
    self.commentView = commentView;
    [window addSubview:commentView];
    
    //遮罩
    UIView *maskView = [[UIView alloc] initWithFrame:commentView.bounds];
    self.maskView = maskView;
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.5;
    [commentView addSubview:maskView];
    
    UIView *alertVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 0.9, self.view.height * 0.4)];
    self.alertVeiw = alertVeiw;
    alertVeiw.centerX = maskView.width * 0.5;
    alertVeiw.centerY = maskView.height * 0.5;
    alertVeiw.layer.cornerRadius = 5;
    alertVeiw.layer.masksToBounds = YES;
    alertVeiw.backgroundColor = [UIColor whiteColor];
    [commentView addSubview:alertVeiw];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertVeiw.width, 50)];
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentCenter;
    if (alertViewType == AlertViewTypeShare) {
        title.text = @"分享到圈子";
    }else
    {
        title.text = @"发表评论";
    }
    title.font = [UIFont systemFontOfSize:16];
    [alertVeiw addSubview:title];
    
    //输入框
    IQTextView *textView = [[IQTextView alloc] initWithFrame:CGRectMake(mainSpacing, CGRectGetMaxY(title.frame), alertVeiw.width - 2 * mainSpacing, alertVeiw.height - 50 * 2 - 2 * mainSpacing)];
    self.textView = textView;
    textView.layer.cornerRadius = 5;
    textView.layer.masksToBounds = YES;
    textView.backgroundColor = DivisionDivColor;
    textView.font = [UIFont systemFontOfSize:16];
    
    if (alertViewType == AlertViewTypeReplay) {
        CourseStudyCommentFrame *frame = self.comments[indexPath.row];
        textView.placeholder = [NSString stringWithFormat:@"回复 %@:",frame.model.username];
    }else if(alertViewType == AlertViewTypeComment)
    {
        textView.placeholder = @"请输入评论内容";
    }else if (alertViewType == AlertViewTypeShare)
    {
        textView.placeholder = @"不错的课程,值得学习!";
    }

    [alertVeiw addSubview:textView];

    //分割线
    UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame) + mainSpacing * 2, alertVeiw.width, 0.5)];
    sepaView.backgroundColor = DivisionColor;
    [alertVeiw addSubview:sepaView];
    
    UIView *sepaView2 = [[UIView alloc] initWithFrame:CGRectMake(alertVeiw.width * 0.5, sepaView.y, 0.5, alertVeiw.height)];
    sepaView2.backgroundColor = DivisionColor;
    [alertVeiw addSubview:sepaView2];
    
    //按钮
    UIButton *cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sepaView.frame), alertVeiw.width * 0.5, alertVeiw.height - CGRectGetMaxY(sepaView.frame))];
    [cancleButton addTarget:self action:@selector(commentViewClick) forControlEvents:UIControlEventTouchUpInside];
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertVeiw addSubview:cancleButton];
    
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(alertVeiw.width * 0.5, cancleButton.y, cancleButton.width, cancleButton.height)];
    
    //回复
    if (alertViewType == AlertViewTypeReplay) {
        sureButton.tag = indexPath.row;
    }else if(alertViewType == AlertViewTypeComment)
    {
    //发表评论
        sureButton.tag = -1;
    }else if(alertViewType == AlertViewTypeShare)
    {
    //分享
        sureButton.tag = -2;
    }
    
    [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:16];
    if (alertViewType == AlertViewTypeShare) {
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    }else{
        [sureButton setTitle:@"发表评论" forState:UIControlStateNormal];
    }
    [sureButton setTitleColor:GreenColor forState:UIControlStateNormal];
    [alertVeiw addSubview:sureButton];
    
    alertVeiw.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration:0.3 animations:^{
        alertVeiw.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark 立即阅读
- (void) readButtonClick
{
    if (self.courseDetail.format == 4 || self.courseDetail.format == 1) { //H5 PDF 课程
        NSString *header = [MainUserDefaults objectForKey:FileServerUrl];

        NSString *urlPraise = [NSString stringWithFormat:@"%@/%@?zttvid=%@&video_type=%@",header,VideoInfo,self.courseDetail.ccid,self.courseDetail.format == 4 ? @"40430" : @"40420"];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:urlPraise WithParameters:nil success:^(id responseDic) {
            
            NSInteger code = [responseDic[@"rescode"] integerValue];
            
            if (code == 10000)
            {
                NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,LearnRecord,[UserInfoTool getUserInfo].token];
                
                NSDictionary *dic=@{
                                    @"chapterid" : self.courseDetail.chapterid,
                                    @"learntime" : @"180"
                                    };
                
                [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
                    int rescode = [responseDic[@"rescode"] intValue];
                    if (rescode == 10000) {
                        
                    }
                } fail:^(NSError *error) {
                    
                }];
                
                MainWebController *webViewVc = [[MainWebController alloc] init];
                webViewVc.url = [NSString stringWithFormat:@"%@",responseDic[@"data"][@"url"]];
                webViewVc.webTitle = self.courseDetail.title;
                [self.navigationController pushViewController:webViewVc animated:YES];
            }
        } fail:^(NSError *error) {
            
        }];
    }
}

#pragma mark 分享到皇冠足球经典推荐
- (void) shareToSchool
{

    [self commentButtonClick:0 alertViewType:AlertViewTypeShare];

}


@end
