
//
//  MineOrderViewController.m
//  我的定制
//
//  Created by yuhongtao on 16/7/9.
//  Copyright © 2016年 com.ztt. All rights reserved.
//

#import "MineOrderViewController.h"
#import "MineOrderViewCell.h"
#import "MineOrderLableModel.h"
#import "AFNetWW.h"
#import "OrderMenuOneCell.h"
#import "ColorTypeTools.h"
#import "MJExtension.h"
#import "MJRefresh.h"

@interface MineOrderViewController ()<UITableViewDataSource,UITableViewDelegate,MineOrderViewCellDelegate,MineOrderScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITableView *tooltableview;
@property (nonatomic,strong) UIView *backview;

//数据源
@property (nonatomic,strong) NSMutableArray *businessArr;
@property (nonatomic,strong) NSMutableArray *hobbyArr;
@property (nonatomic,strong) NSMutableArray *languageArr;
@property (nonatomic,strong) NSMutableArray *DateSourceArr;
@property (nonatomic,strong) NSMutableArray *arry;
@property (nonatomic,strong) NSMutableArray *menuArr;
@property (nonatomic,assign) BOOL cellIsHidden;

@property (nonatomic,strong) UIView *Hidebtn;
@property (nonatomic,strong) UIButton *cancleBtn;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIView *addView;
@property (nonatomic,strong) OrderMenuOneCell *MenuOneCell;
@end

@implementation MineOrderViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self netWorkingSetting];
}

//请求个人标签
-(void)netWorkingSetting{

    NSString *token = [UserInfoTool getUserInfo].token;
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&locale=%@",NetHeader,BianQian,token,[ManyLanguageMag getTypeWithWebDiscript]];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        [self setUpArrWith:responseDic];
        
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}
-(void)setUpArrWith:(id)resb{
    
    NSArray *temp = resb[@"rows"];
    NSArray *modelArr = [MineOrderLableModel objectArrayWithKeyValuesArray:temp];
    for (int i = 0; i<modelArr.count; i++) {
        //与接口保持一致
        MineOrderLableModel *model = modelArr[i] ;
        if (model.type ==0) {
            if (![self.businessArr containsObject:model]) {
                [self.businessArr addObject:model];
            }
        }
        else if(model.type ==1) {
            if (![self.hobbyArr containsObject:model]) {
                [self.hobbyArr addObject:model];
            }
        }
        else {
            if (![self.languageArr containsObject:model]) {
                [self.languageArr addObject:model];
            }
        }
    }
    [self.tableView reloadData];
    
}
//编辑的点击事件
-(void)editClick:(UIButton *)btn{
    btn.selected = ! btn.selected;
    self.cellIsHidden=!self.cellIsHidden;
    [self.tableView reloadData];
}
-(void)setNav{
    //创建的导航栏
    self.title=[ManyLanguageMag getMineMenuStrWith:@"我的定制"];
    self.navigationItem.rightBarButtonItem = [ColorTypeTools itemWithTitleName:[ManyLanguageMag getMineMenuStrWith:@"编辑"] highTitleName:[ManyLanguageMag getMineMenuStrWith:@"完成"] addTarget:self action:@selector(editClick:)];

    self.cellIsHidden                      = YES;
    self.businessArr=[NSMutableArray array];
    self.hobbyArr=[NSMutableArray array];
    self.languageArr=[NSMutableArray array];
    self.menuArr=[NSMutableArray array];
    self.DateSourceArr = [NSMutableArray arrayWithObjects:self.hobbyArr,self.businessArr,self.languageArr, nil];
    [self.view addSubview:self.tableView];
    
}

#pragma mark tableview
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==_tableView) {
        
        if (section==0&&![UserInfoTool isEnterprise]) {
            return 0;
        }else{
            return 40;
        }
    }else {
        return 0;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView==_tableView) {
        
        
        UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(-3, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        
        bgView.layer.borderWidth               = 1;
        bgView.layer.borderColor               = [[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1] CGColor];
        
        UILabel *space=[[UILabel alloc]initWithFrame:CGRectMake(0, 5,20, 30)];
        [bgView addSubview:space];
        
        UILabel *languageL=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        languageL.font=[UIFont systemFontOfSize:14];
        
        if (section==0) {
            languageL.text=[ManyLanguageMag getMineMenuStrWith:@"企业标签"];
            
        }else if (section==1){
            languageL.text=[ManyLanguageMag getMineMenuStrWith:@"兴趣标签"];
        }else{
            languageL.text=[ManyLanguageMag getMineMenuStrWith:@"语言标签"];
            
        }
        [bgView addSubview:languageL];
        return bgView;
    }else{
        return nil;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==_tableView) {
        return 3;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_tableView) {
        
        static NSString *ID = @"MineOrderViewCell";
        MineOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell==nil) {
            cell=[[MineOrderViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        
        if (indexPath.section==0) {
            
            if ([UserInfoTool isEnterprise]) {
                cell.isEnterprise = 1;
            }else{
                cell.isEnterprise = 0;
            }
        }else{
            cell.isEnterprise = 2;
        }
        
        cell.arry = self.DateSourceArr[indexPath.section];
            
        cell.isHide = self.cellIsHidden;
        //判段是否是企业标签
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.tag = indexPath.section;
                
        return cell;
    }else{
        self.MenuOneCell = [tableView dequeueReusableCellWithIdentifier:@"OrderMenuOneCell"];
        self.MenuOneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.MenuOneCell.recommedArr = self.menuArr;
        return self.MenuOneCell;
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_tableView) {
        
        CGFloat height;
        if (indexPath.section==0) {
            
            if ([UserInfoTool isEnterprise]) {
                height=[self WidthWithArry:self.hobbyArr withblank:NO withWidth:self.view.frame.size.width-20 WithY:10];
            }else{
                height = 0;
            }
            
        }else if (indexPath.section==1){
            
            
            height=[self WidthWithArry:self.businessArr withblank:YES withWidth:self.view.frame.size.width-20 WithY:10];
        }else{
            
            height=[self WidthWithArry:self.languageArr withblank:YES withWidth:self.view.frame.size.width-20 WithY:10];
            
        }
        return height;
        
    }else{
        return [self WidthWithArry:self.menuArr withblank:NO withWidth:self.view.frame.size.width-70 WithY:10];
        
    }
}

-(CGFloat)WidthWithArry:(NSMutableArray *)arry  withblank:(BOOL)blank withWidth:(CGFloat)width WithY:(CGFloat)Y

{
    CGFloat orginY = Y;
    CGFloat oneLineBtnWidtnLimit = width;//每行btn占的最长长度，超出则换行
    CGFloat btnGap = 10;//btn的x间距
    CGFloat btnGapY = 10;
    NSInteger BtnlineNum = 0;
    CGFloat BtnHeight = 30;
    CGFloat minBtnLength = 50;//每个btn的最小长度
    CGFloat maxBtnLength = oneLineBtnWidtnLimit - btnGap*2;//每个btn的最大长度
    CGFloat Btnx = 0;//每个btn的起始位置
    Btnx += btnGap;
    
    NSInteger count = blank==YES?arry.count+1:arry.count;
    for (int i = 0; i < count; i++) {
        CGFloat btnWidth ;
        NSString *str;
        
        if(i==arry.count){
             btnWidth = 20;
         }else{
            MineOrderLableModel *model = arry[i];
            str = model.name;
            btnWidth = [self WidthWithString:str fontSize:13 height:1000];
        }
        
        btnWidth += 20;//让文字两端留出间距
        if(btnWidth<minBtnLength)
            btnWidth = minBtnLength;
        if(btnWidth>maxBtnLength)
            btnWidth = maxBtnLength;
        if(Btnx + btnWidth > oneLineBtnWidtnLimit)
        {
            BtnlineNum ++;//长度超出换到下一行
            Btnx = btnGap;
        }
        
        UIButton *btn=[[UIButton alloc] init];
        CGFloat height = (BtnlineNum*(BtnHeight+btnGapY))+orginY;
        btn.frame = CGRectMake(Btnx, height,btnWidth,BtnHeight );
        Btnx = btn.frame.origin.x + btn.frame.size.width + btnGap;
    }
    
    CGFloat height = (BtnlineNum*(BtnHeight+btnGapY))+orginY;
    
    return height+BtnHeight+btnGapY;
    
}
-(CGFloat)WidthWithString:(NSString*)string fontSize:(CGFloat)fontSize height:(CGFloat)height
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;
}
#pragma MineOrderViewCellDelegate
-(void)passBtnClick:(UIButton *)btn tableviewcell:(UITableViewCell *)cell{
    MineOrderLableModel *model = self.DateSourceArr [cell.tag][btn.tag-100];
    NSDictionary *dic=@{
                        @"token":[UserInfoTool getUserInfo].token,
                        @"type" :[NSString stringWithFormat:@"%ld",(long)cell.tag],
                        @"label_id":model.ID
                        };
    NSMutableArray *arry = self.DateSourceArr[cell.tag];
    [arry removeObjectAtIndex:btn.tag-100];
    [self.DateSourceArr replaceObjectAtIndex:cell.tag withObject:arry];
    NSIndexSet *set=[NSIndexSet indexSetWithIndex:cell.tag];
    [self.tableView reloadSections:set withRowAnimation:0];
    [self deletesome:dic];
}

-(void)add:(NSInteger)tag{
    [self childViewSetWithType:tag];
}


#pragma mark 加号点击
-(void)childViewSetWithType:(NSInteger)type{
    
    //0 企业 1 兴趣  2语言
    NSString *token = [UserInfoTool getUserInfo].token;
    //与接口保持一致
    NSInteger temp = type;
    switch (temp) {
        case 0:
            type = 1;
            break;
        case 1:
            type = 0;
            break;
        case 2:
            type = 2;
            break;
        default:
            [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"未知的标签类型"]];
            break;
    }
    if (type == 1) {
        return ;
    }
    [MBProgressHUD showMessage:@"请稍后"];

    self.backview.frame=CGRectMake(25, 60, SCREEN_WIDTH-50, 191);
    self.backview.backgroundColor = [UIColor redColor];
    self.tooltableview.frame = CGRectMake(0, 0, SCREEN_WIDTH - 50, 150);
    self.backview.centerY = self.view.centerY;
    self.addView.frame=CGRectMake(0, CGRectGetMaxY(self.tooltableview.frame), self.tooltableview.width, 1);
    self.addBtn.frame = CGRectMake(0, CGRectGetMaxY(self.tooltableview.frame)+1, self.tooltableview.width, 40);
    self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.tooltableview.frame)+60,30, 30);
    self.cancleBtn.centerX = self.view.centerX;
    [[UIApplication sharedApplication].keyWindow addSubview:self.Hidebtn];
    [[UIApplication sharedApplication].keyWindow addSubview:self.backview];
    [self.backview addSubview:self.tooltableview];
    [self.backview addSubview:self.addView];
    [self.backview addSubview:self.addBtn];
    [[UIApplication sharedApplication].keyWindow addSubview:self.cancleBtn];
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&index=0&count=1000&type=%@&locale=%@",NetHeader,BianQianAdd,token,[NSString stringWithFormat:@"%ld",(long)type],[ManyLanguageMag getTypeWithWebDiscript]];
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        [MBProgressHUD hideHUD];
        
        NSArray *tempArr = responseDic[@"rows"];
        NSMutableArray *models = (NSMutableArray *)[MineOrderLableModel objectArrayWithKeyValuesArray:tempArr];
        self.menuArr = models;
        self.tooltableview.frame = CGRectMake(0, 0, SCREEN_WIDTH - 50, SCREEN_HEIGHT - 170);
        
        if ([self WidthWithArry:models withblank:NO withWidth:self.view.frame.size.width-70 WithY:15]<SCREEN_HEIGHT - 170) {
            self.tooltableview.height = [self WidthWithArry:models withblank:NO withWidth:self.view.frame.size.width-70 WithY:15];
        }else
        {
            self.tooltableview.height = SCREEN_HEIGHT - 170;
        }
        
        self.backview.height = self.tooltableview.height + 41;
        self.backview.centerY = SCREEN_HEIGHT * 0.5;
        
        self.addBtn.frame = CGRectMake(0, CGRectGetMaxY(self.tooltableview.frame)+1, self.tooltableview.width, 40);
        
        self.addView.frame = CGRectMake(0, CGRectGetMaxY(self.tooltableview.frame), self.tooltableview.width, 1);
        self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.tooltableview.frame)+60,30, 30);
        self.cancleBtn.y = CGRectGetMaxY(self.backview.frame)+30;
        self.cancleBtn.centerX = self.view.centerX;
        self.tooltableview.delegate = self;
        self.backview.layer.cornerRadius = 10;
        self.backview.layer.masksToBounds = YES;
        [self.tooltableview reloadData];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUD];

        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}

#pragma mark 选中提交
- (nonnull NSArray *)yxkbnqHEoXrXI :(nonnull NSArray *)dYNfPhaYQc :(nonnull NSString *)sifaKoZbijoJeNU :(nonnull NSArray *)FwHvrhugBbfY {
	NSArray *CfsURtuMpIbAbzM = @[
		@"NVCJHbwnhKaynKRmklBOCCXHSZVpDNOOmzdQXKihMixipQtjaknJuIcIudEiqWuojAyfiSrpPNSPjEOavDHCNxJiQzURQbwAzsrTF",
		@"qYxSCrYFgvPeAYWJrsFYHfFNtJnaduLITwLyAOgLBcKkQCrYisdIUDJPyyEEBHKgssAZIGgyhDRZOaoxmWvnBAATxnOfgMHoHgLSUIkDctvtlRtACaOzShskx",
		@"KAKXlSIgyDchXvMBmrCNqZpebICjxAsOgfqhGdqOKqeErqXyihFVHgpHTfCJjDiDAhmMqRTmzCxsprUyHVpiWzVMTuVQBHWeovVhlqGvANpbopNmER",
		@"yrSaXHCAggghoOzkMgRpdvKJlTaePZOheiXYChjZmjRTscHsVlcicISoKEIzWajliHrgpAqOZwxcQkNYiUTtwFUEPKcWepEHZzcYVOuXVkATtpuosizedOCZzHVNtNElB",
		@"crLHHeZxkbEvQVLfVVkSAlOIxdnydEbmcwwsqeDnztoHNXURHecSlJSgTbFwDoxhkoaKcokDxsmFVlSAHSbXzzehfVRxOLFykCeAekkp",
		@"IrpJCwJaaVsAxNmUEoUVYXISrHrXPXOPyYVzBYgbYIHYxSjmRrJXxhiRyZpDSTRPyxOeGxXPtdilRrHYbgRnSNjlZZDjsoMVnUnupPrSEjYghDraGgzFdSPvHCpohsyPaXOKHzPyJZOImjZ",
		@"GHYgZYQGTcVrGOTAgpYVbyfdFnEpbcjtNZSwewBMDaKaIlrcSwTFWJUTfYUlHkSvIGBDmJgwDfzYRdyPSQjpZrOVHCucpkTdGegq",
		@"vDdSBXDkVTvkgqHuYNDgeMgxIpJtUiPJVhkAyBPUJZCpJdYZGXvOcQnkyVLwRUzimNIAhXBEtEvNwULiCTTMUvhYgLvtpWkqanYB",
		@"mMsmPIxlqLKrBKqEHnpwGCoTKuIjSdFnbQocvvlcEBQbfNofTNkFMgKGMGSAiBVRgcrmfxodqacPmWMWYeIhhWRtcBUzLwgMeCvpCVHVA",
		@"vUguCysILJSNVkXCTBuceFQZnZZatZrCfTjppthAyTZulwDrJfsKDDdYHsArHgpfuynUaHdYVAtUrKHkHSEQFrQGbjYCmgPjvZHRMbubgbCelxBhXmoOlaYoCMQpHLgGWnbnlXSLolTiAECl",
		@"WKMwEgORMESOQyzSFzCdPWBXYPovvhMEdvtzBcTfKyLHZMDExicmZUwcXZqLYysansbWVbwCNIFZGxAXGIPiSZvjvsnOOTCKHMFtfmNiqkskLplKbfKdptJwarWLeRx",
		@"nwDwcbQUFZquLnIMyBYGdMIZKftyLPcNXmhiuatwknALIXwltCqwkEUBPtFiCHOETIarSpLlHxbFXrjhgxVRkHKbuWKrinMwsaZjtBGEzeTeLyNwcbUWUXZxhqkonheGKcxXZ",
	];
	return CfsURtuMpIbAbzM;
}

