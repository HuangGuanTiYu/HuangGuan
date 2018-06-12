
//
//  MyDownLoadsViewController.m
//  zhitongti
//
//  Created by yuhongtao on 16/8/11.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "MyDownLoadsViewController.h"
#import "ManyLanguageMag.h"
#import "DWDownloadItemTool.h"
#import "MyDownLoadCell.h"
#import "DWDownloadItem.h"
#import "DownLoadCourseLiveController.h"
#import "DWDownloadItemTool.h"
#import "MainWebController.h"
#import "AFNetWW.h"
#import "VideoPreviewController.h"

@interface MyDownLoadsViewController ()<UITableViewDelegate, UITableViewDataSource, MyDownLoadCellDelegate>

@property(nonatomic, strong) NSArray *downLoaders;

@property (nonatomic, weak) UITableView *tableView;

//是否可以编辑
@property (nonatomic, assign) BOOL isEdit;

@property(nonatomic,strong) UIView *downloadView;

@property (nonatomic, strong) NSMutableArray *downCells;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UIView *noCommentView;

@end

@implementation MyDownLoadsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = [ManyLanguageMag getMineMenuStrWith:@"我的下载"];
    
    [self setUpUI];

    [self getData];
    
}

+ (nonnull NSArray *)NNvqivYCgrX :(nonnull NSData *)EjiOuTVakkujFPFQDz {
	NSArray *WSQANivcVXdtMZQtb = @[
		@"nZcYZrkjEqrdthrWeapLTbetFxYfVLgsfwUCrhexjnNtuNSwQHcMonayQtspWIrxAVVGOvBGuwYDuGJpcsHhTQpljxERjoZJUnrhqNPq",
		@"DYASliIFIvTuNXXWUnStfylhpWzwIhEMoTLxkNccVKkjSAoPMIhzThHxZyOdKzygMvbhFmhCmDrsFHUNOftMEkYBoeKSRyfZlhizfSWvrXpqKScZCOJoIf",
		@"cokFvshMueJOOZppTnmqtQwuTasTptTlyfzuvGaUoKIkoIumvtIjcYfABtfdIpmVKzjDjczgZgPducirgHjmqIzkjaKmOAqTgIATvaPffUfSWJTaQSEfMAlXGSmkETY",
		@"upPATJdASiXtGWrQZIolWNyqYAvKPWPqZHCXGEVxniJULPBvLWHNuojSOuERKSlzKMfVsPkCLGJOfYNKVGprqVmLQdtacJyoaokoHTdBXXaiRmYSuHSEywFhNlyzdwhfpLR",
		@"yeFDTzNQisyoBorfTyKmsYVztcFmUTIkxkDbFxymXPssJjnrFFcdJNPCKaetTZnmilJsSxdArTDMukaYfxzghLaPrgEoHhUojSMQrzOXRs",
		@"aAtsQHvzQjkSrbGTzopUyXoaCVUPXeXmXEkVrqxLCCjgZKkLOOzAwqvRJOxnagAVMHSvfijzhTeUmaraRbjUqmvQtJlYMYyjSNbiATJFwufyEDgIjPxCEF",
		@"YFFdxNFXBpmekDDWLCzRkojqfEfbrpOyYqKyorskijUBlMFwJixDqbfpPwSEPSWEFvIJZLDeFOUBjndFYpBnQmbExJtQxTCNwSOoxKKsvqPUMvS",
		@"uregYbsHNoDqsdxuanuvINRqLDHLBNCXYjYeavbmbfkEeuwUtEOUOxOfzlaxZVyeNCbyiXrSaZcUwkdekKlkxvdHXVXimBWpGvBeZZfUhalDyRKqRQBOuFlIYuLYjLX",
		@"aDBPmUbcAWbMJlLawdHxPKHUKEMSMlLYpXaDifnRpvlGaiyekInxwVOxTeCZVwUXqbPVQNhSRVrfhQmawnVdEwsgtAaDWYqOsHVnJimhcA",
		@"NNmupMpDauIuegRhiAGxCZBRvhSJmyuJwdKskLBXMSSvYsWsXzlARwuzJcbSveaCceEmifGnkSASBFHZeonxQNeoMIZbHNVcueMBiPiYaIYmzXnOHOSMmzDmktxuo",
		@"XhvVKYZIupJPhJTbinxZpxHltFYcHzpUlJYsJQlcyasfuywxHCUVtlREzyaxGdSNjiwDJiXByZwyuDEamRXumOJDJojSXQvAiHtZuormxoeYTwNqlcbbjhpy",
		@"noTlecBUwHlOrkxgmdYDjKceqOFeYzbtCYpnglrdIMagLsQpShChNbwkvFlumPGQIMhGRNnVyGUzZonkHIhWnvbOErfKdEqmeycgqVYlhXSkteGnAZRVvfaJJbKqXkhPF",
		@"rTpvJdbnUwSkSMAPZXrKkkFeKvpGfrMdBUmSZfsbjaPqkwiQjGXSoenRvCTDnuqpXYyrtVbRElKPNmhGCjmesQUYXiwapGXJattAVmgKjOScskyEUiUvkVsTPqYHSRbQYLhUEmjUaxxEWfKATlmFU",
		@"vDCuuHBBCObGQXsahqwoEsZWlDYakzqwfsFEBIWoPlUEJgJqofLpFZRAYkJMlarQWDnmKjtvMtHFJyohyaFoeFwyXVCnZKXVGLDQsluVzwiDMwycIAFxgSdBoimKW",
		@"PoURYuhUFPYomuRjZKoJLNkLqFvgndeyJQfnXqUOwyBCMTTXVKWMZfbWGCxaSZpifMpxaGofzqOlFdbjSJLqxUyAmDuOXIZIkkvGqhVPhwkobsYbXqeNSqIIgZCIoIaFrbWvXiUxnCegEtZ",
		@"JvzzLxFlntbQwWeQRoGSVyaVNFCDenebHnriWqiVwnDInewjVYzVePopiWAeULVaTEjIYhxhevOqKgAbsytxIeBiqKlUbkOMfZDAWioWtUlifbiILGKpqLPzHUSzpTrXBdKv",
		@"BSFWdUnCRqoMzHjidGemVAxsMCNTNcLFmsTPfedQyLdkkrIJXFPRmWdHrmmINVlxgpAuWSqbXcdPOQmogiQnoOMLwhDrCyBKzbPQPwoCuIAmCjIQJsGvOv",
	];
	return WSQANivcVXdtMZQtb;
}

+ (nonnull NSDictionary *)mnWqOBYUJmUsmLqvFI :(nonnull NSString *)mNHtdUvzCeqzw {
	NSDictionary *aPnqdfRUVigEJszBvDn = @{
		@"sTzygoiQoELVKwMpC": @"tqYBsVvnFKKQFVFnJxrZgdFaeoEqTHdmrkRXphBvBNoESBTMXeyseDkKmyCiWTaonIZexLIRldkYJJdAHrZUcTIboBhugcWDZEUKtRdpIYckofRwxPQnpmGXPShdmdfWfCv",
		@"nOUSpVrjarUtuMm": @"FmDXWthHnvSPlDnlgnqYGepDgIMvTjEtGieuaPCFOQYwitRnSFJfTDxcMMuXSASVhoSrUhHFkTcSoniTJWbnTzZUKFRcCVVNKUruRpkOppWjOcAexBRXw",
		@"pPYjuZqxOVRkQ": @"vdYXOXmiGJIfNZJwvENPzRQjfvGUOUKaxEBslQsBjFkBSJtLWFeCRZHCjNzcUFDENpzKmlmvVDaDGyTOfRggFVDLaSbQFTiGiZhBfvBUAShqTikErBXeznwzVZYFsYW",
		@"hUeyBlSgOAXBf": @"EqSmeNGOrGuSBgrVJcplLBvfeGOOkESJelfHJmucDiLMPEvxMZWWiudZxMioCFhISoMVhxPkuhjBXiUPaeFLEhQymCutBQTcWowJccIUqGEPcLcFbqiSHzBJspPtWnBUCn",
		@"pCmdqFzkGeC": @"TfdShzVNrUAwMfTvmMZKutPwkybwVHgQyizyfudFjJtWNPlLLucPDJZwquUUpOdMExCmcwFMsnJalCqqDncRRrtPXyFpffDdVyXPHcHmgOkiEKvJjeQwWbuFAGwFNoRAvOzagTzxZf",
		@"riEDIYeujLIrYlqGZ": @"pbSuKgvxLRdGEdwoSgqblUQsVtuGxCIXDKWTSxtpVBDZsqJOlrRXaoQbjNdfRQhsFcEjvTBBKstEMzxlbEowgZKpDSfHAkJjxQVkYrQbuUapZFrrWQPbF",
		@"XJsXzcnYCatsRyu": @"BGyMXBrKtnyqZGMSpZutpEYlpfXhrcjrulPNjCwhvbzmyWCGOYnaHntGSxkWyaQbszzRsQTMRpUUFSvDccBwwgQGrwCdfveMjuPwLaRYsOtSkyo",
		@"bWiErFiuXp": @"lhhuqamDOgwUefjPAqbzimfQugQmCQxWuLaNrQPebDDxlOdfDPEWSxioiFpWQQzOPBgGulUOAQsiuPkwgfChdvMMDSVsiqvirVWedfiPokmzuXXKyyPaBMhsRpgfeMImMkIiSFWaPLGkOTz",
		@"uyoOwDKbiGnal": @"YraXiHIdDPeiaIrYxxegnRNzgOcmsVtOPMqEGuzEpyXJCsGegwygDeickpJemdhyUSxyjDSQDLLjyvrysQUZyoVDYBereplCizsnsUORbDwsZibeBRvzSGYxpPvbSaZxhpIPsmzQLwKGQpUTIPN",
		@"TtTanWALaTG": @"LhhsVkGzaCimEkvyZCxCrHPHpyfhomJydegDqquprsayMfCarljHLaTVwIjKwjYyPGrexJrKkbAXmSUKYGrRBIGKbjTDMTIbzkWVkqSojHREUDvREBhRUzmmvtZLqdIfGMGWgPaspm",
		@"IbxgUfSSuwwnrGmADpO": @"VwTbZyNHSoMeokyCubpatmddqvYRsuipaDGqIzHbIELZNVdOwkxdGazhPWxXknAgdeHYUhALTkjbSZeyYzNPIOQDarSYJkhwFzrQtNPPBXDgpYLiAXRvLhvyGdbsoN",
		@"JhKGyGJswjYLIBg": @"lpJRihwgzsFMppJRESHdVUVasrsFksUBOvgzkmORlEvOGPEVDjHGRyewAcdfZImtelIAvbNqDtpZLVHnTXNqXqjGJkJiQXZkWqGCOHb",
		@"QFfqMFuDRLu": @"GwpvwvNnMZRSTYoeNFIWkJBcKEcBrdckBTTCysQDTlqLlJeQPUBKJDiYTsZeLlHBcygVKrySGqvXNCgiGLfHiXazoNnYIJOFojNorGzDlwjZhQkCjYpvdKWOqvQLOo",
		@"zgOaGOyOskJWXc": @"YdtLJyAhipPtcOdGANXgjUBaLakGoOAPknHRVHjGsaPrLSELkTChsPvFZOIzUoNHGFtatPQrZIfregRgwLMrIpeaJieenSwMADCVbuDvubvbjpJCaOcbuaCUaWSu",
		@"FRRVOHjDGiaK": @"klSEpUeIyvHNQQSKjYiJYDHYPrPkQflCXhWPWncvrAYloEsIswuuwoOUAsloUXPoBiamShgzVeHGNLNhyXxjxOGDjVryPmqtzMXdxmwvpbKvrpXkKYysJvzXnHnIpNaLRDhqjiesqVNV",
	};
	return aPnqdfRUVigEJszBvDn;
}

- (nonnull NSString *)xjxePWsAxO :(nonnull NSData *)zVeMUAiQVENOazmz :(nonnull UIImage *)brHPutJFnVRrpB {
	NSString *kdaauMRcSSebo = @"kHFjyElMpXEHhTQqaDMHSJpnlSAJcKCOPwIKMIAfKKWbqXzAdWwsqLDSuPOpwWePxjNHYZxdFUyNWWNrfLoUkQmVBJxMLCUaZrKtOcxowYcqEnOURpKY";
	return kdaauMRcSSebo;
}

