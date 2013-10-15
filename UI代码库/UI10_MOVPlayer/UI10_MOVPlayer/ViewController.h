//
//  ViewController.h
//  UI10_MOVPlayer
//
//  Created by ibokan on 13-6-5.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@interface ViewController : UIViewController<MPMediaPickerControllerDelegate>

@property (retain,nonatomic) MPMoviePlayerViewController *player;
@property (retain,nonatomic) UIView *playView;
@end
