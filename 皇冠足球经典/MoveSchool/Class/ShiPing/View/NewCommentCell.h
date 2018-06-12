//
//  CommentCell.h
//  MoveSchool
//
//  Created by edz on 2017/8/31.
//
//

#import <UIKit/UIKit.h>
@class NewCommentModel;

@interface NewCommentCell : UITableViewCell

//分割线
@property (nonatomic, strong) UIView *sepaView;

@property (nonatomic, strong) NewCommentModel *model;

@end
