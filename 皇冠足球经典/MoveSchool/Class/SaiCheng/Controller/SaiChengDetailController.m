//
//  SaiChengDetailController.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/24.
//

#import "SaiChengDetailController.h"
#import "SiChengDetailCell.h"
#import "AFNetWW.h"
#import "SaiChengModel.h"
#import "UIImageView+WebCache.h"
#import "SaiChengOuPei.h"
#import "MJExtension.h"
#import "SaiChengYaPan.h"
#import "SaiChengZhanJi.h"

@interface SaiChengDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *selectdButton;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, assign) int type;

@end

@implementation SaiChengDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"比赛详情";
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
    headerView.backgroundColor = MainColor;
    [self.view addSubview:headerView];
    
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, 0, 0)];
    typeLabel.text = self.model.type;
    typeLabel.textColor = [UIColor whiteColor];
    typeLabel.font = [UIFont systemFontOfSize:16];
    [typeLabel sizeToFit];
    typeLabel.centerX = self.view.width * 0.5;
    [headerView addSubview:typeLabel];
    
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(typeLabel.frame) + 10, 0, 0)];
    timeLabel.text = self.model.time;
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.font = [UIFont systemFontOfSize:16];
    [timeLabel sizeToFit];
    timeLabel.centerX = self.view.width * 0.5;
    [headerView addSubview:timeLabel];
 
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(timeLabel.frame) + 15, 50, 50)];
    leftView.centerX = self.view.width * 0.25;
    [leftView sd_setImageWithURL:[NSURL URLWithString:self.model.leftImage]];
    [headerView addSubview:leftView];
    
    UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(timeLabel.frame) + 15, 50, 50)];
    rightView.centerX = self.view.width * 0.75;
    [rightView sd_setImageWithURL:[NSURL URLWithString:self.model.rightImage]];
    [headerView addSubview:rightView];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(leftView.frame) + 10, 0, 0)];
    leftLabel.text = self.model.leftName;
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.font = [UIFont systemFontOfSize:16];
    [leftLabel sizeToFit];
    leftLabel.centerX = leftView.centerX;
    [headerView addSubview:leftLabel];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(leftView.frame) + 10, 0, 0)];
    rightLabel.font = [UIFont systemFontOfSize:16];
    rightLabel.text = self.model.rightName;
    [rightLabel sizeToFit];
    rightLabel.textColor = [UIColor whiteColor];
    rightLabel.centerX = rightView.centerX;
    [headerView addSubview:rightLabel];
    
    UILabel *bifen = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    bifen.text = @"未开始";

    if (self.isYiBaoMing) {
        bifen.text = self.model.bifen;
    }
    
    bifen.textColor = [UIColor whiteColor];
    bifen.font = [UIFont systemFontOfSize:16];
    [bifen sizeToFit];
    bifen.centerX = self.view.width * 0.5;
    bifen.centerY = leftView.centerY;
    [headerView addSubview:bifen];
    
    UIButton *oupei = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(leftLabel.frame) + 30, self.view.width / 3, 45)];
    [oupei setTitle:@"欧赔" forState:UIControlStateNormal];
    oupei.tag = 0;
    [oupei addTarget:self action:@selector(oupeiClick:) forControlEvents:UIControlEventTouchUpInside];
    [oupei setTitleColor:RGBCOLOR(102, 102, 102) forState:UIControlStateNormal];
    [oupei setTitleColor:MainColor forState:UIControlStateSelected];
    [headerView addSubview:oupei];
    
    UIButton *yapan = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width / 3, CGRectGetMaxY(leftLabel.frame) + 30, self.view.width / 3, 45)];
    [yapan setTitle:@"亚盘" forState:UIControlStateNormal];
    yapan.tag = 1;
    [yapan addTarget:self action:@selector(oupeiClick:) forControlEvents:UIControlEventTouchUpInside];
    [yapan setTitleColor:RGBCOLOR(102, 102, 102) forState:UIControlStateNormal];
    [yapan setTitleColor:MainColor forState:UIControlStateSelected];
    [headerView addSubview:yapan];
    
    UIButton *zhanji = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width / 3 * 2, CGRectGetMaxY(leftLabel.frame) + 30, self.view.width / 3, 45)];
    [zhanji setTitle:@"战绩" forState:UIControlStateNormal];
    zhanji.tag = 2;
    [zhanji addTarget:self action:@selector(oupeiClick:) forControlEvents:UIControlEventTouchUpInside];
    [zhanji setTitleColor:RGBCOLOR(102, 102, 102) forState:UIControlStateNormal];
    [zhanji setTitleColor:MainColor forState:UIControlStateSelected];
    [headerView addSubview:zhanji];
    
    oupei.selected = YES;
    self.selectdButton = oupei;
    
    oupei.backgroundColor = yapan.backgroundColor = zhanji.backgroundColor = [UIColor whiteColor];
    
    headerView.height = CGRectGetMaxY(oupei.frame);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.height = self.view.height - 64;
    tableView.backgroundColor = RGBCOLOR_HEX(0xf5f5f5);
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = headerView;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
    
    [self getData : 0];
}

- (void) getData : (int) type
{
    self.type = type;
    
    //拉取首页 猜你喜欢
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@%@",SaiChengWeiJieShuDetailOuPei,self.time,self.index];
    
    if (self.isYiBaoMing) {
        likeUrl = [NSString stringWithFormat:@"%@%@%@",SaiChengJieShuDetailOuPei,self.time,self.index];
        
        if (type == 1) {
            likeUrl = [NSString stringWithFormat:@"%@%@%@",SaiChengJieShuDetailYaPan,self.time,self.index];
        }
        
        if (type == 2) {
            likeUrl = [NSString stringWithFormat:@"%@%@%@",SaiChengJieShuDetailZhanji,self.time,self.index];
        }
    }
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         if (type == 0) {
             self.datas = [SaiChengOuPei objectArrayWithKeyValuesArray:responseDic];
         }else if (type == 1)
         {
             self.datas = [SaiChengYaPan objectArrayWithKeyValuesArray:responseDic];
         }else if (type == 2)
         {
             self.datas = [SaiChengZhanJi objectArrayWithKeyValuesArray:responseDic];
         }
         [self.tableView reloadData];
     }fail:^(NSError *error) {
         
         
     }];
}

- (void) oupeiClick : (UIButton *) button
{
    
    button.selected = YES;
    self.selectdButton.selected = NO;
    self.selectdButton = button;
    
    if (button.tag == 0) { //欧赔
        [self getData:0];
    }else if(button.tag == 1) //亚盘
    {
        [self getData:1];
    }else if(button.tag == 2) //战绩
    {
        [self getData:2];
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.datas.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"SiChengDetailCell";
    SiChengDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SiChengDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.backgroundColor = ViewBackColor;
    }else
    {
        
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.type = self.type;
    
    if (self.type == 0) {
        SaiChengOuPei *model = self.datas[indexPath.row];
        cell.model = model;
    }else if(self.type == 1)
    {
        SaiChengYaPan *yapanModel = self.datas[indexPath.row];
        cell.yapanModel = yapanModel;
    }else if(self.type == 2)
    {
        SaiChengZhanJi *yapanModel = self.datas[indexPath.row];
        cell.zhanJiModel = yapanModel;
    }

    return cell;
}



@end
