//
//  CreateVideoCourseController.m
//  MoveSchool
//
//  Created by edz on 2017/12/16.
//
//

#import "CreateVideoCourseController.h"
#import "TBCityIconFont.h"
#import "AddMusicController.h"
#import "AERecorder.h"
#import "AEAudioFilePlayer.h"
#import "TopImageButton.h"
#import "DWTools.h"
#import <AVFoundation/AVFoundation.h>
#import "CutMusicController.h"
#import "AFNetWW.h"
#import "lame.h"
#import "MainWebController.h"
#import "VideoCoverController.h"

#define kFileManager [NSFileManager defaultManager]

typedef enum {
    /** 普通 */
    Normal = 0,
    /** 录音中 */
    Recording,
    /** 试听 */
    ShiTing,
} CurrentStatue;

@interface CreateVideoCourseController ()<AddMusicControllerDelgate, CutMusicControllerDelete, UIAlertViewDelegate>{
    dispatch_source_t timer;
}

@property (nonatomic, assign) CurrentStatue statue;

@property (nonatomic, strong) AERecorder *recorder;

@property (nonatomic, strong) AEAudioController *audioController;

@property (nonatomic, strong) AEAudioFilePlayer *selectedSongCH1Player;

@property (nonatomic, strong) AEAudioFilePlayer *recordVideoPlayer;

@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, strong) UIView *musicContentView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (strong, nonatomic) UISlider *durationSlider;

@property (strong, nonatomic) UISlider *recordDurationSlider;

@property (nonatomic, strong) UILabel *startLabel;

@property (nonatomic,assign) int timeCount;

@property (nonatomic, strong) UIView *footView;

@property (nonatomic, strong) UILabel *endTime;

@property (nonatomic, strong) UILabel *startTime;

@property (nonatomic, strong) UIView *recordTime;

@property (nonatomic, strong) NSTimer *playTimer;

@property (nonatomic, strong) UIButton *recordButton;

@property (nonatomic, strong) UIButton *auditionButton;

@property (nonatomic, strong) UIView *auditionFootView;

@property (nonatomic, strong) UIButton *openMusic;

@property (nonatomic, copy) NSString *path;

@property (nonatomic, strong) NSMutableArray *paths;

@property (nonatomic, strong) NSString *filePath;

@property (nonatomic, strong) UIImageView *timeView;

//是否点击了 结束试听
@property (nonatomic, assign) BOOL endVideo;

@property (nonatomic, strong) UILabel *nameLabel;

//添加背景音乐按钮
@property (nonatomic, assign) BOOL addButtonHidden;

@property (nonatomic, assign) BOOL musicContentViewHidden;

@property (nonatomic, strong) UIView *headerView;

@end

@implementation CreateVideoCourseController

- (void)viewWillAppear:(BOOL)animated{
    
    // Called when the view is about to made visible. Default does nothing
    [super viewWillAppear:animated];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    // bg.png为自己ps出来的想要的背景颜色。
    [navigationBar setBackgroundImage:[UIImage createImageWithColor:MainColor]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpUI];
    
}

- (void) back
{
    if (timer) {
        dispatch_source_cancel(timer);
    }
    
    if (self.playTimer) {
        [self.playTimer invalidate];
        self.playTimer = nil;
    }
    
    //是否保存的提示
    [self alertSave];
}