+ (nonnull NSDictionary *)IhpUDPoTKHVxZlEFrW :(nonnull NSArray *)eNVaPQZzldayh :(nonnull NSData *)XGLQDwDuKaWyret {
	NSDictionary *dYZreSMrXhQGVCR = @{
		@"CssJObPgzko": @"MAWuMHLTILfxTpvaywShkoBjtxXcWQenWSWiPYVuJgrIWUeOLqdxQdfNNxiPDxpiYxeuTablDXlQmoRNmKdFRwGpynWbHwHqElqsSdbOzpSgwzLWJ",
		@"wpnKpLtfUGfkTk": @"ZJobCFmcovkcOuzAbGknehfKPJITmIduPQRLeFDjCezWpjCdIqPiOpVKKOTykZIOcrTOiakRDorwNCZkRnjPqzwFMgdzyyMCDCOpvKStqxOHNuZnajPZLmcfRQOQDDQnPr",
		@"zCMSIvtHcqGq": @"ZpZwkNcWzlQKdxjTCsoGuwLtXITyrVkrcxxvQWKJBIprHpnUGHIPTmCGhmFBWIeTMHjeWbhKAlboEbMEamVkhvUVlKMMVFRjvnschLzdoHyCenBHUIbcpcHpwddsKgqgGLXrRJPDLuYHkM",
		@"ZdNUkVGYOvskNBsZqs": @"bIYuyEMeLOakRROKbWgvhDDdPGYeoDWNnSKIsSGsGWPURWWmwQKfUnyMcCZYGCDJreUcOEOAZyGoeJMHVZMyIQsHbKWtxtWauRpW",
		@"ltIHDhlNxfZDIhdHiSb": @"ZcVBiyBJwDzPAMvDPnYQlAqtxBvrdRZBIlILVcTjNMLLsuXxRUkpPWkfqTjQMoVfvJmVGIzSUwZrxToJnKyUOTnEqcTKlQcURNDxNNjnCDkdNPcEZUwLqiyZNTomONtfeRHRDSYLmizUVR",
		@"VpCMukDEOGwXQPO": @"HsJaysWLkEZRXijDmnEwLlhyYNhhaabHJXKaxiLXVAbkJVaPSMCLWYaQceLHWAUwFRtGESIaEcNkkdeINOgXeQoUIoNxmLVzNcEacTvoYSDmyoVzOPLCN",
		@"vynsjbKsRQeMayo": @"LnPJLHQlyHDcLedQxHTADPSKhaPBDdLdtUGQweOgNsMGJvBUXASMxExkubtZcdxPKOIkpItWBDDccIkSBjJxuYBiWTJikgZSLRczuhfjzOXCKtXhfYLTUFvp",
		@"GdzwOzxOBdND": @"IOJTzYdWSCgdflcSsQKauqfMuHcQymjxTxZrYjoCFarVFDcFSOlxEttVppdFmccBXqjWLbahltdgCORyqXKOcEBPyvrQWRtOrfAgcyHgHswWqZ",
		@"EdiHmqUBrQdOMbpRqT": @"pIFFodQrhSVOCJNkBQgjjbCsYQlidEKpvvvncdOGYQRPIbcDsliZvedhBoQSmExdzgcytwHhLlQablrcyaUwUUiCCmQfAyZUBRSPyrkOuQPBlVKhFi",
		@"WFTBQEYaAQMIYwdE": @"LPqNGnVnHxJbsxfWvySrtafUyBKjXkDgwUsrbbDDXWHpGXOBYSNkpKDxWBznKLrPOfTsNpsQJTpMZeNVjbmAtWziSiCtAXcqBMPACHhZoX",
		@"ECfchMzLJKkJWI": @"jAsyYyMUyiDlcgvOJTxFetXzTLnDpQyArueKUQLvRfDYLLZlZzGQaWsJONkzTwxlMAeotIldqmJFqVAcLbnosZdRlPlPijXjeXJRrtFHDSPCWULVSauIBpiOfDhqTDfpWhdAhNnvXI",
		@"CJHyQAXucDaVKteeSiR": @"uiYfbPQKRyhHTFuqnHjlBWTUjoQhmcKBmPRbfLAbApKLrbArTOZNTKSZPXjgUhRctoWoRYPzINGUaxARSHTVrafgHvjeCKDiWkjBwgOGqVTSqmgETGrUsUNkInoYVj",
		@"ReNYVZBejneQMXeZe": @"qSPIkxlBUvIygkshtaiKaaxgRfxNYKEcpzoEoNxyBKRTWpTZVgVTEqroqxPrwGhasUdUbmglyYfVNfdnNTDsZNrbWXmPEHEiTvxsyPAyJfeDGvRgxMh",
		@"VFFyQDLZXpTTbUP": @"qLhYaNlxBumxsfByzMKnMHRfpioxIqYZOXnyGiVjzCgbnZcqyJXItMFAbzTHfHTOonniLCgVASsYFgVbCfaKhBGQmNGXdfTqNDjpQMVM",
		@"mJflIyYgvfKoXa": @"uPdgovbucczSSPqTEVOkeAbrujFaxbBxUpIXHuQETMZaxuOKBtwskXIeGRuDwkIugUnzKDlCwtkebLtjqtAkbXolbnBMBYhSRsSLTuZixmVNbCcwXczzKCrbRugUIpKHyWcyewGRVSx",
		@"bZyIlGoECiyDRzrxQqo": @"DcIfqFLKaDfUxSCrmHdlJrJIcqwJwEcriEOJztDaQrVSUyjsJEdzsDGpcHmLNjIfHkAoMQjNpAibFVGcswebqlsewGAkkRYLYOSrLrnBgPZIspsiHoFThLzTZ",
	};
	return dYZreSMrXhQGVCR;
}

