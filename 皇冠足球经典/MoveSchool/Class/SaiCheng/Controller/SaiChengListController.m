//
//  SaiChengListController.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/24.
//

#import "SaiChengListController.h"
#import "SaiChengModel.h"
#import "AFNetWW.h"
#import "MJExtension.h"
#import "SaiChengCell.h"
#import "SaiChengDetailController.h"

@interface SaiChengListController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, strong) UIView *noCommentView;

@property (nonatomic, copy) NSString *time;

@end

@implementation SaiChengListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.height = self.view.height - 64 - 50 - 49;
    tableView.backgroundColor = RGBCOLOR_HEX(0xf5f5f5);
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
    
    [self getData : @"20180523"];
    
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

- (void) getData : (NSString *) time
{
    
    self.time = time;
    
    //拉取首页 猜你喜欢
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@",SaiChengWeiBaoMing,time];
    if (self.isYiBaoMing) {
        likeUrl = [NSString stringWithFormat:@"%@%@",SaiChengBaoMing,time];
    }
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         self.datas = [SaiChengModel objectArrayWithKeyValuesArray:responseDic];
         
         if (self.datas.count == 0) {
             self.noCommentView.hidden = NO;
             self.tableView.hidden = YES;
         }else
         {
             self.noCommentView.hidden = YES;
             self.tableView.hidden = NO;
             [self.tableView reloadData];
         }
     }fail:^(NSError *error) {
         self.noCommentView.hidden = NO;
         self.tableView.hidden = YES;
         
     }];
}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return self.studyTitle;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"SaiChengCell";
    SaiChengCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SaiChengCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    SaiChengModel *model = self.datas[indexPath.row];
    cell.model = model;
    cell.isYiBaoMing = self.isYiBaoMing;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void) change : (NSString *) timer
{
    [self getData : timer];
}

- (NSString *) getdata
{
    
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyyMMdd"];
    NSString *dateStr;
    dateStr = [format1 stringFromDate:date];
    return dateStr;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失

    
    SaiChengModel *model = self.datas[indexPath.row];

    SaiChengDetailController *vc = [[SaiChengDetailController alloc] init];
    vc.model = model;
    vc.isYiBaoMing = self.isYiBaoMing;
    vc.time = self.time;
    vc.index = [NSString stringWithFormat:@"%ld",(long)indexPath.row + 1];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