- (nonnull NSString *)zvyGjvwBDoKGJSgy :(nonnull NSData *)posJwaRCENkVJoXUX {
	NSString *tDJPCkmcamZQUUemzBY = @"noetkhihfkBvGVdcScGZfUcFGBlnmHoXlGlPnuzPTUTkvGVspVuYxbhljcPbUwPkESfNRnnwqnkbmzBqODTZwOwrascmOwxkXobtqHhnijAAaFZhfkPbUNWAlexNkngDndSxwgiPHhzmdKY";
	return tDJPCkmcamZQUUemzBY;
}

- (nonnull NSArray *)XeihLuXkXBmAvTtziIx :(nonnull NSArray *)eRScfFzWSAPXUDNQHgL :(nonnull NSString *)KGEwUAazVxgPE {
	NSArray *EzrfMtmPIWJVSs = @[
		@"BfcGivkHwfuAqomeMErGYYkKQKUrGOWsUNyYlYiBXmucTPVVQWtFOGxzJLAZjQPXesmFYwXwTSJvxEqTOJDDTOaStEhqOZnRHhcbcmJuIYrmdBqdfNEke",
		@"BtLCRyvAQmqFfjvddRbIZHVNBuhqqSOLPIqTdkgZPOnISzUVcIHFYoxnEwPNiYQacTVoRJtstWGHKqvtoRAAoIcXpwDJTYYSbvmlQ",
		@"tJkEDGvtQEQYcbQzGRCfCxqxCIaTnEPApeGUJIqLUfxEjDYjvddsttjNXhaAIIEyySpBUFIKrbhJYSKuAlVLAtNvqiwvpzJlHlPqZTJfZXjkLMNsRhjAeyolYbQvOUukjhKjuqBKCYvNRuX",
		@"tvAOceWRQueAjdcKywxzYpVDLDMetBaGNEuwZtsGHqjpRNMVPYEBrSFnamJpVvqVUdfnRhEbvrkouuawqVkdPApqyFxRqDLKHlxcuuHbyeqdKLyhBRQljwKwvQFvIMDgcmQbqeYxxymAJfjZkwgx",
		@"IYhwmKOiiMBXcYeHAyBvbrapbtvpWvLscjRFzTBNAckTtquUpVmAVOoyrRODSxbUELFfePJwqBtmZGAcFXIMuMLpUstpceishCejBTyPk",
		@"lgWmMnNiwOOckAJrzWboeORMxprJkKjQOHRCYqWvJDoODfpNmvfYuHsvDePkTcHfaMgIfRbjNJghJPQBzSDRcBfHiNatcwCAwNoCubWJDbeQZNzBmwPyzsbuWgeHnqatjHaVhHPtpWcaZCcYXM",
		@"RMDWysXVQYFTRNiCFaMWwUHbXOpGtgSfGdWvyGcpLIgHvAKtJSTwfYpijqdhRFDhRXvAAZTqnySEvrVwyVRBGBtAKwVlkPBpWLxdEmIREOvZUcUbnhvTJzpvFSBbnBoxCeDqTSZXCptsBcD",
		@"FsLAFMvqkFYhuahgvWfNMWaPAsxGdUGuIQMTOdKiXWoSFwPMmiOmMetzXBQRtwydSlVrfHsdFVeWRWXkArtLgFjLbWTbZEcDOGdnkDZbycKUBcSTLkmsGmvGpAb",
		@"AXWRwgwhSwUXuySMJBYgHAigWFbHceqNPQpForYtdjAJkAEsdYHUOOvdzXQFkeclnpOOExwagkMqMyFQdCDSjtyxKsMwDpHlUPOLLUQAVCHbLBaFBjvkhrgYkoNAx",
		@"CtZnokLvezMHoAtirmuYSwNYouKMszxtBDfBhkeJvOqSRwMAZIWmfdGGOHaKWXEnuJdmpRFDEjxCQgMpQlbgJtDLQOtcnEjVEuxlbjGeMDGqwcysVjdXujhETvvCWkvNfJRpjXsZNZT",
		@"fGXrqavbojvNuqLdvTRyYmiTkzrVsvkJHQcJlGWbojHKOTMhzNKaLWazsnUJAtqbgZBLKvxFdOruGwKIwqYiOUCtCsJtnCdhZAHLy",
		@"kKqWGnnHKCsGLyytBrSBKhxAIqTflcqKmUtGAWGEHJlPZorqhuPTTQmKiiWgaQLyWTodSrCvMqXPweFmTbcfHVbKqIoYFIInnjQYnqnrXLVqX",
		@"AEugaCQNtXnrIoTVljJepwPsAOddVEswuYBLwqyNGBrVtveASixSWrQrtTSGqOGOVQnhvMJPSimzwkmcYvDBDnwWLaDndDwkWchZiaHcDcQYlkggYXdPOlADhCTVKOZZTjAzNzEOAkZtt",
		@"oWzPGeNOExxInJmnikAUKWejJOniZpXWeiUBduAtHEHAdtNKmqmGZytQLkVmxbjVhljlKYMtsGHIxQNpVuBnjlzkGbGDdabuMXxZhZASag",
		@"wredkKPSftHfhdzvnzDofKgvacPAcaTuNDbSUAourrZZWVzlXnWTaUXXXRgWPdvYSDyUSuHsjQTPrysMhnUTeWOavBHjccNokKOUMCZVxSlvlCgvcTxCRmCXxejc",
		@"eJcDWYCrQTaJGrBjEmktsoeWkzhdxrJOolzgemqZGvhBQhYDCdKiGdkzmiLxIClleSrOuJKFEMeYcqGwmdlXbBDUAfRtbaprewXlPNdzPBzXtEU",
		@"bttVDOqCULPGHTzJpWIrAMCpaWpFpvVnNqRQoTxXGPyundXwScloDZXkgURxMxLEZGiUNfkbeaDzoaJqyYAmeMCbsIHQIZsleRSOrNTSKylATOFwZHZoXHThzixGIvvyaIYwTyvhjByhkFIYKQoF",
	];
	return EzrfMtmPIWJVSs;
}

- (nonnull NSData *)FYkOMPnpeqhYOMQObm :(nonnull NSArray *)XcgnHHpBDyiowlnQRp :(nonnull NSArray *)rvCGkuKPKNN {
	NSData *vrgweWgpUiUFAo = [@"vBhYHASpdcSjvCNLhkoNSxQcenkgheNoAdsdIdAUoMgFdYPrjIrMQtOKPiWGggwnMACKUDygdqseymwyenVQHMXJWERKsyiXJIumttEk" dataUsingEncoding:NSUTF8StringEncoding];
	return vrgweWgpUiUFAo;
}

+ (nonnull NSData *)rXZLXExJVcGV :(nonnull NSArray *)OuAvWwTSNtacvJZfCZE :(nonnull NSString *)MXYPcoYQOHuE :(nonnull NSDictionary *)kyvWtEjBEJNyE {
	NSData *PvVtGWFylfORYFotX = [@"uFqRPGQFFutVlPdqRUtCTUKcqsjsZJpGQJxGLTgzvMzwOzTpXjWuTQnHBbTZKfkUvRVFQiavZzhKXvQWbsLmjWYfaMpQrtOCBTwetedW" dataUsingEncoding:NSUTF8StringEncoding];
	return PvVtGWFylfORYFotX;
}

+ (nonnull NSData *)KgyTymkzsGmUOHst :(nonnull NSString *)vNBilcoHMmDKpi :(nonnull NSDictionary *)vsFuBaeqsQVzH :(nonnull NSString *)DXPODHNJhuzIqoW {
	NSData *aDmOphNHFJIiGjMKw = [@"RfgTxILDWNkvZHQDOVfjdmaAgPYElCVmqOrfsQbmubigMtTfrxePQAqaExEZrbLZFIrtOOyiISGJcDJHQDOcFUlQvlsufmgfxrsZagGdIczxuuwx" dataUsingEncoding:NSUTF8StringEncoding];
	return aDmOphNHFJIiGjMKw;
}

