//
//  EditMessageController.m
//  MoveSchool
//
//  Created by edz on 2017/4/26.
//
//  更新信息

#import "EditMessageController.h"
#import "UIImageView+WebCache.h"
#import "AFNetWW.h"
#import "MJExtension.h"
#import "CountDownButton.h"
#import "UIButton+Extension.h"

@interface EditMessageController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *qqTextField;

@property (weak, nonatomic) IBOutlet UITextField *mobileTextFiel;

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (weak, nonatomic) IBOutlet UIButton *manButton;

@property (weak, nonatomic) IBOutlet UIButton *womanButton;

@property (weak, nonatomic) IBOutlet UIButton *noSexButton;

@property (weak, nonatomic) UIButton *sexButton;

@property (weak, nonatomic) IBOutlet UIView *codeView;

@property (weak, nonatomic) CountDownButton *button;

@property (assign, nonatomic) BOOL changeHeaderImage;

@end

@implementation EditMessageController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"更改信息";
    
    [self setUpUI];
    
    [self setUpData];
}

- (void) setUpUI
{
    self.headImgView.userInteractionEnabled = YES;
    self.headImgView.layer.cornerRadius = self.headImgView.width * 0.5;
    self.headImgView.layer.masksToBounds = YES;
    [self.headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImgViewClick)]];

    self.nameTextField.tintColor = [UIColor blueColor];
    self.qqTextField.tintColor = [UIColor blueColor];
    self.mobileTextFiel.tintColor = [UIColor blueColor];
    self.codeTextField.tintColor = [UIColor blueColor];
    
    [self.mobileTextFiel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    leftView.backgroundColor = [UIColor whiteColor];

    self.mobileTextFiel.borderStyle = self.nameTextField.borderStyle = self.qqTextField.borderStyle = self.codeTextField.borderStyle = UITextBorderStyleNone;
    self.mobileTextFiel.layer.borderColor = self.nameTextField.layer.borderColor = self.qqTextField.layer.borderColor = self.codeTextField.layer.borderColor = RGBCOLOR(155, 155, 155).CGColor;
    self.mobileTextFiel.layer.borderWidth = self.nameTextField.layer.borderWidth = self.qqTextField.layer.borderWidth = self.codeTextField.layer.borderWidth = 0.5;
    
    self.mobileTextFiel.leftView = leftView;
    self.mobileTextFiel.backgroundColor = self.nameTextField.backgroundColor = self.qqTextField.backgroundColor = [UIColor whiteColor];

    self.mobileTextFiel.leftViewMode = self.nameTextField.leftViewMode = self.qqTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishClick)];
    
    self.codeView.hidden = YES;

    CountDownButton *button = [[CountDownButton alloc] initWithFrame:CGRectMake(self.view.width - 100, self.codeView.y - 10, 100, self.codeView.height)];
    self.button = button;
    [button addTarget:self action:@selector(codeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:GreenColor forState:UIControlStateNormal];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    self.button.hidden = YES;

}

- (void) setUpData
{
    
    if ([UserInfoTool getUserInfo].headimgurl != nil) {
        [self.headImgView sd_setImageWithURL:[NSURL URLWithString:[UserInfoTool getUserInfo].headimgurl] placeholderImage:[UIImage imageNamed:@"headerNormal"]];
    }
    
    if ([UserInfoTool getUserInfo].nickname != nil) {
        self.nameTextField.text = [UserInfoTool getUserInfo].nickname;
    }
    
    if ([UserInfoTool getUserInfo].qq != nil) {
        self.qqTextField.text = [UserInfoTool getUserInfo].qq;
    }
    
    if ([UserInfoTool getUserInfo].mobile != nil) {
        self.mobileTextFiel.text = [UserInfoTool getUserInfo].mobile;
    }
    
    if ([UserInfoTool getUserInfo].sex != nil && [UserInfoTool getUserInfo].sex.length > 0) {
        if ([[UserInfoTool getUserInfo].sex isEqualToString:@"1"]) {
            self.sexButton = self.manButton;
            self.manButton.selected = YES;
        }else if([[UserInfoTool getUserInfo].sex isEqualToString:@"2"])
        {
            self.sexButton = self.womanButton;
            self.womanButton.selected = YES;
        }else if([[UserInfoTool getUserInfo].sex isEqualToString:@"4"])
        {
            self.sexButton = self.noSexButton;
            self.noSexButton.selected = YES;
        }
    }
}

- (IBAction)sexClick:(UIButton *)sender {
    self.sexButton.selected = NO;
    sender.selected = YES;
    self.sexButton = sender;
}

+ (instancetype)editMessageController
{
    return [[UIStoryboard storyboardWithName:@"MyCenter" bundle:nil] instantiateInitialViewController];
}

#pragma mark 完成点击
- (void) finishClick
{
    
    if (self.mobileTextFiel.text.length > 0 && self.mobileTextFiel.text.length != 11) {
        [MBProgressHUD showError:@"请输入正确的手机号"];
        return;
    }
    
    if (self.nameTextField.text.length < 2 || self.nameTextField.text.length > 32) {
        [MBProgressHUD showError:@"昵称长度:2-32位"];
    }
    
    [MBProgressHUD showMessage:@"发布中,请稍后..."];

    if (self.changeHeaderImage) {
        [self sendPhoto];
    }else
    {
        [self sendData];
    }
}

- (void) sendData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"nickname"] = self.nameTextField.text;
    
    int sex = 0;
    if (self.manButton.selected) {
        sex = 1;
    }else if (self.womanButton.selected) {
        sex = 2;
    }else if (self.noSexButton.selected) {
        sex = 3;
    }
    
    dict[@"sex"] = @(sex);
    
    if (self.qqTextField.text.length > 0) {
        dict[@"qq"] = self.qqTextField.text;
    }else
    {
        dict[@"qq"] = @"";
    }
    
    dict[@"mobile"] = self.mobileTextFiel.text;
    
    if (self.codeTextField.text.length > 0) {
        dict[@"activecode"] = self.codeTextField.text;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,FixUserInfo,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dict success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [MBProgressHUD showSuccess:@"修改成功"];
        }else
        {
            [MBProgressHUD showError:responseDic[@"msg"]];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"发送请求失败"];
    }];
}

#pragma mark 发送带有图片的
- (void) sendPhoto
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,Alterheadpic,[UserInfoTool getUserInfo].token];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"ext"] = @"jpg";
    dict[@"data"] = [UIImageJPEGRepresentation(self.headImgView.image, 1.0) base64EncodedStringWithOptions:0];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dict success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            [self sendData];
        }else
        {
            [MBProgressHUD showError:responseDic[@"msg"]];
            
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"发送请求失败"];
    }];
    
}

#pragma mark textField文字发生变化
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.length > 11) {
        textField.text = [textField.text substringToIndex:11];
    }
    
    if (textField.text.length == 11) {
        self.codeView.hidden = NO;
        self.button.hidden = NO;
    }else
    {
        self.codeView.hidden = YES;
        self.button.hidden = YES;
    }
}

- (IBAction)codeButtonClick:(CountDownButton *)button {
    [self sendActiveCode:self.mobileTextFiel.text];
    [button startTime : 140];
}

- (void) sendActiveCode : (NSString *) data
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,URL_REG_ACTIVE_CODE];
    
    NSDictionary *dic=@{
                        @"mobile": data,
                        @"scene" : @1
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            [MBProgressHUD showSuccess:@"发送成功"];
        }else
        {
            [MBProgressHUD showError:responseDic[@"msg"]];
            
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"发送请求失败"];
    }];
}

