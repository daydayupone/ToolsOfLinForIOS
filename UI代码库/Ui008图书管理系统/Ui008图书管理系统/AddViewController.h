//
//  AddViewController.h
//  Ui008图书管理系统
//
//  Created by ibokan on 13-5-24.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *txt1;

@property (retain, nonatomic) IBOutlet UITextField *txt2;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@end
