//
//  CommentModel.h
//  MoveSchool
//
//  Created by edz on 2017/8/31.
//
//

#import <Foundation/Foundation.h>
@class PraiseModel;

@interface CommentModel : NSObject

@property (nonatomic, copy) NSString *ID;//评论id

@property (nonatomic, copy) NSString *businessid;//业务id

@property (nonatomic, copy) NSString *businesscode; //业务码

@property (nonatomic, copy) NSString *commentcount;

@property (nonatomic, copy) NSString *userid; //评论人id

@property (nonatomic, copy) NSString *companyid; //公司id

@property (nonatomic, copy) NSString *content; //评论内容

@property (nonatomic, assign) int toid; //回复的上级id

@property (nonatomic, assign) int touserid; //回复的上级用户id

@property (nonatomic, copy) NSString *indate; //评论时间

@property (nonatomic, copy) NSString *headpic; //当前userid用户头像

@property (nonatomic, copy) NSString *nickname; //当前userid昵称

@property (nonatomic, copy) NSString *tonickname; //被回复人昵称

@property (nonatomic, copy) NSString *tocontent; //评论上一及的内容

@property (nonatomic, copy) NSString *isself; //0不是自己1是自己

@property (nonatomic, strong) PraiseModel *praise;

//评论内容高度
@property (nonatomic, assign) CGFloat contentHeight;

@end
