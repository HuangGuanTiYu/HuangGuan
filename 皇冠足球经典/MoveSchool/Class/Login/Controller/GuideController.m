//
//  GuideController.m
//  SchoolBus
//
//  Created by edz on 2017/5/16.
//  Copyright © 2017年 顾海波. All rights reserved.
//

#import "GuideController.h"
#import "MainNavigationController.h"
#import "MianTabBarController.h"

@interface GuideController ()

@end

@implementation GuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    for (int i = 0; i < 4; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:scrollView.bounds];
        imageView.x = i * scrollView.width;
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"splashX0%d",i + 1]];
        [scrollView addSubview:imageView];
        
        if (i == 3) {
            UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height - 84, 220, 54)];
            startButton.backgroundColor = GreenColor;
            startButton.centerX = self.view.width * 0.5;
            startButton.titleLabel.font = [UIFont systemFontOfSize:25];
            [startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [startButton setTitle:@"立即开始" forState:UIControlStateNormal];
            startButton.layer.cornerRadius = 5;
            startButton.layer.masksToBounds = YES;
            startButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [imageView addSubview:startButton];
        }
    }
    scrollView.contentSize = CGSizeMake(self.view.width * 4, 0);
    [self.view addSubview:scrollView];
    
}

- (void) startButtonClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[MianTabBarController alloc] init];
}

- (BOOL)shouldAutorotate
{
    return NO;
}


#pragma mark 全项目支持竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
