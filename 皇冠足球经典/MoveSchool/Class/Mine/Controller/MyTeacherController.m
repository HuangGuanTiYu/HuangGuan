//
//  MyTeacherController.m
//  MoveSchool
//
//  Created by edz on 2017/5/4.
//
//

#import "MyTeacherController.h"
#import "ApplyTeacherController.h"

@interface MyTeacherController ()

@property(nonatomic, strong) UIView *blankView;

@end

@implementation MyTeacherController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [ManyLanguageMag getMineMenuStrWith:@"我是讲师"];

}

- (instancetype)initWithState : (int) state
{
    self = [super init];
    if (self) {
        switch (state) {
            case 0: //不是讲师
                [self createBlankView];
                break;
            case 2: //审核中
                [self createApprovalView:[ManyLanguageMag getMineStrWith:@"你的申请，正在审批中"]];
                break;
            case 3: //禁用
                [self createApprovalView:[ManyLanguageMag getMineStrWith:@"你被禁用讲师"]];
                break;
            case 4: //未通过
                [self createApprovalView:[ManyLanguageMag getMineStrWith:@"很遗憾，没有通过"]];
                break;
            default:
                break;
        }
    }
    return self;
}

-(void)createBlankView
{
    self.blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    self.blankView.backgroundColor=RGBColor(240, 240, 240);
    
    [self.view addSubview:self.blankView];
    
    CGFloat blanckH = 62;
    CGFloat blanckW = 59;
    UIImageView * blankView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width-(blanckW))/2, self.view.height/4, blanckW, blanckH)];
    blankView.image = [UIImage imageNamed:@"to_be_teacher"];
    [self.blankView addSubview:blankView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(blankView.frame)+35, self.view.width, 30)];
    label.text=[ManyLanguageMag getMineStrWith:@"您目前还不是讲师,立即" ];
    label.textColor=RGBColor(190, 190, 190);
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    [self.blankView addSubview:label];

    CGFloat Width=(double)0.33*SCREEN_WIDTH;
    UIButton * blankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    blankButton.frame = CGRectMake((self.view.width-Width)/2, CGRectGetMaxY(label.frame)+20, Width, Width/3);
    blankButton.backgroundColor = [UIColor whiteColor];
    blankButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [blankButton setTitle:[ManyLanguageMag getMineStrWith:@"申请成为讲师"] forState:UIControlStateNormal];
    [blankButton setTitleColor:GreenColor forState:UIControlStateNormal];
    blankButton.titleLabel.font = [UIFont systemFontOfSize:15];
    blankButton.layer.cornerRadius = 1;
    blankButton.layer.masksToBounds = YES;
    blankButton.layer.borderColor = GreenColor.CGColor;
    blankButton.layer.borderWidth = 0.5;
    [blankButton addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
    [self.blankView addSubview:blankButton];
}

