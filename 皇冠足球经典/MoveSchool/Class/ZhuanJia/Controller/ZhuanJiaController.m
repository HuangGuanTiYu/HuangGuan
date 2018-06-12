//
//  ZhuanJiaController.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/22.
//

#import "ZhuanJiaController.h"
#import "AFNetWW.h"
#import "BannerModel.h"
#import "SDCycleScrollView.h"
#import "MJExtension.h"
#import "MainWebController.h"
#import "ShopHeaderView.h"
#import "ZhuanJiaCell.h"
#import "AFNetWW.h"
#import "ZhuanJiaModel.h"
#import "CustomIOSAlertView.h"
#import "ZhuanJiaDetailController.h"
#import "MineCell.h"
#import "HomeDataCell.h"

@interface ZhuanJiaController ()<UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *datas;

@end

@implementation ZhuanJiaController

- (UIView *)createDemoView
{
    float textWidth = 260;
    
    float textMargin = 10;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    
    titleLabel.font = [UIFont systemFontOfSize:18];
    
    titleLabel.textColor = [UIColor blackColor];
    
    titleLabel.backgroundColor = [UIColor clearColor];
    
    titleLabel.lineBreakMode =NSLineBreakByWordWrapping;
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.text = @"声明:";
    
    titleLabel.frame = CGRectMake(0, textMargin, textMargin * 2 + textWidth, 40);
    
    NSString *message =  @"1:本产品仅用于专家与网友交流，禁止一切与非法赌博有关的活动。\n2:专家分析内容都是原创内容，未经同意禁止转帖。\n3:专家分析内容仅供参考。\n4:本产品专家仅代表自己观点与本产品无关。\n5:本产品内容与苹果公司无关。";
    
    UIFont *textFont = [UIFont systemFontOfSize:15];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    
    attrs[NSFontAttributeName] = textFont;
    
    CGSize maxSize = CGSizeMake(textWidth-textMargin*2, MAXFLOAT);
    
    CGSize size = [message boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(textMargin,CGRectGetMaxY(titleLabel.frame) + textMargin,textWidth, size.height)];
    
    textLabel.font = textFont;
    
    textLabel.textColor = [UIColor blackColor];
    
    textLabel.backgroundColor = [UIColor clearColor];
    
    textLabel.lineBreakMode =NSLineBreakByWordWrapping;
    
    textLabel.numberOfLines =0;
    
    textLabel.textAlignment = NSTextAlignmentLeft;
    
    textLabel.text = message;
    
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textWidth + textMargin * 2,CGRectGetMaxY(textLabel.frame)+textMargin)];
    
    [demoView addSubview:textLabel];
    
    return demoView;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"足球专家";

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"声明" message:@"1:本产品仅用于专家与网友交流，禁止一切与非法赌博有关的活动。\n2:专家分析内容都是原创内容，未经同意禁止转帖。\n3:专家分析内容仅供参考。\n4:本产品专家仅代表自己观点与本产品无关。\n5:本产品内容与苹果公司无关。" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alert show];
    
    self.datas = [NSArray array];

//    //此处必须要有创见一个UICollectionViewFlowLayout的对象
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    //同一行相邻两个cell的最小间距
//    layout.minimumInteritemSpacing = 5;
//    //最小两行之间的间距
//    layout.minimumLineSpacing = 5;
//
//    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//    _collectionView.height = self.view.height - 64 - 49;
//    _collectionView.alwaysBounceVertical = YES;
//    _collectionView.dataSource = self;
//    _collectionView.delegate = self;
//    _collectionView.backgroundColor = RGBCOLOR_HEX(0xf5f5f5);
//    [self.view addSubview:_collectionView];
//
//    [_collectionView registerClass:[ZhuanJiaCell class] forCellWithReuseIdentifier:@"ZhuanJiaCell"];
//
//    [_collectionView registerClass:[ShopHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ShopHeaderView"];

    
    ShopHeaderView *headerView = [[ShopHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width * 0.7 + 60)];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.height = self.view.height - 64 - 49;
    tableView.backgroundColor = RGBCOLOR_HEX(0xf5f5f5);
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableHeaderView = headerView;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
    
    [self setData];
    
}


- (void) setData
{
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:ChengWeiZhuanJiaBanner WithParameters:nil success:^(id responseDic) {
        
        self.datas = [ZhuanJiaModel objectArrayWithKeyValuesArray:responseDic];
        
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
        
    }];
}

//////- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//////
//////{
//////    if([kind isEqualToString:UICollectionElementKindSectionHeader])
//////
//////    {
//////        NSString *CellIdentifier = @"ShopHeaderView";
//////        ShopHeaderView *cell = (ShopHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//////        return cell;
//////
//////    }
//////    return nil;
//////}
//////
//////- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//////
//////{
//////    
//////    return (CGSize){self.view.width,self.view.width * 0.7 + 60};
//////
//////}
//////
//////- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//////    return self.datas.count;
//////}
////
////- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
////    ZhuanJiaModel *model = self.datas[indexPath.row];
////    ZhuanJiaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZhuanJiaCell" forIndexPath:indexPath];
////    cell.backgroundColor = [UIColor whiteColor];
////    cell.layer.cornerRadius = 5;
////    cell.layer.masksToBounds = YES;
////    cell.model = model;
////    return cell;
////}
//
//
////定义每一个cell的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGFloat cellSize = (self.view.width - 10) * 0.3;
//    return CGSizeMake(cellSize, cellSize + 30 + 20);
//}
//
//// 设置整个组的缩进量是多少
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 10, 10, 10);
//}
//
//// 设置最小行间距，也就是前一行与后一行的中间最小间隔
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 10;
//}
//
//// 设置最小列间距，也就是左行与右一行的中间最小间隔
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 10;
//}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    ZhuanJiaModel *model = self.datas[indexPath.row];
//
//    ZhuanJiaDetailController *vc = [[ZhuanJiaDetailController alloc] init];
//    vc.model = model;
//    [self.navigationController pushViewController:vc animated:YES];
//
//}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.datas.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"HomeDataCell";
    HomeDataCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HomeDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    ZhuanJiaModel *model = self.datas[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        ZhuanJiaModel *model = self.datas[indexPath.row];
    
        ZhuanJiaDetailController *vc = [[ZhuanJiaDetailController alloc] init];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
}

@end
