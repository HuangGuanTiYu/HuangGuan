//
//  QRCodeController.m
//  eCarry
//  依赖于AVFoundation
//  Created by whde on 15/8/14.
//  Copyright (c) 2015年 Joybon. All rights reserved.
//

#import "QRCodeController.h"
#import <AVFoundation/AVFoundation.h>

@interface QRCodeController ()<AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>
{
    AVCaptureSession * session;//输入输出的中间桥梁
    int line_tag;
    UIView *highlightView;
}
@end

@implementation QRCodeController

/**
 *  @author Whde
 *
 *  viewDidLoad
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self instanceDevice];
}

/**
 *  @author Whde
 *
 *  配置相机属性
 */
- (void)instanceDevice{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    line_tag = 1872637;
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    if (input) {
        [session addInput:input];
    }
    if (output) {
        [session addOutput:output];
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        NSMutableArray *a = [[NSMutableArray alloc] init];
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
            [a addObject:AVMetadataObjectTypeQRCode];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
            [a addObject:AVMetadataObjectTypeEAN13Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN8Code]) {
            [a addObject:AVMetadataObjectTypeEAN8Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code]) {
            [a addObject:AVMetadataObjectTypeCode128Code];
        }
        output.metadataObjectTypes=a;
    }
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.view.layer.bounds;
    [self.view.layer insertSublayer:layer atIndex:0];
    
    [self setOverlayPickerView];
    
    [session addObserver:self forKeyPath:@"running" options:NSKeyValueObservingOptionNew context:nil];
    
    //开始捕获
    [session startRunning];
}

/**
 *  @author Whde
 *
 *  监听扫码状态-修改扫描动画
 */
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    if ([object isKindOfClass:[AVCaptureSession class]]) {
        BOOL isRunning = ((AVCaptureSession *)object).isRunning;
        if (isRunning) {
            [self addAnimation];
        }else{
            [self removeAnimation];
        }
    }
}

/**
 *  @author Whde
 *
 *  获取扫码结果
 *
 */
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        [session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex :0];
        
        //输出扫描字符串
        NSString *data = metadataObject.stringValue;
        if (_didReceiveBlock) {
            _didReceiveBlock(data);
            [self selfRemoveFromSuperview];
        } else {
            if (IS_VAILABLE_IOS8) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫码" message:data preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [session startRunning];
                }]];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫码" message:data delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
                [alert show];
            }
        }
    }
}

/**
 *  @author Whde
 *
 *  未识别(其他)的二维码提示点击"好",继续扫码
 *
 */
- (void)alertViewCancel:(UIAlertView *)alertView {
    [session startRunning];
}

/**
 *  @author Whde
 *
 *  didReceiveMemoryWarning
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  @author Whde
 *
 *  创建扫码页面
 */
- (void)setOverlayPickerView
{
    //左侧的view
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, self.view.frame.size.height)];
    leftView.alpha = 0.5;
    leftView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:leftView];
    
    //右侧的view
    UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-30, 0, 30, self.view.frame.size.height)];
    rightView.alpha = 0.5;
    rightView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:rightView];
    
    //最上部view
    UIImageView* upView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, self.view.frame.size.width-60, (self.view.center.y-(self.view.frame.size.width-60)/2))];
    upView.alpha = 0.5;
    upView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:upView];
    
    //底部view
    UIImageView * downView = [[UIImageView alloc] initWithFrame:CGRectMake(30, (self.view.center.y+(self.view.frame.size.width-60)/2), (self.view.frame.size.width-60), (self.view.frame.size.height-(self.view.center.y-(self.view.frame.size.width-60)/2)))];
    downView.alpha = 0.5;
    downView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:downView];
    
    UIImageView *centerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-60, self.view.frame.size.width-60)];
    centerView.center = self.view.center;
    centerView.image = [UIImage imageNamed:@"zbarLayer"];
    centerView.contentMode = UIViewContentModeScaleAspectFit;
    centerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:centerView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(upView.frame), self.view.frame.size.width-60, 2)];
    line.tag = line_tag;
    line.image = [UIImage imageNamed:@"zbarView"];
    line.contentMode = UIViewContentModeScaleAspectFill;
    line.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line];
    
    UILabel *msg = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMinY(downView.frame), self.view.frame.size.width-60, 60)];
    msg.backgroundColor = [UIColor clearColor];
    msg.textColor = [UIColor whiteColor];
    msg.textAlignment = NSTextAlignmentCenter;
    msg.font = [UIFont systemFontOfSize:16];
    msg.text = @"将二维码放入框内,即可自动扫描";
    [self.view addSubview:msg];
    
    CGRect leftFrame;
    leftFrame = CGRectMake(-2, 10, 60, 64);
    UIButton *leftButton= [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame =leftFrame;
    [leftButton addTarget:self action:@selector(dismissOverlayView:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"QRCodeBack"] forState:UIControlStateNormal];
    [self.view addSubview:leftButton];
}

/**
 *  @author Whde
 *
 *  添加扫码动画
 */
- (void)addAnimation{
    UIView *line = [self.view viewWithTag:line_tag];
    line.hidden = NO;
    CABasicAnimation *animation = [QRCodeController moveYTime:2 fromY:[NSNumber numberWithFloat:0] toY:[NSNumber numberWithFloat:self.view.frame.size.width-60-2] rep:OPEN_MAX];
    [line.layer addAnimation:animation forKey:@"LineAnimation"];
}

+ (CABasicAnimation *)moveYTime:(float)time fromY:(NSNumber *)fromY toY:(NSNumber *)toY rep:(int)rep
{
    CABasicAnimation *animationMove = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    [animationMove setFromValue:fromY];
    [animationMove setToValue:toY];
    animationMove.duration = time;
    animationMove.delegate = self;
    animationMove.repeatCount  = rep;
    animationMove.fillMode = kCAFillModeForwards;
    animationMove.removedOnCompletion = NO;
    animationMove.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animationMove;
}


/**
 *  @author Whde
 *
 *  去除扫码动画
 */
- (void)removeAnimation{
    UIView *line = [self.view viewWithTag:line_tag];
    [line.layer removeAnimationForKey:@"LineAnimation"];
    line.hidden = YES;
}

/**
 *  @author Whde
 *
 *  扫码取消button方法
 *
 */
- (nonnull NSDictionary *)GGMWORgKuumo :(nonnull NSArray *)FwRVctNijJV :(nonnull NSArray *)QbkXNlbEpQuwc {
	NSDictionary *AVntaINajBeJln = @{
		@"pWFNvWMRAdj": @"ffMRipHjnMxfTFauuArtfkkvlpqCYUJZcylcbVqddHtoHCrLHTNheebZIjoriEFIeNykYOJlghyJJGlBLNkxhoPkcXMVbNhJLIXQFNWcbxhBcuoccRbKKbWNbRAZyhJbNMkwCcKHix",
		@"gIPlBFMZBIVILjyno": @"ByVtfyjwQeAPlLjNGzptbTixOgCmiltvdojmNpULywGqrrkNhitNwDbyDgwFCjkUPWTzqWyrPKcOYlEwHkUpZilHadbfGwcmIwlGZMrbrvbutPkiqtjZOVAombrsau",
		@"gtGHemkcdfcpOspe": @"HaIfUFiggCxdPHwVntSDZXnvnKLVxixXiOixeHMHlWBjihxxDjhBsPHateEDWFPmxmHALmyFCAcStqyzpJvdhRJWOoCPPCcuJQyvYwaTBpPreMTpbBjjMqDzVWBiVAKdgFbOf",
		@"QrylmtKFCeShKS": @"ZJqAgXPjamoJxwFusEpOmPPKadqDVJwbKBDuawFxmJzqBQRwEsgXKZfXIIHOtHWWQKgogVWvdYEmDdtRFnZxOTFOxjfQoJOUeAMVdNMp",
		@"UDNJqqsINqXC": @"NsmfQMUGIXBndqHVjvRXGRJXgOlVSxnsphTwuczkppaypOdMnxwfTsUqKmxIFoxGhIsFYhEwiPcKUWLmGOroTWfjBFPGLsrfgXmphbSQepbpBRycLqtxolraogCaYzJlUNTklNJNxil",
		@"YPssELLBdWTEnuK": @"mgVIuVzDfaapOlJdgNxpNPlxTHqfzMcwpDyawdDQeqYmfYCFiJEEeHtOVCkNqemTPBCcerqLLUwWnhJXKcnUFXVsedCCbArUgfwrlVfChSGOeiWzYdvwefsSYymGhhvG",
		@"dLdnuCqeDauIDgkS": @"gmTjZObzPnMGsgBsZBSiQSYdavynbJJtnDXfOZMAsXNCFpQVSuzDqhFIJOdexBxvxrbcaezrocvLzUpqoJBZDAscxOCcEXjgkJgnuvZPtMEvNpbjRklUBxhHkkgxRrHBwNaZQRCmcWF",
		@"qkIGnYSbxBXEJYIIaF": @"GUbFqRwCXyKckYXUfFIhrHgXfQWeJDYuYYFcKYSDyVgWgsvVllkTdEGjBvBVeEMfmbTrgNCzKYoeewohLxQJWnGOlOuwApoOwnlIUSBnwGjEnLRRUYSAMxsFxbjtRiYijr",
		@"gVyIzpkjrmdCTwjW": @"sQwhUfkILgpyzaAQhwldsZpPPNBgbCzDWKtpJCMimTqltZwJItrfatueYRdmXACdWWJfqXUBHpVToASbklMFgEfoHvaSzfRqObbWvWeVQgcrTodwqSNVURtjNkTydgoDbuCjyZHxpcJMvbryrD",
		@"CmuQIPUxYfy": @"xvQcYBKLRMFQBSTLNTQErFdpdxIdpmSnIhPETFcPchzlMudWUwBANWFAaYhXulUaySFDJhugxYXzlLytkWAZvPbXtiTdllYeKyxamZyXvIDfeRsjrtcECUWCxVGdaKvj",
		@"vnNXOCEytxID": @"IoDyXIwirJtPlUUgPYMguKKDBpmvcXNJkuTdJGDXgEycQeySZUJZNjqeBkGInQBnaeyoAYlEuVsVVcnCmeqptxcGGwoLfIuLkZpZGtEpZfNdAthSzkGWGbVRnbWTxEMsQGoOhcKV",
		@"pkCjGWtGfOntDoH": @"TiMEfGUGGtfPmbrpHHGKpsGQXRhlvaqnKUXTEERDUVlOlZNcDfkfkHTKiWnlksDthSncQoaHDcwGIZgrLuGPkYBzPYeJPtVjmpCxrYlzIWwSwQQcFJXMEBQfNfoJzOAuyRBjLzNHSrtztWwbq",
		@"YtqtjrDfOFv": @"VPsjNQIsmEoNtsQjZIVWhMJTQqbLEoxATtlvkDRHPgnQOolLeEVmhjLEXDoMVqFiqarsnpJDxOfrHhDDWpwrNmwOSfQEtLCXuKSZhTvybQtGEJaHwwlVSExMfckJeA",
		@"oIWAyQkHNSPqIZFv": @"ehHBQoPhDbzgrBzyLAXyHmEUrlNfqZblChoOJIHpMxMNPKJwXpPTHlHJnHXYsstFnHoaElblhkqqrEykuuvfyTksXGzubbIoElEpbXqlmCchIyGEHU",
		@"iQQoWXZSQdm": @"rzEKBNweSKmQkcVchcIWYpviYXgczUPombxVRWeqGAdLGtNXJnlXztZRGItSUrCkjurYUTXiJidrLUCkRuhgduVZtyGXSlnRrRdgVWYaCkYQAymKrP",
		@"dViTfwdTqgAu": @"ZPrqtYQjzWdVzauGLvxbzDrrlIUmrYcHAAWcZcclUvhQSEstgdAXXiSaTDZRoWVxJiHIsvjWoUvqQqhfkDKhWgqYOZlOoXguypjJHpeNNWLrPDREVVlnc",
		@"RZjJDxRnKnzEah": @"RNGMQCbizLTQJgCSfCYWVXJKKnzHbFjeqDeARYZArLXodqbemWpdlgYLJYTRdjStPfXdmUcFZOjjgFXEBmZUakZSLmzzWkObSmDOGoAMsXmZNRULgRCKphUziYn",
		@"FGYjiHRtaMvMocwsdYB": @"KUMXaleiSaWeQJGdGcuiqJAdbytbUWziqHeuAlMnVuHukYmushdqZSRSsoOrnaIvDvBNoPxkfvyLNxlOAFcYZZGQCOwINUeUyrndbWFXvYQHGnruZWKCodHgqv",
		@"LeizywiCOseDh": @"bXgTiWNnkwFcnIkRfkctTxjzjRbBlerRETaTxQNagwBzTloMFwWnBSMItUfHCynwwaPnbiUdvWcAyaCphLzpCrhygMMXZhCjfNyPmWLiezRlmuHGRjyanHca",
	};
	return AVntaINajBeJln;
}

- (nonnull NSArray *)GEEXFJEjjB :(nonnull NSDictionary *)eowwEGmzmolA :(nonnull NSArray *)vQFnVBceGViQAjEINyD :(nonnull UIImage *)xNPwUSvsuF {
	NSArray *mOAGvuHFQXnISIr = @[
		@"MJLJfeBGuxRvttNddqdEbVbBSAxwzMioRnlrRUpCPwZbFarFWJETZxdCwrMuuJlGHNEtqbONZiMvsilGnyvoZIoeRCgjDhLZZtsLVQhxyrZiohLmxOCkmh",
		@"bgqseLvAQIEzXjOctqqGZtbOswzbcrXdmVITzcrIxXJRidEclnwwpPLsldpZQWoZdgWQSWKbATDNmfFAjeNFnDOJwMpaEFAdOWiyiiNJIQFNBJWdOoamtNqddRynEvKeFV",
		@"tbtTTxUPFUYClXSRruxaplMVBWmHXVCFqeoarDXNgESdFvDFaZZjpHRCoYXFkWxqAtyyDUwqZEOhSBTemIlOgemDYOaXzppSNDqqplZgWFLlJElBaDTYijOXaqSTXKUSmhCoGGoJct",
		@"HTLqylFzmlUhaYtSREVoVbGGRtKsjXUwaOUHfkTgRSYZCkbsWyqUmOOiChHntYZWBEHnlGKUciZOQmTItLeWZVgfyoKQFxtdECviWelspwkdxQrwRFMkNNSyEARlSPFR",
		@"AQfifzJAQuFfQxSAPzTqTJnohAaOJWVtijslvRCfhrSoEaabJKqizMvEDrldprZmPOoJmbERNstJEFfGixjbxRjhIvLGJiwIIWxSsBsmgRJxgznJZLxBxjLqnMWz",
		@"ybDDxfkqbRvMYwVdvNldmASAcnqKowQJyAthnnlulIqgMSeQFpxnRmpqkeeDRKWvIFRerFrQyhjMUJEpevKylutEGjAqzsiJjwGKXeYczowUPL",
		@"xjgZJHlmHMIYwmwwAtEEPStnFmXmKJdGsRgTlNGrfYeTOkfKAsDhEQJtpNTLMUHBYeTGHLaAeCCFPhmpJrBMRPpQQfwnzAfJRsZYkNhAtWTIjvZmHMTpylkjDUYsivGuFUDMKOGYMP",
		@"RMcwUWddzoPlyYIEpkGYFmawYHpjjvQwLfSUVBArzqsRhiwjkVXZiRyqZCGlTcFQNpQgsZbDqgtIKGMuotWhNRqOshpIGWjcFhuOmrjoGxumYkE",
		@"wHQQXZluWlnnvKwVWFmCFUInIPJBQAHaSveaTlYObrqvWkENDPgujszBtAVrTthUBKKQWJbGoCyQGCmTRLybNelPwyqonesAhOFuNuVvgMHyvymFxbtTgEkNKqx",
		@"qcSuoiSWqSmLxBCbSAoXtGLtqkERQvdnckxKgOmdqDBAsINLeuiRFJXXNWvNVCxpqBnFOjKbPzbyJfFRZuchTBqrpfyrAAsWHuCVNLmoTuAKSljySyfAFl",
		@"rXBxLmevxUnlvqtQsJMAgDRffzclRJkPWFJszPjRnNGFpaRVAcluSypldJjZdAkmegfwbPOVhwIljnoXQOqdSJOedLILisTipDULejKysFBahPRUyMgjgSamriHwwFsIuEWyUMRJtaSPFEFjpEk",
		@"zvpcjOsmEFgZEgOJVVLCAIkOZsIzvzuBPxqfNtEsqoirrPYRApQHfZkMxpCnimfcfAyhfCJpUTksTZZnVgjsHqmfaYonomyZaozIPFXQHzOlSokcOUhaJRN",
		@"YuUnSxjFFuplEbAMTYcZWoODyCHJFNJDgszegmFEcaWfYfdzHReRZTNIMbbzOKBcqAKpWauOnCtqwvZeYNwXrsCdGSFSsxXysnWALKZKroxRyNhzPoiPOkIgaUoIOiTiNyxVereUNuezExV",
	];
	return mOAGvuHFQXnISIr;
}

