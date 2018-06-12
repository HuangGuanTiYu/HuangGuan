//
//  CourseSpecialDetailViewController.m
//  zhitongti
//
//  Created by yuhongtao on 16/7/15.
//  Copyright © 2016年 caobohua. All rights reserved.
//

#import "CourseSpecialDetailViewController.h"
#import "MBProgressHUD.h"
#import "AFNetWW.h"
#import "CourseSpecialDetailCellOneModel.h"
#import "CourseView.h"
#import "CourseSpecialDetailOneCell.h"
#import "CourseSpecialViewCell.h"
#import "AFNetWW.h"
#import "MJExtension.h"
#import "MainWebController.h"
#import "CourseDetailArrayModel.h"
#import "CourseDetailController.h"

static NSString *Id=@"cell";

@interface CourseSpecialDetailViewController ()<UITableViewDelegate,UITableViewDataSource,CourseSpecialDetailOneCellDelegate>{
    
    BOOL  _selected;
    
}
@property(nonatomic,strong)CourseSpecialDetailCellOneModel *model;//section1
@property(nonatomic,strong)NSArray *sec2ModelArr;
@property(nonatomic,strong)NSArray *sec3ModelArr;
@property(nonatomic,strong)UITableView *tableview;
@end

@implementation CourseSpecialDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self refreshData];
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"专题详情";
    
    _selected = 0;
    
    [self.tableview registerClass:[CourseView class] forCellReuseIdentifier:@"CourseView"];
    [self.tableview registerClass:[CourseSpecialDetailOneCell class] forCellReuseIdentifier:@"CourseSpecialDetailOneCell"];
    [self.tableview registerClass:[CourseSpecialViewCell class] forCellReuseIdentifier:@"CourseSpecialViewCell"];
    self.tableview.showsVerticalScrollIndicator=NO;
    self.tableview.showsHorizontalScrollIndicator=NO;
    
    if (self.ID != nil) {

        [self ContentCourseNetwokingWith:self.ID];
        
    }else{
        self.ID = [NSString stringWithFormat:@"%@",self.tempModel.SpecialID];
        
        [self ContentCourseNetwokingWith:self.ID];
        
        NSString *name = [NSString stringWithFormat:@"%@",self.tempModel.classesname];
        
        if (!name) {
            self.title=@"";
        }else{
            self.title=name;
        }
    }    
    
}

#pragma mark 得到专题信息
-(void)ContentCourseNetwokingWith:(NSString *)ID{
    
    NSDictionary *dic = @{@"token":[UserInfoTool getUserInfo].token ,@"projectid" : ID};

    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,Courselist];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        
        NSInteger code = [responseDic[@"rescode"] integerValue];
        
        if(code == 10000){
            
            NSDictionary *row = responseDic[@"data"];
            
            CourseSpecialDetailCellOneModel *model=[CourseSpecialDetailCellOneModel objectWithKeyValues:row];
            
            //防止model为空
            if (!model.pic) {
                model.pic=@"";
            }
            if (!model.classesname) {
                model.classesname=@"";
            }
            if (!model.descr) {
                model.descr=@"";
            }
            
            self.model=model;
            //相关课程
            
            NSArray *tempArr=responseDic[@"rows"];
            NSArray *DetailModelArr=[CourseDetailModel objectArrayWithKeyValuesArray:tempArr];
            
            for (int i=0; i<DetailModelArr.count; i++) {
                CourseDetailModel *DetailModel = DetailModelArr[i];
                
                if (!DetailModel.picurl) {
                    DetailModel.picurl=@"";
                }
                if (!DetailModel.teacher) {
                    DetailModel.teacher=@"";
                }
                if (!DetailModel.title) {
                    DetailModel.title=@"";
                }   if (!DetailModel.durtion) {
                    DetailModel.durtion=@"";
                }
                if (!DetailModel.teacherlv) {
                    DetailModel.teacherlv=@"";
                }
                if (!DetailModel.learnNum) {
                    DetailModel.learnNum=@"";
                }
                if (!DetailModel.discussNum) {
                    DetailModel.discussNum=@"";
                }
                if (!DetailModel.btnstatus) {
                    DetailModel.btnstatus=@"";
                }
            }
            self.sec2ModelArr = DetailModelArr;
            //相关专题
            [self netWorkingWithString:ID];
            
        }
    }
    fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}

