//
//  AddViewController.h
//  UI-Test-图书管理
//
//  Created by ibokan on 13-5-30.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *bookName;
@property (retain, nonatomic) IBOutlet UITextField *bookPublisher;
@property (retain, nonatomic) IBOutlet UITextField *bookdate;
@property (retain, nonatomic) IBOutlet UITextField *bookAuthor;
@property (retain, nonatomic) IBOutlet UITextField *bookIntro;

@property (retain, nonatomic) IBOutlet UIImageView *bookFaceImage;

@end
