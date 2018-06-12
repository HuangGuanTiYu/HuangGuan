//
//  SaiChengController.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/24.
//

#import "SaiChengController.h"
#import "SaiChengListController.h"
#import "LeftTitleButton.h"
#import "THDatePickerView.h"

@interface SaiChengController ()<THDatePickerViewDelegate>

@property (weak, nonatomic) THDatePickerView *dateView;

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, strong) LeftTitleButton *titleButton;

@property (nonatomic, strong) SaiChengListController *weijieshu;

@property (nonatomic, strong) SaiChengListController *jieshu;

@end

@implementation SaiChengController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LeftTitleButton *titleButton = [[LeftTitleButton alloc] initWithFrame:CGRectMake(0, 0, 300, 0)];
    self.titleButton = titleButton;
    [titleButton setTitle:@"2018年05月23日" forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"ic_jiantou"] forState:UIControlStateNormal];
    [titleButton sizeToFit];
    titleButton.width = titleButton.width + 20;
    self.navigationItem.titleView = titleButton;
    [titleButton addTarget:self action:@selector(titleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //设置buttonBarView属性 选中文字变大 文字颜色
    [self setButtonBarView];
    
    THDatePickerView *dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300)];
    dateView.delegate = self;
    dateView.title = @"请选择时间";
    [self.view addSubview:dateView];
    self.dateView = dateView;
}

- (NSString *) getData
{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateStr;
    dateStr = [format1 stringFromDate:date];
    return dateStr;
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
    
    SaiChengListController *weijieshu = [[SaiChengListController alloc] init];
    weijieshu.studyTitle = @"未结束";
    weijieshu.isYiBaoMing = NO;
    self.weijieshu = weijieshu;
    [childVcArray addObject:weijieshu];

    SaiChengListController *jieshu = [[SaiChengListController alloc] init];
    self.jieshu = jieshu;
    jieshu.studyTitle = @"已结束";
    jieshu.isYiBaoMing = YES;
    [childVcArray addObject:jieshu];
    
    return childVcArray;
}

- (void) titleButtonClick
{
    UIView *maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    [maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewClick)]];
    self.maskView = maskView;
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.5;
    [self.view addSubview:maskView];
    
    [self.view bringSubviewToFront:self.dateView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
        [self.dateView show];
    }];
}

- (void) maskViewClick
{
    [self datePickerViewCancelBtnClickDelegate];
}

- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer noTimer:(NSString *)noTimer
{
    
    [self.titleButton setTitle:timer forState:UIControlStateNormal];
    [self datePickerViewCancelBtnClickDelegate];
    
    [self.weijieshu change : noTimer];
    [self.jieshu change : noTimer];

}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate
{
    [self.maskView removeFromSuperview];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
}

@end