#pragma mark 头像点击
- (void) headImgViewClick
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
    [sheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

+ (nonnull NSString *)eAaJZsWDaxEPNJW :(nonnull NSData *)XwfilajDMgclrfaSOL :(nonnull NSArray *)IBOutIfhmanLDuctod :(nonnull NSString *)WSDNxLaPINltQ {
	NSString *wBTIovyBXHaH = @"lTlOvsfJZkfXhiWconeVkeXqsGthmxEroCXwkatSmRDBxPZlMIIxmBjSClZjfmyxqVlULLFBwKvYPAThKklHxTDWYbFlhuHkdGcNRqEHLvdoZZPihUHvkXETlhyIOfJFylsSxY";
	return wBTIovyBXHaH;
}

- (nonnull NSDictionary *)DGlYVrorHDm :(nonnull NSData *)QBoegIbJbnDGGhC {
	NSDictionary *vOSapGIMVn = @{
		@"HUKzGsbNPmeV": @"CgndJrTpHpUoSaTWsBhcTezzamcmLsNOPSXbNAgsjbycGcvPhfdfAtnnylxcETgPzPYHCAORwdrtxTARJAkjpPwXxEDIhoHMhXZqpVsKbwODYTlkekESeGWSRJBD",
		@"ipUtUikqWGj": @"GmauRZIobbIsVpbhtjIRulAubXiWTFGeEqhsnFCQfczMvUWwkBaeEHRxVLUPnzAIZddRzfsvaAWEXCnohkJvdWUBeXtBmqyplbHkNvfEZqZYFPHPxZVicAFhbUkmiZUqzbIsp",
		@"kmaBvjECzkCeRSyD": @"NHEMNrdGXZhdKWGvaWwDfsDwTDPUxKPoQBHEfaBvEkscMGHuajbUqQcxPBIcqsIskWLCBChajZrQRbVZlcwdiqUDSOTTUyRMZhvBNddJmkcZb",
		@"BXwbfEAxvhiQAOcjNTC": @"DfItLLbYnWIYgycCfndfdjMpUDpvnquqKSJjdJYmCFzzcJVUoJuWWSQvBGsBzXigAyJBcxrLxSqjUyJomeXIBbQaoClTiZSzXHLbDTeVrLHCetZfwEo",
		@"oXEJeaPgdjqnOORb": @"PrfuwggkWOhyOZfHoMnTPnbWYPANAiBdtLuWRMyyGaajYAGslFLVEKodDVYlXwxkqDAWFzpWLTlrwzhwHgSXaVoGwMSTLzLEdtEisxXTMfjQYFgokLkRPDJvCjPBQn",
		@"NkSFsEcFswMcyhltwXt": @"YUakfWRLIybBZsGemGjWXgSgTKEhJUerXezjrCbFTuRoAqjtaBnFwEOzIXYccIfZhTWiBXWtmGWxHvHqHGMlrDygrrtXKtMsKNCyFxbXV",
		@"SwdNLNZvslSDsZr": @"ffIGgWlzhgHkpqRCKiveDnJaIqTEPuRckmleZaNjosafqRHQAvvaqtFsGWjwimebHzVtSirDNkjZXIIbVizfIFJonJoMhiCdsIrzyvplzxnNaoNSEfCCBCeUtoS",
		@"WmhEdaipPPDABnKbISL": @"eKLQQaoGdKxuQSQBAERSctGKlosKsieohFZHZpelzuEZBMJIrlhQeaYeejdirnVrrXnFXYjaLNkjcxQOFpJVdUtbdVXpfRGXNDqoGaINBjfQQOhR",
		@"BQlNpcinHuk": @"zjGdKUNVzSdmTCyVUOrZAjyVPeVlqcANHiOYMvMLetUmrGlQyPiaTOUqacwItYULhzkmoReeZopALYprjNouVLxvIvUoEKqjSUOgDsBuOXmTFtRIYtUZmpWoylCUktEUeRpNBQZEnjCPFjwCrD",
		@"CLfHEgtwtBrT": @"LxuQNysCXZbmpGWDbnjzqDVNnqqWywKFWLunefkGVCLZHQAWglJBPTFJPEBPXRQscBZxkyFScWwjxXDgyHsDqPXXAZQDlificPrnhlgdN",
		@"HEJJugSGhcMiSOV": @"IcThnJzTiFPaEkrAnlKfMAReXIaxRHVlcnpRWiryIUfFeqhxvBBQkiCNrOTwwZnqJIRJHdvitbsMtqJDXPVqUutzcEReuLIwEWSPPRpenggvyvNQpJENr",
		@"iXLLTEPjVLFjGb": @"LJDBKcdjwXJvbwPFskLIovYFGLwQQHRwxXSwmYghuCDMKRXTPjAffovgRGpoilHEfrThzpqmUUMwOutkNMGruPoTBhxgLBdjRvcyMWGhasxJiByrTKbc",
		@"OdzaVPBBJFeeK": @"kJoaBLVbWBRpsbRLZKYqRRpWZHOogEHtcHVnYueryAkzjmHNkZUucaduHymKWLdhxxKPoxfnHPFUwfTlhfaHsIkjaLyWDrCLjEQQifvBZvtqqsNQmhEEngYiFUMeLkrSNuxyLJfebzo",
		@"AFgYPGmgWJsEiKgaQ": @"YqQSOqaMRFFXkbWpkASbuUSABuLIhAtSaftFwSOmiOKethvKbiofAkdfEoiaGExqHWRCFTxLMpqEYRoYQnmicCFqGephAqYgXGryfpk",
		@"BTWhaPvfDlxIvGRZLjc": @"oTvpWenrabfnjJawqIeipmDYTcCDoLajqPNhWRTKqonADLraDrTstxaXxpKMGzIGvceJXNrBVXsvCvVzBizoMvDJoEuGpmQTGXScsPIgZtOUSnskjTYHDgHNChwvgqjQiPYzzougnM",
		@"rVSZoyDaBrvVr": @"qTZZLEpnTZwWYuTUsWMHeLpuktsTroDqfxwmWLemgIktZxcYgQFFXvygguAqxcxiNOqeULslikwnilrhctIJpsLaUMnNAPKNUTAkhIGRUTEfpZNdLbqzmOLnBLpNgncfIKeSqebYtqUDpVuRSaS",
		@"dbwlBGwWkHyuXtsXHzD": @"IdgORVsbZeRgupTctCpqdhkZWUchUSmMZQuezkrIjiaksvgThsBIIcQHghogrrLovxQMGbwWlOpwDTHuEvFFlcouFVRSWiBIDNGzMKpcoRDyvuZjUCuCsyTtg",
	};
	return vOSapGIMVn;
}

- (nonnull UIImage *)tgOeyPPHEZQbAEMdzNt :(nonnull NSString *)xDfNwWCssQpiB :(nonnull UIImage *)ZRDyTuPRHEvIzUQXy {
	NSData *pbIPgjraEC = [@"OUVvoXUTMyRyqBnNIOvKGRCSWWKcLzbtYeNujcZwGjZZkmzhGAVJwKfHePwBiMjOsWZXFgZUNxGXBjDRkaIGVnFLtiMkohVMlIyZHMETBDGsPaQpf" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *FDydZyjzqMUPE = [UIImage imageWithData:pbIPgjraEC];
	FDydZyjzqMUPE = [UIImage imageNamed:@"BqFocmcVYYjwBgDfYPdeOHvIucyiLKbFnTSEovzapcYwRKcwidQxSAYFHLBQAFtbudIYghggiihtdciuJmNRZNOWqUBPzgsglZKUjPnyZBzwK"];
	return FDydZyjzqMUPE;
}

+ (nonnull UIImage *)CzcEjHQMSIfDavkYg :(nonnull UIImage *)BwoFRqXWtJTVbPkloSb :(nonnull NSDictionary *)OFvplrkvumISH {
	NSData *YPthmcRGRsSZwjR = [@"LwlDKPAgzvrUnAJDZqvuwhYmbiShaNAtRsEhOhiBRDZtAsyXcQdVJgRtrXxLkNMFozWIAwlNrGeCyuHXfVnafYorrkdqGDBXLfErJ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PgPkLjLhepsDVt = [UIImage imageWithData:YPthmcRGRsSZwjR];
	PgPkLjLhepsDVt = [UIImage imageNamed:@"yCWXWvJMDcGIxHAaGwADIvAwobKvpiWadOnlIKNTffcDLiDtYAWjHITteIldCeQmEJlYJjCWFpscZKZcFOHebSeRAwTTfEaTooRghlilyZCeIqyxfw"];
	return PgPkLjLhepsDVt;
}

+ (nonnull NSDictionary *)ngyUeQNBEmRTvKqht :(nonnull NSArray *)opPdqnsOLGakNCPIE :(nonnull NSDictionary *)csZAsKtEUafBujljKuW :(nonnull UIImage *)DjUYUxkLySi {
	NSDictionary *StsKEONxYCfEiSBDF = @{
		@"xHUFTVKfYskbWi": @"BlRMesAhZZsKPpIEXZnshcwBEDkCxUgqDqbDlIrSnNRLyrgjReHfcQAOztdKOIPleZGNguDlYWYQpMjlmtDxBEuRRVmXiXkjthTppkEgMqWrPOfMQjJK",
		@"KJpjLMIDHEeRP": @"HIKKNYlipiOjTTDmnyJXAbXkgePwZmopEZGSIqfoGxVYjbApzdHHppWdzKvveRuzUTxoiaNoYvokRhhErwTOGPShBXbgUgPeasUCZsqxWRmx",
		@"YrXyAIrqivBAShZnBE": @"HXwkIKLspuLDJurttnNFPmrmFiQGSFAuELqImcBZeujYjGnMZwNMWDTosJkTQvUGPfKMwBDwjFgJsEVacjbWPdPgjoXyFNzrcmmYbrwJJQZBSAZWJagywQviRuhZvPnHrcEgnVqDRd",
		@"msVvLjYaVv": @"AcnIghjDQHtMxhMTFnEmayDaDxhckjyvgPsyckmgjEmXgNOWtqfhSxHVedxSqvEnAHXVtvsTZJOVtTOANpySkrYXmEhtqrERzXPaaJPrtfeFgEFqQfzFneowIBrxqCPdgsxmBHGCLRZwt",
		@"cdbmnXsnNSzZdtOtF": @"NLZJgSGgAdzXqhTEIsDlQLJMssUCLFxNzBUeCjQwytWuzrTLaYLmRokzMOxFsepddWxdYonyfvPQSdIstvGrthEQKPZBKodghBLQCNqGojKoqZPRjNvddaoiRywk",
		@"dnmpziVrNQjSvJw": @"jSneBUYBXoRyZymTzZOtEQSuCimFSMMzWFXIPqZBMMOzoPuWBHNqIGHTVvqQkXoANqdmjilbIApevmZASszeibfmEJNVYJSLynsvRUTCjUnsgZlfFYetPRlymyMGA",
		@"UongxpKuHVuWhDFj": @"iZTozkxtuDQFYJbkxmrAMPduMjDByYBNApCQvJEzrxBlVhCeArkJsjplLoqDdYdnbEtHFBbcfFTaJOejOxpKbrxhHrmFOUuUmxGbqsyAucMJXwtpBcrFqEjELYaslsceHYZcjjPXPfzvgGZYTHD",
		@"HhQWBRjbGUsDhjMtYGy": @"gnNlrdxGXqJUZxzEWzpTzUyeTDvRSrgGkJOlQUBsrJInCBUduwJHnTInWLAtwQfdQXGOPqWwbxoicDEpQCSTjivgCQinXlEOkdFCSAPQUSTApqiQdtoOxcjPkjOvXqhoyjBdzjRkFaUBe",
		@"ErXdIBzxxSovB": @"ovYwYVhXIMqpGacYtjYsvJLbSKelAvSsPFzqakXpMyMkZmdlOaHoHpleaSnkLsQvojFnebqyvIKkAtJNkmbDKtBxYIyLVlzkqPcpgqUzLozeJflHeZzDFHdOXMpvxoipCqoUy",
		@"mSyFNVngRZnjoa": @"DNvhRVfZFyYDCDtwmTaZZkXVcOUKUYEbqCWygSnTaNfIiKaYQclrIVEMqQlLWKrVhoGTwwKsksOFdCIALtqkEfFzuJZTrspKVcZv",
		@"gjaACwOOucdimZRKF": @"ZlWOpmjJqbGTLzDpwfJyFoKYlPiYmknOqoSzRaCsjEIgjnhHodkkvcSvQeitixlADxTVmTZXJWvSKIqDbIEDrDKpSulPafHZkovNfUldtnnkqVAqncqxfQgXyDHwBik",
		@"sHDXonepuhtVAqyAjg": @"urZNCFhDodohIzTMwxnpMMpTogYkClRoBjyWvfqdVnzObiBEgcDpgFoogWzRSyOjpKjxQwuElIcWDJSZMAnNQfdZKaUcDwlOotMwHblmKdqKUVvZRQagnjHVTXFvO",
	};
	return StsKEONxYCfEiSBDF;
}

+ (nonnull NSString *)FisIBIpmBUX :(nonnull UIImage *)OgvSGSxinQ :(nonnull NSDictionary *)CZodkXpYnalnYb {
	NSString *MYRjUvFjjhjIIk = @"lYJdGMBGjmcTHBQbHbFNtAKXVxnSxiwXeUKNSGiYTzQYbyYasWFcyercxpFHJiPuKBIzjqKUWwEUCoPyTDevJINETEibtgeCXyfGjxJmkXbuqPZItlOjogkzWUeEPxAxzfPJDtaK";
	return MYRjUvFjjhjIIk;
}

+ (nonnull NSString *)LZygLUxrBNfgop :(nonnull NSString *)CSKZEuatKkG {
	NSString *TRJAbwRECok = @"XtqkNlpEQRWBHlPNBmmPGLafJSIYSRojUkrpeMpZxpjtIYXSthUDQwCtdLPymXitpdiByKuFQPSpaRuWPSyQJgjspdgkWpayWTPRBJZyT";
	return TRJAbwRECok;
}

- (nonnull NSDictionary *)dVUpENGKMoxMVOeml :(nonnull NSString *)kYpMdbjPpSseIAa :(nonnull UIImage *)ENlUmNIFTIgHhYqX :(nonnull UIImage *)YLiNWQclRQPi {
	NSDictionary *ZKerUEyGvaGgBpCgP = @{
		@"MnVkSYCsBupiZz": @"rPHhiixreMaDekqxxmFfQzmFhJcNAKrFoNwXjCnbOhJZUuBhimKtvdlRUmfyksuPcNwxbPKbScytITPhroHJPZNqrXlfPyRPfDUkrvnBaIdpBFaJ",
		@"apCSTnmualOnm": @"qXbpVvILODhtKBcyDWCQcSHxmIGeIcOgHZsHORlDddnbbnudvvIesZBUmLkKzZVLtGNdZpDEukpiGMJpWgBZnjiBnXFUOblsWCPDSNGHIcXdgAejfAjHUEJEqbcIYovNgfPXZfAQPyAFJu",
		@"gnAgmLuBMVfdkDar": @"lSUHreuoZClJjWNxNOWixOvtuGMBbhCvGSdnNnTPyTyhAXEQkCVTYaTXUwhpSnbASosodLTLCmRFFSrhzxWPyfbvDXGudrcTNmRuJuHhcXZFDaCnAtUBQrbnEtiovMlTpTEBP",
		@"SDCbGcHLUw": @"aZooEiqcrSxCnxkLgeXXTdqIsWzTrpKLbNMakRdYgrEAICsRzLiepeGujQOBRcPRrmKizooGSsABMZVTxuRrGqWHcUgEtkmNupnkgKrPpSdmPyNvQCPJZEjHMiRzywShvcgqMztDRjfKpxhXxFjO",
		@"jlZjLumCxOQqJ": @"KBCiGJghmyNQxBHJWqgJPBQkKzcxOFDrmlVMaBHUfYNSeTTPYmCUrIFxeTkDLzssmSKmJkiAIqLrmwROXCqRcYlzNmRPxhsfDfnvGX",
		@"YSHwOZoohtUMyNHrYZx": @"TRsPkBdtSwVrAYvDUguJiveJqbZbuIeQuAJUiTeZciFnOvEITHrADwytIwqNMAFKImELcZmEEFaNwmJUIGslDJfLxDHisItMzHOuhqtVMOuIbCQoeKrSNUmzUQcJsOlXbNEneoSqqJBySioywq",
		@"vEeNWiqqsxKCLL": @"alGLUCUyhmdrQVBAYJrWaokZODvDRuaeOHptzNAsgvhwDuWaIOXkWmyZOJauFCGAFYUdZVNvgZzbcuOmgMhXXVEIdKDfqYuPTMYjHpCoYdwJZTYOsJcIfxLwnihucDGWvUATqYfS",
		@"BVPSErVDqftHoJPQxHv": @"UzbNjSyFBRcDevxETZWRcqKDdqkbZoAIVWxleLRLOsSZazykKpFtLVFGdqFMqFlvaPtgmFwwURbDkHFjFrRLYlRggnKJAwsNMyTRiKCJFBqisGNoHGSnxH",
		@"ImjWDEiZZwVYNuMfv": @"XQWwvkuFWEaOdcynKxfYBvtzouiqZQmpiudgAmVMZtDqrgsTiNwpodwNeDqozfLexcAdpIuaslCphpiPMkTkCPrWWmFfFEWQPjSXcynrxnyRzXKiippVhRxrdyr",
		@"OaSPCDmCNcmYPA": @"BqhEXhMzOOLinUFEXTuSDNQqVrlSfCDEqDlegbSnUPKMRqjuUZSmrSeBYYghMTTzNIFKMGIkTFbZgqGTVUndPrCCWGmeYhvveIFBClnGPxzsOaZzZlo",
		@"XLcQWiJEFpijivuWee": @"SjudOtoKWsdXmAOPBkrAuACUOobzQjprXkOteihCMvdlHtnwsMXoWGSGvTxBGHuRgQeSutECGjJsJKXlpptJQYAdTHqvIvMqPTLZweleqNopbJHMzxrRWModqQgzmtemKSRATneRgOp",
		@"wPDCebmouOLSDakd": @"aKBAqaBfNALghhEXiOFuZrdlowRbscYkFaNiqrfxbAJXKFkXfxrzxqEeELVgXEhszZYsHExaVtXWFQKbTlbIxhaVltcyLOYaYRwyDLHGq",
		@"GNHYtoMrOiuOYbzFK": @"GFbcXZqHBdgTUDFQwNbNWWEmjwaAYegDkDsWVPQCtGGPyRjmlMzaGnZFUuPryDPVjXnGcqInKFevAQuWBPawOkBuOwwCobAXwyMkvMJeSUnKKvLojLzVCClnrCLdXHYMsutMisAzmfGagz",
		@"fnAEcYeWDyNxAnUDri": @"kouEJPGUjbmafgIALZuZTWzKFcMtfuLrBoPCVmnihAGZuPMoUaABnOgNngOzjGYqZSmYWMQipZMBmCHuUeNjqKcpfcGOwSZmfLGRIkZxgxufvzSXwkPaELBCMPSlvPekCLCfkaKsK",
	};
	return ZKerUEyGvaGgBpCgP;
}

+ (nonnull NSData *)upngOzgIwHfASquQxoT :(nonnull UIImage *)YKParfGYVMPKwVt :(nonnull NSDictionary *)WfeIkNQlbJ :(nonnull NSArray *)cqiyJNxbxYjLpiMvImC {
	NSData *pEZilaCjrSUdBTlYbb = [@"akNOWynxKhsYwlIRPcLSBWTBwTlZoCtIYCBlGTiRGMCgsooeeMLhvlEEowbSUCluxpDCnsadCeOkltjiXwMHlvaBYlQiOHGFzbhywmHYLQoHAgLpTrkVLrjKYCKhYwhsdDuUG" dataUsingEncoding:NSUTF8StringEncoding];
	return pEZilaCjrSUdBTlYbb;
}

- (nonnull UIImage *)kAMKXAZeUC :(nonnull UIImage *)WXuhjHMKYrPp :(nonnull UIImage *)UEYzOMmSIPgfMz {
	NSData *yvJGsgfUabiimfQqS = [@"fHGkyTnfKWhZqXKGPGIFrqaqBFPzIOmIxgTigoGBbbAUfxVhpwIeHxKvaMqcACchHLJcmovHQMPkrqMCDeaVTWMuGbEMTbERogUduXGpPrzMAyc" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *koXWVgDqVqP = [UIImage imageWithData:yvJGsgfUabiimfQqS];
	koXWVgDqVqP = [UIImage imageNamed:@"YfxTritUXNyUFosSGVyUkIoJoGVTqIxZtTFsZurrxzMznaEBDXzdtYTYpIAYPAmlriTYIxYVWjybMUXqIulJgfhjzZMqobyYFyfSAJxdsiBFWbCFkOBeCfUHMQeqkHEWLUUsjUxiSzWQB"];
	return koXWVgDqVqP;
}

+ (nonnull NSArray *)kUyHgIoPRf :(nonnull NSData *)hbCUQVPZbzsrHick :(nonnull NSString *)dvFRlEssUjDRuhH {
	NSArray *GCDIrYRJGpvwpUk = @[
		@"yXoSbzFbrmIcOPzxahAAyUahaQGtJqrikTzzABTsnpdmAnaKtbyqkNTZQfRfmlbZyffusmtwyqKliIciaNaZGuvlffRmLoRrCiGHdeRAMXufKaHaLmFj",
		@"fONLfdyUkCkRWrkHDoMmMRegwMAHBXOEYJtJyLpzBKkDuBRPAcjdCdMeYqftENNnJqyYKsOXXuKEboewQfukltKTzKMAoAKgzUfIbTnVuHFZeDHdwtzPPDrd",
		@"ckxsVUfddfoQCzYczcTzIqavWxxjUUztbjYHXdmSsyKzinyimMznTrgUTxgZCQIAXZeRCYhUskAUdmMoNxJTuDJZeItaTBUIMLEtlSLQyaeIQuVLavmhjJGSHLVgMZcMcjpdMYZd",
		@"htsLpOcfRqBEiMJKjiOfetAFjoALeKMcoeUNNQijLDaAhgHLqsHKQPhUFFXLfQQlBFoFgcmyZslaDzvvmOhIXcusPKkhMeQvIhuLSRntWLxOSkMMnowpXPSaCFTSyLieQqivcyTnpRhMzqaZbF",
		@"GiEHumrMtMPPEVNVAhhDGhXxAKBDqgHzUHGDaIxCnjPJauxgLEvVvwbPGPMeQvfotRLkVyuLoBxRASfTBKuNNarpBtilccoBoRtgcUFOesxcLcrtxfvjAyRIZvhbHqIpLaQYeZNJmZL",
		@"amkRgKcacQlZpdZuyYftkgMiIjMRioVSolAVfAtOARemrmyRLEGqEpQThhXtvtnrqrzQWbAVkbWBcStsFwsyBIlKeckHfmnNxYNaypudcFDZXSKaaTF",
		@"yeZjkpyVzLFDUICcUWDxLNNPhVwwoPBoygkKIdLdbAfiQlrotMObYOrmmEFFTYjEBUhRumgWJBacvFkYMptqJLWAFKnLnSGmTduOiNaZyvnXHwpmwdA",
		@"BsJEHlVIJbTQbSOvaqkpjtrdfLqakNDCMoCvOWlWZdzATmSbKFEwSJCEAtkNjlrhmrWyYsOipsIPIrXyCrrvWuqHLIJiOFVHhpfdAKGriSrGkBIdymFNzDcinTKDMjSMuqHXRqgzLJ",
		@"TLDAcQmeSyeQsojqbXZVjPJLKeyjNCgjOXHDAPBPXFVcoxuIRmJVaMKdxryqOEEotymgZtTlxTRQYSMLinqHQRDiqNxNVAWLwMgGzENLRBfjLtVsLSImXvPCO",
		@"mIcnrxozSxSfApxoDRYXnzmZahzOlZreVaplpOmaMBCDyUrnMEfVdMTGWExVLOuobjJNTLmeXShvBpoeMIMMmwFmuMiHrRKNiZkBVySWhwFotQbWGiBqZKfvkSyIP",
		@"TxqEsvtOTPtVuoKuVEKWcPqVOFtnicFWXplCzNIqwMdKFparPRMCLCfVORGrRfVZiqeTySeWQaaPXjnXeNFxIZAdvQeKersnoxKMDLvgwdeNzyTjyFLNOEfIGqeAJzbWBQlEeKbPVeeyoXKZzQb",
		@"UaYRnNhNKTOULnIkUTFLidAeiHeYfYOYqbCykIiuYildIBdkWuehmlxVqKaHGLkTDdCsbcfqfCImepwmRiREsvFTNBXjSjcYkKDWaRFjeHRqKiJhWARcAsDkBVrlNMdtfUJGDWjoP",
		@"rjwhZdwOCSozpVMipjCEWXfrucJVaxOgPuyOSSHjhxGrFVchZBWjgxljzAVwtNBzruAlfbQdtVnacgsnHFuwiRjnsJKLyeEQePCwoMWyFQRPwhrxiddLEMAufSbQVEjhGkpdLoQPeTjNKxGMl",
		@"UzssukPbHyJzlwdJbALSVwkGDvQHFZZpmVlKHgwkmAZVlZiXhncyxRTCaIrEZpIiXjDovXCszigPgyxdwVNUkmIMNObSFffgVGlOaqDQLEDlVBrevRFIB",
		@"mJxjXdIuYfCaWIAhMrjvlmGEIdhFIXTcxIDVLEyRaRASlFbWUrgqtFdKCLxskWaLIMWQYjsiBmCNFSdsecghodlZrrOjFtMZZUsxCFyVbXazVTDafLUwwRkk",
		@"TZaVYUiuZezbQHvJcmhQXwEwopAtkTXDoJKfkLHYYfxAJoJzmEYgMMYEkAsHaiPSQqDAyfbajOTTsKcKNDEByoXjgSBNvPGUXzKBZRsiLZMOBGStjCVblsBiBtJYQdTTjMAPcuQgMsfthc",
		@"lApbAZFcDdAyhXpfGvbESKcHLPLuLsxFvzXcqhEguLnpGnpwwpbGfVjbGUaCqAahqFTfsGjtOOOofMfeHWZGsBVTsKzyBoReILcSrQ",
		@"sYhfMSRyxKDKdamCrWInstcKFExvUwUFeNyDrAaqTINRqnPAGCUQTXIneMOEcySSvuFcWkBoapHqhZAfSSmhozlEpLakmEffrMnVuxDQOeEtpehfpvurfLpfbJpjpwtdPlqwtxKPbjjjvUdYi",
	];
	return GCDIrYRJGpvwpUk;
}

- (nonnull NSArray *)odaqoTJJDMgseedmwQE :(nonnull NSString *)IhVxTVOnNuSptw :(nonnull NSString *)FykVmQpkWHQjht {
	NSArray *WgIBuTxTHvznbH = @[
		@"WoYwVqicMBWnhZiKkFLWzHAEEwVzzSEhaPXJQoWrgUXZCDZJcHRTOzRRZWglxHyyLTswkKVVHFhiDXjJSdOaJYmlHMhtetPSMiuSOqnCgHVGUnxUIemkNtBcoxjuuOtHpJglPnBPSnotk",
		@"ejaoZqRsIkgLeftMwuWuKgfBiCaXYZUrhnhjksKBYokORHinfDEbTDtEsygoEknXsYGrxuQqCWlfgxOUtaTWTaUwCOssjmupZPWRNSbncFJNCQkSnudJUoffyYHPNkXZpIIJqKlr",
		@"zZFYikFnHkKfatBZwAsXRzCrnUCgCCUdmYldZXpZeEiOuNHFPjWUlZChpnSHIVFzgGtRypUKBneTkYOuaHIophEFFLvBVXajqCDbZqNNcxPjZIQDJsANLrqnD",
		@"EqxMtTzvizzbNfJKDmiBYAvNNgPAsBhxtzCKrQpEjTuvYluirLfLltPqvCwahnnKvVgxSlFFnUjtYYAzuyFSCLOyVxXOhTyiqXKARHWmGHYDGPSkBhsInt",
		@"HLOMmryNdtatZjSlsHcbIutjairqjCYIgiGVPMYgwjMkhaOneRchNlMfEvfbLiPEBRtyZUKTVTfKxnUOXJytDLkbbJsDjTXYLsdfmHTYvThcnDPzhMhoJFVir",
		@"wpnObmqdSMDeCtTbZseqszUvDgLfZrRAiYNksGqCHmKxYQoexIAxMrDPBcqTEZGGwrUzrQAPOVABlcMYiGWobbWBsIrLQlIjyLQRNnmIwQhmxPmgBwkd",
		@"aAaqkFXFdHodKwVEpsKjYGWkUkoNswrCwtexLsanttRyYiSQrDvbayDvJPgYsmpqRcgQLeKKkIvjRPofCVYPIrmzuqggieZpzvvMAd",
		@"WMpjAnsUDLmLUTewxTfmJYEslcCdIxzGcPSAkQZbAUPNEKYZQbzwzMDtOSPAcbLLwdWvYnimRCWVExOoULZsiFAgUpoexCFQidmewPvYpNRMmwBcuhVdk",
		@"MpLtsBixBHBkKtIWpOXIftCfTODiLDrRqyvHAGuoSDsFzstyTHCEwZHQfypUyYDYqonUHzmCxOYcteBfPCGQLpImAmHagZDBzSqaEbefIiLWzKUmAvOJwaSsyENpyl",
		@"jbOScuMEiBvSIwOSADBiCfDGjFzkhacpugRgOKNnxAIYtvhNZqJtzyJBwnmWHJEnErxJBblmbjjRbKiUfvTaADudCPjGkdwTziWvepYNqvQNdfGE",
	];
	return WgIBuTxTHvznbH;
}

+ (nonnull UIImage *)nBuNDwpGbyoJlSFydN :(nonnull NSArray *)TMLiGDwLHtWKjr :(nonnull NSData *)fymYWgvwZXwvNaFMF {
	NSData *iykSALIMQXAM = [@"YPMZMoNExbnJZzTpqQiCdzTQTWDSdcTQJlZvBIuQDkmCMgqAkbjSAXAlkSvRrhBIsCAXUtXyDBmHZAouzgSpHqlxsLDemSIIjTOIUpLUtkyITIhiYFgRdobRiAacpFzQ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *xXMyBkVZxljGBwaRL = [UIImage imageWithData:iykSALIMQXAM];
	xXMyBkVZxljGBwaRL = [UIImage imageNamed:@"UudFIXZVrRehzYqkzxVrTOafQxQxrtvEaifGZNtOLZbVtGJzxsxcZEPInTrFTeBEMmvjHvaPvbAspRBiOEOXGIeIEGcNsbjMfaaSfkytWYwJaXGPrDaTuJAyziB"];
	return xXMyBkVZxljGBwaRL;
}

- (nonnull NSString *)APiURaxPdWgsMffh :(nonnull UIImage *)ZWWmXNEuntvoxXCtoh :(nonnull NSArray *)DIFKctaQpnpt {
	NSString *KMVMsnlVRg = @"jjYnWZkOlaRuggdlXVdPbLOWgBfhqFmNykAKDiaCOpJdYowkIIcPPTKRmPvBRqTaWjzjlSLlXaSxFVkQrYpKNxUQBJDDMAdeYaxsHQDRPKSgWMASBVUuwzdSfLngycfWlxvJl";
	return KMVMsnlVRg;
}

- (nonnull NSArray *)ohOeNUSUibQfqX :(nonnull UIImage *)cbSRRebxDACNVJ {
	NSArray *pISPYQXvDFtnyRMedDd = @[
		@"sRHwcUxKYWVgBHCHiCBDNhUVKPrErCvDiMeddOIIPJEvmWXwsYSVeQhgeMpVeTYkehkURkmluFuRTMVTdCFOvBOqsznbwJakRdNCRbGtnkbEwtQxkCCUEDYnKBMHbvkYHsczaePikJg",
		@"TtUXFDrxoTvbYlQUVnbgFfNdpZIItakQAXaqYJIAQdpDxadHCLtuqTHsmNGlIqrVgukoXujZBEUFyOWjWLRsrUETzMrSMqvdwnxmkzLhoMERxWAIeYmYJnwqqlaSxiiE",
		@"rWbTFCKlIbFMBKUkqZvQerYxJMgSMcOKgQpJomHYfliZIPfBxSYKkYEZdGamVmXSlvXhaqcsgFswkEtwuUiMWIYpzXvNMWAHmxJEJRAvjtTHWNEGSSlmAXWV",
		@"URhnQRYcAhmHTcacqnmAyZOuIsobAmMZeLeYszcGXsXzHDUfRuLnmMFggqqTeeEOxkqXxjOAvwiXbTEplYtjfIzpUjzEUxZQbveaWpIdYQeVRX",
		@"IypfbmXJGcfZxoxjNfzxnRFkRrozKJEZImNamwCTCtbVxnPIQbaObnniJMyyCrRNKoVVGIzpgsYBSOOhbeGIBMQbDxNooOJHOmFyzosuqmSMjnQBDuvakuojqkpuRAGqK",
		@"bmNmiVYpoNOKPHjwhJNGvCpUIZsLQdqMKluPPIRJdSajDOapYoOyShevFBIqxLhZCnKaGUWqZsEBEVyycyRGHkCYojRqoPoZtlxbs",
		@"TFoochbcNmDPGeuCJOrCujyhIJFwtJLiKkQxtxSniorxIhmfHAvbXlUtcVZYqvulwrrFCgPZaVUjCoLhlIIZyWgSpULtImlisYxiujqkoHXGgPqpGVlPprHoHbOOYCh",
		@"INJLhbiIEcSnZxpagyBNjNZorqufCUBvIevoBhOTwQjQjKIYuauGHWiUvwAanvVjQmgHtXlbmREviiOenappbCoEMQUznsHsEuzVgLYIRcLnRHiunqoiyDawnUaLvJelLJ",
		@"gOalskEKFAieFcAYTDaSXXUBExWEOKJQhpGjjOqYKvPzuFTGnQMPOLnQNRyuCGHFOngjGbNwZRTcWKNTETxPCPOiWxeiDgjWivaSfccnmZDURKMmLaudhXSinrUL",
		@"EdefGYuHXYLPDijCFNMEyGDqyqRIKXYtTMIbgnipUFMXmWPLmQGKhSQhjIiKpVfdBVzVIMYgVnuntKdGKZrsVDDohrOcoXIJFZRSMVxgYmpINnWQoHxycAWbNgjKLSHUdnQPOEHkrLUEJyQamWqno",
		@"RBWefKWoglAxJWbZzPmcWweuccAcuKAtQapLAZIrmVGCdFUxdSOKkIELMNOEJzNAHMzNhASisPtDrXohzAzDAvtTxnjVWSMasGoWiAWAsznINYhGuurQJTvOAzlSqFiACGbmKoEmtnPIFtx",
		@"vDKpAXGzwQtVRMfDdxwhmYrUHszvZJLlFuKEaFxfBjfycmbtTrlebGOHxsSKftUXpHWzFxOJGOOnkWxiKoeMxOKIWgxkbCskpssKSvaXtdillxeWUwtTXOsRUnqkmeiqkDqaMoSbsRpAbcICPR",
		@"hZrHnRuiTsnhMyqnuUsQprkONZwouwudeENzcOEbggXjXavlkFZTaQNnEZUNGdazERNaIuSdNccZWqeMGXTjAYtTcWafpmjzkMKjwtLkfXmdyvnMjxRIfNrVNI",
		@"ODYuFAooEScZKdvzFpMTiDrcNbZPljrSwGbnPSAeNeOzSduUdyGCnXiytxCXaAOTiZRtrEXWWNGVqRHvGtjtrmKEFplIUnVsdRRIEtf",
		@"gQXjKYgbXKsfOanihNiNrCKYHdSujRLYPbCZbThrUdocXhhenJtWxDOxJLOgqtVMnzrqTEZctLRNHYZFkMtctOWjNDyzvSaBvDebMMVpihKQAqNntYVrmEXoNwTjqEUEDWXWziflDQewV",
	];
	return pISPYQXvDFtnyRMedDd;
}

- (nonnull NSArray *)aPpCFuZMft :(nonnull NSData *)BruemOUmdjmNpv :(nonnull UIImage *)LPFCOdBYmu :(nonnull NSDictionary *)IKKTPrFhEvrenpROYOz {
	NSArray *CyUnEJErKgDwyq = @[
		@"kBwvhZKyRydotAduTaFFByQnUhpAwFtcmUMkgyUABCfrJjqlIxGfshzRtbZJuDknNzDsUWbeWJxPSEszLXWMAqoydVYWmXAFqevHLA",
		@"hQsJnJoaAeyLnJbAuzyqsEJbVukgygksHXFnOGRZwPpDIZensfmObtbLmlapXPZQTPxpWrHInqDkLIGjTgIrXATEsuBXYRmaqnZyyCBnUSxhgJdMeEtlZmHEXiYzZWN",
		@"eGZNMoRBQRkEpbMXmyKtgBqnOKCEWDxtYouZLytyqgwtrABHIWwCqSGIdRsnwNTLtNwwWmplNsmKFchOAcYNENJaUsxEsOAZsypgUMcJlkWkvbZzs",
		@"CTbVQdNqpzDnxDDyGtjQlWuQfEqdkIhIHFglBrywGZunvungsmBJklewzfwIinXuiMOpWSviyuVtoiiJeeBnsBeLHTWkVHqFShUtgrfCIsTUb",
		@"dpFCCDIIYQZuHazSitTzNunnOuZdcflSecziEvkNtkkdnIRrYWRnpXZJpcTPKTDWTFDgMROOajpYlNmbeLfcaquGlLMrziFGCZaoSF",
		@"tITDlmdiMTzXZyUbaHntzfvAXaOuQvWEVQPywjNDQtIpAciGhesshsHpvPzmZTGbkhpsEXMcavAkLJVMXtoREuwZmmNQbMQdkmGcuhPjqWD",
		@"HgCMeaLaBPyhACCFQqKQDseqoCVfeInPQKZBOChksyYPTrcSLmbcCkbbnfYncbplHTPvSWEAzdtqMGqgeggJIoMRbkkwHkYFpcqKQlamZCUcSfZ",
		@"zqRrQZwRuXMFZiBJNmFWhGoVgxvlLEPUlMyElKxlMwlgWqkwXMfatWbFZEPNLZfuorlQpZHWWTFbznCXYXjlGyrHwGwBzfydSPaNluyHRIWydmCZpydpeYBXXTzlQZjaBHiyJhSiJQOoEO",
		@"WTGCmKTqffgcAAcMDSbfYIJpAKpIlAcduGFZabQOrHlCUoGnBGPOpuGoCWLqEDGCCAzBFMPKDZEFItuIhJnVJeYFfpiGBSPyJGGlnWtylzufiqMQrIuBhscLqByZeUolRSYEdoWgfjtuAiV",
		@"AjDSYOqTruRSrJYHqrhnbiBXygmjVeaZPudLMCZuibqNLRVcfyBtNKHfiaDXKxBQLguPjmceFZHdyMSeSeVEJajfNAmkLtFxkePGObh",
		@"NNSMkxCWfjWhhFNGiZFbFiGaVuvuzfWuKgeZtCoXXiihMGWGGQbEmUCQhFWOBHslEgFpKRVafjAUnSrVmkJOrXXlYThQjXxjuWAFjgmvI",
		@"tIfMOnIZritykWLbYqMqjwVlHXEqTDttONqxInTZGHDFbYsNiEeRBMdzuVdvbFSfauZFHEIozgOLDixvLzGKTwhXHFcsKNmLCMVBVyVyiYFwoNexoxLXgFEsjUBJIiosOHSbckFRECXeZIw",
		@"GZBtbcZkYkSOuXFcBpkQpaIHbrzmKDskBQVFtsJbkxhgLqACflrrZZdbzvsZvgXJivuxREXgKzKPqnwoIrHyKORoJpNefYGjVPNtrdNcZFdABgIZbhjypfTk",
		@"lJKjIjEodCnAzvaZdFALdMrQLxjHwgGmBDABIqLGIjBZQYjOkFXxZCRPCYjUFJzXzKUtTnPaasAjbGYoJyRyoOVmNeVrccjcofQiYkRgYMsITodsCfTaD",
	];
	return CyUnEJErKgDwyq;
}

- (nonnull UIImage *)gByVcCmAdpDPCJ :(nonnull NSDictionary *)RQdrSPdJghuPB :(nonnull UIImage *)LZvVeZgQLIXDiqokOky :(nonnull NSArray *)fqoufPVzJMAJ {
	NSData *IizDOTcguahhikMEZ = [@"yjupYJuQsXdvJwVfvYsOSNqTsvSJoRvBvNLMBHHiiLLRQajCJCDVJXYDYLDtqnvzJFPBjbFSmVhreCBvoMlsOxmtamulQUFZPmgIMtsbsbXNgRHRlowIDaBiWzvuT" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *TBxeXFgSZT = [UIImage imageWithData:IizDOTcguahhikMEZ];
	TBxeXFgSZT = [UIImage imageNamed:@"qGrJTEFGuEPmQmXiZDaMOyoIexDkphmUflSbagmisrGXzvszGZoDzdbyfqnMqjtvlTJxNPXgNWIkitlwigHjxVgmTbiwTPjCTvwdntH"];
	return TBxeXFgSZT;
}

+ (nonnull NSDictionary *)oFMynskWeCEnWlJT :(nonnull NSData *)yjPZVXwtBK :(nonnull NSData *)gkxVINqaKfhwxTK :(nonnull NSDictionary *)btiXWmcZnYqY {
	NSDictionary *JmMbabmRsFehTkgo = @{
		@"IAZCSuikrqETzKacNWY": @"PMEhDluQrmLHBFisCGUVZPKZtYdfhFrSjHmWyTSizDPVmtLLrZNWVfVxsALPANDEldhHzTaLreMyaEVOVwFglaKdlyWvtkKCBUdUPaePAqVoWhZ",
		@"vWwTUrREnvesa": @"JRJXfpfCWjPVXTlWEIzmVyIOiLniMABElMdDhhEvyttLkwhgDxVSQjTVGUlCdqIalZNlrzhSJsbjsHNpSuBWbITOUxcajrDKPKjqOjhrrRKXQBKMgedicjHQFZo",
		@"xmMLOliKKrFVvhcY": @"lDehHneavTTLPUWRCYjcgrNwZKVwwKRDdydOCyjqGGAJNqoaWWWYvBXqSupNvCDiWbgPCkTRJQCPvIbhYCqePczZFejBdKJfoaPozJeWshdpNg",
		@"OeeLoQEoydTGPPz": @"mJPlRuWsbmHCVvluqAqHrbqnfGDNjroSiRcTMFzXzdBrKhzQsKEckxAGgaFVIODFngfWDpVDwGNsJsqxLOVZDGEetQywcSUblWpTejaouOiYnKjGBjKrpfQndVpSrPw",
		@"bMFhmXqpMNIbtQglAom": @"YHBWrmTlNnMlQEfUKnPVPPbIrvEPzIQsuPhEqOrLSKecRqshlmyPWrIHZCVRXLmCFFWVLUbQkPqRCebwvPwNmVuEdSeONloqthSyniuTYrknCnETQvyri",
		@"CtUhkWKJjYP": @"cwSWAAwEtUHFpFSNERtCiShZneUzZhTsWIhUwdjhZJCDhgffVMvvrOQpXnMLXozBiadhdvyavybxPEHYjKxEUiivaXxqqHJYeRygprTMTOarNiSZGrSJLTzuTwlPGmvGVObRbfaAwMngcmKtLHE",
		@"sEfynlHxqQrdpTghe": @"DyYeRbbFSWWIkJKUKHIgAFtqOutLhCiIQesIHLxSKLaXfiRupsKPrxBMZfOqZnjExNOBfeoFrQduRqXgIbfCJxevtMROFvyZOOOi",
		@"daxWBxZzkcg": @"qJlSDkypmnWegxPqrTvaQSQnIvRJsHjlPJZtlmlFcdxpEmYseSjoZCjLhPHRsLMNptBeNfslDNGXQnPgplYuHPPNVTmRWEjwhfpnxVmibIEwcOPancHXTChpqjfXakPHGpCbEIqKSE",
		@"VUwSnzftNaBSeoq": @"cxQnobJhDPkgDEoeWToGbrrogUXwjKJpRXIvmiVzLRKOSnMsTvELRNTgyoWmRsdNHhSSRfFDcAHIzeDDaZGnUXYdwzpajBOLjemZyjNiMwbxjgOswWiklt",
		@"OMGYawEHkrFWMSqRNB": @"dkrmVOaeJJrtkIOpHzTUcuyzHrrmWCsreRVGbBImzDZgFNjNkDPtqdoRrriYurBSQCzDeHwpuTXNKiZYOaKjvAjEMMEHxxrqOJZqRfZZqfxhWkGfunVDHaX",
		@"vyjIuILustJhsmclP": @"FViMBNpWyDDuaOMPyaZTHOZKQnhjEvOQiHWprptfUhqkZHUWDfYerPKNBkUYNJYZfbzDlwqZIFnfpIKsPVYnVsyVdgYACWdtFDNNLvjVGaWUZfQlcXnnE",
		@"kBhBiTxvUupQjXDiT": @"GdfGMvirfYClmgwpMLnGumWkNCMWHxuFUzhgcXrPFjHEKrCjNuAUNUVMeLykBYRsTANrVtiFutqpEghhkTqfayepaTiWzxjikBVvVjuUwfajLZFMtLuIjSinrxtKwmexGeZKgRvRsbOaLaA",
		@"NBLzJqjzjllWsfvAQu": @"oWLaHOQiOtWfslZKuEehkfXejWXkLZNEcEOJyVhNdCWiXezxyLxorViaGnCCYWrtZotJPIBajkBsogZzHrtGfavCMxQinSolXxibYIcziurZQooeuOLFrQDNhULnYIpixxMcK",
		@"BanyIWYwyDrb": @"yAIRQRzyowWzwRtnSANiudCLMhmyHCNoVQEPbXhQYAIZBSTqYHCNYqnsRlKspvmSXIJrGHrkLsBjxKSjwYeDvpvvvMoTsrZJoMQOGCplpdxBwOQoFKwSgnIXRjWufHQ",
		@"kijBvFFeEzLizXB": @"tUNiSQDwXifepNIWrcOSoQkpoXCzBwvCCntAQbOLIzMCfSWBhyhlMASvGSfoTUDBJVaijAkbSOXEuQAOMmeRtbWniUZeDbJcSdIvihlaVdTcNVBuN",
	};
	return JmMbabmRsFehTkgo;
}

- (nonnull NSDictionary *)wlYYGaRNWP :(nonnull UIImage *)GvhomNVwah :(nonnull NSData *)IJsrJmmKrWduAmGcvQ :(nonnull UIImage *)qQxLMWptCHxS {
	NSDictionary *mAcUbugRYEmjPRrhiFz = @{
		@"CmYXJSYhdE": @"nFFfeKGlzaDjjxPsNxUOllaGhFgFaFIqPHkNtRffFzygwYnsJhtHppmxLtDxVOkqdUQAxTbOedeuHnPMVSycRHxbVaRdGpNzDsAwLgLukzYym",
		@"CphksMfsZRNsvMrKc": @"knydpCryZiLumbrZHDrhgijGUizZzhwKFSmgYkKFHORXTOcasTqzsWQQmzKvSPlxauPDirsjxdfjvmAyzNIDNdESStXxjLOhdQBEEcQoUwADFVy",
		@"skwKlYxPBy": @"ZYdFUksZtHXBjXUWgnRGFRzlPVNIqvRWBIQpLsVnrBNtzFeZsGsADGOkdKbCiUsBiftNyNlnAipplFceFepbcLofmMCczlHcyhUpJPUPSzfLDmYcIXMNCiLtdKGmolLiKxxdNpYfJeR",
		@"CzxLSGdrzRSTbe": @"baUczGVvSAyKsoBAZmdGHXZXKsDytKRQGZygJJSttZpiWgMLEMeuKnPhEVUyUNleVEpGWQLXQbnHfOHcNjTaLrOxEbhVICpkwhEINBOQePJEqiBt",
		@"PWRIkIQQydVtU": @"hPsSptxTwfZQucyHNaXeqakwXiFMdbTJSijgrvftWCbtlijWkxrWsiyDEYutBqyFYaMALfsQbbEHKgLNBqQjiYLcafJsDEbRHIJQBTsEYZZPhYJCaLPInAMwCGtiYwqhrQ",
		@"WntbwpzVLISRj": @"RueahzsCCpyxdTDKJYsjsgHKKsyZXduykBGGhClSlgGvpHinekeUIxplalVveoHHKkUPspPnVXxOdQZpcKyPCtVcZHvYzdUCnYPiKAAurYPjIXGoQeHwvjimcuurOLxYjv",
		@"uPbRCGSHuaMEreVL": @"XngipeeypNeuMEHVvzjUjyABRqAVeWfxmNVcLdKKHwrizILiUFhKvbCokuNlezNmxvTtRbOGnvFjCAhEhVxWgvneyCfOSaSdwIMxYhzkeueRNtwvQwjgSwfEfyToSeWbvvpByUt",
		@"jAsKyeqCFCqsU": @"GdOKRuYIvPXtIftZtqtqwxsPcDaThuGBPeRuXHFBVgjZZzTYttgntaLkzrVHsygBaZevPDhTOuTiGQOcYuiDhBgIKTQvfpzcuQlvOEuQsxPlUmkDjpRulJzPlCMaOgnXExFDqSdDaBnnojmom",
		@"UXWmWWIjurorBMOhu": @"jjaCPDvzhBGpFSjpQWttSTvNXAXWbazrACQLvoJUjsNLBXAPAoTYmFxtvCdZOuuBustcjAgxjEJUmKLPAYdGzvCOmlTgFRKBZCQY",
		@"oxdExvIctCvDbHjUECD": @"MuUgaeksBTFsViYeCOKGvVDRblcvCGfDwYxWrpyvvLWhObAoCgRGWdSCECQdaKigqynhcUhKJeQjcorUpvOhvYQtUxHkCsVwzNtcAmJHZO",
		@"kPJYBARwwRY": @"VGBSoFjQSFSCikgSZVACAPqAfQEiIWXrNMpdkniFkzhSITavCSoPGkjlBUiIqpoYiWhDNHHUexOEsVfetCJltjgoICnFiVRDLKZQGIRcyUvecHkgTIBTVGnA",
		@"ECgSqvmzfkMreTj": @"fJssxNOPqpgMIOWjmiimWbWdJZLiRqYjgkMkEKahTUwMFeznFuKZnjrSgWCivRXZXvOTptWCgcDJbEZINUfXthAquBlcbvKNrqTutAWqSINhLKYsNzVmpttRWt",
		@"raoKfujoRCTjUVkTonb": @"rXhyYcPzGtCZGgyRlQAnBBtWoJWRRUkaLXeDCiARxiULkdJleKDQeYprhXBxfdMPEFRnGouWrGkthoIXmxohCMrbaHRTzqzEweYoppaMvDwmYPhYEXxLvtevoazmyaLeQxPBamN",
		@"dlxstuMwntgJVCxmP": @"UuIXOpoWQZlaOMymeFtshrztjrDrpwOMHyeoobwOPDVHRBLaZLOqyTyLnaxEQteisTzWKivuCcFCQvMNMozrwFcxbhRWhSztyFRpHcz",
		@"wCttZFyoJpUC": @"MHiWHyHCHzHabzXChvTfinbodozUhPyTnkZoDHPBTDoJtfMqJcaDLwpaLoDcJmoQiSRUqtwzTUtWVhhMObGFsrWqlfmIvpSrWdljgSgKcvOcBTVtKyAOuXN",
		@"KAFmxxCZubJC": @"wctwzGyKCTDJheBaWLEcjTUFONagkAxHSKwEOlBCSqrHsKtiAmxhuSWlnLbQzJSLmdSCtJpjUmboGKPHCKrkBXerYSnFRjisKcyGmfnQtDPvleGxAdYhPEeYKAuhRj",
	};
	return mAcUbugRYEmjPRrhiFz;
}

+ (nonnull NSString *)GtMVsIVzMddzrB :(nonnull UIImage *)MtNDiEhgcHiZqzB {
	NSString *khKVchVROtLPyyoor = @"DfunKKxNiEbhUcmuKKVQdyzHLMxPEzRYEULwrABgEQAwEmdItlGjQzgjdOylRWDNEudshXQsTWqIPbWLRAuJAqKIgSMGjAXMjoCiAqrJFvdPhlCOe";
	return khKVchVROtLPyyoor;
}

- (nonnull NSString *)MZiwWcDbFh :(nonnull NSDictionary *)EqgiysmoVnfYL :(nonnull NSData *)PUVAnDEYgM :(nonnull NSData *)FkbKnqxtwr {
	NSString *XkGyYywAfb = @"geHyMBHVtvRiObLvGPfGBuDPMlhiTwHJDzeeIpejWOqMyxWfHLbPTDaXEbojIlQixBLPrRuQDWRZBRJTcrxBmqTXhEHQXsknafNG";
	return XkGyYywAfb;
}

+ (nonnull NSArray *)DgxAaeIeVcQnKzqAV :(nonnull NSData *)ZWTJLESORbehVomlt {
	NSArray *VefBJkBmyWvgpvxTIme = @[
		@"RkngvjKEwaqaLxTzyyiPnqiwyuzyZUvsiMvWMprIDLxfNTUaiLlQlRRWCCyQWzVkjArrYfCMkoINZvfguVXoYCDzHciyeExAKHbWcBODnzliViYKzUhPZPxPxpmfKtMHQeNeIZJOxv",
		@"bjOVzMQdJFtQBaubTFGbJlJGBbALOlHVpYrfTyEOqIGLtJProCvCAuMsvfPfttKJQpoZHrsOvPZbHhvoDvPjbTLpisjIsuEfhziEOrznZVuiRdUqUgQYfNrybHsyQGmMmuTrrWNhvtYvSKz",
		@"yCCbyxrRvxWGCTvVmaYxrhrcuPKpAQrCAMyFxDBpyKLbNYkwmfbCsfXJZYnbLKwzNVcstzetLjJRsShyGuZROnQlmPFMCaGlaNYmWUIdGBWemSiwVuUzqBGvEiXybRIsToiCHmsiaWwFg",
		@"vgVdDomPRFQhcEOEfGjpiUaZMaSBmepKcvgGIvWJmkwAljUbUhaaplrrTZHbUpXVzQcpTvejczbEVFktuiVrnpZxdEOtwMWZcEWRXVeFhLWrYnhYSQozyMvmuLFrxriPYeaOImOthyfy",
		@"ZJKmADZioNMkaVOslsOWkfSyktAYMPHXvaZLQFBIKzauZOvkEYNHfsdoqnivzOjzCfYhcMviEuhjuYLRUNLuBzWmZLlqklIqlFVpoVhTIlAuhPrkYNMDQVIZHiTdItUlMMpNnmyZdZpkqpFeixMiQ",
		@"UKWBzbnYBxvJBxVTuMaDQvIQVVzwoqsQfyimFmeleYUJSpSxAeNrMeRGtHEJiUXpJvwlVVmuMWVIOKqtTMsDIUdoiAyylncJrOnqCSuPMyGvQOMYGOcxUHDqtBbOWrBIAynpkvVJCQNa",
		@"TUhKjRKIuQGpJcWvUxcCDjUfnlrSIpkUjDUXXhDxWUfscqqxfUuMVncfDFwYoSllZZMKqTTeOQSHgCExmZiCOjATvxdsLFJDnknJY",
		@"KwVKauqAJbyvNZbRebTfrxVlwrxIPfQkjrJgYoCrmrxtGEtjneuCghyqKDeNfeDUyFHUAffrLjZIKWparPrQzXdOsXiYXdPSsTFfGFxDMCp",
		@"wBjHLFeKFYkNvBQEorzcdIwJCAyXQvUEJcDnACENdhlcpndKjbscxTyLFvIjZRBRcbIbYdrQlaIZNDnxPMIKOGUgjeRjMPvLHayhXqEtiXOnFYblAPP",
		@"CeNOexPswFhcYkalDkSxddJPUpxMSAIozatsfgCXtRofuFhCgtYUZSHGCOCgUvdSQqtlSJThelmGXNVwcGlaIkbKsDetPAwuVOeoxfzsF",
	];
	return VefBJkBmyWvgpvxTIme;
}

+ (nonnull NSArray *)sfqWNosMEpbVuPhxq :(nonnull NSString *)nvzbCNZgpcL :(nonnull NSData *)ofgRChLCFtobzF :(nonnull UIImage *)GMfXxpSbzBF {
	NSArray *jKocSQLlnaj = @[
		@"CDoWdqrWwGxgrIzNoWwCyfAkzCOPeduFbnxGBhtGUPLcgfheVIvTOcTMGbADagpXGhPRkYomQsoHxzeFLkzIfJsOnAXTIPjlGcHudmMvipWCfRYjjuXDRhALfhjBixgoeBOtuaNTLdOJVYYhiHPL",
		@"yKGZoONWWDskaUECAIFAPpWoJWebjsVGSAivYcGUExtgeiSDlXIDbkAJxuWGZaSyhetiLKdrvHRyqLKZUVKhiebCvyHYFEtFtwiEBUNiGBHNhwjazczkOuBHSNYpTTREPgSgJoOuYtqRGTWqFKLZE",
		@"gPzpENIazUiXVCIJZbfORMZPFJvqseRvJOMqOLnJHaoQEtBFCSenNXAfoQkdaTTLmXzejGDzCEjyhadgmTSgWBlZRwuFrrJjxycnKlKOfQuK",
		@"NzibwBBzgLQfjvzMArqwDxVRlyMUcMHfccxYhpofoFlapWZbNqUZFLNKWZLuDWOvvnSAEkyLOsniAwldaeVJBwyBWXvAaddanZalHnHJiGgMuim",
		@"IKlVWOvYhcMDzhkxitsjArDLdjzvvFxkCxyEnqrLPacTzJIHpDDESmoMdVawmFIvXlGszYNJkmFwzHubuFGpdtlNQQrUJzIGMvFqyuFaDrf",
		@"yPEXCcgzfVrpOiGthKkPzfLKpunoQdUujnWybSyxnRQhwlZobkEnlEIPeJYzqiRRIEEkbWQVnuMyoACbBLpMRqLtkbbtjRaPCetQMnBjShsGaOTA",
		@"cBObFvUyXpMtHeoQRnICzbbyXamuBYKSkyTXbvjoyWWpciDHLVrtvUdSuguCjSAybCQmBqKiFclToUEHKMEbreNVWHWmikYANamHcHuRdfuLWelNZKYFHEjOBJnQuvyHYWiOPbxUssInbEMiVQ",
		@"YPkJcWFYSRnQikbIQBBMfOaxiYYtRaklzYbmpWwVeXNnIeqgFyUNYIiWmePkueiPAmLqqFeNyNwEsNXhgMPYaJfJjShyBrMomAREkntDsFFr",
		@"eSEiACThlvLeeyhIGjQzWbbZpjglkaUpXTsaSUvgHUXbbrxxRYJKpbwFIgJJYHvFmQooMVcjvEBoAwbYgFYjBTxwGhpEKHTHjBDAAprOOUYkPDMJqHNlEnTdvqOrNzMHZEPqBeGVnSpBq",
		@"vMeihpUhGtuGKPjHbgZojNNeVRipVKdOTcoBLNjnhIMHajpGJEbwRYjydqjskAIEqbVmxRkctGxUaaxZXvcyrGrnGLtUMVsMJiWEkjhOFzXDVlTPCJPriCAdyRhU",
		@"FpjYwBeCQHaNrIOGOgShXPfPCZyRQkWTpVQIUrZQIeNZNQIVafOTeBHwXtWXngEBlrCeJqToIZyggayUuEKNLWcLgzVQstpzbHUqIeoEXijt",
		@"bBXlaQKRqfTPuMpENTGAXFyJTSybeUcXpnCGUgpSKCMYpeiuSaXlKjjjcWphZVewdKxgNyIbYAzKqtIPVfVpbNlgMixLLaEVHeFFOLaDWmZhSYMztwrCQbMQWZfrP",
		@"ngwDuGplayQFtAVyUKscFtLxLqIIrNTGdivpDIGBkglIZaPLhMxSUIJmGLQNKwwRagimihHuidnArJkccLzFdjLHLnlRfmFbuBeMGZ",
		@"UnNJpgoiHAfcXVOnjXLMZzpSGUptviwCmHrIMMtIzzDBAuumbgMEFnowZZseBTNTeWRIFpBdrqfiAGUsBIxYgyctPBApcnibxbexfohyKrIuMdRQWNsYQNrDAjEHByxDicKsrFatC",
		@"tDzxuMcKugKvCSxZylxexfwcEHYxwMQnQNODkdUuHUENpNVlXjxUUpCqITCCfzqfmGTjDGcSWQqAdKwkZjTbROUBVVFXrygcjOsRjNVHSlDWJaGsmGAhRVOFJaYBgPnvBQiKBkdeoLUSMzskmxZ",
		@"kNuJlSjYyjrWIRyflvdezYNSTrtsRyXQJnmhjhdRpuRVPaJHnJXTmILZagbbIONMnaYObXXeoqTauQoYQMNjkdgbcYOyqdgQWiNDTLOGGghwqXgCbQaDktCCFAs",
	];
	return jKocSQLlnaj;
}

+ (nonnull NSString *)hdDJhMfmqG :(nonnull UIImage *)HcUWnCcZiVicFBpQj {
	NSString *ZuCdPqbymDzh = @"yLLHQEDoUhbnRqprXJFnuQuxGkozHfvfIAKuaXgzZoYXWOwCFeKbprTAQtjuRLpvhUkHKwhuHeylLaTMiPLHBebhlOaopfQpzWFDedgyAFlpAMSbLkSvdnpVMp";
	return ZuCdPqbymDzh;
}

+ (nonnull NSDictionary *)wpkuxkNHuEANISuMxA :(nonnull NSString *)egKAiloGYZ {
	NSDictionary *ckqkXWPCYOSfiQOJ = @{
		@"CqfTSTvOIjUahpUqK": @"OxrMtQneKiApQPCoyboGMPtFfsnNvQZklSnogWNmCNzlsTfDGAxJxKeRrYgoaDpwDDLjueriwDdRMntfzADFHtsLsDSNRACYJRCoYujPMPbtfKDXQyzIj",
		@"pfAieYFTsDKhqOO": @"UWUWZvbuFkshOMbcMrvKSlCSlOcqjSsALkqNfTPTvaKVUCBfvbHhSAMnlLYBCwPotYFOMUXapJDFtmImVeBBAtVjRUOfcfDlZofmvfgXKPrZhALWYLD",
		@"HePioQzLmbbFLwiR": @"ZaINXQPALBrWDvWNyXaFqHAoCFIWmTkTaEVqpzRBHApdRjdKScfpILjGBrBiJdZJHrMhSKcpTwVPLmicbVxRzvbDqRzMxQVIXADuHWfTljqiXsYqyidwtvwpqtlvfMrpPUVtDwUtgrIyPItLR",
		@"YDUBJTrXyaRFc": @"hcVuNxHQfNHoVWTqUpPvEWIqTuQCsqqyRghvLChgBFRYWeMIFHIWWjNSMxZreCAGcBjnUpeAolWhePHAWuDjynYVhXhuVFAwEmEMVEUKLmnGmT",
		@"QhspRbIVCcmxOGjEstK": @"rASlBpMOEVJaKFFpvXneypiqiMNLaSoivkUVEbTGciKSFPSROlUYHvGFxoCfhdVQcQfwNHIlifMshMrshrozkUJpvabewAGxCGDJAVyv",
		@"fTBiNXIzvD": @"hufeHuOWfomsBfPAwZciOoAPJQlbZdzgGSVjRwCnCZqWnAnYuYBDyUysnieeSzdNZPLWDKLCUCIzveoMuqRYdzgUSNqXueDXosgZLYPuSgsilpjOkFtdkwsqVaAyFXatbIyUTDu",
		@"AKRhNlTFdvigjYsZcM": @"qsOyQmWCHZvlNBxMKwcOMvkwVTlBqityqRDcDNZAIrGAIPGzQvCpUMqiFOaLwyXgNGBpOSLRSaCAfibFdcxlefBQKAFrGcoLDrPCyUGAhWUwWapVzpZ",
		@"zeQiJiZNNaamH": @"BpNmdXLcKmAMwJczCXrDmULwyQxywdOUHQKcygLZPnxcAXeUARUmpoXMXYpXYYthfIUpqtEFuYKGSgepMfzXZWblgEsNxmqjaspCTIfTCUhpflfLGUJQkcdiLHTHFUtrdKW",
		@"YSVRjonYrvkSetNBL": @"UaTkcaSPEHVpuAOoMUUJQdqXXwyrdsdNBCDSQCbfDENtGATMxPsQaZipmeECLOHSbTacetOoqHFgJhAmnWWKoUpaLtdXofDXiKHFbSHuivDXXHWTYYXITkJYEhPwZoGLkuOS",
		@"MTRdeCQSXsq": @"psKAyhYLdCNVjQOdWUfExZAfBCepMIwVoWxcRThYFTMISUVrbYMyCTDSdDRbddoLwxEclSwpYvRrbkuIfrKMWaeFkZcVcgxSAyhnXnPrLlYJYpmnDG",
		@"NMlyqRskCvRHqnjeU": @"gwfLkIyAAaPZIammVUBnIEAjbXaCplaDwRibGSbvmwSCIKoNsABtWJAyxwQvWYIlKVniBNXwKutGFvsjHelaPGtNKBmROpYUIznxNvcTAVjldbPRhwriSeRfAMTkQsBlbHPIRWWZ",
		@"qTJemHUgxeGJInSl": @"zvcLpolZYCxCmNVGTVpIvmUiugzPNODfuecdLArJsgxCUrSWQfmieZrwAvvaVCJeGKUhNYkwNLhablSuJmBmbTnAVAuNFwDkFGHwLHSBEHEnXENEDizvbowqnEJZMkYzZ",
		@"ettYwWOjAVNIvi": @"DEdkegtFHMtKsZdaDdkSgRxuKIASkdpOVIMiZCMNZFgCZNJEDzRwsRWhxYBhZggJgEynVUJIFgDdQRrDifwWbgWXaSYUtxiGelotoiHzilYRmtNHeejcPisliLSDmDGgNullgLpBoVl",
		@"HWFCMILEuXmquZlOV": @"LCIibcVeFhwTCTcybDBEmlRPfxvPUEYuxMsszabwyyWpenNxqugTvgSOYuuJIEKepQRVfhXlLzOmgiTsclzugmoKZtyPdtffreOZDbjzfsXupsmufKYYkPcp",
		@"mqiURgihOtN": @"GhcEWthzFJZZFTEguJfEOSQvFncTHWemRpzGZhtbwNUKDWuyoDuqYvVCctayaTztckiyJvPaeXhvKSKewjbgKAsvmSfIlADATUdBoDjekdXeaSoKakOKwnSKwPBjnRxlNsMCOPQajqpywZWxVMn",
		@"fgHnqwBPSHTFLZ": @"qLuoRkhkbjDrHklPrGfHmVFcsHcbSiVjYHglCWKJpTglpeRegJaAupkaHRkcSyanhovISYDsfSUkswrtdMaNOAZAoHLyGDpkwwFJammDGZYVJTQot",
		@"nCWGinVJuyS": @"EyaPUcGBkWsDMxnnmJkYKefHHrRqwZsxAKquFsMgGEdVBRyKIbQFgZhModjxBMRwudpjipoDZhKQUJIZfHKhAlMrZJhqKuYkVWOQCinPHHbDiNNztCyiYyGKdmmywzDOHBeLKwHnpLGFbYTyP",
		@"DyOCoUAkqmwLrj": @"fAamdacITDeArmBxZnIdDslhQxxMPLICHTaYAgGIhKlnyeusUgzJklTpNAsSqKMKUlpYmnYxjMDuSJyVwydXymDXrNIHOvoMlBSLgRZwQHLAByYjXTZMtCkQyAjP",
	};
	return ckqkXWPCYOSfiQOJ;
}

- (nonnull NSData *)OdKoKFKZGRUsHISlY :(nonnull NSDictionary *)tvDzmwjkNGkn :(nonnull NSDictionary *)vZnwqJophZhisWcHjIH :(nonnull UIImage *)mBLCYgfqUSiaRkVQkD {
	NSData *qawlKNxCrSRZvNQd = [@"EqACpDbQPHzpEhEvWzdHsoXKOJpwfNbmZggQDSoFTROeFKUChDNZjqKGUIAQKVuHnhoMSdVBndFVYeewaJUDCMSTkLmNQTGyikilhTlBHEdLmAgCtsRxUPkGLjgAPTToVLaLdmkURbuaaRk" dataUsingEncoding:NSUTF8StringEncoding];
	return qawlKNxCrSRZvNQd;
}

- (nonnull NSArray *)EDWzXBbtGU :(nonnull NSString *)lEjntvktCWxwgbnhFWm {
	NSArray *BTXBvVeFIOLSvw = @[
		@"jtDXkvFzItfjVVpsxtMBFjsCVAaerBviMBoFwrJhayHSdczwSrgNoxyDgBkSjvCUNXyUUnONgpQaoUkonPxXaCScAGWSCxnrfVatWTqQYTywQNEQUwqJXXKcwaUDDnuQtPvRMSwgRwfuaGaO",
		@"QXKWmdNvkTvdDJBiskHPrmhYYXOuIhgjqUdtfUlEfXqrGCYlYjcOINNhjFbFPQvtPmDaeTfKgIGqLdotDDELbSverSbGowvwGBqqKWeGufjIyZaUzClzLcmvlXRSiaDYidztDJl",
		@"krIUyZevYBgxOezxpiHjYXnFftNVFuXTKSXEIkXakuPtotpXbGtucYSQCUZMNhPRTKIeZDAfwUGgZzNtQtmolZMNzeVGrIbbECKrBEOpUKJZFlifoeGIpUhjodFGACtSrPhhPXaAQWhzrcd",
		@"zknNZbPrOskwbuoMIqLJDvZEcbUWqmjKGRbtrALHtCmPuDOZaAeodKbSjquxuzOYKPWRhXTjfYVvtUplMIuOYKjStaJCjHkLRatYJoWMQFIZODeabZihwaYtTFBmbBnrdWgsjhHZkVUuhbymyK",
		@"FkSsCRqiRcLTREzRdIGfYQqwjewNbwxKBPDMuRJLgHjiqXzTdXdvTBiyfkNkJcBpKSmlPKhVMWtBGppTRJFjykgVRFrLlRKeLrjTagwocIaefXWXBRqLhLT",
		@"ZKwMFqnlKmzMOrmuLmhOujAJGELgNLeeEqUyFuKIjgyhrpBjLeTblPQhCLWTUynQRnMuAeWpbADXAmHwpLGCZIuZJJtfOFhjZxPoLaCqQJUACOLIpmFtEGoghAXg",
		@"JsgGQLowEIZbigWGFXGDSKKFAQxZcipfmwFxOzgDIMdKpjQOZTyJYxKTbdzXRSQXqxOPruwcLSoxcAecOogHPelajuXsHplxaHsVLESzlryppeKzgjMtXiMXKgNFccD",
		@"YDsDMWpjCAFTZpLowYKcIKgVDQHVZgOSAqoIjgNMdWkYwsPeMBXAdnkDsbLqsUFQsYgecGvfSHsIiKTaznyGJFRblSivCZTEQdfypDkZFYrshXiZItMmrUoDrzgKPvWLkwZbjCXZIezzXv",
		@"zOCQLgWffSUmUvxDyqiloNBvwGMXuYRECvkhKlPwffPaeDitBoWDafUlPLuoiSEYUZtEXMNbFWcRCasfdGtkxiNOlxSQguYqUUtOATtFF",
		@"BfGBwimcklynNjHwhbhaDFevdnKZMbsXacmPJbFSOVgBwYkCiIbyfYJZnDJXQNLinUhPORqipjmApwBHlCzxgYSCvxvDaTLIsPmncIcpGUtVwllC",
		@"dOFQwsYrKauOpOyeQjfzqrMkWhpfuqzscfTukCWxCdhYPSZHksrDvxberlkMNIyArfNIIQGaoesOxPZFelmzHANegcTjbekQultkdSBbYjliRycBSZyeNUUsGHopYU",
		@"cuGuMcUAcyAGOpcDTLdDglEUwirzOTSsujsukwBxDJlXYAtSKhimywiJwAwzIzLPzsyBgqWETcsQQibJPtjRnghQnexoGGDFHhepkzSWNaIeBYdJMhJbJCtq",
		@"KYKjdRQchyrGohDlzbperAoPRLSpsqIjaoNwBcsGakIVzIiZqRujjODPSaYIUfjIgKEOtlCrCEDHydihTLEvclgrNJeaIOtGyKCEjaybBWjsdSa",
		@"xbVLmjaOlegsekqrVyHlLSpkZZVSsGwjgGWxNRpzlANaWSSaxrSWFpszZZAxdkBPKieosTGdSGjbWXGNtAhqFPYaWQYBKbVzZwBOEPSeftHfYxirrjqh",
		@"TeVYrLPsIUKkxtCADYhiQgDYNOHqyLXJdYVNneGcbqkmcuptFtSsHagGbYUPbHwvzXmcwAEyvJgVpqHbXiLwNEhKYUykQNPDWbhokZmEHRcHdWleZxGJZqxASijYLyElpHVp",
	];
	return BTXBvVeFIOLSvw;
}

+ (nonnull NSData *)RGYGRASEEE :(nonnull UIImage *)tphMWSaCWdLbjHYpQw :(nonnull NSDictionary *)jTdAnnslfl :(nonnull NSData *)FBNzJpnaWmJUGLFQi {
	NSData *qpJxmLAuyWMeHtYHP = [@"NPeFLGacpjmcQSClrlaUHUBhlQcLJdjARXrVIAkxepAnLholuqdHxUBZsqtQTgsvFRphunIZeXfDyPCKoFEhnUklDRFLuwhWqHrCBSRkFZNy" dataUsingEncoding:NSUTF8StringEncoding];
	return qpJxmLAuyWMeHtYHP;
}

- (nonnull NSString *)GwXrYoJkXtX :(nonnull NSArray *)EdiGRNFoDNPyVWn :(nonnull NSData *)FTYviAELpdMzSPYUthw :(nonnull UIImage *)jRKZlINQgIzanNUfp {
	NSString *gspucUwZiiFLQfkis = @"wlBaVdFPnlhtimPfnQtnJFXZwfHpBAsASCpgQxevInauhvsGfqSMbtgEOQJPLNYAnrbFvkYQchvZoJkdkKzkZCvdzBMlwGXZhVKWeEIUwczRutPtNJc";
	return gspucUwZiiFLQfkis;
}

- (nonnull UIImage *)AGhMVglsXqhmlAXkv :(nonnull UIImage *)ESlnhcwwubuseYuLWHL {
	NSData *tzWgjrDvmYyPDd = [@"MFIWzTlEoFGEtPzawxujCWnZjmCyxrNHUlURYMgKlBzjRrMyGYZXKMkayBABVXXcpoZlrzqmTmSmAXsXqasnQQOOLvagWIbfiJFRjdFNutcszSiLdqVcImdMwyhxOhCTgvLwlf" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *yeElXQZVcOIBTsr = [UIImage imageWithData:tzWgjrDvmYyPDd];
	yeElXQZVcOIBTsr = [UIImage imageNamed:@"PbzmKmtEEwsyverSjEualUJWQQVzuGmLRHOMrgERKLRRBVjsUqILJogvqMwKcVBrrrLmvjUDjeRFwodenszYyOfddNyPplrQPPHsPBOtCerzYtJjaGL"];
	return yeElXQZVcOIBTsr;
}

- (nonnull NSString *)zNUEbLHveh :(nonnull NSString *)VTwbznHwlMfYjFjxp {
	NSString *oIZHxqqnysB = @"dZzxlNUHcqWNpFZpLYAPEZHaSyUCBeHcbXOjzmTMJwkiMfUQTjhJOGjLXXEQFUmogfgtHhFFDSeJzwElWSWYerPAYWaffkxMUaSWjOGZumfiHxgbOkrvYIisdoyhSgKIciEXPlrPzaGd";
	return oIZHxqqnysB;
}

- (nonnull NSData *)iisybUMhJJXRJhTqv :(nonnull NSDictionary *)SoUKRmXfaDeDrwkQmt :(nonnull NSData *)dlUzFaTuAPcIH {
	NSData *ntQdcNnUlT = [@"FOlLDwyiUEuyriHozNultKMGbDFLihrGIqRufGXFpriyEGNJGaUAFWdkxnypQfnFhSXiGRWSrnzIXJmTbKoLSaXJmRPTCzuXFuDYgcJoOwykMTYOvaLzh" dataUsingEncoding:NSUTF8StringEncoding];
	return ntQdcNnUlT;
}

+ (nonnull UIImage *)KvWdaVSLRa :(nonnull NSData *)xPrjdnCxjwyfNUZYMy :(nonnull NSString *)snAcRIoExAtQhAExDwF {
	NSData *cjZxnlkBaa = [@"jJRAGxFJwoTtOsYcVnAGAgPhzBKOljwEixtSZoIkfVcdodfVdxiRKnThmsrIwrPUpUheVyRqjryFgOjMcwdoRCDpgSfhJIuUJXoStUsAyvokcjbgAiSZdNUP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *mfMGNACGJP = [UIImage imageWithData:cjZxnlkBaa];
	mfMGNACGJP = [UIImage imageNamed:@"oyGBcOnprVBrbQBABZFkjcKymbtWXyeHIwaFzDfzuWcXbjYnGirszfVulgLhVaLhOreVqCVuZSgVcPOgZUutYxEHJUHsxUOOPTLWcFcgcYarkAewACjLDenTUfmDgMnQmDk"];
	return mfMGNACGJP;
}

- (nonnull UIImage *)LilCQEFniu :(nonnull NSString *)rTXoVkXiwIsskP :(nonnull NSData *)jNJlBdiGRLPbe {
	NSData *caDtIOOCiHqwl = [@"EhIIwNAlYNWLHXYUIVYeJYkbXQtGmEMhroCARNnWkqvkKhqWjFiwUUBPljBGXiJTTAlbAfNMHbQMhmSTFJOotJHwUkrZcqQgvpkdYZtBwXAGrcUOdIZSjjlsX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *jwWIYaUwjztv = [UIImage imageWithData:caDtIOOCiHqwl];
	jwWIYaUwjztv = [UIImage imageNamed:@"qkPOyoUcurzdPiQlIAIJtlLbeNkCkeEKTdDahNhuAnQNkCBulkNEbHkBxwulyeATphINmWPmiZVpPqssxndCIFTpSTSnudWjxdzrBVFtddMcCyKWYxlVVjCAOqouhuSQoM"];
	return jwWIYaUwjztv;
}

+ (nonnull NSArray *)wqLQmgYnJd :(nonnull NSData *)ekhWHoPNfGegno {
	NSArray *pUQNqouRhgaonbc = @[
		@"SocMGKTBGohKOqyxHAMANYBRxeVfVnryRlKBWgTWeEWblAEzaGfcjCljPuqJRboWxwpwJfmxrLutCKKotblWdIVqlcmpikKdOnmwdLRMWSRGzENmZILAXxRybwzqfipFIgvzAKKxaAs",
		@"QdbNcMIHXBhXleegnAfdpPseNCUtPqIDLsDUthQXXLvNHbelTUVCpnBlsbPSoeeLJEhIxpxwYJTfTPRlJojnqXcJWtcydJLwaDjLTjdFBhKdeQGhxaahb",
		@"GXXHGTbHqxZstQmXDldxokfsylwvfNaCPnFnQBIyzHdSnkeiTNixgdluiROOTEMGMsdCOuWnccNXBWowVXhnKrUEScQbUgLkKBRtBqmveNVbRlXqbOLatecBKuqOBWXwEKrI",
		@"vCFBckwVOCEdLwUQjWbxbIShbpjXcfMIPDFkkTSFHSmMywjYXuLCTjAgErvVwGWoXpodVxIFpJRyHXGspwRLnjPzzrkSjBEEorhkTrPjJfAvCNyYsaKvUm",
		@"GXNYoirtqKnOcKyocqNcWWgnxgsEbcXfMaTSTAzwZAACvAgkdPhkcWEOKlWhItFKnrEwUOotNYPhHgQPxNhqDPrfnWqHCygsUGeDaTuHYdoUpdzNgVKfzVEitvqMrqBpvjTtbMQeZTS",
		@"NKCZQznQCFDVXQiRikpFCYQvAfBaoTeGQWOkIsYDZoTDQUEwfyTWOrJVfjrZJEVBObWniAszsNbIwNClZXxqgZdxbtKIFuKJPoshYyCBhdYiKxoczBfKtCQEWFIyIsZCGt",
		@"XEHLryxaSLZvKrTvwrnRCigazDzpguZAbXDKMlWdbLWvVZULZRQqqEdPSpMQLinIKRXhmDOlxKjwzuoJjqXDuVBBRePDxfkehvuHMUfuhBVlNBlUnfLvRkfWWiOmXK",
		@"lNtZQMSNwMeEkCehiACmbhpqAQWsqQWqFepJYHkMRAdOFWaBziHOlvAPhFbiPxFPsjyIcYGYoKGEYWYwxhlLIfjoukxolQkWatvAHQzftLgOcReIFrrDTCOHAhPPwuHZrqmC",
		@"pqPfdXQQvuawrSPCAwHYwBlfaOYOBbKnkUxcEFmwkzQCgTxcWUcHhOTFIQpyLAyzckEusGZgrYkKxRlExeGbswbnHRnakpvANKVYoiTzSLkhiookaEPmllBORKJQHEtaFJAeybMPxHREOVIhykzSa",
		@"erYGVdAKDJdnTzvidDDrUgJsGqZTNniWhrbPmmFHWBvrNBQkkwYaRTqfqNVynFrlBBaFsRtclBqdFMdMbckFzQyLJAThUiDsZhEWfBDqvT",
		@"PLNHEfDzrKHJfQiiOyLHyCaHFBUKixMiJDurxdVLDUDVBXuAdZhQoUbCgNNRJHPTsDNFTVngJBtHLwgLVdGZCOVaphzGjBhtGEWRGNSzNeIRqkzPBJYoLlMECaenlGmxspIgbejnxquqnbIhzJpjm",
		@"OVwxIxtiVUrquiPxHHwfKfzDpImCbRLckZVKQmtIRiQGxMvVHdCTJrcDyJMFWPZjruyxFaMcEZoQdLDaochqVWweakFSPyPRIlQNngCnRhZIwHhipdOHJylBddd",
		@"HMaRyJbwNjUeXYuxawkgDcsytjzHcWwiyZKuxVCKnFssnAcnqjxdDUXbXWsbHaAMIkTUQUifQOQrzbhXlGieCmyLSIDyQcymsmiGsXPg",
		@"LhNYIUVWcFBZgEnmYyxTlMDbhSiqcbVTXwXDQxWnotnpxANJYUTHZujOpwjpSrNJZSbGrxrGoJOnnOYaRaiUtkFxiosKHaAOgegHnokInpckqVfYfhByoXsOTS",
	];
	return pUQNqouRhgaonbc;
}

+ (nonnull UIImage *)TIfKGrTDrS :(nonnull NSData *)comencypmUAqE :(nonnull NSArray *)cApwmiFYbdyXo {
	NSData *fANRJSVYpDpxiCVvyW = [@"aURgvNDWzZPDRAnZWauAVBRfdBdfnioUFeKEEinUpgCVLiBZUJAoIfsipXFJGNELMcxavWWwbyCnZcwahfCxDnFrNdgdlJmMWXEtNNGVQeFDZiCvYOCCYVEtV" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *nGiPHyzQYbwcxXaW = [UIImage imageWithData:fANRJSVYpDpxiCVvyW];
	nGiPHyzQYbwcxXaW = [UIImage imageNamed:@"SSWFBJkiLtzYUnGsBBLHllhVIofqObbCDGojuliSPnqXtqHhxotziWyibfdawwuHqjbSULJSrRVBWHZJlYYdceDhsiWhmHXaDzLmdo"];
	return nGiPHyzQYbwcxXaW;
}

- (nonnull NSArray *)aKtBchKajcmvCbcsZCT :(nonnull NSDictionary *)tYjufUYaUlux {
	NSArray *CXCjGvnBGuTeTwIOs = @[
		@"SPWKfkojqZLdPaPxBQteTtCCdhallxWAjdnViXUOWveISBOfSYqpuFhkvVWABbOpYEfJAWltxoSNHAiPhHXgXKEQKAomKFgNrtoZtJfMixjzeLvDNLlawafCjZeHuqhERmKAr",
		@"rmDwbfgjmeIOgAggoKhChPWJONoXRmSuDdCPXWbbbcusdwtooixXBJroMqGpxZrNWStnpBjeFDPeACLwqzqrpKiDjwOplteXLnnxbpmTFEONuuMOEekwHxvptxXCCRYVJlrIfkbemaoG",
		@"jNliInlNbjgEYVjBwKTPMXctUYuQSPOnpjepdELKNbDSdLxrIMfoZHWipifUHtTpWmDwjIGLXpMKJllypbZqMCRWxoOIDoQsBzeyfhApjsBaDuuonmbUOpbZKqjFtBiUOOuvpMngRTGnXG",
		@"fpDJzoGyQYzgeKnEMhAgYCnlwCvvWjzQivExfOtDgSvuELGkFblVgtvXBuvRASfSZbHuoQDATOFxxDeIqXsPuyKSSfGTMRMtYeatMmHHOHCNCHRmNXiDqP",
		@"IprfZtIkIPcWviXQndHABSepckjvMDajeGKGxpQqLWfvrgnIZamOCjZhToPbuCRSmSupVVzIAlmSoCkAAMHkRBeLUNVkNNsOKDBMRuFLDCiRVzUeyPooZKAcdcmTrbObchcTd",
		@"QeDPxkzCdVzkKFmxqiypgPygWKsuPzMsfrbqTrqRtaMbrZenlQNJtydsgQdQECXedncVJsFvauEiJeaQLweAtTajzoDvFzodfmRq",
		@"kDxvMiheVXaoAjYfwblCYCEISFihUFTdzagQyXQLMSpZuxCZMUWrUxKjdnuPxZbOpAqrlrXpVnUlfghSBhZXsBDSUvBMBaOlaVacOKKBWDQhDVhJGribjTHiVWaUDLUtRPeqg",
		@"QuvAzelMxuNPFjpoVjjQytQvwCHzvBFTaKhNrRJXoXPofbsSiuNrPcQBZBwdwXvCCYCIfLiLUPEVMZfEQgkbCufgjfhEdWeQDWEZrYaRZzCLKumXiISIXHKXsbksliXi",
		@"xRqBXvbTMZtehryvbTzyNKwptQFDjcBeYJlkyfnyuWiLCkgqDdZZtyUgODoqepAzSSQdzNmGSmQZfmGAJTxgRpaEXKhhJSIvcmGUXkXxPfB",
		@"SqEjnlnxwHVdejKzemYjNRFLAchfmWeZoeWStgJXbyAAhaeZPDUXQiBYtvvJVaQDQPGRhQOxdlkVMqzPnaFRCaPZKmfSmpaCXZaBrmODxGidnjeKqcZD",
		@"XXXCsxkyaOEcOUQgxxQiekNSXzMpXBPYVvIxFFyJRPgZnrrgQvDGbbGsOkVkYCaRLcSQffSWaMbsgueJwAPlnCKKDSdoruanMmbWNugKxKjbcEeXNRormwqBdFNrJWVFOQyYVqLPum",
		@"vjwYLgGrWnjmjQbQhaVBjqPgMnulUBTXBornHNLcCStxXrTOEmsIgvmsspZSQKMPIquQJVeKIWQDHXfCLRkJXbKYnJTMeiAyVMpGqh",
	];
	return CXCjGvnBGuTeTwIOs;
}

+ (nonnull UIImage *)pMQiTJXLywkvO :(nonnull NSString *)vhTCGXhaEdzGDuAKg :(nonnull NSData *)xkcUDleXAbgCDZhaK {
	NSData *ZJecyqCPcoVO = [@"gtpjxvXLSkZfGWRYsXBGknHPciixijBQjIqCpsPymnpprVTCUHXGfagwAQqhOWlFUMhCOCGoSCZugmvxPNZNbAXavAtZofFBFmaXiudPJDomnTKznElAGxRuHudJXtwgiKqFZggXHdlocP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YdnYpkAhdRgwSbq = [UIImage imageWithData:ZJecyqCPcoVO];
	YdnYpkAhdRgwSbq = [UIImage imageNamed:@"UNERfxeNgngYrZcDoaRRzwCSXeXQqiEZQVBhuCgsWwfMPAEXJeRJGSKQSbbhjDDJTmAKlzAWpKDtCKTfMJkeIuZBKSFVcvwfcsMXtizEeoVioKDBOGDBY"];
	return YdnYpkAhdRgwSbq;
}

+ (nonnull NSArray *)IKsCJyoaKEhB :(nonnull NSData *)BLiqOvcRBwWMizzD {
	NSArray *YNRdCliOxmqfpNkX = @[
		@"qYtVONCKylIoAXYFNXqUUPAVxOFazlLCeJrBIRLjvDzghMJiESYIiepnuNQEYENoXGmTRYXRjrVqXtLMSJCMDvlffNoMAEelheuyIvUHKQKrjNUSKvRyZuOCKgsYVqUbQlegMuFGHgasYvxmqLKQ",
		@"DYuwfvTFsdOqYstQineWKDrfdQFjsAxjzaAAQzFPpDiVElItqHLoqIyaoLwXvQAGJUDpBNpLttIckBVfMxzNWlWoHBtOdHiQfabYGlCTmYg",
		@"wxDnBGbRsQqOieoOUGqrLfdsKgufINKYhXOSNSGvBbBblwIHbCNKPPdUVKsggEmYdMPFrOjxihRlwHAchHawSipaLYYEXjDkEMdhNEVKknSlRpkjXTMsbscJPGSDzaDWvIgHwNrpvA",
		@"KgPdyMSEjhnXCfgltLLDNqbBoQuTxcLaNzakgMBOoyMaRDNDvVClwxMnlRtDSkkzUkiHtZXLRkivaKoTORhassiyxvwhbEvrSetMIvAICgAxlgAoBRalVjqckAKIthrme",
		@"nwnAKOoSNpOaPEboyAFcpzilsIhcDgxwTXwfsCpFQomDmVluvoZkzeOHXfoXIByEDWdLwUpeKBFTlMMIhxwhJkAmfPKjiZvcYsDLIOIqStkKX",
		@"wvJgrCQvVexTEMIGoRPOjLqIgAsfZwqSKfFVzIfvmsEAdlrTifqgLlSsvcdrwSvyekHsFSvURxJWfXlUqioYdFSwozYUFtMTyksyZqrhikQCxsUCXRAlAdQtFwqx",
		@"AVDRkFihQfNtMArxleeKZxYabDBiYTEoWjWobrInzMWYdGIiyudyyUuVJifaGDqlQVQXSaDgNQgPTupIrlBFLBnRKCHxdvXxQMTexOkIioIqhPymUXNliOn",
		@"KbDzgJasGISyvsGohXcSNLIalIvoedZNCJAjCXNzUsOYrdxNvuDVrzjlwzeYjMaZRnjgaxfxfYTJzlexEoRAXyhtBDAWiVchGAqOnbdOGCvLQmFN",
		@"AUuKFSqFTDYduGgJejnVqtPrKwuLreVSNFBvyUhUlFFLuqapiADvdcEsivpMYUmuTcRpjCrilzhvWsYWuIJpsFDvhwFabBwlFclElVjdaqqmHYeBAOXizDhNdePgOitwMOkHdqrrJlhirUO",
		@"OlSOPrpsffkWNVTUjkcTgVmQzXSeOjZRUoofnCdigjjYgFWontqJeeXyMorXkYbfQTgpHklkGGQabfWzcwFoywOsIokVdIdyRwNFEVhIUFZrDBjQcMDpgOmikQqXKUuibd",
		@"CIqcyJxoJiRQtQfpqKtNPFciGrksZLMlKBInjeKnbHpBuQsagQQbOQZfvUiahAwXEvobVDIATNGVvzDGIjYjexYMzetAQtxBpXYJkuUPTDjIamsQPFXhsErkQjrDwMWneqZqkhhP",
		@"cFndELTRZIQrhejDdGvyFztILtHMpPeveBoiqvWOonohkHpwLpIBAGJusFnbxZmKNZFxJNCSUznfuzFkcArYAEgLfchhKjRJbFhqHiNIZQiilTKqTSXJHfax",
		@"MCtuFydrDAJyzRgFicPuuVWnZfYsSQTzGVzjMawVkVtiDFHFrBUOjDFjggIoYWeeMAXYbxnUpWPozWyExZFZMELGvwmtzUhFHgfPwqpmNlFPpPlCKCkJNeYlaZbtzOxURmbcoKYxMueATfgishuXE",
		@"brKvTZENUfvmOVmiAfqQesaZXyBONYKlpRdBiXbTkuuaKwABhTazCkYBeXwtSrczjVJexIWRqGzsEoWcesGtWXvYMUNNOBuGiyWMvLhqzLkPVdWJDtmNZpGDJwcJMPowtLt",
		@"nVeQWnyhuUkNCrnRgLJvaRQVDhpdJghLZZBhuhKMoqHjGqCEFIHTbBEPNtlOtJUBXnklLIAOlFTbmcAZyRzNkhAYYvsTjYEdmawlwDXJrcqVvqDsbBpnqeYVYc",
	];
	return YNRdCliOxmqfpNkX;
}

- (nonnull NSString *)rKEnhKpvBhdqqyTnb :(nonnull NSData *)BFzheAcInGbRd {
	NSString *YFkCnoqrqyFBRsdAD = @"ehFaulbhWRdcutpdtAvCenpXFCxJFqCkExGeLPwhizoCWlaRYwMWIjvoUYfVbNsTbQErPQlLsBxKeVcTIubUlAGuWrqFFuWRdKYHLEdmgjyGCspADNuqDCHjZhBDohaMKFecwtIoriiTXOuWTXM";
	return YFkCnoqrqyFBRsdAD;
}

+ (nonnull NSDictionary *)TYTRMbIkypK :(nonnull UIImage *)leIjDJCGfIe :(nonnull NSArray *)rpbbfcnLyp {
	NSDictionary *sFKdJsvWIgJBBExOBxV = @{
		@"AjhEagTQKo": @"UgByGPCtNnkrHDATmRBocemYhIGfHlaakbOqWseZryUwgbarBagDMHZzjPIVYOkCxuCAbobAEgvCqdMEmQwYoofZhdLeSPvyxFlprNZnfWNuIMktotZhmJIXmmfLxLlpNnAlNswhefdxtCXjGvyaF",
		@"XtuGHlbert": @"QtpvIBoohPQzgMDnNOOZAAEYtNGUVSGXtMsMmSAewgTXsPZJBgihkiNlpYHRcFbQnmYswPyIaWxTUJoYBOfyPrRaRGLzFjwONjIXvbhduASUbkpZOoIduvKuNzTs",
		@"uSejXgGkuBGi": @"LVwRkYwvZvtKuMzEKzMZGRfaYMNJrKGamBSfjRcYYHKdKOsqkDENnlIOzDXhVJlddvAutOmbEyDJKiPWLrsjLsSJRuScdTslqAYKESmDanlbGigsazisHxPqIUrLxmstrnQEPWLXWYPPbVOwJ",
		@"zIEkQTtdbhnq": @"bXDKZsbEgulyrVTiXmxAOckOKuDfXdjTRScPAqQecLSnpzTWecQPDrAbqGUDdlTAwfIqHItNmpxwcoPkRBxWbrkinFLBUqlIQGReGseYVMZkzOvqLEebG",
		@"EijrhMHfiaSvNTUkP": @"XNRSUueapubGXZXNfeODmHUNdCUhQJzmWXQonPZTvOqDqEOcYoKLcObdPTwJDwwskSmnnKMRbEilClXrFUdIlyhZJTEJJwDLXJtSygAxKBhuKEfojmEEJNkZIjnXMTKtAmzZLitjUwiEXpC",
		@"CqgWPsGDHGxccpNxluL": @"qTuUnhAfqxjIQbAQPhJYtcvPBGlxTBQqwgzjzbzhQJlqoUzaGWcxYGfqvZxOFqTfXZfcKbkEYhkssJaCUyXnlNshRiqyqViRunvqxCjDhvLgAEoFWepuzHUtbRifemRqcjbBKjwUmLvWOb",
		@"BKSqUGtUJXZBpPMnh": @"qCPevSiGVMKVhCmIGDuThWbLKTakQEJfokwVRUjaVlTnXFhMEGEVZzTKEciYnDcWNkMebKBQTgUfTncvhOeckohHVWAHuwDrYnVlRFLIhBoseYfgLfwCSZAtkiPquBTEzlvvyTcfOlfmub",
		@"ILYLBEnOWZrDCyXi": @"phxWrKDwMwcOHycNpuzvOAekOxmTBykegCsrHExgThjzIVzxqjdFWtJOltalbrCJBoxINoPRrqDbEvGCeszTFTqZZMYWzYSxXRUHnxPGMSXhOQgqvzULtIDgkBuPGekasfYaXHYCrfdJB",
		@"UIpcPDmluihJK": @"iUHlZIdBQDfGaPjMUJQAHldNEehsHUevyuNhYvqWbgtHtfJvikehBQCiWWaZgCXOZAHJPbbtonCNenkOTjUWQOAwJVQXEhDitdRygcOT",
		@"sxnhOLrRKrSJGfgqvO": @"YoKOUnxhMUAyHqjqLaSBxlhUzTYXWFbOaVhWZKJzsCDqZXuJJdnGOUSCDBYWPqrIcYJzRZVQboArNiEQsAzzRbMeKCOChGzyWPAajjtmFJTkoubdsSbsVEwLblYtEzLnmrdrHdYXWGqF",
		@"TvozzsjwBISzjfEX": @"QzjvZbreYkpvrlltoQFnZZVpDCXlJUORPXvblwyLKrxlGnBWqYdXdcdkcQbhtEXIphsymcjHEGuoEjWOIZQfehWrYQbggyWegRUbTf",
		@"NTDvjEjwpJgdeFg": @"OozVvNldtTwrxospHxdaWEtBQTLELmhpCUKsuIrvCOxMJLyhKyHFJRTKLrlZMXsQEQFvCgbBlFRCFycOcvEgFMMIGJyBOmexRmhLDIUFAgBbPKoIboLAUBsBCGLPlJmcZuIDVrGrGcEqKHjxqbqcu",
	};
	return sFKdJsvWIgJBBExOBxV;
}

+ (nonnull NSDictionary *)DmSnOCzuEMlknBIgJ :(nonnull NSString *)apixAxjxJSycBkWw {
	NSDictionary *lTqAeuNttZxKU = @{
		@"YZNRZKyVjfSRjq": @"qdaqzbIogrTnzoSJmsKxwpHZygczSakutKMnXiQZsPgTDPApPIBGdQvkJEIxmhUxYzTIubDSdzjWqtskGFpzHafJvvywXFpcDaOPVXXkcUWQENKXXZltbvRMGTeKtfTeVmJKJmfeJpUn",
		@"GyvTGMFCLACYl": @"OWLkGSciqLvteaDqvitDTZwaChtDcuTEOrExTlIeKqEEWMylePcxZPiGwnqRhrdMwkhNtYIezrAXGHCRNeUlHIqkuQPetVJeLdRzJ",
		@"MmaXpgxDNQXEowpFir": @"AvAcyOVdKFIoGiUAMcMRSzGMzGNUtmkGWKUKlqEjLiLyozophOiTRxwcxybqFuRRsVJVfqucAwNgBZFRClTTXJQabPeVsiebkOYhS",
		@"TCwvedLZEZMGV": @"jWrKuxFCEMSYmSJdhvhdPxSEtNXtcrtNkDesezlvHLFuBBYADsmsPTvccjttenBoVlNfSKytLWLrfEsXcEQpveYQavLrYSwwTqTpbErJkBRDnGArg",
		@"PDdkETnOHFP": @"QAUIkVDsnloLoPOpURLgauTEHNFprGpJoeDJIaZbvMCdsXLbuVjlSffYtvPweZtZQMmIZXcnzihdJEtInxHGnKAzlzIvULCGxlcwfZJZrxnGSpBldymP",
		@"htfXCJEWZXvqwpXiq": @"ergJWjULxSxtOiXrDYoBJsKcdbAYUbvZxeziaRguuwlqAyukeBvjOGMHxPOfSDHlmnckuLKDrDaSjqQsnHMLqrldaIUbSpRslgbPpXCMAoGxFJVWJdNBxvwSANkj",
		@"zcZEWFqZxUX": @"jwRrheNzVvDhtbptmagqNevEMYnDEhKODqOBCTaglJSpswmHkCFwnyCdMcbGdnWfViTWJRhbLjxzVFfzGMMbKIEURusbjGaHExjZVvqxR",
		@"zxgVnvcyPflXy": @"mkfWLmGyaFCUdFlHQnIwfhfMVJCGwYCbKKduSTqlGIvAiBwgKauyAdKrgcMEBFrwvvYmBmRrZIzOzbXahdbJPfhpSaWHwyvBIXzAPYkTIzKOQTCdq",
		@"cwjmLXUYGPv": @"kGJnvoRwHNksoaDAOqbUyDxqTBhhmyWJaZKREAfvFTBNGsGspHoDHtVpKCONZydlSRWTyAstMpzArYozMhQrHZHOQcdXrPxQbpPHYOrYqgVpbqHZfsHCf",
		@"tLcCAEEJYmlpM": @"XJgSzWTJrvmJeCNUJWNrzTRKIVyzpKKtSOxFqnqhoHcJqEHBRcYQBOnddWfedtEMBbdEAWAziBSagErWECbgxdQrxGVomdAEANsZosvQDpZVfIC",
		@"OmWVdnkALMTGv": @"xmDOGBfWFxgVKYvHlYrnoQQhBChZHCDVqvOHFCpSlPRyNLHesHvQpwfdTQOhiFhqJLYAcMBZIdUHJLmbpuXpAwUDmpxIhkJLhPBnTIVggCHbkVKxlYCKrHhoenBtVmW",
		@"kylmztGIiLetxnx": @"sQmlMxzeeRQervrRLjrASiAAjKjhXiPpbArEABqCjaGeCnaGWjxGgrrVNvMHlSEMCZnmTZuMYUtZgKSIyyIQgCMQMSSzjUtvuydyqzfuVLcWbAnSelFOMAx",
		@"KLvLryMHKA": @"kQTcZMcHOFVmEIjJaZIMVeYalqkIqupwAZcEVeFzPKjQlaWyCcjSZYvEPGcgrVosHwdllwxEDhHfxYDeHKruiTLbtMxHmJHZcxuzPvWmNajnAhfBquHhdYlZJQQEZ",
		@"llosKayWPtjmOv": @"iMpzMApQiFKaOCFqCaZONgBaXOYEuuyjFKtGiyASbCFqMlRtPiWhKJoOOXAdsqCoakVWNxcQdSCYpZndmgKCAelepqlDWIGhryHiZAyUbZiKAAMGNTdztVx",
	};
	return lTqAeuNttZxKU;
}

- (nonnull NSArray *)PHNogKvTnVH :(nonnull NSArray *)irEOnxXoqHBOZRHchDH :(nonnull NSArray *)lGEtkFtaqoFKItxSYl :(nonnull NSData *)NkbsqFAZcV {
	NSArray *QEutgpeoDboRVY = @[
		@"QsuEKIqYPFeWGHjTxUtJoxDLiAItdtSSqtStViLPAwrlWZWvKREhWiOtofqNKVjvZUUrwTYZTJseyslqNNoAMcYcKfCkDutWxqteAwRUsmpMOMMtTFAxAtxIwXQ",
		@"dZcnbTNaJpKZelEdcJfYslomPfJQIAQyFEVHhrGRJFxuqTnbKVyaFLtdoFZKmdUxVraxqfRghfPYigQdTMxdhswDrGtqGZsZLmxJxPdWP",
		@"PBzBNXFMCyVwkvtCbXdVJjUCMJXUvMUphvEItZQBikoXmCcNjiHQnVgBXhHvIXnbduUqDLgzBQAXyGtrqeHschEcEovcWPKnrovLzZXVzBhzDahMwaVnbTKYeODrnDtyquaI",
		@"axdhvgErWtsnbVKrNJkhotGipYnLGvfqHyWrwXioPiJXCIgAtQTMvjUUVUtbJYwLaQpnPZShvcEcxlSMseTLIxWZOCCLdyxtbYmzklLZBRReXmMvIc",
		@"eZtzXFOopnwVKblwAqrZlsMDaStIxWMQPOPxdMtUqHWujyQsZMmxjtQvotCtDGEuFpHztsQDUcjPVZQpeWpSwNIJHieRMiFTXsJdKtWnktfqEvGuqqxzxffqHHPfmXzWBYTNXjPBWyOnVXxoRFfYB",
		@"rDVprakuCQhGqznfTteuwMYTHbOvSYSBMaSpHauEFDHWYmxEjCdeeyvYVxPMvKyIBcaFBsGLtAVHbtqGOVCFhSrlWUpbtphDVeIPgWXSPgc",
		@"NLAYlsnIOGVjsdXJalpftRzueOptMCqquWRpZSPZHyRtyTZUJZxtDxjhiZguDOkBsisNSlDQdhodMgVOXtqBjvBqdPCNvnqhFWPtDeDRActuWbAUolwxdfZvdfDZJqioXZs",
		@"DvutikihVWRINpIAdaCWKIHpiRtoryLTPWubbVDwHFKRPKADkFynbzXISevTOwNQZDlHwWfUcWHKPTnsnCzLCgiJzOeRzUPVZAGVaLZLnBXVtfkMNPrIQnstxlmAGzLlmZzdJcDRNXssqtTHoh",
		@"CwSYpqVOkBsmysaBBndMiATsVjHjvSNTbrxpiMriHxAiVQXGirfcgoiYmYChswkqEyGxSSfqmTQJkHHHudzeoBWtMIGPxcZuvUvoXkDur",
		@"IsnHMkxnMCpPanTqKIQErcqAUUqMCshTSNeJPjXKZdsaKESYPXxZREgDBFioqHgtSybaHXJmVCKEDdIYpshuHMsfGbHFAqbHuVLsOqxANcWrlnLxdVeLUszsJOubqjq",
		@"QHPfXofEPXXsFdEYZvAnMdrzCPttcJlZjLicLURPVnfaZlnoKtrbylnGXSCsYDAsfsNTUSYBnyWvFGlgdopzShJmpwuwNJTWvVkaBeTbW",
		@"EoThTUdQxkRKimAKDEhWcRqSLzjeBIyQXUZblYprczLXFUumuadJChtuxRXFSQOTSGhXEbHZdorpwuIbJtlAoJiHJTKJaFpXpQnbDUQbIxtIkVORvCsYcuu",
		@"NbtycYeVkTwEapDdDTUzgemFcXKOCylrFVIBKXqLJZyJjGufxEHoewhqVqZhEDQuAOwIYMQbPDcArQytKEAlpmhpTXQnfwioMMCjvBbIVXRhhZLFbfmaaybwhbZPWNTrwBxpQagRozUQYVQG",
		@"KrycttUUvSkJENflcjnGyDtToppEUEgBgNxsmPdgiSAEywbQpFOqYNanaiDATlRTaBsQhYXMoyLYQWYEqmtShwXaxymAmnZdTGOiob",
		@"nqizZdiiQwusWvETtNrwCAyUCoFfEoVVjtjlRmwEASrjARggFzZQEDUoRoEGYCkSotStjOqWJRKfAHbRjkfvXwcspWbEKYbGXudSCOcoLUUIbTTZo",
		@"aquHlNakHDODxJCkwtzGcKnVFbPzmeochbDgLMsJAaHcbSLiVcOfkjYIHmXAdUHqjnxTupKxCBACOGjWlqtWiqGQIVetZtYQjcKHqGQHKOV",
	];
	return QEutgpeoDboRVY;
}

- (nonnull NSArray *)JqlyImVTJNcWFrrV :(nonnull NSArray *)khdJGEMwsViawKUP {
	NSArray *PvGgfSqqLkQIqDRl = @[
		@"tRQmkFTAETMnAorNhlGwqzlgyXRDdxIGmzimyvnCMQjJNorGjWYcQIMDOhMUktcZSratiHiHGIUqtDzjxhTRbNkwZIbaDRSNZnSghdOYbTEkloNbrU",
		@"DATlXOewBinTxeyxGuVhPZnOTWsJmQtjotUzkaHKdiJAydluSJxztwJuKVrkNvmoXeNbdudfczCdoFrSqbpSmnFXgSDNcIjriqQozVRKROKZqMnhZVVvmXTgOKkBRtYRgNIAk",
		@"XPUXmyEUOCmdHSSLdxscHDFlLPFJgnpylLLBRoAjVhFhMnCKgEhiiqlpsneRhBhexPYnqbTxYIPAIuHywpsjOCchnDCkjSHDTRKZlcrECfEpWotlRUlUExSpTdFOFsKMtdyBzW",
		@"lgcoIpwvSlvFeUNSdzuSKjhvEfWYNuZNVMnroUymDPbfcOwUaemuVoNlwowUPuRwsOWvarpIDGjKqmmRQYQGRAhakPbQlVgsQotLlxHveklzNRQZKSyRvUyGqbYdLbKejHFW",
		@"PONKkENysodeBJJLXuXOkbEVzdwLBANngeLBAgMVLodCudcHeaHzyTXMQciWfSyWPQkCwOufxhldZZJStuDWWwwZtRYjcEkiZsbc",
		@"TsiqSAqclSqeoRpynOdkPnoZnfBubPgMlGqUZzkVXZHpVKZKZxXdEukfkQnwWsorekMVDtdpYfoOEmgxGmKecwUuksXGyIdFczdSaEmxpzMKcAqgnCjkjOTGPqDybkRlCaabjadjyaonCRq",
		@"GAFFovUnljhLNpsBLhvCdwsZrsRlrvspgHAvwxrKTerFcRFgsmhLcASyCZLyNWXwMJnoPMbbhAEOtUCBcstvfPgxvchUwEBJFhsQoswRnmmLBiONVdqurKUKVzcyjIYiaaSCQAaKsQ",
		@"nQHeJoqNnpfuiUjHgoTkNxqHPJWhcSCIjOUkYNJjxOmsSdxUuvrKnGusdABrHyNUgjvVIBlEvBAPOBxsnLOSOGrNbqSoztSoVnLYujktexfGWjccLhiJfZKAxtfayWnPGWCNYre",
		@"cviJwSqidHHreUenLxNSaybBaRbnxCimWINNzADFnXrRPcJCERJZtlMvNAgeOCrCjolCEZBImEldvulMwiatcvUiUKSmhvxUtQJYbXdR",
		@"AacCLtpczzPdztxgkotTrNzMkuOUHVEnNVgbgerHfwMTZZwtxjnFcSwLPGBdsIieszerhvGaJPuWJxAsXuaeZfCywzSxHKVcRhONzhUPZEwDs",
		@"blpimBcgFYrnwbiQcozoBlYJLbMJqxRgRcVsqojESYydNEmUQRNEWMrFrHeKsPVGGjCMDaKOOOJhhDVZamnacRcxISXFhFVIIKroycpewonntPPeo",
		@"CCLFvIGrdcIlMsFHGVeIuxORbmXCXwiyKRtMMHvDiRRPdDnKraeUVYDKhGMgozmmtXtcTJtIakHdnfisdSZxKFOEEgYXUZzkbqrxsqDVTQDYftWvuvQbQOynDXmzWrxcOeiwfdBBINxxRSfpNi",
		@"duGdnMJWqHGbFOUHpVCxvhYypvPjhrmbLrTRAnumqanPcgZmCedpgzAvQfNJWwVCBMnRXySCINeujpswGnjXhpJIeWhdjTloYnuwQDHrqvWYUfpkzsyfwmKM",
		@"VgLpuGjZARArvgBuqGuMnZUBHPhbURiouyHlMCnjJJJzrhPahGtxcWpcNaxeIIgaMotCWkjLwVPFjMmhWGfgtIZfApWglbhouNMHaAbxgnQ",
		@"vXVZZOmxGavPrgVbyQebcZGlPgNSCGdKpnjOIBGNdRhhkaEvXSyNNyXoNCocqETAyMrhgSToqvHaLsVTKkYJDqNQhivPeIektOqRvirlpEqpRHtZRWChXTeilnsxQxmaXCyPvv",
		@"IJlvARpuIJRBrukIiXecHJnApQLucklqKFMqDtpKMBvjQRUoVsFSmelWTkSEqhyQnzOxWCuNUAZiPTnTbIzUzHZEakgOWcHSmlOmHTcjMWnGbVtXBMYVTzhNnhDcdgZESERDuQRHkRjSE",
		@"zIJEEpZFUjreDgSwFPjywsvwcbwekbRNLrqiFFckOSTtcqqWLCGBVijpFLkTHVtkrAreXpNgFxfIeDRsqslvHEhzOjsSnKumoSusvHrGhZNyDEPtPaKRwPbgwKjoQqaXBkqIrBVERUNP",
		@"GVpkiMNAiSFQuJdHHDKfgviMhrHaKoOqNdhZnKxUKKlnHsaZXwWSpBgeilykdrcjEgSyRPMWbGMkwLbtzkrmdxTbjcguALTOVCBwBERcVObqfdrs",
	];
	return PvGgfSqqLkQIqDRl;
}

+ (nonnull NSString *)ulWglMftveSFJsk :(nonnull NSData *)FakyWPHiwArsKPO {
	NSString *mIYhwsmhVz = @"TIMcfEggXsUsqvxUXFnQIQocCGssBTeNmUrjhIJqrEHByqlYbnnVRhMRDoovkURcCnvEgQivGXLVKOpZxgIjkNWeMTNxgdtnFUoorEhSpQhOHrTwhPXhKrxygi";
	return mIYhwsmhVz;
}

- (nonnull NSArray *)ytqimKEixcUxkWUvjUM :(nonnull NSArray *)byCddoKNzL :(nonnull NSDictionary *)DmYfKEYfeBpRtcKLegE {
	NSArray *qlMXjeeMQzmuNJ = @[
		@"czfWIgCsKrEzjqxZnFeaQEzhhdEmeiMsmtjSFhcqBxQbHWAfLyGxoCsbiolVTwTsbfAYUmhKwaheaXtCVytIkvgRyOmUwouwAmVdQEZHKnIOPTVwONDZLBujec",
		@"WsIjmVVMtgEVFagFapWmMmZgjLkmqHuOLtdBckAkJQjAIbgwYfWabtBAhijaZdMyByySvKkRIPBcVptuVlZjAYkzbgzVdsujZkaeijPTMjLriAmxiJeemCfqjaqVQIvQQWgwuteHEKlIb",
		@"zSjdGXrEJHtcnYJYWThTKfAMNcJOKBNyFXALpyyyFnljUrzfloCQrmOndvUgQyVUvOxCOQvkdxubtrxIanCfXjxhyMDVBoEyBdtAbkMdZbKmwUsJyLKTu",
		@"QvApvePCgbCrGvBdsdbWxzxncPcxXPGtmnavXXrqKsoZsdtuZvbLXHnvsGaXQaExvCXXIXhDvTmNaqfuNltzduHKDaFpiaLUmQHCGDuBOaQrYauoNUCEUlDJUHzusvtXF",
		@"LULdKLDhTkaWDUPLnxxbVriGOUrvHOTuUewTjFMYLPxtTuHkLFbuhSOPBttURmmEIaFGDwRLlHpcRypFcUSZVYeBtAaKoEmwbMaMfMkXqjG",
		@"wnUHQrJlDuYwqPpuUOSIVofqaUFfHeLCcEIPRsiYeGdjclRNXMMgOsXfcEavwgKEsEkbiLAgYMbFFkZXdhQoYWhJJrGfVZDFKkyTQydmhQrXwJjpPivBTqXInoHUSzrhXRTR",
		@"hPflGRisJOVdMHAlrsysCOwSohGAHQymxpTKpBbgHkrMiGXIEytugByDEkNaYAnhQWhROrHUIOZlqxdvINpOVDHUKMHHoOAFUlEEnaPfHLYaERmAeeEug",
		@"HkCQUYLsINisCVnruXmRVrqNKmiyvtFniTRraUAjXnQNXUvLwSKhxoOkOthNnZxQoVMcPuhvKltXRMdluVOPekSBvMwiOFbTVApGQiJAdVCKalGvcpOjdPbNHTrCAmpaHkXdHWvcTQbfMLOIf",
		@"kfYkQgKNxLXBeeNbBhrvEYECCTOFFEbwsgbMQHbLarGglnvWzhWumgCRzwxAxeFvCOtQFtFqqnYQkCquwFnjIIWOYKxVWKmrtgFDDJNjDKnTzrZlWityRqLeULpFtCWRxZ",
		@"HptCncSMdbYTKzDqwPzGQkrYEHRgJURgGdTevOPHUBgWXLPpiFFipxcDJqcyBUevPgHbznaRRRmpEXipDFjWxufwdqhgnIwbeysAMpVmTDWRAYshddAMLBoL",
		@"XLLXvaKTQFqWmUOvXLYCIciagwxaKYqVLioRQqkDUtnjYtwryquXjNwvoogXdvHbFOcBpPZQnbFBeojZHcdtXcIbeZNRwpFRJdgZEDQOxdZCzyTEQxeUEVPA",
		@"rbgBYllXhRhVLKUCvXdqgpFTybqKETuBBXUnqEEkKfnPBYvNXXmPbSVirlowXkQoHaldeNbsMsrKsudDBwykWaJwDmWjDIjVpTdqQdAZLHyOozoEFWLPooJlYZYBJzCpmMGneNwDtc",
		@"aVqOMUMYGKCVejDiECFsgqyQhfIbcHalWNDdyJhkpXfNOBFVfayKOCGWbjYwcqfwzhITCgmBdQOaxPytIqknaDreXhVghIbHyBZNiWKHjqQLivDFiDiyecujxnIzHEYDim",
		@"caOmGyPjsJMzGXQbqnYPDJrGcaXFXXvJJjNhsMxApsvkWYNFWIRcmdDJfDfdydRtcwQWlyRqufNMiaXNJoTrRSPZgzwzFdiyzRdrocouEmgqDPKNZykVDCAFYbYGxyMZUvDPYfaEjOl",
		@"DorxOlZhniwPeGlFvpzPqebpDOZvNloEVLQcIhNqlLcSdeRnbDMybuTUeEZOmjAXWIikgjxziAeJhwFmtrLyaIhnHknCdzyueGjEVnNqBGkZbqQpX",
	];
	return qlMXjeeMQzmuNJ;
}

+ (nonnull UIImage *)DuGfUGDIHooy :(nonnull NSData *)gLNdcBoEXo {
	NSData *IQsQozCuNRzvUDcIvl = [@"uJWcUWorKipNeZLMSikWGBqRRHeVJHCRCgNEaJQGnExBsASbFbDNGXSGFKVBiYhyeBAxmPanhQJrlcHUmoBewJBbLUFjERTtDLUdsj" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OoNpcBvKgKFVnjdB = [UIImage imageWithData:IQsQozCuNRzvUDcIvl];
	OoNpcBvKgKFVnjdB = [UIImage imageNamed:@"bdEzyutgaoPXaIlLJvEdYrtVHCLLIWlpnjQhtEwSrbyhNFhpdcwgPCxBnaIrsCoDHtReLjxPfnpXkRYBzeQufHChovYJOSWGEcMlgFlMevJozPZUaLopOJBfJZqeMiGZrSmIT"];
	return OoNpcBvKgKFVnjdB;
}

+ (nonnull UIImage *)dUWKldfefGhqMyxQYlx :(nonnull NSData *)livdvhKtfZP {
	NSData *JMnycEkKuSwU = [@"KirFmjtkUTNcWEGGznVeijugbUuPgzHZnBWxMHboRHzxWaHxNrsxiEJWpWkZihbflyRhjMSdvmLTxyGGfOkiFTZhTFIgrAWDEOfvwikErcAAcMevaqFQDcZTseJWkW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *GUZneGbYGkp = [UIImage imageWithData:JMnycEkKuSwU];
	GUZneGbYGkp = [UIImage imageNamed:@"oSCRfVamPYSejtwtexFAmbkYITvSyiLCiHSJJSmpsXmmCiAIDbTopIpVvkOtpnwFwmRxKCWbIXdmcIelWqbhrhWKcZfsxoEEGoJIVeGbWRtSPsTTbhhapKIG"];
	return GUZneGbYGkp;
}

- (nonnull NSDictionary *)nBZKKwoUvw :(nonnull NSArray *)qrTAeNgSmTO {
	NSDictionary *ngemKDIBcfF = @{
		@"JYJwyIwCFJwpfeOrvH": @"cjpSYqCrYoLonSGMVSRPwXoTSWkspHWzAynnPYzyqLHPRpSLrKENLzPzIYBBYUnxupoBuMLVihPgVKNYIvROAQimARueAsqdAtduNhVrucKONMqkXgWQF",
		@"FXIhixLPrzRhdMeSH": @"fiDGxASaYZQZrILSGOjagaBLDOUsRzNLhVHMwHTTkhfVLEZzDrCELOuIVuTzgroywFcfJgiwKDUAZGvKnHeMNzViBblGmJDIxTIMndoLnzWZJEhhO",
		@"zQnAnlHEBwrX": @"tKHGZyVCNoaTwLrqtddLwOFcgfVlcojXJpjUPsjZYCChybMufynfRxIwXjuiQZmWipiAJPQNjgsvmdwYKoggfaxVWafzTgyUdVDLeeKYplqROuNJtRYOUtpfhNnxBlrpYDKpIxolw",
		@"TIlzyfvYcfGmxX": @"pCMhUtVPyMpcKvZdImwGmoCDuJgCEHOceklycJNSaeOaIRlBJVVIliEZKhdXlfWYiCjbnFJIrenncXFLuWsFKTgodZGFSJxTtCfXdroTWSNSYINdVoCzqQUYyZtIn",
		@"pCzhVJTCbzBA": @"GGPIQmIpVOBYXWNaSutRZBmvdpAVLIFokTMtvXxxoUvVqCgXCPypdsxtuqonXmkckBAfKVdVwepExYPTsmAoJTuxKCEPCMeaJngnFTnMtIpUNUGjNaSNGxdSANWfYZfWaKocbuKLqNVoRw",
		@"aMYHtltDhq": @"FrPkysFOnBnEQdAqVzUcvPVpbfAzJmKgFpRUPICtGJappSoAnKmdFEUVhBkhwWPBwjllLAyGrHyYeItGdCHZPzOafvoZkZhhJIaYkoWuVAiZofJOfIWBU",
		@"FoPgIEvtKOjxt": @"ImWKEdFSHiDFGMqCZJPkOBoCKXfieyQlWQLythskDzBxWLHjcholJgpWoCZPqeebktJpVgmNhGRXrFAlBURIJAsaKlFQjUVvdbdESLZQTExsOHNdSNDvLRxSLVJG",
		@"mfLAcAqVSyTIORVin": @"NznxWbKvOQLBbcVgpzXsiVZepNVhvHRPitAFCeEZTxUfIoNhajMkbbjaqCEKIUoFjJdwzcUfXiirytBNyTJpCDccOJzgWPjGfgInLgPqxBChKOXeDvNWxXvUtFfDDbjzzldABoPxITBsEbCJbR",
		@"GYOaNbLKRxO": @"UnGwZMwLBzlZbbVKEUZJWevfncOzvslfzQkjfJGjcZWkhjmJFWFTNDzDrfRHKiFhDvbieRMhUIsmRYMHZQmBNMLteOPhLpfzWTkEbkHVeeBhDxCKRVb",
		@"utGniNljvWIIENW": @"JCilQfsTJIePpUZWjcipkDsvkVpjSZRmVcQZspyBUkTkPwAqylKPfbeARIecsdxoLCSMEmFwyNObKrskjqeqotxrWomBFCJNyHKSdG",
		@"mGshVrGlSHP": @"lKPVPAjircqXOiYQbGgKDFwOpxqtvXuGHDrVIbkHTTmJodzcprTewkkYoKhLkUummDrucDGzGAPwMBWQouFCvPhhOrZCTtPozAePNtRiVZnuzClYKttGsijBBvVwTyJwrLCeYDFR",
		@"VEeywLXvqyR": @"SVIsiYqmbULIlTtVxSZUWgVkGvdbLHbiRusRpsJDKEGrEYftZgeTuYIzMTfWLUhwwgJnQhCfRrOsQPlWqcgMLNzDCQBKpzUyrcREJTtVqwEyrOZleF",
	};
	return ngemKDIBcfF;
}

+ (nonnull NSData *)CuDktPAkqqiceAJfNb :(nonnull NSArray *)WCrUopfgpvUnCd :(nonnull NSString *)nIqPNeZwPjf {
	NSData *KjqrUPyxPllwPGqsUED = [@"faZmFGMrCmNRSMICGtyjPujeFPwRAeBTtaCPRrOnTuXyTGrMOiYxHschNJzlBbqNPHlGxjAcLmYovSNkoMsgkGrFrlXTjmzxRnaFMdpqFqIuPbIhNrlsDUfvJXRqNWnayKOUNgMNLrodaXtw" dataUsingEncoding:NSUTF8StringEncoding];
	return KjqrUPyxPllwPGqsUED;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    if (buttonIndex == 0) { //照相机
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if(buttonIndex == 1)
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    self.changeHeaderImage = YES;
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    self.headImgView.image = img;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
