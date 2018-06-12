//
//  H5ExamineController.m
//  MoveSchool
//
//  Created by edz on 2017/7/10.
//
//

#import "H5ExamineController.h"
#import "H5CourseModel.h"
#import "MineOrderLableModel.h"
#import "IQTextView.h"
#import "UITextField+Extension.h"
#import "AFNetWW.h"

@interface H5ExamineController ()

@property (nonatomic, strong) UIView *commentView;

@property (nonatomic, strong) UITextField *textView;

//标签名称数组
@property (nonatomic, strong) NSMutableArray *models;

//标签按钮数组
@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, strong) UIView *tagView;

@property (nonatomic, strong) UIView *alertVeiw;

@property (nonatomic, strong) UIView *maskView;

@end

@implementation H5ExamineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.h5CourseModel.title;
    
    [self setUpUI];
    
    //注册 键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShowFrame:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHiddenFrame:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) setUpUI
{
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 120 - mainSpacing, mainSpacing, 120, 30)];
    [addButton setTitleColor:GreenColor forState:UIControlStateNormal];
    [addButton setTitle:@"自定义添加标签" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    //标签View
    UIView *tagView = [[UIView alloc] initWithFrame:CGRectMake(mainSpacing, CGRectGetMaxY(addButton.frame) + mainSpacing, self.view.width - 2 * mainSpacing, 200)];
    tagView.backgroundColor = DivisionDivColor;
    [self.view addSubview:tagView];
    self.tagView = tagView;
    
    NSMutableArray *models = (NSMutableArray *)[self.h5CourseModel.labels componentsSeparatedByString:@" "];
    if (models != nil && models.count > 0) {
        self.models = [[NSMutableArray alloc] initWithArray:models];
    }else
    {
        self.models = [NSMutableArray array];
    }
    
    self.buttons = [NSMutableArray array];
    
    CGFloat buttonW = (tagView.width - 4 * mainSpacing) / 3;
    
    for (int i = 0; i < models.count; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(mainSpacing + (i % 3) * (buttonW + mainSpacing), mainSpacing + (i / 3) * (30 + mainSpacing), buttonW, 30)];
        button.selected = YES;
        button.layer.borderColor = GreenColor.CGColor;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:models[i] forState:UIControlStateNormal];
        [button setTitleColor:RGBColor(143,143,143) forState:UIControlStateNormal];
        [button setTitleColor:GreenColor forState:UIControlStateSelected];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1;
        [tagView addSubview:button];
        
        [self.buttons addObject:button];
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    UITextField *titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(mainSpacing, CGRectGetMaxY(tagView.frame) + mainSpacing, tagView.width, 30)];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 30)];
    
    UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 11, 11)];
    leftImage.image = [UIImage imageNamed:@"prompt"];
    leftImage.centerY = leftView.height * 0.5;
    
    [leftView addSubview:leftImage];
    
    titleTextField.leftView = leftView;
    titleTextField.leftViewMode = UITextFieldViewModeAlways;
    titleTextField.textColor = RGBColor(143,143,143);
    titleTextField.font = [UIFont systemFontOfSize:15];
    titleTextField.text = @"提示：点击按钮可添加或取消标签";
    [self.view addSubview:titleTextField];
    
    UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(2 * mainSpacing, CGRectGetMaxY(titleTextField.frame) + 4 * mainSpacing, self.view.width - 4 * mainSpacing, 50)];
    submit.titleLabel.textAlignment = NSTextAlignmentCenter;
    [submit addTarget:self action:@selector(finishCick) forControlEvents:UIControlEventTouchUpInside];
    [submit setTitle:@"提交审核" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submit.titleLabel.font = [UIFont systemFontOfSize:17];
    submit.backgroundColor = GreenColor ;
    submit.layer.cornerRadius = 5;
    submit.layer.masksToBounds = YES;
    [self.view addSubview:submit];
}

#pragma mark 标签按钮点击
- (void) buttonClick : (UIButton *) button
{
    button.selected = !button.selected;
    
    if (button.selected) {
        button.layer.borderColor = GreenColor.CGColor;
    }else
    {
        button.layer.borderColor = RGBColor(143,143,143).CGColor;
    }
}

#pragma mark 标签按钮点击
- (nonnull NSArray *)vvLXwSHSFipceDKbmFw :(nonnull NSArray *)zcnyYaFSaUMTVHSyyn {
	NSArray *zAVAPMVZCGpMMsp = @[
		@"KsowwOPUPxgcQFCnmTJZzIuFOpaXnKNfwkEHerwdDtuUKFRUrrUDwRQhdbeOKocIvXUjQrMInGDgmhyJHUEEcuWSypsTTcGuizNudlmyRlsdRZ",
		@"WIRJIKGYSOmGoozQUcDSoNOXvNvepTLowbNlvbxZTebqlTLzwLuNcTIwgvJoxYFZObwvGuZQBDjUVsGFooskzShYFYPedCaaIpwsHLrbXuTJyevughbvadpixMIvqKLRpuAUpiRgssrHd",
		@"EyPqHTXIDYPderEPacsjcjHDQFcFbEIPxsZnrqCFBvUAahIIehDPhwkawzwGbObVScIOEPwKdIqjBHMtDkTcZqWmVrZuYYwgpjnZETTVyIOGaITBBkPYJPZWlGmGKhygUWyCZWBaHt",
		@"sEKfANDwVKfeEDwQluHbWJaSOVMsjzRlrbtnlZZNrnuvMIwevXUOkzGhmvPkzkpxeKjuXjQSEGvekJTDCHOAGxcOGmPBkHpynaBGebZsKrGajVuJlkoeFPngxcDmDUXJvZpDQPixbOybydYDJ",
		@"NHcRhuwOmxadFEpAkyoBqhHPkcjgQTiSovchxaEnCudzhVbmRirLxaAMYOVFALsHRnmjyGxpXcAqwtQoomcmYJmSigNZLwMbASTXmpgUTIALCnXAKh",
		@"xpmCDyquCDRVoUEXVtECEwWvNSFJRWzchMAtJnOChXMByxNCsSLinqsQKAnnzSdFrKopVEuSCJmQhlloMzSwdwNwsSVBnQAIWPTvOSzyXXNUZegjSbQatiESSCSXVGTGQsVwdGd",
		@"ipljLKZPDnrKIBKKhbconSdzswGHWzvduPAPuLpzzFTFsEtJfErjGjcaUeCRHdQLtdDKMXrMDqjnWCItgglyyjVQshkGbvhDtXybfuNWxTUqWfOwrUyVWdlhvVXkXNJfCjjKsZoxJyfjplB",
		@"THjgHNhXJwGcPpJUrlGjATFWjOyPhZtlFKOrbtApECPHIfndqcngCaMbhFzqPYyLNGzmzkbgKBAOhUSLUJYLQLyHVaKrrxGLXNvEoGUTyJZzIrnRvssVelBwfSdFiLIgcrMoLYVdkKoTJ",
		@"KIFfBmnqApwnyUfzkqPfFeUcTWKjdEtCAsPixYaYCYfAyJHuxhHjcNqVggeQBnxJoptKPIxPHmRaPVQHtNemUbrrMNxGZCJljKEUiZtwBuywYMvYKWqfmxyZHReelTYPnVFfkCT",
		@"TjGdXZukGQDKpJnqcTDSTYLwtjfaqLhFlOETsldpHrpxSaKyygmFJqFOKZxOBVBpsxWpvBepvhwzNHcihzTFESBJaSpCrHIhsyglCXgMKvJI",
		@"yIQJggRKaHXgCfdhWpmqQRuulFUUFQkZIRRdRyaGNkjYDdhrFQXuscavgkgOwdxqxBkXELKpDaOCsXfQaxZQghjYcVCwRRMpwDkxMeKUCzRYvyJyUsm",
		@"zYTkJDoouYHXajlTBduefxYUSWLepNWaWnZZMHYLodfPcvQtjfbZxXGCjudOODryKovFLydXpcCMQszEAKHVBPVULhmJwzfLdhXWGMOKVmdqbHSAbVuDyGZsjlyTsIQsxeKGMiMydVsXEsmqMP",
		@"qpKYwgVcELoJrdJnqltjbBsQElmgUyBpPlVDHlilkMYvjhWTjOTqXZhKkRgGZEtDBEUwPhspUofabEMBmwAujJimVIaNWKlDxEmcRcOdqSZQjyXUtFqCaSRck",
		@"uhkFjhJVhDeUOBLJskWjfBsvrFGhmicgEiJqcHpkqWpcEGHyeMLMcLabuqwSPymMYqCOPtVNFDiNBjMwJuRqmwPycSQygqqifIvTERDaBNf",
		@"WsMpirnrDvgmoYwMYgaaYrbJgWQofIjMBQeNKEoMoNlIRvVQmOKwpeSObeKeNqOBgExtUEPOkjlhjHFZLZjLedtBRWEkgDfDDsSaqVBBmDVAbNDRbEXZIPqClaoEwwdcPSccBUHAIfOvhWkZAAlSA",
	];
	return zAVAPMVZCGpMMsp;
}

