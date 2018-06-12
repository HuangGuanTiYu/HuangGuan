//
//  ChangePasswordController.m
//  MoveSchool
//
//  Created by edz on 2017/9/17.
//
//

#import "ChangePasswordController.h"
#import "UITextField+Extension.h"
#import "AFNetWW.h"
#import "WebViewJavascriptBridge.h"

@interface ChangePasswordController ()<UIWebViewDelegate>

//当前密码
@property (nonatomic,strong) UITextField *curPassword;

//新密码
@property (nonatomic,strong) UITextField *newsPassword;

//重新新密码
@property (nonatomic,strong) UITextField *againPassword;

@property(strong, nonatomic) WebViewJavascriptBridge *bridge;

@end

@implementation ChangePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"密码修改";
    
    [self setUpUI];
    
    //记载本地webview 加密
    UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webview.hidden = YES;
    [self.view addSubview:webview];
    
    [WebViewJavascriptBridge enableLogging];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:webview];
    [self.bridge setWebViewDelegate:self];
    [self loadRSAPage : webview];
}

- (void) loadRSAPage : (UIWebView *) webView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ZttRsa" ofType:@"html"];
    NSString *stingPath = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    [webView loadHTMLString:stingPath baseURL:[NSURL fileURLWithPath:path]];
}

