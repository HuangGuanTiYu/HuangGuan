//
//  ShiPinListController.h
//  MoveSchool
//
//  Created by 顾海波 on 2018/6/11.
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"
#import "XLPhotoBrowser.h"
#import "BaseViewController.h"

typedef enum {
    /** 资讯列表 */
    ALL = 1,
    /** 课程 */
    GUOJI = 2,
    /** 直播 */
    YINGCHAO = 3,
    YIJIA = 4,
    XIJIA = 5,
    DEJIA = 6
} JumpType;

@interface ShiPinListController : BaseViewController<XLPagerTabStripChildItem,XLPhotoBrowserDelegate, XLPhotoBrowserDatasource>

@property(nonatomic, copy) NSString *studyTitle;

@property (nonatomic, assign) JumpType type;


@end
