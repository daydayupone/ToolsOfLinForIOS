//
//  UpdateViewController.h
//  Ui008图书管理系统
//
//  Created by ibokan on 13-5-24.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateViewController : UIViewController<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *txt1;
@property (retain, nonatomic) IBOutlet UITextField *txt2;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property(assign,nonatomic)int bookId;

@end
