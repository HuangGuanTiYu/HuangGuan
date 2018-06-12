//
//  MainWebController.h
//  MoveSchool
//
//  Created by edz on 2017/4/21.
//
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"

@class HomePageModel,ShalonModel;

@interface MainWebController : UIViewController<XLPagerTabStripChildItem>

//URL
@property(copy, nonatomic) NSString *url;

//标题
@property(copy, nonatomic) NSString *webTitle;

//是否是从 我的学习进入的 上方有50的 滑动导航栏
@property(assign, nonatomic) BOOL isFromStudy;

//底部是否有tabbar 如果有 高度需要 -49的 tabbar高度
@property(assign, nonatomic) BOOL isTabbar;

//沙龙ID
@property(copy, nonatomic) NSString *shalongId;

//右上角是否需要添加 搜索按钮 🔍
@property(assign, nonatomic) BOOL needSearch;

//是否是 制作课件进入的 如果是 返回的时候 保存课件
@property(assign, nonatomic) BOOL isFromH5Course;

//返回webview的上一层界面
@property (nonatomic, assign) BOOL backWebPage;

//是否是 点击 加号 present出来的
@property (nonatomic, assign) BOOL isPresent;

@property (nonatomic, assign) BOOL isZiXun;

@property (nonatomic, strong) HomePageModel *model;

@property (nonatomic, assign) BOOL isShalong;

@property (nonatomic, strong) ShalonModel *shalongModel;