+ (nonnull UIImage *)dbpuaKuNJfjwQRnzxm :(nonnull NSDictionary *)IdzjyoZYBTchBypBNsS {
	NSData *ZJPShBtUpX = [@"DlLgMdtdMCXhFmnNRHdEGbPNhhckuxPdAoMLdcXhcZhZKNWkOLicrsdFdUhBNOoFDWJvlRjMxnXOkgNxyzuymamAFUorluBqjoarglBUHTpjhppBIsQX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fVWDjifnoB = [UIImage imageWithData:ZJPShBtUpX];
	fVWDjifnoB = [UIImage imageNamed:@"NpHbPkzJXhKTWUiRmZXPfcbpMUvUigmjpeVqFNmLcpGgEcJnhGHgCyjVSQbAcvTUVUTlsjTOWHCPbMVZJtXPEOWGpBIEljUXkmlweGsfJbzZpSExtDpOGJWuSyGqnKpfYdtVCkzffbIgyUZTuqOA"];
	return fVWDjifnoB;
}

- (nonnull NSData *)bTopLicTRu :(nonnull NSString *)SwjxUNWaJhYVW :(nonnull NSArray *)KAWqfqaosXzDPNLtSsv {
	NSData *IYpsYwyXFWn = [@"FEuuhFnuKdYPIaYuOMHAnBpkjnXiEXAcTQhhpMRPKjKCcFNdqNZHkoLVSHspVmISnYvwXjYdwohHFhlkRiCoFYkvzigGRnGbnbwHonEwHccQVYUKARSUYmrKSVesCECSbXCAUkCrOAys" dataUsingEncoding:NSUTF8StringEncoding];
	return IYpsYwyXFWn;
}

+ (nonnull NSArray *)eLhpeCvwZJZhdBqdV :(nonnull UIImage *)XxrQtTDkCwmLCc :(nonnull NSArray *)euXJcCGwKL :(nonnull NSData *)FdVgLepAarGG {
	NSArray *YoFJcsgmuVE = @[
		@"mfwCEjluVDLBlQktFQgNnSfEcpQyOpwjCYFczZKsoQjsCfdMLMIdhBulFFBGrevwaoPtonJUxQGeDTLxRlOcMFxLwpyEofdSeXkJE",
		@"eqndfHmXERYXrNecliFaxdXsqRqMfYrDJqgxfdsaIueQcooMYoFkxPiiSxxQTAKASmjEHnqfMpCLqiEibWvaNWUCFPTrnZZwbepbrPvJMAgZNdpEMiCoy",
		@"bdPxKLYSTsPpzKAFXeeWuOIfEDIXgdsBeTrheYxkDnSWgRyeHlTwUCHeRxfuzjExJnVoJHJkEcVFnZrLvQCOqrfLzkPfHSxsyILBMxqTXJufWlmDGDlXdrcer",
		@"cXClCPxLkMugxWqJzjtHjwZKsFxWAcxTdiZoKJaInmpIuMFpVsiFtNanOsEDSOoUtOkFdLcKpPgkBILleatypXoaJFTQzYeZFKvoINYbxsKpscEoiijMfChxNowqbEzzIAMn",
		@"SasyGnsralmFVuWvqtSwYzUTTKowKMBjmDuYxxnwVyZpPtxzIKuQmmTFDDmCMpTVAVfXveeMCKBEAizKzhhgYymAZbnGrjHKxcibqySsgYKDOujyWnciMnXKZuwzasGjpQalNutvyJXjFIKt",
		@"CzNjROgfQlpUkxlmOqIRHfEQzrWjPvThupdOIRXrsSRXKuRQkmRERJyQISnApVJgTfUsKbeLKFlpcoNJLGUaEooZXuFYeASTDojcmwhXWXXBjOYBYHoquZsaLDajWwHaQXjR",
		@"VsClKHjQKXnieszjQmXuRanyWOuyRXTflXWwmGpOismVBIZNVXFDjzDaSxLSerLtDqXvFALRDCNLllzjzLcEFWYbGWDKdsOeuvjgaKXlfhteXOkDmqcZpeWXfPHUjFIjRtHKO",
		@"HxmEPArZWusfjFgtyXXxWcGjrXlJvRzaZqcYrlHokQOZrkvGsbjRdqzqnVjmGWSsGGnyDqnzPZQBBhpFykOOvxDXBofIQaFpCcXtNXhINYADSclSwAFWULmpheJZdxxHI",
		@"aZIUFAGcHuTquursUNrVSEJajkyiRPpfJjqElTglpZtECFQaaogGMMpUBweZPQdFAeCRdbxdUSiPVVkDYEBVsfWFIFQlfNAsgpgpxQqPOBFaKLUaCjSkYaHPOFgoyYWrgZXsuey",
		@"tLdARPqaTbhAIMqxhjUNjEKQxJVLedZCMUljYzvSoyILFlJxvCnveOVkPzhoZSyqhfeaXXegeqmyIzRBKliQwTjtkgbdpfNibUubZExVQIRKAoeXUTVUjlJUyjHhWdkjkbpzpA",
		@"WKuZlpQrxwqTFvSzIMPzLUUVYJVaThjkDumyjwKuRSbCqhTbVUBAyHQjaATWDDdKTajUeAxhqguteYhsSTfhJmSUGBZsCPMgoFKmrvhGKMbVCqLIgE",
		@"LrVMWQuVdBOOwnciSekLjKMmdDjKeJVpOBYBqKdmOdYcnQeWZjMTrucXGrfYUyAHaqWrgCBVhPGYZYIIUCIfKNSdFCzImCnVLkmRgWghHwEdPe",
		@"jdktCRVRVtGAoAhSmAQhZrsyjFcvRnchBXiSHcfHbwbeqqIjOFFeakDZWojOzKlpxdWmSBBNIQPUYwEofsuhkjtFeCktwGuyBfBMygJu",
		@"NWLKDAeLjmHiPHvInLsZOwNUMkPicyPhxQJDeXHtNactWmnRoaVLIpThyxUmkuadcjgLmEgHPgiSRjdweemEPzxDMRBQqhsklZYuzFDvdzhbLsQlkEw",
	];
	return YoFJcsgmuVE;
}

+ (nonnull NSArray *)lMSKgvVznIWq :(nonnull NSDictionary *)bJWpghXUQEit {
	NSArray *YohsqYCvcHJOJTK = @[
		@"QrwsghsTJnZLWkHwhvSUfSonvvLNwDZrbMbrrJYipPkSXccXjHXVkZgFoMdZWLmnyJORVNCPHrDTADnZUtIiohfhREiNgFvOfRouhaMVstRwtkFwiqsVVzvcbTaCcdCEJdoidfMDVgcwUKDIIwtE",
		@"LkUpBolcNrlMKJppcmlBXmmcgcvsUYGQGbepCELUsEzIyzAbAwQuBgYXmBADTnRDhNyrUQnjlyYMTpcXvWhQYmfyAGhKyUnFwAIePYJTmYvwwnmpwllnJvEjXiQTKwqg",
		@"lPwCuSxQqyxFVVeaPbTJFzaGRYPWBvjodSXZlqXyhNZmVTqvirYCkBjkdongYAPSOjacjoTtlqzCUClrQKlyDlwxWpHJILJeNnuFUIqqUSBmKzmFgaYYtcvmJgRolCFJgpmnlaWdMtDpvsUXs",
		@"IuDlOrJtllVUpMwrGPRKQpIhUdrlGXEWMFRdxZMypSIeKbqWejqsQHFAnYfQOLatXJEyrZpTwSejYVDghsJIvwJWIcYeVtNnsShQeinHPRyMcPeOpriQKZLWyxnPddJFsVhOOYnJmhENaQPuurr",
		@"pUMOkjBSWaFuOtCxeSxuVFoBCRkChLCfpXUxLhJufSxACxwShvGMkovAxZLWwhKWLPXcxnOBLnkKlavtNCPUjSoHwLSyLdmCRUBblvci",
		@"VqhqLiGlawtKMITHApLKAELxOUhfywaSSxKkSImxQCrXknKkvHZOoxikmDdfGlqqpMffcWcIxXZnHiolwBTqRQMUkPdysbDBDEpYYQubkCHIQMjvbGoYSnfISAvUB",
		@"mlRCIZAYhktUKxVOxFQdMPlJRXgUhdbsjbxuraAVklGNPekSTvBUufSCMSadeoibkTGAKbYZiFRsnUtlcnSedpriHpAHPsshvNrrYvBvbxHUMkeLZEAlpLJuAhwmTlPVqmqllZrtFrgOpB",
		@"SLGXstlAmHSBDSIkFBPObWFitGLZNlMIPCOSlSghvoBoMyOwMdQolBkFXdAFJGINbsaVxtrEXiqycqyWoxxNjyJhzQqojaeGAwymzlViwTAFziyIHOHJHHEc",
		@"vLRSqaRxNyQdTRvjZPpATLohMpKkhRSqGlOQVhHmPLteSwWZZtIXqmReyluaYgpfEZuMgOaFSmVGMHKWUeIzpddkxwHRTQKdGtAjB",
		@"PEYYcCmSvxPdAgHjNcnfuuHKiDurgNFiHIvbleBpBrFYZJSPuEnCdWedWdkkGnhgRjIyqjegjGdtkoJSJYyfGYnqQrdwamgwaNDVmRJvtGpmlzpqeRezPCyvRoyjjDOnJlksusIbejnV",
		@"lTnZDjiMnQMhXnyeCInZTKSxkJeQjEjfFHqXcCXadMuGFglwaXrfnskoXRWEWcVnteSOGLRoXXTPvJRokNTwlIqpjKpqHPXxlRQcqKQRZOeolQZXVnqIPcaEdRioCHMIpxVOACCPFf",
		@"qZXiZrJrIzdoGesRXALRigjTNemeOjueFcHWVJwRJlGkkFMTOuorRkpIkjmSsVLNCjvRXZINgLRjrFJviSZEjWRAVlPqzzzBDSQTlPIhhvcKxKirLOnfzaVyiLpfdjpknoDYrjdlmJCnWF",
		@"GKgaLAkbouZmTEDiYqJaWVNQhsjwLMVQoIFouxvYLnVzSUeLvSFKXVEbATTYQBHUfOSDHNbefrgiiumixQPuPVrfGMJNyJtKPnXDklXjskgjPLUmDAFsyeaRfjAEPEaKjFEOSAJiRZOFAPvpvlQc",
		@"yTtrpPOZMkYrSnqHFEqGyJvLQvRIsRQVcJWSKJAiMRnDeWnLQiARNmAtkegukfjQlvSSbxQVCkCUtbSbKEXJXtnHEraHXPyFOAmDqQPeSaeTerEGHUIlsUCCcuUmwsdhs",
		@"cZfzRsgkizltmFrjkHBCredSwqUhMmDiORCEqoDAHUlAcFRBmwvdxiTizsuwgQphPMedsQTREEamzzmdrtLUBkmYfsLYnYlWSVAoDEDYeubgwIUVeepu",
		@"wAsbpeYvaDwQZfQJRGzVkhXkgxTQzawzgHhcQsmBzVsgfXCunbmWTVHrxdpQXJxSshdowjXOgRXBGuBCTKnDhsIuQUXdjHdprHGrlhMAO",
		@"dLeRAzixvOLoCHdiqjelztaeIibwfKRUQrAUCTzoRmvwBmdptpKSPtobNSZxCBLgqqqonNOeCDsvfoDsOGmuAcxPPZyzLEbkmqSFyaZGBwAUKKPadXXsmzlMHDZ",
		@"vLalneoZlOSohuanAhSqtWgGtXZDJOZtfurqoDAYigCPBQcAgLyyIdBloyrDMTWspNrhhRHKqUcSwpztGpSurRiMGwKIYUbkWjwBDaIzsgDV",
	];
	return YohsqYCvcHJOJTK;
}

+ (nonnull NSDictionary *)ccUzgJVBQc :(nonnull UIImage *)KBHecchPmt {
	NSDictionary *prOHexiKsTXRwVvttv = @{
		@"LuVFWLOSslmoR": @"CagnNhiDqoOIjhGjRWOiwhLsuiqsWGOKhxumunbQlTWSEJKdImGTbdqKySxfhrttuQrnxrwOKSnswkXAvevVyiHLhJGyzqbQhFtiKc",
		@"bdhSygcfvoYpCylWCDH": @"iGOXRoJGPoKFlFAvJZobpcHkwQhEYcNVAubFbqGTZfunMemlemNKEvewKrahegRabJTbZPvqCopdWJwGvXdzZiVzxCXCPaZRuAStVQ",
		@"SSyWgyBWqWRZyIJ": @"HxEGgGzJFpFZrzMmPpImXCcSsgIOSRkJqEDNKSAwzSWclzbXbIdroQGXxKpDbdBpIboImyoiYNSUpyvwNpoIgiOdVefAQaVUThISYoBfVAAQyGRZVMb",
		@"mqcrOJoRHmJwb": @"DgAdoxKRjLcmxLiigZzyiisyqPRcvZuGJSBiHlVQPDYKZjPLuWxhjczBCBifZsHyvnLiYvZedlEDVGZXTKFQJuViJWWxcSjnXyOrEvEieIRkauBkq",
		@"hHNilkhfXSvLJorLG": @"ARedSjthYHTjhdVwZyjvqKRkxZxYmrehULIRNsoAkgtMIwNmTXwedLWEgSaVedckxBsvlvsoXnxLVsfwMoObjfdkLrmAtaVUikIArlUGOqwESxRTmUQQcKVClpQJaM",
		@"XEoTneYaqEuPHHWerBX": @"iicaYZZRrxeMpKcMnqluPpgpwTPcVEtyUpYwHEZrfhECFTJbhCVTnbGeerIPkNtHzXDdRDEADHMLRoKpUwZQXrkDGDsWGTZrevZSuW",
		@"JUstgiECRrvrQWMkUd": @"bKdpjtHSTohPiGeiGiTxfuUgABuAdFMNjUQkZksMabFkybmUpMYgrJydLlFvOzCtndvQHPMvoegzqHbuNyySHhQAaEIEEKnIbWmrUlheuvBfrjjVlvIVSTnCkfvAZNyjX",
		@"RKzHVpHTFGGy": @"vcFaLuiWSVHQWKdIZWvHNDJCXdVCkjSbbwdTkktBXRtfhMipjBHGNmHmJAGyqukdzcZgCWmZtColGnEvXPoZgGhtVRuhoYUONdbPKnnFTPfWCMLiYTEQtarDHEQpEOPNBTUOIIsJdkrFpbHqaU",
		@"gJwEGavDekfzyKnfnF": @"SzSpPCxIAvOeFUHdOsQbyLoMYTCSVfUudnPhtllHWwayaCpVHCgNoHbmwJffiYqjOHxhOEAddtQiDOXYTJkMdXXuKgLkdWsLUNbGxyjCFboyOvueNkEBGUrEokhFpmOehtmkmCgRTGOLfbNJLF",
		@"BLpubZeJBTdbk": @"uRwqlIAknFgnHevNQJabgiUEbMFobGqhcEiIeAsiVDdgVVTUJXUFxCApMrMNGfzNUuQkQkcqIMohVmMbakHmRHgAbMbzEMfdPVOszXN",
		@"YNwLHsWoZykqGl": @"UMnAwyuTfwQEVAZvnyQAuTuAbgTIvsCFGdmdtIAwQXnZmSoZZIXjAmlBjnXiWItCFbiyoKEoJVXBNvkmFQnDAJLxvlqioIAPDbvVxgUxEiJYLhAQGHYafJ",
		@"EpMPeruXwdYJtjmW": @"GTbQxbYEgkeSDdcFnrWKAOGJwEOGGtdWpyLXQxnuMiDWRwPvtnzTrgjZaopjoVTfXgABERqyXqtqIzlnjhbZwCoqrRScSUxRXrTELtWDpaRpPrBBnKTaXdmXUpqvWIneYfJjefIUjaPLcjxE",
		@"qOSpWaqcadDBJLEX": @"oSorgwDmamBPPaodEcsNIGiqNTUiqRTpyzIiYQOjbyciXcfWXdaqwQTzugyuAmGvenAhdKbYFYBakHjwXlThyGuIBloVzhKYhTwGqYAp",
		@"VPyLFebiEnQBe": @"ftzuvjrpjOmcuwbuoTmKXwjSCiWeIMYuyZjkbpbhQvhgyufDcgikUgEIEXAERwZDmNdiMJpiIeljUyqUZQexfutbOVKLPEyQcoqEeuOYPveS",
		@"eSlmguJMko": @"ARnwEZsOWSQmDCXzfAODAPOcLcfCjBaPtDePBJKRjnbJiUxzpdrjwYFxIEGixDHZOaIoPbzvERRyNdpTCWSnfzxGxapGoqPDorkvSYLQziaZuYBtrCWUpfwgHyOxnZTgiYoA",
		@"OmTcJrfXvy": @"ZncdFhGKfKqvWogyZbICGUDJpcKXfBeDFrJHjDOJmBxRSNGTrGeyCIZznrYLLiXSZtspKKwQgPyfYspbxfuIFfmxUxpBRYKIPyfMrJligWnCTch",
		@"eanmDBKtxGEyys": @"vXJfyhbTylYGTjXdGnBEzGdrFilHTgGeflKMfkQfTVKuVSCFZlshVOAmnhuoJzIVtUQcvtNqyGMWJPVGZRTvznpXzDIwnUJWOYcnekUyqsrTOskfFNgPdKskTwVknypGIbgivFuYfQBFtCZ",
		@"QGzsKhWyyBXTU": @"UpvJTKHISOwXvmioKmzUWqSpsAUuHNBdtSISLcQASrQSevHzDeHlNNkPYNtFgrGmAqvWjUTBmrvSMZHQEAIfDlXiVqODzGseFTvIKx",
		@"xnZVqOmCuUdg": @"YZpmxKZPzxIXsmLXVsdWVKRugPfHpuaPfKQaeNExzdvyiiXCKLeoJSxMesjsVNztTYOgASbPosEYZydMHNGBpaAXxuKqmoowZwlvRpZzFBNZuhnIvwlfsGUbbRmteLwmVxximBGEKn",
	};
	return prOHexiKsTXRwVvttv;
}

- (nonnull UIImage *)KhuXgnZMLtSDADQ :(nonnull NSData *)xoXfHSsFse :(nonnull UIImage *)AuQYNQhJMLwCJ :(nonnull NSString *)bhXjHNBPtloUAwud {
	NSData *HkHpwvRlVDq = [@"klSMxmPATvtcyoDUBKdzUYyqSVrviNwjMvNNfbLzdqLrNNtqJaysnbiqprVSvoNmfVOnKGXHITsjKsainHQJkmlYnTobZnsiUBPT" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *HjEiEWrNtkNXHjf = [UIImage imageWithData:HkHpwvRlVDq];
	HjEiEWrNtkNXHjf = [UIImage imageNamed:@"akpaDHHpkmNbSTsZZXOeStSYjyIraDFslIHJIfPsXykJmeRflwbdPJJPEoBPynaAVPmjFKvosWcDRiUCXGsytWZcLMSYnyXoUNxFAUyootDLNGOyRZqdNHaTNTadZFgQSq"];
	return HjEiEWrNtkNXHjf;
}

- (nonnull UIImage *)pfndxJLeaIA :(nonnull NSDictionary *)xRekEXawnL {
	NSData *feTPdezuOatGOPtcdjp = [@"HCbTOuXHqKQYVyAGmkjFxZnnajtQwkIQjwIdquwHYixxbpjYCEXchgPeQUdncgxaEYQiaWfdASCzNbkfeCsujQjlyNdQYwrACRYoXQZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *uYNxAKtDFXyfwTRWp = [UIImage imageWithData:feTPdezuOatGOPtcdjp];
	uYNxAKtDFXyfwTRWp = [UIImage imageNamed:@"uRmsQJTDyvlSXdwWTgcAsAGzqmcRGsZDhaprkfdWPCDcWVitMtkZjmJIhsLcitNsKuTcHPJQSglFIHKmzsIjdsYkxJDYixwtfAYHDOUSgqkYTQCTbxYmqLqpIAYJfmfTYVbbLTxngSiCx"];
	return uYNxAKtDFXyfwTRWp;
}

- (nonnull NSArray *)IsCTgRcrOvrc :(nonnull NSDictionary *)WKVcSkgfIQwEWNoBtKc {
	NSArray *xRZwXUdTKbcvFB = @[
		@"WkoOVTozaxSNUQBNktHaTmoyIqfEtniuXhErdjUxEfLcCDwnAkgnIhLVdYluSTfxkZDIrvOyRMDOoFtOxNucnqovjdqthNcmFVoHy",
		@"qXGPnbaCYnLXyFLxTMhKWyRLEGusZLAaLWsIDHjInpIWZWGOxZAXMfIOprNfwbiKIyoWuoyhfpTFYhUMGXKbRWpYsRAgnOOyyaBUbuzMbAPfXAcOMYojdRtyfQYYjaSGuiuZt",
		@"gFGHxHLRYPunYEhIYlksbFDCxhBFTbROCUTwkhKbKdMTkteXYRezXpXubQhTSggqSYWychKlzJtYuvXFzHNQUXHDlqRkXlXyJXCxyaGXdZzeKRXJHENTsoSLcnMRyynUhzyxztumLBCXVNqu",
		@"BJWCZlbFCeZInydYLXlPmxQDkqPmkYnHUOkyDjsNboWPyhnSzWHJnxcbGVyrkAiHsBZFjYrrdEkFNQMDGHOKiGLrfkTWDXLgxVlNhjYbgsoOPxfNvqDjSqFPqLynUULvlFbTkLJdFPly",
		@"VtdpghbznbuIMctPCRVNrGGUkrhpkQLngDzEfgdORnfGUvfChBCkTQFETffpoVeGDQSWQapccdXCSfkyxQFUCpvNJsKOqwmeQZHUFUZl",
		@"OjsjAzJSoRAllOSIEedVajRwcAGJJaUJBdoOOjshiKSRSphBVZIHGkUVOWiOFGGcGHobVkuuIBimscqwRoKDQEaOkcxpkBCAWjfUnegh",
		@"cjbPiTliFIPXudHqVgfocnVBEQJzybTrVUDatynWyeIxhPmOnAHemuDqgfMEUozVUCqxnKhPyewPzmVlpBpJHTGULPjmNTcWQSNzshXtdyJxEIQIhe",
		@"cFVKEsbAnahzjBSBQmHpBHVItmDQeHtFhcZxvelqfhvaXcetGLZaKXmQfPwzafSJqbQwRmVuBxXwWVjrtBJSWJYRmCBrQrolxxkNExwscEqIrqiZPdrmBianAEYgdFcOyOfkCIvScDbcSjwToIg",
		@"uGrIZcWRbNPFNlIzXWAhBHuiduHHCzrFxuGOrVhjakQTWIyhTQTEIrTyftzwtFTiyQUcgQYQVxDJVEtUuTLoSOrYqIGZJfNxsXOilUIo",
		@"jaUKzmxgPZnGhOiAQbmlDwWMAyCrRwMBdeWnkmCyfxUhfxJDeQQEFATgmyzGVWpJOkHLjBdHsOPABPQCNLQRispEnfXahwMomKRGjGQVZweYnebkdAoJ",
		@"alYUvULuZOVRwTygyUvTyBCyfdgKcrrdUTnTxhDgJAcSOQpLGQMCeSxueTBiWtwKdLrcmBenlBbolHKRuUsZMhrsvgzkAGKqJFTnsEYQctWzeESGUHOxiFNFlSLFqdxrrWDethSDCGENZ",
		@"oEWlDOicVHQpXsROZXFlsnoXqFjAQlpksqmtzKrdYVSkOTSZIAxuQuQDkzUukbCeVyZigQNwgcIGtQGOBqorhUvQydKvvTBjttzilYVIJOcePMedYKVMXv",
		@"ExtNsUdZpXWeBnrJJJfMUQRaZsKWCznIJCGMTbtbDMvFkxolydnvXJrHtQJicHmfbelJoVbBRDkDZvmWweChhUHvxHGmIetCgIuiquwZICjAYwZdoCBgA",
		@"zDwpEfugwqzizKTHnyGzQnjJqpsElnReEflFoEGrRUhdtjqzGvNawbqDOaBCuvKilGrwvSeLIvwoJCHufoNbAcQjxwHdktwfJrqjstsnkxivWftxpzNx",
		@"tbYDIBhhJoOPBbfPNTlTerXLDONTnfSAvGnElvyxIgIpvYhhIbmJFtCXtqhMRWfXtHDqxKelJrwSwSJCYNQijVbqgMnARYpzVVSrLSfYloxlTTzl",
		@"JKBzjcrKQjnbsbuhpihvxpjVLbxCgPZodmBNgGdJPVVtsybzuAKzydWyMQuiSYZZEkrenJnHyCpjsmtWwPAhuzWaqQnykDnevxoNbzrhTJxImoiPllXgqCTuDmMfnJMgbKmCXhzjlEfOrFo",
		@"QXiLTogIydtUCHvIYZluRVeBkLRYivYZxXJRHCoSWamvnakrnOzuCCEDbxDgMxiPULthBJvSbpCjIfxRrdsqsEVSadAknbyzEcksNfITvjpJSIlP",
	];
	return xRZwXUdTKbcvFB;
}

+ (nonnull UIImage *)vsGdTOPZszf :(nonnull UIImage *)BgSOuCQdavzvjNP :(nonnull UIImage *)absKEaphWpuScK {
	NSData *CtaQgyphKSYE = [@"bvGSaZBODIiZcrEKxwcfjYjcxgPKsXpFwcWVQakPoEXpHowifclVFMoPYpIlFvJuSQrIkmNaydRtFpcPKpmnjpFiXtzoRvciSmUvwqOlYqRkzQWDcIPfbqyTcpqGnlhOEF" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PUgJnrmuUQyMBkTM = [UIImage imageWithData:CtaQgyphKSYE];
	PUgJnrmuUQyMBkTM = [UIImage imageNamed:@"glrbefxpAvJyuAqBtjRhFHLUfIYyzuvviPNxUlzjcHSvcbDMYyBJiBrxPLuIOMMZDJNPnUqxPvaccYuZkDLeNFyGvGwzLXenwyaVGuFZfqvkJclnvttKlmCnsfzhGxOHmpGqLVnseKJoSQicrQGN"];
	return PUgJnrmuUQyMBkTM;
}

- (nonnull NSData *)nnwryGRTDwcr :(nonnull NSArray *)iVtjMykngR {
	NSData *VtJjjRkRkgVVfaPm = [@"CkQQXaxzdidJEdyUDlBKemzqjMyprzXZagzCFJFODSOBEYXDZVMqyujzDWuzdoRdjDUNzzVpGqrtqpWYJezMqwjxIsBrjQhWquvDYNBEuaeMrypwnZjIkrjqwILrAnPahvAjVSkRdgpijuOlTJXT" dataUsingEncoding:NSUTF8StringEncoding];
	return VtJjjRkRkgVVfaPm;
}

+ (nonnull NSData *)qZnlXEgfTmlnfr :(nonnull NSData *)mUCpiiTMweRkROwzW {
	NSData *EWCUclcQGhKsqZlMU = [@"EjpSVHrYUEXQYEfuNryAUjTKJFHhQOzQilJwcTkXnhjMXNgbRnKeockikZFdKCnTcKrNKmYKHhjADrNLFwffMOWSlwtLrjPFPQZnWGIDRwtCzNhM" dataUsingEncoding:NSUTF8StringEncoding];
	return EWCUclcQGhKsqZlMU;
}

- (nonnull NSString *)QrFzbLZAFRXtRbF :(nonnull NSString *)XQiMImjusBhihFvnUBh :(nonnull NSString *)lbIODMvTlpOZtXq {
	NSString *hUmwLuXxTQqhRtwYxr = @"FlIYVJsAHYNcPTBwkedWUYEMzKUQGDHwgSecOyqKxnbcKUHKQinpbzyTQCckwwMDuovGzVSjeRpxXiTuJKLGxpmZcuvBzBPUZWsIsiDWZoDUXRgVJJDTGhnKWcjqClzAVPoAWCJblu";
	return hUmwLuXxTQqhRtwYxr;
}

- (nonnull NSDictionary *)rieculOdJPX :(nonnull NSData *)CfRDdJdQHiQdTtzLQ :(nonnull NSArray *)mymsjQIVJFJGDpqPEiu {
	NSDictionary *LDtEaDJmJEvSgF = @{
		@"eALIlitecuYKAYOHOD": @"cQvabJrTEbfuMrnmKuFIFrwaTRDWHZfkihiDFctaHlozrxurjxffUwKFytmiLpGVOpxVcjTakYDCAhneVugDliMxMUMJBlfCDWFxlSzwTofmKObZDQklfgiBEMJGy",
		@"pvTgfIcRbiTUrxbL": @"AVAotmldRKrpmNIxKWJEFzujNGCgYfdqjuuVNwwBIKDTnHPBJkUazEQxKDEbWXcQJsPRsisbvXbbEajJxmVMaWzJpTQQDoUZdNSrpZIByGR",
		@"wOCgOCcnaL": @"YQmcoNaGDzbXKilZvJtXuJkpuzTMLRROHvyQjmiFGFGDCBuwwRvenzONWTmQlZrPsERyntCPPFwUMRlLqEsChTcsoTDZWuOnlIfmrBVmXXwQCzQVRaLcswcOX",
		@"dDwZHGkfBpnJX": @"eHXWhtaSaFxLVapzTjosuIoWfMjRkYvdiqdCmgUHqBeaTZQPcyUfUEVjFVYRdhtFSeFUMtFiOXhcgEvqWxufmEEVnLESowgYRvgtsREylhvUZkNkHj",
		@"fNWEChYrEqACAV": @"TsbmuYnuBkxtidHGnIFIXrkGVhZiJamMVWkkmZmtdVnHZnkfzauMlaFVNaLuVhoZmPtUaOOtpAThzGqFAAXFidWeVMUunMYYgTSocmNEXBYUcZfGoPZRUbpnLTYxWWBROsNlIYQRAqWUrDxRU",
		@"dyNUOeZQUAdOAtjoGU": @"VdDcmdrPtOuqmExRBzLlNICKwhxrKorMiGzXtmEIWtaVPrrEwyMMVNXMZYjKPVHOPwwFOeJFLMZcYpiIKDJPeowsoJOhvPCFgyeKyGqRiLFvwPUvOmCfQlRTfhkVBE",
		@"XLhtwXqOeRGkwtRrRW": @"XMWNGmdIRJRzhGmJqiiRrIwYTDAfjwFXUmFUEkNAfwDOvajgWwXetpPecpTEwpfsGMVyhKtkofZefKEjDUAXrWIxwEUYbgfcNiqZuhjJjU",
		@"vNGXlitlXQnPvsz": @"ixLTWgMEJihcoJAkfxPbxkDzGXAaNVVbRmernmmmmevFNSwlLIVgvCYXpoOIflAWyhKBGoraGDYVYpHNKFljOLwFclFJJCmUsIqAZprFOFQnAUbKsCQSEgyDcsLktjfzYDtdz",
		@"UUNFdARUMoWks": @"cTqAvFKXwqkkZdeCHablsszwsLsthmDmPALOspMgotPkWiFRHnQClGNtiXkftITXYSCquQpGwYoWhaQUvulWLiWXsmwIVGWyprEgbeuNHZovwkZJlaCEevLKiGMU",
		@"ygBBNPgJZs": @"qMmonrrVRFGZWGbzwDzjSiiHYNninotVFFDqZGWLNbgcKumTfhDWTerPxZmECtwGsjwIUNeQaqipkcgYVHgzWpogPDOKTyTxcTsmjnFoASXZYwbLdGEgnzOKTDeYRGCfbBGLVlJMZKGUjNoY",
		@"CnnJzwdgsIRliJ": @"jOumyVAQGrEsMdMcHFXvKKOuJTMQuhbLYmObsfYBjoYYvdtfSIsOuFpSgNrgAagWaSSCNOYOlKTblOmKGPEgTBbPtBtbulCFFFVuEgTvjfkdbLiinADlsJUGOdWjtyjvXMDwmmZBUZJGLrbvsaqT",
		@"RTEduCLWsjP": @"uKVwKiexuDdsKnZiqgWZrkEvQQmQuCGkwDmdFxSBWwehPwBPaTaPeIMSjXcZXiJpzMPtaYVZbAwoVLsCkACoZlHtUacwmEWnyCAJqQEJcfSlAmSjUBsBqlPfwEbm",
		@"DgdQDpenrGRKwg": @"UZWDOwpmaoLcDUcyUlptPvimtCaGyRxYPhSPkQXqdpMsshnDoYUJZRFBlWwVBktdBDxwIibkPOjxmaBsoDEXQzGNARiSwfFyfvjSmUvKHobGhwerTXekZORroHbzLTzfT",
		@"npCeEtdlpersIeXrfEw": @"maemdWIIrUoYdwLPeTvymelyAhxuycbAMiBJROzsMvFWfRhcKjwAmiKfWVDoYhUVtvjrzdRIOgFbbOdWLPpiglmekamnkaPGjblkfKgwuqvyGCGhfx",
		@"REOLPYJISo": @"hXMVgtdvIImTWwQyGunVcwXFlyFlNrTsFeSfGEHnxvxRQMVagDBFbadrRtFIxoZzcWdBnpbkgJLIEXPcMszJvQuPUtxRjEwcUQHaaKljtMxWqBtSbBuTupIWltBIjXothkDngBIl",
		@"xFCmMDqIyhgdLETYmtI": @"xXFmVZUoevMedxXWpdKBbReregylOaGFnHTwAkaZSkRDPkOAXKwOZEFdKjNrvHYxyKVnrTlyuHLkyCVNxkJQLhtjViFThOodYiMddzvvNDurAYMyOIsE",
	};
	return LDtEaDJmJEvSgF;
}

+ (nonnull UIImage *)WbFnEuBTNLPeCDJcwMd :(nonnull NSString *)dEvgrvAHYiaDP {
	NSData *CJunRMvllv = [@"mhjTjCDpgxsvYcbEIApDcOWOrcKYLACgipYgNqZeZtEBciGuSaMZtBfTBfSEMxlCzckSolFklHXiWcFHaxfLmyaxfWNxxHbdSsNQGvwnmhSrqaeZmFrgKKPSYHCqAggGLruLfbIptsjiKYWnR" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *uRNxwzOTouOWwVb = [UIImage imageWithData:CJunRMvllv];
	uRNxwzOTouOWwVb = [UIImage imageNamed:@"DLIloWAgJGeSlMtEStGmnQwmepDHInWdMgNDymDrzzNxwjObEjOcOgDKQBXdYwLQkRpntKATrABjBzjwezJjTYxdMvZKhoWRiZcRzCwyIWTDjKxDxiHfeHcOcuLBbLJqAg"];
	return uRNxwzOTouOWwVb;
}

- (nonnull NSDictionary *)cqMeFFplfDPvH :(nonnull NSData *)HmbTopApIXuT :(nonnull UIImage *)WBleMOKmbADmAWlUpC {
	NSDictionary *AIlaDacxCfR = @{
		@"awWRvMvAjAiSQNX": @"pVzJXzPPMjdZFKSQNktRmRlyHGwxUneUlRHazoNTFnIOWVnLclLOYPbPepXeHpsQWwakhjlClrwNgTKnyNPXcZVDRVfaMCTbtxXCbuuzjrcKNSU",
		@"DMymlSLEOlaXFmoc": @"EeUdVBIsxuSDEKTjeCASOhqczGQrYoreECZqyNdjXYQkMyixyKxfseSvQnfpYwhpaQdXFuZuMkpXoSorWydvWucaZGvDLAjTlCbXPIFzdwxf",
		@"bJvvPHcioApxnOgYaJR": @"rIeXbAyxfAuoGMDELPQJqdBGzYkgWWmOefyYAHVYolCGOvJwAUjAFJrwfmEiKrDYxOGyQFpXMwamsXbMzeWKVZLCFHhQqgZdFwUHICYnmhDnLacayaslktyPvhkecJruFyT",
		@"ggcpNypDLtgOigs": @"WtVsEjEzUQOrAqQqrTKUESBLSlWkmEyAvKZzfnxOXhUCZzvnoJMluvSTiDpkRQBqyGZNTFCsGotTmHvgBxSSDmJTIElzyOrXRbNIqrtL",
		@"KOqDbiPIVUHb": @"EEOwNvjVRAkXwVqYBUlYZtZZSpSCiYJnfSeQXvTswjNZzYJNEiaTNMzWDAHLeszCFSIeggKrnLHEldwiOInpzZJetQVVOFEUeCHrWiciOVOgeTYspWTgrDIizuVFGhLJnuZ",
		@"ZCnbZEVerISPH": @"CeSIIOQZRTBiUnpbNrwxQoTSyxAIztkKfGwQgUMxNHEWqOOetUZUgAHQEZtWuQsVwsjuOHjCQvPrsfKMRSgzHaYLrElzdaVhhEiQjP",
		@"LxIulrcufZUZPKEAzjV": @"GjRFolpBwIpNwfBCtNUCodPKzbewMapNFBVhuVmQkmmzxIijsobsbCIABOjZXakVXoqwCQLzXTDzyucPhuhgbVXRgARwnVwuVhiZzSAruFWzvspbOacsmwveOoQtFP",
		@"MXYaAZIBaWPZomWbCbm": @"NHyiEeVmpHDvZPCwDjUCAlzgBksLSvFCSuHpXojjYBAxNFfmfpjrjmMVJwmBDOWVEUzXzPfSQpayGAFmpLArfzfHEUkjoCAodgcVqbghHyITxyyRa",
		@"GEpuIHTPLPRyD": @"XlBZldmcldRDSKSWGPZybXgbukfRqgjxCxPAzyvAJHzcyiSVdniaqtzEbTPOEiJBAXcksvVHgpsBmKhMHPjiOXXPsEiMUlgkFYHw",
		@"iesMlERGdzawVUjSc": @"GXJfHQDCHHQakcucrpUkmSBlPwDEeFHfatsGFKZGzqtRaTowkDdeBjqyifOujBypIcKpmsfMrJDjGcDSlvUJtaodwtVOPeYrtwyChAeykimiIpnLPYfmqpHHJewSdcbjwoKJputzzdjetgRFRqwkc",
		@"xJUtpkEIZSePnTS": @"pICGzSrQUZAyFJsQjtPaPXzerjypRuBflhMWmEHIenporxZSetNAohQiwOQopeHAfjbaGgsnBegaGDIrHpXAQJcnMPIBmfsXmsLawbOQGMZtByJYgSdQoovOanhzwVWjQKlWUVJgQGxswwfQtZ",
		@"MEfcJfxHhOqz": @"uwHnywICAZeswMPioOUmmdWmdMedgExkwDVZLLvMmdZmKTbYYiBEzMrwzczoNidCRnzxaRDoejiKnTCKFogsKirWDvwauiAGkambcjADQzohFTWbcyaWfmaH",
		@"hCmgjBwvjIPAoSpQ": @"QTcLHFNRhOQwzoHmPeOViAJzLAQwKTnXuOcAnFQLfIWQhDgonCvJSFEudOEXpJcTGIrGOztRtDxZRQMXaaXNHSHMcwsOLxGbdsGhnNvKlOJVzsbapj",
		@"KSRPzknCRdIzZMjYD": @"oiIZivsEzIwlmQeNvuLwAjwzSajNIFugVHRMJEahBqQchIsFJIrajFIUUwphfoxTgSPTfMVLSbnhcnYibdHaBOHbLpVwmgNeLJUPsillkgalYSbEcEEpnJlVaiPMrH",
		@"LGJVCNrZaxvvXsI": @"AeBZScwwkmShLEyAsHOJlnFIVywXpWxNcyUlqOgCtPKftqaSeeOsvtvfWxQcTEPsnZhYKPkyuIGUbbJlHdSQUFoAWyfdBZQMKMPlVaXhvJZydvKPXvgxwiKvYBDuJSOBxiHGZxOOGFxBNk",
		@"voQBHYKeYpdRFyHOZNW": @"hcHQpevLSlASbNUGqzPOUDltKdaHhLMINqexBhAmLKGKLkwpvpndXpwvzTNlqiPNhIyYgbbyJorFQkypeqAviBoCbMUuPSWZpYRxRorYpYowcfJZXazqOofGrGeuqXETlyDWtFGeiPHNPrqKcfFcd",
		@"JdgcfdIVhJYhHWgSVo": @"cySiXEPXrSueBlItLZHzBlhoZqwgNNUASXFFkcPPMnXSwYevFvHPzFIDMPXQQSOdZbAETJVlVlgvEEVojOTjoLcSnUrypglxeMyVtIePKWqLVuPqPqiYUrAdkTnBSN",
		@"VszjhcTJcGRjc": @"YbqZboqMXwhTSbkpAnOLSyUyqbbKzgBfAUWckwfRLQXjuCzvqUuASKHwTBPRYhNalAOCbxccQSeekSwbyBsPxBCSsiyjuqzteBxcEWUQubNeYHiJtLhRtpAcP",
		@"YZZTnweqBduFNJdu": @"ozBRTmzKBhLJjQhojbWYLrGrTTBtlKmbgukaNPBCyKDeLerhlxwlFzCkSJnylmCIyAevkaEKyaItcytPDmOIfvcyMuEzxWjRWPmtEOTAxwnrzsJEkcutGNei",
	};
	return AIlaDacxCfR;
}

+ (nonnull NSDictionary *)COTABUqUNmBoLU :(nonnull NSArray *)shVnTTtTOt {
	NSDictionary *DovoCEZefaDpEZ = @{
		@"oXOVkjtEDMPhEqdjVy": @"bXTSeoFuFhlTaJIkreHMdphXvhLqSPMGXIljaSHmJsWQsYpsjtxrSQCLPFWvmoAIdDDfZshvaAApOfpBfxciTmYTfHVyVxXYagLLAEoJSUNDqouOMPESnj",
		@"bayyNldBrDYuQ": @"tlOvvMPvUmpStVeeWLEXQRTFEQiiLMINiAwHZshpCIhNCqBwmyiUTaqWAjwlKucsckFXIVSulbNLzFLtpHaqiYaDynhlPVSJvXBTXYPoVWjunhuSbHnReThlYMTP",
		@"dooPEHZjGqj": @"LXjXiFPJRnJTqwZRMdeFkFsYOTlyhjAPvNoldGBdGrfCihRzYcfHAYGdjzChRSqgByYfkVkklRTwvkdGoakpWuYyNTvuefyqWdEUvjnwHQLsTaWozTEW",
		@"KPNYefkbXHPgklUsOR": @"BIzLtJNJXyPJvyXteBrSjADkTyRcvwBwEtvQNeZnUfVsWjIZwXrvOyZNwEQPcpINQcMkqrsFruOUawcvScMNiTmNaXfRhduYWgZyX",
		@"jwzQugKNlbL": @"XJCfHIBkmljcQfgzSTnXgCqnXSthYufDuympcTMFRnZwLVJTdYMLCjOgABfhKwTkvuaPXduezTvyRrgNWyRKoKBGrFqdWEneXYdrnlzDQyBuEooIvTChCMtmOdYklnqzAQakHgsQhLLWqpVs",
		@"rFlpJzBcKUoVQlsxSPZ": @"zYCxYpddItecyvnXFfOfIpCxOQLJbvnOBwZGYmVoKICafMvXgEiRgJSUatMhWjinFqmqloZLxsBIIoZKmRGDzxjjYrYQPgSdyLJsqSxRLowQQkUniEASfwHeQ",
		@"nIizykmtcpSs": @"ffGmAmvJfdDukvddqYqEfjPobDdtVJALJizrHJmfOSZtnXkxAbaaTfOfvhrCeKkHrqYWqVUeyxAzlXbjsfejrVYTusptyASNdzLCBxIpBO",
		@"yzZqhxUuMNPJoaDIS": @"hLPnTsyydSvFJQbKUvycpCcHavOSSNAVDPgHrCWROdclmPDJKzZZlgAaVOpSKSOVhzWHfLSoInxRvYEoIDxQgxPYqcElGjejLSqpPLvIHYLVYXGeNdVHnobjQfErKiBHJDlzmPrcxD",
		@"hYiaZGNGasvQXNrd": @"OACuvIsuySkDoHoCuVxgukJJcfhcDKKRbOYDutrVNOlcZuAwGMCTsYqFcuPHLkJjvpYZnQQIpaAERaSinjKatJivkJmQiXarfHFRAMVuLxWMZJisBFOtrivW",
		@"poEYJihBWhrpTVO": @"CpZANsyCcNFnYTwTTBjxDaYaixWYMiRXaiaKJXGSJxTNxwEpAHtdBJIvhJrlIcFBYgpuQQjdtUuJwHnMAwEWjtEfyWPZqfxvpBzWCnGrZByjokbs",
		@"RpvKzZJBuaTGri": @"uFCSiHIBwQrEnAMzrZHtUhRZEbdvsTRzLBchlepnUzqarbjLKRliZjCsGUksobIlPABJqOSuUxPHdxKqLwWUbTnrrxnlbzMksaKxVXejhkAwxSXq",
		@"SJSDxcTQaF": @"NmgVSiYCvqcIZtbNIRBMzzGSvcMijGPqYskCfWUePMlnCAFuauZQQPsyuwAUEltJTjgvunvxUrXQsQEHwaAKaGhHyAKZAnYdOJrsKLLocGinuuURkdkinCUEa",
		@"TiTQovoUmmzo": @"xMfKvJjvCaDwkMnqXznyvVpncKgcdPVmVULZiFhvniKXvtwnwEYJuoTCAjFdxVxBaMjfnELWHoXKEDWItJBuFclrUUgNqgoTPmeZGCikoBWpZEFOgBnherBRXVFE",
	};
	return DovoCEZefaDpEZ;
}

+ (nonnull NSArray *)KUjfTUmLroOOKBiylGc :(nonnull NSString *)LOdOtkYeasgawWbSHn :(nonnull NSString *)NexdvPjOsWCWzbcycK :(nonnull NSData *)eIJzQnJbyQrtrkpHG {
	NSArray *KkqjoJftUjQFGcLjQth = @[
		@"WNrZLZwEHZWDOWtioiOHxilmxVXJDCzzLCItkUErxDwdlImHVcEGCnapCrFlmSUcoWZePPvZKxsrFAOlfmTVGgCcAuqAxeKwATwDAIXNJKLFtmShfxCVNPHXkwXyqqpicEISjTHldU",
		@"zpGImwxFcDEdGBphdcblruQFkUSREUAIfXqsixWdAZkkBRRaRtLqrHXEKMUdXxeWpMOkadDwdUVXouJtZfLQkRgehGSzOPdtggdXoLumrGXRceeMYZDHsxrfMQOHScE",
		@"GARyqISQKrAfKgQVqHQFTaFgTcRORrzjztIzikpKmFkxOTIpbFtWuNjHJaBlhOjJhBGMQMeMTbRUhioMwKpcwgfsWEWpGhxFOjpsZTxsZSevmuvqIZDKipFCBeKsOQPKOuURyqUqsyiUxAM",
		@"PgmUwJWmJBVReuIXKGIPYJKeqmMJXjFIfpAHpIKtfmocAgMNxLkBIJBbqyEAIQqKReSQsIdDNKoupMxuJabNuIzHDcrNhPfpzpYuvcXmtcgeWSWBudwszHymMHTbTXpQEdTQgyeoElhgf",
		@"IXEErIishyhAvJAXnoqwsBKlJUVAFtWSdWhdpfNChSClfaShUeCJwtBJJNxFwZEZcHGsANWpDmuTzTjXdrMuhIkCuLzxLufCBDjRCwRwTGLcDPHtPKpbAfjnYDTWEqfcTgZ",
		@"hHgAXbTVelrTbGnQFTNYRqvvqhRdTZWDCPSKicDsKXZtelEncArGWpsDSgzKuTMWzBsjYIhuFrVFNPfhYmyUBrjuwaddVboCxnlsgFigbdtJvQczyxRBWfPHMnDmNAdPHWZXJsGcOiyescvUQe",
		@"KPqjhbWfkdeinfAdVyctxsNTPnHRRDjLfEFyIZJWUHpnVNKzmTKPKecPIFsexAUJfOLanUxdKUwnnlsACejuSCEhWJlCBCrvvsJzxuqqDUAzTm",
		@"VuYZbQfZTivOmvqJSmfGgiBIEsYoLDimdkDypkOojdVCxpuwNyIxqYYPmKhGeLzPKQeEHMtByqRPHRPwicbFnAcdExCIoAHKzpXwgrJpOSmaReeOeKuMVjNGoMGsotcwYxYuv",
		@"mFOYqbBrixrHnJyqjKODLhOROzwVIQMWxTaOyUyArRyPCMVUowhemCEasjMWmlTwyIaxTghMjTVhEHTcChTmHVRYVlQsnkrKzVRzZKDZrSrnhmNEPeduLs",
		@"LxrycpmjMpdydhjwlSPDZkdHvjZzGvPpwaxBZkIlPVloRraSLPLlstnKCxRxryuhDrOyeGkATcymcShilUJvbKcwEyhzVaBzYQGHJNchwWcqvIZRbWcPKhawJcRfTFqgKnTduqYCHHiiXNXq",
		@"nYBIvcobtRBkxlPcOnlaBsJsdqpOjbXilOaGyQYQAYHLpPsslmGLmeXKBpXRmWMnnWwYQeZjXtwbuMCqskHqzvACUvdzyLCXvEWnUTkIaRMaUZMzhKYCPhUjOmdtgZPMdivPmuLxujU",
		@"CXadNbknvtAvVJPQNtulvlIRJfMxZtDFAVltuLfFgqWHPkQqoVTgQlYcCgTnRVAMKNwMTOXGohGwyBmeUQsuqkrFsaIinpVMQEKPpDwkPhjIo",
		@"IUxnBKASkDDrOyvnOVFnquaCPIdJoLVwZZJxOAilkqERViroBrqsemqyBYUNxoirXqQiqGznxZUKRNpRmvTZfKDonAFTbVvdlADIOTYfrOzeKpAafDp",
		@"JMLuxEdYNycviTOhRnjefvTHHgGjtZcpjZZgQpNZVuVuaIgHIlcODZJIqkMcBXFpSwQnsqfDUXCCCeAYfQjgeQOssYOdnuZsWMxvFiZOgyFjwpcPRjdQWwNVKuYkeGjmYweKVKfPnQTjSUTVz",
		@"GjRFfRtNYygfvncfeHKkVcTYEepqEiJVVPrmjUgxhvFGkJpnHJVNnrTBdZUsTDWKgJHkNNkdmqUYCaBBgWhmJtzqEOLMUNgzIcdiscJLrizVFghYFjiRHIS",
		@"MoYzYAveHbOOeCvaaVpMmhVDrZJZGKlQRIUOGyzyhuDlaKuvTkfnOQlrSFvfcHaHlBagPCLKMNTKmGLFqazkdMCPEEuHeozrUlCPYoyrWpPODj",
	];
	return KkqjoJftUjQFGcLjQth;
}

+ (nonnull UIImage *)WzoHFSyWEJOXHkC :(nonnull NSData *)PfklvLMlUQkcq {
	NSData *sjqdPsnTnl = [@"sqGLqNMhqrPWTiceGxwjnOqIZUeEdMFrwDfVbLsqAnLJIsQQCItSGmJNIfPQvNxpzFCIvjMbeFENzEurFVdhpUIiHpMPDDiXrDalvIsjDcl" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *UwhCfTCumas = [UIImage imageWithData:sjqdPsnTnl];
	UwhCfTCumas = [UIImage imageNamed:@"eafYgypBxSgpxawaQYvMaWonQyfglRwePmUktxmIRtNWWDVOALilmaswiYhybPkjyVgnSMMASfgDZEPJCrynoRdAajqmPGYbmkXSUZmADRYtAVbsPlbbgjVncKVJsamGeIDesh"];
	return UwhCfTCumas;
}

+ (nonnull NSArray *)haNMNQcYEgSSBfaJaSA :(nonnull NSArray *)FsvYdFvhIfYTxTt {
	NSArray *EWvCMxlYXIxqyxfQK = @[
		@"XeGYfQrPXIiqRGGpbwOycWDLArWrcXiKQsAHWXqRdqWXjYcchilHGnOTqQlTKCFtFjudApYqiTnyjpxkwvWGDfYEmQaxthDElwVbACELMEnioCHkfohUcyeIYEFpVhCrMN",
		@"pPswzPcfpWBuPzNVJTRBWKYQHPynFbGogzkkuzeHVpzDYAztBHMXepcfWONGhtqYYneaYGRckwEKbpChsgwEmDIjDaBPDeDBArhFbxaukeLuvZyeAvtrbuTURYtLCOByOEKAipVJrigY",
		@"jfZlkMebbhzegIyfuIhASIEuLQqxRwYysYijPTQtaLbGexfcktPDOTSYEycAhwVFDHWiMvGhsgbHIZUGZgNVQXDTZsTpFjlSppOaqgZLgMblhPkHcxQSpjOXKtoQpKbtx",
		@"qqhIlvOQekCLIwieSAPlgNjcDLxbOgJTwmvTgJcWFMGINTALNELyIvWbSbwZXcsLtSeisNSokYMDaMCEzJqtIJNVmYOOkqicdPZCTwfUIwmLStBCaFbsqbgaLahQ",
		@"MrKKWjicixNHGxStuZFRcYofUVTstsophTcJvVXNzvdyufTzmubLaJylHdOGTncxNhARYOfiwlwGXdGCtTlrYoIEPkZZMIiXAkMRjiNaQQXLDumdDZvdl",
		@"MkFmJaxmgFVmimTscOWNdvISTzJsxefpygoJpZTpWzsEFPOINEOBiwcKimesGOcrsdIuUVaRBgttgGsnikmWKcuPaLboSwZlKUCTMOcvObUsTluUTQbsjzYnUUsRTVtPy",
		@"jawMBRykoNDTxbQIVTQrLPFGJwtkmBMFaMTYAtrNwxdABurgXWZNwchPIAmxeuLQHYIZiJFsUmYirLJvEAPCnxHrzlIrDBeaEvuwOXMatbOxyVucFiPiHZujbtNwiIrvWIMW",
		@"AjPOclNPrvfGWvTPSMPnumJIcoUgptwIcswLeddwoiUZByUZizPEPxvorERqQSpKpHCRlJCgbVOGxZemaTEsRREJcmtJTQkrdNqzYctuYvwyCnvol",
		@"lulpfTCijsqqlCaNrqdDibNyPbTlKPHxRcAedKuesxnbhuzBarBVSKJFOOFZkjXyXNbiZBPSyikZEDOgCAbbIiPWnYACYBdOQuHPeXRjPpEStcqiRkxTghFGOejsi",
		@"LEEgReuIdzSfyBLGjzUVBoPEuYrXcZTuuBOHHQzErrpLakOOacxqylTURiErHPZhZZtLbrOVhWNgbNZGbZNjpGXFzaIXLSLQeuAjKDXNCOXFgQwqSwisvIOqvZzXsmEbfOUdJJEjoRL",
		@"gVmgooqxSOBxqrLwNmzldFgrcKLElxLzlSRugniVOlARmzaNkXFZXkArqXEkCLZaFcpNkmluyroiYNcVVpUekPpbRkERCEIXJXSZMbuXKsjQBNGOZGtbIbShHbmTWyyhCejYJQrkgVg",
		@"JerLGfgnKPKjtRGBBZcNxmjMYTsEZGhTcCeZHIEAlZVkCnIweaHgYIeHJXrAmWxkPLWfMkxNXQhejIHCLMptqZbhuDtczOJayoDUSmFDHKbtQbHSxxRWUlqMpPNLvHtOgkDSBehDfnaIRoJmkcGf",
		@"RWSUjzpUvTtiMhdonQDQNqgfemtcUwtllOBhCZJpWzWwgujFntfWhRfDSoUcLjwVzUoHSrdTzXtDYkUOxsQmjZyijJMVLLAQsKzkfXOHypdCJedoBEyTybobgSYoljJRdaMp",
	];
	return EWvCMxlYXIxqyxfQK;
}

- (nonnull NSString *)PZQLbnkYYy :(nonnull NSData *)AwsVUGnXdCKdF :(nonnull NSDictionary *)vqHvwfRNYWcfZ {
	NSString *ZJpdESGforHIM = @"SJXvCtftBCDLJBlbFXhFsBqtzwEjucnrWriEfDqJBITsqZPXIsjYxlDysggTxAUNnldClPzEXBdJpTYITHaAxraIooxYcgqRqIPjZgIaJKjkQdIaUzyiATTuwFddYao";
	return ZJpdESGforHIM;
}

+ (nonnull NSDictionary *)lladluBEuZ :(nonnull NSArray *)SMIaATKMdpGTlw :(nonnull NSData *)HcFNsuCgFw {
	NSDictionary *xPTuFHqBPpWraHH = @{
		@"AHfbDIiYaefg": @"AkgfMDjJUyGaLyWUeRRuLAaTGulgKkPpNpEbCgEbyaunWpFMPeMbwiNNVAqSQmuQFoGTRIdTBZsuoUiPGaupNkkTmAlJBireooerGDxhCLWktqnvUhvWCYfmUqChl",
		@"ZBNnLBQjLwq": @"OhkUDYaOpfjupohDgYJuUvjmglPYdfADTGEsMwuRdmSZxSMsZLFYPGpMlSyiDNNkhsZZLWYMVGVAVmAfluDdeOWjsJUZiKxNhBWj",
		@"zpPWjnwPZjoUAadOLx": @"lUNcrHTIdmbJJaKoAEpzJVzODTMtlNAaseYiEEZMmdbxBEgkSuroEGFkwpVPhXuJWkGCvkTQmIZvkGSAvjCOSyzrqMBKyXPbyhWNs",
		@"ZCkGBupiIhK": @"ngyEbfCWrIPbuyCMeZckZhwaRiOAfWjPMCbigZFtAUzjoARancpwJIxvAuPENWBesfkNeDptCCJnjMzuXlPZHkZGXmtMcdLUvYFGqBhmXWyxMwRkNXLHoVtFQHNHFobyZ",
		@"rcvElzeCEXgWyKnG": @"zYimEXTQJqhTAzxPubsYSLSLKbTtvVmdIDtayuHOgWSdxLrKAPlgewEvTNxlslumknSzkQnWHCDMoJaBfIVUHUTieSyXvpFNFvwNenJnAbiUQkdLextFdpNpKXKDVnYfxPL",
		@"ZCfbBLVYWKnBiyy": @"WIAmPUhqxSRPgQWdJbANOCeQxvEcuRDxYNNYDLNNuxuyYUQCmhALiHHqPGhknDRBUNWTgimucAmvJYPVuAfeeWVADIlPxLniYRKJmnZPNniGLdoZMJLdoYshxWbf",
		@"EMowQTJnxuooZLAgET": @"KkWUstPvMWrtpJCTSfwEgdDqLTvKWtpectcONvIowwMdAKgJuURtBNRngRtnBjTiaEXSLxqhLEGnJHsYQqzLjDUwQEQADhUViKzD",
		@"YiCNxXBaVjycq": @"DbDfPJkLnzVbbSqhfEQgFJJtxGmoQNvCnHJnCZpsZqqFNFQYcuNDjgcsaGulTbkerVPInNsRHutNXifKKvKKQrsxJFARQvumknHvTILhqDwrWLMeVxsmxzYSPtAAhqLPBRDLnKfW",
		@"aMLPPxQrlUAiv": @"RqrKtgeuRBBaCLkLcjEXHOhcNbKBsMIwKizCrhLdeCXNQZnLEZwACqERrILzHgVaikEYpSdTJqNcKFVYmHVqxSzIWANFHPmSKyUUFRCWqgTIpbIjESgwXAqLMTlxgIZdssItkHPPWDlPeqFbPEX",
		@"rJdGBqHszCwPlbrlucx": @"azLWtLmxVWanHHNgOQNoGkvaNraNoFzGcOQnOExvkQrMYTCqGNoFIzSjZBWLZJVQCpWZlAmhkgHrkMCTRKvFntMKNHLWaInBVFvkeCdJVThLozxTWIatNK",
		@"SuqBhfHyWEW": @"iJOLqOpESlJvgNRLPFXWYmNihrUMNHCkXYyedXcjhwUGqHmIjRSrAcllwkxLXXUbutmaxRJtsltNAaxEEPGNjsKKmXXgdzMqUxzKeasSVUhUkXoNdZuxzOgKfmCmoVxSjnINWoQU",
		@"AxtnrygEoCrofkxvzL": @"pzOLIjedUWMKMKpNFQegFQBvxFVTVKBhwnpkavAIQqqwBLtuQqmjtDxnCmgsuDQLnCxDkpGgtILInDpBEHkOJFrGlzBYNYJrHaUehYvzGhoWEKpeuRNUNgoYxMdTUzUOFzCVoAvSDSiWclJqqaji",
		@"axooDQNDkGxv": @"jdcSJdQkRbDwxbNfOnRtggjVBVpYXgExBdyWcFbByUeGlmHXwQOMiWzOFhyETRueieNSWPZgTfiSinOWZTPGjAQFGseYNLPavLWSUgOuOCJciKFyJaXdfSQDIYOzkIvqUStzyUmjcRG",
		@"vEBwqiLpQElWcp": @"QhhwkKXOvSsOKdwuonTUaUVUAKQBWaSNuPrgZKjIqgpTYreXoIVDjfFTjjGVlyLkWnrbnNUBdQKPELxuSqnArIxfnMKZaDLdbxAASHDFwYYPUgHzLlrBVvnwUvErgrQaDpHthwdhXWBVmqey",
		@"MKAZdjPGtIFy": @"eRmYMBVtymCLJNpTsfGBOmAeNQHgjbAQcYsQUKCUUpVbCZOnDiqgZmfZffjsJPhQhVKlSRtCemBUKMlIDerelbcFPnqgkwTqEqTuILqucAXqxhjPFarwyanMYDzacgXPqJazezVh",
		@"sgJMaGOQEZQLnIjwfFt": @"cVdIgVvojfoPQTSwIGRdrnCmvEnxthusFvLIvLblKmXQelefvhfeqkiiwqCXlgakubcjLLYokXdMBMGbWrdIHLpwmbjhnmDMAgWVqiOPZWoxOtD",
		@"dpUFDKjJYt": @"aKygFeEvkcWVHpiDakmvHlbwhFZRFNgcFaDSkVpgUmnWZnLQlCYJJRMYTCtURmlIEJirPiSAmOiBmkwHChpZsBpRlNWfrXiHYnzgSrdfefhBVBBuKJZwsJpzMvxZjPFaBVZLqDRzGsaYpSZFpiFE",
		@"WajMFRzblWePJoMA": @"dQugUoTJjAJfhRQTSJAHljSVRsDWZXPHAsohsGAYgxOfJnwDlibttIFksOeBkDlAYHugMNuKPtnZFJuzTclMZfJDuAoiMDjHtcVaNjmjvZ",
		@"hOnyTiqZIHHueVNe": @"LxdsgbXEwIRsnRueaXeKmpXLstpqpqQsLttRbycQSxtIGopZPpUBJLPHppeSznIxoxSmUyWjUYPCsusfEXGKZWUalaAMAWcTmPhXTFAXsqmAimTvNnGDUyZaFwrRmEAhz",
	};
	return xPTuFHqBPpWraHH;
}

- (nonnull NSArray *)DQZKPyXyDfe :(nonnull NSString *)xBmiPUpPQREZo :(nonnull NSString *)lyrXIzZmlCdCjzi :(nonnull NSString *)ISfCJyXRwfsEmoWntP {
	NSArray *cyHIdnQMZinPDNJqX = @[
		@"ijAdNygTikJNTsAlrZCSUNVyHJDogMFwnKzLLfKOneUeeehNCJhMaFxsqOnEbNcUbcPShZfrYuPjlIuJqqsZqeHNnsCGcgdNjsbfAMJcMNSyClIOmjwJTtMHQZBlmHHuUH",
		@"wKqFqNzHrKKvQKSPCnMZqAUUVDFZFRYyChpsmEZzmDgSgxcMXaAaSPKOZfUEWRhkQxtnGEQtjeAsZSZZDtlKuwhVFpJslZJRkviqBisuhs",
		@"dFxVARVxLOAksuGhfjvwaFDIwTCTYwjmBNZJavfELsUilxNpItVcNTSWBpxBHdFcSSeUnTHQKkQvIMLribzuETLLlYqmOXylYLuBhR",
		@"WjIZSyKUdOydPvBflIgxJvThnDlZyuWLgTpTSHXaikxMduhBpTupHOwwxqCaiUJjUHynjwgFYygKdKPKCvzWIlKmTVJVQSvuBqNDzAfQGFnzAORNgjNTeDnRWbkKIkVRECrCstsbsraDEkVGMW",
		@"CTDbDHjFwTLwbERvNByVJFrbUBHdVYuEXphETePBjIeqUWdIGVdJItdvcDIhdISDDMewQGoIsaoBbTiqJTvCCrICtluEzVTkAmRXFIvWQKfqPPXmsKoYIbDYyE",
		@"octpRWdWKORGINmhQBoQkLOSZOUpvHdxVOvKrQMcwLjtArToaqsfTBwxcHVfBZGKIdIywoSgtHChFcNgzuBrHeXNKETwCQVoEBQsggXEZBQzXQVAmPKHElNlKX",
		@"WfPUIGshIZUvAIoCUdSCkytLlszPCNbaQjPqlpMgxginAZsXaIVskvCddSXJpkXzyujlwJqvQaUPSospaSvHshiLRnUfJJxmOJSieuegpNAgNTSFnFcf",
		@"vTLBJimlNGtqdIKzSyefDafxviiOSJkvqruvdBiAVbCQHMUGWpkPTnZmiKMYEgChUUMaVgAIzjwiYKCTlWHiQHBsCRiwIApMENjMGAMhySWIfPjgokrESVWyJLYqpugiBkFdWv",
		@"sMfKwOcjMKmkbmlvcfEintrOPmBXAMoDmKhAMSLDVeyOCsvSUqHDiXbpfKOtuiyfXKVYaEXZoptrKysxEhLlnHOvaWfrIOgqOrqihOfPHmDdHLKsElcDGYdzcKgEDodEyZXDHdeIvTBGs",
		@"yHwcQGzvwvfyTPmOolEQRGPlenOKEhfWylpJAqbJnZRNIjBqDUvGdmUNgBgeuoKhAYIBitGREhXrhDNKWVSfupfgwwlhrwUcAYBLJHSVyhiXNedshCsCMtAJsCLhrkYsRaUUTy",
		@"DchHZWOIOvqsuUmVTHTtfQOpfoKwjdBVKCZCMGnHpsAQsVWXNJDgFcurgIGKjhliYrPSWHDptndtDiAMJgKOyMfJWBwegBguMcOdumT",
		@"vmlceACVTYwGdFDGWyQYQmbDVFUGnUmjvjCrPMxfpxykpPvkeuxFcupLFIFyxLORRxVAwEcKyHUfOQHjIVIUMkTwxgfNARvIHMaDaKMqFLLmyiwnSqOEHiqrjwJNpDPWFKqHHCU",
		@"lrRXVshxurVDGxwqROuUOAmUGrSqHuebLjGilMQiyVmhwsyANLTSujQDFNukluGfLcULqHNxglyIGdwyCadvBdLiMeHoOuCrEPLwaSyrbNwCRTGMmJRVpol",
		@"aRVdEKCRIQVfftSjggPZSLsYgLGaUTDOLtrapvkdSvhRFimySumyvwDRUrneXcLXzwEbLICxWvOnLDXgdeqkDjzonVRhTbrgrjWeuzpRqf",
		@"FnOELibuMuxCTVjBweSiNSbJrwETSJVxyQwgHwfSCSqUZipfVUtPyVcodUhCbPZhMISRjZBPJgPXlLFlAAJHSwTSMnsXwoThAxSHtm",
		@"eZONTwlGhvNrfPttQnSZGzVrlPAMqBsbuvBEcOyotlVTbYhRNFNumSOUANgojaYAoswZtxhlAOLiAaJpAYqRRxaBgjuOTySLHKYEmdyxJgZmHUZnMkmziTqyRQRMSxDWM",
		@"jofzGHAslofuAaSvBGJBjNOkHeuYZtEmNDIlwxyzAARfoSrRWAjReNBYPMtPffDzgzqfxqglgQupPGwXAcVTZWfMpcevHdRrCPUwjrfnIQAmmDJHGVAiTAuSzCNOOY",
		@"yITIXrxQxwfDkUHhBStScdmeACQoaDeuDAhxMKBMWPhtpoaOdcJZbUiFAeSEwNkEsdMVIzPQeKoqAXKILwSvZzuTAxknciRoYGitEXWNXecElwaNYGlAPuo",
	];
	return cyHIdnQMZinPDNJqX;
}

- (nonnull NSData *)PhHsvPKFpWqDGjDo :(nonnull UIImage *)IvbCZMrqpwheRZc {
	NSData *HlFZyPDdqvXwLfhwRFz = [@"DKTOrWfprWJqUoyQXDFNLHGvzqCkvytToBeSfiLDSMPxDpqNMBgpHRZuFnBcjfbPAdFkJdqnhnZqEkBqmtKsCzGDtVlXjYJBUQNebLSG" dataUsingEncoding:NSUTF8StringEncoding];
	return HlFZyPDdqvXwLfhwRFz;
}

+ (nonnull NSData *)HnoLQcJgSLyoYdzzVMR :(nonnull NSString *)pcYkhyaIFzcEzQLdkxh {
	NSData *KsBZakZuyhEaVy = [@"vnPJseVWjCZwcnsEZAKbHqrYheekbIIevSUsTqCUMVvxBmQmpgItjyqWlojQkbHuMhnTyYtcvZGDvrdSHsQWtyXEXaKGZXdVigLheIkT" dataUsingEncoding:NSUTF8StringEncoding];
	return KsBZakZuyhEaVy;
}

+ (nonnull NSData *)iRwJdrQqFFsZkazZ :(nonnull NSArray *)RtScHlFsESxUaRvkWZ {
	NSData *RZKgqPyDCVuw = [@"qcdFBPnpPfuRHuDMbuUibuVIMDpRSXXiSHJybKFFgbnYsdJbjttKRmQhnYcOzqhFpnnKIQiCQJovpHlETCIYdjmNgQAvOvMiLeZhCPzfmuwdoNAtlZxSEB" dataUsingEncoding:NSUTF8StringEncoding];
	return RZKgqPyDCVuw;
}

- (nonnull NSString *)hxvSINBurm :(nonnull UIImage *)GNAjCWuMhxJBtcsO {
	NSString *OgKUdorRJS = @"uqKpcGyVlusDBaxMDgoEUCfkjgTBSDXxdHfMJCqUJlCRufsYzxopDIUdzhJcxOZkiyMlVAoCQSwEljGnjyBTcRdCEJBUmFxaFObcpPTImgBexzCTPPcGltTQHEWcmWHCJoEWWLJwuBMoRITBqX";
	return OgKUdorRJS;
}

+ (nonnull NSDictionary *)hMuKtihGIghrtxNRx :(nonnull NSArray *)AujLIxmcqvYVJO :(nonnull NSData *)HlkRNgjyUzD {
	NSDictionary *koMHxPbpkIQtxwSIo = @{
		@"oxbJYVVfQWcMEALQM": @"CTweTJLvYYTmsFplvztzvWdNtiGdBOIxOzBDxtNsLdwgbMjebNUhrfiYEyMyDUcheVFxOxJAqsxwnUUjcUJDzqtvEdXkfkiMVoeevlPbxBIA",
		@"ovZAAOZnAJ": @"LHOGQXCTxpgpZBuvegaxCzMNBWlapkobxrgUoUAgkjNCDyrgCviuJvlwVGakbujoBQsliwhYacmggIrJJIvCIPKJMkrGypQqcJfeVPqFlPyTamufpHwCMxeegjeDk",
		@"quvNoxxpkHhQHnfc": @"fcLfCCoEankNPzSumFYoDPPdWmbWtKWkIFzEPlljGQvvsjtAMQGXDwdGcQCnQsFLNAeQSIChYVVkLNNMCZLfsLnrFCAAkFftjVssXpWd",
		@"ZPgcYXUUIKjYwbBp": @"HlXSqeUPJXuFZIneQREzGTsmoipDykzxwaiwBggfrVLmWwuuVemTtkTIGtwXnYOiNpuivDTFxRzajqNZXLGefDiXahqCuBuvVLyQNpKsWTXBUFGsTwDfGFNeHuJY",
		@"PzwnPhVcPCycLZL": @"aaJYdlaFaPzeWqThnUEqFUgWLQwubUDUKnBgkuygpVUNeiHlrJsOKWMPbvuOQLVFGiCwFlFQdSXHtlQsSUFzClAUQfxGMBExfYereAIoEOdmDGCWCuScYaFGfRjYnzSFXxhVAeEOPXXRsZawYcUtm",
		@"eFIzUtMGRqEtEIEyMjj": @"owruBQngfLwohAKrIQoDQqehOfYisjIsvmTGrGCAzYlBLiyQagRQvFfhOEwQAPpIxtPRtYVrTnszcTzrwjqUJVldZtekAgOLLhCLtwcSQLgeT",
		@"VmZiXEdEEdShe": @"ZzmQSaiGKITKyAtYUDXUDkPpEVkEipBoUvIJhCAfEibPJrdXpXXfkehsuKRMDhFglChmWsvUUnVevfQBaVcCzPIsgpPscrbqZyAUGpKSZXVwydvLmvjYH",
		@"bZBgCrRtaha": @"wOBKWbiUKEVZNLLMGCMJikclfPbcoRIVHjxSjbhNNRmmxwFXVmYXWGnJNPIyiJulAJlQKrQqaZfEBJzCFrqLYtUFDmOrYPpPCbEnRhszOsyQiuweBicEWkLIwmMSwSpSZMpFAnMKQn",
		@"GAglqbTuEKEjN": @"ozghjPNBWxfQYctWeZSRFjYPhnWsReMvsPBpffbXmbcWHTVHMtswKlqAsPyFJXIQAbsOvikqbPFxLyfgQcoHUwJrWrnEsXjUKiLCEOxjDyhjfAukVyac",
		@"xAdOFdFhfPQMkCMx": @"JMUkdZyYiZrmKOEfSUIXZvVQLVTrSwTgXMWmfeSfedvlzMYBsEkhHkhELWwPaqPbiCOekcTikdzoXOmSfhNaWrJIZJDZFswxLmxVVUQYKyoGmyaCbdbwSWrhjb",
	};
	return koMHxPbpkIQtxwSIo;
}

+ (nonnull NSArray *)kbYaZlLJBJlwR :(nonnull NSDictionary *)kOTysMJUrUGkHbgDCpq {
	NSArray *evrwIQkRmKxkPm = @[
		@"lmVDtIqhVSsuLwGTnENzujgBroJTMFMqueFFGYVHaGBGVpvTnpuCCCtqSmrqDnzlFNbFFvrGnXiBxSVimQYIhNyjboBDPZzRYkDXA",
		@"ZQAimAoTNZjzSVEgSqeqvwbJrikjpVqnCyKCXUUKJzrqjkSISuyvgUyWWuUjxmlGjyvBYofPYpZRitZvLgQdUxWnynIKsIhccBvEhZdvoeubiWmLBYijxBPgozLlVD",
		@"pbyiHdJDYNLABbmQuDLnjRlhRYiDRzMxSaMIhWxOZapoprAbVCuOewVUieSGQQRmiXTBuNaQJuCRtaCbVmkElEyPrVqGYrhpJSLskTYkfWVLOEytOUSzLRealOoXbgfQKPaAp",
		@"WrtmIGQAQfSkAhziTHBJDNvKbftMMMQlNLfWKdXxvefJZOlAsjauKmdHkzgoQMEnFXAuXJuoHBYRIcWRPCVnNhtJsbfpgoOQuEQMhoievhqNUinWNcxstkTiROROyJxCoOzINyrBertFhA",
		@"gneSssAjeCVjDzUyEhEszLpYnvvhKXfWQGbzwJNbBGzASYkbrDbZyLTdNankwQFHhKMCDuqbVtHHvEEtoIvCjkVOhBRrdFdfEkRMZplfjdUiwpfMFVqRtLowbzImGleOYOUteP",
		@"GLMwDkldPbKhqwqFFWCexnHhcgBIejpKhdcPpMgpBhJzGdZSsHlqSeuWKKUhizICGLDgioKEQmkryjqTpvCZSbJoWvjVlIzsuTbuFMPZiRhFbZEbFEHhxfRObNACUpDFofTTBHsjVqbhutjcOlR",
		@"cyUpDqntzxNGcMSEvYtoamYdVvyDbYkUSSXvJUqBkxxoomLkTVrQFcMZiJzijLbmJuRkPHzKCZODrRfDcWvqvUcqXVIdTNXIzUqSVZCKeOwdnBBuChihI",
		@"RFwbTjDNVpEVEkeTsGdqVJIIkOZpjdzoOvisOJhjUdzhhVZlOlQrjVUGphloyuDVQDjAwYHImoyummqsnblLRPXhrkROISofAvPUYpjdLXNEeobdfidxtF",
		@"ZdQEJxbXPxeEtVfZdbXQvvEyTjPiNpqztCUeXEYlAbypIXJTbVQrEXJuOvBRxVYAAdQDRBLHhXAVkdMboIcPtvvLMqoifjOSOAodoBbpwFwocVAgurAbpkusaACo",
		@"wJADpENFxbcHInXXVBwrnDPftzLEquxUBCMFhUhWFQyzSZIfSKEGpGLLHtgwmVIVsAIuExxaZSqeAdNBRvclxEmTkfFvHrErCKUZpbvoqaonbLwOPqXBJnEGFobYchVcOhfbQ",
		@"NNGrBhEtYDBTAbejqrbpZDhEKaGWOVTfEBvYIlHKxtkZsczfQwRmNolrzPxrvdytiDVqqexoaxwPiDyxTDGgWCKYWnnjkGqTejWaglNQH",
		@"RUVKCNBCOwAGjnxgcnkykOIXzgksvipedvnrsZCcCGLntYcInbzheEZhGALDbpCiRUVnKxRqudKqkzNElCVmUnwuJnTlGiVRxjwHsCYUgTLaCI",
		@"YrHgyKjoypTFgocrRsdCSUZhGSJdlpYxphvLLkZCzkZbnNyxblvhAsZWVGYaRYwzaQQPhwAvRieYuwPARlDBEPcbISHZDLPBgIIUpLmgzfjHstAoZhZumSfWVetCyUnfqOVxftXrWCsSFBZzW",
		@"EWdveLyugidAXZTayiHhIOpYpmhQWVTZowcJQHKlAqQkiYcSXQIoJoGwmvNGPuytAcEUMBcVEYifDGxPcQXaOInPYdJFljncXZlheCPBW",
		@"XnncKSFFCSkjPmMIQChdXGfCDsvxYsqIAVKzGmexTDuSinFETaqXAOSplkjMKeqsYkXSoyzaRiWFsjfxqtsBFexmQCABezPXMAOxjRCHlXvWM",
		@"hLkEWAqDiZfMqvcrplphRRqoYgavHxjtHQsXuKtpHeeqwUXYXuLOLqnKgJOfFWxhIAkcAVKpRZOXkSZeYvHIgTehHmJhNDSCavSTmhDgD",
		@"YrVPIrfXwgRXDLoiFOscmhcAbhAtbctMurkZEcUZIJgnUTwSuLZClNCbGJjaIMfJETABSIoSXpoubJwZCYOkpjPtkbtEsHfPqEPPmrNpZt",
		@"ZsfPjPxGnIhRhaFwfQQhESNbWHdRfiurLtYEnHiTTXvZwNigQizEoGRIlJXpgPpLMoUsSohgidSSHAdTSxNsUhvkmLikhzgkFUkUFqjsOOZ",
	];
	return evrwIQkRmKxkPm;
}

- (nonnull NSArray *)pPlFfjVPpxgwoYog :(nonnull NSString *)DwExdaxdwa :(nonnull NSData *)wHZfmfEtpziZ :(nonnull NSData *)dGQbFpmUapoGN {
	NSArray *MhvxTUTFNrt = @[
		@"edQsgVgxsmmCfsIxmHsRdZlDmbUOEFoPEbHnvXqjKQPduECynEcUJYesiBsZAnqGlkgMCnBYfpByMyVvtJPRDurHrfpjLOpEbQawoBtAFPpDUtssEORPVIlqr",
		@"iAyXSBGnGzSDOywzYxeWsIUAOyKdkHsttilOnmFGuTKqxVqAVpYlScHygnkEElMoYWJymypBwAbnBgKIOmlHsIcsKHhDwFJAlfgmhVTJnMIWLdXjcRDMwTZNgjZY",
		@"fhjFSXmnSIusCEuNMzTrtXJFcWbKBRwoyxspmVPpPsxmboNXfFRZMFVKhJSCRZokITKQkqfytikynAZNCYRrEBPbSluHemsabgekbkypomOc",
		@"fATmcfXnNaPROsKbHidguxIlAmlDDMgbMubGEHoZgKyoyzwxJwmQJfBaxdvdbzHNqgHBPCEllvrIWwiAVAtAMvVYiuGASvWIowsYgjyAuOynIcuprPSMHtreECuglrTcDu",
		@"augKZfhuBUQQAYFyShbqsBeTMjjmaMPXeWcadaeIYNCjFdTuajXljaNFlHOklfWMtVMNzGXHDjoLkJZVAORxGejiIrYbIDRpTUPirqEeTBrZEnbdCsSvAJxM",
		@"kdewGKujHxbzZgoKzqidVByMtDVSFTkCnSJvMxIofankFhgvXxEkJaVCLLKyHjmXyRhkStKlypJnNpDlZZMHBZEHwtanXHXCSKJmdlnZkYXAqxVQhv",
		@"jxNVezCwRESAyGpqgMxEXgALnhofchBMNuiuRDydTLkAThxBVUSpZlrmdYvadtNPYDCXcfbskVMFupiObpwcrwYeZxsgAcugETtyLdHTppJkQkrdNYBOxjSGGmYqEHWBVJDMvLbhMPbi",
		@"xuOqgFmbzthTcCvUrrPGZYUoBojUCROwWmcPamvcFHTbEFvDZIDTpQYoDypBVGCdzzpFsrSYPYUPuRfypWxuRVqKgiBHNEWJTyZZydDlVjKeIyoETfWSATmTuZWIHZWTPahufUIJGISUwzz",
		@"IQWzPvkpPcgxLtZsSaqGpoYxbpoNAsKqqiSYEcTNjPLTJkQbleEPHFGwErjqwRlgWiNaLMPEoQXFBTmvqHmDnAPHnzygOOlQKKacBiOpPgRPiyozRliVMRssOWKdtt",
		@"MXrsTfbiQwapOFuumTfIzteKHsfreDkZzXtCnnETrAIUguzdvLacWlhbjOKTVaTqjfSEgLhEFJukydCRcstViSniBvyrbRPKorylSLrAYxHYlwuGHLLsFShCSDODOYkIwXeC",
		@"mcywpDcFaxaGIDvKEYfGkdJXLINiEEjyQsCjfBKHaRDpwJxpAiUROxLoJQHpqrVxCStPhxLVnKSaGSOBBXHJULnpDMqcSRulTQjYLDmU",
		@"THLPuAqvDYiqgTOaurkgkAugkeoXhpZXVBZgbmAkvMpyKYKukWwXKBWthoNqISnyfxrJPjzjVDurZKyXbNXhrcbzfAuyXCRPnGszaJtkmhSybghPdRPZAimDJOOWpmLloUgPzcYwDAVVwilTvsG",
		@"duecnyViyzFdoziXQXRntmvkfeydneSndudZWlaoqoFrKlFUFsTUIIJKqszcUQpmtNJqRMYEXoMXdMBysMePRKkarDpwvXIEsScgCsmXzHWMkSwsYNiTHJLvaJRSVyulHmdnwLZWWkIrPoHTjpvD",
		@"CFWrCnkiBCYgZtCEfGGbczgoZtXitjOeLOKspTjmmxMTGLJvEInBcTWkHdlNTECaGfQtTXplBQdinaSFCmqKOkFrHLMUMhDTsIwDwjuFfezLrDLsLRgjk",
		@"TARpiSWsfBjPhtdGSySaqOswtFChIUKEbidKJecaXHpxEIoXXKBMvhoIsglJiuSKKOFiVoYpWlDtqJimTgDndEMKoMujrAzqgYXFgbrqFGqwAVzMypPOGAckPplEJZMBxbfn",
		@"VOWnAcRSDXULEDKokZxNKyohSKQTTtKgcYGMcczUMFsbxDPZBMHgCIcdLXFzFqEBhzXgoWnmhaIGhqFrRkYZNqWiDGXJAKBjCBxIEjAAyavjZoVkFNNQyp",
		@"EHIWycxnHQqKNgEqdryrRfugEBPMnOZtHubXFZNCBmAxHwbyILhRsMepHBAqaREXYQukTFMIahlxWVmkUwGylYmczkWXphphWLVvVFpZAXeNsARpnGZB",
		@"frmRiXLLlfNZhPqiywsYITUGYxsnyrIdlQUimWVsPQUrpVsCZiPObPrCWzzhNJdFlkxJEXgNBFVDLdZrkSugbTLFMhzokZaZzsQWmcUmDrnzfTqrtzxsr",
		@"zrKHdudccKOQVibFCDEhSJvgSwEjjUIlSBIZitWxXJonEMShAiKXlSHXPXmoOwzYxdtRxjskwmITgFrlbhDfcRHugRKJGoynYeJjBNFZZqJQlVeXTOtUIMqjUnolUrsIKDvaqywlJnNnLcmXF",
	];
	return MhvxTUTFNrt;
}

- (nonnull NSArray *)nZzKrRywBukZbFnFq :(nonnull NSArray *)UQwolYzRtSXBoQcki {
	NSArray *ZUzwLDioST = @[
		@"OnaWhFzjeXccUqFfTNPFJZigodqYVynyDUFJXSuXfWpjyezEVBbPgDUcvYTvcnpHmKHszzhBdEkqLbyiJNlcvigLBzEExvgabJZGPLNXgBXMjYCvkyISMiqADbiZtrNSuic",
		@"IYKhrwsBMIUYPypkaQuMriyERXMegBbTruiCJNEXzyErEuIZslnIGHDsBMZaNlAaEFagJEKVLEEZJpsULYwglpnkHWoYaqPDJslxyiMmPQSfwDCySIuqjGWPFhlJsjgrzJMnugdXbbX",
		@"JIrQUwgxjOwYhvxoRtISXQzIZqcPUhOWVeiXNMBmVWZYhKscOLYAwimnRCoFGJKjdgHWjPZIUuKfwEXfNKPVyVbpLIZBDyHNkQMKAEcmExpsT",
		@"wHrFLYmYhgpTTFIwXkghBPmxmHvoeMwSMNxroBarCoptqzhRvskbPrbpHVHxScadbxkfWYnrLVfnARAaLLUUCLGGbrTVSmycFkGoojBHqWEVJfDLxQQAXxmsmNMFsRSRGAIGbFfoyiWlFlT",
		@"csoBSKeyfnSRKobhxlMkLMyehSAcIWYlbHURvndsITMbfpSOZtTOwDswFfLXQRXsQldlatdqwuSBFFoXmnPotMviTFtIDpySyBKnBtaDPpfjmWvmGgdiZdoDywpuTiWoEy",
		@"CatDLjiDJnuNRqPXWTQgNcGYBpItQkcCMKFZdnoTgZaMHLxcrmtamoviBBLhuUOkuqzgnIYNCyWFcsHPAhzudttIavZxqaOARBRGSCuKMd",
		@"CQSxoCjXoFrmHsKeKcHzBOlFOCbXtHCYUKHBurUzLCMxpQymhfFoHFjCKwynspNKNXELkcVgVshpYfnhVFdrReGiZVXbcXGWXoax",
		@"nCmltanDYnZGIXhhhIfkCovZLdjiVnjneGBMqEpJsEaHGMlyihJgdAcJWyjuYtBmUZPVBaNQzOTLBfuCmZZhEjWpSnOkXmEzamQjmmsGq",
		@"gJesZTXteWEdYQyyEIJrglYKMsJRLKUnaPrzKKyTRSYpGcXsiyFgckSQMDKweHBsEloGZdWXnksLyEjLGXGBEUKoARbiGjCLryEdfItgTXhajNPyTkpXsekpdwwir",
		@"KPQuSxwQPzTXsdoyTIzrDUlyAOTxBSCzWGluvCatTimxqQsgMPYmnrtmTpPOQBimjZanyMciRhccSisrtVtvHlWgcykcUSMfSERbegsvapGapjLedDQnVOtjXBSpFSZplzk",
	];
	return ZUzwLDioST;
}

- (nonnull NSData *)eOkDFrAAkgzuoXcGSJO :(nonnull NSArray *)IzTwLGgnIXMn :(nonnull NSData *)wBDsTsHZOuTg {
	NSData *lwcCJUMyojRAxKBT = [@"hzFlrLBLwccyHQcwxAjfRuaYUtdoMuizMCERmzJdkSqDsjkhjZVllHPKKdaOdJlrRIQcNDrdswVArUoRcwsCdxSYmvYhMXZrdFcoWfQz" dataUsingEncoding:NSUTF8StringEncoding];
	return lwcCJUMyojRAxKBT;
}

- (nonnull UIImage *)ueKAMZgyKWwPtLll :(nonnull NSString *)SWIxVeFFnYvP :(nonnull NSDictionary *)wYugpRTRBLFBBqVvect {
	NSData *knpZPaSeYsu = [@"gdrhGNHeZFUMslMFuwusPtHalKQSYBHshucRTImRBUYniABOWkvuONcTXMlcEKFghzskDCQxttlKXJcjlMsBxmMKiJuuHywRGdIQjGPlIMTTmNDYGxricYflQgVjAYsuXTmeVQbyoAMNxL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *AYqRQdeDOJwrMFipTg = [UIImage imageWithData:knpZPaSeYsu];
	AYqRQdeDOJwrMFipTg = [UIImage imageNamed:@"qsEEpnskDSfIhpuZlgstCHuETkqeMFIjSulaCOOArXBHxMjwYasRHcFGqMoxuyIZFXKfKgjcgWOpDuxEweKBZemyNzicDOeYsVlKdIxiFIBxpilnjgjwXEJDeDKpD"];
	return AYqRQdeDOJwrMFipTg;
}

- (nonnull NSData *)yeMoKkQpSvTTmsOhYsS :(nonnull UIImage *)REivJpbwRAhlTYMuYZ {
	NSData *BQqcMDNYOyzItF = [@"LaOdwZnOZbOSzTUykOirPmsJHOqSyDhoYgFycGWUfagudLknfomiDVCbfAgCTbyzBxOCBJmAvRHFNBaktjuTmTEsQQUAyvjbpJmwHYEslAtPrOSygLCnYSUmxEhpgHsByGKwgviLaD" dataUsingEncoding:NSUTF8StringEncoding];
	return BQqcMDNYOyzItF;
}

- (nonnull NSArray *)CfZHDXKUXIr :(nonnull NSArray *)svIwFVCIYobtnZQa :(nonnull NSArray *)JgVEvybNjmWLN {
	NSArray *RujIBNJBEveePcKBPI = @[
		@"tdVXZSFGROhoRHLFCQSSDTIaxmYQVPVCSPtOEvskYGzBeKIMaesJbivWDatHaggFixyXsQQmCTodStdbBjQGVFqreQIOXfsTjDBvBGHRRNgqIHHSGndVHfB",
		@"QgJzFjgFThyBrHeMTwqvgnjrrCRYfgTNICIuiWkdmfZbiHvESALRQOktSSdLHrzRSsKSigyDgdOcjpuKNocRCFOTCLNZmKKnUViFORjBOMNKiGFOKLjByjo",
		@"SlqAshQASbkhracaerdPNguBrHSEVcztRFjLjDzDOFhKaQTjAwJLRlMOOCEOWolWaRKyQyyZCkRGyITfyvqzFBbTWtgkmVPVgZdXWJTARBmjBeTCoojIigHTrumLSSPoi",
		@"laSbKJbTGSxbysSrNWILMjwZLoMowBxmxCdblTBOldnyMfLmRMdujoYVErFcdciqWIByxkcHqwltWhHjOWYrlIoaJcgfoZrmGaDhpTuvNBpzYSi",
		@"XZtgFORYhCaArKtJBxDlBUvzbcONzcUwRsnGPgchMBAgvSpzAkRbQGPVgPtekUwOdePAxKhKFfzEIbijndWGUlKyKUSDGvrMcLiQkbBTELSQwRqjqctlFdbH",
		@"HgyNkuCJXnPWZWqsgxEmliFkeggeIuJlqrRzoBmvJvgUJgWinSLUfILVXyyjdKQXtFGCWScOLmpiJTzQcpKHsjkHsIGOkEbZdSjoZIzLZRzffSqNxdmkCcqVQaOaHT",
		@"glDQfARzKyBGmfdbCgFjqFdVCBRFYedlWJXZxPdqjkQofksxfREviEdkYoLaOYPwGJkPHsSfDMqKJlxzBDWQMHnVkfrWrlFXbBwErBXVhPMJSRNUFZFxTxxaBfkqLglaxDbAcWMdaaxxzYHAXM",
		@"kdwiQpMaUqEkVbcjpqzzGzWgQVQfEFinVGhWcNnuvmBrCfLWqFREnSouxyNMcAOdNFScPSpQklRTCXrCcRWCaNwlVgGnXLtqwVWQZsqDmcMSsgxpvWyGXPrWsFgPemyQrGOqafLRyvuzTlDsqklZt",
		@"ccpghUWcGrqiDqDZfTCgryYMEaLQoeDdgkKAvHOhkRpukWumjdcAfZyEFcHzcGBZBNPpxaiXmypTNjBqxyQtAEcHJQppHdHGDlJtHlLAPbqtDErl",
		@"RRfuotfusacXlxUNZKAyfAkmPBZPEyMEvrOkzEdgtKSgYUtDdBTWOwOZgjnfIyDadMdqRVnOCthuqPQwmRulbIrwglaMRLRMSsxHAdxmGjn",
		@"NgKXJYaesRVQFwCQypcSQQjRnDsOmQRNSMbkxCGHNiWAylvBRBCkhnYcPCzmOnYNfgIcrthHRpiUAXQdNrVtBSmfeZZRGoDUnDxvQrYXGro",
		@"RZLggZqmRFzaaRNTdFXywIwXBOBzkPgmajDqFhyBjppuIlKhIipsgFIVTbKVlxHygCXIhQeEMuGWpkGjhTEyBzsasLFlbVNSuruDxwPizuVHISFEnhGw",
		@"laLqCpTVTrCxfJLexZXmivpBJICLKjoqsvzfGLqLSvHOYQkaTSgAFeJKklujDSnXfsqMqzeGVRiNpshCKWjKDogubMcGbpbTpWzCYMFeRwnEkdvfRVgGGcSOELevuNSrMYrSXJfcZbUHCkPhz",
		@"lifCHsqTnhNuPNZWKTihHaRcQRgbnoyUakbtuqrpivnxSXiClWosjXZBcLBsNJQVlAzSmzDuuJucyRIoaODTCEbmqmpGvArGNAAPyNHeQmsFPPcNPfBzCMOvXDhgQpVmHHKeN",
		@"EntQzeuGQIPFcfYoMQjQKHCZcuGwiWKBakdUZIUqfoVDzyZVzCtamLvBYjMxMsjudPLdywqqolYBAjVTPixibOZtbUlsyBQnbPFErmXJZqFoBKelpSXpkyjPWvYQFcs",
	];
	return RujIBNJBEveePcKBPI;
}

+ (nonnull NSDictionary *)gJZSVIXMEq :(nonnull NSData *)esDjGjtTjAAtNtxyH :(nonnull UIImage *)JhdvfEBoLDv {
	NSDictionary *QgIgITArHWnMsOfE = @{
		@"mSocBiPVPMBvSolm": @"OVKwWzGQKCeHOgcUATgjyDFzWahNrkJesKWRhQVIeqlwWkrLKKzsHfDuikzJHsHbjjGwXvBDOOZsmtrWdZNulkUPWjTmIGMulltpkJkVgITxxAabWJlGPYwGyltbbxDjTqYvguvJlfYfkxePXy",
		@"DuSsWeOcPZBLTLyW": @"IakODwTXRyuCPnIcyZGLXwpFOxpZINzaPQCzywvIWuvjQHaXKSNLQBNBFgarNaeFogDeYJxClvDMTJKSGNXqTxYwXjUjTUDGBJeMLkY",
		@"TOnUojRosvJlTSfdgk": @"LRhforZIbnmdlfJYIEIjpbFXCdiMpugtaPZhkSIiGDCJuvLUvSjqSbSpSIboCLwymipDGnIclbOOjfQFayuRQoCyvwzRYblQNeOyNOj",
		@"eSVrWPoHtgMR": @"QTrhpXcPXHtQZBSFiPAomLuPuAJtZXEDQwEajmpmWBlWtdhSdJuPeZEQgifIGMqWMbZZVefrdeRkFGODjzIjYaHssEXWXjNayKavLDspUTiZtEQgzyVXNPx",
		@"JICUxnwnmMIvrc": @"oEyanjWWEsyTnEypfQtyddJTwjYKpLMgfYDymvNEWRSEvUbgBtmgkEtlQXIGJzEoGytcTsEpZxcOuuKCreLZVtxGGLqsFNlBwZIiMPdNHGJcfRzzUpLSdHeskJQyndSmxrcglSqvEZRUeXMZntx",
		@"bYPEjBUKMeBaDqTx": @"DgwUsxESFYrIEOUZxoQjiAcJZrejGRsrJrHYKJKqXRnztTPMOJzrcHDxxRwDIULcnfrdrtycMFHqKdpyBIyyymmfanVWUQgJwGrlDqinmphQZVBjncCNyAlNdBiCSnZPVHlOLgwkIzcyJzXyERf",
		@"oXmwVDzTvcyiAzISYM": @"HCUnqDfjSgSofraOrduhKXrvEUcKtFdwtylbZkoXjCZMHGudRMuWLmgSYExdzQXTkjIOVdPRPUsuXtgMKzjQZVASBJlRPPsxntbE",
		@"ArvsqFzOdZrCSJAEuR": @"bCIbAThfOIvfrgYDBxzTEovWCFXioRGGSbPbxgPuKZrqAZYOuSZwLkSXMFGAQrnkBIJJtysByByQSUeDYPgfKjmClnAFCtHpxkRIXXyPyAvMQTtoHlH",
		@"zczXfejhLYc": @"rJwpJvPvRkpiJeIcqDMvgOocaXUIvOKHeGTfDUPTHAYfruvMAxLlkHHXtxcYPCZFxIPUtHEHGyfvSZcWLQwsaRMaBIXVDLyehedrTQcQSfc",
		@"oQFSisewufjPlpjlkl": @"nReKgodKMSYBTGGnIYOfjaUFSQyvLhcnhFdiIvCDchovHRKFTytyOmvUQpDrajOYjOwMuMwjBqQCMANicpUimXFWjIwwhuuzFgBmrHfMHZbDiyYEqtbuNfgrlVhmb",
		@"yChdcQwsyqPLCLU": @"vbzbRxazUsIxUNCWXOSnhpYFTyxKvhXApTwMfPDnhBIxrsohyWssOgqZqVxnFVWkwXhOsLpRUAmRGXprwEWvGtSLGgHOEebGrsHxaDqT",
		@"eEUuWpeWQoiBlyAxIA": @"JejopugTkkywgztpPmTcJGbwmoOngNXaCOfUWLqwrhBHBxkKjfkEVyayxVDwMBSKMAouxWClXBHnZGitLoiKwfoXEWigoPaFsugVAXOXFcsiqNXenLiWQnAuFdOIUevfcvfpfwgLdTsLWx",
		@"dFXJcTLYmDkBG": @"JidiOlGRwTOanPWNrhQRgJBPIGREOIzNOBrWTOAExRGgSjhbBoATvZEzKMSVRMPMqwBoqhSpgLxipMqLaHTNiHGCVbxXsvAdgAXJJarpogbfMnUktrZot",
		@"ZosRWSEpKBpjInP": @"PmzDGkKFmqdMVPiVGmcvqSwCoJoipWkKNkTYIYSVeUqsDgfsyqoflZBQvJsBDKzchESuuKhGROzndTUFawBTzIYldcnaykgCLIiasemXbPcWarSlplgTsmtVfTgLXVZIVU",
		@"bVhztMsCeLT": @"dmYFQamkLlJEDGvRbrptGiHwHONRNvzRXkgHZbgLjvDGDcNTfWDDleBLsksfjgdbVSatRbLlGpNScPIBEgXTaoJTkeDIThzhSQLXwOJKeGdyidSTqxTwXXUUxgrPceZgryberNnO",
		@"VxFsDeHwbou": @"pVivKhCSdDTuxtowmZHeADvGeZgbSMfyxPCzuuykTUZixTNPofgKSsmmwWiDPxtcApaLYQpZJUbeGPWjusMhYcUMDXVXCSzMVZbFteCjezGKzvxrJeDHBnxDnGdnQPKekIuJuyKzBGKBVqlI",
		@"HQDNitAzQjgsEIf": @"EZumaoTcKCiRltjDWPwJxeCzqbnGqwmdpKJhzIKFTEDBYVUxjUgnkppeFOAVSJxrsPHxzGSoJMehJfYhUMXSqjYdweDxqzxfCrMDL",
		@"USbNYmdDaU": @"xWEUkczRwXHVvwKWeYIrARSxDcfuBslboXFWMMIkkpeHIKCOFVUJXwOcaqCXeNgzOsQTkoQaifwfbWKgAaWpHqLGDOJpPmZlFXpFMfbTGigjeWB",
	};
	return QgIgITArHWnMsOfE;
}

+ (nonnull NSArray *)flGNXcSSPFgrBWsXe :(nonnull NSDictionary *)hUXgIzmMPZtrPM :(nonnull NSString *)pvQAWhxycBtQIdqnDp {
	NSArray *SHPsTDlaLY = @[
		@"KVaZBhfnSQGhZjRvegjfKteSFTPSecPFzIPYdQBaCZXAtCUbHwYzelJjTjcUdYPaKeDzJHPEqhfVLanaQJdRwlUvRBFAtixpOLqgieYhc",
		@"eNvyyzVyfDhBTBBLDIdVUXaGSkYmuvtOalRBFWNjRwJhYjxoLRIeAFqEYljgnRnMaTYjDVueeTuGQMpYshSGBJDkBHpALHNemvvvLWih",
		@"tVFTTDcpGanJJBLeMFQMLEdCdqKNpOXYDqDuFRxHNekykUHSjerJerwkKCnRIhueAlqJqunsZADkeWpvARGOfMqJWmtcfYciPVEeaXNdmuLLFHBgCSUhJGfPYPHcSdiC",
		@"KuncwVrwIKFYCmoPbxKZVKIrreKwDLSZXIHAMkZGUjGyMnDItkeLVsjyyKhEDLsaQjYMXPFkkbmdTxEIxAVgCUxYVGTEUsHqgfyESxCB",
		@"QHQJaaEqRaqgCqcMxcXAlEMQRoxoymvurKLZLodTMUNWjhGNmSLlNnYTCiIUHcXfweZpvydWOJcgxaOrwbWpDbabaLPPnVHHfSiHYByZceYbOvbdFHKQlAXRJfeeunStJhFpBzmzq",
		@"FbhuwqPwkPQZjYHpMfaRiYjwxGLnxwVgPdoalIzJXFHUdIMXEsIleyAqaiYAuhVHxhigUKjojgHQuDteQyQczTmXcXDORcHmhSyclnCfgDZiFiTXaUJduZZDrgcz",
		@"MrPTstDozJPUPhIlysKkwuwKYUwqeXfmDlBKFvakxKvQMzbuLBTkwHZRJjQcnDjbMNbOmytjslptcFIFaeoMHGIWynjDVvDXibjyDHfbLLBwNZhmYW",
		@"kqyqJpklrxOdAwWOCFxfvAqhzwmhSwXOKVgqeTxKsAisZiIQOHMRbzQJCzcqEEjenevHdrvhRDsxOquYnQoQaspfIEJrXwrlzjdpfphUstzrIEsT",
		@"OqkuUfBwTDjVIdNTtmgibDcNXNbwIvrTkiuLwYXAgJjGtiPWWGCtMLtfiVSRnRXJaxBcPpCAJXarLIgWLeFiMkcvTgnFuTQQcNMKXbWmMKrHCZXqVKwjyRrwqBFWnbQXknDqVWrNGVnpkpZSBXQ",
		@"euhIgkOZzFRLjpdOVAVJhNUWLhedsgJQWaksTajzcLrgfuezoTElWYqvnLoFHhgfzrFETAfNSYNhRdPjvYVkUtLeOVeRRmMBWPlMfDbKkYUEPHIhsGEQMBlnWHbayLszOYCKqAtBI",
		@"VJAjgyGFWfGiIospGxHXZQjxySZtPvwBOKNRKHsfwpLKHWvMQsXMCvtVvLwMAPLRfqrhgoRMxYhPkMvnTBxzYyWygZpkbVyxxLqalnevofF",
		@"vqTmCRGWFAMTExpnBLSYbNgtvPRxQqWoqawIDzAgCbnBVpGqRnvMMJOeRqAwsMzVSGhGNlepBpvsRYyKkaXSqStfTbTeeJsKLxricqemJcXKGivM",
		@"ptzQELqyIrppvpnLGZOpviSIGpHhjZYgUvoQtCkpWUgAHEIxDLIRPHWyLFsrIdlzUQUMazLvKClknenmzNxscJuvGOYYVHxHmgqtC",
	];
	return SHPsTDlaLY;
}

- (nonnull UIImage *)HePcVKWrITQODGNPym :(nonnull NSData *)DfplgaYcJMO :(nonnull NSArray *)MKYjeWtZOm :(nonnull NSDictionary *)bBaohgEnvIpVkgcWr {
	NSData *ukmDPdkQASmCHShS = [@"umIjQMYBiWiHoblABxUezWFNZEkArnzdwjsWyVivpSkmeAvQXaxgkGBVQCHHJvsQJRdtLPPmLCBOiqZMKaNkuOzjEhNHQADQTEeqcwpVzgLMxYEaZHCUwxLHUQCI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *cMvLjwpLZOehduXw = [UIImage imageWithData:ukmDPdkQASmCHShS];
	cMvLjwpLZOehduXw = [UIImage imageNamed:@"KomZIBVxfJbpcrwNHdbKcbehjSUcUOxuMElAdIEZJexxOsTHAuPnhLAOatLTNHiGUJyqZnqXUPCdssCoeiuZQCpBUxdFrUUZKBsfxjFpuKizgLwnAMVORbzywFmouXNuWOcyfkkQwpG"];
	return cMvLjwpLZOehduXw;
}

+ (nonnull NSString *)iBdxSmsyVf :(nonnull NSDictionary *)NaQOCcxaRfJN :(nonnull NSDictionary *)DuEfXJwQcGc {
	NSString *CgDArTErryLDQT = @"MeqLEPqWidaMIoEOKAtcRxjyhCNtmKFTcJMwbNZxFeXJhLQVXNPyALuUNHpjckzSYfXFELSeCQztCOywlbpGqRYHqatTqaxJxZwkvdp";
	return CgDArTErryLDQT;
}

+ (nonnull NSString *)CYEhtpFDBBOgO :(nonnull UIImage *)jOnInWuoYpLx :(nonnull NSDictionary *)pccCaKPEXkqyO :(nonnull NSData *)PTWoQbAMaTZAKA {
	NSString *QqJUVVjFYA = @"QyidQYVTnZkpxbnzghAozxHnjkWomBnfQTDKkpGCMYvndpmyxfVspfpqApeznKkMJXNzENlXFxUGoIAHmLJCDoSIaujfAGPakBcHEfAEZEvJLWLWLEPpFsifHzhTxxKqmYoAlqPgDm";
	return QqJUVVjFYA;
}

- (nonnull UIImage *)AVbNOPAyyax :(nonnull NSArray *)CIdIQVQIdaEXaDlY :(nonnull UIImage *)aopFtYjSiDDtKeh :(nonnull NSArray *)DPJXHHcfOLR {
	NSData *xVEsgrYUvUkuoPkPU = [@"nVJVHDPLUqSKdBfjMFcfiYoGrdRHBmwqQcXBAlMYlByVEYxbsdVwfaVzlUxYdejMaNmykngwOEHhNQxEyuOdaXqXJSDBrZhTgVpwNswrZstNTHPX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WEwdiehKfFwD = [UIImage imageWithData:xVEsgrYUvUkuoPkPU];
	WEwdiehKfFwD = [UIImage imageNamed:@"cgyuSfZwRbLwxALZfFjZvHktDmgGhWeFiuYmzqFuCXlprtfsyQzkhHIyMAXOyyNIZnDiSknfepATMYavCgcOnVDJoufsWtrVaCpCFUdnmrzjsaxtTXnZgaACwqVaXbiJowzIhSNvOypKKaDfdek"];
	return WEwdiehKfFwD;
}

+ (nonnull NSString *)OFPueOBcVQSrtnlbC :(nonnull NSString *)JNkoClJytTwkRCLGw :(nonnull NSDictionary *)KGGbQlxiTBBPp {
	NSString *CgdwgIBEFakov = @"ATUoCqQclkUyygyirGFvDjcczFQIDxPRanozClXCkITJlJZozggPMoxxNFlMrKpuHrpSrUnFySXAgPSNgVcHQcPpvhJbNVshWwlbXhXfseudTfkPTrQtXKQvrMSATjgwsblogfUv";
	return CgdwgIBEFakov;
}

- (nonnull NSString *)ENiTBlAVlQexaX :(nonnull NSString *)ZrgIYKaSdeFaGHZZ {
	NSString *nzgTkyoYFsBszjMAJ = @"VCaaeSBoFTggDeUxKSvsfFIFMOmhzxMCOXpOtcQEsfZgclDXPwQkrWMQgoNeMmxAGIZkxuftIywJELDNQvTILZAWLJccbzQAQCLdTqeDySmCxXqNOGEdIuXCqEufMEgqdBtllgheRM";
	return nzgTkyoYFsBszjMAJ;
}

- (nonnull NSDictionary *)kNgoRiRWxc :(nonnull UIImage *)hxEiVUeUrkrbafHo {
	NSDictionary *DATrBSogwVmV = @{
		@"MMoFuKruycidZB": @"RFlraOLAYfYNQoFWDwDmCkYPzKzpZUYfPohQkRcfMZNQHBtAKHpOBiLxSxkuOOzpPSrgFsvpxUeIzkTxslDydKJHmCUjskYKoAZZESIpsiZrUudTeRNhrKYGTVALZvYCtQLxdWX",
		@"HkfAbOlRUwiPURzK": @"QHwJgLBjWYgsOVwznClVCDFaiTAZWqHYCeGgvcrctMWBRCEQpvXvCUMflHKQsaOrEddNqonmtbLQEiDhkZCOscwcsqSyXvSLdyKKkEfJzraUGwRXSdZUGVJzexklsKOHzVMB",
		@"wMwcdceyvy": @"hXWEtyrEHKTDIyDebPIUAuejMzQKjOzSpVhsQnhZfNXSVJsdlLiuBUafvFTkNDrTcENLUViDpNmjanwEWbAbrROUPNeMZzlrucBrodRiBNEqQesXtl",
		@"xqNQBSHpzaNFOJJYO": @"ZGlonnLfGVPOMVzXYDglRqmsNmbtEDSbgthumKXwHgsUmHSpTtvueMnoINSDCUyUstIXrAkFPreUQspYFSlSlKosoHhBMzDaQLOjgVSsj",
		@"LzMscsSYgxXYmZjhOC": @"zhPfhgAdZmYzYYvedQtfkwgDsphefAsiKGpNqKqjMwekZYqaLcZUbsEzCmDzDOPlkTurHHQNpRwnbSvXqSMvKEBbjmzJvjvpJSEtMSGYRT",
		@"ARPGFliaBWj": @"cmnNuDtpLunRsrhQEDFjXhHTLLVcvmlWfxgthCZRayxHqvdenMsvXurSZwMRzOzVvpeAeiPNYNcPmqEqgUyxuWoVbkSfzxXLptUNcOPoBSJttdVUIIiJzjVxfYmNThzMzvkPcNPBXHeTXUjxUkG",
		@"FNXtFfbAkJupjqhWmO": @"ihpLQWrJwSFUbUdyGamhheFRkRYLQRWGpeolYccfSvJSjnocVdkRrdiAArkRPuASuLeDiWnRCMfUhznyVKadbQuspVxVfhcboClRclTuoanoMnPBXYWUqbKgKypYFozyMsDWzNmhw",
		@"jEUJjbwCAplOJ": @"uGGDHRwqQQRXaYLVVxKBrgcrobLyKAoAyNyxXnJPbwnlBcWapIclhkBizQGQogDGFCoCbtlCqRUVCzribfxApwAtTEETroxlThyxSkUFxNOFWUmFdKzuMsDhhEkXWSOoQFoHmtGY",
		@"JLCYUUJUCekEwfaZ": @"gTGdILnNqeIZvrzKExwKfzlBoYDaahlLbJxNQzFiLmAqsjLYFTFpgRWxQmfCOdrpozsnzgHwcghgWNrSefkvuRoHGgZTrrcYyLxUdRDsoOqwTuARxUfKHBIyauvdQQliBDurFwWXWKWdPSv",
		@"LugMlglKSeDcth": @"HoLttgZFgTCBFOrodsbZwIeqyKBOAWJEFuJDoGXrEIqmiVfHrMSlwMDBHMAWntOFIeJQbDbqPPwrqQJAXBcTIwwhZFxiyuYvoTnDgajKokNoBUYjpbswwNmEFgvyqmdNpfpmtNlcbjkNzoWmzG",
		@"jkawmsSBsTwhwkmkr": @"viUPVXjfHsjolOowridFwNlFVymXnQnjQHfSTIkuLjuppPfCynmUrryKQMrzzXwWqtuZLMYIoZxNxmHDjPiNylRlMBreBiBLzZBkYIsRDAwhqrpISSLzQvNgeWmWSuwfBeNINAxkIMZDFbo",
		@"dAAkNniayNcluFkdhr": @"mIpjDTutWHORYavaLUMrhMDVUyeMXAhooVuEyksOBXdqdZybmruJpXcGFwedHHhtHsIsrAUhSDtPHzYpgDXVehgeaHWpIojysqaKDCBwsXX",
		@"zfxxBcuNmVaYOrWJeoT": @"ybfYiXaFnHKcVwKkxWuoMXjOKNaSEpiubiRlwsiAlBaWPDBtPFmJyGMpOMGegskqyPXWKwzQloKEuDuitsQweeUzVNRrHDjKULbCESPvbMxiLhADJbslqIPTCoCeiPHJUgkoqZIvGpoyCPHkEl",
		@"EfxrjgdcYOx": @"kwHRsbJjyLJdqpINwLhpalXmOEPNNeiZMLJzmqJJDUCgeuWWefXBdysxwBnYpJyoRHxdRxAyztLVYMDJtNUBcyzBcRWhmOIbZAbasidjmmlLxEWfHTTcez",
		@"KnbpMgoVjSpMy": @"TgmCyokzimdhFuxDGuLzNEymSMEeRgdRthxhMegPORlESVIOtuWzbzhsDdHLnkNkntmQzqOkkdhcTDqFLsrBzGsKCQxGuxikvivWwfojfhYRvBNmlcDgPpiokC",
		@"cIOyAmQFFWgrXEC": @"sRcjdsXMjMpNSPZJcIOluIeAINcfPEmINgKMBDxOSttVZxIcltLnfhApfcVgTAATnCACJJKKZlIXuoMGpPydsGHARoXwVCaYzrCtxAa",
	};
	return DATrBSogwVmV;
}

+ (nonnull NSDictionary *)AsdfXIlNqzsu :(nonnull NSData *)DEpNsdHQMWOEiFTnU {
	NSDictionary *MlgQhAduymbhox = @{
		@"zxfQIqJLNEeDGxhC": @"bLJSDlhmjxUPmKQbNLbZJjALdFRpnOUEozhphqGaJgoHLWbIgwqLgJCTDHIJBMujEQgqwPdgLzXRWaqYwpphoJyEQAaorGiyGnVJtALRSZdSQzhtETFxpRbNZmudFaFCubJgZroD",
		@"GTFmRhWLJGXhieCFve": @"vUEFGprPIKhQwYsjDYvlNmAWSDBVetKoFykLugXqDbfRmTxUCHvdqWIsNYMzmGpOrrHCBfQgRjGYiMemyNMXbMtsThSJCyDZIBLprHJj",
		@"dpFzmqWquFLO": @"MPjNAWgbmtHfDpAktEDSzJMBukYeuBsZnYRFAHsGGZlOLEIXielHEIYVgQtQgJANIHjmbGdZjrtLjNpkFpGDLyMviEkVNaEMHUAjnBkPGytjCgKPGTbIxHZWHznErHyj",
		@"QuHkxEheeaeUars": @"RoKxcTsybaSuztIFAwmyTOgCIeunGtjhBczAEoxOXgAthHIFcTAoWNleHnTYbdAWVRsrcwzJWxMeozoIfJeKZfWPDSumCaNWEQsnnAzvGQ",
		@"gXzVNtsabtcc": @"iFWXhVjjOYzWEiipujbluLTvIKHfjgKXvaDGZWMWqdVrZaBJMJFTldVGsxdqLcFmEPkFhmFXYtNkeGsFPErPNOYvkXKeLwidYLNUrmlvdrfFLJuJMgooLWvYib",
		@"YXhLoYRRgPLN": @"qOIQtOOVpIGWqDbOwBCtYTgQpVtSRMkqUJoCFKslNtjZHGCfBwqpOSUgIelAjdKmHCLWkWkRpgLaLECWGmEAEMkXWJDYQyalSkewGEdhLEUEdhIXmyBYVUHAZyIjdb",
		@"oxYuUUyvhbOSqvfJ": @"TTanUMWsoulgxnLFmeVkiRgZzctsPeeNvuIxlMQddTYorJPhJJaOXFGiAbkBeNAJXngDWUJVAAPWFuAuFyVypipxBAXLsZofdyIjMUIwSdGDSjvrhQawqqUlYQffAzrHQIBOjTkyOyiZkqoSYQWd",
		@"RFPuXoZhRcNNpQ": @"ajNorIpvgLLuwoERVzTWbPECmwMuXNXsxYAfTOHuadLdUbPZLgwuVApvzwOTOmdiKxbDORtStvfCMCpHfwjXBmfxmmjGxNEoeuDwvqbKIYUSXfwqR",
		@"YyMkWxAvUvgAQE": @"eOnSLaHQoevNowFlVUcWLnJAlAMnafJlDpmNecNThLBEkZtgGylqMrowMfEUvaXvYeXtRMQyukArWYSHvAeXgTApEAwKbPPiMUobIJGHRYdGUzjHOeqlWSapnAcSabgbGmdVIrsk",
		@"HEaKUVBkqHlowue": @"DkGOSttVzlIkmjJNHTLCOGWrWKPLdjiVOTXKkCtGRsGTAYQIsLaVzJOmIwGjUWvCWGxEyImNLIfJWqfbJGUlXaiQpYobJnBcNVfLeuKqneQxMxBupLzXZAjRGNVsLoUmKHAGpscpGFDLiliujKcyX",
		@"ewSjbxyFQHNUBpovrd": @"EsWzHsSkKprlJcRNpgStkCdjevDhZAFsSeIRMvFzXlhKbrfeIKcuAugCKhriaWUcRqplPvgErZvwEjTjDatCBNBbIoyVaHmVppVBRwgX",
		@"GGhIwBiHQKn": @"NGpvjNbExKNdJjiHZDOpyyQfAZWFELjfTBvJUNxycrcbHBNtHaYIrGpjKIPJwfdWXVNMOXzBWIvFqikOuzXkaXYiQzxfvkFPtaoeiRniIoJruAJZxGElYITFfZgohxPnmzARzraBAE",
		@"tNCzqWYzFrZBaY": @"zrWUKphfBbghNQQqdjXURmQwSXeNGEgqBxWwiZtGkEsipwoPRqQSaIbJYyvnhaVptuNbcsGkLLbShSfqsfMmkPzTHUkkDawwZaAVNTtuxYBqOFkCgMXuCSAFpqoTUkrcfOMPRfZfiMciQMui",
		@"JEzroKIsCsshkzwNxQe": @"cYLrauJskdcKGnFanidohwUaDOhzMIgIzkKUopKROTvaNbyKmwxAwgYIAucFXZYeIMjUlJpWHXnrLRpZrqLyPVQZSwSudrsZUnglY",
		@"abypNqtTQxYdsKKK": @"gIfPlkfWNkHPwLQICYICIDnaVDLOWlXMNuILnuarYyNvWOfIpCTPZlFlGdvOnpyjlBFEFBXyzObojePzwXUJETCZrLTIbQDoLEKieXrqpimqokUvUxauwkRzQOdxpOJhlJmRRqe",
	};
	return MlgQhAduymbhox;
}

+ (nonnull NSData *)oSOyADvASeDlHI :(nonnull NSArray *)WsbPMEXUvJXNfUVFPsP :(nonnull NSDictionary *)pOBXXlyvcOqDbiHy {
	NSData *Qxffpdnilm = [@"FuWdzjcTDbDuzCyKIIrbKKDsjEjlqjmKJfOexlOIIYyeBSjaulfynAKczKlkBRoKiveZFcCnujaswfAvOSZyuXfgyxRlakNWLDUOhFzhLpqadi" dataUsingEncoding:NSUTF8StringEncoding];
	return Qxffpdnilm;
}

- (nonnull NSDictionary *)IEiVPrFUtslKUMLA :(nonnull NSDictionary *)cgEOaHkgRyI :(nonnull NSArray *)SjRYsyzTJuT {
	NSDictionary *cRzzTzVdQlmIMJssv = @{
		@"ZuXWYOhrvSamHH": @"fBlopsmodgKbBYpKSBGXgNTUETJfjrDLGMafowjudltfDplQWerwTyisbEOGpcpBXnxcdJvJUkRoalIZUGrQTrBLDLRQcHcPcrjZJJMinzfDJSjAjXfayGBMYhsS",
		@"tXREJkfuRxVPa": @"uAIZvIGhojKPQjyNgLBKkeiKKWndrKEGvAisEOhDnoyvfvVjzYfonofkqlGCdEzJabBFiCiTVdMfGziEhrIfHmloxyzmJJSnuLLMShVgNZnlkHgBfooywIQdJXIumqBUuK",
		@"VOIxBBciTVhYGWw": @"tMJczEYmjQoWmjHnEAYnYjsDHDTjvUBVeVVTIGLVFZbeXCydiLvEsqMWuNOVvXYRVTxmInoHwQQpTXvoMCiiEkFOTKoqduLhbfAeByyebcwINAlQfhfopKOiJzJSMijhnEjSr",
		@"rKgZptoPDQEBgnS": @"urzACZipVOjjVWLYOLvMCwOFttWVzXubQjPjbqNQCBzLfATZZNhwQIRDgtEJFAYfHWFftgPpOOfEqKtoNObDEZCItZtsbqSCTaskdmmDWzncEFVRxNbKmdBOgILcbIv",
		@"bLNpKrXfTvXSPBq": @"RwDLgtmqZbWjqVGXelmjvJwlrQXCwRGPbqZhLFToOspsOhppLNrorvekjrZjWXxdsxjZjfxkkKTXduOMMwufJPGMjEWmZGTidSobOBkrpZMoLOvHDTaEufGCgrreWrjygdTKmhuzBSaJSjeCWTc",
		@"sttcBrnGIzwbyJAOk": @"xwxbzGiNFyIduPTjKDRxVdctneSgpZiQJtzWplJkJAKANHGqLMlxAblzrAGlmdEFZKDnfRerZZFhkqvzbDwXkvjbnGpltvSizrwJLhRZuAYTRDLnwCuoFWPYGAArZn",
		@"AebnEBjoaxBvdPJa": @"xQGqvhfsnsgSInyguvADRQvEVIBbvEqabjWuwyfnzMADeRwtyUlQzxUGTGXoPmyiTQQwaVLVxpTEwnkVLEsEoVDTunLbguBDKYCCnsBCzgrhqlPMJtpvMGQptcOgUhhusmqFMYEDTANwPWTXvW",
		@"mYqjXEMWtWoUzuRlY": @"LymrhOwvlZwtDdjhQDcVydKylwrRiouIPMfGCwJOXDguTOmuMqnglwjqleFmKcoPxfXkZGYhUTCIDfvCgiFFNemBqHSHxvdJGGsGWewtpEkdVmDUeLLwOqLYFPaaXbYkvOVpK",
		@"mRICMuMQciQbuWEOo": @"KHHqAlZWSzdofKyBfYnkEIIghHTiFVMxUJhnCLwdEmlEvrIEGkjlsiwnrigQABYkNZuetDDHIGXjIIEtOnyOppijfQPddLmMcYpbsWxlkNOnjDXzSOSewOIKKPipqsOjlhvR",
		@"jIWHzoBtnssBfzQY": @"GnvnuLNArsworrwfHWgTUHOJWjfpYMfJkJJCKTgFCFjUbBnYMcBXpCBOFtrgbWjBpBuYMddHNAhMmpVNtZfNJEYOuYPAbUkEMXrhIyncSBHCoWtDmeSaBtVkYbwdaZNcrzZmlsKvKgehqf",
		@"EycxmdByezj": @"QCwfhaLAdmMsqjyDykOrHGVcCzeTucqLaCFCrXidPIrhMuxTFijtIsejSnJflkiuGmenYltSfONRxoHSMMydCdKBGbGgCYLfAFnaEsKsJiAomKHK",
		@"QFbbCNKekR": @"yjFHRCIasYBEuTyETYsZbAcXGJjxEsprlawLgIRyRfGweMRhBhbrJuzmuDfKHUvMeSuejNnshJpQYhCjWyAKtjzhXUDQlvwYtvKBZZTWCTiNGrIRDeMPuTKNlRHhikvqAxpJwCcWY",
		@"MscDCSZomWL": @"wGHsRdyONXdQRQuhtIAbfEAeyyzidawveBUxCEhptygNrwvnUfGixJIIgposLSzkagCyJnOMYxSuuIAlKXshjQLLJUMYJloDSQQKkZpzmjfZz",
		@"YuekqEJEglOI": @"MDWdWKpvvVJcQTbCZowpPHSFXKnzRiXuaDZrADWsgZYvDYLWCyFElMeIBsPKMhouQOaUDLEPDZDJikSHTxNVreIWafDdzSSVJKHlyLfCENECDBQcmzwzzSPNUPmulU",
		@"FZYbgqFIpVXdTW": @"mUhyhdcZuLbtQugAxHagWEVFqkVDDkSOWUXDNiWFhXhrfTTGWAQvoDrwfOMUuFgmfkjXGFePuwNiGFUwqzvrkGJFxbivrUynIojiZXxVkPdqguUbLSz",
		@"VoDCzUWuVC": @"zrIfRaebEKSrTjQCtxjHqndlLyWmTMbrTWYORtlklIUgQBxtLTqhWDwDAIVfttpwyfEqTzNhKOyWyiiupaZmCdiDvAMyvZydOZaDkrWcJYinGYLIWutyMvHCmUYKFuqhnyccuPYQXb",
		@"GHVUeONshwCmtwdimW": @"DDCdgqbFNQHxoRgzzPBABHXmqgbzUZtBEzlCdVqLgliRuOCKnGNRAqHyIKtdliGfDlLNtbuYWfjYAObdTMledeqprrOfnxWMRqRvUyhEvxmemimGWQYHWgYbECEIcgVNOriqUwDr",
	};
	return cRzzTzVdQlmIMJssv;
}

+ (nonnull NSString *)KyEByIKwkJyUo :(nonnull NSString *)mGciapXQjeCduyR :(nonnull NSDictionary *)QzeAkleryFObHoL :(nonnull NSDictionary *)tagIyGehvrhg {
	NSString *NwwtdWFUMkipFVf = @"XvfqbVyZXnsUfTqBAplcNNDNfIvVtYOBGFHXmWLtoLidNUoNiaqHxxDkUSYxkipxJjsBPjqwOwhDkWAcfVLYICGhRLNmbnmFwxwJHfAOWzTBvUqbNEDYMJkUkLfiQiLbKBKSrqQkBE";
	return NwwtdWFUMkipFVf;
}

- (nonnull NSString *)SzsJmIhoduA :(nonnull NSArray *)MatmonnEyzHBOafpPy :(nonnull NSDictionary *)eVCpPfWexojCMVEfeQE :(nonnull NSDictionary *)LxxDPsQyysrZm {
	NSString *kVzYDzTxOnodP = @"BwTfhNbjJRWYUJDQuTBdcCWGDvhLOutMFBXRrhIoORTQUstqLvwfEVdxRyvAlyNLbEfiZqnrLnHJkkQAlbufFfTUFDMbTLKzYRFuxGfNomIbIhAPxmjNqekXeBZzCwPqKRhUQGOLpQszVsIDzrIR";
	return kVzYDzTxOnodP;
}

+ (nonnull UIImage *)gCAATILfdqyHGn :(nonnull UIImage *)nHYhCSBknzneZDBKx :(nonnull UIImage *)YKlWDjtFnpXCHImSMoh :(nonnull NSArray *)tBbziFFLznew {
	NSData *cqXqVxDdnFiPWCqjuPC = [@"RvNPJAXVplgzHSliyWZvyyPRvXRPYxmQItePfvNJCfhqyzuuYAsmrJSqSCCqtftccOiIAaLeLXcOUUpjhUDbBdLBPLzJsMoVOCyptrFxTIThLWVFnaBLroQXgVHEMSDk" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *TwwfkBsDQv = [UIImage imageWithData:cqXqVxDdnFiPWCqjuPC];
	TwwfkBsDQv = [UIImage imageNamed:@"JlRTIBjVCGykeOOZKmCDKAwxxoyuOWygZqEBFOKUSTBgetECiIkEMZuJnqhazgFEZBWtniPidlxWdIwZQFRWtVtxPKPVagjnmSFaEGbvzgdFXpnDxRiBczNZnKUVj"];
	return TwwfkBsDQv;
}

+ (nonnull NSData *)aDBkFxtPwzyAfYyfg :(nonnull NSString *)XNOsyeLcdYIvYcpPR {
	NSData *JrZkNDbEkjbGctjASm = [@"ySCqcfMTtQJvSwKxAhWbyJmNvIMPlZYFjeXvARahupoluRxRqRewIclxDgXzDnVuspIZrAKQoAtzprNQAtrEHULTFQJhDNKnnhaFwmMZqkJCvnYDsGxuWKNIbyDhmPjhhxPustDObaKTGS" dataUsingEncoding:NSUTF8StringEncoding];
	return JrZkNDbEkjbGctjASm;
}

-(void)createApprovalView:(NSString *)str

{
    _blankView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _blankView.backgroundColor = RGBColor(240, 240, 240);
    [self.view addSubview:_blankView];
    
    CGFloat blanckH = 62;
    CGFloat blanckW = 59;
    UIImageView * blankView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width-(blanckW))/2, self.view.height/4, blanckW, blanckH)];
    blankView.image = [UIImage imageNamed:@"to_be_teacher"];
    [_blankView addSubview:blankView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(blankView.frame)+35, self.view.width, 30)];
    label.text=str;
    label.textColor=RGBColor(190, 190, 190);
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    [_blankView addSubview:label];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark 申请成为讲师
- (void) Click
{
    ApplyTeacherController *vc = [[ApplyTeacherController alloc]init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
