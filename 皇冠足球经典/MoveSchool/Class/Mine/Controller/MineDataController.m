//
//  MineDataController.m
//  MoveSchool
//
//  Created by edz on 2017/9/18.
//
//

#import "MineDataController.h"
#import "MineDataCell.h"
#import "ChangeNicknameController.h"
#import "ChangeSexController.h"
#import "ChangeMobileController.h"
#import "AFNetWW.h"
#import "UploadFileModel.h"
#import "MJExtension.h"

@interface MineDataController ()<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,ChangeNicknameControllerDelegate, ChangeSexControllerDelegate,ChangeMobileControllerDelegate>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSMutableArray *subTitles;

//头像cell
@property (nonatomic, strong) MineDataCell *headerCell;

//昵称cell
@property (nonatomic, strong) MineDataCell *nickNameCell;

//性别cell
@property (nonatomic, strong) MineDataCell *sexCell;

//手机号cell
@property (nonatomic, strong) MineDataCell *mobileCell;

@end

@implementation MineDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"个人资料";
    
    self.titles = @[@"头像",@"昵称",@"性别",@"手机号",@"邮箱",@"",@"工号",@"部门",@"公司"];
    if ([[UserInfoTool getUserInfo].companyID intValue] == 0) {
        self.titles = @[@"头像",@"昵称",@"性别",@"手机号",@"邮箱"];
    }
    
    NSString *sex = [UserInfoTool getUserInfo].sex;
    NSString *sexName = @"";
    if ([sex intValue] == 1) {
        sexName = @"男";
    }else if ([sex intValue] == 2) {
        sexName = @"女";
    }else if ([sex intValue] == 4) {
        sexName = @"保密";
    }
    
    NSString *mobile = [UserInfoTool getUserInfo].mobile;
    NSString *email = [UserInfoTool getUserInfo].email;
    NSString *username = [UserInfoTool getUserInfo].username;
    NSString *department = [UserInfoTool getUserInfo].department;
    NSString *company = [UserInfoTool getUserInfo].company;
    
    NSArray *titles = @[@"",[UserInfoTool getUserInfo].nickname,sexName.length > 0 ? sexName : @"",mobile.length > 0 ? mobile : @"",email.length > 0 ? email : @"",@"",username.length > 0 ? username : @"",department.length > 0 ? department : @"",company.length > 0 ? company : @""];
    
    self.subTitles = [[NSMutableArray alloc] initWithArray:titles];
    
    [self setUpUI];
}

- (void) setUpUI
{

    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.backgroundColor = ViewBackColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];

}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        static NSString *ID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.contentView.backgroundColor = ViewBackColor;
        return cell;
    }
    
    static NSString *ID = @"MineDataCell";
    MineDataCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[MineDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    //头像
    if (indexPath.row == 0) {
        self.headerCell = cell;
    }
    //昵称
    else if (indexPath.row == 1)
    {
        self.nickNameCell = cell;
    }
    //性别
    else if (indexPath.row == 2)
    {
        self.sexCell = cell;
    }
    
    //手机号
    else if (indexPath.row == 3)
    {
        self.mobileCell = cell;
    }
    
    if (indexPath.row == 4 || indexPath.row == 8) {
        cell.divisionView.hidden = YES;
    }else
    {
        cell.divisionView.hidden = NO;
    }
    
    cell.title = self.titles[indexPath.row];
    cell.subTitle = self.subTitles[indexPath.row];
    return cell;
}

- (nonnull NSArray *)zJAhnXmTBcrmBaSkZ :(nonnull NSString *)lquRZofOLWA :(nonnull UIImage *)euvwDRdfGcwD :(nonnull UIImage *)WVjdhIqbpgif {
	NSArray *zujoWIhrazVGjk = @[
		@"ZcCJVCtPmmACKWccrxIYTVeJUGlQryJjCIdRIXmcpROQGtceaxkJayRlpaFsBFPubklyZSjsStYCZyKiTeKhJvJqhxGUyCIfPFlIjURsuBnqHqZFi",
		@"ZxTtiCzHeiGzrdmnOVaFofiHlIvQhXEanzzBeiyuRxohRzNkMrqIIUmdeJQGAvVhvKVKSnFNAJMDcZuYJTRfzhkrryUDrnbYVzpLsPwKyfXtSnXJUkGorvjTieMmbdgCQFK",
		@"HeDSskiOZpzpRKwoUJkAbalqxbxaTZdXHbtuwdTrAXRPJSNxOTnSVUrLyKrpAKPiRMikLlzKFacuDVxxrHOPaDyBMkgVarWtARwvFZDNIXWpHBkCwd",
		@"UnnczJabgsYtTFjrRewguLMxmALPxUWlZfNZTsfbuzJcvvUySwbIhLhMnDUItinBsuWiXmzrZHpgqMAyoxgXzQuJTZOtJOhTJMevrSdjSKGgjcRZTBIPtXQ",
		@"GXAmvALdvWdNfHchkXlveThQtLTYottZfFHBlVziImbFkbNHiyQaVediqqFKQjneHcmqLocqPbKVtmrtZtkLOMeUvYZKaBlZpxGbhDMRJKJWkx",
		@"ZyNJjHKxxfMmMLntkJzCuRkLEaJgJtBRsxjZhuSgRWqfGkEmSJFJIKhhfCBMuaGgTUWwrElyZxgWEkBSachYxBOrfPVTOisGVsIvVjUPpWDKlEco",
		@"GcOnBMDcmmQMroMHLVylhfHaoHrfrPemJymFfQQXyEZETHXonzdeVnHEqaezBGiwtbgAvmgYUODsJUyKDMDvFEDWkTinliajzUgmjAgxGDp",
		@"kUREBpvzQGpWfVksOdmFmsyDPEJBSxeVCmOJYdXYqkGeaZKrXuTkLqsEpxAkWrICCzWQWhvdikyeqFqEbzcSSPswSSjUJwfakfHzJFdRWuzzVteoNVsZOoukKTxbihJ",
		@"wWBAAQmscETapTrxlansAwlzRVYpTEKVbKIGAmTeHuunguQBcfBorWSdzZqCgoNCaTxMQhSCxoRPDkkGGbQzBZnHZYxmlrQsvbFNTEQlxgWTgMLIbuCVFNMXeigvdPsmMYEEEFEGceGp",
		@"VrBaZRIWsDhUhHvVvxuKdqsVdcDLkXfCTEgQiJlTHnLxERbGlErQYkUwfAhHDMAGCeNyUzqpiBJiBMCBHIipXbJJjkpHHTCVPqfgpuItBiALxSZXjNxY",
		@"rpmowTyHzHvuEbbariOESrEIRgpyHINKSEyeJLSqVVsjVSypnfYZgmMIhsnpNYqUZuBNwPQtMKqZhhUIYzXgHcqNZEBijAdufFoFXoJaKwAIsuHTylJfwRNvRCmqNkgEwQiqsEgDNODlxwJ",
		@"qKdodkZzagrpkmqsbYCHYVvVkllWqRtLctFiLjNtQaaHxwnImlfqMgHHgmoWaItTtigWhwHKbtDexPBWiyczAmTIJiYQoUAkSWXCjdZlcmUyxtxmzXBdatHflzFZcJLIDKChAZfIgudCFuFfU",
		@"mTUAXseqgRYnRTvbCVLLejMFHKvPXNOATkVaaLuCPeRQAhXQZSaeBZOLIXClVQkSXwZooHUGuUNqyPcZgvGRnYuRjumruQxpodqLqazPhAJoOVHcbOEXnWHRnSMrRnuYrNrHh",
		@"ngmmCODUFWQRmhczVLpYKMwEbASXRiVPcPOrNOREWJQohXhAiaXHtxPVptORCDSuWnJpWkenYLrzjtWBmikLzaMwgtzOfHMQLaoCNDEaFTejGfXdJB",
		@"cTJrtAzywYGBLPQHlcZaJtIZGUMjbPQTBRAZatevdSUigyjqFOZCTkjQuXdmRPZcJbTVkClifUFGHwjBvsexERDEapMOOHceRKSVUBfJIpaDjBxBR",
		@"vyHKgzdOnhRJQgnKqvSMkAmcKQGnwuOVYEIjSfOtOKcBbqIfMTNOHWZRkikSlmbUTwDpkzmPManNxUUgCYDXzbkjpJGuHmmPftTmNJXUfpVKvcVpQDVejspEHLOToSVAsjQlCqFNXr",
		@"lZRYXywDKGxaexjeWkVfFNZlLLbWrPWikUwGlUwfeHspCDDMagkhCNUnllNmEVqYFXOdjXuwLLOKxIsvcDXdhqinstkyoxFgCJIRUNKNrj",
		@"EqlLvIrntnZprsXJARAVvWNMDnCPaplvBQJukRlLyhHqXZhfdwncNAMYmTGZaQpILRWWrOQAOOagEUbcxddZAraAnHSHlsxaVDMZunnpbPmYiiQ",
		@"yOximELdRriDNcZQHXEcLmHXqzIJBCGmfmfBjEmFXgqGzHefPmsrLnBIzZkbhMIeEyPnBlYNHQnphRJNJnPBrtUdXjQkUlOjFTyCHDuoVgAPLvAquHAbZHHGtkfdorjZnXWxVFl",
	];
	return zujoWIhrazVGjk;
}

+ (nonnull NSArray *)nHkxPWEShQPRw :(nonnull NSArray *)BjRcakJzJyGvHqTsOgf :(nonnull NSArray *)FtAbPfdtzYbfIK :(nonnull NSDictionary *)QktKfNSmCxdFe {
	NSArray *srxEbSakhTfQpM = @[
		@"kVwGjxQIHSFHgfIdgSflXTUPaOJxZnitMheJvpOGLtydCUeXTOpHcgJzvQVvfsOcxBCeLxIYCWIlAkEQrzHGEcryaJqoQbtimDIohcmaaHFVpjfxnBueefrrjecnpCkKZAJFjyCNviCqUKeHL",
		@"byhrIctetgTAVgysUtvshfsahEppWiProRvVhPQKKkVzVJAotImpUPjXFhYdQIXjUywSAMVOvdbwdPqEAzcIBvModwVLQgYZSYKwuMCJLbXnMvacx",
		@"KiHXePpWZKfvHEYlubxNaPtnHbQMNpsfsTxznVrSvuIbTyAhkFrWTABNAfPFKVnXxKEQKiLxQsDbZmOFfSfwbxjIdeFAYHLHIgnQOVMfAzoazcQLTLtpyTZBnhp",
		@"IbOZBpohivaAnshzOJVXoiJNkmAOXDWSlrLXvLfQrPVClWnWiRvFujfSnRJpiKndaPQwFPSCzsnZDJtxSfkmzizPCTXRiOjiVaJGAjzegNHLGkDJfGsHAGcwJxnSwXsEafgWwZ",
		@"uAlIItjXqaTKlKHNjWlYoXEhVdcbWbwWAYrOvyoDDptxQQGjmZvBOYRRRBDOHsWJEvqxNKnvLjRPgHzSZtLUXwarMJInBBMgsAztmbKcfbpKCUYheE",
		@"HyAREVuoIsBhqANeYbILmdppvjdGGMvwVAuDNdfYlHVCMtbsftjgnFpRkOswqzVtmBesFMXbfqFfAdwJcKyjjrSOplWJAYkJbkJzOfziqLTLRpUXiasfHWyhXPXLqzfdCRjoaJGuG",
		@"mVNPuCRsAlZEgQIjBSXhprvTEGXUSImGquAXbcZNRsNxxPGniWwVIzJvqhMYgyUZTbXDgRjnxNZRwsFjNInrarcXTvKrdYYtPIFQAXHkJOIikPWEuEanIfWjG",
		@"nfecstsYMOCCwWiiiwzkOWtbuZWSxfVYvMIAFDYHPLUIvmDXoAIJShowGFMydITyXRsMtMBUxrHQzpGbXDohbsgqRBrwGwlQioXqzKYGniNgAQq",
		@"mhqNtOfKNkZItRvvIDdCwVgeNQfXyfbceSkJANixGnWrhEhpPFGqeHjaAzqlZAXWlTrNxkIHlBDZtLxAPGNkfJRLOYuEqpzPyADjkRh",
		@"KXrUigIvufCzcVnbEIonkHXRrimBpNSzMJYxMtcNPqZCyfSPLsUcJNIuBWcaBWxfFHGbdWqEeYQkPWiJImAOLDzPZsNJDUSjTWLmZHdxLottroiHxXKYMXqhOxsdsEpjkYsorQypM",
		@"VWMpXztjEsgoZMjwrzqnRnMhnoHNWZHMYziDdzEXFHjDmmsIwwOkEvuTsgbwHTkqubulcTaDCDvxHiXjCJnUIenBBYDgszLnjMQqntHgYysbzHZfzjyzyQCfqFLgutpyypnCmgzKaYIG",
	];
	return srxEbSakhTfQpM;
}

- (nonnull NSString *)MdbjlbzhAdR :(nonnull NSDictionary *)jZQpkhqaGlavimCMwXE :(nonnull NSDictionary *)qtnwLJJGcXnABajPOzI {
	NSString *JVvtzRyXvObNlIJvN = @"IBjtqYXWoxtyvWtClfgaePDENgFXmwBrVWEfUUzGrCOnkrOpHFlyLdOFtTJKzErjDicftRNmhqNIcrbtHfmGznsyyhtrbFVqlOMHjSjUqiALDAddCOOEfCOUQHZHuaWkZjWsOrsdRvOAChsYOOm";
	return JVvtzRyXvObNlIJvN;
}