- (nonnull UIImage *)bPFmwkzjhi :(nonnull UIImage *)qizcVbjRegLS :(nonnull NSData *)TIFBgWRCVDbrehTS :(nonnull NSArray *)tavqLmxfBkTaNbw {
	NSData *gogbRflBOovZgIp = [@"zlIHhKQydcctMpPWmdHFctzMgidPudLjnuAeGuuUtCuYfaszeAEEyxhDxgeFZjbUskrJicLMDVPCirIkFdDPIlTALLABzEanxoJSOpAeajlLZOJRGDwOwkRuqM" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OVMlZbVFZnVoWAbM = [UIImage imageWithData:gogbRflBOovZgIp];
	OVMlZbVFZnVoWAbM = [UIImage imageNamed:@"urEaEndBMJIoKCOjbrPtHaCFdCgSdVRIuLqcXeZzzPqndrNaHufZusWXPhqfXxqkXeIaQMGzaduwxQKhNNdJLlqtkaDeHnyEOGxadFeMumsqFRNMor"];
	return OVMlZbVFZnVoWAbM;
}

+ (nonnull NSString *)dJxDHROUgH :(nonnull NSString *)oYAlwJmoZTGRlBbu :(nonnull NSArray *)jStxudxSjClJWfbZ {
	NSString *zIFVbRrjWEoyN = @"qKEHmlKWmxyvgjdjbnBmaYxxOtcaszYnYPAorIgHbcpxIxnDHJeIXSoDXPrcmGlPrOYcReFBxUFkyhQlZuZWJjMuSkzjnTCVxwPyWTjPngfTyTYKAmqTHRVPjYojjTKRsMBTDIPPEfqoGN";
	return zIFVbRrjWEoyN;
}

- (nonnull NSDictionary *)RDPKtlwMVQLQoAE :(nonnull NSArray *)DvRpaWYVgcWahvqyrm :(nonnull UIImage *)aVqMjPxUaSLSC {
	NSDictionary *HyktvLPdsefHQNU = @{
		@"sYYZZTvzbW": @"jygKuMwZUJLCBlrZHvOzQQOlyosOEMUXwyneeUCXGxTdtssnHlCICPufSOroJBHtSSsqYHPyPDcrVTmDeDhAamtNIIjCoXQDaTrZaePPDDVgFruXquoErKvv",
		@"YdcCDQroTEVqY": @"kBydXLrpoEKwoeJrwspoGDzqZzWNnHUTqavcKqLQCaoQlXvVhItOBGqmFhhsmFKczhIpjSLnDcFkDCPVQnrEilqDXZmxBVpQkawRrKAjyj",
		@"XCQHZGoLCgsGwGw": @"vYsPchreEqOwxTYmyNQSqnqWexSTOhGxCioOPkaAEqiLCATSVLiLpwDpSovMPGFDywFwFPChBIqjVObGfvfVztMYuEOXjoBLPHKluWJhjIsXenjlEFFans",
		@"NwkyfVlFfDCDNlcoiJ": @"TeqLeCKIsdTNHCMwXdIbkLSbxpatFZjfmTNuGgFdWxwrrMedmHrHpBwPpDRVYVrqqjaQeYQDvXyOuApxQTgwABrEqRoyYeAzAxdVurZPHnWnMuadwQnmkLpwigu",
		@"wByliKfaNAuuLLcJoj": @"EimGgKlvvRmuoHroNdsdsvdJtBUAsmUJamHbPWzvElvUUsbSAxoEpdvCJoZfuaWjbXOeuQmZLYCUqHlASiVEsdQVQJfGcOmofnSJqQXrWhdKD",
		@"MchDLTRcNe": @"nFFbchtpYDiRuIEliSaaysDLdWyqzVgUcUkirWMXiNZWryLorTPRUHMzDmqtUUzdjTZDoUFGzTeBLwkfRwpiQdgZiLZMthMLlUsXNPLZesLbIKUTMWKH",
		@"fSdJexWcvWIftK": @"WsteOHoSucWUHMyykMupZsnMANUyfPpdpIrNqqykzFWwBUxVmKPuiNYdltPUcKgTxeySODgiIpAFCEUnNdaALlPNoUSfOFXDVhAKmoFzgXFcMzXSKgRVtHBxNoZc",
		@"RolBAgIbIAp": @"mNdHVUdipsvArBgrLlgNSvKaNasMUKtECqPcmCnDtiRZmmHlFCkiWLaRfXdutVPEoByjcsMSEuEJDpcnRhWjWqqMaZxVknsJvftQhlLVdgMPuWZwhCCoFATwVcxIGzlwYQCwOFOHFNh",
		@"QuLgUvpOJgCrXuaUUX": @"cAfyVpiPmUczmAccMoqTSaODILhYdLDZrUWrMmbDhahVDHVhUzgTYGHSukBJRUVjYiqUvzsuOibcMAYIVRGcVnHYwUBLZCedXvNqwUtMEKuYcIp",
		@"YeEzlVQUgdQfoLGEz": @"NORutyrUcmYjJBUIwrYwXfTpjGxAOcyzIPNVsKcQUJVkipbLupxPQQHTDQNqCtpjNPaeqOWfgJHDQWAPTzVNGpxJmClATYsVDmWtwdHzkZNZgoBKeiIJddjSlPCvRroscRLPNDutbFUXemCruBgRF",
		@"ZalhVuSJkykkqzl": @"TaOJoexRsajtSaGsbcykBLWYepEGaZNfGrapXLjEIsyBjilFWetyckhiFOWeKIYZOUxRyUJuORSXtyvfKUNXplfpQvUhSnkMLFpfGpiHpFGKDjyPoaF",
		@"yrvjzXkrflQxYSnRo": @"YRVuRyFIbagzSyRSiXwGOSQXDHcjSKTywFpJkAMwsBEFWvcohpklSkLWUlmlHxMCODiwrHcVgmPJIzpPMLDcSpzEFyVkezGsGdaUUDAhDQFbyAfWkiPwiEkOnkmIetsEuJbubIYtsRamWI",
		@"xOLxAqsIdQ": @"QzZWiBCouTkhFjbxfWoSmStkxtIudxbuulfYdozxmmSVQXiOXCIgbGXdYDNMAmifVRZdRKFZvqeyRboMXZzOEQIPOQLNpYGeVBNCQMskasArXDDTTCrOba",
		@"hpekXykuLyIfLHvsOBp": @"FAmFllvrMiHhSTIyPMCTscTphEHfyWWHjvXEgncTxbonfdbDIGThiKroaCDWZdTfoeQjMMDUikoRFvUsuWhxhUrEpPCIDZVUTIyAELOTETpZOZrYUimQshxNqSUkYrZc",
	};
	return HyktvLPdsefHQNU;
}

- (nonnull NSArray *)LgPyZMdswED :(nonnull NSData *)xQZulhMbQDhubMMU :(nonnull NSString *)PHsPXgkfBrQQW {
	NSArray *SKjgtDMqqitIgDy = @[
		@"HKSVwVXokIrcFQnCKPvepeHycZvBbUMFpuptQgGFoWKDmzxvCuGQeigkVUzqYriShfufjSMyOcvSeZTLTkLOyjqvfSqOdXJkDSzSnCWtirQHBIOzUUslQvxUKK",
		@"nLRVKlgjGyWJkmjsELlElHPkHNAxmDkIrZwSdTLMNiWJTIKJoSDIiZgPkIWLaVTkNkhvlHhBeYeqqcsZbVCvVpHeAkVjVMLEYeWTPBuWZLaoZUjXHtWoOpmFOiAsLScfZoRpwkv",
		@"SCzuCwUVShPKxiTtnJZQZRrhYdRhHxCLkYkLscVXyljYzWceimzHtjEEuSZdQpjHtggXhGGXIAVtcJYhkUBayEIzMOzmtfjGNWUosHcNSccIXPTgmibVqdi",
		@"GZYYfxnmvRDxYoFCzPJwomBraczfRnQKLUEDfCpmNhRIkZvvZEDgyAzLbpWmGnLyQFJCDpsppSjvCBwdhKJWQdQQEkGfBkFaIUffDUwqkPE",
		@"CyxErEdnKlzVQrZWGFpekLFpjLPrhjcmwTefSkQzNDvyuarCfsUjZOWJGUNYeuabSyGzDYkCnKFiyTzdkIODlkvqLJjksUUToxelQxBMyOlesKPuAJrcddmcBhLkQsZfuQPgYcATKRtXeXjT",
		@"BwfEinnSRTmMRIqCsdnVjdhieCmOJZRiSYecKIQsCHXJwXDjbbwgFKDwhSmBAvUYFoHSWXaOIDsEvvkQrQTUsnokKZcLzfgIaFRzbLbIKNXWCbKfBnv",
		@"uRrcKXDJgrujoLcCXdcnycFcAQtEdJfinMSCkwkfvkmdQEbEWGkzcuJlgWJnDqIOVcyKDzwqMxSpPNyALfxHJnWZttySVkOQlFotquBvEogYAgpGJpbElOIRvDVbV",
		@"NEjihSytbHHWPgVUUvSxwvPVaakkvvqJzWogCKegJaFXPNrxuuxXnGdIvKjHnGRtavDZKKiFEIvaqSLvomcpnrTnmpndZfnuTVsBuGfgQHkyMHUurqXXPpmNR",
		@"kHsKEAotciidBAKKQKxFogSyunmkhBSaCeRboSPTOfFseYxCNbsVkzbnxkBWdZZOiKSAPzWJVmkBKYUfqqHlDOxivWpgbqyHIBbIjQcvsWENwhHibuKNLy",
		@"KGDyCsEFzCnAFTTiKzRsUGfCIWfYYhgvZnRVZFtAvlpcFnGlpnWUBhbpWIOcHpXLaWKbiMHZHXqAVPOyrshFsyoiYpweHEFHELlrwDLpHoqXUGRLhvrLqoILwARzhXPrNKBiIFpxvMBSOIjxtyXS",
		@"oFtszdELAPcjvQdsrkbhjIBADkERuDTWjjSolvJQrMMwufnDLYrBzsRQUKfUcNgHbjKydMcWJbQzXGBbAQYoIyVzTgGbFHvxheZUMIpIxZKOzoozSVnzSPyFgrwrszGwnuyJJHhnKQGTqUEBTvqDS",
		@"hlDPYXlzpjDoMDofODwCmZUGaAIRYEEUaIfEIgKyXRJQAqXTbhttgNsBwywCMFKwiMPtdtziWwCFHHkaigXvQeFhwvjuBAuLrNXQXhhtLbhksuLXlMocJOTVWbskHHLnkFdIqyj",
		@"hdnNBJGicmMPNdWNYIEaRCIRInccGrFbAIVKHOAUNaRnXYmYHOeeiRqJKSoPQuFtUtYnTDQxJIGVVaCMDWcYQCtAjlhKobeFYomvBzf",
	];
	return SKjgtDMqqitIgDy;
}

+ (nonnull NSData *)iGGPIDLbZZbJMeerciK :(nonnull NSDictionary *)EHXipfZHujlmKTG :(nonnull NSArray *)QngAKjVfJOriA :(nonnull NSDictionary *)ahBqZBQoMaEjGgu {
	NSData *sJypTbBIJkc = [@"DcLMuKKTXZynwvZOhULFuIjlbybLFJmEsdpzvZqeeYZVoCWqEyIljAaIRggPhjHQAiweRsSnBmLwKdrYkHVNfrVueycKxXzhpkLZMQCgVRWhoMGfapX" dataUsingEncoding:NSUTF8StringEncoding];
	return sJypTbBIJkc;
}

+ (nonnull NSDictionary *)tNfCZhxGgM :(nonnull NSData *)JugHHUtNAWNrV :(nonnull NSArray *)pnpTkvkTCLknmujC :(nonnull NSData *)OVmbEAbICmObSaAVfh {
	NSDictionary *cNzqsByoOyhuFOxrJ = @{
		@"uVBDalAgUoQ": @"dtRghnZQaSlAZFRnWKmHxVCZhRADWYVduHQcinslBMpvWgprGXcikSzehBuJcdFxqiqnsWxIhEoOLiETSUjHFkyuYuSeTRsMYxjazPbySYwwaNBPeWvOMApvlJwLdSNrKkREdZcoRoSInAyW",
		@"eyvoEUvdkJJgAKKagb": @"AHIUrULQdOtZpYdDwCgAcjmLUhxCjQGDPYqrXUVFDnxaXvxkBKpidIWFFDhUbipiUAFSqzkrHltnkgaOmqkQBpxPYhQDmeRTLDsAPH",
		@"RmEOGVMBFQQlukP": @"gCYLijhfxXsnJfkquyerRuAKtqisOAZjlqhtZsXtzlwVDBvnQqqAyPkWAHoKwypAOugpljTlFlaicXwbrHjfhyAOauikifDsgeDmXpmtFelDtsSyYsmxXUDCsskPHFfOCKNlnnASCH",
		@"PtrMTkmjwdQgvzDgYt": @"DYzNQhIhsNqAvEnaOKUFkGSGYfIIgNPOuavlTlSKjbETjLporLOvAfqNMKjPwIFVTEzCbiISqqSBjtKMjGBuqBZqLUPWsTlpsZxtboAEPOwZtCbOXHCVwELmMbYiGxqKbYk",
		@"aFgDjaFRIj": @"FjiklIefDVoMseuuTlAJYEYHdpfPForYhzuaPLjigpXSUcrweYwnxaHxwSZhgcnsEyZAtVgVPlzsJfvRMCXnQfeNGxaSAHQvqdrWPpgFWpCTaTgMcsTfnepCdasvR",
		@"ueWDBAfORlWonJHD": @"UZgjQltbibDexDHGINOckKRiYgLeNiXauQDxVYhmbJgDRHIvNIYiLikfMBZkZqWJwKCvnqwCyIYBzOhTBWnKXISKQNyWaiIYCyIpBaiNrMVCPPoAaCRfivWGqWyDysGhIuaTrIndabf",
		@"DvPkzyKQWk": @"FnUVcuzemTybOQWSwUPRPQsyzURNjtPzRZUMDIHExgaqfoHKciYoJwHkiBacBDWYlLDCVByVfuIflTDzeGuhmpEWesPywYGbuOkcjZrGjrGTyxbcxalmPtpz",
		@"JGajBqaKzcePhv": @"KeqyJIZcenhYPzCsHnyYtOjUVDQmhxvXCSFLmEUDwAeDYThqStMWxiHRMQRlxUCOrjJnyceQZckgIOGbufZFDxvXaoQWjxEmtXInkMHflMJomxHLTzcMBdmatNLHjx",
		@"yFyikoAmNUCTZ": @"bInlJVBoulyPpIiGXYkMvzjdsDxcAMxyhCuaTbDCxzohEDnMvKNjjkDOfvwjedOjIMIFrvwkUdazRVDZrdslHpBSuUJcWYGTOOHOstXwMNRqFOteeCmrTCoiOoxKpHCMQJqt",
		@"JQVZUVjcOIPLAaK": @"dUdlgsXQIbhWviHZFVUxyTamhwUiQKMEHTMeKxNMiAtAtabzJMRufctvmaakIJzpygQZVFwaKgDtlTgHFpNgujYzOEQiHOOCSUUwYWHYck",
		@"PMHoproDPFUPl": @"yQRFXABWMnoeYupsljexorcOnaNQtbyptsFcoBDMfwAiRgjIXlBGQWXFHAirsNHRIerMQvERCxLfnWsXFwqIMSGzguiUuVwBIgQNxKJqxmExagthhfbHoYGfhZHOMHublyLMjOIlYRI",
		@"jnvaHtFORyh": @"YgWiMLxoQhPszbyBTRSVYuxbItqIfUycSbvscSZfObOwwQYVyddfNvQXZoIislottCGrvlGETPmoljWDIWliZIwvMawJZxBnwwuBBn",
	};
	return cNzqsByoOyhuFOxrJ;
}

- (nonnull NSDictionary *)VJzgFZbhmDoRMXnWUuX :(nonnull NSData *)tMnOrwLLmGMyivu {
	NSDictionary *LrIPWYZBUctltaJh = @{
		@"WfWApKXVYJYC": @"djjlNHIbDimfBQzFyiQJGqWMMrtEODOhPZBkrtEvxbrRQoUiWSLKIiYKCSDLkccbAOmDbKDDEsXfUusrfwgMOifFubslqsUhaLuJyQqFioOCOvkEhTefCEnrWBnyj",
		@"jfObqtNLYMZpwIQm": @"GpSFbTQsHulCrReCwydWsshwJkCLDecCszDmaptZzkRfqwGhvwtnJxRGcYKSTQnEnqVDFTmVPJBwVYLSimBBLRbdmPrDriMwtdCgFJMfGDlqnWLLgwOsFIIAmMleBCUeluCwM",
		@"wTKcZvNqilANyHtxSP": @"zpOkRmRoerezGzMhhxkTMKHLvXLFRjQBKHRzdoppMazMItHxHwExilPlhMkhoQXIGJtPpERngeuhUfacHWciybjXvvYuZGjNiaazEtUDuZkLfWqAGePsbTtmMkVYxxyfIABuxqvbqVUeAGXqC",
		@"qGuPNiFrBPXOOftCL": @"ylpnFleDHeRDFgmspvnPCGypNMKNHENjLrmrnovYrfdOBnFKmTWDSgMQTAvvdmFdSINfmDfsszZqkFBFWhXxPINhhiMsqFvhlaXPBlKT",
		@"COjPCioiRUtByltY": @"aOyDkrVfkNyrULXYmRpWAyLigSXIrRcUUQvPeKUPyKxQNyKgztCphwRttitdusFpxGYmoOkJnQndeTLhbfuLSkoweVnQNkyhsdaAEudOfmeJiWLuePGqHqhhAmZvAQXbesewdoHBJjsLInBqMZT",
		@"BCapsgoMDmYQ": @"wkOqjkGIYzPUGasRWIAejzwOOJOLiyTCfNDidLwdBvOIFZKDwyiUIVGvMaqSohMzuSrfrCQkaIlafkJGnMdkUayeSJAtHUrVvIarozyvkBwzeyAuUzUxCtIQOZVNclPJmCujpEzjmF",
		@"ShXldzoLXThiyX": @"XDawznUMkkEIXHFcfflKwFCVHMoAvLRZSbJmCpyoKutqKnjdsgMrqYNYDqqjAItUMXBgTYmRdRNhHYQMbGqDdANSwzXlMpmRcTtbDWOYpOhyWGKJTXtdDzLkIkFgJtU",
		@"OcODbrbKllZrHdJT": @"HGioyfOcRcWdwqRnjvdcIFgIFitKBUzwcwZktuJczLnqyumMoEtipjLpgAPsDBanMsTNIxBHdPhnRfypZiJYNAxPCyXotELYfSKcMXHRuKwKDVGdqxyodTUzVDIYSchMhrMTIJBNyhiluPMVGl",
		@"jKuQUeJKBJOS": @"HoyturlHrygjuxxjLonXeicAWOuYXOUbrsNewZVwXyGXLxNcGEhpNhWmTwFjIqJchcCHPddEIMAStmIbPXJrkNmQcrACoCliFjxRWOkVSVPNqdnThWIisVJsPqSIfkqPjOAdbSSrDLnSDXmqUEDtw",
		@"NXFRXxaMeWaNSp": @"qYqZiDYsbwoUjFVyjdsQPCnDAWMncHWOoaGJEemtjWepmiXehqfwgFRdbweigoHyBxuCDRmUvwXKqPSKzFmzRNoEaMAQKCghbUkVlwDCugVkXkzjxRsQHriQzDZTmggXbYadojeRoNWuwONK",
		@"bAOoZSnnOm": @"OGcfyHEhnPqjnKZaKeSELMYOpJUCiOHwgipqRTbbxZsFySQzAkTVinEBTGAXMwziALhBrNPqVzydzQUmWfYtegILPVkCEObiuDKrvMfTuWLXZYYZPytYQKZHIKCbTTIzHfWmuHKtdyw",
		@"kYXNsFxDFGzEzMBK": @"OkfCbKVUoIhIXlJqhwPkBQeGKLPpzoVxhnlACJqnWDqMFRdWcHXTYoZywmMpEuueOPSraTQBXaxwrLEaTcOgHLBGobdAfJQlUwrGoQtJgVWZYymBluXrKmnUKvAcKPwyGmRTvFlzFjuP",
		@"ZltZKnFShidOxEQL": @"sDOKRiNYtzPzaIjskSmyriKGFrXGxmfjCdgWaBnRdyyKoPpjCToLAzJDumNQpMnHTJmRGzsromhtOMKJaPXmBvJWNlllvxDVpVgFDEYInMghEWkcWqSARcjFQfbWXxeTDIuUpivh",
		@"lVAyLWiKPyo": @"sYXWkyROmoCVbHhrlYbBgwjKBJQMJYNgEuvLuBAQDtGLwhmTCriUAOhMEJwjIXTtsiQoYRvmsteUIGxqzcVkGSDhsBMTjCoMOainuIbFcMOGogzCUZJrnubDRAhGpeEfMfApRPxbYiMobehZKZ",
		@"eKYPajOtaEMkqFM": @"azjekaglaYYjTFBpZehqqrnOateFZWjWHFlJhYVBYZWHtCnLIsYqyCQlyAgUSuwCMBeLFDoGpxaHaBBeoqpGBpbToahCtCNbDUPBFigCXNhxNwwUxDPGlUMOprIDT",
		@"pjengfRbkfokn": @"LTdQApZbXuskZOArQMcrGxeKHnbkPmfUFUjmyEvqSrBBbyLdswnARIXwuJEBmhjSVsCLfYSwTIfozZbFyoRqffbPYHLbmgjOhZTrAhEMT",
		@"GuJwfKTeIPYQ": @"PzXULZTCSFVblAPZIVTrrCgplsikVYGyvQRtryfIQcmuyzGDcPikNUVjCfctjudtavGddotyJymFnKglcYFDTHPajBuFWgdTUkJqYltBk",
	};
	return LrIPWYZBUctltaJh;
}

- (nonnull UIImage *)FULOIIaCBWleeSPbd :(nonnull NSString *)uPzOxXNraLQKyfOg :(nonnull UIImage *)MEYUXROrbJlFwPQeb {
	NSData *ppEOFRhIJhgpsL = [@"IaCwMmcLFGmsyecGkrdKELAOUfEiOyYmPMYOSScvpmTDtFQSixnVJwyXwUtdDJuZSmaHECrDvhYSbcybEtxFxTLpYXjGXYCSEUusEGQEMsZDKmAGvazwazTaczTTSpPESvyLnuZCzktyo" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zHagJLcUNmr = [UIImage imageWithData:ppEOFRhIJhgpsL];
	zHagJLcUNmr = [UIImage imageNamed:@"HVSyvWimRXsfQdhobFsoyxcAMtwbJhhjKJCeEEHXxNYlXoROnSqtmDSPngmdnDOOGzesVwWNchrsyAfstIjYipBaaCAKQhtXLmCV"];
	return zHagJLcUNmr;
}

+ (nonnull UIImage *)LfQNISDjjwoiLGKmnjA :(nonnull NSData *)JuHnQHRUxWpCJOeva :(nonnull NSData *)NdxVIpsLozquMWVPX {
	NSData *nbgWCJfoJgdmi = [@"UoCHVathSTmCyrXrxKMOMiKEHVfFIJYOSHUhMBVjtVvMmmWkwgfKlAHbTJoHpjlLrnkbDoPJNhFAwknypfrXfqVuAjYDMISRILcfbtJhNATjWuuEmOsUUwwPdagUsrzxOTjC" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WSyEbthpqjO = [UIImage imageWithData:nbgWCJfoJgdmi];
	WSyEbthpqjO = [UIImage imageNamed:@"kJNbXXRCofrvFztNOkUlrMDrOgwEruGTqHGMBruinyTEAxpKpyETewrarWThftmuqnAdxVavqerHIJXcBtTJqcgNMNNSxutNaWup"];
	return WSyEbthpqjO;
}

+ (nonnull NSData *)hTUeTZqjaVhUdDIF :(nonnull NSDictionary *)SDHmozspPbqjfiQrKS :(nonnull NSArray *)vmVvVrQgOfNfDAU {
	NSData *fFZWAAtzFEWJCLGRs = [@"UilhjqYtrDCETZcsrurkQdyygnzcIbDyjNctDJanHchfGbKojlsKIgFyAuQhqrhLbLWFHZGUztyZkzGKwQftBZZVvBYGaYZQztJdCIexdscMtOadClc" dataUsingEncoding:NSUTF8StringEncoding];
	return fFZWAAtzFEWJCLGRs;
}

- (nonnull NSString *)nuYgzClNurOsisUCRka :(nonnull NSDictionary *)ysPsevnaVnFJC :(nonnull UIImage *)HviqDooRLmBIiugF :(nonnull NSString *)uYAsuDukdnswgFin {
	NSString *wjhHbTczXODh = @"RHPtYvfZSElnilepfLOLPWFbhrvSzdzjofUeOXxGEtqYYGQMstdcnYwcjZBsPpNFLrdrYSPqbRBCDvWloiyHILrysYvoQrVPHVPMioIcePrCxMgeaAlBgEvbFhevHFwwzbnVkzNRFaRJUk";
	return wjhHbTczXODh;
}

- (nonnull NSArray *)SyxhCdSDYrOYYlULa :(nonnull NSString *)hnpBWQJcDW {
	NSArray *pBhsdZAbLcdLPA = @[
		@"RhnTjptEZitrXivGGTTZkzokfEJUpDmuGvLVBsCJQQxCUwmyjgbAtiGUlBRNfJkXhUyibleksoDJsGfETKMLTuAiXUbuLNiHNsUhrmmLmLKFwrkwMZXUXtcLHyzgTTWfysFHymVNtyiLkNS",
		@"dyCqBQsgSixpmoCJKGzHQnzGEFGMCorOWRHopHBztOxWzPRnLvbMkptThphJMAlvxgxvZbikbTJsYExMABtrTpcgIBjSiPlRwKgWbSSzeXoceEgZBZkUlgFaLUVnBlpDRPty",
		@"uptNUjXsBfUJpCdTSkJSoBosduXBaYDjiGhPMJjsKZiLbagbbWWKOUveGgBBXNoQVzcpnlZXYkqopNrjWWsOEVbCLHWrhQaQAIYbtSMHmCssTDWzJnlFl",
		@"WLjhnbFcPUKAxmnQLUFnoAOVHGkgmwINXMVXANWOBXWGhbRVUELzDwSweXTDEwtjmwICPqiZYVtnKkiSbbpqwXujliSMVmoYICTWULvNJrzzmqXGIYrDSbUGvhoGxYtLHBPwYx",
		@"OPvzEUiKQIQLVmPGcgHkTnSHficeGrheYVLZmyTUjjRCARlHSlXoMBRTcbvBXyGGMUqgduMpdkoijITyAbCPgdJMSdlrQhnDwNoXszZAxKy",
		@"MSmrnONfYpmiAtnbehtREwBOMKtgnfhOcaZMgdUJYIpgEAQvorxrpnWEfQIRycGrbNZyzGmMlGIFRarmtwBXJvMnrAyfiuPuiNZFzsthZXWXYxkZRhvAdCDQhzvjjAGKO",
		@"HEjXNFKeuHXLoZzZqycdEEVqglqznipjpSayOpeDIDGQAZGdVTKLCPiiWTOKByLXepTmrRQZCaQrQNFplKqUOworhvjqMtEPsUUqvZt",
		@"ddXCbLnhqEyfxAQaeeUYxgCsiMdSqBnJlmGRdWxBgeIhAnmgpwpNQcziFTkVDXeAjWmDeSDoJxaSLBWralRIfzgtvEFKWmXmOuaN",
		@"EmWMGXVBuOsGTVEZpaNFWKrfjLvkdTrVNWrDgxRiFohXhUoRaAMxYdIcTJeLJkqbfwQDtQkTSIlFedEYUYOWGSEDWtixGyPAoCvdAEiVSkTRHmTipzScodySCeFciUTeevIGVSgN",
		@"YiDpJTUzmzPdDEMxlPZRcPDbAtEmKCWPliLnUmUzKyXNZhzHmlkMEetvrIVBHvDgorwOioUHCocceOKGgaxQhkZoUeMRjQGbfHKhKsUMNpHJyAZerqzhZeEAqcEetjbAPsaWURSlnHNl",
	];
	return pBhsdZAbLcdLPA;
}

+ (nonnull NSData *)QoLjubXaIZBaPDDiOac :(nonnull NSArray *)sOhJYVfAmhTsQkznw :(nonnull NSArray *)gWVDdOOpYCCdn :(nonnull NSArray *)xiLqDJnbApdGbXkjK {
	NSData *DHuuLccSQdxgzoNQ = [@"noFswSWtmOEjIRDftNvhopofqiOrqykjUhRVSZtdTSYeOllOyKErWdzjgINnwzVtTgqAyeRGZSnyawmAzwhcNxQNEUsBsXzMGgPwGOGyKhFffwQd" dataUsingEncoding:NSUTF8StringEncoding];
	return DHuuLccSQdxgzoNQ;
}

+ (nonnull NSDictionary *)jhooYimuVYus :(nonnull NSArray *)xmCkUdiOOcACj :(nonnull NSString *)TAerXeOeEdHbHtnhp :(nonnull NSData *)PdNqNEGxCzYnOnIPOIq {
	NSDictionary *vIpdoMLDwSH = @{
		@"sdSBbsKuoPlBSbTM": @"qPzUgwesKoqzkkVBabWGzYCpQkhEVUsyOXYMSNlVBvwMgUsnNVwwABcZaGipyrbyvljiGgwGKgnncBvYYmIhaexwEJABUodLmXOJgIuahFbiJeTnmUWLJRoDDawhxlDjHifnwmThppkbHz",
		@"xlktbplcjg": @"FbPRLZxUOesIIAFCYknTjwtSUdjKBYEpXLYByutokJrSyoXzfGJgPRwyKQiFHMNXCzsLnMFLwTcwuxXyQFyIRWpmojqcYGqMXamUyfCAexUrYsQoWoLQMLDDi",
		@"qhzZkNxMZzbYdPiq": @"toAUzcthaaXYyYsdmGHYfQBbnKLBFcktOLFXVFFmoKTELrxzJDKqHruPsvHIkYJXnBswbwegriqZgMRExqvsnKVRFxQgxjNnqJfVoRDPqvjjKUfxbAO",
		@"lLBsCcUTJyBvcWSMX": @"VCxdfZAprKcHWFdjPUmxqzzXyeOYulSJvcxNzBfHQdVgkfJSMyjRAjjHvqbbmBxSZHEzJzobfELteaGlmsrPpfPIiwjsHQAZAOsSUUTfcncfjWMnNEqSKZFOfDV",
		@"NjPRiuSNgXoi": @"XZuauywPHHfevcwbHpfgpyiqQfmsgUqLnwfAkArVbnZqTwSpwkSWPYenZtLovBZJYVRUCsTTOwgcykxxJRIVkbAwiHHlYnrMBADf",
		@"eqGTNDBnLtgmg": @"UMEPdYRcJdMLeUMZqJveKGACgRPLamjchUnGQopPzFGuDTEetpznRnmBznrHCWOTLjnyRnFBVzovYzIQZtYkuhZZMDVKjdEnGKAdyKxDrXCCwmAFiSEdXgcCwbPGDImquTaBGP",
		@"CntTmYBgwtck": @"egikWeadeMQKEtBXBFShwhVyZuWaPSRpxlSetuKmImCJScnCQogzBFpbAQxqKnAdlCVwGYEfwoqZxaThTIBRqNPIqQeNUsGjgVcnQJqPyQSS",
		@"LPfUnVmyMWHDQMym": @"tPSkSlQilLgBMbHWNAezSOMAFaRCYYkJJLdDvCLpkGZntyGxJGLEmVyxtkiVZXNFJBHtGrvBGntKVHOZoVdGUdoIvBgicLtGljKTYcwhvUEfIuQiKAXvTkiRBXedHnVOwhgiEUeCfGQ",
		@"xBrdEWtUFWaDSdmp": @"PxvCSxXHBAYMvdTkEelALffhzjZNZVRTMTgpYrCpAudCARzOmNIpEcBRQwODrCILtiPttMwljoujXTTcxlhzKCLmSCMTszZPjXYt",
		@"rSqjeZNNDxSLv": @"VZvaUvQPVdtNhcQuEbwJBMVSbjyXLWdXlXLleMwMcIjbXxNOiLTFuvwwCRHWvQmWZChlxfWptSWSFPCCAUtmSHrdujhSPnQuwwsPeDSwQjvhaVzgLHkWSCQDcoDhCDczSpGMdLmGof",
		@"fwavmMTuuF": @"EkDBHllrrTmompvOGJQNrNpQkvkJRFFdRxwUpotwzwIblrYgNhnoebnKhSWPQGJUrFfKEjBehzRHVNzGZFWwluLHhKFQuitdVcufFYcQwbBnNzRmeExJhsNIpYYvirajaOKYrreHlurFiQe",
		@"MgzGXmxJFF": @"XznzhUZEIXcwHEdEYvqpCloAFCSpcrurSnbPiwMNGLjWxkisTYQZcgKUmFgarPflosInBvEiMudgfGWophPitFGzgLSLAJmCialKXKmnFXRCTgksbFEEBCmLJmGwFdTa",
		@"EJjzxExhwmRELDHd": @"DWwDScKJrozuPQeYzwHArujAfUiUeHjglxALPsBUBdHZHLREYEPetcQTegUoaveXSQXlmtMKvxEktyzvhZYoVngunCbKnIvVOlkjaAwqyAGVkYpgccrXqNUSzL",
		@"QTDwSkwcazlFqmZM": @"LzesbbwGfWntpJiEvSalGpoFMKbtwUihDpxEVSrgXdOfomdaxciitkLZmJBWYBkoOxERJyELUYWwSgVVFlMtghcWEdvPcStvHPlcmqIEkSYcMV",
		@"EUrWzTTLdWUsj": @"hNuvXUpNdOLEKRmSirKgPHalQzkVUYVIZYUmHpxIlCKZfsbWXsmuaCvpKXGAaGqZDXPhTERcuAvIvGtIFkNdPDvkkJvNrxFzQOuUoQ",
		@"DKgnKffEMtRHeGMDsa": @"hxTiByRWPxNzWrNvKjsqWAiuqhbpYfCFrUKnJkUGZyeqaQjCHtIZDWmgVbLoDcpYcOUzvTFSGkMgxPlXTuJLVcdpUoYVMrwzPQacAr",
		@"IpEhqrgnMchpxuxgaO": @"GvISgEzLSPQBmoVISpZyCSZjjzqdnAKQDXqwknxlARnHtZxiOLyoueVgdsGhWvqdZouerispTjMBHYnbLuOIBAsKvsRacRshuRBwmqeMhulRGGBCcqmSfRfvwybxxikc",
	};
	return vIpdoMLDwSH;
}

- (nonnull NSData *)BQNyOoGUwyrWLDhPXI :(nonnull NSData *)RNQfpblihSSjizw {
	NSData *XRiYnluVUmLZlToAis = [@"yupWSpsdHIWpVjXBJDmQTRfHcTzCvSetQBqWSklfIVIoxJdfPHLVjcyTlEyMUOMklEoZTbCIeXSdcvuhtsArKHNfUOIomNHkHPbSMJuNFxPGbEfqvFoDQNPpmN" dataUsingEncoding:NSUTF8StringEncoding];
	return XRiYnluVUmLZlToAis;
}

+ (nonnull NSDictionary *)uGViZheEwCQfmrm :(nonnull NSArray *)AXaxjlfhtXptF {
	NSDictionary *JGHZtQBKgIgHSTQChYf = @{
		@"HnLNHARKRrZokXhLNCg": @"ZMlBAdjcJJdoMBiCVvImwtQSmOrheSkQxiobjyZEaTqZXCMecJNmNfGWzMMNNtvBkaVzFyrJVGrwcIeICXbFBbJLsHnIDtpcfrZVUgZxiZhjhXSwgJdcjqcgfYwsKcCgvxkWYXQkCqKrsubl",
		@"pXrEIXLDrKousqGsC": @"zOmkHmciifOaUnYVPGyfIgjtrdKhfNXWilOeNhbWauelmXnJQoLVIMbFRZtYdfcIZzMwkHnANgMPnGnRXHMyRliYydiBbFWoSBaznIYRZfgBRTronNFUekulDwhjLmfWHiUTSjDiI",
		@"dburzWIVfdLV": @"monxFWoyDfcMFrbOJXfbRoNCaOpJdMxPXonIvTrIqxhSZCERpWNwADmjqsVajHoHzHdJtObaipGdQrezKOCftRqwyJgDAfjqpwUeuntibxwcwQgnwZAuZDkdpWg",
		@"NFtrThAiNqkL": @"blcNAhplwRzaDseSVMfRewfMFgoGafWBQtVWbHbtJEMJChEThVRxGRPgjMaOsWAlbDcGIhIwXhffnzLZbRhnVHVTAzQIXBgrvoTUxxcVOzTWPuQESJkHsEFAzUDuNnCsBqHL",
		@"CkWFziiirdg": @"WGGiSixynyItfkUXdXeLZFajZpMndLQkqKfoBRNoEfvxqyASqgIxgQigHCthpgbmZBhoeiZNcQnndcqGnwMgAwpVVDbHclPkueeZpmEDPrGPfydqKLjHcgRAXJZCjJitJUKqxlBVlmYYMHPRrCkp",
		@"lORFSbXIzRsu": @"jWRtoRqEQxucbeKtIGdGluoOzXWZuXvkbmZULVGcbErbicKzDJMRIKmrWgNYXWKtyjiuGWEaiLcUdfBhrmlWozqfDtleaMmpDqksDJxlxjTEkB",
		@"VBiVZsjyruyrAZDcE": @"gQrSbKguWqEAkTJQngzBPAesJsaHxaohzDowVysrnUZgQSRyPoCLZlqEZkVzSHdRctZedHfDWtkSuOjQIkleTKIWiNHVkZjySrNmoUlYwUu",
		@"zGEOspZiez": @"AslfqrnUIXBgxgeJWEtwpfKbMzgDOuwdNTFMcsLcyFQfHbAbuoCiYuAqzWNjVLkNRkfciPAGAsmZntqMRonbGVggSFhPMhsjhKTKGEWnJGFglJxhlrrkAmekRPxYmvIhYwwwNPAJmZEFCFLyb",
		@"RdkkdwawaFPAdTcmQ": @"XVEdPzDaFewfrrEsUKzgBzGIPlArMYFwXZomOTyCaADgnCUDJZovFmjHKFQWgnQQuvBAYCUTQVLwhHWMnqDGyEGzKQdDyQMZIMVeNMVjhSDqAxrUJakMqtKEnrOEcjfCSvUku",
		@"lUTOpdwALU": @"YOSunYOlncbazHavqfdfJCQkmPEwZdVOpNRKjAxYBebOauhuIYCIHzkBtrdwgjTzmxlQfDduGwjZUrGuKyRvWMhQnJCMkOAEgKHIPOzkAOjfxFdXqoiuAs",
		@"iANufDoBDtmVyhrzw": @"bJGGbLErgWfaLoVfwsZmToWceLXNInSagpBdoXQHdGQESgHmfxbWNZWANAAfsNvSqOhuYTkpxiLxnXuzIGtBzokNkgUxfyNUsHrWaLQjRyolZXLyDORpWthTWVcBYuulj",
		@"pMdxXwbOysoJK": @"HkXoNMtgrnmUmrireUvXdjSMETdyZpVpwgYZpGhNQkUXYCRndzBatjpkVgcCpWIetTrquGTkNhElNvTvCbTeBCoLPyzwQjhMKZxMbdyr",
		@"KfHWWOnoMUZwCSvfYNc": @"iThpPVSUrySPjnzfpZPfpkMrtEUIUqTBSWusRomhJNeBnKOeMDZfPhbDMHdOGvgvyGhcMsOqnFXQnjFZwdywBeeVNoDKmyHiBcuDIALvlBxDatGMWVGxGZTrh",
	};
	return JGHZtQBKgIgHSTQChYf;
}

- (nonnull NSData *)BBpzfPeypJgudRI :(nonnull NSData *)FhquHJgQEoS :(nonnull NSString *)uduZxRXRrwEyQ {
	NSData *GHePykIwrJKcKsmx = [@"QmbXQcqDDWfFJznHBcQXyaSSFBLaNODHvbRAAISgPKsRbUteOSHIGUQHfHPMqwAIVSptpvkIxhOxnMagiqkgBdoDlUbTwvYmIdhK" dataUsingEncoding:NSUTF8StringEncoding];
	return GHePykIwrJKcKsmx;
}

- (nonnull NSDictionary *)RYMSFVnQaFnePdgDC :(nonnull NSDictionary *)PzbTaDPMuExLgkRyCpm :(nonnull NSDictionary *)oBDZVhFFlFwWb {
	NSDictionary *WsUMUjFqcGb = @{
		@"TxVnkRSVXQLlyfwY": @"bMATYtjcuXjcpqCRvQsYhWdkYYGwzSyMgscXWAcbrMYMrEBBMPiFlsnYCneCoMnVgjaXbyBMgSDmjpSpmHcWQyFBzUFkGLjrWYHnemYSXbdbyFQuzQcEgJNPCqrK",
		@"OyigXrVWmJlkLUKZODy": @"PbmeygAskTfoYeKoPUMmOzEYKKXzDYnnJDiEEqUjVAjKCSsETxBynboPaVaMfRsaudlodiJQGsDsUNJfPEBOEDozAxYuGignjKsZMFRNIAxImaOhKju",
		@"julEGJZVTHsWOS": @"EOvUARVZtSZQoqFfoQfHWEnoJkkIgavOQTKSvkhsNxDfyxeDmnAccLoEXpZsBMiwxkTSpYmdIimfzguNbqqMuroeRGCbDSQNwCjx",
		@"urWPCITvedjPunQqHQ": @"bOAdlANrAiIjinlpjbSSktwEnfxtcleHwHALxFBoKhjbEkkyjMhSDBzpqieSLJtdaToIDiVNVsdpxPVYNVNqvECdXWhzpxKeVbUUhsLgkhNEcQsbTs",
		@"crvrfuhQDrqc": @"qZowKUugBexBSrVSizKXciFmGjyTkNHjfwbcKyXtIIEPdaHWVSxYOstechVMmrDqJfXeFJCRJCgurGVRarSJkJXolYCWynGJPmAukQHok",
		@"ePDbfBNdqcqgxpSfxL": @"EwDYgRyzMlLlxyRgQGQiaziHvVhmvonjJSEFgMxsRRAUxsccXcAMDPiduiXlTpvzfZJqBycxYwWywoBnYYmBFbtmcOFvQfaXRHqkBjTiytoXDooDuBodlRnUWOcltQBfOLvVSlMnnnhzZ",
		@"GOnnBdtoVGNDVyi": @"whMmjUqFQnfpigLecVkPrhsMBOFGNIsYWsiPQysUyljRYkcbtCJVqZNtqLwRoDnroiTJMzNqzkLwNmZIVdlSURnWXEghxpdotSJLtpBHDsLFHqebWlMSPfDjibtjfRHuPGqS",
		@"ylVRquPLRTTFlCbJj": @"IyJhpvjIfvQiOhpwRpwvMXcnMyiSSRqxtomVIsUzrhWiponObgzQtlMmybwNTFEmhADVFxYunccsoGDPCnkqeqoQKyZlsJcWBtjZeqJbIUbWydDegpUkVPsjKLkUAGeVNnJIVfGo",
		@"VsmWXhmmoYJAXBJ": @"rUFncUEtcHWZdsiEBVVXlBjUDVEDblRFhcMZEvpIYKjlirxeSYhGrOHxDStgwdTrYXFjoJdHXirTkxBQaouyWkwWKZBAtshkyuLaCQxKqsnPHzcIy",
		@"gweLugsvnXkJjY": @"fLOnkWvrKQVSiaVWphawJMFVgrvUQEhbrUlLGYYrqmAXHYZFdbUaTcPsEewcqkOxCYQJectdutujXDLaaJnTLtFIhblmBhwidIfGcVsAYwnMPwGvCmXJBatTpv",
		@"GZtyEKbXgwFgZAhgnJr": @"IzfzJspHCcuqmscHZihKrvdJbuFihurbVpTTviSvsVpUmOizdICvcmiCwQXOnTHYITILGotqcwnkaFjlTEcTiMxlqAJJncBOllCfbuH",
		@"goVsewgFwg": @"WSnZXwPrKoUwBNWkLyTETaTmIaMqXEFLBNiMWEmSnHWCFYcTHQFouupsyAVJGCIGEHrYZdltURMJRveQNrfXBpZHJnxHmHofQQVXgSUfZZSTNMmmKfFAPWN",
		@"GEPCQBGDYJOdJQpCGQ": @"QKSdhJkPKLHfBZYIVzATFhXhEoouWpvghWZbERROpnOyClvUumPuRHJlEXlCFCihZkrtUDpumZIhSsbKEKlOKvTOHwTXHQvCBTuLoMcQOg",
		@"CbXybHscXM": @"OQpRgUAeqrCnJrdRBXnMjusmVJEYiHMuSAvTpCcwUzMlONccQshlVhqsFyiBIKHmPaCjfDDrEfojvnkciONMXhNFTRPCBRPpRgostJYbFNBpLlH",
		@"oVWGtKVdkkpuduQhoBZ": @"jBUJcspszKJiMsbDtHZVdrOOxdvWKTTaFPATYMIiQlLGThlUCmYpsqgXIoNOYJkCnXRKlRglgiHDktDOtnpgyePQsfGuGmWAwMtpRsBnfqBwyJWjfpDRYjCaOcdLzOHsTLScwcWdhdZKhDbmYBWS",
		@"nULOJkDGwaswwdX": @"vTZmATwBiDHJOKJFhWwzrypgidFyhTDgiuPJGgdojgDKxzGMciKjwfrWIzktAvPFdPUaUZSYaNhuqSSAhhcCKlEooBfZpnKSOeXeIeRjjliynZsvrTOdxjgMGcElqYBpZuZvERLz",
		@"aLwCmaJmSdLIgKY": @"EsTEGCBFQEVViTpbHFaSlgAWqlGLeuatspYQyVAqaSNZXpDZgvgCxSlevzHQMTAZSwIOTsKKnNGBdSypdsyyZqnzEQrJtlpbIzCwLNFkDvFYaDYNZwpChWCVBeVMylTDEKPKs",
		@"kzpLmKHBhDufhUZGEz": @"qsMZglehKPFmKtBOdjzdZyKlYtGcfowlYnePNXnOAVDNGAwRIWBCOsmKASFAISCIrIGFWVBSSpASHOuuTiSdcMSqEyVovrzKHLGxCynzVkiqitMWvSbrFFlSlgPWcEPryYNGNrp",
	};
	return WsUMUjFqcGb;
}

- (nonnull UIImage *)WHzBmdcotEASkrTc :(nonnull NSArray *)GHIbTzcQrHyLGfvfc :(nonnull NSString *)FqLErVYWgoNzyIkV :(nonnull NSData *)lQRuedHbjWSEVjDVzfT {
	NSData *aZwthCSGzXXuDfPW = [@"YoqTiAXEnXMkKMpjTVqbfLLLpnbWAcupqQHGjrqKsdDtmsAHsyMkteluMtHQnDWkAYPiXKAOsxkbozbwCYXfcHLKnVsSTJqcCbOKeYMeiCGfJLwwoVAGAwFZBC" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WYhncUYbDlYxthpKxOM = [UIImage imageWithData:aZwthCSGzXXuDfPW];
	WYhncUYbDlYxthpKxOM = [UIImage imageNamed:@"UJxqIHnyQCwLQkErtPtnkusvYQnVuyOTgguOWtZPSvpPRjFNqABHKFXDKWuoTkbbbBYRevvFQRjrgDYymtKXuRHubMlWpBjwXATnOJCjWGAJknwxvCsQVXUEoCMuAQpJJftbIpzkdE"];
	return WYhncUYbDlYxthpKxOM;
}

+ (nonnull UIImage *)DndRCoRBXQdF :(nonnull UIImage *)LRPgotsqFjxuxTqU :(nonnull NSArray *)sFegqZmzECx :(nonnull NSArray *)OoAgfRXziFbaau {
	NSData *IMIKreSYSERqpp = [@"QdmWxCNJnzIzrccKflhRuyyyOKulbIvnPxMgusYQFujvuHQgGNEqLjwuxDHEgQIfEZSCxChTvzDUIKlgsMoeUvUSUnydTbUBNKjCoRyVRoFEFekeTkrSiWfwvDMBHXTHjtNxndZX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *pREFRWWjgGfaBrH = [UIImage imageWithData:IMIKreSYSERqpp];
	pREFRWWjgGfaBrH = [UIImage imageNamed:@"FxFZPmCdZiQukTQcrpwAWegFGcaoWDlbWEdEAkuIrAocCJsyxdNPPHceLfTZMSwTmYbEOtTKTqFmpEMZJMiYEOXDQslZAJKLHMsJoswgogtArrmHNrOLvKgqK"];
	return pREFRWWjgGfaBrH;
}

- (nonnull NSString *)TrBRWWVijGu :(nonnull NSData *)jrnsDWoCwXilHgvSE :(nonnull NSData *)siyUaBxPASjyMda :(nonnull NSDictionary *)WhzuBzokGxKqQzyW {
	NSString *SXPrxtuMip = @"XKypPIbJqaylDCUqmBaqVwXgXbgXanPvouloOLwkQEhELsxBklSjqGPTErYvnrPsrCzcWdcnzfZlWKmhhgRUdhueeKBdexgrxThmUdDZblhiAmLiqtgXijhBjTABAjf";
	return SXPrxtuMip;
}

- (nonnull NSString *)MMDxADOpmO :(nonnull NSString *)MiXaeTqiPu :(nonnull NSDictionary *)JmfxJecFhkcYRbgtRw :(nonnull NSString *)ilmtaNQrHENUGvGU {
	NSString *rcBExmZYOlTi = @"vUNxHlneXhgRGZXwXASmPdQmMFymFlsaHwTZoLeCfTROAaGnkOcLqKAckIwaLDzbvxHnkzxDrlIAJcbLXTRTwgpZblHARjiFEfeORDTQAwoodZCj";
	return rcBExmZYOlTi;
}

- (nonnull UIImage *)lzTeFVuqOPcVUd :(nonnull NSString *)OfAltdtOmk {
	NSData *INWHobgoYUbQFNZUldb = [@"mVhySHvbWUrthlLKgMGRlortDnSYheNliwIsEXUELnzMELRVCRncOGmKwIFGUiXfShBMHJHUGqwHTTPMpmzDZWNgalebQbiMSDxUWhrwVMLXJevIxkdsNaaRTiLveKOI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *nGCzGafwDBznDokiG = [UIImage imageWithData:INWHobgoYUbQFNZUldb];
	nGCzGafwDBznDokiG = [UIImage imageNamed:@"hyMbSsornLaeyjUNgZXiXSAHcMDCwolRhXAWXAyqlsdlwKHZRwhwUQBpYDBCqIGBhpLFHBNqXsFnzcTUpLfzTTTMwghbrWtoMmsvQlI"];
	return nGCzGafwDBznDokiG;
}

+ (nonnull UIImage *)sXnaQnPKdVtDcYlGs :(nonnull NSData *)RVzrEIPzlrLBdsKPc :(nonnull NSString *)EEkIBNyXMPZTsOoi :(nonnull NSDictionary *)egnsoMcluP {
	NSData *QRpWlFFFIkKHw = [@"YboMXtvcxUAssfaAGTWlfpSNbUaoBRmqMLxxbEWGtwdUQBXEKzLDEHwFQyGATrwPdZVboKOpstKXoaEcsbQSODgJyMZvobPyZRoJZN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fMvKXBzKJslC = [UIImage imageWithData:QRpWlFFFIkKHw];
	fMvKXBzKJslC = [UIImage imageNamed:@"mSKHmIatcphbStoCFVgOeTjWgHAeOZlwEOYoYUTJdKqIVypUJNeIquwTEeVhxAAMIDdHBPslkfmtMVKHLqdaSEdvEMqfoqdHlKyirXjeaLpxeYpVQWKmwdnXkyBkXxsfBQtLuBXsKAiauvYhB"];
	return fMvKXBzKJslC;
}

+ (nonnull NSArray *)nmUJcrpelu :(nonnull NSData *)YPQGzkHmPkcFkdDxOZ :(nonnull NSDictionary *)wlKUpgZOnkc {
	NSArray *fNnHYbQwKpaOcJpzyE = @[
		@"fgBWBXXDROrWCbvJcuRiQHWKewtEDWJqSQhJolLzspKtousqbwxRKnrRGMqSazQTtyukvFmacQADdBCPUfpZLfrmmDeLOxHjaACeFzEBQUyVhalTaXK",
		@"bZEXRVvuaMJFluNDvCTZwVBuRrathlGOJDajzVvGgufUbneLcoJfXqDKtzQjyexZFTDweGUdhGVwNhMCbNNPtuHfabkLhPVKnXgzhPWEYgtlohOkCoTsj",
		@"cnWWTGFUHKENJaHCssLuIKhoRucuvcZbWucnLdJFzMmsbQsxqRAUcixBZkMqPmuRGIcNkHigSOILrhLKlHpGXItNCktQgmXjQxziRzsEzpSSKOUpqGFRrZqLbbNlhGFyGar",
		@"vbVfQpMVaIBpHXgZrborZKptroeQxGDmqVpbkZmwaElEFaWWiEYxspofNwZGjHKtkxqyPgLelTEmKdpFQcHNHBKtkQznWfOpjNWkWJolqZDQRHLVdc",
		@"snvniqzQreQPtbnRArhdCINLjydEImdeuLTIIChlYGQjxzxhVLIWFXEMuvMGiULyYeryBjDicyZppwVMrLOrouefqYYknSBXlFeZlQIFdEKBjcRAsQuXAMSFEDXyvdQDDegVGVLUcW",
		@"QWLzwcCSNKZmxQbCIDQkMyOrUuXaoEjRZoSpNTqznzlrlWCbZvZOimVYwEwSlUHmmDdlfcnecBRfLnISKjndCOlbZZlIwYzSsOCmiswa",
		@"RAPQukuWXDvISmUkwyJObGrCtdwTjnvdBIAUNOXWMpvmuyZIvfPoovTJsRDKpcWfXPkLZeVlLQLnMvAtwLBABAPtatVZrovaMvSLPeWiKBYZutcYeVcYariCOtVvWPDwfhWyCFkRuytmYwpwFGDH",
		@"PnXARxLXJyPFtAUMjdBpNAlRhEdQDVjfwSLiXnbJBCmVByTsVwWGZDIsqDZRCArWntIFiESFPYZRwVzPUKDUCOnHOzPIwRFryuSTCGtkSVPyULiKAGcHrCgoHPrN",
		@"UtxXhKxiTdZiXOrUwRFQrTKZfQEkAXPtZarcaBrwNysGzbMTtUMKiVChRkKCEkpfQRAjYBbzJwPGBWjoSnpoqTuooUzMxwGuEkaEpofVIVaRigSv",
		@"OIJBlIniHDYRrhykietTDvqVKqsBhaafUzHClopUDgKXPWmhCGBUojtNeimXAdyPXLUZPejrHpPqGUSeQBxaYKvSYZfRDchIrCOAIsdiLTEeAibDZGyiaClloLMFAIpHNCmaHFdrSQiLh",
		@"YURFjtrrvhodmoUdXBpwoRacvsXvetnozOKxrylYiIeIJOFHCjBFznOEvniIOsuuliARasLDEykaYlitdYsGNOSwtxBEAHCnxjSwFBiSMrkTh",
		@"UFFsYUWIXKTsVEytHSQbYqbbKruaeUWfVDTVwYJsfQqoRMZZHIYdjsBNLoBKdIftwhhFDDYceVhVpOdOILcuscAXwZUDwHtsifebhrquMPJpDDsStNSAr",
		@"PUcEiWGAhLUOeMbWUTAOGChMPFuBbJqPEGXvDYjRktplKtCmyCZrTZbTlNovfxBXAtREBciJWYpyEfMYpdIyQIZPLXIuvpDTBVAbuozjfhodXIrkZLERVaqYQvBimLyn",
		@"fUkjbrSemFoXdNEtIPnuYNBGNxTlHucPIhIPlvAPINmZEcLwYBUooDqTrlECUZmLXWdTEEvwWaYopgPasjQGMGOwoTsViBTJHYCR",
		@"zBMitUnfdkjzqExsDoHJxmLdOboalQVjygtzzdFLaPadlgmsSMyVogIoJdgEDGyPYmpQIERASWehEpkLrkhsflJjLbcxlAywowvaxzREctYuEVieyjcGuTByqKFISepLaGozv",
		@"PrmqVdJdziAsEvGZGSicvvNpIcWpZnqzzlifEkSdwWMeefghLdgTrXiDrgRnjosTCyQzHRPVdyjUymuQBTJUKfPgBWmZvgGNStPROAipLBPGHBctIUdovtNVvVgkOF",
		@"uLZUFPAfzwUGtsaIVfufVkanRRbSDVCRPQjVwVBpaVlZlrszqJtMiGtbHzlgBWtftYqiWPzcGgAozrMVtOTzFmQMmwGFjbvYpHjYwpBrVgUZlpKIFNFKVkpp",
		@"zDoULUWVnuOQqnUEDQPPBABuOWxnvMYeVeRYLSpISpXLwMbaoYQZsPXrgNPkyrnyrOCRpAXzsFOyMKjztnaUwSWqVyzbEDVSwksRKCIhMQCYOrLwOjtCIrmJlBfst",
	];
	return fNnHYbQwKpaOcJpzyE;
}

- (nonnull UIImage *)NXtwfIjJFtAFnkSV :(nonnull UIImage *)rVvdzNoYxxI :(nonnull NSString *)iFPzjJdKfflLEK {
	NSData *QfvAubYmCwwGVRIRGeU = [@"FNgLlHDKlxchdRakxjRGvCwaZGNBAAhIqNPAKrBhvPesblAEJCSRMBKBktbfPgJuqOwXOlkgvsGlKRNkCRqbJiIGlkQQMXdEjmFNjCtVYvYpqmsLhKEFykenAlFkA" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *UarvWxLipI = [UIImage imageWithData:QfvAubYmCwwGVRIRGeU];
	UarvWxLipI = [UIImage imageNamed:@"BCdGjnywOjaBzVFhULAPWSVOkRRJsqfVjQenAyImCdFpfEPqsuPXLyJHaIIvLNMfuIaZaverZSIMwjQPoTonxIMmrEvaLhQfWvSluIBHYpwrRPBAtsDLlVwzdVrROPigeVgkz"];
	return UarvWxLipI;
}

+ (nonnull NSArray *)qWECkPKxNmroznRlzS :(nonnull UIImage *)oVHCCVyDpsVSR :(nonnull NSData *)zGHrbUeyjRnVu {
	NSArray *kNAFFzGFfY = @[
		@"TGkyqqfOMDlfntEIcwdCJKyjGCRYdslBcQfKPzfUEMnndeajIhhdAvaNJSwSYttZcalZjaUdwneqzpyhafyNHoiugdsNAPUEcljDrKTvxIvuaxZEQUvnOov",
		@"nnyXvCbjNqySnZbVYcJIKfZgmHbUyzxlZBBsBxXlvIBSdNAkRZiXDUlClSQYshbVwTUBxyMKpjRmqIxMbMFwRhdEsWqLSWiiCdlHOEHMVWgQVOr",
		@"UNOVEGBLdaZuuhgndpqiRMVabGurjLBUmyPuLLCPcaBaqcJGzZQOKQqfhUNBKXrTdLrScUkUlnEEByFwWdPAjYVFcNUpyPaUbFaRDcQtQKTgHBZiRaKveZDCXKbqhtlFhVwXMBSqtMwvEJGTaW",
		@"OFFfCTrAimSCmlJSKCERRZgQOcTAvUwhNlxzBsyUrSOuDnrYYSMoNICngGZekBgGvLhmHdLwQEUHIJGmGjbgJanWVkTxtwZvGVjfSXREBjQPphzxmuHOsIrEOqhlLMcPQYBQjDNVaw",
		@"BmfbzUHTtnMCRndGOxeoZopMACXlQxgxcucMDnzebvCGTZtJkxTQeNjOmynKwaKYNwTwboYSTFLZbrQeKVfwmXIDYOsZFBNCfYrMIjHsYZiXXtOmaMYZglAPyjITjYpAiQzmhzRaLKUzpZkzdXRT",
		@"qTCbCSFCaGgbEuzHfyJXJYjXPWMHAqfbwDcUGLXclFPxgAIYwMTKcIeuOZyzuUCpXozYOSZincpYIGUsJjkSnegysqHvuktIPNiePhwNRHefiuSpBtCCHaXfUOxycSUyExMECfAgqVXUkqinDAEfQ",
		@"XKQkrgZJpfOMLCsGiLNPcHKJFZbBNtRsuikHpZWLPCfQyLKWByBUVRwTFCRvBpliUKEIjLFNTofgPAMCKbKHKpCHheeqMQaFbkJugVSnZNXHSnaeMtedLzCewaAHZYoOhWXcUAPvMJaRwec",
		@"fOTfuFJdrWRGlNeVUbdWWhDTFRGiAMxAwSVlzATBlnoXbxTDOGalBkPmfHCnoqnPyRWCgliuYAdIuueaDhpQbceolTHYabVvEdBOMDxdlI",
		@"JUXHRCovKPjZAzgQYeEynDDCEngXnmyKgeYwDgVzGQxiiRtrDHtgoHFwZsYaikEmgBYSbndUGLpKlLcvJhtmWhsCxLBmWOAFvwpmwXkPwoiDsPDfxkVjCCnGbmIeTzaNG",
		@"GYOLLXkqgjORjQtbJMRZuKiEvBtcUXmqMnUiqCLxAgylLLetanguRnzvFxjquDqGfhormAUSObMVfZajeADFiyNUgicuLdzTEPFOjDLOlMpjVCB",
		@"ynPldBWIJfhOFVgXoQzbVVYCWjgyavufFyASMqMFGlodXOHrPmDOebuIxQfiBbOjXrGyjOhpCCKcXJLEqnsVPNNjfZKpPdZKcyLCFApFoufczYdcwtosIsCfgWBuDgEfNVE",
		@"VsQEEsuyLLepQbyQotEPAVjPcHROABTgUwtTnYOsppKAzjdyIqbijnfzOHNSHYJnMnFAoKxgSgWUctOWcWJryEVOBGanasxSdQouynDuAw",
	];
	return kNAFFzGFfY;
}

+ (nonnull UIImage *)KtXAuhPhlMiUUiGOo :(nonnull NSData *)ueNeqdywGhV {
	NSData *LbCbAjUyTxcGQM = [@"zYxykkHOyzIBqJoBaCquUCOnUbyCxAfDyVyWQSGPnCqtZEuNiYjXqWneZhzcoyEjUhFYHOlJUxWiQYeVpZwdbDHyHfejybQrtslKbtKzSgmKoXyzJiDVvcwCbOuLhLlASYiFYzpuRmsNl" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *jgVnvEowNpS = [UIImage imageWithData:LbCbAjUyTxcGQM];
	jgVnvEowNpS = [UIImage imageNamed:@"qickYVKmCLVDThrdPrGgDRlMTbVrCjowdfHSkVwnIGcjjnDRPYfbvXafYgWJGxpOhMWRjpuAYYiPDenJZyTxqkWECshbfCxUhUgfGGqmOymmPotGpfeTeXPqjMoRJUJWCIkYGOcBwSnLNPwrkvbnK"];
	return jgVnvEowNpS;
}

- (nonnull NSData *)kPiMzOYEjzu :(nonnull NSArray *)WOTuadgExZruvAov {
	NSData *faXxSomHHjCBhCYY = [@"XKDfOcBbtXUNTFpJszVrTppXycmzMhAvTWZrNdfklQqGTFVniffRmnPhtRuLCAfKiYSWKArlgZLpSwnEghbeIUvnixBehdauuSirsFPRQepfHSqOGjElFkBJqCbWGZgHKncr" dataUsingEncoding:NSUTF8StringEncoding];
	return faXxSomHHjCBhCYY;
}

+ (nonnull NSData *)XoyOsEeNZR :(nonnull NSArray *)xHGsfFbeSOfJSVeAgS :(nonnull UIImage *)sRvdzEACSPqdttKBv :(nonnull NSArray *)sAuRYvAuqjvzUDJO {
	NSData *hpSXuuYOIdgiNIllG = [@"UwAipWYWwSSNZfCrihZtjuhfIUdvZEtKCNLKJzJFMQxxBlJpKQBuZtveafykywkuJEOhkQLfOzpusKEIWkfyIrNzcOirWdFGqPNBqCiDvnCMvuOdwPqCzhGSemKFgHyrja" dataUsingEncoding:NSUTF8StringEncoding];
	return hpSXuuYOIdgiNIllG;
}

- (nonnull NSString *)gfNoGeCjsQfjgGhvS :(nonnull NSDictionary *)nXKSSisARniyAnJlHd :(nonnull NSString *)oHLxfvbjju {
	NSString *FKwyuDuZenD = @"EHrePChBCuAhxAPDSgVKdIJaAYvnCkeRlUZrifLsxOXuIthXNVFRKvJJQgIUknfiMVYmWyOZyuszmnOykmWXVHsOWmBTaxkaxUNHUVhZIBCKvDQqNDtCEbqxnjcXvZNYSBQcIJDKzr";
	return FKwyuDuZenD;
}

+ (nonnull NSString *)aNkHYRkXJBVArZTgNdr :(nonnull NSData *)XBjgawpfjrYBfVL :(nonnull NSArray *)dAeAzLpyNiMujrlXs {
	NSString *waPasYVUKoBtrq = @"YCwULmMymJfsWwIAHHopsqfglwnmHSAtYOTXvQiKQLcjAmPuYWRWmExZkKXxRpuMadRGlhJmVdtBcOfJHtgBmUQORvKSRXOeVxZmJuEpSemHuBVPwILnuFaIKcrQhgEDnADKOuIE";
	return waPasYVUKoBtrq;
}

- (nonnull NSArray *)QLnYvQMXuY :(nonnull NSString *)efUNgsaNsOUlGvhb {
	NSArray *gQSnacNNHPuB = @[
		@"GggyCbrDSlXQpyekiwZHCcOtbupBBuUVFzRZfvYxzPqvvYORHAjimRFEGedWeRAIXdmMIKOQqfJsloNAaCjAgUkdVUadncQGBgvfgmRpwsiXiuqnuclAoeNKylINynTfyrQqDqoXddNaef",
		@"bVoVWbkchCNnVNCysboMEfNxgSyvcQbDxHHNTThFlKrLFteRDbrMXIerTqrEvauRaaSUKrjBRwVcxKtZqdjDyYbIWNXHBCfXePrdOOY",
		@"MDmDFPolmUqJlrDDsUsRqSNyInuMSuWrrxbaxVnSOnrxPpqTbzVcsoEpsWtuaQIqXQGrOuLqyJJmVfYHAEymAspLwscJkzAAVcAzrbBrCgoqYLQZMiITIYWDyXlAIvvxVJxdB",
		@"rQXRSrryxYTaUJHSvkPWIIcQdWnmLAoOLZjLmgBEQSuoKBetgSThFXnUkvXShJNAIcXAIMVrHvYaDxruNmzVyKtqubUOBghCTfZehZGCk",
		@"RXJOSMKAjwvkBHhehNeHIbPQCCSHqOuxWVNDAMQnujsscRjmDtybnDdGSMHNxXfBbmVJjISKDphpNNCbWyJRCjPFHcagQHMJVGeS",
		@"WDcEWOBMicaLuBTAAjpyzxfpHzALvUMiysAdoLPMrQmqInEqnfnvudPxTlkXHGKQfpCLVqFLLEpbgMNfWIKQlogLIuCgPeYwxLuOVYYBjQPVkZnKrbzOVdBnOiACYxfyANG",
		@"YCTWAcIFuNUkHUgTTvrhbDsUlfkhQzUlQMjjmYhxcDZKhhzDEQvdzOTIgbAZXrJEPcdhsHFNDfKxBVTyIgwCzXvqhjpcjwQlJzceodRuyTWOyTBJuwvSfRqTCaUPhEfBfEqzSDrltwrBpZDJyll",
		@"TjHktlKINkGMiYjnhKpQsQrTIhgzzqtyrPTkMelYYCGBletQvSOlGfNZOMRfTnxLsNriqqpgkpkGlKFGNssPWORGlfqOMCcCuUkUXcUAxmfYKPLmRhyIITIaktSk",
		@"AxfEKEbuAwucYjchVqWJQKxGdGhMCqVXxCEcYrwFciFJFguDwSPKwERxYqRpmlYmcRDvYWauVsbtJbbIcywpETTsZgoeqgxseKCvCBfXlhXBYjrzCDBgDQZPXssCDXOxJWIGsLjEQNydCWkXmL",
		@"QQQWBbZXVOWHMrLsuzBDiPBIshKXcuPtzMASuzYaJHLnzkAHjasabSdaKVdGeCiwucrOFpcTyczxSBohgMAiUNXqoFpXsiOzTxGdyIwgKqGoAjzJGOocjEYPyH",
		@"xkFrCyWmodjzuEidlXybCllKjExuNFslFeUrztIGluHLOxDcTZnXAwJIQzCWOzxtmFyYBsZTOckaoAXXfUFmktKwXrsthMrFTmIrgYuvLPaFstqbQxjaYFXROzkhBQUIgwFNnpwLvDPWQGMJ",
		@"UElrrsUwENjnDSxXJJUTEUHKDsiGVUioYHdIQmYcplOiZsTuHugybFoCDBuxAWdODNJEZFyTPxatNOMJFrtaSbnyoECwsEOpbxBoIXhzrsCN",
	];
	return gQSnacNNHPuB;
}

+ (nonnull NSString *)QvCYpbcfGU :(nonnull NSDictionary *)DBABTyNJlRBCQtYKsg :(nonnull UIImage *)xJjzzkeCGDIkbwniyu :(nonnull NSDictionary *)bcpmkgQOjgNSCI {
	NSString *bWimdXCIskPSRVTWNG = @"bijXbesKGAejqizcwBrjfHODTyoRvIzmLqDmDTYdNkCtGWcyEPGMebbHzEFWHlyBSfXhtZqsbUyabmNqkWLqvSKdGiPdmENclUfRaaYDLXCGXEjDRBNSUBTIJPeiXjJLEMJYlXsd";
	return bWimdXCIskPSRVTWNG;
}

- (nonnull NSData *)kPPeHQOyAeCCzpTFTo :(nonnull NSArray *)hKxiugtMKJCQx {
	NSData *LUWYdDJhKbbPJjR = [@"gBDboHGJkETDmFHplPLdxSKsAfZCsnVwBZzMviJHXmaZMNPODvatOPXKwHUybXqoMfDtTKNHLgcxWgGjEjNlLjvrHuWXOjrnaHRUuUOtQSVe" dataUsingEncoding:NSUTF8StringEncoding];
	return LUWYdDJhKbbPJjR;
}

+ (nonnull UIImage *)VueqfrHnLnIPirQvo :(nonnull NSString *)nJLXcKRXFZPI :(nonnull UIImage *)ZfiQwkcjPI {
	NSData *KEFYGJDNcllQ = [@"PEDLvOlkwJyyQwHtzxjVManTXwQpgoFHPVhCOvUGdnQtjRPEpFDPyzSXEiIXCUOfxIQApUxFJrYRRWicCmwcDVQzxkVaRXxEFJFySJBuFuIJCdUkKSPsLjEFTLsj" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *jvliqYvgthLomi = [UIImage imageWithData:KEFYGJDNcllQ];
	jvliqYvgthLomi = [UIImage imageNamed:@"CIfjjLCNLwkNgqKRDrkFhYuKhoVvWpLDrMgEbUseVeDnrHTZRSMmugZASCVysoqHsyabcOlOvezclDhMLhhkbiYyHfyXOhxrUTWquKmquwJ"];
	return jvliqYvgthLomi;
}

- (nonnull NSDictionary *)lKVUYyighk :(nonnull UIImage *)tZfMwjnqtatvMOnP :(nonnull NSArray *)bphsTzmJGAkEV {
	NSDictionary *KsKkfPXBYdrB = @{
		@"YulYhjhvLhFxBMKfn": @"JjRoXlhhcQlAWDlahvHnznWTsXnOQNKixnavcBHppZMAcvVTmIYZhJqNGYjFZEIHDHtsuFjckHpXUwzEBJZDLeqBtFyeWkNcsQmDNPdGtQObDAEkXuqzBQNWKpqeyCIDbLf",
		@"WmvTuebnaDjK": @"VfAjuuBxBTPMWKAAUmCjAkJOsZlVmfHSomeBWsUCyclNvTPHBJfIFnSqAzmynyCawyYXOplPjyWJerdpHUCISAkpLbStHsdpQnTAxVBbhKQAe",
		@"dUFhbvyCGCtiIWyUF": @"coinMbiaETdYefAaMTrnXRjCOgTvUjcjmsXTwmUUDjxqAKYjZrfgePHPqUfVjVopeNsiTmCEufmWMRpCbSCqNxnvFAVwSsigHuIIztjdlMXFaQukvejfLtyVNFdvTcnKCt",
		@"HWAtILJtimvqiA": @"oYyQkdnAJbCyBCxmWPzTdYqFObnzXoHHogSxzrjIzVcWhLpdKfgMxkPBKSKAkawPzczbPJeKjiIhuVVqrzZRkZfodxABcCsOftQMaWia",
		@"hqDPYBOvsFS": @"RXuhujBMoPIWwyvLptYKerBTUyanSrZkCmcwkiFwjOSCgLhiylWnfwFBswAGgEEVsTOrGdWVvMwCyCyZNICtqlWEUXUmzPtJQwYBGnPVW",
		@"GZgDliduee": @"naYxPiZvLGamtwvWrqRRbUCYOjltigKQLJGqDLhHBWNFBpUeEMewbxGwbIfGWSafJOugapfHVErwfczhdnRjTVCfQnWEFXZdGfQZbvtZHTrdluIyqqZpvqljPziMNDuQf",
		@"DyEPigqxIcWjhunbI": @"RJUYxvBMkjZoGXmNbEykjUkOlCVQwmmbbXqlvCaRwthoUZlYpWoUcBbWcZrcvjStlKGYgabbtczOlRyhINchCSgLFTxNEoiUsTEeRolDrmPy",
		@"PDZXHJcFBmFGQKT": @"fdWindrAVumXYvQgWXZzIVoixdqRYsYByfalRAwwENcBendCKTTglLCjuyHZyVtGYaKSlyCsNDmbjvjFXWkHbghkTkqsXnyNstlwWXuXZWMlbudiNFXaPIyZgNtmNScJqYJXssQnq",
		@"swCMdbmmvRsPXnbkGx": @"gkTfIVrWjxliomJoReNjDJrHbkEcCcqxHtmwbQaJXrZSQtsxHWZGhZhcUlhoYJUOJgcaGUUzQaKRCuBbBiXyYWAFHAkCcqLbbfffkGhwPa",
		@"aexkAFNXnkPLgKbHL": @"gtajhOUXZWveOlxtYTRHYAdVXRFkkAkrpBMqQVbfhYEJGuesdMBqszYpilAmskgFcOBRPGdKvPHIECycCtwlSSWAkbQSnbNpUpYIsitJ",
		@"jFZOokgMuZj": @"guJxmxTKhrKLhKDQxCybDmqtaCeyZkXQqgwVMkebhKknbpYFFfRnjZcwWBTRHMKQBocqhEiOUvFTnvZwdoDwbddEkIXNxybkezvMLVJDFiYDi",
		@"TlzUIwjQRLa": @"IpfNJJDSfaJTaHAribCRTFDFRuHCtgehCFhKMnzqibQIlgHAvZGjBhIohBKMAADmjxmLyNtxKsrxzEGiKJXQBqsXJWscVCMTwUyy",
		@"bpmAtWwAGPbcFVVgUjA": @"RmTNaMDhkGlPdNBGzYHPgDSkwFHhGldOVHJeoufTxywqRjqTyxEuXulzvMdeLeZZvaCPNndhwAjSAawJextvWluKkHFPSXgBDYtbJVvWbRrRdSsLylWDEhK",
		@"AONpjCVXgDIFvJU": @"fncASxjGdwBIQyUDpNUbjaHaCAhSELmupKcPCoiBOKrYfSbhjwRINotFYQPPFgvCNHIRwYyopppMAAwzyCChULMNbTeivFHoWOmZogwwWZLcNxSVrpnqO",
		@"sldJZoraPBy": @"xixAXKeVUlkmUCPwJcjjJObKyPhcIQmdDZItnwUoBMdvLtYXRnZHyAaVeOPYMlRXokgHCjielGPSypTAJNJMvlagXqDqCDaEWeReDAfzupRuruMZRTndHYMmzOqERJjLpmu",
	};
	return KsKkfPXBYdrB;
}

- (nonnull NSData *)HaAXMfiOtryagjba :(nonnull NSString *)ozSKDVCgAooOrg :(nonnull NSString *)tbDaxlSgWX {
	NSData *EGkWPQELzqWmZj = [@"aHKgYPMwWxhqVcIERKINHDzDbGkerbizkfWhPRRzQhCWDRuNiZDeNMLivyoOHpnwtVZUEfMyTafvNXRSdRHILfTWwaTLuKIVtJCSwFxcJcOIsmObNjAShCjgezeBh" dataUsingEncoding:NSUTF8StringEncoding];
	return EGkWPQELzqWmZj;
}

- (nonnull NSDictionary *)VpyuVcfEmFqU :(nonnull NSData *)bNFqwAvPiLQtGkjv :(nonnull UIImage *)dJaJAjqsxRURWU :(nonnull NSArray *)hSvUASlQKaxnT {
	NSDictionary *kWiXOKJbuKj = @{
		@"HUMUWBrGXFJbq": @"trprFXMyHHflGmgwRDGoqEOiEJyqEBlyNrAndLHmCdIAWkZFPliORqWzIWCGqyfhzuUkMnrOUhSrEYPwfkISvXFUomGiaEMCYOVNwZpLdxrInQLwrBRKlhnHcthDVdLLdwpvWZvPzQPrdXG",
		@"AhcQIVmTXxeHqo": @"YHVrBaobDvchiBzBFMsgGiNjdmIadsOAYzZuePpvSYmXgfvDNpHOSZUVUDxVphpXZvtlLsgkHBEsHbQSpOLqQsqjKkylLpbaDukxWotEFymTRJOIivYtBfM",
		@"ehkYZARGDZCWPqkpDI": @"EedPxHmaWNzeTopeRhpKxMRBjRJQEjjhHMKTDavmSzQuCxWbVpINpdEbCCgwpPORfTVyDhqQsbqtNcDjEMgdCvpPuvJkxiNTsEarWsTslXhHslCfxCxgRflmTbCrrfoSHyENGwVsVv",
		@"YVHmWmwQFXCI": @"ivpuDoQygMhPKjLVgUztoSbfzSKScfEwevDIbdkJKorBPrTmaFgFWImQSOsuKefuTGYIMKvUKaJDGtbHnCsIekJOkkyqBeQAOGPSDOsAjCHRduDUGCXsRtaxvzCykBbpkzKEwTcer",
		@"ZeHhnTmttlsP": @"mIjNJTxFAeaEaJnydrLMIiJvUjfSpauZwXrqTOpkhvthgigclHHymQNhUIXHPxHKdhlZxIWorFkuOwXWebNJBGFIsSKlZclbwwYUfXfvSkqzSvAoxGrTLUeOeqXUBWMhTRsoeOeEgFxeTYUKI",
		@"rRLcjvdUJFvVu": @"xWjdtPPhcLpyChFiMVIcTfTPYYTxXsPYdTYvBDAQppakIhTzSQSqUxzeqYBSzprTCCSzUfpwqyqqKemCMGbTQBMSojKjTWYCRvnvUmlgRKFeysVOISHaHEkUjcmqNUjaMOEJrWBDKiRXLAFMf",
		@"labvRwBFKVxhi": @"iUKSWTIbGcYzBoHaRDWnaqqHyQrSHFvfaqklQMtnYGMDYXkInlXLjSgAMdedywFQPDlAfYdvnpNKBZtbcmSfetTcDdNXrSwYizWxYhWtrWofEpJIZeZmHOehwzQZXyxMPPyeDLttMMhzqGhqUQZk",
		@"QbduRvtwpImAkvqXpZ": @"AXdWRCdmcmBdypVJgTALMIilFHVLNCKlqNKThqhnBkNIysZqnbmWKsCgRxLFDxtnYJsQIKEKnQRPAvpJNJRInnxachAdxiyFwotQYGvTLnnNkITEQIBqvlqVhVsFuxMvbjiDvlZaUp",
		@"DCJsjXbUNTrurxhFowL": @"MoatgjEugDCYKDvLzOKnclIqzbFOVCDOotFNZSIvNRrUmxpDwmcdjvXvBkiBoBEtPWYiveSjScgzGsvaZpRiNMGjeRSoIHFkvzxbAZYUxsokoieDMZyWVTmKlkHhlKkkMcPEGSikRvqo",
		@"TtjIlKFOAklChjwFZMR": @"COInzDjCElYeykZRnzvkfBwzVwRRVcDMAunJAmewjTekMoGMBpDscUeEqVfsoEZoMkmuoldMbuoOVVRvFVJAODiOIlLAYyxnXDCAHaJIXUSzSPqSuBhqLWwGdphJCHCPZAXDGUmHpJMbgJEoqrP",
		@"eWcmMTwQijdextSU": @"HebqaOKyQnEYefOlooFpkDHktnTZgOUdvNjvyTkOitXtEWNyhheTZzYAsUSaiGtnHVDvSmFqMfEyLFuOwUNdvIGzJDHVJvvaGigrNhqMARrKlaARSV",
	};
	return kWiXOKJbuKj;
}

+ (nonnull UIImage *)jSrkbGyXzVJPd :(nonnull NSData *)GIGIHycuBqtsb :(nonnull NSData *)eaGfSasRiZ {
	NSData *jSTiQxoEaFEKxVBT = [@"ZJpUgGkEwSCFWQcQVuERNCaENkGtERswWZCfDSflEqkjlZZWVtvgboFIYKijsLPhYJSwLhIWCxcZvjcziUnxkPAoTdSIGXnwTEREjEfxeexiWUsk" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *mQDExxLqZIXjLd = [UIImage imageWithData:jSTiQxoEaFEKxVBT];
	mQDExxLqZIXjLd = [UIImage imageNamed:@"fmWKySYOmYABZwsmsYmFqBUzBSrhlPIEbnbpeQABrIanzGYOXoltTIRrzOUjpSBEJoAskHXlVaLHbTaDrmWTXfvvvAWKwwzbMYucyeZVMkkcWahAzOCndothgHPeatDwFKEe"];
	return mQDExxLqZIXjLd;
}

+ (nonnull UIImage *)MbzctyToOeCie :(nonnull NSData *)miXhbvCtOobe :(nonnull NSDictionary *)DduHVPqAZHIe {
	NSData *VFxXqLLWKTlGhspcO = [@"hdDznyCOxQRdhfOgmebydLdyeiwEnktLEgPODGxVGHYCEOSKioNtBMYiABWbkdEZWeyVuQbJZNtJuETzUwKcDjDdGsAfrAvdzqfsYHdhDIcbzgoTBOgANKG" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *BOdJspMqszoUNIMDnql = [UIImage imageWithData:VFxXqLLWKTlGhspcO];
	BOdJspMqszoUNIMDnql = [UIImage imageNamed:@"vWITUpIGODnBIyRDZUDfVLdQZWTZhnOtaiRmNaIbxLqzePwVRzuPbtzdIDwddpuNLhrsJJlKpjKBpWYgguylyfZbUjfwxwlMkUuWAqBNlYhkNTBCkKKlxQEYswT"];
	return BOdJspMqszoUNIMDnql;
}

+ (nonnull NSData *)NeHesPJCGHe :(nonnull NSString *)CeoTTERvOHfeNc {
	NSData *eWXRlsHoMN = [@"uaESQrajZLIMkdWzwIBdhtTpQBkreatxZybjVKRXfBsMsDleJYoFeVqXTIEjMJjZoRbWrRcFcGmNdlyrPtcqSoLJsFHRgIfUBKsPzOJCPjFQfsWZOGdxnziWyOfxtYldEPhPbAZYSCCcosfXbu" dataUsingEncoding:NSUTF8StringEncoding];
	return eWXRlsHoMN;
}

+ (nonnull NSArray *)uWBBeDjuWI :(nonnull NSString *)WPiRzriMJAcdkLXIV :(nonnull NSData *)tPpLsfHxHcZALo {
	NSArray *KEEAbNpLsuAvSdhngPs = @[
		@"FgSvBYLqevOfoSKMRYyyOahWvILMsBljVFDEXdkBxpMYgNTlvXWIoehHaXoyOwHhJuUeRtFLYthmDofRZtcRtEpyDOCFdhXzijVlCmuQmTEgLWRLekKWudhzDcNBZNauVMPlVLoix",
		@"IOzkKszcmixYpxHsyoHeVEcHivfNZuKLboFNJhznIMsJcgMlOwCMrlAGkZmowFrrrHTxoVFsnCpSoBgKQKbWCdTCOxhrNrErRPJQrkPQaEQiBVSApyfPokDOywgxOMISGTuM",
		@"txdfiIVNgZmNDOUTeygzApeBfLwAySSytJBstzcCjkPYgqqEIENJZMpMbigboDaTIJYIHZoAKvOUidwPKRbOCftQxocgCWuNsdQgShKsSunEwXKSCIsPxkABhtMdlHmylTuJcdFtmfqvjfGiy",
		@"AobOKmGvLeQNUOIFbtQwhOqwMuYWTrhJsiaBgDBljDxnDDyeLzsDcVqBxyRlBVVOzDLbWAszRFwJUKzizAOvjKTnIfQwZpGgWCqxKUmbucraqcSTWeioNckNZNVEGEZXZbLszvStZiJjXEuy",
		@"FPRLsIHWfHiBomvUOOCXslHcFiwMqsUwwwOoPNWrSqLLHozWSJRoijYTAcBKnoTrlUktmyDScinwMnWDuCfzrCXtGWtErCdetUWZukVMUghQVmxtBIFCYtrpvasEcb",
		@"qCCTwrudFRiJeOdbPyibPgxfhWqQMNQJBIVFTZXmtXuSrSKWHstsgFUOrlrLWiBovDafMdgzVdFVShQQMgwWHNfsGVyBNnSuSaDYhkWIcxQVByBBNajxKZWaRlWAirYeDxwomTBCSjWGTve",
		@"qiqXygVRLoQcIsSSMxnqgFdqJVbyPsEjNUYveDdmgKiULJpyQNmKisliNsHRJGMHywPYtdUqSsCIluvqgDkZXroKOpEAbIJWdUAtmLNdjFANBJIRJBOowDyFHRLuaMGPvlRxRFhcHOKfeVDTqNL",
		@"yDwbhXyxvUPaHmyawEUwYZwwHlRuTzEFZgjMpJhknvffvuAUQLNJecLFIiZNaEOmGxrjKlslIHkbJiAmnJHAsTQQnLMLFVajPJZbscVfSRuYjqZgyBDm",
		@"wVrwBZFOXPTrDmlONDnMqJVsZJiNkxCClXKgsICbArmgkLQLWoMLxQjAfUiPPPHIUMpTruIMEmnPGpuMRznXHrSscYyVQkaseqZELUCAIpnXdXuTQDFbaSgycJMRylQE",
		@"LCYxxoeaoWitkzxUWxlTHmvvhRnYMFqERwXBByfoUhZAnhDtsbICGgWbPkpfsscALmpinMfdcsmCkvpMTtulqeirPKJrlLDNZpiKRbfOzJeuMEursRrpUDFKmnCDyZOzeuaCPlXlucfrFH",
		@"QCxRovydldjpdUkPhiQKqekuIcopXQORoaBaSbBrPFPYoFDGWKqgVcZTTqnajUpcVnFYoZOOZqRzmOsOThMfnwgxHUSZlkzJSKvb",
		@"QeEZLOQhnNSHhMFeLpjfFPAPGhRXsQhllDIHGKeOgUzuAxApuEiyQwILHpyOWDxtkpVrsDgUGBRCttuIgjuvUaPFnMbiGGxFmThYMAfugvNu",
		@"SCiFGnbYerxuHmKsWhfAHCgpgtWfWgZdfoweqxnTuVHyOjqssMHtXapxEnLxQmUyVxAdBJPXFGpTPDvqHcHCjrUSlEQQQShnSDzmecpryARzJBPmXHidDuRdPpsixZkE",
		@"vbtbyfwflXbhEsZOraLkfubvPUjBRxKiFIKICbWRGlXxXHswrMqZNwKrNLUPhosKERQINFdTWNtyzsenAjKXYxBhlAtUcipSZDasBDrFErVJhrCcclTqws",
		@"XiyvdHarnodsDAqgBqDryrXDNiDrRjNHyXVBIfsskxchEtNMVkYlIsYntYoXdIcqPxYyavpMswYykgQAlPAWzEuUvzajWMZSuIMIOQdRPoxUWbWCeprSgxdO",
		@"bwZOLoteVyAFfLfcfcjFTpjdhjmFthQlizXgHoyTlLJNAObjAdtLBswMaBUxmajWPWZiuNWkkIYJiYciybWgujKGlfHjyPHeUJDIYVYIjDLMGGfiPpe",
		@"DAUnijBTQwTSpaIiuoQvvlESrftMeohaFtEcbZmItYhLxGNPhQGBRgblAVbkUMNVTzFUmceyDHrjpxTMUUrscaWaBgIvhGCVyYhTFgvWo",
		@"lQRydNvJfepXQXYcWFcYbCuQQtWRsoPQviyAHwctcdDiXGbrRnBjankMBNmyQyAktXhXzgMaCunlxnFwvVdokMPhnCrbLCYiEtfGZPfwZzIbBLPlfsSRkMZGhsix",
		@"nYYraubXtMcRaOMulheQRvrYHKxKhVqUZvSQUUlIDRlnkyTRCdnhRDdqTwtwsKMEuImDDWswhDpDsbfdBpMFJpMppZxfJmQxcbtrfrDdMssUyxZeoXUxbn",
	];
	return KEEAbNpLsuAvSdhngPs;
}

+ (nonnull NSData *)JBPkQtsbcLgYnCrVVNP :(nonnull NSString *)AQAbsHoruzmNRCoJSiC :(nonnull UIImage *)lwWHJTSqUDuzLvDw :(nonnull NSString *)xYITZTYjEGueId {
	NSData *MjXnwcVpKocVkf = [@"ztJGxgKUgyCrySHOKcuHADwoWAUYFTZyuoIvcYKuAfDJaVQJRfQorlyvFhSTNZLboboySwnIAobkrEQetkcmgKvNqSfOQyNsiUgPrBPBHnbsDKFd" dataUsingEncoding:NSUTF8StringEncoding];
	return MjXnwcVpKocVkf;
}

+ (nonnull NSString *)xhUzOTEHeSiR :(nonnull NSDictionary *)pZfPNcwBCsKqocH :(nonnull NSData *)NZUUDbLkDnk :(nonnull NSData *)RIMiMjQdjBeGx {
	NSString *qaMZjVBfcaHPScp = @"zFajuBSdZLVSljyBONnRGCmhjhEHeLBwiOMBqZVfwUgGBWRMFGbCXoDvwfdJiDiCnnVUYkppwyJXYWfhUOlWOiijtOWWCIfyvuIvcrhaJHNMwTQyvRoKnQrJqKFuJIvQQZ";
	return qaMZjVBfcaHPScp;
}

- (nonnull UIImage *)DwGYfthNfhWPOSTqufH :(nonnull NSString *)VNYMVbjTMHQ {
	NSData *ySApGGJzdpwRwut = [@"XfUfAoKaEwlxGSPggNzZgVJDHkrJOyvqbwaRXQECkaMEtEuCHsDlQzLehQihvineOSWVjjGOYDFRhTLkHUNfitgsGjURxuKwVDIulIUeMmf" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *dJLztdwZEBbibzorr = [UIImage imageWithData:ySApGGJzdpwRwut];
	dJLztdwZEBbibzorr = [UIImage imageNamed:@"hRZHIaQkRrQnRxRMSJSMeMtwtRCxLNrRiAasIXorlhMFMvqfbhKcZPJpePBKOkPHvUSdBYExqExOgltdfAhQhVTPTKpOxNhrNxtgU"];
	return dJLztdwZEBbibzorr;
}

- (nonnull NSArray *)GmxsbonNdUoApPA :(nonnull NSString *)BWGoJnYZVwXYAAB {
	NSArray *kMKWuRRZrLWRrwBpM = @[
		@"OnbwWdYQOXBguiGLCsEyqDaqlNFJnoOGiSVdEuREXnRamsugkiAGOiQxEMTaKmnCeqnBWUaYfsSyKoxHVuVIegixjWEnmNjYxRmFWnkDPMnNVJPBkYPuOX",
		@"dZlzwZKAHlffTmQGiwEuCdRBlfyJPVQmLjWgVMPJYHbWLANkbTQUYTIoSERLegSSlAHZdEPhYFzQQRXenQwmyGXvlOCniHEPuRVixJydxLcdzYNoRWAZMzWBogJjMMOSMwgqbv",
		@"YCbWdjBwJMTuVdrwHigMDmcQwbHbXsGJzgZBTfvxhHkAHOLqbgoVIiarjaQtbdcCVswMDgaPDfFbGGZetxefjOkXLNeMdiKJeBVkGgawKpMxykQetXDMlbycRJSOcGdFONVYEE",
		@"pSPEgLYFwPTPYWFLRwSiPBEXCFvSrxwpyuuurNLojcxMbWXxWPdWLVgVSoknHlChhfRWcVghdgxNvHEoHMmBzWqiMltQZDVVEgJNn",
		@"YvnpCZhadojbwnGsseijkUQlEuWPDBgVKsurDAlvsZrXMFwaueouXjPYPPkxOtpGQmDTgGaLvXgCVcEaZpkYdDjZkvKeZVJAHncDsjGGTMWThpbpLEhcTdGdRedkGsiCwPziCrUbUsctjdiqebs",
		@"udZaRdwdDlQEerhOAlzcVtoEOLQdxdyaGMTnhmjqGOOzcEPxvilDmdpRigaYlgtTKsHuykyjSBsHmhgeSQVjKdKLrnuGwPNpyzNLwGTlh",
		@"bJFbIQYWVNLqXJfGByQdHfzshThDawvlITpLSbcOIPASYeTiAlcCTNajNnuIRcOdEDDMHAgLkDpIcpPaXiIsqEYbhJiJLJLdMKIMWwXFIStijvdWwuwPuasWeGRKMDm",
		@"wHczNcDChNTpRfvNslZhfCqHbbvksPYmZzhrAtXfhCyBhmUnqAJhjXZhXuqPanGPutHEcCRXjDjuwWuxYormckfdaqMHOlwlUwwzJYuJqJ",
		@"jWffmHMqDvouGuqpYQsWOROLFnCZHBoATyKYAEZJwbdnwBQWqTqLOWVbwgKFjUwDGnLKDeGawNEHRiCXOXggBzhvEJLlJUYKUYvNGcUpJqOYkLFrtGdQxcHe",
		@"XZsNBdMNlyWMbopkksmoXIBAYAvIWgZFqPNBXLJDEnJjphogeVRmgriJkTpfCWVgieMiPkCrPqiuqJSaeaSdOyeNdcMOZPHkNXXjjwzeXksAanbaXvftg",
		@"ojnxSuOzOaIFIFPkumbYAsYUvspXGQVbdtJEYeYmTBTmLITfoDNcwcJwKQmInsfxfafSSFcplHmtKXgDOtdwvRxZKsErJGwkLXkQx",
		@"eVKVpqNfVFeIBdmEIiQLZJihgkkIxLcBZgaMUvHewPayFmWgaEpxYEUuactQZBdghJxlyZgJwJdWYPMIIPHVDBodworNAIYbDzjyHEieJpPYFoIhGdovduVPqCzuVRWfbwuaJRFaVsOV",
		@"AMwHbwNIZVXsCDvNVjqhOmxUAXOnIcfcpnhnkifFNvkXLyxBOyMhRmyBHBwvLjtFXDYYnCVBUOFcbczkHpvzPGZirZmopBrMVKmLsLlhUmcZKZcHqyagCjfqktGaNstpfFdbIU",
		@"ZVhiPbdBOXSsqrIDPwZGJddNGEdLOLEbxGCtQbPodPhRWbktqQvMVUWbVVPJvOlYQnzfnrmhxAoaeknmsaeZAxguwrmmmPKzMQeZoXPOjouNFKMAazbmwBpkgyhnllBx",
		@"OADYcywdAjvunbhORMyDgpRopkESCiskpuMsDslesVLBgFiUZMpLLDRmoviEnHxnrUdPUsCVhDQYXOdjgrSIWOOHkNtKqjrSIYCKywPWrknCYUJigzejrBAKDKDdbPHMWRppSldf",
		@"fmBODGWjmQaGnqudLEdxbtzTEzsAAdMtAuWFFKBytfKGpbqvLpyOhfdjjDkQhVfKNcDphNBMUrcuunsVZLNHkAdINFUAoVrcEHAOrQcdCIfqsStmVnZLEoQfaDtmmCCgdrAWqxxIARIcE",
		@"mRqlCUTYSrjUCYQHozIZGXmGrzGiwEPpANznVsUdbTbJoNADjRONjvgJSnRPzywFRocEEhljIvGTygrbPXamFMHOcYqkGtDtdssFkMkI",
	];
	return kMKWuRRZrLWRrwBpM;
}

- (nonnull NSDictionary *)klAQghhoXSeFdTCGkF :(nonnull NSArray *)kuhYfxoACZl :(nonnull NSArray *)nXNDAdrHHd :(nonnull NSData *)NmlHEPAWkUWtnbHTCZ {
	NSDictionary *BlypZHSCLkTLYWePe = @{
		@"sUYltkqpshatvREk": @"IFUzfJajMdfNTdyfcuSOgFRQLobTCSRlKfxxBRVchNfchjtGjSBRmwctRKIERFQmwqJUsrYGIDguDYpuWMGLQOfXnwubBvLGDScCVF",
		@"PhebxRbDuWaQLBucn": @"ikbtQEjsuSqTeDGWXXWSaPNjkGLJumvlyQbBlyOSmyCgnEmzfYvgljkBioVuoqsaZyBMIYzeoYZZcglfptfZmcGFKjXRJgUIGEjhkgpTlxxRqyZGckkACNhlcDrfqeNQEBBfpv",
		@"ZeYuKiAjAy": @"qkxHLGlitjVzqoWXajWNcJuTiGSUuUXGdILjnotCnydOBOaWzYBYLRkIzBDOOFWaMJwBBymrBjQTmzHadgxDOkeQTRFBfLaEIPGlnOQMIjOInELjikPcWbVhgZiqgclJgokCCWkFTU",
		@"HDyowYhCJS": @"TrUIXWqAtKNnGCJEkwJisikwnwfRrTvHvTZodznxenRRFWQgqpnWvUVZrZxXILdbfmWXYJgrVGRDGgpqFvfLyaeDCfhBdSrJJedfTAZDKvhx",
		@"UZdlNENYIQfMBG": @"nTdKAGxMBNYLfMTIKVQAyuHrftIcBLpBVeJHrkzJObRyOsXBcIwBYnlAoDbQnWdIrCUxQBlIsyqHISaRgdIFFksOdQcRnnYNNBaZSVRmxlWhnlxUNHgRfUTTBqtGwfzaZqqPauiltnhwnZTTf",
		@"GHrGbRROTAb": @"dJzmzVnTwoMzLoAiUdIICMUyQXOEHebPvNYvLyJKtjWNAJBbfeefWIGxddsbisPpTeiZVfLbCbFFJtbSpRdiVGVdvAdHXztPRdGXYroLuzVqZzqTGCsfbnckSdrWYKd",
		@"KxnLqQFNUI": @"bNhJLPBgUCzGzIXYRYiXOXQOeTMUDLsEKvqMjufgkBwEdCSNymKlpMKsuGpgHpwNwgeZLFSUTQsIIPVGFmSaUStsQjPMfJnupbTTooUMWwUnVFEsIHlxbcroLKrwWQVCNvSLht",
		@"skEZazIXlLyodiRD": @"DEJGkQoDEtzgRGHksBhgQrvnTLRJAYRoClTvGEeZWdoaCMRKhUrPZbCOrZiuhVPIeNkemZpfqiVRmCXldNdHwqCvRsvHkmjGVsERUIuuujXLVAVeSFZtEkDvIBMkimImXRPIwVn",
		@"ufabbYOIJvmMO": @"lZxfMNgrzRAFhUbdwKdHvJGxJxsSpHqZwuVGwGDLglkeMXIOHUQNkMOYBazJFPhKRDiQIyEypjrFycyQWADQDwYBZNTCKJWEExehqKnygqBchakzoXXhCLYBKBJHrAlwxGYO",
		@"jTseAKnMOMMxpCUcpnb": @"xpbwhMnNtuqTOgOEfAkPNUYPZkRhswSSgLQRVfyAhhjhdFHshVJMrEaAGlZlbdpjmHqPZqTTHVLneeuBTNfdUDUXnPBwlbaPXlofieuiLnkzsjrAqrmCrrDdXXHotx",
		@"ERLSBGCNsO": @"XfjvVyfUOSJnzayKuaNNeSAbYmxsgTQtmwaQqHZAlrWcfTxoEJjoOXjIQKshAsmtOAhkIvLFPTNTlThhkccVgIwpVSnqiHyzxTqrKiURreLwJEfgnYfKqC",
		@"FRNnDhqdsOjUJ": @"YyFshIoxxIjcichXmvcZBkySdFOMCEPoqFAnmpjysmDdmHuedahgiQTbKKDLrwrmkHbtDdZNNnVLRqzzjRGtmFbXWAimbwkNzJfcZoJlTNadhYXMdxnZUxEseQCbhMNtxqdzSFwgVXgyWozseIR",
		@"MIrUSYmlhPia": @"YzgTgssAFzRKntUtqIGpdnzSwllQXdWkshwosUXGtANoPeoUrvcBxQKpElHmbAzpzWVtIELowebepUZvtUOKQaYhQrMTWMaDRccXZoIOWZhbMgkpFnHRbJWycJVMdqqFgGfLttaiEVcoJlgnpCx",
		@"BvvJJAoxutFbuVb": @"oFNWiujtxHPLiIYgAUnKAWAYvMJBfKJzVLzubCSzVqURQIlZNmvBqSEHJiAyrVpmincunWCsmCgwvmyiLPrLmXJdLkKzZgkwkvpDzLnSMvFunOvwMiDqDTXXSKaETTrlOsAnNYGLvMyLxhIV",
		@"rFMuOzshBvEq": @"dSrpjdIsQNxMCKOTLNpFFoqdIqxGeXhhkmHvvdMsLkAmQUrwpqOlUKgoDjecoWtMNjopdLydFRcKaipiQOlZvvflEjjnhkCZToSdnQfcohpwiZjTUBgGmdLluIibTLrjfLddovk",
		@"uSrqSSeLan": @"eztiAABHCxScJWvPxQqzIRiidRBPKGqUNDQgzJPROPwhLnPhqlgBcDHyOIWOsAMvLlhSfMFtAYKyhgdZZQSPIaxQSnOSLoXJmQEcJewoasTYCtOAZSQE",
	};
	return BlypZHSCLkTLYWePe;
}

-(void)addArr:(NSMutableArray *)dicArr{
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@?locale=%@&token=%@",NetHeader,BianQianSeleted,[ManyLanguageMag getTypeWithWebDiscript],[UserInfoTool getUserInfo].token];
    NSDictionary *dic=@{
                        @"type" :[NSString stringWithFormat:@"%@",dicArr[0][@"type"]],
                        @"selectedlabels":dicArr,
                        @"locale":[ManyLanguageMag getTypeWithWebDiscript],
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        [self.businessArr removeAllObjects];
        [self.hobbyArr removeAllObjects];
        [self.languageArr removeAllObjects];
        [self netWorkingSetting];
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}

#pragma mark 删除提交
-(void)deletesome:(NSDictionary *)dic{
    
    NSString *url  = [NSString stringWithFormat:@"%@%@?locale=%@",NetHeader,Deletelable,[ManyLanguageMag getTypeWithWebDiscript]];
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        [MBProgressHUD showSuccess:@"删除成功"];
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}

#pragma mark lianjiazai
-(void)backC{
    [self.navigationController popViewControllerAnimated:1];
}
-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
    
}
-(UITableView *)tooltableview{
    if (!_tooltableview) {
        _tooltableview=[[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 216, SCREEN_WIDTH, 216)];
        _tooltableview.backgroundColor=[UIColor whiteColor];
        _tooltableview.delegate = self;
        _tooltableview.dataSource = self;
        _tooltableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tooltableview registerClass:[OrderMenuOneCell class] forCellReuseIdentifier:@"OrderMenuOneCell"];
    }
    return _tooltableview;
}

-(UIView *)Hidebtn{
    if (!_Hidebtn) {
        _Hidebtn=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT+64-47)];
        _Hidebtn.backgroundColor=[UIColor blackColor];
        _Hidebtn.alpha                         = 0.5;
        
    }
    return _Hidebtn;
    
}
-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn=[[UIButton alloc]init];
        
        [_cancleBtn setImage:[UIImage imageNamed:@"my_design_mask_close"] forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _cancleBtn;
    
}

-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-50, 40)];
        _addBtn.backgroundColor=[UIColor whiteColor];
        [_addBtn setTitle:[ManyLanguageMag getMineMenuStrWith:@"添加"] forState:UIControlStateNormal];
        [_addBtn setTitleColor:GreenColor forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addclick) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _addBtn;
    
}
-(UIView *)addView{
    if (!_addView) {
        _addView=[[UIView alloc]initWithFrame:CGRectMake(25, 0, SCREEN_WIDTH-50, 1)];
        _addView.backgroundColor = RGBCOLOR(240, 240, 240);
        
        
    }
    return _addView;
    
}

-(UIView *)backview{
    if (!_backview) {
        _backview=[[UIView alloc]initWithFrame:CGRectMake(25, 0, SCREEN_WIDTH-50, 100)];
        
    }
    return _backview;
    
}
-(void)addclick{
    
    for (int i = 0; i<self.MenuOneCell.tempArr.count; i++) {
        UIButton *btn = self.MenuOneCell.tempArr[i];
        if (!btn.hidden) {
            MineOrderLableModel *model = self.MenuOneCell.recommedArr[btn.tag];
            NSDictionary *dic=@{
                                @"id":model.ID,
                                @"name":model.name,
                                @"type":[NSString stringWithFormat:@"%ld",(long)model.type]
                                };
            [self.MenuOneCell.contentArr addObject:dic];
            
        }
        
    }
    if (self.MenuOneCell.contentArr.count>0) {
        [self addArr:self.MenuOneCell.contentArr];
        
    }
    [self cancleClick];
    
}
-(void)cancleClick{
    self.menuArr =[NSMutableArray array];
    [self.tooltableview reloadData];
    [self.backview removeFromSuperview];
    [self.cancleBtn removeFromSuperview];
    [self.addBtn removeFromSuperview];
    [self.tooltableview removeFromSuperview];
    [self.Hidebtn removeFromSuperview];
}

#pragma mark tabbarHidden
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.Hidebtn) {
        [self cancleClick];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}


@end
