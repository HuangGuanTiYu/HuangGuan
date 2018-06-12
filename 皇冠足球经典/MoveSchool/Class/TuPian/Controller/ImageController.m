//
//  ImageController.m
//  XiuMei
//
//  Created by edz on 2017/11/25.
//  Copyright © 2017年 xiuMie. All rights reserved.
//

#import "ImageController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Extension.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetWW.h"
#import "TuPianModelTool.h"
#import "TuPianModel.h"
#import "TuPianModelTool.h"

@interface ImageController ()<UIScrollViewDelegate, UIAlertViewDelegate>

@property (nonatomic, assign) int currentIndex;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *nextImage;

@property (nonatomic, strong) NSMutableArray *effectViews;

@property (nonatomic, strong) NSMutableArray *effectView2s;

@property (nonatomic, strong) NSMutableArray *payButtons;

@end

@implementation ImageController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.effectViews = [NSMutableArray array];
    self.effectView2s = [NSMutableArray array];
    self.payButtons = [NSMutableArray array];

    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.currentIndex = 1;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(0, self.Photos.count * self.view.height);
    [self.view addSubview:scrollView];
    
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }

    //箭头
    UIImageView *nextImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.height - 60, 56, 60)];
    self.nextImage = nextImage;
    nextImage.image = [UIImage imageNamed:@"ic_top"];
    nextImage.centerX = self.view.width * 0.5;
    [self.view addSubview:nextImage];
    if (self.Photos.count == 1) {
        nextImage.hidden = YES;
    }
    
    for (int i = 0 ; i < self.Photos.count ; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i * self.view.height, self.view.width, self.view.height)];
        imageView.backgroundColor = [UIColor blackColor];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.Photos[i]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            imageView.image = image;

        }];

        [scrollView addSubview:imageView];
    }
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 15 + 20, 36, 36)];
    [backButton setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    self.titleLabel = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = [NSString stringWithFormat:@"%d/%lu",self.currentIndex,(unsigned long)self.Photos.count];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.centerY = backButton.centerY;
    [self.view addSubview:titleLabel];
    
    UIButton *shoucangButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [shoucangButton addTarget:self action:@selector(shoucangButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [shoucangButton setImage:[UIImage imageNamed:@"ic_shoucang_press"] forState:UIControlStateSelected];
    [shoucangButton setImage:[UIImage imageNamed:@"ic_shoucang_normal"] forState:UIControlStateNormal];
    shoucangButton.centerX = self.view.width * 0.5;
    shoucangButton.centerY = self.view.height * 0.8;
    [self.view addSubview:shoucangButton];
    
    NSArray *tuPians = [TuPianModelTool videoModels];
    for (TuPianModel *model in tuPians) {
        if ([model.title isEqualToString:self.model.title]) {
            shoucangButton.selected = YES;
        }
    }
    
} 

- (void) shoucangButtonClick : (UIButton *) button
{
    //拉取首页 猜你喜欢
    NSString *likeUrl = [NSString stringWithFormat:@"%@",shoucang];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {
         
         if ([responseDic[@"code"] isEqualToString:@"1"]) {
             if (button.selected) {
                 [TuPianModelTool removeVideoModel:self.model];
                 [MBProgressHUD showSuccess:@"取消成功"];
             }else
             {
                 [TuPianModelTool saving:self.model];
                 [MBProgressHUD showSuccess:@"收藏成功"];
             }
             button.selected = !button.selected;
         }
     }fail:^(NSError *error) {
         
         
     }];
    
}

- (void) backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.currentIndex = (int)(scrollView.contentOffset.y / scrollView.frame.size.height + 0.5) + 1;
    self.titleLabel.text = [NSString stringWithFormat:@"%d/%lu",self.currentIndex,(unsigned long)self.Photos.count];
    
    if (self.currentIndex == self.Photos.count) {
        self.nextImage.hidden = YES;
    }else
    {
        self.nextImage.hidden = NO;
    }
}


@end
