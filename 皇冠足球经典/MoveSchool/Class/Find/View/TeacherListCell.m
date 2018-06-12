//
//  TeacherListCell.m
//  MoveSchool
//
//  Created by edz on 2017/8/23.
//
//

#import "TeacherListCell.h"
#import "UIImageView+WebCache.h"
#import "TeacherListModel.h"

@interface TeacherListCell()

//头像
@property (nonatomic, strong) UIImageView *headerImage;

//右侧View
@property (nonatomic, strong) UIView *rigthView;

//名字+描述
@property (nonatomic, strong) UILabel *nameLabel;

//粉丝数
@property (nonatomic, strong) UILabel *fansCountLabel;

//取消关注
@property (nonatomic, strong) UIButton *cancleFollowButton;

//标签工具条
@property (nonatomic, strong) UIView *tagView;

//资讯标签
@property (nonatomic, strong) UILabel *newsLabel;

//课程标签
@property (nonatomic, strong) UILabel *courseLable;

//直播标签
@property (nonatomic, strong) UILabel *liveLable;

@end

@implementation TeacherListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
        self.headerImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.headerImage];
        
        self.rigthView = [[UIView alloc] init];
        [self.contentView addSubview:self.rigthView];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = MainTextColor;
        [self.rigthView addSubview:self.nameLabel];
        
        self.fansCountLabel = [[UILabel alloc] init];
        self.fansCountLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.fansCountLabel.textColor = AuxiliaryColor;
        [self.rigthView addSubview:self.fansCountLabel];
        
        self.cancleFollowButton = [[UIButton alloc] init];
        [self.cancleFollowButton addTarget:self action:@selector(cancleFollowButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.cancleFollowButton setTitle:@"取消关注" forState:UIControlStateNormal];
        [self.cancleFollowButton setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
        self.cancleFollowButton.titleLabel.font = [UIFont systemFontOfSize:ys_22];
        self.cancleFollowButton.layer.borderColor = AuxiliaryColor.CGColor;
        self.cancleFollowButton.layer.borderWidth = 0.5;
        self.cancleFollowButton.layer.cornerRadius = fillet;
        self.cancleFollowButton.layer.masksToBounds = YES;
        [self.rigthView addSubview:self.cancleFollowButton];

        self.tagView = [[UIView alloc] init];
        [self.rigthView addSubview:self.tagView];
        
        self.newsLabel = [[UILabel alloc] init];
        self.newsLabel.backgroundColor = RGBCOLOR(255,153,96);
        self.newsLabel.hidden = YES;
        [self.tagView addSubview:self.newsLabel];
        
        self.courseLable = [[UILabel alloc] init];
        self.courseLable.backgroundColor = RGBCOLOR(215, 177, 118);
        self.courseLable.hidden = YES;
        [self.tagView addSubview:self.courseLable];
        
        self.liveLable = [[UILabel alloc] init];
        self.liveLable.backgroundColor = RGBColor(219,157,149);
        self.liveLable.hidden = YES;
        [self.tagView addSubview:self.liveLable];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headerImage.frame = CGRectMake(15, 15, 47, 47);
    self.headerImage.layer.cornerRadius = self.headerImage.width * 0.5;
    self.headerImage.layer.masksToBounds = YES;
    
    CGFloat rightViewX = CGRectGetMaxX(self.headerImage.frame) + 15;
    self.rigthView.frame = CGRectMake(rightViewX, self.headerImage.y, self.contentView.width - rightViewX - 15, self.contentView.height - self.headerImage.y);
    
    self.nameLabel.frame = CGRectMake(0, 0, 0, 30);
    [self.nameLabel sizeToFit];
    self.nameLabel.width = self.rigthView.width;
    
    self.fansCountLabel.frame = CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame) + mainSpacing, self.nameLabel.width, 20);
    [self.fansCountLabel sizeToFit];
    self.fansCountLabel.width = self.rigthView.width - 50;
    
    self.cancleFollowButton.frame = CGRectMake(self.rigthView.width - 50, 0, 50, 20);
    self.cancleFollowButton.centerY = self.fansCountLabel.centerY;
    
    self.tagView.frame = CGRectMake(0, CGRectGetMaxY(self.fansCountLabel.frame) - 2, self.nameLabel.width, self.rigthView.height - CGRectGetMaxY(self.fansCountLabel.frame));
    
    self.newsLabel.frame = CGRectMake(0, 0, 0, 0);
    
    self.courseLable.frame = CGRectMake(0, 0, 0, 0);
    
    self.liveLable.frame = CGRectMake(0, 0, 0, 0);
    
    self.newsLabel.font = self.courseLable.font = self.liveLable.font = [UIFont systemFontOfSize:ys_f20];
    
    self.newsLabel.textColor = self.courseLable.textColor = self.liveLable.textColor = [UIColor whiteColor];
    
    [self.newsLabel sizeToFit];
    [self.courseLable sizeToFit];
    [self.liveLable sizeToFit];
    
    self.newsLabel.width = self.courseLable.width = self.liveLable.width = 50;
    self.newsLabel.height = self.courseLable.height = self.liveLable.height = 17;
    self.newsLabel.centerY = self.courseLable.centerY = self.liveLable.centerY = self.tagView.height * 0.5;
    
    self.newsLabel.textAlignment = self.courseLable.textAlignment = self.liveLable.textAlignment = NSTextAlignmentCenter;

    self.newsLabel.layer.cornerRadius = self.courseLable.layer.cornerRadius = self.liveLable.layer.cornerRadius = fillet;
    
    self.newsLabel.layer.masksToBounds = self.courseLable.layer.masksToBounds = self.liveLable.layer.masksToBounds = YES;
    
    self.courseLable.x = self.model.newsCount > 0 ? CGRectGetMaxX(self.newsLabel.frame) + mainSpacing : 0;
    
    self.liveLable.x = self.model.courseCount > 0 ? CGRectGetMaxX(self.courseLable.frame) + mainSpacing : 0;

    
}

