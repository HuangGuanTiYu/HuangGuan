//
//  NewCourseDetailController.m
//  MoveSchool
//
//  Created by edz on 2017/8/25.
//
//

#import "NewCourseDetailController.h"
#import "AFNetWW.h"
#import "NewCourseModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "CourseBean.h"
#import "TBCityIconFont.h"
#import "UILabel+Extension.h"
#import "NSAttributedString+Extension.h"
#import "CourseChapterCell.h"
#import "ChapterModel.h"
#import "CommentModel.h"
#import "CommentCell.h"
#import "CustomLabel.h"
#import "ChatKeyBoard.h"
#import "IQKeyboardManager.h"
#import "CourseLiveController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "ShareButton.h"
#import "IQTextView.h"
#import "MainWebController.h"
#import "DownLoadController.h"
#import "DWDownloadItem.h"
#import "DWDownloadItemTool.h"
#import "NSString+Extension.h"
#import "PraiseModel.h"
#import "UIImageView+CornerRadius.h"
#import <AVFoundation/AVFoundation.h>//要导入系统框架AVFoundation.framework

#define StatusBar_HEIGHT 20
#define NavigationBar_HEIGHT 44

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

@interface NewCourseDetailController ()<UITableViewDelegate, UITableViewDataSource,ChatKeyBoardDelegate, CommentCellDelegate, CourseLiveControllerDelegate>

@property (strong, nonatomic) AVPlayer *avPlayer;

@property (nonatomic, strong) UIImageView *backImage;

@property (nonatomic, strong) NewCourseModel *model;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, assign) CGFloat contentH;

@property (nonatomic, strong) UIView *boomView;

@property (nonatomic, strong) UILabel *allButton;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *chapterView;

@property (nonatomic, strong) NSArray *chapterDatas;

@property (nonatomic, strong) UIView *navBarView;

@property(nonatomic,strong)UIView *navigationBackView;

@property (nonatomic, strong) UILabel *titleLabel;

//评论数组
@property (nonatomic, strong) NSMutableArray *comments;

@property (nonatomic, strong) UITableView *commentTableView;

@property (nonatomic, strong) UIView *footerView;

//是否显示全部评论
@property (nonatomic, assign) BOOL isMore;

@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;

@property (nonatomic, strong) UIView *maskView;

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

//当前章节
@property (nonatomic, assign) int index;

//是否是回复
@property (nonatomic, assign) BOOL isReply;

//点击回复的索引值
@property (nonatomic, assign) int replyIndex;

@property(nonatomic, strong) UIView *commentView;

//评论弹框
@property(nonatomic, strong) UIView *alertVeiw;

//评论输入框
@property(nonatomic, strong) IQTextView *textView;

@property(nonatomic, strong) NSArray *digits;

@property (nonatomic, strong) UIView *sepaView2;

@property (nonatomic, strong) CourseLiveController *liveVc;

@property (nonatomic, strong) UIButton *backButon;

@property (nonatomic, strong) CourseChapterCell *selectedCell;

@end

@implementation NewCourseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.comments = [NSMutableArray array];
    
    self.index = 0;
    
    [self setUpData];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    //注册 键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShowFrame:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHiddenFrame:) name:UIKeyboardWillHideNotification object:nil];
    
    self.digits = @[@"0" , @"1" , @"2" , @"3" , @"4" , @"5" ,
                    @"6" , @"7" , @"8" , @"9" , @"a" , @"b" ,
                    @"c" , @"d" , @"e" , @"f" , @"g" , @"h" ,
                    @"i" , @"j" , @"k" , @"l" , @"m" , @"n" ,
                    @"o" , @"p" , @"q" , @"r" , @"s" , @"t" ,
                    @"u" , @"v" , @"w" , @"x" , @"y" , @"z"];
}

- (void)keyBoardWillShowFrame:(NSNotification *)notification
{
    self.alertVeiw.centerY = self.maskView.height * 0.3;
}

- (void) keyBoardWillHiddenFrame:(NSNotification *)notification
{
    [self maskViewClick];
    
    self.alertVeiw.centerY = self.maskView.height * 0.5;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -初始化导航栏
- (void)setupNavigationBar {
    
    // 导航栏背景view
    _navigationBackView = [[UIView alloc] init];
    _navigationBackView.frame = CGRectMake(0, 0, SCREEN_WIDTH, StatusBar_HEIGHT + NavigationBar_HEIGHT);
    [self.view addSubview:_navigationBackView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:_navigationBackView.bounds];
    titleLabel.alpha = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:ys_f30];
    titleLabel.width = _navigationBackView.width * 0.6;
    titleLabel.centerX = _navigationBackView.width * 0.5;
    titleLabel.centerY = (_navigationBackView.height + 20) * 0.5;
    titleLabel.text = self.model.courseBean.title;
    [_navigationBackView addSubview:titleLabel];
    
    //返回按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e807", 18, [UIColor whiteColor])] forState:UIControlStateNormal];
    rightButton.size = CGSizeMake(25, 25);
    [rightButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    rightButton.centerY = titleLabel.centerY;
    rightButton.x = 15;
    [_navigationBackView addSubview:rightButton];
}

- (void) back
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)navBarView {
    if (!_navBarView) {
        _navBarView = [[UIView alloc] init];
        _navBarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    }
    return _navBarView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navBarView removeFromSuperview];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (void) setUpData
{
    [MBProgressHUD showMessage:@"正在加载，请稍后" toView:[UIApplication sharedApplication].keyWindow];
    
    //获取 课程和 章节
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?index=0&count=100&courseid=%@&token=%@",NetHeader,GetCoursesDetail,self.courseid,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             NewCourseModel *model = [NewCourseModel objectWithKeyValues:responseDic[@"data"]];
             self.model = model;
             
             self.chapterDatas = [ChapterModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
             
             [self setUpUI];
             
             //拉取评论
             [self getComment];

             [self.tableView reloadData];

         }else
         {
             [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
         }
         
     }fail:^(NSError *error) {
         [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
     }];
}

