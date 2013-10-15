//
//  SecondViewController.h
//  UINavigationController
//
//  Created by ibokan on 13-5-20.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import <UIKit/UIKit.h>

//——————————————————使用代理
//通过代理的方式实现更改其他类上的数据
//调用者的协议
@protocol ChangeBtnTitle <NSObject>
//修改btn的标题的协议
- (void) setBtnTitle:(NSString *)title whitTag:(int) tag;
@end


@interface SecondViewController : UIViewController<UITextFieldDelegate>//文本框代理

@property (retain,nonatomic) UIImageView *imgV;

//声明一个UILable
@property (retain,nonatomic) UITextField *textField;
@property (retain,nonatomic) UIButton *button,*button1;

@property (retain ,nonatomic) id<ChangeBtnTitle> delegate;//加入实现协议的代理对象

@property (assign,nonatomic) int btnTag;//用于接收另外一个类的属性变化

@end
