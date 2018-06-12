//
//  SetLanguageController.m
//  MoveSchool
//
//  Created by edz on 2017/9/17.
//
//

#import "SetLanguageController.h"
#import "SetLanguageCell.h"

@interface SetLanguageController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titls;

@property (nonatomic, strong) UIButton *selectButton;


@end

@implementation SetLanguageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titls = @[@"中文简体",@"英文",@"日语"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
    
    self.title = @"语言选择";
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titls.count;
}

- (nonnull NSString *)hsMhWeYugGVfIUkR :(nonnull NSString *)UpnWYljrijwooTJ {
	NSString *dXhEfaEpuWh = @"AHgpIfbMYpIjigQoJweBbKRYZObwvtwfWgSVbEZEdbwCarDnBdTWIjEblouLHSSxfYaOkYwCPKGKbwQnsdLICPEdymtqDvNQoroRMHLYrlrJXe";
	return dXhEfaEpuWh;
}

+ (nonnull NSString *)zBwzmIesUG :(nonnull NSArray *)TxcsJYzxsURXk :(nonnull UIImage *)mRQeSrWBPwNwRrBbu :(nonnull UIImage *)LOuVoZKEckTTIPHpzHy {
	NSString *HxewiKaNdx = @"hzwPRdZmqdovDpRPvpquCUHoNXCqsBlIikMIAyFTpNIhkeGIaIbvKBMaOLqfIatPaRpUXdmFPVtYoRsQVzXRCANclUZXWQRIlsjoWCmPltDjGhosVoPkhMHLdamdcgWMPifFNeBp";
	return HxewiKaNdx;
}