//获得相关专题
-(void)netWorkingWithString:(NSString *)str{
    
    NSString *token = [UserInfoTool getUserInfo].token;
    NSString *url=[NSString stringWithFormat:@"%@%@?token=%@&projectid=%@&index=0&count=5",NetHeader,ABSpecial,token,@"336"];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:url WithParameters:nil success:^(id responseDic) {
        
        NSArray *arr = responseDic[@"rows"];
        
        NSArray *tempArr = [CourseSpecialModel objectArrayWithKeyValuesArray:arr];
        for (int i=0; i<tempArr.count; i++) {
            CourseSpecialModel *model=tempArr[i];
            if (!model.descr) {
                model.descr=@"";
            }
            if (!model.pic) {
                model.pic=@"";
            }
            if (!model.createtime) {
                model.createtime=@"";
            }
        }
        self.sec3ModelArr = tempArr;
        [self.view addSubview:self.tableview];
        //刷新数据方法
        [self.tableview reloadData];
        
    }fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}
     
#pragma tableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    bgview.backgroundColor=[UIColor whiteColor];
    
    UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 2, 20)];
    imgview.backgroundColor=[UIColor whiteColor];
    imgview.image=[UIImage imageNamed:@"hot_h_bg"];
    [bgview addSubview:imgview];
    
    
    UILabel *titrl=[[UILabel alloc]initWithFrame:CGRectMake(22, 10, 200, 20)];
    titrl.backgroundColor=[UIColor whiteColor];
    titrl.font=[UIFont systemFontOfSize:14];
    titrl.textColor = kColorBlack64;
    if(section == 1){
        titrl.text=[ManyLanguageMag  gethCourseStrWith:@"包含课程"];
    }if (section == 2) {
        titrl.text=[ManyLanguageMag  gethCourseStrWith:@"相关专题"];
    }
    [bgview addSubview:titrl];
    return bgview;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else{
        
        return 40;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return self.sec2ModelArr.count;
    }else if(section == 2){
        return self.sec3ModelArr.count;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        //动态计算高度
        
        CGSize sizeThere= [self HeightWithString:@"新伙伴欢迎你，培训部新员工培训项目组精心为你准备了这个线上课程包，帮助你更快融入，更快上手，更全面地了解公司，在皇冠足球经典推荐学习平台与小伙伴交" fontSize:13 width:self.view.width-20];
        
        CGSize size= [self HeightWithString:self.model.descr fontSize:13 width:self.view.width-20];
        if (_selected ==0) {
            if (size.height > sizeThere.height) {  //大于三行
                return sizeThere.height+self.view.width*0.4+30;
                
            }else{
                return size.height+self.view.width*0.4+30;
            }
        }else{
            
            return size.height+self.view.width*0.4+30;
            
        }
        
        
    }else if (indexPath.section==1){
        
        return self.view.width/5+20;
    }else{
        return self.view.height/3;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        CourseSpecialDetailOneCell *cell=[[CourseSpecialDetailOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CourseSpecialDetailOneCell"];
        cell.delegate=self;
        cell.model=self.model;
        cell.selectedX=_selected;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section==1){
        CourseView *cell=[[CourseView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CourseView"];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        cell.showState = YES;
        if (self.sec2ModelArr.count==0) {
            return cell;
        }else{
            if ((self.sec2ModelArr.count-1)<indexPath.row) {//防止只有一个数据
                return cell;
            }else{
                cell.model= self.sec2ModelArr[indexPath.row];
                return cell;
            }
        }
    }else{
        CourseSpecialViewCell *cell=[[CourseSpecialViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CourseSpecialViewCell"];
        if (self.sec3ModelArr.count==0) {
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            cell.model=self.sec3ModelArr[indexPath.row];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section==0) {
        
    }else if (indexPath.section == 1){//课程详情
        CourseDetailModel*model=self.sec2ModelArr[indexPath.row];

        if ([model.btnstatus isEqualToString:@"2"] || [model.btnstatus isEqualToString:@"3"]) {
            MainWebController *examController = [[MainWebController alloc] init];
            examController.webTitle = @"考试详情";
            
            NSString *url = [NSString stringWithFormat:@"%@%@?locale=%@&testid=%@",NetHeader,TestDesc,[ManyLanguageMag getTypeWithWebDiscript],model.mainid? model.mainid :model.courseid];
            
            examController.url = url;
            [self.navigationController pushViewController:examController animated:YES];
            
            return;
        }
        
        
        if (self.sec2ModelArr.count==0) {
            CourseDetailModel*model=[CourseDetailModel new];
            self.sec2ModelArr=@[model];
        }
        
        NSString *chap= model.mainid?model.mainid:model.courseid;
        [self pushToCourseDetailWithCourseId:chap];
        
        
    }else{//专题详情
        CourseSpecialModel *model=self.sec3ModelArr[indexPath.row];
        CourseSpecialDetailViewController *vc=[CourseSpecialDetailViewController new];
        vc.ID = model.SpecialID;
        [self.navigationController pushViewController:vc  animated:1];
    }
    
}
-(void)pushToCourseDetailWithCourseId:(NSString *)courseid{
    
    NSDictionary *parameter=@{
                              @"token":[UserInfoTool getUserInfo].token,
                              @"chapterid":courseid
                              };
    NSString *url=[NSString stringWithFormat:@"%@%@",NetHeader,CourseAdd];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
        NSInteger code=[responseDic[@"rescode"] integerValue];
        
        if (code == 10000)
        {
            NSDictionary *parameter = @{
                                        @"chapterid":courseid
                                        };
            
            NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,CourseDetail,[UserInfoTool getUserInfo].token];
            
            [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
                
                NSInteger code=[responseDic[@"rescode"] integerValue];
                
                NSDictionary *dic = responseDic[@"data"];
                
                if (dic.allKeys.count != 0) {
                    if (code == 10000) {
                        //到课程详情
                        
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
                }else{
                    [MBProgressHUD showError:@"课程已被删除"];
                }
                
            } fail:^(NSError *error) {
                [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"] ];
            }];
        }else if(code == 30030)
        {
            [MBProgressHUD showError:@"未开通服务用户免费课程已达上限"];
        }
        
    } fail:^(NSError *error) {

    }];
}

#pragma mark 根据文字计算长度
-(CGSize)HeightWithString:(NSString*)string fontSize:(CGFloat)fontSize width:(CGFloat)Width
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(Width, 10000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

#pragma mark 收藏delegate
-(void)collectionDele{
    NSDictionary *parameter=@{
                              @"favorite_id":self.model.ID,
                              @"type": @"40100",//收藏类型，业务码
                              @"title": self.model.classesname,
                              @"imgurl": self.model.pic
                              };
    
    NSString *url=[NSString stringWithFormat:@"%@%@?token=%@",NetHeader,Collection,[UserInfoTool getUserInfo].token];
    
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:parameter success:^(id responseDic) {
        
        NSInteger code=[responseDic[@"rescode"] integerValue];
        
        if (code == 10000) {
            
            NSString * msg = responseDic[@"msg"];

            [MBProgressHUD showSuccess:msg];
            [self refreshData];
        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"] ];
    }];
    
    
}

-(void)moreInfomationWith:(UILabel *)label{
    
    _selected = !_selected;
    
    [self.tableview  reloadData];
}

//刷新数据没有用。必须重新加载数据源 ，然后刷新数据
-(void)refreshData{
    if (self.ID!=nil) {
        [self ContentCourseNetwokingWith:self.ID];
    }else{
        self.ID=[NSString stringWithFormat:@"%@",self.tempModel.SpecialID];
        [self ContentCourseNetwokingWith:self.ID];
    }

}

@end