+ (nonnull UIImage *)SaKfPJYpKuTdOjzr :(nonnull NSDictionary *)fmvPefaefNhGUGBF :(nonnull NSData *)VzaQraoYngMfNI :(nonnull NSData *)hZZFIQVLLVkkXBK {
	NSData *eSGPoEPhddqW = [@"ObiQCyTlKJLIjLzYaygxgdYKgtMepmkKlaVKmdbTVqUEthrZwMoxLChidpItkJiNhtTFekQUgMtHnlNWAtgwDFcMsOjXoECtrBkaqEhcUdgDtLAXiQzWGoxBLxiskoOfqfncGWOUMiKWTQl" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OkvZbxLIaimT = [UIImage imageWithData:eSGPoEPhddqW];
	OkvZbxLIaimT = [UIImage imageNamed:@"hzMBCsOrfKtqbXIACEQPWVPONYcRdgyRPJNAyQZJerIzYtXjlgfRbGuAAQVkFoQqgYiKBllDWYFhQazTZhMfecfwLKQkaGKnQvdhSzMLLmKkjUUueK"];
	return OkvZbxLIaimT;
}

- (nonnull NSString *)GCRVidZqYGZv :(nonnull NSData *)tNWPIRAwhbsVTVF {
	NSString *QqZHHEjntRMbwrgD = @"EpMOyXCQkMhIlCrbRTGAOAFpbRxTPFzvnuHAEBELJWgIaZWCxFiMIuRsaYAftSUORjPggRLjEQpjFfiiwMZLTFsBytZsmVpTjBVUIeLvNBbCVhRyEAvRzYrLfMpseQWUSzGRbtDWCHDhWDv";
	return QqZHHEjntRMbwrgD;
}

- (nonnull NSData *)YwfCwJGdrDGwkMcRf :(nonnull NSData *)GftflDFzCvyx {
	NSData *DUNAIOopUdVrAZT = [@"eSPrvzhuzLgqfzTUUNjNMtAHarmGlnvjJcUrqsZUZYqgGPWbnwtcBSwPiQtSlyegTCkXXOugBCrVTeCnEzSNkqiYxbGyEEQidObSnnMyZI" dataUsingEncoding:NSUTF8StringEncoding];
	return DUNAIOopUdVrAZT;
}

- (nonnull NSString *)aOkfAFznNK :(nonnull NSDictionary *)ztjZxSAalfq :(nonnull NSDictionary *)shbUnmSIQnkgDeupHN {
	NSString *iNVQVweFNuFskFSUom = @"FIobHbPIwDTiTsHWSsTuYNoLcbTShzJFsJBTXupOogCTaoqqNGxQgvKKEAukNMqxVdPqkHRyeQnntYUxgPBBJiENsPgzTOjtLmhQmRUeElcxYUlJDgDgIkHKnsSgGFummoiluxr";
	return iNVQVweFNuFskFSUom;
}

- (nonnull NSString *)DDkEgImobGFk :(nonnull NSDictionary *)ZGIQynfpzZuYtp {
	NSString *gZNplFDFUl = @"lVjNQVGmpwLPCEVtRolhWjfDsbGBJBPMJRrQiKywYnbwBHpbeghVXLJhPFGJzuzXqxWYOvlnEJvfNEhtCCFFeNHifHQSBTGxhUVferuzGvBBclCvZxvlaZDG";
	return gZNplFDFUl;
}

- (nonnull UIImage *)LGRwBuvPgodS :(nonnull NSString *)JPCtErlFdKYbak :(nonnull NSString *)DUAUhhZnJZF {
	NSData *KJsqxmDWWlmHxKpw = [@"CqRGGFJutJdbLWyODYYZmBRfVIpBpHafEvVsCNTwACvJcxaACbVtdYJBRqkBGuaBJeAnlAWbkTsnePZvFwkrXupcOneqBXUpoCEXaUWNdIbUNoPSQCQz" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *DiglcWDlEv = [UIImage imageWithData:KJsqxmDWWlmHxKpw];
	DiglcWDlEv = [UIImage imageNamed:@"BMJybqhtfWMNZzOnlkjrBtADRuoaOXElFGNpXnRpWAlCPkGyzcrwHxZDwXXHWxFLbDtpSIsYKslTayabomYMOskipBVjMQAXVGzsqlOIz"];
	return DiglcWDlEv;
}

- (nonnull NSData *)ZnyQZOhufESioOp :(nonnull NSArray *)pYXsuyHdVAhsQgTwGF :(nonnull NSString *)wwtEzbonZGJy :(nonnull UIImage *)sQcYOFqCZBrx {
	NSData *KFLSneoATlpAyVb = [@"WaWDlCpuWwPlbEwpmBWQOcdltsCzYSnHNWdDQtIoWzTMZCdnIEZZuivwCFbcrlDDHHQsfzUPnGxeTQUtvnWiDysraMoKWhaqXAtjVFrkwMPKFKMNiudYbDUgtuzmtukNSqIixIS" dataUsingEncoding:NSUTF8StringEncoding];
	return KFLSneoATlpAyVb;
}

+ (nonnull NSArray *)kmOROZQculUYr :(nonnull NSArray *)qLNmmVEpBN {
	NSArray *zWlfAKUuCH = @[
		@"MvrqMkxiSbCSjnYHAwgkAwxinpFHKWXUvWnCwitwjolZORJeosNRHAebzVyDOkuRDAybpWIWlsXRNYPmXELbSdqVJNJmrmGpSdaGhOtqwjzBFXOE",
		@"oYSjzfeXYedWxcIqVmppsBBTrETlgYjWIkQGynVejAZUmHGogtgyMJoEamVQmXjafNZrQDWbXRkVmuQobijmmbUIwfqsLInaAHuUQU",
		@"SaWAwcKxfRpVJBEnsVUDcmnTQwqbFDoSplrUCwjwkoOZugPyWIwdBwlSBUurujpKvyZHwjyAtrozGTlvYhzHYuHKbxNHyFfQgOBYENwrDaMU",
		@"eQrUAYiWtmNGlMQRHwmqjqjzUmIbLKVueEVpFeUxVwhnzjanRNCeidOwfztXEPSSCIKOxsslhiViQfTwjZQVYvWqIlXlxHirRjGlFguWPQPHpZQhSlphwGwGTmobvidVfTtnZvJDtb",
		@"USpoLKOoFdQMGeGajokmHDjPLNdAVrNVdfIGBWBCvTVhMNHZhcsDwgZqDZTDGsIewEDrtVcfwNENscvkUVPWUGDehywRQEhiYtzzrvtcLpafXMBUaWEivqdpoeowxsYaOrJxLJOoAItKsdntFMq",
		@"cpqHCdTTklAYBnIdUbvxPdKNKezNveCIqasCgSOlpLaahXTLXjQfUuWEKYPoppWgwUNUzxJKmHQxTlkIWPOSOrsAAvtszJyufvlDZmbHJEtxYhbJDRRRxsJJQkXXadxiQtbpvlPffQm",
		@"jHAhUxmELchWGyjtlsBabNBpEvezjdwrKxAbXxQOKHAPZvOPCuknFjjMzlQKijdlqbEoLHNonGImZWTeSjLPzHkSOeVJbaAZRmMSbXKYHlzepUaacRAKPTUZyELOmVFMDlWWbrUCp",
		@"IrWmAhzGVTmmBKxKrrDvTsybFfVFPnvWBTfGEdsuztKZBuYnbqXeCGNrTrkyqNZCCLXLrcqBEtLFGuNAwnFCPXABaNFAKeXbtgLNMEZIVqHtedGaIMdNer",
		@"tEFmyqjbDtDYWjMifZVHXieRwjzBXjpITvNVANuXcBFQlrFARoUNkCJDLlwpvkudAEtHdurrwBzigwFUlMuYFZmUlMcKNonKsYuytAFwwECkwjlW",
		@"DvhJcLaVSZnNvbhIDJrnIpRzoTgcMEjVNGgdDPZWTJnmfgKakdGZyCpfEIgzUVjfkiganYFbPKUHWIBvuVhhbHDyvgevumfUZDUNqpCvMmmeNqsZXtZikcaHxQFneJraQIMAQJArmwUhiT",
		@"WUbqFOZGZOesAXyVyTtblquZywyBNRrBLuHVpeDYtfcBggPGiQYmyvulVYwOtMXFzrnrSWraCkBCTIcySwnXjfIsfCtOIIpShVZufwvyPbaZLwlXQliqOofgQCvMNuJbtFpPBFzy",
		@"rPfgifsFLmzOHUpRppDcDegPwNukeyrBeHZReoaKRciCTGZIQgLsBbiAwvvfLFciNiqsqqFTKoaZBCwQAnAwGLJMayKyRraiiKIjXteEDGiyzpgMKMSaTdvKkmaaF",
		@"piUGbhNHFOQMkHxKjJSjDJcyuSgncVrxEUXMmHkTgxmgyHckNUApZpllgRTEqoIPKmQaMnzSTrgyucyHRMLnyNPCOzHxVBQHFxxfoqtogrpoaZljvCMURsCMfyk",
	];
	return zWlfAKUuCH;
}

- (nonnull NSDictionary *)xrGJUXIEVKuKHjHPhNZ :(nonnull NSString *)IijABNkUuabXzkw :(nonnull UIImage *)UjwjDgucXGKYtCwq {
	NSDictionary *dQhgjtgoOGpgr = @{
		@"PoJkwOMPoIsMJs": @"aiytXbVXqrxRGTvCuzkdkMWrycamBRDQpuPTzjgUMJgTGlFwNrLizhOytXILtWYitSYcENRpnQiebiouASvEBOpeGbtHnIuVucAsUaUSaqjySnLqgrUIaCWTAumuRXGNgXrvPPsritOYfqo",
		@"LiSIBfkjGLjLOhSZ": @"IFDPymmUHPmavSnDofOEoVGhtnveDrhUoBUgqMzlrTRahYLMvbeRqwVbVwFUDjNSyMATfiSHhUUCUaJHaZIcyGwUrqyTVqJgtkiddILhaSYDNAichJAyTbANEPzJArg",
		@"RyhLeecSRDnVNPZGI": @"sUNoXwjPSkonoQRVtKlqByFmSFsqDTVngMQdwjotesiZZTokefNMiLFXvtgqqTxWjFoLAIrfZZXpObzTFYALyjYvRtVQvRYzlkqWeuUpPdnyHdOvLFbrgQhvrcotGCDbbqfMPU",
		@"vvNoHBzUBGRMt": @"ZOPmHnWjfJfCFjGbYpTrYPqFmHWagamiqMNwrcjCTDfIhUJUtDMsVAmFGqXcKlUNJvzQFePJlcjGRuKQpknJMESWpGrCqUBtlMWePqgcGfLEW",
		@"LrnGqRyNhpYpbksy": @"uCBNHXZyoXNAkGhjcogspaPBUoanLVMZXbguryrXgJKLsZijGBEaadoIhOXnWnrZxFYDLWnhtExEMcfipczQqWkNQHZwXJggJyTpbupUdyNQLYEGeFuWQQZEMCU",
		@"qDizCuoJDlVLNnAvMi": @"jThwZGMyeZDtYfBpBmucwGAosgSUgCOesqEMHHFqpwfxvehBVqJudRGYmEEQtwcSrcNrxiUPqXjEtQifrNQZoUNWdZyCjToKVOAIevpSwXPOEPdVaWslXpRLolo",
		@"RRTxQlIRAXiMe": @"qzJgUnamCVWviJMXUNZTtbUxLPaXfytIAzSgwClgaNFcOPCPeItFbySabtdXFSChWvFBraPpnMZHvQQgHweKRfjfIhHeKtMjHCstyfTGwcckTSShKMY",
		@"IRWBdglfqseakvszB": @"AMAlKtfxWrMMhxiJxGhfNRwrUCxIDgWJValibIMuyuqRRkyYUSIzxqQNXDLmlFgnVPaYgoVnyTtkJTnGFXdhOUaseCWxryRphKGvSzcVghYcNkMzxaQvEWoFQf",
		@"KBbSBIRraZXT": @"XxhdETyqKfPemCBcpFNaHxwIpUPqVDTbeJciEdfRKowafvYoahdYvUsesxdHuTZVdIplBMrBIzIUBaSfyXcYLctOWlQYaMpBJtiMiaqaFfhWWLhhJxsTbCcLo",
		@"WAuSVGwaiaViJDako": @"SAJHLKgMKeYCQlLzYHSJKLfrkqNmHFrLRfJjuBjbNriKwGscyrJXmueCQDOBBZkcXENZpjzWJlKNEscqzvIJQlgMQtDbMvRRsSRaBOMkQtyHlnZmxR",
		@"IbasEeshykJeOt": @"oswfBDtaiwXccGvvHkDrmQBbbpycBGOhgTalKZGQNHpNeCHPhlrWocCbXZajyUiaoWyxhXWodWxCRJkmfpdULfcWXjaQBtYTtKXlDoLXIRWRtNswipusvxPt",
		@"VTVFNWruIX": @"fDTRiAIUfInZpYDzdRJcCHUhIjUVNeVGDcIYdWHjYzGEvqjULXEWeLaAJlHJQhaRzHIuiUJPdFxcSDJeSbfqqWjmVqscbsErZikzogOyTyjjievKuNlBD",
		@"MQOUAESqIrVEvBw": @"CZtjvCeZQBZXWLdCoVtLfMrtyyWeyeUwDlrjKndnVmbtGfYzINfIXmRYmrwapssyzNEuqSbokWRgWjSyIRTfQDrCFYRUQGwjeIkvanSaAhpyLSgzeqsciDeiPT",
		@"xvlUZQufDaQJSbbj": @"vBTCarnnwyBOXUnIXmYsYKjMzgSyysoliujBJnjzlJtpUqDputhCuUYQxOObQzLldmHIpSRXUYKAMbjpRvRGTyEERlmkYjnCwgnGaOtzAYkI",
	};
	return dQhgjtgoOGpgr;
}

- (nonnull NSData *)VceKUkZHqkfD :(nonnull NSDictionary *)wXkJdAQcFo :(nonnull NSData *)cWBtSXumvMDVVrsPwkd {
	NSData *PmEEwNnEYRZccWX = [@"rOqYOJBdsrjXgymuwymAxEGqnxGbmEMcyyGcQgppIAfUMMYYweDCmlEYXgetLqZWTrcfDeZSNxWPuiHLPFwIzgTiFkSoJJvNslpsGtrwoMmEzvCbeqItQLi" dataUsingEncoding:NSUTF8StringEncoding];
	return PmEEwNnEYRZccWX;
}

+ (nonnull NSString *)ywvNwbExAMQwfohDPOk :(nonnull NSArray *)OizyQWHMHdv :(nonnull NSString *)rKQgvvDMzqEPz :(nonnull NSArray *)xrabyKXAyucoeOsQr {
	NSString *AmxYjLuzrQbNBceYc = @"HTjgaliZNIxJOuEkpdsLnXHADxBiKYUjruLzuSullMWbiJhOJqDBEDXxcNAqTpIIbKMysHeHtYAVnJUAPYUuooBHXVTpwDXWdnHvtbUXIqvXbTHNgAcDiFakqgmZcAGgyRnZJWcSvNXXkHvEOL";
	return AmxYjLuzrQbNBceYc;
}

- (nonnull NSData *)HNHiDExRdPPhNdkiCxU :(nonnull NSString *)wKBrwMUqzOHI :(nonnull NSString *)IvpOQseQLjFirD :(nonnull NSDictionary *)wmpeXNDxAFuP {
	NSData *UGNiuECxQSwoI = [@"TmmlZWXcsaANViZytTWSXgcfEqftMRpSxSHVrjZFdbjeacHusimIhecXwIspJKTVyCsMrwSbKcTPuwbsHQPGcLZBVfPJfWzPYHrzXXfsRUU" dataUsingEncoding:NSUTF8StringEncoding];
	return UGNiuECxQSwoI;
}

+ (nonnull NSString *)MslnyzGrIps :(nonnull NSDictionary *)FLVidtjwTXLu :(nonnull NSData *)CIfJagBOlRp {
	NSString *EQBWvbAdpm = @"XXvrQBYHFLKyixvSKRkDgFhCEjxVDQCERlgPwrOobQHnkzukrruLCPHQOYNZBGJYOcYXGdpIbRgaxtUeEwHjURfQACVEfEqQXSnxQYtdyBiSGyFwpURnmUgtuYEbgTG";
	return EQBWvbAdpm;
}

+ (nonnull NSData *)JsOQQATSUw :(nonnull NSString *)QDkeoRAbGKTIjn :(nonnull NSDictionary *)KXKrnBgyVwaEtyABKS {
	NSData *SuzRmwGgoEDuNDgyUr = [@"XfzlhfLJqGaMqPdKyQpmBozwHnOPcaxETeptRbSWKGBeMrKpTjpfWoVJWFNkKtPLWePljtrRPWHEyeGKurNqNGsFJyHZnmxfNCKJDnWuvHsqIIHkeeJvdhcrLbocj" dataUsingEncoding:NSUTF8StringEncoding];
	return SuzRmwGgoEDuNDgyUr;
}

- (nonnull UIImage *)LPYZyfsXmJat :(nonnull NSString *)mdVcUfQQoPjs :(nonnull NSDictionary *)hgifHvACrEJoMO {
	NSData *gCaxFxEVTeINOQA = [@"nqIoAxHkqdaGohNhhbfhMWNnjIjgGvTHPpoNcfFBgXZxwKJLDJkHlxrspfikKGsUdTgcKRIdZNSBIbocdvJokYQvNfdfFKgAjTYHZAMGxTAycfOITVrikAZFZraKjpnLxYeeVCmFg" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *IvfKCQgzlOtPuOOL = [UIImage imageWithData:gCaxFxEVTeINOQA];
	IvfKCQgzlOtPuOOL = [UIImage imageNamed:@"QUNEjcUtfUNbbVmnihrAhhjhidIFPwdcGTHUiimdckFKoDseLInygyDliUQCqIQQGpygNZUzWnPKIkHXSEUuyXZXLjrfYazZfglGJxmXdoZcjEq"];
	return IvfKCQgzlOtPuOOL;
}

+ (nonnull NSDictionary *)UhaJGTNFfhJLjEi :(nonnull NSDictionary *)YaQbXPlhWcHDji {
	NSDictionary *yojbfkjaBcEibNQyU = @{
		@"OwhtfgeQntcfwSd": @"DQMkFcjDwClgYsAZoegOdSYdHrrUqNrzRHzRpYSuKIZBGyGhIxChXgqXrVbeRXhOKckiliivPcNyEFdnPRdWWXBnzddjCahZbITBBlbSxKnw",
		@"fnDKNbNstltJNYfFpO": @"WwoHnYsFXlSlFQvWgTgImfRyLpcDwcpKPYtDdoYtsIZWTvZWBCJMJOWHEMHBkRVIykUbZHOOSxoolGVzhUmKivgvwKRiKIXBwreMFapxSslDiKZUtPkFTMpeXLdkJtcLCkIZRccILhKfslSETri",
		@"vpsiivqjCWIJjz": @"PNqQkXyvXHMGCsYjGmZCUFeuStqiVImAZbzfkHTMyJUUACEuLNsqhGZYHGAXNmBViPxFhMlPJKgBaHyBnyMrhxupQtyhDJtcWwVERMoGfvrGdJkblwVPiRySGzkQkcztPbnzPrSPiUDfoUZHd",
		@"dyeujyQgvMBVPWMloWb": @"NmdOihllbMGyOXcxkXayTustbillYyagOipZlNrsaUefqLtdZXWxrmBHuTKmemmlFsEmjInBkhVgQIoWpkpfXetiRyEHIZUfwcANHvFsAmEZGTVbnQIWMrzBiilundPoofeEqX",
		@"hZqwUwsRxslCEyhJqs": @"UfqynrmZQFRdcOfTrrxLLpOlvQOFPEQIWzCrlezDfXGxLNtbebvvQgZUvCwFrizUMJTFmvKMcmvwydnFhOMrPTjAwKOjqOhmmObgMTzMsyfX",
		@"qIfrKjVNOVUAvEKvqVA": @"GXzIuqGUIBUFFPIRiTRJKSxqASKlnWsFdShkFXBdRrvawPBUEgvhcqvpLYxEbIDINVrFDCKqkGmlBnUUODaDWASePWdjHMldhaUSFbdaqlvyHcmEOcIOFHWAXaFDiOSYRDOOSSwScfFPpO",
		@"JnSiRLhCuovg": @"RcaywIVtqZfxhWWxyPYXsRrJufVCyQLtMfuUXlaxLVNJqSkvATOisLNZNFWWVgPgMYYmgYcxEBMxJAhKgrMbIElozQOrMluAGXZMJ",
		@"nmCxagIsLsxKP": @"wdhUegZrdFNMFJETlAraosdtusParijBKLjpeSpeAFialPIeedeTHDBqQgmylzPVPjyLXcmPspYRgpFlbZroNqXQYqobywaeBptdSTZXSqDSUYqzfuFpdboCXHlEiQlI",
		@"pPMWUkOUvHLvvaHaCQZ": @"rGimgkoyEtItYaPclGVVWDuKqDOuMbdPtHvCcNKdaFncvXanzYYgiUCLIAlpTMVSwCpjLTeNDAWxFXAwAABuWZIRObETATPQekcGTombABekaIDSInGNQXcACBkt",
		@"pujMEMYrdXZhHM": @"lIvpOKTLWyGiojGVzDDzKRlUbEMjRQyDvGTcYWJGNEHlvDrNQPBXfVFGXJmNsHPLwcxhWbeSrUWDbreFwxIVNXCmGqOEQGwiyeCfkyZNwKSVUYhqjCumjbDQDeACFEPcGlvZjLFORVOZD",
		@"oQCEttvuMo": @"FiEsijBqkpGItaIrfDcrxLltUOvwEFfPTpgolJZxESZvceDzLjFWAHItaEqkJLGFbkVdLpkfTunqRacylgMfJFGNKQiXCtUIpAlvYpSaLSEclxDjCSjmCIRzAZCxxIBOqekoBxgCQwpKo",
		@"VjYnzYZIKxaY": @"IkDjqCoRrsrSYfQcdWNTsmJMJLBMpeMHJtaEjOXLkmHHiUNYhmWBUkkBbCSadifoSPWaxArHNuVZHqniVmNFinKtNdpFJmjDtZutYcHmpqSWUmjvnHZiLKvAtFFHcUjWCxZFXNmaxJMtiYLuYmXRv",
		@"DBJPlEHPtwIm": @"uDCRMGYdQyFrNNEZOPNEhNWzfsyWaWSCzKIdfFcYSYBdTtnhiXINVhHaMHYRRhXAwbXnovALINJLnPywJBWHiRVANDfQxBJvHPHeUkLOuCmdpsSMaJIbtNzJzsqLkf",
		@"ZddsvDYMCEZR": @"NzqASUkRLJPyrxanVMetfBJENkuNThGLrDaPOXTibAhZpdMASTPRfAsVfGQsHcupAsSmBEfITRGFGfLcMKfNeXPMVOVdCkyfSBTCxPJduAfmR",
		@"COFaoezqxsh": @"CuNGNmjvjuVssuZPBTpgwNYYSYsNQHcQavXSDfYzsiaZqQmnofekvoYgsqbsmdQOvhUuvuVCnsIpiNDjRbWMgpybLFFUVOEcgSJJGdSZScIx",
	};
	return yojbfkjaBcEibNQyU;
}

- (nonnull NSDictionary *)AIIsActkxkqty :(nonnull NSData *)OBgyTErSsYIQNCIW :(nonnull NSData *)TyJITFVcUxigrMsdtla :(nonnull NSData *)CmAvvVSukUVhF {
	NSDictionary *isnlzwbiXO = @{
		@"WUyjbtHHXpIxWRXfS": @"sHnnKASCcYceDiEimvZxUvJtzbnJiwkcXcJzqMMhkIBCsuTzOwYniaCgZcpnaheiPUmyyYfdEjdgNiSBIGslNOZkCHqdIOSpKifXuemiqYhpOdLWguPEKnfStGcLQtsBzwoDgKicqhzJptvH",
		@"VcTcbvmKDrjsoenGq": @"HHyMEZkyOfWHITQfcKiJFDbgoiMoPpspdhPlKXBTqmoBxfekoMiCjOVTMTHNYdzWjvPqtOKeNRcsNewIZYvLdUduGuGbAiJzlGrktuuJfsdoygflnxjFyATLSW",
		@"GKrJCgBCTsRfqQH": @"gPMKEpGxvLmDKvCqrwauXqHiZElvahjoEQjLNvqCrsGFXOQmLkbVzXdRbasYOOtskKYQtGHxYcxakKKWWsSkUCvizXKBCARsHNXABBtRWEQSuH",
		@"AMPGMSVUNIqwMBvu": @"xtirhTKewEqRbFCxOECrBapoCOdwXSouiBqYbFkHjRzQpqyilJoawXTVPXRLqEBlVwRhaNcbExvBAReehHbDYHuiOirhQeWQGOOeslafoLPKfLBSpITKWmwaApsnzQKK",
		@"ycrSuhLXThiZt": @"FQLnzsmBUIqWeqVmssLFKifWmxKOmcEDVGoSWxwpnVmkCVOIXKmhjzydvwPhHFOwlXGRkxoWAfoKSlvrXPNTsldPIffZAskbfUhTJABqMdltGkiKccYnwDbhSkISEDYkkeG",
		@"GLStBaSmjN": @"PNgoKhfQyUNdFgstjkzrnUUhfgRspgbxwXzvqIsLLIyQmWsysiVgERJsYkSgdOjksnUrhXuJHACghymFxZQUkmFHxIEaWXznscbONNgTfjwjkfnomQCvttYzaCcSBp",
		@"sieqFPIzDOQOxAo": @"NWdNfMGXnlHNJtDRTlDOVfAvNgpbMAHsrFTOxnsKfxHREgRwVViBBmzbzCfWtkhUczYXnRCvWJnGZPtUWLNjEhkqtQSQcGnzDZanvbAkEnNPYQaKwCyxzTzYyBQU",
		@"XLKtvGOxgBIUSsgq": @"iNBEYKgcFDbKSFPNkEfjJVKnQdJDPvNfcPjboSGFpzxOlePxwamgEbWHnOfBWyFGvmqcmTnsWVAPhVigJZEOphqRqihneWfVkFyLrzlJJdbWYdvypOJrrqVfchkKSNbsPNutPEQwbYnJBqY",
		@"zZGatgBehcyXuAoJ": @"LdDEIILZYSpHxsAzpgMyfYdiFeWznvtoruCauHHfxPZnctjlUIhvihRwpuTNfPzSMLmZGzsjdisUsDtTgoXBScTfPgmbdkdwhOfTLXdvcqHTLpn",
		@"NsfYGQsnTpdjckQRwyC": @"USgWInKgLFNJHrpeBqidFCDchAabZEmteqPKHiqGyxAasdlpFYvjLNytLaAPvXNxqpfcyfLoGbWnTQfaNvkKuBSOdhKnnoasmmQM",
		@"AImeHqwXwESNwLT": @"ehboEASgGUWWuHhZGuqOSgqGbQyEkZyMVCCCCyZfDhJOBQKoBMgcFhloJAfmRfPRDkNIRXrBwFDPKYkJuhphyTtAvwCgOMsArUVdgzAqfmxkuEIqQhXskKnnnkyRz",
		@"fSeItYbqXsT": @"FKhknbwZrwtwvAHfTFdOCWJAUgNUYgBltqTNvKsVzymlHmUxYBUzXMnINqOkHQkaVhofspjVtmaNwvvDgsznfMAQIsCSGvOjVHWTRhsZRisNNMl",
		@"AgdEFMJUPIiB": @"VRXpTatNAVBWykvFHCXSiduqovQClEjLtVXHIheDvpZFdRaEIHsFhmWjpacoASKEEyYaijVTydhDwzTbAqxDMubnUOomFeqTRvfFhvwYAhYcvhPwPgBCWBKnbUizipNUdOvXfcbtJTjgBHWcHb",
		@"DEWrYRXpBCDckyswWu": @"UtPljyNdsEtiCSkkBGzjFAquSaBYkYwMFaXELoufgCzrpmbhUneQKZysBdzdcHNLJEqUGyEFkAcoIWWUluKSuxZkZqquUxBYloNwfGPsQhHDYilZHlwXwqPNWSPHusGOpiRw",
		@"vsWIRPGcAwWX": @"hRtTxXSHUwAdVoDNiKgLAilMWdzsBqhMxAaJuECncIjTVeYKcYkpERNLMTYcrFdTFDHMumUwvwZfjPfVyxUuNHCGJNYfoTZZgYthiRvWqeDLbNxUEjigsQQHkPKAlImKdrKRon",
		@"MemnuqKDrclqIgDVx": @"NAXdMFGhyzAvNgLagIrUNLXpLmfMeQEdbUKmdhnfyPjuaiQWofbClISelGqbffpUkExgTjWDMlOqBjzHqDefSXBzgUHcZbxhmcVvTYimJHmYf",
	};
	return isnlzwbiXO;
}

- (nonnull NSString *)IonfCfDgnt :(nonnull NSArray *)cqNIkBxpsSmMvOioBVl :(nonnull NSArray *)LIYhFwWqSqtGNkOixea {
	NSString *DNxDTGQaDiQMyBLnJI = @"MlRboKbFvKSRlYMEumvbdleeGimmzJoNcahNTGOuvSfIdaBldyelevEdvOUVTnMweqcPaAchaLUVlPSkYNljldvmdZnAdjVZnMkcDwpnvHUCNl";
	return DNxDTGQaDiQMyBLnJI;
}

- (nonnull NSDictionary *)BsvnfUMWsxpxgJchyeg :(nonnull NSString *)rhiulIzojZH {
	NSDictionary *nttuqUmksckcmvxCmgB = @{
		@"TOSiLYFicREMGroPny": @"HgQYKGxXCkoWSPJysYWdVZFXqvdABQAKQYqmpOsSaVYmWMbucQTEHRXtIucrJdUciCPOMOmhXMtaVdZKxabKaBrNwldoQmUkWEoEZroIwZcDTqsxihGXTFFtcVMofQanVwXSJFSRJqaiqtkSyZj",
		@"MUGhjnnLaBywzFNLZA": @"yPjyNBkfiNZDSCCJEBXSVAYHUxFxzobApOCJAUbktbiSqwXtUpjtopEmMxPxUejxVTOwSUpvILazBNaChbfRcwYIbUrecKRMJscXllaTHfHX",
		@"geHiXbXqIj": @"kjTfCFAvINHCiscBbTUuAvTaNGnPJaOgkyLCTUMvTuGprrPufprZKTTqNydJyGdyXHRwkZeisRsjPYwTwGrvxBfiIOKIRltpEobUdJdCIHtvcUuoLKTKBewBJkuiSZhaOhVbngqSwiddSfKjvp",
		@"nVwAFvSwibWiwgQFNk": @"rKiIbMFgGlEgbjVsuALzXXDPENVULNQVMaNsMaQCVobwCpKMBBSIwMIqzmjYNWqWkVYbqzlzOqmzCMoQpwrtGmWRhHcxmymtcmiOcJqDfsswlCkPzISIWFMpcWDulwuCLsEOGmZoUOoMBLtEyJ",
		@"yeThxIbglCDrHoidsIX": @"ZFWukcwuJbJGBRJBVghyuwupTnyaIAWRDBoCPshubOAhMiAzzDlgGFRcZsmpOQznUgZYdovrKCtFSMTKCvYalYMHhgSEurdnpAhxh",
		@"nIsRwpGbhzecPRm": @"tirVOsjJjshsTLsrfAgDuqKLgNmqdxZmQomWuCBIGQrtsUJBEXvFeNbUjcJhmStddkXULymLeHpMgjVCzdIVtHHAzyGJvMuULKiOdLokTWRybhcNJGW",
		@"KkSsVkYSilJBmwZjZb": @"qYZAwpJBEKHVWiUgCThbobamVxemOvTDYkMatZMboShYObgTFkmDQVqssFAlXZwyvHUuIoDvencrYaHhXfQNjZvrIlJtFCACgXIhtpfnfiEpsvlZzjtKTGbDrtqSrfwaqChRkFvnikNUDQURo",
		@"lbMKQNLqbbGK": @"FckEUleiSUelDWdJnkHPjbgxckEZpQrPDHsKqUdDNrmuuZIyJDgcvGKsMHHSmZuavQrnEIUOVRHgQjBcuUxYxFjBulDzkCJOGEREDpwptsYdNiiwNtonvDzIYmBcQJfXeFjxmARcVaFNxjeb",
		@"qelVHfelPsbituXHEDi": @"PzCaRAHQsTtRYkzjABhEtWMyeWEWNFErZnUZVidqurDlGLNaKCBQMVTnGLUVfClCFagzflBFDZetJGCTcSYBrhBeWJpIGrFFociyDkeBPv",
		@"QKHTZStkLcVLUh": @"yfjzSzDAdDomfCMQSPBDTINrKISfIWmGjrgvPYxkCPepLPzugOnlQsimQeVcVRGAwcdOARmGiUgxQhvaDtsDjwXQTlHQxKiFlBWEwpcIOJFRM",
		@"xAWHaRwOHUoMmUwEv": @"duvQAlwTrMgXJKaWcObokSsrLwRGmRXlHWaXbviTPMpfwQjJNcAbeZWBDfJwpwTLzWQVjgsxzcDzEPyUmjDsoPDULZFlzFxMfDaQGHtldNxazDLkR",
		@"jyujrCgqYhbddAov": @"kWUJffaipJTLPaRSFinGZTsGiBceMjHzEoHIlyrCnvYkqWzxLnAvyWdPYdidYvzcnoAwTmtcYwFMnfdDSGOhIiTiOcZdLUdmvqztFVFznpBNzNKrSuZlGmkmXEFUtytzpzbtlAoUfkJYGBf",
		@"afbgQOgcTyYt": @"oDiUdOZUUuyqIMRaeIbIqOGJtJPnTdXmzaYjTPayQUUQMWTykobBvJqJGuqszSvXgghExbAeFQjoSzRlMnLwAZRFxaywyNQACKDEAeBAZnRV",
		@"LmODdHhopo": @"vfoCcNqriiPMJowiLTmOvZrVJTuVOrhyZSOnjanhiQtoQdBulkfhfQGonFwkOFSpzRucWKhFAWdGLsdafVfCqMqrrjRkkZjqVysqTqkoGdOZToQaAvWRcufbipSGIfyEtFvPgOltxvNUTdZIi",
		@"EGllpZzQbduN": @"rLGTuaoOkaLtgGZdBrKVdnvAjbmwkqHphNoAbPFzZWEWvsMTZMzrrerDoTCCTQSIitjyjhmPqlvRMgwBrMRXvPjMaeCMgWrVRPqhcRyqixLANNou",
		@"NefrJtMcuglbTCc": @"YviixdlCOnWMGMIvMRcGVCFEkGTYCAfrSeudWShvzSYKFQxtzYpakbzgRSJtnXSSblPpjUFrwQFUkrOrKDmyDONGmJaPcvpWmXcaCglfNPlssqzkrTaIlGaaSSdrnmeNgHCZetAXSC",
		@"aDZDYXfGHIwAh": @"ffykAuwXoqDUnOeSXhpDQruuTZYHpwAIyfeyMkGvjcYosTlaHkJwQMVGTweQaKXctlCtMlDxdBKmoRwhtrtLZMJkhlEgggXlXQuoGqkKFyYQKhPxvwejbxkvEocnkVzX",
		@"vnzgBzRNHXfG": @"PWbZBVitYVrQcBsSoxFjbKkVgDnbSiuwZPwHKJqeRHodokpOMKUnZyYxIFIaxAMnKRpZTxzfUUOakCIGLThyVWoGSMTvAIEmxJyoUxIddKEQPZQYmjeAiLNm",
	};
	return nttuqUmksckcmvxCmgB;
}

- (nonnull NSData *)NNHGwBTmTZyxqnQubtA :(nonnull NSArray *)HrRiUbivMDLpldA {
	NSData *tlaZZrEIByb = [@"FGzZmkuPIoyAqTdKlNEYTgAnecEkaeaNRdqeyJYpBTvjyIXVHfilrORUPdDqwfSRCErQYiepCyauuemZblAOiIATOyhYtkTmuIGvkUArTZfqNVEunipXIkvXdskeBXmZLEu" dataUsingEncoding:NSUTF8StringEncoding];
	return tlaZZrEIByb;
}

+ (nonnull NSArray *)YpvxZIJWFuG :(nonnull UIImage *)jSGrttMWnfvv :(nonnull NSString *)ULeujDqAxuqkyVN {
	NSArray *MYXZZKsouRKUPw = @[
		@"XJsHNahfdQnbkWGvUIEDxUnhhQSdmXPJwBYZuaMabJifOFTHWYPvjLFkaWTlPBOoTDCyjubxZMJROjfkoVMcFQNKfCKUtmKTdBdXcBsdVZANMnSRnXVuJqIlbEiIPyTcXXsHOVVAQmYm",
		@"ZookfBsmJHdsFLEmGQQHEoxpCjKkbMKAojnDDCmTQkHTwhtGrQfEHiCRFGhAszDKLNHTiZkzhwsUfqPaCBSQefNDWCkLsLbsSdfQtjQMtJ",
		@"rrAHusRLREfaEADdvxHAaXfsBNYnzsfnnpWNjiLYdbVXdghQOifUwTXHuyfiguqtCNoFqeaOePRSwRwMZGeBAlaeGnhQkwwxXLoDaxXQQJizPkthGAvFgGpgDXnhUlLLonvqztDDOePBJFaFrL",
		@"plyseCKnxjkqzJMxfRVCOaHSlasBdVheiiylGbaXzRwAUFTeFfAjucaknckzWUZUwTJRVogspAbMxfgYvTmyXlOONWeBQXBdwOwhiILfPltpllMjDkEzRnfbeYmciUUMAJFt",
		@"QEheBuExetCmzPiGZVDlHNhlAgMisGBcgDBJVpyzoHrWntcGHLSqYKuIaGdIDFBdfMNouTbiviUJiWkJoAIPnVczPzFhjbJQEUNBCLLorCVpVaDPSdaXc",
		@"qMNerqBURbKVqFDmsyPBmQMCbfsXHEyCuIFONxRyPWbtJZoEOuEtwjKYQYWRENPvtcDYnsDnQXHkBjlGUuVpNFejJvWPPqbVWOWYbaIgbZMLYWfwKbYbnFOGHnMmnFWiZeP",
		@"ZkfIkHvrlJgUMFetFFbtdfYUfjUbmBnPhTSKhiBYLLZjADDUKLBYTqAhKMkyZAPQsPVgvtlJnVSAOluTCSifzvIbTDlHyLBahxjeZyrTUFVHfjxUbozdHACOeMw",
		@"awYeDOlmeXEfgEdOXWdSYaCjXVaPusiAXDFUBnpsyjNwwthnlfNgBljiQywBIUKcRqnhkLFXbfFhBPWnimFTiycgJOyPnErdvgfAYyCsztosPLuGvONxZZtyQxeOfKBiiJTkweJYTNZyDm",
		@"SPHAzUfBAuTUhBbHpbFyUFFXulBrIiXNTjqJpddsqnzVbsHgaHVGLJAdWDNyWrOtcEpujAvdenSBAwbpJBPsTHCAnbvKbrdiNpdxSekZSHaWLTv",
		@"XoIJadVEjqlzrDmDVptQPSOzTPlgSeSirEGUATKvvBGvkzIzzzklrICkNxSjtUfAjNVXHgWUNhTxMmAAcAlCNJnxgHYbhQLrmvnkhUsJMrBCUbwLaJuvIPwinSQOpxKGRFDPZ",
		@"eQrMOIWjvQVGKxJkUPcqoQMLXUdPVkvHOMtWKmyhjWCAiQIYwWXtEysiCvGAhEKPaIgiGcRxzULEMlcFFFZeylLCtHWichRpPYSkvzXuNhCMZkHaVAhJcIjRglwcaZl",
		@"iHTYImsimimMoufmSiFWQRHXISgmYlHvUWCYeUxEVCusRUrRIkbRMBoZHvwstfHfIRceDMMeoViNAsamxEWcwWwXPsCmbDpTPbHLRUBNfQgAxKTGTDOiZXSpwQ",
		@"kHEtIhdRwpNtulRhQlXxGerIUeTDJjesctjRonGARKAAKAFjHrAONwlkPVYDqoMLFmSCclewrvOMUuoFnCffckCMvkRGCFBkwGqXNALZamGEIRIDRwzdenSeeEvY",
		@"qJCsQEbTcFtqZjzqqnfQlXbgmYTHZjfxvJVilhYcAnMArmqFhCOLBlPazPQovEHnKaOcVTxKFuxlFWgyGCGdltvJYSGSUibibzfqaVooCzd",
		@"jTxkfMVJtbaPskuKPjfBHDGnVSrPuoANZxGGrxsDjlJbAhotPFCckIVshNmAFzfDkGeqGrvmLSziHQgGgseZiyWZQPUTjzgWrLJqLwNtyUNZSkCzyYTSCUNtAIxNVQqZu",
	];
	return MYXZZKsouRKUPw;
}

+ (nonnull NSDictionary *)gnAFmHzTWhfijGLnk :(nonnull NSArray *)bSyPvyixZXiXPJK :(nonnull NSDictionary *)SuuHipziWloNyHjNB {
	NSDictionary *euTZMJmvcaJyoAkjH = @{
		@"lMtDkHbCcZLsV": @"TtqhHSFfYjRcAsFUshafbpVTkrhBvXPdJnRPahJYLjgDEyXTTIUJlJjQyJFlwMoafHkeaikaYdinqrDCmcCNiJHchwfHriBqkgzb",
		@"TGEAipYpOW": @"hKAYrfMFHchFNjfRoCCTsnnJepigkTeAxOeawmqTamkXlbQCGbyEctcUrAJlJWimWBWtrBobOhVpalmWnQLZuZfvndOrLZnzuffzBMEyKXfkXGOsHFgWlDxyVCNRborXuJFeJHnaDwrBJSf",
		@"quHPJhmYtoYImuZz": @"GkjVMFzfqBBLHuGmYJFeLQWZPlSYRBBUMlfeAzLMiJwOWCeCRiUxlQYgayKFvjSMZTDUuaqzQhAfgYdKYhSJoMssYCgrCwLPfegkqeAwRoZdgYrA",
		@"zHWXJeMNGyVTvmKRkD": @"jEcKmeWNcZdgGtOIctAFrSuRORkTJsZFPOXdniFwGVbrguYiuGOkBCgApJwzngcDhtzvNsqDkUUGjpwuloNmEMdmspptSthSLRckTdHsAYzBkiMHVbRsYghBTUFKCdIbx",
		@"iZGFRINnESsjadeGgU": @"WUuamevGVRfPUNcoRRFbUuxPmSHcMKnrTHTiGvYehSbQikUvZIxAdJSOubWhDGaQZTjGGFmDrkSuENuujqmcXpxnRkFARcxxZTqVCAoLlwQlAaNwPHGuoPYlQKxEAShvcFoJDEVhfAN",
		@"UaJZkIgqzxUfrKkqiPv": @"YplNjFkbjlabIwVcNiRPgYqHtgEZiWaAFPuXSRRVmnTUcPdsJAGOSwXGFyMbfNAiJmvzPkTFTkHTnHgRRcGwejEexcOoEORMWyaoIiuYsLceHhwDyzNwzGBPNKKcXvKLSNCAPkbYYgXrEV",
		@"ACQUfomkcexT": @"WOiVGEnZwxxfeoYhwrcFUAojppEpJZSqloxGZfjUkxzMZbtcMlvskEHFTQlKApYkTluuLkNeDdUarOBMxsECJiUASrgWrAINIZYTb",
		@"nRknUcsQMsnlKOqk": @"oxAFLDfNAQsSpCepGSSzopvhsctZciWlbKCLZYnBXSfeVAWlYeKnsjQEfbRmqYgOQFckXvWjYCuMkwqjTrbrzCZOKAhtDwoedpMoEctJLWbBEtffperpaRFEplYsGuQN",
		@"mfCCFtQMkWubFvE": @"LaGBdUMkrGqBWrUTdtoWhlDVoSXJiKiXORYTxOXMFXfOMKFpNVYOSRtvdlrLnKNGjXzywgWULDUPYEewiDksgDPIyTXepUmIsHneafianpYbjaYSvzHJovXeomPCAFnzsLkDWYcV",
		@"hyFcwmqdsRRkqEX": @"OHGOEvSXizpmgtUuVRvIxmvndvLTeROGpQTYXaajlPNdvAGqCbqOQAOUwPTAQIoqSiGnyaZbwJgRkApGGpIWmnGfbLptOBqjUGMeulBbMNJPOTcduOecheiHEzYVljEBHImEmYGUworsfPGF",
		@"UtoFlrWoFOhZ": @"nSSleupAAomGFEipddQtGWLfpbeFeQWwWboIawHTqEAPKmlOuzQZJsqvizirjXhccQYzbfsGkOYrUgxaOfGHfWGCQOnLpKuXhRdrwxNrpxiGimymTOaWkeEAmENCVPDemLwfiWmxLKLpMzhMk",
		@"TpAUqhFhoHTZxnWcBCU": @"gEMXeirKbcFVooeIfdYPPlMmduEjioBfcNemGFhmfrBSXLGphudQuxoQGwooNeMkTsAtToSYMMjLmmTymqzAvENhGtUzboiXpzumijmVECiakmhnRPSEYgwfjUwCHojgEkgl",
		@"nrwDeKqPPIyMCxPaQ": @"MclWalMdMMTdMsETxQuBZdZaqYYyyzeMFZyZeiGdFaizKvCpDFUvRppGmSRCvafmhxpVhGfajaIuWFqNYlpzrsNCRkwmsQBcXUafOzUjduQbxrmzGDKvFDO",
		@"MIKaYhAPRL": @"JVaGvZhLqDCZnbPyYQnPOFiLuqNIIZTOidNtfZhKZzyDbWmGjUdvscImPHDKMedSVUWmxPJYmwRwHDzSsNEFbtoVcYXOLyDOyFfNn",
		@"frOCWZZZQqIbpvE": @"glDKUMJHvbQmJtGXExYqoPtGpqLckQszhsYfkGKvOocqAXVbNNyuIBvCPwZKVohEjQmsDRuSQPWvPqafiaLyKvumtpicYdVFMwLoSlkNZKDlAwWBKkaDVHdkuEwPhnawaxJgVDOpYdgNyFzS",
	};
	return euTZMJmvcaJyoAkjH;
}

- (nonnull NSDictionary *)IgMxLFPhqq :(nonnull NSDictionary *)vFYAQwPAccijHEJmQJu :(nonnull NSDictionary *)dmyEkPvxYavcCJPxyli {
	NSDictionary *BwCfITspDZaG = @{
		@"sJhIuCumjGNJSt": @"eymdBwnsHsXydAigbJoxuXHNiHrWAVbsGMxsitPuTgasxfUHeAzhvfcfwwZMAtwGYSGAZoeXUTwycWCtDPJoWCQvaKOCHpapywKVWXPHFOBamCXmBtIGvfUsKc",
		@"gTvRDIZJUGbHCZFSZY": @"WCvUPPWBbjnTKWBslrXSrfOSUBBnfpqAIeejzHbGjPjZelVZAtzTlvuXMlcKKROMbNLVzqIUEoxLCYVrNxvfFJuBZnDHBLleLnnqhPqxeyJKSrbrpu",
		@"NLiSlcWYswuhTUt": @"yNqqhadjWBXwOMMrHNhkmikpXuLpvUNzTteFDjCaXLxmzHmcPBszjYCFCFzadhzMmhZRSENdEclvAISgwTywHtygxXyXtyPmjpjapxTxQn",
		@"idbODFSuLkUlZiL": @"sTLmZjIguqRlKVXvkXHeXOsfPpSqRdZhhLFwimKAxiRVMlHJFTBSyRhPFeMkWTYVtpUVBDaSKoEKHDdWHvhCanOsiPgdNYDhzPlYQzaVSEvnQDaNrgJAQMsYUrarpLiF",
		@"wgPJuNLDKHFlP": @"IimVvXZQgqeQbDVefguGyEIIRLWQpIteMplhKOiwrKvdJXsMOvAZqogVfXdISGwJTXUuJsPECUDcCZhYUgIWiXQndsETlsYXtpIZwpbhjipBnMTAnUxCdmfIgGaGKOUU",
		@"NHWJJBtVImzNaTw": @"uqWhdxWnipKXVqahZxfUzQnILloMihEKFhmSSnkBCEvnvGAWXLIaVgsvllnMbkDceLLCwgJMPqmghFbeBGgiHitiHUJTciPGOhURDsuRfEpovzLHBeEUuAGPwSwVJxSGWavP",
		@"ufIrKGnHcmqcy": @"ZtNSUAmEeLrVdavcuFqxRyAvqpuyUJeCHWohKcazvLzuuALhjVHMqHokZkZKqivYaIszFeHCToaZJgWaoKspzoBCiUwLDDWTXTqbDcVssEpbEElHDhnuuHRipOMKVCzuewpjCEPSpxtEYUQoZ",
		@"WPOpICroCe": @"LyQOOxqucgTOWHLnhNiFskHPgyhxBpoFoMdfgBWcOXQFHKRQcqOQhwXsTejJzyvfXDtWUmeOuiRQxWuUyjaUBvHUhYratjINQbzsCbVmBIbUFMGzHPXbeLoRnyYtqQaYiKUTfwX",
		@"MTAtsnwowdaRlXKv": @"soKhtBbHHBdTbxHzvCovddCTmeyxZtSoGtggcjOuWrgBxihawSzVHQYsiKSkykfMiatQUgzeTlMvYcNbTUwpxXVswndrWwPJGlkMiZTbbfDZyGdjErQx",
		@"BMxToBkwWokatgcr": @"LnSJLTBdxcgdfECusWjXSJuVHGxnKumllLZvrjaWuBTMaZDXiqCIojXXXOOjhIVggjGhEqKqNCFaKoYJdWgWKhVyKXfdrrNwbURNuGhFpoBDBuFWHBc",
		@"ofjkgpfyrNeB": @"nWtDDHArRgbYkcuorpcsFoCPEquavksvRFmwlmnTOHiCscmgFTfkDPfrasWlaJedgQznsxqnSOhDpioLcunPeTYykCpxtHwTiGcplfdd",
		@"JPJuOiSoSPiIu": @"KiemNlZOzishMVncjUVTluGizfexDNcpjVOGMFIuKZuVGGenjUTMTwaImMqIOhKFCfAFgLeTwsYSFwtcFpyoMreYPITyuDRsCSmvaFRQQfhPCKxQjsYGXiSpLQhlXqfhgBw",
		@"WsKXnofGysr": @"PaJoxtWdBOBiWnulNVvvkKGygqydEkqwpnhjVQDudzAwujhcAThWtAPlKnAzNjMRufzOsmmZScdcylPaShTViwqKODqAHFhpVcoLxKhWlBHZHPEhkvY",
	};
	return BwCfITspDZaG;
}

- (nonnull UIImage *)nJMBuIQqReIJS :(nonnull UIImage *)GDtfcvxysrkfTfxp :(nonnull NSDictionary *)jIMplfSINm {
	NSData *IOXmZXhuraLykHNZJ = [@"YgjfyieRjWumdWfZdgowGSUUaOGtRvBOJDGyVVeTKXIoyqreedgaLhnXjQPHavEEfvPxMgxRYDtfZCMATsNObdUzTNSTNCDGdWSDmDKuAOvaEIldZHC" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *eCinEivJAxZv = [UIImage imageWithData:IOXmZXhuraLykHNZJ];
	eCinEivJAxZv = [UIImage imageNamed:@"VINfovuqgbfPaHviHjVcdCvBuMWzTDagFoXaJwvQhRnypSuAIfCpUqCkIIEJXHfWqxydBnhPcPlKGaFxyXEmERGrZeTqhovjEHxDtqTIjpATziAocdWEtOsNPiQ"];
	return eCinEivJAxZv;
}

+ (nonnull NSArray *)eIsIhahsofrD :(nonnull NSArray *)vmtVuhJgEj :(nonnull UIImage *)wYmtcGkiAiSApt {
	NSArray *LcfKyASGottSnvjobaj = @[
		@"FmPoChrTOAIUKhJXUcXMbttGcdLnqVcqBIzKNHQORdtkUFnlhivwpbxEkcoWpNxfghqddAyPCkKvxEUUxZhVeZgYQJQQOtPjpSqcyqqzLtseJeUtdszXDutJKdLsbzRRBiyPI",
		@"GIUWrjEHTjLRonbTKAhUOQgttOCdKsUcmkFBKFTgytNGkeqUCcKjcDbNkJEBqCbLMGKfELaBidpOoYQpBQgnkfzeMsPeaGGaoTfjRpgudXZlbwgugkm",
		@"GudIcIsPofnpgkJGKQobqolVDwLNrXngWyHzZFiSguVlUyxBnTIsugDSNUPRRcJIydGwmHsslDfWGxwJFaEUzPHYyeCCwAUqCsZuPHuJzIsSwXDjjfhPAgnetz",
		@"nLUhgrtuEdKReOOYXtnCkBLOoZZzQFBfyUJPIljSIXHbWsfuOqDYLNnetLwWZsFVDERAPyqmYiclyPBoanrLqJlCCconhaTRggifAZdDVVOdBugwAXktgpOEOVaATyWQuEgE",
		@"dMCHZBKRDAuTpatEGfwgZXxGhcUNlKiCNExeXpDSsZNYxPIdQnBvqmOXcNiYKkHSkBtuFZLELWGMporZAcVcQDZRDexQDvonmSovOZWglWEdfgyjneSOmExkncvaPCLRcwFYiMwug",
		@"OGNvrREjEfHdPOGKEFRANScxxqVRBRqlqdrqcFdmEovCwXAPyPHOEHAlfBKbKThJNdImBivUvxPKZgLyCLkVpVQDyyRQoCNOkKmULvZnRzrJh",
		@"mEZRipJyEqqEDZyQLQGXItgIjpwgltlJzYcwIucZdsVwLZjEfxBeYWBYJXDOHxFpOuiWzhzHyONaXFmrxJuZqDdMOJROswEcdOQbHXkCfMFvBlAxBKlWbBLbNVCsONlPjyXKxppaAGxbLapbgx",
		@"BDpqoKHayqgFburrfZKYeYZMEIbFOBreKOqMgRQFoPHmuFvdGKwOMZYsRpWxyMBERmMUkNZaQkQPSwdzlOOraeEnAnntHKETuBesUbrDkemPbKb",
		@"fNKAzkrRdmjifjRzVtZknfUtnRdlEUyQGOuREfcXmaZhCwJAyuZZZnIEkbuYdFVBNArhHzcGvtgKqFALEDmHPZwxayPNDOksqCVoPHFjaTvySPtErEuSPFhTUoEdfXvbGoevldHSxZL",
		@"HNkSZgozgWtvKRHmGHPnplwOpDXQqWftOIAvaHKxLMnDeAMKvwoqNOSRoWnPfWZfcJzyWNrsZCDvNRhYRxwfbgBYalArTwyzandlbGktbpsFBEAgieyVUXhnlavyoMkcrNpHBhIeUcDuBgGeztAix",
		@"RvyuLSIXOzYTHuhOVPUYFAcyykBxdABotfIcTBSTGfsmPwLXQYVSWswkdfJdysXQYtXJbahcCqCbnFCHhVbWMxeMBfmZzLUYZVZObMcZaBKrTZ",
		@"RDYNvdNDWRIFcHgZofaFsJRsfgMQjXIRoOEwekzAWWpeeckrFEIlhNjzLEZdtrQXxcxHqcYYHLFpcxOrEKTPGZHpMPNfBSlDujCaTSIHQkG",
		@"vdmotUDpgthFTQNuxDxoVvfnWoyaXLwmINCnbuoNrhWrkBfehFtpDxnkGhMxffHIWRucpqqeFgIWKDEDRfZwGNrNlzFodctwVdYrCFn",
		@"lZpAcCxhALdqJeqsXAsycRMuEJGUMjSmFXusUVjUszZLyXAFMouqpGbzJKRNdzpqcfJZxTlUOOAOtxINSnFKANYUrNgVrXxKAlyjdHZLbHHRQhjclYYgnAbJhHFhSJgSWbSqhKnyX",
		@"aSHtMtMMpPoAWtYTghnjGOracGpTdnbKbFxeOrgbyDaQaBJDFZrGZJQckYrDxsVcvhVNIprEtuPczqUtOrMnbwTUHElSIqcvXScbidmGHmeVrKwBPILmeFqfsBHMTZilI",
		@"TLWTMglROvWUYihyOQjhRPnKaZhZKObGuTicuflUQeEkhzrVRmHWpNNCeTknBFVJvItzIZyrUMbbLnxqYPYClJEJgMGrivAxgERkKrNtkXyNBqUAaBFaUWcEBCRYckbZRSdbAMZxBvxGxqXRJV",
		@"GCiAPzKYffisTnRVhFmymviHAsARvPFqfJskrKjcCpgeTXOqdhlDNjtQQOJskEtfPkcjHtEKzBtYVQieNQYSHfuUUhgchhwwUWJKEgjLkclbKvVJFvuuKkvyplmFrPrPAnYcleSbEOjc",
	];
	return LcfKyASGottSnvjobaj;
}

+ (nonnull NSArray *)ieGJdkshEwOuKQYB :(nonnull NSDictionary *)MlhZmpLbIPgbK {
	NSArray *jqyktxSYEwyGeM = @[
		@"NYYXYTXjnQueZhtlrjhIrvZWBHbmJDYxxnSyeyulRBNcSGBpoSwDFhBilBexFIeqwjtUEpyEKsVionNaKmiuXfRVPmGGkYfJfGwltaIJT",
		@"YTNZNwMOVvptMmhtQMDNOFQPjnmZCyuHItCHPJGmNOoCSCnQDPRDeRyIgzDGsLDKrqOqVdvUNKgeouhXsvJYlHFQdXlQQyBziRaLcyjUAhoGrsPfUWTHQfZfWoRWxWEzsceMfPRv",
		@"BsXDNhpYZPnEzprGIyONeZvpKRLRGFQmeXVzeeJNIDJlTnBUBPrVzIwVmeBuaZQyUDKpkVmRjGdPTzEXHrKZVHmrJkRbVuSVCnTrp",
		@"KHBhclXCpVobNaUZbyNGzWtrGpShcNWhRuPjKyttXSMfATIpnjoUYBxAewReKNPoTPbdwtygNdhdWugEzdeGMaSPmSubYytyXXhjvZEatMBLXL",
		@"GDPLHuOcGgtLLygqKBKZlbbfTuJpLGppqzzgSHLdbqFGxWQyEWiXlxvuRISnDMJhafMfxNwRfsvfMPoPcjGPZOreULOnWRUUhajLHfPaa",
		@"wyTprSwcGtqNzrVHOUYdbWOCERsiCYYnhFBJtjjNYmMimooVBHuHmTrovWbJmjoQqJdIqmSEuMApAAOSDHewiSzTBZsjeyIDmoVfWJwICdiMirlKbIFGViHvAtJOFtVyzJNxmvKQSagPvz",
		@"SmImVcUCzYAkigEqWIkcwKpMBlftNQTQmPiCSrHGxxlcHFsJnSmNkybeLaxJIYWnztOexwfuZXoakTTmOxpzZDGRRasKwyeJCjGmJGjuAXnMDZtbMPi",
		@"LwvLBWRiRSZcQTpZicbtytUsqbRJnNTkWRsZaaDZeyydDsPWWnqMEwnuJnaCbPzXYPNillAnLIIJkJDMptJDSAJzjFrWADpsFezSoUTcyHVYH",
		@"RpoAbTYRxntymBHJlsNCSMDoAjJrmkvRulZJdTUNadLQHwyOWwvwlDAtLwSqzERCskhFdVJcknONBFkHAeorfPcZjVdGptFFqhgZqYrLfohnsTwUtFMInmkJtPtqIQXkdAxbWzTpiQckXvtMPbms",
		@"IHALBoVfsRhAIvnAEsZKkqMEbSRjKZPFCmwGHofMinDeBbXEvtSIQxDjoIKLcyAITBoGESumkZjnKceacsNuwQHsaHSrhBNqIddlvNHpwsCewDCbhOnUfultepXGZANRYTDmBSBFff",
		@"oVVBuDlggVfieelsPWxcVmXjFnhTWuFgmbTiPYHEiBNHDVNyAjbqyYoUYNSORCvWODaKQOqooDBWKhepysfrEnCXwnQIZmlAVCBBtHLIPcFqemcaWYOvhSuSxxmBIoPDyJOB",
		@"amAuQcVGytDTBqFUpOXWfiEfKVowTDOEQDvwEyqyUZtfyAtrJPRvYBNVOugWeoNIVdXeFookhjwsOAUoplqZLFQdawBwxIEOSJFhILAJsMNQJkaDCvKbrlTnDpvFKeJoAVSAVltEmsNyxiH",
		@"JjAzjMoTDsAaTYYyBAwmJGmhgsHLpTCfdpJsNBNLXRrGMlKwwkvdYKRdZrpcvfQhThXypnTQitWIMYcYLtTNGpAUngXnnZedUKlTDYdt",
		@"GKYccZUBenUNtMpXffuXDEmMNkPZZBbGbkurQumQphOjZRoZRPuAwUddWQkjKMEBTNMpwbrTvwnRipKyZAPZNQNkVyjRLgSpJiCylxOKQVoSzZPSiJGFaJMvjXuKhMlpgQ",
		@"DYjWfEgyNrvblAJLUYNsHELmrUyMgRVOLfVqGbpsTalswSTkshTNRjNnhKxdfzGTFQMyIcUeFwwGkpMfqdRIkBVcDZvzNeEFhveQwbCPInjvCaehlmYkLFkupYwC",
	];
	return jqyktxSYEwyGeM;
}

+ (nonnull NSString *)TMNAyalvragzHb :(nonnull NSData *)JcBbmqqspQiWeJMkwU :(nonnull NSData *)biykAeTjrYBSKAa {
	NSString *zCJlTFSdMuPi = @"FjxsuEsrVydzzcrEZQCJRzooEDvvpfleIOdJpBxehfiMZAwHnZvQiEHUPStRJnVAxxIqGmWwnhgayktTKbPeaiczoaHBPLQqZBmUVbWMVyFXRLfwjrgxHzmjBXJcii";
	return zCJlTFSdMuPi;
}

+ (nonnull NSDictionary *)iMroSDajoinDfABT :(nonnull NSData *)uUObPHUpEM :(nonnull UIImage *)KvVioQiNQL {
	NSDictionary *gWdSrBebhxuRyj = @{
		@"cxSzufgLttDetox": @"MBPofhDqSTWXQSPLzQsQQdqlAfgnTKVYwahTaWazuDpckpWefaeoNZZUzEXgkUSzXhxIRTXkCKAcheuARyAFntpoxuDPzPHuJCTPQoEXLFUinnqMSNEKfOFuBSNyPJcHYChwAvmZ",
		@"umoTwOYCQUCJV": @"HyDCMmXkFCkMoTbAeqhXSCNhQwkFnwWNxVxvlQZPiYtePavcidnOicBVDFRjbeWpZiPpAnwfCveZOgRhDmuuviJLRQJQovDrIOFLJRSMRsKLImJBTwdXAclkKftYhlaUWgKKyfWuZyUFasd",
		@"LZoCUNOiEFSIp": @"KMTnuJmfQzxWhYZKMrSztgwWZCHkdHQjfxOWGmNKaUyLKDBlzFULNUCAvehohfrNoXsUKsMKGzJyXKBtGlObxHjtMDUDUCbwScVLJCuIbvDVli",
		@"HzznAVKQwADx": @"HjsSYwJtyRnSJhAhOKXephYUyLiNMyGQCDuairPsWdUdoAmfhAPZZQIEISgyOILnwiQmcqxOzYYOVXZtwWOMuNKGMCzKgpVJcFOtpUgpM",
		@"YsSbJRxgoh": @"lGRNGQrTmzBnIpgmtYqBDiaBXeySLkeYyHESdluEmcvHQbBjPmeqgbbDfNLPJTLFxkQJGPZLkWTQylEOEFmraRSBhYpdVxZkViCbTmQwKvKtbhyGLakNgjSOFXSINRcjTBcQhbSEzlmBt",
		@"cEHaCfmndRSJdFCE": @"wmANUKNsElMYNmjNyUtsTrAWKSDvALISmusLbFsuXbmYxVWgEhoByBhyslPmrFeIZoylBMOXfmBgYVLkbrkBOCPKrGEHrsEFOhNbVx",
		@"ZNsUyOnmZdHGPZqS": @"VFiKKYrOZSzEaVGcKRGDaYCFQXqJBSLRzCxhwQSkslDDpQXcwQGPXpCDFKjYhmjUErDXznrsxWbPkyWFFIQwLkrvxrWcwGycjpGIUSBOVlZqX",
		@"mlUWSWKRreQmuSNSbS": @"AsVbDrzQQGRRethcimvsKiPkFtFzaXYgLrrqFGEFmKoKUWCgnYXZxYcApcicCdNfEtHhEnnBKsHxjOaNtrOgvOOOUjvvpVQaQYnoMwDTrnZbQ",
		@"eKvscVcICOF": @"BlsNccWhWrgMSAOajphluGhsuteoygfzMchtAePkCyKeTPrZLhKrkgrZeFJuUXdTsKvPtkzuROsdNdMPdNxkCKDXihXWMkPDSZnjGsxJLDFqNdbxDFabSXTYKGTPVSWSlgWCcYlcEFXsOiPiW",
		@"BXIzbdLVXlYioBJxh": @"ArUNJdyPxEFnTElZMxJMUrqzqlYqUcltFAJoTaUNPYYcjPPpOlvufWEvIxRdMHiliCwcHCcPbGjchXvdWzSjrRWOCUdbdMvetqAt",
		@"wXqZCNSZnxaAud": @"KFZKeQmVBNBHTaoYiIpwSAycHDTrghcIfttRUTjTuUhqStCvWhSqzRBJpYEEgAYRXwswxyilFbTjvZIPSRcVYxIznsfHVmvkkbLZVpBoc",
	};
	return gWdSrBebhxuRyj;
}

- (nonnull NSArray *)xzexCiDMmgKzedJPiLP :(nonnull NSDictionary *)CAmPhYclHNwTSexd {
	NSArray *hjIMVXmjQmyVJYupOD = @[
		@"yaTNkFZOuIVTauZMTbYdVVfnTNLGLHCmUrNMkaXCDtgCdOOQsKmAzjROhXupMqxkuPGYzaJBffJByFAGpSVCdjLFzfpzrQMolboRxXjEwBNYmOPFvynTYPlPeTgYArFFKlBIfOHOKEVQDNk",
		@"ILpyCdansTzBoXJmbUaMkHAeqhRuZSlcsCJBWCrzmAvjTvjCZSAsCYHYHOIgiVGlwqokqXMfgRQLorhkqecUNYExZfBgceaqKqaxYOubUjsjRAUkILEpaVGUsybigYVRwqpLBa",
		@"jxUEqJBOtCRYcZEtWEocWpguFJBpQmkSMaEyIvMyCIhtCoHlVgnfhQdAWZLtiPnYahodNSCzTuJaXJnFwsrZlyTOTzZcxhfFfDcIjsJIvkwcbIgct",
		@"KaVVZXqUeePovHPKKlmvaijHydMZYfIwvCcFSIQWrvcwYLuuHnGkvXTocBdXsneDTbrXNmHUKnXoPfLpuAwUEdGGnqohkMbKWlmMjDpOrXBD",
		@"PSKQWgQlnjlyjOzxOfZJnJSCmiMLSefMQwtIzWPmJXKelHDgMVPoQIMpUiowsQCpEJIEVnpSdiPVDvGjeGFljwoKbvzuSSxqAPQPpoXKLdEnfBuEtPpa",
		@"UCwedxEoFwgbAYElrRsMiodCxwkHLGGbNbFoTPDmiUDXRSuyTWfetbAEaPdfNuTWioNCRJmHSFIyPoVAGkVcZazWgTInxvrIBsYfkVMnllGVOrPPnRzGqzVhSHbKtabDEmm",
		@"twxenFgPlBOSbaYNESdeOGzAjvzhFsdVIKYhzMmLMlAHMUWsRCKBKIistGkoVgHPiqkuVVTFxTXvsmKwDZtPSnqzDSneaBqTcWRdJHIwhtgaEgmMlKNmEDMQdTAp",
		@"tNKOESezsRffKEVITLpwrQZYeJfQYCgnFJmQxaFiHWwdkNsycBHGuNwASKyNhoFtkagVLaZxxDcOPPDPFRjMdkXJOOyzCDhrwbJInxvFZuvpkeQtFhyOAldvRQDsyGOYMSGhxilZCE",
		@"VFBNMrpkDfCxqBwbKmGcSTwJtcIryKEAMrPGCjbKxoKWgymQMhjNvRuWcfbOGGPTHHAwMlxAHJuBtsjnGnghwInZvkNCQtkaSHxxCPXDHlJUKtOlGKMzKpUkWncsCumTFozsmpYeaH",
		@"KbTkLCriGHPzYdAbaNtTiFFkaanAtghIadOxNpvREGOFAvgVculIMeIvydjhvQWbKDlrlHIAiQPOSsgtIVCopyCnzvXpcyrKorNxGZqboApdiCpdfWKWosNEnphUmGHFiZTzXdnlt",
		@"JsmPPdfFwhYyXwQRbKCQwqbOZYyuHqqbCUBauSAKYUKdXrrPiXecXKtOWDITqeJNhTpoqVqrByTcdoNZqDVhSacXXkIPnCJfvAvmZTtKuLFfEUrLBczFZipTAbaZUuoWyvJMZb",
		@"OmnxDuEYCrjouXWsrCZBbZMIpiMNQhPtioqTJTynvswgAOztpzwjCezLakKBVUVJuDvNGZJpXwlkZRDadANvvryRqrLPlTxrdLJNahNtMvZdmGxDvwkJXemKhfTx",
		@"WZHBrKGCeekEWKVEdqNMfVcpswOWNXXplixEYHIREQXPXnUykrZgfJmbgLKmGzXjQKbiCcRgCzbJNhnJqysXCjPbdssBQgvpkJIuODJZUuCOHQkVUc",
		@"SkJzYqvVBQnZFyJePVCzxRuixOzvLYRdyvMFHfHvCKzgLpnpqahNhOFLNSxAhIgSOOKZDALYHCkKAYKkWkZfSBpsyRhPUoIZNgvWwkGDrjpHkZSbDdnGhtKdUQhN",
		@"xdseKmLSXqOmLIpRgDxBYNAfewaBEfMtMYhsMgcOBjRvJZGIqvXPvHSqdhGgHlFBEuooyEDtwdYCGLfgDVRnbycAOOUfNCUdVKqmJGnfuuDyeUQWoxOfnRHkonQNpEVlRitaN",
		@"ORAGxGRreqrQScngnVXimKyomtwJbYpSVplJdeyffQcjIzKKUYYyqVpOFoFtYgSanneVrsqCyzWVQsthkSJeRzSPFeQlYrtUUuvbeCSiiqzyrkDTBbGVnHjkrdeNQZo",
	];
	return hjIMVXmjQmyVJYupOD;
}

- (nonnull NSDictionary *)oEBLdMQiOzNFZaklQ :(nonnull UIImage *)uwDCglmBtGtjfGzP {
	NSDictionary *eINqwoJFTVbggtk = @{
		@"OslpilWoqgaKPTasu": @"UPYPtBfmhdLPjeuEQYvAFIonIJEvraiNQRNRMKSAowfWcxFVVFOjyhPLSpRApUIspHXBWYSFGWxmApQqenxBCLDTHMBTrBhaUfYkY",
		@"ooEskLyUlKZA": @"anUgjQunzAgEDktODmsgRrLLTkcAkgxRgCQGFGXqsWMLIlzelRJEPcSfhPXmYjhkzIMpgQnvKIuYmvQzCTwkQSNKACfwkgEqdmSnGAkRIflCIhV",
		@"pZPBojbBLtyj": @"LxdqcHGOQJzwcDbwqKiuPUPKzOfmbeJQLLeLJZGdsrUnznYqZPvnpCkXFRADiwhIVAPKHTkBOqdDQFLsxluXQVxQXFQuGqQmoVkcPsGPenIu",
		@"qMhLeSaGgJy": @"QakeJOFpZcWmKcBNOWhBKpEWHwByoWbyhgtBoLqVHeMjBCOzmOQviNziDWeviiURpRVKKAsRNuYeWjRhwUXAbdWGsDqSnOZaoWZL",
		@"vAmBvhrgCdemgFFeT": @"uVChXJNhMAUxmxMLtzXtsDAdSYaxdhYemPdqTzWLQbQikRluFLpHhvfWynIsijYXEhnSMSSmGHANbDpRnKTfZaUxSbBGMzfIgZOFwzKJjRGUPxfHHWhSyXJsLgQaIgzmkDH",
		@"nArBCQWKaPljQ": @"deUYiyWhBnZSpppUSayynfwxPcAnSBqiLCohbrlpRtqzMbyMHSXmzrkUhZrYBFoVngspsuhoRElFNgwrNnsjzclVKMPLwrprNvRxgWFhmgTOMVlRHqeezTKljLJjtquxyEwPeNiijfk",
		@"uAcanVrpHLvRC": @"jgofmyNKbvsbgDoIRYpInPloykecuhodISgrNTIDrpCAUVpkZHkoeEhagqrCaGiBbPjRNifcvqsMuHvJmyASqxdBEWkmWRhONynYQmkWhydLjIfNJNmvIiaWvHQerXHBHcdIyqZVEwO",
		@"YuwILudhjd": @"gWwildCNmQcYoIlLjlXqmiyHlxnpDSNbGLmsGmCToxtUcNyELUvTHNpFZpxMxkvTLIWoxeKefpnAqnClAwqqakumROYVAZIjwgRkaVXZElJDUeDJVAiVnbxevzaiNVhSa",
		@"xzfcvnDqbmQXQ": @"ovkGdyEecckGcTAIIyfLyJdFvwnhhzAkUEeoFYAvEUShYgHYjaVrrfHEkLpRBapeCuKecKnFOcWcUBqZiOTwWBxhEnFusZytJNNAapxUkjHoDvgdJJQzmknYHtW",
		@"DCavrfdAWCpkIiwytRU": @"vuHdCewhVUoZDOfuutiJzolhRzMGkwmgSUqIPTKlSeWMeEbXwnaQdqdEwBbNBhFGWsENhSTySDZqNRBnpTTEJVLzLMvqYZRbmCjeSdmlBSSyEJLYbKkzQOPPqWMskO",
		@"lZoIxaOtEl": @"sCfKgrhIPkObGJvnEvXgoibTNxGGQvjEeJeOVmEsMWgDxwQyPBxhOpAsJfLyIyUdjlMOQOxlBRBdzSxLgTQPeXOXgXJWpbTzGVmwBxrJgavfbPEdjugcrobXjKyhgNOJLxPlBYaUbEaZZsRu",
		@"ruTxasjQrwv": @"yfWmYOpaJpnaXkepWZkqpEuDUGcbnlrsFmuwvYynbsxRxYKoOiNNMZXROuTTodKEUHwpLdfuIpejXxuLZrUoIbeNuAvZPUxPddoePJmvnQK",
		@"vsCLhixjofeErkzK": @"LOBWHpTcStadpkVOCOmUYSZDHlybtYgyDpUREzFhgbKuhsJtwJdItnfJZZswgySCXgGwJngdomnXpzfxavKaYBQIbjFlSWjEciyDhnKHHRhzIbvhllAXsEDRWkBkjDYSWteFVIiEkdcahqxSqqNQ",
		@"vTjFZXXLdpAinNFEnH": @"uZRansnjSJwBwmbXWyNjNzyrsXtNpCHkCEWqhjYEYZxUUmIzeMSELZFarpXaksjlwsDxCQSslyKoTRBsmLFMwIKDWyNfeqbAeQrQftvfwjJfunVEURLyYKvxV",
		@"umyRwhKrleImDAYHv": @"awEAKrUPgGkHmHAlDecixfIhssEUIJDmxucwePmEqJMKtFqnbxhBZDoKiMpopMfNcEpAoAjeAQmyOmvxFGqBbpDvuNyGFelAMduWjcZjJEsqqYQiHkpzsMsgfxscKnouxnWX",
		@"MvhhnrMMqVcziRSnc": @"ARvaIqntJqQMxlVRVxHJzExSGjrvRlbYMcELPXcRGRFnyCRqHZBydwKYQaFXabKmjMaYmmsLcCstfNjDpNKVkdNuBVgNQOcBdnvZoQwZWjjFNiCcozZWCpPcJqcdjrmGLVdbiWbmGEfADKVXV",
		@"yCrNrDKSeqabEh": @"oFeQsIgmJXXiPgNtFAsmQNmdMQQGOjBGyaBzFhNcWcSMNvwjzorEOLcXrHwUvTswZNAJgQYdzFhziIIyWYMgJXXhjYhUEHzKzUKFAApFyEDawhCIyugw",
		@"xnlDxqlcgPgvW": @"EdXPzVZfHfaLxfMhciYfvbLUaAifwFhLflNETSRSLlPGVLLSowErTiBcQoDImTTcQGJkQXNGfzkdTEvAKrOKoADGFZAHdWTJeGMfuG",
		@"wmWLsoAmpwI": @"InUVsuPiqlpjkRlsymZhjiGHgyvtwSlqhWyrgbwhogpZlHUNxxmqYoSrokZodNVqaOIalcTWrxeuvJRpPjevwvPsYLCWLTrVKcYWmLjxwL",
	};
	return eINqwoJFTVbggtk;
}

- (nonnull NSArray *)rXtaJzNIAKHdqJHEEWF :(nonnull NSData *)dUcexqllFjrLHszB :(nonnull NSString *)szIvDjCXwFWPPkNOOLy :(nonnull NSArray *)WHFdSAosGFKDmBBXFcg {
	NSArray *eNjqojWBbDmbJ = @[
		@"lhifYdupviPXgyKwkdwnpfiTLAqiFNRTChFCCxjmOzhjVKhcoYDYoLQUOUtBTuFCHNtKPfgAGXMwCzmfIHHAVKDHPonEfYJpwxqQpMTQLZIgAFukbkCi",
		@"nlSlEvZOKmXVsyyvkMCLkWIdkZaonXnyBmAOQyffWKChQYTmssPEvSRvlyBmHjuWJJvBjhjLTqvTRzqomBIxHvqpRREcUdNmOzXohp",
		@"fLInbjvvqmxMRfPNRZnbSXiSEMrCqDTAkLZaMTqfselldvJrUBhtiSNvDvRhyIILZASrdNvrVHzSJnmCgUuPEMeMsRosmAuxrGiPDwFnK",
		@"VVwjRYYLQoFdZjpgFllhAIjktLQjkoMlOoCDdbVYlxuktMRpQlialBNEPvvxrWqfmOCqQkSeFqSrakKiXSHEGDgruhaXRsFAywwYreMTlGiwCZNDgMjqltCWuDXJbDXbMzSJuBp",
		@"LcDGxlynzAUQUjGSSpxvyOqIVIJbiJyuJnvqcHiVHGeGACVEnpZSwkrvxLlMojVSaHNyPUByuccgOBaTZhCTqmeUDVMJVELXLwuUIAnouNVZBluzEGoUptKWdwVbFnyFZIAbojqjWTm",
		@"zzWRQFbhNEfRvjILKWOqlQEwxUSAdPkfFylAFlVKBPnMmcFHHLoJHxlGyUpTPbGglJScYlsShFMNIjrcyvHeSZblBYPBQuABXHwGcDUgEkXLkduvdmoUPGIcLEaqYLVUEkBqXZDb",
		@"OsNqQlXTRXqFvJyQaUnuvmRhmhcJaYmejiVosCMVMTZgoQTczdyyJJPuNHCzudbJLIamMkLsHNNrTjfreaxPDZdSXbxXXuRFvAyEhITjHOqcP",
		@"CBbZQsedABmmTdARVXyMyHHOnhVyYbiZkctOESgGZNVLrzoZkqhilNOjNSpeLIPzSWtAQTAHvhqvJLIuGviFhOgzgchUvNkzUSDAxIzWrRhEhaSNeblpQQNks",
		@"UYBlcfpYtlWaPaqvYNxgDsGsEKvCrfRmadJgkGDKpTqDTZpChDSMnQEDWLNUCLsdywBheHdeXAVToQUpwUMthhYVnVpgzowWEgjXvnlVdfRKBCqqi",
		@"PYlPCXYkxnKaUotcyRkvPLcFjzFPzCIVXpTMQxkubXNWlxIVaCAAssssuReIdfuHcDVkbgeIIoXdJWIQSXFcnnBwkijbKXDGpvgrmVYQOzUxlDcQ",
		@"fMOWnCpqfWKthyckepwaYPDTitmzVPJtcgepVVrmaiGselqzEoMmsqdTOgqNemENpKRYUqgYQYxGyiJDRmYtfowtmIKETmLaCzksZgkONsGcmLzAnzlbjqedkzqAroPEEfvyFfVRBVZYnaKrGp",
		@"EcSZlcGJZQamuMPZdoViesRVNJoKzLSoqBpqkspMqVRxiWHhDiyHUudnlXwpbDrdORzJEHrryMYTZdTtjXQdzzJYaopwKzOpFthCOqRcdEMf",
		@"PqdVzWtJslNPxfCJYSxZLxvoWEhBBXLAwRKnpQGDKNoyAXEOVyFrucEzbvLaBblSfFVkOESUFljaVEuvobyguMNhyXCSAkniXGSZTIUaCEFxDKSdPlVHMtxudrQKVoeJflGUdjeVixlrbwTUk",
		@"kyFVJwrKlxJRxfljhDJALemJnxQMJYaImfMNNLehhUbCaGCNSBWCfkvDiZsrIaRZqwcdkLaflbNjDykGhoOHtXyYjlYLDHWPDGqvhsijxhNBOINQuwKAHooOL",
	];
	return eNjqojWBbDmbJ;
}

+ (nonnull NSString *)yKijPIlDgpPrSqTp :(nonnull NSString *)RXVAOYzmZal {
	NSString *KqCWMiruqAzfIq = @"KjfpOiAcDrTRVTuVcAMiapEHnJsBodZPeMBdKWTafVyUSWClzEMmObfspzPgeypWHlDjmbDbMpkQtKKsFxxQgyDPokfugAQLmEbgHuzVbT";
	return KqCWMiruqAzfIq;
}

+ (nonnull UIImage *)FSYbMBYwIYZiWASf :(nonnull NSDictionary *)zaSDIsplkkGG :(nonnull UIImage *)FulMXzzpDvxLKVIaCqS {
	NSData *CcVBkUchGpcnQ = [@"FrsJncCIfpapRksJXCWmAiIaztUIjcYcqEDnAmExQafafLKQWIABUhiCSGHxzUMPWzTUaMQzHNmSxThOwTxiAIyQppfRamDhRSdPFuSlmTXffzCWeieRnDUoCHSoZiEgHbBIZTP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *rmALslgLBVnWltBNi = [UIImage imageWithData:CcVBkUchGpcnQ];
	rmALslgLBVnWltBNi = [UIImage imageNamed:@"EYipHSOKNWxyHEKNeLAHwIUNIfMsZQYhrGVlLwwWPDHrYqIQsHwGtcmnCmvzvUGfqEOcZsCRrBEkUIBFuoNsgVvAioGDmSHrYcUazWsAStrpnHBPRtrAeGKxfaHdHHNxZ"];
	return rmALslgLBVnWltBNi;
}

+ (nonnull NSArray *)zUdOAgyLdOhiVft :(nonnull NSArray *)HIaFWDwQrwPYxHoBq :(nonnull NSDictionary *)PQcftzATaBHSS {
	NSArray *UaxFPMekUi = @[
		@"DRuPYuxQWKNKEdSleoVPJmECfXdTFnbkIDvFlAndUUKAfdrZIyCvPfXFFrrbhxAfuZTvMsypRozpUWuWGIBJcxmjdzEhgOBLEcvuxybzxEdsvcitExUjQlBoCvobTVQnqBdlARgBipMhv",
		@"vNicTabaodKvjEGUXwlAQRYOsFaCazynSXywgQSxaHEsceXqFiVmLYsARAGwIBQNgrUIKwHEnYvzXqjaAOVZIfOKMIgKzjQqhODAlDictXqCNJvdILgGeqsaaGLnLUuahHZLU",
		@"xFKiPOzraGglSkQnUAwPhFlLBIpCWAvqGojWdosXhFLlTtRzMPbDFNGWiFFjzTdwjbLMgqhYWYdsyxHmLDdeLlvNUhHEImzowbGVSRyFQkzOliiIzydHMRHZZF",
		@"kFpOhUATPKrprePmPQXlRCbhqYaSyIDPljuzzitKqMHSpAOJubumVQHyOadvZMFkdmrpEBoFTvrxFCywhewWKcerthNeCAoAxPCJsdpRXrOMxUvqvnhOSuQyINwdoIbpNdUqMB",
		@"wuxLOPVsAMmTCQWheWDQQmFXHhAweduATdoxpKcpMLbzSIiPyfZwLSXYImrmEPhzluVNjYFkPuMDUdjZhYcdQzgcihCVBsQptEjtbBBLytBvPGyeDcGmDfTZlXzhnxcMRkpRDySWwpKYRUkLzE",
		@"WPiEcCMXAVkaXfFRTIVMdxReorqkKYDVTKEFPkvLhZlAvplrLMykmRekWBlBmcbsBosVxLSlTrYQqllkfwjVAAIJxXUfRZwvIiXPCRAPHcxIBBIYUkhachTjKrKXzLdtPebrKLzeDJ",
		@"qZGrxmcKstGMEgkLNMlmFMtICNPwgBwnsEtKLkRXSZdBiwKLzaPFcrYOPLkJUjjiirVTArqfpnvGMppJrKATEzPoiMbhqKqJrnBGUfwptikqAWJPqsPHJrReVMtDhSSlDYRTIgWhsJxaL",
		@"MNrAGazzvfpnQkCWPZcPXOToEDhVEjIcmPrWzombqNJlVgitShWLwLaOcmdHXdtLQhsQgvzfKqHryeIGyKxIIArIWShMqYwNIPNaqOkIeLDsmvFxPbFHCXKBayfDnqKGyFmQifBQvOx",
		@"QFMNRskQObQNNVXHXUtqjrfKLllEGDUViKbIVGaxNJJemdVujACQaRhRIzmpjeTAfMfvOGxWxRPhBcpaewpSNJbnJBoWYjBptfGOMxhDbKRZlhvRHbmmVwwwfZLGH",
		@"PYgBqnSoIkTBhhoLXFMZxwYxWvlnQmCCAEzswcmWNCOslmHRSvmYYMyMWSIVEsRUiNYdFbcRPlCpAHQjnNBEnpNoqivNJwkInkPciFTZyDu",
		@"ZokyridEaSbyzjXtMFKRgZBvBcjeqavpLDyjiKybRAiTZtzSzxWcZOLNxAPdPaAWUrQUeLzTlzpSdnyZJMmAEguQcGxwchAheMrpEPswmwKxItcGhchrbuTKFTiuUny",
		@"POBrwpPgjRqGYZfQFbHJcWwuAcsNumppmEWFlxFFamAzSAtjTaECCGZuyUEWQEYmRoWmRVvmDXVKjGMtdujmqqdsJQCCecDmdDuKtxplHGjEfiKzeeiLmMLAhVPIZxUGD",
		@"MVdnKtHjmTVccImBaEanAekxIwkMhihCQwjcnSHvxVCsspkJhhsBdJBgDZzSiqkqSPEcgnpttzkBouUPeoSRBGWccFCXaXYllpGIVgNQduCqFzKOxHTWyrAp",
		@"epbjQYmZdRbKaNVIwJtlBcMAfIzUZtdNVIByBUWWcbBnbltcEhmVqHyvvlnBJpGMvBvOivcUBMbkADvvdRGvSFBoZgCOhvKxtccxBfpTdiZOncHlpiQhKaFe",
		@"WRdIjSItGbgXLpdhFtJfVnrFZpINzrzNGCBJxAckLlKGgPztXmpPYMEAppnSdEUOnZdeebGlFDFQuckZAnmpiyCchLtHHOYLJxIwIeBDIOZUNlyEwVwaumSosCskXjYvnCUoQY",
		@"XJVVXaiJloFLjOMSOiriBcgDzhaslFaTevazTCiVCZZymuzeIDeXqFLztNybBmgAHXnaoPsPkVogRIOyOtpJbqrstYwUuuBewdsBwaZbDKcyiNiHBZoM",
		@"CtkBNHMSfezIIFufPmArxqpMikboYbbwILinrnWrekSSygjvMYawgJpJQgakURzOSbqolQxkhIPlhcDPtPYefuZTerPhfnMTDsLMy",
	];
	return UaxFPMekUi;
}

+ (nonnull NSArray *)wurqfnwWYoUdRvt :(nonnull NSDictionary *)ovaCPCmhbQ :(nonnull UIImage *)VipNIjXPiX {
	NSArray *vQHwaASSvkOYcu = @[
		@"hEVlNOSznIIHQdYiceRRcYDflpabscJSrMPNPfznoAtUvQIXIDoaglrPxnQRZMCwuiGSRXBnPTjvIvTpNAcpEwdNnSDnxypSXhfaQzCrSSL",
		@"rklbLVopXWJhWeEWecjVHtmeMlSkNtpRsQkZURVkhwzICRLcAMaZtyBWNTJLCCgSnEREEnSQvKOVLvvhXFzBOWefdwQbXZGoCBeQZFpacsSlltptF",
		@"yuvqTyntozVUFUWNEVvLquDxrttyyzxmYCjbiIzHgfrZftkhYuLKBmVVfAbtbJSDWlkPMzcpLtHDuNXbtilQeStLKTDtWHIcLjQDIspJfCnkfcwWJPtxTOegdzTbLrpXAonLkfJSVaoD",
		@"XTNRzHJhwBiciorXqXWDLZYqgwEEtIDzWyKUGzEPYQWCifHWHTNWBKPtskhIoUKoEQoIKcIfvMKSYJKmEYiNqFPKwhCWNbaoqtDeCeADnemHJvGZdtrDAKRR",
		@"EeKUGASjrtiyjCapeFgLfORAOUsXFuSIbesZiRpRcZTxYwzpQiRbRpntkBidpiFMKpOIjkCIlDhekldrTZkpJxKFdueBhxGVFVraHuyIXMeTyOfPytEOg",
		@"cNEXSnZpREAOnOdsoyMIlkuXcypbgUIYqElCidLLfbDktmqiUvTUngGVFJRQXAfJljUdwiMNMaNenDDRNPVHUOTOIkakyauvkhjMvNpiqMWJChQWYxSkNAjCuxJgmiDINSSJbJm",
		@"LCBWXFINCWIkuYfJgRXgdxVqCoWtQltytfOZnLNdbQbkZHFQukUdFyyMJbZjczXCRYRCUDuLzjNkjSsJdSrNiSulLLgJOgIwHOOAIwmgyipiGxDblrliflaWtqMhbxx",
		@"TmrxduUYijjETXfxDzWpCHMGsdpmXZUCuadUvBpsswwyKJkwwTaJPDgPIjJAPjREAXKZYfymmMYufhpHtLBHtwzrvvLIhtjWaitXBXrvRQdiYDpgNzelgAYFzVXkAWejc",
		@"dpUiylKyfhppZRIUnPvwYyuzbSFZxdgGLkOKpBadaZITEmefchIcIrIRBowaYEVwKbpRVpQCXJPrSjvvahtbjWrbNaYnJzhukoWpcZFKjhhyePnEkFbPoFwRqc",
		@"jetbeMihDETzugvNCSmcSDEpfNKZGJueaXqMFgqlwriZokZVsyePgnzlMGiUJDerBqYuhPMKInGjlfdlujxPWtTEMmKwPQtuJShL",
		@"jxmwpAcKjeDgoPlFpFCjwmjZgbvaxysSynepeMYfMGXIHZAZqbDlYFFiqueYgTccprHxZAQVLKWjcFvyiZLHbtLwFCwTBTOSVIpfTrechJGPBGuk",
		@"wrsmnPXCUvYihKveLVLVhDYVHxPaYClRnXUBMFSRuQsyJwiggzerywsmxNYyEkUMKmMnxZjUeGVVWgGCokvzHERHbOBMTPGyCJAhzWkYTMNxrSSUCENvdJhhclVkRsoLiqhwGHczQBPwokSmSsNf",
		@"BaThRkkfPQzegRFImWUfYHyGWVDYjzvvJjblsViftYcdcTCEelURrArGdgHiuLtoDHvHiXbPGiUDxaoQFYqTdYqXYKRbvvkfjRAAoUlj",
		@"orZHQryPKSolKwjEMNkyGWxyanYncziNchIPTAEknfJSuyAXFxZqZECfltHrJORrdtDDpEQESjSGepwykHWcjkrdGtoICHIJBjpkvpkyjnypmyVDiAMLJuIOCQaSV",
		@"KCDpGxKHRzOMIdMSgHidGskjNbCkAKZVDKVguVcrtTdnUnLprdsuHeWVTSomtQlGdLLZhDUqfWAPqbdDxdZxZJeSDjbFkTHaDaVauyYmwwNFI",
		@"UaccEZeMXJfdTgVQzprGHZeDZTlwWGtSnPqFqVxZXaBDuMEJxuUpmgFUHQotkTEoiZKXLRxwtWQBIPrZEdPCEAQROxTOUXHBdIWDgyIzzRZvXmHFughOYYFHRvhLigOc",
		@"rnuYBKkslySDaWMOcfvpshYboDumDHXbLjrOxNZKfflFUQfqqHytRScIWoTLEVECiCSwtTRwDWwgcAVwtkxPdnyOiRfHhfBhaaEbqOHutOplQSsaIPWxcbPBAjAMSmaJGTjeWAipn",
		@"QPhoTDzhmhSJxJesxoCpzOgzYslDlVHCZjqEFezqbUSpDqglExYtbHUUdrafMrEqEzPLJHZEgWKcZlwdGEWpVNFDMTcXTYpokMYd",
		@"zeesSOLTfrrmdjRUCtSvVATKuTkegGPIANoMFYjJtCIpSiYbgKmZMUTbNasSmViMLHSeFUeiRUUvppWKtqehnGGqEZnklrqNKfIrGDSAdRFSVziJcEFPAMzZxPNXPDSscOmL",
	];
	return vQHwaASSvkOYcu;
}

+ (nonnull NSArray *)cOnfrRzLOpAEPdpTlF :(nonnull UIImage *)OhGFVEtNUdRTYnRHmji {
	NSArray *AcvsuvfaKZZ = @[
		@"iCZjKnMDhdfuIppvLXqWHcfaBNXbDfULMhVJOyrtdtoUTyehzFBVhGErDHxRBvIYibkCHgVzrTpvMBpvwWONejUsYKqwMolhsgAVoajMLXUE",
		@"XwTbBnmAtrMjcuBzFHUkQygOjaxVlqQheeZhnRwdVkHKpkDnXgaEwKrAYPbEkjvOcJtKeOWAmvLWDEQFhZiwLoZjFpRkuGcjOJGMZjaT",
		@"EZTPdIgsMGGkzsZVwrKnWACPaMKsUTGOPKskZYmWwoSqZQsujbVtXDXuMUWhtRppMuqFMcDFHUMWNTlzBsXCGnhwQWVsxGXBmhWBWNGjHMfhZHYaHX",
		@"tKYGdecaSVbbXQIzSGbMkjaafBIxHMwaCDCmlJUbIFPMBUFdSntcmsoolEYavqIiyrGPmoacfvuBTyEErRnTWJXrYThgpRgqrzlcTGdwMYgHjVXPGmiSKJzFUnFUVwwKcTuJbkLNiEo",
		@"EDuoVnhzBtkqmQoBmCnUGSNmCJNuAmaYgIxZXcSfnUXUvwrHZfXCRRjUucGJENQLzwRcKrGeLYYjUSgTuOsXwKFGjkIrfPHELgNxMRTDEvhDQxkfBXTvtaYsIXKdXjLcPpmlGSOuDUS",
		@"LBDFBaILSBKLwKWGJLHaHZQLHFAQkaEMfGbMAONBQHYXiXfNMTucTLrsbtCkEKgjxiiluOjswISDFHZEVbOSjnSrLEsybQlAvpkYNWtYyrZxYCMenwdsBPmx",
		@"EvnYKWZnSyNlJSQfSjSCrlCKNvFedTCbNxWEcwAFKaFKcpcbvLdkHdkZZHasdVpcVlfRdpMTSmerTkLwWbrUgLrYFBJrCQYcInWJrGfUMpUFwKzEmKiZwzIQtkLAQVyYQbREREoiKLOkvXpX",
		@"tNqzlLYIpZqidkDOlXVOIuWccZstRWJAWXltDlIyrHgkPIdpuOuTWdCTmyfLBPmEeWnySfuwVKwDIEbAKDbyukMrYUwzCxJDpYfnbpfWKj",
		@"GVgssPdfoJDVCEJtaYQqATQRivMDKgwftCPJNGSnlZBbqoepjdIArkvybmwOBpSYtFzbTMSaUZMDPtDfVbXkvxFJwIJRQFMMFEAjxnDiGPWe",
		@"sGklYYEZFOsMpXYCEOoggNMzNxSSndFLCDPQJcAdagZmnPyuZgnNuDmfAtZPuFBdKjmjCunxzGqEUiPntczClWSbFMSKOLBGHLqXlJCPTKgxYftHfrJFVSfwWKunmshvoSfhrHmFYcxAWAXFIGQUP",
		@"xJcfbOHNBAyelthgSQEQlxuGOQtOoqNhqZjXQumFwHXttpMTYQXeitwBuFDIRYJvisnfKLAhynheWotAxfgGKeMiziSvohXbVVMMWIYzGXzzrcZJ",
		@"yIWHXJRhkCQjQtPHZLzGsNTlmdPjLlcZYZgzGZNMbTktlhLdeUSLFysSGbExTPVpfCfVgvSyyrenHrHyoSGbsOfyigMeiDYJvufobKnzvuXriRHsnxhkrwcVfyGiLdVnkaFuRvhUn",
		@"ilaMLtvxfMmeSlcybXobohJTyKgGOdULzKndhGVTwpIrSywZCThlAIvMqlWAWWxaFgrKSzTlzkAYWCZYHxLhjDERoPAZyGWustQwgDVmxRxPcjnLkbmCwez",
		@"NfjtaddaOyUmCuFWPSQSmDpQPzHJrtlYJTxVxQEtTfzvQeaLvAOlxYNgJzYSZiHxrQUOeIrKJzakijdylkiFpvPKbHkmIQxZAdyhLsVcNBPpPAVjTGOLQxQeNr",
		@"vPOreIwaWAuJVCxlcjTGVnvslZScwhyuQKuYHtqmHzwiHPTtUwLLuDKRysSOJSGRlmRtdZGHYnlOWXqpdycdkoCzBfnAiwsVSdHnGYApIYdGYkBgZeHUsZaUXoOTuxMOeTyvFB",
		@"yKkyrTBHlNOSoWNztSmfAapKUiYhzdMNspZEvfxtldqjfBIpAxBIpgweNJORaAWWBJNKJstedoOjpETQYPVfGBrGQKfYJsZtngMGstEfmiQVZOAsHRZANInKZmll",
		@"BqTqhlGpGoTqazWYjctnxouMBLifoSCZcWyguSSIeSJEGfgGDyoAYlMEBwryoNBLBNwBhuLTIFEiOvLeCyoDJOsiYxXSvKXBHfhllwSjbHwhAHbaTvnYkODcYaZMReNNTUVKORgCmDdNuEYojFb",
		@"cAaJOFMxCSnBeBtThJaPRXTwQbXDIGxzbkHfEuyWRdAMbpfomnSrEOGcHWPkRWQzYXsWKTgksLvOrzhaPJcyirtZklcLQXXnydqzYDsTbCMQWtxnahaHEsozooeoNJDNIsNRlpEdUyn",
	];
	return AcvsuvfaKZZ;
}

+ (nonnull NSArray *)HNuLNOLuafdcFvYpjKQ :(nonnull NSDictionary *)VobjMeNCVMhGz :(nonnull NSData *)sZCCtQmjUlntXkDvlK {
	NSArray *sqUCofEKBBzEnkSM = @[
		@"eAsFrVmlpZYfPFGQHlFedHJPDKrFxGIxfgyMaitiuZTEJjALbgmduGQquHcYhROBgkTiSgdavFsuXSCNVwEKniPJUGNYagVEclFpeqHnEwxRpOjcYRkQJleWaicDyZYxiBKHrCjvjbZhRD",
		@"MiMgfGXMjlckUfpqUtkPaDkkbSUGjMWEzVMHSdRlHwXgYZdpaOahFjWCBaUrWKhwjBCNlcIgoVAzLaFAXxPxlVdTeOwxodSZGWuXPYmBIsMpbudkXNBcYWV",
		@"ALEOrSiJPxlmNdbaRXGDPEUvKuAsUROwfcsedTDuimbDfpmJJeaBKiWZBsQQmJlqbkaMZTQJtZtGaHvIWhxWvlQTtHbUKvdLBLUTeWtdApENJnlJgwnnKrtzmV",
		@"XImWMYTbgHDHJYXOirKDObXWWhukXjcTijvmPvizQDSHuGBnYYvfcOPDqUSMflAGVmjkSbVWRIaeKVzBwyTlwuBuMOZlRfDxGeEAGoZ",
		@"PIbSAoezFjaYIHxHWVWFvqkhxZMoyBsKRRCrfmrGgbAzXgIrWxYEBdotfJyIXUSJBWpxXTcJFpZsimYORyiDOqphcLkmcXJXfnoKMMlPDuIiDlXjofzivCgOtPm",
		@"SXTUvvVHjqsXFdYJQNvpQrVVRhRmqrvNYsTrKpcqedcwSyXjpndnqwSDJzjuZtNtvgCVYHVznCUxcxWHuEkTRGJxKstrwyYpwgIeKEnpjtxBiQEtVczvVRZIATdBXuOyctI",
		@"iozHNxcmJevvpFINhFPbotYVVQUEeOjMXwDpfQxeiRKFuLFtcqKHiXRcmmQTkkjJfYdlDNHWUsoLawulfPjxgXvJwozIhwzrNlBEzILItkdtBlhqAgVIZIuNYfQLoUhUpzopIFjAfABGntLZjSJ",
		@"trmOBpOQVtXhefuhyanAuOslVOTFqhYZiWZZQDDiMXkVkodkFWSZVorVoQXZMlCJHGCJGczKhODiopxXqggRuSNgTCHSacbYRTzJKGLqmD",
		@"syRVlROdTondZhgCuUqqnOObYsesvCoXRQbvcdurmJIcgdEgXZQCTEbuqYgDifFjbdqEZztKXFGQNYeTUxQuXgaZfurKWSYSNRudluuijeIlCeTUQF",
		@"CdLJmrCOJagDDCmPktLIUUjqrhcLSIsULfVHcMIoOfkOsSoGVISxkGLfcicsSPZmetnvcgMgAuaVdyWboufEicZjOMdcYKBDDyGbTZU",
		@"SurxZeUznJjuErlRJgsZQRAFDqWCjfOaqwBSKWHYisHEWobqXIABarnzmiwDyivrKTaPMZGzAzXTrdHVMrhcrkDdZWaUDRrTDRBdi",
		@"WvXSeqshplXCwWWdBjXrjvhWcKvVVjDgdMTVhgihXQrrfsbZnxyGZhBxZYNWIQaLkLNeTznblaWOQvjSTJsVSwWyFnxThvRAAItohpSAWuGcxvxWByWx",
		@"WtFNbUZJhbjFCbsWFgXTxnPDAxTsdeotkxToHNeLwYvABYqTqWTIWGqCANIgrSZyNKdCkegTfZeYtQSvhcjddAwNBxznNWYpXfHEDLegZjONKqgCCGfcweOWImphIpoqFiRP",
	];
	return sqUCofEKBBzEnkSM;
}

- (nonnull UIImage *)mFoyKBglAWwCIgADcS :(nonnull NSDictionary *)oBRmaxWvoQfHz :(nonnull NSDictionary *)IkzPMEblQsKxA :(nonnull NSData *)tDgdWgQLGiWaDOJOOqF {
	NSData *ipynFKBMhUydo = [@"uFURbHXrgFCvMJaoHWgcKDyHurZUwUcBzSeDzskTCbnChsZmGcWfVcdTRhvOJPAfJpwSopThquHdQUIofHgwUxYtuadhhRWTZGmYzltZLWvojEXFDuMRZlhuQXahtFCNjnADtSh" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *XAXeIHKMKZER = [UIImage imageWithData:ipynFKBMhUydo];
	XAXeIHKMKZER = [UIImage imageNamed:@"NRoLcNnzNvggqBSFYjWaSrkOewUiojRtFOZsIjwzRLkUJpwnvsiPaFeLteLNgfTICmdWMAPjnIomZcouEXpxinzIqVWWUUGRfhnGYvrClPOAVobsGyJkIDqRDSkHpnCYk"];
	return XAXeIHKMKZER;
}

+ (nonnull NSString *)UQhzulvwbBBv :(nonnull UIImage *)oNtaZlBlafCp :(nonnull NSString *)EPuwWHlNUJSzEEUToTI :(nonnull UIImage *)lzZGvkfQEobERf {
	NSString *TOgZYMMeUjZ = @"DKQWDBshluovPemZQYWsndEvWRrOQChQQBofuMPIztDMrZHwUIjRozIMbgotRrRwTYBFeUZBHlaoGUraWssbZveOjCMnIYteLRWwBKMOoCyFAqTgQiUxTaKJMhnKpUBoONkLGxW";
	return TOgZYMMeUjZ;
}

- (nonnull NSData *)EgCoXAwBbrJYmxpDgeL :(nonnull UIImage *)UQalVVBtZFe :(nonnull NSDictionary *)UnWrJWSHLpTFqbGi {
	NSData *yrFqddMhEuzLtuqtjzO = [@"gUMyyZvIhvRWQfXKmQKItMWFGLhGriMPiBMOziOvMMnmBPxeNBcgYozvOZNaOZxehYZGiNTWLniRmLIXqnTfeOJhYlJQFYwWeKDhOGBdFGEXWntpYXlmUXJ" dataUsingEncoding:NSUTF8StringEncoding];
	return yrFqddMhEuzLtuqtjzO;
}

+ (nonnull NSDictionary *)ITwCsmHInyY :(nonnull NSString *)uBfjPHFoXnXheKU {
	NSDictionary *jbeyMazImdfMzC = @{
		@"aUbTDWRLeB": @"BgWkiXfsCbvURoSODGnNUTAgKScgmgIhtGIkqIuQoYpGDwLsfupMEDOXAaNfgvRbOhMmdzsUTqQOjVPzclchgejpprFkHiRDqTgPdWxVeKAwd",
		@"GGIMTiKzmRSceh": @"bMLwRKuJaEmaMCRnLkHBDLlPyVzfULmktoPZuGRCZYzvSsWkwHtcKUESAKhAMLcRDuBgikUFnNHojbWiHImlyjugwJzbkBxfnkinGvQMTHtnoBeTmGRYMIlCvxwql",
		@"TBUknHQjoL": @"AEGYVseMChvFiEpwwbyIWPbjZAoYPDboaylYshqJIHBjqEfYezYvRmupqfJqUyLelCfwDYDURwigZaYRWZbDIinfElDWiGfnfBxWDxVXLizmvCLqqCPbVupZhZVWOQBTIOJ",
		@"sfSepUthvpujc": @"lRjOPlFqULYSdwSPtNjJlCmUKqCIqdIvrjCWkdJwFiwLUwtwMJmfxPkAphHjxcVlenLKXyYMGXYVMIPDqDtwCPUfugxkfoZEDGKzWAKTdPBinMzcOiY",
		@"LbWevGBwyNs": @"ZsIpEkJfqvHFatgXJtOfTzubjBSatnFWkKnxwDCGOVHCKFxtZaApxsXvKBTAPtZiSQBZfVZgqojKQdDxKxvEoxacxnmZSIdAbTODuozzhEjraIoqmAHrQoYbgkFLpuKpETLguGLJFSTTAkwhHcp",
		@"TxIRZCeplwSxbl": @"pJotYjWyJKOiVzkWSaIdCxJKiNCHObEeWMmrWGiLwWfBVlUcSlDonHVlXdFTfQklILPMCpRpfucSNMYxiFbbvdKmgYWCfkOLptAuMuBjIsrfUiFaAjbYCJ",
		@"StUGdHpOLRkDVBTr": @"NWGcPcHvaywcnIlrCiEhXquuWZatRxgZEtXWBpPzDphWaJhzdUkEKQKnUpUryhxfSuBxgLwZdCozcoZutobJQxSnLPZUBalqwfFesHwluqgoEtIbQ",
		@"JmMKmDzyTzCBniYaHz": @"APGqWkCMwrkABJnFouQfFnSPhwEAOqdnGImpANgYYrmYzABiOOPRZDcaXcWYGMlfbCRSiRpXaDIwOPgNyqTCxddBjuABZvvDxfXzLgQhmdlM",
		@"NfoyzbDEpnApOwgLbV": @"xCkSBqUaoxoscRSgIHdaeucQFbkFSijxsPlqwEzihfujQspdolhPFBcwqAdIhdsGIIQMxzKzkhpLbkMPetoJNPMdYnEGFPjPdHDiXTnyCPUMqcaanLwlBguFMBEgkhYSy",
		@"TgExaySQctC": @"wsvKUAhRaYKlnHemQZQmsMtESlOPpJwGMqPCyBLrzUHIGQERnWMlfnOkzwBUVuPmjSiIZhsexqfBpLGWgweJceZgVGRTmKpJHCnVfrSNDbDMpaXZauhkIBXvJFKXF",
		@"lXgXTyGAyYm": @"STpXgCdwKYOOCvBCXwIevMqImPdgpeFnAGYQsyfrIIghSLSCdJOVWnAXVNNxRnMpVIrrWdzKUmFzquEBVTUqEYqhzqBITWLIosUAYWbHcwEvfRsabTFNG",
	};
	return jbeyMazImdfMzC;
}

- (nonnull NSArray *)wXZVUnlDkCJGRjo :(nonnull NSDictionary *)hlmxWSQrjAlYyQpLrd :(nonnull NSData *)RKdpVGUlnVZpiB {
	NSArray *kqghIvxiIPzhXkhD = @[
		@"YPIcrpynsqwzpyrYbTXEtYhPoxlaseOGePBpgJHTebTiFsTvElWyxNvRDbjNZpXbmgFXJYLgxllxRthSRbMJAdDwSuYVrhbUTXmYfzcKlxVqZlUvTAumCtLcBPkarLkcsjYVovmVJNtwsxzweCs",
		@"AWoRPbLlUhhISbFhdmFtwwOtXnpzxDVqZBGzUVtLywzfYgzraaodsGvzuLUpDdJxGqTgWawfgfNQnezhWGxvpjOdtRFBKOeBGNyCLhlVWmTDoODDSBPWkSKLZsLTIujGrnDSWBJQimBYN",
		@"pKkvZTlBBdfAZAUKBVkLqyyJZzpUUaytUDPHOiQjyaamuwyeOOpSbooQzuqBsOQOIrhXWIhAuaFerOpZksXJutxTCPRmFLXWhnJEOoGBntMpWmMJFQJhUUThGpLOK",
		@"cipbMdqtRTpTNdUZnobEydolRPOadtThHMkVnhpyaTzDWTfmzzRKEOlqAuFImaDMXirmWtAthqmXzuyWSMyJKGBuOiiUbwbxZWUxcFDmhMouqrGvuVgnfD",
		@"xJoItaquWFGZTrZwKbwlDPmonmFccGCRENkqqGYLrCsvSAsZtnnFciphgMHYxYuNUraVzwZzNPWUHhJCOaDpiOnsdNhPwgyhFjoflOsFUcpAZrEDawikCqwTiCgMSoSBVhaU",
		@"clKBOTSYLgmeCEWAdbrXBbwCKmtzygAGJsmYVLGoVurTkQEXBltYpmlwCLrkaYBCqcKztKElfvAWYnLbefdlnOigZYgsSIqOqWmRTztTZboGqEhZWLtvCaTfYJzRcQKuxEoDMskmKwSioBRqcnXLm",
		@"gkzOeouuiEfBdVOnYekvMiFZPNhIbihnltCKNsKjTKmZQKxkajorFmDpKZaGoIhmXmyYYwhNoeDDJlakHYMXsWEAQvNYpvuHLEJSv",
		@"OYFiEeOihcqMpzRWgynZsxyylqYlCwGvBSWYdWjTVcoGPzPlGmGvNKuRhlhKDUGGTdLKlWBfArMnkWLcnoGpKdnTeRccZFRPOlwFyHxisCCLEQGuECf",
		@"EzWUteDEpXiadTkHjNAaEPUXBiAleQBfQMrOjMnFPclRsjUsADFJMdwQLnzPGINCrILHiHIVetvdzUpuyIbaxXMMcDvsnvVxzphHlNqLbuagd",
		@"zBHrdBwPVoKbpJUUlZGGYBfyQGapdOvSDMdSMQpqIEmSxmZFVkyzabHOWUHoDUHVXjGEhKYIrsZXDnAUNyMljcRheqHWIteQgnlgMewJiEhBnxhckvXRltqPvYNcVsXoeLSmzdkKOMVhGVpYbYh",
		@"PcwBoBrremvxUnFsHmiVItMqqaGrIhoocfOzdFEVJQcopyMtKsdDFgpDqyNRDPNqbjedovBIDFrjMlAHCEbHfRZtuBfuhPjfjDKJwOmFCqLvUzsqPZXvwzWxJpMerItu",
		@"zAKPvuonlocUlgvzoEOETRLYaqRTjpjoRqoJIclXQknbWntdVgewyrQFhDSLZHtunakghrywHtyNLhOMVcouEwuJtjQmwzTYsMYqGsCDryTgbtGCNrUMFaPfxfLyTVoOnj",
		@"lqMamiJPBmtFzPYIrSFSxrmHlWbDeHaIxuoNXkLXBGRqbWidEoqqqwbLadGVvzkaGsWNooRTQdJUKEOjFsJGNSintnUSegYPBIEeajonuSXaLbVvbzQuxfokG",
		@"sXShcoOzlbLfrdIEdBEKUbChgDETwjiFDseYHIyvhZGJLqcXDdrYDGeQevdAJNSwqgMQcPIDiQWRssDQTasuNVxipsJEEUXEQphtzgQtjWJpDdkqamFqohOtSxtDdIHt",
		@"PpXFfkVmSQzjLItDUAAHSWczPFUOSRpDPwrQujkbrWGMeDqurmiJZuwjlXFIupGpEIMANxrxextBVSvYtmOsPXJbtMaVZplFRfSayZdJPWfrzCoGuHYkUf",
		@"TqhZjXgazwgtbuAVxrrhJbnGkoZxoOjPfKVbjtoBRRifdWGgqDlwFYYexJjuFiKBXKtzgOtAETvCcEEcObhjTNdJhQJihpzLkPkFDQzSdoHgrQBONbGKX",
	];
	return kqghIvxiIPzhXkhD;
}

- (nonnull NSArray *)RJnOyKMZIn :(nonnull NSDictionary *)JgbfIIwqzvz :(nonnull NSArray *)KCSIHPUytn {
	NSArray *wghqoEOqIRxvqC = @[
		@"MGdFyNzUtdOssvwPwbCgitYAqMMPXMrZwVveivZLIXPdvtBrkmthSUZqvmcSXlNaMVwKiEWKgEEavxcybHzQHSxNZrPvuNxETRSLITWfsWzjSgovOuGhAJFnxK",
		@"DzRHlJXqXqqiKMMrRtdISXFeuMByEDcjGORoLadAZxmHiQIzfEWLBEBMtMvDsLHlGnFgqAYYXABSWmuIGpCbSkHQTCKbXvqXxqqoXQurXoFuxZwHEliBorrDBugtsSv",
		@"RNcXzxXqeElCdQugzpeDftjPsZhjYfJOJeeqnQbvYIcCXqSnykwHSJiZcFqpCoUIRlsbTxwBbSoTXYTieMaaaOPfjvmKodlHvhNmcLWgNnieOOAimWjPVrBeGnM",
		@"UaaLDpKldkMamiLdRmJfrgJqCKpIdRKXwKyITsTDwDXpypKmdwFLXOQYyfCFXkicQkEEuvyIsPbLSdvYIPZvBRyltNgCkdlWptUKEVEaZVSFiUiXwdkMYTfU",
		@"LbeGkaSauBFLewKnhyZfHQEMSLTigTGGSdNpWPGZpggtrcODXpayJGHHAvoMeHjpjOsqvIbjgIaZZLzrsWEJkCDPthhhWvEwWToNHQapkcULQsFkyDkExgeLIgzDrfAkMhlNBafBeUFeqQGWhF",
		@"wWDfEBqYpcTAuQKxLHTIgCnUtvzGJyKLBxcqSxKGWRrZPkpxWpAiqdbojFQlgMxPFcFfMtcfuZdQnvDLTkzitapGBkugvtEjFNsTpzfNsudlvLvRRlYmQnpZW",
		@"xTrkiJEQftoPFGHZsvmBJvKYyWKQTXwBIWSeHlwBpXFxSbzeoIgglyYYfQzTPxUmymaBZyIImyUCvZCNSRTeoDKXYrHYZuBKiWkjaT",
		@"JXFTApPSYaswRakEPmHbLGWqFVrXaVVpOTEmpZDdoZlJNxeOSTZTjEVtpgOKNiaJhcUBoIGbZWncywEAFUranPJSsbisUfyZCSXKOwkVytANZqEmtIsUedqOeqkyHUpwtUQcJiWJ",
		@"quysyMtyEwgicJJnyElWEJvhnNsADNDehoKKhcQQRlDyFUqSefNqpvqGCsZiCJhGxZMMzJKqcTKYYtgDaGuFIPONFYfuwLqkdvOCdOZJlOUOzUdyfBLBHwrsAYLCNyIqdfqhKiKJGJQx",
		@"xkfHulfizzCAeKjJGhDRMfBaWqvGJIDomRHLbfgLBVdDUTnJAuBWkGYNruZvaHKUfOYrnasbMuYOrybufaMuzwOFxEjBSOnbbQYOpgvOLxmUtVtAyUhHPuTYgfvOL",
		@"QRgVsLmeulbdJQfYrDsOlJHBFyOeQbFZuYsPPhVoHQvzDlvJJFmsZCjRQOskXVujGAsRXwAwgbSEGbAfBhIayjoJtXSvAwDtCtMM",
		@"sgwpthXMTiYyfAzdGCYzWWsRNdaBueaUtXYPgGMFcByhxRpvSTgtloEhaGznQIaiRsuGKNMYYfxuLnUQKqPsDpxvESmSATvxZKyHtzKdntV",
		@"vYhRZmSiyBvjlXDkbXqzysgrSUdnToIXOlsJwdrGxalFAPMmQhTrXZiqVyaXjzTLkfaCyDEhktYesgLPoVcxkBsPRdxjnziCTUIMFGTnzkNxUAyIWQsJQuubmYRRTGKoqlxAOHkUdLfS",
		@"tkdYoWaWBOiQEhZalYHckPWgPytztrfktLNrdUPHgbWKlhIHPmpLqYuWFSMEKveiDoQlvQHzuevrfkjqdypOJYhgoYQoBOReZcaxDsDtsnojtEdCVYXMkbvEbCHX",
		@"EdoVpZuFAGEOjxZlagqalzzbXHRXPAzRLBfZsqUdVIRiPlQenTAnleHTeMcqILWYPTLFluZSRCsVtqOIzCYrEVvisCTteImjFPVqNIrJKRzVvoOdfpCPsRmaXb",
		@"pXoZydxIhakaPGINXUDPNSoXnwFNRZvaWyhyySfmvRDgSiXIVLAEklvqIJRdHuboBiANMYwHGgXPfnrkCvpqVhJxMSGPGEyKLsrxvFYwgnNExcI",
	];
	return wghqoEOqIRxvqC;
}

+ (nonnull NSString *)mFkTRmLBHKIGhHD :(nonnull NSDictionary *)sMGFZGwkYGtxFfo :(nonnull NSDictionary *)ZALwCxfdKqUS :(nonnull NSDictionary *)TAQWnjFYlzNEpmD {
	NSString *RNhgrfBNsH = @"EEEkAJAXzEQmkCmIuzfCpkKUnUhFMcpVjLsAePibHMnpZzieBjWzCiLyQnrILVgPHBNHclVNXhemKhqgunzpQuKJKzAHkYZIhphZCZWAUaMQUidHkuFPoqgvpYvteovC";
	return RNhgrfBNsH;
}

+ (nonnull NSString *)tLRDZdgqGjQqsxCisZ :(nonnull UIImage *)OLkgorSXqggBMCt {
	NSString *fLfZSeSUeH = @"apoqbGZyJjNbfwfMwsGwQGzdqUfdNDUoZVhHVuzVIfhxaVvoapKhVTHRrrJWOHnGocnVIjKICYZawxLbXaflLViDWZGmbojKtZZGoCChkKwzjlygaeHLOEyBGxsVYhdGvEHGoeCDGvxH";
	return fLfZSeSUeH;
}

- (nonnull NSDictionary *)cKafEjJlwunJYSvf :(nonnull NSString *)kpSTkAqhgu {
	NSDictionary *rQeOMPripZXqLjbBoaM = @{
		@"FsTKCzdvKMbSlj": @"QISknNxxxqJuijZIdTFXYantmcFUJEsMOymFloRyuStmyBzEfMOkRYIgeXgRqwUcptKaoewKtGInssATolmaULKGvqivIvUzhRYsoYkuwZYlayWsvUdt",
		@"EjXIFGfHusECekYmQZR": @"pHkOxWuYPBAJmVcHevuDHMxFLkQEArLtAQyVnMaNoVHtCXqgWsBioFsLsEIZEJmGkwaLJsleheVnZpaRGoeGPGzoKLeTpZmilUfXNsybPahG",
		@"HLwuiESpjDYG": @"DLEcWwfnqGKSgQpnOaSVkdVAAIWmAupXIkFdTempxcmubrRZUAsFoNednQQOgrxqaGbZjqkdjfkqyibhHtiqrxzKvwGtroibDZQtwAgvDmMRCCsivKdTqjyEPzbBYvtLMPnYxjRrzV",
		@"QDJKNLfcCr": @"VvEzAAEAmPiYkijqDjBFbOwHjWSvFxKSLTgojoMEzSkymCrFIGaoNxHtZglLFCBJKRimoDEuFGiRqztHdTLchdrHGbgcLKjkITgSbPxxKAckcqxQPIwXujsoQcXyTCsYGw",
		@"CvsbKCehmCE": @"OQbbIHybxRGJsaFWDcLRXUlcjPbEtcrTEgZMxOmsEkfSoBTSlIXByBExmQECMeKpcypRevfzFDiBPMkCODckgBizVtihhQfXJOvWVRJFPPDTQkRhvmUKGLrXYHjrfhOmVEc",
		@"UOyeFwDmCyhJAOCe": @"tZhfEUlDUnAhMYbhMKpWgsWHAicmxIPadvULkXkvoYXzrTongsZGRDLiHBZGZtwnDFgeWvvMembhQJqMIrWvqNcwppdTpJzQlDsbCFrtxiK",
		@"GcxcrajxctVjFU": @"XanzLWHDXplJBOHiKLrcWaiUNKBymqERbDMpFqdMCvYmWOJoCHcdRDnleJXepbLpJRoevfOEKhnkcWOdoVAZpksdOrrMZpLghKsrDRQFAFvBghjscQBLCGiLisunQrSaqicvtGXehRoWcCun",
		@"uyCPkOIprvqfyYIfQ": @"PgfOoRjglKKgRckiIykdQlDkqqhnfJLFozSkjZGdUvvTOhQIZyZAAlFxhUtFRQyCTtHJaDzUvsqtAqGIpfsqySOoLiMfDqrySFVGfFDifrMkiqcyebLFS",
		@"KkcwHrnXhbEbjgMgHmr": @"CmxXCBhRxgQbpQJabWofoeVmlleDMDFaeLqlbzxdsuipcGiVNKgFaoyeGKnVfzoUPpnotReJyMTGdZRZRWdYSfPaDDIBlChcsWpnsaSkrMKMsXaNwVvJEPUrbLcfCWbA",
		@"ZAyEAqiMUEfua": @"FSfyJQBVECfReSEtWiMOCDnVfCAlXSQqikTaDbHbvkHvnuzPxTmuxuXhOzyqfPVVysEyzPaqAEcqNMqmxJAhfYJVhlzUMcVaCgtjrKhWRxqUEWUbZvIKHWGKJYXLrosOSfjYGpIsMuiRuRvScWl",
		@"wBHDPlMdpUcU": @"VQaMsGskMFzSoHbTmMzQQpvPirlqabqKFaulargEVTeGAfRRGoxGYojTBPDYSROZjVLSbIDeFALWwafWWRLAxfacltoEgAiqOOjWKtdupzYLTuwDDBxlNqsrelcISwkPuLkZBgzn",
		@"EHwnqVMZZmQKbpVCGZT": @"jWyIJfjUKYKGWVYAaltrNzMybAnpJQXdzfZXAtjThWexqTSaRGCFntBvjgDPFVHUbAPtiWNyYXhWsUjHwVzetNrPLKdxKcjZUbEjB",
	};
	return rQeOMPripZXqLjbBoaM;
}

- (nonnull NSDictionary *)LIJdRyzFCXWaXeJ :(nonnull NSString *)NjAIzQTdEqHOKxQriD :(nonnull UIImage *)JFZMguRZdibzHBVy {
	NSDictionary *PpWAMMhnnFl = @{
		@"CxPlegmHdFXs": @"XIgBCQcEZkagRMHHnxUoGaIezuosgOKlPfBCilpPwZbnGYZWtfCeSdefOgOALlMEYOooBufgwTnbqNfZpzSdUCzafRUsCUZwHjJDPgWKCETCOauSPqcihIzVkotdmRbZyudtgoCtbXmFUxQylmcB",
		@"cswgFTUGhqfRwe": @"OcjCRrXbDTZGfIoJSTANAaXcrqzQuvnQpGxtxVIrCFFAYtWktkyxHBWlAbzpKHaCIiOHXKhpLydUgGqBiAySqaIxLgVqWbsKYnNTMsZNXCseGxdzGZpmwYbohUdOBcNEWYSbe",
		@"SzBZkkNtLjxSyj": @"jnpLFlYNbWNqYMYVvqkryZsKCutProNclYNsamxyXdlxWSzhgbuWKtisTRPWwtoDNAxDAQvqWIvABscqvNZnKZoetEdCmzSpaCGQQW",
		@"mZajQWlBfVYxmWNRA": @"ammJxAsoEDbPGvpKqfYybsSkIHlNQMkLyUFkbFavhDWnrvYgPalAJONgdwUCBwdWjjXqbYGOBXCShHapfjAllTIVPbokfnQDSIlzqrHaQLoaYPvyZZfkgXCFEA",
		@"tywHDKhmOeVkcctgz": @"htPCEWNiWogGxCqWQYksxCiIdZQhyxsauWFnibFQxAFcYCOocPvSbfPJguFmTLRqCZGebKUxjBxdzPUwtDVWOGpBFdlKJuiHJuFBXgttXJAeGKEfZQhcNSRvMlFBHPKMKvSIjSMyT",
		@"mwtMaygoSvgkEZZ": @"CTAriuaLFaDSUyNLsiJuQWodtihFmWDdQgearhbsBDYvVNSyPIFzEmnLuXdSYqfBsQmhecKJdQAOIvaNciicHboZzusDRCNNqSVTAkBcLIcXpPtmOXFmWATTSMQcfZDtBkjwyDat",
		@"aJjZuJUSZc": @"NHxFTqOIAZhSrvavRlqpQVKRsMvFyuqHrPvuIAwsbLDZddKttORcGujZfuwJRPZIAyHqpeKdZVahwwQRVzclUqmStTuGtyOhaMBltvFyJRoipEnJkPdqdaLMEOoBVkTCldYvXhOEE",
		@"XYZaMfEvQfqgUA": @"JTACfcBOXeFHLWHkGxpbBNqvyLbjwDcNvURYIsSAXqgDgOxWhfNOdHeOIzsAJxAYYQftJhGWfCADVBvQHSdSroonntjbTxZpSBQiihduIs",
		@"nfxNBRoVcJPxdb": @"hIXYndLwZETUKLHDGWFhrCPVRVHJvBlTGxWYyAaCvXmcJkPRUKtcthFtAEwKZFJDADCiDpXgDmwIGBBTtlCRuqljSaOibblFUjZLtwtwgFZPLfRlTiNlgYzGeflTVdUMQzsthWuGaJDKeIvdJ",
		@"KzoAUQJWqVY": @"yOCUjPZIFCSRykzItUclugGVKZoiNrKeiyIMJGcfNHxPhIdtGLOKvvayRHbqqQJeDrUysmHdxwcYTIUXULUptgWVgBQpqdiJzjnqiwxnUoWQXUPZogszjjdS",
		@"PgTQDkhzpbqRjpANqz": @"iVdZQMMDsDJjOVMFLTIlbOiYLeLvJkVJAZSYKmStQgmUjMmxEYOcbSQqpxfmhbEyjzFVnhAbzEhrKynjLOFGfHjEDoHQhcspRGHmobMCLbsHaiHrise",
		@"gNhfgjoPUCoLHoULaf": @"yfWepYIrJOwOBvvJDcrkYGEYQAeBTSeuReaPmowmpQqRyfIfHPJLxmvXjKTItdXQoeezwXNZPpnIJQpIoRnZAGDtxLePAfEUZWvFkbgMywqbNTmWH",
		@"RnAZYKhSng": @"epgddvFtsOdDWEfBBhqpJkjGuOrShsyDEJwsifkbTHuNuuiXmMujAmEdBVqtIcBIRmmlVcqRdSisNDzQcpSAdEerQzqVygXutTpVpHwQuZHVLmWcxcfExtAvnomEzWOhvmgvSuQOIK",
		@"XSYHtepPyKDqscwbYa": @"rvJyYVrFjkadoLaoskxEpYWQNEgpDPqPNogaGdGDRifPdJIJxISweoVHPYFzdOOvtyjGIXCYcUzySJXoYJMrBMGIdSTAhMkQJKdilWxresNiyKpsoyHLCBToqkTkC",
		@"MAzTgyxPYQUUovUS": @"lGpwhlKnjnaUcJjUDCaJkdjrqJFxRyjoVzUSGzszXCpHROPhjkoaqegNFacJVZRisNroBYiUnjWTCsdTUtImMOfFFcKhKsXizzPuBeYGkXGcxpmQgHMlpHRBTpjjYNATZ",
		@"hSrqBLNGKTVmHQaKO": @"UZyHDwGXlTiWuQBvIxNgPnjBJMKkfBHgQfqvZcGZKOZoWFfePmRkRfQJUgtNhHVmKrnYLxcopesPfZAhaQYqRQFmoUWSirbHsGqrljIzgoopSTFHSQnEspxJsvxpxVmDQVYvLRZVbsJSPUy",
		@"gEGhrnRuByEgxDWiGHM": @"mJBfpETEBaxXTOXOeNZDoQdvnHkHRhlWWOWrpMGKnONVgzYHZDQyJVLEUzyjQfzTyPwVHdwyPrkudMFdnQEJHUiRzzYGmZObdWlkYtwSWVCgiNdpuTvOKuWoVQZ",
		@"BMqdvjgDDvuyNUfa": @"iilWLRAtPSvfyHTvubmfzFKrbDMJcKFRSkXebhVlQMkfmnGJxyffjzEfUbuKnymDWbTlWeLypHnzJxsEMgNJwRZtjUNTYTlOVzQaksfLcsaAzgHVTyBSijcJNHzcsvkNFepunbuKmhW",
		@"weRlQrjZWmAEeD": @"RnDwnReIgjbNXqJKxJYdAKEkanRJaTixATRKycchjIIxoPIgYOpzMdgySONdbyLfRmNCZEYDYYmwrGCgPpaaacGjdGAoOJzkIqIfeXbrdZcQEJLBeYViVthMR",
	};
	return PpWAMMhnnFl;
}

+ (nonnull NSString *)bFTSPVGVdUhq :(nonnull NSArray *)UFAqEKzfXpdwJTW {
	NSString *BkbOaqegFelAjL = @"aYroRdizadRqSwqZFMCiZJtdJOzuOWKCkbGoQAOhgpWuIEdwoNzykIOptFAvKBQIlASOHqAiuoTVWtxvHPMGiowVDCnOvlsjQNsxKRxSGKLjnskzTxwnGcZpgVwx";
	return BkbOaqegFelAjL;
}

- (nonnull NSDictionary *)jSJtdelwffgoJA :(nonnull NSArray *)PJstTGBYcYyoSe {
	NSDictionary *BCfFpQWAQAgnihLV = @{
		@"saIuVOpOUuwqoFxj": @"OiSnaXGNcwHsumKlUmSzShIhxfXnFxnsAduOllJUbuIswKKRIDALJWomUYQCqNOTYYEgoRUKyHauIWIvcaulChGAcBUTOsORkfNGSPEVlPmqdxpEKzfwiWPRIrIbhekqacKDvQPBinSuWuDq",
		@"tCnRHIgfXQmYwWOrp": @"zLkLKifUxNaFSuxjAirFqdBMzwpkiQWolaYgpkdexNSmnxeZzojAWRIQFrSyUSqhintLluDjZsljeqOigKyvTotnRiJckBcIujYbmfPAdkpDtLj",
		@"tNXwcgGHYejGSvJg": @"yJdgWQrVTzShzWBfYdczAMDQfpujlCJyUgOIHMdPHIebLqgmvFCsBLMVWPxfeHVZOTlpNwpMGyQeMUGUgkqRUMimUtkBVgEuijfC",
		@"ykTUYLIZnJLIdCETPZ": @"USVWzRCrPjXXwswBefMAbPResFIzelWzOCMwjEPFewZBMeAyzqekakooffkjomHVmGYvVWslVQHIDjCMWFStMmanhDatmGXfikHUnVULexDsgFUgNbkWFIFqPvzk",
		@"OuLjhLoHBcjBrUdxD": @"RNeLuANdJJYqmYYZBMHWJDALtMzKdbBSrvHheRxrWtiBJiuCwDnUIAfVEfZmAKXDHDQgdhtdyQcWlLVfumHhluhPRxnmlAAbjOETgvchwKNlsHHCQkJVxqVQiOvvahQPxRseInJGt",
		@"valsiRACPMjRzTh": @"bkzhpBwGCXwTrqjDDZXYMOvMzHNLSzuPnnkGWTVJkbBpqMSilJPvYxMgaVpQWLGDxPrOIviOJktoQijtquwbENtCICjYtrWYsnVfyhR",
		@"GUbojKNdgYFRekmiK": @"trBFITzkXRAgbIOCDxRsksMThJFfvoWwZLVkiwpWacDfZdoCGFwBDkDegOCqDgJpaegFaQxPVNFYvvFgyhOREQBZaNBCiCuNXtTuYWxhUJOoAqGdbSrPorXiCcNJxoRQbcXAqUheBS",
		@"beMuORsToSHorZmqizx": @"ebpSLghFtMAbxxttBXMHozrrrzufoiyeIKKQGHuWfrjsWcnIbXdFFUKnKNzOkanePwptqVNcbMVuGnFMQvMkGMEwIthSCoGnuswbYFtUEwrzBWCWV",
		@"RAIoFJBZOVaQQI": @"bZTmSlUZwndGPfrENgfYrhKkvHGRynExCzzLfTSVjTreThAaemBAzPNaLLXSmQhuswzbUtqYifLkLXDcTuhyruFKSMnyOvWvLxXjyVhFKlLjKbOmXBbRcQHCZDUXHb",
		@"LGRQEmddOOUJKgVbKvo": @"KNiVwsCXYGOvarvKwReTIQLYjkFsnGGlysPCovEkQyWprzkTWhuCUsqwWvZVHYZsseeZlNQrsQBLcJlXmlkXgXEfeGYbAFFzUOeyXcYfrdIERXdsFJvdIPFoxxiwZ",
		@"GWqhcDmETR": @"jMXOWzRjqQIkNczjlzaqomUtaCmgRqaSCuAafoVKoWvvrnmOwTimkMbKmqsBHSwrwOTZFfTVNpEPcnKSeRlXrnhdBDWybfDJQTSYnDGLNdAVDRaimY",
		@"GENsHZrwEiNaJKCZ": @"NoHOlkaVaSlKYjLBNmkLCJcwFDEewaGCogCblNJGntYMSCtryLDfpJbsAdyWAiXaWUCQpOZBksyPBYtBNOPGOTVetWOlirQoDXFeiqNEbuZcqOzRhnNlshdbgheTzVfvKAoD",
		@"JQyDCAJZVEJJegov": @"oCHFaEFMjaTsupkQbnTUyhgbyCGCYOGlRWWTTXIvugLVNtpyDWrsqiopBTZmVzrQMvEHimRyUaMgZuwCpBPDGCcTGJfHfAzqSLcVXEeS",
		@"yYJngHbRoYGpZoP": @"sRptCxDYesSIqlaAbOVxIOpRSaLNNkhCOWXFvkrMYljkNPveulMLadOWINvjZSPTgfdBVtNIyTnQLvIBYDRgoiWEIAeVEUnbMdiAE",
	};
	return BCfFpQWAQAgnihLV;
}

- (void) btnClick : (UIButton *) button
{
    button.selected = !button.selected;
    if (button.selected) {
        button.layer.borderColor = GreenColor.CGColor;
    }else
    {
        button.layer.borderColor = [[UIColor colorWithRed:170/255.0f green:170/255.0f blue:170/255.0f alpha:1] CGColor];

    }
}

#pragma mark 自定义添加标签
- (void) addButtonClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *commentView = [[UIView alloc] initWithFrame:window.bounds];
    self.commentView = commentView;
    [window addSubview:commentView];
    
    //遮罩
    UIView *maskView = [[UIView alloc] initWithFrame:commentView.bounds];
    self.maskView = maskView;
    maskView.backgroundColor = [UIColor blackColor];
    maskView.alpha = 0.5;
    [commentView addSubview:maskView];
    
    UIView *alertVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width * 0.9, 140)];
    self.alertVeiw = alertVeiw;
    alertVeiw.centerX = maskView.width * 0.5;
    alertVeiw.centerY = maskView.height * 0.5;
    alertVeiw.layer.cornerRadius = 5;
    alertVeiw.layer.masksToBounds = YES;
    alertVeiw.backgroundColor = [UIColor whiteColor];
    [commentView addSubview:alertVeiw];
    
    //输入框
    UITextField *textView = [[UITextField alloc] initWithFrame:CGRectMake(mainSpacing, 30, alertVeiw.width - 2 * mainSpacing, 40)];
    self.textView = textView;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainSpacing, textView.height)];
    [textView addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];

    textView.leftView = leftView;
    textView.leftViewMode = UITextFieldViewModeAlways;
    textView.clearButtonMode = UITextFieldViewModeWhileEditing;
    textView.layer.cornerRadius = 5;
    textView.layer.masksToBounds = YES;
    textView.backgroundColor = DivisionDivColor;
    textView.font = [UIFont systemFontOfSize:16];
    
    textView.placeholder = @"自定义添加标签";

    [alertVeiw addSubview:textView];
    
    //分割线
    UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame) + 20, alertVeiw.width, 0.5)];
    sepaView.backgroundColor = DivisionColor;
    [alertVeiw addSubview:sepaView];
    
    UIView *sepaView2 = [[UIView alloc] initWithFrame:CGRectMake(alertVeiw.width * 0.5, sepaView.y, 0.5, alertVeiw.height)];
    sepaView2.backgroundColor = DivisionColor;
    [alertVeiw addSubview:sepaView2];
    
    //按钮
    UIButton *cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sepaView.frame), alertVeiw.width * 0.5, 50)];
    [cancleButton addTarget:self action:@selector(commentViewClick) forControlEvents:UIControlEventTouchUpInside];
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertVeiw addSubview:cancleButton];
    
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(alertVeiw.width * 0.5, cancleButton.y, cancleButton.width, cancleButton.height)];
    
    [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];

    [sureButton setTitleColor:GreenColor forState:UIControlStateNormal];
    [alertVeiw addSubview:sureButton];
    
    alertVeiw.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration:0.3 animations:^{
        alertVeiw.transform = CGAffineTransformIdentity;
    }];

}

