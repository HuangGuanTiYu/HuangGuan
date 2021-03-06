//
//  HomePageController.m
//  NewSchoolBus
//
//  Created by edz on 2017/8/14.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "HomePageController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIImage+Extension.h"
#import "TBCityIconFont.h"
#import "AFNetWW.h"
#import "MJExtension.h"
#import "BannerModel.h"
#import "BusinessTypeTool.h"
#import "SDCycleScrollView.h"
#import "HomePageCell.h"
#import "HomePageModel.h"
#import "HomePageTitleCell.h"
#import "MJRefresh.h"
#import "MainWebController.h"
#import "NewCourseDetailController.h"
#import "UIView+WZLBadge.h"
#import "SearchController.h"
#import "SearchResultController.h"
#import "MyMessageController.h"
#import "MenusModelTool.h"
#import "MenusModel.h"
#import "MenusSubModel.h"
#import "NewTeacherController.h"
#import "AppDelegate.h"
#import "SpecialDetailModel.h"
#import "SpecialDetailTitleModel.h"
#import "SpecialDetailController.h"
#import "NewCourseModel.h"
#import "NewVideoCourseController.h"
#import "CourseBean.h"
#import <AVFoundation/AVFoundation.h>
#import "QRCodeController.h"

@interface HomePageController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *searchField;

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic, assign) BOOL isMoreData;

@property(nonatomic, assign) int index;

@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.index = 0;

    [self setUpUI];
    
    self.datas = [NSMutableArray array];

    //登录成功刷新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiRefreheing) name:@"HAVEPUSH" object:nil];

}

- (void) notiRefreheing
{
    
    self.datas = [NSMutableArray array];
    
    self.isMoreData = NO;
    self.index = 0;
    
    //拉取banner
    [self getBanner];
    
    [self setUpData];
}


- (void) refreheing
{

    //拉取banner
    [self getBanner];
    
    [self setUpData];
    
}


#pragma mark 获取首页红点
- (void) getHomeRedPoint
{

    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,HomeGetMsgRecordCount,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             int count = [responseDic[@"data"][@"count"] intValue];
             if (count > 0) {
                 self.rightButton.badgeBgColor = [UIColor redColor];
                 self.rightButton.badgeCenterOffset = CGPointMake(-5, 0);
             }else
             {
                 self.rightButton.badgeBgColor = [UIColor clearColor];
             }
         }
         
     }fail:^(NSError *error) {
         
     }];
}

//拉取banner
- (void) getBanner
{
    NSString *url = ABanner;
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        NSArray *banners = [BannerModel objectArrayWithKeyValuesArray:responseDic];
        
        NSMutableArray *imageArr =  [NSMutableArray array];
        NSMutableArray *titleArr =  [NSMutableArray array];
        NSMutableArray *typeArr =  [NSMutableArray array];
        
        if (banners.count > 0) {
            for (BannerModel *model in banners) {
                [imageArr addObject:model.imgurl];
                [titleArr addObject:model.title];
                [typeArr addObject:model.typeName];
            }
        }
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width / 3 + 45)];
        headerView.backgroundColor = ViewBackColor;
        
        // 轮播图
        SDCycleScrollView *apView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height)];
        apView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        apView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        apView.pageDotColor = RGBCOLOR(54,54,66);
        apView.pageControlBottomOffset = 40;
        apView.titleLabelBackgroundColor = [UIColor whiteColor];
        apView.titleLabelTextColor = MainTextColor;
        [headerView addSubview:apView];
        
        self.tableView.tableHeaderView = headerView;
        
        apView.imageURLStringsGroup = imageArr;
        apView.titlesGroup = titleArr;
        
        apView.clickItemOperationBlock = ^(NSInteger index)
        {
            BannerModel *model = banners[index];

            MainWebController *vc = [[MainWebController alloc] init];
            vc.url = model.jumpUrl;
            vc.webTitle = model.title;
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        
    } fail:^(NSError *error) {
        
        
    }];
}

- (BOOL) deptNumInputShouldNumber:(NSString *)str
{
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //获取首页红点
    [self getHomeRedPoint];
    
    //拉取banner
    [self refreheing];
}

