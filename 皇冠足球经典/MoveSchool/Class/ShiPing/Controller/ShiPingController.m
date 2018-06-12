//
//  ShiPingController.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/6/11.
//

#import "ShiPingController.h"
#import "ShiPinListController.h"
#import "LeftSlideViewController.h"

@interface ShiPingController ()

@end

@implementation ShiPingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置buttonBarView属性 选中文字变大 文字颜色
    [self setButtonBarView];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem setRightNavigationBarBackGroundImgName:@"leftIcon" target:self selector:@selector(back)];

}

- (void) back
{
    
    LeftSlideViewController *LeftSlideVC = (LeftSlideViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [LeftSlideVC openLeftView];//关闭左侧抽屉
}

- (void) setButtonBarView
{
    self.isProgressiveIndicator = YES;
    
    self.changeCurrentIndexProgressiveBlock = ^void(XLButtonBarViewCell *oldCell, XLButtonBarViewCell *newCell, CGFloat progressPercentage, BOOL changeCurrentIndex, BOOL animated){
        if (changeCurrentIndex) {
            [oldCell.label setTextColor:AuxiliaryColor];
            [newCell.label setTextColor:MainColor];
            
            if (animated) {
                [UIView animateWithDuration:0.1
                                 animations:^(){
                                     oldCell.label.font = [UIFont systemFontOfSize:14];
                                     newCell.label.font = [UIFont systemFontOfSize:14];
                                     
                                 }
                                 completion:nil];
            }
            else{
                oldCell.label.font = [UIFont systemFontOfSize:14];
                newCell.label.font = [UIFont systemFontOfSize:14];
            }
        }
    };
}

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    self.buttonBarView.shouldCellsFillAvailableWidth = YES;
    self.buttonBarView.backgroundColor = [UIColor whiteColor];
    self.buttonBarView.selectedBarAlignment = XLSelectedBarAlignmentCenter;
    
    NSMutableArray *childVcArray = [NSMutableArray array];
    
    
    ShiPinListController *jieshu0 = [[ShiPinListController alloc] init];
    jieshu0.studyTitle = @"全部";
    jieshu0.type = ALL;
    [childVcArray addObject:jieshu0];
    
    ShiPinListController *jieshu1 = [[ShiPinListController alloc] init];
    jieshu1.studyTitle = @"国际足球";
    jieshu1.type = GUOJI;
    [childVcArray addObject:jieshu1];
    
    ShiPinListController *jieshu2 = [[ShiPinListController alloc] init];
    jieshu2.studyTitle = @"英超";
    jieshu2.type = YINGCHAO;
    [childVcArray addObject:jieshu2];
    
    ShiPinListController *jieshu3 = [[ShiPinListController alloc] init];
    jieshu3.studyTitle = @"意甲";
    jieshu3.type = YIJIA;
    [childVcArray addObject:jieshu3];
    
    ShiPinListController *jieshu4 = [[ShiPinListController alloc] init];
    jieshu4.studyTitle = @"西甲";
    jieshu4.type = XIJIA;
    [childVcArray addObject:jieshu4];
    
    ShiPinListController *jieshu5 = [[ShiPinListController alloc] init];
    jieshu5.studyTitle = @"德甲";
    jieshu5.type = DEJIA;
    [childVcArray addObject:jieshu5];
    
    return childVcArray;
}

@end