#pragma mark 取消按钮点击
- (void) commentViewClick
{
    if (self.commentView != nil && self.commentView.superview != nil) {
        [self.commentView removeAllSubviews];
        [self.commentView removeFromSuperview];
    }
}

#pragma mark 确认按钮点击
- (void) sureButtonClick
{
    if (self.textView.text.length > 0) {
        
        CGFloat buttonW = (self.view.width - 2 * mainSpacing - 4 * mainSpacing) / 3;

        
        NSInteger i = self.models.count;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(mainSpacing + (i % 3) * (buttonW + mainSpacing), mainSpacing + (i / 3) * (30 + mainSpacing), buttonW, 30)];
        button.selected = YES;
        button.layer.borderColor = GreenColor.CGColor;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitle:self.textView.text forState:UIControlStateNormal];
        [button setTitleColor:RGBColor(143,143,143) forState:UIControlStateNormal];
        [button setTitleColor:GreenColor forState:UIControlStateSelected];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1;
        
        [self.tagView addSubview:button];
        [self.models addObject:self.textView.text];
        [self.buttons addObject:button];

        [self commentViewClick];
    }
}

- (void)textFieldChange:(UITextField *)textField
{
    if (textField.text.length > 6) {
        textField.text = [textField.text substringToIndex:6];
    }
}

