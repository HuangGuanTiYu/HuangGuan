//
//  VideoPreviewController.m
//  MoveSchool
//
//  Created by edz on 2018/1/10.
//

#import "VideoPreviewController.h"
#import "UIImageView+WebCache.h"
#import "H5CourseModel.h"
#import "NSString+Time_Extension.h"
#import "UILabel+Extension.h"
#import "CustomLabel.h"
#import "AFNetWW.h"
#import "DWTools.h"
#import "NSString+Extension.h"
#import "DWDownloadItem.h"
#import <AVFoundation/AVFoundation.h>//要导入系统框架AVFoundation.framework

@interface VideoPreviewController ()

@property (strong, nonatomic) AVPlayer *avPlayer;

@property (nonatomic, strong) UILabel *startLabel;

@property (nonatomic, strong) NSTimer *playTimer;

@property (nonatomic, strong) UISlider *durationSlider;

@property (nonatomic, strong) UILabel *startTime;

@property (nonatomic, strong) UILabel *endTime;

@property (nonatomic, strong) UIButton *auditionButton;

@end

@implementation VideoPreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    
    //背景图
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 210)];
    if (self.fromDown) {
        backImage.image = self.item.image;
        self.title = @"音频详情";
    }else
    {
        self.title = @"音频预览";
        [backImage sd_setImageWithURL:[NSURL URLWithString:self.model.headimgurl] placeholderImage:[UIImage imageNamed:@"common_no_image"]];
    }
    [scrollView addSubview:backImage];
    
    //标题
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(backImage.frame), self.view.width, 45 + 150 + mainSpacing * 2 + 30)];
    titleView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:titleView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.width - 30, 45)];
    if (self.fromDown) {
        titleLabel.text = self.item.title;
    }else
    {
        titleLabel.text = self.model.title;
    }
    titleLabel.textColor = MainTextColor;
    titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [titleView addSubview:titleLabel];
    
    //录音时长
    UIView *recordTime = [[UIView alloc] initWithFrame:CGRectMake(mainSpacing15, CGRectGetMaxY(titleLabel.frame), self.view.width - 2 * mainSpacing15, 44)];
    recordTime.layer.cornerRadius = 2.5;
    recordTime.layer.masksToBounds = YES;
    recordTime.backgroundColor = SepaViewColor;
    [titleView addSubview:recordTime];
    
    //进度条
    UISlider *durationSlider = [[UISlider alloc] initWithFrame:CGRectMake(mainSpacing15, 5, recordTime.width - 2 * mainSpacing15, 20)];
    self.durationSlider = durationSlider;
    [durationSlider setThumbImage:[UIImage imageNamed:@"kc_jindutiao-1"] forState:UIControlStateNormal];
    [durationSlider setThumbImage:[UIImage imageNamed:@"kc_jindutiao-1"] forState:UIControlStateHighlighted];
    [recordTime addSubview:durationSlider];
    durationSlider.maximumValue = self.model.duration;
    
    [durationSlider setMinimumTrackTintColor:MainColor];
    [durationSlider setMaximumTrackTintColor:RGBCOLOR(237,238,240)];
    
    UILabel *startTime = [[UILabel alloc] initWithFrame:CGRectMake(mainSpacing15, CGRectGetMaxY(durationSlider.frame), recordTime.width * 0.5, 10)];
    startTime.text = @"00:00:00";
    self.startTime = startTime;
    startTime.textColor = MainTextColor;
    startTime.font = [UIFont systemFontOfSize:ys_f24];
    [recordTime addSubview:startTime];
    
    UILabel *endTime = [[UILabel alloc] initWithFrame:CGRectMake(recordTime.width * 0.5, startTime.y, recordTime.width * 0.5 - mainSpacing15, 10)];
    self.endTime = endTime;
    if (self.fromDown) {
        endTime.text = self.item.duration;
    }else
    {
        endTime.text = [NSString getMMSSFromSS:[NSString stringWithFormat:@"%ld",(long)self.model.duration]];
    }
    endTime.textAlignment = NSTextAlignmentRight;
    endTime.font = [UIFont systemFontOfSize:ys_f24];
    endTime.textColor = MainTextColor;
    [recordTime addSubview:endTime];
    
    //试听暂停 继续
    UIButton *auditionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(recordTime.frame) + mainSpacing * 2, 79, 79)];
    self.auditionButton = auditionButton;
    [auditionButton setImage:[UIImage imageNamed:@"zanting"] forState:UIControlStateNormal];
    [auditionButton addTarget:self action:@selector(auditionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    auditionButton.centerX = self.view.width * 0.5;
    [auditionButton setImage:[UIImage imageNamed:@"shiting"] forState:UIControlStateSelected];
    auditionButton.titleLabel.textColor = AuxiliaryColor;
    [titleView addSubview:auditionButton];
    
    UILabel *startLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(auditionButton.frame), self.view.width, 30)];
    self.startLabel = startLabel;
    startLabel.textAlignment = NSTextAlignmentCenter;
    startLabel.centerX = auditionButton.centerX;
    startLabel.text = @"点击开始";
    startLabel.textColor = AuxiliaryColor;
    startLabel.font = [UIFont systemFontOfSize:ys_f24];
    [titleView addSubview:startLabel];
    
    //内容
    CustomLabel *contentLabel = [[CustomLabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame) + mainSpacing, self.view.width, 0)];
    contentLabel.numberOfLines = 0;
    contentLabel.textInsets = UIEdgeInsetsMake(mainSpacing, mainSpacing, mainSpacing, mainSpacing);
    contentLabel.backgroundColor = [UIColor whiteColor];
    contentLabel.font = [UIFont systemFontOfSize:ys_28];
    NSString *allString = [NSString stringWithFormat:@"音频简介：%@",self.model.desc];
    if (self.fromDown) {
        allString = [NSString stringWithFormat:@"音频简介：%@",self.item.desc];
    }

    CGFloat contentH = [NSString returnStringRect:allString size:CGSizeMake(self.view.width - 4 * mainSpacing, CGFLOAT_MAX) font:[UIFont systemFontOfSize:ys_28]].height + mainSpacing;
    contentLabel.height = contentH;
    contentLabel.text = allString;
    contentLabel.textColor = MainTextColor;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, contentLabel.y, contentLabel.width, 1000)];
    contentView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:contentView];
    [scrollView addSubview:contentLabel];

    scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(contentLabel.frame) + 64);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem setRightNavigationBarBackGroundImgName:@"\U0000e807" target:self selector:@selector(back) imageColor:[UIColor blackColor] imageFont:18];
    

}

