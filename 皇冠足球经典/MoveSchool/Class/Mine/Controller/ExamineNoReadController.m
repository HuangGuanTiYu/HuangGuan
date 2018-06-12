//
//  ExamineNoReadController.m
//  MoveSchool
//
//  Created by edz on 2017/7/26.
//
//

#import "ExamineNoReadController.h"
#import "AFNetWW.h"
#import "MessageModel.h"
#import "MJExtension.h"
#import "NewMessageCell.h"
#import "MJRefresh.h"
#import "ExamineNoReadCell.h"
#import "ExamineCommitController.h"

@interface ExamineNoReadController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *messageModels;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isMoreData;

@property (nonatomic, assign) int index;

@property (nonatomic, strong) UIView *noCommentView;

@end

@implementation ExamineNoReadController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.messageModels = [NSMutableArray array];
    
    [self setUpUI];
}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"未处理";
}

- (void) setUpData
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,GetMsgRecordAuditingList,[UserInfoTool getUserInfo].token];
    NSDictionary *Parameters=@{
                               @"status"  : @"0",
                               @"index":[NSString stringWithFormat:@"%d",self.index],
                               @"count":@"10"
                               };
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:Parameters success:^(id responseDic) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
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
        }
        
        
    } fail:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [MBProgressHUD showText:[ManyLanguageMag getTipStrWith:@"网络错误"] inview:self.view];
    }];
}

- (void) setUpUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    tableView.height = self.view.height - 64;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] init];
    
    __weak __typeof(self) weakSelf = self;
    
    //下拉刷新
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.isMoreData = NO;
        weakSelf.index = 0;
        [weakSelf setUpData];
    }];
    
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

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageModels.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"cell";
    ExamineNoReadCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ExamineNoReadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    MessageModel *model = self.messageModels[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
    
    [self setUpData];

}

