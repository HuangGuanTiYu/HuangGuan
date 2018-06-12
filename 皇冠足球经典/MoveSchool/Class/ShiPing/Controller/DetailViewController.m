//
//  DetailViewController.m
//  WMVideoPlayer
//
//  Created by 郑文明 on 16/2/1.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "DetailViewController.h"
#import "Masonry.h"
#import "NewCommentCell.h"
#import "ChatKeyBoard.h"
#import "CustomLabel.h"
#import "NewCommentModel.h"

@interface DetailViewController ()<WMPlayerDelegate,UITableViewDelegate, UITableViewDataSource, ChatKeyBoardDelegate>
@property(nonatomic,strong)    UIButton *nextBtn;
@property(nonatomic,assign)    BOOL  forbidRotate;//手势返回的时候禁止旋转VC

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;

@property (nonatomic, strong) UIView *maskView;

@end

@implementation DetailViewController
//全屏的时候hidden底部homeIndicator
-(BOOL)prefersHomeIndicatorAutoHidden{
    return self.wmPlayer.isFullscreen;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden{
    return self.wmPlayer.prefersStatusBarHidden;
}
//视图控制器实现的方法
- (BOOL)shouldAutorotate{
    if (self.forbidRotate) {
        return NO;
    }
     return !self.wmPlayer.isLockScreen;
}
//viewController所支持的全部旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    //对于present出来的控制器，要主动的（强制的）选择VC，让wmPlayer全屏
//    UIInterfaceOrientationLandscapeLeft或UIInterfaceOrientationLandscapeRight
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    return UIInterfaceOrientationLandscapeRight;
}
///播放器事件
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    if (wmplayer.isFullscreen) {
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
        //刷新
        [UIViewController attemptRotationToDeviceOrientation];
    }else{
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
///播放暂停
-(void)wmplayer:(WMPlayer *)wmplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn{
    NSLog(@"clickedPlayOrPauseButton");
}
///全屏按钮
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    if (self.wmPlayer.isFullscreen) {//全屏
        //强制翻转屏幕，Home键在下边。
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    }else{//非全屏
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    }
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
}
///单击播放器
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{    
    [self setNeedsStatusBarAppearanceUpdate];
}
///双击播放器
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    NSLog(@"didDoubleTaped");
}
///播放状态
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"wmplayerDidFailedPlay");
}
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{

}
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    NSLog(@"wmplayerDidFinishedPlay");
}
//操作栏隐藏或者显示都会调用此方法
-(void)wmplayer:(WMPlayer *)wmplayer isHiddenTopAndBottomView:(BOOL)isHidden{
    [self setNeedsStatusBarAppearanceUpdate];
}
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange:(NSNotification *)notification{
    if (self.wmPlayer.isLockScreen){
        return;
    }
    if (self.forbidRotate) {
        return ;
    }
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            [self toOrientation:UIInterfaceOrientationPortrait];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            [self toOrientation:UIInterfaceOrientationLandscapeLeft];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            [self toOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
        default:
            break;
    }
}

