//
//  ShoucangController.m
//  TxtLookFramework
//
//  Created by 顾海波 on 2018/5/10.
//  Copyright © 2018年 com.txtLook. All rights reserved.
//

#import "ShoucangController.h"
#import "UIBarButtonItem+Extension.h"
#import "TuPianModelTool.h"
#import "TuPianModel.h"
#import "TuPianCell.h"
#import "ImageController.h"

@interface ShoucangController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ShoucangController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的收藏";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.height = self.view.height - 64;
    tableView.backgroundColor = RGBCOLOR_HEX(0xf5f5f5);
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc] init];
    
    [self setUpData];
        
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem setRightNavigationBarBackGroundImgName:@"\U0000e807" target:self selector:@selector(back) imageColor:[UIColor blackColor] imageFont:18];
    

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath { // 修改模型
    
    TuPianModel *model = self.array[indexPath.row];
    [TuPianModelTool removeVideoModel:model];
    
    [self.array removeObjectAtIndex:indexPath.row];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}


- (void) setUpData
{
    self.array = [TuPianModelTool videoModels];
    [self.tableView reloadData];
}

- (void) back
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.array.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TuPianModel *model = self.array[indexPath.row];
    
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
    
    TuPianModel *model = self.array[indexPath.row];
    
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
