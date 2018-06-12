//
//  SiChengDetailCell.h
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/24.
//

#import <UIKit/UIKit.h>
@class SaiChengOuPei, SaiChengYaPan, SaiChengZhanJi;

@interface SiChengDetailCell : UITableViewCell

@property (nonatomic, strong) SaiChengOuPei *model;

@property (nonatomic, strong) SaiChengYaPan *yapanModel;

@property (nonatomic, strong) SaiChengZhanJi *zhanJiModel;

@property (nonatomic, assign) int type;

@end
