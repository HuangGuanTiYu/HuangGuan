//
//  TuPianModelTool.h
//  MoveSchool
//
//  Created by 顾海波 on 2018/6/12.
//

#import <Foundation/Foundation.h>
@class TuPianModel;

@interface TuPianModelTool : NSObject


/**
 *  保存音频信息
 */
+ (void) saving : (TuPianModel *) videoModel;

/**
 *  取出音频信息
 */
+ (NSMutableArray *)videoModels;

/**
 * 删除所有音频
 */
+ (void) removeVideoModel : (TuPianModel *) model;

+ (void) saveDWDownloadItems : (NSMutableArray *) items;

@end
