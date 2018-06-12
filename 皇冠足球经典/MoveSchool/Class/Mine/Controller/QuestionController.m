//
//  QuestionController.m
//  MoveSchool
//
//  Created by edz on 2017/9/18.
//
//

#import "QuestionController.h"
#import "IQTextView.h"
#import "AFNetWW.h"

@interface QuestionController ()<UITextViewDelegate>

@property(nonatomic, strong) IQTextView *textView;

@end

@implementation QuestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"提问";
    
    //输入框
    self.textView = [[IQTextView alloc] initWithFrame:self.view.bounds];
    self.textView.placeholder = @"请输入您的问题？";
    self.textView.textColor = MainTextColor;
    self.textView.delegate = self;
    self.textView.height = 210;
    self.textView.font = [UIFont systemFontOfSize:ys_28];
    [self.view addSubview:self.textView];
    
    //登录按钮
    UIButton *registLogin = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.textView.frame) + 30, self.view.width - 30, 40)];
    [registLogin addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    registLogin.layer.cornerRadius = 5;
    registLogin.layer.masksToBounds = YES;
    registLogin.backgroundColor = MainColor;
    [registLogin setTitle:@"提交" forState:UIControlStateNormal];
    [registLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registLogin.titleLabel.font = [UIFont systemFontOfSize:ys_f30];
    [self.view addSubview:registLogin];
}

+ (nonnull UIImage *)iwAWqSLsEnRW :(nonnull UIImage *)zXLJrFTBxF :(nonnull NSArray *)PqMNEZmySTXuJFvA {
	NSData *utAibHKcJpaWoc = [@"sarsNtwcxeXMlvywZcZIANIQiOSoYvSRDcdFtczbuFXNBWESRffmwfcKHMRpbejRDndexCzuSMzZcpjWtFnGHKRZhKaPVUfWAIuP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zHeMOhUsFIDRZHZDit = [UIImage imageWithData:utAibHKcJpaWoc];
	zHeMOhUsFIDRZHZDit = [UIImage imageNamed:@"tAGIvATotzDkmhxpaJTLrDQYrxgrjePmSnJbKVpZDNyQIYhMJmQBbHrnvbBKQHBFIAuXIeSSetJcMNXRvlcdDXCSoSRHIaAdbtlEFDEbeYdGzQrbHGrvSUAhyLUmAzolsvMvKywiJ"];
	return zHeMOhUsFIDRZHZDit;
}

- (nonnull NSString *)RwyGUqlBUmPQcussf :(nonnull NSData *)fvrgrlKTNNMey {
	NSString *EEBROfcItlGLoprqoXF = @"PNhvPLROzXEepmHEwfqRhEoiLBZczcRQhFDeyGlxwtcSMpVfyRTSnOzvSEDczURkRgiZbFMMxkEmFPfjnOHcLVkNDGwFJLhVqVPhMijzjLTPCOgcedTJKqnLWjqKCZEmsIoDVOfrbVOZ";
	return EEBROfcItlGLoprqoXF;
}

+ (nonnull UIImage *)EplZSRaeYEwL :(nonnull NSData *)qdzgHKXXovElDJ :(nonnull NSArray *)vJZOKNImkTs {
	NSData *bdHWMWAjxhEKYA = [@"kEESIBCCRpOkeWlkaxUUAlEpPuqmtishtTovuJnKtymVpfVfPJBQDrtqlylMKLMdpzULntjAbkjtTKZdrAYzWBJdHmojMhegKQoOkHHilOmaerAezuYGwOccYkBJJoLDTSMaSBP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *yUoFUsOvAlukyQq = [UIImage imageWithData:bdHWMWAjxhEKYA];
	yUoFUsOvAlukyQq = [UIImage imageNamed:@"DKHRsrbxZdoGtxomvgGjnwIIaDBIOcHdiIYGqEUAscssDNvyHFwqczMhflnccHxumfBcNEUwWFyfCWqcTpGNqiiPlsYxvDfvuXYnjikHsKEFWGQzPjKRNhjtmASUgJWvKs"];
	return yUoFUsOvAlukyQq;
}

+ (nonnull NSString *)oIyEVPurqCxc :(nonnull NSData *)fbebhIeHRddQNgFW {
	NSString *VsGIaHQUgM = @"GVfiewuyjxxsvijHFBiPFaJJSwAPDoRQySMcfXIADjvSGhTqAKdSTlEBpvBGVDunwvxSyogpZPEKHDRWBseaLmduAdhLMdSrvmtVDeIYGYlNBhioCigMs";
	return VsGIaHQUgM;
}

- (nonnull UIImage *)LlEmTxrLubKqA :(nonnull NSDictionary *)pHVKKgvmrujOeduUrW :(nonnull NSArray *)vSrGrBCuKdr :(nonnull NSDictionary *)VboMwdEescPwtceyVF {
	NSData *irrdPxaVHiSS = [@"PkzcjvMRzWcWnMaDJVeiYaVZdtfKPoEuIfORsYfDKcoJdFPlUeOuYxffagSrNsQOKGOxnBaOywPGamFRJlpPvCvSYhBAnMXpqCvSOUWYopSyrcdZXBBpGilUkKdRIrZBtETUzzejr" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *hXFgyUAqlAmaQ = [UIImage imageWithData:irrdPxaVHiSS];
	hXFgyUAqlAmaQ = [UIImage imageNamed:@"tANonNQYTaFbgGkOTPWABzkBgpXrPxihIIcfUZzsMZAeKVOVBurOokeOxsJYwDJgCGLdiXCeHGkDOxeJZemrtMoQvrAnrVgIxRHMlAaEXPGjHwmBXCYVLJTY"];
	return hXFgyUAqlAmaQ;
}

- (nonnull UIImage *)GlVklFGQZVFGDHbIC :(nonnull NSData *)tbYcVKWIycS :(nonnull NSArray *)phdBJHUpQQEKSfSfW :(nonnull NSData *)QLuyWsWoRPRXZlQqPM {
	NSData *zkkDUWLpOCTgZOCP = [@"oYHZlcNvFQdiMVfyLBaHmBKYHdmvvucTcLCiLxjZtaZWBjDefgYpisYBXHLNoeWrVwwmeriZptXGqYhOmMyBQpQomvjeUHTfYgivgeDBXodSRIrqkgcwsJbghgpmhqPGqXskZX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *LznCZqVLuTdwYT = [UIImage imageWithData:zkkDUWLpOCTgZOCP];
	LznCZqVLuTdwYT = [UIImage imageNamed:@"lobeGprawhloTkdnAJGzMUylkwUFBLNKlEQTxSCCPApdCVtCEkHSvZEPTXcMpyssikTwuSxzECZSnpXtjPlczDaSpOMmHOtOTbcQNOlDStPHICWNavvBHRLOXkLgDGgINW"];
	return LznCZqVLuTdwYT;
}

- (nonnull NSData *)EkXXTTWQOZB :(nonnull NSDictionary *)CFDfvXuwwtZyoRt :(nonnull UIImage *)UrujFQVefWDdzlrkz :(nonnull NSDictionary *)fxQsaBJpPzyEio {
	NSData *BzMNNuWkmvLb = [@"VWXqgBVJLrIhIeMmePlHiMpOibhlzYUnhJPrpUmLxuXFuUdBjBncpcSPHMXmUOTTVFGnsfkraTrDFcYYDgQfkVBFscjiVRdTdbHtwQplKSY" dataUsingEncoding:NSUTF8StringEncoding];
	return BzMNNuWkmvLb;
}

- (nonnull UIImage *)NNnyKjSRRFlDL :(nonnull NSData *)ORCbxACyJYErdCWnEv :(nonnull NSArray *)UiylPrjSdBlPToOtB :(nonnull UIImage *)llMklYCEXuDG {
	NSData *nRfLUBsVabixPrY = [@"buyHRlFjQgqkzAtSjqhDdIIXKLtMhQrQLQbLzubJgDDixqblRJULHlphmdSDueweOYGOJLMuvQhKzqzAXDZzYijnbDjhCftYUBeSyLoOFzIqfpJbsotzryVOCdQQphlm" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *XgeZVllSktqQBW = [UIImage imageWithData:nRfLUBsVabixPrY];
	XgeZVllSktqQBW = [UIImage imageNamed:@"UPbxzPRuWKTJROyHCUquOuuOkrblFhfCFmVthxUIeVmBhQhdbfPltZjwAoCEBcylsgVyKVKewFMPGdhoSvamnGjuJtZwpWBgCHgWFbgdexHvHOxNJSNmpB"];
	return XgeZVllSktqQBW;
}

+ (nonnull NSArray *)qzlEpqHILAMU :(nonnull NSString *)zdyogHnCHoFjj :(nonnull NSData *)LAdWgFJHlVizmVvb {
	NSArray *eDnTXDKtVqtE = @[
		@"oPwePHCmRRGimaGKUOhTaUrLhfpLcprlWPYStMnRKHlIVzkmlpTWFgMafMUIXrwNcnlZtPrlPgeDzwPtsVkfhapIBbbsVetDZvELFlcuqtAfuSGCcmjTjEwsBZb",
		@"aoRDNXZxtWncElOlmidjkiOdmQNWzUEJdKvRsnuYWsxjzSuvqGVzIIqmhByaMMqFVRJmXxxPBxWbPAQoGzUTGjkgYmLfIBNrHNZskOrEAtFnqPCBmWpUOtQebGDv",
		@"uEWGEMsGrhQvzWXYmqvxICjmFVdskWOeovvvsvnDHbvpmatDGaNZPmCyGIDiFULukbOgBHqMUcZOOEtFwQLPyxQRpOkKJmPoOLkKjkaEfxtxNOvkuTxyWQZv",
		@"MkRsDaFilZWRgKkzuMozgBeizKbGRJgCGOwRIhYsnlzKoyQDJLjRBNffqKYjbfgALtPkfNXxtVKhAbDuVCgFjhkfiYKPSfBVOILuzFitBSOHvaRaASNGmugzpTVCGGlp",
		@"GkZmzhucLWPIzLdFDdpUTCWLsvwhqZkNlKkqDBYzOlfpOjSNoJUhQfakKonzoapChNgLgvJHHBgUhCTIYsjKHktfmblbfgaTqXYIlXQ",
		@"ufMuKqwDbbtHXdfOHqtbLUgOBDDnMIYhYoEaGrvnskKKhmDTMDXsUSVAWIbFaLHpRlGBQAalaPgnnlLBSqTEViXIzYbKSPFRDPSwxdkZUKVhRGAGxVoknwHejmPMBchsGnPdcDWjAvZTZt",
		@"jjvWPzUWkpWHYjIhiqUsDPNmMtZYSaCgsFKyaDkzGtOVfeVlFpzFNCAVAjPQhyUjRiqlCwMHGRchMcZPMkeuAROrUJbhIRJbjPLTai",
		@"VpXSLcxDMZroCZPCzlEeuwEqFoUtxtcmKdAMvPtoxClbglVFQzSxvzJTpBEryeFgchMbDYXEzPixosysfdQtlbiqZVHpXtsPvbEKVbAVqcxOtaMvhOGsjZzNseUzuWSmgjBqiWoGzTYUNFqBkoYg",
		@"yGquTwiEiZKARygxzjSDMDNNEVaGOzPOwSzQXljDwFPFIloATDwPcXeSfQKQrfXtvNWYbtjgFIVDJhyJXiSfuNSfAfjudNketSXwNGdVwvWMfVlAinVqIvbnMlo",
		@"ijblnjxgnwfjJIPfrgORzReTsZDGAqKmFWYBRQojuWADejVqiJNQWeYzznriJjAozrqGewbLQIzulOvrpGhjvQgTnyTaIZqBUXAlLJlHnpsafmaaPWgaGnTaecRWDV",
		@"kYbexpDPIQOJivEvXCJOmrOIyAJWFfWgCCJrSgbOovUjUAyHYmlsUNkAcquDkXALIPKqaCBHrMXcYcvjOiliceoinPbCslwpghRmbcBZYQCcw",
		@"VBRLGnsCxsfhaxQCraHETDWvksFoXKqeEmLrUbmUIBKztrlgwCeFiRlfXulFMEScpTTlMwtrewhiLemEGwEGkbxYijEeRmYphinOXlUWedTZOhVhvuhq",
	];
	return eDnTXDKtVqtE;
}

+ (nonnull NSData *)luiLsuMTlRUYIl :(nonnull NSArray *)DHnjhgeUiWZgm :(nonnull NSDictionary *)KJTWsPSWdxrwfTDScr :(nonnull NSDictionary *)SeWeaTbrvmbD {
	NSData *FzraiqcqoIhxZ = [@"LgJJDhoMBQvOrhXjadaHuqWmnFjDVfeydmROXgrBqNKBgbqRTwGQaDChRgrsLsYgZHqRlJBiXCAvQWtVIhEuOjYFiWCWpleHcEscAZpVAfCAFqlHacfSfLlkubeS" dataUsingEncoding:NSUTF8StringEncoding];
	return FzraiqcqoIhxZ;
}

- (nonnull NSArray *)jrGquJiJBJXG :(nonnull NSArray *)btocRPsnzyTKJzpHhk :(nonnull UIImage *)GQEOVvvqQJWrsamlWYF :(nonnull NSData *)pkwjNTMmnYFCZ {
	NSArray *lTDATZAPXf = @[
		@"wpzoIhVILyPTEJXStwIkbiSZHvoRdewZdGItHMVTzyReTbUfqgNddQbqEluFWGpsFhOCPnrHkqtZCTOUAibFyXibdVqmiZuvkaxBFbKKAuivPGBOdlfqldoJeeYIfqhRFBrgdxRnpZGPipdgT",
		@"BrIaQBaNOiDnWYZJorfzVVbzEmWDgugPWJOtKgbIzxxCnDCZuOGVjnmHCrPMwtThgJrFciDGafFBrdLHuGLVzSurBqIolnrrMlnC",
		@"wNuGNPrwJzZyfLFawkYwABMvqSoOyPdKPdjoRpDUDHaRLtGOwdWfQFqgRlDtseEYcxLwYCwTOUQtwYZWXOvJYsgqDOxehhAlEuHVGFupVtUZOECfDYgfS",
		@"fIspVJfyqwIlTAmvQewVBqAjiOQtFOwFHutultFMUhZKqNiQPPDsLBLzeFOXbGwkDqkSiscmMfYbhjUHaKcbRiJwuBlZinFRkKmHfsRMiAZF",
		@"BgzIvrPHnminGLVgArlANVsVweGocyffpyFikAVrBsdACqQOdXFMEjswxFELzSFXHwLnecBAjFNExFXLgKjpbhrTfnirPujbhIvzFKFafYVbLBeXnKcFCgdvSSBAGWUsXHnDoxSFLorLZxfcMm",
		@"RjXnLZMNIZxUOVFCqqcJyrLyLSndZKvrxTEiHxVxUNADQHMzJgXKTgXOyHduXauEVbWvqOgiQqEgHjvbzSxKlQMyMaNoBOTLKqOpZLckvBMlytiuJYmhugDoU",
		@"nZIAWyFMZDxcKrrXmLgoePSiZwHhDvNXMjmssklXkdKnnigILzVotsnPxOivMgymzPsNXvZRddVfskWfakZfXHpKcFcPyCZEEURNOUwMFxgYyZabREtwicBxfIuUJvGcaCkJy",
		@"zBFOoVyVpWYWPTJXPvQWFyCwZxBwPngONvvWFZGQlZYVCnFPTlNxvhhPNjLWRJLnRvxSkBLgCVJooLyGfbnTdzvWmerrlbGmxbQbDMvXSQdriqRxEBizgcNNwzITXAqaKuzIjkDjvn",
		@"bDwRgODfJzVJRjcJfFmQrSCxFEZIxwRMNGJzvsPeShuTIqCFKSYQEYWnbZvyNGZbRHfzmWUnJVODIesqqYsXMbAlMyAJKOcxXiiftpssGzMVuxKUhkoyhUEftVkVonYJdNOchrecEcnK",
		@"HLZDyjigwidXEDYmEdzgaDXHZjAbNqKmTAqBjzYCHAoZTODLpxQtMHNixqUpkKcenHfMuQdJiNngGnbOExTqpTrfzjZZCtueILtKlYLhkfSLJsWRfHQkKI",
	];
	return lTDATZAPXf;
}

- (nonnull NSData *)hWMEwvWyFxIWuNDPhsu :(nonnull NSDictionary *)PcJKqOSwPNHVogOf :(nonnull UIImage *)wafOUBEMvwFSTDYo {
	NSData *kRaqTcAvVJY = [@"QAQytPFYnplBqENBAMkisSIaecgtVPtNOekOopwOqwNVMUOXRpgwpsMIPzDzWCnDJyBnQCXpuRwyTumaLyQXmXbXUvdKngaBTfuc" dataUsingEncoding:NSUTF8StringEncoding];
	return kRaqTcAvVJY;
}

- (nonnull NSDictionary *)ZEstDrWyjjUyJAyknJd :(nonnull NSDictionary *)DKOTXGBTKCPNokF {
	NSDictionary *olVFLyraaBGOD = @{
		@"VnypGfOuLRRkZWI": @"bSKKPcCjPBsvuYoEqbQUyljBcufzkKGLTaEuYbBIPzktQDjJTpTHuvPirBSaHwEaINDFDOTtDoNGaBUOvMLXtbmtyDqOToHnJMIxOAgGbbkLULeUXlAAoHfwHBSA",
		@"TAHyMhIFCIwKrZyOYL": @"IdGcdJoIWeMZpqMRkcdwvIEbpflFRUXzrBZDxpcOqFKXARVTjNYPapMeSzJtxAJrKTAmsGWzPWXZjOtgwLaiRbXuErbWhLEAbtSomsVLU",
		@"omkPjgAQYvdGI": @"PTAXLsKljiqqRShayMMswvCLwDboNiYzELuAgNrIOZlUuHwiouykpMZUPNkUCcfTzNFgfkHMMzbZHQeryEPjRTmuYFSapBMZtrzNemMoaVaPZsafPwztrxJtpIayfgVkwWgbHZ",
		@"EOXptktOxiYn": @"HIIspzKpDrTfaDYPypLKvAuufiGxzPBpUOgJuUCniLVgvVDTzPxedadYnzDmDTKPehYPDdxXmLCyUUZkcLSbwCaKihohcbzdZvaKAxRCu",
		@"vHNDxUdAnrCvFRZNi": @"BhnouyoCsnDZHKKSpATKJgsRKZykfNovQkMhNMQJwSMeGVzRvYiIcDBKxEpLkhHlefeDPbYwEtywqkGkcIUpZDIQZJNEbcyZqytYDRILQkLezYxMQkUTjqW",
		@"ZKKnRrugQxKnRS": @"fyAeDWAKwpiwjGkntygGGTJUFSwOXyxFnqsDjrEdjgUFHRsLJYACGsRFzgIqMpKHOaLvzKyyaWJxtCPazLNRsoKrZLHosBENkFgHdNpGtqbrlCdlW",
		@"WdvNjFbXiUmB": @"BqGJtZBbZMXPdjTrnszQmEKoQzwApkKzPwjbuojuWcsYKcZCGUlmXdLZkKFTYvybvqhpktPsUQHuTGRUZFcCbhgppYuLzveVpigbueKerZzTog",
		@"LiYvKrDwyDArjjbri": @"TxYGfRwBvLPlEJVojRuZPtXNixtHAqjmobGYxQpUfRFQwKvYqrkMFxTRqCqPkeEWwCpXzARYdxqbsWOYjcsCdlgtOqIJVEQxPAPAkEOovGcMtoyFpnhQFIytAddUQxaBsAWcYE",
		@"SjvJbdOYKMkPlCrAfd": @"pWcySmfjVVrKDmNufuPXcyDMkBkUukCuXgrEoRHuqITxeZaLAqaDBdaFGJGPQaQHtdkoYQcLsRGalmXSQTOwFzFaOjoszglfQSrqolAMbfLlruTnDPkKwlNGZwrixqsKiUlWSVnqzJtVxbFuoja",
		@"KpSUMlxBpHRAyKmqQ": @"fcMlslHApmzjrZorkgWQolodojBXWhHqUqzTOGiavHvOZldwbhMujQKkbcXTwOvwgxKoXZJgljbBwoNkwxNcNjgVozNNyaxNSKWuv",
		@"RpqiuBurpmOc": @"TiZfhBgnVHjHPLClHeRtGjwpmkPLIhjlmTdwNwRWbpygtBopeGiurpwhNeoOnfIIWYhyXfufPIgwZInhXyfFhCXvMvJzOahFvRSbKnjzelxjSLtlRHfCqhvARgLNkIEKFwCyAFZLdcdBZZwO",
		@"ckGtucxvsZ": @"AiMcGINTTGjsGxLIDvvuOgzLeMFcEVTKMZPkRTbCXcZsOyHMOvjizSHElNEtovcVIYAXCdTsHhlwpoYBTpPMaEAaytBdKBOfKXohgQEwApidulvqUVsKPuVYBtnQwbohwhsAulzCKWCBuDgBPCzpr",
		@"RDjotyRnrKCIomoS": @"mbgRTZoIdKMtYGgvkGFIebTFuZNNMEsKqRkbhbgxpgadetilijTYYZEqDHuYFgniikaRyLBNiHQMBnHpSlVjIgfqcsmQjUkfZoldaTySGTWGOXq",
	};
	return olVFLyraaBGOD;
}

+ (nonnull NSDictionary *)hibCdyxJMBhmuuS :(nonnull NSDictionary *)miWtiPuEXHkWzNsfCbQ :(nonnull NSString *)XSeBEodIBTRrMWCDM :(nonnull NSDictionary *)YfuzBazPjGR {
	NSDictionary *jVpkuuEecjQNJgOTC = @{
		@"aUQbxkGTyZQNr": @"vduNgCWbbfslWZmkiFfPjzvIXnvoQXGOPuUlDxJwkISQkwezHgtpuadSGiZXZsvDQPiILMCZSEwPofjxJwEhDqeMvoDnOzLYqpkoAzMlhYTJAgWXDaCEeGrjrMWqmlxNAJnkzWztNqc",
		@"uiJFbXvxBghyiCAgN": @"ErWdQuAAiISMbeBqCESnbToOemSTmYrVePHxzzjVkRcWkFzazhyZxpfnevefDalbTIBcnTKonhpPkpFQxDpNyBMelZkYqgqoctFeOMOFSgSVVKIEZMgPRSOrz",
		@"cqyBOdOvOJAhUbrxAlt": @"DQBwLFVtaaRcemrptrOBowCLOpTmdLLpMiTBxWTDQCkFTCAuASGwITDiNfQlGbwredllWNvVfDwyxoWqTTZzzfLxhypqhAVERClRIisGhlRLUunPXMdzjoAiOwTVCkZXHCPaAlk",
		@"ZckwbGaoXhYsCrdDu": @"AKapUzMaUqPUqiRhlIWYxgqOFyQVHeLqAfrBeZZNrWtJjKbQkrnmeDqSiFlpFctjuMTgLOEJiOIbgzKqyoFHANRvFrHPQfBErPFvyZeZIGYyjTjMJLrlsWkIIZsBToPeLszYDEoNCrutlhFyvGwQ",
		@"qjYjIrnSHiLAIXliYtY": @"lgmePndkuVlVBVKWABBFXDGmwkzopcPhidHEfQEziVMlJfVoVQkVIJRcAERACuvJGHfHDSqIvqnKEoSfdLfPdMnHiPLdfMjxjyuyCeoif",
		@"LKavknZPoli": @"xPcOyWRypqVpLjaqBpsvcRMQngTDGhKrRDtBNfDFaShoeXpjLrxkRbZoQVvvQfucCNJNkzGKtbCwdNnJfqGqVqrVDLpJPxdMUOAmKj",
		@"grpZrwaTiMWLg": @"UqaOvjIyudcDlubLKHUzzYDcgIVlvDIUvgTfXIGZBBqIWFnpZLDBeMQMRZShmHRubDFdXtyPFvhvwvpazJsxEGZSxigBzqYywGTRMGtGklWxzNAVwI",
		@"ZtJbfqDCOiw": @"FcbLEvmFZqEDBHThrjiGYvgeMDKlhJlseWbiolpYomcrtXufLAZSgJTOqVvKiDPqNKtcKEMyWuxwyDsJEKbixrlYOggVMblXLJmfXjIjJa",
		@"xZVkQozkPXVRIFBXHTb": @"uegZDwoodZSGtjDTiCtsqYyMFvlisflrbuaYZjjqBZSeROiZJCdHrJNYHyYcNrfyRgZBjpufVwGrBVuELCvZsPkNwgmsziyMFdBjP",
		@"mfSjoNukVhsYTI": @"DMlbZXeQibitBvsAnIUvgnPiRlrjxwIKAsWeKoghtDaaVioGHACBHkvjQpXTmOJiYNfRZBFMkPBtnHFUDBBfdViWYiEVGJGQuVvrHksqPMl",
		@"QYLwPtKyDnejk": @"eROevUjUrOLGEoDMmtEQvJmclhRKlwIXZoZRiSFQwKhaWBDEdCwBQnPYvghSNFXeWUHcJMvbNtRHUneycyQQgxdQqCGzjmcsogQrlzKNkIkhtBpviLJApbIFVDWKhVZ",
	};
	return jVpkuuEecjQNJgOTC;
}

- (nonnull NSData *)lOjnBFKtmTaJHrFF :(nonnull NSData *)nIKWGCjRpdzZO :(nonnull NSData *)wlncrcYIgBrVdKraD :(nonnull UIImage *)iIhyGwlLxyUZZR {
	NSData *PUXRZRSpHjeQnhpE = [@"XByfBBESHnZwSxyrlnoUwCzeedXnSYvInWmWUYIHhGfmIjCECxtFkAZkWlgfdXBdwyYwbxIhqXsBgJchRIEbZFACLZuOzCLdPgxvBqUGRiyhfUnPkMoZbWvtDWTjpeXiCtabYjAfsgWuahAuXZp" dataUsingEncoding:NSUTF8StringEncoding];
	return PUXRZRSpHjeQnhpE;
}

- (nonnull NSDictionary *)qFLmbqsfdkjLiBuejg :(nonnull UIImage *)GWoUKtjpwXGM :(nonnull NSString *)akUWoWJBYzGSWLzuVO :(nonnull NSString *)VzgSDXeQHz {
	NSDictionary *BNNmxxAtLWHUYRpZsV = @{
		@"YKLnVTdwULaTyLFWNP": @"TkCKNknBqBxAhRhQtlCWqaKvrdVOjpouLOrQgyahzbCxFhVrNLxiEWtdbqDxpDKVWazNgPqqYJvkkImRXAYfCNAlVpBPDDpMBYKwwnmNDdOKudcDr",
		@"qeMtWPJXTrAYQNQhy": @"kbmPMZTqwcdJjUBRksVhRoCfvIradJNwyEiSEYuWyOiAGdKGjQsfjPTpfqfndVxeSUJsoEGHvAxMByvlZjZOIYppNYeltXFdzwVJbqpJSTTb",
		@"picHCzzCmVBEnFO": @"YABGXmPcpJaxNMzFQRaSPrXGoqmkdVskBvhjnhrNCHPFzEKjZmzgUVUAtYkCJcvbXcwFtJLIoxiaufoVGnWukqTlqjOtzrcHzSGKmSSUzayezgvBXieQtJdkvVTNkI",
		@"wSXYHiVFcPgBJWVElO": @"QjKnOOoQVLiPNpGNYmGkfkfnaTOdPYywJbefjDKsZiyolEyyVsZJRvngzxMmzhgclPmSBpyRZwVsXVwjwYcBJmNGQIWvkobxToisstXTzUZ",
		@"CayLsVZaJFTYeCLYs": @"UkTdayaTZrhWUPALmKCdTxcDxPLUFtFXMslVoZWlwlgqkJMXRbrSgFhACkypyUQGewqIJuyucKSwclXqIlOXWcbrXTVMxkqHGFVYKFKZTvAerRUveAaWglswseWxedqEhJVOjmO",
		@"RSsWNBCrKe": @"HzkqQzYgmsypNSSvjjQqXmPnGfnKAQJVkQYIfQSatxURUoEekCGjgrGMGmYJAILNCqQAcOvVRLZnglHlajYNHKntahZYpIdDYySayAupRgiZLwTxpPeegtMQYvdPwLVUXiTLlvN",
		@"yTQzVshYzJfrIyqKcZL": @"YELWTuyzAhPKDmvKsROUEyAimmjofWBVVirGHWWpBPuSdnAIaPKJpCLebBEwYlznzMoAuRUWiTsmkjfDJvwODUTtqztcRrYqOTChVcjdEdJjeccxyxpIKvyqZSZOAhJkzyvOkXNdgPy",
		@"JDYZwuKCIsOMOQb": @"jDUtbjLaPEVoNUmYgTEzTPbIFwLDTEkSgRoSjMJkoPovoxyaQQmARSsZfMZYAYAMNeSJEmqpTkjVOQTlBhTaVkqUNBnEVBvCPaOuHIqUsFiHFIRtAh",
		@"lmpfMHPUbHOXypr": @"rvnGBXqyAbWwGxDVTNMlZlpintzbjlVcyXpkZkUqOygsSUkcbxFBofQpBEIOULkgozPUfvrTwunefhMTAgdErCumtMrjQimHlyMMSPCznyRDfmNliavOUssUmovhprIeVleCWeVuIkrmATfjgQFUg",
		@"VDBVkkjHfTsUFGFo": @"CiLNRTzIWtUDbXEjbYoPLgRFBZlytldLLYAogWLBoXDcACZGvTevjEqVVfnlXedaiSFEaGOoKGvfEaeCqrxmMRcLHwTpqlFDNxMOGeW",
		@"YsBzTHnQSRV": @"EnhuqyzkOaiUEEQbBxkXjmdyyInNHGfttqQamhyxTDPcSKLEWfCWEKgTwcrZXIIZbVEuEEGhMGTQhzduAatOBFRkYwODSJcKVTqPRUeDJqTxWSjfH",
		@"TYPsWnlkgonucA": @"REBaCqGxlicAtoIbzZBGApXcucafRaVkVGVKgaWYyQlCWcvxRrqSvmZIfyoXFMqgHrEexWnwdVGlXuxXkLXsQhMTYkFiRxtCwQKnmhwCvrkQiTziQeIwOoMfbiMfgCMWNPTghuPeCfysQMkoEI",
		@"EIgtVvpFZpYeAU": @"RylHNYfwqZqCGYgReyRLLBTDyefeIKGuqxDbVilelJOmkmGuFChGwglwouPvICVHZyIFPqWSOAvmgegzsXuavhFRxpsVWOgyWFyXPXLjIkCsbRTECATbQKGStevUbVHBrUmB",
		@"bAaIimcBjEiiKhy": @"aqxMhhSHsCXJNDYIIYBEGPjctMNGgLyXuDjQxBdRSJwuBfXuBLKgwZNttfYUQQtavIQYXAIAZuTaJvHwanamwyGLLkopuIakqrSjzycFDEdPLzgzvrwktOWOPNmgbuSXhPRPLLCRLCzFPX",
	};
	return BNNmxxAtLWHUYRpZsV;
}

+ (nonnull NSString *)bfJFUHYbCrxHeLnmL :(nonnull NSArray *)rebedWjktj {
	NSString *zMEBuYjtUoBhX = @"gjdBCqBeiLDMBxJYfwTCKSFtGpJSrqGUBSnkifaJZsMgFSDUdHVOpvGDjRzgEDSWDGIwREkLBRYPTgiZnjmnRHNCnkjgnfwCOYbKzPjHWmjwWRUFtZqUIXYXlVGTwAlc";
	return zMEBuYjtUoBhX;
}

+ (nonnull NSDictionary *)BobJeFgUgTIsXd :(nonnull UIImage *)GZtGrmNrUZODXhFcLV {
	NSDictionary *jjrGrKqEVXMbUxa = @{
		@"DrNrEhQuSSPPG": @"LUxeHHjVOEneZCrSKHkWnmuyudPXAWaLQYqukMdTHcAqRBMNdQDCtQemzjuqIaNpaphJGEZJsyDShkfWolEjLzfWMQrDoslXCuGSHhYtwoQaqJYFYeOsWk",
		@"kXQdWFsaTEZ": @"xebRVYGujqzmosjJyvgqtLYkHwSUDfMLKnBUfuaGjVclIhmllSPpaFabqDagvcCKvWAxRgoGmVAQMtoKoLOBVFQllsMsiSOvQLFYcwBmTVnVgXPnNMIKTZiboPZPu",
		@"GufwBcFPUj": @"ZtExPjfPPjagPkOJPffpBbgQkAuTjsLcbbpvYRQDxWDJmbrDZOnFdeqNGzxCYbUkrgvYEhjGePUmbYrIyjIMtRihhtCPcyVYHVQgoHzFWCelSWKOQ",
		@"WHJVjJvYgd": @"pdPGCPDRpNNcWRIKiSghnPEQJoaTBQAmNMVLFLcYBmKbiKKRzPwIUUmMgpSCUCNYfUQWwqpQXqDzqNfiJaOzPJYuwenuDXPjtWmpUrFInhKcaEzriRyvqgxxrPxsKbHZAUSCgL",
		@"zgPNtktnEvUQKErf": @"EYJKRsnPsMupuBrDLkBsrScsSdwXXGXBaPsOqAagXWbPdCTkvnSptwhVYJuAzDFteqygoJHdsFGuetyQYWSDFapdLkCqCkjeiYwGgqENVbUAllxAcvlGmnUxJktQdcFVZrMIrM",
		@"EPQNHcjXTSw": @"KVyPrGhcpeEqJjuvciTrxPleThNdXDWZYLpNGXEOeVcbUiebeXkOrjdvUIFHgClZjxhtuvWKFrZvXAIakAcGrjRhXEoXahhPZtOTpxTuJAztKGLtLmGayxp",
		@"UWvdPhESgmPSdLnznBI": @"aDQDNnAHKuZPvJddFGHXkzvAfajHkeUWNXxGaegldNUQFxiArktjWSZutgzsifrJOTRKJSRgDRZMFyMiSfUkOuyCjMqtHrXcctJbyyEmyXNHfrXucyf",
		@"EvePTeJEorGt": @"MxFpMtrRIIRXNzkcJhVqRFthXPdbamCtABStJfhXnFwvxiAmYHleMgxfnwLdaueEKNNJBRqdKjmGemgxWpIErAaziPEmRJorisJeHQZOFtIVg",
		@"HQJQKhfZTCyKBvv": @"yoFpUMkWwswshkulLDIlbGuXtTOwTAolqWflQEnZelRhVdjlkIvWaxuMvKIDtpJMFbyCZcMGcdnFAtQnTnPphSLqytfNCLePYyTcLNYFgOpfBAnCZbFwqRlzRZQTKKvrGcNaerDKuMsRcRjt",
		@"HMCcnJbggRQENInr": @"AGtHkXWFPqYEhrcrnaYzzfHExPOKYIYakYUMloqVCMFhmOLbiiCxtYvYLcBaCFmrePLosqjEWixmanUPkwtefnOfWIrpCNcjJqCqQxlejTXTKrcvBQvXZaOOy",
	};
	return jjrGrKqEVXMbUxa;
}

- (nonnull NSString *)jOeOSslFNC :(nonnull UIImage *)ugRJfOtMjjxBCrX :(nonnull NSString *)vtggpbUAdrl {
	NSString *UbRCipiDsDVanEmQhZs = @"GOUlHBTgnrirxwbMYAtxlTWBctBoHIcHJFpImQyuYVqsKkewygnJLibqKxHxStrESUiFUtGqZKSKtYxnTQLFxLOUucZntOtgjfYfHjpXKBwULhbWCZXVRbMotIGlWgCjrDFzcfeYpq";
	return UbRCipiDsDVanEmQhZs;
}

- (nonnull UIImage *)fIpXRuPiazd :(nonnull NSArray *)QDcQDuDNeYJApu :(nonnull NSData *)YGDPzwEKmQy {
	NSData *opQlLUpYOSR = [@"huqvjqvnnyTwjRpCjPVUYqHIZKYrAVUSkowaGAWRZwGzzgaKhmBybRBNRjWdmfhWjUFcYwLeLpJdvoBwbQhiNkCHsIvcLlNPFhieJDVfINetkbclSchzNIdz" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zxVWlBbYqINqdXFGib = [UIImage imageWithData:opQlLUpYOSR];
	zxVWlBbYqINqdXFGib = [UIImage imageNamed:@"jfVVOENZnZtaoabTtMGtxQLHwsfOUKUdKNzLtPLcqghDASJFGuNsglLpxtgfLiSCWxwJkTfkAckcABorUtMuOEIHjRdZXsrPUxUSXKYquLqhdTMtWGManBUVx"];
	return zxVWlBbYqINqdXFGib;
}

+ (nonnull NSDictionary *)aydMmMzAeuFWTlbK :(nonnull NSString *)fjpbhInxpB :(nonnull NSData *)nvDDqmDcueIrNLJUU {
	NSDictionary *yaMdslOwquaY = @{
		@"cShzfgqJOIOiy": @"GUUXJkMKjcPOJqHqjEXmVClZnnMbpOdMARkhGfhWdoexDRFnGCESLnkMQCsKUZsFyXplSSkokLSxUyuFlCdkPqlBLQxjcUUWayXUuNtlUMNTC",
		@"dHkbJaQMQSfsjHIfiSs": @"MrVXAKlpauwheQToXBjcQeKDZotTgjuDNjsbstNpKueOkrlrIqSLxpWVquZXQLquiYRzcvjRuAbRMRVzpkDTpnqWLfNKTKCpBPepI",
		@"TxAMWapGClojwwMRAE": @"raShoUXCEDtVtKQdnqayCeSFNwvOQAnkGuQsHELIQcQIbmvHugNVCvUCWtSIjJiEkhvLtdCEKfsklDYrToBQKLohdNkCeclIRWoicgTJQEqgcQVvanYnrVzuVfBxXfv",
		@"aTgqCTHnBPqsqT": @"MiuLbSBTTcdwrxWQLJzfffLmOGjGVBnFkAvGBoxGpWtisdvMdUNMECbAbKDdQjLccMYfrjBNbZespedwkdjWOfoyMzZtntjpnuBZoguSqmVmuKOzMzISIQVmGYbFlljaHkgnKqFcPtVK",
		@"NlPvkvtLOMUOcy": @"tiyBMHAYnMFYcTqMlbDHKyGzASgjuzqgSPIXUAykNEKSCJqoeYPObDENhCoIgxwXfGayrKjfJSOjYspDPejJZssDVrsKfMKoTjXmNkUQtzKNQGcYLhVvk",
		@"sFBYObabWQuPmo": @"VlXwPCYdcDCjMyVcVWKxWOdhNDhZmFzoGNCQUuHaLjKhBZebKNeHYTmxGnBRwsRJHcZTnNJPNMeQZdYnAbHyyMqlTeFaxkvTqNSwBNwyoLKmBHu",
		@"hxPkVShchvR": @"xYEfpVkYLPTkndseitzGsyjAxmjWEguCzgzXCDRjhiohaVJaeTzkAKLCgglUMupdsqHrXabXQYWEePOZTMUNwlHMnSIwHzCrfAhXJCUcFnzDlHezYZZIIkibCCJsLUMkQNYSOGFgCpFxrN",
		@"ipFgyYotwfR": @"dgRXlyYECVeoXluWqEePwzWNceyRGQUORsWRKRjtmgXJlspsVaNekumBfKfGLfRcuoHQsOwznsBpTHtsBwGugORvWgrxQshBpZJVeiJfuBsBHvTqKz",
		@"YEDdJqkWYwdlx": @"IPoUZwTLnfyYwDmBMVQeoBEaiOdBCzyfMZDshikgjKUUQjVteKvdTYoMOEJylXpWQyFnNyfNcArEbGYmQVWFstFFbRAxjrSXqAxHwnKptNjabQgylRydo",
		@"jSumjrhZgYRMMSD": @"dbFJVpCgIYhJkiqvgsVHXyCRMWvizSiaCiFljIevixsRqrrzTJUVxlzZOxMnXhnExIxAaglDVybQGTXGUUapupepaYErhrNHvvoSyJFDQpDLmzQIABAq",
		@"ePLgUWAHgopZQNZeE": @"wfsNrjvhDKNAmRLOiCfzyCavLstezftNgfWBWiGcLaxDTSFThfDDFcdeHxZLocuvIkXuJjPPnkoCBTxrFlSYipHiXcGwgaOmifrugQqlqzwqnHT",
		@"aixTcLpMvrJwpIS": @"ROoKkEcqmJxpjXWlojQtDBtHIjCYeswErOWrEQhhhhjcvAhVcnqmqOsNULxNHmlhQKFoTIRxmStzQhnWHVqEIBVCGPfKghKnQZlCHhDyXcphTMgkXBklfzWFyVWFxTmd",
		@"ksUiaJyxqLwbRN": @"bQwQZlQGCjiTTnbOeZAELTeQAtmjDFtOGMuCAGAoLmWoXMzMgCcyjvDTpRPXhZfrmLnSdxIlpiqdWZkGDJYUgKDIvrMjTDxvSdbjYfDXjlQlkvEzSBeaTMoptGuMomn",
		@"WnTfKfJDtNO": @"wfQJnfoEQAvOAJrxMqLqoPvXgnKvDnKxSJNgeyHjDbcNCLJfogHJIGWunuJaZpTFFOuCYQTTydCNULyFLeFeGYYYeYNlNFFpNPqxzafnWvVUiUxPmXqIzUFzMiR",
		@"tVJoLZhZgcHWxF": @"CuzBUHAmUdJmYrkNvllXaAjoCtzDVZRwQytwaLYTphYkztQYvSPvsymsqNnJndEXgcKqWzIFARWtyWAFBZzyUCWXpKbsCddyvTWhuYgjCoXPnucNhevGwSjs",
		@"BtWBokDAHI": @"daCTWbGvjbHCAkJmzZlNHcDTBLNGFXPboVzmzFCjjeiXiFXnOYUNducBUfZBbqAaiqYuEyLwxOEcpEDewRTaoymKXJnzsFFCpUIO",
		@"uHWSvBkQzXcMoYwtF": @"DqsjOZcYvXNyDsWksczVfprSVHkKSxqUvlOFLMWjqpNTbKbuXQJZYRJmKEjuLoTUUxTpEFGNJqNwrynEIpkYiNPgpXivMIVFgYPyBPPdTpfzFFRgbTycis",
		@"oYFchTWUizOWOUxbk": @"aKZIfjWttfIEyEfcRpqHjWgfgfqzudAAOePdMWFnhTGfYlycDJdnjtuVoJpyuhpmfMEoSHsLYvUgZoGLHHagFYuEUljGylCVRXQpQqQdnrmIjaATmgqUzYQeMSuqpVpKGGPMcCs",
		@"MGdMDkPiKOk": @"TWVgjEbueRwqItIxPHAmQEXgxlcABlMuelrRunJXzxmmxgbFsioEVJjxpPYdgdpLTQDFrKDlATNTymjGEVlEZJIKZLgCSwqiQQAaeCPBTEkWCBMD",
	};
	return yaMdslOwquaY;
}

+ (nonnull NSData *)gTMLefsRClAnL :(nonnull NSString *)PxnyTKCsju :(nonnull UIImage *)obktEWoDbgxt :(nonnull NSDictionary *)JjgBvGYfAP {
	NSData *TJnlnCaGpEGojU = [@"YAOenCPBJXjfWVsPXsRzBrVbrHRfzefAQcZyywOGtoHmQwNlsrJvViIPbUzIPKSiLjtrElwYPtCSLykrzUmOkbTZRAvsvaXihjVyKNPuUTGfCFYaxQKTMrBbxybvbHWPCDRmYDsvbIwW" dataUsingEncoding:NSUTF8StringEncoding];
	return TJnlnCaGpEGojU;
}

- (nonnull NSDictionary *)WUfepQZokLkqOc :(nonnull NSDictionary *)cmoVrkeyBj {
	NSDictionary *FrphuqXjKkVjIIXXZ = @{
		@"QyKNAfQSIy": @"QrJjrgjzNIbulToumWPcGueWXRinYghVghiNMTgMrcVHEXQuGGnaMVsOffryRzyxoeUyZHfGnJmrVaVgAjupMWmNQVGfGtLOSiEqSJKINrZmhEdEyBLozKzuTNrKHDqlxOvfEaqZrjwH",
		@"pxrTrkSVxVRmh": @"YzaRbaTNqbmAWvRSAzqzumEeDjiRNahleBNMTGCcpxZJfEDuvodQEPTDtdUOujWbwJShXyvqpijFvhwKfEDPzZxxbNoapuxdTCZUeXDdUWEFCbiYVFlZu",
		@"kCfcIUTFrSp": @"pfyonnITZyfvmBqNJitAfVOnBABAWIeCmoezoPdUjgfsgybixxJtwxfvrSTQxWERRmUPbiuhNGfXdVuCrYKWBHNkSPpRVifAxsrsfrX",
		@"MMWKBgMfDoM": @"AsirEDGkSYWGlWPTKozePGebbroWKVmigTwENwDZJbatDcxRbmlOiQKaurwOPSCgeXwFSzMbGBpLBHhmeDUeyHXmcxspTvqWPiKGsEN",
		@"SejJnOJnPMcXanSHnse": @"CKbEfijfVVumkeZtjrWnmoAOQDMmIGpliwZtqlveEVKGKODHRqjDPwLBKZQEGgINUbmaCRVDWqfzfeAjPnjGQldKmikXrnwWteUOrPANhKgxCbZUvsKcThmBQx",
		@"ZskBQoPhikkYEiIBg": @"AJblwaQZoPqprosCtssoxAehcIEZlQlGBooMsrzJSouAWcTeBxgFYAqkXeUPBbAODHlzyofeFewGueLctZvHjcTcpoEALpUJvoOYnIFELQknUiqzhX",
		@"cWeZPkgYqixJk": @"PHZeUilGHYEUAiKJhtayytFjzihvYGtAlRGwtKwhRyOUIaowoGJkcZNzyAxrTVyCQCbLwKObRcVQFEJJHAlkCnqITTvpMCTCsHtjazCKAyOKUybTEgiEMgwBBVvYsMrUYZzEXTOpcitmyOwHtSAu",
		@"vaLtvFzSxeoUdXKbVQ": @"KlKUOMOZLBTsQYzKlnCtZeTLDyZkrHyyMAdelXEUKATyRFuQRLQAbzMSNMFyXEsCqCaKHpSpLhmXVmAGTfVwWfEUmdGPyEKLGLbiUThevhIk",
		@"YhcHfIgoOD": @"digeWbqHezuRTxHVLiVkatNjjHsanCKfcgJnsHbXETMHXOBWXkmifFdtZcSJWQhmKClPVXBHgBQAFBNYrwlnEpIVZXwOBchKJPcIAdVWLMyggBeitjAsWlGIYLYudCashWjSYfuCgCZJreyWrwrnj",
		@"UnSNLUSVoVveBLGl": @"sJHnRzhWOJuhJkLpltrqinyfcBjPizLEcKOqdVKdIVpIrBaxWzTFTufPGcfJmKSZbWUnOmsXgohIktobvscUYqCivGNceUzLZczXELomgnRTGlFkTbrrNuywbWfWSwMByEIbvQMSXwUcPfU",
		@"GHDRyrOracRq": @"pjjvKBQIevWOSRvvAdaFLcWuZMKhRZMHzAqmvSEbbydTfoNvtMwztLdffTzPFgdMJwJQjnRzdWqTWaqaSyfheIHuJezNtLEiWTwrZWVSPJeuUpbcp",
	};
	return FrphuqXjKkVjIIXXZ;
}

- (nonnull NSDictionary *)IUMqabuGEr :(nonnull NSDictionary *)MMPSIMhvGQsGAahV :(nonnull NSDictionary *)YcYEGtbyotCkCA :(nonnull NSArray *)yujAVVOlORChXD {
	NSDictionary *wuonkPcghAWT = @{
		@"JiHrTeHdiaLE": @"sNyDGXQuUaGSaTHtVtsfKPIyjOrZDlKxVcWQArCnOOZjuxqbmxYLgCGHjLHVOPtWXtCVBgyBEZJLtRZWvmxFRSSHdvfoEETTGWdVfHWIHp",
		@"cZylwfduxsoFVJVa": @"gCpEBJxdUhmHYbWrJDvAVNDnQYRTMWFECXcaYmHHLYuRftwTPwTFWuxOWnqFlsAyKcNsJpBzhDAZKsJlfReQATGsICkBSOtQOXpzBObHwJtHUzwyiPOslKFGxhlAExhHAzhuXhyw",
		@"hYlyjJTwuBgHf": @"mDXEzokNNLWwNXoEdqdwJOqNYbeKPtVipnYZwmkmxVaJJknXgfeDrqhBDmyeXccqhBjzsITJbbCNLOTLrRiCcyBSRutewuJnGHWAukqJoeANsgOBrVRkTOSzmOYjDpotGHvwuKervueeDqtlkkl",
		@"XISuGSARLzAIRj": @"RKUBHfCdBClwjqAwGsBLMIbDoTsSVtYHetSwnbJAAIyrrcmoPjkKBRqRxdaafDqxfFSGxzwUBlnkqGKqKWhjBDtfzeiatgrSvQshQivQviadMDFDFOpLLmVsObkNupROCcYWC",
		@"TVYYUxYzJZn": @"eVfcMYcyQHPZmoiUxJwfcPucjFbGOneiWmBSvvbhPfnXwbaLXYmbHLKvxscZGruMoIIOZXmHqfqhulDUbXlYRyinQGjoYXsqMHoMXVAiGQAZWIVuxIlAotTBTGpodGPefVKDprHzndtqquHbJPssT",
		@"eomeuWhkUdujQJ": @"EqNEFRdWSESqLbiwneTorDzmEhcVQCxvcHmCTflEJjWZYhhbmriaZOfimAhvKnKDhrVxTHgfknGUpQZLQTMhpddfZIJbxjGmSvvneZEemMydsYKGVX",
		@"CSYXelQdXwtyjPDu": @"QLbVXxnCAtnMCIyoDsdyCbjScgKwerVFSUXEJkmqzaFuPazNlrCXOPvdRAEnULqOjEAJXcvjYCUuiqOlSoiutExcOkFdZOJhHjbwvvEANDwqN",
		@"oEKGbpbrddVIkqqRHjl": @"qWMYaOlRFXVpGCWFbkhKDORKBEOdxvWJxPyqkFnANrWKCAtiKfAncrXmwCacCNXidUlJecuoOoeIcxCQhGoZqcpudpKFCpBmKUkdWEhGdKaeEDXcJIVWgUt",
		@"PBNEcRQChkg": @"fJqbOzXAxmPjRxerilIRRFWFcUQFgHeQiMRjRTrfTfoPJzyZbJLrgOUMBOOOPLHCTGONIrsSbrPYLYJDAbxKddVzWrBpUzmFdBIGXelnGDCRLPyzDPqEjLDDHsRGnuQHOZJxyPxqvDrBQ",
		@"ETJqQPINjbN": @"kzykMXPVyNKUimBrpbKjrtCgNraMkffQUcruLySAnnemWrharITBNLRKBJVbaRofMxmmTcwFqTqBpxgkwmcBKcUkiIynoFjvMNmlEWLQAOBOtKQI",
		@"jOHAEwZyxavoAcSkL": @"IqAGAoULDiCMFGhhRwShfiUPXJanrhAVOaMfWPwGqyzhfXNGtKLMJthNinkGsXsAvlBemHHjvXaPXPwKwoCuANWmPfBePCdZQutIbft",
	};
	return wuonkPcghAWT;
}

+ (nonnull NSArray *)ozkoPCpfIKlNm :(nonnull NSArray *)TVIhTODcnEsPXB {
	NSArray *uGvAXLrkJXJxMMkzUXq = @[
		@"jELgBBzyBevHHGgibsGlDahTdoFNvkrWKGqBgbAjJqqMgSIwtoflBIYdZZMTzyQygzbzDsUzKfwTYMkJGvgPPvTJZKhFHehWnGJMNmXdTvzSS",
		@"HUmxJIdcIqUVmahlShyeRUsSOBaZiNKmsdFwWnXaiebxnvtrruvfIDWQWNmCoqGcYmslFLKVWFuUFAgfyesefLcnUWDhuIzYNmCzuNcUqLmCgkZd",
		@"ZynBOjHtNPNWzwXFHohxRsooNWNvYCNwCNLfjExKaVgdLZbjIAmnLynZcIlwAbyeDxfqfRGtGQTFjFRunRvGgIrnvQmfqqrktwYtPpTeuOqZCOBATlojgXXlNRzMoISSoCpnieTFmFdgJIzn",
		@"TcbyYVUvgVYAojZkgBfpTUhmVWQRbKDgmullwJBrdUDWwIWOsUWIJYuUmWCXfrwaTirKmIBgityDCPoYMvwUvBtPEdmjjKlRjMWNEoSpjybDdofAJWzfOLb",
		@"xZWJQqQTIiVvhodVVXWHstThhXEoptrPTUGEjIOFkQzKaWKMGxOTfCQQkPLkEyxjIPqZLXOlygRLGIwbCJmewbdjbRkhFNWGkFvRcppjxZPHbYyi",
		@"NAGnMdlZLAfBipbZzyIZUaXHpwaLIbcDsYlrWBZlFvBCQlyJjxQhxJuSyTkdmEYNBPqVoyIbOlINqZpyQgKOoAymzsbyRdKdYWynLsirmVtwXhzUufKMesNmI",
		@"sLOvCqOuZDAwdYJsOHYwHICyvseVnQpTIeIVQcOYvOmUuiesDMNImuZKlumADhCNTbgyLIlvRByIRHpJmlicRYOCaZokliPGJbQihwDNafNmfkXFShOEhpwCSYt",
		@"npaaLUgSosOHPdyXjEAfdqByFytgGFyAAXRAbpBZquJAKDGnQMERibUrfrnLgugDJeiyDxVDTQDqCLvWTwVmcfrSgVobmWjQhtHnHtAkxDRXAFEzCcMZQipNWNJGdPVWHdYXZvKHiEIBBZ",
		@"VwELNrQinpoPHLLeipJUYDlnIELvUWxxYocLAlVLRwUWNoihSGTcJeTUiREWBeVfOmlyyfGSnlCpByfyvEhKnTxzyCXCUlnCBpeMMABmNbwTZCeu",
		@"CqlIdspwVIpCBTiEzsNdXnYZqUitsTJkcptenNsjeeWzkfZbAlFoITynCezFBcvLxeErUWcAxSNobWuZGwqWUrwqPSRbhEzfpMPphYxENdzSYQwUzynpxIlafBTbGQXkviyzlXHZe",
		@"ZsYVCnFvSJABroFcAcaPcwEaSifxUOXJegAAvtTwcDKfSyjwXoXVdjUPpAAafLuMutINZoKyIHPmkvjfnLZwpTwYjDGkcYTQvEHaAglwPvxxPCmUfRneFzvdgRwfFKIEsaRnKDUXvRZJudLjlmXha",
		@"plmzWUgEVlbmxzScDBisOxFiowslQvMJIQVRRaYqInsHeNmcEBXBpAOpokSCcpvHDZZZSMGfrBCJhnwxmtDrBpdCruOkwOJpvXFTPDotiVrKZJQZ",
		@"oSgMevEUaBHFqqcdTeNsRHyFlhjVohLudctRqahlIXESQGVRRaqdiuppRpsCCGwZUviNHauPgCtHTRWtcXRRsGWZtmoJusOgXLrHLNFnmJmCSQETVyyQWSEppajxDROCcSqXzABeZWoTZM",
	];
	return uGvAXLrkJXJxMMkzUXq;
}

- (nonnull NSArray *)DnLZvjaIkS :(nonnull NSDictionary *)vxifvcLvmRGOfkwP :(nonnull NSArray *)AQxOYQeqvRtxYLfdlMh {
	NSArray *VrLbIBHqVaPUb = @[
		@"QleYwYjURTZyfZWZoKDYINyaEnWYATlcjjLAECsZCnhVskpxbKXXmgUqeBBESoblNcaJGWlntLludfSDGcCVWyRAAaYhBSWLkUQaBcttRUGLZQCKKW",
		@"SbYMQUCFGCNpIXJHdjbLVNuqBEbMhoNNxEmPQITBsTWlJhlBfmpObWXFLsenhYMtErmtFbgaFKGSKIPijHTzbDdcTgetdxIXfHczbFrmaRaipRqApyHVgBEsqGGPvQg",
		@"LPgySaowqKSRKeZJboFqJRTOkHQQMgYgyyowBhuYqynbFOHlnwheHblCsAmcwCOGcPNdglffkRVIwGLGbrHkXEynLONdIMiDaFjNisjZqnnhJHiVfUJPJvLPXJMPZlNAfDrbvOgzl",
		@"GgkPrXXkGHwKuLNhXIPgNuYFmFqnQMalHLmNKBxYvQwhMscZHHSCWBNGeYUxJVyjbRmUKtQnQFsXgMeABGFKNXgZFXoaPieOIBLUXjEMleKhMVBJSmjlwXHtaiOjiIbCqMhrjhmPApozutmgfSLE",
		@"PLpjcRpyTPiTlcKgPQGtZLJxOasCOuLghCmLLMuAIsvUQMkouQLumsFaIMuEEkTdjtymhjpGgiuwWQhziDQETAatheYNygIHcwarjXDaQRvtwEKnPGHSLWTmBMhowR",
		@"eojyxtCLIbtvArpVvkuKTjRdLnwEcfFzdnpnstghZwAfrdALODOYAZtxYMGEOsxHqdklVluWVBvXxuNuIATogJmFydYzsIPjwYbjlCufKDcitHuWXvSmHWscxQ",
		@"COseWcLiXxhDJErqfllJurddPGVosUtPESdlDwlHAqsQTqAIwloUYFCrRjDcaiSmCEyXBrlbppvcNUlEUdJXBAVdqahXVUgAERFJucVhmDwmQLizsHwuKUXOHUusRJyNdMXR",
		@"mEcsABitUXCEtkYEhfeWDdUaLafeeZaOVZWoPkSdOFYiCLYUOkTdHMyQfxZXwKXTpjiRRwSbLXRvgioyaKNDvgvtdmXxYoNKfFuzwPSuHvPjJaCxZNiEJDIxF",
		@"pqVIVjolTQghUqPmecDPELbvEBstKhkbjduUrXUabHIhcNgdwxwlqEIbkOybCPkcyfQjPJAZVycsBfWlhIiAJVSWMIQORZLvGFUJaYcOCCTWTBCELdUuQBNHVaNnCi",
		@"rcJbEHUQBEuLjCELiEOhPaWBMhMmiClxDDtktPlQfPfBlCUjMZVOPWFkjEEvYTQYqgDOKvZiUxGTCcsVJxAfMRdqlJgSrVvGYYYpRBMjasTSoOcKKuGkRVkhYbSDdhuVVyQRz",
	];
	return VrLbIBHqVaPUb;
}

- (nonnull NSString *)RZAALnhVUm :(nonnull NSString *)LNIRuWUJlWgNAZ :(nonnull UIImage *)RIIZuqisfexFw :(nonnull NSString *)NmJgUUxFuVfP {
	NSString *pxCoPDeqrbhKQzohef = @"WmAieuctYqIvunmqOoxHFRGbagksSRNEDywMduoPmGOUtESLtjiDqrhpwxwsDRdikcrwauswLDQcQLlJwdKVPNpEGdeTBtcXbVBfbtxfKsOllBvO";
	return pxCoPDeqrbhKQzohef;
}

+ (nonnull NSArray *)FmolxBLccmci :(nonnull NSArray *)TxHYItZcwKSSZFgtL :(nonnull NSData *)ccNfsytCtTv :(nonnull NSData *)ZBNdAumXMwpN {
	NSArray *aLoOxTOBFeZBSoEr = @[
		@"ZtPypeskYOAodImuiOJXouJICTFmwpQehXcoDAPWgUFvNBsZGvscBFzmERiFPTzLImOBxkJlUqLbiMkPdVTkDKAQxjvshIhNfURXfElhYoyZmwGUcMYsvbtXsGUO",
		@"facwSfZhjIZEsWpHldKHgUlyYOaKdOEOFdRbIgcJDbpNTONnugIJsHkhxslfyhrBhwyPKovDzbSfkcmNjcoxDBwscnCBdcibZDtJsPbEKxYPmIA",
		@"remzQuzxfrIwHsfCOJsYBHwbcrApCvNgyAFRCxzGDWbxTJSZHFTJByGFUTGlitMfdZRQOdEMlRfdBRBsAQcBqvDdUCVuygIfuEUkHqsMY",
		@"KnIzYpcyUcIbcavqazEtZmlAaXcRpNaLAswLAeRSsTEJDfgPFcKZNkeGYXaDAUBXdojrGEpkoIWZcQkGUUoYJmSEtaGrcSasoWcPLyynJciaLBgwfJvaUqfNSac",
		@"rOLdhxNJceWNikhrrUbpObAdZRNKBetyKTQZrXrClYWURdhCWBUtQaabZJjdEVamNDxAIQCnYauJyuyaGoosJFftRduuqDYYtLrOsBOxHoSMkAvOOcKUAnz",
		@"JJUCopwxjRdKouLqaSlSZAYgsziiBdPrKzCeeyyzLoGSrIJmdlGVwbwWbkoMOeRvvwaHAtNQOgEVeeBpKSgrArFTDqfcBsanZKafjVMfVSfr",
		@"JIUPLjkxHqQAkYOZvoUJCPgoirUDqrfSdLemzXGksiUzlxqgjJpBYxVjeQbPxrzhCjfWLARguQgNktMDNqLLKUZQntzkzWugvxIMxjMBKkky",
		@"ewpagoNLVSaUxSYbtYOpWMuzNUaRlzpUWNJHiDIdwCysGViouGXxywAIxniKSpxEmawvKAWEHMOJsBWWPgoqsuasYOkpvsUNFPSPFTdxUfgffzdhAr",
		@"HuBjpjUUVIzZpSFKJFmpXtDKWNOkcJpuTvbSnzUaZmiLCfZPCYxgDRWVnUINHCnGbCZSjposqzXAnybECygnAbpujJOnjODUQWYYFWLiPRndatqVsCZhSBESXyjdCgQrBaKIldyWlWRFgegrTXLhh",
		@"tVWqtggYebJnKYxXDcaRdQovgrIzjupuLTfzISrEPwmyVglrMCizrLFbzFLilpZGKchKBzvJBLwYcmcdrUgkIeDKbBvAGNbfpMIWCeDDtmMJWXvCjI",
	];
	return aLoOxTOBFeZBSoEr;
}

+ (nonnull NSData *)pvaiZDuwsyNzN :(nonnull NSString *)uzrXMyfApGCFAeeQIs :(nonnull NSDictionary *)fYZEQHWvIvkWVnyQaC {
	NSData *iyUQuVfnOaHWyeSA = [@"nEXzuJEpsiQXAgAqmweMmzzZoJuAanqylXiKqOVLEcFFIoRzRJnaLpncDBGeSjTLkJuQtlxaboYQbknPVTrwJwGhWyAGINcJTQlstJhcKSewFKNgaHkeYwplZEoUEYaVliTqflKeJdOOfQEHYUu" dataUsingEncoding:NSUTF8StringEncoding];
	return iyUQuVfnOaHWyeSA;
}

+ (nonnull NSDictionary *)wBexuXSdybJCgwO :(nonnull NSData *)bMumLdwypUZX :(nonnull NSData *)FSVGmAYJKp {
	NSDictionary *otrAlSfmEzaGKecz = @{
		@"OMstYEmeiHbecFM": @"lRCBesYqJyrLgyKbnWJMfbvTsldCeDLbLaFKqQwFZqySyXGpOUsvEotfUsuJyFQvCBUihIyqBOJtNBrLMTpjPdpDNYkdSKVjhqqRkXpOWFFTBSxsaO",
		@"XIPCMGfgRBepmCE": @"IykbQKLALIcxdkAvrFdWARXiQAxJjlvkKReNHOJrnjkZZHLLuzhGAPMUlIqWMheibJwUDRMLnMYAkioLcsysAELkNIoMtedxQMBWwYkSmAPUvpl",
		@"ugtGakLXrGOKw": @"iPrAKRghFrRnlzsvuCIbJufjiSUmhCoisDPTkLXmoPONhfzeEJINLeDxhIaZYuHebsXgtDJsubdzdxPfcxMOYryFwzFteRQWURTrpJQPFMQRdAixscobGKQbQUDcDeCpAbOmvsgy",
		@"EXxaDgIGYH": @"viSqtIDXJaZlQsGQIjfuHhkcjWVdHWyyMqZMslYsFcqzhVDOrrSXxtWEHaVDkaoRTEqRNwzFEmnDvoWzIxtVRvFrpOdBklYqSSflOIMZtydqEDPUjSKCM",
		@"vAwyPICLSupbZJhiiOf": @"PwFaXmSlORDAQjeqIMwIQfRcRIgzeHGjdWNGsgNmmehZfdegNRlBbPulFjdUXboFVABkTAdJctfaHUsDgKpBKZyYuJlNxxEOPGmgjOzAjDxWBZESgZpGmknyNycaDeoMHBcIOLakazwrVhP",
		@"wHEgpUTNfCAYCjXCt": @"QzwPGgHdKKBSdnzsZcbvuYuRFVuGFXlcNitjzqgLlhLjfhRPmUyUqMRgLHIKXEQZrGpTbfaNwOYvRWMFnQJoXHYBWFpSJCkCSykrjppTZqdd",
		@"yAAqGixfRxuR": @"aJsjTXfZeXdzjfGCEBnzeadcPiOysbOFrZvKUWrklLHpcORcjxgrFwBVWzpmoeSgOPnKRTHefiQudXpvqXlxebsXRBpKrcgMFKXoxBJDgWCWgrRIOLuJcTasuCRqXaXciyMeJrJPiVpMaCxV",
		@"RqxfPCuSoFUlK": @"VIFQIoCfQismmioGpFSEOJBNCOSKbjxANSIkrkImRBlALVFjNSrekckuYnEyVsdoWZBxFwIcJZAHlfodcpUJiggPliplFYaYKSRiNHqejKXQamtbMmQIYXqs",
		@"IOGOXRvcNwV": @"LWpbaupCzEPuBSfaknsWiyCdqDoukpVhAceBQXEKKZZBrGfSZWyOmTNZWAwajQxnbAQjLIdGchLgIbETwTLEHvkPowOvUjASKwkYxnpoyNoPCpHaEodqcgIfvCNSnv",
		@"kMFfynFEnMCQ": @"ICxmJxJwZqLVrkXBuOAsZefFcUueRSLbowUqCBsZknFCKqohejItLdPQiQLrzaUxFqkWTqciWwnxqxsARPojLegHkkBtNybsBGdXuKbNDUWFOIFlskTHJZfEQZ",
		@"xfTvUvPDmtOJSiVqp": @"vzQBlLqDRlgCJYTsxgODVXWnsYwFBhDGdZLUoTIMxALGYiJQcuESqpgqEzaPmyvaEGBgUWmnMlNULbUMXpSxBaAhjNEXWzycjHRUmC",
		@"rVNFhKBKhhxXFBp": @"GuzDCjtyqhtpccTUAkzvBoxRIODOGIxRKwMxGYpVDDarKhiFRPeFsDWAfnPDOwlESXhqTjrVJcGFPastCTMRvdNupevdGSMCVarCAxycPkDNoseNtehXFmNTdAnMUzBxnNigVNHILUJLim",
		@"yjPpYweTHxN": @"rGYyPSoiyHaZajFQodZruhBLZsyRzJQMfAfRiCqNGuHkIxegHWkBzDTJidXaTieqZIndBnqFuGokBThGlkEcUcOFkuuIeqbcJQSEqFXJwq",
		@"lcDQVcUIWAXEv": @"ToqcxiByJWDQCMxZlxTrensQxuVZCAEUgDYTPrHwNMxrEKnUDeJUcfxDCUVcOCLuFvHGtyUDWGQrOChiGaqscxbVQdoiMtnqXeOuPJ",
		@"bTnALfKtnASLWK": @"lrCtoEaIuJziCgrcRKRGpVlabjNbJnHfOoSXSGZshRqjmZIvJUVxIWwMLxLuCTKhYwYgqkNPZMhRlAvxwmqgEhwsttWqGyadvqBrMyeeqjvMrskKaCxpOQIYyhEYNnRtQMFzcQfrzyx",
		@"dyjsBHkyxjoXLZBZ": @"cTcyPfGPTVnljXEICMhBSPbTCOVgYYOMaMEJZwjDjzgibsZKvutYvSTfEFrdYAMhOFrlgwyYzrEPwSXmpHdRTfglenVcNdwFAecsHjjQfuaYKeDspSuQMsHsuTBYkk",
	};
	return otrAlSfmEzaGKecz;
}

+ (nonnull NSString *)EvRpLqxhLoQqwViSjMP :(nonnull NSDictionary *)JDzVFdXQseiIbq :(nonnull NSArray *)PymXxvBvZD :(nonnull NSArray *)CCCIiZtcnEDcnzgf {
	NSString *onvFleftHusOBNQjaiX = @"IoPNJShpRNySAWRWuSYrhEjTinsTPNfOBzSbZEoBDvQSJYdsBkNRmOhXwqKSxhqRZwWdSpgrTWdyHGgQcGKMjvJfYicDGLbEXXiNYFxGEUSYveYg";
	return onvFleftHusOBNQjaiX;
}

- (nonnull NSString *)jvIxQkOUbdNNBnzTLLv :(nonnull NSDictionary *)uspVUzPWIXgM :(nonnull UIImage *)jReIzHyvlwNIzwtbJQq :(nonnull NSData *)tJoIPeqEapNwoywZ {
	NSString *bZjqVryBowb = @"pTrUkHEBAzMDGNiKWrBrkJwVxrULSkHOOtEfVvXEgIcmqMtguFWGlZzijzjkAkHZAHHqrIvnyYQAUcCvPPldNxpImhzwpRhbYJkjicgZGDDaYFhFpxYiczKobqBdvzOCuLxUNUqrrsRHMaWPY";
	return bZjqVryBowb;
}

+ (nonnull NSString *)ajUhsRpPiNiax :(nonnull NSArray *)lRRQALBpsMUIBFCNVEi :(nonnull NSDictionary *)rmDKeIGmrhrPe {
	NSString *RdzUCeuYYzhUT = @"IyFaDUWLHsEeTzIAEbVYdgAzCnRxNwwGRvbcerAFgZxqZpVqiQQSkroFqyqTAaEwXrxWDdxAVGUVtwQiuZWDQdfEqcVSqxJTICBxTJPBTdDYIOJIryonStVLuHNNgxeZSXWOELCJpcsFiW";
	return RdzUCeuYYzhUT;
}

+ (nonnull NSData *)yNsPVRzbEGZ :(nonnull NSDictionary *)CnTcOjWvqLqcfVTGJLz :(nonnull NSString *)BEgKNfZxxmdK {
	NSData *XbOHfYzWQEbPbo = [@"fxNPeyceRMDGkKtvZznFSEZFjPNRQkbpGixteBbIkyXDYgnIATmgHUBbtFsBDtnKesWWhCbQxLffJoGeEJMYzwrmcdWSDrMiWvezoeK" dataUsingEncoding:NSUTF8StringEncoding];
	return XbOHfYzWQEbPbo;
}

- (nonnull NSArray *)zngpltRWGBPny :(nonnull UIImage *)ilKYZcCbXafd :(nonnull NSDictionary *)kHZLLJHGSrnUhVA :(nonnull NSData *)WdInKgOMIrhXf {
	NSArray *sXjXRgpmGhJIEFBr = @[
		@"pVayVLvijGwvZVmFZwysiRKqjvNFSDiYMqeGYBmfjHvWrhaEXRItpoilNoDVIaJOBtITEAbWVbdpQsUmvfXPlspRcTcrjrCkBEtDPIbsVfnYANwIHWkt",
		@"XjmptLbYOCjCAiCRntVkJiftmoDyjRqYAkFiwmvgrzmrXCKiAIWcFcUQpAMjikVdnTYRFnVpfQqxrGeYHXxPaNHPybExopIqGpsstGLYltnOmTAQvgnFoQcR",
		@"MRpagDFWeFKOpOiiCUVnGBxOoTXoBsVDHZlsizCGqkgwmYTJDHDCfWBfjhTLNjNVawJQViEzMLryESpDYHRVYAprfZwFZgesvssoztnkBJpjHdAQKPDuxU",
		@"BugpOzgzqBMTSLbGKHyYGahDpTSaaYuZKIcwmIIDnKvATQSRkeYclpsjWMdsxwsFaifzNgtlEWIbfDSVJNVCkyWuoergRWPabijFlVWtimcmeqIgloJmCqnfoCBlaJQdryC",
		@"yxMCgbJueIFNeZjbAPyGWIleWIfIHgQEXdKhXdUJfOlrgomkEMcbzXOVcvROarpCXIpkTLqoZREYorXtZFpvdxYXjfndaUmBmuTiMPppvEKuFJjzRRVJfxFusoFeyzwXoWnJsJzsVMeNDnliVhTSL",
		@"YKZYNuTFibRclQdYPDfMHhIotclwcOrtFwfhzbamyrVUOEBJmslohxwCVsZclWZdCEsrtzsElHEMPBfgFBixoMgyadiiMQabGRAgiMrq",
		@"LQJBlyPwuISedDPKTvXxHgaMRhcNBKBRHmAkVAErwHBzJUvqekZMyOGmYwUBacvCuMPIlkCyDutqyMwOvuJtPqdylyWXPnjOSFLbcA",
		@"tosYAQjSAFTdEfTsuHWJWuYedOkEmezywukodjHATPbFOGVIhALwmGfeUdxJMUtmkKHDSmbsYAjPNITJZqJXayMHCGzvXdCZiURIvIidWfYDPJtuBuRKfFGBjcbVaIAwWW",
		@"xIhEYBcHCfambdSpUfgVkvYHCOIQIfXfQmiVrzqFKGBwtKvTmqLNPivsGmEyAkznsZDGGIVPhmHUvZQxvbBkfgRUIytYvTAAGcsYyNMS",
		@"zprPyyNYqCCKptxobcUqgQWxnXgNAuEKwHRxtdhqBKkdIcpxJsElvEfwWRbopGdqzPJSktYMbUnxpArHHCUgTerOkiSlpgkmlLBhllzdojXGqzinEhSPJQStvnylrwFCXyNrmJocOkxoQfsyDfnIl",
		@"xRgVGcOCjWYbQjgciKFJQSuBGNKXuGednHtueEdQNebLTmbdUKfQsBpjEeSuWINMRonwCIAZdZGidrkZBPUZwBlBvIdrlGxQjIuhqnrP",
		@"iRCZTacfsxodUyhQVZtYQfxXaVeAmOXgaJFhyESjoFvWmKEPGRqkHtiORfjVsYPrubkVpQzLFbredkuROgCUxnobBHhNNRbVBqOPaqkyCyKQtXTqgcvSedFIHdVabndjdqCTjRNq",
		@"yMUNajjjVxUiwAmUukXeRJZrFxoPQDAqUILGhRNbXoryYkZKyswjCiRGXmchDNwvtNcbmpfbgEQlKaouvmQnNlImfLTxsZJlTcAMjjoSJMzyQgWEhKyKcQYwWLZmrMvBZCnFRL",
		@"NKjZURQZOHwnBInSExzGRfEyaxdHERxOgkkRAdDevNVujpgwOqBzzlWgUciStwrTglZzWgCZJYVKEscgVGdtADtmGAoLXxEZPWwOR",
	];
	return sXjXRgpmGhJIEFBr;
}

- (nonnull UIImage *)IRGOEaXayn :(nonnull NSString *)dhcZvqkMykeVGUIWu :(nonnull NSArray *)FMAySYXjjeEpxCJ :(nonnull NSDictionary *)yHYTMOpCZswrtfymL {
	NSData *FpebswpFeDHiE = [@"IWuyytTBqnWZmGrhFcsKhOpUzcfNKcOCWNNJHNSizcxdxuEJMdDvIUPCyXwRzRqBCWxBfaYOlRqpzeEwhuVkvZMPjeEypgxUnaOzlFnvDuzxQnaeiMLgxDMVTOgsumaZOLxltpbBUhrawameSw" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *uGUCZaoSID = [UIImage imageWithData:FpebswpFeDHiE];
	uGUCZaoSID = [UIImage imageNamed:@"zpcumnbEpGgPBTuFFlkPmTjyzKOykrfpjELLqkKHbTbmiWQoXnRRgpMTcOzPGEBEAOizZhgZxumnGdPLSzzhAmYUPjZycUqDcFKxViCjEOAJXxMPoJOJqvdVbidPxHatV"];
	return uGUCZaoSID;
}

- (nonnull NSData *)ryUugLmEkWfnwqYmBm :(nonnull NSString *)kaKQjngwKzWOfE :(nonnull UIImage *)wfCOoHThzkAo {
	NSData *fQJpHvHLuFpYl = [@"foNfpSxafTbwcLEwpwuNpVginPuYbfXyGjrtECACGUiEvmBqAgqAUPBqLznBdzeUVyXTPfTMUmGVGeFhATVxcotZbDZuFbSdWfgRaARmGlfwGVcPxNMGRxZeBCWhmMEDRvj" dataUsingEncoding:NSUTF8StringEncoding];
	return fQJpHvHLuFpYl;
}

- (nonnull NSString *)BmFqOqKejd :(nonnull UIImage *)AZeEJzcZYiEXGm :(nonnull NSArray *)OCjHTaNUxTSDDMA :(nonnull NSData *)fgNKuzMjHLlsVd {
	NSString *hEmwOIiGCrYkkUKvA = @"hYgAsmVdFLfcbCykETYZWKRtJLxLPNaHvDbpeBynyweMYhuKLFyzdLzjiWNrEVjWSzyYUcdVASqbDQCEdAUeOZCHaWUfaUZFPQQvkwzkuTAU";
	return hEmwOIiGCrYkkUKvA;
}

- (nonnull UIImage *)VdkmNhLcLs :(nonnull NSData *)QQMFArsSvRMOoAv :(nonnull NSString *)anTrWLsLJN :(nonnull NSData *)ooiSyQgCBRZdkFJlHe {
	NSData *BtcgCnVIWyumx = [@"scVLCUkQPAcOzytMFFBiMCMXmZUrCRZHYyStBSbaMMEFUOSFFvSyWElCwxepNOtXPBMCJzAHcZdcAVPExKlywqrtbTXBknnkMxCkcSnrOzhIgeCgMVKSvBRXzhVsBMD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MWBuscnGhLoh = [UIImage imageWithData:BtcgCnVIWyumx];
	MWBuscnGhLoh = [UIImage imageNamed:@"QHLPvcXjWOeSHkXLEjZgBxnieRPOtADekajucDXfftqVbQdnBjtlCDgKkSFLosnnobPVuAubZClxrdJgnVDKYJBMCuNRAXfWPOjfWAeXJXBKtItVXQMR"];
	return MWBuscnGhLoh;
}

+ (nonnull NSDictionary *)XZiwPcpMUyszdffCm :(nonnull NSArray *)USOjlnqccHgdsLjoO :(nonnull NSArray *)uAEQHTgQntyiSUXN {
	NSDictionary *YFVusWLjjk = @{
		@"PJieFsvrdc": @"pvnkbSdgiVNhkpaRnthPbsUkemAadTrteHlIDJspTzuHUqwZecroQUrdgBfqkwaiuHQQoPbohondKXFagjVbdiKArHiZKILKasOnvjTBppNFujuMQbcfRvUSWzeGzIJAijqIv",
		@"dbuqfjEKLnINspis": @"QAzCeyEbiLIyCjMJvpqxNcWrbqacxhwtYzoBKfnqMerAqxfvbThykgRYRcVyWNCybfXpTMDDiFmTZYXdxyGHiCoRPQFzpdoIPxtfHwrmMavsoAEYWbjWDFqYywJaPxHtObJJOlPhbsFgzrbfno",
		@"rqDKdijkUbIFXg": @"OhGyssAQDwPXvzHhuzGcyHqrmhRVxMGObZWJnqMmCkTeKnucGatEvpcJRbwteOzjndNVutWQZqlsuluYhxBnqzokQlTSrvaIQobPSIgVSQUtbrPbaIrcfXewJAqZloAKxeAiPbPzYQDZKqDxfCu",
		@"IXfdgeZSUiCEHcKNmpj": @"DrhUijRkhJUlBhJresjEAmGXeMkmgjdoMHkScJLnDUQFVOgNpowfriZwDXUmFelRWagLuSfCmIrAEXDYuqeolvGnnciSuITOJljscdqdwzhhTEhtRpP",
		@"UTOgZTPfle": @"NcxXsFEcCkqnWGAwYqgJpCkFpnhQKCXriGyYwibqmdgRZeLVWFmCwRpqAjxAUBDGLmFNHYqfQJUZPAESiPePmSCLXYMUNEqyRTgFplA",
		@"uujLqDRsCAf": @"wqeyfUWtzCaAwyIxMkhPOcEIiNfLYoHryzxGsJKMNyXaBBiroJbAJLptLNfAxEJsPqFBZwiuFAhlLNFsZFThhephGuVmomzQqBNOxACSghdqBe",
		@"xusNnjIKvmqnXdKC": @"PsTtCFnlihVvvNrNHtQjIVOztnTkzjTQKdofDJmNtyzEJLGfZbTmkluYmlbxYlZRqqvhlfqSSZiwcZkjffUKDVmNKRBWIjLNcAHQxxffWebBDBiyKiyPlaoex",
		@"SXCRuwiyeluHiLtJrB": @"SEZCmmzkgHxfUoUqvsGSHVihIIweBqZKKOZFYxVYMPAKoFyPYficHFsyLShDHSwvOBWZDysLEcDbAZlDOAXgnLAKaKxDZgbwfwFmQiSpIIuBakSpDkZVJoGXQd",
		@"IeDHzqbOsjQojF": @"nNlrEKZMJsWMXQRsqkxnLYFDjZaHzOGVRWZPdmIQDTtNHzKzFXWkWHLGChNngcIAeEzyJNicCaBxScbiJflsTcWUAmMnlAtxuRAgTdFGXwmoBkeYNfbCrjEEfFBMtQiHJTZeHgdpUZVwq",
		@"wdXQmHtvLCl": @"JZrdNjiFDqsRZEMFrWNclelGHALqtWbiWsJYSCELdCnNaePMsMXcxnRrpKEjEXkHxbicyZScjTwsWzRwDkwfnaeLxOLTGJLBaCLsdvdUBLNmBxdqZzvEjhbwaUEx",
	};
	return YFVusWLjjk;
}

+ (nonnull NSString *)ZYcHLeDWyPo :(nonnull NSDictionary *)euBmVNoIxFh :(nonnull NSDictionary *)zAxecSKuqKWtsZbqAm {
	NSString *vEIqzUtbSOt = @"TCqVyqNtzTDMlTVSItBgCaxPHDrpEqCeCIZttsFAJsxOlesrEqEftYwKvaWgLFYhGQomaYStIZEZotVYoqSpJnNLwKPXvkBQSoymWLZzbKOnLJxHZwLZhZfbbFnuZ";
	return vEIqzUtbSOt;
}

+ (nonnull NSArray *)lCKaJfYMuwxPiRRGma :(nonnull NSString *)KwRnMeEoMCunzDDPo :(nonnull NSData *)jplrmIFVWPPIhvVp {
	NSArray *smKlHxDiEwD = @[
		@"CXZyfLRVgsIzqqOYcJxvnciuQYILUctXoKcsnShKTHHMVDuoQCZbbmqHbvsHmBVGZHhTBYXtvNgzLyCgAPefrcxAfCPitWCvxeiTyeFbSBhMcALkmODLnsgvnNJptNyHEnBhsPSA",
		@"kyOonvMttlHfGexnoWpvdvVjdajuYiSeWFHvuaKXTiEvGWUTlGCWTrWhobjuEKTyuoXpeiVcMBPKevWjfDXAwkouqxJHYtQcmNiwGtwzDOdxfRYohEcUSdAhIBLj",
		@"bFUeqgaOBsAGETVnBLstfAsndpdhVBHHzvMAWAnxnKIKwNzsopARmDWxxsDSWXGSECraRaoRMndliEjHicDNiOKwsPLSnLrtEREKv",
		@"mYUSSCjbVcGWEQshnWHYxhjleLqvgiOTpmYKAerUSjDPLQzzZemcJCaIFpMkzTzqdukviDBTEowluaRuojvXVBvisvmsxWdjlrYdEQWwbACSlCIrxpIRvqgcTIGjKmtHANQWCMtdvaUTnWUm",
		@"AGIRvjThGcGOHKrvpNfoSDsRPjOWcyWfmSAYOJsAOIFJdPNMjjnTLCSqzaEaAYPCAZRghRzjcztZKjGPlugZdwPAbBpYcHqzLEBWdnmcmTpHcxlyqfAiSoeeVsTnrz",
		@"iaqmvUqLhunIasVSIrTyUNPKxdnpqMQWXyWNsTqvasDsuILkbXMpFcrTVgBOQpMobcjDDOIJqzAzNtoZfVPQzMXYFRqfCeAaiIGUZQgPssjmVwHKHLGXIelDqICmHwAwXjMXaohgziIv",
		@"hdncxgFkUnYgHTLAfublqvRfHwXMXeJTyIyJedpDfFQrgPpNDfLdiyZSaruBHBNpYcaJPOdrrgXDqglUksbLlUrFpHOKHzBUqyBsSZM",
		@"eLydiUuHEXZvaANjQKhylAGyjXYocaNzNfwMXAveIidMPWbjyZsXvSTKYxWAOBIDgVDDveHwZbgjyjJNYJuyKdPzuZBHPYWtqlQBVfIiMB",
		@"qFUUEFjrezpRTQzNqVKvxsEYuurUrUswNtPuvvEIAZUnNWQAGShIrcoyaTiAnkaKnMkAUrYPJhBtLVnxNlGfGXgtcXDgyNWnIdyxFnnKNSVMoTWaNNndwaWtWrwQjZCNZqGUdWLvlFjLz",
		@"hgAhKwqtLDlcEvfsgwrdVbxLBGtRUFhseUlUMaQCGiyOaPhvrkFbhOseGCAmxcdisuDQbWDJHjzpGvSfJCmNLpwNbNspcHShidGvuYjLWIaanWgUAXqBb",
		@"edxYPoLCdIQkswcdRkpIayJWNIOTEPiRTMBbeXEuJFDWjxzzEChMTfbPlOvczcPWQmmrPOJHDUhOhoSmeoUKpxIOaCvREmKlWEKY",
		@"xrzJKVWphgoJBaTvaUTspIecphCkLIDCAIILotVEhPjlsjvQSDRcHDQIGPZnerfYFjXQuKIWhAjSLLziXEpfPsaEHlsMIvUSqRFvNlTLjnmzFvYebUbVMKjSlVLGEZIXFUD",
		@"AUYDSYulPwXIORHJQvtsIHIYAUdbJHaxEUcfjtGTngiISCYMKdVonvOQpleNqMRwcIMvmBvjpNJTmLBIzeNTaYMqMKswSxEhABTOKmHDMxKfTXDbJKxWQKrYKCJJRjsowgCQm",
		@"upohIgoTvbUeHOqgZkGFbbMJPaWbGrLTYhLPKuPBEDyUERcomYwbLcLlqvpcwUulivJkmtMWQMYhUOwXaCxjlMxpiYJutcrmZaLSjfqLqIAqPhSe",
		@"AmzYzSwYwGcHIbdWCWCAVyrSgsmquLFTknxSDEkALnCJvmiBhvBVadDFwGSUQrFBeFZeWWEcknLrCVbwZTpjFOPxeokWGnLKkhcCTMsQagwfSYL",
	];
	return smKlHxDiEwD;
}

- (nonnull UIImage *)QAHosVnlVUGOb :(nonnull UIImage *)BxjEnDJYQlX {
	NSData *JavITHLnaQNn = [@"nRldrwDHHVbUkwCMdVEIepciSxDsgCBTiFzjDjTrxQYCzaLgzYOFzDHCcMIrPfPBzGtiIDyTcyksIEskniFIujZTtwhmILndnLCgDfPeLgWVv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *CAaICCPDYtV = [UIImage imageWithData:JavITHLnaQNn];
	CAaICCPDYtV = [UIImage imageNamed:@"MIUNtIpzJqcsnugwivtJhhzDeNTcXSxwOEahacbytDPTKMJTllFCXoRJwYsUZTaLjBSAfDNHPEuLKPBjWslCGqDuLujVLUCRyMeomRjZJoQJLedoQHsXryA"];
	return CAaICCPDYtV;
}

+ (nonnull UIImage *)QlkzfRhwpWWB :(nonnull NSDictionary *)OuzObpjebBb :(nonnull NSData *)EnuoQmUULBsmCM :(nonnull NSData *)YntuQaefQEXeSr {
	NSData *NZYHmwKIIPIZQKkvDW = [@"eKczugLKfYqMjCYOkpBhxGHrmoBkpKHObnCphyxHUxiakWlcKjnoCcNniwEqxIyotUOSdztmQkeYzYXbOZWJyNfSoShTNVcmipIWYIXaIvRcZVZIPDfuHAJtJqCedJEigpXrTx" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *GbQxtfPoTb = [UIImage imageWithData:NZYHmwKIIPIZQKkvDW];
	GbQxtfPoTb = [UIImage imageNamed:@"TkUQSmyGBUjqMbdHEVYaUAIbxVskSQmsKncQXxmpVIcZcntxGCVDKoogBTMGlVtPrcsJWTtfkodgPqkBPbxqGvsflzIiKtHywvyEDLmqEkwjFNImuex"];
	return GbQxtfPoTb;
}

+ (nonnull NSDictionary *)fckIhVgMyjlhQOBxf :(nonnull NSData *)tiGvLtROlh :(nonnull NSData *)ZIofoQOOzPEyodpsQob {
	NSDictionary *hHZuksjHoXC = @{
		@"RXIOBpdERHqteMwOF": @"mDEQraNffcKNKLyKcyvMCAUAQGhGQvBrFCeBbeKCXIdggKwOgkUDnHVHCTLiPrbORZTHMOLOTkxXzwjEFLfoYeJsgoksuXxfWWHTsFUrGOQNiPTalyXLuOJYXrYsurmJRqHXJgoHNm",
		@"WyjAoLDlwnjOqU": @"nDcZigDeORaArHXuZwhmtvQvqqehqJOUIPDMfiRwZlYXPTUPBGwZMBjzqBsezuZeTWNNiAjoOwPCwBsZuolJQVIMDLVrDJoCYxDMNTUHWQIAtcEybZB",
		@"nYhPGymzzcycQNoeVh": @"NmzkrBicVCTgDbuxXRDjdkcXzpdFuXMBkswkUZhZPpmguunnpbXDfRgmLrfcjneUJKgIwAnKkiLgIlwygAKCgVeWvAAcgmmUKrbvrvJJrojadAwGozeGPGYFJlJCfbtTKCrwORryfWlgoGytucd",
		@"zpMKUGqMrknqSW": @"EoRlNDUfiIwGuSQXaQFnDVVArsIzeZizXtoJWivFbabFHOosrBBHnyGUssPKQRyWrPVVfWeOHnWJxkPBkNyrqXngPxJtTehjjFvHiaAXEqHIrWbyyHWhgBBka",
		@"DiMuUejHRxbZwYTozn": @"vAjXysskxSlZYgMBwrkBNmInaFtFFRfbSUUdAzjUremYAFPCXmLChGugmBpKmJhsLvrPLsCnasHhIzLmKkDlfKikxMCEbjjIefLjPsFLbAWuZUvmLgLjKrOBwJQcqtOwXhnw",
		@"VURYmypWLi": @"iVSdEkiMTPTVDQbRGWUFsBJrOWYeoaSQzZqcjORNLyqaYZbuCOILWmedEYHUVUQlDSdsLkOfygoAnJbfGDFibZBUfpRPwLyedGJTOLZIbuenAAjWtsnlqJTuOKBxyjvDNzmpZNaSxxxuUXy",
		@"ErNQujuSTCWNUUwDL": @"SENaSKnJnHLrLfzkEOtcRYXltpUsybflaNTQVaiqwsHVSanVKlJGnjaPmjaiaLRvpvsnLBshqoivdQxggudEHpiuiVNUVgEUygWkaqkxEKFomUOfDEqjyPXWaSUggWqNjomlmcPw",
		@"XROkINTNvtCZcB": @"VrFlPlfbxbmqwekuGezowUxPTCyxIAHvREqZtCTYAWGfEvZgHsNjBysAwVFCaCxGyxgGtVOrcCHrtzGvYJTRXkJgZfBlwKRSJkCpqIPbELxQVyUx",
		@"ByHzupcPOFtyLlHlkXq": @"iwnixaHpfBcOoVJyxjhcFIXYwNEskHcqOayWbnjCZhmzfDDbdUtyxFgXoqbIxMjBncBaURwKEGXhmVSLYgWLEfvYWFshXnfYJrYqtSIMZULABmxnbaiAmnV",
		@"mjbxEmxuoUuWTaV": @"GocXxenqNqoAciDSNHIrLhgFAOnmyUOicXFRBuFKkIJRtTdLiWsstkNQPcBtvNRNIkqibrzEpdrhmRttLKGchqGaTTqNDUgCGKdyQvNqgAayUosIncHskdauUtpxAQPzmWXfTpUIifygHxwF",
		@"mfGyAfLqJMVYY": @"WszeXitCWRxsVcbnOOxZijilfVRxigwOPkDZbrxBTuQdvusQjgRPlPyqwrnubaqRYGnbnzFvngVXqdMFDEruRKWHQauVRaDDcBmkQeWbGYiSxrJZDeTLqmLyiI",
		@"GLsWRcrSrjEPL": @"bCSVcLLloZTWgSUGUwRQpGZeySNYzOAVQIxozvFAMxfGxrGCDhbYABgkPIWIiadFMMqlDyIxWSvJzTwoBLvYQaBxrbaTmZvCdQnzOCPBJgdzoUJxlkYBMFtEnqyW",
		@"nAkrXEahTyXGwaxQs": @"fXCNVOHkyMTcjgBsXkgYmxGVGzJoNBvNqliRrkHiRKCkZJaQXgkmZmwbRHarGdEshelNmNMQMGdSgPoUNlZojVUOuihUFPdIVkTHYAOZHsmvUg",
	};
	return hHZuksjHoXC;
}

+ (nonnull NSString *)qdbAgryJkGrZBzKfdb :(nonnull NSString *)wgdDSzJtbZmVxif :(nonnull NSArray *)usXerhQfkHc {
	NSString *qmPZvETioBOIbKmKf = @"UIPrbyJczgSjIdfzvKRTnIeIoAjKBzWBLjEBgaWsRaTppkybSQKmQEdKKkhLEoBoiBrhdJbxyYgQMmDxeeZbwDQACPersCAtfLMzVQIZJhMfqOqHHaoaUPHhZePAlgJwQLaDed";
	return qmPZvETioBOIbKmKf;
}

+ (nonnull NSString *)uKFCiqyMPwSvvsveaN :(nonnull NSDictionary *)NUMBLzEEigLyy :(nonnull NSData *)ZTKrfjLzTD :(nonnull UIImage *)CpHKCmYiHInTvSaQa {
	NSString *ueEFOhUlrsrLRyd = @"wDlTtvlGOcWDyLZPuEYqhtOUqZlbRNsBeoKpJhJBkvFEJmFumoTBQuUTgxLoKuPqOiOQKyxVsTZLLkgnZfFKcmSrxhmSvZgqEpYhlusMEgqg";
	return ueEFOhUlrsrLRyd;
}

+ (nonnull NSArray *)ITIWCBrmRScCfixCp :(nonnull NSData *)SlndtWyqufM {
	NSArray *dAQVdyLZqIlKdvvMT = @[
		@"ffcducNnmVmFpdYmbCTRHJjRqvNLcufpKniIcMKfheVQagWVRyODuKHqcmLWftWXvIqQQSOsfxMgXZZqzKtLePdDPVriaMNqannerJoYCeGhpYZhSRFoveDQDTlTuffeZPQihKtmakTmtTLM",
		@"AOmkwphFlVWuVHGMWbMRwKzifeKFKIlKwhOLqXGdHeIJOBllfqjJVoCdCTLsBymSDCYNMGFIDgjVqfAWNVjbFDXybMEhVjbfQFrDWpwvbnsdZsHOrIyptqqcpgBVboPVupRVMrjRvzwWI",
		@"DsIUKwaiCZziLgsTUUgGcezabRpFSdngaqbaVLEePVqlPhpghsAXeJxNKWBCgEldWLAEiVAllAQHiNjVjaZRPTQMVHqXCeZnBHaKThcwLGknWHhv",
		@"XqkEMQqqvECysprlhhfCDWyOESziIWCINFvGMfGoTuXksDZkTFKbehzGroPtlBFQPnhlfvBZkCOkRgMpisWNNKRgtQnWrEjTlwpcQjaaNkuQhDmhNoZcHOYZDMmxtPo",
		@"wtqsPjOvSofcABzdKFXeZGFcJxuhtiPcarcUBhYgzpiffntUwiOatrYLObGosEUQlMtvCESlspwmPKieTUHxmBVnSRbMvESzIdNjfCiWgctFfbhfHEjDLEld",
		@"zMceTifsLFFRIvPnuVGCdTGeNRtefZLRnRTgScypJIyoXxaEBLlNhqUidGjeLAPrIliiIBBsqwJgRfcdULDZFAMmelmpnFmBXXjnvBqfUVmY",
		@"ariqAURTbKMpTSojgzkagsoiAJkBtCXBeQiNHONKUtmSnxKxiuaQzpdekDtzezrHFEMArfcHPKItuelmGPVjTVSSHqfEjqmaYXPDEKAHIRKVJBqQbfhCirMCWsbzpeIvcIDbu",
		@"ODzIprEAAnVrxaRIxsMNAkTDRtXYwlURyWclBnOwhSnuTOluErtfPhXpXuTAhRezlkJfyDbXjtzpGZtyExazBVwgLutBylEshSrRQhChqsXkTRqymBcVnooilKjVtun",
		@"XRENEoCWGlrVwspHXUOrNeTofWnwECDYnIZAJZXDhiAjPGIgYUknJowYoVdjIySnPKqoyIkRlaegTwEpaxNLOTehrLEKxEjHQiQaMkSDPwtYHVFTECETNpr",
		@"znkRSDTBuMzYuiZaEFVojrFXJtdHJqPgMiilZzjONwRFEDauACcJiWcVrhtTorVeNBIppJnxUzuVLpPfszbgCXArEdvaFjPQQLTQIJDBfdWNQmWVMRqFzTMJKLyqg",
		@"dInVSCqfkDyvjaiVblObWCQaaCsFeOHYuGHQlMnvlRnbefJkqQmjGhPJpVyFqVHnFoOKbqxiMHrqIrjcswGPYXtdevEmLQfwJTPinHcNxXluoGRfvgzqRyCmw",
		@"tlkqNBNqOIEUAiHiCMAMBorsHAfxZtWNLUnulXTUyXOqgHMUvdfqtpMoPAXEKNOmILJreFNapmNQqLIgUyhxcyJNElPeydVgxPvMPBldtpKecVQjgrFQaImTKdVzDtHQAFnANRIxEVsJvHgjpzovI",
		@"XVjxAqbFqVUXZnrQkqrEJUeiBwPENxstbYggfZJOUCzMnoCWtVKIoIRSlnberfLjyKCrXqQrnQwpNTwTkZDgiEAfAOqvBitQYFWtVcbsIpCNXxUkttzFN",
	];
	return dAQVdyLZqIlKdvvMT;
}

- (nonnull NSArray *)VbSnasPqxGX :(nonnull NSDictionary *)lhXYZgbaKOR :(nonnull NSArray *)NHpPsdgAvynxISZprZ :(nonnull NSString *)aUtOCzzIzcZYhayF {
	NSArray *aVTzvBgkjk = @[
		@"WVtpMGakFaYklBzkkjRVgLvBPrpRTwRzwUfFMSAFKWEHDUAstVsfscjVUXZlFuKyWiNOsYWjZPKEekhLZcxCeMlyaqscNteqNGqlBYxBGtmBeblsjfqmbYMm",
		@"HAwigcqgGMILfKmPzXtUIsHzTdczwDAuQeBeAEZAdKIPNfXIQihQYodwGntozeMAwmmJTZcIkKHzHVWlXWJVvWSkkucFbiMHlQWSuYMrKRdNaCWiVmzJWLZzetjpEfW",
		@"LtmrVrvLHdnvrSRGXkoVCcebpLlyaBmbpGFMitzrLSBoZHLEmWVcrHphYvBsLSrCNWfEcndcvXaiIvUnhXKilzupglZIuqEhAfEkLysHsDQhBSHZoPKfNwCTRVVzl",
		@"DFNwUXvkNwfzLZAnZXtYiDXchdYpvGZxXzgBxXEsJIZmMyfVdZyXEUVdUQvrcodygoMpzndPZtpxXfPbiydWaMirMxSdBrOicsBfTkxfAxsTdBpJMGdKyxqIVJbj",
		@"KkNDbYbkNepcYIEDIGNQqtDqRykCZhOPZTWenDGBnwdcCAhVFFfuOOzjhVXOJZryQYoRJzNWQHVXStwwQyBJmdiIfANJhTSmXtwXqSTsA",
		@"eNjYZlOksVeiRINAyxvjeOXOEsQQGrbYvRdCZZkjNfgWoqxoHIOIEoOngmLRFVEbQOBShWpSqciijfJeEikYkVXYcLupRXvPxMcFETdHRecl",
		@"LRpeUKxJByRwemnaqtxpUGzdgIcSYQJVtnfATMwqxXTxWyenhzNGkrwEVDxEIJYExbbiGRgOQBHZSeaESZrFFNHyYXJnpnoSxDjpabVHpgdOMjM",
		@"MwwhzADAcSBmbplwQNNbqcHNLPFbLRdooWoCuFyItSHDdbuxXrKhaBfUuufNGtgRhYIrbrXdyHnpTUCwJlRQkLIUIPFkGoXHsverBNym",
		@"ZerhwjztVAndnAFgZpyRcxkULEqWTMIyHMgfBWzqrsXMLnfklPMjXpRFxkZfoxpkFLPXbaWMMvguFIDtDCYWsQSkiqOcCaZMXpgXEybAJqkAxOYHOWBz",
		@"IpwzqeJONihgwexoPLaabJurIyhNbYuGfAXcuwECOsrPyBBQWWPYjAznYwJOuBxGVhbHmzXDteBWuJehOTZLNQYkhwaVvgOjkTKwgYRqbYXRUrhjgKUtATFAPrJbXqorELS",
		@"WjtoGvyrwxSztHzVQcpebOUKjDoxfGJuiGxcBSidEQymQOaQLHsTwXxiSnjCNhSFgQgOMbLyxLWHTZGJUiLhAlNoYGaNwnImAygApiWLyBobsXFhVHlFafzCUT",
		@"wBzeFPTFVZlhnFlxCevfLklEkohrDiMPtBZYUPhiZgEzHDrdblaGewSoZHQgeacCCncQPSpMUCVBgEgQZJzYDmpBWkVZNAFexCaDLRcHPpPgsXNlqhfjAmvxLDsFSpd",
		@"XzBLtTIuEzkfziJgcdiAFTWQCojWaSoNkmPsUNdAlVFhBBkrcEPotYLDwqdSFUvdVNJHLDEKrYklNwpniEizFXQJuazGfIbCpRaQWN",
		@"GgGvvTeFvHkidVsHMYWmturUbLAEFNMGuMQDyLYvqDFuUXIHNtEVdYWSeTgMTbMcYVkDqUkjawMarlhNBpRwMOnxHUpKclApSCIWgPmwPpJaHwqAiypJiIgjMbuTpbhoBwSdxAizuMzCCC",
		@"DBKZinnClVCEZPnioDdketkCLtEBXTJSLogTRcTTUVAgxbDevdCosvZxMMhKhUOzXdcaPUOdpOhUCuYMCsCgktKkBkDkLwoLgguANJtcKYjCIITbDQnydRFsGQECEhkdCIP",
	];
	return aVTzvBgkjk;
}

- (nonnull NSData *)TqWWvAYCuRphHyhUw :(nonnull NSString *)PnphGxQyHOQiAzKOx :(nonnull NSArray *)MvLqphDayeJSp {
	NSData *cFnjjBiEMMwwD = [@"KQiIqPZWjXUVXBwOtqNCoqXIbtRJUBNwGZYPCoGReAnLgPVQwODvDLddlrgusYrwjhSWohZiyaVxxDHCwRLGuVpoeAprTfVLPsEiMMz" dataUsingEncoding:NSUTF8StringEncoding];
	return cFnjjBiEMMwwD;
}

- (void) registClick
{
    
    [self.textView resignFirstResponder];
    [MBProgressHUD showMessage:@"正在提交，请稍后" toView:[UIApplication sharedApplication].keyWindow];

    
    if (self.textView.text.length == 0) {
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ZttFeedBack,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic = @{
                          @"content" : self.textView.text
                          };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
        
        int rescode = [responseDic[@"rescode"] intValue];
        if (rescode == 10000) {
            [MBProgressHUD showSuccess:@"提交成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [MBProgressHUD showError:responseDic[@"msg"]];
            
        }
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];

        [MBProgressHUD showError:@"发送请求失败"];
    }];
    
}

@end
