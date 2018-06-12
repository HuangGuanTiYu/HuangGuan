//
//  ManyLanguageMag.m
//  zhitongti
//
//  Created by yuhongtao on 16/9/3.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "ManyLanguageDic.h"

static NSString * ID = @"manylanguage";
@implementation ManyLanguageMag

+(NSString *)getType{
    NSString *type = [[NSUserDefaults standardUserDefaults] objectForKey:ID];
    return @"0";
    
}
+(NSString *)getTypeWithWebDiscript{
    
    NSInteger type=[[self getType] integerValue];
    
    NSString *str;
    switch (type) {
        case 0:{
            str=@"zh_CN";
        }break;
        case 1:{
            str=@"en";
        }
            break;
        case 2:{
            str=@"ko_KR";
        }
            break;
        case 3:{
            str=@"ja";
        }
            break;
        case 4:{
            str=@"nl";
        }
            break;
            
        default:
            break;
    }
    
    return str;
    
}
+(NSString *)getIntroduceDicStr{   //介绍
    
    NSString *type=[self getType];
    NSDictionary *dic = [ManyLanguageDic sharedManager].introduceDic;
    NSString *str=dic[type];
    return str;
}
+(NSArray *)getTabbarString{   //tabbar
    NSString *type=[self getType];
    NSDictionary *dic = [ManyLanguageDic sharedManager].tabbarDic;
    NSArray *arr=dic[type];
    return arr;
}

+(NSString *)getHotTypeStrWith:(NSString *)chineseStr{ //首页热点str
    NSString *type = [self getType];
    NSDictionary *temp = [ManyLanguageDic sharedManager].hotTypeDic;
    NSDictionary *dic=temp[chineseStr];
    NSString *str= dic[type];
    return str;
}

+(NSString *)getMineMenuStrWith:(NSString *)chineseStr{ //我的mine菜单10个
    NSString *type=[self getType];
    NSDictionary *temp = [ManyLanguageDic sharedManager].mineMuneDic;
    NSDictionary  *dic=temp[chineseStr];
    NSString *str=dic[type];
    return str;
}
+(NSString *)gethotStrWith:(NSString *)chineseStr{ //热点所有
    NSString *type=[self getType];
    NSDictionary *temp = [ManyLanguageDic sharedManager].hotDic;
    NSDictionary  *dic=temp[chineseStr];
    NSString *str=dic[type];
    return str;
}
+(NSString *)gethCourseStrWith:(NSString *)chineseStr{ //热点所有
    NSString *type=[self getType];
    NSDictionary *temp = [ManyLanguageDic sharedManager].courseDic;
    NSDictionary  *dic=temp[chineseStr];
    NSString *str=dic[type];
    return str;
}
+(NSString *)gethExchangeStrWith:(NSString *)chineseStr{ //热点所有
    NSString *type=[self getType];
    NSDictionary *temp = [ManyLanguageDic sharedManager].exchangeDic;
    NSDictionary  *dic=temp[chineseStr];
    NSString *str=dic[type];
    return str;
}
+(NSString *)getMineStrWith:(NSString *)chineseStr{
    NSString *type=[self getType];
    NSDictionary *temp = [ManyLanguageDic sharedManager].MineDic;
    NSDictionary  *dic=temp[chineseStr];
    NSString *str=dic[type];
    return str;
}

+(NSString *)getSettingStrWith:(NSString *)chineseStr{
    NSString *type=[self getType];
    NSDictionary *temp = [ManyLanguageDic sharedManager].SettingDic;
    NSDictionary  *dic=temp[chineseStr];
    NSString *str=dic[type];
    return str;
}
+(NSString *)getRefreshStrWith:(NSString *)chineseStr{
    NSString *type=[self getType];
    NSDictionary *temp = [ManyLanguageDic sharedManager].refreshDic;
    NSDictionary  *dic=temp[chineseStr];
    NSString *str=dic[type];
    return str;
}
+(NSString *)getLOgOutStrWith:(NSString *)chineseStr{
    NSString *type = [self getType];
    NSDictionary *temp = [ManyLanguageDic sharedManager].logoutDic;
    NSDictionary *dic = temp[chineseStr];
    NSString *str = dic[type];
    return str;
}
+(NSString *)getLOginStrWith:(NSString *)chineseStr //登录
{
    
    NSString *type = [self getType];
    NSDictionary *temp = [ManyLanguageDic sharedManager].loginDic;
    NSDictionary *dic = temp[chineseStr];
    NSString *str = dic[type];
    return str;
}
+(NSString *)getTipStrWith:(NSString *)chineseStr //登录
{
    
    NSString *type=[self getType];
    NSDictionary *temp = [ManyLanguageDic sharedManager].tipDic;
    NSDictionary  *dic=temp[chineseStr];
    NSString *str=dic[type];
    return str;
}
+(NSString *)getHottabbarStrWith:(NSString *)chineseStr //登录
{
    NSString *type=[self getType];
    NSDictionary *temp = [ManyLanguageDic sharedManager].hotTabbarDic;
    NSDictionary  *dic=temp[chineseStr];
    NSString *str=dic[type];
    return str;
}
@end
