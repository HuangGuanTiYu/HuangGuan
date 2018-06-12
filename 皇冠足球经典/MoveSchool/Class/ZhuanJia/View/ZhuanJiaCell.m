//
//  FindCell.m
//  NewSchoolBus
//
//  Created by edz on 2017/8/18.
//  Copyright © 2017年 edz. All rights reserved.
//

#import "ZhuanJiaCell.h"
#import "UIImageView+WebCache.h"
#import "ZhuanJiaModel.h"

@interface ZhuanJiaCell()

@property (nonatomic, strong) UIImageView *bjImage;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *desLabel;

@end

@implementation ZhuanJiaCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
        self.bjImage = [[UIImageView alloc] init];
        self.bjImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.bjImage];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.nameLabel];
        
        self.desLabel = [[UILabel alloc] init];
        self.desLabel.textAlignment = NSTextAlignmentCenter;
        self.desLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.desLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bjImage.frame = CGRectMake(0, 10, self.width - 20, self.width - 20);
    self.bjImage.layer.cornerRadius = self.bjImage.width * 0.5;
    self.bjImage.layer.masksToBounds = YES;
    self.bjImage.centerX = self.width * 0.5;
    
    self.nameLabel.frame = CGRectMake(15, CGRectGetMaxY(self.bjImage.frame) + 10, 0, 0);
    self.nameLabel.text = self.model.name;
    [self.nameLabel sizeToFit];
    self.nameLabel.centerX = self.width * 0.5;
    
    self.desLabel.frame = CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame) + 10, 0, 0);
    self.desLabel.text = self.model.zong;
    [self.desLabel sizeToFit];
    self.desLabel.centerX = self.width * 0.5;

}

- (void)setModel:(ZhuanJiaModel *)model
{
    
    _model = model;
    
    [self.bjImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    
}

@end