- (void) getComment
{
    //获取评论
    NSString *url = [NSString stringWithFormat:@"%@%@?businessid=%@&businesscode=40400&token=%@",NetHeader,GetCommentList,self.courseid,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             self.comments = (NSMutableArray *)[CommentModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
             
             [self setUpFooterView];
             
             if (self.comments.count > 0) {
                 [self.commentTableView reloadData];
             }
         }
         
     }fail:^(NSError *error) {
         
     }];
}

- (void) setUpUI
{

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    self.headerView = headerView;
    headerView.backgroundColor = ViewBackColor;
    
    //背景图
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, SCREEN_WIDTH * 9 / 16)];
    backImage.contentMode = UIViewContentModeScaleAspectFill;
    self.backImage = backImage;
    [backImage sd_setImageWithURL:[NSURL URLWithString:self.model.courseBean.image] placeholderImage:[UIImage imageNamed:@"zwt_kecheng"]];
    [headerView addSubview:backImage];
    
    
    //播放按钮
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    [startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    startButton.centerX = self.view.width * 0.5;
    startButton.centerY = backImage.height * 0.5;
    [headerView addSubview:startButton];
    
    //视频
    if (self.model.courseBean.format == 0 || self.model.courseBean.format == 2 || self.model.courseBean.format == 3) {
        [startButton setImage:[UIImage imageNamed:@"kecheng_bofang"] forState:UIControlStateNormal];
    }else
    {
        [startButton setImage:[UIImage imageNamed:@"kecheng_wenben"] forState:UIControlStateNormal];
    }
    
    //标题
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backImage.frame), self.view.width, 45)];
    titleView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:titleView];
    
    //分享
    UIButton *shareImage = [[UIButton alloc] initWithFrame:CGRectMake(titleView.width - titleView.height, 0, titleView.height, titleView.height)];
    [shareImage addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    [shareImage setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e642", 15, MainTextColor)] forState:UIControlStateNormal];
    [titleView addSubview:shareImage];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, shareImage.x - 30, titleView.height)];
    titleLabel.text = self.model.courseBean.title;
    titleLabel.textColor = MainTextColor;
    titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [titleView addSubview:titleLabel];
    
    //内容
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame) + mainSpacing, self.view.width, 105)];
    self.contentView = contentView;
    contentView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:contentView];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 0, 0)];
    self.contentLabel = contentLabel;
    contentLabel.height = contentView.height - 20;
    contentLabel.font = [UIFont systemFontOfSize:ys_28];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[self.model.courseBean.desc dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

    contentLabel.attributedText = attrStr;
    contentLabel.numberOfLines = 3;
    contentLabel.textColor = MainTextColor;
    [contentView addSubview:contentLabel];
    
    [UILabel changeLineSpaceForLabel:contentLabel WithSpace:2.5];
    contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    contentLabel.width = contentView.width - 30;
    contentView.height = contentLabel.height + 30 + 2 * mainSpacing;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:contentLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:2.5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contentLabel.text length])];
    
    CGSize contentH = [attributedString returnAttributedStringRect:attributedString size:CGSizeMake(contentLabel.width, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_28]];
    self.contentH = contentH.height;
    
    //底部 时长 + 免费
    UIView *boomView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(contentLabel.frame) + 7, contentView.width - 30, 30)];
    self.boomView = boomView;
    [contentView addSubview:boomView];
    
    if (contentH.height > contentLabel.height) {
        UILabel *allButton = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(contentLabel.frame) + 7, 50, 20)];
        self.allButton = allButton;
        allButton.userInteractionEnabled = YES;
        [allButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allButtonClick:)]];
        allButton.text = @"展开";
        allButton.textColor = MainColor;
        allButton.font = [UIFont systemFontOfSize:ys_28];
        [contentView addSubview:allButton];
        boomView.y = CGRectGetMaxY(allButton.frame) + 7;
        contentView.height = contentLabel.height + 30 + 2 * mainSpacing + 20;

    }
    
    //免费
    UILabel *freeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, boomView.height)];
    freeLabel.text = [NSString stringWithFormat:@"%@",self.model.courseBean.priceView[@"showPrice"]];
    freeLabel.textColor = MainColor;
    freeLabel.font = [UIFont systemFontOfSize:ys_28];
    [boomView addSubview:freeLabel];
    [freeLabel sizeToFit];
    
    //时长
    CGFloat timeX = CGRectGetMaxX(freeLabel.frame) + mainSpacing;
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeX, 0, boomView.width - timeX - mainSpacing, boomView.height)];
    timeLabel.centerY = freeLabel.centerY;
    timeLabel.text = [NSString stringWithFormat:@"时长：%@",self.model.courseBean.showDuration];
    timeLabel.textColor = AuxiliaryColor;
    timeLabel.font = [UIFont systemFontOfSize:ys_28];
    [boomView addSubview:timeLabel];
    
    //课程章节
    UIView *chapterView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(contentView.frame) + mainSpacing, headerView.width, 45)];
    self.chapterView = chapterView;
    chapterView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:chapterView];
    
    UILabel *chapter = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, chapterView.width - 30, chapterView.height)];
    chapter.text = @"课程章节";
    chapter.textColor = MainTextColor;
    chapter.font = [UIFont systemFontOfSize:ys_f30];
    [chapterView addSubview:chapter];
    
    //分割线
    UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, chapterView.height - 0.5, chapterView.width, 0.5)];
    sepaView.backgroundColor = SepaViewColor;
    [chapterView addSubview:sepaView];
    
    UIView *sepaView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(chapterView.frame), chapterView.width, mainSpacing)];
    self.sepaView2 = sepaView2;
    sepaView2.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:sepaView2];
    
    headerView.height = CGRectGetMaxY(self.contentView.frame) + mainSpacing + 55;
    
    //章节
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.bounces = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.height = self.view.height - 55 - mainSpacing;
    self.tableView = tableView;
    tableView.backgroundColor = ViewBackColor;
    tableView.tableHeaderView = headerView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];

    // 初始化导航栏
    [self setupNavigationBar];

    //底部工具条
    [self setUpToolView];
    
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];

}

