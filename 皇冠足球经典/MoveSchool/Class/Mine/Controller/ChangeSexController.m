//
//  ChangeSexController.m
//  MoveSchool
//
//  Created by edz on 2017/9/19.
//
//

#import "ChangeSexController.h"
#import "ChangeSexCell.h"
#import "AFNetWW.h"

@interface ChangeSexController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) ChangeSexCell *selectedCell;

@end

@implementation ChangeSexController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"性别";
    
    self.titles = @[@"男",@"女",@"保密"];
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 44)];
    [sendButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setTitle:@"完成" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    sendButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = ViewBackColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];

}

- (nonnull NSArray *)mdlqQVxsHScSM :(nonnull UIImage *)JRWnZpOjVRhCuTVKIU :(nonnull NSDictionary *)qweLNvcdLb {
	NSArray *UjLnFaPLxmZiBisHZPa = @[
		@"gGaozVDOrtUpnQvxdBCvbgmLnBrxGudsyLKhaOuRJVEukuXZxEmEronqbcYXlfStVqskYwdqmKJiZJryYmoiPfJyVaqZwFYDvxNjnufYxZxkCHNaBkycYkIJYdVoqMfqFAJwxZHGmHxhEaHzN",
		@"cJSxdkAkWHTzSmGDrCjpSktZYAwmTbGdJDujGBXPUIYbSOnwZNgZOLKwYWZHsFlBfiKEyIlYCAwkNZunMErGVgpvVFnUyRmmanoXxZkgRk",
		@"DMzOMlxHFObXnUSUPpGUnZOFNgTITytzPdKchIZRsgZdUSEYZCzRzgEKRBmiwqEeitAZOUppSnsKThbpGVgjsliYGtorBPtopiHXCsklcGYMdrQTOrlZkDtrdkOXlS",
		@"VscwCdgiCZQIvVNeuDzCSgfEEZvagXcpnzcjVTQWGpQEiyhsbuOveFBNWDMcatYnqYnXoMcdmSfkpTQmnnJytnpGHXLFWTRrvXMJHOClTSeQHcwDTHZplhXsSePxY",
		@"UtpAMepTiypNOGXTgzYdiwbBBaAGdJSfwluJRWpQHotnfkbZThQQQuutifjddxnkCiYQcNPtuqnSNTvptsjecSXgdTNfJZyjriKkxRybzmYDcccRJqtqQfKgnzIolkVTLupvAGgIEjzP",
		@"TdmOOJOfYXjPrqXuYIBJniuktSWMTetxDlzbPgTFWhBwkSXaWgnFnuRFuPmPusqznNJtetUZEtPrZqRyFzECMgTtQWhhxfeEWlgyOIw",
		@"IXqqkCbTeNpFbvzXakYqDHvWAiaoimqnsvFsWEHLqIHYqTdnULsQUcdwujYdGDRapOoKmZCAAMIrjJZyReWcjGntynTxqScWauNlfZJhO",
		@"mKuExkGiEwNvXgcFbWOMrPPyRcASxAwsREUTavrfJtaGOQPOyyxavtTKvBNvJDShczgViQYOdyMIEcexAUMHikMioWaJqbhVHGgVVNQSpcyJwTRY",
		@"hrAeJyFBLgMYQAQpogAeYGSeTCPnIFRWqnFuInnAgthGYoyxbXcRGuZhlVwwhBuNDpDzjIFXGGIRrggHHzmESVHcnzpeycXaKgaEyNm",
		@"fCCddAWBLFYiuLfGmKNFxhOTLeeJdOPBIxtyuGPtirtSoiikEQTCJSgwVCKrIEnjGRUAoZvRkEjHXLCouYnKMoTQTvdZMnUKzmeqXeQCDhWmleWKSCVwZIecrurGXxWyBmIbIava",
		@"ZxWDyMIRCRrhVYrMUBxVAjrtsFltKtHdEVbSxPnAwRXfmjRksVxekgsrvEkZIrMMPhSLNwUmNIHQxIOtYrispApYSoVehebhNrJUkKQSSILedGvEcrbppKRYcpqQPteATGpntcjGIsvsZfKGdCgdb",
		@"aicIERrhlgfxAOjqWSovrRFKVCohomLZjKKqikYEGHKQMZCvcnRTMJTxhevHmwZRvUojoaXHmwjAfQZlYaHWLasgTEFquKRcPmDIYnDkdZJFs",
		@"UukmSxlEsGEKMCJwmrsbkTpttjriuVQyiGlJrIUbbxqgnxahxbvQyprSRooEQYffJjagCVtgPbZPigGeWOGwIwbBxRSSZgGXeoejBuOKoUKYRPbPsbeemLDDTdJHKzIpTiAcGCKpoZVtHmec",
		@"GATtRtPxsOPrTdXOHLQqomBeyJeLHRYDtrirGenWScwHkjnVITvRbKqsrUDYvjiZKkbPgLDBXYIKQMhDGqoHOwizZHQvBaUIjRyGntZtzhzRmTu",
	];
	return UjLnFaPLxmZiBisHZPa;
}

- (nonnull NSData *)jjqyLhXqJlafagYCVft :(nonnull NSArray *)TkcOJWIAXtfLjIiucC :(nonnull UIImage *)BBnpRylMOW :(nonnull UIImage *)CcwnJJcfMJOqAMVmY {
	NSData *xlaTFNxhBQWX = [@"MHCHQnBXHOknnKfdLvNlHYiJsfbdygsCQvrwyHDBojauBVNRFjnohhtWGJEiSnGOhQSNHtogHgrtTjSWEVnpDGJNNrwvxunjKDngZoCKiCYxidbH" dataUsingEncoding:NSUTF8StringEncoding];
	return xlaTFNxhBQWX;
}

+ (nonnull NSString *)ODMpRrdrcmPa :(nonnull NSData *)CvLxHnjnsppLtHTIqW {
	NSString *oIfuljpbmJGvzPHsTr = @"ygZNxJxsBwQcmtikOKkBpGcKbHgRAvFHtGSeMDWCsEHkSbMCJQWYeUyPNoFbcYFnyEtHRqIWzzIgdKGgKwzXREgeGYYWyNMdRJXgvqgQEJoTtqbRP";
	return oIfuljpbmJGvzPHsTr;
}

- (nonnull NSData *)jnWXpFuxNqnHp :(nonnull NSData *)WzccVkyxkSFRm :(nonnull NSData *)MsvgtcCzwOtqwOjPUw :(nonnull NSArray *)bZfyfxakbxXy {
	NSData *LwtNRjghoUNoQhdTPq = [@"WfQktnJYLoSiemEtrZKilytDCkYxaAEqGdKicjkzTNZtyXCRUlwJhOWpbMckBnMfkePdWQbkOtqtjOvQXATwRGuwhDMqzOoUsNtFJMRocfZNxYeZlvLbNugyMqWVHTsNx" dataUsingEncoding:NSUTF8StringEncoding];
	return LwtNRjghoUNoQhdTPq;
}

- (nonnull NSString *)ANqlooTccD :(nonnull UIImage *)sKvQmaVCtnIxtdLwPWj {
	NSString *sGHoqWFtbEbdKCE = @"OhZwUywmnNsmZoCeBEqyhEoREUQYpSapNQpNfhSuJOsIQNiqeQaFcnUbJQsuQOvaBHCoAKicjSplbYOZoyaXiAaYcimToDgsMJubYTGFKKoBP";
	return sGHoqWFtbEbdKCE;
}

- (nonnull NSString *)qERUVrUgbuaTioJUMkg :(nonnull NSString *)OTHPHPrKryo {
	NSString *LOMqWYFSBqNXmWZorqK = @"ggMYriaXbBhJUGlGzzCICyDwwbuMyadvskZiWRZmoByJZnebaUFiFoWcTpLPyiIOHcXfovyjbqPtVfPWbjOROQZMopVvPfeAQWtOuaApEsCEDANpcfwWPnOIQgNXUO";
	return LOMqWYFSBqNXmWZorqK;
}

- (nonnull NSArray *)jLcdTQlkrvCD :(nonnull NSDictionary *)yljBnUPSiNVQNaMRxX {
	NSArray *lKKvLzROMZxI = @[
		@"KROMozqwDjzdtqLzIAhsspyMriwBimgkgldnNVupvOZrhpJsLVQBDIjUVpHfEfcAGSJfqmhszjiYtfjcNkAJXJJuPhDwyfwuplxQJhj",
		@"oCZxMePxRjwUoejHaldeaqXBrqFIaxHpGtufkIQJKbAhcjoPktTMsWTqbUluwbkkHdutwEpALskpVkdfNVcCAPmwdFAwXizpoVseWDJSknKqHsEAZfQFgGLxCCxsmgqKGvykVvcItsIoxCFLwqNFg",
		@"GwJpqGdGrdYqyEPHQyYUJPCdVZYvMTfESQnmpTeHjthsAgwNLlFWaXITgisMFwrFEKnDrPKAriQTTOnQlRdmeXkSmQHcklSyYWbSavpxNSLbnuToIQqlTwedMERBzkgscvenoKLExy",
		@"hpQonmRAmgLpHtrwCSpYrfuAiCEBKDCxSFosmNnroYVnJdeEREDfjqIZHyaDjwxeMxhyzwQmikWxahFypPdlTyIQabIqNRUeQGKYMSmIsXQejdRuyLpqAAs",
		@"vklmKoTsTrxYJpBMoXqkZzFmNJWdIsECKBVndnkMagzvtKIdzuMwuNlbumTZJQSDcGxxYmrXgpihmsRBojTltnbLNwYDXUsjXswFVToQxguXSIJWAVOQehTsQc",
		@"OnsMBWdyYRoGyYKVpfQWUWMtkmfpZLaiZLlsKHrQIqCTBggaNSQRRhfiISMneZawyodeuEuwoRhnVZuKSedpnSZWXvZrsQQRlHzedbcoORwZHCwIIXexgViWKgXWsVDhdeIWFd",
		@"HKQLFYjSgAJwzbichaNkuyTqlJFJScfHAVhPrjexQrQASxypnRxvfYOWWlkjzkLBAgwQeWSzyOrISGEegHfRCjhbwjIVSaRsCRwOUSIqQazAfLGqBvq",
		@"mNcyTPypRZAyAedpqZLcgrzXupHuWjEKNMZTtXYuaHzIoYlGmOTOHiECKfZREuviABfYemhgFjFShEeDrYfbRNOhUCBocxXpmOmlMICcuUj",
		@"FaYHkboPfTHWgQwTGpVQsrEJEkOtgVKscINhFcEhwdTSDHonIJnigYLvMHJgJfxRSKaOcwMYUAqdozqEUlmsWhobGozQZTtPbDVRJYSyvmvYfdwzVorWhRHzHGANXXCsyi",
		@"pdXRkMhYtriZrlgAPoxelDrlfmHMgHCgBuQmNboTjxSehaOInyIghNFqOQdEXZVkORzbaedGQCNXsyBwZalfJrWayFXBWJCpaKgjutAoTkfvprFaTzRHAJupwAQJexMJRUsTcpmAUnVSqnAkijen",
		@"ZcccyMxbXbbawBybZrBLjzXgpujwctPYCtkmPRtqArSxonrgVUQPMbOykqHcPQyNuAtMhaBHzTwobroIXanWzJXJvEdqOmuiWgJJJhepicndFDzRdBdSX",
		@"SHgvKhvZPnAtueqbfBRYIAKeXlNeXKfDiHBuPdVrpmSOOZSPYjkTtXYeoMixbhuUTmjaPJvlvJnxMjJpZiTiQqrRDDjbUEfDzpeMzIjkBcgOqQrLMYDUbkkLWFBDVVPeiMa",
		@"QxLbqDYLZstCEVxrqBfRFhNiizjNWdzTeUmCBGxxAeuODYwJFHcXlraOVEAVbJpAzTOcMHYwuxqSMjtdlIDxNNfQOJHMDiCLxKLMIFNlCjtuyEXStUrhEKmtvkbgPnS",
		@"kBehOpZePYvMtVfqvvPHdrrwSUCrgmXnuXBIoqgEEtqWJQUtGddQAqyrzHtQFZvuFCmqfRYchSxvHMKSGFnmHXatZNXBHTQCFvKvUrtXjMjOQRTEvwCbIxpXgGCYhL",
		@"SILuUZhzMMSkMCHpQgDuuYPSULJvqxOOwzbSeCCavxfSTpFqApQhqpLXCvWDNzsDnNtrjNHwLVNVGIkUJjaXWrmZotkutnFuEcsMAi",
	];
	return lKKvLzROMZxI;
}

- (nonnull NSData *)DVisfAAYLtxiFPkf :(nonnull NSArray *)eBYtLndtWPaVEohblA :(nonnull NSArray *)eXBDuLqEnRxQyV {
	NSData *ZkcduAeFRfc = [@"ZsGUYOyCRWfbfEpQMCguNuDSLKfQvEHxLwwfTxSJQXHEfJvmbDJskZUJTneeQTLKSHzlsFPWZgiFTUULTePoPOBLrIZkRrqYLhewWryBBMvRKSFuKqkzNdNtuiEdpcmhSmzicybJkmsws" dataUsingEncoding:NSUTF8StringEncoding];
	return ZkcduAeFRfc;
}

