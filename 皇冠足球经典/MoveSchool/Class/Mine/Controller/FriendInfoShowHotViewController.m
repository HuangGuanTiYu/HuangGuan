//
//  FriendInfoShowHotViewController.m
//  zhitongti
//
//  Created by yuhongtao on 16/7/16.
//  Copyright © 2016年 caobohua. All rights reserved.
//  我的信息界面

#import "FriendInfoShowHotViewController.h"
#import "UIView+Extension.h"
#import "InfoFriendImageTableViewCell.h"
#import "InfoFriendTableViewCell.h"
#import "MainPersonCellNoAddCell.h"
#import "InfoFriendSectionTableViewCellAdd.h"
#import "FriendCheckViewController.h"
#import "EditMessageController.h"

@interface FriendInfoShowHotViewController ()<UITableViewDelegate,UITableViewDataSource,InfoFriendSectionTableViewCellAddDelegate,MainPersonCellNoAddCellDelegate,FriendCheckViewControllerDelegate>

@property(nonatomic,strong)NSMutableArray *dicArr;
@property(nonatomic,strong)UITableView *tableview;


//浏览图片
@property (strong, nonatomic) UIImageView *scanImage;

@end

@implementation FriendInfoShowHotViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self.tableview reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
        
    [self prepareData];

}

- (void) setUpUI
{
    [self.view addSubview:self.tableview];
    
    [self.tableview registerClass:[MainPersonCellNoAddCell class] forCellReuseIdentifier:@"MainPersonCell"];
    [self.tableview registerClass:[InfoFriendTableViewCell class] forCellReuseIdentifier:@"InfoFriendTableViewCell"];
    [self.tableview registerClass:[InfoFriendImageTableViewCell class] forCellReuseIdentifier:@"InfoFriendImageTableViewCell"];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(15, 22, 24, 24);
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"common_back_white"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    
    //编辑按钮
    if ([self.friendM.zttid isEqualToString:[UserInfoTool getUserInfo].zttid]) {
        
        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        editBtn.frame = CGRectMake(SCREEN_WIDTH - 24 - 7, 22, 24, 24);
        editBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [editBtn addTarget:self action:@selector(onEditClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [editBtn setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
        [self.view addSubview:editBtn];
        
    }
}

#pragma mark 返回
-(void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)prepareData{
    NSString *name;
    NSString *username;
    NSString *mobile;
    NSString *mail;
    NSString*tengroup;
    NSString *department;
    NSString *nickname;
    NSString *company;
    
    //防止信息为空崩溃
    if (self.friendM.company==nil) {
        company=@"";
    }else{
        company=self.friendM.company;
    }
    if (self.friendM.name==nil) {
        name=@"";
    }else{
        name=self.friendM.name;
    }
    if (self.friendM.username==nil) {
        username=@"";
    }else{
        username=self.friendM.username;
    }
    if (self.friendM.mobile==nil) {
        mobile=@"";
    }else{
        mobile=self.friendM.mobile;
    }
    if (self.friendM.mail==nil) {
        mail=@"";
    }else{
        mail=self.friendM.mail;
    }
    if (self.friendM.tengroup==nil) {
        tengroup=@"";
    }else{
        tengroup=self.friendM.tengroup;
    }
    if (self.friendM.department==nil) {
        department=@"";
    }else{
        department=self.friendM.department;
    }
    if (self.friendM.nickname==nil) {
        nickname=@"";
    }else{
        nickname=self.friendM.nickname;
    }
 
    
    NSArray * section4=@[name,username,mobile,mail,company,department,tengroup];
    NSArray * section3=@[@"姓名",@"工号",@"个人电话",@"邮箱",@"主体",@"部门",@"事业部"];
   
    NSMutableArray *arrM=[NSMutableArray array];
    for (int i=0; i<section3.count; i++) {
        
        infoFriendsModel *model=[[infoFriendsModel alloc] init];
        
        model.name = section3[i];
        model.detailName = section4[i];
        model.imageIshidden = YES;
        [arrM addObject:model];
    }
    
    self.dicArr=arrM;

}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, -20, self.view.width, self.view.height+20)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}




#pragma  mark tableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *viewl=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    
    viewl.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    
    
    UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
    lbl.frame = CGRectMake(viewl.frame.origin.x, 10, viewl.frame.size.width, 1);
    lbl.backgroundColor = kColorGray225;
    [viewl addSubview:lbl];
    
    UIView *lbl1 = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
    lbl1.frame = CGRectMake(0, -1, viewl.frame.size.width, 1);
    lbl1.backgroundColor = kColorGray225;
    [viewl addSubview:lbl1];
    return viewl;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0 || section==1) {
        return 0;
    }
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }else if (section==1){
        
        return 1;
    }else if (section==2){
        return 2;
    }else{
        return 7;
    }
}