- (void) alertSave
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"退出之后，之前的内容将无法找回，您确定要退出吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark 添加背景音乐
- (void) addButtonClick
{
    AddMusicController *vc = [[AddMusicController alloc] init];
    vc.addMusicControllerDelgate = self;
    if (self.nameLabel.text.length > 0) {
        vc.selectedName = self.nameLabel.text;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addMusic:(NSString *)filePath name:(NSString *)name
{
    self.addButton.hidden = YES;
    self.musicContentView.hidden = NO;
    self.nameLabel.text = name;
    [self stopCH1Playthrough];
    
    //文件名转换成url格式
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    _selectedSongCH1Player = [[AEAudioFilePlayer alloc] initWithURL:url error:nil];
    _selectedSongCH1Player.volume = 0.4;
    [_audioController addChannels:@[_selectedSongCH1Player]];
}

-(void)durationSlidersetting
{
    self.durationSlider.minimumValue = 0.0f;
    self.durationSlider.maximumValue = 1.0f;
    self.durationSlider.value = 0.4f;
    self.durationSlider.continuous = YES;
}

- (void) durationSliderChange : (UISlider *) slider
{
    _selectedSongCH1Player.volume = slider.value;
}

- (void) buttonClick : (UIButton *) button
{
    button.selected = !button.selected;
    
    //控制动画
    if ([self.startLabel.text isEqualToString:@"开始录音"]) {
        [self rotationAnimation];
    }else if([self.startLabel.text isEqualToString:@"正在录音..."])
    {
        [self pauseAnimation];
    }else if([self.startLabel.text isEqualToString:@"已暂停录音，点击可继续录音"])
    {
        [self resumeAnimation];
    }
    
    if (button.selected) {
        if (self.statue == Normal) {
            
            self.endVideo = NO;
            
            self.startLabel.text = @"正在录音...";
            self.footView.hidden = NO;
            
            _path = [self getPath];
            
            [self.paths addObject:_path];
            
            NSError *error = nil;
            if (![_recorder beginRecordingToFileAtPath:_path fileType:kAudioFileM4AType error:&error]) {
                return;
            }
            // 同时录制输入及输出通道的声音(即既录人声,也录手机播放的声音)
            [_audioController addInputReceiver:_recorder];
            [_audioController addOutputReceiver:_recorder];
            
            [self creatTimer];
            
            self.statue = Recording;
            
        }else if(self.statue == Recording)
        {
            
            self.startLabel.text = @"正在录音...";
            [self creatTimer];
            AERecorderStartRecording(_recorder);
            
            self.statue = Normal;
            
        }
    }else
    {
        if (timer) {
            dispatch_source_cancel(timer); // 异步取消调度源
            timer = nil;
        }
        
        self.startLabel.text = @"已暂停录音，点击可继续录音";
        AERecorderStopRecording(_recorder);
    }
}

#pragma mark 及时
- (void) creatTimer
{
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, globalQueue);
    //    每秒执行一次
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        int hours = _timeCount / 3600;
        int minutes = (_timeCount - (3600*hours)) / 60;
        int seconds = _timeCount%60;
        NSString *strTime = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hours,minutes,seconds];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //           ======在这根据自己的需求去刷新UI==============
            self.timeLabel.text = strTime;
            
        });
        _timeCount ++;
        
    });
    dispatch_resume(timer);
    
}

#pragma mark 停止
- (void)stopCH1Playthrough {
    if (_selectedSongCH1Player) {
        [_audioController removeChannels:@[_selectedSongCH1Player]];
        _selectedSongCH1Player = nil;
    }
}
#pragma mark Helper Method
- (NSString *)getFilePathWithFileName:(NSString *)fileName {
    NSString *documentsFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsFolder stringByAppendingPathComponent:fileName];
    return filePath;
}

#pragma mark - 播放录音
- (void)playRecordCH1 {
    // 通过文件名拿到文件路径
    NSString *path = [_paths firstObject];
    
    [self playRecordVideo:path];
}

#pragma mark 播放录音文件
- (void) playRecordVideo : (NSString *) path
{
    
    // 如果文件不存在,结束
    if ( ![[NSFileManager defaultManager] fileExistsAtPath:path] ) {
        return;
    }
    
    NSError *error = nil;
    
    // 利用AEAudioFilePlayer对象进行播放
    _recordVideoPlayer = [[AEAudioFilePlayer alloc] initWithURL:[NSURL fileURLWithPath:path] error:&error];
    if (!_recordVideoPlayer) {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:[NSString stringWithFormat:@"Couldn't start playback: %@", [error localizedDescription]]
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil] show];
        return;
    }
    
    // 进行播放
    [_audioController addChannels:@[_recordVideoPlayer]];
    
    __weak CreateVideoCourseController *weakSelf = self;
    
    _recordVideoPlayer.completionBlock = ^{
        [weakSelf.playTimer invalidate];
        weakSelf.playTimer = nil;
    };
    
    weakSelf.recordDurationSlider.maximumValue = (int)_recordVideoPlayer.duration;
    [weakSelf performSelectorOnMainThread:@selector(invoke) withObject:nil waitUntilDone:YES];
}

-(NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return format_time;
}

- (void) invoke
{
    self.endTime.text = [self getMMSSFromSS:[NSString stringWithFormat:@"%f",_recordVideoPlayer.duration]];
    self.timeLabel.text = [self getMMSSFromSS:[NSString stringWithFormat:@"%f",_recordVideoPlayer.duration]];;
}