- (void) setUpUI
{
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    
    //消息
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton = rightButton;
    [rightButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e626", 18, [UIColor whiteColor])] forState:UIControlStateNormal];
    rightButton.size = rightButton.imageView.image.size;
    [rightButton addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    
    rightButton.centerY = rightView.height * 0.5;
    rightButton.x = rightView.width - rightButton.width;
    [rightView addSubview:rightButton];
    
    //扫一扫
    UIButton *scanningButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanningButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e69e", 18, [UIColor whiteColor])] forState:UIControlStateNormal];
    scanningButton.size = scanningButton.imageView.image.size;
    [scanningButton addTarget:self action:@selector(scanning) forControlEvents:UIControlEventTouchUpInside];
    
    scanningButton.centerY = rightView.height * 0.5;
    [rightView addSubview:scanningButton];
    
    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width - 64 - 50, 44)];
    
    // 创建UISearchBar对象
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:titleView.bounds];

    searchBar.width = titleView.width - 10;
    [searchBar setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e69e", 15, [UIColor whiteColor])]
       forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    searchBar.barTintColor = [UIColor whiteColor];
    
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    searchField.delegate = self;
    self.searchField = searchField;
    searchField.backgroundColor = RGBCOLOR(135, 135, 135);
    
    searchField.textColor = [UIColor whiteColor];
    
    UIImage* searchBarBg = [UIImage GetImageWithColor:[UIColor clearColor] andHeight:44];
    [searchBar setBackgroundImage:searchBarBg];
    
    // 设置没有输入时的提示占位符
    [searchBar setPlaceholder:@"请输入要搜索的关键词"];
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont systemFontOfSize:ys_28] forKeyPath:@"_placeholderLabel.font"];
    
    [titleView addSubview:searchBar];
    
    UIButton *videoButton = [[UIButton alloc] initWithFrame:CGRectMake(titleView.width - 35, 0, 20,20)];
    [videoButton addTarget:self action:@selector(videoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [videoButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e694", 15, [UIColor whiteColor])] forState:UIControlStateNormal];
    videoButton.centerY = searchBar.centerY;
    [titleView addSubview:videoButton];

    self.navigationItem.titleView = titleView;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.height = self.view.height - 64 - 50;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

- (void) scanning
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusDenied){
        if (IS_VAILABLE_IOS8) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"相机权限受限" message:@"请在iPhone的\"设置->隐私->相机\"选项中,允许\"自游邦\"访问您的相机." preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if ([self canOpenSystemSettingView]) {
                    [self systemSettingView];
                }
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"相机权限受限" message:@"请在iPhone的\"设置->隐私->相机\"选项中,允许\"自游邦\"访问您的相机." delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
            [alert show];
        }
        
        return;
    }
    
    QRCodeController *qrcodeVC = [[QRCodeController alloc] init];
    qrcodeVC.view.alpha = 0;
    [qrcodeVC setDidReceiveBlock:^(NSString *result) {
        MainWebController *webVc = [[MainWebController alloc] init];
        NSString *url = @"";
        if ([UserInfoTool isLogin]) {
            url = [NSString stringWithFormat:@"%@",result];
        }else
        {
            url = [NSString stringWithFormat:@"%@?token=%@",result,@"ydxt"];
        }
        if ([url containsString:@"https://"]) {
            url = [url stringByReplacingOccurrencesOfString:@"https://" withString:@"http://"];
        }
        webVc.url = url;
        webVc.webTitle = @"查看";
        [self.navigationController pushViewController:webVc animated:YES];
    }];
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del.window.rootViewController addChildViewController:qrcodeVC];
    [del.window.rootViewController.view addSubview:qrcodeVC.view];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        qrcodeVC.view.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

- (void) loadMoreData
{
    self.isMoreData = YES;
    ++self.index;
    [self setUpData];
}

- (void) setUpData
{
    
    //拉取首页 猜你喜欢
    NSString *likeUrl = ARuessLike;
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         [self.tableView.mj_footer endRefreshing];

         NSArray *models = [HomePageModel objectArrayWithKeyValuesArray:responseDic];
         if (models.count > 0) {
             if (self.isMoreData) {
                 [self.datas addObjectsFromArray:models];
                 
             }else
             {
                 self.datas = (NSMutableArray *)models;
             }
         }
         
         [self.tableView reloadData];
     }fail:^(NSError *error) {
        
         [self.tableView.mj_footer endRefreshing];

    }];

}