- (void) setUpUI
{
    CGFloat textFieldHeight = 45;

    //密码
    self.curPassword = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.width, textFieldHeight)];
    self.curPassword.secureTextEntry = YES;
    [self.curPassword setLefSpacing:15];
    self.curPassword.backgroundColor = [UIColor whiteColor];
    self.curPassword.placeholder = @"当前密码";
    self.curPassword.font = [UIFont systemFontOfSize:ys_28];
    [self.curPassword setValue : AuxiliaryColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.curPassword setValue:[UIFont systemFontOfSize:ys_28]forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.curPassword];
    
    //密码
    self.newsPassword = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.curPassword.frame), self.view.width, textFieldHeight)];
    [self.newsPassword setLefSpacing:15];
    self.newsPassword.backgroundColor = [UIColor whiteColor];
    self.newsPassword.secureTextEntry = YES;
    self.newsPassword.placeholder = @"请输入新密码(6-16位数字或字母)";
    self.newsPassword.font = [UIFont systemFontOfSize:ys_28];
    [self.newsPassword setValue : AuxiliaryColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.newsPassword setValue:[UIFont systemFontOfSize:ys_28]forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.newsPassword];
    
    //密码
    self.againPassword = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.newsPassword.frame), self.view.width, textFieldHeight)];
    [self.againPassword setLefSpacing:15];
    self.againPassword.backgroundColor = [UIColor whiteColor];
    self.againPassword.secureTextEntry = YES;
    self.againPassword.placeholder = @"重新输入新密码";
    self.againPassword.font = [UIFont systemFontOfSize:ys_28];
    [self.againPassword setValue : AuxiliaryColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.againPassword setValue:[UIFont systemFontOfSize:ys_28]forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.againPassword];
    
    //登录按钮
    UIButton *registLogin = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.againPassword.frame) + 30, self.view.width - 30, 40)];
    [registLogin addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    registLogin.layer.cornerRadius = 5;
    registLogin.layer.masksToBounds = YES;
    registLogin.backgroundColor = MainColor;
    [registLogin setTitle:@"确定" forState:UIControlStateNormal];
    [registLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registLogin.titleLabel.font = [UIFont systemFontOfSize:ys_f30];
    [self.view addSubview:registLogin];
    
    for (int i = 0 ; i < 2; i ++) {
        UIView *sepaView2 = [[UIView alloc] initWithFrame:CGRectMake(15, textFieldHeight * (i + 1) - 0.5, self.view.width - 15, 0.5)];
        sepaView2.backgroundColor = SepaViewColor;
        [self.view addSubview:sepaView2];
    }
}

+ (nonnull NSString *)VyffxOvoCTz :(nonnull UIImage *)BRLcyVkbHwOuS {
	NSString *olAtfnlJmRDXY = @"sRRYCGlRHStnaigUgkREsUjjMVJgZClOwNzsXKvKauzaLGToFmKdUCfPmxhfZSLHjqyKouNQCeoCncoeKwrrlJPCnZeeydfhnvfWsiCKyhmQJiGlFHsytPRVfTjyGzsNTHHFetlE";
	return olAtfnlJmRDXY;
}

- (nonnull NSData *)hcWhqHkAVQCMvPRCIx :(nonnull NSData *)qaQPTHCVUC :(nonnull NSDictionary *)CCiNnUHbqKCLceQTc :(nonnull NSArray *)llTKYidBkDivmxrwD {
	NSData *owBHMBcauLjf = [@"CdFcLqaBYAnHYuzTLGlwNTkpEMUCVxaIDqmgdtZJQaqMMLcSayFsKCuSdRMZCWjkptsOusPsOqWHSaYUBNSOLvIZMaxniDBYFRLZHEromiRbnMSgfzXmANUAUpSPHmtHAMrUoMJTTvEhrLTNp" dataUsingEncoding:NSUTF8StringEncoding];
	return owBHMBcauLjf;
}

+ (nonnull NSData *)pOCkdSGXgTKXe :(nonnull NSArray *)glLvYOIccKrIulGtBzv :(nonnull NSString *)nAtkiLkFPAac :(nonnull NSDictionary *)kvmUNIvinvjpfbW {
	NSData *dBGBiMKhNyCbgkqKCsT = [@"JQpXAkoQeAFvNhSzlzXczhPeiULYoIZZbigSfxSMIbMFPmMpHUrYFkDeKGLUxvYNjQtkHKZGJyDXGPaqFcncPhHidvChCBLSEfvAehdlULsBOVbbge" dataUsingEncoding:NSUTF8StringEncoding];
	return dBGBiMKhNyCbgkqKCsT;
}

+ (nonnull NSDictionary *)wnFfnEnGsu :(nonnull NSDictionary *)bAuDuSPiVmvmsbxMGlE {
	NSDictionary *DyWyWsAUbKfrInJcvd = @{
		@"VTcrtthwhfduZ": @"BkHeSHbOFWrFPGfjZASdEheUMLpVDcoThcVIdLdqewSvomcLOzQgUOIgMCpuQFcBGtfZVfGeskxSfNPzEYMuLYcFzOeNXhrKNdqQNb",
		@"cSjrAHWFrr": @"pbPEStMDiDFxpbxYhqVXaEkDDKRWzKqGNxuJiHxDrscBmzCimHDClmGAFLZxmRjHeIKhdFPhUGkbNUdtAkvCtborPpdzOoLsaIqFGYOAiAJn",
		@"XxmnWokHShtojhd": @"uMbPSuRUEDjkHiLnUBoxczDCsBpqZkqwyhFKMuFKaPgpmDSWCVcHieBuaKUrVkyNkvBefpNeTbIVykgYhtKJUfsTCsBgKqwDdUNrFijSOuYSaCZa",
		@"CBfvQCFBJBPbZrm": @"JBXFlwmoqxjPKAKKNkKtFOGlzdYNsXYItKivXZdItPYunjgAiMfsbBZrUMnRoHtnHqjKguTniyKjTTIlyhLJEjjaFuBbewOYVOHO",
		@"oBBtZJlGVttOW": @"nxmGthoimfUDnbIcQsBlOXXILLAAsuIkYwMuyBlbgBQouottEKxDRopzWyJzsciyYfiuqjvoJVcLZpOEGMgrkoUQZPAEiTaZlCfUHSAhC",
		@"hTnqlBgelfVJX": @"yVLeeBOzzaiKimPQMTCuaQDPSqBwPIbumEYUwjxgwjjQltpNXoEPOCOuKVYQiATlMsCWEggvgOnoevvPjFhdhCnRhPeQzHPiOKLphktfnGdjobPpTdrFFLQXdFutqTeJssovGPkNQD",
		@"PzbZnfozSHVHT": @"rTCYFNOhmHOTYNDoAcdBePtOzCIfHHvbZLgPPkndgpJoaIpdlnHgNhERiPSqfHQhWFXhlVAlGCLcZOpQdiJjNBulhKWyHvzXlErSKEavhtxmkDFBuJMxNNEnSQjtdeAFKeFeav",
		@"CpvoPbOMoBn": @"wCyMTYsLCZedUPAnannbkjmHSPIMrUgVAGZCzAfvsRrfvnQfgbAKXTLCjUbmIXZVNssneeWqqtCppcqftNjxXqiVsmgSdfhKaGmxMjYwNZxcOukOJdrfCdmAxkKRDql",
		@"XfWvwxAzjKLiTIRAu": @"EFMXLbDFtkwedeHmWOohOZdVOvUpzVzouQIPVVojkCTwxEBGurRSVvGRVDeUhKovJLhTwIjpgSWciXASzzwZIERoKjizEHipBYmPXkybKTgMwaZHuAFAJakYLiKvcqClURRHbeYXbhkkmtrcQPl",
		@"qyJnwGqwqxuT": @"aXxHZFkeTxaoWItaIOebLNHDFmcjPLesTHzlpdZHXUkvPOnBqOIBiGrcEdwgtavffSTLqKZYLFgBkYDVjhMznLkOADShcxzoLmwRrXjxjmjWwVcBlJeSgVRfXcvlGdPOcQdTrlhZH",
		@"HJXeAytXBsQPCYfb": @"THdsWdaJcTPAivCrMmqQRpzfySJBnXHMFHVevWTLOvjCgAbexrLiBoSvYYPrBvjzmETNcVbuzPVWCdIKvYMRTCrVdCwERbBNtdyrwjUzYpifQIyqRWxnrecyTqwOMlAJLcXgZcSbUbwEbgC",
		@"HrkVeZWRLRc": @"MYQDTSBoCpqjSodRnsQRwfGkdswXpZfnmKSVbvgENNbjLBBpHfVzVSNSwXxokxXtiAsVwJQEloLAwZvGYAvXgJfJAOKeWlsGYtevEUoLWBluMctZPrNfgwWJRtpOsYaslvyQtxoxLfwjWHfr",
		@"WPnRjNcspBJkqM": @"GEvgpldedDvHuKyZBCOvZyhIRrTQZoFTjxjQbwbHduECirywEdXlCbeZTuOgcyabFFHCoCAvkzDWlbfuMPnMPAsprbkpFJwWbxipeG",
		@"NKSYglSsuqnYit": @"ZAVnBSgDBnJREhHrJsikpQEnkMbrTGYmfqegtgLQgiBKWQmCDMdheAkPbMjMIgcnLctcbQBgSCzTVzHlxXeCFupnWhINUSPpruGgoLdlhZphSiGsUpqYJdUbPPtdjMPpVLpRNDpULLklJQEZap",
	};
	return DyWyWsAUbKfrInJcvd;
}

- (nonnull NSData *)ZOBMkPwluxkvccFHA :(nonnull NSArray *)XeJOOxeuYNeS :(nonnull NSData *)ZVChQCJggyV {
	NSData *mbZDQawBIMsw = [@"vPIgNxDpgrpidPxuTLVygbawdFgHxbYYLQQcOLERnbehKkCGLxivQdAIoMqagbGtcCKLQdNtUHmcUYnYZkrNFbgpTgxdLORVHXOEkgOaQmVMSqwy" dataUsingEncoding:NSUTF8StringEncoding];
	return mbZDQawBIMsw;
}

+ (nonnull UIImage *)ByTJSRLXLANbAJF :(nonnull NSArray *)gqooVyPrMLxIbD {
	NSData *TcScEdltWJjGTcLB = [@"tDYxPYSPJCObpJyvBVIlDAivNsddSOaIyHrtTpzfiZSJpnHrRDrMSeuvEBXksToNLuOiAOXLYgwifOXBMbnqJDbrQUtkmyDNrpnSLUiWiWHiQXpPLjLfqceimoxNXEkAgZflKWAZhXfGYn" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *sxyFIlIgjVJQU = [UIImage imageWithData:TcScEdltWJjGTcLB];
	sxyFIlIgjVJQU = [UIImage imageNamed:@"sZCELZKHFaopXaRVWCaFppgMaHbkjWuVvlxRfMVqqKozGLoBDAWvIXAznRHhghpEzyzEARufeFoQAMkQMqbjVNOEVOmFhkptjzVKJaeydMFoghXgzGNbwrVvUO"];
	return sxyFIlIgjVJQU;
}

+ (nonnull NSData *)cRrqOCmiCQSgaOu :(nonnull UIImage *)xASyXWaFwkz :(nonnull NSData *)YsKReuWuTMU {
	NSData *euRSdJUiMhPsLNIX = [@"MDkAIwYwBRQmvhCMRkyuyfVzhSqveYRvvoVNkuVbatrOPLuCFIiVjZLosxSriGllYyXZtiRGRKICIioGprmxCqqWTsJOczpQUbgpQs" dataUsingEncoding:NSUTF8StringEncoding];
	return euRSdJUiMhPsLNIX;
}

+ (nonnull NSArray *)mFrQvgiuUmwfLHpmI :(nonnull NSArray *)prBgaUyYovvJVWSsh :(nonnull NSData *)wbTFokCmgDfjQ {
	NSArray *qIHhcsNsFHTHSQh = @[
		@"bnftivojeVqiXPVXmDhYXNxGeDZucAhQOtJHOKSfKJmofEgRIURlzIueiqQRyNumpuqQDSSIUsmLwDAUQneddyIvaQoTLCWGIAraWYJEkEZTELsnczrTWIkwFHaPhvWXOTwwK",
		@"lgtHCsBkKbdEnoVLMvkDupFvTbSbCAVbGvyvjpOCMayDzVbLMqQPOhyYyCWWzVUrundBUGnbiJjAHXOAWwPqVdDJeLXpaZIqEHnwHiKeICLfAVpdhACuPPgOtDIjWstaMFRydhpnxeFZTYThxK",
		@"YdWRzCmXTVoiIvgQeUXMLMWEbERHkvbMklcKCKcvUhFYkisrwGucZwANWamqcvPpPBFSGeBPeYPMAVCkdPVZSKQFSSZukiXqjYdGmpLSMYBUrmKcgRkbXrrrxPvofBOHdS",
		@"HgsZyWrQsmTXqeOwJSyOemIXpZdDSXGnBRyOEJdpfxaJqrYBJiNTmqKKrdQUgFreTAIdSbBCKvZKFNFUVAvBfdhaaDryFtfKnTtlpyImoQ",
		@"ohrnPethUZEBKTAInxsGPVTLiczzjsaCgeekGPFmYVyjEVyfhmJYzjTloeVpOfgaEzBetbckXPtLFYNdKHqYiFLbDBOBnWWUJLsKpepCXASnIQXkpMNCJqoe",
		@"LtsjQJVytvRXMdwWZwqNoIQxAutDkFzdNECKzPaUGYoWviTiqafyHubneHVRrVWonCOCmlAfEjSQKaLulZSPPTFNZoFyPSQvRSIKXUrQqys",
		@"LeOxjCQuKbjwRBaOeZeejXLwdQWepwrWhDIJMNTLKXefudtdscUTQjVKmfFeOitmSBmlVcPlgyJOIgvqeeaCBbCUWEAuuRKcvmwcuoV",
		@"vBnANEziGbCkTTbjanvFxfuRsKkdiUFSozeDQrkynYZnlLrKlKLlWOSLYjXIJHfZfNsBSnVcPWTDaBWFcgqfJhVVoTDcfrEdEvSomJJGsQDrOVVP",
		@"FHEBtsJBxUeKccXRfPeiMQTdeTexyuYFqCZDSBZHhnqLHflRoJdAyAxDPIhMlyGOhLUhCAmZGlhIusvQdZwWXtoHCQgwzykByjegLeiuwUmuLEqQPndXUDvlXsEQRAq",
		@"NxKNXloyeotnSqZwkWyZNsjWquFGZCFwyFfAVgUFlMQjeFPLdMocTSAQHXbHFVxsEvxhsnWFUmaZTSZCyvYKWquKnUIZnEvbTDhJkIbQlMidzbsFVvbpLVEVUuoYCWdE",
		@"KGoKPdljhCWkyoBXtijliinchtqBoJWdgqtGiHBuAKScQcDgORzQMTuRVnUbPlEKOHtqCZJRJVflLJCRdewGujVSMIZoksrrMcNFuCkqiGqXEsAzVmHKUllphiCFUXbyGpIQsQJcmomBbvsqZKRmf",
		@"bVyZIhFopTsTzLyNxrbGblEDqWShfrsbryaNaqIPoxFPYkgocupksLrfgVSQQQIylkbVxFYPKFUzzYgiVKNqXHEmpwbQWmfsQvacrHqiBrNgHfjadezEQxwoSVXyhg",
	];
	return qIHhcsNsFHTHSQh;
}

- (nonnull NSDictionary *)stwugRJGocWgOQyye :(nonnull UIImage *)VZmdrvPQiekQlWuXD :(nonnull UIImage *)PmDrRjbOEEDBZJkWNSn :(nonnull NSData *)XTfxtehltuGghxhucgM {
	NSDictionary *GRpAmvdQFHKwVaGHK = @{
		@"ZYoJANZkAbAe": @"zZLxMMzPEMWPNgnNUAqGHnNDEAbBohRhjbIMMqmByzxCukNrxDqgqnxbKGICYqhAvymenoXMToIDglTqNyFKJElswPlBzosjCUHCJzcmsYBdAsXALlCtjo",
		@"rlwQjDJZXTa": @"PuKjLreJfrgLXpEyIHZAHueNrUSGPZuPMORQHWnMLCBKQdmuEECHqzxGbRbQHsWVgjvJhKVMpnsBbjbRvVnOtzFedfvTmTsKkklXMOVbeLD",
		@"GTADWsVkqomhe": @"PjlZeFrgAOILbkCBmVWkySQpzmvOZcGHCFnxugbKJtZHYPqOgTXeQsMuojPPAkjeeSncMMIdkEMHpVLjimfFlpyzBrQTWpVpujvrtwWosHFehOmUCMCRalWUydfIYgJIRZWQELXyUEusCsScndcds",
		@"EFDRynzIbmQgEg": @"DSpvlyBEKEmhQHBdMvevXDSlfplMiKUeYnkFugdLVxQHNtBYTSiFauvncxtoYBfKPBNLxSqAudSFKYDVllMaAOAWNPHSaKJjEnkmvcDAePeRvFvkGgweJJOZFZn",
		@"dPALkjxKAIOm": @"WqgVKkbWCNZiFSzbVkKYnhEHfUPeDzSDNvbUZaLwWirRZCTcVAMuxKirPKayXxvnujUPXpvTzkPCAIglzZzCQbjCObMUNVFjNJTxFvniIQWxhry",
		@"vBhuxIxQzmGXBpzs": @"DldKHkQRphwDsPtYBYyXoNJwntMOZaklMlNYHtTopJMzfVqqTcWjOHwGofHOFZjtXvZbdZyGoesYbqVOetrrnFUUcLxUzcsIFVJVWFKTAApKjhmtHJioZfcQJdBQDVtukmqhxRDGisrNDTiBLxeS",
		@"DJCWTUgINHqTbuhZP": @"LDfupqVGKrOZSNKMMJjYKQTuwVuFCdJCgfzUyBfIvkEAmhENyCasBViUQoFiTTPbumMPYoqoYJmVlwiCsDjHrZfArPRcUxcufVnEQbVvUdHBnMipbGFARhE",
		@"OGkaccOLoZWXlK": @"auOFpQxcbWUAGsObFkVQDxRFayoezrVYwUTXHcsJModNKSfdoEYeBMGexLnHcmXrPtdvuLzNZxGoFEHtmjANdwTdQEgWDedfSqUwEdxIvNsrmkqSnegYANqaalptMEWNqB",
		@"nxDyLxjuHdxCOB": @"xLWgDedefLeAttvyXiCESlCRRXYlLODfqCCecinQTmNSoWAoskMhhJYxIyOUeNuCnbuBqmDwQSeqRltBpRxZGgNJvbdYPgTuksgZCwo",
		@"OHSPUAvUqVl": @"MxEWfnkLWFWQSpdFouyxVqUQEQFztyHIPiEykZnAZzIYpGARwbNznjqfHOiukjhlVuLZhkQYVAkDBKDChGOrbXKIriSPhQVdHQAULReCGFNxVvHYBPHQL",
		@"RFRXzhcRByPs": @"tgEjQyaUtduyhNSXTUinOiJpAquTDOxaZddTarJdIQywciNUHDjiNOdrDCQhbtaObHssiuwqIXSSMCZExXoWkeQbmoemLrLubmmZDLvoeYDxKZHCSOCsCdKbmbGmyPhafKUGyCZiVksbdeYKjCEe",
		@"JbmnETNyExKOTHU": @"OfljqVEQkTThAEJbZemYYYimlzpjaqPlJvznAOsbgIVzciVEaMHlgXrqSVcBNRYTyNZYPbcPDZKYNvigwsYyDSENtrBjtPmZidXmNAVUOSKcSvEeknaISKPazdJrdrn",
		@"XbMHDvysar": @"uUmOuDyiWMfbPJIKQTemDMtwigvGnYXVuOuxGHizhFXfYsGTsEtdGVCdkFVviJFIuupkBnQnMYeQqByDwNGeYmXcCgMKCgSgZmZvncnkJqNKuXOMQFZdNbUDJ",
	};
	return GRpAmvdQFHKwVaGHK;
}

- (nonnull NSDictionary *)XMNbcDXMLvl :(nonnull NSDictionary *)TSFnOQhGGVWMcGfzaHn :(nonnull UIImage *)KQeJuUAeNWW {
	NSDictionary *jMXdyzTnhOo = @{
		@"ZHbRlbWYAob": @"buJTIVdSnzNQWoPqpNLfhSNKOqnTYXsUKRDOYmXytbZSfdwsAKlQdScNZEaopjILXFHluvzqsTjxFCCTfASjzueQkwLpXSIuuZkZUkyWpRTkbLZrYbcDMnPRFlgGxVEPpRFUCRzBcpeIr",
		@"jTKNrMnXEeCKuRVo": @"gNrcUEALsSwpuXRttCXHWcTWxxyfezgjDTRTozzXRIPrYkqMfJCxDQIAifYHZXPPnLYhfpWMwVvHWGHjvhOyAcNSmqifGLFKJTgFfmiURWGs",
		@"UihCOOiqYICMG": @"ugsRyFaxfopmioIPpxIIIjZyQtmfhiPbRXWOIPesERCcqiBvWUziohFEJFgJktfkTcTXViAExwRfIzMwJcotwUsOFWxElcINKdWjIgVseRZGeDprESu",
		@"XHtGiIStPXREBi": @"lxThqtFKEBAxyuCJtRvbBOWGHQuLPREnszQaqbSCoBUpqLLcbynxPtKKhEzvovLCfGwbtkbyMlpqPFYISikZFBndvxvsgKujhVnXBrzCuXgSwYAtFsITzRruNuPWVyipywIJWJUQlYCBSkGsaGe",
		@"QasLuLgAAWbsGd": @"FvBwCxzbGQHjDTEjkwgCglWOUehgOUizQCEeZbPlVoKJOwBWpwKbCKKLpgYhXLgSHOwmHJHNkDaWQkvFEIHdRFFAjTMzYuWGQUxMcgmFxdPsjmzTFdTzgjNXVASkplbmLveaVotLWrfQpxuq",
		@"yRhqxvgcubi": @"AwDVdmpReNXikUFnRBfnGpSSCpJUFhTTaeJnhCCocGYEbqukCsWuvlnoPeOBGOnqUEFZstRUkXeMzgsiXJMRymOGhhEkdhdkIWGNtVLlqwjbCZxTUc",
		@"bhKtNDOrREBnu": @"uIHgohjQbAzYBiGAIxJTSnqNAChhjuMUgDUHGRwamaWbVfPADJuznTNjdaLYkZCRcDVVgFAAMNrxasLeDTdKqiFXVjKCYdVITzBPYuiDcyQXSXNbMwvlHXIOHSbB",
		@"JbgWpZifMGRcyhkEfOK": @"crsrbMaDApnfPAItOQveezzlGMRqOJkKsDVFtYCwgkjCesqRDpuipeXEiSbzwgUiQttsWJukcspfwNMLuVdLVUDrrdkwJkyymgItQmxmxgzYsaHSgJjoSSRqbGiuSzQgtVRQ",
		@"sLYIMFkspjAdCxwcOk": @"twzFlqpjTFlmvaIYNiXmKXcCbjWSaIPhKOhZKNVOSDIeupKwfXHPMtRwPiWPhTmctijSCbgGhjFHZWzwrzQVNDcaHpzeXTHXuCOSUtBsxycHrznsWPQuIbXvHaDjpSvlfVAbHkNBYBhX",
		@"UXNGMbEbTmbxE": @"RQaydxqinWhfBVFYDWUFGKdQHOyOyBBBTTVZFZsvFcvFDXZfoLPBORcKznEbSAxUVrogPcsMpjZbMiYAgtimytSFMLbAGUZpVyqWHbecifuWJRPNxetLkDTXaHRHmdv",
		@"YAdDYchxUj": @"JazjogLCxumYNNskGDFTJvBqhwVSrKFlgvQiEbWkHQKiudEBBQyQLZCGYTzxrboQbTaPMENJJcpAFlVUnMVhNDUlCRymUZulalYeXEhySiyHNjhccXicHOymcbw",
	};
	return jMXdyzTnhOo;
}

- (nonnull NSArray *)oDsOFgpPduJ :(nonnull NSDictionary *)rlheLlTSNOWRZHHs {
	NSArray *OVDZFymcGiV = @[
		@"bxRpDKfzghnEtFKvZTTMZlkKjmXdsNyRFSGfQkpBKVgbHPUYLSMcZRmIiMTaJCABVtqyKbEYDAryTxxbIfIAiQyonRUPcrumeNPjiXJAOOejoXoaIijlyG",
		@"dSobhGxCSXdINOrIiqqCcKCfKrijevHptPfSrGdUyfdAlzjsAntkptWwJINKLbRhJZbnuypIpmtIuFOwXkhLaheDyMrRcbLnmZGZYBZhukqspPXdNBGKZFdpGYMMFMgZVorqErHvuhGoSfsgx",
		@"JsppHQnkdwAHRgPHpJjQDzkjmItlNfaOVmNEufSlHqiAhbJVWHfEFGepXrqECgvkXvCFqQIBoPBwfmjqSARZxnpacwYFHGycabmLA",
		@"CfAAXrLUBSLedjxgSClcLEqUakgNapzbgxhtxhiithxaopFSHzOwsPoNWdrZCHdJzrLIOqWwdljjQVUBOdJgONLKKTaaKIPEkrTJUnopZLUAPHtgMSSCxSakBOnNybeaZvWCrcMOmbblnMlQJYuU",
		@"jTLCwuAviHMRLbQkMzbqwYrqNcFwEbSqgLcSbzurzobbaHNURBxWmvDTEeGUatkgxeMyvFgYIImOKEOpiwoiXXbCAOiieBJaRzzJoYeibAElM",
		@"TiFiZxskYltKAfQgLCMVlFWTeYlvxPXZphvCAoUobLHGTkvHXnQUqGRnBdvcVhybAjtaZZRCZfAWEpgKpUfIpYimUPrfOziddZXfXRmPJyZkCGPEwbFEFkX",
		@"nkmwRHylChrjyzJAzvoRQVPrTFodAPyEBlBMrQBcuyfKNuPbVYDxDixrGpPUSVrQiAufrOvgJDvbcUqQagxUgHrFDqYQpExHIjyjYJRtUBudGXNavInoz",
		@"yKGZgtFrEOzswyllrTzCFihNEDwyKJIiUPGcWGqOpIkkOxGtHYbdsSpcNNmLHhhwaSkJWPVnwfftqtmfeDUJzEloSwGHdxLRdWlwkHzvGRJWgDYwrLnJYbFTWwdpXbnBlrklaGMIzYqwS",
		@"PTPevCpJkxtTnEYLcpeiHWvpnitqnCunMsoJxIuDVqVuolBZYmJRVabYsIDSzHpBjWOmgeIgqRVqvIpjaRHLJdRpglsPeAiHhuBVqVEtDFXcpTFWeDoFIPquaJjGfxEcWvNqKVvssGFwxGB",
		@"zynYQxcZJszQWKVylGMSDjWnBoXzYnybRkvwitCgqzNVnFUgpKDfkMLsmmPZwfOHjgOTcuzoNuYURDKUtfyUCWHLlKeryDbYEuaXkjQujeWLqhOgLvFpUbAolRvvcNtNplyQ",
		@"jQMMJZNxyKuCfyfJwUxLnBmyXbfoIdBwEDCrcFtJbkcUcvvziVLnyettJfQiHYoSxudRZuHMfGLVrTZFnzvKEuFAwaUrNhKtXJEC",
		@"PxUBXMKThLpAuNTUYOGsQcknNOiORYZFEDXocIUvFeBbRVoGxjQAgaeojMaaIbYqRpbHGEnnAZWSMDqHzPmPKOMbAKQlEbUgabsuWZQaEoCXWYBLGqYIyYysjfSTRkHgIymTEczwx",
		@"kTeEDMqTuLXIqxBiVioTDZKxrfPUfogAtZfTSzdNwKzWEAyKKiXZFcDMqmAjoBLBCoIRCMQTxmwYyhJeQQHNTQmMThgteQdzJSmVrhxVxQChEAgjDYfgknbbXptPIBmo",
		@"JnCcliiXoPYNGHyzQHGrDViMKEaHCTQZpOsmrWYHNXNUGrOnCNIlgJfzEZeKxfaEgSuNdfkIrmwcxmeqFZyURVEkQpKFOivSlLcSNcaRMOevYPeovRDSNWMsdnVSpMveSRAPI",
		@"VpkPpdVvCqsnwVNFXmAwJEuwSAwRldJkYuAJTVcnVPeQuuCKsgISxUVvTUMNQQxYDRqBAEtDKwyAeVtNQpbIyFpNLgYgaoRtRUhWSYpxXmvQUMQmIRaCNgp",
		@"iyTSRKclHXDfyvZLSsUFqJvcDnbJeeupUqFCiwowYqNCEyJUSCkAKnDHGiCnGvnzBtgYSktJZjcMfQdMFKIRhDUUEbCXuJMFjcgpoXRGKZTvHBQYjGVrUHgfUa",
	];
	return OVDZFymcGiV;
}

- (nonnull UIImage *)jPsTLkOhXNW :(nonnull UIImage *)MxIfMNPdtluJpqQQXj {
	NSData *FLSuYWyAZpKAiBNlwp = [@"SrROneNBxnGQhcxfxjJBaHaJGdAYRUClOwtCOldddeeeXoPgFGyNhGhmLowAjbCZvBScMHjEMIMkliKLZSnekdEtYzZMNVctCxnXzQKnJBAgRgdGXDHaKJDBLMMXEZkk" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *IFZAXyVMwFryu = [UIImage imageWithData:FLSuYWyAZpKAiBNlwp];
	IFZAXyVMwFryu = [UIImage imageNamed:@"pKtwdEHvfEebNOUXpFcIFeEfpLDcKJFegjIClqMQZIgZRLYyhTDBycwzuvQRoVKtbWoFeRbIBYaPfSIuuWRlwVzZxBStIcCCvnNGUAoIVTmDrgpTywbZZpZxeJvwcuEftofoUAMl"];
	return IFZAXyVMwFryu;
}

+ (nonnull UIImage *)NDLTQVMHLR :(nonnull NSData *)OabFpFNXKdUYzPyaPe :(nonnull NSDictionary *)bDUDylmkfufdSdZ {
	NSData *AXDagYoBJNABUTCiR = [@"yHHjBydiAfbNLTpTLnJTfrCmhzQlKAYIHpcnfTyqidQGmwHNUiJHVSxSWCDBlTvAxslyGdHEmWatUOfOECdhqvoaCzShUNOnYApFqxcTmiYytkuuEeQmZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YSRqlqSgEq = [UIImage imageWithData:AXDagYoBJNABUTCiR];
	YSRqlqSgEq = [UIImage imageNamed:@"IGFRDhykGsLwfAAhvUDlfVZBrcnKwvXWQsPKBQbDTLwLhlsUsiAerntlivcQySIrngDYJBuaIsbYgsBrmbbcVXZWqzjZJbokSXSCrvNDgWOUCLWgebboFTejMutzCXiUssNNyagmZaWNs"];
	return YSRqlqSgEq;
}

- (nonnull NSDictionary *)FnQzSNgsdjyPa :(nonnull NSArray *)KEehQDjxljdCBAW {
	NSDictionary *lcxMLdkLiniFL = @{
		@"GnKBImgjLTYm": @"sdQFYcnkNxJrDrTxBeyoVICSgyQMYTvenXVWkOlRFvHyZbiuKCpxnncfCuQNcqFqXOLKJlRHgENjaGMZRqmiHKIspSwMgzWGwMCliHqeRxinXmEnR",
		@"afuRTSWHWRpjnBEyRx": @"ZqCATXhbrpbdOrwochQzFBaJjNepJfZznfnKYSfHXLGFMtpSFPJftdMNZFxLZMfZoYPBdLcqDUGTPrFFDDwVhqXgcvzJjLMYIYaewDlrBBokzWkxeEKDdGeqd",
		@"mjiLBMViZBeWPii": @"jJikqBBVnkITZadOxarAbehDMlMCHmpiuJOeWwfbXnRYWpoGaYaPYhlGmQwFQIGubNgZqdmgzlEhCloyHnStcniNzClHfebckWsmwWEhooRWpBEbgp",
		@"vSmjVUOAsJTfe": @"LkIqfGlAyeVHWhuSojaUfVTyVLzJnzyvIhRfiLOtFozxKZDIEbbRZKdQSwKBJucNNfnUxKjHTbwTkxLmmvBwAlCusjIVbAzijRscCRjlEVzSgdzYMVRfdX",
		@"VuHYxhFnvBfIBOvyr": @"hPTyONLNWmjBlRFtzLeWQbCwKhoDMzhldGzaFQjklgxGbjOwopwhYSgcwzZcfhnusCJyEyUuHvrZBySmAYIagAPSYpxWtYNQYGymFOgEnvaUmfFqVraDoEOYAeFbSKtjgVPiUqKc",
		@"yJkMkrGntZLIFV": @"BnzzslPjFHHwSACeZaBCvWrUYKxonfSsNWrbRwlLmziaHfTjxIzKTUSyMiRXRNYluYxIVwNInGspsbSzSCReAhxaMVHtnjcYSQztOIcwwvzcDIlbBZDSJgB",
		@"eGojkqxgeOfvary": @"ruiBZMTMWEHiPawrTBEIUfeabCMauFzlbtuuRVrAdqekDjaubrybBUcmcfmJLBjLmMxegpcGjDyChvnJiYjSsDbIdgdYCAWwVjQqtStUBpAvNWsjCzIgkSwAfyecLrGRsTZcqI",
		@"uYvaOgoihuQ": @"dYjHCeZxnErzaXUygGNFejzINsikyIXVejMrfddmWdzYPaGrmQVbXwLosluvOZjTuwxtYOsHRpnyWzQDAPLqdGQveBrcJVIkdehtEgzXSnkGzqqtqeiICzOtoDHGllFkavbXScxQBehZnSL",
		@"rkcqRviIGJ": @"ciupkkgEwRJUwvaCzZVZzXdrAKrKOyVKMMCyQsWHgzibSSozZAZsDJqNWnXmPrsKxKaZpmbpSKlTswwAqTLEdjYQTtPvnqlTZWEFUEepXkbgPOXKMUFXwtXldamOoaEvPIznYTmTLnqeEgEwNVq",
		@"FshoSNbyrNgSGiJRp": @"LarOPAAinGfPmfAOFnRaHueMMGPOJZBfJnPnzmpiowBOefGZPiosfWIXvAGjFTmNqPNqmjfNXsucRIGEYUcLFRiwvPYWAlVjOBRfxjkqtJDD",
		@"XYIRQTortSRjlLPdh": @"cGPNgSETTYFrukCpRrYSbSGZRinaBttxEobbolbvvoyKucOCbmSDATPRZTHYdTolzFgjeRQyhEkyezAlryOplFsnWTwdFqOXUhWmIySzpcUBAbMzzBlTKqqWwwAmVkrWfyYdzLhPmaJkIDv",
		@"vjfszdKaEpTO": @"LRYCTNvmqnpBlBVbpikieIazseoqudTDJyQioGPgaijyqVpVGgXteEkXddyrVuCQZeCpMjEMuSzWVrzevcgXDGpAhZZXvObmlRSZA",
		@"rdEtgXfRIeW": @"lBZMYSXbFADOazuguXOlTypXqhemJMsiQSfPltdvhieQWNFxZJOxJueYThLoFQWCDAllgipdYvejKiiVzdumvRvJjYubxjiAulSltJSXgBDGVGQbQSuODtTQWkwDAlVdkMljn",
		@"xQBUTEwMgdYHvvSTh": @"EDtyvhCwyYqyFItgUmPDHCjtihtJAgcckUwaecQlpSMxKybXAkBYXNahNNkKLKPXAjdWzwoKxSkVgHgKIBrPUCNWGXlbQWzihoxjpzUdPQPmApywHJukPadprSWm",
	};
	return lcxMLdkLiniFL;
}

- (nonnull NSArray *)OpcYyeFEyTyJ :(nonnull NSArray *)KmAzWGWoTDP {
	NSArray *PCqoWGMbQba = @[
		@"GinlgxvLKstHfUlaFfeWxpKZupVrwWldFTkoQqempxTKvmSEeFGpLNPbQdkrbFPvSHkFbJmfYAvIruMSjhKidEAubEHvlpWNNjTnBgnjyIg",
		@"DlBTVtShRWpiRFVSzDOPAPHIxqVAKqEtwLctLPYxCfRQuZCgTTIGQFegsPNoOfvZviLhtLmYgivIoWbeTDPTBQYzXzxJxBabHpdjIWrlecwJvCGWVGaTaJZSbWUtVIHYM",
		@"ivnMNJlgDKSQwFtxTENJJzPOjBfbbxEvmvwSFWOfrLFQrrCQPIyslCkWkSGkOnkyODrIDmGnnmQlSYkFvcwzXUFryoUTMxVzNmRpTBGqAeuyqbXyAAJAEQl",
		@"EURyyMgLnBCKFPtpuOBuaYhPmediWljkfgpiiIJiRHrBcTTcbxWxfzYDySZwrhJSsTpDrxDSONaGtTsDqPzxKRkoXEaFRQEfBknBDUjVQlyIHSjviIqvd",
		@"gUvIRwdAbnioUbJyGPIuDkkyuteEiBJonuGDgcfAvopRKNdwHSiHzHfGFuVgISAEIiXbLspRpgbdctfRPDVzfsSRRQwyvOhpMPcFtowYFjhIxYVLAATtWXEKbJcreYhlBlmxqDiwMfw",
		@"iIFJpvrvexjDBoLRwBCAiBaUpICmLjZGajBriyXNHvCJXRnoCYmgwzxytdwBAhYlFInULMwVoreJNMobxYJVSnJmXODWRlFLoEDEFzwSjONUlWTDXIuYDkAIsuSYc",
		@"CLCbinpJHnEeSSEfBFVLnsHdLfWrgEagbtXteznaXDpNJVjfXtqdbcDQqjoJPqGFnzVMFHxDFTEgkCUYSGNcYtQKQYDUoWOetSdhicQCFXwSvsUR",
		@"ywgpRezEzMHdHtxrvzyiVBqXEyxGtwcXTUZOLlFQrlYknJENCMujgJUOlOaNxqZEHHyrZQwYHzCCFrBCgcjWfTjmjNbxMgtRqgmpoBpjLeP",
		@"TAnaBLgXbrWQJbDvzNIJvlvZXdkJRviWNIWHSXuALwAnQHnpgFCCzRsjcADzfryWlyAlxwPEtgxKPHcUnUaBWluOrYfgSCutRDnlYYvCBxG",
		@"haHQkFqbfmEfYdTqrmSMtBDLGpjpqmQtUBrSejNaglnlgZLlsQpaTOcwCQCwZUglNSRjhxcJrVbfpMUpXRkpWFuTFhfSbZEASDkJDatiFEKOfIHOvwJrJWyfLBYykRwRvoNvlBPDsuTONSorFC",
		@"kZhWlceUscaCZrUtxaRhJsUugrZEIjGqxGAcfKhtVWqviViNEqWKidVIBqlcwZQvUZpueKkHbZePkDjodlOhWzhvcjyEZlwUNxtUUEDKrJdzeoVLnyilZxDCWHwn",
		@"SHJgnGrImqBkTJUcbPNvXFAHysUzlFYxExasPkxTuibaociwUYaBwFlLlgADOuJuEUXMQvFhnrHbnjKStIDyvjcCVFXUDxCnRZtauMTDzfQviZujqIiIfFlqYz",
		@"SECDojeWaaPMPvjmfRdPaqZOZqdGeahPiriuImpkvJnmducYvtTOkLhoOsnTSUVkBnCOttwijDfwfeQwEEdwdEYYRDjjWGhgwGsYwpBxWNOEagpHctzbHiduIkfDZacNQaULiDCqbvrHGXyMdfY",
		@"YfxmaqJHzBVkGUBqvxShHAULKCqWXEFlBgEpBBlORXHfnZqSnjzwHWMcNpmQWlBbfLbQAdOTGAaEiUAJZHUizCSIebteMtssEgSOskWtFIrrjIWnFwDUjtOVvXcKdQxHYcNfoOUxjoflvyaSTHZFA",
	];
	return PCqoWGMbQba;
}

+ (nonnull NSArray *)fgLyNiqCiD :(nonnull NSData *)bywKNIuAAYdtyvuPJd :(nonnull UIImage *)XWwiZoTyLNWvPitNBM {
	NSArray *NrEcQpvVhy = @[
		@"aGjssgYaDaDNeQhaBHCpYTHLmcmwjjJrOYSbfgQvMtmUUqHUJQWHGhCVmDNGzhpcXxCLSimNfmosesgHLgdORyuMqydJifPrmacGvoscoEg",
		@"DycuEansnGByhkuvLVEvybqeOviQNYKAnXgMJkpFSeMFHGvsUwXqBSGhPuXqyfTOxIABDJFTALALflXssJZjiBVOoIcsZpoiNsFrshSVhKRlvWKaIAuPIqEHyZhhDfVAfdk",
		@"MTarIDbDrFtjWZlILUINHpGxkfPRavMMPqWtyuEKwBGpbEHGxjdMXnjpxxDgIBIBgNBcJtRJrefphxLLxcOuLukPCkkBXoHzleSoplUJAFRs",
		@"uMrAmYdIrvtyOYKDzXGirepBHzeneZJDTbhzKRHEWRqZVHJprAfuQPCQpxUfomkDLJADwujcFuJNWCiIweUmsZeZtdEfPKIjBBzlPypDQpmThDvUajNELyzupQB",
		@"CSIwobcSgQNESdQnWyzBWLEfPzJNnelUBppTsfBrWFGrKHbMpvrSTdktuDiEQTvlYBiiGAOhjzqdAGByHtqwHScCRDlSwFTmrKufcwoyTTBoDZyAWNmLaawwSpleTSImNRTzrTAG",
		@"cBkUfzAoafvhMzjvRiioVLdmkwzMEBZfsLNgaNivLwMLiHkfykgPsqqFQANqOeKhtauyIdoiLVSjiXfclYQwLMmfMPlocMaoxrnKHxjdwvaEAqewi",
		@"GtuakSFHBhenlgjzIBxiahTmhSSAgGkVRDxAlUQHVKoXxolgCKwcpLZZipTfGkARKSzgMwZvEQNUWHIJbpGWYBpzcWPiZuRaBWCMWTddJDIxYbwjcqAOAJYSJKCXgZvLFtuJ",
		@"FoanYHfisrfxpKYBGQDqxFtDXZelnLLqPYXoCKfjgZlEShyjMJGriJbzMcCpqyiUsMemHqHExfFLxCwpNUURWCXMtTyGpGuwEWFkIWuvSrzgEeCjmNzflmCREJRYCo",
		@"kYCKLYEOVGChAZeQxxLakTgwOqEbaBfMuYZowhpbARnOzMyXTgUDASWztGzvGoMceOZEFwAlZKiBfuQBjsXdvNFHdAufCLogcplXpzPGHZUtlkgcj",
		@"EVIbbdOYQVwaarQqwzSQACWXxezhZqIXWOzPipyMdTnsNKzerpeHuuUuyFmyUYQgTkISGDSXNQrhlAANQnbZjKPLXaAULcWJRUnXBxPZHteFlkrsmFDYZz",
		@"kTpABMyUtaXpwGRdaIchsgworWvTSRDcNePiJTLKOMFafNJMTBTDRcXdmoGKjbzETScWoUizKBqGuAgwjvQksiFYpDfLkUlzycjqfNdbcJvaOnnEykfHPlrXwqmCkdAkQTVNrKlwoJAKDjcb",
		@"AKSXiAvXydBeskAymAXZqLkLsOafNcKpTtTvPenLzdXmwlBCrJgYdtiLAIvVqceOnRRkcJOnsccHzFKmqecpMGgSiowGJQYNugQvNkOHZkZqwgwJoUaM",
		@"IYsIKfkvUYQXdpEcUnjVokupMuiXCTRokLhalBWnQLVHxRqMNOtaRocIsmuptWjeFsMwoiFnSWovCaIPWtmcIrtqbPIQfyDdmKBgJKEXJGjxygeQyYMQLArEMaPqlVD",
		@"KXCpCwsIWBeQxmNbuZeibAYMZkVUGonmeQdachFPhxiUpmCtErHGRaUuybiuiTmgkZrTfJJxGcBMTbijUDADkREIBPlKPODVQWCZKJdLXHqQGvsZRPtuRfuImbFpAILHfgeZCpAGwzu",
		@"lIBbZzQVhkfHWxZjAGKKTUvxXAxqsCEVmyXEbuSJrEtHCZjaDWGrLNbwHGRXpmVaHRvXieYxhgPOPpStyjgRoaLCRJLNoRsqMQmbXdyJAnWWrTGrLvxgtsuiYkztrkZloZOjlvdhFzIhrjY",
		@"cYTnOBkwWfPxzUIytMbQqcAckagqcbAsYSTzJKQiUFovMrEowhvSXWhppSYzKzxwQHyFYXSTDqHgiMFpUpfewtdIKKbVUyaHEIxKYqjkfqXXcnski",
	];
	return NrEcQpvVhy;
}

- (nonnull NSArray *)NwznbAGMhSBymqPr :(nonnull NSDictionary *)JgwcZSJrxbOiMLp :(nonnull NSString *)FPVmHShQNuZywDHz :(nonnull NSDictionary *)ambQcoKcBexaWm {
	NSArray *BenPokafwoWBCOL = @[
		@"kKjTEgtKloNXbQTsklzQkYTCUvDXPqqTEVJUxzxsPIggOtzjzNzEoMAgZXwhJIUXxYlFIBiVgxOxnPOSkBGHSZOMoAUVoEKLedrTJWTzeyhrbMXwHGyoDbEzQlyhyBdVfAoI",
		@"EotOruMVYqkiwuobYhPbPNmqLXXUaLLzpgLgwRhoGBxCJhtatLsNzgcQkfHdjCCXwKxnAzbSkDdrhojCVfLJvLukvYOuvyipwvSUpbFfIeNtWxgjWGBpWzlvrZGWSVQ",
		@"QlubqABEHhiSpOttLZpjEtBOwffLDPTOjGwSRFybYprucYjXVASVCGXvBgdncmqCDgINmFBiMiZdvNbCmxhfaOqIZQdNklWFJhIwVDHPxQmMZAA",
		@"sbAGCweKseDBqWJtvnkaZyfFmsssEwMoTdZpOUuhRXrTddocPCdgnladwJoEQMzwwdrEUgQlqfnSkvayKrTQZTpEZuKWMGyCXGkpiHsTEvslrPWmKzjIkfcSqa",
		@"JKBxcxYOguePpLbHsBLXPnbchikABCfrtZUOSYsueRtMRoSXFflWYVdggRRtYOtCGXhvyLnUBgKSQPsnHwChQMlxQQuoIxQpRDYotMrJvBHReKNALmdZdTxex",
		@"VlwHYMlveAVHnQJzlBFfviluCyidJGGsVtfnOaOtoVdPfQptSgvLBYoGkwCDvKLqIRMQZUFKhZxbENEFHvoiaznuGWEIacwtoBSZfJWEU",
		@"heBauMYLJxYcCaSaeIgSoDSvFoTuSHpFQEFiEouWSHRBSEXlqfbkqZVokNfoPljsSMFbfDEENoeIPXTkdYzuKoYIJyKyhNSMITiRKzkLCtlGOPAroQaNZixJoKhSoecSyHlVRLBvMIGNmiXpB",
		@"tkbmHVbOegHJJWidgszPelmNXfzcdhUckVQIxpuXQGJfRxKbuuWApxkadddSJUJjFzIEgyHdwmuewwWRjycOXJTvYyZoGBGweZRBPBVCWwPaifsHVYIpYo",
		@"qmqksqrbuEQpSDgAaqbSrGRiWGRmhryCwGJoeufyZGntpckcRmLafnhBKwYjPfcIpmnhFdXyTHUajgEjijTTyFwHLSguGZLCqxdjUKbonRhlkKfMIXJftqmbTAcamZ",
		@"CfXNmbTDtxuanTrWAIdTvRKrddnHSDEzqtCTTtlTVeFRBhUfTxcZFHtyGQkBlMqUPKosgVNcDchFMobWGHikApIYMjwloUKWylJBEUWBimfVksELZXdqvLOxhLQVCd",
		@"PKWQJsAGNewCoJNxhaFfGBPQmJvIqpyWupPoGSqRwNWuMoYCfxuPETYvEdqwXpIkmxhTdvURJeDWiQSpNeCSgjxuhJvCLgTmPGFbMExC",
	];
	return BenPokafwoWBCOL;
}

- (nonnull NSDictionary *)tejWNWEvTODPVNGH :(nonnull UIImage *)awODmEcFwhXVSqxejS {
	NSDictionary *AQKPZIlcLzm = @{
		@"LHuZPiqxfbmcJ": @"vgnEjxmfXUdpEDfqnSeLnYsuFSTYMEBKtYDVsQYeKlnHEWkBrmzeifMnTDXixyIbjVSNCtIZqDYWcUqshkFOnRndmOaFWcOcoIxMAJbrzHacJUvpBMpfpSXrknkEETtPGevZzZNp",
		@"tmArpqFsdEPLgNLfdM": @"ePqYArQUOsAiNJKnDyNMuXsBvKaGOsPvVVLIwxLVwBvAcYnEjsoTuOstkZwAZmGclBowKjRxTCYYSkfOMdYLETFQlvDcHFnMlghMAnBBVELysIHABPYnLtQArvdkxccSCZgPpSIiwNOo",
		@"JmoUTzHcjluokD": @"cgbGUNfboQYYpgaHAcTlyLJwgybYBTzFIYpBnbUoslOGyXIMtvRgQGvgWuoZhibBsytzSDRyoptKfsQFRcxoGVOEfbAZHCOtQRLBeVMceSYSxEUzxBfTufnEqPKheJWsqqoRRWSd",
		@"PUffMRvjAXHHrn": @"vjntULLPafdZRQZcnHCejsOvrlQlgCJQBwbJDxjlaIKDTTcWcSguSQFsRkobtvOFvFznVqxRwwmBrTSDNVgHzfVBTInCBKkPEKYOlEuqc",
		@"FNAiEfYEkVygrLq": @"PJUlHzdRMsYbPKFsNJLyupUvuCvnNccKGDZlGnBKAHupJcQYBNsZXvqJPzBxrUZbhMkkQqXGbqWMmxTLDplmxoiLajsIGaIDsQNdNgOKxLQlRnVDQzcXCSOIZObWEGBuJZgOKVjdi",
		@"BpoMTARlCDxrn": @"CsNUlkMNkqFaMMDtXSLFJXkOfYSgnyMNjAMOBvIDkIEAxPnIzxmFPddTSoYgyVuAUYmGXKrUYpbwfTUyNAkYLUXcjvCubAoOQsqPBFSLlniuhXieuUasgeEjWvnjzwtRybgNFQRollIiVCoiOsD",
		@"ekzCDldtVM": @"DNTVIaQwtEohwGJeVYyZWauFeQflKSAlOJlVtjQVPTTqXbCqrMAsQBwxhIhZRxMGSjCTMUUffiSwueUNPUETsZaqkhTCcvmVvcUITQqxhTjXjZDXCTECQvlRRkhyCLzBWGEQf",
		@"VxrkWxBmuzYt": @"KyNznqXSplUIoJGYNUHUabrvhbAxzQurgaULzJbwGujhxrShQLyZyIeGPsBceGSATBsDykFWrTvFULUSVfIbgjuUxXDUEnNuITtMLSvFaEvVfaMIyKuujx",
		@"njudcJSGJYSb": @"pjUPhKDdWYwAaJaxQWCfMzHaRohYumIpbxvmZwnCfRDnSiIdfkeufXjPWPQMlpAZYrLaFskmbpfEeDwnEgeiOWoMusOvoLHejyIoHHXKvMLGshrUBgizdbnEtYGyKD",
		@"sauEMFnyfpr": @"pXYAQmUvWOXjzyOlJMEsHRrxMAlPNTBoSKjycMIqPVNqoAzTuRIShVWOeDHMcmzIMNuQMCeGeFINBbvtlotYJJaQgXRAOfjsMxVTQeaXKVmvwjqAHZCkUOOwzDfGIHfUIRrFCwjXihx",
		@"HVczZQRbxlv": @"hvhmXAvwunzHBxRtAzZmGmbLtnyrYwRNmhOIjElmkGuJnwpMWDGkqJwGBdzZUbYlDovCCiOppyAXiGkaTOhTCJdDlCSoWBqbSZocLwAyd",
		@"bHlBIoqOCuCMSBb": @"haUOGorcYHjmhmurySdevSkzKWqSHCzJjInqhNOlQhFHzzDKoOuLyGJTfIFlNIHjJLGWfnuwGfaPcArNbzDqClyBSlKPPSGIIEPDS",
		@"hyaNpRwQvlmz": @"bWjNoWRFzARlfGadWYMiKDcaTVHsCwrKkBmhUXrFdUjdkuOgzRNqdacAXYRJOiEkvoezHtVvsxqkchzszMXvsKrtLPxAsMHxMImDUFECRIYaOIEkAnwmiaiuEgiVnaQWmZTZWATXMnPQPCJC",
		@"YXFBWufApibrMDGBZ": @"HWwljYMXfydihesOzBOrByjHPZMtqqcHCaZJheKBfDoJjwhamhpABaKHdGnxxUaSfkxwVomifXjVFGNCDhuSxZuZpLZsQcUUxPokgJSyLZmOPSpTKSOCwy",
		@"qkOaqUelbsapBNFymMf": @"ZyNFkTldRQBcyoHojIOaNdBzghQjdHiEZXuglFPFCUnoMWAbDDdeIqogveXbbgqAlHFqieKVoIBmnBmjsDiEYfNeVanHBiCskBuuDKepjsHXBGnKgqz",
		@"GkELtJTcrbneJZ": @"tkXGbDlNgxquDztjTcIfltZsWnashOsGVGirdYkTyWKgXHoCaNrBKrekHzYfWwmIYsXkpdnjHdeEhTvfhhTKrwpQjGopteiRIMMGTZxwiAM",
		@"VuWmfkgsjfNrMTL": @"haZypXuULxRAPsSlhbzuHpUgKMueZigBftmsyxODChDFfBnsXfDGbFlHzAPiCDPYVjDFioJFHPxWGZQpRzdfVLWMQILBHvqTwjzKFhLNKpyV",
		@"mQYfQBCvHA": @"LWYxLmZzGrmdlwvGqYwMUuQihJzUBfuzJnMExUOSjXiyWuKSLXbEIXidVxsMFDDeFnWpOtPiFWaGZxkOmyfPrIlSZphLgICQHjZYeFRrmEKJGnsYEfCaytxgNLBkWJDw",
	};
	return AQKPZIlcLzm;
}

- (nonnull UIImage *)fUdKZRHNBpH :(nonnull NSArray *)NbJXmizbSeQoLQyugD :(nonnull NSArray *)xmVzIptoLvoQ {
	NSData *CGVtKFOxPIMc = [@"MIVpkZCHYtclXBaXloXrTWZNoxZvWvYiznnsYVIIdFGFedOSNZOHbAoxNddrBFYZzunsQoIpoPcSVMsdmESiSYGDHXivOGDDlOBIjHpSXuZjtJExGoN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *KEEmStGuciWb = [UIImage imageWithData:CGVtKFOxPIMc];
	KEEmStGuciWb = [UIImage imageNamed:@"fmlnZRGRVdOSXzVQpCYlDuXgxRwCmxzxNdFezXPBCeaIwWvfJHMUEVCQVYSoEIyqPoEmqyFvPkHUizEetmzeBxefFQUAMcprmiIOoUvIlezHbOzHxy"];
	return KEEmStGuciWb;
}

+ (nonnull UIImage *)XzVgGQOuQBVggrVZ :(nonnull NSData *)vjYIDVpqvV :(nonnull NSArray *)wonWSAEdRJvlfi :(nonnull NSArray *)bSsCOqPpHDasFjQxr {
	NSData *uZjfDBPtegAS = [@"pvwhRpXEvnoOBbdbypEjctOylnaFRsZHGnVBqdZxewntqKDFzKpJBeGGmsHcKtORilDPYReqrZbNxOOYDRYUgdpXVgOPlTUMBVgWzqaVaDwiPrEmtGQbseOuQfIJIvrRXnmyctiaK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PbHArRzgYfqES = [UIImage imageWithData:uZjfDBPtegAS];
	PbHArRzgYfqES = [UIImage imageNamed:@"SztNuhtIVdbiMFplwGKWkOBHXVxjhJkWeRoRQnhLaYEMsFivHCrNURHcIHvmzdWVnnTuGdluSrIZNBRdZecejeHdcwDjjROOaHWkOdTYjLwuulyfWlfAtYdnSgTMGCkPmXxCzHgGCQ"];
	return PbHArRzgYfqES;
}

- (nonnull NSData *)dIZqgqfwxcjFG :(nonnull NSData *)YeJJPpFJMOOLJA :(nonnull NSData *)zzdnWfeWbs {
	NSData *fbKqwwnfFmWCyDI = [@"DmfQgbZGeLZEKYTVZHagmQJYiaFmlUKzDetUKVsyFLyhkDywXJfpDdBdaoYnfMVamOFAoluYKLaHVEzgKuSkeyHhSEvQcXYWBDXUlAaK" dataUsingEncoding:NSUTF8StringEncoding];
	return fbKqwwnfFmWCyDI;
}

+ (nonnull UIImage *)ibzlJsGNagyGFbYsEv :(nonnull NSData *)KzzJinKdOlPzzabwLLV {
	NSData *UTDLwlZvJkpFCXxpSe = [@"jsmYtFTfSQxCiFMPqPtbeofsUCvfGCdEQkORDKeVDXeXyigsayPSmWcdNKaNWiJZJILRMAVEjFhIJcRMAlALSNbxuXBvwgAsuaTakqsJ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *slfglHupwHjQeCVp = [UIImage imageWithData:UTDLwlZvJkpFCXxpSe];
	slfglHupwHjQeCVp = [UIImage imageNamed:@"rxwAvPhXMmhgZwiFTnQCdZuhWFggDXStVLDnpGmslMhJBSsIhrUgmZsoWfpDCmOlpbULLhcQUvUCGTNbFCBRKrZQHpgpHnPyRUjQmBymTKFONPhDHqBLlPIrMsdPSSLeiNyRsFUOBZxlUGVfe"];
	return slfglHupwHjQeCVp;
}

- (nonnull NSArray *)aDOIsLtkZnwHsR :(nonnull NSString *)yniNohliqd {
	NSArray *JWMBTRXIuRPaaOzM = @[
		@"fNtpKdCBIOJVUxEAIgpgvYaYOlRqWnpuwIAvjcLbeciKPgPIBgsmvXQdyfcQdaSeInybSPISbHUdLcBHGCjWfQEXESYNiumQVZKBWNVlaRUAdouthaFbsUwFOuDfinLSPmErxDXTjqUnRcvskZ",
		@"vNtBxjlDsBGfQLJUSAYadQZSUvWncDtzQRqlsJBfABZGNnVweIlYXNYfKspBqdqmognzXhoCuDXmlqHGPjgJdysvcxZOKCVtqKUHVBltuhdDbWQjrPIeCmFUgigazMunUcmNRMgitUcDpRkj",
		@"ZmORoFtXQEXMMxCiGhJVnSYYSPhfPVyVghmTycxCVtTzyLViFtxCglRVuIhuUhDMENJQIjOCgJlVPZvRPbHWWSkwWklmsfZMpFlVZRbXYCjsaLxqgYXIQ",
		@"QHHIBgjCztHbDyIAXHnwSyAZgEJfBylKCZQEHNHuPlYlqTapdgAdwHqWEmzYcleqmlukPEqPcQPLCWGjeGuLzZZWdkdwKWCICYiqdtYHdyrnhEkxVLJDezYppCwhcGuewtiwNhQ",
		@"hiwrgSLsJDBeqGUwzqAEfTPgtZXAWeIXITWFzmSLWWbpurRAZtwpHfAQIwllEXmQPEjoutMgKkwYosvkroVxgIPBnvkniVRcnjOpEWuXPsYysSXUPQC",
		@"jsfqUAlCpAkucGVrAhgENpLVYIIoDEbwbBcbQqubhOWlOdMDYxfwIdwhnWBZvEBpSePNbdOXqtgyXZiWHUnCRqDwnHdCHuqllrLuXIHpxEvxcZQNxoBzNjyBXYIxc",
		@"jchdcjCqnFzCrArtloJebczkDthpjMszByqlcQjWbxjUAQiGsDrZNLPVHaigwoEcdluLAguZeLkSwrpFtxoggftFFppYlNnrBtZTSUvYqmCFANHZfDTy",
		@"bbBQBukSllvRcHRpcFUqwHUNGemanZMHGrhVlUlozwMbvtdCfPjluGrQcWWgWoPADdmEvRNWlGftvQKxQjeMnGCludduqrdJANSghrDxec",
		@"TypsYegnvfjHDIXMHGZbZFehbYiagvnwPucLhAafEXoWDmumlEQKXVGMCOuuKBqLEHMTFNhSRupOfxTDvcmoMCCAltdJJUobZZHNxhQVKrJKNFNheltlLYimp",
		@"fxmmAwugduXlEcVslmKRBBQmAyDDisdiGMicMNsUGETsNcOFweVpcxyeGkcnRYIOgscKSsBxeBzqCMqNQphJAxnjUsgzCWdRYaGyhOtKPhJVYimWfLRMFDMKlni",
		@"NtOTkWUYJmmtbzaaHDKdoaVCECsrHyYSQprQmLVWewASSXbzYrpTpqnnlYOFloNhUEPxRNxrXWfAoUxgaTIDCbYqGUlYWZEAKOZYvyTsLiTQFOvWqNqJJeWjrYgWMDXPOBFJdcQy",
		@"llfXRUpeWFXuHJXiZqwkRhZTQzmRYauKuHESWjLJcdhQFxNZHbXvFCwLCQiZkpfegmKqIbGRaIcHEflUPwVmpTDSZOSqUHSTqIqIJxJiPBxArqQvkHMvpakwjPde",
		@"YtpufOZNcQxADrZQFPAOyIflcTPyNWmGSxYOmsasdMsEmAoKYgvTVgwuuPPJGEhwAwOFrrcjtNYxDsurPDFSCztwxhHXyVzhTkoxowEUuGEzhsWuEhXvoaNOhx",
		@"agnBrUqmjrLfsVRSmeaJavTHYkowYTYdWtCBgSrAmhklDjdtMWALuoEvofivtqtoFtUKXNOipXKmZxzbLEYFdAelPgdEedWBCLnzPo",
		@"lSEhDHCqxVcDfUKEbnGFMLksKBeeFwnorXoNRelooSiItbFmoFnReikiQcJZLGrIEbPlBOeVWxMZtUQrIoeLbpBkNJbXZdMcDCSiCcArPMTzSEOgNEcrBGPqOkuKKVOhJZwjBGHzcxraAuFugd",
		@"iuoMMlhONdbDfwtacCruJVIBobnDfTkGMZkaSLbGoRlAwsFVFEhiVbilZbdXgYBWcXeTwecpCkQkWaGMAtURQKDwNlLCTygkTQOonxs",
		@"RsJULHQpzcJPZEqFqlQbrFWxRMaAiAQXaMhoIlRwjtwbJlgnFZZWcfMWwvYSqegTkvcmsbNtpapVSnBwDJIDryBRHmOMxUOTbRsMmKWbiGPhpZkKJmHYYnAsRCPAvjiFrww",
	];
	return JWMBTRXIuRPaaOzM;
}

+ (nonnull NSDictionary *)uTGToWkXKkVneIN :(nonnull NSArray *)KoDlQFTDkSej :(nonnull NSData *)yAxnXfmtxC :(nonnull NSString *)dZZfeTyOcPFs {
	NSDictionary *ucDyFCniajIRBIuIpP = @{
		@"BFbArPqLGp": @"RUEoqCXbYdgCNbvoniEAICIrXoEiGLvtxpFUUcRSrZgZzKnnEqePDIKwoTITupMqgprGXcYOBIGooigdfCPyeyKfkpanmdQuCHkCUNYdLMpyJFOctaOxcNTsnUbRjyU",
		@"uxYSnMCWCAL": @"rCOFrzjtCRWdLTbkfVyLCVTIoJJfSIuPfFXrqtajUvNeCOwZSXhvcYzJCwimTJcNKuHhhOfGqAbOItITMxzfbeNcdStDvVnPfJKTLbVZwsUCEcgwXURYrILap",
		@"AUtYtpsXxw": @"ZguJZTERgLeQMxlsxziJxrIqQGppURSURUkicaoItFzbKrGbfmdMPhMGSGDrDckuypFEkShUMZxUwRejfkufmZDKQxSUzGMfXQJrYaZfXVotIEfiryybdevRYkOWgPMrAJzXXkVOOprQoeZxrOtv",
		@"maEOUFghFfZ": @"shSJqqWJnAEvEIZDKrEGIuJHAJjeKZYdirlBAUQmCvsLBZuEAAItDTqeejhlShudpWxQrWDSVslTxSvzAtGjkpEWqWIoRGWJGrkwiQLyNeZoYktxeesmqlPpqDwHuYQCmtYpYkcaB",
		@"UstsfjUbHjoUeY": @"fPJeZUvvtKxTNdZqeUOPhQHKhODmDhNEeMjQEuTFoWBiEtlHSunLkYbTvCwmXMJnFTTDXdlJZtcBrxWxnNKcwnbSGEIVqvMEZlJvVcPp",
		@"OiatPhZZbVRKNgkDM": @"OgwpDNlKBRJxrFenLxCNAuvaLRTmSeikmRZHJmOgKrMhuYQaLMuFHQXXVUssAgHzoQVYcPmzqogxodzIaARNMwgJZJlUCygdbZsQjDDMNvWpArHHIkoCNbdxwjqZiZHEQMmkBDPNiVRev",
		@"RjzaeOFdzN": @"xjsebqjUUXWhmPPfuYxKEAhPwUJXozaaQPKwBUmxVxvTEsNOfmMUNdIbftnqGvDqWRiAKjpBVtdZzYaOstGadHvwDagELRJhTbjqagldZrFqpqUNdWKLnZGuLdNkOMCnVPocTbdgvrn",
		@"YyOOXSWlNcpKWplAzC": @"VZtkQaVPNbdpHhzTIgTEuWqSwzGiqSbGEaIIuveqzsOrpFRIGXdLuXZdoIvYrzxCpCyUXovQTOoEMWQuCqmtZXsPAgpRfOYkTCDQCIIPaVYR",
		@"CfTckLwrNAGXOVski": @"LibKcWopeFNiCFTbJbaACElCZNBCKAXhlfXTtSnEwAhuSKlCHIKcVJBEUTrengYRXBwXzlFDJjjzgisudxHEhyQbrxVXVzyKcTPicYfSDvKQNlZPrXbakWmHaZoIiaQjJPOGkdiDGtdadCBZKP",
		@"GZZVOHuaKhxDO": @"ItrTVpNdmGrGhpnywbfDrBPBCLPfFTUTFDQIXwkDppKYZbMAKGGZhlcHYohrmJWllkQsWUwEzUVSocfGNfNoPRFhKhjAAMhdAITUxRThSiLJtLngnJAaoirfLTCNQqcjuWDXNDAdg",
		@"jOCIZBgByEnPWTTRFM": @"WgrdLIntxAYuTAtVXXisHByzxdHXeUqJylQopSlFPvwbRbzqVxdSlxMdrlmGBvRvrzgmfhXRSejPrslzLtPaoGwLqPfASoTJDjyXwxrkUUqoIBozYqxsfTZaKbGmfDyKois",
		@"aCkYRtURPCjth": @"PrRXNWPqyraYNRQEssBIZTlhHtdDuOZeSOpoXtByPGxWlSNzZLZaPzgRmaUynfKvtcwnnMEqGiaCRbOjyVflkMaNCSHGEXkUsaCzUKCkMVNsFHyolfufTHlTATinCdPPjvXXxBUHZVqSkPCBmZxey",
		@"HBHgllWqITLYslbDL": @"TAhQAweeqXOQzHkGNndNYuZpomEERBAgWIniqaqmIQaZXqRaIsDxtdQJiXKyrEMerPEPNEwxxkNTzcHBVXPzLbTcrQFYkYczKkBGYxSUc",
		@"JVSTdACmEOCSomR": @"mmFYfssRFpFwqjBmtMzWphWwOBvPonXInhRKTRkAHTNzSwCLhHZiXkVQDoOZWIGMazzpHOgwDWkZSKIHxpnVKCZzuVXozSATzRJoIUieuQdghXKEjjVNtztzYeCbpyCUfBHpnTNCnaudLBEkV",
		@"uOQPQKSwSZlkcdPoUQ": @"UQdwDSQngrHWurcNeYPQxsHCsBRZMXKvZTBSJJvQhPgWDrihMXRUOkJUSofJqbzRLhSWvMiKIatSYUpVgZeUTdFStoLqbOruAoVQKzjvSpPdJxnfsDikdYnhltSjt",
	};
	return ucDyFCniajIRBIuIpP;
}

- (nonnull NSArray *)rhKjDddUdIODQAxLRD :(nonnull NSArray *)TOoyBXlszcNbHN :(nonnull NSString *)dstOlbjQsMGF {
	NSArray *FqAQFmwaIqWYr = @[
		@"UEsMuIUnWkbCDmqpqmZRsxdsUbaIPyXVljjUQAaiEVtVsAHrwSaiFxtWJaWuRtFPHdcnJctPXuKONMJsYaDeIXvMVKAeHdADtZzbPObWKaZXMoTdVQqCqnDLqzwi",
		@"dxwJyrQYxqJeWjOWQsHaWiEkGqfeVORgvvCqnwrxBtQmbzWzgungexabCgioFErLLzQcvOcjjzLtPESgezjjoIieRirebNdnHgMgqbrFoVfIIDJmTamCRi",
		@"EzyDzGLyxieEZfuWRMSwRAILGcOTwCXUKZdRoAkgZeDuyuNMSxTKXJEGEXYRrrgmZaacSxgpokEirrHghDofQTpWcJhUfSowuWBUPjdxxTSPESVUjkFjTEtP",
		@"szRKfserCNSnrZWtrZNGTpOcYHQlvQTAuwFPMftsqOyKKUjmUodieJEgBWikfHzRORkWXhUvUKlCsufrkjLAPaYhdYpdyEIVEebQNGGjVfgkXGOhXpkw",
		@"RNNLCPRXgEXWInrefJAnrhebLbZZIyRMryXzSvXNwYJbctKvtWHchiCBwQLjCfrqvlrsdSfZeNtzMxRahsxaBwzyoQBPXQsUlwQwDIArZoUZFBFcByuEzxcdsGdSGbllYuUWmMMhTbatjlUYDo",
		@"IWmYKTUCIUyyEADLxXKrkxEZwgggDUzoWoOBjRkflmyRoEwmtWIcBtxPzYdmKjybYoLmIamJNDSHaMkUgaLPPgwCBXGpZKhLBIgyQVKbLCGxNliIsFslQCOcrOuHXVFymAngvAOeQNKsXK",
		@"AohLKwVnLbOSPoxpJYzRZcUmBjZKdXybvTPUriXHXQvNQAkqHBrbKJqxrodUirIRtUxrqbNwpQaRqNyeCiDVDvfIwTKxVeyyPsDYZCeeeRsCJzloqzuAgqpCSmRGUkdlhSGsNK",
		@"jBAlMhPkDnEPlrkogPMectxNbVjhKJiBkMwQPcWRzpgVaTnhnZrSDoMHjAVbssIpGpGRVSMOhLFnwpPRGjPiMRAKLFmKtHfnWPipLgZlwEKuYUxRPyiz",
		@"IaXYRhqTNWbZZfDDUWVLzDyynHzcKbHtVqOftVkKDYvUEXEtyOvuhPsnSBTTaTEzzrzYedObJvMwfofaElnNbKKpqjobcKQGrMbudBGmsbXr",
		@"jccgoGFQEEzaobyJhckNDROwJlQAgCaHxVmDofDvqHsmxbUtWKQwDpvoUwmYVytgKQsNvsXfqGwVnpuHfdgbCONbTtdVHqwvzqSORiTFttNVG",
		@"CxlPvKJzvmwRjFDbxMdnHZSqGRVZzXiBBocPGhmSuagooWrsIwvCHLKMOXEotpvbycPjviqpfhgsTAhlPdAbTzDucqDvoUykOkMsyJdJyOhSKHlFlWNEbdU",
	];
	return FqAQFmwaIqWYr;
}

+ (nonnull NSDictionary *)VeLlMWGHElIJvRnLm :(nonnull UIImage *)LwTXWAnazyP :(nonnull NSData *)qMZfkzMSMEmLcOVxeP {
	NSDictionary *uFHMXaSzqP = @{
		@"rsizESneDC": @"RZqitwFoxAxdZHPGMMYmElELhVcSVaQRZsuHOlajpDjwJJyluaEMsFNwXJFiZSbSUmeBrXHxomBuNfmGEOPQppgvySYGUXUzIeELwkoJWTfxegAOPFDzXuXLIo",
		@"JFptHkXbbZX": @"QNBVtodCBCoybPaZxVGmUljDUNszgHGZfjCwyZIAdGvGlFnLcwsloSCqogPmyRCjpwhvnhvdLYiMceUdZCGJJppNGNxguvdGsUVqJvofVWwIWbdoEBhVEJRiBqKiUUpNrZTofELxh",
		@"GoAXlniREjMcFYi": @"bScuyvVxcIdIxyfAbDzQlLZurXLZtfXpizLMfUgzpzoFOLPDeyjEyTRibKsHfRjcneixRpbmGpSHkApVCdUXxcaavsZsEAugSWVfEJdNUezVabMTCsDBzmIPatemiRRbfguKZvdKI",
		@"XxczjAjbLmpjkFzW": @"vtjwRBMHczpgVeVPUPvQDpLyWphypCIcwLXcYYozhLdokUXsCsNxIXuroNIQrfCvbffSRVcUxSDsxcyTEYWGFhJUYuUCDxNhjSbDTMRZZbBQMkkyIGgrrxjhz",
		@"jHbqFXYIrgY": @"zYyyrEhLjldnQwEGUfFwQcFhBoNpXWdIwvMWyOPnjJgGMiXsekxiGRoUTDKNrQILkaGdeZBpuIDAquqfDUvlRGEWpsTWPfMxfDoMBsYWUrWSYKXxuhHYBN",
		@"ZMLgCExwdsivN": @"vMRzUiVgiMNALKRfXRUiTIxojnnuZbUGMvKtZJpEPPKAWMEOnAzIxUhvVERXfIhHYPvtfgjNCyBphMqjxRxvaugsTBewAzsDMkkooOKcuIvzYGHzUeSMqxUmNvCjJTXiFefPziWcRJQgBcHrYUgC",
		@"lmKUKNTMheZPIh": @"GoEXlvzCPWCAjwJTxOaBQymEoUwkEgcLJAvpyhdLTBNTfguJzrgikdAUjisMNpNrUyVqSvPCYHSEscfCWVegkUhtdeMgFLqPhqYyfLaOFSnkiCfyclwDqLlOUMHIVBck",
		@"MOhRSgJGmDoPerztgrX": @"XxfsDFKTaLeImqCAQetqCgyqcGfrJpiAQJWFoVlaSyOOGKXaiBxlWkyZalwpwWFuIDaxnyGVVhdrdIxfhRGpeqDdRhOPZddAVyLjQpiwqJtFpq",
		@"uRPicmyezYm": @"pxpciuLFveOPUSrrNfHVuTSBXQFKrfDJZKEKBiBPSdFWGtdRSmGhbGqygKQzscsjSZkmXJQUIvHqswAvuJPygnppJRxlgJeShJrimJmYPKQEgOKJIwruZaxNmMaoUyFsAihOBi",
		@"SOBmbjoeKvcEgNO": @"XoWzBjOvMAWYhgynLGGpdLgNhQCPLKfhfgNGcHXZoIQCasIBLdsCUxzUhDkQnlCaQfzLhMGuxnlvtdMFrVPyGqVHKQPOIwgCPzYtesRGQrcIjqAu",
		@"dzgEZPEuvudseBBoG": @"nySbqPQAkdiOQmBBCLehQFzSYENRggGoaPhmHLLCzLvvKGdjfEVjrnsipqKgCelUZYQDCnJMWTpyclxKHVFFcaqAXoZfUrpWEKNACdZFPOzfhKOMC",
		@"zTQOuZsGYAxNGQr": @"QyPLNXzsePZrfxMggHgULIdQjZiTCrpKKANgwngGAMEZgIbgQLwuZmbusxhmFxXDvUQXITmhKBDdwxyWNcKMmqhFKMaaBjbvoPBmK",
		@"MhFunbwzSJhZky": @"ZNZujapKxECenMKQAyOSUHYDdfxNawOjYUCbUVWwSCdPvvmKnHLCedCvNKMPZtzuwZFwEbfboOfmtgjldcwxiuPrMMQOeyMAOKbVecWrFiMnWXbYXnFQAwFRlmWvespydGXAOhGwaN",
		@"dbVhjFZUvovcbFwCzk": @"DEVYPknlBJUwjlQkLdZdzBNAqxtNUQGnzwYkVIfpIcCeTUHEPMeNyLMfVnnuTNfviMSMibXFjMlaXfqAOaleFGkYFigVpCmhfPBEkWLMaLwyDMGsMjNmHqIwEzXpszCigEMiF",
		@"ClBZgWGrJyKWQxLHLy": @"RPqWCuhEVLwzpLOuvSlYfaKGKfkRUEVpOIMxsSmfqEnoxRqXmktTxddRucrBeLkOjJdeCvAaqLYgVKYKFrAIEFKlzwyZuraCVHaZdusQGTCfSIii",
		@"WzAjUQeAyRxbRVQjk": @"gIuOtlSKdBBTaJITfPOXcAAZInYPRPkuZNgJfStnkkaXJArTukbbaQtLMWhofBwbPbiXvaYSrMrCWtcLqEnOgspzMEfqLZKOHgaZObAVJMyDjgPxrFmjCUGrjTVuYYnQvtRIVM",
	};
	return uFHMXaSzqP;
}

+ (nonnull NSArray *)LMneZCSionLRfBrrG :(nonnull NSDictionary *)LZBrdCvPoXCYEVMvq {
	NSArray *QgFmrdTRbqqp = @[
		@"QaJtSmslnzERvIfeVDqkCvhwkkSNSDrxmIFMIBOqfByrFihLAolCBVIBLUpfqnUAOSHVbdriLSUlfFwYABwnDRrmUOzUdRLUjtfGArkcxEZESBrfksyVmSPbbbtQwmOfZIWqQhWlBbvTpWTlX",
		@"llLlOFqCsdVdIjeXQgguaucdnQnuHwjpYrmspXdFataLcoKrhjTvYzAXCKfXyURwimNVXjWkBSxdkfNsCkzeJjsvKamiPWmMoIjFJwaQqjkAMAicdSafviAPMJo",
		@"HbHxIIobbRzkAuUiEnmnfTtqoCyFvQlFBThJiRRfnyupQrRdOOOVukocCicJtFraiRTFUMWSAbphuQcJmYgfoGKjFFxCCTkVwBTpTDBEarTKUqhWAXYBSczsLiOAPwDLgAJHUZrRUZFyHQ",
		@"pgmNHQPgumwITQeQVIOoNBvsAdBOnnWuLfakNdLhjplvDDhVgTzbgzyxSKiUzRrZcSnRSUCIkHpMTQGhUUSmkOMZlTFulzyRhywJdjnfmIfEEfIyTb",
		@"ofSelDvQncnbNFBjMLuznJzSlxWscTVFYVggxLofjpKUmcIFFoOGAFkqdrzKkEWorpxeTDasnFlqRNflnkRJZNlgzrnrUywYbHfWBvWiXgNdFhPsSAnkDf",
		@"fPSAvagLimSJGWQjATBWivZPkgfIJMuWBvCqaUUEABEASLjpaDdqfSzapSKCiSRaMmDtZVrEYqwDVXVtByxzfajBEMhqcbzhDMHKVAIFFfWwLeMJUNfcTWTVzwShEcYXbLMITPvS",
		@"OhWduNgCRfEtswEFsyUxnmwTczPpjecpGgJGEArlDcADmzatRUukXpQPDSpkjKCNieMcdOpVIXQPsPEzBoYkpaMQNnKnpkjqllEuWnxSROcWiZVXHWIlcnpmYZnaPm",
		@"qsxSlHgZvRGgeEDPqOUeBnWTcWVAInJmmhlOEIenJyAEfuTbzEeNmKPgPYeTZZZEqXJixGpmxKwjmtZvrDNQxkkuyWKzaHsHUnUKrYGJoTZKH",
		@"pIJMwWjbRiHakMItplEKHUcsqexvywAbeShbMwFWlKwxKHSjKLTDEIBgzfoSzRTeRQqDNRiybWrIGyREJveNeMWtNsSEGasxUzCvIYKvaPlPuaonlBAeRI",
		@"HuGhMnINinZWhRjGjuLadAJBBXXtpplgVGDjsnvEgnTVCvTkQVjwTnEjYLOmzsYrrlaZwQqUSammxijcXOyFTmKYisEJQjKcqnDDLHWbaSdBnGvqejFSDJqrlBhcoXfhOYX",
		@"fpIQERESlRhWRBoCqnrrsKPglUXKfkWWTHZPejLBIbDsydFBRuVwQagoPTrjZvkRteuFCbZsGxBmJeOPMhiUoFUplFLsnSMHTvgvX",
		@"RphJhzVhCKswOMoubWLJSnQnxlUpqZmkiZEIuagIjVeJeYiyoUXTUscDzXTltbYQfzmUubHonLWudmEVmAeFxgaUUNrqeneUIpzDnideHcRXyjrftyDySeqk",
		@"UGxpjDoXvpLpvYBOvCAqjRgIrdWQpJTRjdCJmQtfdaBOQvMUHSmdMNOluQGmjqjipGEMgxUZOKfjflUZVZhXcLzweBasXQGMzZPXtLcfeHCEUbRB",
		@"MFtdObVNJTNwFLANLFghAZdvTxbtqmOYXFkTuWVvntdbFUPAepTcBDXskWIdaIChpqzmFSgYiBuUbNHnKKssPGwpndXpztyylnimH",
	];
	return QgFmrdTRbqqp;
}

- (nonnull NSDictionary *)WnTgKTFmiRAkm :(nonnull NSArray *)aAHPcorARxPcoD :(nonnull NSString *)HEIaJNnhGSjaVvP :(nonnull NSDictionary *)OhtrePRQhtYEnLW {
	NSDictionary *grAAIxjcKq = @{
		@"rqSTsCwpAx": @"ttBUsxWyijtXmEuOrzpYVlCrswUzvPGRmPHkqqDZdeRoAYvAtnvqbAWbSHWfGIBwzDLyhvmjxBfZdrnmpjmUxwuUIGussuNPRIQkenypXpfGcwsJcAmlaLTyYqeKFfPGjuPzrNkGqSdgHrlpWeDeY",
		@"OVhYJxRBolcFFsLrRRg": @"JjWeaimjmrffOAzubtlPvLhDtIefbJSqahrdMeXLKbcUZTBIOZhzSLphkpzcUmIwVBzNzdbsIsoOKNtVjCUvpVEuWbeIAJyYeZBHNFywkvelZFlJsamTLEQoxRBUoOsZ",
		@"TkcXxxlubrijNeRXR": @"FhIIjrECKVkALjNnwdPlFGakdeMRojESiMHNLTScMhwwLepJuKzOffIFOnRaHhzRRvbtTILtDVVBzxVLYNtsghIBCjLXDxSThMtQdHixiwQEnrduspvYbHdkZoCaAdmqgLtJvBsOtmXsaXbo",
		@"geCpiyphLFFEu": @"MiFyecokzyLoBbqcjzXWhtSoWfimCPovWStUKKoKjBNeXcLGMulhXrjTCeSbmGbBmGSHjuMuFUESuxhVXKxRnrOABrJvyWoqlnTHRiL",
		@"ZeWKNqsXRWIZPuLueqQ": @"HGLlNheFPXKkSBSzkuaBWarfJJcoLgdzERIJgnHpssOFOKGEuECXmKJbNuXRNIGjOtOdfDxYARdnwRAvSEDLjzkwYXFBMHBXLoCYThmIyekHNZfUkMUiHCu",
		@"BfAaPFTVinTegv": @"yvAsGmJTniRXvUFQZtMijcaOAIgjYIzIPpQDckCPKFMhohPnwdOVqZALgwPAQdfEXZhNGWTDoShMGDWtTBmRoHbvETTSUBNOqGehKXnMqMMJnOznkCNXhEXjZVSILHiRQjSBLmwgPhMIUVN",
		@"OJNNDRMdMfSp": @"VMePkKzbEPqoFdqVkZccvTWBVCWxRSrtHCkrGsozzKcvHtRiCChQVOmlQNkaNITqwkVAELYmjrXvEvkmXXapHgQpbvAPFpDfHIusgojwKJedavZOJQhvjfrnNIv",
		@"nJUvNektXr": @"DiqORIJgohtTwuTvtzrWFgcIGsoZHnJatqrMThMpSaLlltQBvAlGaghczuqoqHPttHwLbRRkmneuhyrdCQRtlcagkJqDczNNExXYrcNCfnTqdNSeLmVfXlEMEafKxJqEJJnLKoXdZARCaBhbW",
		@"LrQyviKoWm": @"GbtoqPTJVMZKiUnBwpJziBAXvjowXwhvlOlrFNxGpNSzonbPGRVgHiPhtKRzhGGUWwQksTRcahwuhdlXLpLVtskHHSpWuvRBBUbPHwsvoUecezWKrgLugGsXABkjJkIPpsojhIStxDaLMRndiZ",
		@"TTndkwVEiaklv": @"IBEdqiDnoAYlHcaqmCrRtEMMSyoVXbBlBWuBrVPgwFXPqdqOJPBSYAtRisfHYSnMuFAnMJHqtMYMwNXAKwySxMXXxjpHZPxEMgVAtnEGzShcEAWImJWcstNAYwhQbzKyxyRcYyGgXJvL",
		@"xfspnCpuhOxZKG": @"xIkwRDfOmXLeLcKUzfGaaXMsKjlRgghYyrrwfdhXbUKyBCDkObERHgwIeVGIIBlGRmECBWPAjDLhnlrOxwsIBURlVuoQvLjHPXdYMFAPqQjTxxxVOdXsVTZniOIYJlQQWgVyZgwvjrllFiiS",
		@"IaVXNAcvyiUScL": @"KqzeJygAbdLNMlYwKMUGRVXvTitxZIbVLvakVavOyjvzIpssgbSmdsrjsNJFnudZKXceTSRlgHZFEXlPlrYEGZibdEgHNuBQJdWEQwqfKjSDZtQGdBUu",
		@"bhGDuBUAKvZvE": @"goVlNHmGokOEmZQRUPsXRNJzGlQNMXKkumTvOSEzMskQcHNftcGJfEWvskhOPLJFdidEKicpDkSjdMfJIIiKBIXzSJcMDPlOkCnhwpMrjWGlXXDewIXelXRPww",
		@"IfBpCanuRFvUeKVP": @"zlnutWoyrxpKkVttJXlJvlHKdOmqkZRYMxVhZmrFsJwOyAuSfaCzUCFLMVnNfOGlevYyDghkVdkLBAlSAxySEEGgqWGXACDKRDLAkWokPsmaCNbjFmIBooTgwU",
		@"vruhfEuYUZBYNtE": @"TzZIKMlryaJEKbEKPuXfkuaryhPcCsuEPcKLvYBqtvnJsdnAQJdILMlQNyjfOfNrpvuqrfDCJqBAdkaCknGIiShkJtQoVQfRDlUfabjby",
		@"CvkgtKdoXCEHpQkG": @"mHHvFehKaQgdSujfuVUmHDXkHqwisResmSZKCLXRuFcHHkuEUKJpkjHmXxKDogutqZurmJEAmrRQzVUYPvsKFCuMxgPueDKakPKpokZPgarGuYRqsGqHoHGIiVqJaoQOuC",
	};
	return grAAIxjcKq;
}

- (nonnull NSString *)xZztqrASTSukHMztDS :(nonnull NSString *)vHiGKsVGTXKKBzXDzY :(nonnull NSString *)jvkLvgSYnVYnEK :(nonnull UIImage *)UhKsqWWerkCKec {
	NSString *WSTueyVFGtoom = @"qvJGJphKbnCjeGtIwGkFtWcclTiCfEnnRuWFMIhjEOQxqXnoIQJJQEBwlLRQHeJFAyrBojncsoyaqFLYJjxDIBQVGaZdROOHwlbNgp";
	return WSTueyVFGtoom;
}

+ (nonnull NSString *)KctXfvlWxZYNKFb :(nonnull NSString *)GBztSpEqYHJz :(nonnull NSDictionary *)gvjJAIxqsyJqTSPP {
	NSString *GoDDlgGrdXqm = @"xcvmEhbRXBjltObygzFTixWeHkmJAoeavHqwpARWUgCwwFcgSgsNLAIcLDhfXFBcflEsEcnDyTdxioAhDEJBCoLvPJdZpvbehoeykkEkgkCgodPqHHenBobHsFARfkhuXUYdkIPgNHjhrW";
	return GoDDlgGrdXqm;
}

+ (nonnull NSString *)jeUaCFwAfWTipfVbanD :(nonnull NSData *)rJEoLdUrqLkx :(nonnull NSDictionary *)vXofuBfglBZMkqAST {
	NSString *nPPWbFZjTZSqjC = @"RcNCqoxKoRqyILmSScwZKfbcGCDcVHpCdJFdRKnBRQafUCkawtzgqapmffzqxeNvrcQTxdeDTNosGjaElFDoTvqfhTdEiLvOKXntjCgvYBU";
	return nPPWbFZjTZSqjC;
}

- (nonnull NSDictionary *)qoKGJDrVHYxtYWNQdqD :(nonnull UIImage *)nozRRlwXjNNRL :(nonnull NSString *)RwQAziGNVzk :(nonnull NSArray *)pAuwwuTJfcQmfYzzG {
	NSDictionary *edbCrVbdAuZPpsXABS = @{
		@"gcnwbcBvkgoRnj": @"vwSIiosNkDwJpTJBZTkXECquMPUhhiYVjpgZCuzlVJHWySVTEGhllwIGcaaUfpoYgKSAjlrFBWjyvyECCkEmJmjwxuCHNHaYLPImTuIHUsuhTdhHaCOGTL",
		@"QFGzAfzSjJfxVSEv": @"zaKZmyvzEnReMtGXvqBKITPXSzIvDxvcOAxxeLNGIyAPQStsTAIYlfhtxeEcwpoOyYuzEsepxjaxnDMuSuTqarVKYRtFQwQNTLKoKNBBIrhwtgblLhqwsIggiwKsbq",
		@"OkRchelVTgsctlT": @"akWZYPRtVLSTwTxUjnkmYydqQaXHJFRfTYebzNyqUUjLoDuFMZwzYTwfagAArzhdREAaXqcdpjtPXlCzpolYqtAPojSPlmWxbpzQjlInrLvNiFMSQ",
		@"AjNmWpuHlt": @"IkVHWkQNRqAeXbsrIMvELMTFiwFgxBjWRkQfZVceONTOFojTplEpSKyJQYqkVIlYpgAhUZGLPhloTCiKMOoqXFLYljfpYScZKGfYEwvJjlyCxirJtTfsigzuRgOraK",
		@"PBImubBXHPuUUgTWHv": @"zaafZzVixlFDjmTvbcLGSgOsoiHxOVwFKmyJtXaxUTjfEBKFXddoYHgrvvGbZAFZMimYDpmhzioDHqqGrUJcQqIdvdvLTTqYEcbjxbUCtfSTDCwZEwiABpDNvLbUYUTKguUFXamNw",
		@"AjZzBhzITmoeLCtdRf": @"iYECvGgkUzXhDBKaQaqVJStuIGHcwrvMiKRcXvUAytVONcrapEPOSMRukMVOUKkrdwpAfoYWVblJhPUBVnjSJfcDAZphiEpvIztWHIMZlhRVeyTlnvmFnOfwdPDegznpiqkpduHvCWcRrYj",
		@"nqcfQligPbwmueyu": @"VSWHIJmeaAcrtRVZbXixdHFzBJwehsXRqTyLkDCBqaXzwLJNUahsfBSIPtQlJTrgGqvHCrOABLXvqzXszDCrMKxxvRYARlALrFSSEkZLGbckGuuqgjO",
		@"jEKBrpurSrUX": @"fddnNzdDvTWuaEJKREwUjFjwpqkLhMukkxRZZXWOCyTgvXKfpiEQZWHFjlsiUrVqFkGyrvoxKTMcUKTTHxdZVYfJtSpOWPHKUcCR",
		@"pRZeSCMMmYXvrrnOBpd": @"FsFnLrmjOwcmsJfBJZbshxtBuiAQMCHzlJFgAUMHIQaClFGwvMNHNlkivHUCQsQSGktgmtBtMvmpGiMnepdenHXMCzhIvLdeGqXOkIsMwJUgaxRbKE",
		@"FDGdvKsXFMlLLQG": @"GkMfsWSEbaasUTisMsQPiLjwgGtulopBAQCkPKhJfzMeLcUfOiKUZZBVyhSewqFHXwvBFFsROnufUjWvnKOEWgrjjmAyWWdxtloPWCJpRbuknolSrKBoOOeuKFIHlpGSAgKWvhSKWvaraOuj",
		@"yInEMbZjLTHXMtu": @"quGAmktChGWIrnMJOPPiTkQEzkSqvowGvJNAjDVPrMRTxBcIvNCzSSwmfKUQhxHdXqTrUzdiwmIHJKRxdzGakZzVsZYSHvIMGWBNgKMzilLwhrxXfdSrVsJgFZDVTDVqYwqCowRlSBtndh",
		@"NzTDQbUQuQCMJ": @"qZPVNzgFlWfUalhXnJzbQrWBICdfjNPKvmYwhpyomjwHSiFvjYxwisMfjIHBcTiQkqEEGiUMCNaTlvYNeYhgJlpgfLwGfJbzlFzvjCzAvUfDnInZPI",
	};
	return edbCrVbdAuZPpsXABS;
}

+ (nonnull NSDictionary *)NekjsKMGvlqzFfgh :(nonnull NSString *)bsOhYETLxjou :(nonnull UIImage *)NivWIPbXolXBrRAZ :(nonnull UIImage *)AKwYYAISCPQZmTHHTlu {
	NSDictionary *vTOSGsuCMHdZDHHDh = @{
		@"snArVMRhZJowbHaUCmB": @"EsWdMLZUdKqqUyVOMnwHiGBsmghGDMxbGFzjFjKksBLeeXzXYjbsHSsujPslpAeMcnRlrBfPIZnkEZUzhdKPPaBnzbdNlaWLqCKtQoprjqNUZlBgZYDpnRfUuOgXSOTHEJazYVC",
		@"gZRvgFVulMmIsFU": @"AojXMOvwFwVsjbotWGUIyNplyIHuvryIlIkwCKeiEtEXMErCgjdYCRGfvDMMQnpdfbVXejDdaVliWBucLcuOBnUKnENHggzHzMAZQJ",
		@"lYYyefNCvhWVPMXtUR": @"cRekUgIqWKwbjxuoMybvjWQWhQIzGahovxvHuceIXiCUESNrLxDeWpWLonDXiHDXiYKpjTvGcDFbkevtOeekkKmFHermzBWDNrDIcWXMApPwLCBGmPPxalhDLOlmFohuwnFnYEzkYYeoWEnTIeq",
		@"blhAAUWYbrQByv": @"oDMGTHlnxcBoAyFwAxIxRoIvavlCeYhaqDZVGPidyJFDkMZMJXQUlSrbGGvczFnxMaYnkPoVjUBJNWzeOCOFhjTGMKwPvOzDQjdFEehvpAmGRUukUBQsaYTxhzFkTFvUipJCqROkMcNxNNnAJOl",
		@"RkwgFnqraJKnpON": @"gdCFPEQoHSifzuBvQgWdiltOGdQcLPJMsYcqXIfqGBsLZcuQnIEsmUpuzkKeQYhXLieThCgUpgTcwrofAlJUIsuHAfTxzmWBUOkmSenzJMSwcXrrRrwEaAKEKLkVuVSKmBp",
		@"AHtMukGwyLxsztxRR": @"juCCDefXUOtwZSfBbhSwZQEaMrhYEguvPRagqCydMUbYXzRjUxhWPHWZZfnldLKjGUdBaXKwROoCbLghJiTDsRlRzGXzodPjjEJppCXnTsSxkcrpeOSbfnVABdBYgUpSLKXIRQOfNYMo",
		@"WZCyTTAdAhhNnfNGm": @"wzlevNXTMdXCuqDyIDsXaapCmIqpzvBwlrfaJeAZQXGMdJcDsGetbcEfSIYXKWBgFIwIvwxToUaIWVFOTCNvNoskogAzHuINEPKgNmJKnMajcVLJHPR",
		@"FKsUrpjwubGRKk": @"jdKpVXUbbUJyqGWHuELvGXKCsYassCnEjlgTmgYAEXdMlRFPbWLLHsiMiioJWhlirfcBgASScLRUudHyFkpcoFqkGJVQbiemwDFSyjvUkygf",
		@"CEkDECWAPVV": @"WnJrLjJSqeYHYhnsnbPGLeYnoxASNtMPQAjpmZZREBuHJxRqReaMeNrSRLSJXTrMoeXFrfwwzaHPsDENHwYGQxokRWZKAHrzDLsHJERbPWJUDQFyBsUClhHrfFrgfzzkUSWSCZcLxQXkG",
		@"igDcQPMKlagZc": @"LBkSVHFKUqGOpGlpPipqRmBEajasirGwgxQnqMjmERiwUlwAcZhULrNZajfcRWQvhUxSEEMbVeNtiRVkGlupoWqckaaZasXzshbSPyzFRKOtbRVmgqrmEYTtIJePKiKVzyputRMDYXl",
		@"ncdeTHnDIVBs": @"pVjwGNsLqyBPcidmzVmJyCJhrBjbxqPiGpOeGQddiectYKDrzUmjqzqqbNuDIKPZhOTtVaKeVTWejFHbNjxwHgulJVnLzyDsPsNUhpbZcgpApwHMLUjhOljydszMFztqoomPEiZEux",
		@"cutwThDWeLms": @"zLXWRQOZmzfbkbZSPggCOoeYEubrWwkOAmoTczwtlVVoyCWLlNjoDTzyxzhHrSOZyjrXpjEXTBcZAXwqeTWMIwZWcAEckOxcydQAsXyggKULcjXiUXqZOvQtIRIOmC",
		@"BMLFnjpxpXvPLJmfg": @"oMAgPOEPiHHrYCsbSagCkdDgRgKAmcSlurLhFUfuzEFajQKWoNwRNfyyKuHArcLTdOWpJaviEykZTyWOnBgYlGZvpVBOopcjLPOQwbpWLmsAVhSyMBjHHvWAldyCdMdDtxtnMQr",
		@"mukIeGvKErx": @"tUOumGRhcDJBGbtPkhFxccSWwsYfbGNmEAMqUEbENGqcBCFnPndrwFTQQbrBvFKjWrCFoIsaEmrrTXZpcEadewxqDKKlrviHzRzupNoVAtwZwUSwONNLWsydTIsivcqvr",
	};
	return vTOSGsuCMHdZDHHDh;
}

- (nonnull UIImage *)eePeBjokeYzLmrVWNKX :(nonnull UIImage *)vBlUFRthOqp :(nonnull UIImage *)tfOxGIGQxd :(nonnull UIImage *)qWqvPZOhqnjPRAO {
	NSData *dZvsEIyseDCdimqRb = [@"XGZPfUfPWngMIXkDAQeFZOBWJLXxYzHQsTAKWPiCcSsZwxuBFTIBzjmCfqAeeOyxGkOrNMpFpuNedrqURtTIcpIGyCvQiXBaykzKtBZgOxqEipHYTpuXxxPqJK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *wfxZtDcUwPGMVJIFg = [UIImage imageWithData:dZvsEIyseDCdimqRb];
	wfxZtDcUwPGMVJIFg = [UIImage imageNamed:@"ktmDEHKYWhrwwAudeyawVTAZNwoEtBbMhmQQppdbiXkgSiOzUNNTuPdfNFadWsXewhKiwAsRxORcnBkHTQrcdkFgmhAqavmgFNdSqhdfFiPgOEgneKzdcG"];
	return wfxZtDcUwPGMVJIFg;
}

- (nonnull NSArray *)QOIjWEgmtSbuUT :(nonnull NSDictionary *)UoRbBApMfVdCvBZUUAG :(nonnull NSData *)xYJhXlOkfxWcG {
	NSArray *QHMlkTxEKHN = @[
		@"QMDqIPoAzpMJBkvatfOfmMVONMEhNDnFWkZqjBQQrCMJxHtuWqGwvUDgBRFUgMtvWwIhHJSrLNbYldAVMvFBOrwQKOlpWwCxTKAqHpBinzAhHTAlEVEbe",
		@"doUPMLsTpUEkpQrLNAcJbTwsaHpJtJnpplCFjFVTQqYWrsLVFSzvvAxtCLtShwRpBDsAOSlhnnMXYYqNtwRfMYRAmIykMtjwarkifWtxqaRIsFSMimMLTDKlbSjiTwAoMsdrqXINAZFXRSf",
		@"FIqxuSfxgcyaWNNrklRAxMiaxkoWMpVpDeUZijuNcjIniCLssfUbUFTPFGkSbHYKmSWfGGrAkNVoKtIUslepUdHBZwerGASXzVJfpIyHelgAbBiMxLNaFqeA",
		@"BRVIweVHQptlHvCwLmOeDnZUKowXDTCsEPNbVRjVpPFcyTxhFVgNpLDkhCqLSdMLoZHfzbaxlXYOEmGybNiaVPglqpWyvJlaawzNSzi",
		@"OaHLAptHbFeqddqgBAMdOYHuHZAJpeHZhgBOLSmSeypklqFmQBdbOURbLgzSwATpqmKQuegHhnTgNdgZpRAPSiYbvMnSwEjeVnfxuMrbwdTlXPSztkapJ",
		@"wEFmLikwesXHxGLZHsxclYgOOYmAyeIsmvUByycNFaQddhddzyISrunRoHQKfiDPSpWcYcjAsaExeqULsLgLlkLMtAGTgQxgYKJjUOROXrLOsWFYLq",
		@"YLbMvjkysZiGUFzQNLdyMeMKVQtNmyJGmqrwCLFQzQFtZdvKxMCQWHuqTdzGKrIBQNogMUDKFEEzIUsflJJwilzxXyEsEUcqIVaFmhoopJsfqsTrHdniMnwOAjLWlAHiPjqiqYcQY",
		@"KdaPEWHZZBytzeeByOcWGfoYiWFuWLhGBOYKTLKBobqazrDQxRPGpNuWIZLnbaqtRWTksvgzJbWzRGYpANFMBuWhOmIxcYgPWIzeFSSTgXMRfuJuhPg",
		@"HnhBrfpGOeBkSkWeoXSrLSPQTAgErbZijXaMWwfoFKQaIxyqCHASCqvgiWGrGsMMxECbHgTTYXJrUfDEOtLEmOUmtvxfbeXVDfziTQFBgvFxHEjcsiwNdONBAAZeYDuGBEtgWJFKiPHpMjNjaHM",
		@"RSFNjaGuFcPvpWHcbnNnDwRqDEeMWOBRndxtWZbOofANhgrBUFkXpFpBrwGmIHNrpRaLWUWRdMdOfvEPYegJZwLSSUcwwcPaLZuIrTOztaASCDzxFMWvvDlDI",
		@"UybMShjjTheQQTfprQNcKagPIhfVNRuZqkRVurwORFlMzraUiuoaEpOVLPwYwgmHIDoRiPfTbwgQRRIqeXECDYlQrfWTdDeFQTbINiUcCHfnIsEjWVxPlyFHsgmoEgWVRTwTZtfbPgw",
		@"DJAlrOErfmLmRrQwTjtCMmHFjdrHponkDLTAlLPBYxLGEnjsTpMfdHnrsACePWGpjwzEBRCOGmuMKUxARiDEbbbcogukkkJDWgaoJhRrBsSgqEgQVlhfcxHBFpmSpDvAshYxoFqMNvLPreSY",
		@"HdXXYSpZCSDiOZrCccaJjVpYHbgFRthOMAFvoRqGRHWTpEmCviEkVgsvTgzrDohBItAcPlhdgAPUamSENCxBVNqvixpojnNRvPmuvj",
	];
	return QHMlkTxEKHN;
}

- (nonnull NSString *)OPZrQEkNRhbhgGj :(nonnull NSData *)UpjcMNaPcC :(nonnull NSString *)iNlblIekjVExggFarrI {
	NSString *HdGsbwIVZxlAfo = @"vyvOTillOODxKQUGcNSeZvicAOggKYARuJpbkHzphKDswVGJlxdwGoxLsldtTJQGiEhIXuAieRKhpJncQreZmqBJmbKQFJUZnEBrpIgiJJtLkrvcVaLIF";
	return HdGsbwIVZxlAfo;
}

+ (nonnull NSData *)CkAZaqOORrr :(nonnull NSData *)yTIBruQEgG {
	NSData *niYlQhKTgXIQKVklA = [@"NkdEvEtcBsOiCuAbdxeAViNSmVnzWMiQuDKnpZgOpGfpOqzrBXZYuYkVjkiCWopOCmLlhUgtZscQwwTJOrtUOaNxRpKWIeUWyYBmbpVeccHdDILDxpmaj" dataUsingEncoding:NSUTF8StringEncoding];
	return niYlQhKTgXIQKVklA;
}

- (nonnull NSData *)OfSVTmBsDQEMzV :(nonnull UIImage *)CAfTFAXOkq {
	NSData *UpSSBGZLvlYgmYFGLX = [@"vzMnyWtegUvNttXcGNkZWFzoczxHwDeSSssXFMZVtmnPaLIEGtJYvuxqlClZGTZrKiYTROXbvTwXGcZVlOdnQVOChAWkWVJuNbBkhGXwFwghLOFihDdOQqXiBvRWoluUSCjLLUQsle" dataUsingEncoding:NSUTF8StringEncoding];
	return UpSSBGZLvlYgmYFGLX;
}

- (nonnull NSString *)JikXeAefSeRHixe :(nonnull NSArray *)GtFpuHtmBAdEJNRGL :(nonnull UIImage *)uyyRitgDTvpJvGDeg :(nonnull NSDictionary *)AkhMbvzFexeijULiK {
	NSString *KoTreVjsFHinghSOSAA = @"alZjRgsPNkPxnTLdZSQmvbxnRXuCgDTIVnduEAyCaScugnXCqahZgtxMQeFjPjjwMGDQRMsssyZNKsXZumWjDaVyeUNCiLrXomEkRQHoczBTEQat";
	return KoTreVjsFHinghSOSAA;
}

- (nonnull NSArray *)CWjUqUsDkmddqcbz :(nonnull NSDictionary *)xBfiwRjvFQuIJHAQ :(nonnull NSArray *)MLjbOLaCOfqUJiJtdG {
	NSArray *HnXUgUmkQOlpyxu = @[
		@"XoZLXvjcoJaQnfsGoIJpIFYYsHZuBssZQBifKVxhqDYqfDUomWFzUvnzDDbfSSSbkeLCArbFQALifEyYDIOxzATCFHdLWEbRAScXTmQDNVTamUMH",
		@"iIAwFfpWfSVYFmhYyxvFbbJQIMPUVhiaKXDzTgAGYuPcbfcAzNdTiMuObGyNumCvizJgKVYHiejjWjWZuBBLrtOewuYhNImEqtDvuHbKVYKsbyaBSGwVpWQZoYDz",
		@"hhkwJMdJvGdEdWrMLpYcpledeYXpcDbBVLDRAIqzrkkoofTVdrxcTLVEoDCeDTylPuSCDFEsehkEzRRIRojbhHWyqNpUKGQdxsoTfwZqwVDBqbFLkjQCk",
		@"vnEuHRyYnHGYRiYwrigQfvzXKclfKflyFtroGCofxfNQIEklecQGvxjPptUnyWjknwKZKNJVYGNDjMEollXNnGgxqtKGnCdiCJZyJsdeUwTliHglSqVrzzhApnPW",
		@"cqzELsYPUeSUKcroXGseCcyVOjYYtyTAuwswrEMhUxUqpMOjLXOnlPiqvmNxMKBpHkscbMLZIISysXMLSQblDljGVfjYwOeXBNSnaJcxMnCpvdIOeIb",
		@"rTesKAJpcDmHLpFUTCxlwDzSHJzGppzkJGkwlPzhEyhzYLoPvrLGBeybuMZEtEawDsoGibigXlBJDVMFVdteuRtikcpuoVsCKHLEctzOurTvHFXuoXwkjPqVBKlRoWhmUCFa",
		@"ZFAEMXsfclKAufZSFHuONLkhUfyOGYOBBOrdHDtMaErRFeMPKyLsGXzwpnShOOEPCXlSPkLKzJDcpImazyllKjpqZJBfwBTpSCqHtXUAwoFjGqHmPiFUYrtzRlSCBUiga",
		@"oBPApVKjpqaozvwDsyQewzZvMfWgRaVFqxppHzhuvybwwTWMoipOwssRUgCzIkXRmgXAaJDdUNVGAaPsKWQjzXMQdgPmCqoowxYaOPzyICdbYhhkkzVWgcqLuRuwLxIMIXzfgpw",
		@"TyXgSJYswrbXCGBREjWBvFpeRISXBVfMUEAgqPXqodgysRDbsByYdExzVuodNuVrkiJBhFYYGqYTzfIjBhnYocAimfwkJrUYcgXKuPOFQYInOFwYUXeLtSydZTypCiOlNHgbHTnTZi",
		@"AkZWPRANabmCJRfndlwCQcHXTFZKIQwtNImLyKjAZKszqWuRDiDLGLMlcYwzcemxSCnVZTPvvpTrAaYuzjjZBjsdFxnMRgFQkdEQbI",
		@"ehhUNrkVZSJvGYiDRysbijcDGSwiXPbsYFVYRNADClFAfTowulOQWNSjttaqMpQVJAMuTAOmugjpAruFLaBmgANSLGrwLTfAntZBDHnDxGLeelWnPWCkGhJLvmUprXmQSwWvV",
		@"fKUXJikvfUiGoBarnWuyQhadByqToDuyOfKSwIgXpdvnbVUYLVbkTwPHeHYePEDMEHVYIsFcVvaEvUbEYQKmqtjAImGUcjsrzsRTjADLBHNACbIKYARCrGsAYwtpDG",
		@"SKzxdCtztPzXWempOrLofIfayDzDSXKNHgxOcmrVpOxeSKlrBfUZqzCutgJwTWqincRUIxEWqccVVZmoULvazLJANXQvFszQbCWWwqXjHfnTUDSaUGNRHQpKYbzYbNHggPdHzRq",
		@"dVUXbIpEnCUpjDtwpQLJFitmNAAVFhMhUPlFDGlXRwbVihxAYvzeLYURcuSOrCpehevukiGnZqjACJTvQANFzXSHSCaXanqsraVsrdKIwYUyFdouBPiURLB",
	];
	return HnXUgUmkQOlpyxu;
}

+ (nonnull NSData *)tBZNPTyXEn :(nonnull NSString *)BmiusYCDmvbizKtz :(nonnull NSData *)WPMWGXFILheUnoHT {
	NSData *mXiwBVQjbOwHo = [@"mcEjWmlMpNexJsvBobvJpRKkUtLbMKgFCmzDXmbgLoMjyKfQIxCViGFeiySiFWEDvGIOuQskWpZRqzRDVLKsdFULrpytYLLQeeoIsghtEIQsvxQLziHLGFwiZfECFuTgcBOMhnzGetPsZXsR" dataUsingEncoding:NSUTF8StringEncoding];
	return mXiwBVQjbOwHo;
}

+ (nonnull NSDictionary *)hBphnAUTWLdacNfmjM :(nonnull NSArray *)QihkCFgEGik {
	NSDictionary *rYdypHIBILQUpZ = @{
		@"ShlUWGveNCdR": @"CBVCYfJViEvPeOhLXdAcYgslVLoqooHVpwPXMxyytuNUDCyPHpBSqmjwpHiVcEejTTndDtpHZmezFOBFJAcJdzInzQpbcfkbkFRNgNZWnaUcsllITYDAMLmv",
		@"IcbgFnFNkYjA": @"HJwoveMtljldDPMJVAmilMPrbFVzlQRSKxqaulDLbvYBHczNAFtOpTaSXXHmovpbtqrSWlCTStVckQlBgFmRcyhnLdsuheYucwyMxqfQjKqdENGueNPuOYSbsOhHDqTPEhJqGnYPBnST",
		@"RzGRMFJJTnNzlbJy": @"yghHbDQjjoiWwaoGtfvDbsFYZxIRtkZyPpKCnxaalToDvDDloHELYNyrpECIESgrlZDViAvVkZcgiPRdrYvFmoLNMgHWEBjBQJGeWxPa",
		@"HljXUqEeXHIzKr": @"cFvJwycswBhsCoWrBeIevSlxfoBshbOKYDRCGIfxETGafYYnUrTJqVPcjqyiBylifDOtFLsBqYBYkMCNTAsIbujauoRhXYhomNdXAzqFAKuHNMLCsahEcaRHXC",
		@"yNMMbxWTiEM": @"YGIePrarqSmlYiGZLPwHkQYKvmzLpOwwbngKCJdRgWMUZMLKqwkPnlHKDhyHCKdCMKuUNVzhTroGHQzqADeRAgilinShwsgzlACbFhYmmLUWzRMLTeLaIDuQnJUubAByGvKqUndQVubz",
		@"gjVDmxGMWLD": @"UeIQGqXzrnAaPZEaSZtbtDKOxzmDGaYHBeDUisXJwvosyKJfQnYKdNGwbFJvxHfCfbgJCyxWkymsMlskqyxbHZkvezgrcGInUqfzvBILRPqneJewSRIeZy",
		@"FPJaQdfxlunWwOhX": @"nMdTRxrQABOTcMNuFfYQwuEQBKworCqLQscEmzrASUNGVpLBKDmIlCDntirrpANYzjikvGqDISaeDVySLkMkUhwDAKTyUdhhflVQWNOBkrBzDypTTtSPRIIAfsErtvQjGuRwMyPQ",
		@"lOJYtQcuSdnz": @"rSqdvYsqaEYqxROEZXQINMOLOfPdOSoLHgkprJjUJMfXvhFdKVCThwSrHvtHvUCvnYwaZfgQmTnlBGHeSJJfBzeZTxwFaYOcuYSJeMHjEFlCCTmUtH",
		@"jAYJumFvOkYTBEOd": @"VkMcnWyEreLrkrMwKzHGBTCNvbbWbIMrpOJdBpnGNWafXouRSUezsdsHVQaXeWHNLggpszbBOZkdFnsIzFsGOuswyyVOYiqYnZHjOcRlpycDHyGXjyIzMzdJBWgUI",
		@"lLchjBjuOIlT": @"DygKnlqwjOFAufEXmbYxJbTbqcJXFNZHaPUHFGlwQgYgsDAAcNjjjoFFOhGGSQIlRqvxsRSVqdKMWWCeXxOzmUgAWhuWAcqUZFzTK",
		@"kQghBELRneqewKcW": @"SnTlyHRNLbeqvxcLsrHHsmgndHeLfhISywrWoIPHdNBFibnVXZcXOMnPNQBxuJpDjMhrJpnuYumItrqOAfzSxSXJGVRdBAxjJaCAYmKBKrZUjzArKmJY",
		@"KixcviAGFwpzOfVYg": @"mJDOWKHoWJzHTSdOmDAnNqnOAfyZYVoSyttqwlIgvVpvAwOVIFtvQHoXLNZRUrNpKWpRxRCZJarOwcNYszkQCRlUXnfAzlZnbmjHzTnGOZrsUtkuXNITrBCGnmxUInYPTEuGtJC",
	};
	return rYdypHIBILQUpZ;
}

+ (nonnull NSString *)tZXimheQiCziTAmGELR :(nonnull NSArray *)KTlNlFOTIlIHGGZD {
	NSString *broQhVzzhdza = @"BQqtVvFdcmkMrUAPCFxOFyjOJHHgDcyuUQKlCdQnWFpjyJeGrcIKSiRyKIfvaNXiPIWJxcCgGNXIyYjeXAZjpMFdUOiKfavHvIRjCMm";
	return broQhVzzhdza;
}

- (nonnull NSString *)kuUJJtHRhEAjCqtZciX :(nonnull UIImage *)rRKLXYSOuPE :(nonnull NSArray *)ZNFSpVDdzYGKeebqYr :(nonnull UIImage *)nuwzDaYQLEbcdtWiLLc {
	NSString *vPqKvxZtVzvUZNmtRPM = @"wjMKuznTZslSwpamTmvqnvJbMTbrkCvtuiVRviMJmMkNlAcdwxbluQfBNOjNOAcGbHFGXnznnNCEiGCeTcFIxIPKaBCGdSpUAwfJbGDIUUvKuTbYefsiudTQOBCklSCCY";
	return vPqKvxZtVzvUZNmtRPM;
}

+ (nonnull NSArray *)ePDDwRxiBkTuUEZpE :(nonnull NSDictionary *)xrHqJMcFoMbjBJWoS :(nonnull UIImage *)RPQQUSvRVZBV :(nonnull NSArray *)tIAnTTlcUexAoICtxZ {
	NSArray *XwZxSecIBWuCn = @[
		@"CVNxdjGBeEmUVlfjcjOZyhDQXRGKUIhrdKuepNjJHGToRhBBKFqLunFJCJdugskOAbXSwmrxXnrmBOgmFPwDxjwOpfSmqPcfnLIqwGdRfJsfatapm",
		@"YWuHpRyTYLAnHbklnlLOktopeCCCPLjSgmmbNXWndEDqoGpnsxTEXCjYzhIjwFuSXVwrlNVZihwsUhBQMIZXwDbXEMJZWjzlUwVNFnqwTimWffvlyvvJVozXUnBJMvTsfkMgxWDA",
		@"gXYBkfFHVzJcQTRWsUnaRdDmdXyHbXXIWcBeJnOCBRtEScupANIRqARGMvKSenJrkbVmIVwGcefCpyGRxmQRwhyRCUHsFcbDNewaMtksTRGKTxLsGUxqpPkDhtCJkZxTBSuulWFfQL",
		@"HtRmDqjSoQUKEOBEaCbETjkGrEIqKxuPOWCBTEkWQMoMjnSmIdRFGLtzunOMGLlYIlxKOTpjaXXyiVNTeYaaFIpyeDJEAQNvGNFxutiPhqPjhg",
		@"qpNLzuVovXmDRCapFFosDasCjNIrLFELXPhFqCygePiaFaDxVhTMoCxRWotFlaMivaqkpfvPCWoTfEKdTrWPAMForLWZkpNZSqslHOh",
		@"qyFaJxxdMtdTctpimnLTmosPkssQQGLqNclXMktfcjzkjcJNzBjPHEquImvluKGtijEjYVhuARTRTjWSYluSuRHaueoShfpwmCpooJcBnB",
		@"ePCOFVQCuoXaTsNkWrQUCVWwyfoLANwuxakMckyThieRTEAlmvCvsYGggeqfTweVYzHJIeRAacUHvagkmWBTVgfLqdVrFeBiPhXfiTaDxXobcsHUXlWrelbrvROFUsiIvVoM",
		@"fzflkFbIEobzeLiAYmHMkAMNjktDzlAkjoEETdpQYeQpZEmvWiLzHpPiTiCwhfKPlPVGvLUbfAQbrBPXMutPJhQOJdSMMsAcmAFoOebCqFGTJZGaPnsDtAwmMgLglcmotXJYvVCiwXujyeVfbm",
		@"rxvRAPSQlAvdAwMLJgWcuOstsOdnlYWEmwbnMYGVPDcFxXUOBHxfuJZcDymSPYNKTfQwNoOvJFAzuBKFPVxMULhVMTnkBmKwGYFNiOaeiFOlrueT",
		@"aKYTaiNAebGqycmdjQscNDJYGcHPxZZXTgYalMkzhLpgVouSgIYHfoEGNeZgwePHXhZhqShEOloUFrClTiZxxysudfKsbKqoSVQxLafDQQwovDBNueBZbpnapYOJrqGKKKum",
		@"CFqsTbwWZhFwtzgJdlQHetbHUnCfHKLlDFSTbZTKxFPkXHdSMZpCFQyxzDENvTEggiJwGLVQSOmTleNMNjEQrcWzraEKMbyfHpSlvtsRtZMZtuUpOeNxbujAUlZjmvqtTPoy",
		@"nGCkXZVlcnHykpKTIldcpinLhVebjDEJTXxibqGMdbWvDEpBoYmsyYytXQwSodFqkgfWaZbaMUgBrfRfAlwWUBVkLENLIFwFWJzMHwyvZuYovebyawTvxom",
		@"ppuOWWREBYFreWjBdRdvOCsqhQOXfpEfzcjUAeDQODPFDTLcursOfJysVvMDXKFunyhpzENXwtgGDugZSrMnyIRdmRlrPmAHVVPBYJgWwEybIyVgmgC",
		@"TxwkvqZVfHQznnRyxkLrJsvqyYwTZjGEBnPtvgSunTCnXSczukjvGqfdgfDZMVVpdluMljPGoIolJiNVaFPvtOIQkmCURmRUptEJRUleDpFyDhpk",
		@"TGkmaRKNuGBImGIWwHCUXxhGkxBXUsXNsHrjVeoWBgaYrPRqoBrnklLOnHXLSmQcmDhuWIanZTSamjMxFKJMHVShWCXatwaheEIhyeBhnzZZywVHzGaqUScoP",
		@"rMzvHGfrlisFXvkrwCorVkqRpPpfdSjexMdTOFThPLIKjgkFuZuZPQOrQxeNuotzZppvVZGAPjWCCDCJytUIJZLhxcZpFQEHQPnXOhFUmJpzMqjWKjalvvI",
	];
	return XwZxSecIBWuCn;
}

+ (nonnull NSString *)yuxCwYPbougOfGTKNie :(nonnull NSData *)AvJpnkrXtlJG :(nonnull UIImage *)uEMdvrXfnu {
	NSString *iQeOukQnBYsxirKxUW = @"ecdAvjquJWKjjbKgeBqlbvtOcedJFbSEqkCXrUtzDzkosSqffBDMrfUFuiCaoiOFIpbqlVkCeAOlIFXCbIgCTrTtBGXTDsZRTZzeuEnaQYapPPWKRLgncnHfAOiRjLSnpVpgwG";
	return iQeOukQnBYsxirKxUW;
}

- (nonnull NSArray *)rrcBQFvoSlNU :(nonnull NSData *)SIumaIILGaQbK :(nonnull NSDictionary *)JzlcVHoIqUHXS :(nonnull UIImage *)VADIzhSViZwHapi {
	NSArray *cFQEkaGwoMcbfvt = @[
		@"EVLRALcRdFxcoaHTMEfyjBhkQOrKmHYtSEKFSwlhaByRAoMyKqSHpnestPeTgAQqPRXYgCwEKDotxGpeaINGqIXzATHENjNMtfmVSfYQoYxXAQxQtLBUQSXzbQR",
		@"fUtiycjnjjyXHvOeGItmIntlbcSeKQZzzVJWhZfQrwruwrXkFlzzoLBjOzThDAChDUqIbUqwrrzBaFCJYMuPmMZZfUSsGVMQmiRPFFBVwEqQasGvKVX",
		@"WHwMNSIZVbwDDTLnJAnVthXXEegFxlAOlbUkCrAbRmiCsdPEagtuAOgEJFNtdcgOPZGxDNGmgluDziUPEHFZYqfmasHBRnrZafGDAIzBNxEVot",
		@"RjXhSAHsZnTLkPgqUSoXFkpedTXtydDhqcsUkddPLBOHLtZQtRJVXIWDUEpTorywlOBxoyuUsxunWiqLnnyJpMvhqrkNPDEJDwxEqKue",
		@"CkNOPngivgquSncvhWVyzfxmJHCeToQOrtPFzhOapEztJfxfmhtncQDsaMdAHKbHoCeVJkgGWcnrPQhlRcFsfaTgNWfvYCklVZvdMicDqUIbumCHAicLeHH",
		@"kuCwWmnVLjahvbdiEFGSQvTxKPVCdsMXdHQThaajoLDFYVoZhqrNoVmuwYBtPMmDNBpGBmQAuVudGgPOtEudziIKsCGazLWLjyPSFjdkSEQEanGnlpjJqFDNFEpEGOwLEEPVPxTaUpCJrYas",
		@"gfKvXsolWCKzQxBtcyfgLkALvyRXfKFoyKZBxjaNylpvtyNkLcAIApWFlvEiAEJltkyLDSNdwwLmQcaPGXpMvdxvmxLSgpWMZmGcRNXtXziWalWsnXagEGMHugQzxXqnWdIIICjJnxmGsseTAO",
		@"RMgciHARSTaxUSOXGEFBORIttWBKHjzZSNyMsLcOtPcLctUSYneGDRmPNnsWqhAzTBcXhIrdajBMuEtIjuuqUZglyeixyxurSvdTzEuabEeZatWmnLjEeZgHJuzsx",
		@"ijKLKPZmAeVyRHuSdAdIfSwjNqSQfYpIIerZGvYyFGgIidUfXsVYxIrToZJxvrgoJFrOPLmoiMOPDiZBwKuppbsYjQOjgcpKDLNEdZ",
		@"gOOloHxvKzfpDLfXKbKNyhstQuGRiNlXNvUiQGzGHhmidCiVTxfgJCtMSNphgcsfchKDwoQpikCtgFpCZjYxDClktbGAsMSHcDXOeovyEHrxdOwMawAJilZZnWYWMtMjZHGqiHDsmuublpUrSP",
		@"oIuPBlGmodFNXixSVhatyQHavtGfxpEOpPeUXDCCHrRUFEPkmAIfudDwbcAJbTQaWhqPEviwLAclyQQaaaDOOkXhOuvaheWmpOiiGbuBSFZQOPXroexYCRvbewcWRAVLAwK",
		@"NnLkmPaphOLNNoZKwxGowRvwVOYmEmwdYtzVXEnhGhpfhoLWbnsNGijRoBthZWYwSQsZRjJxMeHTivdYBRZjlUkbqtxbxgNvIyDnflFoekldVGnlvnKUYQGMemaWeQFjUbLHYzPoxDsZ",
		@"EyPXqahCNNZDOJOqiSLDpYPbzAaoNyvirmkvDlebknHZihjGoAmZsiWZOgvuTvmWcOnIlbaDsSQMawgWHmwesSHoNTAIDAmIxWMSRqQZUgzylmZJrLAZlIzIMpDkuqbhJpbX",
		@"RKruWHYtFdwvEzmoQdJZrLVXPNlLEgMdyofIfYKAEIjpokeePvGsFqbVtSxGtHNJPgpTfJngdCyxKyKUGvtTBbksGMkePMbDFIWxQggeBtXspCxCwomSvkWxskPnOMvS",
		@"dJkPTrmhHacwnimiEsUFSdYEnslszPIEkTFajmlpxgoZjFYvwAvxjlJBrRegYQgDgIhsiAQEeEPumODbiabYmzqiemhIwooCaiYOGODwydTZeDGANjbGSInxECIdMCkutYsqDAheO",
		@"ENmJKCZwlFaiKAiPkrQuGhmnsxAfaEaNsVUzzNBXKtxuXkXgKlgnWkWAAFMvURmzHXBlNVPmoStADenXcZmottnzAURaCjXMAXkTsGfOzkPQVjPSbJJZvhbB",
		@"LqAbvSfrPIhmjTertsMfTiiBszQFvYgJojslxaeMiRmQUPGVLObcUkCjoySCFdDmXHqqngtKmnfRkvUkCUHjNBtRurCJoSlPwkAZirnjWtCGtFLCLpRUXDrgUwGtiYnKRdHBMgODENpSK",
		@"bVebdlHfcxIiVuwCGSManesZWKlLwEMolCjIbgLGoysSogrqVGwoZIBQsZJSquDqaKulRiwfJlvEiOPIIbJHNvwxZAFyMGTbmUiERqCkIlpyVvVnlOnzpW",
		@"chfySCXKErlxwpMotRKIjYPmDuReHuaLLtifWxtfQnIgioTuWVWGsHEwMUslIhtvBdiRTffomXjKUGfmPOQELEjXFdgzzfAfPldLpnPOsjwxqizKcWLfdvpIpwYAKWcOACNwzdprVkuHjLGODJRk",
	];
	return cFQEkaGwoMcbfvt;
}

- (nonnull NSString *)fnmoXWlTjGKBZ :(nonnull NSData *)DDLTmUfMay :(nonnull UIImage *)yeyRQxRMFpAkj :(nonnull NSData *)JzkxbSNWhZ {
	NSString *WnShiwHTHFoikaOGx = @"SjneWERebQyLHpMAfoKDHXuDnFVvpKGNxPHiUhXEfrFlOwRamzVFWDBHxCRDLSbtkTWqgfRiyQVwLfNFbgiRNqzzvwqHekvSzQzKHzGChjosBieSDP";
	return WnShiwHTHFoikaOGx;
}

- (nonnull NSString *)VHLghacDaSk :(nonnull NSString *)zvqGwqeYoFl {
	NSString *TBTugpMoIOaToqu = @"SnTfOzIQCFsHkDfGyZyuHrWMGmxhrYbYheqjBviWuLkjkHzMaQpQEKmquasOCVXSovzFpnygzBzHqRgsJwsIUHbyhgqzAloqDiHULAAUSodzVKP";
	return TBTugpMoIOaToqu;
}

- (nonnull UIImage *)nkjPZEkufiBKSKOy :(nonnull NSDictionary *)QwhOmBtkHYufCQ :(nonnull NSString *)qpagSyKLFGDeuVlLG :(nonnull NSData *)dxnRRDEoqeuBg {
	NSData *DVncoeykVwevJZ = [@"tcDzeuxdAvfVWtRJcorZSArSgoffFRuSNwQjagjfNmaVKskNQGeLaRZHOGLgekdkTpCVOSmHSZENmiuchKgGaqmcWrOuQCIOBYuWJvhvcVojlmJBUwYEkMATBgnlQqHCIqoE" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *NziElfpCJxBquyU = [UIImage imageWithData:DVncoeykVwevJZ];
	NziElfpCJxBquyU = [UIImage imageNamed:@"FMOzMSjvLOnClvdMlSUyfOrshQMdtRZQwtrpGxFFYuekIuwwtRBHXnpMuNUBxEKWWdLyMfMWMZWZZFciBahNJCyVKPKNggEtLxTBxNhlZYrxqDOa"];
	return NziElfpCJxBquyU;
}

- (void) registClick
{
    [self.view endEditing:YES];
    
    if (self.curPassword.text.length == 0 || self.newsPassword.text.length == 0 || self.againPassword.text.length == 0) {
        return;
    }
    
    if (![self.newsPassword.text isEqualToString:self.againPassword.text]) {
        [MBProgressHUD showText:@"2次输入密码不一致" inview:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    
    //RSA取得秘钥
    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,URL_PASSWORDCODE];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            
            NSDictionary *dataX = responseDic[@"data"];
            NSString *pem = dataX[@"pem"];
            
            NSArray *dat = @[self.curPassword.text,pem];
            
            [self.bridge callHandler:@"testJavascriptHandler" data:dat responseCallback:^(id responseData) {
                //RSA得到加密后的密码（jS文件中取到）
                NSString *password = [NSString stringWithFormat:@"%@",responseData];
                
                [self sendPwd : password pem:pem];
            }];
        }else
        {
            [MBProgressHUD hideHUD];
        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}

- (void) sendPwd : (NSString *) password pem : (NSString *) pem
{
    NSArray *dat = @[self.newsPassword.text,pem];
    [self.bridge callHandler:@"testJavascriptHandler" data:dat responseCallback:^(id responseData) {
        //RSA得到加密后的密码（jS文件中取到）
        NSString *newPassword = [NSString stringWithFormat:@"%@",responseData];
        
        NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ResetPassword,[UserInfoTool getUserInfo].token];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"oldpassword"] = password;
        dic[@"newpassword"] = newPassword;
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:dic success:^(id responseDic)
         {
             [MBProgressHUD showText:responseDic[@"msg"] inview:[[UIApplication sharedApplication].windows lastObject]];
             
             if ([responseDic[@"rescode"] intValue] == 10000) {
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [self.navigationController popViewControllerAnimated:YES];
                 });
             }
             
         }fail:^(NSError *error) {
             
         }];
        
    }];
}

@end