- (void) footButtonClick : (UIButton *) button
{
    [self pauseAnimation];//停止动画
    
    //试听
    if (button.tag == 0) {
        
        //UI调整
        self.addButtonHidden = self.addButton.hidden;
        self.musicContentViewHidden = self.musicContentView.hidden;
        self.addButton.hidden = YES;
        self.musicContentView.hidden = YES;
        self.headerView.height = 200;
        self.recordTime.y = CGRectGetMaxY(self.headerView.frame) + mainSpacing15;
        
        self.statue = ShiTing;
        
        self.recordButton.selected = NO;
        self.recordButton.hidden = YES;
        self.auditionButton.selected = NO;
        self.auditionButton.hidden = NO;
        self.auditionFootView.hidden = NO;
        self.footView.hidden = YES;
        
        [self addTimer];
        self.recordTime.hidden = NO;
        self.startLabel.text = @"正在试听中，点击可暂停试听";
        self.startTime.text = @"00:00:00";
        self.recordDurationSlider.value = 0;
        
        [self suspendMusic];
        
    }
    //重录
    else if(button.tag == 1)
    {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"重录之后，之前的内容将无法找回，您确定重录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 1;
        [alert show];
        
    }
    //保存
    else if(button.tag == 3)
    {
        [MBProgressHUD showMessage:@"正在保存，请稍后" toView:[UIApplication sharedApplication].keyWindow];
        
        self.endVideo = YES;
        self.statue = Normal;
        
        if (timer) {
            dispatch_source_cancel(timer); // 异步取消调度源
            timer = nil;
        }
        [_recorder finishRecording];
        [_audioController removeOutputReceiver:_recorder];
        [_audioController removeInputReceiver:_recorder];
        _selectedSongCH1Player.channelIsPlaying = NO;
        self.openMusic.selected = YES;
        self.recordButton.selected = NO;
        self.startLabel.text = @"已暂停录音，点击可继续录音";
        
        //跳转到封面界面
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow];
        VideoCoverController *vc = [[VideoCoverController alloc] init];
        NSString *path = _path;
        if ([_path containsString:@"Documents/"]) {
            path = [_path substringFromIndex:[_path rangeOfString:@"Documents/"].location + [_path rangeOfString:@"Documents/"].length];
        }
        vc.videoPath = path;
        vc.videoLength = self.timeLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    //裁剪
    else if(button.tag == 2)
    {
        self.endVideo = YES;
        self.statue = Normal;
        
        [self pushCutMusic];
    }
}

#pragma mark 跳转到裁剪
- (void) pushCutMusic
{
    if (!self.recordButton.hidden && self.recordButton.selected) {
        self.recordButton.selected = NO;
        self.startLabel.text = @"已暂停录音，点击可继续录音";
    }
    
    _selectedSongCH1Player.channelIsPlaying = NO;
    self.openMusic.selected = YES;
    
    if (timer) {
        dispatch_source_cancel(timer); // 异步取消调度源
        timer = nil;
    }
    
    [_recorder finishRecording];
    [_audioController removeOutputReceiver:_recorder];
    [_audioController removeInputReceiver:_recorder];
    
    CutMusicController *vc = [[CutMusicController alloc] init];
    vc.videoLength = self.timeLabel.text;
    vc.cutMusicControllerDelete = self;
    if (self.audioController) {
        vc.audioController = self.audioController;
    }
    
    if (self.paths.count == 2) {
        AVURLAsset *audioAsset1 = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:[self.paths firstObject]]];
        AVURLAsset *audioAsset2 = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:[self.paths lastObject]]];
        
        AVMutableComposition *composition = [AVMutableComposition composition];
        
        // 音频通道
        AVMutableCompositionTrack *audioTrack1 = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:0];
        AVMutableCompositionTrack *audioTrack2 = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:0];
        
        // 音频采集通道
        AVAssetTrack *audioAssetTrack1 = [[audioAsset1 tracksWithMediaType:AVMediaTypeAudio] firstObject];
        AVAssetTrack *audioAssetTrack2 = [[audioAsset2 tracksWithMediaType:AVMediaTypeAudio] firstObject];
        
        
        // 音频合并 - 插入音轨文件
        [audioTrack1 insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset1.duration) ofTrack:audioAssetTrack1 atTime:kCMTimeZero error:nil];
        // `startTime`参数要设置为第一段音频的时长，即`audioAsset1.duration`, 表示将第二段音频插入到第一段音频的尾部。
        [audioTrack2 insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset2.duration) ofTrack:audioAssetTrack2 atTime:audioAsset1.duration error:nil];
        
        // 合并后的文件导出 - `presetName`要和之后的`session.outputFileType`相对应。
        AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:composition presetName:AVAssetExportPresetAppleM4A];
        NSString *outPutFilePath = [[self.filePath stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"xindong.wav"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:outPutFilePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:outPutFilePath error:nil];
        }
        
        // 查看当前session支持的fileType类型
        session.outputURL = [NSURL fileURLWithPath:outPutFilePath];
        session.outputFileType = AVFileTypeAppleM4A; //与上述的`present`相对应
        session.shouldOptimizeForNetworkUse = YES;   //优化网络
        
        [session exportAsynchronouslyWithCompletionHandler:^{
            if (session.status == AVAssetExportSessionStatusCompleted) {
                [_paths removeAllObjects];
                [_paths addObject:outPutFilePath];
                // 通过文件名拿到文件路径
                NSString *path = [_paths firstObject];
                
                vc.videoPath = path;
                
                [self performSelectorOnMainThread:@selector(pushToCutMusicController:) withObject:vc waitUntilDone:YES];
                
            } else {
                // 其他情况, 具体请看这里`AVAssetExportSessionStatus`.
            }
            
        }];
    }else
    {
        // 通过文件名拿到文件路径
        vc.videoPath = [self.paths firstObject];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void) pushToCutMusicController : (CutMusicController *) vc
{
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)dealloc
{
    
}