- (void)setModel:(TeacherListModel *)model
{
    _model = model;
    
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.teacherpic] placeholderImage:[UIImage imageNamed:@"zwt_jiangshi_touxiang"]];
    
    NSString *name = self.model.nickname;
    
    if (self.model.applyjob.length > 0) {
        name = [NSString stringWithFormat:@"%@ | %@",self.model.nickname,self.model.applyjob];
    }
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:name];
    [string addAttribute:NSForegroundColorAttributeName value:MainColor range:[name rangeOfString:self.model.nickname]];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ys_f30] range:NSMakeRange(0, name.length)];
    self.nameLabel.attributedText = string;
    
    self.fansCountLabel.text = [NSString stringWithFormat:@"粉丝数：%d",model.friendsCount];
    
    if (model.newsCount > 0) {
        self.newsLabel.hidden = NO;
        self.newsLabel.text = [NSString stringWithFormat:@"资讯%d",model.newsCount];
        self.newsLabel.width = 50;
    }else
    {
        self.newsLabel.hidden = YES;
        self.newsLabel.text = @"";
        self.newsLabel.width = 0;
    }
    
    if (model.courseCount > 0) {
        self.courseLable.hidden = NO;
        self.courseLable.text = [NSString stringWithFormat:@"课程%d",model.courseCount];
    }else
    {
        self.courseLable.hidden = YES;
        self.courseLable.text = @"";
    }
    
    if (model.liveCount > 0) {
        self.liveLable.hidden = NO;
        self.liveLable.text = [NSString stringWithFormat:@"直播%d",model.liveCount];
    }else
    {
        self.liveLable.hidden = YES;
        self.liveLable.text = @"";
    }
    
}

- (void)setIsFromMyFollow:(BOOL)isFromMyFollow
{
    _isFromMyFollow = isFromMyFollow;
    
    self.cancleFollowButton.hidden = !isFromMyFollow;
}

- (void) cancleFollowButtonClick
{
    if ([self.delegate respondsToSelector:@selector(cancleFollow:)]) {
        [self.delegate cancleFollow:self];
    }
}

@end