- (void) setUpFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    self.footerView = footerView;
    
    UIView *writeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, mainSpacing)];
    writeView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:writeView];

    UIView *footSepaView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(writeView.frame), footerView.width, mainSpacing)];
    footSepaView.backgroundColor = ViewBackColor;
    [footerView addSubview:footSepaView];

    //评论
    UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(footSepaView.frame), footerView.width, 45)];
    commentView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:commentView];
    
    UILabel *chapter = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, commentView.width - 30, commentView.height)];
    chapter.text = @"评论";
    chapter.textColor = MainTextColor;
    chapter.font = [UIFont systemFontOfSize:ys_f30];
    [commentView addSubview:chapter];
    
    //分割线
    UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, commentView.height - 0.5, commentView.width, 0.5)];
    sepaView.backgroundColor = SepaViewColor;
    [commentView addSubview:sepaView];
    
    //评论
    UITableView *commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(commentView.frame), self.view.width, self.view.height)];
    commentTableView.backgroundColor = ViewBackColor;
    commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    commentTableView.showsVerticalScrollIndicator = NO;
    self.commentTableView = commentTableView;
    commentTableView.scrollEnabled = NO;
    commentTableView.delegate = self;
    commentTableView.dataSource = self;
    self.commentTableView.tableFooterView = [[UIView alloc] init];
    
    if (self.comments.count > 0) {
        [footerView addSubview:commentTableView];
        
        if (self.comments.count > 3 && !self.isMore) {
            UIButton *moreView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
            [moreView addTarget:self action:@selector(moreViewClick) forControlEvents:UIControlEventTouchUpInside];
            moreView.backgroundColor = [UIColor whiteColor];
            moreView.titleLabel.font = [UIFont systemFontOfSize:ys_28];
            [moreView setTitle:@"查看更多评论" forState:UIControlStateNormal];
            [moreView setTitleColor:MainColor forState:UIControlStateNormal];
            commentTableView.tableFooterView = moreView;
        }
    }else
    {
        //没有评论
        UIView *noCommentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(commentView.frame), footerView.width, 207)];
        noCommentView.backgroundColor = [UIColor whiteColor];
        [footerView addSubview:noCommentView];
        
        //图片 + 文字
        UIView *imageTexgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, noCommentView.width, 129)];
        imageTexgView.centerY = noCommentView.height * 0.5;
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
        toTestLabel.font = [UIFont systemFontOfSize:ys_28];
        [imageTexgView addSubview:toTestLabel];
    }
    
    int status = [self.model.testExist[@"data"][@"status"] intValue];

    if (self.model.testExist != nil) {
        
        if (status != -3 && status != -2) {
            //考试
            UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, footerView.width, 272)];
            testView.backgroundColor = [UIColor whiteColor];
            [footerView addSubview:testView];
            
            UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, testView.width, mainSpacing)];
            sepaView.backgroundColor = ViewBackColor;
            [testView addSubview:sepaView];
            
            UIView *sepaView2 = [[UIView alloc] initWithFrame:CGRectMake(0, testView.height - mainSpacing, testView.width, mainSpacing)];
            sepaView2.backgroundColor = ViewBackColor;
            [testView addSubview:sepaView2];
            
            UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, mainSpacing, testView.width, 45)];
            testLabel.text = @"考试";
            testLabel.font = [UIFont systemFontOfSize:ys_f30];
            testLabel.textColor = MainTextColor;
            [testView addSubview:testLabel];
            
            UIView *sepaView3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(testLabel.frame), testView.width, 0.5)];
            sepaView3.backgroundColor = SepaViewColor;
            [testView addSubview:sepaView3];
            
            if (status == -1 || status == 0) { //参加考试/补考
                UIView *toTestView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, testView.width, 51)];
                toTestView.centerY = (testView.height + 45) * 0.5;
                [testView addSubview:toTestView];
                
                //去考试
                UIButton *toTestButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
                [toTestButton addTarget:self action:@selector(toTestButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                toTestButton.centerX = toTestView.width * 0.5;
                toTestButton.titleLabel.font = [UIFont systemFontOfSize:ys_f30];
                [toTestButton setTitleColor:MainColor forState:UIControlStateNormal];
                [toTestButton setTitle:status == -1 ? @"去考试" : @"去补考" forState:UIControlStateNormal];
                toTestButton.layer.borderWidth = 0.5;
                toTestButton.layer.borderColor = MainColor.CGColor;
                toTestButton.layer.cornerRadius = fillet;
                toTestButton.layer.masksToBounds = YES;
                [toTestView addSubview:toTestButton];
                
                UILabel *toTestLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(toTestButton.frame) + 5, toTestView.width, 20)];
                toTestLabel.textAlignment = NSTextAlignmentCenter;
                toTestLabel.text = @"学完了，可以去小测一下哦";
                toTestLabel.textColor = AuxiliaryColor;
                toTestLabel.font = [UIFont systemFontOfSize:ys_28];
                [toTestView addSubview:toTestLabel];
                
            }else if (status == 1) //考试通过
            {
                UIView *adopt = [[UIView alloc] initWithFrame:CGRectMake(0, 0, testView.width, 139)];
                adopt.centerY = (testView.height + 45) * 0.5;
                [testView addSubview:adopt];
                
                //背景图
                UIImageView *adoptImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 121, 90)];
                adoptImage.image = [UIImage imageNamed:@"kong"];
                adoptImage.centerX = adopt.width * 0.5;
                [adopt addSubview:adoptImage];
                
                //分数
                UILabel *fractionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, adoptImage.width, 20)];
                fractionLabel.centerX = adoptImage.centerX;
                fractionLabel.text = [NSString stringWithFormat:@"%@分",self.model.testExist[@"data"][@"score"]];
                fractionLabel.font = [UIFont systemFontOfSize:21];
                fractionLabel.textColor = MainColor;
                fractionLabel.textAlignment = NSTextAlignmentCenter;
                [adopt addSubview:fractionLabel];
                
                UILabel *toTestLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(adoptImage.frame) + 5, adopt.width, 20)];
                toTestLabel.textAlignment = NSTextAlignmentCenter;
                toTestLabel.text = @"恭喜您，考试成绩合格！";
                toTestLabel.textColor = AuxiliaryColor;
                toTestLabel.font = [UIFont systemFontOfSize:ys_28];
                [adopt addSubview:toTestLabel];
                
                UILabel *lookLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(toTestLabel.frame), adopt.width, 20)];
                lookLabel.userInteractionEnabled = YES;
                [lookLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookLabelClick)]];
                lookLabel.textAlignment = NSTextAlignmentCenter;
                lookLabel.text = @"查看答案";
                lookLabel.textColor = MainColor;
                lookLabel.font = [UIFont systemFontOfSize:ys_28];
                [adopt addSubview:lookLabel];
            }
            
            commentView.y = 272;
            commentTableView.y = CGRectGetMaxY(commentView.frame);
        }
    }

    //没有评论
    if (self.comments.count == 0) {
        //有考试
        if (status != -3 && status != -2) {
            footerView.height = 55 + 262;
        }else
        {
            footerView.height = 65 + 207;
        }
    }else
    {
        [commentTableView layoutIfNeeded];
        footerView.height = commentTableView.contentSize.height + 55 + mainSpacing;
        
        if (status != -3 && status != -2) {
            if (self.model.testExist != nil) {
                [commentTableView layoutIfNeeded];
                footerView.height = commentTableView.contentSize.height + 45 + 272;
            }else
            {
                [commentTableView layoutIfNeeded];
                footerView.height = commentTableView.contentSize.height + 55 + mainSpacing;
            }
        }
    }
    
    self.commentTableView.height = self.footerView.height;

    self.tableView.tableFooterView = footerView;
}

