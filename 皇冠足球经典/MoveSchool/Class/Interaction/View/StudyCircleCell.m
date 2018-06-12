//
//  StudyCircleCell.m
//  MoveSchool
//
//  Created by edz on 2017/5/6.
//
//

#import "StudyCircleCell.h"
#import "StudyCircleModel.h"
#import "StudyCircleFrame.h"
#import "UIImageView+WebCache.h"
#import "NSAttributedString+Extension.h"
#import "NSDataEx.h"
#import "NSDate+Extension.h"
#import "StudyAttachs.h"
#import "StudyReply.h"
#import "StudyReplyCell.h"
#import "AllTitleButton.h"
#import "UIColor+Hex.h"
#import "StudyPraises.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "TBCityIconFont.h"
#import "PraiseUsers.h"

//图片间距
#define imageSpacint 4

@interface StudyCircleCell()<UITableViewDelegate, UITableViewDataSource,StudyReplyCellDelegate>

//头像
@property(nonatomic, strong) UIImageView *headerView;

//名字
@property(nonatomic, strong) AllTitleButton *nameLabel;

//内容View
@property(nonatomic, strong) UIView *contentsView;

//文字内容
@property(nonatomic, strong) UILabel *contentLabel;

//图片 (1~9 张)
@property(nonatomic, strong) UIView *imagesView;

//分享出来的 标题
@property(nonatomic, strong) UILabel *titleLabel;

//全文
@property(nonatomic, strong) AllTitleButton *allButton;

//时间
@property(nonatomic, strong) UILabel *timeLabel;

//课程or沙龙 描述
@property(nonatomic, strong) UILabel *describeLabel;

@property(nonatomic, strong) UIButton *startButton;

//删除
@property(nonatomic, strong) UIButton *deleteButton;

//赞 列表
@property(nonatomic, strong) UILabel *praiseListView;

//图片imageView数组
@property(nonatomic, strong) NSMutableArray *imageViews;

//cell 分割线
@property(nonatomic, strong) UIView *cellSepaView;

//评论按钮
@property(nonatomic, strong) UIButton *commentButton;

//中间分割线
@property(nonatomic, strong) UIView *centerSpeaView;


@end

