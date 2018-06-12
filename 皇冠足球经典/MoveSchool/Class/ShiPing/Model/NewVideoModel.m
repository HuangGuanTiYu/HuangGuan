//
//  NewVideoModel.m
//  MoveSchool
//
//  Created by 顾海波 on 2018/6/11.
//

#import "NewVideoModel.h"

@implementation NewVideoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.descriptionDe = value;
    }
}

@end
