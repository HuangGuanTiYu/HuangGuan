//
//  SaiChengListController.h
//  MoveSchool
//
//  Created by 顾海波 on 2018/5/24.
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"
#import "XLPhotoBrowser.h"

@interface SaiChengListController : UIViewController<XLPagerTabStripChildItem,XLPhotoBrowserDelegate, XLPhotoBrowserDatasource>

@property(nonatomic, copy) NSString *studyTitle;

@property (nonatomic, assign) BOOL isYiBaoMing;

- (void) change : (NSString *) timer;

@end
