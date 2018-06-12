//
//  LishiTuiJianCell.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/23.
//

#import "LishiTuiJianCell.h"
#import "TBCityIconFont.h"
#import "LiShiModel.h"

@interface LishiTuiJianCell()

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *stateLabel;

@property (nonatomic, strong) UIImageView *nextImage;

@end

@implementation LishiTuiJianCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.textColor = RGBCOLOR_HEX(0x999999);
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.timeLabel];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.titleLabel];
        
        self.stateLabel = [[UILabel alloc] init];
        self.stateLabel.textColor = MainColor;
        self.stateLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.stateLabel];
        
        self.nextImage = [[UIImageView alloc] init];
        self.nextImage.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e614",15, AuxiliaryColor)];
        [self.contentView addSubview:self.nextImage];
        
    }
    return self;
}


- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    self.timeLabel.frame = CGRectMake(15, 15, 0, 0);
    self.timeLabel.text = self.model.time;
    [self.timeLabel sizeToFit];
    
    self.titleLabel.frame = CGRectMake(15, CGRectGetMaxY(self.timeLabel.frame) + 5, 0, 0);
    self.titleLabel.text = self.model.title;
    [self.titleLabel sizeToFit];
    
    self.nextImage.frame = CGRectMake(self.contentView.width - 20 - 15, 0, 20, 20);
    self.nextImage.centerY = self.contentView.height * 0.5;
    
    self.stateLabel.frame = CGRectMake(0, 15, 20, 20);
    self.stateLabel.text = [self.model.state isEqualToString:@"0"] ? @"未中奖" : @"中奖";
    self.stateLabel.textColor = [self.model.state isEqualToString:@"0"] ? RGBCOLOR_HEX(0x999999) : MainColor;
    [self.stateLabel sizeToFit];
    self.stateLabel.x = self.nextImage.x - self.stateLabel.width - 10;
    self.stateLabel.centerY = self.nextImage.centerY;
    
    self.titleLabel.width = self.stateLabel.x - 15 - 15;
}

- (void)setModel:(LiShiModel *)model
{
    
    _model = model;
    
    
}

@end
