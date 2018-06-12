//
//  SaiChengDetailController.h
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/24.
//

#import <UIKit/UIKit.h>
@class SaiChengModel;

@interface SaiChengDetailController : UIViewController

@property (nonatomic, strong) SaiChengModel *model;

@property (nonatomic, assign) BOOL isYiBaoMing;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *index;

@end
