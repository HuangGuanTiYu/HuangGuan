//
//  TuiJianDetailController.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/23.
//

#import "TuiJianDetailController.h"
#import "AFNetWW.h"
#import "YuCeDetailModel.h"
#import "MJExtension.h"

@interface TuiJianDetailController ()

@property (nonatomic, strong) UILabel *yuceTitle;

@property (nonatomic, strong) UILabel *yuce;

@property (nonatomic, strong) UILabel *peilv;

@property (nonatomic, strong) UILabel *jieguo;

@property (nonatomic, strong) UILabel *fenxiTitle;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *yuceContentView;

@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation TuiJianDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"推荐详情";
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    topView.backgroundColor = RGBCOLOR_HEX(0xf5f5f5);
    [scrollView addSubview:topView];
        
    UIView *yuceLeft = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(topView.frame) + 20, 3, 0)];
    yuceLeft.backgroundColor = MainColor;
    [scrollView addSubview:yuceLeft];
    
    UILabel *yuceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(yuceLeft.frame) + 10, 0, 0, 0)];
    yuceLabel.text = @"预测";
    yuceLabel.font = [UIFont systemFontOfSize:18];
    yuceLabel.textColor = MainColor;
    [yuceLabel sizeToFit];
    yuceLeft.height = yuceLabel.height - 5;
    yuceLabel.centerY = yuceLeft.centerY;
    [scrollView addSubview:yuceLabel];
    
    UILabel *yuceTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(yuceLeft.frame) + 20, self.view.width - 30, 10)];
    yuceTitle.font = [UIFont systemFontOfSize:18];
    yuceTitle.numberOfLines = 0;
    self.yuceTitle = yuceTitle;
    [scrollView addSubview:yuceTitle];
    
    UIView *yuceContentView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(yuceTitle.frame) + 10, self.view.width - 30, 100)];
    self.yuceContentView = yuceContentView;
    yuceContentView.layer.cornerRadius = 10;
    yuceContentView.layer.masksToBounds = YES;
    yuceContentView.backgroundColor = MainColor;
    [scrollView addSubview:yuceContentView];

    //预测
    UILabel *yuce = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, yuceContentView.width - 30, 20)];
    yuce.font = [UIFont systemFontOfSize:18];
    yuce.textColor = [UIColor whiteColor];
    yuce.numberOfLines = 0;
    self.yuce = yuce;
    [yuceContentView addSubview:yuce];
    
    //最新赔率
    UILabel *peilv = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(yuce.frame) + 2, yuceContentView.width - 30, 20)];
    peilv.font = [UIFont systemFontOfSize:18];
    peilv.textColor = [UIColor whiteColor];
    peilv.numberOfLines = 0;
    self.peilv = peilv;
    [yuceContentView addSubview:peilv];
    
    //结果
    UILabel *jieguo = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(peilv.frame) + 2, yuceContentView.width - 30, 20)];
    jieguo.font = [UIFont systemFontOfSize:18];
    jieguo.textColor = [UIColor whiteColor];
    jieguo.numberOfLines = 0;
    self.jieguo = jieguo;
    [yuceContentView addSubview:jieguo];
    
    UIView *yuceLeft2 = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(yuceContentView.frame) + 30, 3, 0)];
    yuceLeft2.backgroundColor = MainColor;
    [scrollView addSubview:yuceLeft2];
    
    UILabel *fenxiLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(yuceLeft2.frame) + 10, 0, 0, 0)];
    fenxiLabel.text = @"分析";
    fenxiLabel.font = [UIFont systemFontOfSize:18];
    fenxiLabel.textColor = MainColor;
    [fenxiLabel sizeToFit];
    yuceLeft2.height = fenxiLabel.height - 5;
    fenxiLabel.centerY = yuceLeft2.centerY;
    [scrollView addSubview:fenxiLabel];
    
    UILabel *fenxiTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(yuceLeft2.frame) + 20, self.view.width - 30, 10)];
    fenxiTitle.font = [UIFont systemFontOfSize:18];
    fenxiTitle.numberOfLines = 0;
    self.fenxiTitle = fenxiTitle;
    [scrollView addSubview:fenxiTitle];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(fenxiTitle.frame) + 20, self.view.width - 30, 100)];
    contentLabel.font = [UIFont systemFontOfSize:18];
    contentLabel.numberOfLines = 0;
    self.contentLabel = contentLabel;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:contentLabel];

    
    [self getData];
}

- (void) getData
{
    //拉取首页 猜你喜欢
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@%@",LiShiTuiJian,self.name,self.ID];
    
    likeUrl = [likeUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
     {

         YuCeDetailModel *model = [YuCeDetailModel objectWithKeyValues:responseDic];
         self.yuceTitle.text = model.yuceTitle;
         [self.yuceTitle sizeToFit];

         self.yuceContentView.y = CGRectGetMaxY(self.yuceTitle.frame) + 10;
         
         self.yuce.text = model.yuce;
         [self.yuce sizeToFit];
         
         self.peilv.text = model.peilv;
         [self.peilv sizeToFit];

         self.jieguo.text = model.jieguo;
         [self.jieguo sizeToFit];

         self.fenxiTitle.text = model.fenxiTitle;
         [self.fenxiTitle sizeToFit];

         self.contentLabel.text = model.fenxiContent;
         [self.contentLabel sizeToFit];

         self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.contentLabel.frame) + 10 + 64);

     }fail:^(NSError *error) {
         
         
     }];
    
}


@end