- (void) allButtonClick : (UIGestureRecognizer *) gestureRecognizer
{
    UILabel *view = (UILabel *)gestureRecognizer.view;
    
    if ([view.text isEqualToString:@"收起"]) {
        view.text = @"展开";
        self.contentLabel.height = 85;
        self.contentLabel.numberOfLines = 3;
    }else
    {
        view.text = @"收起";
        self.contentLabel.height = self.contentH;
        self.contentLabel.numberOfLines = 0;
    }
    
    [self.contentLabel sizeToFit];
    self.allButton.y = CGRectGetMaxY(self.contentLabel.frame) + 7;
    self.boomView.y = CGRectGetMaxY(self.allButton.frame) + 7;
    self.contentView.height = self.contentLabel.height + 30 + 2 * mainSpacing + 20;
    self.chapterView.y = CGRectGetMaxY(self.contentView.frame) + mainSpacing;
    self.sepaView2.y = CGRectGetMaxY(self.chapterView.frame);
    self.headerView.height = CGRectGetMaxY(self.sepaView2.frame);
    self.tableView.tableHeaderView = self.headerView;

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return self.chapterDatas.count;
    }else
    {
        if (self.isMore) {
            return self.comments.count;
        }
        
        return self.comments.count > 3 ? 3 : self.comments.count;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        static NSString *ID = @"CourseChapterCell";
        CourseChapterCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[CourseChapterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.chapter setTitle:[NSString stringWithFormat:@"第%ld章",(long)indexPath.row + 1] forState:UIControlStateNormal];
        ChapterModel *model = self.chapterDatas[indexPath.row];
        cell.model = model;
        return cell;
    }else
    {
        static NSString *ID = @"cell";
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.delegate = self;
        CommentModel *model = self.comments[indexPath.row];
        cell.model = model;
        
        if (indexPath.row == self.comments.count - 1) {
            cell.sepaView.hidden = YES;
        }else
        {
            cell.sepaView.hidden = NO;
        }
        return cell;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        return 34;
    }else
    {
        CommentModel *model = self.comments[indexPath.row];
        if (model.touserid > 0) { //有回复
            if ([model.userid isEqualToString:[UserInfoTool getUserInfo].zttid]) { //自己评论的 有删除
                return model.contentHeight + 51 + 50 + 20 + mainSpacing;
            }else
            {
                return model.contentHeight + 51 + 50;
            }
        }else
        {
            if ([model.userid isEqualToString:[UserInfoTool getUserInfo].zttid]) { //自己评论的 有删除
                return model.contentHeight + 51 + 20 + mainSpacing;
            }else
            {
                return model.contentHeight + 51;
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失

    //章节
    if (tableView == self.tableView) {

        self.index = (int)indexPath.row;
        [self startButtonClick];
        
        CourseChapterCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.titleLabel.textColor = MainColor;
        cell.speed.layer.borderColor = MainColor.CGColor;
        cell.speed.textColor = MainColor;
        UIImageView *normalImage = [[UIImageView alloc] initWithFrame:cell.chapter.bounds];
        normalImage.image = [UIImage createImageWithColor:MainColor];
        [normalImage zy_cornerRadiusAdvance:fillet rectCornerType:UIRectCornerAllCorners];
        [cell.chapter setBackgroundImage:normalImage.image forState:UIControlStateNormal];
        cell.chapter.layer.cornerRadius = fillet;
    }else
    {
        self.replyIndex = (int)indexPath.row;
        CommentModel *model = self.comments[indexPath.row];
        //回复评论
        [self writeCommentClick];
        self.chatKeyBoard.placeHolder = [NSString stringWithFormat:@"回复%@",model.nickname];

        self.isReply = YES;
    }
}


#pragma mark -UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offset_Y = scrollView.contentOffset.y;
    CGFloat alpha = (offset_Y)/300.0f;
    
    self.navigationBackView.backgroundColor = [MainColor colorWithAlphaComponent:alpha];
    self.titleLabel.alpha = alpha;
}

#pragma mark 查看更多评论
- (void) moreViewClick
{
    self.isMore = YES;
    
    self.commentTableView.tableFooterView = [[UIView alloc] init];

    [self updateCommentList];

}

#pragma mark 初始化工具条
- (void) setUpToolView
{
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 55, self.view.width, 55)];
    toolView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:toolView];
    
    //按钮间距
    CGFloat buttonSpea = 35;
    
    //下载
    UIButton *downButton = [[UIButton alloc] initLineWithFrame:CGRectMake(toolView.width - 25 - 19, 0, 19, 19)];
    [downButton addTarget:self action:@selector(downButtonClick) forControlEvents:UIControlEventTouchUpInside];
    downButton.backgroundColor = [UIColor whiteColor];
    downButton.centerY = toolView.height * 0.5;
    [downButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e808", 18, MainTextColor)] forState:UIControlStateNormal];
    [toolView addSubview:downButton];
    
    //收藏
    UIButton *collectionButton = [[UIButton alloc] initLineWithFrame:CGRectMake(downButton.x - buttonSpea - 19, 0, 19, 19)];
    [collectionButton addTarget:self action:@selector(collectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    collectionButton.backgroundColor = [UIColor whiteColor];
    collectionButton.centerY = downButton.centerY;
    [collectionButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e643", 18, MainTextColor)] forState:UIControlStateNormal];
    [collectionButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e645", 18, MainColor)] forState:UIControlStateSelected];

    if ([self.model.courseBean.isFavorited isEqualToString:@"1"]) { //未收藏
        collectionButton.selected = YES;
    }
    
    [toolView addSubview:collectionButton];
    
    //赏
    UIButton *goodButton = [[UIButton alloc] initLineWithFrame:CGRectMake(collectionButton.x - buttonSpea - 19, 0, 19, 19)];
    goodButton.backgroundColor = [UIColor whiteColor];
    goodButton.centerY = downButton.centerY;
    [goodButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e648", 18, MainTextColor)] forState:UIControlStateNormal];
//    [toolView addSubview:goodButton];
    
    //写评论
    CustomLabel *writeComment = [[CustomLabel alloc] initLineWithFrame:CGRectMake(15, 0, collectionButton.x - 15 - 25, 35)];
    writeComment.userInteractionEnabled = YES;
    [writeComment addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(writeCommentClick)]];
    writeComment.layer.cornerRadius = fillet;
    writeComment.layer.masksToBounds = YES;
    writeComment.textInsets = UIEdgeInsetsMake(0, mainSpacing, 0, 0);
    writeComment.backgroundColor = ViewBackColor;
    writeComment.textColor = AuxiliaryColor;
    writeComment.text = @"写评论...";
    writeComment.font = [UIFont systemFontOfSize:ys_28];
    writeComment.centerY = downButton.centerY;
    [toolView addSubview:writeComment];
    
    self.chatKeyBoard = [ChatKeyBoard keyBoardWithNavgationBarTranslucent:NO];
    self.chatKeyBoard.delegate = self;
    [self.chatKeyBoard.chatToolBar.faceBtn setTitle:@"发布" forState:UIControlStateNormal];
    self.chatKeyBoard.chatToolBar.faceBtn.titleLabel.font = [UIFont systemFontOfSize:ys_f30];
    [self.chatKeyBoard.chatToolBar.faceBtn addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
    self.chatKeyBoard.y = self.chatKeyBoard.y + 20;
    self.chatKeyBoard.keyBoardStyle = KeyBoardStyleComment;
    self.chatKeyBoard.allowVoice = NO;
    self.chatKeyBoard.allowMore = NO;
    self.chatKeyBoard.allowSwitchBar = NO;
    self.chatKeyBoard.backgroundColor = [UIColor whiteColor];
    self.chatKeyBoard.chatToolBar.textView.backgroundColor = ViewBackColor;
    self.chatKeyBoard.chatToolBar.textView.textColor = MainTextColor;
    self.chatKeyBoard.chatToolBar.textView.layer.borderColor = [UIColor clearColor].CGColor;
    self.chatKeyBoard.placeHolder = @"写评论...";
    
    [self.view addSubview:self.chatKeyBoard];
}

#pragma mark 写评论点击
- (void) writeCommentClick
{
    self.chatKeyBoard.placeHolder = @"写评论...";

    self.isReply = NO;
    UIView *maskView = [[UIView alloc] initLineWithFrame:self.view.bounds];
    [maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewClick)]];
    self.maskView = maskView;
    maskView.alpha = 0.5;
    maskView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:maskView];

    [self.view bringSubviewToFront:self.chatKeyBoard];
    
    [self.chatKeyBoard keyboardUpforComment];
}

- (void) maskViewClick
{
    [self.chatKeyBoard keyboardDownForComment];
    if (self.maskView != nil) {
        [self.maskView removeFromSuperview];
    }
}

#pragma mark 开始播放
- (void) startButtonClick
{
    if (self.chapterDatas.count > 0) {
        
        ChapterModel *cmodel = self.chapterDatas[self.index];
        
        NSDictionary *parameter=@{
                                  @"courseid":cmodel.courseid
                                  };
        NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseAdd,[UserInfoTool getUserInfo].token];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
            
            NSInteger code=[responseDic[@"rescode"] integerValue];
            
            if (code == 10000)
            {
                if (self.model.courseBean.format == 0 || self.model.courseBean.format == 2) {
                    
                    if (self.liveVc != nil) {
                        [self.liveVc.view removeFromSuperview];
                    }
                    
                    CourseLiveController *liveVc = [[CourseLiveController alloc] init];
                    liveVc.delegate = self;
                    self.liveVc = liveVc;
                    liveVc.isSmall = YES;
                    liveVc.format = self.model.courseBean.format;
                    
                    if (self.model.courseBean.format == 2) {
                        
                        NSString *header = [MainUserDefaults objectForKey:FileServerUrl];

                        NSString *urlPraise = [NSString stringWithFormat:@"%@%@?zttvid=%@&video_type=1",header,VideoInfo,cmodel.ccid];
                        
                        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:urlPraise WithParameters:nil success:^(id responseDic) {
                            
                            NSInteger code = [responseDic[@"rescode"] integerValue];
                            
                            if (code == 10000)
                            {
                                liveVc.videoLocalPath = [NSString stringWithFormat:@"%@",responseDic[@"data"][@"url"]];
                                [liveVc test];
                            }
                        } fail:^(NSError *error) {
                            
                        }];
                        
                    }else if (self.model.courseBean.format == 0)
                    {
                        liveVc.videoId = cmodel.ccid;
                        
                    }
                    
                    //章节信息
                    ChapterModel *cmodel = self.chapterDatas[self.index];
                    liveVc.model = cmodel;
                    liveVc.captions = self.chapterDatas;
                    liveVc.liveTitle = cmodel.chapterTitle;
                    liveVc.chapterid = cmodel.courseid;
                    
                    [self.view addSubview:liveVc.view];
                    UIButton *backButon = [[UIButton alloc] initWithFrame:CGRectMake(mainSpacing15, 25, 26, 26)];
                    self.backButon = backButon;
                    [backButon addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
                    [backButon setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
                    [self.view addSubview:backButon];
                    
//                    [self presentViewController:liveVc animated:YES completion:nil];
                }else if(self.model.courseBean.format == 3){
                    
                    ChapterModel *cmodel = [self.chapterDatas firstObject];

                    NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
                    
                    NSString *urlPraise = [NSString stringWithFormat:@"%@%@?zttvid=%@&video_type=40411",header,VideoInfo,cmodel.ccid];
                    
                    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:urlPraise WithParameters:nil success:^(id responseDic) {
                        
                        NSInteger code = [responseDic[@"rescode"] integerValue];
                        
                        if (code == 10000)
                        {
                            
                            NSString *string = [NSString stringWithFormat:@"%@",responseDic[@"data"][@"url"]];
                            
                            // (1)获取文件（远程/本地）
                            NSURL *url = [NSURL URLWithString:string];
                            // (3)使用playerItem获取视频的信息，当前播放时间，总时间等
                            AVPlayerItem * songItem = [AVPlayerItem playerItemWithURL:url];
                            // (3)初始化音频类 并且添加播放文件
                            
                            _avPlayer = [AVPlayer playerWithPlayerItem:songItem];
                            // (4) 设置初始音量大小 默认1，取值范围 0~1
                            _avPlayer.volume = 1.0;
                            [_avPlayer play];
                            
                            
                        }
                    } fail:^(NSError *error) {
                        
                    }];
                    
                }
                else
                {
                    NSString *urls = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,LearnRecord,[UserInfoTool getUserInfo].token];
                    
                    NSDictionary *dic=@{
                                        @"courseid" : self.model.courseBean.courseid,
                                        @"learntime" : @"180"
                                        };
                    
                    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:urls WithParameters:dic success:^(id responseDic) {
                        int rescode = [responseDic[@"rescode"] intValue];
                        if (rescode == 10000) {
                            
                        }
                    } fail:^(NSError *error) {
                        
                    }];
                    
                    //H5 PDF 课程
                    
                    NSString *type = @"40430";
                    if (self.model.courseBean.format == 1) {
                        type = @"40420";
                    }else if (self.model.courseBean.format == 4)
                    {
                        type = @"40430";
                    }
                    
                    NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
                    NSString *url = [NSString stringWithFormat:@"%@%@?type=%@&zttvid=%@",header,ResourcesView,type,self.model.courseBean.ccid];
                    MainWebController *webViewVc = [[MainWebController alloc] init];
                    webViewVc.url = url;
                    webViewVc.webTitle = self.model.courseBean.title;
                    [self.navigationController pushViewController:webViewVc animated:YES];
                }
                
            }else if(code != 20002)
            {
                [MBProgressHUD showError:responseDic[@"msg"]];
            }
            
        } fail:^(NSError *error) {
            [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
        }];
        
    }else
    {
        NSString *urls = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,LearnRecord,[UserInfoTool getUserInfo].token];
        
        NSDictionary *dic=@{
                            @"courseid" : self.model.courseBean.courseid,
                            @"learntime" : @"180"
                            };
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:urls WithParameters:dic success:^(id responseDic) {
            int rescode = [responseDic[@"rescode"] intValue];
            if (rescode == 10000) {
                
            }
        } fail:^(NSError *error) {
            
        }];
        
        //H5 PDF 课程
        
        NSString *type = @"40430";
        if (self.model.courseBean.format == 1) {
            type = @"40420";
        }else if (self.model.courseBean.format == 4)
        {
            type = @"40430";
        }
        
        NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
        NSString *url = [NSString stringWithFormat:@"%@%@?type=%@&zttvid=%@",header,ResourcesView,type,self.model.courseBean.ccid];
        MainWebController *webViewVc = [[MainWebController alloc] init];
        webViewVc.url = url;
        webViewVc.webTitle = self.model.courseBean.title;
        [self.navigationController pushViewController:webViewVc animated:YES];
    }
}