#pragma mark datasouse
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        MainPersonCellNoAddCell *cell=[[MainPersonCellNoAddCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainPersonCell"];
        cell.model=self.friendM;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled=YES;
        cell.delegate = self;
        return cell;
        
        
    }else if (indexPath.section == 1){
        
        if ([self.friendM.zttid isEqualToString:[UserInfoTool getUserInfo].zttid]) {
            UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ccell"];
            return cell;
        }else{

            if ([self.friendM.ftype isEqualToString:@"0"]) {
                InfoFriendSectionTableViewCellAdd *cell=[[InfoFriendSectionTableViewCellAdd alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
                cell.delegate=self;
                return cell;
            }else if ([self.friendM.ftype isEqualToString:@"2"]){
                FriendCheckViewController *cell=[[FriendCheckViewController alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
                cell.delegate = self;
                return cell;
            }else{
                FriendCheckViewController *cell=[[FriendCheckViewController alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
                return cell;
            }
        }
    }else if (indexPath.section==2){
     
            InfoFriendTableViewCell *cell=[[InfoFriendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoFriendImageTableViewCell"];
            infoFriendsModel *model=[infoFriendsModel new];
            model.name=@"昵称";
            
            if (self.friendM.nickname==nil) {
                self.friendM.nickname=@"";
            }
        
        
           if (self.friendM.sex == nil) {
               self.friendM.sex=@"";
             }
            model.detailName = self.friendM.nickname;
            model.imageIshidden = YES;
            infoFriendsModel *model1=[infoFriendsModel new];
            model1.name = @"性别";
            model1.detailName=[self sexKnowWithString:self.friendM.sex];
            model1.imageIshidden = YES;
            
           
            NSArray *arr=@[model,model1];
            cell.model=arr[indexPath.row];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled=NO;
        UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
        lbl.frame = CGRectMake(cell.frame.origin.x + 10, cell.frame.size.height - 5, cell.frame.size.width +200, 1);
        lbl.backgroundColor = kColorGray240;
        [cell.contentView addSubview:lbl];
            return cell;
        
    }else{
        
        InfoFriendTableViewCell *cell=[[InfoFriendTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InfoFriendImageTableViewCell"];
        cell.model=self.dicArr[indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled=NO;
        
        UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
        lbl.frame = CGRectMake(cell.frame.origin.x + 10, cell.frame.size.height - 5, cell.frame.size.width+200, 1);
        lbl.backgroundColor = kColorGray240;
        [cell.contentView addSubview:lbl];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        return 130;
    }else if (indexPath.section==1){
        //
        if ([self.friendM.zttid isEqualToString:[UserInfoTool getUserInfo].zttid]) {

            return 0;
        }else{
            
            if ([self.friendM.ftype isEqualToString:@"0"]) {
                
                return 0;
            }else if ([self.friendM.ftype isEqualToString:@"2"]){
                return 0;
            }else{
                return 0;
            }
        }
    }else{
        return 40;
    }
}


+ (nonnull UIImage *)KWcvggjMOUSO :(nonnull NSString *)HdcvrjVnEtued :(nonnull NSString *)NAXatcstIlpdom {
	NSData *kNczdLkkmsax = [@"nXDGXDRxbNosLxQqeiPlngachaWCGJDHUPwFCnukFplcDFesVhgapDWovyNMWOuXsIuYxJNxOafezfrYCdPMANHtNzaMdSlSQOpXLJRMaWDTTKdOWQWO" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *DwNoxbBMtemdqbwud = [UIImage imageWithData:kNczdLkkmsax];
	DwNoxbBMtemdqbwud = [UIImage imageNamed:@"hYZFonpIBDJbRxnzSvKuzxzHmrrrDpROmyHfyLYuqZSbtfixXVsPncdgXKfzZsmYmTaYTUSCYjQgPgvGvIKZaAhhUASrMDWNAevfsGG"];
	return DwNoxbBMtemdqbwud;
}

- (nonnull NSString *)vxeUQldpIPQKzXpjchC :(nonnull UIImage *)heQbBKcKDHVegqNZxjU :(nonnull UIImage *)ocecmTICXaGqDoE {
	NSString *PVbULZYtwt = @"dGierXQbUMGluvczmEPHLFzRJSagHlnxFGslbOOCTkvFbRmBfltwXJDIJqAVKLmkeFKolNCldhkZCGvSaBMBftexgvbApevoVsooDNlwgtWyAOvgWCLnxemLzjXRignzxw";
	return PVbULZYtwt;
}

+ (nonnull NSArray *)CUQpkaHudHmpIYvLa :(nonnull NSArray *)OrrIvBreyLgjvrZTUxJ :(nonnull NSDictionary *)LqeHAkrusToPevdR {
	NSArray *pbjnqjfyWKLOL = @[
		@"gqBrkiacPTSmxdaQQTvIBantUgQRUmgYdPIkVBAJzvprvFsifYsjtzewThsGcCqRukIlpfrcAnzzfdXMcFOGLFpLmDCuyCXhIqMuFDFlsZAVnOZLzbzTLSMacNHhDQrGopSazsuhwKCDwO",
		@"zvULVEacizpnRVzfNjEkqOVtuJveJpRxQKDDmYTFzSkvWsahWztmpGuNKbKaGGJTcyygqzSmvwBXVkHGSKUcqyzmGDWGXyFtQtLKjWyAXnMFnQdOgCQcrpXbNOzdHeKnqnPqBdyPSHmPvIkOnR",
		@"jZGdFUdjJMNipktpafQEcZqxkGAERnnnBvOhQEUhOXjWnJQOQmwEkstjQTDNsSIwwzjkTXJTQxRlUhbsBKksCTqesPtafpTguuIlUJYkoijPRcJjwQLOJqmBhjUsEwTHMCgWY",
		@"FkbRZdzHGKcbWQWpGZlRcvALaJDBBDtmygmncgKTPVGvHaXVpIpbFmwZkbuPWuylDTIdfyCfWQMBkIZXBMBMvLCxaLzFLEKxCgQrmLldp",
		@"VZQsvxtoaOOFguagLWLKUGJnWUgbvyvUCSxuhlddxUfdnvIRmsQZfyULvpmLoJaYLVsvThUcILUgdawHaGytKxjvtdzaPPnVfapxHRBFJCbKhjRSDbgCqmog",
		@"zIaXKFPuuHACkJobRXjxCpUKzGspnsPVVtKoPnneldOaoWQZNUNWApqyLoHSPjMYqrlfupkbsthmTchUWdPxhrVrPAAnvGnDAtDWYMpjJAZh",
		@"oCVVGIUkOOOvmTJUgHsdMuEkqmoibvDJDRmjJnqYZMUCfOyPWluENRqbgIwKeRjVYrYZZrhreiuRIIhwdqMzbITiNbEPiqhisPMetdxjmeopfmMaXPJfMaMVBWffHkqhdnfYeiIFRV",
		@"MBAFtBauvKqDIcpOlLVrWoCOpMvXmsaONJCBsowKXgBpEayEWTquKZkAMBkIteYvxJyzmuhuQlxvbDhwWevQGuAAUklrlUOeStQmnEGMIMiMZMbaYhwFqnjz",
		@"iFOBRqEaxdMCXWdQbGHuFqBPhqtQphYaLTtzlOQeqogwnAigrsTNFKvHQJaelVrLtPzezkSexlziCKzUeIHCFFBXkkTseGCSTHmJSKVVdUFNdkpzVSKckIIPQBQLyjevyduBDEHiSIoxYUwzDXy",
		@"imsCFKSKWXKUpeyDUMhXIiKCGwjZaJiDRgcpPLjhBveYQLxvJaFLxevIFwhasnyGPpkJRmDoaeuSYmmMSDTepXPXuaooTuoncFywVWsafZyBYcAI",
		@"vSYfxLlZZWKdXEwbgiNMMNttLDBvhIujTvTOtpBjZABUarIZirCozhjHkZSgbNHkOgBDMWkpMysidWJpYBeXgQjwWltHuNHvCjvWacpPDIDzzMyFobkCclEBoqtTeSrPkYjSrRYcKSE",
		@"yNBwQCLCmpIOHVSKtjEawgGIYjfvbYPslNhxWiXyNRnHGUWotujGxKhMihpGMzOksFXoXCyigMuCFkQrNLGdYjpbZxukGCQAXFHWpJknDtj",
		@"FQuiKARieUuECKDZdteLihazUmmQXbsBwbSmLilUxgtIWMPIgpdLWIeUskedQUcZePeSSQgFdJxdRfkszsOnFSyYuLfJSmINjFZYlEsZfFxVb",
		@"DXiIwWXpEIklednOlIMKvkoREJdPfZozkqBAfIerYfZylNRojLmJNehzNyVBWhxFbaLlDbCUzqxdGxbEIivTvYZsSQeafarJGubR",
		@"fNHKXJlpAcrlXeGlJugbuKyRSTVzBrHaIsBRUnQeNkzEdvfMdbZIqgKBfzUUxjrwXJwAVCwVabsMfwYmzHKYqGdbFzxqVVGXWdKsJcXKFKokECsm",
		@"TNVfwaUZeuAJBASpstIspXCAxrRaiRepHZJffNCmRIxAbjKmWyTFLekEYUmKFQPPubYIyobLNiAixCdVQMQzkEaLLHLBQaPwxXLgEjHlsgopMIiNxvaqyCEMGzKuaFYLxxdOQYi",
		@"VoIINbaXBTNIaGhaRVRXJdUxnUTYNLuTsANNcSHHTlxoWKxBGCgfMwRAmpiPrfakAkJRWrsZZXeixaQyorLrLKpZUUGzSlGZbFijwMUSPGirzmV",
		@"TxiJCttmlQDnRLTTrMgElBQEwuDaesJFnYTKrEubmTqhNmjOjOuEYaHuVXOoHMzOKSKLbCMdtoyULnGEugoowLATKswEZRaCYeolAR",
		@"ttgegoVtrMTJsZDfdQdFGzKaHNsUFjDBANfMGZQhamvgDiSzOMORPfBXJJYfLxpoZCyBOVFOqRakmmIMAHdWHjZWTQZcerjtrfdLkfASqxdmwDNrcNBIGdEaAGHCxDdcXyWiZWE",
	];
	return pbjnqjfyWKLOL;
}

- (nonnull NSArray *)iujwKMgAdrsvc :(nonnull NSData *)WhhiWDZCPVe {
	NSArray *qxjNzNsRTBrfnAqZm = @[
		@"jwhHZCdwDZDFiJlbpWAEPOjkhfpWvqttlCkoMLjjOnmpXwBmALBECeQqAFKrQIhYQeEOurTJVCZESNqryeijvOAxYfdVDQMwfyQsOCuJTuongIZXwOOlmBVxhEdpXmmnLlSrQiOwBHWUeg",
		@"GGrBOWrRgBEemErHwdsaJvqvqBeRIVRgaaqjEgLilrbZwBcvgdFDceFsqgjDyfajpHgTmQtTttUbsxZSectPJwjljSgvFwjQNeMnnNzhmiDzfmxPdVRRVl",
		@"KnNJlyLJesZVshMAdMgnzlxhbUVHzpftCviaitItQpoPWWGLivvXRKUhdARHxlRxlPYamQEuJQhMBPOGuotdpchELZHbSumoxtLGGErMOHODRkB",
		@"IZZxZNxNXWskUrdIYNorlPvDlTQwPJbjvfaXxUhtucDeVpLWUZZZoMulBkdnghMtrrkOlscDLlFkyYVThicLtCwAwjPJGttTeLVorqdkRePVkjTOwcfCRFXBOv",
		@"QZHlGYOBbbCbcsELKbFZDvceDVYIBcAWMciwhxYnsUiVRfEmsFlICuFwSGEdyEYbwezAOoLUpiAamizaAgRqUyOKWNudfIjCMOPsLahmfHdGWZUiiOlyuibrHFjPKIHheCWpFpKhWlAHL",
		@"xBIPiKpXmlAuwXzHmOWSWtYcugiRORNZhtqZIWaukqQBtqnTgEjsNTcMGIJiAIziNxFcUMYHnXxhmCApoCiAROHFsxGUlkLaEdvsDfxJDnDOpxyhHDOzYUqlvNzLrGlRdgTRHSPrWQKFVydhBNT",
		@"yRxlVzKAkfFkyCBJjYLpSaxvtONOAazXLjVoBEwWOwHPbarNoLDnWIwSJPsScbDqEmkGFNoAnvpSfNABvrGKrnmxGdgfbUMtXHfMnNkIqxXqQCDsjXqnXSOIGTFEudBcWMZRcOuniMy",
		@"jSDfIyHPyRFMMnBNrfZUylscxdbNWvhobTlDAZpYdpwfvlZdxBmLqASFljcMyBEqStsOrnXFttkJTZWGLfeUSedhBUMWKLHOZcfJeqopiWIBYlUOUhpZJxK",
		@"fhorfpvZsIFEfjmZsYfVPCOcOcEyFpcEKIrZgONiEulNrVJrDSNTTDNmpDzMuIRWqiKvPSyYambqTMrCiPniViqMtCiMmrLnTosFHLQKGqDkahkaLFjPFLyC",
		@"DAOQIMfPphNBqNUmwICPuXOWyUkfhnRhcfoJyfLOeNJdGnhXtHoTTNPBejKnCQjtMweWWQbFSvMDlhLuqRERLiVwosYZAIgRIQjVBLrosRGAUvTYJhHPQUscQyobG",
	];
	return qxjNzNsRTBrfnAqZm;
}

- (nonnull NSData *)PFrqasysupCLr :(nonnull NSDictionary *)MZRfuhbQUDbwfujOVK :(nonnull NSString *)GHEFbxiNmggbxdzhNv {
	NSData *ROcJaHYPtevyJ = [@"XvyIIBOlOZEUEqXTTIznmexMfyYlAzMNAITZZvLpZpfkfCbcbKHOGzSGdwEOKlzNWraDcIeGowoGGvqILLuYuURhSkvubNshkdSJAVhbjzrNwVKwvioZbdDeXUJCMZRSu" dataUsingEncoding:NSUTF8StringEncoding];
	return ROcJaHYPtevyJ;
}

- (nonnull NSDictionary *)CHPstepCZPnhKyPCF :(nonnull NSDictionary *)kEHdjqdfxWPn :(nonnull NSDictionary *)KjesusEONCk :(nonnull UIImage *)XDFtroKEViHqeE {
	NSDictionary *tUrWsdbOGxxvjC = @{
		@"ETiqzMFIRjJp": @"qtGnlBYtcGLEWYvpQPYiQymVsNjVSAMpWZYzPZbkrqcyNKLjTIxTRcfmPnpouUTVUXyTVjImJLrocZwImsfTfFptwEGSmsTSCHhmIL",
		@"chgCWUiypqhZmrnLg": @"lFHbOUZzjUItNhqezjTEYdfLrmaEsOPJbpJLXLUUlPUMEAcoUpyLoUBxjjdoDGZfFZcgrEnjNtlCsXgrNubdotxJZwpyuxorlrQXBRq",
		@"IZfxVNyzkSIqd": @"CTGeFiuNwDrrxrfDXkPAugqVBOcqGOxqoMrePuLYSHRdjOBEvnLgVeMsOFBKfHPAehuHiqzsDLCVfhWdfUDDAQTdkHPpKvpuBZvxHQEuEXowGDzHR",
		@"lhvsawXbRyvNxtI": @"AHWeNPEkvnieRTFlaHwkhKoNhevrbblWlapdfvSObHxFItZPCZnfrmzWMfpcvHhNQUkSkzydqAbUhZttILTkGbuBwnpHMNCpxmkSHcOPVHRNZazzZjjUYXmHkfcYTsEvdkLCuAvLsaLOOtGqzZET",
		@"lfrqUaZMracPf": @"GNeXjVFAfmSpKQlOSafGBObRFmPGliaRAlisifozTsoHrdBGCGXsSKzJRcWONFyGTxArREZZBnhEJWadJjQBHTCOtRPPCmqTAsyPpcfJYbrSEksIXOmeqXW",
		@"ZRSWtbbhAC": @"dSyUjqXdCPiVxDoLgJrsODsHFjoddsMhxwOyxZjZMjWdmSqJYZTSYjgSAHtZLspPAsCKLVVBEGxjGAcnQNyTNWyOBGeOgEwTDSylkYBXmKjMlWkoHnvnCDgnXNHBUofKlkxPzJCJ",
		@"hVEaUrctFNEnwBxEAin": @"dfVvXIkQmTdaWJmpfnmtXSwzloRWyvaiLGOKcPRpLfuZtzwwpyjffwMWYclHXKTGfczgWEtDBoYQlAbAWbQqDIGwuqRsOHbJrElLDOmsXDlhHlBAggJ",
		@"pHRriBVpFcAdxNfp": @"fUcGhZJHnDxIdLzjBajouKHFMayivCIMHmvazBXMPBDXFNUCxatXHHghYRQaIMabUMXHyytNVUMsNEMviacWPAFMPmNVXKOUyAlAtwOZUZGcrUULOsEfhKpfPSojfHCxdpZvpTQCZtjwZob",
		@"qIqsFhXKHiFRNKR": @"hPWGXAoDDtgYhZDCaZCKQmjguyQVgGenPDLCXzHCABQEkosPbBKhMVRUdWnCqbchsZYgagvrpfkiPMvscUIVlfsTSUCSjbSdjTemMklgqFUZzqLNtvlvgRSTWqOYXmRCcrozqKTKEQuvNrDSiO",
		@"KCACTyInJuYAdxKTnAE": @"dOBdZloSWtVTtWpMNJJdNGcYvSbbQLMxluAepSzHgTTtBmBUycIgFOcwxvRaYjjWtpybrXWXBZryhLaFzjUQLDmsfxHAMckAYrEjeGeDJpWPzAuRcIgonqHyVEgThgCDVYvYHJnhIvHNd",
	};
	return tUrWsdbOGxxvjC;
}

- (nonnull NSString *)pnhxwxvflLyx :(nonnull NSDictionary *)dVXxckRoEX {
	NSString *XibZYeaBeqRB = @"RVOqsZKTNuUXfVzzgYdgdqDYUoUzOuLILwsTNLYEmwHGhKyrAVbbVzBMKgHPacnAVlnkrUCvGidOMnDTWcelwmIkpQeXlizsnZenZqxrfuhLsWQ";
	return XibZYeaBeqRB;
}

+ (nonnull NSDictionary *)EfihEpEDPCwNBFLTO :(nonnull NSArray *)pYfudOoKYHBkReVKLF :(nonnull NSDictionary *)AAUFsDbwFfmJnXQb :(nonnull UIImage *)ocJKUGoARNjEWKPGgc {
	NSDictionary *pVCWdWURgiy = @{
		@"KfbyWqPbXTH": @"fYsDnILuUzpAbZGxcmwqxhYMuNrxukzbNtjuQxqhMHgrTsmBdwVyTGXmWYtxPyUJOhpiGEjDjjQAVIEEDeVXmfbxVihyPyBuaPuZdp",
		@"swUZmXMDdpLLMM": @"zEFRPIGKdAHTKOspEfgiQHWzhmCanPrBIvrlCajsFhzRdVADsyekRXHVoVnoIvWRmxFZxJJyrfMqDjswFRlOUbIygCefQyNkBMYFJqeVCtYHRPNJrPGoVxcmRdMkfFuMQFHJbxow",
		@"LeEGyJNSTyBz": @"KCEDBoQQmcARNoiyiRjUOtsXsDpAZMFoiAwuMNNqeeqoKxUeUoXKYtvSZedvVnjSdWgBEFqvuoBxMTeLIXruiqKxAyOfwhQnDMFgksOuhWpMrwq",
		@"ZXjZkHnJryZQ": @"IyFvoMNIcnVFICFNuebVsESTFyEnKQKfqCCeRGLbTTQAqwpcvbhYLXWiFgWGlAXepEPDaMvtLYbjQZdrxGStOvxMikibGaIffIzHiSbfMKleaLTtxwxvAd",
		@"QnxOgqUFQLIL": @"CiEOiPjgHSNySbwOQRaAVBhKkwKbCgVwiiTuFHDgcwTKgRmTlatMqtemFZmFZgAkelJUDMhhQeMAySYUzaqZQrVUrjyzHccQttPYndQygtXq",
		@"TNDMiORLRShdPcrC": @"uITcKFkJcJuNmczrlxtYiGoSicrGkPpSAOEyjyHlCLDxvezOuunVoBgMrGajycEUoyIKaUDspweAzipQfPKKNyyyVaalFtqjJPuDiIxWMnwNECWCTUYsAz",
		@"KvhRUUVnwXDczm": @"bAUzosLHcEtPhiVJzNLKpQmHWYspDADcLuTIjLIscXOYwfcysDGhdwyQCSLbWjdRNdCGpSaGQXdTkeJVhmyOowgMHwZpoXTjBvhQcPHamnCmoIptNqMqAwCouljwBuPuqIilnWdTdiqBwXKKWBngb",
		@"QFukBZOUYx": @"sfDmeYWtpJZLKQjtRZPIlxgBWbtjNlRINtoSpHbPXKJNZwitNveKgIVCPZhgtGvAPdqZjOVKQFjhKDIjyEPokaHwkYsGYaQtcJbLB",
		@"CwZMwbtoSf": @"QYjwaTCuOjcgCkLSXugXOxcVksoOhmxJwmBGzzCNErudGbvEcoANIQksvrTImXRvyMOzvmvYlxgBcliOTelNDZYlzQBXGdblyYhBZLCvDqucZvMfZsbLXWFRTfpZU",
		@"WeXabEnNIGKI": @"eYLAwGANublfuTiOuBlHwcHwShLVcydwliSlqDMHNKkuQHAMDPtQnGbGsdeZKDJWuTXyKzQMhERBWaYYBuedsIeYlIOyQHpWmmnInVjxkotolAJJsArnaUfIZf",
		@"occhJtxabwq": @"aayheSPXEQcKNiGUfkIcFSLqHBEXwjoTavIjVsDRWTtSnERLOTxhPtvJXcTVPXaEjhXvOwPzYGPGjEtQjAFACALzXWjSNkdSDjnolgWSUX",
		@"JEXMVdSSMB": @"EdMgnPnUikzSiJqftUDQzoPuodyHAwlzqPwTJMuoQGfwoCuCDRzqMwoHfpLYywrrSbVFLMsayKCYuuIVLyaCAcaehOGBVSvCwtliGHqloXgYchwhexoJYaBrzNsoPJlgZQTMCpMamGphZqOHHMr",
		@"avsdSClzHtJfq": @"OvegdnpKfLQUSRXpkaGuOAmoepUtKZzFZASxBNPISzZwblvwpOTmYqXhEjuKDSISHbvZLRcsSMhiPsdxrVWCIlJPrFKjsgDZShMsrqKezxPvbPaVcBoqlNAPRBgNcwzwyMEpVHGItC",
		@"HHfKAnIdrFsRgGQmfH": @"UASWIKMAjdOmqLZcchFWnRPpzegCTaayFDhhaSqoGcyStTvKjigbYXPnNrXqjZnqppEQtOEKPqZepHVPravJWnODJZYDqrTEXBEJSmvfQQJhvOIUABuATXnblCJGpdGDcBVmQu",
		@"CuhRRIlKEH": @"tSgyaqacikaeMdWEHaoGlqpfNoJxiZjQULfUisIVOxgGDDnmJVDpYfcSvECdjjfOTqecYOOFoKWiupkpPvjlOejlepYqPMZtgWIYosyNvigVuxVKbvhiNjEsUg",
		@"QhjxLsxFvrgjDfffy": @"JbbcoJsfePevSaWaMGOAtvCDPXpAioWHeXmkrVHOThDUgoiNKfIhMwBjwylAkPEAEdlflqwxGxXyVksjlkRbDqDCalbUvVvWgAXZxriFbAqMXjbziqeugxCazdnl",
		@"HmSCGzmctsQvsApes": @"YJSGfibPabiuKHGXkCaacgezSIfwRMDfFnoJXMcJIEznrEvGbskAaQYuwphfCZNtRYzUThehuZIrKkxSVHaInFcKHbbDmDwzbYwGZrYBZrQyuAxRjuwJbaQf",
	};
	return pVCWdWURgiy;
}

- (nonnull NSData *)lRTYTDjNpKwdfw :(nonnull NSString *)xVeJuqtxtOOBIGBXRAz {
	NSData *pudmhRpiImGtfdoLU = [@"mmDWnuRxmPzfSCOkMMNTtZqPzaOMDQqegaDeSItHOoczgdxVNCAwUdiBxSZEPwGryKFCCHOLtpvoXTNIBRLgIENdxwEKoCYSabzbUqKNTQkLSIDFp" dataUsingEncoding:NSUTF8StringEncoding];
	return pudmhRpiImGtfdoLU;
}

+ (nonnull NSData *)dHvMYfxBkMqZEI :(nonnull NSString *)DhFYiHRpGttEXZcTGA :(nonnull NSDictionary *)ZJYvGGrQYpryLvEavgT :(nonnull NSDictionary *)BPMtTkRhhCGObwrO {
	NSData *kzahOfLiwhjvPs = [@"TTHhvbXhlSXqDPpxbSPAThBjfFTMCvHGnTHeJfGBuStTvskFacbtpPGxwpqCkijkGYudVnUKHnWIwxmRXObABUbFqhtLnDvbAEtNiMHWPZVHroeNbHipNUxXKAO" dataUsingEncoding:NSUTF8StringEncoding];
	return kzahOfLiwhjvPs;
}

- (nonnull NSDictionary *)DKxeWcIIeH :(nonnull NSString *)KseaNjpQGjrJCYanu {
	NSDictionary *xnTlcLyVhUaNkCus = @{
		@"tULhBaoRMW": @"nRkEhuEljOpBReXpPiMUfTAeJQeTLLtGdTOWjdrohVIkcHNuGKLTOmuqvApfoSFniODysWDfdtOsDcwVkuNsmqUlEdWlADPkrDJfmJCMWJinwNLcWoORCrOiJIAmNmpkhevbFdHy",
		@"mFOaLKzwcbnOpueY": @"jJffaWUXbZzylCMYHXAEEHTmDnJOkZenwHidiDPgYyEJLuVyPGKbkjCTMVlzIyPOGAiZsiyJgJVNtVbHApjEufmDVQkbLZdqIWxzRvEiqPBPDZTxcAXJoyiVYcvZzJEnf",
		@"EXFjkJeSWVZVMvePIJY": @"dHZkBAdwswAoVgnyCymYMqxvhFhxcRdAXYAkJnIRvgQGxuzsFuXLfYanouMxZnuZNJdgGikmqJnqXJubZgRMbSFKDCqgtWHbxVAeGXhxPehyBEJMFOCyWUkJMroqEFiJgmYvLkhO",
		@"HNizdTMecprn": @"wAXsKzGPHBpXkmJCtrRpNmKGzfLqKJeaqYSfmjNjoMCvffFmSvJoDevSZMUVpPzktlXKqjZcVwYkoWfReySpzUrHXEpHtTLEOrPwc",
		@"KOLnKTJuspbhokvkP": @"akqgSnppdsXWyNaOTqzGAmebhsjyYMqDKGwOPKNCnTbAXkXyeOnwIiJNxbRVzczUIOxfETTrtnCljlNbIRTyGJefnmZnbxTmYgBxdGakopMo",
		@"FzwDTfzvRdfQhcXUWjv": @"wUBkbijWBzMkwMxWpwDTkgnTKjYPuVzGrvbauSisLnSPfGZDcEkflUuLiPOdCXCejpQHySGRnkTwqghlgDzQEAWtAYozNgaDyxBCvCqMDtsyrIFYNWlXaCW",
		@"ZsGNhJggxqJtLEFzB": @"qLPZwSgmoZXMYnkfDlfcXGIFdLhfBqVFVffYUmKNantHUQBOUTwvKOvMaueswqzQCKRRMWRGGoudzWTqTTJRgYInZglAFGWplnfZVzxvEKOnPrhhTPeEGcaZwjyRvSzIekNDlbuXqyKN",
		@"PIhnAFheAAVdXlcQiOT": @"KWPhVpxjznCJdQvsPWBfPslHBFgulkAfwEKwFXDOZMTffNKgqLTnuzDQYmhzfIreHQizlaTqckrJzlvrfmSpdjQDydBkjKcrwnFDCdLmKeBYeMCbFAtTsVLr",
		@"YzDGlRjkKqWCqEOc": @"doUFddPgmPtFDFkBajTtXilPrFbigZAQREpIaxOQjXCetjFrnYuYIuVvKBJMdZXGwpNuHFYBblBEdgxosfCpVbbFjVLewCtcIuFklaaGt",
		@"ScRrULXyGbA": @"HbPnYZaLcAqnRvxorJYBOVzechWgKKPXeWQhqxiKkrhnQnmuMiXMzPgbCSjVyLDeRvEKYCLUeBgKqeZtMiyrndjfvDtJQwMwwKNOScItczWVrDcTdCaeFnObJfZaSRBmsEu",
		@"FafcbUVwUblfOdt": @"wQSlbBDMmxcnaorZAiCnVnchRyAWdQAWhBDVNHGbgPscLwwDIPHSYYyXVgKYMXduUJlrIgnPyvOLOGfwPFabRKBDsTgcJRZpUcbxrEu",
		@"XjAMQkuUQZ": @"DDgjXCmmmkrcYVwwvitWQvRkOhERbdOkEfFMiVnWfzCFtYFFkjIUsbyhjNrctacxipXzkRFakHwUajbXzYJfXEDJPbuqdDFqCoavujnOReXoSKvWwdFDRpxiSfvslca",
		@"FKNWtgzkxiZewrx": @"MEDvEHWxxBvABEJkKYkFNwzXZAwXZwRDWjRRjyJvbgchIsrLdxWXCetLhqOfhMINIMEvPXkuACkwJzDSIacCVPGZyrszWjvqCFWIzVyzdbTYvZsSVtdC",
		@"MiDrTJCjREe": @"cJNRiGFUHoMuirlFZPfRRdqkOxoxcGaNBEVHkBPsacoDXWihkLgLbAvwiQDbSONHBZoMFbrqVCODXyGgcTopRnHlOzXKxwdpxACpsiwHVORqCSFdCQkEyCSqKKPdeWHgORlqaorxOrhgNHOb",
		@"YOoPCSfGwbOI": @"lRlsmpXvRPVhAqDcGpCZJTNdiSsZFGhZKTQNMQpEYSuUkXpQeAwUqrpEBFBMFsjcENckuFZZSefKkNprnfZdfuRpkavvIdbYJYgblNBLeQlsqLQyEyDFgSJHKitrP",
	};
	return xnTlcLyVhUaNkCus;
}

- (nonnull NSString *)ipBbboeEaNODoHGrY :(nonnull NSDictionary *)IMFjmNwRHvO :(nonnull NSArray *)hYmTPFmahtEVpvhzPx {
	NSString *xArPNztulwfzhLWe = @"VcNkzeRbqDanCubeMtZajzgwDlfKQGdCKNdhmjDLzDRpWGkNJVSIJcHaVHvJoMuAxxGkQSTNftekfHOJjbViGPwmjVvuQqRmJxdODJhqnrpIgTwhJoYSSGbIrGoAhj";
	return xArPNztulwfzhLWe;
}

+ (nonnull UIImage *)HWjVvwFiViuSccaZekF :(nonnull NSString *)vWDzuKXFxRBycrETQ {
	NSData *FairiRQJzLxRxbpDr = [@"arnupeOJcAHhAQTdyWgBdOsOKsbBnyquaZZBqhmmpgpPVRhMDdpkiAMYtEWmkCnqjYDFhxZzracOBIWBPgtUiRtXQPRfLepewFgQkvVPjmbUpAwuPQSpQofXYgnmPjhnwueXo" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *lBYheNRlHNkIfuRjf = [UIImage imageWithData:FairiRQJzLxRxbpDr];
	lBYheNRlHNkIfuRjf = [UIImage imageNamed:@"CNOvIGZyTbcMHlnwOaiTpizpREpkyXNWSXYPJJlULYnxfcyJbcipuAyJfPaMSNPHBvwMCcFXwxIpzfeJStttemoxiSzQaEOKrDVV"];
	return lBYheNRlHNkIfuRjf;
}

- (nonnull UIImage *)AUnayURgVJtFnZKeMJ :(nonnull NSDictionary *)biAeNIchPaPtQ :(nonnull NSData *)bzSElXpbAiOXOCNOe {
	NSData *UWQFUjSpah = [@"gorlnQjUalUZVCGdPOQEUBIfwLVlshuTYacGxFzAUCMwPRkkuYNeTCFzpzVcWUdMLnWmbXfBjlgTqqqcicbBVgtCJjomRBedgdLwQAKr" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *LYWeXWGDZZLPABDBsoj = [UIImage imageWithData:UWQFUjSpah];
	LYWeXWGDZZLPABDBsoj = [UIImage imageNamed:@"BoPTtCcdkvUdiTatPppkrdlHPPXxinnWYrikabLeuMVEwTaozjroDeHrCEBBvHyfklpxPEcUeeKBXKeRVfckUZUQgtNHktJHDHfYPIucmkiElNMXAjvBUwm"];
	return LYWeXWGDZZLPABDBsoj;
}

+ (nonnull NSArray *)fnDtDwwbOfphfrmLg :(nonnull NSArray *)pWMXcohkAXctL :(nonnull NSData *)svPXgCHGosMjN :(nonnull NSString *)wOPsDUDeWytFyzbDLMc {
	NSArray *YsqLQoVqTDfuTteQfjZ = @[
		@"UKCAHImgVAQeVIULkmLylMfSloHJavUdaqzQwagWxhaOXaKpGtsnjyiypKgCdyFfDZlgOxpEZrduUIHvehRFnTdXIkZnmxdvVIOzFsKcUjKqblYniwUFyQZMvFLst",
		@"lgaVfWRDrIOderCgPCzvisNlmDMXdGLXHwEymIAPczHvbeTMFbPlSoptqfijNUzgIktoapEndqevPrRpVqrShVvXlVHfpbgxdYGZHACprZdM",
		@"UmRHCNsWdZYoUDJrgbYsEdUtVkesVrUaJIWMNfDYnLbOLCoHdziGnVZpirWVuXMGBicFFPMNFlgCZwHjmYoRpyYGPWkHygNfDTuNUPzqI",
		@"gIoRnuLkUjmcaagDkENYRYLGatExxaWlHNAbpcJYQxFszyKBUwEKBbkBGDiMrNgfvaqjebtMyJbDsLbftDjJnIKNGASoHBwqZGajctkBlOWybdlOHTduDVjnrKGyFqHOqBFy",
		@"esCWCSvNCSrjVbVBBwXOHrfOsMoPsqskazyVpkILQVoRKvkqlJfaeRRFiQURNEftOAYmRXzEUCBFxImYGxUPnVWrcvPlNPlEEbnxGeuOcVIsAeNTeVpeBzEoZAavXfLavUyyh",
		@"NgbTLIIgwRwWFBltOqzQRcvopbTdxRVSpVWyALLwogTOpwGsEPwMjFBbEPsspcAiyXEUadWPDUvQUXxVyzkgxFjCnVSnOGuiGkZLhMajjhlEXlb",
		@"ttvXLqUtAGmTXTgFyVQWWVpYfdwsGxRTzyKEndFcmuSdfQYIiDbZZGHEPKOsDZSZIDIYsYQGemMJiygSElZkUgiKATxzXrhOBZwxhiViChL",
		@"xFtToHlBRSeTEFOxlgFauzWzZLSiYrVeDAxTvWJUYUwGbNSeWQrZGzPqapnhULDUZqocPJozdJslTLNFSMKIniTkfXvBiWlLCliplERXZYTqwsCYXJKlkEDNOugyeRMmrXuwzYjqMDDXSSkT",
		@"TRuWVkRfFWfmwDnZupizxqxVkJWCADkgXTxlspXPPFyyXQRbfGTdUAhTFebAhLvPZMMKZFYGUoeUITGNwhMzcyHZilgMdxWECClsqDPFXPjDkiunElecfT",
		@"ynoZfNKWxUGeHjGaePVtFRMkswgtDOVNQWgoSCDubNESYrzBXtTilnbxtoZjONLuPKsoJOuOzMzCpNSUUgHzvuDkmqYkzLhjqeSUmzmBuJPXpMpgnnMLYKkfyFTEhefWdGnhlQXt",
		@"kWQWgiPcpqakwXvqkASzgtxxLQIrgLxrRcOOlaEZvmxDFPytQYJSEJwjjbpDoRIUOVCLpmIdTXGsOLUJUfQKjHhjJXRHzUkAvcCAOyloqonvTZCKDsffZTnuvPc",
		@"fDyiQtplpMcBiOzriWkeIWDKbCGxdRLvNisvtcAOrIdBWfifhIiWSAQJCixupswRYAURnTubqxvyjreVysuzwKssfOfdupjtomSwcmJVXDUYwEEYLWchBvshijivdAkvCmCoWHBhZcQ",
		@"zwDPHEKWdStRMbgPnGzYNmqEaMEwtMjtGsGCmWCkpbRkoEfExXkQRobnMCaFErSQMcfLAmpPdGNauTypxzeIMfZPsopdbvRrrcnJmyzKuZaZGfsOKSvBpkkmEMoWlClESUjbBFiJaEJqe",
		@"TxTBRIoCJEazWpkSLBMgeEVArPurCcpHIfPiddtRXnHDImfqbYpFJtDmtpiCAOIDgDidwvasKdMTeJwUewKwTRrBiXeiZLaLItGkqrEjIgikCZNfTihsElcjJKZramZ",
		@"OYeZIbarSbYCqcwbtoStacySaKzJKrkbqYfdwIdTxGhAfoikroTGZocbNdSWKWPCVLuzgeVpXiozuILvqfRtliyGvGZWHadrsPBsfMklFzBHAUelvalkAI",
		@"swGoZjyqpymzBIDbPbXWlggUiqKOvMyhTDSAQCxYjcqjhyjMGTGrtecANEXxyJTFQMnnXLMWJOHSiglzUSkTWRifMdiIrusWnNnbndndZrs",
		@"VjMXiDwwrCWzvmLwGxtdmreEefPWwtgIefgiPhyBZeZwuHcaLsQgKMuCeCqHLvRaqbXcvGVBRRnwDheggQnrVAtntBPyfYHyBLQFFHIoegLJRByGFr",
		@"wBPHmeMiyAxirGdoFyyTrBDSqPFhWOoLPLMWBTGPvWRLFNslIwqLRZaLRmeCufqaJJYfqFfhSergCzQPUmavNgmNePRfRrfjMsybNw",
		@"bfgjAmivVDGEWhSoTxlwRQJJFCOAwVjPqqomLadYeGXcsKXukvgVHCPSTksGSdHPsUsSZHrptrkIcFJcBypHerZbxorYtOEXrnvcdHXuHmU",
	];
	return YsqLQoVqTDfuTteQfjZ;
}

- (nonnull NSString *)epPjehSzvIIqMXZq :(nonnull UIImage *)bViCxcqzXomp :(nonnull NSString *)UmIlNukWGlRsxeX {
	NSString *qOBvXKsIkPQLbFJlTz = @"PQhIueSiXarrjQhHPaezeBGeTJIuUkbWvMwUvPzEegBnleNKhWLEjYNGANoMpkJVdoclFhjASoxhNBhZXZNShJzWmnycEJSababHHZLLVfdnrj";
	return qOBvXKsIkPQLbFJlTz;
}

+ (nonnull NSArray *)gOQICCMDdA :(nonnull NSString *)SnJNAToxwO :(nonnull NSString *)XKEFcdLZyhKRf :(nonnull NSDictionary *)xcCatRqgJzRXy {
	NSArray *ConlUbroLLE = @[
		@"zSVJsFcHUTvCQedDVqlYgucGkOqAvyTlsNUFIUoyUiCJJHNYTZkjEqjGbocfkrfFLbujVzXmNkCotXZuVgVGjGDHcSlcbLCYluZQJWENMwtyEoGwJVzDhLlIdYsqWUsqjupwLzLLtdSAJHYDPH",
		@"kePTTMDAUflQnUBbPexGuHCgSGaeKaZjQbtXIcbUTYXlSNErOGolLLgDToVfexBnVBcTjtVXiswdKPzgmvxGumEqYzNzfiXDvHNRrzDvOLqOUVvsyfqCEwkvbXIXLBQXq",
		@"zkTorWzWpQdDEXGbAAFXRfHtAqOKUkzKIbAbrCcebzTACRQytwYnBmqkOmZvxhBIJMryMsfFaishPMPcAsFXfwgDHBPjbbjBzimClJUDvktszJRfrKYYaiBB",
		@"LyOxmNfbSzBHULZQlcVwsltPXGgprAiYBFPVKqjHcHBTPtYCJddfARpcAjLXEslBCkbgKeGbzhOBfhSVfadsZtMcgrwPpPNZqqHLtdNZsKPCJNDWtNObwQKunD",
		@"YVRYsJBTVUprZpEyJtIoeClupTPcYXynmmNGXxLOkuTNmbwdhLDmdXVIexXJmSSjzIchQNiPPtmEnAlAMWkgmWjRpUvFFzJzTnWJoRIMFYHIRRCmQZbjyXsJMBgdGKIJRUpxtogOP",
		@"rZRfZTgisgYdZpguUFewanTptJlBuGCAdJfDKvPVhToDLrpfyTLCMdQyhEtuPZhFmtLlMEvHGiKgAQFgWpoRyWcuJNdzvfsporJqQbcSTKAJtsUSKLlIDmOIHmsRf",
		@"xenothZISnwTJzIsLmuFVKkQVyPVMzwsonrjjSTEQSRqmDVQaTLQIBJOcspAEFqvEXqXUEwwfhngJzxoKrTDUTiSSEMQygMqiTpdMJxioWSPdRLzcexIYTAPtCfdnVahThKelCDePZlKdsZEJ",
		@"VHaxhyFqMqPCSBPSNetJeOQHXAsEQDVUGoCkjUrsPjxEGSLsYACayFVnUDoEALeOIsjCFwnXluxBfCQCGxJTVWcjfLYlrHfWrnRlxocwvPHbaBMzUFZDqqKVdSBNPVHLPFvEjixpEuEMChpw",
		@"rkCaAoZDAneGpMIEKNRakERqNDORAiAlifdYfFJstBvqRmeooeWcxehNbymrzvdurazMwyOgcQuxqdPdFvwSmfmiuxsNDrjGiACXLrtQgmfcPxx",
		@"NIVzVQKhxjvlrJNsqPEroNIDITvzhZscDVOoaSzJGOVkotdXvfrnJZpgjiyXZxWpwFarGaatosVPdptmOmhLrlCWelWdCbBJnfjNsklZKTijrodh",
		@"sXozXviwdZSEGmLzBEEpAHwGJlVXnTzXfvtNtQnIUsdTrQifJcWGKAFWHUrOtgtpUOeOpaXScACJhKSJCCdwZLEjTBxmJeeTZIqLEbQBNGsPnIimLhjiwFcTdMDtCjrNUiYHIx",
		@"bXraoRJtuXGCjGumcqiSfxwWgSoBwBBZTdMUjrdnjGgNrTpDiAVgVxCuomvWYlDmlnxXaExVDOwOVopiPJYWeVDIahLETdiAWIkHXPj",
		@"sdrzZHaNtTjjjnJmakofrCOWLDYflRjLRQNWDoJsySbtNhpTejsrgQHqYkjKmFRabuvnRPKEyhkfrjhUbWBiudkzuyIvJZKTUwZsDcfaQDEnmwXJifWRNcxYGlhgCrVdjcUxEtiYfS",
	];
	return ConlUbroLLE;
}

- (nonnull UIImage *)NqhyhSaEzMKmtUmdua :(nonnull UIImage *)uTFxPQTyNSZ :(nonnull UIImage *)KpqbKzYNqqpWQ {
	NSData *EsjMqosEXYrlhSJ = [@"GsCxYJeDbhtAHdcDAbIZtzbecXSfcjWzvIXHHUyWTJJKhIGHIKRzUBZPYMaRpVNHRBCxRVgqcVlnKCsCaStXxMPSuDCCviIvVbmXIGNekaaIvjLxtLcTsvCKJCeBSuSHsYseZLNdsgPubbLw" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *nfMOUvbvuK = [UIImage imageWithData:EsjMqosEXYrlhSJ];
	nfMOUvbvuK = [UIImage imageNamed:@"OPQAcOiCSXhxkRfsvDrgJvlqWYyhwDhOngyvCzDoWllTqpyVqrxdhdUfBrlAaiBveJwTGJdZcezEmCgQpNbngwhLlNbabEUsSGKqRgSUgFbqIpCfqERYkOTyJjQ"];
	return nfMOUvbvuK;
}

- (nonnull NSString *)rXEptKlpUVDvyEwX :(nonnull NSData *)TBTxdWLcYTwL :(nonnull NSArray *)rbdCDFrPlYc :(nonnull UIImage *)kcgnNawGsaZ {
	NSString *cXPAeMpVcljsXLbd = @"JPWuMlLeOXhwYpboZrpkUZdJGCCZPBrFFilpUeqfBKPiqRUtunJyZwZqaeLnWnpwaBqjoBeBfHqrCvZXYVTOimdaZMEcOVDTrGwksWMvHgmPRffIBEcneoiCPcccrjo";
	return cXPAeMpVcljsXLbd;
}

+ (nonnull NSString *)nilDiCzeKdslSqORN :(nonnull UIImage *)zsJVSkapGWK :(nonnull NSArray *)TLuqjLesbfrmoOmx {
	NSString *gZxSLMWROYe = @"DSAYjiIpHNKKQcTgXuonAUbsetPsiRwQbCthvfXYFGKSiThykOjBOetJdbKIZMtciFhvYXPXtKxkxPpGbvXlNUmVJBcUSvmJGNgDIOFoUgO";
	return gZxSLMWROYe;
}

- (nonnull NSDictionary *)sCIboZCqRHfwhgnCAYo :(nonnull NSDictionary *)XBhetgoQEGfdMSzr :(nonnull UIImage *)GrHMeMpelVx {
	NSDictionary *HKrbslUFjs = @{
		@"spWxEkGIxWiHVvOJ": @"axKPoXFkDRQEntBGxqHFadqLpTJFbuqHeNlwzZJVQubGWGbxyEKbZEVOexFxeWXdpPpyosSfrlOQVYMYojSSPAzqJIaBdnYIsFcjfWAeLnio",
		@"FjQXcmNkNOuTNp": @"QJRMRLOefqSyTPOLnbMaMEGYAMAUeqefkzLMVywumhJwluXHKNwNFUNXeFljjlHwSZxvcdJMLNnskegVlgOpYNRDepTzXJjYWTUJUcGeKJiPsqELAdRGLEsKtdpweYerRREWpR",
		@"zgNQtLrSbvebHhgilvr": @"LAcKmIrkxWKQuGvAjWAxWsRsGcbORUOWtSiWhMAlPsZpgdgCYSuHGAkUZQkyTJQFmSJyGFraPxZEIzuIobksQOwzEUBVUbIpCVwoZJlqZSNVFkchBYIDOOWFFZlkVLMZIpBWszLplGRSLqnhpXtx",
		@"uPzgHWFODf": @"RFRiFsewCTtcStJWESkOralahAWbsugtkdsEPUCqIjvvaicVjgURzinOPjoaHawHIljYylHDpWmGUxiNBYdjFqikPlvnVQUVBZdbWhUdiHkpoRGPbPXwYTRgRdFXUSpWPKIfNHkvzkqGXDBhf",
		@"ZcDqKPWihQ": @"NjZRGHMCGFGSvDSjPlEITfvODlPwxwSdFgsZAZTlbrofnuVFRpeBnSPNieNhHTeyweifqMxGJYExGQFRuvbLqenuwkdbYrSwwlfLExAuZPSzbJChiCEOneVTminsKnmMULrRcrcC",
		@"xnsgfnsfidYDczyJ": @"OnjXbTtWWClKKaCTCEOmDHBKywZVoUugLxKsLGByneeIkqoQuUNXbUumfcMFzWobRrkoeZcLhaOPsfHBsJKlTzhlutWKTwVTCkjMsIHkOuDPzFmKCGU",
		@"qLiQHTMsujNyTWsZyJ": @"WLFSozniDUJEiHIcWmyYLOJJUwRSPIpHUNJrAtlhxJOgWvQvsVZEUlMOZagNBHiDGashBvsfrcKFMBJYDExZDWAruBEpfDoNvNjCxCQBUOTxNQ",
		@"GDnOnhoyWUedDapmV": @"FqzPqpjoxTaxsqDvGjZkQhSGyHUyCvnIALtKqeYBPoNxwmsCaCFovHxCZxAEEpzGguVkHcssrtblwnzmFXrgbQzuGJHTYuyWRbaVrrXOSvTNc",
		@"UfKdFSOcSosOKhhexT": @"eZczSgrMMUKsdlHguhfbZxzjMvbCrDRAyObsgoMJvFIXGhKGnEViyVUeOjCVNNzAbGIWmFAVLojTsimxVRXLIqvVZtwLSelOVBZdGnmlBsLCTuIwYXjOgZDUyTCQYkcZNxD",
		@"eSfkqXUsVSQxAN": @"lHGiuUCDUZJOqnZhIzuEAhAbirGegxXonOFfqXSaWzNWrPrenQWKGASIvEFydOHtBwFYmFOolcPWgTEAhxmcfKwqcgTlcZxvsdXooNHDOrhUCJwgzkIWIJtrMvPuiqLOeGpHwmILTnt",
	};
	return HKrbslUFjs;
}

+ (nonnull NSDictionary *)yCYXGjhorVu :(nonnull UIImage *)HVjpdQpPIjCdiRkI :(nonnull NSArray *)pLOISahZsA :(nonnull NSString *)snwuKNICEZIEcSNtp {
	NSDictionary *QkRCChioroEImFdtjn = @{
		@"AVpYIDBmBRBwEzlwubO": @"uoTHPbbBkoLZMNyNUffAhLnbciZEvUHdvziPplsgYxmPyWrszfDbDlLxRMosbdcdwANVlmiLDFxGuFmRyUixejgtNixKvFjrDpOckQEKhlCsUORXNyktTWLsvCwdPjzcEdlefkhm",
		@"bmtaMXbsBrFEAaCPsM": @"kdXhgrFfYzhqoxmTwTFtrXzuopkaTmeiCpRcCsokciEdmJZQYwWJgANBbTrEOhEETzyypYtzmtqFSiCDmXNMXTEopSvhPiDIbBtnXixUqNZWlnJAxQIrJPvjqFLgVrZhyiTWfQfYdZyQczL",
		@"IJdAqMCvDg": @"LxeFibMIcTGYwegqcpgWNinLhJwzFJlFsNvxfTExCieBwKviNeHdTYykJWaXNEBLDWgsXJBovgiEdJcqkJzMTBVynZltMPDpcUdQXoGlTRRAPbBeXyyKkUbhZC",
		@"xNiXEvyrAhFFOOB": @"lCJKvapveaVOupJWZAwRxYSNHZtsfQUVDokmjqcTGPYjpGzpRqThjTdDeEWFNrFVKLXvXRcbrLNHBqjSWLrddZoZduYLzxZvfVEEnqEJjQsDGISYPOZABLACWVkBh",
		@"SICbOpPHbsBcOi": @"VKMMNtoXZvkaTvuIiQESjxJpQZWcHOqzJNtjLricpVJYNSRYyeShcldZkrymDdFYSoIzwhgxAkVJjgDQCbQADMcNOuhIqOIGSGqruQpuFaFkiJQu",
		@"gRLoTGoxMzBYe": @"SlrTyirufqudECCfZRJyWtcPGaJICsJUMPQwlpByMpiaiRvcKhbyLUWcRcsGiViDFJRCgFUQWpimHZZxssKLgLUsNywFZPdEgDNqijLgEGueUxyDtcPvMBAIiwsrHMOkMpzPVdgsmsmVFgUmKBy",
		@"PRyqEkhxSZWraSXQnsA": @"LWUVjseYoMHBPNJSkciMvIYAzMJhLkreXWXcnhCJNkQIWyUoQULpQcqyraAyKmZVgsmBqjyDgsPDxLBlWACRUucaoUTFeiNELMNaDXTzjo",
		@"YIIXgPYUnIhNJNAFAhP": @"WTjwAdGdWyQYlnKxIGakFLBqXOZbezafWYACwnimjqoeUXwtdxIrMdyzrLtZBsyQQrTYMFkQNgqiEHkhOhouOmpTzaXimEKWJwFMYXlPUQ",
		@"jPKhFgNoZqSlPBQAOCX": @"EVNDKjdvPetdHKczkGZlWvNxLbCVDaCrOFeaAGNKlKIvAPMATHsShpOlgajpWVVOpRBASIilygkwKKOnTQSwrrjnogngNbhLUhrNCnXfynFUekd",
		@"fHSNekeJal": @"OVGMtBoEMmObiIvSBwxtZONaHaifqJjfAPiIrRqvVxecsToqYmkGfEkiHVMibHdhqFfOrywipJoHLhbKmvVjyJMGVKQeeYFaCAIrOOcPSHwwbGquhyxNUMwIYewIrNUJMwsjSZtQGrtzbpMrIaBU",
		@"oUrQAJqrPimfieiAnhF": @"DEqZTVBiKcgbdYrxDcwVDQoKPvkHYbQijCLRzgmLjcXYCARaeVblzaoSSwhxkGUpZPaIyEoKeMnWajtDDJOmtYOMNrHbaToovMYZjtbNQTDqiPeuEXwcnlZmIokKYUVWuBGdappVQPe",
		@"NJGEhMtOMA": @"BBhZLXDDdTxoZBmAzZgvGjHPkEusbeNzKesZxBzjvkwBogrWbJGQEIfdkrTzGJjMBkVnYkUCrCgYQWGMbooTqZbCpyNxdjRpZiczRoOQRmkEtCjqeYogLEhjsb",
		@"uXAPJWfLWEju": @"BErEvptpakCxhHMflFuxlWnSAlBYwsIzdggxgHGJnsjWfuIMbytZSXndhsSfqCnDYFiZWYHZzAmfqOtzfWTiHJpnRYbyagjIVAahozbrlZaIFRY",
		@"OdDmWvAMOnFs": @"RWYVuIYYBsFxnKtaWgREfbfhpYPjYajbKFlUecSyUNlWMArDXbXwQZDhXFXCZvIaCQLNdfVggmDAALfNtRWygPegDlHJmXaYUJuGouGY",
		@"hARojdqywDCSXNZA": @"jVUCQyPjBURcEuIkYfoaooGUbjhRuSrNjaAhztUNMUlkqSybwiiCrMGjheUQXIrRJbJKpoACjFYOhLpIoXxEcMQNJvEVgSwOSQfudbTKyJcauCzhkIpoRXFX",
		@"AnEhSdOdqyGkRRFn": @"sqWZGREHbVlmQsjPahvxdvHVdOeGuLmkVOPlfOuNyAwceZNBxYxrVyGJMcTpHvCiDfEkZBkDPudLxemGTnaTTKGcPMYOEDseTSWtiSGIZMWFNaugeGLbQGxZNlMFvWekUAwYRWNzWKYvnLN",
		@"PsOZOuaqrwM": @"lHgefuudSfwAovaglbCIrFWbgantikbUEbnrFFqjWaqfFcrTfhzQVfFMNJmmEngGfwOQPoAgrJipOCbVonjXZbtKmQzyInELrrcbCLMLWDHSuqscTRSICJFsCTZYuXlMDYtT",
		@"hYruUyooJdUeDiXuRfs": @"FnxuoxUqNoHCyfiadlOLmxkhnXKzaRrzSMqWeaBIBCEohbEgRrCVwmOjOglTAYeOwHOruYLCUmRkvRGnHIFkouNNxVOFXpEYChBvqW",
	};
	return QkRCChioroEImFdtjn;
}

- (nonnull UIImage *)bqnPMSFlTNRazD :(nonnull NSDictionary *)KDezfanhZhM {
	NSData *Iopmgtnzqglr = [@"wQweRmQBMiBXpZiUuLwDIWcZmpUIBHawkLwtmgjLYuHeizKjAXcPMzKvqfHSRNTNGHuBeiTFaxuCIrPKJvyrQjhmKjjZZJwNzKMVGYkUZecyzScxmjRFqrK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *GVnHFzOpQTDNSehKXxz = [UIImage imageWithData:Iopmgtnzqglr];
	GVnHFzOpQTDNSehKXxz = [UIImage imageNamed:@"hzvlCBtbVnYTSKjvERSQKIkOBmrFDxNeSAhmvSHgkPUuDZAVGWIJABIKuiofPNKWczMtULsVcBmKpbkFwmpqlvnDXmncUvjZzucNiunBXYPBpjmEDXBTaBWTAVfiwseFnVfxVDWtKNNf"];
	return GVnHFzOpQTDNSehKXxz;
}

+ (nonnull NSDictionary *)jrYdQTxJzLKPXg :(nonnull UIImage *)BadIYItEPvqBXzQgKY :(nonnull NSDictionary *)vfRYaNSGPbXQcHY {
	NSDictionary *vWmKEDVYTPyromHg = @{
		@"kNzucOdHpTalQMgkX": @"ahrTfFSKkSKgNdPCqZolUtkpgBSMwNdrJPDMTeohpHdoolktnbvPNKkjCyezzHrKpFQFEUHycjFpzwDEMxxqOWiGnrfLPKwYciZtXUemXsvaO",
		@"TIvNGByGilndZcXyD": @"IuCvgnxZlKTRCuKahPabVeWZSVJuuZiJaInObwpcJeHHsaTvLWsJENFVgsEmLncRSAelvhDMQhTKXhWbjNlKeAtFmsSCKjypWJkThLpykPqWODRhAwztOIAstkuiIjBbzWkNsuEjaKW",
		@"PRqETHGFalzUN": @"cqwxYAmAGVkLUvhRUlDWwkCWsYKlSVLuIhkllSxlKPnxNWfvbsTcaKzeRPzRyIZpZctvQcZsSYwKHvYcyBqwuQIenMmvPziOjLlOPaYdwicGvukumBg",
		@"jprJlpPexz": @"VZdVvMxUONziXyKXFDBchjGiWqHGXhQjtEvMDUkwfGEQcITeTvaZtiELxbXnsLOVIhwVMasieJQoyvyqdprkjKbUeWBEfPYERbTBjLkKrtMaMSySKEKwmid",
		@"LRSnoOCYaXFvjd": @"lrEAQjtfxiJgRDSzqzeuXtLowOkhHvaOSbkTzkWYjGDnpJIHlaBzinpapcwlvRMqpkSYuThphygCWOcTlhJlwMCNgDYRsIXomjYZiPHHoUwcezqxyZBoHPJoQVSOdiXFhNjFmHTkvttMaewvOeiEA",
		@"AAXxZnOIXn": @"MEZrliHeWcejlgFQjvIrZnMJKFmUvGHICYolRlVmSeWIXbAFPiMURzUUqLwakOXLhUamuABuicCjGWIgdjiOVCiHNauCllgicpecYUVgMGJRiGDIlODFDBDyqhsUyqRihd",
		@"ruUJMPYiNQmBcAnZ": @"zkTFyBdVPuViUtfdldLtcwoAKWzIRFOPZRKvLBobQejwNmboZYUTjCNRgTIqBgxmsZtIxfZvmDAadzHcjehaogwXvhQOatSKFkBmGxlRMUAppdJQxPzojNyQHagjLXssFHcMfDHccUTGFcKSBFo",
		@"nqvxyzItKtUhj": @"zxdQUIpFtyPJqGPippLzNZfkPmulvqdfYZPdPQNzOVsbTFxRjolybbNlBmbuTAHEsrnmUMDbFEkdYEKiRhQeKoeVcAOVVdEdvaFxbhVSQkKWkRbMAZbqaxkYNTjRvOSoRMCLFmnWMJzjQwdNiWumq",
		@"MiBIrszeXDRVKPNQdI": @"ZvIfJyKUtAviognBNsBLeryhFfNMhJFPilxbGzUfDfkNxXVbHUedlAPLPWPNYEolutVpEAzqByKLTVMseKAYikdIAQkckWagFEuKBzxTGxwTXIVqCd",
		@"NAQDqOwZHkP": @"xtxBuXPxLLEtbRLNRXfYElHpCXhTyJizXYITcZTOWhrhbHRMueOqNoXrRLSUmJdFDKXIdsSWffBzMObGpKCgftQgNOhDbXlyAEgBkjvTmUoCKmStpnNZMKZBXKNv",
		@"ZSmfPyPXFu": @"ZLzBgTcGRkkGWGXhwRkdCNrQvNRvlkpdQCeDrvlHIedRtmVjdpXxogdGWifHTQnhBjTxmYbLaXnWKhkGojvZzedbqQJSnaQqrhvLRGXWKyrRPlDOLhtNtugTBZpCsxolBoaU",
		@"bgViSWUDPb": @"zNDzelPflMxztzICibOyHdCVyWcUoKpwHdSXRcBMZqthAUrAfAdanyeWcxpmZcMpihXSocIgsSBkCJrKBDQgUkkjngzvAgXJFSRDPfSMLHNPVIqdIvIpg",
		@"zSteglCagtINYzWaF": @"cSKVmEyOzgBerQAjcBMciSxaZpEGTlHRxvZCQVudYtBWbnURJZTmwzzulrjSlnxxNdFlaTtfGLeHDDEEDFuzJAuJFNTnqjGbHrsDsFkIokyoRAlMgfslwvPMHOqUjnQYAxDxrBqNfuCxfBxVKWEqT",
		@"beYANTXyHLkQCov": @"pNoWtGCwbWrWqeJrYbMmSympDUUGqFocmmpUFAhwOPspZbsIDYbyvTkdVlcCBPhAyLSfjMuArJhzGLiDojvskhrKgZGJNKgnQFhTcsU",
		@"YflCoqzlYtBV": @"CjugzGlFpvIJyMMHtDCCDnOwljlBjTAMyNaBwjSvUxYCpnihDvkbfXSuFflrLkQUhiSUBeFxmQsjWuRICIkDBaEoZjrePFmOGdiQoddNnjYvkPDbGKjnNMBehwc",
	};
	return vWmKEDVYTPyromHg;
}

+ (nonnull NSDictionary *)UASFdnjyvEyk :(nonnull NSString *)wEnkMaNroONNLnXNGI :(nonnull UIImage *)ZVGHCoetLSVU :(nonnull NSDictionary *)uhdqiNjenh {
	NSDictionary *GhtwglMdyHDjpnVb = @{
		@"szgGvsyPrIoYbw": @"SMpeyziyRVdUdsAbTvvqdCbaNAjcMTbPwTsiuwleSnJMTvRLlbVFeHKdUNkhCiRFItRvhsJvjkTUuGcXzxbKoOiCzSrvPTdnXyULfqEbOBcjsitqBWxLZuq",
		@"yqsTGIlTDx": @"NDFYibtOzJWJWvcPWDFHPTLDmPvXkvVipjfRMNGUzjlCxRDfklCvermVgeIjopgwVxNhsofVbogvtYsqnNoUuuJCxmgNCrRjCwkO",
		@"GaZAXINtYpi": @"nouedldzPpeOJZTLQHRVlXzCEIuMsulPaoCYKCOOhzEbUTkGGqUwdeqfEvtIjPYTpbIHTqkQIIyYSWbDLPuQZNzkPJaLqCguyDuKfiphSkSuNduXykq",
		@"DsnkxvPOXyh": @"JWoMZElSRvTSxOwHTmnmIbkuSRrfrJGpPscwNdNsuQrPgwyxHlagaZSjOmSyxMrhGbDTwIoRudAcwABwAlingnAQIRsthnEuXykBjjSgjBIoyAziLQWwSUPfSNBPRzQGnkHEeRuXMDrMNHDaPs",
		@"ioOkRBXZAi": @"cFWlNCdrORWTbwvohahlLBLLnfdRUMrYDuttEgRsDpwqGoQXrewxKFPBwwTiWoKRortHfVlUkBsNOujqIZKErzPUPnBGwspnwyPyGCwaatyX",
		@"aTRWDydOAnHcC": @"fJsfUSYTTpVFYzchMInLueAJghxxEKKKSWHhmlewJorpsHytedckbPAGxBmKMKpWsoaeGRifhCCcoeKfnQcjGBkdzldiWoXCKBzvSqzHzKkRNUcGEZRHESEBZZUMBhaArJQrBafyYqnmjPc",
		@"OPJaXWRwCbCtv": @"hmlAsTjqfVdUdFZiafjJDVzXmYzEdSBtNBtRiEcdPokiOLURCzQshnLOgMsAcSaWRHjQXQYPcSrbKLPzmkWRbfiMyQRSPLQVtIYwgcstJbvLQkeK",
		@"XsAxdtGZfvkFkcFfWaY": @"EfRUpTOSLaoNrreMniecsWuDmCHjMMXtdQFTfxIIqmMvheqLRCkFVADmTlcPznBjMlIBtVTpTAsPvithTaJkXATexjXblnkDnIdVpppCkWaCEHVPLoHdqTXFVfRxxbaLHjcQqMUxxp",
		@"QrAjIPUXuczStkDtU": @"dSNQumNynTKhVhXGtpXiIyGIgNgUfdpQkVRPpvAzfMCrdoGQagKIKTKBSqaRUMeDxBhLgbLGQqmiqBsOKQgvDlmOrOFZWzIBDPpfizFwYn",
		@"GIDbDrNxVmVh": @"ZnVLfnhfiRkDfCCgkDhOzsrNxcsDUAtmvaGtEKAXSGEdSzouNkmJQExUIaZLXgzRGAfYlFletLMwiTgQfRrQlOiDzuEPFbdDyhWJERakGGFLJKxlx",
		@"JSnttFpqdOf": @"zXLgLGncwSQLLkXaCbXfSfUBGVxekdxofaLtcJTXicDXhzuAYGcjieumWREfEcVEqyiyHGhykUbRmdWuRJrabiVGSbzovtnJfuVIERFfmboHFuRRmjRm",
		@"owKjYiOFWXPJGsjPXf": @"lSfAjtiCdJeMcxosiuQNtFjwuwBtLIVEjedjKAuKHahZyxOHtQterZGLpMrlLRLFximfHTxotigJKhvJYZSGmJwZtGXAUYhyUQdcGPtEKaRLkDCnhmRBHCxGClAZlvcK",
		@"NZQuzNaDWwWltQs": @"YObhZYcUFccwlWVGpxsxUZypNOLvowDUMPwweIiiBxfjXygmpnnZMknMJpVCzNCGsdxIrvgtYBMlAqsqFfBUgRpcTfJQOHMthHFKxBmmgiCYSnCOqmREwGTapQggUAouRcfEfZFJUqRxVWW",
		@"XiAgFtNNmuAcctTurS": @"wVEjnVruvOcEHGblWWhydqHhUhbGOfHeSAONnFOTMaKiZiKumPSAdriqEceUBXFcbkKwzIDPbpOnenUVOJbbaIERSwowjhrDhKDoxz",
		@"mTjsoUGSGbszzD": @"yIesnFmLkIxdJdREuqhTbxDVSyBZyHgNaBBoEQuCQlklnTmgdUtHzmrKlyFiItoYhwpWBZKyTxIbzbmgqWLCmfwhVRWoaRmYkGRdBAPCVPzntqxTNhipbSqjlAipzlsLChZliRjfLK",
		@"FiBqhEfbBjdHkWDOg": @"weWyfkpHhaaPzgXMZZqYtzguVPGDjveomVzFyjvQOfjLDUtQtBZhxPmzsyRnzkgCQskvtUHpDbRSSASThhOsbJzXLxlpRgJrkNfPvTMMLZUTNaojk",
		@"HqIrQNhAYDvUbslyl": @"LxqVwRayKnHZOMcTSrYkwfkDVHJSUszhXbecXpmgSBxfLMefbbMnqrEXvOADeAhkYMTFkAvBeSswGpCkWolgAGcoQpNKIOIfbnAbImZddWBtsECWYqZkhXTM",
		@"DOsvYamXKftJ": @"kVEsLShcWNQcxnbyReAmlWSVXpxhVDsAtCiRDaJeJsTXTiJUNmTruAGmBUrBejWkLGsboDfKprtvEnXIamNBxMsBvucbWMzDxUvmzXtLtylItJHlvbsdtmfdOQmMQeopyphaRgvHEm",
		@"JYUEbyxAxlWw": @"ZqXAQYTiOnwXOGfGlmXwOEuhjTgJiMjRHKroglFDxeVkTgcJPTvwNQLbBJsWnAgtIxhfNqLnHwypJesTGbZDqqvVgIScuGGheCkumXrDvsmaTdeVNDy",
	};
	return GhtwglMdyHDjpnVb;
}

+ (nonnull NSDictionary *)FXIxtpRFGUeTeIwvKu :(nonnull NSArray *)BftKZtrnjuzCpkFKWm :(nonnull NSDictionary *)wyeYVBXPCM :(nonnull NSString *)vkRCTzTEQa {
	NSDictionary *NhBfiardcPlYFOitkH = @{
		@"poLiZoVHcXYd": @"lmOeBcGyLCiSMIQGHBDvgCThbFXzdpncboYVcEPCJSzlVyAikiNQBMsbzrLcnoKTDjMeYjiOeTDXzNzsDodbLKtcgSZHLXfpLSeJGsSdnGphYuuFnbfmsMoyTeGXnYJRb",
		@"rLRzUfeJJRrOcR": @"qTHKNwBUxhFXFjvOgdUoKDsVyxClQIitiLoVFPCOHbNeBWwKjxhWFLjRZxumWQpIcCPmoxxyIVzPyUSwCMsiSPUZwpVoKVloWnlrswEqxiSc",
		@"hXONNWJCjRxWBRfh": @"oUwBYLhmCrXXxeEKjgPrrOwmgXiRVIDUiYVDAdmsjJMMbHxdEWdPSggcZiQqIoPzDtxPBZhJEFHTOjZyXdAwWEaUOFffbydVozDwYCGQoTnKerDGBwyLxXarOUO",
		@"dxVFTWuNvqPszTzx": @"jswckDFDHwHUHjiyRnILFmMMBchWFikwitPwCNEJrSWaOntAcGiCmRIqtrEBpWvATGJESvXXsRIDEnxfKOyZitCcmHXqxrBMVjmqRHaKbuU",
		@"BFhKfpNLOJ": @"GgTuufYvqfsPcLBMKuvmEVOpFoiAlDOUKYRZSDZBTezZjKjHRgzCXwnfbTSpsUcfUfUKLFZvRaEMildqgJFGcaFKGgoJcjRjGghjjDvayNlM",
		@"XTuVoNbFbsTtroJ": @"REPdYTyCBHKQTfLNUBsMkYoeSCtUEZixeGUKxkTgvHogXuhQkrsILPSUCJJvRGpzAIStJxwrjQqjGuNOroSuAzBkfaQmQwZEVRrDwQYeFrnyzLmSxCQikwzk",
		@"kFBQUUSJMLZC": @"PBcvGlGxqfiISBkpcJhLQEtIZekdwxfdRYfoVQdrNLiHCZFytofNhFHSMyluEOJOfISmQEoZOUkzMzMZvEmQBNYYCwFgUrzSRwPAXzgxDkKsQZDeYwRVoPtTIEEwgPgwbLcNkpYg",
		@"aeDUyNCySSNTpYZT": @"oiNonOiEWipISubqRgVjtbpDHTEHdzaRsDkVqBKDanxuxZzxWiKivJBdWYQLLRqtsQKyAmpnYlEqpgTnfRsPBEWTsSOmsckcwgIYqQSVjVZeKShXptKICGiwhzIYytds",
		@"bmSitvVbPSgfnxtgVPm": @"mxJXXATTIzWMyvlsAaNdoQiTKhuOKpSCUIDYhyMIyqGsoLPvRmmvocyPoLxGHVDdQapjAsZPfDmcMZKRITVNwBqHzMZzMqtkzphhSGaKkQwEhzkSorfVgzGvDGNKYOcvWhPY",
		@"vwZBzjeaxFiWsXHUI": @"wDtOtgsOrrrcngtHVxjkwVxJiPFvkoiVSISJAHQfvZCmDATKTpAtpGqhpvvQlBjyouAhrKMQwKDuHxEkrhAoEhjPnqQouHgbUrqtzqDRpaTBafF",
	};
	return NhBfiardcPlYFOitkH;
}

+ (nonnull NSString *)HGFJAJykHqrYLetjhF :(nonnull NSDictionary *)BIUYPNSQCCyLSiWdO :(nonnull NSData *)SwxCOQiAtpjX {
	NSString *xHMOGYGOrdMVRNq = @"MPJFHjEWmxTvZaBypBHfIShFOzBWtpfglKezSYczwSnUHCsOsZpDpZZLpsDNUTzgzJsnoqvCPaqnYeBhufmuJUHvpRWryVapDsRNAt";
	return xHMOGYGOrdMVRNq;
}

- (nonnull NSString *)JevoJZZZHZkEy :(nonnull NSArray *)RMkOnbpyDwF :(nonnull UIImage *)rWQjlcIyGLkZ :(nonnull UIImage *)SSNaPPqjaHz {
	NSString *MZRKPafbddKFrPVpQ = @"pdaZyuQGwqqhuNoqMHuNooozFljfVCBPaXWaoIQLsgPdepqhvmKDReLlKnSLDquypHEClXUuytfunmaJVmeApXwPQlZhpNVVvBjNHuauGaLZoiPOsajjrF";
	return MZRKPafbddKFrPVpQ;
}

+ (nonnull UIImage *)PacHilKPXBmkp :(nonnull NSDictionary *)geinOVFqaLyCWWrAHh :(nonnull NSString *)nmHEQNWKvvhR {
	NSData *eDmKtdzdciUyZ = [@"XfVxgXhMVEBKRgqnjTNkvQZWuxsEDdXVVBqabyDQCCiCSlVyVARpPAeXuJCNsruknFJxYvUwnRJoHklBEMOwOZYuAzCXEqUMUUdngtfBBcbhuicSAlrohnjxODzJMaAqQgwFghUWgKv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *sWEVtdJbEctaKgqC = [UIImage imageWithData:eDmKtdzdciUyZ];
	sWEVtdJbEctaKgqC = [UIImage imageNamed:@"FkeKgcPPxfVydjSjJAJtuYCIBjoFPwvJlTpbAVYSJZATzhrPIANWXDPUxomhEJHpwyvAgBxmbhoJclsHLoqDNpokmwjzheRXGoXtnJQhcfNBtejSoeiWQfelIkqIMhJsGHiEEsbVMDwmtxiKN"];
	return sWEVtdJbEctaKgqC;
}

- (nonnull NSData *)DQHvOSlkVuSqM :(nonnull NSArray *)xCyXAyvGIEAnIT :(nonnull UIImage *)KLfzMPKkkzVvN {
	NSData *CcpGmZnSvcRSRxq = [@"qCGnFsXJKhTOzJFgErZGliVdapBRAVPMPggWrbuspwvyGFKaohUlYozNNZgfTkGeyEOTNRTntdZctODYfmxdPQUMshCwCbJlQtVGcxUuADuIgzuqPbeRWjmFwvqDtJIOkdHnlwK" dataUsingEncoding:NSUTF8StringEncoding];
	return CcpGmZnSvcRSRxq;
}

- (nonnull NSData *)fLqXjgmlbyAMi :(nonnull NSData *)bXrgKrMZqSunZntcY :(nonnull NSDictionary *)OWaINvpFbSVwk {
	NSData *ykawtbkMXDf = [@"aTnBjKlxbtEVkZYRQFFGzWnSIkuAQYMdyHsDRUfknjtsqPsCWZMeOJTmzaDJlYzdcabRPeVLyAAfKcyCseqAWxJVqRCghHUnTPjnirrGbwbIUagTT" dataUsingEncoding:NSUTF8StringEncoding];
	return ykawtbkMXDf;
}

- (nonnull NSArray *)MUHIhaQfsOZpwXMdG :(nonnull UIImage *)NomwNjqaBHrKbEY :(nonnull NSArray *)HASQIjSVYEIyZcabSoc {
	NSArray *pEmzPwYsjxB = @[
		@"pggGpMHmaWshEdGoMowFwXFDZlGBHooPWKrKIkjejOeQJdGKSmWOgPblTpefELEMxlWTITslPECMgoajBPSePLdrbrQyiLGODORBcMlmzSBcYstbiDBkKfDIjzfhBkEphswo",
		@"vEuRHwxmCyvipzBwSXZhPbKjsiyfBGhOtNhoIQUqVFRiknxObnqkjFHPMphgolyPLqUGsWiIoBkDUgLCOMpwsNAHCZwGmXtyeJXKyLRhzqVGdLcoweG",
		@"MNkrrZdrUapTRRyrWSjMuuyTfLOzbomBtgePEGfJTMcprHoBtZDHhFcxCEQLvAVwmjrIOtfnlRrXWcmXwnuqwLEpGSopDCImCpPOhzXq",
		@"pMYrlozmRyayySSVoCtXdNkGaWzEymJbjAOLbwZuMCOZWgAxeSWiTaBpzoSWCiLkgPpLEIcTvkxZZfoywiHyJUNpQHelbJOYEvzPlDaUqTAgAWgacPY",
		@"xSAMaajdzaTiywnQwhRVZWmzrVnlCvHBiLrMiovboXTzveUxISfZjPGHxkuOadebbQIvOOtIhavbPvbjQkMCajPSQDEEWDPNiUHXvEBwsXsLdNtWSyYUNVdxaqzooYaBkaVymscySNYvZo",
		@"wQXKLTORFfLmHyclzUwbOLJReqzLJqjJVOTSzcQHXZrLdMnzFguGDDRejKGvIoAWHNqzKtnyBGnxuxkVdHIFXEUHEzDKRuxcWQQnsENOjtupJRAGgiljVTvMqKzhFacJ",
		@"PUbFrkMYrMwhAbryHNFLBJGsCMtcKVMKcouAlPGdmSgMdwBlmffwFvPaSGGyQFcZBLHhyhEcpSsByfrdhKNPVmeCfGwCoUDymGWFQhwGAyRjvQSgAQymKpgsTsNbZeCRajrGugFP",
		@"sPFcmLXHLnVSxFfbmXTgmYUnjfgasGheVOhOIicqIhgPNPFnJGLYDOPUOuKtZxhIuzdYVFchkAYAZFkPmZTbtgdQBCEvpbGvDUPwCTwJgnvnBDrItncUQNTBv",
		@"juRgHjcshlzCMxBGukxWkqnbnIcSYjHVieYZZpItmddccRipUbYYwGdNCPbLGynJUncZDXTPIFlsiTKmMgFrKxXmODDnFlEMwQRJvHXODFDhEboPEdfjpbXtxExuB",
		@"LnXhfXHMVYIVYCmPLQCJqSMkszplrblYDfeaPPQrviWCUjtyzIDDYQzNyQIjbVowpxzNFJxFpsboHFGZjUznHctaGzIJGqCnYqaQztg",
		@"QiwHfdboldhTewBLVksdoRKZFSONTzOWUajvDJGSVYwMZjvNyuQKWFwvBssEEiaMkUuNPlnsAxtNjmUUNKvxdHBebLXsqcJJvnmPBUKbbypUA",
		@"TuUSHdgaxZByVzSljDJAEndQgZGdntYcQDcMQKZAfQswOXoSWAaRUlBCcGMvoRogzIwVaERByLNriYBWooPjZPhqLFsWxquGqkhWzbZkssFzmKqtkGoiEpqsskgrXUcan",
		@"jwkePxyfWdlbWWmkVZtXrOuWimIvXwcfDUAuyoBdRQLAcFqPzbwbFFlsowXAigJMfrcKDchNnMcoCMIUjfzbjulnOANGWUsWKzQtxhuMzI",
		@"ZqMvpYvAVRNUSnujZfqKtkxeuFTUfIhDFoHcJZFEBZuGOExRLcrWcDtmyZjyMLfqqOyhRRWHZwWAQSrQAvvNSBMwbpWZjUJWWwAiCkqyIjrJrCVfUJthYIOAP",
		@"fjNhtkQBwWbRJsybYooOQHfLVycrLhlUDKUhpgFAnJXMEeYRcHjfIwiWRWVuVVxtEknnjdeHLHavcvCTKmTSsKrSRGOSjFJztpIbpkJJEQjjUWfgCjO",
		@"sCljRFFFZuZwASWdBUvCbPDurWgvbRWocMJEXdZkINhpMaYbkbUNkVWrgsYWFDTChYtsQWbLyqOhEMoIJVtNHokeIxOprZWSFqwMBVsZozpbighhsWxxeUfPwBMWPKadYorrYjG",
		@"ZtUsaxTSWHaeqVVMagfqLDeaSsoWSSEbbQhqBdwemmXcdnWyECbRkZGDnXlocxiHRIYCvrXulhrJNpEoADyEhZBkGxAzbeDqGAqbvdeD",
		@"YwLUnSbvKzECyUyWOQiwDaOGIREgqqQRoRxfVGLaKbyLfAevfSziqOnGfqpynzllyfVjqORnKywlntYUXoDEwFDuiOaXDIyjmLMJQTGkvYMLCDIZJLnUWImsPiTQEpjvOFlqUctOpKyiXmG",
		@"lmgiOmSOrTgmEMSJlSOhKdjFqODXqJqtQxAmRrrWaAPLCvtPeJWxOCpAsXAaDSDZSOfrxuweMKgMgVYszeOlhfEtlSWZxWCrpcQwTazTdbLjeCZOnanwmlVFNS",
	];
	return pEmzPwYsjxB;
}

- (nonnull NSDictionary *)VMdRxSpHEQ :(nonnull UIImage *)OpLKIAABhKfs :(nonnull NSData *)plSzBFaDYpNszwb {
	NSDictionary *RpZRoImjqstlmLZ = @{
		@"urxYtHDZXNG": @"eIbtHgVMlYpunhomedPdfnLTYCZTuNXJNpVuqCYSVyXKyNqjMhuuZSMUEKmBTEtDThfKtdlgyoXhEJRJzQdzDcCTyvkLQlsQKqMDsZsftcBKrLAcsltzEWzxORihVorsUwx",
		@"HxVRQLuyGiUrWGWhl": @"uIbooFMAOHrkHjhsbQmHSuudgZnCebgOXXSFqPlUuQTjRsJgcjBjGoRbdlAhpLZaKyBWKxNMdstysoHTwDimZyDmqCOSKVdawdIagmkbGaxpbalnrmUdKmltaeHSTPdSxdWpynokIHI",
		@"wEnKdeMHWEhAZhQHNwO": @"XrRgztgwMUTXBuOsukoGDUoXDrwMlObdDROmkJAKiLcCRmzhBWTKcmiOiaBONZOIXnQpbEeRHjhDfXnbLpqkmdTVORDKMEflqhihZH",
		@"ytEPkQmMzOEB": @"QbMtBKoNseRpEHgEIMWHYcHqlmWRtYJuyGuVphWgVfeXUBWGdccbHTmmlJYSuOGSIVHeGDYBTMDctCcwxtNMyzMVLqbIlOmHjjKeTcwaVJgYGXWLYLdmv",
		@"vERMarWXXnQPms": @"TGYIYqNglLuKxlYcykNjpJXdzWYKZVlxTokQhbtRLvYRESgmcVxKNyYsrrmWvOAyJlnkasUZFMcBQcAadmipBEGmjqcAyWwMNgXgJzuq",
		@"xQkVpJMYCNdQa": @"cwDlUKxYYXfgzKLtBFqdjFRWvUOSZDaKdcuwVnJjvntONZdUzwHXAmRfIUUxrcStbjcQmoKuYsbfCvMUZWiJmLVcCDojxzHKbxUtsgBOrxOqVGFUFCFbzsOZsegPsZMkkUYM",
		@"gteXVDCOrZuD": @"zBNKZjvgUXuLAUWoZWcNMBIhtkCBCObmiiWZZyGoBgNNBbZXRGIWdQSlPnPEmBJEiiChfYBxyUMYGKSviSHcDtgVZBTaNsanfAMvectmeBtrE",
		@"XTOcrBlkqgmZlC": @"SRCxkrFtbrXABgEeWJzaqnaeDsWBsnGDzTAIZUouWvvpODvVGRQnJhTPnQrGaChbiQVDjsfNKRceioGikLfzETZcnbzRCWhULhmjehoCRXytqGcTJQWuaICamXKPgVQPedzPLVDnZeDQKSHJCnptF",
		@"NwuFVoRHYsO": @"iHbGxOUQOVudCRfBGNptHPKFnMcUNwcNDyVVRyPwZRdEnHlbZzTLKgyDKBMMnLJwxsUikhKmaTOGbzGrHHThXKrAYxmQOjDTIjtXmpoJccegXOokgAlhIbEMuFlwwILaGUJAnrwEa",
		@"yLCqRVrcIzl": @"jIgLBsSrzYRbsGLyQgQWmuAQvfAPSuivtSyEIJaulZCmVSiiTsHvNORHMZiwnfODbLvnsOaIlCVuCszIzeHVouyFzNclaiHcJvbgqDUeHYjdLqqWXlrMJ",
		@"UrrejmjkGYhDO": @"HIaGUeKmZoECbLFxfInoRrCYwsSedgUyCgOsarOqBdrwCzpzhEfCVQENzzvQqwZFzzGISJWsvduszwnERhlAIQmLbokemPPUVSJwEBVzJDrEZwbshbYiagROJwuWVjXhJ",
		@"pjicJsnZyRoqyi": @"SDrjCpLmYBHEDyKGSqSOPTqDookjDwLrepbZHlqWkHanZSYYzqTZWonnQwgVzTUoroYlKGiBpOHHkuaqfRttPbvFSEKBsKqtjhkTNkpvcLeNKSQComZzghVfpNbaOdSaSeZJhjcBuCkUkrIhRmt",
		@"uhftSWBnrIPERqD": @"faXEFqJRUsYAbSVnaCbmfSXwQPZqdkXsPVElJVtrLXLAQQsMFCuCtsksqfudNpnQaEguWcGgBsVJWqWCoOqRpQzrskDAEcFyOrVtECaBtOxKECRvPaquTuR",
		@"QdTkCeNLEyTfOmSirMy": @"aOptMhGqMnHjxXTZhxiNGtmiQanMkaJlhyesmkIZgbXyrchumlzhfQuiDzizpPPFRftOXdevfcJyKHqUuoMjkkACZuwfXHuyyVxbaECwupzLeZiUBdxSKxYnnQtKvdyectoHxSJ",
		@"CmJOwpxcPYFGwpGlar": @"ggPuukvmfPIVIEcxTRKxbcIjhladwgBAWcrQgdkUxeUjWBFqCdOeqVigiepuknuzlDqQpMcBDPYLKTiBYnYpCPZcrUVuMDbjVRHdAKsWRiXtriJSwqjwGoSzWhAnCGUgajR",
		@"GhxLlxJhWXCogBmdnE": @"XEvYKAeLuDZtEaRLUAsHMnUrwMQrngcYLfJJZeWfWeMQQviuVmNHMjkbkWkBhhaHhpGbJIiYWbOcwmXPcHOwjBhXBxKSDqOcJLgiEenAesICwQThtCvCwH",
		@"AoYDjoWlEOjfGMYcp": @"dAcPPXwVAqoHyRnfISEgRFDiGyJBwYXmRrzkHosnXpjucvGFzDGUmRvKDyADfIbsqkORobXgXvydNZEMWgyufKjkKOSNEriCEmJkUKrULWSeGFjBDjsjiOtrRmWbGrMljdxvBeOz",
		@"ztIYRWeOyrUvYHn": @"DBQPgVOEPzicYmkdpNFqzYxvXTnfZitDTFVPhoXuAndxzLSGIODOlKBFZCPLuDSQejlOMIkbIyVyPiFFufsUzbYloSxKIYOzHXBCtgDMjFOefxuzcxSmQUhZYsxykxgAvA",
	};
	return RpZRoImjqstlmLZ;
}

+ (nonnull NSDictionary *)KkjZVtHeBolbROCSX :(nonnull NSArray *)nKIeMkiXyAEDMkY {
	NSDictionary *yXPtRyTNpKCB = @{
		@"DVuuYPdFXkfupg": @"hjdWiIfYMhXQEThadgwXHEImINVhiAwzASxjoaBxSrCIqoIbuygJskKDOYJbydLYYhtAuxoRZDilDYnazkBzBrsmiWJZJOANRUaNCRllwNHpYJwlQmFCxsknYTAzPQUDnGpLjVzbwEm",
		@"FHZHsTkKkvjkcePos": @"OlYoNVznDEeLpabWrdwLCQTaGBmpgNTeJIJVmusnRGuwBVqjHfkcIODFXdTaNxxxobrqZYmphRyAHXFsNFFHxeLgMWDTHbmvbFLIbSotbxiSMwjlvLwzMowuMXUZ",
		@"YjWDelFNlJQvN": @"ebRvJDhEViydCDvTqSAciiYORAQBKxuGzcbfMYZiUXgfdxOAHBIhPboSnvJxeGgAngDGikvYRbXsIAOqxwhXTGgkZjNMgAjmyFjECAMNpkssLasqQJzYDWrEMvetFNqFMxncHdflFnq",
		@"QtqmFTJDfXGPf": @"GcfyvDBMQjfLOlIiaxqwANjNzuMGQUHlEodsXBYWCzdTrmghwBUsGfBUOgPQIUAVhuKisvJRGFbEFQQoxdjrieSnxNKMHRzcxaiorojcjgVxhPCCdFinCIqqMgn",
		@"yudRiTmaNFSHuV": @"ygGJqqDvTmqohmdFMJPluArzulHOwFPGNBajuHjAXBwVqbSKXnfFpgWuOQUAHnjRpZKHecFnXneYPTuTcPjdzeGDpsCNziCWEbeIMvJVDkTIOneTFwXgiMqHBFpNAoY",
		@"iLGZwKWIVPwiLzXODDa": @"hYOSobLFOYiMYnVllJMlDgKDMWbeqPIuOzOKRVlIKTHThQBHMjkvdZsFajzEQoVVWiUuLoHotPainNlJHfXNtZKtFfgtkYBJQblBfVIPjHJsXzu",
		@"nuPBIhFeFtNynNmOpuh": @"XkrbTkUYbOjVyCwQMZdZaDJvtKKKAywvmBelshOhHStlFzgGZdgxRduvRQTSDVkYliqLyTrtBpSlFosQQpZyIUeeeFoKnlTkadDJifKdbhJVwUYzjoLSACbKFVluYyAXQq",
		@"VglqsFhuvIaFCDxalvU": @"aiemuIdGFASUbsEmqZGfolzFokcADcXZdwzymUOSyRhlHYQFCQLcqZxidilLWLPNBmqThLpZDQJCcYVXtHHyVZeiPEMuOWdJgnAxXJaaaYvufnsCvXBZXnCdyKoVQIfguwiEPtBHUUtYhsRAyRhJ",
		@"ypnLkzgVAtUFLLcDyCJ": @"vAJPRgYoolyjevRnIgiIVXpIPCUllmswrdGTtjyFjjEeTLvhWjmSOgHYXZnCrhaAksrqgMaJGwKnrAOEtzneBcmPeixSaonpENaKFUHEdoV",
		@"tSxLihquLwluVjCpssW": @"UkiidtFPHlsToAFjrBhZKdOzWJGXTKgMqWslYcTPghEwxPudjrZtDHQHkldAIaReUIiMUfVjvqqABBTebLXiNJmupKXAaRtNMGCVqz",
		@"nhCBBApGaXXM": @"GuDHwuaCZQLlQKWKQuytJfExUjZqOQNCcyIqtyVHKcbeJHPdRKQwRSZSBiupDjwmHgLobfbAVnpnPhLHKMXQRHwckJjuQjcCiqTwjTbQzNsC",
		@"qLugxfXrdInv": @"DXIFmTtZvsFcfEiPGslZFxEmCmDYyGUNnDIYTSZBqHMlgDOhWiZEAsCtxImZGBQCgUkdQEtCLVmHvAxdjPdikfYgRzZPFQnfByieMgwzbKiVJnw",
		@"uDrcwVMqyVIy": @"vZLRBVToNHFabcPVVHspVpAvOBDovWTYufKmjpErswNAkrKjbEVdiNCLjyiVyMhxOhsnrkHVMnoWWipdkKmEAeKgjTNfxSlmZHkqUtDwddhHbqUgfUsTzeuheu",
		@"DPglXDEgxWg": @"NKTUpYMeoEVelymHbrXxWJsReZtvsscpsepToCafxGpwRPSCHBvvfDlMnZSdNnCelWjSfAZEChxnhtQBYHKQABXpGkuzvCdReCRnhpBpgAMnqMBpdRoGWqCVWymWrvsgD",
		@"EEExblEUwzSSokoTPXI": @"KoguUBjUpNpdVaWkcsHUnDHktepxLxToEvbNziHqJOkExsBMRUrhFqVhrFHEHgelvKFYXgIVLpaAtVpmoUOQkJOQyvzKdqtTDSuvLupVZtiubhFIXqmvEzPAMRrBRglVxHiUoFjFHXjC",
		@"KddZrUWdadtEulL": @"lMwVCzoNWXLMSoXvQgnwPiClgSrDOQxsYFHfprbSbAZwJTXmwXSzmUknxcgdNbhnQHlnHigVmxPGEZkmwOjlwFflhozimevnBwJlhtNLaLZwFkFCqxzdzrmEttMsqDEsWXonPkeYhaimILNDulzk",
	};
	return yXPtRyTNpKCB;
}

- (nonnull NSString *)ygtxCrataoorSZkTTja :(nonnull NSDictionary *)iBMmbVILsuDekLdMRd {
	NSString *dSuHSmsAxQ = @"uPdHVHuGzBaWvnXWVVxZduuNDyOFMGLgPgaXyeLrTMoNuvxTfOzsVcvBWcFizNsxLrZYFuAkVoXFUsVYDazWQMOhvKlhTCZWRFmbPiyL";
	return dSuHSmsAxQ;
}

- (nonnull NSData *)nmamMhZaOJ :(nonnull NSArray *)nCsgAUVXgiVQPKuV :(nonnull UIImage *)IuWDeAyCtFWwL {
	NSData *qGqSIgiPuyG = [@"vnyaQdoJcyHIEaYMYfzVSSsrIzEMCUEggesmNPUjeXNRMxhxjqAviMPeQpJtHsprWEpAmKorBlQhQohHSIoLTFRsSjyaSocHeBshvAcHvNpzGh" dataUsingEncoding:NSUTF8StringEncoding];
	return qGqSIgiPuyG;
}

+ (nonnull NSDictionary *)VmdQVHAeZRAEVkzL :(nonnull NSData *)deJCpJcvfeFODAw :(nonnull UIImage *)dTeyzcBYem {
	NSDictionary *sNsKcfSDuBuYLn = @{
		@"qVEhtIhhjYMcTnQVCJ": @"kPDqRFicdosefwXmhSbdCUJhjBgIvUzIRoqaPeiIxBHysSuCWRjKGjnwcBRHzKLAHgCsGbDcgxgntSHNoLJlTldYqPbjFmeWTbJqBzBBSyrSElVqXERNulUHYxPNSSNbbLxyoafXcm",
		@"wsaSnNhCZPaSG": @"WFROFYYVGvQCBxopngtzWKIXzEhyIOaEdXkYiiLEBUyBxtDwnpAbUKHKMMtglDRuqjwjfoBsIrqiVgYkOqZzhFDnEouWDTTIYekhWQFPKBeIWBymHrVw",
		@"RsCbPhdkzugA": @"VCiYuxNmvtQGQjMMQueqbwojDpcuKApRhWeHpPlCfgDwukZltAeDxWMicbtSHTJSQKCObHINQCIDYlCPPvNRjezXBmlfqneOeujEiERuAQYrusIVwZoKpxjhRPOahLrtEMOcaX",
		@"mXCTJRHKCagmrc": @"BYKrtnFwrdbvolJLAbmelsxNKvRKIxqoewSXOYsmAgqOtqetUfgoKYBWiOSBAnGtmWypMVqolPDSIKGgcsZEgiWdqoEeyxRoEXslmBq",
		@"xmMnGIeowpCQlKdAug": @"JkiWYQXudBbduxbCbbhFypIvlSQzDbrSrjVQIgWhxYZWEEKZrAqZlSmcDShPdCbEKQVXwigwQhVzBxDAQIPuNGobDhsQvQSgOTPRCNqAfnAQYCoMjZbSKXexaJbmQrRBbuhUzFugvhALZCAT",
		@"CsuJvehaSMeSVDke": @"UbNJFjzbNDSotcpfCmjTBGcgVzGevOAFSxMoYmXjipzbhvGngYrUkeiWaShgSFEXfJUyVuNcDwskkOuXtajrVkChWPqHkAgnEZlyQkcsNdP",
		@"tEKGJsQPWVWImj": @"uJILsBjCTvhZFuPdFOiqMIlETpkqWaIxmqredYVZuILgWqWignKCyZTCeBCmDyjQvaZVvINQmdgODXjkNOztJBJHbGozsXWjPDspXXmrKBrVJjMnQpkotDttODusOoLCopPWYdtNzBon",
		@"MSPHXZPUqFHrT": @"hQETynfgiykPeJtSJSNXiFPfsvYCkNZFyuEcPGmrTnXYDOfsVvsPUagRWDKOyYJnZeOLlTzeVYaybRDFahTBkBMjKSQPddLZtiLTizMvrmhrMPxWoFJSBdJwiZTmbsZYPSObKpnFAztQlYNlj",
		@"RUHgJMeXdOUf": @"kPJyZXNFHOcheaViRjyosodkEardIrsffyoNWnQdoVucvvKRgcDdWPfqWrXwAmyPruvIGfmPuUQFucwkzbwHGFYffWQBnivjMYpfbLSutsJ",
		@"cKttRWpzAfIoWbf": @"yzGudIbKUyHodfrbkuLsSyDrgpMZYCHGmEcLgiwKtygKoxMmWPrTEFYxivvLBblJkIVeBgCdFBryiJCcwuoXRdftIlYFAvDChOpnYXudueYGlFV",
		@"VJsbBsOxIudIl": @"zRSYryyeizfwuJsgDbpwOouQQsoMmJCtwFdEhrLLBVcuHhTnmSXBUUeknjGdFPHxxeAfwGvdJCGticKKWVmjoPVgxSkdKEyhVytMNQnToDtWetcitdjnd",
	};
	return sNsKcfSDuBuYLn;
}

- (nonnull NSDictionary *)kbnyEDFnkXw :(nonnull UIImage *)BKTaWsHnNqLZ {
	NSDictionary *oiCWkxfdnvUAerr = @{
		@"cbBkykoomI": @"aOgpmQPkKecgjLRnmvrJiRXuwuHzvuolpuZHUmFUcBcfmXMwoYxmSCEWnEiNlQpdglWMAekXRmZsFhEmgFCBkGKJENGngSlAiFkPJVfIAgPPsJ",
		@"shCflhuJPSSIkOhjWh": @"DztHRlsrFBgqgSzjavTrXlGFkiFYWPyJQRCtOEQZWfmMOzQyJUaBBUmNMMSGaBwHfOvukfnLleypfhwFZdTrRWjYvBgtmGSdAxDjsdhPfjlBOEsYcvPpkkkLGrEAvTZcFjBpDjafoXudAKU",
		@"FZFHbdmnKzmWS": @"HIYEWHKTCiIHteMRxEtjMIiyHIzjUIcYhlZXxkLRNVxgoIxYxtswigneEYsoxKzbnWaXPDGrBPXNIKhYAluiBTbDHtKwpVoeKlkCYxNwEdGJhUBfpMeQqYCRRfAsbZwSjfsNiJVcRSneiZ",
		@"BfujqJNcIOGHBtwU": @"ovcfjBTLWDpMUBjsPTABKnhdnFuGPuPFLbrnHSDFlMGkMxSxUsBMBwiObJGaYOXAXzYQAQTcpzupXkTdNoXEBbqiSitkNesHIOfWhjUDIWUTXBPeyNpLKAArIZqyUVqF",
		@"HYMkBTOuaxiEWYw": @"SoegCvttcWaFmfIGoTmbRgOBwMXtaBFLDfrIARbaUayaSewBTiqyxlGjOIPlkDbxRxjNFarUnFZrfuDEwdWZqUwLiVNvJxtsILEikOwVqRhe",
		@"ANtOROULQv": @"igLLQBnTIAQdpirMjDOqHbjpLOsQcnNztsXvttbbrjFitHUBnhVHyxOXmEJMxtiaxcyucxCggvRFVYMwRRQMDEsCiULGalbwYGKRtMHCl",
		@"eElncvsBiwCMOUsTM": @"ujHohqFimpCYsTSXohzQSxAilymGbYQrgPlbsDftSZvirhWVCQDkniFqnUerjkMzLdkZUsloYlQMKZJJgcMLzqGkDGvkNosIqWGefqZDBHeNdghAoYSCy",
		@"PBNwsUzTPKNrNxaLGux": @"wwEKUIlZeAuxqiqCReDZelhWDQZuXcJWLYpiYAQEyaxmCNjkjVXfdVAQYagGcdbnWGWwTClsXGxJUIWKaWTBmzTpsXYovnRrpmjfoRYxFblgSZUrrRJMEenH",
		@"kuNLGzmCeFafKARX": @"zNJPAKDGiKgotsdnCMCkDpMyGvzcbHwUcqpnwIbqujxnOUPRNoZNdbCvZCrlNTehHxMRpOrWhnkpDlCjZLKIxAUacPoNEtCOWFwNSWnYnVjKGWTifvlguFmabfdnLCjlGInXHKeokxEwWssLVEus",
		@"icgtAdhkze": @"nEdJYFmIdpPOtypaDwZqmjXBSCqXizsMCvmdTwflViestYZQuLSnyyWIFijkxAzKSkxehNxdXemOOAMNJVZhUypalafysKQVpmGfsqM",
		@"MuVpBYfghbVMkLq": @"bpQeonIQjOyhkNIKJeZmEyEzAztnBTpQQfoUrdOGlTETAxAXsZsSSubSkqSndEdrXhOCoVHIokCfELdZTjQJMAodZDpAoudhABYrhPTQGdAuuEDMfuehJqgnlAeXFHXPCfuKQnbeXZNhWIbWJcBN",
		@"nJUvUmaGOxczccG": @"lTVacHQFmhkJTDyEcwrdFpPAUKLwVcGfjIgweyrlvebvrQtyDyKQAKWktuIGScpqTwsbFKzzVMwfFkFMXDUEUowkIfmCafRwtNKEIFEzLPxeBaPAjtGh",
		@"UEoBUJIQAgBaX": @"YgMedJUeGKUFdaDXYjzBrcnRhxnHRoRTOEiXjBecDvbIwXiEBbXZWQlSdBiltiAyNHOiqhiHTaAlbiLdawNuGIMAgLwyTPqeDSfVfIQGKqPdtHxEorfLOstVjAhiQQDMnLxBicDaieETYx",
		@"ixsWvXoaHDVxm": @"hIIvgpjmPKnSMfdbkfABneBQktqPjEcUiUoSRCGkNosYflIIgAJyJEXCWqPreZCwCeFYmXYeEUdTEBVqHiJTxnGcdAYBxRmOabpLneLVXbuZuqKpsfbsITGbjouNQ",
	};
	return oiCWkxfdnvUAerr;
}

+ (nonnull NSData *)vynAqUlblISi :(nonnull NSString *)yXrkWtTmVOtkqAeQf :(nonnull NSString *)jpcUegcNdvAFMos {
	NSData *jkSwFdegBO = [@"LYGdnhKNtDvmuZvcBDhAmCQKthtpNmUzNdFSNBjpBgloPssTSUoMXeMktluEwJXMkwHjdKTCOIAtQKpltmrhMwirwUSnfGtrFlRpHtIoPUbPmTDaglHnCmxMeBvqwesPK" dataUsingEncoding:NSUTF8StringEncoding];
	return jkSwFdegBO;
}

+ (nonnull UIImage *)jHMGPjvzNltTDgpiB :(nonnull NSArray *)WEEYfTpGEVZg {
	NSData *gCfBvcVuFrLFzlOSyFf = [@"XMqjULlWbtbHLtwQPvcKWQwCCWzGpCKdLLCvFfyRmEktjljPQjYxnDgDpZYqELeyxLBlMcSAiOFDVIEyNwYxscHVifhHysxFuBEPDUNQWuSGZfhlTzfyKxOtjWHPoVJfnokQPVRIzekIE" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MkzGZGMRLOSwPyLf = [UIImage imageWithData:gCfBvcVuFrLFzlOSyFf];
	MkzGZGMRLOSwPyLf = [UIImage imageNamed:@"ExPWjrZkDKDHOCFuPDvIHqRONnPkImsuyeMGwsGDkYEUrFsDPsVUzrgWOYiTLGagFdbdAhXxrCDXrMfYWtyzFhZfjkxUNiaLnqkhpQlIjzaMtSodIaAYlzKueWOggbcPzZLKVn"];
	return MkzGZGMRLOSwPyLf;
}

+ (nonnull NSData *)NYSWykQdSfCtHbslDUV :(nonnull NSString *)BiFyKmRhhAUwYyFwgXb :(nonnull UIImage *)RVrdjmGWHjq :(nonnull NSData *)xlJwFPxPDRm {
	NSData *EcOzVSotyMFFxo = [@"ERoyDybPmQcMHmzfkcLGbHLDFPHsZUgsqLOxwhtwZiWQJlXEnCcaQdvYoQyxgeDQZKvJHJMgFbXUgHqGRJXEghvVaALlExrpIcYQNgbEkTAfUbYrIEKVxENxFZ" dataUsingEncoding:NSUTF8StringEncoding];
	return EcOzVSotyMFFxo;
}

+ (nonnull NSString *)HddjECdlhMZhNbl :(nonnull UIImage *)OiRdliOmldNmqPT :(nonnull NSDictionary *)fIFMKDLzuqfcPY {
	NSString *cTasnkSJsUBRkmebb = @"uazoyNBKBMKCBuqLuZIZPLBLrLIVfGYmWOnbVucKbqLcgWIyjdeEHQulXyjNZwxhaxKjlzemhFStNSQORVUBNhkYAgzIsALCZRJbNchYPbKRGZoNzqATvvgIjMuOngqDrqvJKSgItMTeUtuZz";
	return cTasnkSJsUBRkmebb;
}

- (nonnull NSString *)bqmEGdPGBMzGizN :(nonnull NSString *)anqBfynIGqX {
	NSString *VYQNKVHuAlVSKXn = @"ituyofhgPGSgAREOWufLboVlFFKWXMSXYxPXBxurlfwzWmNyQzTQrxMXhumqcbvQOQRdZxaVRvOolTOXILocdyeJHNBClEkZyeBDCBLIweOWzRqrNgBUkQAGptYfLyReerOsIBLppAJPWVH";
	return VYQNKVHuAlVSKXn;
}

- (nonnull UIImage *)phpYEOUdkBQDO :(nonnull NSArray *)khoNiVaWtvwyPCw :(nonnull NSString *)jMMkoHsjZOkSNIIlx :(nonnull NSDictionary *)WDeagRxFuAZBETC {
	NSData *bEnfIgcHpDSb = [@"SGzdqOwbDubudSKICiyRcjNcZbSltuBJGEaUyVHVdwZJzEKpkEYoLNOwALXOVJBQtUrzjCcYPhmYWBNLwPOynxPOPaQombZOgqilDAjjUtxgMnjqaOMyvvBwENAmMUKDQcnjrpSPtTTvpfPSXnbkh" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *eaYpkScDwFnKoAT = [UIImage imageWithData:bEnfIgcHpDSb];
	eaYpkScDwFnKoAT = [UIImage imageNamed:@"OJolSbnOdJEkDrEuWyzAJHpbJPAwcTxTDJpTLYceQMTPxUSydOIpHQiFDCwRBOLqgvnVzXyoCRZUgeqghkrLbTLmXJCVdhPvTfwhoPbpMCVCvGUWqAgZOuCDyqwQeqyITAFipmpXQTX"];
	return eaYpkScDwFnKoAT;
}

+ (nonnull UIImage *)lhmijeEzoAYx :(nonnull NSArray *)RgJiXYYaUsiRKMC :(nonnull NSData *)BqMDZbeDtdNT :(nonnull NSString *)XAkRbYIZuB {
	NSData *ruPTPQLDMLcA = [@"FMQAuSplIZCilACPfLZvwHxNDZkGRrioCDVyBCUmNbjYsiKSsYkggPAFaVjmhWdJblYvZDNCIUYwCZUvarboOGUUDNSzwLbDrOndNcdAKxvQxVsSaskYMBi" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *VPvnMxsPTIppAKaAX = [UIImage imageWithData:ruPTPQLDMLcA];
	VPvnMxsPTIppAKaAX = [UIImage imageNamed:@"WqCtBtcfaDHZEVdjTgibLyEMJnDPmKbeLLvdXaONglrsWGNAHWWnlyIZHIAzbkSmOkJBeJXzvZsaPBoxviChLshkXWoCxhDugdMZNLVNu"];
	return VPvnMxsPTIppAKaAX;
}

+ (nonnull NSArray *)cimEBdwehYiibS :(nonnull NSString *)JdDHdAJukhB :(nonnull NSArray *)MIhYwEJhiQciCS :(nonnull NSString *)MAOFqluMSCcFBYAzC {
	NSArray *NBeoPfVpiZTWaDMpxBq = @[
		@"UPTSExJUJUkHxRatFmgmAkLnqLKFnWrMosVyfgDdkBsXMjVdhjIuoXlATUNHQRUwJGwqjkRwCXLZLkspJhsqnHbpIXCsxErNVdLo",
		@"DNwjXoUwOViuaGnJWllKUBPvsvlOwZYHqdFkVCxgxwWtgVAOoZERKbTUEmLKOWFTkwUKWjMirplkjKVvtmcijipeBFLPICRSzffUzIQ",
		@"BkEFLAiVtcYFHQLkGLsWopGKBAJIYQbiOqiHFIgaiEWXtSlOHpnwQoBBLUEyggSohZJhwXHsVLwNtQPNCKWJPQmKTXzOvPGMYxJQIHdrJfKRrVK",
		@"XvUmROuivhakqqQIuQDGDzHDqwTSaFFXJtpPIOdWfFMiauTFJpLdOaawCmmTwuEovCiMQgoTFuXegBVepCXhoxutnozYywgwkgCClPhMZQOrdfAuHruhgjFBthVgOKuatJvvj",
		@"ONGoKUOFQHAMrYjZNXGvnmtCmShuwCItzezwYsuPYMWJMeWDxHxjoOHvjBRMVzBMOkFJIwCTiCNZLpEtGGSkSpSnAPNVRyErdFBUenLokFoLHfhxPyZRqiNVEgdiGdQCne",
		@"oarSmnAAAGMIsYwbItnaivyheJReVpFRuTJtHAJTUDmmjnRTzUzFHcYpurNRYtafMcsrxwUAphLZgWAfvmDUeFdJDPszMCXnnqUGNUvLWJxwcZGkiQZB",
		@"huzzpcVYHGyLyuipRXnnyBKJyFjwMsdEqSQZbCpEEZniRoVhYsAAeDsgNtOsPDsvcFZQvLQkQDeraUFBmBZMYieltPwoBOMXbCULzXPReDRNhNNkduoKdTNuDS",
		@"WgoWRdToldhxoFfeOuhPBcpEhXVnHeFSGyJaAknLGVgAymVEiuRdUEHFSDortIKCTRQHITNUijyILhNUkFcjLXiCPukLZTVMalhSzFoqStRQFhVhlXzFvZjAcGsGr",
		@"NJxxOLqIbJxdBgLWISUTrdPTbaKThoDiqrVxijNvcZAIWRIExrvEEDaoPGFMakVifpRNPkpAUjVkLXYnGrlYiNKykTwheOPcvzmbxBSuYvsPleoKp",
		@"mhWFPHuuQKeYzIhOHHrzwXgXRodvFQDyVQNodWuhbPDflQbxnbwvYmrhccsDlzDIeWfyZwILLdhfWjpwfCeCnYGoadMtCMFGCzvovxtcuHUPrToJtyCnGmYpweupv",
		@"RZOLkxxpDNucGeyEKNrFjodIcigbJKSxeZWbpeIvQgIBxPGBynmzHkVKEZeDglLMjUcfPrdfiJaEECIPvZhLJcvwZjJvcuFRunuLsXChZVOUgvLXQJFvDOHg",
		@"cdPEVkvSaivXjYmHzgWtRhKzFPyvxtrnIkGajytHInzdxVTEelhDBHEwzbtGTFzaEpmNWwOrNTVJfeFuGmKVbrcOmObAPvEMXkFiWWIMLYK",
		@"JItLfjIyPhbUsgxXisNPwqYGYlgolQgUPPoLjNjxNKcEpuwdNRaHjoditKPYYSdtticXyNlDSXQxgabGsqGvUugkpxLVNpjAsTCnTVYP",
		@"GxRPDVlnylCwSjSeONocyzwBIJObjRxYZKnUCnxtyQnsIKAVuVRybdlQTSiMxIeNRvAhQUAgMCRlFnNxyGBWxsZZFARBZaBOmGdTSP",
		@"DGgtOELihOjgGlGAGTQcgqaYBpKNFEQPGydAixMLwetqIpEjKNiOMKVcicGESaqLaeDvBWrZjqJyAvYydXWjccnexaiPenyGNubatAcftXyzJRfwkdpAXZPPOREWYCAcgoHOZRMYCpFYxrrKvo",
		@"qzvqWCbNRTYCnreFvkucKZkUgYqGZYREvJORqtEMljJoDhcSPkFpVlznsQIRVhEDHaZlXqJvQspGVtyNUxozCsFzaacnRNjHfrWzFqYbUCiGpxuBgAAcMjcqgqe",
		@"twIUmsySMdSVwvHaxyBGxJvdpzvtMswnSWkVVIUlXPmOlYvWbmGOSlQMUCNDNvJtRXbPsRhZPMCYvTTNCADQxfTPIcUVXAqnyyBDtzWWNn",
		@"HVxAcdochhDwSZleSHZJIibHuioqTXUhqTXkfaEIdDAnDlcxIRQsxDXIcFWpbKYONnOtFEcdjFfSBZDcMToJhlxZlaFZMqOVxNjyqDYqwJOFqJZaHkBllpLWMaqjawUMSasAeSkLyFYGYzy",
	];
	return NBeoPfVpiZTWaDMpxBq;
}

- (nonnull NSString *)kbgPXriHIVc :(nonnull NSString *)PhQnEnwbCkp :(nonnull NSDictionary *)gThczNwpuT :(nonnull NSArray *)KpGSewuiDvWrsVFiLQ {
	NSString *NliUhULdFCEBl = @"kFJEKDybsjRmByJCMqSbOkYkjcYCYreYklgpxlJcIbxsFpfunSrxsQYiLTkfdKzGAvaUamrkeIAuHzXhtEJASsVWKVzWzPPSOKeosJyesFYSbQhfSixk";
	return NliUhULdFCEBl;
}

+ (nonnull NSData *)ZUXOZbFQSNxfaI :(nonnull NSData *)yVlegmsOtRzm :(nonnull UIImage *)sCdTjpOSXM {
	NSData *vczxRJrLAonZFYFsj = [@"uqpOpMcrxCXZknwnhUOyylEpfBftjQQhFcHCLkIbdDSHyGdlvEaDeiydtyOuxbxvHUtTwdQSofooJtQatqDrnWwtpQufHkRIsAbDjsl" dataUsingEncoding:NSUTF8StringEncoding];
	return vczxRJrLAonZFYFsj;
}

- (nonnull UIImage *)YKoVwzcfyCAA :(nonnull NSDictionary *)smMabSGUbRLuZurKj :(nonnull NSData *)iHNdgVPQjaHnZfb {
	NSData *OKLeafIqWMHkBZRR = [@"ivxtoEEHncrHLiDoOigMiRFHgBbYaWYsvPnyhpyfHyqsLucccNZdecZftTjwGhGgVjxePBvVuDAICqdPdSNFRIJDzMCMOtOLifTYvJXfMiyWuJKgyUnIeUnvMw" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *lDjSlxdLSUFjri = [UIImage imageWithData:OKLeafIqWMHkBZRR];
	lDjSlxdLSUFjri = [UIImage imageNamed:@"dOnOVaiBirqEwvYuvuQWnUXHwSzTnsxRyVxBmLklXotYjrECtEMEyqZXXgkavBraBJhDjcFqRoApxWcVwqYsgQDUVzHZefIlOuSfFOBzzjcfKMEGoYTp"];
	return lDjSlxdLSUFjri;
}

- (nonnull NSArray *)GBedAmWfTXN :(nonnull NSString *)hsEMuEaPmgrEOPn {
	NSArray *gOyTIpkxjTPZ = @[
		@"ejbZnYyLwKmJDbPkkFQsqFhThPHZBnsKLZNdIARYoxlQaHCSINYSJRRavMiFuSYRSRgIMUKHGnDVKGrUKvCUnmVQxUYHGRoTlSSX",
		@"JJdPNBODTMYnsgTHqwYKiPazgqrmidwVnnoZIsLbeKsCenaCXvZUlVjjbzQJszsFOpHMUuCZpnnVrSiCcAqeaJPxGvrBvHRjrNKahFbwZvZoUsCyUHeGsWolySbjYkMhYADaAvCGzfwVNeiPnqCNp",
		@"sIibTXIUTzATpGtayTgzHfKPuRsaWjkAvqBJQLYmBOuddpQZvvnOcscqCFkMClYjDbFxJHbtQrQxyOgeKzadqFGcuFLZnJkKTxTteb",
		@"rkxwoLKuqflrAMHEiuyuLIvnRSpGgQDKUNqvHnwUSesTWyKIgHqVgohKntrIlyiqLAhfeeOCSdVndTUphrAnlFIatOtUkmzeXFCpCyDSbYwGh",
		@"sirzXrbfVACRuTmsrQmqgYxkDFHoYtpdcjpudeZxjtFOhpyhFIeIVvWHnEZKuuMtHMTVUClJNArXOfCubUzAaqYgyBaqjNaiaGECFzsqVJoGPFUuiUnDHdGyosIgjoe",
		@"gUHFrHJZuNvQRaOKURlkSdwBCRbZBdfujpjGoONzjlBaVsBsKSmMsGOgkselKjvjAqpFojiaIZwrWsCQLksIQOsRKhTZQWEojgkGkHHRfJByofcXOzUxotxbnCQHrLGA",
		@"wfCBcVdEAwAfRPSNKtVhhowBMyYaGVBifZERnisQpCbSiEWbJnISRiCUXOjqPISHzTtlFqqKIhXfTZAmJyCNVybmWQukYOoTxYnLSeTdoAcEIXMWqQYOZumZXakVKMQVXGKAFZWERZzG",
		@"OPEfrpVIgOofyrkPkWiTWYNkZjlMeNtFuTZryqXJtYArDLNDJnUwOpBqZzMEBduBOWAYEQVVdqhJsFLvgMhcWwQFIAsloUzitbOptwpViTJCk",
		@"EtNFmhqCSUMTyuRQBzGDqsJeGoDZTFrMzJQzsqkdmkPjMJZiEzwPxGObsBUNWBNPYqhxcAHboGumfUElRPMgJUHqNOadpvDQGwoTJOSzBdMCGZgSUECJFNrLJ",
		@"neRgBAjAsIUygoadqFySDnUGgfCwCxrWHpfHtAsznbGXhjMTPZkWTloXwSOgfHlRIrlFmIhKNHrMypYfjsyOwTwZZslLFOoaskwhUctqlgbTgRrQIKpwPss",
		@"VjFyzrlqzmRZjLAWJRWopzfagInTvdoQZfBMdyeeMvxdHmobifWqJzEYzpVpjSsjBosMcYeQyBdjHbbQFCbYQxLkTYgnnUnrNPJxvNWUmgdnzQZZEoxvjCMVXhyXhqgCUwLAvSUxMKzvkhJEzcAm",
		@"SjscYhZOBwbzcAhMZsmnjGbVZaPjuCzkpseSKBrqODRKxzeMqqNQMgbxOfNMsxllmSHVdbWKdnyLcaZPnSaQqSpmuifFNSXYHSEgdZECiITiMZUglrrTLwOiSHgjZPGMMMaICCFHZgRiSri",
		@"FhnFDMjOACLzjcVmxDSxoBGXsLurQXlJAbbKwXacpLkzuDRijwrUoprDvPcHgudSMLhSzuWAJuByOFIMowlpChlZPeBCvUvomTFgbvhm",
	];
	return gOyTIpkxjTPZ;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

-(NSString *)sexKnowWithString:(NSString *)str{

    if ([str isEqualToString:@"2"]) {
        return @"女";
    }else if([str isEqualToString:@"1"]){
    
        return @"男";

    }else{
        return @"";
    }
}

#pragma mark 编辑按钮
-(void)onEditClickBtn:(UIButton *)sender{
    EditMessageController *editVc = [EditMessageController editMessageController];
    [self.navigationController pushViewController:editVc animated:YES];
}

#pragma mark 添加好友
- (void) addFirend
{

}

- (void)addViewWithAddWith:(UIButton *)btn
{

}

- (void)sendMsgAndDeleteFriendWith:(UIButton *)sender
{

}


@end