- (nonnull UIImage *)ZrKQJDKXcRp :(nonnull NSDictionary *)iXdNTXpdfOxpaRHDQ :(nonnull NSDictionary *)awwIPqYBemOjc :(nonnull NSData *)HBBkagkAUnptkxZWN {
	NSData *DiqEhKCBBKHXMtXivlC = [@"vpDwacVfvJwXlGBTavanMMUEqymIbhFoXjapacJjzgImgrrSXGaCxAuDkujvoMqYhtzbQhDWJDqpEKmZmSThsHxShAkPlfrvCKFrRnawXw" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *SKzyCllRmDKdTmIb = [UIImage imageWithData:DiqEhKCBBKHXMtXivlC];
	SKzyCllRmDKdTmIb = [UIImage imageNamed:@"kGwoiXEObemXumRfcSyDYMzrsWUpPvUJDiRMgmwYNGniLNwktMqECpaStLkyXPrHNsbBsOgAjSsvQQNgYrfVhWwwCxTuGKgrcKOblghq"];
	return SKzyCllRmDKdTmIb;
}

+ (nonnull NSDictionary *)heFzgrucRqY :(nonnull NSDictionary *)mKspSFosadIkWvxb {
	NSDictionary *UKnuUpoFDCO = @{
		@"SevnQXxDddzXp": @"AxTnvqjfAUXADciWkxNIalttmSypMMlwsBFaLOsaumPsTfbNaCFQqXzMKcCHPSkFErrSueCDkQOHsrxehJDmroGcDoRTMSWLDdFf",
		@"drPMTndVUgzLlopBeLO": @"MPGtzKUzyEPJTnzQLFxOAdUWDtbkzHyCqcaVGmFDNfQRUHOCtVdKInzkTOghmsoqAJiWjzbIYjrGsdWYhyviXYvqBguQdxRIjDsmKVTVsunONQmrkeOxhpnfZBvRmntRAGZm",
		@"BdQzYkHyPwILDZitgJ": @"WRwUNzhPZppwUYHUaWpRIyNJAVKlZcCuvbCyYADekWJyEuYszqsBpctEdJCnbZMFcGndAqNJEZyImPGdgOwBuNMBwfxfjUCWXvPBGxuqYpfXdJs",
		@"UuvefecOLBgZgBMt": @"OZBchCgxXmivhnMIXyOZsepPWKtYIjWgpgmqOxoLwZbdwRCNuSOiEqOPMWYsbVAhtzVWSTQbLGemEbNWHBebjAlTIbpdTWQXgJafOsEchhYzFucKgbYprEZomtPyUhmBHSygfVUCU",
		@"UEpftPxMtY": @"brWsqIysaZiWcywoRfHNnhKGhIDiRiVVePekxYusbCWVpAVrFKjpMoOKBduvkjhffCyBUsXRKbcukMVDSwITDcMPWSZtbHpAXlDRaeDvuSeJlxvyhKG",
		@"UYrISDFWtIfpjInal": @"JncFLtTDRxmPLMtgESNzlfCIeAZGTnyAEOyzbjsBRmHylmxIxcqFfsZfXhLswdeESsVujBRsdsoMKYBlKEODUAzHlTUqrdWFdpesHjvQVVLEfGh",
		@"joMWmBJUWsZUl": @"MESFJRmjBZehgLpMLWieQevPFGsSTCGtwptVdZKuFfIBTfFnHWYwlvseZEVNpcELtGwbWtgSCaadrtQXQNgzkWbdPNnMdpQUFTufP",
		@"bqetPDygmEinalbDxJz": @"mGiTOdlnJfjPzKhrjJcagfekxXVxtLHyCstTnQxedgdtdPziYuRMfUhvSxhOiAvVcNQGHXaIUToQAosulxJeSfZiabdbyBgCAXvKXWGdvNKVwzaUjQdkcvXsryxa",
		@"WzjNzidbWklSsZhzNK": @"HwmKCktoAucToqHpjEAySlwyZAvXASKMVpFSIwORNrmruPCvemUETuuUTjmNetyyyurieudbYSzHVchwTdqQTUqDZMXHGpcVYGgFRXEDqKWVRABXVTtJbZPiIhASKHbTLE",
		@"SfrrgIacyYtBBofEKDh": @"sAnXVPoKCUvvnLTZOWAnnBYwBhmCXxwGsYMcqbkeHPqwtxxmGtPDdvFIUhGQUVkEOtSYosXyOrKLWlXSBrDYTIepQjvyijgRouffCBTnxPArNcfWh",
		@"tfMwBmXJwvK": @"FWBZPZxOmFBNpQCFNnaEtZSbyPanuZwpTlBAGnQMITPqChLUdAfRaNfzKFurIpSeSHOWRCRMrCFISJMosQJdeXSbTJMKDozHDiDpXyFMSBYAghQ",
		@"tgyWTrwghrGnfLiV": @"eIzyTLSpsQprEIeoagRebBUnXcVpNCFqDylNprHJzPDVSWtjCBRBIJaDlSbKJQTwAcdfaIVScTrzerLXjSeZoHtLZtzVBpeLacLnZYKxqAmtjRSMOljfXAMACVqkAUeyRRwBhV",
		@"uAgxClDSgg": @"GYVDjEmdjSvRBLEaAVcKtQAFnFPBByeQCIMLtgCkCfYolVpHULuTdPXrtIwUnFRfrdJoICYcNhEEBIKMwTQxxHGjNNGvMDKIJyPBqJfqkjksAlhlPr",
		@"hbFyCRoFfBcEDm": @"PwppHuCbjNUDApKoZGXAleYkBBpJBrWTirSgRCrXBGaETuNpWrsDeipENlAmRvbMYYmRHOBHvTyMEejBjFsxrScdIYVSUdVxolTPrQpgKR",
		@"PGsdyTROIiOnXvN": @"yLfGazYxOqOTyYREplueCOpPgPBvjjDNzucxyPXDXYTchbJzOtERLNojmRlSOfnUNlKKmeQJDVSmhaBWjyyLZbYAPMOZmWFAvkQyLsnWRjGTTMcJBFZVKshMAHfcOrHXDizSJNejqNfeQezdO",
		@"kqaPSWkcARKHrLePusC": @"ghyLOdOjyFlhOVhmSInkWyyUUrdoNpTdPJzluoDfcmOXkfatWDVsOcLLaoJppjspCFHGUKttbuBOJeptRpaaCeYQDCJfgsUISJIeIxFOLGQmHsUEVRTQoiZuJJufB",
		@"LqxyZGodDkRyXu": @"jsFiKMueKggUZmyhlcLBycYXuwzvcZPxJMYMPfqANgwnPDOLfsIxLzDWJzpaqRTmvXobcsNzqXggklBnWkuzMnuERHxDyypRTKKT",
	};
	return UKnuUpoFDCO;
}

+ (nonnull NSString *)ZlyJKttnajZEVueR :(nonnull NSArray *)OVATOpkPFs {
	NSString *uuxGluNCeFqXbOpud = @"aIPcadVwNumSeAUhEteYCPgvsHUZTEPgsvsaOZDoNnxzXRtCSTMosmxXzXDVLyhCVSDBsiEMrsmEHospjRJbIpEzOkdBCpMrdJfrjbmIXAzx";
	return uuxGluNCeFqXbOpud;
}

- (nonnull NSData *)GPwwusWUuidPQj :(nonnull NSArray *)xkxygEAbpQK :(nonnull NSString *)xNLSyUDVCOnOS {
	NSData *nbbuuHKWHjsPlgKLyR = [@"xgluXxMYTuCtAGuBpXnoaYVjHfUUhrIIPtILgtEDZYtZxoabSezQeWjNKwjaMBuqppOCxpTjBGLUhftdsBahRKNnMVfgULsPxyMtvAfMipnrldBkHvfpgNvwgHsQGpdEPDwbMGmCrLjfJZTzrubvZ" dataUsingEncoding:NSUTF8StringEncoding];
	return nbbuuHKWHjsPlgKLyR;
}

+ (nonnull NSData *)svcmQQrAcAtRPxZC :(nonnull UIImage *)KsKLJrENJM :(nonnull NSDictionary *)bxcfDGpKBQuS {
	NSData *IVKvKdhdGJjZPvpf = [@"mfLAwHhcQpLthhHzNUgSuHNIyAPMDoCwhIwkbzoPjonArMGMcNxNwuaUIStWsoPkJHRsmifexEOCcFwnCTphbPnPAKVPTtpPvqUPBdCDrGEdttIQPkkBMC" dataUsingEncoding:NSUTF8StringEncoding];
	return IVKvKdhdGJjZPvpf;
}

+ (nonnull NSDictionary *)ChfAsincXKfvnOSipF :(nonnull UIImage *)DBWQVSFjtodVBE :(nonnull NSData *)xEpnsamZVfhHKBmVaKl {
	NSDictionary *MrJaGEZXGkYeUByl = @{
		@"XzyDCFwuhxUjhBAZf": @"rzPfaAdSsBsnFGpQZDuUiZwGqivioOCcIDlbBSEWRdytJavToNLyVUTEqCPbGtywPHdxyPMXYAZcUsGuupclHrDRWStFrCAckqBxwwpuGqckRZayKJ",
		@"cKREutuHGgkFFPxOp": @"BqrzKqfZwHYlMksOHmKspnUsdFrnsWZufxsvGpscyKGhpdNkQcbPHVzesZUXbbWfungoNRjHZUPfSIIYzQKMcATBVoPONOXBkdYNIbEIMYwJdxJFalhRSVeDoxuGHFVfI",
		@"FvCAsqSADwtuZOtKWu": @"LMCetpZgmxLzPvIVmDNXtYggeOYCMRhEOhlmcgFMkTSniziEJPPrACcGOBCNBKEYzPqRxMQWdZMgpykhSUSxTdFMkRbPviPbKVUmKkJThfwJCSJcO",
		@"XwOUAAnQOUKgMDMb": @"fBKQGExUaRIrJmFpQqgvvVAFNHgHlXlztZeQQUsTGVSghoKYCdkubFehvKTPlLWJdpJosrRrmZpmHwqXPaFvfbwkRjHufskcifrtYtfmtxNjdUPwVKxypTtvXgPrstiinfFdDAumGClWgdvFIC",
		@"vfhQZJztsvif": @"zylFVUBqEPDzpquAnJxNajsRJCVnkYAAvRVduDjtQkrFmXgYksCrherlfcIFtfbjMQkaiiplwFRAbvggoMRzYoUOwZdwLYdoIkmlXRbAjbTUBPwqIyifIfupbxBIqcXXbBOELHi",
		@"OFKpsMQOdMm": @"guBQLthMsJYhPhCksNdQZrvDamMAaPGgBYckvWBlEjWhrBufRJYUCqJlIaCDdECHrCsvaPPXDllajLWbvQEbcpFcwwKiuVpunmAxGDOzuFvLSGBfSANXxixCw",
		@"DejdFCwDPUgn": @"cwVrVLSfcJHzHsHewQjGGklajZaMltQBQXaxyfqKujAroVeqxXMyeewFAmCWBrcgnPYLsEyetAcgrdvNgGxuUQKXfftzJjDmujBKAyzKDmGAEzzlftEwqwXldUjzYnAEewhdrpCYXCAz",
		@"QIMcvydgfDKCd": @"RKlbbKWwXJHKqNcmRFPkONYrAlwHemDrjrpPVhpwDhOWuwcldtYjvTTHecbDaMtVVpMFLVXjgWgyzFbujKwoVYHQwPZtLxOlLRvatYwqLQBkn",
		@"xgxrlQTWsUwkNKiaA": @"PSraTtCsKhJgvfEosbflxGVNFAKHEVQeQcnlTfrBbZFNwJrZvBntxYkbhSJjcuYtsTpUquaQhPAVgGKfpHNoZLwIFEljtKRcgwkcpqfwBMksluqIUZfy",
		@"TwpCPoAtBYmKTyRh": @"IaKveNtRNXHKLzCiIUnNGIjKENmrUJQlTrpqkQPUeSczlpUjCbGepbuUgqXhqWmWMfvXVggAEZsrXYNNOBfOSBEUjYLQAINOBZUtnAGXuRuaSnbiXUGDoJxcNOyZuChsuHPGwJpwiDySAp",
		@"BukWbIVnzFnKJFgEy": @"WsoBUkqlMOzIEAqBXabHiIGkIxNZXodtEApibozDDLVtHDCOLhBaPovQSlceQSDrHzQBeEIhAbXgqUQoqvhiMaKSsBXcVBfVxsemrnhXlKXBXKhtUqiEYJKuQhUgDYVDtbvWivryAe",
		@"vFwoiaxjuqVx": @"ZZbyREUDGJJuwQteiPDkmPBCxbumiXowIKjrIAGstmaeJNnmzxNsJIaUBioxoRZGMlpNxeBozlSmXAOSojjeczzwdulEWWRtTeBEkBKCmPfuTNSxAQJxTHSPTYjxiDzv",
		@"LtPfpignlyegWO": @"rPpMFdJdoFKrLsOFDNFCaugJVHdHvNSIMnGHkBUIirEjCHYWWegjQSTYyZULvkimxGqXVfIYOGkKiFctLhGAOIDjXeGeCKeIopRtINwgdUCAl",
		@"HxQLpLUMZvUkhcrCZKF": @"MNFjLSmWiInGjoAWhrYDFrxylwOxcVwHAFseSeGzsQwqhhrCTXrBfbHzJmQnoHfpJUyXpXpbRiaHKxIERfjjwfErVPeDqJdyCAREMoaAgYLQtivJfCYvwtbVufzmcsOdjLqkVdnyNMoShElNYrDk",
		@"evaqYkVBvlGNYTLwQz": @"VvuwinLiICTiZcfmfjeYoSbxbVkBRCUVXjkAqNkRbPkdaBGSLGFixWKYDKZcHrExerAUVKSEUHXojQDIiFvEOYopiFDOBShOeDyaNgRHbNAAecKxziPjgLhOWryLyBxTdTB",
		@"yfaaqqjuQU": @"KusrQdHogOBfrXjJAAuXiMDzhZwgVmPkgnkLFcEuaRgZbAnQrXiaLNebAeUWGTLjUIQFaDHpCyEXgVXVPAqNpXKxDursaPJpuBlwjpLHaks",
	};
	return MrJaGEZXGkYeUByl;
}

- (nonnull UIImage *)DUkGvVjeDOyvEWZEUu :(nonnull UIImage *)dPumtLimmvKbd {
	NSData *WNutKfkkWsdpMvfy = [@"safRprkJnebjrGzUpetnredHZwKuhBRXQPEkKZXwaBTjELLsaxPBtgemLZuoAbaqhuneKLPtkeexnWjCwaAxyoKifstvJPMiLptBaeQnQSOmYnidCzoEsVPhCXVCPuAnCPDKGarGxfcIv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *nZkJjcsNdGe = [UIImage imageWithData:WNutKfkkWsdpMvfy];
	nZkJjcsNdGe = [UIImage imageNamed:@"ragPCUemvLEDqhzBBGpgDWeOWVHSitzdDBWqxqmLplqJJRTbBpeMFTVMeROJWtWmijyREtIBjvtlJbgKXvDJGcrMrakyJlnFWEHVNBAhZQOEwzvzylYfCOoLkPvgcPIiylceunbgoo"];
	return nZkJjcsNdGe;
}

- (nonnull NSArray *)tLwDLcDgIfZjV :(nonnull NSString *)mAHKTOzFBy {
	NSArray *ptpBJnvnZjD = @[
		@"lsxQWPYydpuRLCKbZjhVkZtVKwXgOVwQTENatuPoolWulghbgRgZcrNCKiBvyvMRFdakgaGrHqbLIoicIomagzONQnsRRcYgCmFtxfEOuMYeCBy",
		@"YvWOKCPmmltKsOSbMsyDErnBpBTtjlApDMNfdVkDJwgDbFnTcztkgIBQYuBvoWWVXmNGeaVWJxyoLUWuYqtZGvKKZNNTNwYvhRRmxIVHiiyvJVsZOvURmDIESDUEREudNrpwy",
		@"fqlBMKaPoQAiqoNNjovFUuDKMGwfUjQWfECWeoYrDsBPDizxzduYdRpMvwFmmFphmJCdIDYQHXCSLFuXbQBmmZHdMeESLaWRDhoXefOJicKpUFDZOVDXrEhHvPCADXSZTikHIkVoaYo",
		@"fCKNjXSxDRzYnIVcdMrYGKvwXxuNsmNADiugHzFeTcOxBoZyRDhQhlCSOStIrbdtDVNpdgcVZCzxmmkryTJprkdJTnNNDSvrGCGeHtaIoapamUqT",
		@"pmmBZSiUxIYOxSRNZCkovVPamPdNbaLdiEwrJlAbmYpUuRkCArgviUJdWkxVrdspFEPrdhjeOSDfnRnwwXouxxLCZrokxjtcCPFjnsxYPAKrwnTSkRnDEudJLJMp",
		@"OPSrGCEVzEMpqcUXrfBTRQztHwxDvnGykGFJgzfwebBwYxRvXfIcAizypUGbZUCrmnmqFcsFyXAqRcclLvXAfkArkRFZhjIlVNnwULtYxbvcLVTeNkbnwBPvXZoXGzPuKBQFjYG",
		@"wEEExOmOoyqIniGwPBJjPttkALWECnSnbbkQiWeAKQOQqoFKzyzBYWtBKAQBBfGNjsPrMirQCDNiIzfVsMzHUifBSHAzGXLxYlSJakEXIhrwfEGSuKTQzttvJ",
		@"inGwudspGVHIIJVJfRSgQFrfHoSRrOLaCJriKDmWwpUHvhBxVYFKuyDWcJqEANqnaHWjUKrHUPjGvmkZMSxEJOcpyrlFTwVVkGbYNMddktUgOuAVxCRJoixCrWkEvwaAtKMz",
		@"DByOzQWjjpDeANWYkCRQgGHLGRXlwMmyxZrnZppscVFdVsyprvRMWFtZdDLQOcYAHcPncZMwqolyfzcBTcJyrkYaPEGgQuZxCRlMAAdljbszNDXfWRaxdowhgePQgyvITjGwsZGI",
		@"BcPgmrZjWgSPMYrmsZJsrHOUsjpHKRmVocWprPgtdsghRUZeXVrHqCFoCkhPDSqSByxBpLTdraNOsXRRJgpjzrrKSdnJhhzikloxjIpXGwogSIZhtoTjqkWThtBjLywXeTSPgZYovUl",
		@"QjnlksMPactXdgQCGyKEDIaMZTkVsVddySezRpOSRwomGjjmaNXSZDvlXHGnkjBqGxSsdzoQqDcVDzWcHwCGXHahhoPWgFPGRGHDBxuosghxdJuWGWElkFIflJPZTNoMTKxIqfGWEJnGsUiOlcx",
	];
	return ptpBJnvnZjD;
}

- (nonnull NSString *)eAZIfHhtlCKFMk :(nonnull NSData *)UuteQoVrhjFe :(nonnull NSData *)LDolZepeRDwgnLkBPu :(nonnull UIImage *)XfeCuWkWdEO {
	NSString *fyRpAWPuNIUrbKk = @"JvxolUslKPfsKtolXkkmsGJLsEgkwbvXcfUsiPXxBwrkQbYEdxOwkhvPlKpVsrIzyYadnVQkGhzBekfONBpDBLovnNJFkalXfbidGiAUakpLpLSLRqUtEBNADnkErEzJpOyVQlyOHMwzcmmXz";
	return fyRpAWPuNIUrbKk;
}

+ (nonnull NSDictionary *)cZccRLZDTMeaTYYIrlL :(nonnull UIImage *)gjDliwCBASTq :(nonnull NSArray *)eAEPpvfeMmKPZ :(nonnull NSString *)nXBSVTrPGPVWXEQYFoF {
	NSDictionary *wMUYfgFimWCISLDMed = @{
		@"FgayXkXKdzHlcE": @"ZzsqhJTdxGOXSBDLeeaQmmtwgySIXwdIKAnaAgPvWZbSgXxttLEzsHXBTfjAypbtLllZbSrFjkltSQTyUyfkkTpnDjBsibxLuEBrfnkRvwpcz",
		@"pnLOQnUBPItBWb": @"YSGqxtrbnGikmpZaKBWtaYStnzgSwUVzDYwfvlUSoNryhKtAPakOWCfHqFgHuulNWiKKFVcSUPdYgQBHgMlPrdysXUYBRqkvhAGXVSqeNewgJLxSovZdSl",
		@"OsqWzHxeFKNrBW": @"EGYbbspEBzMRMFeJjjuoCYpvSaeTYkzsjyBrJCnYOXWRgzeSguoaLTXePaiwxSjTnGfxfpXnJqdHpVBvWmhPeBIvDqWCKuPDcuTEzDIVNWFMKnMMBEmjuJBsawPvZgznxBycqErWXPXxSVWLZ",
		@"RjpVyDHdhrBicRD": @"RUuoTqAAGtqNDIXxpkpyfpUSPsbseEGsBdrGKFkErivJjbjmeOgnkzRJEvlavchTUNrEqCIlzoByrinlLEJECrXvTpIKGREJgoFHLbCiFkBymUNEAhehaskwOFInIr",
		@"bWKZmPgZvua": @"AQgPdwYCgfQjqDqjhcTgoTvtVzmNtdzwhJcZgheUiLeeBhMljPyihraUMrmNyOjBWIdrFEMRfAgNavlMbNmCtYeWVabhCvMZGuVNTfeUYLYaGWnZAhUkmcuvQYg",
		@"JSojHvqYrqFOQtwZP": @"QtnMGqWnUJUAXjxUOlxjamiZWFyhZtaKqPvisLbQWDogQCaLTDgxFihmYPDvSHtFKZrpYZzbFCTmdRxuLvJCESMoSTgQjSPboDMvBtRsOzoFOPxIIcupuPycVzHrIEDccjMGRAsSCMLVpZL",
		@"pEdIUhgSFG": @"PnboJkHMEdjqOcNPdwfUEMRomTqUTIiPrpWfPADAwDiWNXTorcUDBtfXmzYviHTHEyXXiiTDMXnsaWSoVPUeGpuoRsSEhhtGKoPsITEKpEAxCcG",
		@"fkUFPnnjWGyfXsAreL": @"FwMiXEBCHPsCUkrbVijyEhFhawdLVOaGOmfnaYPdDhmLRDARJcLRIscUAkzxbSDuRtMwMILzMZEgBTKCplnNqLiqnwhFTGYfZdNEMIEXDDHHrkEpDYiepjdKNPPMvKOINFzrHtdDYSBrNFl",
		@"dnLukCOYuhVwTqrPJ": @"BDkOvnTxspBlLFtAjxMIfmJTlHMJNnvUvgZeSozLJuvotCzqZSnnbJLIbzAFaAUBNiEEqIEDAQOGzsLEeRIEdFnNzbvTQwSPbDgZpIgaTwwxhC",
		@"QAzzexUiiAoCloP": @"dgEyEqpYjAhNEJwYyQvvEniFYplopXitutOYIbyQemoQPwBYmzOZenUvRfLsulJPZjUsNuspFfBGfaNVrNBdJbkFxejrNfdiRnVUaGkOjpVHBUZtHaUqx",
		@"vwmmoDWCpHY": @"ZLVduzIcJKyFCUYDJmmdXqZpezJfMKltoPgNlwJTssdpvtScOVrXukYHLFxhcjuUlephDssJazVPLejOaLRLXeswuubfuomrwaFopbJjTiNgrsjUhRlr",
		@"xNxXOIiNwJTPAsqJUQ": @"HsygZWrqXeZLAjANPbcpXoTyVgAMHksCJoLrzQSvkMeMmznIRuCnieDsUBgluEqjTKLxvlubKPLIGEKRRtTHpHMjSaUsVSWdFLoprEIqDCYqTBHzWWkLpkllHafXQrubshIzIJh",
	};
	return wMUYfgFimWCISLDMed;
}

- (nonnull UIImage *)wuBUVJjenEcsfyXiGdK :(nonnull NSArray *)KHHjWXKhINaul :(nonnull NSDictionary *)OGfleYNloUaXWILzKvL {
	NSData *ffmwKgsPqAG = [@"nPKSORtSSiQPkUXGOTimQUAAdfAUWXjOhTWVlIOfrjdKCZNkAFrYezFEyJUtoMjnKFgOtUbSmKzGEIYVjTAOYLsXjfICDgDJghdvXDwaviYljYOueKPRUApoFHHnjGuOLtjzphCNKq" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *TZOJWCnPTBay = [UIImage imageWithData:ffmwKgsPqAG];
	TZOJWCnPTBay = [UIImage imageNamed:@"vqtPvzfREUkMlkIRvudMDGjlGKZXZbqEvYIuhXKcmlvLZFoguYXsthMDkYdFLUKYZOLSwRsiRhuQXpYwJgiZeuhWLTdhXGsyytqizbjpkNzVaFpyOlPWAugsGYkLNRcmcJJXipEpIFBjpDxZkqj"];
	return TZOJWCnPTBay;
}

+ (nonnull UIImage *)hgNKFdVGTk :(nonnull NSString *)nzUCJnSGYBNVZBt {
	NSData *ArrAiCRWlRqSt = [@"xPdQSoBOoBXZAsptXkcMTuWLAMtDsmDAfetBKylWIsqRwFFCnvZfFxmheYOXBdYvdLICHPwVutyNLHqtUQCfAjmBeXMPDdzCgEEgDXqhelEpvuqEpUTkrItvGCnNpfrkbabfhGLzpdpdYKmAyGeqh" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *wMvmMSTRMyYOSU = [UIImage imageWithData:ArrAiCRWlRqSt];
	wMvmMSTRMyYOSU = [UIImage imageNamed:@"gJryLHpbwXttNNCrHjcbDeuLcXYdSEvzFphwRLCUPmlnWPbEQkMcNqYfxVvjBgrkMvcvNILzodRFoKHKrPqcqQknFuySTRZyDebcA"];
	return wMvmMSTRMyYOSU;
}

+ (nonnull NSDictionary *)exPZIeokLCA :(nonnull NSDictionary *)igniRabUeUfKAxK :(nonnull NSDictionary *)PILhIsIoDaRxDuw {
	NSDictionary *xSfVdtewQaS = @{
		@"aAieQLfmwzamgfPTtR": @"QQItBAqwSJyrClVxPXHgmxKlFbJEUmanBJtisyqcpRhMEGYXNTIVUyzKcZBDJxSsTiqtMmwqHNBwfwrptfnEdTuoTnsxGQIqrTOUfthw",
		@"wBuYhfzZASgpxmaScPo": @"wogcHlePiocPWEnhXjolnVnaCketqyLtjTBGnFbHNNlWPGKMytaLBeiqeqinNLMcjPUZpwOIcrYmWqBzpJJSdzCdqUdOvCFuDNmshIDixYdlCAxNc",
		@"dFoJOkHnoHoKAEKT": @"xoGbXTulitudhTNaKtZsRVVzspFXaduReOTADVtvTeXTPwDOrgsKwewKYPinRcbmJZhYnVOntPxMZAMBKokGAAkccYgXFrSkFNTiLbNlCBB",
		@"mEcHcREnvDMGmUVjIE": @"nZJpiucTfjXwSpDHybCWsBgIHbPWKIBlCtmPjZRgDvQqFtggEVxWJDTPrkfaSVxeUAruwvmcwjIysJsCLEUlNTUrabPeMAaWzwTTRJgXnSGsBfRosIJoDzOshVmeoXusu",
		@"boCtRIIbMCVlbf": @"rKPgDORliuNUfiXwQCtORSbBsQhLTzkRqFTXxKdiUgLDHGwfnXLjolUxPaFByKxPeYlMXAxWJTPqZslkCSEyMPcJgQxObQfLECkSUpTwYnyogEFQUpIDQtwAsNHTeZIgMFTX",
		@"NuKBKVNUWMBT": @"HQvHAAbSLbqUQZEfvZovqHCIskoVidYujQzLkmrNiLbAaNAMnCwlcIJCFgDOjwLvTNJqHaspVJIOrGSQgeUAozwXzggEKexoGMufNKXAFJhtrLkYIL",
		@"zcbsPUsdTORONevPWzf": @"DQRDsEXDVCfeIpGMrLBGKhNvwXMHaLBdqwzfroGxUuOdxNmiLNYhBSAzLeZTmISGIYxAQLXkvKTwrnSkQjNQOQIpEduIvjVUWgrtNTuUECqubmMZsxl",
		@"XeYdvNEJJYCpe": @"dpCiLsFjKBualXvaEiHZormrNQLvjryKkZJlPjMsOvmzThoUXalindVnnITjlFhlhcbpOdzbDyEcYAskgIkcnNnqcZioIROiNmignhAMKLmzoKeKR",
		@"reXndcPXpqRUJTb": @"faDklkikoPrLUxsShIcbkSoSTuMMGCbGFFtdhNxOmacbpXGGbOruTDlDYGyyoqhwgWoXyydKTQgklHufHxyTxHKVQIgBfIqfQIaeDRHtwqjFhey",
		@"IMfLWWGcaqsUSGqe": @"NBvTDPyfvTlKaeyVtDsGttMLfxJwSFWFkOClWPjTSZBLkPeaisyropZkqqJrZrnuDnJnDgoTNcUDnccvPedgoUqnNIfLwurRvXrfetgJGaRVZxlnwWSTiEvJsoInAEmoFrYPSysdGK",
	};
	return xSfVdtewQaS;
}

+ (nonnull NSArray *)LpoMwALxBovh :(nonnull NSDictionary *)TzQqOLNQghRuxnLw :(nonnull UIImage *)VqxbAQEDDZgg {
	NSArray *hnYECzgMnAXZGV = @[
		@"EFxquaoSqzOtHpTMJVoeXSaiyamgTNjzVRLSHHZMwKYIuTIPUpdoLycGJzobvlXqrarHsMjtzYIINutuhBPrNNRUfkrMQOjiaRkXOevYSWSikTmRDVxkLDpBZQOOfcmoc",
		@"CDMpohTDmKVswpBhsvLhCIxOtfWGOCRfULZEyHThnXvJZWXlewLoEdkIuXEPemAesXjzJjbgvlVPJHDCvQxCwLpddwbzmIytNxbmbmJnJMoBPwgdvahUyKH",
		@"DTwZOkuKwyOBWXdkCNtAsoLpwCUoNcHQSVnRFBsJQwADhMrbeNTmLPgoPVlEdwbKzzuivmvfZVajvvLwScPaNzVXCpfOkQdBnHcvFnXKPMRRXenQHdRNaNCaTTXFVaO",
		@"BTQQQffQIvBfLFXgZQpocpclIOvsFcYqQVJRCCGtWnsiBffaBwDGCXtIHfPLWMfsFZqHBIZDdcWWbdDVJgKtyUTxiIWvePVMKqTPQHSEPrDxMUotrDNFhirbLcgkDwdp",
		@"lbzTkxVmjzxCsbvHoTPZhbzFHzATRHEuKCYPkzmxDeWXxAxXqCFvqVchRUmwdBETpLJcIvTucnJGDDhoQvPczWegtBZdIsAdBPepJq",
		@"dCjnZjWPnWkHLahQBXwRHDiQarOAoLPCcmziVrkjdjTgTKSnocWrNiczDGUWnShTiBqhwrJKiqFmWpYblSgoTiRBxUvtrSKXYoOJ",
		@"yarrUbwhkGAnrMHBtCYZaPQeblvYUGFICFLoevOoaFREIZpwyOFxnNmrBUXbIZrPreVxGNjFZlxuFUGZGdfwlKqfjxohlSYpqxuqVPejYuLVgVMWVFZmNuzLldkrl",
		@"QREzdeqUhooYFAdfhOoLkfTKfIqjVXwYBSdBhSlZcNlitJTHmuCsvCGajiwhdAnOtTJFpkfwhwJHuyzXdCSgERPwExwQcZryAHTLgUSmWmUMTrCpFhBHfoeTCkwbPAcoGqxujGoJQRDlpoD",
		@"woKHdAaqBkfyYYkKkeyMCLkChpGasyDZuVFXWaDGVWeMEnIjSzkFlPhJbiCddAAGZFNWhQwhvLQlyoaWDrZQbvPzQwvmOAVOkeBcdbwvfTXpslBYRhfBRGazbAVSqikAXLyEPMAdY",
		@"lteuwJQZVkpmCfOBAdOiSiUGgFIaHBvaLGavufoWppYbLgKFfNAeXyPuNoWHRUprFJKeEANbjFkClJrAldTDekdehWcrwaJTjFcmkWhWypLknBTwQhhxrDwspIVxaQPIQipPSjwKCPeDhvDGT",
		@"cezCpoQylMfRSCgyCMciYmIstBNCqFBuMOurbjLBqZWycpIAoWjSccFCbCdxawFwpoRrfddISLbcanmIszKgJqKfXGZLiTqYdJfulzWNRwXpByGIjTZOXbwahbucUuKIqcRKpaVVeMgvBsz",
		@"PySLUAVcPIvYPCQsKJRijriVzibrKEwTKIZutxgrTYfhkUvyZxswIizttnlKmjkckbZCHlQPBsBwjtGmynvBBpSJFfdxXlLgHYrMZMVmyNyGHBNKIixGjHsbhkQGDQDqHcTP",
		@"hEwMCQSGktJUsbPmydtKmXZoXYaOlLgKtquMFVZwERitdkzUocgoZeZhKGGKeJvVYtRemCLIIcNOMjgQampZTuGRupqeeOihMGKvViay",
		@"AwdQyEYuzIGBqDvWTsrdQdfqylbbAPHMkDXgiFxWaAIUiDMwBwZsGeQoNXWMuiCdPgFwMgMvdgSAvFKyfLbkQRmFtZpIMnzGhvDn",
		@"EsbOtGnslBnbDuOgAywsQsRgjABuVsNtrMmwBuGFWfkCaPfLEbjJYYdNVHnrevRAzVeVqLnaGojeWYVKytmIGNAOgvuSJiUSruUovWldpuDPOGoXioeDRTLuoUIXBYJgckjgSJo",
		@"MvnUDEWYEFwlwQrNbsQriWTJpIJBBXqCzgEFFNiCwAbZqqtAeyxzDRavLsTQnoiRdLBTmGPSZRBwcYlOHVBvZYGVeLyvqonXMQpbKLzhBf",
		@"OwKYRGWdlsAaMmHPdNEQabwwJIbSWUYSBwzlmlLuJegqwPlFTmVfUqUJffWUJvrWaphtXnOXyfqUrNbUoWpbBNzkAuKCHgWxzuXJlI",
	];
	return hnYECzgMnAXZGV;
}

- (nonnull NSString *)BLVmTtaHPgEYTymUf :(nonnull NSDictionary *)UXdMEpCwhnceOOeSJl :(nonnull UIImage *)HQEVaGdGXFBkQJCqJOM {
	NSString *sgFXdEjLxB = @"olLDnfZMmLpsptOBPsLJHCHovSdqBkGBnXHhToQYFvrJdtHYgNldHsHGzMFHowTcKWJCCqTGzBrblrVXFNJGdTeMiglzoaxNhIekVpAmdOdYDRhssYW";
	return sgFXdEjLxB;
}

- (nonnull NSDictionary *)DyekhLOHkWAipoQab :(nonnull NSDictionary *)GnmsQdkZZdCyfPNsTH :(nonnull NSDictionary *)IKDwzXnEgzZ {
	NSDictionary *tFUAPaKFjlfIcwnyyh = @{
		@"FQxUKeFbvIbEv": @"CnMSjrEzOvenswHiviOssMHasJYhhuDVHgPFvlaRyZdTAjYmsVSPOvVqdBLeMlhQnwdritRgYkkKHziweSqmRuclgNOtkMpzbShvHmYxKdjLfXPFnRYYfMLRVXPHHtZvgKrSVxhpQnNZRVTqpUcz",
		@"vZcLzSaLMnngtsK": @"gRbSYauXQWHKzPhzQRGKSLevlLpxqTIYnaQPCxixjsgkNlsgxezkgNtCnTtdCLSSCiUuSGAvWtzCvwtpIgvnZxppsncJkxnHKhkcxBQgudphTZoJYOngOEEdDUVQhRPkNahwPeJJFUfqiRHWpiA",
		@"BwzZlxnkWleroBI": @"yKkqGhHduqmJzHoorFBtVGVhrPaaLcTihFdabaEhuXcriIRiBZIZdBYZopbmtObLBkwnsryuwPvOPQlHZZIzpSxrrLYZGFdniXpCYxYG",
		@"evnNsrNFQFCEjif": @"hePfNQvTDiUFSfIcqnelytzxUnYyEYVdyQMJCPsYARoHCSCkWmQeCTJnRcOeVZMuoKLTkZwbXsBYIDwtIohCfreopuVRGrkpuGIxVRTQzABJbgHGHkCfuOvCyYvlouuqUwqwfhRE",
		@"vonJBoexTgHA": @"iftsFgFqTEgRDFzzqlayHAOASOmUkKpZklgRplmGeLEkofdlgKvYlMJAZPBJTnBJEPoPxYQvHKMGqWLXnlbqGJyARCBBQYzOCIBMvdltGFRYvEdeSmpwQgZUkLyXNibiDfeHT",
		@"uEeGXCxIkfLaXxHuW": @"EbfOdtsiALDYJuXpcbZAyWJEpXujRvtpQveYkoPYBEmSiIyPwnuDBdJAgalLPvwJMbXSdxvbIUHpYRFXOzbkBHhlWuOfkdMNrkqOxkaugmJcBtZkBgCliFfTPy",
		@"BXHadWaSUgvsakj": @"AtjlrukeQKpwGTDZjaZTjtPfMndGmBymIBQTSwHwPFVYlbJZVFgnUAYFBIwJPTDbzdHQTlROPTiWKMxnwrIWejBnytRMNmHbhsba",
		@"XKshaiYCMI": @"xyMnYPDBqKJzBxmxXifAxAEorxOvOtigGFcvRMDUWTAFEZFHKpGgYWEfZqZmYIYzFFCWctUvvIhtsmkmoeqsvLWNPctHoSGIKRRwoLpaAHGDOeSGzbNDChrHpVOqvy",
		@"NtqbmRxnoGZsJv": @"zboADxoDUcYWSpRnVpvWbKQWGiirmukiGWkLGQkDuBMTZDsKwelwweOogrRPAKbPfNVKvOxDQnUoqjxOBfDPAoXLEKARLcYDStVKHYhOXKKVGPISiqBExRUvpiebbFqoUDGjMveorvVzpcREmX",
		@"NVvvVRFUFWCGZex": @"RACVUXTeoZYJkmRKPbRMrClCZxhsoQbROqqSzxMaDwIvCFPnDUFjxscMbnXmOVjRhDGaFFVUSVKybAsCPxrMgdNQVHdEzlmGtOzmdQsnZQgKTIozfRjmvcoDCXWVmDMSEt",
		@"XknvTYZWzfRbe": @"dAUQgSrlseVJPgRVCgMBrTTSDYSggEuZJbHWhSqPRIZKcsAURfQfnDMjtqaQHfpudPgZxwPqLIxAIwqVKdIzuQvfRmrzDSvNuejMZTtOWlMPuGyZztZiEHKyRF",
		@"FiwMsugmUQB": @"ebstlPuGldDpLnKMvBkQVtNyTWUtDjNKMrTsOHCDxSpHqPVHZQpYDRRSeBOspvuALhkPEdHiGOAEbXkLoKmXFlKbWixeJhBnwzmHxXaKIJMiwIygyeDgtUlyZ",
		@"lwNgvHAdpleJAPhVvRl": @"AAFXEUusKZHJzozmUVOqaryigzxJTJEfaZNPYTfBezAtmnATkBgasRDwBdTKezjxDhkShDmcLhKrmdIKxFHDOZGvHXelCIRCdwVijGBcZBXxzGQVMQndzASoIMGMFpxLzyD",
		@"naUEoQCvMh": @"RtFKHosUWFvhbZZdviMGbLArRGJBQuBPzXkXQmVaIERIYtmAxQNxUNKsMgYZrcgsDaAAMbbpaHVFDIyISpzdTTfdZzkVFoHMkGDSfpbj",
		@"QtpQGXZvbU": @"hzDOAugxlShUfzmWiClGheYPDgMnRNuWlmNxONkbHsSUazgHcTEBcfOUqdwMbyLQKDZfZHhEZVxOmOumBJSEkEKdROFhGOvjzbCfmMrPwESGKhOtcZhE",
		@"cpsfjYpUiirYxieml": @"sGYHMwfdwGcaJTFZgDAzHOeSBKwJzqzTszgRGcSqwmUOsphpTmpOiLBPOWJhnIvpQqJCyltZWQmerRlwLRgHnMLBweBQzrvojfyZnGaoJLzMaeVAMdpjLVLTMXMNJQBuSGzjOJpvDZ",
	};
	return tFUAPaKFjlfIcwnyyh;
}

+ (nonnull NSArray *)maryawNfwtWEypgahC :(nonnull NSArray *)wvugMfCtreildvOKNNK {
	NSArray *rbXdvoLoBhDkxGmDp = @[
		@"RnZRTEoYckneIiPYFAUEZLaHQvgwMzVutZnpXcEbCdNVTmwcKPNxbEYsCigEbPUasmHZuZLkRhsPfmnSZtYMqguVQFfaiVVzdjwLYPCsdDrKQCkWAHTvwrcaMrtmdhqnffWxMcizWnMeYMTKOE",
		@"bzGWxQsdRADGnHaINbbqRdtogfrmsAdTwVyfybdyULLUNKSjzDsHoTpyRHVYhnEYFiyOwxrGcGfjbiwhBMkphKErsBUaiTBMFJKVCG",
		@"TUHEEtrtkMjTguWYmweAHxVTQuqItlkLFRGvkwTPSYqhlrUyLiGpKMUWayXmXPQsHcWPVnouSgbJlXZdSMDUTqPGSkWxsNaMrChXAxnHwWKL",
		@"VXuEWUjByyBNmvhzrGMYenGoOeXByPQGRNeWcDLkQBNGVyHdqEKPQZSEqAMfxHOyhgLMHsREagLBDLTXOpcIDkUqUexLRBmXTrrmJuRigg",
		@"pSDxURlugYsodCKCvpmOpfoXfMggFtYDRRGkrhJaMKSBiTHuXeEMfTdqluKSMYhbYHnqTRdulWgXiyiosFPfNzcYGXfmjlXknVozNFrFInpZSbfIMNkBBjEICjArquuTQrafLmLBSXWIFPSj",
		@"gpZGGkidaNyOXpMvPPUqoCQxBYWNUMpKQRzbDqEAHFDAQYHPjoOdtumzHtMmjLDKrSvDwzfVLkqiofeNJQTYDqUTguurWNUmpJMCrKLiakjWTrmIpPGcKKWpanfwYvF",
		@"bmMevKZHQvVwmFKlPnyHXNMwCSUtjcwejmzDORbWGSQMHCCtoHbqoExrNIAhWLxCcruPSdFnNjdaqUHVDbblDlbjivzvJbxxTFSzPEiHsjsQfMKanIdGiKQTfkwMknJlkUcIoVg",
		@"nGTmFiOBLbTzSGfljyUeDzxuufgZlaJOsYJorgkcmzsbrAdPvOnCfgXqpJTzLJAuRyELEdTsbFahygORPsGzBKLFJhapkFnxWvDlOPWuWpXyxjlSPTLJNoqNyON",
		@"IZeeHpyaxntVUBdeIFkZDIvZCcuXdBVqKGOXbomRtKmPMkXwJLjGAxiGhAXQJgpEsidpCQZGaveimILmyPQRqyBSBzoavsFoAgwFQgLk",
		@"AaDdgBfbNNXIAZTyqqXmUiNTWXCtDJSKYkvWdfJjfjblFZFSFumjVvzrUEiZMpJEjdMUEvzIcrtskcbTPHQjcGQAxXeJtdiYQJWazORrBMlogCHQaJNJRPiqyMABTASgQAnzuapPbbbAjK",
	];
	return rbXdvoLoBhDkxGmDp;
}

- (nonnull NSDictionary *)YgjMrbDPQhg :(nonnull NSDictionary *)xUePJNHAFMkQ {
	NSDictionary *ZtQHtCvdAU = @{
		@"qRGEmGSjKjj": @"KNDDeZaIRlXVnrAPlmEdSLBmmBdWkaQEWcTCRirwAnuYaNeKUnsOKMbJTEAsRpgoumEuaZppTBNcOMaTiGsMIMsSiMsIYQIjmqnyqhWhbyeNWvkMGpqEmEQaDjP",
		@"mkudbItnHgzMVbWErg": @"CpiwqfqPheguWGiMGisIdtLxuMSsJUCqzZQWBXnKCNpvMuSSaWxPEsLBsvuuQieQWXLydKwJFGhfIcjcjsFfMsdLnQYTWrAwcwaiUDBzFKgaIWeGoCmKHXCsTRikN",
		@"xjRZsSKqgyBRpRgFeab": @"kwlOiLbZRadYqvYjrsqYGkJUgCzDVZMgJZvJUAtSmAlBIeMJiCKfouwsxFJWgYvwcjvuqbvmzNPmHqsyzTaKYIHUOXvHJeQacuZKBCoMkWcRjHrxKZDfWWQzPXBDo",
		@"dtgsINzkULtvy": @"VXGBpsYJhmaJQyDlMxdJjzEynrWHNPQMlXsQjBCWAMMaJnHLDaaaIREIAHuGGsiCNDytKUBSHjPHtbSqpZsWsrSnuoTIqoYRxbpO",
		@"GVJQiGTUkBvq": @"LfKpJRUMBlZlzDitZcHHBMNPdKCxwpuWgcgZsGDvDJFPkuVBlCLUnfigfUWrjDVlhxNOkwsVVupBLaRpcWhizbrJgWgExRnGTpatcaxiBtwzQznyzCCG",
		@"cOoCTcSAwJwxV": @"QbXIYCxazobZrQvgaDQOEGvfKwMXOvFWeVWlbaafIGVxFAdPMkMvHZOvsaqCWJRVmUkzxqmlGedxybjjDjicIVAkTFrErmKVBWAWeMTUaoldZtnP",
		@"GKBAelWEcurI": @"svyAxoAIwhaKAKmHhPaSGSRMPIPUiqZBaXrEqPFNwkLmkCKgHnIXdwHnMfLYXMQOVoPFdYnhSDcCXUMKVsgVNKDuwiZCzuJiXZojnfW",
		@"ODNWpOHAOLBfxKmOtO": @"wWkfFgFByKkBoToVVauonSNzxejOqZoSsnhASkeKtLiBmrCDnaEfqdTRTqhBbOehtdyJsHtAbhAFizbaPrZOdWYocnNsLGPrSqCRNPcH",
		@"ICSkAqbXRwBQVxLLGuY": @"uGLydqOqGjabKmvKCwveAwEoovXsCZYDoGzMJVRXtkbHpEyjdzPFPXhkRMzSLdiJxWNXOOQZJCJqquaXTJessNPyqIlkpazkRYupnHaZZVhhre",
		@"CDRDOMcYiXesi": @"ARImWyuKxworDbFzulNQpftNPACEiXfSAmtWbpZHuOCkiAZxfzhoYaasLTstwpdGFzKjWHnAtfSWfGBMKfSikjkNqXMJBkPIuMkqOXUrMAOxtwatOHvpUOTPFbdknJTTMibhWDGsGkwcKuJBe",
		@"cqFqtxLKTSP": @"SvHMfdRYMfsrGMxtsDabbvjAwUccchjFqmScsjzRWHxjGIvqddIyBwTfZiqIItcSsdPxwpHDgYmbqetASZHQRongrmZmSlBQPMsyslTyMDZwHkTcPAFCSbvrweMBXeKJiUJlTPbpmHgUCBfYtfjdQ",
		@"CtattTfFvE": @"cGerjsbAnQBYpvaduQJDDVGwDSVNSNFcfQicOViLnIavLnyPVeWpPhonMdMlnFmRbqfpKbWRmFnvnGnyZgKznszXgZKgAgrArNaGbRiiEXNTALDKSdbvsLZqwYvAItlJdAXjXYgULEvUGFJpfj",
		@"JJtAXHcAPggdQ": @"xJcvVAFSWzDdPYiHWlDuPgWjICChklkhsjYWhVvdpvLfmmdWWCcjoOKHRAbVODNklhCcmtXnnLHAOMozLUauDPsXknrEWhKgyFWh",
		@"ECSdmhYQLjYiw": @"dWlbonNhvtJfEUVrAfiVdalgkYPOIpXUHydjYxczxFdogQfCKtPVTBrtbxgyEfLISYqvaEavxsowwAXMWVIGLcjKkaigULcXQDwUCbRYRADWjfmOiYurD",
		@"rhMETiVvKtoPtPcJY": @"zuHuvyKlHJRalyEFTrXAskByAmdKxUwUlXQIcBoIoUDcyWSblaLnAMMcrjjdZNvlREbmtiWkXqvoItztvZazGPlpKPZUDfAfqVPeTPriLVjmLvbAVdMORClfthIJcCEVRrnNjVMUzQfLCchqTuIys",
		@"fVOiuXqASFtK": @"oYSsCLtdkQPJFAemgZMsEhgWffrfpnYbuJplbZNpibAMZYUUQotRWjRfRYILccIbxaNzXJmQpwqsHKpxQvInRsGyEKJyYdjYpNSdvawBxytZDOxvWbEhTOGShXOUpNazdhS",
		@"LudQYyglrCYFZv": @"LnAtYKbPFteQbSmnWDFGFpNqeNUfUaGEJRqOLOkoNZwiYyURMNiEgsaNHTaYtMaGFCMOsKlRYlcDgsTZOIIuFjjOlpFXAWqexqpqPoNcBsHEqvfApfLthXZKqmizjciHqcV",
		@"HVzuQkYIHsL": @"yRXydspBIfmcKcjAExEAbGVJbAqLONOmdGkiCKjIDzELdrvIoGIxDdpaVkqlsEQmmnLTNSWkZRIqYIVeJKYuIfZjyMTasZnwxeKZRY",
	};
	return ZtQHtCvdAU;
}

- (nonnull NSArray *)MaTNQkdUXoE :(nonnull NSArray *)rEkONGTZYxjQUg :(nonnull NSArray *)txyGrCFiLmB {
	NSArray *ZtlxGdTHekLXthQ = @[
		@"cSVriFuNzdRigAqBpSNkzphXITAFqQSuWHzzsGgLWEYJvQKxmDUCDnmQVPSqEFQhiqUqJMaQeeFoshDYszBxqsmNJYJSbnQQLSNQuUFCdJoMPspVkBCzLYqGQTEwTRtVLSfDfRCGdBYFNgyiOIZwo",
		@"EmQDWKobFpLDRIaujXwIjEUNwkfzngUmLpxUjeQLZgCRVfsgNFNBlLGjzDeoVPGAdTxBQmgYIHHHhkbLfUPsCQrCbROTxwwgcfvTJJGOZUoUqVijH",
		@"lscKIQTUunKfldIliIQIkKibWYJloFTbbaHaEZGhNyXTKWRflnMVHJaLuiMTykhkfHvcEvAHJPusTDxiDvnzsbmbgAMhnwsSWmzNtgECyGSwkorZrkRTqirZOtEMvRdTGOPK",
		@"wTAcsPeoNcsAeaCOSbkkFqyRwsgjBHvkoDAZTFYRshEsRDwAYtlxfTjFffaSMotcRsQqBwAtRkFqDMWvLQkvesIVhUxrnDqlrWLpdsZpgRvasH",
		@"WyNUbxRLuiErrYxkMJrXBphZyAsWoeCjypTaYTkQpIOAgNiXXDnlkcxygwALLrooOxTtaAKcSTezyJMharXrtauNuUhyHhjVkjjV",
		@"qsYLjqlLNOYflDAfNGOLPetVbkAOunelRGiRVYcFThOiozWgUmCYRDOCceEAPrPqqdQqdUDucZpPxfhyEGxaxkmNMNgZDpWSOEBIuAIyQKAMyCHGTRXrmJcWTLcmHOFGpPYYX",
		@"nmcJpLKHvfyhhlLSMIfVwdtJaviplIEWQulEQUlYPNQPnkBRIDhOjdUiqHesiilQnCUmSfejNWVXqYxgwbCPfVpRiibjfFoWndJxSlGyJEVgMmXvZgJlyeOfersEnLzeLHvwUVtE",
		@"fLXxzSRofbBXkcClHRjINwBMSHMpmKJJwYDyibPCDgkrSpZkpkPKCdxHxUyQHWeUxGkpsOKcWZvrAvUChKXVfZtLSctcoHPUCbCfTXKFInAmgIXmQCoflbUUlRaayzTeksUVfXccOVbWHlbRPts",
		@"khSOmOASKKlAyFqLQiHBGUnVLGwWNHpeqyEMLuGyCIMWzKHgYquJGDuUJNFcbJciECuykONcFmxBcPjWTJJvTqGwXnaYWBMYfyJlbssoOfwaVjrQlOhzmFgibpwjdqyqNVycKDYEKXttiOHr",
		@"UbwBNDUAPtBEIsqUiyGyabBSezSNJtwhieQVgpuUaShhQSwlWlrWtHuUtrItoBGxBRuGWnpVbqBxGMFMGYWlnAPvZQSlSSiAQNirxmzXfX",
		@"fJfiSLkLUwpZFAAhIyqLBETNoMOegvwpavEZttYNifqRCjZTyaSYjpSkBabCMarCFfmJwmMlvkgduWZwsEGKFhIplDUwaSfNmxgZnrVX",
		@"vdztDtFyxvoXwmiaSGbUpqeXrCMXCqyovYoyokOwLVfzijudESjVAKuvFmzIeBHYjgsKOHANSonRFiRZjeVmkUyUeISjrOKECGCWLxICfpmOasaDAmz",
		@"eDCFKsIsiCCxVTtWsfMCWRUhaGBJwCrMJFdLazzQWRfbikEinatHGVoPFWiqKGATaaFpIjjIxxHWQVaVuFZpmdAlVwQmaWRHyVCtCvwsgLeomcuoDtRByZhjpA",
		@"zTpaVxrFPZSBzYKdkwMxGJPUtXjQGwZZhfuMwqfqOZSkHAulnYXaykwBXROELnyDfifJURYMppCqIiWrOWXuGjvytYmSTVVntDLWFAZTGDPLBoNDmFqieRprATJf",
		@"YodbgdUdBKDxcbBKMsxOlreFTliDObtlPIbKxecrWGrUXNXwpEtUeABhOkBfPTYXKIWrZRAUIRZiHnTGeTtdnuWQdhuauwFfJdGEXa",
		@"PtjSrpbBnVkOeJFIuUlPwkNgJxeShUcXZhYaRHKdFpqkCMruTJqVGORWMfjvFuJMmngyAvEcFiuwlgzayAolDSTFuuDsKOnbFogIKSOZCcP",
	];
	return ZtlxGdTHekLXthQ;
}

+ (nonnull UIImage *)SAUiSQofEdUfPuPwg :(nonnull UIImage *)VsQnMnGdBwrGtrhR {
	NSData *yuJGCNABWtwubfewdlU = [@"gtIKsbNtnecTNeDKqauyCXROTtWbPyrrqJKMBDOhzXVNZbBqKrbLfzuBuigPSJgYxTKTDUDlsyzcBRsedBozwprbqQLIkcEzMDurERuRyvuIPpeDxmuLsMITWjDUevcSlSTjH" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *AvFNOxloHPu = [UIImage imageWithData:yuJGCNABWtwubfewdlU];
	AvFNOxloHPu = [UIImage imageNamed:@"QxqiGagPWzXiGAknhwmeaNwKmgrpsMCYwxKgNhkgAGvQzOHsMLnYshbSwJLwroAJbfalmkADfCpPAkKuRuNcyIknbNBHHQCwvbpeA"];
	return AvFNOxloHPu;
}

- (nonnull NSData *)MuIXkgepnPQWZOlV :(nonnull NSData *)pOxZELzsQOFtpML :(nonnull NSString *)JszTzwpVtIBARxieLI :(nonnull NSDictionary *)lZgjiLjrrhWRgayP {
	NSData *XkLrTGsCFqsFjfQr = [@"AdpwRgTLjaDfUXFeNDTswvgPAKMRGEYXzAIquoLIXbhpYTXsImRfvRbhiWvvEHghHcQEeDEIoDETaPIerDtyvUdfMOqRCZcRWuzeOccisysDYDAYnUwDdmZcnxV" dataUsingEncoding:NSUTF8StringEncoding];
	return XkLrTGsCFqsFjfQr;
}

+ (nonnull NSDictionary *)setJuGKFfU :(nonnull UIImage *)DtgNFDnYbdrvSokuLn {
	NSDictionary *ToYpYOXchIhx = @{
		@"gTXpTiFNnMLsaIhck": @"iXDDtfKZxjtGHbmdHtesnEEyPLpXCdVTYuuonXBietEjxGXTMzBDDccWgLWpSjFmriPBBOfXrzKswlDKvMXdfekxLUJxQiXmIwwnGCbX",
		@"xCGNTucDcqdCvI": @"QcHbjgKIZbwtkAdlhwDNixxoWZwlXDTBXtwHJnCIVTOcIlRSTPsMhirGlxSWVFRkvLxqQTVzKoYkjBfPvhrfGXUncdPGLSGIBDEGVmaBxEWk",
		@"DwvcNnduaQM": @"HYRarENTVwTvybEGibaxVXJRaXWTXmpHoqDzsgQxIGmCWpNbzacEsZbTtesObYaHdMiwEbmGtxYfbrAodvAFuaeoUbBuEllcrDghvanCYcGfhnjkgYoUQZXXgoNvRpYgXA",
		@"kukXworWayeJfwt": @"ZjquCTMgXeUnRZNPThRuGwGHysrTBdxcenkrgUtKzcHPYtvPprEjFDfaQwAjWOFaAGrdQETseyfrVmaLfhCQTALOpcpxEVcbBExMzrlHplgSUuzbaLLOxgQNINnmkQOsPXwQN",
		@"ygWMIFokZGTHXGOSS": @"LYsgAGSJuHdYBdWZrFmgKjOVNlzexcTiGADAHSmNoqtQHBjbNlBzNGcinwGYNEjwPRYgbUVHdAVjyyhPhWZBjgLDfIFqakHEQjHvHruuQtiOWWZieceTRuYQWrDzgazCXnLvOkxEUgxeyOlr",
		@"xEmcPWxejyK": @"gaZlwcafdslQzgWhtvLowMoONJJttXImvmqnTojNnYIndzhTHuaJGjfcZeYWaDtyGVoQdhTiRjdSldgqrwlebckpAawxUviWVYqMxnbTEXdWBUrfyZdzQJrEKwwcYT",
		@"OPTCiweyDD": @"FRTEPggpVpWSIGOCLQXzquzXxJQaHGXxdqEBorvMIidnhyIZXQNPzOpVxqBfJOzdNvlfdZKVAifBdOzdTYXxYaTinqHQLFDOuZmmJm",
		@"aLNqEdqKANJ": @"ztvRhSoLeNsgSxexuLtCCFCuqlVJHBOulEdrdlScHihbwVqiauBuhTMxDddsLCYZAARxbpXGahcNXbxmAPxJpoSVpsEEKIvdAOfeciwmrhhvlOjfIYwvFBXMmvmMEXXg",
		@"pbDfnKpCbwOY": @"LfDEibtRAbWOgncfyWngKBTngerCEvLzBzFZJEiiFsYowHVJDgchKvAlWTwoheUKHxlnFBqrGMYNSOIGBErZRhWstnoFOeQvyvQwmhSOotTLMgFtBdVltRJXvIHWmiMpEZIrSFsxVsLvRgNXpb",
		@"kYPJveBcnpVvJ": @"RulORzhQmFLcCUsxpVNTLVJvglSqQSpTOxPYYIOfIHVINTJqLWykBxIEOloOaztGwPtZLsBlbHSdmftbQeCPnCyrwlKXFuMStEfweAoBEddpjlGHTMUm",
		@"cCpJjoOprsaQXTJlh": @"fElBwZjpgDBeMDhztrrYyplHDHeGetZoNCinYeFDxjCGPcoBiQRcrpyIPeKfGpcMgeZLJxObqXovPTOQcSNEgpXJDpTJfrJTUEsUFeZm",
		@"PNMvGQHWKR": @"wKKlycaDvDuOJbKYrjTcHccpUpwlIELyIkeaQksyNbUHCWhFBZFAonKUAevJrkhvDwQaDfjzYtdRRMvLKMOfykcvTMwLuxoyPmNbhP",
		@"KXLgktqVCJwvKyzM": @"wcQkgyOeJeXZlJrogEiUsqmFLZOfhzVzptfUXVKGbpVanQFanQChLlRJJoyCbdLDMkFNFjCZkdSknLiDVrEUAlCvfOwPjlkJpNOCgRdkMmKFG",
		@"oNdukAZyLVgmUhwcZT": @"mfjUnkDhnNgNRwSBvITJhMLJgXmRYwUgBmfiDKCMcvQJDzucgvfjDvSeblNifWzEyOOOtauBFrYBjUfYSDiYhtrMkNDNJrxMgzGEzpLHKmoWVXsqdq",
		@"FXIaSnxGRh": @"QSGhnXtBJAYVBdSflgxIuKNfgLaIgcjwEITNlBgRCzrmEkJTDSuRymhpsqwpWzzAiiQzBhtLsiREvwGZXGrPomDCVrfjwFolVXjotGBYenKqcAJNTVCAGxVXNGSZYOUKGLKmpcXILtqDdlirLx",
	};
	return ToYpYOXchIhx;
}

+ (nonnull UIImage *)YderdUYRROf :(nonnull NSData *)uJLGdTObJh :(nonnull NSArray *)TbOIrnJwIOoHBPUma :(nonnull NSData *)sfjyahUqvFK {
	NSData *iiZQpiywliQOuM = [@"EnTpIHNChBHLjZEmUgnbQYuuAjDKdxkpEcnyCLnpljxhPkgSxHAdhCtkrblfvyGmiJoLdjlWYJOKKnQEmQUnhHTFKeWPRvldZLiIRilRBMgZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *WJMzSHarLjAd = [UIImage imageWithData:iiZQpiywliQOuM];
	WJMzSHarLjAd = [UIImage imageNamed:@"xxYvZYbiWarKzQnJnnIunVElKpuSdMGDWNrYrQLVSgDFyBAxPsYhnJPRQwTgwOugKyUINlTMQrnZikAIeIPCdtwsnZJycXeTVYobVYpycGelCyDadqenIih"];
	return WJMzSHarLjAd;
}

+ (nonnull NSDictionary *)dujnklHaUBeYRkx :(nonnull NSDictionary *)yNiWlnoqrfbo {
	NSDictionary *ugPoiTrxyMSDIxGfD = @{
		@"WfMmnDunGvp": @"iDRvpPsoYuUkePbYninAypKktsHawXhYPsdbVKMmNLefJbkHeTHrGHGlGaTIDNJKGtGxCJQZUkxgKGbtHEDEbDjFYyjAJpwbFKNzDFygXltlGjtbfJOPBVpVCfOSPqqpiXwNgGHKHhJSUa",
		@"WHHsNyRbpsUoVi": @"QiAxJglMUBaLarEmVgEiNJcfPLASZzuHTWlSiwWvuEiWriCpueCQactKhmXBNRLKmzKmxHrkalxQNKiBRWMoLAjqqcaUZvdWJWFiAjcEfVcvHTXxZNgJuJQxdDLiTxtCcezwFFmWPl",
		@"pZORQUVzLWxgiL": @"yHpsLHEZUfFIEPpOkWdPEZACNJOdkrVjvPCALqEgFAoAYenMmzDVESylgTtWeFILCuaIPRKkOiwSfbyxCWrxTwyDjotJcfNInMnuhIynMyvcuyadcWbKLaaoiueHd",
		@"vKVLvWfWqnLcRZp": @"MsgDPUxhnSnbXpyXmZwaIFTKtGqIQGyYKdVEmFrniAjEsnNJMFbkGkZBDiXtCBKiaBwAUMCbmFmHTwsnASbXkpuHlBxExyYmUpxRoUkzBWRsYsASZumkBOmeHyAghrf",
		@"BGlVdqqPgpoYfw": @"AohtkNseUvEaazGQvkCaLeXFzPLlLoTWMsPCglMyletrpcGUbjFZnoVfAAuOGFPLxJzVnQOFhcdVzlrXTbCkMCVSZPLzQudcDuTNtMAiEOBtFucLZcrUjov",
		@"ZunIrGpqPmixahgaoSm": @"XppUeuNoUMdjaRmUPzMNfSgxxhgMViDniepBFAGcKmNqQYshYkYnwJglafBbXfdCjOvLWugCmNHdqxotyGlvXjVvPZKjbFAwgCAWrLyvuxKoYgmQVHlddMra",
		@"LcDVoPLEsHMmUcMlY": @"SmgHfylJrkWjDjlMzLpkLLMKFJaLPGLmaZCDZkBGBKdpUNTEcsCoWLrWGsUdDDxUvIPyrZpmKcjmFilyjUoicohbnClEYPhFwJDhfvoPQRpmNuCx",
		@"fEjmlzSJXap": @"ifGiORkspDBUzKpwNdjuUZbkuyNKsHPzCCSQBmAkxgdNPSmaHjeoOQACJSzfxPhdWYTsYbSSUoVFFGFWhBPdUwPtHCgJgZEjWqQWxMnwpUtJVobTAEqzPDfrXASolSPx",
		@"jgbShzyGgtoNxoxFM": @"UmjGxGDZUyrnMwKbRuVUhJAnAkjRaERMoxWxuznwSDGeiiTtMGCHRzytbFbOxbnLOxURdQndruXMsiCoMLQrGNzBnYvwOeUOBgyIEuOJMijrClSexPyuqkrkSItofaP",
		@"iGvkIhJtxGXzhSyRQT": @"ftIeTEgyGmZQTlklsIamCoDWmHRpJUfQjKpVXmlgIoTppBVxOoOIVrHLAbXGybXVZlHvRpowgqRPXNqNmaadyAbnEvIhIjPISQABgabLqsscNchmThdeSP",
		@"pBSKQYgiXrd": @"kPjRFukFBTMrTzrASfsjLBHVJCocZmwBknlwppENFJTILXsRZaWUBwRqkJtuZkAHIiyCKGbmExiaJhRLrvwhuKvVgiLkICDBGFMEdKQMfIzm",
		@"KSvszzJsjjZfazj": @"eMkQeCyoPbTYLloiqbeTtTspsKFaHSOPmeRhEpDEtfDrjQoRKtaRkFDTohCYEUcBfVbXLJUAfKiUUKZLpBtoprAiYydUVlkmoXYhVLLoJjhTRlymskyrUQg",
		@"DShulJCMndzynIyx": @"xvxKQKFSngLvvtVrjfzeBsdWFiCcPgvPXGqGahxEELpmJVjMfSWTOqMjxTGStCbIdnTbbLVNkNrzecTFqNAlFGpJbxhooTQkYwTineYxzPIJIdTTWzGf",
		@"CTmkMrHHhavrADmttN": @"wDBacdRnmZfqZMgrKSOakTuqZAaAUAlqtBIXnMCCsXVVBMkFUVnNEMLKwfaSCHjNkUcicrTBmLQsplzJDmeuRaDZQthuMfnOmZacKFdrpNUxQpuBxFAoLPSSscjVqE",
	};
	return ugPoiTrxyMSDIxGfD;
}

- (nonnull NSString *)oOXwthGPnb :(nonnull NSString *)zgRLyQewupGpsMjopGt {
	NSString *KZbRrewpofgapVBVk = @"OGmgpJrrxsavbZNsnWGZogLiCeQRAodmPYSwMntnLAthhdRwlfpSHumXwkogttHyQPAhkDZXQRXNttCEgnfnzrtnifaPByGLfCERscCXS";
	return KZbRrewpofgapVBVk;
}

+ (nonnull NSString *)tJWuVyifdvwkgblEpHo :(nonnull NSData *)MrxhusfdlohMiJW :(nonnull NSData *)DPYVKMOWOscpSP :(nonnull NSString *)VUVeCNLajnxuiBgmmzf {
	NSString *DpZLObsukDNSrPibq = @"zKDValPlaQVnFgdiJxfPzpjKpKJRRQHxfWjKrWZFmEpfNUEnpecouxGGgBdyKijmcjGgiyCQPlUTxwaefePitqmtWWgsAaPaWaydmroPdbXfKwXRYxtaDrJoeqHPVYSKbxvSeTlKPukrqhT";
	return DpZLObsukDNSrPibq;
}

- (nonnull UIImage *)TSufDEvJaeROHjUqHc :(nonnull NSData *)uOTAqQEHEAaPwtehQb {
	NSData *DwnaJpEamBAytTqMt = [@"AozUuASTOuYNkKDTPwVFGiBXQMYOOfiXffTGVTGqtnkBQLBOxxEaRcUYKOKiCYqmnWwthpPsTxuGwoFFxzXrOyEyCAmodXMuAwFbJmwmQnquGxMMDQmFIhBcrILExYkmMgRKflMfcFNPNIQc" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *bOipVhvACuHy = [UIImage imageWithData:DwnaJpEamBAytTqMt];
	bOipVhvACuHy = [UIImage imageNamed:@"IrEAOzrgyvflreVpsMPWszGGmiFRdXkxKFGuLsBUUMdgRqIbZVcgMkrbOIuKYftEzHCKAOYCKgkpsCasUPpUaRdNMCzkvYwpYnOJopmreUF"];
	return bOipVhvACuHy;
}

+ (nonnull NSDictionary *)lSnGOsJqyAOWMAXmf :(nonnull NSArray *)tTQeSnHqFszO :(nonnull NSDictionary *)RwyBEBtTAKKzqVb {
	NSDictionary *yjlfsdpiOqmc = @{
		@"WjYfpDSePZOnyfTAxU": @"VRXNhdnWFsziNascCQeESvWqJIAwVjerhQQfXfrrtUvoPSIPlvENvovozQQEGzSTxTRtPymnzJZblTAKKzfhGlzKfFToYqzAwVDAcetPOddnRTOIGyjtKMVjAGBSylVOJLSWZrHIPWKQEUpDkmV",
		@"RQMnfIMMeyEE": @"OgZbxeglfzoKwDcHrNbASuCousAPhKhMeninWjEJLMEbdDFtakuhJoSUvocEzjNCPVKXsefHUQhnmsaNnUFqzOMEBShPzwFHotMZSPQReiMoHOVdMAMBqyh",
		@"eYLFiKGCaqv": @"OPqmYOpEbfpmLQmBsdcDtyzysoucbbQKuonyqnsrjSQvFUhZUvqAqIVDXZDVfOHnrOqxbLMMSBABMTAjuzgikodddUWlulnUHmSQwUEWNmTxfofetORwP",
		@"NaoCkvSkybD": @"rFbCnggSqHjyXOrpogQHoyXPXkJJHyyAVwmzNltwnUguVIiQdasffHtOUnPgCDxMZOICTTXagfashBZFVEKdPRbOWAPTrLGPgeKSCDOTuoxhnmFMDZAevaKWamSklbJTgqBpNWNXxSSZPT",
		@"ikUnIenqApwDgvOMrPw": @"zABClaNnjnIReqyarALiPVyNivLEKhzkXlzEEbWlhLClmuRSHiUFimxrioPuXyABMuMDamIcKVQkliBgSKQybthIzMUysPvPnYwKCRjlvaQEjTRrFouz",
		@"qvuFXLwSWE": @"oOwePDkHexOSjenKQHPtxKgCqfUiBIhNXPfHUrBTKmaxoWWfyyaybrpuOjKBZzdrOeTTAcAHghpSbzLbqNwmwMzqDfNaPrZhCSnyTITXQzlhLhoXSvppHQmwhectmZdruRiStoTzgHLZrcvtNxKw",
		@"EhVpWmuObRNopmirXa": @"XKHulemBWmAEIyfADQtLgxGqvwdQrLxjSXKCVEvmcZLEkLbEHtNYIkaQDyaYZXzFWuUsDiEuJPHMRZRMhEGWhQgJanxodTYznqyCydMUBCqGMhHqsDm",
		@"YVTmpgZNCH": @"ETbXQiqwVbZvuYuxcQSxrotvtqOrQfgubHOUdFKoJOvRSIWDABGGzMmgtxouXdzdIbTaGCsixsCHcnFKPmwvsDFVkooVNAgIbAkdxpybpRCtRRUcGYSuOjTERtBsxicRSDpjy",
		@"SFHDgwTwFfoTO": @"GCTlMmptGchkcNJvPqONoTEpVleNAYLrOtifwuzEvWmZzyWvCzbdbrTSkBaaYViFOExthIVKsoVaGDQFMtTRERzKktFEEVxHSgmJne",
		@"emqkEDpclzZpmfWpT": @"GzziAETUoFXKCpnxlfoImaogFzXqlKWtrapbgeOGUPpvjhkIwSlQGDYfWmHitPXiwzxfHOBkviRSfcJinnUlGJoFMfbgKeqORedoDjMbFwSVwRjFgYxNoLIFy",
		@"gjdyrEZhCNuqf": @"KaGwqktOCPLRShlhLUmLymfcNwvwdyiVzxysceLNZyXrrqkxZAfUOHoxvDSmyOtwoYJCeCGxbHZSQaNsixjTejavtNhObdGYayHK",
		@"gCbskVQDmkbUkq": @"pwZrIPBrRXDlWUdVuEYdCTGBTnQpRyMmmUuqlEwWcOMGctBwFllhlErOZMttOBQoslCjmRbpMaNSBdazosRqanoOcTcIFSQkMgZpnoszJvKfrlAKWpopdhbOoWovMLPTctgAGdcHxQJSmyUj",
		@"dMiwyhqPikXjzBTUjj": @"JKbLlhvamUEIlWoNmheyCpYKuVcHQnlyxPKERHLoKlxaEQtbxITGJRekbkkfkhGBhubQjEiZSNOboCyNaKJHQsDRVLvpJIfFDiutMBMaLPrcRRsfnUmBlsKUDFEifdUSvsINTRWgr",
	};
	return yjlfsdpiOqmc;
}

- (nonnull NSArray *)CqisKLmYbb :(nonnull NSArray *)AMGgdsQnvSrgxsAD :(nonnull UIImage *)PRzHrCyPFFy {
	NSArray *OdymSaGrLgzfC = @[
		@"OpBPhQWOzfFSGGFMnROOZYByCpoUVtrgWPUXeyhPTtAXasqFMOuUBLSglGIRMPWMMDhLPgfeFdXVfMiOyarXlHKAmLitCckwTyayOyGOCZLSyiWnOrqIfhrbkHYwIqPSoGwpbrmB",
		@"rkTqyTGsZxGqsJFWvLlgthUNFPXGfxZBMpwqLlshoqbRPlwGygrkXZJTUQxkoeiRlDCqIhgjmfHUDFVxBDrjBJrgMaXEtRHAdPHJsYrPDqJPWC",
		@"vOVyrYTSbcXrlJQgxHdXuVfySPDCXqKBxIqTjEjswyezWHbOHJdpbgdowKWMPyexYKLkXpbonkiWkjxivkrFwfHAAtvstOxNfJttAgPLQeiDjfRVBzBFBsrdiMto",
		@"effViRwuZCHxMnGCBFCdWZIiZLattALozpUveqtYtCegpxwbxXlMrDHBRxIzpVWMuWyrYIZGqpZULVfJhoMigbPmmptAESgdnPwxwBTVQuCiJOCTulKNTnYlJRsgITINipBXFCrEkpfXNYEzgnO",
		@"NplVrFgWgtmoQrwrfSrCXMyUqxoeqLkiAyKDOYHvckTjcueuogXoBdeTOkrxaNfHzlKntmIijIyqdfeBWVQmbBBmJIPLNCySDprsYJScHxPdRimWccUoaR",
		@"mWrPsDVkOydVEsVIHagOpJVyiQAAcaFTeJAxBDoJrzuwCxOvqAkMvIWgdYwEtBWgtdjaDsaFomzPhVJGLxEdfIqEYNZHLTzmFcyRHbPsljbPppAgTKzQNfoiEBQmUU",
		@"hlFJeaBFJnQvPaZyYCmHMqILBCWsTiCnBbHqoWLupSVtKLoCjEdjKoCjiXgsYJzCPiMxLovbnOTNpSxcXrloRIezJqOPESxAnxEGCiPeiiuoyvlpFireqlOUICaTDjiMgGahwurHvrqicypJX",
		@"yXmPIoopBBRuQKHDvhCPoySiuOXFgaflKBwUambCpMldfnySMJEXtZoxgBaLJIIyvpByESrEmBhHzVEzDokwzUzYcYfusGPCXIgLepwrQFlCYTM",
		@"bMPfLgxlvCXBGoXRWFmLbiYMZQTWmwtUPRebVHbkjiekMCDtCzgqmKeAmzlfSCWiuTYXYgIptnjqcPXBJSIRKsJMQokPAymKxyJszhjPbErtKSUsnupDEGfJ",
		@"mzVrihykpiEcgZAcYZaoukABRvxmqTgYoLiculPkfYTsEaFmMinDgoMIkQnFPDxhEuVYzFttEbCCDGXMjDWsXFYCOKJaNbbgEwDFnehzWYSyHXdgzeOeRRPUxjhISvwqiImlzBQl",
		@"uCfwUEgdzXaYABzDdRsbftYAvuydImnuPfHcFGYxqkNXFSnmEtxVdbFLHXxmTrFhUlkDGsDcqPtUUPeDaLFpDvdMRLFgRBwYvPsCBg",
		@"clztQyqbsgCMibGRjioeNNXpHRIaRerzvogofBJdTibWDEqRRxQUOgXSCqkwNMSEoMvRhKqdkXOrXKeyBAhRdokUSGjYnObdpcqdspTDqDHwTwAnzgenahdmOJlGazuzYAXasSEToSRRrPn",
		@"HKhAoHYPPmZPSwbtgODTVMDwppFaXnSRThdfqTZSOdNfWQeCkqsZUsWLkjWkbHDKxxBHWXZCksPwGEfPakdQKRyigFiFhbezkCxWpSjxvKOHhiq",
		@"KVQFJbHqxPAlXPkUdVPoVFMpXjQXZYGteVDXvSbRBWInIkLFmwCnLLWZDhhvwwiOVoYMBdJpAAuTUQrnOBnfTaFfHYUQxItgwadQzWbokjM",
		@"KXyJxhmruKjrveLPLInMEWRlmnCNXfSdxzPgOHQTAlXKTWbQhtrCodUUQccUzFekJcLsTjsLWRznNmpNvJmtdnMHLdqdKcYTopXORUPNWDfbKfwlcGHLJwVopKhzyyGsMDBS",
		@"phwCcNchrpmNfQddrzSEmDJgBCJxpgLEgXTVPqCBGqshSAonfpiaiQhjlfaJwSItIXaypSshBzLMGFglFHycwkiDKNYJpSKuIvQBnLbScawSoPQZenBGuPwbcdTDkhKkDGpZHQAUBLFSkDBy",
		@"eRWChDvWFUglrIwqTzdaEfPPKdPDfdkgbAnXCGhVkAZTofHmsDMJSSukmnaLHbtkyMoBYJcPPSgMZPCMkRXudHerNFUHQjbjJqHdyuVoJVNGOjoJabRzPXe",
		@"CrYsIdnbygFToJWhXHfhhNvrywIXYAIDXPpSLjNoxOkdGGGBXBFTsnBZqfYONPIHSqDgouGkvUVZOaoiNloyuFcidOqLUdDsqOBzFXrRUlrtfeilFiKIs",
		@"aTZLNHmlwUsLyzGzbltaihSWRpPRtmExyHYwRvYCgvGylNeOXnWWornvoeajsOeCswPnHNSuVlelvKDJWJMFYchckQKPwUnbABWdrfpSDn",
	];
	return OdymSaGrLgzfC;
}

- (nonnull NSString *)WoDXvDGbta :(nonnull NSArray *)aGUjkhyrBfo {
	NSString *oeaolyBJyC = @"LcHvHoUycBaIHQyhgXSuREAVWxmlpswgAVBtMomouSahwExFjKPDhOTDGojMKPRQpgRpIltklDqpwVCpjhFLayIkshnmRDSJnbXqdTUsVabjWipRCyAhhmRfvBXBSopNDzY";
	return oeaolyBJyC;
}

+ (nonnull NSArray *)UIjJKwgucunU :(nonnull NSDictionary *)GiitnYtSaWNYSOpP {
	NSArray *dUBhrcKUvqyWRUpOtG = @[
		@"gvAmTjkxIQvoqkWYrfChGXqXolPvCsDdemLBuEPXySwnsxUrwnNBojpmefKKpEpcDyJqtAydZKcILivzgHtywkvuIFCjYEfwmTuSosLUYbHNEAPVAOwzTOnoZmuaNxStApWITtD",
		@"FcgPVeRlwPTelOTpEkQSJghDVNucQJPojHswzcKVWaAJQYMlxwjgEvMDBPrJGOKWuuBXuDouHcfnFifBTPPPIQUGtMBfuUhhGbzVWyehXytyBJMMfyarOWcHcr",
		@"YotywLZDfNzACHnUoVjPHzLnXOdjwLDQdfgHqaHGrFuFjFjlsUMXrfTBZZqlzeGRzirYzvXUUjhbmzxGkYlsrvbegOQugzqYJWki",
		@"WhoxptFYKAWPFvuPDhgJxLIkqhMgXtrwJHPxCulvNRIRovWIPzqktcztVdhcbsBQGXocYJloPSlQdjpeYyPPcytcYknwveATupDVAlYJSZjIEGGO",
		@"yOruexMkzEILyWTUpKXyQYJXyNVlTMrmTkVVEoccZTxkcPsPeWayGgHbfnnnjpcwDRHCnXHImbdtqYNRkcSxuCxLwtYvGZcbetsifooXRWTFWSccYACLZnfhxvGhstatRhbsffMTQmtRKZwPk",
		@"mpwpesgPtrYcPoVXazrtCaSdctpHHIpvIlCXhYlfcGcSipBhzEzRroxIxESHxuDttBiFvbteKwtZrZEFFRoxJpNsswbCuiuKmHDvZNnDenQQmsEelOYDgFWLsiQHHAcCckzMJBPItQ",
		@"zIwUKNkYPLqyhwtDgPgQxZiTiaSMlJUEHapUYPvfdXbMtNFTfZuGdGLyaDMcinlkJWuEolDhCCLBDUgfbHJXgLRsQEdxJkFEkvADEPLsmBmMrugVEKoBlivsNXdgoEEF",
		@"YwUTqOsPISVjhTqowfSDkZDEbjWazzITRYezRIhPygWcFdRNkVJaacyxTAvrPBNhUatxiuEwuPiyLXxXHoGwTOyhYSitaCqsoffzaQWKPWYbzMqdIQkTYhpNGXZhDvpHIUATBoHfTjFivofVlw",
		@"LGwjbrVUjqNQOmJjfQSEpGEZgACLTNWYtszZtWNFbzNtKBGFqFvfLQABCwvAhyezNrLMAVpXiqvxkiJFZRRDBPfZvYPHwPkaBWxDoLmmQhNZcKjRsFvBilBCmAgRSyojKqywMnKsNNjXQ",
		@"iOmwmUeVLxfEXVpMfPJSggRKhaZiAcuPsrWRQSELhOvqUFLPJeYSTqSDkZAPVNgUDiAAqdxNAKSpsqiRbMqWGLNapgJoxIIjlUtvtmHMceWkIjewlZbzi",
		@"WbyITBDHjynhBHNlgfEsCqSBrFrskLqLznHIgvdqOYDNZagtDSrFVXoFFVKPEgdwoSlUftYtGiULrLocftjQCnAGrDsVhFcUowCDdGf",
		@"miJdayTHEHyqcLbTeFAjziKBQzbluROThGXAYequgxNIzzJRRScDPhnxMjnxamxhXFPQXacbaKdbGqZJfRvcKEGJbiPcjkrTQsJCKWAgfCoNXJAARLQPdQauCzeQFBpszfNkIJCYJzA",
		@"DEtCdAuMqxwFDobwvNMYYHUhAhbomqdBfFjqfjHkgKBQDrcFySzWqrbXxAcQOMnTICdfemExwylbvshjSmCspsXejbhdIurJobxnDhLDZdCBKUpdjykhnj",
	];
	return dUBhrcKUvqyWRUpOtG;
}

+ (nonnull NSDictionary *)WliNDsHvfAILvLOy :(nonnull NSDictionary *)JETpMIzjuhzbOnY :(nonnull NSData *)DjVlVGpVDCPYlAeyCu :(nonnull NSDictionary *)zPUorMtuJwKzUABp {
	NSDictionary *vkKqWTkxSmEGk = @{
		@"mdsVnCtetSb": @"oWxtHCLSwlLjhKduaUyauZLKjeIQQcZoeIFxaEBFNWpsxivwswrXDPCNjnaaUVxCGkFHLWMvoaYzKZNdUMKipQBgCcjLclAhPkZXKdhkQsXKmORyqGHrLZfbxnRCxywSYobZBpn",
		@"ZSXGUWcKBVQW": @"QKIaKZBSJyzXcYljxMaLnjqQvtoiXUBYRNlHKDPgpRZjXEHCxCQgXHEeAFKeSJzhdacoKPhPiBKHuRuarIwTHPIvwMygQqtHAnri",
		@"aCizJeslfrkBJOHUEgI": @"roLkrIcuUiPvgVAYHCAdDNtpSqarHFMXyqZRtTGuNCiLtrrzujmRgwtLYVSpPhTnoLjHZhEDywybwNjKDYgXQaubBoMJNrGEKnmjDPUokqVvPcWiREEiTClBFTTlOU",
		@"VexgJQdjpNkNlK": @"oBwiDgbwtkQzgcLcLJHuLatDeSEeVfuPluQLKYiVuZglZBrViZdCozwBnSWZysCyRyyEqIeyUgPPlrTTfgLOnsVCbKQtDoxvWMMusKoEQrQjPnPtizokGAKucpMiRWqZfbqql",
		@"aqrjgHquFdrzlubNxd": @"TIqwpXNkTcvywxgtmjNuDDffOroAnLurPcHpIamGMQWPDRyIwmgYvBbbopwcoOTbLlGsELRifXlKAAlQtDslsXdNwpOPxtlvDBFXLGUnPTtzHiwMahfcgYdKiDZjdZPMfUelHBt",
		@"dmXguEIVIFoCMY": @"HMrCHPszsDzltwQFIfTYlGMyrPHNIKzfrIRpVZBLYNxpbBgQJaAoRrGVujWYSPdhcikyRvsQCKGNChINaqiSfyAVraQYJoJSpyGFaNGjPQGHFIDACWrEUBefqHBBQtAOjLOrHmc",
		@"REjxMWbwxaxnFzAi": @"MaMpWNMelfjHXPEnVWoVUgnPhMTVBqVClzwwAgHPzHcOCDvYqhsxlsOHyAQIfgSphSxKqbhBafmKfDqbXxKQZHyUWtIklNLpPchPPgPEZhudErSNteKGOOtqdLQ",
		@"jKHGKzwjNW": @"lTmtysOfNqxypxjrxJLmFGaVlPQQcUWLWsseEZSUxPSLfPRmvpXENMgKsaTogFpQAnXbQkUAHfeptzJgSFqkGWaPLdzCfSNIfBqxZl",
		@"pcnrPaEgnTwtc": @"zIwwBDzHWJNsoIynCVizFhnTSwcZTrhVAxIzwfQlsfEScNEgroGxSKxBtvJeQrVVAzTiiLvKlVERHvjxuEltBMwauqKNxRxmecSuUTFBYTHuWbzcEXuOYxqcYErKUzMPCRmfpfWDkxpRDSmUvz",
		@"yZpevMyzFuqrVUv": @"McXKPVDkkguQHoSwhlRbtmfVfutBmKsdLQgXSFHcPnAWlsGyiiOKNnzKWAAazcIPHxMmqStLaHSUuHBMmgwbsKZqDJSQEdLFNmTgcForXUChDyscBpDfseguzJkNpdynGueLsdHOuCqloO",
		@"kyjQnFqGHo": @"RYXeBSpGmbVcMDbCzLGdYcjHojaiKvcnZmMnNHKwzNWDJzaejpkEKRiKQMMjOvzUVRmDHtwrZSGJXMhhGobeoNgdywDCoQJYRfikv",
		@"OxMutztFCPYBEz": @"xReLVNjbZKFogeCKlJWzhsOdPvhJXvddNMkbTXTdXGpHWicsbzjnoQFYjEjDFuMOjYZafrxqLpDDNbekeupVIibTaBIcbTNghkjmOoAckRcPUKXRqgNmRUBLCoRFaQduNMGoyiBE",
		@"zyBxjKHvSsEjE": @"uaeEzPmYXtQzpjJzSAvNHJpXrxrLXzYRIAMyDTDovDkjYZZHdZhOEDRSJBYwQfbmoBfZiBTUhKhTCymRKSvvtUmpnxeHUSofsgQNHcODUQmpgIgEqp",
	};
	return vkKqWTkxSmEGk;
}

+ (nonnull NSString *)SNdcOCEdNvLJo :(nonnull NSArray *)hkZScBvPSFQMc {
	NSString *jSSxgnuJbBuNAv = @"YAkoNqOofnJAXWhdSkNOKrAXTIHewxnSXNcSJgKPrLPIKpFRgfMVOMvCZpCumRtreXftDhGMYPprRuJMQeTykfYKOUbHFRwgWVqKrPgFWvihnkPslVzpGzIFjAJkOzFjSCayto";
	return jSSxgnuJbBuNAv;
}

+ (nonnull UIImage *)RptayMYyaHPobDKtfW :(nonnull NSString *)QpmujdXwrKEe :(nonnull UIImage *)XwZBomKQsPiBfftZ {
	NSData *zJqwuMbWUFCs = [@"JhbJFueOeBUuxPmvudnbyTUmEuXVJLeyyYvhRJhoRBJSxtsYzIukjFvxouYAerzASUHHnlmLAAbZQxLKXJXwIClFpveSwcfZrnpkSakYwVDikrFPSffwms" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *EXTTgOOJQQctot = [UIImage imageWithData:zJqwuMbWUFCs];
	EXTTgOOJQQctot = [UIImage imageNamed:@"FBlIaZEYCrEIkQXrDWQUDRsJLqwNDSkAmPeqnIpltnUNxRihiBPLedCrLLEnXeMJaSgnjozctGBvKJEMQWtTGCJFcWgfBreKeUEmLhYtiaWnIDKIcSrUDCFtfSLzQpRldQtVhfgDhLHzRsgmr"];
	return EXTTgOOJQQctot;
}

+ (nonnull UIImage *)WmjFwopFLVeAGLwnY :(nonnull NSDictionary *)dfFELqhaBdnrLaOJ :(nonnull NSDictionary *)XMsAlLXygd {
	NSData *KlZTCzyvfcBgn = [@"EXlMKFONJjMzRJEPTRaFhDRsRaTVUuUKnpMDMoxWQhVPUGvbRrVggWqjpNowihcqbXHZRkYMwDgWCsdNthwKyrjcwjKVzXajJRoySilDdZReW" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *ldHbQJBAMKyomI = [UIImage imageWithData:KlZTCzyvfcBgn];
	ldHbQJBAMKyomI = [UIImage imageNamed:@"eeIMcfsOEtSmGdeFiKOQyvEvTfoakPCFEqgPuXKXEVrovqSbXuHngRvhIYHduwqQKaEVhTSGBpCKaGqCopgifGHPObNiEggRwPWLbcAtDSlaGchcgkXWuHGtKkmsTATXe"];
	return ldHbQJBAMKyomI;
}

+ (nonnull NSDictionary *)aWavxBgIiwIQbqV :(nonnull NSData *)qSZmHWWahAX :(nonnull UIImage *)aHhUHzdtvSTtTgTg {
	NSDictionary *drzJZAZxhmFlSlXb = @{
		@"zCQlHSCzOtl": @"pIvcopVHAPnCaDQvbCXPqXDUvafXXMaEjjDfHoheHjubmqmZwOFPzuRoqagNlCATQooJsvYBUhuavgfPjBsiGPIUdahVFqrVtAgPHDZKOyWlIcWMsdPQlZw",
		@"FerhLidMszn": @"WvWqnwXtIaALqYLHRwQFlnINRToBHIXiXlRBgCrKEvMDHxqekUMzCaNFEmyKpFLTzKJmgGlCiTuXtfRXzSzBHoEFUvDHfLeZnPrxIJFHpXLfTzeo",
		@"ISyyqARjQBzIHuhv": @"UQbPyXORoklZojfujtGPAdpLafcsNazJhpGCicMimmrfxRKqmkGoJhnNHRoHnffmGpUPhpEBySlPZJVXGaSEjGoudjCENvyrkSpjHyMfLvKwQKYanoKtXp",
		@"vKPBTxLtxFG": @"AcWGjQDczEPVeCdNGDCRqutjOeEHgAhbkXJKgYFZPtzMIrkDpmgKRqBrmQKNoOOxqDSEJKpVhYKCIyGLLeDFVHhsghEuVZbnflYneqpmobsYyFjkshebAONImTWkIDboVvycP",
		@"kUeuJeoYbLMnIuZZzIH": @"fkTiLJBmWbCJkBeqeFEdwvDGAiMVNcAzjhOVXabyVOMgHTdvNFVDQcnKrqMlYWmpVmJjqIddxbLbFyiRrzTTsDOpqnIRQSeydJyPQMYQGHHwOaFwDFHM",
		@"ralUUerAwZMQpn": @"mNLmiMUfJnifgSCIOFNsViqFHuyZHXDvLZHnthdHBuTSKbglcDLSxTjlGMLqeMyqYEtcIZSIYrgtCXiPZEKueCzPNuhaeYbSJrzqwMCKwAbuibcxfBxIOdCSBwe",
		@"fsAPrndRRyTQiuqIFN": @"BfAkMOPnynNEkhvDfdnTnDeFwMWtnyyVuXAFLgrUOwfguRGHodYvVJfWTAqjNgeZHsRLDEeWNhvvRLvjfkRClAHaYFmzufYqXEDlvaoBjrGKnYfRNSYXd",
		@"rxGIgydNzxMuQqPjE": @"NqgERFyrYFqtOReczXPckmVPHjRGhjrlfLtgrsWXeTWaihWsgcNOntuOQsgYmaoQysxbRiBFClYEIeDKbXfqklyzxFfaTOnbIukH",
		@"VgeMMnLVecvhcO": @"HKrjASKciRvcLBskLCIJdvJPRCQeJzXFogpYEKaoxfDKqNrxpBeGuZqNfrjKWoEMPrtkjbLsgTwUZOxQWOSGqJRmUKPGckAGrzAKPuXNGdgvyuLpqXxIryfTbwxFIKZbWndhvzdsRx",
		@"mjVkteSTLrC": @"IXWYZdailtbenaixSYxuyyDXIeuFfCWbehaPoHgcCQSlKCDwZBcVsLnTjpkjiCizLJeJrKeAnZmIgeluGLsZghGVgSEnEgJaBEEJTtxtcfBuiUBnvpSfwglnNkXvSOYEQsR",
		@"mKfYNvdviT": @"GnJsvSvHnWAZtCbMGQUufEoMvEbRzobyaNLGomDqzmgBkmIgvbttFwafqIukZZXRFfrZrlldbJslkkrjAbwVKAVHoqiWRfcBYXNLahwijDrGDXXewH",
		@"LTtvXZSkEpgiwXztsZw": @"XvdkYDqMLNvYHbOLbIsavFlHQSqspShIFtruDqyLazgLHikRXgTTVnpHXSPwzYhXhnvzsxPgZaRRxxBgDfKxtXhTRBipCEzJdpvuXLoeSsw",
		@"KBnVRGiYkFT": @"HHCLsZaaSrPIobgGFeYFOcsqkyiugtZjfSYQEbwfENpWRaFAXFqUtswUovILGMjKWFkqnCEgqgtYlHWgnyEpEoZGmzDVMPTnalitrJxmgzwkjTzOMwKWsubq",
		@"WLAtfQijGZmZRc": @"ftCydYjBjTOUbKyibJTjsbyipeYeqLqxoUvKjYwcNLqWPnNMVcjyHalyqHYEdxsRHsabBtiZyDINOuSzbkCyJQwMHazlZfStAJFOWzmktZtJfgpeDgXHWWAdEQpvsWHbGHxbocqozErJwGn",
	};
	return drzJZAZxhmFlSlXb;
}

+ (nonnull NSArray *)RIyfChvhcBA :(nonnull NSDictionary *)ulqliJLNrXpyz {
	NSArray *RALFSVkYmRJx = @[
		@"mXeUIAAawsoreWnORElxIXZUZCDtRNPWPEuujkVrchNUqIlncffBgopUkYSNuNVsYeakiajrqAydrOQwoYkkfGFkTHCOJBqjldLzGlUfYgTjIvOFy",
		@"iKyMaVKjPvDHKsXvjrRMCeKFzhCsSwAaFXJXrmoxEetYUOrKKeluSGbBXCQmEdSYUEPqhmcPlzTVQviXwhFMqxnvOCLVYTijOTTObiEguZMWgsmSAq",
		@"CaeJPZOstdTWKOtQCyzRbgIUEqpFOtvvnCUkqwEIKZnvXwoHIRSsvMqhGZoGqHtBshPnNzixGVvlsKCfNGuppCCCUmEbUqeImlcXEffs",
		@"oajPgJRDocMInSqwFqOcerVWWXTGlnpvkxqyiVglkgDviDQRefOsKRveUxlCzXNbQncWcvCzjhXAaKvrqMlarEsNeWiQSuxzwsqrdDbXZLXegXkgGBQDxdSdQfEyXmhFJ",
		@"dEBNwVPPNMhhtxzrGoQwatKSeaPEiSLonUhddhJXroovCNrsbZhPchjLyfcByhpIlqZAMYjbOOkbgttzqtmQzgUuZeJvtYXWYnDWpSidVqgpTblytiwxoydWmbclcHyJ",
		@"WGnVbzYtGBtAgFZJXJjmKrsLePWPTXUZRaoSWVMWhTtXJHNebCwnZDbNYqohvmGIwFtjckWnVBIgQSwBtQExLpWucuoOOUYeMqnTXhhxarEAyUfzhuGbxohVICiafzQHPHcGoX",
		@"JViswzpEpIhwRdfdUxjKkQyqZqglbtGhnddEWHibbniuSdMLWiSzkXpkRhNHMwiuwjCNlUciMdUsheYqcLUShTILEGjBcVPOzKbzCPPwXuvJwMkKvnnTyvibGPBYvjFWcDjIKmEyCXf",
		@"ybCFxtKzSBNASqcHjcszGxWymDjKMikKUbMHwmTVblkBqVCPDEcwNllReqcsrpAbAMDDlRFYwCXdfdaAGiVoKCGajuBYaCAuNshZkCDiLvspW",
		@"qTrhMgHEWlEuWvljDUMZtZPkaKzYbLOOTiKjpmhBbHxSqxZClzVrvgUioYWFGDyOQFrZfSjZLipGUwHTttFHqOjDpSQjhvHirdAsoZPAckmVnYPtTEnzFEUOXMoeNIzwsmQRLyEKLhvnXJZrOq",
		@"QjwbBzFLESoRyBNEodqQSEdImZyRqENzZbLoPaAVkjDBHLyXbNUarTmAOAzUfjSGXFmRnejHCovasPuLnLEVZlgQqKQiHGyAVwgOMfYTdUVMKLuntGfXdZhhcjmoRwYRrutNyTTmxDwdWTjb",
	];
	return RALFSVkYmRJx;
}

- (nonnull UIImage *)qccMEZHrlKoNsSbRY :(nonnull NSArray *)FeINYABJwYZCDtTJK :(nonnull NSArray *)NmtbQHOyHBWfGH :(nonnull UIImage *)jdZMGGfTvKxazFBeZ {
	NSData *VelYwNlbmV = [@"REjrqBqxCYWyfojzNDKtWtfQNodqIfTAMbdFrVNxUqyMUtMTpYRTudabiLcqZkPsMkKehXZuisXXxdGTEfhWMQMnyxaLIiCUAarbUzUHhsQzyzCvPFabksKVlw" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zbgFWXFeCQiJTu = [UIImage imageWithData:VelYwNlbmV];
	zbgFWXFeCQiJTu = [UIImage imageNamed:@"RuhmJiLqeimrgYFgtRsCaZxMNiRTsEvHZVhABWwAJNHeafNQtstBHDwkymFQODsDTaiJRAzraYOljzwuoeGyfzRsBaexnxlQnsniHYmwfkpPmE"];
	return zbgFWXFeCQiJTu;
}

+ (nonnull NSString *)RgvYxMmYtuMrHH :(nonnull NSData *)AdxYYHPOZMV :(nonnull NSDictionary *)QwJdlcGgJmDmCQQ :(nonnull NSDictionary *)gVtzuPYZbeNqlRbo {
	NSString *lEBNVJEivlMLXitH = @"ucUyvDoltfISUwssAQEgrCSIOiLsvoyFGdaJBFNcrLFiJttKCrWoywgVdByLlGCWwnsLeUQdCvvNqYiIRrPpWyjItSfCyrNrTOEoEYlNyymNCLoerMOefSzkZdYwfALSuKydxmqAorS";
	return lEBNVJEivlMLXitH;
}

- (nonnull NSDictionary *)nDkGlInrCyCNWWSNF :(nonnull NSDictionary *)pedtjFawokqwRt :(nonnull NSString *)npYIrrPQnJMqsoTSl {
	NSDictionary *MTgrtSTtmRsCCK = @{
		@"ohcFUINnzU": @"DEnfNiNKPcpHrFyjyBfRoACYokflvonifQccVPWkcgEIFnphEoKEJiajwjuMfjpzJYyMIBoQjexRfDILHnmKosksicBGwdkmvIIzmduCYzjUzjzlrSGyZwlFMxlPShERINFa",
		@"vNtQiZCXKSBJUA": @"XihkGDPpquWlSLibCeoPMFcLqGVCgJZbAtWdmxIdpMjbNQpNTtLKvmtMyqTglydhjrDZJPihzKHrNxTZjDraTmlckXIpQCEpDrujSMwYDlApg",
		@"fhmpdrZzfesl": @"AzfUcDTIOHOZmsEnjKQOQBwVXKGjWHxgEBqZKQGNwSNOFNXyGCLUyTVaoRSWuojaTIolNlOnkSIDGhvVUoeaJxNuUSMJkLXebIXZKXioINuIfpRhiM",
		@"pLesOihgsSGE": @"aAQNEGvNKevrvAABCJXNUnWFzuYSPJRuwOloQyAecnfCOBZneKDqALTRZxcFAaOIFDcmeHlkaacEJfVghmhweCWATypTAYpzxiOQAPJVfyxAXJypzHTYQudjlmKpQxzeqUdXComOIyTYfmlvOKie",
		@"GdsOirUNZSn": @"wanquoSRaVzfgZdXsImnjaXWAzeZhXDjuFKZUxiYkKUvVAmcjLQYrYrLgYjEiiGdnliUVBqKuajuhpzXrnyrYDyQfNHxMmwqiAIPHhfCGkXuCfRufUHEGz",
		@"mPdauDHikOvadSKpP": @"GSnglWXeagGIXlSjsynlwebeQZzbeZQAGNFdScgbFqSRZydhqEOZKlnutafOWBuRUEiEkTAMdyeSfNStJScCJhCPYlolHenajXBsVdvuNxPdG",
		@"YIRDtSIMirtJCJBtEii": @"NdgxBofDIKCgibLxqykmIfGMHBIwqxzfhijXxEXHszUviUNLnQuTLQXPnIdiMyRHIQRGQUFfmlHzURGqKIWKHdeLNDwyGBJHdyoPLLsOpVSV",
		@"gWtCVoVGUoxZ": @"RsRDjxuRkHRnzfPAwWiPhNaTvnLpuBKaSjcffJPAnnJpQWprfxPOmuniBOrzrFycetislYQmIMEHlyReeqPvvnWDlPvoodoEOeECczUVEvDKdepxWyXRGTjXPsHL",
		@"HNUaEhQbtNokVFEO": @"fwhjgHZrXQzZSzRHcWaSYgHCzfUQqvddXRChAmfApQWmcTZFevQVjoMAUkxDtZSKHwiljgbMjkMHUmihNkyvllRemesidtAlghXVuPsrAnJFpxsOHwEBzHctcSetjEOy",
		@"vLcgTmgmhiO": @"XUGQSZmFPEHAKWLOgqJQSdruOZZsQbNvuaDbNtaeCKuHJvlbHsUGpBrEnhsMizGbjdVogqwrtRZZXCEQmGJJzspLPHEePZIYeNqTstkWJFWIYohZ",
		@"lZUWGjaXwjT": @"zjHPNaiBtwGOXvYkFukrGkrSzfgGSJIpBQgwTQWjhdxaKEIXuPLFACmuEgzbKTgfxOfEgAKZGUvucAGHcLXctRMwtycvkUTFnwkTFikSQhUMkYYtDRknPnJHKRdgPFjulIKtWrdlbxnyoxypY",
		@"WOEtRASevGHLcuGUSf": @"pzHQcBbQFKqJHzsoWepEBqmoTlVeeGSJCjuWVoTqUbkJVkeJuEiARBXlKmPfRkYOQXPfqBDIZJlabpVGgsYXNccJNuhHVxLpUwCuVLBXsjwyJoOvYLbLymrJGvvVwRyaVq",
		@"JYiqydjfAhZhGdDWIaH": @"OkndxldRncgiyHCUTTvNAcXTPXDidjXVCGGvcYGFRROqAnQRiTCYmbaKjurSMjpZEmOuJrlmSUmmYwbGInMzAakUGJhMIhIAEytW",
		@"XhdjTYECAyEtcYl": @"bUkLEgXfecODNqqKFOxvjjKyRKavIiXUKEHqXadkuXnWVYKnINkUIBtnQHCwypyErhCBMSQdLVqcLDwdTTyFWQdnvPFLlvQerMkiWtWYGwblkFFWSYSJzWOuFDttDiRLEpyNcGGReZo",
		@"DjiwPLpqYKXPdpbfrdY": @"fRjjHOEtCDCZNojhbyxkNQUxiEVYQDyDzCDzKMyxLERXpprkzaiNSyeVTdUhTMDGCKcVpLQnXKQUYsJwfUqZxmwfhymKdqQvIsgKPxPbtWPcNPWCKJ",
		@"VdyVHBzjxiFAWjFMH": @"zhgFpRCDlzhvOIfAJTnZoAjtwvOVBiCmwwvwOBakCzqGSqYfthselTylcZZtOilPLteVMQbnrPrbsEXSsTRvbzwVmVtkeAIaMhumPMGYUsxgILSrbKOVYmzznjzojrJFEPkpEOrVk",
	};
	return MTgrtSTtmRsCCK;
}

- (nonnull NSDictionary *)VTttObaLTqTyPXjd :(nonnull NSDictionary *)VfGAnkubNPNuS :(nonnull NSString *)qzCOdnepGBuOhmj :(nonnull NSString *)tYMMEpYcaXlaBWu {
	NSDictionary *srXaqcjadEZlvKT = @{
		@"myStgYlTVkbqQRAO": @"bQOJrwUmSeqIAzeFqKCBMDDPxLeNdzoyCiEdjaXSoPhBBkqBKFeJcCgNhddhzEgrOrQeLBPjkIXgljGNgzTDpADEEAKOmAckcCXCMSQMJSCapDblnxqWSyBJnYoDtckFvPlWkiOzduxjbZDnAi",
		@"lSaFenLnUstS": @"KZbJFQmmRHfNWStKgejNBIvfSqoVKzhyLaZFOZnYnACDBtkSEQzfOiqmZyeCgkQazSfaXnvpqjKojPDQEBYAkXHKekziedAKgoccUvs",
		@"WTOKUwMuGilAz": @"NIjqTsQOYZrrwINTzjfHPTqUjMkBaRALqSSAVqqHwPlIiqbkfTMkeqZINwKoMGnUdivQhFpdwvHgBuinpZUjFcXcRKZorhjihlDTizGSHCSHwc",
		@"dsRLuDNdxppVeE": @"yBNalzCVcXGzvAITcSVTQdXQaUqxPsmhPfGUztHGzXFwrXeyepQImSpaTUdMRfaRzpgbTyHJExDbLhtdTdMpSvuoPWpjeieiDWmcDqqrSsQlVBbngePrgUoSZcglRoSqqlRoO",
		@"sAXJFWsuDRzKhZj": @"MoWqgPyBYbXVxQlfrVHdvvBBRMchuFpewiPlbZXPOIOFqzkkvYvibyqRzAWQLhSiwGAxYoyjLBeZPlnMbrdMaRdZCGMcSFUZPmJhKNLrNbVcMOwIuyCOEcqKjAViaRgutVSQb",
		@"WgcjizcAceeXhEZRCx": @"WeuhYuxNYHppELqNDEoXmkuxlXGQRWgXTJSAEyEeLscMjxxngMODizjpScjtnpamnOspaVpedEJFVdnjXvwOTiGmAMsSZOyepiIwRiRtWhddPxFivatxhZyfTaTTOGNFwiCPjnBgTTxRt",
		@"lQUylwcJrpycgTkAnwJ": @"gUQTZmVBTqMvrjPEwjvFglnviYjJvELMASlIbwocxtdlhETZYMkDVXkftkSvlYcQgrYlSELKJRDrlFOnpVcHjrAHaqOYqDJYotJnThHqMPnHSuosxdtcJl",
		@"KCgmBMkCDoAt": @"tTmpDasmfcUspthUJVsAJprlhiLkIKAYSFxaYTgfnaiRoKUSZhoyVbWmsyCSDheYIfSDumdLQNXAZEwsBsPoebzRRkOWdxPaecIbTICMVUS",
		@"FIyeMulqKTMa": @"ayMwwXeVayvIxVebQPxGilAIZZKjkANFSNZKRGTHPExISkCSYgFsobNUOVCQlbRfCxAZsyOBrAIGnLkgdBpyqWeBmIUMxyHEesLiNQPkiOZnkdllhbEEyehhxgaCBNYifkcbnBxitsFxoas",
		@"IFUlNJdWkyZqL": @"AeUlFrwMnwsUzDPAAZHxRcYzMIgUuzZsLquzcUbicCNGIgipvuLLVatiwTAsPBysVAhtrcqXaPIubCjsVeMceJQElFMskDcqfvOhPGntemvtmoANDRIdSu",
		@"VmrhBtNnxBS": @"UFdBBHdoUnEqyyDstqGbjxDhSNjkeOjAgLqefsdadyaPGGYkmIqNSeXNaERlKlmmMeXOoGKXpwkRhFcipPzZHEQHhzqiGKcMqPqqlTYlbTKpPkjBnqZdCVpxnfIBKQBsUCLagoBmfghxKD",
		@"arZwkPeiFfL": @"rTiXnypUHiSEzKDGvsAsFXkpyaSFxRjLTIeaqbFlXgsbRDkpvCCzCHegXUJKoeKsrCAQBaAnPerClyCvfWJXrbeAItRTHyQlSnTQHkujROMelqafyXFqHdCWzLuB",
		@"FlKRCMvAgIPTaKAGlIe": @"RmHbSLAcwmBQvFeqlalqWiSVFCUKTgWhEfHadnoDJUwoUKohHJEbtVLcTYyrplURQsTavfHsgRLijxuBecWFLswWDIykFBGcJPGyzDgWCyTIcpoAKTpjIzGLiWTwkiyeLbvKoEpQrCznCLJohBUMv",
		@"iXmerTkZgSzSAMwQ": @"pKWVEGKDSXorXhJHvIRLHPcfaqRIvEmTVdXuZGfVfgToaCYbynVQRiyuNQWxGHMXCYAfBjUNDcdulUDCVbuHZdCWwOuuielTcjNxIwSn",
		@"JndFmOLEGiDlTZCIq": @"qbVQRWSHxfOnbnQKMqhEeuXvhzsLkCQSfxDKEnldrfOplXjPPPaCcbnohqBToxHMAWAJvAlGpywCHjAGlnlgrKhBpenAAtcJLSKiXohwQw",
		@"FmkMUfNLigprFkpGYY": @"YDddIaJMSTtGnizbeKvHaesHSZiHJHuWCdIKxjTxuWpVIedbHutihxLjEMUcxQcJSXIufcyuzCdmNhZmwLAKTODDSKfWSrebSZzRrlYMlwhBkeZJspvACk",
		@"UCeAAvRJBRNBroXUo": @"pnANHfraCgeknwZaRUMpabCeJioXTHhBvgxsKIotNYQHiKHvhDhJYWoRuXrIOLnpLsTcfukKLmTKXfBKOlyenGMIqIzZKdZyncspaoL",
	};
	return srXaqcjadEZlvKT;
}

- (nonnull NSArray *)ryOKuVkWcHZRPVUtv :(nonnull NSData *)SDgZMhbxsFhDPikXXqp :(nonnull UIImage *)HTVdSVzlplSoshT {
	NSArray *vBMYnpxsOPsaiPpRsK = @[
		@"ttRLzmAKZDzxRsTBOlePVeJJlWxmtrRBMtCPLMGmWcFdLfqiHwRNilhuQhgohAillbSVfHkqisDucaJehFpEyvyaCntkjDJPnhBlUxOvSyJHn",
		@"VuYznJkQpWwACDdGmtJfqYaaKQWOtIcNgYWRYDfgmhrlIifcavMouuUXzCcNvtQaASTytCZuHRoxHygorEGDCMfAnwQvJvSNhBbLxlIKyVJorSSaedNzIaAFXeroslUpA",
		@"WcUSjQNsUAehDhgDbvoHgxHxxfTAYJnBncookxMkbePMiFVwRPZccIxXNQNrnJouTbpcWUdZnawcoBClcEwqmaWhuwDFKaBabuHhjJJ",
		@"coMkPPElNVltoKojCwznFByjPOZrJLCjFwgomexwbvMupssQSLaZTuPmMiPjrgbnryCFBVfVxDdArzrdnOviatYhkIAVOVtGdJkyklghvVDkLDXkYfMBOqcoeHQjyuUNDBJKwDAABlmEkQ",
		@"hRADMvjMpclaSaOAakKvmfXBQFOnCfOFsYGfKIHLxzoJUdBoxszmfkKhjaRSmlAKmrUAzsHiZZdITqBHEhuMLMtXBofLgjwShwarBIOaAvFSkZ",
		@"EeKHChyFFxtIgdNqZlDJBAjkvJEsdyfFyAUNujroWkElXUUcZCnrMUvcZbfxIsKliXejwRdqMxUERnDcZTAxjSuquwobtuxPaTdPEhY",
		@"BrZyqIGskjZCQqjLCeuOvziwQVsOXNYHelfjFyuovCquispJgeMJqeFHUTStSrotrBSmpZmLrLCEEYrJLnLYYdTZPGJqgMUrHNoGtzxMjtlixdiRaesPDPFmhor",
		@"FbiocflwccywvbCMligDAstBdIzqpSbcuMNkwKEGEGEkXNVPcinZokJJTXRSFPRzkhwhrZtBQKyBnJcqmHqNoxIWaoPNfzexpbkLbCMPyYqDRakwlCxRnmrquktHwORD",
		@"MkMFLjwkrbWlNxJaUvdwHHgrHYbbYstGbHVYsEhAUcBnlZGvyfCqfzYZxdYcNrnMnfmeOhZzPmWmNuHaAZFFOlHUiUliYpliPuIEOMDXpSRptRgQFOVDPQjqUqjJjQzBywdpJTJ",
		@"RoLLTFqkDeaRCXBVxKlPoiWpGmwpsBYgfTnPcelNvouDRNlRtmJLgUmgrVKhqDzBdIOYArcCrXlSFnohsKSAJgyOQlgahAdHiYRWsGlvcQmEgYwIadnSsejNRfdgYswTkaSYZpWPOvZvp",
		@"KzChgaaiREAHcFCiDGjEASKQQIYoPhWegQukBJAAMAfHBnOmBghlDofUgUTrMhRiLCBvayNwNcKiXyzQkQrCQhLfiptpXSBhhJwqDzOAFOexOkhZsPTgGTmRXzJArIOMmAycEO",
		@"SWQqlIrHjlxSKBDqjdwVLtarDbWNJROccXcwMlGUVLpSBMoHmymjOOdbhAoaMSVUuXHeRWlmcTGdjQoqAWdABVeJlsXXPpOmhxHyHxCADJvQylAFLju",
		@"pTdRnhoRFkaZoFkqwxXnKetKjeuPkSgMCGoetKAEQVFEnfQVJpFKWwwDPDxPZHzzpKvOZJRHNzCNTYvbGDeWSjWaMzYKYWaMWzrKwguWzRzStxFDmiaXhBAnGgtnXskuQmjDLjFYbK",
		@"ISGJeIUYCPnqbdajrFtacJhaTYhmQYOORsiVCfesgIrNSDdojklqtNRoFCQTPHIKyDdhDwDrtBSAMBUxbSnmNRrTxGjaCjwzfvkbavb",
		@"lnnasNwDNfCOdpnCgLzNrxrNtQHnfzHfjfnGJhOlMACWcoaYsQPdSYSknJeqiJjcMGrWrTuIZFacqqAECXRPQgsjDfKXAOdmQIOrlJxPy",
		@"cmSvYTBKSteQhaKWnXxZMBLtafPEokxEKqEZznwrEBrHSPjrKaveDQJNuueOOpBoTtkNxTVKQqSqsBrFklusPDcbxiuocJGnnjuXpq",
	];
	return vBMYnpxsOPsaiPpRsK;
}

+ (nonnull NSArray *)baGaPfpKhtPZBL :(nonnull NSData *)VdqNsumgbuSzM :(nonnull UIImage *)bwzsOxCFMWTp :(nonnull NSString *)DKhUxrtmsMztTCXh {
	NSArray *sQRwVIWFljunV = @[
		@"GBUEYfcwibeTyymHGgUGHcLNYKENMrTHLWSECbvosIhnnjNiZfhCvbcjVKWmgmmouGnJVkMzXYDTOXTboWoKqDIilPLdzZTAWIMWSFxYNapqFsgfJGSmKHBfKUtTdukXMXuXBVfkpVzkamvNVsZBN",
		@"FSLKzFBZqxlyeQQMihTeqpDATDOjoASnZbqvIYhshfEbFqPnFXRIaIGLbORNXtLCzoBRPxoSbMEqFLfiChhyQPMICGEpddKYyUiDkKnCjNgE",
		@"mFObIjMEpiOarQxrZyGinwTOChhYnWbFunOHJzmYlYWeBidNibyyFQMRughiAEjHoTaTkaXIyoIaumHFeuyqrnDwsnuDLOlwGnBGMrxzbFiANiKBfZHmQKhpVoUEIMOiiJIMSYTdXGhET",
		@"crOmFsYqFYSItbgJjhSSzlTyrbOUHjzOyGwPCTfAuyLnfydLfKrBQvlFBzQKHoJRcPRvaaumGVIMWmoKThNEjrcESmQiIwZMRBATZYWuyyW",
		@"diKkHmQZnGNhDFEDJwhhoWuKnmHJAAzdqvSzOdpuxdSyqICBwwMjZnhezEJqzvWAVuxJydkCVRlIAyblolNfJBFMMRyMilhpFEwZQJeyfoLJJQuxVOpjsZfMGcdHMdlWWjmEqNNdPeFMVZxZ",
		@"yqsHyWvMtNXsVlKXVxMnvJKYqKBWhuJdRZrCHKMVFdFapgKvkkpNifaQoBYMwPNTMHKvFpJbSVHFNQckOdWAIzPIxqknapvljwajHCStbeQhxuDF",
		@"SRdrnKhxqDtGXEIDQsAdrQTfiSmjxeFNVomXYFPoaSFViBpixsBIyKVrgvXTCazAqVJuNrUPihVnqFtknMqYXsZsxWuoFhyUMuxYFbnOoYRKdoemsGXHaxiuZrsiBuN",
		@"MoxTnSAkBqMOoiAePTiFPCIjJEUxpzgiijqjsfLBbsmCfvGnlMRVNBlTEefqiVCuSlLClCMnucFiDLdARpDaaFEiOXcDcXlcWxkPGxuLBfYlOPPSGYxxmPDVogYYQMEUr",
		@"xQYegUexwoDEBFLKLjRXCvOJgmdfUHYpiMbuYxyuTQtivJJEySvycagWGhDrEYUyeERaNAivglADdKdrfqjmjAncidjdYbEyAVMHhYGzaoilaDQYupwGHULpOsQdWIa",
		@"xarMptKJygRNsGRqQokVEbTndfTFMlmroqQZEIIcNrDWGHkVaAPSMHjydVrhMopJLapFHmsJCoinHHcIKesjwbNcahjTMTSARrJRbuZsLunDZfQytdtzvJg",
		@"uZtwkMAaAhUNfQzvSzlwvyjQkogznFUpGeEbCxmwQTtZzQKkMKazFojAKHNUCknsAHzSSEPPMscRdXWzKdPvOixCwUykSQQXUzPjTUFoyRogEhd",
		@"jZoDpFUaiRHDmXhDwWrpvpgESYhZXsGRlUUBsXfodfaGYVLBGSfzLpHdvoMVXJNOBGEwTzexppeMGVmqVvdJWlBekNAsGyPjfZTXealLTKELrPsVVbXbrrrqHQygrOVtLZdKVDeC",
		@"fNfCGQlkTXmWemCdrZlbItoMxGTJtcUyCFhXfLPXWtDTWwywtKYNNoswHEDhUrzAxhTrnNULTEEzKdlYUjUEHYSLOfBeZqYkDOhXqWKLQgaAhZRqG",
		@"rLKEMRKdUJzHJvgRYtmmTszmfiiLAHKKKtSDwGpkZYVTyBzUwMLLYzadKdgZMIsCbxBxCWpJgaEaggHsRbPUxfnakSKJYVYimCYsDVbBVvuzYCXjCaQleaHOZpeNYrsQXaiLdjZsnpk",
		@"pQqcwnaqtSDeCQYWkxkvCjBdglYRNVkBkqDhrlwPhZuSGprvkUCWLnyfnjmlsvrQDiDqjdhTIPVgpTjZFfKlrMuLKofEAxRlWKxROReOBX",
		@"bfssAyNrdEUYwztIbZMjiXIobEIDQfRGCQiMyzNDKshxiOXygYaQhfuBoCQjOucpAcGiHkPBCNXhyxKKTubasyycxgDezSdDtxhRExoerOwOeEgVpOaUFRYSjqNgcCEovGQbsWMyDzbLrrVN",
		@"OqdqesmkFnnnLDBFuzxubxtACERrUViTjWpuoMjWmWEsGDerKTLKMcFmjHMbuBsobvEkqNqogiaPpOYTEmiCNdBySOmvUYNnyNrgfZuLcYugBcMENiiscG",
		@"PKcHzEvayXuKJQYhvqeIOfWCnVjqwiZaZJThEcKyWkchTUNCMfwVBdRbBTuNaubBmoCGsQdpYTYrHiVumjwjKCKtExhMGlnTHrxiYYUUrVJkXhAdcVgQAerAycYCnKHCwFUIJToWNADrkQJuXzeJg",
	];
	return sQRwVIWFljunV;
}

- (nonnull NSData *)KMhuoLOJtcPTQNpsQ :(nonnull NSString *)OoCksprGfqpjNMTN :(nonnull NSData *)xbtEbKHIQeBrbfBxS :(nonnull UIImage *)VRgqwHyFqFSYB {
	NSData *yEQSAhgrnAUTTiaJy = [@"OlEqNzTbFTBPEMaSPeSmOhuysUAzcQvSyNaluBscqeRhvyTaKMMhQXjmDAXNvAwqokhppWbTWSNVfclVIOFlsQAmgbkKglSpRaoovbooPpCopMXcpdLlEyGcSmaYcNONaNBiokQZriPh" dataUsingEncoding:NSUTF8StringEncoding];
	return yEQSAhgrnAUTTiaJy;
}

+ (nonnull UIImage *)xSQyPlutbUmaVmHyJP :(nonnull UIImage *)MsoTOzmSaRqayveXV {
	NSData *akLlzzUqUUxvUV = [@"xVHcQTHjWcseoPFvsqrGdsBLsPyhLqytdDxpOqmYnivnyFwigqhIxVURvDwltTuyVmfRXHQmPEjiwfriYehMafRltByCfaYZShJOEOInuTM" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *InSrBNocLiBwMFhlDgE = [UIImage imageWithData:akLlzzUqUUxvUV];
	InSrBNocLiBwMFhlDgE = [UIImage imageNamed:@"jKGwgamvEtUpiREvpFMoGrGrNvtGxScVhqHmwlPCKLajKKAQJqpKPRVQDhxTgelGsiQQprsRbCLwjINMGckHuLUpBWzgnXZQPiAWlVPqhpBICwjkhYPczZilZOdUjyyNNtiOTOWlFtWtsyh"];
	return InSrBNocLiBwMFhlDgE;
}

+ (nonnull NSData *)JCFdpVHxfL :(nonnull NSString *)YtcYdxqydamb :(nonnull NSData *)WVISGypQKsmyxpQn {
	NSData *QuKeLEsdINNU = [@"oZQcuZNEFeITJxHtakIvOnvvpGGulMnaEqjTGETEaGDZQiVcwFQfmWEanfSRKkDrKyclaGgdKesxtvaupWEnaIodrSpZkNDLrFqNPqPaJdlwUcjvEBYaCVPZak" dataUsingEncoding:NSUTF8StringEncoding];
	return QuKeLEsdINNU;
}

- (nonnull NSDictionary *)bJpBtXmuZVfA :(nonnull NSDictionary *)CSXfzmsDxX {
	NSDictionary *jrMmSVDtbxjRCa = @{
		@"TyqNdMbKPK": @"EDLkSWJydkzSrcuetaqsFZwidnabfBNSTVzrCpGehtFuUcMnkmRrnpPXyKIAJSKAizgSkRGtFYdNdMnfZwVhiPeazbrFcQhgUQaYIDiuAHbcXQDmpsIu",
		@"sgJYzCdSEwWuNb": @"nEpGmJNWSnHApsWjERznrjPbNqPLWpTnKhEeCicUUteYHwLmpMYUzHDQYETdiDkUkPGEDyWQVubktXBOnpeBEgSfZIdQQFzVFicYqUFGyqkUkPaAoxXeaewr",
		@"DtcKhDgOLslG": @"VYyfjWRlBopfzPZYFlvpobkAECVLOdtqDiJWjMdVMwxVLFzsifPGRTlTulUJMktyBOeaXcDNucclYzjFsHbsklPeTsEBeFZcglLdpejtxyZIyzoxkhZIpDNGCEvwx",
		@"xCJrByRoFHRlVjY": @"svrTWztcgfbAklrSxcpRHNviyjnzGBieCFPuFQhtNisEfkJCAkjXeSAyQKLoSAeHoFCMQnGIPsWYSqArerHQiFKxMqDbCvbFkXVWxzEXgTK",
		@"gNhZcUoWAHqSJUzTo": @"aBrjjYXSMcEuraUURNMoDhspxYMbDZsBdQDbDzyrUeBNAgpRGhKKGTEhAvdnFXdkYllhVyjXICWTSIxkBzUjYanPfleRLnaKbZvGFJRbkPfSIcvgLJDSIZEiDzPzWmFmJ",
		@"ERdVVmYhkrSuyOy": @"wOSoCHyfAkcoEzikeZglzXEATwdJgpckBPFqWWYkZhkTyDPBhAGzkBWtDrLVxNBTYDqzarlkkwclNqrGrSboTzxcokdGBMCyHdHKsohiJGyqVKoOgLymWpCJdtRLtBUJsDqvrwXjPXUeZBqnG",
		@"bpeNqDqVdNPEr": @"vierSlheEefkrRCVqpJGoBPMbIBZOYjgNkReGpOBUWchkMewKFBPPyqMxPoZJCwJeKpaxvJqTKuGemUdXdNtxzaDMjyqDaBuKPbpuQZtbUBNSfXMzOCDDxMpDaeDOGSGVYgbDoEQAIwzU",
		@"MkBZZqTbQdBLEvv": @"ZUwplpyYqDLglvykWySaDYSORMzhPtIckdnJfMtZabgaYtoGsXrGpYEShAWaKjWBvrkqekAhTrVYAndHMVpOEzdBpvnJXbZxCiviMGajLXaMiqCKIIJpVUbwaXOmHG",
		@"zQDChhmAgoewPIwL": @"dGZIHOpClQRbAzLFPxQDzWeECglhachUfVuVaBwnGiJQWhqyomkzWnkNtvjVKhbyiVUncsXQoWREwgPZbxWodlaVpPFpGcpdlSktTIgBsPPodBTeyzKOuUSNTfguBFNcABNIuQJtf",
		@"roRyGcrdZqyz": @"dRVcMiGSfYNCZEdcxvXLiVojjeQkNtKfNTdvvLmJknTkbgighYsirKvcboeacUJQggjDtBaMRPeqADJVQqTELlRYzpzhTintwIhFRpq",
	};
	return jrMmSVDtbxjRCa;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失

    switch (indexPath.row) {
        //头像
        case 0:
        {
            UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                          initWithTitle:nil
                                          delegate:self
                                          cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:nil
                                          otherButtonTitles:@"从相册中选择",@"拍照",nil];
            [actionSheet showInView:self.view];
            
            break;
        }
            
        //昵称
        case 1:
        {
            
            NSString *name = self.subTitles[indexPath.row];
            ChangeNicknameController *nickNameVc = [[ChangeNicknameController alloc] init];
            nickNameVc.name = name;
            nickNameVc.delegate = self;
            [self.navigationController pushViewController:nickNameVc animated:YES];
            break;
        }
           
        //性别
        case 2:
        {
            ChangeSexController *changeSex = [[ChangeSexController alloc] init];
            changeSex.delegate = self;
            NSString *name = self.subTitles[indexPath.row];
            changeSex.sex = name;
            [self.navigationController pushViewController:changeSex animated:YES];
            break;
        }
            
        //手机号
        case 3:
        {
            ChangeMobileController *mobileVc = [[ChangeMobileController alloc] init];
            mobileVc.delegate = self;
            [self.navigationController pushViewController:mobileVc animated:YES];
            break;
        }
        default:
            break;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        return mainSpacing;
    }
    
    return 44;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark 选择上传方式
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) {
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    
    if (buttonIndex == 1) { //照相机
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if(buttonIndex == 0)
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    __weak typeof(self) weakSelf = self;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [weakSelf presentViewController:imagePicker animated:YES completion:nil];
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self sendPhoto : img];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 发送带有图片的
- (void) sendPhoto : (UIImage *) image
{
    NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
    NSString *url = [NSString stringWithFormat:@"%@/%@?token=%@",header,UploadImage,[UserInfoTool getUserInfo].token];
    
    AFHTTPRequestOperationManager *manager = [[AFNetWW sharedAFNetWorking] getAFNManager];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:@"file" fileName:@"test.jpg" mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *models =  [UploadFileModel objectArrayWithJSONData:responseObject];
        NSMutableArray *attachs = [NSMutableArray array];
        for (UploadFileModel *model in models) {
            [attachs addObject:model];
        }

        UploadFileModel *model = [attachs firstObject];
        [self sendData:model.url image : image];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
}

- (void) sendData : (NSString *) url image : (UIImage *) image
{
    NSString *likeUrl = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,ChangeKeyValue,[UserInfoTool getUserInfo].token];
    
    NSDictionary *dic=@{
                        @"businessid":[UserInfoTool getUserInfo].ID,
                        @"businesscode":@"10000",
                        @"key":@"headpic_path",
                        @"value":url
                        };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:likeUrl WithParameters:dic success:^(id responseDic)
     {
         if ([responseDic[@"rescode"] intValue] == 10000) {
             
             self.headerCell.headerImage.image = image;
             
         }
         
     }fail:^(NSError *error) {
         
     }];
}

- (void)changeNickname:(NSString *)name
{

    self.nickNameCell.subTitle = name;
}

- (void)changeSex:(NSString *)sex
{

    [self.subTitles replaceObjectAtIndex:2 withObject:sex];
    self.sexCell.subTitle = sex;
}

- (void)changeMobile:(NSString *)mobile
{

    self.mobileCell.subTitle = mobile;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

@end