- (void) shareClick
{
    self.shareTitle = self.model.courseBean.title;
    self.shareSummary = @"自己不学习不可怕，可怕的是比自己更优秀的人从未停止学习，智同体移动学习平台，学习从这里开始。";
    self.shareImage = self.backImage.image;
    
    BOOL isInstallQQ = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ];
    
    BOOL isInstallWecha = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession];
    
    BOOL isInstallSina = [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina];
    
    NSMutableArray *shareArray = [NSMutableArray array];
    
    ShareButton *schoolButton = [[ShareButton alloc] init];
    schoolButton.tag = ShareSchool;
    [schoolButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [schoolButton setTitle:@"皇冠足球经典推荐" forState:UIControlStateNormal];
    [schoolButton setImage:[UIImage imageNamed:@"share_01"] forState:UIControlStateNormal];
    [shareArray addObject:schoolButton];
    
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
            ShareButton *button = shareArray[i];
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


#pragma mark 分享按钮点击
- (void) buttonClick : (UIButton *) button
{
    
    [self.chatKeyBoard deleteNoficationNoFrame];
    
    [self shareViewClickWithNoAnimate];
    
    self.shareUrl = [NSString stringWithFormat:@"%@/nodejs/h5/5/discover/course/courseDetail?id=%@&zttshareId=%@",NetHeader,self.model.courseBean.courseid,[self getShareId:[[UserInfoTool getUserInfo].zttid intValue]]];
    
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

#pragma mark 分享到皇冠足球经典推荐
- (void) shareToSchool
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
    
    UIView *alertVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 0.9, 0)];
    self.alertVeiw = alertVeiw;
    alertVeiw.centerX = maskView.width * 0.5;
    alertVeiw.layer.cornerRadius = 5;
    alertVeiw.layer.masksToBounds = YES;
    alertVeiw.backgroundColor = [UIColor whiteColor];
    [commentView addSubview:alertVeiw];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertVeiw.width, 40)];
    title.textColor = MainTextColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"分享到圈子";
    title.font = [UIFont systemFontOfSize:ys_28];
    [alertVeiw addSubview:title];
    
    //分割线
    UIView *sepaView3 = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(title.frame), alertVeiw.width - 30, 0.5)];
    sepaView3.backgroundColor = SepaViewColor;
    [alertVeiw addSubview:sepaView3];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(sepaView3.frame) + mainSpacing, sepaView3.width, 63)];
    titleLabel.font = [UIFont systemFontOfSize:ys_28];
    titleLabel.textColor = MainTextColor;
    titleLabel.numberOfLines = 2;
    
    NSString *allString = [NSString stringWithFormat:@"[课程]%@",self.model.courseBean.title];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:allString];
    [string addAttribute:NSForegroundColorAttributeName value:MainColor range:[allString rangeOfString:@"[课程]"]];
    titleLabel.attributedText = string;
    [alertVeiw addSubview:titleLabel];
    [titleLabel sizeToFit];

    //输入框
    IQTextView *textView = [[IQTextView alloc] initWithFrame:CGRectMake(mainSpacing, CGRectGetMaxY(titleLabel.frame) + mainSpacing, alertVeiw.width - 2 * mainSpacing, 60)];
    self.textView = textView;
    textView.layer.cornerRadius = 5;
    textView.layer.masksToBounds = YES;
    textView.backgroundColor = DivisionDivColor;
    textView.font = [UIFont systemFontOfSize:ys_28];
    textView.placeholder = @"不错的课程,值得学习!";
    [alertVeiw addSubview:textView];
    
    //分割线
    UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame) + 15, alertVeiw.width, 0.5)];
    sepaView.backgroundColor = SepaViewColor;
    [alertVeiw addSubview:sepaView];
    
    UIView *sepaView2 = [[UIView alloc] initWithFrame:CGRectMake(alertVeiw.width * 0.5, sepaView.y, 0.5, 0)];
    sepaView2.backgroundColor = SepaViewColor;
    [alertVeiw addSubview:sepaView2];
    
    //按钮
    UIButton *cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sepaView.frame), alertVeiw.width * 0.5, 40)];
    [cancleButton addTarget:self action:@selector(commentViewClick) forControlEvents:UIControlEventTouchUpInside];
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:MainTextColor forState:UIControlStateNormal];
    [alertVeiw addSubview:cancleButton];
    
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(alertVeiw.width * 0.5, cancleButton.y, cancleButton.width, cancleButton.height)];
    
    [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];

    [sureButton setTitleColor:GreenColor forState:UIControlStateNormal];
    [alertVeiw addSubview:sureButton];
    
    sepaView2.height = alertVeiw.height = CGRectGetMaxY(sureButton.frame);
    alertVeiw.centerY = maskView.height * 0.5;

    
    alertVeiw.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration:0.3 animations:^{
        alertVeiw.transform = CGAffineTransformIdentity;
    }];

}

