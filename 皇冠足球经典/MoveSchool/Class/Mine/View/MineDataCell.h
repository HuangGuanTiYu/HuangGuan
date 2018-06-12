//
//  MineDataCell.h
//  MoveSchool
//
//  Created by edz on 2017/9/18.
//
//

#import <UIKit/UIKit.h>

@interface MineDataCell : UITableViewCell

//标题
@property (nonatomic, copy) NSString *title;

//副标题
@property (nonatomic, copy) NSString *subTitle;

//头像
@property (nonatomic, strong) UIImageView *headerImage;

//分割线
@property(nonatomic, strong) UIView *divisionView;

@end