@implementation StudyCircleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.headerView = [[UIImageView alloc] init];
        self.headerView.userInteractionEnabled = YES;
        [self.headerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClick:)]];
        [self.contentView addSubview:self.headerView];
        
        self.nameLabel = [[AllTitleButton alloc] init];
        [self.nameLabel setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
        [self.nameLabel addTarget:self action:@selector(nameLabelClick) forControlEvents:UIControlEventTouchUpInside];
        self.nameLabel.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        [self.contentView addSubview:self.nameLabel];
        
        self.contentsView = [[UIView alloc] init];
        self.contentsView.clipsToBounds = YES;
        [self.contentView addSubview:self.contentsView];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont systemFontOfSize:ys_28];
        self.contentLabel.numberOfLines = 0;
        [self.contentsView addSubview:self.contentLabel];
        
        self.imagesView = [[UIView alloc] init];
        self.imagesView.hidden = YES;
        [self.contentView addSubview:self.imagesView];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        
        self.allButton = [[AllTitleButton alloc] init];
        [self.allButton addTarget:self action:@selector(pushDetail) forControlEvents:UIControlEventTouchUpInside];
        [self.allButton setTitle:@"全文" forState:UIControlStateNormal];
        [self.allButton setTitleColor:RGBCOLOR(92, 104, 128) forState:UIControlStateNormal];
        self.allButton.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.allButton.hidden = YES;
        [self.contentView addSubview:self.allButton];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.textColor = AuxiliaryColor;
        self.timeLabel.font = [UIFont systemFontOfSize:ys_f24];
        [self.contentView addSubview:self.timeLabel];
        
        self.describeLabel = [[UILabel alloc] init];
        self.describeLabel.textColor = kColorBlack;
        self.describeLabel.hidden = YES;
        self.describeLabel.font = [UIFont systemFontOfSize:ys_f24];
        [self.contentView addSubview:self.describeLabel];
        
        self.startButton = [[UIButton alloc] init];
        self.startButton.hidden = YES;
        [self.startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.startButton setImage:[UIImage imageNamed:@"course_player_btn"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.startButton];
        
        self.deleteButton = [[UIButton alloc] init];
        self.deleteButton.hidden = YES;
        [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteButton setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
        [self.deleteButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e61b", ys_f24, AuxiliaryColor)] forState:UIControlStateNormal];
        [self.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.deleteButton.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        [self.contentView addSubview:self.deleteButton];
        
        self.goodButton = [[UIButton alloc] init];
        [self.goodButton addTarget:self action:@selector(goodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.goodButton setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
        [self.goodButton setTitleColor:MainColor forState:UIControlStateSelected];
        [self.goodButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62e", ys_f24, AuxiliaryColor)] forState:UIControlStateNormal];
        [self.goodButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e62d", ys_f24, MainColor)] forState:UIControlStateSelected];
        self.goodButton.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.goodButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [self.contentView addSubview:self.goodButton];
        
        self.commentButton = [[UIButton alloc] init];
        [self.commentButton addTarget:self action:@selector(commentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.commentButton setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
        [self.commentButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e63c", ys_f24, AuxiliaryColor)] forState:UIControlStateNormal];
        self.commentButton.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.commentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [self.contentView addSubview:self.commentButton];
        
        self.cellSepaView = [[UIView alloc] init];
        self.cellSepaView.backgroundColor = ViewBackColor;
        [self.contentView addSubview:self.cellSepaView];
        
        self.praiseListView = [[UILabel alloc] init];
        self.praiseListView.numberOfLines = 0;
        self.praiseListView.font = [UIFont systemFontOfSize:ys_f24];
        self.praiseListView.hidden = YES;
        [self.contentView addSubview:self.praiseListView];
        
        self.commentTableView = [[UITableView alloc] init];
        self.commentTableView.backgroundColor = [UIColor clearColor];
        self.commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.commentTableView.hidden = YES;
        self.commentTableView.scrollEnabled = NO;
        self.commentTableView.delegate = self;
        self.commentTableView.dataSource = self;
        [self.contentView addSubview:self.commentTableView];
        
        self.imageViews = [NSMutableArray array];
        
        self.centerSpeaView = [[UIView alloc] init];
//        self.centerSpeaView.hidden = YES;
        self.centerSpeaView.backgroundColor = SepaViewColor;
        [self.contentView addSubview:self.centerSpeaView];
    }
    return self;
}

- (void)setStudyCircleFrame:(StudyCircleFrame *)studyCircleFrame
{
    _studyCircleFrame = studyCircleFrame;
    
    StudyCircleModel *model = studyCircleFrame.studyCircleModel;
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:model.headpic] placeholderImage:[UIImage imageNamed:@"mineNormal"]];
    self.headerView.frame = studyCircleFrame.headerFrame;
    self.headerView.layer.cornerRadius = studyCircleFrame.headerFrame.size.width * 0.5;
    self.headerView.layer.masksToBounds = YES;
    
    [self.nameLabel setTitle:model.nickname forState:UIControlStateNormal];
    self.nameLabel.frame = studyCircleFrame.nameFrame;
    [self.nameLabel.titleLabel sizeToFit];
    self.nameLabel.centerY = self.headerView.centerY;
    
    if (model.content.length > 0) {
        self.contentLabel.hidden = NO;
        // 调整行间距
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.content];

        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:LineSpacing];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.content length])];

        self.contentLabel.attributedText = attributedString;

        self.contentsView.frame = studyCircleFrame.contentFrame;
        self.contentLabel.frame = self.contentsView.bounds;
        
        self.allButton.frame = studyCircleFrame.allFrame;

        if (studyCircleFrame.isMoreThanSix) {
            self.contentsView.clipsToBounds = YES;
            self.allButton.hidden = NO;
        }else
        {
            self.allButton.hidden = YES;
            self.contentsView.clipsToBounds = NO;
        }
    
        [self.contentLabel sizeToFit];
    }else
    {
        self.contentLabel.hidden = YES;
        self.allButton.hidden = YES;
    }
    
    self.timeLabel.text = model.indate;
    self.timeLabel.frame = studyCircleFrame.timeFrame;
    [self.timeLabel sizeToFit];
    self.timeLabel.centerY = self.headerView.centerY;

    self.deleteButton.hidden = model.isself == 0;
    self.deleteButton.frame = studyCircleFrame.deleteFrame;

    self.goodButton.frame = studyCircleFrame.goodFrame;
    self.commentButton.frame = studyCircleFrame.commentFrame;
    self.commentButton.centerY = self.goodButton.centerY;
    self.deleteButton.centerY = self.goodButton.centerY;
    
    self.cellSepaView.frame = studyCircleFrame.cellSepaViewFrame;
    
    BOOL isPraise = NO;
    
    if ([model.praise.isPraise isEqualToString:@"1"]) {
        isPraise = YES;
    }else
    {
        isPraise = NO;
    }
    
    [self.goodButton setTitle:studyCircleFrame.studyCircleModel.praise.num forState:UIControlStateNormal];
    [self.commentButton setTitle:studyCircleFrame.studyCircleModel.commentcount forState:UIControlStateNormal];

    [self setGoodButtonStatus:isPraise];
    
    if (self.imageViews.count > 0) {
        [self.imageViews removeAllObjects];
    }
    
    if (self.imagesView.subviews.count > 0) {
        [self.imagesView removeAllSubviews];
    }
    
    //有图片
    if (model.attachs.count > 0) {
        //计算 图片宽高
        CGFloat imageWH = ((SCREEN_WIDTH - studyCircleFrame.nameFrame.origin.x * 1.5) - 2 * imageSpacint) / 3;
        
        self.imagesView.hidden = NO;
        //只有一张图片
        self.imagesView.frame = studyCircleFrame.imagesFrame;

        //行数
        int row = 3;
        if (model.attachs.count == 4) {
            row = 2;
        }
        
        for (int i = 0; i < model.attachs.count; i ++) {
            StudyAttachs *attach = model.attachs[i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:studyCircleFrame.oneImageFrame];
            imageView.tag = i;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)]];
            [imageView sd_setImageWithURL:[NSURL URLWithString:attach.url] placeholderImage:[UIImage imageNamed:@"circle_portrait153"]];
            [self.imageViews addObject:imageView];
            
            imageView.x = (i % row) * (imageWH + imageSpacint);
            imageView.y = (i / row) * (imageWH + imageSpacint);
            [self.imagesView addSubview:imageView];
        }
    }else
    {
        self.imagesView.hidden = YES;
    }
    
    if (model.attachs.count > 0) {
        StudyAttachs *attach = model.attachs.firstObject;
        if ([attach.attach_businesscode isEqualToString:courseType]) {
            self.describeLabel.text = attach.title;
            self.describeLabel.frame = studyCircleFrame.describeFrame;
            [self.describeLabel sizeToFit];
            self.describeLabel.hidden = NO;
            
            self.startButton.frame = CGRectMake(0, 0, 60, 60);
            self.startButton.centerX = self.imagesView.centerX;
            self.startButton.centerY = self.imagesView.centerY;
            
            self.startButton.hidden = NO;
        }else
        {
            self.startButton.hidden = YES;
            self.describeLabel.hidden = YES;
        }

    }else{
        self.startButton.hidden = YES;
        self.describeLabel.hidden = YES;
    }
    
    //赞列表
    if (model.praise.praiseUsers.count > 0) {
        self.praiseListView.frame = studyCircleFrame.praiseListFrame;
        self.praiseListView.hidden = NO;
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithAttributedString:studyCircleFrame.praiseAttribute];
        
        NSMutableString *praiseContent = [NSMutableString string];
        NSMutableArray *nameArray = [NSMutableArray array];
        for (PraiseUsers *praise in model.praise.praiseUsers) {
            [praiseContent appendString:[NSString stringWithFormat:@"%@  ",praise.nickname]];
            [nameArray addObject:praise.nickname];
        }
        
        if ([praiseContent containsString:@"  "]) {
            praiseContent = (NSMutableString *)[praiseContent substringToIndex:praiseContent.length - 1];
        }
        
        for (PraiseUsers *praise in model.praise.praiseUsers) {
            NSRange range = [praiseContent rangeOfString:praise.nickname];
            [attributeString addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(125, 125, 125) range:NSMakeRange(range.location + 1, range.length)];
            [attributeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:ys_f24] range:NSMakeRange(range.location + 1, range.length)];
        }

        self.praiseListView.attributedText = attributeString;
        [self.praiseListView yb_addAttributeTapActionWithStrings:nameArray tapClicked:^(NSString *string, NSRange range, NSInteger index) {
            for (PraiseUsers *praise in model.praise.praiseUsers) {
                if (praise.nickname != nil && praise.nickname.length > 0 && [praise.nickname isEqualToString:string]) {
                    if ([self.delegate respondsToSelector:@selector(nameClick:userId:)]) {
                        [self.delegate nameClick:self userId:praise.userid];
                    }
                }
            }
        }];
    }else
    {
        self.praiseListView.hidden = YES;
    }
    
    //评论
    if (model.comments.count > 0) {
        [self.commentTableView reloadData];
        self.commentTableView.hidden = NO;
        self.commentTableView.frame = studyCircleFrame.commentViewFrame;
        
        if (model.comments.count > 3) {
            UILabel *lookAll = [[UILabel alloc] initWithFrame:CGRectMake(5, mainSpacing, SCREEN_WIDTH, 20)];
            lookAll.text = @"查看全部评论";
            lookAll.userInteractionEnabled = YES;
            [lookAll addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushDetail)]];
            lookAll.textColor = MainColor;
            lookAll.font = [UIFont systemFontOfSize:ys_f24];
            self.commentTableView.tableFooterView = lookAll;
        }else
        {
            self.commentTableView.tableFooterView = [[UIView alloc] init];
        }
    }else
    {
        self.commentTableView.hidden = YES;
        self.commentTableView.tableFooterView = [[UIView alloc] init];
    }
    
    //点赞
    if (model.praise.praiseUsers.count > 0) {
        self.centerSpeaView.hidden = NO;
    }else
    {
        self.centerSpeaView.hidden = YES;
    }

    self.centerSpeaView.frame = studyCircleFrame.centerSepaViewFrame;
}