#pragma mark 评论课程
- (void) commentButtonClick : (NSIndexPath *) indexPath
{
    
}

#pragma mark 收藏
- (void) collectionButtonClick : (UIButton *) button
{

    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,FavoriteAdd,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic=@{
                        @"businessid" : self.courseid,
                        @"businesscode" : courseType
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            
            [MBProgressHUD showSuccess:responseDic[@"data"][@"msg"]];
            int isAdd = [responseDic[@"data"][@"isAdd"] intValue];
            button.selected = isAdd == 0 ? NO : YES;
        }
    } fail:^(NSError *error) {
        
    }];

}

#pragma mark 发送评论
- (void) sendComment
{
    
    [self maskViewClick];
    [self sendCommentWithText:self.chatKeyBoard.chatToolBar.textView.text];
}

- (void) chatKeyBoardSendText:(NSString *)text
{
    [self maskViewClick];
    [self sendCommentWithText:text];
}

#pragma mark 发送评论
- (void) sendCommentWithText : (NSString *) text
{
    
    NSDictionary *dic=@{
                        @"businessid" : self.courseid,
                        @"businesscode" : courseType,
                        @"toid" : @"0",
                        @"content" : text
                        };
    
    if (self.comments.count > 0) {
        CommentModel *model = self.comments[self.replyIndex];
        
        dic = @{
                            @"businessid" : self.courseid,
                            @"businesscode" : courseType,
                            @"toid" : self.isReply ? model.ID : @"0",
                            @"content" : text
                            };
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CommentAdd,[UserInfoTool getUserInfo].token];

    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            [MBProgressHUD showSuccess:@"评论成功"];
            CommentModel *model = [CommentModel objectWithKeyValues:responseDic[@"data"]];
            [self.comments insertObject:model atIndex:0];

            //刷新评论列表
            [self updateCommentList];
            [self setUpFooterView];
            self.chatKeyBoard.chatToolBar.textView.text = @"";
            
        }else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:responseDic[@"msg"]];
            });
        }
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark 刷新评论列表
- (void) updateCommentList
{
    
    [self.commentTableView reloadData];
    
    int status = [self.model.testExist[@"data"][@"status"] intValue];
    
    if (status != -3 && status != -2) {
        if (self.model.testExist != nil) {
            [self.commentTableView layoutIfNeeded];
            self.footerView.height = self.commentTableView.contentSize.height + 45 + 272;
        }else
        {
            [self.commentTableView layoutIfNeeded];
            self.footerView.height = self.commentTableView.contentSize.height + 55 + mainSpacing;
        }
    }else
    {
        [self.commentTableView layoutIfNeeded];
        
        if (isIPhone6p_6sp) {
            self.footerView.height = self.commentTableView.contentSize.height + 55 + mainSpacing * 2;
        }else
        {
            self.footerView.height = self.commentTableView.contentSize.height + 55 + mainSpacing * 2 + 70;
        }
    }
    
    self.commentTableView.height = self.footerView.height;
    self.tableView.tableFooterView = self.footerView;
    

}

