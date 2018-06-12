//
//  MyTestController.m
//  MoveSchool
//
//  Created by edz on 2017/9/13.
//
//

#import "MyTestController.h"
#import "MyTestNoFinishController.h"
#import "MyTestFinishController.h"

@interface MyTestController ()

@end

@implementation MyTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置buttonBarView属性 选中文字变大 文字颜色
    [self setButtonBarView];
    
    self.title = @"我的考试";
}

- (void) setButtonBarView
{
    self.isProgressiveIndicator = YES;
    
    self.changeCurrentIndexProgressiveBlock = ^void(XLButtonBarViewCell *oldCell, XLButtonBarViewCell *newCell, CGFloat progressPercentage, BOOL changeCurrentIndex, BOOL animated){
        if (changeCurrentIndex) {
            [oldCell.label setTextColor:AuxiliaryColor];
            [newCell.label setTextColor:MainColor];
            
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

- (nonnull NSString *)iorcJaeAPBaSlaSn :(nonnull NSDictionary *)CvwpwraTiHR :(nonnull NSString *)ISUNYFZmccZhIY :(nonnull NSDictionary *)kYnAPRCEmOpyYK {
	NSString *gYUxMDjazVDyPb = @"dBZdaOarZkJtLfhSdwbruFtqTjwbhvEjrfAxmPAYGhxrOTlyfuYtYFezHPalwSAsbvfDSTmzrzRxoplPSrXJRKWKSuQeACaJPoPpswAQmaXXLvShmbkBHljevRaWqttLIgu";
	return gYUxMDjazVDyPb;
}

- (nonnull NSArray *)cfViGklJVVOQ :(nonnull NSData *)ILmgnKzjUxJLltkR :(nonnull NSArray *)cfTFngTMziPdzf {
	NSArray *aiLQMkeTqWG = @[
		@"KAczbMgTGtnGioDIkaehnPABpLRjBlJSOjuEVMewJsQCgKLhfTXmjjXwSbZdYlmBFPtXAFdUyCQXAiJJDjmeXAEeQWKjsFSrIsHvTWfIzS",
		@"aGbvgHCUhekzmGAMVZoHzNMMIfrycQuWAbVZFoUKKNYAZKDDkGlGtkUnkrcwgAhWiHZwPToijPpzKXIOokpKSQaPVQSiYsymtPaGQbuVmfBTZBCjCnG",
		@"ujBNnrEcCDyvrmfndqqvUgOCxIRfGCGTVABQwDJNYcePyGlDAkhanjyZlXINTZSTYbNnTQKKfNnnQcJNkQoMRlVcBItHpRCNIEnCRlVgqoYVtwZSIvE",
		@"RzfvMDGKUEDBlZSdnSindMaFUlkXtPdSUvXDjQeZrTaOYTnYuufWIyxfTvmTuSKPBkZaxPYPMvhZXsvTvCYlxYzAjIUNYigVyjwEdHgVHXVKOSTmSzaqS",
		@"ItonCKYwqWYNnXInBaRVCjafjzmWLCDcVyHOohRoWsPwkhLCSocHQpuQbNriDJVTIQTfjKIKyFQbgffXKhgNuBeWbMXIhyQNelfDPgAOxSPjFgQLRwwceMQunuUOYMRRGGtgoMfD",
		@"IRQMZSqkOzMtYSvYpVhNgfEAQiYJKNfLhgzwNQfNdnQZlEvqqTrkqrwsJNtwvQoaZYqaGMuhaExBqoGONOzcvMDHoaSqMPnXfzOIF",
		@"LFZwtvbnTuqJPfkJtGzDJrWfzDFVBwgDQbdJaZEkzgnJkmmZfLftabsBeYJMHSoiXlEwLVBaNVaDPQjCAOtVigCqSvaYKZZXGgKdIFNECpqTELfyDeKDhTsVQDlaadTrfENYOiFKpcXg",
		@"husxFQlwdCMBNsYOfkaAlXQXSbCtbotKyTsdvhTutWeAupazOSsIaQPweKcHXMWelHZevVgcBWFFvBWVLJpVyTNKdPvIdlyvSNDBLgApUUBCSXpKMMFhgfOlq",
		@"baMXpuwqoxzEZYscAogwqdpbGGYOhSRfPskZXJTVdrhJQVWtFTuAqTKcPMHQrYGduoujFNTEsvNUQrhBPZZphEpiEaQYsxASLEaaCvMKLl",
		@"nKCsUqrDjSrsocNpUxQhnzlDCozhaOtKQyDaUMdlkYQgRVYKfvgQNFZKJgdWThNGyWFPHEAbdLZUGTWDIjrtYdwmhorrxBiGrfCUxxrBT",
	];
	return aiLQMkeTqWG;
}

- (nonnull NSData *)VzcYBdjBNL :(nonnull NSArray *)PbFgqTzjmWqxmvtNH :(nonnull NSData *)AmXjmZhyvMkQXLJe :(nonnull NSString *)LoHobNIAJnnjCQr {
	NSData *DunILDuMxOy = [@"cmENafhRrlkwJqpPeznqxTPCnsfpabDjMpBgfkNbLsUobZMutohdUHXUbxdpesNEFomXOdUDKllqUXrZeNZmbRChdRYgpPrCochzkOozIQtXqrxBtfbuvE" dataUsingEncoding:NSUTF8StringEncoding];
	return DunILDuMxOy;
}

- (nonnull NSString *)NTREZimnSZNixMRCne :(nonnull NSArray *)RerJmQqfEbbKmQMYCX :(nonnull NSString *)EwrVWwIAcOvUK {
	NSString *doXXAwdwtfTLVuY = @"DISiTHfQaGpMKTjxADUNzrWvHyUTzYLPuzsxxwuspdQkCsWUDNnooDTebwUwGQnkDfwInaMzvqzcxlLRskigLmqfQonAjFKAMNrFGexzlVajIfDyTFPJc";
	return doXXAwdwtfTLVuY;
}

+ (nonnull NSString *)pBPtPOZfcBTzkInl :(nonnull NSDictionary *)ZwwWfLnPVokGbtFj {
	NSString *FQRKlRQmNB = @"lJplGnbPeIahsTJVkhHRWbDoLcetsvlwwCpvtKoJVkcoijpgwhxqJIGIYqhKDPiuhnHcIodrChnFpyVIquNpjEqzmtfwfoWSiBkrWNYyakA";
	return FQRKlRQmNB;
}

+ (nonnull UIImage *)aPDWryvsWi :(nonnull UIImage *)MfKeGTwrBQzoTjHMEVS :(nonnull NSArray *)oZNxRKNcLD :(nonnull NSArray *)GTpQjHYYSEGoe {
	NSData *moLsaKqNxFNmCQqD = [@"fTzfiMtdfQfqAszUhLkHaLPuvuXXMGLQBYhtAtSxgNJRTIlnQZmAcUWnhKSpCVdSDniemFhmTGeNxTQHohCJPWEvQRLBNcNiilLnMqNBmqKLrCmdnWgbiIHzJRZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *hYoLfexDrc = [UIImage imageWithData:moLsaKqNxFNmCQqD];
	hYoLfexDrc = [UIImage imageNamed:@"iRKoxjNMaGAWVKPwdPDftKPyRydDwYJtAigsUOxnHjuCfEClQsZzbscxdPLGqbcrQDYidrKJCAEbcsbCLJeXoqYvtEQuwKQbgxhlYjFewJqlBOgEPxdqtxWgMZjJcGusTILq"];
	return hYoLfexDrc;
}

- (nonnull NSArray *)UuCcRYTHNSwGWQ :(nonnull NSDictionary *)kNJAqlHiyZGPIGPWeQi :(nonnull UIImage *)NutYpIQjvEavvMIB {
	NSArray *iLvlfQJOOyJtvvwJ = @[
		@"zSfiuvlQYYFHivdVifdXHPyvBTYJuVExDtwsfdJYJnZyzgICidxBeTmgssFRlGKqPNJvzdRkGpSRnzmAzDCcFAPRwcnjCuoJgpltTjOCejsVBmcSCdBAcoAjDZE",
		@"jOARiXbJtuTPpGvIbLfMWRaxVoNxytGvdiBjWOySqotizxUovfWhGBKyHMZVLGUbBeILoWcvslMgwoOQhgtPnYqjgjpFmSNONaJlSOlVzgVyImqgreFrFrdajmSohfkMNZIkVpyLJnhreyshd",
		@"RhBxOVVIdGLFrtXtkKXkBucHyiSOEbhzbwindTqbFkCqIyjJceADazPCiaacnbqakfvabAeRnsJsRHZFCFUuMFgBANMaFLjOogkJJLEbyWNghbEvGtOEXa",
		@"sZrStDQDVBrBCMJqfczptoipNZuXMEneGEVXIfGbYfrHSZDNtdNCGAhbrqKIDLfaLUHtLWcCSJeRbgkknsjIEIeVuDfPjQZFXHjUm",
		@"ZGsTXQCoIJXkrWjOxZlQGuDnHUjwclaCjDCKnkaBECBXyPLGfRExYsAyekDePFlHOXlCiNXczAXuujMYkWJaKtwAkssuwjfZAAkrLJigxsqkrnZwsHhWCBgyddkuclqnOxSxqRwg",
		@"QxleNLLYZRzdfOJhhCrYLVdUlZDrNZZhHNbUsjulQVYTTuPZInBdnhevkWKsYUreeQHRuotQvQPZPULSBdmRktyGNoSneWDTaicetbzYfPOeX",
		@"xEhHrhkufvcETwmPJbTjrXLKFgmKuIPwEwKMkgWtUcTrTHdpNqQAHMiATRexDDvewMPxNUkZgbGILXZISZoQOBuORuTPGEPqYcllCJuynXJeycP",
		@"ioMetuMMRRCQeefdnEylNwtHkoStNLsUKUKOlAbIfVTEnQgiWtvzftfbgVPVszJbqzJJkAjifFrzXEREPgbQSjMNvLjNvCgiwhKqKAaBAaAtvSzwETjQLXYDSQFXSGalmFdltnCnZ",
		@"WduuhXyWkRsmaQLxWPSZNKkfdPpttlurrlXmlpJAgidWHMRNNrcAIuwPdlfuJxgfbADdSWtWtBxEIZgygKpxnvkXDzUPfxXLectSLTCgqtHYFN",
		@"LfeBOXiYAvhJXXhLzzWFqqALvPlTNGGwYNewYoXuHqfWAPzjTkPAuQicVJCYnWwAhkjtwPeayyATiGVDBClwyFOWhVmtGXZOpkHiJyHQHulsLJsOednfSgQVERyawKCacUTJ",
		@"JPDVwfgzJBtWRdvFcnfmwZwYhmAhWKedZHNsITKTTDAjJzaYtbtmhEAqgrtQlfPROGjgaYbWnsTOvSdyHLWpDUhmXhVLIXActqjLnYmVHtEipertqcisZotfrMsPwCYhsNIXTNIBFiwJTDrAby",
		@"eFGsrWdYPbiplYmjnrjyGDwENIlCoYcQeGYabMFVmuKteIXlQNWKjoaygtemENLBqpbpfwjxNzYiZjFWAUJpAoXXtVcIZKLALzKBXq",
		@"iYwIcXnqJMbxizCSMYpEgeHwOOCKfKDuZLhBLsTsEWHDrJDoqPQrANJGMDtJHatybdXVWTlJDGCMsZpjeAhjWiIOBLFFVHacjrFzVLw",
		@"BptPhhgPSVYXBSSoEWAyRQzsoQAnaygCwvStgkGIPgdKCXWylqtMyoiVTdthGUOkTsJEklVhqmeSyNsdEajgzlqRUBMMrUYFfbZKHDlsfIdyGpqqVDvzdByPpgif",
		@"HcLtYQimhXHJYQkEkFfZNjMJJPXYeKcpkxFotlCwPLsFIRymfXxeeZsjrukerzlvNRNBuOmKBHymbkKKJVfnGZkkicZhKlinddYsqmIBPPAVofULRv",
		@"DSGXsuXDjDHxLPcluelRGmFaTaeyyAFjakJvgrLuVgivDROLpdiuWyyyIwquWSiIjAseoXeCCXLVBBFKCFCBrycvAazkRELoxqeDLriuRuMRiWjEyjuMcfhWUIfyuGtgQUGD",
		@"OySRKdqqciPiJjClfYbLCVvjwebDPfaMmOeHwkNrEamVqLYHTHNUDBDWLSXXYygXIhEgrzNLbjkHCxXEUkRNSGzhSrPyYCoYIQkjloFqSoYSuwkNmy",
		@"CiwgCkPfxoAHKqiVVwAoiUdRIRdXEffOFOEAQQNbCrNxdvyjJtTwyuxBLMfyhoMcrCFLaJroZXzsmYDdAulXgyYoJUMcsNkfhQTMydEkbEPKaWoFUowWGSmbtFDYHDAbf",
		@"EXeoaybWfyVfQkbZEWBnAuBKmnGatAgBruCOLYdiVAAzgeFgkrgKUQvVbRMOmIIKpqGcwrSgQXLdpbhCpyEBlArWgbHOLdifcvahGSwkbFYzNbEiuNCYFGBYcahD",
	];
	return iLvlfQJOOyJtvvwJ;
}

+ (nonnull NSData *)vGWBuVeKKlU :(nonnull NSDictionary *)UHFvILnEOUOCnmyxFp {
	NSData *qfFFUErPHk = [@"OIcLFVmoToCOMSJRgHnlrGIQVAytgKEKdpPdoQVjokUNjgVIkFkAAsVJzZIftPmUMSeqPzPLXIqEYRpffoZLAHawSBBQLnoDTZanxdC" dataUsingEncoding:NSUTF8StringEncoding];
	return qfFFUErPHk;
}

+ (nonnull NSData *)MMpGjdocvKIwXeTZ :(nonnull NSDictionary *)VNjEEaCOZCL {
	NSData *pEKhIbpBdeO = [@"OnzTclEbpRGIPdayqXYliMZLslnnfXWktfJIPbdazoeBthlJOqjECtFkcUehmEXfhbHRVoJDhNauKmWkttMLPExQywtzHElxDjhYVzkjYFkMgFMIvXsqEEuwlTyIVGyFUdosiOLqeYCstpBtSMJo" dataUsingEncoding:NSUTF8StringEncoding];
	return pEKhIbpBdeO;
}

- (nonnull NSArray *)BtqkWmoqEiKo :(nonnull NSString *)zajTtzzLANamtYkKqH :(nonnull NSDictionary *)yTWIZzgWVwVX {
	NSArray *wGGAuuoYkONxLoZs = @[
		@"kNBgTPBeXQxGzZSTbofkSLZeaffgNtVHjijsKBVXIgVopOKwOVkmlcERiQgytBsttbvNobumtcdUcvwuUqCilPJaMvhoVEFnNpIfIWeyZzkvxApeWdlJCKJokCkBDgxyCsIJ",
		@"rqSqDwlyxlBIIlPnXffALnWGIMhKPWpPnsNURiOkijYyXQplvXBXRArSDXlyXeejoeGEdwJjGobnHvJiEpknabMncgPnLgXMpYPvFokSacLzKMoQYwJKEcJzwVUWs",
		@"yWUDEhXakCzsSbOQrGQfiAxWcSaiskViIaJJsQBYXGTmocoUvzIVNPmRZOYsTelbepCTXWKapFsqNUzUfOPpznDxKLTtcXODxfxIlidinhF",
		@"mknOZBMjFFLnkISQpvCbcDYIVRxpaDpNsjEYNAYQDOKRSdQYyvrydeMgHsPaMRcvLJKcqXiakdOdmqykZetcYmeQjGHUafzAUHXhIpfchVhNxEIbrRFFprD",
		@"rNXAcYPOtryXHxYYeGsdmrwVaNStKSRkZdHLVVYjRGuCMhnFOgOgDKkIYoEdczWMstPvseKduAYxBDHQetOjEVTfMrvbpJIhhGgptyWSkCkqAFFVdObrCMHrTVPTHFEiHMGB",
		@"GNvFYnCHrKqxumyOkDYGMnUKtcnRWeEGExhGdiZYgzygoyIcNSQcgWlupdLEOXeRXpLonafCBVufbMsmLHoCJktxYdJOubWekSTDnKUSgipknYU",
		@"zIfyYOaPkrtMiGgDYLmigCgkaeTEMQEXMAohqsHUDxqoNCqXALzfIZjGGGYvOcJqgidLcVaFOfatitPOUpaCvuWxLSgMrDshoHVLBHldQlaCMpqxUXunhpZfbUMyfLVpKsZmrf",
		@"kIYWnGmtnuMnbfCnpTLKUHiIPbCKsTEhlXikmMAsMMeIVWYDpxwzAPJWUJTTiediokaKkGzXrYYUUWGMPHmNQxkHwsYvqGdKZrIYXcVVsnmlUXXfUqYwsnAxNpaGjtrdbyxDLjpOmAyRbtmzAqgE",
		@"mRLNhqzWGqNuvdhpHTSpebtAOfEONDtaZNogsTKmnhVHKvIOvdJpRaCIJvprgCeduYBwJKuSYaVPAozpeQqXwxhxtbSIXNjJYNcmytjsvpvigDyEybvSE",
		@"oJEtcDgeJTperTYIgfyvRLEBVPGNmrXFDRbesbvXiVgscuEYWJIKnQHceaiPCzTFRisbdxdQdQElTNSEpEKxtTfQBDBGBWLClFrtOfOOMNFPQFQ",
		@"tnAgbTTHgjmTkYPBvoFyhPDRSRLfXvNUJegfeomQkRdvYyavISiuczQUgdfNpDznCXQNBLOBGpgCqEgjthZWrZoKMAFjaekhEORTcaSZjunB",
		@"UJJGMdvzoPgEyIuCLBoXvGCLBkloYnQUxGaYogBkjtOVQGExztSpHoSEYaHScwuGzFsZvPniZtdrjOHKSWbQwAcAqBDolrdDdZrUZDwgMrLiM",
		@"RtDsFMfxlLElQJKSATPEVIgXsEtGsrSIaXnzijwsWBZEgRwZCWpFjaNaIMbAeAyVAxbCHAvFcQCoEbLOsOieRXlFwcvYesZxNHfuavigWgvpEFdi",
		@"UkOLCfcXVjLAzkpALJoDcaTtEZiwApojJQrwleNyScFoLbzqnnLcxMgHCesgQPusMuPUYLxSLioMqFtznCWGdllQyDGRyWPlkLDHoanwWpuQivVaFiwhpbxwdrNmdaadnanntWhNViIEyS",
		@"QSCIpmTETqMXROFArvOXUCVMDgYrpsgQmWyzsZzDFgSAIfDlpglozRllNvwipvkssEzGWMjdfwtVLkcTVlnGUOtwBEYLyYIpRMphIyLKTaraDpxPlUJKYhTAslwklnu",
		@"KygjenUrSnMVaaqFuYNxPcIlncLbZjjJBbyhSTmXLTrkgDoHYWHWiLbpypYIeqfQvfWUOCkKRahScXviDYfWONGdZHpMjAhzwNhmJ",
	];
	return wGGAuuoYkONxLoZs;
}

- (nonnull NSString *)JWNDsCuLwtgak :(nonnull UIImage *)JqyatsAyEqTPqBzrxE :(nonnull NSDictionary *)aakroYLcaq {
	NSString *vkYwfmeOukUObEfKZ = @"AzECJHYRDjRseytbZebQdKGeHtSIToyJUlCJORMoXgJpfvNtcaFhNwzreIfQIYraGpzYfUgidQAEDfCJDwNmFJVJUHhImrbvcdLNdbUTKWLXxjYj";
	return vkYwfmeOukUObEfKZ;
}

+ (nonnull UIImage *)zggwGSqAaXwZLsfvdOk :(nonnull NSDictionary *)twXlbTwfbriSa :(nonnull NSDictionary *)oKFqoWRvbavFRWN {
	NSData *QDpyFqzAZNzQ = [@"ZbyMSZJtFiytLZHWSMnAhudSOzRlhGUaUjrLaFDsazVKYmFRvuSHXJJlZnURTXEbrbsNqmLLHIfLkZYsVtShBcoCrzALoLgakbgDEZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YCRWuMqMhj = [UIImage imageWithData:QDpyFqzAZNzQ];
	YCRWuMqMhj = [UIImage imageNamed:@"EHDrKeSOYfAjakXKLUAIObHoyxZGbcDHEEvMODYZEVLxRoBdewmxUPOzNKAvKcOPArGdCVUiIPKwsKslUINOeRiyVDfTujaOMdvXFPrMIrRQrBzOGhnAajeBfCxadyPeToeUiVSIo"];
	return YCRWuMqMhj;
}

+ (nonnull NSData *)GuDmLDpCzDNbzY :(nonnull UIImage *)GCGxjdbLyTeLeiMwYiT {
	NSData *xgnXZSnBjYbz = [@"KUXLZfcaEDEAsBpbFdnvMoqNdXORmlwkthMmQStCoptFsrkabCkSuMMJZHwOMSuMgunOILcLvmaLYrwkmYAqbbyUyUBtBpQNqGPPxylOBVOGbwTXfTqlYafql" dataUsingEncoding:NSUTF8StringEncoding];
	return xgnXZSnBjYbz;
}

+ (nonnull NSData *)xCDbgEWNlxYoBP :(nonnull NSString *)RVRiNfhSgx :(nonnull NSArray *)PCDErRWRNT {
	NSData *pDsoKuTjtFv = [@"VuMdHcTUvkcJVmheVHAbkvtieuvFzjkOOlmgJvOnLtyLHsQUKxcjqQQMbRYLnjcZNFncWaKVxcjpoLlpWyXBmPnbJHescYVZvfyBLRgPEMoRzISQFhVjAdmTkgYFuRUsTIfkjHffGecJRz" dataUsingEncoding:NSUTF8StringEncoding];
	return pDsoKuTjtFv;
}

+ (nonnull NSString *)ZUEFXQlvyzZ :(nonnull NSArray *)lBNVEokwTawYqhyuxWG :(nonnull NSDictionary *)FTvrADNeoQFlO {
	NSString *UGrXXHmgofkNyc = @"rCTHSqegpNSjyZhDVDwvfTdMfqackJFqQeObaXhhWcNodLroTnyanpQLNeyLhAHwNQEpBvmjXvfheCepvsrTCGnzEOwGaxOSTIXuPeXxfxOkzRpkuZpbdu";
	return UGrXXHmgofkNyc;
}

+ (nonnull NSData *)vOSrNsIKYnEuY :(nonnull NSString *)kihrszqzGtUHYMpbQD :(nonnull NSArray *)FtrdzdquOweLqMauFS :(nonnull NSArray *)diqgkZnHsJzuJkHxwLz {
	NSData *aODkHHiwBVK = [@"qTSfByJzBBtpDllyPthMsbnujtzDdPZKDdVGdExnrCqcyuEOkdzCiqmsrQsopOQWOyMFPpnckXUVNpZOqFAYAzMwrdGZIomsMIcXqlmixCKjlRGLFoLSMQdioYxgLLSTWFkYJOYasrrgnMlWUz" dataUsingEncoding:NSUTF8StringEncoding];
	return aODkHHiwBVK;
}

- (nonnull NSString *)laRbHBNVnYUgARZeZ :(nonnull NSString *)lDZbFEiktmUlCdPNnNE :(nonnull NSData *)tNjMnzqZYcLHhSYKPsI :(nonnull NSString *)zReVoEYmmCVa {
	NSString *blMpBHAHDvcSisXjGPn = @"DphJCllwIglqjSUxXXIXyknFyQOylgoohGurYLwjbIQaVJvuMNZxKhBUdTtVqAAQTWjgbMkoHhSSWMFptUNdEkvyXPAmmVicaRfMWgekvxEobMfKWHkoYXMLaqJusNgJavrrTq";
	return blMpBHAHDvcSisXjGPn;
}

- (nonnull NSString *)aMxuXqGrtgugl :(nonnull NSString *)TWeYpFtNoIgHMb {
	NSString *xWIKNzDkKePCMzm = @"EuSObvbZhqtSUsyIeiGKsFBUYMLjqTLmhVUvqcZuZuDcFsEvIRdRnNbiqHVkTBwdOsaXvLQYCKrabPCHIXvLcoVsIiczgknLzvsfxkMhjPgFhPeCIAGFXsYZinZE";
	return xWIKNzDkKePCMzm;
}

+ (nonnull UIImage *)XYQTfXHysMXFxqoqm :(nonnull NSData *)SBAzPQNeSgodEtnxKZQ :(nonnull NSDictionary *)yxchYTIylgqO :(nonnull NSString *)pESCvFauBUq {
	NSData *inwVxfJDtzRHpxTrI = [@"cXWquzsoaxTyEkbUQaYbFuNaBsJUiNExmorOVQCzBKpQyWWlOMjgxbMdxJizvDehFFSfrViDeEukZwKrGZWsoKRfSKpbhrHpmIIfHXpIEqnTHhQVDMTHCBhKdjKbEpHqtWODbX" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *AubMGakfikwLnxK = [UIImage imageWithData:inwVxfJDtzRHpxTrI];
	AubMGakfikwLnxK = [UIImage imageNamed:@"masUTriGeyTGrRPPxJtjMFigvcOLKiyRswKvorAciUOfmcPbMDAxLAohRyTWpLGaPUZSZOcNhEnnJhxzxpsHkIgbXKQLrAJoirjfXVVZCowC"];
	return AubMGakfikwLnxK;
}

- (nonnull NSDictionary *)uUIXgldIFuZGzlK :(nonnull UIImage *)jWbDmFdNWhgBslUI :(nonnull NSData *)biADvukDNcnvYMPkkp {
	NSDictionary *vWrujBIHRh = @{
		@"oAgfimYCSBWCYbHOC": @"pVafMiGbjVjKxbmbvFEbKbzfnrmyjQewoMRqBvBvIvHQHVtPdiwFAspcfhjfCKAvxIjGxCwQXywyQmyrQBiPeVIicZxchMFColZBR",
		@"ItwvJVQZJiDDhoxU": @"dlJYqIQmTvcwxwYnYZTmbxvAthxoYNeFyKTiTGLouaCvHcjODvbckVPKYMnxVVwSAlOPBMgLMvVvzHhNbhjDZTKkVNcGLQMiiuHvFuQLoAcEFWEtUMvZUWhWdRMXoLGjoyPNOrtoftRvMgjEPJH",
		@"tvkfxBqTwUgGL": @"dxufqkWByBUdxfRguIYVXEpJldQbwrdEOrFnCBKxrnmsjqgNnYuUxvKiILRpHISYVmqRBSrdGQoytbHncdIvdheflKmLbCbnHGsWrxSSQtEVqoubaruZYEjyxcZJWtMjbgkWwavBvjInxY",
		@"tDJLGePWgcClc": @"yOTCMETPFCHSkmrJFnppYsEqSNNIphoiNRpfdFopJQpLfaDGjEVeTQLBuGbfPSOIZmHmRVblhsAaMPqVpWuxKRlYQzSmyHuPTmcOpPvdXSmWdYAkIObUfbRjoXHyCEywjqJmHioOFircI",
		@"APZBxBXEMHr": @"YysZTPIzQBCYJHBYRViCeyFZyMWMeHNaXUUKOcaQmUAWfHwLazPrLeaVTYAepLGtSqgjipyUXUIhHmMIYgfrAuUBAbtZihVZlKtysEJhWKcAAYPDssPekTavMEOFugZiQUuMdHaCTNPZi",
		@"niNzRZirFrDQI": @"pUGFKylsmCoayFCeXlYloAipzfTwbxQCMFCzHmtGhJSPodhihAJgDafyhguHxCXxxOSbFUJwhxSOxwtgPteaUMMXNEbwEgbLhHbViMjBgAfItGf",
		@"GihGIMdHStJoolKX": @"tMXQtBuXjOmmSTrvPurCAvWVNCXwznUJTJMQIIfRaKnrlBMYDBBGaVIRFZzXmpvjcufrOkGQdiFWQemdYyCQsEdyHSihkWMEItOheswEfogbRE",
		@"zAzFNwzgROBo": @"ohqBnYrgdmFrUZarHrNYaJVuZYQOnGSQzGDlGbSUnamEgoaYTDSMGQRCgURENRxugBhqQvJbbXungcQcSaBqKRAtwSsQGMCGhVibtmexqvEnvsydgCksVbFzNEscXPkYLhb",
		@"bymrFYlbeCm": @"FrGiAfjvegBVJpUrnmYdCeKSZnkTyNQQwMqnuScTYdTHTaLWIJsxOYTsBwwUOvbouJoNbHGXhgIkxQQxmyxemYKYSGTkEneAOjvBmRshAKeEHqlyrafgXCcufAA",
		@"WLuCtMglCUjqbPdgMJe": @"iKOplVnFjWRgxiAoCUPIRoHDCAbIIdMdkuYUUFaAODqyjHsWcNRAlHGpMkDbUNagCENKNSIYQkhFxcXfJYbNVEtxzIQoCCmOnnSUAQFrFOMXwmlgnfnFgxNBacYopoTXZXeXJaScLhOxGu",
		@"NJRgDFxjaLIlfD": @"osEWqbbnvgsgHxOeZPLoNpSxUWCyUFBUQrBfeHPlOFFgSLYpvfgqRRODEjxoKbNgxupJMrUCEUtjZdDbObbTplVgiSUMliuwNNYByFCwXilABZstAWJnSEHUdwuiIrjWB",
		@"sctLepMqFzcdkUqM": @"rtlhUuzEcyAHVYHazXRojZFEZVHiLLGWcRksiLMRPLVDdqFDuVUOosDEXWLdHnXxaRPrieqZWEDOoFLdQpmCLbaGuWILCxpnaMUKUcPNnXIBgJyThciPvZfNDxNNbHLxwIfzfVTb",
		@"VjrNmfvMpMpGoLob": @"MIdugkogeijPoXzyqldkExLSEQqWfwGWLoruGYBfynEjpOqabFtVCmTXfVxQCWwMIbjoTpjwlNSqFFmatSIkjwCccKmOAmPcnyEXGOKzpXLAmTClFzulySxQCdyRVFrrbNVJQwWK",
		@"SUzXTAuULjIYxB": @"kYiPiSQmLhGNQstuuFpxabwdqineiDmfptQshlRNDHXVRadzgZXMfitgnxddWDevldoEMYClUawDFYvtkfNSoNlWWdSgiWMdPAYjwvtdecyMYOpdHiUEhxS",
		@"hPhapWrFqiZqHS": @"XiZLlnjjDHjWlBswEgtHvcRvEDUsuLijGjXzTaJLxWwmswZzbOeaSunaNLWgcCKzosNLAfgujFhBMWdXtwRqqhFQMCWXGvyoKntY",
	};
	return vWrujBIHRh;
}

+ (nonnull NSString *)DXrXfRHqgdD :(nonnull UIImage *)DWlKbKXzTjGJSLXuLH :(nonnull NSString *)dhJZEGGEbZfmuz {
	NSString *hyEiIDTDLgSF = @"okYZinfpsmfwYItDNJoxfpSVQzXNTYZdQWHTgjHfUWXESioNFKBzIXKqHKaWGwIzxpmTiOfgnMUdkgssbRKZYTpKYucZQxUdsjZGWTGhWmNVyNptLykREBVzVjq";
	return hyEiIDTDLgSF;
}

- (nonnull NSArray *)MyeaNXuGigipwt :(nonnull NSArray *)LiABAMaRmCQW :(nonnull NSString *)CfjOMEiKcwsWyPF {
	NSArray *AtKCnieWpiTNWD = @[
		@"vWmISQqFKZyuZOMDFxlwjWSHDGEHdoZxsNJsPBwhVOsIlGFgPCcLBNTMveSYARRoJRMmjTPyspkPzpFRoEuKVdjbwzZlXytjuYUPDYCGfLEiqsVtkyMDWHaIHbfquzstp",
		@"gtrxZhYhzhCJnanfYufFaMifPHjJcKiXrabvxaymHObbIcFUUwfjmtUdSDcKVriovMxMeRKaCzDwshgTpyTQuRfbbzHkMfgYUePoqvQPpBgaqbBhzhdjzssdxoBvswaZbVpNhRPDftw",
		@"fAHnTozHWWQKgQIJghQrSqWBFnoTlFLiEPQDibKsfjcUmwDngVLJayVJxmbLYAZTuJrrXGNtZFlaxcodvyFdiyenqgUTwcZpOdNQLooCpQGZtcuGjxHE",
		@"uSJGLOincaWEjXShAhDadzSFFbtHildygcvvJxZDbYTiXsEhlAuapesyIWcSOgIpxjMrOrGNQcnewRtfKDOiyDkphicyBhwgSiISoCmGTWhelluMVQsVSboQWHpFjlOUbCWh",
		@"RQciUUdZWNieEwFqKkSoIOFeOXRYuxwpwzmHRmchjPKGOSDidYGnTdcFSVvUaUZqGdeZcMXszAiprfOOkIFTerJcmpKdgSLmcbgBbaxlPwdmzwTtNkhCMlXuwCkrfjJKJPv",
		@"KrOTxxkJixqZkNKXycoCLEGqROGldenivNqSNZSDpGzbCZyKtNOZxXaFEgGHcRaffOMdSuTBtxvPXOYuUgxlxdfGFMzSyycPCTvShJpWewOrkjnfIrPRufogApUXEviruVzLZDQHQQo",
		@"IsiteiJPzUnHGZyyiwteJhavHkQdCXkKhxwmQfcThyDpxgfnomFgikXFIuvPRKLoOSpAesXwVINeIbiWEGUKJRTTEokBFaFwvpJYN",
		@"yQQkbfuMZPEBlZJJIPsXbMoIURXephCoGyfOJYRKcEuPaZGkJpUzcovxhqndNfpzpBfloyhcaQEXulrsuditVlLQyRRsuULQMdxtfxMsveJiXxGUeYzMulpCodjNwBEohGvZVOMEGxcrCnpziMr",
		@"sOVIBDxBXlpjtarEMKFCYTjiRKJkQMDBfiFCpXOokmGerZflQEMdTImMLFTDqkHCUYXjwKALrRIUGvdGPKayrMYJfhVlHrfTmgkAHYvyprQNaprooMW",
		@"HrxlasgrCRHgUlpUXTrGsxbYfiNuMRldpBAJIlArfZbkdLKtcaFhjjzKoJxLFhPizFZzwJucfPEPLGHRkFdIyYosFfuDLcPqhxTNXqSNpcDJpYzieIUKhUPoqzpMIdaLFWqDvCl",
		@"otJcGTPRKbPEfMktaodjjvUsQpHISHlfPQKsmsRMeQrbGKhJWfyyTynWjUkhvCmhcPDUlcvYptEDjeAwDwiFaZvlrHROdAwKUzaKrpMHWPMfJIPoYGHLWPgwj",
		@"uykMWotWcxAJvdEsAVbziTYiXZSATZfrvcTAgeInlEmAGYUCEMFvfGzaDSRyPYllRXfHAFzZhKbcsmawRZJwrZjfGZWYYkbKUCrMtWxZhsZunSD",
		@"feFwukfUHSbPHXHDQjbvqDSAvNTRNEmwUqxTmUCBPPfeWVMzEVsluIOfsEmVjVEcKPCKUSfeHkkPVoNOxuQEQGqGfkLgTyqFqjLhPlnvLFpWXkvND",
	];
	return AtKCnieWpiTNWD;
}

- (nonnull UIImage *)YPxgUnMcZrgknwBVe :(nonnull NSDictionary *)rMnqAIjwtD :(nonnull UIImage *)dDSZkVpWrlnlWpyh {
	NSData *SeUzwDUUkmideeXYUrM = [@"BuzyIMDJBsUbRWrBwfjIclbzUZUMaNKFPMEyuNPgAalRQSSXgHLXStEAyLlmCVKzVbGEsRVAaOHrBVFrClLohcqwiHZdkXIqhdxB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *azeYVHaBfEBpfrXzwU = [UIImage imageWithData:SeUzwDUUkmideeXYUrM];
	azeYVHaBfEBpfrXzwU = [UIImage imageNamed:@"XkSOQvXvzhDgXKZwVxFinkTJLSWftIUuTaKLwsIFKsfJMlelxRvskMCHwUeYDrKzzpjjAHZqvjhxhWbeEhaXzjbFKYevKhKjAwcDreATNIdNfTsFyZOigwsQwlevyKDlCtemCMuIcKcXbOMZquQz"];
	return azeYVHaBfEBpfrXzwU;
}

+ (nonnull NSDictionary *)MYvHiNZlNbWSCBE :(nonnull NSData *)xnpSvnfIAwxHwNs :(nonnull NSData *)pBUUYoYsSoyvqU :(nonnull NSData *)mOlRoWysqJJgZudZe {
	NSDictionary *xYPQuhWmuyKYbZpNnC = @{
		@"KKdBSIKMTGjDRskKhW": @"qnUzaIdqmqQpHEFWEIBMMXZTNQjaaiGiMlJgUEGcGczraatkefKMHAxTKquPUSTwFYmtHcRQCSkowcDeHvoJFkIkfFpWuagqDUblpJUkyLfgDuyQrMtcsWBMHfYIwjyqevxlkMdLANjgYdH",
		@"eNLpIWxefkoeXppvYt": @"RvrAZoZzNABmTpREyHdAVJdqYxtPfaaJsrkMWjforOBZhsrWPuVcyceGwcbBeRRrsphLDuDrgVIfVQnkzxjEAoNOEuTQnBrblbwgsquzOsEqQhilKrtruAmTYnccWqx",
		@"LztJGzVJuTtuqvTldma": @"wcoWjkibWdEhnXgCGnBdWiyAjgSjNPyGfynTvupXuxJTFMLGlPafpAqduBsnuSGKZouuUhZIOIOpJyHDjmhaWDTfUvIKnwfpKmEYFsAALjKYfLwGzFKIvOgHNKPX",
		@"QDxsZaTaVTCnaFUSCN": @"ARptKMgIaUqSYlnlVLYKhPxIPQgOSGvgbkSjmoBBqnTQbFQGFSRuQxjpaXcDVucoYQXROgDKVQRLWFSGOLXegffOdUaGqrsUnLtqgiKlCoZLNXyqxgyVZxaK",
		@"DxOnSXqsYNGSVHH": @"uvbxXFwqccmUeTthoFCqdqjxIZpoMiFoOlHaqmlBYbnbBIqlufBaGIjxvaQBisqvIACzppNReMfksXiuXaSwDkQfAjchGCreeVxtthMsidhsvOycN",
		@"yarJGKqPDislafDrS": @"liUSeELAWETxXZySaLqSnZBCmncglHgFeIDiaQZkViFBsIiiLPfjBlqEApdHEtQnyZFFxQrjGUUJpDTVNwafUNxKoqaWUspcdwiCRiEcWv",
		@"kyAOvxytOTaXTuNZjzq": @"soYNLdfUhPhqWGyDIJhvuQPenlkFCILPONSmYKtTdpkSXKHPLezBbkUjDCGDYRnSYUJSmZxNmEeHDwmkuRmbyoWLWjZnGIHGhZTf",
		@"ztjXrxqcvdCiYcKuTCi": @"HfCgfFbUEASpFTHQWCxjFmcDfLcZMUPeTlglkzObONKtfXrDnrKBdAmKqPuxYBQHMCdtTBefaTmqzzrGDdfmOPopNrVdiZIbUpRu",
		@"hhVGjtmcqpcJKj": @"FQtJdhfDzpCOGVDETznnMBXQNzFLUKcvHFYTCXQDhqDWnwxPjUIYTsmgfzoSWonfRdsMvzYYAJqeIUyKGMFrXfvngGUCDJTKGUZFFCsqdrIjmRtqWpqmEvVysqwQlWdrmugCUcbDwPMmhnYOcw",
		@"WgLiWhNTJq": @"FprGDduOpiDnRXpaHXEUhLmqSGuORrVjiQevOgyVjCIKIrvSRpyHYtNTIPWPcnsexbrFLogEgGZxZtzTgUqVtEzXoDNmKmCFSNJPTdXh",
		@"NbZpwgNCuhMX": @"UOOtYtzXONieNvVCzagyLSTiKtiSeLUyRniZLOtZGgMDpselGwmKyMXvTTwpgNUGpREltSPJtqNwqqyeybMLSCqcaHzwQACgpLIopmsgYrCEnpOicWCEzgloxlxsjLJdrnrScrOchygBsNIELKFX",
		@"feXbNfbTKHXWtEOA": @"HCHNqnqsadlsrYyOXovqqCmiPzfKoJOtBHlajwlWtxKXHvSSSeAEYebFMKfIHSGFKllBvSYowbZIfpgWhCqNMXfvzdaDhCLbZUXIMtnAwnGLNbtIKsAAgfxPidjjgTbnUKPNOeYDRPqKAq",
		@"CunzOEQSRxV": @"dJRwWLdNlbkGLCFsLCYmBxTulBvHBlaATPDbjjfWeHKBhNmSuSzvRGHfUKtcOKYQuHTjqjtciDFXRuYJDioOYAqxaLLiAvbkmkPYBmHLzmMqHeGIfUDuC",
		@"ElGtxrXjpRrEY": @"rsxtfGCkLwjdpXLvLvBQUSHCdGLokDMNxAtrZEfQRlDZCwheTPNZDvrgXaZpzpRfrQDQlQgcVgTsBJkVjKgBAfAKYeUFiyMVJwKoqYflQetGMRurKcxOnoZhdnvF",
		@"npfSygKXEbi": @"NxCpQXrPoOpofexmmCvQUInrUaObLYvcVbbwlakcLBJrQvflFhhtCWUggVWxzIaGpUBWyOjtYuZygTWoiPEGnRoPbeFdgElbibTLTbiOKRyuknjtV",
		@"XXCdGshFar": @"pHMUratQHtEjuFGTJEnQUmidDwOiTdkyGMjzPTxzmnmpXvDUmFLVjDZPpYvktPxTmMEeAHsmhTafGepFLOzPEvcsLTzLUTkZDpHe",
		@"ssnpAFBeRpR": @"CpqOWtuGlBODHLIqKhdRpNNMrQVuggpqNnpTqrvyMSpevnHCBccyFIVcrTjSYzHGBUHfohppwqSTeIfTdOCQypIFJiPVozXhCEwbgs",
	};
	return xYPQuhWmuyKYbZpNnC;
}

- (nonnull UIImage *)mzJFAwvfVXeZ :(nonnull NSData *)UkeBUKwOfWqGQ :(nonnull UIImage *)ABeQpYkxsSkrVsKIYWq :(nonnull NSArray *)HHAEBfpbEVEQUUXbM {
	NSData *rmqryNUmkWqgKFneoq = [@"rquQULzGaqdZTcGILegAiyiQtoRMShnGGKiKnkjbVAecTsLkTebYcSKPwqRqyJBglzmVDmcqBmBiPfGKQZRFngqfPslrjWeplZxiqeseIWnyWexJwAnYglqSlUNm" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *AiBGwIqcwocK = [UIImage imageWithData:rmqryNUmkWqgKFneoq];
	AiBGwIqcwocK = [UIImage imageNamed:@"iHUTWDHzeXlLMgdcaCZpJeJupAFpXRRUpueStsFSbfqLsDGplnWSZPWGLDNncnDQkcuxwmDwsIIvPnbDKPQRqogEpPICzvczjlEqAxLTMYEwifXrCUqlJlMpkbxAuuGmWjDcFpADpExVTZouNuRL"];
	return AiBGwIqcwocK;
}

+ (nonnull NSString *)nSrhjzFWrfsEvvkobS :(nonnull NSDictionary *)ubzQvWDABaknnY :(nonnull NSArray *)fctPetbiDlhRaetfzNv :(nonnull NSDictionary *)ELBjPdnDWlrkOtrGGH {
	NSString *kmiwYJdrsoO = @"lvycaVbEqodrFjajBHbGGaoeJhNHWiXThlDSjfXGDkxOrTngrKPSqdCtDDoxiubCwvtWyDQiVPiSmVWqQPOQFZLHLQRZVHgQiCOZfBxEyEQeMvQAjyQzuQFjCjtmbD";
	return kmiwYJdrsoO;
}

+ (nonnull NSString *)OnJKgPJNFtPqaEIJtdi :(nonnull NSString *)bzfYYHKzphm {
	NSString *gbQtCeioTVyzg = @"LeOuPwAZkiIHCLgCWxpEXTnicxqWYCnHQayPHgvTeeGWjPGpfrbIiFJHbMiMxTYfsELeqjDZeksHFAXlfVViqlOIvySjoTrottcF";
	return gbQtCeioTVyzg;
}

+ (nonnull NSData *)vtgRVnwUDWewdzzW :(nonnull NSString *)GyQfjKNZmmuZ :(nonnull NSData *)fBwpOMthMhRL :(nonnull NSArray *)LngcNUdwHszD {
	NSData *IcYuvTyJsrK = [@"ItKjoJRrGNmQPZbqTtgXBmoETijdOsqaYgvNAtaAVwaVgdSsQDLKtdiEpuyGCdovweXvIdrXJoMObyOwrVyLqPLSHxQypPCPDOlFPkXYXdIlNaKgVulBCTBysqVQJmQAROs" dataUsingEncoding:NSUTF8StringEncoding];
	return IcYuvTyJsrK;
}

- (nonnull UIImage *)HRArrAkYigL :(nonnull UIImage *)oWWAULReMdiTWGk :(nonnull NSData *)UsMjGiRpoqUpK :(nonnull NSArray *)bReMjBVEIqiCToRw {
	NSData *sovWfpFWatBcDidk = [@"JdomndxKLiHhsHlomybFOMlyvmgbhaswBGphRuoerIGaeuRZeYbzboKxMnVdlabFCxBHxEsTyUYPhrRFFyEUEoOfuuljHIndFYZHVmFSpNuLnUkHiQJsRYZQQTlbY" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *RTtYvsuinNfEnOt = [UIImage imageWithData:sovWfpFWatBcDidk];
	RTtYvsuinNfEnOt = [UIImage imageNamed:@"EXmCJZnfYoWWBJsLfeyFnUGMMasCRumVIgFgNIAhwTailfIoHPoaqtbpAuHypXZPaKaRKXhUuEXaCQztIvpZltbVNqMrgDDGHdYrQKeBqVE"];
	return RTtYvsuinNfEnOt;
}

- (nonnull NSData *)rfQrYbZLkj :(nonnull NSString *)jLFCPXABSHFok :(nonnull NSDictionary *)RNGSjjIdSgXMvl {
	NSData *kQbegkPnpiBuiYZt = [@"lzVTkYpJFdcjfUOcWSbspweEHhBcSKGbKFJwPlWsmBssEoGzbbuINUZIcdMJCcbpbQYpYGAWKBDaFtTAHftYUcUuZZoxxlxOtpBKtzJdVmBnRUHjutuNkMGcMgtqbNBLxQyQtdrNDA" dataUsingEncoding:NSUTF8StringEncoding];
	return kQbegkPnpiBuiYZt;
}

+ (nonnull NSData *)gVTVpqpuYF :(nonnull NSDictionary *)PeSCcJQcwTvnepvZM :(nonnull NSString *)ogqWAKVhXHJcytykH {
	NSData *ILLHiVgCyphySbE = [@"EftfAvBsiyrOQlSLabBVFIofsEPxrGxrnJQTKMHBtpVCcLKKyZDTnhPBBTZgwaVdeRvluLSAQXFVihSBISOaJvCVMMuoOrrzXskuwECxHVeooDrmVFcbMfAtRenxuFqNtelksRqpstrfeHC" dataUsingEncoding:NSUTF8StringEncoding];
	return ILLHiVgCyphySbE;
}

- (nonnull NSArray *)eesfHgfvPcDpSPHdnvN :(nonnull NSDictionary *)SNWsQjbNNdUHPDzAzq {
	NSArray *UfDFFpfKHCv = @[
		@"AXpERvxcELZHZiMzzpYxIILOJLVGHmOLTYQrcQJvYYjaGNhrdHTkBjdhzPHgWHHWEVYXXADneBfLkutpBRNuemydyCfSOtbbJyJxSpzUkYMqyVtQkBZEDnStDvhFnuzAQuydNNjRSvZIMFF",
		@"CbXLeDjoBwEcqtHYrqvnQSypjoxQPTAQdrFCZALiRnZiGovEVuaUZcOUXXoCEHbnBzMrpUiheKjiyEJVxOyAtTxRUPuGOYIZNELfpesUnMYwUoAuXponrgvyLVnShSfivhbkkQDqsEfEthI",
		@"zifqxwhObIJFMXFzkeebPPWInJNaHOGpOFqtibWDyqtnMcHohbyaHDKdPNoKRKiOYXSVHLilVzSZHIFTqiWYUkIUwoEzGhglLkyaDtiVbvvEkZDLytmKM",
		@"QAFhXpnhNWGCNeLQzxGoBIfDtKAIWtSfMBMocsBrNPTbbCvLhUufAkstrAPfaRtbkCIUhMtrQmXSeLTbpFUZDDASOSumhiZFnuxtELPPtasUUoCNwGOeVCGzq",
		@"ldpclLUKZwBhtjLIyQEdQiDkYQJvjudBWsjhrZkdNYrjyHOhkirSraVfQEmakFZxqYMGNtqsifuNvGKJqcaLUjNvVfCpeMpevTiyxKzjCTKHyEjfNHSUYApFISWVJGoqSApVKBe",
		@"wCqyxzNBgZGRMFyiOVqzabyriLDSyZyNlxyXtrHNQngCxKZEWxiSRUuuOplqlbORogogtpBAkSkokedaZZOQyawyAyybWofoaETouFrwaBtPvcrBbOMrVCssWErNMFYOhRPu",
		@"jtrFFgcVJavVyjLaydvSSVNHoVPElqDIuvbEfchytKYLzgrOQKUMkKXRtbXqVqHQxBTfzIAfExKPWoPcCEfcHzChsPKEJsSsTmWjQkkpWZlpAXQtPcuFLS",
		@"fMAXMyQHOgPNoscjJUkGtihcimkhAubfmrvboQcjhcisoiNQyfiBEJmImvxQxSiHpdCbWvlNskfdwqVTHFCKMDpLKGwAvvelMjaHJmBcvpUixMICGFlpVsjrngpTS",
		@"hjOcssYaiEUiOxipSlIFEhzthWAKFlTTbZSlBhwupUKICwtjdZmVpTAuYGGmuBFdQVlcDnxFumCvYmPyngissUPSDxVaAOfcekeQZfEtdfRtsnNaKThZRjXmBFeCbQKkQwqcl",
		@"DUWWeWsKldmBjQgeVgTvOAGnRutPItfRxfOMlnqWGZuzetVkCZIAuDObazlMQwnLUnAiZrzJhXpDUYPlBXWaFMZuEmIyEohZkONPgAImuSWkbWYPgqJGplwGGsMonAsjnFxDrMo",
		@"RAwsFwsnlkJuAOXJcTwugaRDDUhBeWaKTZafYiaCLNYvFubGQoDbcmMLCLtrtunRRdDzfZHVnJfKJNyjFuDDxQNcRpYfLtvdmSOZoveMtgVQAQJYnvgBBRsQBfhfqOpFu",
	];
	return UfDFFpfKHCv;
}

- (nonnull NSString *)NCOLcScuzddFhCQ :(nonnull NSArray *)TKcbBPjsbCJnSkLpF {
	NSString *hOuiVsvZrLBOWe = @"HiXIKmcTiqJRSlzufIgJRLtTMvcvYyjwmEZfaOQyKbWYPuEWAoGNHgOMaFfHcrelhiWjKqECRGOKGtjRXCgaOVynXyRVKdonovfKhLqaZokrUhebASa";
	return hOuiVsvZrLBOWe;
}

- (nonnull NSString *)tArDgGvLpHHPHUbTF :(nonnull NSDictionary *)DigdOCIuwR :(nonnull NSArray *)PQVNrbcVMIUaZPSQ :(nonnull NSData *)gMYRJMLVPVfdRCDbTj {
	NSString *ehHxazHTNaO = @"kuimMZfaqGmZWYKYsSTnbDMDLOYlAoQtlwpsIMqJAsXaxHMXHmlxfbSsYbmviFIOiCwuuRDNZAhYUPIZbfIJneSyWwCHKIhsGYtvuksERhsolXzIcGvzMpSMVaKqmXi";
	return ehHxazHTNaO;
}

- (nonnull NSData *)LVdMiKvfwvuHeOct :(nonnull NSDictionary *)femwSZOKPjOpqlqNqdt :(nonnull NSDictionary *)ukPtyArBqsnBKLLUpuW :(nonnull UIImage *)AikkNDPXwegefTEFg {
	NSData *mZnXBrDXdnazoX = [@"msBlKToADeMErCChiqmHPFMABCXhkocSfvfzEGCqLdTcjbUPHiGzwmBtNtsMDsCxyyXnElAsalJrQlXjktHetaFaKyzWwSjbACDn" dataUsingEncoding:NSUTF8StringEncoding];
	return mZnXBrDXdnazoX;
}

- (nonnull NSString *)PCMDHWctXNOAx :(nonnull NSArray *)WnqlkechmQPpOEU :(nonnull NSDictionary *)lQuruoNyIeNY {
	NSString *YXXZAoVWiIFOG = @"mTGamoWKIKVeIaMUpcLncJShPmhShgngviodGaxGlumVGdUJDFYhyWRwlXJJoptIVPiOwHUMhsOAwvhiHQWeAtOIvuihSCouJdlfkqdzvmwBKrrmtzlfndyjnptiDTPhtLTsr";
	return YXXZAoVWiIFOG;
}

- (nonnull NSData *)udyQKFIwxTO :(nonnull NSString *)RlrrRkmvEe {
	NSData *ANjZkkBtwYzB = [@"kEypeHWYLaMrzpcmQwYLzCrbkHeFGauHrEcVIFRhDMyIEkAdbVoBuiwmtabzhNRpwLpZgqHInFDNiSriknNqCgqlOQwfpeUkhfRuRcdewnZqsQxkJQbEUnbbzhGin" dataUsingEncoding:NSUTF8StringEncoding];
	return ANjZkkBtwYzB;
}

+ (nonnull UIImage *)EHRuYDXuqeL :(nonnull NSString *)IRfYqFEAcNiYCYrMG :(nonnull NSData *)PcCCavhuDUcqKWBTEp :(nonnull NSString *)tdijJmDSKOJFINuIDOc {
	NSData *SVAuVclzDAj = [@"wbPHGMNKIpYqqsxfHwKrvwBCThXmBsiTAKQHgBDIOJQnhedHmUfMOlqawvytuhRmAwnChKIYeRCpyifFHOKsixrGWvtRmDVNFgbWAVEgaZcosqERlYvBkchurEuLl" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *kIALXbyLzwHKxccSP = [UIImage imageWithData:SVAuVclzDAj];
	kIALXbyLzwHKxccSP = [UIImage imageNamed:@"CDwbmskFGxXuAWysYFXxJdwtkrlPOvklhPrAwjOcprwJuWounCZGkjjiVTVqWfVckCXNAKMRDkNOKyggAXXXfyfGabsdOOIzPICyDeTAZgmixoKNlMZ"];
	return kIALXbyLzwHKxccSP;
}

- (nonnull NSDictionary *)LgzgqyaiBKZCwMpkI :(nonnull NSArray *)ZmTGNQSEauMZihTFrhi :(nonnull NSData *)CgghFKPUXKTDBhuc {
	NSDictionary *uAtUSBUslFuepea = @{
		@"NoJwNwreHvyWQeizAaH": @"LGxdbBrHgFFjHPaeUPbgbnRscTsjteRNjgKThEdsoWcXxGbNLjumxzHhukysKlTgVYhMJQPVxyHnpEiRhGVjPtQQvfJOhyiZykOaceZLGWgUUcixUSTHpBEdUnrIVR",
		@"UZPzRevbCOh": @"SeeOudJYbebDmJSdoMygmUIYWnFQpDWoxMjHCnAvPawKqEZVXoXzCQZShWCwWJATGbmusBjBhwWUxJaibTtmkyvfWVdFxoNUmqxjVXSMdyDKHBObTtYOsRpDkxVtGeiBAjVVQLRpEzPNLVeAHsulx",
		@"DYayDlAXdwX": @"FGxjRQwDNrJDDWFnuJhLilkzSUrVFSyTGNvxwpKjejmoDLIvNVlFUAuoSNuZcQBVMiYFIvQNuhlsmZtgAuNXABwdIJmLWboVwOsYKS",
		@"UNitKFkdIIbNpVjeId": @"XntEOfGqDmUzXMiHpanbMjHOzTSGuSMoCjKSriULpZCYWWpGjMqJBQwgKRDAjbdAgjHBxJjjZuAXdSQcmqQhkLbtelkGWtijoAMQpzExvOwnXkuEFEMcjECyZgRbiDDwYbZDeYpvdvDDrDirbC",
		@"fpdlHgqGxojcAEYdfQ": @"dvusSSQbnrGMPcUIZQOfSYTUvMsboaIzosyBGEbmDNlkLKeMXoUDvlaeatqmHwwVDbgWmGmxnPRBITXuEKfuBVciUSqQosQdxFIYuPnWfDFdakdScJBqrJVblEwJMrfRjfrgyV",
		@"iOsFiPwWSSRD": @"ivEfJUVWBkcScXUJLGWwdYiWQqmvpSQfXXIghqvlSaRiMBAhhPidYHuGGoxLhdgCeVvXuaPRNqyyqMRahnpdnhuoqFevDHXBtZYqlhJBeyr",
		@"XUldOQGHblFbfNvGD": @"DIeaoKzmlrhKbkzyzsxToPvcKClkVjFqRhOzBwWxZzXpVtQBMlkNNEvXaSKYyIonHqFzwRdCETmAkWRNtakjDkSaEUnwAFBGvotw",
		@"JybjRPIMgbFCDHKtcUq": @"MubQKgcigTvXyBKwjrGmwIsMCRfVOixQeRDEDiPZcEMCHYiTBcIZAWMSedlMaRsngEXBJeBPiybLmYQQdobZlfYWNNwCBuLwdIpCoSmlHsXpkhzGKEJsUIeFXORZDUsxGVDMaliOTLVfWw",
		@"ookQfTozvq": @"tmuascWokJJKNhnxUMInqAiCORmwujqGlcUhCjtsIwQWScFiLderiQgkAcKZmlWlQcwJOWpgYcVHXZaNWMEAtpMOXwTDppVumzmICOUgBuCppomsk",
		@"vOeYgvfrFonCEsR": @"dDGspMxMXXPvosWNpQeAyRUtqzwnzvhCoyLHLIxKllJyHnMFrnuzYWnPqMEzrBXpGvFchJpEselpZGtaYIrpxlUzFKbfIuqYFiAwQadNiDFrvcosiYSNzlnBAOujTBgYPCNnGmVrGLAvrGumO",
		@"SzEgzJuViJxXiyjIK": @"KxEUFNQgaRBfzBziJKRCwMkhvuesMFaCCAOcuCqtVsIlpZInPgxkcvTMDdWpogMfkSNMwsYsDSarRPKmWjvCOhjgBKmAgrEJPIlfoMHuvdYTXmIBeeyIEb",
		@"KsanOhnPfJvLUeA": @"ajrDMXLHkaOeYthMvDsiTHclBlXEaJdRABmfOqZPZxrjmSOtbSHQwcbmZYCmCMfgWdFcLITRIwRbpUfuVbTvprVFkPMPFnJshKkmRs",
		@"rPapUHLOLCHfVZBkE": @"nriptQJzyxgyEABPbcgXddpGrpnSPzoyySuvykKmfvFawpvVBGmhtvQQdILIeIvkxNUdVHyNMbIbPMZCsKEnkCGUgTDHuTzqoxOHDOkzyrlasQHIRqYXBHXymMOealQKCtebbstlY",
	};
	return uAtUSBUslFuepea;
}

+ (nonnull NSDictionary *)lRamyZTVpeX :(nonnull NSDictionary *)RPlRoSHzHPbQaqXUd :(nonnull NSArray *)WDhtlkFolIM {
	NSDictionary *tjKWvHOAPURlrFdQ = @{
		@"HVxItxdBrs": @"UkXNddvqdHwivNGXqMBOuzdBPeqySRhFptVGAGEKKVBaNspiDVeWuzBxEAfogUkoQhAXHLUFKWCRAxmrSBjWsonGqNhGJszRqwoqqHqyzsbKTDQZRLNZX",
		@"EIOCtHVFiMr": @"etXnosYwOLDEQykpznOWwOcZKABCzodeNxRLgSwpDHAdPRjWPKVXBPCXCFSPtwJYIhWdaPFzKyJFNpWdGwRCQRqoeChwZSFEWiYOhLQjSvXtGGfyWKiFWNPgRTWkBXLQUbjA",
		@"TltGTCdQOC": @"EsDqhuDCHnkLMIoLhRoeVsqHphzBIUixbCelyhbcIXaAKhBEydvLWdLfmtmMlRygtZggAvVgthdABbPJZCBvWhHWiziqTvEywoLLCzQEvnDJyCptSpCcmfnwQiSbVjRYDOnxuHhvsHvokgaLfHZYM",
		@"NKQKwONRElpqXQp": @"NmVbWQhNZIVxjYQpriTcvPzqIJfRJuWDzoEkyXnkUNcsOqvXeYwRfqsIIePbffDSBOoEcfKESmtvjaTsiASPvDMyDXBgDwRDIsjvPTMcoknEBULckSBxWVlLACJejELOcZZynbsIP",
		@"rNgyBPSAQbCdFdEYOPn": @"IwabYGuLinoJYWTsrTJJmVlyQDACdCushqyIEOYtKWrDHXJtfDvDHGsHAFHOvLCDmOWjHLwylztQMQnPadSnsvWAOsFCISUFTVVSdZroHVQGNdrmj",
		@"jwxACtIofozijc": @"tqRWgxIWdMPbNvbbQBmKlHyxIxGzHACXdugHwtjZllVXSVQXaqkndOEJaroVEvQTHYgEkrsKRKZPRvukdjFPDBwOMtKnrGlFXkZXiGhtoKp",
		@"cySxbTWIoMg": @"tEoHUeafENTdbFqgyynfZinxvivtkJXiTvjWpImsUmNfZGRPMRvSujKlsNmbBsTdKUPXZqzgAYnFjxwJoUkwYyGgmpFFOwnWKnEwdPylhHfMRHH",
		@"qeDjvfbkihbAGHPg": @"ivLmrwrJGOnvXtuIDzzwRdJdJkecPXhLeSdMyIhjUVdScuYXVfwBonMojmLjatvZjyZYjdbGRnGxHYwCytiXqdgnKVeHqLSBbAjVZVJZnPkFNvbGrTqIzOoWnxWY",
		@"xrjtjnnofNqyQ": @"NwjWqqzpLkPIjmTBOFKpZacVChaYEgOTciwyYsxisdrOJhUDnUZrrlzLYLtCUDqBGArrEiRRhovayjTEXmPiZtZRhjnjDSxVgxPWKsgpropKDJn",
		@"eoPapYGvpcVaV": @"BuIRwEGomtDqjSrEuoEiyBDcoDyrOhWoTRJKbcxKqwISSzhnNwxSvpmICfjBfLfFoGueLfAoyUoeLCVnaHWFXwFdpbihTvKxZOICeHOkFKTCUTIexdvQhtEPQLdOMxaowdXCuHLu",
		@"QKmKLzsNye": @"LazZjcUbkfTfRvzsXjffKeYnONZzOkguAzJuGmyAJPXLDCPNuMOkvmzUWNejjoqoDJxvmIIaRJktRuOzEvSMepvWTmghjVGuqZhHcPNdnEoSWioTJlZsEvUJVRSkBrzfDQqmMSmjfKubrgnOnQUzv",
		@"hskWoseMOivxbKsMDt": @"eajUoNXlMgShaVCrggZbkiaqPvkEMzlwnNRkXAUjxrpyyljESzeVQxUUANunlccNyyQjtTTmctdbnNDlgRawbdTZMseNKhYRGEaBpXXMaIRCGDGbgqDQAWoM",
		@"uVcsGHbZMvJuxxzb": @"LGXDyMcBHNKtGDUArpvzuAEDqEJvvpqELIMxCcvLwzFipreGAVdBkLhFdyHxdUzULANizwBfpsQHfbSzMALuAgVUjmZShyJwKGHcPoAiPAGpGAHSqYCvYcTJfrvwHFtgTVIxf",
		@"BNSAhbFdRpZyinzUKL": @"jvUJRpGCOOpdzQLYQvTqXfWiEioFrwDjrtGZUtttqkyozzRZuUhAZFePLNwkGBcPgMVAwwSZuqrgMkTdUMmhumSDOeqboCfYjMrWVMfzx",
		@"KYrDeLOUGsMWkfP": @"PITTAVwdGRhTNEDLzofXmmxRxqusemQNdpmpkRJJWsesTjxLXrfthJlcRmfZajoPfmFeZrCXbzxuuzDUOMGAifuRcyNRChjEGbLbEYEHakdnTJxckBqaxhSvVjtDjs",
		@"WtmDOBdvHfZVpRzXkkE": @"JyuUrqhNoOePoqRtaoAwXFulqjoLwJPLiVVEohTjrNmKlTaKPcKxTDggaDFWvIqFAYnYDhjRvJBnBjlTSjmabflqGoEqDHfBPxcNMUuDdnzx",
		@"hWryFfilETL": @"TprRTsStrVCaKVvYiFwzGpSBvzZwPspFnJRyrTqvpgmOWERxAdUTAWDYuxLCDrrQQJjydnEuroFEQXKSaoRmpFbvewaoPfLdjIQK",
		@"IHkBTDTVlhMXfhAtnCL": @"kRDdMGzZXnjMfvpncYSFlvZCzrMvjUCamRPkBMaZAQWcFjUgamXVYibYLBciqaFtekwXUANxIWVUfplauWpMRWXNRYPDumqXpIzQFZYwSoqd",
	};
	return tjKWvHOAPURlrFdQ;
}

+ (nonnull NSDictionary *)MaICmCJhtVgJr :(nonnull NSArray *)klXPsHcewbhQKZsvUz {
	NSDictionary *EsaLKfUWAQBd = @{
		@"ewLfZwLMrecVSFXem": @"uDUNtJeSZSZEoatOjvBizpRfOcOMlSmbIlzupfszZwNxhaPGxTBnYxRiMaAAzzfQoCpTBxFoIzzGPVTEOthKDOkQXOTrBejsxBQxeLxHuSi",
		@"FJYgUhECsONa": @"bsPYRuyhazjFkqeNVKVquGNMwIXTINGgRwLFhJCjBCOoeJOVoeFZzGuDadisiIiKoaGuWSNTIgZFITLbTtvwvExFSEzLbDiPvTXNdHYzIotPnyehefMLOkHzoqwGyh",
		@"MdeEFoGoUkRRyHgAAzb": @"tLYzfJQnJTJJFQtLqGoavtLchTUSWVFBuzASgkSYRVGWXpBRjsPYQRAJIuZwcjNIGYwFvYtzHVNNaLEwOuXufkzazLcJhyaXiDCwnTtXfEjuNmrYEdBwUanSSjUjSbXIKVqQoeJ",
		@"MTbOBXYwZthsDAAvLA": @"eaKaFdgxfaxVAZoMhGIzaRRuNjiWPyliaGQPzxDzSTHnBXGovujWRiSfbWvweaNXLnSsXlpYvPUNPpRbGWQcNqaFQwcWXypORLaANmhjOfJCesHyJOtYMIUmaaPjpxJahZyakqOkvocbceDEhky",
		@"RbbRIpdvSnbrXUPJWo": @"giRGHeGqDpjXUytshGRwpXHYQsOTOrzotdPFajzQRYgIFTVgyQzvSuIVDKeRfQAQIWvPPcALHQUlPNEQuUzeLPJHtslmSVSwHuAAALXqWuIsvHKbzyucLwIdpmv",
		@"ERmVdAUedHoUTmX": @"PldMzIkQXCAvZqKrbhWXKCephZKwDKwEnCzpkjhrMBhOgSKVFpOgvDTpEkBzdJkVDwEzyetlTftkDIjNiVwCkyUkidTuuThHSfpNLhGUnOZXSBZSp",
		@"EejDctpTKRGgfx": @"ylVnLgUUvlIEeDxAYaFgUknYaznvylvKLjGNmAHFLcMLBGJUNRrBJxKAOaePGXSqvunlvIJunBlTufOkjYMUXLfSLqGwKLthcVdreAMcFdKFgvPHVckqE",
		@"kNTCLJuDIKSpSHPHK": @"afsNVvSqovqcjNoqmzZNdyCnEcoizWoblhTuPFYHcCjTkptgKlLePVqszdFxBnXwZzVLqidakLyhAZAKBRjjeHUtvCzylbdYOTnIEL",
		@"BPBZnoDCreHqDXfiOwB": @"drLCtGcNzPUryjhexgLBFuGXqDPZvKTSwhExevDGVpRLIlDVsdGopuXFauaZzqoviaxvCKSqpkisZDKHkPcqPBCXAXGgDczKCAOhkbQzxCnXjavBUDwipbLNItrlPYSnPawkrAfNdsZsQngcqq",
		@"DKESNEUnSaMQbgx": @"XNBpKlebtAkVqRChrElOzOkFEkRyooBEIJHgphhSWIxRjrhEEPoPmknjwgbrWXFroqbyVnSvMhPmTnnitpeTuKwDDKokohBIaGeZOAFPqeXaNsdTKOAnEVgvfRNOWPOVuI",
	};
	return EsaLKfUWAQBd;
}

- (nonnull NSArray *)IIExdZnLVAN :(nonnull NSData *)IaDKiCIsicGH :(nonnull NSDictionary *)sEqYHrWezdYB {
	NSArray *LElSUzEZOh = @[
		@"iTTHoCIaLZqHobSwOtERTMLFCWFJmalnsnHNfmBJtOZHbVthIZPnOezlTyypUvtohmfOZxqTDKpGUOAaUYLIpvvEcxBCfgzZuynwqrDaAxaZiGbEpUMAA",
		@"vElHrVBwYzaEDGOOxehKnSBfbCXuMMfMswBPOwZlFfCHuMnSikjnVYDxvzTeyRJaiBvyWxBojuAmxrvmMmqanOJwzubfhZbzOxRbhBHrjoQWjhAQbkUjSPfeBcPwrSovR",
		@"WJeYpFnHCbuFrYIONxvJSczVQtOFkOGsXXygqdmMKGfYXtlzgTrSsigZBXGRxJQOrCwqyIHbeJuiUjgiqhmLCkMMwzizbMNEeOCjPSTnGSZdvkzuyNyXol",
		@"RhmThDwgxtuYOLQnBVzTjNWTBUNWsDYwYZWscUVEBscNrWIAKOlTvQCuNWFhLIruqTUIENwLUPKCUwiKepnevkiaiEGdbGyYqwIbqTOQcvloQqgOKsmdXzDxLnfSTgkZBwSZmR",
		@"LYWRQqRwKhNjFTEzrNCuKlFObggpTpTqLNEYjMVwBZsZiutXKfFNErBVUloVbmshAwHwjzOcmsWbFjUilfcFZpqUzfvCLWrzYnyAhVHnQhnukUMwwzqMSwtWqIUkkikXtfizQPpGSzHFnOyWt",
		@"bWZKlbQHFDdhcJMckPzMJflyWbTbwtOFFTCpzJvqdwuJPAITrtPkjdojZiRYpwdOsyplgBcFmDDskmOfRGZKHpeJLJodOthDlwkYkDPiBaptcREhVqvUyjgcvlqlWLadLihIEdeCQnpSbignOmP",
		@"BEXyVOAGVhxoezaCPjoATFVQCnHMMdIjCNUwumbEeAnWOjSyKPvllGiwOUbLgHYWDdnzvOSNQbIcPzzHLPWfGoVqWmNUEkvDXWfnuHBsNQXOZlGsLlojiQiFKiuTQaZgtWxtItwLiCWSisk",
		@"sGILleUSkhKBnkTJnVooEYfGNbNVfIXMCdSuPwfhGAycTTQhNQsIFOtStLCjVtCGBiJAzgJaPsxIgtJnYyTvFInipbuaJZJkfmTeKDtZqreAQOedetkeLjfNt",
		@"QjTTzPkmLzMudtxmqPIvrzWjtzoXxzBFTYZMcFzMRAYqVrQvBvOeANzirjZPNaQbLSRyMPqCkKCsdKUFfBcMoGyrqeZDWCCbLTfMaxOefCHYycRYaVGCxlICMWr",
		@"OJNPCOrUMuouQqtnDfemblTbPFBgIycNvpUxTeZIlxcuCOpJfCXjVfwhuGZAamrLRtbjDuMDgRThCpIHhkoNTystFsyRQlihwSstOLqpYtACFjrYUFKzmCrVjIzOzrtCGoyR",
		@"ytVjOanGcrHsgVSSCYkndWXzNjuXWBGieOkvpRMqHIgLjcPAjLoqNPAIBeIqMifWVnFIjrqRORaDjcyvwCHXHYfWcHpFFEUxpUKLnAkUYuLKprGXMlEVhreYSMMLBZQhrCyUGbJUekNUDHftyXAS",
		@"VtMrKkakKOxiZvPwDNFAQodqjoZElQRgAdemlligMrnVoJtaVSqWzVEeXZxRdRkPRATLHkvCRdIGaynRMeCDRVFgJnqMblBWgHKGyBUVJGTyAiRTbRPhiLCLDOad",
		@"HcKynAODLGBYoGaxjsnVTzigXULOcCTMawjihKSHwcJxRKILRJyUBtTvIEUrzMvxBrOQJFxItfGBEJsPSSSzwMYaZGukFkIaNVEAJRWRohD",
		@"TxFqpetjKGwoiNrAnrzjHbCEMmhpXRvkKYLlWUXuihhOydQeneGzAxObIlshfesVHpcukmpvmMYPnsoIkSAkqAglilqaodukupYAkYRghYWOYEOprqfueQyHdWqMzZa",
		@"PdIAjqJiraggFZxjMqvRnGlViGXNWSKrVhSSFviAeEQByhjcBcPcTSJZHahzolmOoyScNjEXVcJoICLhKAPjiolOBUxAPSTMwJWNeKAOchjrmCnndOAFNyZtICxuPORcqLfqXbqLQFKCGTTPC",
		@"VsdQKhqSwhLftjJnsPckSUqpNXtLPQGOEpcbObfzGDFDPFKdpMJhbCsxqvPxzirOAqBsyZnFFeRcwEReEVyarzIxInnhnPpOUPHbxtVjDGIFwmvcIQRFNudApa",
		@"aesApjVgREIUzISnbMVVpSvicpUHRtykruwqcTldxeVwCiJoEceaKTDJBbfTkHhnalVfyhELXDOwqbLJKLerkmYkXaqZEUZyzXVeLfKYhEmqRXeTNnlyRNJqBbXIlOsNCALmWexotXP",
	];
	return LElSUzEZOh;
}

+ (nonnull NSData *)IbXYKZXWwxvuCRE :(nonnull NSDictionary *)WjnrBNJbmpMYjMNg {
	NSData *HnzLjRgIWumoAmof = [@"RBVlSwBQtJFmNcNWdWkvrOTXpMNBVEqLFbPxaLEZwlHwaJIMLQKzCnnvzKRjDNYKHXAlzRgoorXOdDZtytiFesIjPsURTTKjIzHIPUxU" dataUsingEncoding:NSUTF8StringEncoding];
	return HnzLjRgIWumoAmof;
}

- (nonnull NSDictionary *)HavIgUrsienDP :(nonnull NSString *)vjuFoijQPYnxQ :(nonnull NSString *)UNHRchZeYdAENwQqr :(nonnull NSDictionary *)ftmCGvUPuzkTNrwwdD {
	NSDictionary *aMLZdYsqXRi = @{
		@"mnRTsJXYhwbdklrzOH": @"mTxnYEujynmjSUlOGfRZbkvptIqmksVZbphofGTRUkgaYEQfXaoKKEKJRCOWysmikrdwAHELcfLiFaOdDsZBUbpBGpQvXxWsZOkCnSpRYtlJDHIubgJbWJx",
		@"sjWLLYEPyEqlKV": @"EfxciHKduaLfaAcyGylItxMTaOvzQeKmpSSmMtOzHTZquYKzaiohfcVyhxOIvxSLcPdxoUGtQGbiGcovWgPSWIGHZOAIVsDdenEafXYjEnTpSgxdMKbaEzWNOCdJkabuuIVdfFBihOfaVeZG",
		@"bcfztvtDbMVLxTjWGZI": @"DZcZCkdzAoQQXZfJXEVSoUZWNUiNrEGPIXsaVUbQIqoDJwopMojSzrXuBeFBLMKqYLxorjoaJTkycwFJwwMNgHbzZnLlEVGdMONg",
		@"wZVuhDVVXIHGbjjm": @"bkOrncPSAwwTWFNMMJxpUxfdPvoJyeWOTfGrzbTUlUANzHXhbhKgnwBFGlazsNSAijAbpxCTNlznvbYLxcekdsDVdOQjtyumsoksObzjplrPkYVDrjVKijgOaQWpCQyNbcUjgybbvu",
		@"YKKUrTAfQfJNDR": @"aUzmqnQztQlbZFZjjpgrrPZscSrlzNciglvJWIZlrzOEPwmWxDvQXvarnUkVtiFMxOCfHDexpkwpzFhCUfLrDPUiKGSlQdJEzSNgEmbZUCMUKcBuYLOhMdOGBobrkGrbyEdQF",
		@"cUSbXWBTOlh": @"ekcjHoGtZtlOoCYGNLOyyNIiCGXbEokEmUlAorYEXtFNbyaugWveomnKSFfuwRVxxjTswKBmVMTfyBpqhKJEmJmhhPNMoHTYboDNrgNBoNkfKW",
		@"VTqcamAqPTemUZilJS": @"pqbRCHeeOZzAZAktjYElqbirdaMenZvcCeznjxTDMxKDUGznOHlCHTnPhWCyabtklTmGGEUEfWIaNYfywWyiWlrIpJGzzWSOzJkoByIcrvujMFtZQuXsZgYTTftFpAPuaEQeocwUc",
		@"GTYKZkRSoparxtvG": @"NmhFViTynDloaUZqQPWZgNEAZXsdooAoOgJNQIBBVIzisliRCjwBaqYkeyxXYhfzEXilGMnTmnxdRbaFxvTbhmtnEMLKvxfkIcnwIKBUfFcDrwdaAhoYSeIIppUsaAAIJrzEdkyqcPK",
		@"OjKUgiQLnyKDwzqLm": @"RUySaxAgqhfzVmurGPNxIeLpJPKBdgmtMWAKmDMFSVRGLbhNRGikpibLBKOdOLENHbavfsLYILampHGeLpFsjyCnvwPDBWGcLKbtT",
		@"xrCbHbVpdjVsJBgNx": @"UyJRFPOLSFQWGwMzKqadAtmXiwckjXWunBpRYJoesHudJiNjHYwRiPvXzYpjGdedZhwIdQhuVCNdyzSXJMmPZdmubotaLuSgLVxAwdoNb",
		@"NmdEkiiqcFYzjkIUga": @"SjFtbltXCOvUqGZxcBTYuHQHLAqbTeIebXucRRUfIyEuBwaGnHvcrUYTnBaLVxwJyKhXUwsUYTNlwGGrbyIUgQwpiZKjpzWrKUeWovyFjulkgtMbMNNFeLzeFe",
		@"EnEaFzZtaOtju": @"aXtvUyPTfelDTDleQXdQjFGHkdfKTdyJWZHwpwBlhFeFiJiokNoJSARimZuebFMejfmXNXYGgMmrkAakHitiNxMOBVmdiwNgppSANMJWRploilKEXycZllbJjAAZWzhCpDxxXkqSzzIfsDtVFR",
		@"CsuTezembQId": @"liliNEGMpOmkGGZFoWDpvWOkaNFXlcrUenLQuHHMpdDapWgNcspYcTvytTKuiIdmUuuZSCgJXQMKAFCYDEyDFoFydJlJEUByTwwwvgGOXAQepKJgXvDwOJQzCvVXCsjLwWGhlLLpXyYUickMNOS",
		@"dtZPXgnUhmd": @"APzmHYhyGFYNKQhVrdodaCvsxUErBxRcHNkDJJVlYzyFzcxdarcRAVhrmoNqwmIfNYIDvIXPqPDncLZxDQYAWTVtjZdryKGRoSqZU",
		@"fcLuwUPoOfWwR": @"XJOrSTmyxMlmFfBSqGgAynslwXCaPQqZwErGbKMEMMIylLlJShEJuDHwXJHTGMyjNylhWwsAlwigqiWZhhFxaHjoHYesMandsNCMxNZaGcalLSWVPsbdntHszwOLALlSfapHAyBZCZ",
	};
	return aMLZdYsqXRi;
}

- (nonnull NSDictionary *)coeCVhISxB :(nonnull NSDictionary *)ZPTkVFXzmEGbu :(nonnull UIImage *)kbkhoQbvSDZIznDs :(nonnull NSString *)oSNyOFJRTdg {
	NSDictionary *iXZjnnxvjMZ = @{
		@"sMhxCtqBlfPQj": @"RfOYImatjfVFzhhfGxcpkBMRzkmiPbEvyUWxOzQnvngkxdMSRRIdZxooEVAMNlctdwOnRKJgDRBLReHpMvLeitOkGTZCaJnPXFksvVvHomOKOSdSahKjAJUcMWEGKiSpYyxxTfaUyuRptxeg",
		@"QfKpazwpSfFHtW": @"ScnoppdjulYYjctzOnRlbIBrPPCjUTpiCXDvYLgQZncEoSzuozUIUzYSWSyWglvxddTbPbNlUQIzrhimaAViwDLYFWooSNjYaifwbLIoVCSqPvMt",
		@"SGeAyokUlSUDsTLEhB": @"PsXbbDkwhFedRlmTibUUYdugFlJDLwEtFemtBiRlrCaYSEjVoIvkRPYmYJRyFRViycYexmtmEchcKTeVxjMcJVEJwRbARPRxefITPIEudQAqgBxmaeaWAhuAnnguDHpIarpgyOwcNsbuqDS",
		@"iYWqgvlvDddpt": @"hNDQFCBItAKYpuXobwcoPTprIPzSftBwStgXxDpEMGtPbqODIYcugKASqPSJvgoJwXQyHLIjTdoRJAZIlcWdPIaiabNntGzWLvtrMAaBHVBGXrW",
		@"fjblPpdyvAgz": @"dynVYwOlTpKYdLfePnWWLBboWNGxHDhjmhqbQqeDDgrxvDeNebdTQxxZOpgdXyVcwKcuwoSilcbYmFuOOTsGpynyMZOnNBSUXpNimJf",
		@"HpBABiqVlQy": @"noVPdveyMoGqLtZxoZEIvJMQJToelfevRgFTsgjdNBPmQuNEZnRsasLACEMtKIgnmlGdnmKLdEmTjaHPnYAMyHoTxzAAuluzIZdTshyeQyc",
		@"jpKbSNhzmVQcdypJGMH": @"jPCNCsdihPOnetqyGIbrPkMJfoahFagDEGXWixqasQtpOTifRNwTJHxXAHHdRSNrvVpmFgHzFggqoeNNTcTUiQzRoJqQUlDxvhOUsGDu",
		@"SaIxRxmQWeaYtrZciSV": @"vRmsopUuwyKHgWBKEjdxvZrvelWpPqEaymxoJMZlUAhhFDDxDAJrjgnIjbppiPXYddQRULHuRNsTBiOcYYtWuxZGOnTlXyFUCEDxM",
		@"kznNDqiEVvjLXsGOlRO": @"hQUWYnFsJiewHpJPITlXFABhSBdiJvuyGNSgSpHUImPQTaZPCwGxZygBCKROWIImpTVnjufZLvYxPdUnOlXWiQBfwdXMFgLXsPAgiuWpynZFoBIGwvH",
		@"kjLoZLMVwWgGqTblns": @"tUdiVCARjNrvwydUiwKtgmFiBbQryIuEWZlqhGbnaLlORKgkAZTqtAtDEvAWjNfcpkmbaptYakVfpEvZwPLFjybjCzeDmmiyWPqWQVOabXaIrdRXijrbCnMiPLpRxbAsIesjUpVt",
		@"HBhYAmtIPa": @"JteriuFkMQCOihHpizuwqAlLfvqjGWfiUtjbVWtHVgcsFMjgOsUbFvrImbiKyDcoAGijAixAfXXXDaJyOPIdWWcDuzVbPWMMyuYcDRtQUGSDybfHIMfrqCO",
		@"OsoejCJFYtKfissK": @"rLolouABsFOuEunQRDYzqIBzEQgxiRvlzTkcAPVXoGFxiCJtaZOHCjRDtATCQcHdvffesstFtbbKLfOfHNMBjLKxKUPlhBofFKQSrSipMVab",
		@"ukkwwCPEcu": @"mfmEFnkeNJnEJGBQwOjBRjyETZzHbRacqvaArskNRaxAviYQSSlPUomgcxlxoYiJwxqKbbpJuieEgaUvYKBPxRRNBKFupYgnbmKuXbKekHbQuVPLS",
		@"AEeQHjNrfMDMi": @"RKWRITdKXewLxtnJJEZTYTSjTwlnKNgpMWcNEJHDkWoFgrQiwWTYdgNaOArVWCzhEbwPRrJvelIQtpthILGpNfeiSZPPLLLNmpZVPunbqrxNxKcpgQgsKdjuzdGkZ",
		@"hKHzDleYBYcZfgNGkHW": @"ztEnLmdRCaFdjEfnmSqIwiTrwsWKXlvbNibxFWwjwkATwoDSUctFONEkSMMxKwNXMLSaxDBwWXNybNdcSqTIxrnAxiDOmrjuqpCTOlPTDylXqDTHxCXfpeSYqHvSAjIheJdQp",
		@"CQiIaDOQme": @"tEywNTiaBbFGOzvWEVhDeXSTCWlYuAGydyzfnLdNsKiXdbtCkfOvbzjQhrUJSpheivCJSvxcUfTHSDvfFiXoGJpakXoABkBrCdcEABrOGcDEyXYpTdTOAZbpsLzKlwSsgOrsu",
		@"tIOJpiJdMRsRzDpd": @"FLjlICDUTniKpyAKtlJcDjtdDjphKLwuNDHRfKhqtfGmKAHmRnBVLSnrERqoPZJCQHGHAGSySgeSzIWmHfsebnnqPopjewTZLYtQlU",
		@"tmrdpomqQsTBNv": @"PtWtnnvNMDyeHvsWAZRHqtIplzNOduPppYpmrhMwfLEfjdLZFLXGhYnNayvCzCOgxvkjahoDIcgIVsurVgdzSyGHuhhWhEmITOCYGXOmiJOVJElYhsTLolSnMP",
	};
	return iXZjnnxvjMZ;
}

+ (nonnull UIImage *)ueLFJsaUWXNZbQ :(nonnull NSString *)fpXtHvjuYTlp {
	NSData *bzUaaBXvDZpooaN = [@"IMFhmxzdLzUecwenaXOTkjjfxcpWqNaOUaLjGvUhzTssJCHXCDHhyRkgsTXeFcoiWGwUyeQHFrCPXOcIbsBiDbsVWRdSwBhxFqFSpRbLJGHlBsMtNvUSHapZjufJaVYZeDKFlPIkB" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *brxNOztkmGtX = [UIImage imageWithData:bzUaaBXvDZpooaN];
	brxNOztkmGtX = [UIImage imageNamed:@"EnnuCEbDesXTJdPTgubjqHWbXNtHglmGFXZEnupXMOJejMSYufELEOtDdoCnILlZBVTGzHgvxyDElRsiPnJgHMlrbbBkCQpxNKNulRSopQzFDrVNOudAVTKYKWOjDWHMkxOf"];
	return brxNOztkmGtX;
}

- (nonnull NSString *)wlIkPkNehyFgzSYPnO :(nonnull UIImage *)yqJOxbGucXbSF :(nonnull NSDictionary *)ybcOYkaKotbV :(nonnull NSArray *)JdmfsDXbFVbBIPQcAo {
	NSString *erxsJdkIFQne = @"lWgWNEApjbUHRuoIYNBAGqkzfhqizNeqGeCrYPenKLuTaRRcJIybldTpPEcfiUDeeDszylQrLXOabiCWqrPnaQbQTfyyZNeFwQxvnVLTjtNVlakHNmpvS";
	return erxsJdkIFQne;
}

+ (nonnull NSDictionary *)AQRJaYYrYOgUEwOlMuq :(nonnull NSData *)FbtoeraMptI {
	NSDictionary *HiYFdHfOwbvIPrPyiw = @{
		@"rrvRXdKKsmlcvzWC": @"slDhRCwNyMWVcWhXmuMIHNEwyhJyFOpzimlLlDLtDdzJDTyeYMZCNwaCdghlJsLDoIDWsnLTzaBKfClakFoiZPkdiOFgyKHEXUSOUlRExfHllNhczzxMEHumDskECHPx",
		@"oGcgmabKodLuGD": @"qcMzEHqDcmQwDoliaZSjkBHZmInfiftDxjQYUWTBldPshYOKCGLxtulVWLYviNeksdZxtCrmPCyMhKrAcDbZecXVnxVzsJMSKNJHPwKPewwqeFDZnOtxFouDZIKXkoudYUvgDBObc",
		@"KWuYpBwoIuf": @"wDCxEnzGenNimOMxdUgBjIQahATXyvogDaJAvGddGHhvBjRMoNrSEAIYWiHfzwJgVzfLhxYNdpEvksctQSGMLgJVNBWzCorNanTLEHMzCJYmkorJBCwBOVoDvgKH",
		@"rjIiynFVGSUuQHZGcq": @"vWhzAsVmmLEJMeGqXugQXHzKMnwfIbhRSHSKLCMYdrWXhvQkecORzmJxpGhmMjeZyyZMwEgOsYPrYIXdGZFbDkCejHkZtHxfzkDRrnQVxliJCgRDoVowR",
		@"nbEIWgBCijeeTD": @"XVlKKhZiifdyGLLwJlPdoAbEOtderHqjfxruVpclGxCQhQoRaZYNLoERwXUUcGEcmNgEBBMDJJSppAWDtPIpfbVIjuvErlnENlbufQRMFceuoCqjwZL",
		@"PZAhOYowWNWSVQYURtB": @"TjRWBUpeuyFzwKuEyXpnPXXkBTsDFylcAJQpLWKsZwvgIDCPBXPIXfnbCGfJYUTQbaGyuzsNaKhRtXmoThcmoXlxHyWPXnQPdJAR",
		@"mBcpJCUsktlRXzdg": @"ErTXNZEyOBGORIWbLYvDOzlNAdxNkgtAyEDmdBroVdzkBINmIQJWNdLAcdRMqGcVaURESNfBkUteUhZTDrIlHLUSLDgOQfnPrgqemQryuEeULVSkboVFSheCztoJhMPORdHgLWNWOUbelZ",
		@"tSPDYQgZMjxoGs": @"sOvAOMRsreGOaIuBFQahzGxmFXnIsoVjfaJThtzQbQUexKfYQLXmycRVQCTGMxwGUdqJtsBguzjLploaJBAoWglnThMIUiDDIcrxcQiEemxqzeDuevXiXuHmtqCy",
		@"BQaEsahNPcDBYcuuT": @"OJDWelubGhDixlGASAakMDzwucljHbqyMdKTSZUEOxpZRALbiTAAYRIHfDjCfZhDUXAvIzXTlBKRpuupsqrtLboXxLPdEqwDzdaMimciObpqRqRvSqAKKdOKsN",
		@"BAWBjPZLEPIfRkt": @"pkutQZwzMCONEGzYoqnrluXbqFleTiVAZxSuLGYEaVflTkyCYiEBHTEiWyrLESWqplZpXjdugiBbtwqdJcOwtAZxpnwggJutKojR",
		@"HwBtkCGqEtlfz": @"PlQjUnMGuwJeqphLVGRotszJVqhnhDrnvWVmllyeTWHqnoAkJVQXMClrnDwVWdYinDENopggLcNYGHfcfqkCxlOGVAuesYjQSRKoaMPvHOnZxVmhcyybAwOsRQtKhM",
		@"NqHdekHTVxjqqDJHKBW": @"kSWpxhashSpvrrUtgdPcIFPmhmKVYigYJhXoNxBHKAiHXwTzmtQOBHOwvMuduszvjoesfiEGVQcPAhRmfoIDujzelcYmjpEONtZluEwGLcgNxeDwyKwzqSshlnnNpRpODHwPmHDRrCmtSetGwKj",
		@"lDezIzuGdu": @"vjxwbaGFarmQEkyQTKpGGCidRtQcfHhmjUNeojfFdMCakDIRfaXaoQvwnKSURWdnlasrybjxyZqLnpyxNZOTnXUtPYwMOqUkGHbcBkXnBvZOtqaRTYAHSjmC",
		@"tbtctoruMZYJlFol": @"cfrDqncwEKfaliQxNLarHGqjTzBwuCYrfvMbQbefBolULrLGeVptvxYHrdJCsScmTtDMmWzbjWphiNWdnZLASWEZEyJbRNojfIeuTGNKYZWvZNkmrhC",
		@"xNHraUwgtmukl": @"DUaELxyXGxwPFdxDuuZqpwrixDByhztFxbZaWuftBwAioKJPcBPYwFqABdYvxHLLGiFMpMTppDMzjcpNEZwDZRuYfcTSLEbfKwIzlXjXAnwXioboaaYtg",
		@"BeMfKJJdyNHlKjq": @"DiSihLLaSiTkDZPtWNLKEhtZXqCOtcfxzAwsJUCTMcZkvrPAsVCbQcDDmLIRHrbhelAQmcZcEprNuupqNmpVCDRKwkXPewfLKKInaExkONLKtDKUYtCdfbcSFYxeokvDQeMxUYjyUVWSdSyrfvMwB",
		@"xuNzTYuHQjAylBNnSCa": @"pPghEdSIsBugPqtRcQawEzTGoQelBHZMGgNHqhOqPVgrKFvfxPsLsZjikcQNMzXOYViWhTsorOCFeRdqTepaarbNJCKfxXUgBXLvhwPdbiUcxmRhbrMYuqUEvVzGyIsdoqCenfaWkLkUU",
		@"BoTyYBgrVqhtaxS": @"PRoefzgxxEOqnjMWIusHSfTKRrDrlxsPzaVHAnaWZBdNTVWwBQkAzEdnQnKYVoWBssHfxEZsyGfwVxMBjQcBpGUzoWXssWcdmAmhqbEJNcVenaWtxLkgkTNMuYgHLvbqgrQozQPCjob",
	};
	return HiYFdHfOwbvIPrPyiw;
}

+ (nonnull UIImage *)vWAEMTSHoGr :(nonnull NSArray *)cvYrDSfiDIjdF :(nonnull NSDictionary *)VvrpgontVvL :(nonnull NSString *)xzvDccayhuwRGGuyE {
	NSData *qzgdPeJEliiIT = [@"MDZtneHNFhldAhpeWlKWqqCOJnUusmeDKqKYpCyyDBbzYtElbMRrnEMXfRcwvAjKaSronQrIoqJkKfKvEGFqdlwTzABBnPFdLyOBItkCnDoJqmyEtZkMN" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *xQtGdQWxStZy = [UIImage imageWithData:qzgdPeJEliiIT];
	xQtGdQWxStZy = [UIImage imageNamed:@"gzyHBaLomCkebyQbzAcVWChtGvVVRONBUKMuPpTRFuixFJqHuZrkmdSStebgucrrGYJNoKWxPOeGdoMbKvymGHspUQnLPYfyhFnHukZuSQoZlODJCm"];
	return xQtGdQWxStZy;
}

- (nonnull NSDictionary *)uXdPWqEqAJMFkEKd :(nonnull UIImage *)nwmMOqAoGYufkGpd :(nonnull NSString *)zLfbzBPMBd {
	NSDictionary *ViazVOlFjpHYOoh = @{
		@"HQHbZGeAACEVwSh": @"qOOJJQklLFYIgfysgnesqyScYcrZkPjuEXDwYYAuCAKFOffkxjijGkQXdXDAtnxTtFZyjHMPvorXHvCoTrJNOYBXTucSTldbGFtLPrySwDoTGmBVtITwYGbpFqUFSgpquCFXRmhClFDgzdHsjk",
		@"wkrVRmkLhYHWC": @"eiytxOKjcVcunJFvCXhMRqkBURYvYOgMqAdhrPVwkCFgQTjOisbyQLkPBgVpNFMMFetaCRkyLtPOWijQVjycqufbGkXEJpsZoAeOFTjetPGmQliYMEONkdTGEnokYFUQaagpTOtReJW",
		@"VvUxkjOCCnqCco": @"SSKqsCISjMRdCAtFBREImjCyEMBZrPjDbgigKMqcPgjYtSANRQIPrMJXlEjZqkskjWlmJZDXaMidokyAoHypnZvYqJJdxFiukGaQrSmwlniZhQwOThmfdGIaoxxjIAKHEVfpWPLtDc",
		@"NHqHpfIdsIHQJHdF": @"iKzXVTjaEiFhyZdgwCuCIvSfVjaFlpYeSnDFTGnYvblxtlbsGZBkxMldwSjPCKRVZgzfnmKAWHTHquGUzMZKYqhzRvizkhObHANRpLeaxZOZFDXSpZxstlAeEuKaIyvhYQDeSfyjmOw",
		@"gKkZNGpEbjwFmhRK": @"kEBNOtinDjSlshPXadUGgDpvbKPPlwBKuRpGunzXdPEJbUWMGFOUbCZGgRxJeYGuEdthBxHleFBVgICkwKobTsMqXOiOZldvtzPMbcnwvF",
		@"nKFoJcXdewP": @"uscxPjBthqCdCpJoLfTjfFdRFouOPdlqWXIWpKSQtakiwZUGtyndImTZYmEfCiWUchLDorwjrmnZGvIssPIRJuoseZljGROTsIsmvXrvEQiomIAL",
		@"NFLpJDXidRxiHElHhE": @"oAFtsiCKKsnJmswlxqacaUfBvdnbXheOIGwiuXbkluVOoOgvvjoqZcxeXqcVmGUauTisJBEoNByBvESeTHonXQmCaiIWoCQjvdEu",
		@"MjdNFJuJaOMBuN": @"PItsAMNeCwxsgoUvKxaiREBgvqksxEfiHjPHrVnrSSoFazKyjXtHYxeFMpReoEMdMzEDhmvLeAVoLhyLThHjNbMfSAtXkrPXRtvGWJzHLxtTIMiuvPWABAvtLgAbTgxzj",
		@"uakKrREXfGCVBgaZA": @"TywMQjahbMFWNqglybhyqRXoUtgiFjWFNskbsQLdNnFQQxxrSEmEhlmSIQRQSgrpcAWopWOfhwIVKhCPYKtbILMjZMqLYIzhQhKbIFgLvtjlKZqBcePupXrMbpgDzreKIKCxiUzapA",
		@"eFRIFHSctOujD": @"NBzbvMTbyzEBBcKMNVpLlEoHdCbPfzNroFDUIKoONPZMeiXhzniIAMtizjPbPIFyTVSLpSeCPZOZJCtoktahhOTtmXdAFVMkAxIysiFbglOqJptSitFjYmmITpMVrxshY",
		@"rqbayYMyMcPBqc": @"pSDFfKQUHfFeaSNnPwAQoBgkBKhFaDPBLkXTkcdKUnjfzbfEkAXQNnovkAXQMfvDGxpKwIEOMxptvafkupnnvJeuxVoHNOTjGKmNaoGhHetRMqTKHbnxjthOaXUAUUZnJi",
		@"RRCOLXRtfbdvBvA": @"FPNUCjnmYvDiblbLwyOKveMAGkfITEqdhvnZtPJieJHnoJThqgIfXgUUmaABiYbozcBZeShEAjmCENELAUhFTesOdtcuAJxguRTeGfpDaYfqjxEQjMwCgsvCcXPvKgODDt",
		@"DWSYgMvxmRbI": @"ufNPzLvUrIhRgQVpJDpmUUsHdrdlPwDbiUSmHynCiVwdRWaocopyRppNKvwkGSDhJaBQiLnNKnxNhIvDYxDcapmryRwAziQvZsjUoAwXJrADWDTKTcAHBLbaujbcdIloTnCiCaluNPQvaRcjIGju",
		@"mJLqxHIXdiO": @"kFFUdaUooFzDarcAJvsQGbCzxhHPKUSGfJKFxMImnQTdNXWybBjrPjvMMxPmccmaLPtaYCDaKZsMqkVpZPfVuyDYokbWpggptqGtautCShIxyIhBfNscsKXXMPdqykFZSzowHdymKwKHhIqzI",
		@"MOnueOCmLwkvnXwlX": @"lmFlAiXbVtVqjJmbCDCtBZznsByaRYbWepezSKPSxVFydtpvIGGVGFiZIIDznZUEywVfGRVgOSliLlRIzVehObKOwkhLsRlsMREyqRNwIVwvrMFIQftLHqYZpZZzcGEeTvfRLGfDclcHnSXic",
		@"KbxfyKRXQOzTicEi": @"PrrYySdzODmvJvtdXrDTAPVJEngFcUHtumGFxWAyZhcBGySVhQyPJZoYcisIKQbuwoHvnetEsORhTrWWauXBMaYWiwaizVqYwummwf",
		@"KqyrifJtrXvrZVn": @"TGvqiDNgmgCnQwIDcNbNVpjFTJOnCoazQOzDaMbeNVkTWJUzqnpWAmtjzOQYYfkMwKUKkECdDYpiVvVBPuaTbrBAUHuRMEoJoItwNKxLSZGCglPMgwfbvCOEdbyAgRUhg",
	};
	return ViazVOlFjpHYOoh;
}

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    self.buttonBarView.shouldCellsFillAvailableWidth = YES;
    self.buttonBarView.backgroundColor = [UIColor whiteColor];
    self.buttonBarView.selectedBarAlignment = XLSelectedBarAlignmentCenter;
    
    NSMutableArray *childVcArray = [NSMutableArray array];
    
    //未完成
    MyTestNoFinishController *finish = [[MyTestNoFinishController alloc] init];
    finish.studyTitle = @"未完成";
    [childVcArray addObject:finish];
    
    //完成
    MyTestFinishController *noFinish = [[MyTestFinishController alloc] init];
    noFinish.studyTitle = @"已完成";
    [childVcArray addObject:noFinish];
    
    return childVcArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

@end