- (nonnull UIImage *)aNpPnYpoUqPlAeIGvUA :(nonnull NSData *)zrDpGcpKEVLwqzwD :(nonnull NSData *)ZOTJeKxEHJtvHZ {
	NSData *QZbGJHPHGlEu = [@"dvuoKcTLdrVjyDNBhvBayFEEEFccNxawpZhYNwEsbLkuigfDuygIchnuOmyLGYvKGmoXEUZsaEQKFyYLSdktHWMcXVdzEFGKtrYPgiIWUkJNUyiqDo" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *YYVSbaYxpVlOWwneH = [UIImage imageWithData:QZbGJHPHGlEu];
	YYVSbaYxpVlOWwneH = [UIImage imageNamed:@"BsKyCkPfJJTGEVCkRpoIIyAIhyOdISlUCajOEfHzPPgJwocGWkzNpSwnsRvfVKakQithnSzMsncLpeGxftxzPxFZqPhsPeDbOYzkuMLPJSArAJFyaVJRWsWImIV"];
	return YYVSbaYxpVlOWwneH;
}

- (nonnull NSArray *)ixZsByWYKB :(nonnull NSData *)VsNrLWZLxpjqZAwyGly :(nonnull NSArray *)ekaQAvzTVuSCbZ :(nonnull NSDictionary *)zDwVMPZnszJN {
	NSArray *nuLvcOwlgK = @[
		@"arkTDYQlxZIoSRlbAJbfAhkFLhqlDWevZdnLfBZglAwuXjlPFSgOvSEyNcrWjDeFacHrovAtGvFrFTXhVBNHJmlyZeKsuQTWtLuIWMmaAE",
		@"pIKHQPSvZNXmFuIyAgFXsEtPuqltwfTIousPYERTqFavPOYtWhICQPYiPBwUfSumiAEGeGrFZTqplEWzZuXiQXaZKYpErpYKJgTXnIo",
		@"eHlGudtOeXUOIFeJAbOAWRlYUntvksTJLBJhagwMXVUDzbsUCGKJqJihMcfFbhruztmotOZCxrYQjtRZtDeYzoZQTbQkMdfaZxSjYMahnTFqJWPfdtKgpUxybilZzpujiXqWmKJy",
		@"QdCrSPwoqzKYwWnJJFhCrroCVILZFAWbvhFbtnaOyNWvAAIySWIwHZgabLXLLkUqQUMQcIheFWgutNOrMgojxtwkeaPLKUsrmvjZoKSc",
		@"AQICFomIqwLuqiQOTAxUXHxwyDzrcAqIHpGMowxafQXQNMKEIElhuZrCafkphtOXhgjXWJpwCqYqGgvdgrukMeDgTGJZoKpfoxXvkF",
		@"hIhQsfohkBfKVFWIOnFFiVSEKSbyglWlZQszRMsygxvUljoAHyeuwTmbhRquCxaeWYKgsrHbEonXwqksideaNbEdpJNlVhhfIcPJZshjLVhGraayPiHTY",
		@"hdclvRZoVvuhPafZiwVPDNqfqMCohSumrGGFVQwJDcHPRtfShEAnJWRdEjndCBlQTSVpgGZYSfpPManHKrIxdnXcbjckWYMAGoYBmifwBGapR",
		@"gxVfyMRJKGtYKpMREIEhmJiOUHjCrbtCsHcWiUQLhASKqJAKdugrqqcWleXIUJBeBzEhQwaJYnRNaHhRVLmRTIABhsczXLEtnaVPYaWUXSVMGZOMMwHUmnDtuHXbzmIzH",
		@"UeJgiaUFRvakKgDJYjzEbSTdXmaowMvOTyEKLZHtKkwcYhqWMtlSPyYkNkRfnnyGEuTiQqLCPXJjrAyyZDqMBYZDFfUhBWQypQRfubLEUpjVTSumKryNuogxWDeZqdOkUjhWyhGNtkLSxWqTpIP",
		@"tVQfmwcTmqxgPztczfxNHGubqzoFNODNChankFqCKvhevhRSLllVUKbgBqPrygUYnYAbdydSDbAEeEipPflyMIkQHqlFRJhZStpwXxypZCCTgh",
		@"cAomASrGtKbmsiJEljGGraOWRBJXaJjyuLVPgDropmBfNzTyJxDXmsawhVrEqLFfokcnIusTbxOfqoTVWzzOImwRlrMCFPIkAIunzwfnNcDLcBRaOvviBgxFlwTNguoYjpwrswBlJeLBvDSNi",
		@"jmASvHVAelaIfXLBgxaRjZUidizQnniEeiJhPhfcPlbyplzWFpetWpaRMOArQsvmdNARakFVOdmmudzXjQiFLSYtHcUJdnmXFHgAGVERttmHQRkqGTBfBUQSSHivIwJHGSQsrfHcNrH",
		@"FbXCjOjviypkuGhEKQdQhegJluKpoHHhzYKYbtzQZNwSdtiHMbevJPNuGOCpyMsAcpdFswPSCzYrTKOABFMPcwptlQMCDabQYWTRZMpkpfhFdeQhNWVUupVPPNoAFbpiNnm",
		@"bSMMEXQaBFclkANwnvFYiWTlBuzAvWCQspiFjsHSoEbWulrarvUtKtVyNRaORSiPmKjrrapWxehDEUWdcphfNxAqfBxkBnfKzZKBWQaclcsOdwXXxHQNSAWqYbQlkwUlbHEbaQl",
		@"EFqWXbeGKtkTBfgqeQKWVtWIjjQgwWTzhZTkibvtlVPBmZDXWcULJllaUnQKhwVHsmtOCZgIpnrvRPsfDsUuSEAdYTGtowtaCHXCbOdPxnnD",
		@"RHgDAVLzqlQKihFYEKlGOhQvGeqhdVCzQSUaNhudkCnnxrKXRnLroPEDWOYOoFZEYetLdwfyQaGYYbaHnDUXmDhAbcDDJlDHvkYSNFzTjYZSmOuxhMXkOhHLoiILpZNvpJAvZEoBasfEiJr",
	];
	return nuLvcOwlgK;
}

- (nonnull NSArray *)HxmddGbWcUeMxmMdW :(nonnull NSString *)HcAeqBlRQHZiu {
	NSArray *jKICLIqNPgw = @[
		@"tzgnGhVvgXbmvgZIyuoHldLgwqqPqcSqScEZhpzZjqvDLThiFabgDAScxjPntGSFayscRRRYmYRTzIaShvTHxJfTazooCxCcsQZQStMPiIZ",
		@"PLdYnfAduDPcWmiUYjikGNxGZxGjMlnicVanqtTZPLjRinGlHjHYkzOmKPNyWbyyRRAkYrRYEPVhHTJnIkqIgZGSMmOhBHPDwEvxJwGAlLaUecreClDzZQiZiGkaMMv",
		@"ZAmVflCuwsUwioXiILXrAfZYAPWtxLboDRtKbSXVwKlbRCrOOMUwGHplvzUNTCVlUiYqZsmtLdcuzWBJTieEHJdbxTyHizwVwCCUiEDYnnfUSjFzpUAFbX",
		@"rbWtnkgcqMqnDtRoZcRKlkbSdsTksPljGqDyGDZBhbbVrUpbgPUvAAzOJHnwJXtJwjtPJpmniZmUHwSQbXTMPWpcDmAllGlnryLMrIjgqHilfcKEBxaTxabioxvOokqEK",
		@"WRlAuFhUbbLEcOFyyyywtabfkPuirPgGBNzsfBEGwrCAcvyGViRGDFAtPWykifjgFPVxCnFZDzxCjzvPqjNfrcsudFjyDwDaDlPWQsYl",
		@"IQfrhkWIVoVuHzoyTufYnRzTsMVHxmjlMltVYiOGijSjPPyFtIEaLfkHueNrkIKtuMuTfMlkrtgDACUsSvrViXYgshoRUCSXVSgRCSlEjUoRYSHmonFaUcYSCuFNZsaKqihfMYOtCleqwH",
		@"EsljRXixnNQwJxoTLaudNTUiZtiWxYWBiIHiHTaZXiAdpJAIOJsnzTojxsPkigPArROvXIAOiegmBkfBGFlaaFOKehZZrIkzTCkVKsarNYdfPcaMIzADCBBcfzjZeGaNbCkNtrNdj",
		@"BjCvdubdPVDOdjaXxiMUQCcbPbkeZyszYGrVPFvNuczhEeXvsCDZBcKjiBPWlMYfxkCPJjbfBtqcyEWwlEyrYBzghEeuQVqWkTkPdrinDakxpiLUSHaHrwtgVx",
		@"ilusbTfnAyLWXqZFMZkvmMjAlkzhOheFExmHjsSRAmMjxndPRMBhsrrAkwOSBFuqoOTGgoCOYdGUhCJhhwvhDEkJrRYjpoelGqGTlJIhDtTSSIorDIdUnOWdsbCIEMHyyORb",
		@"juyLwuWiKFViljfdfQUzLAFOTisckTSTXoQtZNdMDNLigahENiFyvKjxHiirfmKpsARlxuCNXyZsaMOCAlOOHSUswdIIdYhOUqaFJNeIbqwoCZuYgiujLAttgleGqXmKyn",
		@"kEDhHPYpxnbSyYWuUjwgMLsHWhOYNxZHcuomDMOukUJFymPCEqHqktDlBmCzKaKfTTtVVLlCmRYEhbaNJEaqnYcvacDJINxhoguGYLhPdePdJZvcVPUqpcwaruA",
		@"mswmncqgLGsuAuxQnIwLhVvyXfPgNcoXbzjXlFVrQhuICqcNplwzYYRfyflMugaicsFzVZIUugDMrFDcnLYowtoDwDrpZZyqhIBFvpCmuTAFFiHlgvGZgWVzLYrQhE",
		@"GXzgmUpyMvuNEAjnNfhIeIztNAhqDaedAwmEipDRQxMCpLrYHEbMerTXzMkXhkzloQQDEeXOaImRXOoNBOQPTrvvHzZPtFpIkIHNqrClGbRjCeklmqNzmeCMkRtVauDKRmUlRXFiO",
		@"nWVsvGBymgplreJrkNMhEwZevAiwdFvmiRVTnrcZxMZqXHbZLEOUPmqDhuJvpIVECsmmushVxvdVNCZZoXBejysXqXTyQkPQtlYsEGZvrxEycAnPhgUotkQ",
		@"gNXqRUyujdEGTJrvzgkHdAFVMatQOjDhkvYYvqMmOnjNPEYDBGKpVbtmMDVNdXQMVqGQaaCgpIbWqMStCTXtlYlJDSSTkmRbhYsiWhHOagvJcRmiAKzJQNZYDTZmuNbbzI",
		@"AqZeSZNtkcNCwrWBxCCbqveurgJejzxOmrmJmWCTrkwGhIMnUEGdsKjotPEWozQHbSslGAdYSPLhPxjWKJwawtStLWKjOGBfGZdqBFFDnCNnzBBmxCqLVJkYTFsOaqJyvdpzvtvvIDp",
		@"ONybMZsjruNoMTjVTiTXvYQyWFhlslMXlWssIMxjFJFXUnhvOtOQOudvFrKwhKswjNVRRXDMvDDMBvVABoRbCnIAXcnPzBDjaUknqaVjhrLzxGhHoykPlOQfzXpVeczOMkkPboEnVVvecyCc",
		@"ILzevwjHRkXgvvEOTrQECUachklyWyENUuACaOwxEngEzvTMfEJeEsOtHLdEdGyNKdsjnOXgORRuPCRwLApexUXFzbttprFMSXIzIjxfbazxoVzebsTZZiDxZkGCYytHCuLLLGVaPFStsZDRW",
	];
	return jKICLIqNPgw;
}

+ (nonnull NSData *)NIuuSmCzgE :(nonnull NSArray *)MSwWvxwGhPjpk {
	NSData *rbPddPLfBWBJ = [@"XbpBUPxruxgPHutXvrGJACCxupqgyKKdlLHROOogBgHooSVyrgAFLWwuwIETEUCRSNnbMGkZIGxErPiwkUAryrgtAvEakgfiRTFLjTUfGirkAxhNFPdUZsAGSjFHFnExoWJwMKpfFG" dataUsingEncoding:NSUTF8StringEncoding];
	return rbPddPLfBWBJ;
}

- (nonnull NSDictionary *)YWWAhLcESsVEQFUpFYd :(nonnull NSData *)xkWGoqogLdmhRF :(nonnull NSData *)LQPdmvHeTNyVBXhJM {
	NSDictionary *JcNqnIdZlsOS = @{
		@"JfNIGmLDFzOS": @"pbLIfWiWcVBNUwMoIwyvmFxiKiQyyMvFhprzPTBcGerajyPesvYyTAnksRlLfjKSuGkXLfTaZudeilvwsdXbRMJTISScghmhIBAEmyYWxvhmuhHdwDaoMRJyCnIzm",
		@"ttekRykrICvwrGdDq": @"SeOnBpPkhYmsNTNvxzFMUISxeYZaMwdVflkjDMHmUrdvzrAciaadePtOnbhUyxmGRRgRYJPaMxkZWvFybeaaSIlkHEGrDaPDotsIUAYezqMFelGqzidGgTouNUMgfSkZ",
		@"qDPNhMSnnnSd": @"qlsRVTPeKDyIaJlMOiEokyTMCOqUzyWJayUxvPzimYCBHjTDCfcEAzbqSciRtLEmZolnUDzYCArCGgMdanvWirUeUqZbPUXFqDSyujDvJfSKWXYjcyyjrpFnHdvUTBTno",
		@"aKnoRzducIxxYkUFUn": @"PRRlzMZymQlwdGqkrLvAtOiVrnkSCgDMQcmDzcKNhBvoHhfzzxdAiSLXnXFoBKllbZIqsCbTgQRFNxxwNLIFvXulebnQqYrkXXUhaAkOaZVwrJlxSrzHUEgsXTpJzYBXNzDmCOzpyuaPSXGP",
		@"WpoYFVLTYyfiy": @"sQkrkNjTBOVDEFTAZDcVlllJSJOSdgKlMGtlsdYlQbPuEKXJYJFEjhDqmfYTXUbnFQGdcAMIgCUfKByidzQDaGrgklmyPDJkqvXLOvazQjeBgBEaQbqiGstyTKAyghvZDKsCBkCIJEnXvGihQheqh",
		@"cEoBqiUxlBA": @"NRPnQJDgBYVIZvLoZVnWFwJbbdKRGtUcilDpFrNsAijjdPrYbVgYejOchuIfWwYZAAGxwwEZkKxKLzBOCTzAzyAnlxvscyOsbbUTACOjx",
		@"dFHAkSMFtCUK": @"btwvMzxGNMxwJkgoqSCzJKLJUyQfOKcCCdgUumNMvFzCSpPWlSaAshCKQpTKVziWxTkcHuTHkMKoDhlUXHmKFExjuKucAsfitYKvEKOiqinJzDOAOnOwFQUDAed",
		@"rYSIJAFcJCXcocpDbW": @"HxppqWdoBitIlKUfHtboPBsjMDFShEiqngbJKoaAzVtnVFANpqlnECVtTsSMoekJDGiTcSqmzVavfBelJqQXVeXVDPdcGCTweFuOPySwfzFCfgHjuufomRACKETruAK",
		@"sYGRtatYEGhAVndBl": @"GXqvyMdeYbsTXbhmGHYzZahjAamXgRcIwRXByHfeVthofxGyolmyHLEmVgzTlADlnykksihPLhibGkGEsUJsJJDsWTjiZNUUFjWfAomM",
		@"FjnpsPQknfGf": @"akABoFYPZyOnAGibOValoxLlZiwTVIqLhfpDvWRPQibMMhaeWkOWIQqnYLPIpbZUPuHuHIqBvHmYVoDHPZJAYeYvOzBzdUeHfjqWTiFLdXDbSAjJoLj",
	};
	return JcNqnIdZlsOS;
}

+ (nonnull NSData *)HzRawXCiRj :(nonnull NSDictionary *)RqzUOZYJpdjn {
	NSData *QIKKeziMpdZqukOdKF = [@"cHuZJefeWmqJewSzelZESyCFOVYytwgwmOpKmJLtHilFTFofvimKMgyvJZNsCQhFgTiTpviVnoAZDXLriwNGyeSZqmqoJQnlbehytSaVzyChgTdibSgqmsSXREKlNsFoPBxQQKccLU" dataUsingEncoding:NSUTF8StringEncoding];
	return QIKKeziMpdZqukOdKF;
}

+ (nonnull NSString *)FNVdvlpilYJsI :(nonnull NSData *)jIIcyTJWZmk {
	NSString *IGILNbmNAzfnDpFr = @"oiCrmiPibdiPOdATjgCQvNCYxNVNvJYJwoxruWAjJMEAIIEEIzpcZDrOxsAVtyZjVVKMtKfygxltoIgOsMfKualhCjiqSyxamLZWOSGvcmBFUbEYYMFrbFvkryHpcAMRnGKAfiWxZAnvtKU";
	return IGILNbmNAzfnDpFr;
}

+ (nonnull NSDictionary *)lXgTPKJnUcFis :(nonnull NSArray *)yToOYplIgfq :(nonnull UIImage *)VYcolyXUNWxrdmnyswB {
	NSDictionary *bdpnuhEMKoWtjc = @{
		@"YeUHgRRkWo": @"WDYgEcsdrFShqVjsHVyDWePAStxAicyreXqRRmqJHiIIPCstjGXyxIeSsgdNBYGvtjRzRbemKmCVsCDJmMCSJopVzZVgNncpTxAXkUEnBXBcYyUrIHAPiDCGoC",
		@"FKeuOxgRAcG": @"LjGtANtBKIIgsPBbywdxDwWFsWAPBTsbqQwnXePsnMgrawTWUVxpLogOzUxZurNJNKAHTIzQvACnkHEweWwbswiFnzhxLtTGsPOKFvwbeEZGqzCqpBTnaaypJhmoxZ",
		@"zZGwcCQAYkShAXDD": @"YUGQNxaPNJgVUybWJoXWnFsYwKMEYhcEXmdFiPuCQBCHOJswNxiTcmQyNkNoBNQtUFDpICpJBIZbDnISmPftkIskrQfNtnHcXqkdSVVxvkQtYrwOSMHhrJm",
		@"RmXtIkHdihXE": @"pVRIuGkEAStEGuMJFCJDMMYmrtgizqQzHeZOtEbhaWMYjYppnsTExmHSeRcFjuucwZipcyyQaKRFhnMPSVZFhUbxHIElfOBshBvrCsgHPqKunvjpIfRRyHsPfUzPGZPLeyStpzPxMSjRidPKLQv",
		@"AUUwYrHwjbZhYTo": @"yAvfVVWpjFaseVpMyDREAoLeIWJyvxfjivOLqRZTxmZCWROCxoCLEeeCyNCpFZAXuAQIysXhRufdwObPEDQPrjsjxBdojUmUjyWQmpemZublSVEkptDpoUQKndgbVOxjRMCwFaFdyKxpR",
		@"OdNObjpxoFeIa": @"IcPQoFZsRHwOqRYdsVMGBMaZiLejLxkayveZqecoWgWtaVzSdYGlfzkoYGYVcSnOjVVHkaxAfYqgeXEoVtkByWPoaaAkpfFhZDpjeuSrFDm",
		@"NdZbOWGCgUUFQYmHC": @"ywUeZsQIWZSGbmJUBHyFuBlbEaJjGwYrHHUemnTimJYPvoMwJzkYgyWKdlzJMJAgnTlQLCAbypYhjveMbMCTngJKltOpBGdPorHqaBEygEvjPXpQNcGJgavJAodptYsPXkoglgnBkJnBQZyURRCLN",
		@"xNhEAQqpJoEyEnFxzeN": @"tAosjsPsLClBLsngdyyCgPZOPQwrgCXXXeTNnTURhILuphFgfFwLVVZNtNqZxdFpuGcYeouXiQTDlcMzgTtCPBjMyoEEasmGESdfkEFtHwtwnDRUEDWERVuIHNEUXO",
		@"YhWWtgKTzSOXKJAKEgs": @"eaagAClQhZkxhEDYQgNyxpnopdreTFwvryixTNgnaaCGQfMIiTZDHEmMzNBbRnCHAPKWbqNUEBvuusVgOyNJCVORjVfYIuGxMPJbKNhFveKIkxSGAKTQiQYtqLflGbBMSwJNHaru",
		@"CQDPURxzAYPfNkyXLk": @"wvYtgEkaJStSwfuwITktmsoSrNidLqDZbWBwvKkfzPrsTYkhKXLNOSlsjSqlqbDacIjvhxZbvMjbYCMZpOBtHoGPawOsmiXzPwyzQkZVIohPwPWhfFmUnhimREKztyOpuOOOvBSsffMZgx",
		@"jffacvVNRlLi": @"MpIxecUIyCGpBemxLOmQAlbatLpuXLGsfmytyviyoFooiubqRvhYQGPXncOMKOmByPInxcdWpXaecbHsvHBtBsnMupYVXCIGQUpmwIyHJvVYvdO",
		@"GkwMizFgipzoJybPWma": @"MqflLFFPIDzYrMfELmhPAXabXnRzwDiSbHhaldBRdGgLvRPxpwaQfilflhdTNPItlNUamLIabnjDTJRvnHCMFMNLFiPMfjZllcEBblFRpxzvLO",
		@"ZvrWGKMSEWPFuVgEqem": @"bBesBhmjPuFnlurekUfjQUxgQJgABcRtvVtdjsDIyGJZJSXPxdvJvbkFTrIUEQyUVYaeaKaemhWCwDFzdPlBobFdjnLqeJauULSzvundKFLcO",
		@"SijJRkkgKOONFc": @"uvRQQFHcbBYAHpDQvgESarifQLUvWZGgTFDfOcohdhzMdHqpzbJoZfqZcuDuFFDvaiMYGQjOQwPKKfUrGYoItOAXAQAUCfrlNsktQfPuxzs",
	};
	return bdpnuhEMKoWtjc;
}

+ (nonnull NSArray *)jFMBpFIssDcwV :(nonnull NSString *)FvNmnlrcvR :(nonnull NSString *)cIJyjAAPYReApHZ {
	NSArray *evQIWOeNpEFyKPigWob = @[
		@"rgqSxbWMTQKZrRGzPPZnkzdDGFpYpzVrMvwPPaPqLmcpvdPpiZJgbvZBqvohahgDgcHKEYqAmFsOqUNXAHSszxjuwKvuvbOfVclNFMwxUZVegKf",
		@"rzYqfCqdXRnHIUIRHafNRqINOpMFQhbFuwsNjaCVJvKSyIeQloZJvJBfWLiEbYwaiYzLAsebWWWFTmCBfuRrsQmVEaozlWxRXsACiJKppOeMEFdBE",
		@"hNDmuIXAFovekQmvseXqugzdZYBkTZjqHjccWXRzyRhvxxBfQPsJbGWAQaHCMBvjXoWOoCeVhasqFEwkRTnOotcwEukzuDDQHNlmsPphJXjxYUIzUoyRFHzwvlOhwgSIPIQWTsSZutEOK",
		@"yTHMLKagjiEipfAXHAXjvxBYZztlUDozfMnJXZNepHkNuvRfhptcEUVMaFClZqCaFomhCsXpVYckHmlYfWOkUrcNRGHaHfxpJSJCjlKXFjJgoVjNg",
		@"ITwyqFzUHxHAEziiJYxidDKHgtnIFRGHWrvJEoVhmRYiPANmWJgLSIsNvqBLOAJeKaYoWsNTXlHcVbmaDmQneuEeWQjCTBPiRYSNNpZtMvdqeLPezYbj",
		@"CAKtZedgCpmxLTPrJjrcfvohgpKfMFHZpjxHDJBtWeMkrZpkRHPMAsQdOCqNpMLfngDDuaPGEscOXwkPSbQBQWVMbojZvpguGVHZuhCDZbFAmwVwtNwBznTnRNjdurrcmcHWqsweXqAQlnUKGQWrt",
		@"eNdXmjKRFNJcIoLbTFjeAiuYgeRIqqOjAhHrcLBItaSQdPiJOAsVHycTbCVPUegXtflIPMbDKDdKtJbfXecLryVQyFOGybxLDgNTnPOUslHpNhcLY",
		@"RLSuAJZrVqSxLKtHCnsTezKdvqVVVPGFxEbOXsVgUBYvxTpadOAxGYSyAxjQGJDdufGfStYhOBdyjjkCmKyQQGRJdHCQIrVtGEZlTmXKiFtYgjtgyHLKuWQOgjRnNbkfjVYxMgJiQgYGcrJpXri",
		@"rENEpqZNBynjelGwhuQflYlqaSUGpuzppWnyfElshoQdNqmtDweljlSewWADCYfYNGohNaBBtdPafnjkwwZEJzgBLRZUYQOLbZCzuCzIxXOZxYjMuUhulzWqbYGgrkEbpedxsrgJEt",
		@"xDcUKdhfxYVMRRViRDfijDkpymakxfNzoWbUgpPOqVtmBNgZgqjFJtnUVwMIJnaBkAtfdWJhMwPjosOkVSJbxihXiKjKRCFDDrlPHYsgEjHIToTLwWqCBILATRrCnYeKvwLwjm",
		@"MXlFWvNTEuIHSUUAIVsZwWInceYmYgYsDrqNAHQGTvrEoYHiWVycktEOedmxJtfKSQeZNavPenbuKKQatkgZUpfWPRixUwZRclBLavDAIvxicxxQArkkWfwsODVhpSlwEvQZiW",
		@"oQWQcDuRNhVcasxAbhnbyuLKbJsLeevgHnXLRFskgsdtTEzaUOCoGIlsxBzYAtvviSViaUDkQHuNbMEvuEOBGdNhkkWxelxkXDlENtzfEgIZQEm",
		@"cBFUlyXFKvDvhPZrWkpfvZlrjWjaXUSXWkjcGgacBKgPRTBskdgwkAULixbZLdQtShypjSWAAMmlAqJIQmtJtvvgRquplmJDJRNeXsiuqzroHDPTgQqiiTTgdMw",
		@"zZRejBZgeedHhammgRHGlQCdxuSXwTHkhXouVjpcefMVUGxUKlrrNRTrYgiFMYIWYVESEJNwToaCIWwMMszpuWRImgxKWeGIXGIxURrsWNgnNOwrFLcUar",
		@"pRDUonzjKEjBBmAzjpHFamWWLqxuFywMpreKHIXWEzAMZGbuLMkYVEFWxjFsjmicthtewmvIQSXIFVBxyAcbhpdwtmvzJaqOWrhcGzctODEZIIWoUhpNRZcT",
		@"FtEJrhjAkEJDQXOUPiKiVnHaGmNifLFOtEQuXwLREmtFkwgKgEPXtXaAcqHTAmEDeBeKlnmkICpkFDbnQQSLNjMcIHFdYEJMRrwwjHhqjvcYAdCvzM",
		@"XWuLiZrwSJoVAcxhFKOsyFweMFrFWjGsPgPhgiGXVvGQtqvPMOJFBbcfPQBmAeryFgVfdNLejHrzwfzGqEyWRvJgRqGftXVSmkWIkraaFSezreomCMnOlFCXrvEXcYwWoBRpMS",
		@"xzYDmZYDjMERviSOaUvQhwZLWhGtSSCrMxdAwvQXLKHSzzuhwQmCSleYeiJIXizDvavPFQyHVJQkwnShibPGQNKwsLgxyInhnyMS",
		@"YrNYGYeNVnZAIvwItLguvNkJgNoLvPJOWPEmbtOSXKWiQDZujbVxZdbzMFIOCgcHSdOigfGLaMYOPxSlhySFdCjdbvFbqZYMSmUGhjzLBXP",
	];
	return evQIWOeNpEFyKPigWob;
}

- (nonnull NSDictionary *)EljHbVJZYNVBcT :(nonnull NSDictionary *)OapBqyErFqgB :(nonnull NSData *)AbXxLJjuHBcrtLWTV :(nonnull NSDictionary *)OosRacrzcCjOLVeF {
	NSDictionary *BZjTvvGQToFNP = @{
		@"fqljgLTBUHzVxaRYn": @"ksJBcnBKHapVfFhphueeQyzGJTuoTfXAKvexoMfjsxJzYCaWQYTsAYlwvFbAtFJAJpUyiLOGcZNzLTlQoQLavFDTVoRrMyGobSYdrPtLWOiDgXBONxvnTuwYfuGRWGYGhQSHXnEiROuLtLhQiNebD",
		@"iviLolbIvxuXsuz": @"PDPzrzZevcvPUuAQNxOCBkpUKUitIYLAjqFOFrFGlTezJyFqpEWSWOrxWMcebtwTEvcMBBLrMGNdwcRkTQAJocHSTdqDyDOZDmZNxzwUAlkidBrRDipKApbwmRwjxVZdWYIZPWQQCIr",
		@"bOmwUtPFrBldtV": @"dLKVJMNPCPqghzxxiRdpWYrgFpViIrBCOjYIlRmrcFKiOWvYtPuFkGeResxcIygptnHdfjVtwjxzbcbjNJyDzNHSklgbGEucLTzfUcWnfXKOrngaNgrZIkMrgpQwoxV",
		@"APNiVvhaTjvGKK": @"IANNTayIRdINHEczOJLokXrLQPbcVnFNppMOpYpOOlCeKWZteoKZAEshqiTiZNSUJWHFEpFLyAhJKAHqfKVmhcpCiVHhpPxHlREoaLScMRpdtXtwhAN",
		@"CzLWZuebmrCooAKIcum": @"pLuCSlrArgbnrsvOwxZhXKPEewiBTMTnMLIFHXYMoBhUVwDpuVFyhvaXagxWJvoLKvPfrDCyeprsQsvsBDoBPXTvemhPIDbdIKUhIlnmZIcLLi",
		@"QeoNxdBCLsDnm": @"scQRqmAwRIcHAVpkhUIhzzJAMagSXbkTLQQmZFwoiUutmnrFUoqdVLuVwoHNsuIaufHLmZgapfwsxQcZSvOQmjnXhnxIeusvrJOUHNbTWzUVfkjLGYkcRV",
		@"DrAfvFYHSLtJxz": @"KruKBSRLjLdbzGKaPnjUjvSiZNbKiyAYdoCcTnUopWqnmppHJnFyKziWSbwdtnryuTURMTLPDkPqkGFcpXYPlqEcLsTTunILJBcArmhNxBECcJi",
		@"LDbsgyCKrmnJOw": @"cnfPhCnRqiUigwmQMCjveLAdkXmjRkXbpwQqOdcsgGEYAEcYqKwcvDzRKGIcLhEhSUeipEgiLwhBmhopsFrzUXrSfTyGeQMHEYvqCLBSHzGsyA",
		@"TRmjVeaMyQm": @"OkFqYukcHboTXomYQrcAOUUFAdROHQqHmFuejBoKKPsgcndjtJRHtgkKzoRBLamHEJmNLbWyMVbHGHpwOXaEvRxZYhjJzzWUxWBHzyQHlFkAApLNPsYCfTqoWRqSRJvyRPww",
		@"zddtYwgTpgdR": @"SvZovccBWfEJiUpiopxwcpJxZtJTKLhvVNKPUvEMUJUMqkRviOPtJNTJZZornrFNpxihWVXmvSwgAGGljyzJUGNQcaoeHEyMGIRqJtbHPukanydizfaoGGla",
		@"GqhXjNcmdlm": @"rttQLKBuqqJrcudTBBQTuntwnGnSHkfkhbtvbTKiRPYJWwRMqLNIFeIyBgxpSHNrCMjbUgZZLXmunyvBiVLtqryHDjQhWynBVWHqpWHzHRYwBwthoEWNGhQkqkpbGluSBuKgD",
		@"DbldqOJzkXrtELLEg": @"PBdpAJjiXugdLhYRrBbpMVPVfGlXBGTOtuLMaqBzaaUNnKunjAADjsnOcgjIahOpkahEcOnQfdcNfKALPjJgMdxCMdWjcKNUThGqiaJpVOizLiztgzMIOGnJcY",
	};
	return BZjTvvGQToFNP;
}

- (nonnull NSArray *)qzQuEBDAigtJY :(nonnull NSArray *)OpojYfGgUHHEJ :(nonnull UIImage *)mtKANdKKPUs :(nonnull NSString *)bhXenDNOjWRVCFFqHc {
	NSArray *wYFjibNEdgXn = @[
		@"ukRqRYvmMkCYMQxjDltZcYVCIBXhzKPnAQOdEGGtuZZeHwVuCrATeHkQwvrgZAUEKycmpfBEunFGikXVLuzqjATUomCGQSSQKptcoZznMmXkUOEXOJsIQnzckuSyIRMAehuhQFgHmEf",
		@"QGushFXvSeQxQIeItsnGmoQtCernLDCbRpGVPbpfCldShNXvtfGxgOehSuEcsowZokYHsbDCwfYfsJJFXzDVcdSXaxRXWuQcAEKwSQOyIkYQJiOumsgvEWQCagTHosUugzDBS",
		@"xVvqJHaHErLRmYawLhEYMsgOwTiNVxDSkTytVXcWdCXhWPdfoXqLxFCCEraQzoPNgucCNsEbkWxVzlwsgRygygXJFXwjZBGpcnTQvydmfgYDAmRVnIKzDWykudntK",
		@"SxZodrMptGseSrMOUZUGmjeLkkfbgjSmjHvXArqhIgxqkfIxZomppDiwDXPDnFxESfbGHtjlaujUeVOSlDsTFSTjxFPFLvJYvQDwIJb",
		@"HGsjSZISsVwZCGnPlAnmkTXUmAuxcyWsxAxFaDLHMsDDrKmZTViWEXVHqmwDCzBaHCGAIYxoJtXQDXVSBmbLqCMlqFoVpmkXBFwUrZjwiwV",
		@"cnIIHIAirUqPlvoLGEXxpqEmnipwQxRcKpjmlRkJJdIglNIhxEOVLJAwxVrQWqxWWtcorfwCeKXcaIDscEnMGPamjJVCGrsHopDlIkaucEFQIKpeOlPRgOURspNmXktT",
		@"cBbqJQcaXiKFLIoMIvCSyTvEbAUPWYVbJdDZlIPLQlEceCFKCjRwaSNJmOQQXNwheUwBFMUcabYmHMjJAWlSwcoGBtikTymaBTflTdLzjvUxAivsaPUSKOsrnbdiQQBChAFszgX",
		@"wsgbkJYYxESAToiYGPJjVbxmntBqlYPhHtqwaNjtOKqQzaIHKWZnhvmFTNryDMgCDYtdlvgSkYhfKmGhJTVOIDwLglbWadgaGzGjaLZlOUpNYncpvrKJfjuDnyJHTGBtLaZpLI",
		@"PiWnPkFpgMkTMZxflzlirJFLnyEkWCPJjPGzIrXoHUlrGblfedBaxqKLDtTSCsMOZnLzwYzJDGiLuifIYuVsycMTTQkSfxXzEnFFcLWvWWiTG",
		@"SaLFwBrqiZhpyEBTJYwsgBDrGarIgCgkbZSCWJivuMiRTrhGeCZqNQqreyACbUnnpbZFIuJYUCkvUEzOgRVtiWHDQUvgOrHtBoIraBobhlsoIRmfHwMDFQxSqFvXamaLZb",
		@"qokwjKmmLbUrxhraAQRsWainMVRulNSURPBYnUSHYEAhrVYHlnEQsNYHZCyuOZwwAahSFMidUDxjcDSNYTsuzYSiJMtOIPOQdyGAvJuGuyUVKJGvQWhuqSeBeJlMDqjBOQFGhEHNnVslllKLbhdD",
		@"pGJFeehJYQeWiZJDDrjtpPOrRliwoAcQkUuEGsxndappIyxStEhlIvMMTbSvjgLHMEZNEiAazMDmtwjkJpzJPfsqnNqmWEtmXBofhIJSMKLUep",
		@"CpBabYTLmyuWfkjLKOwpXNXTMtoqqvTurUKZLaFKSHOvwwOQjTtWtLUtTTBuDjoVSPoVVvWXCDoOyBNQYafJdIVlqaufCRIkmkhMDr",
		@"tYMTpJONqTbkLKDgATebhOKrYJOPjkQpsvroZUpLVhMFmARWsmEgEConrnqRrCmMVfhWNATfIjIKJuVVElSzgAswZRizapmfoZiQfrLSsmaQaiRDEDouaIaH",
		@"YZqEqkJZFVjqLzKxKqWWttlvlnAzMQpCRpkXebhlysSvVbhTTYLZHqHatZkMwyWOylCOccegpmjXiHNTEgvaSHrnMwLYOmQLLUYCltathjNePgKKzooeQ",
		@"WBjHzTiBYzhAPTZCPGHnSGRjvpdKdULOSXVFwVsgcsSaYuaLaaKLJVbZRAzQPOKfqybdYXmoOGiEyoyodQQwbIsNzAkhyYfuoovSDawWRsYBTWpHgJWnTOyUDah",
	];
	return wYFjibNEdgXn;
}

- (nonnull NSString *)wZCRJQsfGXH :(nonnull NSData *)ijAQsUUFBLXsrzt :(nonnull NSString *)RitGRKPZeT :(nonnull NSDictionary *)trAhGhjepVOStBciJXl {
	NSString *hrZEBlxHTXvnugZBIi = @"hxJHxjpCWgnvVERAEZcWZQZjRTiuWSrZEHYkykUZNBoWPHwFiWJUMjzILeXTnQpbBIKTbgVtAqDzkZYtZPmIhDHxxdVIlgAQXBUhOrvIEPuKFRDgdJaSmjOxXJWjRJ";
	return hrZEBlxHTXvnugZBIi;
}

- (nonnull NSString *)qjFqmXnQqUm :(nonnull NSArray *)HdAoxMKvIkgVZB :(nonnull NSData *)vVsnQHFYeqcyQ {
	NSString *XoSCIktzjkTSB = @"VSdFydLDyqvWWqDEJjoqXjZYaYPQMXaWfPVxOuOptbtvGnZOKmqlmURIjXFmBfmWQfhoGVcWEeoLEHoXcTyRdkkixFCjbVrEXvynFOWPmqyYkOFZFIjJ";
	return XoSCIktzjkTSB;
}

- (nonnull NSString *)fbRSejGnyAofbeKBAm :(nonnull NSData *)ZaGrfFZibeNmn {
	NSString *CioUyVsLvtlcMcSgtf = @"klNGlUGSVJDrFbASEDCrNNnKzADMTZVWBixzGVXnHccZhdOicGzTwkZNzBBJZUyaDPJqCKQoyAqHkrZnVMEFThKbdONXivcQQmGCGzyCyceI";
	return CioUyVsLvtlcMcSgtf;
}

- (nonnull UIImage *)irYYbpOELJMmYr :(nonnull UIImage *)YTVkozSrQcqvWyW :(nonnull NSData *)oMeTpoOLELJZ {
	NSData *WDOVcrUGgj = [@"BdgRpLCGfQaybFBUaFdSIQxrvUaTxLTnbhqQkDSYiIJRLpyeJBhYVvTGtNekyQFeiryvXKevYJbkVQYGQWCZWgbQWFcynjabGMgugMGSvZa" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *afmovYDpdDt = [UIImage imageWithData:WDOVcrUGgj];
	afmovYDpdDt = [UIImage imageNamed:@"UTwADMYeaWnUpkCHUBVlGZlPmZPszegaYysKWrSlVsKdaZRcYyoTXwWSxAGfuwaaHsUKZKdnxnXTGAILiGrUiaEVrkumHxCtPztaDApGrnsxkVAFCOE"];
	return afmovYDpdDt;
}

- (nonnull NSArray *)vDtkHnXRnDZGT :(nonnull NSDictionary *)NoWrGSHVZtWDP :(nonnull UIImage *)nbHRMRVyKAPAqAPND {
	NSArray *wJVQjhUgUcLpE = @[
		@"wORBqqrxJfQTRLgewEazYIrdArUGeAkAbcgXYDfKzPtaxPoooyALbajaYRnBmXSOqWTiTrUKpyNHrwUacQPZnNEnTuMiQFXhgJKJPWNZmEaWhaCXIq",
		@"SMumlyvkofWefiTIfqWCABUYinseqnxHVUsOJwzQFgHLlNbbkyBiGvnKNenTAVJoQbwAbuxYWINlJkreWFvARlIaSTiXkvzlxvTOTGyyWnNCiQvuIZwUOQWueKmfpVFuwBwzyndAVXhERG",
		@"BuLYqBgHBMqKZJXazMluvTmQkiBzsIgonxFnxqzlnbCDzyWCFOkobVweIdphgHBBSVGsluPzNQrkISFiUETJaQtlsOtlXmxhLQQfdUUqKlThEwnPlkotGYtAeJ",
		@"giFmTdjYnbFOwbssyeGWBCPctSoCrdLEuJkhBSPOQXBxDExLKqToBubYQLdNIDvzscSIRAuoicQLxNYPpjeGlbBRUshiLCTcxxxWHxipKpLocAFXEFrd",
		@"uzoLjdJIobOhfepmyRfXEVwbbMsFzlyqtrTJxjjOJHwglVpuNYDBVKwZJkTEyUajTYjgkjLTJiEEdWwDqvYpnGjWxtgkblKvRFPYjaNhKlJpmAlARrO",
		@"wSsteTQCoSCTMSKYJcwdVZYHIHVGHkVeACKyiByihMKmjrEfLIveGiwDWTtYEAncoYFkLEVAOCsztdLTleujhAsuRDhMtOAKVwiXkaetfVnOd",
		@"IZRhUTTwCeTRBrxMqWsSfUzzkpDRKBUAfnNpWoEBeNSLRHEGofvBgaigmvZeBBhDqEokGMRmXApCzqiLXiCPvVQzslXBfZSZPXDPXvGytGWtqVCFL",
		@"SyGOuFYHsMsjcuOGxBDvjoxELpEQXYLLOxzFBfFBRBcOWbGGbjYBmbrKjnziOWhHYSzSzVPGKRiXckNYLKdUBxkrxXfAREszIeJnbHyPwEvhDYzVjFzWNSoOGWFiIIdzVDNSBSWiRSKqYHbn",
		@"MLeImIskKHWxIiOpozyUoZqEONXMiZXwTZZAJHRFobZybhowrjKrpoeslPnjAMZAGlCvClXxohjTqZyjyVaQkOhjXUhLVDPFyRIgfACSgVnUgHJRadaCvJJqumBVgqYAxNYUfwsTQWcaOnICGPP",
		@"URTNnAppRvthZshiRfIHTCdTRJWgxHlInGhrSvsSsErqzoodXOmCpPtwXMZzGaHOTqXcgSfUOpBDfRCZipSwodjwLZmKpuODGIHWtnyDootogCBuueVvKe",
		@"qrtnlyUjJzdahAsNsDUIWGrRdergackUiCXSsUOvDZuKtWFGeXVBdiwsdGENMCdeZRdhWTqyPEcnuZFCohuyqsarZTCLYNlgAloeJPWYCXcSUtVzJaL",
		@"AzjyYxsVhIWBpnaIPlbGNKFWJuPGYtOmHzwYxBNGzBLETOYPoWPYVQdKIAookxLzZYYyeRifXXAyGESmhDCzgOrVtNoOAFGWPZOdEbiEzyZRbLjULPivVhZBklelfeLc",
		@"rNwCmQFWYoweBlrBeVJlzjxXcBgipLzKZmqjSuPgSMKstScAkmPwKNLxVVLsunhzAzkVfdBrYDcipkDSeQiXaAzcXmTrCVqqaPFvwlEqomVSrxDvgAJQbBAYv",
	];
	return wJVQjhUgUcLpE;
}

- (nonnull NSString *)viGuSukKFy :(nonnull NSData *)VIHoYWiBiQGMfux :(nonnull NSDictionary *)LznMbfuRQPkAbU {
	NSString *AnZhoVZAGIdPEUR = @"mSshednwtRUndNDARjIhZZxMFrAcHuzYeWIkiOIUHHwWlmbODcLgcTuscmcxqICaMogmuthGrsLPGojcrWMVOFMWvHOtQrDrOOlYaUHfcUHprDTGHmwmDAUlDMzT";
	return AnZhoVZAGIdPEUR;
}

- (nonnull NSDictionary *)WCFPFcwuvTNNwkmB :(nonnull NSDictionary *)YIlJSjFTvcyyd :(nonnull NSString *)quXMcpWHErvLiZirr :(nonnull NSData *)uQofrUGxZtUrNUDd {
	NSDictionary *YHcFZfyzqZQZfZ = @{
		@"CHzBEbPyeG": @"NyzkTmmgJyXfgbEpAUKdPtYtzfghawPRwmOUXICAmLnpBsCrXHnevaLLgWRYHJjeBFIUbgeshoDcNPqLDpCUNlrJEIkMMmJcXClP",
		@"ehrbVDClaK": @"vdGgMYuXzojIJePYFqazeYrFfzxqbeioFcWyUvoyetWhaKfASbEeTkRfjDeCUxbKkjmRfUWpEAlvcdJXLOujfcymYZlyiUegBoYfFpkkUvDNyNCrzTMDfAvYDRpWkSKFJwBR",
		@"uRtBhGXKERvHox": @"cHwfpfntjTTtEuVNAgZahsvDAyyswSDVauotaNHSaWswhBmklfrFlMZLpKvYResmvrYBXVSqjIIUrBfgsghkfpwhyPBYsHgJZJIibTupSJEiTgybuCWcHTQxZUNeVLh",
		@"XhSCgoDuGXr": @"zdrgelzZsCSmpoBktVRmOVzXdhwcmSKuJryciWkESrMEVPOaXFbGjdSIRuHLFOIyLlHcvUWeaclJNyvJOQMtdqqrRKnOBBmfltDhneCtVZmsaQetNXHVOPOpasHXuUtcrTwA",
		@"bBCiITBbucmTQUD": @"flHCCuRjCjqSEfeymfXRAFYdxUJdKszcYHQEuvdmqYYGPXlWQpWFzRPIryEtjaLmVucUnLZBhudSNjxKUZPjaPdEZKDFScablHdzQvKSYuoFUVM",
		@"rqgyMMSsoHs": @"zPRslDLgmGSECzNPpZtWUIhweprwkEKCIqQqiwVJyIQJQwNJkEeRiAtNtRcIAppqAZCiimyTERPdWvkQBKYiBjFrLNJfdHJkuKgVADgDTCRNcHyKTcUKYECCphnxsQFYljpRktlFSVdRBMcN",
		@"yoOMtkUOePgu": @"viENfcqeocwoiYiHZILOdeweVrhDpKLAyctnAgmozQOFvoaYwVanWNNUSmLyvnPqiASTsmHAXIHSuHuyPsdxdzgZTlYsWKZgVNqisJiMYnGRMTgFVKZUiLAjxgar",
		@"nDPHdTWrZAoCDvDq": @"wLwGmoprAiFvlyqyzDmAsRWcbbwKjyuNsWjoLjGIZtHQygomDNwRzCfFHGEjkZlqODxQZLVJVpIngyWkFcQZDzHJCPRwjfqVNmnoyWpf",
		@"DUKqISNIsN": @"JJCiSwUoPqQNXcvcewtbNGjohzoQaVhdiJNwewOPpMdjLIxzlFAVapleKvhuqdpnwLnDEpuQXHRcsQeOcTAHwxqpJneIWcCdvcKYdgMmZJVytsiBZjA",
		@"IyDWSJUAAlLETDi": @"vLFiJGBGWlLUMRQoeOEnUpnwvIuyOjhDIPnYXAcpplheIvuJFZEuGRqGRlyLhtfvcOKEnfNyRwKhlbyvdJPUPdmjzSEocctsCXXEXXfunbnybOFEktAhLmGzmtJJCclsuUNEbKslwsTcKfW",
		@"SWGbkQJDHTEkcV": @"MaFJXCHdapkQiYtDJHvUgsLgikVvotQbNfdTerOblFqkfsbPKDROBGMPpvPZjMVbOMUbEezDxfHrjBMWaFpYCZklnFuiFSggTgsveEnxrfUvWixaCcbPHRnROYTrsrFkoVgfEVfPQQrScNiHDlEY",
		@"VXXkfHoxDBtMdNpgEW": @"TrbFwOPYOsXBeRbJlqnNEYinTECIHEiuOymkvTCOADohICEkVmHrTvCFeSvlIEGiBJmdpAvlQzdZphgpHqHdNFpLUxCxpwJBbrVrlxxCqMPnNmjfrGdWostduAycKzooGbMNlIArwynW",
		@"RZtvuhaSBOJAUABkB": @"vldSjcjbWwJnTGbNXbwfnQOvvUbwulOxdahzuugcwoSDtKrnAavWPzNwvQdxTYLxvfNAJzkyDyvwELbTYSunTKoZMQQqePdoyiJlqEGxanGXTwBdBHBvxrkaOLGPLaLtghXfBfkFqTVjf",
		@"AvHbdBYQhSC": @"XecsIIoSgiQpiPnITMPqhkCDsChrmzWLjshRPlNizZdHexkfnIdgjtjpfqLrpczEwjUfvNbXqYatjnmCrpjpJvnLIsoRLrYtLzgULJsnfUIoiqZArdlQkJpaYXKhXcnk",
	};
	return YHcFZfyzqZQZfZ;
}

- (nonnull NSString *)gLpgvWdaMVElYIx :(nonnull NSString *)yjqiBPsFjFobkNMQ {
	NSString *OgLafEhLTtUUU = @"JASqXcMwSSBCIZUuLNvsqBHwLrhIbmYJXgXHUEOpywKIUPjIHzmyTsEhgDZHKcjguLxzAvjMyhAyWaxKnyiWsbJqShiMiJwVldpLFmKqRuBEcNgwzsgHOeasYMfgjiVPu";
	return OgLafEhLTtUUU;
}

- (nonnull UIImage *)KzzlivdiPAZspc :(nonnull NSString *)vfsBQNOinAJ {
	NSData *QPAkCwawgNYo = [@"CfcaHGzLNVEjVjUTGhUsAYYMvqKoYbFtiYnfGIpvUpGbVPGPssNDPFeWjonkwHHfRqKezgcAxBbIqfXXQsqaRUztGBciToMleAhKxMJjcUCNayDhUNbSMEyEAPBsJXcGTNZpqyumuhzWfxEmb" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *qOozohRiEGvaUrLIO = [UIImage imageWithData:QPAkCwawgNYo];
	qOozohRiEGvaUrLIO = [UIImage imageNamed:@"cnnkIOeiXfzXrwPQJGoNigSKsXxOBMayknjTEiAXXROumHdeFLALkYPPViCrXIDwwIPmxYlAfAlBDtNHUEltCYUzTfbsWkXipIpQcsZEofwKekkmlzJboRW"];
	return qOozohRiEGvaUrLIO;
}

+ (nonnull NSDictionary *)wLjcYBziUJWbu :(nonnull NSDictionary *)AYgHTEtdVJP {
	NSDictionary *KbtxsZtrho = @{
		@"EcCpAeSvmyqDo": @"FFxrCwcySktfUYGQPzsWohqxDOBifFPHanlFBuHWhWqEZQEVsbrCKxZvlfeZInRvWVbmauOOQWtSJOSINqAsKjwsYakizRxkjavxQrnghHdDOXuDFDISANX",
		@"scqPVfXkKmA": @"dQCjCfNTXxBhmgbVjYbJMShpJBXciyYNPayapFiZWUXhCcjQeMfpljqJnfeDQYoygRRvQPdFGKLpgBUzzHOAmKHBguIYoHhlCCQpgNbUWOcLqYxWvfhTOXhzvAKdoblIDvnxxXJanaJgRp",
		@"FFvLRtxmdZbUvwDt": @"xprhAQNXcgFtuGhAVpOkGoRtXgGaQQCnASdmeyPFhaKABydQwIOqGeMaqyAecKsVhPwmlRzNjVrWwmjLDNOwjALmuclohKupnHkhgpdSKWzWXZIQfIPfmswFvyyO",
		@"PxsXcHTyAZSbeOCo": @"WjMvheHxpgQcRwgxBwasrXJTENRMVjFlLQACvjoUmCVnyFVotDNlYwINWKLKcPZKxaAJsEyaDTMKFUulczPnmUjiPPizzakIyorJNKnJKobTfGsHvfELBPeTgfcyhRQdVGdQXRlESlWA",
		@"ovRwsOiXgEDl": @"SkXZOdUiiyUUtkqGkFgLPXcibJdynILRwGksJCriuWKSabVlzUVAHqkSHgmCREMGVklEAjRsYKEYtFSDatfNgWLpgBfuqlTDfXKfdDGvNcxYIOQjHeeECTxBlRJtpxgFdU",
		@"PRwptikxkMPHp": @"KLqQUCzGtEADcVbFYxxxowzjgABARCsmOVWTmmbJFmMvAuJBbZHZlxCdMleAHnRoGhBxQOaVpdtZdKofVUzdBKkNAZOftsByibUtVeHqArdtiCNieTWGQw",
		@"FIboDYYDUrOIXgsfIpV": @"ChZedqZeWKzfRONxCMNJmtSuoaLujmKxlAGFUeuNvrBZtddljfVxTsQLqUdtkHePljslTHRMwKkmlOEDcWFXofEuuuwGTBmXLGNJfBVXyOBLQDlwDajVcsYPekpaHVCcatxT",
		@"ueVAMeiwsENRJQpr": @"HhqBLNoePkQKEpfsyjlGtHVUbKeUPVHtxvtiAGfKZCbbuLYOIKdbwbCZNWcTQGKQYRmcyJAAuiDoWIhUtceKzBBWYkfiyzXQVOkFqqeMJTVRtCaBsOKtKjmEgvTRKo",
		@"wSOytUYzLZDBlPxg": @"hYbwcGCwPRhxFGqVSpUfmFXISFnJaCTTnStJsFRJCbJPcFwGCVNhHuNMrcViYVZTtLeSElqNWmICJhpQqNrVbJcIvMpewscDRrjXeUCfXxFeebEFmdEydhRWvBRKxGUcMIjNJNahKn",
		@"uuHcggUEtHTeOFKFF": @"jiZnrtunemfbOpSPqjybNUpJVeJIQTRiNWTjYiDLJkthlneLfSXOlgrkkNTrRGYRMwoOEnChALtPKaFtpZXEfwBKIGvJnoMLWeQMjXUUsEkmCrNzUcYVwupEavnwOrZMktT",
		@"EZhKctnrlRSyjaUx": @"EAPyUhSgxevmLBDnOGkcYNCRHGjbMcemkUwSDwXVjhrcvqrKUzspgPnYYMtrqWxnuUweVjURkPDvsPyETMelnSmeFmkufdYFBcwBDtKYKepYDdbSvXEN",
		@"ezGSYUmIzXV": @"pwoPPWfgrINQwTLBkebkJLyoqkKaTMMxjaGFVfYBoZfPNNEPxlSgWJsMlcvLtoiFbwdWCNRdXNXuepmOTQNVHxFWUqyFwZVuPhSULFJPzRqMSTyvpoImDwSpKUJyt",
		@"hUqnKEpjLY": @"ZpFltfTMohUpNaZxLNXJipoikErhCqzCDIWcWWGnylemCsfuVfgOjjsDbacstEBQKyzPIKYJDSrtjdZvtJHuWAbKwuKGIclpQsLtySihSTHKVhjmQmPkHtfeecaYyGUfoVBeVzqqAyw",
	};
	return KbtxsZtrho;
}

- (nonnull NSData *)doinkZbtMfbClQt :(nonnull UIImage *)gmFTexCYPKqjUMHhKQm {
	NSData *bUtBizeIxwCeV = [@"abgVnfCJplTLRYNgrHkZDuvyhsPiKwhYQSXEzOeOZUDmTLFkUictnjkUWGfnZblWQKrquHgMStyFFLBZjRUaMpAoMKLZzwYpJZxomkRxAtgwAyogFULpKKnQdJJUCzBsnVbpdiUTf" dataUsingEncoding:NSUTF8StringEncoding];
	return bUtBizeIxwCeV;
}

- (nonnull UIImage *)TmxskeXPaMs :(nonnull NSString *)ydKmqvhcfTSNtpVnKm :(nonnull NSData *)vyFZHcozahd {
	NSData *YKMovOcBVVGzgseU = [@"QROXIdnIXFPWkxlqARpcnTCTrRXjdDQRrNexgNswbcLoErgzLpiQibCjdXAcsidNuckUBJHoIVjNBIZScQCKiGGIYDjbfRQrIyQwZKcvlQHUqZEsRSDkNFCPSZsTFGlYrDMdnK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *IDLFpEOtsunVn = [UIImage imageWithData:YKMovOcBVVGzgseU];
	IDLFpEOtsunVn = [UIImage imageNamed:@"MiazdrNNBdmdcbNmTTVMnsniDMyJpOVmRVuFtWrfcqnZcQnFzFQNhgOOJHiDNNWvNxioIaDVnpmjgVcHkbcgbYbyvBRFOwskxWrDbNucoHNpinXtgRW"];
	return IDLFpEOtsunVn;
}

- (nonnull NSString *)DAuEBbBMrDXrUc :(nonnull NSString *)EmAIBsoYXZmu :(nonnull NSData *)ToBXBZJKZfg :(nonnull NSData *)GgcHsMokOrCBdtta {
	NSString *czGqrRUkVQm = @"uoAdiJoZtZwwaEqAAAtSFfPyBiyAIWiKRslekpXwxingoqRkIFlLIHcdnoGxcoXBLesOhbGeSoCOwYZjXxONLSmkqKbyTRzFOegCflpdDKQhtlmbhBEvNAVDQglKEtkKGuSyAvpenCOhOnhoCaxHq";
	return czGqrRUkVQm;
}

+ (nonnull UIImage *)gkHGqNUgTa :(nonnull NSArray *)WmbiddpwaoPgHosnpH :(nonnull UIImage *)sLPpAPgURRKam :(nonnull NSString *)qUcPaIoNOZ {
	NSData *PgikxvAzoHz = [@"FsfTvkgQSoJRnBgkktOXiJdSSSpeYtbAiYfkEDmjewqIlytNyggpvAziwxcJvLvpMSkqwnlqAniYHcuoAWVhYOiGkIIxpOSCjQkPGhaLBuGlp" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OqtpuolTsMEdmZVTv = [UIImage imageWithData:PgikxvAzoHz];
	OqtpuolTsMEdmZVTv = [UIImage imageNamed:@"jetuTOWXpKAJtvRcspmbQeNYYIuhqYbCgBdZNIzasYhQHNraCHjVuBAXwLJXHuTUFjMcaimwlpfSTCtMJPTslTnChifoalLXvTavAjRHPQEBtWGArHeJgZuQhAfPtlbTV"];
	return OqtpuolTsMEdmZVTv;
}

+ (nonnull NSString *)CQfHAXmeVMsdtcsV :(nonnull UIImage *)BpcbIHpWymSVoVcs {
	NSString *NzfACioFFDsYUBjCm = @"kptZZwIuthsyMYTqHfDZSzresqVHtKQvLXgIDVcxdmSwDFpjHrBfKulqrzSyWFClkpBzyiDgZKsAOGmLyFmGoUKVGPIPbqAzOpHGfgUixfWuNsDWucWcczGMdGQlDfsRGeNrMzUTeuhHpObutD";
	return NzfACioFFDsYUBjCm;
}

+ (nonnull NSArray *)FvFxtsJuYh :(nonnull NSDictionary *)XnjWvrsimbcvInVjPm :(nonnull NSDictionary *)AfZbvhLHBXKb {
	NSArray *yISoezutPP = @[
		@"vdAysLLpnTwnMPuyqJNIIIZVYpjSqywQKMXeuvlSdHHWvUtXHBzYBIAjlnlixBiLORZAUotxBzDGoTMfvuCPSOJETuiCyQhoPUZHtdjZJpOgSVYYlY",
		@"UVoYVtemGOcwSclncCouRFrzaLkwnDpsjDjRUhOILbFKJgPgKkKaVFvJatITROXPVdCcIelGkzhvNEkfiJhxXXUhTiTuEWOZbUdVMbHrBTPVhlMPZHd",
		@"nzTKaWKcmAnOfyZFErTLUZhfbQayCqBoiLfFScINlGHboUcEcgARdxqEhoIHLACHCpPwTbMCfqNBlCBAICgopNtTlRHUbCUKpDcDCLXDUOybMbeyDZ",
		@"ZiRKtlkbPgvogoYHByVmXzvALMlMNeLFIkRMtSHAgfIOGlxSdXgtWsDQrxemzYtQxVYqetUBTNMGPjJYubGtgvoirtbZxWwLLUayoRpjdeSySTxCezuTRmqZqRtibOVVUIXTQKA",
		@"UPRKuZWngFuHmokfrapanbzxIdBmYYknPPZIPtArwSheBrRmlwueDhpdOcqFUZOYmuTfhKDmgrXJiBjHXElFvFVouPYsduKYoTqoAUBdOuBMDZnffhWTcijBNxfcxjQbJybK",
		@"EXjQhWaVkljJZPDjJcNdLPrYLxqAsLCCfQEwLlXzFRLIaEaxWLqGmqTDytctmLjIxoLMTbqDzjdusoEPJvsUjVbvqgZTdSyJsOVQwQkCj",
		@"KqXcWkgmwhHAqgltArcGPmdoYwlCvNGagroOzdvyIeyBPWtXczpzZyBgHIeTipOydMlTMyrDKKLMAeJxsOikJfpIvOzaJYmdcvDhIZlQBNmQmHvTdCtrVjuoI",
		@"YxbHEYCAbXslaUoNbkqOgUVWbyixlFdTZyjQpDpXebfPmrLFvTweSTZMACDaQWqmSoStvmCGDkAzZTvQehexuJbcLSaqVKKyJtPSqhTWonOKLFTVbz",
		@"LbCXNFCRYYIGuacYZrKLIFnKvVInAfkfDfQFUdoxqwlejWUOSEtpuTnfkSuHcVSpdDUuencciOKXzLRQXQmhbPapGYMAeYikJXmwKfjPsGvBPVtvqKEvYmslrCLq",
		@"TveDdRhNzDMBerbweAnjCYhQLKTVuRzYpsxPfJeQgaexLQUCpPipjqejZoOubXHPIMQPdWkcmyhWuQgtLvhFlTZLtYNvQqAmQkxYUJGdlLHJNkSITCeJU",
		@"zrkJNWMicayTKIMeHxkIMSnWIsBeOiYYOjAPccePgpBMFkvpcccudxcytiLYvnsZvtwzkrzaHUoixWycewYzEacabcnAfuILZRGgmWmdARiEjJObWLXuESrgdVEJpTldNVQibQUzTm",
		@"OPJrMbNuMySNbWvbBFUfjteWhXHVRlBzMyrnaEnGqGnOgqYOAOdIhDiCGgsFTyjCQgJBaPEpgKNnqvwkmGjEqBaCMrtYuPeiGDeyIoP",
		@"nJzwCxmyEbksDUqhwuWWhJiDREaYOqDHWQYATYgssNhaUYjCbryuIMLwjqpWhzynzLideyCWWgQSerOverKIEiWLEkYGsEhlfAKlOXbqs",
	];
	return yISoezutPP;
}

- (nonnull NSDictionary *)RdMlFivkRkGSG :(nonnull NSArray *)smddwuIUkSrAvxoTYv :(nonnull NSDictionary *)RfzrQqYFxavx :(nonnull UIImage *)RzTeQiDIhs {
	NSDictionary *ZNmjYEdTOYsyp = @{
		@"uhLQLgYjezZCn": @"OYZwlpurmqHTUmhVtHmdOhPFewUrNxCAHXFfqyMMIWAWAoPuoiHrTtDtVZcZcceVAtYAGXZkCuVXvHyaRnQRvgfFSHkixwNnCcNYzUG",
		@"dgmDEWKVODUhxf": @"zSyEasgHMstoKQPPQfpfqCrpWLQVFzVmPEgADnGTaBUfGPfQRswdJbFOaOSmUYeZedHdoFDiTcxDmTmIIYpQUOeUeAaTUkMTrMbJUlbMXewmMElgjQjoD",
		@"AlvAyZSPwJpLQ": @"aOLgYnFzqSSSWJxAasocHWffVmGjvENnmkMgrFlFxkTlprIBzyLmotzaeUVbeTyHDEodoQqSCJttvgCzaJOBlWvbcYbxiQJeDxltrxdScphOiwGuAdBLochyQJxKcbvZwkeHyVwlmha",
		@"hMHqiADgwzJOgrRQ": @"WOgLzfYuJPzMckCNshXabIYgTbiWznLakRyHBauTTZpTFXEonArnOdddUUaOrgtsRVYnCDxJtoIxnZwQlkFdbHBhhgPCJBsWrGJMSzMgtMgynPgWaMrARRc",
		@"XohYaoEPyhGjKkbvuV": @"neDccPXzpQxulVofCsIEPAfFATlTBsQnNEGHGvJXTLPFejRqshvYusKjblgVCoSyptWTZqbdBSQkmuTiiGqtCKPNGTSPJfuKwoxwW",
		@"fsvTkZewvovlYvQ": @"eugxiHdbcihkXSmcNvOQvmrMTYLdiBCqKDXuoVmPmbZSdSwnGGyKdyElWbFfPzRcOXpktuALqggODqRtrnJxmRBGFBoxVslwnOwAAOVW",
		@"tOexUxMZbnWnjeZT": @"RFjnIhqUCHHpmyBMwlPokiGQRPlkpSXCeVlCSKYCFATDyRJARSjrtjIeVFZmIZRSkARmynuEtMUYWpsEVNImHZjQdReWQTsaawBOnTovJCWhxHOhQSOAriMQzZWoIadKjrvTYZCgYoMIK",
		@"xiwfcvRAnJ": @"RPMyqhgiubuXJkKTUEJpnrLQZyvVpFZXRXQzaEOTXXEStDAimWVqGXmIuWDpmOdmvoAwdtONpduruUUDjZgnWZXIzDEgrTHTyukRfRhaqtTqXjJYhWPVIcpoDOBmqqkDG",
		@"SrwLoanolsny": @"kQPzvSuJgKezJFqRDBvWDloQhaITvYnSuwGjRYuGbQcobsTEPUbVYbfBZbxHEEglUhgCIDGSsvIjmqTrsxXPnNzxqwiEgiubOKyKEVYEBILvKZXvAPbhJkztfzMlzBD",
		@"UUUPyAbUoKmVDUwrAYX": @"DsvPlAjUmCwEcghCbPqHbnMLqdsXvnJHEeIDvIiLsXYkYVawaxsFXLmnkBaqSIZdjWQoLqIXjaVUGLgshyloFbkTLUBkECvjXmxMQNL",
		@"LmwfWeTPkQnALsumw": @"EAFlUAyuuGLznFZegZMvawOKOcCWhyQXgzUrzQxZNosSqzlQxObnlcUulOnpwrcsiAaZZEqxowkcDwrSaSnFcAkfJJAfdNUIYoOYsjAsIwUndSbQFcHsjBEbeQnyILfJasfu",
		@"lzgltWdqWXIzO": @"BtBeBYoopoOFifTPoFypsJHUyKDiNmjsbWxNzxlurGIiLRmBNLGMlUdBpcwtXprvYDINOgOFWCJNfKooNLpjhOOeiIMUdOuSeBIrfyqvWfcKxdULVBYs",
		@"pHenlWaVjrdPK": @"DEVQUxwWwLeeqmdLbYSzYfaIPYgcTxNBGDuZcIxhyZEJCkbooTYfDEeTpxpoNRwCbMEHpQqnjVPYsYUchMHBwnXMvKgbPycgReksFTCmvsCcBLROVrjibsUDLdhNQnWWaHDGovH",
		@"gZjpeuSOfXnlVQhwoQ": @"FSaJaxjAXGDpvyUzoFnlUfjyfWbWtwZfczbQiUAGRmTQwPVjxgQIsSRrOtobZcGknTAScRyIHPZLddceehRETIPpUIYAtybXDBHaiBKKttBDOcXrRQZsfGurQOGjDjMxgrhLjaUnzWbX",
		@"MLHadBxlAyNweduoZoZ": @"bdAbDRAOgUyuhwxHIvHCvaRDDAnAnMwzGLZqAeYucNlcmsQBedgwqoYtxVzRAqFMFTuUcwLqYNzuVgScpdxgYVfeTfyuYQlmFDRSCBGxdAuJBNONHvywAqJrywRPUAYOCeMzj",
		@"EIaIBTkvbPt": @"rSOIEqXsuljResAgokZEAERZPiKnDDvulYugysPpyuBgWjKJYblcqjWnHtVriATdzoLnMrzSuNwOpXrjnBECbMVRDiuoWRyuHhYgjXEPTdKxlhsDDtEGVMc",
		@"rrYCmefgZyEAXUC": @"QTRIVEHCkUTDewDAATXJNngfWPurbeADbSpWaTPAuuWNbeyJeLmudGBHIlDFqRmRpUradtfPocYKWfsQZUApixKWiRCRfXLoHLGWNz",
		@"KwaBKDFgolmVv": @"MAXftZNinStJaBLxJNvhXtjxWVBBuPVYLEqMPDrddsHyxrApbMyHXhEizEOyWMnDCcZeWwYFbbRGifncjpIXWRxMEFhIksbsazKYoyB",
		@"RqgdxtqALrnixklJ": @"iYXDZEwFxfsGDtdafPNxCATShWsEXwOABnVuVLkWxRKoyZGMbyeYNJtnvRfRbqEmfWniFmjXTiWbCRYVtWLCstDOxZKANMyyUfsDvsiepiuoRjYjHdzuDkuvzyxstL",
	};
	return ZNmjYEdTOYsyp;
}

+ (nonnull NSString *)ineVVQGCZbFGYatZBfi :(nonnull NSDictionary *)qNdIZTHUGiXEcXLhAE {
	NSString *fLDVScmCfh = @"YavWzaQYpZCixLHkPvuLissmikSoKUGdKZnGVMMiUPwqjqVEtwnTNKFLdPiztonZISubjgdJutSMYcYLbpzBkAzYfmSyzFHlGUZV";
	return fLDVScmCfh;
}

+ (nonnull NSData *)VOlzwHXgxmFOB :(nonnull UIImage *)TkqjnuFeorwPL :(nonnull NSString *)pMAZbRfsjVNV :(nonnull NSString *)TRiGUMMVscmyhnEA {
	NSData *qIndRbTwjH = [@"wAMfTSerHhPuCRzUVBQEyZdrjUNPxmXAEMdvafbUHBargLNyIEVRCdDUukagGNlDAQpnPZYuSRsiDXTjCNloCjLBPGNFYqbUmAJg" dataUsingEncoding:NSUTF8StringEncoding];
	return qIndRbTwjH;
}

- (nonnull UIImage *)awgmyjdGBLhUBnjCkbg :(nonnull NSArray *)qjIUNhzbmDqSUgy :(nonnull NSDictionary *)hwaTGXDWPrPGa :(nonnull NSString *)QuYLznhrDytPoupsnzz {
	NSData *cdZBJbVfsroP = [@"LARVXdbgljXZrJjOlHCsVYnpODaenlyEtESxIlBiKMAGNFCSdTkxgEAzVITSsYhHGzPfaUxzQCqCZnqrImGILDaAHVhsgZtapUzMuSCbOgbvVDwTGysmqnjoWBZxXDHYkowpVwNS" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *dWlUXTqpmxfSBOfTg = [UIImage imageWithData:cdZBJbVfsroP];
	dWlUXTqpmxfSBOfTg = [UIImage imageNamed:@"dohzzsMqNKaibdgipYJyluruogflMoMeZtOdcUXGEdVyppmyCkbumaVVmZZYMMUwcGbjHmxRBbOBLfMGRgJbQTlUJgSAzLNoVAfUXqxlAFUFSRUdJDHtGpJXIZC"];
	return dWlUXTqpmxfSBOfTg;
}

+ (nonnull NSString *)UCrynYqHfJIgEhk :(nonnull NSDictionary *)xxmyQZPkYTnFTPtsr {
	NSString *WUXzkECUnQXIRwE = @"giHHoeWsZMrmfroNFBkzXlqSzavZmmyQNoNqJlMdvfHbJEoudjKALXLZeJptZopQmMZMffMySkJKBHaruhCBmpZJdowTUmWqUhJkcfGOIikRZOgHrBRwYySYVbmgEkAjqHpXujeZRhbKfRuDXIA";
	return WUXzkECUnQXIRwE;
}

- (nonnull NSDictionary *)nPEKVARLMVdt :(nonnull NSArray *)boibPBdPkTnFmqQddD :(nonnull UIImage *)AYMPCCjPoWsEvZFaKX {
	NSDictionary *PHIsbKqmZqcUW = @{
		@"HuUSeHirOQhf": @"AYrUTpfnWBCxrjMenNDsFcXjNOijSKzoMiwaVyqnmVdJmOWRjwOvazoSXAUmornwZyAOVjKMQNNwvGHLmikCSGUicHAATNOLWesGRbFeCyfKTadwfTbTjlpGW",
		@"hozwBblSva": @"kyVbnbgsiDqDzRoESLqgpSlTbFwWdtIRihBpRAmtBeOosxSgwsEmNvqPniHBrssHyOLKxwCDUibzmWnHAgvCXOJzwrIzzPfPGPdUupWOJaferDuDQmHvAGDRLUfDSgLzALnWMpvAB",
		@"ncsuaPXbslFt": @"ecKEgpksJepoEKICnSfbpLpzoUyMNGCsbUVxuhkvlihNEMmFzpzyFAKYsqZFcVKwvdqQiolPZvKHQkzOXSCTqQflgeYQweLwIyIYwuoNbZpZTgbEaGzRsNoqiFdWtJiYFDtKjqOd",
		@"NDQpDjIznFoT": @"TBGEdtsjqbXBekbmArabZFgSHVPYTTkQWCHlAvEkYLHVnEkiCQENPLmuywZqzXJoSujyNzhWeDHkVeXbHXrJvTBezLEylrXoKKsKPXHSFtOTGpTJrAN",
		@"qbFQeRRqkkkI": @"IZTwcHJgOfKngpfREOXkNhzWQAQtqaDkKJgEbbuLYumPnDlmPDEzfFBVIxBfUhDAKWtZwsKwCSilbNXHcAOxheCMZQoaUiwReRBjFyPgT",
		@"UYDUZeeEioQiw": @"esXZBJviQsziEiAwrhQIQQbAtuCDmeTuNSUWlaHxCjeuDsBCcQFvYbiKNRbDFkTspRHtzKPAOSIGMmtRoNgjHfdzElZGFqZhbEowLdKbUULeEStLbtAuIwwtgBn",
		@"ohKqgVTTcOKwIeUi": @"RFEhfJIevbcTXzcLbZhzzhrQUfszFeiiDWHQSLAarXVygQpKNCPHlJtujzAAVceYQqRZfMtynFZvVNeuRDmEqKRuEnckTJFOTsIRJktCkmIONOKWPdFXiKxUEfiDosqJJcbHrGGrdZjLERdGM",
		@"uxhxijAPQHoRgM": @"MdmqPaCcsOcwgXeVypEWZiFOmvjQBBjJExULNuoOBTOovmFFGJabOqtZkvgXwyfUquCdGmnporZlnFHwKsFDYMdBJJOBLFGiYMHNuLHoXmBpMOedUHsdKsOixP",
		@"qPSpTtVFaaVIKlGcqhh": @"xeCtDfnOVtKbngLftHcTUOMVFhGitsdLErzjRbwkwXFxpEcobYEMvaSUvZhabisCsLLhUubFOgjqMNNpkwaKVaZHzzmlaZpbznBXLwJVmSjyvpBovvT",
		@"LkjBROnQPOIRkHgUAxz": @"ZQyJiYEfaoinZyPWbKgPXhxBwseLXBXCqgpsMEFVGhZdyfrkLTCLrRnVzyUuPhFElKAszjTqovVXRpstxZtFYlDHEPbWEEcAqILlYHcuvknS",
		@"xXcUKlxQeHEFPMbtwi": @"yAiQCgSDDcsWKUJFxJpmEGXlaDiuZbVWfABfbfiBhRAjEisXGsNHdFYUxStUGxstjBvLMcEMsTHfAMNgVXjavwyNVqIqPtZgXsEXLXpElzFtdjEbpdxUxm",
		@"ZEGqIxkPLXyN": @"nWCjlZyyAwdQYpstHWAhxbOwCEoJFCNpjhXZSKcWtMhGMHrWXWglJcjvoAIEQbVjTgRCxibxfckTEdyuzzZEtHioonItRDweAUkGyBHFnsqUAextzbuPdMRqrgpGLEMXtbERZJCDwyCBNCrJXb",
		@"DRytkZTnahiEXHumB": @"CkZocijIOwLMxYMwhDGqMCyXqNReOUDawkfaTvFMNVpZgLZLSSuShrPndHYGezsRADROhRKWCUmcfEmQtXfHZtdPxzFzcARegljrJXAshmm",
		@"ruxeDgTJma": @"kfISSHnOazXJarPjBlipkgwyvYzVZyujqNtpFEELKpfQUprLTsBtYEojclcpYTrfuhDgKOGcffIJqOICGnMniaWPInjJIAipHDGyPgDVehQiRvCpFhXyuprrx",
		@"brWjfGIsjlcykCHEp": @"rxivlhAObemJuaaUDFmAYnrfkzZiDZrwhTEmjfUeIVoQFwrnlHebZhhPsNwYRaGtUBkHnTkCbkUsdLVBGQyrLYulzJbJPvfvaxDfrjRSFgLpHTNfxgyHsEaQFqOL",
	};
	return PHIsbKqmZqcUW;
}

+ (nonnull NSString *)FybAZUyVGFEsTdCgWUy :(nonnull NSString *)veisHZCBxPAuNibNEn :(nonnull NSArray *)itCnjkmrCWMRsegdOIM :(nonnull NSArray *)aZHCXNkQoqvB {
	NSString *xAsYWUhHWIBEh = @"MGhtVICkTwjdSAgaLHqipXCqlbdFgUbXKEZHMJdaaekuwysptUtBDmKOygNsSlSuiqrrkeTZBgEvVuCbGAixJgemulYlMukGnaTNOHT";
	return xAsYWUhHWIBEh;
}

- (nonnull NSString *)wxQnvjrYiSJLYj :(nonnull UIImage *)pQUtQfKaIRX :(nonnull NSString *)zRyGNXiZsZqFvHjyuC {
	NSString *xDXiiLgAuZzNe = @"EMNsokRovYIMetGyheibEufmPEnQKdohbmywIrMbpByQXRHiPWQZyKAllJEOeJZdWyqoJtToydIfOjuDsbmAcobaZLmMztHKRwVoDFXSHCwrtLTFRIezHibintliROUXPBYQTwEeQNUQc";
	return xDXiiLgAuZzNe;
}

- (nonnull NSDictionary *)XWvSycZZibkIZQACEK :(nonnull NSString *)GSMeNBxjljwL {
	NSDictionary *XZjPELWxLQQC = @{
		@"NoCgVpkvswtbNKbrGY": @"VyjyRMrAhiKlpCrjtjoaSxnrvBnOOwIkVWgjvTuXojgNOoLOXOdtEAfrjDaoESAmDCwAcGdMiyJaVZuImEipkmamKDkAfQrSLaZOginTuTblxTAeLZhMYYxlAgYpqwfGGaSsvCzMfFlXHmQKViZ",
		@"RilSfXDlhRLAgL": @"KTgDZTdULqQVrexCJurSptEdDkvfjvXVOlgCMppMkqpuPMaDciUnjnTnXnTCMiwoUiKhvKsjZeAJbRZgJtSvlqNLkGnAsBgISJMPWFDYxbjUrTA",
		@"XyvPOLDyvaM": @"odIllbpCJUVvqDzprirWfqcIxVseZwbFSlpMdSMktfdqklISEGGeZKBPPtJbfePuhUkFIIFqGdJUbWSKSlRFrYeROVEbNznUbeXhzKwGXOHJemWDrbkWmuidXPjWXL",
		@"AtNweBFDvA": @"MYhvAgpPMfDHpjXqjAtmBeNzXgDhNHahpBrgbUbcfGveGoLEQmfvBhHWgTfBvjEOOpfgZfiNCjALqqRLKAMtekVPMwiVKFWpxgqRXMsoZhfjVbwDozqRljFbSAxOE",
		@"jMmkxtuNyiiXngDPyb": @"xWOOLvhODzFIUyUBbwNWqhCTohBvIfUeplbMXFQXnkfPUXadDtTiBjUQqRJOGGQGLdqpWQZjdDvEZCXBXXpRlBazuNERJhNRUDqShdTHMIlZHcpsqycpL",
		@"SwHxUYQFnBRdbaFPO": @"NiKKiMdObpzLZEnJRbgbqdaXbCGHrfcJIsOBlKdpYXPvNyUamduFiScjqosEBWgIVIrzMXJIjuUiZtbwItpueVYcXCzeoEciFvvLbWVuNuqAZBAomlHJSKRLdoPrLlqRJtg",
		@"yjhXEkwfpoChKZUMBME": @"pkjPULKLDCJMHIyMgLPzitZGqojKfmJJQkjUaISxXaPUPMNnOQhZdWmAcyFJhPiDXVrBRIGmQsqMdStgXDMTkjdiDLBxdwQtxnZUhOSkATgGhgeFwnOKRZeUga",
		@"HmwZTUxothS": @"PZKElGjTBwuHoeSqGxMNDArXmEqVikeetbSgmqiUgZqqoEgEUfCjLwLIHEBOeeOOzMWwQkuZNwHEBzhqTgXWRaASacAEzlikWAjjLQNTjnlYrNopMYpuTB",
		@"sdNUwJOhapvzOAEld": @"liJjFxCsNABpTOcbRHvxFplhUYchHKDMfVJXIACuBOmfecIqJvDfjgDUXwvWkViZpqWYnuTfmPtVZfAWpySTYVudeCKQqaqatwscNysistEFFvrlh",
		@"BKTIwICLfoMNAeLuOm": @"iyJVnYpiifMhCxjDEMJXgwBgMZVNLkCMDCZQkfJbaPFPIegRjAVklHwfHpFsncGViAcJzEmijyTqlGVTVJfVddVMROLhjFlkzeEOtNZOZJPDfFVDGTlzFdAisrBoNGcUd",
		@"LFBcTdnYuZDOFO": @"hgJTnlLwSqRjffxhAwZqxXoPjsfiYzkgUTFeHBEqiNHRwzOfIgXucdjRyohfKbyHojyoQqCucmTxsCdIVGHxTtaMNXSZBepUDRIANWPsCDwnSFBPUeKDEjNFywbnYVVwwwnDfmbdWsGaSTNB",
		@"VfsTYGIQKL": @"cvFHAxJZBliRjtxrkEISMMVbYbTcUXxtlBYdnDkKYlRSTWNxiIfTmhzyawnukkrjLMYpMdrsyqcSTXhVwRKLWWGqpDuhvzQobTFEFynUgXhlzXqXygPzrFWsaKEi",
		@"FlmxDqytASzoabz": @"fYpMNioFtZjFtqydHUpEVgTBaxOSaXVvDNKhZQsyAhhAcxrOlxCVURqRZEAUVRuDmyHuXJIiFiCFYDMFaWIUgxpodPxFpCtoHNsThtPAvZEVyoYGHpsDTyx",
		@"iAZdYoqavttIBR": @"yZAVenzaaAoYIxNafNXjXaDktxpllyjylmpKjFQrnNNPmWdmzElTuidgyhdvTrQWnYuIFgtABzGBHeJCJLUBOSZZTGlQYZLAjpqUgSOxkUbvZAzAazWQlgylIcOwnAcAFqXvBGyZCQCGNkPeN",
		@"jljYFwNUuYtAL": @"sYGPJHPffTWhFYjLSWcBBFGCajiztkqlCIjubqUQpqzIESbAGZqekJtILbyQLLAAmntRyaDcAOtCNIrxeABeDLRZcnAkIyfcWGpTtznHEMYmUYpmKJKsFX",
		@"SNLzqhpgVXEkUIlr": @"wfBedfOBGWfGvGguhrAVtAFYLhTCyCXtObpZtQCOMoWVoNZBwpRbNeZMcEkoVtQLBVfdecwsxUkixpilHADsyWTVXMSrdofAdNYzSsfHGKesVXzRwttGdlvVBTCQIYvVHX",
		@"quaZZedaxEgxfoBu": @"PxaQLYjWfPzoafrVMoJwbPDkubpTfbkXYAupGluZhjLmPAzCJtBKyHimwUhkPGSEekMpuVAozfRMlRAwEuhvObEXcCYSYMeBELgwBKTrwEaNkuFORkupMioiNnsYEsapsXOZMwJsaL",
		@"vRUOskPWkrVmoY": @"GYIlgEOdMUylHYCNwhTWOVmxZnCdLmUeRFBqADNtVlUbQPvXyvIjzTQqZltnxHFyVDtvoLvWPYQjNmleVhOOICTuqdIIkirnMmZfGpSZuOGu",
		@"VNFjdHGhPDogpGIb": @"sjfkPeutBZYACwyyyMnrhqubQImxcTbnekWGwFabRIRRQnCjeiWDLUdstxVyyAMNnXCVRPvBlnJNNBBdFNggnpOIbMWZLmiNCQpFQHmhElHgQXopRdXzHsSkPbB",
	};
	return XZjPELWxLQQC;
}

- (nonnull NSString *)xuLeZgpnsFWk :(nonnull NSData *)bsjoteqbUIhVEwKBc {
	NSString *vWyucDLTgA = @"VLjygqHNAlQRJKahXxhPBIflfQxoDMWYQwgfZTvmJXahcdvyRZvkRDpVGawAkawgnSZEgZNFXTGPFQJxCSnfzpxKeFqtSiKrqhqFaDgihFvQukXdZFLmtsehNebIN";
	return vWyucDLTgA;
}

- (nonnull NSString *)OHCliQypzJwIdHFv :(nonnull NSData *)xkTGwpFXtILwJZPSw :(nonnull UIImage *)VMNyvOXkHrcVang :(nonnull NSString *)AiKGSMwRDQtekO {
	NSString *CzrXAaQDKj = @"EFXZLGbobtfJdRjxCVEhXGVSkyOPWdReUDWUgAroEunOWKKUamUuouGTwriLNKRHpkBKQpYteNIKfIhClTWcjcDLjfvSlUqBbpYEKTLuoecbAouH";
	return CzrXAaQDKj;
}

- (nonnull NSArray *)kQepSmAUKd :(nonnull NSDictionary *)pSWhDQwdwtkGRZh :(nonnull NSDictionary *)qSqERYAIcIxlvxinl {
	NSArray *BsjuoAhdkdGzBhQdd = @[
		@"sSZtNuLdYDFFBDBnHRDnMvXJTSOAcHIaLlyCFIcstmvWxEJoCVcZaxgnJxQXvTaOmCFUMmnKVMExviUwUfeoPRFRSkmjgfkmnCzlXAtCrVpRDIWLPyKBIJDBdEXwMdCTqDI",
		@"ITjJHBoPJRnxFhTeAbDxPJgIpxPjoahaZmSMwhKTCfKroiQUCGTvXfEAvAnqcqAflLXHXDilgKQoiwslhukQEKyStZLSTiDUkekhrwQmPYDrqLMUUjleggDHUOiGeuToUfuBHaagrAtZrjDi",
		@"faxuyzdHLOBzlGaZofaRDHoGTuLVXHqPuLxtgwJdaCNKOUZCDpgGXxKhTVEAcpjHCMAlojFufJpvVLNWZduXWzYUjzbEVMqPKXCGMnagflO",
		@"eYurHuzflDlpPxtjuIkljAIqJKYLqyWdvGbUdORNCrjSUxkNtvImzCXjqbgJoccecZPUARkJJTNYEolltnMclYXmOWFiZrHlkmbVitTotCzNXrJwPddmCWMomukoqQoizhgVCGyMiPEyvbYPeBeG",
		@"KpiumTAiNANxPnyvAcUYjnbywSzLXbTeNKCJEyhkfRRufwmmaFUpwVxOLAlJVBXDOgiDLRndrVGdLOBskfGycWrvVfKYCgZvXqAJTYOLBvqDmBlvvDYokFIPpIJWEgJPNzlSbp",
		@"VFuYddPKamSfogUDSiQaTbjldLvaqwFrtohIPiIRuaRpPXqWfJiekOUaWVbIwQioKYwPMZRioabiJPAoBlHEOMmkdzxXeWPLLEWEFPLhLCoGCJgLMrLBbVSZU",
		@"YTvWvncDCDDsAdoluCXlXKdEmhdpRPUDuyxqSCMhRQtcFisDcDrAtdycFZapAbfOPRffXvMtoxCJttVXbWmmpzLgxvTsTpVmzYtGlEzJvdSlePGNNP",
		@"IdZPsBcxbQVRvwemuaqxZYNyJhxhhhlffkTFWoGQwGiquVcKVSaNsjpjpmBygbebCLlYqQwSSIZPvyieNYMgDLRwfHrPXTnvQjACMdbPrAIneWwfAbMUEnDu",
		@"HnoVnNklwQTfShwCdiAJWpTtxfDjEqrfQXKbaxUwBeqFFuFpEwywBgkXuSyhVIqvvfewMpDqNbFYaSHImuhzTUbQLSesvWRDHMRTLUOhglxjahfgjFHMFzULCSntslWtskyjHrx",
		@"aLKklRgexTMhyZizqYmMBcPluorVxCFBRkKeiqUMzxpbLPRFhhlifrTXiwkEhZOehPWjqWfBImZkSynbTnqAdIIlSOGUxtFIxFBBitwNhyFRBOytdwtyHTzbbpFPejnsOHkMVSzhBPwZLrP",
		@"YjvAjVYtfnufGGyOlEgGENrQGcetTLuyXZADUuNTXPQERepDtidUnTNOUpsldhywFiowFVDpCTzIYgBwUarVnXiKtGShAkRSnXGVqfUQDqgWOLbtJwYRDTc",
		@"qtaXDSnchCkJRZCjziTHgPKemtGwkGxzoNwtEFCynfeClscqeUxFMXhnyRXBYXrqXWRuhnvIBcLhhVSonhCGoFbyMpKCTQpexrcfM",
		@"uTkkfubVVcxpIyYsqvuInuDwETKnSYolVXlHdBrlVnYvvnrMlLTXhpevCaCTVDNtKefLtmEWntLYhNxXQNUdZNuLHPPlZxFVLwBGdmAFXfkNlhDeyNSKYgGOZCkTewhBUUz",
		@"bdlAOcrShSdRbeiiPERaUhosGeWmawKmDZDXlGfxoinPNmdhozLItGphRlYsaiwSGMzMHgywCTMlaEdFukGcDOksEZdjUKHpZxNXxIJWTNJBaBoYGvOwCnOFieAoTtaIJKFvq",
		@"NrGlHTwXJPctXkkLODlUqYQzPnASDJnUxVqoYCqZbUVVAXtfeTScTUWxIHEdBMDOVGGhQXCQYJFKcVNKgubILqLRlWWKxmYmBoKdJvqXapPRvMvfuMcHeuC",
		@"GhMpavjzydNKoDGgeHyxwPhGbXDfycflZTUEyQkGrwsWnHNNzATSNCeMWskylJLhEqqIdjoaHVJhfVcUDFmszjjbBGvjlVataHvOEKkcPibBLPkAlWaaNtPtbRrvANvRlpEhMrazngF",
	];
	return BsjuoAhdkdGzBhQdd;
}

- (nonnull NSDictionary *)qABpVpFGCsNyZiWjNP :(nonnull NSData *)BDiPHZklREzwwWCIdE {
	NSDictionary *VybWdBDGWqWxEPLC = @{
		@"hLPaBFJzLo": @"iaDDarxwePdgGJQDAFrogTyqujnWlGFFbluzsUpRCuuaWNWOMBUwUIEjfNZGbYIUqoiGGwpmZeRFzRGckVRGnBXceIWqfmpTecKbksynnVPMfzzdhTvGiusft",
		@"WrdBQLqYGQ": @"QMtZSVHfSasHaukJBCaUvezlBfhqrGhMjDoompFxADBmgyFdVyAlONJibqBRRItEfRNBlvFMzLRhCCEbiTEpcdNmtIHarROvNsqHHoTCmHzczUQlLCxzPfgYWkuqLuXdXV",
		@"XCfiquqocihohZLorOt": @"EDFTLqTgcFeREnDktIBjDRradYoGVCrRZluZzfiMYqUTzfYOaGyUewdiTdpCHEiuMDNuMqXhDQGNiYttltomkIEwIDXYWnbMvjulCcvj",
		@"nFrazYHHwwK": @"WWkmLSOaKgvtvBnjZiMMsMHBDgIQoInOwMWQhQOMCoVeASnkCPRUaKvcNLaGgaVUckyoOetVVSGsAweClGjJjbaOMyTYnGePiVqrwpnmMkDoyHxXjLocZHYuCfuM",
		@"bhXbfwTIfA": @"MPwaUJmFetmCVUlLwWJOLByfXwGFNWIbwExLtTyUQTLRjUAXWJOOQfgTvNqAEjBEENpNwQBpZnaVDORyxbVtUeFVGZHsWxdTNRnxEpQoLrEaU",
		@"tWcnmvBqMLIRIORV": @"mZmFTbPvhYlGxNhBjawIiYMzBQugwufvWouybOglwmQuKBpHZzPOSzAysJJFBSEJebxohDpGlrAXxSHMmTGGTVUYzGJyeqRXjwevPUAwsUGPoYpAzZqYvbElHuFMnoeitgqPVTcodTERzbqDKQ",
		@"ZwbZswgLVXJCQ": @"gkGhgrstGIMrYNIxCDPMOqoEHhTtfbOwsumqWrmSVhJeJmbnvgPbpFOqGnuDfzKWzCMLRTelzhducqjMFXbpCpYWbVIZIwNQirgpXpEqxLwTjKbPydlWChMmtwbfsUuHPpsbfGMjMjyyessRjYux",
		@"OSgTheYGcBQfFZ": @"SwaDWzlZLmvmqvMcYcbkptWiQqGgiYLnrJOYeodAjWOTdiUKajkqfxdCZxtsiLPaTiebNwsqCSonHYlfCJguUZGIAhrYbsvuSjIFFQLqZSPsHGIgrEHMTBsj",
		@"AdaiVScXsXyzgVeuVnl": @"kflMDOJyRkpqXPBWmgPTwyrsNQfyJIztocZnwZfypPpZIzpltZkgvuUaMnfcwOwIpZgdcZAyLwOPnWwDDvMPVLNKXlLXSQropupVTiqCfsOuOXvHqUOfNucyolMNpviPF",
		@"lxMVDHndkDkkPPZ": @"AHEeaAmHkKoAUszZaCGHDzslbuPUHziyTbtsJrufIVjSgGWpHmfwHbBfeuFgMxlKZmZmmUXHLzRqGmHOPoDdvNukQUGdyOQPSiJIHoPdjtmBMKcRt",
		@"oFXnYqhlJztuwiFe": @"IxgkUFqTQsGjMgXOxGFLuEPujiidakUSomKlbSCRkjNsTYvwkHmlrIFYFJYpjkTjAGghFedcyZFXMYIFnewtFRZzZHgkOBklnjpnEZIhnaowUvLneHGHnn",
		@"KOkOXbNNxE": @"dTEATuYVpYfkWpzsUgtoHwTuYuqaWhaTOKagurLQwqdnGKvIAmRIOgBvRWMPYhFyCblpiilmyLfbFZjtLGgOPElRzWUduIwmAnMzyolroowKRuSrstsnbsay",
		@"ruEAnMPUxLu": @"ZcCvkpCReAfZNvuVsqjLBQJvwHslPwOUpGVEepPcHcDLwfPAxPOIHcpjswWpzklOYavnEmQHTpobJVnvnVPKHTIqMRnFOzxGQHgJAQQIOPUEHVzHljmGMaw",
		@"ZAoxkSntrofCqauOPS": @"umovXBLDQOGCVFEKDbOkReNKhoqVPGfQMzfOvMRDkExqmTNHticzsUHOqOrgVVtbBxmORaMnAAMIQXlNOjCgCdEaFNRTdrTAutussroCHsOUgSAasXaTKwZTFciPfnkSEcvAfP",
		@"dHilQvlOrhTx": @"pGYBzMKuopXjpAboMEKuCAnTYVCXhICFqCcqBArXemABoitrsjTeYjNrAcfcmQGgXsRSdKULQOuQtUltRynUWBFLjljTZUIbAYEtialoLRTOgoUbYr",
		@"lkPIvIfoANuBbitU": @"FtMjYtZmtuLxIIdawySrMFrmwzCibZVwJrtHjGoasCToZbtaFwLzpbIRSPrVrQeDaBWuIrVqOANShvatgWbzsAxwJDHcDdJWIBWADztrpFHaYBYlKOXTHBhHmME",
		@"uNdWdPCrcmI": @"IylviMWDGGlgRfsTFKBDcEpBbgJNNbPHoMBDAqLTgwiywVIcOTbtqJjoKDfPfRohdAEVQjcPJRENSveSoCiryHqBlpVyaZDjZUGaFdikiHinqtmJCAQFVslMHfhsQKtAerkNfLWX",
	};
	return VybWdBDGWqWxEPLC;
}

+ (nonnull NSArray *)hFtBtSVjguuJ :(nonnull NSString *)EYwOSMNPwXjBxdBuw :(nonnull UIImage *)DDiyUQDIbaxDV {
	NSArray *vObCTvxMUdZzU = @[
		@"wZaEspmfHOyRzAUGMPxWJWKqSdoNHiYvFPnFCWEVQkpwPyMxAyyhWDXDkdodtiRergeyouyfFPQYXYVjJcWCfsNZRhskAufVrxixGpeBydLXvbDVJQx",
		@"WSDYsvVtZmeMbfeSCMLPgbXiLEugjiFbtLyKwLCekXmVcgOYLpwUwstrFlrtZuTJIfTKvuueOrmGsLvPVsMeWMoygUmSNNneLrJEnbQYzBKyiBmNmlra",
		@"rwdYBRXrROETsvJqByFvlWQXVNWVGrLdtwsykzrBMQgyBwNpgKIEgQcoyrneCKTxObgAjzHEfZWuAKjEkNzSEDxTKNgdocGwtSgWPDYmLCesUAa",
		@"LgIUqHDfdbUXaZFthZDNrRkpnucFdGyEUWXnneIMRkIEievmkxnOesJJPVbtHlbApFnsOCFPfAyBKkjoiIhhKOWPRFsqTmJKGnBHwcKixlKkAzorroCrxLhs",
		@"RENNOAVofvSuRoqJhdYuSzcqvINhLFcJaJbMRYACiegzuXWBJqbvIbhzCUdycFlvpGmElgJxEErKZUtsNAFAJrmknOPZgQtjpVoBkBzgvIIavSMfEOXjYytuta",
		@"vFlrMAVmsTHMmybtAanIpxCTHASAJsnIdgZgDMhaVdJkvYqeUEieliwZqaghmutvwVtrMRTXPXukuCIkpevaVohSTVERAPXVKDuRLhtBopkXkUeldkMaMeCdccxUJeECUO",
		@"YwvmMSfjEXQEJMAWArAmXkLiJGijLYkfoWxAyiZaSeLgAbfVEBzyMMGUewyCOkjOoHzKDzFHylkwdRNcmFPzhZBsHcVCwrrYvhjkjN",
		@"mJIUHKlmZHUwAiEPglBfpODBusmqsgmCPZlQLATEIvYCCYQdydOBzqaQRuzTtAZSdsVyVvzaatmSENQnLpkDGKIVKueGkgSFoRnTzORAohnDMStNsRzdMwhTaOJvbOTrXOGH",
		@"qkLeMEVvRipthvihtgoMRjYjHlyIeVEesMLCmvybnOyNfrJHxaumdreKSvDxWacHgeIfLDJCQjhiIgmBdHGLvsbbBnebccMBialepYirsMWgOaoERFEVPedduuvTPkosFBW",
		@"PwVWgOQBuVktTjJmgvUCSzjHbxtjIgmaRLonEydGCoPcKpVTiSFoplcsSfQGRMvhPknQnXXDlPPObWfqqLNDndvuqBYTpCcCPWHkmeAmtRNPJmUwVxvbNXBgJb",
		@"lLExyYEbICnvAgiRKRurzZlWnnCpODmGLLWZfitBhWatdHDGURxKaaUbfnizoPLNxcIGQtSwIGaoyUhfKZYaQMdfEGLNBcmfdISNmJwOVyTokSjgjKsVUNEvweVgLtWJzjKAQZRtCPPLRdTMCIdTF",
		@"FlofmvMYTHHCqqdCRQTRAVAASMnItYnWxSyMnCXAtFEUYbeNrQneojPrXrDbqpyTzaIyADdXqthllwGphcxyVvEDZtkUoKKKeqwyeLNAQLGiCjYXUJWfCPMqNbyDhkqwPZiOInZVvxYhGjcHAJA",
		@"XPgBWCJzxeNzCurOcqOLcMZjDuCcySSDiQBtErpmFdQfYChGNnKtSlzqEbcrkqkiRAuFoqIDiMNYygAhscPJczUEUJCnZDcthHZVRjlLWNalZDIXWrjQosVlafyiALSSrqaiAhozDrgpnvl",
		@"glSDJirnviUgIIXsQSOJUBwkcDNFDImHTLTAQNUTouyUHOqjaAwRlSNUZvMJZhtQVMYbAtOXFEnZiPijtijOlrlBuDTrZOVUOrknVkqsmUP",
		@"UNeAmUGSjtutKaGSGRVRUsvuhWHIiReQVwstJruaZIROIPpZVSbcDklPcRCGnEHUvFnapyLFTiXCWkxiIPAWyqrNLafPpzCGfuONFRkppbAf",
		@"gUODpRSlacmbkJwUpsCPwULhcuPoBxjssSfDqBjkzKSvjryFMqHBflHSiZzmWnwBMssKIMzUwzNoLAfADySxiVWDWqApJLhUgrIX",
	];
	return vObCTvxMUdZzU;
}

+ (nonnull NSString *)sVSfmEGmKt :(nonnull NSString *)YGNIDHcriuqHXSjjhyv {
	NSString *qjDCpfgfuTMnchRa = @"rXigexSqJCppCdfrsUdoWUDfSJZMjLTbXtMYkClxuUcFzbvhVNIHNQQylpjYUsHwZQCPfLJnMlvgxRyKrxUcdSKkGwiUOYLSRuxrLIvaQf";
	return qjDCpfgfuTMnchRa;
}

+ (nonnull NSData *)BUewjdIGgHcGVbQCLws :(nonnull NSString *)YoOztCgJQjSSR {
	NSData *VVZFyixVxugTVaO = [@"kumqwKbZWgfTLfjqBfIfRlFgiSQBnXTvCyWvXuuOXujNchyJAhduWGpmtXYxeIiVdNvZGEeaDtZefUWAXYMOgydBMTFhhhJHGldcIUzGenMXXumlcelnCwYKrdgkWICvPa" dataUsingEncoding:NSUTF8StringEncoding];
	return VVZFyixVxugTVaO;
}

+ (nonnull NSString *)JqNlKkoQpr :(nonnull UIImage *)bkcokbEMwOmUVAUR :(nonnull NSDictionary *)sivcEUBoQzjKBZjFn {
	NSString *pNJIMyoyQIVNUHlyNZx = @"LIGhhfqxFhLzKRlMBwyzKyEOdRGaPhKUHReZKYuyKDWDzkEZroKVmzmjQTpXeftYjYFzdcFRmLHHwySMSCHZGgrQadgOrYPWqSRRGmSsX";
	return pNJIMyoyQIVNUHlyNZx;
}

- (nonnull UIImage *)CYczeeDSok :(nonnull UIImage *)rKZnHDDDBA :(nonnull NSString *)AsGfVYopWkXik {
	NSData *XoteOgjDezIpcsxzJd = [@"ikKaAXZAwTOXVlytfalIgwFBWNNQvxFWWNplXEfnzEZespSIRXUHJarkdpIQxtoAOKyQdOaucVJpYuiwbGwRIRTsUUFkEljFCRUwiVRHAMtgxcClSceVYv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *lQwsPyDevynfZZPf = [UIImage imageWithData:XoteOgjDezIpcsxzJd];
	lQwsPyDevynfZZPf = [UIImage imageNamed:@"diUVngeiYWcQQNUhTeFEsqPhWkEXsriWKxBUUrEMSHvyYhSEKGndNofMIrovalNlfmbiCUOerBlIixtdICNcxMSFNpRCuzhrWhAGFvPZapUQgrUizXFwBjBYQSO"];
	return lQwsPyDevynfZZPf;
}

+ (nonnull NSString *)PabbZLsQeJJvPE :(nonnull NSData *)oNcXIdCMymyAarMg {
	NSString *NQsOavPVQciwY = @"OcWXfoMMIppgcCmjRBxZnrcJzlCQZEThhYxFOgEMCVzLHLjVWNNKflsQfBitNNzLRYGZWSAGXmbRaTpNBZWFOEmEJnNzAQTSGMrajNjlLjeA";
	return NQsOavPVQciwY;
}

+ (nonnull NSDictionary *)zZZqEVCWpdm :(nonnull NSString *)XsXUPENcGevZpKFyBO :(nonnull NSData *)xurpAQoHDpNssL {
	NSDictionary *rwpwnCdklxXxdVBMUq = @{
		@"umVfLKZGYfnuPJtHOb": @"jFopUQijsxaAKzGMBfdnORFTXxVgwHBPlJbYkTpYhfpUOheuHMpuXoIdFZoRkqnEOWImVPCJaaCSjWNGpRrvBgkFwSUJLZVXwZiiGHDPqFizvFUGZMWVsSjCg",
		@"xLPoEtfUenVsRJM": @"gKcboxQHtMSibyFsSuyVEcdxSohKoKtlMUcfvBXXCnsJYZxKLhVyFiPmlVEaqgGlYgnAmuDrVYwuqUEIvbfItihvWpmRUltTDbDavWu",
		@"iLIocXeIIeDoY": @"eYdkSjziGDxMKBffsXJsOCNtZTKJhaFjKppgOafDTafvHTnaNngTXfvyPkqcBmsTXbiABQnCaITPtsHvJqwwSOmGdvgdYFXeENlhbzcGImIOVZXKyhxMhnFelkbiuFJSzVur",
		@"qcHzcFVXtkitDKG": @"nSPMzqtWGUsDaHuACAwuYhLyDFDsqVZJbrUykoTPzNTZrjOpAusYyfCxIRCubTxUPzxjOEeiFwIKyGLxoQUkBjWPSAQHFWdzHkuoZECAowRgEnAqMAGhvbvCXqlvoKWbwPuypEjZqmmT",
		@"gfGrmYoZUt": @"CJkOsigxqTTpMRPrDLcpTwEMOPBSAQwMjWQxIRRHHcBUjTWIGSCvjiesZfLyEBEuBMJSkBNNrBaAohKviMUiEjbKoArzBCdVAkhJsKWQswqXMaWcZYkABEhzxxLVWEyskfZAwcPCFiLKogWoLV",
		@"rnrkJkEkStxuB": @"vbsrsvOvJKHMwsbJxxgtVaogDoFsIFLaNincPzttyvutakfkoLSAwCujOFDmoqZDIzeEbABaiejoUzvCWfbIyBkDyxhTJWPVVwpaAeVMCiNWKNHBbBqwFfOVTWiVeRCLzbyyOX",
		@"RYZsRcwGVMetxijbO": @"vOzeZhUbythTGUeqyStzSMRcLkJkjhziKXXXmvnUnHBxwPFeYcGZyHnrnlxQseOoFfQNZgIZwqBoinHmOjMuFPYDqyPyXQNIAbdFmKViH",
		@"XoifvWBKfRFltNUOB": @"HJzBFUcOIzhVyIGmfqJOEKEnBKyxDMclEqHfsmVkAhnrLbqMpXQJeoXolpQDwrLUNkTNJYpwSjzmYPuTwsGUmEMcODsTzTjOLvigNDiheYLctSGeSdkqGIemAfqwznjAnAZqYIatEXqz",
		@"GgVnGueluzhFPehI": @"hzsvDiKdQESPIcvHWwWhzLqIRGhrPtnTHrRDZFYAXAgMXWUpiLeZULDxKacxsUGKjdxqJSlWgguKGBuNWitSEyUEFrdUPvUSEGBAOAZzhNzsLKEzIKuVQ",
		@"stPdaYnoHTGdzo": @"SzDaMPLTAYxfmRmepXRhSsJqkzJQmqjzzDHpeYRmoXRQbycxhRZWDHAxobzNenFbnDmSwoyBBeVpvYIacmzQozBecfgiNPeWrksnUMoUbxkBsuEhgWFxOKvQOusbveGdcDoHFXFJZLNIQ",
		@"QHSJoYdNelqgRACNG": @"ZWuUoPWueVNIJbpPdAbRnYpoodSRIAhyEpFeaBvVJMkGvllsGlxAszeiljYSsTtrqfFxGVWvOLZQMoITtsVuYqlWbjUqJoULvXqTHxlhkbcQwjljyamLSYSiZfiuhfhHgtJpcpfJCyUMxOitwoDly",
	};
	return rwpwnCdklxXxdVBMUq;
}

+ (nonnull NSData *)jmfAzlMPUJ :(nonnull NSDictionary *)RidlvrsqHVCvVzpg :(nonnull UIImage *)HMPCWqtkisXzXTccNB :(nonnull NSData *)hlceyWiOqVABchCD {
	NSData *rlJBKkBksvlAGZpEQ = [@"GHspfnOCAvLgaOrNCRJpCgPmkrHVxAcywPuiwaVYngysatmMvDQNOSvKMrQcdvjCYirSfdtRxSQsTYZMDzFIefOwgidOEduPcFLgsBnCOELWiQayyrxblgfNhxde" dataUsingEncoding:NSUTF8StringEncoding];
	return rlJBKkBksvlAGZpEQ;
}

- (nonnull NSData *)SSYKYNrOSfGjlNBP :(nonnull NSDictionary *)MqaQwfbOuTMHYWd :(nonnull NSArray *)ayEbXcmDQhgwGPY :(nonnull UIImage *)yFvshhdWjMBrFVUBa {
	NSData *xVOWoQLrNreffh = [@"wBUSlgAXuRrzwWXFGitCLoRHxMfLnpxAWCKWKatgujvFIhqdfbgfBSGshXgHBvfTLFmFNYQlnLtioLIbaCEaolTQjVhOWiECHdvAIKaTDZnOSiQCDuRXuZYGfrXcHdSeiUExbOp" dataUsingEncoding:NSUTF8StringEncoding];
	return xVOWoQLrNreffh;
}

- (nonnull UIImage *)UJHQwLywSQSCITZpS :(nonnull NSString *)fyDqMTUaFiIZNlqZZ :(nonnull NSDictionary *)uqMJdbICqGWHzd {
	NSData *TAlcKxANLgiA = [@"sBEOqWIZuOkQbtyGgAJDNLrBWdWNqAeOvKqyYDuxbwXfZwWUDkZzKSDwzIIXobQJaQpnvgFEAosdGNqSnKJvcAWUoUFdvqnHwqqDkklBfPzqPETmFuhYBpWZIGATwoFopwRUVKKApjFtwft" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *akCiNPEXlpPpATOBQzS = [UIImage imageWithData:TAlcKxANLgiA];
	akCiNPEXlpPpATOBQzS = [UIImage imageNamed:@"UFMuynKZIdmMbwiBuQSZzdysAOrBoCZDUGiuGeeTbqTOOeNhCWZBvPfZBdqgTnzqWaaKDiFempesbKJnHMcaeYTvvUAMEpcEADYFlmkZfOClKDNyVfwidCAWBmpTugWNswQJYKYmNDRESTZc"];
	return akCiNPEXlpPpATOBQzS;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    MessageModel *model = self.messageModels[indexPath.row];
    ExamineCommitController *examineCommitVc = [[ExamineCommitController alloc] init];
    examineCommitVc.model = model;
    [self.navigationController pushViewController:examineCommitVc animated:YES];
}

@end
