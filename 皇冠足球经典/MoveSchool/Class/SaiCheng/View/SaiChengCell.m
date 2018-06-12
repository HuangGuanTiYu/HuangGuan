//
//  SaiChengCell.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/24.
//

#import "SaiChengCell.h"
#import "SaiChengModel.h"
#import "UIImageView+WebCache.h"

@interface SaiChengCell()

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIImageView *leftImage;

@property (nonatomic, strong) UILabel *leftName;

@property (nonatomic, strong) UIImageView *rightImage;

@property (nonatomic, strong) UILabel *rightName;

@property (nonatomic, strong) UIView *sepaView;

@property (nonatomic, strong) UILabel *tagLabel;

@end

@implementation SaiChengCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.textColor = RGBCOLOR_HEX(0x999999);
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.timeLabel];
        
        self.leftImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.leftImage];
        
        self.leftName = [[UILabel alloc] init];
        self.leftName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.leftName];
        
        self.rightImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.rightImage];
        
        self.rightName = [[UILabel alloc] init];
        self.rightName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.rightName];
        
        
        self.sepaView = [[UIView alloc] init];
        self.sepaView.backgroundColor = ViewBackColor;
        [self.contentView addSubview:self.sepaView];
        
        self.tagLabel = [[UILabel alloc] init];
        self.tagLabel.textColor = RGBCOLOR_HEX(0x999999);
        [self.contentView addSubview:self.tagLabel];
    }
    return self;
}


- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    self.sepaView.frame = CGRectMake(0, 0, self.contentView.width, 10);
    
    self.timeLabel.frame = CGRectMake(15, CGRectGetMaxY(self.sepaView.frame) + 10, 0, 0);
    self.timeLabel.text = self.model.time;
    [self.timeLabel sizeToFit];
    
    self.leftImage.frame = CGRectMake(15, 0, 50, 50);
    [self.leftImage sd_setImageWithURL:[NSURL URLWithString:self.model.leftImage]];
    self.leftImage.centerY = (self.contentView.height - 10 - CGRectGetMaxY(self.timeLabel.frame)) * 0.5 + CGRectGetMaxY(self.timeLabel.frame) + 5;
    
    self.leftName.frame = CGRectMake(CGRectGetMaxX(self.leftImage.frame) + 15, 0, 0, 0);
    self.leftName.text = self.model.leftName;
    [self.leftName sizeToFit];
    self.leftName.centerY = self.leftImage.centerY;
    
    self.tagLabel.frame = CGRectMake(0, 0, 0, 0);
    self.tagLabel.text = @"未开始";
    if (self.isYiBaoMing) {
        self.tagLabel.text = self.model.bifen;
    }
    [self.tagLabel sizeToFit];
    self.tagLabel.centerX = self.contentView.width * 0.5;
    self.tagLabel.centerY = self.leftImage.centerY;
    
    self.rightName.frame = CGRectMake(CGRectGetMaxX(self.tagLabel.frame) + 15, 0, 50, 50);
    self.rightName.text = self.model.rightName;
    [self.rightName sizeToFit];
    self.rightName.centerY = self.leftImage.centerY;

    self.rightImage.frame = CGRectMake(0, 0, 50, 50);
    [self.rightImage sd_setImageWithURL:[NSURL URLWithString:self.model.rightImage]];
    self.rightImage.centerY = self.leftImage.centerY;
    self.rightImage.x = self.contentView.width - 15 - self.rightImage.width;
    
    self.rightName.x = self.rightImage.x - self.rightName.width - 15;
}

- (void)setModel:(SaiChengModel *)model
{
    
    _model = model;
    
}

@end