- (void)addTimer
{
    self.playTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerHandler) userInfo:nil repeats:YES];
}

- (void)timerHandler
{
    if ((int)_recordVideoPlayer.currentTime + 1 <= _recordVideoPlayer.duration) {
        self.recordDurationSlider.value = (int)_recordVideoPlayer.currentTime + 1;
        [self performSelectorOnMainThread:@selector(runItem1) withObject:nil waitUntilDone:YES];
    }
}

- (void) runItem1
{
    self.startTime.text = [DWTools formatSecondsToString:_recordVideoPlayer.currentTime + 1];
}

#pragma mark 试听暂停继续
- (void) auditionButtonClick : (UIButton *) button
{
    
    button.selected = !button.selected;
    
    if (button.selected) {
        self.startLabel.text = @"已暂停试听，点击可继续试听";
        [self.playTimer setFireDate:[NSDate distantFuture]];
        _recordVideoPlayer.channelIsPlaying = NO;
    }else
    {
        self.startLabel.text = @"正在试听中，点击可暂停试听";
        [self.playTimer setFireDate:[NSDate date]];
        _recordVideoPlayer.channelIsPlaying = YES;
    }
}

#pragma mark 裁剪 试听结束
- (void) auditionFootViewButtonClick : (UIButton *) button
{
    
    //试听结束
    if (button.tag == 1) {
        
        self.addButton.hidden = self.addButtonHidden;
        self.musicContentView.hidden = self.self.musicContentViewHidden;
        self.headerView.height = 300;
        self.recordTime.y = CGRectGetMaxY(self.headerView.frame) + mainSpacing15;
        
        self.endVideo = YES;
        if (_recordVideoPlayer) {
            [_audioController removeChannels:@[_recordVideoPlayer]];
            _recordVideoPlayer = nil;
        }
        
        self.openMusic.selected = YES;
        
        self.auditionButton.hidden = YES;
        self.recordButton.hidden = NO;
        self.auditionFootView.hidden = YES;
        self.footView.hidden = NO;
        
        self.startLabel.text = @"已暂停录音，点击可继续录音";
        [self.playTimer invalidate];
        self.playTimer = nil;
        self.recordTime.hidden = YES;
        
        self.statue = Normal;
    }
    //裁剪
    else if(button.tag == 0)
    {
        [self.playTimer setFireDate:[NSDate distantFuture]];
        _recordVideoPlayer.channelIsPlaying = NO;
        
        [self pushCutMusic];
    }
}

#pragma mark 打开关闭背景音乐
- (void) openMusicClick : (UIButton *) button
{
    button.selected = !button.selected;
    
    _selectedSongCH1Player.channelIsPlaying = !button.selected;
}

