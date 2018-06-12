//
//  AboutMineView.m
//  MoveSchool
//
//  Created by edz on 2017/10/10.
//
//

#import "AboutMineView.h"
#import "NSString+Extension.h"

@interface AboutMineView()

//标题
@property (nonatomic, strong) UILabel *titleLabel;

//内容View
@property (nonatomic, strong) UIView *contentView;

@end

@implementation AboutMineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:ys_f30];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.contentView = [[UIView alloc] init];
        [self addSubview:self.contentView];
        
        self.contentView.layer.borderWidth = 1;
        self.contentView.layer.borderColor = SepaViewColor.CGColor;
        
        self.titleLabel.backgroundColor = MainColor;
        [self addSubview:self.titleLabel];

    }
    return self;
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
    
    CGFloat width = [NSString returnStringRect:title size:CGSizeMake(self.width, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_28]].width;
    self.titleLabel.frame = CGRectMake(0, 0, width + mainSpacing * 4, 25);
    self.titleLabel.centerY = 0;
    self.titleLabel.layer.cornerRadius = self.titleLabel.height * 0.5;
    self.titleLabel.layer.masksToBounds = YES;
    self.titleLabel.centerX = self.width * 0.5;
}

- (void)setContents:(NSArray *)contents
{
    _contents = contents;
    
    self.contentView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) - self.titleLabel.height * 0.5, self.width, 0);
    self.contentView.layer.cornerRadius = 2.5;
    self.contentView.layer.masksToBounds = YES;
    
    for (int i = 0; i < contents.count; i ++) {
        NSString *content = contents[i];
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, i * 30 + self.titleLabel.height, self.contentView.width - 30, 20)];
        contentLabel.numberOfLines = 0;
        contentLabel.text = content;
        contentLabel.textColor = MainTextColor;
        contentLabel.font = [UIFont systemFontOfSize:ys_28];
        [self.contentView addSubview:contentLabel];
        [contentLabel sizeToFit];
        contentLabel.centerX = self.contentView.width * 0.5;
        
        if (i == contents.count - 1) {
            self.contentView.height = CGRectGetMaxY(contentLabel.frame) + mainSpacing;
            
            self.height = self.contentView.height + mainSpacing;
        }
    }
    
}

@end
