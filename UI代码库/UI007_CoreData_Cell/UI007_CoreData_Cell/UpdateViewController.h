//
//  UpdateViewController.h
//  UI007_SQList
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface UpdateViewController : UIViewController<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *stuName;
@property (retain, nonatomic) IBOutlet UITextField *stuPhone;
@property (retain, nonatomic) IBOutlet UITextField *stuNumber;

//获取学生编号
@property (assign,nonatomic) int sid ;
//代理AppDelegate的对象
@property (retain,nonatomic) AppDelegate *myDelegate;

@end