- (void)goodButtonClick:(CommentCell *)cell
{
    NSIndexPath *indexPath = [self.commentTableView indexPathForCell:cell];
    CommentModel *model = self.comments[indexPath.row];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,PraiseAdd,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic = @{
                          @"businessid" : model.ID,
                          @"businesscode" : teacherQuestionType
                          };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        
        NSInteger code = [responseDic[@"rescode"] integerValue];
        
        if (code == 10000) {
            
            if ([responseDic[@"data"][@"err"] intValue] == 0) {// 1取消点赞 0点赞成功
                [cell.goodButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62d", 15, MainColor)] forState:UIControlStateNormal];
                [cell.goodButton setTitleColor:MainColor forState:UIControlStateNormal];
                
            }else
            {
                [cell.goodButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62e", 15, AuxiliaryColor)] forState:UIControlStateNormal];
                [cell.goodButton setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
            }
            
            [cell.goodButton setTitle:responseDic[@"data"][@"num"] forState:UIControlStateNormal];
            
        }else if(code != 20002)
        {
            [MBProgressHUD showError:@"网络错误"];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];

}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)orientationChange:(BOOL)landscapeRight
{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (landscapeRight) {
        self.backButon.hidden = YES;
        [UIView animateWithDuration:0.2f animations:^{
            self.liveVc.view.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.liveVc.view.frame = CGRectMake(0, 0, width, height);
            [self.liveVc changeFrame : YES];
            
        }];
    } else {
        self.backButon.hidden = NO;
        [UIView animateWithDuration:0.2f animations:^{
            self.liveVc.view.transform = CGAffineTransformMakeRotation(0);
            self.liveVc.view.frame = CGRectMake(0, 0, width, width * 9 / 16);
            [self.liveVc changeFrame : NO];
        }];
    }
}

#pragma mark 下载
- (void) downButtonClick
{
    
    //视频
    if (self.model.courseBean.format == 0 || self.model.courseBean.format == 2) {
        DownLoadController *downVc = [[DownLoadController alloc] init];
        for (ChapterModel *model in self.chapterDatas) {
            model.buttonIsSelected = NO;
        }
        downVc.titles = self.chapterDatas;
        downVc.format = self.model.courseBean.format;
        downVc.image = self.backImage.image;
        [self.navigationController pushViewController:downVc animated:YES];
    }else
    {
        
        NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,UserService,[UserInfoTool getUserInfo].token];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
         {
             if ([responseDic[@"rescode"] intValue] == 10000) {
                 
                 if ([responseDic[@"data"][@"service"] intValue] == 2)
                 {
                     NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
                     
                     NSString *urlPraise = [NSString stringWithFormat:@"%@/%@?zttvid=%@&video_type=%@",header,VideoInfo,self.model.courseBean.ccid,self.model.courseBean.format == 4 ? @"40430" : @"40420"];
                     
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
                     [MBProgressHUD showError:responseDic[@"msg"]];
                 }
                 
             }
             
         }fail:^(NSError *error) {
             
         }];
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
        item.format = self.model.courseBean.format;
        item.chapterid = self.model.courseBean.courseid;
        
        item.pdfUrl = url;
        
        item.image = self.backImage.image;
        
        item.size = [NSString stringWithFormat:@"%0.1fM",response.expectedContentLength/1024.0/1024.0];
        
        item.title = self.model.courseBean.title;
        
        [DWDownloadItemTool saveDWDownloadItem:item];
        
    }];
    
    [downloadTask resume];
    
}

