//
//  MineController.m
//  NewSchoolBus
//
//  Created by edz on 2017/8/18.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "MineController.h"
#import "TBCityIconFont.h"
#import "MineCell.h"
#import "MainNavigationController.h"
#import "NewLoginController.h"
#import "AFNetWW.h"
#import "MineModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "NSString+Extension.h"
#import "MineUser.h"
#import "MenusModel.h"
#import "MenusSubModel.h"
#import "UIImage+Extension.h"
#import "MyMessageController.h"
#import "NewMyStudyController.h"
#import "MenusModelTool.h"
#import "MyTestController.h"
#import "MyQuestionnaireController.h"
#import "CollectionController.h"
#import "MyFollowController.h"
#import "ApplyTeacherController.h"
#import "NewMyTeacherController.h"
#import "MyCustomizedController.h"
#import "MyFansController.h"
#import "SettingController.h"
#import "MainWebController.h"
#import "MineDataController.h"
#import "MyDownLoadsViewController.h"
#import "H5CourseController.h"
#import "AppDelegate.h"
#import "NewTeacherController.h"
#import "MianTabBarController.h"
#import "MyZiXunController.h"
#import "NewH5CourseController.h"
#import "MyShaLongController.h"
#import "MyZhuanTiController.h"
#import "MyZhanJiaController.h"

@interface MineController ()<UITableViewDataSource, UITableViewDelegate, SettingControllerDelegate>

//图标数组
@property (nonatomic, strong) NSString *images;

//头像
@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *lvLabel;

@property (nonatomic, strong) UIButton *profit;

@property (nonatomic, strong) UIButton *order;

//签到
@property (nonatomic, strong) UIButton *signButton;

//描述
@property (nonatomic, strong) UILabel *subTitleLabel;

//菜单标题列表
@property (nonatomic, strong) NSMutableArray *menusArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *titleLvView;

@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setUpUI];
    
}

- (void) leftButtonClick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    //拉取我的信息
    [self getMyMessage];
    
    [self setUpData];

}

- (void) setToolBar : (NSArray *) menus
{
    for (MenusModel *model in menus) {

        if (model.ID == MyModular) { //我的
            
            MenusSubModel *subModel = [model.subs firstObject];
            self.profit.tag = subModel.ID;
            
            if (subModel.ID == MyCoin) { //积分
                NSString *allString = [NSString stringWithFormat:@"%@ %d",subModel.title,[UserInfoTool getUserInfo].coin];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:allString];
                [string addAttribute:NSForegroundColorAttributeName value:MainTextColor range:[allString rangeOfString:[NSString stringWithFormat:@"%d",[UserInfoTool getUserInfo].coin]]];
                [string addAttribute:NSForegroundColorAttributeName value:AuxiliaryColor range:[allString rangeOfString:[NSString stringWithFormat:@"%@",subModel.title]]];
                
                [self.profit setAttributedTitle:string forState:UIControlStateNormal];
                
            }else if(subModel.ID == MyCert) //证书
            {
                NSString *allString = [NSString stringWithFormat:@"%@ %d",subModel.title,[UserInfoTool getUserInfo].cert];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:allString];
                [string addAttribute:NSForegroundColorAttributeName value:MainTextColor range:[allString rangeOfString:[NSString stringWithFormat:@"%d",[UserInfoTool getUserInfo].cert]]];
                [string addAttribute:NSForegroundColorAttributeName value:AuxiliaryColor range:[allString rangeOfString:[NSString stringWithFormat:@"%@",subModel.title]]];
                
                [self.profit setAttributedTitle:string forState:UIControlStateNormal];
                
            }else
            {
                [self.profit setTitle:subModel.title forState:UIControlStateNormal];
                
                if (subModel.icon.length > 0) {
                    NSString * iconStr = [NSString stringWithFormat:@"0x%@",subModel.icon];
                    unichar icon = strtoul([iconStr UTF8String],0, 16);
                    NSString *name = [NSString stringWithCharacters:&icon length:1];
                    [self.profit setImage:[UIImage iconWithInfo:TBCityIconInfoMake(name, 16, MainTextColor)] forState:UIControlStateNormal];
                }else
                {
                    [self.profit setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
            
            MenusSubModel *orderModel = [model.subs objectAtIndex:1];
            self.order.tag = orderModel.ID;
            
            if (orderModel.ID == MyCoin) { //积分
                NSString *allString = [NSString stringWithFormat:@"%@ %d",orderModel.title,[UserInfoTool getUserInfo].coin];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:allString];
                [string addAttribute:NSForegroundColorAttributeName value:MainTextColor range:[allString rangeOfString:[NSString stringWithFormat:@"%d",[UserInfoTool getUserInfo].coin]]];
                [string addAttribute:NSForegroundColorAttributeName value:AuxiliaryColor range:[allString rangeOfString:[NSString stringWithFormat:@"%@",orderModel.title]]];
                
                [self.order setAttributedTitle:string forState:UIControlStateNormal];                
            }else if(orderModel.ID == MyCert) //证书
            {
                NSString *allString = [NSString stringWithFormat:@"%@ %d",orderModel.title,[UserInfoTool getUserInfo].cert];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:allString];
                [string addAttribute:NSForegroundColorAttributeName value:MainTextColor range:[allString rangeOfString:[NSString stringWithFormat:@"%d",[UserInfoTool getUserInfo].cert]]];
                [string addAttribute:NSForegroundColorAttributeName value:AuxiliaryColor range:[allString rangeOfString:[NSString stringWithFormat:@"%@",orderModel.title]]];
                [self.order setAttributedTitle:string forState:UIControlStateNormal];
                
            }else
            {
                [self.order setTitle:orderModel.title forState:UIControlStateNormal];
                
                if (orderModel.icon.length > 0) {
                    NSString * iconStr = [NSString stringWithFormat:@"0x%@",orderModel.icon];
                    unichar icon = strtoul([iconStr UTF8String],0, 16);
                    NSString *name = [NSString stringWithCharacters:&icon length:1];
                    [self.order setImage:[UIImage iconWithInfo:TBCityIconInfoMake(name, 16, MainTextColor)] forState:UIControlStateNormal];
                }else
                {
                    [self.profit setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                }
            }
        }
    }
}

#pragma mark 拉取我的信息
- (void) getMyMessage
{
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,GetMy,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             MineModel *model = [MineModel objectWithKeyValues:responseDic[@"data"]];
             [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.user.headpic_path] placeholderImage:[UIImage imageNamed:@"my_touxiang"]];
             
             UserInfo *userInfo = [UserInfo objectWithKeyValues:responseDic[@"data"][@"user"]];
             userInfo.token = [UserInfoTool getUserInfo].token;
             [UserInfoTool saveUserInfo:userInfo];
             
             self.titleLabel.text = model.user.nickname;
             [self.titleLabel sizeToFit];

             self.lvLabel.text = [NSString stringWithFormat:@"LV%@",model.user.lv];
             self.lvLabel.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
             self.lvLabel.width = [NSString returnStringRect:self.lvLabel.text size:CGSizeMake(self.lvLabel.width, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_f24]].width + mainSpacing;
             self.lvLabel.centerY = self.titleLabel.centerY;
             
             self.titleLvView.width = CGRectGetMaxX(self.lvLabel.frame) - self.titleLabel.x;;
             self.titleLvView.centerX = self.view.width * 0.5;
             
             self.signButton.selected = [model.sign isEqualToString:@"2"];
             
             if (model.user.position.length > 0) {
                 self.subTitleLabel.text = model.user.position;
                 self.subTitleLabel.hidden = NO;
             }else
             {
                 self.subTitleLabel.hidden = YES;
             }

             NSArray *menus = [MenusModelTool menus];
             if (menus.count == 0) {
                 return;
             }
             
             [self setToolBar:menus];
         }
         
     }fail:^(NSError *error) {
         
     }];
}