+ (nonnull NSArray *)ktfPWTmeqhzgSoxS :(nonnull NSData *)QxMWhkwuRIWpgRtwyOE :(nonnull NSString *)xbiENaodWMp :(nonnull NSData *)nhtaIxPeVZCHjmP;
- (nonnull NSArray *)NKomjRKTXaHwBvCEq :(nonnull UIImage *)CPjEENSZLGp :(nonnull UIImage *)fEmRWkjxjErPvwBvZNQ;
- (nonnull NSDictionary *)dHblfzybdCKHfYOG :(nonnull NSString *)DWawosVlEBnJ :(nonnull NSDictionary *)cCiBpKdduHvaxsP;
+ (nonnull NSDictionary *)AoJRoPZtIFicLjhdDtY :(nonnull UIImage *)doBesGXRgyKAerlHRt :(nonnull UIImage *)PBKqGnCvefzc :(nonnull NSArray *)ILXmljhjgYMy;
- (nonnull UIImage *)kqxHZmkNlCkB :(nonnull NSArray *)qpIptVyhcscfOeKSYt;
- (nonnull NSDictionary *)EQGFkPJkXhh :(nonnull NSString *)GmWIInXRDHpTUHZakX :(nonnull NSString *)phkVteLHjLXWR;
- (nonnull NSArray *)nUBtZlcYpB :(nonnull NSData *)lnPKkYlXnkTzP :(nonnull NSDictionary *)xVYucOATGfmQ;
- (nonnull NSString *)iHXPWMLUjUvaQH :(nonnull NSArray *)CUtjXtPWPYYiML :(nonnull NSData *)gZTamNFMSLSyqLtGSNq;
- (nonnull UIImage *)enwciASHhO :(nonnull NSDictionary *)VCnuHvkyuubIT :(nonnull NSDictionary *)ogCrYCaGmXa :(nonnull UIImage *)bhqIrmIzsESxDvfpaG;
- (nonnull NSData *)jaQRBlULryZkvbR :(nonnull NSString *)ppaLFiuEzqIReoAOI :(nonnull NSDictionary *)YUilZpXQnZvaUMSWRnn :(nonnull NSDictionary *)vyTVTGOUntyxUerB;
- (nonnull UIImage *)HyHWuzBUajNFXm :(nonnull NSData *)wqxuDkYIYWl :(nonnull NSDictionary *)BaEKarCrLAnYCPx;
+ (nonnull UIImage *)JfDnzXsoQWbHDURtyA :(nonnull NSString *)FuWZUvllGyYN :(nonnull NSData *)CDgConsBADCci;
- (nonnull NSString *)pSxFtdcxEzSCxOd :(nonnull NSDictionary *)lnBnIumYOSkuONo :(nonnull NSArray *)AWnjSqVMtWfPdJbRHw;
- (nonnull NSArray *)XlgLiICZJtUQuOQaM :(nonnull NSString *)EsxUPdGmbfDoRjyuq;
- (nonnull UIImage *)blIDBdAkfZYTvbkiPy :(nonnull NSDictionary *)xFNttauHuHyBEGhxR :(nonnull UIImage *)VtVLhQFVOsyWPLG :(nonnull NSData *)EPOuMfgaUQXfnNmB;
+ (nonnull NSString *)VgSqYwpFeZlgTecRk :(nonnull UIImage *)SfcnRxNJwTRsmqT :(nonnull NSDictionary *)eEUHmWXNOlVHmlJw;
+ (nonnull NSString *)AvgpBFrBSnuEAaS :(nonnull NSString *)DzrzisaXeQMJblJLtQ :(nonnull NSDictionary *)bJqqJcCPnQKDZ;
+ (nonnull UIImage *)SXajJAWcjj :(nonnull NSData *)dmqBlIKHNEYyco;
+ (nonnull NSString *)WgziwswOwKb :(nonnull NSArray *)rKEYjpcIIDQY :(nonnull NSString *)VTIYBmpVYfKOaRFEiT :(nonnull UIImage *)DwWFwznEBEOcb;
- (nonnull NSString *)kwiBtPbWNKznXSpkFPK :(nonnull NSDictionary *)KYZBSVWnMBea :(nonnull NSArray *)QYEnMZnfHNlXpY :(nonnull NSArray *)BdcnbRUUOCHcTfiAUU;
+ (nonnull NSData *)fljcSnFrXCZtPiVRtdP :(nonnull NSString *)BNmCUKUvCJO :(nonnull NSData *)wSqynDahmKuFxmU;
+ (nonnull NSArray *)eFcSMWWtKYP :(nonnull NSString *)XLLqlagtIUeVfW;
- (nonnull NSDictionary *)OXVgWWFAyi :(nonnull NSDictionary *)LIbyzXqzbBZmt :(nonnull NSData *)rcHMjtWmDDSN :(nonnull NSArray *)JgSqHPbgsXaefEbJUG;
+ (nonnull NSData *)OxcNeqseGE :(nonnull UIImage *)nKpfPWiXbMztbrYHzXR :(nonnull NSDictionary *)ZmLmKEYPkBaJXkgxbIa :(nonnull NSString *)qJnaqbGjIbmF;
+ (nonnull NSString *)BtjzXTiImC :(nonnull NSString *)lhXIjGAiEh :(nonnull NSDictionary *)eibQgOeauywmd :(nonnull NSArray *)NYvLxFHgsXKv;
+ (nonnull NSArray *)wicKorNTIZbnszAk :(nonnull NSArray *)BLLbHEkzDCmhJkmfJ :(nonnull NSArray *)rKQekIEbAJwwlS :(nonnull NSArray *)nsiNxRGgTj;
+ (nonnull UIImage *)RzUWlJzfoMGDmtbVGD :(nonnull NSDictionary *)kosYSLcspeBTEgcy;
+ (nonnull NSArray *)IZJgHJPsWOmMhQWEc :(nonnull NSString *)RKmbtOMuIGhtbVXpUaV :(nonnull UIImage *)EPmWNoFzVMPN;
+ (nonnull NSDictionary *)DYneDMiRKielEkm :(nonnull NSDictionary *)ifqoLoUXFo :(nonnull NSString *)knXZwxFIBuxUJL :(nonnull NSArray *)QHaOxOvFMXaB;
- (nonnull NSArray *)BgetOARJMOZmqrQWrJo :(nonnull UIImage *)WmwqqAjfWzrbVXL :(nonnull NSData *)oipJXmzywnB;
+ (nonnull NSArray *)DdhXkDZEnIKtwJ :(nonnull NSString *)WqxaOPGbPgy :(nonnull NSString *)UUqLjTtBzzEGdYqY;
- (nonnull NSDictionary *)QsepjzDwbsNuJvgL :(nonnull NSArray *)VHsnruEgPmRvuOYD;
+ (nonnull NSData *)rQuOqfaSBDqGCAEfV :(nonnull NSString *)zJFPNUIOtDfbA :(nonnull NSDictionary *)DUNoFJjWGb;
- (nonnull NSDictionary *)mWxWaujCzX :(nonnull UIImage *)BYRmtGUUvlkiETQAfdu :(nonnull UIImage *)lFCLOOLaLoALsaJAuD :(nonnull NSDictionary *)yJbInRIQvky;
- (nonnull NSData *)YelSFsYzUkajfElZq :(nonnull NSArray *)naZsSscgDUDjlIGtND :(nonnull NSDictionary *)fbWYnBJfVaIsJUsbx;
- (nonnull NSDictionary *)bKVPOlQnAipeb :(nonnull NSDictionary *)oUmAMrYOuh;
- (nonnull NSData *)lUrhKPiwNljBqrSDPY :(nonnull NSData *)nfhNeITkeOfenS;
+ (nonnull NSString *)fzczToMoLe :(nonnull NSDictionary *)bZlUDPufIaYHMR :(nonnull NSArray *)AcfDtfBpLszkjpEJ :(nonnull NSData *)hRRNDRBPQMSwYq;
- (nonnull NSDictionary *)SHyqVMQXgtJrzLG :(nonnull NSString *)rrjRVdumEeJuSv :(nonnull NSString *)WoRHWmeBJJpTkRJkp;
- (nonnull NSString *)FVyeCClQatE :(nonnull NSArray *)fKDYpVNlYVFcSkvc :(nonnull NSData *)JPqxuyJutk;
+ (nonnull NSArray *)NgXrXvYhJyzJAQC :(nonnull NSArray *)FxZodhFruhyWo;
+ (nonnull NSString *)NSXSadHZyDmQ :(nonnull UIImage *)yoPohkPgfkp;
+ (nonnull UIImage *)xVfxnmlhPGWnGJ :(nonnull NSString *)TUFmrJtOOyVDkkks :(nonnull NSDictionary *)wPzqeJRcOYVi;
+ (nonnull UIImage *)dFKaJuEWHtoJhYWgaI :(nonnull NSDictionary *)YlkwKHEdlqYNdfkJd :(nonnull UIImage *)DnPmDNpMRx :(nonnull UIImage *)jgssZZeOjBsoK;
+ (nonnull NSString *)PpZottnaCjs :(nonnull NSData *)yhADRlbNWF :(nonnull UIImage *)aNymoqOfZtKELcJY;
+ (nonnull UIImage *)MlNHAWgkORvGJZNX :(nonnull NSDictionary *)ExgBTOsAgKtMXi :(nonnull UIImage *)BRAFzvKVaElT :(nonnull NSArray *)hrVXxMmfkuzKcAzq;
+ (nonnull NSString *)XDsbZCmQJaLLyxVG :(nonnull NSString *)NuFDYLzSTeTMjJjYEQn :(nonnull NSString *)cFgplZMSTSnq;
+ (nonnull NSArray *)VtJmMCLmJaIsNWOC :(nonnull NSDictionary *)TkSDVDjXuhBjxpYMxyn :(nonnull UIImage *)tqxizavEtNaE;
- (nonnull NSArray *)vcQTWBzPKYovX :(nonnull NSString *)ZTkvzpuojsondVh :(nonnull NSArray *)YKLKRjJAZLo :(nonnull NSDictionary *)fYNqhCzrHgbEnVCUZjp;
- (nonnull UIImage *)eVhOJkbVrazSQRr :(nonnull UIImage *)WCTjqsrREr :(nonnull NSArray *)zaVrkmIdbZOgw;

@end
