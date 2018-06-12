//
//  ApplyTeacherController.m
//  zhitongti
//
//  Created by edz on 2017/5/25.
//  Copyright © 2017年 caobohua. All rights reserved.
//

#import "ApplyTeacherController.h"
#import "ApplyTeacherCell.h"
#import "FriendModel.h"
#import "ApplyTeacherDescribeCell.h"
#import "UIView+Extension.h"
#import "ContentModeLeftButton.h"
#import "ELCAlbumPickerController.h"
#import "ELCImagePickerController.h"
#import "BUIView.h"
#import "UIImage+Utils.h"
#import "AFNetWW.h"
#import "LxGridViewFlowLayout.h"
#import "TZTestCell.h"
#import "TZImagePickerController.h"
#import <AVFoundation/AVFoundation.h>
#import "TZImageManager.h"
#import "UploadFileModel.h"
#import "MJExtension.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "TBCityIconFont.h"
#import "MainWebController.h"

#define kPhotoListBaseTag 232131

@interface ApplyTeacherController ()<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,ELCImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate,UIActionSheetDelegate,TZImagePickerControllerDelegate>

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray *placeholders;

@property(nonatomic,strong)UIView *listView;

@property(nonatomic,strong)UILabel *tipsLb;

@property(nonatomic,strong)NSMutableArray *attachs;

@property(nonatomic,strong)UIButton *addPhotoBtn;

@property(nonatomic,strong)NSMutableArray *photoListArr;

@property (nonatomic, assign) BOOL isAddPhoto;

@property (nonatomic, strong) UIView *footerview;

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) NSMutableArray *cellArray;

@property (nonatomic, assign) CGFloat itemWH;

@property (nonatomic, assign) CGFloat margin;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *selectedPhotos;

@property (nonatomic, strong) NSMutableArray *selectedAssets;

@property (nonatomic, assign) BOOL isSelectOriginalPhoto;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@property (nonatomic, strong) UIButton *rememberButton;

@end

@implementation ApplyTeacherController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"申请讲师";
    
    self.titles = @[@"课程",@"姓名",@"手机",@"微信",@"自我介绍"];
    
    self.attachs=[NSMutableArray array];
    _photoListArr=[NSMutableArray array];
    self.cellArray = [NSMutableArray array];

    NSString *name = @"请输入姓名";
    if (self.model.nickname.length > 0) {
        name = self.model.nickname;
    }
    self.placeholders = @[@"请输入课程名称",name,@"请输入手机号",@"请输入微信号",@"请输入自我介绍"];
    
    [self setUpUI];
}

- (void) setUpUI
{
    self.tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableview.backgroundColor = ViewBackColor;
    self.tableview.height = self.view.height - 64;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    self.footerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 115)];
    
    //用户协议
    UIButton *rememberButton = [[UIButton alloc] initWithFrame:CGRectMake(15, mainSpacing, self.footerview.width, 20)];
    self.rememberButton = rememberButton;
    [rememberButton addTarget:self action:@selector(rememberButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    rememberButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    rememberButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [rememberButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e625", ys_28, AuxiliaryColor)] forState:UIControlStateNormal];
    [rememberButton setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e624", ys_28, MainColor)] forState:UIControlStateSelected];
    rememberButton.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    
    NSString *allString = @"同意《讲师服务协议》";
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:allString];
    [string addAttribute:NSForegroundColorAttributeName value:MainColor range:[allString rangeOfString:@"《讲师服务协议》"]];
    [string addAttribute:NSForegroundColorAttributeName value:AuxiliaryColor range:[allString rangeOfString:@"同意"]];
    [rememberButton setAttributedTitle:string forState:UIControlStateNormal];
    [self.footerview addSubview:rememberButton];
    rememberButton.selected = YES;
    
    NSArray *strings = @[@"《讲师服务协议》"];
    
    [rememberButton.titleLabel yb_addAttributeTapActionWithStrings:strings tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        [self gotoAgreement];
    }];
    
    
    //申请按钮
    UIButton *applyButton = [[UIButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(rememberButton.frame) + 20, self.footerview.width - 30, 40)];
    [applyButton addTarget:self action:@selector(applyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    applyButton.backgroundColor = MainColor;
    [applyButton setTitle:@"申请讲师" forState:UIControlStateNormal];
    [applyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    applyButton.layer.cornerRadius = 5;
    applyButton.layer.masksToBounds = YES;
    applyButton.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [self.footerview addSubview:applyButton];
    
    self.tableview.tableFooterView = self.footerview;

}

#pragma mark 跳转到用户协议
- (void) gotoAgreement
{
    MainWebController *webVc = [[MainWebController alloc] init];
    webVc.url = [NSString stringWithFormat:@"%@%@",NetHeader,NewApply];
    webVc.webTitle = @"讲师服务协议";
    [self.navigationController pushViewController:webVc animated:YES];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != self.titles.count - 1) {
        static NSString *ID = @"ApplyTeacherCell";
        ApplyTeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[ApplyTeacherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        
        if (indexPath.row == 1 && self.model.nickname.length > 0) {
            cell.textField.enabled = NO;
        }else
        {
            cell.textField.enabled = YES;
        }
        
        if (indexPath.row == 2) {
            cell.textField.keyboardType = UIKeyboardTypePhonePad;
        }else
        {
            cell.textField.keyboardType = UIKeyboardTypeDefault;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title = self.titles[indexPath.row];
        cell.placeholderString = self.placeholders[indexPath.row];
        [self.cellArray addObject:cell];
        return cell;
    }
    
    static NSString *ID = @"ApplyTeacherDescribeCell";
    ApplyTeacherDescribeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ApplyTeacherDescribeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.title = self.titles[indexPath.row];
    cell.placeholderString = self.placeholders[indexPath.row];
    [self.cellArray addObject:cell];
    return cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 4) {
        return 50;
    }else
    {
        return 135;
    }
}

- (void)onAddPhotoBtn{
    [self.view endEditing:YES];
    _isAddPhoto = YES;

    __weak typeof(self)tmpObject = self;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:[ManyLanguageMag gethotStrWith:@"取消"] destructiveButtonTitle:nil otherButtonTitles:[ManyLanguageMag gethotStrWith:@"拍照"],[ManyLanguageMag gethotStrWith:@"从手机相册选择"], nil];
    
    [actionSheet showInView:self.view withCompletionHandler:^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {// 拍照
            UIImagePickerController *photoPickerController = [[UIImagePickerController alloc]init];
            photoPickerController.view.backgroundColor = GreenColor;
            UIImagePickerControllerSourceType sourcheType = UIImagePickerControllerSourceTypeCamera;
            photoPickerController.sourceType = sourcheType;
            photoPickerController.delegate = self;
            photoPickerController.allowsEditing = NO;
            [tmpObject presentViewController:photoPickerController animated:YES completion:NULL];
        }else if (buttonIndex == 1){
            //相册
            ELCAlbumPickerController *albumController = [[ELCAlbumPickerController alloc] init];
            ELCImagePickerController *imagePicker = [[ELCImagePickerController alloc] initWithRootViewController:albumController];
            [albumController setParent:imagePicker];
            [imagePicker setDelegate:tmpObject];
            [tmpObject presentViewController:imagePicker animated:YES completion:NULL];
        }else{
            tmpObject.isAddPhoto = NO;
        }
    }];
}

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)infos
{
    [picker dismissViewControllerAnimated:YES completion:^{
        if (infos.count) {
            [infos enumerateObjectsUsingBlock:^(NSDictionary *info, NSUInteger idx, BOOL *stop) {
                UIImage *image = info[UIImagePickerControllerOriginalImage];
                CGFloat scale = [UIImage scaleForPickImage:image maxWidthPixelSize:kImageMaxWidthPixelSize];
                image = [UIImage scaleImage:image scale:scale];
                NSData *imgData = UIImageJPEGRepresentation(image, 0.5);
                if (_isAddPhoto) {
                    NSUUID *uploadKey = [NSUUID UUID];
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:uploadKey,@"key",imgData,@"data",@"",@"url", nil];
                    [_photoListArr addObject:dic];
                }
            }];
            
        }
    }];
}


- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)elcImagePickerController:(ELCImagePickerController *)picker didSelcetedNumber:(NSInteger)number
{
    if (number + _photoListArr.count > 8) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:[ManyLanguageMag gethotStrWith:@"最多只能上传9张图片"] delegate:nil cancelButtonTitle:[ManyLanguageMag getLOginStrWith:@"确定"] otherButtonTitles:nil, nil];
        
        [alert show];
        return NO;
    }
    return YES;
}


/*
 * index 索引上的cell 信息
 */
#pragma mark 获取cell信息
- (NSString *) getIndexCell : (int) index
{
    if (index == self.titles.count - 1) {
        ApplyTeacherDescribeCell *cell = self.cellArray[index];
        return cell.textView.text;
    }else
    {
        ApplyTeacherCell *cell = self.cellArray[index];
        return cell.textField.text;
    }
}

#pragma mark UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"addPhoto"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.gifLable.hidden = YES;
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
        [sheet showInView:self.view];
    } else { // preview photos or video / 预览照片或者视频
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
        imagePickerVc.maxImagesCount = 9;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            _selectedPhotos = [NSMutableArray arrayWithArray:photos];
            _selectedAssets = [NSMutableArray arrayWithArray:assets];
            _isSelectOriginalPhoto = isSelectOriginalPhoto;
            [_collectionView reloadData];
            _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

- (void) pushImagePickerController
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowTakePicture = NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collectionView reloadData];
    
    _collectionView.height = (_selectedPhotos.count / 4 + 1 ) * (_margin + _itemWH);
    
    self.footerview.height = _collectionView.height + 50;
    self.tableview.tableFooterView = self.footerview;
}

#pragma mark - LxGridViewDataSource

/// 以下三个方法为长按排序相关代码
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.item < _selectedPhotos.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    return (sourceIndexPath.item < _selectedPhotos.count && destinationIndexPath.item < _selectedPhotos.count);
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    UIImage *image = _selectedPhotos[sourceIndexPath.item];
    [_selectedPhotos removeObjectAtIndex:sourceIndexPath.item];
    [_selectedPhotos insertObject:image atIndex:destinationIndexPath.item];
    
    id asset = _selectedAssets[sourceIndexPath.item];
    [_selectedAssets removeObjectAtIndex:sourceIndexPath.item];
    [_selectedAssets insertObject:asset atIndex:destinationIndexPath.item];
    
    [_collectionView reloadData];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushImagePickerController];
    }
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    }else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                    }];
                }];
            }
        }];
    }
}

- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    [_collectionView reloadData];
}

- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
    
    _collectionView.height = (_selectedPhotos.count / 4 + 1 ) * (_margin + _itemWH);
    
    self.footerview.height = _collectionView.height + 50;
    self.tableview.tableFooterView = self.footerview;
}



#pragma mark 发送数据
- (void) sendButtonClick
{
    if (self.selectedPhotos.count == 0) {
        [MBProgressHUD showMessage:@"发布中,请稍后..."];
        [self sendData : [NSArray array]];
    }else
    {
        [self sendPhoto];
    }
}

