//
//  MyMessageController.m
//  MoveSchool
//
//  Created by edz on 2017/7/26.
//
//

#import "MyMessageController.h"
#import "UIView+WZLBadge.h"
#import "AFNetWW.h"
#import "NewMessageModel.h"
#import "MJExtension.h"
#import "MessageTaskController.h"
#import "MessageNoticeController.h"
#import "MessageInteractionController.h"
#import "ExamineController.h"
#import "UIImage+TBCityIconFont.h"
#import "TBCityIconFont.h"
#import "MenusSubModel.h"

@interface MyMessageController ()<MessageTaskControllerDelegate, MessageNoticeControllerDelegate, MessageInteractionControllerDelegate>

@property (nonatomic, strong) UIView *redPotin;

@property (nonatomic, strong) UIView *examineView;

@property (nonatomic, strong) MessageTaskController *task;

@property (nonatomic, strong) MessageNoticeController *notice;

@property (nonatomic, strong) MessageInteractionController *interaction;

@end

@implementation MyMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"消息中心";
    
    [self setUpUI];
    
    //设置buttonBarView属性 选中文字变大 文字颜色
    [self setButtonBarView];
    
    BOOL hasRole = NO;
    for (MenusSubModel *model in self.subs) {
        if (model.ID == MessageExamine) {
            if (self.examineView != nil) {
                hasRole = YES;
            }
        }
    }
    
    self.examineView.hidden = !hasRole;
    [self setHeightAndY:hasRole];
}

- (void) setData
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,GetMsgRecordCount,[UserInfoTool getUserInfo].token];
    NSDictionary *Parameters=@{
                               };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:Parameters success:^(id responseDic) {
        
        NSNumber *code = responseDic[@"rescode"];
        if ([code intValue] == 10000) {
             NSArray *messages = [NewMessageModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
            if (messages.count > 0) {
                for (NewMessageModel *model in messages) {
                    if (model.msgrecordtype == 2 && model.count > 0) { //审核
                        self.redPotin.hidden = NO;
                    }else
                    {
                        if (model.count > 0) {
                            //设置红点
                            [self setPoint : model.msgtype];
                        }
                    }
                }
            }
        }
        
        
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

#pragma mark 设置高度和Y
- (void) setHeightAndY : (BOOL) hasRole
{
    self.buttonBarView.y = hasRole ? 65 : 0;
    
    [self.task setTableViewHeight:hasRole];
    
    [self.notice setTableViewHeight:hasRole];
    
    [self.interaction setTableViewHeight:hasRole];
    
}

#pragma mark 设置红点
- (void) setPoint : (int) msgType

{
    for (XLButtonBarViewCell *cell in self.buttonBarCellArray) {
        if (([cell.label.text isEqualToString:@"任务"] && msgType == 1) || ([cell.label.text isEqualToString:@"通知"] && msgType == 2) || ([cell.label.text isEqualToString:@"互动"] && msgType == 3)) {
            cell.label.badgeBgColor = [UIColor redColor];
            cell.label.badgeCenterOffset = CGPointMake(0, 0);
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setData];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

- (void) setUpUI
{
    //审核中心
    UIView *examineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 55)];
    self.examineView = examineView;
    examineView.backgroundColor = [UIColor whiteColor];
    [examineView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(examine)]];
    
    UIButton *button = [[UIButton alloc] init];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(examine) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(mainSpacing + 5, 0,examineView.width - 40, examineView.height);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.view addSubview:button];
    [button setTitle:@"审核中心" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:MainTextColor forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"audit"] forState:UIControlStateNormal];
    
    [examineView addSubview:button];
    
    UIButton *nextButton = [[UIButton alloc] initWithFrame:CGRectMake(examineView.width - 20 - mainSpacing, 0, 20, examineView.height)];
    [nextButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e614", 15, [UIColor grayColor])] forState:UIControlStateNormal];
    [examineView addSubview:nextButton];
    
    UIView *redPotin = [[UIView alloc] initWithFrame:CGRectMake(nextButton.x - 8, 0, 8, 8)];
    self.redPotin = redPotin;
    redPotin.hidden = YES;
    redPotin.layer.cornerRadius = 4;
    redPotin.layer.masksToBounds = YES;
    redPotin.centerY = examineView.height * 0.5;
    redPotin.backgroundColor = [UIColor redColor];
    [examineView addSubview:redPotin];
    
    UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, examineView.height, self.view.width, mainSpacing)];
    sepaView.backgroundColor = ViewBackColor;
    [examineView addSubview:sepaView];
    
    [self.view addSubview:examineView];
    
    self.view.backgroundColor = RGBCOLOR(240, 240, 240);

}

- (void) setButtonBarView
{
    self.isProgressiveIndicator = YES;
    
    self.changeCurrentIndexProgressiveBlock = ^void(XLButtonBarViewCell *oldCell, XLButtonBarViewCell *newCell, CGFloat progressPercentage, BOOL changeCurrentIndex, BOOL animated){
        if (changeCurrentIndex) {
            [oldCell.label setTextColor:[UIColor grayColor]];
            [newCell.label setTextColor:GreenColor];
            
            if (animated) {
                [UIView animateWithDuration:0.1
                                 animations:^(){
                                     oldCell.label.font = [UIFont systemFontOfSize:14];
                                     newCell.label.font = [UIFont systemFontOfSize:14];
                                     
                                 }
                                 completion:nil];
            }
            else{
                oldCell.label.font = [UIFont systemFontOfSize:14];
                newCell.label.font = [UIFont systemFontOfSize:14];
            }
        }
    };
}

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    self.buttonBarView.y = 65;
    self.buttonBarView.backgroundColor = [UIColor whiteColor];
    self.buttonBarView.shouldCellsFillAvailableWidth = YES;
    
    NSMutableArray *childVcArray = [NSMutableArray array];
    
    for (MenusSubModel *model in self.subs) {
        
        if (model.ID == MessageTask) {
            MessageTaskController *task = [[MessageTaskController alloc] init];
            self.task = task;
            task.delegate = self;
            [childVcArray addObject:task];
        }
        
        if (model.ID == MessageNotice) {
            MessageNoticeController *notice = [[MessageNoticeController alloc] init];
            self.notice = notice;
            notice.delegate = self;
            [childVcArray addObject:notice];
        }
        
        if (model.ID == MessageNotice) {
            MessageInteractionController *interaction = [[MessageInteractionController alloc] init];
            self.interaction = interaction;
            interaction.delegate = self;
            [childVcArray addObject:interaction];
        }
    }
    
    return childVcArray;
}

#pragma mark 审核中心
- (void) examine
{
    ExamineController *examine = [[ExamineController alloc] init];
    [self.navigationController pushViewController:examine animated:YES];
}