- (void) back
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.playTimer) {
        [self.playTimer invalidate];
        self.playTimer = nil;
    }
}


- (void) auditionButtonClick : (UIButton *) button
{
    button.selected = !button.selected;
    
    if (button.selected) {
        if ([self.startLabel.text isEqualToString:@"点击开始"]) {
            
            if (self.fromDown) {
                
                // (1)获取文件（远程/本地）
                NSURL *url = [NSURL URLWithString:self.item.videoPath];
                // (3)使用playerItem获取视频的信息，当前播放时间，总时间等
                AVPlayerItem * songItem = [AVPlayerItem playerItemWithURL:url];
                // (3)初始化音频类 并且添加播放文件
                
                _avPlayer = [AVPlayer playerWithPlayerItem:songItem];
                if([[UIDevice currentDevice] systemVersion].intValue>=10){
                    _avPlayer.automaticallyWaitsToMinimizeStalling = NO;
                }
                // (4) 设置初始音量大小 默认1，取值范围 0~1
                _avPlayer.volume = 1.0;
                [_avPlayer play];
                
                [self addTimer];
            }else
            {
                
                NSString *header = [MainUserDefaults objectForKey:FileServerUrl];
                
                NSString *urlPraise = [NSString stringWithFormat:@"%@%@?zttvid=%@&video_type=40411",header,VideoInfo,self.model.ccid];
                
                [[AFNetWW sharedAFNetWorking] AFWithPostORGet:@"get" withURLStr:urlPraise WithParameters:nil success:^(id responseDic) {
                    
                    NSInteger code = [responseDic[@"rescode"] integerValue];
                    
                    if (code == 10000)
                    {
                        
                        NSString *string = [NSString stringWithFormat:@"%@",responseDic[@"data"][@"url"]];
                        
                        // (1)获取文件（远程/本地）
                        NSURL *url = [NSURL URLWithString:string];
                        // (3)使用playerItem获取视频的信息，当前播放时间，总时间等
                        AVPlayerItem * songItem = [AVPlayerItem playerItemWithURL:url];
                        // (3)初始化音频类 并且添加播放文件
                        
                        _avPlayer = [AVPlayer playerWithPlayerItem:songItem];
                        if([[UIDevice currentDevice] systemVersion].intValue>=10){
                            _avPlayer.automaticallyWaitsToMinimizeStalling = NO;
                        }
                        // (4) 设置初始音量大小 默认1，取值范围 0~1
                        _avPlayer.volume = 1.0;
                        [_avPlayer play];
                        
                        [self addTimer];
                    }
                } fail:^(NSError *error) {
                    
                }];
            }
            
            self.startLabel.text = @"点击暂停";
            
        }else
        {
            [_avPlayer play];
        }
    }else
    {
        self.startLabel.text = @"点击继续";
        [_avPlayer pause];
    }
    
}

- (void)addTimer
{
    self.playTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerHandler) userInfo:nil repeats:YES];
}

- (void)timerHandler
{
    
    [self performSelectorOnMainThread:@selector(runItem1) withObject:nil waitUntilDone:YES];
    
}

- (void) runItem1
{
    CGFloat currentSecond = self.avPlayer.currentTime.value / self.avPlayer.currentTime.timescale;// 计算当前在第几秒%f
    self.startTime.text = [DWTools formatSecondsToString:currentSecond];
    self.durationSlider.value = (int)currentSecond;
    
    //播放结束
    if ([self.startTime.text isEqualToString:self.endTime.text]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.startLabel.text = @"点击开始";
            self.startTime.text = @"00:00:00";
            self.durationSlider.value = 0;
            self.auditionButton.selected = NO;
            
            if (self.playTimer) {
                [self.playTimer invalidate];
                self.playTimer = nil;
            }
        });
    }
}

@end