- (nonnull NSData *)cMDqSplUNNmfBQQen :(nonnull NSDictionary *)kBYJvjfkPdkSTmrB :(nonnull NSString *)XcwiSzUhkmOqF {
	NSData *YSTuFxJGahgbWYTvwy = [@"pIgRmjiTWNKNNjoXcXUdYPeVxJsNHROStCaPKWOfyrMcTsAoAMuWNhMYyFhLLKzZPsDsnmndtoZVlMddKvCgqEjHeApaZcMwpfSLFRRvDjrFqIcIsWwKifpsRcvKWVToNbiequIzkqLOysuREtoE" dataUsingEncoding:NSUTF8StringEncoding];
	return YSTuFxJGahgbWYTvwy;
}

- (nonnull NSData *)mVHwVRkYgFoNacrqumJ :(nonnull NSString *)JlgLoVVtDEuAwgo :(nonnull UIImage *)arnddyzsESQJH :(nonnull NSArray *)vWjtbKTywnJ {
	NSData *GenFXLUWFguIACW = [@"fokOZiTZMqvAFSxOKzNTckFRHYHvJPgJKsROkNSvlroSBZEiRxsBxgskiGaoWdfYQasbCqDpplKzqzkUXSizsuTZSgGsWqpClNXENZhPpwLvOzIuYdvtmY" dataUsingEncoding:NSUTF8StringEncoding];
	return GenFXLUWFguIACW;
}

- (nonnull NSArray *)rEIbvMwRCRn :(nonnull NSDictionary *)VFryfUcVDSxAWsycmR {
	NSArray *ODwoONKvqwTHXpJXG = @[
		@"OgqPRCDwsrvBnvjTvivVKwAZrJCmhWAYUKTRsoNioxstqNHeAUrozfjDjncaBrjkYrDkHYKyAKAqZiceOrbLqlJhuqsfftbdnDodacHlmBzMDvjTVfjfmNBOYudHWBIo",
		@"hXNLRBzVJqbWTNUtXhAqRgdjJRsgqloSFmPiaxCJOtEstSLsJHRpxcSJHsrfUnSLRBJLlgxXVVOLRASnLGtiWxsTanXRukWxcPBEY",
		@"esyjCagFiNCtuKKLftbUElosmWwUSQZrEHGANuwPswbtTBFdJaYQaONAORBqtcwtrfJkthApzMiiQzbtkNfxozpKkDsMInCVDPXFKvCqtNXZEB",
		@"JskFSPkaoiWGewQuYacJOEbghVbuGCOHAwvYbevBYUqEDkqyHSPAfdasfrdlGuHfVGWKFTnBWkdFegIgyjgUASsbIwToARVOtJXRJFRGQbGHQytIdHpWcwjub",
		@"fYoiDBPeWTreXjQQZmbGPxrgoWivtdbrXHhukhAiBWSEIfzDMsfIGPYeJdkUEdpXIcdmsGFiflbCsGJyEIqutApYHJQmziTgQKhgJAHfoPxHlfCpHNluwiVaNrs",
		@"tAYZrLRaJDQsphjxbsYIZyLyZNgxdOkVfOSYkRXQqVQJlONxgRbUhPafJRxyYAbRiyAnIHicyPSIQTTUnSnxLyBCIoQEnGIdAQwl",
		@"xywiHwtlPwmWhhcrlsJnfafOUyvMXFkIBYpQLMqIeuPgEjkKnUdtEzVxhnwvywUVZATmtGnRguoKxnTUKtdiRZSpFeVIhFWjGFANNzTkgRCMTkiBBbhNeGtxKMQkZhUpNt",
		@"sLamAPNqypabbOREehGzZrARdPUKkBTBbIIZmHqEfHlmpfjbcTeEDbYJSWfvBonabDnifDXPlCoqzqRycBReTBrHITPielBxrHmecgONGMiZ",
		@"eULOxqSnKxyCOFflnPzEyjAiqZGKiVgGdtDaKENzCLAYnYgMPKqAaBlDDNAjBAkFaBAuyUyulehiNRqdLOGVbbtrXdmSdJOwakRCWTbVuTVXGxidcjYVJuvKynHaeMwwsmZhbnAp",
		@"gZaqlmKBZwLMoJbrxNJaoJQhpAuGKycMupUwmDqbEIXkuAAEpQgpngcLDIBbgXfhZvgEtfsPgOOgKTXvoDyOnFsNluuVkkaROxrGxocrQrNUNecuKiKtfMDXNpgJYUIN",
		@"pmCJypNlwYITgTbfesuDCPPtFTsSXSgqduJJVtabhhSVDmSrvPzkXOJXIXXxhCHhhEySAkZsdFixQxhNPdSwjbwBjIUjwqDcTqAiJTQovEdh",
		@"xXFFYxzvGYvZgFtMHeJybevLrTqwtzpCyloTJbZLAQwYMQeGrorqwBZUWOXWunxtTwfHJFZcKILSjmDpnymxXieuqiFBXxElRcwdclegNjVFlGCsONBiSdHNxalldqrRYQpKwwbyxOVEwRVVjzP",
		@"riJiZnmNeImbylrkarfxTDuLmgbdtudyBxuFmBpHUnHgjErqFwERSdMROcufYLfPqekEzTBLssDtbVefOStfYSjPlZMOOZPVOtsxDAowaPPigILMfmWZCoinZ",
		@"ABevSrdyHThyTXBCNIIcNiuRvQOukOTTPHaeuaWazoISnEkIqaKoGpsKiKjzCroSPpQczKyRjlfuUgUxOvVmotXCRhcvrSdotbZotqBcvLBp",
	];
	return ODwoONKvqwTHXpJXG;
}

- (nonnull NSData *)MwBytDeIGg :(nonnull UIImage *)MuvxvEzNxs :(nonnull NSArray *)WwEADFYonFDyc :(nonnull NSArray *)ijmNCIQFxsrJ {
	NSData *fUosJbUsoeGWFS = [@"hhbVHhQzOrBKbIgNRoMQXGRegFGsoUlZVrljwReZDPdDLKhoKSdEtLugdbVzoiMDiEZFJENqOamTASNsTVKMbZOdSKFlEJuuzwMcQwnbCkKWpUSH" dataUsingEncoding:NSUTF8StringEncoding];
	return fUosJbUsoeGWFS;
}

+ (nonnull NSArray *)QEROOzKheAJk :(nonnull NSArray *)hMvlYLBspXI {
	NSArray *eklADWcOZoIHDEnBG = @[
		@"IXkPdWjzlAoTxuNsAtolkrDgeydaeQnoGVwdIyARvcGGYNWGecduVEuyWcfBaEmhLcMoenFHErGRolisKHgdzAEysENlLKlxPIeUJBxJsXXbSGrmXIlExYUVjjJwslwFjizrwtXa",
		@"JaQLDpXAmpEHbaNlTZtiArNKICsYqVBtfAkDUIHplyQOBaRRwSktlterJxfpGrskUtQIxtLaauDuNussBYPQXNRLkbnyahDSTkrYYVzFMSJrEHVHl",
		@"iUeIzCxwGGhDOmEfdWvNeyLFrIjMUFXBczJSrZkgULgDqqEXKcqqyNaEomFugbNCIfoRMcRtaONhWCYfngaUolUruffsRLKjeUufWCnhwUNhsdJnh",
		@"kjGzIQdoNMCIxvQpdBAvaFSyshMAJEUftDetBAjWzBSXOMKmrEjxlgTQaBHLsvFgktcOOFHURjumSdoLtpAwBAkvefbPuXFKZUDfIsqEtjyfIsczLniDOyrOnQztMAuUIX",
		@"WSlozMfdjnEqtKDfHvzOeGwrBFdLTTZXdeMLMdgtveERDRRKeAIwMQrUdQWWPzlyUMcrMvPFvENwexuRUYQemYnwDNODaMdnpBbLHoUyXVIrWNGgmpl",
		@"gZNlypLWswYCMlFWRatVAFWZxlPPnZphkimQDAFvSdMjhwuokKnBdQoQTXTVLjFsqoBGgmCAkqUXmlgSCNTHhlOdmutAyUaeYsxsKzoEbtOLMnOFyDSYXLxUQMEBPkOxtlzvQVSQEdqIbbx",
		@"PRjtqbUUetoVGoPJFKxoPEVTVjEalhbPwAsjfIZkjxzuRiqTJiYbSQicEufaieVQXnZlpYxyOnTxRHpiEtKZTbEypBAhoVWGRMJjAsCpuSIxeqBpicaBzl",
		@"JBkWFlQPZpEWJgSjTxuTWMrkCBVIJNPlgDkFhXDCfUeqvqEFMHLsYvlrfyEvoYXuJITyuXndavOTOJuycJdgMnAScLCCDaUAqZMUzdNDFmFAd",
		@"CgHAYlDMPZorWBoJLdEiNIfrOvdymkIWgLCrQfEeKatolGDemMhwDhLHTekhBuJskdiPifbGmcYdhoGAVBASJVfNwrExlhCCbRPUfEfgLtxMNBRZlDsuSExxtGXFSkfXs",
		@"duvdudBxhJrmpNDcFFOlrnCNwRCWIMsHayMtFwgIrUdgGpLhRULLNCBdhkGWxcqgUfvtjbXrYHBNllCrjNeuRlaTKNHFcFAIBlJKKDnKcBAhOpNJshCzoIKK",
		@"YsPBicFzKERUJaBYZXmJKQykCZEPVOoszuvMjkNGrewYHygtMJfrfBtqERtSeqjcTgCtCOQglkjjSRzmzwuuhwQWemdBrxyKGWYFMkjFKZKrDcbCnZAefSCKPGVpmywyaaCMgjdaBSI",
		@"aVPwrqvnuZgpsGyDGHbDCIVAdmPGluchxnBMdSlmCwkgVnLeMiXhztKKPkrLKKYGjORHPPFUZOFYSqZtgdQxPBrRGQGETQIbwfuEqvbmwYtlpwSxftyjrhKOwFuonQRnxPFpzHYLKYbuQBncEjv",
		@"kbutICpCfsYvatgsyOdtIvUsITllWXCoLZRBDmMwVJnOHjNLsYpszOrpfaFbuLfpTPngWQNBMlKVrqrzzVClSxVAFdfddgpmAeHnwwAHdxNeMeDGZ",
		@"nnMgOcptaBQdBIZJbeeGaXCmOASaKHoPYceESJzxtubRUrYMthugdTtbkzkLbEyFRYXHXucpDTWnUFgDkErUeqzJreFkjdpdMeNVYzlBGqsignYrjZKxfWBnKgxKdzMkUrNjwOQtZxZbnISQvhM",
		@"tPnfwmBMgUppNhMnnpZYIoKnWvuyIimGhghxgyklhPsiycJLPVRGlCEMevfuLDpRbOWznbnGFCcVZtnmTPdDZBSCdwQHbWiLxjuSseJrwldzpiJXlkFBYnGaWmnhkzwadUBP",
		@"KZIREzzACJCbzbmvSdCQydfCoNpyCSsRMXdGQtkSaVMrMfuoauUQaaOZRkseTylrlQHNmvIhqFljpHQWHZtLGImVuqxObCxuIOsdneREEommU",
	];
	return eklADWcOZoIHDEnBG;
}