- (void) pushDetail
{
    if ([self.delegate respondsToSelector:@selector(pushDetailVc:)]) {
        [self.delegate pushDetailVc:self];
    }
}


- (void) allButtonClick : (AllTitleButton *) allButton
{
    if ([allButton.titleLabel.text isEqualToString:@"全文"]) {
        [self.allButton setTitle:@"收起" forState:UIControlStateNormal];
        self.contentsView.clipsToBounds = NO;

    }else
    {
        [self.allButton setTitle:@"全文" forState:UIControlStateNormal];
        self.contentsView.clipsToBounds = YES;
    }
    
    if ([self.delegate respondsToSelector:@selector(allButtonClick:cell:)]) {
        [self.delegate allButtonClick:allButton cell:self];
    }
}

-(NSDate *) getDateByString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    
    NSDate *date = [formatter dateFromString:dateString];
    
    return date;
}

#pragma mark 头像点击
- (void) headerClick : (UIGestureRecognizer *) recognizer
{
    if ([self.delegate respondsToSelector:@selector(nameLabelClick:)]) {
        [self.delegate nameLabelClick:self];
    }
}

#pragma mark 图片点击
- (void) imageViewClick : (UIGestureRecognizer *) recognizer
{
    UIImageView *view = (UIImageView *)recognizer.view;
    
    StudyCircleModel *model = self.studyCircleFrame.studyCircleModel;

    if (model.attachs.count > 0) {
        StudyAttachs *attach = model.attachs.firstObject;
        if ([attach.attach_businesscode isEqualToString:courseType]) {
            [self startButtonClick];
        }else
        {
            if ([self.delegate respondsToSelector:@selector(imageClick:index:currentImageView:)]) {
                [self.delegate imageClick:model.attachs.count index:view.tag currentImageView:self.imageViews];
            }
        }
        
    }else{
        if ([self.delegate respondsToSelector:@selector(imageClick:index:currentImageView:)]) {
            [self.delegate imageClick:model.attachs.count index:view.tag currentImageView:self.imageViews];
        }
    }
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.studyCircleFrame.studyCircleModel.comments.count > 3) {
        return 3;
    }
    return self.studyCircleFrame.studyCircleModel.comments.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"RouteQueryCell";
    // 根据标识去缓存池找cell
    StudyReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[StudyReplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.delegate = self;
    StudyReply *model = self.studyCircleFrame.studyCircleModel.comments[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSValue *value = self.studyCircleFrame.commentsF[indexPath.row];
    return [value CGRectValue].size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.delegate respondsToSelector:@selector(pushDetailVc:)]) {
        [self.delegate pushDetailVc:self];
    }
}

