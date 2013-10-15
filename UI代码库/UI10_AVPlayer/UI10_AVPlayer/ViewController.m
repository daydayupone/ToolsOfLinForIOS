//
//  ViewController.m
//  UI10_AVPlayer
//
//  Created by ibokan on 13-6-5.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize av,pv,tm,flag,stop;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //获取文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"复活" ofType:@"mp3"];
    //url 和 path 本质上都是文件路径。
    //将path 的文件路径存储进url
    NSURL *url = [[NSURL alloc]initFileURLWithPath:path];
    //通过路径获取本地MP3文件，播放
    self.av = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    self.av.delegate = self;//添加代理
    [self.av play];
    
    //音量控制组件
    UISlider *volume = [[UISlider alloc]initWithFrame:CGRectMake(50, 150, 150, 20)];
    volume.value = 1;
    volume.transform = CGAffineTransformMakeRotation(-M_PI_2);//旋转组件
    [self.view addSubview:volume];
	[volume addTarget:self action:@selector(changeVolume:) forControlEvents:UIControlEventValueChanged];//设置组件的响应事件-声音大小
    
    //进度条
     self. pv = [[UIProgressView alloc]initWithFrame:CGRectMake(5, 400, 310, 20)];
    [self.view addSubview:self.pv];
    
    //实例一个计时器，每0.1秒
    self.tm = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(showtime:) userInfo:nil repeats:YES];
    
    //停止按键
    stop = [UIButton buttonWithType:1];
    stop.frame = CGRectMake(120, 410, 40, 40);
    [stop setBackgroundImage:[UIImage imageNamed:@"Stop1.png"] forState:UIControlStateNormal];
    [self.view addSubview:stop];
    
    [stop addTarget:self action:@selector(stopm ) forControlEvents:UIControlEventTouchUpInside];
    
    //标记
    self.flag = 0;
    
}

//
- (void)showtime:(id)sender
{
    //显示播放进度
    self.pv.progress = ((double)self.av.currentTime)/*防止精度丢失，进行double的强转*//self.av.duration;
    
    //显示播放的时间
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(5, 410, 60, 30)];
    
    time.text = [NSString stringWithFormat:@"%.2f",self.av.currentTime];//在lable上显示播放的时间
    [self.view addSubview:time];
    
    
    
    

}



//通过音量控制组件的值确定音量
- (void)changeVolume:(UISlider *)sender
{
    self.av.volume = 1;
    self.av.volume = sender.value;//通过音量控制组件的值确定音量
}

//<AVAudioPlayerDelegate>代理方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.tm invalidate];//停止计时
}

//停止、播放按键
- (void)stopm
{
    if (self.flag == 0) {
        [self.av stop];
        [stop setBackgroundImage:[UIImage imageNamed:@"start1.png"] forState:UIControlStateNormal];
        
        self.flag = 1;
    }else if (self.flag == 1) {
        [self.av play];
        [stop setBackgroundImage:[UIImage imageNamed:@"Stop1.png"] forState:UIControlStateNormal];
        self.flag = 0;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
