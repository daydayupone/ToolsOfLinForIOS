//
//  AddViewController.h
//  UI007_SQList
//
//  Created by ibokan on 13-5-23.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//添加界面

@interface AddViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *stuName;
@property (retain, nonatomic) IBOutlet UITextField *stuPone;
@property (retain, nonatomic) IBOutlet UITextField *stuNumber;

//代理的属性
@property (retain,nonatomic ) AppDelegate *myDelegate;


@end