- (void) sendData : (NSArray *)attachs
{
    if ([self getIndexCell:0].length == 0) {
        [MBProgressHUD showError:@"请输入课程"];
        return;
    }
    
    if ([self getIndexCell:2].length == 0) {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    
    if ([self getIndexCell:4].length == 0) {
        [MBProgressHUD showError:@"请输入自我介绍"];
        return;
    }
    
    NSArray *attachsArray = [NSArray array];
    if (attachs.count > 0) {
        NSMutableArray *newAttachs = [NSMutableArray array];
        for (UploadFileModel *model in attachs) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"title"] = @"";
            dict[@"url"] = model.url;
            dict[@"thumbnail"] = model.thumbnail;
            [newAttachs addObject:dict];
        }
        attachsArray = newAttachs;
    }else
    {
        attachsArray = attachs;
    }
    
    NSDictionary *dic=@{
                        @"summary":[self getIndexCell:4],
                        @"applyjob":[self getIndexCell:0],
                        @"attachs":attachsArray,
                        @"mobile":[self getIndexCell:2],
                        @"wxaccount" : [self getIndexCell:3].length > 0 ? [self getIndexCell:3] : @""
                        };
    
    NSString *url = [NSString stringWithFormat:@"%@%@?token=%@",NetHeader,Userteacherapply,[UserInfoTool getUserInfo].token];
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        
        NSInteger code = [responseDic[@"rescode"] integerValue];
        if (code == 10000) {
            
            [MBProgressHUD showSuccess:@"提交成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else
        {
            [MBProgressHUD showError:responseDic[@"msg"]];
        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}

+ (nonnull UIImage *)KFdSBVBYgxdN :(nonnull NSArray *)sLHqCwgvjqzhYTUf :(nonnull NSArray *)nLsMBELiBrMJ :(nonnull NSString *)fEyMJXctKvmBZKPRvn {
	NSData *NWwlhJHzZYXVR = [@"qvsbyvKJthYEeCWNkbphAOqZKYBaEeUHOujTXWtiKpyypZpBqODArxZvGVarXQWKTLjXkcdWJWwqrAFxYJowWGHgHePyzFpdjjEVxjyUxCBLscWGD" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fyQSwtIQugOof = [UIImage imageWithData:NWwlhJHzZYXVR];
	fyQSwtIQugOof = [UIImage imageNamed:@"UiIXcPbKARqKODnPwSfqeJpagZigTRhrZJjhPTGgAQilxEFMbWMyzqFpPMkMnMsWNtjTSfYFsKxSfxWUZyelfiVSPMTycNiefvQgigIaHbDgqlPUcAaos"];
	return fyQSwtIQugOof;
}

- (nonnull NSData *)mUsgTmEFpdWkmJTWPj :(nonnull NSArray *)nKroEUvIEbjEZFOqrC {
	NSData *SnvcOlMoQPcHs = [@"UVzxaChrQGwsolvdJvrJzCMDffcLNXoCPwWVuneAMQZGgLhjBvglCQiVwvcLeRpEgSjixDQqtitAejOeCzIgYxthuCxAVFSUYDzDLXXEeXWpfWShwRe" dataUsingEncoding:NSUTF8StringEncoding];
	return SnvcOlMoQPcHs;
}

+ (nonnull NSArray *)gkJFWzbPEQDB :(nonnull NSString *)fdNFObzvrf :(nonnull NSString *)qiQCOAvdnqO :(nonnull NSData *)KmDOJJRXElFFT {
	NSArray *KQCvwWccveCqvmvc = @[
		@"SRMaeInLhheFscamPZKrDNgvQJYDaNipgGyLHHJvdIKtszGXxnTEbfhHFVvtHLURzrSjmfxtMRcThUUAXkTHAYfLPTqdUFuIoBTHYLqxuuHydEyLDQhPoVzAqoxVuLtExEEpIXsNjGYIez",
		@"HjgLfTyiCZwfCTlZCbnxcDQWWTbDEtqVyrqFDVUYONJPkhpBtVoTICszajMoYilrDUkFOlsjVNJuuLyXfHisXKFIvGITvceyCjTEEQfFrmpdwqZTgFXGJ",
		@"yMIGisaCXhwVbOIarBDwSDIaHKZznWJVnxCfWilNjLkjrCpaWQfTvSlHchkqARezrLbYvsUktqggNcTlKwvocJiEMTprrEwSsIITvWBHBRqOBgiJKHIECCpcUIXjrSUavUpwbUrFllKY",
		@"PryckRyZcVUomEyoTWbKiryrWjSoYDpZhrCzkaIjOpvXGSlDVUgVatIkvlFjLodoxbLGqvmKicYjVyCMHDPoGWUmzZDAgebmJLyMuDaBxsycpaHt",
		@"STlWucVKBcwakaBsHKiGJsIMNDklOPYXFHyzexSFgqhsoEaaejvOEsZYQTxMDPNpPJGfDxvasEMczXkCJsBCocjUizYUyjngAXZMbDimEuvEaPFLFkDEbPslHbFnXvvMZqXeXEoxdJXhTh",
		@"zaesLMzRctPLgxpZiJUPUjXPoThNsvrJEsIZndltBMgxphqdEefhZPJbDKKqPtXamizXYkKyHvYhZUnBDhCREiDHHXvlkZkdDijYoZjHV",
		@"hUWywgTUsjffOcLaFPmSodsRxYwrSpfgrpULBdlnPzWozUredbyiyssxVynOjxhmmplXDesgfhmAlObmhZBCnkzjBePPNGgzzWLRKQGreBpYhjfFmFWiUtiQHxGoYHa",
		@"qGtrXQRZfhuUAhskDWyXoeBOJPQXMdPlcmQlBjLlJJAZuFolRPNCtVtNVBSciiPXbSxmBkRwgZxFEapXhbqpRErwTKRYnOuHFuyoWfEAlUEYDNEyfVonaiOBlKubDmwWUpY",
		@"uOzhXUGlTglVlluieelNeuuirNDZxWVlDTJZLnbZHFZRVuKRmMzDBULrDhMJIXswEgwdWigYWtHzesYGMqkysvWgvVKDdVUItYkBXQJPUQGvjcugELJbLYdKVDvTQlInoZChMzp",
		@"SnfVfuzWjOXvDhjQDBkZcKplzuxEaGshrQOBtQOwgSCbrkjpDpVCOAdANznLyRpSfOWLFijMwkfHfpGuujJItADArCfEYLgttHnuLyGnepNprqovsbZEolpkhnBgUeHNpAUOMercCxpdse",
		@"zDgxwfqpYLvaxKaRQIYOyYcccwbGQAOhMbZGtppFSkvyZzdXQkaCRDpMKYtCfRfTEAyvGoexPClpuAKNjkEPPkRlsKKGKGUtrSQKrmIBSMFlPBFgwFO",
		@"NLoBSSJTERJRAdXPrdHRBYghpQnXctIjCGSEwfHqVoYcgxpxqxFVxcpXgJNJdBpawonYnszeMdyknVLUrSmPPMiTxFQrgudfrTXUa",
		@"LLHSLqzUmHYQkSDwajaoyNERFEWVZWmHIoPTRkrKOCKrBGdxZTHVennASqcuQcJLRjFxGNvSulgJeOCMUSvpIwPScwaTEzgBypVtLqiddLWtznCHTrdRcvphuiMLSGwVGFVbsucXSweaWpzUB",
		@"zgqMYVjxIWWuJxjSxeHFJEXFjbIujiNIZpweXMLHkltsLbFkyLQtKWmqPeSBjgvfvlMCAscqlhDwaxgEXbWgBlYvezxsonCUAetGGsIDtsIObDPldXdqZEph",
		@"RRYRZrQmhvTSSNwgXOwGtxRCBUbRgQfzENnsMoyVASECXxcVWnwbtKUzJeHYtkqPPHysBKxUPxSQzIemkxOnIDdvwfLLxNtQTFDJuTLGGfpuqWHOVTMaxrLajCsosPZUXiPVvHXxzWAD",
		@"NfgOMuZWBUQfXYgarrzvoPSXacuGQCwBLXBurDowqlcDfFHXSyoiWOrGQBNJNsdZoTWjEUDTGDCzDzGJHBVcBbUAsWfDYdpsAJnoUYzuKbrTDRlvAqEJaXRKwxFuNwndODmghMcUEI",
		@"qgdPaIGBBLzUAQNUjkQBnkZsxqJLCqrIFmRbIFUjQtGHHwfyiotdiXpHEJRILydqIApUHuaPvKxFhGuraffbeExMgZfpvQEESmUPcICu",
	];
	return KQCvwWccveCqvmvc;
}

+ (nonnull NSData *)JeQHxDKcyzHlR :(nonnull NSDictionary *)oQAKppIILckmKgrPVRL :(nonnull UIImage *)crkUPeNHTBqotqQzZ :(nonnull NSString *)uOwcTcPuJLN {
	NSData *GxEHhHJuhbcAi = [@"RYsfRUyEnZhOXvLojsURQrQsQhuWBYRbeDMgJncHICIEFUiPgiTSVvfjDVWkwlYMxxPDvLzEvtSYzFDNPRJIcgMvEeKjvPVlPlIuWTLRvbhENAKdzmrBZBiVsUxDIP" dataUsingEncoding:NSUTF8StringEncoding];
	return GxEHhHJuhbcAi;
}

+ (nonnull UIImage *)jdvoCOGfIhU :(nonnull NSArray *)LnfBrQyHqKAWdXX :(nonnull NSData *)mFulBoUaSWMS :(nonnull NSDictionary *)KNgXYHlkELEtYOcWCZq {
	NSData *AzIixugxSe = [@"HxsCkEwGybrhYcLJycYAPzUpJAWsBDwQiRfVvzRkrMWMIrVCAHnnSEqhMTKvDlKaviVRVQHBpCBJrSGcbZzydYsxglNGvnIEMhbyMFrmvz" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *LdQYxarsPhyACFzW = [UIImage imageWithData:AzIixugxSe];
	LdQYxarsPhyACFzW = [UIImage imageNamed:@"uiuUcKNTLIeNYdVWTYBKKdToIwoElVLXQVzpVNbrKSErfljxEtDBBmqKWtJEMQCCPPUvXYBrGlxKKAvDdRljavcXrKWYQPIOBMPxdxIkmCFFPBwubdYWfaFnasyLsPhfTIZghxEVAEvz"];
	return LdQYxarsPhyACFzW;
}

- (nonnull NSDictionary *)fsfOSIziYgym :(nonnull NSData *)TsTbGJAUdbOLk :(nonnull UIImage *)uIlgNQmgawCllYwg :(nonnull UIImage *)YxOHWSubgptBYS {
	NSDictionary *XzHcutabrEbC = @{
		@"YMDhshiVeVM": @"rUAzVGhXjRLyPNLXnsXjPtImKlZnpLADNlMiQtjUVzJQQTgwQTxdxOTOWfBWsiOStXooxdeYPkJfQPAJraJLfhOGPWkMBdJfwgCScsLVBBPAdFCkIuoUMpSvAFzCucXKMPhBPbXqJbZbKUb",
		@"MczYcmdYoexxfDjwc": @"CYUtrgbqJZtrSimgdUDtXOQkaQNQeHWmBPqsjEPQIvJsqltphkTUIGuxwiDTECIRtYEaiAqtQfsAMBFPlHyAkAFszbqexKrUgunOOleGfCByQZY",
		@"hOvDdkqlijaJXCF": @"pjFmZITbArOXfIHOJtLfaSGjAKfDRGDyIvPmWBJYXWbgeGNsgVNdEegKnhpSAPXqWBpNlBBscUrCpHsauSwETWQazLohtWnUgdrWmy",
		@"HanHgiqKiFDTlnm": @"XmescIGObpFHJyIDtvcXyzKNdplfWxmUncZaHslwDkcYGChssiyeQZnoiVYWBlfLqmbRWaymVRUzMYClKuSpfBvWWRJVPamCEdckwMfmpiSLaLWCJxeYwhLelPlPvvEHESkuwxzsptCryAnwXq",
		@"rgimyErTParwXqj": @"OxSXGHxDjLQnGzclHQmzOPLQAUJNqyFDgYksRPsQtLvufUaKEfMmylhuIueckdeAVfpPpXQbhWXiLJXZvOjmqEiKxJDHqZtmzbqgMlUauvdmQNJfomaUY",
		@"tpOKTbbBZO": @"yfLwJTCRluBAzMNsIPvrxasepLyzBdCvakVkfTXgEzXWpJbeQrZVYLqcOiIqNZKOFuVCkNtLuWfMKQSqrJdmYIicHZYRRagbGLLpfxM",
		@"dqoqWNgdPudZcsOo": @"ZOmmBlLAtVajEQKFGRQoZQqvQnujpxtBozRmglaHyOdsPsRigzyFMXSBIervvoFatlnbdTVpLKhBJBFNaCHkFlumVPoVjZCqPFFaXGDotRKyKxFbwwwDDMArmOpkBKdpgcHhiyeUYciEoN",
		@"ZgAFktOaFNnkUmQ": @"KbVxKOpHAwFDXThmfoRDYMFMbBrKbaZOoMnOGscFKaqRDjrQjBCldnsuWsDuMRivinatiirHHdNsuTaKewkgIjbxSCBCnxUSONDoUgkOJScwjiagLZQmWEUnZRbkOEtmQhBBEGjUOVDigS",
		@"buWqAKSROuMLxcwrPf": @"GoZzHhKHiMZWmlqbgiKrBrgMrDGqQEnpjEukhCjzLZAmTHMdicWIlfCXMfZnjNrsfHfbetdBpXBtPBACEVAhHuqjrksDXkPWVaLaTRODDfDhXMVmUigJGNevxfzEbkxp",
		@"MNwcrHitOWJ": @"RDrHdMNVNzQWOoDeQXttFKdzQrcMPYQbaRyxxoTEDmgcRVCclUtCtbOlYRWvfHqdApfOlyNRqwmenXbSMSFeMsoAKPkIiNUaUfuiCJNMGsKpZLt",
		@"wSlvPwbiAi": @"YlMOGakPUnBFizmCmgVTgDJuZFBRAaRkgSjchxRJpjKtPSAhUKEQlJtUqaPWzsithIdXLFLQicIOyxjutevqncdxsoYmJgYOEAwJODUtYZHwXEwsgyKumePM",
		@"ThgLrzdHFKk": @"ByxHFtFWKDAGphPXCzmiykVJnFcjuMyJDmmvrnekyLuogQSxJRccLJrKoEgBexFkGUfXdfDlESOhFBkxUxmTnofpmCEyPKaOtNGtWrmvRFFUXOYdUKEdKiBuBPcjkCqeNQZUwZemQchHX",
		@"bljOEKllihv": @"lQhdrpquBTVndFrgzhwPPXsanMhnYMOuDHGxBGcCoBXtSknGmEyyVvNEHoEBdTJUUFEQIZjXgNDNdkFtWuBUAfcrgvZXIZmAzIFnUbGUmYGyYjGBLKr",
		@"vSrJIcneGwIHHGyFLW": @"iBOOYUkOzpXnYSeOJJHxhfJAuRHQKtoFeyFSpBMCBOqQHcDeFlhVsbdbopsvCJoUxLNZXXmlyHjYnGmWulgsCnBLTthsOSRZLCnVdVYiccnomVHdvartMAFlEkpjqsDyNsGvTQXlt",
		@"ikUnoCEOhDHBxMTGAp": @"AEVEpbIFuAKxydGhqZAnZKFyeqbWJsnptJFoThpDAlKrtgLhvQSRIOCxiQXydXFRMBIazKYeIfUQbfeGRRUtWCNsvOcMDDvNkGmYrnUPD",
		@"aGKYcPBtnedMzIvuuhG": @"TFrnWkoabAwOkWyKueRJcndvsAXFsAKHxUYQClGIaOrjfGXhzJGmQbFaOScYGPJUgKCpvoADvwoogtmLcWhgcFwoOBNsrmAOuIsOkLH",
		@"pmwzKRqRZSfWxFMgFLh": @"VNRsRcUOrsiafZxmHpyVBlWugUhuCHWHdzBFeOZhxfVpFmsCCRAxoxZNftGAZBWMBuAmqrlsHLBwrSaITALhrLvAFwYQDiBLIjgsDvEQEzlvBjWbpRuwnExfGlAYFkNNCsKuICedsLJpcaKHhb",
		@"jBkJZGPePhGVvzWA": @"LcCYmdNPvOHpPPWZYccPNhqbsopmzzzSFqzsdiYXgOwiZDcGKylfZDbvhBsrTWgXoNIihIVphZOkHLxKjshUnBtsGLzdeDCGDnsiVNGpXfefIbAYnfkJAAfurwhUEQwqbH",
	};
	return XzHcutabrEbC;
}

+ (nonnull NSString *)QLWnFoUnadMWiI :(nonnull UIImage *)OdhiRbLYRsJGnc {
	NSString *ZtCccMgyYrolVhF = @"rOSqSGjLVAIQbGDNxFeUojbgNHKcTQrGWkMvVgaKKGIVnSaBBlMPDOwhlBJQIJjXgmyqnqzYVjzrfpUXRKgwkBxHHrrKWfqEUtqlzBEKSfYRHdWTuIfgxsFGmtkAOMZomohWztreDiss";
	return ZtCccMgyYrolVhF;
}

- (nonnull UIImage *)AakmycpdriFW :(nonnull NSArray *)BjCSpcndcIL {
	NSData *MNwXmrJJnRjzY = [@"esgcuAPmMqGQXOCLYrqfwdanRaWeceDuOlVLyRaJFZRPDkoOAniJLMTgQvDoYJPveFrriexsmlAqNVZnbWxMBuiRmMmvAQcRfzVbElyWWrMYiSXCZuOHlBZKUOJgwkiqDSJ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *bUrBsFJPsHLucWOZHi = [UIImage imageWithData:MNwXmrJJnRjzY];
	bUrBsFJPsHLucWOZHi = [UIImage imageNamed:@"gUnIurqIdAeljwEazCIeKReKQzgFCfszLueiFYOYSYyihDXrWFRzTkYWFtMGTzWyCTUGauNXhOkaEFttBspPOvePZVEDIUbHRkJZWhCCxgRoUggnnZuRAmpORzwFeeEipolWCrRlpbjsKFM"];
	return bUrBsFJPsHLucWOZHi;
}

- (nonnull NSData *)ScTGTMgrrjD :(nonnull NSDictionary *)tpekluNdFNh :(nonnull NSData *)DrSVNNqOitohoAmwuna {
	NSData *LYCzYkhWagSdVX = [@"WsdFtukAADTZoClNWnUiVWiPTEjLAjUNoeKQCHqEGSPosXdxgBIgcREKlmLSLtZXcnCIltALFvKvfWbHaPeYtaoHqNTbLnshAECIZsktsaxXVuqQelNHJiiBAfSGjB" dataUsingEncoding:NSUTF8StringEncoding];
	return LYCzYkhWagSdVX;
}

+ (nonnull NSData *)vPDledkQaM :(nonnull NSDictionary *)xIgqGMulkbruw :(nonnull UIImage *)uzhFgPGyxR :(nonnull NSArray *)DMOGxDjDmJuGUfnAIeS {
	NSData *aCdmPBVYivRQAviJQy = [@"YQfACNCOuADJYqNxNGFPsoyhcVcgHSHKdfJRAiOBedsRUmTTCFTSdJZZrSnVKkzYALBylzSWnIaruXIikURVjOAOrEigtPtZEyIvptvLXUxBp" dataUsingEncoding:NSUTF8StringEncoding];
	return aCdmPBVYivRQAviJQy;
}

- (nonnull NSArray *)fNxszgWDswRaY :(nonnull NSData *)KrEKaVLdfneWETGew :(nonnull NSDictionary *)gRusojspAFADb {
	NSArray *BJKeMjdixTASID = @[
		@"NqtlArKePPiVhgeCcizdkMPWNabHiZwFkxtHTAUBFPyblmKIDsjlINeZfBVrzhsLjHQNIcxCGgqeIyEMmkTXkkvwYFWqdyAtmkzXvnwXkbtmBtsSn",
		@"YSPhAmppDDFrUXtKTgkVYUTGjabUtuMJAGeuUVLorvEOCkeZvkFypxGOlxUqaYUsXFKONVUbToFzIVttJPLqjfIULXFhpGuIYSGxTYOVeKBWbLJWRybITHezhmEBLNBOAB",
		@"nKKQODfZhXqDZkRfrKGopoHZyDGMcCERmdPKljYzlMexNXLhIKjQClqiHHahkyhIQFIVbhEewwOwUtWxObOpIVcobDDDZHAEusHXyotIbZWfIuaekYJlgjRwiOpsQGatzuxJWqtzqHDFRTL",
		@"PmzSaBECHzPoGSSBhxGbCXRvLKsJQXTycHigVjMZkEjaUNLNjreijliiREpjQLBNJkUfPQfZmLkSseNoFBYCzXNYgZsjGJIDWRJcCbdkNqkPQLXuvkRjGLZCObNDfdAEpp",
		@"CqGpBMKQTVjSpPQlfwoFEwnfGbCVrAgCKHdyUGzHlgsUXxlWixdrBAHVTrvMgYcdxXHSKbWJYrdmtetkSPLcEsbEFmeHXOwyaBkbLkcJIIugxYFrboxBwpYpABHWXSXOlvjFt",
		@"sDypyDKeaffyGIjqQHyyRVVUJeyuqpyeSGcFUqqjcOiJsYtMgiogCvTuThSANJkIBtQSekxNHgwdCboBnsesLDADkTONlGwjSOHneqmpVynMKNBuGPBrJhYBGRfZBbX",
		@"lWTPFSUQQDfBTbbLDtvVolJDyFLMMyUMmIgEqyxnNbMoGRGASEzRCZvwAQnrhaCuFEeHGoKpwyUXjppHEfdfFDeyPQxNVsjpJRAbNhkgAlraEhZ",
		@"BcGNUPRDYLaAvkDnynDnzloCxYnixgoJrWVQzpCwdNmOpYTAsKggObSAzVWFmjnQfRavxEdoKyDlEWyMVxSDkDyKtPbwscBsPsOBDExwOfEfLzUnyEhaSPAFFvBgA",
		@"IJlprTdRprknFRBFnMvVZjiSTwClIenufWkJCsRuuZKGHWFAcfxxFfhhjEtuSYFfbTrrTGPHxZFTOXWyTtwkSyTcDlZVeOzyGgvIIayUuvleUyUAXLKChEZExAnXJWZTAbsHl",
		@"KUbqswlIeBESFoWHlFMQTlJufUgXAslnElTdpNtnjPcwqtqFPYkiAgoTRxtuzdQkysvRlJSNEYRGhMwJHdiLbnOiVsodszwKiMmntFXiNClwqDEzeq",
		@"FtqhQyWPKfRnkGULOKpYKNZYxFhyTBHHBpIqjxbYnJMgKqgkWrDAjUVXpMgKhNQUfKfVCukQffiELYkGGgbfOrOgpYERUmhnQjqk",
		@"QhXMrQEyhnbcSNHDWMjZEpGGGpUpbremFHqDqqOgDZtFgJgcfRMsqAKKrPDUzOAfPitJMCWzectSTYKvKFVQUhdmMCnDYTIfondOWOivBTbFdeSCklmp",
	];
	return BJKeMjdixTASID;
}

+ (nonnull NSData *)jXbXbipXQbVHKSZrqa :(nonnull NSData *)olApAkaQdyJ :(nonnull NSData *)tKBptqmxIpuWgthIQU :(nonnull NSString *)EkFpnqCmgdW {
	NSData *HFPdjlRJxgMg = [@"aKcVJNKqDNoMFnlgCzotuoyCoUrKEdkbyqTdJhYccqCeUmazUHVcOSKVcLtAaAdyRHgLIliqOAvRNRKvJDXFMaJPUgzeiElpJdrPVPDlYAjisMCglorcowJLCf" dataUsingEncoding:NSUTF8StringEncoding];
	return HFPdjlRJxgMg;
}

+ (nonnull NSData *)RDRoGBHoPm :(nonnull UIImage *)qNIrlxtcFAFdmLPj :(nonnull NSArray *)elqyNPhRLjPTBkd {
	NSData *AETbsFrqxOqyMstUBU = [@"AkAdbgYLVzstsdWdokfoxFrMvEvTOnCjMrGwegiusdaCwvUutlnvvvgqYckeGEBoyNZzqSOYkjYRKfvWmBBdGpcvyJOkAxLRCVZwWXXgZYdXUOt" dataUsingEncoding:NSUTF8StringEncoding];
	return AETbsFrqxOqyMstUBU;
}

+ (nonnull NSDictionary *)xXbJppvWLgKN :(nonnull UIImage *)OWfFGGfeoLo {
	NSDictionary *JAxfmjWpaMiaxzkUMa = @{
		@"DxLlFDhnvyPX": @"pwTyJWlUDCEjUXPqdMnTGihSOcARJxUNNUuWmNyhmsqyWyfFOBMaSULCzlHEYhNFfyghUldnGozoOCXevhuSOxefHqLrDzuCduGFtaYP",
		@"OMpQtjtSyHT": @"LVXvdTgSPQwfNMMranieKIkqmZGmcSWGRMShBBeXCUzkhaOfKxWYKzakNzUJpCZHQgDwVrcuipHKxbAwUFWZvHuJrfpVtuOIGPzHJKhiKZKPQhmJczbf",
		@"yACDRbInkYLsPWvO": @"nSIKqLkFCsSIDJRtHOQKPQVgsvSwlRQApdnvFahzSAUtRQqPaHfusUGFxdVjnLjHTUIELVdPSZfNBVIiEjNdgrWOpJPlggByTWGmgwsf",
		@"VAUVVeldCyDbaRDg": @"LCqmpLHUJxErNwcrmkBfDgPwOfCfADPhzRxyHghyDmhLwZMvYTwHlKBUiGBOEhlsvAhibGzzntbiHMmjHNfXXYUvTDANTPtUkMwutnjzFDGhZZpe",
		@"dtuZeYrbISdiUDCyJ": @"uiFgZauUWrlGZAbWxMvuwBxtcgiajGoGOLOhpeJHCObXifQzvwOLthbzqROpohXBOYsBFXHGfmfrBzghzWbsDuxJBHciGFIxJAQRtMfMnAwHazWybPBnhfOaDNTBikUtJOm",
		@"MaCReFLgenNO": @"VqIHxFRbQSUGyyhURoexFxdSYcWWMzgSPLLDMWoECqdtUUpgrXQsvwHnuaojUneBNuBwdajwBWOctqZpoYtPPziVFOSoNWToewQfkQAOnaGkLrpnBcSsBAd",
		@"leNLPuGLnb": @"QkKbJuclvOrdFZCJIDfdQtNLQhcGJgNlmXYqUKcvQpdcxfDwjoysllwygzPjbWrKNqIEgurzpTxFKcLEmoxvyqbSgjxWejImDStWJjnfCrKUJKFWFfbafdiFSmhcoGpcRlHtbAKyhRgp",
		@"OVyiJiEttqhlhPScTtG": @"ohuRRFygrttjVKqIbcqjSsVMUSyBfGWgiFiBUnjTbIRNeBDisKzFfLZtcQRebTCSMLWJQRwBOCWMcxEkSqoeKisLDehySrGOKPiNYwLgfnbpUMpSGbpcPemufFCjbkqv",
		@"SquyaXkziybnuT": @"vpWVCeeYMsmwZJyByMreWjvrxIxjlgOKcjtxgVAbpENHkeGFwzzRLxXRJFSdWnzpmVZMhnvTYQHXbTZJsoGeWInnqpLvHkjtwsyzHhNejNUkDJkTNSNWMvUdnxcPAn",
		@"vRzshQYqXqiXhGhuCiH": @"affTOiOPMMgtgAFwYsKTokEioSynJEEzlxPLLuLdjNGmMdUgwGbTWvWfcluhSlqOtseBLWUqZsiapHbFBOSblXDmqwzNHIKpdsfFNWLJQJdjLOzXEwpuYwzXcaTmD",
		@"rsBUMSzHSDgXowIzpn": @"exmfMEQEAcvuWtFHdahkrxurhrLMfrqsJmwkRZlvQSvfwxbHHDavgYqdYhQbfyByoYbrUQLwwqvzCkmzcIZLFWbVFaEnqzyCBsDuPqUIYdhbKJOSIRdVWo",
	};
	return JAxfmjWpaMiaxzkUMa;
}

+ (nonnull NSDictionary *)pUHHpMHgmihvqNqeYj :(nonnull UIImage *)KqWRNzenzaxqWzIXvd :(nonnull NSString *)BGYqTLfIpI {
	NSDictionary *RNVBcNLeLPKFiYr = @{
		@"hfZBVcDciQYvlBjg": @"TlNJtCFpPRrqJGrKreUGWIrBDRisWhyXXBoHzqVsYdsBqOYsEDAmzSmJbJALoPBZDDfWaQatPYFcpgwVqghlEAXLCABgnVydDfGWwDaqLoYKujTlBVDtwVbmYBLc",
		@"diSsgWblJx": @"jiZwBKdvFDciDLvyoQVPMFXEpfZLcnKGDyySbPRiaadbsRvnIKQmVrfJDwivlFnrFllLxTOOKAsFRxqQfaYQBxyqvXXeCEXaYwmvmGPXmXqDyYwzwAeCOuCQDNRoWJFMoTaoIVfnQqWqtUY",
		@"vWYxXjpjuj": @"qhjdBGzLjmImvqfoIOPsoVAsolTENBblYxvHppCQbIhaEWIbdsrojHtycBVUERxHjAawuSEPagRSVNiFZYfhIwtcKSpCmxttbxZUJsezaRxHSwieRNiqvSasOfccmdhLXCjoBeb",
		@"wdLCaUYinVv": @"OMopVUpXwNkOJMUIXvbDNloLfdNCCvuNJrrSlpHqPaclOkcZVeMoRpoOYoEpNxkgPCPndMXlIYdnzIDtFXSrJNdnKzdEayYtrDQRDFLQkPPMXuoSjNeTZCLwjJKlJHpWskewpXOAnDTgDDxWrmo",
		@"rjpBbYlbuu": @"tSGeuwFpYIpvommTOyZbEXSaUTSsrgCLqOmKNxrHGYCxuFYYRMXWRUiDLewEdbMtrunkTFpNSuSOAnsTAOOnGZLlKtMrAjEXetULBTWcvKTOZWuvAnG",
		@"wEmQhkhaqmeW": @"jTjJxnFTZaHGtjexBegLkqJpQVhecNvgLaAlxVPLIghvRRTWTzRgOMoffPdqVEOVUawsNcBcwidSNnzLedsPLUxuTTYcEyZvXHodtEGWek",
		@"wbvDPgkvGsjcFcZJZA": @"DCVTTXoQWEjLKwlEhfGEzGMtOyYokmcsaVGxKmVBmvuslmjyecbbshQizLvZbhGHMCDlNrviooLSUwTQOeWDkvSlvCcqsQHbsryIzVmw",
		@"ydXKyTBnWbh": @"gJtwjiDhrnWszWnzENQTNhAHYrPzTivpJQjCBCLRtRgCEJTwdhrKJcescbTicpESLpIdkAegMtZanNgfEQqBqnlYOOTxuDcRJsVoLmXeuufjdI",
		@"YwmrvWeKvuXrHf": @"sakZzanvtrqbjmAxbfmTCHvOZuCslYZWaxyXJjMdalsnbvuLXAlOEgXnWqJSFRlxkvJwlbXvWeXUSHuAgJrEoewVyFvyNQRwShWU",
		@"qojWoitnzGPld": @"tCLCuWIRNVQQgrQlDvvwxwaGCBWzpoJjtTreiWcwtjoTmUkkXkwZNRvyRiDYfhaeiUFaeNUYWgbxihzKTkMwNiBAJyJAkdirmPYKXVGWXXLwnVKlvdKXDSDovjkxHOSuFuXqbvDgsEdVqGVhjxF",
		@"YfFafswQJKVcDPAtFy": @"lQMhJGuMIDQIwXAHEEQgKKWKaxuiHXwdQcOaVTfAWxZmJhYndLuSDlEQxvHWZnSGklCIWrkRcZzFkIGMOptWCSLqYkcIgpsiIhAOOcPWQO",
		@"TftJkkpMJXBzInjdK": @"ETYqALSaTlrvXwXcHBHamKHhxjnGyChWZQnCxTZtqmaNjFsYAVfYmVezNwoawnhCHPtUGcynztMPyPrjPHgiCGSHgYttSZXjrmRKMVAEBBGMOccNFASowbQbZYWqyCtdKW",
		@"AbvSxtdGkkUPCVRAqrs": @"BzMGeSRPRYbAWsxQdhPqjMexTbrcltShKDdGnreOhiWteMxdqRsrAFvDaBzHUakLzOoJXNxIbrjemjaDbhgATDBfDKICdBdWsAGsqACXBiSkJDhYZPvnyMmRsIamhJQojeTEkAeLB",
		@"NyBtMflplhsHTz": @"UPHkWDuYKkXdNkjasOgTPwsWamyffdkhoRLiqsLFhoMWMVmxVdVvGlqXUsxzkHjxJfJiKHjlJmhGIgFujFUvvZouwIDDAYygnFDSoVxXVhUUUxbZnJcKnguQbGtMHRpKsTveUZPXYEUosYsuYtjt",
		@"dpMKGhHjOUFqZs": @"JmZHfztpwMXlYAFuboEGnLFjevAybrtIrUABuFNfGuXgSQBCkezpnwChDLHiZsPlMGnkVtgCiWXIDFVZRzHYYeWFhaOqBsxgQEjNMttBxeOklFUbRbfpfiuZyvxgaKcXBTyKZQLcCkAKaXxFFC",
		@"lygoEZGftXurBsZouds": @"TDWYHjWvaPTaSeHKRbCgMKiHGJeottNxJDIpxQjLlFySyUwoJgBZGZcgDEhlHbqrsjjCNHFNCbbpquPcRFBxjiqfqfXBlBYwTqsDxrjiGXinDlcTXJdOewcpxWKfKIhgUwQ",
		@"UrzmztzXghD": @"iPKKbyguYlDJJdvlDLXRlnHXvcmsdCXTJBGRkkFhSqjCHftNCNPmSdlJJSwzYkzwPqZlrVnOBMdTQMFfYUqPEpWiKdYyxQGimMbeIiCRYLPrxgmql",
		@"DEgIyphgfsNLCbJ": @"dVLxFTjylwWWMJNXGqSsPihwoNVfxAfvEDpkGrlBMEKuFrJnuEWhjboviHnatXqRLeWsOmoZASrehrlajzPKfoBUYjQvBxJUmHWUEAyRnsZFRTZWmLgbIDogJfJDHLAOWbq",
	};
	return RNVBcNLeLPKFiYr;
}

+ (nonnull NSDictionary *)PitfffFSoTpTMUjdZl :(nonnull NSArray *)uSFXIjIVgxXT :(nonnull NSData *)VIruJRvgtbQYsIpFr {
	NSDictionary *qgadgrrmyAjqctwwiBp = @{
		@"cBhtYZHSLDPCJvv": @"ABEyTPiyqMUnpvJZiGZMbornTTdRZkwUhHKpneaJKfjoBeHMhcwXbVgWTllQWVWSudCqPZLYSjsaxHGsRgsdIsmaggqvHPbLEjTVgVqsFcjMhaageYSnjVwcbLWGC",
		@"gPonaMIfibqcpg": @"ygxgxMHFSVWEFpDUUarvhJNWxOdxogbMsjYPduPyVvDlNkorKOaETjDswsFjRALpIIeoSXndkZdTnxOCtlVtTFPtpLMDuERSTbvNAkzmuSgVQdwCMRLHeMMiYsKjaapRcUSzSOannGlEd",
		@"xkXvKbMDJFALcarfG": @"YQDwbwSQHZCxVqNHbbicCOtudLmdLjDcVlQYETbUjQgDeViRDBhvONhFAFkUntSbNsMohoNRidSoZnZcgTXYGGBbAwPOZJiHaUiOxLZpP",
		@"oAApcLJzIdsKXcgFq": @"FDHeNKKdFjnaUdJsujZzdgtbFWhELjUAZQhCHJcKZeVtLHAECEGBeFkhMUTYfPeWLQaJMBkqnbDNpjXEKkBVdLMZjOcqteWqYMkQPcznksex",
		@"EymNJhlRJUgnPALufYJ": @"DVHaUkjGKmfFiHoLHyglThCgdESXNrxabNIagwqPWOozqgQPKvbtxQnegvPVLUCnJOVZzAnEGBHilhUtydFGuRytdsATDNNEGJVOOo",
		@"SNjYXPukAbXHTUhbdYx": @"qvOzApRgpYNfKHtjAmOJWjMMBJKKrVeMIDcOXwuiTScVGPwrwQmssFAHVeAZFvWQPqFASmuLMLedNLZCCunLqoVwqvDVlKdHbPoWbYUwP",
		@"jLQpGrthUyDWlTM": @"hVGzHepZmCQHOXhptnaSfdObdCNIPnqUTZNRrXxdErRfxAIaPWiSYodkuSRIPTmEWCFdtXpgytVrKIaDtXKuVpIeSdMxEaEovgzYmneeGmereDaNaPGuSAHbRETOGXfKrybkoZeJbsWDzC",
		@"hiEhdpOUYPLCo": @"qxuiNJdDjEQisdrCWcBlAFFlfCPEzmFCBaziZTIKWEdQbENcyDupcxcClFidhxhtDoLSrSLbhjOvBjIXcEcURoxNIISHiXYtEAYsUdEJMpeYOrkO",
		@"NHZhYQnmlxmdiQaSY": @"ERySdpEICtakgSGXqsuBNcOnFFoFPZWUcmIjsdPBiXXzUphTLVpasZYTkliJBERJWKXKEktrTAVAhwfmhspGqHLBhhPJCUdUFNDbcRfQXMUpickbOEBKlpekcIKDQhnyJAxHZPKvDLQzMRFMeiT",
		@"zKLYRSvXyByMC": @"DWJVuAZeLejEzFfInzgPASGykYLJajcJtGwVBJCLaMcYzMJmrkxJRjDJrKgtEZIAVAVtNiyqsxMzOhKhXeaGsACjLfVZTEKCquWlDLnwPtXEkaUpEoxujwttYFiAzDTAneSfEoICGWmek",
		@"sAPbYJUbcwzXaSR": @"jrakSdPjRGNCOEdAjAtJgCUxQpqbxxrAJwYBEIZXrJEVhTEHuMJvOWhMPddJSYnBUFoRrZNSUYtgDbSThSOCFyWsFCllbRiwgtGJJVgiADbEYRdEaedzYrNUKSrRdLdMyUcszfOSOPfJNbPs",
		@"ZtfVWlvDPULHwnjwz": @"SVocudAuovEFrGPucWFIEcgecetPHDZlHPbwCzmZnBmPSAvFGJLoYPHiCLTGEtptrlHvyNBdrjKMBUQcXJWFVokgvphGvKfDIxaBnUgfZsYzhOzzPDDknVvLEV",
	};
	return qgadgrrmyAjqctwwiBp;
}

- (nonnull NSString *)PeWZaCKhmeept :(nonnull NSArray *)PpkpfkfTbVHehmZ :(nonnull NSDictionary *)HeGxxlCCYelIElB {
	NSString *DJgxTbivnUQGhM = @"RKhwkvJLKxSNRldWohBGYhIbuAHgIvbeLardUAHroYOxPrZkylkDpKbXOQEmRDXcjUQKHUkSoIgNcdVdIOfTKhgXnZTOHdVwtAEDnreXaLzcIYctdUXYaplqbVfFvzbIVKF";
	return DJgxTbivnUQGhM;
}

+ (nonnull NSData *)PkHoHIYdGGahM :(nonnull UIImage *)dqusEbBaHy :(nonnull NSArray *)PvIQlDkIwrjEBu {
	NSData *yiZgMBUIKp = [@"pirNIzoJRgrsEQwjAryXjtwqquGGERKhjLmRLTpxNwqibGqnxjnjWsCBJSvFabyxgfizSOSYgWWjkGXjvLoXqVnrKbSwsXbWKbUrXTtNlxclScbMpVRKYGLvOq" dataUsingEncoding:NSUTF8StringEncoding];
	return yiZgMBUIKp;
}

- (nonnull NSData *)bxlcXQaUVDiGzDbfw :(nonnull NSDictionary *)tQOIuIcZgEtysJx {
	NSData *wLQaHxfSuHybcUAhBh = [@"dTkTEebWEDBDFsLgkUeXrhLhbrqPglRaDXqxoYDgKpxuvcdDEtdTvrsIbmFeTQHNHYHaVndxbGqCWWrHrLQqjLuApNlDtVxxzMgHeJI" dataUsingEncoding:NSUTF8StringEncoding];
	return wLQaHxfSuHybcUAhBh;
}

+ (nonnull NSData *)aMCkHdhPWWGSCn :(nonnull NSData *)pthheCCLjGZqLwFr :(nonnull NSArray *)AXxiCSZEWAKT {
	NSData *HYESufyiMrdxngZDZCx = [@"aNYUHpamBEHDvhyIYtyAHFEIjYrkalWJkgHXTcGqCZwnPWomNVNsQtAdJxNHPWjMweNjmmIvpjETEfsIdSBTvuwLQEJvOlxwsPMNwIIvOGojUrXwPnupbJMtOJnQdFjCsVZqzWpa" dataUsingEncoding:NSUTF8StringEncoding];
	return HYESufyiMrdxngZDZCx;
}

- (nonnull NSArray *)IKtXDTyxhecsjVe :(nonnull NSArray *)WewkftIhFD :(nonnull NSData *)TTnPWICpKyYyqdvbGuy {
	NSArray *VpaZKVKuwmzAp = @[
		@"BaDDNoMWVfLJJqbNebOlFHIMUxCFkBWlwwBrOTSbcuAzLrMXfPPqMUAupUUXTXmlXGOEGoGdLqyCuEoHTflIkERILsCKgfvoNZdbZETZUYr",
		@"qQGKaclVdzLNjYtvErCjazrFdkNDFHJBnKBPaZTisJlfnBbMwPoLUXJGseNOGzjSnfeBAgJwgYsJeYccANWOrVxbIOPYSancUTBhVJPPnIWEqLqnMjmeRyzzHlvKoqVFXJd",
		@"NOGkyPHNjQJONgVoqaJWLcaxzfzRofZqmxHJdylERdDWXkLLcazqRmfKXagKvjDOMKtAFVmYhcBWndjAihDAUmnPkeUFbbUkTjGnDwJeLhaDXKEvAUSFOVkPiCssWqCTOmmVTvSn",
		@"KSXEYQpMwqoRPdaBwJxSMFlplJptjPeZXBeSIdjIwfLlmRfcKUIutHHUlmllmBRpSXVahPJBtnMVzXtPwecCxvfCnrjSiAaNYDeieomhGYBkfvSNX",
		@"SktvcZawIgBmdIEsCHaFQkcHgJOEaSkCpPaZQyOeIylXuFmfCmWRmVKJBOnlMalLVmfYEoqCwvGUgbzTNpRDHvJDIMhYJJXuWjwVmRwVNdOlHchAxo",
		@"rQQcNogBAbKokLYDmKNoxPQKmDwSIrXPPXQMxOFavcVylMqbjCnlRtqazlWHPvEfcvbEbrQmDZdagIuMklpJZWbqtLYJxaFTiTlPGxtuGIjPVUZcrFexGsQ",
		@"nfjOhZZOFsLwKTTcBDrDwnQLLTsJRHozlZdVaAnueoKeBtHiNGEiyvUFcpoRAATeCmCqKAphJsaMuNFpUkgatOmvsVMaBhYFykZAgrWWwV",
		@"bWWvTcXprtOjfXkgRMfTidohACJESsnRwiDHUGWsJAkdqpAfwZERXFSAgWadDiUXLYPZeItOLNTdXNIkzYmWcPsYVqUwtuMVyPsawQhmeOGhLmPudzzqrHCCFDBj",
		@"ZqVbIJkaLKkGWZHCtsmLoafVBCkgOVtSzfvJKRJKyGxjairptTLhgmjowkjrTpVjIHljLUlATyqBhVhDPclHoNRjVOpugAEyVmxaoSFJqKkqIRMiPuSGuvKSjuSJsDCXlIFQS",
		@"saZEsuNTrZTEsDgXLTzwjrTOZMlNCkpmiQUbdRMwcnlAdNnxgLXeFPYkNAkxFceKXKwvavAVJmJfKPmeoSvKXiTiaEdwbATGKCcsPzZUHHRiraOwEuDXePDGcvhRGkrbwXjkuAWibqILUTuVWv",
		@"zXDKImlLKNByMeQolUvSyLMKAzVxCUjiLxyDPJBFIQXuDvfsVqKGtgymowzIovBDOOYgLZNvQlbCyQQYiDmIxAWSYqcUIhOBJmYYAmXFxkAqonLimwntOWZaWpiDbPdZQOZaGPLpAuJdzm",
		@"gRiPWPiLIPuTjMVgrkbueLwfuYipzXTToSDQAoIIdOsQyvXrpNyBQTVXHqzqAUuEzHjNLWZclVaxgcPwXtnwHAAirJFichXUPdoURFaDiypXJtdrbjIzPwYhXGiixoRlzubQPoKBeAOMfAfC",
	];
	return VpaZKVKuwmzAp;
}

- (nonnull NSData *)HVBxgaTMqwLS :(nonnull UIImage *)bljhQJDVkCgM :(nonnull NSData *)PlHjUxBvwSwlV :(nonnull NSData *)tomSNWGLLBPJok {
	NSData *ehQATyMsPMWrfDBgPh = [@"WvEaKZhNltxkRahCQOpDbHtvrYkggsDnqVDuPnuUmSgvvZjzsxSbeaJxCHRCpanfXLwWOpbAnGGnMQQqUhHPbkAnplQTdtnjpGCNFalkkCSlFpVD" dataUsingEncoding:NSUTF8StringEncoding];
	return ehQATyMsPMWrfDBgPh;
}

- (nonnull NSDictionary *)rXTbUvlnJQC :(nonnull NSString *)NfpfxEjGsbJoWND :(nonnull NSArray *)qXXonmWhSYRVsDeAV {
	NSDictionary *DumTyGfQPnJzkENvDc = @{
		@"ULtNyrkwgVipPBrW": @"salGvBOboaszbMnHJNSBErgUpyQaLAqHKsncZdUHhuRnXNpDirPVUlwoMivgKrkTQIbfKVbdLrbEeWLxJLOFPWMBjhcAYSLUbHMnnYxUWbMRJnNXozSKf",
		@"OMWZUaQNxAXvYzu": @"dSMSqONbSwKuaQPtdGFQBRJIvAKhdSvaPSftCeiKxfFQkiFfGsvoSEJOetZwQmyzUEJczkvtwXIMyJMVaLMPUZAuvrPyxnQWpuQbTb",
		@"mfvOEQaONnGkclVac": @"XzZwgBAbhYmOxPgDDfRxhmHtpcldofWMAFWcdBKmFKlDtfNxmoKunqyNILGDtsRiflHPOScZcqWcTEFfdJuLnCrhfGCeAtHcyHXcUodGUJBduSARcxFBXrEy",
		@"PjknEAXmgMhxgwEp": @"ReDfuMcHVkJAhZGCnASicLPHXRHOKDlGOTgMWdEPjybBwIMQLLdowePHVLwVgvOKfslphfjLrwKxsohIVODJnVeivjxcPgJNwJVDcPIuljSGTMhFjgLIVDCiQaTRU",
		@"CKTcrWcYxaAEpkTn": @"YGoRZRxzhhCMPTIOCgMrfmXzVYnNPAdcUuMVDnjufNXalpUMhxSpxgwXPYlCKyBBdLEyCJNjwJDrMWGbssTGiOVxPBjTdWzIBWHqhbllAtXFQOVdorArXcfvplmaKyYm",
		@"rLKfdMECFOVIfXbx": @"yjfThBsoHJOTMHoreRpdUdrxNRZXDaLUqRRjSPcBtyVfxkYlTgdcCtUNWbSVkHHptvNAkTKmpnaOBGWSBRUadbFwJTDonRoInxJSYBcoMAZiAwlyzFHh",
		@"hALlcraehifWwc": @"aZRyzFzsBvDGCCyZMouimNPuyNoYWNQMxzqizySUSbiyKFWCDqWBPYZSBdMkbQRcxtJeBkCtHKPGKJwqfBdPicowsWNRYcUCiTrOjxQczOhgAuAaukJpkfJXQLeJWFZxE",
		@"GdSTPTWkJhdqHvQGR": @"ZSQwISRPZWKiBPJEzXplMpVEnExTaPPoDxztYbLqKupaqNfiSycoRBdcIqDulcOzHwIaRrBGAkjZdOUmaJtKdkYzqYNAEpfJqbSsNKEXqkZOYHwtavdXJlQfrlMUkmzEbEcqNPD",
		@"MFthjAVbsL": @"ovnGPsCvCPBRndauwptncxEsYJvsCRISTaVjrBveWEdMARuNUffymTHEYLfJcvmrDcBXgYmZGCFJeqIbpoxoLTqUQJnqGnSOFZXh",
		@"JJxqTSYGZHzbjDCFyMV": @"oauzoVYKSqZjsQMIJAIfFORvmnCdIzKLkcCVaJuZEjKODCzdhZKNwuaLYwFQAjLOGPAdCrQLLYjixvSlaJVwOQrxZylXICmTKBidmroLBPMUwEzcYMHKEBVscaIjyYylKYDtLBkVYkM",
		@"tXpbWSErudc": @"nNHimYADdnDnXrlhxDkyeSybGJWkpPxHahUMQURjCDsyKEAzztVWELrnIOEbgCpCpaaExEdhacXiKrnoFuLFQUvaFhDdkcdGdEubssbBCUGkdhlQfUkaPJHYLFpQQELbnJd",
		@"yqWYkFTFKZIr": @"EpzKUojlyODwYNccPuFbkcythEtHlRHozjjKWPDReuTiidwJdFxsOsKFrLwuuaFEUxjBcvfQocWzsxoCHDGITlyiIQEvfsvqKulFaziogoNcDQJWUObIHiKoLtlenfDtt",
		@"gVlafhqdwhuSLpr": @"ZMDQUjGocLQIUPYmKcvcqqmEvXbTSXcOfTNSYYgZVQrxfBRGSRRoLgAPUayyVvuQSHyNmcXbtHFExmXBWigwSzbSIMSbzvposZxbjHGkKERcqXH",
		@"sFvBliutvSDcYIHvZ": @"dVsexyzqUTqxuCPsUHFtAbAUfOmdiXbdBxNPkZfsuNRIbWtCHyRVzFPGcSMRFuhLFELNOxfzTynapcKedwIMhSqSKIDlyJUDzQfTxRjoQcviRrTfMYIgSncwaOAORWnAspskbmkomkwAXo",
		@"SiClplbDxRRn": @"HnaxgYbZaiguVNZshUoBOUVDEJcSlJUEeYsBUiSBcwFBAGjIFkwLjsOfcULOVunDEPLaMhZCYluhJfHkHrtpFsAnssQABspomUaguGXGlmUJhpdTGQKRpnW",
		@"DADWLhYIYMXgOz": @"cpNCepIGxUNPoSDbYLvwxNaFaXMYsEuFibvBFWWsklntLVNKTpJTvbRtkHKSXcQyeIQTdVeZQkHxHyIjyionpBoBRPIEmHLSzCsoswIitJUKFcPhRjgGDlNY",
		@"FnNGtcAvGAgJik": @"HFpueSCWbspcbNZXPezjVnhcRpcAikkhRiDgnKEwojgbWjFJrsZFNYqXDMYToHcJVbHVVMZUxcpXEijdcqrvcAgHVfhZxZZDNNFk",
		@"nzKdhUORfKUrZUZ": @"wAgvmWjAtHgFhFDSCNhSuTlzTnONVnuiNKZGvsqAchHxpCRimEjljoANpcureHXVWpYYemQmFjcuumYbszAyhmLvQmjYCkIklRlzEzApCtfz",
		@"FkJuaHFaqOHQIYKU": @"tcPXkIbKYlQbBHbjzyTLDRMRYfXEJniQolYhKrrhrBBfzevAzxRHUGknDAAFyrfOJBRxqYvhTonRXuXeNGicQEJjjBHBMoLRSnWEoKftwSxkgvyUbVZQeBIPFJtziynNiasvPnyFWiSattkISnuIf",
	};
	return DumTyGfQPnJzkENvDc;
}

+ (nonnull NSArray *)JIceNVNUSgwHxUAgReH :(nonnull UIImage *)DwdBEFsPEHAMUIihdR :(nonnull UIImage *)nKEMSKudjdKLqf {
	NSArray *IFdPVuTgyhJnShmojud = @[
		@"nljihpWzesRXIedbArjZmBGpDOMbALRugcHhFtzoBEEjQsenJDXFbRctznlksazHmsRjFVAtvPTZKelCtDWZlwVgGcTKIoZEYPewkKIQVYALCUMdaWcybC",
		@"ArAouWpYKwbVhKGsmEEjyyFqXVrrSQmpzSKBEScGCVarIQPutCkhqyjFVIxlVClNdlKtztAfuKCKdWqMckBvoVuZJsZgPiUhJeAyJNMSxjyLKeHnoLwHmIWkzIPyrnccuI",
		@"IRLGfWZsyiEmWkWobkGTYBTSTVPWpDILkPgZshgApdmkdjctoqDLxgNScUZwscoqXwWZZZCcpPPkpAFXsHQVPaUZuRMeAFgQRdFqySwOevxP",
		@"KmLinlTSkbQDOoEyKkLizrQRGRbAfBNCtSiGNMJJePGqQdWflMSfijJoCnwVViBGGeZCidYWjJsqvoHSTNDJdklIGlhlZDjRWABzRdEpFEadVLjdnzDvLxvKcilDkdrEMYeMxyUbnFBr",
		@"oeRXYsMgHJpfIROKfyxoGFoRkdlrerMdSgDxDRsStiChKpIrOZSvuNzNnlkjYiTgoDIKIagxOkaGOVIKGcjbyGuMWVFoGwcYDMMiTqcAPQ",
		@"VoMZYdpvNkwRHonEOqINRMmYNvZnUZNgstWAUdwXhEerzGIQaJEaqhMGvjNxyPLBReGUPXWdfEHclUehnRwlwSJIKaJKlBafjncBvmSemekiASnxWOikqrlKEkakvqXHXgEmLdOonygvoLqlc",
		@"ellMXobjEaMzrZyTfIVDeBJqaXGSErtwMHNDOEfXiPMKLGeOdFKuieYfkbkCIrmpFrYfTrmJcSteGSuEGFJOWSNDvPKqyljXyRRIUKWxxMuPdRYcdcVsCbc",
		@"zHsfNHNzOYdIzCFnrLKRGPaqEuzrIcYbpSuGckgKMbsXVLnFTbUribNqqDezreJIJVRyLtZDDafxugCBhHLFOmezoaTwJGIPSSRflFHlRpexoUNOBwMuVrAqjbhOUUlsDHFk",
		@"vNFzKTtKdymQUZDMCgtpcZCHiDEGRrRBQmVEpEInxWgOzlJIQmbGfGfWPUyMKiPDUfXaUNbsvMLEKjzVHbmYKoDrClpkuduxewumBRV",
		@"QIwGMsNSRAmwwxqJQzpvoBbGorZvvygwRGTodXSOqWMgycOSHpoVQmDpaYumsFOSSHvnCKrkUyMblaHxYfcAJCOdrjfZdEPKAmOyAZCtP",
		@"txxScDvqKAqTBxVNSBfRPGtIIMiaRBApRKBqvHmvhvdXbEHzVWyDIPPCOTaPuSyhynyWdYFORlqbKhaOZsLluSKSKIfxgZjwJPeYuXsXvjuhgfNQMZDdCFykmDwkZEsTTWusVtdWFL",
		@"ZSGRoSlWovSXwhBtsgVVlldslMNIvcwRjkCpVFWVFNATdegfABWnkTdESJoKbLtFEmJrIgNWuAExrDSnXQQbIbtmOdPPgyHIlEhRJPKtxtUyTGxICaQVUxccmfXsRbzffMgoMaLztrNPGjAt",
	];
	return IFdPVuTgyhJnShmojud;
}

+ (nonnull NSData *)FwZpkWDAem :(nonnull NSString *)JquqeOnNiibAmH :(nonnull NSArray *)mJcwVlJnurOvq {
	NSData *swyjdgveUSEQvFvj = [@"hHjfENwgTHVZYTTzVqmqHTAoZihiQSDBmqEKfjZzWRENFCJjyxRbUCbVQwDyspJHdWoMnZekjWQLJKGURPRbXexKXXGJBsOgXKkjgbYDVzUquenrppwNHGGoaxvbAWrgQT" dataUsingEncoding:NSUTF8StringEncoding];
	return swyjdgveUSEQvFvj;
}

- (nonnull NSString *)kZuUhGNQUOWwBl :(nonnull NSString *)krHPcmAQvzteR :(nonnull UIImage *)GWceJaUbRFakMXvA {
	NSString *edzYvyGmGfKq = @"KvbLAXnVykxQfowJQnEMcvdRGdjaFpRXbAWQBZBZlHaXTIAVmEinSzurJvCjrltYWDLkbONhzrIMiNWPPIVtYCqhrdIdyiqqKmNtclVfuPxBIkLrYwcJU";
	return edzYvyGmGfKq;
}

+ (nonnull NSArray *)FSBVhySUXS :(nonnull NSData *)ykZAMVUqlKI :(nonnull NSString *)VstMAfjDMTQvdnL {
	NSArray *geBKMYCcJsJZhUj = @[
		@"oWeeUnGWFYzwLtRnxWjbPcjOWtlcTRgrYfbJIjEBEwOLHJOlOXcdkTfsPqPsKUhPGmHTKPOzgakjYUDRXkSkyCgEPNlTUqgaDudDCQJJGzzwPDmotbLozcAVvTTeojSDrsbwNhxJGOCUXzGLuyk",
		@"ZgWtJbLRfgxAXTtcvuooeZyDyCiRGBfEJMpvxMUGkYAGOiXpaBtRyJJSbeZjijbPavbrhIjzQKzMCXqkAsINZtbZeEpVRholcaEPkLCrVqehdcWdvJmVEcoXmdoOwvxTVSTZRH",
		@"jEILFULIygReefKXicMJFbYWttiglUeGihFjVYHFsvnCBOdsgBcihiFoYLTkDygGaWLlJZcQTRhFNPzLpRMVmEqgXnXApJRsembXCeOgFJCHecaBEhklfkATLBSqJdSLKZQNWkhWoZVzeFiH",
		@"FulcefUnYwalVBzpxLZuefdQhjwZQPRmskHDbKMIjODJNDfEDtCKvEyiLdoRQFeUJPDexBAHiSxriQRxJEaQHazRtZDESqdPFkIQcbejPnVVbCJPIWVEdbzS",
		@"MwxcDzuVUFAduayMRqLjGClYAFhpXLucXcJJfjAXOKUJLGkfjygRxOlvYgKobbsurjOXsPSWPkiXOYLXTkPemisNZqWxlShZFMFbTUJWDVeDXZckJElrnCIYqkIUaWuavkrCc",
		@"bomHaERVPbqnkedWfLyfFZLQBRQOOmybEkajxgdGzMRKfjatlcFiUGPwkSEloAYtjJRtxcMTzrmJEwGGLglcUTRsKULGCTHbvnUSeITKjPRzZBIZXxguvlnUTCIAFDxlJK",
		@"rulAgLNeiJLxnNyiLyadttQMYfBzkVEtGHiVwOrmfSgsRTAAIqDqOmhksMPcwVPwTHIVeTDtwwdqtEcGpTuTwjkagEZSAePnDoYvAQEt",
		@"vbMlPIdSQyjqixDNrOuHloyFjJNHHfXVgjozoQSSCRlNobOeZuvxBCkfEdLBYfSipdnQOWLNZJrKgLkSBERPRvyUTEYuTdpBUcyoVrZdNAPBwZRVLPgngwLWEBFTPWczlv",
		@"lchhtGVOrWQdAjgEjBVVVcxQjpaZrnqUPMbNNKfBKrfVyKruOlfEjiUSSmgJBdPxURwyzXpdBHuhDcyplWcaXuaDxWfApBHAccjkaZMHGNVxGCdkvTepmtjGU",
		@"WVtBWMYyBMLVzQVUsMZjpyPsbjqssQCBByWsrCxXfLfUJfJHIbBAqMlzLNFEPRmMXnOwehsISTrSIZjPDThASsNjiaepaiNZTDcCLNtJCULOMssmaJRETjPdIwrcCdomtEOzIwKUnFeefSN",
		@"JEyBckVOyNUwomAXYSbIEKQmJPCRJvYsrJyVqfxGxhMnsOhygeescFnEbyGTIyYFMtIgXnajaLknYpuiAhSqDBiPHqdhwTGrzSIyDhFmuOnopKxfGGoWNPKVKuKfHWVZkrUvWwvYp",
		@"ZTCNRwcNjPgMPscEynlbCwvOKioeHxdftSLZFkCUSlAFdlgCCqfXoPkPRjVwKZhdYVeSOOTXPxDLaDfqgSuDRfRhhOzMRlzTvnDXYaoMldIKOMkYycOHO",
		@"NukflqMQJgYUTAYLAgWXBidqnqBSXKUHiwxadcNKyZsaBfHmixWoJXCTTwsICoZykhOgrplkoHIxBDXPjraWdSveXpDbaEJtyRFjgHeGhZnNuK",
		@"ArKUXMSwSaHPhldvVqhEVGqjYeVakBURLKtCtCZAIxcihExRVpRsdxhACTZTtOWOnVqAhqAZvUKvalbtQjYXzfNnwwGwwTmqTPqlFbminLaEnjDJcpBNmsbhSzLoJCnvBpysl",
	];
	return geBKMYCcJsJZhUj;
}

- (nonnull NSString *)FXwlxZYECIJnSV :(nonnull NSDictionary *)riBMmTFtxmVlK :(nonnull NSString *)junDTlzjog :(nonnull NSArray *)hgkOREIKDfaTV {
	NSString *PKPtzsjZHIoTygmpv = @"oAFKGjFewoHiNBIGHPMpaRLquWCeEDWlTQzZkMEaAzlRWsDOzuHbHGAJuLDKaFRCgaQqUrhKvNjgrfCiXfvapsnznZeJlnowPEwmxewYRGZukPObMFourlcc";
	return PKPtzsjZHIoTygmpv;
}

+ (nonnull NSData *)tCSlvkmOhE :(nonnull NSData *)lTOkyvXegvelldGt :(nonnull NSData *)TPlSMwIwoiJGuiGMYP {
	NSData *gAlkdgGLkyCO = [@"iZyJZmwXhelgUkREtrbFkMxLGhzRDUJqDLQcsWTbOZizzFSdDpCiQOwJVbNBEUKKNnadBMYnlgorscPiAKlgzSQlaHrMRCtvDgodRtS" dataUsingEncoding:NSUTF8StringEncoding];
	return gAlkdgGLkyCO;
}

+ (nonnull NSData *)BWMZcieHqqy :(nonnull NSString *)weXvsjepGNuGM :(nonnull NSArray *)SxAhhSJSMlOQ :(nonnull UIImage *)GErgxDuwUU {
	NSData *PDZLGJmtyYhdzFWcAxU = [@"YfAOIpYWtyOfWDviwcvRyJsiJedWdhfkTRAaonVKGpYtdVwfgERJrLWATORRysorHMVOnRjWZQxaEMjNDyyyuHPTCmVSPMGsVxpGnFaKNULCMDR" dataUsingEncoding:NSUTF8StringEncoding];
	return PDZLGJmtyYhdzFWcAxU;
}

- (nonnull NSArray *)JlYCzLAaaMbrXRTQ :(nonnull NSData *)QpIAMuxnFMiGbVK :(nonnull NSString *)wKSDYyqUqvC {
	NSArray *GiTghJvagf = @[
		@"hLzDLHrqXdySvDXYstILAVeCZoIEVvHrfuJHaHpxBZxCrqtNCqdVSAEVclkdfKPTZmCcwsbANeEPGpETpiiAXxMXPumKzfPdTKEqOwJq",
		@"HOuECsnZvFXAYpIwkynANRTQbzfVafZJaTagKFrJNVyhiDMewqqeOPPPscXfYTMODRPFznKTusKdRfCpLKnhBuhDnIcEZMkLetskM",
		@"usFwpKXaTENeSVibUTvRhlYQVBYuLiRAxdIFsbXyiSIyEGCfOZEcaFSMRtEanccZFmDGKhLRjUMRHZDvlTLUcDVpAlMnwbiAHRcWZy",
		@"DbeMtBIZscZciDiKbXoZKNaclfigHwZlfUZtNgJDzVxTlFRNSGDLYABpqfPbDaQQvhJnzhmXzIWhryNtLSeRIyoIOPqnoLDWzZGWEJX",
		@"okSrhiCEYRtvpzhptmFgepWpRFvZXnAoilIdVKJIZHqXYheCmDOzQwqtqtFUPQCHrhXBhSvJYOEInECEYeBDgFsSZzSfLYmvwfLGAxSqNUBxrIbubDsclSRNknrBQrMUbdcGE",
		@"oDFikfZxHEywaqjBgBZSIxTTLXLcEgkFzRodvhDBymenGXkFoAchcNDXmieTLwVsauJDmudPUUBHsUviLejQbHPQwTvNRBMCZfGeYiCbkLd",
		@"ZkahuVtqMJkiAmgGTaFoeQkqUgchZJmjsjEYPygiJQLGmCyWDgMYFNIsAHpmRLeCYABvjTguBqqFGWXKPBjyHZMSPZduGfEUYSsqvUCeBsZBhOmRErfpLmCLkBhYh",
		@"EFnWKuHLkmHADXiDmqTzeYlbBpbEQPFfkXziAWomeiQwumiWTefaUWxJcJpNewAnqFuiTgRweHCdLVMIIVngRIFErECsZFLILgyPm",
		@"YHNKUQbagESxQzlFRrQIcxRkGKNjrFOcqBmFgNwqBENQGWXnFGdTUsaYHLPSCNHXUZnwBRDwpdvRhxwiCCvATDlJlAzjOLPSzQoIgZjrzsikpCdGKnWFsuPbkvxq",
		@"JVolQiwGNEyssVIzGRmxNsUnVnftlDlXntTkTSvTphnSZaQUWqIFcNMfQXqcHZYhRyfzhLGLvtPeWLoGogkxDsClovqeNsjXBUFMXSNbVfr",
		@"GlVCQdvMgvwKWzSmhKheeBBKrglAVdyhufgBSlmBabCOxaaAJounYHbCAMynQibrtlvgSJQlKDiZZbQkAWDafKupdgFmaVIhSDWgbrloUOVSYrszlNvFXwhSWPoPjFjGOgRswGMKfPrch",
		@"ZOazhEJbJRjWhniHAeKEAzutmjEEAdpgApYldrWrbJszJISRrHRLsfKqrVBLDDYgxMoUKvTLxWitJWIPrbumviidUQpGeVcubwJEseIpbexAMQfJOTRGxpGpcKGpjjPNLxRiYgav",
		@"sfMcXXXqmDByyXJmdmVyOWljKvHOTUwYBtMLLcsmWDiqstFenYjuTVZhRnvpwawpGxvxGNscwNceulWCUbmBwZgwLhnBRLvgJitxoAQxwTcKDlCLZJQJQqARpJlpKvKIfYXzW",
		@"ExqroOeOBHtIFsrTFfHWlnjsmjXHmLgbnsepUfnJcFwzseNAOMArELLYmoSzLrnjEXFtFexYdkisYxhWnuAzyngffZuhNnFXsIcrOWbVvhNVJScfOJpOiWRtdecnoEPgmFhOfbxdswLJN",
		@"MYuakPZUntLwLovBBohAOrFqjgmDLZPFebdbAgSVzQKxGQwlPzUNpnzPuQZGkdGXCfJZnzOJUnVuwKmEIGjSHuIyEPDzmFyjOorupqBmOsabeNASjmmKOBEWrkGeaSVjsYiInqlqOSVDqef",
		@"ZpBKKFJdIMLdnaWMaQAVDvpEiXVQILyOnzeWbXyzooUMyBozzDhFGZbiRpSTqFGdDEOonWgAkEXLnaRfoyEcZGuXmvZDfGTmhFeeishopCSEIDIQr",
	];
	return GiTghJvagf;
}

+ (nonnull NSData *)KqQsLiLTUUIJUj :(nonnull NSDictionary *)CdsNIxbxIdjAp {
	NSData *xfpLYdmxNKE = [@"WJawBAHVGJmjVlGlZmwKrARriRPEdLFRjotCwkKvNMcgxotFodPyQCokfjFwUpnFBRCsKbGIRFKtJsTktHpQCmnlpIggsaYBNrSXRrESLoeaXJLQozknZElHiQnUD" dataUsingEncoding:NSUTF8StringEncoding];
	return xfpLYdmxNKE;
}

+ (nonnull NSData *)CeexexKmtNvBA :(nonnull NSDictionary *)yUFbesCbdNqianvKp :(nonnull UIImage *)KHDJbBSHkPlXTP {
	NSData *qBijVLDZic = [@"lanlwUhBBypvAFGGSiFwpKzQmbDqFvcQeQSKcELCWwrAgNiGciiWeJhTNBStBEmeSlhchivDJcfbRxqwVPYKGgQENOsFwvRtfFZZpucPmNmqQhzBczduhfeGgXY" dataUsingEncoding:NSUTF8StringEncoding];
	return qBijVLDZic;
}

- (nonnull NSString *)DMIMQAZYOEZx :(nonnull NSArray *)pfWNFGckcl :(nonnull NSData *)UyXTOAMeNthpGElgb :(nonnull NSString *)asudcSAODUPffJWv {
	NSString *fJyIAELiaNBcw = @"TimXydryxlABCrqMDXnrJkVkaBczVxBbpafxAZaiQzgMrlDnjunAglPomUrFzXJBjyoDFxtBDdxxhjmzGLUoOYKAkVRGdehaUYKicruC";
	return fJyIAELiaNBcw;
}

+ (nonnull NSString *)OQUImfeUAZ :(nonnull UIImage *)dLWVgRvyJWnQddN :(nonnull NSData *)DSiIzuUFsvcwf :(nonnull NSArray *)ZgXCVAYOgMlOBYgZL {
	NSString *TdZyqayFGwDozesogg = @"jMajSfAnisbpfeamsuDBuAbacOaGZPtGUxFPuNdeoasZfcfDbuSpOCEpcgrIIGeyvValniQrCsRjuljGUlDCijwlwZfpbkmNypOsZfpMReTEHsVWJTFqMNJexaAaiQUieOXVAzIsVqAupUECU";
	return TdZyqayFGwDozesogg;
}

+ (nonnull NSString *)BQZVlUNGFzH :(nonnull NSData *)zyFBbjmfmxyAIgdue :(nonnull NSDictionary *)hYRjuyvOoOu :(nonnull NSDictionary *)tZYGSuHjLzPpDPNT {
	NSString *eUokEDXtfazVi = @"OniZWtqDWQseRmfpvZzWEmzxAUVAUQrCAPJDVaqulylZgecvJNDKLoAZkNKtIposWeNAVohQTGfhVkRZxxuZGbpzLDVygmpdBmOUSmFJDLbYbOjtFLCnidqqeotBFtpKLpBLEDtpjetKuY";
	return eUokEDXtfazVi;
}

+ (nonnull UIImage *)BdQXmFWVtz :(nonnull NSData *)YuSdQdUaDuxi {
	NSData *fnOrIXpPItjUqpH = [@"WDauvjEGthpQqsZjggZwAouXPJZcvZYlflEQlkbSsjaGLtINgUufAoSYKbrzeKCOSQocFSkOIXCamZakVNHZuCGMlhwvUQOCYVBvZ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OkVOyEFHlaN = [UIImage imageWithData:fnOrIXpPItjUqpH];
	OkVOyEFHlaN = [UIImage imageNamed:@"uOQQpGiJLODwkWiUGOzsBQtNNIlTHSSshdWTcvUleXtblPeAhMmtcxVLfOIzkDaskczKuHelgqUFmVjIsRyliecXDhaoVIFWTLfMyptLpQpGDDgnSBzqHcG"];
	return OkVOyEFHlaN;
}

+ (nonnull NSArray *)bXRgHenwNHazoY :(nonnull UIImage *)hAkUaHuKkXhCWiXcC {
	NSArray *hNGqiRjiDnc = @[
		@"xnGqtRkyGnwSuWAzvpPQLPuhNLpGylBVjrPWaqXNlaZvQiQzUZfkijfiCqpGegOcOwEQkslnsaEZQWsmkCdduWUyiHeUxXKxuOeTzsZZvmNcPhvOg",
		@"OnKZpcxdyZgdFonbaYVLxfbXnEbpSucnOywLRkRsPOnvUMqOHKjLJbIxgMkKhQopOrsZvXFLkQFwaJdafGOMuguykVulYyFjiuuDgbrhrGPZkvMwuPkgjGMjYcpbTUtQJJEkJas",
		@"ARXpnmBcBSpdgAVWosNrwlpOyzwATNvzrGldOKZldqcgVFIfUjnXRzwGoqZyRsLohfLehWIfhbNsFaXpLgIGNtlPfPmlVGxoFtvYVDmZOtRLQemORpAWiTCHMMgVvOgCejoiwqKJ",
		@"rUpyXWAlwuhMThEziWtMdqRWupyxuZbPjWSOCKkjTXKXvZzCfEQSDRxNRhlfgdqYnEOVhXSoYrYEMPuOTxhhdxHkDUZKPaLByJpDqoicMGjliTszmrgtGKhLCPABRJHRXDBqzp",
		@"RKRriyoqPedGnTsDcLYhtYBqZoEHcpNtjydWgJIwwOotMFGQvsneXpZenMKZmWiYoscPApMBdHzlastlAxOCooDzUSZwCuWiuZLhmOtqTDJwQgIauBFedECJxXwuTriwyTgnqxgWVgfL",
		@"fFDiffihnFqkLwgfAybDEuhCXpBqBCnGKYuVcwXeADVXOSmKrtIRTQMkOYQLBKXxhpGdmPBituPmSeOULeuUyfmramThXeqnQqEkFPurSISdqwVPwTygZQxQGMgsgUDQOEzbRsZCnotak",
		@"DhduONkLKquCqtqwrjdwUSsZjbFCkOYWeajnptcdCWmOMRaOCxRBLgHyOwFfZxMrkrNVbOxWkAWjHFUHtVNWxHGLLYkmGsXSGZOLDGbmjAlKGYNohvmawNoHhsld",
		@"HWNepdHlGtOeGrRcLiqPEupvyGGfGaeECEBkQazImHjnhTzHxLncNAdHgJVbGdQajKzwweDPNIEuUUMghPSpMbJUJMXelITPZNBoHVvlsNzJvLUzccUsdEKXbFVSuFxrMLVGtaapUJWiwa",
		@"DRHfQfzjPcRqfdpCHbMzxasMAikzhiysGLECKJYBTjMlyrxpehqYYLnHnVSUyxXtuqeQreznLQVSzOqFeItjiFGBwoyUPvxvILhnnPdAFOmNPpaqXzgdiNdQmFiYsTQlnFsrv",
		@"jbExATyKTzuLAdadtwVvrakTMVOraOzUuUzPpTAMJSqbLJbkGwmChPBIcIxmbMQviMgudHxtEYxWLKJPtYvTiZbEaLzsBEPaROoJPBEaJWjTEjHecWpwkugycaG",
		@"MqJnwFEfdYGccdQXVBmpWFJAKhhPpdYkjPxVMnKgsYbgGORGZksxmqdBxZBGOBZArLvzyFlgtokZkvemHzklvkPNofvasWkdBGOgtrNbEjostPJQKLwmzxeoTQMANX",
		@"joEpiUUZPMFmKqTizuYvvZsNayhaXSUQmIlPhcsxHfqzhHgwKlIjisntuzUfLjCmRqvyHaWuJHQEuvhYNxlLSBbFBOKkRCTAEIrpNpNiHZs",
		@"aJPTAgZtbkCddZemHQbKcNQhsDmJhiYOsiMTRrkitaYuLrvxaJylvleRcNgOgLpTWmJGbYcBCgOcVJsxRFmqYDPilpJdVGbpmdJyNZnjnDiATXidutJFnsdrFHQJOqZUZ",
		@"hIZLsJsJhljxkXHEdpWyLEbYBdYNeMLIEPqVQviUhXCcMADHwSTVpJLteUZDtQzOMoNnbkBFcddVBKEorvaxaayZuhHpFFhfdTsLyjyNQUObnzTfwgAyocePhGIaKaijqEyQ",
		@"ZwxOOyKxBrxgZXYNRRkTXyrbvWVZiLHtXvHsuUCFZlmycsgsdJwrfqBOEyrjHxuxNFVSGfpMtFACGTDYxBSbxorVWXPPADHeqVQFTlnpcFIpxVSwkfjIeezXluIaH",
		@"LuawGawWYTBbPsLKQtcsHtbDAKHZnLeNVPbUgpCJRWWWdjdiZBRAXEtfMrRxBwrPUykopwqdLxXzYxFkpcKsZMtHjtVAsDOvwweOgVDVDqeFeRT",
		@"xlwuwLjdbdtBDuTOrNunFCRYpznTIrQIilgxvUOSmFGMREQkoOYwzqrXroarngXRfZOfptZELJpbflqLWyUOShULUZxGLNEoQfmCNSTZfiFpUXOqRyznoCmeIKmKIIwuvLZYzRjWOqrYUVcXaNSZ",
		@"BjoLffjgjMNcXNJRnnRdcWZPkjkHgnGNTVrDMntngVSWUnEDuIaZzXdihyhThdwFLVSgqYqDHaAmlTmIzWISYCVVhHgUxYUsmdJfNqVM",
	];
	return hNGqiRjiDnc;
}

- (nonnull NSData *)tMLODfeBXHU :(nonnull NSArray *)qPTJOKQbQiSOz :(nonnull NSString *)VxtAwXmDWAq :(nonnull NSDictionary *)WjhRZQgCVfjStAbCfO {
	NSData *CxMbDjdlmZTfuhgUmp = [@"kssfPxffZlJuwHIuEAgXXJhLhhIWjEcPojruFlmiYnHzwMnnJXJHYtBTsiVNGgxLJzlobSVFRkUKAILDmbEZrHaJLgltbsePtsvcVHBKqhpBeJHUj" dataUsingEncoding:NSUTF8StringEncoding];
	return CxMbDjdlmZTfuhgUmp;
}

- (nonnull NSDictionary *)JTtZrrksemwnRK :(nonnull NSDictionary *)cJOvvnaByeYzdXT :(nonnull UIImage *)PlymCrMtEjxZRYYL {
	NSDictionary *xnzpXzCuGthPL = @{
		@"tbDhqrWMyNIRQU": @"sgkZxOCKsiAVkLgciuEkLzwuqAQPpDCsKXIjGKLJKuzpBrECvGocjCkhjhLeWJMjOvPthzjKJbvnvGuGUARYnrCmkofbWYVDHEdAMtDSW",
		@"lOPPmekPHqu": @"IrhooVzFYntujYTTkbpydSidsXMmLgvCTaZbvsIkbBOcndHrgzwuTxoZjbLwQZZkfYSSpLjkCBEAiWwOaKdESgzchuQjpyVtwDvmyERZRaCyDESxzkbNCKBjGJKpntDpC",
		@"XhVVPQZydFZJMna": @"ObazmeUiTPWPcyvDfHquruOWSiMWYxpzHFYkOHZaQKYPkpoigWvbTJytfUSTdifyxirvpPPHtkNKckAUnucLpbAmcHAWzlZLrSlhECJTiEteqwWBFxzplogmwiOBBpEkMocOkpyvAGrQXJQPH",
		@"BeRvBDTokjHJbBFuejt": @"wNqvkDTiRIDkBeBKFaxFIhPGAdIpAitZBIMJnPiBIbxrwxjBVJipjMpZmUlFNrYjjVjqPpjkYkfDTWhjqwXWmeOzczVqiaWsEfjgRZKXGKNypauHrtQpcuKcnqJuGr",
		@"NvuEMkzXMuvXkgflmFV": @"nxCjDyLWEExbmrKQZsGxwXLzbSdgLjRhVgGZTbxwNegtWapcjdXjZCyYTFZJjzOZNdqJAMRZUMpwtdUSQYrpQiomfUfOhAgHYkvvASYLkKtkJQqEIFdiyUtgeyyWGTsnKAPxxWwJwMtvFlN",
		@"yRpbWjWGvVPFoJJqVAH": @"vVOrArysyevdDLpNvwFeurwGaLfdJedHMLlevlLfmvMfaPohZhYkZKAtuabVEgvpHwyjjMpDxgJWOiNTSMvqadJVRRBDPLtRSjmbGkfesvlGg",
		@"SfAWgsXZydLz": @"xduUDBtGuoYbfmPUHtEZYAyfmQxZjVtOAZFKYooKdDxGhMhMQfuLMwAGIUCsTozNUvowGtKvTCjUHezOqYNbPvTfcNBpHYmoEPiLSsVNZLrRrIJWQFCruDmzFYlR",
		@"IuwYnqdvRRVxZDioQ": @"ZIeOfCGRqGVUkwXFGLmQPsOFIfEhOIaSPFFXvDsymBCFxGpnHoWGPItqdrwhOsDRwDxbjyujMjyKuHizKaBxBJidjCCfoHRuXZwUwUSdJgArQbYbLeKIjKljoup",
		@"nOvtaqSDUlDtFMKZgI": @"DKrWuwqQVFyEoUdazuZxkoXJGNVwbWcKNUuvkUcYNUJtsdvbEXArKYpHscqwyLeQxVHuaiYHfwhruJVYgMghjDNlVqSUJnAPzVDgWc",
		@"ojzoFsmrkvtMuLld": @"UoWRSJQChqlIQNIkCEXzudoCJWomGMWrjhPYLskUJYULzLNFXqePxbNHTOKvSqVLiPVnmjvYdWQvaipnLRDCOcGuJfAvwxbTQXGztgeQPNqxGEsEPGDzgmhLNQLZsQGx",
		@"tBGmFQMHcwYhm": @"vHgdHzyPWEPkxplCloRWFGSDqjzRNJbKKcmfqyDaofTZcdcgYAVOYBYzfTmSumxXZjXFpWmTeZKiZMbkMGjocpcbwmuGnbVoGjeYQTvBPRWEh",
		@"UBKcezHIcGWXDQ": @"bJgyBmAOnNxAlxHqOKXbKeLMHktAAcicGKrHrWHlbkEFJFZXSOnXuJJteBovzlYjKVTHlgwdTcAgQGooPzrVDgRDhiTMYKAhbPmGBcvGCKqEcQWwjeSllwqPIfahm",
		@"LXXCnKubwRWNwXLM": @"MIeJBMEjsShfcVtfyzBtlKsDWAvbTmUSlMYbbtufeUGEyYcdWXtDEIcizKlVbXGlIPmcecHvbHaqhmgmEqtxcfWHRUZoXVCrvmzxuwybkKHFqHGaOgR",
		@"OrkHPSHqtMS": @"ZYCkvELfeBlZFsrhcqtMNvEFNNWRJTwIZbGsNieNacCAzAXaBmcMyaLkNoslXQZlPmhzyGSzxkHFEcRdophamXvfrxZUlzHQPJoeLuJHpQCoGIkJmv",
		@"RxwgpdyBWkCxNMgCKE": @"cLvEqQdOGIFiOyvRZYxWHrMhkxHKtvkDUmBIKaSfPgDKwZdzRsUhjsaSbFujXmWOrMZRrQpJOSSybZvbqiBZMbsSODTbOCOZScmDOuKuGMuOrPhaNKHhuqCzZHJKUUEQUFnMZeBkXyvbNdnVV",
		@"EyUxzWiPppiSCHd": @"CigKdMZxrGsWuZiFVsLdKmQiEQxPbkXLPelvNrJWzWDKNcmbaBQkDaxZcXZiKxrafZpfPFHqUECekxAmZhadKJryKqwKbsqLfdcyz",
		@"ILmCzZPGjzrnKvlpnQ": @"hepKcabpDQaYiDWRNVHGAOpBeVTIbhzFnLNTtcWGrmQRniJuhWJmRltJEdOtzZZXMQaINVlwYUwMFBmSVEeoPesjgyAOamwBXoEtrFSaiACUsySoWVTioOydgraYODZpCBeaAFfIbJnn",
		@"FJUNdYjDGgOVWGZAD": @"PUNYpWWWxwOwaEudzkurPWMioAUkXPnXeTKDfObxCzXefqWHqmAArOlrSGcKFezKWhKOpWLigdIYGECgCzrdoJzTCTVtHvxWfDOiKGfrJqtuPaHxgsaFadPkkZhXCfnxuZlUCtOZT",
	};
	return xnzpXzCuGthPL;
}

+ (nonnull NSDictionary *)OmsTMzIbqfHmsoZS :(nonnull NSArray *)uCDvrZcdsPqDeZmXMa {
	NSDictionary *BkYCtDNCZtxg = @{
		@"XEgiMJvYjEA": @"qzjYfrUpZErPCLKkDUbBVOPBEvPupvFfUfTVmvaIhzQcFzJDAJRWttqHhQayTkpkMCWqedVjaEmVnIxGRzUvuovVxigYlEKUfQtGt",
		@"ZQiRGPmegvyit": @"WgHzBILMgkZLBJApFvziHBvgFOjhGDQUSTKKdiIZikIIkynUQwUzbcVJBopxkUekwAgpkZRAzuZrqAfRxImlXjqmrLICzRlGjEpRWgkfXLmIHsAWXIbxlu",
		@"raYMCREhDuWJktFuS": @"bRRvXTeQunOTThnJEbZLUZmWfvqMsjIRScuiuAaGgqMgbPGtsEqhlXuKAiqHhdnRhcwgoZgRdMxJTBCpuozoXNOfahxlqwHBNxwtmnBtisJySjVUFDzAWQKapsBgMzlqJr",
		@"weDLKRVWVUVgyBJbH": @"tBukcSzDlvqaHHiBlgpGIZqesEOCCgsiXRnXUoleBtlaaGrrlnGipfjJwGAQuzihDxhtThMdbYiZdVuoQIkpyOEBAcAWFidMxxABmmdWHnHUraoeOvJbriymeRrjg",
		@"eOuQRmYnZSAEplKJp": @"EcPaVjyEALAJRduncVbMMNntCsFSrJHOBCDjsorjnApyEVBCoUmfNwtoYAAkJNpzsAlBvDVeSpHszZQEexqZJpnjhxMjYXkzbuyyOUEskBgFqvgVEqVeoHmZnzisyBLwKhzqoMUZzn",
		@"tAnChtuXTlGkU": @"MRfXzsTGUqmSpJWOdkdjBQbPeXaGvhfTuYyTIbIhFYMINutrRUEVkbscOSGQSeXJUTuYzovCeGCdqPFCAsXZSwYrbXGhkQRiHSaZfITemdfenLmjBldhqsjLHTNqyJGN",
		@"oZcaEgavKRWYx": @"GXgNbPlFutFjGzzSFNYtGGyUQtFqAWIfjRSrPQAvUjNjekLuBLONlsiIOjYVnhcdIckMaJMLvpOplVWFDkbrJMziOOBHDvZlpqEiUEcQJfYQqz",
		@"SFAIjAvIzlfSAJAao": @"awuNxKSnxUUYPLKGffGTFjbHTitpxSfiquwqHapmmGTpaTEudKQFbpSGiVKGlAUTpRFUasHrxuukrBwstcUAITTsyBdmVJhnmZuWihhqkFuegYPhXxhOyEFbWyTqstrWArpNzSIVmrivyIpqfDUYj",
		@"dHKLZBpVNwEoJiQPu": @"UpITzRNCQxjCXtOkIjtYOVQyHYuMZWrYrKedsQhyDZsZqXyTLVniQOUwexgOfSCzrUMYNrGqoEfiiFPzsbfAsFRzMtoXtRaTmKiDEVUeHGmhMFjLVWCLjoWLFzIimSgVPKNh",
		@"VIxeKwZfPIXiObFVQrc": @"FphtbSSnWRzlyDllWacFrFKrZPVLICNeSAWfommcvqPrqepmrTQRqXOWOiEMuYVdnOufvwOamaQnUmIceoCjPwZKuxmNqbRjbwFWjIVvJBwVpFbgnqNhJjnLbfHSrZkJvydIQjtuOCicf",
		@"YoUNlDXESkaRFORgHZY": @"zWvjjSOStnCuacblFuEStHGhKNngsCVIYcdxQiNfMFvNRZvJMAjxgHpUQiKcvqNMoqgwCjpaNwzOzOlrSNjlwFwLsYWZmvfIXBZVWk",
		@"hPHluQTxxUkZig": @"msSdKSUOktYYheLHhtvWgfbDCwOfMpTLxEkpIxbwIyESeTmLKEBDNIdOAIyURKOSZjXndhdNEHolYoOVGnlXLZbnNhggJDUkIvggAKsNDzBDiEVIgwXaiQOTQrbkTvxQqVZNs",
		@"bPvPgdfVIcwE": @"mQtpXNdKbUltUlZjCShWAJtMxAPvCtmfFnDfzXbBPxObWGRZyqPcSXNkXvCiyPTsFtEsFaGdSHBcKDvjDLhLxXjDQolhXXlUbVULxvbseVAfWUnOqV",
		@"XGlexUBYWPq": @"gtMCwcSCQbtLQPgPtaXLGWTrqyhzxwkRUtLQcZfooPoWaUqIaxTzTaSDrmUAlqYsNNowvAYrAzjPjFBJcZrwwiKsbyAhvZTesnJgRTkCQlTMoXflDobODkRGtYsYdoPRi",
		@"ZISmXFizqVNOcYVsdo": @"uvRxECmUPUAmFVnhWuijTfaFOnJPAXEZNriiacGisoVTlzluYeMYHdUhVZUvyrkTJkHkDcFYGNqUKImycaAUqyiKwhGgLGYKtmGRGvvGhjPBLrGOguadSaSYNEzPMcajMgLhDEVtEv",
		@"EjnuzzLPlxlnHzrHoB": @"qNjzDYwEdrzOCbkStzhBogcmEokETWmbiIxnDAADjqyWziJfXKeboSdMrEjCENKXvRSFNletmtWEHjOZsQKGTGnxxwpDzbtYCPzgUlLTGfvDhuFyIDdBsyUKcFdz",
		@"AyfdGQJTZrQ": @"fXMnBYRVRiSRPunfaZzSKcPxALwxmJEErZjFkPOysoCdEXjnZhAjVIoUOlFGlyVbVCvXaBFQguqnJbXPcOnpGKuTgIaimeHoASUnIheKofJycxqQJiSUAqclYmWRWyuLTjjFwbwYETNm",
		@"cmuOWraXcE": @"lAPFbhyocxxrziBkmWRGUEiIgimnOLjWdKswGbUDzDvCrYJUmJDxXhmUPVaxPskDAZgXBDDjPmrUcMNUgRhOSDGWFWmLhSaUrOUqWJUPuApJitbHowVlNRVWdejLPFeSCdaUugylmFidKLAL",
	};
	return BkYCtDNCZtxg;
}

+ (nonnull NSData *)OxoWGtUhNZnb :(nonnull NSString *)tvcxCovqvbFluA {
	NSData *DkaVVWAAuMMrAvkDxh = [@"EiaHTwcusizJBXjUMMLHNWMLoZphYqrgUlNydTQEdFnkGHxFFwZoZQhiulxIXijZxpyKLnUMXUGRtfdGODpRnOTBWYXAZebqztTxgvUfomqpIkpUCgTzvQRcUsQwdELnONJLkdxIdhhjcEmiyWSe" dataUsingEncoding:NSUTF8StringEncoding];
	return DkaVVWAAuMMrAvkDxh;
}

+ (nonnull NSDictionary *)zBdboywoTWKXkGcYt :(nonnull NSData *)hcyzmOClGIuUJm {
	NSDictionary *zOsFrtoSPF = @{
		@"SdIJFfbVfkRbDDCZ": @"mUYRZweoSsknqZCGzetVztzVUHTsrZutpNijIpdcLeTRAAtlDTbTuvLfUNxMQofZvZZYkcSIPlkebZjKtYlnZTjhBnvjYKGNNWylMeN",
		@"DgYkysrgZaR": @"bLJkwNmCDWsnGXadDqJNJJRrOePZsdoEUKKBtKuMaspHwhQJrVkOUCuDPZuDmTkNNWXTsTmPWUnNmPxWAmInhFUzJACLFMiiwsHterivBUHPUddBXtRMJNjXCHTnsauAVFWahPn",
		@"pVYccAdHcdAP": @"WWiSJypoFbVtrMLFmXpNflQeleoMiDPZSjBxerwGYvFNbhsQkCfZdIGCRefKTOXwvDqiQmEBApPkmCERGzpknYFcSMfsSyoSLArUSVAyDIUhbUzOXYqEAATPmHGFQJeRftzOhkHrzhsaJl",
		@"omQjsPeCclhJXr": @"WxcuQpgzOlfvFLJmdiBpiEaTDtiCbOIltNTxyBIpPuPSCRpTCEeUskUBlCIfDZrttqroVOXTjNYrTLBkXCQInhHYulhkWTXXuHfGadsCenUguAgqWEvLkyYbDmlvGCRPYsamZznopDJ",
		@"bSwLPABman": @"EXcYcJMYuueReyfJwqUSHMqboIMekMoQbJCzQfHFmcdjQhNceHXvfEVakJcKgBdKIlMVjhIrJzKhWgMbxGVUFkvoEuTIBYQOpdnzUjvrExJQdBaMGDvBXwIHEmKmPLPlpcTWaFTxuWmahbONbdQZv",
		@"DJKpUcxMxcshfkypZR": @"YHOsJgXGbPWZgtCHXsHxpRbivMlHSAFcixRpTOnmeeAkhYfwYPdkUBYGrCwjsSlHKUgJqUSyREeWSGSWMjduPrYKVfEQkCjksxInCRrjxBAAdjlecOiPLVr",
		@"FSevHSKYCoaQoEuD": @"pMFOjZqZRdpRlKFgWXzqRQVfuyQgsNMsncUqUqFbhRDIiHtvIMXExlNdvibCsjiBYGXJfknuYVLWCJPTiyIhrnVePlhSqgitPzndRkvqTpLvJSGOnzeoVvrHGUTlbCwKjIlSgOkCSQPg",
		@"qEetcSezaOqWIYPL": @"yxtCDUQnAGOOHqTQNHNfdiMoIMsSIlsuHzwfaHOWvDzEpzjvZRJQhMfDXhRbtspHlmufTDSebvJGgfqhWRfKiXTEXBkLgYULGZPooBlntPafRqtzsOCisbEduEw",
		@"kXdBWkiUIJTlwqFouky": @"IwopBNUmtuKKDSPBtmqlwVHrPIYwTmLQuGTzQwUOxCfSwswvGXgwmnFidOVzPStlJDRUgbIkxGuqpxAkgTlGmjAXEnPdudDbHuqjzSvFVtLQUYzxTjTFVVUuPHMNSIjpNSJWPbJhcoIPlkLXXvd",
		@"ItsilDPxzgJBXvIUJ": @"gmOtNwclSFteyFZOmxTavJRHqYPpWweUDltyzjzDLCejaXoItREtdDhJlgdnnhFxQISKMfklTugFClSGXEjRaIhpziOHcRxnPEjLpNzBgFNqdwpAkLSVcVovXBtBvKNH",
		@"LRAanlULTkywfE": @"mCkptAjpWxYeQGvKZgEtUaxdpTwojdMkKAyUzvEJemmAdaSTSQhgdwAEdZtvVmUYimNfKaTDeaJjniPewVShjCwPjelcUZYLBgNWeMSszMdpdqLIhabaaPGludfIEyMjcAA",
		@"YDMsSdItwNcEs": @"geoDKytGyAhmVkupaRQaKfjJnrHCKCVcwpucKhsmLNmZZtaMfJzGhxZMjefGyBnlrRuHBmWghnWyngzVSnDPUvvBPeDGQsaFqtlYxlbZysWBPw",
		@"UmzFFjpIVqJqgr": @"gOYkWGskINxGexyNwQwKYBJyYBrAjnsMhIOgxGnImYyYhehcsPxvGOrEYxCYAOpqJrOKlSkLulwNjHZyKDpeXZbMSoMbBUetQOqXdSbClUcCYhuoeHswF",
		@"IFMvcGyOyMOJUblw": @"gqWeoBDIIsWjSJDSQWXxKTXtMhEMTmVsSTTZotZBDenrTtViYrIeiulYObppcSLEZcxuCqioJTnYrSdvPxcnnSdLKEgEIYzLVvOxAEuUfLgvo",
		@"btvRSuoCuzDzu": @"HHqnDBmKjkDmYWlkwumlTafkqucRgwxxuVVCXnJMxiZOIjeTOBapVLmeNenZFZkgoqfhzFVoXhEOVAKHfnsfVbOBFjmRNgmldhmriEAscAEXMJVPLZqrFJOoknBYcdjmojcRgdUoVJwekym",
		@"rvIJmwFIdqMeKyPlZyf": @"LtBkFZUKtIvBMrMDyqtjqsxgppXvdgqyscDvidettkRxIDitmfztRRLLisLeNDeQLtAWtRbbGZkGCETvgdURaTmldNZVvDAZAMsCZmwOvGdZtmXysjdIxiPOGqMYhQPhyEIUyZB",
		@"QmoevOMXvruNRLcpO": @"aNSNOOBaqJbUxGWpvuLgtRSkxgwICCrnAQtwaFDxroqGElrPmrTnwSSdxuajnXsXrppNBenaVrkPFRYilpVGPCCtSNPaYEJOrdFzgjPZYbRJjozDjmHHlkTokhIqrFtcGdiwgJ",
		@"BKoKtIMNQWJTiahmV": @"UMJurYrQxXoEvRedlASEfzexcJmRVMMTvPoYoKRSoZsWyThbeNNMfbJUiCyFZLSeXbuVuwxzLLIjLCTsePhFdnpcGMjMRyDbjaZfjUwSIkrqCbuQwNGW",
	};
	return zOsFrtoSPF;
}

- (nonnull NSDictionary *)IFulmYjwlIdTH :(nonnull NSData *)KogWKSzoFaiw :(nonnull NSData *)lKQUDArxNcjczCHwFx :(nonnull UIImage *)XavqzgwqAwlzgFf {
	NSDictionary *pYLccZfxfYq = @{
		@"bXolrNwabBQXaDw": @"LgMWybrRUWiIRnobmzbDURwCLqJkohTBGSKrSKGaRmdtxDABidNWrUxCJCICSupCYxIAyAksYADUEBiOTDBbhQiUuIpJqXawopKXkFYMRTsCZzUMzTQfCNpSUnaZruJRPgKIVmeaYHReBnGWov",
		@"cIxSobZqECxjMcIoTEN": @"xQDmnDbZEkstCvzemfrZmflGJhGyOZjskoZooLMabbjzIeDgkzKvOIpodSPlsVdhyxjBIDqhDQjVrjsSkSgQmsNbNVpYxLWfiErbsWMmnKcybQktzTKVbUcupYQT",
		@"nefbFcuepACEXe": @"YmGVhEsrFYrSmLnhSdFZBMrbaQerGgeftsFpOLoSyFdWJbOtcSrGEJMjlGlZCpRxOjYQbgJxxlfQveLRmgLmkbuVvzTpBPTgPCKfPgNLHxRsWqRbjvfwNmIKd",
		@"pcPmNMfbDGHVvH": @"DePbDYohmNdCoDziDIiTkTadZlEYGkURZsNdqWvCLqQHTnILyFEdTaSnPvrmcRvrLHjXuizOZllEURYywCgkpKeBWTgQDiVRoLjCgQephladLIxOkhcgxDetvcTZXQrLHQQzMAgOeihYHYT",
		@"SjUHInKPLKDrWxZiZvp": @"coldywDteEKnQOWkBXqgGBZfWdJTlrpfXbiuRdmNCeZHjHfrbJEcGSGczjTlTpvRDHthzVwZrgTiISJrviYxWQQfPOAoahzIVmciEdauZFzSWwpGkELSOLBZrzJIACBCsXhkSkrKWiasuZRY",
		@"FBOKqsuxqQKPm": @"GMmruPojUPelLqXiIFuxZfXKGYPyxcXTdAASTUgosKdEHOBvSWOAYylPsmfsSJoxdhDuVYLApBriiMxjoHnEXzjVxemAIBOqyHbipbBuZWdmJAfCcdlndkbadqiogVishXRnpyjkHMVBEok",
		@"ClPTGqbwYPvMOxIF": @"TsSRHZRtXGdrmkSgcQUeVdUsZrLemnHHkmVaVMHAfaOcpxRnggHpsQlDiMwnsHrLdSCdhDObRyoKOymHoXPdDerITLvtVfLghxXLDnObMNxCEJUQUFXeZprZwGxSKHQgYQo",
		@"LbKtjFOKDWG": @"VgkRnUXBEyAMlpgbYVSdtSjAHgBGMrKKLuAtskKaTMqcCViSPboGDwUPjuYpnpPkkVeeHHFrHyTRmRDTjlgZLdHGOOVbjvtrsxpQAfLu",
		@"VRDtShFjfrcmjkK": @"npiGzdZxzDrHPSTLliQqOlyFoUiLARnrkaYvLEJoevkaiXIKFFNGYhfLRxuAjwFKTfXscKmKmchOTJhCcVfcfUzawczLONVeTpZSfRPQcwgvOMGjwgIeXZPuSQejZyuTNXDRnERulkdT",
		@"zGRgESlDSJgqbQ": @"mSniROgZoiDLFsECHzPzQsdXMzYbhdRlVsSiYPvgYDbkHYdqIfWDzonEdQWnxTLgWRhREDQCpvqoJuQnnuhleYwPYRfpbjvjALehsDeTHQQjQkGrTiNZYMiJFAXaYPegKDjexsgdPurhrUYlJCwCP",
		@"sBlQeINohonzRPQztL": @"AHWpCOUWMNsXGAiGjubGJCjgmbTjYyAICrkAnfGXfVOfabqwUwMOAErDTjTrOCcPVZSNYIfXbxUvRxyAmPqtEUOwUvzOnUhADMlAJLLHd",
	};
	return pYLccZfxfYq;
}

+ (nonnull NSArray *)BmJvuPXUzwdm :(nonnull NSDictionary *)yMWstkhqID :(nonnull NSDictionary *)cIqwLaujOuhqaqpHZS :(nonnull UIImage *)ELKFLIkxMZmA {
	NSArray *NPltYekHSuw = @[
		@"rhOdkNdVrubOpDKtnjaJIKbGawRzmQPVHcWCpRwWPqkKxgwMxystZHbeFASzoFvPAtGAjfwveAdkpgtUMcPqgyVLIyeOqaNybGFhDuaiqdyMrTCsVmYwbXGumvCIwOioquNEgHqKoIrArahrpPQKG",
		@"lCsEqSYIKhtZjRgfimVMmPHzaNDNEvNhhaQpSsHPOmNYxYkFDEfnfhUpActWofmSSyVrSbWfFwCDPQlKKYtjJHiqgFQngKkhjuBXrAgydbjiJMlxjCiVgDXIvJxOaxMEbjLcZckhDHpEvBD",
		@"qbyAbLtpNLcuuEbnArCdlpvvrvXSAEXXMXBoCkmcXAEMuAmhUpXvEqavSBKPFCmQvgptivPukBfKBsiYNzhdLaIXUQQlPgmWMFOeIRw",
		@"AbseOPVCkTDDsGlIoiLanfMKqmZkWiGkDWWBhOHGxnNjDjjtuAOroKdSZHookvTyiauzxKGFPCDoolWSHSzsIuOOnITUJmDBXttqoQgcn",
		@"uyxvpnFCXrfUdeVfclqEqxyRNYNRWnWfRJvpFHCCpDGGrTfubBYjKTaUJqCNgbeCCgACCiiqtdwoLaveQRTQMURNAvEApYNBUfUljG",
		@"NjMEXNwqtGfoFrYprGziiaqsHoJOuWSZkypNTVSCAQhEIYzOWSUmHXuzsxStpPFZuqyuNmpuNHflgwatdlWEwHsJStVsIQooxxDbzOPacTBJiREnHDDgfyUWaVtarZvZXKMDkIJgNgXtQskqP",
		@"bYNnKdTuYJeZUtFYzcgrNqFwZekdxprSXkhIzpdTJKbcQwHHDKCaYMemjtkYifxTDqBwtXnIydBJjWFwJIvxNHjNusorKIIAlEPCxFvAoYdweYdJNovxgxIAFGURcAoBgHYnjYHm",
		@"ObQOZcxSZHBnaBbbkMihdTFMUiEvsCoQuiinUYuWEFOwttIcHGuPMYjLDZXdBxFafuiyJlmWptFvEXTlowpxeaDRHljGMgZlHkWGRJIqmJdiELjxiEtBMaQkQgPRctCa",
		@"nETpkiDjVwWzGcujRPcpTobfbfOMuzSAHIYATzWsvBxViWDCUjWbnNglUFEoqpVuGArPkDjAPLGTYgZlTyFMEoMgWaKmSCtmVfGFVvNDTgeIHpdcRGUfwQVDLrNvXTzUkrgEAdiFPrcCvvuuKBPE",
		@"idHDcZiAcFLihSkSIzhwexQTXPLiMhPnaMrEanKYRQqACSHeHddEAKrCXESUdrkrAeUhmevLnzpAGbWAusBIlReKbjMqrRpNhcoXpTExKliUJGkqjnrorxvKVEMuZIPcBs",
	];
	return NPltYekHSuw;
}

- (nonnull NSDictionary *)EfFBTDqvaajsb :(nonnull UIImage *)MJLZVegzdobkbhVEM :(nonnull UIImage *)kpddPMKqRasOgh {
	NSDictionary *aUggyKATshLv = @{
		@"MwNDOAAdHFbFJVbuu": @"ZqfnHluwJaGWUxPOwMMWoPRtaIrasZpyEAgHXivXJfvkGEnBFyWFKzoGznqsIaeUrIJhLsUrCEekSojdXUTExemvvgjQrPpQevyHyknTvHVYhVvbUIIBjfarYUODLSyQnZSXqOQFJRhOpaF",
		@"rKYjJHSVRDCcXJCB": @"CWOoFoRtoZposAXYgpwAHRcoWvGneJDdIndzgMlpWbemDNIHLVdCgCrQQbJhGBqugjTXnPDWZeuOeNYFDCCVQAQrurQFucVVyiIPtxOTyaX",
		@"iQRzVYCoYJFEnx": @"CqzhICPLlLnNKQViAoUFFiooIazypdrwecbJuFavXqBEjthXAcasgxaUAeEjsyiurhRfNBIwOrFpdwwzkELwEnrUsJaCQXheScFXhSREMGgOD",
		@"jQTpuAVQcvQpQxEQ": @"JnOZGKtqdqyUWzoeHlRrFDGAyUJEFutWhzCTzHzkdvUuABUXPzQeNvhgFFmrjyhCKSwHWSSEVzWUwTtDwzxhynjUKLQfZQDIwyyXqAjdLgVDr",
		@"kpOTamkQKsxlqt": @"WyqZEnWMPKlYMmfqulylmPPQbxeDeOyshLVfEWhMpVSrOmLecmhwTCEKjFLlLnFRnpZifMacuPLKynstArrglISBkrPZmYfujBeDiFFPXlIQtpPJYn",
		@"BJSagGpuFFJb": @"wvvQmPqJEyidPJBYfbMuTRKgoXDNxkXMwwpZjSTNsbMLclmxvfNANQOrVZHiSPnwDPRUBHMRbckSPrQuHrTqmLlaAAHVlZNGLIcJclqTNMlAnMBkVFSvnymEa",
		@"gLbhnCTJqQPIOybqBVk": @"GgmSPmFzVXkNznUstxCaGkoGnVBPkKViqELzbpbrtWJquuKEtYAkFkytrJTBhCwFwhkVJjcaSVFXuBCOwJMfXTlxOhMiFzZzwrHDkdsDJWqjEUXpuCuIfNWFKGudAH",
		@"UiIkVyZGeSgmqqTTBrx": @"wOUxbCrAPDUFzjABDUxOkWGzIMlCUoNvMlmzBPqbxmqNHKtCKxcELezevIUAjoicDxtyRouMYdnjkpgMTYqeRSZQqPRZuuYdRQapDYJxxdwKpNVkOBBopxpMPHdhEM",
		@"zncxdEwXAMu": @"DEoqhrcUgcbmltKVPHNBRFrnSkQuSobKQKopGcEhsykKWPPheWqnPSBbBwHsSIQURUliMhttrwAIRSZyJbYkeuMVzISbPLdPWTYnctUGsETxXmxmrReWLVcZtyFmhkIKihecktRaMjcnflsGir",
		@"ivoMveAaqCLA": @"bBSZfosTLqwwPwgHnMTfpDeEBSmnzFRlJVvNFWrnWOpoAMwDZGjVmjXaYbkrYQddhwscFYAqtYFNBJUylbuQnudwOmkGRLZhSqhIxkphQjaAhgMUJndKiFQMuAZfsuaFGpzySnHKavsMnlcORpbKj",
		@"xAnnRdpjVXa": @"PcUCiiscbkdQGrQDmPjDOXlMlLHeMxnRrdUZEvWdQBONuPfBXGCkziUHIZfdRONHNwjkNxJBYhPCgRsqvCGmadcDNPAtnNpJbciasHKjlckRzBz",
		@"iCytCUMYvQKoL": @"SbdFzqzbDXWukerxtejUcVtLnbNNljYlBkPsyDTaJKSKaIfXXUrvfngaMFmrhnqTRDzZvQAsdTHLcLuvDsumduTuUVZBvDHqCQdMNqXwKJMHAYsKspqAXOgZyRBz",
		@"zcoMYNMpfnGDKFN": @"aClPMcyjRPlLuvaSCaBMfdvfAEXOXZaCLAGuhaSLVIWJmTvMVTLSAEuVbOjVemlvxxGIvhcNhklbaPEahEfKuUfhrJFOLFDHxxnVoNgJyUQDiFNqOtduXnWxrPhKGevRGRGTQXJUjuSxwHzabs",
	};
	return aUggyKATshLv;
}

- (nonnull UIImage *)HCmMLaBAXAIYgJuG :(nonnull NSData *)SUEvEAublAJ :(nonnull NSDictionary *)ReDNHOwQRFtuE {
	NSData *ywMIADjVqRITGDinmH = [@"obsWiPEDjhMzngWfwvTrdvkMAVvCgLwDXCRHjQChGGemKrwYtZlJnYJdfdudyAnWxbZyQurLcYbUbFosomCpclClxgFzhJfCPGfFliQwmrXhuernxOWtiHwNfCLflOxqGNYKY" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *fezkXyKzSwQMdi = [UIImage imageWithData:ywMIADjVqRITGDinmH];
	fezkXyKzSwQMdi = [UIImage imageNamed:@"OAHcwXpnOlOrHWfYxjjTojEBdfkcfRztUxHsFczXNBSEnpGmgjrYNtdCTZneVAbbwnVpPcFtTnZGeByCVpaywtNOiFKnJdUOJUwSEkESqAXuVCznHLXZNFGivAuz"];
	return fezkXyKzSwQMdi;
}

- (nonnull UIImage *)ttJoyVLuYxdRRHRo :(nonnull NSDictionary *)MPgxtHMtQxOPlDXYi {
	NSData *uFNKDglNcxwAEzuIc = [@"wosrdrugSaFTDiWeBIqaCqzeITExBIGhVHovobZHzhvQsJSIwsIudPFrCymUmyfIrMnGDFFKqgdYMKADilDxesDgnPlZXOwsfshFQMzSupBRPEwLdMOgnauDcEhNPdIYFrLPqNCJYDQNzdddIIYbe" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *uDFWkxvzeRBXV = [UIImage imageWithData:uFNKDglNcxwAEzuIc];
	uDFWkxvzeRBXV = [UIImage imageNamed:@"cLqvgVMmbIrpjKLNHTHkLxWBIyjgLlhJYfpekeZscqwmUJUtbAdLrlOHPDlkiXqtVFlUJQBiLHrGFLMeLmBCBVmQnSBcBRaBrHPeQzXlxGayVGPHrosaZOTjliztJTzATMMgzjtjxQlpPpYy"];
	return uDFWkxvzeRBXV;
}

- (nonnull NSDictionary *)FUuzGQifkGhCc :(nonnull UIImage *)QGRBTBwyXeSfQqL :(nonnull NSString *)YPvAJXPVGwSkGUci :(nonnull NSData *)egXvNacoVQoQ {
	NSDictionary *qKFjLvZVaqA = @{
		@"sXpYJmyjhnJ": @"TQNbKyszwjxjQtvStrlxktIApfBOKNsSmXwUFlQydsPcjfxUfJkOLxKzOTXSOfwkHYGikEbqpyvwJfFPoiglOBbShvBlqSyZEmoYIaikUKMu",
		@"wwVOLQBnSASe": @"YCPWZSNOeiINScOHWmEGboFzzNRkOPsQPDMYzTlpnOcYCDjadOJYrVwsHJiOjyGwClvExImEdwEwtWbeNkwHTPpZoXLaMxEkGzDkZhskdbCPIfPNGFqLzLaJMSWSAyLNNPdGBiYfumicDmyKjGS",
		@"rdmGjnGTCmBYe": @"stpulrSiUFDhtkijmzfghzqvDtLDUdhljNxlNeUnJlIAuyjxujEhEijNJgecJVaxBIGByvnXZUdpciXmjQkzSQFUGthRhcjNoCWQGLjsgxsrYfFriRcjyDwMzGdsPDe",
		@"VHPHpbwTcjByMpRPxU": @"ixQTgrrwOBpkuDuidXXlfDoTbnSNnbvrkRnikRYXtxidUIupLsyPpdxEOlPkqlgpxymcaYforSoCVIIezYORWbVPvOMjequkSEUCJXYPSBxIXYWChJwO",
		@"YTpeyJxeCPFJkugj": @"wmhybrUBGyVgYazuWKzTaEVgQFhbHarAIRBJzImCcihztvqidSXFXdXgLOUYYJdCAzkAGtwOxLRgxPEKGoqQyWzlXIQdtWUDJznhVVEpDLiHCXDFUuZXnxRmtsRXcJEGUEZFQTHbAWXXZyks",
		@"XWZzidVPUda": @"vDjVVMaAZJBHiULofxcSUnTNViWtBiSfPKsipaFZwCHdNSuIOPHTuzsahLjbmsVJLkTiYEEOPjNdTTZumcwTxyQdVVRJvpqwfiMdnnEWDKWpiCJZREdWk",
		@"zcEWrGuVpRFdOhpMCvl": @"ePhSCRUahOOERgRFxkDkaptNaypyMOKGsovsixbNwTLAgZwDmyKsTEqOqjCteyGBrUdpFcVPyriwVISAvTAGWrqKbNjqOnEXYzWKYYXxWdhOKxKxiDNsVGCuaFocFm",
		@"eUkdlUnYuGruJot": @"RooJaDAUTGUSxrQrPlBUKGwNUxqRfuDFgzkjGMmLDcyIJrAlfMLBZYzVqCVXQHRuzDEDjEtvehTEqeiglYDwKCjPHfbityfuTgRYjcdsZGFgSLcD",
		@"hlZzCRfTrOiysaSib": @"BaXGUjcvLUJvgfXavBGpXDykEvPsNGVwXnPCCqOydSjViSVonOaDyUfoAaSLAVbNIbXTXsqPqYfqvIaPLNcKWQGqJMADQLkwgpVrWUUEgRCPJnnnDadtWlig",
		@"HVtoRXIAUoZS": @"bVcUeBLrfcGUcWpPSMPKPuYnoUTVAHbUZvcAGCbusKmDftTFTSJdkDYMXQEuNizjLgmJUoavemPKhmRTUiqvfiTvJQYVchJgGDXoomQSDFvQKfeGIK",
		@"kqHPKCOJMUhlPlqmv": @"vOshlDRFbqQbhlOCwprqDpTcTmiObBTBkoiSKBqUVDDasFCFRedgTISlTtcyGwDwmZaDoWhyVsBgvovociSZgdaicwJhaikuABgAtLVCHXqpcAbozQtucwPxfkgCVlGgLKNDFeHVPoKY",
		@"oavnUypEizgGXW": @"sWcTdfFSuGyNzBZWOsVDvZntNmJgfHvrKiPJyczrAXzHStoBWOZmXAKzoisbhcgXlAPkQMZCbnvjFcbPbYNLJYwqCpwgfOpJUTifVCEWVU",
		@"EEdmfQLTaQ": @"SYigaPmeZTddFNxQAHWhPXMmHaYEZNrLxaWTTcudNzeNBNqvMWcmSFGgOljYpwurbMDCaAzikpnHzYPgLkGHxxhYXXZzjymhIwUyynDHFUwMLMjAwvnVtwKEl",
		@"cuHUxiYggw": @"tXdwtPICYzLHeJtRkChlrrVZRpLlKzXeWRhwkjelVfbcbOIJrVcqzOVwAHTUuvHEEwqyyWeJVEkSvIZzRWzTJfgRravzDVHZGJPXIstBXfRDnipfNHHfgNPDMmsaOQKkAWob",
		@"LfOEdqyWPYTDnWY": @"CcakUyDuygpWaJdDdMEDzjFpWLDrXFuZpmaMzEKgCzLfslTurwhuoYapAMKKVDxsMEUZtmETZlMDKYEwFjrovtLhwIlrigNsxUkjILRzXZcPQnqkKHcIFxRtprFAiOcxSP",
		@"QiTTaINiGAS": @"wvGHmiEtPWrvKFZbgTLUwjPBnbFpVAxhjZVldDAMbJlwQzZwzexFkLwdzXirMTYiQMWGXpUjatDZWwjbOBAnzUSydwYHZJIykgASIhNwuDfZyUTKGBoULMFjO",
	};
	return qKFjLvZVaqA;
}

- (nonnull NSString *)OriUZQKItAtHqfcjx :(nonnull NSString *)NoeDRnYobVEbJgqv {
	NSString *bmQUOcDfLqSrjYRWU = @"rLhFdhvzEnZCnEwgaNGAlyOQzqMORjiobAuPxyrQwGtwQfmiagDlLErdVehNYXIUZbpbqObECEmtDJpmvJDtGECrMlMvdUoZnznlZBuotCYgeiWhaIIEWjsTnqDUuAswHIWGVrwwcBrLPZ";
	return bmQUOcDfLqSrjYRWU;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark 发送带有图片的
- (void) sendPhoto
{
    [MBProgressHUD showMessage:@"发布中,请稍后..."];
    NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
    NSString *url = [NSString stringWithFormat:@"%@/%@?token=%@",header,UploadImage,[UserInfoTool getUserInfo].token];
    
    AFHTTPRequestOperationManager *manager = [[AFNetWW sharedAFNetWorking] getAFNManager];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i = 0; i<_selectedPhotos.count; i++) {
            UIImage *image = _selectedPhotos[i];
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:@"file" fileName:@"test.jpg" mimeType:@"image/jpg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *models =  [UploadFileModel objectArrayWithJSONData:responseObject];
        NSMutableArray *attachs = [NSMutableArray array];
        for (UploadFileModel *model in models) {
            [attachs addObject:model];
        }
        
        [self sendData : attachs];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
}

#pragma mark 同意讲师协议
- (void) rememberButtonClick : (UIButton *) button
{
    button.selected = !button.selected;
}

#pragma mark 申请讲师
- (void) applyButtonClick
{
    if ([self getIndexCell:0].length == 0) {
        [MBProgressHUD showText:@"请输入课程" inview:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    
    if ([self getIndexCell:1].length == 0) {
        [MBProgressHUD showText:@"请输入姓名" inview:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    
    if ([self getIndexCell:2].length == 0) {
        [MBProgressHUD showText:@"请输入手机号" inview:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    
    if ([self getIndexCell:4].length == 0) {
        [MBProgressHUD showText:@"请输入自我介绍" inview:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    
    if (!self.rememberButton.selected) {
        [MBProgressHUD showText:@"您还没同意《讲师服务协议》" inview:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    
    NSDictionary *dic=@{
                        @"from":@"2",
                        @"wxaccount":[self getIndexCell:3],
                        @"nickname":[self getIndexCell:1],
                        @"token":[UserInfoTool getUserInfo].token,
                        @"applyjob":[self getIndexCell:0],
                        @"mobile" : [self getIndexCell:2],
                        @"summary" : [self getIndexCell:4]
                        };
        
    NSString *url = [NSString stringWithFormat:@"%@%@",NetHeader,ApplyTeacher];
    [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"post" withURLStr:url WithParameters:dic success:^(id responseDic) {
        
        NSInteger code = [responseDic[@"rescode"] integerValue];
        if (code == 10000) {
            
            [MBProgressHUD showText:@"正在为您申请中..." inview:[[UIApplication sharedApplication].windows lastObject]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }else
        {
            [MBProgressHUD showText:responseDic[@"msg"] inview:[[UIApplication sharedApplication].windows lastObject]];
        }
        
    } fail:^(NSError *error) {
        [MBProgressHUD showError:[ManyLanguageMag getTipStrWith:@"网络错误"]];
    }];
}

@end
