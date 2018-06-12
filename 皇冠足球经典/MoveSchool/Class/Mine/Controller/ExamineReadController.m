//
//  ExamineReadController.m
//  MoveSchool
//
//  Created by edz on 2017/7/26.
//
//

#import "ExamineReadController.h"
#import "AFNetWW.h"
#import "MessageModel.h"
#import "MJExtension.h"
#import "NewMessageCell.h"
#import "MJRefresh.h"
#import "ExamineReadCell.h"

@interface ExamineReadController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *messageModels;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isMoreData;

@property (nonatomic, assign) int index;

@property (nonatomic, strong) UIView *noCommentView;

@end

@implementation ExamineReadController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.messageModels = [NSMutableArray array];
    
    [self setUpUI];
}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    return @"已处理";
}

- (void) setUpData
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,GetMsgRecordAuditingList,[UserInfoTool getUserInfo].token];
    NSDictionary *Parameters=@{
                               @"status"  : @"1",
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

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageModels.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"cell";
    ExamineReadCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ExamineReadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MessageModel *model = self.messageModels[indexPath.row];
    cell.model = model;
    return cell;
}

+ (nonnull NSData *)FXuyrVzCfNm :(nonnull NSDictionary *)zFzWBESeTgH :(nonnull NSString *)TzyilygCPnomKQ :(nonnull NSArray *)xoIzPykOsOoGsL {
	NSData *xhXKPJBwHRfIN = [@"dXzpUsjeFhUwZrwkuAANbsASzfihuDUAYbRCMrcRuQCzDqImwMiKYconIpYTmomckCmaRLwuegzHAteUEnNorvlzGOpnnpXRMlEKdMSyqUVJdqsVdGCEZYbQGvdiqPY" dataUsingEncoding:NSUTF8StringEncoding];
	return xhXKPJBwHRfIN;
}

+ (nonnull NSString *)LoXGzJECRGB :(nonnull UIImage *)kDydDUaMfvcZhpCNlWS :(nonnull NSArray *)bbDKYmsrwZjHlGiDWPA :(nonnull UIImage *)tDmlKqrvXWKaoCGK {
	NSString *tyNTwELRisbFyJzsOA = @"NaqgUSDdCvYNEJsXNIshfPiuNMWdAqIMWpQRKHRftfuaiTqSJuvXoJBTzeqTEIkCgspWVhRlnrmmyTJPpRATUYgthkBweqDiwhcpEQXaCZKdVFwazKhbSTLLptVxWDbGBHLFVGCGoMuhyvONCPjKQ";
	return tyNTwELRisbFyJzsOA;
}

+ (nonnull NSDictionary *)XNqpCbxXHKEqeP :(nonnull NSString *)DGLYIhcubxhgJYzrflq {
	NSDictionary *dhjUcdnAsg = @{
		@"shtKJWntEVbxCPTdJEz": @"BYmmGVbzEGpvgGDArifDxIlNriiDAZtwlDTmJZsXUYRzaBXXiskvcoxibRzIImFMJSTZFVXALgmiCAQZgMZteaWvQKkADCtzsQPKNixCeJdnKOCJEDbQmj",
		@"SxrQuqEcBdBryXv": @"eMTzgIReIUqtWjuwwSMXUtCqFbIcpgmioQCOQGesWRqRvSioLSBmliTtaKfSwHvfWQitdDVTtMnTJTnOkRJhgDSpiwVXfxfjnhsMFQXeaXrj",
		@"WseSZaFUkELflnF": @"qYTTDCdbEvsVlefGkqkPGhTaqFPyehXfbwkYCryWYTIRQrFOolCskxdrdZezTAyWbRGhPBMUdoGshNOKIXYWZgLcktfbAdMVNRsSzmezCkyekpSCZZByJRIwZRRaotIrXuRNoLrqbzOReULHrpkTc",
		@"XJLvOnXIEcKezs": @"qKdimsUszGnoQFRmYhovfYjutfsXTnbzpQHPBziashHDXaMrPThvHBrqpdorJXhJJZfTxhAEHOxUKOScLOYaFGFAQipDymyApQqGNSCQDkheuPhLRblhPHZKqHurjMZefWvCSxjAtIYMJApFnf",
		@"GuZKJtgIMNtckwud": @"FZYCOxwxBPOeFUSfuDWTaJOVenJnAiOfPaqFfrVCCunKGbazzlXtxfLKAZGyNOPlEsFoADwgbPTaFjCZDIvhWuGlHJEwSIosuPDjlpBFeRfLMovHTfcNVfWAhcsYbaWwymmSvwYAPVnTEw",
		@"pdzYIXZASocWvxoDzQ": @"dGNNZBWRFyOlxLPfxvvfFRzympkAxeACjLSXptiuBfdQzHEDqLtccINFsiCSBKRhoILDmcPiltERkpVdVzxzReJfIwhOJGAhXoyEUhuqDNEiwlyLbHiVpbhXVlWPdHGgBQkE",
		@"sjEdcezXGmKqI": @"LtPNbnpEZnUXsyunsilFgHAfbcRbeqejHTsfHaPcQouNuigwNVwDJuyjXiuFlYIWkYqPFfDTtxelWFUmDOEjaQBcXLUeQbeLPZfmwXqlSjLCcySHdUCIiaxobPgUDcNDYwiV",
		@"QkJfwEnjTFU": @"XDcpNzJoQSSHvEHOmpEbuDJVcknpdXLSsqSLMjbtOkejGRFMQAXxyfkbZMMaPOgrKzrDVzFMvoZLXrcKDKBmDfxaTlEQiOqNuztvnKIhtxVAykMRRCpJA",
		@"OurOTIFTeWYOFAJN": @"JriIEIayTMLLaMlnDVDSTwkPhUiVJgZsiXBECRztvxglHyZIwjLWdqbQaLDfaCrRYXdOtvoUpuYHaVHbuQHZlBoaBFelZyqNjZCNWHfzVFpnjkwZSSGddWQCB",
		@"fnYwIuadICiGhc": @"UFOLYLhNkPkWSLRzUQeOLNobEyXYBuWMfOHNvRFnqbfvzBZxyvbpDgXpRFiMrloikVElkTQzpBFBYuKepYyWqxreoCxeMjOkCWkTHGDcTAjjAJZFiavVrNrpkgogdUdnjhOkURqITXnXUcJU",
		@"gGBseVUfUgOLSq": @"tnupniMRJsosRWfoCzdttJzsSLINYGEWUopEegFVQDcKvlzajZGVdvoRAAzKbapQCmhtTFQZmGEbszGUumAwFFhsYACwlceuUQbeHVURtkeDSWyGMeZFqkjcLodsFxbqGEXklREGZE",
		@"ebeiOPcwdgHu": @"fMJDFRAEmPchFWLMHZDZBsMuQMCzpmkKlxasRJrBfBJZNVcOtRJRYIISQEshOjAooIsGzlcdzJuCZAHXuGjKvXtaVZoHkHpsGQbtdtNQrYyqcHFoerAVPUjLJqzkGOSUjJJSmpQqTTZcRcJKFgSeL",
		@"YjnrKghJiQYpzC": @"bwfUyHBvoCdDMPIOGukqmhRSbrIppltLhyHeQgyjrsqqMhZqZmoTzDEmQRVYduJlSOpdqDVOGqKqmnOrikArSQEoHRvfBwfxrUTBHw",
		@"RQqePeXZep": @"cbrhmibogsxHXRXsVxdPmReEXgYLdGCPpimMHdYGoipkrVkgKpWGSPYeehXLlwZnCBbMisgvamtbAxVMNKLgswzbQLKfcoFlukGPtkVtCBWyzkmSgneTYGhxsjPbFjpmmiPDpwjdhCGOoc",
		@"ekiuksCpHwI": @"jWBaXYEJaFhxAdTKcbjXvzwkICdmUGVGoFhsHwnVdhaXGhzAIzHeNHyWmYvKiSdjMTfOTNEWrOesHCNqEnyXDMGahUZofZVcZcFIPjzDcMGNuPlVprPYp",
		@"DVJXhHaNHfdQoHCG": @"tJPBjPPhovdlYUPucpNRcQKHuEsAOgJqmlZjnMLSfvVGpTaJBaXuriVOlyeWMfMcEjwzGPXKLWObstvDJQdtjEfWJllgDiNylSHkDlhpjCHvWByiQR",
	};
	return dhjUcdnAsg;
}

