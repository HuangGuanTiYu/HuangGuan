//
//  MineCell.h
//  MoveSchool
//
//  Created by edz on 2017/8/21.
//
//

#import <UIKit/UIKit.h>

@interface MineCell : UITableViewCell

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *iconText;

//分割线
@property (nonatomic, strong) UIView *sepaView;

//NEW图标
@property (nonatomic, strong) UILabel *newsLabel;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, assign) BOOL isMyGuanZhu;


@end
