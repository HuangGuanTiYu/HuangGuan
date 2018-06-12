//
//  TuPianCell.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/6/12.
//

#import "TuPianCell.h"
#import "TBCityIconFont.h"
#import "TuPianModel.h"
#import "UIImageView+WebCache.h"

@interface TuPianCell()

//头像
@property (nonatomic, strong) UIImageView *headerImage;

//名字 + 时间
@property (nonatomic, strong) UILabel *nameTimeLabel;

//内容
@property (nonatomic, strong) UILabel *contentLabel;

//时间
@property (nonatomic, strong) UIImageView *nextImage;

//分割线
@property (nonatomic, strong) UIView *sepaView;


@end

@implementation TuPianCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.headerImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.headerImage];
        
        self.nameTimeLabel = [[UILabel alloc] init];
        self.nameTimeLabel.textColor = MainTextColor;
        self.nameTimeLabel.font = [UIFont systemFontOfSize:ys_28];
        [self.contentView addSubview:self.nameTimeLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont systemFontOfSize:12];
        self.contentLabel.textColor = AuxiliaryColor;
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        self.sepaView = [[UIView alloc] init];
        self.sepaView.backgroundColor = SepaViewColor;
        [self.contentView addSubview:self.sepaView];
        
        self.nextImage = [[UIImageView alloc] init];
        self.nextImage.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e614",15, AuxiliaryColor)];
        [self.contentView addSubview:self.nextImage];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headerImage.frame = CGRectMake(15, 0, 90, 60);
    self.headerImage.centerY = self.height * 0.5;
    
    self.nameTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.headerImage.frame) + mainSpacing, self.headerImage.y + mainSpacing, 0, 0);
    self.nameTimeLabel.text = self.model.title;
    [self.nameTimeLabel sizeToFit];
    
    self.contentLabel.frame = CGRectMake(self.nameTimeLabel.x, CGRectGetMaxY(self.nameTimeLabel.frame) + mainSpacing, 0, 100);
    self.contentLabel.text = self.model.subTitle;
    [self.contentLabel sizeToFit];
    
    self.sepaView.frame = CGRectMake(15, self.contentView.height - 0.5, self.contentView.width - 15, 0.5);
    
    self.nextImage.frame = CGRectMake(self.contentView.width - 20 - 15, 0, 20, 20);
    self.nextImage.centerY = self.contentView.height * 0.5;
}

- (void)setModel:(TuPianModel *)model
{
    
    _model = model;
    
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];
}


@end
