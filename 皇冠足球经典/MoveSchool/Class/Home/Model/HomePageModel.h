//
//  HomePageModel.h
//  NewSchoolBus
//
//  Created by edz on 2017/8/17.
//  Copyright © 2017年 edz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *businesscode; //业务码

@property (nonatomic, copy) NSString *businessid;

@property (nonatomic, copy) NSString *mainid;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *mainTitle;

@property (nonatomic, copy) NSString *indate;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *score; //分数

@property (nonatomic, copy) NSString *learnNum; //学习人数

@property (nonatomic, copy) NSString *discussNum; //评论数

@property (nonatomic, copy) NSString *showDuration; //课程时长

@property (nonatomic, copy) NSString *typeName; //业务分类名称

@property (nonatomic, copy) NSString *nickname; //昵称

@property (nonatomic, copy) NSString *living; //直播状态 1可以直播2不能直播

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSDictionary *priceView;

@property (nonatomic, copy) NSString *jumpUrl;

@end