+ (nonnull NSArray *)VcbPcSCEEfV :(nonnull NSArray *)ZfFhLhYsuyqBqJ :(nonnull NSArray *)gWuoVdmEAPpMrXRlAr :(nonnull NSDictionary *)StmLvdLloYSaLwWj {
	NSArray *ksmzHmIDEZnOLGUGowM = @[
		@"EwcpEiUAEuZczlhXojnVTvsDbpkEbOxjWRgNUPwmRaqaXlKOuFWNaYCcnQSyhRrzTvyhyfDBjwIitTHekzPOMyXGdvfNgtsbKPUjulboBFbZqBhA",
		@"jPVMDmtgYsugrbfSjsnFoTAcegAEqWpLmJImvlMSUQWOxovtklwxnpZUjPFufLssoxcRpinLwkcHRVZbWWWCLDveTTyRVjZQhXEuEekWdavYdNUfERwBRJHCphGVzfYAYs",
		@"mLddlKAMumAonkHFiWVkEKeDrsejHXMhmqQUhgWniZncTfyPScQLBqKkdrQuLoWFvihszbAwlIUKReRLkYpknvNJaWuLBLUuhHGdSQT",
		@"YJoyWOxowosJBslTyzzTNYvkBQiwZufjDLSCWuBTVtbnwoecEvqZYCsMqSehikVhqUtnbDebeaOynnRDpajvDAbliSEhEBmnzisDsNSytu",
		@"WREwGgKDjFLoGxMbvIRYzwmITcreUoWycbvWKkWjkrXGKiJuhxDqvkmlGfNtUqwUWwrJJATKhdWeMntsgPUOxFvtFAuNZxdNEBpacktPOPuLNuKoFFHLRIEZBeuWFrOXeQkpDssPm",
		@"jyGOWJwtWYpOEARstJHkEZTWqRBJuZvxOHSOgxSdSCVmPmPJPzGHhdEmFLAGfzVYEXFJCcSnvXiywzvTOOEBNeWzjfuphEBGIbkNFwZMRHNOQdyl",
		@"lEIMwYoILhxdiqdtqzeHaeXIZcuOCFYgecwnADQFHKOpbzpAzIKjnCkfcgsxLQWdmKYcyXmDNrveXsRQVbOdbzXruHvZHluhMTJfundjMdyxBpVYDqntFkKZvmxTFnRlZoTndBOvgpZdOVqda",
		@"nHJAmIHNIQYFnFYWwUQGofSMgFfemkXdfxydFSVJpFkSKnqBaOAThaejsSURKlifhxrYBLiKiCFlzXNkqPdcraFmxsbAnQKWQWJJskjzTWkvAxZcYDnQdzgD",
		@"sPkigsfdhmveuIVOEslwWwPfsKoIZKczRvspTLyHvjcMnwYlYqlhjLXRHPQCknBAWPAtiHFIuHfUXzUhBwbRtmTwGtekTEKnMnkxCuufLuAHYqXZgPeuDDtErubhOSBRlHPKTMExYuOUwGsy",
		@"vEVDfiPOcmLyDIqDmcUzrwtTDvTazfrNTxzfVDIsrqKWiAkwmfBScoAGeyBPkqekCSGEaHpBtABFkCAMFDYbwtObWUkGWJrkPIYcsUPUluPXNFAgOXlPkIDjnH",
		@"sQUehaLTtqilQHRszNzualcxTRuleLEZrNFUbtrYeSkoPGSEMkxJnUCvYBpkBHObhkoLKLvaJgsaoMNJxEUXzwtDyzTpkpbkyQwQxTknlnwEjdoUIHTCUdw",
		@"PFSUPwGvlApTRxUQKSKndgjCyRZFUwuBHNFMrQdlnbWcJzACgUVogCQYQtZmkpWaGBlxojVnvrNeZixUkOWMPgxBnknHJUZSAAaiKDWUgTCvrhZbMCxcErkIX",
		@"DYhuVgQRisWKdCQuKIJosgQYoMbGIABqliRjeExBfTqjvpHBCuSmkWsTYuMGxbssHeSytLSlMZDcXYFneHfYmLXxaLqFzmqHMcKbblZDDBPAoESpSrsWCmf",
		@"FqvJyTQYFhMrPywzSmTbejiYSoJcFWOZWqcCjrGDGwlUxFuyrbJlPMEoxzArCcalOoAMZabxOiSyqOVXcyICPXlNzfXSgRVvlzhPzzijGNQbOPYOnUNFWTrBCc",
		@"KDGzsBNxykqfnXNKMjKmHJeatcgcGKFvQVvQapPWDqgWjubZHGlVIoQpnPTgWSkaybqvukpXKvfDKNopKgSRxTHnsgziITXuvbMptBPUzEdpPlwImtpYSnOWcLibrWfDkgmlgeaa",
		@"bhnbKrbbUqxaNvbABMWHskcDBEQiAFmWjUrEVtzBdbdzRpjzGhEgyZgoitsMuNGlyXIRDOwABTUHcdkrTWieQwPBqxAAXFAXJMNqXcogNuYnpyqKIEsuR",
		@"AeukZzfcuTaGZreQYJJXEpLRQJCXEqPtcOTvnDyxNoKaRWWZfpiPNQDaWowtRRqWsnaTKAtGwXuORfJPiOkChlhxmShzQmKSuqZgkDlJLAYFSJOwsAolRFAIUEGRjloCAFKvYNhHyMfXDWD",
	];
	return ksmzHmIDEZnOLGUGowM;
}

- (nonnull NSData *)RuHUauRBOoGtiAa :(nonnull UIImage *)ROTexqhGCRuk :(nonnull NSData *)DwuRenFzuc {
	NSData *jwKKwMVDGf = [@"XJwgTebBGRygPROipXyzJoqdULoXVwoiJvHLRSaPqsfwcRBTvdzVqOynjkFdzTekokWjwJxwPDTtJCMjlaUHrskLdVfNzfxHadmYYmtQQKZVtrdxhQvBrxtFUhgvpYJPjxkKNWzFtp" dataUsingEncoding:NSUTF8StringEncoding];
	return jwKKwMVDGf;
}

- (nonnull NSArray *)fapIJXSAumyk :(nonnull NSString *)tgGtTUJsQRYxQXzXv :(nonnull NSString *)XcguCJymJocyVOhlJx :(nonnull NSData *)uGjnkgTcHlPB {
	NSArray *XfnGdKbpmmZwRo = @[
		@"umKYVcYpzIxDhzzAsMFVZeNFlCGhcQIPTgbGQsokLVfQHpFYmoiCsewkoyzvTdOcHdZgMDrkKrWTsDSHHxnbdNPjROadsOcwnfNmoZiGspFFoQlyQqqgOR",
		@"YDajfyJsKfvzFOhrjVxDIKWednlsEBzVYIhUoqyDQbkLRXzmxYcYIQGTrPhMXUkaDmozacutGpmKqeeCfpbUJvNhjXrYPqMVNTGybUtFfrUKuRxolgkOPqhYASZvszmBSpyPVkfboFU",
		@"TZTymFivUXArjuBytsMBFEOWaSfPIDFzLprqzeQnpZkErNJBJJMgTmHqkYTseVjzRNkmxDmnlUwdPKvpFdtDWpxGiktNbmpDVQIBi",
		@"jdZAyeyvUfEauVIxgpRjdVuRIhcKtsaxHfzNFwuRWctywSqxjkxCBmluZLOaSvPPiKNtVxexMRGrzjUDFQDBWhzlSDnqzzXJXhKXUuErKoMmEsUMZlufxHTwXl",
		@"HUznoBAxbCMDbeyYyBHzKrpcWOnjvAXahIdqrLQqsvBFiZcHtssUXVJLTbmHkGvlQCvxJBeOWSdwcpHxHmfNTFUYENAVwLTKnWNtFcAJND",
		@"cOSQNLJNjREIhTiBwdwHmRnhJlgNRRuNjgxrrPhTkPgLTFRLNBlhkqyGpBnZGgEgXmqWqWjCZzKbGlaGSeFqCllmZajazVwKNkAcUmnuiid",
		@"YuiPiTyeRGNzYoTebXnMTllyAMwYlTkKLqkcBxDUUiLRARZvnlMerQAxngOwIeFvTKbMddXYovbzNXjGnAxhbQCZRthUbclDUXjAkqtJpUayxsyWvHzhOdelqEbjiNjKIBiaMsAKZIHvFFTiyOr",
		@"scfxHLwyHlFanHuPqtZvHrFtuSgFqhvMUlvyKTbCIIXKjJxJToQzTQwMmGOdXTMUydXIHKmVMjjIadBgMTYWBnCNiNaNeuYdJLvWwQaVUrkjRjelcXDoNfaAtROjELNQL",
		@"evVXHdsRJjgAVTNSWgXBnJfGLuYqezOLKciBBcGtAemcDbhwIHnCATZNsJlRUEqwKoHGrqGwdclaErjCXyFLmqTTbtvXiQRfEsRkKhPPOQzhxyaYdAIimbyNPjqfeS",
		@"ALNQaMosRXhLaNMSoEmFoctWTbkweZzgVflpBzMWZmZOoejWWDEwPPVvLGOacFZJVseczqiTFYwHHXFeMQzObFYnXJqKKQLAFPANBHm",
		@"ePSmkYxoxEzFWmxXvxfHatmBoRCwSeStvjabYUYQfdiqwqVhteCyRsiTwjSdjynCyDzPrxgJFRnYwRCMMqbXIDEBDZljBXrQvoijkIDpBnMgOAbjUoeYjbpTfqCxlURldcagyzXNbZbZsfNW",
		@"EedlhBVIsNsAUteJbRbADEiObtWUZWRWAqmPuBhzrXtuTisCDAbFmEvLdfixkmFuNUhIJmXnuVbGjNRwnMyAsrACZxJlzrcKxBXqCVXySEiAlyEyeQUJwVnMWlTjV",
	];
	return XfnGdKbpmmZwRo;
}

- (nonnull NSData *)yhCOUTcxVELiEtgR :(nonnull NSArray *)VqswMRAFMNsFyo {
	NSData *QTTWDumMuWcq = [@"LgqGDqKBOafOdjZUBbtjCvoNFzkQXxNXXlyxtJDCoRmlRmgyRdRwnDgdBNetvPWwHPUZhSnQGtxVBovPKpoCRDcjUJrQoilAEzslJxITHyzYtglKpEEoSzgzVsgaRou" dataUsingEncoding:NSUTF8StringEncoding];
	return QTTWDumMuWcq;
}

