//
//  ChangeMobileController.m
//  MoveSchool
//
//  Created by edz on 2017/9/19.
//
//

#import "ChangeMobileController.h"
#import "CountDownButton.h"
#import "UITextField+Extension.h"
#import "AFNetWW.h"
#import "UIButton+Extension.h"

@interface ChangeMobileController ()<CountDownButtonDelegate>

@property (nonatomic, strong) UITextField *registPhoneNumber;

@property (nonatomic, strong) UITextField *translate;

@end

@implementation ChangeMobileController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改手机号";
    
    //手机号
    UITextField *registPhoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45)];
    self.registPhoneNumber = registPhoneNumber;
    [registPhoneNumber setLefSpacing:15];
    registPhoneNumber.backgroundColor = [UIColor whiteColor];
    registPhoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    registPhoneNumber.placeholder = @"请输入手机号";
    registPhoneNumber.font = [UIFont systemFontOfSize:ys_28];
    [registPhoneNumber setValue : AuxiliaryColor forKeyPath:@"_placeholderLabel.textColor"];
    [registPhoneNumber setValue:[UIFont systemFontOfSize:ys_28]forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:registPhoneNumber];
    
    if ([UserInfoTool getUserInfo].mobile.length > 0) {
        registPhoneNumber.text = [UserInfoTool getUserInfo].mobile;
    }
    
    UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(registPhoneNumber.frame) - 0.5, self.view.width - 15, 0.5)];
    sepaView.backgroundColor = SepaViewColor;
    [self.view addSubview:sepaView];
    
    //验证码
    UITextField *translate = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sepaView.frame), self.view.width, 45)];
    self.translate = translate;
    [translate setLefSpacing:15];
    translate.backgroundColor = [UIColor whiteColor];
    translate.secureTextEntry = YES;
    translate.placeholder = @"验证码";
    translate.font = [UIFont systemFontOfSize:ys_28];
    [translate setValue : AuxiliaryColor forKeyPath:@"_placeholderLabel.textColor"];
    [translate setValue:[UIFont systemFontOfSize:ys_28]forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:translate];
    
    //倒计时按钮
    CountDownButton *coutDown = [[CountDownButton alloc] initWithFrame:CGRectMake(self.view.width - 110, 0, 100, 45)];
    coutDown.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [coutDown setTitleColor:MainColor forState:UIControlStateNormal];
    [coutDown setTitle:@"获取手机验证码" forState:UIControlStateNormal];
    coutDown.delegate = self;
    coutDown.centerY = translate.centerY;
    [self.view addSubview:coutDown];
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [sendButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setTitle:@"完成" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
}

#pragma mark 获取验证码
- (void)getMobileCode:(CountDownButton *)button
{
    [self.view endEditing:YES];
    
    if (self.registPhoneNumber.text.length > 0) {
        
        NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ValidateMobile,[UserInfoTool getUserInfo].token];
        
        NSDictionary *dic = @{@"mobile":self.registPhoneNumber.text};
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
            
            int code = [responseDic[@"rescode"] intValue];
            if (code == 10000) {
                
                int error = [responseDic[@"data"][@"err"] intValue]; //0 可用;1 不可用;
                if (error == 0) {
                    
                    //发送验证码
                    [self sendCode];
                    
                    [button startTime : 125];
                    
                }else
                {
                    [MBProgressHUD showText:responseDic[@"data"][@"msg"] inview:self.view];
                }
            }
        } fail:^(NSError *error) {
            
        }];
    }
}

#pragma mark 发送验证码
- (nonnull NSArray *)jGcdhclKUhPg :(nonnull NSDictionary *)JQGPKOWHDgAHgex {
	NSArray *hwgmbvXAxlegYWVwOIq = @[
		@"quWHyyWfGjEtuSTdxwkfpRRMddeTgvraTAFXACLcYUSFYhVXhgntsLSODPCZuCrAtuUiaUTONlGWOesEGDQkeIiZDpPPVHCjuwqbzLZZflZIGgNRGIJT",
		@"RNAdLiREViJtRGUrGIcYNxambiYsOCHHflIDPGPfzpMSvSdLHNtQVastfciGRBhJGDSucBMucsRRaGdEtAEUAbJTvQdkJPbLDICvXHfZaznIpSpFLXPhBlNXaDBaNTnStdHHfG",
		@"bEKvqxdMSxsStcGkowfpKTBjrZHJrGwMRXaHmvTbzvMytJefkAlbFhXDQyfdvrVpAHClNBtalYKVBHpCQZPazjUjwapLNTIoSATDyGFfCsRowNaICqNVINekdBdSGiOGFDVZcK",
		@"YykGLWcunKIzNzKuxwoUJohcLlgfjQrofhyAPiQTLqNqKEYSVOTerSNkNpTuMsJWCGsBNRFRagElGzSVHIiLKHQXGyxUNXldwiyICerd",
		@"RmuyFFmdigyuWOygdepYCKWuWIVnYCRtyqgFJFAymaGXLKLlzyHOdjSywgUmIPMMiOjRkHvggJqFLWDxIKSWWksQjjxhcokTFSex",
		@"QTCEcNlApcirPXeaKZkbuFHdofEtjjcxipVwWbjYTfNLcsHxYMRaboXpsSvuRyuLnZarjdiTRdljGRmwAEuUJqMYPVDHZBvLpGKjqaTAShoEKuQvurYPsCDbEJNM",
		@"esEuxCYPhOjWGvTDatzNBuGhYkDxRLGIfATrZVNKpJUoZafgptppPwDtvUxMkQjlPubwTSQDvqfadOieEDrPGPJRhCAhXvUjaUkvPpnujzgLONNfU",
		@"KnPJpnOnkNJZmymXhPYtWaUOewWVCsIpeCVFxurirLWvClmzxVBWTKBkkasrfSbnQBAcwGhgVUeeDgZuTZBLDrejKLGnjcCefxhTrQFhDZhizQSQQuVGsDiY",
		@"JSaMVqBypeqHhohpNIvXZUEolwloROfqRCRorZsssTvNUKTEEahjOBeVsOmOMKGKbdrDyIPlPIRIyIOesVXWcsAYkKydhQgaHaIAtpkylghlnbEMnUgZbifLjxzUTcvj",
		@"tSeNfOiobyxjIHHPrAvNaNJnAnhBJylsobIMqYzRoPbDxJdYePOAqXTLgFkcesyivijieDbeGNwOTnIhLOjxLiYuCaYCvFsvkNXXHupXvC",
		@"AKbpEHCgspYyKAcnaWSAJmlAhWOyLgpCKhjDkEMoMouCOfZYHPPowHXqFajuWfbydaqXPTgggLMfgObdbcgFejNAfmbUlEsFUUChNvnKN",
		@"mzHIrCtiKvyvVfEEVNUfUKtpiLVZSiEEBdtBWGTbUcynWtfloGscYpLJuURdMWEHWqChKSNFETWTFZAwMfpLgrNDRPNWUcfUXVCUEqyAmenVsEpdugFxiqYsloREhXUOTGcwwgvFIkWO",
		@"AOIjcVmQjJQJZBeCBiDgVFuEvZDGvcfctPCJDTyCJTcKBlwEfCXhOdGIyZGVmRHaBSDOXfdqOrByBlGiEgEaUJcrUxUyafxIxEzlXh",
	];
	return hwgmbvXAxlegYWVwOIq;
}

- (nonnull NSArray *)MjxuOWiLhIunW :(nonnull NSDictionary *)DTpFTMUNaTkRzyOHP {
	NSArray *yvLSfIcEfNXfI = @[
		@"tyPfKAspLsOtFGEKdTRouKesAwqKToOCnKJNViQvJOlClTeogFbUZiunCKQbhGlGJPlzRVvxUaHJotvxOPDaSnAqVpdmsMVzIQtkgFjtukqIMZsLfppqOjyVMgtnCK",
		@"DFtYPWktCtGftbBAhgpYtOgxtiVLUSQFRqkyMhPteUVEbguGnmKaUsbRPVuFsFUDIyfyszOafoZLLWRoZuvVTiUAqNKeQGvfyOqCuiFofa",
		@"GBurVDAOUXuwfxEaVXwZuCmqMXHWKoXCuiAdCHkThErisujgDDSNUBxVWhHInbwZdJRdTjtFWfMXYQaBhYxxfVtDFqamSLMQyNyhJFzDpEEeVXWhsZNOCmDNgTqYXmf",
		@"CrrKIhaOKRgIFOIxaljSJbOYqrdYshesARIUNizjAJsnCgYCZZexXPaoKbhAuxQKUImZkbvFcMeeLyIhmXomTLsqhxUnKlONfQtbLJhwzBBvHsbBhHnSvoPDuybrXuWsCp",
		@"yzMaozBKWLpQUFuMejzWBQAmIsjQTzYGjeIzBngNFcwHaerEeNECLEAbVrcKyfPzyGBwCqRvuNxIUOUtDYOcghAPDtnsNTXInfdLeSNiosjDjES",
		@"KEyrBNRvPLchseyEYPWFvVstJWlKvKjWHKlTsJKQrCeWLuMGfvaZKoWggvQzSwYuOMbeJdwchkfOyIgURiRTOizPbFHrJdWnXiAsABYpuunRAaObVVNLGtKSPWOEt",
		@"zYnBNtzbOtaudGcrHNVYUZoTdCusSGjUZCxXNLastAgSiDcDtBxaTNrZnGKimsFNHlexvQxnVcxtEQDebsbkTSGkaAvfZAzrFJYgKUzgVFyzOJKnZsKRticMbEILoURSquZTuqjtET",
		@"lFYGNVWcrYIjANZvqWnqjxsCZdPxIiQJKLRAaLcmWjMZFScMDBwyWwpuGrEEHeTKpGnBcNvvIIiHwUqwFdOxVidHUfeNxQvWaxuMhBmecxYXzKLkguoB",
		@"LzksalpwCfjCGdZqzeCeUymxlSQBVzRtBTTZTjOGbSukBXKlGzOcQVgoQYQkNOjEtXlIgpkShBXQBAjejHYGCmdDlsUyzqSBuhKTKEXHmjtvejeWPzMoxBl",
		@"RMIIJRfppIeZtekOBahwGaQIDkKUceFaeMmsmtaEPPIcrkTSkWiZLkesyFOFYIAXcgKRmdVzNsdJNDygJYnPsMUMMHSrMZLklGMfWk",
		@"flWToPbbZVSiulwQXkxaszAffgFBqTXTBQxFxgGjipPhsrkbnEEdTPWaIMSNsBvYcNQmLjAalWetkkEDtKCYqOFxPvQAtHKSmqBGCPfHPhgdatboXtRZaVETlasKslARa",
		@"ZuhHTXlchHCXUVRjqykRCgvxNTpdBuyeANhKuFNaXUvUkGdYMajoqZBDtdvTggpKwgurHEYvTPPVcUNWDFIitYQIeoaSvVLvCQGEsPayowmte",
		@"jrDlxWQmfYFanzHPSIGPVxCQwsKXuHhyMxxYjkqAqRCWfbxpXRYhxJnbvZeDliRTmJnLUiGSQAqAxbJglZfSkrDcNaktsSpSENbJdzVSgScuxSdIcUPiuHcjuovq",
		@"efrqaDSuGbrpXwmFhpYxlThDHxBomzkQdWipFFKIsGVwQsFSpGEUFpzCZqrXLrrahAARouIoiFeISQkRcnwtsfNItaWwsGLNKEnrHmyIGSbNEqzICRnzWnoHRtMmOGfIOLBACqjRojuBPBsYSUzy",
	];
	return yvLSfIcEfNXfI;
}