#pragma mark 暂停录音和背景音乐
- (void) suspendMusic
{
    //关闭背景音乐
    _selectedSongCH1Player.channelIsPlaying = NO;
    
    if (timer) {
        dispatch_source_cancel(timer); // 异步取消调度源
        timer = nil;
    }
    
    //关闭录音
    [_recorder finishRecording];
    [_audioController removeOutputReceiver:_recorder];
    [_audioController removeInputReceiver:_recorder];
    
    if (!self.endVideo) {
        
    }else
    {
        self.endVideo = NO;
    }
    
    //如果有2个 录音文件 拼接起来
    if (self.paths.count == 2) {
        AVURLAsset *audioAsset1 = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:[self.paths firstObject]]];
        AVURLAsset *audioAsset2 = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:[self.paths lastObject]]];
        
        AVMutableComposition *composition = [AVMutableComposition composition];
        
        // 音频通道
        AVMutableCompositionTrack *audioTrack1 = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:0];
        AVMutableCompositionTrack *audioTrack2 = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:0];
        
        // 音频采集通道
        AVAssetTrack *audioAssetTrack1 = [[audioAsset1 tracksWithMediaType:AVMediaTypeAudio] firstObject];
        AVAssetTrack *audioAssetTrack2 = [[audioAsset2 tracksWithMediaType:AVMediaTypeAudio] firstObject];
        
        
        // 音频合并 - 插入音轨文件
        [audioTrack1 insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset1.duration) ofTrack:audioAssetTrack1 atTime:kCMTimeZero error:nil];
        // `startTime`参数要设置为第一段音频的时长，即`audioAsset1.duration`, 表示将第二段音频插入到第一段音频的尾部。
        [audioTrack2 insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset2.duration) ofTrack:audioAssetTrack2 atTime:audioAsset1.duration error:nil];
        
        // 合并后的文件导出 - `presetName`要和之后的`session.outputFileType`相对应。
        AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:composition presetName:AVAssetExportPresetAppleM4A];
        NSString *outPutFilePath = [[self.filePath stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"xindong.wav"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:outPutFilePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:outPutFilePath error:nil];
        }
        
        // 查看当前session支持的fileType类型
        session.outputURL = [NSURL fileURLWithPath:outPutFilePath];
        session.outputFileType = AVFileTypeAppleM4A; //与上述的`present`相对应
        session.shouldOptimizeForNetworkUse = YES;   //优化网络
        
        [session exportAsynchronouslyWithCompletionHandler:^{
            if (session.status == AVAssetExportSessionStatusCompleted) {
                [_paths removeAllObjects];
                [_paths addObject:outPutFilePath];
                
                [self playRecordCH1];
            } else {
                // 其他情况, 具体请看这里`AVAssetExportSessionStatus`.
            }
            
        }];
    }else if(self.paths.count == 1)
    {
        //直接播放
        [self playRecordCH1];
    }
    
}

//录制音频沙盒路径
- (NSString *)getPath
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMddhhmmss"];
    NSString *recordName = [NSString stringWithFormat:@"%@.wav", [formatter stringFromDate:[NSDate date]]];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:recordName];
    
    return path;
}

- (NSString *)filePath {
    if (!_filePath) {
        _filePath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
        NSString *folderName = [_filePath stringByAppendingPathComponent:@"MergeAudio"];
        BOOL isCreateSuccess = [kFileManager createDirectoryAtPath:folderName withIntermediateDirectories:YES attributes:nil error:nil];
        if (isCreateSuccess) _filePath = [folderName stringByAppendingPathComponent:@"xindong.wav"];
    }
    return _filePath;
}

- (void)cutMusicSuccess:(NSString *)path currentTime:(int)currentTime
{
    
    if (self.paths) {
        [self.paths removeAllObjects];
        [self.paths addObject:path];
        _path = path;
        self.statue = Normal;
    }
    
    _timeCount = currentTime;
    
    self.timeLabel.text = [self getMMSSFromSS:[NSString stringWithFormat:@"%d",currentTime]];
    self.startTime.text = @"00:00:00";
    self.recordDurationSlider.value = 0;
    [self.playTimer invalidate];
    self.playTimer = nil;
    
    if (self.statue == ShiTing) {
        [self stopCH1Playthrough];
        [self playRecordVideo:path];
        [self addTimer];
    }
}

- (NSString *)getTimestamp{
    NSDate *nowDate = [NSDate date];
    double timestamp = (double)[nowDate timeIntervalSince1970]*1000;
    long nowTimestamp = [[NSNumber numberWithDouble:timestamp] longValue];
    NSString *timestampStr = [NSString stringWithFormat:@"%ld",nowTimestamp];
    return timestampStr;
}

- (void)audio_PCMtoMP3
{
    NSString *cafFilePath = _path;
    
    NSString *mp3FilePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@.mp3",[self getTimestamp]]];
    
    NSFileManager* fileManager=[NSFileManager defaultManager];
    if([fileManager removeItemAtPath:mp3FilePath error:nil])
    {
        NSLog(@"删除");
    }
    
    @try {
        int read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 8000.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {
        
        NSError *playerError;
        AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSURL alloc] initFileURLWithPath:mp3FilePath] error:&playerError];
        
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategorySoloAmbient error: nil];
    }
}

