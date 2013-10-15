//
//  ViewController.h
//  UI10_AVPlayer
//
//  Created by ibokan on 13-6-5.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<AVAudioPlayerDelegate>

@property (retain,nonatomic) AVAudioPlayer *av;
@property (retain,nonatomic) UIProgressView *pv;
@property (retain,nonatomic) NSTimer *tm;
@property (assign,nonatomic) int flag;
@property (retain,nonatomic) UIButton *stop;

@end
