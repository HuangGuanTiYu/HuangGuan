//
//  ZhuanJiaModel.h
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/22.
//

#import <Foundation/Foundation.h>

@interface ZhuanJiaModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *zong;

@property (nonatomic, copy) NSString *jinqi;

@property (nonatomic, copy) NSString *guanzhuCount;

@property (nonatomic, copy) NSString *des;

@end