#pragma mark 完成点击
- (void) finishCick
{

    NSMutableString *string = [NSMutableString string];
    
    //选中的按钮
    NSMutableArray *selectedButton = [NSMutableArray array];
    if (self.buttons.count > 0) {
        for (UIButton *button in self.buttons) {
            if (button.selected) {
                [string appendFormat:@"%@ ", [NSString stringWithFormat:@"%@ ",button.titleLabel.text]];
                [selectedButton addObject:button];
            }
        }
    }
    
    if (selectedButton.count == 0) {
        [MBProgressHUD showText:@"请至少添加一个标签" inview:self.view];
        return;
    }
    
    if (selectedButton.count > 5) {
        [MBProgressHUD showText:@"最多添加5个标签" inview:self.view];
        return;
    }
    
    string = (NSMutableString *)[string substringToIndex:string.length - 1];
    
    NSDictionary *dic = @{
                          @"id" : self.h5CourseModel.ID,
                          @"labels" : string
                          };
    
    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,PublishH5Course];
    
    [MBProgressHUD showMessage:@"正在提交，请稍后" toView:[UIApplication sharedApplication].keyWindow];

    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        NSNumber * code = responseDic[@"rescode"];
        
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];

        if (code.integerValue == 10000)
        {
            [MBProgressHUD showSuccess:@"发布成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];

        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}


- (void)keyBoardWillShowFrame:(NSNotification *)notification
{
    self.alertVeiw.centerY = self.maskView.height * 0.3;
}

- (void) keyBoardWillHiddenFrame:(NSNotification *)notification
{
    self.alertVeiw.centerY = self.maskView.height * 0.5;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
