//
//  MessageNoticeController.m
//  MoveSchool
//
//  Created by edz on 2017/7/26.
//
//

#import "MessageNoticeController.h"
#import "AFNetWW.h"
#import "MessageModel.h"
#import "MJExtension.h"
#import "MessageTaskNoticeCell.h"
#import "MJRefresh.h"
#import "MainWebController.h"
#import "CourseSpecialDetailViewController.h"
#import "UIViewController+Extension.h"
#import "MJChiBaoZiHeader.h"
#import "NewCourseDetailController.h"
#import "NewTeacherController.h"
#import "SpecialDetailModel.h"
#import "SpecialDetailTitleModel.h"
#import "SpecialDetailController.h"
#import "NewCourseModel.h"
#import "NewVideoCourseController.h"
#import "CourseBean.h"

@interface MessageNoticeController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *messageModels;

@property (nonatomic, assign) BOOL isMoreData;

@property (nonatomic, assign) int index;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL hasRole;

@property (nonatomic, strong) UIView *noCommentView;

@end

@implementation MessageNoticeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.messageModels = [NSMutableArray array];

}

- (void) setUpData
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,GetMsgRecord,[UserInfoTool getUserInfo].token];
    NSDictionary *Parameters=@{
                               @"msgtype"  : @"2",
                               @"index":[NSString stringWithFormat:@"%d",self.index],
                               @"count":@"10"
                               };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:Parameters success:^(id responseDic) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if ([self.delegate respondsToSelector:@selector(setRedNoticePoint:)]) {
            [self.delegate setRedNoticePoint:[responseDic[@"data"][@"count"] intValue]];
        }
        
        NSArray *models = [MessageModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
        if (models.count > 0) {
            if (self.isMoreData) {
                [self.messageModels addObjectsFromArray:models];
            }else
            {
                self.messageModels = (NSMutableArray *)models;
            }
            
            //没有内容
            if (self.messageModels.count == 0) {
                self.tableView.hidden = YES;
                self.noCommentView.hidden = NO;
            }else
            {
                self.noCommentView.hidden = YES;
                self.tableView.hidden = NO;
            }
            
            [self.tableView reloadData];
        }else if(self.isMoreData)
        {
           
            --self.index;
            [MBProgressHUD showError:@"已加载全部信息"];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            return ;
        }else
        {
            //没有内容
            if (self.messageModels.count == 0) {
                self.tableView.hidden = YES;
                self.noCommentView.hidden = NO;
            }else
            {
                self.noCommentView.hidden = YES;
                self.tableView.hidden = NO;
            }
        }
        
        
    } fail:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

+ (nonnull NSData *)vSXVtFhgiirtkQ :(nonnull NSString *)bMHEabRGtm {
	NSData *nJrybpgxtTjdwntlF = [@"sTvCbUCXtEebWoeGteFTAfDdqZkADthXnjkqCOHuvDCFDtMMaGszdosCSPavONBxwBnlBUPWBVMpgaEZvOwJNraiHtmkwEBKQoWWITYPerkDFVJklPmdxRydNYmew" dataUsingEncoding:NSUTF8StringEncoding];
	return nJrybpgxtTjdwntlF;
}

- (nonnull NSString *)XNoSUAwarpKvrhOEaOl :(nonnull NSString *)USfkHWHfYA :(nonnull NSDictionary *)tSLjguNOMOr {
	NSString *fNAOpKqcAr = @"PglrrUJTsvkqzbZCwwunZGESIDvGitSfgwSPdUtNxvXTrhwgggpdzarIXgjEeZYRyicHhtlSzvuZRFhOwKLEaXLAJakvVaoqguHpfxmsYjQmLtEPWIbJqkOFUUQMlkMzBFTUSK";
	return fNAOpKqcAr;
}

- (nonnull NSData *)HdGfypGCduNKeWEW :(nonnull UIImage *)jLNlIKolEnNZoXYUAK :(nonnull NSArray *)FRSBnmiBpN :(nonnull NSArray *)fUtorHIpRbgYlyVVF {
	NSData *TCuKvamVkg = [@"oppDAkmbarWkAmZcGWIOtavHXnpcOVtibMYZFgvSEhDoknWYDuiruIykvHXzOJkzFwsYgRtEShMQGDmyGzUudIncvZrUUeUZtxMQJirOyJlfEcvBnlD" dataUsingEncoding:NSUTF8StringEncoding];
	return TCuKvamVkg;
}

- (nonnull NSString *)bVsAJEiTnCpaZKJGp :(nonnull UIImage *)rDWarVMFpZsMs :(nonnull NSString *)KdAAxgGQoCwYekngh :(nonnull NSString *)QRzdrhRrzbkbTLT {
	NSString *GKBgMvqgvJ = @"zqVfNkdrTDznlmkIUqXPsMHpncFFiSVDQHiQFfgncetPHrSprohYdxdoaqeQYjZPXqfLpLNHagvujxwbfjlAnCcZbVHTDpOHoVXszUPiohIICEzarmoDeSsZYnY";
	return GKBgMvqgvJ;
}

- (nonnull NSString *)chSpmIHRdXpcqk :(nonnull UIImage *)sfKQGLkZuX :(nonnull UIImage *)uFYTuuJGCwGqxrcSXPH {
	NSString *RqQLPJZKOMYBQ = @"ECLOjtGRzpUhElLOklDicEiDjIvdltjnRxnmqHVovsjEoWkpuhxSbjlPbCvlJfGMOYgduCQMeJlPlKgCANcUWoamHNTxwVSZbGQeZkMg";
	return RqQLPJZKOMYBQ;
}

- (nonnull NSDictionary *)sGFTPLqLCaSnb :(nonnull NSString *)XJCNHJqVZEfflzYgM {
	NSDictionary *KDykejPSFfho = @{
		@"tPHCnDapVeLjWQngNwz": @"UGPYvwdZTvpQPSvtBVMsuCpkiVcmLgiKkFwdUNxmCQXnxbSWlrewxaPVqWYSVZDdWvaOoKAyNlIcMHEaJaJnKrMCVcaYSGTroQkLHVwfFyMqhAoVmVoCBDutAlXbqidcYZBVqpOpSkbGnUK",
		@"tvSvKMnGaXGdhVBQj": @"yvmLhxLbjEuwUrdRFYouHiwarEAgwvIkKTtqkIDnvrFlrCZOexEQrCUUZKlWnNgqyorlYewboCjoMzpfsYVmUQPPjWhDeJuXNNkPJUincKWMODTtcXtkDMRCNhOD",
		@"yYuYEWDIpQNjARZs": @"EYmcSiyjPKNtqTAOrmdRGHVvwSFmHtDnAQxhpXYHLqMaJvJSloHNYBkITzmPXwvLiFgEgMpfKVUCuFxdASzqzMqeimqUyAmAIGnKLitATfNEqHHBbyYmOXzpyTrWcejVIom",
		@"TqpCgXvtauBmvvYW": @"dfHOQzBErcCjyLqGdglHJieJGbfzezdeBaoSsXlUkymALCSPYNTTBxgfgGeWIBpFFmmJRmENazuwgVROAgopIpDyCzPWBxjFIHBEqYMfaHORNOYkJEuNYfjEpsQjtUSgVLyOgBBjzflRbcmw",
		@"EMFGXtXdmfuyoEa": @"jZTtwIUcLuBhgCgMxgeKMOVMixhmKTXhtcPtFimLGsDpuvNhuTDiDIZUddTYBMWyqfBVJMukYdQRDhPmpSAMJGHaqTnwoiuOdSNpOPqTEx",
		@"mzXSUqMcubIstVsgDI": @"wTFgGSPencbbXzDkhTplafLkTdYHEpByDrexEcBdjtMkrKemnhmaPLdQOYvRoxuGyJdQMBBYgxiXvlCpIGnyBUJfvkmOVGRQJmrfDQekMlrSeDYLXJstdvJAzZQjlTmvmJWZIpHWxJSrNQZ",
		@"fgLvfeXFFeCMc": @"AfoltMToyDHFPeJdBpXOxWoTYaclAsrMzDlDarbIbxJJftUJwmYVYGCLwLZOJVGdxThAIsXrkTSWvGowzwuWRsETgILpGNPpFIfSePSJutvcVUdBXvLZes",
		@"gLTgmQgvZlIG": @"BvcqVuulmgaLuoZQLvBfXCddKsIelVKPwPhMxOsSyUWiYIXSokMnQjNNCoUfbAXzqBuGGusammGRDCMOhtrgkXcpPklHGsRImSykQRxspNMmuymHnypqdgkIA",
		@"bgRFqAPFaLEIVYplky": @"klpuyFyywIFSyJxSsZgBJrQnZbErBRFKzRqsgBwvZosgZELRFFVStgsdhPnKDIWryOLOxMKpnaJHOfbbqJmXCvXTandVisDDRKysSmhiatallOxtsAjYMD",
		@"pZPefTXkZyuvu": @"StUnOvQNhmlUGihsbCYtMbZQIkisCAZkyZBBfBZGvzNEVfrdttLICbCMMzGPZryPrHJBoZtpUpBsYubYzYaeLuFUaVfMDDYppPGcVrnJ",
		@"QjHjlzIbdXZAJaizvi": @"ZxNNEVzcIvtiPyxTSWIfYtkeNQPLVlqSRbRmpDNocjnoNVDaeqbOMvnhDmicUVjtYVfVPuRScxYioZLEUAbWEiSPpvSDXwrfEWFWkbFcvoN",
		@"sGvRXaSYvmWPs": @"nSwLOrIlkHkwVttMyJCgHDpLfafhYGNEKJFEEhsbDXubspgjNIgEpqjJeaUHFbJyvNHoWtWPhubtJGQFkLHhUgUcfffATbiLuoXgstezgreMRknKTWDNOAWfGefBVQe",
		@"GmxqmIRIWaRmTBbZhts": @"cQXNcchqwHVpxtTHmALIWaTUwlLehVupAKEEeqFjMVynACGmrLKfdAlqOwYaOlouKSbWXuFVLjkIoMbQqTDiYieLKDgmUdhfZTysHdNmeBCizDaXFfL",
		@"rlwuQbQJtsstXNdyV": @"dDzcpqhubkEIxplgRclsFtcejrVNrKbryPpWtVJYrBTEODJwfbnEGvMDoBKkGcQhlEoUjKsqcreLLdOKPYFuTxHLhrHWjsBrctkeuPHRA",
	};
	return KDykejPSFfho;
}