#pragma mark 评论遮罩点击
- (void) commentViewClick
{
    [self.chatKeyBoard addNotificationNoFrame];
    
    if (self.commentView != nil && self.commentView.superview != nil) {
        [self.commentView removeAllSubviews];
        [self.commentView removeFromSuperview];
    }
}

#pragma mark 发表评论点击
- (void) sureButtonClick : (UIButton *) button
{
    [self.chatKeyBoard addNotificationNoFrame];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,BroadcastAdd,[UserInfoTool getUserInfo].token];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"type"] = courseType;
    NSString *content = @"不错的课程,值得学习!";
    if (self.textView.text.length > 0) {
        content = self.textView.text;
    }
    
    dict[@"content"] = [NSString encodeBase64:content];
    
    NSMutableArray *newAttachs = [NSMutableArray array];
    NSMutableDictionary *attachsDict = [NSMutableDictionary dictionary];
    attachsDict[@"title"] = self.shareTitle;
    attachsDict[@"url"] = self.model.courseBean.image;
    attachsDict[@"thumbnail"] = self.model.courseBean.image;
    attachsDict[@"attach_businessid"] = self.model.courseBean.courseid;
    attachsDict[@"attach_businesscode"] = courseType;
    
    [newAttachs addObject:attachsDict];
    dict[@"attachs"] = newAttachs;
    
    [self commentViewClick];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dict success:^(id responseDic) {
        NSInteger code = [responseDic[@"rescode"] integerValue];
        
        if (code == 10000)
        {
            [MBProgressHUD showSuccess:@"分享成功"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"HAVEPUSH" object:nil];
            
        }else
        {
            [MBProgressHUD showError:@"分享失败"];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"分享失败"];
    }];
}

#pragma mark 去考试，去补考
- (void) toTestButtonClick : (UIButton *) button
{
    
    NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@&testid=%@",NetHeader,CourseTest,[UserInfoTool getUserInfo].token,self.model.courseBean.mainid];
    
    MainWebController *vc = [[MainWebController alloc] init];
    vc.url = uelStr;
    vc.webTitle = self.model.courseBean.title;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark 查看答案
- (void) lookLabelClick
{
    
    NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@&testId=%@&usertestid=%@&type=1",NetHeader,H5TestResult,[UserInfoTool getUserInfo].token,self.model.courseBean.mainid,self.model.testExist[@"data"][@"usertestid"]];
    
    MainWebController *vc = [[MainWebController alloc] init];
    vc.url = uelStr;
    vc.webTitle = self.model.courseBean.title;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 删除评论
- (void)deleteComment:(CommentCell *)cell
{

    NSIndexPath *indexPath = [self.commentTableView indexPathForCell:cell];
    CommentModel *model = self.comments[indexPath.row];
    NSDictionary *dic=@{
                        @"id" : model.ID
                        };

    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CommentDel,[UserInfoTool getUserInfo].token];
    
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            [MBProgressHUD showSuccess:@"删除成功"];
            [self.comments removeObject:model];
            
            //刷新评论列表
            [self updateCommentList];
            [self setUpFooterView];
            self.chatKeyBoard.chatToolBar.textView.text = @"";
            
        }else
        {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:responseDic[@"msg"]];
            });
        }
    } fail:^(NSError *error) {
        
    }];
}

- (void)fullButtonClick:(BOOL)buttonSelected
{
 
    [self orientationChange:!buttonSelected];

}

@end