#pragma mark 评论按钮点击
- (void) commentButtonClick : (UIButton *) button
{
    
    if ([self.delegate respondsToSelector:@selector(pushDetailVc:)]) {
        [self.delegate pushDetailVc:self];
    }
}

#pragma mark 关闭评论弹框
- (void) closeReplyAlertView
{
    
}

#pragma mark 关闭评论弹框 带动画
- (void) closeReplyAlertViewWithAnimate
{

}

#pragma mark 删除按钮点击
- (void) deleteButtonClick
{
    if ([self.delegate respondsToSelector:@selector(deleteCircle:cid: studyCircleModel:)]) {
        [self.delegate deleteCircle:self cid:self.studyCircleFrame.studyCircleModel.ID studyCircleModel:self.studyCircleFrame.studyCircleModel];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([self.delegate respondsToSelector:@selector(closeKeyboard:)]) {
        [self.delegate closeKeyboard:self];
    }
    [self closeReplyAlertView];
}

#pragma mark 赞👍
- (void) goodButtonClick : (UIButton *) button
{
    if ([self.delegate respondsToSelector:@selector(praiseWithCid:cell:button:)]) {
        [self.delegate praiseWithCid:self.studyCircleFrame.studyCircleModel.ID cell:self button:button];
    }

}

#pragma mark 评论点击
- (void) replyButtonClick : (UIButton *) button
{
    if ([self.delegate respondsToSelector:@selector(replyButtonCic:studyCircleModel:)]) {
        [self.delegate replyButtonCic:self studyCircleModel:self.studyCircleFrame.studyCircleModel];
    }
}

#pragma mark 设置赞按钮状态
- (void) setGoodButtonStatus : (BOOL) isPraise
{
    
    self.goodButton.selected = isPraise;
}

#pragma mark 昵称点击
- (void) nameLabelClick
{
    if ([self.delegate respondsToSelector:@selector(nameLabelClick:)]) {
        [self.delegate nameLabelClick:self];
    }
}

- (void)nameClick:(NSInteger)userId
{
    if ([self.delegate respondsToSelector:@selector(nameClick:userId:)]) {
        [self.delegate nameClick:self userId:userId];
    }
}

#pragma mark 播放按钮点击
- (void) startButtonClick
{
    if ([self.delegate respondsToSelector:@selector(startButtonClick:courseID:)] && self.studyCircleFrame.studyCircleModel.attachs.count > 0) {

        StudyAttachs *attach = [self.studyCircleFrame.studyCircleModel.attachs firstObject];
        [self.delegate startButtonClick:attach.attach_businesscode courseID:attach.attach_businessid];
    }
}

@end