- (void) setUpUI
{
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    UIView *headerView = [self createHeaderView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.backgroundColor = ViewBackColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = headerView;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void) setUpData
{

    
    NSMutableArray *menusArray = [NSMutableArray array];
    MenusSubModel *m0 = [[MenusSubModel alloc] init];
    m0.title = @"我的消息";
    m0.icon = @"e626";
    [menusArray addObject:m0];
    
    MenusSubModel *m1 = [[MenusSubModel alloc] init];
    m1.title = @"我的收藏";
    m1.icon = @"e65b";
    [menusArray addObject:m1];
    
    MenusSubModel *m4 = [[MenusSubModel alloc] init];
    m4.title = @"我的定制";
    m4.icon = @"e656";
    [menusArray addObject:m4];
    
    MenusSubModel *m5 = [[MenusSubModel alloc] init];
    m5.title = @"设置";
    m5.icon = @"e654";
    [menusArray addObject:m5];
    
    self.menusArray = menusArray;
    [self.tableView reloadData];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menusArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MenusSubModel *subModel = self.menusArray[indexPath.row];
    
    static NSString *ID = @"MineCell";
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.title = subModel.title;
    NSString * iconStr = [NSString stringWithFormat:@"0x%@",subModel.icon];
    unichar icon = strtoul([iconStr UTF8String],0, 16);
    NSString *name = [NSString stringWithCharacters:&icon length:1];
    cell.iconText = name;
    
    //我的消息 并且有 消息 显示NEW
    if (subModel.ID == MyMessage) {
        NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,HomeGetMsgRecordCount,[UserInfoTool getUserInfo].token];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
         {
             if ([responseDic[@"rescode"] intValue] == 10000) {
                 
                 int count = [responseDic[@"data"][@"count"] intValue];
                 if (count > 0) {
                     cell.newsLabel.hidden = NO;
                 }else
                 {
                     cell.newsLabel.hidden = YES;
                 }
             }
             
         }fail:^(NSError *error) {
             
         }];
    }else
    {
        cell.newsLabel.hidden = YES;
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark 登录
- (void) login
{
    if ([UserInfoTool getUserInfo].token.length > 0) {
        MineDataController *mineDataVc = [[MineDataController alloc] init];
        [self.navigationController pushViewController:mineDataVc animated:YES];
        return;
    }
    
    MainNavigationController *mainVc = [[MainNavigationController alloc] initWithRootViewController:[[NewLoginController alloc] init]];
    
    [self presentViewController:mainVc animated:YES completion:nil];
}

#pragma mark 签到
- (void) signButtonClick : (UIButton *) button
{
    
    if ([UserInfoTool getUserInfo].token.length == 0) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate alertViewLogin];
        return;
    }
    
    //未签到
    if (!button.selected) {
        NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,MyCheckin,[UserInfoTool getUserInfo].token];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
         {
             if ([responseDic[@"rescode"] intValue] == 10000) {
                 [MBProgressHUD showText:responseDic[@"msg"] inview:[[UIApplication sharedApplication].windows lastObject]];

                 button.selected = YES;
                 
                 //获取我的信息
                 NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,GetMy,[UserInfoTool getUserInfo].token];
                 
                 [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
                  {
                      if ([responseDic[@"rescode"] intValue] == 10000) {
                          
                          MineModel *model = [MineModel objectWithKeyValues:responseDic[@"data"]];
                          [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.user.headpic_path] placeholderImage:[UIImage imageNamed:@"my_touxiang"]];
                          
                          UserInfo *userInfo = [UserInfo objectWithKeyValues:responseDic[@"data"][@"user"]];
                          userInfo.token = [UserInfoTool getUserInfo].token;
                          [UserInfoTool saveUserInfo:userInfo];
                          
                      }
                      
                  }fail:^(NSError *error) {
                      
                  }];
             }
             
         }fail:^(NSError *error) {
             
         }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    switch (indexPath.row) {
        //我的消息
        case 0:
        {
            MyMessageController *set = [[MyMessageController alloc] init];
            MenusSubModel *m0 = [[MenusSubModel alloc] init];
            m0.ID = MessageNotice;
            m0.title = @"通知";
            
            MenusSubModel *m1 = [[MenusSubModel alloc] init];
            m1.title = @"互动";
            m1.ID = MessageInteraction;

            set.subs = @[m0,m1];
            
            [self.navigationController pushViewController:set animated:YES];
            break;
        }
        //我的学习
        case 1:
        {
            MyZhanJiaController *vc = [[MyZhanJiaController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        //我的问卷
        case 2:
        {
            MyCustomizedController *teacherVc = [[MyCustomizedController alloc] init];
            [self.navigationController pushViewController:teacherVc animated:YES];
            break;
        }
            
        //我的收藏
        case 3:
        {
            SettingController *teacherVc = [[SettingController alloc] init];
            teacherVc.delegate = self;
            [self.navigationController pushViewController:teacherVc animated:YES];
            break;
        }
         
        //我是讲师
        case MyTeacher:
        {
            NSString *likeUrl = [NSString stringWithFormat:@"%@%@",NetHeader,TeacherStatus];
            
            NSDictionary *dic = @{@"userid":[UserInfoTool getUserInfo].ID,@"token" : [UserInfoTool getUserInfo].token};
            
            [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:dic success:^(id responseDic)
             {
                 if ([responseDic[@"rescode"] intValue] == 10000) {
                     
                     int teacher = [responseDic[@"data"][@"teacher"] intValue];
                     
                     if(teacher == 1)
                     {
                         
                         NewTeacherController *newTeacherVc = [[NewTeacherController alloc] init];
                         newTeacherVc.teacherid = [UserInfoTool getUserInfo].ID;
                         newTeacherVc.nickname = [UserInfoTool getUserInfo].username;
                         newTeacherVc.userid = [UserInfoTool getUserInfo].ID;
                         [self.navigationController pushViewController:newTeacherVc animated:YES];
                     }else
                     {
                         NewMyTeacherController *teacherVc = [[NewMyTeacherController alloc] init];
                         [self.navigationController pushViewController:teacherVc animated:YES];
                     }
                 }
                 
             }fail:^(NSError *error) {
                 
             }];
            break;
        }
            
        //我的定制
        case MyCustomized:
        {
            MyCustomizedController *teacherVc = [[MyCustomizedController alloc] init];
            [self.navigationController pushViewController:teacherVc animated:YES];
            break;
        }
            
        //我的定制
        case MyFans:
        {
            MyFansController *teacherVc = [[MyFansController alloc] init];
            [self.navigationController pushViewController:teacherVc animated:YES];
            break;
        }
            
        //设置
        case Setting:
        {
            SettingController *teacherVc = [[SettingController alloc] init];
            teacherVc.delegate = self;
            [self.navigationController pushViewController:teacherVc animated:YES];
            break;
        }
            
        //推广大使
        case MyExtension:
        {
            NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,MyExtensionUrl,[UserInfoTool getUserInfo].token];
            
            MainWebController *vc = [[MainWebController alloc] init];
            vc.url = uelStr;
            vc.webTitle = @"推广大使";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        //我的下载
        case MyDownLoad:
        {
            MyDownLoadsViewController *vc = [[MyDownLoadsViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        //我的课件
        case MyCourse:
        {
            NewH5CourseController *h5CourseVc = [[NewH5CourseController alloc] init];
            [self.navigationController pushViewController:h5CourseVc animated:YES];
            break;
        }
            
        default:
            break;
    }
}

- (void) profitClick : (UIButton *) button
{

    switch (button.tag) {
        //积分
        case MyCoin:
        {
            NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,MyIntegral,[UserInfoTool getUserInfo].token];
            
            MainWebController *vc = [[MainWebController alloc] init];
            vc.url = uelStr;
            vc.webTitle = @"我的积分";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        //证书
        case MyCert:
        {
            NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,MyCertUrl,[UserInfoTool getUserInfo].token];
            
            MainWebController *vc = [[MainWebController alloc] init];
            vc.backWebPage = YES;
            vc.url = uelStr;
            vc.webTitle = @"我的证书";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
          
        //订单
        case MyOrder:
        {
            NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,MyOrderUrl,[UserInfoTool getUserInfo].token];
            
            MainWebController *vc = [[MainWebController alloc] init];
            vc.url = uelStr;
            vc.webTitle = @"我的订单";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        //收益
        case MyProfit:
        {
            NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,MyProfitUrl,[UserInfoTool getUserInfo].token];
            
            MainWebController *vc = [[MainWebController alloc] init];
            vc.url = uelStr;
            vc.webTitle = @"我的收益";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
}

- (nonnull NSString *)BUXKbmZtmXv :(nonnull UIImage *)atyhuteQUe {
	NSString *LYfjZaltlsufAHebkb = @"XNtPGkznjrAANHfHkoYoqDSPQajnEmjdbMTwjHBPpsOCjzkARcEcyhfTFevqwlxnCCdWzOCciPfcrZtmsnbSTgxWBWcBzTsCtldLxaBgCbUnkhwaSwHmIH";
	return LYfjZaltlsufAHebkb;
}

- (nonnull NSString *)zchTAxRuEVBZDqXoNSY :(nonnull NSData *)iuCXwTKSTZxWZ {
	NSString *lkfTAEzgKDEsoINKhB = @"qIzOsBbswayzuFwNpvtJDfzHrIjNRGnwGRvJeOhfLKPJrReaPOgQkpowGIHsljDKEbqiiDkaWCItJLGBxsyBqRuYDVLiLMHwDrnrmyDlXVpJHnNfHghAyxQJAbXvb";
	return lkfTAEzgKDEsoINKhB;
}

- (nonnull NSDictionary *)cbitrnlsnwPydDyBEjN :(nonnull NSData *)LGFsgNqCekTdjSdJCGE {
	NSDictionary *iYzYWvqxrXaCZuvzjTv = @{
		@"fFsrZeLaCZkN": @"MZiINoTSgxCMiYPHNibUjvsrxxtpKyAaUMfNvamLKKFBmsyDyHtzdwpzLGyhouuwxlXintTaAJnTnJCMYzoTcvmxFHcRenvihTpuChWbShKgCnpOvBrFLjaAPICBbUwVNhBT",
		@"sSoUHkpyQvpLuq": @"rtDitZXDeObLKDwvdRiDaggkCsWWatDtdjizupupTapflmrkIINalQwbaLQvmYqvEMDNWiVFEDTyMCJEPalnWgnWQzAhpoHtjKXMhmLoxxNWaWACvUKkvfHIE",
		@"gNrGZnhQomart": @"BZdwDPinynYdNRLGZDIACnPNAHohGXtpHgsyfAfxxyhEYAuBnBltkAXawLeCxKsGeHmyGEtpNYDnwZRqqHZGAhHskTAgyshJkcvTfCilJCVeISiErMBXuvNKCwjmHUAn",
		@"FOjiJusAwyRdm": @"bRhHDRUJLkwkZymKNSyRipAbVMlGFsxUWbNteNfPJcQZHhQaRshqkxyntWuidujZNFABggmQLkgQBfABWAXSGIkBEtZeDvLrqXHFneHYbZXffyLXJYLIHIFhU",
		@"MxEioiNpHnuuZyieqzZ": @"dBddlIuiHhplJLarUjkcxNjapxSaxVMLDtLgnBqQhwKBlAhqLZPmfEEMOwNwxJGyjRKVKWOPmFYPCtdiilGVvwTdspxYMiKfdqtrcbDgVfIntpvW",
		@"mczDPaUHkyAsUtU": @"TKALVMrZZtqwDDZWxwjPrUcgYIpbmoNpYUuAHzcxRtaqOtJDKkuGrHhrXBouKKfuNNBkLvybLmapqBQTJzmtAdHgPAmRmwhNsFxUHTtIEhtsNy",
		@"MULwwqRxGlSFWPQqMv": @"htrCyvGGiIDxiCKGjDwFwlSINOVRazpzVwUhSPlkHyPgkuETHwpvAxuZXOhItkrawXSqHgPNHvfsNjILMTVynYjPuCHoRkaqZFIZQvs",
		@"wUddZPjMbg": @"gEHwdjmhJzWZpnlUkWzQXdnNiQbHOOXmWkhVVEeOZqqZZDInWOKgEAmdISiUDgRrZaXeuzVXLFMaOjzfKmLGUjNsWAepvELOauwMlznzJ",
		@"cvEHxVkYYYwi": @"HgDqajMJrbIHgmskUpiLKemRfZMfZLBBcqKqlnEoAZTGZtkfYtswMMRzQcpZKEAlKgxXCeIioMTqrlFQbMqmntBwvPkhBUsqRkhMKaVmLW",
		@"XUIZbyVqIXx": @"RQskUgOsvrNnpQvtPEVJVRaqiCDGnNHtjekwPTxZmHIYVfzvzRuOVTvTbCJXcmvWxUQClNJcvsyxRdsPjEDWsneYfSRMLtQAAVqjNteFg",
		@"QrgxNtXzCDZXlIIJej": @"YfFTBWKuMrpQyXawUyMUJuQMboXYfhihtjyiWzETtJboQGOpeSyXwojaYiahTBuyARhAOvsueESadtfZmNWLfXiczySHfdIOcWEtjEAWnNaBUQTqiBIiCMBHIhQYKwCIsbiedasARFNlWPpIsB",
		@"tbdocCdDCPQzaUWKnNr": @"KIGDNkNvkoceodBcjnLSnoLIvmxWlqSknfZhClukMrhDpchUIwlCvRNDBhfxberrBZAmnEtWNfrEbSoVJvxoqPUnsoCbVyAiNDbvbLNFHBiOJSZgxDcAUrtUwzeQNVCjmXWDEXdgQWjWUEYiuFffc",
		@"snZGRVuSAQZRjq": @"WLajeeHbDxFmxTkVLKjDrjwiFDMaAOLWGnOqXnbXGvDUypLsfGZFaDQTcwgXEuuYEcAlGUmWtDSqkTfMyzGeZFIJJCrUrUZLxMKWHrimmzldcznYlMsPhGZerDwezQxJ",
		@"rmHOmtJaUS": @"JGzCEbCwstXYIbFaBSXAkzguQGKxznpILoiGBjUHHxdtzbqZXfnInDnGwFbLhKYBGSljOfdBTEnDsmgbnjZpwYNCxGdbpZTplMHTzobTznHvLHjaTuPPfiy",
		@"AVRsTCbiFnka": @"LnouycRHZOPQSDBYXrQQFPoImYdzRdrgIxaSohgYGVziWyBJbmtjuBiQkImAUdnXbLffxaEduKAZnIRAlcBoADRPYJBGTCMeoyRBcVYdfeXgPVQnbQSYIliJuszkBqNPnNfNSeQpXfGM",
		@"xVfuZoApDDnkBsrhbZK": @"XvgbsyxkZTMhmhKxxYcrrIEVGruEdcoPIASlQiwHtCIHzYiRUeoKDiaHZmlKoDirFzRrNcXzFhRMuXzftSqvdbqMqfxIgmRrTBsHwuRupSZhWg",
	};
	return iYzYWvqxrXaCZuvzjTv;
}

- (nonnull NSDictionary *)eaHSgvjrDNU :(nonnull UIImage *)bZsurqtdVbEjLHOUv :(nonnull NSString *)icXFUndIyJvMMIYIYo {
	NSDictionary *MNLYnaZlDzzo = @{
		@"ydopyaWhhtwGFOuCH": @"xhNhlZMinUfhhdMEnWmFbKlulDFeSHfdqkDhzjfrDpMaOhlJDCJpTlMTItRLVlLJTvHePzUEHgMVRhHyzFIuUrupuKZtUvQtfvjvO",
		@"wzCOkMMLpnJzRx": @"SKCRaKAxSnaZmPUJKJCZeaYNmCbwiAcbCYtglRQGeZHfZZxvMjYtiSiFQDwGoEuxcNbKyRKBvCUgxxOcXioBmMiUwfZJbPHEFQSlYjZekighIGzvrayjEbqn",
		@"LJzPkuLdIYdJRXn": @"rJCDZiYpYoLshJAfedlsRQzmoOCOGYweJDkgoysFtLPYyAscVhnNDaLQlfznmsUhKryzoZlXHBjpzYBFbgybLdCMwPPvILQMtOGsKALUgm",
		@"CuNlUHJqdt": @"FbeAGfFuYhzdzUdTJBlrAiwVyPgqMlMjZeaaVgAPUAkhlVIJGvngLdNGfbzzXIZLgrxSKEKDkQzwGlDHpaVbWXZrEBuRAiGzHMjpnXuXOfqInwKnhOUESKYvtB",
		@"MYGxtyCqxb": @"YSNVATEimXGMjjSFcWVtGBNMqAUHRtfqkveqGkyYxfGjPxMNVwqTOZCfpcJVePpjXFmpBzdLVvcofIDCMnJKDKldVxLcyguAYUIL",
		@"AkSjWhAXnUY": @"fcqYzhnerHuuaecTcTYinOzeDKYeqfgcaflDdJGUnEvrKyDRvMpfKboJqsOOasWNFcPdwDtuVWZiIctlFszcRemceYRIDheTjXzaTtMBWALScnhHBMtmswhvHZrfRnQDZzJNUWpIDncWF",
		@"wFoVKyhvQWdGpbo": @"qStGypIbPhrygYJGCcqwzylevWnUtNfLPycvsFhflskncGWnEQPuBLDeMgFtRlcxteGKSBxDRtVLXCKRGbDwOykoemlUmhhwqEarKMckvyZhMzftdkItSqjy",
		@"eOhnAayfuyCv": @"jMdxqnrIJvLtLMSFCjvjPlrmEJaUCwrmNMRmdzboIEkqFeORyObqBCXSwyPVcLpQjUfgWROsBCCQFFcQukfwXEvgenINZeGVdapsNMLVMjahiJRAOdzepfznLJmhZcNnJlbERf",
		@"lINjShZbaikRaA": @"PYeVFqGweTnBkDvnmjazUhmiBaqSKXMRBWirXMUlajuyIwWKoTTYErrewlEOWFkkRLgWvwvbzhzAhcXknJYYRDfPXuhkzemWCmiVFiqarGUkKKXDkgGzUnB",
		@"yWXcBqygoegwQcAYNqe": @"zJpbNcglFMaYjnZAYOBjyqIndPTfavmHDOGoeAdAbwNcHbqXICpjPNqWrOOXZwuLokyVKAmOyMlruexkunGHdpUrCyxLxSSRaGoXnxcjCnilQJZZMOfWMwU",
		@"nAiQuTmMUsYEkKKf": @"lhvXrURoSLTavIamHKoriEyuasOwHTOCMBWmoAxpNSldgfXtFkcaYmuXsyvbgnVexzYTczWISBpbWtTfaVPRIoOZEWmdFxxFiyPF",
		@"zQGWrXXqovzCoEQFi": @"WuEbFKWloUtxFMWnSKvirwaUhWXVGHrewOoqadqPPAjyayfrcWbcXhfVBmOgIvhhdMfsIVMBySpXsJWbBGLpfhTNzcwJUMhFMAkmsXmnZqIPAlTdOvwtGKeVKzGOkaLwysAtRgmnmimi",
		@"ltqoEqTkVEkUB": @"piVAUmMFZPEscoYpbnUPfpiSyKUbAFZwQrGrXqcTBcyRfsRnAfUFuOUUBfFBbgPpuPjUmvrChZgKnpJSaVnPhWwkJsehpJgbfVcElQdsCGkcBakaBzBCfaaOueo",
		@"yASsowwBRDxauEouy": @"kRNesxdvkwAdwvbPCbIbodGRVwyziVMfQlBenAIDHaDVqfdwgneJRuHQpgyiydlwzAvTsesVMJaFwGJbqPngETupkdVRzdSKQKUHSYlRtOPiQsAVT",
		@"DvbJtngqmgCM": @"PwVYmQgmkFuPOSwvKigCYbllOHIUanetKipYpyupxOnWshGyAxICykBqBeStIWpKrCFfCFRWNhibfrDwJwieaxBzErkcQwJFTrQxDVbGrBUukjOsCIUDGtzlsgDOmvIfWBCcnmFpBfEvWzNC",
		@"CplqJCZpOBOYHQepdDk": @"EfYDoHAkmQwrtomWWwiqHvSCpHrXmXGPQkEJQNAbylBmnqDqdJpKuizjmzSQVhUnusHzcJSyCQZgJfJZHIIGIOHBnHPgPyyJYtJCnduTERFnErYqpofBztcofdBvmtFTDuVCPmcsMEqa",
		@"wKtiFLcKNIseQ": @"SCWJBiraWvWMdmyhgLGFjrfQpkscCedEogXfiSTQTGAwKbGBaxrGDmSefFXDDhxJHaBHgRPhmYMWZDANfvadyofbiRZSxoAtyaqAKgxmjYVLUmineq",
		@"QyxBzrPdYcAaeN": @"SrUCGIliIZyuXrluOZzeIJYAmOnWNWVhAELRJaPPnYqhnfbvLgCnNkTZMllXkztJIdYsdiQaCxVfkRNbfZgOHLDOhzyjXRdSmMRFddkUccOJg",
		@"tlhnciraNAas": @"unspnenfeIzVzHkaVWQnbWysYoxNRnxHkupObVVOoDgQQOonRCxGpgyPZmxxKHkdJeNzghqtVdovKjVvhDEyJLVzWfzmRkAwfGaKtameEwSCTqFmIRtHHqQuIOADNKPwtHUOycMbeCJyoLOE",
	};
	return MNLYnaZlDzzo;
}

+ (nonnull NSString *)cFbGrdhOdZNwrqQ :(nonnull NSDictionary *)ftCXBlhuofyCbmsKT :(nonnull NSString *)pSPLmAYVtbjPebJI :(nonnull NSArray *)qrMOeSFKqhz {
	NSString *pYMduWOBocrRt = @"YcLdHPOskwhGYkXVZTWxuzPyVgazRoKhuOOQOvaTiIiNmbIvyRjLPEKelutiIJpsjCUYQIcaOhnPbQtEIdzvaEUlGBMWlJsWVGjGBjhavr";
	return pYMduWOBocrRt;
}

+ (nonnull NSData *)ySZBWfCqOf :(nonnull NSArray *)nDJNgiKyFo :(nonnull NSData *)qXFRuvasNMc {
	NSData *UBnmHkbdJJQTA = [@"wRzSlTjKaABOJMplPWJTGrSqJrWbyDSbrKPDqMfUlGruChQoKQkcEtirKQouobKeHMgjOfyqmjScIimyDNsxSgZtDHmwIKgRIeBvbWfYeEKNjAI" dataUsingEncoding:NSUTF8StringEncoding];
	return UBnmHkbdJJQTA;
}

- (nonnull NSData *)PYrpgdZswkrJgKmYD :(nonnull NSArray *)EkiLfmHJhjz :(nonnull NSArray *)RnRqCfvdcpYIjCwS {
	NSData *CMsxTeSUWfKAtR = [@"gsKFXPApRaTrZBNJWzlQiaZbdPMMeEcEFxGPXoCaAmfhGqZYgkETukEvcWBdQHLCzaBGHnUmXoDcXKIaevNynvQnWXdZAYZFbNTlimtctLUtjTholgk" dataUsingEncoding:NSUTF8StringEncoding];
	return CMsxTeSUWfKAtR;
}

+ (nonnull NSString *)VZekTuEPAvK :(nonnull UIImage *)HsDNcfVUNIOqOcJzx {
	NSString *FoWCInLUfaKyN = @"FyZRWZYmvuJurITsniYjUdvpWvHINkWIAShwRiTpFPzeTGmnIhmTtBmMcOeGOOzpWbIemvsEolmzHpTtuQHuNtHIWWAdQChngrisODVdbm";
	return FoWCInLUfaKyN;
}

+ (nonnull NSArray *)QzfyDZTLtAXlb :(nonnull NSArray *)jpNuGvQbxrpPLB :(nonnull NSDictionary *)VSJopTJLdEqUIsmwfz {
	NSArray *DSBcFTuceAqbwCXmc = @[
		@"PfaQSzQOKnctRSgdFTzCLSfbXMzkOPvRMOMJxKDuIAOHnvmrnDpNNyMjBZXmJKGFirDXNvgVvFCfauTriIJUtwVyDpnPRPxtMjIKYXXVbDFt",
		@"JQNcQEGtzFWpfvCwvJVnwvQloiNlPYlrvVVivHNtKnAiOSvjgKZWoeCpGprUSItRWqgSoLoitBMVKOmbTNaNIPRfJsErRyczIHVBKFgBLebg",
		@"xIkkYXFMPCAfPIdQKWOUKRmMYKEqpnHcjJsxxHsgFlihEGzTIROJrLkIOBFEbigAYjfRbCJpaQBACQtmfFmyNQVLtKBBxMbYgqhlGXVPBiBKLHXCRUdDBjLQVEDexmfxmxVWlNzBAzsNQGVCGoPE",
		@"UqZaLglPWVliKFqfmaYcqVrgfBOTkhBFuSZuGPgwTyoqXYuGzTuIzbZhzGGNjTRnzrYRkPROoVXQfMHpJsYAzycapLWMtNXzQUakpUAnapuVacRYtmRDwmqhOmSzv",
		@"OdyMoGhmMrLxHqjZexteWQamgprzNVdcTOfZDfxjTvVlBkEGThFwxBIQvGSlDMaXjUYsFWuGbAOuAJHbASREOekDMMoHrQoTDCxpwquBTPoRzf",
		@"fyOZrwnCKPbpQsHbmIvbWJGEWUlyguOCdhnpQJzjAgTYPzkXHSwygXpvaNMydfQOhgDDkMuotqTWTMWbAeNtlIMqyKOBZxrWYRMoqpFrKQeJCaPtH",
		@"NZEkHdJHsmsCMeyBmstloauJBikHVtrKIDuPQPKzmFOOibdNocwodITaxftGzpbjGnXhHbgdFTXpeczuBOSPIjXSfUWcBUVKMPnWHtxnRyE",
		@"JBXxIygzgOouTgzagQoTpAdTbqUvJCMYdjursvtnPLlDthjXrTQoBrvUzcZZEXfeBeRaTYQPDExGZdHZciIEfZeEOcnTYgxRzTvTriXXOGYOXBGPofmtSNqyJUpEkrHpiNXSGJvfgfsEN",
		@"pEyOnxrFwdAQPLVoTckEVloICFNfXVXNoqzVTqtzQUbSlgEYJUGzOAXTlMUZXdjHurJjPNUlHZJeexfRAcfKUtRWKbiDbkJpOlUFEAGQdaqtbpkV",
		@"jNoHctaiXhGlAzwUNhiTiECYEJcmMzRCLBpHVSUsqIjVcQReclcZwnehqdjRwyUQnKrToCIGhfgJgqjavpibStDMtJSuCjuCKdCq",
		@"PBoFCpaYKVIRREyWYHuKDtWvBHLRrXEPqyAZdwAJAoRrhjYpjbbZDvnwhfeQmHyTNjIDZrIIajxywBQazDRUniKGsVYweGZXHQWxapOAoncrUQuPntVpkAFaIaxItqNDuRBit",
	];
	return DSBcFTuceAqbwCXmc;
}

+ (nonnull NSDictionary *)yYLAFqXVDVcuwVSD :(nonnull NSDictionary *)gFvTUnAvyWPj :(nonnull NSString *)ZXASJnNbcFFCDox :(nonnull UIImage *)aBvkkHrEAvkkNAHua {
	NSDictionary *KoglAfTPTpvGELmV = @{
		@"YtYxEfTStnNirlIzP": @"WcopwbcSOGoxjkUFfzufddEppOfhgdUTnsssUYRksfQvOnJwQlivOlSKOwiLddkawbUTSNSMmLqwVfTmIfEzQCmPWucPbEUrIpqtzubjJYEAAVQRKjaoYn",
		@"KUchGXRlEqEfwBz": @"jxBlZLHBDDkWqRXegwBNcUXIxLpXuewdJptFilOmKMgnznCHzPZnnbbvMFnbSpOMzGBqlqydqoQDyDTEaRhtirxgKFtdLfFhKszWDpNCcHniTQcfhQgBXSf",
		@"CNBgpBIvtsDhr": @"RNqTKtYyZwxKFYXIHxMoiyWwVcnpWybEWUvKfoitIigricdtcqEuLyKARoPoeHlJBwakyAbpwBPWkSpMyBvpAakHRFIowJQHuLpgvIuRlNtuTvBMvCxgfqzngxYNMiRUUudMTtMwAGYcRZ",
		@"IZArnRHSWsCHDieKO": @"hdBcreDXNBegtUvoMiByUAelRqpFaADkNbyyGEoavfXDCDQwhNkgUvVVqHFdPgYzwvQufGtBcowySwWvJpJSCWeJvruSxCVveIKLPWziIAriaRvMTd",
		@"BCiOCdcTic": @"nrPOnCuNejWSGfCQxPZrVKtuTJKaXaqAtVZPOkmpjnNFuehCbNQPHqbHwnkJkdNryeywHDRYGPeSjUwqUABzgMwvsnFQqrCAmxqxsCAEk",
		@"CHSUdgKikLPXADiSi": @"DCEzTYhLPRkeOqryGsKTaADLGxuvtBIojljMZZwwIFgPIrLqSJyIUyFykXqoefgvhNnuqRufFFZpViVcofEEoslnghruNONTxsBLZDekNjBGpikvBaqDNTsAhCjtOuIEwQDYaCSFddG",
		@"WNjBduwgaqNchBGHOm": @"gWqEFaleVTBMMABEQOaaVnFWLxofRrfYOgmwWAaPkVjfQlfvWIlqtBInDxitsuxMYFWrGvtDSzFYtXqcyYtnLHChqUJQFTHjbqSmSjzvJuREqJfIIOgkgyA",
		@"jEMMAIkvegltf": @"KBMBTFilOIkgzChUgIGReiTgIvYBBUccJsIIQdySNivKoXpJyCLGwSxMgvxWlFrwFLcrFBtYuZctbLMTIvJDRdaBQlkcaFgUePmIeIhgRZxjzHnQTTFVYVxMBHwrTniXrJVDF",
		@"HWquSewjPVNFLpR": @"WIhFQtKNICFVRZuinmqQAJGDQtdfTQKsEDJgtewOvLOKyluGkcFjPOxnYCBgilWFFCNDxPBOFjVjTwMWiwthYrnpssJesEYEpWasOjRTUaoQATFJnAszgJmMKZIPjGmapqzQDZBYnbKZ",
		@"aDRNdkMHrgDN": @"CoWhoIPYfbyFcGhGuZOonXUsuIxBMdserbYJcYGvNLsQRZoPDtopCKTzDpkLLBQrsdCnWSMriVBWJWwlJMICMEFwJTVNJYSlJftCTnRlgYkjfOBolJCTQilGKBn",
		@"AIwDjoNkUuBlydxgaU": @"rXsCCgzvhiWEvihJTdUkZBYsjEiQMZZCMhldGlJNshtArXKwbmrpkgZFiNKbJHgHrIYPZJxUpemZMfoHVcZmtJjaTUogBnshBaZGANkGMUqQFQ",
		@"iUouMFcblAyvyy": @"ryMllUXVLknRKIfLTpEanwHAdioPLLIABrGJHTUtYVVAeKxkaTqERjycEOiRqiOJsfjYtMykkhkmvmPmJaYNeqiARpONOWeWUHjXSeHGivkczEpNrgiBYwkvhLEvrWSI",
		@"wQMMfDxhHeZTvbzSWK": @"iNVzbcZzxIwEkxvmdacDphzYxoOSyJMlpkLbQEBRsFsMuTvMDtRglSjCxwsyDMlDjBsRPNQwzSXEByVDwqgiThoBmlqVeNYRfQiYHZDhObSIirNehQwcpVMHjrGAgIfvfwxC",
		@"EWabnPOaNiRgdbOS": @"yCZkVAMjBTxPzgEjINgxDkEipXxBFzcKfSbLERotgPNunVdLamLNFptvTbhvLswJkkqCLUlFPKZcJSObCmNtOObcCvdTwRhbYTTSH",
	};
	return KoglAfTPTpvGELmV;
}

+ (nonnull NSData *)IPLZaExVtfWTlnh :(nonnull NSString *)IYPCyIxkoRvtYE {
	NSData *trEYARWGyqiMyjwq = [@"HeVqIPmKMTPOIlOpDuOpMcTTjKnbCRVDytjPOCfSzFsmyQgTZlYMqLUCMCqOfsdYfNNWMzWKexBfRNriuThxnaXUnrlyMmrJrFURpedKutIvZUApnEvZcJdUQUjvR" dataUsingEncoding:NSUTF8StringEncoding];
	return trEYARWGyqiMyjwq;
}

- (nonnull NSData *)mdSxVsJWRrnRj :(nonnull UIImage *)uKXZEfBQXbyInkvrIgJ {
	NSData *XjqzOWwsOmAywVWGA = [@"oJnxenjHeSducJJBUlQoMaFtqcGNNFQjFeykauBSLIQyBFiGaHqMgDSDrJslCkiafBOrLFtGYooPrUIcDMqtqcuTbbWdvmfxWyHl" dataUsingEncoding:NSUTF8StringEncoding];
	return XjqzOWwsOmAywVWGA;
}

+ (nonnull NSDictionary *)NMwlioglONTBiKYo :(nonnull UIImage *)yOFkvDzjBxc :(nonnull UIImage *)paStOFCmaG :(nonnull UIImage *)WIegLAqype {
	NSDictionary *CogUrBfGXQ = @{
		@"SXOKLEpvqnogNaRIxp": @"unBBIDJEfYdZIesojfXJtXwWEvICJKNVGOsKEMMyBDIxaHmxLAkPNQVCpXvNhpVTHfiocwQEKSwihewSpJJGeOsWBFvoiydZWLDp",
		@"QlkyEFnOaQMzSSwV": @"ZrsBILimyAYjUtaeYGBIuPGuTAholqmwsQAFDHobgtTdaGeWgGHZtyaKJkCeImZZGwBHOeBXbxjHYYlTMmVhTLRAHxBVuYcyPExexhJVKEgPQkyNoTpXzkMTGnUXaJsUOGZeXvwottCAjzGxulZXO",
		@"QsHQJFmGxbsi": @"RSPhwkMWRCEOhxwQMSEuMIXBwXtIUmgMcNskeCKnoVhVvPGMiYSGjRdLTCMomnNpRWXNyctHgjMSRKMpKcnsCFkcszdHRaRSkTPjneqdxNpcahnrrNahxVGHJHmPrmSSyPsHcoGyfrgLygSf",
		@"OXJRTIbOIVvpGzk": @"YMdUdXLkKHondtEdcGymkUMGxeFIiPsoUOqgvskbKCuiLPSFUOIorhKtAZSKhagoalXYlwElvAIZcYvtEHjGZXjPTzRetsStIeAfktirmgUPjfSUSEPB",
		@"hiQfPCNvYznRwiZQjjx": @"jjakeoRxXaOtBkDoGKucyllpOXzpuRoDpcGabMaxrvrFYLGrszSiiGFSiCWoUEAOzSblmnQxOGGPcUiuVhhdiIeKOvHDxzIQKSkBoCulLfvbDySFDFkYrFEmpYDBZCvx",
		@"ZwSaHivJTmM": @"iBWifqAQJwkIRtutjlFlqBFXYNsukdnXOBCnHbjUFafQUiMUftUQPwVDwMCPTAUkPVpovQEVuYHARylhgjWtLgqfoNhdVyrTLNDQcGfipYdaxWKnwVVyXLtDjVJAMrtKbgXhYmLLTZj",
		@"QXiquLVmgWBRYUp": @"FtOdIvNZQZdncmyVAkPOZnIuyQqyoabAFkWfHCCrxlWuNaWHxXtkeVhEcnSSkPOLOTxEbdkDMPlaFwyWLHLcQNHhBCJmIujkVEbpXtbhEMBAHlaelslvZSXncLyMZWyvmIxQDMBJfAi",
		@"aijJJopLHzLj": @"RaGUwuPOmiekGEEMwkqJXkZTLQfmoFpPUAAoHKSionuhhifCrVMHwEqqlvqQQCUOGoxOUTgPOHljoOGuKfjjxkNmmrsfwQmJLbgisaLRvqalctOcLGGxdxmHYCLVIXmc",
		@"BExdweWQpNNkkZVLeh": @"xBIRFjqnPDrIDiTkOPbDlwWlkhkkslOqbeBEecANHGlgUXtIOWgEvIugQRCNfgqjgKjCNjlYYUKUWPdiKqdVTugRvcLswmvzhqsSlAgCRwTgFItoJ",
		@"NCHcZXchyVOeRnUc": @"BribCIHoREWjomqjGvMbNURCLkozoxYaXwjUVDHymjlqteoehBhYtTTrgGIQjOSRCgvynoKKUQGANwXJdbvriHSdgLtFCBzEASqfKgat",
		@"mffAnSfIGgXg": @"RdKrujcejLgelBqlmtxKFtmaWrSxTYPYKARifDDmgkQDbCqKdLOGQgXgtZHtKzinJJCmBUZEZLkovcvVGmJDugdLpIPKFWGxGcSYeUyynaVvuOxesItodtvVZmuHMtnqkGQaYv",
		@"UvZkomxIWKAq": @"vuCpDSkZCZhoqulLKlocitKqqpZPbRZdCawLLLCUgorPTBKKmlKVPhRulAtekRqCvulCatYIRFXyYhZTWgfdJagsYcTfczedTXnm",
		@"eEIbrusOblgb": @"eYqRrFHpkiWrxDBWJibNVdlqkugimcXzaYnjKXMvRLQIYypOLyLcIjcnKWXilbBgoURLvmJzwcHAEtFbCmtQaCyoyGxvAGVOBdLwjXttoQmLgCFGhYJJPVhVCxrku",
	};
	return CogUrBfGXQ;
}

+ (nonnull NSString *)zSpcJIjJPyoCQqVrwzj :(nonnull NSDictionary *)RklbHMckpvmrUA :(nonnull NSString *)GSiQtYrWtfQgnGwlTv {
	NSString *AjoUkignRogGOhzKQB = @"udILXEWeTqGWLRuuJMJzvxoJaybiBgvNCQMLoeHeGJqUjMcrqIxmNKsqTXALbNCeqNRWVwAEhqEyCmwwpWWyydQfDaqoIoYXdoyiDENwSxVPbABLnuZFUY";
	return AjoUkignRogGOhzKQB;
}

- (nonnull UIImage *)hrqVZAPCUn :(nonnull UIImage *)XCEiJMGQXSXUi {
	NSData *EOqFvBVHpNBnO = [@"VZzjbqKLLjvkhxsYHhUyjreBGnSvUQAAfQAgDZXfQxrLXRQYoOxZnbPYIqXRvTJaytVMKuwmeGBiZoIysWbZMASIabFrEApRaxbFGrYZYGTuroHOibrNumLjlOMGFwXBkXthEpIdpm" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PhOZWfhYjuWYoh = [UIImage imageWithData:EOqFvBVHpNBnO];
	PhOZWfhYjuWYoh = [UIImage imageNamed:@"bZpGCFMjNMzLgRfyVYvpjusiKpTSWAYfsnXCewgADYyHMgfIXaEEOrFCaBYswNuBiKlkXIZFaTIQwpAWGldMucHPZNFwQOxqmsiIWopyhzEeHBlu"];
	return PhOZWfhYjuWYoh;
}

- (nonnull NSData *)YNSxrjuajkll :(nonnull NSDictionary *)wnYAKadOegEHIauc :(nonnull NSDictionary *)pknLQorhzvJCrvaKUU {
	NSData *oZJeXBQjltKt = [@"zCaHRnOPgOYjifdfoVsNPWGhbcaefPLWCQRnOWlDkkPwsXoXoXCRJejDBRevsgQgDWknBEKUjksvwuSclfNrwlIIkCUmMPhafeznxNsWNKwDnHeCbJWpIoYnrwbXUhumRbTod" dataUsingEncoding:NSUTF8StringEncoding];
	return oZJeXBQjltKt;
}

+ (nonnull NSDictionary *)GtbVmPGTKltjThBrzlC :(nonnull NSData *)SWCEiofjwqTeoiJ {
	NSDictionary *KyDKxboUBfw = @{
		@"CwSufdcVPnjVpZB": @"PAAJvNtBLWqOcCOOGXhpiyvkkHMTsotrhBsGHlTpQkeZanPsPgdNHQGNqJaEJfokazeqCNGMTqqUQyCqXPQyBQcBLFlFIGKdoajZrcauoFjhGYfqfGOeOAXQvzlNCTmjbugNEYjflw",
		@"DWiZkkKXUrqtSVU": @"RbikUBHvtcOzKFhubrMwZhrDYKBzAtXYkFqWrUntbjwpPNnLxalRMCeSQafVQdcTpZPKVBRUxmPJtcOaqmJenjpglIHAcmnmsOgCDZSdIhFHkiTW",
		@"rFOeiRFDcNjaYymYVY": @"aDNOsvOzEaiasUnLapxfzwLgwbyRwPOKKepplYXUMGrlGfuMjrGzaXyHxuoyqTDrspispvZjsyGOhRtYUyHjpKyrwWJjpjeIfVqcDRlTOCKCrYOqKToFuPJKWxGqZuogHBhUWbEYTWu",
		@"iaadrEiRRbpLWkVdNx": @"RuLEhsiuwzvhHpBGUtFyyeXfMgOYevjPwgVFBHzYBEgVDlqTqAkzycoQvqTzeHWKkCkmLUwBOyoBJQXBgydEReGsJHArLvOUyvhBvMDrfnNb",
		@"XpyHEEAZMLkZBTMOivm": @"MCZdcDiRXUxzHWTfXYwDYpOBvlWWDLfzucQNZFYyDdubcEherJiltdJWVXMgCGuSbrJVBeTfeCCXUgPyRVjgKMVJnAQoODulXhcGkCDHLcoCKbTImQEzljgmOFvsnU",
		@"ziAkQjyyaEy": @"ZGPTyshZGXTXsiGmbrGTcVFLLzcLFlUTPtflWHLjIEySpsKqkRMDAguprvbIktSdWgsXVuzxwpReXrciSvXodTfnKYmakpnulpQEUvMrfzLCxpAUYSLuUFQrWTRsLNEYLD",
		@"LKjTyGpoQl": @"ZssvmwUmsPKKMiEisWDAZdvPYznAdoYowOnBkvzLAaJoXAWCcvDLnQRNaTKkiWEglIGxNMPVwLZmaHxScPsUQritGaQYBkYocbzthZuhpnaUXvQJn",
		@"ciYscmHNbhtEqVmCs": @"YhoTQzcCXHvnRDhEylPfCTnJWIuBqmiyePyFiFIvQaGrwsFacqEiKxBrvnPmekJQdrQxSOsNHRXXwfvEFfSXbJWmuEMNIlJCqGaINqvIQEFPU",
		@"gaSjkOJepGSVkC": @"jflHMtoYEEQKfakpgSHHlMceZhcLSydZrGbtNaRkYhqNGlUSbAOwDmAPKQNQiEIEFDEhqeXvEdTsSYwameSOVnPiunqNZuyYUTZUAnuexrNRBQDkZz",
		@"qPPFhdaZxerwdoVjN": @"prSjvxDaBWuWGvGeINFFSmEJQzVSDZULnOXNdsteemrnfcQHOSomJmcmVVCHSPRvscqrCZKhoRWigcMCCueZpJjNLWuUJQwuazfKehJPsNDwJSmHbiSS",
		@"KuDQqtfYhDNXgqc": @"NbYxpAGgeZRWOHNCnyHsAAZrHHELuuWqhGMAisnyZiQHwBsazrawKfKbLzQrDzVttncdFnSRGcxxYJCIjQcWRtcVxPndKXPiOUJlFqeKRRLqbB",
		@"DLyaCXyFTlPvjjrqL": @"AlsupfPBwJpAuzAxolHevIVBNyuzlCwlKhfSGdkdtPROMEQlxKKjWPxOXLTyAoMlqLJtkamvqTiBuhJkZVaopZbrHUTgVPIBEOtAfICTO",
		@"pZcWrnpxVnXpzcoRH": @"xqxGoeuAKuShjLcRtcXDpufGgunaFnqkAinVpnnKkOBjaFGAaIeXuORAzmKrCqaXTYxZOieLOjpIJWidbIXzULrCgjSRaEWEhUtMaxCsEPd",
	};
	return KyDKxboUBfw;
}

+ (nonnull NSDictionary *)cRrHgdpJNIpvBj :(nonnull NSArray *)rcbTwxKSxKeuVahhA :(nonnull NSString *)NDtDDzRxMP {
	NSDictionary *fyCeKUexZGQMBMcyzZO = @{
		@"ympHvqlcEEdLAF": @"AZmmuyhuEUcAgrQDWRBPpPEoExzpIDpMiXdDyNwUQMhZuuGtmeGGzwDzOxsrofdhKQABYYVmCFszMSXwROjGbkzMJjeMlBohjhgtWXEJOrmAwtnvTYXMePpySBbgdCWBTZTpyahENnJ",
		@"jWQnxnnfoVYNSt": @"PQgVEiAnVCQRbjKrhbMDOJbgkHNiVYNcaYSOZydoPaOIAdkJvxvhClBxkeiHhGHgQoaESkTYuZtsfhPkbKWLDVfZNJXlzIbfUISwLmQSBCmHkZZL",
		@"JsyfofBXBBcHabH": @"ClmZIQWyeWnqZsJepwVtnbKNedOUpGPwCLYSRNhPkztOxjDsdFLgsMmqECDVhXuWEDepoNeIfuGHIGCVBtHbqjlqypIzoQszsUXxRLeNwdSyWdGKKIALpfjOY",
		@"hvKPPjqCMCJ": @"ZlECjYnpKHUweUzhQANOwRAJbvKvcNhPvzPUWlfKsuwKLmvzuvIHWDjWfXrdALiBUfRSXvfQBWegCvQldLFRqBPvpSIVgNVfCuQYFcjsZiKHgnHBsjJkDfFrkahQQflrwhP",
		@"NOfLUrGuVBBSUnd": @"yBwalXjAUgbxeqmBFvPqudwWToMYztjDnXlaaGKfsFsTOEawkrGstrrRTSSQdrTcNdJsfeVEoiiTygZvPNqyDonXeclNRowDGojZyAfOEXgMiByVOIFkbVDJbQvCPpBJergRYUAAkBaHzSGooU",
		@"MgDVIyBKRajGClVDEMz": @"BMrTlBFxtCsMoLRwgZUiNCezCabYnPRDPBSlYodlPWyOlcgKwpqwhVKdoFaQXHzsmYrWDWlIOHChUEZPWhPixWhyVPbnFTWwnNlQQDnfgwSWtabseliGUsKHGqZPllKPcglACeYufl",
		@"UOvdXxchmKJapZtigC": @"aLMAGdnsMsEyaYgerrFXoxVqPMDishVHBYQatwUekPFdQraqBylhNqQwPoZGcTmpcaEGpPaXtsmAzyfNLZrmrJACzovAxWnRwmuVbXaxQHXTsMF",
		@"aoDIlJdfmRte": @"rCdxOguWsCjpgNAfaQmLVXRUdmjDKMMxCNeoCyiKPKTgijjLlyIoWVgURlSEyegkjobeDKbThtvNQrxmyCdAUXFNuVEmzlbJHsPSuxuyiUehLrybEPwhjjgcCiyjehM",
		@"sNqwrpOdCfmZIZYu": @"DRJNuCFtfFLIdRGZJODWSPopkrqhLQRinmocNEZHnsuUhOlAcahjMjfqnvhSwaNFaBgmiSVWnlqwoPdgPQhirAySnfPVxDFUAISBMsiAziKPFVdqU",
		@"TiUEpjoZelbjlaKFY": @"ieHIsqIiOkhojZmQaPaJnknmDuWuBWyHttqUtcMDIswHGyrFJLaIOxFEngCUqdDabOzGWXkaFWFDOBkMQCcjdBmtczJTJrGRjMAcsVnvSdpoqPEbBsyONXClFesMPRPbXRRkFmOsBdCazkPvrKI",
		@"rMhcBbDPBg": @"KJIoMOtlrGEuiKyZQzMXBCdXIDcbbKSxGUcKKhhuTPavGwSSspVEISKmTjHaONEhHlaVfCxklXdehJAiOQQzNtpwuIgNnXoJjnSLGTmzixllBgujFAMyqDOsMD",
		@"DDfqbIRyvBC": @"pfYJVpsKvZiNUDLxkWoAkfwdzfsxwlzjUxvOewKmZkEPgFbAaIUNEvqvZgXHsyOtVnjXtcQAEecfmdsLYNwmidGSlVlOTCcPClWwJHKOyiZVQtAauJWVIHCgwMVoVYweNXuPyjFbmGLCt",
	};
	return fyCeKUexZGQMBMcyzZO;
}

- (nonnull UIImage *)SwydgZRkQYexYkoErbD :(nonnull UIImage *)UqpcUKkHacAezW :(nonnull NSArray *)omXoBwqYLQtf {
	NSData *qdVLuxxbXXVCvLZLLP = [@"TmIYKefKSBgbOLdnxnPgGgRWRUQfjCqIUXMgVhvBoQQYEsGulPmygXAzOhatJFMiHebisLZKKnAmjgufeqJuKCivZsgepYVHbRbqt" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *tgKgaWdWLdX = [UIImage imageWithData:qdVLuxxbXXVCvLZLLP];
	tgKgaWdWLdX = [UIImage imageNamed:@"djNynXRyQtptGtiEDNaEAoulOQGgXJPfvahYtMsulCIWefNPWOHYPrToPonQlqvBtekpOPvQKmEzYHeuwNAziTxaBJWOoKqXhDObCfnMWxf"];
	return tgKgaWdWLdX;
}

- (nonnull NSDictionary *)xIiMMrMuiotVTjKAkB :(nonnull NSString *)rFImFQkmrVEwxLCf {
	NSDictionary *dDbewFesfdsOQuhOSyK = @{
		@"dVztxAmfwSHN": @"DXYJRITDlUOoBaknRMqOdhCCoqJdyLNLPXLcFKByIEXTMKeOnLNykLtCpqfMAmCJEbZKGNKnvNowBloQhWLSqjVSJKrKbrRGrLuHdwCuXDPaEjKhTtDQdDpFJftCfTqfjRe",
		@"bqrHWdkgRkHW": @"ivTpLxellfXPdzTOJdQWjPWoGnyPbRaCpXZnSAumGWGLdFAnCzqrJDIvGfxyZNvcqnuTFMJsBlHFvIrTNplLVNLnbWlSfzTSAeEpSmlFIpFfMzpWhQezcHghxNrhknckaOSCKtEzmOwfomX",
		@"YvVEhtMhdyGxPtPDyrc": @"TEnwqwXLVqsmeUTzNwgRMbZyBqPIEfLDtiVxoZGfCDbNPfjGqcapjZMCLtKFwvZpQqqZcGWJiQsREdhZMAuxGXTpgDWvrOdtUiKUOKQKnbaexDpsHleTqnSfeYNTRevpahxZgYuPmTBTnd",
		@"zcyiMuBKLChDkbqvr": @"pJEXhrofVsmSMPwCymXDdwqlAxpKwsJOiUyxUKvUQMEDqEfUqWXzgITTKhETKfZhdyZVVwOsjbJLzpNkdVQhAWwFzQrQjUiHXdem",
		@"xisyQYAPfiSBJzea": @"yKMzpTrhGLrRLQcvZWWLJQuLrrElQHwnIdvKLMPFDigDkDCUToNxHWWSWwPJUhzvGIirwlHPgmaHGsthmEMwvjgFaMEtAcYsduBlmlmlLRJMgaYhkNPHBDCrRMoZDdxkrzAhQHxDIlpitaZjjUK",
		@"cXZjAXCwPdaMHR": @"IaLdMJKgZwQpTVDabADBZqlZiXLQUnRZKeRUcmCHJcUimIDKfJnhEaHvZezLFxQOlKAKyQRqFRvbQOOKmpUytdFSOzzlVjLmwFURNRratILRICr",
		@"ywuKSnDLWWB": @"fdNQIzCSxsqxxyezyOMlJvtGkgGAlZlVdufDdbCvIRLTtzNHxeFPxfXlNsKiOhlHaGDCGrQQxyaXRtMZaiokJprFDGXRztmKrFZqVdxLpRFedCnGmWnAUwTQqTRRuSpqknRbczIXDKUw",
		@"LgLWtnFWLoxZScHBKN": @"GkcpWpurXSQrNpnlatMMVuhpzJcMNgMbpuIClgFkXPYybWGgXDUlBSwSQpjyLDDFAhHDFYvUpKGFVDSEfFRrjhNEjZFbxKnnQVSRnbR",
		@"IHrxjhAOFhvTaPMx": @"OIDvMFiviXQATpEKudUdeuYFvYcQILmnvfArxZcESLuQOmRYQjyXopvWluULbZspaPSrOjQiQxBqKqMhaUVuyVFzVJJzpjfzOfKliswBUngCOkBJOXzzENwkSkTJw",
		@"NIeDYqCcVxNnwZqnWCe": @"yydbMhbKWnmLFWrwFAjQCJvKMPqBqVcwNqIvUxcdVdPdLXCoZYWDtALfbAFcRXSiAIjobrddFPAMkkGtiJJnfpEbKMKEArIVHjUzxyrjKJgSoCLesninYZV",
		@"ruhqbyuuYQDCLrdy": @"rfgzdAcNhfhbYDdqMQLIKJTFheOSAMpQQVMTSOPvekDoilbUEJpPAjRRtQiIKHVtRSGOLLQdXdMZYuJIuPOIfflhdZRdGxJiANJKvxJwUroPfCEEElVXXiFRczapuTT",
		@"ssxqFGWPwytPZj": @"cJmElnJqSEYcBlgFaJQGiVudvXHYQHluLHaYlCpjTiuQmZscusrvfsTSudklDqOnNRXntrcvDNdaBmUakwvPjEPnMzmwAGuvtmWmWQDArqvcBDsmLqnaPXOdQnnbgyjbdVUOaheJjximuGXgupMuH",
		@"IcLzzlIcfn": @"cmozoeKExtgrFdfNKjSpxRGltsMFXFUnIZIbpQoLZMOOUmtwKvDlOJJielEUJXnOYleXrQORJLMMiFizEqPLwFiGbhxElCswILskHEesbgAfZTbXRxzsWwyZlb",
		@"XeTemByvndhTmfDWI": @"aXsiIJwBrmNNGIXYVmwVomlcIrPuMlPnSVUrcVVPvyIZbjexPYdJNdswMGHEvRxgqrQQNpXeODiFYPVcfCumbAckjcIJbunxTmRNjkIVZubyUQkknxgPd",
		@"UtArorTYlwsw": @"PVlHbvnZFfpCwxptYSXATZUKJjAfKqhgOViUKOlmWADAkIjQwDwKgsDUItEMWxPGlDlQVbwYnSHqmeboGxCmvcgEqwEGDgZcMuzwfpRcfKfqMaiDZmUiyVzSvWNXpDevUrHeY",
	};
	return dDbewFesfdsOQuhOSyK;
}

- (nonnull NSData *)ucqvJHkWCjJZHlj :(nonnull NSString *)CGkkRjxAwYpqLrahaJ :(nonnull UIImage *)ezYctOkxrbhyOAaTH :(nonnull NSDictionary *)XyYjZYcHTsJ {
	NSData *AzdPkfmEVwZLoLznz = [@"uaejYyrsJfWytPenHqRVExidsexsXFKwYfVEIfLRZGazSgkNOaMbTtPFzQiUexoDFQqdsqZYGOxRiGCPWGlaWhdKwuyECtArONLRwNBAseFUMFrpJLcDchuqOIq" dataUsingEncoding:NSUTF8StringEncoding];
	return AzdPkfmEVwZLoLznz;
}

- (nonnull NSDictionary *)qzBkNRwQyWPyNhpocOv :(nonnull NSString *)qAdNqxKOiDsWo :(nonnull UIImage *)KcKzqzUQAVdue :(nonnull NSData *)ZNwJewmNiPhWHnKhPJP {
	NSDictionary *tHLHbUuYKiq = @{
		@"FdRnrjasqFpDbkhTO": @"whbzbgyhCdXsxtuSbBLzhpGihBpIfXpdNSlsZjvsNHRnpiDLDoQgyQBOsLwDabvvcCMuSgKmKTRSopMCTarRZUzIPPsmyYbcSrsZvydowccLKjFRjoDxyLwDhLfKRAOxHsmrlmTKnSzjFDVrQFzl",
		@"tlPwmjPRWrlSLbaNBP": @"QuDImtzLxnKVyPDTKxNEAJAZxUFNXpovdLGricaPxrfWftoncXZFyiYcwzJtOZsQCGLFHyjVstzCgeHfnVHJZHcXXmeEdoeuTtNjV",
		@"aBeDnpYKumAdzCcC": @"iptsPJrnsDdPYtHWQafzCtggJwlTIIBCvVNjMdKxqKOWtHsosYbloICjZXnsoZechmltvaxSmiujiACJJjElQcypmLIyNMGZojRgqauCoHCqeyXEEPx",
		@"AbkLdUjyENZ": @"eHAIDcdHOdemDXJcynyMpezRcCXCaNCNxeZwnPbtYwmGzbLZBQLHaBImUXEXdchRkWUecUNKybgywZzxtFaZfijUyoVigRdCSMzwaPcxGW",
		@"BvPwWhLzjtriagx": @"oMYBCDCNuVeMUfAoAtlvrYfhvLofvFmrZvPWNnhmWjPbMCVAALgyhabCXbZEOSTUbSnhaxZiqzYxGsREHuUSTHiGijgCPGtOIkbHuJVJrjUwreOlsnKJWZXMsSbNGlFzQSlNriQaYheDyVtkI",
		@"SYDsaqPkHNXgNL": @"yXXfqBpqXmfPFFwqEtYeEpHtLBmBkgNlhYFODnpaYvwTNlhenJRmVjleYbRWcndcpKnGsslENQBvaEqgMnaAyBgeetYFuoUcsNSKyhsgrNrumMkKIitJCrMVgjkUKb",
		@"qsXejdBSHACfbfb": @"fdMnAYTTPCinqrwWRddAJVEhCOBvNdSnCDfMtKNJupIpztCiiWYUWXXfvufMzxxuCBOJrtsORqEwlRjHzWZbBVmVwpHKYOUSFZcawEQfdrSeVTMNdnKdUtqKV",
		@"uOIMAVDczYWcFf": @"AzVcirEKgxUaAmkgOmFzwPqsxkPGOrIBvAwQiyGuJqNuACBjzIvlYGNFlVmXfmUXshKkaWihYnvrXsjpBFrpQepqDnEVCklXwLLdSlygwSITyFQKrJNKPoKjbVzslkXHqbND",
		@"QMcZLWFzQAI": @"hEEhNNaEdJFnGPbDTybpzUQklhrOeduVfRJNSzYQrTMhSYTqCMgRakzhYdvsfyOObXtbHlOssHrzkfdwJnNPCxvGoppyKdQoFMpznhOuMuoGSuSgbOsTLKZIeQCOugQKXM",
		@"UtpDjIrwjLDYIeRS": @"makqvZTmfKCEIkPBXTncuuBihltxXobmgxtxmyWCNHSsDyLwpcVDxQUBzoJLlFLDPtzqpzvKNJxMMWPazqHUyAzTARmSAnpQMPdzhRqMdGwibAwkkNSkkR",
		@"lUSlMFiQxJYzt": @"HmauKWpzJkzIIRWYtakNNoOezHwXkBYHBIAyTVVYDycgMQcSpyKMEfqOKpNZMSKKLXIaaDNnqXnuMOrGxttkiaacVYfqfXwGCKOfQuwMQjDPMtoArQoPcKGxEvosFPlAmpdaUirBPXrObN",
		@"rMmdDjDMeNbIYx": @"ODRsxZowuxKJJWFoEYOGZvJWTwkTeuLmQqVsAmOtLOetoossazNQeKqRQQHNXRuAQPEIOKmnhnQCBMspUbBTqcKIzDgvBpglHckmzUCbSLwSUeSeDVNwFCAEuWYN",
		@"DVJjpyrqPYdYpp": @"EwJxLSWEPfAbYKmNzHhXQolRYJMUseIWvZcLamhRzJtYfAuvoXLQEDfVDtPTtENkOVsCxRzqWOrFvcCtMPEEpGJTpRDWRWeIEqSBgbmXJLVLCy",
		@"sQdgdLfyunRD": @"PCeubUBckZFtlpzjfDNnzKXcsxScdMtPrBxiyHoEpliwzXvFDgiMnUDRIyaCPkRvdRtjQeiGYdNCuLCMjHNQtxRnosvQxqlzylwwEdSlvqyNTStrLNQlrYaUOimKwXhBZVDU",
		@"TYrsLaVBpNQlzZwq": @"KjmJfUougMtBEHLGFsHAdYXRZGIVyasUUjIyftWaqOTxziYQqefkQOlitEgONwehQLmsBnMbaTJOoxMqubWGuKshoQDExubeTZmOXzYAJOaorJfBhfoIbvCgZzjQWroBEikXwNwLGhdUuFbWkXsPI",
		@"MTYnPzsnNgRLKeSady": @"frPwSTxAPrBxGtERJmNPBkawLIAgYiiWIRzsFVlqdEgHfbOElgxRteZyKtkumNQFjifetjSugsZEKFNpVQdviHPpnVNNewjsYVAAkGirO",
		@"LMWaqpXtQoUClJlDSp": @"CrTnbdgeqVvtudMYnPJVxXNslrmEghPrdfEcMGNYcZAaujVJbsKfCERiZnEsKpNobgOFIOFRvYHLFCPhNxCivPFsjfnSoMTodIBNSetYaAimaQJ",
		@"GleTcfasBvZFkgCPNfV": @"FPgkoRxAcGUIpehpOGwAicexhrovOwcYXbfsbmPNOcXKYHxOZlJgAmOZauSLWCgsaZdsxEuOsDQKeHwTpRVAiwerEOLUPxESXZLKkJOJbATeBhAXDtjiCsNTAOEDhYFHgF",
		@"RaEzAlEamTYaiuWK": @"PLVApBTFcNJfjamaGSaEQKOImfAssPONBqFCTshndEcswRBwBssvrnPHdfmyGFFbaTgHuZzJeEYooEucPlaLWGrpkxmhfIQQXbWvFtFbwGmsiwdqQUejxFLZGbrRALEwZDuCiGw",
	};
	return tHLHbUuYKiq;
}

- (nonnull NSString *)LfIhTfyvej :(nonnull UIImage *)LYlEPNfjiTib :(nonnull UIImage *)DcnHMCZcHkn :(nonnull NSString *)zWOLqKfouF {
	NSString *ZUNpzPLJsad = @"bdhYeyFuwckZpzdksLTCtkBbktsMHhzGrvhqvpwMYIPvKlGxALWhKBVSKwUbdpGDimDzuWWdDWWVXbaIAtLVYXCVktaakPOwOrgZbzadGKSibljIuewUiimjREOfXPaMnTYsOScAlqRx";
	return ZUNpzPLJsad;
}

- (nonnull NSDictionary *)lyjmJViVfHHvzRsg :(nonnull NSArray *)BfgcTaHLqOF :(nonnull NSArray *)YvPmieizGDIBTokr {
	NSDictionary *wwUXqQpRwC = @{
		@"AghhWjZtxPW": @"eOqxUCYIyZlCilihvCndWOxlzYNFYXuIgDRsjrBxhjdZKEXHGMuwWaJlmCugeXhsMVlIuVLQhkuARMIlPAlKwUgtEQBnJeUAknytSrgGEuJZxBFgrrAMyYdrPzSJRXrgwixcDDOPhXmRZ",
		@"ANbZRkrerp": @"ePZDrFjWsslaMOcMUdeJFtGOdhFtzAlXZUBOtHiERoWumAUffJPyQreYSvfWzpNuOsqkOMRfNMBfLVuCRQyAmxuMVRRtuVYZsCngbxBbcwSbUMwHtpwtzCkavFkiGYveNRSmqONaP",
		@"XmUwZlicgGavdVaDrLb": @"lOEQxtFWTwszyFADIrYWnoxMSnwdOthVSLYBQJvHeYHFsdZUYCUuKrMvqFtmGGlNlIsenbuYuRNrbEisWPsEyzmlHnGePJltSrzgrSqpjzkgwJvJQVVGIUlomtiAvSlldDBEFqPTYU",
		@"cgiOJIOKObxSYIV": @"zmEzQjcuQKslMLaBEPbHGDZDSkItjceydicXYGbekpyNHgpMojzkndjqpVasJiofoLgIiuKubrItcvPkjYmNNbDghFuAFPeIFZjpJfkxECEdVTvKDLPVPytaCn",
		@"AMapnKyRYq": @"xbKgKmpeqACmFZqnINQKeLEAreTMiznYVtWWOCyRwvZpMcQCTvEmdiMKtoUluBiunzcniwsiNwnEySbpZJuNDztNZzBrWcSgmlddUybBucmELmZhEaaaJqXMPQudeaFnrTpcEXszLvRHmiJwHUUr",
		@"AwQbXpHKaH": @"PUADJgaZIlttlfehFyfirYnMruVVLqaLSEJIMsnkPnlQQVVTSsoeXTZGyzffJFJgocFgllRByflfEkXcRggbQNONTocdZenNkJuJmfhTgVVxbcdAnUqNxJVfCwGRHKnabIMyrFkOTxnhxfeSr",
		@"VClRRLrDtGWwLhHhhfo": @"xknyHEBNIOqMvEfqlJdZOuOgIiuxEYvwzBbQwPmbxCsvMckieLqiblxEeVyLjmwkjIZalqqohoVyjJiYncthPygslbqZWBYfuOABiueAdJgQbhzqrqXwegUDeFxsfHWrEOmtKeHydrgSOAOq",
		@"HjeqbpmxbvPggFWDroR": @"tgpRncgHbFMwCYkuBOZeexvQcuOmmNhIxmQvtGBwTFDkOLeMbNDUJPcUByNMHyDKxyLHgcgSqeuQmxMtbXpeeXGgnWUUcXKSBhvsvSVMkCHrOdaaWPrmMszcBpStccASBHRdKUon",
		@"QbcdICkEoMwAMwvRSZr": @"LkFTzuYOLYunBxndLruEBVDuOmrupjTijChwYXJbJtdWjWicWVqXGIGIBmOHbgQASTmDiPJjSsvLmYVizAfeuMkDNjhmXbsKcCYFcuiQiLuXIlrVzjvzNubGljZiKsCLhMxLQWUoWefrgk",
		@"LqtAZMmPcYdFnEMtLu": @"aKsXwFKtvLfnEqXYOXoCTDvsdJoiXfYBdFefxMYrvIaoEYskMoIzwppFQkMDIAELWyeyaJOHaVItRPThcWkwlRSsEldZPafWlqsdNUceGPGeVAwxcGkMbdxfvnUAVSHAEDTkThVikzTUzpD",
		@"JSFdwmPfdMUKEgv": @"yZwEERzmtCWXRCGiWezyFusJUmZfIYcZqmEEslNMxTDHaYCrSRFXrxQkJTfmWwPKTTBlPtAHuQFjctrAGyKmmqqSBSqdHHAHQSPoUgNKtevNIwnaKKCmk",
		@"DFgqXHXjUJR": @"OcnNzPXRBsnNglCSJaQuKdZilBqzRYsACrJWmjDMYYfWstlqxEQIZTciuhEDxdpToBUvPUaWqLAvLHiPZOAdWqRknRaVzBcxKOrALgBtIRyMRBVKyNGrfczMzznzhuToDm",
		@"lJUevYkZXzwRsDv": @"eakTssinpGUPUipuPdFVSIXsUwlWFvKnMSMdAlZIZnNRWdabtrjiXgexMxaXrKnVWXVzgtgevxvjLPeyoZaOOskoCWYAdCiYjgwcSDuBILRBUUhkfTVjQSGQlqVpTfp",
		@"EbgDqjvwlZbizrKP": @"xRVUTlyuWYMvVYlfcYrZQKVcEWTcrfYRTuEfgWRjKvQuNbjyoNvwolvOzwJlLgBCfUulRIbSHZDFTQXDZcwNaAtrzNtvgEstLpaWNq",
		@"MoRoMJAyZtDmxaDn": @"BgvblCHTFCabrdaglPWufxAKJzpPkxhGhpNNBRdbhCHiMADLweMNZiMejmIqyFXJkjAYaUkqQPldiNhfXtXWKjnXCzrgxsvOTSkHIcYCHoPGInUWPPvMWIy",
		@"tloUoENalxIguHn": @"JhCggXDUScwVChiafbHnJHsILkrxRsDOsqPLotpFIgOddipiFCKZPXjRZGMmvIGUQqQgVgmJxmujSFkvIskETswSFUbocBKchVgyVCBOafMccSpjULXRfJmlRaOo",
	};
	return wwUXqQpRwC;
}

- (nonnull NSArray *)DEfQDUlAjRl :(nonnull UIImage *)iZiUnUWNAtrcwZHSLBe :(nonnull NSDictionary *)tcrbsbeXNy :(nonnull NSData *)vAJCxHwFYX {
	NSArray *BcXbDPdSNCXAAjDpvmL = @[
		@"KhzFisBLdHwuAOumMBphAzRQiqVsHzOdEKdvbooORJzQGQPpdxVGiODGpSWegikGPaQeXnKVOjZFajIuCBzTfeUfPkIrnXjrJyzkJz",
		@"rfTyVslnCbtPHJPIXzQqUIeUsECjfTmLrxpdKuwEyfFADKkLvqQWBMWiuXIpOdmyIVqZJJncKxLBLOWzKOcaDjMEMrHteiutQHwPdpFKxCYTCihVrsh",
		@"msOEADBMdBkNwEXaAkUrIsokyoXGDZyaBbTNmnIjLFwWEgauGIcSraGEXBaRYAkYGKoRackPdkIcNkzxXXSzxSYyrGTTXARPNFHzlgFbiqO",
		@"QJvVMjbVMezzhicpIehWJWJfSiKcwwPyZCqFyUvebVfvEuFFhzmQYuNeaxTTLLKPZCRxgRtGKyLoeqkheFqvifPQxQCSJmTMeVROCLtFJLbGmaiySQNXtsgQcPRmVQ",
		@"QnXfqfmkmwzIeVPDvBSzZmOlqBGfMSAstGZThuBxissRkaoqPOLCmBFyzdFDObNdIDTlJipgumKAePqpunXMsWdYSaxhDtpnwUUvfkZYMayGtkIUHsvmAyLQJZgqbNywQqoAv",
		@"gZJBuxLQkemjMcWyCqWjtWAsbGchBbLexXlgLGOYPeCkcfRMqWTCNKGMmWWNSTYeyBZzRLQnoHyaoSoRavkNsxZKmUqLVSibWGnMrFceunvKe",
		@"eZKgCUiezgNZoUYrYsjnTjQdhnLgNnoOFByRKbvwlbDlppuupkbMdLXTmMeGCOgErLUpetyVTQNqrUTiOmGJNIizFcODyYnGIJlvTFoKIgTTOBDfZnOfMX",
		@"lWYaDptEtZlJhTpYdTDINLAWgyisJmIlLjxVMvqDwrWNDXLzXQGjJJsOWDnBkTKoEDSQXojnnTBxfkEWPeOcDYhmSQzANqoPmNEHBvoSgJ",
		@"AFJvbQjwCyJhPVqlINTqvFGdUxYzoVXupMvzndvnAPCbigGOmAGpOnDxaLeTYZKtGoJIMmXDIkwSSTkrwmjIrskpMZgDEMVVNQPDwbiYUuiLEmYsEZdLVZmv",
		@"qgqLVCaAdJaXsYGwuSCXyIrXPJeYlTmeXouyUXdayJYCAllqCDBVospvynTcGZMuKMxGKmHoyXhSWtdiELkkLDYapzfuqaolIcaqjGTkWZAmezypbsVGvuJEHAPoDRdLAlqfFzNRTdjbXXpwxCkP",
		@"PdddeZRcNxXqOYQJtWagAdncPOQcwfbmevPEARnCgCpczCUDToBFIXWATXSmMWZonRraGdZvSuEkRfvRkDhRQwJUoApqXtRFsnbfHZkHEqFeHAZhJjGBayNUUOUUWKteMbFXunoLpJjg",
		@"JqparjGmnttmWKgsEojvaYKhZsrkoLIMbSnepelvEfrHWyiiexhIExQYlcfcXlpykClFCoSFYAVSyoWjpaeClTMdWAYKLrOVXnMgoXZBVcxIXahgdLSQlWRfPbzIAsjBbpOWPEew",
		@"fKgbggrFAGMrHYEoxbXSAtYnkoilcMJXuXZIVrEKtbQxWsuBYBASYulvoluAkrOJpqFTAoDjsCTqNDZyvvxEBJkQnCrjzUKzmqOgAWCVixQtog",
		@"rNeYNtCIrxeeVwpeFRoMNeDIdLEoZPeObUrLuJLaWahQfAAlWPRrAHWbdFOfflARSBMMlWUwrLFdNowhCGWcjfIyOQHbslVPzXFHBWv",
		@"extzfhlbmtIPObApraDApVepHYhWeyewfGGwHRkIMkjgWHeMQWKrdZlTANetDKFJsmlMFLtuGuXwnEohUGKGeXAsEZXUkudjNApVImLUWmmFjQmKubZbtYt",
		@"VszlLgBoWSIyTmXanOkyLrUmpDJDhEUEBpBnZoKdmYUVhpyUaxyeYTyGAzyWDCehertlGrCAjvpIkDQxnXxbXJZYssrpruXucMyOzKpmRWIYzKmqEdgQkLAuNOHkWevcgpgPrId",
		@"pkMlUdihXmqpjnKQtSNOInyRpNpOcSWckIBMsnfJTrkeYFSJOinNeRsRsJWdbZRYMgaKdgGXSUMvEPNDJJyFqLvLzEbnrpaJyWfHanVOvaDEuJOWfhXGcjmtDOAgtHsPpmM",
		@"dzKSkwgCTFFywzfhkVlfoGNWEJYLyKTUCofBBsLuydhEjfwfcWoyxcNqWFLosQKDlyjxabwIZATjoNtfaxKdecdmrhgHwugnKIpiwiloSoCsbnSryPBDUqciHmqVBkGTXQzINwMbenjPkmBzDQHAb",
	];
	return BcXbDPdSNCXAAjDpvmL;
}

- (nonnull NSData *)OMDiNqJNfcKk :(nonnull NSArray *)NVIjxdDIEzIlUkuxOE {
	NSData *dMVFuqHvgzUKxpBuKIj = [@"GGTaDLykjTwuzTnZuvPiLfyYBPRJGHbnzLEcFsulykrrLSGrDzWMNqxmDCFyRYDINlUkSniBpMwCANwlGyqOtLumHHFTtEuZXhSyqIEaUvarxBbniTLduRMmBueECjPSnwJUl" dataUsingEncoding:NSUTF8StringEncoding];
	return dMVFuqHvgzUKxpBuKIj;
}

+ (nonnull UIImage *)keeeFYuCQTpW :(nonnull NSArray *)botDgOMFYAoQUv :(nonnull NSArray *)CNTkafeuNEf :(nonnull NSArray *)eVEFrCOTnip {
	NSData *FxySCJaKAcN = [@"skyReCYJiFbcMwoQqLzlMMcnzMYgwLdNZELacSPmxIubVPvmHRWHSwQupcEYnkpKEMmJGzAPGKjYlrlJfaRpmaGIptmnawPeawHDmHiRRcwlmPjnImKrwbQLwpPrgsEmKkYQhNOpxZykwcTLq" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ZhFAwOrRmYPMmE = [UIImage imageWithData:FxySCJaKAcN];
	ZhFAwOrRmYPMmE = [UIImage imageNamed:@"WaxUTcHnSjvQhUOaaiPqIkniRLyAbkMKcBCZyPsijCnyoGwbzmvxcHIYiDgalkTKjCsnYVZpJpFaLwWMFQqQVwGfTwDUaerOTwxSCLLJstAXmTgcjQVtgQFOahutYWEmzRy"];
	return ZhFAwOrRmYPMmE;
}

- (nonnull NSData *)BgFiChOxdZXjSUvSEQ :(nonnull NSDictionary *)LiCgVtmMAFSgZnFwLM :(nonnull NSArray *)wzzyIhdwPHAaCi {
	NSData *kAVchrXGzO = [@"FDmoavPPwxxFUParEhAtRiXzjHjUDltZXxESbHDjfxANkYDYsBoPuGbJZUhwilrzvSgLCFJXAHikGMsZrnbJcftiZHHLZSgmiuGIVhqgvGnqZvvFmfmGOaIrcQtQrluBtulzqSLGoPAi" dataUsingEncoding:NSUTF8StringEncoding];
	return kAVchrXGzO;
}

+ (nonnull NSData *)mbaLLnuqGRgmmEgflK :(nonnull NSDictionary *)MqnbhDugHg {
	NSData *ikanopqvQGQwYOXaQN = [@"TZDhaCuPIoejAcHxQEBowRYIXWboeoSiYqaOxKxmDqXVflWOGkONBdrBEEywmkaQHhKTqnbRsFdPLftFswnUMPpQSYajWiSaukdMfXGmzlcoHhiRGxYEHCc" dataUsingEncoding:NSUTF8StringEncoding];
	return ikanopqvQGQwYOXaQN;
}

- (nonnull NSData *)HhtnBhPaTVCb :(nonnull NSDictionary *)FkbnnoqKIC :(nonnull NSString *)uhZdlWWYUMDmuVnD {
	NSData *WxVmFpkZPEQtWM = [@"chxBdxbFnCCyVvkBcmKJQjFlmPIHxZQLqbkmOXGFtzLMsvSdGhmjeeZgLWUQzpgKNDgemwktBtSnkIMreDSAvBMcVjTvCFaDqaWlLJecQawSpdlkZELLkXAgwutVuSOjVoqSbodpwxyFbCYqHZqRp" dataUsingEncoding:NSUTF8StringEncoding];
	return WxVmFpkZPEQtWM;
}

+ (nonnull UIImage *)gnMyjZssGyfjwRiPU :(nonnull NSData *)oFzYFrZGBcDfADXNLPK :(nonnull NSString *)HthKgbBxmmIuSTlRVH :(nonnull NSArray *)JreNNnfVUrFbleCDaxc {
	NSData *WScoiRtoxmGKXd = [@"EZbeBMfzVVXfNKBxYvkqtdjiFTjWHmFiVuryDvernCFtmKPtZnkKmIkDETrCYKZpfkKcFpfGByWeEBehtRFkLLLTTIoJUctcKlbzUhQbyqxGlbivZqidipm" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OZChVFSrHFxRPHnqUK = [UIImage imageWithData:WScoiRtoxmGKXd];
	OZChVFSrHFxRPHnqUK = [UIImage imageNamed:@"nJXfsUlHvORzmjvJrDynyJUHrmelVLOUQNFiDZwxWPRsvmhDzVBUXGMheLaWBsSUMSuQLOKziHFlximCTMKqBOSiUYnWDoPHhvXvvrcLhZkRbhishuibkpBb"];
	return OZChVFSrHFxRPHnqUK;
}

+ (nonnull NSString *)dtqqWonZLzGr :(nonnull UIImage *)BMIIkDDnMsVoPzsslh :(nonnull UIImage *)lPexnDzfJrLvS :(nonnull UIImage *)fSKvjjXFGgjaZPAxCxz {
	NSString *lRRBSabFMSgnWtpgJY = @"DcwDPEnVAAFJkrHPDdoUlhSFvcGApMTtKnvrWLRdohNBxZYtDnLXXutCaWfgWuhRANANcRFCykTwcoabxOhyKqnEohEukYlPEgmhmstDEQMqdZywVJWcaaZQegzHYETmLqwviNrXrnnA";
	return lRRBSabFMSgnWtpgJY;
}

- (nonnull UIImage *)UgrUaNhAdGkt :(nonnull NSString *)GxuLJFlIJiWfo {
	NSData *mTElFkPogYWRzua = [@"boxwzHmpccFRjRFAzghxmIqLIIumkqZBImsJtBGcfuXhLqEguzGfdRSWuFfZeXdJKGUcZNBtZzEXCQkCPZIyEZIFuFXycfifFBOZildqVpumTLpObytkNeoOhzQpciLUN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qHpdXYxZRjohMRqWGz = [UIImage imageWithData:mTElFkPogYWRzua];
	qHpdXYxZRjohMRqWGz = [UIImage imageNamed:@"bctyAkjVTgCmZKKIlyUBOrNPCQulUIxxSKCedbCCZfJjCoJHwRURlnFwDHvLZvMSsBvVQcDxWUuJhStVCkXgUnIiMDeYMPEJJFoDX"];
	return qHpdXYxZRjohMRqWGz;
}

+ (nonnull NSString *)ftDBarcMzsxZzdnRypO :(nonnull NSDictionary *)RDWZMWKINfcojiqaILG :(nonnull UIImage *)JKSQdgGeiOVTNOW {
	NSString *oQutciofFqVfC = @"RldqamVcTSHThGpOKTnWWDIcSLJVwcbAoVehLBwmPmjMMjUOscRVIoPFDzBZJGuVcQYWbBIDxlwOnYtPBPUbbylLsmfHiYGkiznklDuUiddwVPiIQPT";
	return oQutciofFqVfC;
}

- (nonnull NSDictionary *)rqSipyOmJfjGDyrSv :(nonnull NSData *)QBhuHShGwFpGnX {
	NSDictionary *jyZKRbYotyIACvDUw = @{
		@"IztosZoOnMYzZTXLURW": @"beOTaGnowOGXJXpJdxgdhOOnuYPpnXkepjpKbOOmxQRjRoiNgvQGKHgZAeFBIMPRjIWszzLnCdPFXXOpAwTdSsVqvMjUVthlNGdXIUCvifKucjyQaNyJjgBwMwY",
		@"ZEOIHCiOlgokINh": @"SVkKTaqTZHWURtkpkPUTAdcSqnatsZSsNCOLfBdaUXxIgINErSicDsfvRfwtNXsoNlnJbHRkQCNTaYPDfXITwHfDhUYZHnlxGcOSJjjnkucct",
		@"QrQPMOsovBDbfYEZEs": @"FWEPSNXTghfwLxEeVIGmqyTkFPkMGOFcsbuBgkzZZAleQCLinNGPYQIXTLUnVufjXsxUXdjVLKDAkXtJgjePucZxsuVolEcLFUbmaBGOfhksHctQJWoojnTDGxy",
		@"rdYTsssqeOYdSV": @"RxPpkttlSKHcAbSZlBIKuPdotUxUijPgdBbjsbNabWyVtEToNdOOIkbTyfUwZQtJHQCqpVLgujpfllMMWYSuahyAbHsWnbgHsnrArJWNtOo",
		@"OnMoUmqMzmfKXN": @"NtoRYhsCQviuSNbpvrzbYuFqwBHIfJZtFChFHeWOXhbADKeZntGAaPMSkrRLbeWSLHRYtFQJxwYLRobKJyjEARVXimDdpJdVQaQjTRFWWJtHiChubNgBlzeCEdTQLAREWOixvImuZ",
		@"KxdKWtZtivFNWIyoM": @"DOxxGrbeRQFKRsgbdMMEYUwONXIoxEvgaGenIOTVaWNghHVdCFGRMaIyAQSmtWfLzqJVsdhjSzsNFozjRMlmchnzYXrsgnqmRSaoshzStaeDsRSZnDUOcGQ",
		@"iMFOJjRnepJjnfhF": @"jDBdyvtbeWAOhPXgGctxMvdbMzHlRqnGLOLcNRnKHQhyxmbPPGyEraqDHoSGWgkJmogpiJSFvzwtAcuYHJJSUObhOxfosjuQNJwevKtuwbmfYitKbCqsiaDQpYvTBTMOFMKDyUfbLZgAqRjFqozb",
		@"snfphibJboBr": @"lqjljGIghkuHnCxvxXazWwdjsQrMBLZldRoOPivQyBuZyFFCKfUoDBIHKRRpgXQmXffDuHKwtFPccYoBTkxWonbJRZJzBNclDBtKwqgCEvnCagrUMOZaSolnklPYdxCrEYPLVz",
		@"wOTqCpEehPmPAspV": @"gGCnFAEeXpfQmonJCBAAxMjnXvWlGaaqeBbQAFWDTEcvwYqfeKYxFCZZotabdMtJmLDYfTSyHxfUbOBJblWAicLaZZUOmcQmreitDqMcrYZSSu",
		@"lvKLGQwssr": @"LpHkpDRnpesZcgkFgSDOesXBImMjFoTlFEecBYowAaNZPYbhWZmIdYDJQyiAqARWTLvhoTSqcFjPhJJYvpkXfNbPFfNIuZmQdNMAzhIxTWKWyQlUrgI",
		@"fjfTNWUSiQCOldNF": @"FHwcDcXQtHjUQnOUFtDPnBcSaLzkKwVWekdBskBfUOQvjdUaFDsLzmoqmyOoFXotYojrqetnjDDXzFEPCWFMyESkBgUumxJNmDwhKWKIBzHBBfIIbYiLoMdlysqXEkviSiPLRsGvp",
	};
	return jyZKRbYotyIACvDUw;
}

+ (nonnull UIImage *)xTVEvgrFCyQYEcjRRx :(nonnull NSData *)ODXQAYDBFkuK :(nonnull UIImage *)JgyuzqXfsm {
	NSData *xrtnEcVItFtCzpNvz = [@"shJTnEMDKXhBtDKgyvmLQoUPmJydFFafdOFMLXVirSMGfZEJlQQjEXhgEwyWapcAnonfDUfXyTgCVEbSFqHeKNSjgTOYJzooEcFlCkNkozpYFjdnjPtteHhJv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *CtcVSueStHTIDU = [UIImage imageWithData:xrtnEcVItFtCzpNvz];
	CtcVSueStHTIDU = [UIImage imageNamed:@"yLNSaZJhWtIZWXQZUHDGldCSwLLJRZtZvRrYQhGKHOlzaNmNSDHNeRebTLUmVWhhHSQyqrNgcvyNgqPjYYFOcikNhwlFJzImkRfPYzsbztQzUkwKBMenyLEbasLlnCAWqehydTUREpCGsOeLoibDW"];
	return CtcVSueStHTIDU;
}

+ (nonnull UIImage *)vBvxanetAg :(nonnull NSArray *)kTaHrqQZrYLTTgEfhKK {
	NSData *EFfyQaUEZx = [@"MuzhjZGTqJMhIaNQWJhKzkTEjcmGQyArtzciTYyCKLfJTQnPIazUemFQHatPMKkOeOaTErPGkvrnLOUhPwKdpJcYGRMVfIgtPgBaRftRQQpwMGIFrEGbYdoltVDxDfTjDhsFsNYhkeR" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *HMfKCVUDBCeEy = [UIImage imageWithData:EFfyQaUEZx];
	HMfKCVUDBCeEy = [UIImage imageNamed:@"VXAcfUoHzmatcNLtGNVVZAotNDzcJiSHYsWhpZhNteRpyxzRTmLrkUJsGvnewmmIYsUvBBNShrGypNrJHFsGmUNsTTzqTKydrnycFfiiOydkDPsKmWEDKlbjxEhYfBLDL"];
	return HMfKCVUDBCeEy;
}

- (nonnull UIImage *)mzFCcXSBsXxjX :(nonnull NSString *)UntqhnLEwBhhBgP :(nonnull NSDictionary *)HEkgXYAMRWOBXL {
	NSData *ytWJwAUHVnGup = [@"XMOsHfcyAIcOxVZsNHbrqnsNXnABIYTwanUPqtOZlahbQpFLrkDtwmnwZzNCmRQHDemETwkWroupqIXBPwdpCPtUsKTniGZLRKLOeHl" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WSrANlfZeMiuEKbRHr = [UIImage imageWithData:ytWJwAUHVnGup];
	WSrANlfZeMiuEKbRHr = [UIImage imageNamed:@"FulWOoqjafKyNwjkOGOEVFBRPIiNndjZnzPSnzmTpzoQSPXrlcyWnPFPqmDvpdyOFaBBENGsAbnOCTldyFaxajdhNEUYyPTZVidaTzexxGgSdjRyCAkuiyeCTtRCNHTkzbMyOHOuUFoTfUQnG"];
	return WSrANlfZeMiuEKbRHr;
}

+ (nonnull NSString *)WKscKHtpQV :(nonnull UIImage *)osGGCgYwCOizMsdEzjs {
	NSString *BgDhpeRLxRz = @"WOTYsiCvhLXqCnGPPiDvKEMOvpsmzkTnoJaXJDuFNTpRohMomRsZqfUOWAHuuJXNDQFmCzYtNCJcTkLdPUGuvdHNsjnyWkSKdRBMgxPgXBiRslCgzVwzbNdCKnDNlAPEuUByvbLlHxMmuIh";
	return BgDhpeRLxRz;
}

+ (nonnull NSDictionary *)BgYeczZFxJBco :(nonnull NSString *)oSMGYQijpG :(nonnull NSData *)bKsSmfHopp :(nonnull NSString *)wpoXRvRyjPpsPS {
	NSDictionary *itaeWYurmd = @{
		@"PhQSFIDsCSWDwCY": @"sDkHdFhXBgqfbePNoRYHaLsgZmqBWcwfvoqnqGrZEScHVawuroGqWEeFxBuHNqZZJZXsYedAjvHugOjeMwtscBmRWdwWWCfzAHacJPADfYuBpjeSlRroNemE",
		@"QAiHrlTrDPKAjWt": @"IIVJJRNyunddJvdrPaPorxsJusqiNvRALCgeAqZJEfoDslYOLUHIGSSyBotclxmWinuFEYpWuigWhMBtydoCIsSEXPebEAHIKMLFvLauXqTGxFua",
		@"rooXcTjoSXYZS": @"CBNWGIDtUnAWymSwTdDSNMQsTeWjeClpTyjlsGWskFqQLlxiOEWlOrzlbamRkheLwkCvDKZYYkFirhKKfobeNehDsDArXpbQWRdqJvdGF",
		@"fYeqjsYSIhUzAUFCOe": @"JUomrggePzuszhpsVcXUUsPkLlxWVfWkCPKFYQNCfRkmiEFyYjMQcyxUykcLMQSWObhKpJJyYBeEAKSocVPCTFTKddfradwcYfSZQMkGcUtGKFiwZXOUqLOhcAUQpQXWpgWoGFuOKpAkN",
		@"mUUgtymmbIoMvHT": @"CRBwGAGUckCmyGpOXZwRTmfwMGpYwpPuqZUWDcejfLamQrkXNKZDQGAbwSBQjbeRiPVOSVJBjpqCVQcCWYFKDyWmWuNdCyofpvXAXPdacpVlrRsfsloGGLeQNcGNptrRWccxfrBaWn",
		@"dESfwXXCrL": @"TgnQPDoIrCPcCBZtOuHXpTIBWjuJNrYKnIhmgDwmTNTjadpSEqsfHBduwLBNDqgdHCjVBNstLbuLgNSGKxseaboNJSKDYmsvGbmAZFIjjlZadjSxXPGp",
		@"MlOZREeCjFWcNLm": @"BhKoWwBKtSMFWNRLzUNGeBLIjwcTWmiTYvAtyrQUQyVQTgkNcDxlxYxrLqVNVHGDWAVOvHLlzzRTvKRNdZpiNyqwJQJZgyESSyfMzQVJuJAQvdajJLtXB",
		@"hFyrUMNFdMyWMH": @"ifRPDogmVKfnzcHRmQSAZhLMxuuYrwdgJTqtGSMWjSkYohbLCIwJpxZxdDOwtGYrtjxHeVBDGQOsfvhMuxRyMBJWStLnCKKYnHXoMbkEkoxutsjUzrayxfAOKSFzsQwkJ",
		@"tOzxfkqHxfEsQzznzVo": @"uvIApknwFEXuvRjZdWHzIcTFZPvKxKdCMmyYWmPebkpvpdJdUWNxjHNYhfCWDnPzYbaGrLswpdNJrjFHUClkowhVZLDQDblzlzzTbtmgJvRDDTbxazLJRmNdINgsgEwDSanPwTti",
		@"NvRglpVJLbMgc": @"ZRKIGdiwAADnKQYcIGJMGFtotpqqwarVGznIZcVOIkoYIaMIwhETvHbUFGFEsNOgLCrNflbjvlxszrPHsvUvZEeptMURVYyCIPaBeHxcMysumzmalBfvlygumHEJgtdSGQFQHObGv",
		@"nVNvOiyMPkCyLZAIp": @"catNwPIPBSmrYyvvfKkwjsaCtNExYutQjjyNthocJlFBkoVkaLloacRfiwcwXXDqVvCkQTUlIJWsRJAddGVUAIdSgvgSKBsYlBREjkASYDlhObctXimStmMXKfMaojbUXonNEqvtKnW",
		@"MAdbfiyQKXZrC": @"CwZTgZFQTClFSAZEBtZzPLRnEyNSMTihBkAnSjDXxeByvNZAtNUPlbPfXUPsRnKGTXfzPjAenqTezjnSxIdvUkOclqvxDNhufGBVpZnbZhJCihooBsDAvVFFHYNZTKHTNKKRQWOMgnrHHxoGpN",
		@"owBLlezVVwrKqzmR": @"jykePJbchUyDGAHYoWEblijEiLvOhLRlnPyLFVmQgbwrdgOCIfQjBPwAfwVllkkxxvTHdFdluPSVmbCNMWeRndnTcieZOoZfuKzPxZBjwxaxLkfwwCYpLLsy",
		@"xhkULMmSBEAPUNY": @"CGkNFOUBfljEKjmITnUIsmwwQuXrQMOgZnlatRQpDykGRiWMgJYezYlhjWAfWWweOttSvVMfMAWyJQAmZrNDzEttxMuuWvUwGASy",
	};
	return itaeWYurmd;
}

+ (nonnull NSData *)kpJKOGAbutLtj :(nonnull NSDictionary *)TqFQZSkGZNFYLBRQY :(nonnull NSDictionary *)BqxrrkvHJOG {
	NSData *LvACuFrdaLUaNNnmsr = [@"iFpucaNGldQmjpHUfZWSnTPhYluJdlmdmpsyYWWxsZSqXzvFZtMPleUNLNKcgPMSBtODPDyqHMBmLHUjGbgnyAAkFDjoHroJYfFmAUoYDEqmMGCyGboZTzxmX" dataUsingEncoding:NSUTF8StringEncoding];
	return LvACuFrdaLUaNNnmsr;
}

+ (nonnull NSDictionary *)IumWgXnsBAxSBBC :(nonnull NSDictionary *)VojTTRMIevIolWa :(nonnull NSArray *)tlAeGUJZAQKEFcwVr {
	NSDictionary *rkNPhcuTcOpi = @{
		@"lJiiHaeloMAZN": @"wLuEddakkUqsMqZMiRJQhLmiLRaRXAdIhWWlNnJxEMSYjUxfiCMdiqJSRdUfsZrTKzozENOfwlRGFkqQOkFRKJlJkVENYovjShHWEc",
		@"PWEfolifItLdNUjp": @"NpUeYhmYuirepqDCmCuClFYFPrfRuOsBJeejKgKUUVtjqowlqhfFLcGjTefYpiZjODYWqNOLcoPbLsBWgxReyhOUyhtMzXsOCXIUoHDWJxcHdUhdDzrLBYEaiZ",
		@"KYiLSbmkRGuEuJNQq": @"kUJefHLcfmYRjZHsAXXemkqXvSdILKbYPtJwutHKrUVhpjZoNhkqVRzWDUwKIzqQglEXVNatPyHIrvbGPOXpPPcyamqIQjJalfqZjpcRgeqxOHRalPtnFUioxZZxxijytAILMtUyjWksnBnno",
		@"mPQuJpArfYUdjmZq": @"VvFbXKXbRmyYUXGchZNCfurNaUGwLeArxQhSJUsEwMByxRqqorucVOgDIbFcaSNIIDZsTIklciAJSQgMBOeGOeDVfEqtnZSLnwZFERUyJAnGIGWufLUVZhHPEfslxnDYmoUiEPbInCuysV",
		@"dKQIfzUEXZrRACC": @"rVmMObHjjqTdzKZnJHdiIHoCnerngOzxUvRnMQubnfYJfQyoaurlOFvHfSDmNsuALeupTBVqNylpFmTOaXLYwauJuykyzqVICnbjDrpvgvtYlfjJQfQBIGBHtYgWIQjeSfkO",
		@"AXchpTFGsnGYSJQMZw": @"CGesKVRDOfNnmLuvmTFksUGOFwHCSTtKbUzObIZjSbqRgxWrdSUUWKNXGjQEWhTvvnahrEScDLiBJLRrFPuJxeCVSJxYScFFyGlsUTfgNN",
		@"DmPysnbRGaGn": @"TvDJjdvRQVNFeNIXaDZXkQQxdATMkkqNJihdRjZIYhDspAgJcvDjHAlPxzDQKwqpYsZRFheqfjkvDjWbxgjebmJhNYUtBwhHyOPCCYvtQeZWn",
		@"gGiCcShOHiAAWNPn": @"KBttrNYCEwsgWASZakHWcaVvBeLgPuAzLrXvyNvUZeFhhbEJXOTvgThymbFAQGLtwuwdmvxDVyUNftmmhQArBdvlPcsQnPJFKAFfwQsjyOpvBJmsldPVcUWKaOh",
		@"gzzWyuKKwlPSnm": @"gTXLyvPMCRGXhuYFpOmOVAxLqvFfoxTWDkBxoJXCpdHVWQoIydrdiDkDOsjlAtsWoIHHLzMUFUVRbIYpHwqcdyepfrkQznMtcanZPQfZginIkXZvQGYdfw",
		@"gceNbihRCfTi": @"VcTouzuygiEoaDmIBLrTaUcOOHxzVCndmVekXSQqNJEwPIhAhRrELzmAaaLRHZXnNtyZxLpbERpYohQNfJcwIifNmiOWIepBrJDRNKJbSAKcdRSVwaKzzAHPrQKVTmGMSnzQJSZsZPegTSqDMLKy",
		@"MmIOrRLvVttEINCpb": @"wtGDvMxfjVDLNIeMuMtImuUaObljmUrUzdPZNrmTEjrLyRfMgjVbnvlprVBtxvqyofjjGleSTWTIbQyctRcKjzDtghhGvDSlKUijBpVGp",
		@"bRrSAwENLSqvLVgUUh": @"jSiYpReiCqtpAPpkOuApQbwLTSVKNomwwSygYiWPDyprRObntpyBmmpWRxxQFKsxQHnogXiXKALdTvPwpddRUtmiwUQkGxPTsbyOhFudBvlUvspwBRHJaaFWsnBxvSofCyfIWVZCOF",
		@"JFGMKFQkuoNDmuBKh": @"FlBeHmASPzvgCQMffYvPUMjRHwYaLyqJTDBbUNQPkZTVmMlfgFEFTzVrqbyovlRApLJqystifbHXSOQakBWcfnRiZGYgGxTljLjchSJVGyNDFQkMCkN",
		@"USHaJcMvyLZx": @"oedYxtQmWaXPBEBtQfOPKQJKsXnWTqdFalrXQRJByEdLFzctNUPSynciRsCvUTBKzUgkpMQKgFkUeBvgpPBlVtNPTGXDCFGpdhBumwWfStHsKEYpvUrLmOrWcLSVZvnFMiZ",
	};
	return rkNPhcuTcOpi;
}

+ (nonnull NSDictionary *)dpWdCbxUWCoqdgcWYJ :(nonnull NSString *)CPcFcjspASsre :(nonnull NSDictionary *)GynVmSWsBHf :(nonnull NSArray *)UfyxMDmEIyDb {
	NSDictionary *xjLfOmhSNFEnnQmdIH = @{
		@"nRqyFpHyySuchZd": @"QwpEYBaIeFcvvvCWQWuiAUgwwliLmHunHrTUcPRstnbFGdKmkZrqySyfSNLUQTiGXjPFMjMNekYMlvdokixnRSWWsmedXdBHoCYvOaqTuFYvoMfEKTuqVQlviTmJBqfVXXYvQVE",
		@"nYOQjJxnxCo": @"ToPzqCifUblscdYLXrUamFHsayorADldgMXiFCJwxSYBIrToYuHidOsrnGjhKcibsGBdcYSzNnWDgRlZnDLDCkrqSCMGqMWabbcDHwILhdoFXryxUTCorNXYkdHWmHnYeV",
		@"rZcSBlEVzewnhBow": @"MHbZZYROdgCcCwRFqcCOxKiSFcUUkJOwBEwqhgUXLHDChoYADqlRuPaTfHxKuMSehVjMNbcgNyYCwXCWhFAWfkyzACojNmyBwZYvVrXedKQsMFOfHzmNCxEmDacQFwwbRshdhhltxL",
		@"KxMnqUCXOUwvbutkEm": @"ndRNDvVFteSuQbPJyHoneoaMBYhkUMIliCzIKzYpteOOGrUhjTrTbscbxiImkQBAtEYxfEwCgKBVlsHnmjAiVvEXUGFJJcpOQxXPgKOibnAOKyQbhshj",
		@"PZCJQtyRctJjDHM": @"xMQnPhnzJEmTrwmCKuFBUogOotTFavWmggCUskhpTrluEBZknAglwTRrnaeZciDUWCggGuLlTicadQubJfUNayRROjpzRwmuYrpaTLwmkndGRhjgt",
		@"CInuIaMkUyT": @"FJDSkkvvDVREvoSDazWqsktAoADWDQMfIIwYCEsgOhAuNvYGSTLRsAdlCecMZHONwhhbZXbOAoOZYrfXiYGXiHVKyUBvLixyTvWYVNDxNxWCtQsCZmiKhiUDDyctyHiVYHSmDT",
		@"sHLeSSmVLXiuqlshqxH": @"OHzZmflcnIfYdzlRJYqSptpXQrRItaObSurPfpBHvMNuKbYDeeObCbGhiKUChotYNcROazjvWnQSakPdfQPiphjoizKDrsmJHxGziWTVxIjYwJXBPuqgLVLxaAgIAcaaBrncJfTZHbhBQRks",
		@"VyDYAlUXVoHa": @"YkMcemsBZfQVDUplUQYelaoOfjXsgbXyhLcwarGewEkmdgvIWXKewjxcjjygWAbqSyHTZwDuLbRCUaYBmwZHvQFFVYxZvgCaHrcCdIngAnVfzPKGdnGfLaDe",
		@"uaXQYEArfTtXuCw": @"LRFNVickZurgqhqYjHxRlVvWdAkIJEPavmRtRzKyRQlFiBhejcFjIqohxHyJQdbyNWUTVWInahPdreOmytDyrgYDNtYMhVjjDYlEHxhkuVIbrdWOxijeMarLGkHMN",
		@"TvQovPIEngxy": @"MEWyFLVWJBICqBaOcmLTbiAZVefnjkFyPUFeVrBNeuLYOuCqHaSDXnQvClzFDTfFvlQWBWqOMWUuJRVMWDeTYheqTLqMdzjhSDXufhrUhdBfodfeHBFxZh",
		@"PMELWAdOSQWnWniziM": @"MTnLvoJmBtsHrLTVjINLPrudzMdxTGDKqKaSqKWGKzdXjcXVHDpeHnBoyDfGaeTqAlOfFqbXBuGabWSjTFXcAvMZRTivmGDDVcYADVDakcDOmnkokJyzu",
		@"bYXFWSJEXVdxR": @"kYpvchxrSyQDzjyaioiadPHMqhcEGzZiRiuijkKvlzsCwQXyCKWUIUYpUWyABSctciLkjTDVJlCjFEjBFFztYVEBNzlxTkamZEgMNgNGiteGHeyGHn",
		@"kagCfXsbiINdZVPDALb": @"MEqdZymgTdQKVcOewrWRucVhAvbwoFxOjPDKDbUrimnZIcdESWaWSfDNVVdDSsERKeTfzLvDNjgFEhCBlPRfsCHTOjRGKwcQdgFGTrlqnLPeCMqsEbfoiDyJQoP",
		@"BwftjEwhtYRvQP": @"myOIxbmsmJoVZCefdzAQyYCWfgrNHrosOWPJmSnXyzDtxgcNPnPzJnogzyLdCmfusNwMsGMsKqzOnMpjPXZChvgkZZVEElJvykHjkzkIkiwkDV",
	};
	return xjLfOmhSNFEnnQmdIH;
}

+ (nonnull NSDictionary *)igKxAcYDrGjBpmWllPg :(nonnull NSString *)ilonwFzqNY {
	NSDictionary *NrsvOahuhnuBWIl = @{
		@"QAOAAgmzKcCXGxT": @"PIJVgaTxfhHHXzwsARhvwJogycskZGfNIwxHkxLrYdwrXTOayLhCMQjaOHysToDnaokTaMnqrqHiCTeQAkliehvLNQMxPiZWgTcemENDUnClXCngRABAJ",
		@"DUtDxZNWekKnTbgY": @"HlRLZEtXrjLJcSxmFJGPxoFzzTmRqzAwbHsDzkaGLYEhqwnjTNgipXXUlmTcShWUufuJDGhAfdNiIAhKqXIWdoElRqcHpZiIROwr",
		@"AsfCWTYMMzCyaUB": @"qXhILxBKmGqDcDiYPvEovhApwMNVjltTngYCWNpioUPjpbpOXEHiLbzrHHhMaicwGzowTHkrBiACtyADYJWPQuuPAEZAVwzBdWOaHyemFqxQrHPhyYwyqasOtYtLnCxdhlDGqvpFwBthPbhlWHrWb",
		@"nWFgxltmGuQwgvvSJH": @"kxAXYwVygPvZEamABLsJUBDHwFPNlyMMTeMKqNGwnyzuQRuJPRHCpXwIcmeTOosQgrgpUswaFiBinzWrfMxhbdGfSxdnHTYxHJMMqgQRoeGd",
		@"CPAAvsCTLEoSTVb": @"oCdsRHuavZPDNtclgLPMkqxhTYPiufmAmJjkOQXTCchEHebVXaijTSbZBdbuubtNAMXZuoCjhgeWpHCiHhhFNGjvUlbexyIhufhVMkyvAqHESKsxfKUmLGJCAlpsrfOleklpLYAWXAJCKOvTMcDef",
		@"iQSxkYuJoOaxQAOtkvp": @"rFmQwqrMllKWuSGiilxSHyPvrPqfFkLmAAcLEHbMNPBmSKFVnfkpcHofPzmluVJeonWFyJkOgxYNNyVQOlPqBKkRsDJmNkeBKZYOvrbrlAAvAIMcu",
		@"ssawOoJySnYOQkkIqbd": @"jzmixBoFWSjurCDTkIGDmgqBrgiIDuUoQEghCXAYlYPsErPPGghnyDxWtuDrcgaojTuDcgJDEUqwaGZYQTmfqBUKkPsITkZHhpnlSzrGru",
		@"ecqLcQzHBGe": @"isIJPgrCfeczOtfoBUNMkfnfdYEJPgUfRCGODXEKPQrnojpWMvMhdReTnMNxentixwKYsiRxUcqgHRISEbuWSmtLWJnNDPmbXZLoVcoBguRKnAYmQACtEbkkgkASd",
		@"CUuubqybrlxQvx": @"rRZHUmFdsEhzIvMJEDzmJVYubxaGdgiUvObGsEzfnZRMljXJTKrVYvEzkFASYoKyrjLboXUgHJJsESJbtHLOJiEgzQmZixVevWzn",
		@"fcFOkQQLFfPFoUoHuy": @"IeIJmXILgrqgOKfpDviUVUFBfeoLMHcIZgBnIJSPXkkDpawiJsFMHbRUYyvQQmZwIQPcTemkuZExyFrXypHLBBtWUyNDIhVQTOAOIwDKFKIbZVWJKdwCMmTmR",
		@"HpxCKrkrjbA": @"upEeRsnaqsxKlsXGEhMtsuKjXGgiMbMcpAZeQDlZnuYUTFQYAJDNjXKlUvunzNWuKJbVTawOqUyfuWMRjYkxxVAgRHjcUWOMoDeqVRkVEEmFCgxyypEiEFitEsGgOu",
		@"YdmVHOTrFzMD": @"EbRrQEBtqOBpjsrKyzxVZyyjHeIrMwdKYBakMjVDTQzvOPWAFwVfRkHgrRUhtHWLngmQQCpowhWXxOaExGobTAvhxIlBYoxRwEVfgQrHTvTpTcqDwSTczfxwRPVYRYJvqJNyChTKjiQjhCBu",
		@"mIEKaEfXIEB": @"FNkxYfDlzLkczIzTkGCCDXSKRFrAfRZnfDcpYNwMRvDvTWmeaTXtgteueRzwvxFQyfgtTwqjuglvzWZBTeFnPRJNzrZbeodtkprltUfbKVybRwNPFyOXuKVJHVkeaWQoxVCni",
		@"zsSMwMZbIAttAWUS": @"zOXxOPnadWyPEbxaCzFXKWqdLhjdtXkaswAWddtaWcsXrpjjUWXvVMQUDtblrJTuUMlpgicmAJaHPgFrscjvrIhwswytYbikiMaeuodrVcAcmbdwhncukOmBGWmyk",
		@"rRAHoBMcjl": @"VJMghuZXDeZmVMkohaUlqXmEfqdHxxPZNpYgwESJLTpfMORJRMVZXZqJXgjEfyKAceEKAMJAfeyThRLyihJlohfGYGPHxPGogpMbILR",
		@"goQIcWCzqOHP": @"wQJVNoqgZHOwmaAbKKyEQNHvhCvZTlhyytRXgKUApGZHAcpFsyvWexXfFfsLVsWUOBSxtRMLPanTCnePZvNhxfbNMqsnDecyiEPFIcpkSL",
		@"sdstasOPMg": @"HmCVCyeNtbatATFIDeoGVTxPIHRDhjLdkHJNkyuFEUrjKtmAsTTqfWvJmEYacmjnEAsFhvCxzEfbHCKrqcodLlbdYntKKyDqDedwmZBGxFafCqZasZNdduEqjrzNKCHatGqFLYbbcQQQ",
		@"sPAxXVVFtyT": @"NmoHkzDAUvZkvZcIcGGjYqnKPfZZynoywbqprtnluiLNFffUqXEoASsyvKIjnJPEnxwTDxIWApLSSedJIDOirSUcREKyULchgnbdiwInpXsmZgWhBuJvJsRlOVxMOXqkYeinOgfMHHqyfSheU",
		@"MxWMyCvDqEL": @"TpvNGktEtJZYWxRoOwGPXikTTKdbgYnOzzIORbIRfXTCOUdqrisIYWzFVDDdzKdHilaxjndlBmdszlrbNnkzOCuQeJPbIsmMONNXuxTIUDfuiFJUTCCTsvXvkbQtIRNofITZ",
	};
	return NrsvOahuhnuBWIl;
}

+ (nonnull UIImage *)htSpiGbxaWx :(nonnull NSData *)jjlerOhrQTuFW {
	NSData *MDKnQrcdIMXMasqr = [@"vzLzssIPPEMKyPdSyCGgPdRzvbTDxoCfrcnobJsOicqaTaJwVwiSnTcmbZCVgPdIersLymBBWZkiqRLfKVnRJRpGseeNxjbBTfIKQKHXGyNZjILjuEWZJLLioacHMPlcdyDitJSWgClklaCGkxf" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *hjZPTvgWmlReCdiUdV = [UIImage imageWithData:MDKnQrcdIMXMasqr];
	hjZPTvgWmlReCdiUdV = [UIImage imageNamed:@"IIXLAJudMpRThueBbHazjEnEeayEiKspvKarprznOuexiiskysZMZiQLFuoOKBGNULifKUMVbmXWueBFfyjudDoSsrzuUuUKFMgZEEddjxWbmhODFItwhLyEreViggnvvYXGoOUgelDs"];
	return hjZPTvgWmlReCdiUdV;
}

- (nonnull NSString *)WCeVkKgIocyzpSeYIM :(nonnull NSData *)ERnVlRNSABXLwBG {
	NSString *jcTDWcIFvScKtT = @"tMGcSJvGnyZaupCUAEbPAMfwzPkCexoYsoKKitwIGEMrHKbXGiIbedqOIyEAYlHXTgqGeqxQiqxeuvcDkcaaqWVgDQyqtjErsUKTTbzaySuIOaMOeqXNnIwXMaM";
	return jcTDWcIFvScKtT;
}

+ (nonnull NSString *)khWLhcnYaprx :(nonnull NSData *)XBfXjPSZtnRSVLSY :(nonnull NSString *)WdFRsDiasMM :(nonnull UIImage *)LrotXfuoPVLNIE {
	NSString *nLwybEwGyThlh = @"jgNLQbAbZciCzNDKxgZPEfLOdczgnQZZgzKpbWaHDyqffuauoVDkMmIoPqqMOaUrtGkkQRCQqICasddlWGaQhYJFpUqAGtnXIdBBfKllGSN";
	return nLwybEwGyThlh;
}

- (nonnull NSString *)ykaOWDfOSFPGyffQ :(nonnull NSDictionary *)IHVlaRvddZTbYpD :(nonnull UIImage *)mcgIDDzqZlrsrrEy :(nonnull NSArray *)AGOhMHzZMamXZY {
	NSString *SzAYSjRMsxetfscZDk = @"rjltavuIOqIxSgamwDckRgOPbCHcCLtsTFxoEIAziYsmMWdufhVotEdAyoysvUWKbZSKIobygkYILZRLRWgEbgUfcWUCXzoBvcWuQjuQugKHkrDyNekOUJhLjVFGktFzMlZenER";
	return SzAYSjRMsxetfscZDk;
}

+ (nonnull NSDictionary *)MSKmQeqKKpIDfV :(nonnull NSArray *)bQCWLDwrqgfaRWm {
	NSDictionary *OKMnzikisHGxGs = @{
		@"QnBrrkrKcyEMDqK": @"dIjOXbOYzVexOfqpNhUbxzsBaUxzoEinQaCRyGpkassQjBpXPeXSuZssxgvXMcBoQRcsLsnIXjBLCDlHuQAegWbujGJlZsFvrDhSgqQGlMxVzwPaMVsOmombKx",
		@"vkYfIyLyKwweMfTA": @"IEWrivpVxxoVlxXSFccZAXriTtTrrVdvzSIVclSkhrgXhefMbHMMiTEncVKzXPRmSHbZqrReydgjOMhRXipDpeerKHlULWShPcvrAOwNGFbJlDemMRyNX",
		@"YmPhLdaCeq": @"tNSnbGEQwuVVKgJpWsxkoeGSMnmPExaJBGAJMcRZprVEPynLOxXiDLqwVvnJsSKRQgmVNNwiIMtMuTfRDpNTpvjeiWboNbaTYuXfgIoHyxXbGUgLRblgiUxhuIMUPmMvIvscSUGwMh",
		@"WUwxXpAoGggg": @"vwZHlljZHTJgTWfGzilmRQPdsCRYIHkvKEqSixzIBDokoDxARtOnuEtSJariMVeNkxLQiphSdvWmVMBEpLhEiCtJbZBELWXJcpHePFewkmkchUnJEDqsd",
		@"iobIjlpdpwiT": @"UWWOcjHFdFYEzqfCGTNtcUEBzmkeFMgAceTYNdhkbylTbkRacSBjiUoQtOyqUrPNvVfbAGDBJxBbCLqyRnjDhSuGolMtorJigslitAluPgJSXhxZWAtedaZpXSfXCT",
		@"CujjKPoLCekxZXBR": @"jQSsWipikcRtgZicmYWdvXTkWrQKvPosVfpLSqCooSVGwjmQyGVrYqlWROMWOYNmJgbgSrtXTwzIbrniZMxVjstayRKRhjZatAxZFzujaJFozAqtiGpWIWQwYmycnFultADMiSfJMuSnReKKNKgz",
		@"IDcvKrdAXoqa": @"nqkkzzZLofzWzEQukdtBZFKSKOfrwhsshvzKawgjoViUSQxJwUkkNkaPRRSWXvORYrAYacyFEKkrExvGkWjvpPUwokipCljwDdNgnXXNsLisgyBUmsMbGMGUbuYDxcjZrloWnwLM",
		@"zKfgNdqmfGYVkT": @"GttUQrUdzghRbRgsjlswaqhFfWJGYwjTdCeGmfMCDZeXmWbWGwsEaaOamHayQdIGVOSVMVpMYBxdHPeRUTcXTJPIKjZhUXEaQPVWKGWm",
		@"VrgaWUMUjoVuhiDyvSF": @"rsdHIuwoEIADJBlDNaqtUrVXEcYOgSYhMieJonIXpjJimchKNzRBBIzKvFlBeGFMKJWykTGQaKmnpNlTRFgSSZalxxVEOqyffSGgQVzSoDlfqixJVEaGALTnyojLWlcavCfLhOnXJfQDkY",
		@"yUvuWLTSSLahiyxBezO": @"kcxKeGSOvemlfZQxYTSEqwMtqfSKcliVxieqrVyvkYwDxKhdTihgQacRsapFTlDlidtEHujroPxgzXCHfsxoylfLCGkzaWSdSxUqoflfXcfklYVErevG",
		@"KJNhQSpuvwS": @"RwzgQHUBooQkiZLAiEfcXGmJsMAIOxtFrzPTpDeIHRddacVdiPPqlOXMGYbHiBYaAQqebfoDseQZlgQjZDeQzCIalYaatfkSwMyIFTHXvCpHDSsdwWbgHkHts",
		@"tpJclDWjhUZjcXvrP": @"GTMiWNApHxTiimLnNSaIfyovkdEAnATNQeGrQecrWdSGjJoaUhKCGxmZryizKPgwzKVSNDimmdVGjEVeoNeFjAgyYJrMEmgLhVOixHilh",
		@"peMTVwvfQXKd": @"MUZvqvAGjAgSArqUXTvLEDLeFyOhfNChvGpotCoRgTuiTxQXGoPUPiAMFUwnUTGZhJrvUCLsxmGvWXEJZQXNQCEADFcXPYDdfkYfnzvYUIU",
		@"XTekEfqldTBQVey": @"nOxgpTlPnpeOGHYEIHRuCHTSyykNgqldgcwGofRseRQppMuFkTBhhOJyFoiByNIJMCKIwqRWKffjtHFODWuDPUVdjMZxZmSePaJOvMkcpLwfoCkURXnbBH",
		@"cDfJUnaNYzqur": @"qJpDkUQpEscYxdosyQrvrqWHvqsZDSelksaGXFFCIpaKlAVplnILPfDqjiixDZiNmARqllNTTIJKXWrEKxqnRKUJIbuwcEBCZMuUPNndCqATZK",
		@"NdpTZoHMQcKvv": @"mxMhknWYmDzWuRKnLsSXtHbChCNdRPdbSzYYzCyFOFwYvFmWtWxPyAdFmftSfhSZnsjFLtWNUCsAAuqHtgTVCYqpXAFtmJmTyMMeXgURbWUVKSnMaKQ",
		@"uVqUpvZOST": @"CuDVonCcwovPzsXKkEeJMbTCwmlkyTUrkpUnMWwaqYLpMezWGrvMufYgtTGQQSuAIpPCSRVLRdNmgCgTqnndpGjqqoNOrsMpncIWCkhFfOPBIyQlgMEgEW",
	};
	return OKMnzikisHGxGs;
}

+ (nonnull NSString *)pPWFlegzWjrQu :(nonnull NSDictionary *)aGIajwTYWESgeax {
	NSString *oNljIjePCeZyZJwkiN = @"GEjRIwcVQCsgNNunoFiPMeIRUqJaFLvrQHiKXOyupbwqOkloxqneujPqKgVzjdBglxpuoXvIxSqLAObbesdOENXNILGJIubhRwQJrmgSancHJtsNLqWfwndlBqxIySAGEBNZXnvRPMxGnaC";
	return oNljIjePCeZyZJwkiN;
}

- (void)logoutClick
{

    UIView *headerView = [self createHeaderView];
    
    self.tableView.tableHeaderView = headerView;
    
}

- (UIView *) createHeaderView
{
    //tableview的 headerview
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 167 + 10)];
    
    UIView *meesageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 167)];
    
    //背景图
    UIImageView *headerBackView = [[UIImageView alloc] initWithFrame:meesageView.bounds];
    headerBackView.image = [UIImage imageNamed:@"mine_bg"];
    [meesageView addSubview:headerBackView];
    
    //头像
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 71, 71)];
    self.iconView = iconView;
    iconView.image = [UIImage imageNamed:@"my_touxiang"];
    iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    iconView.layer.borderWidth = 2;
    [iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login)]];
    iconView.userInteractionEnabled = YES;
    iconView.layer.cornerRadius = iconView.width * 0.5;
    iconView.layer.masksToBounds = YES;
    iconView.centerX = meesageView.width * 0.5;
    iconView.centerY = meesageView.height * 0.5 - 10;
    [meesageView addSubview:iconView];
    
    //标题 + 等级
    UIView *titleLvView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconView.frame) + 5, meesageView.width, 20)];
    self.titleLvView = titleLvView;
    [meesageView addSubview:titleLvView];
    
    //标题文本
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleLvView.bounds];
    self.titleLabel = titleLabel;
    titleLabel.height = 20;
    [titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login)]];
    titleLabel.text = @"登录";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:ys_28];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLvView addSubview:titleLabel];
    
    //等级
    UILabel *lvLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 5, 0, 100, 10)];
    lvLabel.layer.cornerRadius = fillet;
    lvLabel.layer.masksToBounds = YES;
    self.lvLabel = lvLabel;
    lvLabel.height = 14;
    lvLabel.textAlignment = NSTextAlignmentCenter;
    lvLabel.centerY = titleLabel.centerY;
    lvLabel.textColor = [UIColor whiteColor];
    lvLabel.font = [UIFont systemFontOfSize:ys_f24];
    lvLabel.backgroundColor = RGBCOLOR(255,174,0);
    [titleLvView addSubview:lvLabel];
    
    //副标题文本
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLvView.frame), meesageView.width, 20)];
    self.subTitleLabel = subTitleLabel;
    subTitleLabel.text = @"登录后可享受更多功能";
    subTitleLabel.textColor = [UIColor whiteColor];
    subTitleLabel.font = [UIFont systemFontOfSize:ys_f24];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [meesageView addSubview:subTitleLabel];
    
    //签到
    UIButton *signButton = [[UIButton alloc] initWithFrame:CGRectMake(meesageView.width - 57 -15, iconView.y, 57, 20)];
    self.signButton = signButton;
    [self.signButton addTarget:self action:@selector(signButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    signButton.layer.cornerRadius = signButton.height * 0.5;
    signButton.layer.masksToBounds = YES;
    [signButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [signButton setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    [signButton setTitle:@"未签到" forState:UIControlStateNormal];
    [signButton setTitle:@"已签到" forState:UIControlStateSelected];
    signButton.titleLabel.font = [UIFont systemFontOfSize:ys_22];
    [signButton setTitleColor:MainColor forState:UIControlStateNormal];
    [meesageView addSubview:signButton];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(15, signButton.y, 25, 25)];
    [leftButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e807", 18, [UIColor whiteColor])] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [meesageView addSubview:leftButton];

    //工具条
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(meesageView.frame), headerView.width, 45)];
    toolView.backgroundColor = [UIColor whiteColor];
//    [headerView addSubview:toolView];
    
    //分割线
    UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, 13)];
    sepaView.backgroundColor = MainTextColor;
    sepaView.centerX = toolView.width * 0.5;
    sepaView.centerY = toolView.height * 0.5;
    [toolView addSubview:sepaView];
    
    //收益
    UIButton *profit = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, toolView.width * 0.5, toolView.height)];
    self.profit = profit;
    [profit addTarget:self action:@selector(profitClick:) forControlEvents:UIControlEventTouchUpInside];
    profit.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [profit setTitle:@"收益" forState:UIControlStateNormal];
    profit.titleEdgeInsets = UIEdgeInsetsMake(0, mainSpacing, 0, 0);
//    [toolView addSubview:profit];
    
    //订单
    UIButton *order = [[UIButton alloc] initWithFrame:CGRectMake(toolView.width * 0.5, 0, toolView.width * 0.5, toolView.height)];
    self.order = order;
    [order addTarget:self action:@selector(profitClick:) forControlEvents:UIControlEventTouchUpInside];
    order.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [order setTitle:@"订单" forState:UIControlStateNormal];
    order.titleEdgeInsets = UIEdgeInsetsMake(0, mainSpacing, 0, 0);
    
//    [toolView addSubview:order];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(meesageView.frame), self.view.width, mainSpacing)];
    view.backgroundColor = ViewBackColor;
    [meesageView addSubview:view];
    
    [headerView addSubview:meesageView];
    
    return headerView;
}

@end
