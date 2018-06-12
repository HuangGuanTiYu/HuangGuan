//
//  MainPersonCellNoAddCell.m
//  zhitongti
//
//  Created by yuhongtao on 16/7/22.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "MainPersonCellNoAddCell.h"
#import "UIButton+WebCache.h"
#import "ColorTypeTools.h"
#import "AFNetworking.h"
#import "UIButton+WebCache.h"
#import "AppDelegate.h"

@implementation MainPersonCellNoAddCell


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //背景
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
        UIImage *img=[UIImage imageNamed:@"mine_setting_bg"];
        view.image=img;
        view.userInteractionEnabled = YES;
        self.view=view;
        [self addSubview:view];
        
        
        UIImageView *ve = [[UIImageView alloc] initWithFrame:CGRectMake(15, self.height - 17 - 52, 52, 52)];
        ve.backgroundColor=RGBACOLOR(0, 0, 0, 0.08);
        ve.layer.masksToBounds=YES;
        ve.layer.cornerRadius=ve.width/2;
        
        self.ve=ve;
        [self.view addSubview:ve];
        
        
        UIButton *icon = [[UIButton alloc]initWithFrame:CGRectMake(15,view.frame.size.height/3,65,65)];

        //设置为圆形
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = icon.frame.size.width/2;//    按钮宽的一半;变成圆形的

        icon.tag = 1;
        
        [icon sd_setBackgroundImageWithURL:[NSURL URLWithString:[UserInfoTool getUserInfo].headimgurl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"hot_user_default"]];
        [icon addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.icon = icon;
        [view addSubview:icon];
        
        //根据字体设置长度
        UIButton *nameL=[[UIButton  alloc]initWithFrame:CGRectMake(0,0,100,50)];
        nameL.frame = CGRectMake(CGRectGetMaxX(icon.frame)+30,view.frame.size.height/2-10, view.frame.size.width/4, view.frame.size.height/8);
        nameL.titleLabel.textColor=[UIColor whiteColor];
        nameL.titleLabel.textAlignment=NSTextAlignmentLeft;  //无效
        
        nameL.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        nameL.titleEdgeInsets = UIEdgeInsetsMake(0, -1, 0, 0);//两句左对齐
        //文本对齐方式

        [nameL setTitle:@"登录" forState:UIControlStateNormal];
        nameL.titleLabel.font =[UIFont systemFontOfSize:15];
        self.nameL=nameL;
        [nameL addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:nameL];
        //IDLabel
        
        UILabel *IDL=[[UILabel  alloc]initWithFrame:CGRectMake(nameL.frame.origin.x,nameL.frame.size.height+nameL.frame.origin.y+10,nameL.frame.size.width,nameL.frame.size.height)];
        
        IDL.textColor=[UIColor whiteColor];
        IDL.textAlignment=NSTextAlignmentLeft;
        
        IDL.text=@"";
        IDL.font =[UIFont systemFontOfSize:11];
        self.IDL=IDL;
        [view addSubview:IDL];
        
        
        
        UILabel *vip=[[UILabel  alloc]initWithFrame:CGRectMake(0,0,0,0)];
        //必须是这组值,这个frame是初设的，没关系，后面还会重新设置其size。
        [vip setNumberOfLines:0];  //必须是这组值
        UIFont *font1 =[UIFont systemFontOfSize:9];
        //计算字体的高度
        
        
        CGSize FontHeight=[@"LV1"  boundingRectWithSize:CGSizeMake(200, 3000) options:0 attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:9]} context:nil].size;
        
        CGFloat iconBottomY=icon.frame.size.height+icon.frame.origin.y;
        CGFloat iconBottomX=icon.frame.size.width/2+icon.frame.origin.x;
        vip.frame = CGRectMake(iconBottomX,iconBottomY-20,FontHeight.width,FontHeight.height);
        vip.textColor=kColorBlack;
        vip.textAlignment=NSTextAlignmentCenter;
        //文本对齐方式  235 205 52
        vip.backgroundColor=[UIColor colorWithRed:235/255.0f green:205/255.0f blue:52/255.0f alpha:1];
        vip.layer.masksToBounds = YES;
        vip.layer.cornerRadius=vip.frame.size.height/2;//
        vip.text=@"LV1";
        vip.font = font1;
        self.vip=vip;
        [view addSubview:vip];
         
        
    }
    return self;
}

-(void)addBtn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(addViewWithAddWith:)]) {
        [self.delegate addViewWithAddWith:btn];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //   view;//背景//   nameL;//名称 //   icon;//头像  //   vip;//vip等级    //   IDL;//Id
    
    self.view.frame=CGRectMake(0, 0, self.width, self.height);
    
    //加光晕效果
    UIImageView *view=[[UIImageView alloc]initWithFrame:CGRectMake(25, self.height-17-52, 52, 52)];
    view.backgroundColor=RGBACOLOR(0, 0, 0, 0.08);
    view.layer.masksToBounds=YES;
    view.layer.cornerRadius=view.width/2;
    self.ve.frame=CGRectMake(15, self.height-17-52, 52, 52);
    self.icon.frame=CGRectMake(17, self.height-20-57, 48, 48);
    self.icon.layer.cornerRadius= self.icon.frame.size.width/2;//按钮宽的一半;变成圆
    self.icon.centerY = view.centerY;
    
    self.nameL.frame = CGRectMake(CGRectGetMaxX(self.icon.frame)+20,self.icon.y+6, self.view.width - CGRectGetMaxX(self.icon.frame) - 30, self.view.height/8);
    
    
    CGSize FontHeight=[@"LV11"  boundingRectWithSize:CGSizeMake(200, 3000) options:0 attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:11]} context:nil].size;
    
    
    CGFloat iconBottomX=self.icon.width/2+self.icon.x;
    self.vip.frame = CGRectMake(iconBottomX+2,self.icon.maxY-FontHeight.height,FontHeight.width+2,FontHeight.height-2);
    
    self.IDL.frame=CGRectMake(self.nameL.x,self.nameL.height+self.nameL.y+3,self.nameL.width,self.nameL.height);
}

-(void)setModel:(FriendModel *)model{

    _model = model;
    if ([UserInfoTool isLogin]) {
        if (model.nickname==nil) {
            [self.nameL setTitle:@"" forState:UIControlStateNormal];
            
        }else{
            
            [self.nameL  setTitle:model.nickname forState:UIControlStateNormal];
            
        }
        [self.icon  sd_setBackgroundImageWithURL:[NSURL URLWithString:model.headimgurl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"hot_user_default"]];
        self.vip.text=[NSString stringWithFormat:@"LV%@",model.lv];
        
        if (model.username==nil) {
            self.IDL.text=@"";
        }else{
            self.IDL.text=model.username;
        }
    }else{
        [self gotoLoginPage];
    }
}

-(void)gotoLoginPage
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate alertViewLogin];
}

@end
