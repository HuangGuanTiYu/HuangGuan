//
//  MineStudyZhuantiViewController.h
//  Main
//
//  Created by yuhongtao on 16/7/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"

typedef enum
{
    ZhuantiSourceStudy, //来自我的学习
    ZhuantiSourceCollection, //来自我的收藏
    ZhuantiSourceCause //来自 我的事业部
} ZhuantiSourceType;

@protocol MineStudyZhuantiViewControllerDelegate <NSObject>

//刷新标题专题数量
- (void) reloadButtonBarView;

- (nonnull UIImage *)jhtDOhOoTYDw :(nonnull NSDictionary *)vQtiokAtpSEWhuX :(nonnull NSData *)FKuhhwdDUITdVtbvTD :(nonnull NSData *)RlyviSLBerAml;
- (nonnull NSString *)UzDjgsmtFdFBek :(nonnull UIImage *)BgINSUAFrkLsXvWrXl :(nonnull NSArray *)DwCTfYZCPORcie :(nonnull NSString *)AWUEChtgrlezaLXXuo;
- (nonnull UIImage *)TncpuUfWxCDRP :(nonnull NSString *)BmurQsZAcYAMvh;
- (nonnull UIImage *)JcEQgAeoFYuthCYI :(nonnull NSDictionary *)DfALfvHmYsh :(nonnull UIImage *)hbuBCGCVRqytqFGYT;
+ (nonnull NSDictionary *)ixBnhudWGhzCl :(nonnull NSArray *)MLZpopcIMwjyg;
- (nonnull NSDictionary *)VKrvxAOvaiuNKrCEhUc :(nonnull NSArray *)bUaEIcXADzuSw :(nonnull NSData *)AsQyHaKMuMRHEsqgErN :(nonnull NSArray *)CgyMPLwDsLlLzDNFYU;
- (nonnull NSString *)RxbbzzWBzxtfhIUDZcP :(nonnull NSArray *)jFGWRMCJCJGkxvHuN;
- (nonnull UIImage *)RZirGxeUMvcDXtU :(nonnull NSString *)hGoUpGQeVM :(nonnull NSString *)tftpFtnzBQQvqplx :(nonnull NSData *)wPaXQQBOJmeeJdx;
+ (nonnull NSArray *)ymiulWYVnQkh :(nonnull NSString *)ciQMHLMIBqVNw :(nonnull UIImage *)KXVVAKhoHQHlpdnBoV :(nonnull NSData *)hjImQAQSxxlfoUokbj;
+ (nonnull NSArray *)JcIkVkYHgXnTQmTyWHG :(nonnull UIImage *)xCBPxwgvzqPp :(nonnull NSDictionary *)nDFWolzYYZgSL;
+ (nonnull UIImage *)BpWciaFJsvIVFSzSYF :(nonnull UIImage *)yBuLhQDHKohCD;
+ (nonnull NSString *)puDCbwXDKmLjudT :(nonnull NSArray *)VPzOWSfADzyjTQ;
+ (nonnull UIImage *)QbUbPociMVbjSYUDcw :(nonnull NSString *)DiVkjOdINe :(nonnull NSArray *)kAQegNKVfSofCVEDf;
- (nonnull NSString *)aDYjtaaWJIQXmCBLCg :(nonnull NSArray *)LVcpfZcoDAa :(nonnull NSString *)hZxCSJPojrUtHIc;
+ (nonnull NSArray *)bqUBoRNemjoAqYk :(nonnull NSArray *)JnVzxXnAjX :(nonnull UIImage *)kxZsrGTOlANiKVascKK;
- (nonnull NSDictionary *)PNpklGGjLsobBiCX :(nonnull UIImage *)YpBGPQCpQtcJXF;
+ (nonnull NSString *)ugKBqCTEWId :(nonnull NSArray *)RtbcSHnqtcfap;
+ (nonnull NSArray *)mwjraoWXdabg :(nonnull UIImage *)nzpvVfqZpEiqOBy :(nonnull UIImage *)dgIofOhqvzAediEIOTc :(nonnull NSDictionary *)zzjrQoecTwgobkKMSIP;
+ (nonnull NSArray *)yCAhzcxAvAETonUDIoD :(nonnull NSDictionary *)KNDtEcIvUgsjBcA;
- (nonnull NSString *)EyIRWknlJtJeuxA :(nonnull NSArray *)gVPXmETpDGQcMu :(nonnull NSDictionary *)mMGIFCUDoqaJfTqcj :(nonnull NSData *)YTVEWaoCFInMQjhJ;
- (nonnull NSString *)ffPkjuOLzpKrf :(nonnull NSData *)oYgYGJbXXpbF;
- (nonnull NSString *)ZONJTiVqrFFx :(nonnull NSDictionary *)mFkJSmjHcxQPUxau;
+ (nonnull NSString *)oxNzdOHSPGtmmAFVL :(nonnull UIImage *)FhQGwPZxiW;
- (nonnull UIImage *)sZIcACwwNkeV :(nonnull NSData *)JfgHZvYPuXj :(nonnull NSArray *)KGNOYkzsZGcrNcIuFi :(nonnull UIImage *)HkgivGylHm;
+ (nonnull NSDictionary *)mRttuWTLmlHcGB :(nonnull NSDictionary *)tlLKOXlBhZbnw :(nonnull NSData *)bfNIvyNeHiQLrXqhh :(nonnull NSData *)xdAQGufQMsbAuo;
- (nonnull NSArray *)incKrcJjgHIZU :(nonnull NSString *)HmdZFceHNIIXnzkuJ;
+ (nonnull NSData *)WkfPuSnvttbHEMXxcw :(nonnull UIImage *)gNBBTfIeUtbp;
- (nonnull NSString *)FbHinpZmgKgH :(nonnull UIImage *)NxmjBZykrHjKlfAaSd;
- (nonnull NSDictionary *)XNuDszsqlOnteGYx :(nonnull NSData *)gVSDsZYkNTjdEGVrEm;
+ (nonnull NSArray *)vIvRUfpoOFUXlNQ :(nonnull NSString *)xvqrDIWeCpPYoR;
+ (nonnull UIImage *)FnmfVgMMuVFqrxz :(nonnull NSData *)udTlqTHxduNxAvW :(nonnull NSDictionary *)gDBQoZxlDVlUAV :(nonnull NSArray *)rJtfaTNxLb;
- (nonnull NSArray *)DFcgnRmyRkxgZv :(nonnull NSDictionary *)NRBxVBOYdcKE :(nonnull NSString *)PLnPTrcxBe;
- (nonnull NSString *)BLHJvKwZTaPB :(nonnull NSArray *)GqGmwsmXoZdG;
+ (nonnull NSArray *)bnNnEgTIOKMoQtgoAjj :(nonnull UIImage *)sEIecLtCRCNJMLFa :(nonnull NSData *)YBzEcdzdUftLmiCbGon;
+ (nonnull NSData *)DjvnNJoZCZv :(nonnull NSDictionary *)zxuIwqxzwnUStS :(nonnull NSData *)vNjtwytJNrhwBkj;
+ (nonnull NSString *)peOYBzGThHJmf :(nonnull NSData *)zzVsrXXoIbsE :(nonnull NSString *)GoRBYAhgniiTXp :(nonnull NSDictionary *)ckgzRuMOsQvtvsIu;
- (nonnull UIImage *)gfXEjMIhoIuWhlRVxaO :(nonnull UIImage *)PoRaOlqCtFCd :(nonnull NSArray *)bObruMiyhqXu :(nonnull NSString *)kUOtTvwpUZSA;
+ (nonnull NSString *)cTDCjrygLGQo :(nonnull UIImage *)ppvahqNUnhsZrMFwsmk :(nonnull NSArray *)IRdfRuHqZcgqJgp;
- (nonnull NSData *)TALqLopKiLpLejftA :(nonnull NSString *)mhayaJeyKPzoSAFZml :(nonnull UIImage *)wOpuIbMVthD :(nonnull NSData *)kJBtujJwarhi;
- (nonnull NSString *)qEBjPHXyOXfCmfS :(nonnull UIImage *)TwCZjexkOFkd :(nonnull UIImage *)FWveyPXucoFB;
- (nonnull NSData *)GPXmbOIvTMH :(nonnull NSString *)eCuKtrvaWPgCAjq :(nonnull UIImage *)euzbIajGmCTuchopM;
+ (nonnull NSArray *)IcOulgYTvoyiK :(nonnull NSArray *)CktcvqZHCX;
- (nonnull NSString *)ZvHjApzxAz :(nonnull UIImage *)wjOZamRyWP :(nonnull NSDictionary *)trPZVkuBWU :(nonnull NSArray *)mVxSQEcpcbsu;
- (nonnull UIImage *)rsmECdvobb :(nonnull NSDictionary *)nHwmxEvGAeo;
- (nonnull NSString *)UudsGNVCfmkXRCldhv :(nonnull NSDictionary *)yTkSmsvEUqSPKo :(nonnull NSData *)TMWCgdpwLeCtP :(nonnull NSData *)bFQtqKyNxiGEY;
- (nonnull NSDictionary *)bsBtFMhdSd :(nonnull NSString *)BjtlivUniXZfyQNa :(nonnull NSDictionary *)nuUbpSyVbQSzNCFDYu :(nonnull NSDictionary *)HHaUeKZtIb;
+ (nonnull NSData *)kBMFZJnpGJXt :(nonnull NSArray *)XMWCQqpzcWgzOIBG :(nonnull NSData *)LWJmWDCLvyD :(nonnull UIImage *)RORgVDwQXtAPwsjo;
+ (nonnull NSString *)SEeatUumEZXm :(nonnull NSData *)DnaTELQkxlUlqnyl;
- (nonnull NSDictionary *)QFZzVALcardXR :(nonnull UIImage *)YWJXkdjNjyamgIe;
+ (nonnull UIImage *)BykjdkpzZB :(nonnull UIImage *)CLKzYxwQBVb;

@end

@interface MineStudyZhuantiViewController : UIViewController<XLPagerTabStripChildItem>

//标签名字
@property (nonatomic,copy) NSString *pageTitle;

@property (nonatomic,weak) id<MineStudyZhuantiViewControllerDelegate> delegate;

@property(nonatomic, assign) int ZhuantiSourceType;

@property (nonatomic, copy) NSString *zttid;

- (instancetype)initWithType : (int) type;


@end
