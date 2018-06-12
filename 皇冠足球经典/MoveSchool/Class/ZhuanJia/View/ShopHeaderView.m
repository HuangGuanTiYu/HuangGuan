//
//  ShopHeaderView.m
//  Duolequ
//
//  Created by 顾海波 on 2018/5/3.
//  Copyright © 2018年 com.duolequ. All rights reserved.
//

#import "ShopHeaderView.h"
#import "AFNetWW.h"
#import "BannerModel.h"
#import "SDCycleScrollView.h"
#import "MJExtension.h"
#import "MainWebController.h"

@implementation ShopHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *url = ShenNiZuQiuZhuanJiaBanner;
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
            
            NSArray *banners = [BannerModel objectArrayWithKeyValuesArray:responseDic];
            
            NSMutableArray *imageArr =  [NSMutableArray array];
            NSMutableArray *titleArr =  [NSMutableArray array];
            
            if (banners.count > 0) {
                for (BannerModel *model in banners) {
                    [imageArr addObject:model.imgurl];
                    [titleArr addObject:model.title];
                }
            }
            
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width * 0.7 + 30 - 10)];
            headerView.backgroundColor = ViewBackColor;
            
            // 轮播图
            SDCycleScrollView *apView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, headerView.width, headerView.height)];
            apView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
            apView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
            apView.pageDotColor = RGBCOLOR(54,54,66);
            apView.pageControlBottomOffset = 40;
            apView.titleLabelBackgroundColor = [UIColor whiteColor];
            apView.titleLabelTextColor = MainTextColor;
            [headerView addSubview:apView];
            
            apView.imageURLStringsGroup = imageArr;
            apView.titlesGroup = titleArr;
            
            UILabel *tuijian = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(apView.frame) + 10, 0, 0)];
            tuijian.text = @"推荐专家";
            [tuijian sizeToFit];
            tuijian.centerX = self.width * 0.5;
            [headerView addSubview:tuijian];
            
            UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tuijian.x - 10, 1)];
            leftView.backgroundColor = SepaViewColor;
            leftView.centerY = tuijian.centerY;
            [headerView addSubview:leftView];
            
            UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(tuijian.frame) + 10, 0, leftView.width, 1)];
            rightView.backgroundColor = SepaViewColor;
            rightView.centerY = tuijian.centerY;
            [headerView addSubview:rightView];
            
            [self addSubview:headerView];
            
        } fail:^(NSError *error) {
            
            
        }];
    }
    return self;
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
}

@end
