//
//  ZhuanJiaDetailController.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/22.
//

#import "ZhuanJiaDetailController.h"
#import "ZuiXinTuiJianCell.h"
#import "LishiTuiJianCell.h"
#import "UIImageView+WebCache.h"
#import "ZhuanJiaModel.h"
#import "AFNetWW.h"
#import "LiShiModel.h"
#import "TuiJianDetailController.h"
#import "MJExtension.h"
#import "ZhuanJIaTool.h"
#import "MBProgressHUD+MJ.h"

@interface ZhuanJiaDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *noCommentView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isLishiTuiJian;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIButton *selectedButton;

@property (nonatomic, strong) NSArray *datas;

@end

@implementation ZhuanJiaDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"专家主页";
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
    self.headerView = headerView;
    headerView.backgroundColor = MainColor;
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 30, 70, 70)];
    [iconView sd_setImageWithURL:[NSURL URLWithString:self.model.icon]];
    iconView.layer.cornerRadius = 35;
    iconView.layer.masksToBounds = YES;
    [headerView addSubview:iconView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconView.frame) + 10, iconView.y + 5, 0, 0)];
    nameLabel.text = self.model.name;
    [nameLabel sizeToFit];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:nameLabel];
    
    //近期
    UILabel *jinqi = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.x, CGRectGetMaxY(nameLabel.frame), 100, 30)];
    jinqi.numberOfLines = 0;
    jinqi.textColor = [UIColor whiteColor];

    NSString *allString = [NSString stringWithFormat:@"%@\n 近期",self.model.jinqi];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:allString];
    [attString addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_HEX(0x91E0B8) range:[allString rangeOfString:@"近期"]];
    jinqi.attributedText = attString;
    
    [jinqi sizeToFit];
    jinqi.textAlignment = NSTextAlignmentCenter;
    jinqi.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:jinqi];
    
    //分割线
    UIView *speaView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(jinqi.frame) + 5, 0, 0.5, jinqi.height * 0.6)];
    speaView.centerY = jinqi.centerY;
    speaView.backgroundColor = RGBCOLOR_HEX(0x91E0B8);
    [headerView addSubview:speaView];

    //总
    UILabel *zong = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(speaView.frame) + 5, jinqi.y, 100, 30)];
    zong.numberOfLines = 0;
    zong.textColor = [UIColor whiteColor];
    allString = [NSString stringWithFormat:@"%@\n 总",self.model.zong];
    attString = [[NSMutableAttributedString alloc] initWithString:allString];
    [attString addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_HEX(0x91E0B8) range:[allString rangeOfString:@"总"]];
    zong.attributedText = attString;
    
    [zong sizeToFit];
    zong.textAlignment = NSTextAlignmentCenter;
    zong.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:zong];
    
    UIButton *followButton = [[UIButton alloc] initWithFrame:CGRectMake(headerView.width - 80 - 15, 0, 80, 28)];
    followButton.centerY = nameLabel.centerY;
    [followButton addTarget:self action:@selector(followButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    followButton.layer.cornerRadius = 6;
    followButton.layer.masksToBounds = YES;
    followButton.layer.borderColor = [UIColor whiteColor].CGColor;
    followButton.layer.borderWidth = 1;
    [followButton setTitle:@"关注" forState:UIControlStateNormal];
    [followButton setTitle:@"已关注" forState:UIControlStateSelected];
    [followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    followButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:followButton];
    
    NSArray *models = [ZhuanJIaTool videoModels];
    BOOL hasGuanZhu = NO;
    for (ZhuanJiaModel *model in models) {
        if ([model.ID isEqualToString:self.model.ID]) {
            hasGuanZhu = YES;
        }
    }
    
    if (hasGuanZhu) {
        followButton.selected = YES;
    }
    
    //多少人关注
    UILabel *guanzu = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(followButton.frame) + 10, 100, 30)];
    guanzu.numberOfLines = 0;
    guanzu.textColor = [UIColor whiteColor];
    allString = [NSString stringWithFormat:@"%@人关注TA",self.model.guanzhuCount];
    attString = [[NSMutableAttributedString alloc] initWithString:allString];
    [attString addAttribute:NSForegroundColorAttributeName value:RGBCOLOR_HEX(0x91E0B8) range:[allString rangeOfString:@"人关注TA"]];
    guanzu.attributedText = attString;
    [guanzu sizeToFit];
    guanzu.x = headerView.width - guanzu.width - 15;
    guanzu.textAlignment = NSTextAlignmentRight;
    guanzu.font = [UIFont systemFontOfSize:15];
    [headerView addSubview:guanzu];
    
    UIView *sepaView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconView.frame) + 20, self.view.width - 30, 0.7)];
    sepaView2.centerX = headerView.width * 0.5;
    sepaView2.backgroundColor = RGBCOLOR_HEX(0x1FAE65);
    [headerView addSubview:sepaView2];
    
    //描述
    UILabel *miaoshu = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(sepaView2.frame) + 20, headerView.width - 30, 30)];
    miaoshu.numberOfLines = 0;
    miaoshu.text = self.model.des;
    [miaoshu sizeToFit];
    miaoshu.textColor = [UIColor whiteColor];
    miaoshu.font = [UIFont systemFontOfSize:13];
    [headerView addSubview:miaoshu];
    
    UIButton *zuixin = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(miaoshu.frame) + 10, headerView.width * 0.5, 44)];
    zuixin.tag = 0;
    [zuixin addTarget:self action:@selector(lishiClick:) forControlEvents:UIControlEventTouchUpInside];
    zuixin.backgroundColor = [UIColor whiteColor];
    [zuixin setTitle:@"最新推荐" forState:UIControlStateNormal];
    zuixin.titleLabel.font = [UIFont systemFontOfSize:17];
    [zuixin setTitleColor:RGBCOLOR_HEX(0x999999) forState:UIControlStateNormal];
    [zuixin setTitleColor:MainColor forState:UIControlStateSelected];
    [headerView addSubview:zuixin];

    UIButton *lishi = [[UIButton alloc] initWithFrame:CGRectMake(headerView.width * 0.5, zuixin.y, headerView.width * 0.5, 44)];
    lishi.tag = 1;
    [lishi addTarget:self action:@selector(lishiClick:) forControlEvents:UIControlEventTouchUpInside];
    lishi.backgroundColor = [UIColor whiteColor];
    [lishi setTitle:@"历史推荐" forState:UIControlStateNormal];
    lishi.titleLabel.font = [UIFont systemFontOfSize:17];
    [lishi setTitleColor:RGBCOLOR_HEX(0x999999) forState:UIControlStateNormal];
    [lishi setTitleColor:MainColor forState:UIControlStateSelected];
    [headerView addSubview:lishi];

    zuixin.selected = YES;
    self.selectedButton = zuixin;
    
    UIView *sView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(zuixin.frame), headerView.width, 10)];
    sView.backgroundColor = RGBCOLOR_HEX(0xf5f5f5);
    [headerView addSubview:sView];
    
    headerView.height = CGRectGetMaxY(sView.frame);

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.height = self.view.height - 64;
    tableView.backgroundColor = RGBCOLOR_HEX(0xf5f5f5);
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = headerView;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
    
    
    [self getData];
}

