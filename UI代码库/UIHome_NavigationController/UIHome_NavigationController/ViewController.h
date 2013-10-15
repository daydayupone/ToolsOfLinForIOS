//
//  ViewController.h
//  UIHome_NavigationController
//
//  Created by ibokan on 13-5-20.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SecondeViewController.h"//导入头文件后才能使用该头文件的协议

@interface ViewController : UIViewController <ChangeName,UITextFieldDelegate>//前者为自定义协议，后者为ios提供的协议

@property (retain,nonatomic) UITextField *myText;//以后的开发中，要将除了Button的视图组件写如属性


@end
