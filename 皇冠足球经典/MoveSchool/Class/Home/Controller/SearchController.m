//
//  SearchController.m
//  MoveSchool
//
//  Created by edz on 2017/9/20.
//
//

#import "SearchController.h"
#import "TBCityIconFont.h"
#import "UITextField+Extension.h"
#import "AFNetWW.h"
#import "SearchModel.h"
#import "MJExtension.h"
#import "UIImageView+CornerRadius.h"
#import "SearchResultModel.h"
#import "SearchResultController.h"

@interface SearchController ()

@property (nonatomic, strong) UIView *tagView;

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setData];
    
    [self setUpUI];
    
}


- (void) setUpUI
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width - 30, 44)];
    
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleView.width - 35, 30)];
    searchView.backgroundColor = RGBCOLOR(135, 135, 135);
    searchView.layer.cornerRadius = 3;
    searchView.layer.masksToBounds = YES;
    searchView.centerY = titleView.height * 0.5;
    [titleView addSubview:searchView];
    
    //搜索按钮
    UIImageView *searchImgae = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(searchView.frame) - 20 - mainSpacing, 0, 16, 16)];
    [searchImgae setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e694", ys_f24, [UIColor whiteColor])]];
    searchImgae.centerY = searchView.height * 0.5;
    [searchView addSubview:searchImgae];
    
    //输入框
    UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, searchView.width - searchImgae.width - 2 * mainSpacing, searchView.height)];
    [searchField setLefSpacing:15];
    searchField.returnKeyType = UIReturnKeySearch;
    searchField.textColor = [UIColor whiteColor];
    searchField.font = [UIFont systemFontOfSize:15];
    [searchField setPlaceholder:@"请输入要搜索的关键词"];
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [searchView addSubview:searchField];
    
    //取消
    UIButton *cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(searchView.frame) + mainSpacing, 0, 25, 30)];
    [cancleButton addTarget:self action:@selector(cancleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    cancleButton.centerY = searchView.centerY;
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [titleView addSubview:cancleButton];
    
    self.navigationItem.titleView = titleView;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.hidesBackButton = YES;
}

- (void) cancleButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) setData
{
    
    UIView *tagView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.tagView = tagView;
    [self.view addSubview:tagView];
    
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,SearchLine,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             //热门搜索
             UILabel *searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, self.view.width - 30, 15)];
             searchLabel.text = @"热门操作";
             searchLabel.font = [UIFont systemFontOfSize:ys_f30];
             searchLabel.textColor = MainTextColor;
             [searchLabel sizeToFit];
             [tagView addSubview:searchLabel];
             
             //中间间距
             CGFloat spaing = 10;
             
             //两边间距
             CGFloat lrSpaing = 15;
             
             //按钮宽度
             CGFloat buttonW = (self.view.width - 2 * lrSpaing - 3 * spaing) / 4;
             
             NSArray *searchs = [SearchModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
             
             //历史搜索
             UILabel *historyLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.width - 30, 15)];
             [historyLabel sizeToFit];
             historyLabel.text = @"历史搜索";
             historyLabel.font = [UIFont systemFontOfSize:ys_f30];
             historyLabel.textColor = MainTextColor;
             [historyLabel sizeToFit];
             [tagView addSubview:historyLabel];
             
             for (int i = 0; i < searchs.count; i ++) {
                 SearchModel *model = searchs[i];

                 UIButton *button = [[UIButton alloc] init];
                 button.adjustsImageWhenHighlighted = NO;
                 [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                 button.layer.borderColor = AuxiliaryColor.CGColor;
                 button.layer.borderWidth = 0.5;
                 button.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
                 [button setTitle:model.tag forState:UIControlStateNormal];
                 [button setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
                 [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
                 button.width = buttonW;
                 button.height = 25;
                 button.x = lrSpaing + (i % 4) * (spaing + buttonW);
                 button.y = lrSpaing + (i / 4) * (spaing + 25) + CGRectGetMaxY(searchLabel.frame);
                 [tagView addSubview:button];
                 
                 UIImageView *normalImage = [[UIImageView alloc] initWithFrame:button.bounds];
                 [normalImage zy_cornerRadiusAdvance:fillet rectCornerType:UIRectCornerAllCorners];
                 normalImage.image = [UIImage createImageWithColor:[UIColor whiteColor]];
                 [button setBackgroundImage:normalImage.image forState:UIControlStateNormal];
                 
                 normalImage.image = [UIImage createImageWithColor:MainColor];
                 [button setBackgroundImage:normalImage.image forState:UIControlStateSelected];
                 
                 button.layer.cornerRadius = fillet;
                 
                 if (i == searchs.count - 1) {
                     historyLabel.y = CGRectGetMaxY(button.frame) + 20;
                 }
             }
             
//             NSArray *historyList = [MainUserDefaults objectForKey:SearchHistory];
//             if (historyList.count > 0) {
//                 historyLabel.hidden = NO;
//                 //清空
//                 UIButton *clearAll = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(historyLabel.frame) + 5, 0, 30, 15)];
//                 clearAll.centerY = historyLabel.centerY;
//                 [clearAll setTitle:@"清空" forState:UIControlStateNormal];
//                 [clearAll setTitleColor:MainColor forState:UIControlStateNormal];
//                 clearAll.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
//                 [tagView addSubview:clearAll];
//             }else
//             {
//                 historyLabel.hidden = YES;
//             }
         }
         
     }fail:^(NSError *error) {
         
     }];
}

- (void) buttonClick : (UIButton *) button
{
    button.layer.borderColor = [UIColor clearColor].CGColor;
    button.selected = !button.selected;
    
    [self toSearch:button.titleLabel.text];
    
}

#pragma mark 搜索
- (void) toSearch : (NSString *) key
{
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?key=%@&businesscode=%@",NetHeader,SearchKey,key,@"40400 "];
    likeUrl = [likeUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             NSArray *array = [SearchResultModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
             
             SearchResultController *searchResult = [[SearchResultController alloc] init];
             searchResult.classifys = array;
             self.tagView.hidden = YES;
             [self.view addSubview:searchResult.view];
         }
         
     }fail:^(NSError *error) {
         
     }];
}

@end