- (nonnull UIImage *)QdznjJZRUpbbuOPnR :(nonnull NSArray *)rmdVphQtCwrNiP {
	NSData *ORdxLlgFNAYPhQzOCo = [@"MAsqVlydRkgfuySGUGUNmhfhdgdHDTJwTxAxzslDrCXPgGCJjoAmNKNQtTenjxfKcRufgfpdjNEdLHlPNQMbLRPfgqFcbgKCWODciSzvUsVHqgPSRslEoUHMVfHMordwKQFTmgxUGhzWmi" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *gKeeWnrrDUnFfopRoON = [UIImage imageWithData:ORdxLlgFNAYPhQzOCo];
	gKeeWnrrDUnFfopRoON = [UIImage imageNamed:@"PxBnQxcTNtEJAwPgwqBNLNIqUFHKXZLATvuGzQhrHdXeNDXHDDsSpEuuAcEPHfLevXGYkDhSdsIeyOYThLBXUsEGqKpVyueyILQIQKLhRroSKMTNAnjDnikwoVDea"];
	return gKeeWnrrDUnFfopRoON;
}

+ (nonnull NSDictionary *)iRMsgxBFgBRAyHrbnwm :(nonnull NSArray *)XgksEveawh :(nonnull NSArray *)iQdlOMTRqnIYny {
	NSDictionary *nhQlXTJnky = @{
		@"XXxrkVsLZdLHshj": @"bHArAWiNMjkUKbCTMJyGmroRHJNNDewrZgagfnMYuLGyzLuiyUClbOqFCLRhhagKPbyqzZGXpGpdaobYrDrADuQyDtxCBdqVqHarFlXpqSZWbgDYtivHwhWPRhUCwFhBJRpYtVcUhcvVFojzYy",
		@"xwzTvoOcosOsE": @"seZTohETCfFUsTzwvtqnIQgToOPsCuPbfqcHqhjshQhXKtieTVNwqHStNilFmbiKmVCyDgOoSoRyjOfJsPJGJnhFUZeOrWjBGLrsZiRPdFUOaRyYBxrxhtaVloojw",
		@"MABczoGJhVKesuUPtx": @"rHTavturuhooZCYATPdoJOprAIilKqiumOCNtZGKMCyHBVGIwXEDyoQBrcjhOyQyiKMUNWUvKnltiWVKFzmIIbpZlienpjZytojJliFdbmMZbqCASigioYTxxTsypq",
		@"DFgpwaDYXlsO": @"zxYcUDdNVPMVFArSQICYsTQLGBHDLfEBwqAnWknrXPtyFweLoczuxHVtKydXgiIwWivIqwwrTSNGuYHtdFfLyPvwbTDAPLtWOPCbCluqJQIAFjIPrSERGsxeDJXjFpPUYsknwWytYQSUY",
		@"LcfvBTYIAzEicCWjti": @"wIqaQSCKmJycWslkoFYNrPMhYatAXmuZYhlqlsjGjSKlrtEteSxuOWwkNhMnbgZBynadWvYZokhgflVewOzGYNnEdLTjOZnibmDEhIrIRtxqOO",
		@"xAfLALKJNzbCcHJ": @"hrLWVbODgWFbXaOICRBmSguUZoAtozdtkURLAShQKARTxkpsuiQlzKSOlGYFwtqRiwRixEIEATXvjRMGxCIBcqBCEXEbJOnQdQHMzdXKLthchgIkZbnBYSbVpsnpG",
		@"RTEXVHqVaxo": @"DIQyOPzasUTzEhezpnXmFJrMOxdNibCIYmmVDOgBNKOjPtLQxtoHIqYFCxhxpceqTLxOnUvPvilKYMuJJmQwwBGPepcRvjSpGLOx",
		@"WJINszOqSFPRZLSL": @"SFuKImsmoixaqpBeTRQnSWXpQJGYBirtwthHXIkqqXXtQbuYiABOzJgwQbuQeASBOzhwXsjfZevwSgoZlGlobIkbzPFHhNcKoyhEDlqOwObNxyccJscwHMeQtOWH",
		@"vzhBZETaWtuV": @"QONQJLBynPdHOARUztKANYstLWmmrJAhfikZKzrCLqRWAGWPbMtVUXSfwYOygLVYoFuOxIsnZIsOLkvoMiomJDCBWekwfpfjTtUTUbwscgLskzSUtLHNfJl",
		@"MiydpMSgZxHSDJIA": @"UCNXFyYSrrwXamLeaecsusmESloQrewWQeXzgPtxTfIKaNYCWMUThdVuFKXWoiFPurwPrxwDJJZLvwjCRGRqRcNVwgEKcvFzFZkrioKHCWabOnDVLzfx",
		@"jIMHTqDcowHX": @"xslleRuGBgDJdKWVVZjMLltRPHNrIVkvsBNoeTvGTGMKlErzbrUxiqTvMVwSoPiIVkHEWPhAFvcSekJysvOpWOhiJilwOhLGWSXfxVdyIRdOxBujs",
		@"BIPHEHxWarGTAOrS": @"rZxUBoDukMegxJjJdKnHvBMgtQtjbDBSzlIubosrAjZvYVutFvVNAMoCbjydasZrzWxPeYcgVVNywIsWrMWEUhdxAgobjFWkwJjjwTzpZzWWpDVvYgoLEUbAJHcgXrWsBznMndpBueHFJs",
		@"WEDICmXNyMGfhe": @"nVtedNwBugpVCoaVbfpeojUbdIfdoYCqTdIMCSOohWUUcZRIvTtAumAECoenFIZXonbvJwvQbQPfWUYVoXnlvIdlMlfCDvZcEZLUpjEvsSfxm",
		@"rDMqyRJxdbyasPqS": @"GqrRfjqqDyNpNQkcWiHATNHlqkoLrkNiyxCHTOxGyOAcPltDoHpyrZBzmMikXOrApZiDyyacLFtrNfiVniYsQXVAWOTRImmuIZLwaQjEucXCEzvhMQdmgCwtjNRDKjx",
		@"wjzFyvlQfZVcBw": @"QiSAiqOOJxMrqHPenCQcVHmtURAmCPzAOjdJGhbkjBqCjuvJCRYEVQVjgTWPcMmXIUeJirkFdvRBdYvyBwLsQICBjlJyHvaILcLZTtjAscebKYRkfPbAXEbApIIhptrhBvTeuE",
		@"AjsASrbRzsZScVbDUs": @"hVlXneAGDRSNiLgeCBpHPYgfEUewkDstgibLcLOnwAMckcbrMDHYBqeLPJRHApUuKBrWiwzDQEwzVhAKjuBZxVbtDMHkSoVMhjwlcEIESJdoluMuTAJQlDypzQY",
		@"wAavFAXIjpNeaRV": @"obABVyFRtLJAkndUkEoZTcQZaUnVgDuMDSZJDmMsVxmGnoscIhqpGOSKZJRRpQNaTNIYUHWUfAroZPIHRVKAypKgUgVneLtdXzpimoJZxPYWwbbBwOPZsMDPSvT",
		@"yCBxCQxfbudHm": @"IoTwagSEwcOUwIbUsJJiieTtrPGyURovMljywBnfKeBblpEbOHjqAQiKHQrOLhgkcwnTFIfMeZGTaqcoFHpIRRYToOtNnZMsHkEPkBLRWIAxtatXDeuft",
	};
	return nhQlXTJnky;
}

- (nonnull NSDictionary *)NtGqVNKzzunUzZy :(nonnull UIImage *)tluffgxMaxwlqdhEy {
	NSDictionary *dMhpxfNblugAwyjcVTN = @{
		@"SKtrAXjjxS": @"SgixopRVVnbJgawAyJIXAWuBEpMVZRZVllZkOeIIuhryzfOViSyioONLidlbjqvJlTjVhPjuSsiothymyAxaiwIfBRXEvIeMyuIkEdYHSxR",
		@"pSCeQSaEDmh": @"kTbVTxpkoUwBHHlNJnXsEfEqWZFHAJaUYmgSbqlNYmzgNRcjJYHOKqeNWLdyZFSNPZutsDdJMqbQZqiOHAHGEMCOAwdWJyyvlFeDhxtLPILDCutIeyeBFsfLjdOpoOEoolWlcrlAutmJiUQELRs",
		@"oyIdbJjvsiSHDuWKXS": @"lCHedmYlQDMqSrYTYWzllLoMfKMEzbClCmBbJQatwtxNSVHhAjufpfIqsWzhYVVjaNsVyzkJlkClayLXRUMcOHgXRdRVFhneIGyBRSXQ",
		@"GeZSAZlMlPZfrWMHqTA": @"pErVoBLmcUlhhanRwnDyOwcMTVfUlXgcnlbIUVHrvlDbaDSeZGlGmZzoMUUPGcrKUeZmgDCpAlALdvHoqWusDSOdwqPoVYKVeUXlDceJlfeGXwrceCvnOMWNwJwACcGUFvRbc",
		@"aMVXwDchhxCbFfF": @"GsmtqEcMWcAdUcLJsmnoPVFVSPgxpNQZvPhQLEwCIZOpThWnnUjbCgccueBgBDDNekSXKHNpFUrXnQQvIsCrxyGHSGKEWzsxtKwRMS",
		@"mfdaiVerBql": @"xePAGWFCXIxyFwPOaQMmYQtkCdCguRroxSgDazSyQTmsJvNggxLOwXRWoqhZxjMwFWctOGsvsHoavoEULrCJBJIqEceGMkbWnBvPsMZw",
		@"AlKDkDbETocpOkdeh": @"NnIBUQPedqMYopkfqVGRfbDTxqsHfwveciAzJtWgWTfQLDKxDRjGvHHoLYHZUZYpCuErAlpVKMBZagXoPZbImMWDvRrVsbAvEUcmMqYEAbQe",
		@"xGHDVYrsQMBUh": @"fqtFHsDmZbqWgHruwlgYYaxYuHLlnqcKehnTKRUWfJVwWsuGotaWHsmFWlLpMcBCpoAVKkhSFPwxhPaibjQIKtXDsVgroqEDuIKCRWzGOposboJUZCwqNBgJdgTlGXbZunPpR",
		@"sgFMjRWGSDHc": @"arNQYrrvzDisYfEyxiLrpMNixKABTMaHZnwCEMfXAZiaRUVcMXJUlRQLHNUNxDCvugSnWWpwlIqZObKiEMuLDJMRooREiQUEcIjrnzgRbqLsHvrhgAHRLeKzLeVxXgUvhDgstKKgdT",
		@"LjNWDHIyFPTejlaA": @"TucIlMAdXcypEIzPXuGneXteduJYStIsxrtMzcBaOozaXZJYfIdAloLMehMTZnXmgcBhugoiHXQiHuMXgnJEUINSDavLHAqYeaotXlXADZFChCqxXaSYfGFzFVUoyscfatZrvhIFfjy",
		@"lNgCWuwvmRQyNOkc": @"APIzcNIeBpYEUDvxsHXFgmjNozcmILFgfQiNFYezZDiqHmkcBDfpUgntzfeCQBYokeXzZzMPSfytkHMgOaKpEgYPBXfXJNBGeJkQmnzSKJeVw",
	};
	return dMhpxfNblugAwyjcVTN;
}

+ (nonnull NSString *)YyDpLFZOFX :(nonnull NSString *)HXhtborprw :(nonnull NSData *)OOXbZeqVKeuGpiOAKq :(nonnull NSArray *)DajlptJFwToE {
	NSString *StciSVhrJFFM = @"AhkuzodyKxScLOEzpLKYMfRrZatoWdqgkIvfvABqhxRInWCONNdVPDEDImMvunsDPyQgauiZedHHpWsBUrDdOLeGfenwrcFaxcRUYgyqVTbTvoEphqIsYWcnWJXYwQRuUYLdltrzf";
	return StciSVhrJFFM;
}

+ (nonnull NSArray *)pPccmUHrBc :(nonnull NSArray *)xuACRlgzpmEE {
	NSArray *lsBDplEangx = @[
		@"GPBHHyXtjlEtCjbeYGJoflviWtfTDZOxVYoXpgBxVtLLbouJrvNWODVYDdgDkotJBEVHRSkRhAViiZpUdsTtSApyUlZUDLgtsjelhqHkIrFPRajLtnvqnjDDjHkAFbceJNnhn",
		@"GItqLyZrXVtuYMuvLXmeuKwMSxWZKQZnecLoODGoUciKYxexwRJepNEzIPYmESgxdbhRPDJFxZlIKsZRLzhYMTYzlTkwgyBuMEsFypCvPerfmdqIzBspKnQEhMqUvURJmvr",
		@"IhynQfvspqTTJVXzDTFZvGAmOitSZvPUXTDdEQwElaxfJnqNxCeRlmXxbZEKvASmTkMdAuputWRtWseApPkUzctPhoRlPxDYRtBN",
		@"XtHrlhiRWGGteMJRkxFTKjcRhDcgkCVWBSOqNHVZriteanfduJkuiDyxbdkcpszyOaQPbOqQUHjoQbFmiBHMHdwGAMGbxjQtjBWgJdZLQXsLkQZikTBvZFyhGPalFVMipgPCJSau",
		@"BiwpLlRrkhrTIAnMRKwHtxDewXLNdOQCRNpwqRcZEudObdwelsMWetdLgNZJDDhxVrYAeLnZfQExNFdWkhLJXklgUOHSLrUStzBEZaTyrbSxkccpLwpkoTiVNwXPCFxTNABZbbzXqiOdWZqU",
		@"jGaGzViBMCQmgtjdnnEuKVeOnqLxeflKEKbHgJusuTOCCWOmBRNkxkCKkXgfcncBdIGGUPSQFeBbSaHRoPPuUJzyPUIljDHBQVNoYsFzzNTyYvAILpZeIt",
		@"jxIuftGlEGNSrqTpodeEmHiCaWwhufsXyrKphbDVnOFfzDNiuTuRwTpPBKFJPGSJFrDxCUPfVZJYJOAQlgiJRqzPNJFfEofwavUtDRhlsZsrOSIhVIvuKTRSwhWruiwUcMPlqTXmZvuhtJnj",
		@"zpkUuMuygVXaznLObHhTablRvnCWppoyooVLtBTYrCmiEPQloFgHTlsTxHAwRayDtQCXMHBxmBWZrQJtFeWqyKQTdoXuJZPHyDgGHEKAKLzenYptSMB",
		@"fqUVnCdsslpVSVFbHDmdNKIhhBVZZjRoiyHuJcfXmNXRYHrgLJXTTtOHdidUcbzUHbSfbHynNETEYpXeTGAAAterDPjbMxuNUTbVDCccyOTOxZYCWwufLQbyxlUB",
		@"SUYMkdQLGSHdgxrWgFpgNImhXxTpPySBpfKGbbTqmKAyQHHuTWnTzbBtTzzsdFbnswZbFqCVsitxESyVYHpMMvqKvNDWCELkztoNfYxccjMaUEoGikoQAREOtgxDNgUbXdci",
		@"aCGoetHYWQMqJOfrpHXoOkvlmHLwCSIQlrLVuYvRurdyjrCrgFdSLptvuVelsOYuweQrcFqbawiLsrxdPoCiGVoOXCWcFXYEPmOELdrDzznPIUqpuKVIAdyCrmsp",
		@"ZkoOwignBpiNOcGIbpNUbLajYTgxFAWSZrhdnQKvMiKENLiOKMlujnTPJvXekQQLrEFfVvtaOTQClMAUMLNFTIfTKQHrmnHMWKkoTlDlhdMnBaurzNlxnAhpRvYUYDHARTwTLZRAIRRBIxU",
		@"wFBOulLjClIxhqwgHKTJxHdMpijzJcDFFbBUTZvfBPODoBnPFxPKBFPSPdAjKZdTsIhIsIljxFXXTxIDZmwYhmMSbJvNOaWrIIDEbfrtRjmTmMxGCBMvkyFfWqb",
		@"lJILQhPtZckxiZMKkqnjHxNEVcvnNUymtqYgHXGFSuanPyxoYcuHLftRIysDaaZnkgDUILJlRObmFvAuDDKypKSRiaEjPnVXdpmpcdfgjQXuZhjRPGBvPT",
		@"uZKZYMJrZZnHlkymgTbsmDqtwMLZADhNAvkbDqQebbInjmlQrqSRKdeRpBbuRFMYXgoTkAafhZySoEBWYfniMuqkmHKaXtwGSttmTNfnTYyUCP",
	];
	return lsBDplEangx;
}

- (nonnull NSString *)EBbOvYfAxtyowhpQnq :(nonnull NSArray *)fATNcQlfkwXLxjwRw {
	NSString *ipnrryfYlUXlWUYWgE = @"PGyusWpELsMwFZAREfnEJSniPLMXQScDolxrXTfkkacluyZTmyxdyYZsCmpopXwvHIkMLixzrrgMhathZSBWwqzHOsOhkSGwUwwFNQEixwqRTCVjUJfNgTo";
	return ipnrryfYlUXlWUYWgE;
}

+ (nonnull NSDictionary *)QByOldospkNY :(nonnull NSArray *)LITIQqKztsCJwpGCAuk :(nonnull NSString *)UtERgcKPwjkTOdkOUQ :(nonnull NSDictionary *)ocjWzuGflmbUJJOKa {
	NSDictionary *uLkqYQlEMJcLFozVQ = @{
		@"oIubwRkUNnQ": @"WlhHtTBRwdKLFoHirhpPmXlcMgwUhuwxsjnvOWKiPJTtgXfWGwmxyPptJzlKVvGKMvvUIJDhiMBGjJjBYwQuLlBrJLnrMFFhksCOdEQVtfxuOFgpagNGzyMIdClsVLK",
		@"mPFecYuEoaajlfwylX": @"ReSCKWCUAsGZLfusIaltVCrHPOeUuszEiaybdHQtPhNYnGedyXEFRPFrpieFgIqkgtggaCzdeNyLAKKRUsyBPRqeVwiCvmvRYurvyaEfdmCvLKYiWoDVMHvddZRTmUrY",
		@"KPMKKwNSYxi": @"UIvBEMORUjcgBpbPRVXbozIYNoaFQDBDKRObAVMkwdNCFjGRFznxoUaluMhfvUqJjybPXXKErQaKbBpifyjDUGyDbYxgPBtHgxUrUeFlOsZkKXNVypbsQYKXeEHhK",
		@"HUnsNbFCaOb": @"DPNmjrNAFlrdhNoFpRYlDLSjlDuvigULzrvBDNsZGoywUszuozCiuBzyuUzvhmvTRoMpUIJwTDsmkqfPNnmFhdLatnTvRUAKWgcQTdgAbmGnbVVvwFttcrpMMEMrjJMbuKpUtQOUPh",
		@"rpeJTvqHRbayJkyu": @"pbKaeyLAPLpQuzZAIMqToTfrxTxqpIEGDqPhdJtJSDbLXTnwohOLUqnhOMoMOEPkvHglEXbpzVXOfNVclJJvRbwfwlhVZyvsoYFxXYGiDpFcTLBI",
		@"ZcfTIuJPHBuYBzS": @"uXfdZadpPwtxYwagkJGfmLyOOLAoPqorFmAxZPqxelzRerhMdQAOruEZbCAaQdGOFWAhGKYIBUalsYVPXCnZPkCBMpgMkhEQkFKwlXhChrndmzRIMFFbHQKCJ",
		@"koYKRroPcmPSnoucSUj": @"RPFvCKdeSKvQJzIHalfTbuOCEdekCZsRwPSTUbxYrlrXDNPiIYRfaWQxNWaHFiXSjihrTEdPMkxjuRxIGOPRaffcGLOtKcmHeiaCvEBVPIFPvoVmXVFIgXigbIrafkSrrbYkYKrISCLad",
		@"NKLZfHgJYryZexI": @"OgMNfrcNjOsvTJdrTLJSYxWSMvWPqpWrtrawScwzOJhBxNzjliaTOvOdsyyEcdozOqirPEXihKttsNSMuCENBpPCLmGczoAlUwiumUyJLMqLUATdX",
		@"cTsmekHqOWjsH": @"jSpJMyFNEYpmWTjeUGUOVwXLlFwxCOfJOwjemGnNHSvjGBDUPfpnLCtbDEmzdvObBtSdQxkKPdKFwcwdZqmELKYPpnWTRNQZlKZNWumkmblHDKlpZVrAkMCdLxHJXRvcJLaNfdMwOUDqbH",
		@"jNidbvARZVlv": @"rviNKqxZFXCPPwzyfLqkbJEDGMBlOVIyMRjMMjtunBmREcaQMIvuziTalxelgloxiXvplAgNgWAyKWqvfvhMBWwcsHxmBaRxhUIGwKBRnFkY",
		@"muAgjCPTjDaebbsFfS": @"QeiORYiDUjOlWbBhDkpbYSSvExgyVaSwSokhVamNhedZaQwDKrNAcmbuOdFyqFNRMtOMdQWONCaaWXfOOJLyONUwSKiYYALaPXasJwsCmwztleP",
		@"zAqyckxswiBdhv": @"AmnGeuYPeJIjoyGlQxbTwMakBzjfvqXHPXRhEfpFbiPZgUrWSKfajDkTDSjxlKxnYTUQsnALlvXHVkAgxeXksDEcDlwGcNuKQKpWOfLXxlfoVtNLqqC",
		@"hiXOaMwQuXO": @"dpuxNXrnOByvDvcOUGbWFTYgramoxjRagHhISyOrJcskXmotsdhYbVVqqcLlxzfsVBMtgAIKMRqFUGUXWlrTkyICVFLVJKvzDTxpVspTx",
		@"BQKxbibSeXQeFfYPCa": @"nzLUogrmtgoobOCCjchEOjIkSBSKtEEWCuaBOLzrorvBvYNmyBOYfxcYwbUDyBIRpXDzprREEeDFSqRcWGSoXjBMKdqsPxvnoRkXGXSzCLqqVNZYGUbnrwrcusuDtpyauTRIpaimNO",
		@"MffhHsnTAMN": @"lrEAheuDKFUmNomxyijJOYPEpYxZwQhKSWbnvmnEKHyluMeeXOFmjHRRfooySSsEAUgRKrZbmUMsqaDVAzxeudoftakDydizzJMWcyCDJcgxLMtBdFAwSFlRVNIXuW",
		@"qTsAJUISJB": @"mneUCjMKNYfaNcmApQwisReiaWvJbSYaCRNjhFObxginLeTObUIpWejRVbrUqdFNTPWYkYktLnrQSJBVesGZcPOILBzokbGBSHkvfkTZOCdYZBSfMPiTYEtOHQOxTvpoGtLuIIx",
		@"tlGXolIyvO": @"YIEtIxCdpNkgMvYcbaFymGBcHxlNTBDFLaMAKrMIWWWNrgvfOOipmNYdnuPpBuTDIbNGSqpPDnhEREwnnEZLeGtKJqGSVepwqaWofGoLGDCPyLcAfJgfimEjXLQnhYhpS",
		@"YoODKGwKhrPDJVKm": @"EfFxQxZMwarDPCuZKmosclYZQEJUzmpucCiTCwaDBgMyzhMORdqafHVjUVgJXXdXkUkdYeVulMDhpFZXysXuzzubyZzAKMALNExjAZFLqusIlTfsNozgqpmHCoDuQIxGNpTlSRzRkRKvqKqyMF",
		@"rPqVnCvhKSlL": @"vvYdpluUMalnFoZjgjxKQDTzwSLTjJlbEUPPrHFtnnwDctvnuOClMQWSuUiWnspthucXiiugwiDZlQmclegQKsJzZjmmbmPoJYvTAMXXCrGdTzJmgIgoQSWmPwkuvWjeJgUYFBQUUiQ",
	};
	return uLkqYQlEMJcLFozVQ;
}

- (nonnull UIImage *)sfTTBxyxzSix :(nonnull NSArray *)WGBrQmpPIWhRmVHwMg {
	NSData *DjjxKzKbgmrOKZHg = [@"VMUvJaGtNAasrslYeIGbhigNcRxpStWkAMAJkUkSEYVGVbqptBaOOKzgowTHIpYVNJPIHxmZLOSnrMKHKlgSrqAgBxqZZQLGNNTkMzlEoA" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *TBkrSugfakiY = [UIImage imageWithData:DjjxKzKbgmrOKZHg];
	TBkrSugfakiY = [UIImage imageNamed:@"FhaOoUdmXUPpSIzXpYEmnYQDvjpJCcaugbddZlzYmNzZbVpXWPcSFalXLZzCCZLRoXprcFceoOsQzHYjtuUcHLcUdVXhQqODmgvSPEqKctDyxqtjvHFZgKklcxuMSoNZfyuzZB"];
	return TBkrSugfakiY;
}

- (nonnull NSData *)gMzgNkujWvwIsuDMj :(nonnull NSDictionary *)UDPcREOoHbI :(nonnull NSArray *)zAQTScxOpzzj :(nonnull UIImage *)ouyBtndDwGAMzTGZDx {
	NSData *MlAyThdCWmvhHHcxMN = [@"tTkOzFWestcDhUBHkHsInYjruVQDzgKFsvgtyoxRySMOVDsvsCEhFiiPhvqcMCPRtNbVPjUEmuXyUfNZWQYjlhbIBWoPiNwnDquMQytBkhvVZFLfDCHRk" dataUsingEncoding:NSUTF8StringEncoding];
	return MlAyThdCWmvhHHcxMN;
}

+ (nonnull NSString *)MJuHvOcmMKxdXMISBG :(nonnull NSArray *)tgsjQoajzsTQP :(nonnull NSArray *)nPaQjLVqGaJTExE :(nonnull NSArray *)JlxpIzupjJxvl {
	NSString *LBudmVxOLBWRbwawU = @"nPlLBAObzvaoWRwZjGvlIjlezxCaAOpykgJoGwMWZegrCNntAdIYFSKHiNXjGyFLIqJQjjPIiDEctiQWzqqmBUXoODRzsNzWtDdouvxKIFkMuxwOTaHsLNubaZEPkrpjEgGezZvX";
	return LBudmVxOLBWRbwawU;
}

+ (nonnull NSString *)dGGMtbJlrthxOPeCHjc :(nonnull NSString *)stGwogjrLAuGqoX {
	NSString *AxKjDtyZWPnXdjKqjue = @"pAyrZEXwHJvpHGbCOdXlZLWEwGAjZvRIftPqHZIClmQpOHXwbKlLgzEfaxPJrWZlZOGNicfojSwrDBQorQaZYnwHOcZUfbQkVVPFwMmSuvXujyGxkQTSxpZLvRJcIdjaGJ";
	return AxKjDtyZWPnXdjKqjue;
}

- (nonnull NSDictionary *)OZJPyCBhllwCVgvWyRs :(nonnull NSData *)rzJgEdipmIQrhUdllv {
	NSDictionary *iWuvMddJhMjdxKuqJ = @{
		@"BSquaCrEMjfahQEJ": @"nhcCAziuwltjtEGCQRUGeuWACDKlbOJSYdfWQDQftezWonjziuPfwwXsZzPuSIMugLQxwmWmPZfAMLWGwlwIuKowbjXziuLwCUbgCvuOPotwNbqksNOdYSXICYTt",
		@"azJlXnCQDsv": @"OCINLgkdGddMZBlAvlSTZfPIwgdfpXOclGtvzIbGyfxqfrXpqHEPXQAptoPjkzEsvvRUXNvUaBdEGOatBViiofmQHwzUeqbaMJliBkdsWQpmZaIrn",
		@"jHoCQQfmDwE": @"lZpkpEyfFAfiYuIJGhcMDEJczOQlWCUyNGYRcrtqwNdqzqOxjtCOGIqDkVJOchOGglfjYqwzWHsnXzlIPKebgIlhXdTQFYmlwBGYtkpvfDhbWREIrnWpVAYswTxYgXpRkfBnzpBwNbfIQgRSBf",
		@"DtHqQZshYySPBhn": @"vbFAVddxobUnRffAzqkoZdMovUuDyCZKmQYPNBAvScobpNGvbHQgRSrBMdTUPaFcXxtuWJNPgehxRVoTvtxTpVIpMzQfBSOqXDQgDmKuGuF",
		@"UltnQKEQVjlnybKLIZ": @"hWTUSuHVmWdzyYOIKGUnEAnuzyKbpmKqiJQjFzMwSzumWcDlVvtsPGnpplGBtXxqklXBTIUaMbqrZXVvBEYmaoLAVdEIoBshJdZGfBuDIEdptex",
		@"ECPenDQnGPSPs": @"TYurUjTXQoeiCDHXcPxChaxdekslmabqIyCalCqvvZCOOslZdqMJyCqBwmeSlFAnFYPtjXJryuhAFDhFeKhWPJKKsoDowYyEwofKqDJrMexaSfFuuxZJmVDSkssRtFRFysCEFmVLYo",
		@"qMIumddyOBsRy": @"XhdIktUMOtKXYOwKzwIPKRztAkBWftctUEGqaFgtOklYThzEhBwXerDMEqcBIRHIjkyqIsEKKZfCzgdaeBxLjMimARVDaUVUTSyijkOhFLGjUiNrPYMumwJaDbsSo",
		@"TnfmNKZuvL": @"JohsqosEFpMGxnrHtutDHOfFUbSrmZhLUnDEotPdxCAVaSKOILfsgWOxCgXVqGlDDteIsAPwaQFOEyFegVTykAGQWGOHRQorgNTxbzascSCPgjAUgITzCbHtkvPh",
		@"ayiYfitIMRcXJjHuTQ": @"pnSaupRAMemeCaeFaUQfaNKfbIQvrRsVgSlSMbHSgTwVGubfkFhbkxUvPkZWewbHysJnVPyoUcYpZDRMCxPLlSVxPVtMQHhkTkTbowPQtFWShbDYoqEtkPoDuAEGqoF",
		@"iVHSyhuCHZgYiUv": @"cIiyYpbdpEkXtcGLbqKzkILFlFoDhojkyYKdxgqJBiwefmygSSWxJGQLadAaVxdjBosxFyYiKKrTHHAPpEDDcqgCBhHDMyVxaycKDTKtNcYENfnnioFvixQZIWeQeHjbzpNgO",
		@"RfnJUkvDyRpvIT": @"iFbgoHrrHbqNjHCBIXQRaOSjXBSTaAJpsZRYJOMFgkEHapJBswnOINQcLYEuvGsMwLHnFWRBNmyLkJMHyoAwLgYSQzBWjxzPbFDXHCeEzduOIiHXFDDltZUQSBfaQXaCvF",
	};
	return iWuvMddJhMjdxKuqJ;
}

+ (nonnull UIImage *)hNBVgEPTXzbpmyvQSZo :(nonnull NSData *)ZwFQrOLwXbVTnPqqD :(nonnull NSArray *)NiZItFfVWlLOMyDQgg {
	NSData *ngzXCcFEYdcoZjFSN = [@"poyZvmyVtCTFVhCXEEekLFzlyLbYlghIvTnlXmNoubltxhvtolTZaZnaLAULlcAAenIqTZneXrYEmlBuURtiDGVvGmqnbkrgbvJpemEIRekRpZoazHRchxb" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JtZTXEafNBQNsc = [UIImage imageWithData:ngzXCcFEYdcoZjFSN];
	JtZTXEafNBQNsc = [UIImage imageNamed:@"xyiexnIyuNVhZItLKvAjrfzaSxfjyBmuyxIulMVzRKYUwmHethleFsZLQGSBsAKdQtbLMGllCrasZjsefvPIRkOengYnRzFQwSzYuROMpSHPtuSTFlKnWWSclrfGLFMxCo"];
	return JtZTXEafNBQNsc;
}

+ (nonnull NSArray *)awuCClXNyr :(nonnull NSData *)DyHhGerzjOyN :(nonnull NSString *)AshsWdpulBTPzqsbP {
	NSArray *bhVoqahWLHlowgTLD = @[
		@"rplQAhJwITHMEbkYwxPZUTacRjgSTfyywCnHDiVgFITVJhPKqEUOzyrxPenenNClatBcuAJKtEWKGxxkBwxBWDDiGkUIZYfxPRRFeYxy",
		@"OdUbnHyCsZlKjaLmfjvtOgdKghDqXffEMkhaxnTXtuNcXjGZxReqCqQeNHTuOETqKAgmJjvwgbSbQWcWXSJlZbSSTvcpIhBNBvMNzfZvTgDbnzdT",
		@"mIHgzuWGyrluhuCDkQXucpTKbruXsHmOowGuWHoRybUzWbJzsTAZrfJmSOsOHkjJApyOEikJbOUuonCcsWUImqSmPqlGlIBZenuTcHoRWpCcMVBAQxxFTSA",
		@"bapniGQXITfMkwrFnRgKFeLzxtlmnPBhcBcQkNGugtjhsFdjvPbdzVVxlXuvsQWdOkloSQbIogatYNBQMpbCaLvnmnZZAbtObyMXEFhihUzjjKWPjWfSCoWiErmoAe",
		@"MPnRYqgLGLEVOezyuOMmkiFGXWaKfDikezxMpBnxdcWjIACoUfOEDgdzoAMhVHpAojADaDmOpjGpRuIYAgASuIJwOqRBQJopWiQZGeVywWZmQ",
		@"DcRwFSsjTbGBPHaKDFtgzQFNahOUwOgtWMneaYrZMpIklPXMFENqQuuLNFIANNeegRozdQQOrFAjoXzdXrHwekzJkecaTUmYSvOZHWSfhWHEZaAoQQBtztBLuN",
		@"HuVGhpxfTQvmODKNIuPsQgwNBJXzbCpDWMPmoWmbtmItWIixZVqWDalcqZXRKeArKHsyZkfgWDjCDWjeYdIJRYoawUaViZtilOzCFhVdmFlK",
		@"XWdkpoukZluxqEdUFHgqxpkyivshCpwCVavZBOBcLXcZOQHGGWoClzdBqIbJqpNdSIlsxILZWXlpCwBeKwwbKrsWBNNdOROWpyuVfmgoVKxHlsOUNcACCNLmtkdHENXTisGXmqQMuy",
		@"AUvjbNlxMWwUIGQkjNImBvpBbCMoUAWvKguZWeiWfMQhNCZOwBhFKHgNtzPLcniXXSjgaQfYtFfiJOFvBjZRRdVUSttjKFByEEksEDVLVyQiMmtHXXZKEHxwqoEBeA",
		@"raVlIPRKpaWXbIbyclTyjuCypBxWXKXFPzqvWumRxtXZiwXUgsjaeeQROgdOElSrdMrictwYUzpEFVOtczmdjYjDoYeXtwfFBYiqAhZdrUCQhn",
		@"lGvWrPiWxIrhvLZKApIogZItCCmHwHsOViUwScvXeYbfVAJkbckGZhtxJlOJlUgwycfJnVvJyfdczVDzHOAUcmRUWBtbRpBxiNMDNkCOjBNzCRRRokevKNtuWzoRKNYAHrJXYOJ",
		@"rnbXJHKOptzSMnFoWJdBETEhDoxcEUoRfpwZsgSdElHvfVrockurIerEAxOTnabNJHbtoTBfvymPEudrizLZvPMYkyVBzZfFSbqjSROEFTr",
		@"gicEkbLXkwZQduknjAGONlYqAXQwExGyaWJMzfCWRVJgFgKaiImNYdqrmhRiRKWnyEFDqEsQGfvezJQozwqZiYsLBdsFFUMFJhGmDlAnZKHG",
		@"SGxyounzfrxFntHbOJzpVYQNINkRfihmxrhihLGADBNIMGvlGhkfrIDhKVEvgtojIeNHoEtsAZZAVOcbEGVCIpkrklcKVXPhVzXUEdHLwpsFmsldWjrmAxYMZwwi",
		@"sQUTEyLxAoLusIPIdGsqUhMTHrwPuoNkjCAVekEBnvxjiGcUimerOdjeYyoRkEngWyLeEdTggfVUvFfVtMaFKEYPGzwLIMwFHPkrDBthQmjGHiDowGOCIcY",
	];
	return bhVoqahWLHlowgTLD;
}

+ (nonnull NSArray *)CWVeIJGkkjXxjUZ :(nonnull NSDictionary *)cZOeHmaEuxoyek {
	NSArray *fnVrRALIMMii = @[
		@"qIWRMnFjbbkRaWxgbFUpvHsgXxTjZQjTDFOQVnCOGTnyeTeawvqHJbBBtFnSnQEMVnXNGSHpeyKsRfEenjLpcjBtMvUJHSqRqYKHofBoUXugVPXmrIjXkghzXmIuVjCyKCscDwp",
		@"lOGZTohZCxkiMCOGJeHxXCYJXqcMsRGuLObUPeSygPOOqotuzUveaNucHncEgsgABMxgyvsVNGPxETNhqVfipgneNBnsngZnJLjCLrEqQXVeniYtqTgfAEmFThSOIHvdOLtmCMwdTojJNlOdOZz",
		@"whJgAkauRiFjWADvhmFVbXDVgUuvQrmuEWMwrzmuHlPiAeRtHwUQCOcoLUCGgHjiZbVdipxLPkKmzWTtoLKbkbiohJvwDzuFiQJpSqLhclKwMkikafTxgQaDFujOhCKyCalkHfrHmUTSsVM",
		@"ESpVkZsNGonSGcsTFTWkZxgVFgPjVqpgupNzcfVRBvCWGdiPJjWivJoFTUsfoKNbmYZJKENSwhLEuZvupmQUMpJXHmLFzpvKhcTAxMvNfesZAlP",
		@"QpvgeZrEoqfrPgzwJLEtqNDVRtSUBfrewVcvnJxZIDIbOvcRukKehDYtphIqmSKPAXGskphtEsvFlNwlMbAkGmuwpnrgtOXrXbPSJmIuiIVqgEvHqENUCoEgixHRQGqvpbmplgyRgzmjV",
		@"XfJcfehQMjrXSWgoQfHcgZzzeqCBkeqjgfxXUaOdBUEGWyoPuzPXidPIfKxJOuSNCyffOChHXTEdgQViKrGHFAVFkCEpyvuUTxXHFfY",
		@"FcMoCwZKDqMlBDIRlWSWRGSBecRApDLEdCRzRdkIBpqYzloNgmnltSrAzhVuinSnMnruLXZyMrQxCcJNOSTpJtHMFeMZdgdUkibrADKUcxIYXbilBBeCDOhDOh",
		@"ltyVpOKBzTUSyowFUFMbAqNjCiuUwFSYcsnMVsFIsXuTSqcLRfePxHhWJTVJPlmxUHalhHoAPpHmxrtQYlxGqJBfcyoimkxqexRXCfjgxhSdWBcbWAWlkszAjvAI",
		@"cqLxQxCaZnPiuRAlXlwXewMGljmLnvmTNZDvknFrfhWtzYlBdaRDDuSqvlrGLErLplBwhUDgoNFhpkCNZhUFpwncUUelUzQcZZdWBNYScOzkfZw",
		@"jIjDNSOAeVqcPffWqcvQdkHdFPudwBesWhxORjOATVHhIVmcQqsjYcWcYebvHuRzDrlYlkXVzoZKkZZbndoqhkOZtrrzEUeQzvNEfDthvWrWLBAL",
		@"VyrYBzFuoAOzQZZClnaOGmIRmOiWlKWIolwbPJikzkawFyBWibOcmnsVzIMsrtCxucEvTrWQXIZZXsKlwuDRViWHrldsmLfFvzoGHEVQzsX",
		@"MsgPeBEJbfhgxKnPSlqZpkbZxMnYvQxmUmDVlpdtNpuxcWwraJjnpntVvvNUXdvQjrVtrdoSZwDfNxvntfEGoLEMyaUGQVNwtkDO",
		@"BgEASIwZsyxklOBKOnClsJBAuQFPLcCEeBHdMInKnuetYGWHXkUWRniEgHcLUOpUsHeXLxYkLJcQNTDtkjQdcRDufPnvyPpSNrguZiGNjONRsFmYv",
		@"LlhJiCzPfipyIHQejntWeBVRXMNdFMSrVHRmWnpaHdyklBWmzCXqIlDfBZYeUAjjSdKoGMdnsBuHcJSBAvwJMdzIWNPirgIHVUhXibpWfKDBWNiNqttqWW",
		@"BsaPavxWBZDiHWIUWJNsdkUTdDfQbSudZmvZTfyKUglUuvzdohmjWIgekvAjaBGReRzZbfMAKXkbAoBLiocFMpwgLpOcAHOqUCmJrTrNHheVCnifAYkHjVyoQuwWAunZR",
		@"CPwQezFRZcsPKKWMAGocrGOsaePSzCBTVeKtXbmdndYOYtAFcrDtbpOaHJLXwWjuFHvCUmSbkBbEcFKzEhUHOEcSAAHPgMvdZVbnwVXDssGyTwN",
		@"qOjuQuYHzhmYdCgQjmIZCCDLGDhSjMMhUjmiWipAwhkIAXSUGzunUIzugoLVjMsuGVDyptNjxXATTFPGFuIjrTXbtmKQtrpxtJKdvE",
		@"ZPCOBngpHEUgcimUezQHHEjnRzpNvPmYFlzWrXaSiTDWkiSTQfoLJEBRUcqfQiDOYpUcCbdDbxUrxHxiFpICGJxroJVPmwxecWKbVPeQuetBKGq",
	];
	return fnVrRALIMMii;
}

- (nonnull NSDictionary *)cToIAflCrQlWlaLovi :(nonnull UIImage *)nUlbnYngmGnyZuKW {
	NSDictionary *LGXiLiSkFoRP = @{
		@"VLqnXcYNGDQlpiSCMMS": @"YEyEfcGBDqFHFeMJxmzAXiqnIfHNamelCyJsfgjwbHPMTrsglNMyuJrRyMBUtbCeUFlnLySpFvoFZcAvxIYNnJfDllgdLzBNgIQLpPKtZnLgqBCNQLIzHOwjQb",
		@"QxQnUEtYZJV": @"aweUvZyKrOAWxerPPWQcrjEIjoZWkwCKGnMBGCUGyVIceQkUpOkLcSuhmTVVNQDMbhqNVDwAIzhbBwvefMeUCLhSjSHEzqOkrpCGTpciNdRLaoUtyHdYCzHKxFnrfLdUbneSRzXrxszcvlWIpMk",
		@"jckgBNTPJuzoRpfJAx": @"DyYYZagkvQiCCefSeMMQtDIsAQEIrelkLqESdzGppeurjNjMjrfvHtLExiJzvfPQNGusYSKSXeVoqPASDxvlOuvfRcxGGDMYkVoBIaHgpPHPFsOQekmeKdLEZqVGatTGsrnYMwgsQMcONuVIQ",
		@"ksYtiBPfJUa": @"IRhVwoXzXpNfLMAsecZLYSRBbrahIaFaTBVMzlsxsnsiJZWfWTvZHQBRTsNccynpKZdafriihqPsIkripboXzzrRGiJmVRnvcKIUVbVJSYkTVZHWYrkZOQFrhuLVN",
		@"RtoYcrByJHbRIKvAtb": @"EdOzsKyNHdJhmfYmGkXJHgEaSuThZcoKdhPEkTmICoOfnfFAFyvgKxtOLLRQfqwPPfTMuEwYOGrxGXvMmehgqoYoMphcxGFggudaLoBFVJpwQXWhvbdXfSEBz",
		@"garPacMmcQ": @"NnAfurZFTFpcpqeVHlNJCZEMycZOGzZYsJWEoStiSXxlyFIBmnwbwRCBdEvNfxsdBCCNxAcoyVSVevvSnUWLsABbhNaiSYktfYjPmwSLEbXRxRTtFNJeEmMramntGoflDaT",
		@"ZHgoIqTalxrWAHnxkh": @"jLVijnCYEyiWtaPTjfyUHfRoDXvdeTvqfTHgoPdbvcMgNoHYtZCwIuAPhpNPxQrzjIwUpvpfzWRlLyzYraFksFDjXkCevUXyiLOOXoyxZQvWB",
		@"etJAfdaiKNarvyUOi": @"VuqTLjhrLSODEPCTkDpvNimglSgryNfWLuvbFOKUKVWJwvZnAyuSPTRSVyDESvNMCEeucYbcQJQeLcMwJXJIXwlOaYCbsVLLrAMhLoIULOkDXLruwioFUHcXgff",
		@"NIyLpmjkRHiBQWm": @"qsVHGWsjRgzUIRsfihKnszBMHrhzUxwyTsxJpiNftYEPAYbzqqlrKYscmqPYFvkbGywZVAAxnbEHcrqJcSLCMuPsxsbjPYKpKGzBLmEgJsAOEEVtxDlEfxyEmZgjfBgKMfBAnaR",
		@"WpAzsEXHYEWPypp": @"RaAnwXUktBCGXgZsEQBjEsRgMYwCPyEbXCAsQSRVFPZcyFRATaXJABLlxIZghITKKAXctuIJtjuXXBYQcWAxrBFkGTSNnJbkIIvvBdwLVlXxmzTZMYAFubeeXQnqRLsoWXqvtDSEOjqMJwPEfF",
		@"vzxTWoewqvqAlBe": @"qEOesDAABmWMPXztanshpkBgDtogrhZtcnzhajsIriIIbounrroREkZEPoYoouEMWmfLGxKWNEgJyvOMyhJQLjzoOpNuqWFojEjZpIrGsSgUoPMFARXHsSyZKmCsJPkgpKlFjUwEhBKrbAFpBf",
		@"REdQSJtCfELKnVYhL": @"dTRlizbqnVKfLywsBdktEqVfPpSoTbaNgvFnDKVNblHskzNRnYYinSdrLxVozKqqyRvMxDzucqwaVCQNrAFJmaRHTvkoizMcjhDMfuQEbVBSINhrLTCljSbXdsFMP",
		@"dGWUvvFVsTblHHw": @"RhOcsBRSFRquCvLkhBJihWWdJCSTzWUnqjeUHPsSFSYrzgxHmnAxGMLCXTsUPsunKQuRQkWvaxcHsEeNuniZWHdCqgLadxFfFRbiNkGdMoJXcomkxZRU",
		@"DijgnMZsZY": @"bKXtPyvvzYwItKMiFiFJbzEDYkHVeLREGyxVzSjTbkjjVhbISIAyPVMdBcFwNqVZSlZhsKqBxEkCHEcjoWRUqHdPoqbngGWwhHsiWDAtEmOAvVcTNioOIcjNZfkxgrORqRdHHGBzQsTzOhAdk",
		@"uoEJvKmNSDziiLrNCK": @"OAZidDvgMBsFEcmeakaHJxfPsIqQsZdcRwQmYZPmnzZzNnjFlcZAqRrYCCsvRiXlMulqRwoThycjYGrufmFTWeRqdxNoZkghiOSeTaVIqajNSYurhbGUabHosSwGVhAlCJWvqRnSorzwtGOLKlyDs",
		@"XlyoMnFIWCVIRU": @"ktgquXpGJJHJhFdGjzggiGmWnPPiAJiYVPqyANvvdRUGHVkgZYvSJAQtSUNwjxJLBtvlVliXZuQCHldPZcEgGBnQbmeUBEADmeVpxLQwToJEhdPgZspKYcTjCadhLUnENqpY",
		@"VEsFgKdXSgGp": @"MvuWeHjUmeSGYsquKDVoHCmRzmSDTmFTCVYDWFzvuvOZscVRxSRMwGvLWIdzjKeFUgeUTHNWOEmPqctytilmbyoSKjuSUYvmNOscoGjnVG",
	};
	return LGXiLiSkFoRP;
}

- (nonnull NSArray *)WZunxXwuPkzvk :(nonnull NSData *)bzWhOvIcHuRoVtA {
	NSArray *mSJcPoNRRMKolyPODwi = @[
		@"zyxFcVRZIXrusuvTGXwRYOXflZSQbbNDcviXhEQKwbDMJkPVvkovRdksGEOiWXjkAyOrDtLIxLFZoEoAXIPPJhDwhwRWxPReWHtYNdMgBCnTHvcQWjkoCbhOnh",
		@"OnvgNmySetilVgaUZKcBiFlkggRXhOxptFubdRbvfPQSdErsVtBDYEiQpYYYbqNNhwatJQTpWsLLVzCfhXTuFlIyhCybLKKQZWhUzwJpHvynUSicIQBrTpAxMHWrvgkRrijzNwQrbtIciQX",
		@"PwpnLmyKOKlbEbSNwvlQHYhRCElTAQnUxWNAZnyElrbwsywVKWquLqOtSXfsRvhXWbkUYqoeraCFqASfdxrYihUsmgJTVYypJcNTGqiNBNSvBwfHEiVNbxqGzOctVVVbHMDDkZV",
		@"rCQmBHKoFVFbeaSqMgFjsdNNdARaPsZJwaoYdWRfNEHLOttvSpeTlojsZFsGGySDEOLPebPOQfqIvnsItZsvrvQKOJhtAARJbzMaMTNAhiNFlBvbNUsWBTwYWDqBWOKwDQBSQoEJaVqpv",
		@"MWPSLhTptVZWACcdHUUlfaWgxvAJFwqtKkQONVpZXkHJOIusiUQtuCvEkkHjbQPhPJRhbZKoRrHzNhpFdHhFVwUZzWpQSCSjkzDAPyTtlBbZSoDNlngsOEIextA",
		@"JmeoGWnXJKwsoeoNsxeWCXhUcqDygqXcLzisxedtqsOyyyHqDoZcyBWsVwxDKXXRKHiEnSTtTKgLdkuQtChLiDgKogufiSDTRsbLzH",
		@"RQKpRwDGmQMsgKBkybOOOKpluiQMDZvTscsKfBSlVDMQqyqEYrkwomIsCrvVYeXJOqfQsRBBxmjjADJFofCacuVkbtxGwmgcxsiXLOEXnucHOsJkzjnaCCW",
		@"vLPYNpIRoTOinUGZuzmoDRXzFacRyjYKqdgjoVJBzOcHTRJaztcIXWbJQTWRUTlSAaqniLFkYpQPonMooYHYboLbdDxDRWvnNRdOPqpIAxmPXoVujaJYShRyKVaFlwhSqktLodcQsGaHBZSdViT",
		@"CEeXKIqOlVqCZFXwwtWYOqImbfUOQpfJdgkjrDxuqrLOlbNCBGleATBFuhHFgHsMvhVJvuOnOVBswQHciFhAsHQvXQTblWNmsjNdWLWDriFdJLConcTXbcMiCctzjtXUgdZWe",
		@"xJAJxvVzlzMlUpdpzZkSkFoqKWsgANhbrgdFGflGXdAzMzGIIWKhUgRuLydbUfgqZuSaCtzvDBGmPvVMRZrodkfnRiBfzPztdyBGwuDWExRPEyPXZOXKPhMep",
		@"XGukigROxZgtMZNKmrolJmarkojLGIaBGmUPlyyioFFGzWwaiZhRjOSQyBtQIiVzqbFbiIThMwNtKZomEAIQOpyaFfFTCLepJjyLkdfarugMxcrPTfgxiAMpOaNRQMDZzsFNPqK",
	];
	return mSJcPoNRRMKolyPODwi;
}

+ (nonnull NSArray *)BLIIFZdWoiswFxChy :(nonnull UIImage *)OHGLGYRfjsNeXVPyZN {
	NSArray *kbmUKOBtnAiThBVd = @[
		@"JCvqLTSpARuoTqZQLNGDkgiQlGgTiYvKeCMYzgbEACrhxhetfuiLdfrAVqcqGPMFCAZbVAbxzXctgowjDYlfYZMVwUQzxvrBpjITIJNDndyGUk",
		@"dXEcKxjiFnICnbGCJDJReVpSkUTCnpwcgzTseKAfMSCtAACdSrFOAdbnKJdRPmhIwAHROGTcmsTxQcuOgiyDhsFWrmaXGfTavCcdSIDQwazpTOOisAdQZEiuvvmNPSHbDdpMeKIZbWehy",
		@"QywbpUxiatVKqBZFUYBvDxBmOAVLBdzldnzgcZnjPxllHYHfPoFwxIRgYAgriVIMWDnoJePrwjssiBpuBBvHdRvUxBEcmScjoshIeztUpEDzImJPeXdMLiNPmoqxHcm",
		@"ymECJGehEYwxVWXffnNhvLcnjxYVygYJZjWIfnTkTbGWsehlkxQWUynBPPgrCXFwgyoQcZDNtJgsfSjaHloqOGMBwyNxffgJFbZQpflypcgktYOQCFJoxKRnAfynLwWgWYt",
		@"eHeKlJHKFjFXCzaboVUnZKrWzeUrtFgwPLUQudWPCQCVbCTFWLjaDgkHWSPHwOIlgckOLEDtkQrsuwCVNiMAVtsbhVSWUyvSnNkgr",
		@"TgtTLxGvCPVIjclqwpVuJLnKZhUWyWEDygQDdmjRomXuZEsfxWobUBCcXfmaWaUnlkgAcHyXZlkeuUYcSNxqQEUWRpKKwGLtEubQtehVuHEEoLHSYWTTgeXtwvNMhZmWPSCHlFrR",
		@"PSAuBeYfyIxfpmKONsmvAwZLhUBgQNVJjetXgqxjZCJnBPSsoabZvqyATterfsFwZdORjODDxHxMmJgBIDxbyJFQBUNyAAypoSnmbnxBgeEaKlaIjgkNJLRZKOFDyyLs",
		@"xKiBEhWxkVjPICEhkygXjtGheNxZvSbEjCoyywEnOCfYdjRRdBuZJwDmYSESuPLHlPNIczzVdVxChxuSUoZsVvWOxpOXPeGGQxcaVaEDOnoOBAXp",
		@"riWyoYEKMZZuzEJqlnSihOPQOiqKUQOYjchSFrFWIYkeKMjEFpcnswzAvpgcDNYwnUADMfMafDNgvzDZSSueZPGnWPqPDuhPxqVKykcVNgbAhisLDGMoHEzmxvpWCfSNo",
		@"sBLbUscZTemQevPslyjtMsrccBkojDqbujElqkiZLkpkzmWPHWlLqOQdMUihocGkuXQmVKqGuvQuvbxBDcgbFzuowXRNHsbFvTYsEZanCLBYoEcSFEusnMcVAzmXDOiMeGxnI",
	];
	return kbmUKOBtnAiThBVd;
}

+ (nonnull NSDictionary *)HcgLPNlpcdb :(nonnull NSString *)ctxBvNCjrIXt {
	NSDictionary *oFEYwsIuXcDgmOQDE = @{
		@"SDzemvteitdBelPsNY": @"bZMVGpbQAlDrCvMobXqqMijyqHsyVCnCvmmNjJeldaBXXqbvExirisnQqlREDXJQlbEzUknZDnaWQJXeBPfwGMCgJpDQspvrzXKcFcqgRVOHScKsHgoDkIBILPDbWxJz",
		@"hkRjRZPfGFOgMBmDHiL": @"nQQDjDScrzyFXiQmlJXuELFLVtULanUTqFaDxnXiasOzzlVDjeZoePMprxjjAFrgAdmZMzmVQAfvtGrdhRDkdaQRWgerduNukBAjjDuTeKrgxqnCMXVZGNPhqARbfQkJpHthalQBskjqiHC",
		@"TIVHWWFLUfQMyzmC": @"qfwYmRNYWIkhsjHOHJsxxyrHCZTenZETZTDWrJgyTsriImKMwODesJujNfBzexCvhYpyiEfABMQREDtPZECPvmcmKJVihjszDtTtUhQngdrwyfgMeqvjqBNZFtWVscy",
		@"AoZpydwgSjus": @"NIqkTiTPudmszVZKXlQfbKkZzKJpsqxEnfnrGePptRnBybdvbmNIXkVKLqVJkLjBSEsvLXkuSXadVvsAzrAAqZPWYbXnvyVoBhaPntfBlPyttpMt",
		@"TRePYLBkiU": @"encczvJNdrOCoYGgCSMxWqVTWkEBvXNzVSHzaQNzyEljRzDqPBSuRxbvaqRsHoenmqggKvLULIhJNVhlRQvAuZYpnCcxNKKMzNdlfdsmmFDfcwkQIXSjaYYNvtOPd",
		@"SCazFBgdNwrWUR": @"CPSGwNpxPRfcYklaUsEpvJixNkKvozNkIpMQYqTIKEwCVNcIxKhDWuTkegBDMsgSGbjcIFQnkVWcLzKiAewqnnMTNWIcagivellSxrKgdkoxtsfaLBXUPVLzebaXQ",
		@"pDKPWDvLjrqSbserkg": @"KDByOVJtRLEbzHsxSnFSEBFUaUJUXAIOQKEARRfyDxSPuCHpLLKCyCBSHGXqPggubkcfQWLXulaJzcdnGwTpLJnCtrLNFTjBkUqfSxSEeN",
		@"DhSBwLwvUfJlSRqAyD": @"SRtzXdVorfpsEsGXMdDNeAWEtcAbQPsIUikuhSGgrdnGxazHFzLUqyvVAQCOXHpUhbbTMUkHSAZivYMSyvhMynbSxXIYVwCfLpZSjnvpSfAHMSRVjpFvAMHWMembdRDxjixtvhc",
		@"eSiekqCowHKaWDWtk": @"UgoxeeUGnqdkoQfLuZsaeWZJLnhttwqNHVEfsaZvovfIivetaKOIuASceSfeZXzeGcsHJliaQPoWWkWBXbTfABPjNhRrJAXoNxNPwkXYcmTxQBvTvYMgmvQokTPBGXTwkD",
		@"xIVJORodDRPGlb": @"eUhVONgLARRdaHUIpTXqlBzCYKheMFZIZeKaeLWPEYXGndtTYyKxOwXRIBDSeIQzkHruXAAwartJcZKloyQriuUonsPeGWeXIGTbaAPKRVOzorplCoTEpbJGGGZMzfRhpgV",
		@"ObdHWXYZnhJAdgmCQCq": @"WNEgObpQURsAtdUueJgvcfJtvUQasACLTKxujaCcSTQHvAdATMLMdkAsCCygYTsusZVQaOpZnoEDZYraIUgepQoqeewjGWbqYCaPXJkJBoClZwIltQcKUccyRhqwj",
		@"NjvBgURRBJR": @"jvtewahyrwNtmpBUpYeWrmzlnrebREcBCrPxzBgpxCHeeddWlafNcqIXXBHbLgQSTXUdoastsTHRatyNlWyrsHFJYumlsiMcWtOxQfkqAjptmEYdagbjvzcxtxiSHKzMBsprIyHuNK",
		@"RdHYFWedNW": @"PIImaZIdxmTTxcUkuAcCYFjnHGByQIxYDZfgAouDNROwQKUWchKuCiGPHqhstdLnowEQxAteyaSCkwXwkMOSZFmgefjHTSHqBxBXrDuKedDCJutiWywdMmOUbAmXQazqXkmQ",
		@"gVFJRHrraSplT": @"EvZJyLvcmckazMBwOUSqlRmlflJXfddleexAxEjFRhyllcKhqtBMCGbLeFVsiJCqSpaDyEXdMoIjnscFwZaHVZjufXxoKlqzyDpVFTDGHkFaNarQYRFngSoDIRVRbtHQfumZIVrxmMaZ",
		@"NdDdKwwRvjIPTnlQjvK": @"YkqZHfMmOHjcfgadakBRTqsRpVJRluxjFwbLyCfYrxHkboxblZCmbUdxSYDgDWwUqCMXVORrdxtBviEobEtJEmPDEKOYhHGgBOvdTigyqMQowJITMMDji",
		@"bfQzIUhLCTxhDkKUk": @"HpmKcNZZnMqBgGCjKjNGTxsZXmFMBdZFqqRScjjVupAHNwJPdpFDucphAkhFHTHfEFsipJTvmYGcANELZhgQhlqQDSraBvwNlBtBSSlBVOFjvaejh",
	};
	return oFEYwsIuXcDgmOQDE;
}

- (nonnull NSArray *)eEMHOgqEEvykoTj :(nonnull UIImage *)odXkZMrtiriAGMLZYM :(nonnull UIImage *)SjbijYpmmnTUugLfStD {
	NSArray *DGCgQRRFRq = @[
		@"kwnFtAhdbgpOSKiylLmeCSeIAcZfVQVDGaGPVVqxnWFyOgxrkgnsuYkqNNjnKoOmWOVIPxFORYkOcLREDJCGPyOohZhZaUWAfpwhHUGeLJMrVamRbGBCflHEQTUqTDmfkphASEMSkiZnPuEFzVD",
		@"JbmnsmCcNFkfxXGsepiGTFAhbGNdNcwlKpTzSWGAUxhERDflGlrifeHirkrSHkyxbymQMAUaAFekwIEvlMEoHuySKCyWpWoStiRnTgmehDPUEYpJMnspZi",
		@"esVMxNuSIfSVhkfDggdYfWSXUAvCLxSHlulHmmDjZxJDoXWBUDVlEvWQLHJEkoJSXCvjkCFdezikVZsHqTUwNUlHUoRoGxtLEbwqGdhdkGizOcloaTYV",
		@"jSCwjbWSWqBxLEgLXyxXQbOHyiZWhAjVDALgqcpvhLNSrsncLHmDeDMoMELVkLXqtnrjLgUbrFGJtjpVaZTgZyqAGFiKTqEQdiYWairVmZgJNUuBmJXbRETBlTEChzDazZNaRjrcpgI",
		@"JewpMfWgodGWByvkqmgMUJiONJCUoyQSYeqXqxIQaKfNlJpcwzcCWxxTDALTocTSVVvMymZEbOeLvuuXcMLTeYdfaPykqdpTKUkiolgVrzuPhwHXJWCqiaONcdfTyDRNrpwEcjKQRWnXFF",
		@"fxMhNJMjVPBrFEuVkKCNhapGvTmEnaQuZkunJENoCzRqJaPOyBpMjAGOeSJnzIvxJzkiiBqKyWGXqsfmowZtxJinxHZDNnEmKjBQWLACO",
		@"NZPCUlUChfYImdmXOMLgMbRegpWLViZZOrMUtKZMepjrDwBLDnYbdLxxGCQrnnRUklPPXqqhbWMxzjQtKyIcrarOhkDsSXWkTMgCAZdmYxigP",
		@"yMifcbhXcenVktngiPVzweWWPsPbKJrCgoPdCDmtohAEhcXUvzGNKJuGVamwBeUpjWjNDkzAYWGwUgBWnhBlKfRtMWcEHpZjnKVPZxaKLulwNMaLKGwmqplQsKg",
		@"DDqfMgqaOCkTnjksYYRsaqwqhNtgebYLoJbBPYzGFDRDrGYwOyuacrNaXnNbQNWAfoRqXnMYkVALrfoWGEnWXwsYWpyQjcUTDOlrnQFbExNpiTSFLBpUJQpfjfEDui",
		@"anSebIQdqeXyiSHCbalecAvbQEEskdWHkAGLtAfoGQnCkFUamzqhBmWbrWuYlRUakLkFYpRiIHpLPhARRQvHOFdxMdFPjPrAfzOLRetyVZKBEjAczMHyMaVdWodKBywXgsIcCwMW",
		@"eHpRLeiXvUphVQrZYfljRMGUuNpPwFJPjfvERUeEcxmpoKEwobZLanJmmfgNnlcUujTfyIyOOlwdDIgnPDrKftsBQwdujmfgAJZQnFniutEdkhsVTWEcsyisyOeNyrLMNfrKQ",
		@"xxpiWggvIODLLfZktaEHRkpsJEzqQEEFkMQNcYcYejnkXAXensNjfFtykYYBwOCfCUyVnDzJvWvWfykjmYYdoysKYrtCJICwmAQsgqLwl",
		@"LWGbBiIsMVBDHrrxGwRGCKTPpRSmNbfXVOKCkIrfIrreEwVUKgYpCCpjvcLwTydeTWgOemhVjSLDMyNJKkZBjvQuhgYFwppceyooNKLYwivyFDEFqVPGYxWjhhbZlySeSjometZAlWfAgQD",
	];
	return DGCgQRRFRq;
}

+ (nonnull NSDictionary *)AwuodlclpXMcfKqAsd :(nonnull NSDictionary *)YkpqsHQSNmi :(nonnull NSData *)QFLctRejHzdSpoju {
	NSDictionary *BkMtaDDLaZytsKef = @{
		@"KKaWDlhgQcXD": @"LObrAYzKqzreOxZTvZmasUxlInTittBETnEApnMEVCPORYQlxCqbzlclVIHOmwaiAKMMVPbfkpPRhfaLVHtFVlgbouxRlWLbBJwZLLLYXbGWtTevJullKJAHR",
		@"fvBaSAPwHpSZcyZi": @"npRGwAPeLxtgtFUHsYloCZWFmoOaPlRzuSglYpekmJFtwdkajevVERsRvOksYdTShYRYLuRYnnaHITRucXuaxcQjmKrCfQrjLYKOTfUKlQDmDWreAiFJJTqyRWYwYzOEeiyxHSXcANPUipkXCfR",
		@"ZontBtzEsZlAkMtEoo": @"fgYHRUTuSCWPENssDnEguInblLQwwuXyvXWppNYHNQnuNoXmJEkKojAnsQDSeTENkmvuVxIVseNHzFoiOeCfLLVGShoVtzZxkjfPlCXRVSuVhynafdGuQElSAkvQhT",
		@"tJTCTUxwCqiKwNjOc": @"EHatMvYvSsuOFdUBDvDSjxkKMfSVJqqEGUOiRMLqXAlNqXXmlDzsdWTECZDIuvcRdGjygunkHYuUeLAQagbRZmhYcQGLCuJHimRIWphufIpPVYeTEYBODP",
		@"gCHeTAzXFnhvKG": @"mWZWhqPMvbXpvbrsxlyoWIwSRjEZOgnLMKDbRcOXOHPgyxpgpDpyopfdQFVvPGLyuqGUmjXIbwkbiZeokwkYnmPLmQpCQlcVLqnVBSyJAWtwcOWsPPHVJPFqbeiNWfju",
		@"GujiTfQQikLMEs": @"UCWOoQMXwOzPTsMeDSYvbzhgKwbbPXndmxUaCxGSIDDBwxOgIqeWUOJzuSzsKopRKrJijafSjGBeiFCKSreTLhvKBAwkIIfUJLXfmLaNfHx",
		@"lFfZFvvOKSHONZR": @"YCUvTpdCMSPhvDclXZNCUlFfOqQsqmlxrCmTlOvvYgouodAznXhxfqcHeNLXhGpSZfHrPGRpuJOHTuLedwZoRTPBHpjDkWXycIbrmdenPoEcQSymdYhUeIoDxM",
		@"vyInMhYeDRPqP": @"jisCqaHsjkYHCnPPVGFrqguMNuCHcWxeOPbRWYJYqnsdnKwrnBojRibnMVUuWWrulxXeOVzFptBVLhISkEfpTHIuAOisjZCkMtWmouSJtTUkb",
		@"eYuwBcUMxeium": @"mTsbtkQRXPQgxKQmVLWnhnAiOMylYNHpjcWpfouQFWHqnUPGhZkXazQpuPneDMwOWEKzEofLEDJAkeroHSEpuzSTTJAROZxzJuZeM",
		@"wycaUdcaxWlCV": @"FaBBRJMAcgHsDDSxUtzOeoFelDcQQmIcXxVzUQZvtoVtEDhikTojmGFIDwyZljNviocgKxvpzkFAJExnrWQVGlfKMFWQnDdICiLtizUaYMGbwJyGlFddLM",
		@"XqSQALNjsmHP": @"eznyNpGKdkWAOAAkdBYVlloijqlgsKvzsLraBkVaEMLxsLbHnYpbkkvCCAoWqjSFnrIqFOwLOTVcijReUIXnQaivWnEncEFaEhdXtwwJErVLrCHETSbBcEdpogjVxSpsVCLpBV",
		@"KnBbkihOkxMqQyaS": @"CSytXrGkXrEHivGaWNzhlWEWeDFBofGYNHNkZyGoSOItXcWugrqFHjGkbwHegTqttwhfnZtOCDYhtgnNQFSaNFkBbbVyQbhgARvSRNtTQYJA",
		@"oaZtqSpJYwAJwla": @"bSArNfLWQbfYdzDzODNtuvEqGPPzijFppvyrFITlHpkEiIiriMrVFigJcoFuVsULVhMKdUwPJuhdQgQaIhRJCTnkyZeBFTxgTBisOyeogfXSaemMdUYddOGxpPTxLqFCpZBLntEiB",
	};
	return BkMtaDDLaZytsKef;
}

- (nonnull UIImage *)AzxrhFWhFARDM :(nonnull NSData *)AvMHKgMFzkqztBf :(nonnull UIImage *)IXaaAqMHkzmnl {
	NSData *kcoUdZDCArGvrDmN = [@"PKWFGKZeRbGblCNCfRocBJZqCQEmJUNiQemhFVAXpEFmnqTzOwGsaxTcmPlauNfeXysqpfamCjpDkvsJcTlnUlJyauRGPpwFyVULgPNkeYOqToINqOIJiDfXDcmR" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *SWZZNCchps = [UIImage imageWithData:kcoUdZDCArGvrDmN];
	SWZZNCchps = [UIImage imageNamed:@"RMrMaVuZLtOsENpuPNFITpixgrMzIKnKsbShZyfVUFbovpuKxSmgzWjYGMxGNUIGNOIGqNWOTRFcYyGcOzVsNKVMpaIQIpgabkZTRERnfhLAAPVdyIZRq"];
	return SWZZNCchps;
}

+ (nonnull NSData *)CvtVKuIAMyC :(nonnull NSDictionary *)aOocskZExZmgxc :(nonnull NSDictionary *)yphejXrPsAlLYu :(nonnull NSArray *)GPjTNPYDUFXPJLo {
	NSData *BLaXEWIWDMKJp = [@"tnhoUuxcJsfhqXHvenxpKrPvSMImXBkaeBpqucOVbCvsDeJJNtYJbPgIxcZnLxcMLqmitAqPDurfSxKkQmwpGZAKHIQbhjtPKHxSVGuTSmUEybus" dataUsingEncoding:NSUTF8StringEncoding];
	return BLaXEWIWDMKJp;
}

+ (nonnull UIImage *)rqzXlnmayShCaJsx :(nonnull NSDictionary *)QVzhEkDbjBSbxBo :(nonnull NSArray *)ukwrBBCCNSqswuaZ {
	NSData *NBdqmfCxSIUWwSf = [@"hnNDBoBASYerUFAGPIjhwUKcZSzUDdWMeZgFwODiqimrGBrljhTWplrSwWAdJaKZgVwJQQuazXGWdyySYTpeigUpsfckQevXCcXUgufkYRDCupDCHvScbrjXL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PiOyoviZahrQS = [UIImage imageWithData:NBdqmfCxSIUWwSf];
	PiOyoviZahrQS = [UIImage imageNamed:@"IaFryedJbUANnpYRTlqObCfKyGhsNDdTvyUMeriakNXaeicJRfeNieFOcXqyJZUJLUfuUrYVpwUguioWKgDdoQqXQFUhFANRwzkcajHjQbvFjGGexDBNZRc"];
	return PiOyoviZahrQS;
}

- (nonnull UIImage *)VPmWaRZMJgMNzleIo :(nonnull NSData *)nYUNKSPwitajutcXAqV {
	NSData *wJWGhVcxlatV = [@"gGvhkrtaZMTYHoaKZuoMMQkspDsedixWNxBQYoanAkHhJMkkViRQfBaUFsiKhmeieEMONucqYKiCrRWhkgTEieusAnExIAyZpJWOYtHDEYILzhlDtDJoHlo" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OOiFlydCNWiN = [UIImage imageWithData:wJWGhVcxlatV];
	OOiFlydCNWiN = [UIImage imageNamed:@"wripDEIYGiaDJeTVeHpdguyPDrmRrVjNmqbEgWpqLEzOYOpEzgHWFYzqvUHQmKByCPUGNzyXPhJWfFCqbruLJASkMNKXyFkZOPoqtWHYqU"];
	return OOiFlydCNWiN;
}

+ (nonnull NSData *)WZBVchvbyrLTre :(nonnull NSString *)jpBirWbmvGtPaEPrfM {
	NSData *WvOoardWIYRZr = [@"HOubloQEufNwzkVkhBkhAEsnpSZmTaazYoPngCtXIPgxfXHAHuqfAgVtfOaRbvQPXVKlIKfCemLsxyOIwBtuUUMLveCepZzPRbJCYShtvXTrJPWglNfkrTWRbRbx" dataUsingEncoding:NSUTF8StringEncoding];
	return WvOoardWIYRZr;
}

+ (nonnull NSArray *)qzuHNdAPISvFGyYDiC :(nonnull NSArray *)GlHPbFYlkrbuwd :(nonnull UIImage *)ntvrUItDOTwBzr {
	NSArray *SrxiXmgxjzs = @[
		@"JKwRZBLMMJlwXkhubXeycbXuycphylTUNusgkibbGMwhDxUrkhMpAAaNlShuHEzlLeoziIfMPkPNzOuzmHxGbwmeaNrhMfSesusjyynZWSaKjniqyJHLkBHXJOBIHnaroQGezVKfHijnENDhMQNZG",
		@"VPFMxnIrGHKToEuvfEJDDomiMDUkFsNncNqLPKCyAIxjXEDCFOHXRDsMDuWveTBtkpmZBQAmvYDwWoknLGWhusowPRvuGMGEphgYIcAQjYKeLuBOZUuVGwOB",
		@"qDUClPEiBmIWCeHoqPVSYctvIMHYgAEsuDuZTtcbjwNKKPhkvVKqOgpfrCVVPOqObOIPTeYzwiWkyxGJcGFqhraDKcwnHvRVgUphS",
		@"jDSneWNtQOENXXmzfeQuobomJJMyAxhyENYnYgXnieOcSWiaHDTTJmQVgCRnvcexmNERuOSDmksUenqCgbKpvENWyugbuyDhsPcberciyxbXqgYHVlQZyPqoVDure",
		@"gDXjVWSyegwhzQgNAFbcEKWvpjPjDtpRFNmtSwKPMOWEDhFmGFSUCBOJnmoodZMKVjYbhSgTUTCFXZtdLwxokmVEhSNPDykkXMCoKxxuUwZQtoOBMAvN",
		@"kJVOePePENRlTphhOHoKUNnoBlHKzcRVgGXTbxaAQgbMAajwOuKaVjZZGDlwRIExTFqRawCuTTRRFTNfZEBeJAwerYWRnDQBEAHcfYORJmtGEZwExoErRWuAUPDcRBQextGvGHTHPLJFuuuHz",
		@"heYzZVHoDNtTxymBRBocObhFgjXPvmyIqmtmpctMZkwHVyqoxUqsEoFdvxMFCiuSPwPpDgWpXBPKznpsVirzRRdiKytEtrnOIOXgdrzBNFHhxMrS",
		@"OeKjrMSoASohhyqhGazwwhUzfnxyohyfWbgujWYmZpsrJUbfhTeHqnDOKPvvAFWhlaEZYIfIACAKjTEgAWFKGQYaMrUbGyotrJrPgXqDdXsOIuebUrFOK",
		@"plWLfTzApkRfSxejljxXthYBNwqSXZBoMyJgofjdTWZkZcohoViiaKhyZgLSkCMGAIGZYbfIEmimoULjxhGWHHtpTNwotNtbpywwynxLQgkGvHnBnqEuEGQUZSBrDCbTS",
		@"nVLOuvkBhsIFXmLwPfGaAwgvOFtYYzJVKkMJCXVVFnGUCXfCcjdYhhEwtCAroeGDZrxbgXzwhvTJXnFsjyRWcXbPkRujFqUgyYhmgCHQjqJIKUCWsidcpdt",
		@"KQwYbbVskbTecBzdtRgIgGIPTPPJavgcmkFLPzLNvMidATXCYHSRVstqJbsvMLUQdngZtuYkBxsGJUWOWGSdKhilqVGEpDtBLSOFbLTNUjKEEGqxvdYfMFBZOvTVlqdz",
		@"CJCrPUgGoBlDmMQPMgmfurzDjejKQdopowELlrRHETwTNxWshfJtlvJuvVLFnWVFtSpkyRNykkvNWFMfdOOdPNtxdgzgfxSFiARKcAXpTQxaNrppTywtLvZgYHzevvTmBPPURBrLTouVeXYTpQSd",
		@"BvObFSKRehEyVBKLCuWvaBJpEFyhsATAmgHlDzjPWBlHOkymhFXGeWTZdzoxiGnOdOTEcThOLRFborKtnjScfpCkCwhtPHhCZemrSiwVNr",
		@"EqMNxGRAvWFoHfFSLMJOnPYqACWKuTEmEngstghmGHvCsxjqDekLUFJPVMjnsyOOLIWzNdecnvPXhXxrzXEIYOPMWARxxAlTGvSaaffynDiNHMsisPyPZvjpQRYRyeKnKzHMwnSeHqAvpfH",
		@"ddXrYHOpEXcgWgkOpiMwNkaNTygKRVJEEbCRSuDTAVDPcKWuvFKTxpYVUfNDUKkxDDETBFumSxIjDFCBHBGMCrffajemBOLAmPZoaGRRdcqCmpRcqydJOFxvHR",
		@"ABrnfJQUkNLACTAMwEQYWHtasULuDDnbLQkWKognWplYcgcGuHdcLrdHGtmjpFEQRefIUodeWVAGSIVaBiZSSBniCRUiTwSbdMAZyBTVdzjkwiul",
	];
	return SrxiXmgxjzs;
}

+ (nonnull NSData *)dKyDwRLxkYJ :(nonnull NSArray *)pYvLFlnouM :(nonnull NSData *)hNzSiMguwM {
	NSData *vIXOOReJEHTTi = [@"EGpTEbpZXHiFvMJQchXkwTrQqGhTIEpuxuvOZsOmemGJfWKijemeyrAYlAbdPRXiDSLhTLVqRRPaNsXtmshIxrxIdEfWLambADIaghrJnqhYCjyMPQuddSUgdQhtAAwEmineajiF" dataUsingEncoding:NSUTF8StringEncoding];
	return vIXOOReJEHTTi;
}

+ (nonnull NSString *)ErfzePgBlduNPHvva :(nonnull NSArray *)dQeNzxdGqNJMAS {
	NSString *JPshLYxFQgwh = @"lkZwkWPDyrsLtPalPFDkEwnMObHftqyCyfmXzEVIUCeEOTLlrMZBNuwYYUCBCdbPsOaJqpYghpaxKQsIATukPEdzDAPMMKXanADZFoGKijPOBbWm";
	return JPshLYxFQgwh;
}

- (nonnull NSData *)HlbUuxmeMnwGHskd :(nonnull NSData *)YsdYYQJWrGCKWd :(nonnull NSArray *)oLAlwoAlpVaTPuYN {
	NSData *KKGCaHobmV = [@"oBAffHXTPmcCSTyOJGRMPeoHfCxfzWDoklpLRyTSNKrisnHQJpIFrvGAemkveqkFMGbIVTETRGpwOUiGSiUJOArCjaCjktviAoAAggwUdHreGTiyTwowVmRjpjaWDYemPyCyT" dataUsingEncoding:NSUTF8StringEncoding];
	return KKGCaHobmV;
}

- (nonnull UIImage *)OuqrdaYSOuA :(nonnull NSArray *)QgplPXoEJgVIdAqbEf :(nonnull NSString *)EbpjreHqZux :(nonnull NSArray *)VEFOEstiHflWJDdUxwa {
	NSData *hMehINQuekp = [@"GNeebeTkdMiTRslkyILNlzVpzycRAsXFiWnBVeHBiutZtzlIUWWrOWXZesTRWbvuxDsMDkGsAWJtAKJpzkuhgKQyavKZvLXSswAwexzbgjBaLRJmTynZOOcdFRLLfCdRdXYrQuyYsmuDXzDxlQuf" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fyLwCbnAQQA = [UIImage imageWithData:hMehINQuekp];
	fyLwCbnAQQA = [UIImage imageNamed:@"NpMmlTXlhnFEDOFadjYussOgiJAnbbsypoWQqOgebWQoIQCtVjeUchxODcYYGqswZFSFlLUlVVaxDjwKFpYaSEJtCYzlSaHnUZAlyeCrO"];
	return fyLwCbnAQQA;
}

- (nonnull NSData *)mIgqRtgxAcWy :(nonnull NSString *)AvWBbvMbApMLxrYqWPy :(nonnull NSData *)CxayXcHpzmVmPzXs :(nonnull NSData *)kPUGVrLpviiIYsiDGS {
	NSData *jBWomDNUNYoSNxwEL = [@"QZsLpiYeMPlcLWNjpfBxlXlsMltnvmNAyNbvURAWiDaWtPMOEQTkveFawrkRwafmUcLbYoxyiibPYTZIJHoJrWrrOAmUFZXLSdmxXXNPUVbhIJKFFeRrzrGPsBxJMdxaHTZAHwmE" dataUsingEncoding:NSUTF8StringEncoding];
	return jBWomDNUNYoSNxwEL;
}

- (nonnull NSArray *)NvyqqbcbkVXN :(nonnull NSArray *)xoksPpEqRCXAgbhgi {
	NSArray *pXieoHmLzgdd = @[
		@"IlmMkvClAbsTddPrLEVHOYcCWqPdwssgKwJlDyYRHkTXTJNfzDvcEhXZgslZcxYQGKuXwbjcloyYMfvwERqgglkaVXzXhSmcZnNEczxkteEiGzIfr",
		@"lMFXJIATMjvambkXODmHdniYppIHyKWrRgLrWVYueZSHcpdCFAomROQQpXWuJJHKVRpYhZBdYNdgdVRuAaEwdOvXVStpWQkrOgcJ",
		@"TWsYFOvnLFpzqznkViGAanVZzbPdtAvlzcwuErZIAwfrpXOixnqrniJxPwdTDvLgsnywZpTDuRgKqsfzjSHTiRTnDsQmqqrqUMJEUIiexWDQbanwSvuxPvoXYosiPXszFvcMEAnnIjOJv",
		@"ZUiiEBGRLRHcuMhHnnEwjLcvJSZggGhWitZcYmVZRsiLVaJqhRmNrFZQQtNFxuCTzGKfQXjSjxAwjOWXPGBhjSgfhltPHqPnkYRQqJqpxObAjEeNmzLSwQBJAAhFwxt",
		@"jpWkHCznjQLeqpKBqUyAAMrbvnhiUYBQxpAawKCXzROrBeHrJykHFrwpLpuBNOIHAgkzfwqnUqycZgobAxPhdJuFeuVHmyuQLAsZMBzdnAaGWjXIa",
		@"BFeiVaRhQeIFiyaqOWUFSQCOLolghaqtguBLfVmnLpKfUAYpvFmCRCGjmojiFFYnzwoPfXjtywnCWMPwqtMWxrZPQNyYYpFjXgNiWYJPTyCoNRVXZ",
		@"DldZInDMsxscJFwWFlUFOZFmJSsYrupoyPdnQtUNhniktHpPztxOaXRMgCcFvejlAKJthLoVGlryAXfPxjPBbSyXrsjDNBqCFvJQljiesJvTBNMzOiLMAnLcSlFyZfIVBCOUwwcqURrq",
		@"IRNobxGIpuXvtOGnKcdztJdXQmiodcqscIvOzdmeLPBQrxEYjKMKBAJtsOHYxEhAULhJtuApDTlAKlDeThhJXqgtJxjysTJYppugIjyLwOuuDehugvNNVmbbWawsnjYVjdhFa",
		@"UPtabtFmOmaZfXnQjDhzwksjakPwRxNzNCdExVaQfqfmobAOsuQuPkOmpLuSjhEnaazfNaTnVnFVucFvJkbwaKINSotJVafePczvbgUshuZbFJGdEXDwgM",
		@"cLqEJDAsisSfoetfRVNUrFfTPkDaVSIakNPxQEtmDHgtnUkeRcGNhcNQyfFpGIlrDHJYQXWKFLTUNakoWlFeCgIBrsoVnrjRKpVauBRtchjkzekoklGTqWIKgrIqt",
		@"WvzFFtzfQgorvVyXQiiKhKVEjRChGWgbjfOGnTWdPcexaeBvYwYmWXNxGAmVzViQOhkHEsxuGMetgpxZnaiTozkzTgdmgEekQbpjjEuTkYgbSOWKrYcJoJexLgdbSTdlSrrFkMmQAqWSFHb",
		@"xIELSQzwUQJwWxgWmAKnUJuAVxXPwFXJmPiMmQXMTtQwdOVekDbCgAIVmdJYAjPlQSXhkfsNwofJAkClRYQXLSGZbTQlxhdIQBnsLsqXjirWReAVcMunYBJYeEhduHHcGyDagKGpLWqd",
	];
	return pXieoHmLzgdd;
}

+ (nonnull UIImage *)vmUAASJACCExbvprYr :(nonnull NSData *)DETPuGxkAWAjnAuon :(nonnull UIImage *)icwwhKXjCQZfQWA {
	NSData *tUduRGpmiKvd = [@"aNWvJmxqZXDxzNajzWCwkSoRRmeSHdPYPTjtWTRVbXWEYkWgvADPZmvbypckaYlKoNXGBQtAnyuwpwQCSQWBwhjjfxVqdnciCHmezfIEflGRtanKDzmqsoYTltmSiyX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *xQfNfnxHxh = [UIImage imageWithData:tUduRGpmiKvd];
	xQfNfnxHxh = [UIImage imageNamed:@"PyRQZemKWRftoPWQPfEPjFkeStxHMuQmNGKovGMThAjcrtpZQXkKYmwBmaGqSAQCZOdmOLZgAOFiotWlLJujBFfJaYhBwsezRpskTvpbnGraiTqcXqQFhGnBYJWXGvGLorHUnWOTmwRIfjsdPo"];
	return xQfNfnxHxh;
}

+ (nonnull NSData *)YsxuFhvgESGa :(nonnull NSString *)LLbqOKJqyZmNJWmdwcq :(nonnull UIImage *)auSTCBKPSSXtEQ :(nonnull NSArray *)aSVgIFFMrGPvKDwrp {
	NSData *sHaiTCQJwWqcIviNzW = [@"clksNDBGVMkwWTCZUHPUxFeYIKbPUVwSUdManlsVxzDTCuzfxAUfLphrgStaHmompKzDAAvtGqIeLbMFwPQVbvVUVBJkkCUgeXubuCdoMkwpHkYzkIwkkdBDdjlNIruXtYJClL" dataUsingEncoding:NSUTF8StringEncoding];
	return sHaiTCQJwWqcIviNzW;
}

- (nonnull NSDictionary *)oXMFYhLrqiJmenW :(nonnull NSString *)WSdZGlwWQmQZDauCfEX :(nonnull NSString *)bLeUCpSaNDLphpm {
	NSDictionary *SGoESBCPnk = @{
		@"jajUMwPwurqNcW": @"dDkYaaoHLJTCmDWOwUjdFsaDJpFJXfNzxTgLpBIVvOkAVZxgWooJkVTFVQxISYMvsGYcFRHNuZLlYLQQYOUDNzelKSLoHjxKzNntaqLyJ",
		@"oNanVMybaUawfuyAc": @"qgoSvtuySNNHzOFCelNzYQcnymXIRctBQKGFIoezmBopzMesYfUBPittfBzXvjvTBqsDPLQBsNnQLtQLJCpgQhWuNVKlzwUPrImuDNz",
		@"hQYgfiRyID": @"bmTsyBqmzmYKtRWxJTkKIcroYAfbeYtzHMPVAzoktRLngRlyQTSFYZlDaFrgFimUQcTXPHdmEQLDEmXBtwCzGLdqkMcPyyEOoJttN",
		@"PTHkomDBgL": @"jNDuoAHCurtNiooUfIHMhRGDjXgWvFgjdGNkdBEbdxPAoFqiVgAfAHYEowxrUUipJFPZYWhnxvpOakSoMGqmHcfbamFNefWvZgnwGsiJlpPbxQlpLlAXXkdDqEbzVcJdnfqGwjUGTodhPwivWG",
		@"jRKjtoIQaXbWlYbOZD": @"VtUPXYQXEKxgFfVtCjKufiWdZuEfMmifNwySuLGOxCPKvLiSBOKVTJLJFKicfyTDmceHjMEqHckhVPtnqNLmvtaGiOmEYTFxfpzhqNS",
		@"TBxIpEwEWfWCAgpUEd": @"OXKsVsRvHrMiroASTOvwWskzqbTgGnKpfCnJDyPdgbjVGuPfQAyVuievPBoPwguhMlNXgYRpNEeHbmExLejLTYDHoBLIFudzIvokwBuULE",
		@"HYEburJSZOzoClTGuwA": @"fjifMfIiYCUhVaCMLOwBUlrqBsTRHdvOONKmmlyIMEmWhsumWFLAcTYHShwHmLvmyrQcMAvsGkKxiIVCdwYWMrMhPtoBqabPDIdcuOmnoJvWzpjWGURZPQYDoyaBOQmvBxpDhjPAeyTtbIWDbwLc",
		@"AoEpgKiTRyepGEzkAEh": @"olrEnASvykirzdWVkNVQFHulMpztbHRypQtJXgbfDUaAOqoIGICrLQSIiAUzxXqRjwDhWPswCsYVEEinCzctWXRGkRzMqmFfpPaRoKTpkDBCJZpJh",
		@"rxnrnFgPvnZduYfne": @"ADcGixWqcYniBPaopcAiqxPwbCGQZWPUmpymdNgdFWZqzrWIdADOHJffFNCNTVWwxBsFikGBHWUPdYpIFiaCiDuaUGPXHHlJJEjjYhVvYGYzPsnPrEtyaRA",
		@"RxTtkdalMhLjCJXX": @"fPFqNXfYpcBiMQwDvqyjjIzIpjwUTISkuUTudAIhktWaiiPDrsOqPDonsgpmxpurPYjfGcGMempopAqdIAHXbWfZyrycFXondoATaFmQvxBF",
		@"RzBLAunXSObX": @"RzzsLeytcSTdkgxZPZgkcUYeawIJGkfpnLJTnjcTasGMRoUuFzfXDRgGTcMzFWloJStnNIXuteTDMfBTHMHFHPLTxAHwoEtxFpogMI",
	};
	return SGoESBCPnk;
}

- (nonnull UIImage *)nQdwFbwNVil :(nonnull NSString *)nEyqTQaoXHdrxvgTo {
	NSData *XHhhsIspqcbHdENj = [@"BHAizzJPoEwTWxGrKfxDlmLHFWMaqUuuItivdqnJgPgkFyUkOxFNiDmQXbvWwMabBprLncWaFpMfZYOhpiHcYneqntYAmlijxDHWYzPuWzObTbZMIIxyUG" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *SsQPLmBvud = [UIImage imageWithData:XHhhsIspqcbHdENj];
	SsQPLmBvud = [UIImage imageNamed:@"RovtVzCLdrQvgFCYwxBOyUcjiyhWJTlZVwgNTGIcXSajbFyDQvXwmBRMOzKZMWnAYzVBjvwKZRDERxiCyeNehCTUmBGMtzlROOaKUqCDabXsKhe"];
	return SsQPLmBvud;
}

- (nonnull UIImage *)QidOpMWwpbsJ :(nonnull NSData *)tWJboLdHrJmZv {
	NSData *kSFkrFNlANXyfH = [@"TSwROntsprROusiMMwolSwNbtzitVRkaWleDfZEoPugMpXVkFUElLtdbyGfJGSAgdkMtjIrROHWptwMINAUcBFTJJSCejfRvUGoZgsWlPKtAKDvBcsLNyrMfttdRbJbOAtFtMKrUYl" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *iDtpjOJexgd = [UIImage imageWithData:kSFkrFNlANXyfH];
	iDtpjOJexgd = [UIImage imageNamed:@"RQTXNUgEfUiWxlAiFLHuWezDyCHQEWnBtzmSoMTFLUhDtsgzSQkamXhtwixgoDbZeHmewkQEmEqLuHlGjXgwexNxfzVkOPJLKCYJyTKonCm"];
	return iDtpjOJexgd;
}

+ (nonnull NSString *)cHXnWLGHuLSkx :(nonnull NSArray *)MLHFIqsKsWySx :(nonnull UIImage *)JKQDrlPwTrkapYhhCCf {
	NSString *DaTGAWOrteuK = @"nkgoinCjDVZlEzEtDMMohwsLumYSEPeMeEAIVmUsGgoeDhcDGXieGEhKLVZnMEowtiDZLuhBEYamwyujzIyXSQPTpLhobHfMyLQMLWLvflRDxUYQKpVJAmSyRahbYrAcVhSEBwiKaoKdPpvPjS";
	return DaTGAWOrteuK;
}

+ (nonnull NSDictionary *)teiutaBXPklyGWPOn :(nonnull NSArray *)rVZEAXRnTnWHYch {
	NSDictionary *hJwcyZpxiXWqxgzLpV = @{
		@"PfOSoWyVOGJgSJFVid": @"IOJpQszcaNWFqZFgfpecJVjFASLoLnnIyBpMPFcwHxOmtjhaZXZUYPpNGPMXGreoIeSqKMkmmyZDEUyKqyyuuYdYOCIOibimpapVMGrsCTfNs",
		@"sgUaoZNHlItjIxucOFQ": @"XlMgfuycvxWSCNrGiAVPBYcbEqFqPSavDFvtMHycNKNlOVxWMgCJkxGcmWeQlkTlLYbGnoTPjgIKUhDslWkaInIOcbUqASqCytQeOdRZKkieFjWnHragxzeERhKFRgpkraMdtKTQYgjgiR",
		@"wGuPGxoprNfcAPBWmFw": @"ugVhQksEnvBTrHrnhOZxcEHkAufoHDNHWZOffcoDKiDyUoTfpITvTPiehFXllPTdFBEgoJRGxCOVNucXFSIEzfdfUCRAMfZNoRaLGWAWHgWPGMHqpiFJGaCZzQcgcaDjAeotPMtbxvwIY",
		@"imfAQBegcp": @"aIXRBeaABamJmuKQpcZsnngjIsIdznwERKTsvFFhYbRaHmGnmaJxVHQbnbDNIzGnKvKhnyQoTfRwqEegKLhOPtMeorYSHwBBapIykj",
		@"XjUiwOYKGB": @"JvpLUNsZSIwvFjPCFwAzSrHrwFPyKQMMzYBIKitfLgmMkAFgGfYLrekzFeNWIISCzIfLYYCpfBkmgwVerKwtorGFeuNVGwVCLHmmzxLnyKyVtDXc",
		@"diUeucQyMtwRuaL": @"IVfhisdZJGMYPuhxuTARYUuKtDyrqjjTeWOVNysyACbsLIsijYMxfUjuPoXFPDAzrnmqupqseHawOaVGkPsQKsmNOkRsEujshNTClhqLydeBqOejQwplwgLlVplZGCnRycnVhTvhTJXShHFi",
		@"JWSBWJBZkupioHXhgXD": @"OCrvrRbSgecgRUcPixrYlhBsvbtDqeYdkHpvMjDgUhfAxmDWsJLLxobmcFReLQbzIyiBeAFNEkSZOukdosYfABSRDeFdGeOyKtxDKhGtiInhSBCC",
		@"oydRasrMHQPNhBYUDW": @"zWUmKaaRQUPHXwxmXqNymeCbzncxlEonIqbWHCFfvmqoObpKwrGRTaixCqEXSanxcdPpVAUZlZLQvGCnbgbeEvzJyKUctPqwyMnDyPxIedCbmhdmAGddfnrmyHfPnG",
		@"SMLedihemd": @"bZDPJhpOfgyEzFLDANossnNNFrEuGmYHQcgqkEXAbqvfLPIkAFblZtutIuhmxiTsEOUmYQIgNbsVLEpHkHbJIiQOQcAiKjfCfAbhxOcgsfIFumHe",
		@"ZFekWdFeMZZBZt": @"RTDrVZzLVbBUvQIPPJYsUEtpdwKajvVUAkEvcCWziffLDINojZAnsbrMChswfHcYHTNhbAilXxvSSagohAoEcsYcEdctRqnppjRnWmtxxCSdDiDTFWFgekYONgAwTdvPInfwcMmBKrza",
		@"XTMwTkRTnyvjhgMBUTF": @"OwtKLBNIgaXfEZbINqKSuXNdjRAUigkpLjTTvcOzQxOFXAKWBmHMoOEBzYgROdBIuMCcPyZENXzqRcEwECsYoXgyqiwOpBOnFCDYjAPrFfwFh",
		@"ubpeBZIgDotoPlwCcg": @"IuQgJGoZAVJcBwIcRxvzKaykfnikZctRSDXoVASPOXfqptrmIaCgUEqUYXQJEAzCiFOCHEONIBMktimmluTdQxUDCVMeGRPwGrDN",
		@"dHxXusbkIBJDIZd": @"ONNhKkLikQlQVpGNDpMFtORLhIybZJBoNlUstBcvWXAHVHkvyRJmmlBXRcNYhDtoTesuLdJtHqDacBVuxTKQFvAdQBCMedFLyYIXFgzaWNjOXFrvXvkNFDrqdOfJlSGsDzlA",
		@"GXOPbgbWsnijloMCSBv": @"UjdoAUVUuQbWPiatDnUYKetcqllRfNmjEQGFYiwHesxIgaFDxGafnqNlbtPuAaKofPEOROrURVblAykfItnKzZzvBoyxovPCdBEOUdxXNHBSrgQu",
		@"JHWrFRyShmipiz": @"zBuuCBLubAtrNVNFhUSEZzSkoBrfJNfXurYlevxghcZlDsmlmxSJGcQNYskQvGdbFhWUGamDbgPfJsVlXuNlCBBwwwLldTnURFdMWGCQQOjQTq",
	};
	return hJwcyZpxiXWqxgzLpV;
}

+ (nonnull UIImage *)TtWcXwwbeD :(nonnull NSDictionary *)mhNOSzojgkUCFmTMicZ :(nonnull UIImage *)NyCeSjlLdgYUpzCNSV :(nonnull NSString *)tBpIQzTzgjXpUAXp {
	NSData *bpDzQydzoNdhYrynHA = [@"wAwRDzmVQLAFLnCBccEQcCIbptmdsMWvvWIkqGwxHRAaXZfMdGukfCoxnpTCEUwuHuGAlcisdMzgNbFDLzisvqdaivbXWsWNUiMOUxkEgstVtkPu" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *sgrXEsZQbu = [UIImage imageWithData:bpDzQydzoNdhYrynHA];
	sgrXEsZQbu = [UIImage imageNamed:@"yWuKiJveuiVBFcaqCbYPwkEcZTsXVycQssxRtyLWAjdHcZgSqUsMXrFKEuRRtDFytHbQrsZXVPNWFCrbrkWVPvWmuDFYfYiqnzJaoRQXHtmgPKCYRIbKxtJiClvqycekgGseB"];
	return sgrXEsZQbu;
}

- (nonnull NSString *)kOWwiMRIPMtKNUspd :(nonnull NSString *)dAfLhTEiQtAREBB {
	NSString *QNcaZOtKkpQWwtBNrr = @"CcUeDZJObqOcowljVtAGBnqlHClGiwnqQaiHNWhYMZDOmaYTjKJtLONRrjodsWHZgpGhFWiBLDwgeaLdixjYpkQTOCkpFnFmGjNVMCpCkTprKOhDiJWNntJNScHZhJkWDQxHOyf";
	return QNcaZOtKkpQWwtBNrr;
}

- (nonnull NSData *)cEOCyipsIXAq :(nonnull NSArray *)UEVWoOsJvsycrSc {
	NSData *WlxhdcDWvROFkxf = [@"xFiGaHdnBaYhGhLiOWKwPqImhBCEzjcSpEwPJRsolUXxvAjRlRAbPSKengVTbHzjXnQsBDirYRYElpMMqnoDzAKctzNXJPyKMUxMiptezyePJpHYbnxhZiIhlwEHPrLFA" dataUsingEncoding:NSUTF8StringEncoding];
	return WlxhdcDWvROFkxf;
}

- (nonnull NSString *)DFbjPYTlfTV :(nonnull NSDictionary *)aPxYwfQTxHHVN :(nonnull NSData *)dSxRTWuGzawfkyfeb :(nonnull NSString *)fRfywjYPUImlFk {
	NSString *twRelsSSItFCm = @"bsvcdZmjwtDeYfDNwfnHLATZvjVLHHIUFCGKeDYJzqckEMWJsJnlfBOWWAuBReFfJeKPaGweeCxgRUQXSfqcFdJBqjyPGbkCkgXvLQvjVjBtkMmSkpSVEgaKEGIn";
	return twRelsSSItFCm;
}

+ (nonnull UIImage *)cTkCWzFUgEsWSDHxhv :(nonnull NSDictionary *)rZxcdVHCgiaXRGa {
	NSData *xnrGcgXyEn = [@"qTzzgALcuyORqRflQXymRLajEMctwfyCFcwBBhMuRUwCTCOCCRjHEgFZpnIeYDzpKwAEiZHlJffztULjOqzggExPKgtrkuWLhJSTtNQcdRBeuppEIpDhBHtcysOyKoCeNUXl" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *IQZYYMIKqGjGI = [UIImage imageWithData:xnrGcgXyEn];
	IQZYYMIKqGjGI = [UIImage imageNamed:@"nLOozzNaTczXCrSoobBgnCHSAJtWKprHvPGspGoholtPNdDykVJYYlSrEkmeXCPgaCaSQatcFSXIDbJBVYLpNhvVOADnZnYPVzEXuwIXEY"];
	return IQZYYMIKqGjGI;
}

+ (nonnull NSString *)LbmgavbJNXEwvhU :(nonnull NSData *)CyIctDXeGZRHBm :(nonnull NSArray *)cUoCnOqcViPgusgo :(nonnull NSString *)jnhsJBcDTsvccValpL {
	NSString *XGWHuZUmtGz = @"bCPstWGaQlVHLxSmvzHJlLpfsjiwlNneVYAUKhpLMKSDTTmWXhFXuofLyJxOOlNIYrUHCZjSoyRDEGnXjZVbhSmLSqicQbSufEoVHqDKiGCeltfNFslWNMFYdaBAR";
	return XGWHuZUmtGz;
}

- (nonnull NSArray *)znbXzVBSvPbwuplc :(nonnull NSDictionary *)vwBLiyagQI :(nonnull NSDictionary *)PjMqJNJhkfem :(nonnull NSData *)NsghATxheCZuVNVoM {
	NSArray *ADmCPoWBFh = @[
		@"qIRvfPQtGjfgUqzXztuERPnYUYQwkphgKylZXUXwEqeyFslJZjsnHSZoeUFSSJUKdeNbMYCXfmssYXHdBqxfkcWxyYAyGlbKLWwHIUpjSvLZEzegVkrffUgBprNfdxo",
		@"FVkXJMWinrWePRlatVjnBjvwljUnTUYfBrXJvmGPpQtTCeBXRftTkoljZhZeedpUlMEUndEpquctYMVWfKaMWqWnPdkUnegzDcJmtKadZyLcoRSxHFRe",
		@"MYzzuRAsKQbmutwceYWVFQWLDiBLmygLJWhIjkdoUliTlvMvVRaNupPhcRTQAFgGQKPvwZWTvjpbnZFCIkkoBaHJAlGptYDgjVfvocErLaEBBnTComMYOQSxCDVIjNZhKrQQVKwdLwUYmpdmAT",
		@"jvdYsglwoLxgactGJZYzZZeeTCTtqZDxpVpzXAOybUlyHuZaLWrBqsozqUaUmmxbDpLjZkwGGfFCGKMMBLjnTKuHVlFCypTaPbREsmdJemzTEaflYgOBaXzHsnQwRuZMhz",
		@"jZjEDBhkBSaQzhZuiSWNGyWFppRIdfRUKzcwggEJlrQynFmIWejbyaHKGUNzzHMNMtTFIubNsNSkcqyPABXsYNvvFikrxgOovXtFaAsBXqdaWFpbnjycfMFOgpyXTOpQDaDMsB",
		@"ZKCcNXZrxpQEPNkCjOImkDjgduYtwcvhqOStLhYCKtmXsUhJtqQbCzWHiIsZgJZxJvhyUhyxcbNlxEfnazcCaxnpctAzuKDZHhwwuRIQ",
		@"FGjtTejAbCsHnpDemYRtfCWZGhfbTdXOQdKZJeOaJqTyaaAEfsfaFkxSpzyfllwFBGrqtdImzdJKDKDmFNNBArmrqsGjxrepmsexgU",
		@"xmXLKglDDEULVRiOZZRgTsuUqpSUqjehWOSTJsFWMrKtdGyDAbBSLBXxFYrwSolNlWPOmDMCtaOteKtVbupWkqZzUcaZEOCMBdgnW",
		@"TJoFQnuGowYGKcldQbFiJvxAerxSBTXmBDdDeOqVobOvaPOCNSIqyBuxzCibdYLbIzrYSnRyIeTeDxQCousAfyosvcTEoyYviTJVbpEYxwbtecCJNNIYrTcNRMRaZNxPScyRa",
		@"QUsAYVRgEYnmHmQrNTLeqDFRFtrapTzjWlYrHLglyechPLAwBAjOnGezosiuGOkPtPZLKrqEBSsEllABlzLhxgyxWontNMwuoBiZlK",
		@"orvARGXvftSIXFgOvKMinDBLeRqvgHKLWGmVRBRqihvbaDXrLbSQSfNTxcAozLWSqQNLHLPvniPbZdExBZifouPYWZXrGgiJBaXOmaOTHxMLzTwTcqswvFgIdMAnvhiDsZsXJoYOKYWHyjbDlyxuO",
		@"WSrNkuMWMLdtVHuITwJiWCBtlAbvhvvAGFRJxzCTZTRCJfEgUhWYKImrfdGMvOmIrCOfaXWUpIHJDHbuXWGVgDWSsCzzBMirhQtsiXUfjzIypP",
		@"wtQXHEKXQjNESDwvaqOGhZjdPBJmduPuYcHZCPiRaPQiyIqHwWsHuXuVlCGtXbbZfglMYCADRLuptadlYrzbvuqWYhttLZpYoumjBzZjuduSuwFOACqX",
		@"kKUTBMMJeqEDCpFDGGVjVrDCreeCqUgaUJeHYoqAJgUfpaLXTPyvKZIvBBbGqazabpgfJGPMulfaSIBrCIKOzpfwosRnSGHsAIvZZqKLphClMIDovnBLEnQXZYpVsedywqZicncaS",
		@"znnkbLVgwijzOwllFdprVSKqfpXInqiLtzlHAHxAVgtfbRGTIWUymTMvNAAvntDnDphMAsXtjZIShmgtZzDjypjzCjpPApDcrBnordqBjJuZflSBKCPqjIsnKRYSqLxIIiMhYBqqcnMAr",
		@"hdFZVHweOyLesaVjeunacllKJMfJrmEbFgwsLzGqDJlDnnafyfWovcHLJJgkeYrwXuFHCxgrFeqzLrDQXogkAgLTCBjZQXkDCLJUmRjnfORLsx",
		@"ITHQYddNuzYdZzypdUvhlJiZJMVDJTlrPUaOSGZnndSPLWlTSVHfXAqiDDpybaWDUFVWTRnZreloCAfUvUKdtWFwFazjKglUpSuaXBEkPrSuWqG",
		@"HNDEcHLoBGqEAkraCCaQqxewEXPxuiyaFYXLYmVDLKPfKRHNoTwyjKlWXZZNnoYkCDECyOqvZEjVacNQtyKNZdBwNsNZgidzbDaZhDkTvsoJvgIBQypaYaeZmbYocraztqVaCtesSPn",
	];
	return ADmCPoWBFh;
}

- (nonnull NSString *)xwxKlvuKdqzhAgR :(nonnull NSDictionary *)DwqoGMtLwuYuxbbwL {
	NSString *zuGSGWJHWNc = @"xbNHBgmVXOEarBcQbHIOTxlMVKvvCkmSjjvTSfZYQOeHZTCHVNCateVYlUIZNUmhSMlwrvwwBDgfiKJlNVhzLGnijNFzXOXEIkvQtriQesSxSjmdecJrPyVzYkSEPhmPzmqlQHlxAN";
	return zuGSGWJHWNc;
}

- (nonnull NSData *)xHBhBqdlEOmuj :(nonnull UIImage *)wRbNVySiMiiZRZZ {
	NSData *TfZnkANPkjSIdaOsXm = [@"vcrGvknxGJCLjcMshQAlzGDoYkjlNiFlCAWDIihnKfcUWgPuXzXVfmRrKUoOizuEuLBnoWfvwaNZXjuOfqbCYmNXliKNXxUymHMLxEa" dataUsingEncoding:NSUTF8StringEncoding];
	return TfZnkANPkjSIdaOsXm;
}

- (nonnull NSArray *)xhFtpVHuNJx :(nonnull NSArray *)SbDThaGziJgtyHsr :(nonnull NSDictionary *)NGpHceHipGxE :(nonnull UIImage *)NKRmwkqekGyaYWVU {
	NSArray *qZWDlyqOBfH = @[
		@"eZQuEyLEhVEZILJBBrumkkfdIFRVKUMmUuUOIWeunszmgrSYVNiZRecTmQqTwcUXZZrztocqkBztWDXvKLYbaGlumRKOnPcmJYjVSRAdqmdpvVXGYKQXViqtVwDRKZQCVOSmf",
		@"rvAthIXDzfYKabxXqDROpvUilFXSoEmeseiEVJzFxXCpzxExkpTgobXaADNBXkmeTGbsaWfNKfQnmstMspPutRdTUavnnXDhpjZWBtYgP",
		@"eeVeAEFISysEEpakwCfXUpNRwXOsOgerEmEUKVNoybmCPAHxgmYJiVyWrsLRrGxrsyZdkjemegwJYLJlfMsinhoAPEExetnrvDYgxaqdWdnWFjKIBqqYHLbzLFxYxiKCpAcrEwV",
		@"nbYIWmKnwaycgHokdWarHqDAdXYFrzegKaXKBTukgDSqRWtqdYWwsvBEtyTlMEBiXROdyjMTlMCkSWTaVJZMsYYgUxvQsnfpGwySxaELdoIUojJCDguwFfjSAjpPZUf",
		@"JwKnmyeoZUCbDzaszydiYUBOsIEdpcgwbSUhiTPevVSDbYrJYfMNibAeoBkbKeBhlZtOnZzepUmLsTclJdEtoIjkuElqzwODSoueeJXjTKaUinVvrNbApiJqUuu",
		@"cDiSjrWqVeuJGqXqROjWIONLulwDgJCpnLWZlcnrRAdcmoGIPEbUCHzhgkJjBCyaeTtNOMEHCyprjYmdJjOzNapTVcYJNYrqjKirAeYMcIGnAKXECKFWIePGnZBUM",
		@"emVbkDlDrxThwIonRayJyoXhNGPSLSIsRpMKhzBZNUoqtCRupBERMmHSZcCGdEGIxxEyrAOgtkydcHTzfQxPmpGFQhGzTKKmlzeEsGfMSHSloHsvnGUJR",
		@"cfkCGmlqyAAIcwPbTWwyyOgjKOfdWkpuQxviaQIaNSLJnKTSpgPXskGalWYwnfOLuyFiwqxcKHwhNCblQUZIlNcCFSwrRtjSAwRQObSVRGzPVCvZFKVNtxptIJztBtjwISoNMKaGyCrASOHLKPm",
		@"QuaoxhgnxAsCALPYpJgMINeKUudaHzCmCasavjAfcMTiuhppXaxscticqaRWfuMOOAPOoefNdoBeRkrHgPMuYPZpbCyaNUevxyPyocjNtZoJtZUImdAzfeCwqDpkCpomyVAboqvp",
		@"LiJCSbIXtayFTVqwZtxRJUWgrcRFdYGsXbQlqUtQEbFbezrRmWixHMSthqBYQylkgvxuMeQCcHLRxyjlqhNppBtWKwskYFxNqhrWuXuKNqdkFAPWYXDxYWrjjmyDVriVLtqOVXFjAnKYGDXucjb",
		@"kSbOgRwRKMaXAqbuLiyVdAsKQKzbBWqSIREJDnPhjmhUkfflkZMcetCBRaXeJmJndtEMfduYnrVmEsMIMKqBBabZCAsTdlTfHidGxgGruhYFuMafapKBWGNzYWnWQys",
		@"iNbLZMKgVmsbNhXvTuQsQsMETGuBXFYfOQlvfOLHwgEGVpomkNBcitrqMSmfpNvoLFNofnHgRLingSVRIOyWxVeeyogqxHtAikco",
		@"jUJMTpUgCttTOmgJwjGLjAmoFsxzihxmlfGPsvXqDDjwfaOmSAWfACclWxSrlDOthAouBmQSWallrInhnPBjxhFuUFAWkCQjridYtnAVLGMhvMCuGeQuXLX",
		@"BSldyWXJfbehuVMSusnwExyFQEktfoClQEtBMVapnCXmXpHcgBffIAuBAdQIQynPVKydpwGjMHIVZYhTfgZcPuLCqEGiaCqnJbaonwOyQDRcpbmnxhQLgrBZqKnqTHZvOoUKnHrzHiybWncHMOZD",
		@"VyFbjpqLqmlMFrMGNTNJbCWiCbqCYYkAoYMkodZlQPXqdGqrnOIBGeLBQHCvLoiIFyfvmjyOXgSNdGnLTtwbKHjliuliXeEzPBMfkBoalpydncWJVAKkuJVcWSvumtzXbhcjBXzaTvNLgm",
		@"qaBgcRRfBuPVEnKSRlOdDRYjcKweWobgEihoICooMPKHnHTEkRqccYOkprefrXfrGQuILJdeuGKttjXPFOQmrzjGOKVpGHGWwrTdUTcPbdWaFIcj",
		@"jtFqilBRhkoJqmaKkAwWRXvFnNkbnkBcdQmtLcZToBMSpIVuiTGXfHSJIHHJmkicypjEvHGRDJOMzQBnVAcMQYkRAYmFhFJMgMFnIYKFWCPPMJydjwhqAnl",
		@"ZvHwoAhTDNMEUShxHvzustJaxRQdmcPydTDsdAzDltYOPQwhkgNokLrUVkzbruguTwjfVqoSgtyTqBaEbnTTCmWXdKopDUgGCvNRpiZlPI",
	];
	return qZWDlyqOBfH;
}

- (void)setRedTaskPoint:(int)count
{
    if (count > 0) {
        [self setPoint:1];
    }else
    {
        for (XLButtonBarViewCell *cell in self.buttonBarCellArray) {
            if ([cell.label.text isEqualToString:@"任务"]) {
                [cell.label clearBadge];
            }
        }
    }
}

- (void)setRedNoticePoint:(int)count
{
    if (count > 0) {
        [self setPoint:2];
    }else
    {
        for (XLButtonBarViewCell *cell in self.buttonBarCellArray) {
            if ([cell.label.text isEqualToString:@"通知"]) {
                [cell.label clearBadge];
            }
        }
    }
}

- (void)setRedInteractionPoint:(int)count
{
    if (count > 0) {
        [self setPoint:3];
    }else
    {
        for (XLButtonBarViewCell *cell in self.buttonBarCellArray) {
            if ([cell.label.text isEqualToString:@"互动"]) {
                [cell.label clearBadge];
            }
        }
    }
}

@end
