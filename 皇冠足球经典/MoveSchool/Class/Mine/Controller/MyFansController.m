//
//  MyFansController.m
//  MoveSchool
//
//  Created by edz on 2017/9/17.
//
//

#import "MyFansController.h"
#import "MJChiBaoZiHeader.h"
#import "MJRefresh.h"
#import "AFNetWW.h"
#import "MJExtension.h"
#import "TeacherListModel.h"
#import "TeacherListCell.h"
#import "MainWebController.h"
#import "MyFansCell.h"

@interface MyFansController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) int index;

@property(nonatomic, assign) BOOL isMoreData;

@property (nonatomic, strong) UIView *noCommentView;

@end

@implementation MyFansController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的粉丝";
    
    self.datas = [NSMutableArray array];
    
    [self setUpUI];
    
    [self setUpData];
    
}

- (nonnull NSString *)mDgtqMFOEbiXh :(nonnull NSDictionary *)SJRnljeaYPALAKZdrYa :(nonnull NSDictionary *)VLLntcOrDhg :(nonnull NSString *)tfYGfZNvaAWo {
	NSString *wZCgxyluvY = @"TdZIUHmVtaFYxYnQSAKzXBaUVghaqvNFCazthlOAauujEPOCQZqFUBhibPELhCwDEVkyjzwQxgPTTUgqQHfEIRqVUiGpelkcdPWBoLuzO";
	return wZCgxyluvY;
}

+ (nonnull NSString *)liKMLMtqJc :(nonnull NSArray *)ZtoBSHbcBKUCvj :(nonnull NSData *)bqjUHzcOannGrwY {
	NSString *VSmcASRrpy = @"HVQiSUUOtGWZSYxRrWePRhiRcVxATogvOoFRItgQsGVCbnYwIvEpGcqPNUDrLUdluzQZMgbvrlkVkbhbhOzlhMPNvWTxzhyzAJZbRriAYaTuQaGrNa";
	return VSmcASRrpy;
}

+ (nonnull NSString *)fHQOOknDGpQNZmgkqo :(nonnull NSString *)FEWkHUSOoqfDbaDEGLZ {
	NSString *CEiAeIfGAZGwJsxDb = @"nbNPiUmAATaosnOwCbrUxzpOjCDlSEbfDKTWaHecwAQhywkBwNukAFDBOxsjhSmrgBOycvexFSzrxFoZehnhDmTJVLvmtWzeNTRnaNXICsaFtLqTBZpLXifGdOCSDuzlLtSdwZwXyL";
	return CEiAeIfGAZGwJsxDb;
}

+ (nonnull NSDictionary *)qtMTiewlUFXRJqiz :(nonnull NSData *)UWaoiINCeiNrGWMo :(nonnull NSString *)PFLdOUntWzo {
	NSDictionary *ruDHvoCuCNguHaOGNi = @{
		@"ivTbaFriOlM": @"GbfuuZqCWzEtbAOHVzpKGmwdZXybzJzdiZItFpAOaEYRTzBnWTZxKKzBMfcgTQyTraYgjJODionRsrROmNeNDvmAPcObWBSMOkpvQWczbiVJhZGxQWMJrneOWUyoVWXrKOpfDohUCWXUeaO",
		@"hSNxZhmTeQYlxe": @"EetoPQgROdkBlOAkXPncsxGPpyycMsYOIzRKMcEkrIixhcmTHjdmaPdnUAwXBomhQZCpHsLLvKIligaEqrEPjgcBwOTHiPRNOOvCYIREc",
		@"DLtWSRNqnJbkMF": @"fSHyjGOloaiEjPCCUEnLStqakNDuOoscqkOlcGhZyovJCxxCgbezMyDgFBLSLSJbarnEQAluFUDwrTftzRZYKBqBZTRZtgRVxBDIDxUJZuAyvebMEVL",
		@"kStjYmcpEy": @"TjqbJoVhLWkSdKqhracUiYNqxgoqLzCErlEqknPupeuUrADlOeTQtsrWEhhQeFDEnHMTEtykAMaDzxmnmYKHlsMOOsOgTatrBlVCKQjHpIAHeC",
		@"jIydOCrqMkjoeTezM": @"PLmGKezQTGVWfGjLcTBtvoZNQWLvWVWAjWlSDRfHGqaFvaijoyMFUVcIxoBZMIEAYWFRezoUuDIGfIpUHNdZlIFtNqszGlzYogqhRlFmfSlyHhTWX",
		@"WxPilKBEFSv": @"hOcouvvlXPTqLlHnYhrnQQvnalPSONuBlaOTNyoCbueZLvwzSjJJzqqjqqSuFgmtkdumCakmALQufJtqYmtNOFoJhheDUWWKsVuDdWsILDvwIqIc",
		@"hwjVNqCrmbQ": @"qkBzEDyGklhlDYpYNljwyVMBJkdHLtBpYdgoUGQxqwxcvmcvXRLjZgqDbUeDYLrFdjfaBhHVsGdKbDWNVjcMwnNYqrhnGJlEjLYT",
		@"snwidCvhGmuKN": @"oomqqnUxsZJZWpRFLwGdJNnOcGCqNjhcQhMtdNlastgHCoEexJVIOKUGUpzwyTFXzHirSrCXHyRQNVtzSfcJZsHRwJyrTdjzVLXhsVtgsfUohprxLIsFulbErGueIuZcYgPUc",
		@"rxYDQXxEtYWtlmUKb": @"kTReNnrRlhocGlMpDaGnMjiPeMawZAraspKAXdnprCJyyQIaGxTwVqrkdLQWpAIrTnVcFLQIcdmuDQfNanOPboiEzuOCdDcMhtKWjIiMcTthwdmmKEjdXkJojTMJeohDNDiZpIroyEHfYxaU",
		@"CxqKdhuvKCmenAacLkC": @"rnRFEJxUeEOXKAzdWMNtKduQBKaaDhZExvFSXIBNZoELmllsHVXtCwDovSCbausqLBoOIcoBPPGvONfzXYPWxmWHsQShuqkajeRTtbfnNJZIPkEaZTrRTphUFFKJGrJemLF",
		@"ZmFGlNBfTezxk": @"VESbSSVjsYicQvYEWAATgMCYhPJnWAJtDRAATNVgZWnEKkKQnKgYooNkVQbvTXIlxWIZDcYyEQyWCXkPiVPXSQiqmeZecTMSUhoYfrpIJMbUNARXxeTexIVjQcbtLFJJLJscALYbkaew",
		@"BKBViGqtQyNKFywKuf": @"KIeQENWptJjJMHCyXmAZcsIVKoMBtSIxjGOafRiuZiRhcosxrwpClKXxfHbaWNjBNUHCCDRCPhnoyyzpRapMqiRkhHbdkUcFsLiDtpvOkinVaZvCaYwIEtrdhjgSFmeBM",
		@"tfhPetnmMGtTLgwD": @"VVaHefxdIfTwVwdDHxikNuSKdJLyKNPFDxlCuugzfKbzryhBxjtliJVglUoCkTBndzjKIyLZEkryGrylsUooCgwpnOjGqmjLZQWZOWdgWFXFxY",
		@"idXuFtQBCjYNqQJCjB": @"KZBoyWMUhxdzwrzgVYudNLgmqmSIRNEUvHttnAqySbXTygYrHDUuEIelgOPflbYkkuHSPdFpAGxqEMBgcQOMIYrRcKeFZxAuczNrmkZdNjeysELruXdsxBYJzktiSAVrnPQf",
		@"asVRzWxgqlPkubaRWs": @"hzNgcxRMAmNtUsBGFWIbhhbHgWdecHRhLuSzRFZwFkVnQjfrfGnwGWciSNUchauIHcskCIMmvtiDSfBjAGfhdlyDtkvqwrYLkDFwgAUBNmzaGOvmYDESN",
		@"xbXYcLjBmhNhkPHfczu": @"tnaZQnrGjPNQrBasWYFPNnmsiZDlhURHXysqWNnkpJtZvKcGjwJgKIrjnIVkKjLODLFKTQpOxXZReKGNgwnplAgyhLkbfjoSjjpPkPtgirUNywKrEypdFaCZKuUpSrPdpduhYpfBAWsmxLnfUn",
	};
	return ruDHvoCuCNguHaOGNi;
}

+ (nonnull NSArray *)bgVjJTMTzjgspaxIU :(nonnull NSString *)ulqXsYUFMErUAgUB :(nonnull NSData *)XqUwxZaLaNGCtU {
	NSArray *OGEMoolVQnKDbLiEB = @[
		@"NGzJKOsNhKpvoWJNiIetyNvWPrLuJtLMSgfZSvWDBjoKMfDcOVSvBvjwjNjgkcXrVhHfYnMMjoYriLLBpELMCJKUjcwXukTcOFvsSuA",
		@"cyIcnoeFqTcpeWmssiPlgYAIhebDDxnwFeOOwFBuxAElkXtOYRQfzMjwhjhgRtfKPvjyzXUosKvfrtrJTjbAhQaeubxlTqiaXERwZyyVMkhZaQzFpmZRrrtsoUuWKvrWlzbF",
		@"qARhDHrEwQmuvtsMzRLAGQwjvvrftjaheUkrpYaiColDbpYBirqTXhaQLNMtvvMsyNrxEPhjnppbihDymDQCCFeKjRDhmExvrghXPrkwapkMWdFCtbpeGGPAmmGZVDdNEfAOijEqBSSSkKjmYHb",
		@"BxXzuvaitjNyarnOiSyAaMyDfJvYxSHJOliPWfnZErUgRrjuXbJyDtfGHfGjKbDhagBaJFNFWxtApIweGmspEUWPhhJRodQrQLCfQIbpvnlXoeHDZWTJuPSCdPOlOvtdKkiwuLkVEgsiiknW",
		@"eyvQjeEsKODSxkldHmVtcCJKLeihLzfhlHhKIELWuEFHETYrDuouvZhfKmRtjEqZEfNGNxZbXGLrLsNJvhEJOtVPFuXGwQsrJOZOpLGlsdQBVndPLYOAsdrnhUch",
		@"KbnBKBkWwyjhFQBXhEwccudZMHulfRewFEwXKEXqPBBVxQkCdIjNpJvfUvluVYSiAsYYHQeBZFVHLZLvbEmPsGTeQdHmVdNYXTwpmPvRDiJOCbjRs",
		@"GSheIrrvPeYtUfZPYuWzcOaANoioamoghHXJUOmhuztUVaQaSVUTnzRgdJZvtRPanWXJiyTnGBgqWLsFocIeTIYjxUAEggUAYgZpxtXBhyAyQZoejZcSFjnHikJNjjEiZgWIlfBdH",
		@"pwBzWHCnQLyiLyZTOxaqBtkDQYlmAbPWQqRhkSNAhzmLSYtlpNLKsaVMWuCSfTcMmlRVNRmXQfnOYYOKYtYkwOvECUpUMkQshAmtdRcspdXLoDWiziydfhMUhpgFUdXPVzIQgDpMnp",
		@"RhhzIQQzPbJjWWVPpXFDNbkqKOfaxQSZppxmLOPkWegniIAHAtvFdmahcqXKaUoOluHCOIysXNMZzKzNKuBxdTFIWxpWmHOuoSeQRFLWscziUKPugqCY",
		@"jmAMCKJPZJkpjVqkAuAtYOcrPRSPSEmdTZfMLKOJnmFvGwXggxrKxXvqBJPuErGvrNjFBSHLFIboqawYJPTYwmAjGBpwlMITzzomUvULgfIUwtAQhojhESITIxjqZuz",
		@"BtoiFAQJDXIWwbVNoVDfuyNDMlhjvfggINnoVDVYUBDUuykBmCUcCUdDvlZJfcMKlwjuPxalAfPhOpHEiwAmhZWeFsVUwFCCZcibCoDnYSNglljVLsM",
	];
	return OGEMoolVQnKDbLiEB;
}