//暂停动画
- (void)pauseAnimation {
    
    //1.取出当前时间，转成动画暂停的时间
    CFTimeInterval pauseTime = [self.timeView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    //2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
    self.timeView.layer.timeOffset = pauseTime;
    
    //3.将动画的运行速度设置为0， 默认的运行速度是1.0
    self.timeView.layer.speed = 0;
    
}

//恢复动画
- (void) resumeAnimation {
    
    //1.将动画的时间偏移量作为暂停的时间点
    CFTimeInterval pauseTime = self.timeView.layer.timeOffset;
    
    //2.计算出开始时间
    CFTimeInterval begin = CACurrentMediaTime() - pauseTime;
    
    [self.timeView.layer setTimeOffset:0];
    [self.timeView.layer setBeginTime:begin];
    
    self.timeView.layer.speed = 1;
}

//CABasicAnimation 实现旋转动画
- (void)rotationAnimation {
    
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 8;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.repeatCount = HUGE_VALF;
    [self.timeView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            self.endVideo = NO;
            _timeCount = 0;
            self.timeLabel.text = @"00:00:00";
            if (timer) {
                dispatch_source_cancel(timer); // 异步取消调度源
                timer = nil;
            }
            
            [_recorder finishRecording];
            [_audioController removeOutputReceiver:_recorder];
            [_audioController removeInputReceiver:_recorder];
            self.statue = Normal;
            self.footView.hidden = YES;
            self.startLabel.text = @"开始录音";
            self.recordButton.selected = NO;
            [_paths removeAllObjects];
        }
    }else
    {
        if (buttonIndex == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}

#pragma mark 初始化UI
- (void) setUpUI
{
    
    self.title = @"录音";
    
    //不自动锁屏
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    self.statue = Normal;
    
    self.paths = [NSMutableArray array];
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 300)];
    headerView.image = [UIImage imageNamed:@"bg"];
    self.headerView = headerView;
    [self.view addSubview:headerView];
    
    UIImageView *timeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, mainSpacing15, 165, 165)];
    self.timeView = timeView;
    timeView.centerX = self.view.width * 0.5;
    timeView.image = [UIImage imageNamed:@"t_bg"];
    [headerView addSubview:timeView];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, timeView.width, 44)];
    self.timeLabel = timeLabel;
    timeLabel.centerX = self.view.width * 0.5;
    timeLabel.centerY = timeView.centerY;
    timeLabel.text = @"00:00:00";
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:22];
    [headerView addSubview:timeLabel];
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(mainSpacing15, headerView.height - 45 - 25, self.view.width - mainSpacing15 * 2, 45)];
    self.addButton = addButton;
    addButton.layer.borderColor = MainColor.CGColor;
    addButton.layer.borderWidth = 0.5;
    addButton.layer.cornerRadius = fillet;
    addButton.layer.masksToBounds = YES;
    addButton.backgroundColor = RGBCOLOR(255,133,66);
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitle:@"添加背景音乐" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:ys_28];
    [headerView addSubview:addButton];
    
    //歌曲内容
    UIView *musicContentView = [[UIView alloc] initWithFrame:CGRectMake(mainSpacing15, headerView.height - 90 - mainSpacing15, addButton.width, 90)];
    musicContentView.layer.borderColor = MainColor.CGColor;
    musicContentView.layer.borderWidth = 0.5;
    musicContentView.layer.cornerRadius = fillet;
    musicContentView.layer.masksToBounds = YES;
    musicContentView.hidden = YES;
    self.musicContentView = musicContentView;
    
    UIButton *changeMusic = [[UIButton alloc] initWithFrame:CGRectMake(musicContentView.width - 64 - 5, mainSpacing, 64, 17)];
    [changeMusic addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    changeMusic.backgroundColor = [UIColor whiteColor];
    changeMusic.layer.cornerRadius = 8.5;
    changeMusic.layer.masksToBounds = YES;
    [changeMusic setTitle:@"更换音乐" forState:UIControlStateNormal];
    changeMusic.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
    [changeMusic setTitleColor:MainColor forState:UIControlStateNormal];
    [musicContentView addSubview:changeMusic];
    
    UIButton *openMusic = [[UIButton alloc] initWithFrame:CGRectMake(changeMusic.x - 100 - mainSpacing, 0, 100, 17)];
    self.openMusic = openMusic;
    [openMusic addTarget:self action:@selector(openMusicClick:) forControlEvents:UIControlEventTouchUpInside];
    openMusic.centerY = changeMusic.centerY;
    openMusic.titleEdgeInsets = UIEdgeInsetsMake(0, mainSpacing, 0, 0);
    [openMusic setTitle:@"已开启音乐" forState:UIControlStateNormal];
    [openMusic setTitle:@"已关闭音乐" forState:UIControlStateSelected];
    openMusic.titleLabel.font = [UIFont systemFontOfSize:ys_f24];
    [openMusic setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [openMusic setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e625", ys_f24, [UIColor whiteColor])] forState:UIControlStateSelected];
    [openMusic setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e624", ys_f24, [UIColor whiteColor])] forState:UIControlStateNormal];
    [musicContentView addSubview:openMusic];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(mainSpacing, CGRectGetMaxY(openMusic.frame) + 5, musicContentView.width - 2 * mainSpacing, 20)];
    self.nameLabel = nameLabel;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:ys_28];
    [musicContentView addSubview:nameLabel];
    
    //滑动条
    self.durationSlider = [[UISlider alloc] initWithFrame:CGRectMake(nameLabel.x, CGRectGetMaxY(nameLabel.frame), nameLabel.width , 20)];
    [self.durationSlider addTarget:self action:@selector(durationSliderChange:) forControlEvents:UIControlEventValueChanged];
    [self.durationSlider setThumbImage:[UIImage imageNamed:@"kc_jindutiao"] forState:UIControlStateNormal];
    [self.durationSlider setThumbImage:[UIImage imageNamed:@"kc_jindutiao-yuandian"] forState:UIControlStateHighlighted];
    headerView.userInteractionEnabled = YES;
    musicContentView.userInteractionEnabled = YES;
    [musicContentView addSubview:self.durationSlider];
    
    [self.durationSlider setMinimumTrackTintColor:RGBCOLOR(255,185,147)];
    [self.durationSlider setMaximumTrackTintColor:RGBCOLOR(255,185,147)];
    [self durationSlidersetting];
    
    //音量+
    UILabel *musicAdd = [[UILabel alloc] initWithFrame:CGRectMake(self.durationSlider.x, CGRectGetMaxY(self.durationSlider.frame), 0, 0)];
    musicAdd.text = @"音量-";
    musicAdd.textColor = [UIColor whiteColor];
    musicAdd.font = [UIFont systemFontOfSize:ys_f20];
    [musicAdd sizeToFit];
    [musicContentView addSubview:musicAdd];
    
    //音量+
    UILabel *musicDe = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.durationSlider.frame), 0, 0)];
    musicDe.text = @"音量+";
    musicDe.textColor = [UIColor whiteColor];
    musicDe.font = [UIFont systemFontOfSize:ys_f20];
    [musicDe sizeToFit];
    musicDe.x = CGRectGetMaxX(self.durationSlider.frame) - musicDe.width;
    [musicContentView addSubview:musicDe];
    
    [headerView addSubview:musicContentView];
    
    
    self.audioController = [[AEAudioController alloc] initWithAudioDescription:AEAudioStreamBasicDescriptionNonInterleavedFloatStereo inputEnabled:YES];
    _audioController.preferredBufferDuration = 0.005;
    _audioController.useMeasurementMode = YES;
    [_audioController start:NULL];
    
    // 实例化AERecorder对象
    _recorder = [[AERecorder alloc] initWithAudioController:_audioController];
    _timeCount = 0;
    
    //按住说话
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 79, 79)];
    self.recordButton = button;
    [button setImage:[UIImage imageNamed:@"luyin"] forState:UIControlStateNormal];
    button.centerY = (self.view.height - CGRectGetMaxY(headerView.frame)) * 0.5 + CGRectGetMaxY(headerView.frame) - 64;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.centerX = self.view.width * 0.5;
    [button setImage:[UIImage imageNamed:@"shiting"] forState:UIControlStateSelected];
    button.titleLabel.textColor = AuxiliaryColor;
    [self.view addSubview:button];
    
    //试听暂停 继续
    UIButton *auditionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 79, 79)];
    [auditionButton setImage:[UIImage imageNamed:@"shiting"] forState:UIControlStateNormal];
    auditionButton.hidden = YES;
    self.auditionButton = auditionButton;
    auditionButton.centerY = (self.view.height - CGRectGetMaxY(headerView.frame)) * 0.5 + CGRectGetMaxY(headerView.frame) - 64;
    [auditionButton addTarget:self action:@selector(auditionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    auditionButton.centerX = self.view.width * 0.5;
    [auditionButton setImage:[UIImage imageNamed:@"zanting"] forState:UIControlStateSelected];
    auditionButton.titleLabel.textColor = AuxiliaryColor;
    [self.view addSubview:auditionButton];
    
    UILabel *startLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame), self.view.width, 30)];
    self.startLabel = startLabel;
    startLabel.textAlignment = NSTextAlignmentCenter;
    startLabel.centerX = button.centerX;
    startLabel.text = @"开始录音";
    startLabel.textColor = AuxiliaryColor;
    startLabel.font = [UIFont systemFontOfSize:ys_f24];
    [self.view addSubview:startLabel];
    
    NSArray *buttonTitles = @[@"试听",@"重录",@"裁剪",@"保存"];
    
    //底部菜单
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 44 - 64, self.view.width, 44)];
    self.footView = footView;
    UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, footView.width, 0.5)];
    sepaView.backgroundColor = SepaViewColor;
    [footView addSubview:sepaView];
    footView.hidden = YES;
    for (int i = 0 ; i < buttonTitles.count; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0.5, footView.width * 0.25, footView.height)];
        button.tag = i;
        [button addTarget:self action:@selector(footButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:MainTextColor forState:UIControlStateNormal];
        button.x = button.width * i;
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:ys_28];
        [footView addSubview:button];
        
        if (i != 0) {
            UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(i * button.width, 0, 0.5, footView.height - 2 * mainSpacing15)];
            sepaView.backgroundColor = SepaViewColor;
            sepaView.centerY = footView.height * 0.5;
            [footView addSubview:sepaView];
            
        }
    }
    [self.view addSubview:footView];
    
    //试听的时候底部菜单
    NSArray *auditionButtonTitles = @[@"裁剪",@"试听结束"];
    
    //底部菜单
    UIView *auditionFootView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 44 - 64, self.view.width, 44)];
    self.auditionFootView = auditionFootView;
    UIView *auditionSepaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, auditionFootView.width, 0.5)];
    auditionSepaView.backgroundColor = SepaViewColor;
    [auditionFootView addSubview:auditionSepaView];
    auditionFootView.hidden = YES;
    
    for (int i = 0 ; i < auditionButtonTitles.count; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0.5, auditionFootView.width * 0.5, auditionFootView.height)];
        [button addTarget:self action:@selector(auditionFootViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [button setTitleColor:MainTextColor forState:UIControlStateNormal];
        button.x = button.width * i;
        [button setTitle:auditionButtonTitles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:ys_28];
        [auditionFootView addSubview:button];
        
        if (i != 0) {
            UIView *sepaView = [[UIView alloc] initWithFrame:CGRectMake(i * button.width, 0, 0.5, auditionFootView.height - 2 * mainSpacing15)];
            sepaView.backgroundColor = SepaViewColor;
            sepaView.centerY = auditionFootView.height * 0.5;
            [auditionFootView addSubview:sepaView];
            
        }
    }
    [self.view addSubview:auditionFootView];
    
    //录音时长
    UIView *recordTime = [[UIView alloc] initWithFrame:CGRectMake(mainSpacing15, CGRectGetMaxY(headerView.frame) + mainSpacing15, self.view.width - 2 * mainSpacing15, 44)];
    recordTime.hidden = YES;
    self.recordTime = recordTime;
    recordTime.layer.cornerRadius = 2.5;
    recordTime.layer.masksToBounds = YES;
    recordTime.backgroundColor = SepaViewColor;
    [self.view addSubview:recordTime];
    
    //滑动条
    UISlider *durationSlider = [[UISlider alloc] initWithFrame:CGRectMake(mainSpacing15, 5, recordTime.width - 2 * mainSpacing15, 20)];
    self.recordDurationSlider = durationSlider;
    [durationSlider addTarget:self action:@selector(durationSliderChange:) forControlEvents:UIControlEventValueChanged];
    [durationSlider setThumbImage:[UIImage imageNamed:@"kc_jindutiao-1"] forState:UIControlStateNormal];
    [durationSlider setThumbImage:[UIImage imageNamed:@"kc_jindutiao-1"] forState:UIControlStateHighlighted];
    headerView.userInteractionEnabled = YES;
    musicContentView.userInteractionEnabled = YES;
    [recordTime addSubview:durationSlider];
    
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
    endTime.textAlignment = NSTextAlignmentRight;
    endTime.font = [UIFont systemFontOfSize:ys_f24];
    endTime.textColor = MainTextColor;
    [recordTime addSubview:endTime];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem setRightNavigationBarBackGroundImgName:@"\U0000e807" target:self selector:@selector(back) imageColor:[UIColor blackColor] imageFont:18];
}

@end

