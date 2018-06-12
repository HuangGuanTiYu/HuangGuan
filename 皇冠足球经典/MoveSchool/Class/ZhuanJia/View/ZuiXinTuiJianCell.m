//
//  ZuiXinTuiJianCell.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/23.
//

#import "ZuiXinTuiJianCell.h"

@interface ZuiXinTuiJianCell()

@property (nonatomic, strong) UIView *noCommentView;

@property (nonatomic, strong) UIView *imageTexgView;

@property (nonatomic, strong) UIImageView *noImage;

@property (nonatomic, strong) UILabel *toTestLabel;

@end

@implementation ZuiXinTuiJianCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //没有评论
        UIView *noCommentView = [[UIView alloc] init];
        noCommentView.backgroundColor = RGBCOLOR_HEX(0xf5f5f5);
        self.noCommentView = noCommentView;
        [self.contentView addSubview:noCommentView];
        
        //图片 + 文字
        UIView *imageTexgView = [[UIView alloc] init];
        self.imageTexgView = imageTexgView;
        [noCommentView addSubview:imageTexgView];
        
        //背景图
        UIImageView *noImage = [[UIImageView alloc] init];
        self.noImage = noImage;
        noImage.image = [UIImage imageNamed:@"kong"];
        [imageTexgView addSubview:noImage];
        
        UILabel *toTestLabel = [[UILabel alloc] init];
        self.toTestLabel = toTestLabel;
        toTestLabel.textAlignment = NSTextAlignmentCenter;
        toTestLabel.text = @"暂无最新推荐，可查看历史推荐";
        toTestLabel.textColor = AuxiliaryColor;
        toTestLabel.font = [UIFont systemFontOfSize:ys_f24];
        [imageTexgView addSubview:toTestLabel];
        
    }
    return self;
}


- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    self.noCommentView.frame = CGRectMake(0, 0, YLScreenW, self.contentView.height);
    self.imageTexgView.frame = CGRectMake(0, 0, self.noCommentView.width, 129);
    self.imageTexgView.centerY = self.noCommentView.height * 0.5 - 20;
    
    self.noImage.frame = CGRectMake(0, 0, 121, 90);
    self.noImage.centerX = self.noCommentView.width * 0.5;
    self.toTestLabel.frame = CGRectMake(0, CGRectGetMaxY(self.noImage.frame) + 5, self.noCommentView.width, 20);

}

@end