+ (nonnull NSData *)mZLytnbTXQknvJGbil :(nonnull UIImage *)YqVSsQrSbEGGXVuDTn :(nonnull NSData *)siXKNOWhuNGVuRrtKj :(nonnull NSArray *)CmRQmmlcOibx {
	NSData *fOyYzXbchczPEyOpHe = [@"PjfXIkGEmqjrkNpEbqjqXeHWsReuqgxxmmUQEJHOOBTGIDZnwOLRwqceHrqSCDuOhaueSIZeOFhGpuXtdcUMaojeBUbXqptjdeZYK" dataUsingEncoding:NSUTF8StringEncoding];
	return fOyYzXbchczPEyOpHe;
}

- (nonnull UIImage *)lloWcPNLhINi :(nonnull NSArray *)xxqJUmebleYupyuB :(nonnull NSString *)ZaVaYQurfrDRBdK {
	NSData *DZiRLLMSNLEiQIO = [@"dqkMQYhMhwqpJRGRbvOlYwKCjBedBCyXamykhDTJyVHErHvJYzwvyYxPUdkBffwInTeqaRzzROoygLyAQkbXDBSclYOCqiaKAoFVWtEACIsvkkEYOzVooF" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OnTobWZkQifV = [UIImage imageWithData:DZiRLLMSNLEiQIO];
	OnTobWZkQifV = [UIImage imageNamed:@"dpiAxIdIzKSHRiTiICQDOEDgciMPBcQOCXBbtzpdrcNMqhBDrjNGJPzjoVteesCudQZuUMjMjWCHXbFXicoiovZgMEuYHWiHRsWdIeQnKjF"];
	return OnTobWZkQifV;
}

+ (nonnull NSDictionary *)HoiXuHdjuNHF :(nonnull NSString *)IbHoqVArxSlgeT :(nonnull NSArray *)tRNmrvEqtwRFbqNsn {
	NSDictionary *vDFZyzDuyrCVMeGRY = @{
		@"fTQbUiMrUEjoQuVSq": @"NxoVUVnLtlSTrybwodqyeHNCXWVkSUioscGapbcOnwoqNOVAsgsaOCLIqKbJLpleFwMZwJgqnqOpUpOJJxiieRLDvgUujQazgjAaVytFKmQxgyfOwicAeDZBhZKbnxbWRoByuXMvzTR",
		@"EkHJzrqSNjgrdIpIqr": @"vebKbRgVlmVJrkfLhHaBlbHkkUBIQQOQdagOdxqTcUAmNsIZkYciNSRVNtarZcgcgISgvqGRvCWYHVNVDaWyBfUsgIIlGUtOxnEogqYWZEZXgdhiOpTfHFaaKEraYdFWAdrftqn",
		@"AQgRSswsYPWufWLO": @"oNBpiQyIiLUDtQJpucTKLkAsaNLxLFWdlooFYrgXMhqsWuZDPwldDEvgaAGeVowglnbiNsmOkDCOcJkTLHnAzTEtWTokQYpqLkBEjBgzLuezuz",
		@"VHALojCFZK": @"WJgRutLDOkqnGIpaGpLptMAuQuhIIYSedbqHHnvobZcjzaQCCcmgvraHauqlGKTXIsAvjmNBCdHKQabVwAEXWaXuhNIiRUBbwkycJgEOjhSuexUOAXBOzQCZctbNgVGV",
		@"jaKsrENUVpumxWxS": @"KqNTuTFxsXuudMeqvgBcAqdtjYEOOJWxnFBulhtdPrzfckSJnGoXmjWttesKJlnQLtTqUYVVMNKZAoyiQVOXHrdlLKlPzZBGLmeLgyTtXLUtSHfXGhBZCbIeKSTvNgXpzTbFtXPbQzE",
		@"WrNywnhhMP": @"EfCZRnbDPIyLeCuvQQdSgZbIgZwIPLoyLYyoyLomsOQZIbJIVJsoZFEihjhQUyRHOHJNGQCYRhZovNopYHWBtfJQAjTpKeiThOOaHcMREgoSdi",
		@"cAyLKcGtUZMrBFqP": @"OKmmPHZdMfYejIVlglUkCOsHPlFvSOjieGLquDGRUOuUFkSUAEbyTQioEURHoZggciAWqbriEsltZYbPAGglBFoCuMNCewzoCmCALpiJwRsMBBIb",
		@"EsiiPlQfVH": @"DerQYFVKfOYEGbvlYhrLJMBmjjTYvOqIEnjvZnydytyktLxWeOEDFTDyElajrRRcuYxfxlDhDVUtkDcnPsApuNcAxKOoiqZtEAmWFzNdrrHslquuGwtLcerpCpovKOrbhgOArVZK",
		@"jrQlbkkpgTvdnfZ": @"vGJiCvteztlGnEVhXCdmWNaKNoMZBtbAgdxpoSHDcQmDgLxDiqXIZTmDTSwcAFTingOeayKQxGCMAxSoqKLeofSUPDYIWgYyfvQCejkbWLtbpPcktGCJZcvBNoeNkEUiUlnCHaeeFwnzlOTDMPk",
		@"WDNWvFjysuIdJPBUd": @"MuXGOVpwXfkUtSRFdAeYfVnBTUPOPbFTPBuVixYjleSjwxlZzSXRwzEgpwUnKQUeNczqPCrXIfpRuKVajtuutBCmCbtXoiYQmaYijdyBYzugeGdYKnXhQZkYalqCDbHxc",
		@"blWsQVnWtAQCd": @"KVYEcvvfjjNjRpixoqiNjcKKhgSTEctDQpUfVzzFDbTpwjLICwlwIojfZoFwQRLmAwXKQusOIqIyEUwRWsyaZOlaQAxfmOweqnnRfqmnbpikZZHEcUoeOFF",
		@"bvGkKuankTYSd": @"RMOYyrDHSpxNFtBfKMUQvbGMDHxuGHwgbFItOTCoRdDidLhnacKMtfjQcGzrVgHGmjNfkrYnycUKfcqYLqjWABzIzNfPKaKgOmMBKsivYVuyuCebZFzWEcxVjtWVtBfArEj",
	};
	return vDFZyzDuyrCVMeGRY;
}

- (nonnull NSData *)bimiSVwjQKLFq :(nonnull UIImage *)aUpOyoGZDXx :(nonnull NSArray *)pUTVKDdBewA {
	NSData *YuyxpMiLGig = [@"iglzdejPVQgUZChFqjMwEGxTRXZYPxnrVhxfjAcWHsYexDcimUyAGuUILsFPXhsytuNjETsaVEtFDvCDFadKmszRoeawSQibXVfkIRfxfqsRxxlJfZQTFxsys" dataUsingEncoding:NSUTF8StringEncoding];
	return YuyxpMiLGig;
}

+ (nonnull NSData *)BJEBuQHnOAODm :(nonnull NSArray *)OXXJPlitjibgrIUX :(nonnull NSData *)AwsVwJfzHDhyvJJPFu :(nonnull NSDictionary *)gpDwoOHNnPHYQgVE {
	NSData *SDVinpiigewbavv = [@"lRpekEKMLKVidDlfhTtzrgHWYHHGIZSTSnFrMwSozjznrRUyoGKLSIihEsJVDgVNYhyvPiuhvAftXPQgKoslfqPqFNNdptLfHTGCMfxHZuFGhEkVVocAO" dataUsingEncoding:NSUTF8StringEncoding];
	return SDVinpiigewbavv;
}

+ (nonnull NSString *)UkICVpktQDnOcZSRG :(nonnull NSArray *)eFZJPjWAEDpU {
	NSString *kgOlWQofmVUpZztJa = @"zPgRbacMwpOFRLIEpuoaQeLpxcrsvnhODIDcGZKTgYaCtelZDBydGvNUBOePiAmmwTrWxwJcYYHpzcOKxdzLeLgwWHasAhPXczHuKQRQpwNErtvIAQUlpICPujhFktEKvxOHQEhV";
	return kgOlWQofmVUpZztJa;
}

- (nonnull UIImage *)wOlDsYpAZIx :(nonnull UIImage *)NuhvnZPgWOPYbuUxML {
	NSData *pagPwnQoNMQ = [@"nZgoCjRjIFVasYuwblSQxuLGyDIQcjIwOEacOGDNDQYACKUbewGjQJXKdPLtyXNnrbXNdrolVTMeCSWbCCaPvqZZYZyCBowdCouTxAldRqcZQYRpSzmVtNcDGRNmyQzlqo" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YQizycQOsgWOR = [UIImage imageWithData:pagPwnQoNMQ];
	YQizycQOsgWOR = [UIImage imageNamed:@"ypyYcTWAWRWAjPpjNklziWMvHwgXXGFdGlNslRBmcCUmSMXfNriRespADEUrDNTueKKLARXBwQVdzzZWTglSnCfAFxGERFFcpMJkWQbpcCHYXJCUGNVQMqBtRKzIoWJouwhphic"];
	return YQizycQOsgWOR;
}

+ (nonnull UIImage *)fLjdLIGSsoDGJJl :(nonnull UIImage *)KsPcsKZrTIoASmWyZ {
	NSData *BoiGvGQqcZKzhPPd = [@"qrJftzcOKaIuLmsXHhuXdoNePzDnIgxwJGHrbDQtdUTBETTDoUeMWkHkIWNPpmJTrNyJeYbaOOmIqufoPujVnTvmaIlQlgTsTheOpksYwygjVIMvQafk" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MSIiREKtZLOFs = [UIImage imageWithData:BoiGvGQqcZKzhPPd];
	MSIiREKtZLOFs = [UIImage imageNamed:@"APdLsWhPQJkmDouxTSKMhXIdymrVRIQYRyivvfYGCalqszWyIPPZdvyWmzYvtbvrFaGnqUFwkizLJZNhdKAZpgHXoblkRLkrWaFsMSjBeTAEDGIaUNOJLSzjOafKyrEwtnizk"];
	return MSIiREKtZLOFs;
}

+ (nonnull NSString *)pnQVDigzPJCeWRA :(nonnull UIImage *)QMhgGIExZaCbkeD :(nonnull UIImage *)affMGanZGZGw {
	NSString *XWrMZDbHChHFNTCVdff = @"ltfuwMjZfrgRPPjLzdJrdSplcnFTJuGJlIrxrkuZovgDMHbHFKXbqlugGWjuOeVfTgpLUPfTWxoUpwslusgNfCoPsvLYZqZJNoqkHHNcwhneXRwnbonEERsRrvnkY";
	return XWrMZDbHChHFNTCVdff;
}

+ (nonnull NSString *)IAuneDXNlWnfIY :(nonnull UIImage *)qPtUHKhiAHToUwfB :(nonnull NSData *)bOjlWpnpHCSSLaDwhEY {
	NSString *RiMhVjCiJGY = @"rPFvMSYGRqMupFejqVrbVlFdqpbQOAkjMObUusOcJLQXCHxwDICguOpsyQyKxJrpKHaWRSDJEAzPKAFYEVRMrOjLiYusSqItCxnRKaJthsGfWDClECqUSfPqIKPQmwt";
	return RiMhVjCiJGY;
}

- (nonnull NSArray *)oXHOMIBNiEDDvqgk :(nonnull UIImage *)NAjeXBwmYCyvXsTP {
	NSArray *lqXPbINFTQmtRNcEE = @[
		@"kpSgUQakIefQhpERMZTpiWPEjZCUOLlECjdITWsmqhLuyymgWDBvBKjoOsRgewsZbJammfhiaysUzfjJkJFJzwxqxuizPxSTZCxow",
		@"VGFUvkFSkDSEmIwtOswfvBKVAKgdSEQXfcDVUOAGgEdNXRcyYcgxAWoXuneMtpIWekbjUXteViVhpdDlNyyoVfXkPkzOAJJKuvNARYiztDZHnTkrBgXkhp",
		@"rFdfwKhIDMzxKySJydELJiCsIsveyiYHAVipIVInHFcsHPSPvCNDJwoNBSGyuqRTLSNyXrhlcvXIscOQowMbDJJvfSBKVIHnzSNjuMMZRquRYgvrLzFaJfZQXQVEzYbuLkiqhXeRYvGodELUNWT",
		@"RXmHkGQNKSbsuPFxQYFuelxpkPqLTLbyAxDrEHhrXnFFNpIcfNBdwERBWCcIFlXoAZxFxsmHasTObmMLCsnaJZmWblEUtHbrubUDidsD",
		@"GYCxzfiPKBXApMsueuPIwJdeOAAKxrWqPacfNrUklBCZoaWMqjsKnnHwVfUVvNrEWqWqBcvEzPGYAeIXXzFREPYsCsUqzPBzNUNcX",
		@"bzoezpNEGuTWinrbACVPYVNNORujtRotpiKFbOLjlBQLOozhFgRTsjoytrHZXOGbKFSxgnTCMKcZkvtsrTMXbkRcxPpIFWhydEIlHTJYpOZwwAJZFYzbXBaBFkoNMGm",
		@"WLRWTqqtEJFNQocXcxUZKnonrxsIwwufMLCwwbBNYcLYJvKybmsUdAwhyuwQLyIwkPbVlLVhOFvlDZihKIfciFBnLEJXsOkuQUakykrXmSgsBEkFNsdL",
		@"vOgndrJFlYvLqUrhGgJygVyCouxdeMrplORebBflWnUqHNfBiiNvVWvGdGCRkYRstKxYTLMJnFUhjIKuRuDKHUnuBAoQfIlYoqRFIxNzLgbQMlVaJlEaJARaFDoOiTDdCVwJRyEwWx",
		@"pDGGIjaeGRiFzKfhqVgUmfSYqrerQTFoIhktUNfLZkyoptyqOoZpTIcTmCSUhWctbBFacCozNMuvBxNqlzmnOJesqzrhxOarycqBrmPBMHqGGEiXPOOJNmG",
		@"mfCLVjeVJFgOLlTWFrVDzwVORECATcRHWuvLYBojClufqLyMEgLXlSWqnrFPdzbfZSDGtRaOmFFDSfYceaxkTInOZDNHNgAHdUnPWasdxigwt",
		@"kBKVtcMULjFEjOPkKmZHMTiRaNxyWJljMZTCREHyXAAOgrKfqwhBGCCVxDncwvzGseAToanNYmFPpqGjWzOUGaqxHnKKKiDplWBvKLmmuDFzyufNACAr",
		@"bontXFBlqZWVCyZfzEjCmdaXHfeMrYuhkqoBSRdfOltevRIVHyebjvRFLExFvIERHxGwYwGeIZCdXxQzTvjvbDjBwjoPBKDAMKzHyCLMLgYzMjTvTm",
		@"ZgINdZScPSGPPjguIzScKwAHEXkXsGhUqFHbUtLTkYxipVppwrXOlSEQCpkLDlebykRGwQKiLdCSZQtlIsMYQzzFvWHkkhfhhHHmeWpHcQLWRn",
		@"CNgCDwzebnAIWBqLdNdGJqcomypObmvfkrPVsMXSCCeottHTNqKVaSahBRKVUTIdqGeEIXESDsWAWHfrjqewKKSReGiVeckAaQVtgbjDVAlEfJQ",
		@"EOcZPZdtTeybGVlqcDtkyEniyfKIBDPSuVGXidkrtmhtnWyxIxaVAIBjqYWdxNOnrtejwHydlJwosVaUIzqWUdQILEXLKmRceIUOQojbgtaVviNcEntpcYfSszwJYOqLNgazREAiYclXnzbCauhag",
	];
	return lqXPbINFTQmtRNcEE;
}

- (nonnull NSString *)YfXQfdtgFbi :(nonnull NSString *)EIoUaDXBiMGfkDu {
	NSString *eKDbOlSHsHKPjcGaO = @"WqlkAuWZOWGyLmieMsPpIVXSKyczkFCzxHTgnzrvuKKblXsAYLHCtsiOWuPtvSRyrIGkGYXvHhFayBjZoPygfZAvhpQMFRpxScxLzNAo";
	return eKDbOlSHsHKPjcGaO;
}

+ (nonnull UIImage *)nGvIjoUBORFaKufN :(nonnull NSString *)LKhEkWtHtKygxlSaHO :(nonnull NSData *)EoyYiikhbFCMqIWhz {
	NSData *KmfoJHrBQTBJjnQMIo = [@"gKwXGJrfOpdmuciDSFUKBsIdpLxNRbjxTQItNvVzZLoYoxVUGHvavFVYgJAKgtNibCSVIgYzAulzfuuRhSdHxBtdbFJyhbrBcYDfCYeouRWQktNiniIStKSAjokcAQKlQNnYWqVrrPfOmOtt" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fzTELiWPuwvKh = [UIImage imageWithData:KmfoJHrBQTBJjnQMIo];
	fzTELiWPuwvKh = [UIImage imageNamed:@"yBqiFyNleAqFFGRdHbSZYZXsNXxypaZbHsnMPWkojYCsiuAMszHWUilyVMJPiUtarIgjldzrgPccQeFkgUxBfghJsuidcZzZXLQjjYEigIEGzPdXGlwoCWlNTUpZazBCAvMPZgfsD"];
	return fzTELiWPuwvKh;
}

+ (nonnull NSArray *)ksjXILkyDXlnobgqw :(nonnull NSArray *)QSczrhFChBhuiIxUvbK {
	NSArray *zArWNPAuxl = @[
		@"upDVPMUhiSvjnBWgGeQaBolRbdzqdNiIFoXoIQEbMeZXazIVpzQFGxcjXWTrjICQzjLLKnyHIpmGUgbEvVqBvoENluuYDNVVVhVFW",
		@"GOVUqfyVTXzaMbkOzWsuPIodjGkPDECBzCWDvbgBqSytiSruooTEqDAIugHeHzKfxWBTeyAiZUSxDbvzpWUszshcHFTafJAuAUnoluCJkuScjsuK",
		@"eiSjTYNTxkhOBjxgbuwMYqqdaOtrykhTiyseBVduXXePtZMaoQFZxlbRQpdOGPPUAoNzZOjjjEVWNYiIVdhllqgbsLIbMyEjUgIdXkdtuVlIBiKPfnIqGYJuq",
		@"vvSlbfVxeiTQlFFrdHNcASYLNQngMQUhFAOpbRPOpfRWCvbCNiyeBUhLSihZQuqVrVqNJBNHpdsHVjLNKKNhjwPHZgWoATDopHxPT",
		@"FAgbpxyjQSoKViuQBEIfkpCBXBLpKqpEBcnHWZYnhBxCloFiNRlBXvXGmxIdpccFlNStnwdQPKllpYxfFeCJTvutBduBbKPEwsFE",
		@"KTpCgrcOBTfZeRfYoLoylDkVFVvQRRAeZEAYqmDecfvuwFgbQYmcHmLdXXAyQZDWekorKOFXFAUJiSQVsrzcRXnggQwqshyOOJQUHqOtevDW",
		@"rLsrtUwAXOjgweXIORFpAengLqoPtrHAIAtqmeyWQQvAYaVyWmurDFgbEOSmUKqZacPuUjhtsLorMgeNUnjNLNliziEQKqdPyOeLrzIPAWHBMAnkTctdkzaKAvOivu",
		@"pMEBbBRtXhnKsoEIHCEPMFdhVhVapRZQJXggQKFVcIKJFTLTlyfcagQDyoIgkqRXcrrkBhjXNWixocaXhGiucOygMUHRhIAuvpUvXbxQLIuUbDYgRNQ",
		@"QRtFeGpYqODFWNjrQUtGXgFwHJvSVpiqjfCbrXIGzeHSHEhkraUbqtrhmjZTZtrdowcoMLeKUpLVlcFfscBekaMRxRmpwtpabbbwqKrJPqDJFImKWuGdBpsPDDenteykTKaZuuPiLSbL",
		@"bOlWabbUZrsJVeVtwKznxZzVpKNoLHEXPMVhkbcqoiYoykmCEZdomhpmGujcogpXfzrbJALoyLcEISJTMaGmtHrNyCdaleTJNBJlLWZbpcEzuURdlwRgJOkhEKzSvbdIRHp",
		@"YPunOSQylDyHXSsCxrkduRtSZtBFCrjxSWPLaSNZCsKzQXCrFkPzmEMOhijczRCcBpIlLBXZhulsGQZyaLpUNmbYDEgwrjEKrFUbeEiAGAoyqGbrWa",
		@"dIWauOEOzdLHvGwhsonxtXmWTXNzPlVKjgtUrVvLFRVQwsjnBsrsecJZYecfbWVNJwGsfiMfpMYWfBLmjoPulMjvWrYzqZwVdRkhWUqxMNwuhwbLNOhWniwwoEXB",
	];
	return zArWNPAuxl;
}

- (nonnull NSString *)VnYgcPHaHSTNpui :(nonnull NSData *)WlvuodZoISE {
	NSString *zbUWsjkhJpY = @"KHgEtxWVExwxKlXHVWEjpSRNFoXfqjqVXEhlaSKTReWqCkqPEgOZtJegSgmKdlsldmAvzHrOqDoBKKiIhmwqihmjLaPckEAQYGWzqWYRWWuFLJuyOoRfgFjiYmJbitIICv";
	return zbUWsjkhJpY;
}

+ (nonnull UIImage *)RmblUIBmVn :(nonnull UIImage *)OnIGdxHhtnLT :(nonnull NSDictionary *)ftaUVyCQrfUxM {
	NSData *lmYHNxuybiIcelueeD = [@"cjjFYAcxSOtEcyRmQHbRrmNzNOSEsjIHViFusVUFzbTtsYRcBwivwEceFvFYYUaUSVDsiZnzXuWsOvggdpogkMOmMjZBSmGpTiQDymnspeamjhwOMCQxGZwudWQmILmzsTPCPVKlLNctBFhHeZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OTMdKlCcElQdX = [UIImage imageWithData:lmYHNxuybiIcelueeD];
	OTMdKlCcElQdX = [UIImage imageNamed:@"oeVrjofXICKoBRYZIXVdXWZadKcTNOhSnzdZARPgzJZOjxRvsDTfOxUWbMdMxOxEoXgOavFTdsSpkBBXHpxwTjVVegkEEeLBciePTBIjkvtNOpNKHohwhcPbAwwwnIqEXxLQrMryBPPD"];
	return OTMdKlCcElQdX;
}

+ (nonnull NSData *)GRFzcLvlHIcNHrjOZ :(nonnull NSData *)jOtxpUKgnTXIOph :(nonnull NSString *)CDmbEjoqxaoIt {
	NSData *aaVxYnsRYky = [@"JdItGstlJRWJMTNFHhkycZEerZHwafTmKQnpkUMfcObiuzzOxmMwBDHlADRumfYaZPwyJEJnpoACNWRQKeKZUWVRltYaQPGTUuCNbhNvTbsHjZdxTAiCumNiBQtWQEaDuUgCagievQ" dataUsingEncoding:NSUTF8StringEncoding];
	return aaVxYnsRYky;
}

- (nonnull NSDictionary *)nTkhlknQVohOYXIhq :(nonnull NSString *)RXbBkwYIosbTDLdE :(nonnull NSArray *)AFDtYmeRUeSxrs :(nonnull NSArray *)dtccoDDhDWWFycjCSAJ {
	NSDictionary *TLELHcOPXERnLMZXgW = @{
		@"jCRLycgjwBEOcmQDaD": @"DhHHXbAlPJwadamfwMYdJEGdJoHmswuvyfgMzrEAGaPILuJwKWYIBnbMdOLxOjyEeQbZNtuwGNJNSVyIlcUqgKVaOwztBOvyUanGBghQEipDFScCJKWmBnhKRDBundcAbnbOXY",
		@"hBiRUHqGPjfYmlr": @"dMJYmlUZqABViuoWJbvwBgToCRzRxWIwWTetlMLCeQFBlMpuZCtoROTtBEfaBAHrFiheLtbUyyoSmJuibRHFikFKpPRkETnZxkIrhdJtLDbUatyKjMplcBEMpJMBhxNQVDNDynbZysqlrr",
		@"YyPYFbeDGqvhAGl": @"LWHAbGQezETxtgeDrNzFhpHzNfmpqbrdHVBTTOkxHJAubxcQuDjmvvqhcxeyJAsawKJEoAbDSQceNMcULibYaviybCGnFyZACdlpNIhtssQ",
		@"ZoflygfdskYFqcWJL": @"dWzQBGYHzpYXutWMTqESLTDNRiUyInhVHNuFwCcpuzAfjvCZQHeOheklfafmVMapUgsQtJUhMgphHvSOhgiijicGJJvRpDaHJfxprffcncH",
		@"BimdONbIjNZAJiLGIh": @"fCNGNGkTNIIjXMWIkKVEfvZqaHCppzMTGjnCxmbtuJEuhqkeksXDyadgBUKkFcGgXGshtMKKcBYkXLditpDtMQdFzBdctByQTlqEYlAEJwoCygSEKVI",
		@"AcSmSLiAEwfdiMqfI": @"vhbiYTJbNMAjEYYYRuykOQqtiZhCKIgXXXPmmKlzYtwlUAjuEenIQymlxdKNeFnfgNnPRuQmkkbzABwQmaJbGKasJDkpPyZKBJGRInMk",
		@"YfGfZCpneejSWl": @"LQMbaQUAQctvEgEWKWZYtCdlPPXLLRIAklvlhASkYyNgNECZHbHygmVBKsiAsQHPSdKylJOzxAFRvKpTEezuAQXRhlhqSefyvaGzoHwzKpfBUzHxIKvYTCjDELcp",
		@"mCMCpFCBNdrZ": @"uoMzTVVOOogajcfvRWACUkQWhaiKdqUEOCNJcgzsekAhTnFzTTkBzZtvfkpsFHlfRvFmIGhzriMTndWQAvLvCrbNfSmScOVJzAnNydnUNxiomZaOqDuRKOs",
		@"DVVMJeiBYkSgkbey": @"XlCnFshfMgWyYuGiwlJMIrtlewIKaEezhPxpSfJAXJgvitsYjuGBadPXgezplHOizsKNvPbXyxLbnrySWHVscGJGDtLgRqgjEpvrpkgZklV",
		@"aTrNRLHrGfKqitx": @"NPRIJhJQjhxWpuvDqsgAdXYGVJAYzPMkhLoZvgZGcGjRLHfmNAvltlnDsDftxgwPWpRimLMRsgRgpMmHbtHOdaFcTgpIxhTNaMPmFxbFaTYZPJ",
		@"RFPCEqAKOqKq": @"ZgnjWoXNBLfYdlcKtzVOxUSgoTZTKVkhBAOshiHiKTGSmahKWIyJEGDUIAmGmNMRSYnvXXOJgGmaTNChkSMUZLwMMFonYSIHfwiuOtjKhmIxpkSmdiBZzXhhhiHeHYnvn",
		@"gNkyDVKSbGnYhe": @"aiyHLOvCPdJZizeezkbjxIZVBnzmfeyCDDtMaaOBGfzHEhAONIzlSuBhhLGTwQThKwYNqffEOxQkVofverTRbzucQrZpwbEGscVgg",
		@"yPByZZBFuXSvjyMKWb": @"VJhhWiwuGpsrkIzGSHyOoEVakHzvSMKJpqXIKwIPmsNRrhIiGAzeCzXPgaxhToJTIzYMymYQtBxOUHKSOeDNYEhqCCUhVoxHzxtRHwsHnyxNlZfcDqcmFJiYQTiHOjbw",
		@"didBLJzSFKSJOTi": @"sxoPmBylaegCAJZkJXsLKuoxVSSXWpOtHmAasABuKzAnFTaKCqmSdzXEPmztiMCUaPpqeIhdSKwJHfzJEbjDvLxjTbXRtBodjaGESVldgfOaMpHtSKfQSgKxAJaS",
		@"JfcuUbDdWvOi": @"AGNApNJvDWacODJASeXakuusqnmlVwJAXzZRQTltBKocbAuKdwOctERLDjTwjYPFqRtxAnruOMlmdVRCDLEKHZRpSzlevUltczgnozWeCVGEjYSqtgnQVYSckWevjrzzUv",
		@"czisYQRDghlnBzdj": @"KDtMycMzZjXeqhzhXQqYyBRcPRvuOCdlyJAlZsvKMICoZRnfmJCMsxALeTzEiZFzxxJTgGrPQjylyfwrhhmZcrGaoXJtVfRUjGYGhUvFSSMetaavXUFFhVifEgYhLcvwrfNnF",
		@"qSmPuPMjCdbNhq": @"NsXihDpvopDrmEDimJZLcXUBFqWjhdVJmyguwhyKzPxrNdOqIwZysfTwLLcupBCDeMQEwidrKBelzWiqgsgCxoSatuxmcZmaneoyxxRpSyYjLJBeWGkTxXMJWHwTCOqxgN",
	};
	return TLELHcOPXERnLMZXgW;
}

- (nonnull NSString *)jfQhiaZnusRpZjGTE :(nonnull NSDictionary *)hNrGQtvsivnDCtMtx :(nonnull UIImage *)XpxzcCFNgLYZKuCwh :(nonnull UIImage *)MQlZkKgHBkOxf {
	NSString *lggOteWLgqjffxiKXcx = @"kOOVESEFmjyzSWdDqDipryXhvZeLkrNXddXEErMSDuXfXDkvfvgUduJuUahshTZIHkzjVwDUgZCDxZiFkUHrcJOnCByHpsmSeEJD";
	return lggOteWLgqjffxiKXcx;
}

+ (nonnull NSData *)cbEjyaRFBq :(nonnull NSData *)TeOEsJSTuoXIg :(nonnull NSArray *)CjUoItDhGbUyQMBycrg {
	NSData *gEEPFXwJVYKO = [@"CslnGcuLPZOIVRkPQlEkDYerTcBVpNZCpFakqYyLXmmOTrEOdsXmPfKqDdaXqutCOoBvTLmqAWQKBhNelMiXnZDIbrFcHavsamYslXaANoSnwkRgovlLHzahflQqukq" dataUsingEncoding:NSUTF8StringEncoding];
	return gEEPFXwJVYKO;
}

- (nonnull UIImage *)cQklLxVlND :(nonnull NSString *)DhusdrrvgYB :(nonnull NSDictionary *)fuWylvrPxKJFw {
	NSData *jYLbworpUaqaOUkRjt = [@"psqFiMcYGRNkioldYkZYGujjYTuqwVCKvMIfrXRlTvoHOulPDRGyjOoLzEKjeTTqQgqgKsQzGGbsDJDSLxiPmxJEaYAErQpxAogcNMzuHnKnEZPiBdQBaqlcKdTkYevaAaDvbwSBQxoawcWKBUD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *bGSwTBNUXbdIiJV = [UIImage imageWithData:jYLbworpUaqaOUkRjt];
	bGSwTBNUXbdIiJV = [UIImage imageNamed:@"iYqoAaSwwxxqrdPNVnwhlWBiTgPbTTIikSIXDDMTPvztPxilbIOodUNRCYuGIozFrthwzIRmzcqUplpIjVpAUCaSMaCDlwOAqIxLhqQesDSbTdO"];
	return bGSwTBNUXbdIiJV;
}

+ (nonnull NSDictionary *)eEDgEgEbLYAXpydHrkV :(nonnull UIImage *)UYYMIemhLmEposvL {
	NSDictionary *jClOVRdeDFbwuzMm = @{
		@"arGYvKIEixqwkYzcp": @"FZzTPqvVzuhSxLtTrWqoWxNYwUWWfQvAXtcciKGnTgmKqyAaxZUEqecxXwhDTJKwevGORxdOatxsaPUGaWnPfjKpcDmkBVewxNEk",
		@"zQBoQglgAtWO": @"PnVsEQnPOipXVkWvmpmaBofFMcgxbKsLgNxpXKvmlMBJapdRUAhSGtoChLzbvSLokEtBEdKlMYpyHnTRdesbFhcujdfpDdblQEZPFIuRiwe",
		@"AYOHlNqACdfCygq": @"SfHnJQFkRmjgjpOpIxrRXBPeklsdzEtbVGxwnpBoAQxSPwEZhodHDuTzZaGHxZrqHulnvvGrSCJntJMLquQWooSYSlngCMzIEKphwEtCNExcZUVl",
		@"NMFTfBRmKun": @"pnTaDfzNgkKUWbNTobygmyWIKnOCesYKXGHkfHZrcXcWeBQxEIiRtqbdASqiUMBBAoQEdToSIQYaleElNupDUOciKAHHOJcPaxIEu",
		@"ogRhvcAMAnnlHXL": @"POLkJQxOtBWHMWrrZkXKDZadLlAGPFwnktFUabABSZESpwpzqdAYoLLNWEHdCEHHIFVXUfONweXBkuqpjEDrhbjONVAHOvofRdimANScDppVnPuvVPSYOLDUPmbCV",
		@"cOKKWPQJOeTNMKEf": @"iGypDqpTzfymeEzaYKSMVIgxSjkuzWcuSqStMWjQSAiLOFynvNWROhgMQlZOqejFBCJtALADETURvyXXQysQVaUPQIcsJsIZgxVbbEijWmLIRnfXSqJy",
		@"kjVljgyGQMZWKvPV": @"jFbJqASajqPtlouYaifAZFvUpbdvvEqzVoXveMKPCsuxuhjLgvwfXSVvDnqOclAzPVFwhTLJLZzSIIfTKCLefZDguNbHobDVOeqdruyJPo",
		@"isNOXUFrZimvGA": @"PDpEleRjeLqxCwUieLEKOzQjNHeAKgQlSaRNkeeplNEMyBFkAQqkZZHemVwyiMbCWlLjhtfAjBGqOFVRhUvlOpcObzQjyBpWnboyxJRPEYkWD",
		@"MpWcDTGDMEWhhXWc": @"bXqRbeIpUYiezISShctnxbaTFWjMwpgttEwwarbGjNuPpbKIeVUnrDAClzNCgpfbmSZKkYtKeRIpmgFhQMjrvNAHnfqDwrcdGoqUEQVSnEbLIIeBeKDVsqOgnMjxSgMTpVTPlNCKetsadUzr",
		@"azBUMrSpwwYZL": @"qSyddXRTkPGTEKwitfgghfUbVUuVLvtTxeflTpUIBVxhpKiWIoJGGjNiSgSYpdNdkLJBLXpvDPQEcDnhHqTNRQUqssGMKLbLscuXeM",
		@"MJHGAUuLWqZzZYt": @"emUnpgfxWPiGVdHFMGkoikuFUBunGJndJmWcKmrwubzDNHCSufyRqkgAERqDiKXFJTIMgkIDklFLLHVNiokzphaqiVDbKyZvapEaoogbFqwuINQvQUptdTAXHcfjYYFFpUIulCCYD",
		@"GtBpkLbPeCKGj": @"UKgcKiPNbKOjBRaFacaMiPPsvRgqkNDsqlARpqMHjPrYPEDtvxxEIdxekrKCqmaJnMTMFuMjzGhypCyMHLrQQhUIHdFPjogntxGFrQjrghAPqQxflGuEVBzWDSbhXhkFkqduMVltuSEKOcMkQX",
		@"JkvoQkvfSiEVo": @"SmMJPscDuODtLSHNXcWUkriKafAyBbzFVDUjBDCaCFCYCqEeZVFqjFPYgigCsKLVuOTZfQBRAdtAJjJBJTHWLeEGDXUyWyYmLPjwkhPOcWSpsMRHPgpEnyCvyHsveSUFXlQnbkOMBQKePayW",
		@"nXQIZiMcRWe": @"ybMKAzsqUaOsVdKoPyZqWJSAAVSnidWprvTwOTXtOGijhNQNqtLDSmhsbFWXqqOdMVENZmlUrcklpWyHMRiLxCJVfXZikerzKbeTeuitBFFDnfVfqwvKuJDJ",
		@"LmYpsZGmzV": @"EwoHmENigvoVqjBuSlCbcKyOqfUSnUnzixgijYNzCBwnqzourqUMBTCzjbkBTQMiOpLQZNaoMtUUapyhBHGUfXvZrtIyEIKrKQwRkBcXDnGJbknUjHfcSqSHtzWvkynfQcPuQinGgjoSnjIBT",
		@"hveyiLRnLji": @"YEVAXDJIQjaaAVOhdlkZRqUxotixCtXgVGntHitBdoDgsgizpQulsPxceJUZMMexBSMmpVCCALXNULkpRUJBWqroDRTqYSnGbhaAhJQYkZsUljxRxPdrC",
		@"chUyiADAlczW": @"CyIDkZmqLsWeqQPRDaisoNkQFCRlTIiMeOIZNLegOvjYKZceuggVEHAibyotzHPDnpvsdXxKLjngvBUdvjpMwrgYwSlrDWhBpPtavhTelTKJGFDsKFXuQE",
	};
	return jClOVRdeDFbwuzMm;
}

+ (nonnull NSString *)qsEUCwsejBtEAHeX :(nonnull NSDictionary *)nXqbaTHbBhLIFWqSKL {
	NSString *cjFgkQJiAahvdz = @"bVHvhHLgeqxciiiDuNkAKzAqBOoiGRigxhbWseYkMONfDgqnuowgRHYatYjTCkqxIpAAeoPNliDcDidRGYdLlLIkOPBukMHhivNJNqBYcvxpRJGaCCWIQKHqPfgawzo";
	return cjFgkQJiAahvdz;
}

- (nonnull NSString *)gGGWYCCduXMpjYpUWa :(nonnull NSDictionary *)XZwOsAwBgbWC :(nonnull NSString *)NHchEkAltumslSj {
	NSString *HHZMFglzYSiFMFwBYEa = @"uFVfFyqSlMSYJskEcbnECSLHlixKXgdpzOkGkEkOkrgOAtFPXhBbjjIKsKzHLdghzpkawCjFzzVvUosgftYqansBZKXnoLkHaDzjcHHdnygfRRNukuyurnfyIOeLPWCvLxctLSKsVCVbYl";
	return HHZMFglzYSiFMFwBYEa;
}

- (nonnull NSArray *)LblHXUTZIwKwq :(nonnull NSData *)VCCdKUnRfcydoidSDRR {
	NSArray *bKsHzvnOcqkWoeA = @[
		@"zasElcRnZfNdiNwVooSCAkBbKZEEyDMsGEvHzjFSCqVAXxPCjktQsaLvBPoDKGpIUZJnPYpLxokkLIwyvyuwAOZEvYUEGsrpoZXPYsCVUynrTQofzqxvuWNPJXaPwKFiivcYNgTovUuieYzS",
		@"PGTNCkAEJmkZHtcJLMvHrazPAbaCumFhrPbsCqFbzyuYPhPUXHCHkOtoDQnXXSMOupQVAJfJTMzqqLONtbLjDXjPbMNMOJZqTmsFsBsmTQeoC",
		@"MXzJoksCNGucvYCDqEXFMMLzDyPTaVBdxbOUfrHpcFunjLqFKjSjcZAuOtCmGQmcjTkDySyTNZsZbtMBxsxRFbmqsBcIfwvVfDTGKtgu",
		@"dPZstEFptfHXICDRkTRCzleyuJFZdLOtswFqAZFBvNGSoYiKeubgpkvHEsvGiQNykMbrLboHqttWvrHpQPhqJsgvnpUZPlGVPJTqTyvLsBJPx",
		@"JxTMoNKgESAecTMCmfFajWPPHrxvPmvPXIGMjZwCKQvVzYIXTwJvKVDOmvefczmXpYYTvnncMpisMjMVWqJuNXrpMAwWJMunRcPDAbwLdSohBXGAuGJm",
		@"bhTiKyHZFRTWpTUOlwJLVSJRBZcrofBzgewMQcokAjPUaDTctoHZgCNwHUkAVxlVNGCcWrcJCGLSGQcZsWFlAgoTNBInoFofGKaoeZMGSHgeGtYpKuvSMMWvGXJEqnZYzbtuYMXTErJd",
		@"omaBumTbhDGrXvkSCzefMngRsPTnEtafGupuuLDKNGkUsifLxLMjVVmghjIQERhBxhbLhRhibtTfNERWWvVkKDzccvYmdEmvoGKIeyrrqXdwqqZqnfSNDDnkylbyIDCnBXHTysc",
		@"KFUppFMtqkckrqFiaIZSQzrvfQlnzPUbWOvEnNbhsnOuAAjaPwTaHxrSVLJuPZAUDlljeEjsSyXJBkRYkTOJXnsVzDFJeuZZYaAXVVGxuisCGTiJqfsaYPXSxrEmSDn",
		@"gkiarnmlkXWUCNaDDWlFMLxCTwXrZKHYkNSqpKTFEYVLQqtqGqlWvZWmYHoAczUZuTzSFYzJUArDtmxuItbvSrMKuKOFgmQbpIraIBPVGloizDYDhcVyDBSTcyXJRqvLPwIRKpDbqNzylUdFsvgU",
		@"rCfAAweyzJmFWIkgqCRASpbLpqTcIgYUiyliHiZgQKhovNEeJereamIkanNMUBLMrypMTeuXsbmPKsnNrkcnVEpYVAuUzEuFXLYiFqEfBSqUMSnDWUdv",
		@"HaYNMJcenEwbRbceeAQTpFFszbufTmrLEGyLVoMtyyNHzLoxifgpYILxnpdbLwLhWKZUZIGLDxKOVbymeOPoWrrOEpnDkSqLqoLLOws",
		@"nyPFAJsbsUdstgHSWZegYEHQCeMxIZOQhKxLiFpPFuZmiiDBhAYUxHGMgaXwAOfVFYVfwbxtJKXoNaCdyzPLqhDDWplxWOGVZkBdWvzYFyftyZRcnfyFFOjftiZCY",
		@"NFWkswFvmcdBwgywaStFrkbUpqqODCqBiOzADjRaZkQpEwZvNLpVsqlUHYAwuoqZOnbfhXzKEkhjjhodGwTeVqREZJCwRgBZJcuhGBfBMOafpKmryygKefTfocfPHTdc",
		@"njHpWSgKONqJnfnpVoTkTHNtXryVBXuxtOQaAqGTNkgPgGIDfYyFgpMEdvNETrBydoRuSjYeckdTkQICghgITcwlvvWMvwDJgWunDM",
	];
	return bKsHzvnOcqkWoeA;
}

- (nonnull UIImage *)HufkWdPfLSYhU :(nonnull NSArray *)lcuqVHwRNiwSbzoLqK {
	NSData *ctNpfQMJZdMJ = [@"GvLrDtaFyXavIWeQpyTJevQaSduVxJpevKFmGqGuokznsenoxZgyVuiLNQtXmfPrZToIOZwUlHNtKnSWoQQqAgjvyqlzpQUMfWoZAoEzmeYvSxrddRiCQDFrOfIpNrJgZEXwXYWy" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *UxfyfujnrMOyYckHj = [UIImage imageWithData:ctNpfQMJZdMJ];
	UxfyfujnrMOyYckHj = [UIImage imageNamed:@"EJWObTTenThhtRkmuWumlzFTIYHEsmbuywvRzRaxHoDIuDLThHzgrfJYUsssUYCjqFkBbGCHCWEjGemMZOEErqMQGjHsezZFMTrDQwYQZyPgWxaLyKVjuBvLJEYDLMuKFF"];
	return UxfyfujnrMOyYckHj;
}

+ (nonnull UIImage *)UTLPnnvXyFm :(nonnull NSDictionary *)ofoOQFqwoBbbowh {
	NSData *SdDaxoklEIPuhltjQK = [@"ftKSfdUMRkIwEGaZpfSWBrSMlOCcVuZunuQBbTyntbsATsnAERWgqPjbCwiZccJLUWgVotblHklvoaLwVyUVsKYvErPrEeQkiYeoeCNnpACcReiUEavnAGiCPTrpMgkmUZX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *FgYSPHFOuQPkEmpsiG = [UIImage imageWithData:SdDaxoklEIPuhltjQK];
	FgYSPHFOuQPkEmpsiG = [UIImage imageNamed:@"XYYMebqBgyWfZpZmcMVoJeIkqPgEDZPYBYIsiOGuPDMWhAHwLZhMOzjqEQFOmyWaUVWekJCmwuKDHCNFraTcVrjpIpfpZHAiYXrvKQnRRZDpWHnJeRwJtHdFfPQRZJFTHXxqjpk"];
	return FgYSPHFOuQPkEmpsiG;
}

+ (nonnull NSArray *)xmMrcwpLbVJk :(nonnull NSString *)vqnHSZGPrzUrGIr {
	NSArray *hYRohkgXmWUihzTKDto = @[
		@"QbtpoOCcnelxXUsSvkBcbKLxFhcTsIUybAtskKjeyEuEXLjHecfRzidHfDazKTuVkbkZlRHZCQIsvWQUAYcyyQwbMnYrtCWOGDXwIYiJkmIZOOfZmykXwzHrfCbFuTTwsQsaQYFhVPDJYyT",
		@"WdcXAQaTLeIQFZYmKLwUiIpjDFCUXFqlHoFwKvZaTylSipLUesSZLtqzcClBrsmbYZnMNKiqmzMoYUDzAinMFZQeYVyARupaFiwSPAQixqiHSWMGHhpRiYlAXjCVyBDbqrujKqFVU",
		@"pxRYMbVdGtlPhMilOngNwnIPByfVFtrwweLFHFPahQZlkuUBblYqbiMJcCrZQMgbNwiagQBifQFErMgujHCHTuNkefEsMJhFOkczZZRsGoVIVXdh",
		@"dxhJQrPyTfIVpMGPXnBqySYmwjwkBpcAutRRWiYxlWJpryWfxdOzFbVCRMUKiiFIXomLKotgwuEqGERmaosNuoYJVmpBBKItQmXgOQJFlJeFIwAXeJzGXCMttaxrJcsGb",
		@"pIMmihdpCkynHyHfriHYFmkfWPQnFEasPPEKVADyvfpdwldtvmOuRYIBqLJwzeZzCZYtAVIFiTyVNrEBqzjgVIsgdPyJXmDNlFJUsLMlVpwQqyhQpQdaWjyuodFeXiPINvqGDQcqRuJvO",
		@"BOomjwrHdNKZkApqkfGHBKLUNmZfICKEscLXpfOkvRHeNLByqPzOPzfTqfBTeUyLBxKcGamAlBAIeHpLfGZTdLXPXeSXGicobgdLIhuZGnjMXOKIPqvmNthKgTQehQIuEvh",
		@"oygObeviVstOixRoYxrNEqFUtPTIIolTUoDUwdRVgxQNpEsPOzLLgtyfGhJNjxWAOPaOgfjtMvahqnaJGtWdEZVMzukUjqYmERgAIT",
		@"WOVOfIHqDQDUDsNeIQTmUJCPGkZUSIGaTyfJNcVOEfykcXauFWdfrXwVJkXcfzZGZnSCWWBfgfohKHUzrcJWWsPuMaUeEAQfenxGaTgBRgTVHruuEyCPjkmbFBvNDBftgLzYO",
		@"HvZKgHwsoyqFNuDkeKWnvUrhEZTqdDXCgmYMAZMQCdfsvzWAMkyDAhGwZrRDPZrdQckDXkXVEYrNhljnFVDpQgDigCPuWCZNoXRkc",
		@"YZGLBBYkmwFopYwWCWCMqDpZLiPlLqbipcCOtnOhNLMAArXmQVObbxbRZiFDRlWwHIgKWXKrrSODIoovwfNrLbTzjSAmrzylvooaVitFiqdodVSyLrDzvoSGbKpqQZJmuCCewmjOmBzSLuCXXbNw",
	];
	return hYRohkgXmWUihzTKDto;
}

- (nonnull NSArray *)fIiAGrKsfWCUjpyOgs :(nonnull NSArray *)iJxiIyplgAtaWlLoqed :(nonnull NSArray *)nENtkbXgQb :(nonnull NSDictionary *)zbtUyheTHXofRFCy {
	NSArray *hYgTvYMNPbVbkO = @[
		@"XaCkiUznHNjvZXCvFEpLhgQAEDnqJgROXqzVQjOXkdiNxbZtpYAaiCBwpAuxksloBtLBjohFVyxdQJtQBHNXUmtqSVsphFekndWXVwxXuVnpwxrudiqELChranX",
		@"QGuhduxfULZkTiEsrLUkDLQBdqNNYhfmJTPmiyowKtzefpIzauYLJzcAdFtWihrvWWTdcnGkXbAgswfmzBGdagiBfCpEaWRPUSuOHSihJwjNYpyJtoPyntZFmPlAqyggMzjLwqLNEaYxOlzklfS",
		@"vajZiNDDdwakpjdAhXlGdleOMkCPvCIQyBJZeBTxyFseQPOHNKCwpBwhxWXPsRExfwuQfeumbTWOpWdGoonLXERWgFUtSyBioLkvPzumxYmVLEmC",
		@"DUuUjwCuUTmcjDpBFeDdSAdJXzLKAfvduNAROWvxBXYEmSFtDrkWjOwgAPljMRXwqOjEZYIEJPzShKSpXcLKGkGlCNPRJvkyrugIfXHteurNLFsDUCNnHKnIXFkHFp",
		@"wuSgXoDIzDjhUtJZETeOyNbpqaQItVOnUXyWAWgYfzjhbjEcjOoYwsgQLbZuYmBeiVcQWejzSwYGhBUDFLXUhgpoIvRTlZDBHFyciEkBkSNtbmOFIRKsQnagOuXhJjEn",
		@"eFbjnoLrmJsvOAkylAUtKBhtRRQglsBcSCjIgCllNckykhEMWUUhNxFQIQPxAymYdZcwhgFbcBBMUgayiXtKziwmMEsYFEHeIkGVTYWcVN",
		@"EjEqHYpZyVdpiyzHaiGFvPwVveWtOdbdWvJXTiisVEAjwAQUPGHJZEBduCZGSbhXvoMkbCAmlwWcgITGsrfYMsEQFGKfCqkBDPoWCrPGSZeyzDMKOAbSaWBUOjFlrBvBziR",
		@"PChGNJCDPoSafIujnodCgHFjLrUtYVfZGXdCqAgvMpQNBmOOtfmYYZjzlZQqxqDepXgQhsYWhgyqArLNhbWpZQnRjQmrsTnRUvIneQvJqcpWGRfPI",
		@"ySuKiDeBhqIdtyuwpzlurHQOatsBlCaxfcZFKVVnMgGfgXkwQneKAYBOwPJcJndQXWTBawJvXWcNCGrSqHVRudwZGxBlDqTCkcsfGHyVRJFVIdRErugfHoeyIjlmPiczaRAJEhAOAjFCdhMxwj",
		@"LSgdxVtfeiruPnInMJSIsZuLTzSgnqsnpjlOKIuKSMVUiVKakUIdxusNRjObNqAGphmnNXKPwvuKhepHFzbnyCLaIqrgFdLcuUUvFTXdbO",
		@"EUCPgRBCGMFaWfQCFjqIqsqsnoAuCGpdSAKjPrXDTkulyUPxehsKLFkOxhREWMYNeFhGFHBbGCNlSPkIgGJFRQwKivhQglYgXELTyLQegFexsCxYgnEusyM",
		@"rtfbWnANmePXsRyGMTlVpsIJpTAMmhAnNXGSXseIUqaLocDQzmKpPrxjOHtPFEknWOWnGnrLuoqFahvpUWYdpwuktJlWEFbCJYgGgznOs",
		@"QnGYYDJXeHfrUeHsfMakAuaFBlCQHZcXiLoggkLcoaKmZaHGPnYJsxXMqFztnixGNodoEYJqpvliywyGxORFxeWNXNaplCEAOAdlIVnDaavokNxuaYelYemneKjmqTqtE",
		@"PrLSYfACnhksjzNUKvmtFShUWHkgfNnjNYrshNCTIrpYqPpvbBQSnAIuPkZDvbwVQYTpnrdlCQtFzJzmZbdkPfVyJgsZaPYNRGSCQoYUjf",
		@"aXZRqreFupAiBYzgudeKvUeMYsnFZDIUewaZlvKwuhFlXEgTleBEvCgQZVPjmSPGcJuFocTLjvFYoQnEswSqwFXGLgLEshHAgZtDwUmrpAqEYKsfMwCAGzcsyql",
		@"pRJHHnYWzWdnVHsqofFrZZCDfvAvcYfqhdYCGAnJpQnYPTXNdXzZufVxzgsqUdXuzlzuwBEOjbNPqsRUfHpYqFAomXggOvCnyXmVWPXmkXAcggfWeQxzTeXxBrW",
		@"TXcDslufhHLhIKDYbHVaKcegKRKaWObNSQXokhtYTcxitqJXmJjccvzlUbLyVbMYveJnqUhmxNutCEZMKqRaeaWQNpyDLnomvelqrMBVFeeYswaJhAJHCnxoznECBFZRGXPcEJrofkATeXTelL",
	];
	return hYgTvYMNPbVbkO;
}

- (nonnull NSString *)DKsRmWqxPUUgNUufDPu :(nonnull NSData *)FwLlKhEQCTWM {
	NSString *zFalMYSZLcJ = @"mOiTShcChjqqRvSNptceoJDMjpkHqenCntNKmhYtpsDugmysYkPdLUAWYqkThFWdmuKJaLXHqGPOsWtQhFVsEiKnMgrcSYwMdvtOXifjDrgiwwJh";
	return zFalMYSZLcJ;
}

+ (nonnull NSString *)aGdujuUIgtBhxWLXlI :(nonnull NSData *)CBHDLHBfHeyb {
	NSString *alzxQjfcOu = @"gdzhJoQfefxZCXWWWWZbIxjbPrMghsyfscilnrkVJuenUaFIbSTufGghkfkVzfPuBzbYSWqEaarzCagrWXVOnZaZPzhFZhUloXVAVtQtIYjmhLKY";
	return alzxQjfcOu;
}

- (nonnull NSData *)kdmvuIqZATw :(nonnull NSString *)DCTIyRDgkqmOAAQ {
	NSData *UttUhVjUqrhWuhjoy = [@"bauxrZxdRXosJDLIHLaukNWYgxmHLNRLxKzSWgRWbCsSbfDXWyuKtpkchoXzMzSLEYvzhJrfxCgyyFgvyHwLgdcQhkAWpRLWfczxsSTpvjYZoajhHTIRAjVJYJGzBGROD" dataUsingEncoding:NSUTF8StringEncoding];
	return UttUhVjUqrhWuhjoy;
}

+ (nonnull NSArray *)yCRHYnflFHUbEb :(nonnull NSData *)zBxYJxANrYNYFr :(nonnull NSString *)FJJCjMCjDH :(nonnull NSDictionary *)oVqwZfhTOInftt {
	NSArray *PsKmKAOSZQLjhcVdt = @[
		@"vtIqQIUkreMcfhhGSSmuBiGMrasIlrbektiOvqrzAJakUZYxzTsOxybmWeRQUxWenaOGrZxUcwVdEGCjwlUVViRAILwEYjFLEaYMXdVrJLhXiPOsZQZqsvpHDkOyuFhyDyLDsXO",
		@"AEHveiXLDApZyiBvdCgudSowjpTLhflpGbXQPygbfIexURtjeZbUlmBowEFsKUpcECzykKBGSEyXmVJLSGlkvXiFsUXmfpvuFrwDdobsNHuFGJpjiOfDuZfuDSOxvaZcdGgushUhIoUMeRCVbhq",
		@"SWIquYdjibeLUFfbPUuLaTFOeRDJltIhmvhmGPYdmSdbgoUuwVKhZtLwmXmcRjXcrqlNcfMNveueDmCGqFaAJzrLiLPAgZDagUUc",
		@"BhtKktOQzgacNbueSowjoxgMmFvhOrNAiLWxYQRObIbRaoXBjoyTVUinjTsGhRVUPeQSkFVsWpGKdYvWCcJndDeASrsDeuZbUcAUOXsUJEPzIFLErbzCxThzWJUoUfUzuilqqnWmMrJqY",
		@"hlyXlkPqbRqumKvawQVqPXpDiCrStzERlsifaZJrguHkUgCuznzSaYbOFgEdajlSiwzFLoABIUNVwiNBgdhsgMmzoZjedZGikGmjljHQAGmjIjHvEbdnpODoeCzZLtlPnn",
		@"UCjZzioVpeEUJXdCnnekyISdOxCoMdwDLbnezbCzoqzcnsFuPFxmXRUvLWiOSXJANhvBNgGOgoAECvqcBHwepKEivQDOEHYiRPFqmUSWbChTWcORcuQugqO",
		@"QqkukkUnxUPzZlNGlDRdezqtJPiCuwihrfWNzDbyYPhSFfYlTLjfVexRgpsUpDmqUNxrYgTfpigAXLWbaoVGpOFSYQrogEDwhkkzn",
		@"VtMmFWmVRKnfZCeNfcWRRQJagrEKtpufKxzTMOBQeHgtXebuNBaRYmrSYfZEFmYhQpZAoUeaNltNjlfbRkIHwVOmDITpsjyGraYFueDWQVQvRPqRUnDBPGJmhywvhMRdVHIynJrPaV",
		@"hDNGgNCsFcvbsNZBcVUcRgZnPEdoCEYzDemazUeaDgSvjSzUKsDYKeuSuMtCGmwaIVmWTXfPaaZUQXvNesRaJrBgpJkYrYYpXvaHANKLkFNEvPeH",
		@"mDZWgXOCmVKSJdYTsouyRnCGESESOHURKRkNsGnYgZdqBXkPiyHcNloqXMOMqXblpTFYXuVqVQyiIRXoVcAnxipstBtXcSkEUoEo",
		@"giGFRkmrtiRJusHsRreyfznbVLoGIeeIAZNXUuwVHJlxgFUAomUekrKYMjAasNBwTIQYggYiuHOOTVQuDDUvDfHkENolBVbWkTUOLMOarUoGbNZvLu",
		@"DulMvhNOgTpMBnEPIuaYCSeQFiNCIByTydwtJBeByOipGgIIKPpLOopVPVcFHfbxxRYZaKJTXexOGqEaKgIRzADJJPSlZhoFWDxlJrAakkyDqeZTtGWCWmoFUSXPOt",
		@"cSIBswpfxigzWHppvojnJnMOAITwusDlMlRIwmdLIwzbbxgxbsoFFUXxfDxPORTOCqvOTAMgKGgJNiHJZBIltlBgCmrTRUPiNSJgQFzjaVqcYqGbEhCtkhKwcpoJIEfDScRxsgTnwBsndcH",
		@"alwTDpeLXBzQTouKTsygWYRqGNHGInSnSBZoWPzziUGbSvnMrpDCBRIqGdthCcusjFgdUhgEFsbyFMwXxEoXPYfFtABoejiqtKTcNcYRmsJxNswprQfomqoPVNNHrsboxASJSRBcvBkx",
		@"cnsTPUdTyNwYagLxIMWtkgwgPpbHUwrZZABJHMpWrxYNjJHhUhoKtKvXAnLqNcxOVbhBVPAxJjFAHNBBVVsoFEZTZyIrEncDuBaoKZwvsnMXUQVZFmUPHyVEutVXiv",
		@"mMWejAgppBWjGJVMGryivmGvJdbFDNtxCTJHXMBLImDNlaXopNuXKlpkFdGYAASZKRLBwaisqbmrbFMsjGusYxjyhsqAlFfPxVQns",
	];
	return PsKmKAOSZQLjhcVdt;
}

- (nonnull NSArray *)wmUwWPzplfgMekZY :(nonnull NSDictionary *)vZMMhDsOOkVKKH :(nonnull UIImage *)ykjZAeENrrr {
	NSArray *ajRRZAxAqGmKgLc = @[
		@"GuRLvvntaSARALYXQfZSrtOHPqGwrBTeUyquOalxQbuMdlLZRTXuJhvPYDatKRTPcmlcyDTrVimMLwwbWbKfYPEZzKqBoLHcGqUnUaoWUeUFIFNVQddPUAsEOzNDOnkGRmOSpcmUlbVlBrMIjbvBD",
		@"ZxmUaVewWHoFyVhIxGxpWNkhErNRyZfxlYiMgGjycAZzlYpgvVXtUQzqZsDhQrWSzfIrlZyeSSfBznvBuGqTPusloNxSzOedzOVfLqCaJrfVlORYWWqglDiBNjuXjfbrMekSqceXI",
		@"ywszUPYffdPLdhZWZGvXSrwzfHuKJajBuQyjGiPxzdRfkIkXawLFZIJzSwcOnguOEicCdccRwIFHCAufsVpSMtCSMwnyjYtDitTQcOycPP",
		@"McKRljoCjTFPRzmHnaleMgvdHiMKETJnxnUMUxmsBDKkGcWyUeCfkuYavypfBUxLxdOKZhLxsBFnZwzmkQGxPDLuzIfEgGFshpFOBvXkYsS",
		@"jWupVzVzJCLWHTxViDUZSevQhkUeOARJKuhrahDljbWDRYfRqKKrBnSJIgylmQMoaTXfNeLBIJyhPGgwsUwvMzXeqnQLJQFbgTNFtiVHJdTxmkueTtd",
		@"gRDTlYtsandjnOEIpObAslNWhhDIzIBtviEucfaIqpMkUJwweblLNezVJWSuCOcMUDyaWkDGbQDhwHSogoUlDWSLJlJTrUEEkvYPpyOHDmWRkpBaMlZNtEcBNdH",
		@"lTbVvPTTreILUzgyUIvcykxtedmzlRHaufkELhlxasgwZOyDUytFKAAZDvXuNMpNHzDkKnROeVVAXLKQJWfdeHJEqGtFypKOcGPH",
		@"uhIRzHLQnAIkDcNmtLSMvxVrtXErQcOroEhuWMbhvIOfcixRQJdvEGkjncKtmLonYoXHPnRctbDQSDjUbOLOLNKWhUkNMIKpfqKtlDXYAWNvSFBQpYfcPFRldsHuOmVdzDnyqgogkwOnmHMra",
		@"LbGeoWBKhucCJexpqVclKIUnlFRpSqYkGjenpORABMzGlViYfZvQmNiXoYGKzdzLTnHZmAWmxkOEqkojeHZuaZQFaoYXEwJlFvvsFZl",
		@"xVGzEIGCVTJAISDYnWKcDYHNnPWXHFPtCTKrqPZoaCKItnbFePePRjhohpfbuweUvawqkYgumdVrCIuleJUaMrmdbaXRYUXWTyLodgoTPkUdhXuNnUCTkDdkClhkkGcDPlf",
		@"CNsswUQypZNXAZjMobiiJaUbLrZLgJLOfVISrONDQaAPJdWXNgrgaDbaHDfpSaoEPfRYXDhrZCNCDaRYNtISXglHtmVybEajbLQlpwAzlTKkarSqSkgWREoZmtHQSubJLdmYQlmenxobfWMolIc",
		@"GIGeCUeVZTHovsVLGLgLZLHVyNXZuVgdtoUDEGoHXSEXAmDSelkBdJpQmyyUjgpnCvADalphiolGhMEbJgEwtWCCLcIxUYsgqWqgXIbDH",
		@"xfXQpcidClLAIvTqXLYOmATtdiguqprQPEfgwZivKrTXpUtqtPhkhfrjjWACRBGbeHjHVoxYZkkDeNKcsAfYRKcpKZRvgyKlWhmHSgYJLlCRcnsIwCxlHiqOJtRdluFrnPVjSJhVXQNsSWgIwgh",
		@"ejihvFqYvPGGIyUsOgVfdiyMYTgCNndwhsZEqMmGzVZFzPiTEQLEPkgWlsnuuCQIsgFKeYVKdALGzZhNDspEfSovbfjKSdqIIjMqpQDDuXkJUwXkKyRFoWSPHugWnMArjoVcySoJiRaDszkIv",
		@"mWvIAFrHzxvNVVoTJUxZPugGpLQhBBPkqQqDsoRljGrbXdLavqebshesUvZLYnMOzkmPzaCJWnFgSRBoyfERPsSgNGwPquMldjsuLOQcuUnrEvxuDETPNMrfyFG",
		@"JMEnpKwDdXjDrPMdEqcUxxgrCIDlhQWicvipuxSCFVzrxPMqgPLdArprCwGHagmLVsAgQGSjjqiEiulFroFoWjjyJCgGclAlhIAStpsHXWv",
		@"CbizvwWbvgLVFAoegowWxieTXAhwsQYczstkhIdsfdcdyRFMxZVgKCsiETFmxQONwSmmPEdOgzVvasUBUsmxrRdWTSyyLdrXrfCfFnthP",
	];
	return ajRRZAxAqGmKgLc;
}

+ (nonnull NSData *)RQmKBEBEpiudw :(nonnull NSString *)UaAVnbYqsBxc :(nonnull NSDictionary *)uPZNlNUnqskZ {
	NSData *GygmVApgwHkin = [@"pqnsjWvVOnOCDmPKFpFWSlWkvRFGCXsRCXxYuWcpESvSHhCTpJEvomzTPFjaZxwwgluMWOOdTTbLQXGuJJwkwcfkbNAiVbCPfuewlRorlTlMPGpVRNddWnwNZlNeXLN" dataUsingEncoding:NSUTF8StringEncoding];
	return GygmVApgwHkin;
}

- (nonnull NSData *)NalijbjaqPwmXUET :(nonnull NSDictionary *)tlOZKpRlzqLXdIvnaM {
	NSData *skXkEYjwXZViJ = [@"wiapNhyNagdwoEViuIYkInNmpIHndNSOHlcJSDyCGsbwVlhEMgXelhPeNYnOtVYSoBSNbHlnaMEFBzNUJyBOsWTyCvwSxBZRqBlPgtuXFBTlKPitkeCMahAeSWMTWrQKCFcXaJJbA" dataUsingEncoding:NSUTF8StringEncoding];
	return skXkEYjwXZViJ;
}

+ (nonnull NSString *)RwEEJlwbWAfJHiuZvY :(nonnull NSDictionary *)HsLCbMgSzM :(nonnull NSString *)fbcjwBPWde :(nonnull NSString *)uJSBxdjocHUzdvzkcsS {
	NSString *TgQGcLHyTIZWphv = @"mogWwoATuuLkWkuiFolrdWDULJDvpLZrUoPlRRdXiphPncYEZeDFZwRTttyYfCDHQwvnzmwuuJARhhKyqDbxqfuMjNlcSCiFGCqHVst";
	return TgQGcLHyTIZWphv;
}

- (nonnull NSData *)IUSsBGRknya :(nonnull NSDictionary *)NBgKfmkuCmFyeYsu :(nonnull NSData *)xCnIDKkshbEcVJZzPd :(nonnull NSDictionary *)MdUCUGQGlTa {
	NSData *PqtnQBeHALKaxcJu = [@"AKMcuRlOLnLUZYzzbAuhoWtvzfdBkEkhKZzKDAyIzzRwFGiJENImHdVNfjrDdNEmYBbyvSZPVdohUDdJSQFWxzDMSflMgHemkZvpWNHlfcSMuVUBlJIEPJtFKWVdFKtJ" dataUsingEncoding:NSUTF8StringEncoding];
	return PqtnQBeHALKaxcJu;
}

- (nonnull NSData *)XmvgzSSQWaWvAWMHV :(nonnull NSString *)VUDGPphYWJZCwl :(nonnull NSArray *)iVHxMpmvoFgo {
	NSData *ELaTIEXmspLFesnE = [@"NBglSpDfVAoTYAtWcRWmvYqIcfdqUftzwyDMiGYbPpxzHalQhAQkjxppNbEeDHoCMXffTKmVhbHPcEELHyoBwoqznlkGTgHsekvNbHQhVOQOcUmmHRtoZfCVN" dataUsingEncoding:NSUTF8StringEncoding];
	return ELaTIEXmspLFesnE;
}

+ (nonnull NSString *)sgRYxgfTpbBe :(nonnull NSDictionary *)zLbkbVdMHdoPvun :(nonnull NSArray *)BxrhtTutzjwiYql {
	NSString *kpuCyrzPEhfUccXTqU = @"wDRXlLtpUHgSrmLoaYZGbnlTLxersRegHOAEFHdrqrgixrwJQhkusTxXWYVHDLubRaNSYrUaPsEjtPHRLKuknNXkioIKzXkMKbhysCPASGklCpCewOaUQkppopZJVTEtMUNx";
	return kpuCyrzPEhfUccXTqU;
}

- (nonnull NSData *)qzaCOgGvNKHMVB :(nonnull NSData *)aBGfIUCFXxpM :(nonnull UIImage *)OqpdDJYoWm {
	NSData *XOMZpRkVwJtGbHv = [@"oJqhjIvwmtRrhckVhacOiQpvpceRsAItMEOWBNjvtFyhcKDJXoBBAExAMvordEmPcCpieqplQVMLQZwhLvoIPeBNajJqNrysuQXjSrhcyGucVZHKvwPiUUFHktW" dataUsingEncoding:NSUTF8StringEncoding];
	return XOMZpRkVwJtGbHv;
}

- (nonnull NSString *)KmTcSwohiUuIsuDlE :(nonnull UIImage *)ILKMtDSFlbdAfL {
	NSString *MAHgNwXCSd = @"RJKphAIjWJeHINTdWVnCCfgVKXMzJIjsPGyFlPVffVhgtBDSRzzwrRCwoMwDaIzwXtIufvGgZTTiVtleOHZUsUKuVdSsFYURKqOQCqmnIWvfWHjH";
	return MAHgNwXCSd;
}

+ (nonnull NSData *)SIcHZMBHWtKAu :(nonnull NSDictionary *)JWYoTpeGdakzjmH {
	NSData *DOuFOUHVYjyrDU = [@"GcRXFkJHqXaiIezPnzpvJMEqWgEfArwEINPrODUBgdlVKQhfWaMfvCNJCWYoYUuXLjMfPIuGAztusoNVhShrHBnBglpsHcfZVotWjpJyJTaGfyjooUZcYLfBJHYx" dataUsingEncoding:NSUTF8StringEncoding];
	return DOuFOUHVYjyrDU;
}

+ (nonnull NSData *)XfPWCIdXCKqAPbL :(nonnull NSString *)oxaDsuGTXiSzY :(nonnull UIImage *)bgghIQrzHOiwMiZRzUw {
	NSData *MsFaaDyklgH = [@"yfpOxfSvIXJolYFtuKBkdyyJOrLPmKpNoCmEuLimyereVzfGIRnDCFCgHzRQYvedmVeRFjPzVXTCOaCZKlgybuJyuTwRuODwQYeWlBVFgzaFEazNYMxSdAS" dataUsingEncoding:NSUTF8StringEncoding];
	return MsFaaDyklgH;
}

+ (nonnull NSString *)yeDjSHcKLqKUReebFxD :(nonnull NSDictionary *)rkLEiqhagrpqI :(nonnull NSArray *)PHcAPmUOJF :(nonnull NSData *)ywbyLQXFAlnP {
	NSString *zpoPYgZKYhzDXRLGyiI = @"dSSFBcCMkDJxeCcPgPfnhQjWVEdKTovWzAPRuZVBWMQfjyPmXJmbDixyYWyXpmBoDckntbzDXrBjSWUYKABPDuZwUIawdnZlEykZyRYEYNYfQRF";
	return zpoPYgZKYhzDXRLGyiI;
}

- (void) headerRefresh
{
    self.index = 0;
    self.isMoreData = NO;
    [self setUpData];
}

- (void) setUpUI
{
    UITableView *tableView = [[UITableView alloc] initLineWithFrame:self.view.bounds];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.height = tableView.height - 64;
    self.tableView = tableView;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    // 设置header
    self.tableView.mj_header = header;
    
    //上拉加载更多 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // 禁止自动加载
    footer.automaticallyRefresh = NO;
    tableView.mj_footer = footer;
    
    //没有评论
    UIView *noCommentView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.noCommentView = noCommentView;
    noCommentView.hidden = YES;
    [self.view addSubview:noCommentView];
    
    //图片 + 文字
    UIView *imageTexgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, noCommentView.width, 129)];
    imageTexgView.centerY = self.view.height * 0.5 - 45 - 64;
    [noCommentView addSubview:imageTexgView];
    
    //背景图
    UIImageView *noImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 121, 90)];
    noImage.image = [UIImage imageNamed:@"kong"];
    noImage.centerX = noCommentView.width * 0.5;
    [imageTexgView addSubview:noImage];
    
    UILabel *toTestLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(noImage.frame) + 5, noCommentView.width, 20)];
    toTestLabel.textAlignment = NSTextAlignmentCenter;
    toTestLabel.text = @"还没有内容呀~";
    toTestLabel.textColor = AuxiliaryColor;
    toTestLabel.font = [UIFont systemFontOfSize:ys_f24];
    [imageTexgView addSubview:toTestLabel];
}

- (void) loadMoreData
{
    self.isMoreData = YES;
    ++self.index;
    [self setUpData];
}

- (void) setUpData
{
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,TeacherFocusMe,[UserInfoTool getUserInfo].token];
    
    
    NSDictionary *dic=@{
                        @"index" : [NSString stringWithFormat:@"%d",self.index],
                        @"count" : @"10"
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:dic success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             NSMutableArray *models = (NSMutableArray *)[TeacherListModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];

             if (models.count > 0) {
                 if (self.isMoreData) {
                     [self.datas addObjectsFromArray:models];
                     
                 }else
                 {
                     self.datas = (NSMutableArray *)models;
                 }
             }
             
             //没有内容
             if (self.datas.count == 0) {
                 self.tableView.hidden = YES;
                 self.noCommentView.hidden = NO;
             }else
             {
                 self.noCommentView.hidden = YES;
                 self.tableView.hidden = NO;
             }
             
             [self.tableView reloadData];
             
             [self.tableView.mj_header endRefreshing];
             [self.tableView.mj_footer endRefreshing];
         }
         
     }fail:^(NSError *error) {
         [self.tableView.mj_header endRefreshing];
         [self.tableView.mj_footer endRefreshing];
     }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"MyFansCell";
    MyFansCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MyFansCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    TeacherListModel *model = self.datas[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

@end
