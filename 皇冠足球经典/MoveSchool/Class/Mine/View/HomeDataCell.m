//
//  HomeDataCell.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/6/2.
//

#import "HomeDataCell.h"
#import "TBCityIconFont.h"
#import "ZhuanJiaModel.h"
#import "UIImageView+WebCache.h"

@interface HomeDataCell()

@property (nonatomic, strong) UIImageView *iconView;

//标题
@property(nonatomic, strong) UILabel *titleLabel;

//缓存大小
@property(nonatomic, strong) UILabel *cacheLabel;

//分割线
@property(nonatomic, strong) UIView *divisionView;


//箭头
@property(nonatomic, strong) UIImageView *nextImage;

@end

@implementation HomeDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:ys_28];
        self.titleLabel.textColor = MainTextColor;
        [self.contentView addSubview:self.titleLabel];
        
        self.nextImage = [[UIImageView alloc] init];
        self.nextImage.contentMode = UIViewContentModeCenter;
        self.nextImage.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e614", ys_28, AuxiliaryColor)];
        [self.contentView addSubview:self.nextImage];
        
        self.divisionView = [[UIView alloc] init];
        self.divisionView.backgroundColor = SepaViewColor;
        [self.contentView addSubview:self.divisionView];
        
        self.cacheLabel = [[UILabel alloc] init];
        self.cacheLabel.font = [UIFont systemFontOfSize:ys_28];
        self.cacheLabel.textColor = AuxiliaryColor;
        self.cacheLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.cacheLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.frame = CGRectMake(15, 0, 50, 50);
    self.iconView.centerY = self.contentView.height * 0.5;
    self.iconView.layer.cornerRadius = self.iconView.height * 0.5;
    self.iconView.layer.masksToBounds = YES;
    
    self.nextImage.frame = CGRectMake(self.width - 13 - 15, 0, 13, 13);
    self.nextImage.centerY = self.height * 0.5;
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + 10, 0, self.width -  10 * 2, self.height);
    self.cacheLabel.frame = CGRectMake(self.width * 0.5, 0, 0, self.height);
    
    self.cacheLabel.width = self.nextImage.x - self.width * 0.5 - 10;
    
    self.divisionView.frame = CGRectMake(15, self.contentView.height - 0.5, self.contentView.width, 0.5);
    
}

- (void)setModel:(ZhuanJiaModel *)model
{
    
    _model = model;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.titleLabel.text = model.name;
    self.cacheLabel.text = model.zong;
}



@end
