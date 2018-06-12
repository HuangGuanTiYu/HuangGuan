//
//  TuPianController.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/6/12.
//

#import "TuPianController.h"
#import "AFNetWW.h"
#import "TuPianModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "TuPianCell.h"
#import "ImageController.h"
#import "ImageController.h"
#import "LeftSlideViewController.h"

@interface TuPianController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation TuPianController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.height = self.view.height - 64 - 49;
    tableView.backgroundColor = RGBCOLOR_HEX(0xf5f5f5);
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    NSString *likeUrl = [NSString stringWithFormat:@"%@",TuPianList];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         
         self.dataSource = [TuPianModel objectArrayWithKeyValuesArray:responseDic];
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
    
    TuPianModel *model = self.dataSource[indexPath.row];
    
    static NSString *ID = @"TuPianCell";
    TuPianCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TuPianCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失

    NSMutableArray *photos = [NSMutableArray array];
    
    TuPianModel *model = self.dataSource[indexPath.row];

    [photos addObject:model.image1];
    [photos addObject:model.image2];
    [photos addObject:model.image3];
    [photos addObject:model.image4];
    [photos addObject:model.image5];
    
    ImageController *vc = [[ImageController alloc] init];
    vc.Photos = photos;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}

@end
