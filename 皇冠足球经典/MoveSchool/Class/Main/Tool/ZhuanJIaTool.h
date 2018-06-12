//
//  ZhuanJIaTool.h
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/24.
//

#import <Foundation/Foundation.h>
@class ZhuanJiaModel;

@interface ZhuanJIaTool : NSObject

/**
 *  保存音频信息
 */
+ (void) saving : (ZhuanJiaModel *) videoModel;

/**
 *  取出音频信息
 */
+ (NSMutableArray *)videoModels;

/**
 * 删除所有音频
 */
+ (void) removeVideoModel : (ZhuanJiaModel *) model;

+ (void) saveDWDownloadItems : (NSMutableArray *) items;

@end
