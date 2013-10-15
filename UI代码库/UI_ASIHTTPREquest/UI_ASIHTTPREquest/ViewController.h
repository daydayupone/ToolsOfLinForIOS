//
//  ViewController.h
//  UI_ASIHTTPREquest
//
//  Created by ibokan on 13-6-9.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface ViewController : UIViewController<ASIHTTPRequestDelegate>

@property (retain, nonatomic) IBOutlet UIImageView *myImage;

@property (retain, nonatomic) IBOutlet UIImageView *mySecond;
@end
