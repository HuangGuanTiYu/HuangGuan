//
//  LiveListCell.m
//  MoveSchool
//
//  Created by edz on 2017/8/22.
//
//

#import "LiveListCell.h"
#import "UIImageView+WebCache.h"
#import "HomePageModel.h"
#import "AFNetWW.h"

@interface LiveListCell()

@property (nonatomic, strong) UIImageView *backImage;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) UIButton *stateLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *boomView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation LiveListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.backImage];
        
        self.titleView = [[UIView alloc] init];
        self.titleView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        [self.contentView addSubview:self.titleView];
        
        self.stateLabel = [[UIButton alloc] init];
        [self.stateLabel addTarget:self action:@selector(stateLabelClick) forControlEvents:UIControlEventTouchUpInside];
        self.stateLabel.layer.cornerRadius = fillet;
        self.stateLabel.layer.masksToBounds = YES;
        self.stateLabel.layer.borderWidth = 1;
        self.stateLabel.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.stateLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleView addSubview:self.stateLabel];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:ys_28];
        [self.titleView addSubview:self.titleLabel];
        
        self.boomView = [[UIView alloc] init];
        self.boomView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.boomView];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.userInteractionEnabled = YES;
        self.timeLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.timeLabel.textColor = AuxiliaryColor;
        [self.boomView addSubview:self.timeLabel];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.nameLabel.textColor = AuxiliaryColor;
        [self.boomView addSubview:self.nameLabel];
        
        self.countLabel = [[UILabel alloc] init];
        self.countLabel.textAlignment = NSTextAlignmentRight;
        self.countLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.countLabel.textColor = AuxiliaryColor;
        [self.boomView addSubview:self.countLabel];
        
        self.backgroundColor = ViewBackColor;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backImage.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.width / 2);
    
    self.titleView.frame = CGRectMake(0, self.backImage.height - 35, self.contentView.width, 35);
    
    self.stateLabel.frame = CGRectMake(15, 0, 50, 17);
    self.stateLabel.centerY = self.titleView.height * 0.5;
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.stateLabel.frame) + 15, 0, self.titleView.width - CGRectGetMaxX(self.stateLabel.frame) - 30, self.stateLabel.height);
    self.titleLabel.centerY = self.stateLabel.centerY;
    
    self.boomView.frame = CGRectMake(0, CGRectGetMaxY(self.titleView.frame), self.contentView.width, 35);
    
    self.timeLabel.frame = CGRectMake(15, 0, 120, 17);
    self.timeLabel.centerY = self.boomView.height * 0.5;
    
    CGFloat nameLabelW = self.boomView.width - CGRectGetMaxX(self.timeLabel.frame);
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame) + mainSpacing, 0, nameLabelW * 0.5, self.timeLabel.height);
    
    self.nameLabel.centerY = self.timeLabel.centerY;
    
    self.countLabel.frame = CGRectMake(CGRectGetMaxX(self.nameLabel.frame), 0, (nameLabelW - 15) * 0.5 - 15, self.timeLabel.height);
    self.countLabel.centerY = self.nameLabel.centerY;
}

- (void)setModel:(HomePageModel *)model
{
    _model = model;
    
    [self.backImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"zwt_kecheng"]];
    
    self.titleLabel.text = model.title;
    
    if ([model.living isEqualToString:@"1"]) { //正在直播
        [self.stateLabel setTitle:@"直播中" forState:UIControlStateNormal];
        self.stateLabel.backgroundColor = MainRedColor;
        [self.stateLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.stateLabel.layer.borderColor = [UIColor clearColor].CGColor;
        self.countLabel.text = [NSString stringWithFormat:@"%@人参加",model.learnNum];

    }else if ([model.living isEqualToString:@"2"]) //预约
    {
        [self.stateLabel setTitle:@"预约" forState:UIControlStateNormal];
        self.stateLabel.backgroundColor = [UIColor clearColor];
        [self.stateLabel setTitleColor:MainColor forState:UIControlStateNormal];
        self.stateLabel.layer.borderColor = MainColor.CGColor;
        self.countLabel.text = [NSString stringWithFormat:@"%@人预约",model.learnNum];

    }else //已预约
    {
        [self.stateLabel setTitle:@"已预约" forState:UIControlStateNormal];
        [self.stateLabel setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
        self.stateLabel.backgroundColor = [UIColor clearColor];
        self.stateLabel.layer.borderColor = AuxiliaryColor.CGColor;
        self.countLabel.text = [NSString stringWithFormat:@"%@人预约",model.learnNum];

    }
    
    self.timeLabel.text = model.indate;
    self.nameLabel.text = [NSString stringWithFormat:@"讲师：%@",model.nickname];
}

- (void) stateLabelClick
{

    if ([self.model.living isEqualToString:@"2"] || [self.model.living isEqualToString:@"3"]) {
    
        NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,LiveOrder,[UserInfoTool getUserInfo].token];
        
        NSDictionary *dic=@{
                            @"liveid":self.model.businessid
                            };
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:dic success:^(id responseDic)
         {
             if ([responseDic[@"rescode"] intValue] == 10000) {
                 
                 [MBProgressHUD showText:responseDic[@"msg"] inview:[[UIApplication sharedApplication].windows lastObject]];

                 int source = [responseDic[@"data"][@"source"] intValue];
                 if (source == -1) { //取消预约
                     self.model.living = @"2";
                     
                     [self.stateLabel setTitle:@"预约" forState:UIControlStateNormal];
                     self.stateLabel.backgroundColor = [UIColor clearColor];
                     [self.stateLabel setTitleColor:MainColor forState:UIControlStateNormal];
                     self.stateLabel.layer.borderColor = MainColor.CGColor;
                     
                 }else if(source == 2) //预约成功
                 {
                     self.model.living = @"3";
                     [self.stateLabel setTitle:@"已预约" forState:UIControlStateNormal];
                     [self.stateLabel setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
                     self.stateLabel.backgroundColor = [UIColor clearColor];
                     self.stateLabel.layer.borderColor = AuxiliaryColor.CGColor;
                 }
             }
             
         }fail:^(NSError *error) {
             
         }];
    }
}

@end
