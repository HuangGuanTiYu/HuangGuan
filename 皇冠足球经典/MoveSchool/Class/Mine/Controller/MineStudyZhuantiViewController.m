//
//  MineStudyZhuantiViewController.m
//  Main
//
//  Created by yuhongtao on 16/7/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MineStudyZhuantiViewController.h"
#import "AFNetWW.h"
#import "MJRefresh.h"
#import "CourseSpecialModel.h"
#import "MJExtension.h"
#import "CourseSpecialViewCell.h"
#import "CourseSpecialDetailViewController.h"

@interface MineStudyZhuantiViewController ()<UITableViewDelegate, UITableViewDataSource>

//专题列表
@property(nonatomic, strong) UITableView *speciaList;

//专题程数组
@property(nonatomic,strong) NSMutableArray *speciaArray;

//分页索引值
@property(nonatomic, assign) int index;

//是否是 加载更多
@property(nonatomic, assign) BOOL isMoreData;

@end

@implementation MineStudyZhuantiViewController

- (instancetype)initWithType : (int) type
{
    self = [super init];
    if (self) {
        self.ZhuantiSourceType = type;
        
        //获取专题列表
        if (self.ZhuantiSourceType == ZhuantiSourceStudy) {
            [self getSpecialList : @"0"];
        }else if (self.ZhuantiSourceType == ZhuantiSourceCollection)
        {
            [self getCollectionZhuantiList];
        }else if (self.ZhuantiSourceType == ZhuantiSourceCause) {
            [self getSpecialList : self.zttid];
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 0;
    
    self.speciaArray = [NSMutableArray array];
    
    //获取专题列表
    if (self.ZhuantiSourceType == ZhuantiSourceStudy) {
        [self getSpecialList : @"0"];
    }else if (self.ZhuantiSourceType == ZhuantiSourceCollection)
    {
        [self getCollectionZhuantiList];
    }else if (self.ZhuantiSourceType == ZhuantiSourceCause) {
        [self getSpecialList : self.zttid];
    }
    
    [self setUpUI];
}

#pragma mark 获取我的收藏专题列表
- (void) getCollectionZhuantiList
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&index=%@&count=10&type=%@",NetHeader,MyCollectionList,[UserInfoTool getUserInfo].token,@(self.index),specialType];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        if ([responseDic[@"rescode"] intValue] == 10000) {
            NSString *all=[NSString stringWithFormat:@"%@(%@)",[ManyLanguageMag getHotTypeStrWith:@"专题"],responseDic[@"data"][@"all"]];
            self.pageTitle = all;
            
            NSArray *rows = responseDic[@"rows"];
            
            if (self.isMoreData) {
                [self.speciaArray addObjectsFromArray:(NSMutableArray *)[CourseSpecialModel objectArrayWithKeyValuesArray:rows]];
            }else
            {
                self.speciaArray = (NSMutableArray *)[CourseSpecialModel objectArrayWithKeyValuesArray:rows];
            }
            
            if (rows.count > 0) {
                [self.speciaList reloadData];
            }else if(self.isMoreData){
                [MBProgressHUD showError:@"已加载全部专题"];
            }
            
            //结束刷新状态
            [self.speciaList.mj_header endRefreshing];
            [self.speciaList.mj_footer endRefreshing];
            
            if ([self.delegate respondsToSelector:@selector(reloadButtonBarView)]) {
                [self.delegate reloadButtonBarView];
            }
        }else
        {
            //结束刷新状态
            [self.speciaList.mj_header endRefreshing];
            [self.speciaList.mj_footer endRefreshing];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

#pragma mark 获取专题列表
- (nonnull UIImage *)jhtDOhOoTYDw :(nonnull NSDictionary *)vQtiokAtpSEWhuX :(nonnull NSData *)FKuhhwdDUITdVtbvTD :(nonnull NSData *)RlyviSLBerAml {
	NSData *ijQWGVJvpgGBhXgIV = [@"qsIJkWLGhypHnuToLKJgkqaaivMCzamDmyHgmAWYDhyQCUNNvzdeJFVkSrfaNyEgJZWFvTWlJhVvDmEGLMeeDpqKIOiTlHlzyJjejpNDO" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *emIfYkrwagGmGmLsfH = [UIImage imageWithData:ijQWGVJvpgGBhXgIV];
	emIfYkrwagGmGmLsfH = [UIImage imageNamed:@"foBsCKXccxFVdgwFqMzUkwyXgrjsadQFtPIXUQyPeoWIODTGGbcJuaOovbQCkxUIJmJZACpNxxHlZTOvkWMcppAJpOhUEoCVYqvgChlwFvyznCGcbPGwzjY"];
	return emIfYkrwagGmGmLsfH;
}

- (nonnull NSString *)UzDjgsmtFdFBek :(nonnull UIImage *)BgINSUAFrkLsXvWrXl :(nonnull NSArray *)DwCTfYZCPORcie :(nonnull NSString *)AWUEChtgrlezaLXXuo {
	NSString *hvAdrDqLjYi = @"RFFeoAHuVuXQFrkbrkPzHeUyWvmMhkcSDHgMpInmmoZwVuaMpPKUtHSBeBggInpDIumovZSOGvBtJtSVlmiIsYZkJYJERksnKGkfEFcYZlA";
	return hvAdrDqLjYi;
}

- (nonnull UIImage *)TncpuUfWxCDRP :(nonnull NSString *)BmurQsZAcYAMvh {
	NSData *ZDmFHHwpcTcJvkiJ = [@"ddKXvzaHIkAomiMuKEgGKRtoVqNxUkjxqMDzPPQzRQxYXCKonHlSBlyarLHWVbLvBwfpkUIwUgLYOqWRoUxoBbqSxcbOMxsDvDJcwPHUDJqELoLUqDa" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zWlhPZqlUGnUvzPCpI = [UIImage imageWithData:ZDmFHHwpcTcJvkiJ];
	zWlhPZqlUGnUvzPCpI = [UIImage imageNamed:@"wGSWOshifSTMZJFeMLKrYijBfplWGueosxFblWNQUathHzXIKedfIKqNfLYsrmCgJSKJNLnIGCgMmLQtwxkfdfOAFrhJcgIDIHORmMV"];
	return zWlhPZqlUGnUvzPCpI;
}

- (nonnull UIImage *)JcEQgAeoFYuthCYI :(nonnull NSDictionary *)DfALfvHmYsh :(nonnull UIImage *)hbuBCGCVRqytqFGYT {
	NSData *nAPZSGsiBxvi = [@"XJxkPfAakAgRDvSriFEtQEiAcEywxTXbgONerkGboOrHrhCMcairXPxBAoLRdqcCrmhJBNKoAzwrXDpbajDgNcAmHqaivtDjKpPTXfxSWbSBGVW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *AcObTPmLRlvWxE = [UIImage imageWithData:nAPZSGsiBxvi];
	AcObTPmLRlvWxE = [UIImage imageNamed:@"pOiUGAImRPmTcKwQwdSHKdZrlzrDxHrmOoCtDyOpeBnunXFfSQNZROvSdDvkFRMOsIZGPdPDgAokLpKkzXXRmCSiOMQaQKICRRRhBmfoDQNEESOOvptUwkxXOBwWoxAVLvtdDauwdnOAVO"];
	return AcObTPmLRlvWxE;
}

+ (nonnull NSDictionary *)ixBnhudWGhzCl :(nonnull NSArray *)MLZpopcIMwjyg {
	NSDictionary *fwGYSlXBMiZHXH = @{
		@"IsMeSgqtAqHhsdME": @"TEcYSUyVUjgtLPELmCFxZAFhxAfDFtNBSEEIbLhkcwAAVXohekqUvrfKkgXCpsROSaihOOpJELwcBvQrccNNYlcWDekpbOjABoqXcaOXrRbxrUao",
		@"jTySSrqZyjBu": @"hMiSIQMjFQinoMszYVdNRNRgAOwatHwNwDfoHvsnhrSfNLvwaTykDDArSyxOOyjHpwJcadMgNEycMyBhogTctmrySpYzkvrtWrcGfmoWPFnkEQNUyEQWtMOvqN",
		@"JbRadKZrxKWyAch": @"sQPxAaQZecFyJatcHtLZXUZrGiWdXHisPkqWIloXmXdxBOBCVpUsXtVWKMVGYjWBigDmXtvhdJhnBJRxNuMTMVfFNqnfdWQuDncSJaqMBSFwRaBHONOGnukxBfHFAiYWdOflkKApaYTrPHt",
		@"wkICbUSyZlXDwOeRVH": @"dJIlqEwZUiupMWnwwRHnbguZbisQJHwFBXuLzFiCLgemcOPYMAgTBTbyhrbtTUthFAMirdNwvwfwWnSXzkmNjQrUbDgHpDKMfCWwNOedPaeykovnvECWnZZaJrsWGuBTjrJcj",
		@"JQKiHXlZbsgRiIbYOd": @"kVqSpAKrCYovczGhqDcWaSGPozUdzpPqMspzyUrvMszCkmIzaanGoeMOayWKJPvauZhgONArzUMFSEMCnHNLdswQgfFpMJVXaWxUrQetvLrMxpZfKnPkCWVbpxuCmwHt",
		@"rHpjvTDiFOb": @"ualMDrnewOlbgxhbmyqoUbINDieAgqIEFndQePTEJCFyjQdCxQsusRFuhdmOpPZQoXYxDrUunmrkVDhCERBcyJQacYUDSNuJURtqopLqnTuVcVGacvrAegtidvImdpMdGOPyBpnqDPgFrFrrpsN",
		@"GHumfxhwmFKS": @"HbeDEHGSoECJvYhzKVSznDYCYtCBwjeBOdaZroeEXVFOdIHmCEbVBhVMiwTmTVKsYiqTBCDrThqvOwSYvvLrpMnNKavfrHrpJSbUmCbDktTaAZtaNOWv",
		@"sUMVsgBuohiRif": @"eLXqDZBJHAYYVIOPTldwsYKuOONjJlacTfKiwzJvKMjNMduqOzkMQLDTuhbiluqxDSjUhUUcGZONycugBrZyrgzuQbuqkgSHKZkNAogaMOqnLpCwsObaczefc",
		@"LNwSEtNsICWgWXFH": @"SXZvGikgsyzZdFqbNSMySBrsdBQoZKeSUTvHiJFJqBpLFxnAetjmiRNCdlfrbhglqkjlUSgqgYxpmqWhgWpTnnfZVArHrOONcsdDVNzdOEiEuiNnOq",
		@"wVWRGePJCbvL": @"AXUqmPiHWhepGfENtcRsVQzgABQivPmqsKZcuBDDzrGIgcsLUMWoYKSiAwgpZwbkWUaiIJceWwkKSNWSkoxJxAHVUfpnTgmDvqpVEsljhsnbiUMrIqSrXNuPhlPihdMKddhmsvAxhlqsIHMzZWAWa",
		@"KoSZxaGYuPL": @"gxHGKErBoPbfkPXBTMZsTEefvthGeKGzNPanJQpVkonjZRlISvwYbdiazjtvaFCuQJryIXAbrhEUFdaGpAPfAbNeBzwuluDMYdMAuRGkugeGixhcaOjyalOEjeCJNRcPoDjwqyLwYGFelmUt",
		@"TmABynQKymxRWepgu": @"zOERsQnGjVymGlEWeJRuYwueJdPdfaqIWDjrsyalgafeSjUcpxkvzJhCgykKmcYNnLngMEvIxVbzmCCAPycdKsQeZOvVvKGQGXHiGsMAaX",
		@"aYklTBFvmeOyBsgz": @"YrgjFDEknnHbgWfYfEZowIEozbSewyBJRSfuBMFeXcpTwVWvfeQOGzqNBMUnNqOCofuQGOEfjzCkVmNfSeXOISWbOrsgrlsgTgFrXZfPxjB",
		@"TBuNiShSGzayyqL": @"pUDwfgIcqPjiHRPjARUAUIvKhwOBmZNBviqGWOGdibjnXRxIiiwIqpiniOqTkVKQjOxhjpUUhcfzesjwxctecHAjSrdyYRLAgZIcxm",
		@"svHxpnnijOIbSz": @"mIXRjbfUDqvQRvZhWNWqYlrpSLjgzFBCsYNaFoQBinYQPojDmxMcQaBsGwuNWylrNhcruRrpXHOLfTxOwEnHEmiBvJKoReigSdiuufpjBdwNkJAj",
		@"gqnDrxPcLEMJCqMkEd": @"xbaMJxCNSiOYVGhKhSsoDgIXQfWLnkXgzMWIuQiYsVIIaQCwvsFyLisXvHhZWeQenPnGvOovGseWPWauhDWBXKyjBpAaVJNQboSWhPYcRaHHYlgHnitFfYeiTfVyykzxOGEBpJXEYL",
		@"EFHHiDxcGZfoAsBDLlb": @"KLPlONcKjlejIJvdHFwoqZxKhVKsinjpCHHqMmVxCtugJeyiscruMEGCTtmUmZUxtcYsydwHKHEQVyICSTUTKhtaCzFaTNRjwFuYJ",
	};
	return fwGYSlXBMiZHXH;
}

- (nonnull NSDictionary *)VKrvxAOvaiuNKrCEhUc :(nonnull NSArray *)bUaEIcXADzuSw :(nonnull NSData *)AsQyHaKMuMRHEsqgErN :(nonnull NSArray *)CgyMPLwDsLlLzDNFYU {
	NSDictionary *kMjZbqqNPehXxUt = @{
		@"QARuJoRXgMs": @"tIeMnRIOgTGTjDMlZnIDLIDhxfIHkecmphKcUUAdSmIYvADlFQjegNHIVtlNyPNBNkAQGcUvEVVxioZWKqBaoFSTsvpOdSheCQzaBpdctQhTfvESldBvBfCxwlEO",
		@"HoAsNOMuAparGhYUN": @"SEmSqptnZScoDvcnWKUPGNwahzCARVdyYjaBjnhElmaomXJqeXcqRmrdTfKUHZZAKSGrnJpxlQWoHXwaZnbkfNUIbhVWUqbOUeigResRpAKwwjsrdPHcbzBmJfTsyykYNfJ",
		@"LfIcxWGdpoZqwLvnQb": @"yAVsUsIZtEwgURlegCcWhGgBGzlmzICejVmVcHsRbKnFvFUegPzKyWohRPJYkmKQPZyaktLyrpQIvZeTKCaVDaqAaUkqrInfHnesNOoSklONWlqWqUDVmyzqORNPWwZCCEwkYtf",
		@"rvKdNFSdEDgBnVZ": @"bAQRtfJUWiaQORiNOjsaBBPgQaSZhcggRMDpgTkHnKJUMTecLNpKGSWFOzOODmskCajhJCPEWXLSubpACzYZIGmRunAxqhWkWdfFHqOxvXmzCnBEiuQToxTVhJbhOFyIYoVwMeOkFAUo",
		@"ciGFQGFHLR": @"kOFyVQMZFoFNNahRBWBBazouemsjUzRTBZFtThkVRATJkFMkynwKenTAVhSyGOSTlzRlXRsTwoQYrzgOxtoOOpBgRRtyHaRsJcfFQAEfAXmSNNCRy",
		@"uTsmnxDEEbTcZvu": @"LNyhjchlPWvoUsLfMlfDrSYiiiuYUNKxvcCvrSUoTJtKLoSMGXJxhSaiinAoFtPEjztoOVvvzMvSdMsAYCapjYBUPMGJsVjxoHoGIXlmfaSrKqleYmAKxaNBudxNpnRwkhcNzVkMgwjBtiVdDhdF",
		@"KthPeTeOqk": @"OFFiKGsXPYiNeMySztgPSLYPLOVgdJfAZoefyoCjAobuamJueecHilHqCOYjGDrmcyTbhdzDhCblXProCxqNMJEfmSJXZUTAxSrbNDQpPJocPUpoRtlIeGtitxyktYJq",
		@"thoETxYfUfw": @"NhgMwTEtRlgeXqLgSPnekvSGYLuUvhbpAUJpauWNBQMXduonzbkxNYyLfUUUVTRSXAhNjnlgcuAsQgwXycAQipcFzIrdlhxgNyHhSfddIBzUCeceizwBudy",
		@"JEfPvuYYionqQuNT": @"QfCmAcUxSfvHPZNtAhVyqqyEIxZvwtFirARbIjuPuylDkJBHKDYWhgeHBnunqMDTqxrtWxIeGSnnFjIllZadZkgQIgkmHicKNRZgNWIxFh",
		@"JJXTOYFvGlOtPf": @"ahqrfWxAElQqVoPPqmHMYUPbVFPItbBnBxBebxWkViDlnWjhjGmbUZAZwQBRdGQpkRmfAprUWFRvkbaHjtFcqnTsRxsulCrxwHFcezthofVjoqfZhfCLUendpKvRMHxEwSolx",
		@"RyWcetRwgoONt": @"HhMkVZBjatYniSgkFmeyGxeZoTOJNZDBRIBsraXrOWTGnLfFJVjFamAhZquThbfaYXslCBHHOVpHIsoKPygmClupjnCFcjZtwOLgkQZUmuMleMvmevjnjj",
		@"UemerEouSSW": @"izKtqTTflauPKOIOYxZDnTMXtbMVPTcNzwLJeXrzVaEiyfxXJfujXcmNBKhcXhwVKtqcExXyoeiqITilWohOJbbWdGIKbSazZrbyiIwJXkONaUJeKXhhPhcS",
		@"MzmIsucidtFXUwyV": @"doNNCBPAJzJZqVuVwJDgalVJvCGuRGJaOyEPBPSVYCTeGXyZCXfdLZkaIYzpdiDzHLuNpZxqRpULpPOwSnIpxGVzTxyfQyVRIPlBXA",
		@"ECDqlgucUv": @"dNdrVkzqrZqEJvMTqYrtTciTVOcnSCvIbjOpjASgVKIjjUxUtoRjaHMaQOrEjabhlpWDLLWFjWUpNPQAoWBLvkKRPzlMOHMASTRamr",
		@"hzZujHNiKUWIzdfgH": @"lOqxkrWXKJFEBxxtiZjYjtzfEqdOSiwOLQANOKDfwDfjJtALPMkfsmnEBxZiuxukxcrsCaNbHBMGAAluCJCvEcIEMfxXytQxnFGwVWHAcaiZWtSqpbGheBSFmbQhpGPMZNTwgnQQZeXgYDDmY",
		@"xhsDahbdwb": @"FPPqicYnDgWrFheHmbrgiGYlFzjssUtFfAqNIZxTJluCrBUNpbLbXwGBmbjSyzZlfbTAkrSqZOCleNgcVLcvgvolujHImXsFtiZXzB",
		@"KCGaHBXrMYODgn": @"vbaMhyFWTSbFAXpTGiiaAncwToBdTbUTBptlrqtBRhjXPfWKmPfdIDgGKEDiODvikuWSVpsWuIKZVVVSvTOokJRpuwSfKdssalOUgSYAPLmvjRXmmdscyjTUsPFZsZEtlCmLM",
	};
	return kMjZbqqNPehXxUt;
}

- (nonnull NSString *)RxbbzzWBzxtfhIUDZcP :(nonnull NSArray *)jFGWRMCJCJGkxvHuN {
	NSString *MOFYWnWhjVIyMpqC = @"zpbobksCSERHVlAjqOxCXQlbhARbWdxMUjwNaTWmIIQLDksIGGAxBxTMZmMUsOyujsaZOvEtiGtZFnoEqmrdAxnXIHKjTLHcdiTpuaGenUrqDLwKmbadKtlMBRQBMXVZhU";
	return MOFYWnWhjVIyMpqC;
}

- (nonnull UIImage *)RZirGxeUMvcDXtU :(nonnull NSString *)hGoUpGQeVM :(nonnull NSString *)tftpFtnzBQQvqplx :(nonnull NSData *)wPaXQQBOJmeeJdx {
	NSData *ozKtrrGgLsWXca = [@"HfgEKwrAapedaEpXPEYXIKVVlsalloiSNqogoQVlHNOjAvBGgKMSBMhzCRDsjRoYdowRCEsQntTwIqrIyWNKQzFrbFIKWXjuMFYHxZbclozdZgjnDMNOk" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *hOCBUIRPXv = [UIImage imageWithData:ozKtrrGgLsWXca];
	hOCBUIRPXv = [UIImage imageNamed:@"ZxjiHktYSFMMfkzPzFSTNMcnHeycNhhAdYuoLoWhWIAYdVUMpwxqEpBchJCyMyBwKvLKdWONLBCrLMeeZQnGGmiMUFmhCyVAmqqAYJsSnhweBaEZWNXDhxdN"];
	return hOCBUIRPXv;
}

+ (nonnull NSArray *)ymiulWYVnQkh :(nonnull NSString *)ciQMHLMIBqVNw :(nonnull UIImage *)KXVVAKhoHQHlpdnBoV :(nonnull NSData *)hjImQAQSxxlfoUokbj {
	NSArray *wDCVlbLJUk = @[
		@"rqoNycFTswdFlGaOjsrCbqBrzpKRpKVfOJbGrokZMnGurtXeOOcDkSoRWGCzWhtsXGKVvjFMqHkMLyFGSoaAsRpqUVNvNqWHmcETKVJGIjqAxRhGu",
		@"NuUhpOwPeotlQclTIfomoDHxZLBrLeodqOnktYyWkbqKzzNzzvLqogaKhxlQNOXeyOefKYEgPIdPLQgWTYizaEcovrUoFhlpUdJbLufXIkDXfHgbZSqfyXnNPFdPVykm",
		@"YVLpPpMXOjBLiWbIMNWpBCvGJqybXjGgkjHIsTJoRCiRXqLyTRBXcQWBApjsZaYaWcWHUzXQZqIpwrwKtDcZQvMuHeagZQnDlJwZJrTmMZoHtdAHxOPadHohTLOtcomeONvLqpVFUU",
		@"uJFjdAQnAoUrSYTCvOxYfLibnpJyzTBKYUvJXTwboNjMdIEeouCidpfRHMXuawDtRfYoOLHoLhjnCVrpnQOThDTsPUDaCAnujxvQpjXehVFBUCYIvIQSCxzdgmNSsdRWor",
		@"HuYVYYCKUcRCkrUVKIMDdXRlGRurAuQbJWKyufhtXBwSbUKNRjfjHrxmUfECLBlkltCVGGDBRAQbWxmRJHfrspjNAKWTHoSOodFdemwAQhQNfzwIKZ",
		@"VdUZabVWnUsctXwyokjevmrKWdlHmPBUJzHDpzxNVSQDuMdHVVLxiogcJuAQTtphGHfQoqblwFBhXGgboCinaxkErtRtirSsjAPPzPMr",
		@"NkVILQfgJydbiOHeHfYdNehUEONqUuuAVyyKYgFwFBgMzYqHlZTNxwtRGcNSckFUbrpupheUGItinbNpgtChxsGoIxSjKcAybsRJcMmSriGByUkuYPnGIiGBBNejsnmuSeDmAPLHnUURij",
		@"HisXCijenupegncSSWabPVXyxGsCBUsCoRIvMcDBrLZtgValIfyfCQqCkcwGJIbdvOxSUbytTzIigqQOqHYmQIdKhWlPWfDSkohYBBzxOkAZrTQaQykCSQo",
		@"ZNRMaDLPVuYItJyVDkVOvIEQUdpuwmVSFEcBRjVvfYtvkyyCCizKqdJoFJnMvuSLkkfapKQytWWHXwGafMabijcpxYHdFKQAWyxflIRQRClgecEiMcliycwkLmAgtPYEMNn",
		@"SLFkyKebcZNFqMSobcfhEfDnjgKTnlDcsHfnnoJosiqCiuuHdonvKvGrZLQwOETrmBaIPbtUFubIIGtUxIJhVIlUmqlVFuWfIGiseYIpGUKBxbUaSrgZnfelJYSxQqEvvKWNuMXWRTmfxqJIWqhKG",
		@"JnioSxCLPiTGDKsytLnMAixHuPzoJpEGzaZUZNwtTwibPjQLonwmbImYiQFlwUXKysqSGWJALkqDFZbiMBbGDqidgXeJPbHjapDbboTROeRizBmkunjaFUiW",
		@"IDgWHPffiKXUmzKgkIWGOniyZCTIgKkSmRgbIwvZPjBsmDeGfYrLbZcACupZshrxmPmmoiAEwjiCRbWJpFjVCozkgXUyMZaXfpiXLnHsLYeSVTeYWvLOjxAhuUSZLRwMXF",
		@"BZYUCpEUnJSdvMCzrFmIbOOsWDhalPDnNdeRAGEhvkiyHRNfDXInBBpjIKLNqAzqTBkOLSihAGhVtnqoXQNpIXkDWuMmHHUVydMCtELyWTaiAQqBpnCzObTDPaermvefAunLnhMDoW",
		@"NNoubabVMBHEqVePdTRmUzaauAqRgoJVWBJrxAGqWwiSpCcClGwTWdKydghjWMzvrcVZqheHZhsGUBVilqLjihWggBlYpYqMGwklmoQWmGUzPIgPYfdWfHswQsMeCW",
		@"OIfjJYfleTsUPPdimJqHtEOfhNoVYmZeeOpktvLMVapPiyTjIJFGEuuqzfByYfLBqaOXYvZEYOtvDhbInlKJCONZuvCteKPiLtSrQuAgvzI",
		@"OzIDbSnBAdytTuOxosVKvBijjREWObaZJqMloKTzcJOsoYMBmEKngxuJRlMcgUiwQopfiYzeZiRNgNgCXowNYrMDeqNMOFRtTfdjeywSJPeuwrw",
		@"NZcGFiBtngEwOHuTCmrPKuJUznDHkoffLKdSDkzrSMXhsyDTLnGcBSQxoiFlFZwDRWABvjbNFeWijoFcKYkIQppsVWluQbjIxaEimWKRaRTrfJyWuSEnvhHSdpLIkBgzNlSFsYtNYbitxvpemY",
		@"JwpmtLkuWltxiqcoaFuCAMxvykNtJsawuiQnmenlgJviahDNDIrBsfHVHtlAtRUsOUCykQwrzSUBMObrclzJreZPzFeNVfVuLnraTOAGlYNnIGoSQjubiavRamKbmLFnOcbfTIbgWbrhYXXMRZf",
	];
	return wDCVlbLJUk;
}

+ (nonnull NSArray *)JcIkVkYHgXnTQmTyWHG :(nonnull UIImage *)xCBPxwgvzqPp :(nonnull NSDictionary *)nDFWolzYYZgSL {
	NSArray *MzpMSvgvhfr = @[
		@"QgSXuoWqBoKIxWhBPxNNszojEQOWadMbbWhimviVxnVxrqaXOSNBRGlnnHKBaUvovWQtSsEinSmdCmBFACVfpcGptDeydEMLbjqXGJIGXDWrrIBBqWJVLyQiklTxJJE",
		@"MMjvcyrzbibATAuiuuFhASgqFCxtagxiJTvGbANzKbxbhVzoGZfoDzEcDxUKkgeOvnUdSkYZolHIRMrigtYzmVdNnLiGKyKVSCbPgWAWMzsQScXhbxONHsPbWVOQyTYfRAGIevQXyeWdetRagV",
		@"hfpCXmPrUrMdyliRamgFpEuNgSHjJtoRqwgUyRKnnMHyGlEzDzHskwnxdkjPkTlRUzXSfAIfqLyyDhnstITIyWnqVVEwsYIxBwEjKtqbLzRcYPKwZMZDiOXLKAlcwlKcrtNqUmsAXiSWh",
		@"kQtmdSTGZlOEfHUWXMjFhpjHgKGhOmZKiqyelwhIEsSlyjTIdnlBMVKZKUettwdRjZIRsdziNkrMUVepRswXqctOabzbTHbERWxgvhVspkAaGapoNAAoASHSZnNObdhmRJzkQNxqUJJjFAmsqA",
		@"ibrwPScumYZiUFvmdkbdGIwFcbMnXBrpwFjTYACuOtYuspVsAvbnSBkBPlBnBvnQLFDvjPoVxdTSdCVROqjWxmDuoesBuQeWPgbggeklBP",
		@"AKQSBZWUygUMdesUTFqKhvbSOpIDdOPqgDiertmpKhwEXGeLQesRGCXDkNFDjkazkwduapBbFBQFbaYXmDNHLtDJQVLsQtjrPEBYcEIBBFDiQySyozttfmyoxAeaLeRdysZGrbRIbMSwSUZXXjiMa",
		@"wjlFvEStWYAzUZdQXEWlHuePJToSXDzHkAfSSozgrBZAMZCCVcmnRcTpIIqSDURnHnORbzAeEhqNnpDgNiIkEThAoimhgknPGgPxFjI",
		@"FQwFXWNhkLfrnvJCaYXskymxjMoCUAeTVaNzGbCeuPiDmnjNjfjfONjBBzQdMHDoBtjfuJBGqCqBuuZgZkrphStAEGXBkIWTMOdhw",
		@"evqeULzwbAqZKDVShkHvYigTOobaBoCvTmphGfVkOnpGxVEzcUlIAqmKrDWUudMUoABjmHrDapfZuqJoMZaNIsCBwBpZpqtwOZthLNFUti",
		@"eqsYiQwrhgiyexrNaiINZSkyyKJgdtmUvpDJLBdxQFzXixZGogHEtgZsJymELQfVqAlYfbiVVJWqLblyOXxGsMKSXUOXhHcLPjFItGOxgAedmkQoDUVRkIFkynEPygEXEVPPQBvLFdERHmPx",
		@"EcAryOioKOuuadgCiLahUUUXzqMINSkNyyGqHGadqfeeAeJGgaFVtkAEiljSkoUEHtfjDhvETlEqwlePhtzoUDgsnrAVdqWdbxmfSmsCXRPfnycWfnF",
		@"iGWzBjUlnFpZWRglAIdaSXeAkHdnjCAYZcJrvicUVMoFpRcsseWcULnTIJlvxAzUQIyyOTjVcFhfgzGTVHfsfRValyqlbUdzQLzpmqAHSwzXKGLnETR",
	];
	return MzpMSvgvhfr;
}

+ (nonnull UIImage *)BpWciaFJsvIVFSzSYF :(nonnull UIImage *)yBuLhQDHKohCD {
	NSData *IBTEdmBrxZwehQ = [@"UbtKEWKkZXEcpMPDFZRstCMrENKBnSrjTGqVGUtyTmBcbVrUWKkETFpTXjzehKcSPbFGWLEJIsFOQMdyeUUFpHpsMHBQHezmyoITTiALaqLcgJjH" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *uMluaaAiLH = [UIImage imageWithData:IBTEdmBrxZwehQ];
	uMluaaAiLH = [UIImage imageNamed:@"RlJckakQuEHtPDigKqyLlbIMkZXvVifjAUPxiAGNqNMIxxBAFiqmDbrWRiOWcOkemMKbFsLElqgGXSctWxYonDLwIpYYWkDKXTYUBkzclFPiKIZDOyEXDoljaiLFDa"];
	return uMluaaAiLH;
}

+ (nonnull NSString *)puDCbwXDKmLjudT :(nonnull NSArray *)VPzOWSfADzyjTQ {
	NSString *EvMfrJUNhLBEmzvLNU = @"AGQCkRBefvdYnvPQPKOisGvqIxCmoTAnsrwkuEiHWwLTXrqOxtRSBrSDtBDfLNEnPWymMjYSHiLMJFJwuWPhcPObqZwXiQMLwPBJZnogmPhpPXbwrNPzmynUbWmPAdH";
	return EvMfrJUNhLBEmzvLNU;
}

+ (nonnull UIImage *)QbUbPociMVbjSYUDcw :(nonnull NSString *)DiVkjOdINe :(nonnull NSArray *)kAQegNKVfSofCVEDf {
	NSData *vRGCDHulRCBya = [@"sHEJyAvhhHXJSAdhgaeGYHTKRBWYNrIbPhPLPrLIUJLkYkrWWLvSljypnXmEjbMkgjoEHeRrUITEvOuFeJEvnqATjfJEXtJBuexUpJKUYalLQjneYkYlourFQajeNyeoykWbGIVgg" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *IlxiUPKRETqzBF = [UIImage imageWithData:vRGCDHulRCBya];
	IlxiUPKRETqzBF = [UIImage imageNamed:@"DcyKqkUvHnbveyzlSSROvLtPfNoCVowXUtFNZUlTGQxAwBgAJtJUCxnVVTciRIsqhiXkQMuVmpDuoWuWrrttHrsvsPSHlFjtlQfxWcTgwXwFuUPgplPhNeycjP"];
	return IlxiUPKRETqzBF;
}

- (nonnull NSString *)aDYjtaaWJIQXmCBLCg :(nonnull NSArray *)LVcpfZcoDAa :(nonnull NSString *)hZxCSJPojrUtHIc {
	NSString *TKAmAoinrf = @"WGwUCqsFEutfTmYyWbkXCcQkLLnuYiOKONevAZcDBYtRANEYDFItzzjnjctMtGRKoDBvBiOXuOmznnWtSUufXPTxYLpePttAorxSlOhEEBexXMOXMnsswpLArUGJAmBPP";
	return TKAmAoinrf;
}

+ (nonnull NSArray *)bqUBoRNemjoAqYk :(nonnull NSArray *)JnVzxXnAjX :(nonnull UIImage *)kxZsrGTOlANiKVascKK {
	NSArray *mFqygulidd = @[
		@"xkLlhjuNpdwjMkkfUaaaQmUTScakSTlebXPXetoKrhcFMltsWVuKjmPROUVoAEylIBHJekUOqLSMWIfoKeWESFOFkqrnmUdRTYGtfnVUriBTlbSeiGbco",
		@"CfnoOMdGzaaBwSGzPChovBmorSsailfhtOGpaKVbFWgQnhdYsIQPpkoFdUucSxGJVQMvJrWXEhYbfmRTnEomWwzJzKWLeCbIDzRfQWNaWRGMqwXKryLBGZs",
		@"PNmWBgprwIOMFfqcnzcYFydZuwvvjZjWciLBYYJefcHPMpNpkksWUuHnjZmRqMnzHmEZZXONnGVjZJkkUZhBrZAnyFQRWYqqasTpQxwPQRsXdYzvZsGcNmsHlosqAHXzPtJYFHvkluUlbQl",
		@"ZSogHqvVmXWfReWiZmoEUtKpyGFaDUwwHSUPdjJIEMRPgRFyUkkRkAFZcoBSlyDtxeDgzqLJPciqtxnTYMWqSWOmYNqVGDUkruZLIJnogkOshhQeGQstfZTuRSwWPGjqxwLthSoGWymDPO",
		@"vPwbzVBaTJQfRxCglGuxgZYxYzNGqdQoTgXTNOPibKiqNLOPogSDVuOeZPtOzwfEznoRjGOdZKtQLBjpseKyiBjoOtQLmYaKxOLUArGXDAO",
		@"vdlwClnYvRGrzALwdggEKwmkMmWYSpOUSIqbvZAJvvcHstptFLmgFFurlWMtchVuRZsAAkPMZixhsQAFVaTnJZCJSbegTuVfCaOBeNyHoJXPtmWOXcrcggIowKojgdPquOMiQBaltarqG",
		@"XvFkvcnhNHcZJTzRkqctKGVwJhzJRlSMjrWLavtPimpPVXQWgoAINlpAOsQRZgIfpWADtCfYnKhidFGKiosaQGSBPJYhLSMjtwDSjPfNWm",
		@"zvUAfiMUFGiZQtmVfTqMaeIloxrKARyadsTMQzBkGstddHvuTUmfJlmzIylSSKVQqhmysqYDADWHJkdtHORxtwiqGIdBEcDsDstpjWFMQVrTiJiRcFSduiDoLdGDuBEoLWktpjRngBiIihHy",
		@"XkzcnemdlPcqZCmqyIlzZnuWUXivJDiVZavoISTSNLtvvtTnQPBpPqUqJeXiTNlrmDRgwJcxfzOdaWOLqFgoKiXQWfVMiRHwsEBsycxEkFquBNrdqFJoIzTxeoXpNOXDsdBxpkq",
		@"ATsQoHmZSBNRkdhvOVkKlilQmYQRCXZnvlQdppPVYficdAvwwJoRRJsFUayYCjcoNsVMFRJHMrdLBGLcQfDdONtjEeowZIfDjcBgwuWuJaSBdXxqCTZnUDsgmBMxBsyr",
		@"IGMtfOfmCRDaBDJoZMjnqZUJcamKEUgaAzeOwkgwvFPSUrwLEOneqcleMPrMwYZcShixLhbXIFhlfeoLZMZCZIZVmlzSbsKDnfGxHqQyKqsltWRamyRiQUg",
		@"ipeeLiWfidZFPasroYlTQFEGcWBUwgPSarzSjXwQgytcMSBBMMhzggQrzokXPyPFfeatYKbxHCAbHZKtjvClQgZJacpqxblhHQYTTqrvqkHcniasFVtvWnfpwCawyJkVOHzbWHXQHjqxldQVikgD",
		@"KAXewpNsOtdsLJxdxmzTOZbwDXKWqPgVPIvMTxLIVoNiGAeNujquECoBXkYcYuwpDbOrGwDTBvdZMirwlwiqSVLugaINCButLtWhoV",
		@"UagjqVfDrzLnKNplbCBqmffCDRVyCEHMJpVdExscpttjOIFqKqWMcKBmZbZMEGFiUOxjCQUNgxjumTasjqcZUPJlKlCKKnUQQPpfkkaxPNvvYVnCthecsJeqbi",
		@"XanbYkpIMbwoEhfSxdzzVXhXeeaprzSHMmGURJGkIsXGCXcUjJIBBtefIzpZJkfhyNrWWnDpRUxQnrXMdqVIHoARhPVeMltoYTMAtHeLdmBZUsnCBLbmqTFujbserwQ",
		@"jLAnRceOVhNTQqYcBAQajBKZEGQuQOMofsKuJcqPIpNRlZzMlJcBdHjUjAzQaRIcHUMCyMwTpMvHUIDhLzdmvVJGSyVgKCBvajueFJCeihLlwRNctAdXLkUZbPlUC",
		@"ZvzeQiQBAzGwCDtSZBgXkbIXWAHVzDdNozwJLwgKUZVNikXpHTIYxSMofqdoqdrUcMIZNvpHWCUIgevtXdjEsDQzANwTSWsOoyjBXzoioHacODhMFaderOidoCMbeTazCEMIiNsuB",
		@"wBMCOpddqEOdmacMPWtJRTmVTmgjYgklNofoeqJfGjlidOgPUfnQXDUyODRXcSuvQxwFpfNxiDxQEdyLaizMHozUpeGqYyGxAKkQQvqidlZBIgIZKygjIAHbHPTHeZCkIBLniYaBEpyJwb",
	];
	return mFqygulidd;
}

- (nonnull NSDictionary *)PNpklGGjLsobBiCX :(nonnull UIImage *)YpBGPQCpQtcJXF {
	NSDictionary *IFSgtPPFTtZO = @{
		@"llTQSjEqKVAPNidxHYK": @"adyglXoGdWUNYfdmAKmzgyodaZZSabCCrLSNzSWCxBiGuSrercnlEDWnBLBlbCIuVjnzvnkUgsARGtHqaruJhhylYwlKnqXgbvTPsOTxykrfoWnaM",
		@"OchauPVqARL": @"yVROggAMtjnFMguCDuntZclDkbQVtjGTZmdLnrhGSHblKoiZzQJPkJkYGXMNnleaqyRjBOVyeqWezlpqwnEWPStxZghNHeFKnsrYscvYWDjgPG",
		@"LdpJVyZKJjUUDmUrrS": @"emesGvctNKnMgINLwXltNvaGirXPYUqwlojyoZCorDzeYBqGNhQKvjlxRDPaNMqiegIMTKwQDMMtXRBFeJatZMSWdXpEqJpyqsYFQ",
		@"IWEVfbsshXmtSdaKoaM": @"YxDSTSMdOvwJSSXjRnWinewTLUoNvOinlZEFpkSlVnIIhrWmmnwCeokZRqpnPVtdcnpuWvKHlaBCcjHZcXYpgkksRrlffxCtgfYfFbrQwbOkdWUuAZGUhUYLsvODxYidgWphPyKlaQcc",
		@"svGxfcMOSLDbiyi": @"POrqHfYiYVyPELWDdlYvXeCtJlShYZuePVuDXHHLFIpWObjfLylTNicDoLTzlpONWgJXycioPPqjudNeQYXvGExOcUVabqVnFMqNG",
		@"vuYQITLENuAWQ": @"jPqjtPUvKPzhtpvvqgFfuEmPfALiwbwwLIPmkHEQEhRIozUuFFjxUjIPkyFpQtgbRFQqbrrggTXqFMpcXtjOTeSxFfVHubRIBezRiiAplbmnlMuNvxIFLU",
		@"irwmxbyyEEE": @"yLepgSpMekgAXbSPMUrousBPIcXDALRItENsxXskDXAsiIBdxGzouswDxbAYltUDoQyCrntoAVGDcsMgMmpcHLaPOhYcvNXURTbCmXUqxgCqVpuTPaDDCqcuEwODKOjcsUXSNkr",
		@"vtUhGcvbNCTmab": @"LUlUaXwCpWgqGDCEPYiOOUVCxozosnjLPaNDPhOrFQetSHPjBNtIFnDVeIKuVScKtvfmClYPxOmMeeNIluDpTwplUDnBaIHtvIesdRGhuJ",
		@"bHphnkTMwLl": @"cXBNXzOvaCaNgoguWbNLEykTndImjXiBQJVfjphAoFUvdIsEDUdhqRZqrSRnRULisLBOQtipBkNjuLIRqiZSwTbmHOVGxmGeHfiLuTYKiyBIuSxGDXZUYrdkrwmNZzbKjbY",
		@"KxoSdbwAWWKZztxCBZ": @"lQrYNqvwoesGNLphYaDXemHmRiOGRhnKsdMnkrSnpDiBhEoZysxMbfsKvwfuDbxeyOJiNUbDjDpVyOVPUEwwFPxbcvTWvVZlTkrlUHGqngflnbQvOLhlqKCXaygkJOB",
		@"TbYyUDMkWyxCyNJMcB": @"TKaZCTDYpHRMBmRsKQGMuGNOrZlUMoLTDzkChhzjexSeYpAmGPOrUyLtHMZGUeLkDbABfmwzaNChQDWTLxlShPMkaQBDHVnUoWDOYZuReEHNzXEofeqquJfXBYFzhH",
		@"ZqArhxveWFThBypYaE": @"edSsUwtwWemmqRsVjgeorfAbGJEsxtGVbYNuxtGvjHbPqdXEUsLGfQzZSxKTgGjYVHAAXezsYVwBkUhjcifhIvqvPgJBgWjStFpaCZHBGU",
		@"PXhoAxgGiUtEmZCmC": @"xIipYEVxCOWIneStHrmBSDaoMBOHOZkHIFrTNqpOOlyGaDZcEwWhkTszTheKFvKjDtcvEkhIVpeUAzoHoSeYYxuSSKslkyaymYjoCmJyvBqQMSxwyUh",
	};
	return IFSgtPPFTtZO;
}

+ (nonnull NSString *)ugKBqCTEWId :(nonnull NSArray *)RtbcSHnqtcfap {
	NSString *mkAXngTyht = @"EtVdgjaUfpksroHNlmMOZcdaoMvDDgBxujnbkBQgCzEJDeYxASwMybVBjKormQmvPSNlweGJqKOmQkaJETbMABCueOKURTZgXjGjOxRBtfV";
	return mkAXngTyht;
}

+ (nonnull NSArray *)mwjraoWXdabg :(nonnull UIImage *)nzpvVfqZpEiqOBy :(nonnull UIImage *)dgIofOhqvzAediEIOTc :(nonnull NSDictionary *)zzjrQoecTwgobkKMSIP {
	NSArray *SgansUHzMwlXf = @[
		@"rGRgAJmJMTwCyzTzZbIvgiuCTSXWRSDGggOxCCyfXOTaRyFJKUJYXlSmjqgsVcqKmusRlJcVAuOTWfmfLxDLqbmyXgmrDRRBHbGLoYLtlAQ",
		@"ExspOYIIyXymnHyvtnwfsuwToKjxsOxrnpLSBBDIhTUrbJMEBwgsuBjPcOgNPaQKVQWFxnkaNQZxJkBeSCLSUoYMCUJQvWQzGWIc",
		@"gLQkTLmRQooykACDAmaWZbJXlTreiFfUKjaSBDnFlMKaHUbJgdCOBDnrQRYNlmykGkQZsUkBpKPMElZKyjGZfMgKKOUKFkeVkoGFCiJxvBJDMvYrdsvIQoDILvsuTIqbaAbSJvpDeygdXgRmGt",
		@"eUukwfcFhhOZmgSoUzGdMMmXgtAneNfgdxZHirqvFLackMAZUHxMMqZtgFoTuPAzPjwErhuYcBnrEONrAxsiXdaQEBYxZAotlpoyLmN",
		@"BFrwTLJzDAToFSIxOXMzkMdLCOPyBBXBmRVxqjdBuGExMPNByzDjPOXiPmrMfWicbgwyEWBYsMSCddLtjSFvUcxcEgaGoVrzIyuDqHBrrFmuWiVLNzmRXNPJpZQjnfJyeC",
		@"ArFgAxwvSzzMoKUNLLjuYTLeokMLaqsmjxLYIQwTVPGdAKAAeBCjVHfmgEcCsxHjFnMufPpwMURtUPpHULnzOjYGfeRsgEWeUIKlAdC",
		@"BaWGYEpBVsFPqeXiiZGXbjlXTVjNdFNKmhIKFwpVLRXyyTovXpJCunqQjKkzsBavWNUqbyUfUUnosOwQMCxsJfusdNasQTWAVqjuHnwgxjXxuCNDHUMfQubI",
		@"SMLjoMttRchWvfSRzHBeOuzjbjxHayBtuhQslHZppUDGZTXRczvqCgmxCEoUuuhYldtvSfVqqucILfDohrxtmBYonDhmMqEXdaPktaWfsBjWCk",
		@"lagqRSNslPPcizvOUiyoNdWcLyyLINBAvSXNUsULmxQwbarrSffUSWKJloPVduMPEytzhmRJnbwNaLKyPIPkeivzNoAfxzDNHTXShrcdVHSAgAREpMYLUCseMkLvbywZaRQBfzdBIltGuReoLKxop",
		@"fJktjUwACNGDjlfSNWfOKNfDTUsHadjfjRuxyZqVYUarsYLLqlYwsFnbuanUNGjxvJzMIfEVwRQEhJreAAblJDluRKbvRYhJyVTEgSzyYSDxOOMHawKSsbJWvSbf",
		@"MrXYpllfaIyuxIIOjhVqKrkTpreFFpkMhfXAjrEzTHfCyKsuXclMpDUtgkAlBKxfgRoyJfbbUerrGbQMenegSoBlyPrNyuRJkOwXPvyglbnzuUcuNrNAQIUsPxccYroqYkiH",
		@"fzBhgRFsjlNyJdiaQBugDCSDmIOfelXXDEiNSHFoTuKbBByjXdHclpAXYFZYpSJmylLFNBjsmHqlmORlKSZbOBEENkjcEtqByVCuHdqVkomXtYqPFKrqbUsBrZGfdFliRQpn",
		@"oRQntDBkKZDmkrFPKQsGiNQZxDpGrhIaiGZpjMvJskdwIHvBCPDwFBxRebsOFhvqGblxoqUXAAenHVqXrTfaWITIaPKSCUseeQKCqEwzjHsljfwZCHt",
		@"dklcCPqPwcjRdRURgfynFpydXYeRJnTkILRYJbqAlLJaaYEznqZpQfpXAcQdwaMVbpGXAgrZEBgKrssnyoDCYepElILzXLsjsVtviIJstOivFqVZlvbjnmScycyONYVslTgUEBdppWZXomDqBr",
		@"XLBZNBLibOgijVUQBLtpxxkvPensXEsDSQmTRCcbNYPmuHnDyHWfzQQPQxyAatPVgcAbVzPsUCKaZwwuZaZUDEAbmBGicMnRPcgFFkFctqbDOCxpwfQBc",
		@"guXFIahpokSEoVPnJwRbUOCdCknUCtDcmPqbtGptSvvpREMSuXAHiRhsIyEBusqJLVwNTtqtHuLNfKwEJOTDErWrtGyQfrqDCgnRxbNmPXEDdqsSmNJfbbAnrgTrHeHJRGeNOoThqOYhvb",
		@"JfXUVGGqOLIeeUvvpHCGJiOlzIwaSuZTrBbsMqwiTMbaAQIPGHFRmqbdOTYwuDVaxgutyGNsSiTWgcieTLykCjOnJqdZbYmfaSAtwGfFHSvknWUJZsqLbNaNngaAtrDZyAhDmRbfzOaFvznKKfQH",
		@"bSVssAuynCsATJIDslCgrRuyvOCwkCTQieyGxwUiZUJqKswoAHOTADJnvzvpKYnClSUUlgNENCAVvQZyqmUqSXluUHrSQZUTgjntKivLRuSjGJmHpkYvteCewTnSuDYLdZtDfCQhHeMRTzfbq",
		@"jsDUvnrTgxBxTXRuXYDvnwDEhitDSJpsESvOqVsejBebRizOcqybavDMHpqgGjWnXJlsMrdTWYrxKPofURJSUsTJknaIAqGNieHEiwSlXuYxbWsHpQMtdEpAJwQSSNOlhJdpWIgdWddtvGv",
	];
	return SgansUHzMwlXf;
}

+ (nonnull NSArray *)yCAhzcxAvAETonUDIoD :(nonnull NSDictionary *)KNDtEcIvUgsjBcA {
	NSArray *szLMoZPGQcfBuuRGH = @[
		@"nYvQqQQrYLvofLCXJtzlcpmESTyAlxmZMzQdOJnNqwbtGgBgxqTyIsALYIGICuPqarEBDdZeaqJGSeYEJuKoTtWysbLwkqXeVtRaFgBaDOFhxcnbFWcXMsn",
		@"xZwniYoQvyyWPXcBJZRcDzDbaBPeiephMSzdUTSjKFnqYeoWlvKihIYkwjobBFPFtfjZyFvoyJIuDTAunQJfrXVhshkiAPcoyILrWcqrJONtaBrrgzuBAoWIttPkn",
		@"TknQnyVaMUekbsRYoPyyGEKKHXEKhWBsMbyHoFvvwAgjcovmdviGRhQRkvCjgwnSJzxZYmswVsSoiTnlZJGbMdACOeGxBOhhIbTJJYRMpQbmjyvWmq",
		@"NWXgDOlPtiTcstWpZYzMpbzIQluQXpnmtdfJElbQvFmVpuneXDfVFJzRjPSARlPpgvKPzzEnfPeysVWfOUcKgjQrmdRppthTnNdqmPUkydsaen",
		@"sngXlEphOnaMhXRMbRNSynBaaAHpvmYwBKCXHLLaDiVbtsWjvLrHXTNriWZurBGcDwxPMgktZnFpBtoVSGpvrlTRAclLaLQdpoiZxcMrlXfJRpsWnhEcPXhsXYrsuHAQhD",
		@"ZvUQEDuSIVMJFmXXtSEnzfOkaDsLShHXPVPhCvBiNJArCNwQBgnSVQGHyIOvDwGsnghtoHuRMeJIehXCSqUlHpWWsRnhPnXFDplfc",
		@"cUXmUvhqqXUYBreZLFWJMnARkBgnkSvxBnkIzqrSfTRBvZInyjVXqzJIjiObbFPWJJAcoFThhjNUALrOshxdjefcJVDChgeRucLLPdHbGXu",
		@"fyOzrVNFgTXgIdLYZqDwrUymnpcJcXDaSpgDihTOeAeFLavNkjTzdjaDosuZdfDVlIzOlfadaQzlHiSuosrbOKGWKbLOzyMHkKjflUQITEJRtiYdXhQfnhrB",
		@"UqMokBAqdeuhVvbzPWpbKBwzpcAGwMsuvGRaXsjHIETJfgxzeBgLrCvgOFyzBeQosYnIlsLCjhCDyjZECNogbYXtFoVCABDjVOvbeOdTKYBoiznooR",
		@"TdYOYblJJUToGpcUBhucFecTpUCAFkCyoobqitMWUdJNClIGOqbpmKpUMXYZHNvDkiFxOREWvxjytQFOeswxRJpUdjvljALoghChjN",
		@"UwgnPSeZBuOsWaAEIakdGhyAxLXJUWvNKLyRBdOEnToWEChHkRoIIYxSyGvLXOAYShyrXazuozdYgpJcqwKBZAuGZoSRLIZUUcDHVMQtZszGxJUmkdulSIcSGXraE",
		@"nlfPdJuwmmoApqWdgiqOQMMKEympHAYJqPvXjyKIbARUDkMPYvkFQozsgyKAxYSEdgNnuhYlISPPlNzbAqOVDadZlHqRyjCZVWGwW",
		@"zQJOfJdjlnLbNaNbDiDfPnSzaFlFvLAviYiYzXgrpLBqQyCtnjWyoKWhnDsEGZjHPiAdIxVCCfgHWzriJwJURvILLSmWuBRBPKShbMfcUogDWwRyNVbGkVAWPKExmVaMJPVPNTMD",
		@"wNjILEYxBITfPTlWxHqXGJcWuBAhcvoBAfiDVSGFKSNuCAvGHjnWqFJSQFPGPbctxtkKShfslEvjAOUMvQzyAupAJNjBhNqreVABHAHAQsJbBgvlsCdsY",
		@"UuIZFxZFlOCBEiDpuivRzGNHEZMtFQPcHjwODzgEsFTTNAhAKVpuFTFFIASoeBRxjSnLhVyWnVLwSAnxZiLcNMaCfvpFrsDWpsnHXWbbstvyUsSjXoTaStvkhwKWlRgkdMhDRcEwJXCeT",
		@"WDjFQVlbHNEiGSXoReTXMmZDqNGIljehmezmgmOOccRjSuZQdOXHfztHNJBqcMjUmMtkxvYGXOneEQBtbnamwutBKalVztVLiytcuTqeyVKCfroiDbmkZcdPc",
		@"FKRTLwCgRNyvPAucniIbZXrtxGfZFLcOOgaERELLnKIcLbcvERGLSCcYovIlfBXUZkmHEpqAHUGfqqSXRRXCqEZOWUcyVZoYcqRPCBkojwLaLaPAkLPGl",
		@"VNibSSjMIaODppPpGGttpSTFulUfLxBziSemokKJWKlSQtkZrvYxVNnOQoSNWfnGEwzpVcrgGhqOTpGiRljZEiHjyrdcjQJLezYosVcTJnFVTTBtbrqiQHTEMumGShmdCMLUKQ",
	];
	return szLMoZPGQcfBuuRGH;
}

- (nonnull NSString *)EyIRWknlJtJeuxA :(nonnull NSArray *)gVPXmETpDGQcMu :(nonnull NSDictionary *)mMGIFCUDoqaJfTqcj :(nonnull NSData *)YTVEWaoCFInMQjhJ {
	NSString *uKcYtSkaSKbq = @"okMbZTHGjiIjZXWZQrIeNbUMeXakZyCyzMHSavRLhpdowSDgnIfqgMyDrTvxKzdMgSLfyzdAcPyoTExCkEwCleGFvEISEvlECCGOEsGJpnDD";
	return uKcYtSkaSKbq;
}

- (nonnull NSString *)ffPkjuOLzpKrf :(nonnull NSData *)oYgYGJbXXpbF {
	NSString *goRklzNckxoZs = @"yYuEMChYkVzwyKWLjfeYmoeezxxrtdHNlQuBvlRKypNurFpnzCEEUhqpzjwvXtfYQZxPSFhUYmJLuoQlBAGpWDHSQWPPREbyWSfBIenVM";
	return goRklzNckxoZs;
}

- (nonnull NSString *)ZONJTiVqrFFx :(nonnull NSDictionary *)mFkJSmjHcxQPUxau {
	NSString *SjwbpvKOJefDPEz = @"jeUrYVKciEXYAByehnyIHWKrlWxyxMLBUnthIiYkQKyYOsqhFcFYtyzgavjqWneqwPxScjkflcAVfTsmKyOcnxxjTKJWciTuQUdpToIlpsieFtRSiuGDbEhCqQSxfoiWdJEyvwFt";
	return SjwbpvKOJefDPEz;
}

+ (nonnull NSString *)oxNzdOHSPGtmmAFVL :(nonnull UIImage *)FhQGwPZxiW {
	NSString *BdbwvmFBSiFrwX = @"mXKXCFdqlnPmEkBUeReXMJxToQNggVFtHZxnZdVpOSZVEgQBKPOitCWbxxcVrFLbHKzVuUycSBeZPipIlinltFfxMDSZFIQOhWsZWsVEDMOGmVORXWSwSHfmwETDkbfFuFFpajlPSkfJzI";
	return BdbwvmFBSiFrwX;
}

- (nonnull UIImage *)sZIcACwwNkeV :(nonnull NSData *)JfgHZvYPuXj :(nonnull NSArray *)KGNOYkzsZGcrNcIuFi :(nonnull UIImage *)HkgivGylHm {
	NSData *nirYnvmGwUwzi = [@"WlmPrqUtRHQXdGmXjapOULdkBoOSeIcAzzErhvQfumUYhIRfkZQcrqhjfbENlFOXJWestZXUHmzapyvMvXGAoSLMmLPckLLwpKEYQSyevQINGuyiDoyyrxWpa" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ASYlVhGERDoEhuVaY = [UIImage imageWithData:nirYnvmGwUwzi];
	ASYlVhGERDoEhuVaY = [UIImage imageNamed:@"WAiebHjEAXIRzamoZrxXLqMbhHzHzujmhBjyZzOpSZZEFRfFYRwHWeLyjziFhUvjIhcuyYDnXtZyUmYhcdaNnngGPyJlvQXCAunwSklGQeoEtjoTJCUYkgJCrEelEma"];
	return ASYlVhGERDoEhuVaY;
}

+ (nonnull NSDictionary *)mRttuWTLmlHcGB :(nonnull NSDictionary *)tlLKOXlBhZbnw :(nonnull NSData *)bfNIvyNeHiQLrXqhh :(nonnull NSData *)xdAQGufQMsbAuo {
	NSDictionary *DbBwWyjbSYCa = @{
		@"OkSsvjlVKdVr": @"KhsVkljwBgksPuXhOqhqzhCUukwWiFOucWEOdrPNXEsxuaNNmEpaaoyGvtjwSWOohiDWAfmwUdtMrzsWtzlyiVgjnTvdcBxUHNLZNEhBTdsLYgClTBofukkayKkiGxQdxnGjTPV",
		@"gLLNrbvVpdimkEagnD": @"qWqPajICanJcBfJQjVbVSOUZfuEKvwxgTTnWqraNNKGiYgDIzPHkksEkywCONvdBBiconNcOjXvLtAAcTnpoHsbZiLCwBelHGioiGZZfhAjjiiyyvwhSiuxiQem",
		@"RkZYyGqwwKwFeL": @"nFpRLngzEJgGASUNEPghSuLZxxlKfkNbNDwMvBbxhxKesiCwWOaOCZWbRhdyGxevDeJWtrQLNzBtQifmsZVqNykPyvmidhxLUGsyaALViJlTJHcvqXJoMonpyIFeTYZCkJnfTJXYirOGpizjkr",
		@"JXWXJgHbhUzGfXounp": @"oKqViTnGjxJWLMpBMGSekbCoTCYGgGyBkynSIDbruUlkVIuWSLbKuPUFFdRmjVvLYWRdAHkrPsXYAZKgQdYQZrrYDgRprJNaVyxaMVqOYFxfKUsjjAhKZOOJskrwLvx",
		@"XoXrmFfgBfsTfF": @"vVuSOsqJRLddehedZUQNnDYBURyekRINWISgdpSupqLVdbdZwTDWlLLWoxpgPAIkLtYbvYpnOoKMhXHPKvFGNMFpatweiDGjxqSXpKrpCJbOgvUqjVWVHpxvEafEfUgbvHOHWigdYvRBwKmgZJp",
		@"aHHXntSatYPJxlGQ": @"GZUiKJRjBPzwGvwClSPvmDlzJCJJrLIGXFBRgvqWJfaexCeeuWGZuzPltJqHxLXOjOEhExgCxKHAVtMhOzledkXwevAhhqtlAgqMnfpujHUh",
		@"oLUZOTJJuRE": @"PxqIGlJlQxoBYAnINoCxfhqSQpBYgoxHHJfXJDhqdyyKBUtbtFYyaZMItEjflQZcTRicApIwLxcYuCTHJmrpBEUeeMyeWoGGZHBXqWCpbyEwEZyvrPFoRfMPNnjgTdAUAAlCjXth",
		@"EnxbndpbvR": @"XuUCcKpDZuwDZItnFUTLxZVxrzERqadLkBYBlZKQCbLaRFxcxnHMeegxZZQxosqorudcDaXVELacxFPbarhfgnFpDUKNyOjhThCrKeVcACrPxmcTslgiHnKJbaauDFe",
		@"GHSpRIdFkL": @"uzoDkxbIKgMmHPFhghcDmkNnNOVSDVmbEtwLZaewCEeGexYozkxRjygRDSYBWOcmVEPxeEySiQaToNRMwMkxzEIAmrAZjSqMJWFaVqmIXIPDWaDfISLrcOYIUplHwyXxOacCPg",
		@"HvFsIJlOuvK": @"DMhCIqemDhsqCFkIFAyfrrpulJcuYshnlKkEFgflXHJRMCKiQmnQaVUPVTSiIXwQSMTsjuzhTMGLOPYEaipRodqNEHbKtrKbTVBdUpAEnxRBFuIOmgwdqHxIsS",
		@"WGCQGKMdxjS": @"kvcchyEYEpjdAwfiZzyxDirUXsrNIpevJXzwtojOqOgdOKcOGHyjddTCOdfAXUczPJQpIKWHKqreVdqbxJIvIztLtdrcJcTxHPMhnyvMgY",
		@"IznnVgFbnL": @"cBfluxTjrqqusqylPfRzIIHIHdySxfzuqoeenmXOthBayHrWakGEXYgpVSiWOaxNySdnzdiENJVmAPYgdxZGvCqTsQZwnNrEftMNCudpPmQ",
		@"UdPxmoxZapRtxlZg": @"YApGkLVnUaieevQgeXJtouLiKyugFHqptFqParjWimXfKPlTyJXYUFkHMvWUTIbosQvSPPEmonvvToVNaLOzfGXZLUYGhLHkbiRcIGWJhCPORzRXayrAqanDskmz",
		@"yEDLFXAFfI": @"gWESclmLAuoZGqRSymlqxMOkuBhpdDyNjOBpBnatrBbnTuXJoFehTKewClZelYraVpEugRoWszRPjJkmDZrexEHtVFzMPYDjLgQPTLIGsiQr",
		@"TgonAevlYmFjIeoGwhA": @"OYueGdncfIkfGwlXVkxoUtQZELeILVNWHoQHcNmFMjnULtmjlRjOgLNGrrAuSmRdlzEVAhIAlvakzPSVNgYUafUZkuZDhxjsbYIQnUTuldMqyPCkwbakFuDetgjKUZnv",
		@"EVDGfHyTtatUaRqF": @"GAyhbFbstgzhAeJScvtHXzvIPMDAVczCdlXQcexcWbNsLMrDIDqZRvZVjMYCsxCysRlhvUgDJrABzAPcwCYlCSgzMQGGDlMmfcKafqJPmnKqXjErNXzuDPUamJnRZDHNXNIxKM",
	};
	return DbBwWyjbSYCa;
}

- (nonnull NSArray *)incKrcJjgHIZU :(nonnull NSString *)HmdZFceHNIIXnzkuJ {
	NSArray *uGyvRGgXmesCTztk = @[
		@"WLbRUXkEySerVdIWtfpZykuhlTrBkhJPsFWklbAHuXAHiflsTbiPacUPVhucWHWzuPVobOdZbjLJsLYeGClSLnKnMYdeCaysGZsyxkmfAMXz",
		@"WhIIPzoYfYTuifaaJlBPBDfyGIVzpcalgCTWmzyGgPFgWXzAnzBCdhdbkwyYOZiGWuRYvKcjeoObZVytkviZFVccjNTQnnKHgggNiSTQHKaZBbLFWoWGaOLIGTndtsrabqIDeLryYJqyzl",
		@"pLACukiPPIPUljtDwBRXcuXfqTLeALtPuBcXIjVexXseCJyeBhZkMlMuIwfieSHMdxDgsSDaFoIXWqDOKqrDWMlzWovTMQgwITgLhFoVvCPcDmrgathLHoUYItxdLUyFrkSbzU",
		@"qNnIEfoeLqGZARAELoEMxptECiQFgbUtgIoTdrOQddYZYtPzBryAcSclanfjpDCNIpOnMJIsZnGhNUNkTMquOHHVHeihVuwMWcSxm",
		@"MwKeZsNbcEhaIAIhSKBpLtsVvWmhtaOATfNRAPfOAQENPIMkRTPvAYZffBDSXtQsDyxyRaPPSUVwhIeAHqABymdyHCAsFfZolzqlE",
		@"ElmynTvgAGjIQTZHtPPcbgzemVKUAJkfVFuCLIrIqVJcNNoNNUUbNoZtwAtuKTgIYIvDqNKcSDMGIwjZqdFZtkTVzxqFoQtbiRFYyswpAcIiOnRIMCePgwWYcEXXlTODVWYSp",
		@"oBFkcikqiwZQZmLsEqKckflPDQAtGLTupiaukBFrYIvyncQojorlDllFOSgDuAfGxoDVzSbFypuCKBOvEWFrgQCwqXlNpzxIihGqCArFyLqavDMqHoBiNRyvRPZGAnfJMQEBSKFLwRyIsz",
		@"DQoSparXkFprjUNWyPKBmGDYuCglRGRJSLjrjqHUiJzkxXUdAcOwKhtiOtCFOiXReLVBnIRhWAuabLNVMyYbxmheCjDMEFIUoMllYWfZFbOSDMMeMusBmLXgTHABgjbwroDgFFyewiulOPinu",
		@"DydEFoVWNPtTjiedxIBDZMyvjZQcNvUmZakTMtLvwZBfdNMTYhlsOVLKItLuufssULVHOwfMLatpJeFylRgnpwZzVZdxPxKIPtKzECJ",
		@"SbVQkeRcDrAqfotIJlnIDXqjNHacqlPoCvpGvlevojfjqMwmTVfcYzukFWkYkZOvInZNLanaedGhSkIoozKBefOJEWQXQZImOEcNFpwHVIiJPaIjBtJidWFnrQvqaQcgar",
		@"TWLnmePpIWaCYWyERQkFQWNlOEhSsZtMHkVvgHiluAQhFNaiDFjCNeeJMSwmIbVYzXDzKCKrGpzmeGEpCWFJCUafTSztaMjRhWYagBuAsCRzC",
		@"OBrAcNQBwkNVmgehWigbzfzbYZOdgsTgJMYtGnWMjdXVwIgmYlClGzyEJCIteIPOgMtpLUfQhFlXiaMOrgweMOKEYSodtyJFVazoCUCoWeFIZyHKKLk",
		@"SGMWmCiKRpkKQLNmeXvyVFoKzMbHYHfVaKUMKbOTUMivbKnZPKKuSZyLddMfBaBBwqqegIWdmUZFXBtRMdowWHSCphqkkxBaxgwCLLAvDZHcCKOOARY",
		@"WJthwRzllufMkNrXeLnPOlewckakjOcBnxnPkDeaXVBqejoWhIuRjkscqTEZtYuGKyuezHQDoycxVdlPVarMXhekKQlalkzlCCFYQIDLpkjrUZXhEiuLhxdsPHkHvUtsJLESYqQVaMkmUfJdH",
	];
	return uGyvRGgXmesCTztk;
}

+ (nonnull NSData *)WkfPuSnvttbHEMXxcw :(nonnull UIImage *)gNBBTfIeUtbp {
	NSData *CmiNsZRXUdpSzPB = [@"DkjNiuuuTfyvDRHFlEfZvOEQkejaUVOHdbAawJUHfrTHzsqUOavOEQZdhMLtVQhwkVOFxOosULyCLgWehIzHAzgykMHWwJixYhXHOyCuNFkIIvCyWYfVYdYsAghVCmtySxpwtUzx" dataUsingEncoding:NSUTF8StringEncoding];
	return CmiNsZRXUdpSzPB;
}

- (nonnull NSString *)FbHinpZmgKgH :(nonnull UIImage *)NxmjBZykrHjKlfAaSd {
	NSString *WSDbVYTeKXciJviwxpx = @"eSPWQZeykwyJcLMLSVCzoXuoPgWnXrYOmEBZQjHtSxYIvnScFBSWPfVVDQxZPIMCONiBDCWpwIEtmSvXnjBgYjXtZysQwpZrvRJrjGBiWEDIzHQHJqreUIKOUiKUdzrkMMcBnC";
	return WSDbVYTeKXciJviwxpx;
}

- (nonnull NSDictionary *)XNuDszsqlOnteGYx :(nonnull NSData *)gVSDsZYkNTjdEGVrEm {
	NSDictionary *XCfXXIyizkOCWHEmRz = @{
		@"MSCGvghgBLIoBu": @"rkaXFMQMryvBmsVLLcUEOoVNRlDIAbFPwWRnEdDicZkYszrkqAszplEygtgDwyIqFIfAEZRtfPpMAhTBhVdXaSgDpVltbZlzfiHDnRHnllzoQxRDNuXKlfr",
		@"KdybqCoTmB": @"ZSzZSMKAqEAKZLKuiajLgAqGdWEvjXZZROZTolgjVjxkGJIiBwORYuwIcxhpqLRsONXtuPXwfSFnSdepAuPtnDcFnGfBQpKqQwbShljoGGLnCObnXmuSjTZw",
		@"XPOTTwaBenHBEgHi": @"QlJyENPgyNRdmyCgHCgANOvBLHUxOfzoSNGwSfJNElrHYGZxwOrSltImxqYgKPCchsMBYlklxOCcXeOKmSrxmerILvuOqyJnlCGJo",
		@"BbHeaguPpijL": @"iMYqVHrudvUjluYueXofBtgPkMVrqmnUkyVRZqnpxOOVmLiHEaOopYvRjIIBwJgaeCweyQqKvNzltmalWoAeuKaLDJCEHuHthXVZmTuncakpUYZkjtsgLnEpfsgpcXBrepbEDtxLjkWuDIPl",
		@"JlEWzeYpGZBHYtlqQk": @"GavpaCtcOqCMfjJvQktWemHlQxbtSYYSaRxCHCSwlmfouLTLRodZMIZFIVlWihZqdnBQmbTqwqoufFGxmxyuavcYHEYqCruDOZxfmdUkmRAQ",
		@"cOcAoJuMTvg": @"bdscUJAJglFIHdbCZenwGTuSxEbBTRuuZNrHETgzyZzgzHMxNoqDFWCRDpdfmOgnCsvUrYxGVsQFkqstWUPAxDfDxuBUFyIBByRuJbFPZbIuunCpulQLmehkGSgIpoeJvw",
		@"wPjgdOXUBtvsyhg": @"pmdGMnOwTVrDIlNJlwMZhLywyUAaPiLOvXRIgAQKCeRBHixecboqWtTtnYoeogzWAmvrNComUcEnmJzZBAENWrfQjiAwDmJsISsIdLVybNBIWcUjTTeYbHqOqRPmVFEjDbhpmyUpduusZh",
		@"xNIvfsnpJk": @"LVBkIanlfvcULXdjjvEeBNiDQwaEgGsLHnsuzNxzbtRGdakntsTNGcPkUgVLRLEZmweVgNQOFIlkHvynNrhkXAJObBmGPyzKfIPAlCsFliOudBNAthEnjyoaDbEyeImHkcPICSFGlmbagAmKB",
		@"LxqhGOsWDM": @"GzGtcXplUtvJuDFHvhLFwPUAJVXPiIqkkgXHyvIzIIdoVFxzpFAMVVvmLxFsLeEwcjkKYXWbFNnHnfvDMyuVJDVlzJRXvMZZNEZP",
		@"bUeaheGtHx": @"PxyUwEtilWDpFqFRBTWiNoMfUfpDIONmWvBREDrpLxOpRozRXwRVIXfIATMaHirfgHvCgYfOqmjjkGUoNXRUDHRiqxgBtycWbviKaCuBpAzbxRURbNuB",
		@"HfsMTJXnbIjGQmq": @"hlUCugFXUTNuXkdgfQcwHISkMzgQotWwclsWRjTbkCGBgDRPWtysaJxphqtfLhsArhFRwhpFgrymHIpARkGATKRRqPYeOMAmuizMaGdMDsTmtuOvh",
		@"CnjTfgqkgVkhv": @"CxhmRHyfieEvGozHfZJUlicRZWPslPpgQTycbdjNhzdXeENSBohfDihGxAhoAvDASlJOiRipYPqWWSNJPvxEIUCJGrmXzhVLxOLvKKyXLzWqqzgDEmh",
	};
	return XCfXXIyizkOCWHEmRz;
}

+ (nonnull NSArray *)vIvRUfpoOFUXlNQ :(nonnull NSString *)xvqrDIWeCpPYoR {
	NSArray *mhYbzAOefKfPOYy = @[
		@"axwhhujfQfIHxnOtVbbmaMVMKzNJvnKEyfaNbRwCeueeVWuLMdoUskySyCDnZeuGzRFqtzOymErEdJzxzBSqFLfgipoBWZIQsIXhtswSgWZ",
		@"UqLDymmuanayRsFcEVlDODQWrYTQSIwLFRvJsfjhTqLRnicJLavxcslKnAzFkuBDoGlRlghQdCwZIXnbwmQItaWhxEzYajbhtwFQeBakf",
		@"GKGCUQaSKjPewymQcUJZEpNaxRxiUZYIpxLmoQliDNnQxzhTxnAuMDhwLyxGbsxBrrzlJFDMybVFXphmMzlNaaxPfkHFxpWuovPyIpgwnVWGEpjIRPEdjLTMggZjkWcsykKQVLMNSfwCCCkos",
		@"PgOCERvLiEhxuIIbIcbzBXmxoiSQaPnJINXBnQGULpdRGpmsEivHIzPShrkbYlJreAJJCIDOYsSsBjMaNMFLgnxjFTOEosExScngnrJmfXdUkquYhYOVLWie",
		@"ZevHkedqtvzmQUopZERkWrWWIiZngwJYfSDItuhWZVtriljaDNdQwXXOFUEeNxbKfbRuduxgQlxBrOsNMICXnsbTwWnbGyoKJDZQSXyoKooRMvFdOIGMRqZFagRcoRtmBQlQnVkpavrW",
		@"CTPZcszyGdpwPIwSlPxBFHkNVNGYUUcLDFIIkgTXfSNDIAZFjOeQCmwAtExvfcaXJTUjzhfdfONACQxGypKoaMrVXTbUUkeOwntzpChimGpvXfqD",
		@"zFmiRzTnSQpgPiFVUBgEYDOQSSjsUpxrDoBSkejHjHhUOaFypyZYKtYJkgsPKXnoKeiYstXUptwRdlgaJKcFCLqAgoLhpUOuoCIYFfuaphEpMjLrEgDn",
		@"YbvzuTEPkTdlDqsxQSAQbmfmzpcekdvEYHWJOwZBIWPPUFCTfhheSThHUqWwHZRMEnfnECHoNrkxlrwBDsoQxfzeQAYebTbyZqApurycMJoyQzBPSdewWApWFBfxJb",
		@"onGZEqsvuFPqSwONdtzvQPzkvwZfidCznIcnbdmhFRvEZdRZUysiiDtLJXaKGhAXEVoDvGYDfCGTPvFvBatusagiueZxNXwyIdTYRIPFGiIRojEikxgFKbHYceNSfAyzAaDoPTJBNM",
		@"wKTzHCPuprWcuPDQbESYerHQcCxUXqicAyEAaAxoCXcTMvexZVYpFPfylEsRpKZMckEqKItSuyQjwkEdCUTQGgmLOIMxsPfdNGySZoLJpao",
		@"yGjEMjCfBBySrAWdDdCHmecmFOLcRqgRsHUFdmEaXhGWpjAJCygNdYXJtTWaguAjUtZhfSnnOYybZMApzOxhhjzFCwJmrGonNzfxWJakokIopSHtydFJroogVINsHpdSYUBpppZjIDi",
		@"ifXpwAXuTxqMcDczMRTpmToONxxqdTzpMzjNnXNmNAoZsEdBAciEXZCXuDuAJKcHcruIgqIMYrVBhXZUAuBnaNhxlvXkHtZaObAblwdLNKBPGLmyv",
		@"vvSLDaafmkvzsNUTSJkxppOoTVukGtBxmYHQyKXUDoOEKkxSmaiZnrGtFCVfbwkoDUarnGIyKMtmUaULaPfXHBDhradwQvZuByYBKGAPTIEsgEVeAGxstTZjFdLHjyAsKOfJbyxwrNoZN",
		@"QpyTpYbbdLOfnqcxlZeoxxurGcFtPKRSrMwGTQIcIRJoCkuoDMILvtttvkvaZNYmvAjxHrdjwrMrWyfifVUIQhArsMYLRFFUgZXncbB",
	];
	return mhYbzAOefKfPOYy;
}

+ (nonnull UIImage *)FnmfVgMMuVFqrxz :(nonnull NSData *)udTlqTHxduNxAvW :(nonnull NSDictionary *)gDBQoZxlDVlUAV :(nonnull NSArray *)rJtfaTNxLb {
	NSData *GaCHQCWLJkJn = [@"HyqjoLkFGnIqvlAmFfNtSBSbmtTVKPJxjdFaeDQdPkHbuHDuRqwrmUiWwJAgYBwXmzIXgdkVoGKGYVeIPgmaKdkFkOQZngQqvCHmHusLRrrVwOikIHaBsfDDdvZWrU" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JkKEYwdQuzAYQKPkNEd = [UIImage imageWithData:GaCHQCWLJkJn];
	JkKEYwdQuzAYQKPkNEd = [UIImage imageNamed:@"RiMdCMdnjCJeUJkqnnwjwZHjAsldMnlWWDWbbpEzOQiEDhaVRjqQvakiiTOzxlaUDHkdENaVlIWWuNHMIUatFdDtPtAGdkihFIriYjEYRUhBlojjVsbnAtAHsAPdQDkX"];
	return JkKEYwdQuzAYQKPkNEd;
}

- (nonnull NSArray *)DFcgnRmyRkxgZv :(nonnull NSDictionary *)NRBxVBOYdcKE :(nonnull NSString *)PLnPTrcxBe {
	NSArray *DbLqElyQGnGTuf = @[
		@"vSqlINOuEUSEOoBRIDgcJcvxzKXtugZYkhxzyCOovZGxjxfqiPYfnUvKyqHWyhIhseWCcrvKjdPEfLjdKfNPbjCPapLwBWuchyfCqHVqHyVBJxr",
		@"mVFYkJZjQMzuvzkNhalIwFNxbgzdGMuGgOcPCIzVxWBECsLaSYhJyxPzOtVvEoCSoCPSDGxMElbNlzquGefumwgNzPkDIdNLtslRFoaVFPtyFaDGghhMZpQcxOQXwmlTafpZbaikxcTGZzzNM",
		@"WnrCXjsVkXKAWZkxaUtiOXDsQKCfwmAMrRERzCUBbrVwPygslyFHXDGQYIzLElZTmGLYXoFGtyufPEIsFWiTkDcgyJvMbqWPXLUD",
		@"zaRbgEAUPpKQSAZFrGgHsdrbBNnxoqsNdYsaXDJBkGSyJdWzHwqeYsRTtlEOBcSveowRYtokbjGYzKlUVeXigObETVTbptiiDRZcYUKUqdtnDuQOgdIqhWCUKbrFeerGGCwbsGVDGQvHyNUQM",
		@"ELcWPoaAPTvXyeAcxOzWWLFqpsskMWuHceMVUOaTkRagdCdZUdeMRJnJOUvYhAWJjEvcITHIetkpDoZGznlwBvVdtSZzRmTWxqrHcdLwuaESxlkPbIyuWJDofggUqYFSbYnfnDQ",
		@"WhkAVkYVaDzTIeGISptUNhoHkflDrkAOkRDjDVPeHUcxcNOEGUbwCXkrVVbixWEPkpTxvSrIGWkEQRtOTIRqKVNMvdBNBUTIoPCkGyNH",
		@"kYtrLucRCctPOkFJvzzjIxLxKkJgUQoBHlVMrDgkEWEhsYwhTXRemOWhaBgTMuRZnUxHbgeEEJAjmjCNqRXkkVnAoRaIazpmAIWoZnAuNrEsmabGopItN",
		@"tkQMPePAUTvttKIxLepllItUTEYPNXhLGvEkbvgUXQdmheSzdcLTFxWOWDVFYXXNGPGjuziiRidQCBuWYSTkWJOJqUPYGtMPtDVFlocoW",
		@"WoFpuJWrRcEzanAflOdCCkpYNEbhqsSZwRxVlAxwSPLkkMqQhUaAAOQriswwZnfdEgQFXAmmMkLvaQdpYCKwqQKPmDemcJLSMBPt",
		@"nucCKryrvSHXgqapLNjlbjIZajKQZIxGUUNnlOsmBvbFykYcJqoaLdLwCZBWgVCipKDVgiDQNBsXtMbqNfcHXkgrrZxhXWRDeCaqcOXwZqJ",
		@"AxChOQxxZGbvmLAQxUmJzXKZAealksXQWBStCyGvkCeAUcnzSdIkaCUUVhSLmpQklaCwFCvoYZDZFNOzSJGMKhAhPgCzPUcvPWWUefIWOZVpgwQdMEOrdrisgfrNzZybWQiGe",
		@"wgxYeGWNmEXEjnsRMTXzLUgPTcdofGbYZWSvgfKyLYrsyrVLIpaHnREubzOgiXxOzuYYCwzExJnPGIJZYdURUJSjtaOVWGadhSaPiXObvoOSRrLZMJJsgasw",
		@"CbPjqIXOPbbKBzwMOJJGERYHyTFFSkREXOuosauHPxncGxGahfOXbocgDfzfyzhgdhXGbwaTPUNNCxnsXtoiwYnkNWYNPxKnfPvnkL",
		@"bMUxtKrILQGWrmpUfCVZmGRzxRmqacurXbTiOYqzqfKvMBWOMzJWBajghBrqVMmTmbALTYodChSkpeOrNocmraYVgUcwYXLBwJCOEIqAvEsVHrBCBEFVqZUd",
		@"PdKguIVMdmVHgLsKBAOLYSZUSvYDNCWORduLaUEILaCFXgJAnQxueWTdRXPPONMXIAcooIrBfHYdKsclUmyGnEjoKKGvbhjJWYRcTWeTMzQVlDwuYAqojHnfnYXQiWJtPijDNfpXyXBPUFDq",
		@"GAPEtOlwnengqLDJpUKbRslnNpWpPDhCEdpOPjotbewYDaKlUaGGgsXQytKAmVDtLRJFooeizOrwOAOMEVqjwgabiXOHDCMsRwkEnmJwUPPdYOYFURYlQiHsAcFwVuNa",
		@"LXVPGfiNBbGAdhLZevglmcByqjCuiLkiLRcxUZLAgaxqzRYbVZCihdBhGDKRIEBWAHxvrrUSFKJGXNpXBEgiMbHYuKAYkjDjidyRcOhIKCGSoxalYSUcpAHqSHRt",
		@"PFaLPXfgQiatTqBotDKaofrtcoqLQtNWfYnpQjQhwDIMTQgQencztOAdnWwVehIwuBHsqrSsOxgXVfDqvMfwqkkCLTridCtgBZioDVFnOYvDGYXLYHjhVjzBnOUgGfcGAdj",
	];
	return DbLqElyQGnGTuf;
}

- (nonnull NSString *)BLHJvKwZTaPB :(nonnull NSArray *)GqGmwsmXoZdG {
	NSString *hxuNmJiRYVxBBVTQ = @"ObDTXacPSnUAJeuuoqJOoFpRWBwhXzfwFNrxsJxikiuDxhKWooYXUIJhRHGvlGpNSpmVFFNZiVGiHTTLkordIxSwCsbTyEHToQpmzmmqyPftdXrKPnrXzfyQJEPBbdiSj";
	return hxuNmJiRYVxBBVTQ;
}

+ (nonnull NSArray *)bnNnEgTIOKMoQtgoAjj :(nonnull UIImage *)sEIecLtCRCNJMLFa :(nonnull NSData *)YBzEcdzdUftLmiCbGon {
	NSArray *vsJKlfNhiRUFoe = @[
		@"lYxrcewYoOsABSAwcttgpzRkWlzyukcIUGYeAknCYEzSPyVFKGeaIehsNsxDenEKjFhSKxCYJkVLcJLtEnjNkXTYchVDhEpaTUrRmRymGIaKYQ",
		@"wHOHNtHijWJSYfrwQGaCovwDxZRLXkvwqGYDWYuqVBkuwltSooLsOyLKkyHDbwVNkYNtPevRvMsEvVFBAAkAyjcspcBLdLJJuWsPSUcyOGNsLVLTozMGtSLLnaETKXjDBnOL",
		@"zfnZulOsVFaldvceCbSYSzdnUFcWStfvYDyWuMPraTeZYPbXsfvOVhnyJtrqIVnRhMWNdXLPlvitJIeINUehRkUmcSkzsljGBwwwEKrluUIANLYXuyQCFHCyZk",
		@"vHIgrdItrOQNFlEavIraOVhkJKkDgLPZKAoOzEidGQDsEYFGMULMXvBAKAvPhqiChPLyLHBDjjwKSSHjHvktqLaTweZAefIWKkLDeFycHePwWuySXaGaKBfdyxEELRFLmXyHFhcG",
		@"oUsciBCXLOGEOcztweCsDYmKOqyLxRLfhJXGSXCxisoIyJkmDSwiZrwQicxzEGTBZyKepFuuNXlveffgiJSDpvayfJXCfFOGpYogXJiVHAWRmPDBAxrbRWdJjxGzejqU",
		@"JMYmmJCFjHAzBYfShXzpfipZfbEwxXGKOdYPMAFwrfBYnUBmxQLqvuGiTWhMVlTrBWihczXhDEqFNnFuAAHkqOXntSgAtvGfVggiUmHEQnGYniUUfMrgiN",
		@"vtigxPMcYGpKHdamRmlPOqysaifQqbaCDnfkZYGmncimnDtWseIqCZHcNIeEDSGkVRzQDNGCjvAgphbhjRjpXwYmZUefWPNRnQiGvrBgkJGprdLVrWIarsraXMUGFIqePHUzSv",
		@"XpSvyjLcCGhYOCbYIRAPxTxvikQhQsFdRZngwWWVrZEwWevEtsObmziDussZrWwOBzUxWbhAbYTDlqCTlRXzCHUwYHjPQbeoWLasGbBhkFKfNLOiVFXxDHBbiCSQcYVzTikYF",
		@"bWcrnzCuLBROGnDVwLETXqtXQcTTnXuuxHcSNQRfNmOmzXUanDfTnLQevsIwraSCZtZSgQmJaNzlpechmvhWIGQSlwtzppkmmqadbAwWcZnWQbAYmFWNskZkYLheSRmpzImDBjsZGBlIZ",
		@"FZMhxqWKnMOcbcSNdCAhGSTJOcvIVpfjkrfVKsEENfTuIkBvcoUpRNlBKlkYtnxaQuYdHogvxtKKILjyKobHpPzFObwtfwNVQKqMGVFfnXFkKlrUsGUIawMeKezB",
		@"aYqyiRLbSFKUmhohdukjaSSIsFXxFHejlamSOQeUESotSOCVyIfbblVWjIpDEyMsbKcyrhSzSJjNURKqogjyHPJxTmJrbhcojTnUcbNHZBNf",
	];
	return vsJKlfNhiRUFoe;
}

+ (nonnull NSData *)DjvnNJoZCZv :(nonnull NSDictionary *)zxuIwqxzwnUStS :(nonnull NSData *)vNjtwytJNrhwBkj {
	NSData *beiTcaOEYS = [@"ykGNWeTnjUXtFVgatvFNYRQclDkpwbFMCAJpgDWKprLEMUFvfBwslObRvYGEkowvhGvcVgTPauNCQVArOJOlZuAqUFGHIxoNOrWSbryVUxJVDPVfvj" dataUsingEncoding:NSUTF8StringEncoding];
	return beiTcaOEYS;
}

+ (nonnull NSString *)peOYBzGThHJmf :(nonnull NSData *)zzVsrXXoIbsE :(nonnull NSString *)GoRBYAhgniiTXp :(nonnull NSDictionary *)ckgzRuMOsQvtvsIu {
	NSString *coPjQjYfewSstX = @"XeRSvqYIhqdUPzDvPwqaUyokrNbzyTKeKIfzrAcViECyrdrlAmigBPYpYnQKQmBJwYLXjIyRkMKWoBUVymFsrBkgyThjqiDbDuChSzvJZPxoYfxmBAMXFcOLqhkKRWGKut";
	return coPjQjYfewSstX;
}

- (nonnull UIImage *)gfXEjMIhoIuWhlRVxaO :(nonnull UIImage *)PoRaOlqCtFCd :(nonnull NSArray *)bObruMiyhqXu :(nonnull NSString *)kUOtTvwpUZSA {
	NSData *ScFrNxjfWpLMDLPxQ = [@"aiJIfAuwLffMMxlOQwOGomluixbyUtmujzMWjbSlVSCPvrJjArCejvXqMbWnrhWdNfyUdmyJJJLSwgfStNCjqtskWvsPnHXqkhkUJoNnkIwecHlnitnxpdkqRphYhVwNtxejsKZg" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *okFxbxDBTypQyGb = [UIImage imageWithData:ScFrNxjfWpLMDLPxQ];
	okFxbxDBTypQyGb = [UIImage imageNamed:@"IYVkDyUVuPCYSADreZfkAZOevCAncPgyTxiKTMpMoQhWlAkiQBMHFdtTmWJxQPEevuaTwlrFKaLxdNyDjRTQXvzBFzxCOCAFzEutcwFVwidjjyhizOoEVDaFxT"];
	return okFxbxDBTypQyGb;
}

+ (nonnull NSString *)cTDCjrygLGQo :(nonnull UIImage *)ppvahqNUnhsZrMFwsmk :(nonnull NSArray *)IRdfRuHqZcgqJgp {
	NSString *rgqemnUVqUbdR = @"dkxsuOmAFqqjpIdkhJRwSsbiqinNgPtfTXlhzRdDmxeZdDVNGjnCJaMINmaDJnoMiOmqgsVgObyldVVvwRlUxLrnRsrBrfIbtwkkAThHa";
	return rgqemnUVqUbdR;
}

- (nonnull NSData *)TALqLopKiLpLejftA :(nonnull NSString *)mhayaJeyKPzoSAFZml :(nonnull UIImage *)wOpuIbMVthD :(nonnull NSData *)kJBtujJwarhi {
	NSData *UKMnTdcSgnLTn = [@"LcBRIofUuEmhxeQDEgpWSfgkfhphEmtnYsDVvMMpluOfXOsSnJySwJCMsmwsYeYDOdvBPpHtNXJMmCXjLTGNpMbxbRHLfVztDVNCNp" dataUsingEncoding:NSUTF8StringEncoding];
	return UKMnTdcSgnLTn;
}

- (nonnull NSString *)qEBjPHXyOXfCmfS :(nonnull UIImage *)TwCZjexkOFkd :(nonnull UIImage *)FWveyPXucoFB {
	NSString *rmEHHamEOtsMOmt = @"SvjxYLRfMrDSXWwAmajlbljhkpmkhFCdzrSSdouIJcKxDylNhsaceoQFMXVOnEsWxAylGWfeezWOAEAfnTfMfViPsCiGDRnqwbEdkECRKwQYRklViFHTsBXiR";
	return rmEHHamEOtsMOmt;
}

- (nonnull NSData *)GPXmbOIvTMH :(nonnull NSString *)eCuKtrvaWPgCAjq :(nonnull UIImage *)euzbIajGmCTuchopM {
	NSData *fxNXYgUcHh = [@"vtuZZRHqDFsWKscDiajeMzNdiwEgAjdhTLOOMEyZuNUQWsOFBCqOIceXmoHxcgqJlbFVATHjIflEglBuLCFMpmqSRMVxdoRSdxvqcqEDmFTOSBmTrLVZWCtaJWHzeNeCnTuJvQoEpsfKevFxY" dataUsingEncoding:NSUTF8StringEncoding];
	return fxNXYgUcHh;
}

+ (nonnull NSArray *)IcOulgYTvoyiK :(nonnull NSArray *)CktcvqZHCX {
	NSArray *sLpkfcKxRVPj = @[
		@"KpNlHusfAfMKRrsEuxnIgOFiGtrmkiSMpxAQAqCAOAXRLnAAPIIfLxtHRXESsccCZfdfflGKgCTTHTgJCBvDJQbezzlzSydqeLpUvXlycA",
		@"oXQlcRsvvVskomQGoCGXUDtrzupyotJmDrIocoMGrrpzzDrYJSMwgjtIrFJoJdSAJOvDtFqtiFPDHjrIgQMPaSqsxLtAaYbKCLsFoKVhRVRPVHbZEEAfjLwk",
		@"ztBBaghoWnTXtChCaHMWrHfKobvRhpjxOdMhwBfDjwbrJdgmNyPqCDYxsNbAFNEYwSBNCfTidhuFMOVRUGecItSXgcPQdmqikhLpkzriprrBRsRMgdRhqxtxtbIGFJhdDblMNiclxsaJNL",
		@"TnkBlmLqCuWvjlbrInbOztbUUQRJxJoUPKbouZUuoeHLOHGtesuxkFPksgmEUgKZWTlYhOhHGrlnSUyyCHCGMEZyuhFgzxylmDnv",
		@"NnVEVnwuVoYHUWpGBqKHZLQMKCJEcvszzEdlmupufcLQslmcMxHtaybglItbcnKssMDZQOTJMathxEXYHvtwvXtncJsaACDFHzGSRPalzmGFfrzFvWnDvo",
		@"KErcBYPZPJWIuPVWXvqcCdPJcgwXYMVZGuJdAJzBpogvvaNavtJMyjlruvesFWJWDmlMlQEsvAZjWWzdAWfbpPaQbEhebaLcoaKljThAsJhNBxxfsUuGyWVMxVDQmey",
		@"jhZcxwFWspyjUkuonmRlxiSGFEycdqdSmfbqwgNbEjJFoSfFhFhBxLQhmawKtDPCOhyOZTDUNXRMmePWaJhAsmuPWKTWfbrgOWFGmJJf",
		@"jNPnvefXuPHNkJXnBaYnHiiGFLdLxIAmPZNqAjTlizdgunRPdskOLCckGgwxEwIKwqSPolkGJdYuhLlTALYJAcMyxPdeyYVvUgbPscCeriBgrAKaKiZRzjMl",
		@"lLtYZPhjTZPmPrFsqBVSeJyUYbalDwsDrLAchcTWjUxiAPWHQUTJIPAIYbnrReZVvXNFmVkImoOJwbxemcdrkoIXEQpsbeeNXldHzHC",
		@"WNAnrrLhXTfZjYvzJqLowkFvJlaBKnogMzoxMsdAhigqCzHvlzhbnoyneczKhVZorriEdpBqiOjvyXrFoqxBleLrwAcxIKqtqcPItdqikiV",
		@"jZYUugnVPmBJwDHHKwAZzAhwIaaqQgEYaKzZPjDEjvlJMbNuxKPXmIxeowGNqkAHsmepGdBefodSpILWWdFIotyIsWOqdSOBfswAjthynqbSaxRclMr",
		@"qbsIFVLDINJPPKCROqAZXPFZHtHJNgkkcwvVRNYvvSpGwNSdlcrMmebQIRqPphoJCAKWjzVkbzmhNXMfZSqIbzxzPFUuEgVoqDGo",
		@"LZpMWPIDoohVmTZfCQrccRhscmVLJoRzPDxXfwPzCcxVZyIzskOZxMOTSkcCwClbADrSJYVtdRhObRgpnQyxNizqTFCgwKmyjjjhsWJONMhfMYDAedlekIAOMStOxOKtYCVTQIRqnmjkNTZtXeI",
		@"MrHNnBpuDzPFtrejTokzoauNOxpMMDvFdEftRNkoWXFUcHKZaacUVBekCAUCIgqZpOSqxUXgTyRWfionRdPRpPDMhqJMyvWiOaPtYO",
	];
	return sLpkfcKxRVPj;
}

- (nonnull NSString *)ZvHjApzxAz :(nonnull UIImage *)wjOZamRyWP :(nonnull NSDictionary *)trPZVkuBWU :(nonnull NSArray *)mVxSQEcpcbsu {
	NSString *UrZYjilumXaeqSiUPXh = @"nOqRDHIDIEWazVXInqCWvIIFIJJsAQSPogLMvMOgvnCzVUvbnVkJPzmXEaMIKNiUeCEvkqTbNSRALghWvdvLTqVaYEKecMHGAxKTYNzMBwHPbNkrptteGFdjAoKmK";
	return UrZYjilumXaeqSiUPXh;
}

- (nonnull UIImage *)rsmECdvobb :(nonnull NSDictionary *)nHwmxEvGAeo {
	NSData *eMrCQnyaIRZckhg = [@"DJXeBCNcnxCpSVTwLcyYheOJAfMajzKCsgLFDtvhpSmuojnybizbzxSfLpezBgaeCZwggsFzLrbENrigSERLfaJebQhVQfRmjExCWSpIJXRbgQiXVVKXbROeBACdHTAflLPIVCqL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *PdtvVLvTEUUMZqvN = [UIImage imageWithData:eMrCQnyaIRZckhg];
	PdtvVLvTEUUMZqvN = [UIImage imageNamed:@"NtYLUnthNGwEhFugYMSGJyPtKpkagExVndKLHZMAHzykOllcxAvYiRKCsezTQSALitUkgphgWKLDpgfaKpDJtmNqLKLgFENWvxizrzxYDmPCCzEOrQoqsdqFHWLCfvEkWfWMlrvuod"];
	return PdtvVLvTEUUMZqvN;
}

- (nonnull NSString *)UudsGNVCfmkXRCldhv :(nonnull NSDictionary *)yTkSmsvEUqSPKo :(nonnull NSData *)TMWCgdpwLeCtP :(nonnull NSData *)bFQtqKyNxiGEY {
	NSString *EQMbFqHnCaZnobSpFEV = @"IJozOmUSgNUifwVtevJhKKGhGUidXdreEUtyWaXmSlGQHMvoBitkgzPLtSzDgGmGqeltfJLwMeSCicHvbUraqHwbIxbzUzKaWOCsCjOITiouvUXFEevGCtYNVEEyfNflhTJbwQreR";
	return EQMbFqHnCaZnobSpFEV;
}

- (nonnull NSDictionary *)bsBtFMhdSd :(nonnull NSString *)BjtlivUniXZfyQNa :(nonnull NSDictionary *)nuUbpSyVbQSzNCFDYu :(nonnull NSDictionary *)HHaUeKZtIb {
	NSDictionary *JiaVnLyUxdCiXxIL = @{
		@"HwnDzoynnDKOC": @"QlmmUjSUTrIVKJaLHjSTuyEmNdigYXQjqsfyYcpwazKhykmYKFNUjKpnJoIELKoAsCJIGQlLwBVybQNsQFzREaoeHOdWEOGUzsqoomJIezdCvTvlfGFiiGsZsZtePoorYouwOVPdagsSTr",
		@"NcwEtOhjKdiPQQKss": @"sbjJhKHyltqqxDjdJQzppdANsPchzcwzRERYTSyCXccKRhLJtncpSqjHiTGIcnRyoJRogkFbAHRMfbTdNHKUzParxGlRtyvZLEazKGpIOMrBaBpeZyuvxWJrEEPUPWoEbjCkvqZiGmCVib",
		@"zQQZDgpiKGQXdNeY": @"KTLZLGqZihXXBoCiAZGUiESfKeGcsxbSFnxjYOeVqRhJFYhydSTQpxAAGJyqvgvJeavbOYOAlppIBFDkrraIUHPMbXGAShKSaTQIwIwaBKzNQawZmopNDpgjIxNptKexXMxqDtGcUTeDLRooEAp",
		@"rXaIqoByBQCt": @"yOigkjnTjLazAiJhGdgZogqCFLAIHRACsfzlYazWZlIxjrKussKwGMsceYzQtnHQCyjQeNAWUeZrzbfuivuvFgeHKxTbNgtNlGjqUPgyGaVszVleILJ",
		@"JCjgBMEmny": @"ItlomyPpCjJXiaEISGYusiwoRTSUDvNxCCeDgwGkNIOiNACSftkweRWoKdyfddfEtAlSHDNyctpuaVcJEHnfHvgJHNbQcswranftmrOQqvTRemHgwiIsaa",
		@"oHjIEXAZoaPazyE": @"rPfydKpJjrivtiJhZPAoTCYPgZYrukKqKKHgFpprSrMLfnedJiMIHBfXNRLIkFqiyNqfNTvZRGfcWjdEwWsuuLvAraMhpJkoQoDHa",
		@"sbjXgmjthG": @"avaawnMZDHuYCjYQmOjxkblEIikIpPCfTDdpPEvevbIDEABrTdMaZzsrEAYRogkjopWNkyBUrhzvbbYALLpWcTRJnMqbtqYPlsEjcTedCYhxdqRbHGnTPZojbtcoXjGZnqSoLe",
		@"hHShuMWmtTOajN": @"IcUsoSdMnHlTVxNfrIpPtBhDjUWbtbatMZRyNhdfldWVKSKooDpmKHdWiocNIndQnJmjbkoGUXjpGzPmxCUwKIIqghXZWqXiyIqlWcJGv",
		@"XdTwhIxaea": @"nCUNTSZIZLYopeguUqxUYsIlsjCOTIHhSmaTJUPfabkeoRpniWmAkWSdALtiSEZYtpdusVHcImHsGuLxYLJtbpAKqsmzNuNYXOAtdBLZPdFRGYzaxwQYHcnKrefVzNDJcripMIEWfXEFnQCjfSp",
		@"hnOottJgLidW": @"YgarNCYRKomDaaRauSDvobQIWujyUmbgEDycYbiKfAcXZVwXePbcjgXGAjXSPGUBjcdJnZrBrEUlxqDzSnpGfahcDaDwESEHyqoKjx",
		@"aLBdaEpiLZvytjpOWv": @"vEpBmjLtxlbjgBXzCzHvbgynrTDnsWzZBTGDZgspkZyGbscuStyLeJZPpLFCZfIEyRfGVUrVsyGuDuudJGvpTgsvGVWLJrZmbxKYBbPHFHhHLgptyrZBeSLLsMNdsCo",
	};
	return JiaVnLyUxdCiXxIL;
}

+ (nonnull NSData *)kBMFZJnpGJXt :(nonnull NSArray *)XMWCQqpzcWgzOIBG :(nonnull NSData *)LWJmWDCLvyD :(nonnull UIImage *)RORgVDwQXtAPwsjo {
	NSData *baZgIavEielNPS = [@"TuzGQCgJaCpZBgyABnJyFBTeFhVZiZmgcyetlAxZrhWFvuBDpvKuaBRjwAQitfkURduVCUDwyiFHfdaDxduifPSEzrYEqEVuinkobpbtLrviNJaYjkhKgYtjTiIPzfvCpUcpYKz" dataUsingEncoding:NSUTF8StringEncoding];
	return baZgIavEielNPS;
}

+ (nonnull NSString *)SEeatUumEZXm :(nonnull NSData *)DnaTELQkxlUlqnyl {
	NSString *dcyXNSJAhqBaC = @"TlEgXnJVsEWjoggrIERpuOGGwiTySfAYWCKfJHnKYGOSGREPrtpySPJQdopYELHvCwzNghIvzsbFHhyujjCMReqozCuHtOXERtiLXMIK";
	return dcyXNSJAhqBaC;
}

- (nonnull NSDictionary *)QFZzVALcardXR :(nonnull UIImage *)YWJXkdjNjyamgIe {
	NSDictionary *sDXgCCUlzHfdXywtGn = @{
		@"lLqgCmlNZsQEYXySOrV": @"QBYMmTNddRQZdRaGmqOJZIVMAcsIAqEayxIZeooUJtJHUhStRdFPCsOTDuGvHGdMMPdCVJTmYHtxgqAqQDHUldEPyhqCoysBSHOFXeZQVyNGGJdmkuzfqFkeghKXkyNM",
		@"WppBDUbQZqQTSdP": @"HZabDvWeSvYrJwwJufGUCRVTxLhVLQLJLMVJkIJLYUbyHwvOpEkBGLrzQTNPZLjydYktakfxYBvmsHNgRNyBVrdqfljRkaWguhbXoJBBbSUXxXVZuiQBvsLj",
		@"TCZLAiYerSMbmYDPOH": @"livMXjZsQExqXUQqTOrxcMRJZOAWWaYcJpxJUlIuwtTfgLgEvvUBvHkZCgxvIYltaYjaNLqqXfPoeRXGOYICWkGHrwvGgbILRUVCemCKgIiXGQKIGCxUqM",
		@"ceDrQocRzLBYIL": @"CwpnzYrGjeVWAAkOSLDfCEhVfgyXwqmYBmKFCPbMBjPYCCnQogGuQhhclcwjkqVhLJUDCFbGvcTfIxVvwevCPiWtVeazrUOSfGnUUgYUDqQZqEkYsPMBcjqRj",
		@"HchPjKeGoCVLoMQJYP": @"sOkaytDbpiOJxEZNJfOyfOhxqTvrmVxXelKtZVUrrSXXhyCvDcYWRRpVzKUxZQqCzIQBUyWGOiaFSRIYjnGVbuFnpiEOXaNezyaOQdUviOvY",
		@"TaYAuSvTKCqEIYDGX": @"hozOJmzQJGKidgKtfXXPSdHTUJrikJbWWZcafhGpCKUObwSauTpkTRwkhpEIZeAzmCaeQzpBuRWLXTcvGVFeXTihQNlQERiviCGfrUeRnwpLUJdCIqnxRgNLaccLTtQYzMqoHWOljy",
		@"LczJkdTKnRd": @"AgGcIxZVTPdSlaFxjcWyNMghLNIIrXgMNBYyUHZDRpfXugvCaPruVfTHlYVmnOcLQEjrXNYQKbIGWYIQSxMAoCoMyIPKhdqDpDdYzISkMDJiANLeTFmmwdxfdwYlCGWriNls",
		@"LqqImcTJGRvGzaGRE": @"iLfewvkiQpTNeyHiYURfEVwxuGXbhXJcMslWUyYvMqLFQIaqdFQzyDbUfsVlCdWUihQtbfwCHeHKQofpRSnaPbwuPyZjoRzKNWSqHpPOJl",
		@"UCxwDuiFJAQw": @"jqkaodpFUgmevKmqXIjTInAEQWzLmTzyVnESInvDMOrZdBgirNaruPPPLRoIkTuGdutQNyhThiydIFgfANRqvhJhjMprzyQJsROyxuIjELC",
		@"DvmgSznbJNiDm": @"urVPosFNfsPbLhwNaBhzqAehlLgKWNInqXtPpxcfQhRxpaoDYRRhWbzjrDNsvsbQiMAJILDeDFgGjjbaiFUfnaeOmsfrxFSUlxNTACOZuOoSkvaKNJIeXdLpnyM",
		@"JcpDTVUvPyPcBSNkDI": @"pMgUalsAQZayXWkuJjVknucANUAelVnRuWqBNWhSLxLNviIsWLSjAJGWiiiBXUpdMWwxEcFNFJlgFsKqksUUUXSOiloYsDWYywpfYVaJNKsIRfzQjVpcvtMzmVPQthTlBjclp",
		@"eCZvZRFqDe": @"EclfIYkqffdjAvEfjcleBgaxCZzusUExxSxXQjQVYcyfqyjYgJpcJwvukcCkEaqdglNRbKoitLaKnJUmiOAoCjFqxMQeqBoFHkpaUHMHMqwfNCpmPS",
		@"kcUaMNckNc": @"hbLoFbQAKALcuWsjvNAzxNBIDldREiQsYUVqLYnyqeEsNsPDhKOElMnqJatlOUzerHCauCvjdlMTnNlxKEpmGgPgCYgoRTzHbxNgKLykRGtkjgbKUbnJfDAYB",
		@"epEfHWptvfrgigMic": @"UwskmhsGvYleqquCYHPljiLtPDmzKdqWiPAdyguEwDOERTZKfroHCCkZfKeiuJshwFHaTxKlqQfrnkYifxtTdthMhDHrtjomnrxZuBeoiNQvbnqjizKvCAaPfMZGcwBeGApHjldVgCPhfUhv",
		@"zzSkMdxKzrMKDwV": @"HnLGRmRrxWNXpHXhuBMZcwEPBddXJOcBvtMnGKPkEEiUmtaYUGRkvDOAAqNsBLHBiDXZxWwBwMDrKUYDflLtqDaJqehFKIErLRxPgZepe",
		@"suzPDmgxFtPNBL": @"AbgKDVDvqeaCdpawkKtuLtrVxHCRdhVwKVpEYRoRmStSzXJqqcUKRDRQPiMpAohDduPjqPbkujfxEKApBHknZmqwoIFtNSmyLEsFphMWDyVHlgFeBAcoWNGJhGIPh",
	};
	return sDXgCCUlzHfdXywtGn;
}

+ (nonnull UIImage *)BykjdkpzZB :(nonnull UIImage *)CLKzYxwQBVb {
	NSData *QtyEINKnGDODhamF = [@"PbqhIPrJZNXEyqpBBkEbgOliHUqrnhDfwOQSUSBMPapMMMmgrNbYPlixpxqjWOwmECOYOTkuewQBNUPTMpATXyaatiQHVgQDeteqYyTmrLY" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JfpWqnueBB = [UIImage imageWithData:QtyEINKnGDODhamF];
	JfpWqnueBB = [UIImage imageNamed:@"vVrtQlAhIEcnAJWdGpoNrDsqVjPTGCHzeyyYgmplwtOEYVVILkMOuNuIEsHEdfbiTUGkounPdnbTvaVqelRkFRslBrxVCjhHnRZVi"];
	return JfpWqnueBB;
}

- (void) getSpecialList : (NSString *) zttid
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&index=%@&count=10&zttid=%@",NetHeader,SpecialListX,[UserInfoTool getUserInfo].token,@(self.index),zttid];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        if ([responseDic[@"rescode"] intValue] == 10000) {
            NSString *all=[NSString stringWithFormat:@"%@(%@)",[ManyLanguageMag getHotTypeStrWith:@"专题"],responseDic[@"data"][@"all"]];
            self.pageTitle = all;
            
            NSArray *rows = responseDic[@"rows"];
            
            if (self.isMoreData) {
                [self.speciaArray addObjectsFromArray:(NSMutableArray *)[CourseSpecialModel objectArrayWithKeyValuesArray:rows]];
            }else
            {
                self.speciaArray = (NSMutableArray *)[CourseSpecialModel objectArrayWithKeyValuesArray:rows];
            }
            
            if (rows.count > 0) {
                [self.speciaList reloadData];
            }else if(self.isMoreData){
                [MBProgressHUD showError:@"已加载全部专题"];
            }
            
            //结束刷新状态
            [self.speciaList.mj_header endRefreshing];
            [self.speciaList.mj_footer endRefreshing];
            
            if ([self.delegate respondsToSelector:@selector(reloadButtonBarView)]) {
                [self.delegate reloadButtonBarView];
            }
        }else
        {
            //结束刷新状态
            [self.speciaList.mj_header endRefreshing];
            [self.speciaList.mj_footer endRefreshing];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

- (void) setUpUI
{
    self.speciaList = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.speciaList.height = self.view.height - 41 - 64;
    self.speciaList.delegate = self;
    self.speciaList.dataSource = self;
    self.speciaList.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.speciaList.showsHorizontalScrollIndicator = NO;
    self.speciaList.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.speciaList];
    
    __weak __typeof(self) weakSelf = self;
    
    //下拉刷新
    self.speciaList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.isMoreData = NO;
        weakSelf.index = 0;
        //获取专题列表
        if (weakSelf.ZhuantiSourceType == ZhuantiSourceStudy) {
            [weakSelf getSpecialList : @"0"];
        }else if (self.ZhuantiSourceType == ZhuantiSourceCollection)
        {
            [weakSelf getCollectionZhuantiList];
        }else if (self.ZhuantiSourceType == ZhuantiSourceCause) {
            [weakSelf getSpecialList : self.zttid];
        }
    }];
    
    // 上拉加载更多 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.speciaList.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.isMoreData = YES;
        ++weakSelf.index;
        //获取专题列表
        if (weakSelf.ZhuantiSourceType == ZhuantiSourceStudy) {
            [weakSelf getSpecialList : @"0"];
        }else if (self.ZhuantiSourceType == ZhuantiSourceCollection)
        {
            [weakSelf getCollectionZhuantiList];
        }else if (self.ZhuantiSourceType == ZhuantiSourceCause) {
            [weakSelf getSpecialList : self.zttid];
        }
    }];
    
}

#pragma tableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.speciaArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Id=@"cell";
    
    CourseSpecialViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[CourseSpecialViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
    }
    
    CourseSpecialModel *tempModel = self.speciaArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = tempModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.width * 0.4 + 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    CourseSpecialModel *tempModel = self.speciaArray[indexPath.row];
    CourseSpecialDetailViewController *vc = [[CourseSpecialDetailViewController alloc] init];
    vc.tempModel = tempModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return self.pageTitle;
}

@end


