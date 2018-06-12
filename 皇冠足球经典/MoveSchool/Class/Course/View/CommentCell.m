//
//  CommentCell.m
//  MoveSchool
//
//  Created by edz on 2017/8/31.
//
//

#import "CommentCell.h"
#import "TBCityIconFont.h"
#import "CommentModel.h"
#import "UIImageView+WebCache.h"
#import "PraiseModel.h"

@interface CommentCell()

//头像
@property (nonatomic, strong) UIImageView *headerImage;

//名字 + 时间
@property (nonatomic, strong) UILabel *nameTimeLabel;

//内容
@property (nonatomic, strong) UILabel *contentLabel;

//回复的内容
@property (nonatomic, strong) UILabel *toContentLabel;

//回复内容的分割线
@property (nonatomic, strong) UIView *toContentSepaView;

//删除按钮
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation CommentCell

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
        
        self.goodButton = [[UIButton alloc] init];
        [self.goodButton addTarget:self action:@selector(goodButtonClicks:) forControlEvents:UIControlEventTouchUpInside];
        self.goodButton.titleEdgeInsets = UIEdgeInsetsMake(0, mainSpacing, 0, 0);
        self.goodButton.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        [self.contentView addSubview:self.goodButton];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont systemFontOfSize:ys_28];
        self.contentLabel.textColor = MainTextColor;
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        self.sepaView = [[UIView alloc] init];
        self.sepaView.backgroundColor = SepaViewColor;
        [self.contentView addSubview:self.sepaView];
        
        self.toContentLabel = [[UILabel alloc] init];
        self.toContentLabel.font = [UIFont systemFontOfSize:ys_28];
        self.toContentLabel.textColor = AuxiliaryColor;
        [self.contentView addSubview:self.toContentLabel];
        
        self.toContentSepaView = [[UIView alloc] init];
        self.toContentSepaView.backgroundColor = SepaViewColor;
        [self.contentView addSubview:self.toContentSepaView];
        
        self.deleteButton = [[UIButton alloc] init];
        [self.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.deleteButton.backgroundColor = ViewBackColor;
        [self.deleteButton setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
        [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        self.deleteButton.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        [self.contentView addSubview:self.deleteButton];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headerImage.frame = CGRectMake(15, 15, 35, 35);
    self.headerImage.layer.cornerRadius = 35 * 0.5;
    self.headerImage.layer.masksToBounds = YES;
    
    self.goodButton.frame = CGRectMake(self.contentView.width - 50 - 15, 15, 50, 17);
    
    self.nameTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.headerImage.frame) + mainSpacing, 15, self.goodButton.x - CGRectGetMaxX(self.headerImage.frame) - 20, self.goodButton.height);
        
    self.contentLabel.frame = CGRectMake(self.nameTimeLabel.x, CGRectGetMaxY(self.nameTimeLabel.frame) + mainSpacing, self.contentView.width - 15 - CGRectGetMaxX(self.headerImage.frame) - mainSpacing, self.model.contentHeight);
    
    self.deleteButton.frame = CGRectMake(self.contentLabel.x, CGRectGetMaxY(self.contentLabel.frame) + mainSpacing, 50, 20);

    self.sepaView.frame = CGRectMake(15, self.contentView.height - 0.5, self.contentView.width - 15, 0.5);
    
    CGFloat toContentSepaViewY = CGRectGetMaxY(self.contentLabel.frame) + mainSpacing;
    if ([self.model.userid isEqualToString:[UserInfoTool getUserInfo].zttid]) { //自己评论的 有删除
        toContentSepaViewY = CGRectGetMaxY(self.deleteButton.frame) + mainSpacing;
    }
    
    self.toContentSepaView.frame = CGRectMake(self.contentLabel.x, toContentSepaViewY, self.contentView.width - 15, 0.5);

    self.toContentLabel.frame = CGRectMake(self.contentLabel.x, CGRectGetMaxY(self.toContentSepaView.frame) + mainSpacing, self.contentLabel.width, 30);
    
    
}

- (void)setModel:(CommentModel *)model
{
    _model = model;
    
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.headpic] placeholderImage:[UIImage imageNamed:@"zwt_pinlun_touxiang"]];
    self.contentLabel.text = model.content;
    
    NSMutableString *nameTime = [NSMutableString stringWithString:model.nickname];
    if (model.touserid > 0) {
        self.toContentLabel.hidden = NO;
        self.toContentSepaView.hidden = NO;
        [nameTime appendString:[NSString stringWithFormat:@"回复%@",model.tonickname]];
        
        NSString *allString = [NSString stringWithFormat:@"//%@%@",model.tonickname,model.tocontent];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:allString];
        [string addAttribute:NSForegroundColorAttributeName value:MainTextColor range:[allString rangeOfString:[NSString stringWithFormat:@"%@",model.tocontent]]];
        self.toContentLabel.attributedText = string;
    }else
    {
        self.toContentLabel.hidden = YES;
        self.toContentSepaView.hidden = YES;
    }
    
    if (model.indate.length > 0) {
        [nameTime appendString:[NSString stringWithFormat:@" %@",model.indate]];
    }
    
    if ([nameTime containsString:@"回复"]) {
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:nameTime];
        [attString addAttribute:NSForegroundColorAttributeName value:MainTextColor range:[nameTime rangeOfString:@"回复"]];
        self.nameTimeLabel.attributedText = attString;
    }else
    {
        self.nameTimeLabel.text = nameTime;
    }
    
    if ([model.praise.num isEqualToString:@"0"]) { //自己没点赞 并且没有点赞数量
        [self.goodButton setTitle:@"赞" forState:UIControlStateNormal];
    }else
    {
        [self.goodButton setTitle:model.praise.num forState:UIControlStateNormal];
    }
    
    if ([model.praise.isPraise isEqualToString:@"1"]) { //已点赞
        [self.goodButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62d", 15, MainColor)] forState:UIControlStateNormal];
        [self.goodButton setTitleColor:MainColor forState:UIControlStateNormal];
    }else
    {
        [self.goodButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62e", 15, AuxiliaryColor)] forState:UIControlStateNormal];
        [self.goodButton setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
    }
    
    if ([model.userid isEqualToString:[UserInfoTool getUserInfo].zttid]) {
        self.deleteButton.hidden = NO;
    }else
    {
        self.deleteButton.hidden = YES;
    }

}

#pragma mark 点赞
- (void) goodButtonClicks : (UIButton *) button
{
    
    if ([self.delegate respondsToSelector:@selector(goodButtonClick:)]) {
        [self.delegate goodButtonClick:self];
    }
}

#pragma mark 删除评论
- (void) deleteButtonClick
{
    if ([self.delegate respondsToSelector:@selector(deleteComment:)]) {
        [self.delegate deleteComment:self];
    }
}

@end
