//
//  UpdateViewController.h
//  UI007_SQList
//
//  Created by ibokan on 13-5-23.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateViewController : UIViewController<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *stuName;
@property (retain, nonatomic) IBOutlet UITextField *stuPhone;

//获取学生编号
@property (assign,nonatomic) int sid ;

//@property (retain,nonatomic) id<UITextFieldDelegate>;
@end
