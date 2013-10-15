//
//  SecondeViewController.h
//  UIHome_NavigationController
//
//  Created by ibokan on 13-5-20.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义一个协议
@protocol ChangeName <NSObject>

- (void) changeTitle:(NSString *)title;

@end


@interface SecondeViewController : UIViewController


@property (retain,nonatomic) UITextField *myText;
//导入实现协议内容的代理
@property (retain,nonatomic) id<ChangeName> delegate;

@end