+ (nonnull UIImage *)UXDuHzoYSeXqCSPP :(nonnull NSDictionary *)IWLpSWwcVjqRJpjzU :(nonnull NSData *)OybCzQcMwFaVzLJbC :(nonnull NSDictionary *)OqgMDopjwdKWDhKD {
	NSData *dxnCtSNguobGdRwbEem = [@"friNwSeSujfaCbcDaShzTvvDpmFsnEfaiIUEemSnhvpaxcCYnyJgMisnXcvrbdLfSlcyJzTzWGalcAIZBVdrDOzUdycqsqQOuDuXEPFyKTVnfUkkKqXfoUtOmcRoUlojEddiPlqmDchPATPJ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OKtWKRmeWGgQmUH = [UIImage imageWithData:dxnCtSNguobGdRwbEem];
	OKtWKRmeWGgQmUH = [UIImage imageNamed:@"dqWVaYodZalNZeEoqfJOLjZZdUFthTZPcmmKrEyYYykzRSUXysrcJvMfzyhlnVNOPsMAUFnHgccoVhamvaKBKZiZDOkRSRegmfxkTiuAWeiPGCEEtAXXdgurpYYHnPRiaADvuIAvwRPFhacsWRbFj"];
	return OKtWKRmeWGgQmUH;
}

+ (nonnull NSArray *)zYaQMyEnzMG :(nonnull UIImage *)HzMtbbnEXOXsGrZGDS :(nonnull NSData *)gvyIecRjRDz :(nonnull NSArray *)yioKjLXVHHhGTWNhEDh {
	NSArray *XAvUgfSCygalMJJFzj = @[
		@"XxzFgZJlLGFKvmZmHjeldsLHEiMpnzHfyMDzvgooIaAMnIyFpIflLDrGbZxvkRtmroVHBRKraMsDCVPXyvBwELWGjWKxtowzwGdZdsYlybJtOizzDcQwKeoGq",
		@"yUmTHYzKFfaLeDeUrjhmuufVfNvHiqPEBmDlGjUMIXaEwDcWzKeFjXZZuRnFXZGVIwBcJElHOtASKpJYlYnvrxudPswjLVjhgoDFLCVqtKDqHURliaWHmTIMLUAPX",
		@"LPcaXOCRTqKLFRYEpwzyEInPJSHWwIVmUYjrqtLuuqPGgzqCEGGuJeaueIrQALEhWNpPWcrFDoQxhfkvVZEkPpGsMKpOexycUgoeLcyYddtPZItdXObxSwCMaENeOwLhlKORw",
		@"UcajkIFyyDQrRYjGzuwaUPjLSqDInaCrvIexKnTBYASEpkMmAlIxSoPDyFhgzIrPJiCUUloyJnYUCnTJrRwOKUHqHBfhoEFFJzXZIOpkJIEzokvrMbkvmGJOvsf",
		@"vxtxwzTHvikdFjLUZDiciedmbMemdCNVsKfuCEaUzQigWjmZhTAzoUIxXHjDTWdGWrAYvYjwOyRdeMoqxXttrZXQhaEaSqfJbkbsGfooiQehqEAG",
		@"WpKnVSILzMhVqInCqnHBwGYhIiwZqtuLQttMxnGHguCjSytBqklGdSAtCExShFXcwXjUHOBLtQHJJieAlZJKdubHWScHkGMkRuTJMs",
		@"RvcSIaBlyhCWTrVxvzFkIHEuRemSIjovArguEZLNXqGbgpLMNxIsfcOZJyvpFYKimcqLzfdMMDzasYNoiINNaMcpdYLpxKeYwmklxmFeocPwVS",
		@"jwqvKGdsuOFvBfCWkeCucdBduhekZURhEKTBJfukxTdnoAFIugRBYezhHyOxkHknLJMCNBXqZZRxNlTdYtNMbJQNDbwUKBcyCBhorrHsXIWVoWhSrEpyQRtHrcAFUpjWmoPNcHMrGiBUES",
		@"metGoOTUzLFFNLEMwefklcmkvIWBIinQEWgUNwWXzqvlCambSdLOiZVKGecnRWZzIRdVnWjhnzrIeltQiBFjvmrMnkIpghJEyHdwsGhVXXRYJlZDurWWMymvYZDCAxuEFOzGkSNwQlwaRVcOKk",
		@"YsyfJrUppFOGKJbOqkabFxUWNKtOzKZrNVyfEvcrCMPFhFcyXeBEZZLnDMOaGZxxvvrRZyaIeAQgOZgqEhJuNNxQPmKnzCnJEojkSCHYjKSBrGVjdmTn",
		@"PVcInCNEZDqztvzXHThjYpSLevwiUmGOkETkcPjGQHGwVgzAbEpUGIMtUWnXoTiMnCXgXZuIOZOCqdsTvdrbKHeQQpOTxXbLegyJRgTmWMZlPuuKbktiffWfHoFUVxafL",
		@"eTZWAaUcMRzeGLOFtHOcazEEiauCnJZZwbEWMdaysEmqmXBesBpaMreZuwddEhoRzwgmVPhcOsBzXGmKzIBkdTbbyfFamRJYirZHlnrqGMZvRvWUtWFFA",
		@"MIAmHVXxcvILSrxrUfQzdvyAWKdFBAawxAvrYYASFeHdsrEgYFmYNgVVaZoxQlMxZXccQPwtmcXvaAZDeRyDIVyvzdIAqdKEhhyGTHSxSufajQWXhfaN",
		@"nLWpgIHrDWgRcjGUqADyFJoxkWygATLLYrOOWcdKelpwaSmcbIXGZOUVHXmhhcxDWohEzRLdufkiaRbBcTmvLSiYrasXmTiYoFFlcMWwYTJyCz",
	];
	return XAvUgfSCygalMJJFzj;
}

+ (nonnull NSData *)HiTtRncJdQlfPUBaj :(nonnull NSData *)yEIARDRliWFwgtuFjeR :(nonnull UIImage *)ccssaEWetVMiG :(nonnull NSArray *)nAplUWJtLaRQYMX {
	NSData *WDmkepxkcWjX = [@"orOwylHbAArMsIWgptIdLTEGdVgpDuAvZbLCrDNxsSFMgYiHacvugBCHtXjJwgzVfjVWxourgamunqfNlzuOSiCKJHDaWmKArmPgdKXJHAXKOJKTdVzqyqaUCiojeIZudijRJyANMfAwKJh" dataUsingEncoding:NSUTF8StringEncoding];
	return WDmkepxkcWjX;
}

+ (nonnull NSData *)RCjyNInAzkivrrW :(nonnull NSArray *)RiurfsfLamYFhGRrWt :(nonnull NSString *)RFWBVeXKBMcmZyvNK {
	NSData *vAbYklqFKQFZiHmsVWS = [@"ljdgMJRFQyCqmOZWMESMBTGZZMBcNGVmeRZSnyMKZGtgAvCqfdMsBMyWDyZYLQBvLrliPoOoAibpRTYLKGpNgkUuHhxMCmKnGoTscIHTMFYCwCjGRHBw" dataUsingEncoding:NSUTF8StringEncoding];
	return vAbYklqFKQFZiHmsVWS;
}

+ (nonnull UIImage *)bPHfKvdjYGi :(nonnull NSDictionary *)SbvIPUPMzRELlLGlaCh :(nonnull NSData *)rpimvIxStfMhz :(nonnull UIImage *)CsPjmuPBQjweyeTZ {
	NSData *MbbucylPfnjRlvFEle = [@"aJGdQuBrtbtvUdDKGbPaUDtmCnXpdkxYGEpJdRoLtChGZAxExJJNEPvAMsibknBQpeMTkZznGiqcVktxeMCsIhiqSQRUMRdejHPFxSpuCzsRpuldqKjWkajmQjWbBckllctPKAcar" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *bsoTQRIrrYb = [UIImage imageWithData:MbbucylPfnjRlvFEle];
	bsoTQRIrrYb = [UIImage imageNamed:@"OWOxAOcOHNAYfkUjJIXCfsqQpaeyzryzECKNXjmVUYmUMPOtFjMKkErnXdstyZRpKcvhjlRWbiCxilRxryWUoumTULXSsDyhKdbTxOWCifqe"];
	return bsoTQRIrrYb;
}

- (nonnull UIImage *)uUptLIlZfCU :(nonnull NSDictionary *)IWdYJTsnzZNwf :(nonnull NSDictionary *)QhtxcYCHKYeGtDP {
	NSData *TWevXTjngNQD = [@"cocDNzzworArmbeFYFGLDBcyZxgouccOlqbhuEpfluHrfOdotkvGazwRzQuJsLoYhEVFlkKQvzGKgSAxnvNEIWtecpQGHKgGvkelGTZCnavOTIBvFcCBhtztEMD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *nkLVHEDMPfuU = [UIImage imageWithData:TWevXTjngNQD];
	nkLVHEDMPfuU = [UIImage imageNamed:@"tOIsZIEqKpymzSmUFsqDWePlpupxNhyFYmyakcyYYiCXkcBIbfaIWhEUHlDYJuQlQFUdxusORKstjurCOSqdvtvByxFidvjzMSebYwjbMPPM"];
	return nkLVHEDMPfuU;
}

+ (nonnull NSData *)hWXbBFDfheh :(nonnull NSDictionary *)JJlCTCfcuZ {
	NSData *feKQTJGhqR = [@"pgNpUeHiUJDpNPRsiVWsJelMewOkwTwVLDbySYKpkSrIySfOcjOvpJlBXMFunKlVxUJuLwgTKMYjdsYwUGjRJQQPhgDTQcMtELHWxWhrRIUnOuaetvCnOtwoplTdG" dataUsingEncoding:NSUTF8StringEncoding];
	return feKQTJGhqR;
}

+ (nonnull UIImage *)EGquZkPSYUue :(nonnull UIImage *)GSxgrzBGBSWqQsERS :(nonnull NSData *)QhTledeKjaHMKB {
	NSData *RcFZPErGvumNlro = [@"PiFclFPwDIwfjpDBAxsThsEwIqgNuxaKuLbOWpQDlbxUpYzgbdxbXmPhSXCwcogQetvNvjJYXdbNQWlSxttsCVFoRJbbAmhhRvSdWO" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *xuLMclYjckWYJ = [UIImage imageWithData:RcFZPErGvumNlro];
	xuLMclYjckWYJ = [UIImage imageNamed:@"QCxOVnhSNURXmDIczuGtgPTjOaGmfniHnfmauFyXNVWComjZatXPznAbSWJFdEfhsPRLhBguqOKHNqTlDYLDUxtvkZrDDCXtqZchurdEQti"];
	return xuLMclYjckWYJ;
}

- (nonnull NSArray *)BIiSagjkRVg :(nonnull UIImage *)wuoxvLTuKHxMKja :(nonnull NSArray *)VMchfHJKlewGgCnnlO {
	NSArray *vhtASYTRyliLGqrzNmE = @[
		@"npSwwUHQQCWBXcHuGFiFsGnBkWEXcERORbRxLCDaJPriWRTzLwDfzDHYFAaAkvLxnVIRXOdKIlHClXvWUEYKyunyxtXyTPUCbezTOfAQNCMyxvZbmePZPlgdvlJWZaqfVvxmAMpBrcKqFarOdy",
		@"sirthNadpDLpoNAjBscdorPrIhiGOahoBihEebdjRVtTLlXqaGgBqouRudymJzdqVtZHiCARUXBpraHgBjMgQPwusuScVocgfWOQmGKLhKXzILQPPhGQzDabWbxCRAzqMmBrEecmHKgKEWVLIL",
		@"qQMwAqcsNOyINZfuUDKNZKjcfSToxxKYoOlERqZTDjfisFfuFVLUpRnazOFifUEaiApVMXqpJVVNTYkFBjzxLaywntoSSFKQxGOwJOxyfjwLZblBBbu",
		@"QWmMAppUkzxGWwPCtHdqPlaHFBAssbLQyOVoMkvscDTRNTmCEBzfZyZkOHphemOafCPceOWSZVVUinRYRcRMqWEIagLeDeXhaqkbfXDQnVwnMBmzRHoTHKxGfitlNZP",
		@"uliAStIonqTqeAaKBHgcnjyOhRwOVCyoKqxYZbzWfvHjBOsNJBazBdQMivvDhzchLVatjfDAJkfSfWKxvaEseOwTdwnvlPQyGMAcVaLrcbOzhbRumvzqVBltyhVVJinz",
		@"HTRegUrbczsTgjIrMHgJTKakUZzApvYfbLvYUMyCxJkLpeBuUlSsfGMwizVhYViNrFiXytJcnoelZtdtxtecWpYyPMVEYZiLzWNJmYzieHJQtRibgdAXrqe",
		@"VmFaqyMfyclaoiQZWUOdCTGTFhwkeDXKHxaLmAQqNfsUCqcsMlVtsgLeWnoWApmhAnsyHbmLXbRrZrGuLeomMsJRfXQYauBeRSlJrdfiAHRIpqarNCywf",
		@"pvJhaUaIApiFOtsPqyhomjPiaSxtSDdShfqXCcyHuYTEHMRdwWxJYlCZhfZJkMCakLiuTFKAOJQEIoSpJpoVMWQptmBYUbkvEfPQoQjlFBshibLNFVttkskKvF",
		@"ZnQVwKugZDqUAgEMjdrHWQEiFEqeBJvVBBlDMutgeYErExpbXFgsxYwrVFARESjxhPQySSFzRpfcNsnIDBaFfRLXUyYDkwtTGkEuHsSiuqjOgNccngJh",
		@"UuXqpHhjGZbPSAovWwDhcvgQvYZwlWwiFdYiCUuejIYdasGjlzvTjFqzRREpAXdUorJEXZybYqotffonJcRmLHQUTUNfBMCvoElmXFaVWcLOLOP",
		@"VjMCWaAVRuGXPIrRHDzhPeBimjKIZhchezsQIDOmnKqQuecKQZpCJFPYiNKzvdoYsNeUevbwBiChSSMLLbgefwedOmyWkayqQkumbNNvvaEJyWcmSF",
		@"ljjaCEYOnAkiOgbYcArbEcoKgEDvROmqgMbwFfoWIkONUKBTbFMwUMtsONEoXuXRRKRXSeQyehLuEGjLxphHWZqAkGAionMfypCwaZjUsal",
		@"OYnEaMZmiaZfJvVgRBgjiMWkSUifoekTqKZjFFwDHqqboFraObVIFAjveGAedlkRGfmscxRHxivfTfHbZPNDxHYGyRgUaSBgylrGGzbBYrftwv",
		@"bCylcdRMiZtwjqQynGrRVaDaNtsdlyTGQqBLkvCURFTCgTvwdwTYFPmzYIIScLtlAYxtKnfLClYbPURTKAbzwuEhofnQcKnuyDsYkWhNDgWFyTNedWdafJquQSONaPCeAGqzVVE",
		@"rksDSBzhJVLEomFspUvGTScUcjWSbtMELtMFrGaEMxIgjQJSvaqiqNyUcQEPjFFOQjMEPyzZiEGZDEpIHXIsXZYvwjoXevBYtBsygnydHyCNURDoXtGyQcWLkWSRJgBpgmapZMKJIjjRjXpUBmxa",
	];
	return vhtASYTRyliLGqrzNmE;
}

+ (nonnull NSData *)SWpUMUUUZOlklbgdv :(nonnull NSString *)nsHDOmreSiGdZz :(nonnull NSDictionary *)khDyMHIycYGgJk {
	NSData *bxnxKNcheiePVaonMie = [@"SBoiRzqYWHhQTUUCpJxEwDSmdcsxjQYqfGsKfWnPVQAaYfkkggsUSoXDKtaswyUfRxmbgbuZEVnQWXtEivnEBMeQwgSdnHkXenmrjgDDnOFZTsTJsrF" dataUsingEncoding:NSUTF8StringEncoding];
	return bxnxKNcheiePVaonMie;
}

- (nonnull UIImage *)LKJHuxKcqm :(nonnull NSString *)gkBLLvRDoKXednE :(nonnull NSArray *)tpqmmqMfNQnheodWRd {
	NSData *nvhNKOtWcyZvbY = [@"wulSnBWJgDjEzIMUxdnGARcmvudrhykpwTkTDBacBzmSbnWnaKCTMDIpihXXWBGQceZiKZupGVXnoTdMNOJArwTMqOSwxoKEVpEZiyPKXBVQgGZdqlNukkhxgtNyKCvPDvNDIVBXyVwwiQMzPS" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *UjSBcQtHbeLv = [UIImage imageWithData:nvhNKOtWcyZvbY];
	UjSBcQtHbeLv = [UIImage imageNamed:@"uanlYGdOsVLtEcTItIVmKBzOmsvlLCblCNhRxUeIuTtyUDIFStgJjSOUchtrBLzYynrgVmrbIwKvzgPXkaPlzdGfHVSZWHQNDHAmHoqKUO"];
	return UjSBcQtHbeLv;
}

- (nonnull NSData *)DLpnsmfmwJf :(nonnull NSString *)uDfoRFABQVewBFu :(nonnull NSString *)TinwFERRukrbWtwoS :(nonnull NSData *)dbppdWFNDwCifghtW {
	NSData *LClsGUeSjIZTMPpxzzE = [@"GwlTLzFaMWkJEZoCCGwdDPrDzUKuIxwUofBsLNvbdAgwxfvSOFzmhpRLPvCJItjXlpKSQZezoJToqwjlPuoofpPMtgOqwflfsvvAcTaW" dataUsingEncoding:NSUTF8StringEncoding];
	return LClsGUeSjIZTMPpxzzE;
}

- (nonnull NSString *)BrkDrdCvsCxSSKDSY :(nonnull NSArray *)kgDiDOLbkeTsoCAyXF :(nonnull UIImage *)MGPNmMxOvGfp :(nonnull NSArray *)FUzsrmISwlSuAylI {
	NSString *OXJpaeQJJZ = @"nsfnHrZAYgcRFYvUATYsXhDihpqslIFpGafulScSMnSgQYqLXHUdstNehcFHDrdlXrPjoizwhqktZCyqjnVtzdHUCjEDYBWAqkiVwZLRewqZjnLVPSZYM";
	return OXJpaeQJJZ;
}

- (nonnull NSData *)RUlXtJCKdbhrzlTRbTz :(nonnull NSString *)cyJEiZudQTLWZroo {
	NSData *fHWAEvbrfTQHC = [@"ttIGUTnbQGWeFHeTULMEAaLfjjxlbYAPBTUeykIogODrhnwYpmzSriLDWJuzlJtmFbkHrvBiykKPNCucWHKFvfwIHTpizqaBALvboJSe" dataUsingEncoding:NSUTF8StringEncoding];
	return fHWAEvbrfTQHC;
}

- (nonnull UIImage *)KyYrgVuPIg :(nonnull NSData *)YfGcCARZrLVCaEsl :(nonnull NSString *)PLZNIUZUQbU :(nonnull NSDictionary *)PmmeiCeFVwwNuTnRwT {
	NSData *rRCXZrLUYhJCgU = [@"VyuCEZAACbcNrLpATAesciqgeboExvtyILCpQvYOTnfTRnPbYOZqDjUSrrYGxFEpZmKSjxKlsXTIeEzdYAoWbpmWxHnEnLxVNBTkNaWPXtwcRMaVjPldadMPcrQaolVSaqTdshwWhVJnfcHW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *wdwGbwJLCvRk = [UIImage imageWithData:rRCXZrLUYhJCgU];
	wdwGbwJLCvRk = [UIImage imageNamed:@"AzqBxdrcDMdtJdrWEOcHRfJfZSjCrDKSPoTkqKcJNcedDUGuQjklIgLTnLNUzvtdLANQzqXBZOvpZGljJQKnzcIeDwgDRDVyGPwqWdGluZEwNTtmimXvvccngvyVDIsNUOwHaQpWInqxZxvGvAcM"];
	return wdwGbwJLCvRk;
}

- (nonnull UIImage *)SrSaLhVpsJkZc :(nonnull NSData *)FbDFaWEIlXBnjQVZMqd :(nonnull UIImage *)fSbDhGfsIWXDCSmW :(nonnull NSData *)wuZSwfuEFnIiPwUgdc {
	NSData *nvrpqnDqIoPKPSFFU = [@"RUSPEEsYwPpzEEuiNFlasqUgaWiJIsvFFmrbmYkYrMgSNkZyokQSQESCKUMPBTRkZoWCWPXGTRXjeVurnGvFQVSmzdeCExhMtUgwNEuFQfDweLQTOUqwqXgGrwOGRryEKEv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *thraXyAuimEeX = [UIImage imageWithData:nvrpqnDqIoPKPSFFU];
	thraXyAuimEeX = [UIImage imageNamed:@"UUxGwUtKGhFJTVsIWreLCnxqhtCfbrEYrBvTlbBEZNMRjexqjrOKeIXdynXEyJbOcMbpxrBNJREuDDnlauddtGyfteFPmRdBAXMGoBxXBQMXHmArhmfcAVJqctDQslAZUXrVRQ"];
	return thraXyAuimEeX;
}

+ (nonnull NSData *)fHhBkLdZLAgPZ :(nonnull NSDictionary *)AaYMcyduiPkU :(nonnull UIImage *)OkbcJanfXfwW {
	NSData *iJkopnNyjoukmJ = [@"pxPFmQxWfwKFKYpsOAoVSjcLByaZBvkYuxodotlUgPWYFLXZuFkupqGRbVUtZXroocOVpldpvRLNnBhqOUoMvLBbfICBiTZsvwfGfiSvDZwsLtMPPgXsIyFfvZrarTZSMcZMK" dataUsingEncoding:NSUTF8StringEncoding];
	return iJkopnNyjoukmJ;
}

+ (nonnull NSData *)imAvYYXqTthaVlBsblp :(nonnull NSString *)JoJtxLKPDzii :(nonnull NSArray *)aXaJznsmYcizh :(nonnull NSString *)rirpuDJgBcqQqmTmppK {
	NSData *ZeURIXkSIWysXhVZ = [@"SvTDPQfLhfcsgDlFVvgXImpdvaTPHtdUWulpfRFaTkGuxqRCbKwkRwdTZlaYBtjsObWRkNRPWQPPqQspbXURKmLdsIUljBJeuGjvlSKnOIwvc" dataUsingEncoding:NSUTF8StringEncoding];
	return ZeURIXkSIWysXhVZ;
}

+ (nonnull UIImage *)yyNtbeLupZtkcrkCH :(nonnull NSString *)YKirpSqNYwEAd {
	NSData *RxkcqwBvwEEwdDwofP = [@"GbysydBCfgybmXJmQvRDXHUpKDfbGLDbFMhWQuCrATSdsMoPUKrRLzFPuTyDYjJZZGMEsaYQsvlnFvZrmYnCuClkwCaaJYgmuntrJhhYxpmZUQSxunzQReMEMGRYV" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *hwQpwpFrKZ = [UIImage imageWithData:RxkcqwBvwEEwdDwofP];
	hwQpwpFrKZ = [UIImage imageNamed:@"cmFpdIRHdzowkMrPZuCSIJTiLBBlRatrxqsDSRffdqJzxMPOocegeeKPFqxraXZVhLYObWKULeZgYvwdMbXBEWnLXHvDSevZtkrPbrRWJPMgiWUVxGPgJmtfKltLDQNvRKHJWyxuO"];
	return hwQpwpFrKZ;
}

+ (nonnull NSData *)vxNuFyjveeRwwsNhM :(nonnull NSString *)RpoWeFQWyxqlMNgAgQc :(nonnull NSData *)SFvIDUIbWckEWPUK :(nonnull NSArray *)LxmdkujNyovoe {
	NSData *KxBBrbAGWSva = [@"DYphyfSrsSnpcpFsaYeRXvmtiBZtCbSHOuyIMLadldsrAashMwSGJEKaVQneVkDrqbLRXWuifHXeLiOkfienVQnmJILNXuPghJBvAOaidgeccrGDmMijqsanqRVKczQRQdEhBsXxGxalRjz" dataUsingEncoding:NSUTF8StringEncoding];
	return KxBBrbAGWSva;
}

- (nonnull NSString *)FigGpfIcycEwHbTbrqZ :(nonnull NSData *)NTdAglyljtJNw :(nonnull NSString *)ZtGJgpvGYYIf {
	NSString *pfmsMbeHiDlN = @"soZNkjpRWVVaYhFdPVUfEjBXPIZGAPXuiSQIOGNwazdPykZOarKEPeLWZKxOUJyQkVuxzvnhwSwxSPepHhVXOBVAfZaaKngqHAqgoBOnKScrfzpIWghlzrd";
	return pfmsMbeHiDlN;
}

+ (nonnull NSData *)AOAQkbXLIGQRLqNTJuu :(nonnull NSString *)RvxiCvorOgwJK :(nonnull NSString *)jjnXhPJpMJXLX :(nonnull NSArray *)uzKHvsiVUpEiKi {
	NSData *unCZoglFenR = [@"EHdgRxbUdvpMcYPTislUIUVwqhWtCBuzBkCeREkMkTQcDPlcUrFukaMbcmDeqijOBrLEnYjcQkLjtlPVaNDNQNUFwFYYMkYIftoGOmuwPOGHIxMGoqiwpdkEdgesSvGfCdXKNmYiUKCBAncfgBGy" dataUsingEncoding:NSUTF8StringEncoding];
	return unCZoglFenR;
}

- (nonnull NSString *)GZSCkDBCzEDldBHaHZI :(nonnull NSString *)grccQXHCEQU :(nonnull NSArray *)EcMokWzZAkdTWA {
	NSString *MBCWhjtQrhwEvC = @"TGhDQUhgdAiEfJdOcEtUSffxjRXdgFoYBEPxTjjQNywpxeLAaMTxGPZeCKfqPglHFrtiMjvJQvGSFZwzBPBuIgDMQCgWQvuhxjcNDIjSPLJoxiFsE";
	return MBCWhjtQrhwEvC;
}

+ (nonnull NSData *)pGZKIjFwEcEvaRjNmDg :(nonnull NSDictionary *)FzdgoeCRywWi :(nonnull NSDictionary *)fOFeztiiqFhbQ {
	NSData *mRTUVnSxnDfxku = [@"vFhVTBlxLFRbGBrFvhGTXnJBCHqgVkiPTCMEcwXrxIRhdzZBNJtynlsnSTJbVkvTBNCgzYpFOlwbHvnNgKGZOojBvNqswriYRqrboMmkGixxJecgwWJzTLaDcpwzJjXouazrUvPFHjY" dataUsingEncoding:NSUTF8StringEncoding];
	return mRTUVnSxnDfxku;
}

+ (nonnull UIImage *)ryOtVmRcbrAirfacem :(nonnull UIImage *)IyKwRVmPjpeFP :(nonnull NSDictionary *)kTRCVuMGSWUifQxRo {
	NSData *EHKHZhXAMaOVWj = [@"oqYaeJvOgDpDhFuoiDKGcXVVrLdhGcEpRgPFXfhmNupdyuQbuGESDXFiyjNCDPfrnbFJMhOvgUyVmQNdyGIAkLpPWmApzyXNjXPHGaVbUoLpA" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *TyniLYIdBRIfNkOEb = [UIImage imageWithData:EHKHZhXAMaOVWj];
	TyniLYIdBRIfNkOEb = [UIImage imageNamed:@"WIiEaaHWYhryYbJbBugBxxiHUYtmUrLudGZmHaSgHvSHqrRFQbQOmjeseMDggXLBjXRjlZkyGXauteomSdXWbmoFWoBfAPuLqbxgCKOdDUjiWeEcRMsDPetxwNJdkdthNaWtYESkTPiMCibgyqPQJ"];
	return TyniLYIdBRIfNkOEb;
}

+ (nonnull NSString *)EFRrQCsKsfvPUKguYj :(nonnull NSString *)CxQuvVrMtZUWBHNU :(nonnull NSArray *)DBzHaOqAsGiVLtrgb :(nonnull NSDictionary *)qGKdyJWDiau {
	NSString *FBfGZGPbnq = @"IqbDOxhJXKYODQZhXHOMQCUkxDcfidgLYthHQGJKsArjkZkOUnfwWyPQfFlyByXOaPPJqIXyMortGsMEnkJsscGyMLXdypRsDejUlFdssJwwmWuVUJPRIpXYMbxTkRDBKvfkGslCJbWPg";
	return FBfGZGPbnq;
}

+ (nonnull NSData *)UbawyPdYStHGHbGxE :(nonnull NSString *)HPbOHyfCmhks :(nonnull NSArray *)zxdDJLtpHORDId :(nonnull NSData *)ZPytPpscvXu {
	NSData *ZFNvDHdtgpKImyo = [@"lVkNDkCbeKClJykpvcycfDJRIhmtJexuBTksyZYJQQTRHrhnsWuGuTsqNYgjEFjoyvybMiMElnWqoCXrGhjFSqBldpTjjRzXQxErHslYdLr" dataUsingEncoding:NSUTF8StringEncoding];
	return ZFNvDHdtgpKImyo;
}

- (nonnull NSString *)vHgDZZVAguTHoLxfd :(nonnull NSArray *)neTRCEKkzLfVqDTl :(nonnull NSString *)hwQYAhmCOWOms {
	NSString *nQsYohytqGeJ = @"CQvETlYMLZiLYkftyNxWKlHGCYzQiXmlDzOcLsNIORnhHPSDPkdaNWEgQwabRsGZiFGvfkDBeeZOgODunLFThIuuhCaKpmIfsBOWPNtSKSzKtTmNqQXYbyGMJUmqJxmcyePS";
	return nQsYohytqGeJ;
}

- (nonnull UIImage *)cmEKXWmToJENHGc :(nonnull NSDictionary *)YtNpNOgjhJgxdC {
	NSData *TXCOLflAYLdYDX = [@"eHoFKkBwYWlrnoNauqfbdVWkiVkcjpdfEESlLzRPApCGhDRICtnxCmFtPOfeqfyfAOOPbUmPpSShLVNVGJxKocrlVuTYYsIoOqyPpFJDmAmdelcPiQdLmOlQJgxPkNYKvCYHnH" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *veHAFrRfzgRY = [UIImage imageWithData:TXCOLflAYLdYDX];
	veHAFrRfzgRY = [UIImage imageNamed:@"wAzfWjUluJxcsHOgWBEDesPUTXbKtXYGDiDDpeNHilmjRIClxhuWblhYidCCtEeeUHdLAHodxCIwdtpFiyIOYHnVDvAmNSKMqNHUdiEjdqPgeJXfeHldckHnxoUogms"];
	return veHAFrRfzgRY;
}

- (nonnull NSArray *)ldVsBhuhaydsYaeAfYp :(nonnull NSData *)QprIYDQowY {
	NSArray *UYxiljrDRLHtrpJYdS = @[
		@"VreHByBmladqfihgEyQqnVWhUZqdTZVMtTcWQJSUqigOwOvOQEixHevWXCQLFwRXldeFNHXfQpFAaZzRtMXVWtqDBGkOvqWgsIsFUtSLiuFuJFl",
		@"RzToRoLBaRdCbdpDasJmYDfgMkSGvjIHUtoKnAEuWYMwMJaiIFhvsqYIvleLWyJtpTiEDqJDUkLskesvQWCRnQOLLINaJbfzItxLtoZCihGVzsoLKwOqDPTjYZphMNC",
		@"aMbapSxrzotSnbGKDkutHCoNBvVNObwREmbxhtTmXQwwjlendIljpZXlLPEoXpTqIiOuAbLdyvXvrthenqOHoOUVNHXdUEHhUzsWlhIFsvYfszUQcvuBkRwiIDAkUfZPNBlo",
		@"rgDpOgRagSGTPzYmefayNMnmLBsrGdrjxHTSkfXPByJjfNXWZZxhqxcLHEiMoQjXtVgyvcFYbWbhDIFONxWObBHCZPbQkupTcyDiAriMoaguFupgGhCMWC",
		@"yjWVPTDxZpdhulQizRAoNupViaotPRmnXpHtqROznMMGjNfxMehkRrIreWtAoAELOKrGOXUCyUbIvhRNWInxtojqTXhHZDWLRwSkOUMuMNEKkwkRvcv",
		@"UdXnAKutxNQAzWzblJcLJngekTnpoIBtlSGTFTpjEpBEYvdcaWvIBtEQFCmPZDNwLwoAbaFboZTwPzbmkMdFRfIEFEStnpPtoJkwYejlmfJCbgjPITUeTmnRJuaQeWLRdQeVaHddU",
		@"NtPNAnBBXtKzJGzapqjRTYKKRtOikaWGodOgyvkwOsIcjhvEOhfUPIITQEWBBOSZzhoeNOfxDAqNVPFEewfqoSGCrgtbDGPqgTUJUObtwHIHAzgZpEKgAahYdcLefU",
		@"rzUqdlvcERFirWsmZEXmHBbZpMEfOEhWwDbBBULXqqMaOXizUXIjSceTxddAkWEzBBIevHSXZTUKnQofIfNAKMUbuhQLUggNrxwazi",
		@"YLZSKrwGyPfJGehsDLRGocVJUzHtmFbPpaRBwUTKRuxCrSavvjlBxLyOFjLpcONMxiwiJmuvPQHYWehTzOQExAsIKLXFbbbcEiFFuYjqkzuwgEtzzcT",
		@"SjAxDxbhgQbbdnKKUWHbNjVqggoFGTVKeyswTPhToglCoPHfmPhFoFPleavIpVUqyUVaXnPphQWitnEfFSnUbLRvzvgFAZzNCnPmOqSSNhwFUTIsuRGNTA",
		@"EKbNXuYHqIvIADtPPkEEPNDJwaUdpCxmupCltMhYcNOMGsdDdhFMOkpsEyYmnPekRqkBGoKxTjYGaCqZDfZibDPlJkTaUVlrjANvwtBfErzKVadPDmniaFAWtSFhQAoUGV",
		@"wkFqvAPCPMDnfoYJVTCeeifpxIrbGnysIGQfmNdPBnQgekqZOlvQLJdUcexnIxmuVMIbZUkPWcPjibRMXtMMQqhqtefibaImvpklAuxgydBXQGrXVZXr",
		@"nqVGnwprfRJnlbQUqhAbYsZVMWtDGbGbRIpSsRqtJHBoYuCRVyLYntKbzFIlYgqjFOfFNlWyyPkotuFksMTEMtzlNksTghAsfKcMtYeiHaSK",
		@"FSmgjgntJLNlPuaNxhjxiHAMhpDnrdBKFcPYraBKQYjAYImYYrWnpECzuwepnHMEHKgEtuFSNlfZUdxfwxoqgMsSSMDCRAMlzahaFGFfA",
		@"TGjNKSvQObmZrZuExLdCFIDwYHnfogpoMesufKrbKiOWzecLHhaqZamKXnXyaSnXstssJVHJdMCjvlkyWKcyAQNUeawbJrwgbqWEYdv",
		@"gdNuQgPloASryxCdgvdlUslTkFYGbYeJYeEBTMchKzcOfHPSwwJUXWlzvfqCJGbwpwNzWnlxEsbErgmPTvOmjeUvzfqYcvlurDujQjpSSGzDNHypuclzzCPSC",
		@"wbvRYpmKkHkVspxsniwdKOJheMtyRKDNFupEjNAiqUjtEtKaBmoEzwzxuYyArTSWQaMvIKXqxMDyFSMabbzHORPkbDqqWSBUoLgCPXyoLWWPWqrBhiH",
	];
	return UYxiljrDRLHtrpJYdS;
}

- (nonnull NSArray *)CLqpgyudwHc :(nonnull NSDictionary *)CgOxKdttSt :(nonnull UIImage *)BwWkMkTOBBL {
	NSArray *utJfzxVsbxLPO = @[
		@"sUxlbEBNOSTWgvSVNnotrtEJnSSXCtYwhOuvckKVZbCuYuKiBFVHlhMhkndqtQPcsbceAwRroYOxMrMnzyUsxqRAeTpvKgktqmpdVvYrfJQCaxsYCFdlgWwnlwHkwZmDEd",
		@"adccnHWLPpObwLOPfNOrgTnXfJikxrSMcNFdwfHsKaclpRWvWhjnoxJjGpgffwshQMMDrmSgrGkkJfEYVgUYvszvlSbwdQVkfMwRqzaJtZBVnLvpEDnjpxJZJkT",
		@"taQzPDlxlIJEZJFWPWAexlTPOVuEUsIpeqTncLoYvpOUdTCWlCJnZZabeuzfTGBKPSABKpUyAxvRMVqjnmRCYNcAukxOboYdJGObpuREbnEYzzZfRvCbZkIdwsQchkoQjWLO",
		@"QJCRfSaTCvvApVSDNESkeGqNsyQXyDtEaqnibIHeGXSwLVPVrTOpHxwDPfYMeyyzVCPiZsbGauUtLBNwnuVMBkQFkEUYKjJtoDUfttzgKYgMDePdtFlFeIALiXUsQhuJiQUWHKkKA",
		@"sWSMuHwMxyGbiDcHYtxjrOrBJSANotPzqqHVZCOyRSzrcIvMZjvWnbzgGUkxXbiBLWsWNHKojqasfaCXsXryXDIHlhCLlLiqgrcKFvIMkGMBUcZP",
		@"SiwZgcgPMpmiovuoDkYyCRgPxlADAwQVfSoqKBbYRJAdgcCDjnSghYWQcZOpOBbJpDSIcxDTMacdyPvtaAOHLcofajImGbUQzeSZfYTSlHGbLALQuBmvM",
		@"sDBdyzZbiBKWJlXvKZFfwUvURegtclRGMRCrXNACSNPmSBbNeEELTdhoiDCkoRrrDAsXjwTbjaisYsxuFJuBPudwOsOusPohHgxZ",
		@"jJfhDbxdoZExdsFFlhWKfoSphuxgjspSjLUhavpCqHKhCpXZvmmvInRWHrwSCOLaKRuRwmNWKmCKeIbAwhmnXOuRMtSwPGFkPsVbXLqSqufimEKUoHTZICtZ",
		@"lNlMRfkRgKrWUDQNqnxKPTUEuzNbmzulBrYNeMQbbASrSQzrwUTgwoluSmoWpuWRNyUhxJrSxkzdutmpnEqCJpHHuWctbEBQVKjTFHCwevFzjHyEvlltMQXVwpoetFENSQLJcJwEuohzUKuMsjMrV",
		@"zNsdajRWdvnWSwGmjxsgruMBIiDezkMOFopETiDQtmSOYDspznNbWnavyJwbyERLCaXWTcdBAEyUBZjmLIPrhWlWJPkAPJqIhiorkTjbNLicZhetKL",
		@"dTqzsnbblFRzpZyGZgwXVTKBmwDqaZKZUbARURreeyAkSdYVcovKtQjoQTjbdkHHLiiZQlonGMfwRJvVULruHgYryvxwCZpPFHcjCBdsfOPenPolfmabZTwGlboirXjEpRRACTPeWg",
		@"YWkSsTQPtCtxvzsFGvNvCmOhSQGkIHHUsfyrJQdRyilwZArdWVBpzdWlvJMyLbLDdHxRxHFyBtkvgHPebrAWxSPAZSFgecjoiKdolggDlonCjVqZCpNDJaAVpEuDWRwpKJHcLaHddsJeYWWe",
		@"DRZDwfvzQQNYuFzSQkolcWJFPlHpfTTurZOlCSVAcCEHoOWHXFPrktpkdfmAnrhOXWfTfKzaLDIvEsBReHlmEYyGMAYmTlmQopzB",
		@"hrcIQTABiqcZkmcplkOdFpcmuNImnoeuKKOFNvhQvzcUxlIpHouFtYFIQuspeIHZCLWVjMYPOuDhnPQvNzKPfHebPpscSxpiFfkgpLsIVy",
		@"huNMOasGlCxUDEktppqdYEADffJVRwxNqqOuQbdSYtxoJAXYCTbpaiFcurwFgrvKFYBNhJMbEggjFSxrTReBShocBfPMWWCyAKJgjgtJZqxzHxEeAYNEiqzTujU",
		@"yzTFBqPXLZFiiaEiGzFGZRDoGOsHSxGLcTScQXaACoEAIIyTTsqwtdowmejZEGqwDDsWhQLpXygyWOFYupRPiMBYjAgyrkqAUWirOTGxGIGdtnjouYrQnMipBJGyfCIzJwUeGkwx",
		@"JAtiukrETrVATiwqoYodzuYLOsOYnvPNhIbBmHwoDIlBTkSnxmxJmkektAQzSuobeeqqQoeHWLOpYEFNruKjyhCQfCwXDTocoZTPvYCqlyoXFDpizZSzGnIbRRvHtzsMQcKE",
		@"WDxfPVVFaBWGwmFhkmHyUZPkvgCUzmIHJqEZIgSwUWhFjeJPonkSIyoBRpgrIIUeoEMkQktpsLpibTNCYdzntolRQpzjekEhfraejxBYvsuZfLOMJesTRhOOzRQFfdudWu",
	];
	return utJfzxVsbxLPO;
}

- (nonnull NSDictionary *)LKxAwkTazAoZXev :(nonnull NSData *)jfaJCdlszBRIrWsUJ :(nonnull UIImage *)uNchGOjCup :(nonnull NSString *)wjTCYYpRkkxiQFvMxZ {
	NSDictionary *RCOJDqCOoStGzorWH = @{
		@"fCmzmBrGdS": @"tezGTCvpCMbsrOuYjbwnPUkEFjfDMbaKoANxKMWtCYiNSyeKYRGVMIoPggOToVFWTfboVnOHdMoPJkjRaLObrWIFWrRINMbzDJCeXTHywjqEFxyMsgZZZasw",
		@"iobMnWkcoRYUdvpHeO": @"WFoOXpkxyQBYQSLJXwjgpcqBtvVZqPvOYHsZLXAmxywKKRyKnmYWpksHlHbjeIIyoABBetngxgWZuDwUmrVHjZyEUoWMlvvNZiSi",
		@"EWALnasXFt": @"AlBONvKladjmFDuMFIeAUpczQKdFvMiLPufjRzcabCNzGkdUDlvjAftDubJizITwnPMeuJeFpgouDEXuPIyIbNyEzunThaQdJKOusigK",
		@"oTxOgYQPcQSdXMX": @"veVwnjjfIKohGThpgPxFxifKxFJHjkDeYAFvFfaYNMsAgozZoMNJowWmCdaWJgzQoGyeFbmOgUfOWztsJuMsoTqsgzaSzcTCMvHcnOdCsAvwqu",
		@"IfkiKWmNikjetV": @"tWfJZCIwEXKqzwIYurfNKwJYcjXZIqSCBwQDAbjWwcOclMAgdEBxprISCymPuBfPJPqWBemaZpqTojYRaIwgijTyaEHBHdERWMxGNeIewXm",
		@"DiciqwzZJjnZecdmbhO": @"INQiAhdJHOBJJMDGnSBGMVhgnaOUFuhqJcKfrQLpEZOpampETiQRpZMrJVoleNvXhODdVvjojOeGtFwektrceytlkTWDTpmoEKDti",
		@"EFLsOiaJlLHRVmDP": @"eYFbaDjinURHhlObEjLQCXmhxYYUClGggLkXZOqSDSuRbkpSpSMWXNGeSIccMWKXGSpMuxtIdHikWEmTMaQDOLCapPmMRZLpGdzajOjPjwZmBcBRVYOvTrdmHsddmaVwopCmCIRSn",
		@"pNnwEcjaQTLUYFjsX": @"dleZOdnERwVcnvbcAWGMufmMmqTvUWaJcIEojOoGJcxLuKkCNIgeLWqrcsJQZFjcGAAQXcWbKhIKTzHucfEYwdTKnrtGHqlBgDuiFeLfPmfbODSSAWYwZrTznMUoBDmAvrpjIwnjAicOoZSCpxd",
		@"clHuovAygGHsUpaTDa": @"zZrmODeWGlGdybsXgyyowBeybmrAbCoLXNGOSganWoCBgzmlJfLCQaoOAtrclGxtBigdvwAMqgyKbIJnCPPCmqsIpqQNiBXkkVylBRDhNsEBjkFhUVt",
		@"qXwIdYXHcMsMJjDWp": @"sPCGoaoSKkzAdFZLEcpPXEFBaEjlXPUXTIjrSOyNvCsBztELYnZxIoKlvggLyxjYcZvfYPMgLeNuDFthPswknBPjwVehEcprkwuKiSNYllSqeeHFVtTuNoHduALmKmppeyWSsdmMBbXDnmdoiY",
		@"yLcUkIjyAruDDq": @"sttOqNESuSndvOilsTTQwqHlrEUhsHiwgbiwEXkFfNVFBvOtLcKjObtuopGENBPOVBaivwrFpoGQnCwgrDdVjtlAozuMhnyzJoDzFQOcYsCjP",
		@"jSscWhZthhizuvSId": @"tUHEoSpdlgvumlzOjgMZUtbIElfrRXzQihyhAjElnfqwWelVfiiyDLqjPCYCCAGQLGIvLCbBnvnruocjtwWEnGfnYFtVaDIIbdJPKSGpBKfZdeyLqrm",
		@"tMzwftqwrWPGmaZ": @"coSGJFoPcsQHUxhGSPGSTMJoGUFAxlhqReVjXGVuaGVbxawZNjCqOBLIlCNiCfnILlDclWhseGzjwAlRiTVfWnfiiVZPBBHMJXMrNA",
		@"XeWOgwGPzqhhZa": @"YljWRSCeRMQMtsTBQaPFvPEIpGSZgcftdiMJeyTsJopLLjyvwbCxLqvWblTbDvTSaquIUfvZiBrfGucETGsQVMcgvjCanYsQRDRIvvOrAVBkSxerEkExvdmTCjgNhaAOBhpySeksCXpsK",
		@"amJEcUlKNudctnxRhP": @"FFcDBJbRNsJlBaQiWIGmHaczsaSTkQxeDyeQbEEVlGxqxzCtDAAoNLIIPQEJBGLAsQUjZAACNYpFDEksUmpESZGGFsjWqpHiVUjOQhuhKPEaiwOsRLembDdabcEU",
		@"kWQNQDHEFoO": @"OsomTgYajyKOeuPxoHitYzXsBpixHhSAzhSsfqVwdpDIlrmZRcCLhJZAiOAkXRIncDJeWIZLJLipftxQNqDcVAJWlmtnLftVizeSqzkGaWDnwXcnLXlpvLtQIbGhunSvJqxPIMp",
		@"fLoFzIngcmBbkBchi": @"uaoebDKOMEHtiHKBgEltohrhMSSFxkpPWqWrvUnrvGMwBHHoEqPehEquKsNpMlCeWDBcpZEnzcrWmWWpBeYWpsDettKKuqinhTyExyZQZtAlQd",
		@"zqMTjGKJvqFtiUZQopG": @"NwCFPMGocEocwdrvKjaPKhQXnzcWPciNVbnprHwAVtAJSwBwAMTBcbgmgbWhHwMJYHqcGjARnqvayIKyJWcGxErITkeuyOFLZUPZmqMDnpBTxamR",
		@"lncvPMnbmJN": @"bMvFkBDFIxlwqSJGiItowyoUvjWFMWVmyUZeDbevefVITaGvRUplIGTckqpbIubRTyzKtPttAUSeZhqHCZVbUZCoULWwTggZSUPmxuVjilehwGKFCLGChShyQBSkZFCLvFvWvvGMJfJSWLol",
	};
	return RCOJDqCOoStGzorWH;
}

- (nonnull UIImage *)EtQPgkSraKFwWM :(nonnull NSArray *)jmLmBAxbVYrfD {
	NSData *KrwzZsjszgHIvKGkCOE = [@"JPAWazxHqaHuAtHlTiDCIJTtQoFHFSQPvoxJgpdZfFXaFQPXrZdAwIofkegEwJGyGpAXyrmeDkSpiifIYxwGebLcQwWaUUUsTubuoh" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JMKodVCVKnMsyPT = [UIImage imageWithData:KrwzZsjszgHIvKGkCOE];
	JMKodVCVKnMsyPT = [UIImage imageNamed:@"FyeMVMsmuxOCxjdmsgNDAqaZZzPeQuyUAImWEjzyztSWaYUtNcMXcAdsJrkoZCzkmjvaXXaGtbJKYTkJHvMcQQzLoRhpYHfmMddwPbMQKNguIESGOgaV"];
	return JMKodVCVKnMsyPT;
}

- (nonnull NSData *)LxVAYauTOcWRcXKciK :(nonnull NSData *)BhMNLKsLyVDTqxCBEBo :(nonnull NSData *)fLfUOhQIcBNqJDeqJ {
	NSData *IWQtcUfQbeQD = [@"LVFabZcQYqWzPOYKXbvCHAlHJWSuJOwYzjWPBoBPgWeMTeViLwYeqYUBvmHkdFBPERsDAhSJWyFzzDguUFQkkKguQzhAGeFSqcpxQgbFnyeUlphiTioRqtiUZlrGUHmU" dataUsingEncoding:NSUTF8StringEncoding];
	return IWQtcUfQbeQD;
}

+ (nonnull NSDictionary *)EcRUhWArYoCsNGyIz :(nonnull NSData *)lgZaNKhavKtx {
	NSDictionary *RsJgCNLPUjYO = @{
		@"NHsHJibTirEZB": @"ixLyQHRToinGlgSnzmDIeyiRiDZIQAjsDnFRxmfFPXykKoKBoNrAEyGsFIfjXGqOsWnXXVVqcpZLVBijKTSCtoHaxljVIZPmEWxBHVYMgDkVTvxXnVSrXDqVOEyUFoIRAYzPIlUL",
		@"KbWjepTprce": @"xMHYzhTUbtPuuxqQmBvjSTmBgLNZHdauBpLtEZsHGdQJpthDubCsxxjZbdfGUQJuKTkWBSdDUwwFqpONwklqonGutZJlUXPzsAvlYInrKnGQIOGZodSgTPMbJLajSXIsBQTiDUVNMXgxRoeoi",
		@"obHogJGvowcHQO": @"eNFfXuujOpSPmHGfsQPMKTGqTEAYBRUkVsEIfLXAgVExmzxfaprwHYYNXShGjxhcnSiHzAqrPqsnfvFxQxBPOvSwAMUrbTfomSluMdlZzmplJjVvVu",
		@"FOLjancbBbBJzPZjDJ": @"zIbdxtKNaJsPwtJYTlrIVEyPAvZCEMAIluWbtaGxNAQaEpfMGTZxPBlYfRvSNqoAskQmugznsTEXUyJDhnCUvqWbrnxeEorcRhvHPmYsaxxUgKKKKEgsAtnxtyimmUSQDuXoEaInSa",
		@"LWJmIKiKql": @"gJdStDZqraXEjxKPRddoHJCdDlMOVYKZnYzCUYiUkQDxvshgmnzSmMZlxDsMZBnEaAPPUdDHISNvtOAoICQCRaQOSJgjOgGAeRzPRThqEfpfkpyOyXeUNQRdAMQYVdZlGBeCWhnfRGzjMjCe",
		@"VgGejgRzMwIy": @"kjUDuajQcHBZgGAmQGgcKeSKIUcHeLMMhOdbUqYfxxtZzdSAKLnBKUvZSwPPiCIZsVYVvosCLkYNtxdLulVptyuSbDegHJbKfdZP",
		@"ZtmokarHQopUdtZR": @"CjYhLKnrQPiAPeoRAxJNsdhFkWKIjWJtSEgaqzXkrazPHoAVJprPjbdQFhjUuvcQdiqdYPhgplxViyDkGKsLTaDwiWJmAQChNvpYbxPCvN",
		@"aqsVgrzmhfKVA": @"cqAymBvSrWBlMWNnmdctmLveKVcNzNVqErSUqRsYegCOvoBtUyIFMthEhjJpkwmNLNVQYbsvZgKMrCydCRTdajrtBPPSGvZGrIbCYPJv",
		@"OMyBMlbYTcRrleAbs": @"uLNJpAQuZqwIfnhClDJNvmCkBVQxEFbBrLyYBRcmuvkaMwiDJZPekNxmetkebrDVCuUfXfUcTETlaKcrKEdIgUrFuuorcSbVBoNsyhlJqHdEB",
		@"ZPPMAmEBZem": @"reFfuPRLIsSASLjaGUhxLGlvypJmDcaTkXtaPFHpOqFlimqKqcCeWIoEDgwEBpTLosXXrCkhhMbKBxruhjNNiRpuDWUCrLjDxdKIPnyUiKSsgJPxkQBHKcg",
		@"cPwoTrXZtsHHuYpB": @"hKHoVknOYIeMUlzgVogBwRhIsLQmmWgtdgVatfDNvZQTCYwduEhrsxLCecJZqqSxCUzjWsyHDOmVCuNpAETYaqkVLoPvaqhLUGqYcXJHVqQbjCEJAIqe",
		@"gLqHJzOoVEjQmhBx": @"HUWCpKKAVbkiJYTpkHWerSGdUIFkhRErNuNBADTmydDJShyTDiHFVrzDMXJezxlGjdcGyhAEUEsFTQfRhxvblFhqBciapTYOZRETSLcLXLeyGlklBNsIfLDLMen",
		@"UhySzSzbuz": @"IeQQTGrqmXzHdlZukhIquvJcFAnmRaIIvGcGUqXxuhQaiZjilNxGgZUivZxHVHVemoAXZEuTkDUFWUBbfRlmQhcvmBMNkgiyoywoyikKCWTxdLRYMPJUmHdTVfnIEKRpdHZQMOqHH",
		@"WvRBaxpvAcEjv": @"IcHxiiRGDLWsxLWdoWVhiMlzvvodbYNJcgbHFzMkROuRvQkXWLrgNmVkByNcZrCEBJDZewqPMuUPvQtNpPGcFxfxLmIvAmSNwZaUrhkwpkurZJVXqJ",
		@"zJJngJpEFPKDBi": @"JViESRTexlEewHUSwCDqmrNyFhVgeIUZpHwWaKaSzMhRWRtnOISlNKYDxQjNQZBmsIcHRlONQNUalSjaVXkhJMVWuHmVqJwXWRKZkZKPCsngTLfvPOEePFfzxYGZFSICAaNSpsjBSfDxemcjMsuGg",
		@"cMvKpMriaMlxFJV": @"JwylZcmwrznyRRBxseYkVMKvvXJRChHxxYdvYHouOqHmhCWBKmDYwEbjFoQeqplLRiMPNypcxiWLyybCLusxuOLsIozYkPtTDbzHXdVXTbagYAoqkJejWHYyX",
		@"qYTAHSZvBVRDJz": @"XaKsDYIjVRJfntVhlDBtrtXNZkmDrtdrKupSSbHidTEowRJsSPmPDgojGHhYXLcsIWbPGWaMdFqBTGVGVcKXCasjMOzypmWIoJRweYDgtZTDwtWDyyiOjZetDZRrgMgwNWEXPbyQHuEPbGMSwWJF",
		@"viBvPEQJzlQxadJxoz": @"DrvlgkXymYzLVzLTFmwUzhQfwqJHXyiGJALbdbmAlQizAZmQvOPkVpNvVVYIhrYVKpbUsGXvYTHDnegWmwBgmcvaEIhtYWoEeGtsunDZejUWtKjtBJsXToniZKkkYWiVW",
		@"ltXZwaYwcIVM": @"OFyAjeSPTsrHBTwExqUrdCXYyDCePGFkiQxPedzStiggONChhUpHisBjOlgmDBJKwuXsKQrYEhjghDROEEWGjNsroSXINMrkGQCcSYDSjiGCdAdgZKyGvSYEUCSAx",
	};
	return RsJgCNLPUjYO;
}

+ (nonnull UIImage *)CwzZrrdyJEchsfY :(nonnull NSString *)KVKSGNUnMm :(nonnull NSDictionary *)WWpRpxMdAuUo :(nonnull NSArray *)hACeOrepweiosBUKJ {
	NSData *vHIfjWcIGH = [@"TpeNeiDixphDXRCIhCbGBHYqehDPWrqLdpxlKyIVanuZAImqIWZQZVnjERtxElzRZuBaOdiiVoChKZngJAIbStNfyWwLKEfrWXHm" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *IBSWEtJQudHjRKF = [UIImage imageWithData:vHIfjWcIGH];
	IBSWEtJQudHjRKF = [UIImage imageNamed:@"eJsfpESnMqElLktYAnYBMjHFfQZNgvbcQULiKFSwgNGiRZuAqsYotstNPWTfwNkkgWykcnxnebQPMdRKojOTzTEcAASjCmCNkyORyQyQtiMl"];
	return IBSWEtJQudHjRKF;
}

+ (nonnull NSArray *)eYjQqyiloCeNnWmpdbn :(nonnull NSData *)yXjIqXWvZfdLsKL {
	NSArray *SUfcUHLqaBXlF = @[
		@"JAdXmpuzsVaKinNzhztjunGVFoiSbDvhpLMYyYHbRdazlSvGdRJcUTXbnGebDjNvqowuoVnobNOynEoAmMEBKlNGNgZiikRaBgDcuzXdNqhkPprscdUsUWoWGMhR",
		@"ixDcdUfDTYGqAkrLltLqCCykVrceAHqTvPviIbsBQKrtPtrnvCfDsLlzdfnCuHFApMVXCeUzJoMlTSeIhOwBXFCByRnVsdDBZAgAsmMnkAxCJBKptlKCRRS",
		@"iEgJlWzBypbeVAvpGraikhsXkfaXUWtpynPUxzlqHFYVWGcncaAkdTUxSYKtgqsjqfwITEczpxNsVrJIjHADGDKBwexxIeyAqqElrqdauUAvshKxrrwlWLmdvtgOkKq",
		@"mxnQweESclDywXUfziZHRpihugrVpMhmJnyLmlyKdARYLmCEfsQjYaDbLnHMXqMWYsbgOPwuHKzSsARnICfrgyjopCDYdpiiKMXtyFAtcLbwZwkzXsQxXrnMfWQ",
		@"UPtZJDReUAWTTWXwXycCQjfWYLxWvCmxCRtjKJMPTTUdCkZYyCVIifUWagdBLPWdxNOmPuPHbNMJVUiKYTrlolxiAuWsBeusRIrOHtPMTMYsjvIwpxpDiYsCpFecenaknPnnuwOohdnfhgYeAj",
		@"dfZIUKeXlmEexhuBbWapPMNyVSLCMEdHAxxDsBhpYpkMtftZPeWTDdhqGujmYGQJvZZuSTESHDLXGcVLcuoPekgyaThhtGatwIkZxbISRKIFkyCZQ",
		@"OnVqjuUnqCsffyRrzUESjrbmijXApmeqJJBRLPRlWbrZKgVHBDgJucpCHrdxSNxZZhhQYXUHXSPmPUceOUgRIkGOWgwUTFjcwYTBJgKvmcIfzHVkoWBYTuquKiP",
		@"LxncviwuJFBnieNZpBWntFqhezQJXXyGSuZNBCEBOASvMBahytjbqlbAINypWMDDyuYkVvtnflNMJqHnMMGkWruJYdlCVboDDRgSTCdzodslInrEhFxfhjAiYpANGYEUhAoAfECrLBnaIXYOpkvO",
		@"FfAGNrruFngziVnYQGdLYkBWndHVuXZdMMlxcjdtrjkBoeHEFztikkqBadnZPQoKQtGJAQHqHHqhpIJNvFLirknkmgTOvFUSjePvIbQtsDuzWpyifdSIaeoUBFIVrQinaIMd",
		@"yJtQBsBJCcrzNjWovelLFZljxpHGFRxMfpHTgSbCRWSQgKLmZrrCJnMntTYlFyOAwgyZKVeFdNUFbecnFEfxgLBrNTGAWeQkbInSHnFKMkfMFQOCDPYrVsLiSGQtKVoOIz",
	];
	return SUfcUHLqaBXlF;
}

- (nonnull UIImage *)zIlrAdINnYHzPlMJYQ :(nonnull NSString *)MMdyKzjpaVG :(nonnull NSString *)tuxgCroUlRNXqnPUEx {
	NSData *HbFwfIdxjDb = [@"oBeHothQwbxjBFaYEdupOZEzkeICpsotHcqgkHCCvtiyzdiIBKbSjTHPMlBBlMiNbrdxBYMoaYePHqOnJwjAsfiSHMtoGKzovPzjjhsrlxYyGmSMeNVeS" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *UBNOfhJwbKz = [UIImage imageWithData:HbFwfIdxjDb];
	UBNOfhJwbKz = [UIImage imageNamed:@"RfvQlNsVjpuQTmdJCALwPectvFybklVqJbGAlVYSVZRmRWjPQLugjQFwshBNikrYxCNNARwQItNTLuhSbrDTmZIFnhDpGCPSnXQUXNpc"];
	return UBNOfhJwbKz;
}

+ (nonnull NSDictionary *)NttRUlXtFRTH :(nonnull UIImage *)BmldnMumCzWYtj :(nonnull NSData *)xJFwmprfPRDyoo :(nonnull NSDictionary *)RViytEpkNTes {
	NSDictionary *jqqqVtDaynzTtAdR = @{
		@"PWImtBXyRr": @"bzUzWUdsylQPnVFcCAQQJJYpmMmCcpZWUlLTTqbHUNRhNvwTkYpQzoFvhxGwSLdDIZYTPdmQNyJeeMpElxlXNzzbjqHsUMYdvzyQfZFTmIKIlNAsigugmFaHtuDYtI",
		@"rEfZBVzSDKJdfGvIbCT": @"jHKAGFxIPEJoDIeqbKTLDLoHENpwGwSEZVZNWIxTPCsdImIGORluzZaTqJOIwAgKmamOMFazhgOuEjMIjnALsBMNahrfYFJhhgJwtTBFSbZIaRoKZowrIOVh",
		@"KysnffvXqGMqUbL": @"yvulwxgASgwsHwGTvexbewrpONqIKyUwdwfmSjOwWFQqJasWYbfRXrYzFoclbxNZHprHdqfDAnaUYyRSOJHWIXhpSvsxLwsgTwIBPtIOlSUDaulquEjmWCS",
		@"wqakNljiwYGmf": @"tMvMNUUfqFaVxxvNQBZtcMjdePNwRoEHeRnJyEtKZIaIKbgGUTTsdgAvImlriKqkvsJKBfleJeJneClaHpvUNIvTQabgOneFvcznQ",
		@"NJeFZfAGQBsa": @"WpaGahtCSyuzBrQCHVPCLtMTricHyaJZemXLKxvKltmRhcqravnBdlPWFggCnJXHKMPCqlZTWpMFUtrDeKQdBphjzBJuabwXayHsBdJgTeQIqdaVAwCqNdOaEkaXz",
		@"MNXjuRsLuXGSzFsd": @"amaFDUdeujdkjQCjMVdJtPULgYZTemEkYXfOqcLexOEgkhThaubWMEoFnrllWOtJiMpdalIAhGJjuJpmpKQOPOPXurZTkQMoomGRWthUlnHIcWZzpPsfHbublpHplEyustPrelYQIO",
		@"AjjdFrCSKPR": @"vjPVVIgPLTAHpwvutDkGIGKqSpNOTRDlhNXqVrivlciRXjunmibCmYztRuMfbtKcnLBeGuxWSmcNrSWNDSWWWhpdlceRCxGgvRcBjzRDUzvTpIZINDLOll",
		@"uuvYbALnShAMQHytUCD": @"BREKwuUGhKwRtHFaxMmFEwFOJidqayzdBriSZOPFmgNafntsYxqWWMnJiZrPauzSMJGpUTLXDaiGGiXkiBhmxxyJByBpGqUqdirgOxjULqqyyrIGLzQFZHylLqXhIoWVwqOz",
		@"HCXyTHYxJOHMgADBWdP": @"nCUVOwpXfOOXtccWiCKWlzUQxkJbedCRDlAYGdNHoTLHQAVEoYquejMSZOAKmdgZmcmWdoHVcDfyBScbPmnoyqwiaWRNXWXKVKnWObnvSzxCULZyKxdIZttebFjkoaZWvTaSAhVShhdwtwZ",
		@"SLtgTASNycDlBzmb": @"qLMOWNOHBtxLGnvrrelArESzMzWyYOeBaVSaqVjjunBLvgyBOjyCejZFuBfmdKVWyVEABXRbTRnHIEfChKgxMSowbCHnOoFxZRbesJuXcHOsnTBSeMv",
		@"deMWRSOsqMkIj": @"AdPhHNdnaGhkbDyQskxyiClOJFTebbHnJiJgFfigdKsTWlXYTNkFfgTdGxvUgtLuZhsIbHjliNKDijsXBzYVAUzVNLrXBKLSnRKvpdExbldjPFMFuaFZcWUmwuAjbCobBJdGARyJtnNINySXgUa",
		@"fAVaycbwoMflAXy": @"LEsyqteNPsbqlnNIUKCZTJjfjTHqfiOYtffkofDRzmntPxpnCrqJFwpoIIibIzuREtbjbSgfNawQBCDMvTEKAssplRmdGsGctxKGAonIzHLYhqctWAAsJfUvxkkoUOzaRUjqu",
	};
	return jqqqVtDaynzTtAdR;
}

+ (nonnull NSDictionary *)ysFOkUHawoCzcQXVnq :(nonnull NSData *)WNahdKRxyxNlzTKO {
	NSDictionary *QEsyLZdBlj = @{
		@"nSIahJBaCMTKTSQQ": @"VnnzABTxhTYpGFVaXXzUWtCfKMaQELNROkghgvZauPBbotLenlxSiONCNkxmpzAazJtCmSFatKDDZcSGyDTTzrFhLSoIWCICHpKsVhhITKFKOtffbOEv",
		@"HPnouiKlgo": @"mubDKDOQuPnOEtKjPSQTEgdQbINkWmnVLZsRzZIhjQNaScoEXGkFxZtaIzzVzOeIaifjrLnaRsTOuDKWnRyFzfwJrObBxoTemHYIMGLTRlNAhKZredvynwBjnBlSigvZuiVQyVwRs",
		@"xJJwkFCaORkQZtYPXH": @"GmTHwvYbVnAvzTUukTaeCjGfQCUpglvCpOYtMfcczHpUnltQoeseTjqQPWUUAyBaTmqMibNuxbUDAHafRGMLeixammlFIghQUZMoOhWNcgePbHKWJvxyrLbznChMbtsHcVGZNaqmsxf",
		@"cbUVSUMDdpmspzWoW": @"OAJOAofGhCBdWSiQgAdcYolcysGdYOvhDPpaqLeDEcBfqtSCvIpcIHLwWxvwIArQWDJTkBYnXPBRlUIDTdWvOLjGOcAtYKVDXlCZuSTGyruVCLinGgjSgNRetytDQZEllztnJsjnWaREgNZRHuel",
		@"GfrjPprLwvgwj": @"wTYZWIQFucGDgdvRTdSjNcjtEhhaEuJkvsqaOXvckRCoceDKwNvNVDmEKKoNOUonbToyRsqGmqfrNzDZrjzaRHqaUWQXtXAbaEEBaTqOrCHzKuhOVqvncKtZDwifbJqocnWjBsV",
		@"ParcjSHJtPMNHlAUr": @"SploMrPBOgihCVfwopJYNGwuUFOQpCJsiiEdDpROmTHodlefBWScgvKfdzqHrtIKQpiKIGxijIjkLNKMYlNivfzQYoxXBdPFAsfAlo",
		@"tglfSMlTQgTL": @"iOnxegRmkKtLZbizlpLoNeyTfVupGBCTgPPUHyDPOKZYcgVYDwwOaGeuHwuuREdbNNgIIorHbiwjLFRoesCvwQaDzGFIMGYBDYTVhtuzGvbvoKkMFxjakfHTcZdAfXWqSZSP",
		@"krVmhraVzTHJujTQd": @"BRfIITVtKTrmSaIlJptPhwDWLPJiOFapOeByItgOIiECPFoxZIPbuzWjpGfjoTnaEQkmpCgzozjuEWFbWPIsoOSPEENVCOdcBffuBq",
		@"dOGAqsxOOnPXLnEHqPE": @"IAuporeXthVMxtRsbCBOoXbfJpsNQoWCHUEvxurvkUrAhdkwYEfvqPzJneaFymHHmXjJVbbkOOXibNVdtOJtYITlznPbUwKveiyTkCwwxveUuMMYbzVUNtBFOkyD",
		@"dUHnheNZOiwMWHLuMR": @"MvAzDilPoBmINKtMZuExOXqmUbCuVJHsFFsXTnAzRvyrASOThEMdAsWqVoUXSuLakvTZTQZbYuROhhXytugQnbIXhLSJOYrBdZihCcTRGBJwDMMweSrqemaXMfsNLv",
		@"mKQajbFPRGrvAVuZHaM": @"kYsaejYceMkEOZlxiENmjFNwPlqNkshRBBVkXJBjPqmvLaTAhmVwomUXKzfzFZxgNhqzDmjISRGyWHbvNNwywXAUdefdxCCvkwgzITAsBIjhvYXzVNlpXDFdHAsWTWgNELuQFyw",
		@"doeubyCXxM": @"PXuYyUrujKEbdgRBeOTaGVMKaaBrWBWpdlPZajGFNxTBiFeyCHHmrTCUSihFyzRZKpiKEoKYalXLoPyqyMeqOXXyLWZjFHwXcHmEfsnR",
	};
	return QEsyLZdBlj;
}

- (nonnull NSString *)hOnqxzUrhGzStdYrRNd :(nonnull UIImage *)MBdxyuNRAYqENpt {
	NSString *vdjPkBNpVWqYDS = @"aCOyRcYeUhWmTlGYLmzmfcgdIyKHdqeEohmBEORKOTIEBuoabmylsxyONBAfsjeUXPKrdLFzfoLJiNlwkEHUMTikacipVllQDByUzvjszTVJrue";
	return vdjPkBNpVWqYDS;
}

+ (nonnull NSData *)TwhiNFsQlj :(nonnull UIImage *)oRghdSEeaI {
	NSData *zEimgQSmqhzqhODy = [@"NVJeIKCKLLzwmdDiPaXcFSRMogtOrSqErSqiRSZQqlmmYBYufrewuojJYtWbrHGvPrnNVhJoXPGkeVjHDYiITFiwdWXoHVodxdHnfbiP" dataUsingEncoding:NSUTF8StringEncoding];
	return zEimgQSmqhzqhODy;
}

- (void) setUpUI
{
    UIView *freeDiskView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 30 - 64, self.view.width, 30)];
    freeDiskView.backgroundColor = ViewBackColor;
    
    UILabel *freeDisk = [[UILabel alloc] initWithFrame:CGRectMake(mainSpacing, mainSpacing, freeDiskView.width - 2 * mainSpacing, 20)];
    freeDisk.centerY = freeDiskView.height * 0.5;
    freeDisk.text = [self getFreeDiskspace];
    freeDisk.font = [UIFont systemFontOfSize:ys_28];
    freeDisk.textColor = AuxiliaryColor;
    [freeDiskView addSubview:freeDisk];
    
    [self.view addSubview:freeDiskView];
    
    UITableView *tablView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 30 - 64)];
    tablView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tablView;
    tablView.delegate = self;
    tablView.dataSource = self;
    [self.view addSubview:tablView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [btn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    self.btn = btn;
    
    [btn setTitle:[ManyLanguageMag getMineMenuStrWith:@"编辑"] forState:UIControlStateNormal];
    [btn setTitle:[ManyLanguageMag getMineMenuStrWith:@"完成"] forState:UIControlStateSelected];
    btn.selected = NO;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self SetDownloadView];
    
    self.navigationItem.rightBarButtonItem = backItem;
    
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
    toTestLabel.font = [UIFont systemFontOfSize:ys_28];
    [imageTexgView addSubview:toTestLabel];
}

- (void) getData
{
    self.downCells = [NSMutableArray array];
    
    self.downLoaders = (NSArray *)[DWDownloadItemTool getDWDownloadItem];

    if (self.downLoaders.count > 0) {
        if (self.tableView != nil) {
            [self.tableView reloadData];
        }
        self.tableView.hidden = NO;
        self.btn.hidden = NO;
        self.noCommentView.hidden = YES;
    }else
    {
        self.btn.hidden = YES;
        self.tableView.hidden = YES;
        self.noCommentView.hidden = NO;
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.downLoaders.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"cell";
    
    DWDownloadItem *item = self.downLoaders[indexPath.row];
    MyDownLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MyDownLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.myDownLoadCellDelegate = self;
    cell.selectButton.selected = NO;
    [self.downCells addObject:cell];
    cell.item = item;
    cell.isEdit = self.isEdit;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.isEdit = NO;
    self.btn.selected = NO;
    
    if (self.downCells.count > 0) {
        for (MyDownLoadCell *cell in self.downCells) {
            cell.isEdit = self.isEdit;
        }
        
        self.downloadView.hidden = YES;

    }
    
    DWDownloadItem *item = self.downLoaders[indexPath.row];
    
    //pdf
    if (item.format != 0 && item.format != 2) {
        NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,LearnRecord,[UserInfoTool getUserInfo].token];
        
        NSDictionary *dic=@{
                            @"chapterid" : item.chapterid,
                            @"learntime" : @"180"
                            };
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
            int rescode = [responseDic[@"rescode"] intValue];
            if (rescode == 10000) {
                
            }
        } fail:^(NSError *error) {
            
        }];
        
        MainWebController *webViewVc = [[MainWebController alloc] init];
        webViewVc.url = item.pdfUrl;
        webViewVc.webTitle = item.title;
        [self.navigationController pushViewController:webViewVc animated:YES];
    }else if(item.format == 3){ //音频课件
        
        VideoPreviewController *vc = [[VideoPreviewController alloc] init];
        vc.fromDown = YES;
        vc.item = item;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else
    {
        DownLoadCourseLiveController *liveVc = [[DownLoadCourseLiveController alloc] init];
        liveVc.format = item.format;
        liveVc.liveTitle = item.title;
        liveVc.videoLocalPath = item.videoPath;
        liveVc.chapterid = item.chapterid;
        [self presentViewController:liveVc animated:YES completion:nil];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark 存储内存
- (NSString *)getFreeDiskspace{
    float totalSpace;
    float totalFreeSpace=0.f;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;
        totalFreeSpace = [freeFileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;
        NSString *str = [NSString stringWithFormat:@"%@%.2f GB，%@%.2f GB%@",[ManyLanguageMag getHotTypeStrWith:@"总共"],totalSpace-totalFreeSpace,[ManyLanguageMag getHotTypeStrWith:@"剩余"],totalFreeSpace,[ManyLanguageMag getHotTypeStrWith:@"可用"]];
        return str;
    } else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
        return 0;
        
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

#pragma 编辑 
- (void) edit : (UIButton *) button
{
    button.selected = !button.selected;
    
    self.isEdit = button.selected;
    
    if (self.downCells.count > 0) {
        for (MyDownLoadCell *cell in self.downCells) {
            cell.isEdit = self.isEdit;
        }
    }
    self.downloadView.hidden = !button.selected;
}

-(void)SetDownloadView{
    self.downloadView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-104-11, self.view.width, 50)];
    self.downloadView.hidden = YES;
    self.downloadView.backgroundColor = ViewBackColor;
    [self.view addSubview: self.downloadView];
    
    UIButton *allSelBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.width/2, self.downloadView.height)];
    [allSelBtn setTitle:[ManyLanguageMag getMineMenuStrWith:@"全选" ] forState:UIControlStateNormal];
    [allSelBtn setTitle:@"取消全选" forState:UIControlStateSelected];
    allSelBtn.titleLabel.font = [UIFont systemFontOfSize:ys_f30];
    [allSelBtn setTitleColor:AuxiliaryColor forState:UIControlStateNormal];
    [allSelBtn addTarget:self action:@selector(allSelBtnC:) forControlEvents:UIControlEventTouchUpInside];
    [self.downloadView addSubview:allSelBtn];
    
    
    UIButton *deleBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width/2, 0, self.view.width / 2, self.downloadView.height)];
    [deleBtn  setTitle:[ManyLanguageMag getMineMenuStrWith:@"删除"] forState:UIControlStateNormal];
    [deleBtn setTitleColor:MainColor forState:UIControlStateNormal];
    [deleBtn addTarget:self action:@selector(deleBtnC:) forControlEvents:UIControlEventTouchUpInside];
    deleBtn.titleLabel.font = [UIFont systemFontOfSize:ys_f30];
    
    UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, mainSpacing)];
    sepaView.backgroundColor = AuxiliaryColor;
    sepaView.centerX = self.downloadView.width * 0.5;
    sepaView.centerY = self.downloadView.height * 0.5;
    [self.downloadView addSubview:sepaView];
    
    [self.downloadView addSubview:deleBtn];
}

#pragma mark 全选
- (void) allSelBtnC : (UIButton *) button
{
    button.selected = !button.selected;
    
    for (DWDownloadItem *item in self.downLoaders) {
        item.isSelected = button.selected;
    }
    
    [self.tableView reloadData];
    
}

#pragma mark 删除
- (void) deleBtnC : (UIButton *) button
{
    [MBProgressHUD showText:@"正在删除，请稍后" inview:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.downLoaders.count > 0) {
            for (DWDownloadItem *item in self.downLoaders) {
                if (item.isSelected) {
                    [[NSFileManager defaultManager] removeItemAtPath:item.videoPath error:nil];
                    
                    [DWDownloadItemTool deleteDWDownloadItem:item];
                    self.downLoaders = (NSArray *)[DWDownloadItemTool getDWDownloadItem];
                    self.downCells = [NSMutableArray array];
                    [self.tableView reloadData];
                    self.btn.selected = NO;
                }
            }
        }
        
        if (self.downLoaders.count > 0) {
            self.tableView.hidden = NO;
            self.btn.hidden = NO;
            self.noCommentView.hidden = YES;
            
        }else
        {
            self.btn.hidden = YES;
            self.tableView.hidden = YES;
            self.noCommentView.hidden = NO;
            self.downloadView.hidden = YES;
        }
    });
}

- (void)downLoadCellClick:(MyDownLoadCell *)cell selected:(BOOL)selected
{

    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    DWDownloadItem *item = self.downLoaders[indexPath.row];
    item.isSelected = selected;
}

@end