- (void) test
{
    if ([UserInfoTool getUserInfo].token.length == 0) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate alertViewLogin];
        return;
    }
    
    self.rightButton.badgeBgColor = [UIColor clearColor];
    
    NSArray *menus = [MenusModelTool menus];
    if (menus.count == 0) {
        return;
    }
    
    NSMutableArray *menusArray = [NSMutableArray array];
    
    for (MenusModel *model in menus) {
        if (model.ID == MyModular) { //我的
            for (int i = 0; i < model.subs.count; i ++) {
                
                if (i > 1) {
                    MenusSubModel *subModel = model.subs[i];
                    [menusArray addObject:subModel];
                }
            }
        }
    }
    
    for (MenusSubModel *subModel in menusArray) {
        if (subModel.ID == MyMessage) {
            MyMessageController *set = [[MyMessageController alloc] init];
            set.subs = subModel.subs;
            [self.navigationController pushViewController:set animated:YES];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self.searchField resignFirstResponder];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageModel *model = self.datas[indexPath.row];
    if ([model.businessid intValue] > 0) {
        static NSString *ID = @"HomePageCell";
        HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[HomePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.isCourse = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        
        //如果没有下一个 或者 下一个是 标题 隐藏分割线
        if (indexPath.row + 1 < self.datas.count) {
            HomePageModel *model = self.datas[indexPath.row + 1];
            if ([model.businessid intValue] == 0) {
                cell.sepaView.hidden = YES;
            }else
            {
                cell.sepaView.hidden = NO;
            }
        }
        
        return cell;
    }
    
    static NSString *ID = @"cell";
    HomePageTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HomePageTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indate = model.indate;
    cell.backgroundColor = ViewBackColor;
    return cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageModel *model = self.datas[indexPath.row];
    if ([model.businessid intValue] > 0) {
        return 106;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageModel *model = self.datas[indexPath.row];

    MainWebController *vc = [[MainWebController alloc] init];
    vc.url = model.jumpUrl;
    vc.webTitle = model.title;
    vc.isZiXun = YES;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) jumpToController : (NSString *) businesscode businessid : (NSString *) businessid title : (NSString *) title
{
    if ([businesscode isEqualToString:shalongType]  || [businesscode isEqualToString:@"6"]) { //沙龙
        MainWebController *shalong = [[MainWebController alloc] init];
        NSString *url = [NSString stringWithFormat:@"%@%@?id=%@&locale=%@",NetHeader,Shalongdetail,businessid,[ManyLanguageMag getTypeWithWebDiscript]];
        shalong.url = url;
        shalong.webTitle = title;
        [self.navigationController pushViewController:shalong animated:YES];
    }else if([businesscode isEqualToString:newsType] || [businesscode isEqualToString:@"4"]) //资讯
    {
        MainWebController *webVc = [[MainWebController alloc] init];
        webVc.webTitle = @"资讯详情";
        webVc.url = [NSString stringWithFormat:@"%@%@?id=%@",NetHeader,NewsDetail,businessid];
        [self.navigationController pushViewController:webVc animated:YES];
    }else if([businesscode isEqualToString:liveType] || [businesscode isEqualToString:@"8"]) //直播
    {
        NSString *uelStr = [NSString stringWithFormat:@"%@%@?liveid=%@&appkey=%@&locale=%@",NetHeader,Liveplay,businessid,appkey,[ManyLanguageMag getTypeWithWebDiscript]];
        
        MainWebController *vc = [[MainWebController alloc] init];
        vc.url = uelStr;
        vc.webTitle = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([businesscode isEqualToString:teacherType] || [businesscode isEqualToString:@"9"]) //讲师
    {
        NewTeacherController *newTeacherVc = [[NewTeacherController alloc] init];
        newTeacherVc.teacherid = businessid;
        newTeacherVc.nickname = title;
        newTeacherVc.userid = businessid;
        [self.navigationController pushViewController:newTeacherVc animated:YES];
        
    }else if([businesscode isEqualToString:specialType] || [businesscode isEqualToString:@"5"]) //专题
    {
        
        NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ClassesInfo,[UserInfoTool getUserInfo].token];
        
        NSDictionary *dic = @{
                              @"classesid" : businessid
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

    }else if ([businesscode isEqualToString:courseType]) //课程
    {
        
        //根据format判断是课程 还是 音频课程
        NSString *likeUrl = [NSString stringWithFormat:@"%@%@?index=0&count=100&courseid=%@&token=%@",NetHeader,GetCoursesDetail,businessid,[UserInfoTool getUserInfo].token];
        
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
        
    }else if([businesscode isEqualToString:voteType] || [businesscode isEqualToString:@"7"])
    {
        NSString *uelStr = [NSString stringWithFormat:@"%@/mh5/vote/votetags?id=%@",NetHeader,businessid];
        
        MainWebController *vc = [[MainWebController alloc] init];
        vc.url = uelStr;
        vc.webTitle = title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    SearchResultController *searchVc = [[SearchResultController alloc] init];
    [self.navigationController pushViewController:searchVc animated:YES];
    return NO;
}

- (void) videoButtonClick
{
    SearchResultController *searchVc = [[SearchResultController alloc] init];
    searchVc.needSearch = YES;
    [self.navigationController pushViewController:searchVc animated:YES];
}

/**
 *  是否可以打开设置页面
 *
 */
- (BOOL)canOpenSystemSettingView {
    if (IS_VAILABLE_IOS8) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

/**
 *  跳到系统设置页面
 */
- (void)systemSettingView {
    if (IS_VAILABLE_IOS8) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end
