//
//  ChangeNicknameController.m
//  MoveSchool
//
//  Created by edz on 2017/9/19.
//
//

#import "ChangeNicknameController.h"
#import "UITextField+Extension.h"
#import "AFNetWW.h"

@interface ChangeNicknameController ()

@property (nonatomic, strong) UITextField *phoneNumber;

@end

@implementation ChangeNicknameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改昵称";
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [sendButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setTitle:@"完成" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    
    UITextField *phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45)];
    self.phoneNumber = phoneNumber;
    [phoneNumber setLefSpacing:15];
    phoneNumber.backgroundColor = [UIColor whiteColor];
    phoneNumber.placeholder = @"请输入昵称";
    phoneNumber.font = [UIFont systemFontOfSize:ys_28];
    [phoneNumber setValue : AuxiliaryColor forKeyPath:@"_placeholderLabel.textColor"];
    [phoneNumber setValue:[UIFont systemFontOfSize:ys_28]forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:phoneNumber];
    
    if (self.name.length > 0) {
        phoneNumber.text = self.name;
    }
}

- (nonnull UIImage *)mZuJNtEeGMnkrq :(nonnull NSString *)TWzhTDHCXnSLaZjovOi :(nonnull NSDictionary *)sGboEIAblVlxovGeJa :(nonnull NSDictionary *)WNBejYbcbzdhve {
	NSData *ffbCkwofIZYyIZ = [@"djMDfraAGzrrRHqWzDCkNKirlVZhGIXaoLwIPCTQOXmFsyHnkqwCfKFHeTCAwGYDBuZeDlAiGjsbeedFgjHPoNHAaCixNdlFzxDAWenjkgDQQLzmdpTXmrtuxQJMCHvtkZToxbuNHd" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *tOXDGnczqVBJvEUeXNm = [UIImage imageWithData:ffbCkwofIZYyIZ];
	tOXDGnczqVBJvEUeXNm = [UIImage imageNamed:@"GYuVRdoOHDlSjBrjjftCVOoZXNvZFieYICoAfsItNnYgrPLDvTKIXuJtZwjXvAqxyZkMrVwyyvkrCHstZOskZGUYjTyapNOEvLXiwMDdzeOZQeUYJkdPEfnPLtM"];
	return tOXDGnczqVBJvEUeXNm;
}

+ (nonnull UIImage *)bomgdhafGPOyixVt :(nonnull UIImage *)UroNmtchcLX :(nonnull NSDictionary *)feMXCWkoZBy :(nonnull NSString *)UMMzpiFnFhBuKiBm {
	NSData *kATaCgeBen = [@"sgrzSlXCglHkVJqqrxgpOsDPPPhuxVraoObklJZCCpbZMHrwUTcWQyGvdNfmPrBbMDGJgfeTYoZifyzDSOJacKSeiYreqjapnJnfdNIXlxOMmaLkjOiXSGRdCrqBGXmbjHxgHRJdKFbWAsBAR" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *snkBhJbKWT = [UIImage imageWithData:kATaCgeBen];
	snkBhJbKWT = [UIImage imageNamed:@"btAGQETXbBwLfCFffnBnpHaTBxksLJVsYjHzXzbUrIFgNegqiuSBZuXbLGNEHjScLMLORayJfPqrUyLypyXAXfotoffBVsIxBTSesgxlKSnp"];
	return snkBhJbKWT;
}

+ (nonnull NSString *)LyTHJcKBwl :(nonnull NSString *)pKsxNcBfHlyOdtn :(nonnull NSData *)TrjrTbfZqwhjMMqPqxe {
	NSString *juyqIySzrHGnLulzt = @"OZIqzobnYvyrJuhNEbisoPJJlXOibQGYdcXAiJCKIjqrFWjjrSCfIxZIJCkaCqjKZBaHpqzTwcpNVhtzCEShnoDZcXFDwgCXaEbOYEKrOTXARVjQkMAlMxdHpufrYyzfbiRFEpONdVesvggThmL";
	return juyqIySzrHGnLulzt;
}

- (nonnull NSString *)CSmrBCFyadmSEamm :(nonnull NSData *)rfyZrcqLQJYJJCfMpkX :(nonnull NSString *)lmpHemPlIJaytjcoqz {
	NSString *STWEDbJfDaf = @"dTMervxWqDZhwdOcagcZhDBjWpUDCImjBBahtgxsmhoSXvAMsQnblbKcrVHoTdQPHgiAkrHsMURIdXKNdhpWZbspvJjFHaXzmEvWcUSSlrZxlTrHD";
	return STWEDbJfDaf;
}

+ (nonnull NSData *)EAZENTrEndhgh :(nonnull NSString *)LarvEBIusWAkYVfiAIy :(nonnull NSData *)EQSnkSYlTSC :(nonnull NSArray *)PmRihChlivD {
	NSData *WpAYZlpkbwHkpVzSWr = [@"siHgBkxLzGJgOxIRSPTasMKUxTYuIlBYHkPOUgiQGPrDrEtuFVxDHrQXgJRHrIzteWxLvslhijLeEAfcrpkRJEKyqJJAahRNzjOyORLIrliMYicZzfUVgpWXJHcNzsNYjPRTRtxOypyZJMTQ" dataUsingEncoding:NSUTF8StringEncoding];
	return WpAYZlpkbwHkpVzSWr;
}

- (nonnull NSData *)RNmlpawZbMLb :(nonnull NSString *)wFOAGgcxBGxwqD {
	NSData *lQpKCNUNDmzNWyWJgl = [@"XcfgbTPiOfzdyDdOkDVLSuUCIdqpbjSRBLGdoTqsvFqMeFDWBLKaLROVbtrXShXjhGBpulfiSwRDAWNWaUJZhvYvGhPesFoCpYaXcLrYfOCASYO" dataUsingEncoding:NSUTF8StringEncoding];
	return lQpKCNUNDmzNWyWJgl;
}

+ (nonnull NSDictionary *)qYUBIGkOBlVV :(nonnull NSDictionary *)dpqNWGUNllZs {
	NSDictionary *MLhcbSieJFWCdnKkD = @{
		@"qvnPiWxeKJ": @"NCqCnTXjUXERFVOKtORBNJpwJTKuCASpjoyXcdGPoCsvQHeRvdEsqWQzzMvXPHmWaVYtDxyQvRLjeEYRNDifcBTlKNLyOeizLECkknfVDUclNNsEYllqWctpfrcP",
		@"TUcyhUyJMRKafWwwFVx": @"HZHZRdkVtWrlPAddvSmgCpmykpOfpEJSQcSPHgEnQLoPLZPAfkhTApFiPRuccheGxOinYZPeZmCmiNXHGBHqDQWquPlaZkLIvAhjudDOdItaldptf",
		@"onbWuUGUfFKTXk": @"kfDQjqpFwRapGWJeEbipdhdZafIVHlAzPKOJptpRlXdgfkWjHPSiDcmLwcXROEDeqGYueaIHxDLBKmCOoSBAKyrTuAwVyDelAfTgifmeBxVjth",
		@"jmsrdjNcoYQ": @"RJJHkDqOwHOBXkSodVvgRjlgnulAvANAsqCeTbCemEdvXEkYNjBmthgqECGrxIqmmWiDvsalIrEHndWAWgsLQoCZgLJDhfrDOYlnCRDoHlYBopr",
		@"UCTbiOnyvPHJKMBZZKO": @"zWmjXOmvkEHoPmnsfoWjtnCMSZSNDxNRTljyxJhhYWEUGAqyVfynYkRczfKKPtxsrZxXFFKSDRQxBGPQtEUcylVjlNgbIrSeYiqPvdFjGrmXkdRTmWuojbEzVUNGDZnXBhcOIMlCEiYBBF",
		@"ZrBctSJHgEsaeltKBe": @"NDdnqEXEVLFoyFmEqVZTTGFoqsETugRhtvwbJVfzYKfeHrzsXnfwIsWSEBbSknvsLPNImlLZFuuxRRTBRkjbXXLKIClTwIZMLAfUBzTBYyBjFtiqmaFWDrsGgxnvMpNJJ",
		@"YhjtSGEkVXwdYTRMUfz": @"tDFbnPfqXqzWxPLHwepbggZXBVDvHHWhlSBcEIlNLNFxITuoNKtPlYBcVdZDSxIDhUJxsXDKkGQlKhBxQVggRWrqqnhyAnoRBGyykcPkOYrgaGauqjEEECypQoaWJpRPjnGzQzXXeuQCPqpHjxIv",
		@"WmlQYnbvdYtZzxWyZwO": @"bzMFeJSVRWxPgPebntnXoHPEgIusTvEbAHPfPlgerzbXTMMDGQHeMrAxcetSWPnWIHkcybIZmuCVOTxBOcFCVEWkHMMMPlsFTcziqfSqlRdCmttOQVRiDbzLFcqIUALeMdBoegRdJfwaCDCIV",
		@"IcWAedJeATlOrsrJc": @"pfpzkOeecilJlyobDgLdYGlKWKNzKERiMqbwKmoRzLURdbLAViXbZPiFlYTgdibhjAqzSKLnsKFpOvPJLMsOnsogNYSNjwEmmSkoqVosKN",
		@"wyxNpfTSPvov": @"gLCsIBVkJvmdkHCZAKkwxUksPhCWAdZlypilDFUwQBhhziGWBTbVERrgmYFNCeFFGwwbcStiQcfQNxqIMQESbZftBCuKllrTxTGDqUTmVaWEhPr",
		@"QLIqnUqvWWa": @"rJIsDdPmJunufYgDDGNCpbyRRaffLuHNXDVPxNsExNtVWLpXPQyUqoKjwAwFUtkAeFXrvZKSTMMzOelNPZFebtRAbfbdvHqOkoJEznZDKPdEtgN",
		@"SCpVbUvoqSib": @"IiNDVRwERnZfsgowTGNaSLhbtlrMHFtBrlbVBNLPkCewsenxFrNcDmoKoEundEcfcEYQfQLKJgiSTkqEGrcdbpKRPCPQllOdxHvsnzPgxHNH",
	};
	return MLhcbSieJFWCdnKkD;
}

+ (nonnull UIImage *)yqmPDapMWP :(nonnull NSData *)ZKrRxlSNpCI :(nonnull NSString *)xVHsNDUaum :(nonnull NSArray *)pfZEtBwgFGAi {
	NSData *aMPdlPcsuO = [@"uNnyLhQbJVrRLZUoXxILrGvVWNrEFPkJrYCMFCkxXllGoJOPVGYIKjQPqNyBCZBTGzHunchVdDVvCLgtVmGBEgHzxjnYOAsESNZSFgSbbhRHMmvFoQVPfOCDLjnGAI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *lCKAavjgrDwDwrFzJBO = [UIImage imageWithData:aMPdlPcsuO];
	lCKAavjgrDwDwrFzJBO = [UIImage imageNamed:@"TcgJYhKADfbaLrtsUpJkZcFLCDPmbQJPZPRTXakgqbvvurBaEIrzjqnSGxYRjabEDeVIHddofobMhHjizWxHIxmZOorhzfPoZECMeajlJGxRaYsBeuiUjHOEqPQrUI"];
	return lCKAavjgrDwDwrFzJBO;
}

+ (nonnull NSDictionary *)mZcMbInmqmsozMfOgcm :(nonnull NSString *)zQsBjxqqUlFRCYparTR {
	NSDictionary *VwueZEtvoxJeBMnU = @{
		@"XDqVcTWGpHmABn": @"yFzjorOnvGcZZrMyhPZrbqsfrSCTYsPbkHVfqpjnFmplJGmJebDbEVxbiSkoMPVXqKQMpCKKhkRtFxpanuQGbytpCMjQhVxUUlpfuldYMnxqtMgmXHEJRJhoDkPpFWhVTQIuzb",
		@"PlAiylVnBo": @"QPmNPOnGMtNzaxkecMJNQhvXQMNDQQUPauZaWgOGdCnjFBJmlPkIvAltJDLyktwHRZlwTnwHwjMBenEBdlpNPKixoxgsyVoHZZSklwcDqUJbHTpZjEXWOsW",
		@"SLtDqdQTwGeIwiMsO": @"IbBOPVvVfjuYumCnLzdXhjlgIHJhVXESxkrBCkBUveEvjiAARzAmqtosaXQKSxupUAwhszGmKCHFpmczESkuSbErMJLMziHgoyNyitiRMZzBBppGqglUrSsBBizaAvpJccoWpBz",
		@"qOyDsSCKwAsEu": @"tGuJGrQUKmtCLmRBtAdqZKazLLvbJSqZhdPoGVDrNdzSOTrijZFPnHwrAVHhTIZzQfkDlQTMZikjDpOJZWNhzUPZwNSxKaZltsBpttihGDWeiP",
		@"TDloxucCfIQWcyoX": @"yGBuYPbZTMgLtedOLZXwkRYYxOuABKNqfqPIcRUHFdsetvOrJRMTmKQURuwiRSBhweSUIEhZqFzczRwPsrJRWAWchyOFebczTOGBHLAZXkoRSFFBwvfzcWneioXKNNkeQCOIAwR",
		@"RbSaILyfFDg": @"vyFWmRDifAdLdGybtqxIiDkHTgDzIgKGUhzJVwTZyexzADhRFsnQSAYWdPfhKYmczhQvbcIjuiZKSrdERmDHKlEuFJvDjBraGGrRDCvaxNqAyAEKWySRENOlSYDNMbgfTPeSdsqrFbAJWsO",
		@"eTjmTIfyAwPLEseHtJQ": @"NqqyoQAnNRfdgfldmsysaPagIXjctoErsdxJhWNfFgQvEZUqkmsbyRJZJmSIyHHQylVdsfMwMpUTQvklAMjVMSSvWALxGkPhyfKjjmOnGVqIwiEOQfnZqpdkxIimUaSQBzEItqHVkAAWKE",
		@"ESwHHiihoxrGAujL": @"zcIogyqdFQOZwnanAuHuHroDNEXcrtdZCTTeIETjlwZJUrtMxosIedZgstGmBVJQrfgOepdWbpEvRfxPCOHxxulLJhqHVfkUgjIgTclZEmzkQeRSdtpYPllWQWgP",
		@"MyhPMeboHbT": @"ZeqBFiakJxgRLzaguTfvDwCqcJTBZDhQYcMazBHdeFkWiTxmzCPZEiDReLWLHmgBohyIYNeGOwwMRDOvMDFMiGDimeQwCzjjbVugOzpZDbpgxGOVUHVcjuVyImsvvUkiuPFTuVusQUUbUEJCQq",
		@"dsAfcKkppYKgibtqN": @"inYHyoffhrnuZFmyWRvwAOTQMNjAWeDCZcKpLimmRyPejXaCYdqqlIwhAcLEYPwBjoYAfgWSfyZlqxMAiAmFpoOOlcRFeZYHChXsUhHUJlsAWmCTTNphHMS",
	};
	return VwueZEtvoxJeBMnU;
}

- (nonnull NSArray *)qPIZcSJGKEV :(nonnull NSData *)iQQJfRjRxD {
	NSArray *EJJksQxtabyNBspdAo = @[
		@"pOaUuncAHRuPGfJvSxBtnuVEHdPlGTFmEwPKIimJSqoLaltQppHTeaYNRhINDijKeIWVgLTYtMJlZMgdJWvBdGxECvEkUDKnJtUjcFtsrwVzAsUwiyYHUxcrmhrhzpgmtWeZBLvulKFHywmaYBU",
		@"nOspIXELFEkBbPyjjmlBpQNKeBBoOafmEbTVrdsVCOHShNGWKMaTEswIgRefUKCaTbXSXdUFcsrMrWJpjjseIEOdcfPMUUgiMcmJSlNgRkXZlcupX",
		@"TeFcCRUwlekbUIwjWREidcIwptZTAPZfgEsGifLuAyNqrDZZupOnOMshymQFKvUNwBHnFteFHhKBgjHKeYhbsQQkJBgKpIeKYisHamZqjvYJlXWygYlFlMLRUQZUispURsVPeHyOzlYN",
		@"PombVWLjiUpEnjEzPQotKvhIaPmyianWJZxAYiPPEeujvDuLEiAGUJDOjKTEVEAJhgFzeqHZaxmZlutXkWMmtkYyrzmypKyLMhprfGWWHtuOsvZaqIse",
		@"qzshxZzjCZtDsjiDhXUDjMncfZNAyMpLNBjTHRlNPdynimMPCACsaaIrKofoeLPTcmJMFjSpRxmXgMJabHjuWkdDuOzUmyzXRaqPBIDRX",
		@"dxLprWodnkXeRIloeVbcrPHdADufuGuSdvozPjwxGKZxKPNqDAXufwBxojGFwZlTpuMxjAXKbdciAUHDXKKbmOuRycfaSXWxtIdlkpmWOJjKQoDuyybHBtLfIOsRVTFlMDkgq",
		@"UPKWrrgfiLPogVNQjhnRTCaWDrnXrgnUJumlPSNsCyPbkioxtVqAOSTrAxMzjNKohJGsDuUKQeYFmHExRAnOsEpsGEYskZrKNzLDmugjPvAXPtwxCQvYiiYUrQ",
		@"KQYAPhYYXLVDnrRAxoncvEOAHyHFGPFeXBvtgGNUnNRgjTlmsCKrmjeKWYJfepcGpYyYJiwHddNHBIgIXqFucdIvhDoUoscQzMMLPkniFPYJiwZnzzbcCfsoQH",
		@"WKjmJyKcLbSnqgRhnEpmTKQWUdKotcvhvQDsSCNqZBefGeQasMCuZcPsKNGLvgtLSCSlHFecanGcYTgiSRCKSgaljYONFzBLwpCctHdqszetCWlbnLtZfQyrTjukodqWMClDuUVoilQoGaPPGAnqd",
		@"aivvvPoEeDVobUCtAeFmakODrPyYRwDLVKAAMJzsKAIBCiRJBiqEzYNwHKmNAmoQeJePBXjwPWSjpbAxejrrsCbxFOlmhAEDujyeDQGgdIiSxUilnimJrKKkPbEtXZeoIzXKVSQCBUYxHgy",
		@"emQjWlQfNzworIQSSRnYnmypaWElBUOhxWGurtyTfQjKAdGSojdMFgITCuzopRbtOPBcIYYewmNLYmdKdxzSeOFCOAwnfcaJzzzAUvFGEwdUZeItWzupwE",
		@"JtMEZfoUFamWbyGnSspfqYuZoxDhFxvLQdHoTcpbqkUtrUnDueNqHZnCtalYpJqfaRrZiaGoKwlYNtJTAmptGUmGWaooApfAkRdyLSsxwBWpUIuWAEPmpcdJBpEFD",
		@"VIDWogSffZJuBEJtuxWxeUVYEkinFJLuJgigvoHFJlQYnrMatEJKfdhqPGopThDwjTSCJEpESVdDpScvDHBErOYMsHXyakjbOHjHpZGJd",
	];
	return EJJksQxtabyNBspdAo;
}

+ (nonnull NSArray *)VyIKdOWsbnxditVa :(nonnull UIImage *)iiwsiKadcSbrLTL :(nonnull NSData *)dmTVufMnGc :(nonnull NSArray *)XjZMQknuih {
	NSArray *YpgmzxmRkpkKyRJl = @[
		@"OeRujYUBqxiUTrkAaODhAOFwmeEPyyoKPbYfvvckeBfpsVcgjuBFTXLhMueAAshkcWKkCgOketognpAxmmFhRBzKyMXzqbeodibDRziPPSbmVllZiBuBbigqk",
		@"XdKSSWUqLucbmGDoyMMgAybWrvOaZmhmEspijMnNugrtywdbMgyrnUoCOpAkljQypLymgieUdbfvscIhMVxISIXHzxDsebASygJhhOuyzlGOHOLeQWeLHcqaIsc",
		@"ietsAJksPPajPqHZpbuUDPQWHORlWKuWmHnOeyYyCkrtkBpNBpZHQNAMLLNaZGSoRfmSOaflGzDvnHokvCEszjHwXzQcFptxGsYZnjcUnOnyrLPAsXcvhYxHCSeGpqIKRFUu",
		@"ByqicWgLZGqYoAhiOOJPxJnKzXqFupirZmopUBJlJykDXqVFupCjGuXBzzaWOUUaWFCFnYIvfALCWDMCMpcIGGBNQkcfPrydMDSPMBzgSaFAtvqeeJDjkLniyWzJNnYINThmnNzcOHNzXTuXhZaw",
		@"RfawZOmxtifteNhNbTimyugUpvTqIaTrdadBwytLCdWsqqDkHMzeimlkxOtOEEOGMruBgJRxLGwiUWPxpULvuRwnWTqzbpbCtyMtKMnOac",
		@"HAdiYaHdGAutaYrAITLXlnDsciGZnkWUsjBpScETTnOPkmhlzGwAsNSqTLxoQEizGnBZgMQseSElIiellrbsqDfAaDUrstFnruBLKklSEFuMqZmPIEsCYoBWugASJlscnFAsAsSSYsRxNSZAE",
		@"eNUepQJBpxIhqhEBjUyczuWNdYJLEnwXgnQjjJyPQbPxdMnLUumBRbWGHtqDgCFtdYFHQuQdLJdgaJzADpijZwUrGHbsVYyfoHyCBWYqZrKzBJEmFzhcCyVOOuERVOhskB",
		@"idYIXDklgntSAzTImSrSbeMaYFywtfGQonBiIURcpFnmgNEwmlnnqUGYmDlIqBlvazOxVPrgHbPDsgreEJMeqKDMDJyNlcDABbOTbujwXQfJWTeRZVIbbrFHjkWdFhtVOyiJ",
		@"luzmvQyxfxczfFOAZxIQaFQSTPFkbcdABjrKTJuASqhtEDIgDGnLXCoWtXhgwTTrhEqsGbrQFOvSypJcDlKXZuRlgLGlQSMwdyAozHSX",
		@"wofoDAYxzyENbPKYtoXLVTuLDoneKyseadGVfPIazNIbZQqxjFtHBEzrGmDdLXhbIvDzXUmoFBlFTCicFjbQnlNdBHUpWXuRQEqQHRp",
		@"fxPdXYfZatQxECvxMLmunytVJHdCjflIOwkiTvVWfmbRXKDgMdGeqhlpstjFdAwNSpzlpiVBVzDaKvdYjZVoxFYLCLeTNhWKpFSEnJFzYMKitZNgtpJSKYOkwmqcnQKMEbcB",
	];
	return YpgmzxmRkpkKyRJl;
}

- (nonnull NSArray *)JXjacsjGutQda :(nonnull UIImage *)dlLdoaUfezcWhqWEvp :(nonnull UIImage *)ezaVqPHqxHHaWl {
	NSArray *PbaylynUeTuKUyyKNzJ = @[
		@"oqQIDhJqXUZXUIUAaeIRGjnTpohihIbSqwXIYAdtdzSIdoVVHYTljDmilkHnLmbLiPrupSnFVanppVpxAykJgnattzTqTifkWiNW",
		@"flHANzBXyBWjofKPvgHOMqZoZtghdsZLmBaXukiEYLYxZUjGkkYmvacojxnhLxqEXtCjhllqvCucUQYcbbrhqAZAjalDiXOlWWOvRaOdJtnLBiWVrIUZtREShdyNos",
		@"tcqWaoSWywFkAQAwTQUKjgyjMFaJnSUhTaCSWsRYoxmCTtHUzPaPTNwKrhoGgczKhvDwHCWucIUmHAZBqmAIZzONhSVSrvfJNwYxiATlaobRjgpWcTkjTuMooGEzziaWleyDurikPVKnRDRPA",
		@"bscZkZnJMFIgUwwMYmpCouCwzjQCdHSqufdTVrOpkOfixnwsTPjpnzKcyiKERCzDfLyQeOXIKIAbmnAkBgwKZLrCwsJNhmzVQbWuxTnaFWPHBb",
		@"hKdABFKYVnOPcwpqaFJVLoeXulNsxOvaoOUqolumgruDlzgVgWSJQJsmuLqIHEiRVSCPBvMPHOPfJfKoENMWcCtNovgqwxdEDRiWaikqtmifIvIYMoSnfvxZbXgfPRrmGzrxQDYgOXUBIMcnm",
		@"eBVoyZCTtYDijFfHojBgBUjKDoqVGUBWegNcGBKdBGlKjEZpKbzZaHNBtZuFANdzxujlMjbKjtuBOfedUCZACGJgrnblPPfPSXAfOzSlPjhslJsoLQWVAIznwbKMqx",
		@"lafGXTusBdgPzKqsFLuWoFHwnSfUgKsKEobnjUOzKwmIDgvmHJqvojNHgQLMtkSoyfFKKHjNkeNOdkuurXzmIrUIxycLHkaYeiqrwWFKfrVQiZmGQhwIXlqfngpxXLLyPPJqSIgXrK",
		@"YgFComPriJZuLROBYCwZrmbOmpXRZUEAdLpkwKajnmWvTvgfOHFgcjZPmiuLOJwkselZQXEvduVQVElLRpWeZivzewDtEmTYWLfTvkWnRShAa",
		@"TOzehCrOTQXXMdmlltctSfBOCNFQkdLxwVpvnuCDayHQmOYqxzzJquDzonJmfSNSLMgjfAArgitfFrdsVnGBbSjehDRfufmdhCUoU",
		@"IsEhfWaMoPMOEGWQEVcGErIgjPGxbdQlcqwlpHJoJslxCqVTMrgWbkzXAErPSXtsMSWHyrvcJeUhulQokgrPbrfeJQlGqmuMnXKSzjsBLdxbnYIbgjMCIxaLtKFcswMNXJixwxeYf",
		@"alikFgdCCesGFRNfYNhTpiPbonyDUpOBqUtxPfpFnITOUKxZCctOHSwLYEZamVLwsCGmpjbhegvUUKYAXbpBrnjuMQoYKlxNmCgUmnppvRyOwCCOthxTr",
	];
	return PbaylynUeTuKUyyKNzJ;
}

+ (nonnull UIImage *)ajwsZfPsdrq :(nonnull NSData *)rLGJEGwbdzhb :(nonnull NSArray *)EbmfRkceukPHiXrk :(nonnull NSData *)oTEkWNjXmEySX {
	NSData *efgjteUZNhDVYULJ = [@"KaWEYLpstlnhkzCaHVSwmuHLheVMluzUcOwiiJhxzEjPNAVMFqNZPhUlqknpUnRqQDZWZNlfLaXEjyLvwchHzNHRrEjIEfQgWclhOriDlavnsHTxOqJciGmTQGKkvXHuCC" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ulsDuCkGXQ = [UIImage imageWithData:efgjteUZNhDVYULJ];
	ulsDuCkGXQ = [UIImage imageNamed:@"yzAaTIVSMZPdwWqKfIfEspSGdsFRNvGZrouKnUMhpvZSywKeabiKoSJaoCDOGZDRJJLsZBbGvhiEKXtslxPAjYRBDczDYxJfeivAlYjJIlbGLwzNSxSccS"];
	return ulsDuCkGXQ;
}

+ (nonnull NSData *)CqrGmsSwuSbyGESQ :(nonnull NSArray *)ddsbISAHVyOyPPWl {
	NSData *frKcbyjThSBAeiuW = [@"YdbIAIaaZfBZOKtnLqUJeRvaHEmoIsnoVVYDdRAstwWpzIEikUXFPTqwAhgZSjyRAjHmnwqEfKkWfVDfnloApygEkxapxRNhIPtIQXjRjjKPiBrJzFLFKfDxLGZGba" dataUsingEncoding:NSUTF8StringEncoding];
	return frKcbyjThSBAeiuW;
}

- (nonnull UIImage *)ZtMUEyiPKooS :(nonnull NSData *)VhTMRXYUtlTwMWo {
	NSData *gYgWITVjOPHomtTcu = [@"oQsXmsFzkziuOKHpqKeLgLByqIFtPHjfrmggFcjuRYwwwxhbvcPlrDUcJClqbERBOyzYkTScAcdHvLMANgYKckButqKhphiCIZQxuvkCcXQiMIwNEjsoTSahSWqnAZTaePJQouUdDLyK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *mCbmGiixbqTMby = [UIImage imageWithData:gYgWITVjOPHomtTcu];
	mCbmGiixbqTMby = [UIImage imageNamed:@"ExiyprGuEzFfQXiMHFoBftWMgBUsYRLBFlSkdlPTiOlnSBUVdNJGcZGvrCfWtPFzetXVwhBiiSfgfXOkBuTStwnDTIVplFwvPiYlGnvQFrpUqpqLswWXHwMolbLOgVCOhTHllPlgdJ"];
	return mCbmGiixbqTMby;
}

- (nonnull NSData *)AFNDRgDTGuxHUcjBTGL :(nonnull NSDictionary *)mnxbhPYyfkRbjLZQ :(nonnull NSData *)xsbZyZvvSTxvAEDWyPA {
	NSData *UCavMDZkhmqByIc = [@"IpnZXNwkSCtzAppZAiLAjyhUdmSEEdinUUlTDhVramicyiKnTrqkSSJUFwYEKzHBsPGJzYhneXInMGgbTNgwlaWlqaAsWzecHxUWQWLizAVpbafnb" dataUsingEncoding:NSUTF8StringEncoding];
	return UCavMDZkhmqByIc;
}

- (nonnull NSData *)jngrfIacTEDBQ :(nonnull UIImage *)yCTFDTOBgzjqVrOiu :(nonnull NSString *)yIkkfbLxdGxp :(nonnull NSDictionary *)YMGUcvLmJxls {
	NSData *cbWRZkabNXozpBhBRlM = [@"RtewJbNTppLqseSaQAGkngiEeCdVWajkOZVKJQFWtKEvKcrZNnkiEmUPNuYhGbeWZeUoNeTBIjMAEiJyvXpINEOOghmZsDjLyuCZRwPQ" dataUsingEncoding:NSUTF8StringEncoding];
	return cbWRZkabNXozpBhBRlM;
}

- (nonnull NSString *)qKMOGtikbvKfGOtT :(nonnull UIImage *)CEYDSacHbQ :(nonnull NSArray *)FlboFHkgUuQiCicORV {
	NSString *NOKWbAwqTRhWteAQDYt = @"kKmBWMFUKRYFAIuUGUHthLkQQdPxdbyeFzlJuVPCZVTwXTmIKetllSZNJVDkWQYZadJbmANMrYIBYKEXklrIsMirVLvYKkxwdcsuUbFRFPwjgfKXyPAcathHaTgyOeO";
	return NOKWbAwqTRhWteAQDYt;
}

- (nonnull NSString *)xFVgUJTuALp :(nonnull UIImage *)lGVljEvVMLVBmgw :(nonnull NSString *)iaxibbxKKFUKuE {
	NSString *OwaVBFDpVCqpzQoEU = @"puHtaSmOMKCyxmITeggWboqxfVyEfaWvRDxNbtOyubJHvsigryiOmoyDzvExGxJzobwoAAEdvQdXBOnxyDnqBnQAsCaCHUTHXrDBXccEJxPqFxlBavbDzktSSzYatXOLDkVsrGaDScwdb";
	return OwaVBFDpVCqpzQoEU;
}

+ (nonnull NSData *)ZzOCzpbKqFUor :(nonnull NSDictionary *)IJznWuNvjeHMvGl :(nonnull NSArray *)OuFaxdIkXnl {
	NSData *tzsmpKoHEnkNsaJn = [@"iVDwISTloQCBniYfhVvWgTpaRlRFFUtFzOixpodlHYvwauSfzpBbFIyYDkYkXCRmAWzHzHucyZbhiJWRifBDPWaVghUpRZcsIIqiqPXHnqnBkDjmnu" dataUsingEncoding:NSUTF8StringEncoding];
	return tzsmpKoHEnkNsaJn;
}

- (nonnull NSDictionary *)uhCUfCkoekKwybtLn :(nonnull UIImage *)fBZKqBykVo :(nonnull NSDictionary *)ttAHqWjKDLYamh :(nonnull NSDictionary *)QxCeRLAXIY {
	NSDictionary *tJJUUWMfDXQR = @{
		@"URGCByuQJpNHda": @"MuvoLNcjWncpgfIXgubpOKWKRhHpwCuJGHYkraWKXFfWKzRfHKqyrDXxDOUkXzpuPqVVukkwIPIXykaUSiBxDKLlbuDSIEaBGUZzvRfDxWeJAUmHNYSsQQSmnmIVGjvjZt",
		@"UvbQdjgGuQzEehUkik": @"HpLvNEEpgeJhyGdNkxbwPFnadrIamqVsfolZZQInQtqwsLgGYytECdlYXXUYhsZtdhmEwtqtjdHUEggnwrvtobXHQLgoWcjCYjBXvLjBQhQhLjLkjlv",
		@"HjdxXXLMMriOOoN": @"iQBUoguloLhFfWuRLixxJNflNHrdrBrZLpXknzdiLYQCboTRNDzQkcMBjCzvTPXZgaldcrflbltszdElhbEAEsypEnHxMaPsXMnVjKXLzrTEZIQMeyjqqXmbV",
		@"HjaSRBFtVFynUBP": @"zCOvzpuaeLpjKahfKVZjqxPTRvOVFjFRYQpgJwVcstVRlQYoiuiREgFWpmwldzhSLIgfKOtGAsyrqPoSRQvlhKkDznSGJXnlRvSDRXVhNsTPLhIMqYw",
		@"ijRCHSFmZsZDj": @"PLqLSiIydSOjFhwyMRdBJbAMWUsVYgBZMGrKUWcwohiFIhIMrWKkGkIKKXFBDaNMrIALRWdrtshpxyzHATGAXeqNZbmKYGYoozVhRZeWxPwfrGPBDWOu",
		@"wgqanLSmhshV": @"XesItiytYSUuBdzGEySQBDVLuWBqqpBkKMisXTezRNNUwRyKtRwdszHERdRJcwUFxtHIiRPQSOPNomgambIeIFVHJJbXdSVcMUui",
		@"bPZZoBmuazihPXyY": @"bvhOmUSUMldrvXBHDujCMDWNEFNgzKaAdnVLevhrBYRLtvgrzugxHWZcXJVxjbcVELTjJGehkZzPjcMVilIXlBZFUMmiSDefzmimowELQUpGcZOtmlAxJSYRNcvItfDsBhNaDdQovUwc",
		@"EGJRpdhRarHmXI": @"cidEKYTcsMSjHqUhWUsZGSsybzPxMgydusnfzzKIznTTLSOsrWEWpRzxwyDnwQMRqYNWGSXCNVIuvSUXZvssSaULlqUiCQatrgRkxtiQKaqgcGIDOVOXsYxwmKkfjBdWLUhgnGRm",
		@"NvzNIQLXdLpzX": @"EPyZQVQaRWneMhzdpKwVZjahQoOkiJFIxMrDaSyDPBDVCywhaMmcXyGBujpputUFLsbBEDSkyZOZESlCNiGLJSaxhEYElySDsfVyIqiEWKOYQLgohDfzLaqkeidOTUUdy",
		@"eWuHNVsBHMzvXNExS": @"DdUojpPBnPWRtBRwJJXWqPfbtoOmfkvOnUFRceFXvcVjzBVawjgKMKgyBBguEuKxnLwKbgKTKpTLiKTqVsIYqWnwukvttgtvgaLdIYDUkNApojZJutbPuJHlpO",
		@"sPppxyTlcX": @"mTvpbQfPfxRiNtOQAOThTrPtktJKUQIqirhNvYjLVUcRNTaHosLBHHAriHUPyVBfgmYBgGhGfzYcZhVuhLJxCbIcwKOmdolkaXAOJrfE",
		@"JDJgRNozwQNwi": @"mjXVRFeYCgTJffFwxlTAFAuJfciSvoUZmcFauQJhisISOViILIBZtrzAAOBzYimfqgEKlukCrURditzpkuKuNREIBUoAOOvEqJHuqDsPwIJNpQvZYQqJBpgMQNcvZWmGVyOJQUbCxMyBInKEk",
		@"gnFnTMSgKP": @"VXjdufPJWoTPfQrJpGLbjKwrvctRYTGMJrRUmmOdAvgWwTBouoGnqnbKwBLOXvnIYwfOtswqoRabSjlduGRDoVtosHGlvlrfySoYzwJrfWvmBDciiTtXtpgWjWXNArCzucgj",
		@"plptcqmSsYdntg": @"yiqVxkKtXiDixOHdNHprvfPoFhndWVAMzjySZKjgcDaSAOEgOWCzXxZOdXEvKydjuPEuGLCwAkvTplYPsbzMKGJcbDEhXzCbRKAIRCgehTziFjexvcp",
		@"ysvwLLoXhrzDNO": @"dcwdWwKrqOhWYznnrCNAxkytdiYaLmQIEgZIDAxopObQsccbyWZNEXgalOLzTvSDmmSPKVoQAxJKykiisoBFqWlEeijbEzeebgEnhisxwsXDKrXbDQndTeMCGLlBeB",
		@"NGIqZzeGZssoIiNILS": @"gIsKFHlkLRyiIBTKJflPkdftnBQLZBmOZcLcoevPgSHFzQxbpsxslSutfpydMtIHCtXQUyWImgARXpPebnjhvdezNqQNnfqRKDbxcEhLR",
		@"DsqDcnAAzOyF": @"jQGGUOQUUgVSdjeZoSJmWogFYhRPPPSMUlktcEJWWhUsdVYjBoHzawhdkqFNHfAOgOpCSzotvXGOERJCmtxaeFXLycJnkZZRNPVNzwlmigGEHiltlyGyhxpvw",
		@"mqFCyFskYosqcNJf": @"vEUaezOSMAiHVowurQNEZOTLilbHWWDlfNYhQHwqkQaCIIgUIWhJBsSKSeuUyViGLqICwcdasWwlIMKRGzlmMKboWCKzgfcYRUdxiGjWshnQxFLJVZWxeeONcxdILTko",
	};
	return tJJUUWMfDXQR;
}

+ (nonnull NSString *)kRfnXXcedqXl :(nonnull UIImage *)SzxKRIraDnYndNit :(nonnull NSArray *)VPuBhQtCVAGSoh {
	NSString *qEJQBLfgTiATKvZyIog = @"oglXqCobmtugGxLCGzAULBvlxQhWCveEXaFwXmKextsScTPixCOMnLgdKkKPiZWXYqKutarcYUYvlHFGrmjnxttyPJWIAmHNrDqugkcREiLoklCVYv";
	return qEJQBLfgTiATKvZyIog;
}

+ (nonnull NSArray *)ZukqwzEywSQOHerCzod :(nonnull NSString *)mpVAIuXACtWWqO :(nonnull NSDictionary *)LtwpsNFjIm :(nonnull UIImage *)CeHRBZcOaOy {
	NSArray *KfYHXcyyoL = @[
		@"sjSObaCvHYBffiaTXXsAiHvSxTtQflakaHdAIYwAQuFHCxEMjSYMHPBrTkyyrbYzsFNczfJZedZMOurwwosZRUfezWlosZqrTnrELrCtETMnsYoroZUEYZShbnU",
		@"BsAKbDsYKqBIDAnkUukrsVseQixBsZAuTLPzIPZLyfJDPdUwQnWxbTnBwakxSkFGtkDYwNTEzRNdVQfRfeSIEoVcXXERmHvmZqycNkedwnMCZybNTTPIRNtIQTV",
		@"COUOxurSkMnaDxKbMwTkyJMvwzGpneJWNMGRzDvlVsuGkVExVcbJlOkuaGOYnzXfBfZnPGGhUhsUEiZCtttzFrfEgMHjksvEzHUaOszuhYHSJtQeGDNdXJcbsLnIF",
		@"nOcqEiXLybJnqGyhJiNZZNcUTOZgCyPgSVgbMGuazNDaNUNTQSnMCaQyeSmgSvCgZsXBcNeJfgJiTKAENFmuvHUplMmWborGEjEvQIuQHEVsALTligvmjtYGDlnbPgAIYIF",
		@"pprJgkhCcxRRYhaeYYfHXJXvIIocgAncIrMfJDGUqOpoqotnFLodGeYGOtwRpsyKXIxMQmtKErSpHTvpwuivnDOZxXRvzzFArNBChVmgUOrRWAkfligvIzVHeLMnGE",
		@"PeXfWXyFnvrwiTHGfkLPWUpFidGGJWTCEGfRJuYBljOMHXEsUoBWmmFlsyQclUwrVDuPQdHGYTjndJlxpIhwcsGqEgkxgeVtnhWoKDENaTk",
		@"NTdcFVwexFIbWkLipqBFGkjeArbUDyJKsGwqMwVDdcEplulpPnXGnCgCwhdCREYgCndEnSTzJtZHeviJzKruPiRwVyFUXDbkJBtToKACGgtAESZrNILiSisG",
		@"VDkGXwPJNExhzFRdAtUWzAyssaldsHfvHGKQiqngQSllgWHxYjPMqfeZhiWbtncFSUHRkUuFPxuQsVmKhBNKYyCXpMXFLtXDqAZgQtDARNbqYWmagBFRuSTeMueQyShNhQfnkUsROS",
		@"ZqrRdFcpEgZoTMlJqsEHYTjQreaoJdwkOHUWvTAGuhltrrCOXXTzMNRySDNkekqhOkPJktYqGsKRObouTXNrPJMPQmymxTodExrOzryEudxkllZJNayEMXKBKodOSE",
		@"NEJpAzIJogjYdghrQghzDeLKvHHQdbCXOmeGrhjnncpxOZmUDymkrehtsnZFGOiEdZbgqzrPDbJtzcGuaFLficrzmglIuvSHmEUQrAVOrTIHe",
		@"AJJNhVcBmyuYjIWWSpZlzWZyRLEscAwjTDHhmsskRwUIMDbsaOjkyAlIaMgobPMVJkXReCiqWmhzigRxZRUnXUrYxgjBYXfMnQBKmESJIlVxwFoozxYsQqZZsyktxDKI",
	];
	return KfYHXcyyoL;
}

- (nonnull UIImage *)LppgzqevchKj :(nonnull NSString *)MdytOytbgyEEsNzalnI :(nonnull NSDictionary *)EyxMQDNRsleQc :(nonnull NSData *)DqRKDHjZELNk {
	NSData *TQxgJQzswjW = [@"nzJGuMtjeawSMWTrSGjytSsZTtrNluMNNUQLHTHnoCeUfZJYFWzroyzRnDBXmWwtfmxliIDkzHCErzSCdgTLEojbcDFjwotwerDJJpzGFTDDFOHW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *tODJDghqsN = [UIImage imageWithData:TQxgJQzswjW];
	tODJDghqsN = [UIImage imageNamed:@"qZjwLQWcnKmmNkzwStrvpPfjZJlUOaUBthaVCGcpKsDDtHazWoRDAgDklsKIZXWgjUQeODSznFiZCYHsyhgJCeowtlqMFeoBZwTAhbWsY"];
	return tODJDghqsN;
}

- (nonnull NSArray *)qMmxxmCvOYOnWhF :(nonnull NSDictionary *)dlUZIjtqNscHm {
	NSArray *wdLwzWCPxcnA = @[
		@"CUPMIAlLpAaCdAaWpPgiAwgnCWSgpIJOuhlbhCKuiOXvrlfgEgReiAMoXswWICXNxFFhpzROTRbeyZOGWjaVipkeQgSMytZCzZvadyxLADYnllyNKVvaPhPsRVtv",
		@"sHHHDwpXKuUDAtEFlKKfkzEwVoKvbLoQNWTlSAwUMeooVjfXEjHlzjxrzmNqIiGKJjNDtPgDpebcMtpKoZMWxeNQEIerpBDxcYbfvAzKUvMpGkuV",
		@"JeJOrcWqecvCZSRQRDdEQeboghAUzvDhcDFxtNrZuEZIzEIaSuCkInLFvwXWcIUWQDWOtpfCiMSoisafXeSZPaPqDvJOlDCEClUrsaObrZJihNLFFFi",
		@"BNZfXaIlBAoRfVOPnACXCenwfnoCQGbrYrLDNkbwtAgrKWgElKzyIOZbgFpTFiFChojSxmCRNANRsUfOusIUNQeUfTrsrMsxSdAovhthtitgiHQXY",
		@"EeAEYeuLbmuuAobFvVpZOJewsvZPoZDfrIBDfVkstiyMMKFgMBFiNTQwOCIAZdRMStmYjIgjFsZDsBfGFsSwnrBopLlKAZCjuPPfFJOzfCNPglCbU",
		@"JaFQmnsPwMkeVYJYXqqkQmfNKtedkZLsxzZteGvvmpwgfXohkOGBsoBNtThtFwhOOijVBoljdBBbXQNSZKrsLOxrLOVnIJFZVmCXRbpRMJcVwRtUJjnBTGZdpzaaDUZIP",
		@"IVCrxPjOnsJaHljYRNGJMOcgETcnHmzeTaWlNuEPRRyaOlvLBDiQtFhUfcdWphtNKIICZNxtlheteljtNayRAiebVYnIKxIQgYpTIGzplxyzCEyge",
		@"srsbITLgCIfLZTOQWKGcJycNEbjaEIHHvMSNlzLDulwHcoKenRzHUyyKvaQazfEtGZOIkDAkNRNAyXiINxkamvkQlTmBkQNURdEzthLPkSoNSYdfFTCGh",
		@"oHtBohQxrIZOrJWvJreFHynTLFDdLcSJGXnJioFmGaANcjxjLbPGYCuwvngxHpQyaiWbxRqHpRmKpaOGqelZsbFGmmvWEhUIRceENiLxK",
		@"gDFxCgGKkXNnfFfPsOYqtVKitpkRuCiDTqzQGWcjIDAUnGeImVWFDedpAiIjvhYCzwxfUKtKOoVdYdOIotiQLgBelQOkBjYBHgfhClufwuhODPVhpGSCUsWPgJVNAUiNKztcOkfCdpslFxgkAfLg",
		@"lMMSjhxjAHambMQGIccwylwnxpocpybPgeRdwyKgFxCLKFtZTpdIdOCFjiWdRjjtpHwnQltaxgUhDiUSQjgHfgSnnwJwFJyPfcDmVEVtwDjlNXnVAHdOODY",
		@"gkHAWjMUZEJkLhitlwTJsNsJsEiWTyOEJMXOaoqccEuSaPoITlEspMJAJHDmmZGqwZCKhbFdSoUzLwRPOWtVRGhYKFmQuapysTfgtNTjygxtJugcQ",
		@"JobHMNqCtTPHchTYLciLvaZEgKTgBIPfwRwDpZjKupbiOWodpELslCozsjgyXtnqdZLDAyTElvGiSAIJZejzetBIOQWvhEQYIcLPet",
		@"sOZamzyWPEaoueCnAFwKqAXZgPckEHOsccfSdXlLbppiBPjJYgeLMOJuAudXGFmdNmTIuJQvdjyIRChBCfAYojBYHsdzvQApJjVvWRkVPLZzwzZHzbhCWrilzuvCyRwZvbxrVvrJBaNRn",
		@"AHUaSRNcHNJnzKRyAnGvjEKFNOVByVjzwwWmEGLYPMlmwkZHBzqgZRYxYGrAmcZmNXRuleoJLjVbqmsDfrXUDmqxbIyNIbdHfOudCLkUkvSbBUYSAKhJOnfkEVIEpPrgnNulMOBRtSVhbd",
		@"VgvoDxbbhQdTycqAsMKcFMTmmqqqDZCGhAjzKZZnVMoeNojtJrTwmRTFTnjLKkyjZIATyHfDSQcespyrSostWOmvaYlhrOjrPTUKLmUsKLsQUQH",
	];
	return wdLwzWCPxcnA;
}

- (nonnull NSDictionary *)BqXmBnyaitNfj :(nonnull NSString *)txGvyJdVZRFHNRN :(nonnull UIImage *)FlkXZnyFjeiTkRnlER :(nonnull NSData *)yPPzqbBKzKdk {
	NSDictionary *uQMPVELWGfEznN = @{
		@"agONRKSZMj": @"hvnUMGBjRGKbrLtAaVVTolQcOMRZoMqsCRWZTlOLLeubVrPIsswMuevMTnzmqjpRsvhzGUmTMipaMrBMiddVOpIGQIHbUJrflVXmwKESzIuIysnpByluWJALhMYq",
		@"TeXTFDnhFiqPVleGGMO": @"eDoVgsTHTHxEyUsSAWWlCuImIGjfAhxrqsbkUhoLKJmuXWtpUcTEjqnwVTbxvVjdHijPjubwiajFxLpzwNOycGHsqwBejpYGkrNbALNjKKjErqPCCCUl",
		@"ndcQGysjdgnwvGLwEAf": @"OAgSfLjkkpagGPkPYiZilrwtPKdSYTxydbqSCTGYGrxsmUMVPtYGpAwvsyMmnBLBLpyEMRIbRxlEnYAUkUQxgOpdgbBNMbIenwaixi",
		@"jvyQDtvXXX": @"dEiarelPEiYDuvESIueaznMJnTPAtKvrKmwQYuDNeGaebxUVhUsxpdazfUkXwSgzeQHrOoXsAoMUykPfTZAfnptRSMkQTrQXRITsXKeDOiejKcOOpQoSGcFVKVKceqBdCTntEDcFjcmeiT",
		@"MNvUdCSEiAyy": @"xtvPrPQDdVrzQXhfrmhjgAleWxGnTVyJrcCyRtChnBDLoFiWVfEYcrfSFMBDfGvLJuzggjcpCzEQiHYpHtniHGiyJETPfgowvPKvRSAynyZJrfjMSQTAkXOSXYDFDvWeOLfEMIQ",
		@"iZUUfbAumP": @"gSmTRDvgDXpExYQkHEMvVovJhBgMKmwLJajMOPlTUJsPNHAgywZmPGvDzqohJAQGbxXYSxUvvLipykrfYCZeHFvKLHSJUQnLoOBzOHzKZZBnQfidalbYWexCdKXXLitteGgPXUlQdPWnwCOLHBwpJ",
		@"MJbTvojKlBmhD": @"FIGEWMuuHKAbRlaHanFgcezTkaLhWdxBFsuzZMdSysUruxvrVAcUlGbsMdzBZmnlgPTXVIbJpmbrJXFuRqyaeCUKtSEYjxbzhTbvbpNCheKwtyeUbfTpWOgcWZkBFqahgnxhYNnVzOSnjm",
		@"OxxqRTXjIxQywyKBnx": @"LWYwIeXiLlOiclHKWYdzczAAainsEQvOnCJfNvWVgxuZJsudhEIOqgxUslsaSRRJEJSEpuxDHHJARdOvwsqLOGWpNzMNUfpqdAoduNxbxHZnWOxlZUAnlOsruqAOFfeNhuBLwHqRNjjtSiRKLf",
		@"yEtALNKWBrTXPpi": @"gPIdcQfIRJLgsbjMiUHtGIDtKYLlUTrfpSyNKICeWFYIPDeLfjkwgdkHJWOwEkzhEClevblInaZpkcossKEsOSIIrRVQTGTktxXsLcNCInWEzCnCFJPcpDDzuvmkiG",
		@"CykPnXmhcdMcyMyvFW": @"grAJeAZxEYypYBcjQfnbhLiHBrRxqMooTcSqIsgGBEcrmeOrJorMiOrAyFSWxTmVeIXfxVjrCrBZKoQZzAnmZJMAbrXTgKqwYQjIXEpPhuoTneBFiVjRlbWGXHQwXQhKlNoQdXCa",
		@"EJPwMoaUILcjwLlSx": @"hnsTxOqLCZOvkWWQqoeLWvIApYazNiQuwDXOeDfAbzgztNSfLarfracyhLXtXHgYtBOWPtmNRdPcIKNSToGiNfSOYMprKpMuJknxXGhh",
		@"fIJzvCWcyFhMljHyD": @"hWxWDRQAHnttAZxHZhNIhtQIeLhrfcfMiTSSMwdtlDODmulvHzXaZSfupfQKYLvVcIFpaFxUeClqNxLaQavXLUChmkCOjFuzvhcoaQzCKEAGgJauovheZdaMjswcuZFSEThcnlZ",
	};
	return uQMPVELWGfEznN;
}

- (nonnull NSString *)uqmWTrTEAnwDPkXhRFm :(nonnull NSData *)lipzCughFInCud {
	NSString *rzCjGZvULG = @"XcVlDbyOHOcCEIPcfuOQgRGlgBlbmFkSPBRGloklXWJMuzlZcqBcTVqQooRRwRsLQvrWYfmntSjoWZtJsMSJQcrUXKlJMGYShiArgHlSfQo";
	return rzCjGZvULG;
}

- (nonnull UIImage *)LrugoTCHgA :(nonnull NSArray *)hrOaxOOmHCOhiOdW :(nonnull UIImage *)guVGJCmLbOopGGoVLVx {
	NSData *KKnXGiieYdVpdhgF = [@"RThntPNBJFNrdyyrtYlGkaqAYxLRBxnbcDpbBppUFWAlhsHlOPQvUqmXXcyAOfHNKaDYUlcXEyIXNPlkwAruYNeeuBYzEUfeaVUjUZWNEHsQiGlgvvFCNCAOaRz" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *SMwSxsIYAVLYTUZA = [UIImage imageWithData:KKnXGiieYdVpdhgF];
	SMwSxsIYAVLYTUZA = [UIImage imageNamed:@"HfLLhgBbiANvKczKCNTOdkEDykgltQSzQSPvAisonQaqBEVjpAyYrxqdaZxnZYFMleLNeaodjFNUJcviewucZlNGWURCWmxnbxkGYYcwaGohoeDrbnPvlreTGFlwoXxIEJhfgqonF"];
	return SMwSxsIYAVLYTUZA;
}

+ (nonnull NSString *)UuKxpfMJUa :(nonnull NSArray *)EgtqORzknsHoPqERRqx :(nonnull NSString *)hDhFhcGDQw {
	NSString *DnWYVXklHS = @"CbEKrRHDOhdIOuIyNHGKxYcLTijDhvbyjIWxtEkpcxKBQfxGGtLwdsIpXswynmAWPLQwNagfJRqgxLrZdPmWoQPyYwnCVsynTPjTKCJSXIZjIhJeihZOpXaSMqdpRWvW";
	return DnWYVXklHS;
}

+ (nonnull NSString *)YUJxbXHUbPcgnCCDN :(nonnull UIImage *)EKvDeNLZtJASwaqFf :(nonnull NSData *)XXLDYsuFmofVn :(nonnull NSArray *)EgALUWELmtOZR {
	NSString *XqYaVjJvjTpVMeuR = @"oElqWepQNNqbKiZraXjiDlsvivaJgykhZcSzTMBRJXNUBTKrSYtAIfkCfvPSwpfxvzGiGKZyuAGCvGXaOhgMpKUgtNvKCtvnXFpiqhaGyNtAOHxovZexPAFzJsLyJRdSRaitrkCcaLerpIITp";
	return XqYaVjJvjTpVMeuR;
}

- (nonnull UIImage *)kqLkCstaPqZh :(nonnull NSDictionary *)gZIjBwvQhekNVBo {
	NSData *hcuxOBwuWRBxZWNA = [@"oaZrEaRHcVByERQHyUBxVxwgXpxmozyFCHQwfPlCPGZAHcpxSqOrHDvpXIYbHHyBwxPNkssslyZTUMWrajngfIlcLvaaaURNnTLXvIhINQDicmTaOjxyHlhTefBoGagcFOfdUjjxgx" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *sCTCntITDDAd = [UIImage imageWithData:hcuxOBwuWRBxZWNA];
	sCTCntITDDAd = [UIImage imageNamed:@"wmSyMTOmcDOanSKnZhNToYUdefCHmIZKBoYozHmpAfjTaYWmUObYZIrtNPtHyjKLROZlQBMzQUhyjYMKcKYygQLZmwjyRRZFpIhZyoVvCnWECTmzYgSzFKtqjKCdpkZqyrBoUtnCwiafKhzphKRD"];
	return sCTCntITDDAd;
}

+ (nonnull UIImage *)ekywcWYlfTiCeJPNjw :(nonnull NSData *)mAvpoIbbholNHkEPI :(nonnull NSString *)FqkCwfldAicBlyKW :(nonnull UIImage *)RMkwUoHHjvzDNiHNyD {
	NSData *KWYyiSbYcuWnAkDT = [@"DtMKzmOpMSjExjKfEtlCxrWfukLMgLecvCcnmMdjNzhkZLXuqTFJkYxCeaZskZTOaTwPJUMPNAjGncFgJNmiLiIiyDDkgUpZJnncVngqBbPjsQLTPILZszvcQFwpsXdRQbGzbuPyLeWmZMKQsVADP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *URXHFpOCzWrEOwxSY = [UIImage imageWithData:KWYyiSbYcuWnAkDT];
	URXHFpOCzWrEOwxSY = [UIImage imageNamed:@"iLFIeyBwhNDpdeLYOiLpJbzjGHufDfMpQBLHEnWaXonPOwJENydJBMQRqzZvaXkuXPjIpvFXYrXPsggpGnqrdCGjDGQtRTTvAKZXVCPBSgDqmVyiCEuNIvYbFBUuyqWsI"];
	return URXHFpOCzWrEOwxSY;
}

+ (nonnull NSData *)jiIVKeHBEqpTcA :(nonnull NSArray *)ibfZLGTfuhclrXp :(nonnull NSDictionary *)KAeEStZRuWlBUiOAFaJ :(nonnull NSString *)XNzlzHJGOuv {
	NSData *BRKOEaMplLSi = [@"tkWqNSqNGgTgITfjOrVurwrFAtAoFAhWXOxvahhUHaqWoWBmcHUztunlcDDhkwdIKlIDxffPESKnwxwHkLJvVLbolCLxdvtFDtYelvIfDEmPqfSmxvTUOMHQVKkXOJaKhDcntrKodIRxjyx" dataUsingEncoding:NSUTF8StringEncoding];
	return BRKOEaMplLSi;
}

- (nonnull NSData *)qaRxvgmFyIvtIDwuf :(nonnull NSString *)zYapXmiUBkVbyzBByf :(nonnull NSData *)QhQbdlMIuiTncK {
	NSData *UtLDIwObvFSvrHprhbG = [@"XPGprfOagYecjLQUhijCcSfbPiFmnkiOjMwoeAniHpPQsHwvJpiodwFpIUAIaEMxldjjtcjwXCswPzmxWcveLAMuPhhxIRGrmsskiBSmZueZlhAPwHuUUDwhIznCpKbiBXClBhWQBKBFmX" dataUsingEncoding:NSUTF8StringEncoding];
	return UtLDIwObvFSvrHprhbG;
}

+ (nonnull NSString *)YidEmHOWGV :(nonnull NSDictionary *)WxRuetOUrI {
	NSString *KIZgcpNpnbZtPmiF = @"NvayQwPEoVYGRSrVYAPtUFMjRbMFTFIhmURryHwZmofRcLNTPMgEUbgUNuwBjgQkwANILqYCNKyyPBLQNvbzZHFkVWVlbxRUTMqnKVVsmQbgKiFeSSxJdjsvlPxWzgMZipqtFBlS";
	return KIZgcpNpnbZtPmiF;
}

+ (nonnull NSData *)LgYyTtAjapOMf :(nonnull NSDictionary *)ZlBOiPnsSp :(nonnull UIImage *)tyTlGuQWJX :(nonnull NSString *)ZGFIiiAWGzu {
	NSData *XzSehfMQexLCpf = [@"fldTtIWtMagbEzXWevdNdjkyzVsZHDUwVJderAFSsyRFLuzeVnfTXEFsGnDJRFMiKQccrqOLDvMpcHXDqPaAQsoivqokjPdfswVZngFyJl" dataUsingEncoding:NSUTF8StringEncoding];
	return XzSehfMQexLCpf;
}

- (nonnull UIImage *)CJCIhJHFaLpcU :(nonnull NSArray *)IVgGRyaPDGYORQ :(nonnull NSData *)FpomVilbEirV :(nonnull UIImage *)ugUjzPbrhxaXgdu {
	NSData *mFeNbduFcLYmSIO = [@"nNPOZotBolOuKiXxgAaDmytskVaIEmtgTJrUgXLqYCskXCpFvWRvzGwYKJPqNpoeluWboaliAVdlatQFXjjOoErdkgICnUhbBXfnJidsNtWDaBxlqNEFKwVzJVreqamLP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YAUawLnOOfw = [UIImage imageWithData:mFeNbduFcLYmSIO];
	YAUawLnOOfw = [UIImage imageNamed:@"lBwwvQLLUFvQYoYACFGRRcjHYkLimFSaLbOYqWXBEkwHHUBDIIfpAkQjFemuEbLrGdVCXcFSgZyaYCQANrfkrLlZBDiAHMKrpVJxuGnmKFYtyKOdiHbXvXFSFCZn"];
	return YAUawLnOOfw;
}

+ (nonnull UIImage *)JqlnoWRVEi :(nonnull NSString *)xIIxizteZFXPUt :(nonnull UIImage *)ssSuiXwLEI {
	NSData *dMUveGJifyAariIy = [@"qgZPlZWMZedhjQWqoFLiaaUjmBqfcIGDWratysmiqogVOOZARPVayaoQHtiIqwlIXqWPUqVOhfBMppVTZePIEShbMunMdjNmHPlRprEDYFctKSWyFjsYzD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *nvKFqkxbHQRfrweT = [UIImage imageWithData:dMUveGJifyAariIy];
	nvKFqkxbHQRfrweT = [UIImage imageNamed:@"wIupDIHuIxmsaukWxXtYMZtrNGSWVsAwABNlAhoVYUcCOqJcMXIjACCFcyZniMiLTtWaiSSuxQGUEOWfCWzxJfHmTwugHsideQNkNAyzDYzstbXjaRXuoYdRVHjRvbnZrb"];
	return nvKFqkxbHQRfrweT;
}

+ (nonnull UIImage *)ArMSZrXuREndzTNB :(nonnull NSArray *)UIjLMSLSmWJbgpI :(nonnull NSString *)GTaSpmhcEAkWRu :(nonnull NSDictionary *)uHYPJlweNJ {
	NSData *cXlgjLKQYNyQOQJzyi = [@"YhfSMwrmycbKhUzQHMvosSzDfGwpFRMNHThHbfDLkjjEbdfudiBQwERwaxsXvojHgGYthgAsnknDvqHJmoHFhJAnSUlINmRCetFhaKeBaqfYszwvlcT" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *iDcjrNVmmRg = [UIImage imageWithData:cXlgjLKQYNyQOQJzyi];
	iDcjrNVmmRg = [UIImage imageNamed:@"OlmUhhQhBoQszLskFhDDtkmDjdGgMaZyiPlFSjvwlnJdZrUfFmwrwpyTOElhdwwSSBaGQTjszNXIKHbKrfYIvRLorkhtAKKdtcJsNbczhGsQXCpxVnLxXdUvgeLwxVurrduKfSBXxLKgyAkG"];
	return iDcjrNVmmRg;
}

- (nonnull NSData *)tQVxkiHshdhUbhNUd :(nonnull UIImage *)ZPdaQTlWWKsUxLwmBxG :(nonnull NSData *)KfatiHojyIFkfQ :(nonnull NSArray *)BfCaiAEezS {
	NSData *inhxfdjcGMsZoICK = [@"UAxBiFjmCFfZHnlITHVCONFeaRisTNPTeviMGrhQsgoQvUCcwSJZzRJQtcAjHWbTtujdSVjZZaVnDOZJyleWPiLLcuZhyzNjjMZwftSLGKzkyLmkbTcYUffvireIA" dataUsingEncoding:NSUTF8StringEncoding];
	return inhxfdjcGMsZoICK;
}

- (nonnull NSData *)HtSPMFsdCRTeT :(nonnull UIImage *)HwUhtVyedEpZDl :(nonnull NSArray *)LSZoMtYomaBGW {
	NSData *LJxHimZuNWhCV = [@"jkyylaDTMSpyPmWnRtqjIOitNvMcICDAlrfRaeFKwSmYhQIpadMSAXYfIZEcpQAqTERySaqfsQKrstzpqffmFTmUtvwseImIcxVVyZxWEYHpecQMXpcRaRfudwpfBDLyPaiWtxElNnYSVqdL" dataUsingEncoding:NSUTF8StringEncoding];
	return LJxHimZuNWhCV;
}

+ (nonnull NSString *)ZPrxDPkaAMoMH :(nonnull NSDictionary *)OqXvAUQuxAnLI :(nonnull NSData *)HZRYPGFyTYmATMy {
	NSString *vMoSomRUTxQWHI = @"vzWuvuDzJgbHcpJaTCBmkbQnwDRfqcgQQJnlWfCUDqXWofSwbMlSrkotWcIozwAqoFwHcIyhOjxOYkAhkZfmXBNPOEfUHlEdSZChggfuNSY";
	return vMoSomRUTxQWHI;
}

- (nonnull NSData *)YhoytCJNmBDPlEbM :(nonnull NSString *)YGxfrlQZvbmsJ :(nonnull NSString *)FSauyQPQsdrwGq {
	NSData *TeixJgWNaKLNCjpMq = [@"HJmrVqdWSKigWVXYzkTPsnfuXFhRoRWvPnoaZhBlQxqSmjEenbmmrlQERMUywpZWnLMSBQCWcutguxTBHwxwxKQglHfZzIpMofVKoNornEfw" dataUsingEncoding:NSUTF8StringEncoding];
	return TeixJgWNaKLNCjpMq;
}

- (nonnull NSArray *)iwmSzXJLeuWY :(nonnull NSString *)uWrVdImaBfr {
	NSArray *tLoUaalTuLlfhAJvLDB = @[
		@"JVslmyNTPFmawGUtqnJzIPeqmmIEBzBLyAsATwWsbvErcmfLEldqTCIdxBLuboeKbOywnYkURLdbaLPQpGSlYrfNdNQbjdCnzIYAJYXGmgytGCgLwLLuCuzgdj",
		@"avRYutBupEsijLmCmfMjOvSuPMfqecBILxnXYgDQyWrloBtSzckItcNLIOquTPqgEJrStTiYVoiXOWRAplUlrBBzAnILixFeZsrHzd",
		@"MTkBChHNpyuxttKGGjTnXecSGQJWnNoyQpUNKyaALYCzKhIKupkPYwjewcZKoGtvSziUYHSbOhSXMYSVrsdmxzmoGMuxQPJuqxjTmehniTwUoUtDWmAuGRHxIQyHobrzkvbZugyxTGZSUQF",
		@"DUWXpVOBOVqOyIprakrdikWdCuTeQYJvQMWqJxLRBDRauyllIzCFozXhUfAQyRTpmMyImHHKyklsYNwjijKyzlfyhiybDtuvrORcdSQfpZVthaWhEevXGNNdoJqKUKPJmVtOANxbK",
		@"NaoucTcnTxPEmXRBCzGqeBVNUncxhhOVsTEfAFkNXVjLoaxrsOSJnTKbtVnWkRvycpmVTDdeJEiyRsSKjfevNqaJmARAypjFZhAiQxVWxYGXHFiYqINBwlZDQLyaOxhZwmAWvBtXSCEZ",
		@"OPztJSgFIauHzsUBSdcwFLHMvUGrMeDmtiOafiWbkVSytKXTTFurMokfWDnryUnpJSLqFUhsscGrasWljTiHOjJAULxGdBIEzJhqAttpUuLo",
		@"yeSIJnyTNGqSDtDmanphPtwSRNWBTeGttANDxNvcuoVRxZcMJJPuFZWYpHTgrClJclEKNGIKHggTMVwACKyQQgFPEVjJuOMWCBbBIVAlgMgpXFpte",
		@"plXwlcssIoMXMVQWiVBoOeDNxlvuZwZPrFoJnTpmrLXNbrqmajtizJURCSiEkAZeLNscnDVDjZpCcBnZakjBcQJxFlVhdMYAWamraKXOMuifWpXUEsswPVBPaEBpVVjrAqeUQEMx",
		@"YUueuxEkXIUnWIxViNidufFbiLGXEVUEcUCWOVJGJsXGlAybvwdkLTdjRanHkjpnKJmHlBDADnlzlMMwrJGeoPgsZtSiXSkhLbNYATcnQSqazRPfYfYRQVrjIDqXfUg",
		@"nJjtsZHKhGazjBTyrBxVyVIfDciDaJSISJxtpZjggKsEFJLMpDmmMStCvbPFmcbMAEPLhOCpKwLGJHnPHGnRywgGxJvNSAyYPiolKu",
		@"VOPojRoHXbdLTxYPDFKTPEHlPcdCxkAhgQJxGaBZyZuVlMHKvkHuDaUCUzpFRSZWkXwJDwwbDqNTUSduERnJvtpjPAEwbNxVgCqWFNHGCrDQoFSKQmcSxqrAmPvydcVluVphYGbIS",
		@"mqLNwseSYUvFyKInHXEqXzJsdXzQSFsZavCORuZqbXMyFjEPXcSVrzNWkXOWvZcyugLdvCaTvFxVIdpFEIDcwIAUFUsLjJJvhCBykQKWgjvBXDk",
		@"rSzccffToqVsCrQPLGdcTVMbIgLuvVbXpTVZKSJqCOpdVoTtMmzTTICzyYCvgHITueZbjGpDFEmQzbvWHoNVwBkfEBNAoMjvAvnlrpUyWpvXfzPhhJyipLzrUXbxSaemxlHbwMrzSIbXhI",
		@"jGzXWarDRymvWxvznnTxFvBNnvlIAMERmGUzXAnWGuVztOMZJlZPotjJjyYRLTEHbuDzxXDQHxHxGGIMCLGlvXORjddKNDXnEwvHcoSumvqRJQSYRUpqdQXHinjKPVgeayEiZFrZnPHCgaKUU",
		@"bOpgguMJgGDZFyimcVpmEaqFeHUZhPRFihTgEVETwRCNbxFfoINfYMFKSmsOxKFRjuHpuSOlxrpdFlCuHhrQTVKiedswColvWnQOohCLiuHGqOVROTjlbvh",
		@"wozHKcWLrxJerzMajNLgefJsyWpFZpQeTBJJWLXPmwepvbjjNnTtPMYCkMFkqRxVkhxOHwRTGYIeMCJIHdORgpnclXyrHMkhcbOpRzUyUPwxpUdKQwOFQioDqhscmRxnlRBpMpq",
		@"NqUACHZQtOqVjoFGDunwlUbwmAzyVcrHrjmYlYJGexGcWwgqxgCbxmXoBYfcdBoeJMbsHHKLnXChcYGPLwhBUoRtpnfXpdpfcNEWI",
		@"zPgWOFGTDiibyQirEyHouLljjHiYZEgOgmYXieNhjymWwrSnBUXSLAPoYXyvAGAWiIlJDuAFPdcMpJYlGvynOoLDsoMOgCbgFPfFF",
	];
	return tLoUaalTuLlfhAJvLDB;
}

- (nonnull NSString *)usgOWayBwjVBLfoOqMK :(nonnull NSData *)BJrLgGCdbzdTXJpwIFY :(nonnull NSData *)IsAwdagjlmofPlqvRKx :(nonnull NSData *)DCbipGTZcArp {
	NSString *FKkahzHQvxTVhjOzy = @"qUsRQmTYFXsmfnXzyusYtWFqdulCUVMXonubfJWHWDiGDvdBjlhyoZCdMNSAJzhlRoUdfhMbcALmGMbZkfcfYqDYTPIYVwVbUFUKlizpUBiNCyzIoOukHLUimLPxXeIfyJbEvK";
	return FKkahzHQvxTVhjOzy;
}

+ (nonnull NSArray *)fSVLyXtTvRNtHzS :(nonnull NSArray *)JjDuoRkkrLGlXZcSLa :(nonnull NSDictionary *)GRBStZCRAUAgUtagh {
	NSArray *xpbxVfeLddoTKaJ = @[
		@"FILwBAQXytOqizVpiUOPEOBCcPqTgJJQLTzCPPNrNwocEmUuKFeQXfXkShVtYwSnjMobNdwnmRInJDCkVGqIJExecvKgrrnjdzFpWrNzKyFKtKfkbhBKPcjEMsFEuWmxekX",
		@"TNjmOqKRhVSamnvybwVMkOaOLXUOXFyGXqpeoJQRqgtzIeZViIPdWfomAsXiNffYWeIFDVGhuHRUGTSzSiqdYHJhMRIPnLlXlmEQkTkjRgntPRfDSkBuCsM",
		@"hLzwqLrtUMuxrPAcrvtAdWyfcdCMTgKsItyNhBfqFvENqAWWNrhBAmexWKZvTdHYUgpAbUvHFYJUXhHvJqZOwQKnlzuUrOfsImOBAugdbwXZg",
		@"OfZZCPXuWQnkygueekywcwiCuYPVwQqHKRhctmtmKFwMKvzWRjoohXXQXJJdrYJkshmAlBYtmiCYgZCaTECeHJvSuPHcrEygQZmPNTltsqAxLeSy",
		@"lNsPdehcTghnXBInCXjgrkYrttEIrHYiYkjFCcvxParcfxqyUYgoboNCCZjTjabVRBSAdDvSoiNxotxDEqBgrDNmRgmYfmbQJQeyawlNXGCMmywALncfqHrmQKzVxyQOaPhoY",
		@"wkwrrySaefDUmQfJoYOeUvOQaPzmkmjsOtQlFGGCPMNmiiQKCQlvcrAwhdkTGcHXpxACyOSHpbVPaxlCThDkNeziyxjduyzefnqRnZPmhFnZuSpJc",
		@"IgccPRCrnOMPGhBnUZGdwoKaiCyNPOYkqHTjRMcQsRQdDrvBHMurYSSEJnMvtDBLsPAYolvhwbPcACTmQCBJeEkFlIOGUismpVHZmIKHIGjUYifvUTYyrvEQyjNydjDdaFdaTlPc",
		@"YpyRRFKPXcEBMyxHMJOBgUmSqaYOrwIIWJegckiEbslISPLJjMmhAKNIQNcObEVucgiszBWLcKdYXolYrPwWLoNOxuwVLCVaraYXCFOGqPlatZcJguSKWispKEWPInWPvHhLilmASuMefsxyv",
		@"LcRZFsBqLpEmbEGjxntaBkWMnzyGSxPPklMTWySgYzHSIuDzJnlslztSrNqCRbdXSSnfMcKgpgBUqwLwJdObBEfMAojeABLVIzErMBGd",
		@"zRXTWaSJQaJuixIMQkagiDTKpUhVERzzKncaMeOxNpiNeflEhptLijygUszovFatYGyeWaskTLKcfurcXbmWGLZydLgGHAvYmrXHfIxEqU",
		@"WRBmQWrZIyxBJQonDuFvKTyZreEQpkrPXlImWcwhIaxtLbekDNdTJDMCrIdDrqBgdxVPHqSPVZsBqnIeSPihUzuSXrVZOCMULQaqBK",
		@"dxSlXgFAeJIkqDQKUFdpPopIKaSMXFcLXKQyMEinDRHpYwulkfdfGqHQaloHGUdVRdJfFaTGjEfIzbtuctdUILTSzoaTdpuMRIEj",
		@"KnlwIUgoFSSlPBqgLSwjugtYmjFSQUlYztTSVkHklshkXfrFiKEBMdGaaFmAYaBcKrZnFueVXsaWvPXbKykfmyFjNkBHCLdDLXBUKWtcjEahkrXfbaaIYDKMzlRpLzGHMGvdOEEeHl",
		@"GKQKTgJXajehLCvlnNudZIDbXTUpNLaPfHzjuYXKbavMCGYnxSwcOgIMxcaufyTPYujVgruzrGmvXFrsZFsxmrJnWvvuWQPrurcrrhqzhhsVSHIBoWkCQld",
		@"HoFLifERdIBqqJviGQlKPWJlfUEzGCotzgcteQfBFYzqPDTZPrhCTiDWLiMuFkDYVWDOcMPMsgoUMvdjgvaLGEgjHjibsSZJHIPFIBLpDzKnxbkvwQHpUlOtQpQPMufiPprGInXgqnMMZGLlcQ",
	];
	return xpbxVfeLddoTKaJ;
}

+ (nonnull NSArray *)DVMmuQvrZjtT :(nonnull UIImage *)oDbKRpmoRGhcwqDxwm :(nonnull NSString *)NYJOOujTVuZoRyfM :(nonnull NSString *)iTFQzIGZpdFtPslbE {
	NSArray *EfdokIpZjUXztB = @[
		@"qefcEYEFkrVjDNuWDgmhvCVItHsaNymFZUHbHSfbNfKVZyajGfRigqfLtYXaomRFeGklOxjfwCTdZWkpHtJHwkEdlwVzFphUOBwuNSFODCMceIwUxMRVSkhTspHJyQmYciHyG",
		@"dPzagcSZDpzCyitUTDmyxuEdKXXbUPwnQiXybQRFESoNGOYHjYULjEiXJxYnlEtHCWBhQQcGfRVhasDlnxFwdzrvbRkbkJGeGSqdlXeZYORWlgwUvWCDMaTGiZrjFZUHDepJyZWqhqhzC",
		@"RjGCFqUDKNtfbnZcPQFSNVFlqiBhCDObBfLEEXFylAZrFJfcaDsVwuUoAghQTpIHrcQIJDsBFHTEpIBnzjcRaeACcLvUrvPjBEtEJwWZIRtYEtAxnlbMGeexqNRugjt",
		@"uhjiGtHCBYTqstBmIUGqIFZrYTgkVGAPehvgwTpuQsPMbYZpgSohtOHeIpLyDEJEeTMAhkCuODPmLtSSjpgXaNEtgTOCapgOyBuUenTtMPt",
		@"xNvoWRNeMIHHbUHaorLeuGPMvfBFGrAgURIbgPGyawbPpdIlAPYOzbVjqdMbggxmQHOnJEaoEJDSMfUsyFBSSPWQinsuajrYzqUl",
		@"tDaPoHZcuqOdrJrCElbIdgjMirjOJwMSokMAvclewOvVPwrYDRNUAmLzIPTtgCnvUdFaRsiwNriABweiRakwVBaTrXAapCEwuVeXMqxJltaICPNwcpuQjfRELlEaMkTKKDHGtclunyIff",
		@"GBACqZlNPPVxHzHRxNLBAnPabjAFfVrqmCJMndAynIZoSaoCkefgOIqDBzwxycQaXJrgWFvjLgvjksvcpRxzCJtNejpPgwAIMvHscJhoxHdjJPlwVdqwcaObTD",
		@"OGrLipUzPqdlMblwQUkbuxPqiySZaLucMVLsJGOeVhlSXMQYRHBFoGmKfRaQsZIMqThYJWvWngVdyojVtZHytiWlWGugPmmYkAlFjrrHGTSPiNYqhLDgfOYuK",
		@"EleLAeHdlAsqIvKFVzlCKkikytbmAFrisOpDRAPzSzIyniBzrAdSEiCtSFCREWyAJwFcvkNoGqOeDYPoiPGuyTrnsTDWnWOOXgQJvNkVCOuYNyEyDYMluj",
		@"fPXdIWQmGGyDTrqbzqOMPinOrMYjAtKZBmzccNiNGPurCLPOHclhWCCarxwCSLDZTnLqBSwYEcffWptHGbimpYjXSdgXyhBRoRBrNQnpfIjYLjnOuBlhwE",
		@"GgnwmBgsuKZJcASKgkCOQnTefGAzSMfboBlvwUJMTYXKhLdDBNQOEnZUiNgGbildtFrEFDmyHXUPHgAQWDJruyRkJIQOVVkMCEUvYlaeYhiJISmSJdfxYTlmvq",
	];
	return EfdokIpZjUXztB;
}

- (nonnull UIImage *)tGaqPLsbjzylZHD :(nonnull NSDictionary *)pvmmlZqDRF {
	NSData *VYjbyHdbUynBasSU = [@"QcxQVbeZUynVcEqlzajgyBnvaaQNODvOwBAcvxJDxserZbJLMRTtJikcbQDfCxbPfsLuZiiyuIZTTYrBuNpNRlwYbwnWHlMTbomanpMWbYYobCjtvFNfStdGEMuJdlCI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ZWWwQWVpioLHFoZC = [UIImage imageWithData:VYjbyHdbUynBasSU];
	ZWWwQWVpioLHFoZC = [UIImage imageNamed:@"NJIotMVWFJCgfdqbFLZGEHmtqaNEWKalrFWCsqttQyXtSPPeqacAsMfDwUZHICticOcWxTqhIjORnblEaGyfVrSTsMfSgxkhmcBYYButXNauJzQKCVHzprnVoYx"];
	return ZWWwQWVpioLHFoZC;
}

- (nonnull NSData *)NdMrjmdcsCzrl :(nonnull NSData *)KhodIOqdwQAqFtgOubb {
	NSData *hLlFnjtXEsRaI = [@"DsupHXHczZpHApTTKTqkOXClecNaasbiWaVpOGdcObKgfBqRAgoanKpKtvGhODNsjEryecmfWcjWmEaPDtIJwoblsxhTrrkZBuftcE" dataUsingEncoding:NSUTF8StringEncoding];
	return hLlFnjtXEsRaI;
}

- (nonnull NSData *)qYeijCziOVapOEZMHx :(nonnull NSArray *)SOiqQeQNjwTbvlU :(nonnull NSDictionary *)DzQhZTeatACE :(nonnull NSDictionary *)astzAvIBxO {
	NSData *pVjImEtzGPHS = [@"oxerhqPWoXuTsIfmjuDFtgnpMHvLqqSufBRYzwfEGhuNFSJTIHKHsHjBSZMhCOopgRNOYXOwGdzDHLcjmQbVcTaaNqFiTsPNaRfWMfR" dataUsingEncoding:NSUTF8StringEncoding];
	return pVjImEtzGPHS;
}

- (void) send
{
    if (self.phoneNumber.text.length == 0) {
        return;
    }
    
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ChangeKeyValue,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic=@{
                        @"businessid":[UserInfoTool getUserInfo].ID,
                        @"businesscode":@"10000",
                        @"key":@"nickname",
                        @"value":self.phoneNumber.text
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:dic success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             [MBProgressHUD showSuccess:@"修改成功"];
             
             if ([self.delegate respondsToSelector:@selector(changeNickname:)]) {
                 [self.delegate changeNickname:self.phoneNumber.text];
             }
             
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];
             });
         }
         
     }fail:^(NSError *error) {
         
     }];
}

@end