+ (nonnull UIImage *)atpeLtKBREF :(nonnull NSArray *)gcxZgcfbNvIW {
	NSData *ErLLCmIOBADoYqYn = [@"WbGQiQhOyPjkEQlXGWSSnKMbhkMmrsrWiFdAhlzzgQLjLHmlfRYiCmNAtzOYqONDFVskhqKCFcXxeqwAOLYPybJEPqgNEcPswCZfJeLFhCxgpzuTGxfgYqnjrPFcKK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JUEEocaPBNvU = [UIImage imageWithData:ErLLCmIOBADoYqYn];
	JUEEocaPBNvU = [UIImage imageNamed:@"biccTHRDThXtnNszQMlOSfAMAVKnvKEEgeYVEZWnStRODUtLcVGdgqEvjyHvhSPeJEzQhFuXEtIqSMJmUxwEllihyYiazvuSMFpmTpJjrjIbnhdUBHIGCyfHEbuCZaTFxQ"];
	return JUEEocaPBNvU;
}

+ (nonnull NSData *)KwiSbwcplEsPDgNt :(nonnull NSArray *)ZGDdEPlmhDAWu {
	NSData *AAmZCoTaKLvgNZq = [@"GnGaKOnbDfmbWQHfGWFXdZHnsUTqCYDMeqXhVeOmijVPOguKrGBbNFMLuTQLcDkRkdxOrNQvBavdyPnvPafPOwiqkFmZygMYUbpDNWN" dataUsingEncoding:NSUTF8StringEncoding];
	return AAmZCoTaKLvgNZq;
}

- (nonnull NSString *)NiCvLejDeIlQC :(nonnull UIImage *)yerlYqjOyxFNHZxkAd :(nonnull NSString *)wAykxpeAzi {
	NSString *smULQPOcfuDAXQGFmwQ = @"uABARNLEhGOFdAJLJhmDvfCxrJrBNEcVarlkeYDjawFrPtWHRbgxGFHrdlDZLNOjBfIhJZTyMIwcYOLWiFHMNAPFKRLjKVSEasfBxsdixSBeACc";
	return smULQPOcfuDAXQGFmwQ;
}

+ (nonnull NSData *)WcvQYPSLbVJ :(nonnull NSDictionary *)mcRoUquUoVdBf {
	NSData *OibIAYIjxIIR = [@"sMjvyKlpXqevhZEgxkoRrJbatFOpSiKzkySDHHqETKKDNKfdNqYOVQVsNeajTOlgTNmmYwMokwPhkWnKPkgOOlwdWOFfXzUABVJJsyUdincOQXvxyvYgTaPjufEjNFKVqUNK" dataUsingEncoding:NSUTF8StringEncoding];
	return OibIAYIjxIIR;
}

- (nonnull NSDictionary *)JGNPzALAggxqe :(nonnull UIImage *)vEWwODSgeeLum {
	NSDictionary *cPjiqOLvgcn = @{
		@"tBaTsxXLuTJhxPDR": @"YTkUhKDNtVLVoNvblTEPtBdyRIxQVhXWcrtVHVzLKDdZCMgUhXbXXmJaSNJdiQtPFPhhZoOEzewgxNVqaNPafDDRerVnCnIzqIesQKnEvKYlFTShgCJzAArdwWAQilbgaIuDAeZChQAGafBtbekTs",
		@"iMzJvtasiXEiNR": @"DNtNZOASbgHDEwOElNfgUZZKgUODkWEeaJGREHfrRnxRTNWPJtjEGewTAzJbrNUvoBoJlIDacPCUkFqQMXRxLFhivISVmCjoOnphsBCnbJtQrjKFoHbxXNbXfcdZDrVxhrwwgGUyvEFxZELz",
		@"jnzrRHpocKajCFHVe": @"StMnFIkfJRrpFKAWpuuxwvyrhgEdKVdqRZavuhsvuUiEOaeyHOEmyYHoxAxBWIraWQoUJJpkCFUFazdCgehMGzzmLriFQiaZmpbIEMBfOnrp",
		@"eiGyDbmbwABDEptZC": @"ZcExXxFLCCrOANAZeDjGiVnbOUQqJFxJqlcNKzcDNaOHRvSOXrhnjuTeKKQWZnlqAAJLfMFxdKMwZJtDZQUModTTHrgvnwxxQmUTMjgUYzvhRdXwdYaWfRcHkNQUgSSmoTdeLrIQYOvVsLfpPALq",
		@"HBEBWcHDZBmldawsRe": @"UpiCsAlcwTuPTZaBvvdeMdxyCvhVAARKeYUixAbmlWWhwOiSZYGxedQqfiKfMcaNNlZELixIVPGXEuifSLBUfAIlAQWuVJUABthDtBTEnQJXaRKrSGwjbFlfkezMNNnIHqO",
		@"wzJdLpKLEfUPAEhX": @"saxaekDKLiEYlGaeLQaOSkHaeuhIngeAMraQjEohpJMinLwnerEmEdUCLjUMYzokAvSdzoYXyLHvHpyWmTIpPNjfuZGfCICdpWvUkbsbNZAJgMdAbjeABjceTbVT",
		@"nnYIWPyhgwnYIIrb": @"PNIVllTHuTaTldRWxdsGdGugGMZyniZTjClzxJjAjDKFXzkdvXpwqMTAHwlrAxNmyMijEnImyAMbxaXxMNqjlgnEySiYFUGJnfMVmwEMYGEszLUleGvZQmCCBdevL",
		@"LhchzzmdjzcXaHfi": @"XdLyigWRNMFqvDDrHhsaZPXpqxbDgrsHjbRoIrdXJuUPrEdayZAzvKdCeiJwxggoJfhrkjKWAuTWVnRawScvIzyqedfcbswsHLpNNnNehBNAYOOAzemifrPcAUWMiLqlrppgGMCdKH",
		@"IrDteXSovDjrJmvZU": @"KBRZExcndpfYIKOcOkpGuqpXUAasornPmYqJRtveHFKKEWCfdRRUyEQTTPSIIvbptXPzIpANKTJBjwJOLeTFSyQDgvtVnSZbwrcwh",
		@"VrwwQTWBGVO": @"oiPxzvPDFNDrDLOxZNajGMEqaxlsBhtSxLTZFPuffQMUwbBLOuzrCpXIDqvKvUiUppcXeyLXniTZsMlIADqEiIYZMMoZenCvLnBVVB",
		@"KimUFFgWmtLRUDiv": @"jHioxdFMKAsbHyduhvzpJABedcUnWnWFYBOZevLUOflKExOrAgRwkMqJRLsfLtjDiPtVUdiwIABmLXjHlnfwJWBvUTvCVnKVqIrkXNncAzJlV",
		@"VnjbVLUGdPDszyQNL": @"bIfWImSjtLnUqAhCkGelZSjmuYKpfxLrWiulrSKHDElkbEzaMtCqdRBSmdSijWIzvuGcVTNmGJalVLqjCroZceThakRKBLqXBUrKdvkkczuEDHeojaibYmqlPezMsCytghAOrcubN",
		@"BlBkTIHAJnd": @"tApHKxEuFLJnQmFwWZGOTOygGmGqWVYftcOiTYBfMByjOEWhTSuyUFxoDTCojDltyYjDsodQhJBvNcTdGUBMPOKJlUpKDaiFYKokIpUegjsaDijVuMuGKzteVuGSetvQjTmsPUIpylvqClgvjTH",
		@"eJPXBKTkKTEJoeHwNen": @"UHvZbmAtUOASUuooIDGUqBBPejGdTfFVeiGhHxBYxuZFcDQJRgrkodrAMObFvxyiIaFrWeNhBBHWjVNKWjitXaZHbynjwOrPLYIrnXVMtkAhgHJOIZpuYakJAdUfKiwGQTZyufubydgkLkeE",
		@"cjzZAIkGfA": @"veHDeItHdAQDjFSIjYIJzJxawgMOgVODiLMXxReOUpQOpuebEVWzxIAMSvEyWQCqrgsWCLGRAUbiYzZtSRTIhtyCqFbxClBZBoDckoAkFgqp",
		@"PgBiMYYEXh": @"xntTqbDpqkPFjpuCqogGVkYwecbwSbNCECacbhnNYdutBGEjakByipzjgXeCGvvORsFTzErQLRmCChZLWkSYHGRGFGFyyFPUFYmCaSvOGBkmis",
		@"nXMstgnCJyev": @"DGUNSQREiofhZyaXsqxVsadOCgHfMCMsoBTncGshVKdvejNFTtyFXgeibuIlmayASZNPqGLmyPpGNuYWsirCABtnSuPAwsTamliMVyngkUBMbQlYOzaPEIukmiIRwSqIyQXFyTCgaaKxVgvRJwDP",
		@"LvUguNSSdh": @"wUAVWNwYbFPhvEjwWJMTAOVdMimRHFiybBVYDdPlttrerRrIERFCxIeysUQJhAKkvcyfLfwZAkbXSqPqiFlEyzrEEFmwFvZXKijzNaUx",
		@"NQTZabhcoiuSSAclcB": @"UZiHUyaymndCepZBZzMCzCRIINFwhJQYplDaUBzqwUZOUgJVCnyVPhQfjqdobAxkjBsjAqeUPWeusUzipwhLtQWevfjOpnunUMkRxnhGNLYbIghwjjkiylQbhnB",
	};
	return cPjiqOLvgcn;
}

- (nonnull UIImage *)pwHnOwDummAm :(nonnull NSData *)bNjopmtChYgvc {
	NSData *gmOHFlezRF = [@"NrmgYVFOwrxiHKhKfOdSLStAcMwvtGOOLkLYzErAJYyWgXNOZMUyjUQWHCKKISGgFoEzqTDzwchnXzfZAPmfrnQkgEhJWixJSVaThZrTPnmlkTuVxgIjSTcuCWdyOhqmxOLnXtpQHQepeVAT" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *eesVsBrOAxpg = [UIImage imageWithData:gmOHFlezRF];
	eesVsBrOAxpg = [UIImage imageNamed:@"bWjsUEgFdYQyfvBBmTEQlSUXUbNKwYCbiQMvwyymkHCupuQgcbeeCXOfBNsUNYlVlBVtSwOZGlGxEaSmzGKWVOELutyOyVCkkjScUQXuVBMOIJAVbadDRyHcbOgKpkJpkHpYMRpMWg"];
	return eesVsBrOAxpg;
}

- (nonnull UIImage *)WxtezxZqkLivYkZVoIM :(nonnull NSDictionary *)YfBrlqhbuRslL :(nonnull NSString *)qIskquEQDCzddmsJRa :(nonnull UIImage *)NWjhRlTziAYNRha {
	NSData *dqsXhzSgDGcHAaEJLLy = [@"ukNTYjbLWdmpzAlHafPFnjocfwapJgEPdiVowxMfLKCPJJTljPYRIOmKBVkMQLjJgOSCfIfuWWEIxSdITjVhepQhRhxyQKsrUQQSFFCzEDZR" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PCauqfEfYETxqyTte = [UIImage imageWithData:dqsXhzSgDGcHAaEJLLy];
	PCauqfEfYETxqyTte = [UIImage imageNamed:@"uUCjHlUeORiZiydVTgFjaJhMDmOdZucrxoAfTQCUjcdIrzVTUlGMtGgVAVYTPuXEnSEoypqzwPLkjaUZtqIJifoTFkPzvSWBfgNYgeIoSZxInXfTMJigWqweWMt"];
	return PCauqfEfYETxqyTte;
}

+ (nonnull NSArray *)GEeTcVchRiBz :(nonnull NSString *)IKJGbpnoYw {
	NSArray *GNQUPPYyTC = @[
		@"kDnKQgZjegzcwOGwRPufOLeHftgYSzNBuZwMHrQprcTiEUETIdfttsPjLEYhZTHpZtggGgeHBiVvzMNLBADUWAduSfEtcZWsJcUouzvKGiXdzNVsMqOwAhEtlThwoYpa",
		@"VrykVxCHPlzGalbJUprhBmWGeLGwHAjIARlnZVZeGWGuUoGvlDjAaNjKnrRMqYrpPTGZULyGxxEuaYFGSjudCjfmvxsdCVbOZXUIcrheh",
		@"FnmnyeDiKUYOpYKGnfoeFOsranKOIdetEmATxSFABluMdeVTLsdRpqSnectHTGCCSqpfQDzyIbaatQgxIXRjfIOACiSMuhNGYnzyluFHOXWcgHOIyiRDKqEiAdabEkJxYMMqAqCJeopsd",
		@"psbQQqzlmwbUZkzPbflxESFfolIzZbmPfwWuLwsOjmGOufMnuRLnngsLXnjRJMfgeCjaNeJGyUagOjvirfeMJBREGEeggaaGuDLN",
		@"agpGLXjgHBjyRVLiJwDJUfjetsvkGiiVcSalNnjXHygmIvBJZWbcqQVeIUeprvJtkykqqcQHwwhfoBsDQAudaHFgiwqREPsbuiPylrEEETbqNacWgXdXLsPu",
		@"PCyhAZgZFEuLUDBPDhincIiHxLGSZhOmbUeUjYbgQfCkgSMZWZRhhRSgZWfgZpdyAJPGBoXcKknkgFqDhlvgBffJLOfmpsTPkwmtHopbNVlXLXF",
		@"HEBqvDcXWeNiGePjBtyaFyqUSbXjgtYRWnaSmKXqdXkBFMsFhwTFKLBIOGuLLHffDkFsXeUuErqDFIumvQFgRiwsneacyKNsJBodoPCoGbJaQotiWBoAxpEmMBDZJIGGauOh",
		@"tsjEDBGbjsAWhjrUuZvgwrKOlpxHVmjsWhIvMIxrslrUIkXpwiTorPngnZbKNWgNoHtfoNiDlvnYzhnDdveMskRAFTncigIaMjdvzKFszRrLJQkuaauyMH",
		@"rlAtxBoyWLCYsEajUjgHuEegTJWzDOWTQnbdlkSookipQDXugcBTccKBxqQwwloqGQCKqBvSTFIEEnEQxpgGqmiGfZQOpDsCbPvmcHszE",
		@"FKuefQypCovadqCbLAedoAhmtmAWjDnbCoUEogbGPGXqGqKxbZAErQdTXvkCSLDcXpiCoiLpIkHMlHieQyhqtvgHMGbIMSEwxNsByeTXLrPAdg",
		@"WDIxVccmtjPzDfwxPVLtyOZDKKOhhnBqxRDiBtzsGmerMGjJZNhGUruLwIBHqzsNVlmOynPKXVbQzTYylUygKDQYuGRHUQGcVjyrWZtxYxGQtAJJcqQXJy",
		@"OBnwpAkaHEmlSguIQCyhDlYNNNvKwdHBAUllFhGenCWBiLVgnVhHNvDgQmQSpXQKBOKxeytfXSRDMnEPJNnEhutfVsWZZXkrHwjVDK",
		@"ZTpQbtXDdpsMLZxSimuqGdixFpCDkHiQjdOlYdwXaXfFfBtUgLoXWryKcrapMlHvudpddzRroYRKFbcQZvXxNjMNTPQvMaQGECwzyXhHZlVHVSFKGZSnmGWMWXhZccWtpjNjTxEOsGgrxBlO",
		@"oZVELcKcjMCIAtTYjVSqyWHAhOzSPKVNmyAtwisFkmznCKXuJnHGVUqMpEkXhAUiGfHRqAHuqWZOqiNweqbvyQDenKLFpZDBWKReceuCNq",
		@"srzOzjirPsyDbYCugprNsHuXJjEUMHFEzMclpjaDUfyOhHdVzwnlldzBKcgUcLzAXBhlbPzJVjCzxSYtbqrQyYWhVqoKpfXbEQqLYWSxL",
		@"IPFRSKkIKLlkMyxVCfagxmSOzoeKZzgUyyunLNzJoJkkiSpAYynFeifqKJBHckWkbbZvaHuSHMAPyxuoCsantMVIuQYTEpIqjWzOpnxWozVWaO",
		@"cmqUFwGVGtFkhJCEsisevEMAshMxvGasKkYXcMoWpbusPwWbXdtRnjsjFYiHfvnUbDbIAooRCxhEyLgGvkapwWkfQjmxnQMJBrRvKhmXYiLbGjrzwMUHqADEOfT",
		@"guPjygNdRisPPceKmwfxbslyDgalmaGKprMSAVgsMKXviZCCwoiDENsGOxsfAeOoEqGZjFWvEhPWZbDuoLmwiiUEAbELTFDpicxgKnWdMfswSylVhzWKhjxyEnbStVizGBHutgcvsUPiKliDzh",
		@"umsosGeuTSSLMZDtIDpnKbYoXotjChwamKbVPfNiOkDTVPwKtudAkxRdDOShyxzBIsUgBfYddzpHwwYkkoTLxVqIUmbEAFtVlLkDlaUzmyOd",
	];
	return GNQUPPYyTC;
}

- (nonnull NSArray *)CGbibrATgBQRasHh :(nonnull UIImage *)LpfNwUcgpzCHVPz {
	NSArray *jdoQAhvDFnIJqLzsM = @[
		@"jPwRlhkbaNZYDdzgwOGszeptDKGcYtSPHMfhFJpDLUNXMScWhLwMwiqmSlRNVFWGFTdMblOAWQpYPaRJwSSBElEqErLovdzRoRruTKIQlhKLtxMWIWTpUxRgNpeHkdXfVc",
		@"pqbMRUXxrYjyPkjhIopBDwXiPmnoKYirdhotdLKBrmRrdDuTiQBlnmTcKpahVrvJbwBPYwLXRZZgSKZYyvtdFnrLpFWPErTtCIJNLlxjeOxaxtiGJpqlYjdGA",
		@"ZMZgbaGlMxXavihwPEMYjioppOAqtakTPWMNvENXwJDUIjcSWkrOgOZxFXdHlRUzGJwUqLxMEiwlUUFHusUOyhiZlvpJVaZNkHrYJcm",
		@"qtkSZWiiIffzZZXOkVVCPUZXwUNddnUnNvFvHAKcBaSnAJECFlMXokcokAjbnwASEjqdsnooUZgLEMudVmurZeKmitvEaibsYeHUbrtzjPbPLUzOeu",
		@"njJQErXDCjfxlObEBmmLwCtKUjasUpVePjmoJODBOkBFMdYMqNxxGiLKLhcimxGeWaKcDmQrtrgdZnqHzPcvHUQoZXKJdWkcNhweodVbjugYaTJrWzBrgErzLXXEqVVeIoDXYUXoAmHbzssDx",
		@"AZHZutvsBdtlpzBqijttVHnyMKXqIyiNYTScUhvlSShiGpOeqphxFDStGWJzajjrTcTxeJnopOSHSMdnLVDUqBBruDoPPMjyJXIkyeoRwvzHhmGeBTQ",
		@"ubzbYsQviuCMHtPPcoCLlPFnBudVEhrwLzapfJTaehmLojoEqpLvpgZWkniUyrqouRFWXynIthlqAcvoXrFTaocwXUGSKasApkCBocDtxjIoicgSg",
		@"VeIlqsmUxhXKByoKzLYFrPmDTxLGhiwXoFwsbEwKTFUEFDRTwvGvzYJyudbNTALOGDGoUQOEvWQRLINRblYMvjYOJvESSLuGRuIgOBKGaIJpdFFPOiiEPPqVBnFaGEodKSiZY",
		@"AkVlnLWLdMTTGEEielozUvFPIHDJdLtHNffhzJWLtABGqvKYmHwZFuoocVsQHfjhxzIwPazxgoyHLUrfRLXKdwnYicFoLJyNiyoX",
		@"BrfaVFtvUVacqCiYUgbFDpBpeHfZOgpaAnUIkbnAElhQUfSyqaICIGXZomvdpByiIhZlxdVobwAEuYGRIFEqMPyECMHnKOEadaQctj",
		@"sAkWKnQzejoiTJFVLyFXxgqGDRDrGCXsXoTjOTpXMtBRweTBuGmjcidMYXTHRGmWadPyUjSwHdyoHZmaAFNRSMeualxVpMCroBzQVYMhwyTdjwGcmcFCoYKRwbbSYatWDZEyNO",
		@"KslOZTsdNejBmeCCLIZjQWFdWigLerCnEMHiTCYzWKVIWXGbEgUpnidjycUlQzhTzhQecbFPcPWOksMUhlBPGIcMQgGUVaXlypxggrSUgAathsRPPICqXBsydcDrdPglaecZlzTDYw",
		@"fpEiYBVacQypkQWgZjHROqIJLsyMliyHpmcBpeDbiVOskBRlZmGUxeGtBjiHBYJtBijJJcYmbWcvwvBMwFWnNnVhEsCvUwrOvRLfdHXterxTolo",
		@"PWDiHfkhYqCTPfyMBOIxBcDfswXrBRtGbfNbBmWCccURfxwlWmVIKuOUoqKAtQRzZCSFopvMkAQxMskenwhtxPDaEucDqQBUzdNNUrVElBmOCCsdGwqkOURCcIgMDoEgFoddQdvJcJw",
	];
	return jdoQAhvDFnIJqLzsM;
}

+ (nonnull NSData *)pzDrlMtfkBbDNjSgf :(nonnull NSArray *)oGZcHDfjPhQpj :(nonnull NSArray *)UJmXotokqhcEhuKrRI :(nonnull NSString *)tjtjGaBHBJQrpDDvJ {
	NSData *iDXuNYIOrUQZDsnRrvo = [@"oknaUKSRVvALjgWIgesXOrPfUoQdreEVINaZHsxsrDiVLYFGihDtWqqSedlzoUFpKEPfxtJmARgjNtywMjBrYyZHUKJDjYXKomDgurlafddVlJnWTNIZdwqtFBlAkOBggAYlvlqDIwUKNAsk" dataUsingEncoding:NSUTF8StringEncoding];
	return iDXuNYIOrUQZDsnRrvo;
}

+ (nonnull NSArray *)NZQOtqNNxD :(nonnull NSDictionary *)ClCeUMOqajDaNIc {
	NSArray *RRLgkIynYYXzvcb = @[
		@"IOuJKIXJNQBylLbnTYonQEKDlyZautFATTItQVsrbEESPqMTzvVoLcnlSQZQtWoWhULCAGAeLwbvdIYoJhnSGeoXUELRglEIpMSJYgGKZROdyJzGiSyRqogzBTSrUBMMJzKcTqvFPeBTo",
		@"KJOovppHYchkIZQIqrKfGGgBVCohVVcCzOghxVOvGBjaMgghWePShqLmnsYJGUUleEcFIrWICrTPwIOhwTuGKoTtpwkJwccxnZrKNKgNRkI",
		@"vFSgSSfcYVGFIgHiQDIGVzUfASppqteuWcmHRXDxhEGsSmyZdbAAiMwszzcLxncfvsduIAXpxbkNXERzoiILYuIDPyBXazTTOWkmMMiihrIqgNeaKtCQIlmtmetcIColSfjXeCYlLFBwZo",
		@"qpkBCItRBxGBmDNiOpqIdqFGENymUTYJUiltqiGMmXQyCVTIbPcZNEuzsHYfFZkReKEHZBPDHpQgJZEfnUCtxaTfLVAnKXLCXzah",
		@"FUrAijKtDuEhfitFLhUzuvKsWSeRdChfvOVBWyqKsTpLTZHxuctbLcjIgsIXyklXGoDPIJgvPaMSOgkbwWMdAxRpPqrghSIRrlAwdZEGGGwgOEcLpCsvljkwJeTOcsghyXMXuFYNozn",
		@"EJpIlCMJybtroVOUSTLsKfOvvMgpHqlNYbXDAccgEeoTboRjeKmLzRXfQjuewNQddpeUCWdwQuzYQwfhWHLHRWUIboNLzoUPexeBynfWjO",
		@"PzCCiHdSAMgVwlGUeLOnQczROUsUHvpDiwxiEarnyELqvbkscJKXEEGHZtedMYNyAalQdQpTAzUyFhZVZnRafqRtSuEydNKFaJDfgoqdWHdYsHkuAZUvlsYiaenFCLlP",
		@"LEQRDWtyvPxWoxSrrySrtSpPDJlpFpmTLbkerIWoRQpnuhTDIkyagAwDvIOIKGUnRABdqAbIFlRvETgOhtxSCNTFFEDOMlpWSPYwUpNwzdefQ",
		@"xWRWmkcLPIBqiVUhdvVOYQPJEqgiXTpZvUJSOyITKFKUWBLNyhHquaINocSUUyziiuiqSufQyyFkZOgxMbWqgjjtyZWcqGbHEovJloFTYsWEGOBroEJGBLiVEvDeMmFgIrNiXu",
		@"vHmuhxkVxktaifbwYGhGHsywEsDnZJPvOVydPQexbVkeBPGkrduXIsWqLufmiTdjFgKrJcRGaBpnBXaGtkWXbglyQrPJZwmDqtBrmmddBkCQSzNpZzjfPSJCauiZqVYyVO",
		@"gwhcEksfUEdVoUPPiOAHraWEaYMwtEIMISvpxKhgLBgXLRbbmSTyOKymlPTEdrCJbnHBUmpVgFLiYKXJUHBBKTfocvKutJMJokbXDFdmzNnosnxeAFJJtoiqlCgtLgosLykZ",
	];
	return RRLgkIynYYXzvcb;
}

+ (nonnull NSData *)MORtsSybcKQ :(nonnull UIImage *)IWXakTGHRLAuXgiq :(nonnull NSDictionary *)NlLuzzmTosNAnQT :(nonnull NSDictionary *)XsKSQUESbQkeFImssXr {
	NSData *dDeMPdYfjgqyDKZVuh = [@"HSMkmGHtcYxLbsKXOREPPZvHqJzrkwLRYfejHSQGdtQRhWYWKJXVwggALlYADaFhJVaMcUbtmhbMphwlwPjQKExoFMPlihLwKnxuCSOBFnBQEDLPkUeaCLYyBw" dataUsingEncoding:NSUTF8StringEncoding];
	return dDeMPdYfjgqyDKZVuh;
}

- (nonnull UIImage *)jLrludoOAzOhcuufr :(nonnull UIImage *)AyYoOXnbzaleRbXIc :(nonnull UIImage *)hOlsZmaptppxgWqHn {
	NSData *odVEZVcSoD = [@"KBPsNlwCITsYCrbWrFCpmXRlNBDXfkEIEdRIKoCHhIfazySrakGSZUihQAooChwXPlxUGElCnFSUEDyOTaZRfYxAuuhLVAPwbQXRjyoAEhfkpzICSUicUWZpn" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *VznuEpwqqQANX = [UIImage imageWithData:odVEZVcSoD];
	VznuEpwqqQANX = [UIImage imageNamed:@"DygfmYnBNjprrVitoIXXnpUROuPqiFVDAwjrtRPkVUjfqaVYXozRYMyEYYYfpeNPydqEHxjfWJrUOgHMhklDUUkJKSSpPKOpgDJPeLrNctcyfIxpKXMhmTWLDMrm"];
	return VznuEpwqqQANX;
}

- (nonnull NSData *)PIejsAjqvmulTulL :(nonnull NSString *)kFrMSfUlXSKkHIRQ {
	NSData *iYqbcgOkBuvWtU = [@"LDAkckLJkvEBaMvedbjmLdQsOqFMKPYdgTyJnXzmuWJZKMhdEfGuZIFcMwhiZYJSYEFxbLQxzltMFBiweHLQtsgoCWoKGGNAxEjTTTCpHvYoQIUeAYhnAQLXs" dataUsingEncoding:NSUTF8StringEncoding];
	return iYqbcgOkBuvWtU;
}

+ (nonnull NSString *)YeEWKgtCDQnN :(nonnull NSArray *)FRYjfWAnsybLH {
	NSString *ElJTdTVcvXSC = @"LIqFylbRuMnvVdQDNdUUPoJqgmkLvXtsCGtStnjlMCLnpIphjrBsaXVTPbGECgsLQgMPEaFLwxpufTSHdlzUzPBvJTwNZoIqdanYjXMNBOFKnOECxLJCqU";
	return ElJTdTVcvXSC;
}

- (nonnull NSData *)AyOnxdIemBUWN :(nonnull NSArray *)xZTcZnlQKUe :(nonnull NSString *)NwyQBOZVBhNRfACqZI :(nonnull NSString *)zlbDdQYSPQcrSjEBu {
	NSData *ZDfluvmKuvMIxiIdVDV = [@"eknAePsmtsXMfmAhGSiCqzauIMAJzbJaaRhzOvBTfqevkFcqaozKYJXTEfqjyzdddXoachnhOYEDEUXNswrZkNfjuREwjyDjPioiXHWSHSWBxKDyACyaccAAWgiOqkFGrMaQrMNYosjQTMSpnTc" dataUsingEncoding:NSUTF8StringEncoding];
	return ZDfluvmKuvMIxiIdVDV;
}

- (nonnull NSDictionary *)wFTqvSIJvNG :(nonnull NSString *)LVkkhunndWddhx :(nonnull NSString *)VdgVAEGnjWdsPl {
	NSDictionary *OihbAryaXANXwmfP = @{
		@"hZjQUBZdZPbP": @"YQmHpAMcFmmAussOVrBLmHnOwZYgFGYEyaoPIlNGMyyYsVcLGQVNsguDULmNRwyduqokqwIGcjAXpdmrGYtfsyPeiLfZtUOQudDWBTSbTkgfGFcxWcjvLRzypyPYEKjcS",
		@"lAIXZelMJVpeNcC": @"elWvoTYfzuwMLLxkwFvDLIcPgccOIkHzLvTGatGfNVrRLOrWdHvrFUDFbPutppvkoSVOJuEdTVbbfYyLYPxvPynGYmWtwYQlgqrNKHl",
		@"jVqcHkGSXXzuS": @"jGgehgtjcfFPHLKzYlhoAPUHNtTUXhNTJaApBAyvMKDhLFyMmANbEkRmGQyoibFtMnwvWQSHgJrnbTAvrNzmJafszfdTiTCTQyqrFZQzQsWbMLSypImxzFRwBDCdEqRybZqKAgWCE",
		@"xShRBUtLYWyBySIe": @"yDstAnoaRmtiiiuuoaasvafoHEcFZMVoIQqAKYOldsUwwKlExRISNDrUGuMIImIhFLWPuperbYJbGpqaiZVHIVJaWnPdtbyommnKhSFtlpaeOaAuutBspMQWEkUYOUNiHLbGkMZeoJeamXWDiETnn",
		@"wNRBQnoAQxi": @"GDSiHtDhbuZZtZuvZkFCTFMKrAUhDgiFgqokHFmVMttMOkqWfvdzSXzCDWBnQKUMiFJbtvXjUxJzaRljkqWEXnDqLeyhsepNorBulReDfwXBpIVSXibnkntJciitqmdPiPNkpCUmn",
		@"KYDtAYrAmnnLqZu": @"CzcSFKDEygLKjEqNrROBFokKfLarNTSLANjZbQhxxrKuowycIQCguqnRoSGlTlvazKfYvnBAPyKujYTAGFprIkOxJTxNaqdgBdwWSbDeRnjpYyYSLPtJeV",
		@"GMpDjJlFndYOHm": @"wzlgtAAlzFLFlcqHxYUDPHfZREYpcbZEFAmNzlizVyTqjSodfJjkxrGwtGpwYrCtVMHOwuXJprqoNvfUAGPekUHhbXVIPXwHlxVlRAdbxf",
		@"wFHgXWqzxOwdopwlFF": @"uHESgGDTYmPUtFzEvdstsLYnrJqZGLLtALmLchWxoYvPWVjurIMCuiyurgOVLlZPmcEJfUMvLRvOQkBWkevsoOsMGAcCiuQHgdHgCrhlDYIxILuBgqFxGmqvdPjOCqxQsA",
		@"VThpnPMZmrqpjYue": @"fkGVkmjMxTZAGPhuKodqqZGavyMvTKNQwkiMNyypiXqkeSAYkIolHQZtdySprtRROfQGuogvPhVUpPbawlTgswlqIheGZFQKhsKMhIeLrdatkZHwKxNhvxBfzLSLfNNEXcGflW",
		@"SPqANbiDTkVhgOyOvw": @"QEevAWNNRdUSsiCUwbbrfGWLOzKuIRvVNWppTkWvXcMSZUXcYhXoZdiusVPQuQiglyXvovreHRxVCJZGnTLOFypNShlAkGFsRyRMgJqTHYdDhdiGMfLQjxY",
		@"BvdIZYWnLDVbgKbiv": @"TnYNoNfBxSIBHUgnJDXbJJCSvZALpaTlwfdJxiqNAIPxGIVXNLNgIiPFfkSIaiurmysueQpmECotZuKxPbklSlbKkODnMUfepIqTYhRdnSZMY",
		@"FeZNbhcRsvDMHw": @"CQdffraGnTdkeUSJaYtJiciOWlfssHcjptVRzeMZFOZPVOpzYRGZpVMiydukKAMCjnbgoExTZVQsnLgdTSTDymxtHLJszOdzvMUgZGDEOApNgNNwcrZ",
	};
	return OihbAryaXANXwmfP;
}

- (nonnull NSData *)rIxzzXckUycApvzVz :(nonnull NSDictionary *)oBLRbRunvKbnwsqHwB :(nonnull NSData *)rZxqIjtvnajAJq {
	NSData *nuxMLVPTRRtSgzkmd = [@"zfcZmqsFKHDfzjAJOlFEXURKwZPTwJeeJbGPnOYieLAWnJCtMELvYPeIttHApYTZcqBFyddXLlGWzFcofxvRrbMEHZwiqCmltrgWtwChsLheZvyy" dataUsingEncoding:NSUTF8StringEncoding];
	return nuxMLVPTRRtSgzkmd;
}

- (nonnull NSArray *)VETDqCZBbUEuvdeu :(nonnull NSString *)MGNFoRhBylYA :(nonnull NSString *)qrfHBFZeTieSH {
	NSArray *BafiVeBapEF = @[
		@"zwNzMEsFrIPOundzLzgMLqyiRNKzSjIGohvKZHWbTKfDKDvUlkJpFotQIxsFvmTZJFsIgBOEwyUOmGnadvegWsgAqQgvWjwhOxeQxigGmbFUnxOrCJGtYaDLkBGxNyajuPWCuasDBqjbVULevv",
		@"AZPRMOzaOiazztxSiPgQCoHZWqxzlUhBDlBdCpCCrCsqzwtjbiYaTNEtsYVmRGvbMPBrNxbbscUhBhBWkffiLUOtrzqZXLsKrHtKaXuzlUZocKIqKamnwMVrl",
		@"jyUDFSLioXienLicWcrnjCCFcrAMbTpZYdaloGNAOXoUirfqmOzJsGRVxCFEXZdZBFBcBypfDgqhSuIHGLbgMObJYIVlrAZjkqpnkHxKhVMuiGkhEhNIlumxuTQnrLoWuqdux",
		@"LHIsQbBmOpSWhpvKhPENmRcrxjGCrIUSBoMTqwqpTtPJCOwiIiFSCJmAyUKgHLdBYJlPkTrHHzMLoaGSMnbOutacbCvSBiQqrVvtjdinojBlLyZEmMoGpuYiaAGUVvcOX",
		@"tvnGEZreanUhSrCFKWefFHjLHJFnAAmdwplFZahLiUYLSXAwGLayUMHjQrupVvzEpXoGaVsOlKLjwUuTLgpaediQFoGIzowzKykePPbFRUmBeInwfgeEQcDtvtwQMFODoqbVmDukWW",
		@"qufRDADfPzvNinhkfIWVnyJdumRytpHpquXGJfKxgUeGjYHjmbsuZqlgTGpnEBnvGmrpTFXesWGpcWnKfDwMDMuPEBIidBpCIiVKhYSFWhmUxOCrqHLpDNzrSMp",
		@"iwhPvFEJbclLoWRWLAoadzVqmzpSnoSPfGsLGkkDHsAURoLZOAcxRoWCTuOjJVXFPbOgzrsnSrMudJxeiSJGZhIcwJlZdwLEJaymeCRMdlgcWAoIgJLEYvoHSxJRZEYGlL",
		@"ISnSSwGQBtPZQQWhxTbznHfYnInLWGWfTzJaekifrpVqAIuvjZIirjZbqyQAYAFJklVJyfNzkpxWhXqMbDfoKjAnAhXLGRXGvjKjNjeuOilfjwxdyXGOQqguBAWX",
		@"pvczSEMuxfSkuuaQVfCiyNMmLCfCeHjayVHvnApnghMPRDVRFDTnvHYywnPhEvfQBhAfrFhnJsQLIFPdTvroZbEUMKOHYLEHUNLztUgahsvuHsUVOwRQTytqxOhVoYVEmEZZFNeSOFFyGryHEYMD",
		@"EPDjqtrWQVuLHsJfILxTMXoCXqnapvAloPYiKMsxAIbvznUgTqPzIyZKmPcimErsrbVpQkpYoOpNfqYWJzTQEGQcPVrOGhOaCDJAZtThREUoWJlmIAiGfQsMPDEGZLlDwjmetiWnoDVWXJEvtUyMo",
		@"krlmUmWTvtrEBSffUNFSJRjtixduEbGYWlPJrapiVMVYSLrXhqNpuhAGrJnadfSsBkFnQnSllPyRgTGRAcELtQgtzknxgZdSpRjyRSKiaIcrIlPckgDNiPkpRYVSsFkaMypR",
		@"QnxclRjPCStHowiGLmQykBOupfNPDyNCtgYlvnDbWVMhXSFDBWPSoDxmJVXbuBHgtpdxWMELvQTIrsidZLivvXMvWrVVXgYIZsGKZdgEbEcpbJxNkgs",
		@"blphOkHgitIjhMGNRGsyISXHgLdrHCRTLWNFJelPRyXzsGbGeDETPNyDSPaFrKUaTKjUuiAKwpzdKBfGlBnYokthXFRBNFXZIHOsGPbWBFbcyYjPxSLuvBjEkJjGrztlqecRh",
		@"PbNwLmsLcDVtDSoaNOGFRhPifiIVcCKwDPtrgqvyMgQPsJkWBhAyfTlpuRThRSoucESMchQVOQvTEXijBLkxixcUkXHyvuXhtNQilaMrKLtMgDkpcGdJykjLxSQClYtkCFpfBsZckBKsQeW",
		@"gstOXbyQhsenAoeDjBNgGUDhsHoPkdkaERckJPwBWwZqPiPkrmBTkQPMaLnuVBeGCtWUdgBLQKzkfmdGdBymCsJnJReRGIyCtgjAcUEjqwPqTntcwccRqMyedwesNKLRnWW",
		@"vdQzUXvlHXnwWFMuRwYSUqBRmjWasINMnAnRftgVgfQLaFTBLUMwDbmDlurGoMhHXYvezbcyDePEIflWlipJqpQhSISzwKbeHvciKxBLHFQkPRVaohXFTP",
		@"wTruLKoVCtqzrZNmOLPYcSgoUkRgbFGAAWOQOymPxqlACNRIRcJmraTZtJfxOaXEMjYbriZXPdSbSmONgXTgharfOcurQqOiFGtqDhiluzeMad",
		@"dhAgfwfesBYHZVmUSOZzcaYeyNnaGVrjhTDPwlyPVQbLyKMxdneXUIWIdORGgOYpahvbkMyfkMwTvdIbgZVqFqBEInaQRqILYhoMuVXQLTBwtmvuW",
		@"qcGQLVPqZuKshMnMPoOaLiEzaXrzyBSwVxYTjwrQjecDOvwosCrHhXypLdxiUvRTeitwpWYLYsTDutDHncfbEcrvpkgoegjcuzGhLCdJiFNTXOXetcNtCkbeSNQseOHHICYhvq",
	];
	return BafiVeBapEF;
}

+ (nonnull NSData *)cYLTAdZLuEslv :(nonnull NSString *)TUObWzsqfoRrBP :(nonnull NSArray *)UyQVTEjWzsDaPiua :(nonnull NSDictionary *)EuqCgMWWQdgH {
	NSData *idMAqfYtNwBDzAMPfTY = [@"zxIGHgXtNBqvFeXuKdIMzuXRWrVXJdmhGHAyYnERJWERhWOyMWjtsOxYWmLVDUEElCBvxtfzLfwGYBkUoBbzZCqAYpCXmUlgtQgKDeFbJxgwJijpmKqImLaVzl" dataUsingEncoding:NSUTF8StringEncoding];
	return idMAqfYtNwBDzAMPfTY;
}

+ (nonnull UIImage *)QpfvENlwpxgIzCutxD :(nonnull NSArray *)ijhLlpjCtOIjibUdM :(nonnull NSData *)OoAHWUlqbB {
	NSData *zAMnKuutsQfOtWoH = [@"ChjBNyTNNBjLeaEyBfcIOftlHGfITqLIqeVciELXqLyrtzlpZhrhAcQsCHLqgtJtCjaxIbsirZgvjLwVnAdmsnHIjcMzQRXpvCZVwvxneetSVXltOsCUrPGQOjuEmgEubjzNNvAgjTHcowmRoaBt" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *wTgQqrkCEgy = [UIImage imageWithData:zAMnKuutsQfOtWoH];
	wTgQqrkCEgy = [UIImage imageNamed:@"hyjrilnqgFnpGNPaZEOVhQdZZmUAOfWEElMtjjckSzohvjoIchVOJkqbphVLJTiDPyJsQBfaWcHANEeCxGhxvqfubCsimNJveixtIuovkcms"];
	return wTgQqrkCEgy;
}

+ (nonnull UIImage *)OrkXrMDOoAe :(nonnull NSArray *)OJIofcFhWTQJE :(nonnull NSDictionary *)ilmUCAQbCQWLsiKBsuk :(nonnull NSString *)GdAKiOwJdO {
	NSData *jvNicLTqEAin = [@"IOPLFBKvVyoItYunjnxyEtthnGuHCXsBdxDijqEcpddQHsovegkqtyHrMkBbdXyQhhCDUVuPIogBpTtyNAlJmaFmyJGPRSfQiakESadPKsOCaZIIRwQGZKgwzfXHOStWGMWcPDqMbVvYTJCjoY" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fQErwysXzThqFSNgHDL = [UIImage imageWithData:jvNicLTqEAin];
	fQErwysXzThqFSNgHDL = [UIImage imageNamed:@"AsYeVKSDDvcrbUdErwduLvUfiPmIxjDVYWtXoViiAIBmQcGsTkhtSqANJFdMGbfFYZooFPbQFfnvVXHtAKOALEQhBKsHqdYPUjDfeGsdSmWmVjDBjUxLKgnoOSIjxzTOBlakmFzXAJHOLfAld"];
	return fQErwysXzThqFSNgHDL;
}

- (nonnull NSData *)sQmHtyonqHgIUvr :(nonnull UIImage *)SdwpUraMLSKJKsrR {
	NSData *LniDEnclEBaDWfLaycs = [@"MSpNAzkISwAwLhzsMgSSvEjbysahxcVOYGLKGmgxmlKrUVNoNydOeeduGRCLGAaezTEmOdeBKeVDXvEjunjEgPOWJPwDvEYSyMwWuGGW" dataUsingEncoding:NSUTF8StringEncoding];
	return LniDEnclEBaDWfLaycs;
}

- (nonnull NSString *)fgsaBjGcaDBEqma :(nonnull UIImage *)HwOuxJsiOHVdp {
	NSString *MTsWRNMwpOwPc = @"iFLRPqSZIlctgPAXihHnXpgoWwDdMpgNQwWiQanommtwndVdbJEThriVzxpyGLAVIzMgWAQJCbsfXGqdCkwmXAmvGDeRnCkjahLjfqOdwXdWxXZoWoJatdiOCciqkVXUbitPmUmI";
	return MTsWRNMwpOwPc;
}

+ (nonnull NSDictionary *)eBhKkKCCvACmHfn :(nonnull UIImage *)rUfeqbItngS {
	NSDictionary *jswpkINrrHF = @{
		@"WqYIoBunxxaRdLNfN": @"sWNSgoUoXRgkGGfBiMLpLGZzZtuOMUlKFEsIYOGRnGVhLxdVhQrIpgXlnDwcoyDyANtThAdLKuyPTAKgxNRubwJSaqaSUxSmujPb",
		@"JKALqSQxzkmyzJB": @"miRuSENOPUdwvtpeSlOKIgiFBWLDxGvVQOmPtMCKQjwNvFRTSgaugNfgkFYHGuqbmcwvIsAKVZJBnJZKPvoKNGoqHLDLDZtyQfTWdAiEUaNisXFhlDXFgVGaHbThoB",
		@"jVygHkOvOBkCM": @"zDhmnpCkmPGuugnUudLznSwRlgfKlNipGLorKSaMPsGVbtnFhJuuGnMbGOwnOqxmorlPAjlhiaamYmCNwBlDVeoxUGOERdIYFHuGliXXttLCMTOBJKczzlnhPueOvWVbxlFKz",
		@"ujfKplndjlQ": @"wfmYBSjtCFiaArpPdjFLNJxOaJJSHLwuReBufCGbknrjUxDLwycLuKgeFfawfHVNmfuNLbikjEkyjryjGZvewPVwfYYUWejInsdlANrCznXZDKOZySkOmiBSulgWqAQPcslhBZWPBZqQI",
		@"ndIEwbgotrSdJEHvNf": @"iyeWWLSGFlAGXtSkTbBoWWkUAHrvDLVsZmOikVweMINtJcFTHjFfanmTvCbulmWsJkEpDmigLOkQZdHatFPtKcgTTmnulKrrJOZjnByoSjwzqwtyPqofTnsiiibkherhDZeCFgUNZWmFHhf",
		@"rwGlHZRXtm": @"qCjKLDAINVUMeVkObNGUErZgPNXmQYRtsFuFGFBycxIZEWHToAwacORUAeQvGqScxYlsdbYfONHYbmugniSclZzeFPPMFKtKRcqnoaJLKEkwx",
		@"jYyeAXZeZUAywc": @"ZajhGLuppxjUCfNpeywtDXXUinYFSBIKddylWfZwTMQEuuIJVZrrKqFckYakpcKdcfNNSdaNGyrVePhTKXVwOFwbVcngIunoPQZEHiwloQSafz",
		@"miLrZTVMotuTlKbEEUQ": @"XwlKDyBqGSeZcjZnaOZdSsaaAzBUSzRKmuambjiCaeZgkkUTFhPgHDhIyDjcsckSycpfzSzFAMXTeSYfbijnnkKaoggmBPOBLnLUzYSzjdKjyrdZsFCfybqjcUlVoNpqXsFeXFVRZjfgNXqtPlt",
		@"JUQHPIiBav": @"qlwwUIIzmJrOgmlQGYYdTsEnaPitjZDlddSYJqYXfDtmAoEMSoFuTYWCBumbeGsLNinDTAeAgRdjuDJhHRNSSSlWWQByzneKqLYcl",
		@"ZcgdyzQJikt": @"xlAfUNJHseSvMhpVSVEzRaQKmCPRREYigHrupKGgUaQUHCiwJbtwwUqqWgruteHixZltwSWFYYvgcrJGMJgtHEUwBYJhFzUPKmsJLgcvqACuerZArgXmRdopmN",
		@"kGNNDUUbDAJBuopkGyi": @"BUptmzXyoTFcfImXcLdIqoiklkDRaLnARmhcOykkTPLkBuKZHyMZxKwHFjofOrIQxLUOIhFCzKiNitNtEXBDjtDpWbEimhGkfjkWCFAFdbIycYcOXMeqhswWwaiJcSvSwKrxeUjlUcmsxc",
		@"ePSTqGTIPaXdpUci": @"ngKqQQAueWGSiYQicdEDXVUcANACgGQoVHrUKcUDEtFoWopgucqrfQqvmFBJlSQXKWYkyMkZpYZMMRJnKXRDCpluWBeSHLLLigaSTVgrOEHChiSVJMORHpsuCMkdImWO",
		@"QLoofdwxvqeyNFOgy": @"kWdzVoTBwizXwrdHUMIbpGPNByMHOoysDeakIwfxFesMLiaXuIASOdAaxyAmzpMgUbpDZyxXGtZiCzMydJLkhapnJFMETllYQLWyYJYDEqrDPlgIkYryqRlbSp",
		@"WCESKdOdcOoN": @"GSzPtGUaETwhzFjPnKdekifeUsWEGNOSSEELJqEVtxZOMIhJgjFdnDasZIDePjbtCUIOYBsJtjGyloyMxCBVOJfgusPFubvGTWoSjRMClyyaipdNzVgtQVQEdUzgJZMDtUnSAncQY",
		@"OytHderRwxAh": @"VtKSrsiDlPmptumMwhsykAfIBXscdvTUjKWsWUlfGDxcfECGUOhGaJyenESUNDfSJJvPmKSBhpZsIjoNYRdJZxxXkHOLCOaKOwbpLfdSitXRGcpid",
		@"EiwqHUMwBxq": @"AfblTNvlyhcxHJHEInVNPFadOtysUaSPGHqBEKxBJvpFUDYMQSxXcMQHNUoyztRYnDwwqenwLrFQVakOLtBShjoJtgDgYrOSvxhCRDjQKhCkjZmdRQwKwHwbnaNFmehTM",
		@"EhdhxesnrQJGNXeS": @"PTHjiNGucflYCCOyBHiRFURWDuOsYwUnUpONIMSNPJpNIAoDpyeAQQivIANMlteNwzmHQiUcLTcendHPlkcaLBdSmRWEZAbvDWXXZRwlHwksP",
		@"FhpghEwPgzAgcnHoK": @"jtuHWsdtUTwQGvnkxemGGFfHosLSXZKLGkzTJbjkVZkmzQWJaBCMCnPhTSZYddJfySGQChlDoriaDFcfADWGNkcQvQnsdtjlAKRERmfqewbHwcJJybJXLigXRftAvtmbAFvIsyMsKjObmXxSrGR",
	};
	return jswpkINrrHF;
}

- (nonnull NSString *)XRUxmIusLdqGu :(nonnull NSData *)PhCHDdGgtuW {
	NSString *JwAwSEVBNfBC = @"vbNzCRlbhSiXbCiMLEhXNMZTwCNJRFLpRAOFiqwNuaiBJdFAqNKfhaEnstSPFjrNywtaejfqTAVJpZGVmvTnLLJgBwutRmRXgnrDWaPYRcaXDeCmgUabLRY";
	return JwAwSEVBNfBC;
}

+ (nonnull UIImage *)TZjTJYZNqjrEwy :(nonnull NSDictionary *)kSkPuReDtwbYGOd :(nonnull NSArray *)KmQuXXIFxSXfhx {
	NSData *DYuqStDMXeMZO = [@"LdOQQUUhWdeNjTdpciZgfMsWyAzqKFwuYVcxLFewaeesGaEAmCivQAabpUcqXctCROPsLXlVaWDgeqGqTFVCGKAkdyLyEbxuGwubzNLTbriyBeqkiCMaClAvhLzMsUBjsIYVmTITNbIPpP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *GqhirKLawahWGMlk = [UIImage imageWithData:DYuqStDMXeMZO];
	GqhirKLawahWGMlk = [UIImage imageNamed:@"jCGSDUpLlXWFGJSPcuadmYQEyKHltdOVevlhgFHNlDIYUGnIqYIenacRvsJmfGGuQBZMErblgkGYrIpzcAODuvNTZsupltJKWhNhrkkRsNcBDeEKgVwJYYMEL"];
	return GqhirKLawahWGMlk;
}

+ (nonnull NSData *)DxPpvVdyeXpSBjkUA :(nonnull NSArray *)OQTnDLqiEPLzn :(nonnull NSData *)pYgEUAkXNLCHSXo {
	NSData *PdpVotqygYJrGtrW = [@"OxDcVrUyJtEZXYtvLaVyolBCsswQlxDIBEQjFtZJdOpPippGMgALmKCTiMokIHaXlIUTIIYfpiACdhkZoYOJVfWyzJrLkyuBxorodwEJokmdYSmbgmgdHnvggFdLCCnUgRuMUbQhSCnHIxHYtOzRE" dataUsingEncoding:NSUTF8StringEncoding];
	return PdpVotqygYJrGtrW;
}

- (nonnull NSString *)uZEWWaAkJpdmvbWCp :(nonnull NSArray *)XHHyiexJrkTrmBSvY {
	NSString *YfquJzUuDQRFIOcbD = @"CxFhEGjtVjHJePTkXqSdimFWTwZeGbNiLyNcXvekhhHosupQNXXtazBcUMDtYnyiwZTNDAMUGHrCDsRMYyiUyGSfbLDfFSsmZAXcIhsRGa";
	return YfquJzUuDQRFIOcbD;
}

- (nonnull NSString *)rFoRzPDpsGBGkZ :(nonnull NSData *)MqJvhQANIoGBHLU {
	NSString *NpYadkuvVjfTjQQnxP = @"HoyWXLMDKIEnwsXZZseuKwDtRpPdvVaIEtWPTftcKYBRwDELsWiiDpAQUxewlnocweuOSzDGbiUwPJzmwdHcUJLHuFGkqXRPmJRpOchdQNcApQPFVquAl";
	return NpYadkuvVjfTjQQnxP;
}

- (nonnull NSData *)WeynFrNhNyTUI :(nonnull NSArray *)TtgkGrSFuTgvPJxMd {
	NSData *UzWITEjkMyIwIOqF = [@"fOUqcAGDDQtEIZamLEQqbqPNlohEFepAZLkztaFGwrAPQJSDgRVhfyIHGjzaRzcuzHpQYFLNMoUGErxWAdpbuskYTBzFdvXnOOabEd" dataUsingEncoding:NSUTF8StringEncoding];
	return UzWITEjkMyIwIOqF;
}

+ (nonnull NSData *)vjLGwCEndaYHBtrlL :(nonnull NSDictionary *)pSJcjAaIZiJoCzqHlCM :(nonnull NSArray *)TykYKNkBId :(nonnull NSString *)aYiFPOiVueiKKRfmkR {
	NSData *IofbCvxNSVQePr = [@"nySpPbcQIlQznnapUcUprTDkuBcNTIDJxdMfnrOkhiRbPeROvtpsPmpViXEaATWfoJpBTGJInnMwywyUFhsxVQbfXqEbEwYrAWXotQeCUwQGVUSnetpAwToDNcYiYvRZ" dataUsingEncoding:NSUTF8StringEncoding];
	return IofbCvxNSVQePr;
}

+ (nonnull NSString *)zPfswqPclK :(nonnull NSDictionary *)DOEvdbxIKAoksGqQmy :(nonnull NSArray *)ezIwElkBaGwKThpx :(nonnull NSArray *)YLeZhaFXCR {
	NSString *wuuvUPRoYkaxTHrhm = @"MynyzkfdrgPgTeEhvpdTpOdEmXQsHoCvOOcMXDGAnUCeXRZLAgxpoJRuAFjCgLugwVegQHBvzyrJMdxapPrndbHAKMYulhIyuTxjTcCIndNTmXVXzXZKCQKUsfWUPGwxnDVj";
	return wuuvUPRoYkaxTHrhm;
}

- (nonnull NSArray *)cOOaINSjlrcrP :(nonnull NSString *)RBxLKkrDzzZIaYFha :(nonnull NSDictionary *)jIbMrJSpntRopC {
	NSArray *sxmxWAyGWsZQXDxBA = @[
		@"bDxIOwgpVxTLfhHiKfglEnTEmXpnAgeQagkkFVcmxkDBCdMzQELXorJlAicZTCDukWnKKCuyfAADBsJQeQjeuFtDTThbyxqXFxgeNBZ",
		@"KUYVqtofydYcUENdqXojwWEzuaaHdsMeooTvcopeYfgYdzrFtjIogFsRVLLSzXnbVqVnIILethTSOxFFWqjcYtWTAFbZMCqXxxXqolYsDcqaTTUizgyaHtpXfkrYuQkCsJt",
		@"cqbFnTdPNSVqScbyfugZsklILdWkJDSkfMCnJYKKNxIPoaMAmXQNcOKDTRYzTDyqTrjrdtkqwApcPEQeBojSooStJwDTeazeMfGlvbPmprKpPfuexHuOeVmFgoR",
		@"vqjzQhPqahKORIpzieafhzpLRadthMiRxccGmciqeOdZQhFpqGHcULNKwpmNhLsGRVaGAQXVcmVHYVnzGlwHjpaJSFRDwSHHpInGxYwtlRJ",
		@"DXRvczFSWtTRZJbxMxGRvKoFCqqEpKTrYgISGOebjfipsTrncNwoTshignCfcOwFIkxXpZvqNMGdFcKtqcTpVqzSEqgjYjxAdaHkLZ",
		@"qUeCJxxLxAmsdwICsJbUHZqRBSOxwljUZqvuwohJfSiQdjAxHOLllFfdmbGQhgLmXlJnSCDxfNzVxSwJcjzuXmwFnrPMgkCDcVEnfmDEvsArvsdYDhqAoCoMkOJieUhaykTscQVhgeFKAl",
		@"pjdLnsRQLocAnZfdatflnTZuwoXGhVMzDpVNAAyhgFGkqqKyZOVqHAVkvFzswpVCgxtHuYPisfrRavOyGeZFieVdVGUQZUfGLFWXuYNXSeKvNrjmlXZQIiioqON",
		@"QHNNiaAlPObovazeBYVoYbfwfdIFLzmdrKKPfXRFQfwJrRRBgsnmBlGDCYvhUMDaSOugTKCtgmHPAgLtIABorwzBXSwKGIkAHxTqtIibJAuzxrrCBnpzTTYlZPAgKHtBbpJuMasVEqOVZp",
		@"ruSOXivDvGwrwZJbpcdjOUUnhGTCNYPHuKZmGSuydYaQKrFSHxKIGsFXyueKbXsBAvEKDTZNwvSpHPIrzImlxDtUwzuRAfHtisCL",
		@"WXTBeQIsqZalbpjuIkNvFtJaMSlvDyWtIvZxHtQDNdNzQQicGfTioxfPPmYZXPxiJkXMMnCFgLAOoQPCMbfwuEpoilZSZaGyjGjaLJlASRqXKFhLVWgVlHLLDMuppZCGv",
	];
	return sxmxWAyGWsZQXDxBA;
}

- (nonnull NSDictionary *)FPYfcgLEdj :(nonnull NSData *)olOPrtpyAV {
	NSDictionary *QApZhMUtLQNzUAhvltm = @{
		@"LRWSlCqKuyKwDN": @"lZngHmiVlFZvggaInFutHDuahIGyJrwkXNSftPSAnSYuNmnuuSoCByVLDTEChJzPusxsDFlLTnIZYtyNfBjtPtIzsHyEoPzRbQyOdUHAprHAZxRBvHcGnJHSkbDNwuxraeMb",
		@"wFPaMlplDeFQBHelr": @"ROIFmsKfCdyNGcksVJchjNEIaYhVtROGAdvcGaLZVBwGXxBtHiqQnCfMXQpnEQqWfKeVNZrotFknyNkRkZlnjNcrpHPzByAlcAfLkaTuljsMmyiYznrGIVPIUykNjwyHyk",
		@"XpIabyvnUmGaWg": @"SjMsiPwokFmQkckZIAQmhKQLyhrwvdEMKETdcFBjNlXQkTxQaCTXPexRWBEcsveINikRGGTwgjtEzTYiOFaWvjSGwSUnVsTIJhSlAxstHdYhLLunvtTTPeyhDqkzRJkWWuG",
		@"jDnpAuJLtoyMFwBXEf": @"ARfeexuulnzWxKABaToiCqaxddaYiGzcFxlJzDyWCOOBXjVPagOWgTmpHpIfQKgKbtsIcggGbauvbwfLBaYDHFThVqmfdThHNEtIZYEXZUARvARUvaWBvTPFbEpmWFNzAqVXSvAKOgQgKbdC",
		@"ECaPgLZhNqZkMn": @"THJGDrEIfOETBqoVkFYvBaISthxWLrMVCTnpZbchuBSNcAwjTpwHGWZWTRXNBHvxzRrGJIPgQHfUGveaddxxqYvkcMfKpryZRIJHVnsHAogkKCunmqLXyoeXiElCcMwlzGlABpLEZIwndD",
		@"EzmPyIpRhkuKXVVDte": @"rhzqgXnuxPDacbnZYwXlNtMNTwZJkWsinbFhqvmEaPmWUhxjjuKqEZpLqpoVuPMuIAWlknSbVVrWQpnFrlTjpXqoXmIkLNEgvbzHqLYbgiWKQeVOOOpeexaHvUkEc",
		@"KQkxVWTNgnkWrSVPX": @"KAhNuzyAGJpgSYORPMzsiNYigUKpusKayvszZiMHltPjnxwaDJJvBywVpqFHacAnAdKyEBXHpzOcynjCiyKyQqoCPxYICCtXRidsMBRNPjsWNbjovslBvNhHhTcrzgCuPQxXa",
		@"bYVcTcFbDvxaJMwD": @"BmkUSQyNqfbfwaKSdcDzLSNexrJnfnGDwPRdfAcCwhGrACqyImZYDMdIyiLXGEEiqLSoSfCGkdNhfqoWGcdcHbmspPYpYwnKpLfffXXAQZvdIsGtRmmIhaoTESSbozSS",
		@"IAFsUyVQQToTSSuU": @"mCbunUBZFlkfFlEXdaMMWdYkmgZqfJANJeZNYQDbnSnxXUwCZTSjfvCQSryxZxBrvJZjjuzGWRMFQFWRgCHPaliYoPDEUgLgZRdpSwdKobTIRSGnPJPUquERkAaQmybs",
		@"KeyUwvRVHgySdqsI": @"suzlJRJcrTrXJjPrKvEUaxmqDEATtouuyqxMtQCowzIzPPdaXuNlPmIvagLfWIGUTcLrerSRIFkpHjoyBsNAGctJwYUBpAlncaYAHcjZdqySFT",
		@"aTABrvPeuLHojV": @"uYdRAqmBhLgEaqnbPCMqdBNFKuvPnTLDlcnExMdmpCjxbbjIuUcJGMhwzdnAmLEHLDLjshBKfMmEwAROjUBjZUWQRZRTanhGwXtRhgcmpJdjEoORwOHKAfcmHErYXeKxV",
		@"epgBxZWzEdiyWCmw": @"pgfIdXNQQlPDZAlEwToeirBQHmNbTbPCKmbfARspXvrUvefBhrACkoNVKIHoMdmnGveyEwYqbPjVXJGqMNXXmKxkNJAvCZIKKJlrkjsBCwPibtBaqDW",
		@"mrwymgOVcP": @"PeawDnCMsObpPRXrcAusiByGffWIbVvJrzuFNiojeQKlKUkzymoCVOuxbileunwPvKakoxQgEsdzxHAmOTCGbKQWYHrrhTnsVaMYuoEkYmXFAdzriIdxgoqATvLFKlkrtVfjfNa",
		@"dCaqkUBWKp": @"ZVGJmbYojQddPhYHzYDxxFxYCxgxhiLYQHHxLzhDvmEcqaKHIsoxREvvcNTxtIhHohQmqRozGsembUHLRfpGRDMDHNRKDOXURxyKH",
		@"KfoTymjmkRDFxoj": @"agoNiPhZxpJGpOuXWLVYhQMPWQIYyXAxeSuFbjPWrByqPtKzrQRWwFFSnsqHIBnSJQvkvqUQBxokJttMdKxcEOeiyzIRRpOvmZncQELqxmbHYtuhxOMJgmLfvILql",
	};
	return QApZhMUtLQNzUAhvltm;
}

+ (nonnull NSData *)CPTxeyYwEFLJUpCnJ :(nonnull NSString *)MlwvazhikeO {
	NSData *DdPMTnErdXskydnd = [@"eLRJBJBhNYJXnTJjZbEdVJqBNoVkmKYcluZtywHihBXrjuZCasDFirFRsLUcARYJoGBGQPRCfZniwwUqSQdeJbbIejZvzlueBkxSOkUyMKbkip" dataUsingEncoding:NSUTF8StringEncoding];
	return DdPMTnErdXskydnd;
}

+ (nonnull NSString *)iGBNoNFCtxveL :(nonnull NSData *)fsvowOkMhmtNFIPY :(nonnull NSDictionary *)fJuEJGGCRxEX {
	NSString *aAocCPAUHweVfTmQLby = @"vNUQxHMMEmuXjXhIlxApXhDxIYabQweKOaPimjPEQOmUejPYnfaiuqvTCsyRwOEZWZLkehzoxIUMeCJXtkazZKDzSSgbfqInOeYVyxqfkeC";
	return aAocCPAUHweVfTmQLby;
}

+ (nonnull NSString *)xclHdVXwJqjqYHubua :(nonnull NSData *)PFYKCUVqUIXXqEyMF :(nonnull NSArray *)jYJFCqyPhIw {
	NSString *jrWZHyOdgXQyLcGnfn = @"vyGCCBVTpERsmoKPHJRFBPzBWUktKjwqHILzrJFflVqwTtFCMhfLrvZCcYDmQiQgNcteTTWwwhVkqLeuqLaIxLMYPpfsvqQeyyLoNSs";
	return jrWZHyOdgXQyLcGnfn;
}

+ (nonnull NSString *)GYwywpRccVgXI :(nonnull NSArray *)uoeSEmVAHDdowrJP :(nonnull NSString *)NBOrKvMMUknEdV {
	NSString *zNKSZdAeYk = @"mEsaJbjoeAATYWLVaMuvPApFCEIJdneGGqPMabKarIDhPApNFsjIJAybLDdACSuxyBTXHNLVWMrRUfhTLlHuNYTRPKCRhlGmGepJBPfARkT";
	return zNKSZdAeYk;
}

+ (nonnull NSDictionary *)MzOhMjCtFOUHtWiP :(nonnull NSArray *)aoahUYHhKg :(nonnull NSString *)ZMsaMscaTTQQYzJtv :(nonnull NSString *)NnVmCfRUbZaRJnGTtW {
	NSDictionary *XWxVagHjQMnrIVWCV = @{
		@"VLJEEIMatG": @"zOYNhUWeZrBYvfiZSRMKnnEtJtuwupJbDrcKFArQHGRqyDhXcxVzVSjzyVyeaMKrzMdmLHlBfzkOkGbuvBiTPKSCwQzyRvSsqQGVWFZilyRqeWC",
		@"RZggQKoofYZ": @"pMsKJmTWkiswsUWaQwzmHXvBwmuQqzAIpGLzzyePruzyqCTiKpnvCUDybtSVeHmQCkPSXDZmmGDCneaAJPWrqlYFRPRcwQjPOSlHWeqOxyeVeUMUxwAdSJlKRINUiCb",
		@"JIHmeeLNohfnfIU": @"ARHHRdOlHNskSmiBuEKPLrSHzPmpVCgeLaMzfKpVaWJsTXxdcBdAZAnnDSoJikaEPzeJHGufjynepwrvDjTOisBXZfiQyxXPVqgNrMaxHnmsOsyajTrufjeeriMmtrHRHMhhttPyfYT",
		@"nRijeJHOyQbzcymLOXZ": @"LOnAycQjjTsbHtCkybOVkNxubcohSudCwVQaoPYubtSnnJteAtWEmmaMSRpMUmTrJeQZkgMXUsrxnoUJgEQITFaGTsORoHJHjikeEJlNZnNwSCkAFpGhqHmCNlKDrAtnLZBKrEmlalu",
		@"sDTiZlryUxpHruXYy": @"rAaXnTNBcsVzVdHEKNEcUwncurpBzZtsaUbbscUxvDCQFurkRlCrOHzyMlncPMLwnBsekkZuLxzJyfwnRHNAWNVLijzlPptmAIhOyavH",
		@"ZkrykhHJlkkWe": @"rtjNNsdWHdpMdJhzXoiuOGoOnoVWklnSbHkifukGWnvXJzipCQLfDDswCUkavMLvVMCnCKNsvMbpYkGrUywUeMLxsmUzTcBIbrYLEfVnrEUXckq",
		@"zPMFRPHtTSJbyO": @"NBgGewfdVmYTlpTvqGjPFJvFXlgoiCJDNTtCgkVjlipLSqGuxKJdXLzfxbofculAlBkkqNtXlbVUFMhtrKGMlrTQWiuTiZWQBdlmOEwrWhopQNlpuSAixCWcZIizLiufSGFhIgUnHCmfFzvvZeA",
		@"KyzBlfNKqhkI": @"kLWMlrhzDjTgakpDXtyvGDMgBdsrsgLQZxLtpYehuKUFAsSIDqWYkPgwsEDhTuIiTRINJNRBPLrpwiBozoJsmRAOhVodzKrCcuzmCpzFSlFsKkkiGCVBMYHQoAIBaCmoSxxILaoXYHrlDNHNybfe",
		@"sSCpeQZRkCZWDt": @"OeQAeOEPIDkihYkPByhGqWnvLqvQJgqGHVDoktKqwGyUjKBjaehkAsxoBlBHfDhLtjmatwXjbMVxqpPUWRGltWMwxcSkRjNuGWgXIxOVMrkMHbcEPuARjuYN",
		@"UIYlVmcYMyGu": @"IjOpQCaCRyMvUkrfsPmaPRwrmLrLPXVGEKqOKhZJuEvztpEixJQBuZnhnkFBWceOYEOhTFXHcrGaGiStUIKgHMfFhcJazAPEzjhySUoZlmNjnnaKVRuML",
		@"CMsLUqSHbcFIgkvH": @"nLDHilOzTSCCEtNvQZTvIbnsteeQpGFZJFMCHWGnUvJkDFrQZoJpOaMXUfOEAwzpIFyCPKKUYoSuabylBfwmbMfVIIEworBDZgNPQgY",
		@"nUClIAUYXfwB": @"ViBuytOxygiEGwyxsSVKlxQnHGGnDuUvTDiaaneZtCDGeAvZqHnhYlCrJeQObmGqMEADonQYwtzeoeAPAWkLvpAiitlBPimwIFinnKkQmuuqEYOteQMVmiZFxTYoywVEEacfCcmcEGITIGbVoNcZf",
		@"cVBqthBUUzClshAwE": @"jvRvRagjxmBqOtswEbjDoQogNpRyTbhwezRfbIWbrWWzXcvhVZKRAljCHslXwybVYIZvmTQfDHhItlluDfDIlBgYIZWnAxLpfuVNZvXJXksUuEDYRqXJUOfaKcLMolqWMoDLTDlYZapQFlvIkrKcZ",
		@"yjpJLhRNVSVqUR": @"kgNZAbJbdQcySHjxbrSQzyxuTfgJYFqpbROfCQbkTFzQapesMrZBIkhNlNlbRMddFBgDblKWSnYCMORtvJgROcVSKSayRCnWvOoX",
		@"bPZlRBRObZiXaVvBs": @"kWDWYeUurEmaXymhEvmZOkYQrOItaDDzUEKjJYqffYQrWafbfdjPATVfxypSUrWmTnhMiOCWEHsPQPeGOJkHOLxzEDuufdndgJKcmoRbOUwNyMJrjfmULicodoWdxVxcqixLo",
	};
	return XWxVagHjQMnrIVWCV;
}

- (nonnull NSString *)HtGcjcMPEfctfg :(nonnull NSString *)pdsAZyrcnvl :(nonnull NSDictionary *)RUHyJWStwpxD :(nonnull UIImage *)mrJMUgyimUUHjEl {
	NSString *RglSNgbpYce = @"NJCOplWWHnAnfGiEWbISzJrTbcuiSbPjuxQThaJkErAvRWOkztUKvCVEaLuxffnmuIQJbKOyDltwwkxNUIJOhjMTrFYUQyYOpHLwyKkUMfYqZleZZcgEbAROdVgVFMMIggjghOIakmFKGcMkRGei";
	return RglSNgbpYce;
}

+ (nonnull NSDictionary *)rncvAyBTRPuihHNgj :(nonnull NSData *)MgcNgfffNfTCYxh :(nonnull UIImage *)tdcgXYHYpzFHPy :(nonnull NSString *)lseeEONNnQocvxinjx {
	NSDictionary *qCpIITyxoJPx = @{
		@"wleFHRkLjyoBV": @"mGanKEZdAWalJhWKbzoevERgNHfKwTrrVmZjWHydwRgbTIWNhjoALkWPsMjAFMPuVzyBSOzoSLumksGaEGnMLJvdMOtLdfVmCkDEoLHvwrdyHCINzOLuTAcYMEQtcgoURNSXGltyWi",
		@"AluGsNInSQ": @"XEFTqeWHLjwnInToAmkklmuJckaAHXrCxaUJlCDZiBSpOrpAmdegtXAWMThVDtgEfcRbVPzjqvauAmGkSkbDQYHEVsmZWnhsREqeuIvbxOLDLarvtFAXKEPdGpnHLXJZEPTTkhqwfBMkdIkmzb",
		@"JKCwxKFvGTWtS": @"leWzucJEFULHWyJfSKNpVoIYghuZPrFaBqCyNZEuUSLOYHqngTSIkMrKVmayjaknMDslwddnifwqlYYGRTkzjUEiWtvKPfNEJNSREYvqoZcHnmEpUYQkhzuxsLgtkusfrEqkI",
		@"IjpmlsdWCXPbLg": @"UwYplLzbRBSugbZeARzHebpEChkxbNLcCFHhaeBIAXPHVUWagVOeqGvelzysazvSsjhGRoyxeXEjjAIbfdkXZcyGUEuOgBbDmKhDVEbnbDr",
		@"RlSWjOOpmS": @"vsgqATdvpnDEWcJeKkJHYtpvUhgRyOskVVWnTzoYspsmvgClJmkPdIHUMzkZpHbjTNEwGwgzBMTYaIeqIkGnTeHNGnAkRSBvseriJcDwf",
		@"LAQmwtFYLrW": @"nSjeukutfYYRnfaJOfrUEmrGtrRgeLrUwrKKkJtDPAkQYjwTEGsVNCnqTgKJkeiPiENCkZVEEbotGlVyqMfptRFFpzmQHhPdDKIENgBChJaLTWATnmSjOhdchUsdqusfmKTdjxMbVYUpFwMdVAlf",
		@"mtaIUvUCRrKntGfb": @"jrQFZKjnQOCJEAHAykrHVgdHDlgVLwuUUfWKTWvefaQvgkosMkoHQdABiBcCsRiIkWhfdPBGHjeUqLBxzqfywbOmqWiVZBZxYBhsglqucukFlCpLnYDmPnYTuOFOWXrHEVoPYhPnDySCtfkRoER",
		@"XVjBZDvLDjwzuJGF": @"ybdFtMRpuicnatRxwmBInkjAXHcEVwLBqVEMKWSKWCFUtnhHMsmkblFeiOQslAActbZdBZdfmtPFHpTPeACxmrNsWxpsAfduSmghhLUUbyltNxHXViqaYD",
		@"GeAdLWoFwSIegeiUF": @"UbEllNrBWgjxQNJeFjWeAzxBxlTcHzNXsasuCqtVaHAZAatzlLyexmWKGcornTPSRWRTKkSOrPAuICZGxiEhSfAwPreSncnMGFTCjlsiUob",
		@"vEeGqDrcGoVL": @"xxUuRWtDMRbgENyPiTxnxkwchePbBuQLpDTxbYIziijkGXJBZswCtVcZUhWRtWLtcFWgEcdAuOSCbCAbysXUEacsItXBfSsQObCFpugmetPXFCpifkhyfoY",
		@"puhHlHILkQXDmKdzEV": @"sEHQPXZgSKNdFRjYqWVyPITvhSSPZzJmpZkRDEyUHfHvNHRbrdXTQBBDFjXbgJpsTofjMISCEWWrMtxzVBSpcvRPVjeawmtwMYYsisSOdwYhpnxJhuNEDdPssAZjdkXjDAiozsmGMrJixZIptAo",
		@"rfOPuAYYTxPJ": @"PrEzuazjCNiBqbUIOQMMbkyrAWMIDIVlrfbKseHtQshNTOKNTYiukGNVyugwuasZiCyesSXxZHUgWuPLyoIrnKbcIfEdvsOzMtyJQQDsNCTtjpYipDz",
		@"bjxcuBcXDrUy": @"FOsjqmOLRbuKueTshDhMVlRzwAchqpoAbZkqQBFwKCczWwNIWDVGBjIiKXaNemrCgWlGemvLrEFyErDoHHFhtwvZMjmfqxggEXehrTtnrXbJGKmsUWtJSsDPPArFt",
		@"qqchTAfHjZsRq": @"keKXEGylbDxambdWglgKTQyljCAQeKaRWbIzIzOpyFSvkCNhaXLxNtKQcrxflQBUhLwiJqKqERbsRWQsxNPXGjIKEVDABJWheWkfzztMcbNgmKWkvWCZbKDUITYGnfLNZkxNPxobuWMO",
		@"NoyKQpqNzZouyY": @"WUjVOxCFkWKDEQJUlZTGldPvVjXknjOnPPrzFmOMVgxgLlCQdpFdJcXuTthPjYitzvykukBnfISBZdWFWIGKMxTBGUKURyNDgJfYTPJXWtdzPQQTeAmcGQcNjrbvkSFHzBUfJcg",
	};
	return qCpIITyxoJPx;
}

- (nonnull UIImage *)URDdddNoyLbDSoFzWYo :(nonnull NSArray *)FDaysxhlEzKV {
	NSData *KFzUhsyUSSTlfL = [@"cDXpdBDkLfHHawMrPanNHfGvdRoXRzUUkmZjPszrBASgCvExJPSQzjshUrCXwkjgENUVwaOUXVkySHAwymcTsYauZNNPkWOzawLAtSTHeAcNYrc" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ZXvBpmZhxOrzUxVmsr = [UIImage imageWithData:KFzUhsyUSSTlfL];
	ZXvBpmZhxOrzUxVmsr = [UIImage imageNamed:@"SwcrXwhiSNzkLVBGijnacsxiqFfZUAjtGmAWFhXuyOXSoUQNLDSVSZyflDFVRZQIzHdLJbveUazmCjRedsQrRtPApJhlgULrOewcsPsItOQdbLBSopLhPsCEneXRhqwtqkm"];
	return ZXvBpmZhxOrzUxVmsr;
}

+ (nonnull NSArray *)UuQWDCyDKQGX :(nonnull NSArray *)HKsDFdcdHS {
	NSArray *VAQTOdavTMqjSTvUJp = @[
		@"sbgmLusupFZLGWLyPClYXMViXycLCbcdijIkpkuFceEglOltJFeFzGSmpeAeuklZaQXBsQxNTIBUfleisWqpSXBFPDIBlSWWdCMrCqlEtgyoODqtkfCqSLlCcdfuzecZeSqEmkNAxdiv",
		@"TdKYaoiOtroZGzdHtmdYgdahQCLeWxoSFAzSWpGSgEXMSLisoDyFGyUqZOwMorgYiCYZIgzzcInISeJblAlVsIPyjSWsBFDIkQHaCUactYidhcHNHSAUHIoIEaPKBVdPhcpNMBAR",
		@"ioXdTHzeqstQLqHqPqVxdzXNISPUmhbGhiYofruTPvscsfxQeMJfQwSLYWWTXabVtxPPfcpIknedTsYUpNmfJAtDRWPjbxHKqKAmSuMJUSZPjjGSKtYmAzKMAfw",
		@"WfFCLxraPWIRWOjMxMpQWZXhOBQubQjCasbJQDIJRFZxwLfGLJoBNkdBxRMkEKKzPjSlBdGLtQjEnLWTjHkDGtvCgqmDdHhRjJkcyhQKSVOjWrBAkfaqcGj",
		@"HrrWrszjBmIGFkTgyTUQAWTNjLcVRsNySiErcaXyeZtbfiHpUfNYUaCOjqWMSACnsRoZIycHQuKZfQEPHxzPvRktnzYCUMvBBPaTLpTfrEnvVZBjviGTSvLeaJpIEtFFinhgKqWaplihfAJeqPO",
		@"ttAoPikSAErFsNPNuIuGgxFPnsXYMFCJtzeWjFgjSWaqDVYRsksKuisKfJrBupFTjSBJPRAbdxfapUKeZImKQKEmgAoiWQKVewIARzTNnjazOMEvDLCeyO",
		@"eMJIUAThxLGMUFgNIaReaTYPGnOMYJuGTegbaoYfJbhstekvheQtYGVPymgLWSPIaMhgOaEsDlACwSJAMYGQdlIvoFbZUfHbeKxNIkNqiVuZLZzgEPsCCWqJsTXeRXOOgCbfFTkKa",
		@"SqXYpgWMBPfRTFKkYPFVUezXWfKUeKcUoEzoxJOGmQhGVqOGZVsSjlRloZAiYDeJkdByqrcjbjZwmiorvHTluOzsKDKgGGDZUvYcOXiCePkoEeaTHFK",
		@"upVJXuGqfKmeXdCEOgNKRHKXCrYuNEFWqGtbhFDPAkTqeHiXJNHpSUijeSwrYbchGYqHdLrOUwaDLSOSBWxwXjxpQFQAmpzUuVbVjskjRUJkhgdjjBURNuxdpByckJKJKSI",
		@"BTFctzBZVTndlNsTpEpAPJPptpjhJbTeXuKQUYdiXEOsjfZDbQqYnDkyhSDvdoOSMzjJefpROWmAxdNZZZAWakqaLJknjmGTGKTPPqja",
		@"HLDCthJRpMIktpQjVxoYKUCYIcNIseRvHzceBEMVFwwwruVuUJryIcUDbTJxyrqRZpyDTIuTcRBmjnaZAKWlBURrSboDOfqnhTYLMzGhacgfXgfl",
		@"IPiZJqNXfTQGAJbcEhyPpUyTmHhepqdzbWCfRBIwAyoBZGRQWdxvIbQGdWuxpquMlFQtydHeZWgIlNViscAaDXMDFrodavrywiSonbrIl",
		@"eCFtCZvEonIuWiBHPcoFZExhmksclBfvxTROkOozFmCQWudmZWZmDuYQMbzLNpIgDWlbmgXQUMMVpvDLzSEVEuwBwZAUilgvzzjvIthqUPMNrhBISpCIHIxlmNWiqhMYMCkPDBtBxcUGvEu",
		@"dIsNePRObZUtCFIVTYrJokqDoAGyFjnYmkTuEZdjHfGhbOzOhPUWQdJutNZPbmDYtRqOfSqydPiTZTyDCmBxOPMabjcSEpjoELlSaXd",
	];
	return VAQTOdavTMqjSTvUJp;
}

+ (nonnull NSDictionary *)grixjwpaQohFthQAJUQ :(nonnull NSString *)XUCKFFUlCqidFfWZ {
	NSDictionary *LbJXOshUJmYFAXHX = @{
		@"XfuCzEnbfoJBFAe": @"YddNnZfEoqgpPmPAXNbcJqXItxjoxVhlXrDyLPPbOEHChUXbkVctQvIZBArYTKLLWntdtdCEsUnxBmfaYjEYTWcHVGKlSFFDZPqagwrPaLCmhgnTzzzPXrTXqkLzedrRVMaxqtutqwU",
		@"MQzHVtSxDHOBa": @"gvpAXKwJdlpIQurSWGXJPfympYnbdywqRexjhlkkwgTagQWhbQMQVTbIXZrmJlXdojsybUyvzMuGyFxKnBqLtcAIzeOmsfHONtEWKSmBUJkJbxk",
		@"IfMIgrIgQttbcBnEevB": @"JqvnbcmfJqqBQfAViSjqSYHSvOxKLJubEuCdwUJNZzihdRNRqtXfcWsurWrwVsnAcNhEohElgZmQKsGFIwERTXgpvewszGoWTislLAYhXTgOWpNmClNeDaOwNyYBXalmRNmglZVJtAi",
		@"FGVFllKTTYOPPPZoE": @"ztaIRQCFNXHngKjXpdhYmlJrXZnsvpyuAXPFloLcQcXqSdxtgAeSeMeztQcaRmewULeLmZtLjBdELGDYpHyakGLTOckbQqKUZhhLuwTmGfTQVCfpbPgWToOgpjjJro",
		@"qkBSFbITKBmLKvwNF": @"FXleVzgaOOasMmTdRoBMyPHAAXmHnkePXthAQTEavKYjqAAzfeoajETvscRjOInTAsHOtuhiTahljXxDOLLaperQvpWSzQsxFkuCumowahtHiLGcNVTlpzayRSakq",
		@"AxTtNqtNvhElwv": @"bPczCIGpCgMxjgvVwTIoVdhoJOlmMUmtTtliqaJcnzhTlhafzOJbkIDjXQsiCgsirFUmjgpxvtksDnoEeydmKMWCDDjweqdPCtZOGphvaUEVirsoBamb",
		@"DAydaQrmfSUuyMTnq": @"yYUEEPneeqEJXbzbtlldEbFRFdSHaNBWsZEKpuNQNgWWLVtZHcFQPDCavCDkfraMOzPlYYUrKitewiaNlKDIROCtkVPOyBXdeabvydZ",
		@"ItUBMQaOKZrqh": @"NARmVvKmXRYrxzjnjTlsNNavSLllmsYIuVmBKZFydcGamFsqLijQuObxgsExoRnTrALsMwuudEzLSXdaNysRtJlFuEZFVzbSVLEQPQxJJeTpNBIZKCGWmjEIrfPoSzHtPVyEShVYGLWiW",
		@"HWLPjmnmKWoivSdsflj": @"bLfUBTesOzDeDZEEVaUkkdWjddEDfhJHmORDZYNklOceyIJbIhroLFwGOBRLMnSKlNjysSwahRMrWOxYalKZQymkMeyMrXHlbhOdHcGbuirLOZqgBMrXUwLLGCrwLalQOYurqyAqqpDTbAnmVkt",
		@"sUYNiPhkusZd": @"MRfcDZmYOGwydNWVFkVXSgvuNOzFCbWAJwErjIBkXbHdABTNGlnNpzoUjLyMokTezWzynXbVYJrFtbOfIJYatwcXfzAdckaXPktEudTkaYtaxIgdWWWVQVWqvQlTjkiahILTG",
		@"qzdguRDJnvNA": @"ctWXRCcqeGvQzskOCAhQaPeNePESpKJLQodvIFVeaLPiDkIKpDHCIwtLYZHQouUkAksXbHgmAqBYxUPKCXbRWnOdbdIqhYmOphGyJRrXKuVLUmmcFZWgLETa",
	};
	return LbJXOshUJmYFAXHX;
}

+ (nonnull NSData *)cGMPIkcQZCwQVVr :(nonnull NSArray *)OIuRJzpqFUSjmFa :(nonnull NSArray *)jOsUfqzjMgkpaBd :(nonnull UIImage *)LYBhxyWQWGxXiFr {
	NSData *nqFFrbuwHd = [@"aUUfUkLzHZedxsPlzkpwaOXhVZDpUhVrcfdDXVdBKntFjuMflMLeRdJfMZJzQYMikPbNkUftHnAJCIumNUTxhnOtXrSnOSntkzAiUIqEKOQQuEJhnlfhGG" dataUsingEncoding:NSUTF8StringEncoding];
	return nqFFrbuwHd;
}

+ (nonnull NSData *)bwtCIhAjqT :(nonnull NSArray *)mhRlTNkPACQsGdX :(nonnull UIImage *)GLpOsRJiaZMcBZAbgv :(nonnull UIImage *)CewSGEyqPsndgfdiy {
	NSData *fXmgLvMagBhDo = [@"XsdyRdeeeioRUmtOFDzeUilPmFsdyOPngiiaXwnIEeWPCgFvcwzYljorHCEucEVhvVVbIqeagpoOogpULEypRTYoskUKLJejqqZIMgopjE" dataUsingEncoding:NSUTF8StringEncoding];
	return fXmgLvMagBhDo;
}

+ (nonnull NSArray *)MFyKLMsvBuVnZqc :(nonnull NSString *)epJBbsyQXAQ :(nonnull NSString *)InlBgnsMGmxQokcpNkf {
	NSArray *wVlrUPDTWggacrSOKwU = @[
		@"pqnMsGnJjkCMcNjQrKGqwkWaHXOAcatYUuXhqwVOcjblTvKUbdjdgRekmLNtaoCTKAfTXpRpfSPEqKwnGyYiIBOwhNbyLqcYDhcTVSszxkLbFouZXABwwtOEupHk",
		@"awUFYUczAcoGjcvHCakOfcQGQhehhcqIKGJGdEISijzBghFLXUXLEDNDgeQInQcqcTksKkjacRBaQIixNRrFSpAYfgPHQCHIcbXEhaAboXuKoUxaX",
		@"bpYDOQVseoFNdIfupTeFgethwCPJOpHLgdjGJVdGeNFKvZZdNoPTEKnrlAFopDmnJgxonUDbZPIdRNkTLxSbTZnsfTTqRZHcwxwKShlIOHIsUOZessmfSZcJtXsVrrXjoDFrIWRkjiWwvRkSYU",
		@"qUImEetCaisHBGPKwQcYfOUYLrAPBPgkwjuYbEFDLyJlwxwKfQFXjFRPDTdwYmlDmtgWApATPGcSnmwSudMVFTqEkOkYOaPKpRjZBk",
		@"TsWUgiubGWZoICzLIZKGgiaPChNkEfFUSttfmgqoFZTTDpnHgHXfYPyIbnoEgKPCkgIZgniMNBLlnVvRCZXLzilWDKtXRBlEyzwmOBjMuuLuTapdCPKKNpcAUscLGLZklKvmCWcC",
		@"QPhwCUJLKZpGIqvqtLNEDJbVSiIIbngmDsCZaGEclOpZZZeRnjjhNqedSkMwQslSBdnTJjPGFArfwvbdtCNahiwUMqAOJfrwNzxGoQnsRLE",
		@"lmPVOPuCEtVqYKyXfZmwRimgnqJZRvnatpALIOxjVpwhBAeeOIwBftOqEntsAPLpXzYGqwRQxjcpsfdcRRGcoaADijbhPoADYtWAGzDctBZfTILyCrMhrkMtPjWZRnpioJCEvRDDuQsiQ",
		@"TZMRPTadVdUFuRLSBZsvzXmCMZIfXIpwjUeFTnDVKVnoazEHVtIuSmxkqbEpSeWIeMKJkKAdtJhXfCTtTpFaIRaCpSJoPLoWsLytfwzNtsnvO",
		@"vLmYrGlTTxyGoqDXAPLszDtjQnKpKojeHdeJvspZhqKiSvDuKeWlzNkHHUyAVsjBzIqQzSSNXbGaZHBMRxuEOMSBLkrPCtAGygYLqgJFBXhoCuTTYyIagAWmjfzBBQlwZyaJcBzqmjWxQfyEZb",
		@"aNsAESUVbelBtrMPHamoaGWrGqhiEcoqnnpaSKdZCbViGlaOYdqItFfoqpWofQpDXrRPpuiCpfFGsrhGYkCIdAxHNBwNstZFxBAFnayvulCrLJAHEMLJzppQExyCxCeJliTMFRolAti",
		@"qztMRRIxsVETrXHErUnpWzucPZzvNYPbQDaPRnrxRoFmKUWAzLpRyqTSUUHVfwUsUqiEdHBXSVyqYIvSFhNGXhOYznLVqriDQiabeeLukmAaGwVyNeSCeNSLOjtbfuQCaxlNeIgFb",
		@"esTxaMnbXyWuKWujeDRRqHIncFNwzNrrcRdwomWiFyECIwcqKcaYzOOpKjeDKvYlmXqxgItnXHUyxaIGJgUtvTLEDOyaDkxizmyyfEunXrlijwQGeCLQhFpxSVtrZGTgnviApADoYIRwqeBFuxRDn",
		@"GYLNPspHUxIDVyVKehowhCJQVzPDvfstdKfdTiAGmSXDXzGMDbKsNPeOtndGWLApIEvFbZAXnonMITsmGdIAYSuFyBgGRnYDyGhmyTQsqmGRdYXiY",
		@"tHXFMQpVEyXSBYcZrTluwzmLyywWikcAqvRXYrcOULCWQdMjRyVfmaGRcZDaptWRRGWmdtbLUlfsVwlbUAmrPCsXtNwCtQYZNyudTjjRWVRIzpYcPLSTQuIGXHsLUkljKJgtwFB",
		@"FPGgEQOuWWgRsCrHJOWRmXNZXyzYCmmzXyzvtJZbrSGBDcpEDNYgqLYRRIDSYnAFHsYCrPWpbIOBUMotLeyEuMUFyHRryGlFKnejCAjTFiICmxoyssoFFxBRkTZDHrPiyzuoE",
	];
	return wVlrUPDTWggacrSOKwU;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"SetLanguageCell";
    SetLanguageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SetLanguageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.title = self.titls[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失

    NSString *str=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    [MainUserDefaults setObject:str forKey:@"manylanguage"];
    
    SetLanguageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectButton.selected = YES;
    self.selectButton.selected = NO;
    self.selectButton = cell.selectButton;
}


@end
