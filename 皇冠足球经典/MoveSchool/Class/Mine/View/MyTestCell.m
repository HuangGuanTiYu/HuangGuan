//
//  MyTestCell.m
//  MoveSchool
//
//  Created by edz on 2017/9/13.
//
//

#import "MyTestCell.h"
#import "MyTestModel.h"

@interface MyTestCell()

//标题
@property (nonatomic,strong) UILabel *titleLabel;

//时长
@property (nonatomic,strong) UILabel *timeLabel;

//分割线
@property (nonatomic,strong) UIView *sepaView;

//分数
@property (nonatomic, strong) UILabel *scoreLabel;

//考试按钮
@property (nonatomic, strong) UILabel *testButton;

//间距
@property (nonatomic, strong) UIView *spacingView;

@end

@implementation MyTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = MainTextColor;
        [self.contentView addSubview:self.titleLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.timeLabel.textColor = AuxiliaryColor;
        [self.contentView addSubview:self.timeLabel];
        
        self.scoreLabel = [[UILabel alloc] init];
        self.scoreLabel.textAlignment = NSTextAlignmentRight;
        self.scoreLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.scoreLabel.textColor = MainColor;
        self.scoreLabel.hidden = YES;
        [self.contentView addSubview:self.scoreLabel];
        
        self.sepaView = [[UIView alloc] init];
        self.sepaView.backgroundColor = SepaViewColor;
        [self.contentView addSubview:self.sepaView];
        
        self.testButton = [[UILabel alloc] init];
        self.testButton.textAlignment = NSTextAlignmentCenter;
        self.testButton.font = [UIFont systemFontOfSize:ys_f24];
        [self.contentView addSubview:self.testButton];
        
        self.spacingView = [[UIView alloc] init];
        self.spacingView.backgroundColor = ViewBackColor;
        [self.contentView addSubview:self.spacingView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(15, 15, 0, 40);
    [self.titleLabel sizeToFit];
    if (self.type == NoFinish) {
        self.titleLabel.width = self.contentView.width - 30;
    }else
    {
        self.titleLabel.width = self.contentView.width - 50 - 30;
    }
    
    self.timeLabel.frame = CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame) + 12, self.contentView.width - 30, 20);
    [self.timeLabel sizeToFit];
    self.timeLabel.width = self.contentView.width - 30;
    
    self.sepaView.frame = CGRectMake(15, CGRectGetMaxY(self.timeLabel.frame) + 15, self.contentView.width - 15, 0.5);
    
    self.testButton.frame = CGRectMake(0, 0, 50, 20);
    self.testButton.centerX = self.contentView.width * 0.5;
    self.testButton.centerY = (self.contentView.height - mainSpacing - CGRectGetMaxY(self.sepaView.frame)) * 0.5 + CGRectGetMaxY(self.sepaView.frame);
    
    self.spacingView.frame = CGRectMake(0, self.contentView.height - mainSpacing, self.contentView.width, mainSpacing);
    
    self.scoreLabel.frame = CGRectMake(self.contentView.width - 50 - 15, 0, 50, 40);
    self.scoreLabel.centerY = self.titleLabel.centerY;
}

- (void)setModel:(MyTestModel *)model
{
    _model = model;
    
    self.titleLabel.text = model.title;
    
    //未完成
    if (self.type == NoFinish) {
        self.scoreLabel.hidden = YES;
        self.timeLabel.text = [NSString stringWithFormat:@"时长：%@分      %@ ~ %@",model.timeLength,model.btime, model.etime];
    }else
    {
        self.scoreLabel.hidden = NO;
        self.timeLabel.text = [NSString stringWithFormat:@"时长：%@分      状态次数： %d      考试时间：%@",model.timeLength,model.testnum, model.testdate];
    }
    
    //未完成
    if (self.type == NoFinish) {
        self.testButton.layer.borderWidth = 0.5;
        self.testButton.layer.cornerRadius = fillet;
        self.testButton.layer.masksToBounds = YES;
        
        if (self.model.testnum == 0) { //没考过
            self.testButton.text = @"去考试";
            self.testButton.textColor = MainColor;
            self.testButton.layer.borderColor = MainColor.CGColor;
        }else
        {
            if ([model.status isEqualToString:@"0"]) { //补考
                self.testButton.text = @"去补考";
                self.testButton.textColor = MainColor;
                self.testButton.layer.borderColor = MainColor.CGColor;
            }else if ([model.status isEqualToString:@"2"]) //阅卷中
            {
                self.testButton.text = @"阅卷中";
                self.testButton.textColor = AuxiliaryColor;
                self.testButton.layer.borderColor = [UIColor clearColor].CGColor;
            }else
            {
                self.testButton.textColor = MainColor;
                self.testButton.layer.borderColor = MainColor.CGColor;
                self.testButton.text = @"";
            }
        }
        
    }else //已完成
    {
        self.testButton.layer.borderColor = [UIColor clearColor].CGColor;

        if ([model.status isEqualToString:@"0"]) { //未通过
            self.testButton.textColor = MainRedColor;
            self.testButton.text = @"未通过";
        }else if ([model.status isEqualToString:@"1"]) //已通过
        {
            self.testButton.textColor = AuxiliaryColor;
            self.testButton.text = @"已通过";
        }else if ([model.status isEqualToString:@"2"]) //阅卷中
        {
            self.testButton.textColor = AuxiliaryColor;
            self.testButton.text = @"阅卷中";
        }
        else
        {
            self.testButton.textColor = AuxiliaryColor;
            self.testButton.text = @"";
        }
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%d分",model.score];
}

@end
