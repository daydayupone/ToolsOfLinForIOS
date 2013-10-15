//
//  ViewController.h
//  UI01
//
//  Created by ibokan on 13-5-8.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>//键盘切换协议

//创建计数器要用的属性
@property (retain,nonatomic) UITextField *text1;
@property (retain,nonatomic) UITextField *text2;
@property (retain,nonatomic) UILabel *label1;
@property (retain,nonatomic) UILabel *label2,*label3;


@end
