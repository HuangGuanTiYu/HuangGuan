//
//  CommentCell.m
//  MoveSchool
//
//  Created by edz on 2017/8/31.
//
//

#import "NewCommentCell.h"
#import "UIImageView+WebCache.h"
#import "NewCommentModel.h"

@interface NewCommentCell()

//头像
@property (nonatomic, strong) UIImageView *headerImage;

//名字 + 时间
@property (nonatomic, strong) UILabel *nameTimeLabel;

//内容
@property (nonatomic, strong) UILabel *contentLabel;

//时间
@property (nonatomic, strong) UILabel *timeLabel;


@end

@implementation NewCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.headerImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.headerImage];
        
        self.nameTimeLabel = [[UILabel alloc] init];
        self.nameTimeLabel.textColor = AuxiliaryColor;
        self.nameTimeLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.nameTimeLabel.text = @"用户昵称 2小时前";
        [self.contentView addSubview:self.nameTimeLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont systemFontOfSize:ys_28];
        self.contentLabel.textColor = MainTextColor;
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        self.sepaView = [[UIView alloc] init];
        self.sepaView.backgroundColor = SepaViewColor;
        [self.contentView addSubview:self.sepaView];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = [UIFont systemFontOfSize:ys_28];
        self.timeLabel.textColor = AuxiliaryColor;
        [self.contentView addSubview:self.timeLabel];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headerImage.frame = CGRectMake(15, 15, 50, 50);
    self.headerImage.layer.cornerRadius = 35 * 0.5;
    self.headerImage.layer.masksToBounds = YES;
    
    self.nameTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.headerImage.frame) + mainSpacing, 15, 0, 0);
    self.nameTimeLabel.text = self.model.name;
    [self.nameTimeLabel sizeToFit];
        
    self.contentLabel.frame = CGRectMake(self.nameTimeLabel.x, CGRectGetMaxY(self.nameTimeLabel.frame) + mainSpacing, 0, 100);
    self.contentLabel.text = self.model.content;
    [self.contentLabel sizeToFit];
    
    self.timeLabel.frame = CGRectMake(0, 0, 0, 0);
    self.timeLabel.text = self.model.time;
    [self.timeLabel sizeToFit];
    self.timeLabel.centerY = self.height * 0.5;
    self.timeLabel.x = self.width - self.timeLabel.width - 15;
    
    self.sepaView.frame = CGRectMake(15, self.contentView.height - 0.5, self.contentView.width - 15, 0.5);
    
}

- (void)setModel:(NewCommentModel *)model
{
    
    _model = model;
    
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:self.model.headerImage]];
}


@end
