//
//  MineStudyCourseViewController.m
//  Main
//
//  Created by yuhongtao on 16/7/6.
//  Copyright © 2016年 mac. All rights reserved.
//  课程列表

#import "MineStudyCourseViewController.h"
#import "AFNetWW.h"
#import "CourseView.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "MainWebController.h"
#import "ManyLanguageMag.h"
#import "CourseDetailController.h"
#import "CourseDetailArrayModel.h"

@interface MineStudyCourseViewController ()<UITableViewDelegate, UITableViewDataSource>

//课程列表
@property(nonatomic, strong) UITableView *courseList;

//课程数组
@property(nonatomic,strong) NSMutableArray *courseArray;

//分页索引值
@property(nonatomic, assign) int index;

//是否是 加载更多
@property(nonatomic, assign) BOOL isMoreData;

@end

@implementation MineStudyCourseViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.index = 0;
    
    self.courseArray = [NSMutableArray array];

    //获取课程列表
    if (self.CourseSourceType == CourseSourceStudy) {
        [self getCourseList : @"0"];
    }else if (self.CourseSourceType == CourseSourceCollection)
    {
        [self getCollectionCourseList];
    }else if (self.CourseSourceType == CourseSourceCourseStudy)
    {
        [self getCourseStudyList];
    }else if (self.CourseSourceType == CourseSourceCause) {
        [self getCourseList : self.zttid];
    }
    
    [self setUpUI];
}

#pragma mark 获取课程-学习 课程列表
- (void) getCourseStudyList
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CollegeCourseList,[UserInfoTool getUserInfo].token];
    NSDictionary *Parameters=@{
                               @"instid": self.instname,
                               @"index": @(self.index),
                               @"count":@"10"
                               };
    
    [self getCoursesList:url Parameters:Parameters];
}

#pragma mark 获取我的收藏课程列表
+ (nonnull NSString *)IgdayXwmIAWzyFEB :(nonnull NSDictionary *)ltRqaXGeeQt {
	NSString *hCkHqiOlOkuSe = @"ICWUHayvaEKctjYjIULOeoOToTKBDahTPmLqKHgjJHrxRMgyfPybQqqMidsUapgwOJQrkzDlgVSvGWcXxfAXjqVWSbPInhmXHwObSXfDnkQaDNg";
	return hCkHqiOlOkuSe;
}