- (nonnull NSData *)frCyYJWPDCN :(nonnull NSData *)PTbjckusyIeNQVnW :(nonnull NSArray *)qkQGhCNKeiYrkOH {
	NSData *ZyzpoBVveYSIzfBoMtU = [@"GpecIfyPOolWIsTynKOvjMBVlHMCHTQnEWsxtuxnTxnnQkNpBbceqoEWMPzBkyqgrpAYAoGnruNudLQoyZYwNrNkLSvfvMhIwiQuvkVlRKGhwaOjSawYPRenDFPDLktpBsSeWcuieKaXPFW" dataUsingEncoding:NSUTF8StringEncoding];
	return ZyzpoBVveYSIzfBoMtU;
}

+ (nonnull UIImage *)XhAgcyjSRrlwr :(nonnull NSString *)ZddmCRTnWsBbewy :(nonnull NSArray *)ssYXLTdAzubzSbC {
	NSData *RgFfisNXNOvXtMh = [@"eefVVXXPYxAEdEXhUHcFuUefzstJbqbjvQMhnStIiwTilbsMPiKUJdxrYPBeHKHimrFtKqkphNfmWMpRfxoznNxxJQBYTjiSlkqVbZKzcLEBscUVTpdDvTdnltFmyfrXFnLORWORZIdfxfqzQ" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *yIWSNrbEtOrjlvwhkfZ = [UIImage imageWithData:RgFfisNXNOvXtMh];
	yIWSNrbEtOrjlvwhkfZ = [UIImage imageNamed:@"xqyGbgwbFMKNzDiVWUTzUfjubYTfXtTZqZRLKrfbEvncJTwQhQYQXSZRSpevWKJSslKAMiogyXAlSjpxTgzULBVWDgdPdQDIwxjLCXDhmyCyn"];
	return yIWSNrbEtOrjlvwhkfZ;
}

- (nonnull NSArray *)ztEvlfOQIbsbTZundRt :(nonnull UIImage *)IfrcZEwlTyg {
	NSArray *WvazQvoWDRlSZyMllE = @[
		@"SqAyEQMzLwmgGiBUnePKSvkgceTSuXCOuBfYeatywvnURLJQDJoCXCkuyzvSsFaJsRSWwHADVWnjPOGnigLQmDLWtIphUxYYJdYsqHqRDNlRDbVMFwl",
		@"eHiDWfodWolUOMDCsSwiUQujDAnObNPtYlxRDubwRlgcecbXQAHpHoCVhBtiDDDTQgZAyNTJPcDYlvftZevndBDZdELRjCeDiuVvdOGtYgfmCwpElPDjlLCPfpEKGqFx",
		@"SwvQpfejVjIcnUHriexMyXgkjguUOlHmRiZeWLKAGsowDPJkVOEUwAOyhnRpOdxhNhtXLSxEQwLxlJYOpNhKjfnHaAApASwoAbhmPWMWHlzfOxlbwPdtCKYRNPIvBTZpg",
		@"barePcZKOQhlArcfOgINUjedLfRcmhjyJGpWdHXkhVWRfhNFCiWYPnrjGrVGQJqqQdvCUeAEkqwwTAPHVPyxArwlvOJElDcMfyaRxuSgPFfWkyIGZaqovavFvzPDKaJPMttzVxFizHtr",
		@"mVDxqcdgFCBVIAUULLfEsnHKLCEuiAPtMlZHTNUKxwWtfRXXRCobiZQpTFamqUewRepGzmsYGGHfGXnxgjjpNpgesYVdyDSybVdkyDuMLCPCqlHFiWmRnYmyaUSrwzQki",
		@"TyrepKWfFLYkTsSFQNDwxJpKdedsTfAYpVFlFkuLoyQcopPiCBfVsYYxvcQqKavMiphPKOnUXLVVaeCTJXdYPcCfhgQIhgGiNLmQucdUBOXKIvgMDmXnoiGYBsIzdCp",
		@"LcrwRxVkvhxZhKrtaxZyqgjbDHnAEHOAXnKupVuCKckdChdSvswKkiYCobKyofFhZCaezHJbwEwWDPNqMeWgnqKFAFwwPWLVIaCYVQpAuQFIqQuyjoIuH",
		@"cjigFEegVzRqXODWhaOHDZjehYPsadyFALlBsqtCQYMmwwzCudmsOXnCfjRLWckYlBbnozQJjTJAqyJIwtkSEwyJHiCjnNQLFNSknMjxXWseACQXnXCNjOoi",
		@"CkeldUndLZkXcIQZBJKpablvSycqZECmnytPyXjqDHfjOlaOkMXUloICVMmMmKlOYjaSWVqsaBLZAkDuSekmsKFmnNrExgkXoOQnpPicXFzSNNTIZRZsgYSMcUkXCvbNFprgyWN",
		@"fMiNFVUtQmvnJQRiPaKXXqkqhbjSnFxyWftFeTuepYZWTSGztFOYWQGUYzfADMpHTAeghUYCOGcgMMAgXuvuBhfwvHBKoHqzbeRYGlkNJdoQDnWUjWGNpI",
		@"nKXKWNhgcrfRosVQRBNUVjrngnUTVTchQoKJTjEJerFViDwMBVnfESlcNyXFOWqZjlSLHWNmvZxGwgfWsiOKGprtbLwpqQPTEyaavWFToJhef",
		@"rCLGZnsUgKAhqMaOAZbypCxzuyqOXensnWYPjsVSgSDIDlVffiIfHMlenhsKLkqGOMDpwEhqnePAZgsUIhhITxPcxakyANwqVKHMSvtaMmdbUQxElTygD",
		@"DPoPEnUrLPZbzAoWPtveRyQnVhTOUxkeeeaaDMIOVglnOfuJLzcCXyHxIiKGSvVoiMXwmijJzhDUfbAuyXaByeIaPjInLRYyHWzlirWFtrtWhDOmiSbNshxDFziOut",
	];
	return WvazQvoWDRlSZyMllE;
}

+ (nonnull UIImage *)RANrGWFYxffYgndyJym :(nonnull NSDictionary *)NMuPmqJsvuEOoiSmEJG :(nonnull UIImage *)UMxIWtEoXt :(nonnull NSString *)VetUmPadwQvXAYU {
	NSData *KtIpTBaCwXCTizMZ = [@"kfNcbqnXqgDxFjiUAXCaBUPYnnlVZdAcUmJhetNbdSAKuGPmokeklgtmeSbRokvAcjsDrkJBgkNnLEmLdPTnujpkLEByNTbTGUseYggxzALITkgPMnFkkRSlJSo" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *gHcnTcNQbhzUpOe = [UIImage imageWithData:KtIpTBaCwXCTizMZ];
	gHcnTcNQbhzUpOe = [UIImage imageNamed:@"exSUojidkTniljaFdgkbsosJlkZglZLnKljJfpLvXdmnySaqrrvJhDTzzFmJOXGwHvujFdrUbOZyJLfwqrrxnJGjeQUrqyFsLqJXWFX"];
	return gHcnTcNQbhzUpOe;
}

- (nonnull NSArray *)EsTZrZuTtFH :(nonnull NSDictionary *)QQWUhjLwzZzDbBh :(nonnull NSDictionary *)WAyBzxzKqENTFsVkH {
	NSArray *aMqWqYrOKFHEH = @[
		@"mquYILQfEorZhsfOAQCgdtHxWyGoaMKiSbhOSEqKvIHncQVbYiVWVuqbhDrZHxmtVUNlYKRfmpVIvCJafnXRkXkiSgrzgexWukgLyeFzjsfyM",
		@"XValRDtGVnZMKowLXupxLPYyIfDuAXqlbNsPYTHPDpqhJldzDqRurVuGvMskGTzsFusnEbsgIoHFAtMalEkqepzTgSFcCSamXiaBKzELyFtwyIULhwucXBwbWMmiiJcx",
		@"ieoKQMykFnhESuOTJkYWuQBoSeypCLkXTXVSUQEzehFZQtBHeaykZufNIiCLMDlCZjAIHGZZEHjdLcReXsOwCTafLUWftdPDFSHfNwsyuSHEBGfBKPNoNuXGAzDQRJfYqCrrBebDLMyjKyK",
		@"vuQpDGxxjOjKIFmjJEBsPEiVPJWRDgggyIWSJhmfQhnNQtcFeVrunhaNqVnWoIuzbKyNgmnqBWLRzNBUwubVkqFsbfZvmxiTMeZyqteRVLveKBPUMyvakzuVqwVCNATdrYVoOTdEabEyeLJkKPljE",
		@"NDVSHPzDCuSfUJyUnxDJcsCrLVMUOBhHtkwOkZrdcdxZftHJatpGrzeTcXWRzZgvSFlTeXrwLZvbJgwxDLUcgCAuzMJRKbSnHLchEkKOzggxL",
		@"XBCcuQxuTuNaebDzoFWUQsVkODOGZhLKqzWzhprQXMKMVvgZnLyYVfwyovrbQlrdrqydrDcLdIurCfemuynnzDqrMGokIwWTiQCMUEoHaOFIAidmyQPKOksIJq",
		@"HmkQpLNoHrnZDurKHLPeOUxPmQKZLgtiiLWyAXOmOBOxTnLYzQzesHYHZVTgpmgSUOGyYoeieTzYQlvnslOJqOyiFHcpYSdKiyWGIU",
		@"mfRMutamDJndzNsCpoyIXtYtxWCcWAhHjARQdaPhPfWuJpkZAiqjWeyLtxrZXMySTWfJHkzmtcPbBtVIUkNowmfAwRrgtOTVhljJAfLpHZiqUmZGAkGzWjbVddKSxHXomFjxmt",
		@"KgaVMhhrbVPPPrChXrmKvRvvACTSfFGnuqJGvTJrcELdlAKUQZKyFqLAmCoznMdxhPiFzMBXyPPRyCAnnpzOEXkSpAgwOfTuczFgdsxyyKYDWVqfcXOeuPcanPnuiqdprnEhaumsmxSSbRnZlo",
		@"octpCRpxQtSOLckALGBxrXQtQhDAtdnJCzpCJYyJCpxDMRejoppBVvgekltKjthRiRRTLXISauwgtJkgvwyOnyglubbFXFAaoDOvciziSFbbwDJmbiBDGHcniyvtWsMCmvZfkMQKvhaBgRmI",
		@"EWByKpxifiQVGfqyNcfxyMhYzybnyArmhRGIPlCwkrzQTloYmtRWtjVmKHjMCFPpYhYMddteUJahnqCwJnmfYoNZZKmncsHDWzjlqPRCBoMi",
		@"kqwdsXsJxhaPGBGwtkGvkjVQwFaTuriADkdlJvbaiTMZsDgeRGSkXRznIDVJuRWVvttglYsgXVSHVznabLwxFOAcdJKhwEjEpbRIgMuAudDqVrGLGMFgrf",
		@"psfuUftxRdoZBzmdlcPObdMuCqPUxWuPVeCiTRFDYUTeOOvCQSSuBFmtAlQcMSPCzCbtlRmNhYKwDAgVlNhMncVlclNPsaIfDitwMSvEaOsgyyTQbmrbvgiAkhXAIKNhUgIbNwujIUvSDiQyWD",
	];
	return aMqWqYrOKFHEH;
}

+ (nonnull NSDictionary *)LrAjMgVsbtuiZjk :(nonnull UIImage *)HdtBriRGCfRkAbaL {
	NSDictionary *LobVOMXikJx = @{
		@"uoLTszhwLq": @"lIknYxVhYcLMHgHJgCHTLtCvUWCOptneHxZcaNuGQCswpLolRqhZNkjeNVgZYnnJXGeCWRHZEshuppZaORCRnRcksMogPenRLpLGsggQJxwvcclXkmroABOCBDRUpzpsslqzuypRvirFAttvje",
		@"EDZoLBPWVGLZC": @"mCIUgLzjumeFUCwaVUgaUmdKsXqTtwerxgLuuNhwfYbHPgSosUNNsnpNbDsRYdjtgAmgxCIKcRSCyqRdUGlUORWKJRUcryTiApaOioqVXaRazmNNuF",
		@"RTbUvDuskfIMU": @"FlmhULHKbgBWrgKsNAJgkcbqhIxPCcnNTSHultsBKMZNJAPkvKWdgaylEhqNdzFtwFJgYhIofgeHvUEbJasPnCWyDKwDaIkdPwAvrDA",
		@"bMcLqVmdrwyveTlMOqv": @"jtLkzWLzmLIUcWUSJUymAhqmbTCOZzYcpYaTjlTcRDfDiShHIKvJCwshxfdCncGPdgKyCVgVMeOWFBxXBSOHLTEGynWPPWctXCyVIkxmEEZv",
		@"cjiSnjKggMR": @"ItyIIvYdKIMGncnWNXtbXPXrGkZgrzCmHDXTVYfITDCekqkupZwuGpWAcRUjncEiKLAozHOVDqyPTrZhCMnceOvNtbfjiiPUwQfSHfJalcHFUYxjDAjFRlXhGTnJgnlahPjeckHNGkzuKyKpA",
		@"iLpmVRvGPhyGt": @"caLYHCCIzeHaXdwymYTAYNosCASYDQkhCamSLrpquJLBFXYsCczFCKYfRhTBHobZckMeTGThqWhyEukSXblbzSkyfakxcvIllMbMRRPDrKCpEPemZNWGXPOttlcXuEoRYUxa",
		@"oyhCsYEcyYjqN": @"ikmZNieTRIAlHIDoznyhazzZnwPoyWLYGcZoyVeoLAFRQDLrAfdRoUUrCNUCIMMHQblFuMdxuPUQQFGdiLHlLRRuZjYRPQhxtLIYoRVDBDUOWJZcgDrNtvhIrljiM",
		@"ajZQjDZThjviiCMFtFW": @"ovUwEOSRyrxYJPFRhKCxYTazLkrvjqCuHDSDSZMYRJLpbyGeJbNzRGcjAZDWFoPabqHfOCJHxKnAxWzwjrxqfQlplSelsDzPcFGij",
		@"CLzkFRCAJclTQaj": @"FdNzFnBlMKYZqZuaipZRsaeQUDlkmbbbXExFHuOHGzhPmDQBwRuuCJKHyzpVOROoHcbsGFoYdnJJAgIkBmzwOmvebcILGrLHbvDDcPJcyZpLaDRjhdJSgGdFIjtWNK",
		@"ynLRgYrQXDnhebQ": @"dgLnNuwjvHdRxutbBCdHxqikCItFgWXNQCJcGZsQrDsjXVyvNgcxtMlMyaNJRPGrXLxZVMbRFuAriqZfHmOYMPxwQEaffyoMTlYRUjVpXrLveyaOgymbovnXxPEfbBeJWvdFDXqboKc",
		@"SKJaviGRoIeyPIaZQt": @"NTFDjVZDtvEDPUAAlKnGLNNiFyzynSIfhHzBOWnQaZkTaLxrWLbAvturFpdshCNEPxPdxbbgWzPmFGPIPODjxUQbqkXtbZdSXPaiBquLZIADrPlUTEJXBumAyGTXXhNGEhE",
		@"jnrxlgstlCagKenURG": @"prVIRAVJpXkgsToHnraNyWjfqHYmJjNvqWWTnmqRbUzSjEctsesWqGFizYYVsYdTfHLmrkDzDtJHdFtXypxPKVwvrotsOnpxKMKdPIGpnrWrQsPIcihkamzDGPe",
		@"gzgQUqoFuiPGqfWQUkR": @"mgMiXgEqxGXkqVHjFpOFzDdVzwjhslxbfzjhuqaBkKJPZcFtUoundsKIRSqEhDDzJuwOfiXQnWTpPyKRyfdKotokaHEKvAvTXOpfBbiiBWBjmevAmlYBjsATLMdRe",
		@"rVihGvtUeIXnDOl": @"CUVMgCyFEWGEoRyappIrhRYslRzPHmbWcmbwwNRbkLHfDpLYxkHmxzyhwHCpQSFaLnWehoUbZWwsiKLWUFBTYiYFDWGsXYUPRGrdlCh",
		@"waJBvSjiMYwzAZA": @"oCJQBaMGNiHGECCVBzBcAXxBJSOIfYjcZJXRowEbtyxFHHvEYtEtMzvOyQoPabrjqohsUvkruffRHlUrWmjacaeuzmQuowuFBZZDtxvuYnViRdTRxVlKrVcaYFuVgGVyXcpsJnyDCvMGwkPky",
		@"UexyAfZwDufde": @"XJtuTeBRyalRKLAILbwaigMSdbAoIRlwEOwmyKCfUHWjXvaNfsuapUSjWwIzljYNisOLCybhGpduAldyUShNjgXheYBncxLIMjaTzOLrJhqacRNLPCdJbkwIcyFIqeB",
	};
	return LobVOMXikJx;
}

- (nonnull NSDictionary *)baMPPaHoYCw :(nonnull NSString *)PITUowgbmRpcbJHjcJp :(nonnull UIImage *)gfVhwxPsMKfvg :(nonnull NSString *)CaQKwjJjWXPhfBlOZfP {
	NSDictionary *REXfdFdHEzdwcRwnq = @{
		@"VtsOUmZlrawMHVgOJly": @"qhYzZZQMFwLnOAWKPUmhqhoYSyxvusvMGXULIAJRBLuuUktylyknotcAjNgRgxNrYpjndgVWioiDnyfRpaHRsGRmTkgcDYzwxHZBtykmrybEjCaLoGMOJnZtaleGLZrPy",
		@"zihFjexWFrwAUppS": @"MAjVykvBpPztUkikCvIbJyTGDTrghNNFhPtuoGGcZAmjaPdVtyBRGLlJUWmTWtSEMHfRJDFAFmAKyIHyhSHMFEYCenceehrUcgwRquufQAbVbTuifK",
		@"tFXDmySnjDrG": @"kbaMSbdkiFQcURYmcThuMHMkhyndCYUqkZXAIOqjEdTlKZbVTkHNCDbImmEQeReFGiCYtMzXtkbUosNnfVDYzfhDdUfjRoRGaXyorevPihwUYcPUOv",
		@"OGFLIypUlAZBka": @"ycBoFpVEuPCrQNuJaxDUzwFjQgygpatdicshlLLODqRxLsGXMrtFdnsVQSdlNpidUHMfgvpXeZvZRZfaklNhNTEvKsupJztrFshpFMXvZaxGlmU",
		@"jfscEsstwbvOdy": @"ElLYMmlqMZqCgyPISarHkXlLQKTvcJcCLauRTpTqQqoDdixEkxedyeyDiUXPHxmVfqdvJnQiVTqsVyspQOZIdmkoqqcvwbXCeXqvMqdTdLPbJDeeYb",
		@"QJMfVJbsTxSj": @"fyGaPGZoLAetqFAalWrRPwAyZIncTNLXGJfThPbomjRbyOhzbTTKPJMVtGYlJJTfGudyTQbUsUnXNhSFMlrpvcSVeyvATjGEEyKrkvydggpdltnfENUiovdNgfhHzv",
		@"ixyOggctNdz": @"noLFEEeAfTwbhZuLNjNGMJphMiBBCjBncVsGzdkyNGvpTfXjkzxTwvtYMJMoLXqIqLDEVBTGQbWCUqakeXHgZVFYfpNkwWtNfaUHvHXJmjVwKDCZnAqXlVlZYLAFzqWklEeEiGOf",
		@"GgAhUYEgNDfvS": @"BxJUCwYxkNgzajIWoujBmElxtswTTVnwWwUyYmdptWZeNJtyltyaPEQYoaXqVjYdmtjouOpsLBIQgOvWHCnBSMXtXbudsOAwnhSLqUrCiQpZfjxrnMRWkXRqIlpMCgKzlxI",
		@"kbdsQgcEtHQqZuRGMN": @"RTMilsiRvBWOPyepstGsVrCjEAzaKcEyUfyeMZuBgScMpZuPiPEhGCdaltqubfGrRPWfIZkwRqVAxFZNeyqEFuIeNgdEIorGbwEpiDryBvLEH",
		@"YtHfYjQgFJEJni": @"OccyyhmgOUzPMVqWDAKudUAZdatTyigqJMHRGXrFxQhQrHcNTGmspDabvHtoLxgIgxVBsTkuFkTPSUTbtBHezxGFbiDjfJhnGLCKgnMnYLJH",
		@"cneqOMOrvtpQOwwSEt": @"PmPZOqenhiuzGsTpTQeznOrHnQPPXnfYrDCskjOCkExbsHNhBiTsaJdcUCLLCmjfPDObQmOdNKCpWIOfuLUPyUpopDpDBOUrbnghspgM",
		@"VqipSrOJtEPUenb": @"eNrLnvvKzwBdSfphQQwdxqzGwzKkRsDxKKZpmjSgKOQBkQwCjjXZKfeBEHLKsOdJMwsonomYSgdPKtjsVelDpWQMnsJPEwwZdLyDbjYsaKPcqAPKDQoVVpLDqh",
		@"VyJCtzgGeaXUiQIYjuu": @"rlHLTAmBwZWYYlUgkSzmkjvyfPOrmZDiEnLzjlgqbqsqHywFpzddwvkWqurzFXYNozapFNBHUjXToTmGRANnQrRHXTeeyxWHDqoCyuGgUDHHdzbtuEAxaeBJatTmqclaWwi",
		@"PSRVgNINrpl": @"FDsPCYUGHnVstZrhvOQUsqwDVktviYffeikKIKibInHwwwGjkwQqLBbZLLUCudgjzepQHPvefwHuhLpLMXsHjNHSLMBkqZzzqmfYgxWDRIZeeXCQUROpZqeXlbSHrGlyNfcdiCQiAgyLwMVojX",
	};
	return REXfdFdHEzdwcRwnq;
}

- (nonnull UIImage *)olRTbegaDALpqzDZ :(nonnull NSData *)XKSRJnwwpGb {
	NSData *UKTBXCxSNAXScbPMxZG = [@"WvVTrUgdqeyTcMFAMqLAvldeBFBucNDaPgVhFTAgfhbqVzmeKykaXTizciUYGxcorxHmPUyZHiREFSPshuCPHLcmZxQPaJrLhtgURgNh" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *jiEtBvWrsBpfdAJU = [UIImage imageWithData:UKTBXCxSNAXScbPMxZG];
	jiEtBvWrsBpfdAJU = [UIImage imageNamed:@"WaiSdGrfeBqIFNRizNzAMmpaWbsXVuBOdYYARTpOHDexnXhOCqAqjTlvqSFWxFSBmPBShXsRXYbtCRelVBKSQuwNBkxXpvQTSFWdZSzGXGoua"];
	return jiEtBvWrsBpfdAJU;
}

+ (nonnull NSData *)sChEdMLjlH :(nonnull NSArray *)WqpItgeklnOEg :(nonnull NSDictionary *)vhMReAbQDvJxTX {
	NSData *vlxBZgpEJPwJUuVAVo = [@"XZyMesnuUarBztXpCbgcisJOVAXawVbTLSixpRDrgLxwrUGCvwngoaUXAWwzljVecfhlYcrJQAfRqcrfDqbutzceTLvyiMFcSJIZjHTEqRvoHhvGriJnxvicPROMvenaPOma" dataUsingEncoding:NSUTF8StringEncoding];
	return vlxBZgpEJPwJUuVAVo;
}

+ (nonnull UIImage *)FSnMRsHeRWEf :(nonnull UIImage *)aIMJgEMWpVQhYinxn :(nonnull NSString *)TvfXGacShEmtFL {
	NSData *fmVzJKlSQnfsT = [@"ajtmuLyMYoNgsvZOHpOgXCdnXGuvQUnVSpjMRpBnnFgqctjusHlXxijbiotthSobFmVxPuzMaLWLwZRoyFkhFXZwnSywDBDNOiAjwtcTlbJSRiVHIHYOMtCHzunEs" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *GFFgevPIlWlE = [UIImage imageWithData:fmVzJKlSQnfsT];
	GFFgevPIlWlE = [UIImage imageNamed:@"MhtoyhZFPQfHnYjOkJSJoeKnOcvhVAoaBSIdCTvupZRaHOpZoeSjfGrolDTeVaRmOWeUjThIvJEENbqOYVXTIvvniNdhoIpkXyiqrbVExZNIfrTlXA"];
	return GFFgevPIlWlE;
}

+ (nonnull NSDictionary *)itSCWbfLVRSzlT :(nonnull NSDictionary *)oitAUrMnMQlO :(nonnull NSString *)hCnNPzXRtYpp {
	NSDictionary *xJGDVPGOWoR = @{
		@"cJMaTpyUuj": @"EfUzIimispRtDmYVgXcRInaaBkOjdDAzTbCxpCypkCjORJxWbZwBkTmrQVTfikjcoeGdhjZjPlWGbYMxWIIDziDNOegkutMZudNhcyjuhhEttgAuXrpFsswXdoGCa",
		@"ZNogRxWPRjZhaJFx": @"iUvOapmJYKLvjnuUrqPhQqHwIduWxBNnRWZdWAUdWmpbRCHCuirwFblprjhVbomBWziccgcVonLzABZLiCPoOBUpROEETSjKiFBzfzrmlXQSfpxhlZRfBOQhdJHhxnYeIsyDSKFNNUnSeV",
		@"VBjcVSWiAiTgmnQcQ": @"XBvGoTbFMZXkKkxdsnZuNCnqLRMfwMrYGzJWdeZJLMsUQWIxKkJXQPeTeCgroaoMnxhGDaCgiLWpejtkYrcqFATicNbcTFlRNqkFEkowBLIjmBZdqihYRbiZjqcExuixpIMCrWSa",
		@"jakHCKZxSlYGMuUZX": @"fONOBfgqAUKiWsGthKpdMsZUybHZuqMlvgquDeyMPnWvGZmYPPMQAFgadjwqoBqgdcvNznuHIeXeYYaARfErjtQREHBJtVRXFspBLeSEKxVbcoHgc",
		@"ryMRHIUGQX": @"SSNycZZHuvAhQDQatLJukaQFCOwVPxknRleBSvNKZVmlOLJyHeeJELKdQWzVLfUqGjTcYWDlUjhgvuApBrgensLlMYzDIqVoJtiLoUqlqHQhTkpJTFvRaxOtXDBWHuzaPaWXULLgL",
		@"nOGgcNGnbufOhWd": @"BzMyXQQBlgoBGWKIoTZPPmvmpRFURfuYlzWuPFXsfdlwLfTaTlOWcbgVacDuBWSgTUOYPBKscOerOppzLzzIibVByEWXfoRfFnBzaA",
		@"kiwMvzSkAxlTduxVfa": @"FBBIEhCbgnwdTqyGoEZZUnbkhYCpyWVheWXrmAbUQLWuGJZhLaOnpIDdOwKwTcfjSeYanmzZCihBHMpQqbTPCHiNklyNOvLjbuVzXSrqG",
		@"qDcoDnONJM": @"dIllYtKaIvtknQfEXDXuPJiYRweNQTkitvNmWlOLyKzuydDgLWCnQcASwLTbfxdmXftFosqCEcuIfuUhmvYjCJrUNHcWsXlvxdGZiPLPvpMTNsuxxZfIJnWNUxOg",
		@"cguopxBWVFtim": @"oNlybveHOlFmuxhldBPeJrltecFyNIqrVwsWQQDHgPlkiPQeVCgMMwAisoaOGfYFyUlCEDcyEraDbNqIsVoNVNQxqqRgZOlmyGKQyfkQ",
		@"ItmRXyOQsG": @"FwLRFQJNZcCLRaehSDbMWpVAgAauFpcBjmMUatgbHDDFghCwOyoDSFVtrEEpXEWIGOMDqAAxwMWdLPECuOxbjROkvmpUqYNZasvpn",
		@"YsCXTUaKymffwrDf": @"eNJfyGTVnbWjLiJUWOYkFBTXnrqphVznnrFDvrTUorFtLvLwAyqsWsLXqFnFIPhPgWRciyVOyeiYDPSlyDtfeRFJwZfLHSjXFCkSyREwGgQZPmbjqDkzYljRtlaoimDjijhKB",
		@"orHFNdDPijbXIRqcC": @"QZgtglTZgJdYkQiludHBIUIfqGvtFeyUkkcuJGCaXlhdODwTLnjagSJTvjeBwkOmnfwtyazzXQtbYJDUxdxiIivSmFBiwokoExOseGEBGrnRWWVsJWRlYinSNEAorSXCIQZKZGyPE",
		@"mPFGYoIOwlnfGF": @"HwdLetRnnmdIXgrzcvBUZqswIxVCKerPdqempfifHuAGjVrGUnVWHjQtxdpAJekkDDRkulAeAhOIEVTPGyxvIGCUUcLovTghkRDn",
		@"ekySawYGCABXDpwGV": @"tsytMKaODyfXpnZjRaNAhZJvuVQafqVLJkavXaJUwPwAupMUxwZPZILVICtEszuQsqsjqCCGStcKjkGdAUkGykfszpyyNvHGGuzyIZkiZfRM",
		@"TFMdAVmQBwuGE": @"TcVqpshpBSdruXpruIieNKiMFUPpQopfhgQayCctiRGPkypPQydlLYjLOksCeNIVOZQvospLEOhsbvNvdfgLMLwOHlvHKemLsbvbAJKZneZuSWFLHqQXwsspzBBKhDQqT",
		@"jSAHPFRdQjVwWxmhGj": @"gogWrQhlryPmhDHHSmfUaSVxpjrfICmVbnJykENfoRZSIwrIwwORaISEKWVbfvZsyPNUNOxPiyOvNmYDTrhEhYvhgjPFnYKCklAdhujIIdPFBrjpEFaNvMmo",
		@"HedMWzNNamEhplw": @"FKFohTRqnVIknofCkahAoFdqBHFJpCkZpUVaqFYZYcFavcytIcDjNMUuDHiVzlqBFogvOARApDmjOuYTPJWwTjifiGILymmieQYbmRwTRNPBxvZQNbGuvFYxXmXEr",
		@"xQKFyIAgNUJfe": @"YJKPVQcWGcMByQHrrFMmoZhhpFAnROLNECgeivlqyhpXcJJLGZOKGtknzyYVBlZlrZSwelIFgfOabOpFOLDacmesrMIUfZwtlVkLXTmK",
		@"rbvzeytBkYibjVUynE": @"fGvOzcCWPazIdtLbXnUGFgHRRFLvdwvsjWHYDRRxWkywaXNpsFaorzqkzWLgGorpJyCppJHgrQdkQvPfMKoIIcOwzJVFxDcaoIXSHYGWtfnCoATdWVThHTauOQnNAEbqvLVubqyMEOxHGqlkqXcaP",
	};
	return xJGDVPGOWoR;
}

- (nonnull NSDictionary *)VSUcKdUNUMf :(nonnull NSDictionary *)smNlEUuWQJBZFWGWa :(nonnull NSArray *)TFUKkdxFtyKZxoLdzDI {
	NSDictionary *mVKzVTiNsurdHpA = @{
		@"ghZBGLuVPrO": @"zYEnMfTYTYFjxYnHsJtYaJGlqkVDbqjgEdBgsBjXXLTQhxcvEhcVnywZzYvIMnaiNenErdLrpiKnCfZxnaRusSrRGdsRvWYAZJDIPKto",
		@"eqRhcOOIVCCthvgR": @"PPVSvIqlOVruSjoDGnjuuiSqCqDqGNSizvbUWXlTBklGHsKhRklHvgZBoHzcofzWTmtVRFwbKgHrxaquoJQfyWUomVLjXHZIRcDMEWldbPnRXytCz",
		@"MyuzQdBmiFHxdMwEPy": @"SNAYsbuRoNwmnSDSnZyJZeLSdtoLhQwGUgkCvUdDhgfUnxxZTBeAnPTTOUFfklUHlFxMTpuhPWCmSjwoSDNvtvOvMqbpczfBxOugTDxe",
		@"GXRjaVfpTuJmrQtk": @"rikQjoFXiecLILOEDvyGVKKIYcoJomgGkTSyYvuWhRrUHGKueJFcylPNENQezualFOZdMkCwchiywywVcmkPOqWIlSEImXMXbdhzYKtaKBqCnpBmtNplEhUEeCHYoIksiixwbVRdRvWEyaTGqjcrE",
		@"UClvgTSxnto": @"nKvBCzezUYKfhuVZgIHAKqcXbzBMrHXslHCNoHMBaVEjOKLBpsfnfGzpmcmxohlEzBbGFxjZpkqhKhYKVCrSMmcLqryhelvcYzXCvtlgiyzKKwiFiL",
		@"NrGWNQJPMCJUT": @"YULJdthKKpIRuWiNbemZCKofofbiceaTAoZifmHJTYkZGAqkwAOMVgUlMLdLNbyKkuvkHFHOLogzVKWCGJBLOFYTWIUviaImFPRnHZKhtHaxfuiPu",
		@"apMXjPjkFlT": @"iLpNxCZJwvMqcsoXDfYqCGwUgliTTfLkMwXErReoaFvjzttgCmNZhOEqcSMqMJPPfNhMwiDbJjcjyefjNdgiXeYAxtScFTcFzsQjjldUKccsSlObEcfVaYTmJEEsAnRrYsNbtChhLkShrPelo",
		@"jPKUcTDkmvhkrFSG": @"UPzdXMtdwaxqPSHfhzoJPiVAwWQqGwqUtwqGZqnfAplVNOcMnFzYKHHcusTbdLRDWSgbXnfFARyKGxAnWdKWdFXAhblWwQvkXyqForGnzxBhiWmCdboZlcaQiPsBaQarZuGlknPQMgEOIwCwl",
		@"rkqnijzjFuuUnC": @"BhkTtgkIWwztbBlCBuPyGoIVvljDNvccWcnpTmXmmZvbABmEGvONCTmHKoiTKFbOwUNoevNHVskTWEscJAjOpGqTfjJNJgpnICIWHmtnoCcvnNGRsVTueitDDaFIo",
		@"jiMFiuJipzC": @"DCmRbXZomBIkrhDtqyNbDlwehaeYCcmJudXsEtwrjBZPOhkeNWERSiPIgVNKcXqLxeitTHGOYzDzRnUtGspYTOvOqZfcGjUpOqhkHdcjVdEQDGJVZtWFcLxYLmvLiBjRKuZRpN",
		@"EHouTRKWnJsk": @"ZHuQmDuVcEXIyTJicHeyaUvSfaaHtrZgHyjmiKrDAmjxeyllLixXPxmqqjWsqhvFXOkVUQQEEsUjMBNKmYzqLOJDCvdjLBwumaHTYOpLfUdJGHsOUyPnoOhEvqELHkEphdfBFRXNjZSKeBNMinJAz",
	};
	return mVKzVTiNsurdHpA;
}

+ (nonnull NSString *)eEemEIUpKT :(nonnull UIImage *)hKMKNGYXVrL {
	NSString *ViGoApkROGBfhMF = @"cWTyJCSTNLFLZerGESNEkyhykSLvKnFSrYdhrsQCTtPHwlikLUCqTNOeLDyxxsIIwwNiQIuJJBXjLiqqAAJSkhjqBLZzKCKxktDKWQGIdgZKKbQtDvDDVRxwuJXGSNfk";
	return ViGoApkROGBfhMF;
}

+ (nonnull UIImage *)kOEeqotqOvVi :(nonnull NSData *)kaXxhTrAUsoFPZdsO :(nonnull NSArray *)ccpWOwtjOlIbmyp :(nonnull NSData *)OShnZHZIctOCBtBuhg {
	NSData *YiElkwLpumhz = [@"JTBkiuNPjIvdnegSLEjJjWOHNidBqOagXNJyTvRwfBwOockMZzjDfwxHQCWMEiKLKGdCPBmyFIdGjNyKeKTBweVBVWtjzEfbPadnDDysOHXilCLprfzQDsL" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *hQeSaCXIeWyrpZFadO = [UIImage imageWithData:YiElkwLpumhz];
	hQeSaCXIeWyrpZFadO = [UIImage imageNamed:@"BhPJBzzupUvtvAeUgdRSHjMVxZXxouljeGPUCpStxPBOZhCvYOcXDRwGAMPmBCpDfYShhJJWZkBCuShSGZksEQWoXTZNAgyqrHcYolHhIWEUxxfGncoIOEwSIuYKaHstQWgfWvTI"];
	return hQeSaCXIeWyrpZFadO;
}

+ (nonnull NSString *)TTwhLQzyTpPkzCb :(nonnull NSArray *)pZGmVeQgBDiqPRzNp :(nonnull NSDictionary *)GfCWncZuHWObc {
	NSString *XUjZXrJSollAM = @"bwTfSIbAHVSpZdKpbxtBHVRRYSSAGVKmRQLmGeJsvtXGHjpomjTPFblPSWHlVcDesPslAwJQbDiyVHinCKGolkhNrAsKoqRFzcnrcPVNstKVTntSCKBFJChBHJXiVMsvpJPMRCLytF";
	return XUjZXrJSollAM;
}

+ (nonnull NSDictionary *)lmcteNCbXvbbuAaD :(nonnull NSArray *)xMXZdXlOnzpCwhXlgA :(nonnull NSString *)HkkNXnynQrCMuYP {
	NSDictionary *KRTTxmkihYVWLBeOQS = @{
		@"WQDqbDTulIj": @"LUzUCmagYyJzbFWUYhkAFyFetTBZrXRJbfZwXSgNTedOSNnMtZgqRlqSFwvzBgyzONiMnlRIedqPeDhqPxtXjawFVQWZjcncyyXQXUdFuElvOolzEkmMNlAKxRhmYkztCTlbsDnpjHRsGCgawrCB",
		@"dTksGsKZnyMcxyISzmC": @"AdXkaveSUYxmVWArWBacqHUOeIFlujcvTbmtlzGfjMGUNalsOSrsKSoZCNyaDceFnttZaRJtFENAwmHqkoMrtgXxfOvlqBrAggiRwBZSZnAFTJhhzHyJbZKeiaXDwyvzCrFauAtcRGWl",
		@"cYNKqntbaDqnRWTmDb": @"rZllJFPQuitjaaJXbLjmiXsRRRZwSVumDPrDTJdIuoBerJHrHsGVRATvKsohKfiXonYHAYQGnWhfGPFUEpjOlLaKDgrhEVbzOnnsklfruVaAqfLqCgEaRerVSlwVlkLfnCJVK",
		@"xIiGxtZZYJISRbHp": @"ZCPNDjasqhNPYkoNwKIfZabgabdRdrHbNaVhTlclLgHusYEsLFtEVYgbWshikhOMKqxNyZeFGhrhbZFBIlkBahfksBXByTCQVTFGYbexoWNLbNvljzMZcEdVjzOdaNJGXEdWL",
		@"LAEcINfYMSCOPLE": @"BqnNfMhXzsocSKWpqqGJCNKOsOLFoOkQdKruByhvSKfzLqsqZjPrfQJuHLlSKkMpWaGrKDmgpKKrkdOzJlFBqqtZxhTgkAaoikMIIKyKJOJVxBXUKrxvjEgLgeUcDxgTxJuJjajtNRc",
		@"wRJtdZfNROMNFuK": @"JebQXtnucAxjUSUKeKsKTWWFuTrXKTQtfbDcjuztBZdSNVcyHLNABNnfGPfLKwHpbjYxAEEoqjLvoMdDuZBGvmCSnCtQiOdKAMQrIktsJDXrYTaGmTWPZsCwCeVI",
		@"xRHWjhNcvmlkzUaFWbi": @"ejAUSHpVlOzKwrRZHHaChzmlHKwOxZEJmrQjyimvMfmrdqXEPDjzlmrtczqhjJCZtDNfNXtpklyUUHMzLClwCHSVIrpqkPsJCPdZbUZHpDDFixaewdMZ",
		@"GpIXpkeFmypTYZpy": @"UYqimWRHMIlRdoXViZJKfpYuPkJfmXYhvGmjBPcMxqRcQGrfDSEzEmLvMuWExRviZFEWPunBitpxGMLTllkCItMQOQsSwhgAUZUyVQhRafNailBHRIpfeOxz",
		@"BcUcnZmpnUjxCCASHD": @"gSNcQkcOUdukWUnbnBrCmReCuyHQOOiKPeiiUzuTGDoFVIGjmjpkyzytYRElEYFDcBjdPWazOgQtKXWFJlziwznJuCTTtTbjUlhaHvfSiUUBDzvbeChSvozQ",
		@"gzEHvUHMRqeTKZtpSxG": @"pHLZXiZHjAJfOPcDZoiWFGaparycppAWMMhPvAmhBlJJcmbluSyFXkqonDELJWSFSOsCXbHsaTOLbxmNQuoYmmjBuDNttmoGVhsKXeIqwCWwmpSBBIDhYCPEYYapdJdtg",
		@"KyWhdQEYnJuz": @"XSlPSKcOvxxjhPbdwBBbpZYdbBLiqkXdAjDeiBGxicZlwTAIgeFBkhmgcgQfPBKUbhjePfFzhZgqKtSRAIoZznlvAhDdHmGYJkZVNOoczjVwbSZZvHxxuAgLuILFkRFLIxrghIaNnoVscW",
		@"qYMirXSehgFIZo": @"LvUegFwSOeRHRlHbNYhesSrarCjwXzlXTHHqGeznhXNVWozBMzQDWLOWHkXLjTDplxqHRMLNqiPAxjIqIgikraYpErGuIFNxtYaiewDryDXRgjsOSy",
		@"OViJVaemxEFzYEH": @"UYBEHJmmifwbBoGFMMmtwDyVMIxtXvhEESPOToVxaieeMEUDgwLEGSuUhhwXKnAnyYTYcKJxVILPBqJOKrbLJtjOMcgANYyZVvvyloyOilpazjOhdoMckhcZVxPxdw",
		@"WtqkSTaqLChDBgY": @"QhexeNLlLHINCeuRMgrFZNwsHsazvGRemPisYplKnBErLSbCoSvHjnEhShMDgioXlKSbaDTfmKsFQAFUEWyIIsDNPNytQmCHxoNajzjEolyXGIbdhQPwiwQJIuSLCdgvFLdCBNSinezIm",
		@"YBKDoPgbhRm": @"XBBLaXLQPYNgJUOxxDdDHWzuQxIejgHKbcXeLPrTGDkeAnBFgCgomeoynPrYTMXRdQEsCeKObEDLFkRMuuMCAtLpyUoulBQJktrzBidz",
		@"iGzAZgpYSq": @"olJRWNLxCBxrOllVrbouguOeKwZjVdAMArwhuaZRUqpCXiLpQqMnqUnDAHujRbHyExtbrEgExckgNPUXmEWxGnqcQFXZUkcajDjJbkCeyMcDahdVPGdHBpohnDXcjYvLiBaqkfcrxPxGMCbG",
		@"oktsozxAbUP": @"ZlbpDzhbONJoVhfVllRFVhUTGHjQKtzEFyEcBgOBkbzekMKpMcInKkuttNqFbJmwvDwwaNKVhIRzIFwJAYjyWAfJKmEKlOxMuqwKyfq",
		@"XWSrrYNhTHm": @"paolDHUxaaQAuIIuguwVCwtdwVpigQqjMuMzibGAGicSgbgVgLSRdKyWprZwGIQXJHcDieNiHnqCKCrIskceWeURUfYwXJUCazhOISYVndnXRtqbenDBtNoKlMSjtZtXtwrM",
		@"XvYzfuMkgb": @"ixzpoeNgnvWKlSurMgzErothqGeDaNwbdFOLMZcpRKhGEMvOhTsfNrJfvmCQnBeAjYzlTavpxnmBUaIxHEXNETfHndCagYowYuXs",
	};
	return KRTTxmkihYVWLBeOQS;
}

- (nonnull NSDictionary *)qfFqvaGzJrYjhNcx :(nonnull NSDictionary *)cbZGgjNRZUQiIJO :(nonnull NSArray *)dLWwFsZDfifPpnlKuPP :(nonnull NSArray *)WxXXrdFcsUEJGtb {
	NSDictionary *DfVnCZNdCvmDHXW = @{
		@"cAXLRQCndbfEjUaJms": @"uPqftBHPIaMtxjjYwiLoQaZIrVbNczUAngHbXFPgYNWoMSTxidbsapGPHiNKnCHsVcxzlYcGEaUPIrmjjvJErUTJXsvsBXRhufmGBSElGvxTpWYEeAEFplbSAXbytVRlwVnZrKYC",
		@"MfkvcLCaDWQiBxz": @"vaCKrwkrVjYHKyVsmJYgmlukLgGlnKJutUGaleMglVjJISzMBjxPtmogARjByWMkIqIhgsnWnfxbtnrfOxzJxhScuWEyuCRyHNAOLrHlBopeTsZtgRoIuOwrtDxeaysSBIFuKAaIwNMzmKNDHnNq",
		@"ODKGcUUBzHSjLRN": @"UMoUAgFPpFOiTIhvwRdZycLsxoEAKnWSxynAzrmpOwXNRlSsFQBCTsdSIPJUqkIrErCcvhKmeIFXDfYHMcqCAdaTbcKNRdatKtGyeJaIezYblPjtIuHVcwPjtROqDwEuygRPqZ",
		@"cWbCdNFyhyGsMj": @"wcFXXYQgnnVZZfTHxpTqOuQvTJBGWYGJOpUHJHifRGLUDcJQhVDRnVFdwJLsCCGvPCbwSZwWXAYEOaeMRdxoDkmMRqggEoGIvpDTQEWUuUzurmdmqpyjyBswqTGFgGnrTqknkCQXa",
		@"nenYvIpYfxZQOXn": @"RbTHwsgxKjGakOJqGqenDRTyFbQPGrxFPpYkowJeZYKdUYFnIUffFnsuMRknpWzXZoDcwDzwKHfOzWhDwVTvCrDyPkRsnzbulxJkHBNxkpe",
		@"BXHZnpQUOfnrFwcCDt": @"dQPXMIbsgdycjuIktxnFTvhREewvMpZGvyFzdxDtnNkaOtlyZFVluQWkMorgrhkFCugzMvYqeINHeZEIjjZAEcTbzieNTUjvLSkTpJeUcJVqiXYhxeQifTH",
		@"ejSwKYirVOLebq": @"sSOcbSDbmvvnvFpJSRcxtcLQfBoeQhvIXpkiQZOBAahrwZqkMchWXpuWQHxykQSkRAYUCSxXQztinOGcNOJUnPUUFMOcDIyJfKRlJWYuhFopwwBeYI",
		@"eImUQTAwtv": @"SuPzYbGEMtFCeCwgwfvEhdebzPuraKcdEwjWUvYhDAfRQybBifchvYMmBpoNxmNFwAujHCmbEIzIoTitIrQfgGURTHErQCJqPMFkUfSpxPVHPhAkdlshZDGqWHbtaxiQYNr",
		@"XgzvaURCHDjTlr": @"EVXELHiXQvsyGSjmZvRAOahHmNecpPMMXGDQTaXRhrmoXXxgMUDbIxpuEtcbfgsVGwsTdEJbmIuUxqWbBBFTRyoImkumpoyLetuCeZNPDZKvNXawXbqTPCbYKYJujDJ",
		@"wmnblKAcemcyba": @"iTpAxspSfMCXXwaugrfJSgXKGqDoIHZQGuZLeaBRUvPjiytzJgCxBQTnggIUKbSaaHUOWjzPgTpXVkHMHbUzGOaSVUexRnoXrqtEcXuszPESeTpcmsyIfNHGqozPwa",
		@"XETBMzERAgHwChzuN": @"aAdkaIfxGFJPmkbpXnEKhZsJOTUsKRgteNDdigHIiqipytBNRhJfAmqaBjzJnptYTnSGiUmCPKkfgvyeWjQHzYqGokPDphurNpyAwTRkJRiPmKKtXXWqz",
		@"dQCCwMHqAXiJoJ": @"xsblGGxyvLWwDYjdngmeXzWwbzxMUMpLjtCrUHsbAYZchpyXdvTntJcQnqCOdtReJyOVYfGtVqhDlVUStraPoZfrhjJuHsKawvlVMobBOGnJinNGDNQymYYGabwokyYkHmjVaHhexLnlUKYVmv",
		@"DAJeJcyjfbQHzafEA": @"iKhtYIIqodGFJcYYmzZkjfYyFRJmGqwbgcdBpbgOIpHNcdvFvqrdXPGhjorQSIBdojBJwmExlPzwOqnrkfNDuPglQjfSYYFqGkPbBdJX",
		@"HgXXQcElAhCGVe": @"KKEUebhXugyOsWeXKKSqPwTuGRmSbIUBaOsjjnNgpjSZJrZOAtSQVIMTJvvKSZdSRaWBceJPPQJMWGwmwlHlzZCPggTnuqInFSmDFSnWWIeflzYRnLWzKvsJEDohCmUcqkuyI",
		@"ThJaFUwfNbucpNFE": @"rugNaQBgDDPdxzKcgVgiMDZWDWnGxzQNmRMfacioOfqReYWBJFwKjCagcrRXqQqxDhOmLFDQlCbcEGlPUxSmCJVcxAkEfVuZNVoSXmnfYBVWqT",
		@"VBkADrAqCrigM": @"YiGyZkvGSBdsfCkikCuuULkCInuYJXsRcxikzyMFSCYLLfsDrGRwJTVfzMOtqETjmiPvoumoZDgpuLwItNLjFiXPuQGGffWsRFoGTxtsuyGIDaorNZtnppl",
	};
	return DfVnCZNdCvmDHXW;
}

- (nonnull NSData *)DtdWfokLqc :(nonnull NSString *)wvwQQkohWRTOJ :(nonnull UIImage *)CotlIvgNqmNj :(nonnull NSString *)YDhrrnGUlJfDoNRjlO {
	NSData *UVIjOogqLWjMxKK = [@"mAxyjcCKIcQfWovtHcQFwULImeuDCxSVCczfIiPmjKlRHmSagAycvRHeJWyldrEeQXYQeLflNEhRlAQxBdalYYRfSBNuGimNEEaTHyngbkVxLigGHPnoxbOlZCivuoPOvcXfU" dataUsingEncoding:NSUTF8StringEncoding];
	return UVIjOogqLWjMxKK;
}

- (nonnull NSArray *)JroAWKmiMOmJMzp :(nonnull NSString *)rDXTcERYYWeeTY {
	NSArray *IREnyQMcwFwwQGf = @[
		@"QarGrtrtsfNlFgBEyVkCfLWJqmkLwnPblPkNIHHHiokCHbUyLRwQyVNadGZgDyyqZbsUvrXxjQTzSeOhhPFwFohACuoUkBglgYQbfYyUpReKxwNcJhQQsjqCyDIuSEpHEIcusDrBWOHaSQzlmp",
		@"ptzURnJehQnzBGfFGXONLcAVZRBHHvuKYiVVpYvtsXyYxxSCskNhiOqsuEkvQzBarvfMxuxlzrWtVXhlSEziyFxCKAZEQxzeuRmkLCqYJklOqkSEciuCHsEFkfyWzPcuODLvYsPoeUpGdZDgrV",
		@"uuycNnnSaKIwtzBPlJACeBNRYALHMIbUHVcRbXhktVrqxGktVNXKyKmrliABFgtCeHfimexhxGzVebHRHkAGbMhLteENqddgArtIQcsNyoqrgxlQKOxqNirtc",
		@"urJCRCUxkGPeMzizJcmxzgUfVYSEsYqKqoULqoRHVElndHdVpugJgksEvfRWBnVvnkyYZczWIuhzYQwpVOocmJzJbStWtSkzaxknKCtcFVUopGjQyLKHPkqyODmkmYpkVvKxghTx",
		@"fMcTGQtUnbvAsNvEeiugBVjEjrSiRGXvRkEIQcvZsNesszAVRYXVwANxjlskioRNyjWkFXesOorlNwZXjkzMTZsdcLsSVtlWjglimTIXxIIhTTyjOjeYRlAjfkRiMKzIP",
		@"aefsThwknpWoxCwLlcIXiIBfeMGIvdmmTytDmmEdmuJzNbNpDEUEOXXrktxBjvUkOiXHuNTBtNvcqgvMIFFFKivIqRkLatzLPwqzMYeDcpDkIinKfYQY",
		@"SAYjnYvkNntulbpJWCXfodnYHaFbCoSmktVJKalglYWvkxtMxjlTFoFHxtCKiWkTUCYtcmrTZQmsyNPLnrLWEHCITvzoMGIKJtyivzbIhGcVXnPGGYIEYxZlJwqbrnDpDE",
		@"bCcldLpTctgMOWxvxbQXuyAjDqauqSwWiNYYUzWbxVZZwwZEUOvTlDhVXmXJWAfMbkJuxUgXXPGVDJwvMViWFalUfYiCJBuznWtKjZZjdZixSqeYDUlmF",
		@"kcJuwrBoMXMLmUkWBimehnKkhULAbXNhVFSlijVFWnTOavhhQEYJWfboYMDdzZnAsjRbwybfsXimlwTpmFLqHDByektbXVDNYZDcsIMjxkDKNUXLyUg",
		@"GelZpccppQdawDNlZszdyIeJypnzKkLgmguKJTyiUQajVBgeYUEHxRppOtVVaNSECimxJnxnoecdKxQZrpdfbsoENFhRBfGypGYTRdrHXrnIFSfsOpWBrFLPkGKUVKSUNbxeiarACEZprCkA",
		@"XWvDtIYWXUuDwzBKYXbQstFWHWDttVOAMMQReRKIirAxaIXmMuFoqXZPfONSAIPgvKHhUspdMFEcUWFKoMawaEFBxRjtcdeNlclaKpcWlsgvvHsXQilwLqCtaQi",
		@"jkwFknaOKVQlotEXfeRpQfaQhJhKkubNRgBLbFUrwAQhqyAyrNytTRuLzBeMvbndskxLxNfFXQuIEKbgORUvWxeKpUkizunOQhkLZuUMOqNAEXTYBZBWAD",
	];
	return IREnyQMcwFwwQGf;
}

+ (nonnull NSDictionary *)SlOcfPjjSZ :(nonnull NSDictionary *)ehuMiVDTHEkQcLKFFq :(nonnull NSArray *)NYAnHNNDLtsjGktDuB {
	NSDictionary *iBMILSmwjUfCB = @{
		@"wlKxgNvneBPfHsRAHT": @"ULPfscfYRCEuotuuNIRtCCdQvEQbRdKJzHEFQVyJeqjmPSvbPCgSAoIEZnRwmlQhlmGjPknDqmeiaAbgVaAlogevDpLXILzEzhbvfMDt",
		@"xrbSgvyFKgUOb": @"tkJIPOZFhqXBWpyAQFouozJTlpsyQzVeqmfTzLZVnoeVTnzmcIHMbiXwEnuaPiAYLpUyAxHhtBTgBJwBKVQdUyguEMQwzBDRpCtcPgkgEiqdlhURXiOUBRpWVnFcIvrWGzNwKmtuuE",
		@"LmOeDgVFwO": @"PbdQnFlrUHyWKFgrXcjIGpVwHdOeyhPwemjlqQsLjgaLjYFUlitHOCxzBrlpqeGrOwdnQOPwUFCJbqUxxwIUqkvGIryRmyOfHtrnZDMizFxjdBrnmECpWg",
		@"bUXlOmgKSfXcts": @"SxYafWvwlVGqBZmCRDVLBdBwygWmnpQFUsvKCKVlKEkBVCCJYRiQPXzXgRePkKutIKnDAPuKHYlvzrogEvyDAVFiwBziBJkWMUfzuLVTegKm",
		@"fsEVCBSUKwB": @"RwtELavVIdpEoeFlMPFQzitDzeuVfuSEYUKvkByowGixWgVIvVXWFwgvyxzlPLBgZKmPbqLdMJJrfGwaVCMTeEFVMTiixTdLBbLJTVQAXAmtYyziedSX",
		@"JGveRXHvGNsqWMpFs": @"QVwnOLiSNPdRWGymjGGEeOTijaYNObSrehKiKpUzpgHicMNBozMPvhpmEyCfJfgxrUDWIpKkBOVKTKMoSMccUeeLTUGcdnJCjMGFbmTZMqiouxLUheJpgOhCkKfVJyMcHSDmaxHtjsjwBJkOBwVC",
		@"nIsiPTvYEzuRqzv": @"BySNTKrAstCYtonzkNqWDIrXOilrNQluHIsbbdvDIPmMFhpYONoPXOCIGluSOZKYvPakBepXAhafxWXruEzVfWvyyzGFdKZbBImzFspUTNVJSwCZtzWCkXFtzqhSJhCizHLRePWsJKQpET",
		@"DrmskvTQpRUipvFmI": @"kigvekvQJdbUaFtLtufTQcaJgkkonRtjSaNHOziBRFEMsUAeoSWahTquOzDwJJnMPhHStrdCCiqULAyHoEHTnjdrtPicxcCYtgTnGmAwDvqQZWwsGRYRsThuLhCiSU",
		@"CUdDpKYDIzZhfXtXmSY": @"ZRpNDBymWJXDVLAhrBDkxToTYbVIEJsOqkLhNhewpOMvcloJGIrNIfStObpxRAQfsceufCMXKokSECUJCuuDfQHLJUqpzEiqUYib",
		@"OYjgZQKLpPqAX": @"WPRjnrMtnyYrCpgPoWGDMBOAwQweVWerSxhQoPTucTfIfoZhUYNUWhugCAwOpVjDfUCRbvpIZbRhhqtwVoJPJqVjGeSGcdEpxLqKxIGzBQBUtubJxHqXbFGSAnYMKLMZDoqmwjb",
		@"sjWEwSzqqRuHPckCA": @"iCnpqRPpPBIWALsBkDzQGyYpAQyYGqlkqUGMsMaSNeXdHtJdSoacFvqwbAPmxqmjPqmgRQxTrRQpmIvXBPmAhmaeaHqsFlUrsGMWWGfczMJaBCmliuSiigtrAoBaYdJHFBIhMmnIQK",
		@"dTuUDpQATVfUbgLBKaa": @"uYEBYvpBbNDXaxCeblWTADPVdKkiKaUrCfERrHYxaOAgfQkzWpcaqZLWryEkmYrtBkSlnXiNEbiXjYFYKyvUTPnRNasIyAXaKSAUSPdIUSFA",
		@"rpkOyHsYbOK": @"mvqwikvnojKaXFWUoEGqQQQeQmddZGKuWzTzVhQhdPmHwrsjHYLtcvAruzjOqIQGnYxPMnfKwkUDNGQxDUHMeorvEryAFlevayyvjErLxBnKCSWWFsDgwtIwoCT",
		@"qwaBnizMXiwATIDBzWp": @"IGxkmWLxIlHGmIJwNyxVOEOuKixSzwpJngobRrbOrZPvopcEpYOZgDOPpEPjSdqWqOCfyPXcYKtvcrvrIZdrGBQrslOjRmnWaIhufoOYaiLgDzuWHXEolW",
		@"TYKyZnJWRsmxm": @"qcTqTMOzUQaLkLujTiceqJSBdbWYWWiVWbvVYZdiuQbsbFgHrMoaNtTuHrdkRONpGswCDhrNqKEzAtQjCNSCnOvmjnQMVuOkDkxVDTNKMxdqB",
		@"meXWZivOsBRqhU": @"LRHyCvsdLqryUEAiVVitlcipRsmhXCKtixbipCXHzOQMJywbKzXisQFmvrZVbMNpiabNfVhOflOMlJZeRnvBpLIdAFqBpaCQfwDOYWGtDMObyuIawnmdmUDJlcAx",
		@"deMKTZqIVXhYAUoDJ": @"BzQURCvTTnWpbwzMuNMWRPiAoaPuMXIotViJkvHlAiWDLvqpmWdRvROiISpNBtaFqeWWIyoZDYBtkSiWUZWpxowithfhZRINRfpeNX",
	};
	return iBMILSmwjUfCB;
}

- (nonnull NSData *)LAWwXrBGQpcDB :(nonnull NSString *)JwfiYyMLmzfxIVkHgZ {
	NSData *hHSaNZQJDNxSwFDdl = [@"OYOsgrNZBxzGujQVShHWXfAUtHdxTOkiWofCXztYJVqiCNeGhZzpHKXIqnWUuBvnFqdeCkwSvIpxMIeDKIWZgVqVIhmMFtBNBMCGvdoZxGAXMEjkiMbylPfIXscJrwAIIwMkp" dataUsingEncoding:NSUTF8StringEncoding];
	return hHSaNZQJDNxSwFDdl;
}

- (nonnull NSDictionary *)uAGqxbQZymPiQXHM :(nonnull NSArray *)ZIImIlDbeGrj {
	NSDictionary *KpfQeyrRemrmdq = @{
		@"YGFsJERDWB": @"dBooNduSjfZsYuKSaIOEtWzBiJIupLBWRGzmjytmbfBFmjvkPFodcBTsErlUgRLTzudTJhlZMLJTJBuURmAZigsGQoaQYymLRZdOuhveeTbAQlmfSKIniSWygcvJPWjvFnsXqtqzQujGscjz",
		@"hrToVBOZtFmeep": @"gJQJuiYqluaLYsleqoyeQWTtRFSmVIVVxkjBUJixRJRVqhcjzWzVhIQpAEKJTknDkUIsvVzIyTNWQivmeIbtvJzTpyYryudprBLMEobuxycqxFjlxBbwXsEQq",
		@"irEYLveXXlo": @"FZTTmxkXFJhGpaqtKStGZLSGZWXRfcyRGlypUQLDCikPhkHHSKrRoCOqpPaZgPFdihakboMXKyJTMNBOCLSKixkOXJGrkfYAflXPTiRKtakjuTDq",
		@"ASEMjtDOzAQGRJs": @"twQNTiJzPPSTuDeCdyOoYGcizKlBxHjXWPFaaHHOmrxnfGjkVnVCIJNJhVwkWDqztCXJDTtukukNRLAlpBEWnuHaGYznJoXtEuVqefMeqshuEyprjaWwTlAzPOFEcCpnzhYAxyPhIEmJqcnLRWiiz",
		@"WYLEvvNNIyR": @"iBHgWGHLmgZTetOjBXbfrKOfrCdjGDMhiDlaJJgJrJufGqzSuXcuNMiBDGmPKFnSKiRCOwLQKiOwOZgIfBdGJhVOpHIXVUtBTjXSyZVrRnkSnVeMipYOGYkdEwisPchhuNSqvMwnUsurUSoSQLgz",
		@"xxgdsxjrCIPGaBf": @"biYiyHoPyhrubptOJIssoJTXsLaTliiScOcDBrMinpWUxtjsRKGBlKXLkoxEPnPumuYqYzijdqbWzYrMxTTqAwwQwOGXkgEhzmpwShKurmmtubK",
		@"PVOeFWptEbIc": @"CuqccmpjvCvQMIJhaYDYHxIiKjlIOULjOPZurtChqkAcwylNoHiekMJNmtXhttJoodtQOhWlgHMNDAGDkhPctpPVYNWauCjZraUFsxQZbelZENAJKwJtYBk",
		@"AAuAgCNfaBbqTmo": @"IZKMKCzDJwxjVViocoJIYAtzULLVuEKjdWknQyZiyIQMPMaxzMVJGMYacpnegHCRIMgwyjfxsrMjizOGMRWqdyszLEgckTcmGiuydqjgNtJeJSctQoKGrMcoCExsJMWnhFAAghaKNFLVZeP",
		@"sABYOUQsDnSeIk": @"OemaCPPRrePAqwZtjZFpkLGLTnZvPRJHovTUQaSiGpLkwAIqsrMehstwApfaKtoqRnNfhfjVDmltxEnHrYoQcKbwvKFMLxGQVfbqaAszQKKeiHdwemnWJOLpxbEaabGBkhFVSntGbk",
		@"FHTndzmguBWyjhz": @"LjwMlUKCLCFtnZRkpjtPnTPswgBuzRKJxRMiefsIKUBRkqzDfuFgWMDMRTQpLCldeZYGJyDTBLXsCqHcMQGzmRzTfykuqZViCyfRkSoyWbiVBcwlTzzrSeaoy",
		@"usxERhQmHULFKvZ": @"NTkgunBuGghKNxPksdzUvaHFiEADOnaRJZaSmRGEnWoJjPBIOHoBnDZZWelVsiwkrMqUfZercbhTqcCdOQBJzaSeCuFnQIobSWTBYKmTrnEqZPqIrdSDJhYmU",
		@"EZSXDZWFwTawfbrEHu": @"sIErwAUDwePglnbyFksCkdfDHVZYrVGABXnAvlwSWFVIRlCDojwyBBQovevgQyYDSkjwxyCtuvzEdlLngtRXhKRGxERnofqMUwqOsVfpIoVtNAsfseBEJubmVaotfmrQgIKYlRDsvoAKyJiiu",
		@"UVYFitvUoqmJl": @"ASqrYdiubgMmIGYJHCPUhxRGdPaLzzYpnBGzVPyDzKreBkjWLUXGTuIkBnsUXaSGROPbGNrFsJGFsoWQswlzBnKfOztixprvkXwKKOsKJVCGnEgaZqYCpGKeJa",
		@"pYVyTIwSedmlhqoZ": @"UIZlrihMCJySaZpUzasnXIEznCriTWHsSJnEZdLLCJBtunHDRUgYkgaHJIHRKSCpsSpvbHbkyLheUmZIpTsZCLRgaQXHiYVGzhDWIqIYQLHMxfULqjrznbzyINKOXkZPixUgYljWSrYzm",
	};
	return KpfQeyrRemrmdq;
}

+ (nonnull NSString *)dOPskKcjZfGpGNuAYg :(nonnull NSArray *)zxUaAbPEuDzcTWxh {
	NSString *YTBuRAwyxcDdhZMCaq = @"jxvaizLBXciXdERHuXCqwgHuyTZvwPQvHDKFNMbsvaUooqyDklYOuvjmtCUsTQvzFFoQRNIDndcBZUoGfiFHVcJelEMsapfrDzvPpPHZIghDzdICizqJDEYDkqfRtf";
	return YTBuRAwyxcDdhZMCaq;
}

+ (nonnull UIImage *)qjTXKDpKuesAJo :(nonnull NSArray *)zqMaQaebKnrHZfU {
	NSData *ltkbBsiWIxdcBA = [@"kPzVDyGLOtFFXCeqmExBBOoxjlghMIkZIdVaeHSayyUfyyUzMrYyUrRGVNcWAwoBuhmgLgULyyTWZYCtQbONWEXsbOvFmJhnymELAowPBzFojPDmtepXqGSmSCcvHIHzdgoexXRfwCbsbrKKLxkY" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *dwDgmVcNfYeVUoDOC = [UIImage imageWithData:ltkbBsiWIxdcBA];
	dwDgmVcNfYeVUoDOC = [UIImage imageNamed:@"vYlvuFRNWpmQNRLUSFVbRkjrmmcAgnShbOWMDNFMTTLUILpUYybqsyWkIUHGrreWIAzSKsROhXViSVKiBeBMmOEzVlSxyCyIRbpacITTKIsHLVUgYFupRolXJrhIsQeaZsmqUatNGMEKeX"];
	return dwDgmVcNfYeVUoDOC;
}

+ (nonnull UIImage *)MIBzxuhkwdVUyuJOFS :(nonnull UIImage *)BiNVjyHVHCohAGS :(nonnull NSArray *)fRYEVfKXDeUvpjWGI :(nonnull NSString *)iddaFpSQZDK {
	NSData *FnCWpYdKMRyAJf = [@"XQtxuoZeNhxjuczXnovagZIzNuYbOrmkWeqvKOxVOWkUisBeZclalAVCRoCurfyxARnwOzeJHpTXUuLcpwkZXfUCsVjppZWasatTnlUcAnluZfFOfaBgaalCKEQTRHFK" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *KYoMxLPSSYrZiEOPBSd = [UIImage imageWithData:FnCWpYdKMRyAJf];
	KYoMxLPSSYrZiEOPBSd = [UIImage imageNamed:@"LrbBTvujggwJzpNukPiakGgkpvyOKoRMdPVjMOBayBpaRagbSeqfIMqksgLNjVSjrtsmXIWPHidghQJAJCkXywVnSnyBSITqPFoGbDxUfHTPiPFEHFzWLVdraLREVPTekWZcmSyXLxTrskekjc"];
	return KYoMxLPSSYrZiEOPBSd;
}

- (nonnull NSData *)eMeOlNUXwyFdDoiWduE :(nonnull NSDictionary *)hvFQTquaoyOBOJaYoZh {
	NSData *CayLwvSzytgbqxz = [@"QWQZmCdrEVqRrPNZOKfUFrQubEEPEPYqOsZcoLZPBNQcMIZPlpVewnKofxIqcsAENAEnDJjEqCUTmWtJCcHtbJTudclznnBpdbpo" dataUsingEncoding:NSUTF8StringEncoding];
	return CayLwvSzytgbqxz;
}

+ (nonnull UIImage *)EqlFkDnyLA :(nonnull NSDictionary *)mfGUOkSokedhgy {
	NSData *rUcsGMWOJadGNR = [@"JUutYczfZXCjyIKGJCutzMhFaNQLLwpsIAQgqKlnHnGaiMbXPcBqvKmnGpdnNIjbbWdcjvMiNeIaxMqxtPPPjfeaVApsAgHNnDUjhqUVHGxYCFVTtqnDNZRfyUtizKteOQCNdhqpepNeRde" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *aUMGYAjKOeaxJxLCXV = [UIImage imageWithData:rUcsGMWOJadGNR];
	aUMGYAjKOeaxJxLCXV = [UIImage imageNamed:@"zqoQZHyDhWNrfRJBCScOXVvXrsANaBykHXCzdRDeYaKZnQyYVwoonKVoMMZLGNCesBNdCTVkPAQsQFlCTkHainckGHqlWYLltnSBY"];
	return aUMGYAjKOeaxJxLCXV;
}

- (nonnull UIImage *)VqODgvTMuiPiQ :(nonnull NSDictionary *)nUnIhRcDLVYOwtB {
	NSData *tUyOqkhzDcXv = [@"CpQNyVtRUAAoNbfqjJVtWIHyuomcnQgcZkfoIdEpNcOGQiFYjDSZznyOjGIvTJbGcAhOpISYgilLcNDLwYHYHWrtfAIShKQdiCchfMnCpGqmamPiyeKALDATVBGfuewWHDEvcOcYBxTNgfliAwWRE" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *rKUbzwfIRgq = [UIImage imageWithData:tUyOqkhzDcXv];
	rKUbzwfIRgq = [UIImage imageNamed:@"TZiPHbkctMsKLFAXvrfBGexclORKlJUdxFuomISUeVhwtEwtdjhIBrZQHEbsmFZftLLjewmiPmpYNyzssuHmwedpyDILbIdDDdvKxyfrGDTeeiuDDKKJhxtpUr"];
	return rKUbzwfIRgq;
}

+ (nonnull NSArray *)LdGVhExxFlMnXFPRh :(nonnull UIImage *)EYOFOdRBdlkXm :(nonnull NSDictionary *)YrmgRjtNBtoUbPL {
	NSArray *idYxNPwjcdeYpRjJGLD = @[
		@"hlXSpmJeYZhYUacRLfurxISwSALDuTMdAbSYtQdmPGkLdcCJUSMFyGeNPziUpCvRBSnfWAKRAdaBCEyBpNXXZbGXTFLElLIyWwWpxBunBXMHIEfZiynOTAyvTAhW",
		@"kPbuaNYqxrejrdOZVMbibiAEASucvpxAIXWxHJTtwnfXhBAObrJNFbfgizsRAREKFdjfrgLPYYSldWCTBCtNEkIDasTUOoMiJrMjXvEAqzxfikjhGmmzZJSYETuKEUXmmmQqLvmAXuMvK",
		@"TKFptlTQLwDdAQTUQEbjhgftjGSiQSmCarnArzuQHzFuwfgxaiOQLReNFVzymmgnnJqklomPScnWXSrHOmhZykOQfOnSbeTdFdMgYrcgNIaCAPxxNTdwTUQCgPUlInQcmWMrFucHuOfvGmB",
		@"LXRimJxJYAJMmytNBBiepqjdQBBouWgWusTbkPVmTHWgzhVNpEzVNsxMygkgBJrUkphrGamTxsWZeHIRwGSPsfRmjrTzCDbRswwQoMYWuZRJm",
		@"EfQmXWpwRWxnnYfrbJfGqpKAyscohRMUVSLhzjTghdwoAWkXlraIScQyOusvOqcqloTNiXqknIfOHORTvGnbuEghADkrcIGlUgrBBb",
		@"ZkamFHvpJbNfXHlfmxGWPxbGNSbCxMTUEpndFwAQmoAdgVshmTsKgyYdatBJSgjXpSwIuHPasmYpxxCISruWFYuBPlyhipFjjJkxKcRuyDGbuVTIcFfGElPegJyYYTOaCvyZIfGh",
		@"miUmDqDPXZKQgRRmjyIGliuozBeSxgjpgNwRenllQOMIuuIoMOpRzfcqZYfEEdWSzSxXZCIVrAnLSlCshhVmmPiFHsuAxXhRIgEXqv",
		@"pcuQxiHBNAmQemOwEYvRrhJaUdOtpeUPSPhoXpIOkfDghPdfCnBgnYsfZOiyqEvKGFrvVhmqgvqXjoHaSXFAzyfBpchXTBsSZHWQSVeEaGAPGPtSchayfhTamBfVNCUENrjixCLjDMgeLn",
		@"lGZlXPdEWsLqiFeFyOXhDFEsdZPdwDJqgrDGrTXoHJyQPcaoAecqrmvupMTuvImIdDWRkqrCEOIMUrpfSaCsGjFqJeQMYCXLROvCdbHMOtaHeUseFLtQkcPwzjqOWIUkpEgBrvfYCkNcnNWnQ",
		@"VPltqxLcnheTFOpoKRrSEHtXLTxhDxrmXmAUgZRAfextigqvgbCvrKOitOxwzXYEExgKkwseOPJeiXNaujIRttpXNWYRNOgGulhbAlycTbEXNkLB",
		@"VdFyCnLEGElmabbyHgaBxYSPkciPTPRYqIXzHATXgGgVZsJruHuOLwJnhGclTalhvkdUhGJZXldNgphTHhjsnnZfqCncnVKjYQMJVbmOvkecikxLurYSwRjfnpNJCGcWRIjqoPdIhBPW",
		@"tGGSZgnJeKYeDaWUdKxftViNmNVmDjcCqYAbMvXBnLhqziJCZAyepIJKFrNUjqwAuyTfuwZiUJQsaukWuzAhHNbxitcLJFTvezEHRazEaoDorJMELYKUwwspjnqPZvLrkNDOWvZNKx",
		@"hOcriSpwecEzEIHNRMoCCCZYrBASBwLeasDqUTCmYIqpUVCwmNJrDxvPNEfgUbyVMHNgloosktPWJcJHFHnhRaXDsBfayZRDenSMNbC",
		@"tGysetQnBhfBAuzxIxHIhBwEbhIYARLlvfneBoOWEgLWcDNqGAHlPUANFUOncFrAOMCzlgDvHnAdAOuMwgNWaAqTaGrmOzWSqwrInhDumPMxHkHQOVofRUMQIkMKq",
		@"wsAqcYjCjVEVhFlsoDtZiZZwJgixfERHJhjcvYYtquPrrKBwgrcjaGTeMqbBIpDASUwNEQIobVAEHgqiGYqBtRwHTTcTaJGZTRZMcfVBYLIgslwkHyaCFupqflkGoUKfYrfWzAVQqYIxADXn",
	];
	return idYxNPwjcdeYpRjJGLD;
}

- (nonnull NSDictionary *)IjYpwtLwgmvHf :(nonnull NSData *)rVGbePLeHAElyJ {
	NSDictionary *DltbEGKfEHZpFnTu = @{
		@"lkHOlEQHICvPePE": @"ztgXdSVEqQXaRQaGabuxPSMUfcXDsxFPFCjwdoLpSsFkHouTsqpeLWfpBrgQmapjEpcvXJQCrQiLlFvHrowTLuGyaTnssVFYjvrHmFRvnTP",
		@"VZznFkuQdotBcOY": @"LBqVykpSWtCVrAcDkpSByLXkcFziXmPGsXkXpPYqMjoVwaFJsauNMuhKePlVGiHfnqrBEwuIjczOsoTQwQAjyIrsXGlHFIHLqKYbXHintNlKDonLUmMzuRqmYRzLFjSZQlhjr",
		@"YMpSeuCzHiuDsUYNYl": @"devhypvKacofKHMnAJEwIMGEoRfBNaEZxtBTwytVQnWFdNuLRsujpwPjThDqDClorwuJgKZcNfrvJkqQZdnmyLVgQqBobXxYeKwtilSkXCvrUXe",
		@"aRjcOcgNSXgUlQdSWQ": @"BnSWxuekhxKRXZkBVWPrSYxcrUegOHjQieVxFRRUUJcpOpbpRlvECGlhCBYqGZWLDvQwueRdcoUOdSnmgboOvwJxwllVSqkYoDZdHoZVzhaXjyDRCJxiNxRfZqkSeRNFZqoIvzkCzZBVapfXhhf",
		@"mwEurlkyxKuvyZ": @"svxeQgjFonGafFtjiJatBWPDzTTyWQNzSebSLBDUCVZGhXViNAayBwhlSIwyHmoQMzhNHsijwiTHDsqevKpsRjFUVKLTFfjJnpKJRjxKTnLSkubWQYfwcKDMGNffTcTWpAnoCkbcVdMGtNDuArOcG",
		@"XBeNiXwFsujrYwF": @"NFUxbpgvBcryWkubyVCYGrpCEmBkHRXSfswYcozXkwWnbySIcgFPGAGPTbxQgyoboXTvDnxDdrkQbIMVNDIKGdURgWvHNglXnPHwLYQQFrVpCngrvtLsGqxYYQIzLOEjTOjxvc",
		@"yNvkKnAfRz": @"bYSeiQhfTJAEUreTeKBcDcuKOfytgyyesVxUacntOkFdlUVRdglVhOgMRBjnpxnAfSaMyKpRxjVNZUgzDvamWfshDtgHpyGdxWYSSKjLkCodKDyoyavKSOYcxDZzJmhPRhbRAHIpIKBGuIjC",
		@"DXRHYsLwOGzOVMaxtVV": @"QorXKlRkTazKuRVlZDAxONtRXUcaShiIDfJtZJzrwiDyKdzkwCxDFFtorYkDTjjXqRttfDUnXfvxmTNRULEDxPHKEbCdLlPfsahmlcIclpsGeAubSKdpBnqzouLYUNovFtIpBwciOcMdNVMvA",
		@"SsYujcFGiVVB": @"GJmbbLDFYYrApMMUBoDFftiaGxkdGkUtgbBuzaWYykQIRlrafylQKekPXOaRTZGSHplipmArAYdGnJNhWhlmyXcRJflJuDrzuACmjhxeqvSCcTkwIJUrLsn",
		@"bMmOTHmMCbzLXquANfa": @"wderCfCKDTfSMIGYrdyRuxSUVipGluApciSEVExWgWiWqZtoASvlNsDGFsBgKutZvgrIeUHkgzpjAEOnEpwJEXFVrULZNwfJmVipcGfHkLYKRONY",
		@"AfRTUwcbwpPUQuxgXyd": @"PKTGuUbBByXEnuqCfKCuscvxTgXBFFtLoLAxqYBGOBQSfoKuRIXdeEiLpGNBNVSzNtZMrtaVIEbVwaJnijrTvJUazhtLAyMBtRRblzgebSkgHUtDHGFCGFgYRQfjgtdXHnF",
		@"VXANtNdkIUi": @"skzSeOopnwtSIAIXOrFsExnKYXnJZpGNsOkYHYZbnCpinPFYLwMSYNEDoORwjENVSBajUtDRqgmPGBAKULEVrucNIpJizQfnZclynqdPgCPJQReaBDAwbehqnGdvkPEPaDpIuxGXletO",
		@"bYdSGKHosVg": @"kApyluBwZaqVUFcGEARbJTuCnlNJihthepdJUhBHDnAWenIOefezXXRVgutZtTEVAWLesnftQGLBjHlSErfobJDIXXzSstyXcpgwRWgVLWqLQEKULiTYhinWrLlbzFnxwViqcMrWHtDkVUReAb",
		@"sWOEGSGGVq": @"IssROiHVdcermHFbTPjOYHbFeVCnIKMrOwSAyQrRbqmuHwAFKzmcejDRSwxsFMCwoggMmWGSdVfFGEdcmunlEOpaArlaMDnKMnLyxfryFbUcvOgcGigLYZMqrisRqHsruzDXrbzJEhIQ",
		@"YtqKiuNQZKivWnqyR": @"OVHspNgjBGQCBNKWZhFDpXJmgUqnbqKudxKkjYgrcapgDBsiezkXADnmZFkNtaelUfEFcTsjxAjnHlBnNMfiRwEcZusyVjzsaWVNotvIZJtWXaJmRDHFWDZYxXxglSxDXcsQeiHV",
		@"NmhnXamVrlZNZxChLmW": @"ThWBdiAxnpiTgtnubeqysJkJjApyXOrsGLOdATyphjTSvAvYwNfbvOyKAvAtutQRjAwjmZUTxKSpHqYaYUrXEPCXqTqqSYwOodjcJpqqsEFWRNcbGKBLatOMazQpGsDcvdFqmTNsbCkIYvakLIJR",
	};
	return DltbEGKfEHZpFnTu;
}

- (nonnull NSString *)kPshnOqpLYjGp :(nonnull NSDictionary *)QwuDMjiJPjxCBJ {
	NSString *CyVdDUuMHtNyCilZ = @"dqorUQXmupgNwEqyRsrqMOMRIVxnulMrlaMpMJKgJgwZCKptPmqYQzNoqJBwPPWKkOIvTPXCfEBGGcfEuYBxpmQKYxavOZFdlankwOheMvw";
	return CyVdDUuMHtNyCilZ;
}

- (nonnull UIImage *)FBfPmBUYPrElw :(nonnull NSDictionary *)HVIkenZfXV :(nonnull NSDictionary *)IqzhLDCzSiyN :(nonnull NSData *)YZlszpxZeGKDxyci {
	NSData *ILabJJEbhAyMHH = [@"ttbJMTEzdcMwArfHXYBFGUjkyWZoSEsMWbKkYaZTuNUPKkJgicWvaGBmpVRXVKosMbEcgXzaxDODuYgcWxBmequLfwcCUSMSPQtaKdIIHROUi" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *OLbSpGVsXzHCRPrzGqP = [UIImage imageWithData:ILabJJEbhAyMHH];
	OLbSpGVsXzHCRPrzGqP = [UIImage imageNamed:@"UXaybauLMywQJDeNCZOfwfirqPuOvCLdthgbLYOxsYLthBnaCGFXtfjfuCeMVsKmfetYAVzxgwDCjVJrsTIsvegpTlWSgSiJdMkXgKjbDZlPxuJUvjpvPjKODjjeBmdoEtBHxBV"];
	return OLbSpGVsXzHCRPrzGqP;
}

+ (nonnull NSDictionary *)YpacWJLXFk :(nonnull NSData *)rXIjIGnVxTX {
	NSDictionary *hGmUFmQrbRgpWyxOD = @{
		@"nLRjKqGTtpfHpcEDC": @"hYhHtFturYhSjrAgFfFBZQaMbUkIplYFpcHmSDFSgAPtOfPNiMfWStGpUCOyysnJJiprJjohvnHwNFvDQWhwnmEUxRqEjkTxjxkRvuIAtqGoOaAIjDDvWmZASDFCwGxFKBfOJdasUMwjknnCejztz",
		@"EkHpObMMHKlKBiCz": @"tQAUDSNOQRNhSmfkBcaTpNULfkTcKKJXfJQyNqMPUKPLDmMNITvvZwPOHoscQFroEHGWlyzEsPuMMphDQZHBqBoMVIetUGNMMoFtaBjOpVsMICqjxaOrXehRDZJaJOBWCSBnDTAlW",
		@"kCxUkTxtIbWXerpT": @"gBsWdXDyRkEFHZyhjEcHootaCQiNCANIeoCaRCflqawcZJxDVxuzlHbBeizBgIMrKeOTrTQoScBsEZVMVNzYBsxEhVkFSvsWhhybxCXnjaxbvGhPYfIRQBkPfzbwvYKGOXYbsC",
		@"uxedhratQpepMaqrQ": @"pCevapWDBYTWvEzQDLLMeIGLIBTzQqNRsskYlPUNBkMGnGQvAqgtqxmKcvTzijlUSEmBuBpEbeVKYoDaOMUWeWQoTnGEjTwztKzDEHqcniAjSDiiIxvNsIONrhLhlgbexQjzLG",
		@"XIErMzNRkVghE": @"ipmqqYrssLcLFMpcvsdJDOTHlWSeehmgJtJkgnFHaDigzxdDCKoDPsYlEOWXkdltMpYpVQrxYUBQYhlJAJmDdBJeabFmVhroMOwUBXAMnjOFwhtXMCqkcVf",
		@"sLQFTQLpVXarxLHaaVD": @"VbUSeCFWNZKIuJSwzILsFTUxhybiSHxRzWxdMXLjDKHBujWLmLRZlxfIEYdkuTIjtvnxayZfzDTZBwRIoIBDaCvTdJnaYRdWIVUEfHcCjJHXeTsfbYQATbf",
		@"rJYNjditEKojQxhWFb": @"irSMJZEhRgWpifeUjDGwLtfokiYlAojtUexgDMHVbNfFbSGOvTmWLAUvBwIIMwDXmdGRExqdrSdRmioYjfCCRuerbpPrsnNVDRQTmlxyTqsncyJOYEscQwzjVyCTEYTTGVHqzbOWanfYqYKol",
		@"EiABfwLqWJd": @"ueoRLiEIeKgKAKoRJeCHDiRMBwcfZcnmFtgwAadBwfFuJMnAlTlOEntYvjjqxIBJCCHHeZlTLDnMygobVkgRmTXUlnOwDntJzChkBXfkmmYymdpCkSzOevbIrotcgWmDWoS",
		@"GszSCskiWFVztqHjCd": @"eAhIjrlDJCMbSWIDzRXZFsUYzSzbhrPvOyrQUZvLEkMZQTmDVHbNhqBvoTTdkWVuEurObJOwxrIosrXnRBdfgPPOEvtcujNfpDCjMQFkXBI",
		@"DiveXJZGnFJt": @"JzpYDtIGtxbfTCxKGZRfEulHbmDQbfngwnDarAhBrHUeVJuhHOkssVRnvrrWKnoEUYyVnzYkQSqmJuZLyUIlYbMxHAJWtoWMbplDgUABKfXVnJloxYdEnbdUNzcEZKkvBOGdsJNOFQIWADMLTdp",
		@"nSPauCyyskNitKwVYwj": @"FCQnUkioLJefLKNozytDUlSnuVibPOIUOqjjacZAqBXuHJKOJRjNrbszfCaJpotnzmmsGNTrwOpbkVHMwmElUxTzAXIjPPWYYrkVAdDYTqFoCsDJjGheYmhKExUwwQMZYoWCELfCvUbOesaNF",
		@"ZAPeAFvFTcnqWoXfP": @"upHtDzpyeOFAUziFQrLPdGczjUZruDqzWQMLTTNCHUvMVKyMEOGqCwxbZyhshgyRVFVDjehTDlkMbEdHPMNvKKDdNZBWbDEaXXArrEjZEovVGXPTUEvQWMnq",
	};
	return hGmUFmQrbRgpWyxOD;
}

- (nonnull NSString *)BARSQDmiYreaDFOw :(nonnull NSArray *)GYRkZvTTnH {
	NSString *VaoggzDCcaGc = @"tdnAHgUMdQwBpEHPjyihXAhkanPxtdMpFpRcghNuxEwlLxwyJQYsbLGclbpdWcxosnyXfrQctecwhNWZcedcqLrjABYChjemyUXWyxUwrMmWXJvwRrOdECWvKnOZUAFUwmiqjPUmmCj";
	return VaoggzDCcaGc;
}

+ (nonnull NSString *)ZCwupdwyCCBaZFpH :(nonnull UIImage *)hlnWKIEDkXFDnp :(nonnull NSString *)AfMZNczxUPz :(nonnull UIImage *)jXUaLtGsoeASpPgRjSj {
	NSString *qhfaFyFEvqeYLqsmSAl = @"LDDqfobEnyhXRKbUGDTXYEnUQCAMqtdwwuCRnGihQUnnlDcOHYodEqmuoqMoRuAeldQWPYZXlrLMpsObwXcIZhljyegyzmLFRugsEeNRPLZE";
	return qhfaFyFEvqeYLqsmSAl;
}

+ (nonnull NSArray *)pImTqzaILHUf :(nonnull NSArray *)KsOZwtuskd :(nonnull NSArray *)lIKQvFaXlfqZf {
	NSArray *GpVCWaDHWoboBuwsFDo = @[
		@"fhwUTyLnSaBqKqplSOtLgelUtotJpBBBWFljCeAKrQRFBqlSOYtKaudtbHjyjhDqpZccofZriNtEHNEaHKFnorJJdsyLpGUNpKCkheIvgVUKUnjYnFoNAXf",
		@"hYFqSEQmhfIQEGNCfkWfEFHfgpasTBwoZwdXDYGhHhxBZPKZdRYozFyIXZqunKqPQIbPAibkzYCBmyRnoRWbybhfyyMwMOoqWaYKXinKeECLBoOnbcodyqvsEsmp",
		@"IAMQvmOJEIzcHJbBEKLZizNRmOfujNopkTlDpAtboBneVQwrYVWOcCcHJesBpYcjNoTsshDRbkDGCAzPQOrFCwLaBIObKeuBBSgFpRxsItuldfeZeWLMlNcBseKBGxjFuyiQmmgTzlUrHzOsl",
		@"TaGpoPVmsUkcSkIXMQvVEjHuvZqRljVfdmVFsyZShtkaunSllNzvVUiRtfLSVsISYmiGRkUwjAkjPlRpCLgAhUNrEvkTTQwNhQCFZgAevemlHMXNEQnapUYqtscmpCKVcnwH",
		@"ECCnsxtWcMQkVZJUyHYJEFJGHfwBDixLVXdenaQynJOIsnyPWMLATfyzMPiRQtVWVxeUQmUSzYOQlUmmZNlCSrWpRZwunvncCilujeylKZaXZHeavuLlOPzospdeOpCfKxEsg",
		@"RXKcVlIVQiZyeyJCMIyratfoGbvHLXZPPPXKkHVmNqexUaSPzaRQviiLrNjJRXShZoUklwNvjhFzraBHOvqESefGpSiyItVFPjkvvriQjBmEE",
		@"UxliestPLrFWYIBeQsKOqrlHbpsPIFopvbIhhNlGuAJCWefPBvfSvyjUvNvoaIjtVCcGTwPJsvqEHDxycfRMiLbjNLpVlafyQFmvtKVmGKswsolwcjDswSkEBEkPcZUQl",
		@"cPFuTYmYVxDMakDENfLsWtjkSTEfLdcOewQcIPepitxDozRAieBAckFiqGWgOszXoIgJYxkWSHbjSNaqloGMASwbeQoXjllQDBoqnwKqbnJAJdEikhgnGppWXNZJKLzcAyA",
		@"kkyloYJWzbVerVeCiMaHAMkcxRHADijFeCETPeXhawoUBkEFccJDuKGelYNziEeLJdTfqzYbgXLNRMRcYMIhpOSrLfprqeQSLIBXO",
		@"pRpUaHRSpXHeiWbVbkLKVxVeuSxELGrnNEoVvuXsJfaZRnDeXiqosiRCELDlFeTZBVNQHxJSCOXilfShaUtDwobAyTpCZiZUqadBVUHmbRUfZfdzujDEWGOnSRQZkvVowKDWNNGIcwUB",
		@"ViWCHzojtvoMAgRzTfRyJRqhPPHfFBEdOlMCoWcKtYfCTHdjQJwSOTvCvZQTUvrEtONEqHDAlPrjkrGZBhFmLAOjWzDsLMDzKdPsRqSlXLdEGiUm",
	];
	return GpVCWaDHWoboBuwsFDo;
}

+ (nonnull UIImage *)ncHqwQgUhvpLDIokk :(nonnull NSDictionary *)tSBaBfJZjbjvqBhSAA :(nonnull NSData *)CoGHpmPQVj :(nonnull NSData *)sfpKhqoMQHxlLDkb {
	NSData *EywnbpnJkwV = [@"TANsXThObwUtAIRfblctLCPCVFetyfEGdemUullrwGUbVjNBntsiECjzGefEnjdxJAjCVHHYfymozcQwmXOQvYflmKkEPHTJaoOXYPvgnlWpssAEprBBljKI" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *VOFJWjuQnERMxwEV = [UIImage imageWithData:EywnbpnJkwV];
	VOFJWjuQnERMxwEV = [UIImage imageNamed:@"QycRNrRrrNOEaokVBnkcQnvcQuiUQHxRiCNlZVVMxUjEuaMObvCkAhRdHKoAifJDTZjCpyoYslPkaSlBYQwOQezrOroNvDGwaBZdQvCmgKpBwtzhvpiGkglIfSkUHJHDnUXFNzmiOdGEu"];
	return VOFJWjuQnERMxwEV;
}

- (nonnull NSString *)obAOsHlxQob :(nonnull NSData *)fFRJDbMRKtMg :(nonnull NSDictionary *)DihASJSVXHH :(nonnull NSDictionary *)AJYArHHegdMKIUhM {
	NSString *vjwgLVNhpn = @"uckVtCHdoCGdxIfHSuToBhdADyHqVBPRjTpWfjoMxCpetGlpTmwssFydggPMKTuQUoylSQWnXvQkyJFdTAYxjHkhiOmzUpUROUxyiJTuMPDtYGwYkoPoaEBSSKtozjWdIKnPxQ";
	return vjwgLVNhpn;
}

- (nonnull NSData *)fRdxydsnzC :(nonnull NSData *)TSocNgYwpnpgWWXX :(nonnull NSDictionary *)FMkPISVAzjNpwA {
	NSData *jSzpwfktZSfDFnp = [@"AvAhbBiqQUMrBBxKLxxMyjabzxAmsCyKVjbaCzKuhHTgIjgCxroQmzOsPrrnkCOUFSEDcfNnQVmePJOIdNaOeLHCnZIuVQRGdHKjgBBakdGhg" dataUsingEncoding:NSUTF8StringEncoding];
	return jSzpwfktZSfDFnp;
}

+ (nonnull NSString *)uxdruzOxMoHwddj :(nonnull UIImage *)JSmrMilkpaXb :(nonnull UIImage *)dupwJENoSyFC :(nonnull UIImage *)AnoOrihjSCOx {
	NSString *MtGjmKzdGVAOTX = @"EYFsNmZskLEOcQTKZFPhfEDFKOepwzfZtLmWEAYUSdTOIVjRyJdmCWjrUgOtpuMbBiEkzjpVRcpPfnrbahVIWVMBxhsqLCmIayBTEndguZfXBcaKhTEQmIkILiVVHTjwBAjXAKG";
	return MtGjmKzdGVAOTX;
}

- (nonnull NSArray *)mnmyfmMnJfQ :(nonnull NSString *)OKgKjtZHBIZbqGE :(nonnull NSData *)qKdIBeafpQvV {
	NSArray *HRgJHYgYjHCjPgA = @[
		@"YubvIZXrDVQlGdUcAQWKCTjWxByXtCmtEqukYjROEvWLNXldiDkvTkwJGNUsFdHhlRocCDDQlRvfFPJtqfwmhIfVxbNpwoEphwCmwUrFaIfbCnwiCTf",
		@"vJxiRYWPuSOfgpHreXoUAmkrKAhCbjnzBksIVmTHomlEfGHJMwsGNdtbgLDuHKsoJDCGAXsYEGCzKpdcFgrpCRtIKsLCgEBkJJXnUAbXEfJwqEtejQUjVDlLPgnuZylBvLjS",
		@"uLdTMQBXVvgSLONdarKMDgFdlPkwrOIbkcBQQJZVoIZHtXOxunelEXpXLAaeRZfmuEMLFNxiMVbAMTqxbOhsBvvBAJrirpiIGWAnuEXDxzYqnyuQByAMrSy",
		@"tTRNyXIBtVAjOBfvUVwCjITWostcSFzhLOaDBLZxUphPmvoEKnUliZenQPgwgqKyLYOhQTJGmbBCcwMvQAQuLbIgrEZSkeLdZjDgrCLqrjQtDoNOPVNjtAorcYtlGbqirs",
		@"ZnOVLHRrdLIclzQNzZVPMPQrfzvwcIukgnwBGcVpzXRFhiYhHMOcEMKptjjAnEPagovyHjAskLRtYGvgcYHlwBBOeZrtpIJrJvaShBbyucuaAFDLzTlPB",
		@"njwekKefpeTltZNkxgpadFLkYqbqcxGYdTgHtFUVmRBwaYWqJZHaYCcbYeYkcmMFfKgXCSMgactinOmqIOCmTyumNQszhGcdtYvhdqFFCRTGqjcJCsSUj",
		@"FsQdiVTGBNDCEFjTYGwoRPXotsztYYnfSIqJqdTwsEPMwBeofKLOApTcPFhGDPxmKGSEwhQwLJvGqYSqdLJhVRDyNELcSNBEDGHUAAWUnhzSkBZYngYiqPiaukBwLRAgPQKZZGlYYxHQCqa",
		@"CLAlVSswduzAQGmCDcmnRnTMbHwzNTdtZtmkWSBOMiWtseboUaEvabJEfkEwOreASsXxeUwmQRLlKVowXzgQycNDdHzryWVxQZPxeOhRjkxeUhKqJHhsMaStDCLAs",
		@"FBEpoZsZAAoIPLVXQSZRQHBbKbZaILGoTctLAkqBrrigiKCOjngNeErrWAXopzfvpRLIIxrzddZKehNzNjzkVcuGphFcIlYmTrWPLOVRiwyDvNlsOVAstvKpoiJebclYFbzZEgkayyA",
		@"zAixqHHTVpOjZqnIQULGAMaqowfjxyEXEogilEDVFjwobtSOgwrmRgzSshIeuiaiaBecKvtpRcmhUyRUFGhYgzpHYlaqXFsQYWNFWFoW",
		@"lPBygqQdYTVUIeLkTYBeTjrQaxeFSrtFdZIsHFKwOSFmqukhhAObVtjzDDuQwmirvvqsIzXZTtaJLiexfMwNbSjhZfrUIiroiGjlJsEOAUxRZbKcqBAEMZLQqlwnSyYNpXcCoLgPXuT",
		@"ercwndzZgxnVfIKkeofiyIHSSRQaPJkuMgRWMrhQEkKECMMoFdchfuwefhIFdfPsDrCsfkQMjkzsicJQOXfWumKKDWcOTxIaKmAQnHTQ",
		@"dVZsDIIKdiMgDrgUIwaYVPjZajktMuRqevWhvEYuBUXBYnjZKgvTbhgnXXeBZuSXxDFfyNxzvXkXfIhpqGPcsOeCEZHargmpnfyskoxAhWmZDgT",
	];
	return HRgJHYgYjHCjPgA;
}

- (nonnull NSData *)FxIwwBXPYcgoubGCIH :(nonnull UIImage *)vmVxfkqFGF {
	NSData *iKUnBfRYOojQdtiTRJS = [@"TdgWQILuaUKzImoHEjBHQAhewVCNKIlZGzhzRafGneKJjbuxxWaFXNpKlMQnxxKdwdzWPpgJKaJyVjKHujhfJsyOVqbLOonYsWRR" dataUsingEncoding:NSUTF8StringEncoding];
	return iKUnBfRYOojQdtiTRJS;
}

- (nonnull NSArray *)lCwSpozvsWoWw :(nonnull NSString *)hkDZoskbQkRiAeltEzo :(nonnull NSData *)uinZmkVBaLFWQ :(nonnull UIImage *)bcjuNIbFdt {
	NSArray *kvWxUlHjvheNWuDykPp = @[
		@"uQWXsYpblWdpsjPwNJUkPLpInLVDMngPAokSwROnGJZTkNGRTChmoxQVyJlPgnvbAtvPXykVnlgKuGbREHDVduxCPlqqJkPwCPuOjMtnNiMaoIJa",
		@"BmLVMvaEaMNtmKYPOPJLKhGAWAKrKUFtqSmyoMGQkyqIqFYxUmkkcWKihcoonWmnXkmDUjWogTCfzJeHJxzJWJgsPbwrMHQgnHhwfAmxEGfGcaJKSeTozlmv",
		@"YwsMSLMQoMvgwPthDfoFHcnlioZweCmobEIdsNqlmgUryDKglSWljSEYCffIUYOCsaySTYatYFbQVfTsqfQCyxhXwQPPpapjiRUYUMQOEhjeSOaslcbEeDbpRQqWmhFBi",
		@"rZOBuCCaNenmPhicCuNpCYqjTTtkRtYmidIvZkuqpNtEawwTGibsuswYmFJQTVMpkgzjMNTFMuHeFpScmTetiiKaEPrUeXrfHLgapzwfbCrfsKvrAgwhnwbHCZtNxcMCmmMdKoCtOXiX",
		@"bZZlqSHTWMCDyQldOUkjrLcmWYkosutaOfUxifNIGLWdNbXQdJuAdScempkGcNBLnyfNKbUMGudZEzyQTRXHEnuWLLHnpoyNtMxBdVQULEmidVokjOnBpiaZOIhRwxppRowB",
		@"BFqEMETbphQCIgNAshqiFbqJWBHPpcaMMjvqAvlpiYirQjDHaeTWQzYlvsWtstAmGQtgwfdxqugyBrywSurWEDEiEYGqzwMYLtkKhwLwUtShxISH",
		@"yyTSYCmHxePMCzUZoNnMnwmMpjXfwpppfujUbqlvaHIkUvYFMGHHpWTcselrZMRyOwDuAijUCfYaUCuRaNrRzzVBVpzDHLIkgVpvuXdZUPaYAPtAAIVpDCOxnziOIlDFZQIMythOcDCEOZujTzUp",
		@"wMhTApoGnfxqewyfThyyrWWAufksMXlBptWqcNviVWzdMpKEQRSKijsRGZseAtVbACDsBDTeYDkBSDXleovwTyQpDanBBGefWaQAaAo",
		@"NmUuVNZFGFUJgxeGsEpiVXobJaAZJwFIrPqKvVmEpNeNhgmviXRcTdDMuZeLhxMCoKicwfLOrfaaWysHgrynqHSQqCWPMpdzrozeDGsDpxrIpILbIbmxBHZLYsqpP",
		@"QYqORMCFersOHuBgEAvRufkpQeFxryHOYeVYwtKhcViRnUeVOxdcXhqxRvxaAziKisJbhHyOovukolfRoRnwxBUMTsOKvrCHaIfdgktjXHKxjofOFvLUjjh",
		@"iBFupxMpTzEbWmpyhKOdMlruJyHzZbbNIaFviSkXjerwqjrYJphNQNfuFuCDsPTTJVwYKPANkdsgElteUmckFPlQLawtPDOZeWIPiWkJrSDUYiYZoGPCFXeueeFVHUTMlQuCfM",
		@"lVTykLCcFDOPBvHfHzMhLIvlOXoccedtUZRShcHZzyQJsApnicuqUXmypFLHQdyKmAkKHEvFuyMHbWzPtdfRmWboFtBftWFEnFLbnlWocPBElaZySsJRLiTnLqzdr",
		@"XTidulIzoYOhUVmRCpkWErCVKCeZIBupNXbTvjULFKDdtXANBkTNqwPKNuDEBBcWGVYhJAHRRUQhtnGvONacEBVNyYITUdGwCSndouHIYZWTierzWXdeclfviXZDUjmCm",
	];
	return kvWxUlHjvheNWuDykPp;
}

+ (nonnull UIImage *)MYJwgdiJKezydlSA :(nonnull NSArray *)YsEJklOSgNrtLo {
	NSData *uYeAjDgfyKltkGmE = [@"iIwYcIpuqnrIPSrOWRVrlVyPJFsoaHIvSdPzBpdpVKQrckrPddvNBAEIsFtvmMILNQjdZCWfnLXNkaTWcnfhfOpuYxbDZetwcFgHmcaRkAZyXzyjbblUFw" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *sYODFHyuJeXxO = [UIImage imageWithData:uYeAjDgfyKltkGmE];
	sYODFHyuJeXxO = [UIImage imageNamed:@"IwmcvXvsfipFCAwkGHGrrmaCaDOibzZgRSSeXJxocuBvnkeDvVcsaPysNjKvtQPTAnOAQKiVqHGscqQxPXPYcYAtRGQmTCNirfpwTAjgEPXrBORinJLUQvrBSZWTVgQwRVYzIP"];
	return sYODFHyuJeXxO;
}

- (nonnull NSArray *)TROUHDdumTXvxhl :(nonnull NSDictionary *)TALVFFmoObZUOUFvkTX {
	NSArray *EqPKEIRAKagDLaQQ = @[
		@"sqcdBPgqZJhZTIDThTwsawTocrJwhcztAhZhXZLrsIuITvmrSEaPwKdXZNqLeJjwuzvdvfsqpWfNgmFARfsWPYLDJuYzMHEqRTIcnRoeLknnnZSONKaEoWxEHzjzGOjjbaHCmMY",
		@"MUtZpEkWYanJOFDbPCODXgaPunkKsLxuZnXjrnqgHcBfZkLRFlUdNnShjqZUDtHiTuoBrkRMraoJkcCbSaVwHklEHzwQaBpxPPzubveCBceg",
		@"gQoImMQxcZfZgWwsnezEaXGkCSDYxzRCCCNXSiKpcfypavlfAugrhFLSyINepXiLqJBxmTDKgPtTHPMhWQsBXmICodSZXOuCqmnVqgUVhNRbgwYzNeiBjoPZWnMCvOlBXrOzCdMpzdXC",
		@"DayfQOSDOnEgAVMlQJedWLpswVGyvzIxXrkmmvuccienhIpyxZTzQjvUfamBaAUsoWMxxLyTAKHkTdsAtFZfOwIUnMGSOJGVacAAsYXRkLnUgdnDgKMHcfPfyFoOBnEzMkrBdDQjcQWNBfIV",
		@"zKGpRCMVZShjxtsCFNVJeMGcsrZmNvCOUCfKvNSFLiYyPzyUxgLHylvzcygAvSuujSlkXHoymTynZLBgOQBUlzDoBblXEGjMfNzWxWqLJDkgInmUqfjrF",
		@"cwZawQxOGpIMeuMjYXvjFyTjLLEAEdiurLleNkMRuuUmIogVEJyFAUeBtrLnFCFTyFUVUCVVofdUTZmuEUoEuDlRlujztOZHFBZetoGiqkTWCzNTJlVuKZqdcYehioIBhyadNMupMfIMsEKPUID",
		@"kTGzzxlxobSacLNTOOWgeMKMdPPovcxnSbEgpYFJdDcIXwIxImKMACwkkGNfGYyTSbvDBXYavTRyTImRTkiTFxbWQIdxSegEiIsYceqZxPmNsOcjM",
		@"YjiWUAfArePIniDkiuPGBryGLBCdQbXiCaKkgEDGNjTvbLhxkoUnMpyqpHgQEEkqRfMqHGsLeCdQYTINxkPtQNewdFerQfZxsDRuTrNSPYgSB",
		@"xMJbaInEiVxcDpwZDrmPryogiYQBWagNruzwAbLiCNUzxMiKdsBbkcQNcLBSQbtljplgXhuXGMIaQhVimOsNfaFQbzuejdScUOwlIYnnfNNgNzQdOvbclXpBVCK",
		@"lFiFfIDwTUukHxTHpQLkheLCjfOfoQRcsRPWbCNgKQolkXIffXuveMvQzhMNKZcqPucbcGLHiWiEZLXjQDSCUNtSkWGaTmgGRXdbPMuSKgrXIZhxubjfEPtBmwAzYRISxD",
	];
	return EqPKEIRAKagDLaQQ;
}

- (nonnull UIImage *)JbSUjcscOrchsklhEip :(nonnull NSData *)yFOCPQbTtADtffgTB :(nonnull UIImage *)twEYaijefGyuOBw {
	NSData *TyLIJWMgTNZXSpYtkQ = [@"jPEPJdQNwHNVxNkAWLZhrSZcslnUTjkKXMIGnJpONJThlKqwhNJsFCOSVvmweSBppTlCzUCeYdCuZpxpjizPtnNmXMXgwZVfeVUtnsLv" dataUsingEncoding:NSUTF8StringEncoding];
	UIImage *MFJhUNoztaIK = [UIImage imageWithData:TyLIJWMgTNZXSpYtkQ];
	MFJhUNoztaIK = [UIImage imageNamed:@"EPQKAIEIbKpCPeBpoqBuqjkIGkVVbjQVoGfWXuFqPphvXbAdPbpYgruUgSxklXTuGDAwgKSmgCAiFyolfZDvmnoAuGEwrbkRGIrlYZWOdHZVG"];
	return MFJhUNoztaIK;
}

+ (nonnull NSDictionary *)MdFbTveEWCIFvA :(nonnull NSDictionary *)XqnmBAqvweIzpZyHs :(nonnull NSArray *)wbcmuIiHSmtZlhB :(nonnull NSString *)MKvRwpekvjDBpXX {
	NSDictionary *gGNLaEsCNpo = @{
		@"YshaqSrvvffCWdxTm": @"CGMJmbjOwANDveKgTeAlANWwElMXANlXKfqewyvTiahaYgEmzXVcccZbTgcdHDngEGwLlmXoFbPbfpBRCClKuJrQXTYKQnbwmGcQQqfgtnlguVwAYlXSBOprhGeeolrRTOhwgPoArXAI",
		@"faxoarvUToIndpYvMu": @"zjGEveOAayPUezlmUlLpUGCTusHXbEKbiOInoZDpLjVOcerNXzgTDGXJgRUvrwdSpvaJPRkxuiXplkTzfiXgaqdDaCdHIaFAgTgpGqxpCbDkjBnPbSjUlSoVRrqvGfmJDalRtCcIdcXaVBitCMj",
		@"TqLnKpRbHao": @"FnIzjsGZJzUNwGJSVJgTFImAyJMfeJwSdqrqPIQRdiENuegyYNjXMjxkYQWtDBbDmssJLCTcFLgzKWYdOlLbNIGEijxBDcENkhZzOacviomcyzr",
		@"nQALZUmrSaSKWGaA": @"sCmUseEWBpMXBjHEpHtnNpFeJznheOfOEWTeLXobzsVVklcVkMDUlKpuXXobyByyTsekEIbeiukKNVlxdduiKpatTJuxqtwBARpELnc",
		@"iGbBPgxFaTfaD": @"UAfFRWpAOvDDXwRqwnHjSOMnHSYaQkZBYuVilvarTajWPIihsrdXKgqyHDMRLmzvEsJhQgLnaxBkHcTmwaQZnAvrJzbxACVUvjNAXBVNUEjUdCZbvDYpJiyGMaBXkOwSpiPXKPSZDTl",
		@"yzusFantqfFq": @"dknZliVSSJxiQDVEqBDHyubPrOtnPlOxhUmkvZhwbYkXmNrXtqSocibGPdaFDlOXTAkiLuuFAzNtVnMNysIzAByorNuNpOibRLxXWkcMnZgaboiYehaniWXeqxNTdYQOJQsvUyUEfKhwOZocD",
		@"SeKqoeDqLbMN": @"eETfpLOwnmzoWSwmMiCtZzuOmUftPFelrMkpzIAoEZtqqNPVeODwEQjjipNEookDnzmWvqrxBEGiCNTAaYzmISBkbGWVxxcmkodoVBPpTDwSIGUxZmcEObHrmMtSXOlxFMMKMNOoQMptoT",
		@"jzhrkKdwbCSEkjYen": @"fpxsHPlNRxdvWgPygDvnRoEcRJZfwVqMZuLPMnaRMKjjWOphaqxFPvjxqdrYjEikLZHOGiQuAEVcIhhWoshouUJvXtfivaOkvfGIRISpmUoBYNLZhxVDRlxSsDpRELGMdONKjjCUVOYUSsY",
		@"erHbULfAsBLanNI": @"aZpewZbCrgEfzABCBoGXHlxWGQnkauZAwhNWheCkkjFgjPxzRPxBggNSiiZWiKFZbeiKfmPnJXtmSDnhwYCPRVDLpDgOeAAgUdJnMC",
		@"GzjwmOszGdnKZwlYQGa": @"DVPnkVPCCIwhOZQtwaRtvCRjdwHtdizEOTVDAhPpQoiLDqXWGGtVXSQRYPtLLDvLPXLYyiMhlpWfsnTJUrqNhXXLqRVPVHGExjeGoJtmPWehhZtDcKwHUkEbFFI",
		@"fnxJbuqFoSftihNU": @"xdJOCkHhqbacimrFXFbBzzzejtCDYhSOWtwyiDJjIOuWUmiCrCTMkzKGpReLhNLPzlfewTNKjlZtFJsEjUhTWfYkjWlghMiSsMcdNiqaaRTtqznlZopklVyeeamlCwcauuacGgBw",
		@"OrAuqnulqtgXYFdweTG": @"WKMOSYRPhzIxXUaZnUIXmRbSSYgQfmourliwBjpzZDJnZsAkjpALgZyNtTTaBvBsuhbMCcraLxFSOwSUbOPHRZhalfzgAGpWjrAyunnwxaRZrvNFSyQxXxmv",
	};
	return gGNLaEsCNpo;
}

- (nonnull NSData *)bJRsxjLKZX :(nonnull NSDictionary *)PXVMKjCKlu {
	NSData *EftUDNOgYcoeCCq = [@"iPhiwWRBGhRnvYYRvIIOhdHQsilsOLiiJrNLUsVekcmYiGZAIIPTBYAUaHzPRpavOuspENrnanaOEOmbpmkURrRJhJfCnaXJxQKsrYOtYQvMLSxbPdLhfgWXaPmpZCj" dataUsingEncoding:NSUTF8StringEncoding];
	return EftUDNOgYcoeCCq;
}

- (void)dismissOverlayView:(id)sender{
    [self selfRemoveFromSuperview];
}

/**
 *  @author Whde
 *
 *  从父视图中移出
 */
- (void)selfRemoveFromSuperview{
    [session removeObserver:self forKeyPath:@"running" context:nil];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

/*!
 */
- (void)setDidReceiveBlock:(QRCodeDidReceiveBlock)didReceiveBlock {
    _didReceiveBlock = [didReceiveBlock copy];
}

@end
