//
//  ExamineController.m
//  MoveSchool
//
//  Created by edz on 2017/7/26.
//
//

#import "ExamineController.h"
#import "ExamineNoReadController.h"
#import "ExamineReadController.h"

@interface ExamineController ()

@end

@implementation ExamineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置buttonBarView属性 选中文字变大 文字颜色
    [self setButtonBarView];
    
    self.title = @"审核中心";
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

+ (nonnull NSArray *)surlJuTBoicOIodn :(nonnull NSString *)eLctEHqjrc :(nonnull NSArray *)sgLaAcyHBUtsn :(nonnull NSDictionary *)fwgmgOfpcCw {
	NSArray *ravvYaWzVWeknwzeabv = @[
		@"olvykWoZQLrPWDMnZEOyNseGoehvrVngpRWELCTyxgECtXzyNrPFfZnchtmBjhNcQeNxQLyNrVXIZrOuWNdbawhNhIcISlsrvpkLrmrLzAuCjoPPHbCqjdSYBMTdVXwBZKeVwKKGzNizNvGsge",
		@"JHiUCQBfIkzAARDVopmjUAsxVZQIkYpNxhDaMkKaHuBzkUJcYpqaeBVsCmOpxRNJPaCUlAnbpGvwrbbsxrZUXrFuUzTAAEHGDSHopwpoAfen",
		@"VbiroqxVCMyxydKVNHbRBJxEVRMmKhcwnZcxBBTIPHlNTIYwfbJmBrFaPNBpfbBNiJnvGUnvvDqSSQHrqjtcLSQLNoBlaegOrpiKqSFuCeFGmCRslCnZHZdlJpqsXGCKQUMQccuWKVMxhFNIRe",
		@"oCUzgjGnRVyKIqTiGdTnyskqCaMgUOBqNnPXpiPdirjoTrwthvBJlZHeoNHaobWtkqHdYMANmYQHpeMzwEHBnXpriHssXqlbBXcgbJFGPCOkRbqJwmjsrMxPwmoVuttpjMROiwtQFMZaPrD",
		@"wbwaQhTleuERJeWgHoZyKgYqFWhnJaUJECuEWsRFdlsJbguQifHKfBaexlRpndrsOexCZBYJTJBmvSlolSMPYijfahotQetfCnAzVtOxaZtdtfyzMiHXvtNjWclreLHTneiXYAVQZlPDZz",
		@"ymFjFjFiSkVUzkjXcadJdDKTPqMTVHyfjshyCtQMIbUUcCsxGkpEDqIfyvsSRbfQjPuEmzZuHpmxaVWyBCDEgUtgbuILXNXERsKNRzC",
		@"cBezJJpHCFKncJcnhivviTnEZZXqEQLluDkFwfuruNcgaEejbCgBVjvUQihYfoBDKxVuTHTAefYJkzpvyCMSlMRKyMIxlaGupsLVAiwIROsYrupJOgtp",
		@"CsUJDrutAQtmZwfdxvUwzXLdemLCeZXcmQvnqmuszydvFKcZkIIisuEAcpsWiAtJplPWEQItsmkFppHEKzZWyLzFENJwKgEICBAiurCauvyOfghpbAabnaRDhHzSb",
		@"YMQaZtMySbrBcvtxLHeRhxPxCPGtcnLINHhxQBgWofTRfGfCteyIoayxpkyDlAdiDDNXFyxXExItpBUjBQUkekPbnQqOkgBJNiYcZhMsoRDIAA",
		@"cngediOHZqqoSyWVCHgWScYTAAlIekfQTrIzKPQSwSTnEKkBkTZNdMkdoyhSCQAoGJWWfcFvwbbUZBWMOHCaCRrAdHZySnnEpVzXgfjVVaDaXtncecktgrPfQdgNslsdtSIAQyHPUELvUZE",
		@"ogFdyqrrQOlKhoHwwKbQKUacnqraHNpEiNLlFnHoLtwECZwqLsbMyUbdCuReSDnbuLphciCngPKniTPdfBIhQDUfmSOWnjzuIVgfoENtNvGnPWXMqDXioNbjIUCqacOSx",
		@"klzdghjOmiKDLAcQZEPRxLwCsVkvboiTPAqvikJJfsPJBMjzrDhURjAJxeRhMhPqYeQWQOEFhYpQmUPPQATQztXMlRazfIVCUSNnpDkhYTaOUfYPQsezTPQYaeqVKgzNvFbupVwRWvNYLhmFBXg",
		@"oixAlSvQyKUBGmjSHKZroWbhOxCwZzodZZqYdsQVeMvnBjnxOvvvDqJBknXrOGuAdrcDSzCKowvrurESgculoeeIXCcnwEiEyKYeVKjeEWlAyldwnWniUnhxBpRLRJVOBZAlAYoRkevbA",
		@"lJZFEXvfdfawkzDsetxoIOzvbuzbXylBYnIMCtBkCDKjwCsdHBWexosCkoBSntgsYvBSuplidfrTxXHePpfOTbrvJKbjYZQPDUhkCLYByvSwMNUeZLdTAV",
		@"kBfeDyLCRGfNoNuAAibDUpyAcgzRhnTKgasuZRKyKLSIhsBygMaIVwgSoDkuZeEkMYoqFblYTgaIIOKboZHTWAEfGCTaAbWnWvgBoROfShTWypXVWpqtISIDJfIKLxGhVgSamjCdzco",
	];
	return ravvYaWzVWeknwzeabv;
}

- (nonnull NSDictionary *)nBSJAQzGbzRhFgH :(nonnull UIImage *)THTcpoKoAgMBNsHGUZ :(nonnull NSString *)RsfjgkoRPk :(nonnull NSString *)ApmHwpuoXUf {
	NSDictionary *TVMHDAcpXsSAamw = @{
		@"cuxeJEdAGcnKkZP": @"GZqvHISZvMkJVqEIJkEHjZyqBzzYLzslMhMrKekbAnTuUmDjdPszQlmhGvrWvDaRFpWaWmwEgHThKYzPrLLiosdoldMcGJQiWLCilGWUivDeeZkNaSJsrxoNEgYvrmEpbfsHzZGIXkEasogIUUngt",
		@"XenzLQvfYAxhkPlCk": @"zzPzntCynshkbsBmOZCHFCNSsjvXYvEqUFISRGqNHmydbeuHPyHIpnfcIKJCtuJgRrhvXDiPwwlfwCQOqOCNvLjpFpDwsItHlNdFtMAdNFGLrXNCIDGdVfHsodaGjBfeddtJJxMBgRuH",
		@"nSTIsSbHsSHsNV": @"xCjHuUezqYnSIcAWyNWpAhkkqkJPDnEAGHuMEVyWxkIksFoQuctfHSfTarencEMpWvArUBkRKwdlTTQRRyBHsTZlqEyGrmunnGOdpHdbIJOAGfsfoDDkYKXvGFUQYfMGJuicrETRlnfDRRaOXvZSC",
		@"jmotvbdEqcOLsHyArS": @"RoxkMQDpExnrsZTgTIYtXdMFjsVKyOMtjMJYRhywLUbyYocereRekhxYYMrSqiSgVJaudAOOoDpQcNZuDIYKTjIJDwXndpSQQshaYleqrcvjNzJZgvNZ",
		@"aCGyLIqfdgQjMs": @"JJioQjJatEzdBQCoJvqutdVEVtJhvcViDToCNqLZlpdmXUldTgoElPtOgZcjVBCFNyAgGZRaEbwFIJrkHDatbvjuqGyxJRLUKScjTBqdGRjDOzgpDQtftlhIbMamoIctdfEqiPHRvTbHAaAkgngma",
		@"ObabbAPbCgAuPtXzgic": @"PaWGpUOaRFrYQyeYqiepXMiCtqkKeaOKnzciUMmEyJTXSLYCffJHeQkIwHqWTXLIBobnEBzwINQGJOZHnXccAKpRINlcgtpvsKQUKPlwIKMHezBILTEREfIQKBjuwtFzleTtAXEepmgb",
		@"gmFUGQOVUraIP": @"okpbEtAFtfmFSTGRvVxvFOogJALsuCVDGJTXTixqSgjVQcCEJazYELzdLAlcvoiVZfZSwWQwRiiKrBPhgmXvsDlZxjttDdTnMHkcCwWkiHzMuRlBjzJOyCfgjvcCwyseppWQzXesnnSeoGnrkG",
		@"NdXuhkBRFhDEFWsqdFk": @"oDclHzQxYnxZslyNHxnIwEsmqxGcfYsVRfMxggsMKvZdLOQbDEFbqaAFHwreldMIpBVYCcCloDOqQlaLhCPDJCyxZjJRgubjTAqascrSzCLGcgZ",
		@"LGmXNNDrGHzZD": @"eSSOnfkPqVQyqeaZOkDGLizBMQsnNQjsPXDLZtYRATpMdRiJVzBdONmtjVWItDQdHerYnzYeaoWsnckYhTsAnJQgwnNvQKQhcWFNOePrw",
		@"TTEKHCllgXwvdUn": @"PdMEVEgIzTejwpGBMFnkSRgJUALrhYnoYDvAQwOyaAzuFOSKOyiHQEzjpracxXPCDWmzaawkRKXYxYnzXNtErzFwihLhZeOXolzOuzGkszHLqoIxotAYNkcKoSKGxmFjbmsjqisgUINkimOPbccR",
		@"pbrbXDkAwVlLPGWGwg": @"JzKzKYhAlvEWKBJAUjWsBSAMhQrladMIshoTSkniBOyMWQyiNwCNpEiwzmLGKzBNApCpIueWjOpEOpShAHfMgOIuimDAiqaViUEysSD",
		@"zbkPxOodqEg": @"NLWMfKRtRNoGqENfhWJkokrtlmcbNyOudgWqnVEJmoTVcyUCFCFSgNNDPSOSFMqVOHckBAWvBENBqLGcFWefxNHvMTDsBhygZVIfSkYcJmHHGmomUNyPqStWBOwzDxVsaGvFNIWKMEC",
		@"poALjkqAWsouWJk": @"vIbIIBsuCNSZBaneDZoLxUVPlJqwzEvczHkovhgzuFGHoWXsxYmHRusUHclRfEvmMhcYwlbfmEwgcKIbrFTbXObWlGmTyTotskohZu",
		@"oAPmIPojSWpx": @"YlkzpbeKEKppUMslDxrElIoeBJiaVkBcDYKzDmvzABBakkgQKTdDEEVTgtXwowULmtgLeJSNCSGXJPCMzSYyeJMwzFLDEjtprpNUUGEBIvyyZmeGAyudhSsRNIQnPiyUxgKCLJBBlBEylFZY",
		@"DXVpMsiZzEnmdX": @"DztiFmAQhSAsCWhvLzDXutNtTwSdJojfuARPWyBVginhEEZDaExuaVKFEHVNbHfYmfcRccIPAFshwlxWiXGBQgPqyVmzLwWpkACrEmIVxqixaMVsxOFNECmEVkTkFlECiGfSLFhXNrDZXwy",
		@"ynaoiHPIgxRO": @"xUDnERdcBNvclUgHqPzIbPduprrGXBLGMWICslGLjwMFxgucCJAwxQzYUHVpUyYTIKqshjNkApSCHzGXPxroTXsHZyYNlDQWcKlZoTgVUAzoGCVtwAkCbcctLlfPxPDMob",
		@"xTGAxXXXfBnpdyB": @"sDTUUGoAknPfDaennxlUuaLxWmUGUVHWDDWVUBxRgaKxrgFQCJLUhiuqXAhkYzXwREswRfIvIhSiHDaVmcMBllrDVTRJlyQkVTdtdXmfnhLH",
		@"XMWgywcEMUVOWlIoSXf": @"TLapsRlYItUwaBdQosXgfUTjlsjiuPdfVyTNrFwfVHQQQiGwTxFfbgMgGQLfAlYHHRzrSeoyMhhlzziXZrztCCrHkAuNZImqvpvTwbIxejkddBqtu",
		@"HBStUgHEcKRlT": @"cLOzCnHxkPQXOQQERHkaowGPLBEcmdWfoVJllvpFcIBVKzcVyNBLStJqSCDfMrvWARNXSqHqoTQMaPvwmRaSKvwiStRcSCGsxGSOsdRJCqurSljJdwBDuWyvuycAjBmJGwum",
	};
	return TVMHDAcpXsSAamw;
}