- (void) getData
{
    
    //拉取首页 猜你喜欢
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@",ZhuanJiaLiShiTuiJianBanner,self.model.ID];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         self.datas = [LiShiModel objectArrayWithKeyValuesArray:responseDic];
         [self.tableView reloadData];
     }fail:^(NSError *error) {
         
         
     }];
}

- (void) lishiClick : (UIButton *) button
{
    button.selected = YES;
    self.selectedButton.selected = NO;
    self.selectedButton = button;
    
    if (button.tag == 1) {
        self.isLishiTuiJian = YES;
    }else
    {
        self.isLishiTuiJian = NO;
    }
    
    [self.tableView reloadData];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isLishiTuiJian) {
        return self.datas.count;
    }
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.isLishiTuiJian) {
        static NSString *ID = @"LishiTuiJianCell";
        LishiTuiJianCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[LishiTuiJianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        
        LiShiModel *model = self.datas[indexPath.row];
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    static NSString *ID = @"ZuiXinTuiJianCell";
    ZuiXinTuiJianCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZuiXinTuiJianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isLishiTuiJian) {
        return 70;
    }
    return YLScreenH - self.headerView.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失

    if (self.isLishiTuiJian) {
        TuiJianDetailController *vc = [[TuiJianDetailController alloc] init];
        vc.ID = [NSString stringWithFormat:@"%ld",(long)indexPath.row + 1];
        vc.name = self.model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void) followButtonClick : (UIButton *) button
{
    if ([button.titleLabel.text isEqualToString:@"已关注"]) {
        return;
    }
    button.selected = !button.selected;
    if (button.selected) {
        [ZhuanJIaTool saving:self.model];
        [MBProgressHUD showSuccess:@"专注成功"];
    }
}

@end
