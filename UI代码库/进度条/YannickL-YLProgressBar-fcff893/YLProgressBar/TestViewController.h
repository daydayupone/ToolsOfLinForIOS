//
//  TestViewController.h
//  YLProgressBar
//
//  Created by Ibokan on 13-6-24.
//  Copyright (c) 2013年 Yannick Loriot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLProgressBar.h"
@interface TestViewController : UIViewController{
@protected
NSTimer*    progressTimer;
}
@property (retain, nonatomic) IBOutlet YLProgressBar *testBar;
@property (retain, nonatomic) IBOutlet UILabel *testLabel;

@end