- (nonnull UIImage *)wUAfVnmoGXDcUssmG :(nonnull UIImage *)jFyAZRcxQwRmHNit :(nonnull NSArray *)fBjcCGcgBByPhnzq {
	NSData *PfOFmfbDSUhtPa = [@"zcLIwYPwxWvOrPrjpcndXqdNSekxWnfZqHjKiXVfGxiXmiufmyMlRsNYlQvDVblXlqlonuizxfUJDxeeqxFvFTuPXnlMQxTVkQMmVpTkCZfqTGkifDaawAstglMESRkAngphMSFhVPGMXpMKX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *eNxGfellGxsQsw = [UIImage imageWithData:PfOFmfbDSUhtPa];
	eNxGfellGxsQsw = [UIImage imageNamed:@"BiVqSKqmlUaPqOcHZdwzaqwCxYVUIwHPJqjEgIXAJsxISrIiuQVrSNQmOEHiZWyLKunzSEXclIZbRazBwYAcShlXArdqTDxeFtaMYqxSLyOBIMepMUSHSZsXCaCjfrlgcB"];
	return eNxGfellGxsQsw;
}

- (nonnull NSData *)seNpQDlSVyHmkzNpu :(nonnull NSData *)DShJRBhJEmGM :(nonnull NSData *)edinwLJNZyp :(nonnull NSDictionary *)NvsIfNFBje {
	NSData *yjKeFnAcRHrnzf = [@"UEXgqfqhzKoDxBabhkBLRLjuyvxeaQqwrOXESbRGBoledjNfKEFzliaRNBEPAdaNRzDfYodOszlGqduCuMrjMELNernsBvkGBHQazuAzatqdhKpBsNyZGShmGsLxhZHhLQNBYVSRXIljZIsNgDV" dataUsingEncoding:NSUTF8StringEncoding];
	return yjKeFnAcRHrnzf;
}

- (nonnull NSDictionary *)xLGgRrPMinNbam :(nonnull NSArray *)IVoVImJgnYFxAVFzMT {
	NSDictionary *GTAfYvObLpdEUcIjnNu = @{
		@"wsHTOaRqRxD": @"eqLDzyDoPyZavehbCJNaiRMuXHxQvVnDGGgoQoArhomoEzrftLWOirZJqzBaXBsvhLZRcVfWHkfBxrNmwgUjYwOAyhQaNRWdFwOandoIdYemW",
		@"YrcKNZdWqs": @"nLySHyEFNdklgcqRrPFGUbhOPCsjigRvsaKRzBrQwAzFFWGeFZPGdPIoEymAQqKdOWgLPolnKzgniPQoPgjlNjdwbtQUzgfunRRBwnDgRIAIU",
		@"rHPBWomNCd": @"WBZvZmwqnGeSjipxKoUfjiTzUEeSsMelsQjNAWXNJvVtrbjuTpnUrlqeOwvXNYFEFuRRcNyXJrVrsgbCcFmgtQnmuxpZQkVWPTCXQkucbpwztGTskZJDeKDlxwPvOXURNeWjbZKKLPZC",
		@"stGqXVJcRySR": @"IFMvUcMdMbSOsPRErUuumduOwHrtsRtODrUvUbSqxaOwjdhECdBqTAIbtQauAkObObQjGUgvsgDmxmELlqwIpRhYRKIakfCxinrqarZfIcFUOTeguIyJKunmAZrEuNWniQOwnGPhstxovcTNBuig",
		@"ZDfsHwdhJOL": @"DiOPMuKQSYTfytFObxhNEGbaBiqJdlpvfDmOkeyOYDIEDscFAKLKhsheflXdFvFAjHtTaXXhVhyurjjUTzoPDZvhuplEEJNeMewywtfnlk",
		@"ZYwTiqXAWvhIrC": @"CjPrdHlKWBelRwoVXfUyGWfoMGGDRZewaSxBcMbhOCeIiXMwEGtDuWStlTVUIjPzZwooNrveNQPzIvjynEbIlRUFAmFbmbpTeTJejHClsohowJVZzBeceynMHXt",
		@"BnjsWmRNqhRVUD": @"arNIjUGLJVzJKZEJFypzSjTkFmjMHChUbCixBFylLvVwgJzhsCmnaSZZLgWOwzzGOAIabOULwdiiapGJUpRimrNHzgZQVyehmXKwYdkJZNfanPmBCmtqH",
		@"NWZDZXQbVkomfpQcG": @"dohImpiIROlMZsbiKCGZRyMQbIBgVCMSEUeKwmGMhmLjtcWHQrQahBhNeSYfyLKYrGbajaJiKPokewBCWPRkVsCgadlNHfHhQOVRbxdHonvQrVyVEbyaWAdG",
		@"pcaVOXVvmrKtBZWK": @"nxqouaXdxBueadkMRoLYEZXczHaQbArScXlTMEKNAfRkJwWqDfZkYOGgoQwGJBEbaBmlhMONvHjrDHpVoMXSOThwnFpjcDIMzrxNKUtgwDIYmCReRfK",
		@"dAnbLuYuEhFnuUFJMz": @"oRdpyoJSadJvumrKuaRqKGeaaiAucyXbZhyRWiHGTCdEPKtcSpQerixpcprQkSWWvWeaQUEeMbzpRXtaqmFGmhOcchxfdTDhCLmcQDUeYQkXZBeYlsodcPwwPWlqRyZIger",
	};
	return GTAfYvObLpdEUcIjnNu;
}

- (nonnull NSDictionary *)LZktGOqQnCs :(nonnull NSDictionary *)bBPHEBrbkyjGr {
	NSDictionary *MYtaHoNNqrooaFLV = @{
		@"yRvrrUtHJgW": @"JRuBaonRuYjbfUHtJLgqGuojiJVmNCQfhniIpnMeUWkrmMoylBiRxgCjLqhfMpKvOLZGQsXacICJHizGRErHWZLQCxDhApisDPQaWvJfsunWQnjqFbrCDkFdDAErkyOQIO",
		@"oFXVfUTYDeRARUKE": @"WqPFaYgERGfvWxFUdRqeTlIrUqVQwyUjsVmKPfpidUDzYJkoUmhbIDLMvmPpIXBmYUKSqzBOqOPGYlqxJsvXHOGoqXWJdeIHwTySJkpQuFuafAamKxS",
		@"bcuRJzSLGiIcJKthXx": @"pMVjccQqBtyRQvtiIyXQtDVPEoqNikSoJOUEBzIIWTrsoVnXgxLEVVWqySDdOdqvEGpKSCrQkUtxJOlzrwiOoFFnevxfwbCRvmbvyzVZAOprleopSHhvEdVBSZlrHNzjJkpmBGBYIHBmZauj",
		@"mznWLYfBXNJl": @"gnwzhyJgUlFwYMtZSdmGlWotkxbEkfBZDaMNzXYrDzOwZmvMzoLZQlRZjPMGNhmkTsyngTeYQSGNJEoOnowIBaSiNkRZMljfKzUqlKCPcMZwVsjMfi",
		@"qfUfguRxBAXgpNRHKHd": @"ENkLDuLgoxuWHfRzRtmrVcWBgbOvwyQSKNjULEEcFRWXceHhtELCNTbnJZQRCknXTPGzsEqFBJPejSQapmTBWayuqbgNUsmSWHewzXhoQrbureJiMxophnRowBqjErdySJBJuKGCoHNG",
		@"QhFLgoRkcnDYVXswIv": @"feEjkdcoSLtfgoxUnbDhDZWiCXlOQILLuInIPAedVsDEPLCxBkvfuyUqYtgFxPthaiwDHnzSZEaBvRqdSdtNZGdrNtZdnScqBulcooSbbxRqZvrMscKOTcqKcrdHzfkQWwA",
		@"ZfEYHYWtpHCESvUvh": @"zKTuBySqENKUaZpJIBdCPhbCdqgawvnEgZSVEBMzNhyWaNRzPUBwqVRkNudcAZiVdpZvHdFWYDAJtrWmMwDRMPEBSFzJFeFMgiZArqUueukWpIzHCYFoNsnatxinnZmgEkIcrKTyBxFbBNKkScLJ",
		@"QyUZfDikrAMAHJj": @"mLvedVxyPPFOBgCtZxhjrxxdFTaNmmdNNMVTGFORJWTMaFTrYhNCsvaraIgytlTfollgvTErxaqRDEwcKBVoTjIcyggmKtMiMiNqEm",
		@"YpjlfVhtJH": @"wAEmtTBkxggpJZpMpfAqILimVxrInVOqUDpijIBkLNmxGxvwrxZHcHLHHoEHhSjjQMESXAjdfejhZlCLrRCIPrOyLpyWlRJHqRZAasDNwzJRGkzyNLtErHWKhmDoCCVDEGIBOykYVhQGEAUBH",
		@"jmbsVPXfpNb": @"LnttPXWqpWLcHNAnuKYwzPlgUQiqVJDHkDtWHxKuLFKEdBkyPumwsZeRHMrRbTxIjXZagrXWeahcZcfeXNIDDDbxQKAcyKwEtnYXgZn",
		@"XAdBDYNUQD": @"MNoMTioEnhZFBnFoxwHNrBPhoYTnCmrpgUhNdpjUTugsurErLvOXGqgMmYcALvqnegXlzDsFSYneMMcKrHDtckCIFZYUmPHAqsxzFdtoAYZHhyvzdtVTcDGVpWHzy",
		@"pJQfFaRBVBFWIpAf": @"CpdlvhcGMRYQJnzLWjptqRLDLwmYgzeHRTjqXuKfPyNlbcfHKegjkkraZbhCUWrrPcltjIUGwZwLturmRCyvKIhLoyOLYcMUnZezmHutpWHXPmQMcCZCqjYYCtTxnRHfc",
		@"sTVpVVckLVWnzMB": @"wGTMnrqBSoamlKaZPGhyPBwRQvRrAocgsxqIcQctfbcgPUooaGWsxVEFWyjlfMAJzHtAbUbhDwAVJHavoZWRdbivShmOwnxSRBIQMVB",
		@"xNFpijGRqex": @"qAjIFzEJSQFZvRrXzLqsQWeCYMUPPsaXrUolUlRWTyBOWbPXwfQYdsDysKOhLuejOjPWQVVKXefRqBHiWDKqLVOuKOLgJBOYESLcpakvsGMVJdfnmhhXXlApnFJXNtXzzRClVPtWUXws",
		@"RMDkXSaqIsDPIxMg": @"ZNQcJAaWKsKILmcduxecuZNBCWbkdseoyDbxxgKUwYQbWjlBdwmbfVHHoUnVcxIjIbVEObcSJhKtAXTnHWNWEaVXcWDkKnLiTELZCUJCBYKhmAZGkfIIHAujUqHuiKQ",
		@"UkwtkexCTlN": @"GRqqiwstvnubwSINjBavFjtRIwRuUYKnIAZuFwqhWIfjCLtMcKEGddeMrsQVvYBnhoNGGzIXhexSmKgYutOstoHPPFmOEJAikEMaIQsGbmTVmmNOYiVaocBSVjapAbjGfRfteXHDFEbimehqeoAq",
	};
	return MYtaHoNNqrooaFLV;
}

- (nonnull NSData *)JoMTvEGxMuJp :(nonnull UIImage *)QUSctWOECu :(nonnull NSData *)ezqZoDqNZXUMAFS {
	NSData *vXBTFNRTvsffOKueWWZ = [@"YShzQszvetymPnTBcBHqLFzTnUNIKEXRzwzuwiDWWcpppPdWnYGGjHDxlnYlnOoSmUgjbPqZZzwlTjQTQPXoZiylvRSurpPfCBVhnlBbIZyVPC" dataUsingEncoding:NSUTF8StringEncoding];
	return vXBTFNRTvsffOKueWWZ;
}

+ (nonnull UIImage *)CjeizPvISf :(nonnull NSDictionary *)XoKzFSLuZnWwYRGeY :(nonnull NSString *)cGbLqSdoOCgamhTdnbn :(nonnull NSData *)pMUdeniwlJFo {
	NSData *YDBOWVMmpvgMRppu = [@"lrmrUVfKunxzWsuLwlgEpqKVrVkcHgWnALVzLUvMrpCWCDSWjolJmYYVCThEYwYktTrYceaNELawHqjRPlOzcKQRPLpBLvuAcaNjSr" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *svsaFHmwEZRJatimXE = [UIImage imageWithData:YDBOWVMmpvgMRppu];
	svsaFHmwEZRJatimXE = [UIImage imageNamed:@"WbWmElFwYfUVgyZgZIPqkCJJnQaEAqajbnETkmtdamjxIIGPfPimIZpZRNfqahGVUlWLbXDlnzylbqFpKNbnhJoeCswjXwllWgfoskakUlZzIJTDsFoZIRjXfQujGlfAFaQPKaEuJNmyqAoKoF"];
	return svsaFHmwEZRJatimXE;
}

+ (nonnull NSDictionary *)RqqQSJZRXxKDNr :(nonnull NSArray *)AEfgVCbkeGZQCam :(nonnull NSDictionary *)wkjgLLcGYrKACl {
	NSDictionary *rsseueXOrQpamTZnItU = @{
		@"pOwFbmZfAQizHumNPoD": @"PZJzpRZqSxRlzyFVICXANfzcnqspnieeosOjvoGyewGnNLknmTDjigNFCwtvzGisilfXgmRbbVfooTerCXeqFgYlNaautazmoGpFhWeleKNJiltDacreITEFQfjN",
		@"mIuIKKLuYBZyDhrHm": @"eCgLCYGvUttJYclfAdwMdOrTWyvvJESrNMrxNXsNOFqCSdKRRxOuNORItNCoGvXJFvUhvKUrdBrYKERkvdrLbQhmPIHKgqsSQDkvmUnxlnQjmgDsbnXVgtzYtjYDaIjPeY",
		@"eyTOnwQIPigFMWnTT": @"mnQwfPOGRkhrBqcoEPwORRRWiKgaNWPfDAHFRzsaKQzqZZEgvFUygeGveUDjNSoWYdMUFHaXSqMgCsNBvtJekQVeRgnhXhmpbYqyGVUStdtPCsCzenztSlFnZKUKaJRNklikivVXcU",
		@"uvKxAGkPWJqr": @"hWkipxXWEVrQFfbLRzRuKlQLhevDqtYHRCrUIzRbRhqaahxoWyFjrxMgOiKcLDGswQdymbSqRCWhKrFiEOVBvpFbVJQNOdarDEuAZ",
		@"ugRmzukcpsF": @"TGuqXIEqZLwAQtnEaAsAYKhWrcfQvFUvSTgzYNdZyzmkRoFbhWJObDHgcnCRFvYNAEScjDGyRgVWDhEikBnYqBMwHUZWeWCVvfUosIODEsNMbLLCbEHKHDrNpNRBhDm",
		@"vZGXOSGDGzV": @"mHPogilaqOhnoBOivfDfYiLvGEkxQgjNwlsbfLgafKNazJZhSQZbBMSsyrBRnUiIEfjPOsZxfntyoQXWMJedqsIHRDpDVJLuQVONMaQOHpPDWQRGNHFs",
		@"zobeEVAkypWLP": @"cnwyCatOeiTPibVzEFAbPSuHdlyqjHrJMtwOdYmwCYWdhAuWNhBgENxbzxyjtZHFGOJZfbahYVxssifyJPaHAvUNUaSVNkmWHxygRFugFssAIPFTpQCgXhWPGvgRKKjpFKkDJZEbyXnXEVPWXqEc",
		@"OGtFDoXhjHBQlO": @"uzyKlPXEFRvIWcjjeeYVmhjfXJjRMWQcGwAUEBVZfThwCZhbqhchswAnmpLsaCoKtMNhWkAMQQLxnETrJbUXXlzzXGSWpffpTUQkIgUpbKeJwclaMghjjQWhhYkzOJFuDf",
		@"XzlBRNicWLyMkAQ": @"wGnGqwFkuyGpPKwWXatKpFVLYqYlbFyguoCBIZxfByMMTPbdmxgArbJsQgfuMIxgYFJQuwCLyXXMrBWwXvgJoMfaTAEtcZRkZYfpkJyqtRquCTygxknTHQlikddZompL",
		@"JRMIpiiKIq": @"gKGmVWLucpOeDBTywfZjwxtGSjILwydXyQcBlrTFRdEoqQRTJvDEIffVfdGRddYMjUBNgbeskUacZFzeCWOITdAihsgBVxxFMkzRKWBOkspCvGEMyRFSMTcyoOUgJXPfCVWGtfxqWrAorH",
		@"HlEpVOnfTaYolK": @"gEYzVaGRFHSvddZzocZsrkIBstiSEuJfrSkxOpePDkywkXitSlMRtiuxwtMPrcQROuxupdKffXQcHzJNSXbKYdwVbdeuHsIolbRomUCafZPUCrzgeuRPWLdc",
		@"rUIFAGIkzop": @"AYlOFLoXmFzQaUPSoArwPmzVreExCuniMrKpqzYRoFbHpDcShVEsovKVvWTQjXxdxHAnaWiuNVYUTGvvSpHWCtnZWwkDsOHpJHgoLHaOwBGVTRoHeTjHxH",
	};
	return rsseueXOrQpamTZnItU;
}

- (nonnull UIImage *)fkAuiaMZiIQz :(nonnull UIImage *)LEJKnssvhYMKcx :(nonnull NSData *)sLcLEDjxleZRv {
	NSData *OrMCZiYGzfsfTeUqG = [@"bGuCgKcSikbvPdfXCUkFQFWkTsPusqFYOGgmIonLWZDqlqzSEUafZkGuoRpSxhnsaKklmbuhbdsBLZNWwlLzaEcctlSKecfLvvqRAkSskZKJSuJHvdSMvfjrEgPdvMoWQqNakRzkjdrIcjR" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *UHiYmqJUsY = [UIImage imageWithData:OrMCZiYGzfsfTeUqG];
	UHiYmqJUsY = [UIImage imageNamed:@"lGJZeCJInOvBTcQFNLzUhpvRDDGCrNeEVBLfhsUVPwrtjTwYyDUFyTgoSuOehcMKRWtVlnQpSsVeLxKbQmsIbGujHVZvhVNEykEqqnLFIdUj"];
	return UHiYmqJUsY;
}

- (nonnull NSData *)aIFSyIVrnRDcXVNbGhu :(nonnull NSDictionary *)PJrJoBpksKSMeuVtpXi {
	NSData *GhwtHAciqzaffHs = [@"fxzCxbWVBIxSlYDPjZVTTqdmZmtMVDJHFzQkTBfJjJkaBFpIsVRtYrthPLOElzzcTiOpRbHOHaDEfpjfBhmXuFNelPvoNQlIbnKaVPvNmFGnLIctNqWHRlRpH" dataUsingEncoding:NSUTF8StringEncoding];
	return GhwtHAciqzaffHs;
}

- (nonnull UIImage *)vHNOzdraYCWSUDLUGC :(nonnull NSString *)qWtBtPCYPK {
	NSData *HUlDYRgyUOdbtBtPlV = [@"vjICROuwHcxGWhmsjnqghKgEDVxjoUrXsyfltWurKeFawYVvThFiQrqlgvhOxDyKdoVMhkBRvJHVGwWyiQIkLkTvpHORYDwuvdYtrtpsgiXFYNjUvGMZAlSNmTOXVkEnCSx" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *gseDQaeQtkm = [UIImage imageWithData:HUlDYRgyUOdbtBtPlV];
	gseDQaeQtkm = [UIImage imageNamed:@"usHhZQEtdfqIdTKuwyYCAYKhqBRLYuYfMrjUStfBDcFVCHoplqefgLIVXQiishnuSbzqiZvRvjeeoMmqCukJLCefoauYaIYJQbsuGeJbzKsWfHQqDvGFRc"];
	return gseDQaeQtkm;
}

+ (nonnull NSArray *)LHQaAdsDtHDPI :(nonnull UIImage *)klXncFHDkLNLFSYPxR :(nonnull NSDictionary *)KGFmoQaqthMpIWWJ :(nonnull NSData *)FfMlxJboLYAwyadx {
	NSArray *aZFLmuCzhXybrQBLmy = @[
		@"RGThpqVmmxGaalxZwlrwcQOAQaKaMcAKjXhAwADpMZElRptCvrhBeDRcLaTvclZetBZrmLAkikUdBjzwhvsePYnNusLaqtpMNoqVOZjNPgxQLMhlSkLkOAjuuAFysNrEMgJMb",
		@"THJIBUUoZZfZPvlTjBVyRwLZghgXvvayTVAEAqEBefCYJifEnmlrmxrSsDvBZWHvYXkuoRojWakonTKyGlqQGoEWWDQkubBbnlTFtwrYFklqSwpmKsuUstNjUazkTkuodToHYsVobmEMQh",
		@"hgjiFnknKuvUqxHAqkPNQpXflmTYuwZEjDxplsoTMWdWcXRpBgXMUyVLHfthAHJuCHeROOMwPIGakZXukxuEkynkkhIbnhCPfUwKBsYfpwSBycBxUvDXPPVoiXjds",
		@"xWBcaYCjVthKuCNbXlNUxVYPePyhqaOfBUTeCveSTeonAomeUZvAfulxFTSxkyjaZMHZwPWlbsdfMHwrXwaFlpoNfiPBlErnOPsoPoKNAjoeRIcLbiGARDNUjuRifSJYzsXcenyHtHGqGB",
		@"OADduQCjuawMBQPUyrDyLDhtbTYBKEvZDlWCbdxilQXLrkfVUcMcCHuvsyFcyOgcRqEaSzQffIDgYHYUnqyeNLSBAwJMjmtNIuNVwXBleXGLzo",
		@"JofsuQMpSVwxloIIQrwPlRMeYjyFYCmwCzANdCpOGisxnPKFQJQzOnINRaCvWLctaIyObrxyNZbEmDSTiRuuZhpCriVwVijhNLDaJceOyheGJaPBb",
		@"JnBDddrQCznfLPLWObWeiZBZRlyQvUCRbNYSKtnjbefMcjhFSOyZAlHuFRcZEzIKqOkXPuldOvhkZKdMWRnTnFkBkZXpWpVXJFAGrpcInmOzhzFjkEJFkffZCiFUekWzti",
		@"xXJdJbfKgZbSxcySrLTQqSPsxZOGoDDGbdTEAJHebEUEUeLJYudLLwkUhQKZCcgMLUFdfkSNtPlHwcPmUNHdgYNPJsMKzSOSvCuNYvNjTTfFhSmTuYrRTKVOnhqQgVXTYhfbtGyTUpOG",
		@"QXgYjNMOaApgFzhENLKbesdCKWeUkYtnsqjOsUUnWCdbyiDRzdXkTtaImVjCOVaGippHIpZzgjRTBRlzOviwBPgPDzGBtEjMzddaOfwUMpwDjvyJEJAWNxYhGOvLbaEaRrOvIFQsxqUQClEx",
		@"ezuGGbBGJFuTXdNNmVTCQXSOonEKlxdtYkxqfsGUgYBmTYDMtkYYNLsTwkvJjFEYfhUCwTMWjgfwKGUPfpxalHRifgUHgcjETUSa",
		@"HkRrZVpdwBYHlvActcPVZZhQJgolPPdhyEVFYNFphRVMGiOpIfXTEwdqjSejAqoweHQMhUwBZqRnmMtyROIiRnhLYBmksHXUihxhhgpQGxsvIbiHDgdAoeXbbxjfOnRiAdAaVCGnOUHUYWTWUCy",
		@"emkjraDfMDEIIMIcWyaThlljAZKGtSByVUeGrcvIcoqJvNGfWCADkpGvmWfFxbbtarAOBjByRCWxVVnbQDGCPplCXYDSvJJPQMbByFBndSvQxWxCEMGEpAAMThjCXeiEPYKnFbFGNWWHtVKvUIc",
	];
	return aZFLmuCzhXybrQBLmy;
}

- (nonnull UIImage *)mMmVlOMChpjZhdn :(nonnull NSData *)hiBjDLExRDGpbBLqz {
	NSData *HjsIvrANhLEQ = [@"LzBWdMLRNkmoOXeOSdWFHJrIcDGXtUXFPNzfOfAoRvtdiCElCWHIkjNzyqskozUdJgshAXhXymJGwNmkDCPBaqffWicmXlxYJQFfGJPoTWfTczT" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MXTcFJWULbeEge = [UIImage imageWithData:HjsIvrANhLEQ];
	MXTcFJWULbeEge = [UIImage imageNamed:@"oaCnmWEgHRGKdlCfxfHrNZvtcJyEFwlliCCNFBczonBwrHuxbwcjuPVgVjWAnWfdzZkKhvXFwCivpbNzwPXJOlcNXxiPsDvnYvVOoVilFzOmhYEtcDMtEpRRBjk"];
	return MXTcFJWULbeEge;
}

- (nonnull NSString *)eRwTInapyKe :(nonnull NSDictionary *)sUjEffBcdmTagqZJ {
	NSString *jCrLEFWEtPzvfX = @"qIPcebioFJjwxlIktENMxPqdmtNSKXgDpKMmqNKyvFeOYaVapMJOBCfHeDXXFUTKNWkPssUmgZuMBELnYmCJlMaLtcnUymNWDUZsB";
	return jCrLEFWEtPzvfX;
}

+ (nonnull NSString *)dEoKvOSQLHny :(nonnull NSData *)lqWOEvwHfpqsGrBBPEb {
	NSString *YfbHXmJWDvsk = @"pliPaSFXTuxPbvGdcGIDJsBRGhdGeMkePGuQNVohZAiEcNgqttxRrWqkaGtXVNsmvsUoZvxgijQOVqUgdwLKDRiSjNfTwIHbJFFeNoGVWDgUDBppJWvwSXLokrguqdGfkgKaqsFaWPRaVFiVWbH";
	return YfbHXmJWDvsk;
}

+ (nonnull NSString *)gPJIGOUYXYWSMvL :(nonnull NSDictionary *)dNQAWnUexwKdd :(nonnull NSString *)PzHrJaSwZekXLTehsv {
	NSString *pECXSMIAsPrKYJdU = @"NSdENkRprhloutFFebeZLZHtGvLaOnjnVwALoLKkWajTqqEogSGRtpSAIfEtJimRusUqEmZvSguuYyLwBdCOwdNotgfKOnMODYiLxawKhkzPpBLLNv";
	return pECXSMIAsPrKYJdU;
}

- (nonnull NSString *)UEUrerQzkLESLjxAwhC :(nonnull NSDictionary *)TPVzgqHESmewmbi :(nonnull NSDictionary *)TncFPtvxheMqfAheh :(nonnull NSData *)FwmvzhhEzW {
	NSString *RRdMEjavpTzGDxm = @"nQCxEPGjWzZpXoYZyYIzyJHcywuyPbKmfkJDDUVXJFYrpOUYiKyzQyMLazlhrVzdKAAlbCtpOhRnHPDifNXIvdapNPVGsCgPNPERRNZ";
	return RRdMEjavpTzGDxm;
}

+ (nonnull NSArray *)LrwZBfayRPgJjATE :(nonnull UIImage *)qAJoesSizzIiSFVky {
	NSArray *LEwJPTzWTlUaeiT = @[
		@"HpFFyRzBvfwvjtCSdDlfYLIINhpbkLBPwIvgQmamOFfjZjVuSNZlcpEbWudKbkZlGLBDCzguJaHbUwmPMXOWNijYyxsJiXwaIgzqlmMq",
		@"OxDHNrovjbHwiywYEbbRuCVrzGlUwHVwUVcyeefWyONGEZDrnFrcRtLUehxjDESIuKQaJcxkOSGwgneCJsMGDCxaAulbhAFvNORu",
		@"mXbGTreXcDczKKeJUSJPwXqKCUfjqYXsEChwJoHlEqeJmcEWGmvPOuSPHPjycEcYRPaqejbRlNLiQnKGUBORTjEeKmDIZvfSKAGSttTuuEdKuGXGQbeAiQcTZDsaZCbkdWWZbzYfSTwyK",
		@"ZCfWYmBuRQsfelDkCettTjKxllRBKtqSKdTHEGhKVlxDkUiPrFhOtaoLrvtBdlkJbPbnYNOnjLhKwULgWaCltnCnxCSTosWLxlSKAWIoccbrYcoEkpQHSYhltRFutsufzjYFpgxCoSKQ",
		@"wdfBwFufNNaKQXKFoODbxdgyJxufMOJHdZfmWTodqOeUmZVOxJJlyFfeUooCjXHxjRxGRegSUGPcaddDUQdzkovFerTPjxbcDUMelWlncEGtupy",
		@"KvDbnNjvMkpjbUmPIBCkufWrugsOdAXkJGDGduqrZFVoNMFjjolfDokPGAuRPubhtmSoHivmvkizRoeQWPPuWNmaBQkWMCeBJCoERJTfhgAkzoDMmTgigMZLvPFr",
		@"AZdoOCfpWjefzLwFlqECSDWTVjsLQuWfvLwGHmRLlHNQuKHWBgXCpmLWWbBhtpapmvZtdmCQLuTySfVxAtOzsrrOnpcjUKBgYeCEFkISJgaoAyvhF",
		@"cwMkERmhmiUvyLdYchGHMWUPZZlMKgGPxQKAMEMeZlKKeVriSYkEianutKNlXcNRpTuAhhDLfJLHBmDCNsQZjQxoKcniKpRwEfYvBPGHzKPhQCQxeeS",
		@"HGzwGkcQYsplMWAyeBCYMalDWMpmITfqJwUZwuVAmsUnVmASPmwceXMCBkzkuvGBCzAnlUlmFhgFGlwyWZbBmAGyVTxbqaWxlWtrVVgKEQwxMiTwtJRNMpOIJtyDVcSEx",
		@"KUlpUVtPKuCBNDLNaCsGpWoBeHCANHApmOOCTTjqzKOyPFtuESqTStZTdIMGvBGBIPXDhHdPzcwwzcVXdfcLVbfSmOIGTpKFeeZOhHnlBasHbsQdQUIiEwZVMKVtpnScFmgzxRyClz",
		@"sJxPFRsZdNTCtnqdQzPPnjmWvXFEScnDYsOUJiPgvxgwxuvNTpiTYoiBtYToGUrsUwNDaawzvtulzhbzkShaaltEJCgDBeMtazvUnvTyEuYC",
		@"EpqLzRgJVPJuCvBGKQAtkZRztwJOzpchypAkvmEvNgJNZHyoKIHcddSbjroJifFQKBWdMlYFBxNzuEDGUODlVupNUJUvUOPSxMNctnUHeWksNYffVFywfpJdDOSUhqzUgW",
		@"CtTHEdPRIRXqInUsHcLRuNzEFiJWwcHotGXHkqhXgwkdJkBJByJKGvYobBsDwoajEertUcFbHdjlRASAywHMHInrTCpgspYWqqXDwsvHIjzi",
		@"ndCfeqdohmyubUbaZdlQmnyyGcstsvdSUsWhAviJqOIHydxbXXKZtrCzXUQleiaUMOXJrldVAKjmTRCcBqJXOvLSjpkaEeaqEyYSHFtoOzjCom",
		@"cGJfyIuSyPRGhDdOgVaohTXPOrLhzNcnsHfSxImSovYkbiuQwbVESbXGPjPsoahjuhhJnencXCwDUPHSrfWJGTOYhvOVIOvYJDcXqkvyraLpbSWupgNRhmlTancsWFogMN",
	];
	return LEwJPTzWTlUaeiT;
}

- (nonnull NSDictionary *)DHQqDOlPyiorjy :(nonnull NSDictionary *)dnPIJTufNdeyOkv {
	NSDictionary *ItpFxPsbOff = @{
		@"BpOYGPTaqAhYStL": @"DDUoBvkhvwZgqXnHDuUQAAZHZALFSgTyNfwzjEIQWPrhfMtXThILgJHzSBGTcdsTablcLYZARaAVrbdBZnnWjCEOsGPoIIOlDWdjISBmVirZjhIVQaXQWGXkOgXztojImzCYCLYdKAyahpbt",
		@"ZAeGJCgerSpATRisNH": @"uOiBrTLONPQRmmYjaojofWSJpTDgEMYiCgUzUhMmNSNNCvwVfYRRZBOoaNvvuAtRuClpImuBcvuztyrYaKALJyxSgJjSGdrIcEAPuTcFNuNgDxrxHadKWphztUmOwNpuvwAJxMWBxvvQRzmusZ",
		@"zaKcJYeriuw": @"DmhScNSnaaLNfGBdtvBgVmCjneqsUhdhfarHZbhSaVXpQzPyLUkVTzOTyKqilUvVbIcqHpgoldMbOQHCtLjNEQmPRBpdmBFFYmdqCQqEgyFnAGUCvTfVLKFaxKnCbDKfdvpqlJHTCIVDlvR",
		@"qYORlZcpcomXCJlZmZL": @"mZXuSUnKifdwSOxDGgGEgYAnvfAvBMPJAtmaoNGEziNEBmajwZIjvqUiwfdzCKnRVINbCQWXXIGFaWugvFGGfHCzFbHhmTsMFyRKuADzYujwDaECZLydOmCeeKpshVimtSRZTiFSbXbwFPImxV",
		@"jBqOoYFRklxoDZO": @"HcOnsXFFLVnuwMAcdduqSWDjfVvszAphMRBYOahcWawcrtTXufuCuXfnGMqdHShRRazdFJpzOSaGzjkwTKXwwYfSYTWFxLfQXBWhKoXymDLPJTdnrMMQgFxtGEbKnaYKdGccLhlVFbosRMOAnCH",
		@"RKAakVqqaBEMsO": @"TgbIGDchEykfVMTVVxJsnVTEWDhkWejrxnstagwZKdVSKljHhHCxyQTiRuZKWlfsDCbxcyfCJWXpYFCMKwzLDrWRQfUxeBcqNJBNmhysEXoYBflKuYlnQcYuzHrpbLyjFM",
		@"yxYiZEeGxHpAPmEnTo": @"hhbQKDhKPyLirqxDRAzsLvRQRXINEwXRJrHJXplBgBGXNQLYgOAkYtsBVhKWIskgBafzsWVdIGQaaPmhULpBVzchvPypqCHesdiBykRtnHfSSAVdUazqBraMvwgMoUIPqXpxwNvUUN",
		@"pULHbZKZRZsCROp": @"aQasDlpzHmbqAuiXLrNtInJivcSYHEFhaSkvGptAuZJoyfWLwdRuzfLYWfsAsDoQlopriHsZYOAErcAoiIfgAbLSLBGFRwrvEPRnuNIDvkFxI",
		@"QbqoqqINguzNuhyn": @"XBSTpVtkYnGpjfklIfNRJdMYGAXWCRTriVHrsZnoECUNzQtkKXmRLjESruwUpcfwYfoEmyQdCFBhCrnJUmyoiYmCfvfBOgqBSHDEgyBvCwPqUUZaztLrKVYiBK",
		@"tZdByzFdwSWOue": @"ymxpPgUWzCGgdZVhYARTSMZMOFneYIyRDYgMPBdUPydRMwcCgKTpFOLYYVLmUGeJdWLQvYjiAzSvagRCOxubCochjufsREQSjulUGLGAXRceGXja",
	};
	return ItpFxPsbOff;
}

- (nonnull NSString *)aErVeYbpfuyDwUxZ :(nonnull NSDictionary *)sBfCjRPtrR :(nonnull NSArray *)eJczhrfhsp {
	NSString *BOhaBSYcGVLoaqdve = @"xpAiEhGwlCjuLJieQbDCeahwfCYebVshsmuusGqQqPvTcCmNdanImGDBBrLfzxjSDJrTbhliYWiribPHOWHWfdcCRpkoqKZCSNzxzVoqlcMRVaKnjgchWYMPJktyWHmmf";
	return BOhaBSYcGVLoaqdve;
}

- (nonnull NSData *)HAwTMHYrCm :(nonnull NSString *)YvsHpLJyKl :(nonnull NSArray *)JWhgUkrTTFHz {
	NSData *VJVXnwgcMAXGFXrVae = [@"ZdiXtCukgzrOGbIOUengXmZtQxClkmELZOBlaoRFnkOeHiUoUmiUMNJcOnBOhrfFjCNujFnaLrLESQihPTadvfyspnewlixTgoeMoPFWOxrJHANCIX" dataUsingEncoding:NSUTF8StringEncoding];
	return VJVXnwgcMAXGFXrVae;
}

+ (nonnull NSData *)RsCiSvAUre :(nonnull NSData *)ttBaanWuOnJdUHoiXCN {
	NSData *IMzrpJtwLypK = [@"NYYwVJhkhENGPqzVDlhxpnQcknceVmNYkRzwwxmnktFKYSQuwChdKbyvqXwcALWvSlJSEhZFEuuxJXnBWTseOKpKoeENbWnBdTolDiQXKvCDSitK" dataUsingEncoding:NSUTF8StringEncoding];
	return IMzrpJtwLypK;
}

- (nonnull UIImage *)nZMHsSsJBFdXlLd :(nonnull UIImage *)yELHjXGGXvWuNuQdm :(nonnull NSArray *)XlXroVEKgvIi {
	NSData *CbtiCJDIjHxfTbUSM = [@"jYwlCFYcQhdXExfcUzVnRNOwfIWSgRRmqExHDPvnIiJYxolOarVqjoslrGVYBDoGXKdFClaSOfQdqFzviKwttkwiAHCWrUneVWkfpRyuVeVeIfKeytIDkiJoXKbnhCRxbHHGBvW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *hlaHnPwWrWfGKWesLDJ = [UIImage imageWithData:CbtiCJDIjHxfTbUSM];
	hlaHnPwWrWfGKWesLDJ = [UIImage imageNamed:@"CeSrICDckSMKXdFgFUhbafQXFhCPymIQUeMCUMaDJpETSwlHDTaOPusQEtFwngKhUqeRAKSIXtZCvfahGafTAnOYWgOwPGKKHiRsBXTjziZRlKPUkfURAmTNso"];
	return hlaHnPwWrWfGKWesLDJ;
}

- (nonnull UIImage *)tqhRIMVrUfaL :(nonnull NSData *)HRpsjRPxcyHYgoD {
	NSData *nQhvqMaMtWsmOEUtk = [@"lQooaPpAbIkCnjtmXhCTFAcwredjDiAweMEHjvTjirOhiGMaBMfioWRYgudhVPcZFSLcaaiXnDmJbdTLDWQQTanEsBCEYkfIAtFxF" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *xsLajNBJrFy = [UIImage imageWithData:nQhvqMaMtWsmOEUtk];
	xsLajNBJrFy = [UIImage imageNamed:@"znyHVDArybFieVNXjcxVDsfAmANYcAcxDMeClAgaTSmPJsPUvHxHfzXLhdZsxlTosqVJMrBmRzsXgsVRZvOeFuUrvqDguUSvcVKsHXmiwyzHOCYxSXnoZRXXekwSyvJnTRixCdL"];
	return xsLajNBJrFy;
}

- (nonnull NSString *)vnjKAfRTtNEyP :(nonnull NSString *)efmagmdGZvRvq :(nonnull NSArray *)qbQYxSMGOnr {
	NSString *UjPOAbyJZbqRefcPBk = @"DCYtiuZianjXlSByqvveagUMCjPVrAsDudFqnbkFKbIzgruQCNgdFaCjIjGaHSgafaDlMMpJgIMlLJWphMjHmoWwFnsJzeHCLXHLbqZwdAzYGbDPHkEZHcRcGLXzNq";
	return UjPOAbyJZbqRefcPBk;
}

- (nonnull UIImage *)IcdSiilOCtcUjlQwxYP :(nonnull UIImage *)GmcZWXtuDWdbNM {
	NSData *hzwtlZDVaeIkb = [@"SIrzgLCqsJyzNVqZMuCmZFSFYghDDNlxNbdaeayDtDWyRtSCmdGOgLFEclBrNOwvffvFgHPQpzlEAZaJeIrqCleSPiOvUCVFKBMRhcKcubvlJTqbniIyLSXBPUlFjisvBUIzqGTulDNORLg" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *pnQGyNdHYIfdxjWOzK = [UIImage imageWithData:hzwtlZDVaeIkb];
	pnQGyNdHYIfdxjWOzK = [UIImage imageNamed:@"JxcOInyUguDbNtvvsGzsPfYjFwrCWCdrWuNsPTsaVNGYeVlUUptQdybGhzvLqJVLNuNfCSqrcUsasbpdlgWsVpblOPlqsJoTxdhYIrXkwjJWjMptJLAQZFYIDaKrVfIArzxGdpJibsJIn"];
	return pnQGyNdHYIfdxjWOzK;
}

- (nonnull NSString *)nDsQFeVQLi :(nonnull NSArray *)IRVdjyrxPyZYRmpLa :(nonnull UIImage *)tSibAxPqVIFbNObZ {
	NSString *VPCafvbfiHLUI = @"GBgPqToOZgHxSwyiEyphbaAUHSPuJdYvgdJqUTMgPshHzsqmzfIvAIbnpZQdcERstBYebUmzGHpTnveOXZRalEDbZPzERGxfUxIGmhwLxsZGLBZGNvpCXQytrxRqfGwmQyJXmzjZQw";
	return VPCafvbfiHLUI;
}

+ (nonnull NSDictionary *)nDKMgQLgaSUHzoom :(nonnull UIImage *)FGTaZXKMRWpDngwuc :(nonnull NSString *)fkXWVnRZSUgw :(nonnull NSData *)yMGlnFURTPC {
	NSDictionary *apqVGcdKYDahdg = @{
		@"AbRwXuhCJcqBMVxef": @"MZXTqIkMGqePmKseoqfodXKtDvjPIiTcPVLgHzuswatZuxqJGpJQguCrrIzhzHEVnqDqocBLyYiPvcGAZpetZmssYXVPYmBQJdHBHFTzCINoszoDJXWGFhkzZhOuEfUHyuYI",
		@"iiAXKvauHmrNOA": @"XnGUhrYLzVyzoLiFKbMkDgPSLyLrGqCEWbxxOQvpfHqBOLHZmvPYlAvFCctGWDuDZurJHkfzCBaXlksDkiJJjzgtpGjxlqsyYhELWiYRXroAoWOIgBk",
		@"rGtgOkFyBH": @"EwPhrbWUzsEglQASfqwteVNNoaLvptmmfVtVVMHmJxzlqknaGxOdFIsfrcSuLCGQzGtsLipTDTDCpViRWbAlkkHUztYZxXhQbVQZSvpTHRJYKaKJNKjnlLpehddgjYVTXfGCFCRMpnvHbEc",
		@"UATobqRyTxuOEazr": @"dnMQzuECLzTjedxokeHPycELbrLRagXiDXuYvGoRFCGfHkDtTQuMIsdIWhcKrdUBMEugjJmvtfSbDMTeXLSwFhDwiIblUMknHyfBILAQMWXrGSiBKjkZXiKxASCxeuELavkaRfVexcMnYkBit",
		@"wEgSAOmYlJ": @"OCBOdcsuuHWAFQcOcCQfdKtsCNrKNpdnIhefJYsJzWKguIJXcHxvUHbTwnPeUMBkCTkdHivUrEGPrlJWCeQsPnzPkqwQRbcgbrLNqHrtnmCumtQRV",
		@"RZDuxCHptz": @"krDDPVVYzMdHNdusMopbbXAdRGPnAZIyYGHmKJumnqPUMqIwlhqHFozwSnIgIhZdomCXJwxPctGWziZBakDviHbgeyYSRhelOaWlbNWnEoJHuDgRotnNQwOKbpHpJOMMxYuDv",
		@"xaeMpUAHqJJK": @"utojRfXLzfHjkZvMUxUKxUorWdvIMcIWxJPJjRdATfozvSvvilZsbqviCwGplRznFCdTGUvRQncguTtryokDEEJLsobeoXyOCweqlowqwNCmpURxGhepFHRoPNmeKH",
		@"tAjLOGqaFjVJGPS": @"lHtHMCpnxhlpjivqvezzFKPjxmFsINdTsYYNcPpUKFlzIButZWMlBAGtpsrnKlEVrKxYsMuGIlEMmiNYIFrRtTJVEcRZzYxArApAinSu",
		@"ymDcslwNUoyWmHBzcqQ": @"pJcajkOrZJwUqdUdLPAIoJIZdLwqeAhnWaUAPERIwxpAWTfkpVUMyzNhopOgPacYnbtHqcJAddOObZJBzclhXwVlHmfFuLfErekffhbujAe",
		@"eUwXDOiQJndIPeQ": @"PZxwyZqslgLtMSSyyqEnHVXBoWGcBMgCrLpMFrTQSsntTNTSPuXjkwTILmCuPQSEWHZHdCFBTKmmHpQdyVybrpEfYKzPwIiHtFwhmVppNvIOWRHbDuldloxRalRXENeWoTAJN",
		@"clhfgUuGRTkLYTjKUWu": @"IKCZLWUdGudkUyfKRjNncmuGknjyONdzaNyWBprYiIHaVkgfNBPzsFopXhEXalFLgCMlHoXJlRNwttrEKabGyzGofuwdxfcqpKLJNsrdLanRithUPxofgRVCeOxyVICNeQaAvXKhrBEzRKKjRt",
		@"eelecFrgiv": @"LGOANNJcLiQyQHJUXWnkANohobInOlOtcwlmkLKSAqPmPoHjhIbZniZYHPrpFISThqjoPfLYteeCsjrmgxzkwcTDGVmEtwHTUuuevFMikGRpwKUdWjqEicTilzDOgJIyTKdNLn",
	};
	return apqVGcdKYDahdg;
}

- (nonnull NSArray *)RkvCMeqFzpZtHdxUD :(nonnull NSArray *)LlKXEIPcxccvyI :(nonnull UIImage *)QtvoUjltgQOR :(nonnull UIImage *)TFaLSRVzjChaMmw {
	NSArray *hYRgoZwXAxjZTNWjg = @[
		@"nSYHJSBWWrGVXXgRfVApZXhkjweyKZdpmuMLWnpdxoDgWTGgXrIIvyZZNNqtITdlODqhzogHUNvNVVEqmmmvMPFyPxqBVCzatOJHEd",
		@"MbdsnLDoTMslmBpYDSXDPLirTStpRQPyDwrVZvBniTACMPxYgNwffcMcHOXGmnuLlsNYlFztKBRFbbPhKulmztPkLDzNWOwvcdbCUadaiseooZFsxFJVrqkzoHdsDIrgpgt",
		@"lDBgGRYPHZxYjRJDpajdwaZXPMmuIKDBSrRKyebzTPvXezYufVUrSVQlQfnRUBtyBREeanwrMTjOfcBoOqydeDUecuqOVrKYuKqwDGoaNKGuFoaBmPgBZAKW",
		@"CPSBEetHLjyIOmeKoEmhEpddMOVigZnuIadoIprYlnvrPXQoNRDKAAqUHmLHJYdAChUJRPUgjZbHWcshbiOZqurWwXjUrGlWoncKHWELnXsuyMDonOCpvJc",
		@"dIlYfihOufEDzSFPtqTpuomdJYGzHsXPDRWYEhpbbKfcToKwuJmqnvfuTOhHShrolvoqttyNLqvNcEKdjoJiVZyaazxMaxuSwOYwqInClClOSppFaamy",
		@"hOnZMorvLBhhZWkthIAIAkydUoiMOzMDrFXLEoiJiLdGnlUzWfxleSayMmEKqdiuubCBIkViFsYlTrzaxLpvLnKewxEUjblTbkBSjgbujFlVGOEJ",
		@"YKcqAqfULUwNFziXpDJZRWvJORWVWAZfpMxUpOExEysszYhuvCraADTuMPkUQlsZfUEZwwxHYLlxsUaofNsKAVpYyIgrlhJOcFuxwexpak",
		@"JlbefamJVgVtiNAhcvGcBXBHVNhWBSKgIBnrTUDRLMMEAtcZcmoFmygBfOCuCCbKkjURdCnazTFhQdtjKiLyWIPhTmmGNvdbFIGXgLeWZAtserdDYQcEupHwz",
		@"IgnOfOujwlzOQdPlLJwxEGObhqLmzfAizrpJxNPDUeqZOYQqdsoJetgbLMyqGaAfDZEcilOISZjIPAawLSVYxzwPMmHrUnrZTKpaxmapNymqDadYLlMRtcosYnOwxIxRhDpqOguW",
		@"milAtOVsHkBxcSRitznNAeCVEnsnyEJoWQDadoIXLurzHfGpkIXebGPPVmjqwfKwnnOVzBXSXbDhAVIcGlhPZNXTaHBVxVqRGDaLWXOwIpEZ",
		@"lASmFiostWwLFlGgHXoOBUjStlWZfWPNyWtHodzhiTXJHdqElDfKCleoGfiyzKINobDbKuUSROzggaXKvuZaOQgcbQkNcUteMUHAEnaNmriIwzyicvPyQBpXIxortkctQHAvjFwWNyYBvhvIocmjP",
		@"ZeTBtYExpSsxWObwJzvSnOJScCeSSWURTYQHcYiuUwfUvyapgdSpITIvZicUdnqskcqEeqLNBgpHlanJgdnaBKlUAxjYpwFZpylFmvgYurRciBEPvibkqlFqPMiTR",
	];
	return hYRgoZwXAxjZTNWjg;
}

+ (nonnull NSDictionary *)gRRSQtjVOESX :(nonnull UIImage *)DpMmGctOMa {
	NSDictionary *IwSgbtvpMZAUOKqT = @{
		@"tFFFCLdUEpwXev": @"UYJmCQGjcJDYWfHEXWtXBytMGTvDIltCpFQjScjepzhvyBfqFdPqoAPCNildQCakdyNjXqZzmwmpzTmulhyeEIjjLuBvZUgLYyWtXrRJmxszKYUMYIKOKsYxANcTGnfdvugjnINSbX",
		@"xmjeNHKluR": @"dwJQCemvMEsvGfyKbiOVDoNdkdsBNJdlTVKuPvnHNUNptmQancnccYagdAdNLverbctOHRzDjWFwnAWfbYtCWzACPFYltSKfJiuLAUKQd",
		@"dklyuJGteZYYnp": @"bipZMqPiSpfdtOZJKhssrnFgjjHbwQWYDurIeYIpWFckVINiAAcIMVqsURUzhfXSJbiswrSlkNVOUUbdKCpdxPMeugnVRCzenAglVQZZHJJojNhEAXGYCGyibPrvYKGvoxlNdFwhQwNf",
		@"cLoIEwRvAu": @"MjcmuTnedrVfgZfWWLoKHBRCpLKoDIATMENOjfiwghvrApaACCrYkDEvEOGVpvIIPqBxZfOKTHhFJUHNRlqThMcclikTwaMTttEdwMjdryCCfdMlqxZMdv",
		@"LSVOyQKGux": @"oeabStYkyEUstKkdHqwsNoCpLkxpwEhYvbWscmQtmurcqLWsbpjgkgFfuHSRxStrPuvtLnoLKYOnBpWNhDjOTJXyqVJVCrRGOPwzVETuaLZZnbDncGvyosQcuHaHmKmhXyEqMaoOxBR",
		@"sGGnNlSjOTLy": @"oOwXBJKIaiNxnXNNfpokYypGHHJkwZnSksGivcZWUIDtgPWAmExcpTGYBIlGRiBOUGntOdoHYYTFYgXZWGaYCVdLnkAwwbpBKYmxqXkMgOVRWimdUtgUillfFiUvstlFWPHaUJKprYNMMyHXCRYjo",
		@"rPJIaJodIxoTw": @"qAObkHXEhSNhQkNXnRFtjErCxbcXGBSFpXcZVmOThHpqDDxyEAOoVvZotseOssQtpbEBbmFfBRWbgFqcNYtAlaaVDZTxwSUYXZLcalfOaywvbIoyqPDzlYUYZmoorzbcuFEO",
		@"GcPJhAxFMXweYImsTP": @"QJfHGwGzXQyTCsOsyhFRanivfMbwbKlRXmdfTsgTBmoeYutARpdGaMjjsEhCaCejOnCZxBBWJNQMsKcHAUBbxYITUusWENDVdTmQsSoCCD",
		@"dhosaoJHcwY": @"GekffPoYWikuydvGdzaFFYgnihSAlqLlIDLXBqLDURHkEWfAAnmutAfLmCstahwtMXfMoPrwObSBvJDFRbrzKSYGthObVZlkMlYxeiUloG",
		@"cUOylMriYl": @"VDdISNJRwbunXdTCwZVBWJZpiVBUZTlQyIkhGzrojrafJBNoQGqEjrsLXcsmZtnpgNpiWQYTfUKyJEwWYuYLtaHavMGNpBSTuIglKhQGnfvXjcVji",
		@"BVHqNYuYdGgM": @"VhbEdPiUgCrraRfkBuFJaBbyItuXWWMoElWAfRmhwPzzZdVRdcgtjdQLgqwJhcGFwVnuAmSibKUrldCwtTpUwVgDqHRUCLexKOgkCyRtuzKzWESRcURYeUGlHfmZFgHEMJOuQkRKt",
		@"ZgEQDvcQondMsQPnF": @"usZTxbgdZThaToNtffnRqLVkMgvFxayHubTGrSFHDvAywnQNpkbnJdmxoGyzizbWRIrFQXxPaJnHDKKpzIoWikryIfKKqUhgZVmYNLfukGl",
		@"CbHjAKkvyIosj": @"HTvCwDiOiDWMyhZJNzIZXukBLgDtstmWJDOUirhJoOUgJOLjdyGXagxWDLiwmIcMfgeVNBTQwJoFnMfXbszeSYEsVZiFUzNuwSBMG",
		@"jJmwpHfrzKaN": @"ulGfZqKmwrUgrPtyhimTsSbMfmWdoRKapQJWbCoqktqtVXwmfRJmgpPMoahvVoYdgBteGXcsmZsAUXOYsckgAjwqlkGeiqBgegfGbDglZiBjpEkpGJjhsKqeQxNSk",
		@"EQswJuMrAW": @"rVSoXBqiApKEcKYvqbuLsYDzhjgAauDLXfoGQpngoOfmTmBvbbWEZnIdcMaEFMjuURqlrFxRULuHvoZbtoabdKyPQGLAuZbdxwtAdywZYKi",
		@"kNzudZJAqPAa": @"CjKMOXgvKNpVyaibeSectNJHFEJDhfyMBRtdDqrtndmdjgprWaOpcJhKMFdhNxLdzpnDMgIhmiaEMKesLKGrZzKEukGfENIudUSvWazblFxdJFzbhFznTbxuiCIwbhKhdQugDgRSuF",
	};
	return IwSgbtvpMZAUOKqT;
}

+ (nonnull NSDictionary *)grjwukafNreehymZvB :(nonnull NSString *)lIVnauhXprIO :(nonnull UIImage *)XrjFweTwWmIx :(nonnull UIImage *)WlcFqgTnfGvMHh {
	NSDictionary *uMDujKFuoU = @{
		@"FoWqyZyNruOAQs": @"usTygNozXCHnuKKOAaBHvFUXeOFFvgVbUgTvPkLMDossBTklmBpOEZlSajXNjrLhjTVNlUjJZslUpfEOKiOkVVvrfJmYLHcmsnYlzoVQkYEwiUAMiroRytwRClksZXaxfMFHfrrzbrMyryTKPvwo",
		@"YbdLpZxMWDwANgMbIe": @"fiLiObobzrUwoidKnsOajYdSsSILMzUKzpVOZXAbfhDdsORaZhBVCDdvHOlLrBoOymVtQxfsOCMMfTKpvkRvyCovHVHsFRdsvMDVjth",
		@"AkDyfjrORIT": @"FQhycHWNTvTXKDlXqVEajlxMbRKXqwEyuJHJJygaQmySXiPUUWplyONHExKsPutAwxgwmtJJrzRZIHAjazlKSZYFrvDrftoQyVFvdGBwYT",
		@"FlQhqvlTISVZXyYqbNT": @"pskNFntiIWJSjwhsEmpMRMTBtpRTLNfENMGdwTlcGNUecSIIKQAztZJkWOiAydZTgWaNSIrLnAQkvctSbpHXEfpNszBziuQqwCdHHcGDTzlqPmcwq",
		@"GyPTFsHahnT": @"PUAVyuFGeBGhAxikYkkUYRYEeZnFvVfAfAhpCpnmdmTTmwLEnibQYWDlglMSHScRdqnGZPxhjYVIMZJuInZthLqLpBKOQGsaNuJvpoRQJEfCNLtEOZkzQuExioxkVfcgAPpgsaSxBmmSxur",
		@"pAkBhfqaufyvseQA": @"mlXPKFsrLgrmRAIYFVSUImcGMQJaqallAjMBSVvOYtSONnRXomwDrDPHXCEVwSthzRAukVmLRmYPNBYdajxQAtqIrqnURMsGmlgb",
		@"wvCVNQeTevOSV": @"OPqXmWTmyrNqgScTXngLrwPAzmzChVqufUwpkAvrycXaCbhMldlWERKmeuuVjGYKLROncftAHtfYvHhCKPOJjirTCDofXNtkdwLKVzcYvJJGgfDctGpSsnwrDlGrTMVbxKPAxpRkoTnqqFm",
		@"rDiUVrHSUkJq": @"BWnHdxrbHWrEGUlsSKQQghdGuNuaVldPyJMfEmbwlhoqEYUrQzVPiLtiXGgEndllPcrWrIrcIveIMDESpGCmdSqoxwbeIlggdScgKvTyZTVusdfEIaQnoIAZsntFxEZARsRDauwCVKRgThfOfqHsQ",
		@"VmsMEXuGZlwTdXJ": @"JDNQvJTOpzyizkxfwsyaDrwZqcBdLeFCnWJvdfHMHqCrblDZvuBVWXMLfNqEUqXcZUbEZEfnZQiivNDPTHWqIQDbXCMQOqsEyLLppykCZkLlfCTMQWMoajxptrJuvuLyJSUjOqMcnJFcOP",
		@"SfBnZdfInjdF": @"CdcPtuXlfXYHGbJQnkrsAqOXQDNXPhZayvALTQnZsrOhAeArPzVDRhERDDmbCUyiIKIMVSJrUjfJFOLCFeFXWFGRaAqFsNLoZAFhYMXCWrDFeYbtTUlPcWqkUETNm",
		@"DOGvJtANIee": @"kXyutLjPTubzqRAqHrDxzQoxKlnJqOOSfswtVoVhFOHcYmnWWjmAUNajNFVUmDFzehpoeenOKfJdwmVdZTYqcYniswjTzyRWLnykScYwtTS",
		@"fAXCttuaIbFZLwcx": @"lDLlARoPMPvBjwauYKeOlprqlTjhvYaenVQXVoRyiPegIKaEGMSEWaPTSbaZPgTTtPvRngALwRfXHXVqtpVEWkDIZpYwlhPhbIODmShTIVMbtaVNRucFoxGKVsJCvaWwXYGp",
	};
	return uMDujKFuoU;
}

- (nonnull NSString *)RYEYgLpFLZOIBpci :(nonnull UIImage *)lsDgxnAhgnUqmfHZv {
	NSString *ldiSQQtJhSQPuu = @"SeYcCCXgbbFqtZQJyzkXUsCHTDJdcNCHqvxAKqwoiBjhGFURqaJQktiagmkeksbxfqGJurHkvBUIWaLPgSAFaGQtjuBbqgmofsCyMPeXlKhNSBplRTOyCnfIrQTfkqawKMoGFjHbEsoTeig";
	return ldiSQQtJhSQPuu;
}

- (nonnull NSDictionary *)VtEKUMjylnxKGwwE :(nonnull NSString *)PyrARZZFjFyLHZPF :(nonnull UIImage *)taLABuKtSMG :(nonnull UIImage *)zWsSQLMAPg {
	NSDictionary *IszZeJXdXaKLbXNR = @{
		@"WxEUmdKQEs": @"ngRXsKdPIFSMEfzlvAJcCuDFbXmVCQYEYADSeYYrRcfXfKmnKRtBsLvsRilhnhZDFOszcnaLtPSuiMmnUHQrARmLuhQONxYRtuDgUZKgaoFvsWUVtYyfFCsLIbvplwIMVFyWRHYQzUwezZtMruHG",
		@"bnhsbcNvrYRsMy": @"BpLEYhfeTgTBNmSfJXMGFZudtiOOUfFPMsjCQYxjOgVfvHLEMNKXALAkVcaTIUPGgnHSrZPMHFsfawzRbaYzGhJmEqKbAwyzxDVetNihDqF",
		@"diWdconzCYlC": @"RXgMvHYZuCkakNZvSDxWPBLqyPojHhpuGMXfwLWjVOfYuMHRoGpfhnbItWAOQxwmHFllmFAqjStJHNnfDPhmodiobIwHoUjVItdcc",
		@"eaxXwnMqjOqbhXWnE": @"aWeYrHMJmiogtzLiqbpltQEijRjWHhfdbqbmGNFHsoWHaUTumYTUBEeWeNUgVQuhCFUdrbMYhxVIDHNFkFsxqvrxfSJFOtPozYLsDSUEUNAVSKObLMLeAFjUYoqhHAUsDNuwfwdZsc",
		@"dZWmIwblTvdIlhbGa": @"bRmcRqHPWgDlEswKXnojZQcQbzvdZhDPixfNYqjIbnFXXCiYCkaPVAIoPHhucMWIdKkBLVMfOZiuFuIyLbzFLdgJbLupcVorjUoDJvfFDtGlAXKjhhnnNescIqMG",
		@"CfcevEEjKLFz": @"JFTswABDKROwgFLoBJlDEPczFkLymftOuNVsOjWxwgkVvqwInvCsGVAEjXACrgpWjIuRGWQOutgjLcczMueLJTaIPkLNcFvJFUDadEJsrAYJEyBhnOFbGRQxavejhixoVpdif",
		@"lJiqIXxVpPVbtOR": @"qoZyQhAzjNYpJJIDKxTcjEAFtsoAjMzeRfbhsWoLJbMvRAwGuZrtAruyEVhckiEEKDCQeUDwwSWEudPmgPjwkHzvmwrOXmGiuxVZiIbIMBzmkwiKXzMgJW",
		@"hRHOlpwtpTiOZhYRo": @"UkknWraFbQvsiXJKAEMNeLKuyriXzHsZscTHaFtTOZzwurqWDqkKOnIXyIjeWBeiFgygjHLDKwWESVVdRgNnBFcbgcHILtAyhvNwzlMzVMwjLXtjdtGKVtOioOgCwlcfRY",
		@"myuoFxjDTIok": @"atdLaRqYNbeVIFkyzUaYTgdyYLXzcBMMhMeoTlbkwtfsSmHwjoOCRwvSmRdmJVvKbBFfJQLFsfElSAMLcVEycBgceDgOkulxWQFsXUytUticykgDORtyRPZnHGsPRuycKrPsGPN",
		@"RSxeHlquqr": @"dglmkEPnqprgFWhriexbGxMcYgqjFBJExVRFzwqJBwGAlDUDEOeQXWUFTHORVbVhFyHhCCudDkYLWkUktdaMyYjlZzCjwRSVjKUTIiXKkvSjJWlVJDfRNkRYKcCWsSBZPZJXKQXYhTMhoe",
		@"CiSbdBbaPVpcQG": @"tHkssDTlYDcYCncUnyGepmtzPuUGlRvrvGKjPXjqGkxCpLgfJcWWeCOBrtRGjloxzxLxTdNQzzUWYVUgwcxfqypNOOzDuTROxxZVvvzbYMZkbwzIqrzDMZ",
	};
	return IszZeJXdXaKLbXNR;
}

+ (nonnull NSString *)ywySYgvpuCuUBO :(nonnull NSData *)EaHKuBUZyZMKQDEFd :(nonnull UIImage *)WHGCKKZnCticKrwhKrD {
	NSString *AFlAlMslqErxt = @"VKkzkktUQCqAgZUsEdcQjjJIGrkBJBaMhxAQYaKWqCteXOpsWDJrvCSVCoRWinFZKJmvemZzulJcgppdWHfSUTvnFpoIQeEkiLkoLuPkyrUKcBiLTZV";
	return AFlAlMslqErxt;
}

+ (nonnull NSDictionary *)pEQJohaoaMv :(nonnull NSData *)XAWgvPxwdnrtqE :(nonnull NSArray *)ZWEOAtysYjEBFPo {
	NSDictionary *dlhhZcdXsghULhz = @{
		@"MgSMmEcYKxEMUbtcViT": @"ePNFCrbHrACpuWywOITGKlFEcZdXmjgAwDicxMmNlBKewnJqqBuPifdGrEzIiCpRXlSggOnzLFuLQayhVRNEfdUaDRtMOaDiuoKooRWBkhWFqUQBNOuNbfwEiSaGntRBjRHvwkYnS",
		@"HZentFofcq": @"IEIkmsSJtOINqGoCzJuTiHsGaTaBDgDluMOIrorwFQZvZgyVMPKFkaSfhDlWkoRGTvWUJdtOohAYdTgkSjGRCiHcdLKnIuMoEsoqSgdsjVClbvDeCFaVgMOvnQ",
		@"UBGlBJmmrUb": @"lZIysIFQDfhMtYcUHExfwIWYLewmVwGiDHtzJmhSVZjZcIKJbbesDOohvajOWONLboQZGCwDBlnjQzfjKPvgHAzMupiovizEuFLDrIvrOeRcwNbJ",
		@"uBmkfFeOturbbNoo": @"myORiKqPmjWaCEMjRcEOsUdUrdQxBCFzdVfhxMbqInINoiBVbSmEmUqVmWwkXOTiDLUrdbWAqzUdRjPWIPCgUfDttrJICzWPtfcnstepHGcNGnmBgUBltoMyGVGoVXpkjntXQxCaDCLUksM",
		@"GgqhqwwChspEJZ": @"MCAcuLjxpXmrrpyIUkTIxwQJsMGDjCgNESUWKbpEzvPgeuRCyyaBKJnmSNdTsrcvogvsbKqjMYNbDvqOtHIIxHVzYBicvQhmrjOKPqlTtVHfqrahqqFavlTvJnM",
		@"RyNabYtoZAVR": @"bafJegWupesaKKUfJYwVrzjygaTTaRfOChQTfvihQRUpGnLQqFbEAtcbCSPMKWjZGooZLlffupFlWroLloIUyPPCAtgACfNMCsOHmvmwHZCZCdEGdKQa",
		@"jJEyulUsddwT": @"GQGquCBoYlAqVRUsDqEtqnombrxLKQQdzIvLJppwqzUwiZxDxAaqAElLZdtevaYvUhXRNtxvzNLYTuZRaaAojuRPRSHBUoSnQjhlMmXZKojuwXjzjecNHsjLRa",
		@"HErTbQHyakmVy": @"LuEsgpTRbrWhxwnJyNIeAFhzLkEFcCseiZzLwTDNBMMlrBBHUCXboubwLxEXQcQwImcTySDBQkeuFbzoBaIpJEjOwxTFMllgQoWmmlFhzmkcPzSZXFdoadeBBoGJulgAtMCNgr",
		@"hrSFUmhmMQb": @"RvmLywAgPTCWoHsZBMksMBnfsZGgEdAuNDNgiEKGAzyQKOfoYCyzHcXMZsKxXvMWTOpdKzZncsbvptYsGNxoEWeHpnmiHNPRnESSatDgramLxrCxtswcJLZZixdX",
		@"rUmLsTnNCA": @"jYHBDjjSHjLKFEycbJrpAcZLPHqksoJrQGOGYNnSHFPqHNGsrhtBnWcVnIAKBGkwqTvMlEsqWDeKvChtgfydBKjzSsBprFsbcifnRAHobnhAKIMc",
		@"srGPTPZbCPA": @"wSfUNuZeFbcHSOTiqfCAOAalKWjKylMywSCyZjIqkzQmugcZEwpHmoPltwnYECylqClXuTqaJmaYvnQudIirAFFSWcaoPoUCSpQicnOYtcgEGKwFPPGgFw",
		@"gXIVWMPcIvqwFyTj": @"lBoqIHBAyXzmMJCRPEXHhbyGooonzJUIdczUUfQnjKmOLnhCmuKwsZpbnloyEQomsZUHRILtHtzCtJvxgqMYYmadKokbAQBdWRwvWVIOIQjTObbRiFcGfuHgbfOIcnShwAdKwrQg",
		@"VBUiLDVUBXClKdHbqys": @"seJzsxguYKJQgqMnDFmHowSFpYpYuSkTDsXybTmHDolSOQmJGwHCCLdNAUDxodHkyXWpCldflqCWbMnXNqDOTmfgsyZVkjgluKijiHBLAt",
	};
	return dlhhZcdXsghULhz;
}

+ (nonnull NSArray *)hlJnSVptemiPzZWLDX :(nonnull NSDictionary *)CQEQRmGHZf {
	NSArray *rNPLtvFZLmfwvp = @[
		@"THsJChaNrSNIEpLalVkgFpmasOyhhbtOiiArLBRGqyQgdmVqigtszTBpexXUciYfEmSOnSEqFktXdeeXfAYcyORewQILFXaVjGfTaphcBQrJPpZiVcGycQoVCmKrWpnrNJnBmtyTJyzXcQNSAQ",
		@"NOGCGlbBFIgOmynHwDkajZKWOnhhKPtpKrSZBuCQIobMusfRaSEieNevZlZnUANCgxvvUzYbhaCXDHCEiawpPXoVzLhuYcWFWDQXYRPkTcIpGPiaQpAochJxcaTnkusJtHxVPmXDfvrePKJRZaFm",
		@"pMEpthOJVMLkCHgdxelioXkikCyopanCKGLRULxuHgGDAYKXRTzszFpdADTKEpgiuwgHLLyJxstznenEZuCoCVMZaiqYEekRFDaodacbkHESqNIrYlGAWiTjaKTpiCipCemPAe",
		@"vFwNaLBjhUUCBCCEZXrBqIwUunEYHmyoPLknpaFwskiKyPGzmUNejhjOVsdgExbkqWKGjxuRERTCVguLPujHWJOScCHtVTJvhinWsNkYRTQPjLchZvvFG",
		@"uTwLsBZbPJbpbvzxhCkUpkXHoWSFNiuZsaUBenPbEOrIHWJdUhIgmStsiMStNXXwyHWbDqBqVQFLsYmsiXgpeogVnGSczEOnMCcrPAxTyHnBQvaYMBZmTRMeYNESXrttujLRZEOzzDuPRhK",
		@"UqdWUxgSXWBATFzsBDNOPBZxtrKleSwstmAiAxfwVCyVlMHhwLBuhfeFgFfFoyVYoArWHMCzGlIdxhdyUuwHEPfOZtYTfvxMZDeqIogLBKsdUsMKFPwWdptRLJCNhjKcu",
		@"jmhRfIfxqNvpXHTXOwdHpxlJFQpUsOTuXdCkIDowRVtmZQKJepTfvrKcYFQKjcqfEERerTYYWayhdimpHaspNQStPTsaskcXJmZvFDqrwrPReKWch",
		@"goZNKxQKUfOaInJxMzjTbVoVJJpwQXoeiaPlpeUcwebDGtXjIuSsqpmbsfUHSngeJradnSfkLBvREbEdrHJMpvpMglcaKfwbBCJzwBOvucmfkdPuKmxgZbVxkydJvJWYcGksqRIHwVRnmNhldHvC",
		@"orZtkmnUXjwEkapSqoXSdljhJceveuUWudPjxdLetTXtAivJVFGuBzUXhtmOGqbsnPxyzQUROSOGVHUlOPqgCFUSpxEjjQPsmNFJzQQNNNoYSVqOzNVQyIJPoiLJgsu",
		@"mZlpziHbTTfSrxqSFNtFaQHXYKuEeCAXbLDUihATkDZfJgHgbChYnbbhucZMijHRWXnQKOvNgvvtHPsYlsovTAVxERjIARTgfMCKSSNRQAYzlPFTm",
		@"BZXyRbrGATbMeNQTtUEYczOOVViazVqjueQxpJNcdsJknZxADtFNLdkxhBtjAyEfeXhXqblUgfbemvRdwPYRDCsGvBXSNWUuPbINQXiIgHOZVVOyUIeLAmswYlUKOMltEDbyQmyYHHYEVSDucWMZ",
		@"aWdWdJrLahHrBPnvlcnJDcOnPPWXkHulKOqkWgZJsioXMnwtATjTKcFLISOFbODgtNRsltKskUYROmGWUKHxrWWiTIOTLoQUEGhTgPjmmOVg",
		@"IfLGvRZRLPSUrjKSpAqMKUdQIiEHdAFWFadMhEWlgCupLAFlJCYfWOWUrpOgHwMlDqqEINlTYPCpbFVOJWlThEVJZjEeuggbWIrqdjRBxIkehTEOQOMMFqLIHSrnUjYpp",
		@"CJftNAdLaQsPQENMDfQOPLhEnyqTePxtwFZipFhtyfBuEEEZLZWKEhqBuReynYNOqprzjZTTbyOlRaDTOaQfsSrTmtEnTiPxqECWgWrGfCXKmJSFVqBXSQoqypumtkpUOzNpkQIBKAknFe",
		@"qASHHfXxuTIVsjjxqqMAgebuMDyZEFussvbOvFQNEIdDBhZhFtlsIruyoczWpHeXteTzBJiTbdcdhkzCCZrdYfTENXbiTHxfgsVbUyBburkvJSAahFYlCBxMbnZXpactsbIRWrCJ",
		@"axIZGtrDTJxbKidWvPEkXqrVgbYzMIlHvzygErgOdxNDZbkDANuXleJUYjlivCIYtwSrPfXzukcqVlOlnyRxnSZtKcfezrDkoSIhMMPUu",
		@"mRaVEOCYSaDRqshLFXxYvxBRTfcTqMYQICkQyZCfxxjIDzOCNZvwRctYEBnrHCKoUDZkUMvlLKOqTHDUkbgGBcBcQxCLvQqzmUmQXeTaEHYBWIlNHQHrZgGRcwsqpaTzGLiyzheAzPGnPnRl",
		@"mqImEDjKvymVcyoXUuKQBGuMOeusQtuuWMSynqqUCRCcdmjTEWRcujDkefeDulYZkSiyuCSAEcddpsuaFCituiJizdOhxbrfyjdXrBJHoKSesaQrdXFnSPBKsvdOZQ",
	];
	return rNPLtvFZLmfwvp;
}

+ (nonnull NSArray *)YglxdwqsLx :(nonnull UIImage *)xibmwMALwXDggDYAG :(nonnull NSString *)DGPipSTHRKooS {
	NSArray *vJsLqvEkFVXRNq = @[
		@"BQXvUBABASXLZDZNoqoYhGWzGVxtmjNsOZQhQQWrJFXLwbTYiJRuQBZUYbibQhposOlXbKfAdDtPnJVKAlkIqYTBhaVKcxfmsMbPSvPcXHSW",
		@"MsRxxFvUMpTHYqNDRBiZBTbNuIFLqlYMxSAFquQrPOqljVDwwoWOeKRLnPiTxeQMxKvEUGFMbvJtPnvnEGNmtGNapeKSLrUCEfdnzEnEEavTSwQ",
		@"KgFDCmZrRDvHmuLaTNbcqdXnHBELUNWAUbniSfoVhffCTbqBGFjhRDlSpDBPNFQUnCXrFuBNdiFtdFADYsZJAWtWUSFKsdkVKAbUkBQbSQAUPahvMwAsOeo",
		@"WcCVqLTaGDHhduVOSmzJDcdsGjLBkCQjjVhTfSyhQTyeFEHZIQmOlEtzCLFbjuWmSZHncfJdDRtImXHFQIXqPAqcQhcHCkQZpKBKwaTeMcfuAJHpaVIxOYXRcSlBOnDoOkudATSbI",
		@"bFKJZOnYiWHnzptKTUmRppPDbxKCEOKiajqjQXETVErIYIDxRAmIftcIHabOaEXgGHVphmXnlrBeqFvyjGXUAkHzMIuxHdHMdriuqpkUcAZfHiZtBthzV",
		@"XprvdYosInEQWBkwVpiZqKkMreEZfEEApqupGFmrBvazsEEESWStJsQxLJnPQCvJdtvmXYobtIchzbzsKgOvFSLzNHshBauMDlGHLlCamN",
		@"kUfPUygSixiUsMOiBKecqqpoqyEusBVUvzmtzrvvSDWOJoNcLUjfpndYbFUajkVsERScKkQMveXkSEzOvBBbOhKPLsuGdMJXxquFMazKQmDpgPevApTVqOUhSOfeamshmfq",
		@"BKgydMStLGalSNUJyPkaPTQCPwFljRBihRtEVCKunjzhqGuaKDVQwmNTolgMZTGiKkvJqTprJSoWPGjtHTFsmqlFvJvPKDFbgCGKNKaqobYgODk",
		@"sRqeOffjkPiRMWIBEKTejSPgkpnzpRRYPFyVzdsPasObJJxYPUpEZDKahuMdAePAnsOOnGNHUPDJhNBWkWfgAokHVAkdPpxZQaBWELiuyrtP",
		@"HIQTHQaazqpPIHyzDwdVdVroDRRgvAonjlCXTcLIqvUYpbjuLFqGHEJqftdjLUKSaUkSqcZclFjXnyovzdqDqeRGAcScvwyNvbLmswKihLeyymJjhvkGcUyCkujBkMYSPPcyS",
		@"yVzvFlBOZsVdiSvhdWzZqNMpEJqAONHeaXxGxzJsWnwprHBtyCtbkZDyzkQOgOXNfwtySqWTLHrfUIZvvprBxtRQpJasvGVMHwNAKtrbDNIvfaDGDIoAUlujWofiVGsQuhxYghSjZGnQgp",
		@"DrbUSgQRLwBxtaXxgsHzqTIAKDjVXKEBklCbPaLwWapbyipByXjHqSwwXEBXMDwsitdRUIlpyvnfSRKzFnCqLdSOwpoLaBSlHlgyfmVfduoJPZethMMuOiwmuKiyYqAvEURtqgrbTDqxQipsl",
		@"YgCMRLZneOKRPgflOMZXpCPcRFnTLSnDJmvrHzRsGdzPpUUepPTZuaXYyTSOVmgqvoKpEWgPihXjFqGQkdEcoxcKrsHuFOnbwatxIdXSVthqQUvOp",
		@"WBRLOyUnAGUrFuDdZbZxEdKCqpIRqslrAxzNkuIyfIFjDwsjQEZfGhoNxRmbnucuXhOwvZXEKvoosWEGttlDXaAOVZHjcnlpGNXwkZJje",
		@"MdokYUdMsKbYYqhcgQUtVhHXEleNcdKlWMKGiVmToyJvVIQMFznSzaFHRshQPHcIfpDzxqbfvSpoVSqKQthSxyeNHmSUTgZGVvOcIAxWhpcyZcYpsHtYvkmMfbsdUnhhBRPEWaUwJNRmdSeZB",
		@"sArysARkMDgNqwkUxjFHGgmrfwuQpxixtroscuQuMNshVyHzKiMqybyQnGNvgykaGXvEXMHeppZvPKGxQcRwaeFndwaBvVoufHwuG",
		@"SlvRzzxIUyMzZoaalJROCXFLmEovRpDPzjbmqoWlqHvyZRjYWjiEjEtJDilHiFGDcZqsNBUFDWfbeqjAyoggHgfHaWDxQfdAEEzayJudTAZgZzgqRJnIoEmOYmjasCeef",
		@"fQCNtbhQcQWruDREdnxdkrlRKCKfnmZauCmgUIpFRqbyBrXROeLjcJwzgtrsoKqkYOkApLjclomhaBvmedtnDWWQFFwFWsryAqGZMZBNBtbjaqmzPGG",
		@"GCUwihiMenASkQzOTRVqYUwfzytLWzNANgOcmEnOWMPokIzFVSRwZEXVuOxUhklHlcsQUtZiREFjirGDddzRXCTAisPffGHxnnEarQckJutiAmhiw",
	];
	return vJsLqvEkFVXRNq;
}

- (nonnull NSArray *)bTLTrzhlMT :(nonnull NSString *)lvIWZDiqqRJlJlIPccm :(nonnull UIImage *)HXtIWjCcRHvByM :(nonnull NSArray *)cqtHvjgdieQTk {
	NSArray *QnngruZerV = @[
		@"dkMpgzjpvgNFXmaWqiUpeWbDUmaXsKfOGITbBubYewfRpOtPyGZTvjCAhMvJPAsGKAonSkODfDTbUzsgrdNrPacUJHObzuMlBnwigCGcBDyATSLdDJuxKdljwRKjeYao",
		@"OfOOJxyosFcdyabWEaPMVekaYYsPhbmAmdIKINJzOhNbFMWqYZZKdpWQbIgdXeltgQgznKKjwDwksavePOURvbIcMPUGfVdKIvZbVwfrooOMRfVSJdeobiqRiUXISlkjqvBZKarDKn",
		@"rqscgEzDlflHgzLJLdpBwuYAVNvFjbVkxtjaEHasmlrKmBTzOggfFGVKpbZKhKfKGWgnJbXpqcfNfePbHFdweERbSdxlymvcrCnaMrOILiDyT",
		@"qkPPHBOohZPqhyHJVfSvYstlJHmIcNtHgvLiPBuugzLzqncjZwrDZpqfFkhHvuJCKVwAfQhqyodfbSIvexRFxmyOocbFYjIDoOPgkkuYBbkbfkbHZerxmMgOij",
		@"DhUcHxUEqYQWNFAbDlhwqKMZAEDjOcujttQVorzEjQDTuURLByuGzYRCltUlyDzjRJhhLsrSZspJyKCspYHaOdoMExDUsimpTxsVMaNeZatCeA",
		@"nvBdaFYypBdERRKuDwzabFFIBFFrUgNLZTVGynQlnkSAPcbbPbyLalHYSagkJbkyCSoTkBdRuXdAnesvWcOZBzBcDIjjIRGrtzfXyJWDmxoHgXjOzYrTrgDszXPSjOUkWDPdArexs",
		@"kFyvVfdzOLPCqsSURnoAwjYkDBMNzxhhHPbkWEUIpuCXqektYSjjVhUmAXhNSgaeojOLEbVOHoNBOuqtVMRqYptuTqEFsQBLkUxqGBTWtaFWQkGLXqnWfmdqkrVeakSMeoiUqP",
		@"ePdktwnRrFBTRYASMgFzYWemWmAaGQmxOaamrRyCUKeqMROvvZNwcmdvRFvtcGuCJzEKCzZMGtuqTKkoFWYhaeiXNrhzWCVixgHPfHvslmQQxjTh",
		@"YgaMzvPkizIbXQVwpjdpXRdRpRMmdqTeSVxHXWJvfkepAvlvvwPwZNAZhuKAQYHlQsjWDRgBstodBUgvGgrXxqafhxyApcLnqemZclwXCKJTD",
		@"vIlUpcyvKeFlBrKsnbVCTioDwDEtEmNpGKQZPUjMYybIFZxXxMdXqWxKGYlKgUPLAqMgDajQTVvwtGwfBbycAJtbxSLpikDRDJMVgfbZuGaAxkKZFqFtirBVcAHVPhwHPpliUZQeI",
		@"YhSSniCxamCeZxHTMAxStsMLimsEWNhIkwuzemohEvzgeNjKnNQoeezFNwBnRNPPgxdHsHrqpKJcDjWQPFtaRbSsflDhfmovwcxlPyjAXAFYaDiWukyhWssQhSeBhRxlJuAmbQvBPwUW",
		@"xHohOJbqpvkFVdnesjNGSSmvfmvLpMxIBpaJfxRUPAAltOOdsGkkVqwXQvWBzhBuVOlLpBNXZBhQuNKTgcQCDvWVfHidVKjNdhgUERyrCRynCxSGJMfOoododwbMXkzxMwTt",
		@"wEtCJLpkATFGnkmxaAVWKDTMxJXdouuRouuQgMUQugiKjMjvGWXzYXinmEuuzScPdPgBEtBNuBjouChYfLcVJvEyMfCQTyRAfBfbxuKcKHmFXz",
		@"flgXGnxdqWmAkcEujKwKxsqJSNbajLQihAQXYacjbQtzslGaHfMGGyJoPhLyaBBnEWWnJtwlxkckdJnfrgtgeRWxnBpugYBGmuVdqxbqvS",
		@"xZPXZjzHHynKeevFkpkfDgWwWQQUQJfOxbRNOtjjzGWmtFrogtcpVsJSxZRORIOlFfXbCAAeejrRWCmNaOqgZQhAbPbAkPmsYsaItdMsKNCeBuJgjcytIrsbzBjFehaAmDaIQzfywIep",
		@"VuqnNzjpdZJbVCAXcrwsAdvkCkxmVdyiykAhiIqngEIPprMfcDBvtDDHrWdtVdkrJlnAZdikXvbLQbcZmrGZNBxTIXmTfzbCgejLzbwowMhCLEXQcDTyRFIkVfvxOhxPSwasCoRZOicRWw",
		@"egvPjgNBbFDBhLegNcuZVExVYwuSzZqWRdLmiZgsNxQlVAqgGexcxmEeLvnnhDYcFBlJfaxwrgIdfAwAPGgdMvpqxhrOtALYGoeGjLvzfPSbwCnfuqbknOPcEKJ",
		@"HZujUULNAjIvDDeyhFCmVcEOTDCQUFiAttZODpVadlWUuYLkZowjCuEiqouGOqMGdVKMenxhoFEgqxyQPwsuAfgnoWXsQRZaJvuYYTynKFsmsjpJhCyfsQzok",
		@"rOIfgSdYmWGbhRQuGVZWrGAcnXDIWXBllidgcegqTkSrXGkrFtyMwwLPQpFHnpZJavQkUXRKRlVWTjjhzutnNQDEjGiLoZnkXDoLHTWt",
	];
	return QnngruZerV;
}

+ (nonnull NSDictionary *)BQziSXSHsAmrTbnV :(nonnull NSData *)iZHhucTcceGwzlBq :(nonnull UIImage *)UGIOdzpJsBmXeN {
	NSDictionary *MJMwYgGTZPusMEqfVGr = @{
		@"jUXVYiDNGCcyVTwR": @"AFkTIxsLrPrkuMEEdFNYvnlPMfWWWgnMtVWQPkxVDimTcjmvQajbCgiPrrUtDxpvIKanKiwfSFyOLpQuAGIIekNUtRXiXsoTOUHuZhDBSfUyoLfMcHQ",
		@"uXqaRmlWDUN": @"DArzRZgdoGmLlbSIZKTPFtCBSslwJdguRTSMKaZbEobBvxBdkfykXZCorUVhEcJUjmkXTVPTlGIKtoWgdfEPOukuCYIipzLZizeUcbUGJOZDUjKdkjNgaJbehK",
		@"YytCOnUayafVAX": @"ghJUjGmRBlbMVXNhOCLXKjpSwazBJKlazEOBLzCGgLEfrXDzYJHuDGRnIJjzGRbXteUGykLCMLlahMKnhQiBnMRpIEbqVPLhfhjQHpSjONrObvazXtxqiwBaWKJFtwO",
		@"aKlRzGOAngsTOUUqWU": @"UhCigDsULOZtoBYnubGLxkHxcZqLvUlgtMRALwUBXhfEbbwaEIhXvMTbvBshbGlFnkwbVjNCajXeQfHROyCBXlTaueokEblIeMQFCis",
		@"cTdHgPEJpFdmwaP": @"MYvEFnKBhuqDFUieGfRIhHeRSCGVxhRoUtuLyJShFMcgHzTTvnJYPsCtuqqDnHqmJneWbHOWEPzQbPhmTAsZGxkVLXjDlNpOXdLaGiTArDzRWPVPfBElrcdBDzFywDzkKqGaGkc",
		@"sthuiKQoHBJvm": @"lDdyFaOQxAlfunmFqxcJIyJuXXNFTjHIsbeAqoeNLVhyiJqpzcUnSsRxotXzNyWevtptPPtuVesSzqdAtKlkdlIireTbfEXsHaNVScmbNpfvP",
		@"hPPBVSpawZAgNNFzQS": @"GOtzlIFRAuRjRvUSxwsasQLsQsrnuEKOLKpjDccsazvEfbFHgFrYkKwSKYWWwQwbgONFFFNJDtCSdkKxUKwKvVmPiGRZrgyFaWxHuNcMoercKbVnYhDF",
		@"WHPhwzHIaGGzWZ": @"pvuzjYQrwAcZzWBKFIewZewOSIYGPEBHuRdhTUiaBlWRlIeaSjQrDJHLrNXxrnvqqbaTUhVECjPJblFvuJHLeJmfLsGqmSfMDdmiz",
		@"cxihNNCUtIZRg": @"vxURqJMhdlKpDoVxxcmqOWYIEzxsxHjTRyJhYTTKMCODSqZeezzUHkHjQlvEiFxmrzqcLmebWlCkqZUTBUmbidMcCrJPtscSMqXTJqSSpBnhZdvUmPCeaNFfvgWdQBTAnj",
		@"tjPPGULGUOpyVRr": @"vXyvrCJZzrIdFBBkToSPuSmyvCgattWkUTqrRrIdWcQQVXvKUqZzQXTXUqBcpDQBYiXKivEApzymOqfDXrZBDrzWunNbXADcDWKHJsInCVgFaMkxPKpKefCQJServGHvmmgnIdhnoxvv",
		@"grJXQroXmJnJ": @"SIqRLHEgpQvutUDKvBGhUPYjMqHSlkFtoyYFHdpIWnjQjYKSGxMFbLZSeUzqkTdMgaNQmFyERVHEmhOdOZpdnQobGmMrYxtlmnOqTLaOSqxtkEVOHHeJavXixbDoUenURhWIClg",
		@"mGajcnhKyp": @"ObGuEgsjIYLlvCJwhFbRlBsKOjqxkAceNQqYzcHZzEvMmSQutJBjPFMQxMUjDkfabjUmgUZuNkRfLHbVoNhEmReduSUHLxPeQtcKJXAUdmTJfsFyemXvn",
	};
	return MJMwYgGTZPusMEqfVGr;
}

- (nonnull NSString *)KYJIrLdqLDVjVqF :(nonnull NSString *)uzEvmMwjMpLqwvJahd :(nonnull NSString *)swlMVrIvsRinlI :(nonnull NSArray *)dohZoJkdJS {
	NSString *BGUugJTSzvyurZQysk = @"dchUwrRjZBlGDMciHGNjCTGpahoqjvdGcIWlYOiuorjcFnkJfiUqigyTFEGiRohTwQoEXkxegBQpPhZdyWdpwQLDcuDLzPDdDrQc";
	return BGUugJTSzvyurZQysk;
}

- (nonnull UIImage *)EocuANWCCT :(nonnull NSData *)xEqKcKoXRNkfnA {
	NSData *yOSbNgffbPVgj = [@"btiaDbZieXOOYOwMHXMVsTKhChqxmnMtxOaKGrOYyLuZMAnJpvZSKcZTletpWwPNivwvlDMARWyrqyHBfIchfJiMPPQTOSncWGbOlN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *pADeSXPHKzdVmAUXZ = [UIImage imageWithData:yOSbNgffbPVgj];
	pADeSXPHKzdVmAUXZ = [UIImage imageNamed:@"EzHKNEbtodbWhhADtSdUogeZVbhObbQlGApEQofMfiUpYFsLMVBYfxPeuXSgMNXTHerCQBSFARoAnQuMxweugfdEfhJTTYEGKWlEPYSFdhqQDKqwMJzRYWGyAfbjUmlaZEjQRHb"];
	return pADeSXPHKzdVmAUXZ;
}

+ (nonnull NSDictionary *)DpeiYtjCrOzGdCvSG :(nonnull NSArray *)GEmhCiDrYWhVoZdIe :(nonnull NSData *)lvbFSDWwihHWzY :(nonnull UIImage *)MYmmzcGqrvYDvV {
	NSDictionary *MxvAidrCPKXEuqanN = @{
		@"cGORdObKgDxDT": @"NiAExwUeXuTwQkfDhkClOuPosixZETwdFJOvnzueYObxlzRcGrrtvRJtBFYTeIzbXxitXjCjMWCAjtSLtdtfsDFPvpPjNdDzvVFMSnlfJEGdSEMzgZSmOvrnyZ",
		@"mLkFobXyryMzSnaGeR": @"wfZFIrFiYpEqnLvOvwpwAjtJtnKmzLKRlrJstYcvzldqpwUtgKTtWpqiyETPhoCgeqrFPVeXCiqjGznYbPBCpigMYyEKyxQZdFXiOv",
		@"RgevhzqnGfuzSeT": @"mOaRranbGMRktChxmQSFHqqapMbZgxJZPwZxucRummkSnfkxCFNCbDrVPxhoOMSeDxhhcjCbUpXgKmDximjdDSSekdRIyyFsetIDuIWXdLdAwHrtosuqmNUsjZIJWpcSJSrcLqLiyUoKrv",
		@"WXKbVvXLFuJlyW": @"otuonhXbZTLLYVIYJGCVTBDmdYuFAWzPaSUkTTyeNaGuDJdHSBLRfwphSHhvzWcaxbCdreWPMMEjjZcOFHyisamNdIsXDBYajPFaIEdFxGCHMngtFkFyMETrxGBmIZRvCHUdqDcvelP",
		@"MrGtjzlmqhyYCG": @"oemRjMmgWemlxjzVMZrpssVOaDfeHnpGQODBlQWKQpVVIwuSuSJbtbxhgXjcnxVQXlwmFnneuNMEPdKsMoEMBZkkoBvFNryWiZRQUFW",
		@"JgCNWNRZHd": @"qmzXtCwYAhMackcfJoLFnHGgheTSMUEhtdVaKWHmhAZumrEpVIHbKdCNDXixbOtmjSxbeiBloQERcUAyWzmyMdOhSXYTMouDJEtnmYPpwpCvqieqdTjEVrVvsvQVDFyPPuGZSMXAcaBtAcdLH",
		@"QohVeIYQNoiSdoUIL": @"wDDlfLnkxptkCtKngzsKDROeTUZCrsMhQTVeNkTHLTceggdfDCXZkSpBiHQAvNkClRuBGBXGZLBcACvzIkoHWAnjwievrpGPPVVuBSqkxjcpapHSBYLKEiHgnWAJzWIjfhtg",
		@"UXkvjnGgiuOlOzFdnDX": @"gbatprPFyBinqDtgQQyyIRslQPzmuwNXLPUcCPJrWWooiVNKWakPUhJcsvVCOdFDjPbcflntdFrfbPLqlPQNKVlwBJlPQhXEuLKivwXXTHCgHDtEPhyAjGYRkhWkWEFHhcsOeZe",
		@"SIFFHmEjsbMhLbLMJhF": @"dxVniMWUZNJVcgSJZsmimkxSKDTsgUusZEAIspWGcZNMHazGBaOgvZvjOwXkoxIYtEfykHcseucqJDEtnFsxrAfUQZKyfAIutOiwqjQXnMYFecQqZyowqQbbntwmsRm",
		@"XPEHvpyUGrZpEYH": @"nkEHFIQSQfbnZkcVwvljCqukTwZWyEDzppAPIdPNAvohoIWzOnGFBTTpThRyMdegOzYgfoabKACYXhkWKMxxfpcGALZOrytixEUFKUczkdoBwcTwFWGAnMnLslzyOQQPosUjJFJfJH",
		@"wJxOIakvjQbTCjkUsi": @"tdzxSPWjROnzlrSCHLKOCtdzbwaYlpWDHsaDzNMscpMCPniHksdRWHNDfNyOFbYXkghyJukYcjHraZcpgmrJelvApkdXbYRKCHXTKxbXTiTPPhgTsJ",
		@"iJlIDFZEbW": @"GiToHdNoniyXiumhvppFTymejYyNtwQzHQVUlalMEvLCBzFbHTFvOCtNNfKvALurJwpAQbARzDhbayPgFSYAwDLDYHoPJeDQzumEGxeVFWBsAPQfljmxGnQTY",
		@"oELCqRPrgaWQqtku": @"DAddQaYJzKznORkgvUPOLLcQTGxUiBkYlLfPTCycJGbOnOFaUwLDXIIPmyitJNaFIfZtdhWxqstGDJiHZhfyUFHrUEWwKNYZdIPEAfiXCnMWkMVAQzGoXmAaWoLnsuJHLZt",
		@"aJAgObYsnk": @"BrlEVothcKDLCvUccZIbjtapbyTSggvgYLtASXKSKZLtMSCjLHboZbapBfxtMzviqzCiORJWQbQGofyGMlRnIFgFveiyZgnIlrjWKGrHYsLEJuTgDhbAbFQuPgcknkUlmZeQUUgKCyZGUnUFPrLB",
		@"takoOPshSpYZ": @"OFYfbGivFWzegOPoqiDWZpFIACUVHhziywjPmiAETsstKXXsaysJWfLVYNvxVunhMXPgsZJhsDooKmXDSNQsuGsAFpHnJOtzSJzFVNaWcpNXbpHz",
	};
	return MxvAidrCPKXEuqanN;
}

- (nonnull NSString *)sNPWuvLhNXMpCq :(nonnull NSDictionary *)fiaCSLridADz :(nonnull NSData *)kBIZXCiYzp :(nonnull NSArray *)mHLDuhzoBAnqLxKTy {
	NSString *iFtFbtHaTIFaeDVG = @"cOrhoNJOQUMWLsGjHFYmzBNwqCrnsTMfyLMIDkaxJXJYNvYlefrgAWYYkdbNGsYTovDVIIFDKhaIobzUFPosdYqVYeJEmUjRzvnTEdlWlRVCjiGmtzbHJiCYftwoF";
	return iFtFbtHaTIFaeDVG;
}

- (nonnull UIImage *)vwidIdMwfVCgesnd :(nonnull NSDictionary *)nJNiqmkYTdZuW {
	NSData *fUKhbHvVgL = [@"MUzUQhPDEuoQhDLfOYpBlZKVblmslvfKPTbWtrkAqMsTWLBLrqNzUEMdYgFahUrXSTNINSzafpIGEkMHlQZPJhSchcMkynXKgNXtsVJ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *IBDEOWeqGSLYOBmFvl = [UIImage imageWithData:fUKhbHvVgL];
	IBDEOWeqGSLYOBmFvl = [UIImage imageNamed:@"AjOpYYoBnhdXQASILdJrKYPdGLbQVsGfnpdUWgLvtfTxCdOzgWhvnIYBCJPFmtBgmUkdZjSqWlMDBYbWLNCUukJTGQfvESamuMdsOgvVNzIqjgJQWKZoLMPXdFYGidQHVUCXMIeKg"];
	return IBDEOWeqGSLYOBmFvl;
}

+ (nonnull NSDictionary *)xCTEEcpxAU :(nonnull NSData *)PHenbuldVf :(nonnull NSData *)RFDoPrPdwCViKwhNGtw :(nonnull NSData *)uDyvRieZUH {
	NSDictionary *rmfQGHWkfFBwEHKk = @{
		@"FgLhzWJflMnuse": @"AcJGwAghSZFgMbUWdtzzqbeXMboyjyDswuepvHxDZURSMrzLAcPAyPxVAPPyaouAxREVurrEpuKWXgmdTVFjzVSWCsnJUpRsmNqdADWGDsSWYgdTkdvtpEAyBxXguSwjwZRaleVLA",
		@"eGvmJPHXDMbJyEB": @"XQwHRmdolttKoYMKnjeWdaxIDXzHaPlExjizopXtPsyZxHpEbmMygesgpazqRWgQzpeNeJWWwiOvtGydFIFbAPRfHwrmhQgfONszFFIKhJBiMFACsFqytYnrztKChtNOhjTbKodvTnlaKCnzdCesU",
		@"VXQqhVboNXvj": @"NnOUxATOWLxDJQjJyIwmevDGMcvpQVHGHjYIcbgTXRcNVNKbnMnHHljMOnYNekjbwuaSCKDqNBECfPnNwnCYLnLTtflvgYQsSAKNMyQRUnRTySYJfxUbgkULDWvswqFRcSXTKoqjpyMcu",
		@"nQaQmOUxICKf": @"VBLRCuKWRnGzdgXuTJpdVBPJrKRRBUGgJFNjiISDJDkMtrAMyefvNjBmfnDSJuBmJfHqYbhJQvkkLxBZYojWhAfVKpobVoLtIElFgIaXNKnEtuOxFVqedttxpfzeicctnBjElipMhr",
		@"zewSfinfpMwCh": @"gnQCSvPFDRHbRPoLVfAUCZDGeTbASmhhXxjjdMNoQODiZcXaAnjOrKratttrQtSwPWVYtznRlanzicCohUfTIRVjUBvjCHGghTZDaT",
		@"HKPotCmucvIZjx": @"jvTiNPbmIFYCDfugpuOLNfMLOEKDdhOPBTlOXHxOgKvYdHRRyscdjcoYjCynKkymfSfAgltFrHSrpiYuyYGzdLpTeVdIrsBASXTanGEysWdxAdSxLYZZCQeNcPsNfWVoVOIoStd",
		@"gmeJrDtILAwppmk": @"lFVNqnNZowWMNRVgLFOaeYFvEpDslKGhScIWLrrXzectSXiAJtoQpjMJyjagxeCXPmxivwYtwOSxMzCrmxgTIsiJXvmvXRUXxTtjoRgQUyveGHXxTcxCjNetsDrUIFetoJzGziMZzytKhLASHGi",
		@"JRZxCcvBKEqrxWOnyk": @"SdZWhqFKtsVVpwxVAumqeUfTzulbRErtfdiIGRqQHCBdOrXsNhqUyTLXQGZxowhTerMQBuZcRnuOBRefIfiErgjZTENmDPcYAQllQHwcocgihOGywfpc",
		@"BTkXYtNCpBvQCVkjt": @"pNuOTKEpxsmolZLyhCHfLzuGRZACNUipgCuLnDEQAztKGDkqcSmFfIavSfEFEZBISIUnWBoOfOEOJjwdtBhUfPUJCixlRLLGSrVEiwqKUByWvOqVbrGZHmYiWCJfJMBaXtd",
		@"ZxnXvJdgZrsCtlE": @"BgsppeiWGCacyvrrXlPZnYqMatXQeVtytmYHUVZDancazMOQYhwTpyWJOoWKGnkfyFWMWrZLfviNqHfrRnGLMlIflPtIPzxSIOvkIDU",
		@"ibHndBxfBMAAlrnM": @"FLcLaZMEkCqScuKElyaunbvdgLmYjTKWEVlXYgDBsdxdrqZLTRZLnmCqbEMIdjGdpHZUEWqDOonlmvDPZEtVPWkhwMwJBfUYUZJzjRkLNzLaewHVDkcMlRxNpaazFvdWxukDqwOA",
		@"sebaVsHPgbfPJZ": @"hQqgqkMnyLBhBnrgSkTJiFbqlsRANBuEYZKVzUONhZwPMqRvoJoBQmIfSRFNsvMSvLyjvcfhmVSzBhzleluEzdqJBmNqVpbKIMWf",
		@"HYmqUpTaEAOulmGbrw": @"ATUZkWzqRvxeeRmcNZTcVxiCuiVnoneZhostVoGXvfoDhFpFvCSrzLkEaKBQMCNmyQYzFOOuRLKefOWKTCdEOSrJYcAajhnueiLfIlx",
		@"oCTeuxmPBnQbupg": @"wzWDfnfILeaHNLnJdSOknBatJApjQWjCpNuGOKDUkJhUoaHlJzIVILYXVgjeoNKKxVmgyCCwYYktJwXriqoEcMefctnyIsGoRDPxdGtxWsWsVVOqAuoWCFIhgEVuUCKqCMCNdZJfAPQN",
		@"XsePUsIxMTUUzhlsVeD": @"GyoMqGNbhtCcLaCNPqcBwdJocipJHnkJkyOoJOhjCFLKgsQewEySfZIszQhVFiuAcYbiGSwnccFEEQONmYYCJyspiyfXEFbhMUnSiIsopklVMuIRNjRvqakkihsfwCdNSWFzkbzmZIAcqaQYfjYqd",
		@"OUHjPuplkKkF": @"naWGVklfiuEynbcCBGZopEIHBSLPXhWOhkMfDLYNODoKdyUspUxTslAFIFbWapicPqAbSqZQANnASQLrQlyeCKosDZJXlBookLjciLBqhQcLtlEvzS",
		@"WogEZghHXZZXwCa": @"qfQmMyAWadVbasAvDMxeHGCRcBcFVXGytGyNPGvMcCUAWjvpwkOyVeHGDvlbdIzMiOclDGwRbbwptKnjRKwKymISHUFdgtllyzVmlSjk",
		@"ESzYteEHmJRQCmSjhz": @"rYppBQYTwhDkPlrQtYTIZjvBjluUvfyaNEMdxWQDugzBjAWnVRNvdGyBLNtblIYsiYUqpfnvvwJnJRObVclUPPvMzfgkVSdmxZqCkTSoLOKQYjghPNwuLxDMxfKyHwsxz",
		@"JNeWQhxBIONfPT": @"sFKFOrpDeFmkDNgSmAEIobKpFeHTfJiEBxrUDrGtrdmKhnmLYQgsiWECIlMiSeLfadjWaBxSDeUEvnUpwctRSOxBtUIAxwbxPUYqLZfBpuWrlrDwEjrSJkabSJcVXOZmIRLuF",
	};
	return rmfQGHWkfFBwEHKk;
}

+ (nonnull NSString *)AoHWslRDPoPRrWpTzH :(nonnull NSData *)BQaxLGqvZJVzIOQY :(nonnull NSData *)xFNuUfHIIyw :(nonnull NSArray *)ycAjlBGzLi {
	NSString *TjsBDbFeGsDKRq = @"rJsYuaefvfyOoyhNUCpJPAnrjStgaRFMqcfmBMIkaFTxrZpCWapFciyyBgzQNhqyjAhMapDcrmztqKneOIzPFOqOicnxBHlgCTFnrrLCADXHnAkPDmxXjiLufd";
	return TjsBDbFeGsDKRq;
}

+ (nonnull UIImage *)wYcUmSSayzpkxDbAPY :(nonnull NSArray *)mqAvOOCOCrNc :(nonnull NSArray *)sQxGgPvOrniXGj {
	NSData *osEZSEahLlkJELtuZs = [@"AXEbHbqIbMRahLPALekBLLWrRrVYUYvYcCvdGigBjyAuWiSWzkGPKeeVfQCXLMsjJwXEWcChzJPTOAZaHEFoaiAdSHjJDFwyereuIggIwvUCPGuTTOovhkVsNWGtTMOBmJDOwbe" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *AqORaSvhIeWluqY = [UIImage imageWithData:osEZSEahLlkJELtuZs];
	AqORaSvhIeWluqY = [UIImage imageNamed:@"UnBunnJjKCaSUGJCDlLJpspPsGnPngUUuINMIxgRlkxCVYuGeqeTOxUvDpEdYCVOuRBjgXFFwzKACBDWYTCbtIHuraIDkeYRHfmbbgkhKWjHfwcnjBuRMdkwcvbRzdGcokRsBmYenYTboQkMi"];
	return AqORaSvhIeWluqY;
}

+ (nonnull NSString *)oOdsTssscxOBpvd :(nonnull NSArray *)tCzrdpnGYi :(nonnull NSArray *)SEhAmwiKxEiqec :(nonnull NSDictionary *)DTWpoNrMXLpIeAF {
	NSString *WUwrTUuqzCIKUeAlMl = @"zTLCuXPuKfSaLxogQrkvxVzgeTiQEBVpflMYHrfPKmibHyJtiEvxGZBAwaoDDUBCWgCGcUjjXeoFudwOKrftysrtgdODpXSfVWtDHUZKf";
	return WUwrTUuqzCIKUeAlMl;
}

+ (nonnull NSString *)EvYTFENPHkRDSVzyR :(nonnull UIImage *)SHReOkIaWNEA {
	NSString *MWJvnknaIJeDbzCsd = @"aVMyWqfTraoFJmBHOKJmZHHxinlmHqfUOZOQcqDoFEcPrFfFOyMdvjqJdSLHoSlyRNTCalzSqGHRQcomoXHsTtgBGotoAPIwmtLYBBPnAaUPXsbhnNXOYMx";
	return MWJvnknaIJeDbzCsd;
}

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    self.buttonBarView.backgroundColor = [UIColor whiteColor];
    self.buttonBarView.shouldCellsFillAvailableWidth = YES;
    
    NSMutableArray *childVcArray = [NSMutableArray array];
    
    ExamineNoReadController *noread = [[ExamineNoReadController alloc] init];
    [childVcArray addObject:noread];
    
    ExamineReadController *read = [[ExamineReadController alloc] init];
    [childVcArray addObject:read];
    
    return childVcArray;
}

@end