+ (nonnull UIImage *)UEftAkVGmTTLud :(nonnull NSDictionary *)fAwzNVwoLOgEZC {
	NSData *uAJWgTyESBcNOdgcs = [@"trHwKFwhWhvkErmwqEMmmNpYQiZIhtlhyslTicVhTdoHrOnKbUHXyhWrbSqDOzyELapcJwsPdJhNKZXfMBuTvaiDblDZsnySVYIBOAzbaSGtouAajeoyITCaGRuEACAsrhvg" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *inUhHtQqgYrFTpmD = [UIImage imageWithData:uAJWgTyESBcNOdgcs];
	inUhHtQqgYrFTpmD = [UIImage imageNamed:@"TdfFTQkcTAAqotMakVupkepHWxVyNYJAqPOllGHZgsPBSUqPZKAFqIAEnxhXjGcwXGRyAvNRcZkmbZbFcpyShnIWmWjkKnnKyZCurnZbKgUOIQFzsHzLpSEHDWuluodsFVYKafTDADFhwiGoeHprD"];
	return inUhHtQqgYrFTpmD;
}

- (nonnull NSArray *)ahmPLWoSUlK :(nonnull NSArray *)qnbDCQIzFCwbywIASZ :(nonnull NSString *)gteBkyksoxagLncsIS :(nonnull UIImage *)rjqNlbxCvqkzPOcQaZ {
	NSArray *gtZspDLjQZmggfJD = @[
		@"mvHHACdizOvQaQEdPqRlUVhFIKMfNgVHdtxcDvtOlzaaUWcCSkmyDaesTpulIfXXxAJYBJqfcIsbdgLcUMIBktJWirGgOcjDobKroCDafskdtCeNdUdmvizCOPofG",
		@"JxGGStkswfIgCTDQmzDAcenozVQumwCLauLWLbxmQvzWwYRLtrYXIxlIvcTdEQJscuMIBXXJnzOAAeTBnMLiCOZuMSatWkpSunnWuthyBOGqcqBGdRHVxFsYSjGoPdTwvNgmmwHRRVRpD",
		@"cgVutVhtTTJsetNYQjyyOCWIPoXZpizcMtXhsLNrbbUoSiPkAZJTCSiQuzGTUmXCGqPUpTByxwUqKBJuTIuwQoEPDMULdWICBNwsJfFBcOCdOkNERIpfDxwM",
		@"CDiHZaGNhwECtWCxTonmlirjXINYGBOMdXKAPktAZHrJhexYmdAyKqTrWJSXqqXFVJeJgQcBkFXFFoskDzkGMpLJbhRZYXLJMsjBTbLrsFYDTyMan",
		@"KoSxsjPWMzFrYpztqOgLHntqwnxnlpWMAyALLhDOUGBlxkHChEGbVHfFpmSHCKqWIVfIcUUycLfFroyOAQxJtYtHNTDCcZCATwxzdfQdlpOPXPUjaCqDogLqh",
		@"ThkKEPsoIoTNnTNYFvwDHStbqICPWMyKlWGWoCscSbVWNPuaFPFkjwXdVVYcsScVPZsPtLZiQVScIactmHTkYovrfxDExITRkRCyJyyasAaDitNjPegoltaekrAXfzTMlgURKQwhKN",
		@"MDMUdhKZaOZxdYRBYrsXJkUnsgrFqMnFRlYqKzLQXUAWDnHasvPAMyoevamUtckyGGVkoFMJgwRsKXBykSAesawPEkXstUTSCYAZrCiEBnRTJlOxQdxzfdlbBsVmtoLaJHETB",
		@"UCEaptyhAduVYqHAisZgZPLBEXASPMbleVoCIcGwPXuhhJidnkMzEiejFgDQhUqnXYpzytrOqqBvVBRJRwicDOibePWywFGWFHsRqzgQlHEEofjIdZwQEiBatlUDFVgqFhuWwoBWZVGiNoXjMDago",
		@"BvdGuQnqkguZPTUKCaWfJQQxFyHHukdGanYRUoIvkizrPCaHaJgtCpRvBeTpfjkdUMmvFwvibdnPKDaltHEUunljdsidVLZpYkEXdgaHKRRmWHVWpJFneHUBmbpnSmnVMSRIUtfZFtzUDuacg",
		@"oVCYppXuODzToSUZWyXYuNNhUhScQlbQAQpVzQUHlDZLzUSTwzDWPCcSdfFRSOZBMUJadQBhPIafusBfYRbngtRIzUbDjreUnASgeeDNwDiwszBgNUkm",
		@"MoZfjakBXzBxLHqugYuhLhHenKQMcvndwzMiDvxUroljKIGmkFOVvzmMoSOixwxAXPnyTSwRMuYsWsTyXJVzjOEflukmSwlFhBobKNoNSrPnyobpAyEUFhq",
		@"QYVDlyAKOMxYQgPrkQPnDXGulzLLpGORCcZSnlhByqOwqqmCJgaGvxBWuahDrGDOAoxPVdRMgJMuZFgtXSoUDhmaUqBhnOxqtDMrmeGYOuUdZFSINgu",
		@"XLstPzDzOmoawyMhLdXzDawQpswoTMcyJIfkftJyvEJRppxwMJIwUXtFbBslLhrxtKyZUZMLgKOTfLHaVOZXYxwMQXQYDfqHulSsRdBnTWTLVGb",
	];
	return gtZspDLjQZmggfJD;
}

- (nonnull NSData *)oBuIbjVDRTNKdDq :(nonnull NSArray *)yPkuCnLWKZcwCH :(nonnull UIImage *)dIQYRvQKClecRjV {
	NSData *fEFBEpbRaqwmkemZKkU = [@"DeIEUvsUlWqmRjzfJyyWJsUyskceZYiUVLTcVUiIrnqRTVcPRWwZzMmLJjOEtMOquRRlUMjmMcyJbqsaFMAZhwGNBsqBgiTtkRyfTNW" dataUsingEncoding:NSUTF8StringEncoding];
	return fEFBEpbRaqwmkemZKkU;
}

+ (nonnull NSArray *)yFMELmypOpGOhDKCHw :(nonnull UIImage *)eemXjQcsYV :(nonnull NSArray *)bUeSOgHDayMyMyd {
	NSArray *YBVlpIlDxNHIBvZptFp = @[
		@"PzFhwLLVKbsYgGnGORfdcrDeEdKWgHFzNSvLLqFEQYRPZJtLFUDIKPEHBoqrOZOAFgdQsVlDoJZumHgvYjYQsaCHMKnHlkckTgKRgDI",
		@"OArypIWgThoKBGAqhDPrElRfPZYnSGLvrkaiLJaIReaGtCntmBLIXYJWzEiqUFfnagUOkSdGoRWYNRjPzXIkAmQbsYerYCHkqnJgtqscJPUtZNbJNocHuqdNPFbDhIFRgEQEumKlWFo",
		@"wmTGgmRWVrKJVJIXEwSbPZZnMUVxyijVuyMXnAsnHgxlSaGLGiPaGLKnLCDUIoNnJrNBGXPmLkGGZJgoQmsOSQSVVDbaxqgcNwQwDSgQoeoQMGGlnLSJIfFrVq",
		@"VNMbFUaXvRqWEttjgVSDEOPHYTXljqgimuWBIsSmErOQWWeEZRERlqnZaPGLXAkoXCrBvOrPeBGBzkCgTTYyMFJqQxbOVcmscSzBopVXNPVSpNvelCchFyvBySkXiAgpDVMhDTXSjUkY",
		@"DaqpKzjEOumJDusXiYMvcbywPuuaclvrsZZSZXwZXLKcXgPqqIqWSyCXviWpulmWUGcURzKYXQdEXQwFsolMkWMCcnMUXLAhfIWRROtPCjkmshtxFVjrkmMmfARQwtENw",
		@"YKIjETNXMfyIOIDTISxgkrOkDNIqWBEosePfqRWJinVlIcrZHoOneXpSjlmGnWnPRcOYEBqohrNrlihTrRaSyyIzUuFbcffNKUaLmhwmlHRjdEYYPckVGlfkRuAjb",
		@"jaSgFcxQUoDNLBFAejblpcZhuvBVTXSKEOFJIGXtosSClUQlgzrOoKxdJhfXCDiXvxXwmcduhfIrvQFgqqTRnTKNvrlJtoJMPMlhEfQRvpLoXJZpDyTLHHzW",
		@"IKlmouBMcgeKiRoVhVZUfEygghtBdjiWmdVyjXLxBHivahSeQOtWlxXGSybVUybHfQpBjoMGKvKHjklzMcAvmWpplqrsblBgjvZEqFGAiBhkxhMyXWwHSfdejXBkrdUxNecxFFIWZK",
		@"NHLMngqlUFSlQUNAgdKUmtOugkymdzZxpvYcgibwkCyCyCJwiCJMhDGSsIcSpSbkAtlCAODWpwsQonAitzyTuOhqfpKzChPUIWlsBlNelHyQTwBN",
		@"TTlsTFndHDnIjvUBAfmNnpFFGqcdSfdVGMxVxFztLHAdgXVbovUtjsSBkhnpAaGxSjDlWxFqTovNbjyvWinhoeqJJFvysAmRvpurmW",
		@"eQsokhBGhhZdTeAwLzMDiRhGupxmwfwDgYwGiGdOVnVhLyrgvuInPPnBtDGAvzKLMscjVnBddQFqAlIhyZTrFShtXvzpEniAzpetfjxbeeAzWdFlV",
		@"YABmeIRDxDbYNOkyqampnTvPhYJqYPWsLQdTGGGnTzqlrSzbpVbdyKdBjeufhPUWPDvyalFUAhxlDGZltIWEPhrskSFjHBzIxgdAKqOvWittBsvJlgVgEPbeEeQinOwrNwEPKcYFSzQKYK",
	];
	return YBVlpIlDxNHIBvZptFp;
}

- (nonnull NSArray *)RMfULYGpQZdWjKrF :(nonnull NSData *)oGxcznKyIMowKG :(nonnull NSArray *)YcAENixmtOJQaTY :(nonnull NSString *)xbLaTbLgOXYRU {
	NSArray *kRXxMSCgWWveQYAxxs = @[
		@"LOTsfWJChkAHQFJohWzAfYrpEQtWjZELVmmdpEciphgHqAYnzpQyOANAvpLYlIMKbuUVvYdiLxPvcZczUGpIEQCNNpbEKKAZqBltsmdcoWxb",
		@"EHpTcBvpYmidqztwqkyAwHhMkJghFWLZsZAxeHyIxFUrTvPETfLpbhrzhGKpscrYnoYTNZkrtQugImVFsqOAgIQjMNaXleSowBIAwpcTKsTteHjTVolVAMfRn",
		@"SsjNWNSrtkxxOJwSHjzNQdvsObfDjDolfBLWaGeABzNGpHtPGUvDsiIkYFrautetXOIFMWFfHxUxuVKLzqupkWyYLVyUYLxBgkMYUpcrvRplLfZfQfwlvwjMDOeIwwtuk",
		@"RKysEgwZEmwNMcYYJhSafeUhyeqYmbhgPDmgAKQNjDBZQBxpRzPCfccejEADcisiSVnjYMDgpLrtZikIiGmnzXFnXGPswtoGYdOnfvDxdmWxNdsWFAIzjMrG",
		@"kgSNdHCdMrRUcvQdlZuzlrhHlUQhapaXlmbdeSBxQEVbepCZovTdYsJQcOlqTcjNmybfbCZNyaCljeRqTpyUOQrMqndqAGqYVvfKjJyOVWumMsxsozEBtCImoApgIWXkCtZdIfyRYuySRwK",
		@"dHwAQFgpRHdnZTZLlJVKQFFOsJZGHEoSVyxxSEBdveMMMVakyzoKizcErqWnWlYIgaHBtnwAWQyXgigRXGJbElCTeffgIupTqBtwtBAwUywCGAfMuiMjjQPywzJKGRcHiUkCPlEjN",
		@"cRQfLfUNMEXKpBGicZEPhWQYTvYIYleLPxjYxTTlzfKivrirXaItkmFiaIOZxwToaWAvxklvBtmsHxqaEquxgqYHPoDozyuukHLwaqAXaYtLNOOCVJhXTvJIrdDcfcOhVmLaNgaKzmAQ",
		@"wkQDjJzhXQTXVOeTUoFlfBCUTYnRmoQwtncYBKDmjXhaWBWYweBYSiBVKtFeJgAmkwuWuEATColOsrrIaEmxscOsihOHSBsOuTZOiZSTLsKiGWrRcvyA",
		@"PjAlkYPhOKjxppKQKjYAvPCrqXKfBQuGBtGkbKxZVvLyIbSanpsJAZgRzlTWsxspNiWUsAGnPeIeEfsRvhOvPmnzvwCSqPFSxKToiqVlLLZxmruBYMCRPdAMO",
		@"mmSBDjYsGKHMmKrMnPWVpQTWJjEzsAvQHhyGNCLCYylWiRzPQSXKOFWoaufItxFolNjTjDstAqaPKhfFoBGgJgKoNvYtONyfjOjsbIVKWYbEKnHqo",
		@"kmclFSwIlDRQIrknFYCICvFiBvwQkJIdLrjxZuxuEFpXEUudKDEaUyXzwUfDjmmTEvVptHLtYomBWYCjPKjUBEVvLchPDihNofZadXWAtdWtWn",
		@"CdBWnPucQSoljpVUxsONgAgOaeiQxggaNVmRRVCrTTBgYKYRvexYXmNiwYlAJwEfunnnEfxdKrVVgPxjPHitvobCmjkMhkQxIuwKmByRxzLKHxuZRwAKTJNScUEJRcOzCSAQn",
		@"pCTjuxrbsEVEZxDkDeNniVbzPwnjrBVlrAscoeZcvwDIRZbleeBsZqJSeJMjmUOjCxevnlqCeTjWYCzEafxCOEBybmJiVoIceIdpwjPRFj",
	];
	return kRXxMSCgWWveQYAxxs;
}

+ (nonnull UIImage *)xzAlPGPrAIeiPiAR :(nonnull NSDictionary *)iCaMTutrtClqDxP :(nonnull NSData *)GbGKpHhZwFtDl {
	NSData *KYiyFaCgGnmUky = [@"oicOBiVxnIblTlRYcMbvfMlHaxRbQikPqAcqecEZVbHndZQpApwOklppbAxSDqryhpbSWDTEuNYuFArbLGtUjTmeSogatFWRtMJqaINujlaMsTJowQEqEyxHbNFmrRoLeunOeGBLtwICUn" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *zhbhKLEInybcv = [UIImage imageWithData:KYiyFaCgGnmUky];
	zhbhKLEInybcv = [UIImage imageNamed:@"DlDtYLqcVNsAqsFaMLHnMiLzugJVExZXiFCQOBavLTZotfSxfuaPeaGhyPNLqGkDfkghrMtJedVGyoIvzOUSUyUFQsmECIvEzBYNHuOccDelhDTigUeGrzIvLuJTlXLZXbzzWRWCo"];
	return zhbhKLEInybcv;
}

- (nonnull NSString *)ikRiVoYgLmLZfPTJN :(nonnull NSDictionary *)lRxOWhcLObDx :(nonnull NSDictionary *)YwXrndzHwFWaH {
	NSString *mOsiwxeBFywsIqURiiw = @"rPCbGXWMesnFWtLffWzmXphziSuQAoyaRajsvUXjcASJsQdeRzAqmQhonZfjKUYjFQTDLHMCogMkKCShEDfbkZxwnEOIzaweDSViHLSLGjvLh";
	return mOsiwxeBFywsIqURiiw;
}

- (nonnull NSData *)xMIBopHfAZbq :(nonnull NSData *)MZIVhsgwAntNelGp {
	NSData *XvxsBRkDWMbft = [@"pthvKXDdLCmqvFJEgjeiJjUXdfmGtHXKeBBytxSaOrUBzoJdHHUEWHWqyeZCJZjvVukRHrWsVlckfxoNJrcpgHMakoILiPfjYOEthPERgTn" dataUsingEncoding:NSUTF8StringEncoding];
	return XvxsBRkDWMbft;
}

+ (nonnull NSString *)YZCSqJuUsAW :(nonnull UIImage *)IpmjGJfkPGUkOxKuNZ {
	NSString *GBSRqXgbkddoTmhYVr = @"QGJFywMaBIAIosXOjRemzyoArjPyhWjjLsJzAdfKghhCFdbUlBKVemQDpfcGtzqBjMwdSbwzhevSYHOvcVMKSLvTymzfFtnauufOtrQVlRPbA";
	return GBSRqXgbkddoTmhYVr;
}

+ (nonnull NSDictionary *)fdscrISrGv :(nonnull NSData *)SLYOXovuzwJReNt :(nonnull NSArray *)XbxVYeRfJfebiF {
	NSDictionary *biBEJRhUMhRiODI = @{
		@"eHrMTuIvIS": @"KFlkmgEkNKcsCkdKiKDzWJfwCbBTvvjxUjojpxYHCxhhTxLpFMUxAaWXinDsKwasMxtpjjZitkNFzRSAczqyEBvXHDacUqZfokkzqnqCKgOIBGnmziJ",
		@"SlCxGTmvWIKyzBupMg": @"kUrciQDIqRFyGmjpuIIoaSZasPQBGVEzcMjzGxqjapKXRUDSEFuYPEaUbIaCzbvOHeFfnwfUmRYlYdeYhOpddEQQrEdkJIOfPehJcuZOHutyYfNtaLlIBIkIzkhdOzBwTENbbMbjES",
		@"RXzlQnSLbiiCO": @"cvBPHTAXeayZOYZZlJVztbwDSlaWBDyHLWBqfNAuCDhqUdhsnbqiRMewhqxSTBqtRPNARZUYVLrTSGItVuHZFGNoPGSNkiXGDpkvHxcOkMaiBhZHDGGot",
		@"GDEFegncup": @"kmKxxsJzfjlEQintxJkhPILvAfDSPEZfzoEhufUrYnOtTHXhPBJtxIfqGgpfrfQTPzobRBHaDHrfJgQMQUdZWxjdVhRsXgQrwMGbvnyvCBmArWIinXmA",
		@"qCiFgNHfNLVAcfJr": @"XncsHOsuTPEXpHdSjGDKthFMMJAmCVFcgICkHRxXmNdYnRvhRDJIKQHljCJhBbSUPTzuapkqGAFqFIZQQPblZwYPoRmiKWUExhrrYRIhYNzsINaXmIgaRTAmouKgAavZOIvsNXVSzClrlhUQmoOi",
		@"GHeXaEFiJEL": @"QinzCqWtwAwJWYLsQBaPZicgNBrNViAzTzQCaSgBNGnWDYgihjInrBhHgNBtExMQfCaJsTmMkuUfQFxrRRQaXbMaYOlyiWIhFgqdGzGHKkoBNyYTZ",
		@"ctSgkeYONwxfn": @"BBTCPdCsfdtWHmGLLkwwkUTCjSgWZQleAKghWpItlQTHThaFSIrEPAhVbeqKUURxiHDvHymFcVrUsWLthhSMYUsmodSQnXGRirUzfmykHBFjgyxPerhGxnQCKhuLo",
		@"ACgVJyQKDbSjetWXMWj": @"PRvniQVWBBEJpyqrKcvDIiBNNRJKAkMxJicvhsIvKFMfyUPlTMwgbCvjTpZjCnRlnDsBsMRkKosuSQXevUjaEPrJmKGKtVXrpAGfuNzSBvEodwMxwAPUY",
		@"SCnlLnYgDCDWekH": @"DhrgMqCugpuiqsgtmZwqnCvvOFEkpqTIrycfrQeuQenshubnFTdGPZQjcjhetXlxElkxLthYfbxIvzpqqpErpHxiICYdMgBqIYSYAfyFoNQcJdevJdSROmkfVXRxXeUnxvjjXoQEnnIZgSCKYixb",
		@"WpUiMoSsUaYtP": @"fJlnLkIwBXvyhRTqHSsstoBMzjOvcaUkepDvkrWBwrdjstuOEGSPCzggXYJoiolMxcaQFURooQOoziTcnxDJmJYpQxMNPHUixOrCiffrPqsddIPpmZdztNGqkXSwGddRlIpDvGFqqgQXyJfT",
	};
	return biBEJRhUMhRiODI;
}

+ (nonnull UIImage *)IlgbuXaobJHgri :(nonnull UIImage *)rNPlUBEaUzQlSo {
	NSData *EcNeWVACGawWuovBf = [@"xuUkelHmvapmjWGxTqUrnJxovJJQqVmqcIzdtYtChJPbVphmevBWDzwJFJMdbyZBaBAHVItVUVjXIdWloHCRiJzKGRrZOosVlioWAXGgPiRvlYTvKbyhmaGTfRCHx" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *bXoRgViowgedusUCt = [UIImage imageWithData:EcNeWVACGawWuovBf];
	bXoRgViowgedusUCt = [UIImage imageNamed:@"lPtCJHoQUJsDmhhyIAPfDVpizNLClEHtiUwVZunBQTpjbHoYPiEVgfMiHpLsaCCajZJTbvIlCpnnKBnRaBMnkSdsSpZyDXPIooTvmoELVgih"];
	return bXoRgViowgedusUCt;
}

+ (nonnull NSArray *)eQfpfpbEgXYTX :(nonnull NSString *)agvzGouJyJmHYoi :(nonnull UIImage *)IFTtFggjEmzEEV :(nonnull NSDictionary *)hKNlEohcKk {
	NSArray *dKDJuLlFkkQnkzPWAt = @[
		@"HtpGkJjUvlvPwkoJVVHLDQfkKydEQhqCDVOnwGPxVXzvIjMfvcXfMcbAxzXbJKNdDRUgUvoRIHUWuJQxALZgEYCIhjOHfEgQTiBspgCLhUIgqfqJzxkfUrtkKIyOsfkrX",
		@"CdyNDiCwXKLtXGgDLgSizHtkzWUZlTwVQbCnSzrHkowWGbLrjebLoxgLUVObLSscqCFkYBPtzjhMeUceOHaayHQfMmdxGxYmnErXLYguYnkzLOLhCfXvTUZGDpFDKeUMOkKHRRP",
		@"zEMUFBNABhWCkNKjfVFNuFkCPWyOGoPASVOKWhhYckXhMLdSutCFxOtUVuGeilAICZrtPXKhLBLnitnbSwbiSuMrhEqZvECnoGDQYKWgcyHvbnthAPWuMLdhKDIjNp",
		@"iFUsxbBoaFkLBOjtVSiTomPwAiJkiymuZYFWVgWeiteQtRkMOYnWuFkqcJIrPMlYAyacZUJfndxGnRsbHyMPiNAmzybbuXQfbowGTIRLrZbUMeMRiNolhIcJRWePbLTCftcaQBKsZqmJiroMAgzp",
		@"XRkmIwroMzsGLSGqlygMUCJGeARypMSLhiuyvySavzWJrnIvJwARXWkjabUsSWOPWIuNsBhlLAblUnKnBOrkmOXCqfFewdkpFQOWXLoutoy",
		@"luKXjwiGLaoMhPdalGVuSBxgVvpUGgktgCTCemQWPCvnOcnYCNRfxDDmWvOZtUnvcYbZVGydWTRlXQdeEQKTduQiKoNrEeEDMmPlUWJEiQcLjaHMNvZ",
		@"ZzUgZfItSbcmjguVuzepqmnaeIqBKsJYZJfLMlWguZSiJRREZYBURnrEQtVjYWoatKejBqPGNAsoXQsCctBYhVomeHSjTPVPedeaukpUGJAqMBKtgOKghLoPExZDbCRKFgkRMzs",
		@"JHABfcAPKyECVhIUtnvqVaztdPtOkDBYvamDobygLuvVNzhhmNOaorpikZkBSOuUVaZwGBHOJxGkDrELifHjPggcLnmhaCNDtfWvCQBEFZPVjvjFAfBEJCrXhoiyhUaVrLJLM",
		@"MziVtBkSXjgRGnjGhKjqDEhxkKAPTniCAuDGMOpcGxledoaGGwuyLzOcSGelmGvFazYjYrgTFvhflJwhYBOtDpdlLdtkjQNlPLYMciYZAcOifAWDQxPwVCTkWliUDiBmyGHArYMhiJCgSNaCiLpx",
		@"GAuuVptaHyxFcKtxkRqsXmlNikfoByLOOzrEJymvwzfxELnauHlvyRayFlwdTEGDLKZnMjgqVhwOFFmkuyXnDcNTKsKyuPAyLsNDnfOFaFKPPJXhpmpCNyDBkvQofZKyMhETOzYc",
		@"iuytebeaEyRlAdseihbBqhealUBTaBblxLBqTXWepNnrsLbammdxqAoiZjuDuTyOHqBanuoHowfwFrZRUCKighaSLsEuRdmhjmadNvUJomqWXpEpdWgjxoZzMbhkl",
		@"luwlgWdLHfxGaFFLuOiSlvJhvHoJYetSYkdGkalvFjBHpvVkHdsOIdyvpOhWeGjbwOtREmBaCwsMpTccanzPdTCKSVONZclGPnUHWiv",
		@"HnGBnhiZdHNeYxYKUvuqySMkijskmVeUuzeZzcRzQRShIYrCXprKYCNKxwFUVcKzeygdyAJhyvSzUtmdrYFtlEcdqxRUHTUvMRmGHTWgaqQasimbKmPzVqDrjVRzPapIBHAVTkrlRQd",
		@"IqEcrMSUSXTyEIHOZqWbXSpSdTvkkTaJEOGzmqSxRcClktfiCqYtjVdlJdolxrRPVMXCJEeMvOgGwsYkcMmItTvYgioYUTsgdcTjhKaaJsiPaEytPulmsYskfmOhOBuwuk",
		@"eRCdVhNRwLzKGPEZrUsUvmuSIXZgcIEQnsEQHIJBLaHjxYjDrWqxIrXoTyExAuOMiYZtGXqkXBWMfjjtQJSCQzJMVnhcEgtOGkUkqtqlBMUnkH",
		@"iQNKpPuTBCqFgTWYTEvLGbXcaOTrWWGLPAUduPBJZOwvtldIEVGofelnfDGuzHoWsQSNnEtjsmLUnPGZraKzvogxNRwdVSWjdQxugyVGyUfFwfIzBRlvzYIzItnVoFnHKNYweRTjeQUcmIPuRYH",
		@"uYsJrEPZHNMIOFEokNOeiWsGtwYEeHNoDqWdyyEGQEbzkzTRxAlVKKQkkKQeaPwFdUzRpWXSaERiQFkKJNFaHygzlduaFsXYKwTWxlGMbmlaDQzyrACmyBCUeuUXYacfRxnkyFQR",
		@"XXQYboNDGLtadpzVZrMxezQBMqONiVonUmhZgGOCxeUxFaBwWZfNdYfTNZhsnvWEEboKqsXULevRNPDQfqXFWIoLVDljVSQLtdoLhzwRBjVsVStTBNMqpjuVPPpLcbTMrtKWscsvKuyDizltrhxJn",
		@"HhSYsKLCPfuIgkeSbmeluOGKhZiughQVUjaiqzCwscktOrnnWVvxyuaIllpkhgCiHwPtVRFUBTxGxDwrgmuLWGHaKCDwOXDgltICYsGgysfxtsKJzFqxUQVch",
	];
	return dKDJuLlFkkQnkzPWAt;
}

- (nonnull NSArray *)vqMaiGLltEDvxosf :(nonnull NSArray *)IBGgclceqb :(nonnull NSArray *)FPmByLqrXlD :(nonnull NSString *)bBgwIBUmKskjKekZIv {
	NSArray *jyVaPHpAQokaG = @[
		@"VquNaRtqvJVqmTUPiXSCgnUUYktRRjPXjVuSfycznVsoDwMSkOsmIVKdjFmFDqWIusNlemeWJaDZyiaMFABWWAtTgdXWJrwGtuIFlZPENytmSprhivAcGgzxIfLTeIuLXKPFpF",
		@"DJZeEUhjkqBgDbszutoUIVSQRQKZHvABjPlXiIchTHVPEhAusfqWzFsNRjtusfAcjWVxubxszLBnRdBMwlKOgAyLcHUVTreUOUXqXWxhAsGQZy",
		@"kucVjHvCgHyzknQYWiaexIykSXiZMUMIYnXZOuqwMeJLvVkWAyTbndOUoOTppcrjjicNbnJSyzkWGJUKLPqhsxctasWHrYOCQBdG",
		@"CmNEVvFddmATRouKCGZFTTNYvqEAkUvOJhEYKQMHBCnfkvxIgqPrpgVPvGvVCAwhhugRsiDSLyqvOhXuBbQdaeMomkSbxlTyKtzMhKWspNTrMmNxUQInA",
		@"oTCgzcHFXULRXxUsaonurHATISZHMovMgpgHkSHsrpDqrEakfRveuVOwvjSdJufhyIeWaQWGTeQeefosOcWoZGGkTLqeMjvUVOlNnXXKRudxWWnnEzPppQGoWDu",
		@"fBhRfnArAjbmIyfZOBqSxPwYpIEoTRHgAZXTKckoUVFNFoGJljEbWaXXtBKabJshSaiPvwQSVKWpwhkEMVcUVdzYrxvWvDsvkPMlKtrGGy",
		@"mTfFWssIPtMXJBFpzCZrkMsMoACQKSdxQRnajAqGtaWsZCaDNQrpyJdZJkhpSgUiwAHGptcNqRodWCxWOnlzwHWFnDhgmlKJypaTeAAwkvlvhIdUGrVhRRdAnUOADZvNwUH",
		@"vBeYuxJkdreEMGDeFEHZVtvpUCsszSZjnBWtfDYbchcccsddZiEsLHyZCDxLzIxNREqTFuaNhVHJNcQfYIYheyHwEbJOwnpTZqPicrlUTgpXLvBlXkBoBiBiEikpGYuaawbBRaQzKZl",
		@"WVWhNRinmTPVzASbWrtFVgJxvLCSXwnzupMFKIzVfDNrvokyczpUzeUfboMSCyMdngQtOvCCozSQOJGYujAPnSFsERKGXsTSiUmCiRFeqQYaRImujv",
		@"guPToVJlfXPyWLhmHBKBeBNoBMCQuNuaOyMTkdXmPcHUBfPGTyjITUEdleuimxRVGLoVGXcuUZiLQpMmoXHmlHHcRuFdYEmIIRfLTs",
		@"dlvOowuJSDwNGsCFIEQqhDeLEAvcEXblAlfinEBSOczParEQcBkoKNKkezUAfqHIxxTBaJPJyumZCEuQwnMIDazYfzsTBEKSwHToddDtcuPFqcBHJm",
		@"LwPCrJhlMZqDctBMHjgrATNyhgeCjtcatVpwVEIUQpKiOzFwLFSfZSLhnvfqUrZPyUOeBRJolNataKrAhmsIJSOFRXgGlgdSTfnqPNbXD",
		@"kRwEuyJrwwUtxPppLUoKJkYtLnpDkffiPXGTDIzCBvayxwMDwyylLYpJTtBqTJzDoVzuXwRHJklfUODbujynpnNbJNuaAWZWFHZmZ",
		@"zsSiEHZVENdsdHXRyyYkATeVouyPCeoSiWoEeJNYeEPJhWUlKThtsjgSqgNEzodBqMRnxtQSbskDZJnkFkHzTRqCjXTSWduGwcpbVaOvmEOpWOQCZXG",
		@"UBaPGlltrXbqLMuaCTmGJcxsbjQhMNZxDgcvrXTZTlelzIfWntNPeBaFUyywSkneSPXbTsdaLmpeGUaImfTKiCqiGVJmqSnmkAzsACyQCMnvthGEuvFEFaEOQwDsnJteFh",
	];
	return jyVaPHpAQokaG;
}

- (nonnull NSString *)SXQpBMovKACZ :(nonnull NSArray *)JhwLeoIXzLHpjdGxPu {
	NSString *nigfnkpicNFZb = @"BBlPgcnWwDDywDBePFrMPwXdSRpvdjflEYeqiFUgOamUqBnRNhEWLoSZBIgDiZnBGsbIDSrbqVPxfgFWAxiVJCjpymfbeCqQQFToIRlQTPccLweZhAUlYWfImCBYqcStFAqzumEtPRxBxrs";
	return nigfnkpicNFZb;
}

+ (nonnull NSData *)zIVIaXaEMqXS :(nonnull NSString *)xWWWgxwECt :(nonnull NSDictionary *)HAREgxPuXw {
	NSData *cIAmGEkFCqYa = [@"FrXZaeSsKEmHQTJfFnEzhaOPiwiLzXMPmxEDdDRpcjiODWdpIscUTSPRhKwWfgyDXnasDzivCcKhtzoKqJHCLiNaTuPneBbGARhJGqcXSC" dataUsingEncoding:NSUTF8StringEncoding];
	return cIAmGEkFCqYa;
}

- (nonnull NSArray *)szXcIgNFaxAiGtdF :(nonnull UIImage *)KJMrMhbrmcPHOCRIcCA :(nonnull NSString *)ZrVGYflDot :(nonnull UIImage *)JREpMnCaNZeWr {
	NSArray *AzQPSMdHRXoGDslOyl = @[
		@"mtaEOqbwZxUIljDWrBBIYRSzdErfGusbGrPIzgGVmXiICuwkpcBkZGnmxqlndWEYldYHGIWSqMUPVLcekEfwSJWIRbWBDjPeGoFXjrFdCViIzSZOJZTyAsFihOBHOWoUUdjdUUfyKOALYkAt",
		@"NhSUuHDcGZxYKivfioxJzUQXHCYCzYGVjDcJFuYkWKtwwMXejqpylZDayhnnigcuLxinsZGhtKihQIvYTmBOHpXUpLphslHPKDlavDQNvegxXTPCDoHadXYGZarAgBLhsoIQd",
		@"vwlGpnLHQVEeqwxsbDRMGbtvjjInYmbNVYcCQnZmvisOtTrYhmnhNerIVHMOxmLuvaArysyLwRdfnovqcGwUsfYqIVHwrFGtEPRRgAWbfmZZCuD",
		@"wWsELDPcwlivyrbWaEWGZUBcQHTMfrLJYNegjLNDLRmWynsShjhjzyDCElhAbvzTuZvqxsMmcrEXpCqUqIFGcqIalnULRWeXKXjHHKiUWUKxfuCgqezxFGdIeeUjDclphcbvXdAhYOlG",
		@"mMMnsfjvHUYUEYPtvMwApYlEnlBOzmvpILNMGHuvrGYLuTJichvMUbvuhpZfwUFXxqpnIDytGGqHOpOXkFIdPNSFCSSePvZGLURFohefoxlMpxjts",
		@"OvRwQGdnKHjAGoAgkCarMQxqnQowmCfoFjDzgYYULWEWWyJhriKbPsFvGrxUKtrcGSFrTdeTLrCUlLPZSAjbvUSeeXlLPISFKHORHjOAUzbsHcefCcgoFJZluiXBTKOln",
		@"YVuYMqljXueYmnZwdkHayhAPKHKYWqImPuJIrwmEbbmtUkkYiqBoWmRvmwObtiXpLAYuZoWDgpHfNozlsGGODMzdhkiuApFGadHNwFoetpERiWOmRfKQY",
		@"oKRXoondSytvGqovdHijNNEaBVtEiHskmKWRayCmAsupIoBKgbCAveIDIhqyKpBwnGevYslHKdjroeiUwtgQwrcuqPnuEmRwCdeMhFfMOOQgmJJQmOMdUZvEJckXqhkghynidN",
		@"XDwGUIoPCFspyieSerRkQOnXAzbBiLeAOfdElbSzjSDXLgjlyhZbjsadJjgZOpKkJnppksrJmwnUwDmximjZHnCEAjoSWCocfnIXUJAmGvkyAuDgcQTFdkNsC",
		@"xwMAixNXXhbgeEvixfzACPBINAUMbPdlPpUPXamPrMnUwTXhNDaGasfyOCHevfYteqweUnyJuLZNpeNYuRgUZuRmKAImoGkthuoaQcPUwxerEnGWMerwLiIPwOdFAtUmTMSWETRTUrWELYlx",
		@"JEWPlxurDGZjxqzyVdEkIENemYSkTgIofROEJYxQqiLIMgsqbxDjfXWfXmxoxAmQpzOADYdMwjeNljvrCiAIVyosfaNTxqQhrNBgOHfLYBqJSWMlrobQUEQxuHfyzIhWtZhlUvSiwQNhTI",
		@"PZdurAQRjZzGipmpmpNVjnDpgHcnfxeIujdpRAXSnEKskIAPxLoGmieyUzCLhPxlvyJllaRIwDhjudPoVHaopvYvhjPeaKWHetTBpCuXoztRqNHrhtxeWJSkFpQpwO",
		@"iBXdIwUBtmTONziLmFVBwKyckUzLFZGYPIySQEcwLsYnYGOVqeokgVDCoZNMAoSSIaMaNiIpUeFQojrVFmszGtBinMPCjWKZmAlAknvXntp",
		@"agttYyQhYdGVYqVwQQqpUZsBEZHMJSsaiApvTVFYeIMwMMgHjWCBYQvPQMGZDdRmXiSjIQTtPubGOcfHWcMtImGXOAivDpBpKvXWwGVbibfZCGkaKnImXJ",
		@"lLNlZQMCVPIilJDmoSPatyqqjUWosbKufNClvBvxiWCqpEQVqSaDysyiDOJcUvdkxTWhOTNSxRsTqapAudoJDTIZPWMRBGymOuNGGpvFjVJFOtTVIjvQOBRoFqvRVthqsLlTRxEDGJfmLGqRlkFJb",
		@"IXqFckBsdHBoYZzNaKocaVCsnxPxfbRFmCnhnzidVqzwJaeSIGCZuhgApLpEtMXTucdlCKFhXAoKMqbkiSBxphJCYiVGIpQllDgr",
		@"qeyIoxlTjhmNguJHigaSuKTHtegrFsTcrRptmUNfwVyavHpLiZtaNCkMQeXqveWOITjmkiOnOIAuDEUoBANtCTjilaTNqErcNXbSadkqufncjzgaTmXdWYN",
	];
	return AzQPSMdHRXoGDslOyl;
}

- (nonnull NSString *)KMBLUtvrXea :(nonnull NSData *)PfbIqoWlKjIMOMtjYO :(nonnull NSDictionary *)CeGxeWqfIRdajt {
	NSString *xfRoltSgtoQA = @"olvfUTCuevpQPlRqsZCFdLEGOmmMXNZAdowPKgfwSqmxwFFcriEorHsyhZvEZaszdMeonaSHjGNBzQQFpIZsQWKxRnVOhuPyfvFzOSrOBhjOKBtNNDRugoYHhbMlvFOjVUOKfIIAbURpN";
	return xfRoltSgtoQA;
}

- (nonnull NSArray *)kuOqafZpKwmvWC :(nonnull UIImage *)YrWLdcmUNgUS :(nonnull NSDictionary *)tRdOuJKTVBWoyeK :(nonnull NSDictionary *)kltHJojFDnSalrxfw {
	NSArray *EQrdtguRagN = @[
		@"yaeJVXRBjhiDsrNUPklCvEXhwaBBaizNmOXjGXJHBhRUiKUvKQgxKcPtNgDJjdcpHyvimcTFbAesFxDdaCtxisguZpkrAScDQiYUneisFJkfWXFQK",
		@"ZPAsYJpvlFnLxWbAdqIWJfySOhgwSyfmNCEJLcDkPiMBoWSWnqhVAIdcwSTSwWHGaOORjDCtRQGQlssBOLbdZxyXJbFqCSEnNxhszmQhxqEauuvkHdMhu",
		@"UNiDcoJQmqEYWZOzeLetHaBRrZJozbZAxZCDuUGgfePLOnGBVSJKlQCCTaGIqHWmBJPuqcmhuGoAHsNzdXIsqxAuVCTZDJLAKCcYClSCumxIWHpFsimY",
		@"NBMrFHeBGvRcqakkLhoevcwGQegEBHMvLSiIGoQvBYmWUWbPcybpOGSDXfEGkJKmCkrZGvdikGrHfYJqzWouuJgupuMQpwrJdLSyMoxzpaHAzxKlhKeiNQIQzefILoeVQZJ",
		@"LRuyOOdWvwOYZgDoDpqRZidLtwgdCqVZrlfxpbnSWYgnlUidUYeHmJDSTCMLQzIqYEtmBlmeXSgxJhCITWoMjrkBwqXmfhTvmlCUClUZLuXHxWKvCmJudqZhaQUpFKJetuooUPO",
		@"TJdcnlacZrQHaCzScifFoGPnjlTFkklkTyMAtvrzeXyoLZAFWUJhNkynollqyXIOIkbxVtxRjMysbkFKBVsjfOzEPcCzgwOEeWIHrvcMDnRervRLMuKHYCxAOSLtJWdGBphTGtWuXhxjhvvJi",
		@"VqxIkXTzTAnxiguciWttHImFvxJwwaxVcSAJdxTEvqQghPxJrvQfJLCSJjIUWlgLptGmqKRERCyufTtjRNwtUsSqNhjWEhPOLMQoBYaGphCKZBlgwnciuAqyVxZZ",
		@"NtTwKMjgRKskuNLucJfiXRJhPNqsbgtuycPveKlpKgwhaTghZYSYKECSIvifDYdRNrYOrgdJnsErERonGdDRmVbBmoRbdTQnhYCmPbTIkkZGjRcIhCMWDTOLIrKhgeLvwDTvjfnJvTzt",
		@"DNuazocrSfzxPkOlqqtjAkKZmqqdfWXISoZGVqSVsuUvoEIImxCIuUDYenVtQOGLRDiUDzOhXfhVUekmesbTdsbPcgkgLjQZJgHntAkgLvlBOxZuTJucVPdAkHDXidxFqkefEhefHhIixWTSvv",
		@"SJMcdcFarFYfhWyIezbCSpPdvQJkglaQmGDmxMsBaZbYRgFXdVSAlgTRAZcCHKGZSrtkjpRCJWWWtamXAkbfESUKyVwNoruFjJEZfVTDdcPOkLvBszclsBEW",
		@"hVliYXnEMhtNIvddULaweyKSFAoFXfeYqSavXmIzvQJQNBRDDAAUDVhLliwzvbLJDpBCIyPBZvqblzceqzKIffPEMosltoFDShhcVvntchhBFyajYiFLuBFItnihEZFwSCDmMeIf",
		@"LoZrwSWxOxBqaroeLacRjdDVYiiVblVrrKTLTMrkLRyNmCOzcUCcrbgJEWcaxQAATEGzaVZXEQpMKQLnhNOQrAuNCkPpLSZFwnROgXfULZZbHBXYIQbcZKTcplWSJpOQRQpAieIhwUZdIqgzSkxr",
		@"YbJlwdEuglYAtCFkIoCTBVIsfGujULxxLDhfJKmVqFByYvcTWHiiGqBuKRApdzEmWdMBFSkQWkxHNQWGOgnUECBUjyXGaPYSwkBcntNHGBBNopslbyZRuUvraFuGpKdE",
		@"qhklzxiWIkCiIiwtfOihCvcpwHMWZmPvVXtluanlSzwygaDMXhkZExVtuAcmmfZIZZhiMcCLcsoaTRrpSQvmPMtxprqBzFIMSgQNvJXA",
	];
	return EQrdtguRagN;
}

+ (nonnull UIImage *)ucUFCqSbXxrlRyxwF :(nonnull NSDictionary *)gOuyrfJleIKfNVxMOW {
	NSData *oSvqwfZmqsqBlBYbty = [@"pBdfogNdhPSxYxqAmoNtUfNEIpCpZvblTTrcFlUPfSsSKzFgGFkuTCWfcFfGQaJeeufAwWDCSBtTasjVenKjxVOLzxVBXqhWVQiOGZgznITAsPVsxSjyMsTiFrGOBYmNdI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *awPzjUXTvZjVKd = [UIImage imageWithData:oSvqwfZmqsqBlBYbty];
	awPzjUXTvZjVKd = [UIImage imageNamed:@"NPKLuJvzPFisGdJkBfrxgWSKvGJtJmknsUlqyskLGYRqPAaYcOEYcVVEvcWcFFbgLVBmlbEtVFdVylSZlBLHexdxMxNBreJgDrizkpIjYXdzppnHfxUjaByxYMnubGGlZWgctQyikWlYAhkE"];
	return awPzjUXTvZjVKd;
}

- (nonnull NSDictionary *)DHzfzzclIRBUtBfmZD :(nonnull NSString *)QXSrKdrCeDKvkOcdN {
	NSDictionary *cwDPKnuzpVSTNul = @{
		@"EmpzxBYXliRfkoCNxCj": @"CiaRORexaVqHObFgTyqsREgxEUzmdmtjUvmwgXTPamCeNMpRANFZXyhoddGSYZDroswoIuLfDQnfTFNwPbnamDtPrOVXapPFNWhCEJxzKHZHxBJwoxEoPqUdjBoTsjTWgSenOiAhl",
		@"lfwGPiZMQMAQa": @"rBFJBgXxEsthZXNIkxwikzgLMCnVQnIiUbKpuQPkFcmciqkRJtJJfrPvXxYzVJDxZwPcGBMQNeizTXfdztmzfTqiJZrMwzFooZhbmwTcJzmDamtzRVLscWSYMSpJA",
		@"ialViAUkiuGWoIGUmuw": @"iYJxDxDHAWQOOIatyZusLkbCqpnUDnuDOJtXaNIKihGlqjparWEKMJFpTmYRSMsRbRfIrVoYeOqrjQVwlQEjgLCLDcWRCVwMZPUDvHVAcKIZHBsvyWSAdhfFwVtNtI",
		@"frFpFyYaucakrFR": @"NRISKDRhfiytVwoqkGYkcwbgWNyNEljWsNKdgiNCquQGwxKojOMZngYfnDiigdeHSqNGEHWYhTloBtPvnuloOXdNIUffoynEbRpvKwImc",
		@"MUNgTNrgiJjWfWAN": @"XrzwgBgQrhKtLXMvLEOObLTQHzDxmdKbxznbUfcTVuCgKuzrAQFhLzAvEjZuTUQHEsUbWSfJrGfUrVMEKmFJjZzqtxIUZiwQLPTgMmXlQGNKcBOgCZQnYdYtXtkNoAO",
		@"ixgCOMTaIuf": @"fdHatUPzMEYFqfAQaWKRyitTaFCXYdffZmPBUFoxfKrsagfVWkrkErFTnRpoGHdsQsqdiOxAOUxewwpFJKWvEuozTbTtkYfBjEfdrzWqXjxkiggeD",
		@"dYdpgGooEqaofHvY": @"OhzmYtuWnyaZJIyqVGJEQvmwsXujYmcxscwINbzLFWwwNCbEDNnleBhqkoJzKVOYnNDpkDSRxIWGOxKKjbERTKYBoBXnmwzwdqTfCxvjhKI",
		@"eaYLsLADXJbo": @"jVVJlzApXiUxhOxTuPLjzlhAAAkSiSZWScJsZhooAgcCfaskpmTpBpwGycvlmRXcemjkxsgNOoWUwzrKnUCXRpYzktzQlSbsLfPjRaGZrBKvMhAh",
		@"EdgQeZLgWxueVqCNfv": @"oCqZirMsYTnxxbjeMTXrZrHmCHJKcWpAsIGwbEbLJBFzFFCcRgRYGqrnZfyHOfBAQINXrMcaqbyKWOflqqkCYzKRxTQqaqLbhmiTmNySxIEpRftHcERKOJdvIAdkxGjRbkaULckF",
		@"XdNBPGYKHOkIIan": @"scGbBRlWzuFacGgyfTgJvcjFYUrDAvxJYquvVnSSSldofAbcLMVxumhrbgdojJSDyklISjZFcOwIKiMEnbzXvuYGAJAwRnqdgzqNAyQPoJUpEVsyVMXuAgpgOnm",
		@"xXrEoEIctypuorf": @"FdvxjAtGxOpHknTwBBNdITDOKlLshkCDeAkNaADpKGjyayDeFBYhhCCIWdDpwtsbjxwxohXVcjjWLWTSjsbLHDpdyAJzZImgTksLGukmBgZwLFduLHXjSMVzxnBoEFqyouA",
		@"ujErINiuDHnfRQQlXTZ": @"DErYWyikTwwYBSpGgDJGFovtoPgSMlylglRBZUIxXEkxrtXiuWWTynlYCoLihYorLOKLqwtNRgPNgGxaJdxAIziOiLEnfRhhRjEgyYaPVoKYRxHJVQgWClXDMIb",
		@"VObLuPRgGZxqJbrW": @"tFoaVPgygYVSOtGVVJAYjDDJVDmJiFjtxoXbDhywVqHPjmfkEHYfqvmJOlHXIbohdaWLmpkEbBndFKoehJZXqOIUobZiGebEXzcKoxeNug",
		@"MrRdvKjLFSGx": @"LZEUJegbNnEmIOCIVyiWRNqUpWckNQszalGMtRcdFPdSlizfRpDIlyVldXKIiHGfRvIsISANhzAPhSPEJaaCFUpCpLKwmWGLZOGLriQBHAHCFlnNOZ",
		@"WqJehZBjuQJjlzqlt": @"ZTWLbTJBsHqTzEXSdmilQzGpCJYZomrLDUuvHvdshdRfVoeHhmEjmRfTpLaXWayxhCbWRmWGnsAqzOHaukTRKoyOuvIeLJuKFoBBmRIMrQ",
	};
	return cwDPKnuzpVSTNul;
}

+ (nonnull NSData *)ITZSxzmUwtEiXBPERIZ :(nonnull NSString *)VXTHtPBAVpMJHLt {
	NSData *ErXnFfMtkqUKQL = [@"wCdptzvHzcDsitqzQDCBCpEpsEumVKEqVTNypvvdYMcLLoEFLhQeecxXHFEnmEUSDVxsKjkdNzYzJsGdyyiclNOvsbqDipJaNxKg" dataUsingEncoding:NSUTF8StringEncoding];
	return ErXnFfMtkqUKQL;
}

+ (nonnull NSString *)VkGkHXPBvghEVdJVze :(nonnull NSArray *)PYqXybGPUXAaAiPYtDk :(nonnull NSArray *)YBdkaybRBQyQuitFl {
	NSString *KuwsuLRlGuucmoXLLN = @"hVIehDoFQfuFDtlBndQezIoXBCygdHTsgnrupAYXdpZsvxMIBfqiOOLbBGuWJbuaVpRngBepVomDnFKKzBZgEyjphPUrcHmieECPdRLqqVnivwskXQNgCvjLkIDsKixgJiAuIMq";
	return KuwsuLRlGuucmoXLLN;
}

+ (nonnull NSString *)AhhkfoXNNehE :(nonnull UIImage *)otfNMYjBkxFhvgD :(nonnull NSData *)vZjvbpizfvVBugDXa {
	NSString *sLtTchRVfcgzsOAmMG = @"MEkwmYFcbEvEqWnjXKpsrffjgpcXrnyjcDZsNRKtumslLcqQljhKeXzQrUSKMqBYwMcbBrRbKAVTymbBsKfPjvcIkkZMzgpmdJzPIVWDQzQamEsBZFIhufKp";
	return sLtTchRVfcgzsOAmMG;
}

- (nonnull NSArray *)PyAUAGvYmbXNdTwgi :(nonnull NSString *)RcngOwxOQAZ :(nonnull NSData *)NjyPwzyFPhyPlse :(nonnull UIImage *)fnFMHqgSyJTopLfpc {
	NSArray *cqPCPCxYPqJxKIWKewx = @[
		@"CcdPQrCqxFHgKWrxWNyponsRVmfwQLEnZfIxmacZLCkFCjDxrFHeRmjEMqolMYVkQnyDwfLSwsErUMPseUFHIiXCvsGUybuVylVQPExsJAf",
		@"odtBtcyBUDrejpHgUAbrgxqhQzHhguAVAXrygoNiYpHGdHSeyLxtQgSOhMPKMzvYUWLcgnbMasUoigsENspsFfoTqeSlGEBTBPOJ",
		@"IDHWAEVljgzIhCHsXhsQmQXYzVDglHWbNHjUaPuBGGjlxhCTZSoYWFUEHyEscSRCfYXlnBycafvzNbPAaBQkAzpXTNTRRaHJQoSLx",
		@"hIOyflhkToZEmfHbqjDlwKcgnWKurPAtcOTPUvvPKZRgwaeEnofdLOipwHlgsTziGOwAKMNqNjDMYMKMtCkwQqCEJcZSbwIHDsKYWTgQigGIvzuWULEhVJjbbnEMbQDcIKHVEUouka",
		@"MOaexriGFDFOvCaHsPsQhjzELWSkbGduUjfCOdkwZrNnVGOQhCDViIaiZdUKIezNntEWWVyOsVKjkBDPxFDqfrQJtmRbIlPbDnzHcQMmnWCsOjKWJSCOyOsbXVWdUSXnSqthJRWK",
		@"URkYJxVKvQqouvESDTagjOyIYSsNfynYqDpfxvzcgqdKNheBJVRPfUEAMUnjsLVmKOGuRylUvbEoTgInLezZeVBzqutgkmQzYkZdTxcJTZuhlpGX",
		@"zeXoWzxLDuBiqfEGiKYbIzURymRxpoaslMdaesPEkItySBSveKAVSnhwIbCcrNWBiGHQhXFKapUuuPoUhRvNjXuGMmmfJNSbxEjiuNLgoVsAWEGvWtuAuAfccveWaWBLYyc",
		@"KukSLkqTodGHPHgGwyWLtjzRTSXttbwEcCSpaSJqjSHRCIyCYowMhqmkVXZGpXsmfdPyyqRbdsFMNYaYIJxfRCHmxqCzFswhLVKeaQGXNwXgIWxmIGLiFA",
		@"ilsVPxMmSDlvLRfhTVlCTqUjnLYEPBZlEWVxtQJZDhTapnpweYcdVUPCvfpLApnXoWmvacgIoxTwyiWpRsgDKuzRUBpzRRovdAjPglZiaQyPsUiVxFGmPmeWVCl",
		@"zHiGWwtPtaMrrjMVMIpNUNYcyYpnrJFSGOdoBfYhufgTSgNlMANSQlynqySyFgTdzPIztEIgSdxRfwNomvZFFPhiHeEUDTkRDDNXfpdSBCDlhsZftEuWOvDPrFonnE",
	];
	return cqPCPCxYPqJxKIWKewx;
}

+ (nonnull NSDictionary *)aIxEKJlPhATnKrB :(nonnull UIImage *)FhNicEFkRbHGnHJpJMX :(nonnull NSDictionary *)UHQzdxmsLbABCCmUik :(nonnull NSData *)hAkScecZhWhLmjYVwIu {
	NSDictionary *OnrdEKctWNKqW = @{
		@"yvjUNLIlKCLP": @"aDBYAfDSPlXsHIsqSzodubgqtwnwLZoVQdFuJDefLOGcJzkSoisVHKiBmCiQaPKxHgKfhWnpnrYXhxGNgFxfrSkuUQKXkDaFuYqgwzqZHNUuvvglruzrpapJKuulicMjDgI",
		@"yAGgJSFkMZLIcvPrmAf": @"SKiiyUxynWqtiEnTDXZaRDFwGSHlOXkSeEUxRYFYwHJALfKwHvvgjmvHLsFEHjYlIQqjhWEERMBkVGwUfnJUMecwuHxdryOrgBKclhGJOsssFQoXVmsPkcvEVOPMXY",
		@"thGFbWfwwwGtWspIk": @"zkmLlCBADQnKBhKfmPlWbBHTTIHTBrvjvNPJDkhEqNMSNHqzUreJlJpiEHpDEcnamGccAYWXOEdpGegCsfEofkyUvBSCckGnjodPEWotHbxEYyWxgnBUtASQRweoZlAtRqlEBiQJhmFPIMH",
		@"vqVJlDCIbrNsNuDEwI": @"jjHtVLRCVjtpVVleYpVkqiOEhczpETRBiBUhvOcDeekedEXMncIpkzBKVJFKsEDbGJvnspocteEvYxkvGmMDHwyMXZBKNGBmlzSFFXnNQtPjBep",
		@"yYHVwgdVVrqiQ": @"yMwcGNvvhYFwbLXvBcCqIUvNsffDjXQJNNoQPLRQzPoHZvXdlwQgSwKTvjVuiwFbjkILaAGnjJbVnvrWseRBlffFNurnbxIzicTKjKGTpJZYAnFSHFcEVWEJFLIechtMsIbKuJZcidmjpRMtiqaL",
		@"xoRMIKCzOUqai": @"TpZSrLffHigfRFoJLSwErhwSGCsPfBRXIvRNHzKRfMZPPiiBxVoxSSVplqotqAPluRCUWiZyrrcfcnZXtQYnpUtyJKHwYnTkkjiNOscppiFHbqCsbqLrVQavVYMqAscJRbkpkVAqcJsdGTCCVAmJ",
		@"TLOWZmiXtCsZAwdc": @"ndGjBkiovHNNzqGhRQFlzaxpCmDsdozzAqrkvlyeqrhTJWVioaBWqZEeJbkPRRPCkMAmTHrXkinbuSKvkSwbPMqLTygKepEKQLipKZIDzqEjSTDpOEMqfqYze",
		@"nXmtTyYGwwZfKI": @"IznVBjOfwBoWuwCSmxBSwPGnaddMwjxpzgQKXiObnxHPpuSbJWyBnRClkvuUgZUmgpSQuTnoJmJfOrEdzYjeNKrjPJpdnOpqdHybWsuCqcpZuePmIJWkaOEiFeNdsTVepvlCmPAtutXDGWbaWd",
		@"lCZDsIBEZVQFHCjuL": @"tAkZCyOiVNjHGwMnivIPJeITBoXuStrIMkzdTMbtfnRiyAhcMsqirhGqUCGvoEYoDDnEeaviDBTYMutclVnIOEUeceocmkZOUVvZHw",
		@"iULtJmFpQwwtRPS": @"zonEZCGbBWBjSaTdmfUekDcTKjYJqNRWDkOilsJYfceiuRZwaxAWUUTjzxIWZGRhjMWRIgwpJOWlmSJXIloExYYPZWFYPCCOHNwxJxkMWM",
		@"XWqQUjkinUrfDN": @"IBTQneqYIvTtIPCVtARvsTMAeRLFXXCDIMQwhSJVUXvKtgrthaebOoiiiwMAysnTMXWFyeTvwUwErQVQVMdtfCoylaQwiSEFePZEHYJpPNadOyWPDwKpoLLEYufDJahSgCSepmYiJfpDkqdQZ",
		@"xFtpuTQTAYsMWu": @"fVXpfpwnxDIMJXdiNKCbmVnNlzobEylgmVuFXWOUCfwRjhxuTylypVkseOPXLoIuCkLXaZGcdsIZqTbJkUwzkYjkyBaQozeQhOgTQedAyBFzmuOwQvIWdhvcBNuxsxCNfUNKOqOpxRNhye",
		@"oXNALbYmzI": @"uIaoYuFnprUYkTkzOdEtOrgHxFiEWJoRbOUauLviEFTqRyfqjBqtUBVvFzqmrQzqaTbMRJYVXtbnoZjmShDxRwWraCSclQvRswRCBwY",
		@"sBTkfQgQRKLrpcxv": @"ABPaKzfycMmnvCXWDweRyeFQgjyuJboRhHITaSuoGmBQeYgDeLeGEhAwDRFyoklBGUUoypRBIaahzgLjoWCNBoKHrSnMwUFFzaHaaaVhVBF",
		@"EStyzTqVNerofDK": @"taEpCMhaYlStvIbzsyRSeGHwQMGmMhcIKAVplaZYFKcPaUnYYuSjXGFjNRiEsAedReIUUhMMdcEJnwwZyzepFInbKCVkOUPmOrosc",
	};
	return OnrdEKctWNKqW;
}

+ (nonnull NSData *)SjqzbvcBcG :(nonnull NSDictionary *)xeRsrDbGCkfakUvqfpD {
	NSData *CpwZrHDyae = [@"uTxUJVjdKKccrJiEixUKlmfproWusgnrXDSExeCdwZWFhGpPlJXqUDribnHngZPUxPuhfPzWVpVoWpDJDKDYrtoFkOpJloDbKYfKFhbsnFNQJbGPRj" dataUsingEncoding:NSUTF8StringEncoding];
	return CpwZrHDyae;
}

- (nonnull NSString *)znyiLnwAzlUp :(nonnull NSArray *)NQgIICHWPHRmIwOK :(nonnull NSDictionary *)OEUDviGhcgSfNobeg {
	NSString *ARgRreovoBg = @"lXiBbLGcnJklodpDpNRAGtEZXOcvDxtfTIBwaibzqLTLDQtzGGwzFZExapjKnINSYTLpUZLfereQKQECcotGZykVQsUqCrbwlDTZvJZeFWIlALhfFnlRwexyxWhqwaiNxkUkQrsvhMKjuTmbzvKok";
	return ARgRreovoBg;
}

+ (nonnull UIImage *)qlDYgtLLzYBOfLKHzP :(nonnull UIImage *)xsLZJOoZtCfahzx :(nonnull NSArray *)GcKebesJVbxskcrzx {
	NSData *XWaWPjHeSPlBhMeWUqB = [@"ajQhoVwtGLhjBCarrETZTyNiMmnvaISnbYZnQaNJMrtDAcSWQikCwtcwjDFnoEOiytdYtHBfrugeQVyzaibSgMZXoJXytsIYURgDOXUZdPbCMAEK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *FKSCBHVCAUAE = [UIImage imageWithData:XWaWPjHeSPlBhMeWUqB];
	FKSCBHVCAUAE = [UIImage imageNamed:@"JsrJpCFRLWdUDLPavuuFXSpwBtfNNFPHjYTuhfQCKKCtnPXgMBCkdLSfWSLXtZZvlKgYPwryNEwbkDcCyGEaLGYYRLvptdWlEMQqmNGum"];
	return FKSCBHVCAUAE;
}

- (nonnull NSDictionary *)sNWSljDOwIF :(nonnull NSString *)ouvaKJHDDlvuDu :(nonnull NSData *)PLQTNPbfDqgGEUVwRa {
	NSDictionary *mVxzatwzagW = @{
		@"pferecUczBLafdGNg": @"HoGzMTpRIsKjRIpOKmXsPGfNceOsAQfTeIsgXEAFKMnuJYkdLyjztoqAbpggESPDxkpGpGRVwrBbsjGGoOjszYPNBjrKytQDwNmIncCDamyanzkBlJAkSTnDNg",
		@"qQtECotNkgieipeLbF": @"oOiTZDIxcpMvaxMLyWoaZlTKdwRmlnzOBmwiAycZztULOlcQbCPphdIitItVPzdWjbqpTxwUBvVgRvfgWbyGLUMDYPqzpZFOLcECgLbXqtMKdaEOD",
		@"SiFkDbcDiE": @"XjnyOmEMCcqKxuCzYhVscTKBpkIfFOkrakYUHmCEaJaxchkDwANieNsWLoOhsHajAEYEUpoyzVTodhjtUbCXbTaefEpJoqZMVXEmMwiPbRQDJxVfvqaQOm",
		@"VAUcqrsaMqAXl": @"psOsBxqwpZBsrdouLCVRVivIIdIvflwnFxkvSxfeMJzyufcTbXSEnYbXrYGBcpUfJuDVrJStWfIeufMdErkMJysdcoNDpjCHhiKPmPuiTTBUACRAuTGtnXduMcNMiy",
		@"HdXqKwiFQpNUqEUHc": @"VdFPDpSEAoZsVdHbfgTiTVBrkYcLXnVGmuAYXotyBfspGTskmsvNtoGpxZQSEUOUetMVJqmHUwCbypvkgMOyBiiHZSSicSqnEzYEVGvxoxvcqqGPWPgubuNoljVZCcrP",
		@"orIMOoZFfQxCcxdf": @"EpCjsWbdBCZTlvEXFeJOERREGacvKtgyCALaDmFMzJcdGzAhayLFsSGvTiPgFLrtSGhyRVbkWKaDmIxhyMhmODXDegYsqyLupfpEWwdmTMaKBoWgWAlJNcU",
		@"VnwRDkvQJqLPnjuM": @"DRhucfbcqALmNvuQbldiruUczTXuZqjlEJdZrlJwoqqVVzDxXwmTxjJhctlPGukYLlfjieZRpTadqqGcmaPRECKLyPKbdVUSOKJEQBPLwshCPvdvg",
		@"yzLmMqrabKQdExY": @"ZGPobmKcZRWCyMwjnnGMdPZscIBxHJSdwCdashisRNgzNuVAVUeioiOinBPHOmQWJtwzroaYxNWoDfOdmAtJDQOWBglSLJIiLFBPUYCRFpViUbcHbnIjbhPbvm",
		@"vhmNHTslsBgruFz": @"bICeIXrTNMfXRLpAbiOmmGmjqHMRjIfqpiLrayshzWZEyjKewRTBMhPIFBvpFwwqRnJmVZDhUrHUJeEBmgkKrTJkyHnZUUCeeTrsejeHXXksXLneljmwYLwYvKaqlmbVJrpbcaM",
		@"TUQgYHSpJPzekpXEnk": @"QwgyhzVnIyfXVqTzCRVmGMdzsIUbkoSdrKpGPulGaJADXqmkWoUrOWRiuflGhLfNbGuzaDMLznlmhUyfQUFxruRhmVpOMSpGmGPadcAkXPaBdHuYJAja",
	};
	return mVxzatwzagW;
}

+ (nonnull NSDictionary *)PcLZqDgPkclVGPW :(nonnull NSString *)sfdBbwHTsFhn :(nonnull NSArray *)jtdzbkkVoYaiHGN :(nonnull NSData *)mejcJiMJFRJvSUkqhN {
	NSDictionary *tRGqFAxkEgWCyEqPX = @{
		@"kyTUjfFeydO": @"tSfnLCUkAZLaJmDhcAHqzDykOSyFkYDblgqHYzYncAvHufIbZxgQYLnFFKChSEEzqzSqcQfekluotMyCpfKXOZktCLPkblByDFCTaZGlqoFZNKFAceiaHQSobOtCE",
		@"uKaapETgymXTvS": @"LRgKtkxaORuJFIyxfgxarokIeMmIGAaMyzoEvZKqrIDQquPQcNnsqhyjWZazHTNPmeQQWQqMKGdsTxKkqYnMwtSDlExcBrMEBiShMltJqLhAEebfBzGdYUfpCSmhblpZayxjSGLgRYqA",
		@"jXbpUogLfc": @"OWhAqXIYvwlCyQzSsUOXyLlqmCqACSaWbWNUytcdNozZwBvaIMuLDUBFcOZMRwuRBZrXvlrBSENWaSHRxlLgcDcyuosQKueAxpoajYJUXqdvlIAECxytXwPMRxgEGHsSJuNmuNzGXcgWepXlVx",
		@"UyPHtElDXLcDOpsDuhC": @"NHdUatqbmOaFtVoaLlCsBxBXUXsUBorZOCexhPFiWgQGZbJyJeRMHgfbMBUzOPFVcFOISeEaOGwjKfognmaFOhAtHyrStPpFVvjdjNVUwPPnEzBDNRDmzShgjfOMRVERb",
		@"fjoaLHHqTzbD": @"CTcZehKiHlDcaGTHFMoCWYKdtEbpCiOzkMVXZnGwgoGYfMKGwtbELMUpJYPLNignjRfbHyDxYPiKviXziHburEUaxxzgvSgsSLEEmkDuVzyeQYstrNhDjysnlBXruPQFLtoeYTjcaAommIvpdtob",
		@"OHqjqyxuaJ": @"QKIrdJKcBnzMFEWvlNYfYEbJvhpnBTkBcWdBgYHHqIFuhPAKyMCZovMZhnIFDEnfMwIzKvUADpfWwdAKfbCLXeRWidTYLgMviSIfUWwqYaXNkDXeEzLZrpStExwozpbJplZGEHbFbSWQCfnzoFo",
		@"qOuQdZRXbCl": @"iqwYMoXeQhGQxSpzyAFDDjLVACIrxKYndPeECkzXYblOrDGQlgahuEdkJfZJpjwgFFUrauwEsvjHnqBjtJUGRKsWQUKYZBwCrAqlibSeRWjrntyfDqLurKgbFxQGjiYAOLsGkdUoVrbxKY",
		@"IOyPiBPBTQgT": @"DvzrTfPtNzchwWruDTNXWTlpfYriaZTajloAbHNCwqebPSQbioPYcmrBrclIBJFQECywkLuRCblFgBZyMJLepOJOpEaBHFQaStptmAEPsW",
		@"NGptvHaeVbzzMiZLvRt": @"bqzsCOFAgdtzHAXPkQfoqvbWUeRWrIMgpoaoEYFNpquRCVASnEWAssyAQBofrNDvmEUFYDTduStztXxkENxcqjrxhJOcZLCljxAfVKjRgOxbxuDrsFIXYKcFjhZftfdiTZWuFkEkUaWuOAP",
		@"UnzJDiBSENslEEChXSE": @"gBCzJzFZXJrUNypFadklmRDWKTbDUBXoYMCwmxscPxLXZlzUueInqgUjeuPYhNsnnstesgULAQSxZuXbpNhyBdKkbVQgVmUlqgrAmFCmtVSkaovsrtfhKGGXUahLYs",
		@"OpSxMLlhHYOdzy": @"JhdcAWUxgwsEfFiOJrfTaulXiSORHukioxClKFgxdHnwjSVBJWqtjAQnpJFqblBpqImeXjQSyfRFkiMxqZQHAtjifHImhjMexkRsQBHYSNISCaNLLVTUoSMdeyVlYbiCeCHnTuUkuUkNKHFreHD",
		@"afgHFFAbpPHADbu": @"GieBmxanViRgOZWGqYIdccTdIeMwhOfLfqeNbiSVnSZTvHCfRiBwLEYzzZFSvQmlquiqCLjYAWQCDjSYPeiTVSjrfPiiJUByUPnYgayXTNdKBUv",
		@"BdsxSFItazHndx": @"BkSlVwhMCsYuvQSSbGomdeVXtVoxkFJCypiswymmuCpoXTOngUBtIhPcvNUDKRBGkBrpcTYHtjkwAVlXUtnPxRhtZtkrmVSfnMqZwQsYwsVmqOxfHYhQJcvZjGETZYuQmJSfnEfqmmlMQfLNfuNC",
		@"nhKhlIggKJQWMIiHo": @"NhOZCtdrYbrNpsbUwYLehfDAMscaYEDCChRWbUNlAqGsAVzUKtIWGqbGZEWSmRPLskoIpVeWBJcqvsgoZZfpNvZNNubLTuOebYkdzFIsYPqZYjbdrxhPYQBTJFZosFklCoXpOnFQNxwyj",
		@"oQDghEATWF": @"HHPMMLQKOVWTYRGvWlvwSwryGjPsUptwvsmIjeqbKPIyWZZrMaZFJQBqGOgYwHnBzPqmMoZIXnEILmbELMyvwMWFjvsOKdlORIvXRoOPtiCsitMWFoLnSRkeHXOvZCOBawGvthvIWw",
		@"bfXDFwszGKDMtBQi": @"YMFAkbeQWUgtlFowjgjSQFANYEonRKurqgsHxdIUKORKHZxKXhIpzgNSDlSeOLJTdyqiELxXfSzZrIIqoSOXZYPPKPVZsISAAMJAPIlIcoADMDkdTGBJAIHcnDDxSeEJdoBiHkTfHRgtXLfXs",
		@"XcZoxFzHBupf": @"SUyLGZhuZzFyoHNVdCqHUMcKwiNkMeQqPnaDWAUHCgkUHlTsoRuiwQchGbUOGeFWktCGsTYqrftbhIsbcgGutDkTQjKZrfEFLBGvsWzA",
		@"hGEWmCFLSXfURqblVCk": @"EcQxNiMZWKUwraMIWVhRZDeYGbJexXeHURzzUdkmQxwsPktMnZVdpJrOqNNLXeXrjYQlRTNQeQtWSTMZKhzFLMqBnXvuNyetoyvlzp",
		@"OFPJTTrslKtCDXFcC": @"lvemwafYcoPmjwNkrmRpEMlVWZeHJUamaJOgdNyGDFTUUvQQsLKdLnTCHsJWFbvKfXFgPJeELwIDtGtKtoaEQVxYEcWHLzEUhpUAudgCJYpZcwZdRLUnUHfehKtmvqOUvenIjgvMBaTGkkJMCJy",
	};
	return tRGqFAxkEgWCyEqPX;
}

- (nonnull NSData *)XohOVIcVwFFEGfqr :(nonnull UIImage *)tRvLdWdNnY :(nonnull UIImage *)aJjhnKvgcwW :(nonnull NSString *)vFZnqEZxZcDM {
	NSData *yTzHqFJdnfvF = [@"LxnavQxChRXfGzRzdmYzItnIexmuCHAOnaZhGSRJFVEmYEgSHOmkpuHHiKyDUeoRfUhGHKfPaNpKfYPKfMgvOAGllTesHagcwCXUoKbJoAtksXkkbzwHNkswO" dataUsingEncoding:NSUTF8StringEncoding];
	return yTzHqFJdnfvF;
}

- (nonnull NSArray *)jfvRsAvTQHIBdq :(nonnull UIImage *)OGtqgTquPpcIaDb {
	NSArray *AGdJlggclVbKB = @[
		@"peeTLUEIjkWzjmmPpgGGxwidOPcUpgfoCVoafBQbNaHvsypCnoFcBmQQahPfiwcPriOapLEmcMJPtWDSYCcUoGwePEWqBfXxQWaqExabgVEKPLskTeNYVvvCflbpKalvKQ",
		@"saKojGHOOhEDJQgGCsCLgwLJrRJNufIClFUITMEtlPmTSYuCshMASiQQVIoXGXDQoAwWaUeWKGFEQcsuItOFiMNdPjVPuunIdmLHlOgBswZOUeueYIjrUqfJPXFas",
		@"GgVDQbwmivsGCLUVhiUoqPpPKjHtiPPqclZtTxTfNqCInDhfnYKfcBzTJEWyqsBNCNxQASKthmfEfQxxLVYPgDbpKqSrbibSEFeIl",
		@"fuDJRInwrgCLfAFwgOkGTySszQujcskopRGAoAXuAPpDfaKezJuOFpRUWfmvdTkEbNASHiNuWKcQBvGBCueTUkVXVSjuVLGshnGkwJcbmGQYRSMWvwSONQqZxzHd",
		@"IAwZBrWvUhTRcrkNjDoAvuilNjwXONlPFWtIGjTTfriAESVeQLYdLuvivnmyicQFUfObrLZwMPBOelIQrYgHYmrPQzvGqWHkRMPnStxcfmUaeLbcytczfNQHho",
		@"EWCYtqdeghhxSZQteZeLTfxGyKJheYpPMvbWbVnUnOldKKaPpWmqWjbjtuHlQfIXhoUbpOLgCbxgZTKepwDjXbHgYLJncncvmuRD",
		@"IKYTDtrNBYyHrKmxAmGGcvNWpvmLErGeJPNYCFmBPovuXYJywhyTkMOXuTurxGlCfoKrTTxWFxCHxiCFGURwumFibVhSErdkqVUqvVPSLWEhQGZWxvPciDPDwpeytPRFZ",
		@"rMwiSfCYFLSTMObNXisaWtgRZEnfyyOxyQqiOcgRMxnxUxCPoSeHDHCSZokGcdNItBBMYfjxdfQWacAXNjokuAEEQNAcjBYnkVUpaqPmhYwLuvEhOtVTzhVpSzG",
		@"DQpytysduiLuTyGmruaUZvdedvVrtzhXipNLwrXcjwWaUKMIiTlqdeXhqgRDssoAWGPPWNdHCgYHHYfjHrIiMbmJNSjVjqeZliRQVZTW",
		@"jvwYLndDHXxZhXIBCoupjoMrunDfevKLIluTaIwXoATlOkwFthxaxKahycYpLZuqnaWnoqSvxpggoajuruHbtwRXNKOYccnVQbtGhfXMJjHfVBeOhuWophTHASISioVKcPCYQNGyBvvSX",
		@"ahSTloAAkdQxEPBTzbJqCRfiENRWTweOXUYjjnIskONlQkfgfJtJvislNdzHVyXCgREUnAIBMnExpxTQOkktswauViysvqHVFGYl",
		@"wTIlLYZZRXEbVVxepdfmeaNEUyACEOYdKNuThflsebiQpcAMOUZsDqnBEMHCyQXKRsEOjmStibRhfLwzVdxnEajmoiubhEjGTBPzYLpWqYHQesdmqfIUOrmOEtSshK",
		@"MPXYpTVvlaDiTiwnRxXPdADNCjJSRyczZiiPbUtWlRlrjRzNohzYuxraTglrTToGKyMqKreDfUifcbeVOUHJhEBQryxbHlBReKtXVgUTBSTGRjCbDAXdZtiGrVRcHBoOBzP",
		@"FXvQWeioxpOWWynjmTYGaXCTgBXYzPZJHSxkGxTnEixdEjWfrmlzIslFMUVCGknIjrQVcxhZSgcNpqbMDOesUpCPtdwLnLzqxlUJZtdxFPIzhPkELyzHvbHaitiJTojTYnaMmQ",
		@"CUDxBTRLKCkTKUWRDOjdhmfZgoSqAIRjezfwEaqrbLkriMyPMAXeYCuyWpddTNydIMtfTyrNymCIetCelEfoRUIoEdqFrsHihgBDWyHLIqmKUp",
		@"BgcoUYMbYIBUPEyvRNCixuTnjQQHtstKOmbrJuCsNTEdVnpgsfjrainHTEgXYxLcyiHOtaHsGJStbEMiMcmqqXNssDcfiHOLrygDYTFTjHiPRdwMDAUeFoGVLSkDkTOemxaXIuNYJLGxNYqbstak",
	];
	return AGdJlggclVbKB;
}

- (nonnull NSArray *)wfNrSSNuisAczNuEGe :(nonnull NSString *)AsKJPieYcSa :(nonnull NSDictionary *)aFsYhZvKJuo {
	NSArray *ldzUSLsvdnoqpyqi = @[
		@"DpdmuxlkwDECiQtZipkiPJOmRYQmvtZWkWOWJtDsYLMAeOfKPlVDjFVPxorJybvsxAPFoZZWbETkQRcYikNBedpZphMbogbGDxnNZlnqjOVNYQCtKSpcODXcFgmRGVWPLNmA",
		@"UrDHWTyQGBZKtHmVmVRxKluRVEMBUJPCYGqTjXvPtHlFAOGLaTIgiWXhRMRzUQknPcmpahDnnVvGzTxtkaEFNLlVzriYeRvppYeTQzcjaqrktrmBEH",
		@"EabQMryGZZFeOPBowCdQsQrajTLfPuvsnHjcrRwfXNtpDDaOGvuDFPBVkluVeYVCjjzVmbHirNrpiazAPzUPUCKolUaBdiLFyaufCUsfMpOkfuhAIZQYCqeUdtlspyCXSSeLulMDxID",
		@"DntHwKqiFlOrFYoEJPrcTcSEvnofMqgnUGWtMYBSqLiWbzgtBxolCdmQNDQBjOddbawTvrluIoHZTjWkdvAhJtQVpMgxoxefmqnonjIKpOaimbrYBhRFZ",
		@"xrkcafueRVQwdmLcJYaLTzRFtcMkXDNpLohRJOPegVaxnshsdmHkbQBMkGtRDDgSlyTnhegrGYRLediAmWAmNKVlhgfxrmDkJHNxxIgcQEOexDvjQ",
		@"yoMITjHOGppSYDpGJXvmHIwNlURtobpHbNMAqEHHIREUuhsIzJJjLkynMZvOQbCULDRSiCOMUUXYelLOaJZMVXBSMYmbAZMSxEkfvKDckZVHXkIgqGYCn",
		@"YmraGpSAhGwzHnCYVgXwRERynfGeeTvpMUqyQcOLEPsoIcOdkFtZhDgxPQuWOBvusEiUHPloAXXqdRUbQuzkadVsHJUxJhYOmYzYkeUlrWZ",
		@"qVOehEOfdcSIMBDyCbzbZWcuPnLmUHuUYUSWKOECrPaxnYyebuYtQBknbpKKudmmyMJqrNfQOZQSXsnLOKpvsnbJSmrBlDnsaEFuTsqnPAyHdppgJQGIoScWGzMjQIKrtpVFQgFE",
		@"iCMXKgypAuJhpooWIPAdSlOkTcGujgvcvYwcPYbUuntKXJOUWtuijJhdTQTFmifWHoAioFROnrsxubjQWsDABOSIlEVQeveBLxfsLsfUwMaoPmRYKKwGBclOjwgPeOAgDHnlSHuUSRVFJYFqzSWe",
		@"iJwiyWqJZhZLOnLzLyUHlgEROtIjUNgldPyBSHyuGdVtuwvcCMDzuLtBmQgHZDGbNUprQOFtvmPEByJMNvJeFoyihqXKrGXkVRwsOvXjNhUUyvFFXdGtvwQwoO",
		@"cjKmoBUStTcjHgnGxFAhGJCIVMuUisIbQckIQFxsiuJpWLADksYQAKFHEUlZahyTtIvUXJYZBTIqrDnartkatdIeEFPKIKnPeAELtxbWmY",
	];
	return ldzUSLsvdnoqpyqi;
}

- (nonnull NSArray *)HkCpQKYJFLLWMVu :(nonnull NSArray *)gjHgIsXnWBiG {
	NSArray *EeMPcUKstqVgBUWU = @[
		@"dXawQHvQkKhxPgRKLFiwGWzMZuOdKDnVMwTJafnYbBgsmpZEcHFMCzsCdqBxsDALSpyxThszXVyroSRgWagesfXJAJyIlqcYEWjlSUefxMJKsWyXwmjjjouwBzJgjc",
		@"bMTILnWQObbzvynyiauAOHgmPUCOKulwXhurJnbAvAGkoGqBXkbNQNUCDnIFNqDQecGDCZZUzMnxPEYsVjCIWGDONYTJvACdLnVDPnfHRmEBpgtNmvBIzmMqCLlokNyrdwMrxBLnRDHX",
		@"ZNBQuDwAoFNEpVVLnkptzvPNVQbbjQfwWLISrzvwvjOuDXTqGpVSzgKceltGLfKLaXfxDEtHXgsvyyEEOkMmkPFQdvGUjeMHYEbuwWpJqYpZANfTDgQlSViLyuzwxZlkoEnhwqLMWcioxOKlbBc",
		@"SMPyXbdYRNVpmdsUXJVEapycIPRwkjzAKPwbocgvRHjRWbVivVucLveJHDoPhdbuDapcIuzBJIsBjPdXrmdlHQquLSgKjbxoxTcYXizZJgyAlVbGNamAlEznMsKDHvPufwb",
		@"ktvrWKohrFVPvutZFsaMRZsTaMHfxyVeGePFKcIWaHMcdatRqBBgHBtSTfLMYUyavSvrbpRVKBwICmvUyDLMWSlYoseqTKbKXcPzCHUZu",
		@"CDvCydiXZADPNjeHaTHdxsjmnkcqbAdvbFRmjPDFDBpheUXMdmDbCFJLbuJLAOKkppybLOizQIFEomafyHfLvEyKNjeMqmCCjMVBGWLYmDKmGaQ",
		@"qAeNxcySsdKcXVsEjowetrJmHTtDGOYaTeCGUHYSbxssdCxXMcLprnwPOOBZtSfawoviSlNNSPRraoSZDRDMLbjTgOqEzaRuMcAXfMbeivWBySG",
		@"gFGiwTwkcVIlEFifXlDUJHEZEXfKZxmfOplyZaeVoVEbRpFSlWAuZAkERVneLYegHQSuDdeMtLBraQjNZviZUQOKvzbxjniGBKsRRuozhCXANwGe",
		@"YfGcEWUySSorbDZKLAhpwYFXRTpkLQwKpOZileVTGWdVQBwKIKsvaoEvdrxvyLizupxtnkNpUIzFvrdJrQvMFVLZcDKtlrQnAldDzanhefIKuloTCjvDpLNySPGkftqbIFMqzkC",
		@"TIVBOaVWhCrJEqRiFQJsDkdKSXJgDylQWAbvIlhMhwLDjdkihdGSVvKofXlruQQbgGfMOdALfLdRcNCyzALWuTaMSEzICZDafmpZGotLgcVhdbdVcpocGYPL",
		@"LRigWRaOLPnEVbqZaXLoFsIuxwKsmiprMfzwGlTByNBIbnSefMajisziyVMlxulgHPTOiDyrFhclpIxJxQNFWOAxNhQScxugEQuHUiYrOf",
		@"URqHyrVRopljPPOQfKuQEbFzgRxQmVekfTQdHKmwmwWZbcRBoHYdDyfVHXcqxQxNEnhPyneDCIKXSKozihsCQwsNjJwyyKKxMxeqWswTmJUxFCixPXsUANBYlvpPiFETaEuGC",
		@"RhoosRrOdjsjxifyoknHyXGBnjebnlbqepVggnhwNeijORbbPARrWXxaGvgLSOLejOcpcsAlPbeitqmAuDanmwxTpgzSdVXwDlKcbSYAXCZpukYhBWDaoTJJObgTVXw",
		@"RSSppYCuAPYtNwJBftGJIeyDtlQUJwNYdocdDQesMcwbbLbAdhquqHcGMqZcBjhgtQYPFFRYQrNNtbgqDQyESlauOqWQXfaJtrsPgSwojoUJAMu",
		@"AHZxSphzQWxpNquXhpTRnJJGyfYfmYFBuzMUalvhYVyboEsQSMwkEtkNvqgNQgZPzoesFGqPsQUDJbZcTwwkLJnpKOQEKTwFjYiiHuVNgfTdmZYJPqAwqGMdoiixUIySIIQtax",
		@"BLjyUPlfWdhcKiGUafGrEtZBMDVvZbZHMsVjiKGhpsmAZYTxRURffYGndeGAbQKFScCjLyiJaaIeuvdISQjBSzKbHMKjHlGLxGAZOwHsBNKebrjCCSYsrOwRp",
	];
	return EeMPcUKstqVgBUWU;
}

- (nonnull NSDictionary *)jRSNFitODzNriBLjJe :(nonnull NSArray *)HxAzrgFRhhMat :(nonnull NSData *)HJWLGjsUNXttJdQijWo :(nonnull NSDictionary *)ioxqXhHLkFNXQSddPOr {
	NSDictionary *TLTobwlGYltyrdjpj = @{
		@"AsSpLruYksnGE": @"jxsSMlWVuvHcyfGzjwTIUqlVILtBPyBTWyrQCRqbzkvIEhTMZAxfEFtXTYwEHIVHsPgeQtgqDycfgxuhSZZdusXPtTnWbxfDlhfOb",
		@"ZMDxIXQEwfrRKnVZQ": @"CtwTOszWfQHuRBCzVeTRvzABtZKjQnHyrYrxJmEfiNZZynqNxKnhGRmrAzMorNBogUzVzSxwTXeafnWeJXCIywEPvZhwJQXdWBvrafLPQeEYNyCkpgxiD",
		@"OCVtPjbyZCaQvBFrM": @"MEHhlTIgzXtHQCWGweiimzboRnDQptFrqjczjtosWiINzerLxcAVeUzTnmqYdSintQrKzxOSvTcVygcAKhnrBGiLdLXefhSMVCpMSnKbKgczzSKWYQ",
		@"RtMJDWiGRPQJjKYrik": @"XaYnXIxVfvtxCjGiXhdQjeJTFFntrSRTPMAMmCAcQmoNskUIrtSFxAMmGuSfcgUXZCQQLHPBDHesCQdLKfsiFVYOxzojFuSNihFUg",
		@"eICYtvyMWpHMkO": @"OCAePXKaKpcDOTtIqoHwthHycowRvWxNgJKfslMLlXwwYnebfzLqNpjbaQmekpTBKjthPsewSTracXLOAYENswXEmEhMteNptLhn",
		@"QQttlUIWtwGn": @"meNzpbRyZwiAzScYmZTdzZHjYnUIAzjrRCqnpwlbeDEQhgLLWsnoSDtqnEHFUGneuavMuHTcSswYAqDFSJVuPzJArayMscfzTKzwmRFqDVZcIConPXqCQlOqbBcFTaXIDhKCkdnJqhszkWoWum",
		@"YfMSQLtTIlKvkZL": @"CWjDwEgnppSuwkzilpZtGSnZUNvrmjLyowQSyasGYpnDNHOgHVBbdeJVpFscSgDpMpkcQTEVEceXXvBBCnCfyhZqUnVxQVdUiIQmamH",
		@"rkBDTwiCTjmZGLc": @"UnwhwNlLnppdpGaSfnkuteDFHDHrzEYHNlNYBgAuWBVDCNlaefxYouXxQkfwkxbxhMICLMLafYUUrgHbpcievjfYbSsrMnJqPpCgCsQNasrASrYwM",
		@"YFuiEItbMRbPGOAU": @"DrpnaAMgFYsxhvvOWIYTGinfrYGddwXBluoEPZYFrrDuGDLvlHFRBvLLKtPPftmwzhprzIGiNyobVohPauFKflqcxscuIcvwAdBsdMlxhYyfehDNjJhOIssGLBXPeisJCelumEegesaJNRzDo",
		@"xAiuyRYnUELN": @"ooqBhIJzPpdhFVjhycMPKlVZBzzlbwOmxoVjhnCnrkEDtnFKQZqoMgExJsSUEffuZvEZYtYFPSjzpLEHROiPXJcgapFYenByReetKjfgQwryJRmbtuIbOVBdwfAaifaOqgqNFvgyISD",
		@"ltUkOIGvgQfBAsQ": @"UjypErtvDDGXIFaVRzBRMpalLhxNyYoIZRCwUKDeAhjDJeiEYhqeusjhFvdqHWlvaHtdNntZYXjmcFYCbsBfxEfjVPAFZxwPEvCrDpSXMVOvyYaTzwUBASoXzu",
		@"IlFXQVsLUZbqQ": @"YJlXGIwBRnRzKLdXtBbCwCZsdOuAiOjmlubflUoCskXwLJkVATLcvDqeWfbOVJKwvFAlnmfaSSHhTCAecMSYNNZcsfhqmwvKchyFisNDoRfuZOQgHbACDzHbklGWWGoQXlgSgrKpUTyu",
	};
	return TLTobwlGYltyrdjpj;
}

- (nonnull NSData *)dMUxFbHYLCmC :(nonnull NSString *)qXvxbSDRLaP :(nonnull NSData *)NPBJmBcZwcMBrnqomE {
	NSData *hvHWDKYQSJMfMufwQAX = [@"TwrfNbVpOKCPIXySvVXNxpvNKhQkBlYGaMvmwmAatSxCHcdyaNSKCtEYYHsHCgIFTpeZyZdFjfYVveErwTwDsotMvGOsLTmvKaspccUfyzbPa" dataUsingEncoding:NSUTF8StringEncoding];
	return hvHWDKYQSJMfMufwQAX;
}

- (nonnull NSString *)rzYqryLRpsenfAyQ :(nonnull NSString *)ccMzRsJEjFyd :(nonnull NSArray *)DjJQDYuTaRumWGDow {
	NSString *tMlIglhQtP = @"ugyTwxHSFlpJYonZqOwnnxTebQKnWxBuhRxAFvjgDUqDxnAVPdlFxeTPtbYEXlvoOubSJElfQCaBRJamzIYEjHUPUSQEXWHzdNVMvmYNdqbwEDlpVOZRwmlLPDVUKSl";
	return tMlIglhQtP;
}

- (nonnull NSArray *)frIVtzAUsbhdGWYPJ :(nonnull NSArray *)SAotgLycpEvdgyTdGTE :(nonnull UIImage *)wELbvOHWdYWt :(nonnull NSData *)XceWYBZgzMzjxdHJNtd {
	NSArray *KNgbhdlilT = @[
		@"oPhljSVyomtzdCEUUuJnRotzSELWxhbARVbSxmVfkgHkwXqcXLVdCBZJziQhYTKVRvhJcYLThmYiVOHGotFhNIdXJhlTuZwizwdeODiWsaZNVNggnxMYfcKDIVDgBxrMUIBajlTXcUCs",
		@"sopgyOTTpSblSBqkqKaOKlpZvGzIotUEzQjtffhQSVObglXUcQrODhyOIUCjNspPhmpBoxiUlzqhEoaizwLbQcnqTDJKyFrbRtpQSYfRdmqDgzolVurcv",
		@"jRMrgOYYxpbXlHAWZFhvPaimxfwxLTILXwDXtCZjXuREyEWsEysAuUziZaswVIhDtmHBDIYVusfGiMyhIxaVMkUjWUKmNQdyUARBMtEk",
		@"QPydJfapPRncvFWAygVOMNgrOCPzCqykruPdFbokDyVZxeAWsjNJelDTMjggaSFmtNkIFkpFumkFAvhjfAdhDzLqlDRBaUyowRIJKJOdngMZNUCWDEBSlnPRVCWBwLcNRyMjnxKcvNC",
		@"wDJRQFjFDWBYkFPBrUPaGocFVkqDFXxlurEYiIDeBGljVCQTJzyzKZZajbEWruZHNubnsuZbzdGBHopcHtFRdOzuewdlYDwgELegjiz",
		@"nSdEfRIrffmarcKcWIgcsFlEqfAbNTsYKyJhekGooCZuasJjVSaXGPotJHCkfsGuhUOuxbbbAxqwJbBCyDUiHyWzNHunjBROegIZSsJT",
		@"QzUvGujRnAgFpIiRjMbRSmEwzoVIPrwDgbwUZFUfEBqmtDxZsnbHeZYOmsJYWYjMZFtafYtuGxIODDPwXFlXsFdnsqLhyfcQBswyYllKweKzQYvnJvDNFldyiReFJQGAzRAiqfAPHecQCZ",
		@"rrjDKjQMjBsjClTvBPpmVxnvRLQrYGQWzXZoevNUsGvQCYXUMlIFwtzYnRDeQfROvuPljohyldhHnduKJpDqogrkeKsOACdjzDmfRbCCxOqh",
		@"kaKppvuihpbQNyTgEydcZpZfzZhHqfAYrdzjCQcexxaVVlDDJQZRPyAaaFrOPnkKaqFwaxssBAqkWZntntXjvPPCSNzeOkPiUMeFXTWzbdrsOQYfsmPXhIlGOKAFEOgJ",
		@"cThPVUuToYEPcCDyEcdPsCwekiutDqjvqRaVTjlUhiquYoyuXprrMTfsOSrlZEzUmACaWqerQWeDhOdVdVoynLVcgLKpSwigZDugPnOvmOVrOuZrZoisVACyAJRqjja",
	];
	return KNgbhdlilT;
}

- (nonnull NSDictionary *)cclwdhaTNeqAH :(nonnull UIImage *)tWSVxLjqdxUquPxX :(nonnull NSArray *)QqVXHhuBte {
	NSDictionary *clxUdrjmrjVOO = @{
		@"GfemmBfseD": @"ftqtNEeCFGFNJVMWDLCcymKpLQzFbOIPwXUJNiSTQSGFULzlgyigCdhIPjmOjXJXdshesRbCIsmpIscNemsqkEiRepbzmDlefCPWqQDW",
		@"xmHweePpPLZK": @"lHjIHfRLLKtVaDfMZVWaJiLxHaiGXUGuhSKXMGIXZZtoknprqxPBtzjRaOeoVqhzaLlaijMROWEvkwIqByBzDLgQYghqKUHvhPHsnrKguhocKeYkTAyIESwQOcWtYftmzYzFEMBlKjBsBXjrZ",
		@"eNXWjRsTJCHiBRH": @"UqjhHlxdrFaDecRKgNKNHxSQdbulweZkiDMvzSOdlsWcNuSVlrTUtJtyuUnIBodVjXTXhUiVSqHceKMNmDvKsZDhEnhohbdIXgIEzkoMyWPmpdXMXmPCJQdbAGfCAuhwD",
		@"EuiOAgZnXdwCUAB": @"NCpcMvsLHiQYtxItGtREVmGTJVAJOonYPpTmjWUviNrSPYOGPsYxXOQmWqtkLcpLKNytMniCrOxNGbBowoEMQOjiJYiJKIHciIiuTIGOpZycWqwnlfGjPcHHjhjHxLVZRhxIAvKKu",
		@"rDUcXpYKZhTabsov": @"qazzHoHnCXTRBHzvXQnFwNBjbiXmTfGcPlRzHvsLORqPXXZzwCFTlQOWyEfuaoflKSVKeLpMFRpCjHKSGUIHlXBWxuFNqjEnUXtXXxMwqpuaVlnzl",
		@"PtBjfJbBNhJLCc": @"mqdbGcOzYVxObFpTsDKFFaTqaAtPHpCdfkNpBFWwxlfSBHlLeEXvMuQlpTPKaVHZqfFUofdoWAsRZulRyXxvtZMTAqFbdrRQfyjtvyPJIoNQNpEyluFDXDkNCPB",
		@"MIlFFxxYPmeODqCkOfQ": @"jLKVBClyhwHscAWoRplBOmhQYjggamHWkFFLGKZUedFWmgtfTzdQpCaJgYLldELyQwvZrUsFCRlwYEYWCRYMZJMCAXBJqOJuQVEnWXlTKYQLcummydiVOBFpvwlywCJjwXO",
		@"vGeEnUtQUwND": @"clkggsWpOWOorTBhRfllyFRuGgPAJNSfCZPFrhbGBYiKzPNRciHjHUSEFUOHOYaJqAUDZbwSIbgYFSELQCLpINdbGGpmiuqemPeEhpIbUeOGWMKkGPSKX",
		@"ebOJrgYYoKFjVKwvz": @"YvKXYFGOhSaSOnkcRxxotSbKxNgICTuqzEKccazrgwytIMtPwinZOkszwAMUCvxhLKMPTmMNaPUDKhEvwsyUVHBCeYSfBolJCyuZxXQdVTNGdIehpNOrcqQZScgxoDe",
		@"OQTMKrvIoaw": @"jfxdNHYCRyrJOggBGiaRrwFzhmBQWUHJVjskRAdkBqgzhMWblbvNCufcoLoUaGiVETQICNHwmXRAOVbjHJIquPbiBOvXeVLXzpRMGfHgkGmFGpbyViUCcWyqdLkrNHUotTSHAsEbAxjxClZ",
		@"YuUdpkFptYdTvyz": @"kpCCNwgOgQDGCJnxJhCuqCqNOpajKOJGCfxKTzBurbaEkjgDfIvgLuKIrsRTXpYHFTnqZZMofRTRqCmyjusUSqzeUcflALhMYScqWmXDQXstuoi",
		@"foGdtzANlK": @"btfTOICmPZWGfoApwbtoBmPYMTqZrYLeDrXSxunVmDaqaRKregfFabKITKoZgJLfbgcZmGoIwhXwnldACNnBvZVYnQnRqJXDeGDTvdXmCYWrkfddNSQNGvmKhDfxOerKC",
		@"sPESJSMUddeorsr": @"zyrIsynPbbjmNvhDLoKzDKhYmYiSGZfKpgsnTNhcvBCKScfncQFEWvvKqrWmjEsvMqkAXyTtjglngdChbBghkxXeclRFQiUNDpNndfodqWRMd",
		@"IucIVJClMNlQqRHZHS": @"kkJrlZnDPFbkCYGWlaXGLMHxrQmlfBmdHcDDUgONBoIOxoSawcKvltVARfDxaOKKHWOqDmfheQAKdaPHqMbCESazOkLHSdPhyPGenFWiOxUkJY",
		@"ReTyxEmzCepqbKpgVTH": @"cjKizQHloaYfcMfyXyuLTnSLPIqzrchDvJbeDgLPolTSdiLcknZjAbKmWSOCOKFrrGWUqFPhRYLhYbDxDAyxJjoMKlRsZSPxTfKehJ",
		@"nkvIXcziMSHHWdtxiNw": @"iYwLSZOMuZTDbGqpXyrRgmtNPoWwAYZlBlYSUZZkSrchhllsOznYTLymYPUWxZpAbaqvSxTBTMLQTKUwhuZVuDPMHMVLVQlHHHDnoQOzlQZOyIEgqXMLfRomupQmFYZBKuEkZJ",
	};
	return clxUdrjmrjVOO;
}

+ (nonnull NSString *)edlFZgqYQJcxVBon :(nonnull NSDictionary *)dhmiJXcChCs :(nonnull NSData *)SqAmhWerHQvJe :(nonnull NSString *)pyghUkVKofmN {
	NSString *qdLAPGqmIVnY = @"ldnbKeAqroywJAbkmVkncgLrcOSygcZkTfsoYGMQmEeLxrsDhjqAoJcuTcPhDSIpQxyoqzQGCRZhKOWtEAJeIeJCEMcEJIcPzcKEhqEBegFldYGL";
	return qdLAPGqmIVnY;
}

- (nonnull NSArray *)RGLsAvJnNY :(nonnull NSArray *)ndZYWFYNIZREl :(nonnull NSString *)WuDDzKtTfMZbyTEaIZW :(nonnull NSString *)xYPXqnTKin {
	NSArray *CneClOSarPdUyDug = @[
		@"SkojfwdKdxXpivVfLCCCjkaJeCzMAHiTWTZVnQFeeCDFJrZdBeCbxvWYVeGTpWJmnCOUmqCqvXMpLoIMIpHCsRQygpnqGysyqdSzA",
		@"uhfbWsVgisGITzqVjWIOSZxidEygQHEBSMoysxXUBbnCAtNUvoVuSDVIZUFGjEYEpIlPUvAiJVRtbViWToBxhwoinktTaxMVhdyBNTrNqhWMQfbQKftdYeUTcHVUXTRw",
		@"TMUAdOdavqkwUidFxtmImsaziTjeJWxaFPjbMtSKKMtImTIHxEKeUUXWprgSmnPMpdTtjaMxBrhEKpzJaIbhsjsQJSanBgkujBDVEDsEKbjGyGzEvVBkyRhWElDZQg",
		@"veBceBvVkfEDhFHpjterJHMJEsqWmEocBYxdpBHFXOvgAzRiaLtQbkyHDLVGdyAfvRqYRHWQrBPHeoYyZQwdcItzOlGqqHjBSSoDDCZLmKDJRrtagWevcq",
		@"ixEmBwSQVpbhgpzeyCDJjAsnTpYjiZstBvfePlhCXhytjsryHFJvjNeCYFWkWmoQhfWAOMFIcvYGkKnbuDFgsTberbXHwIeCaNpfPvmsUzkJEDvJtyqNcxvHVsD",
		@"AzFYnyPzrOIHZzuNTMOYZiqyItwMSQNcqVljoECTBajVjLIdQetrcRHzrbAPgzSWZFknglvGVFfKIceyfaitFaYcuZtFmEWPKMCmdqpVmymYrXYZWbbdqshfgHmeKhlmRDIERKcZvQ",
		@"VWTOehtLdfmFwHdOMGmMBcrmIdDiskLHyIfZQBzqEnhKQCPsOYgOPXXAXaWOKDfGpLrnsPPjcTNKcLJlcViuMmAFfMofbKLFhdmcOzKxoNFTqPcBZvBQBF",
		@"FsjNBoJlgJrolvRVtojgBfwxyPFslGIkoJPiDwzmNKxsjuJBDkqMeqiGRxGcNilERGLqlxZkRncikSOmLdGBCptdEeeXEwWievqYIlhiqkVoZTPkSyFwRskqOaVacdnCOfX",
		@"XVrqyjEDSwdlZwZYrhyZyGNxCZMSyfaYggpuXzcCYYiKaQPxZmENvkRaKcsKpxlQDHjKFPvfbcrMTUWqEhMVIQBEWinXinhVAeQoyDftmXGfoepLbWjAG",
		@"agcFEvLFGDNRuMEGWHEzBXhvFphibBFOsDrPXEXgOrVCfthjdEzFMmkUHedVloezTHCFapnMTNSmWUXebeVKBqByPvyvBgEnXYfWDvSFgbitqOLASixAUkSXNCwEESOYtckRTwsoEat",
		@"bLFgERwyzfKNmRPCvxsIZSiQeOpuwiPyVssXbbTwuCsppJEfWACduktKYNGydqLVWNGbtBmkKAKbCiITTlAoNpFCHGHWZSTJIclncfEOAi",
		@"nKhJNyiAfizNVZnkkCSvvKkatvURNPnexnHPYhqmKlyrdLYzHThDQxtSUGSasoVuLnlPDUlpNTLOMSvtQNRiIqlAizxiYnIrKaMPAWVcaWMiznDCZczQUvNSQbHvriMn",
		@"KdSMWXIZcxVttrTonFrzHlEuapMMcWCuZoOgIyGcrcBRMLRBdNzCsILFvNwMXxkqJtAzndHbmWEWkeIGEKVQwEDePPAgvOfJqiNonjMHtwisOaT",
		@"qziZwAegjXcRMTrcRjSNYOnoqTSmgHYPkiidblDVrESgqGvOWgsCZQYpzZaAVzZZCEwDkLmCTymZxeOHyDnrAudgnenbVyRvZCNXtB",
		@"ijTblBgPYxWdPrAjXkDuSWItiAbicpJLrRPdkWglYMhoqFddNFIvgcpJSngUSlnuhLQvEgSQGamskFTnQGbQZSuaCwnwMExIenoHmeaOCDFVzmNANbabJwOBocW",
		@"FTIxDJxaPufZWxfKEaLDBfyBOeIuHtHdIRKVDsVgrRGhWJIipojMVtxHfTzBGwuCeyaHjuSkWwLMzjbbIdBVXCPiEJCSnLqdWdQKm",
		@"yPTNySbyoATtuBSlrPzIWaDVubILkacIzFvfWaaPkOwNvMglKBqBqAusbAQTXLiwbRWneHAdAKKDBvOdUOleeJNFJfgYluJXwZsTGUTjOSOnqTvGyPxWwUQbpVBEbJKUdQulFBBqdHLFEDo",
	];
	return CneClOSarPdUyDug;
}

+ (nonnull NSDictionary *)LtvFTYOScWDN :(nonnull NSData *)ElsGuQFSPlWfSroAe :(nonnull NSArray *)VKeVZIKvbCa :(nonnull NSData *)GrARHlHdaLgQssHns {
	NSDictionary *dryMNTzoktG = @{
		@"UIGownRuWouUaEz": @"KvBIZVomcyxmjBfmJoDNfrKvCbwzPYXgcPihkjrzscKxqPpZaYhUgTrpBlUkFsmnDIMOHlNdOwRLskdcmIffPDWMVBsvcwTYDEtPmttdHTxkTmIBjjnZFzsJlzbdtozrqRLMRxp",
		@"hKbPCWgtuWt": @"cBblYKrHOkLAvfHQCIoZOFjFugsqbvNclRJuECkyTJwquPoJGpUevfegxtzrqctbMEySAVGDqImKdLZuDPwUGJYduLNukHuCPzuTbTaxStuzxOQKvVuxstqyVYBdEQThnplWTlEx",
		@"vrPIbBgAvVtQmeXeGOs": @"yGeZASFeWjAUPfZvBfaPmloNSrEqmaQnpBnBllzpiiwuOyaTnWufUDKuWzOHoCkePtwzMcBFRxlKOVctAhJomIcMrmlNjBquBpTtU",
		@"IOxGOrInyWa": @"HNRAZLawGKJnoFDaJRKJngWYXMbPokAYzhUrJwACyOEhZBGIOlBIphmjGwbtfEJQLNkMdlPdbFuHbYaOdbiwaMKZQFSsyuFHIojFHEuBjdedXMRdDbUfOEEfQCxISIjphewfZN",
		@"xSnVUlzjwsIivqWuB": @"KBmfalssqliceFRehyjPqgoNkZfoYFwIrmuEHWPvhnSAYRDSeyPbhmNcYXIcRsaDvPRPtxDkHZLklqDSTHbFwhfKXgxwkKHvCiEJ",
		@"UsxJVuHVqaWiPTobqB": @"QsSstEjWMDVPaYxCxbMsJozIALXQtOwnuGZlFlLjvEhDCQUmBEUtoFzrYqFtvZJvgHyXGYYSnEEWcnXiAyTMHBSJNTDaQElHwGsWoeIlilOrrnpVNfCJoGUJEKXcUoMYYmWuNJnqiYqvgsLjvk",
		@"DCairgFOnUUAJaNkuf": @"lfQdNVWiHDaAQrsixQNJCjuTrGkauIKlLtUZpEbvznLKspjkDHHlPipXObotmnuygvpovUFNcdHCEKVQTGsPAuiycNEyZRmBzYwuY",
		@"ggXFbGidckjQIg": @"nqZJcIgNVkOMMCHHlkYBnMHWeJzQFkbQcYMDPfUzuYJXdNMmohoIpOCkkBmNsxZhanvZEyAdonCSSHaSbbLqGYmMWwroHOZcpmysDUVYpvldmGPhQQlwUZvJbDhJPOpviAa",
		@"MZLyotBwhSQEl": @"QobOoxRZCNTiIyzltCrkBddCEyZKOSzylJuTrfUzAAPZPtSSPegbWELcXvWSTPYsAYtMNVYnLelfNjZCisgYEYeNkwSKAVZPHcFauBe",
		@"dWlAnahaYdc": @"pgahisiKVfVNiatxTNLAleXzLSyEJrMnngOaPhvWxDSYlVpqmcgNJrrArAyQIhmYYScccnugoTcodKxjsWkYAJZwlzqnHfXsKoBJUfCBwfhqbhzoFgtpecKBKcUNjZMdaa",
		@"RiWlRIvVzk": @"dDhRairzjLwrdyhZXMzVxQhpwkfHvpgXJHYjekNJnndNImeajfxxmwKWfQmiRHfJYvdDZgsSzvmCKbHyNWHLMsoHhQRdvcQFknykgbvFpLmngGITCkEJrv",
		@"xTXdrGfpfrd": @"LoufmzdPaKZXklXmOTlcvCbGQcsHRfmuUfBqXFTIoQisZzUfROhJtwMFIJCvemDjPbOLSQehxjYFHHvNrEGORlOJkzsCnRGObgbELUzovrbshaqccDAJfPWpY",
		@"iByvjefoyGrT": @"CauFpchytTOgVcbPNTAeJGSvbFbdJxJyJYAdplISTuOcAPTHEhGJoTHDAjWLXYXTfoqDDwshIQAaClpdIUhBvDOCMJQdofGvbPvOTyMXQ",
		@"WhuhnTpJSuHJDsUp": @"KSrTfWLNzabkfXpFXkHGlwGYfZykpdvmVdCxIPaMPEWYAVaJeSFuRTDEHvhhIyxYbkIBfiCHPzmOwFRHShFkSRpgNZhTMlCVrgDsEQXeSWFIaABrZtPqUdapdWycVqNpckusoysU",
		@"BDrzzxguqn": @"SAnGWTxKskyLsXmEddVOnmbxhwHgTalmjHXXWueFEJnqTSkOVfdpiloViCIppJqawevaaQKiCodEygLIKBGMCrKNkXqocFlFdSkSppEtPNLcNExXBsqgxaGMztzWVORqOlSOAzwitGRjBelLE",
		@"VVaXeZBEHALgadr": @"KSOypZvqzMJbnONPXXgDKyVHMaKCqescRqqDwGulFxCmSebzlVMzeyJQmeAwHaLodXGBAeoaendKKfaRMFbdVnbsJhlheiMGyRUjmDHExtLMBTSCWp",
		@"IKFxeimnxxmIuSPuX": @"toKRxlZRSlUjJlGRRVgfgKLFHETKoxMSMFpJYBDYonUNiJNKWJMZOPpsLiLyLHprxWygszYanBOepPKVirWZujQNHGaURqgMjaZDoJOZjPhaKFMGNfONqOvwOJPoLsZ",
		@"HwvJbwmlcfqPMRdUqOE": @"PZLDAfwCazUqqkNceQsCMXiGIafZboloMIDiDpcwAHztOCbROaAKflfesqLFwJbCDbnMSLqFipquNhOPynhVKsHjRfkZGhkOHnjvLqpSPg",
		@"vvdaEiKRyn": @"JspVmpnUOSqbrnGogLpSvRRTPLAWWiRqqQUiDMCmlMyTnYlIRjMPGIQCezPPoCcJyBDXEpLeJiSciGYxDUsRLBKoocLLkZFAqZmPbjXykRFHNrRFabxorAaMqFCgerIXBvtJEiCpyRfJwPR",
	};
	return dryMNTzoktG;
}

- (nonnull NSArray *)WEhdfzdKXOpat :(nonnull NSDictionary *)hcmERWtBpECUuhXrWOd :(nonnull NSArray *)uClzSJygcfnPypMU :(nonnull NSData *)HtgHDAgTvOc {
	NSArray *RFSHeFTIiAyhbwJ = @[
		@"pwoolwWMdywoBrakpueKhDECozOFfLCWOUBHQeliOLkGPGjuJdGnbbGftlUIohswFXahrDPYdHYoXqGikPIyqfidknXsfQpSdOajaMdXlRgHmwQZQlnaEKKOiBd",
		@"dQPKwJGRnFGcRhsICfuVQziBeOxylYEccqcVGkDiuOJUxuMlYhjwMsEdlzVvstXNWryqCmraKotDDKujKvpnvBixnLyMguJwLwtJPijPqZe",
		@"GCvGKcmZmPVuvVoaSjwDbNCQndyUgmdcwwSPHPNXTKzEogoIMinLzmAfTOPifhezlHcoYPTdOqtUkIYbSoWmliJMQurmBTraeaAcWVLfEmBEIQWWQBNJZdVfmOEIDZph",
		@"sScZWBGKEGjdkWYDkGYbigBFdmuxmcXxLoNTBeTDExKLOLYkTCmPRPTiVZkGPiJEKUwSGquUntVBhHoWtCItZsrEAjOzuWRayFeEtqCjcRDIjuoZMqjAbBUCfTOMVPGfnDuEviuQgTYRuCgUdTMUS",
		@"NmzzhTJmfkGEAZNlfQXrwnIlptAYgxXJNNtQDpvIZzXfkOVIwXuwUPdIyeZuCFKovESJqqKVOTAHDNOtybehGZHYhvuudfCMMuiYumGyCBEOWqzEBCIxpKWNgssLBW",
		@"CKhZRKAnBREdifOJrcvUNDNPoFGmYyZBegwxcMOCLllzgfQkynqGGIfQtYiaHWykFLbpgEscYuLnxsmcjraLzVRtmaGkhvmFBuSShAACrmrDShSLOXVckbzhY",
		@"kwSPWfabKvJFsRpFwYAiZhAvZdrNSvFelDclysexiDDShKwDdjzhLtfrFxUWcKGqrUnsnNuuFjmXGcuLvbQErZykHBIwnkLBjehZj",
		@"EekWMUBTRpxMgODwomLncaSXnlEaUtIhBMqhQmJtaHdSzdXTLgEqXXCpjTdQopNFhSurQXAzmfiLMvGcWylDPyChKYFoXNtfXguuJxwewmPP",
		@"WpqdrScRfxdWKiMfDZGydHKeJSipwIOmZlvXTklsToVWDnpxPYiALcOuvAekpewrACCjxKmSAQxQvFoZGmdwWFyiFDjoMpEhKAaSezoep",
		@"ESElQNVMnwScQZafMrjBWYKrjIjBjOFjSSWsCIXyKqbcXPeJGVIPJvAlgqnCipFFblPEDwRuYUrBaFUjjTyYSjvswjAyvDvPmyzFSFlKtpxSYpvPcCwMtZqJecGORoLQfsylNSairOyUVRjbodXNk",
		@"jPTNosVtzDAmvNYzKhaXVndYzNLwQHBidxvTdPjDwqhVMOfnWQMWrZhUuHJbhloFQfeMkjqzFQWjthAXdbYBWvPsvgnSkgQAjQJSTrMNrpLjlJnFtpwLhvyjvTOXzA",
		@"fxblXANDytqQxWiwxjfUODrayrNMNvNhQxJydvXLdazsxddclTuPoIwexzOGlxvCzZcbfAMqNuYVTXrUsOGoRHKYOtQMaZmoKcvdIXsLDfcBzTbxfownGHPrjBctDOFPsqiyrTL",
		@"IrqTjHmXnFoDsQpmhjKDnSmtNBqhgkUCOFnvewwfyiqnXMaLzbMOUEXlUaywCGOKfhXrSjdAciljsUitpzyiZNjUwsjLWdXWvAbIHnjtUQDyWWaQKBjVUyJfYOQRrRsXYZlcbJKZ",
		@"JDUwoUfPYGHnbgTGQFUzxrGEWkbHjlPbCaLGlankzFErDCMVdWngPvkUIxSuMSJLZpRDYOqHBAvBXYBmkUfUwezeYDuAfRWZjoXzRilGqmxCwPTF",
		@"lhFDhmyhOhDgnDeyrFdPPZicvJtCIBZvhDvThmYLlntRIUTYvCblSthRciOnWULZvdwlmScGmpbCNYEynLzCaFNSiytfppRWBYiMLQNRJqibbeAsVVdbpmlPvLODEWnbNlfPYQvimWoJzQcV",
		@"VsRgoGCbQcNBwaENMCXjADmzbRVcwpzMzEEJBjYeJvQkFKSYyNPemJreofhGGmYoApSMDcAoKntMTwCrjqJhaWfbpyxvbJCeGoTbmOPHqclCClhnZXIqcqPUmFnKpetfxcYyTYf",
	];
	return RFSHeFTIiAyhbwJ;
}

- (nonnull UIImage *)SjoybuVvuIMA :(nonnull NSData *)VCKtDXfrwDneJWTMq :(nonnull NSArray *)HuLqamXTYMJ {
	NSData *ffVVCZuIOpnJOEXC = [@"fxmiMvPHbhcBptPryeuLzzjncFClTbCDFnoLECQBOtWCioyYAMoRBnSmjVoQzBiaFhDXsaKCkawsZPBNReTZMVPSWBlIwRoJxRrvKLeQDtLVVlQVKCtSRqmiKwWErEk" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *vRWywZYTYbpwXis = [UIImage imageWithData:ffVVCZuIOpnJOEXC];
	vRWywZYTYbpwXis = [UIImage imageNamed:@"YrNivrPTBXemHkDeXyzVbolQVYLYccrUUolGOysIWSktzQGuXMcBIpWRuAoPXtPloDkRNnmBWeBweEZmCZOvqolZCthzlThYPRKGCwOlalbqckSxyWGxBAuYuOApcyBzNkHD"];
	return vRWywZYTYbpwXis;
}

+ (nonnull NSDictionary *)mbbveFnNKgvSxEbSSa :(nonnull NSString *)MAiHDMkqCMLZMQnoo :(nonnull NSString *)TmgxYUoPhLmW {
	NSDictionary *PbgcYvrRjAhFW = @{
		@"EMCyUCnchzIUNjCgOyq": @"oyVXprZSLAexDHHzfWEOKVBNqFdWZfFPoNFQUZOJZsYvZSHdHtwqxhFbZPRLpPplGqXBkDtZNBssSwWrMuLpBqJopchJOsPhpIjRvEOOBHhFmra",
		@"VPRiCMRjlmChJhpg": @"vpDxNlBqXrFPVYNzyVeSoYEiCoWFANeAxfcgiScWedGFHnQzZqJZoRqjwwJlLpKPsFNoLjyahyqjIATdFKQHGqdkoCQtDKlvVtbaGwdqIQCtNCndjlXiqYKpQmzdXKnULKFzlDKpIA",
		@"XSCBRMSJfztOmCNoPHB": @"mWFKZyBwkoiMEQOgRcYTlXGVQiWdsVKYtmuPnIeRvELUDRwdmEGMigREdVIRiLSomqUaNPxhzYzpZxbHUNSanlQfAyNZUHhYJFIThLYWcwd",
		@"bYjvpQyMocCN": @"VOukudfmohDnnvlhPEXgwDeHQYJRfBQIPlOADnBYVkUgumQMQTxxAPezGOGiEZNsqXRtguoAgCxBLogrBLsLdAZtDaxsXCkVZyAkgTvIJ",
		@"bbBvMaYxOkUYpDNl": @"jApKzWdXXuDgUPOQpkCTLqIGkWNTECGnVpLRoCNUOgzESZaoEJkSYAhMBPvkcymBjpqZrOwkwgZhhtaGqwWUuWWgjPCsldDkFMpUAFdmnoTWFWPpnThMJCrydcAOoinbJGeCBqsJnl",
		@"xkaCJFijyjdPZO": @"IMLpXNMIJdeisQbAqiFQbMgPXyQDfRBhXJnJKxfDpyGwLQlHXBfLVccHjEyXuHOKTrKUWjhFsPHUTRNmnXWKryViswBGAgjggGIsjnABReeCkflKgdizuBMsKsRyczSIxCHK",
		@"wzPqZwmZjSNckDXgUQ": @"JHnADEjKCFMyrtVZrTSohkcHqTMKPaVIwDAihtkMVwzPmnxNDKIpCVEUersqelhhvWlBQNyHZekdVvLwyDePFngydFMCclefDbTTsU",
		@"vUjPghLyxvDCgoJPkU": @"hHeNAExVtrCCyVDGcgFkHtutVYudxFfirpezGlJxJFXVuHBixTmpGrYhvEoUaKZNhWSPuGKqGcPjFtaxunTIhqeUbbZKVPtNDKrbDgxh",
		@"SSULwknFTZmh": @"leEiwNTfsSNMbpgNCoNwULAMdGjojOHIIpnFpymWRDLhSfocgHsGQJgtCCBvPgmYvGBxCkVLBQbNuhvCMloTlsOlnRaYIvreWCkLgbMIUpHuQAWipWxbzrGVFgs",
		@"fBPNqUtPfr": @"pQClsIMgrhdSwJxGMoFFszUGzFesqVzfNKrWGzGQyXooeYcnZpEztbqxYQjVswhSowsCYXlQhNCUSHUeazALsFzZsGWFDRXPcePY",
		@"tThUXwXbuWRwCT": @"syNIHsCnImjmTadEUdfwaJlmPFItguVVfYBQKBezpcjeQpFAIdCqChhplkXkjZCdvWdHTgVgZTtynzJFyrjTQncwVmuyxNpLANAODGiDak",
		@"aoUfNwHTTXyujJQDZrW": @"DjOokhRYKaqAkMIdXolmrfDDFYVghAtEFsRHmvVhsOSoAVVXLdPerUlyWfkiZCuXMiIynpvEPlwIlhOchDDrYCCcJrChGDVUNsJHFEiWAdzABSAICczFmzcNhot",
		@"XqMkQlNEfsjRqytisJ": @"VTAvqeLyjIyMUZHzlflCwuYefcrvXnnNCIdOAToEdFVRFYzyivJbKrWvdMNiPTChuOEfZosIKECDDHJyHEtTxLMYBHPquyCABNHFdSwJiTXsAjBoRwpgQggCZRUpKT",
		@"zDwwHamYmgOInoFlSOh": @"EksWKuOxnRDNRDTHigsAhjDDLboBbZoujsVSpKBscSSitLIlCTCqHRtbIRcKJNSPOQzGRTdSxzuGguQtfcpaTcgqvvqqsetlVsMiIxgKZCydmRpbbjgLLSOJXGSQIudZXnNOJUaJNIVlVhkRLRTGz",
		@"MYOnraNwprxGwDKznSR": @"xdskkESLXaVXCZxLyCuZHQcllNXsbJeEUPUZbNehNtLuDbKWEdEQZuQxUPRYIFztuNpfiPiLIUlvGdlmctjOEKZKJMlALmOSeGCViXByrtVMTjynouyDEdsYDlbwNNpZwzkEwAerIZn",
		@"YVacAYiCtLuTG": @"JZNdnxkxkxulkugeblzzaKJyAmBbUBuSvKKKkmekbrJIizaKwLdoCqJNtRjUodQTZADidzRprchJykrGOyZFobLsbfCENPHlYVBMpQyXfFlhMdyzZiYExxutiXeAbKhHFhm",
		@"KIqQvLFhDpquIHJynk": @"emRwBykQACRYIPeqCGrifMMHSatRchHcyUXbglpPnRTlHsgPzcSEjXTEBAsNUUfkqoYwqrMUowcZlWDqEayqLFnUuidCfqEWZDRwyYaphlUdtf",
		@"irCPEVIzsAjsAohCG": @"wIdMMWArJXRjmEbotIVaNxhXDDHxfBnTxwFVrFLprhMJkkrTjJhbrIlwuwUtvEXxYfNehHRCrztywnYgNBlJYSvWPuDrwTrGAHcARPUTkAXnhjOtZLSzUs",
		@"qkYJoLmBWMQDZw": @"pFWmooNRolujWkhiyXXPPWJRuEMVEhFRRzoSlbVLfOIdIAGdLRQrMAhDlFvOKQfkrYiiXHopuYOYwNKzzrqWEtsdBMqpjcHiUcRB",
	};
	return PbgcYvrRjAhFW;
}

- (nonnull NSString *)VzGCMCsPcjFFvv :(nonnull NSArray *)tSIWqkJXRHZK :(nonnull NSString *)uQlwffkazIuDsMghZ {
	NSString *FdDPlKJCnbR = @"EuGJqYjVkBHrTbUhhTDXKKMmhipLoOsCJeZGUoQpBbbqkiKcLdGdFNZiaFJUWMhMDhFwyFFOnOkCaCuzKXZtZdVipTcBouolKQLQaLjzwbUaHiQtQhZKfBQkOGAVIj";
	return FdDPlKJCnbR;
}

- (nonnull NSString *)yIpoNzknzPkvBWE :(nonnull UIImage *)GNMKqrJQkPwobhPC :(nonnull NSData *)KAkgpVfmKiMwLju {
	NSString *MOtceodfhFuQvGclFQe = @"ahlFpNWxOQudGYAxQjgMKuIupsnNUMbCeeaXdycQAqxTVpowLniyPuolmYjDqVYbliaJWlULaQyIybrTcWXjKLNAoaGwYwTqBKkRuHUNnaKgsEGrDMekTGvostbGBfnHLmEIIRgbkwxNph";
	return MOtceodfhFuQvGclFQe;
}

- (void) loadMoreData
{
    self.isMoreData = YES;
    ++self.index;
    [self setUpData];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageModel *model = self.messageModels[indexPath.row];
    return model.auditopinionCellHeight + 70;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
    
    [self setUpData];

}

@end
