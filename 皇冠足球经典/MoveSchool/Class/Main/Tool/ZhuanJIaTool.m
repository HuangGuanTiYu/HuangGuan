//
//  ZhuanJIaTool.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/24.
//

#import "ZhuanJIaTool.h"
#import "ZhuanJiaModel.h"

#define FilePathWithName(fileName) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName]

#define recommendFilePath FilePathWithName(@"ZhuanJiaInfoFileName")

@implementation ZhuanJIaTool

/**
 *  保存音频信息
 */
+ (void) saving : (ZhuanJiaModel *) videoModel
{
    
    NSMutableArray *array = [ZhuanJIaTool videoModels];
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
+ (void) removeVideoModel : (ZhuanJiaModel *) model
{
    NSMutableArray *array = [ZhuanJIaTool videoModels];
    if (array.count > 0) {
        
        BOOL hasItem = NO;
        ZhuanJiaModel *newItem = nil;
        
        for (ZhuanJiaModel *m in array) {
            if ([m.ID isEqualToString:model.ID]) {
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

+ (void) updateVideoModel : (ZhuanJiaModel *) newModel
{
    NSMutableArray *array = [ZhuanJIaTool videoModels];
    if (array.count > 0) {
        
        BOOL hasItem = NO;
        ZhuanJiaModel *newItem = nil;
        ZhuanJiaModel *oldItem = nil;
        
        for (ZhuanJiaModel *model in array) {
            if ([model.ID isEqualToString:newModel.ID]) {
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