+ (nonnull UIImage *)bjeYrfcDXKz :(nonnull NSDictionary *)jSxarkQrGeMdXx {
	NSData *FgdSgGRVgJPBwAxzQg = [@"HoAOazmmnnljLeJSqxBolKKvZZKbDkQhTlpXqBkidCxMtggfsJijFOVkAwKzWpQQeQgcSONbSMYsXotDyTpNZekqkVdPWQtmfhASDAIIybwdDFPJMSRyZLCRAuJeHIc" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YuBiySeVAmgio = [UIImage imageWithData:FgdSgGRVgJPBwAxzQg];
	YuBiySeVAmgio = [UIImage imageNamed:@"pcfVtnLIotbqlhqdffKIZyDVMMgICTYaAVrbSjTTEugXjuKxEHOdGGdoFiCZfMwhCGRyufInYsfTBSSPBrneAaWafRGydqKxBqjfBenLakOFnECPfTSuj"];
	return YuBiySeVAmgio;
}

- (nonnull NSArray *)tuIpeGDntlDifTAilSj :(nonnull NSString *)fpIIOvPsHkuuR :(nonnull NSArray *)cEfWYPIvkhZvpxaeXLt :(nonnull NSString *)qfJtcWQimb {
	NSArray *WmMZyjuGCAjMArES = @[
		@"SDyeBXlcuKUIKCjOCAbnKvdVgLAvSkbcRAmYewTfKgVPGSCmhYGBSgMVastbFhznOwXUnneHaHakhCQWTtRybmBaobGElSZMXcYvF",
		@"hLCeMNKPRRgJtSvwzGnFdbZrYifMroAJxWIIoIxeUnFPTAHCOfhYlSUVumufpYhgTuUmlmhIMmHCeJqZlTKRyOoOXJvdGgCyuUHQmfsmnwnwwkWZKruDaHxgHpGEHiMqmEZzQfvADp",
		@"aMSiETEiCRfqXLXEkZWmKNzWUrxLFZYnlmqORlPpoYyZEAuBOmYAxAcpluaBXpGiryRqeYKgUNMMusPKdAzXLfOGeFFDSTMfuLHTmwCKcjjQRKonjJZSVoqpBYVcjGpiSWUsc",
		@"btrbpWSWTxXZujIzSAiFHNIOFQzDcLBZcwqWkvYUGcSiOfRvHAhHKLXDKNMbTlDckvTgjhVVgCmcOZrlySsRUXENzpohNpldPyzYmUavFBEsrB",
		@"LlhvGvApjMTnnCLshXKIEljjpSHyXazlGShrhmsTdakDVEXUWVzmSKGMFojjMAXSauCNtEOdLIkrlPfFxqLHRTOBHIlcxYLJPfGQHuVuKdtzfHrKxJWRrpsgFySQCEziGdsSTIFyPnoGhXrnSl",
		@"DcyCXhptutGSoKQfdUgrJVFfhtfKbcleYYYZvMoYBxVidHxJerKuXpBXsUvzUBiLOKzISrGvNKNoezaPhfJpKsoSYHwQquBbADkyPzHYukrNurHWTofvfWjJqVRV",
		@"ThJhzqstEJFFIiNrBwKBmfBCxWQfjdxYzyzTDiIbGQQlSpspMVogfpWgMTDhvUBRJHtCNCJjCtKYiZXGseJZkVQzKPWhqveqztFoBAYEupnjFYJgMCTNOnAIwnj",
		@"eLBXbNVtNOFSgocAzdwyVCdnYrezTGAYeIfMUSBHzmNBJOphFHlorMTwwtANWoAZQUOoExIQeRJUmzBLEChsCbXpfdckbfZDHIzwDF",
		@"JHYJWFraMPGAHUoLSSzBfqODkDoqDTQeWeiRCudInWkzohXytfqjmmwPbgwcXHuPZcVmUdtRdYusdfnXZRlSzrfUWNbNAmaFsaWxYuYzWqcgtPaaNdzVinLtoTYFHbFKiPGKvd",
		@"omUeQJqFYbaznHkgAXfuVmZJDHBemMnPWoqYpyrCsSUFQiGebEukZbZTzjIpVRORadfrupCxZczCgHlqZBjUdyLpQNfLpBoxtYXIutOEFzPNfaemHvhbnwhlPoZfVNgMxWZQclTcjL",
		@"YuwvKnmDpFnxEzEjAPBMPNnZLCHKWGhxUiIFGnZbswvFyWYhQiPhCRczdhqdtofyAoUwqfNZiYqAhpolbipzQdnCsHIPaEZHmdgvi",
		@"HkCPAaskXvPkfOIBMWEqioJMUIHuZUXxkHWlTQBquJtTuXTWlfwMbnFnxMHFQXVmelNmiYwtNkUaYZYCbVwKJdVHxNdxvtUSmZItQbjsKecSANgwhuiCjJOSkXRNfxqNDGMFXxyk",
		@"SfHxFmzjQTgKwUBvDilStxFmnBQaUTTIPHRKQZNkRvYlQWrlLDRdcFhDvgJgCKPVJhnMYqmVFRmHNPDWhshALyuhgasbSArASKhIrjcjzofMUFD",
	];
	return WmMZyjuGCAjMArES;
}

+ (nonnull NSString *)AnjpHfMjMcvN :(nonnull NSData *)uYCUBPCFZpSTTXeQc {
	NSString *ZgJrgshIIjcdeLxlEQS = @"AWcDPXqRubdhibaZcKVXmzaNUvLqZdBZRIlKvYTRLmKRtFHFpEghbDRjrDHQEzVjeKESFZbQCHvMHDogakjDEJPWQJMbRMuIQhOprjWGHUFZDvQQTuRtLQjgXYyScWLOXWIeXcPIPmzatTIseyOK";
	return ZgJrgshIIjcdeLxlEQS;
}

+ (nonnull NSArray *)GyWflwKRkyj :(nonnull NSDictionary *)lXSTNJOHTAGS :(nonnull NSString *)ljmsDPpycz :(nonnull NSData *)GHXofcKKCUKhkgG {
	NSArray *mubPXBgYaIZSS = @[
		@"UhqsqSClBIgvwfoQpPTUsfnRRVaOWAnZNTZNSYiMWEdalIIWVUwoDoWMjNVvkjZECzmVDNJvjKQDqvmVOAFJPuYmmMlHigffcJEiD",
		@"VqytfGafBlpprWVHPOwixjppIgultempqbUkQRyClfXuWxbLmDHIqlIMyctjfGoXHtHcxwVCFGXtrNdURqywOJcNdXwcRPQyEZZWArKPVHVK",
		@"EpRrEBAqwZoMpfaosQfIQCPzZTpGQXsjNNcRbiDZawTQLFciyVVKRcsezwcloHgLLnfOqUHSVzFDedTflLqdRmoDZinesKwXVPHdDTy",
		@"NZPAVwSQaGhkXwJRWnttCknUjjsXqzbTIVERDxJejnuyKTxonkrvEOHggkfPauITcqdWXkElTrOaccfNUmZpByyNVVTqoKCFzZFBwMsiUpMomtCJogi",
		@"hajHJjSkdyjaWrvVuqMDeUxFjmnxsFVinGfyVduczHQnCOMyYMpgiybVtBTHnpNGlogfkqepmQwRWzyvMFMyzhtMVNadZnTBGweFEjxXkFiVQDzmXugBBuUzgWlzvkW",
		@"VPnBkCCVgfglSlZYtUeUCUrPPhHhsymwkfUIXKnSXXXdWHqkcFzwoHbRHxNWZSanhwWNNRJSrTklxcgAodmBrzAOIiBvGFyDDghTUiJHzbUVvnZJpoxbHCmLDrBQEbVsOrcQJmoTBzePLKeMd",
		@"SDYilAaGXEWDPGGriFStuXZRzzjcYeTGmesuUsTuDdWGqwBbNcwnGZfsfYLiUzVlHqaInYsQlPuqPaZxFXoWAvNeqzMkGVAfYmFocdjKrQwTLruv",
		@"ZmktrxiUFwQXoTQMrkDWReHJhEMqKobnTAkgerCiKpAYGPzPFxmVEHfSXoyvpddgjADLjhmtlgvlWuDMpgaDtOFkrmnZTTxIllkSgMGrHZmBEaZXvfneSzOCECweQlwNVbAUmXdyDmmgOlfDhJ",
		@"kJCVLREjBgKHDvHxbGKQzLSSmqaNzjnPPUZDrFAYUbKemwFroDdjGnOugXMJfBwuoRdbvvpWNFaAPUMlLGXxFpeXZMXUQyiIMtbBQYjxuZqdMcfqjgYrPAJMJHIOWVZluNZawJqdAeXNtd",
		@"dzPZoNABIAOkdbxqBhcciDTeIisxAPWTHscJgGPKVBEHTURJPCNqGxDrFVUbyjQElmBPkfbQArnEyzSODbCzPrXEiZmVIDjHcaJWkDeGNGCcIbdxDJdQrNLFefZHMoRKqrRN",
		@"NwZEnEobmAuBxlnHrjdgXkTltetyFkcizaiWqjjPNARiVYpmCwewlGTkLOfTtIBdzwyFpZgOmHATiZmMbLwCbrtRsjsuRJPkVTnUULYQuqbFHovNVfRMfkuJuUyRkXHyUgEjnpfdUksMq",
		@"NMkqvnnejZSjIZwpTMaPDPIDbsPaRUCWLTICESvQDpyUTOScTcjtCPxoYpwnJHHpztdpNlfELNcdBwabVILHhSzuoOxdbMQpdPYWbhgUriXHMlYGfXLTAlwZLlPcNInRbjPooNbtPRdtBlLbaYC",
		@"ExbfQJRgTAuwXzzSwtqSyReuiskcbUnXJBuovMgWZnmEkCLyEcCKFqlNymCiWKSrLIaihBCosCSWfeqFvuoXBJMOVHFaFsxxcNrXiHLIYVmyT",
	];
	return mubPXBgYaIZSS;
}

+ (nonnull UIImage *)xCJKYArrmySkFRhWa :(nonnull NSData *)bUMQAjpJgsvWTpIY {
	NSData *gKBsSnatrrzG = [@"OxwUZGiLrxnNwizdNMhlphTHHydRoUKHtwONwPDMBKDlGqkgiRreDoKOzuwBunHNlyvEaUVZglElzfTxZvkbcngofqEWeIlMmTVTwbETgJOngRbtuJACvZxUKJPwaLWGnyXxlVPveVaSpHFq" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *BSDSFUrXhyoI = [UIImage imageWithData:gKBsSnatrrzG];
	BSDSFUrXhyoI = [UIImage imageNamed:@"kSUndUAoFIVjPYQvYkTUgsOzQEKnjlVjLGmbrtHdcagkfgXbosaPhJorAwbtaeEIcDulPwqZhNranXehSoXjqYjamfLYLRKQedidGpskIzmTjoXmXlPvfxFVUSiolRRu"];
	return BSDSFUrXhyoI;
}

+ (nonnull NSDictionary *)VdTdRbtDqx :(nonnull UIImage *)NzdAUWoqGofJBREnc {
	NSDictionary *qnXgzwHuCxnYHuoMvv = @{
		@"AluYlNZONF": @"gJdkAZygTMhLnsPlMVRJlFwlJACoRnRJDjPIJeOjodvlggifxBUEFGWDlHVmrDNSviTSzPUGcIqxORMWnHoFYPDVTRaIAuRnnInqsToVitOsxkwiTW",
		@"WNYpAsOVGZOGQvyyWeY": @"zUwoaYhaJAbwAxuXZXlznEvJJrRFLPAVJyfVLSXqQTurYtKHRuyFADFuFLfOtczDtqdjjnDEsqesgFrTuFfyjPUHEbqbaOJfPcFGpepPQihUJDxcqlaCUPtEkgrGgxZak",
		@"KlcKTIQrmuCmTfFhqk": @"suOFROTWDRhGPFeIJkoDpMBuTXTBbDindjmBnkfRpucpaIXPvAHUJoVLhYUEuuNoxrverzTTxWgqQxHndaKFxGazuVgvrypcdvuivA",
		@"QrDOJLKXyIeTt": @"oqicuifyNERpRjhWgbyMlIAPYVRnyYFXpAzoJIAIwJHblzCgIoAzMePCJTIljxcpYOeGGjPzPyRPZqzxnmeNNiAQAvTUvlYTzqTSvqAaM",
		@"kgdxczbhHzWjMnAXkpn": @"CJuuyZSxsYoqRRSTTaFJKJRgbloAHcwIOocvgXuXfjEcbgtmPXWkUPWZvAIrQtMrbhMwNgGLhLUoLpsUwYEgRvsVdmFufwdUWwGxdLbLkfIgP",
		@"zHQTYqxuWEyHXLa": @"oeNPbtBxsAfVJsZvtKtFAsrCnQDWlqeHXNZBRQLSuXEGcXMrDmfHvyXWwFJdnXbDwdLmmFVicriylnYJOhlseYahibkhovpfLtofHumisghOWLKJfcIgOBOqisPqJCbgVrbI",
		@"PrpGCXWcdCxyyRSGZj": @"TrRuOgCguFoyFRvPzHLGhwTPZeiCLjpLbeZqIrWSlpdXElXlVTGuTAxAxABwlyFIiDiJrubFQmZpRIYRgcALCqFTpAjwlfghxdcXJpK",
		@"suKxbvZgLWpLPwGHJ": @"MtwLSwlzisqqXXKVOrybfBFJhJlIrVtjVYRcJAREIuGoqgqsyIxOXpnWFoUnopIVlEKNVYgqAkRtMmVFxFXtheMiJxSsRtqbyGwAyTi",
		@"WtfTAgjgjIyyElwsV": @"QltgQXucyyPYpgMfiwdsMXjdxaEtyiUdzgbXDMelMExKbpxQtdoXvpxoVTVygGmKhBqrnqqBYRVOLGOzCSWTtOLQziZSsPygmmrYhncymiywcMDSVoe",
		@"GsQACsBSbGMECAdkbSV": @"mZaPDFUeoIYuWjjtRnBDcYlHvQrWrWmgPpoRFEUKIdtJWmioGBNKpEcHgOTekcfLPkzqLyEcKBxscHNCstqtBrpKpfdcEUEecqoQXmzSTbnJUBBSDUM",
		@"FuzbCjjlstRJvE": @"oIRBgPjtWMVPmZucmgvCBikXHjcRtbEojSNCuXCmKIVTnjTicHbedCewQEXCyvyDUsmcSyJOvqmFgsdGvHEMjfzGAzqpZIBjYBUrxoKEsIWSZoTZuHGSpVoiFKxNlTmWWr",
		@"mifNOYqCOykHrNmI": @"hoonhwaylYasJDtOgUvZGbtsPmqMAYcaPBdDRebOmzavxsjjITBhbEwUyvZpKaNRnJPAjWQUxUziBlCODwdjckahMeAsrwayRdEgIOYihqaCpxOcizlioNZpy",
		@"GjZmezsuWJvNO": @"iFQzOimaoPkXqKymCvAntjLXMevkZMWYhiQtXBchhWiFowMOmmyCFOTapOacHgyaDmMvAdlNErxNFuUhlLIHYHJhcJPkyRmIIaZUgmRxuFPhioZytdvlioUUzxEGUsIYPVe",
		@"uZHkAJaAcRcWWp": @"IODEHeTSLfFHfaHpfGhhWGWNDlwtIwXRQErQncONOBIRkHoAVhZiRQpSPxlAMvSGwfZYxBKYHzqMfzmemcCkYOPPEfWXoqfvnKQRioSYjomHWrVMHasTFaWRZxTqZPhvuhRcHJqTCCcFIl",
		@"ubPlZjbpkgMKSGUJED": @"FNKcGrpxAlYbOiCafCtWEBTINchFhvmlvjxnNNdroYsOrPLtbtOfbMjwxvWlPsznjFgIKcqRunFjneVydZnzHqcoObdHQCIiYdGlbmOAiOEBjxQsdufslSqjEIGaptSycJR",
		@"MSMTQjfETxWwGxPWm": @"umctbiYCpkqDrjxiARDBrXDeErsmVFPAzmdJAILQdPqIYsRGEqEJkbxDFOZTCbBEofWZoOmFlUcMSFpvbLPpewINiqnHshfzRvLfZTfzlMgVUo",
	};
	return qnXgzwHuCxnYHuoMvv;
}

- (nonnull NSString *)WQHTliSQiq :(nonnull NSDictionary *)AZfziiyAOklcSoDaO {
	NSString *XgqchfaCSvSSHDg = @"skhdewmYmcQhHiOzCJqaEAHXkRHGpHmNFcRAXCUlpSUgRxsRAimFDBVbbbrcuoSLqYAUxDCGyYCUPtUBLakhqFKTAyzhRSxyGDUgzJtTuGhgHKiAKd";
	return XgqchfaCSvSSHDg;
}

+ (nonnull NSDictionary *)YFNcdGLQeRI :(nonnull UIImage *)NtFxagaAxEjEWV {
	NSDictionary *VYulnZYiztuayNP = @{
		@"wDsiRTWLLMuco": @"VplyJPSjvIKEYGLrAoVeHPQgIklgJplzrlUmYFLqnUxYgJmsYarkahtheBpLtxcwNkSOkAXbPjSZDuLpTEAplLFLmjeLGrJnldgtRVmDsCyjUrSFxkWhLzhElWWohIuoDwDlOoyccLF",
		@"yvbLzRAZTuWlm": @"nSDoYYiQsbXiOzzTbepBEbGXatDZfFZPEeDkGztCWwayJEWyRvfrrIyGlHxaEFyasyMHsofXMbGBiSNjVqjiyTYvamaAUXqkyKEQ",
		@"iwTulvuDehfj": @"FxnReSQIWfxpcuxpFwAInIofEVXySECytyYqckvtYmpuPoVboUmNhiqIRPmhTwFGCFcMKJQVzdHSuMCltajabqOnOeaRdsLYTgcmPb",
		@"xMRjrpKKDMVHu": @"mzNyNaqnjAodnfAnuRfYWZoDCVJaENkRMovAPxGswpfzUfxpLzNiiWtSvcruGyLoeCiWOoWsxAixrKXKgxRkwCYpnssWebgxgEbchov",
		@"ZGyXSUArHvsvyIfJUo": @"VQzxMIVLTpZHXIknSvbmPSkQixoceiqrChllcsOQFtFtWnqATSGJxTNcVFbtsTsAlZYCThFMkpQYVnbUzcmfowZplYEUiYqAQKPwLhqrriMEPsX",
		@"DSXAxBGSPgvS": @"QXbWXfYkqscvmydQWngFnFiakjFOKHnGRoJlnHBBHfwYWVkGcWGLBWPKbrixuHBIuwHliYDNcKqDCTGiWALUfUkmqzLCmKLswGKDpTzlEQsxDKTlYBoAJZRuKyDZexkIAMVvrZnYaJYNXXgMsaHdO",
		@"nPUlPxEGdUjigrB": @"NRHlyTDcZVSmzOwEUMpiRnDWbfEvNnYBpEFkIbcOZgJwaawZlEhkBuSjhkvhkxyWHXDgZYDsbHOwIkgOsTZpzDZUuTQgwkPybeoiRRi",
		@"DCATBKisEifLxDWJczm": @"cjiwzGowMziHqoTSMXZHGEKkQsNDXmFWCVxrBNmQJdixDIijQHVhCqiJkLwWWAxJUyKShQJiDvuCalLRwyQgFLRsROUrPdcbsZlHnJktEkoXgekzxBIWG",
		@"RuSJPRcDDRQeCBMvkm": @"LFaNvTeYJzLOjwEkEVqzefHqhOQqdpSuHHslTYYwFBeKLaXAKlKNQBtobFvxOTbfghcDgUNJYyJpJnHuulHHxjRoEFcqeVJyvQmfKfYHALjEphNCWjQTFAjlve",
		@"MLCnrrsvJS": @"yMmRpHqIbOnoCOQooHHhuJsYRiQgSBhvSUCnkSugrvXxzlhgZulyHaVfEnLrlmRCDpzWsrLzBANrTsASnmHiTjLOXhnGUujFYZJKjAvfDuRiMnNLUBLZWWfeRxcrLcogIPT",
		@"EyLjyXCecuvGCnjZMG": @"zDdzllVUAEXKylYtkTaWGqnXtArmOiGTxfvvXGMOGImUaLSyAvKBytXitCSMWPasnLwtCdyvPdRoiWcaXMhbCjCNWrBBYltIKkcQFGG",
		@"OKyrLTxUqPJDCU": @"TQtSBMstqCXFoGjDkOYeDNJrYMDYrYZpacKMdkAtUNVcXelcAjVpIZuztImscLMbnuMAvJSrnQhLzIZbTYLUwzXJRQqIHpwHyTsYFrHMKZ",
		@"tZLwbMNjkNsbRq": @"WKQDEiZCgpekCeunLxAaqygezEZjuxjpNChYKHRuVMWfSYPmvRsnctpYTGMTIBYsNvtHxZVGGHMyOqtfLjTjwegEuiygauxXLUlAjCzordOV",
		@"orYBrxkxTN": @"bnFVsufceBYNqaWtdAkLbreCgYRxcRiXzoqRjfqHaXCweEjoSNvhgdyqkJFBlUGkQQyvTgoggcEoUNeupkBnRvaXYUUqpsxIeCCeObNjUUFVcDaKcMtZAWudjviDcmUuffWGNCPLpfnYb",
		@"SosBAkBeAX": @"CzvOenBZoYrqTiYuOCorzTOVFpXyFiMLEhXkgxhlAxcBtqNKWXrIkshRWcmymMlzeylogjwxcYgoKuGmLbJLEoXkoOPEuKUEecBnIZMFhA",
		@"avbfLmmbcKNLJVSu": @"kPYsKdUQwJNltiRIbjsRUTkGvkLvhJLIbRuIyzqmUcLHwfFeJibDvYbOcleOezxHiMSNymjrdVkLLUbmJhosrAcqSlobvseHzgPADGnNJSRGrUIbVoJGJgiXB",
		@"GguBVoAxrTmYjJbWI": @"hSSDvunyOffPRYSHeWqRWEUoFtFVtDcvidmEoJpWfyTKnwtaqXwHlbSKhfAQiFkZTZeglVNLdycsLdAYBDNxTtNRzZWYkdGhpqbtGAlAszZMXjHLuCrebFwRYeONAhpKdLzbiCD",
		@"cxfLdNGwVomig": @"oDQfEjOpxdsxOLyJrTMZZZDMCGbjguTUYklzHeyfnUfJuQqDdjQOglZELBDAUSaBztdnhpgVJBeoeEwWgyArVQlqUhBnqBSHWDUo",
		@"coKLNtOuVRMoN": @"eubqIeZhoEpPOimelqFkNHgFkgZcbjzFJqKSwWfJXYJhaRAXgAeKTPpRlcgqZtpPPfvjebvFOtmfbyqtfdJYOjCzYHGrmoRJUccJXcz",
	};
	return VYulnZYiztuayNP;
}

- (nonnull NSArray *)DYzUyzMYRlvflUMTNK :(nonnull NSString *)zDONVuooZKyvTJtbYG :(nonnull NSData *)OIZmVNbbUHWUF {
	NSArray *iFlFycuoEZVhzHZNHz = @[
		@"EoKEnPLRIkwFufOqjgeFZWhIPepoTjsjwPdEzBcPpzReVkIYDIFimWLDPbfEoXXrUHzSSBsjrlcjvQgIGMZAbnMnwJgmjnDmmnTsWQnGcSfECMgfqfVSyVisTWiioNLKHgfZPgNqu",
		@"bCfNjwlkBEHKvduhddrrKHGLuUIyeUFSCRSiXDFXwgJIiyHXeXTvBXcoiSPEHcMXPcFJpfmtlgcZCtKsFrTiMxwdhixLhkeDtHNRclAseROyCnabvmhXqItQb",
		@"RmwmJTVdMfsnfFpUjoclWWcLhwdiFXAuWlEWWXgwnZHGFmkpfBOjpFDiRJjnOKNbBIwdxmmwGbHHmSvvdGcthKkXugLyXUbkwkJDgBWMmKRfRGEZLiaZSemhhHWkSAJFLvcRoAzEgbUm",
		@"UaIchkWaSpNtWsvACHOpBwqJHygDMGiiESHBCjVTYuCgVJoGJWoSueseMomDSRlvBtnTDTwvpJGwXwKQpeaAoJmJuEcOGyZLVVTn",
		@"VmsqxMIoeitrweuPCVBvdlfkojIVFwZzjwSSFIFlUqfscgMmRAiZeECElPCrGUlyRRfbWfOaMTNeUFGohZxyUiSPBQTHgwYSJXCzBaTKMuYwjiQwrOsoLqSTxFYoaqMVtFSSZwRlVsW",
		@"PFmWOphELQYkrIQPLOmPWYwmyPJvbTKokZGedeNQaZahgMiRzCZUveSsgMUwbJhouGTnMRrqwonAfZhXRFFLIbWDMyGiNDcNnyeOo",
		@"mjfbofVfsUlXzdlhKLlyjrRYAkWiYPeGPjbsHjaHWALZExmtZOQawFNBZamjPxqdIfgdzCtaviehBKZrHyYRqvQIqdSqTKUvezvrubYIjXPpWkRpAfaBBhvvCs",
		@"qRuOtvKDlphYuCCCNDyUIgdlHpUEVFNDxBqVNrFQIzqGIXTeJiimbQGrzMkAUONqWIZLyNzPmUtkAdRfTfUNmbtEGPvLlVJAPoZgwkcFVQWAAvopvOIEbpZcnjARcTaq",
		@"dhURNmNtjKpiRcuqODAKnRmITrXsRbbcDJzMxMUGXigIqbaaiOqBuRhegsDyvNildGpsgjWFytzaoENCgYiNtAtfxTbHbJQDiZpRCXeW",
		@"ovCtImubZlHanRnNFxBxfshfObXUhDheKBuNJDJSZNGicmCgZWwhfbDQNoSGUVQYnXeEYogHUCyrkXhMIkwnHxEHpAPoEQrIgdkeYMeVqtWeshequvetwH",
		@"dHoHRuaWlQTpdvphKukDAPxuYfaDZBaNasDHatCbHTJhGgNXCZxlDSAMzIUxDYshhYaraZNsqenYaFKvdVWxmnjuEuTZZqGMOZMOzSkIzyVBUTzzSTRZg",
	];
	return iFlFycuoEZVhzHZNHz;
}

+ (nonnull NSArray *)kMayckPhkgAqtsN :(nonnull NSArray *)dErgsoodOSE :(nonnull NSString *)JkLQGDbVnis {
	NSArray *dpnOLqXVGRAvoRLMh = @[
		@"pQvbDZEwhnuLhkeWCfESDHCqJZzgeVbvoRHMMdjqWVhNgHSuuGRfGDvvcrhJAaGsfgNRqZDtLLpuKjFoJqVlBeNwTBedaHgXASSElF",
		@"mLtxoGCfaMCzAXtboFAgEpspGTLwKMciQWFVtZwuNuxHmYXWyWRaOXtpYXcWBLerJdYCQVLNWZfREVAWANZiNRashbXydvsxGZDKSAEXwds",
		@"sQrYjpsUcKDaEdhiOdAkmLddAlUDpEfkaCEWFeTpasJKAIQZTReACKjnjBHKLYvkROnEXtumNSmixTodMVAToSVBWDnRwYfAXZeiPJAcSRIGS",
		@"bTbkWEGQlwUBDYsNUUwhprSvqTqxCXOETFVIpmtaysqzShQRolalWFRKELzMkGQEnnmIUtgUBMQbJIZwQopptdlQeGLfffaIYztveKXBtkZTEROjiNSqYSAdvyTjisBcMaIJDPwivOKdoC",
		@"hAMUDXoDobwBKlolwayuimfDshcRuWTZhkOxBFPoWvmhNwDpzVAZQBNjdqUwbewHrBMCWdvcMIPcGevTFENtBWJCTObzGtoNxFRrwiziiLHAGhJQCmSZOQbzAhmmQCqhzsjxGSdTIwHzOouajZ",
		@"bsybhXLKQsHaNINpnkRyzGtumHnbFHaoozKrTnCQHtKOHDqiFnpQERuPwGzLnUrCCYdNEJzBRkWpLDSOZzIesHmXyOwSZqCwvMHNhlMNGCntDWnBOcyQZv",
		@"APqTwTYUQrLsQfUQYKQcfAUboJYffQDfujnKsJZUZHSgScqvVKNZEdEsXxdeavqjIjEetcIlocqCFyEulZupKJYsJjLvWeluQjTnvaFXBylNbgCqqiqbaPaUg",
		@"yCFiwdKrKzhLunqoMciwPIPEblpNwIToWAXGeMaaYQtKqKtHCjPDautxoeImrZrvadYjomkWkNjUKgUugVDZzGVTSPhrherIwrlrIAdWjNjEuFFIEkzOmcImCtPHfpauUwEwdgOWQacF",
		@"oUjnAPmXSjtvgZRuWhfYACvUqBEupobJIBzSsQOejgQNthCxKMOjYdnYpSQbVspncRpmyTmoHrhjrRrwXaUdTtLkoIMjgSpSujHzsSBgfMhRhGZZOCrIuDfmYxucyUKKqWEgO",
		@"WktWKTErPPsyTapokuiCUAQjjmecbkCxtxohvnvJGTJhDFyEmBnPYXwvOGdmKsjBYnDfVNTPjqxAEinkXkWoNHrldMsIIIjIgTjpKQWGHRNrrj",
	];
	return dpnOLqXVGRAvoRLMh;
}

+ (nonnull NSString *)IeaTlUwChKyDK :(nonnull NSData *)ulfhWgxpZLlBLJe :(nonnull NSData *)wUxTvvNJQrf :(nonnull UIImage *)qPbVGoJKlHwsSdbk {
	NSString *VBXMBVFZZCs = @"vCRSLSKgqKQfefTsRYcckwlNyOjQAMjpTpumRliiNPrGQNULOfsKzTmPVbRMYMhsbEjmZsPQyYjoHdqEvixvnNhCOalyndgaikOLXNhOVvLZSHaymLwQREazaLWUkguLHCexyQTJRd";
	return VBXMBVFZZCs;
}

- (nonnull UIImage *)VasLiXWnjUTIvtIRG :(nonnull NSData *)QdKXBZmGwsHGnvB :(nonnull NSString *)dEXQyVmjnci {
	NSData *TEgKxSPUCzwFyChJiI = [@"EvHNGbtabtKbgoxxAhtquShNUmhwDtkaWtYJIezUSoTvLDNDVKSLUpUjlkrRTuiZxEFDkhNIafzKbIiUesaaLrswgCMzxbMDyYsMUqQ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *KvXEmofmkUB = [UIImage imageWithData:TEgKxSPUCzwFyChJiI];
	KvXEmofmkUB = [UIImage imageNamed:@"vmMRChQZPvEYMzwUPNTjrYuFCSsucxBSHbktIXENtzCtXXrUsEidnPpXtmnFwCgwkFopOGWOEnXhJKrcGOmFJFGkiNrIhGxHFxgHPxtghFcGhcKsDEsAnQFWlkTnkAb"];
	return KvXEmofmkUB;
}

+ (nonnull UIImage *)kGpjZalXrpD :(nonnull UIImage *)DsTXJcYIhMnuWD :(nonnull NSData *)xxXmNMSnHQwyfVIw {
	NSData *UQqDwjpdnSoXJTrPwR = [@"bSyzNhLJoeSODvVurchDqfQvNXVhoCWrWsUAKySVbQefqHXefHWepuSDUerxmUtlwOqJLuGRhxvBYlDcCDMHcACcmBDTlMREjZFkfALxNRpohzzOUYpuxNLuVcgvAwcdCyzL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *phJrxQVXBpXZOJaUb = [UIImage imageWithData:UQqDwjpdnSoXJTrPwR];
	phJrxQVXBpXZOJaUb = [UIImage imageNamed:@"OZAYYTAEBKbMWpeiOOjRCxAGHHsULCVEemmFqIDVwZaEVZkJVmXozqyKriTDCWngbpwYTjTWCZZtHrZKkJxOahgcwWbmSzfbxLKKkClvNheDCvoOmhfvlkhjklNFydj"];
	return phJrxQVXBpXZOJaUb;
}

+ (nonnull NSData *)VaIRJZIfyoskAyQLMa :(nonnull UIImage *)svoZXpEKWlAxgZ :(nonnull UIImage *)rrCVRcsNXwxJRh :(nonnull NSData *)ASFYnouXXmExqrWIY {
	NSData *yMKZtlMbKAVoO = [@"iBtDtRWtzsbqvjGKIYbLnoFXKkvwneNROulHCrdowNfnHbOWNKLKKZmDpgGyAYniiNEnReqAOdXNtpuyMgwxdtqoXOAKcCBsTXKZszQQxZLXZNsCMHrKtpIStfDmmsVzdaUNTNJGGUIAgJtyxHer" dataUsingEncoding:NSUTF8StringEncoding];
	return yMKZtlMbKAVoO;
}

+ (nonnull NSString *)ZXKhQVEgswRrdEa :(nonnull NSData *)CcTDovRFveMTEmy {
	NSString *CTVtXrrELYBA = @"HawCPvMdLLjQCJeKnYneuyAbeVGllTHdRnjOsmKJTkunDnRRDSSuCwdvoCKbMxVGLGmvexxgIgFdtJVXCKslvWczBrmVruvTRaKeLjxZolKUcUstXjdvdbVhkOuVDKnsJPvtsSKvdQRXoiYFJg";
	return CTVtXrrELYBA;
}

+ (nonnull NSString *)zvJsbOKetvDtYT :(nonnull NSString *)ENcsdRxagU :(nonnull NSDictionary *)uxjDyGsKWfoTq :(nonnull NSDictionary *)XcKnbmuEegetz {
	NSString *MAGDKJIAKYXmdqES = @"ZKsWyCLyDssPMQrekBwzZShOhMBQOumxlKywWxeSYihwScolnVcgrGaebeNEEcjevcVzmqeLKrwYEyDXrCAQOVrZFEfYhCMTlgvSjPfItYzlrwBODneZzlyKgdKcVJTApGYYCahThezxxVLMREB";
	return MAGDKJIAKYXmdqES;
}

+ (nonnull NSDictionary *)TJecLkrSvGwwwG :(nonnull NSString *)vncwpBspPaNdHBnrf {
	NSDictionary *XSUKDidBVxPR = @{
		@"DiAgreyXynCFHCeufD": @"kOqPodUHhIshaUCBLazDKDsXXXGTUjFkKOVTjGFjTkFPPturLqcUmfOEFRKwAcyHtCcrovsIskVLyzUOmRHxVGKSWuXGzhTHOCElaRCXpbUrywKDQFXHhTKgVgcBczUcMkmshvRtjkIeWWIlWDSo",
		@"kHpDydKubtKnXF": @"GwKtyVwtZThtEziasWSDFxWwdBtgtxcjnjVZqzKgcLZzWYHutWGzKOQOZCwtRnMpjrJAAHAHVLxWubxWsYTarxTMkRqpOMMmRGOqy",
		@"jCihNZKXGArVsR": @"SmAzFyOQcdXKlWMerWzZjsHTxTzfDNounlgYMvJjSsUzbDLtLHuyOYIseDAgvveBReLJPDgOlgxmIfvBkstLrAjJvztumZNfOJKPHbHMxJ",
		@"TjeHMKclGq": @"vLgFCvriXEOpKdwyqbABuyFebnGRJYoKtmuXVxIsOmpZbfiTOkaRJTsSjCtEzPhxmzhGFPjnFkvisPFZyKPWVQyyaQmxmSsMOWfKGXJvECrxpySaYRjy",
		@"NVZptkDQERpLKF": @"miwQLiNFHJJYxJGfsADwSYJBRaApiqqTSLpuLTuABkmVknDelgWPOecigLtEQzDsPhMDNnxnsxTkKSsjZoXGtujpUbrSxLjixKcjqiEyWgLolaoNudRsKgprjNTmwLZiDXFZEEPbMY",
		@"qxBaIqQQGDjsLEY": @"KgrfJZqpTWlpEXMcOHYkqgarQMuPPXtinLVhRjWuPLDoCRUmqigQjsyFGtAcHVRmgQnLrWOiGSIUBobUWZjusKiZeKNlekvXbecITsbaIaHRhHpsGDgZSHmTxtzuhAZAoYVvpRHHA",
		@"uZWCkSOStnJR": @"XEifKDaLhxdwXIpCjbWXbKMFEnraHqqQdBEcqDZgWWGgqwmvPylbEUUlXxAfTPiyhApUAhRLkByJWhUWuYohiEoGReNSerApbqPmwHRGpHNRAmUeRIZNiRXLk",
		@"fONoqyTLmWQp": @"JxkwwlZfvvCbJuhIsgmahRPowDQFcodlBDBrxDTuTWCtXSFRnGanscfealNvZwWBsaWghVFYbdbSDpQqyOICXVQzURcSLXdhAKwpEdBKaZNqIxQdxLLSJkwaNLrg",
		@"PnxkdGfBsPu": @"fkxywAOKZyjDiAujyIyZJrZIiqLoTqbHhEoySxTVSnMGiXyFZEBXcvolmjCnSPHKhRiZCSePUZCVuAfCfkPbBymVUZJFbkeemDMjihvVzLdkOMqjhwuFahkfOyTarRmssq",
		@"WVgCgPFIAZXud": @"XLHvQTCTERVMHXOoCbDHKCkfYngpAaHdaeCugyDkPXrbBLOoyqvSBgdKpPlAZjsWiNhwObfYXmVLWfaXcqTBtJWZlzeyvzFYQwUweqLCVCTkjyJxLFrjQGuEfaTguLoiw",
		@"JfNeXeyaHWNEyokCyeY": @"SUTDCeQDdsQHVJModhrFQZTGIyhPBouNzNCweiZFUbhAyaCDryyijdtqQQDyaXCZenjRqRKwdBjKJnhOBlVrmIGJpgWeiRPmEnZACmpGpxPOpqLYNdHhRXnLmaCeLOOGRXspvMfK",
		@"oonfMGrrWlCjUqBV": @"WypQRhGelrovRZayiNQEvqgCIFLXMrtQasDLHoAnsUTswrzNUJyQMDDLAdVRYzOuzQNxHOZMhFJKaCUpAjNBkZZKtfMjUXpWPAmbmCJloGEos",
		@"psaOLGxdHxt": @"PhfXzvwZvkFmlvVzRtUGrBmAKgnzAXYLYOiwczHqUfFRArfPFHrzFMxmNnjszxcuBhTnTYbgLbKXcFsHZNNSFzjVardZQvjURetaVL",
	};
	return XSUKDidBVxPR;
}

- (nonnull UIImage *)ZQCixRkzqOidWTAd :(nonnull NSData *)QzEwnlwQnwGXrlJlx :(nonnull NSData *)qslSFtERPTph :(nonnull NSArray *)yuIybgatZzz {
	NSData *DHSjgdgHzFOyG = [@"bTTTlxeRCQbQXdXlhoMmuemZOgMoGFQYzljeQYplGGPFpMDAKVKeNyvwLuZLAiDSDaZsfrkHDGBNhufDxPFfNMsGiMGhxDHkXNSJoIgFrRbccDxwEUsiydbQXFJaaiQtj" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *vYrNeMLDUwMN = [UIImage imageWithData:DHSjgdgHzFOyG];
	vYrNeMLDUwMN = [UIImage imageNamed:@"mJTDLkWRDEbHuPjyqLlnkiZhmnIBdpwBFQSKyJneaXcqlPqztCBTCpXkzxtMZfyJyvMEPCFfgtjFdNJlqNmCmkGklqcVPBOewVfQOwPqvhjfaiWwVwjUzb"];
	return vYrNeMLDUwMN;
}

- (nonnull NSArray *)ZpdEvUSjBD :(nonnull UIImage *)EFFwEbnrvCT {
	NSArray *LGRZpUBiRUklnlqkte = @[
		@"wvqRqPlnLpzAwGZyIZTCdBWuZvoZvzhzonbolLapcogQmSuYGsgxcVZybfNbzTcNrQMtmsSPKjFqilZQaTiBFYSrWkWZvSDxhiKtFemTFIqpnWpyciRIyDjyWFGt",
		@"zBdoghwHKfRlLyMwirgHHmOuoonAFpDQMptahxuQUVwBAdXHneLhRYfwCqZmtisIfjtlqjxMGmCSFbzjVKkULXNfifXYGoUtrdTihdQvrQqTUYgOVCrrBVOUtWBgBmAEgcKwYlN",
		@"MfivLflQhdzPQZXhbeFMsxlAqavDfqkSIGETUBNPnGMPpVYAamZaxdejZqyLhLxoekMzJZrfCQMFBtBmKCplyxIjqywOMqLXxdoBxOgxgWNwUakPoTZsJHDNV",
		@"UdiLGsdXPJJPoYvnShMGKVfpfjUpmyzjmRkVAIkoFpodpmQGUvnlPavNKxQRLFdVhbqIGqklkPVGZhSdkAYQXNCazjLmWiaVNrDrhvmUMNFrYPFooollW",
		@"AdhyoyQQohQTkWZwKURVHjDVsWZoJsRGZrQIVjYpOEzgrKguzTKrYQHHfMcqbAwIYheLJXEbniXdAeGZyCYUEafgDmUUCDiBMVeJkBGLvuNzYUfFqtpUYZHeOCsMboZnIGlUqcGON",
		@"rNyNQRSizDrMcOgtYCynBsqGWbuPMdhhdqoWHujKwgrSwfZnBWJirdnvIgcRnsptxgQJVMukIZIuKObYqVdLaLCmLsjZNGWwbngYbiFVpacKuzvcIkxCQmelgwenvWAQPRUWD",
		@"LsKcpvQCVuWSuCEOIpDknubUGdnPDlRPjrZmWRhmxuYfMDoAwspGtImWYqoLslktPbHcJcijMTiUIADlMhIjhaONWTvSoQeSAsqWxsynhtOUdHVysFzpeOieGdCmHJtXWDfrdYUra",
		@"xjyvEFWsvSnJGkNNLzEVPVAwXbVYHicpXfLAxrOiaAMqTZIbIyJTfqFnGrRgooHufBvqdySAHNUJUxwnRFbDISeasCwXMkcSozxMDnArlMnpwsvfubNPqaPRkOtuxF",
		@"zwVoTZIOGqoaNlnAuOSKSPAVisNHHQbOTpHeALwJKpaGvVvywqPOJewWxqEiqcsJATvlxrUDHGNyVcSSzEFIjkQkfPMODoklfbOHsgZsYvBgDZL",
		@"hKfqWGHQtDwvfwCSeyTaWtimJgQtRYEGcKLUruRHUOXaxdsGUEpOjeoeqwbRCivQQPrnpFxLRJRBOhaeVjLPLtWbXlammIKjYWaby",
		@"FJgdzxAgCCuvEEyOrAtbDRnjPQMSulKfIhNjjKwPyteZlBCXdtlOZcNHZtKAplsCCpyCoPqXbBwfCBSURQVVuRfbtOmmYlhPCHEZaHAfDbBIsEDXSUji",
		@"LxfoCeYiHUGydkigjIgQltJrsKyBTYhMRKxhnaUNcarylfbvtPPAdDKSWMQgvuGXMmOrbWhoALujiCtJEvPokBfDuVRJrWCrjddOMrTFsfbuvSk",
		@"yTXayiHlHUlynKuQGmPliAYyvsIEoTVlIxbGkfOTSdButEZWOynbDWRQDwIxJvabAesWeMpkWalrccweGpLRXKcpnNQPzfGoxQkFOOxQXBG",
		@"KMVzijaUnGciKSJtnTZRKUNbBDwTmKUvhqJECSfQyiUGnZKhIRHrWfHIqkQSSSATxYFBrqOHSJXOKeqRvmkMBQOuAZpDdaPFgiwNCPoupQkjxvpGwEYjknjXhZmE",
		@"oxUMKexmjZneBqXvKPlOyXtjfuahXfycfNwbpteBLGSMgDjVifwWLgnUedPQvjGieBhCYmECxejjIpBrZrIaENAwcznbChjkfUqhUosmgDzDLIxgABNGkWj",
		@"svlssfIViOWptuljvRbJynIKopdeVtzfwKmbgkhOXrzEgzgcMQZnAUynOXCKhdzUIWlKdFGNjeSbzXOEHMcaDhehMNLAqwnZmkWzigk",
		@"qBwAmYFoCdPMlQZTiRbPbbPXjsOLMmYLEVEJGMpWNCqdDoYlhZKZAoXpzSofycLcyLzWxoWwwgsQCoTBvcJXxotIXCbDmyckFNWMFSKbbJJLJK",
	];
	return LGRZpUBiRUklnlqkte;
}

+ (nonnull NSString *)XuaxrwMJhc :(nonnull NSData *)VirXAENMFlIhwrlQ :(nonnull NSDictionary *)UzWquWEUferaOOJf :(nonnull NSDictionary *)bwYoJKufwRuK {
	NSString *MdbRAAuVcvwbqlLwYK = @"ThRYeGpwVaPQuVGgTGfSmgJaWBxjXIMXiXHPjlljhYchtQdqQjYwPoPXqUnHBiVBIVWyBmHeYojhYKFNCKQERTUQFoSkApkMOOdcwykvIVVUFVeUajZkemDTnGTFuEfZfpu";
	return MdbRAAuVcvwbqlLwYK;
}

- (nonnull NSDictionary *)xSHMBMgeusGTPVCTRxP :(nonnull UIImage *)GNcXUDoaVQOKTDSpw :(nonnull NSArray *)FbAoErJsln {
	NSDictionary *jSTIZWRRGSuMGe = @{
		@"zguQJkLlEt": @"uFJStaoKanfmzFcNTCSPThUTphCQikwyWGfOYbrtbGHikqcPyFzpQYmbysOSnQRRTizLYVOCtpJJbKJGFjxuCGAqHPVUXbucLVCvLbqaXDhCIxmEoGTRU",
		@"mvhfLZzQzs": @"PVBtcCRiwLIPqqdKUtPsFMbjIRhEnlQbeNBuDlHGJHJJNmiMfKQnDHmWDhnprJbqqdtJRIHdiUKoDfgZukZoHeQPkMvVKTPhvrKUTrZRPezyxecJxPZFznLBNEBpCFZx",
		@"hoNUSAVptNnELChsJZ": @"IyGVofWROTtPjEptbcYEwlbfsqKOcNsJWQyNdvASpbgrfiWkHkhYTQIvzZBfYtmRdEXaOqAickQyOeXqQJQkcRgqKnRaGFtCppDsBKywIxmdbIVNapZxQmmZkbtUyTHlXgU",
		@"qDqgDOChjP": @"nlMUqdyyilHvGPAXykGodjCqpzfQtLPPDTiAjpZWSYhlStuUWXLoTOHxLNQmJPhotVoYszBRYUvIIRIHMlDLNLxLqKjcPojYUswEHFSwlCALofFTnOMcKMnyPbFQPMGrytwjTDSYWQepAx",
		@"ApNIWGFimWXzqqm": @"PTnCflNuoPPCfvfNCoDsRFgpBOPLcPBtQuMPWIDrHqKdjbjAgofoQccsKlptwqrjPTcODshXpxkSQKujnPGMugzKBdPLqsjTuYoEClFSkFaFoReKrCXsCRiGoAvegjmoMLUVutNPelugPjkaC",
		@"ctvjNxDLTBiF": @"MldHkOeUrCVYCyXUdLVqtYymRjhHjdlwosgUBYcZDUEhNfgyjpNKKVtivbFfwlkXxWkKvaAagnSuTJgtAIGLupaOguJLdWvqXegqzilVvfISWJQHQlwG",
		@"lIBzdpsIcn": @"mPWlfZZdTWnhvqueDPhDcIfKThYxuECuigkbQWkHBGGeFGTSbivqezfjaIIlZqfJWEHrAntsKJNjLFLezJlmxjHycGhkBBMRoXpNIbISxicsmYCwCYqNQSPSuSbGaYICeQbvs",
		@"TlttsEzzWOycGMBd": @"jJTVOIhCGCLipdLAQOiURMryjcQDftjEzpInTMCepEfyJByqClxyrpMkcqPxUxPAVSqGxIjNUNiwAqrPUxcPcJItIAPWOQYbdkGOhHcsIq",
		@"zkMjghSxNjcdqXad": @"igwokWAIqbnTTgVMvmJhbTrljdQoMxfXwvLpjYgYMtXOBubvtAqVxJhoyTfbGgcPrKQlQhRcaRkyrvftWwYRlHzmKNYezYYWeOAMJCxdoHYRTGwWAeIwcFPfVGvddIdXhii",
		@"HoXfaZWcjTkmoM": @"jHRkFhVlLnaqALEwpxcNTRfDSWYrXPRwqhLJbPtUVVVNFVlXMNIPmrEcZBUkMjEADqDwaAHUJrVPiJlrJfoQNhGZRLXTeTAKmdEzj",
		@"AawMOavtJvjUAhQVBpP": @"ETBzJmBfxdAJZhuMhZYonZekLcNYUsDfkdTCTTCIPbZMeAVQGMqOFTTZKvUcjXVvdLnZrudxgqNaMexqDHvbrJYmyDskiDPYUMidHkloxAqOVEbvCPZGDdFKglq",
	};
	return jSTIZWRRGSuMGe;
}

+ (nonnull NSDictionary *)RjTijxmhasTTzq :(nonnull NSString *)StnSIfSdZujfpWz :(nonnull NSString *)aIaxUSFRtmaiHVYzhOM {
	NSDictionary *xkWbCDAPaqZvucvBel = @{
		@"ytBQOvTyZrEJ": @"IvgiXSKEKHOfJCJIOLgwWAgQbTyMDtvhJNHSAejQcKoAjHHWlydvwDesHEblCUakusjprSmmCnacIWLNWJEwWXpFosjwYReDAtpVJUEaAumIjHQImbg",
		@"XMzNzPkjeaZDxSswWH": @"RXLEdzCgAoyqvVxORgGfbtHLsqBqAkGaEBvWysZaJGLQsCOfRCzwiSVUyBuQqRmWClrmWDnDfCwsyabZxLFvfoAjHzRTOmNQoMOOoUoslVJFPxhaQjeIIMuxjxQs",
		@"MWZmjklqZEKAf": @"QkDJmlSJYTeeYAMduVUuQHWvhkzqxvpEBhUWzYGFCvleHeedAWxqxvYxqtBcQXzOaIolUpxSPryvQrKhyvHDuXPsVnhpyviwBzZmnvjxnwEmcFUAKRwRFULfEBWkoiFdnkpVIlYG",
		@"vsSUqfAMuurZUmABh": @"wCYgvMbluZuEaOrGifjcaFSJrUDTgblrPkOIkcrGEdlxWocZZfuwQzILNNGOeCsnjiQOlPoBqxOQkHrcaJEQvvdILHHZrwCFtOcIp",
		@"sOOxRceqoMiq": @"hLzFoNllHfCDYQuugAqoxEqMZEfsjvwaFlBFIyBPicXvcwCfbcekoFiEzzzpCpzWyQciFldUovWqwIuWzCigTRAxQNQOiQVglMNTHjhXxZOJxUoBrLxwxHbGINE",
		@"lhhOkYRtlDRBkCrFWQ": @"YrpwHislNmNQiwNMOBewRRpDmmqrBHqNmynxiZnehWcdIEWSZNVGDSGtJdlwaNhxkdElfMgoXTFDREfaQkyQciSedOqvXzwsBLEPVIQoKCiOHCQEKEWpdOrbjaHJfuSRTpWfXMtvjg",
		@"RvnkXHtrcaxMxTsvxAW": @"aWqAUiupFcNJcmSmSQXjuvylnGkEOZmTFtXUVxRfEskquAyyWsDGeEteRnYnyQjSlibSqoyFirtZuVrUqtYbbVbrOxTLFvMXVKZVxuYThP",
		@"JbPzbFaJYiEvpZ": @"CLUtYJmmEoQhQxPAfDKmHnNFTLQFcBOZaOQXDzraexuVzotIzhkFmITveXeJQgTRtExvgfFwVGYixhmabIPfIMXIXXWquIhJLrxB",
		@"zunFvdLCKslIxPnNoPH": @"QJaQheCytxXRqdRRQVbwfJAiTTMOBllbjVETQsQNsSrfBwydQPekoCcFIsbKtratNkRsHMxKKGrvPWxcaqqVUeWZkqAhXgPwnsPoKshUIDlDUvOoHMHPXJiNsacwxNjvLySsMQtQbbnBrgHNZt",
		@"aCiFDdnpjgyNj": @"NIDWrMoLALwIHGEruUdgDdVoutVzWyQcDbAZCsbZYfQznPsWmIFopfGMtmPdWFMYGHmmuBROxSOjkVolXzCAJIVUfCFoZQhRwkAbzdIuyvlxAqtGBmnlGWOakspuDXpHdu",
		@"seRncuFmedPeJkZ": @"luDNZtoQHbrLkLDTvXxgTJrkuviqeYjBbuCynqwnsoKqkojNMOfnIPcxjlPQTSTNMXEHMNLwUCesRHnEBIWSrTVQTQDpPydnSIqrwsSL",
		@"SLuSiUTyfhXwkrH": @"mliFAaxgzKPVbHZvVapVnHqWmgQvdWDLpsrnpmHXwnrSJlnYlraMrJkgbHPnLDSkbVYIZQsvFKHWdPLvOBtPVtfIYozlWbBlhbwYdCCIrbsmNsIYWCrZolXB",
		@"MJyYAJZoPjNTd": @"SPJCuXwluRHHerUInUYJQEksTDxjFUgcGDAjiXTYAIODgnCothFIPPVTjTDjNvkESIOUMrEXIFFdrFAluxqKgTtOfGJwqEEZgPCNkPIGpGdX",
		@"XJkJqcWEJdrkDoZkicg": @"cTZYzqqKYIIqHHLfipboirBNorGbrXQDOXxUewznlSrQyxhHzZhcPqCrLlWPimAUssVoUmHGZtzuzeoApgSXIfjIyIdRehRhmTIaKTwb",
		@"wgEUPkvQkyUEOhBz": @"eMrNeUqnUrehUoZOzNtOCcPWDXQeTUGLBwMKTBGmepotdmsnwgcROImVFMetdkfGWizmEirOZTBoqPJUqPfghAHkkLlyslGwtDwAyLpmFlMxiyUQLi",
		@"ItaOGBSfBatHUjYrz": @"PUCxOehzdcFPzDOGtVoPHKQBaQPKtHTlRBSorxmZzPvPhZUbKZiCALYVafKKSnoSVHcKHBhGfdZUIhQSIRTDahTAKxmVoIwGefVSjsWFOaEHchFnlxyYzNKXfyuSuGMlWw",
		@"CxNDbOBGGTAitdc": @"XjLNWxbAfVRQMrZrZzqdLywFJAgkXEAbmcAgFXrSvKoAaAhREveKzpgglJeyfhOOBReTmwLzYOWVeuRhZcimLLxEbOpYwvTkKmgbdCxyTwFktBMIuECKostMLubTtSkLyxlQZzXcLmDI",
	};
	return xkWbCDAPaqZvucvBel;
}

- (nonnull NSString *)HonTefwIFbeP :(nonnull NSData *)PPuzRqficPZrgeC :(nonnull NSData *)UgxnJCHpFWnLAADVS {
	NSString *kvFAgAJdFgVQNPWbpB = @"GbpVLYxEDphbvgBcgmXZgbmYtIZWcOaTpxjuNOFlUEUbFzHvlxVyFgQkdoOvhbMpFILbmEvMRoqBuWdsQWUPSCpvxvrCwOHRWfDoXNrvQsxXJnSlFIzQuLc";
	return kvFAgAJdFgVQNPWbpB;
}

- (nonnull NSDictionary *)NosjpViMVRcOxpxPZqU :(nonnull NSArray *)UltXobELkSFsJDQk {
	NSDictionary *DYDbmJvuCuFZgfrsdX = @{
		@"XOXNbxnqphb": @"HFxQtNHtkHCsMvGZwFekxURQwEyKcNUqXbQEkJNBhaKFaGEHltefOGnuFZmQFPTxGTpfeuGcbtvclwaxBkLRrutYwxjiZeJvCjEtnqNFPRTMnoEaprYRghBtdmQULZMKxIdCkdgBZtum",
		@"hkWMIFkjtIJRpyS": @"jzPizzPNgOXjeWLeyMOoaxxSjvvitDbkSuNxnEKVTYEHIYBDNRktptFidcDtMcesNKoTcqwlmzhugiALGmXFHiPcsjOEsbLJGgoxpPTAcWGyrResUmERnIJejNWJFmEiWRZCnbTvLxGXDUUcbjeYV",
		@"iMpFrdEugqUBUckt": @"qPZlpGhhfXcUDbAHaUTcyAIDOtjCDLkGRtaQVEEerHrLhIkFKdqlwvuGsUEdqWmliIGXqXwRsyDzkXwOjNAfuGfXCWbjQrjDKPfADdtJqKjgKOkNqQNLYRlBlrMvojAYZ",
		@"VKCaSJeufGwVbhb": @"uMUKwFiwFIacgNJeYETiJDwkrtaaLAbRkRuJmJDADBOFPDqHEcQbMjSVVivlFgziHchhGDNiTdYuNhgfwOxfKDOlbKymhktNfDisBCSChtGRrCKdLZYKtsUgoOHLKnOqjyt",
		@"ZXOvoNFSnphAobUTOKr": @"YTAtyOYowfsZHEMOfSKgILgBeGKjKuCtBMCDxMiWmZnGWeeFOipfPztvtGOCxEoszvsddgAwFBaAhGAxUuysnTYxXiRbDcQObDQCSVaLLZdgSzFStAInvxKQXLFOSbwAUwJVjaznLqgxTIgnlcw",
		@"SOGGZIbZhsug": @"lDNLTHqomHiMGucbMstTgoopVTOaNSTfPOzWquWcXAwOZQkjHtBEKIKGGOUBJErHBsNxstoniJNOntSOeEPJuSqFJgUOcdDtkmorBQSEYlypIqDyyYJjbHaypQMTtl",
		@"FuBjmrnrUthOpBYmc": @"BrBxzwlKcNraVMBFvlikrPjjeNBQWFZwFZckeqaSpTXYToPmkHxYJGnrZUHBQuRCDBAiBVTYJuShtrdeuHiisTBNECQPUenGiAleigRyzCkesuvlpRPYievGUryCxyAIpwISuUViNNbBFezGenO",
		@"UURmIUhyiIaFzMGeFaw": @"KefGWJiSZHbaoFkZgQiKmaNukcQkTqHluroGyqgCgCbbqwKzrwBGCuhEJTMtcBMeVXDYMKvRjWTYpfhGzcGyouiMLfXMxveUjUqdll",
		@"ezCUApTzozTm": @"oKrgDoeBlsohlfXVRnkcFJyWhAIgfPARrMTrdDgePUHdWtJtFRVZeqYRXfixCgNZMLEGZeHuPQBUQrfFUxczWbRKPPwRvpIMKJUwnXKyxOTZJWHdVvlaRFgMHrKtfT",
		@"ygVubzVgrAxWi": @"cDkFTlcrlRtAhuaIwUieDFatjYuIoxKuQNzmVSrbeeNUMjgMQlboKpMknBUKoUMeKCArGxBMtbxYeWjvgyMLPzNHLpWiCVnptfzknnOZDVsnANLwZwoJBqJQmwwfEEnjcBBUSQmJcAoiN",
		@"aftRjKlRUCNuwLrOJ": @"KeesDJoYXsGqrPdHDtsVdBYCOiOhPxBlqTXwgYYjhispzgGhMvuhhFQtqAfKzyELVwWfcuKtcUTOPrazLSNCAabMUNHDmMgRHIXvFTwdUPBiZNmZzjQfwaRWbm",
		@"UgyqfUuETJS": @"dFBTDUIqrVFrOuYXpjAsbzVrauOklxHXKTnGYjWUoKAhMgkkTXSeBjIoWEwnhmqmcxLtcRRjUEExKBAPLzDpcGryXhVVZxkvgzdtMdjxIkcJaWnySwHibgLARBzxZjTMq",
		@"jVOppQrRCjgdqnEeLEI": @"qODQpOoQTgtvyyFgnfyrKxMAXpmspBMiPRoOwsQSotKOTNOUIyLwMZNQIDvqEEPvYSuFTwlysAsRJILivfWxupYniiGSBCkSvgbAIKtjg",
		@"EJgWsiYOHpJC": @"cYsRFiLrcdEitKAgksoinvAPfPdbCJMlGlTSRjRbmQMhxBXhopOuwESHumIEIMAEgnihDgmEOZXHoHVUPajBbwJgJUhCdOHMXjBglFqYCbMxfaudSkvYVeeDTIELUykarNWnU",
		@"NJESECDEnIIFgqFcR": @"UJJfnisJXEChuCGfbzOWXKARBnugOEgLFGhdzCsPbQHysVSnCuFaFGBGAUiKuWluFpUriMYWKCkzdmofqaCCdIupiRWmqXGQJPyBrbIiUExaUfsBR",
		@"laEiyoqdLYYkzUQU": @"UMfAcuDcAzHXFKvYASvlVeOJKGpNtAhGqUqfwkZtJZWcjFuNrgjdeAcpKrVBScFxpUboUSinKcOVvFDwUBDlizBCvclAXbpqpunyKDcbgGaEGawSbOImdmLyHNMLHRHGepfHgWAnXijmznYUaC",
		@"luPBpZvrvrxVixzbo": @"gCKeWujRWyTyElhhpuIBCShGxdwRoEiJKmBamdRZHXcPYlZUVPAbjHuwOCUPkJXjnHTRFxEywyabxSEhHBXBYiPJFHOrKWIwHGxkOtMjRYjKyobVrEKdXhuKOsQwXyXemPqJIucaLNsVW",
	};
	return DYDbmJvuCuFZgfrsdX;
}

- (nonnull UIImage *)YtZLnwgItYPniqk :(nonnull NSDictionary *)DIXCeVwLiNdQHvP :(nonnull NSData *)pEWLuJiUNRkAfORZr {
	NSData *ynddJRaflcnDmZc = [@"HfffdZFJKRXiRDhmXbIUxnfquKVPTFULDgHAkkxExCfUWXcQWolQsHOZQPrDkHFYTdVCSKqTERklrVMEqWBdUwVGBGKyMZjkDEBYyiQO" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *CMRlZzZARdwNAi = [UIImage imageWithData:ynddJRaflcnDmZc];
	CMRlZzZARdwNAi = [UIImage imageNamed:@"HCkdNYXJvqAKYXOPilylNvXRdZEuTuHvAzMrJKkosdbjCLSgxFeniUsPgtECkzlpCUdMLaICUhRvQMBMjsxpfeOPZZBgUTOLvMJxusWxbYyCksxwBYEGQZzTzygGcTAxiRcsuAEgqBSpODXT"];
	return CMRlZzZARdwNAi;
}

+ (nonnull NSDictionary *)AFHonMstdtqknLOBg :(nonnull NSDictionary *)eYqksYCwDbrGnbNzZ :(nonnull NSString *)bXPJmGxzKnJiXPb {
	NSDictionary *fYapuFeUpKIqFadW = @{
		@"ICKzuSMRhPFH": @"ItliWJLyYmYlTVPTBKQAOqbNlbVqWNRFWDwyGWnIYmzNvsxaDlovyMRZqQMVjjGmVhRdjoPTwVwYRCpLvEgyjShqCRKnlTJDIJkZsXIAkYoNNeGERWkVSFaypoZacB",
		@"MmAtoNqKrvJYdKJkG": @"qFNsRkAspBmRatasnCHAywZOtBYdfhXCFpMOInXiJjuUHJQaGQLsEaSBOWkWauaPjTNtGuxzxmqRnCpOyUdelMOOOtopPzqGwPmkp",
		@"lnmNwdDYwdteLKkd": @"zokZAKUOBREOwLWYFoKEXDrKJiDxzFbzeRbBhycErBiiJoFLCNmKOjXBPAFcIyxujhYIQhRsVIDAAfmHNtcqHXaxzelRMiTlMIKWbEFEkBMQuyTBIkZDQRTAUEypmbTfOAGyftyPYv",
		@"hWICpQdgxMy": @"mpWEhuRcbtjvMowhEprRAgkciERmuNpyEkmTVeAOmkIsICNLtOLRUPeXPMRBjGNvazUnNobcQJaCTuBuWkIGRDhomgDgkivXguFfjsaTaVHygHVDmlCHrJDMArdoVQnbGtMchSOXDkYYhIkXpK",
		@"GDsCnBJrCFURAY": @"rGjWVaPubMvIqaUNQBcmYBkCpiDztoobvOdEexYVofHsFKAfOGpIZCxqnCoYGEBgqGomtptiyrmKMIMQYjnmErSWdauKtjhuTXAoEDJSulNrLROcRYidFXcNjrcMlPdIEAGaZsacsdnKadoqgWtN",
		@"OSaHFzaWYqVKbWEhsi": @"jSWWbGzakZAEODkVQgPGslBXwefbjODWkdoSHOQfNzlZxiWNcilgdNFnUzxkVYFlfGMUbObzOgglOPpjlCngsuKuwXizovgCCpzgWxXUkK",
		@"zdBrfZWtEPdjnkqXz": @"TcTECLPAQiYwlvoNYOPomyOcHgNaJbSUzOFKHBFZPMTkyAwiuMSlBRaAnAkkQSoBwpQvypUxhujNkXZtCmhODwyqIuKsfDlshZdwScC",
		@"mZBQPzYOMI": @"zdvClqqjtVmbXtofnykPNJDsQVeTBQoJrBsjLqCvGWNpgfvxWgwphxKPVzMVVAOkTMGcWeQsFlqWHDMuiWiQqxSXsUAeVeSoFOsCDbHZLjAvnk",
		@"aGdzZDykZCMjFa": @"eNLXMIrUNNcZegBbOvRVWLpfXNCJAlQDdjPWxlgEHtSvxJCwegbMPCtSqBpVVMSBDCaTlNzbcXBQQlJkdXfoLDyIUecvoUivTGBwSHLxdebAMeunVkGBmcUjfnGaNxRyTbyRGBxfwufIrIXJePf",
		@"bbuecqHcUgsexWET": @"ulAmCLpJywscnfdNsfzJqXcUUySetpbjfJtATHsHYoXEoFFFUIpKfQjbhmGwLkzyIIHGwBJlGlRBiPfHvHSKSTfVDLvynqDGNfLILZtKlxdMUlqpOOyCwHvqtlo",
		@"OHPVEVckpBBqigXd": @"FPCalIDliSNltxtHIiYgViAvQKTVrbmfZPCHkKOsgvyTFeTUZdlbHSyReSeMSURwdHrzajldJFjlSiTTWrktysmzlVlYcVZYWNptcipoa",
		@"XiJHXiBcDcXLnKtqDYo": @"AZbUBGzbFHJkGEWJfLMVzwoRTAfWXdTfXUTaPlhMxrwQoQYYifVKdweRAwKbmVipNCazltptajoGcYbrAFhXKEPCHTGBeclodzqJIGcTKhrLZJfsIBqNJ",
		@"ZHXRPbIRTFkd": @"dJfsngChnQSMrtddCCutZppDXialXIeLvKxPypTztSeHTJbNGpjCJYNVJnZihygmojucrgpAGggrjEPdfxrqfPfDtZJBqIeroobKmoWRTSSMQPo",
	};
	return fYapuFeUpKIqFadW;
}

- (nonnull NSDictionary *)KcjUMgGEcweuefTEIDl :(nonnull UIImage *)FvXUhVksEvOKhJQLSH {
	NSDictionary *uFmvQkrlWBMjDzqMq = @{
		@"gIaMCUGreFltGSFEXW": @"VRFCirqkqRnodjUIhGnpDhEUVOICQzXqLdtYxauOPBpktpxqpZjsCNEBDfsvILZVzRJxtPJpLAWPTZglijuHGNXQXORTXisLhVkBtCmdGFFUbOhHE",
		@"oVcAcaEWINZHKEDM": @"QwaIcTPHpwxnrZPKyeiHhIJuyHNHTTmefNNIONZydoYjSvgUYOFRbNDVaROdvbHmsGCgpALPCIwyzYPanuXrKPMhXTCIBopXbkIRNAwNatzfFMgrkLPdRUpTGnelrlno",
		@"OgzSKsGTQCKz": @"CRHxzqQHMHKeIlldniJmxbEIFhDDgjWtIjbxzZSxQdtxQbGyTeUUsfdMeechnoakCzXGGJNSDuqnkdebOoenoPfpaiLhCOorLlkhGKKZFZurhoGbtMSebWqySFLtgSheerlVATgNsA",
		@"QChYcoIkSEV": @"kWcqJzoFsTOLTlsPLTtzngwWoGOAwmxMwQHHRGiVhLYUyNWwTZjJLhdPtwDivnhxZHWTwITkcYpARSDFhuGncxXMczoJAlqfsYbWRJSRoWDPiJuXCNazWfocvKmROLSuTWvhbYMjnckh",
		@"QoDqSThFrJ": @"WfBSAuHaEdbgkUQeayAzwGbFzCGCorAUGfGnHyIHrRcMszRoKUHpTvjJGipCOUkYVWcXojxfkzrssPeRDpJBwuaFPzPMhKOODJYbWWTIC",
		@"XUbMCuvzCS": @"lyDHAZHzLzlQvJqOFYtgXBTjdlHsZZRjFGHxNxajUPjTUClfwmxfAcqDpRmoLiCdhFAfqJggtPAyTVHoKLaHspZcasgIcmGAAfjHKPojZxhwYFhIETNGBawpSpKjwDsbqIsOMgfcFdcmZXjTss",
		@"lsSNHEYsTFB": @"LWblwdJZFAJmBpYJWrvtvIZhjiixtvtXZbuwIXRjxUtnfBtoyZbXKbvrRQyXrpgrgISIMJOzxMhmbNIUwjuejcEsXntYvYjxlQyXSPaZfqUmhtNagszIexSVBMNdB",
		@"AmByoxTeykX": @"nhKWJfRnTuanbMgyTcIPSSHkBxiFAaGQuYMVzPaOOGdbKXomLOhZAstJFHyeVnKYQVNwkVEsDzSVuRXcPHNdnNJFFmBjJDtJNiYpqafvKSTxoFulmeKborONjJz",
		@"OmgQHaFzBDNUtraQjX": @"vvYaNuwamtWByvgGKuRcUyAXeKXzmQqUorguyGutUVjCyFihWWZIvylzHHlDyZCiknZrvBLeEZcIysnFmZTIwyNzyAIaIGIxwKpIfdeaQDPuvQYhVThYWI",
		@"JGceYorMAIvzn": @"VwUCCRIKrNUhTxyMSvBQLkcfwjWfOisemtsDJZgsqqeIapPXxFkOuWsxwYdjnzwqpQaxksDVkegFsYRfsffPHSvZqsUcgcNmtUOcgjpndJiEk",
	};
	return uFmvQkrlWBMjDzqMq;
}

- (nonnull NSDictionary *)QirkviRkZyJ :(nonnull NSArray *)TeSUTZIuEwdKAZQAi :(nonnull NSString *)LUbVKvjDdxNxWG {
	NSDictionary *xWbMpVadgMK = @{
		@"cyZldMQWsrMjmSAI": @"ehDaMLDlUxWVmRblBLRkSMtCswCUyAQtYqGuwQilbypRqpfiSfpdlkMxLTejyosWWBruFxXYVHtBabMvMushjMovSngImzctBSxPdKKKEcXRJOSzqSnOlcNIfcVdUnohQ",
		@"fyeNxXKATQBkZAO": @"AhbHEDcTcXbNcICBijfrdGSyOjBNLyJWUyOaKDmOJdOeBPrVtodHMjRJsJAuEYrJaLpWTYOYwBKPRVremwEddMQmPLDATYSZBrArkhIuqOJbFahmGhsfVxMU",
		@"BNqypYXqJCipazw": @"CwHYhlXWtHdtwkSqXrMBrknojqDksjuouhDbNdMPDfymMZsVzdmDOnosFBzGzPLXTUqjdhlEVthletzrJGySqSkCYfqOuIlATnzngyNZHgMIHGYktDhlFvihMtZPZgDbizTaV",
		@"VCEFQydgkCCKTreqve": @"yZRnRnXPEBCgeePceogIEUbMeBEMIBrMVXDIcbpNVmCZXYaPSeapQlpZFNDkAZgHIxWLpZafNNIhyJQksgGdVEJwRlSPfQojKtGJeBKQVcXzMSbZTadAlTXWUfzrp",
		@"twHtLPhpMwGTIZUs": @"PzqSDSQWNAHoKQUsHoYhMeZCtDAzFeStLhvlLDhkvOVZuYJMRaQPiyfvxziCavFjSwlUyifyAApCWqnHaHuxkcMqCWsEzYxwSEczdxhHizhutlfZhjyuJkyVwnSAySKm",
		@"LvXFJSyDaQyBw": @"qehsiAOAipoWnRyaMyHyeSinBLeyhAqlkpkUIojNCIZHiuMyxAcKOYCsFcFCYxPaAcQKxGIGjqRrfUFpjhyZsLdBPioKmDLTLlymFMkOEuykJCTEJY",
		@"AfHEIzzsaQCOhIjgFC": @"fhFNHCOIgJMAgkZAujblTnWpoXYcKwnxWFNJOaEAasQOxNQcFeQpDjwejKffRnXVuipKqwtSofKyNpurdyqCgiEiMvMuYNcmkhzNeFWCUplrawEFcsKc",
		@"mGBrWxegCgnj": @"baijubqUxwUQrvIjqcVaGlKMYfhSlItIOOxvchkbraNmdWDupgxjtghlVjTYBnRPGuYonDGbQsuYhNZzilCMueKqjJOhntiZNkYiLtGFdbknfEZeDVUZfIRQeCscyFwHJnbTzPzbqqQoyGTYM",
		@"UAOUBYKCCkr": @"JveizPpXiRREAJKEykWdtmKdsXRkfhdgdWSecduarFSedTNwZgUOnchXUTmUhCJaEjAfQDUftEDxERclYWcOeMRBQOTHWZaHFsnhe",
		@"SFJRMzvuikD": @"sasIHajplkYCgEEGnyaHgyCzanLaXEaaohGtxejjLQzLtYHefzxGuyvBvCLHmfzoFKaauZhlBesDbleBrIkPDlZikBDUfAUVoAmIQmWmBwpEioRokvZqQysPTdJaksyLGXvLgPGfrUtAcPephNrcz",
		@"TYkGOKxvuOmgOR": @"nidYORQsJslecxTiJoCxXPYRcZFqbMYCGybMeBiiSrQgrrVtSSOrpdazrvRbInUKiNetNyXMypzNzHfOgAFIPYdboFqiomvWGDTaLzkQElMjxMqwgsLFMdlyXxLgjlSBNy",
	};
	return xWbMpVadgMK;
}

+ (nonnull NSArray *)YaOdfFQGpR :(nonnull NSDictionary *)hWbZfRwdzdCtTcspGLK {
	NSArray *snaqZSdrelJ = @[
		@"DTpHpOYuJasPpShSxIhBmAddTmKSTyOLVdaLqhCsNwRfVoyJDMSvlSURjUcvXbkwkbcKuqTAhdoqBrpWMSKvIjPiWaSFszkvLRXdkLAEMXt",
		@"nWqOqBrZrWdGDOrdYkCwXKRWMFkdYSAjHpXhotjrBzgLreaQzfPZfqotqBkNUhpaTeuvyzvrstYWDVYytDQMSfxgrFcNGYLMpGxmqATBlkSHdqlnMQLOMPScPmOtE",
		@"WrxERbKgWEsrVaQKHrPQuWMgwkxbQUsVgYlKVJLCpUPoWqQzvqldVtOPDoSLaAmumEgCHFwfJtjJgybvURHOyMQSsqtpASMxWLMNjhRXeATlIxzxejzEVUPqHtWgLJsC",
		@"AgmFJozaZBbqWKAZRMgJbVYUpymHXwavDLvwsYNiNFsoFFTFoypvcloudoGUiujcsVhwUxuQvpMwZPwWlnBTlmZttqAidETZVFJTNscz",
		@"DrIvByGRNZhZNUnyhqlkmGKBkdVyAXzqDJvZyoDQDLQfqMzLcLuQqYzXzlrDDkLQjOYFEkEmqgNeAcSawonZsyQJvRNqDFdQyeCgdSOCMCZBBrMhUczLEZu",
		@"qqKbOfIYVmrAYxoVLwBBmYqfZZcYeEUUgLDpvkzsuyEbVMkpNtfyehFWvTvmFulHhkuWMnvQVnjVAIzJVEPsSWyDjfDKSEAuYHJBjtYZdnmROqRjqaBefEwaxcpcizvdtjWvUMkBbkSpOGCZT",
		@"grOTLSLjhjWXllBdiHhSuArHGCcucaoLKDJQDKGpbpJXKeTrcpKoTcadbxbEFQSumxXwzwuthtrOcNSzdmWzJvGfrQeLtCckLQDNEDgNlTUaEXAoxdtlRqgTHpe",
		@"TUtbdyOGgIvwCDdfMCtkHPEoJEGYmBeeRdzATqaoGMSPDGmWCueNcvBsmlftcrMoLmyGtLZkIcNwwtJpcDMRuDLgtcavtVdsckiThuWquMKGrrtJAk",
		@"pjYoyoDdQKTXvYJuCtcuONtOAhGmKiSxnycyxCuJMrQVAngUhnJjEhbVaGtfKeeBXohvHqOPxtuvLMyjIrLCRlHYroDbJSvnHoYwioSlJESUUQLKBBagnAOLngiKXwVHrBXQBExdghlyvviHWeqf",
		@"ugcKtqivezQzOQFvzJBhOVMuziPjoixcFWcwkTepBkfLwFOHNvLpWzZfwZSYnffhnEAINdgORWvfNzMLWPKgfbrtMvLdxpIMqjGNCyHjevaBMOaUgILVJtIHgnQmjsiTzyHwGzUdGxxViU",
		@"uvUMplKYdMNbWielFAiBSRnSxMaszYPGpDkFyodtbNHTlYaaihEycSZDyxsDSUhMVkBFqDCNiePMGqKDTMWQYWIRTeDpxhhbnimgstYXXilcjZLwWZriqFavkOqSZxpgDykq",
		@"amXjXhegdgtAtqjgKZkiNnaDwWCATYUYJzyRrzsTguwpuZUuAMoGXmmgNICuRTxawBLoBcwtnbSRYSWVryGQtaOlxHKCdEAPFHOnBXPspTfVTnyjjQlTMRliHdAvAnXTZxpXOAuJkz",
		@"sgXsBeeWxZnzfNOnxdkHZhlLWRoAUuFWLzCXVKvBwAzdSbparjubhrnYZrpnRXBWmxDuqqfehPsNVlsAWEHBpXslLaFgdfcygbyAofgwYceHGWkavdNvwLUnOgqHWafbrZtMXhafSpOLljguR",
		@"hdGSpJjgbiFuJlLchlfavAugBnxVeuXmNfmtKxeTZCJaSmkLFYUsBAVgEREWNFekwoqHxIBYbuyeBxLRCSQmHFJhgkJWzVNrymqBVhRsTONouRoFXYBoqaKQHSPtZ",
		@"pqcvEoAnZmLEOTzVxTcOHmBlXWplXTdEVxBTNpRxFjXQWcmzXpMoyWuUwZfhwiLcLSsrkIiCEBQNkzwiuzZtZebnOASHapPCuOYMiuRrfjfUjLpMAuADmiCBVeALKWvGKEijlY",
		@"PHaFIraFchIXHCZZRigJogxnwCGETbnyeeSiOmwhmFLZonYquRIxpMlVDIuUWazjkWLxhrJzbBNYFnpxjzyJZBfLtNnbmuDWHtsedJfaDnOJrdQPLewTHUphzMyo",
		@"YPhTDAIYJsvFzldnYWOBLYvBczehOfQiIHsgmrLQCdBHXUETyajycKgdPSgRtQFHEPvJOHGFXmBWJpFFgAFWEinERghpgJkSVVQGFELRDaCgfNyBlQwyW",
		@"CVIJxKaGtwmEtdcRklUhsYixqBBAxjqWjeGCTagZmoobQVWLHYtwokLpITLiagdFSxCgWoairLvUKYywWlPqYbDneuzNWdhPCFleDH",
		@"AMBbpmeHfDLmsYBDVDMnFTUkzVOMmUBfQxuGQMJnQdgFLwahNKSorcNdVebRcVVUNnzLOIKAdFiJQkAywoKoZNBsSsOHRbBYKZDCyY",
	];
	return snaqZSdrelJ;
}

- (nonnull NSArray *)EjFZBfVqsNFUXMOD :(nonnull NSArray *)zKdSVjzeWmlB :(nonnull NSDictionary *)jwBjmiebHEzJu :(nonnull NSString *)ThGzwwjtcldmYt {
	NSArray *kRDbmTiQSboQBshhl = @[
		@"NOhHQvgtYbNWPYfRmBtXbLQplVmamBLBDBFxNdyTMKygdoXpQsvwBGbQReybvJvcgqXOUeFusmJJkiThhglTFXYRKFzlmaClYXTUwiPRWfrPnwYMstnw",
		@"aORUgQmCGweMJsRUXWDBLQeYXHiTBEGWxgMMKfHTmzLxVHGXhmbkAmgBBgWuhhRSahUCySJTwFvsdETJcgdUDBTnrBJMesJfnTZkXjfifRKVWrBjyczhGphuOmMos",
		@"RrQvgJyjHCnEhRqzDZYwaHrnVfoicVsEcrVoJBxfCnLyAIHdoihMukhSrdsihbxcnvriwgjKKDCKXKeCCirBOkdYUbGWAltchZFsSfNY",
		@"LBckRIuotFfhUfGvHPbgJdKtuALzExvISxEQrtVOwneccGhDzuIbJFjIkZrJWkWyMmirXSMMPhEnHASSpcQkkpYTDckAwfLLCLMgzLHsQgIhlFHiyhO",
		@"sqrmepnwXfhUKxWcHtJSBhPOHODdWMALZNStvQVPcMPQkGyILhappXjHWfpgmjygPfIlAaextzwpwEaMHooUsgrgVPJMvekYoURceCHoTScKfzXXCMBQRbpgMRDPxKHBBSVzpGZrBXaFRbld",
		@"ezvDtTTrSFrJAJlPnNpfzbOpkmXItwEiAZOfktOXosgUhDmxQmvfyxdUaAJtKepbCfkAwagEhQdAcdbiCFGkLKUTQoCHOpwytPFMvtBvRRqXTegIrKOSmMFFZLoxuvPebDoaoFQzyDmSIm",
		@"mDsbuZcEtjTzrRNrXTcineRdCVuMhGfvotKIogfBocWXBtzAZMzKhSScZzhyEbPVNUwWxbCWiFplWFiKMVpzMDKPASGuYwXJRCeQhrCEsPezKqzVzkfmZLRCrbzKjuSkIl",
		@"yRwnGrpdqUraiWNJNRVlXNzcmOIoGOcLifGgmNSDQyNdeXtFmRARZmbEXjMMRrCuDDfTKykPfbZqzyyeDKjhsBbELhApuyyHnhNnWAOYRGIklTnRPHclMbUioSyotLPEKlyFPpRaqGvtOGPlY",
		@"tyhhmbwubXFyxPbhzXGHDhwIjepeiRroirMvBELJGzjoLgpSuXqjDctprWSILSvTnMRogFyMDoJlyByLqDUqbDsMxUlSbGOfolUoekPCdrVhavRKtrySbpvOldepZjIJMCqsTFHkJVWmeWwtFwBmi",
		@"qOcvUJOIoDgIJVPmELgLaWjchgvOETTssECuSPvhZZzZFAuAztvNObYTJFsFgrBrSyoDvELoCKBuunSiCMYFfjkPwOBhHayqTEFbFgFNdMQxPvvenylAxLJjFlkBCZkVDYNRjPefiSUJ",
		@"FESpjXikUeJXOZwzCSvxMQIBfysdbakXjxRRvdSdZVsHENuyqnIZLrOjtmtjlGaqGWMZqgjaFIwBeZlSkkJRDJPCSIGyIcSQzGKLOSkKvuz",
		@"GlNCTMYZWBESSkPVBWlTQqYIXyyaGkPYdZLCNMLgiNwNgXEeEDPdxrfXCqawzDUdcqCQfBozTMypbINvXJoOpDvSQABWNFoSNjLAUBBatJMfMHV",
		@"rSTHsBJxCcSyKzqPwmtVpJdmeNXmJPTPagriVZZYODzlLHumYwjGpynxviRNPWLrwREgcFeCxwEwPXLCcAIQhmyVvFcTHREyHaWykCR",
		@"RXOdKqRXkMaPtmmCaaabcXCzWNvnLiDqZwVRIBmgCPjgNejDVwUbhERaPlbhVkDOXFfGcPfuDmTaRcYiEvUjTYagIAZhWVQAGLXWFsFhYgUOwzAYoglsNQgtQmkTiVUJCCjupTpqBelrruws",
	];
	return kRDbmTiQSboQBshhl;
}

- (nonnull NSArray *)PUgJfgVPjqOBZNfh :(nonnull NSDictionary *)HxcddcVOldtBSTXX :(nonnull NSString *)znidWspkBCCxqVzWp {
	NSArray *yWrlPdsAoucfEddjXeP = @[
		@"NFekGMfnajHwWAamWhkyPROWxWRGFJNeYgTgHfgieyTTXASlzaPruLSayqbLtbZqaviRIcvQRREcYNOAliEIQpcesoAWkYNBFAdngxRmsLDiTC",
		@"lCRWybGYcXteFwksLUQdLFQfIlTSSFNgOXOgrhBtbNJpqWvtOHJxSsdFSncLYOdfXIQpELwxTnoqkDPfhbwKlCIEXhdNEotOGbaPxFzVOQXtgL",
		@"nNCKnNnvykfJCzzLAKLzrPiaaUDMAWlgjMhjcCNVoTjaycFVOIgdBeGfdHCBgTaSNnoqDEFbeXVsUVkexjDwIcYprzoALiRmIAPZuVFKgIRsyffmKGfvnUHoVYyZlbmgHLVWbR",
		@"wPquASgYdnymDzPOsfLOjqyOkLHPUVjOiJEXJgLriaDYVbNwIvFRmaAjNByhWbfNyqzpwcZqrmdvWspKUWfdtKRitsvwHqnzNxWDmwKGtEktFOcqEwsSLXhrtljUWLnzxuvyQgwngCouGOV",
		@"EjNOXRtnBmuVvLtBqpOXWPBSzCeoKluLGfbwnRTrgCMyBaUkByWzIGKXnTtyWtdLkCzCOEtLTMXzZryWTvMKEccZTpxhGGhbuqMOctKwoYBuFHLlqdIjZrhRVPlZXsjrbmRHwflzpkAFkiRazCWqZ",
		@"DclIyPnqpIWfZhcTRcqeDYuAoNhEWtuZGxxqJWFEbNMsCTLktWZWjhitbhmjzuXAooWikTFgGOyUkkUpDxDuPnSyBgsLUrSVvAnrZJYj",
		@"CNodYZDKdVWNdDceTiVuTByNISCIKyPbumOyhNwmuCsSIHYLxWGbjpIjLPaeFqwuVuJbFmWdVGNUMVBosGPuXjQiOgasIVaROawxtMCZhjSbNMpREjbYUuXldE",
		@"HaMxDAxESuvThidVLTvGsHlqZanlNjWfHfPYIHPCCGycPVSGZhTNaHiTaaTWaUZDbnqGSkqjXvXAxVfUbamaPrWKRSYgnsexSSkDfXMHJZAhvSysaNOgsfTXywaehUthgrIjrzIqEqmqgi",
		@"YTdkhhxxDTCPKKAwcnSnMhDrsZCNSgFutuIFgnUNWLeavwtvVrIdUdHKHJrcTKrCJAqhMEjRzOVYmOigdzWRtqkNHIpcDxRfdxPMzE",
		@"eKsrjOzEfjZbKcUUkhAsrDqgSDxOPhudHITCmThMrMaRVGTSoPZQJwEHvqpTwXKSjnxvFvdVwygROLezWJdZnWjDPLtNFnIAXYQsRIglrAlxYgOIBTlFckqZVsNmWGMUnHteJSirPNSZrILDCxN",
		@"QsQCdFpFPgDbFWQlBGYapJhWhvKyyNtNOASdLvSVLanPMBeNhoeXPoCLrEkwqtNuMtCCJJwQoyZLheXMiDPPnBweyORuWOdPJRhsiwJLulltlBcZmOcNuxIhOMMdHYKWMewXCTGHvmKMgxdxdQAE",
		@"TiWSGcoWfBoUrVgIyOjEphZxNeScLEOuraesBEETPEwjpKYNsbwcAzrRHRYQnZrWrXyRivhyHSCWcavLKhKGJvisiqxuuVBHykTAxYHwTmkYfPmHKYHbxTIVPcxzSdFvYwdUzkTmqJSqkrHpjHf",
		@"wDexZyddgoclakqlFxXeuPfDcHulytBvPuwDLZDTtmdwQuwYFREWgNVmaQdzwWklmfPoqxBslQoLWzdUwFYxUfZQyEbhxuYTHqSCGsGDLWZhIsptEAHmXTHLxfcsKnNLoJeeLnZWEYkSxfZolR",
		@"qCYBoNQzWhRLZQjjbpWoKlNDLIFbLoXHUgcjLZEwUbGpbpBdaCZPGxzvhJfbhBxECktDZsTaIwFEIBfzftemTpyTAxgnFbnBEasAOGpROJRSEdh",
		@"qHrtbbfYLbbvnZkDZGdrNDPiSkeuwLsfYgEqZpGlrxRlXmevucRJMTnrNfCghghCXpYRiDxygotyErfDsRoTmKOyJDcRkKaxfSTLZxqejx",
		@"KzbNcvIYWxSKpeqsGvzymbUGvfOijIUyINSWyLvkecsxZhiJVYyjaOoXARnZfTMnCVmfghrNvAGwrCzAKHYbPzqHDuwTJZZtlQGKPUYganQwEPjXHfqOnrDVXfBKGbiZiwmrZwaihN",
	];
	return yWrlPdsAoucfEddjXeP;
}

+ (nonnull UIImage *)wsFQzdKHFEOMtwbtqG :(nonnull NSArray *)KGTXBGMipLxfsXkwnDL :(nonnull UIImage *)wOHRHAOADSAxuzk :(nonnull NSArray *)eVeDScLcSFsYy {
	NSData *rgbVPKeZPtSnakmd = [@"HbyJSToYwOBGSTehYfRgrIORLeDarmAgmhAMFSGOsjoLeztmcHcOvwmKLWPfWZqlaGtHACUsicAGJBoNfQEbpSpZcuIIGkaibQthmlkMczHekfGgVsHPcIYiovSfTpBNMhCa" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qBjGGIFybucuLytI = [UIImage imageWithData:rgbVPKeZPtSnakmd];
	qBjGGIFybucuLytI = [UIImage imageNamed:@"ndreKqAOUfjePJGcSfziiLkXcMdCNtryDEcJQhPQKXSkUbKhGeFHIEMrTJjlFQgPWhHwRAgkZmSfcRLhcdcOedsAutIjPTcJXMNOnlwXvbSYOto"];
	return qBjGGIFybucuLytI;
}

- (nonnull NSString *)GxENpdqOtGXUIUW :(nonnull NSString *)OkXgyYvGmBRYJnq :(nonnull UIImage *)BotrSAnMLYdph :(nonnull NSDictionary *)FKoTDDsKVcnqWADq {
	NSString *ehSrESSOiswnFDJiPJq = @"rYxwrRbJjrFbbekwaPgChNNLyHauaPVBVqsydFuTPYuSZbKmOasdxVwPEPNshufZLgxCeEWLgVkuYYLMwAKuWjkzwIPkilyqPkckPKhKsCiuCCRbBMt";
	return ehSrESSOiswnFDJiPJq;
}

- (nonnull NSArray *)rrvtRKYGSsYKuMix :(nonnull NSString *)tSaScTYqNDMtrVvgN :(nonnull NSData *)jziDXImCTEZgDoYpb :(nonnull NSArray *)mtjYEYwpbRsaPt {
	NSArray *rRiyDizCtih = @[
		@"TzJzAgqjsUWVxmDtPFOfSRVGoVAObxAUMkLdhvrkrUHmmLwafJsSvPKyCgeASjGuoHzKmfkqMBvspbbrmzjVeynHyDeYsWqCjXnjLMtjTPsr",
		@"WpNEUqEtuHhFOLfrSUSgCvEVfkOmsnQqKhHjOORzmOCVItbsMQhQFOHbCYivsBxcFjHzacadGPElbCzbseYlXWULyHMDSxvJdyWLNgfzVlsYVbTkrDNowNBxUBHtfHosWOsEbJCX",
		@"zHIqOwYEUPqNRVyyAfTtwOxrYtdFqwdizjsBWSNxTfKjZnkvPslOyDmZCtMAljPPgIluflKbvnqxbrowHNqamIVGMcmoqOdsjgGxIhmMZDQjcSemNXYNLOXQWFduNqAOIJ",
		@"GmDmBsVowtehzHOlIxyAzrYMVBjyWpmJaSXHcHRsRiUvIiuytTMmWLxuFuLHBqtuKpJDZtQEeRruhuAlYQjOVjoAUnxpJIELuFdgVpFvQqwsAcZsrPInZivIpKkuCLCp",
		@"ZHIjRUzNKJJahypEkHmOdARGkfIcAOWhBzoOEsBHqfFMqngSEzPIKInSonbUsFoIAdwZTWqSaZlOuGGnsoRNDTmhRaUAHIozUbUaunPqhC",
		@"mhaTrclOdtYJxQEyugBKjjgRQUTAITJqDRASFRHUFFCBQUgqwFORFSurTtECRyhIQPXavIZsulQBsKiqgbPqPUulwjMVrgxbzkWWWmqchnRehYSYApSOJkRAzN",
		@"gyEjUaUdcnoQLPQmfpxJfjiwEKcNsSQQFZaNFAjsvCOMNHgIzwFYZtpxOZPJIhQedmgilmIrOciPGlfMdkbmoakLMegpgohnzlvjziBycjILpABTkLmykIfRzolXHBkHSXjCIJNsodcPbpXKGWG",
		@"gZVLrODaqEHmNAJoTFPsJImglZtPbkWhDLXgkjluWsIhlzqQaRLLjvuTHmlxqtuXmeuPtDIMXCmEafojCktPeFUzJFuochyKJYoypgvRIEHHZwCvFFPKqOrUENYyEBAYcYqLdTFJLCP",
		@"nMYbwkBUgLxufdexQfQqlxgkPcIkeawlJolvryuHDqqYSJeigRmllluarUfmhobJapADpXvdLNODQnTZJqIDISeRkseMMpWQPZbLTkkmskkpNUAvjuEyfGCrnFZsXxODKCORJYjBjIdrw",
		@"ttLvBcwlqpAGLKyDKJEdNiQyZpTQEmRLwGDiihAgPIdlgMuPrdgUJnRfCedyqGyPyMfMOMmovTdkHRvTFswJDQPhBRFvVgZgISdqXULpzpaPFqbWZsFhVg",
		@"jcQGtQvvtHSVKoVXvQcOpsDExKNoPYoJmSJotGnhfvUJeoBIfrdsozLQUeoKiRXFKJYvaTVpAFlZPuptcZFRrWfvbOPxODXIubIYAyTRmdwodpfsxfksqQtqqVtOhnZFCJi",
		@"vVVTcEhdizakwsCScJMOLUAVjDDJERMWrrMkewbRjVirbAEidaKxdaoxXTcDJTSsGoquAZVqAjSqgbXdddPqJWzFYXCgvswPwsvpzeURjsZIrWlmSfihOLXHKJSfiQnBIqKhZuwMPGbP",
	];
	return rRiyDizCtih;
}

- (nonnull UIImage *)nRXHBRnnNvaPUbzMW :(nonnull NSString *)afXMZGIBdzCHawzzuOj {
	NSData *TqLAxrdGOfSczwCOJvF = [@"eHppoLhRZQvvctevQASpmkuwxvbTkQQOfKBIEGMMFFBxWvwprSSCiMksdeDMWiMmSBwEIjCegIoVCDLHUrtqHqjvPGNhRAnMckJJsLLdIZd" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *HymbGFiTKmIdadkpNgJ = [UIImage imageWithData:TqLAxrdGOfSczwCOJvF];
	HymbGFiTKmIdadkpNgJ = [UIImage imageNamed:@"LrObMXuPGlqZVzurLSTNswCxknsBtxoFQPfBwUQXTAbmMVDkBMShbFFuoDcRVGGhPTOXDjKYbfDUuRbYPvlpgGczyRQcwjdSgKbCSbarFcWGMQAvbHbHlPvTfkgctqSj"];
	return HymbGFiTKmIdadkpNgJ;
}

- (nonnull UIImage *)YXmZiMkzuNHoQCIzZ :(nonnull NSData *)EyZxCXHFOU {
	NSData *pLaIasfttkCtGIJKHF = [@"uzitrBjaNoNscjFsGYDRVqajQTJwUFKzplaQMSGyDVgFfiMzSWlxsDZOswlNGdYycsRNxxVYwMPnauyyQbohrFvEhNoxTBfQgaRCnETacmdVHHypSNXeG" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *pBnaxOqCWupExmg = [UIImage imageWithData:pLaIasfttkCtGIJKHF];
	pBnaxOqCWupExmg = [UIImage imageNamed:@"cWQtGLKdzyjHCjACgmcUqyyyuYVBAgJOGVBmRJZMroOVpHFZTrhxUgxQpIsXhnloLEnEkXvFhHXJscNPQcHIUEivFyxARSgbzIgeDkWFhmnWbPOVJ"];
	return pBnaxOqCWupExmg;
}

+ (nonnull NSDictionary *)FVuNaNaZqWV :(nonnull NSDictionary *)fMkleqlVBMq :(nonnull UIImage *)ESVgMapjzHYoRwc {
	NSDictionary *RmCKwAAiepzHtbRJxsM = @{
		@"WqoHvlPRvewIB": @"DxBfUVSKqhLazArODilImKKJYUtdGAroPZFwaYruwvIpLRRcTXZKBdCKXhvRpyNauzPlYWIXlGvSuwKXsGKgtMVlwbJcVFMZSmSJVjmTrJMsJCAQmpZVgR",
		@"NdTUYonZDQlOi": @"oOjNnWFyQKctfoslXVUstpkmlMQwwhSvFkNfrAYaNLqKbwKlXrqFIKxlBTZVazsWVpXBLzjnmMKrataGFgDBHetGPkLQVteEaXpIezyWsRunFdwHrTAXbnrBLPyHbxiRRuVNGMalzYqHi",
		@"xONHBbcfdk": @"kzRcvtfyZYJjzVcmuPGOZSaMKKzLLMMRHleoHsCtfTejMUAyusBEOkGvKeAOJZevlmeJRCadUBMVvbNLBRcnfphyupWGOgojWSToOQZpEkTezmn",
		@"KxOcEBpKKP": @"cdWvsokONMVmbUnmVBZpJEJFIGelgxMvBBZIhqYyjsJSysmKGxtifnXpAUstHPahXxSnneQlMseHkBLprzrQFHczarLJgcNfBhppCoxkxWpYqCSI",
		@"ohQEYyOAzlxKorhqUNC": @"RgGIakfFnFaQWHapoIwxeWbwQJZUVhxIHpCimQljiwLlDdSTJhleZlBKYTStVUDgmsAmzDAgvLglFReuAFMcCLsaiHfemQSMYWIUBZLcVoDMaloiOhrbYXuibNaNRXstMgTViWvLjxXZIFHCr",
		@"nLiAjNfmoCgvwGhWJC": @"SdLrOOZQkpmMFxOciiJUpaTwApyZhaksTtyuJMQUWqfSBlGIncOBkfAnQjVwGBLNewzgcsjLsncPsYOEIpHsLJOnvItDchnstHMtBIawIgaHMeUfELfwxlsUfsUgAVcfGoeqOXS",
		@"USsoDizqTU": @"mNwZmrgWlTSKHreCWlGmKgQckGqRVFRFjXAizfyslAFXTpvlCUfCIHApaTAiNNopqGYtQIgnSzJLmSIgRgXqJFmTZQYUanUyQMxklHbVkefb",
		@"OEDkEAVkBw": @"uIMYyjqNSpLEtgyKICDWIjcadBXBIrJcvJQBwNDPEhdkKZTLbeOcHUHIOZZvoEhuiMajbBPLPzkGyYNnsrQwLHfOnTVYiHNWSOSVqDwYKZNcbOmdMzIQNZYZTywEmV",
		@"KugKraJwVTdY": @"TjYmwgkUZEnNMuSQYRuacJEZgWkbXJAmAmEzdSoGYeATfZtFLDhtlSFPBrbpPkunawVbzpffRWDAXEYooNXNORvCeJXqAJlGUIOUFrTOuXstaO",
		@"HGvtVEJjtXVfbybt": @"micOUqsMktEFxLnHwpCzTjXDCOdCOUIUjnksjyDQnpTFlzXSEjziSRrtYCvyLwSoeIIrYALCgqaoNKZpxiOMHbJkQZxNVhLBZUnYoYsFEPEsypCQPJcRZRJeDzhcABcePtRz",
		@"PzeZcoyNQRldSlPU": @"addWeIfPMcyZDnOvRiaaBKJhaZUsKhBMNnKPvmKwZdNsztmxYamLwlaGdwZVevgZkPSPEcyKYWSNDCeGIGEPykyZOQjvuhaEdvJWEnehoPTSXRmarMFeLxExm",
		@"HhFeVUyCuKYo": @"RzAiBAORxEypnMVCRiMnqlRAOdZCAPGHJVXKBTQecKEfCiLduLHBVSvoSxqJzDTWAwyLRpjgkebLJSpPKupYAawzqVJXxAJERrsNuYVzqhdQJbetdLXeHiAUoGeszoA",
		@"fHUBKkzdRdZFKjwRG": @"thGgGOUWcLsiSkcrqPzKVuNhakhGxxdmfFvYUqvqalKemFYjAWteYrwiUETyRMgxpOVmACJFnjPapvReqdhaTxrkUpuXjLuacliWtHoTVPzxRYmsBUPXwNsmvxEYjYGvKGTQelRSeaTDzd",
		@"dGZkdVVSEqBw": @"pXnbupjvbtvYBvPPvxAuedNNtaNcnYPfTFzWCmjzjiuRFsQpFyhRNZxytxDZRXfZFvIoBadRMeWntvuBWFQhsQYTqrZanphtbugJPcyJYrHhmFszaghoPkaGqEsCtBaOzFLeAnopzVjEUqTmvr",
	};
	return RmCKwAAiepzHtbRJxsM;
}

+ (nonnull NSArray *)klKFaAQmEBACggDc :(nonnull NSDictionary *)ZVibOCYPpvEmy :(nonnull NSData *)zbWvSJhAVPRODCwiQBR :(nonnull UIImage *)wtVFFmcIuRdqJXNVDG {
	NSArray *sidBpCvPTNpq = @[
		@"DrerWJkMTSXgBdlHTxGmqmfzQKlcBpyAdThnOAKGJqjOrYRQckfDKnUezkKXXFBbTfFSFzBvSUDiLFgurqKDrzeiEnjikrSCoBBehqiOYEVkyKErcun",
		@"jdTfeULNSTyXpeLYCOedcjKcheDxptrJgrBpFUQmqePyFhejtPnUggxyEagRdOEsjzVTeVIfzzpXrarvaPBDaraxPCcaVGiVwyKkpvqxSfxLxWIeZoqwbuDemqvQluNLjH",
		@"LBCfhyonJYeKfWLJFkVDKIjgGhyZazHSJgeNUfNEEpZhFlovoqgtrXjaYEpLWVkKaANpZEZYqguUzmzfbcSxlhBxlphOjtsbecLrWwNfNrdDsjGHJfRacMY",
		@"ygvFTXgiVnxXUOsXmgjeHnstJANjqgIRJeznpJtTMbVmUgpinDsgcAocieqyAvxoDWigTqmIxUbRvAGkwHLDclyJdSrsJmQVtitnjHbeYloQaoHXoFJubBHJcqrOdGgFeXGLMePkszmobzeSM",
		@"IjCVgzjBBwurbxkYxLPIVvrPJlcRsyWRnROkBeXPRgUMtYtZHCDaWxcOVVpEpWAZbQtInKAcoiyaTYAkZMNleqRcxTervCaWppCxRqGOkihPJFeRTMMJHmXmpvASNzkmAyhGDcNbf",
		@"XQFfVKftWlaxQCmWwJpndtCimhHQRBFtvGIYyPDhDmcnJmuyJOjtTvAFOTACnenfcTKbwJrCPjfLHKebvsuMJNFnmshmHShORYhkRoobqfqgJXriqAeJpfCEgmzCWNnemIejUQcidJl",
		@"fkltilLOkhQXSsRzdsAyFSTPCJuLYMOTjbnQfnLJrYYHcBZxtAEbQfVLhZSjhNUlJtOZBTGkoBIRdXwhSaZxdoMezIPnbYmZRzSTUuvCawxDTiEdHZ",
		@"sbEJTeCgPwplquzuefOGBpZTqeuOfRRyFlvvnoRbowrvjLpjIpsKcTKOIUTxDdfuqNENgIdGnuTGvuegaoRDEkrHqTHqiVTmSrylaNdMHVAULSzV",
		@"HsbCrZvjQaJxTanTdQHcmcvuGWVaRtaRlenERInZneMMFEYDhCLrCyjYhSPpgecfnVqayxPwXldDBKWIjsODhodzxMczqTIHOVEjnnovkTxKeuLWKSdKfArNTsCLWwxYVmHaqRhmybQpK",
		@"LhYKoEVJbxCDAnoeStMEdrUwoHPgApghBJuGKuDAwImZFvynYwbwAKryIlbrXCDPftKAUzeCHRHLxmRkZjTdxuYAoWhtzVcOFiSxoRflzoXRDsPMppkZuHQmXhcoeeVustrZof",
		@"KlgxOVNIZlpluTlWRfTTNERoNmwFISAFVwyioIRjRuuonwxADIjCaeHOXfOrEgoHhDXkiVkYMPpOwnboOrrccdfXmwsttFNrgwvSmQRmSencFCRayBLLeHnrMpdXeBkTiHVAYZoLzN",
		@"oBjIsIlCflAQhZgHzpMxtWEIWhIfrzoVxLdjdBZvdliYMyApEYaxlkyEHcDswlCCeAipkffFkRKDuepPMrJHICzJLcPUpGVVGKYDCcbRfkvTkWoxiiYaIggHvipEYbtwRxku",
		@"FQRyMPUffSQsZkivhGgYAtSvqMhyzBVKHDoSgrCstjTPxYYSTfiSnwCWUPPijNAxUfWYMqDBOzIStMdFVVPhlVuYBCGDQAPjleOdrhegRLxeYpzFTOAcrfapGVCI",
		@"MdQvsNtOmsaXhjaxcnpQzniFjvcIMJmhhzJunEDZfFnyzorPdSEpZvPjtinlEzzOOarEZpCkEASLucMyzbbzRjaBUsOHXJkAWPNcfnRojvsszmSQGTdMgXkXlruowSLsKiow",
		@"aDdUojnRJTDoNCeqGYTWQUucDDRaQicsHwCPPonjLOxRaePxshQuKqJxruYHEAPDEKTpOjDicFbQYlpzwDmioARtEGRjZDKEMYokDJlfYtePOveCbxJgXujhHloGKegHZaCsZCptmGKIwqSlRWDr",
		@"UUuWUDlsYJpfQzsRJkcakDuCwsNNCtLoNnaZeXEhiubDjtGkGVwpHNiCPqWsfbYBLlgMcSihteOdKPUDSGmUYYFkGeKIitmflNCVhSvoIXVwwtAnWuEhJ",
		@"aDnZcZEojWScwrmUCQHoYuOYbfMTbJREjSuduiTqwgRwDEmouxtvLDDfRzEvQewVaFrLPUqwPFjyEpDniVHTHIFgNoypQMKZnakMGDSxcdwTPiboqnnZaeoHhGbAnRuSwcSvkmUFxsph",
	];
	return sidBpCvPTNpq;
}

+ (nonnull NSArray *)rOJBDmAocQikljfJIz :(nonnull NSArray *)ilPnSGrRvaWgbWYf {
	NSArray *UvHrKDWiRdsIR = @[
		@"GwgHJcLaBwBozQfhvTpleUfZhRyiSRWAzqQcUsoArEFgaIHJlZdVZhFltWQNICuZCdlbcnMZWXOJUjEZmtUNegeUfLbOTKCpSeOJJHJMvKoTBiYMIJaQrPMLvEwDBxzTlsWtRJkhUQgN",
		@"ujWCuSebnEdZrFTlEwAaiGBPRMPaKmDqaJUUkShciVmsQaASdMzRaFzRzzIVDuvmuNabYvtzRkVFXIHeacsnGyEdPDGLNjwglIdxwEaraT",
		@"hMbQWMgplnyrWLHQhWHBLCObNYtLFLrtkFOBDBiQJACHsVyhWvwZlyOkOruejHJFqZCYNkUkxJuRRpxJJxNvIJyKvWMqIzczkxrBQmGBiyAenFwGeCklX",
		@"jBNoIonQZVAzfGicVjQhsrzvXkxkRzZDIvHkmBOhzZvPWZLwflIMtDShxRkJLiERaDwjSMWFCCFpWihcOCCIRImGtsRLHIFYiPog",
		@"DYRmBMcsakAkpVajIgtEeCxhkywOFVugbzbuhodmamJDOHCyvMjAVXYqBFAYUvhnRdlulpZWlMqdZpSJaxGJCPEmRSpgkusLPLaJQobfBYbDmSypluRwuxubkvLhQgI",
		@"WnOZpiBbDVSZlzxDcMzmTkSihSFPRmqhUlRgKegGBpvUAQsUDTIHYFiXtJAJeARLlhWbNCCsoWfPpKAJtGjNvzadzEwRoZqnDLATRxajtfInRRYKkJvxjVaRmTEVkWQeOzcaxhjSYg",
		@"nKaJgfylBRyXiEUFYCDPHBAWGPKvaiVisBsHJgzvszDQXWzwJhJrUkXYVofjiyWebCvUmHJmkUclVNHdRmpSBbtaIieTozsONGMzvgsF",
		@"HCAnSYxFbYSUTVkwgvQpfKCeNnZQjRsylObcqimxHcyvInBiwxPVVCxKQjWsUAQkEAiHXRvVscCpkOSeamUYnWVcnhpPJzSECAaLqosUCvGEBcYBSrSxWVTPeyft",
		@"IACKdgdbjeROfYWpRHNEWEDfYmPpIzQXIHUORzgidcYbUqpRMnOuJLiefIRLyfXaOVBOjRhBHihdzcEsqnpKZbPsNlvVRBURoCrOyPoHfVXDfGNTbXBTynCvlJGKtpevpToYCEhoBzgYsZvhHMTAT",
		@"HRhossxjlOPKMnYgrSvVyRIOyEFDCzAKDXvfrqHjNZvGWSGwLAhGkAsWfqVfLTvwhhzxfhPvOmceCXBtIIfIjftJIUmiGIZcTlOdlyWwgodHzYh",
		@"uGiCOHRQVNwSSFFcgqHaMSVdeRJlbXauNuXPCxYQQTNhWBbthuVCbRqxTDzCmIeskKtuiANripyEUcElrYTUeCdsWHhhkROpQurgnrJuwKtZvIMg",
		@"juHEQlyARFAzhAhpnbmDuzxFryJakwlCqsqRIFbVVQtMniUaBSFPpuTGAjQYfvyseGETEmcwyUEaNwdSoVhfiuopKoWniwlmzPGdfEtZwGCVfCndfkgCYgOVxUwaUnEORSuVlfrUIJlwDvlgbOsr",
		@"QmgKbknzKcTYkHTChdRbeioEPZnaFpuuAQlgiqHCpUiVLNCidGYNUvtlAqBncSuUtDIhIJhFLIgXGEStAvqJkLGxvGkmZiOXCmMFFXGQdwKjQQhkBkpuzncBcskXqExxbHrNTZExDknQG",
		@"yLPbRcMhZQRGZWLOZhUAPGCBTbrOqnbfdKuehwvaiajLvtGfNKhxKlUDOTbPStHjYBFROzdRoZPEZzPIbFQIfchtONWQQjZutGmEqIwhibVqJlXmGWtEIYmJqXFd",
	];
	return UvHrKDWiRdsIR;
}

- (nonnull NSString *)CkVZbTZYlJwURiKGbLZ :(nonnull NSString *)SqCpCHcKRYSiVlUbs {
	NSString *rWtNLRopMC = @"GWfXsandGwTudTCLTeRhmrznFStMNoYZynSAyWhGGPCMNMZuIKpVYznAfJOTpQmbtMBhzFhzJVPDgOSXeISJmzEnoLZPIQFrIPSibKMcwWYxK";
	return rWtNLRopMC;
}

+ (nonnull UIImage *)vxusmLjdLCdDRnr :(nonnull NSDictionary *)EsplIIOPKIpTB {
	NSData *yWxpyxLMILAzAzMJ = [@"ERgYmIzhOUFrrieEUrXZRvbpqRITmXmdQmgpWHdDkPQCMKZuNTEFJvEByEjerRdMRaItfVTRZhCNjEpvNxWgQiuxJTIraKUGgPKtjKNDuRv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *VqxEWpIcjryZOkO = [UIImage imageWithData:yWxpyxLMILAzAzMJ];
	VqxEWpIcjryZOkO = [UIImage imageNamed:@"WXnHXwAdrPInijnHJZNpIumygpBotJtafjvhsHOtJQNcwVfWlvzEMcMGkaaumFAIUJuNmrTEVqXxOousSBRTejaEVELbbpiWoOjuGHENaJwEUgDHSBPFuLswmjSIakZgcRtmuVZhSlYEFOXASlbT"];
	return VqxEWpIcjryZOkO;
}

+ (nonnull UIImage *)WyQuSlwXGs :(nonnull UIImage *)NeibpacNrSp {
	NSData *XHfkSoxbAwQegq = [@"nyZnPqwxAsUyndXHFlebjMBuzDWpKbOSPuBOhwYlAuEviqJVLceLowlXUjvroowJCScfCDjHcSgQGwIlkFltOTcwkOluATKbrDiGGtR" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *EkQDJBPXcIbyh = [UIImage imageWithData:XHfkSoxbAwQegq];
	EkQDJBPXcIbyh = [UIImage imageNamed:@"ECLYYRQXluXMtxKhDNIMqnpdKtBkKtHWBBSXPQEnXYzARLgaHcKShszRlRuXonIngrPwxVTStBVxxDXOxKydRLdZzLxrXPPINipUPGRgcek"];
	return EkQDJBPXcIbyh;
}

- (nonnull NSData *)HabfnBSkkSovz :(nonnull NSDictionary *)OhfOwWQNIzUm :(nonnull NSData *)UfuAJGJZDlSQB :(nonnull NSData *)zguwEOSpeSGFyz {
	NSData *oIgiBIJkJvZDAHj = [@"QfpatzmNJWWylMFTcFNQfLTNUMWjrqCgAUhUfCagxOCCetekmLREnjSucTsdnDcpQBfaFkzkBPycsXkQHozAEmSwSMWolrztHuMK" dataUsingEncoding:NSUTF8StringEncoding];
	return oIgiBIJkJvZDAHj;
}

+ (nonnull NSArray *)qRPUlyVfgO :(nonnull NSDictionary *)fqStioibeYek :(nonnull UIImage *)nDvbhUgIRkdbPVwgZUu :(nonnull NSArray *)xhUiMaPiJVnRpxohov {
	NSArray *vnaFVAMAxpRmSKWTrik = @[
		@"iGTUJlouJPYdSTOqHWyhwEzJQwiPHqOjSNrCplTvrDrnxJFrwXFEOZSGPkTaoOZfkYQRaADEEalKEVngFmccpziauwStwwDfpcvQphgVGEbkHywrauJ",
		@"TxfuTeKFaHFsDzZoEYtnTXFIPayrdISFXsnoVNAOAcJmUNjfTcPGjNRGKWzGdfUEkvDJFNsLGnFGGxUgglYhgZMHuwFwcHPrCoAjaDSFXoOMtixTdMToZooeNrfBattZxqDMV",
		@"wDFPkfBwQqJejulkCDRcmCNNqcEdbhfnkSuaTKXecnnFTfostrWcuwNbcjAOmOfVotWcIZcxDxdzOOQRXnFfrOuHsXigvbBynLzjKbjaUfvOoVFdyzafBTdDDum",
		@"IdFSHEpLDbGunJytBldSUFlCVmkIfiErtljmNWTBsDKtWvqnwijojjhiMZsONGLBxVyZJCugmHJHXrWoSGWFaOgSasCPIrRnSBUdtlLNlGvpSxaNBzDqzVDGdAmLtQy",
		@"zUMvYRdLXKdnoyIKXeVIWKGdQzhSiCYJeejYAZzoxIzQuakqNwKTEYXeAYOVkjGVrgJgnJvMSlYGKgPrGumaoUbzfnVyBpcSzRwl",
		@"UBSQjtbjBxoJYZpIStyTipRYwqJmyWsltRGHsEVBSYfFUWpiHgqTywzynvWJTWURsQYMBkRQpReOqzscjAUzdfhBlFXszlrHlmwcFiWOvwOjdkxEmnFMp",
		@"pnVJofJHWAGZETANPyUEfRuJClMPJzqGnJVTkIGwzGnmMomtZyZAcUXSnJafFpjsViuVPgDAyRjxwoUBpQIomoEebzgBlXEPLubnZmTPuugusJzKXrscfXnpNJFknWcRbhIqX",
		@"zssBpkThKEofvIsFXMrSQOWUVpKhnSMiXkUOGfHkzcdSMnSTTOUtSRuRnNPpZPcaLSWPSvVYuQaAwLDJwrvLOWCtwkSPjMLEkuPjelBibWBhDBvKPLoqJuxCkBtpPFyfMHsBSUTqZsl",
		@"udrVloyYXsVFnGQcgXTjpleeraCfbuUgnqAdYfiFXwsXsuvNUVFVemRoPnRUsisWqXzPCSborBXbiqAHGKcFwIspukjMxeGfPwQDyaLUwkHSS",
		@"PwZhHvhjgUAgEKIRZVenkIbwZWsOpCcsSEdFOVGInwoOtApIMMSTRGISmzbRFihcaFrMMDWYejrHCkGElOvFMyIqvMTobAoLKoDIcROzOswgMgjOgpdIwCaETMNTMtIoiFmhEZVcMu",
		@"LqiYiYuxiPOXyvhhytXpfutDkpyWsDMacrimhiGvmbKrrsBPdmVeXCNcUCKWGILMaIYPFClwERrMYbvwtkTutRFVJxBOeKKSbiKuKHqxUqZSywRVRm",
		@"qPesLIzTsRRcqadzOzdiDrQizYnfHkunBxXCUNWgDlUUImHDKTQgzDjcBSlvDHrrWbTUEgfdaoOZFLCAPygFYntSvdingaiIEAlgG",
		@"tzafLSoZHwveKxWLWCBnVCqogFmbkgoudFFvKBoBXnrvFjuyUhtJYrqmpZdLBYQmytmhnXOHRMBBHQoXzJzFnYLzaDbtmLAoUvftsQXaXuTfMJHEQfBEGitkerkUuZLyOQiiYbHLEAZIAMpyYT",
		@"aISNboSCNEZVqElygiscLYvBsjhqoyuvKuSFlupFoJyyXTwoSsvofnXZeuDvhwxoUmKTVlBvCNJcadOYnXNLCrNjpvmSVQLsmYuuUIRISF",
		@"hUzVUngwlvUrJrlzrMiKftmZKoBZlDoBKKzzJcMJKVVEYrecgReqduswJIlSXxTAkBHuvxBBIQEjpeZqSTtySujaPyIDbemZiZUGaatMpxWOCPCnvAwnr",
		@"eWoiwinOqZfnilnfhYKdwZVOfXWqKCXYsEyjkvtWHKHkbHTUfyqLFNWMBpqXHgCQktymhGVHqfeddoPAmHsRXxrqgFEDMMreMtOUNfDatjnIQOexNQqsbFeMDPaumXnAFk",
		@"XCIBjTovBVUKyTsPkizoxzjTEnQtrqBzFooqmiSBtcMZisnfqwGOomwFvCVTeJfNHapcaZKWwqCXKDMFVivSEDuYXmRddiYhaioxHelckYZTXyqUok",
		@"IRlHOAlYpMyGVaiQMLpiszxtXqkOhMtgOYLqPbgxxfZyHDoLtbfcMfqLbbEvFpKkIpCefEVZFeKuMjVqnSVFmCQztOpdjnbmvNLOdqmVRatHHbdHiQobQItOtHkFpxsKaIMvihBQXtkeGPeD",
		@"ytYGYWAYaQXVzrvrctDDahLcUKKXHwzRLJhftVChyRiAsHSveukEOuzOqcXHasEFPXQqknSvSZfAXjRNXOvSjRibJbZLRpJPQJqHebinBOoYsCRmdKpTZKSljSZcQDRUcuBPfTgkkiZG",
	];
	return vnaFVAMAxpRmSKWTrik;
}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"通知";
}

- (void) setUpUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    tableView.y = self.hasRole ? 70 : 0;
    tableView.height = self.hasRole ? self.view.height - 140: self.view.height - 70;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    tableView.tableFooterView = [[UIView alloc] init];
    
    __weak __typeof(self) weakSelf = self;

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

#pragma mark 下拉刷新
- (void) headerRefresh
{
    self.isMoreData = NO;
    self.index = 0;
    [self setUpData];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageModels.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"cell";
    MessageTaskNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MessageTaskNoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.type = Notice;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MessageModel *model = self.messageModels[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageModel *model = self.messageModels[indexPath.row];
    return model.noticeInfoHeight + 50;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
    
    [self setUpData];

}

- (void)setTableViewHeight: (BOOL) hasRole
{
    self.hasRole = hasRole;
    
    [self setUpUI];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MessageModel *model = self.messageModels[indexPath.row];
//
//    //考试
//    if ([model.businesscode isEqualToString:testType]){
//        NSString *uelStr = [NSString stringWithFormat:@"%@%@?token=%@&testid=%@",NetHeader,CourseTest,[UserInfoTool getUserInfo].token,model.businessid];
//
//        MainWebController *vc = [[MainWebController alloc] init];
//        vc.url = uelStr;
//        vc.webTitle = model.title;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else
//
//    //沙龙
//    if ([model.businesscode isEqualToString:shalongType]) {
//        MainWebController *shalong = [[MainWebController alloc] init];
//        NSString *url = [NSString stringWithFormat:@"%@%@?id=%@&locale=%@",NetHeader,Shalongdetail,model.businessid,[ManyLanguageMag getTypeWithWebDiscript]];
//        shalong.url = url;
//        shalong.webTitle = model.title;
//        [self.navigationController pushViewController:shalong animated:YES];
//    }else
//
//    //问卷
//    if ([model.businesscode isEqualToString:voteType]) {
//        NSString *uelStr = [NSString stringWithFormat:@"%@/mh5/vote/votetags?id=%@",NetHeader,model.businessid];
//
//        MainWebController *vc = [[MainWebController alloc] init];
//        vc.url = uelStr;
//        vc.webTitle = model.title;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else
//
//    //专题
//    if ([model.businesscode isEqualToString:specialType]) {
//        NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ClassesInfo,[UserInfoTool getUserInfo].token];
//
//        NSDictionary *dic = @{
//                              @"classesid" : model.businessid
//                              };
//
//        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
//            int rescode = [responseDic[@"rescode"] intValue];
//            if (rescode == 10000) {
//
//                SpecialDetailModel *detailModel = [SpecialDetailModel objectWithKeyValues:responseDic[@"data"]];
//                NSArray *titles = [SpecialDetailTitleModel objectArrayWithKeyValuesArray:responseDic[@"rows"]];
//
//                SpecialDetailController *specialDetailVc = [[SpecialDetailController alloc] init];
//                specialDetailVc.detailModel = detailModel;
//                specialDetailVc.titles = titles;
//                [self.navigationController pushViewController:specialDetailVc animated:YES];
//            }
//        } fail:^(NSError *error) {
//            [MBProgressHUD showError:@"发送请求失败"];
//        }];
//
//    }else
//
//    //直播
//    if ([model.businesscode isEqualToString:liveType]) {
//        NSString *uelStr = [NSString stringWithFormat:@"%@%@?liveid=%@&appkey=%@&locale=%@",NetHeader,Liveplay,model.businessid,appkey,[ManyLanguageMag getTypeWithWebDiscript]];
//
//        MainWebController *vc = [[MainWebController alloc] init];
//        vc.url = uelStr;
//        vc.webTitle = model.title;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else
//
//    //课程
//    if ([model.businesscode isEqualToString:courseType]) {
//
//        //根据format判断是课程 还是 音频课程
//        NSString *likeUrl = [NSString stringWithFormat:@"%@%@?index=0&count=100&courseid=%@&token=%@",NetHeader,GetCoursesDetail,model.businessid,[UserInfoTool getUserInfo].token];
//
//        [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:likeUrl WithParameters:nil success:^(id responseDic)
//         {
//             if ([responseDic[@"rescode"] intValue] == 10000) {
//
//                 NewCourseModel *model = [NewCourseModel objectWithKeyValues:responseDic[@"data"]];
//                 if (model.courseBean.format != 3) {
//                     NewCourseDetailController *newCourseVc = [[NewCourseDetailController alloc] init];
//                     newCourseVc.courseid = model.courseBean.mainid;
//                     [self.navigationController pushViewController:newCourseVc animated:YES];
//                 }else
//                 {
//                     NewVideoCourseController *newCourseVc = [[NewVideoCourseController alloc] init];
//                     newCourseVc.courseid = model.courseBean.mainid;
//                     [self.navigationController pushViewController:newCourseVc animated:YES];
//                 }
//             }else
//             {
//                 [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
//             }
//
//         }fail:^(NSError *error) {
//             [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
//         }];
//    }else
//
//    //资讯
//    if ([model.businesscode isEqualToString:newsType]) {
//        MainWebController *webVc = [[MainWebController alloc] init];
//        webVc.webTitle = @"资讯详情";
//        webVc.url = [NSString stringWithFormat:@"%@%@?id=%@",NetHeader,NewsDetail,model.businessid];
//        [self.navigationController pushViewController:webVc animated:YES];
//    }else
//
//    //讲师
//    if ([model.businesscode isEqualToString:teacherType]) {
//        NewTeacherController *newTeacherVc = [[NewTeacherController alloc] init];
//        newTeacherVc.teacherid = model.businessid;
//        newTeacherVc.nickname = model.title;
//        newTeacherVc.userid = model.businessid;
//        [self.navigationController pushViewController:newTeacherVc animated:YES];
//    }
}

@end
