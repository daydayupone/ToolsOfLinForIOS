//
//  ViewController.h
//  Safari
//
//  Created by ibokan on 13-6-4.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate,UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UIWebView *myWeb;
@property (retain, nonatomic) IBOutlet UITextField *search;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *go;

@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activit;



@end
