//
//  ShareButton.m
//  MoveSchool
//
//  Created by edz on 2017/9/1.
//
//

#import "ShareButton.h"

@implementation ShareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        [self setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, self.height - 45, self.width, 30);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, self.width, self.height - 20);
}

@end
