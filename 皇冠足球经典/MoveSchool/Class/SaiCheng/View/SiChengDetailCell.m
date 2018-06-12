//
//  SiChengDetailCell.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/24.
//

#import "SiChengDetailCell.h"
#import "SaiChengOuPei.h"
#import "SaiChengYaPan.h"
#import "SaiChengZhanJi.h"

@interface SiChengDetailCell()

@property (nonatomic, strong) UILabel *oneLabel;

@property (nonatomic, strong) UILabel *twoLabel;

@property (nonatomic, strong) UILabel *threeLabel;

@property (nonatomic, strong) UILabel *fourLabel;

@property (nonatomic, strong) UILabel *fiveLabel;

@end

@implementation SiChengDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.oneLabel = [[UILabel alloc] init];
        self.oneLabel.textColor = RGBCOLOR_HEX(0x999999);
        self.oneLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.oneLabel];
        
        self.twoLabel = [[UILabel alloc] init];
        self.twoLabel.textColor = RGBCOLOR_HEX(0x999999);
        self.twoLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.twoLabel];
        
        self.threeLabel = [[UILabel alloc] init];
        self.threeLabel.textColor = RGBCOLOR_HEX(0x999999);
        self.threeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.threeLabel];
        
        self.fourLabel = [[UILabel alloc] init];
        self.fourLabel.textColor = RGBCOLOR_HEX(0x999999);
        self.fourLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.fourLabel];
        
        self.fiveLabel = [[UILabel alloc] init];
        self.fiveLabel.textColor = RGBCOLOR_HEX(0x999999);
        self.fiveLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.fiveLabel];
        
        self.oneLabel.textAlignment = self.twoLabel.textAlignment = self.threeLabel.textAlignment = self.fourLabel.textAlignment = self.fiveLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}


- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    self.oneLabel.frame = CGRectMake(0, 0, self.contentView.width / 5, self.contentView.height);
    self.oneLabel.text = self.model.name;
    if (self.type == 1) {
        self.oneLabel.text = self.yapanModel.laiyuan;
    }else if (self.type == 2) {
        self.oneLabel.text = self.zhanJiModel.time;
    }
    
    self.twoLabel.frame = CGRectMake(self.contentView.width / 5, 0, self.contentView.width / 5, self.contentView.height);
    if (self.type == 2) {
        self.twoLabel.text = self.zhanJiModel.type;
    }else
    {
        self.twoLabel.text = @"";
    }

    self.threeLabel.frame = CGRectMake(self.contentView.width / 5 * 2, 0, self.contentView.width / 5, self.contentView.height);
    self.threeLabel.text = self.model.sheng;
    if (self.type == 1) {
        self.threeLabel.text = self.yapanModel.shuiwei1;
    }else if (self.type == 2) {
        self.threeLabel.text = self.zhanJiModel.leftName;
    }

    self.fourLabel.frame = CGRectMake(self.contentView.width / 5 * 3, 0, self.contentView.width / 5, self.contentView.height);
    self.fourLabel.text = self.model.ping;
    if (self.type == 1) {
        self.fourLabel.text = self.yapanModel.pankou;
    }else if (self.type == 2) {
        self.fourLabel.text = self.zhanJiModel.bifen;
    }

    self.fiveLabel.frame = CGRectMake(self.contentView.width / 5 * 4, 0, self.contentView.width / 5, self.contentView.height);
    self.fiveLabel.text = self.model.fu;
    if (self.type == 1) {
        self.fiveLabel.text = self.yapanModel.shuiwei2;
    }else if (self.type == 2) {
        self.fiveLabel.text = self.zhanJiModel.rightName;
    }
}

- (void)setModel:(SaiChengOuPei *)model
{
    
    _model = model;
    
}

- (void)setYapanModel:(SaiChengYaPan *)yapanModel
{
    
    _yapanModel = yapanModel;
}

- (void)setZhanJiModel:(SaiChengZhanJi *)zhanJiModel
{
    
    _zhanJiModel = zhanJiModel;
    
}

@end