//点击进入,退出全屏,或者监测到屏幕旋转去调用的方法
-(void)toOrientation:(UIInterfaceOrientation)orientation{    
    //获取到当前状态条的方向
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    //判断如果当前方向和要旋转的方向一致,那么不做任何操作
    if (currentOrientation == orientation) {
        return;
    }
    [self.wmPlayer removeFromSuperview];
    
    //根据要旋转的方向,使用Masonry重新修改限制
    if (orientation ==UIInterfaceOrientationPortrait) {
        [self.view addSubview:self.wmPlayer];
        self.wmPlayer.isFullscreen = NO;
        self.wmPlayer.backBtnStyle = BackBtnStyleClose;
        [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(self.view.width, self.view.width * 9 /16));
        }];
        
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self.wmPlayer];
        self.wmPlayer.isFullscreen = YES;
        self.wmPlayer.backBtnStyle = BackBtnStylePop;
        if(currentOrientation ==UIInterfaceOrientationPortrait){
            [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@([UIScreen mainScreen].bounds.size.height));
                make.height.equalTo(@([UIScreen mainScreen].bounds.size.width));
                make.center.equalTo(self.wmPlayer.superview);
            }];
        }else{
            [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
                make.height.equalTo(@([UIScreen mainScreen].bounds.size.height));
                make.center.equalTo(self.wmPlayer.superview);
            }];
        }
    }
    
    //iOS6.0之后,设置状态条的方法能使用的前提是shouldAutorotate为NO,也就是说这个视图控制器内,旋转要关掉;
    //也就是说在实现这个方法的时候-(BOOL)shouldAutorotate返回值要为NO
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
    //更改了状态条的方向,但是设备方向UIInterfaceOrientation还是正方向的,这就要设置给你播放视频的视图的方向设置旋转
    //给你的播放视频的view视图设置旋转
    [UIView animateWithDuration:0.4 animations:^{
        self.wmPlayer.transform = CGAffineTransformIdentity;
        self.wmPlayer.transform = [WMPlayer getCurrentDeviceOrientation];
        [self.wmPlayer layoutIfNeeded];
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark
#pragma mark viewDidLoad
- (void)viewDidLoad{
    [super viewDidLoad];
    //获取设备旋转方向的通知,即使关闭了自动旋转,一样可以监测到设备的旋转方向
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
    self.wmPlayer = [[WMPlayer alloc] init];
    self.wmPlayer.delegate = self;
    [self.view addSubview:self.wmPlayer];

    [self.wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(self.view.width, self.view.width * 9 /16));
    }];

    self.wmPlayer.backBtnStyle = BackBtnStylePop;
    self.wmPlayer.enableBackgroundMode = YES;//开启后台播放模式
    self.wmPlayer.delegate = self;
    self.wmPlayer.playerModel = self.playerModel;
    [self.wmPlayer play];

    __weak __typeof(&*self) weakSelf = self;
    ///手势开始时刻回调block
    self.gestureBeganBlock = ^(UIViewController *viewController) {
        weakSelf.forbidRotate = YES;
    };
    
    ///手势作用期间回调block
    self.gestureChangedBlock = ^(UIViewController *viewController) {

    };
    
    ///手势结束时刻回调block
    self.gestureEndedBlock = ^(UIViewController *viewController) {
        weakSelf.forbidRotate = NO;
    };
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.height = self.view.height;
    tableView.backgroundColor = RGBCOLOR_HEX(0xf5f5f5);
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.tableHeaderView = self.wmPlayer;
    tableView.tableFooterView = [[UIView alloc] init];
    
    self.datas = [NSMutableArray array];
    
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 55, self.view.width, 55)];
    toolView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:toolView];
    
    UIButton *zanButton = [[UIButton alloc] initWithFrame:CGRectMake(toolView.width - 50 - 10, 0, 50, 28)];
    [zanButton addTarget:self action:@selector(zanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [zanButton setTitle:@"赞" forState:UIControlStateNormal];
    [zanButton setTitle:@"已赞" forState:UIControlStateSelected];
    [zanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zanButton.backgroundColor = MainColor;
    zanButton.titleLabel.font = [UIFont systemFontOfSize:14];
    zanButton.centerY = toolView.height * 0.5;
    zanButton.layer.cornerRadius = 14;
    zanButton.layer.masksToBounds = YES;
    [toolView addSubview:zanButton];

    //写评论
    CustomLabel *writeComment = [[CustomLabel alloc] initLineWithFrame:CGRectMake(15, 0, toolView.width - 30 - 50 - 10, 35)];
    writeComment.userInteractionEnabled = YES;
    [writeComment addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(writeCommentClick)]];
    writeComment.layer.cornerRadius = fillet;
    writeComment.layer.masksToBounds = YES;
    writeComment.textInsets = UIEdgeInsetsMake(0, mainSpacing, 0, 0);
    writeComment.backgroundColor = ViewBackColor;
    writeComment.textColor = AuxiliaryColor;
    writeComment.text = @"写评论...";
    writeComment.font = [UIFont systemFontOfSize:ys_28];
    writeComment.centerY = toolView.height * 0.5;
    [toolView addSubview:writeComment];
    
    self.chatKeyBoard = [ChatKeyBoard keyBoardWithNavgationBarTranslucent:NO];
    self.chatKeyBoard.delegate = self;
    [self.chatKeyBoard.chatToolBar.faceBtn setTitle:@"发布" forState:UIControlStateNormal];
    self.chatKeyBoard.chatToolBar.faceBtn.titleLabel.font = [UIFont systemFontOfSize:ys_f30];
    [self.chatKeyBoard.chatToolBar.faceBtn addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
    self.chatKeyBoard.y = self.chatKeyBoard.y + 20;
    self.chatKeyBoard.keyBoardStyle = KeyBoardStyleComment;
    self.chatKeyBoard.allowVoice = NO;
    self.chatKeyBoard.allowMore = NO;
    self.chatKeyBoard.allowSwitchBar = NO;
    self.chatKeyBoard.backgroundColor = [UIColor whiteColor];
    self.chatKeyBoard.chatToolBar.textView.backgroundColor = ViewBackColor;
    self.chatKeyBoard.chatToolBar.textView.textColor = MainTextColor;
    self.chatKeyBoard.chatToolBar.textView.layer.borderColor = [UIColor clearColor].CGColor;
    self.chatKeyBoard.placeHolder = @"写评论...";
    [self.view addSubview:self.chatKeyBoard];
}
-(void)nextVideo:(UIButton *)sender{
    [self.wmPlayer resetWMPlayer];
    WMPlayerModel *newModel = [WMPlayerModel new];
    newModel.title = @"这个是新视频的标题";
    self.wmPlayer.playerModel = newModel;
    [self.wmPlayer play];
}

- (void)releaseWMPlayer{
    [self.wmPlayer pause];
    [self.wmPlayer removeFromSuperview];
    self.wmPlayer = nil;
}

- (void)dealloc{
    [self releaseWMPlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"DetailViewController dealloc");
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.datas.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"NewCommentCell";
    NewCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NewCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NewCommentModel *model = self.datas[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark 写评论点击
- (void) writeCommentClick
{
    self.chatKeyBoard.placeHolder = @"写评论...";
    
    UIView *maskView = [[UIView alloc] initLineWithFrame:self.view.bounds];
    [maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewClick)]];
    self.maskView = maskView;
    maskView.alpha = 0.5;
    maskView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:maskView];
    
    [self.view bringSubviewToFront:self.chatKeyBoard];
    
    [self.chatKeyBoard keyboardUpforComment];
}

- (void) maskViewClick
{
    [self.chatKeyBoard keyboardDownForComment];
    if (self.maskView != nil) {
        [self.maskView removeFromSuperview];
    }
}

- (void) sendComment
{
    
    [self maskViewClick];
    
    NSString *text = self.chatKeyBoard.chatToolBar.textView.text;
    
    NewCommentModel *model = [[NewCommentModel alloc] init];
    model.name = @"足球用户";
    model.content = text;
    model.headerImage = @"https://file.wuliwalufei.com/1iupzjqc2yywi/ic_userpic%402x.png";
    model.time = @"刚刚";
    [self.datas addObject:model];
    
    [self.tableView reloadData];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}

- (void) zanButtonClick : (UIButton *) button
{
    
    button.selected = !button.selected;
}

@end