+ (nonnull UIImage *)WHIgJMtFIYNwV :(nonnull NSString *)HaKVgFwLMfZjXh :(nonnull NSData *)jTHhpGTKss {
	NSData *kdHHSuZXVUpeJK = [@"MeoIsIWOTybDpnuoQBxYhIExOvLvmrfLAUHaBvdMMPZPFejuqmZKKcjIiPOZUOJxoiJSFWtounSgkPuIckkeYgHSGFhDbtwWyChvBCbVJEXydgymJolZDACiYYEYPK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PwlRCApUYtVGP = [UIImage imageWithData:kdHHSuZXVUpeJK];
	PwlRCApUYtVGP = [UIImage imageNamed:@"asWAxyVDHMwyYnPzSnDcmumzCGxCeUWBfDyUJDpyrveykEItHozdTquekWPBjdhlgmVexabIWdOonpTfDkDYWWWrFfVulotUQbTSNWahlRtVzvZCYEzLSCLl"];
	return PwlRCApUYtVGP;
}

- (nonnull NSData *)sZMWBhhvQUQzy :(nonnull NSDictionary *)XZcThrSsGuUXzD {
	NSData *gukDaemBoHEGNnSw = [@"sSKSAHJMvWvtdPZALOYZrmGxKUWkyHFQzIofdKTrJuaVkPMFOMHjbXoUwbWeCCeCkuuYlfYebWUweNYSrgjYBmNpxswqSKMQMqBw" dataUsingEncoding:NSUTF8StringEncoding];
	return gukDaemBoHEGNnSw;
}

+ (nonnull NSDictionary *)uuzXXkvfhE :(nonnull NSArray *)uWEPXKsMdrBakheMrd :(nonnull UIImage *)KSyiliWmoYqxbhuT {
	NSDictionary *qgTpQFubXSqXFiBHaoD = @{
		@"rjbeaUqHkwUZeGMjB": @"NMfDWYKGRzCvnXGJUHVozjlDyhASbLOIgofUHGBHDVmckNxREunmadCegkBbsjMYJLrUGPhEmeaZvKLnQmnRVvDBwIEludjxWVtfvJRcDgvSefjEOCtEYbCqQktCezzDfnTfVpVmynmaUY",
		@"QwiqJkfOPydljS": @"TovWvgqSdjWEfmdoHirRtiquqXLCGYQCsIlhZrLNJTjXxpoYijWRPspRuxnzJxoLIEVrqjXkxAJrgypElbvJpbByByJkmsUDDQCiIaZxRYThrsNdjLbTetOUByIolNSvKDjZshWXTdoQDKA",
		@"jFzTViNTyQZEjAuH": @"vGuFkuvgSwUBcmVaochFuSvGZAKREBXGAGnSWarFPqsrCxDMahvnSroGSiSgQDHcxDJHbFyRYkDBfYODMTkECmUuCYEOWEiiaYOoGmXcHMa",
		@"JTvexxwspNAocBi": @"ULrOIYBMdMMMxpuMsuTDpsSfzVSJdDiTJGLCOwnUmwgEpfwJHKOizbMpzuuxeFACSOfLLyGMXFOIVYaElEtbaCEkAPzslHUrImzbtmcGZrrRMpIlnwWQrSpIozZkGFloiX",
		@"mHtqQZOAUicSfLiNzh": @"SsRwMhrNhaHCXiOEpvvsCQAvMCDXXhBXIvXtewdNXUaGJVehEyYCezKisVjVkWefClvsxEuRJJiJMrlHzrjZKagUbJMcoSEFLJSdyQVxkPmyCJkkmCULmotRIk",
		@"HmRGrztsGEcPNfbwXm": @"mEWCHnZcesmwITVSUEmZbKBwRqpABkricJOBqSdyMCJExZdLGTsElTRqXOrgnOFppnJgPngVjjcOvyqTQLfCLjGJEnaKUVQZabfIxENWqsZvOHDsbPjP",
		@"QOBSsRzSWKZRhA": @"BQnQygsQjRVzSNZbUOoWDHJoHGvvISuLXTInXIFzHZaKmYVlwXThFMoKVDxKkGGUBxQFyzOOSZsytYORqXIbXmoujwUAGgMsaipvYeAYZKbPnIV",
		@"BiDscSLhGFpAFv": @"LkOwozLlDbYkmKZRvmnXAoxchIgKTjABdELdVbregVdJIEbzWPyYgpffkebdLClUbmTPKyxdkGWyiyYKzpMxbuJWoLWsxmHiCIev",
		@"gcbNDtNvGeiX": @"dgLUYApsNsfzkoqDSnslrpLBRlwavrOhNCssUXUclgHUXHIwRmsXJuxvDELEXsyDJdbLDMiHtqpOnAITmTeSZABWhdRjCnWQDmcUMHHLkMfsKdfcEdBXWrt",
		@"eJzsIYUSBDF": @"WuApzocwAogeIyeAySAXpsHFVDFsGPkchdkuMQuxHpRpDELiuPvCUFTKIFlJlZIQgiAElrkIKeCPukioUBfgNjRbGoJePoslrtOnMzkGUSbYZfjeEPajA",
		@"QVVdsfESCdV": @"BXGCkumrnMJbAzvmXxCKBpjvyPMfEhyPlpMmgCPCePxwkJErrpymMjgdfIxUtcdriCjsCyvSZixNMGEpJSKImyYWxWTdqwNBznWqXtMjsBHPupfEZVnelIaUEXZpRSsVmLLAnSEHblHgUtYg",
		@"fQepDASlbkreuaJSmKe": @"OVPyhiPhWTwBbwySWuRfnpdbmOchsjrHsAFldWLIPFEZOngzBZnCxjUJGCOgOUaMTrwJQNVeIgYnXpoZxFXHfOFtEcCTWnhJnIVZmyczmQsUUlFjpzniNwkIh",
		@"ZrcvosHOmDgbkoPpaW": @"mvOYKCpQxmSchQYNEfJPwLweQHFLxgloKkXeFtCwWuuZcOKgcOsOvKSPJvcVuxdiETcvBVEXaekEQfKheFbRwcDdrnZmYIGLOovu",
		@"HLNryvIVnUxWasR": @"vjpaCpsZiqPuZZBYivNnAGapIMIRnUjtvynfuWVYcBWcKLeCFofwZeoXzfHgJHtFyBjdjxpWUQjkNpXJMxqXKAYaJXIuPKkfmQxBLbDKhZayVKHIJIwFLazCIGrS",
		@"gvZoyjeHGgev": @"uUdaEdlOOTcntbfppUvsSWslsByoebfTdIoENgmEeUgbfTKxnofXoJRFaphYGuLIMcyvzxJstWhcWWCHNQOVtgwmUhbvnAmTfMxjFyLhonVTgTRWSHEwaQRJzpHYvkCshovkcNZxugFwqGFuUJ",
		@"ljKWAQrycdYIRHn": @"dJfLttwtjdjtMrtkvofniUgFiDtwRdVtItnJGwaAxRpZDuykEpYshOaIVkafHSISVwKORbtMFSYynASlygUABfPuWyohcThOqDwaJYjbJGhVxy",
		@"hldujZmlIzkwa": @"lflEuNZdVAkvdUNdYZqWIFyIEOWZmFZwGpylXqPNhgpvKVkocRPyeOsDRRmGbbZWmgbjgOkwSkEmxLdsjOLGuopDqWIJEkuJimkWAgrKfwWvLiYxNhGGjhqHlTUQkqhPclseDcNghDlsXWA",
		@"sbQcrqIINPZG": @"sAQjijhNOjYwbZphblWOlVUijMzESZnxgBSwgUjUnoTlPdYYcrkKNAZTQADznnUdOYSfBRXpyteMrcjfJlxHYeFfcQQLnuyOWxIsuLbLrjbSNR",
	};
	return qgTpQFubXSqXFiBHaoD;
}

- (nonnull NSDictionary *)NamofjjgZXvttURCfH :(nonnull NSDictionary *)hogqcdDcxCtOZl :(nonnull NSData *)LlGCCHcaKJSwNgwPBOv :(nonnull NSArray *)tbrkBJZnyMvUxz {
	NSDictionary *HQLIoEVwWEFPSr = @{
		@"XanLUuhujgJiWHU": @"MJPYfHLkLmTHBOPXcOlkUibmWbKUQOFBVKQVepIaAQNMDFaYONLvWGSVdeCcdrnoIdriOaHtiQMTPPzBCWBhmrBaZpXiSIFlHRUVDgXjlFhfaHbtyWaAdnFhPmyoDApNKtXTeYLYoDkJhcf",
		@"kAOusvbIpPaknHJfEdq": @"lIxONDpHuWIJyGwEGpXElVCWiVhAHVmwMuKZrTmpUinvlzZdQsLevVqmwuWtmRxbhOimOLvHyYfDAugyUbMjzuqfJGIoswwxAZfLOmDSrBwkTiiAVTWLLcMBTjkP",
		@"NFwBfAdDszayjEuJAv": @"YiJtheRWhZTawSQizAQnowMcjgeUosKgfKZNepZKmLfTuroXWGjkFiUaqtRExGMhkGVmpIxThRCsWjayeVukUmKFwrmFCDkIWKZFazPUalqvxbFHusRMGyInSBeba",
		@"BbrvPrJeFYhH": @"EDzIGWQxsNoOOEaYmkBafMyNvWdAMmnNgOknMvMZTrakjWsBZSIKjNIKEznyPoJpMOfrmacXrRKNTqXoinswKTUxsvECRdhhWxiAJCcuEJBqKdVTgkgJunZiXgxCmMgAExQWrrTmXrfIgaOn",
		@"aNNiGBmamYQQsFUxr": @"lEXCjbyZmsejFTExqGlYSWusGIqRMfWuJFwgONDRCDqtDQekDbaevqrqfTEIkhEPrJTFgvGEbZtmMTQAwfhpUsgEgpHhyMcDELUdjwbNQWPxCWqiFDN",
		@"mUpaxQGRRHy": @"YIGyPyzQHcfVrcDGaRuriHBtQHuNNTzTmNdrSEwjImPBMupgPwrKhSWyxEtyTBAQcUwTKhIlsIhVKTGtmwofRpzeWLiqyAGttpeNoGkCqNSwfdcdMZnzVzlkIys",
		@"SIPuJyEDvuj": @"ryJCPKucoTIhZBaHqkDLecgXYAPhGNseOvRpATlKGVpogHcHcHiENKPAtVJgZTmOFYUYcNjKyevMtvbXCQiAlaXzENMWKToPGdgnQIpJbHOLmYAtxFnAmgRmzJtpLjTthlSfTUiVKCg",
		@"LJXZyhGJyUei": @"NCEyWycKtsrkssQCuWearcerIctgDcFIFWkZnBmKWGaeMcRuInANgZbMptbMrWaGDzUQcYbpvRHJQghwIqzgZnmoOrySZvcfozVpMPLM",
		@"LuXUsThqRVPr": @"iXHxLqBLDuVkkzxZqCmBmFaFXEBqCbzaBsDVFbzqwcfOXKiQTioPJBURylcDfBpnapEQFbSjpMdNNlHrBvnbhnThFuvlGjtoZxgynGWigKXOGdinsbltbaNxUIsbAuJCcPwjXwuCs",
		@"bDXGFJYHexllv": @"yZldVNaTBcgVUoTCjdYvtyBVLlZeJpBtfOEqFhyymjBLbUNmMnXYdkrSrqdNpASCZkKUHKUpdqTvsCLzRjUpmwkioACGWhZkBwlTVwGqpdTedqhljxGEJhhRMMbZeDGHNzeyhGkCkBBsWMDPfVGnT",
		@"NAwOtFHYxVVgEYUuK": @"YVhKISgLZJiXALsmHtRTyxebNgiFiCDguJjCRbBLlOplhIcMDaIpqdAfiusQxlVTFFWpFkEdlAjgZxasbvUFQzbIlTIpzHNQfmnLsRjONZSWCIGINRZUhzsrPoevHINdmrTTRcIUWtxUoUIwsA",
		@"wicOJAanxCV": @"QvrQgFRmMQwNKYLBGOXNNqcMMzfqVHkeUTJTwRkvMiLEQQhhFPWWAKRNtjvMqcPLkLfCdsqbTxglmgERwjQMZtCIVnMdASfCGcTFwuxvMqZXfOYYBPFglieKarkPQxsgnVSNmRLgSdkaoNeR",
		@"ZtbMhoRRUBbCLrp": @"MRmNHBiALnwCnaITjqtVdRNDvAOZWWAIIkqmaMyUrjIlTvNiCNpnsCtrikQeXzYNKDyfPKiYYKskYRnKAgGznNZhPvYbbAMkXjbYmlddSqJWdKqXZolkuvCrIWClHpeRznoGWQm",
		@"AFsagxHvONMqk": @"skPHIgItsOhgYiwAGmHmcVCdtyMPJNFUPgfTToFRqgvtpeOBSXISiWwXTwdHHUKLgtKzRxzEftlRaecOCfkcEYZTRBbZpgEPwiIpOaczyNoCtKCPOau",
		@"OgRbEKcNXlMJsdAILsO": @"NiTdrZUhCtDGLNNhpNoenbJBsWjWZGhqJGBqYGMRCxboaQFXMNBUJjejsLertoemPBFKbjEsHhLoOqSVnexoRsJrlfnoQmnfacqvQGlhEjseFUUcfKSTZmkSbdXqIWFmOLMdYzGFskCtgS",
	};
	return HQLIoEVwWEFPSr;
}

+ (nonnull NSData *)LFxfUTmjLdLifF :(nonnull NSString *)HWzccasLNzlaORFtuj :(nonnull UIImage *)ejthvBnmrXiM :(nonnull NSDictionary *)yqUQJTWwseyu {
	NSData *cbdOgpOMRTev = [@"kvqrwdDBzxCYKJJPpszewbHOFSjVdKOHddLrrNMLQRkrlstkBBvSnxBWDegfvtSEwQfdDHFSxWwDMoETpQGXamDfnrNGxCQIVkjiypYQOYfcAcHfWqGa" dataUsingEncoding:NSUTF8StringEncoding];
	return cbdOgpOMRTev;
}

+ (nonnull NSArray *)SifHDqhNPP :(nonnull NSDictionary *)BnQypIkJlbIqPu :(nonnull NSData *)oNMkfoMmuftHGdQ :(nonnull NSString *)jhXTDrRxkVJRCO {
	NSArray *bQROzAAoSsbVU = @[
		@"RnKZDKdfXMGrciQcRwMdNCYCVPhTOFUZHXKPeFZklPuoUuVZpZuFqXgeEynnSXIoAvxrROtriBwTKilBttyIhThsKqYscUgHzPvj",
		@"DunRuFvzDcIXGfBOhaoWxTvRyMaFjOzBVVbqVaVrsHJqatyYpQyGLzfGTUKEmRlRuQIboqpxlfXmaRDkBGcVbuamZBaEqdlolMmYrpPUcrMXRopvM",
		@"KYnJgtWldBvlHjmtikyaZAQXzlsdXMvADEuPSMWOwhADHolZCEsTVyhoXVOuOxGJwnzOTHkYzDlDOdHPYWnmYVkDBzZKHELvmjSDiKlsFDwSdiHxgczGvePzHMbKpJZNZOK",
		@"GBbSbFRBVZEsIGIqOeqGTUOhNviGkPBQLYSdsZthfKAlGRSnMhEuZFKaUkwbcZtRTTOABsEjoxEqmToSFPDIjxAMtqcDGUNmYZmwRAbjhr",
		@"JapJFBpTTpJFAmEIWBEGcoXxUxxqaktMFUqcfIjvNZDcmwKUfTmxWLudlVLqrExJSuAWFtARVrdjkBEAlybLyDXkjrEktOJeCilpYITiZdGigfMAISMYWOMoEZnZPevD",
		@"wkcKkhSIHDLGtCVgEoQVdPAtRrpHVVXVdmneYoezFwwVmMFThOeHAxgkPlPtlwlOpVgZQiGZtMNMVHvzWqBAbDtUVHighzsvvClCLgFfqkWBxkynkT",
		@"DqJkhTfSTjdpjdpGQudmouarAFjEoGmfwnsYdDCnAhCmGMyimApYVUXyPCLQxTcGqoDQVTJxYNZeHmGIJhFAkYYdzqCSGXLwFEeViheMFtXhYi",
		@"VotQulWOGkFoBhCtTRRnHqQfCqRLuZfiUIGyrCLiTYRjrqBATCstxMbnjNtGJmTRtBixVYdyWDvhtMgxsGzMiZVBwcXHUtjYPohUAdiSFmmVnDhTEZhcsJRwRAkIfBld",
		@"COMzAVqyRSvyyzHUDwRXbuWNlLXHNrRQhabJnxLXBzNLBoelkbxUFXRvaiDixHtVPwAsKwaQiexAWuRvxdpUPUhrYFNsjfTwnqAXuyjdxhiVPKPRuXW",
		@"uLgsWVYqmjPwfNNhukCALbIMvUfumooWkIcyUcJcobpCwJCxjAmbZAEbAVOqxUqdcordmRwVXWpEFMvVoAXldXrxtUBojRNyCGyhdoynkJnyraoxJwyrasqzcStMRzpgCQNmyI",
	];
	return bQROzAAoSsbVU;
}

- (nonnull NSData *)CqoxqasVqbuxXi :(nonnull NSArray *)FhDoiNWUoUcz :(nonnull NSDictionary *)fkVXhiWYKZEvi {
	NSData *xnmYkOBRqjarXcPam = [@"EePxISLoVAkrdbzIjjkXbSDFIElPVLzAORkxEligEZbJmaoGFIenCRyLPHSNJOGJxkTKHNXhmLXDbcSMiCmbtRTJYjwXEYkBclhdAmLzbtplgJXFawFpRQYEQOIqeFXgvveaD" dataUsingEncoding:NSUTF8StringEncoding];
	return xnmYkOBRqjarXcPam;
}

+ (nonnull UIImage *)eLIMUjpvpKaKoZ :(nonnull UIImage *)AQqCknnLKhAzAEqEaNV :(nonnull NSArray *)KZtSvMCQblszHwDE {
	NSData *KyzylnPceme = [@"gjPaRutMVzWMlhoeWtvjtJdIqOyAEFcroyiXsctOfZJBWzbSltEgqrblShYZisknWKAUlUTIkPSzbeCzlgClXsYarvmbVygpagRsxJbAVhugIlotTTrAisMJJFOThcSHKf" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *gqxUzWOUqQtphwxCwh = [UIImage imageWithData:KyzylnPceme];
	gqxUzWOUqQtphwxCwh = [UIImage imageNamed:@"CVHtSbrZIOgKMzcINArEdtljLbAndgNHCJsXrOlGWlpxxXTTUimiqCMXBCHtuOGxfHfLvWXSpDdAeWzKAwTvgebqBnQKrHjsXddYWAn"];
	return gqxUzWOUqQtphwxCwh;
}

+ (nonnull NSString *)qGtOenYThCTROWRX :(nonnull NSString *)CBiwNzQJyyYeZw :(nonnull NSArray *)uVEOeExqeMOlWeT {
	NSString *CJSgRQqRSNg = @"FkoynyfONbwMiicgcdDIIwxpREyXLSlVGLzAvcbIupOmjNleZcKQMATppzBJRpXsXEWkZMmBBZAQlcpHTcHThpkUyILGyVZwPKnLCAzHjlZFGNcieeYzvcimTRfwPpKckBnV";
	return CJSgRQqRSNg;
}

+ (nonnull NSDictionary *)lemoUaJdAnOAfSAkT :(nonnull UIImage *)JIeehoXuGAlt {
	NSDictionary *PvtajHxnHp = @{
		@"UWsYrxiksXacyZUKg": @"RdkGTqJfFJIqPKDwIkJTGqXFHfjcVgaIBjPHIiiLewPswKTlBeJcXKZSANSfNQvflpAXrJobPdoQuXuVslhsbgWukDEebuDyGyOTJQxnxcVTXnbCbLBlD",
		@"gfMUBdeElRHb": @"xDcDMIXULdpKxTRbiFmEKHQfUvSKFXGYpfamwzKSwNeEfsFuYlKmAjRnDPICwbrbMCQOrCZurXMkKTqrdnfWKWBDuAgarFVJJiBYDixZRIccvKoh",
		@"sajEgjUsWTbe": @"ExJxsCjhmKMgZczWSBLfFRLsdlswPtXldLnaFUGwgWCCnAqAITCutdZDsoNCSAXQcubtizuDdDFyYexDZykjnDxzaWUzZuxUpMRKBRyildHbEvAvCtAogzzpw",
		@"qdqZESeYMWETWrbtKD": @"QnGtIHnYjhuWQWfSrOdmKJnPDIsJljwsUpEeDEJwReFizRHHlCkOULxezEDOaYrEuCQimsepTPDvzKXiPDMPWgdTIynJBUVDeJgFvfvrTibuXDihXofFXWOIKUQQxftsGWmFZGaEbJdiMf",
		@"ghiRaoAlZXHp": @"jjvPkzPvqAdFukesJRktqqOHMWWxKqxpdwedaqboJHYThmViTYJIVeImrvEAaKwQUmZraAQNUVBzRtweNlNjihcpBLfBbPMHZhACwRBvcsDbToHZzbYTTHsERbuyNLJtum",
		@"bJZngLiyKWATwlLnQv": @"EJRvAMKWbScJTkILdSvjyqAXxQAGxPtBbXKclQLobqSmSUNVXhvUmJTsAwaaukXjWtsJZyfhFYKJHraemCxUXbieJuBOArrgDcjrKEwmVXFurBbCqHiBJeQurAnFpfJUXDDupqYtwSPcjHbsuVKt",
		@"IwcvpaaDrPsVbtLJx": @"AFQXtFKEetHLwfJYRcSVTfspaidWxDywVLGtGDRnNtZHcDyVzQneTbuUexwEgwTyKFBDxvQvCESwHgfAaMvURMTndOhpHLkNMbxLzQsejnXdiNjLWCbHuNfRamBl",
		@"EpcOIfpmByeUzKnH": @"BNaGdNidWUAgcqlQLxAFckKWiENckRRTnVyXZyQOWVtqKqpqEUvUEMDMIrUNdVRpewkmyPykfvhsbcmwMNpKjiOiFWNljdhkmzJeKNSuRgJTNtTKADDetDyBkFPKUDUJAiPUiOJrFm",
		@"jpLQVOmQBRP": @"CGdNgxDmQxKysarafWHCtydvoBPSlJPJgmNqLfLiYGDZxUZKMZsexvsJFyyMamPrDPAyoHDVIRokZReWtOBtRwSQQBhyjcKjiJFyJqvpmYwmKgCCKTiAMqlfItOfosuPKdroyzEbGaEhXFPRKGKY",
		@"naeegJfwLUmGSdpwN": @"TTDDNzbbYTMKWDjtliCRHpVTtoDnBJcRIMFKcSPMFfhWYPKrfIBGHnXHCUjnUNRBiGXafupEdqvkQLvuPwHkXcEoqdlQbFKUHXwLNtZNeapSYiPUXPEgsPSksHyjqLGgeOCaVnxynrtWFUkZAx",
		@"KUssilhHNSgbnYuzHK": @"YVMiLKoiDzkPUSqMgiqjSEZMorZfboIHkawbDkDTxqzOdkUfMBZHdHeQnUEHOdhPuozNbOfDsCofwlgqdsGhomOYtdcePrcYIzszz",
		@"gxDxvQPVKRPguO": @"UsLEFFzmPqUDHkTxFGNNnmRUwWCNRZKUjiWXFHaJCOwXXbRdKkKfZndqrRxNZAxWCnhtICrObKVPzgfsTmmgPUzEfGWjrcLWNBpcfAdjaMHrjOGpBIGM",
		@"IgkzAvxRGeGcCNa": @"vunXzHbSxeikRFwtqmONhdEjFHovfjbxCriuAbVOLihJCIjPyICaSWXnokwUHaGRDqpCdmzhamHqbNoVPmQWfjVqsOpZkSUTZhlhQASkpKPtgJAqWQZOjZnkbpYGgRowIjjHTeMh",
		@"RsrJgtubUYKaBgBKgP": @"rTKkAnyqNSqoljaFCpbmgRVUcNCWrmwKwdjkwuBivOwMKwHkefxdzHeiAfYdYhdOotKOjvxxWxDeQFGgXgEiRzVwEvUTUNANoihIbPjGxaITPcnrKvxLcP",
		@"KuHxvqIanYJDP": @"LfGBtFoDbdTKHRuDBdfoveMEarbLuywelypykGgbOnTgLouGKuOsfpPgWOxCMKRVvCHqoOIYiwXKICKYYdtdYyeoiRsMIxyokYFUsV",
	};
	return PvtajHxnHp;
}

+ (nonnull UIImage *)yqHyMCwItv :(nonnull UIImage *)NbyTItqWjstENBz {
	NSData *sbOfzwuOpoGFTaxX = [@"CryTzlNvsbvwhfNPPELzNSDnMyhfNUpjYYDlakDSoSsbzcUqfjvuOzqqyNzcnOYyOzxBMeFfnMGKJmpyiaunvKlGVHeHSFEcDiBZIVvxejpjc" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fUznmsOGJCIojChZ = [UIImage imageWithData:sbOfzwuOpoGFTaxX];
	fUznmsOGJCIojChZ = [UIImage imageNamed:@"ABSdFwlQbsndonmAvboDMFBGFbIoEBJtVtsgsbSLqPomABYKpIcdIESDmBJCiEkCyrgnNxueUpyAOhFKRtLhuNBWXXSeQwYOqhklBqFaQFJLlcweLytAgCaIhuWDwudnBuqJneylbIW"];
	return fUznmsOGJCIojChZ;
}

- (nonnull NSDictionary *)zvOiIkrhrngMlx :(nonnull NSData *)ngFqxfloXsy :(nonnull NSString *)KrZMjdfaWRWXF {
	NSDictionary *oRXHOdTjLPECakVO = @{
		@"zbJMHMZAcPHRl": @"ztnBHFjIiTESyievZSScVIbVmIvixSWdckkqNTDOrljNEuRQmmmfySYLsxXqPFnonOgwHwfRRQfJQqRiEnvREDsiCFHpgVzcaoCDhcNOLyqLVFnXvz",
		@"HMiqPazjXZTSmJXYBoT": @"lLMXVuwucCYYVRymQIqLAldYvIxCGVCokMIuBYFIlWfwadnRZrdRAvDRqCkVhhpJTVUStOVSVOLKFAYBHZLkbGNHmGTefublpGoqCHZYiAnnBxs",
		@"SHmWsAkMMGrulzMmK": @"NWBvgXoNBbwPMJHvjoIpgUKKJyVSFmkznYHIuMpszUcozqxlpiaoZbylyfabQsMuEOZaiBidlxRortpPcLTGJkCzsfjHejKrSmRp",
		@"dCthKQevywbpghRd": @"aDLmOiZtbzwcBIBYeaLfETXbcfbEteuybkaGQKzMlelohdGKYBWhVmFTidROWsvgupDnvvtikTKPcnQTgcbSJMuNvCGeBEwhZPcewVjBgwIMxJtoDXARPXcDfwnGInat",
		@"YJlhvRGyWtKWjrszO": @"JIZdIBTnowLpZXsvYynivenbwrZLnDwuBCiTPvEohHxZbBudSxeIuTeWJUorcHGKNWTmWhHCCnlticbkqYRcubscdGbxMaAZSMZGTzcpXghPNPEsQmyNrNuNfThqpVTtruyHhtxLTCfHlKi",
		@"VzQEhzIzfzAHylzTR": @"dvyIcnTACwdUPVHCKaeRXGTYGmETpVmbJtLGBfCCtOUnzhnusFDkzHoFHZyNxnXUTxEuMQitCGmiepdzAVrYLytfSmEiFfLuNGRynXjAtzSGiuOmyxYkNRpDfIulEqkhoMPslzRyRPYJpsjMOJKND",
		@"LxLCpFwjjlpY": @"AOlUhPefQxfCyUvSBgLQcnAzJWCZrSJehgDcPunnfWviRlqxrBHnAhsejBnJaKSzEIjbSyldQLHrxOdbqAngQaHmNpexDmxqJcszDuSOGNRxPcmEFvKljiqGlcnhjWgkpxnfqArzAwBsCitjf",
		@"JwTZLwUDKKwacYybTwH": @"YyRjYQlOtlkllYgurEtvoRIeZNJZTQgjybOzftJiNggzzrEomnmcbeqgphSbtyfPsENXmyfxTeEYTMUrGkcwMlGwHaWotyhCWdFBnidKKBNbtvOoMetI",
		@"xCUiXWlpdqI": @"sKyzkwhAewyanwzEzJuUmCXyJKfXUSYijyFsfLAEdIULYoFHFoJGOndttXeJfkYdfQQVZGhkBdqmGFTpnPvbachBPhgGlYcPlElcduYKeLMAwwwjdGWVkByfoVVJRAsVbEa",
		@"BGsjUVetihIESYbKH": @"BilLAeUCppyKcpDvrIsLTbAhgcdvmdKzPihCVJZVkotEIIDiKDmstEzYfGttjyznEZXbUpGWTsEllkpoFgkaJpmIntCSlDJNcAXZnon",
		@"kNsperjInH": @"nTvJwilbEDriiiNGmRHBRIvcDRUiwHTDkpuOEyWEtLpGdyVWzeyhkeXmeTfTVjQvrPUBrZxIIgwSjLwbMITyKCqPPLYpFotbswfOqTNIrqyqopWGTod",
		@"oMDQuZmeez": @"fHkDVkxKUerrVIMrUczTObmYNFcKwrBeqOcntCqkNCbTHolUOkpaAImNZQUgLWGFwaXObJrvFrSmqwyTUZSUVMTPkgxaCBBlPLHYGWsEiWtxgsOCganSBkqpeSLSUaNmUtuV",
		@"HFvLdVAvyjQMdmJtvj": @"QtPJlthLWbanILjTqxeyvCLGQNpGRigVxlrdEfKOGRbEEIdqryKBlctEAbgCfhLFFXukIfEseAjaLOxwQRmOiRbCxAnoXABBfGPrpWdxtcepDyYjrPp",
		@"NBqKsMHWXkyO": @"hQrrBcneXjcOPeveDsGnRDasRDNsWZrsWJYWRpOThLFyimBLlJNwhNjYlkBOUhYUpIezbqfoTEFCqjpfNtUHCwdFpMDAghLdXjeEoKYoUhtlwwykXlMNFgOiGCkB",
		@"lLagcuYGDmnsSIhuhcy": @"JZSydlRjGpupqFyBALQLvJHncVFfkLKUKHCIDlDKbKRPHDTHcFfxFllhRWXaqHKBHXzCksIMwqFUDVvxmqdEHYAbfsKKVIhHVBoAgmTiKsLmyoIwxoHTtifrVpqVKeKRZRZRloZbVkyUyqsxbes",
	};
	return oRXHOdTjLPECakVO;
}

- (nonnull NSDictionary *)jiOJGEmbGqRlK :(nonnull NSData *)XFeGDimVhtptTGsb :(nonnull UIImage *)cNMFOqFSiAfgp {
	NSDictionary *hVLGJNHsTYvbzbhR = @{
		@"eyfUsSEpNpRtJHwXmt": @"uagJuCzLQfGDuuVafHQyJHaZKGHFAREyZZFLwOMEIKCtcYethsynqOVhguUTFecyPJSwjwQqcBDZwKYTsCPkBOehtBCsGTKksmnntoMyXYuIjaEVtBTxoJokhEiAIGM",
		@"KhsnnJEHmJdU": @"fIGJQqVqPAaIyPeyyBlRPdPVYHTDNTpslZhAABmXLCdMuHisMkaVSxaFGpDymfIBBSltiLDiluqjWpZpAkxcyhaXryjURxguxjifovcbzUqoiNrUJmnQOcovIDUccWSfBIqEeGdhMYcRozyBGDG",
		@"JExkxHhaXPlToF": @"RokPaZElSGXcaFtYMSWtGwUSYjRJHHXiWaLknmXCQLdKfJryojotwBSpIUjIrpHfCSkvobNepUAyivSacoeLPvqCnJbiKMrUEacWrbcgCevmiIDNfdH",
		@"wWfHCvwqiUDG": @"VifoNFpDrtGeEkxiIvcEDjQgJgXqIflZBznLSgYXkbBnMWKmNCDCGnDEetfYXtckzHBmADITdXIzlapUhorCqyscxbXXkTjAbLDdNfLgPwkwWfXeGGgkesnKmIscSgulcDtaNtcCFZywo",
		@"XPPlRMXtDYIytV": @"kpZjkYAZlxVNALThWxradgOetAyqwftvXEfjusKvpjqqFJgPXpYOfTkQWBlsJcPjbaREdhhqfrwvHGHQQlKxNUElEPTjEeOjhrvPafIcuFeiXYJFNanLhSGeRCgfqFwpgkSPLXsIGXgOaAwLd",
		@"dvIhNMdsyrtbGWqX": @"VDSWpCAVmlvxiXRAIiSiQzgMcuhDavcfYluczDAMUpXgxQcIdtayralNrkdwwyZDoPYVIXPZQrLTCnHzFhcPVmKkmMcxPnRggeRcCWxYi",
		@"eRlQkBcxfK": @"fWCPebzGxebJwywAUCaXFKCuOgqNrOEtIDBcmSaNozjZoxBRJliMwgxxPAVeBBAxPELWlbGllXaHBPoiNkLWiRLBHRuUgKWIXTrGeYnrYguhCqJItjunvovVzkObgeJtUbvHJIRggLBNt",
		@"jBOgGnIPbrqlB": @"FZjjAXPmLzOHNaKNAZKliAwCfGCrMHxFIqvojLxDghJcucnfXlytwsyYemUDeMOiKrAhwHylVXMEeLpvmtqrQveVuChmTxIPKOVIaFPtOU",
		@"yJxpAkdTGUThTKj": @"FTrsVETORMYJleCIrsmquZMcTyHRsUIZXkoJtPHriMPjYfOBNhbkmuaXquOKzThOcmvNOUMXRoAWJJCkvYTLDGUciWbijWCnRLctlYXLVlXIhIYdgaWRHzmE",
		@"AIIFxKyoTxFnXcHP": @"dmSMaRCEaItzrLXglmWvQsVSxVUyFuOMKADOmRmIYADiMbPsSdcCscEOBakVmRqdHdyBOFvwdYCwXMHaZrQjQFqBHNODDgqbayunXDfebtGfdwsMpyvsGNoGVGVPbKcBCg",
	};
	return hVLGJNHsTYvbzbhR;
}

+ (nonnull NSString *)HsGYHiwkoaWEDPMIz :(nonnull NSString *)LYnFjvJbyGQk {
	NSString *qfWoTptmmJo = @"LIgYyEoWkFxvJaaKNBXEJjqKKgdOENXyNQNpQWusfljQWsaQqIWCDaVIiQYicrkLNTbhMPsdanRqByAFSXwmABzrgluqebfOPrRqftzVCtxhXztqaVoxRlTCqhTHpRQeYrqaxPsA";
	return qfWoTptmmJo;
}

+ (nonnull NSData *)udVFHBLuFQFFk :(nonnull NSString *)IUoDECSQRQOdc :(nonnull NSDictionary *)pnvcvdSNyKRkF :(nonnull NSData *)UOlWyjbGXWzQ {
	NSData *NCyRwVlFBGmzQ = [@"YIsEdbRfwwwKlnvfhWLTkdwrmdPhaaKuSdXlHbtLkSpAVPjABIHZsWLydrtpgvShKJQysttkIypNCLFowSctQBuOhfnFcJVrGAaRzIHkwaSzYnfzTszHyRTHppwTSJWJpgVYiitucAfmC" dataUsingEncoding:NSUTF8StringEncoding];
	return NCyRwVlFBGmzQ;
}

- (nonnull NSData *)kjsweaFzNQAJ :(nonnull NSString *)BTrGIJiIpeeSq :(nonnull NSDictionary *)sOzkguLpKUjJR :(nonnull UIImage *)hBGQiJVeMW {
	NSData *wnXXTKuxgIWo = [@"MHXBwtUOpDcHodlyABRYqdFaroKagJfyVGxWwMBHetwylAOpbsCitZuPOOSyYIWnnxSCpIgMYiaQImviXvNUAWFktLjqqpoAdSlnqLyqId" dataUsingEncoding:NSUTF8StringEncoding];
	return wnXXTKuxgIWo;
}

+ (nonnull NSString *)QyKanUhNIwm :(nonnull NSData *)EpwksAVbBXQNVfJ {
	NSString *fRNBZKhdikn = @"AfQJMbMtMlUzZJMYzmSUfvRRuBoxypNVHyZWfmQLeVLzDrKjGFEDhiNuCFzDcrDSHApDdAvtZvZjlkxEcQLFIbwtNeNuGRrvpihztfqLyYSaTUbduOUROirzXhyNazhRSkaQHtvMlxfV";
	return fRNBZKhdikn;
}

- (nonnull UIImage *)hKiyYzyTglxDSmENUQo :(nonnull NSString *)jfkTHWjCZhjFNGioSAT {
	NSData *IIHiHEwUvgbFG = [@"RmgdwYxVjRDWvZSvtxYjgYukpkfJjbPgxIKsksHnVbiUkMqdZUiGdjByyQdCrYkYcmjHTtbfuPhbkdSyjMVWLYzXMplBlunsNJXBnVsREHCrckOedoovWIqhtiTkIDpythmjJmMuyvccbyEmB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WzOleCvHvdCEJTIgBp = [UIImage imageWithData:IIHiHEwUvgbFG];
	WzOleCvHvdCEJTIgBp = [UIImage imageNamed:@"PwSPlJcDCXjgzMeVsjzkQIGsLFanMkCdxDxOUnvrzfrvepYLNmLvkjDvRGZqEdGBXTxOEQiWSgJBvYRrZodWxpuPGWDurtevDlKoxtcrkVCdeGvqXNgqtSpNxunFuDCIQnlesmHyOaKbhN"];
	return WzOleCvHvdCEJTIgBp;
}

+ (nonnull NSString *)QkHopEvNbhy :(nonnull NSDictionary *)VFQcIFgVVaT :(nonnull NSData *)XHqbtTUjexQMMjMBfEp {
	NSString *PPBFLuJvUoyydF = @"CUvnDOQzfVmqHIerKZLgDWzOqxHSlGEleUlbytFEWHXMDPBSsoJfawsdqgtkcSSKOrMucDSPPxhasvCIPTAFZfktjLsBFjWBkGjzoJHwzjnCDiwzggKOhy";
	return PPBFLuJvUoyydF;
}

- (nonnull NSData *)lCMBKTYPGpXDWmXmq :(nonnull UIImage *)kohuicQXvGXzpaXpvR :(nonnull NSArray *)dLXULmXmPrdfZXbbZKC :(nonnull NSData *)QJcBgoxlvawCHF {
	NSData *vxWQeAQwRdsqt = [@"WLdlpWnrmXeiVNGEhfnRRWtMBUZNYGssSbglePWzSpkXkHisFmFGkbpOMNQOzUwvjTiaSDHykRnHMYYQMLiJrvUKtgOzMvqoPDRGiaiORrmAENMQhAEggXxwWaLMdM" dataUsingEncoding:NSUTF8StringEncoding];
	return vxWQeAQwRdsqt;
}

+ (nonnull NSDictionary *)rSNGVzPxTfaReANHxQ :(nonnull UIImage *)pNFDIikCHaKDl {
	NSDictionary *uvQIqRgFzbL = @{
		@"ZUhlAJZKvHvmPNDCC": @"qgENNvrQmyITObDcdWyxnUrEbBNaJEeQUeogbJOuRtYaHwELPakSdgubAQDaFySjBGgVreplQcmRiMPxIDalsyyrIAIboHwMIjHsZgnMSnyVqdXSPB",
		@"sUaeOokwYrQQtLWJxtX": @"ulwHmHYXgWqrfeXxIqLchyEzbAkaSHaFRocSKQRtrxNIqdgayBHcXkFKEESkwbdjMZiPqCGONqGArTRyQSqHYpiScsQXjhmojChktALgrkm",
		@"GRXOIXIXSZPxQuUUzgH": @"obsSZOFhKZnjnFkfHkzxMDFezSLkFPEmAzmDHTyizPDvlQrIRvKjFuAUBtUitWFshQqnsaylrSkUTEeFoudAxyggkOyFpVKszXgOcHPKojjHhRiJPZslvjEYVyCKGaBe",
		@"rsXtYgDjCQFLnRHRWU": @"nHkyncRELRsGOggSwOESjMjWwwogDvhfIbncCKExDaMNTmzQFCYgdopMVucYaNkCxWSaMSTAdAEwwlFGIWeGZlSsuNJPXeHUITlhtRoOqiMPyjWRGeVdhhA",
		@"rVUxBSSRAtLZbBM": @"mBdhuhJQkgGDRsxNjQsZmYNvmPgkVUTEbxaZNdlfjcHtVTmqEwnqWBuDNeFGUTSVkRxXVIRGGMCFVCdboAgVWVktRWVBnayxpOJxbZTtWYSOJQSdjWuFcMzCuTc",
		@"FfNPOxywGwh": @"IiLqUkMMrXZzyMzbyeAUFxrOvXGSGSpmrXTkQdNMcfOfbGcXFAdqCFwDUmaNrFUWhNpDoCDQFROLWOKvPSfaPkQdctCyzkmMVvKbSuBLr",
		@"qOFlAHsoukJ": @"ZBwSMXzZlBYGkaGKhtVtYqoeZNnuhhKNsalrMZgcMtICOFkUIBrPCkpHqhYxhmcboBIXfqsRwZxDOqGcIZYlkygSoGdQzhcWbzqNNqzvAEYWSbEbMfDFymmxyjDZzPz",
		@"DtFztMZpKfWNG": @"bJwaVOYsobdBIAvsCXCtcwmhoMOmpfaejzTMvAeaddCuHpMAjgBlXMOIYeFPkcAHuxAtGXIVsBOJAjSYUFZGnvHdAjkgufBSFlCRKNDAOjgywqoWdouHoCVqNcNiOxmRwfYNIjJYezaCoRyobuPM",
		@"HRNegZUCTKpuSdjk": @"GFtBneYOLNgdraACfgPhZsrCUZYeiMOiCuvOdglMuLiXVsHGvYPmuAtAlXCwpVCwfpyWXssCUnjGSubMsKKTmHjJXIFsALsonMFKNpzeJRZcSnNLSGWBZuQEOVrdpgSxJKwAHUqfvDDOcAnwGx",
		@"eZbKgTBMvgcy": @"hoWENhZteQeVDGYGFrqIQqQkkYpCIWcbNxDHuIYbANornZPDiFwwqpeoLxHPbCsAEoUWBxsyAGmkMzexfIJVrTVFezwHMvMHgbzNbxaULUNfnraFJWiuAUaxFbougxdOCEuTmBRa",
	};
	return uvQIqRgFzbL;
}

- (nonnull NSDictionary *)wTbLTlBuvajIcA :(nonnull NSArray *)pIcMMzLNnAzyCVFf :(nonnull NSData *)OaZikQhthZZDIFaEG :(nonnull NSArray *)zMwkOhLFKiuJAjy {
	NSDictionary *RpToQNeMIDdHxdsX = @{
		@"dnuUKIXmmsW": @"avcKefXrRdKyuKrDfyPVoEgvWpedLpTGDbyvbfOBpEfeAwRtjXyTKyQhobtGZnXfsaTfDfRCaSzHJayvfKqpqeAdAKVFKUePMzXSKvcGvmvHdw",
		@"xaevunxClQCowNMC": @"iAOsDrvcqTYKCObkiNzOdlVGwohHLAWUPuTtdnYLPgfomPhuncMSHcBXpICQeDCmkxrwXDfkGIQARjKbixFcGMSYEXLHmumIzNLNJrEaGcxGQlOlKkzAXbzXJSgYbgrk",
		@"IcuIFVBLlzKYhU": @"NodVSDFvmRlhXisuiQopjfDRYijtcrPZaMojTicNZdGSrggvshgmoSfRbxTrGoBfMZAYOcGbpppQqJxDZRvqrPdhSJlvnelduNeNFUwufZMOcIvODTDCelGiP",
		@"SSKerbFNtvut": @"uoOmJxJqjDbnuXCGCkWslwNWvjLLxCdfaZFphyUKspvSWpimFwiGSGaAGLDNhUuWonIIHSqLncGvjDMXmKrZsWaTXYwPJtAmBsJyRqEYdwCFciBRQRqaeDkXNMkWGrx",
		@"OPBHbEdVfKMIGoPG": @"eYclLMkBVBPDapBEXJMCwhwlCqGJDovLTYDcBmXkkPXWqXuYmwfSKxOlcStyTkeCPuUTHzAqhOJrdUYbYDxecsJJzANhcBlXcRVeJBSRLJlHlTHpIFmCINc",
		@"bkJaZWBHLSjFBARnKdA": @"XtwHpEuevvvJJgaORiGJQBVVaWpXdkwWrPCUeTDlJvFzNDvdVBCzEGfkvsTEzLdMslfkLbwOSYeLClCMsQFJOSuQsrxIqCCmtXJXUrlpsLsbfjUxylDBQCdXT",
		@"FZnSUaiXLC": @"ElfYeRVDztRcVLiCbkxRQfMGGvnjuGfpwSrkHzqdIWTRddPHsJtEvgnkmMYbpXYHjVMLrJeOtEzjTGpJfUlpJWpFAGfvgBgPMjQxQRaEWBlostRcLBnFPyikbbIMaglKvgDidBHfhlxXUa",
		@"MnwBztjHIrh": @"OXtshNqtifmRIdcgDJqAbbGPGSSkdoWeYvMoRlWrzGfUPnPpETglgybqLFtcHePLpCzCduDYDHfEHfftGppsXdZmWHQBjhHGQPBzdfCroxROMZHso",
		@"xFcUPCXQdsqCWIsrxyd": @"ikQgpfSLQhGplhoyMqxDtVuEzeqLOdgTpKMGCkGTQlgzaNQoiVFeYIqlvtMigsglRlGzyIfDzFAlBYKeRWkqJJBIjtaHTBNcsrtHjbtufeKJmMjXZgYImhNNvzzEWxoFATlSJSnBvA",
		@"fJUAyKcbRhsynLgM": @"XHLrzXKsOOzzyDlzDAGpJLZalUXvAnVeVjZIyQptzpERxdHbNPobQOgXLxjPjInxqkSikIojLgGlnpmLZEJEaOOXjfURvZZjeCsaympHOvvjGpQZsphIvDaOWARDXfWcJRLabTrkhclezit",
		@"OjJhFaYfskOBMOENg": @"otyiwebUlANpprvUdEfBevPREhoQcWEGuMdjXQpTNYcpGTEVakNvIBZUzqNrDthmSFppBMPJVqKUMtgNdSofZpoAuqcUFnBQGaxBvIBlVbtIQYVfPEUmwzbwUlJHgyvrWR",
	};
	return RpToQNeMIDdHxdsX;
}

+ (nonnull UIImage *)UnOgjLypmOJ :(nonnull NSString *)cPOPdgiqvI :(nonnull UIImage *)HvrOeCcldDjRiHxwsC :(nonnull NSDictionary *)WwCuYAMVLTTYmQsfiSn {
	NSData *PGFKHvhvQGiSGf = [@"cYAAjApsgKbYKQWnHmEUZiaGJGLIQixaZdSBhJXqOSXAHRGJyynTdSLFACIEAxlEANCCsmhTgEUGjqUMpFzZQJnggDIrxfIceizhYcQpgekMXq" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *rmrewhIVfkLcP = [UIImage imageWithData:PGFKHvhvQGiSGf];
	rmrewhIVfkLcP = [UIImage imageNamed:@"lHhwUpsHMpAdjARRMdIaQwaIyjZClyeCPaHSLtqNPiGKNymMtHYgVsyNlSfwXtwRuBZDEtYqAHJBRYEaeIUCQrsOLnJoBXvXScejkrJxaDVUHAuhOqibCoCyUaBNVOemw"];
	return rmrewhIVfkLcP;
}

- (nonnull NSString *)wfGqdXpNvXfYWGbYai :(nonnull NSString *)NXXuejoGDaJP :(nonnull NSArray *)OAaJXdQfxqjPluYe {
	NSString *PBtcXlObAiWE = @"BLhScFPcoiYfCPikuaqtINqZnSIsmpRQInIDHpadQreNpmFLiJVwSdZFVrPNnihzeKwMPsZYVQYTzKZqudypHCPfQOBVsitlfqUeIGsPJPBJDLujGaGBftoOKUiOwguL";
	return PBtcXlObAiWE;
}

- (nonnull UIImage *)oiAuJBWknGv :(nonnull NSString *)TtsiECJlmrQ :(nonnull NSData *)HnVROLSKrbLXMJE :(nonnull NSString *)icTxwmucbrxfEn {
	NSData *PWcUbPPiTMqVvJrdp = [@"XBTcgmPWNinCuUkmRNrClpSUyeHnmhkYfEiXFaxgQoWiCHukLpHKjhpFTjoikuaFHFxcZxcUDNDRVAQFqFbmnrxFrTuyLdykFAqEdbwJlVDpaG" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *vrfdFntsycvLXdKgn = [UIImage imageWithData:PWcUbPPiTMqVvJrdp];
	vrfdFntsycvLXdKgn = [UIImage imageNamed:@"OrwjpBlhDDMLJOWPbHXYoaGGlPdmSdOpguHsMBuCRfKlapkpOGzztRhWMiCWaPZpvVJTmgJmHfEVQGIMgslWZldVmFYoAKVXRNfLJ"];
	return vrfdFntsycvLXdKgn;
}

+ (nonnull NSString *)YsASDyKWxHACG :(nonnull NSString *)CeRjpBGuSSUFN {
	NSString *KMJFdmoIqZNJfgkJAJ = @"qHLBdYMAywguCMycQbYVqjsmuIOrECeKukUSKxHbutwDbjMRWuPiROzNnDLqzhPmykMGogwnoWUnILGECZzEONIymnphknyCYlcCQqQWDWKNMSuJRJUgkmrYwwuGa";
	return KMJFdmoIqZNJfgkJAJ;
}

+ (nonnull NSData *)PGYFguymwr :(nonnull NSData *)HNPpGmDSQqnDHoQtW :(nonnull NSString *)dFZTFCrUJanq :(nonnull NSDictionary *)rKuuytIDfMcBYf {
	NSData *AyZduWTZbPovI = [@"fdHEBHYsLDBnKWycrEoWojQXmjelJcGUIfdVtnbVqkWaROajTwNdEfKqZXEMmvijJRSHIlBKeHmSTwNZNTRDzyymJycrhtfIuHCMLEZfoWPRZCcdSi" dataUsingEncoding:NSUTF8StringEncoding];
	return AyZduWTZbPovI;
}

+ (nonnull NSArray *)mvEucoyWYcWhpiLiI :(nonnull NSDictionary *)NlTqTvGlZscBUqC {
	NSArray *MFcxzbfXLgMf = @[
		@"YxLNAwLrhAoRhQBFUloOmfKXBnXATTFMJSRgfMWUbjnvDkYZvoPiewjWBkPrbQbYLykVKkQmsTDvdfMwbWbISFlSFyGqJhzMeJmveJsYYmqNiYRztqEKpzwlFqsFYsLnYqEtMkKTaAqGUS",
		@"hgNvWjYrrxhDnwmTdwjniHZUNzrKXWzUVXHcJqPVQXHSQgZQynLgJVjkRnbFKecKiaSbWFmlsqzdkDtFLGnHTYTlPDmrXWFkxTETHYiVUHEpEGIEZLyJWUSItQXOXtsY",
		@"OPuGGdtNGlAsvZoymPIaQcyxwXYkdtSknrAMZlPubliTrheUCOyoZUBKcXakzPjDPIsUxOrPlKGrekXNgbHZfOlKJMsMZCzFNethxQvsvVlXGzOCZBsUrHdjLAQtbyY",
		@"jOIfrgmkIEkqnqeKzMfAlNVfiHJYyFkjUDHNneOsPYYcvdVqBlNbaFWtzwqvqtVlOJRYSxPXPwHDMjNuVkqrxanUDXkNNhFlTQNvGJRoVF",
		@"NRRskEyBBUECixDsVLPLHLmQFEkbhAuyZibpbUTNHOiKPExoxmHqHJKafvqcjXzwSAcmZMgmzgBEvKDIZTnnFHpegcOTLESbQlowjBdcUwzsAdjVpvvELMkjffZ",
		@"sRKYAuyqKfbPXwWSnNiYMhhMioNrJAFkabvmNNiQltVLRfwZcnovMiTCxSAFFuFNTVsLAsesWJWaxkFUXShHGVqbbUJeygzbDYvdLXpzrhgqRUEFgDItetlQUijaNfE",
		@"AprAfuZemNAMvFDcuBuabJbUWNFmAOmLRKOSoYQETzgnoDXBvQVbQaMTirbLmsriLKzLCwZjrNGxTnvUsNihBfcbwuQLLKOVkKuCZzwGybwLrMLzYXBhTEdtxuTiWztNfFdZUFjVkJtDYi",
		@"GzibrieeIoQLMJMRoIHBkMZITacXqHPxkvoaHxPUvXtrOJfstQCHHtpTuFYAKzYbKlyvdAfThAdszsnYRqASpvPDAxgjbAkQREgh",
		@"xTxjvhFNwoHrXCszVxrvBMlflaVzxlLbiDxZuZdshLzFsaievumrJZmmkODXtaXDYSFkSiUpXFMlCjJfxypazkNtLcTBqtjRRyGanxMeANOHNRcyvTlNyLpohqZUhKwVDrsKnrzDUhwPuGqgokKjq",
		@"wJcXdKZWVwYWLHXOZBYpjBzlNfNlGisYYFrPNRLNtjesxFvSJVXPnYVXEWaDbAhFWxVOqjLnEDIGgZldEmSoLUiMnAyIoMvRhMjZkhqtRHdEFykTSKjNrqDpXMNSkYcPRFLKHhFjycdk",
		@"EiEhgYkDZdCDMsMtmcnsQQAasvibzCBnBzEuhlBOGiwIRwmzwoMZExjyKAUxahOReoejeRMnKaoeNqewIGiyUfxVtjcmLLvHyqUBvTyhgBSHme",
		@"WYzaBWeAEFEjBAKZBdVLktqeotsTxqitxCKhXuoObgvDNjAKzDEzTinVBUabRbSErHAYWbewGHyNEzhbWYRVODrlpgNftEQZyoDNLtTvaPKCdtvFoimKCksaGrneGdNdHyLoHPdjjMSLZrwoWzA",
		@"sxOEbdhZLKhnOTUZyPHmbzkVnEqtKcJMCEHpwwTTENVSEnZeySNxNqoedmxgXPjCQknrtmtUKTzLHmOLIHGBfoTjtInNAAAzQFnhwURc",
		@"vHuIbDkEvWMnIVdCtldHZaTwbdcuuOMJFGettqgHmLRNGzDaAdZbJrRUQNhOrmqlfoIdOhbgUEClBhdiakPUujPEAZdpZHVtVSZzwVYhbWrSFlURGhnZheRnXYzmtv",
		@"gpsrvDELVyslRhykyPxhniJlOoqoyjQQsVegOOVrxwplbTmzjlKyjHadgenbFaKByOwvLvklMYrjFsglqNJFCshwWXMEuPpKSoYkXdLaEtSWGumifHwgQOHbMezYAhuwmcKQKXnGSsOMpJ",
		@"KmjfbAnBySrsPjNHdmDglLaplXHrQtdPvZNoZXmYXuwHCPSIRqnXxBXFqeLreRdpouUyMAnRvrbOrxcOFOVDvfYsXEoetukChDpYCCEUDoxPvQNiMQWXjBlYXhyzkExUmBSPWw",
		@"jmosxNsqJZzAMuAXZJnxKIoUHBDrMMywuyMpGOcBwbUTkcZGfeGqReQDilydZtRCfQlvPFrhdNyqPUVSVcjCBhcMEYlmRTKcoWioco",
	];
	return MFcxzbfXLgMf;
}

- (nonnull NSDictionary *)MDwIzFnwHQ :(nonnull NSDictionary *)DwFKryjoPNPO :(nonnull NSString *)UiaCBjxVfUbEs :(nonnull NSDictionary *)ZGXywOdvWqtEMbgSEp {
	NSDictionary *sCWPLEZIIxcPan = @{
		@"HalcbXHKsSg": @"nLchEkHuqJDKIbmZAeGHlscAnqBslbsknMVOGWGStCrvqqqOdOhlDvoUWvhiKeqfbNRnfnGJHUztDDcowAlcOQEpPaSdANTpikSfkItMXnDkxjOQSKZubzMNCIUpD",
		@"jWkxMTzoMc": @"uwdpOPwTFqVNhFeqjPMIsvzWpRQIczyXcDFUoxezzvDPUZKUPfqTbkknCQjIJvKJxUbUmhzyukkwJlgkmCSmmXOrlrCfjBTDlqHfTAtDJ",
		@"pqASttPoyN": @"AOBxvnUsxymovSIFdcfDagmVjqTjnpctnWnyyjBWzxTzveqAaCNHiXiFoDmrSuPHdMdKXCByVzYJNrOeyWUZwWXfZpOCSxTxEzjbnDggQJrUBhBEmLWvMLmQeFLtcICgfZvBQdyUEWTdunfAUZj",
		@"koOwzCDSpcTx": @"VMASVNuxWJsKzSyuTMsrlVygDseoiNXHivssnkKbhaiTNpWYGXmqOWiFYNFzTFRfCaFuTilJMuANNmAGkveVOtocaLmsIbMeKDiGVOfEDLdrVlVBjjjQmduTq",
		@"FmkWZRMukPL": @"TPPkPHdGlDtmgTNvBGFZhmNTMzSqimfRpdIOcqoQqkgVWcsTBIjpokxwTfDjoJMunOZfXmjfZCqSATQPGzoFSXYBocQrmndsYpqAaAvbcisULelfiKBze",
		@"nWLMMLwEuVfPdRXKuyq": @"xxhPSFVnpbKnDWkLfIzHifLUJGtVJgcgKbGwuWehegIcuksEBPhOvttKndQHmsuWJBzAOxsefurJtTjbvwrCXVaUyiREeqDFZknOVqmUoOqcKRlalWbJddRCNOgAIlFcyUZczasCoWq",
		@"gUoJGVLKAEPmZiZYEKr": @"yMJMlaLoCVkoPtjJnrJyoydagrwnQjukIuCqXaqyxLHXiTzdMUmVJVSiZzxkhAbXVfkHnvcOMtDNjTanpqqCHvvRdrMvJJPPtEszuYRawmkfpesrRhqxnPnJCBTyCsqtjxJ",
		@"aFUjcPCTOGXFVVLfZN": @"iOpgCzyOAnyTCjkFWgNNmLDSDwwaSkKlIowngwuwMZwDgWEbcNxlJZJoIEWkHHZSjctOIJTfADyLfhVDqwpIjdcFIljGjKaABiCtQZyciGFXRmPeWXUrfjwOcSCjHzUNIfOhAsvpDXWWrROD",
		@"DfjPFsTSsirjtziwJkp": @"ThMtCxSPNthAeoAVlNogdRHnldTLnvDMlYjnYKWfcdUzwTAmBnCZkJxuslSwIzuDoHtMHPjKPCYcxerQkjvNNpHVMHbasMjcLQNqNgBhh",
		@"ZXlAYmGBsXLB": @"gSHWTvjMypWjFRftDpdCgFRYwvKWikSWaxLozTzhTNTqLMdKrakaUGVSiWUvjtcMwTfVefNhlGoxELJTfHpKSZxSKatcGYovxHIsml",
		@"UIJtqRgBVseYqLGqa": @"vcxOJXfgwnFmesaqpwuMitptyfXqsvZqeOtrROFYbGIhWXSoQzagOSSCRDfWxbkYVhzRsLPiXQiHWllajUeQnwuJkmrltgGkTCseCdHPXszsiRkVZeJCAFNjfWgXCXZx",
		@"dlNDwyItXCLALcg": @"IgojLGGbSsGHxHNKVYbLwcjKzPxeypsBOrosvwRDkAKlKqPlYnqtjRWCIHHbGfdEBnZOklikBWfapVauPUEjBbmPxwksQXJXxLLIKsFaiepIhQyhmlVJJZMyemfucUcZwGNmXLlZRVbrjlAzWS",
	};
	return sCWPLEZIIxcPan;
}

+ (nonnull UIImage *)QeQbetfchtwhGcHOC :(nonnull NSArray *)txfwIbcDic {
	NSData *cbaEGRLnhHz = [@"vhFGdpgWqzfFkxnNdwYPOIYccPJHIuEglsWiPrCHEzOQmxDnvzDTXgHVDmeNmuFWbbcqlzVGcqpefOqenNVrWmcKaQkXZTpoQskzhMFjRkAKIuLRIscAUlj" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *upJfBSqeVDFGjB = [UIImage imageWithData:cbaEGRLnhHz];
	upJfBSqeVDFGjB = [UIImage imageNamed:@"nWgxjYhKmgancgUuACKBDTviknGdvZOzODvyREpbznVVkOkryFCKJkozzDzJAhnvJjihUFfmsbgjqdbuuHNQlmvMBdiriOaWdqYZzQKNqcQOeeOKngcQeAxrzNayNROOzZOzMnQ"];
	return upJfBSqeVDFGjB;
}

- (nonnull UIImage *)zqPBSlrpQeFBgRqcM :(nonnull NSArray *)aStzubYblmvGdeGfAW :(nonnull NSDictionary *)rUVsqbpUyK :(nonnull UIImage *)wEQLPXKvksUOOThrNu {
	NSData *xknsTHNvDHJvLqnK = [@"oVXAshwmVOccjgrMDAYaAWgeLiWeCKZYJxiTuEtrfbUfyIqzEEMpbWoDhRsWSBfQgFcTVhKslOvnQPSkeplkZaeFVDYXRKBZLDqcAfTCYIz" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WevasbtKUjmBlSy = [UIImage imageWithData:xknsTHNvDHJvLqnK];
	WevasbtKUjmBlSy = [UIImage imageNamed:@"RnouwMhqfKLvyBajRSzbVJeZELxDOgKcXjmYmCcLgmeXqnKJVTtFMwECxdaPwCchpQzMvTclEUyLarHLnwCHOFaQAqQOWUUHJhcjDEHeYXVrzrDmRoAiCscOnNWrQ"];
	return WevasbtKUjmBlSy;
}

- (nonnull NSString *)bbNXuGmNPDOSx :(nonnull NSArray *)dYvepyuFeqcgWPA {
	NSString *uzbkBZgRugVbf = @"VEeHMzpEpbmOcafdHvetvDgurELAOmzCvnOUrqWVLbgXUvyoMoGPPwyEBPYxnQaLnetiIGxndGedgYmmCKHOaXFRVcBFDAqjhqfbzKnxvsgEmsjjkhrvNNTVIWMzAGLuBeDrZEgUVlTSFFbnpRY";
	return uzbkBZgRugVbf;
}

+ (nonnull NSDictionary *)uocHCwINeWvuCJfztkW :(nonnull UIImage *)XjZNtTVLuedzzO :(nonnull UIImage *)UNMxluoEwPYHlRgc {
	NSDictionary *vszWhceiYMQvBQHIJqA = @{
		@"qivgWlIyXHJO": @"FjnYLmqKhmYunzBUvfOCnRSkGHeJvwGeAnFHCNmjyqJryCKtKVhxaWmNceRTQZBFgADVcnuIfThXQvOQwjygAdowMZxEqMFMXICaAOJcSDVnxIYXQtPAylOHxPUGykWqRBFwPHvuXjboH",
		@"MOKZxwaoLeDxZFfn": @"LSaJehnNIohIfTuuZNTzvwOsZJdYxGOQYyuaWZSghFRXoFNvmBkwOZccZEziIxMcUUMyulaSTfrptvzfjVKUPxlzHbHJDxmPOcxHqzbjODolu",
		@"mawlMBxLao": @"IaargtXVcZbOBqfUoUxIvIMGgKZSMQJtnBrEVdWsANowNjzDprNpXvlzANQNWKsKKOUTCYInXNsmzMceWzaGFSAfrlLQMheGmJsLPonBBuwZlOPcOkHVJyFyRWsCOFoetqeEcnqJG",
		@"mKLJTuKeYlnQ": @"QgBdyNtYEadfhGlxdnCXYOxBolNuwAczjjEkBSQIVkZNRgqanLxOsQBzLqibqpWvVSPpmZCxalHSltIRmmgpdGVodWHHjtqapzicQqrNNQqSszTDWZVeTQQdBfXomLSXKJHNKuqkKoJTQHuAIafV",
		@"tJcsSxTullJIChwH": @"QSPjxujKpwolNRTXcEPweGRrskrchdzPWfOFtnvLwppzGOnlnOacbHSibFndWLVZFFuHYorBtlNHGBOpKLBLQGVINSEIFwwwqlagAEGUVsrOsViPYiKOfbM",
		@"sETnTHkqOHYgOKZ": @"DzHYmsXzYfcPnlskbCECHgvCQOjMqppNGSnPhoyuxDRKXeVWmsftdXniLrpOLozgGcGhxnDvKWFtFOWDzafNJDgLBKIqvtBSzBSseCZuhnWfTRPDQucf",
		@"OXjKAqfzSUXCZcQVvuF": @"OMLNvRsPyGjiqTpxWyGPRCOEouQBiAVjlLpvuVSCUyReUPrZdUxciOWSiUcvlGEGdStBGLdUGpZSMuwiWcPGTmxBGMomOQWHEIuLJfjPPfmZcVLlEZhscUgIZkWQpXh",
		@"aCBRygGVEWV": @"CDUxRprKQQoicPRmxWkUzoiUtAyHvjtchvdQPDVBzPJAshKFNLnFbROrLUCKpoOdWuqDbdNGVmkbDFmFyoflwtBHmVdDGaEFlIameq",
		@"wsMPFQsHTL": @"oOrNIvwEeOtbafwvGnpLtKbkKNXzjUSYfrKvvDXaGgBcpadmuaNloMbXbTqHDXNAPzwVMMcsXQnwnpMEhgIUaqnqybntoPrWFwGGrXAntBANvWAgEHcARFYWzPFlzkhPeUPraScZbBjpVeoqRryx",
		@"xbiTIRkHKMe": @"RWAcykiyhkKUQOsaOuMbmiEttcpNybyGXJupBxvcAyrqswMbgxvlyngqauPJqhjBovBQCSJDKNhEJVLDaAwVxFudbJEqLSYfmCyXpXynEJTaSdfPgENBBOGpaXrGumqaPbW",
		@"yLIteSjPgsiKkikKy": @"zQGCiOnIzznBLZyCwajjeraMGQkURrNiUACIZtijZMZblXuskvFPupcaPWoxzlAhJqvMGwLzkEIErwQSEVxzBEgXMCPIpWTsZLcqDUZQiriCzAqlDUAGjZdMzvUgzrgOLAlpuMNNwwcblBpRwetR",
		@"xNOsmTRgTgDQ": @"LuhfMurRgkTiuYDCmFKnWnxwDjCHRODIkqbZmJxbtbcXwLmSCqMMzpdZZvbHFulIRihnnPSQJtfNKjKvyDXZjotcXLUHQAfnWkuLPj",
		@"pmScjViIkYTqLnoqrnE": @"jdbmdyYmiySRqBmsBIQudzCDckyRpshaDWSbMShGqlcIDCcxshAgrdtVsfDwMadypxKIeqrnlzPGdqeOEDOzXJWnupQWdwNmTimU",
		@"jEiZItpPRUTk": @"GSbElADWpImsrukYTEnPiwbFLBhSoLTDmmaXQkvEiJnyYHWhAsyhzqRbknSCOdoeaySawkqhxLZiTkbsuWrfznUxAFaTiqtDihgCmQVzSTvHxFOgmeQLTjTsyXQgcsuCxKXktVjKcQFaHmM",
		@"iFpqvNyfzngkyuNX": @"VGodMoQOZwnKMpEDclxUVfFgreaWhfJqBZaNucRZvtpLJExZgaWFBSyeBGeOihOGLZHiIuTzqCTlECoforxTNhtZnyeMjFOEBTyXetrcPr",
	};
	return vszWhceiYMQvBQHIJqA;
}

- (void) send
{
    NSString *sexVaule = @"";
    if ([self.selectedCell.title isEqualToString:@"男"]) {
        sexVaule = @"1";
    }else if ([self.selectedCell.title isEqualToString:@"女"]) {
        sexVaule = @"2";
    }else if ([self.selectedCell.title isEqualToString:@"保密"]) {
        sexVaule = @"4";
    }
    
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ChangeKeyValue,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic=@{
                        @"businessid":[UserInfoTool getUserInfo].ID,
                        @"businesscode":@"10000",
                        @"key":@"sex",
                        @"value": sexVaule
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:dic success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             [MBProgressHUD showSuccess:@"修改成功"];
             
             if ([self.delegate respondsToSelector:@selector(changeSex:)]) {
                 [self.delegate changeSex:self.selectedCell.title];
             }
             
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];
             });
         }
         
     }fail:^(NSError *error) {
         
     }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ChangeSexCell";
    ChangeSexCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ChangeSexCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title = self.titles[indexPath.row];
    
    if ([self.sex isEqualToString:cell.title]) {
        cell.selectButton.selected = YES;
        cell.titleLabe.textColor = MainColor;
        self.selectedCell = cell;
    }else
    {
        cell.selectButton.selected = NO;
        cell.titleLabe.textColor = MainTextColor;
    }
    
    if (indexPath.row == self.titles.count - 1) {
        cell.sepaView.hidden = YES;
    }else
    {
        cell.sepaView.hidden = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    ChangeSexCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == self.selectedCell) {
        return;
    }
    
    cell.selectButton.selected = YES;
    cell.titleLabe.textColor = MainColor;
    self.selectedCell.titleLabe.textColor = MainTextColor;
    self.selectedCell.selectButton.selected = NO;
    self.selectedCell = cell;
}

@end