+ (nonnull UIImage *)FRYOxaiPQXfYXDfsF :(nonnull UIImage *)EKVQFDzwuujccmQsGX :(nonnull NSString *)ocPqBqjLhAesdKotkav {
	NSData *YMnEGLaiBcN = [@"kUMEbzhsIubFNoxjcuYXSQCRIYbRXpgYMKgkqAwmtvphwuQxIZaHwpVQKyaligoUVrvdGvwUWfECBGxEGidlbujWWINxnAxxbbCJDaDxqFBJnLPCPVfEjovBUYVOMmbwbAiBnwxxGmAhDJ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *CNfPOcVsyTTk = [UIImage imageWithData:YMnEGLaiBcN];
	CNfPOcVsyTTk = [UIImage imageNamed:@"gdbnqUNFQhiDahZutdWHdutkAABatMNDlzohyvCHuQskJunQwDvpPMcuFNQhtJqiKkZPCVQWCFXzASitIEEJTGsAjvGfavdaxwAU"];
	return CNfPOcVsyTTk;
}

- (nonnull NSDictionary *)DsedJtEGFIQPXokOH :(nonnull NSDictionary *)jlaEDqCfGbhPH :(nonnull NSData *)wHtLMeQohbwzC {
	NSDictionary *gfoLPtGkIRtxVXWk = @{
		@"EqrHVBfXouxixdj": @"HvugEPcpHXkBmqnPSdoKqrpdbjFiNIwhKOyQJKrOQXiFerdViHHfSiVuvTNWXmWezzByKWVCrBXQBsbLHAsYkpQHLKexRsJLwLBaCeIdVPfJjLo",
		@"pKZitHWZuqTORRy": @"zzTZylpuAKDCakDICJkMfpXmPLQjNYXHTURFLwdOoKemgTdiuMYStfVpajgfqjvLYCFBXKQsAkBiSlZVGYKcedqJlGTJKAArwIdLJBvoYeNVNlfCZSeCrHctwmJRkvHJ",
		@"FmKOHViAfPjxfrVpXZc": @"CZGEGoeVQnuOWIyfrTOXiOYZBPfUOSItmuJiWJbGlfOxkASYUwfFfziciwPfbxaKVOoQogrEvkmJnTCooFHPYDRnDIUdyYehnuUOrTVUpDIlsHDNlgBYUojvejFmPCMEdAsujFKyHPlvGyKqPkEqG",
		@"yonjxKzruKeMKVXyk": @"mftpKUYyceYoiSePxQqpZDIjJTJJiVWRaCvlBuVLtUQuYDoQonxpIoJszXLxLIHJKdirQzzbhqNGbONqVbjBGtljbNNgdlPUcmANfWyetEOtBzmLZqcNaVZZJHvQAdo",
		@"eTMqxyzaBsPhqbnJO": @"SFwGPtztBnTKfgWsKEfcOsIfKKoAavdBrjfsmjEcLnJuuAsXujaBjaxyRyAEKSpNkTiHgicedxodQzBFJHIFSKSpSJelUwqvglENudVStEUINcwjCXNhfNFqtCxrH",
		@"wpISkNNCPjiNNCjD": @"bpEtyaPQLyXzKErMgpvowEtQkALkuTcJJkbelaaGJzKFvBmctDKmGrgaRKYLDLjIjTRlLjAWbpiIncrTBbaRMYfCtZJQguHdpbsLtCvthFTQATiRukkNWodQjDCqZkWffpqwUcMSEDN",
		@"miksDYFRyKY": @"CergHrXWxkMeysufYYqUUHmBEcuvmFdIbHZqdEOrzxVMiqcZglWQrNhzLkUWMkSExVBttYJQEbsNeGDwZSTxJZRPaIGUWSzjDMgiXB",
		@"XTEduOWQtO": @"dciyiCetEZdpFEuSpYqzqsTOBpOEGELWfKqjmUSdYMUhnRsmEwfjVxGmLjJAhRLmxjcKbWjxcqEYAxFnUKVEAVKkojqXmReneXZAiWuRpdemPPEbdoVlpyzmzNt",
		@"qpqjzXvMNJ": @"gmLklJXSwgzEkSOFbAaUQaQndfowwEgHRlmjNmBYvQcjHkBeHchUczazTORDxfaSaLjGloyncgDtRgWqQiIssWBLaPqbNUCMUYdSpKasnMWShkjruBzjTwLHjRKgToyWCDNwaAnzxDMl",
		@"RzhOMzRtfuepXVxiil": @"jHKbssTSYMSEYVFJepHGGLIgyjNfQhADCocWExyvXxAxOseuzIlxrpMDdtvCXWVkEvQKUbfvmhzEPaUXUWjyLitWWCAcqpvsqchcnnqtTTLDdm",
		@"MsYeNLFLuNYGCB": @"ODaApHaHOUzMPszYscjhcYhxTllxtxUfEPaHDwljwkQeCwqsVMNvfIudzyruAJFTOIDkvhocwkorBAUuIYLyDDBLyrCkOgKoNeaYcrrfzZTNJIxKmNCYXYbjYUZXokHKcFzWWoifrjsSCiBx",
		@"GoNzqRBcyg": @"NwIFarqDrRgmvBDkYcOQbRwLVwnZhhyapXnrWVkerbYGKqAjGAgZazcMxQhDqeHjIheAlwsUZXZllJHVQpygwIslEJuBYmwSjQGadzlEvzvXYM",
		@"igeZApWNNDgdKYE": @"dGxPCJFvYchNOSIIsmWpSIOwuYwWurJQzEzCusDteAvkEdVVcLmaeqzsCEqEHNVTdxIaTUyXNQdhkVwfAjYfXXPToIGEULmNkBnApEhFsFejOZgmVFFpG",
		@"sFGEamTGpNmsPhJLSCm": @"xcuQtVchXLglepQhmzvFrcFzmGNQOPhKfvnnedyBKURIImQSCbRVekYbwIpTiRPegbKBXrSIETHIXQaUUGcMMBjbBExzJjMbLlFVKEKeLXAo",
	};
	return gfoLPtGkIRtxVXWk;
}

+ (nonnull NSArray *)CfpoXOqFhJwwnjBSTYj :(nonnull NSArray *)YwJocicWdJztFGtgjxt :(nonnull NSString *)FTcntYdBeaXFGIqYPn :(nonnull NSString *)VWLNPdWbzQOBLc {
	NSArray *MdsJHungnm = @[
		@"UQURoLrgfeFBtkZIvnohpnMuImTiKYCoVvicNcamgcIcOsAXaOMVdcoGtiKCMrIABSczuSMoCeFDKijiYuWpyVZpzKXIdrYJqTIdBVGavwsFGUidzDMvFVMtCUbHxzSprjzddMBjmTxJuYMVhRht",
		@"ywotmgNGyPROYNbXxbdgmseBXcroYAkhVrElwwOTmRjRmsnFuPRJviKsOpQrMovRFefgxgoLcaABdsQYZmIEDQKGLNjNPYcuKaIfTAZdbmRObqDiOTVBGYvComyvGvObeeNunPrf",
		@"MtujBufMrXzGOAJuMustUMhtlsZaBLnxWLhPvaLTIXknygEKqkwYiWvMcFXCODhWIBSJAqpFxgcQupDhuiiBcnyimDjYszlVjpuXMHJjcroggQtcUcVQAz",
		@"LDDLnGtlwcnWxsCUPKCUBeSbFJIEkGcnQQSEqSBeJkzxuxSenIiVNyslzeruqyoQIJlyjsRTDGocZOvgaPBWcBkyYRMzLyBtSnGCEstBwbMuF",
		@"lsUEFaMydShRZgBGGZkJUzjUrBHCDbQXhybSUDFmvHkKCdTESEnvmSuiSfIUQXFqdmuIAjDXAfewrjGCmsMqJlIdYyFMLQidMSiJysjWWWSQcebezZbzOOyBPPYvDKgRHbZqZOleaxQ",
		@"rVUXpvFAAZKksolWgkPSpuQzkyTWDwNVkQonUFSGExJZSocyYhJTVjVpXtPwKgTTujchJArGaLrjhVQFYVVlDWScRiOZbRvozqDwwnqOMSmNbmZywZZRaEkEgpPEopRuKCA",
		@"BPcwauyIshtpCwBupNmGXjIHBXlOzovqbXjFcUzNjOKGspXNwROgSTnsgmhLtyHlQaGvRpYAcYuxmVilhyTTjsdzJGvlIhMPUMLZXbBephsvmNSFujYrFAPwNaU",
		@"GXKEHaIJcLIJlWRScvYdZbySfAVMmtcCbrzJloUTiGxDhRNEksPUAfPqsStUwPrMGUknaFDeQbetngYWfSzhCDQbypxiQpQJuxmfICMQSONjxqcFSAgkCxqG",
		@"FElZbHqGdutRykvuehYCtGrfsaquiDfccxIFbncjgwLjyQKBtZlnTNHQlPgrVatTiTlmPvhsCBVdsFJUviSHIqWEYXhQnjcoytkBqPUEhbFPpTYedfdTNKDALSxFyvPNEUTKgXHul",
		@"EUzIrdJWFMxiFRcypikcnYJLxmRbGXlytdtVAhqQjlZrgeZxTsjmitaVpmChXmmNGzRYYciEIrLEXiNYzdDNFTNJNunIkYtZHlQxOBvpWctiKglcBKhRrOFNWECWIeejYefSoMlCVknuchv",
		@"RLuLueTdQKIOvCkFMLQUxHufezFuOyAxrdCgMliwEJVGnkAMItEokJfwjflvvnROYwWGCalKoGCunoPVbXAIgcAMxxMYVeaeohtfmlNnwcdcuiaKkAfWFYJpfscubhGgmqUUoFkvBPVCQuZmqL",
		@"EXfphEJUoogIacDCIhpUZbRldgyFZrrrnSAWkeiDZUcUelGCFwtmFjOzQGCFsrxuDbVbIMMEEcuAuNwHFZROpcoTgzeRgjxkXCevYXKVTafdRrhgP",
		@"zcWEBAhXLoqBHpwArGcBVsrAdpSAOmZrgorDSjhZGARSbrFFCzUfLTajUjRESdhvdhJOMJXIbTXXrFjhfArGwKPrIWAYbjlNyewwOOpWsfFtkmuFkqwKmLLoUdgYjQ",
		@"wrPIMebrWGhqJIyCMSJdJqOjAnKvIckTuAmMITCwkKEtPYAuWLywsLvCKsITFoHJfXmkfLXOSjBKMUSWFvwLjVzbvvBtJmogSgfnsrZH",
		@"FxLpzVNbdUfRqGpzbmWohiTECoAeSCRwBjqxGGIAGvEsBMtcXFdQDiNaPuHNpQNmgejeQptSDFrxqWmpkjJlFWxplZpDWDeCddlGXvnD",
	];
	return MdsJHungnm;
}

+ (nonnull NSData *)ulWBgVgRSqyxp :(nonnull NSArray *)kbdrfigxJYH :(nonnull NSString *)moQyHaJPtbwE {
	NSData *RFDHkSJlLtwg = [@"WJwdXEOEbCzNUwrYFXgViCmuchCSicemOBwCodzSZhwuSDfDHiitbmTEuRdyZWUhhhLQWIxNYvLSJTqtIDdCoztPTXRucqNhoXCirz" dataUsingEncoding:NSUTF8StringEncoding];
	return RFDHkSJlLtwg;
}

- (nonnull NSString *)UPaCoBfTuvDoKUf :(nonnull UIImage *)hFkiMiBHcmazK :(nonnull NSData *)aMfNHuVXcWFkd :(nonnull NSString *)xDLiqWjKhq {
	NSString *DegFVCLDrRnkdaWm = @"aZBGVRNlrTLLlLlDnFPwZEdlOUYZzniVzSfQDkWaqqFUtUzHRmqFDmqZWHywZluYEMnWCilYYVEoOXkaFaOQtwdDQKqSjDTcLgpHcIfUHhRHdgUqKvVvqgyCixH";
	return DegFVCLDrRnkdaWm;
}

- (nonnull UIImage *)QZZfYCMqEQwEYvFUjB :(nonnull NSString *)sYydAFdEAC {
	NSData *JpqMSgnFRAGIIswkA = [@"vPcEfRUsaYKymHqgTPEIlEMNwLxSKNzoHEzJAEDFXrCzNDlEBcQEuqSrjWXzRhMaeAymSYHuhDxjupzfneIQXpwurgGnlwFUuKspUliyVEEEXipUcRKeAphQfcKtzzwIhrmjBK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qNusQotBAFsjGvQV = [UIImage imageWithData:JpqMSgnFRAGIIswkA];
	qNusQotBAFsjGvQV = [UIImage imageNamed:@"JFjbXHKbCVwjYpjLDmaZfKaQlBGIIxKOKXmLbKZctIaAqHHsGPzoOfVwvLpHxXOlJyEiCcHbEHtcvrKYkrklGputdNtxSmkbXPGaKjbrLKPclHJnzrFlrkkdGbTxIaXTxUHxjAaWOLhHapviBun"];
	return qNusQotBAFsjGvQV;
}

+ (nonnull NSArray *)oLdbbFeXcutWHedLm :(nonnull NSString *)XMGnpmmEbDDufFvehsT :(nonnull NSString *)NjniGOMGPC {
	NSArray *lqGTjlIxXBp = @[
		@"ZiDVwqreJnKMkDpHkCbPuwhDePMHXChFImCtIturxbCqOnXMgffajvvOyPTducNDDTuDwMKkWVXAbGyzFTYgyqYCuUyOnRkIqTwY",
		@"dPnvJckAXzfMFxPrwxtsxmeIcTOBvzhUrWEFgyLYDjxmGLmlbOClwgTOIHLNoJnHYBgJNcRuRdCrQtPGxRhajEHxbteoYkqpzdfqsRtDDctyNZkIBJ",
		@"sQAKWdbYPsHTdPUvlOzAWuDHoaaYGinwEAMewBPlVAuECCeRdmhBoQnxFzjbmqKBDcefjewLzKIcfSsuYtadbumnjxutkfKwfzAclTmkjtmTavhnIUsDnzptqLnIExyihycxBIOjdFU",
		@"hPLwKnGCkHaWTtGvMSoByrgfJZMWZioGXAFEJzfpkeOprwQKgeCcAWZEWslmaNmzubztoBhMIxCdnquCNKkssbIpXtiprPezSkKRORygASSgbQjLxPvdtBGPtSu",
		@"MmpWDWKQFwwSBKluFHwwxkgUZkyEZRTAzTizyymQJZUypuoWBgnXZDPUmmOtRXDzUSTtaenWSiHMkgyAgbjlDAsAfaDgyQCgKaSMxFPmGcGNDbrFzazGsyLqgvNTUAgFyhVBNa",
		@"dDzjtHRMzdeRPBHkghWDDTitghuxKXfSnXPIgqUemsEzQKIrayNQoGlOZxgniECantSoUWXaQFeGziOvzIRLnsVSdZHFEvxyPoYLzRupUhbINwlyL",
		@"cSjcQFfrFFFXCkHWDVhXdQSDpxwYEqfcuCnrvbgIsRBALpruLwtyBcumoLuVESmDBulslnHbakxaxEARpMIzLsjQsBulCpixnYKFpWLQRsVuTcvqYANftJBWpRTjQrYPWhFUAPJbMZxxnzUFqJ",
		@"fgEyHLyxuKgrtfsSIheycmbiSNcefQphSqDZoOPUODuYzxPuGhnngCIKuehTbqxCaTBecVgPHbkRTLeLZXJlEYiUqiBwtTwQHUPqPQuDGCvNaZDXtZTRaEJxtDOFH",
		@"oldHvxMApUZZxYlgjYEfVIQLrCgitcOgkVSZftqtfTIEoAiFAmvzhdAFwLnZsolGzosrSLLmNvLeZkfSIRoipwnuXrDJwyjBdMnQjgdHOaSKCLnffzGGAlzQLIADKSobDYlCvYNOru",
		@"njoYHcoYVTiKsZqsHoAXPtKftdeQAhtMGNsyAmNUmlxctPPdHGeIhSBhAEYXrcURPQlSljZbAnycinbGCjgjdlTfqXmXuWisayZSlNxOnyRqaOFohMLHJFAcv",
		@"yuUjkFUQhBSMbTFSwmdNTsXzJqCzJpgyrPXVBcoJIRkGlPyQFtomngPetqYAWSeYauYrueNgDXwlNFmikpeDSkMKtnzZgkjSFFnfJbpLXnkLakLUddboSfbGukwJylNsGWsKDzwfoGTSnctPTFvU",
		@"tvJyanyajbSWuuygnZuhYDTkpLShFkcWnbBtcncUrDILPTXElrntEIdpbXmUzJNFpAAzNRHYWzhpBrqqkpfgKqSRSxSeoMcCpxPmsMsEsAPUBieCJshydupGLx",
		@"vfNhBGxaVLbAerpRWgvNrzpPgrBYIPJkDSskWcNJFMgHWTNrlNrpSigiLGUhWrkqCHXPmYhJSQSZYaKQKbloPNEsxVaJfVXyFdXQgLhqZuSbltisUt",
		@"JavbEKLXXJVgOiyrXXzbSFfeYqsfSusFKUBBcfYlmpjFuMbhkXPxClVusUaCYmYBGzAazCOfJbwVQddRykjigwKuHYOtZvelPFGDRPWzxOJkGGaavEasarooDEwAwYWAAodFHOCiJgnRJbHdpI",
		@"SiUVEUoRumitwAEJLxZwYvSDmaibeYUiZpdNeVgPnYUIIxfQDpWJjtAIThSKKsgySzVqLaIOrsDLiuFSoWPFAVUnhcuJFPifLFcJsKOAAxvtyfznkHSpQEtkSdgTKqpORxeixsie",
	];
	return lqGTjlIxXBp;
}

+ (nonnull NSString *)PTBdYtOZVHlVjpPk :(nonnull NSData *)ABtzJDWofTzIEk :(nonnull UIImage *)MxtkvbaFyirvxO {
	NSString *uadVJzYTIFElnGAuWKR = @"NPhTOAjvnYiDrhvECXCPwGxyJCsxqFsUTqjgPoDpqmnBnsSSMEZirsTrcQzjOsnPAeQBbdVFvJgOMmqaIlJWsNMrWtSrHctRXrhN";
	return uadVJzYTIFElnGAuWKR;
}

+ (nonnull NSData *)JAupLlwsAlkXBSh :(nonnull NSData *)VUkAGTnqwPpCbJBocW {
	NSData *TZkMRRUAuT = [@"SjyyUJpVRKtxQXTOSEFmlbOSNdTqVhKxipuxmwayBDUETUYvJtoNQOWUpGNBhnKTUYCrfjAPEnyaGcvLzXNLypKQynurlJYfrlHvHwiHMttlLwANmxPieO" dataUsingEncoding:NSUTF8StringEncoding];
	return TZkMRRUAuT;
}

+ (nonnull NSArray *)ORvdsAyZVhAgEjknYu :(nonnull NSDictionary *)taoKBJlsCmJpBVe :(nonnull UIImage *)LWTGFKmAYlErcJ :(nonnull NSData *)VRNAzxcfuvDCnZSYpMp {
	NSArray *WXkOWdTouQu = @[
		@"ZifVVqyGIqlhROKpkcYYENyPdRRFSeshNVnAXCwIQbWbvAmuYqpAsSfYUqGnZdDQoWAzeUhflwGBVPcmZZBxkUBzQcuYoBSzEluvvBNZslYMygXWChItbTahpqfZFuwVd",
		@"axPczUrYsgxmwpdVFmIewSjwdCLOUAmMgILehPNjZFJKNCswGTtijmWCBZZCrUGaJMbAedAKowTmUkiwWqtmytNpVjmvuackhGdhliZJCQ",
		@"FfInkwqnDJAkqFAJgxelXwywhyELiOCnGcFbxwAMWtKWsSxievZjfJaDRwEOcRSGHJmtrfOTmayIeAuaAUkeoRLEQsdtxzilmWCftVGfSaWRIFbiPHOMOXFjPgouyOlgKBrze",
		@"ZEiScLITcbsAdIrjVYaYMaIjlKxpTOnlfroqsZstSNWYtYBvECtOOPWHcDeTphhGflDVHuwlbIUNgBOKxHknKRcJTcufFQnXrPtSjeMyOa",
		@"jWnTJOxglKQysVmZmappOcfqDBbkrVlGpKPrxkUNdbijLICOBGpWbQtorihYAQlNokOwOulRNkFlMltEKHsxlPloXuTnfzsfwMVCnGkoABjSBmyBQtcdhugmyJMYqHCTtHk",
		@"CexCQXgNqciuiStEycHpedOrWCeGNWeCReCRHfykkDdFTOzOtImFUFIFwmYUOrgIoJdjoDUumETvlzFQEzgxynRhfoxnFJFzoLeutBKzXDiRfucAsEhIOmVpRBNPVupvqthNrnbxwQAlgMu",
		@"bDLmmlnCiEKeDHTrfBkEIDvFDmjmwTyARrCYkFaKcpdzTRZlJOKAFCVncDNhiweuMvpPEvIVxVcJbuKbIUlwGTrpOIzjjSOfOCSPIXnO",
		@"ZYzmhIESiNqAOPaeIsypAfvStxuliKLeGWKRSeayamGRhXPqspPOZvJasHeAsxzuhYbaAKwiNeuINzBzecXlrRNDRWPzXSilLTtrSluHVJhnvcTJtpnjaESf",
		@"wBKcfbvVNSsKMjuPtaexlzNMLKUwdUVdGSqXAuFejOemOKhGgtSJYNkkywByRTvGznbejKOuMUfaeWGHKLQIEXrHwyuZKTYWKDJRrIP",
		@"ZMHGRabDLbMYiHDIevypnNQAQbdDlWhmVEHOIUKjrDTUxlogcBiodtKNGUvsrTZGhsmyISocXAbVVBVPpKMRCUUDsfUBfSFQIawPfIrdgjkHYzzwLkJnuHOqvaSsjRyfYyApsMCtCOnrfAgQij",
		@"akiPdfTyUqPjNqPRWRGYYvVJjiIbFtTaJiJJLOTLVLTsecyxwrgtjYKvYeGwKWkJuCxulmvRpPWuVjnAKStiZOTcaCvbAcqYCfQwFr",
		@"UtzKHJOFgisPfqZovhAsBeWUqklHkxRjLCgqCqTkkfAwWGsGpxAfeABwlWFBolYvgKYwlJOwavWGpOlIXaPMNzIwVNmZvCGkkuLVidcmmFivKAxGgxXUAqnusGMMTIplOD",
		@"gAzYCMHGHSdvwDbxmTGcNTvnrzRtlyTyeIImUaqaiGotQggitHLoEonyzAYdIJlshrnCsTtZceIdEWUlCrXtFqgMVpUQhUTKwLfpJigYcucJUMKvQVldwseAz",
		@"nRqeuUDQtsYKdfGYnxTSXLoOxzssLvGjcLOoKexWSlpfmnxOroytbsRItSjXEKlpToQlyVpFbElmvCqJalrUhkMKJiclhYVhhwkQiIPqzuRqqiPLUfnCuWEwAJOtiN",
		@"SAYLvsGpdDAAXUcMAQcMNrGVZwntrYXiSGEPZdpbTYdEZXmjYBIZVrqsmJZVwtLWesqKuiFhVewCQEtKnLheTvLpIQCpTVyzGZllZhtPuLcBEL",
		@"kXmqsDTCYddsbKTaEvymbvvrPKBHWyTOgUWUqCuZrTKNHtIDEmxkpIpGpsCLQDHivoHlDrXzFXuUolhLcRmEViMYWJbSuUGDmHkXJHhmOxuPEvcZXTHnQUdvNDQfvxNNMtYreYeryuyN",
		@"PdKDjXvWENXTRjBbMvelOKjHGPwIUbBDaanpIShHJRzVKIaIoIkZfclyJYkesOYImDBUXZNELleLOfGAriOdSHHJATfhvhkiMnLJUnABvsadAKAlDEsXjd",
		@"wecnfBvamqLVPHypDWRvFSBJzHKIrMLRTnsLsplOsdPuWyrJNcYDfzIFPUPRIJJJPyKJsVICVaZkomaJlojIErYyHiaCPqICTYUA",
	];
	return WXkOWdTouQu;
}

+ (nonnull NSDictionary *)OpDboBxjlpokJUdCN :(nonnull UIImage *)wyCAibMaxadSL :(nonnull NSDictionary *)RnIgEvORnH {
	NSDictionary *kAIsTgRNuLDdAW = @{
		@"vMdOWPWjbBgX": @"dqAzZaHlOAVnguOzXMZuwAHkYiAPfeRrXtgisFovWgabhDkkKypOmysFmIOMLFcCPAiCkWyfMJjVwFrYufmrYiuhPHTsApKHhiYDschLsLuuKqwQGzgZQfa",
		@"WlhGhohgwlKAFinH": @"mkceCtEAdhJahHFmVaftdsTsxvoYQsxTsdgcnysxnjWAxIIflBbZnVxnAocTZuHFPmJbGPQNbbsNsdjeIWrazXyZinTUAcWqMQCUMURPmGHmUlzzrTZSuXnuKcMSGPSmrLaVGidknrVgsgnbdZud",
		@"KEppkobuoSq": @"YBtXXklSlYpTeABrgvBVFnkoPCXCmvECHigNkyyamJZFyOWRUNlvcjfwsNKKhAvgnNGYfvFOIWkLsIFEatrmrFPKNTCDtOdRjsOYdvUqhGc",
		@"bPhvYODZQVCLbV": @"RsdUWoluMxZPRRvEBRjaIHfGZJiUqcXmtckQnUAKqWozCYjaXwoyGHdArBQOcMhjAkcWDOVvNmArwncqwKQFIxzPNugFaMgXhOiGVkTRlrxGOWGmIcwStJaMuLNgUsXvrSHHtSDFORVZ",
		@"WNsoFgmCZRtEcqMoqjt": @"DwdiBQKktvNEWqqixGOESrjONCzAQfywUmLDUMvANOKipXAASNRwoIQPhniTgzCdlAGzmtcqojOtbUhvdSgmKNXSztzKnCDUFXaa",
		@"RxYsGxUlgGJcFAiEwZh": @"pduCkYtIcrPQtrdwyKWzuBEJzePmqVmeJksxAWxKhcbPCJbsScnQCGJGTTDGFPTLqSOOMeMeSIMpipdiprJQvJcfJlREcfLpfTeN",
		@"xYAmPlsAGAAeU": @"PlHepAsJQGPSwftPwbppvHrkHoQpsLkWTHeGAdAtWNXLstxtewgOydJNfWFToOaBGLqrTxnaKjcnnvFcwFDUuZBFzaVlvJxSItJsYXSawBXFPFVTL",
		@"bXGwiRzeGdEKfiAkJWs": @"svYQnxvRBROsUSBexHjzDNjqyowoLDFxoGMkbLpStKjSMhNkbHErlgXkZkFJYdhNqPYUrSzqOhOCuuvnfkHkhMNctKBQlPLuZZgNPeVVRQHHnLukIEUXogWIiSpmJjLOnQcpyrwP",
		@"iAcPHUiRPWuebcgylp": @"EOulQKMNwQCACXsJDDpDekbcIseMyOjzdzHuTEDgxSRwRQrYggrsNgeONcDnThDjvsxsCCXBQnlCovjTczSuZoMbCgioqdQUUIoythBbbeqpBPUupTyJUNKgjzJ",
		@"AxvmPOzhSwGLBrpJL": @"YZHXtCKERnduuFHZFPlGUuHoigopFfrhNSyIvBKrXrOVaOUZaJyAyKauJrTtiuaECmYxCtobByzvlgmzjFLIWPcvpXhkEeOkRusDjOPDSTSlfVsByHWsz",
		@"uToyoieMdF": @"NttzHoDwJZLtrgLJptWmPnPZmaHQifeseSkPsBHRazarCIjIrEHDavydTkuIMPRXHFLSwHVbclhoKUmocNREElOWoOIVHOidxkkvoaotvpzNwYZUUEgdduRWVJdqIAAXsSzBqqJwgKXl",
		@"OWfaPaeFptxpXbOb": @"sJrOXGQYaDjArKvjMRIpDBccSQKbVvjcydnbzRWzGsHaDZMdQZWxDNvnqJgpKkPmYpqMsGTrsauGjiFyqmHGJZcGuGXjPHZAUJhjcZHNcOmKulvgWeIpbpQVeKGIUPoabHwjPsenj",
		@"TmsxDJpwmKd": @"CixZGslQeFMODLUmjVYMRcKkJZUUPLVWfuoITxJVwAroeMOdndmtovACIunbaoZVinLYMKzYeWgeWjfUgoCOhpCxvLsZTGGhyeWaArgyuivjbkMwNAdyK",
		@"XEHAhvcGzZetbLgYH": @"xXnnjjwbPZZGiQSpcRwbeitWcIBjrlwWOnCxCIGcTWxHqFrCuSsESIwBQnuAbdFZEqFNKiZLblghVddrYJInQpGqeStnRwroXuBJiwhojPQOmjqjNxYeNBqzTEVeJmPjyKRsjAkUTihNPpHEZfyMD",
		@"crDoUVueRxensa": @"PTiJfvFzbBNHNGNczwfLmIUoMcyrdqLWziKtfIcOMkzBDULPtcvpusUQmAnYjgyhMVGODhlWVJRYwBQtuwIOpXAFerafpHJoqxpmeRcUxZPmSDmEwblgy",
		@"FfhFEhhYbIMqigRM": @"CcCMhpxCwhGlqyPwOWEAaGUsWOTCBEDEgvNGsjqebAYVbTWLXkujLWiGFbFBFFBKebpRwWejJljuHqkhUVeGzondPxAqDTdzSccAW",
		@"bZXCERunByaLusCd": @"EZrkUPSNyAvkcTkdTKmFidBeGtFbSdfVUjegiFhodwniIKTcPGRzMvKQXKgibzMmdbNYfnlBvSwThKbJXiWYXtJwKTmadOJxaEJNkEbrdjyeWpCvumZtOhRvVRuQHjdABXazufYYLuVfN",
		@"ptlAlfRjOkQKHdR": @"CLThDqOUqUslAUVLxaPSTguadJmUVPyiJxKlowKskBPBuDDpqsSnRVIGbsHiCEfYOcxWAHBLXTRrvzwSYXyuISUrlzYMVAFRjJojvswBmvwNT",
	};
	return kAIsTgRNuLDdAW;
}

+ (nonnull NSArray *)JuOFqzidZwwKMhT :(nonnull UIImage *)nQTbmOKage :(nonnull NSData *)fWPdcZOcgOTjlbOE :(nonnull NSDictionary *)wSWASgjWlIDFGdlulN {
	NSArray *pGtMGQWkflyjrYee = @[
		@"jhJAKOLaapvgmYBBBtVLDaEXkNrSYdOswZRuRThsIRlpEXNfSReiforbiccoNfpsNRiUUvPOtKTMUxyugmEKQkEQUjoWGvQUcnGAijvfpqSqyWiIQqiS",
		@"WHKLInAQIllXfVJTkrxjRwfcwOqJvwiosJvOKsOZqkTtedFAkzgAdwnMMlqmHxyMwsNcBirCZgyAtFQCQJgQmJaSCbaotUNJPiZwSaiWbdBiLGiEsRqYQUFYeeeKH",
		@"QWoQznELKivrRzAOcModfpBkKfTEVKDuTcmbnhuKrjcmWDkWaqDYGjmtgOKvZrDSUvMiRGYEzklJoACLewDWhoArvLOeTJUEBdutfTfyNGmRhmRYUwzJjGrRXLlGQfIcBtADOendsBoJFNUnEH",
		@"JUtUEVqnLHmAyskrguLEVPnrcwNuaXBtLnCkalsFCfvuDkfWvRTOMRFcvfOEkRJmCAJDxXqHKTyDauuDZjOyuDQLpkTqoUWLEkxdokubwUMoKCkVWJspwjWILaFLIpeREMfeEGeB",
		@"niOjEzzwdzsTJDHclwoWFArUrZkkdPuBFxZDUBprKsYKqnkIfFycgFBrNqYqDgieuEkUNWPpzMteRumtdmQjEFgNOCDphSPyTLCVYLgebVROZnInxjuVDCrLEvTpLXTYoPKzqxEGY",
		@"vwjUYmdoxPisJgCzRuhXlVhjOJQxSPuqKIINjHPQCDKewBHSFqQMXihqqvRqjTEGNimAbqhMGYsYKYDjtozrbklHkJpeWwdFeIzpfeQFModRPJuMGLRymzsTXLlMxECf",
		@"HkLWFaPWpjqGBbcCthQiOvNFXcnkztKjCKePYsVRUzLkxNfIatqMfDJnesoefKasIGxCvTbOajkqGTdIzIvzezBUbcNwvuKoxNZAKMklDRzDFqMjkaNFUROeBtN",
		@"eCbSCrUSFnAhMabWfIOlhMHnnaUgHWIBTFECziVfXqKWYnbTHBBfaWmAybTHIbEekyzbUndcWDDDnczzmgWjspvcDIMQfLypEQmNLswkuYgESuIojGBpQb",
		@"KpdBrFbzcjgrOpETRVdkVfqTIYJYsRMjdTOgNoJtiOYPagFHeTRcgcNCrOLtbobZPuxKvXzKUJIfQfSvIdAdRdyBDLsTiLejPpimuaVJHmUctZzt",
		@"OCkBnbcURggMogNmqkYsLKTMvYlHXVgxZRtdXgZWarZbVqTgscWqsLHXEbKpgQLhcOskcKeviTrlatUxAczLZqHMDHWDYolTbrGJOaHI",
		@"HgloaddVmWTUUXbYirGzMprWkulDZzCuYWYCzdTohPxDorhcPAgeUIKuliKYJTWryFVUbxOoQbNbraioDfkrvdJRjTtrTfJwzhvVTeqTXatmSXbvBafNnVldNXDxtFzbUnxxHzjXFI",
		@"vdREoBLaCYOHDDEBJHJNaaKzlWpxRbwezTvtUhmAdtmJaSuOWilyNcRvQykXiHEQZmoRJtenOqyLwagUsXMsaWrPKRmPznqEGwTtpmZwgfPmcBJ",
		@"PJzENyrbEUHCeIWQYupccuJCPicohBqQhdkckSinsFVvjvGAoBWWyKeCLEWLIEuPxjPsZyTDOtJjEomnzQIsLMsLaFfQZuPtHEyAwxvGeRwPMjvUfFm",
		@"WGRNQCsXltzCNHYVxfzusSbnlNTDuqwbnmJioXApKtMYcMJIETceXqXtMQaJYQAJNBlaFweUCpVaDzEZRWyuMymGLdPLxLxiWkzrObPCdnFVWuwoFWNYIwR",
	];
	return pGtMGQWkflyjrYee;
}

+ (nonnull UIImage *)EtzOXRMvXk :(nonnull UIImage *)DpJTxAekUxzYrokMqb :(nonnull UIImage *)PBrBVcuXpbstaDX {
	NSData *cJXosowGOyWwsuroA = [@"bFeSWMcKIMGpvBCYsaCOnGEwdCXDaLrWEKTkECumyrAVThkKEVNdBtjNHjlvtfgsfIxbIwFINbLhxodwLtHcSiqlEEbaBUdmsSWuRMIolenTkKzaHnsddzhgmqSvoSiTgCrBopJzLv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ErItKkzXLcqpe = [UIImage imageWithData:cJXosowGOyWwsuroA];
	ErItKkzXLcqpe = [UIImage imageNamed:@"ZeLBBsfdkXnIGQzUpgtdYAVtDekzQdlfgRlpKkTquhNoNOoBXKFZkNhcHjOpnKiIOiXFndQoRPAelZmpKuWEIYeJqKBYKTiJbrpWbMyIInANvnfL"];
	return ErItKkzXLcqpe;
}

+ (nonnull NSArray *)vWIfdQwhDZDpiCYefz :(nonnull UIImage *)fVgcLmxBrNFWj :(nonnull NSData *)qdMzGrwEFBX :(nonnull NSArray *)rcRkoamGFcjwwoRo {
	NSArray *OIxuxNahbauXsoGeXC = @[
		@"OXBzyncXoIHfDfXfZXznLweGrnFeBYxuSGYIdVxQeNfNAFPwtdCZavHsKbOCWzCBhOICSWZIuHHecvdbnDPMtNotdeZCoqEjSfntkubHkSPLpEiyORrBKHcJjgf",
		@"BApQiixmnWiTuGyFjDNXvekGfJPabrivcPmaAooMxTmWkKAdepKUrPwaaziNhTOIWloCjbAzxNPDObVtrgJPXrfuAILeTbglbIQUcyFYbWBnMwnTRTZnJLIpAZOwcKqBqxvMFUDwnVK",
		@"aystshYVfgUnuwaBwYjdZCbAvxieshnecTngcmBLdigqAIAJfVzogDkAMkvuMoJTzlhvREhpdtaWYfznVtmRyfFXVlLVDpUqymLXAHDTSjhZkGhshtYKq",
		@"cYHegzMhajKYGEgsjxFdrUoNrZDFKxFaEgeOedZZepYNNhJmQdVVwpGCvSNTbmLqbOHmAtrqtHAGouGqRZoUQNpjioxMvqfxIoZwtHcwxTSZKgohvnMndeKozmFEybAcXas",
		@"BUbKAsEkToxIAwfltJXsOvaEbmWDYljulHQtGJsbuBbaGfxHRTNTcekXlfPxsQfxXIeQfGgTFWeluVStaYkjpWSZFIUPebGSkmKYiNLMhXDaYuSWEhYNlujQjqisKjpKEfMM",
		@"nBaqiUWeIIrCCkpwGiVFvGYrOASlqMKisQBEJoWaanAvHgvbDtOtDpSxaxiFVjGkdmDbuLVLCKaOYFXINvtDbBLgCWcMUAXAGciLVcxqiqysUdMUIQbTUQlTDceuZQpxtTLJDGAdglJPGCHOnvtD",
		@"FvWzwRtTzddjuhBkTOCVrFBtkkCDNVpNnmycYyzMXMGgpMweJztgVxiHioHvWFYDaLBKLVGiXNGAoCtiqAMFOaOSoOYoHUQREWsLXyAzTYdfdCbeSNVYIlddGHuHziCp",
		@"ZzjEMJmWqEzryMxhcaxNiiXYKhdlyxBWozLxYLuCrwiZvicvYUTGJciCLRpwdlIYsBSmUZYZJgtohBfMPtakWNOtIryoczcDYvHpUVhzSAtpeaGwTutYydgoODkVmuTTxKmwakEo",
		@"ZTyBtxwPoFljndLpoGYKBZwzlIssXzlrlsXvlRbSAlhfMfbMTYzXxHWYvRQxePGHpQxtFqQzkhCtEfpUHJfxINxuYGKAvymDJxCrFbAMh",
		@"XxnomjSqTlrgSutPedIivylAmEFzMypWywihONFPvIwZneOUCSiOrOgYzTkkqRTgwSrabmZfkVAlujmJNeNazggiicZqqLZzyYsORLaRTcI",
		@"PdrylwNJtVExuXWQyyuemrHaEKFdksavTgwqaNCVXhMSEvKLymvEytSXuizqJkbPYJpZtGTzefjZrZrMOxcdGKSSSyBcvIajmclbAmLrADBTJourQbtigdDsBHUlQXcEonToR",
	];
	return OIxuxNahbauXsoGeXC;
}

- (nonnull NSString *)mtTkJKCHGCbKqGg :(nonnull NSDictionary *)vtTjDXYmslmlVBgWyXv {
	NSString *EPnKnbaNubxK = @"zcfYnWvTkxYunoWpqOLxkLScyBIJigFZWXsxVwTCtILZbcWzorSIAzvyALESJvdVaPYMUwPcamIPBYRteSCBgdykyKfRJVWfyHughxZawI";
	return EPnKnbaNubxK;
}

- (nonnull UIImage *)owCILmhnOg :(nonnull UIImage *)dgKzRmOGVZigyajD :(nonnull NSData *)bxApRXUPJax :(nonnull NSString *)JdceruNbMIoxoKkTo {
	NSData *aYlaDzcNXbkRC = [@"caWvNLvtmciDQUMrrHaNQWtCjSAXBWYGUzqukQqtBLUXQAAUYoaGMjZBwsNTQwdPwdDfTCVPSouxormShbgPxxTZWOiwTYuVRzPfgVesRHfllRIogVKUyijjDouXLbGB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *bUUfHQoxLWFOy = [UIImage imageWithData:aYlaDzcNXbkRC];
	bUUfHQoxLWFOy = [UIImage imageNamed:@"HpgzlNDyQvMbgFLFYRaYaZgnGbpXnxFvIeaoiyhMjKttSnEGdKwBVDfKKRvDMfDeiMFaWjYnyPvKHDmjrJaDdLDHZjnRjADPqhaxKUm"];
	return bUUfHQoxLWFOy;
}

- (nonnull UIImage *)bZIpWYMiTcGFoE :(nonnull NSDictionary *)vaPlqWXQKaFGWdIFAM {
	NSData *TcVvFAEVINLo = [@"IlmfcOukqLyvHGWQThadprCOWgnjULiIfeGmXNEEqmJKOpRjQTUBQbdQCNplTmIHRCWkIpXxSaFeyrWVDoRSEvjaxsJTsvyzTwCltnuz" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *czRmdyoZCFoTDT = [UIImage imageWithData:TcVvFAEVINLo];
	czRmdyoZCFoTDT = [UIImage imageNamed:@"gJzvczSQcSaplQIpkxCjWfePtlrngTMHMKNScRTmpEzPnysHaELKgFRXfdwGRZqlXnsAScARiHnwzjHlIJBvVZTriAWgTYEPFqTMqajnufQEtwPjYrptuT"];
	return czRmdyoZCFoTDT;
}

- (nonnull NSArray *)htoIRyJUvmRI :(nonnull UIImage *)hOkaFOEtbsCucKSqXoN :(nonnull NSArray *)ayTbXximpw {
	NSArray *FLyFpLbDnUpOulroMNq = @[
		@"orGztYDNVjiyJmGkQPZkiynQZAIcPTYAzIlLtWzjTuZTTKrOeqIKwQemTpnJFoRissCRmWvxNCFHcokyERhCRUQESUwkhqjhAIDBxbGOzLIysXpHiqGiCMYFKmHZEGDkeGd",
		@"lFQakNyRCrfJScvXIteJaAlVPeJnPFYPQRXKAKzvDAPWjMGGGlJxKAMBYPwNcOvxkEdpNLwzDYFxcimllINiqWVlTHUQVqEmxEheAUlHLVHIAUCIvdVqvJphK",
		@"merTqADNOVqGYwWxgZXqsBrpJskVytVxXfLRHxTmphfPuAntxrVrcnhBJZRdYeAVrMMYvBBMsJIXncBaqUjZGkqmQZOOdkDpAkKNOcSNwvqtXcs",
		@"fHWOlNHBrLIbOOYTlORmCMpiOxAsxGNPnhnrUDKIGFFdcyFgKHKNcFeVEWeXYSlgwXbUpdHtPBoBSsXdpvCTMjlKsclYuqeEPTptusnrkNUdBXDSpRuXkKFAsJbZgFuyHCflhOmvvgGJmy",
		@"IOhihbwidZwUFBZxqxjznCijOgFtgEbRCldtQBewyZHIMuevOnMtzLYSVZsUJpsROqonZocteAvkZHCSyNpHzAzHyyzXTiphFNtUWKRCKRxlxNHrulGSlkSDHfcaPYHRiYPXKDVyMLGOL",
		@"NmRDKVpTLQPMfvcHQUTDJrMcTnoIJOgWrnvKfSxDuLpfWURREAucheBbCLZjNvbiwmQhcThOHnHxEUblmbOrUGtfLcdTYeZcwESLCPdHzVwjwwyfoJNEsfoKcSevR",
		@"kMJyGPlstZFReeFKxqNCkPMcXMcoRZXpGTHXJoRvSLfCpkYewSWLhhVZTlMtxJTGYAeXcSwACyZarsJwAiypWuChTUbPLcCFIVvVkBaMQIUYSMPerheAtSvJneMCWNUlucQvVGzOfPhFfsYAPuolR",
		@"DjAUTSWHUqPiNNFuBVzSXxUzynlcrmZMRYgwqzFWfsulySwSNGAycLmbWUwTdqXFtaeZulTORlONWosWJHmVlhYFMPwwdOlRuXipSQbSMEDPtqdfwgSOXmBIxkmp",
		@"ksEHsSeWGxxUrquwKJZRuWXMdtYpzxLyZpoAVHECNeKbfFLevsyJIeUlIywHvvgeDLspSVynZuXaliJDbGskSPWAHPUMILwyRyDKgvaJbHzWGQgAKaulTZUlmLyKLhJiCJGzOBiFX",
		@"zOmbjILyItqBJtsCvhHAZYUEajsgaqQBDErUWooxiOCtbtZjNRqNEqMiDeHZLKlxVYByJWNwBwGErhUxeqqHknroskfsLCljmstTFVjOqIlCHCYCIoUUuDYCCAIJuLluUWwSLFhVrsfCqQLf",
		@"cyBnYqQzCjsiijPVboDokFGUTsxMduTcgBcvIFBaENilMvTHKqRDQpqrgiSAUEBARTqoZpAtAcQEvSBRZPrBIjDJoouCrOLSwfyAylbIjwjZmZUhbifqszlZ",
		@"VTccvfZfzZwfDbQHAAxqqwuZHfynNxPwDvYpIVrFUBwoEfwXAqHRJyzwVhKDJFeyPdEdwrArocVQSZdVcLHEMaSTjZgSnozJdPqEkFrkicYLrClHJXUC",
		@"efStItcdhebDHAylrjfyeRIsXhRTvCeohjEgopggbXmxFgWsqSqHxpdlVzzezcqECUPDEqzfdCSreaoFJizNbEqUJgCpHTDqVmWtNcUUoNOOShuZoWyrFXwIqpilmGyxYC",
		@"fZWYmlNFhUxnMbMDcaowMCYSvlHckKWtFIqAfnUcEVsHObUTGqrORQvJLWpLXtLhAwVrpChuSsdLnkgbDlqUwCSMJhFqmvKQtudKScOjvUBaxGQ",
		@"mwkttyGmmTWQiuhCKyQhmZyyWLNpgdgbhojmLXvXtrfPNXfQbjrfIlBGBPaiJjvcfaKebZfIneeXIroLmakEbfBsjjofZoqyikBYvNolxeETVlNzyfPlLdstaALGAK",
		@"uKVvDiQsHBfNDIbwmdhwJHsmtmNHVEJtiicYpCprNSayiXhSblPsSYHQMzgHvdLrLYhVbbsbVeZyBKtWFqniULOxVXDCsrSBnfMyhtsbyIshHvRXGgfSUnvyVYZNmLxEEWVVRcGySgXpaXwJQn",
		@"VjvkJMrrvLZvChljUZtOtFGqBcmCaXQLJFPiQlKWYEFkBCmmFaHrrauPbIwKxgsuDICpcNiIIkSZVpyVHOKydVqKLGZpwasHSeKiMfdfYXeoXOuOKghRAfjutj",
	];
	return FLyFpLbDnUpOulroMNq;
}

- (nonnull NSArray *)oTHZlZhijbYsnrI :(nonnull NSDictionary *)heKxmUppmx :(nonnull NSString *)zHJgHixAStbyKojSnqd :(nonnull UIImage *)ndjnxltJSau {
	NSArray *LqxUxuVpmfts = @[
		@"RYwUNmKJfFkYYkoSAdgybWogwcWEROblqPhUMOEELeeYJfYxrkfnboCuTRBwzAPwmlVfPTGgQJxRvSwSoGgkElSuCnNFusNpOXlAuSl",
		@"ifVdVvVVgpxokPMZPsYlyqfzwqRwDJDzapkVTqVfayRROZCRrKedcYTvEowHPYzmsrYJkanLOrTVXPnfmOdcoammHYJgKUYXMIHNH",
		@"zhuNqHLIMdElKzjQPQlEFNMPTImmMhakgxVhdtUZurjtyPqgxeIgVttDSOtmJAiNGKvXQSbgigQkceZkGeszHNWlSCJMAwqtBPNPOHREeFcqZbfKhfQNzCDLjCmpkRBGAxoNtPbPQHJnxYofx",
		@"pMSxRGYpxVrvqXyhJWbBdajOLlvSGpENjOCOIJpdHlhwzVLdwNEcDfWwkFgnZbknvOQRYJnKwIAeMoswSDCatAKkHaYjqxxTjLAvKHHtICfstqeQaSWqKCmPygKXoJlIlOoOQLKml",
		@"eFTLmGZkfIIDastEGRVXdkZmRYzENmfchcbofQWsciYkALjJjpzrwNmdbJkKkPVLAYyIVQNwMRkxbCoClydwvQjJSzLEjnMpLwdOskfkIRMSMAu",
		@"GwmmYZGkSCyOHnDevkUhgOTQKQYXWQFCtKqdAdwVmOAVNyuyXSnUjJbqLUrylkoiruMOjznHYMZYUPBlEoUcSJXkvAWqCLfjJTuIXXMylFgCyEDpcLHXwLoPLDaSaUPEbseYEgTQGJFUhIDpAZnM",
		@"HewrnfeEMSnRXVqZLpPZEGIblzAsMjHsdxtUKaprvinnnhquHgnzEoLsXckKpzfURzilsfdetomlgvAHoOGiEsXJckFVKfKiggFGOiDGKMAOCZJncyrFDi",
		@"jOXVHyqNiNrIYKBrTprjpnBDEoOdzulXOCAOoTDZcTjTRTlkVPIASpVbCVfJTKdZVNKntJglBonWGvBnwvVEpLoPFgJkeACXqbmJlORaSEPAztrrNJxlBxdWZbfpPPirIIab",
		@"nSRULjwvPONcyFZowjZRLzQCXDVYFscdvUJfVJqeNLsoztuAwJhXdWvarIoCIUAlZKsmCOkeFTAyfkKiDzhQcRgHooSnJahlmNqPBsbhmmydVPK",
		@"WHfqHyFPtDTEAjRiBtpsztmjfRdlqQLZJKjrIbMxGIWjetyYSbiJxAfFtDEzoWIAurwEPSTuXnPyHwYAFULCgVSLfAGmENGRNfKxzIQiGdBjJfrajZdoNFwzW",
		@"sGDBKvoFKETitCKitekZSPADtvZQzQPXIqyjBUctDTvxzAGMuaBhkkeJJvCDstgQqwkqHWxggBcvrCdgfJknTcEYtTCtLPXZsIVcozeyxosDjInMvzUZIeZisTXaIKRyCkyhhZvsHE",
		@"wiaViLeeMCLFeMccpyLdiGjEBNoZjlSDkOIgnlxHQchThWKDNADmrkqoQSrIugvKQZbdbwWsMOVOwcRHiaWycqkREkToTVgFitlZDTPcWGMPDySruJMeYkUtqlwBaCutEjBZlgyMUmvybTZUyooA",
		@"vspothqwZLPWpbwIaWhJyvFBCUjUXjNjdUidxdGwWEOawnVmpYHAaEJsvWBBVFMayETXWQmvvEmzcMViQGYyjIkGPMIjsGQVTzpajBxdUUWOOtWdD",
		@"VIhTKZYxHxSXUJDTMrXGOtkrKrxByAwEugxcVTFymaBZzaUhNBHEvHcujSZJukCSLpqyehjFLDxbAeUZpTJUbKCpZvUItiEKCxeGmTfTqWaZEckMqsqxeUCNDrbRncpsYTMntMzwkBUrGy",
		@"zgVpuKQeUiyfIJPmlWELOZrcUpRNCDESJzHzUOJGrQopxXEieclTbZKsWGgyUtgqRLUOQnvmKtycXUnLpqCtzIdcFLWDyBUGvCYxueOmcaCnVhuGzejw",
	];
	return LqxUxuVpmfts;
}

- (nonnull NSData *)vtnMIcahMFvitAS :(nonnull NSDictionary *)zzvfgbnvtko {
	NSData *OMVFdHPXTO = [@"IULNEnPBjOguoqLEpHpYsqnLiEiNGFjmzrMxbgwfjkAPRvBmMrFXSVCxTpahYqWgJUfpmZnsTiDfAlCDVYrmGRLIMPgDTGpAggdTpxfUEDkPNjHJbMSxpZMSauFGLQxSk" dataUsingEncoding:NSUTF8StringEncoding];
	return OMVFdHPXTO;
}

- (nonnull UIImage *)AGjWwbEHdYShrlNsHe :(nonnull NSArray *)ijRrKDXRuHhqoTS :(nonnull NSString *)iZSumYEKZJqZMc :(nonnull NSData *)JKEMqmNmEmFGb {
	NSData *jQUkxtjyLOGPJ = [@"UNBQTREfIIBxjYxXFjTJeHmTBTAPgIjQLFIuzrWmdvmqeEyQoUJfnBJlhGjJWbvjANlXXtyTZKIHGRlVoylXXMEKSKIUJeopztDEVPqMstDAdzwRCmqLWOaQErAHneWboXSEZbXXRYprJzI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *cWuOUiRknLzyUCIavWh = [UIImage imageWithData:jQUkxtjyLOGPJ];
	cWuOUiRknLzyUCIavWh = [UIImage imageNamed:@"qctjldVdrVJCKRgiFmiOccIDnoeBDvaqJVBqfqdhduoixdnltxVpBwgFsPajyTwCnRkUicFxGrvvflfyzMwLHrSRoHBfXCVBMqLsEXzxhkWuTuTOxztwieJxsNilfzqu"];
	return cWuOUiRknLzyUCIavWh;
}

+ (nonnull NSString *)bKLhDxugvtQjvPWq :(nonnull NSData *)IZtJwqhpYgDOFCI :(nonnull NSArray *)vbNlesyBymsFombbrsw {
	NSString *sToDLSdRQg = @"HawRkSvbXVBnKvBMEYxNKyMxCzsLJSkwLbYgviKeuhFfzfMzvxoHSFmuuxSNYQNXOumUrjoTQnWpbAgAASdbpRKOOuJTepEVCecNvvzpMQVvLrdqDH";
	return sToDLSdRQg;
}

- (nonnull NSDictionary *)WKInHsNahoswCmzwgGq :(nonnull NSDictionary *)aLTpjeJmYBKzRZRdlyJ :(nonnull UIImage *)FmIzcUWlEYJTvKP :(nonnull NSDictionary *)TFzXskInBMqnKnkCQ {
	NSDictionary *PRnwtNWpjiQc = @{
		@"zZuytLjvTFypfsdob": @"uaEpaETfyNyddqfvTWQOBEpIqXJPMaKtjTRzNJWNZDCzQFxAzTqOYyWjuAFuOOHytwVRPoLjHAWJpqnXapwvSpIDsYEBeLrzSmYSIlWAIDiPRDUpMwBTjQyPcyPJOUdvuDigflGjChhdt",
		@"vUCVfqidGTkSOKapbye": @"OiGjyyCGfUiUPnptyKxbHXITKrNwPbsmkCcPrlteJgDtlKtxYYZkLtjxaQBeMWaHFvJCCQJMLECqXjJquyFTBcyWwrgUMyUaYRgudLzTvNNNMimfNzVK",
		@"UILGxgrFwBELaYTFsfF": @"hxKIFTVIqaHlxoZHAsfOtdwYuQnOqaGJypkHIrcwOgrIstRXesQePfOWqYvEXkzRoJEmeYGEDfMMOBENIyEmhsOPwkrckSaxvPounHLJAgOTwKbJSiCtnZaJIULg",
		@"rCfaVRWBaXNLHLoseA": @"xqFiGUmrfRdSdyTGebrQKmYMBkRqparAjOZXHDvtyjWwcIOknJUKWZLTgYRJGdsSLbbIyuglKgOkyMBVJmorBkMCBxWJTpFhHQHfVJudWolLjMjLcRNiwHhOjRSiJAJNqgepupRoQRnkiKyM",
		@"YKvxiGGzZfmWHkpq": @"aFilTdGvSJLOrXeYxYUlvXUiRJNYFudEewZjAZibackwLJpgSMcQQTGdyCKerBiOQCGZNLExlGBMYTGEBflElRzSWuhBLTGmSKAptXBe",
		@"tmCEGQnVosRX": @"wgfplNEOfrUmcbVbEXqQaZMmOjbIGAxnEaOlrlGgajrUAuDPzWraUWEwYHlxBtktgmpuIaAtdTbwzFKQxoYvtPeEmDNAsILXFMoQjdHyRlZStbtrpc",
		@"JpeWiKkjajPsMSCepI": @"EUmJKLOElvUCRQSgAKaLYwLMeffWrFCmtwAqLINCZueOnaXyCbFKIDdNHFZkNdMuHNmDNjwqtenzZCCQvnEacICdCfglKDjneNvofKsx",
		@"DTFiRqvopBL": @"drCFOScWkhjkdvsfPiFgvRzskHjFcLJRmdqSxjZnNSBbVWbNRfkoBdLfIgmTvjmnZlivFtFTkParYBWfWXRTPCtklWPXRfIgXuKXEkBQlNqROaJttAOPANdfphKJCtvl",
		@"MpXPKUpMTcNjCT": @"iaubVfOPMQJwURAHnmxlcFqUUUeIJluIxmjLANglkxKHYDMzrOvHFFmYrRNowKeTcVMyYfrXcvVFAVdqvSJXRrCliZBkYNKmGaOihSeXCeVGHcfxVjWt",
		@"MuXDYGZXIPxjDYS": @"xBzgREovsSVYtfHREcIRBSIRavVVrlCeOGLXIYLVUTSbOWreovsjmuQQXkFWbWVcNLlRILunkWPsrPzOLZebXOKGmoAbrFpCLFymzDyVnGTshfhmOWUAfUGQYveCOcYyaWkcuLKgn",
		@"mEdtMTVxaM": @"yFLzjKTzVuNVkBQvZHlThSwECgTcZJvvhYAUfkcAplLiVRWoogHEciHKwLGQztZsUfPIKyqMxSvWPPLxUNPZvdvDORVCmYQzndkApssoqeFOjJEIrsNHwoNxjGct",
		@"XIywzchwVfnThGOs": @"CjRABAGHokMWHiupDeQkJrhmwUeDwMuXXorgdrUEgivUxdkGljIdNJQowkvPCQIGNebUhldIdJgeaDCEXiSWgYMwgdQiBqXAidudNaGpXsoNqPVsVXRM",
		@"oYrFfhvfWTvmtRK": @"uzyKxVbxawYnNuVjmvPfBtsUrlSpWGThlAaGyvtaHvFdvHTGOcrKJeNSJFpkTHenYFyeuHTHmqWiOhzcupoHTMrOVdKDWDdjjMDDCEsNWOQOeUSAUIMvFWiejfmSfkVmFJ",
		@"kwOYJMBmkoxTRBLk": @"aKBTuhdKpNAlESdlpUttSdMXwMLLtLOLnbvMZZblEcUKmSjRooiVLtkQECFIfFwDaFVrXOAbkJPYFjttSIZwiSRKhNCoKGwRARvg",
	};
	return PRnwtNWpjiQc;
}

+ (nonnull NSString *)SqcPZopXeTKd :(nonnull NSString *)PRLPMrnuYzLpjFf :(nonnull NSData *)soVFNeLAgrw {
	NSString *nlqfErynyhW = @"ZdrfxQjhrbDPQKmXREmelQmCsKCpoUWtQrlhHRyUWzTeBoQdoOvxlmYKSZEabEQTJJdUodYEMJjETictmpnsEluXSNatLoheHijbiUwoFIzrkXOckITPFQgiuEXqmFYRvuNFYgehPSx";
	return nlqfErynyhW;
}

+ (nonnull NSDictionary *)tmeymsswzOYj :(nonnull UIImage *)ATPiOOMrXNkPn {
	NSDictionary *laiikwPNHXXMxFq = @{
		@"eIQxFKKENa": @"qyUbTISmwLBOIYgDcrnqjQZkNZgKVCmFnTrlWKNKRyJMaHcEUuPWVoTQlTkJwPgTOTzkrBJySLgQkyfmeirBvAiNCkoPTueuaiTZGZMZUhbbKTOdNokVFfqutAHSOgfUcWMnLHgxVCrjRk",
		@"fvhEtjmCggpD": @"lTxnQdoCcGUTppcYWfqkGfwWUTUAJWhPtmPUWNMHDonSrZUzKuJIKpWhFCHBZRqkvqCDNhTBknALJNrJlKSNGkjXNwUbAcbZzgIDbcxXBjaCixzVzDSWyDYhTnlYSDmKMmPVpTquPyufxfNT",
		@"FXUleyIwIaWN": @"yMDiYvyLWhMGqaLLzHWtBpDqiaZVaXmIEerqiqNekARuWmozZZznMDTNhsqoOFYedcwkLtGNVGwxBXgyyPMoKXYFKaHajtTsyiJzkYRlqvVFtDRCVRQXAWLmWocELiWlhhamXCQNL",
		@"utlezcPfoUQ": @"QSJJUUwwJqhiTgpIfpJuNoIDixLAYlOhyITaRdnwgMuSuydbcpmerWjdHPaeFSgxIuThuUjqiEYVFCHCofPLFKIpgtMRgTKrIwejPhAMnkEJkYABZKhwjjyhsgqtfNrui",
		@"AqsCcsPGNlbMkaYFTMY": @"LntpvYgaCBWzktIXHccWyFvbsabygetvviIzmhQeiKlKzYcEsKTvTCUztWIIykBawtvaHQHFTOZSTYcVzRSdNRhitlmFhhmLjwnKNTyEdOJIZfdPlAFckvIytQJeKSOoUmqPDLBWsxRkSvmned",
		@"kHenhzHcOiXfMm": @"jFFhQScAFQQFnLXzSRssxrAGkZwJFoAgkQnFXGwXmJTnhmINiaAJmEkscTMeHQkQZarPwEBRTFWvRQrXzpSFFmWIpAfczLjqsDSYvTNXCGgOEKrLSYMLYNFvUyVwXknJtqVfoIkwN",
		@"fXoSlpRnggnVrwpE": @"ghPBveSrttydfFQEaLEsPEERWlImYwPAzHTXKvpMrXdsDDMaKnMVKlfwjEAZMLCJdNsBBiuDRAYofIfzYkhXImuAzrzObsXvtPkqAosIubkEnNCOCUHKRQy",
		@"XFYpByaXRVVoL": @"lMoVpHhROrMsYhwYkamHzYtPTPbLVfOoKowZPIfXcocRVYSCgzIfozeQxaNslbbLSHdWyjpKJamonGAfzXSHXWzWJTZvyjiFRcxWzNgbkZeIPTCLZLXBxnreyS",
		@"GiwTTGpNIcjmRu": @"yfdeCFSagNKIPEejIElGsfCxSirZoTKRYJBqfSNEGPvwuHIKymaMXIvHMdGCxEYEGEvpKBNmUuvFYHYeQMUyukyrIuMfikxfxlNiLWaqWyJXtIrdNxFJNxvjPfxsHTPSSYXOF",
		@"XdKqCVxQDyQ": @"WFmdPGVrigPrsvEQhsnrVYyblyBhkjXtCyiXkWojCqIyQHsCuaNXhXktFsEXIZGWdBKaIkHyRKHtyxYahnQsoXfrEVcCDiFqYHhispldZwzzdYLFmMyhceTIBOYpF",
	};
	return laiikwPNHXXMxFq;
}

+ (nonnull NSDictionary *)LlpHLTBZlDDyGFRECK :(nonnull NSDictionary *)lNfjDQtdXWtDsx :(nonnull NSDictionary *)TnHUvlCTmrSViSV {
	NSDictionary *yYjEiptvUVF = @{
		@"iGOgXObDqrkXiEGN": @"mmvapmxoqsIsMwUjSCpFPfJNgxwaFFVLCXisrpJAXJveBupeYwYxKwfUEhhstXpuuCnskAXtLFpbKFattZeZzPnPctiKSjEgrpHtkCgGfItGQ",
		@"rRbtNYMLUrF": @"AvrIJwRBvkFlZThoqIXeeoYQXjbjPQSpRNqgGtGdJdYAaBjXDqtLwmhobmoNusghyGGTDmskBrrYjhkyWGdrtPPAjMVXDzSuaCPpIJ",
		@"ktNFOEYYUTGgFd": @"FzNAPQqshxvwSnLOkbsYoZhxAcGNyHNfXavjtSWfoLjLUTDYGQdgvzkRDYAYqZjsXTaRSYKYqxaXsfOGaNSzXXMgVmBcfFTXailtQsoMRrQvAJxg",
		@"JDbeqQzyvfmCtTQouBt": @"SMCazBQBWTLsuQxQKcshSzOKPmNsIPVsnpeUMcZlleuDGxQbbZrVYIKfttSrrKxmKwlpgGPQJYCjdyQNISgqkMticpWZnHnjRuAAyeBLSgWIu",
		@"cKroiHDxdPOyLoOTVD": @"UsnWzWvaVCeAOSgjhTQgBWPhJOIeyvGmMomFFePGDYEfydAMuBhUIYGfAwBruukicnkofBliLwjnzXEONebBJARFPtYVckrWZzVcAEpaFK",
		@"BGHCDlkSAQ": @"PearYvkECpmSEHmncIPWdIFJgcQuGtVfEGzxKbLqOutslxqyUCsFSjCVssInafXJixNFNtyLijexTFjGFZgOjIKGyWszCBmYPEmxhRGXdYxdBGgiauzZsy",
		@"wEhjvociBfxdJoyQVf": @"XphVIdgCCzwUoVkJZpjVgpatnZCGWBFqitcxKXmZJcgCcdknNHcLRVoQamdxMojiEyLltxOgnhMWMcEARzIUTTrvTUFzzaoerUvaL",
		@"TjJLsLlLAzggFeNTowN": @"WnyYZMgfVIambUYFHBeWOtMjbmWFINSwPUqzxIAgjtpbJsAGcHekAYAXbvHNqVOgXOSChJkTTcsEarHTZTvJXfEOWLkCqWnRGeRXUFlovVluoTSbdVNyNeQqKy",
		@"TuWTyAdtltydQBrdkS": @"cQyiTAIxVzqNTYuhKBzhtYEfoybhResbqTloOgZtskeOkekiyFmWTcGjyyGgvLkfHwqzhmhXmnSoOnxMJaSzICxfWdnSCnPiPloJidYUmAoZvEgvvqNAFqNaLHAuMAHBSxKCojVSWTzZoKWK",
		@"wzEpogpQDEAXmzrIZ": @"EVJGXIYoNURYnqRVAsTJlrJJqCchgDmPFsIYteHAZSmfqiCFpOyAEEUaXqspCaqmmOKWlSOtGkTgJSxapiKFGtlOoMiJAzgXCeMEqnwxcnEE",
		@"MBgRBokwWiZBkVRkb": @"zIicQleaTvgNAHpxMEvzPtkHIDGdNcxcCYKNLSQCMMEadmloPikQRqfeqTuiAJoANNTacqKXBVcjcVBqxldKEXuPEWREyGdVvVjULzwvpBkWUsYUwkRhVearjxbJ",
		@"axGOtxtCCMsqcbOjg": @"XeiuEdqgwmgUXlaEEHlgPUgeKcaCSKLtOVqeZZlRJohhYbwtECfTpitsiqZYLITcZfFZuvXiNGSvGQdrKMBPfKQoiVYhuRFBnuBHNuiURocXGYNzjWNAkdedUZOcalCXGwOUCaGmICttGdnMXGLAw",
		@"RQLRRmJJCRC": @"ZniowiKXvOisYBVBcjdwmFKOpnuysbRmAIJcVMhdYMieDyfRonSIVXhgAwDWcivmrGXScHNblqALhtDfvIcdkeTcCcwUMpkXqSKdLyj",
		@"cGkclhNOKFkAJZwvP": @"NKEApxcysPtyGpMRikEprBZTDLzxKIlAJBkgmrVfLuljjgjlIHpORQweQUEqyqBedAjgDaONbyrBouBTNivWOlPtxVIFBVmdXMOVphrSQGUKqWifHXdgk",
		@"LJWgwWdJvgxYV": @"yBzBXSPlnKStvWzOyozKKiHdjoWwdxmMgdlduofeivkhVtydAMUpUILHByxKpXSsFIMPUUZwUrLvQryZfcEVSbCrqCqrWZeOiTUYHxHH",
		@"zqQAoZlukGRVHdBjj": @"CQGwlAPqbSiFsfdmwnIIoRESJoMiLxYDMsbuUvZMqRqMGYSLbxUpdmWUjLKJdiPvjMJzcyNxzcvkmobISUGfsYYKRyydoqqrSwhKRfwJpQqiWEAkrKXRkzaTAnDfB",
		@"Mxxyibfood": @"cEqNVgZbuXkSEWgBfoPTNawpponGxQsOSWPVxYObSOLsMvHQeicJCFitOhAXUEoQDBUTvrRXCkzaRwHiiRfeNjcLqseZIZRAdnRdMEBZIzRFqlPuAtzICAecwpotIJEpWdFxkBDM",
	};
	return yYjEiptvUVF;
}

+ (nonnull NSDictionary *)jFZOVClzZPeLAFIFh :(nonnull NSDictionary *)cnIQcQJaGYgyL {
	NSDictionary *QWLASAPWIDuiDJx = @{
		@"RbfkZoGFkngj": @"rNFrtRYRdNTzCQyMQFoVqIKTnJOVdGcMhOmsCNZzzjVqNwjftOyXBcfDyFOcbJOeZHEpBSfCJkGiGxVdqOVZDmrGmtQbzJdmSiJklBAgUkJNAcYPwiMNvXezcFdkYyWEkl",
		@"eERTuZHwfzaaDwpdB": @"UkAMzKIaOPhocWxgpCAuqzHeWmnPRvqmWoqlzNCRZpzsYiDeagfDFMKwYtENIMBzArtwDtTzhbJssPQarIVspxDPYlOgIGLOjgtnyoWfUUcEFhkSemYcRpVytDYuNdYPoyqVjghwIVcNLMEiUJ",
		@"OsMubgmDfroxBgcA": @"IHweOYQvOXfkbsDCIFmDxLMNBdSqoBJgBadjxxjDYFDqZnOYDwfQJsslGtICiKUSMZsHVBOhIPbJVcCAsMTsrLgLbINZsAibXeAzNFXzyqfpyypFrTjLCbhXeWBbMVQuGpylqrodxnJGhRs",
		@"CNKcVurbwwFmGupxU": @"VeMEMyMoFzsndxfXjVEEjivDeIecyOLDjdtVlTOAeEzbMJAUdKsFUNOedwyGSIGxfEHkLtyCZFtdWpWGALonRDvOocqfhHmdtQmvEdGORDmVRuzdbjprQroEZwHxawFTarNtIyzIj",
		@"AorOAZUXAudHiAiiyxn": @"EYhyQWphKohaZDJrEOQhhVHdJDfIAHDxgvlbAWJBYAolwoyEzkQzMsErTayCfCzFKXCIlJfyHCjOmqxvnblHNjipgvmkHgHDQShoaSWVYKorXlASuKCqVmPZZQPiyDvamPJqsJRQnCWtUuKbOd",
		@"YGfPYZYXWsl": @"AgirankbjiqxwClJYQPXSPfKQKUEVkmCSLaqkTFAfJtFdTbqfaXDNMVJMeSlbqwRNpVqrBfnxzcIhHBnqWyiYxLjOvziJTPZHDQTomAeLNRRjNMAJkAzXLIvNn",
		@"dbgdJIGsXXIRpHnZmIf": @"CxvbYZqbxWOOeHglOqpPVQgyllHICNVrmkFqeUYZjVMFgCbxdgPqDHwrxQKHmspbXzTPFXtCdhMHKZlSDBeWFEEpbWfMUFmZicLgm",
		@"jhSpGGNTYUJNw": @"ZJOUnAkAAEmkDugeTZrbkOIYPEoHyksNHglJXgWRHUtxaQoYIYOeEqyFSrgUbHZNnfKgCyTFyQcSZqUwUcBmACmgFdAXbigoerpJjHMTOspMncTbKDQvstiaufoffoSyHAXuoXNjQRRwWCGpSX",
		@"yyhiEawWBGnnWuEyFaq": @"JCNmsvbMlDOlErzvLxkaQpIJVjOPGqLeJpjeBipluOzxoEEZLmvctllSNTZOHiWNDglKxiudSonTKJEuKkxtosCEqcZXjBQWIZGsf",
		@"aBayfLKiweJXFlLb": @"RYqEOkkmqPEyYgpvtfWXorpjzjCReCseiNgpNkERuavzQXTeqJeBHMDWwDvzSQSUCgXpFjTVFMpScnGcUFkaVubUIPeVWFiArowprarp",
		@"zFOlmFMdzolwLVoZVDA": @"IYyramlxpetyBhiYcYhKvGDrgYWtsvaaaOaOJHcvKdjkgMrwpBvHeMNrFuWtTHxJxbyfaWzITDnOBhHYuuKlmoVQlQgoHNPikBeAEXPmRlNFqgINchHJrLdKNckNzAyzXZeseKEWqnjzkgHedmLo",
		@"HmgOWNqPpanbzxOr": @"bcqzOjFShmcRfybXGlAlKKJWxThRfwOoJIyDidSSZOsRUBoXyrgzdNZEVRxGEEaUGvmHSzNJiugotTTQLPQaCjDRrfrUmNYOAGxlnESoXReAutQUkwUUSEhVpFqVmhlBuEYvGduCirEvm",
		@"BqgQdgdUgN": @"KyMHyAxvIKKIAQFQroLaaOzBAWrANwMQXtvSRhmaGgAWwGFPvlCsHnkrtIiyvvKFbTxZZVYmbgsUfSJCqcrtHeWysKAoHnbaFLRiSPsWpcntguFNqhjNgLwNqxpJqGMnZZzNLMPtNbhrGPpnh",
		@"FaEcfraXzdsQmAD": @"bOPhxZdCDnhwzLPxkUyFOCBSMSFEKxTPzhlLiqNPfscBVcSEfePaIYAVIprVZSzkQOipwgIIbvOotaUCAWOGBJANGFijuoIfOXqLVPsegVia",
		@"RNikTTsylEKgAXNv": @"bWfdcxRbfcmrJWKosRIEyuxaQlkYVuOtfmtoeLKbuAgqXQcIyfmOjAehebVgDrMMhhxEdTtuRqMxdxDJeasfCYWajwxvlHBwyTXbvixZqnPVqULxzCkSVIKylUxu",
	};
	return QWLASAPWIDuiDJx;
}

- (nonnull UIImage *)SeKUAOinLtZ :(nonnull NSString *)BmJoOCTYjw :(nonnull NSDictionary *)dWqLspOxVbBQMCh {
	NSData *oRTRxENyLKS = [@"bBsIjdbxiGujEyfzRmXiRSawvUYrzGQYKtNcalejnBAmALyZiWvYELsAcivGQKfdAdXQwtTXzpjvnISjodXkQCLHciyMbOfMDhAefqFGTORAgqxHOrQlvqPdGArUqbTjtI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ivREUcfQrpYopHdLk = [UIImage imageWithData:oRTRxENyLKS];
	ivREUcfQrpYopHdLk = [UIImage imageNamed:@"baYQqEKaIBpXUUECeQHaWtdnqTLKOOulLFhdmaIZRCiiDzheioHrpUayaKUlZTaNDcqfIgdHLWScQPJzNrBfqhQGBrmMWhikEICsEGNPHIfmmgUNRNLTLiIJNWzHCQ"];
	return ivREUcfQrpYopHdLk;
}

- (nonnull NSDictionary *)SccbYADVXMxFBcLUGL :(nonnull NSString *)VKtYLSwJILoQP :(nonnull NSDictionary *)lipzQwtqEMqWZf {
	NSDictionary *AQHmEZMxKAvSRtQ = @{
		@"ZNNFvlKmTRUOBxnyXw": @"PwxxUmLQUastDhUFVvZxJJGWqxCyeqDktBajjGmQFNcEKotKFtnivcjwmHMySKyXMixCEVlOEMfrbTguUVzaRfIOmNzRZxTZvZlThavIsxnVwYvXFmCITCyldQAdLU",
		@"NYoFCAQuaGysTXe": @"RssKCKKHrhUTrDZOhVeJmXeIVzGoRbbpcqRNwRhZNyyZnjFtzZtbpuwqeOVusUeMEMJXujOmEmSOTiMPFGKLXdQjNpTukCPLUvROPndM",
		@"gIrczmcRyPVLyRBKe": @"mPKEkbgDsBYXrcBvuALhoWChbFahsnQaUnGuEyfBrswJNxGxaBikYtNMAnvfUklQBtbAiqqYSruesAPQmBBxxOgopQhdeJtmOFXSxZcFaMcCrvpsHdK",
		@"tAYlEnemDTDTWhkIami": @"AYQBRYQLLeAkyOGJeVyTTBLPiEsASwTwvaHtuLIduJDIbBLnjIRzZGClpnoMplvxfHGCSKGEgHQOgzZqaFmIkfSczfKACmNJjKmaaJFPsoGdCLLrhpOamepuFbWCEDeTxMfNKvfWzqt",
		@"FERDRtKzeIgTKRLyAwa": @"yHopsaSELDREblhkQyEyyEEyIZPMwAcTNcCBJFiqvwKPEZzzoEuUFUlFqKbnHwCekAkQOOsSFcnzMiWfRuFPYhSBJVQkBlMbABpPVsGytAuomLZhLoQJR",
		@"GKMwiqYHInNBLrUiH": @"vkgdjRnhoBJmpNBTOYQVdyXaNukNRBSyPIfMwVzhoBRTCQmNUPUjGcCHeZaKOIcfhZFjKJimeHRdnSmsEheDKoQIBCNbUlTHfwDJEScqSIujWSYBSEyssuGtSELBAt",
		@"lDizYfIeMsqcT": @"hEevRYXuhnMCEWScrqQPQUeaBnOfrLGPCVeHNsJsrGFZhqlOqTlRWwKbgsCnMcRZQxEIKUQyBqICgIVnuCNDEPEnSXdueJjnuygZytLtjVjULSenFktLDqwePiHMQzh",
		@"GudXsrweQyCZ": @"XpPbArVDPGfSWPXtKJrUaunztszSiLtyhtRqwcCfOxDdbmTBSWEVZMXmadEBYohJzxWfNGDsXyjXMrIIEmsgdIhBjQNVdhCXEdDaReXytelprUdmJWrpOyMZJwsHZRCXLUqvzU",
		@"aGOCzLYFRBMtymJP": @"LdsANNWNQVFLhkImIKrDgqDJnOKNDdMcTBdczmHEvbdppFcjfPToOMqiAFWmYZOXsfPdncFSesuuXzMtNRdNhtzHpUHbVmUDhjcJNubYwvDHPoLCgJkztNTTZawCtUgmQLckuwFUpXT",
		@"MwFuACCiFAC": @"sauJlIJpSlItTWvaZQnWDdxQPhpdbULMYHQPXLzqysoAuzHWylxNzDIGuNKnSMecoAzwWVHkWkbrPfdaDTCkeriAjONcLWdLsbfwJSfqEkLhzmsoq",
		@"RGnfQrgjNP": @"AJgZvFsxtverbLlsGywzGFAmcVgipqzIjzKxKPQhMbqAmvufghnwXCMDmhxJNuGjFWxxNzULzxRprPEXYcOWFcfVwbDRoPAxkQSeaUsYvfITqSBQNBrKkJGzOGgSOwSgKmWIZv",
		@"FzMyUPpWeXj": @"BIWczLBJAQrTWZvTkGJrwEUaOzhQfVofPjEteSnGAyEBsVOlBzKAcsEXhVrkCdxoEkiJlImdjvXmMZMQazlHIFnLKvPLkCBBQGiSEXiAkQrECMolXaywwaDoOSJZeAdjnNkeCwxYLVMtpiH",
		@"TZFTblomPrTbd": @"PEonqBlgWLXXBRHncYSfTUyFJtiPCqKrlZjTeifIkDswAilmUlaPSGyEVrZMevmKkwTnVrLlZPCFqdnNMRczbRmQLEdJAFzhYyIpSyJdUmFOBNEueEVLOzXfcDwAXxolUPTGR",
		@"LTlDVCWKlIrCmXHtmu": @"QdFylurQHwNCsiXpGphNRnhqXmTUzsfJWFCwlTyVjhtuyDXUSyMgLwmTSkRlzQkzjsalbzLxuKlEzMMBxJqPvVvbVNmUEXoNgMsWmXVhoIGjpAqednN",
		@"LKNdGRENyyBibMfvPhe": @"hIsEfLIXFbSPLxSOALhqwurSulrIXoWbKsoxmoWAKzvHOiUballWAPgXuyamGifrUPlEQohUWUBIBsROIqoERdoVtZlesAwFPfXmSEnvOOKZVZPNTAEbjlyN",
		@"XPOzhMWpOHdYSjm": @"IrBZkcBwZipiKFMobvfhkIZIAQlDOrbAbqBWLUJKTdMVGdlyVLTGEDmUqyblWqqMYZtMdmaVQJfnfPzoCPgmLohbzzypRsanNVuytbktdDJhgBcXBiSnGosQMLOtPsZ",
		@"aGKeOtwgYUAB": @"eWPWNCinOgrRVxYzUxsHLLMEEInbZiDIcLDfzNpbCPOpQFAcrVyefoLdXThxbxHavOJiyvnoyuQKGAeWAYiPOQagFejbHLppdoHxqwrkqcEXHWgSMAYk",
		@"BzpshfRHGLDBs": @"jzCUiLsfwfAggcADYBkaAyOtHltCpmKQYJSsMNmSRHwrrjkOeHbxEGgENtiHqQIHFTpHIdVTPVAeBekyXITVjFAHWHnnpMRWRWiNSMWRUtEXQ",
		@"DBtXowvRbeO": @"rXlebBHugUGJECYbbTLAGlvFUdeIsjnPJqAALBQIFJbBeOGrEIrwXgCwvzNWrFfHAuimLqGTNStxnXkWqCuRDuiPdaSvIyrZDzGEKfBxhaAzSdeBytCcQVAbdHt",
	};
	return AQHmEZMxKAvSRtQ;
}

+ (nonnull NSString *)pgNtRHwXaPLl :(nonnull UIImage *)HRdEhfIlcj :(nonnull NSArray *)YYYAjmXKgtMG {
	NSString *qnGcFPEHDYSKoiGrcQf = @"TpHTUewJdrmgfMrYMbbuKwDlRsBnXVGiucbahnUPHFPkIRQVBlgOibHENsHnWLSXwahCzcgQEUTMvpimleKKmvsPZAzeQxdyHfeqhkaLzEQTGYSYsxreOpZNozwHBboGVAIRKaOScMzrsxtyHjuT";
	return qnGcFPEHDYSKoiGrcQf;
}

+ (nonnull UIImage *)UjGSrJXKlVReIBOU :(nonnull NSData *)iJAGOmyLXwtcfYbG {
	NSData *tNwWRcZUiooWUYbzYx = [@"hJliHNzuvZQQpAlHKsepqvibkFGMvGWDZeugUOeZezIpsvPvUcaXFTffuyndqYdkzXwsZXrxFElmOxMGqdyhEDtwtkIRgYWyKVKkhIqrCYN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qzyDlrDCUVGjlpcYc = [UIImage imageWithData:tNwWRcZUiooWUYbzYx];
	qzyDlrDCUVGjlpcYc = [UIImage imageNamed:@"cUxXIXvDZJthgenErCTIXbCkCyLmEwPbDNiuejYcVaRDZtTsDuWiBeMoPfLKqVdOkNPwozNahgPmZNkedPmLeoBIxvHNWKqfetthlrEgjWaxCPTEnhqfLu"];
	return qzyDlrDCUVGjlpcYc;
}

+ (nonnull NSString *)KbXbGjuocG :(nonnull NSString *)qCPJZtWPWmeI {
	NSString *pbEZKDZotUwn = @"loZHyFndhBPIWAaHHQBvBHUjVWOTBImeDiYgHaZGmYbTGvvAbJQzkbcUsHZhVKzMHvxjkrIXlNIpGnqgXMIyQVTKbAGATzhHjTeTMm";
	return pbEZKDZotUwn;
}

+ (nonnull NSArray *)tsJeVRSxNZsQuJsuix :(nonnull NSDictionary *)erwaQYCzbxr {
	NSArray *XwmWAgnuYDKsoQby = @[
		@"RpHOyRYUDQsShHSqvFxmyEuykfvtvVbGWNoxFrxNPERbdYlXoAAmPotBszDjcXQrPLlTnklfyFdhlSxCCCKmrPkAJsPJlUXJsqZEUDExRkMYSgqDdwOyn",
		@"hizpqJdqbkPutfbLnXBAgqdpZhPHNWQfdSeeOLMkHMFQOAQoynueDCtVNCmBTgCwJGTYgDtJmMcDRfKCZrAsXuDbilVaAsMeIMGfRcLpJimlnTXXFPsSpviG",
		@"saKADdeCRHxdUrhbwTHmsVmiAGlVeKaYfNOqwiUawtrISVCexvNIJctoDAxKFVIlYdpJEpHJJCDJIiUhMKJZDDpYSHESJMLhYpPmwtKugPPJDpOHGTZaYibqyNNbs",
		@"qBPEZsmfPOYMvavGVfgPAhmTwWdbPnMNpTBQXNOOTfWwFmuJeWkWNPRDrKhOyqGnmhtEmgyVZPswMWEQpVgkbdujhmnAPWxofLflnn",
		@"VbTHLQgaIqLbVTHngGUBgvjmArmJxEfkFIDGGARJmwJqePsrxIelBBYIXMfOpQdcUTNrgHSBSjdZYjwSfWQXLuGfRhkELXaFCfYrUMmkDqxmcQIblPmypjuG",
		@"CxHVUbluOKZnHzQTOhmjFuNJcizvHEacKKZvDGHAKgNBOfgKlbDCbgWaVuArCokOzZgmWCcLqsWkshLbOcHYglpQhXvhECXOflMoRgyIoeqZFNfwnOxGgUWNEFg",
		@"AfQkOYBrCZrHterbobDvsgHzFeEDJRctXiEdhDdKlequFxlKULJzSadReuSTlWFHswGudFXuWCsIckaprntEnJBVJjJjjNYyjObmPyaubhIgHwAEkmLxzYvaL",
		@"xUBjGCEFOOVbvkYQJDdmDCczYYXZQAWfllohMpRiwumvqIaBYQEJixTqsnFwWgSCMcIAfSdKLsNyWLufUvXXSnADAMzKMcECVtkxah",
		@"aGOCMknGQvQjnUqSsjdpRquZHytjdEzRgBcSqPBYnOElbzSDZKqFQNEYULPIkUiSoppwhEOudCgeKyVWMBRsriEzZFlsvToMXLCPPkPYp",
		@"LKBRRkZPAOrSdZlopjgTAdIuUTxfmEaEpVlpOCuVXAASCfgWheONfhFHEynWNrYgRlLdgjvDhmPGseVIPEQULEdUGtveXjGVsOiULcENrazAQNzGQRjwLWlqUUZEJyCpNmwMlRZvYr",
	];
	return XwmWAgnuYDKsoQby;
}

- (nonnull NSString *)YCMwMOEnce :(nonnull NSString *)lhOHzmWRhvf :(nonnull NSData *)CTggoAsKXsnyh {
	NSString *NYEGbRTtynTDnjQySZ = @"cfiPNzzFzOUFPaXbXcQFtXDJizGawHVLarSJxdHtlVLYKnkWEewijIZdQXEVxqEkKmCwOKtDYVqUsVErIgdfYQOzVjljVurrBZetCXcvZavAHpklEhk";
	return NYEGbRTtynTDnjQySZ;
}

+ (nonnull NSString *)HghmPmvODGer :(nonnull UIImage *)DGWcCtQCMPbPPXkbQ {
	NSString *CoppUZaBLG = @"vKvHstZatzXfZTbojeUmGCJNGWcmRxxnEwSmNvFchsZYfSiAaktHaYmjJlRVzTdRUIhXvDkxiSvBOijKLqmUPTvhmEyLORARyGKwglvITArMCuSaEqidFJVcxuya";
	return CoppUZaBLG;
}

+ (nonnull UIImage *)kwyRegtHOXEPvK :(nonnull NSString *)JSULXtgSnBkhGD {
	NSData *wKbAhmjigWIgzjY = [@"zVYgtfRTXUZPJhYrJZiaedsXkxOmhDcmwOAPdVdOTfhqDZgDxobMaxovXfvClWyYmrWbrExRHztAfdKaYhZNXeLLTAJrZIbgBKjHaciwjRBcgvryKskkxSVALcsmOkesBFPINFGbnJKUmFugwf" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *UCZUzrjoXhdjZsvNdw = [UIImage imageWithData:wKbAhmjigWIgzjY];
	UCZUzrjoXhdjZsvNdw = [UIImage imageNamed:@"rUPnjuzGgJcAqiDrlQcCNPdDuhBcPKIMyFQuzaGLSwCpAlMToHuaRgLsMiraiXsIdBOMRKmFDNlDlUsFQWgCHiajJReYOdBXohdQRLaDLRNZaqJfOXwvQWjebrDENUbiaTZnuhtNzKuuSS"];
	return UCZUzrjoXhdjZsvNdw;
}

+ (nonnull NSString *)PuGYjgMeXHZ :(nonnull NSData *)eVHERAOXlQvncl :(nonnull NSData *)oUgBxFDzmbkLiR {
	NSString *vMkBcpaLQEloQylb = @"tfoxpdiSsOVPRPIvLuBoxwpJcZAHGWpEsGOrCIJUxErRyIYtDkhTjMuDjNHjnUEnwmrPaYiNxwwFotmkpqdVKAOFdEhXhdwkBZnUtRtjK";
	return vMkBcpaLQEloQylb;
}

- (nonnull UIImage *)bgmoDTuNDF :(nonnull NSDictionary *)wnQlYGSAmSBXqbUgm :(nonnull NSString *)QirVCZgpMg :(nonnull NSString *)rSZuzBzcOQmM {
	NSData *nBTAldfsdQg = [@"DsSxHeyEHJvROpNSrztOJtMsGRSshIIswEDKDbkEvAlaYdPTMJuVUsCcIQKmcSTdFRPlcGzJTEUsvsIwdIjRcJwDrrAUMpYYGSQL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *yNgFXWoHYIRX = [UIImage imageWithData:nBTAldfsdQg];
	yNgFXWoHYIRX = [UIImage imageNamed:@"DwsaFqoXyrCSfQiULkRHZcoffaWyOhwByeyYCqFtClxMCErjZrXVGtdGqyGmfgCTxpzMmgEYGOvgJUABZwMPZEhVmslRYTEvrVxhAS"];
	return yNgFXWoHYIRX;
}

+ (nonnull NSData *)hDRERhHEyHueEpTdLd :(nonnull NSString *)rUmqhOEZkoDDdcVVz {
	NSData *eedqiSaSaGDDLorkb = [@"GWCwZNkrrtUNiNqsPccvsBfIJhPIbcKwbNzzTumWqvqNvMoCBNTbsAEeBhxXurdSnIKLqUbieAxrWoDEuEUSwoCpsxCJchyrkRFLuIkjP" dataUsingEncoding:NSUTF8StringEncoding];
	return eedqiSaSaGDDLorkb;
}

- (nonnull NSString *)VnkKmfEMJY :(nonnull NSData *)ITInmtHioaMkocdZUn :(nonnull NSDictionary *)umKKRjXsKdxkcohyrXu {
	NSString *yUOFkWkpPo = @"YCfhLqAIaiLeMwliNQIkPCLUFnMmudJeUDadbbsmFrnVRuJLpswyjRQAKukglzxWYjeWrxbVPcXTgJrLEihICxliRlYhpRLSNttfrSVNkdbUogGEFIIB";
	return yUOFkWkpPo;
}

+ (nonnull NSString *)gqIKaXEGkBeCBOVi :(nonnull NSDictionary *)gGPziCbEbtqmxgWeu {
	NSString *KYTMQGstSYGaghp = @"XVWtubfLcIspUrRKJRlVllKHPUznXGfFVqSpAPpcTekVvShTPkLayObPyoayKEkUlYBtAPtklYnMMSWSqzmwNgNaSEWTZuIwmiHHLacqIyhFqmPnqZwicHnfOHqFReUqvIhXLEwVuFyPu";
	return KYTMQGstSYGaghp;
}

+ (nonnull NSArray *)zxkUgcotHUQVCAAAl :(nonnull UIImage *)YJaJqxvTKPC :(nonnull NSString *)fLtihzBNOzDmyjte {
	NSArray *UuRLijbSgXwtbm = @[
		@"TlavDDlodnCQjaBCZkMEdogdgdeWWTslhJrZMSOmiLYyhgnsMtgjqAYZRMdwDQeSFZSxVmUgcbHihOEkRfUYJFVjHIOnvxaPeGtRAwmTZpykbqPBOljIuDremBMWdpkSyt",
		@"gMRAUwcdvZRpPgfIFUcTsMsghjqwqqwUGTWAkmXtzeldBdpMoQOiIqiphrknRDIjlAngLQbeiKqYaWauDekESITTGvOdTuRoHqYHVqdxImoVjCfU",
		@"rrhfFfPLAaCbRQDgNaxekBjkESCpkWfHyLXFCzHgfmymMCNZPJEIrRsjRERNHMRCSIfaRPmqUROHnBaLhrEheGyNtmirBpBQoaXxFTusQmSVpSndiW",
		@"cPXbybPmunhZibRSEULtYlpRfArMCphfQmEqjKrGjkWLJyYFSpZHGpnmEXSVjzqUMHHhtjPehCMxjojyWjArlTqqtXFCgVPZbOZKudalZZkCIvvCOqAuHLJvNpzftmvjItNCXkOxXgs",
		@"hwqZpDijkZEAnBbNhscZatfkwVAEqDgPMctDwuXvNboHYOtmoMNOFYIsWvfwRKkCzAlVrIvKuTBMJpQRvJbacrGmDaOvGLPPHvZBqcpOgnaB",
		@"vwoEnHwoQvIDGdIJtZBYxhxYqgsFhfwspDDPWjOHZmBweYWYCooipAhAKhtEqPyswmdSMYhVOGcDwHsQDfbWXYlivwoMIoYbcgfiLuSqVTBrEG",
		@"oqIIJbsyDveOZMhjeeRcaWonRIfMBFNPTUusvHzXdMjjzeFkHMRidjjkECFtRyAYgXyoHpzLEEsOMLCFUTTzmvmKYVwdPHKNVZprZSJIwbBAZBLgOKETzSEIWUgdb",
		@"DigEZJVEmrpFuQEJsgCKQLdDhhOxIPxiFHPkdRdjNNTgJKaBaGcqhIRWWBtpJGhvqPrrqYnfkRqXPnUEhPaIZenaqXWvGCcPSqkBQuSKUJwIurhwUEDnSgub",
		@"RVulVYRTaunyntMZkuugfXbWZVltQttIlboiisZJCptywPujxehCIzSFqpyEkvXcZzxcngUXzrjYHnMuASWuQQuHZCexiDRhKlgy",
		@"dTikPpfMZqjFIzOlzJDlCSEeTqqegwOSpOuMQIAtSXOwwYngTdOEeGjpOsFxWWBnbxKADrDDQtpoYNNALgYvkTOgZoZZsUphZtxsUPDxRRiaDGSvPtymMCrFdqTPtbWoZeL",
		@"OnaUvOvCeRhMnUjqsGSeVHgZFgGBtdSNiTNCXrwDVHbAXfzybmPhHoDQGLhUcTkSQnxnvZHGOxkGmzAjFwKHRzzczwGoDUVbEuSnoaZOcIQXBzmKWLubzTL",
		@"OCBLQsZuMLqJFTLnQPdLFHEvDcAlVrWVEYoTmjXBqwTamWbeFvnqKJNagezvUHulJtmUOxabazErfkNXlzolJZtWEoVChBoTWhpSsQnr",
		@"hbkDggtuVblnsVIPBScfbPCOmVChgJCutCfsPjjCtvffyXMlhCAVSUbSlwPbVOgzizCnCIERYivsrReJhPStWnLNBfzfrckxHemPWzjRUeomdDqOeCgoiUVpgayWerie",
		@"AAyYPOUPFSQXmAWXxfJBKaVHJItZVArPOrXFIvkPfPrPoaxTqcCjouizUhiZlQAlMdDjzQbUcanJMbjCKwJxOqkqHxQgmUveeHqAYipEIThCWJXzBrfObkIgkFUmXGcgbANQo",
		@"RlfYNfhkLNjVuFzkRHjNhnOIlaLzGrmvwcTtVqsZArcfsKsWBLmDiAlGwsATTnvsnecrTmhSrslyhMqhxDsmqdNJaDGNjNClrnGPDkmPKfAKXu",
		@"ZPlVKHJKnQdTeyzIrgIIjgTCfuUcZYcasIaOPljtESrMRAyeoAMpKqJocQJYrWKTaZzTCoeTNCwDBUZFSnOeIFjnWtUZGwZLApvQdJsBGyQVrMgVBvpHhzbrnTzQiztr",
		@"ZLuRNtjjiMVueetjYjOMEjwksWNbOXDYcivrBVTBGmSGUZVzKyuwWNrmaisOYPLxuUwiHaCORMqquHcRiIGyjyZweXqJrvucwNQfGOPFXZMPoaUAD",
		@"MceGgsnoDUHUsOZufVFthgwBmMNwrFcnRubzyPPaNLyMRkkolRwUzhJEoHJphjIyITShIqIkJVaUroXyGKaHvvmimzMgszSnHJjoTGSfyNBLEEnztisAhOnuPd",
	];
	return UuRLijbSgXwtbm;
}

- (nonnull NSString *)wdhXkeItOwYyXNdhx :(nonnull NSData *)uGsjAdjLvDeDfLM :(nonnull NSData *)nstITxMHkVbaBKoJQka :(nonnull UIImage *)xNjGMfSvfQT {
	NSString *dMVvRCLKJYDK = @"lZndsAiowDlugytQORpqjFCjUTHteRUcwVbYCtRvZUckynAXMfKBckIMnrvGHQpdVVPNwLxQsJDHoRZSupoYpfBRexpdUXqkAMruQvxk";
	return dMVvRCLKJYDK;
}

+ (nonnull NSArray *)VYKJWZLWeOtGZrsSj :(nonnull NSDictionary *)CLVgkMKAJa :(nonnull NSString *)cHNMwEaVCGs :(nonnull NSDictionary *)qCElGLxDZCiNNAux {
	NSArray *mJfOQjtbaDa = @[
		@"jWDHwRMOiTEAhdJPbCpmZudcawFMyiPyHyUfSmusHLQVIttbmkzkTPcLJTijObtaIAFScrbsqFKoCQHWqTxINahFGtkNyuhQmXzUphsPKk",
		@"kqCOTRjfcQcwRcIphHzLbWhybQEfWkbyMSWenoVCHhfAlLdzyVDYvGJIoFDMTkvoKEJBMuNzMXvCiPxZViZsiySzdnSKAidzqVNqXIkBRmTBbtUntxgjNxbJEVAkvUUekORUnDpIZcZpXREsHxAjI",
		@"KvGZngAUxXhLaUVGsHlnHjVYNHEhVzbRTTrvAMrHfYetJOnIKxLxynxXRVAkHVIVbNqttiXTNQtBknHTLScNvxmHPiGcBYJzCVUlAnCazEiBKwnIpROm",
		@"NwUwTVKvkluNTZUoNAJSQkCpJnKPlwDYsKmzWGrsnqrpGjglhFLWcGweGEkobvkuycboWaHBvAaJimXJZeyjbglYqfBQOZKNiMkQfgElAvUvXTzockwqvOKDieyotergNYiiuwZpBNclt",
		@"ZkCEXEpzhTzxNPMKZUFgGJvwWBBhYVkUgdbiQGReCRsRMaxmHPnjidEAAfcYPBoLlsrOwtztDynHidYSHUNsNzMpGtxTvkuvrRwAJJYztTHTXxsemGoViuaVVeNgGaJNmooT",
		@"ekiFfIqCAIjTeSzGwYDlIjVuncnlqtIRElAccZTSUBTUwkbUgRtovlEsJiyNKMlcFyMVaaFhaVyCzVeilBWRLlFRuvQThBQPwyvChyKNWKmbSGsEPUdpxIxzWxEA",
		@"jbZeEqXvdrpYcpUilYaNoEKfthJBHXilokMYyFSFQVOKdaqhgOAkcNKpcCnmVkJoJhFfJqLPPMrPmxQtJRKlbOHRhcOGYKiJwDLsCDLlMFBKPUcYRdhIjlZAtqzLjUURhIwZpYKcVMvFF",
		@"PZqKpxnzvlhEVQlxgQBgJLOdeubfUPAwNgvyOdKoJHRkiwquwqYLjvCXQIUBPsoPYwyGacVEMnMDuNtEZxVygoZRkydSezOazyFdVDsJQZAmaMFDOqqxeDZE",
		@"WdjHFwNzKqJwAwvLLeRexidETQrrHVKsAgpDagKSdOoMBuuUEpLUANaGynJWfarAfBJMczCvobcLqmBiDlVpSTgtkxpbnunonDKFKSoAkyeMOUVeOvOqCHvTCxOzrQsWqnxPVxdHJoVHcLIDJxD",
		@"ImbeXnZRCwXOqmEbVBZDDDWhHWouAZvZwaEHhYVogPiYbckVdDurOnQkUhkHknjCKHpanUJSEpRgFkIMDWtvfrIrSseKhLhEBMhoubntXJT",
		@"VAEVYybXfMMoqpzNnmYMccTnexqSBQleeBZXgIBCtZkpYHyfOAUItJDFZanoYgeidEWpJmtuHSajYlEYEoImtiwLlgCVXuSWjcfhGvaclxsJDgVehAHFmx",
		@"nelpmhYjDRHbjhkZpDiMDhCyxtwSlylQlNJJZQoXFUBBHmdBOJbbFiiAARCetyUWEBzXCVawAMGxbfDTaGWIEaeofBLhKCxdxELVtuXjuKBlaHnbyaVR",
		@"moyqTxWJaXwtpPgdswFNCWrTuHqTzGNqzowHEvUNCXAmRaIFJnUWnTUeMaXHbMYGIPExxFOTRNfRnLaTGZHjyAoGrozyxOVMBEBPWsKcoxDWBJWQ",
		@"LjQpVrTqWGKzzkSwaUwmbFZrowUTYHZWWPSLRpqkNiKAhankKSQRkGlcerTOMdfUIRdWxszHDylIMiIGBQEkpMqVkAEArOOrnkuYYGHXBduSNmyZQUPAWkJtLyHGfjoGTPqb",
		@"EUDBHJrMScZPvoSHezQXjWOAopVjleXOwUltzJUbuforEfxqdDalVfeBOXUEVOCyzxSIhFJreFpMjttrfyIzjWEWTtVqOzFBksEeltUkAtxxSTPmqKFxEtYcLCQXluDOPj",
		@"hGIEFoPoJAzsGiCjskrRUBaJkzmVEdVOJxwkMxAkYavfzTYbWwnKFTnMABYNWTcwwEMCqbddwGFhgBQISJkIMyQyjrYPtcrtwehq",
		@"uQqLeBwsMIAnbvlZhAkOnCphSRHReCcAQeKqSMnRJcslWrdVQVrRrWMRlAsEFeWABCAuekcPkVJFNshDTEMnOQUfCdcLNpwyjlmYfu",
		@"qCCFsduDqVSzgbSHQCmrBFrEsYgciZrmtDtBKcxmiDFvhEZxtkUbxJSmiUAgYASsRKKnwOyawTrCZCWSUCkAVwDUyPVNYbMVCualxnjgDTzwLLPKcBFbTFWnGhIEDBYhzJffe",
		@"wNVvXxlkWRDJBmGCoQDcSGOeFTAfmdrMyzKHRoNUFIvvEdbzrFcoHCFkbvlJXFdBqPYCmfCKgxctUUzDWlytMtMDFOFVyMYDnMJsqFVYDRtFgmCnbbLPmwrRrETNeKxzbHGDel",
	];
	return mJfOQjtbaDa;
}

+ (nonnull NSString *)ScFlkReyjVKk :(nonnull NSString *)kwVuODUFUraEzbZZQDt :(nonnull UIImage *)zLdLTiGJfUlpUsbp {
	NSString *eVnLzQVCeGbeNXsAoDd = @"TiYtCGNxanSIrLiWqUntCOWRGHYIHRgSsUYQuRWScjbGkEvZUaQBlqIwXaJoNFKatgTSCAdxnorjVtVHjOwMxJuArOlghVJOVcCiRhVUGsGDkstjiULDSwUECUgRQYOsIuatmMCwbJxDitSCQSyIj";
	return eVnLzQVCeGbeNXsAoDd;
}

- (nonnull NSString *)ZPPfzNJiNrpGZFYB :(nonnull NSDictionary *)lPepcMOjYfUt {
	NSString *hBaAoqDnhEZCJnH = @"DmjXhpXVAhZFxUtjOAnUynxCUaJxeAKRXQEVbszdrRhWzSakRIhJLjKNiaDHXoqbEYakUBzHzqsXyhfFspnqWQXIRlDUvbVgfWolrzdFESUkcNGyRtFFnxFgHCydDRlSdzFygV";
	return hBaAoqDnhEZCJnH;
}

+ (nonnull NSDictionary *)NpNSgEXGXZ :(nonnull NSData *)BePXmQhiBxDyBrQYrH {
	NSDictionary *fZJuiBcZGmYmkTmX = @{
		@"PZpUKwEDrAIRWR": @"OXQgTEzCAQYCqVrztxfoDqdniqHyhAuYbZCUzUrIuurxptWrCtnOsNSjsQDNNNMxqGUrWGcnDPXaNefvgNGuYVaEibVaCMtRmOboNWEpcotqbZLrOFojpfBPGDPgbIwNsLuAIviOX",
		@"wMDZCZhuxTej": @"HnsRDJIycLJWcDMyAeenbYgOQpaMycTSYEJVjCnhQiSZarkacXNTFQsZGNTkVjHJjLKpnsRQEPdOMMLmaBhVePVeSsvWmWfLQqaHGTTTtQarTrYFcOGyGhawk",
		@"XNhIpAwecIEFMPDRuzQ": @"sMYkHpmjJabZksIWxAoEULDqhQKKnOkGbxUgZjfBXySvNcxVkeAbwDdnSyZRZArsnsTYVWHVJMEWzXYSpxvGpvRBvHitwaJihwqoIGVYSMUmWZRNdrVwPZZpSYqgSzmKTVixxVaLSqdcps",
		@"lqhfAuLTbkRWVeFY": @"nOBlVrIjApHVdobsIJVZOQUFGuNoAVYdyGWaXeJqrvuzWoUzWiooKpavTuvmMlGoGeYOpMTwDSxwbAoQANEzxuVvZzOmTzQrcinqCrXNMrvZVbNQVQmmQf",
		@"trMrbLYjqPrhzv": @"FxfjwRxKnuSKJukTBYsjlTAarKMcSQXoaUrVFzVpopjVCjzMjCDRwrFotKvWPWKbatFnWIiOxEZqqYBbMBivaHLWWOMRzusdWKrHaqAJJqaNzldaqabaNgiSow",
		@"lMXKjsDsVcqOA": @"SssJMqvZmDgljKasrHqPkFQYLNvpckaobnXmdtQOIjxuaFnwJdHYCuLogrrewVqJSThMSHoognjQbxcETpRfhpOYyrMCUaxNpfchpYxJbYdWnerADHalfETsMGyJZzlxJP",
		@"tFaSaDvMaUsfMHI": @"dnXBTgvkGvqxHOwxDhVcsCGCDRMvAIhlsUeVzPePqWXkWqcYsNSSyqHtbQgmgsjNKqAbhDsmeYivodZDgbvZkdADjsmTAQoVggkXbhgnrrFlYmODsFCNKXhedFQLzq",
		@"mEfzdWvmDkOPW": @"exTFgPfPWgxnNHFOUpFkDTXDNZxJKshocVyduKMpyIsagdmAfcvBqqcxXBTVPOiRYybhsjlCcGzFqeZatdlwhGmhGPPbhBqZakszYcdFEZoRPypYJLowiX",
		@"JXnYAPWKMaZLPR": @"dBkNZKhheaAWZHaHPggLXFFXsWeNsZgqCyHByciCaPpjJavYKyXcNkrVxfehPCpshhWCGkEEfxSpaGCEebsAriuZfbyYLqAFjzOEEljNsUz",
		@"GquNIMzyhPX": @"ueLIkCEvAXWVwRijHPYhoCikibkPlxthJswIpuJTSahZAskFWQWgSucPFsfwvGiWdupnXkOviuUqdGvTNlANfPsSTnSjGlAxhpInrkIe",
		@"tjAtkTxRZctqdicFpI": @"rUhmCucKPaneeAfplmvYvLwZXxYrGKnEpcVYIevAMnlaPJsXItrxfcmjifzhFWzZKEDetWJCSAJPfgVIMUrTkjuboITRvCJYpMGIbJiDkRWrZfDXiaNVPRwUlFarqllhG",
		@"UvIzbjaJlKN": @"jmCzHkBWKKrlRWwXIZBTgTHopCFhZqqQxeqMDVMqbewkjjHOgpsPyYOFCUdgKSSuznKBynAvRtSkQSsSowrjZRxQGIFpvyEdJCccjkcYpjNXWlVEHBZzdJXi",
	};
	return fZJuiBcZGmYmkTmX;
}

- (nonnull NSArray *)OoIWUvZaTVBDQNqEhSd :(nonnull NSString *)RxozrDScBuSjgA {
	NSArray *NLrbWYCdAfuekPYZHj = @[
		@"EeHBtdkWtGuQzHQibUFKTAvAZemCWrayoTHtklRiKkqpZSzdmDyRDpHbMeAciRbgjDuBgztSRLqDKAHQLrlQoElopNpFJuxwQmsSgjFixnpzEDJzLmwg",
		@"JNwxDeZXDKUyTooorATNEdLrPdIlFJsSJQRVNhHgIgMQKMwXjROEBrgUnEcxMbMzqCjnPqDcxbUdPAmYQMGozmqKLEskwofIfEDNaLyCAfUWOzR",
		@"SYNFTLdCWTUybBicTDSKgTOECYfhnlpCbpfwxbLxBDSxCMWvtxxvcsMLMcVUXWqtKgCLrDXNHvnuGiWaQObLjYOWDtbiOgwGZTdXKxMXpHTEmwyRDDhfgfd",
		@"gTHVIaZXlckRriaWcbBgcMhZNHHWYvowSOuPvBCxyCSAMmURGhlPXcFBuMiTgKtwjdYWvMjzGotRzwwbFdIxipIyfLPIWCWOTQVWKHUksUjXVwnGCdggLmCAXaNZYFEGOKxAAKLXeQKJuT",
		@"nClUbzQbLsqxOjMwMjYvedggLIXUGVagFnDwbKsUCOPSJcYHHYqJHQfYQebahpdBAQOoYqzoIEnjivOcYwYimkRfXGckSlUMtEEFKHUTbrhbNwbJeWyI",
		@"VHdlngadBmksvFcXpJmoRoUKluVjkWfzhMesNoeQFNqAAHImBFVCeygFsGbglqrmZEhzKhTdtjNojTeZelvjpxCXnTrxnQDyJMSuuQxmpHPipGSudmmTaKwNEVnxcZwquSWUJCIr",
		@"XLtAAhZLsYtTXRYaYvUHKpBDXjXqVzuFgjHhTXmMsnttHssxeJsIKHOTYHsuUxKdpdirVlhoqzMhFMFYAUDFJAwcMgdmQyKumoJDNeXKsqbrchNcRixlGLkxZmRShgMcluWWNhyzlXy",
		@"oAQOoEmszIUvevVibNRhBJkUBePJGABjpStDOpGvttXyFoXlHpeLacWnRRASJngThaywDOKIXRrYADgcruykBCkrEMTMaCcZeUIIqzGFVzkAxkcIALYdtA",
		@"JoAXMfUcvdMzqSsntDSIZsXOQPrCzwTliOZMbOczNsVafaBBcpJgwuTKMrivcNlVTHNmgkMQBStVbAzFNQETYmdOkClSQALvvIjdNiDXKoRiGDgaFdWJgKgQYCUitAryLBzWPbVdgfrHLNIWWfde",
		@"iegwspeViLDVbVmPWeelNjJdRjxnNNJhfESndxoLJbyERwFykQROxBwTbmPSsoEgUkzqawUEtHOcccizGQfvqXPoxJfUjemKffeQLHEbe",
		@"qXXPcAmBUrvvNIKTHeQxWZRSCVtFhykhoWWYnNYWZjDgXiBTZpYZWxcCFnkuebzPQpeChvCanSGVKKbqwaechjGmxFIMMMBxeUqyNhCazmvZcDwXpDLCCegNCbITyWcQQUGOySKh",
		@"bGjiNsxJlcFqdrKfqASyeyKHiZSjVXUDnqixIJIGJirRACemCcekrgtfxlYYyFBqfNnGHbAfxEugZeVtfhmyStzgqeTDWawnJaXcmNwNtMxfSweSTFuCUUloIVejvGTgJSjPJECBvhclfAt",
		@"WlRUHfTXnvzxAjIQiMVWnhmvByyOreLjlhHPzsFpwTXZZxCoOSguCaJDrCnUGHdsVEBGFFWepAEJSBCcdWWlzjaobHKaQJEwPbGAWHayEWxFPLOfissyzWRsmWUnkv",
	];
	return NLrbWYCdAfuekPYZHj;
}

- (void) sendCode
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,SendMobileCode,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic = @{@"mobile":self.registPhoneNumber.text};
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        
        [MBProgressHUD showText:responseDic[@"msg"] inview:self.view];
        
    } fail:^(NSError *error) {
        
    }];
}

- (void) send
{
    if (self.registPhoneNumber.text.length == 0) {
        return;
    }
    
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ChangeKeyValue,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic=@{
                        @"businessid":[UserInfoTool getUserInfo].ID,
                        @"businesscode":@"10000",
                        @"key":@"mobile",
                        @"value":self.registPhoneNumber.text,
                        @"authcode" : self.translate.text
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:dic success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             [MBProgressHUD showSuccess:@"修改成功"];
             
             if ([self.delegate respondsToSelector:@selector(changeMobile:)]) {
                 [self.delegate changeMobile:self.registPhoneNumber.text];
             }
             
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];
             });
         }
         
     }fail:^(NSError *error) {
         
     }];
}

@end
