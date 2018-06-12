//
//  TuPianModelTool.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/6/12.
//

#import "TuPianModelTool.h"
#import "TuPianModel.h"

#define FilePathWithName(fileName) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName]

#define recommendFilePath FilePathWithName(@"TuPianModelFileName")

@implementation TuPianModelTool

/**
 *  保存音频信息
 */
+ (void) saving : (TuPianModel *) videoModel
{
    
    NSMutableArray *array = [TuPianModelTool videoModels];
    if (array == nil) {
        array = [NSMutableArray array];
    }
    [array insertObject:videoModel atIndex:0];
    [NSKeyedArchiver archiveRootObject:array toFile:recommendFilePath];
}

/**
 *  取出音频信息
 */
+ (NSMutableArray *)videoModels
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:recommendFilePath];
}

/**
 * 删除所有音频
 */
+ (void) removeVideoModel : (TuPianModel *) model
{
    NSMutableArray *array = [TuPianModelTool videoModels];
    if (array.count > 0) {
        
        BOOL hasItem = NO;
        TuPianModel *newItem = nil;
        
        for (TuPianModel *m in array) {
            if ([m.title isEqualToString:model.title]) {
                hasItem = YES;
                newItem = m;
            }
        }
        
        if (hasItem) {
            
            [array removeObject:newItem];
            
            [self saveDWDownloadItems:array];
        }
    }
    
}

/**
 *  批量保存下载信息
 */
+ (void) saveDWDownloadItems : (NSMutableArray *) items
{
    [NSKeyedArchiver archiveRootObject:items toFile:recommendFilePath];
}

+ (void) updateVideoModel : (TuPianModel *) newModel
{
    NSMutableArray *array = [TuPianModelTool videoModels];
    if (array.count > 0) {
        
        BOOL hasItem = NO;
        TuPianModel *newItem = nil;
        TuPianModel *oldItem = nil;
        
        for (TuPianModel *model in array) {
            if ([model.title isEqualToString:newModel.title]) {
                hasItem = YES;
                newItem = newModel;
                oldItem = model;
            }
        }
        
        if (hasItem) {
            
            [array replaceObjectAtIndex:[array indexOfObject:oldItem] withObject:newItem];
            
            [self saveDWDownloadItems:array];
        }
    }
    
}

@end
