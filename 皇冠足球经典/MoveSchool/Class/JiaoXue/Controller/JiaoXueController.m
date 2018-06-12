//
//  JiaoXueController.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/6/12.
//

#import "JiaoXueController.h"
#import "AFNetWW.h"
#import "JiaoXueModel.h"
#import "TuPianCell.h"
#import "MJExtension.h"
#import "TuPianModel.h"
#import "DetailViewController.h"
#import "LeftSlideViewController.h"

@interface JiaoXueController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *dataSource;

@end

@implementation JiaoXueController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.height = self.view.height - 64;
    tableView.backgroundColor = RGBCOLOR_HEX(0xf5f5f5);
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
    
    [self setUpData];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem setRightNavigationBarBackGroundImgName:@"leftIcon" target:self selector:@selector(back)];
    
}

- (void) back
{
    
    LeftSlideViewController *LeftSlideVC = (LeftSlideViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [LeftSlideVC openLeftView];//关闭左侧抽屉
}
    
- (void) setUpData
{
    
    //拉取首页 猜你喜欢
    NSString *likeUrl = [NSString stringWithFormat:@"%@%d",JiaoXue,1];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         
         self.dataSource = [JiaoXueModel objectArrayWithKeyValuesArray:responseDic];
         [self.tableView reloadData];
         
     }fail:^(NSError *error) {
         
         
     }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSource.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JiaoXueModel *model = self.dataSource[indexPath.row];
    
    TuPianModel *tuModel = [[TuPianModel alloc] init];
    tuModel.icon = model.icon;
    tuModel.title = model.title;
    tuModel.subTitle = model.time;
    
    static NSString *ID = @"TuPianCell";
    TuPianCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TuPianCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = tuModel;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失

    JiaoXueModel *model = self.dataSource[indexPath.row];

    DetailViewController *detailVC = [[DetailViewController alloc] init];
    
    WMPlayerModel *playerModel = [WMPlayerModel new];
    playerModel.title = model.title;
    playerModel.videoURL = [NSURL URLWithString:model.mp4_url];
    detailVC.playerModel = playerModel;
    //push测试
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

@end