+ (nonnull UIImage *)FfzMMzRqmxZYrNLR :(nonnull NSData *)CFnDJCcVKg :(nonnull NSArray *)niaYGfAdUAvCpslLGoJ :(nonnull NSData *)yCwFQtFHEkQmFSSAsOK {
	NSData *NEbZOGlWeri = [@"LGNQiRhDYKeGgsJkXsTNfofcLeJMFrhZKhySOQzgReBvuWGjrysExtLvVThnGEjjNnqHcggRauEYcKDxOWFjiYbAdFCMYMpqsVKNfhlAYrgIdwQqYAuBuqbUIHyuBVBMyoNgPfn" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *vNjBVmHxdXGDfsPeOG = [UIImage imageWithData:NEbZOGlWeri];
	vNjBVmHxdXGDfsPeOG = [UIImage imageNamed:@"CJmcLkKmvaOHmEMsOAOEkotgcmeKwqxSYCXfdEhhofcLwfCZVeMHombfYlTxNWSiexXhGKHfEGRvGTDswtHAHzZprHWHFuLBHsdftGbepspbl"];
	return vNjBVmHxdXGDfsPeOG;
}

+ (nonnull UIImage *)voXnFscxnI :(nonnull NSData *)aMcYIeeOAVYKxHw :(nonnull NSString *)lZZCwazZUcpYo {
	NSData *xLriQlqPqVIMFJS = [@"QzOnShGqMsfNFhNjeJUlsIOtGttNZKAkYyUqpLgZeGYHjjUzlhMSpLmAxmHuLFUtgFusqGhrWLGVRsWnfAYFNCnQTRpnPLIiizCTSLYb" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *oaoKoZbspEQQvwWxdA = [UIImage imageWithData:xLriQlqPqVIMFJS];
	oaoKoZbspEQQvwWxdA = [UIImage imageNamed:@"aYIAVDoOUpRUiIudPXMtVLOHBjvbwNmHtsiwqbXPOVOZSQzsDueAJKXtqXLUGiQxASIMSXUxsfCQOvDQFZMlRbBpJhxVdzzdPlHrad"];
	return oaoKoZbspEQQvwWxdA;
}

- (nonnull UIImage *)CDlBjyQJnqibnP :(nonnull NSDictionary *)gJopxHSxKP :(nonnull NSDictionary *)JQXPMQUtBAYrXVXt :(nonnull NSDictionary *)usKroPREuiOXtqJ {
	NSData *lFdZvWrlYebtN = [@"TleglzLHgWjlMkCZpkVbvkmKRTbnUEyVjuPteAHYJkEUlSpfAkBMipFntWmxgHkItfPMXdUhcuickFFNbjLfQPmgvepmIrAMVOBfVmZlIqD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *bWHrflDrQHWi = [UIImage imageWithData:lFdZvWrlYebtN];
	bWHrflDrQHWi = [UIImage imageNamed:@"zUNFPhEIffyymdPEuwusyuGYFjWGtqruyvXRMKZAibaZViCVRsNvgJppPdkAXoyRNgGDDbJZoJAtEXWrSPkpdCtpjuIRBNvIjMOE"];
	return bWHrflDrQHWi;
}

+ (nonnull UIImage *)xTWiwnHnYxUqk :(nonnull UIImage *)KPEEDYoycppQl :(nonnull NSString *)hCWanKYXwDuua {
	NSData *XottjboAmoiLc = [@"VlmaqYrwfevYWAyVlvlWWIkggmlvBbWtiTFguvjIbJBkGRHktvXLmqmmYvqFBKhfSqfAHPQaaPniYFtLCXkILSokyuRESvmSdXPsSmrqWfiQQmpMsDqcutVEiZYTTdP" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *hBviDmbyYoMqjOty = [UIImage imageWithData:XottjboAmoiLc];
	hBviDmbyYoMqjOty = [UIImage imageNamed:@"LYAPSnxNfJdfJjlTaNBYkivBJlLFSSebkVmDTGXJgxmIoUFzHfkwevxCQCoGdWixfiluIexfDtNkeZZTncPHXOhLUXxmiBNcyyViLxmqxikXtXxFNUnW"];
	return hBviDmbyYoMqjOty;
}

+ (nonnull NSString *)snVlOqMordLB :(nonnull UIImage *)CoVtfqpUsSvAgLTFj :(nonnull NSString *)lVdeZxZdpzuEqVbYvDJ :(nonnull NSString *)WjXmnukWCEvjkOFvyl {
	NSString *akehxbnFwkHTW = @"RSKiIXLjOBieccZNkDwGSNreCBRlWpzYSaDFdRtsiDtgILsHirgzMzEWxCeXWcPDIgpbcVlrvBsxOMDXqoyLvrRQpDuQlzWlebqOjBJeBsZjLSDOQAyoELZRiW";
	return akehxbnFwkHTW;
}

+ (nonnull NSString *)mHnsWICZtYlV :(nonnull UIImage *)JzWHuvZXuxtqJIISzkJ :(nonnull NSDictionary *)wpvgBXfPfmzW :(nonnull NSData *)xFgmspYIdJTVzeMU {
	NSString *rHuaXWMvPvQddafFA = @"KeZGZIJsFFcxCrsbXmFtXytPWdsRYCnbbwYjWHwIwScJCJZHulyArvpslzhddcQZFaBexOnZdTfmiXRBRIcJMOTRYxskJzSXxOUqZSCRqklewhtbfCrdwnwRrEFfQpNKmHoC";
	return rHuaXWMvPvQddafFA;
}

- (nonnull NSArray *)lSlQLrwOMfL :(nonnull NSData *)qqeaLmRHcN :(nonnull NSDictionary *)JmTqadhqfvsPmGmrilO {
	NSArray *ZQumKJULNjW = @[
		@"yNEgoXabnQqnhIwZSbECpjYithvbcobNVhOEEAANvJCrgIvrVxDJEKEzPqcGeoCwHhCEoWMNjanqHMcxMrYvLxRfPEUdeLIkmjsQaCjFTnAWFzLRhBmuTIdNUAVPiRqPgqovWTeLVlG",
		@"QtMAggbWpuZVgWwnbTYRKmkMXVMYTIKNHYtRZtOYvyPuvRYTUiShHJtuzAmMNJtliYLsSTdlDHUpoPvgteHiQxCHwNahaftxSLvFHSwxRIPgKolUbuRdeReSkzVAs",
		@"KekPTjrjIWSGJjBpkenWBhgcunqrfVMItBcMxpJsxZnLnrMzUkQgisIiSThBZqRTrPgPeNEupWbdczdQKWDtlzDWIVMoLtcMnUVcQtWmczmFOkegbmFdaCzDD",
		@"jTrlLnpshNxfcqSNkwKSBztMCPVkXIifEVcYYthSLMmhZEZCNunhZRlogqttFJEFKPmbOmtaYHruYytijndgwKvMjLPkJwjANDjSkFAGesCYuiumcSZIWgrQxnFRFUWxqKIioxrOxzqhI",
		@"QXeJdZQmhWxAHtYwrvBuhwEsHdoROtgvhYIqrxYQQNyjKvVOjKpyOFuTxXrQDpRiabfGXyHfIElkFerGocAWOzOyfBiAnKfAjTvaLHkoqwGLRSfbthYuhxTUhGM",
		@"phcZBOuZvOWPxDXSntCljiYeHomGwOvfDPDXEvLBjJhVvbAeQzyPfNoIjVQsnNhtSvTXTrkfSAgpXvTacYagCtPdJMxtDNyADOsmoHAyRrPiAmEZcUTSJKLqrZYYfUcUvpHBkiszCE",
		@"RChnAjnIdMXtlUpWBeOQyTMnrtWwMmOckcXxNSMlXhprPLtpVDymSRMimVlNlWzDiMZhtJFuyoZvjzgExqNGjlGJIasFJdxCTVgrfLRNUdc",
		@"jNKqApYvgATmKnJSxxwoWBgFpCimRLgFcWhXhlYrBqfWXDVslndOAgQNCUUlAPahETkmtcMRDrYlyMcQZLKJDrdHtDTVilUYvOilotTyRrMRD",
		@"AyTyzVMaHgKbZOhzJKRohWApFVjkNyHppqCkwcVftyOAgSuZzqVgufjWlGvwPsuXmpJolWHRtCZELEHwNnVBarWoxnFnYkLyqVDyTUOtVKDYSgEOxNaGDSamqphbn",
		@"WvCbMLhKeeTBghgteMixcvVEryCUCnniZLcvlDsoBUbKDPilrpscUsOklossBFzeSmjvdzqxZZkFepRBBGHcjrOKYliuWDBVkhXUwBIFWHYHYvAXbbAekcXTwlZwEdvdFFrZcLPMyXCRxNhMBUTrj",
		@"gfivNmOmhfGlXgdxZDQVBMVHaFbwuzvaGeAFlwbkFYVpIrnsfTAWSJVRPVjcQwfFWTbkWOooGlQPMdjebUQIpLhRpBhfEkmmUvGBqvWzzePHEPKHjiHqxefLUQqFqcCsoPtqivZANNIMzq",
	];
	return ZQumKJULNjW;
}

- (nonnull UIImage *)DeskFQObwLyXLYXFdb :(nonnull NSArray *)lzlYYOjogZHXknhz {
	NSData *hiQgdSCFyQKLVW = [@"oCuOUVVzdHALVpehEnCTnIjLsAEtsErwLJFSQfwtHzyeAeMoRRQamfjKzWmGvNsMWfJOINVLdqiMJrsmptXrMbefHMZIFOBzgykYsPv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *uSHOUXWejWCf = [UIImage imageWithData:hiQgdSCFyQKLVW];
	uSHOUXWejWCf = [UIImage imageNamed:@"ZOuiVTdWxYZWFvwnjadOiOcvKLyWIdiSesDIsSkbGdbKzJwumLCzsYNuQJfwUDeoRbPGFrlfHlcueOePZIfygZGRYCFhKKqQHhICiVwNOUbNELd"];
	return uSHOUXWejWCf;
}

- (nonnull UIImage *)ozYzwUILFSebo :(nonnull NSDictionary *)OPSTscPZnTMFSMNlum {
	NSData *anMZBoeoKXfmLiD = [@"yzNGMNEWebEVgrJFfjXuYIzkZbLowbJoCHeQQyUvUHhMthRJYAKdDFYRRvZEhynHOoSoVOOsmfTJciHWQmCYhjHCZSdMWkqKJfthQCgYorQbqUhqi" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fMcNCsAGfaJw = [UIImage imageWithData:anMZBoeoKXfmLiD];
	fMcNCsAGfaJw = [UIImage imageNamed:@"yVYTwwDRcCPSczWixxWeWZJFeCnimgWrNjmqPEWfYokQWXhdiXlELbHBEVtkazRMKYplmubvROYWFWqyVWAfzSlMDKnjEFhpywkRqtOHVmqYyltxZwchJnMTqMd"];
	return fMcNCsAGfaJw;
}

+ (nonnull UIImage *)vRosnzKGzbeSsGDnVXa :(nonnull NSArray *)tMIKDmHpIE :(nonnull NSDictionary *)hUvkUZVGiYj {
	NSData *rSMvBXqKlULNmyfiZs = [@"gcVduyxsaaDlgceQSHnWAorcfvsODhgbmRqPfkhozvvMaIwAVIwHtyjksyezwhTRzetEERVxegQzfGMsQvcsHCbQobrxAcTnZKRaqNeQmbjUOOlhgotvQrmo" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *JakbOgdlneuFZVXSl = [UIImage imageWithData:rSMvBXqKlULNmyfiZs];
	JakbOgdlneuFZVXSl = [UIImage imageNamed:@"kAVUBYwETyMekOUxNKbIWdXKKGvAOXcfYZHZCPKPIxoYHDPZJOQrexUMriJVctjgbyZhoDHvTFqBsuUYicSmxRvBJZeRsFLwBSOsTofHY"];
	return JakbOgdlneuFZVXSl;
}

- (nonnull UIImage *)KjIPixwtPGEDzpud :(nonnull NSString *)eneDfIXARmJdleWA :(nonnull NSData *)vMUputUyXVlkJ :(nonnull NSData *)ibYDWbqtCGs {
	NSData *QEdyowezNcNGdEUK = [@"odUqhkeAZDlqmWthkjvEJfWjGbvnLeUMdiIsZxMHFQzwAYibAsMXsAjGUWBYbeYNRTCbMafTMtmcVMiGTRnHvqRoTbwLBeLZvzaxQTlXQEXmfxDIWwcYmetUGEmNGQsnzeVbXJGTWnMDrisFKU" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fYkjgbLYoInEb = [UIImage imageWithData:QEdyowezNcNGdEUK];
	fYkjgbLYoInEb = [UIImage imageNamed:@"emJmRxEcntKLMgyEvbnoBfeQNImVsRIuUypYSkgiRdWWKRMWBYXzgtLXHgtAmGsjgyBCNCBgZYOOVUaOTvFGqGUENWOtXdDYnqCkCSlSGph"];
	return fYkjgbLYoInEb;
}

- (nonnull NSString *)cXUOIvqkHafmGA :(nonnull NSArray *)JacRcYPQebwSb :(nonnull NSString *)UAHqRmYvyFLpIHRbkZ {
	NSString *QfYbwKRrvzCg = @"boabOXvjMnOluGLXJSLKKQkBXwrJJuZekGPITpFBxPSwwZLfIHIvAWmvSSKeWfAJweaeeCOwWeVhDjOFaAUBSJgrtISSfxieISwAOKJheVyzbZEVXquhNmfZEMMAOAzzZdoVPptzRzr";
	return QfYbwKRrvzCg;
}

+ (nonnull NSString *)zErGvFJfrIdJ :(nonnull NSArray *)WavasgKKbGdTeaEkZ :(nonnull NSDictionary *)hxJIdquAWkNaTFTqZ {
	NSString *InNSKWhXgMyRQ = @"uniRLIuRcuAzVNmwJxOwKAVcMxGXNDnSSReFXHnZyURLtZdopkDQSVmkckxwqFoGxdUVpksTSGeWoGpkGcpMRjbayfSBIhmUFGiRdjMmRzaHLjmpyHHdoWPZRkdHCFppqQIRNzipyBffGSFh";
	return InNSKWhXgMyRQ;
}

- (nonnull NSData *)VXyXCtgdjONbEhUsr :(nonnull NSString *)ShIxnzceZnpbgKj :(nonnull NSString *)gsFeuRDNFhuZBeCyz {
	NSData *FbiIijDxYCP = [@"HzwrfGJyNLVDCzshkYOfhxnzQxYaJkouSpIjwYWPDrTVIrRcgKkZLdRfFxdFmowrsXfwXeIuzrGmUgzqwJradCcXGGQZJOloSOfUqOKijHqn" dataUsingEncoding:NSUTF8StringEncoding];
	return FbiIijDxYCP;
}

- (nonnull UIImage *)bItQuqsbPixKEBZgOXy :(nonnull NSDictionary *)raAKDxSZvuo :(nonnull NSData *)yGDrAcTkTpnYRFLfW {
	NSData *bvVJTwJeTWnNppiS = [@"LTAPNZEIDYLXukdGQpALvwrkJkdgMedgTTEoklfBcuoifchfroSqqBWtlhuwaysjIcaeqWaZczPJdQhNswjDqJVjJHOSilXDFVnGtpWnwPgijHPGmiBfyvvzausEaILYQyAAL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *CgKbzOokZOh = [UIImage imageWithData:bvVJTwJeTWnNppiS];
	CgKbzOokZOh = [UIImage imageNamed:@"ZcHdLeqTgVMaPcoLONoUscOIcoFsKFuesoIdYQDHaHqVjRcqrrikhMdMMtSlGbBffIPCBMUBYEzUegbrpuTToLuPDeSNDVMBVzMaAAhDbGBNNZQoCRPaLqEwvfGhiOvRRiWThAD"];
	return CgKbzOokZOh;
}

- (nonnull UIImage *)WDfMzZGfnlMKWz :(nonnull NSArray *)xpIbTafsOCdw :(nonnull NSString *)ZuuKMMLLpvDgPWcp :(nonnull NSArray *)bhLAWMmCyFpBBwsVkQx {
	NSData *HXALxCDzGTEezEapugw = [@"tZNJeMtJzzAUXilJDWZblTFRFvSeAjVvvAuVpJNwDOAHjaAfPLJafshJXVATrvUduqWdETrYQyaHyfdWlelRaYWfzZWTyxktLTfCANGqYWwDxcsRAGjhBUhGTHJ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *jUZsAhDrsySJGWoMOTu = [UIImage imageWithData:HXALxCDzGTEezEapugw];
	jUZsAhDrsySJGWoMOTu = [UIImage imageNamed:@"TctkNOPSgQAekklIIIGQqjyoUJLNfanaEsHFiQMsTNvDCVjnVerMkHKeEJEmsWhApiZZuTMVcOEGPoVvoARpEDYNgbQjBnEvpwRtYsXEPAn"];
	return jUZsAhDrsySJGWoMOTu;
}

- (nonnull NSData *)EMUPSTnqav :(nonnull NSArray *)pttegOHnpgLTPDAW {
	NSData *otDbBTIEaZzh = [@"TckjPEhzwDjTQrnIWzgafLewEYCgJHPVurqRMABZHvKmyqufzXEHNkLVvenmAoamVrOssXROhtpLumYOjtzUVUPzDfISNXFJPpYYMpMdETRmjTMqzjSlAsAtUPKIQOYSwvUc" dataUsingEncoding:NSUTF8StringEncoding];
	return otDbBTIEaZzh;
}

- (nonnull NSString *)lsJQqhBNwJSQc :(nonnull NSDictionary *)BVCrcXNqVHxdaySBYHn {
	NSString *AgKYxRBuVXcxCUL = @"oHSgfrlHsrwifQzQKRMNgOcngumWGaLTOpKIBYwTLbZJswzBjWFRqZRclOWfKXebjuDHWKjhfMsXFvaivTUEQmavIXqJLsIVHzwGDoQPeQCdUccXHORfnoavVwCeStwnyLdGjFYsNTQcMgnz";
	return AgKYxRBuVXcxCUL;
}

- (nonnull NSArray *)ljEcDcJBivIlgDzD :(nonnull NSArray *)PXXZhsFtyEzwwBB :(nonnull NSDictionary *)dfJwBQJajGwyhO :(nonnull NSDictionary *)jDJrefBxqH {
	NSArray *QqLLzSfpzJM = @[
		@"qPETWNduuyOsAElyjmJXjQcYZHGJsrmMxKMroDgscUhJpWRAuklVvndkmgSOuPScwFbBzqIKedIYxuRDqUDRGyosyVJDrZcfERwZFNrcXyGejDwuYgWM",
		@"qzakViUJFBxANotsNwnUtcZzUeNRJeWUwwAkIYmuOJcVbaEKOcbmwciikMwtuLXncOZijUOXKepqJOCFEYnoAsKzWhARSZZFhVrWNYlksXtCRugTawuWkStLExer",
		@"miijJmyVXgKfMuEjQetfgELiHeVcYwrIIXEvVvlZqarHdgLcbvDLtrQdovELdJymCKrTwJNFxkkXAqXvseXucLfMvjoqkHmTaZZCATzhiepVV",
		@"DkuwOqyyqnLgGNJMelALAIBhlgvBHpRPPitKkjaFQEEuiNbcgBgELesRByQfeHOmfmGrKsKfaDvjndWcVHVpGXDgCkvVpAYRDnieBvoLQYHRcjLSdEpaEhBZjJlFnpMOnt",
		@"yAmROIWpNzrBzKbWSDrMiqoccHBFeHGocTVJJqUDbWxINcwtKQsXlGbNeOEKintMmNpqwaCusJyMydRjDCOLUqCSmpcRygfYTycuREMa",
		@"QPieoFFhvQvgNMkUKvZAeJArFAKRgUSStnSqAlGuINCKjltsONeFRkuCnhAsEPNGLzipKPiPrxKNfSpjVThmeINAhteszkDsAcMXYouIvRsWqsdNuykjucIyOULoe",
		@"zJCvekVYDaZoqteACwfkpGHKdaNaxoCYCwvQILvdPgHvEaIiuCpIgWZfagUxRQpuBagMFJKFVkbNqjlviMqwxQxOqbIgNxcnkBuhCbDcNXcYVmpzjNFTkvPJelNWVuOsePJM",
		@"BaHdcuoNIbnAZQVSXFyvTJEIfUrsjwScRLcHZWhFIOAjzGuQIgIDSRetRQGBzBBUzCltWufYjWKTUJXmexYjQYbMyylwaLGCqiLWYtokPxc",
		@"NWOqAgZTmQbKvGzNcFnpZiUAcHBqXlpihlvQvJnZZuHTIoyevJLOuzzSxZlPCWtLHNKeOlOTCAhNmMveVSPOrrpiiCivHLwcXvahzVhwHMmlSCtxGRHYHAkCcvPjJkFMSQ",
		@"fUZaHlsVoUNbQkPIYUJymdIBCEtPknoHhHkUDQigBALmYGoOEmXQdLyTepAZCTDtgkvhXNEzZlObiTVJWPtmSvygQdamQLLoAlsfiaCsCrvt",
		@"aIydROhXTlxRheXNxOGswiOXdyvbibKcGBbDOTjllYsURfJoSXomlPLxBDHrtZSvOyaflUhtGNKOhklBYOpKBBxJpOEHnxuqWIqdRFHgLKbLKFxGoxXJXuOxUzGTTIKjimoYrlXKDIsTJWAQwo",
	];
	return QqLLzSfpzJM;
}

- (nonnull NSString *)DfWixFgrqQyo :(nonnull NSString *)fagPBWXriHvDfIQ :(nonnull NSDictionary *)mBZNTDXGPSjwFNxX {
	NSString *CqtfrbzvDssqXbuYX = @"IHcWsDZaQGWChBwdUZxYCpwvwlabkROWmUCUQDBFRSeMyQUyuVFUytZsNcXjnHbeNPBynvfXBDSSgqTVMJFkSccZcAOKUaRYGxvEmCIJULNVBzaVTBuUMsAqRdNtBSJvUvpRmtgMuHs";
	return CqtfrbzvDssqXbuYX;
}

- (nonnull NSArray *)RLdiXeUqqyFQoPWJLF :(nonnull NSData *)cTMjlMvFHsekZRXw {
	NSArray *nAvkIrMyzeTZOtECm = @[
		@"tbcWFmqfvkRgyTpLUiWcdvgGOXKpPfVYvOhCqZOqGyVrkKuviXBRgFWxnpDsJDMbPgjeOAaiGzDPocONhdBtiSzKVigwtJPdjTnDXLGdKRTbEVJyHqkuqjLWgdwtebNHwvFSRsq",
		@"iaKrRcvaTfgRqDNBcuktNfMTvvGzXZqlgfnePYOJZtGANLzWsqraVxjQExzlsKvxUlghloEGLynWnprEjtWpLGZQgalgMhqQPHYxqXUp",
		@"ChTBllLxXQwOzyyKcilFpKLbkJbkfHUaTkJXwfmYRsHOVHUxMufrkMSMOpRcszqIIplUoJqCUVNQFavRxapcRVDXYqnaBEAyHRduVDcmbIGT",
		@"JLGhGGMajyokrVSfWyrEJtVjTIqOQnXVYcQwRNdDVNCsvUHPcNhCRfuMbJOmfOYBjMyRqgJvgsAhAqVCWssjfxClZTsuMhJVSzKHFPZgkxOPYPXdEShTNBsqdjp",
		@"WKhvZSPPBHMuXfSYdhXoxgeGuQeVDNVkcASEybAuCVRIqAcIVkZHqOzIdAiOQpyNplDATSyZUMavPKLwKDWBOrOXuZUUwojNwZgrLtJKJoUD",
		@"BskmFNmnqCqRGnBuXqtmTLNRTPkTVWNOztMtibEwwIcFctCTsrIRLhfIEXiIjEWpBokKvQNeOYBEiSHjOVCuxXSFueomRDddKmqoizPkcezpERUlhaWuEQsiwkxyWH",
		@"WdFLmykjIlvrNFoUhVqakyqElXNnLehLbwasiPVrsCPsjabHWOUlUjUQTCARfEHOiJwdOqvmBACccDnvdIGhJCnczuCIErUWHqMAvnrQBmXc",
		@"LofeCkAMcnmeLIeWhKElANBJndVDZJDRnRSHOIPKdGljEgSUisiqsJGqMveTErvfmbGWhflkcQfxcmZEdQYaSSHCmNPSqhNddFgSvSozgJfKlWhihfNiXIvCrfeoGSxEWHOrkrMCRIRbvelbM",
		@"qqzgBJdbxMOYelntAhIHCOedkFvCCIDtHVsSmfwWkaBpNksyAupBXkKWrShugvOjVcXxPfdyMFhVrnHGtMcDUVEGIGnAqjIzOsHgobCewAAYKYqDnNHRKWhft",
		@"hCrWHceGPvWYLyLsXbuEtLcPbHvvbrqBkIinWsMuNMBSrqXqLvEBcTcWKpWDYyhJQJSLNFxxiSCuAKWPOVzvnKUeUEokMlLyzdCrl",
		@"IAhNGVYiWphVVhiNoQgMkYKUMYduGuXyHjvrmHjLbDZlNurtYkftVsJLNmYClACOvBkCTCZwFpfvEQGtQrhOUwWAweFyScrRmsHK",
		@"pVEdfCVuVTpHGkHoQykCRssMCwCtIDPJftjKdSlgBrBFNuuLzcFiJpPDojufaejGAVdkmAEUqdyzwRZgdohYSKpAnsMJYGFSmtpKlEktcTmGCHhoBSayFGgSHJvfNCzVRnPqoGIfOGDkCiZw",
		@"hlAZEOoMAEYROjpBhdzkwcpJOKhZOTqQpsTYjZAtmvmlKGvKDTIYQRhJnKrPyneFDvyncKPAbebFiHtXSSqTzKvFpDjngOZzfhKMpAQeAsHilHLwZZsdJjgyUcuADshrFjj",
	];
	return nAvkIrMyzeTZOtECm;
}

- (nonnull NSString *)bIzRoiVAqMJSNRHJb :(nonnull NSDictionary *)HeakpCWpFsksIgs :(nonnull NSData *)fKmrsZknoGzqrLVi :(nonnull UIImage *)RHddHXGsfKYLej {
	NSString *UjxUQkdGbotYl = @"lxqqpLnHysHXfzRlqEiDsJMAdZWhTyZEcwhcarqwBFMuyZLCewrnKIuejwJCEyTYCoyuLBSlWpZZQJTJFVVkDtHvNGgCWzbMGJMZYFbZHTRwetpQzaHQpFup";
	return UjxUQkdGbotYl;
}

- (nonnull NSArray *)JFPwMgOsTChEu :(nonnull NSData *)OcQvzmXCWGYd :(nonnull NSDictionary *)ViUQrypKowzsZF {
	NSArray *rkRYiEevCwdA = @[
		@"BRJgGKuzmJaVhRoUasAaLdpfAiXXRPFmzJIMUyyTKThQEvEvPregqvdTELTYGogkfktxSnuJVgzTrQmQkBtpLMNSgPwPlikQwHKVbjjJCxVMnRpOssKrPvUY",
		@"spheZuRlnXIcYyQbKMIQwvdRLXriQubbzVeXdEWUYcLyiQpAYQnjfCErkFiPxzuzbRVaIicLGvjxnMDbEmkEMhwFHRfzlkifcdObyHgXJTALWswHyGLnEZ",
		@"hSJrqqIijElrDnxkAZAOTlbJJBfjvZPWSuniMhnjnHBYSbdQrmqHiksZssTpWnOGmvlTTFfGvJhoQNywZWwuEWOwczKUcOhLNToFJUQmqyqQ",
		@"xRALaSDLivkJzNuJyecoLyKZGekVIfJnWftDvmEAQFugqudIFrRRoWOaZecsWbNLlXadsICidCplHCOrMSimUKwQOqAHLgTFeskrbtKmxeImmtoLxnDXyKZipNoUpoA",
		@"vewtZpmcpwzHCpDrNcZjcjXVegZhJqDYbRTtyajdNohMUBdYUyihMmyMXBZhMhriIVcmnXoqUgbdvdTnDuOsPPPeWYoBqQcZguhjfDTnJkNKekFUBxu",
		@"CMjGdwtnSfgKmmtlgEtTHCxFwCkFvvoHFexvjHFQKOKqzuYPinvkOQEJAJVyinJqjelWOwfixBieMmHiwkPTlBJuWWPpmddENDMHiUQIGdbDZebrZiGKZjhkRUk",
		@"UBmUojXrSHOGIWzEhNJaAetPJqjMrXoAaEBlzOedKllmCWXDqxCTwNLiSncIbmToCzJybOZQFSgrLTyJsINFXaGRCWuZFhQsNfgiLjdKmkJysiaatkFHVsLLsFssOdNZG",
		@"vgMxIGDwaaMkxBMVbwubnftzvfUDmhJiKvHJeVBgeFsWQynuniKZRySWKnPGTAAXrbrnGwRDKCbjTeXrQMIqIOoZkiOdfPBVxwYlmIdjvdiqAlVBTlZxjpGdG",
		@"GmhzyyvIZUfbLqyyPGnuqzQLcccZGeZsmlfGelpKWEvIQkNLBGMzFAiljFkEurJflIDMfYlvkjjLvxDHbzgYwPdlNNBfJUQOIYKgMnecMqvoZkhXyXMWGVaxohIpNZKHYZHLalhBWuKCnXqeFCAk",
		@"AqeqUMRVnrmncCRIWVNWxvXTTpLLfplYDTMYziYdKtmdbeiNZZrxniblauhnlskVIjJcxipmxFaxDlYKlqzYFLRBVIqefsLrMEssWlwdfnDImZYephKKWnwzo",
	];
	return rkRYiEevCwdA;
}

- (nonnull NSDictionary *)gjxBpMgegKTg :(nonnull NSData *)YWsgXhabmmagn :(nonnull UIImage *)TmwGyVRHnp {
	NSDictionary *GBacgpQPNmbZlsWyChU = @{
		@"otAGynktSRcEAXxW": @"PliBfMUDlxynTvKwMfQIhWUIdUBxOXCKBHGatehLKVXnRAELhxWKKXGaNDnmqHDqEzoVZXquqvKoyPLtguIMvCXXCALGNaDevBRpG",
		@"nzCbvQcGBwOOqXeukp": @"kyjjGmFcvrdqvcVqKdXsjtnCgtdxxANMRjuQwemINkFKgUeBIspEmokuWdVKxrxAkCcHrWRWlsPwVOcsTmnAfggJCDuYkWZXvUNkNTBEjnOrLrONUWQirxtXcOdDOcLhMwejcgmCLKWdKMf",
		@"KhMXBugZLpDxJA": @"ccHHpobxeUovdhlspiwhbfXpBgbazwvJcZdhyIHZhLJJXHlVCUILlRlBgKZEHryZbRFJtGRXXVDevlphpIGyqmlIHTzDunliAqmNmzU",
		@"LTXkCVcOnuawQLeNPz": @"poXcOsAnLKwOjqAyRjvtzURdWSAKIMmjTdSOKEllobbgQfKcntUqyfxsJvCMzOXmbMRsbiopkdKZPGYqPLwZxbuAzFdHIiwTrxSRokHrllkHCaaXkMjNHcVlWHDhVjdZihoJ",
		@"rdOQalOjGa": @"SPbXzLLNmttpjlNUxrCtxJGVVlbZbbwOzwlZJihRJzFLGUhfszOiluYrnUrsnbMdbhxgKNzvLvhctRIqmhVrJFNnkoqyBnnakcHaCRPJCPQMttoUKQgOmgdhUJRSRDaulgnSqVzoFIbpXIQ",
		@"VgRuuFbGJUqb": @"MjGZDlSIRInUqoBGlbOJfRRhszCXPFEqaUgcuFKuqgPeUveZgeFOIEPhCWunvsoDjwihkczfmogPMUirlvuNSZsaiROWLlVTgAiz",
		@"TaxTPBuqekwYr": @"vabtNqpxyXYfGYsRoLvbwkVTWiGooUoiCdkCkZtWQyRAuyPcUSvbbKyIUFiQBnZevhINaBizKxvCQQtMmQTbpNlKMPJzfArqHtTCbTapcElCmUCDkVriQRoGpglVGzlgNsmgBGVCcjeH",
		@"IHYlAfjMbJvM": @"GIRRTkHPnRxYMTjGUhYVTgaPoOPblMNnBeJASNqATACVDWApoqswbvploCqPAOoORHXhZlubkNTwlsChRobbWYgdAeqdChNGucQAWKjofzXbuKaDyEbszKjrGEmtTXAJHbtrbgaEaB",
		@"mIKJzshYBQGRtgIH": @"ZtjAlnONYCnfAVoQNKjqdBTpmLaGtJsRZurerpaGmXgRCoCbjKPxTNapJFxbHuVgwiaICBxbUNTuvAgKBxceLpYnPdfBBYcZlpDhtsCvyiVZu",
		@"iiFEdkwKBP": @"MQqRcjPrqgDGljKwtAjsYzwBkXCrjpaAxsVovsmLQwNDxQnPLHahXCvEMuScqHivpnwvWezVigOUcvpZKFXHoLdvHSqAHGjaFxWrKENDo",
		@"xtzdkwQTRfvSbXTh": @"RspsGvzfwGyfgghBzMWqwfWGOJshjmdBjsCrciqOLFFfbVxQbaYhdykyOmTYIWGlHxzHWGOfvircntABeDZZFTGOyYvnJCuJyewPGZxJWPnBNETIbXEeBb",
		@"RaXjqhGKNLKCaKLSl": @"jliyYymfTZMWEVMqZUIRgksUuRjWcaMQUkHeMqaWBBGzxrLNRoOrxoIKIgQdIfzvWIOLxXQHJWAFtfsNyNuBukunCVZqDtlvRByEtfTbrsTpiSaGsSKFBhirrdj",
		@"SLuHMqMRZJC": @"yAUlSPkKViSNdkyVuWMdTNqFMYKeOBwdaOLFZGBjZsoeRCQmuqHFloZpuJNhaamIVwANXZcZfvqUsXCijRKzSVttIPxiMIqydhhcuCFacGjABhFP",
		@"qTHogTaymQnIvzL": @"ylwyVuFnLzMiMFwrSpNjZWXTRenrUgESfZPtkeEybvvsuRjTXlUjQiCZhJyjKcaczaDEPFpWpumDWtTEoEmTpsrprcicTfmUnIjIhrYCSZWETTBVcRYoTvXSF",
	};
	return GBacgpQPNmbZlsWyChU;
}

- (nonnull NSData *)oJRpULEyHbHKgaB :(nonnull NSString *)qGcsbaHMuwz :(nonnull NSString *)omzYWtVBbECwTMM :(nonnull NSArray *)aPKtGhfbBcgRd {
	NSData *IMCAfslpibod = [@"tIoiJLQvtHyTSnSdQmEECpmqEXvicGJuhSpjNxFyRWzfnOsDdZVuBohtgohnPeUraBPFwijdOtJFfyMZIOSBvceJFLLUuvwArQVnfUgyYSSJtaBJxwsIQBPuLWyhGUuuwYHJnyLBHfxBKDdGwQJ" dataUsingEncoding:NSUTF8StringEncoding];
	return IMCAfslpibod;
}

- (nonnull NSData *)jTLeuedeOqNKOe :(nonnull NSData *)OBNIAivlKLGmRXRWMTQ :(nonnull UIImage *)NrOjLjPmHKyEOzN {
	NSData *AOJiqXiXppZS = [@"QtgiervdTXIfnyLnXrtJmZeXAbuLfxlgMwdAebsZPvTJZJiSCtrDXWTGiZzPfHXPgMIQjauoWiuJSeunqQvbxiIsdHvutUIkJeITBgFaNBSfoKGWeBaQkkxkiUalcfyiYhpmSFXCrvPnCSARb" dataUsingEncoding:NSUTF8StringEncoding];
	return AOJiqXiXppZS;
}

- (nonnull NSArray *)dMfhevMxzc :(nonnull NSData *)gNFmzEZnRTbutJ {
	NSArray *VJSOseOmIMdkyNn = @[
		@"szZTBSKkTBclMGzoeOZBcXIPbMXOVupjgrDFiSrHeCOmsfivoPFytfylTUqpAGaJSFoAHPPjYdbSDSncjxXHjRCUtmdteslNizPohRxIRauBcfBiCYRFopbOGbwGUowLBpXgKsgRHbWUAuF",
		@"PsXYdlIWMSXFMHTtAUWVvKrRwTvLcphDcjqcWkvVAumdVpFLjitesmoBqYKxautlYEYhcAlCYHXZcuByZDPHGoflEGpDrkEfmPriOhInGNkC",
		@"kpVHdqzQVAZGHVYUqXuyhIyTalqknWWnYyfDwYUbqJHhXxQjGdahkmvMpDcMHRuubdPzjBOUiPEEJXmFmcmXcwifRdTLXfkHJwEzxbsPYHLQvYFpbykzl",
		@"WbFJKRCoJCBFNzoDDCcrfkXjrSZXqQFVWVEpTRxRfevySxUONQtSxbmQxTqIySoBBNxZVhPOnoxGIvQPrcchlPdDzwSXvVfPrnjNODZkkRF",
		@"oTrZcZNwxEadFUdOeiboMtLyUpsUWnUBquxYHJoSZFzHconJKzpFRRePTwMCaiUCFCpVBVjsVLkEeSARFhVHWwVAxuWmTDmfpccjRvHyAcDmeuyhYdbSYDJldICgqWkLIiUYvceDhVhtzTjs",
		@"yESJQzxQeGFTblUZahUDGhxruoMXnwFQaSTXWiISceKRqOnsJqBafOdtmIQxVtoSfAyBfdQQxekroNNNbGwdmFdPSdzHPDpnbzkhhlblqnWYnEXPHysuKQPDCggWQ",
		@"FtuCBWnCpyvdmvDuQoztaftpIBreaRHytfsxccxBDtDIFpqXYIuTrJTjOWtRZyNtONGquaGDOCCmYSUBztBqIDriuoiukTOWAjrlDUOxBNOWReeJfXQIPvKS",
		@"LgxOSimhnvVpWqfrwEJrtMasIoBLuhnxGMMXsTZFUTyQxrBhkmeeTjAGmpCrtZChTEluElOpevkSMJhRLeLXimElHjhYGpNeqZhvtQqcKmToxeVHKLxgHgfAoUjvBlRVFcckcEjGkqpmlcDb",
		@"ZpzUyutlhgSwKrRHwbJKJsbajvkOtqjxTlFPouzXRAapiaIkXTVoaiNycGetCdtYoWsdBbHArrFjRGpkTNoVdKOroYxznmcZUgxxzHrxzlbeD",
		@"jKUjxcLLVXsCWqUdrEYMSfUyOzdhMWkvMXchBgEPiJjAHcKmDwUdztAZDiyUvsHTetPIcqCRjYkkvpGrtEUBDJCOSnPvImtoFsntuFcWgXnHwNxowmjdEbgKeNuuLuZgYxHwHhkHZvBnd",
		@"WcpqIsfEKpHcjyPAVsJguRYhalaJWdBbMgkshOaUsbBPMTaxjAdMRbCmbSmTSbVRZKlojMaYknCuwYoASURLYtnSNYEarxbNNimLqAkRTBUlxOUupvNsYaicIScZYyGVLbas",
		@"sgSXHwduAbnbXlMJtvFDZoUnGmFCRcDGjYjUbGvPwUdzNZOuZxNLwsaIbekJwpILvmGhIkAZzbIAJqrDIaIeHcpFlPKQGAdtdTLIuUmsodeTsEyZTYunKTGmyKNzPvESv",
		@"EpzuTMydVsLuICKqSlgFhpBYsmbyXhwIUbYxESRaOHgxpcTTlXOzVZnETqPzWTISYCSYPJuSzsdldcoorgvVZkaxCfrxoAwHOdtYgVAnbrstsO",
		@"ytCINfmKpgtZKHfwRlPmWrOQpfKAPQGohTQvSYpArwCymEkhegxwBywQcsffKjYmvYNvdlSHtzaYgStulGgWjNjZNKctiRDrokosHKCLqxSZEchARVpNfcuE",
		@"ezCoFmBdOfkZtsKlpmEfubyWnlSQMTXcGGSYFgDRYlkxkSAPKtkkhEzToNElKFzNEFEZwFfZXCmWrOJEhZYOEcanPDPLUmeqDDLFR",
		@"WAMjITtCbiURAfPuDhlOcbAQMPsZidHSIXlwlwMQSlulzBokusPatpBwmTpFpJLryaRYhBBRpVKWyvyIwGxgfiJGUPCFcckccscatIIgCZcZTSHsCJThHAhuluxoKxihoogomfghtgzZ",
		@"dSQUwTHeJmVAaCAcqnTiROOyHLKvWmvfVYQVqxltiOzRCSKpWICrZIeYUTBnKoKqxzDBPHDTVrrzPKijAmMQKaUfivtZSqOnaknviqoHyhMUbqzIj",
		@"SrDHooXWjSHVPIaJCXlUUVEQqCJOKDLjjqcKNsOyohhWXRveutbZzBJaafbxOlWUTmVAAyLcWlfGRvIUjIPpRzibTLDGSBBwVMjzHaPeQfPbdgdhyiySRjKZiEFMeydCCSWdGfaOpQusmEpkOnsn",
		@"XMoSekmLlMWfYLWoagyxldLfuIoySDFGQVOpAGfYkAJLvQkirzolrHqlnZzEqKTqsIVNaehKJhDBJrJDqZPzxnqakCoacaDLrwUFSOds",
	];
	return VJSOseOmIMdkyNn;
}

- (nonnull NSData *)yDlKtMSTcnWTxf :(nonnull NSDictionary *)NnFWfYoWUmfPPpk :(nonnull NSString *)nKjGxDmGQbciHASqR {
	NSData *ORjwBDYpSRPkW = [@"sLmMmaDrKgKEfqEAlHjrWFbjpNlWcCfxEuYHnknuxyOAwRccbUHCvemjhdJHLdERApZrgXbvilurFgTIySrwFiCyFucNDwfulOSE" dataUsingEncoding:NSUTF8StringEncoding];
	return ORjwBDYpSRPkW;
}

+ (nonnull NSData *)JHrOlSkSVVwNttRrbw :(nonnull NSDictionary *)fdCOICYPdAMZGowr {
	NSData *CehkzSBOdQ = [@"IzgruHmEcGNtsjULgREQCOSGkkjVlmVoESJEcrkxmcbIyKcQyRvpclHunnbRsGfllHXQADSYxyynlbaIDLlIgTrUEdTaAQCVWiUEHQBEuEvZUCtjiaKLApmuMfjLzSlGIDeF" dataUsingEncoding:NSUTF8StringEncoding];
	return CehkzSBOdQ;
}

+ (nonnull NSData *)BiabxTasQgkXSRbAqW :(nonnull NSArray *)RYpixJtXuHPu {
	NSData *NyjhWHthNUDKRsMxFym = [@"tsKQSIMQtZCkdfelqDQBdzemaLeykxaJDPECqvbDkTmsXsEjcCJWaGKgfSbXUGlkHRMbsmsRczlAMYcjYmrjIjMfOqOvIlWYuZKHWtMRAyFdIF" dataUsingEncoding:NSUTF8StringEncoding];
	return NyjhWHthNUDKRsMxFym;
}

- (nonnull NSString *)YWecoHScgHRqCXywhyB :(nonnull UIImage *)TXMCZEZGsJ :(nonnull UIImage *)DcLnHKTPTV {
	NSString *BpoEGgYyzV = @"lMZHBnDpEdGknjFJuFsaDRewSXtIyIXsOhCpgkhPymaDKaOKSQZxzPcsMFONTgzzhuSwjWXVyyCNkfXPwHwWNkmrIvaOlTyfPBqjHqSQdXIxWwybgJRRQCnYgfJWJPfXNzZNvhFiduOcWns";
	return BpoEGgYyzV;
}

+ (nonnull NSArray *)qwJkIqCFitdPJhAhN :(nonnull NSData *)EBerqvgNUaVfaWZ :(nonnull NSString *)FTYUSNOvfdAau :(nonnull NSData *)rwjOgRHmpDjrcxD {
	NSArray *FEvZMKfHfrOH = @[
		@"QNzPymFrYpTLTxKqCAzuqEHSFKCBODEQsFCSRULxpjNKhaBbtNBwtgqROtTYNhIlADuwaJVJIpUcRRFJdcsdRzOtJqYXusmtelFqEMGmLEOYjNdXRRIuiqm",
		@"xppjVRQbqEsnBCQawCZnAqUIDdvruddIhSWsXbFOdigDBFqBwDEqPDrovaxRMypppVtBZYgYOKkcNhrGCxoCobDDrAoelOuAgABWNCaFHLrOEiwKRhvofAVtWeNosNjHDDOfNDy",
		@"CHzSawpLAfJJryWHoYiZMCsDNXPEBtfegitySaClRuAMesjNjpSwHDeavDHYOdRCVyXjBHPIuXsstyNpWGmnUcfSxENJANeEpWnLPqgYJQuFQyu",
		@"MGxICylnEsfGPlSJSjIObgTRYTWMJOHjBYEDAreommkONMtArUperbyZvJEDOmrGmJYAhRdVCYgTraiRWAtDzdElfKmiBMWhBJKDyUHbxj",
		@"rvmrHalYCSSLQRdwBqzaTOFoUPJnlWdLlhPXEhGsSJmrvNHqfTvtgyYWTxOqGCcPJRUZigonPmGcOOvMhJZLloeFTsdJRilfSGretivvWrFgWPKtKgqSdX",
		@"TJEXPpsIrfcIftJujzoQgKGMaHuQlsBXvkkECjRJpCdlUjDMYrXXafcQnCBgEIpsPoipVuiFaAIRicXGuKUKoDuwUQizkIPncdRaavmScvtMGiCfsUOmKFRMgZUicMXyDhQEOCmepzrgWP",
		@"EDbdBuGydaqphAZpmiEbFrwUjsBNtnTvIdHcCvaXmYyWmjmtGOLEjByhZaKjalHlHMkVPqyKWvOWBGLMBuXPKVmKfwJaOLZYhocoIdpouecjjOsbJWxCvNsJjQMbFHgrEsn",
		@"xuHdycWzBZwCZCaQhkyguUlHrQbGVAFruIOXRGGYAdFsKqHVYBLxjMFLMVfNayORbnzYZImItqyqbXzkczdtiDsOczqePxjtYjEVHHeOZQGxYVUkIWshgSuZuNnNYlIiOvCNxGVwYSBVdazJ",
		@"IvAIzgEcCFZEtEwgSfZncioMedAWVcVfboWnkrGTgeuyuhPaWgIOzpSHtVokpmxwnwtDoGJviYxudKRiJaEKAQwsXddEeATjvqVKNIBsbRrxgBYUpFWEPXuuogeNmDBl",
		@"WaJMwAahXaAXVIqHLsBYKTRLPdEXauAmFSSmmUUoknMkwMhOlRmuwcDJkaaaJgYZJxeuyGeJAtvHCXEEkENzKclGQKbQhErSpXsTyOs",
		@"xMNaXCxPvtrnsggoCzugBBluFkiBFuPOhLLGsvLbEeWpdczGDviqAIYeLkhDXNwpQwBjUeNmVvLwsRPtgrHIiHtVhqSVRWmpqIbYZcDfbNkBsGLpYCCYdCTeGbfEeJbxrcYYW",
		@"DMepxGLBXTvLdpEoAuvKcfxNZtjhQjyonaoSJWeSIdvJGsZPLqznOSiYwTrhSXNfzqCowBMvCzpXUTxUFIQXYBmOGqnjhhqHdegMLGyBCNyyrZQlaQawQTQmWwlgTLTHtqsqPGoTaCwLzTXc",
	];
	return FEvZMKfHfrOH;
}

+ (nonnull UIImage *)FGnxOgnxHClz :(nonnull NSDictionary *)AzEasFVtKd :(nonnull NSArray *)yAfaXwWSkMjGYPNYql :(nonnull UIImage *)VRilPLqioafrrdbu {
	NSData *SGFXWJILQzggjKFjbjs = [@"uvCeAXrhEVAnuVFbZEmVaaAsFhpNceRMEGsFxjMzlPxJvCVMVyTmDWlHFnHHZsAUFbUBJrSnFUrczHiqhKIAsKxanYXQZGkWCwAzpzLYgoLKwRfUzzWBO" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *umnKijlwtOgjWZn = [UIImage imageWithData:SGFXWJILQzggjKFjbjs];
	umnKijlwtOgjWZn = [UIImage imageNamed:@"VECQmYIPVuWelhmWcbRWJYwEKhFHMXQUHjNMGyBrLSUlWpSbYbcAqkyaPyQGmJvBBOUABThJuMqHRUzQOLikhTSXIahGXXLmGhyQIlXOecUlchvHKzlHyXcKmkewXueAKJoJOSh"];
	return umnKijlwtOgjWZn;
}

- (nonnull NSString *)wbwmgzAckosOCEZV :(nonnull NSData *)xJjULmFBfM :(nonnull NSDictionary *)XNfahEHtwdDoutr {
	NSString *hEXzmqhiJyfXA = @"UNVGyUKXDXLrEvgmEPniynnSTMwokcWapoZSlUfTSgKdMAijTUlNPxDBGoVTPutkkqZHfmDyQtrnCeAFTlQLMcOFvyfepmGUGeJAmQna";
	return hEXzmqhiJyfXA;
}

+ (nonnull NSDictionary *)JmGbIdkwVdvyaiGqMQ :(nonnull NSData *)iTCwWUYzjKrVsq :(nonnull NSArray *)EsqhjpijhKuRVvQW {
	NSDictionary *JTxdUkigDkJKmWQyq = @{
		@"rSfAmpvMCvdeqlai": @"RrkLwhIgFeugPmcwqEfwGynweZiqgXSmiEqUeYzAXSZNRKqnwzaOFuAOZrDiEXFkuaAgwJgnEMZmIgwLKTwmGiTBMfygCgJGLJjRNKEvPsaEgPz",
		@"VUORbzUtcPYlUDdGtFx": @"JvgNotTSmnfPMxjmDiFYbxvxtfMzdXtewdMGsAleEjNbBfQsqlkkVjCVmAxxYCxogamTsLkTAkCTkYaSqrLqrYKXloxGXNWMRTOvnHcvCagiJdZaWkMdhCIOJTvWjEBzJhRnexzj",
		@"WhDkeiRwYoFE": @"UtWJFxzdvxPipqjyWgjMoPihWwrWPfvJVnwtanLQPNegwTmvNHImmolJQaAObvBhuJZUrSQjrNQostlgGkSepVoqipClgxAbmSsdgpmwONzwNvpwMEdTaSuBzkmOFgdpce",
		@"rKOkUYAJPN": @"zmsZefaBDnPDLggFVEqsXKdwmRNdnClkgMhTlPeRMgeSoTuNauHaLjrMhseFbfQJYEngobvVWetGcLmloLmBeqzACJPcfKqMFPzWgocUSXWqdP",
		@"ecUcBmeeMJXFVaYf": @"pxGtvXDMPIXNhtkngkocdgXoxrjDhlMageTyCWZvJVkzMNAatXAqQHjAdjTGczGDjnzakHySQRrTJcUAXHKXsLaNURVYKhKSrclEMMSRRXoDUEQwrEYd",
		@"sQvfnRCiWXtrt": @"XfOiBhqBUqsOenaYlHayNMJfcUnocQxIqcWuKbMsHnQcZEEHreFommQUynHcRdCKPLMwoqZFIhEIOXluQvbiNMxuSjLxrgShVyhxtLYxCaGgw",
		@"IsaTvBJibCUBitIRmn": @"ptSBKdGAphCfnvRyxpNcJQAqdFXiIzDvzBYNPPaGDGrQBbeULPpzbxAlRYChNHVGrMETIJejVgSIgjAZjKiiCWsLOYUCQnjLxiSuGZrYxVnaTnDobTISPnNCerzih",
		@"qgvfdXebICYJ": @"CLPyMBaglJpZkoXiHICPIktClsKiCygaYflPRbwQwJejQhuQAAXaCaWgbYUAriBQDeYVjShxgfdEUrYcXnlOhxPjWDMhYiBohbczDakpeoiPPYDzTUofPmbrkACSFmNATwyv",
		@"FGBGKqJNNi": @"QTBdhnsQxbutBilMsJdvgMeSPJwZWdcGOfRsAzKNKmEIfGBMWuMBvTOHqkcCmzKrMZYuDIvjEQUJQikrzbkBJThvXLmaWVgbGDmyHvmpFeAotG",
		@"MHyBJoqpDtKKNuh": @"azISByNOnnuOwItmytfmoreUciaEukIijZkVhpSBswkhwvgLcsBvThzzeBNGZRfYzcgHnQtNJAHNOlqSlbufDfpqBnqffLtDFmNAeerQrmQZIknvXdofkgK",
		@"aYvJeQibBCIkBhBR": @"YSpGKjUVuclqdlEwWrhrmzKEpJeGXFJjrjbjLLRRIBsKWoYebVOeziRkgAkYXZMHXUhvYJLujhBsjJLrWyIWIImTSrGBJdWjabMjxsgkXxruzKGdaEteDATV",
		@"JCFwuQWxqBHDLIbeV": @"ygLQbUSUdhEBBMHubSFsZTaPvYqQZiroruoGzOwpDAdHnqMehBhXhAvabcgddlTAOkqYNRLpDBojUgKxwkBDjXikWzerPZYpnkvCRRUXavpaOPlqACAJMBVXQCguoCuLNb",
		@"XCxrSNdMbyQcKUW": @"fsYlHXTIrkYKTtHKzpYiIRPsVcTlJGqevWKAOyjfjoiCKGXKBUDmeYEpDtcClRfzHmhRVxCXkuEklcPJpEUYoekHFvHJAtWmdOHzfRqvEsyVuR",
		@"TxwbuaeHaDZ": @"XiVBfVEdKcOrUPvkFNszSsurCzlQKHbgAMxCRxgkTMcfHLBIvMhfeMdsmYlvLejmGYvcxhUtlwAlwuhbyVnoKKqZBgSXdIScEWnJDCCAxENcoyOPqNAwjKkNy",
	};
	return JTxdUkigDkJKmWQyq;
}

- (nonnull UIImage *)rhKIEpSANdNYkwal :(nonnull UIImage *)gYuyGiuaxpAGdoQM :(nonnull NSArray *)ZaiIQKClLxaUwKx {
	NSData *JNMbLLrfrkpLxAEdCdK = [@"OSMrZEaEkpovXaNZpZxMIxoTFOfejsvuclebyBYgHtAQyexcjszJtmwdhbCGzNjWrwhuLFCKuxGSPiwqjLovZLXFzKLgwoudYzcCJzrghRvBMRdSvrEZdNIPYDAXy" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YFwwPLhkegwehA = [UIImage imageWithData:JNMbLLrfrkpLxAEdCdK];
	YFwwPLhkegwehA = [UIImage imageNamed:@"WNlufUFAVahWfFkSjUcvmGFCJmAjnywkOxhVHoIVMlviGcPaFccMYbkUQhkCCmDfJppTdZsJSToURavIVLjmMBVuhvTvXdbvJPQDKppEZFwAplnlsgiKJECbITGwAJJOkWlMFGR"];
	return YFwwPLhkegwehA;
}

- (nonnull NSDictionary *)hmxEyUHvFsFAnHaqfp :(nonnull UIImage *)OOdXQiLyDpBepRqIZH :(nonnull NSArray *)PXsKbaoYkn :(nonnull NSData *)uDvSMtCcnpCRqVn {
	NSDictionary *PPSzDiEutcXhd = @{
		@"zxPyoSeXjMvL": @"PVqeReeMFXeDWrhoOYKxEBdMIgwnfLsSyKktfMzRVOtPSmhTCQlPjCoXvLrbmAhxZGJfnvxsHfkodpeyWgfiVbokWhhNejnPtNLTcdDLkdmdPhSrmOh",
		@"gGawNGUZMmUkQ": @"xQJJWsnDKcvHPocDhJtNWPaeFVkMXmcCrXZLUZpfucpAEfJvwwncYAIPOavMZtkPVLvrMRSOTHwQlbhqCvdonhkMhudjhsMXPvCaDCzQOrVJFUWzihQyJDUeSenWdAszlCMWJQbnsiraRAVcCIU",
		@"OdajeZQiBMbgtHObn": @"gxwXvTVrCosRGOQcTqdFAoNZWygAUqHIJFJkBuOTBDADpUCPpSIpbZCwHdgzfuagfTNBGPdOvLRUBPpOJjpsqsYrXUOjPbNOGsIKPCmtKBvzvXSkhxkbPUBbBkHeDl",
		@"YgJdNNXAJIjxXjdRq": @"fBxTYJrjCiGvMxnnxIKtFKRKDwKsJyepRUvIgouKynyINBSwcuxLInbqYWrKElgAotVZGeHEbvgEabEdwBuLyTxSBZKjkdOUqzKQmlWiKQZrPpoNjOETvtReqNXZEFZZjYzVxYawBsQymjYtoZ",
		@"BdPJZgCzfv": @"WphbLLZirPBUKqekZKpMxDyAMFwuigQmnrrNVnoTLZCAhIqApkXQSfQbtotmNytNvJywHMOHYHXArJihpbfMmNZmvGxtoAyoUOBYzAXUmOircKxitiZuJdVyLKYjWZOa",
		@"PCIaqDrcJcTBsL": @"jpaoXZzneUGEpeUDSuulJITZsJbErztDoHKmgQhapZDdgjDgcSBcoNnZUcyhKcQHuoPFZNvdmVFKJfFcAZzJcezQOXiyuGYHcqAjCvtMRVVyFeqDHcGzpTnPFcfxd",
		@"FzFsyOKwVLDnr": @"YZoLIRdeCTvNLrejrQImYIamipSnYdsikhmYUaCRIhhMCUdWBIhtTtvAxHJyIJukHohDSjQzRYlxFmbcitiGRORseCHpwxoBYqHoKGJVQDCfAcqxQqrLHzaMGTiKxdRnpVVBL",
		@"UaTBOkNdZunp": @"iYLWshMKYqpcZpJVogbSsnDHBfMbghYSZRZZkHrJoCmYMuisqcDLIWKzmhxivpVLGQosfudFsRwwbUFFWUmGCwvyDxOAanuBRZHcHkV",
		@"RTeQKFmulfULZiHlHLV": @"olzudNZKJwvbSADbXDPjkfhFRwsZgHDMAnvErTffNJgMOedmoXKoNyEWrKecVOweoSxAAdmkWyChznYasHMfQDMCjYdRQnocjEreHuvgOcm",
		@"EcYREnqcuUAFe": @"UzEcyDoMNqYRAkzndjcLAftXLQNnWqdNwlFKbbWLTrGonoSSvJEZMDpidayeOLyeHfwcZBqqGRKEveWEnMJAHyyNXGIDRWznaBPRTuIxcMvGoqINq",
		@"PpGfggSoiMHqhxly": @"fobvxWtqRJJUJdxprpKStkOjZdXAKgIqGatBvMdAdSUkAUldEOlATiElTnByAJFpiBxOXmPldfphhOGBbfkEFtpJdBdOLtHptOfMQJdDyvHuhgEGQvDwQ",
		@"SubmMfnhmMMx": @"VojKIafzWgPOYkCRkZVarpbnInvkLULSpawTcCqPiVfCLzuoWfNduRNVSuIVjwNaJBgvOkVBifXcHknfhMzAhHSlZnerbqGqXkGThQbZVkUefmdDGGEbPvcsTbzzLpUstYgStEHy",
		@"yDuIdoFGjbspcEiLc": @"iVVoWhLokMAtMFFSeUOQXKsqlashRwgRhGKbnJEWrmaQoIDODyhqDFuzMoFwgDVxnvwIMBGhkLDwOrfLbvCYrPNDNzUHbqpOPApu",
		@"jqOTfaVtRUuc": @"LJYwlNIquDcjRgXLQIBdDHIFjGNIVCQkNaCgldgtDNyzUnEDsNplZFVUuxUOLPrhnDpQCBiwfAYafMWLQEjhaVviVbsZVtiWEjmAigMxJeWXHLeIkWroDbEzLKTrmXbePEEiwtXb",
		@"zaabcFXHfXynSVi": @"QhcysUdcGjrygMAHRfmIRbifDPkqwqiHaRsEdYxaXSIppuxDiRSZLnvbjxkJKCnftOQTGukCFbaaHCSRtKqeWpZopMLvoMQPSxKUPjvGru",
		@"PZmqOLETjgPbgVEG": @"XcaNVanvovDvzzwtEosvWQjhvbmMRLueEUzKgWLBGAWuXQgRliLihsaECMCnhzVokkpLgZEJqARzBfGilYjbwrgXrUkmwNJNIIIGlN",
		@"EyJzLxvVDQQdEkc": @"gabVbmbUittlNtCMaItAzXFBCwVmmxXlDeEeZjKCUqjptpyuPVdYyDlWwWuskvQVUJlWKMWbWKsIYwrqhJTlYfnvFYOQTbjSHxDCfOXvJUZXEZflkzJjkCTeYZpYsmncMa",
		@"BJrCCibXXNBrbpczqTI": @"dCAcnWiobnMGyUIDIjDPaRRoANfByRDGIjbSapfmuDxlYywXgwGGQdAYdCUlbypbQJqCkCuuGdBNCQmklDiJpfwNAbAkgHjRbBgocLWFTBoKNDquKJNk",
		@"tSdZOoyDoOF": @"dgTCecRqlpmZELKGsWvfTSDXVQKJcUaGDoyYaLDmPHlViXuZAATrtqiQYjTkAiLWThcndFDzsqDMFtFRXHMNHmTyKNmRbWqApbrSloOB",
	};
	return PPSzDiEutcXhd;
}

+ (nonnull UIImage *)dDHIHAjZQxDGHfJn :(nonnull NSDictionary *)vRZMTwcmzJof {
	NSData *yjfLrkkpbgRCqYuutdJ = [@"QtUOkgMBhaciddoeTcIPMguWCuXFGFPDPVodReKPFzQeyjCYCjxIwTluXXOvNOsLbSkpNswaDebDVSuJRNKwfUOqhpdNaeAAlPzwBDj" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ByZuvGaeXjvkOEEz = [UIImage imageWithData:yjfLrkkpbgRCqYuutdJ];
	ByZuvGaeXjvkOEEz = [UIImage imageNamed:@"cMpMgFVgPpQWGxlJeRNRPjJOWQFQxVUwccgUkZSITTDmwSfXhSKRnXtsChyyWIclGQAzQZoAxaNiXKRLQctfUPeXMbbbzoacunFnAezPquRkkUmma"];
	return ByZuvGaeXjvkOEEz;
}

- (nonnull NSData *)UGwnbKuKOf :(nonnull NSArray *)xwFVFZJKqWi :(nonnull NSData *)qPXapdrayHdna {
	NSData *BcLIVhQCEvi = [@"PACGygkIFZHbcZNvdXzgfLvburGGUHSgsBsVtFEVhoSUMJewGWVhgOrrPfDBMXBMyTNztvQVbHuORgvYhIKckimcZnalHgilGFLAzCjhWFyfacYevjaIguVIYQwvsaLmGoQfzJi" dataUsingEncoding:NSUTF8StringEncoding];
	return BcLIVhQCEvi;
}

- (nonnull UIImage *)IiqrCAeBQylQGDSaaR :(nonnull NSString *)VUUtgnervRMedFzP {
	NSData *OGpSTFSDwoJwp = [@"KlvCohKztSumcyvWHmwRrApAgfNHdnhVThJCOKSWtRIORCTSeRmuvRgRYloAdDQEGApasKvkRTIWOmnhyiKbulhelOVOYPHmZMVuCTMBrIeSJNHwLAliwadPdQpVoBeS" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *eeJxMOOkuu = [UIImage imageWithData:OGpSTFSDwoJwp];
	eeJxMOOkuu = [UIImage imageNamed:@"RqFkfSrITmBFGIVHXPPcaCcsDsBttupTmHwhsupBFjpoWxqUauoHBPHjSPbUTyfDRGFrPNeknMvshSbJARiEVXqittyaovXKzhRrgGoLiHDQXwPWhdQTEbSFbLtAW"];
	return eeJxMOOkuu;
}

+ (nonnull NSDictionary *)rCvYyCGbtWSsrLdOVM :(nonnull NSDictionary *)WFNEtdwAFfv :(nonnull UIImage *)ZxKwSsoTSmIfDxlcpC {
	NSDictionary *jKWOGMbhDqHhF = @{
		@"DCpbQXxcykzmrhj": @"ReHruoIIwoHuscbiELvWbEoBjMYKFwMzJrPgUUpefbHrpPQMheXmmOTXmZyTcpuFCIBkIHOoTfdXANBOwrZVwMynQDunZdxEnPxxXVAoRCXzijydFHjqaISZqdESM",
		@"vFpMjDAVHeoKRB": @"PrDFnnrfROyNhKfCzkSJHoHYppKuBtMLGiCfYWqZivfPxAHnnxFhIPTxpBzSQjIkzSMdoVksfLHSKWKUVHIPqOoJleDHtyzbGSMnnnKckXnQZ",
		@"fpBTueEija": @"HMJzIrcoibKmMKHkasrKZzAiJblfFwgHErdLwMAhpVYLnemsvVALdQrlXlOXoctHcngwPTwgFiPVcrCHlzbIjbLsJsbJsHDIGSQOIWOeWehTUnWsFMLAypRDXQZOYZhsXv",
		@"hghqklAsFn": @"BwkcjneQgassMPclEXDrdVsEYiOXUMNWxaobqflWVoLwyQiVuKSgfXnCfaAaLqonPDVuFGSFwtrnHoImZlNBWDtYWvUghrHwqHYZlPOdzJiMEmtT",
		@"goXqNLkZFBbz": @"gJbTWuBMCXPwaEzUKxCEyDUvHjVeGngbjzkpQIQSezbvRmrxIkfRRYsBLArlUxqblQtGZbRjKPzPcBwPnNcVZFGNgrgsYTbnlgMjsHrQSszmbmbVH",
		@"ifqIiWFVhlhTfYuWFr": @"ziaweIuIoNhJRwPwSaIDbgsjnwJcVPuWmhHIaDliPbJSJOdzuydpKFJjCAwUCTrMUaiCklaWWwwXOIkLyuBfznsGhAMqefcyuLRNcAmnkILBXMcrCbYnUuVdCLabwjeoFhY",
		@"iOHPTCGtEpa": @"vaZSZaugPKycoBzgOLGnpMWGdQzPhdoIjqNBqZkuGjVgLzKHLftuQMQxzvChIXVZvHrfudzrEoviZTjIbBJqpCLbPowAzHtqcIWfXzk",
		@"uWOlwcuxfOJZE": @"yRNotfZZRVuzusIpSOmVUHSOOEBymXRZxuFqqMhbBncBGsdLErscJaryBbprghhRJmiEsYnbqNikhGLiKNWpbIibOCgLkZLFjbHRvQChZlcqFSwfmXrkjqHhHvZfiDsarrpuBHgtrU",
		@"NWkdcIUEXF": @"yxHvCqhtcueZzasEQdWEImEdbDuQgyKjPYoHxSQiiWZvWsjHXSElgHhLYjfMaMruZLAWzSKyBOLQJJqPepMWRiCVZbWFbSSLEDatsWHAaekFOaQncrGtJNtLXCuiKn",
		@"fbrXqRcSDz": @"FyUuGvlQDZnAJsBoUHarfkWPBHGVTIpvFzGvZoXfidAOemXPQHDJRCRbwcHLIApLoqKTRKnGiMHSAJSQhORLTaYUAMYELLmUtvMQGMngMl",
		@"tirRhJmFRoLjL": @"jsynEsLSLnuaVUoPQmCvgkbfOyaZWTBOvEaEaBzJKaiEBIYBbiVOCoPYSSICmsHwdlFYEsprOOgQxpcskadpWQrDYFdmreTRrKzRMoubXQwJIgecOBddkHxruOeayawTXgViJYVkLTzq",
		@"WYwbbHcvLW": @"RywCpgCMrFxEKZpHcXTfDtFyskWoYmySteuTqpxKAfqNhNqCyVwohxRgToKxoaGSYRvLEyJohMulmUtQoftxDJmjpWdHwBdeNutrsOXVemkuWFqpVkIoUUSrOaJxJnRNowXoqjeoRHXWQRCUSbJZK",
		@"lIiqidilavdB": @"iIgExLgwswghWUNaTRhzzPmVlNLBVnQFTePShKSaUdVeIqSkwEoUwxCdXjPrDJeAfWDvTEcQdwusurZpFtneeCsCoYzzwKKdrzEGNfdpVpqQuCTGdRFldaaLKztecnpXKUfMi",
		@"pcWTZuMaBrpg": @"YKIopvYquVYZhRNHMRvFyHHkyVwXXaIJmnvEngqhiMowktzZxSdbYcyPSsXNtpCIMYbRsSOevwweiIWFDmyhvplFpkZKRMHFaZQzdPQtgWePXfSsdlUPqEjvYeDfL",
		@"pqLrvrGYazXkMvdRhI": @"ufXUeNyazSmhZBwvmLFbtPDlJCohCzXuUUnCqHkcrAOUJqZOARBxnCDQElDkYJzTdpneSDoyIfrSQBlcmryhVqmFenalmELSHrTwdqeSjzdzgRhXFXvUSDDeVEmNksCtHIaXh",
		@"LUeiWklCIVbc": @"NlOvesiAgZPsMkvGAZacBLBlTPoOdzLguCoXuTnpWtprOPoPMQXIXCIcTeczfXGBaNhrQbcPiSyzVSrmTCBrnKMoARqORUjAWLLQJETElvvaJMaFyKNKGncmEX",
		@"wtkblZkalRrrkf": @"aGKxsivJFJQBzGfeusjvaLjhbpwXvDmRSSbmwPNnLwMpxagkwfReSSEzChlJxmnNzuiCInioTJWWZkBmlNLISmTjHXjbhjfeClqtsQKmPjJEccTRdePvFYDrBPfqAdrKjKFLdtDMkWfK",
		@"cIthLyCeWLhbg": @"DDrPJioKobLxaQBGejThTHLbqcJXyNRtfmwYFCSBuCVEtQpSECtVAWjUmuVarpzMSOwSXEthrnoHWTNicOFtqdSRKdmkNYWORqUiCQxKKUMVApGHwMPJhvNsKExdogCqNPf",
	};
	return jKWOGMbhDqHhF;
}

- (nonnull NSString *)uYXBujADgeM :(nonnull UIImage *)cqSODUfHpjKqgXtv {
	NSString *SqnyPDqlwBTODWJnK = @"AUvEfFAiCAEWsGJTxSNOXmRjfrKnlWtNrJuPlUEGVuwldufCRDSqZGqhGfDjNmETpHTJPkfyRfCGEiKATniKOzOdnlVMmeqTBIUqDnIEJNCbyRMGONyBYdwpfztnO";
	return SqnyPDqlwBTODWJnK;
}

+ (nonnull NSString *)kGbUTyDgRBWEHyD :(nonnull NSArray *)weSABMCerlrTPW {
	NSString *KJPCtWNQZgp = @"oDlpahEGYPjwUhJIQcGsJBUrloKxAigEjWqwrlQvdhXsHEvdRZitnlFHnyCgSMQPVLzSTMxVoVtXnPYAUoMFvAOawtosyDvtgNrsYTDggMLqgZHwjGgWuxNRMGotkzSIFrJcAMkrHTKDrJOCC";
	return KJPCtWNQZgp;
}

+ (nonnull NSArray *)ZyQowyCzsyDJdZGEWP :(nonnull NSDictionary *)fIyJPQhSiNnnIM :(nonnull NSData *)UaFIvKpdZvNDbXnhiGI {
	NSArray *lgvOgqZcoqHBajnjpqQ = @[
		@"ixTFZhPILAgGRskHiqghWhJWGmAolrsxURlELsNneLhmLZoPjnEBsfBEaghgnhXjLISpyUlCReLCYpZXhDjmCBXrQELxjBRMHLScijaPjMtdgvhsynxClCAwaCigk",
		@"yulmZBoUQReRPPmNnPCkJZsElIUEqCiwFaXDUByfkugiNEMCOnaqPjwtfmHBpqccooQXPwNipTtXXrtlMyBcjbViNQlVzWmKWjSblhDQBoftkBKIVYRJYq",
		@"ypTZPlbgRApYzxSaopplXFtSXOftKqAyizpQPTkSWgfSJvsXYbJhBxcSzjrhHpuOPJwCYVHdUcyAEkHPLYEyQkHkJCJYCkdphSryIYPwhUjbHKKJdVg",
		@"DSQyKhkapfNwcYXZaTKysZmORnbGoNNoCbDpJOrLGtqSTFykmfEwnwHFzAzJVPjhNHiIyxJHxZkLCKJMRDdWfFfzuVwHLgnerDABndChnsXqVhhSvxrAfzkVFFvGVPCiNgLbaaAEnWiEiC",
		@"kreJQnoruXFBjgOqwdvlwgwtHmRaJiiDwhrosudHTZFpHCPnyGYQXMROKRPhSHKKJruVGvSLrDrRtjAxMhxnzVXBwaVIvMzaWVzI",
		@"TVaGKdNdLXjZMThPAtNwYfzYoQzmlmKcylKuCUHYbQlOItnbRVFfwaUKSQcePqNrgTeXIONsSnUWRFCfbwAjQslfFTHMhMjksCMVUioIDMXiETNJBDudgWedwwHOIbsZlkOUDiKGihIbBcnqFAv",
		@"DjhNOzkDVWgXKNNOKDcWOcKorPhEYzBEGpxcxRWxSmNgcPCCZqPKBnzHyXvxzUysnJlXaODgCyddxyqXYojnlXqjhALIBCbyVrJzdOmWpposNNCZwqvcuhoEFUnPDdCFScpHru",
		@"vYCQarXlxwvmNmkhKGVvONlvWbLzdjnHYhFbvVaUVfqvyFiiSZjBKrepQFBBFXQlKdjjaNNZctcYALlxSaEkQUHtzJDvmugVPQeixlMLAEGvIsUFJyprmCOYLDjNnwYQtiqye",
		@"yLOSiiNLpbfmuxLKhGOAKTbXsEdAUsvyqhWiVXHrrPmyHgRYxvnWpiUpobOqTrdmcVvdbcsBJUqMhyXMtBstnLzKdLggqOMkkTfZfOeACoUtgLeKRLCA",
		@"hVeRsXxwNfUfrfIqvyVTjLBjBhqUGWnwgUUunClLXWnjCkYsYKLLqHSJusvmidxvGtcmVMFTlGiZNcugiRLNereIMQwAZlqtwFsSsmWynXMgvUNXlUBfOxbyVq",
		@"JXoanOjeQlxhQjyNlqlhVJXlHpzXHkbZJWCEgNcVnGOcTreCxPAMGLMRilNsJqjvxhMTIaAgghKrznFzaoSQaElujBvZGIYQbLRacotqRxEimgowAYtglGRftMUCtnAWPsjCqHnaFNx",
		@"aSnCLBsxSCxrkaodFZWeFyEslImtYIIfVFKdPMeGLUxfnSrzrHdHCyfcjpOAmSTWQNhupVEYhGNGDYPlDfTTnulrODxvKzgkhbxUbMWnOmNOVdiICmBdiGtL",
		@"LWixbtIAmWRfxUbDXXPjsMVoojhTlbfAaEBlLayLpTFrrkqmLAOmOwNmpKMpkbxyZzYfEyTHSVqeWElQqeYQajrLWnxtlCSIGtBM",
	];
	return lgvOgqZcoqHBajnjpqQ;
}

+ (nonnull NSString *)ECKRKKWtfN :(nonnull NSData *)GHZMgyBApHIt :(nonnull NSArray *)GsFBEiCiFVwzGuZE :(nonnull NSData *)YAGRNDUXDKLaGrNUha {
	NSString *dQygVpkNbEu = @"RrraBHbYpAgxKlXQxirIRKahScmMKWFjoKptnvqGnKjLbfMXMYSCeCryHZCreKfzXeFSCrKuJwTHREUmeQXjVaXSBnSAVsNyHfEWeiuV";
	return dQygVpkNbEu;
}

+ (nonnull NSString *)JHYoYkiJwomLUNsa :(nonnull NSArray *)mlDcinGFCvy :(nonnull NSArray *)KbWehcLgPjHY {
	NSString *YdLTDHwuPZZq = @"zJxcMyoqvHgZnMWfTVaXUcADmFwiItrnWKXrRCTPdBCERCBECyZGAFpCUnasHVeIiiqDajWaQsSeKGZmGZUFaftnnHxPMwOpWlpXZkLaWjNvGsG";
	return YdLTDHwuPZZq;
}

- (nonnull NSData *)cKABbRDTZXTuz :(nonnull NSString *)ijkADqpvkBBv :(nonnull NSString *)pRrLMwgJMRyNuwgf {
	NSData *gmeaWjyXkatYE = [@"iXBZWodvgtdVJonarBeJmyqMUkhNVtjzmdVCsoaOsrSUzCWQaMXERdFgJySiPzIybfbVvHEYfhfEofujMwoHFHSZWpNdkZfXrYhnWmMmfqASHpYKcG" dataUsingEncoding:NSUTF8StringEncoding];
	return gmeaWjyXkatYE;
}

- (nonnull NSDictionary *)RFPgtALdecWJJrMSU :(nonnull NSData *)pUnVcPJzefWDI :(nonnull NSData *)uvNMegdQvu :(nonnull NSData *)gExoYZezXzz {
	NSDictionary *AWnIGQoriknPtV = @{
		@"jXzAiNpafK": @"dPrguqUkZDVMWzUYIhGVaubbvsppoVgXXCbmjZFinqeXEmBbJMdapMNAIjZbkzUQrHdavPTXAiIJKAhUaTITvccSlxSZYFwwvSRfBIPueGvdTcAFTGSvYRNqax",
		@"CoAzXTWKAMVhmzDMw": @"HnBkjcomhuUdQnYxSOgzYHJxYfZKiviERNqOijpFdJPxgpUSzaaFJXjiycdHVuyUDtmsNqunTlNbTNkQXyXaiQMCfgZIcMpJhaPwHtqT",
		@"NIskqhstiQCqwNlpDa": @"xxKQEpOegPxrjQtchgqzLTYIslYVgOrSHEPfbjhkjspUwaRkYRfmbcqctuMQJYFvQwzZAQuJkcEdsQMbwPjlMnHXZKvaeCOacwsLkIfvyFdwNkYlWdIWhWZoacjaCQp",
		@"OhblbOxDApm": @"WEBFMJCWMqRrkCTePWbtMpgGIpsgRIHTRIGBsISmXidwqsWLXxkSokUVRUQVyqkTiJcnkRvkglxyUuVddPpzfQpBEPwYwtnvIwQrEnpS",
		@"DDZvNhfRyyUKMdrNwt": @"eGeGvxXvuPZPFYOdKTovaeCgvuqRvQOyyRoRvzdgQxGHxwohGQOUdWlJWmTcJvxfjUbuHSoaZYySnLyRBJWzQrCDkLoITCLjthLMzekAaqQwraLikwJ",
		@"BZnEMdlNSWPVWT": @"LdmbVBiqPfRsrMidhrnKdkMiLABOFJGOnZytJdEZvpAmqtADFwLxlcFrBMpEhwhRfrYZDHoOULORwionVayGbyicRjsirWYGXwJxGkbrnopoehJNPCZkvRRUAIR",
		@"CkDjeWYyFEkLMZuyAbY": @"UpAPQnWVMczBCWdkTXcIGAueOfHYpvFfHYNSeqQyMVJWgMlprzJpAMpZIMydgswrjXVTnuizydxfADwyKYuHFxlIrdUGZevMlEYsjGMxiETtepNvxLsSCFfWmmAnYzJkF",
		@"tIohbCNaIcwTrAIKS": @"JndjgbXuvzJZYyRWCvRAVrFLzQtNDYhzIdkRyvTGltqtZoQvSbgnMpkGPCkmBXNXJPjVuCCygYiUmsgMRPVwfcysFmyTSlQACPAjvrMjSzVHWk",
		@"FeszozwzlHZyL": @"mYfmxOrGucjiHEuDOnwjHswblwNjKxtSMXhoAVihRaaKtqvJWqVlJufJcCAhqMBYcvDiDTjxoyleZqQvmjsQXtAMvlGloClpIHwSpiBhPIBVfKs",
		@"CkgktMtoNeBGd": @"gZjbNWfivrxhefkzxuMfaBmxOsUGWjeuXqjkCmTLePJwafNUDxJakzXFPzCEUOpKVanWbFUyUZbwwIEAczOFFWPsDWrgHfUpIxrFQpxZikAxeVpVaWmQtZpHDlrRtIQgfCyCut",
		@"oFEDqZmUlRZ": @"KvWRddJvNZpIzqHDHwwKOEZMjeqRulzqcqIWzeerJXaKeVaCKGTYxbXDwkYdEcnICXJuQOapitlDJSCxXAUlAMNDqITrSEbhozRsqVtlKImCUSZSrISWaAxnctaiQJZsSI",
		@"xhdDwbbKdFlL": @"iDobAYnYrFFtMGUeZsuoUMJjLrIjJkUaJXqaSfBAPOUiyzsArruFdMrvqBoPFpGmHUGZikiHTYekMVjvwbveVneDxDkReHKDjbkhCMWdUwkFHCypBSxrpoTJBiOVcEHpLSLTvnQZAofAVUcHouB",
		@"nFggxrzFzpakXpJBGS": @"nXGhjKbiaUddaGnGjxUWeRHAMIcACForQzRonbmHciDdlGqEhnpCNtYMLQKodVgMFtakEwtoLftUuasDRBogTquxoxkRKNWIuCEStxXjqOvMIdbmuItYAdcmSgEAvNVutfmcpA",
		@"THPsKJoDtKCzvWghOvt": @"wstMaSNdPYcTBuGiYpTMEMRTOipGZTqQTvrhYeJJWujcfDNJGRnLXtVMlPAhzMUnkNMFaalmmYVFNwpxIpsSPBhiSEgSNaTWepKsmjdixgkPrzOMIYxFgrvFNBqzrtXLc",
		@"QaThXFqshISuH": @"QMNUGnItpagYVaitiBbeSDiyjfHZJnJZJIBSKWOlXndfHcxzoRlNTVnDiBEGwrZEbeOuSznomsHygLVtXsbotoBdkFEglEqmHOsssML",
		@"zeafQWRKRJsCyAJE": @"PtDuJlgHJvsSWGJzCShJkUBQeVFyTOVOrnZwMwaorMrqHNhANOflTSFWtmxjWdGubTnmubXVIICwiADrOFYzNbVBrCJrrQgvMrZOVwbORyIeRayAfSTytMLIJcJECu",
		@"ubBAbFedcRQMv": @"tRThiZcXfGcAZafjjRYiQCvJuSZwObxurhEENypFoCzBcEpOjVOAQPhhuvAckqAuvEejkYfYTrupdPCOWnOazhCchIsmLQyNmjmThZVegUuZusBmIUDZraiAbeXEkOlZTLUrm",
		@"XPQNmOhapoiYZkmCt": @"sADXfmBesjHbLImUCMFvETsSEOHjlEQaIyZEglgHJWANiZVYEIuUVhWtSlOdruDItbzQkxFYOsUsahDYEjlAzOwoMEsOiYIZkVozYBBeVSSQHLEJEmzDwPgkoeCEPM",
		@"pSCXjkUqGinQxlUGoc": @"DEaCrFMhtDILSLCGKxriVlAhnBIStrWYqPHBeeeCSHYYVfwyauYIGDhucdvYGtZShWjECeytYpjAmDiBWTZSOXqQWRAZKHBquSAPxdISYiOrKFDCRcSwHDzgffIakIfmlMsETHJvq",
	};
	return AWnIGQoriknPtV;
}

- (nonnull NSArray *)wtPMGVhZek :(nonnull NSDictionary *)tZWrqxGsskPzkBn :(nonnull NSData *)zVbzifkcwmhr :(nonnull UIImage *)rAScbXwzzH {
	NSArray *MOiTvUveIse = @[
		@"vEmrYMewGpBpgHeQtmATJJaBtmbhNeKBMgSeDBbodPQmFCjsVvtzviKhSOjYfXGTnNFdDzxygefMWQBRVxOXEdtGjaVrSUpXturPtIHstNxmIRVjjK",
		@"kCiMqqbalEafsLLPbuKYeVOCMFPSEJlATszpXHUcSgNDERjwAHxZAFdcbdXYdPsUAwAoEMytXKdMWtUbsfOtCMIUHPAotRivEoLmNqGcrouPnNUGfnjLtgcGsVSdP",
		@"alCAccRyZvnLEbLSSfmYyxuadUfBfmRwkYCCDyzzBoilOlUqBvBIKdfoFTezRoNDavEHxNkWUqDWANqwnLsIEZrNeqpDcGYQGfgbHafCqslmLNPsXi",
		@"gXVDhKLfEcBXAvqYbRVfTCEmYopseGbGVREFzvBXztEOnlbRjPizrQAqeyFbMIUzKTFfWkCirFyBlvIpIVJzYpIQldzuujUXEdkSVrsaxjdSwEu",
		@"GbLVOJftbjlPVTIUlJkJRSDExVPzRWMgJGhAlVWcARyjlZEHHFyUjeCuXBFMTKxlvYuqMNzSpXMpDYBTYHrkxkhAvdxCrlPDoDFyuRynObeGDTfoUvsSQVSESKsWKMvjoFqmKnDen",
		@"bKUdAwDWgnjZYNHKvUIKztigOwBwCJDQxrgPOMIiyHvSpDVduCsLyAuhPMiRVCgpvPHDjVrtkGHpnAHAlSVoGOETGcfPsywQJclAMuaLYYbnYZsyLbgLLYfvQ",
		@"MsUhSlkeaQXbLdHaFypdAgXISnAtmQtkrGuzeqUogKzMbuxowDgeFdgSLAarirDQrntRpHbTDFLHGqdLFhbYYXGLxCtHyJeUKbFlcKDNAjMMPuohBfHJwcXBYaLjIZPWukrtiLAdbX",
		@"ppcHQFMbftGLCuFVLduzQDfBkwUJDvhYaJRfrmfTwhqFLsUwYIgcLIuGdLAMQPYoHBLHqhPOsDaZAogHwJlSsnobrsBmXrHBxTZAiBovnNnAglioYMxGSmMsMpvwhnHUkdldIHAAKxSlXMTwhez",
		@"HdqufidtrZkQTIoCQOlgNflrtHKSMfaZPmTxlTXVQxzAsCWlBnFORvGNgqPDRvEWfTgVZqPaHXfvsILMWheQRzTScOtpQwGAPkfiWvZe",
		@"HmxkosCsxJiFHaMtsZAYZKuZwoOzopDquHqpvUGebLkQWdzYioaKUuQnclDbuIBqJnjQlHTsaGgqlgLrBRvLrElnCNkyKMOqxKDZoIubjNaRciQEwZZwqsFgxkPjPwSQw",
		@"tCWBGETMffzQRTspeKlmtKqCiurdbAAtGDWxTbkvaBAGLdkCBXTQnWmTuCpRKNRiSALQPLaPxEZaVKgKCnokFhxIESFXzSSRzLMYMytLYnHdDThEtyJrLNIBjgrUJDaiXHgsfUYNietTkYQ",
	];
	return MOiTvUveIse;
}

- (void) getCollectionCourseList
{
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@&index=%@&count=10&type=%@",NetHeader,MyCollectionList,[UserInfoTool getUserInfo].token,@(self.index),courseType];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        if ([responseDic[@"rescode"] intValue] == 10000) {
            NSString *courseAll = [NSString stringWithFormat:@"%@(%@)",[ManyLanguageMag getHotTypeStrWith:@"课程"],responseDic[@"data"][@"all"]];
            self.pageTitle = courseAll;
            NSArray *rows = responseDic[@"rows"];
            
            if (self.isMoreData) {
                [self.courseArray addObjectsFromArray:(NSMutableArray *)[CourseDetailModel objectArrayWithKeyValuesArray:rows]];
            }else
            {
                self.courseArray = (NSMutableArray *)[CourseDetailModel objectArrayWithKeyValuesArray:rows];
            }
            
            if (rows.count > 0) {
                [self.courseList reloadData];
            }else if(self.isMoreData){
                [MBProgressHUD showError:@"已加载全部课程"];
            }
            
            //结束刷新状态
            [self.courseList.mj_header endRefreshing];
            [self.courseList.mj_footer endRefreshing];
            
            if ([self.delegate respondsToSelector:@selector(reloadButtonBarView)]) {
                [self.delegate reloadButtonBarView];
            }
        }else
        {
            //结束刷新状态
            [self.courseList.mj_header endRefreshing];
            [self.courseList.mj_footer endRefreshing];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

#pragma mark 获取我的课程列表
- (void) getCourseList : (NSString *) zttid
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,MineCourseList,[UserInfoTool getUserInfo].token];
    
    NSDictionary *Parameters=@{
                               @"index": @(self.index),
                               @"count":@"10",
                               @"zttid":zttid
                               };
    [self getCoursesList:url Parameters:Parameters];
}

#pragma mark 获取课程列表
- (void) getCoursesList : (NSString *) url Parameters : (NSDictionary *) Parameters
{
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:Parameters success:^(id responseDic) {
        
        if ([responseDic[@"rescode"] intValue] == 10000) {
            NSString *courseAll = [NSString stringWithFormat:@"%@(%@)",[ManyLanguageMag getHotTypeStrWith:@"课程"],responseDic[@"data"][@"all"]];
            
            self.pageTitle = courseAll;
            NSArray *rows = responseDic[@"rows"];
            
            if (self.isMoreData) {
                [self.courseArray addObjectsFromArray:(NSMutableArray *)[CourseDetailModel objectArrayWithKeyValuesArray:rows]];
            }else
            {
                self.courseArray = (NSMutableArray *)[CourseDetailModel objectArrayWithKeyValuesArray:rows];
            }
            
            if (rows.count > 0) {
                [self.courseList reloadData];
            }else if(self.isMoreData){
                [MBProgressHUD showError:@"已加载全部课程"];
            }
            
            //结束刷新状态
            [self.courseList.mj_header endRefreshing];
            [self.courseList.mj_footer endRefreshing];
            
            if ([self.delegate respondsToSelector:@selector(reloadButtonBarView)]) {
                [self.delegate reloadButtonBarView];
            }
        }else
        {
            //结束刷新状态
            [self.courseList.mj_header endRefreshing];
            [self.courseList.mj_footer endRefreshing];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];

}

- (void) setUpUI
{
    if (self.CourseSourceType == CourseSourceCourseStudy) {
        self.title = self.courseName;
    }
    
    self.courseList = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.courseList.height = self.view.height - 64 - (self.CourseSourceType == CourseSourceCourseStudy ? 0 : 41);
    self.courseList.delegate = self;
    self.courseList.dataSource = self;
    self.courseList.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.courseList.showsHorizontalScrollIndicator = NO;
    self.courseList.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.courseList];
    
    __weak __typeof(self) weakSelf = self;

    //下拉刷新
    self.courseList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.isMoreData = NO;
        weakSelf.index = 0;
        //获取课程列表
        if (weakSelf.CourseSourceType == CourseSourceStudy) {
            [weakSelf getCourseList : @"0"];
        }else if (self.CourseSourceType == CourseSourceCollection)
        {
            [weakSelf getCollectionCourseList];
        }else if (self.CourseSourceType == CourseSourceCourseStudy)
        {
            [weakSelf getCourseStudyList];
        }else if (self.CourseSourceType == CourseSourceCause) {
            [weakSelf getCourseList : self.zttid];
        }
    }];
    
    // 上拉加载更多 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.courseList.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.isMoreData = YES;
        ++weakSelf.index;
        if (weakSelf.CourseSourceType == CourseSourceStudy) {
            [weakSelf getCourseList : @"0"];
        }else if (self.CourseSourceType == CourseSourceCollection)
        {
            [weakSelf getCollectionCourseList];
        }else if (self.CourseSourceType == CourseSourceCourseStudy)
        {
            [weakSelf getCourseStudyList];
        }else if (self.CourseSourceType == CourseSourceCause) {
            [weakSelf getCourseList : self.zttid];
        }
    }];
    
}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return self.pageTitle;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.courseArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CourseView *cell = [tableView dequeueReusableCellWithIdentifier:
                        @"CourseView"];
    if (cell == nil) {
        cell = [[CourseView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CourseView"];
    }
    
    if (self.CourseSourceType == CourseSourceStudy) {
        cell.showState = YES;
    }
    cell.hiddenCourse = YES;
    cell.model = self.courseArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.width = self.view.width;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.view.width / 5 + 20;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseDetailModel *model = self.courseArray[indexPath.row];
    if ([model.btnstatus isEqualToString:@"2"] || [model.btnstatus isEqualToString:@"3"]) { //考试详情
        MainWebController *examController = [[MainWebController alloc] init];
        examController.webTitle = @"考试详情";
        
        NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@&testid=%@",NetHeader,CourseTest,[UserInfoTool getUserInfo].token,model.mainid];

        examController.url = uelStr;
        [self.navigationController pushViewController:examController animated:YES];
    }else{ //课程详情
        if (model.mainid==nil) {
            model.mainid=@"";
        }
        
        NSString *chapterid = model.chapterid ? model.chapterid : model.course_id;
        NSString *mainid = model.mainid ? model.mainid: model.courseid;
        
        NSDictionary *parameter=@{
                                  @"chapterid":chapterid
                                  };
        NSString *url=[NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseAdd,[UserInfoTool getUserInfo].token];
        
        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
            NSInteger code=[responseDic[@"rescode"] integerValue];
            
            if (code == 10000)
            {
                NSDictionary *parameter=@{
                                          @"chapterid": chapterid,
                                          @"mainid" :mainid
                                          };
                
                NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseDetail,[UserInfoTool getUserInfo].token];
                
                [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
                    NSInteger code = [responseDic[@"rescode"] integerValue];
                    
                    if (code == 10000){
                        
                        CourseDetailArrayModel *courseDetail = [CourseDetailArrayModel objectWithKeyValues:responseDic[@"data"]];
                        NSArray *captions = [CourseDetailModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
                        
                        //到课程详情
                        CourseDetailController *courseDetailVc = [[CourseDetailController alloc] init];
                        courseDetailVc.courseDetail = courseDetail;
                        if (captions.count > 0) {
                            courseDetailVc.captions = captions;
                        }
                        [self.navigationController pushViewController:courseDetailVc animated:YES];
                    }
                } fail:^(NSError *error) {
                    [MBProgressHUD showText:@"请联系管理员" inview:self.view];
                }];
            }else if(code == 30030)
            {
                [MBProgressHUD showError:@"未开通服务用户免费课程已达上限"];
            }
            
        } fail:^(NSError *error) {
            [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
        }];
    }
}

@end
