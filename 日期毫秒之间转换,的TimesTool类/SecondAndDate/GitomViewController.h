//
//  GitomViewController.h
//  SecondAndDate
//
//  Created by jiawei on 13-10-10.
//  Copyright (c) 2013年 GitomLJYU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GitomViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *anDate;
@property (weak, nonatomic) IBOutlet UITextField *seconds;
@property (weak, nonatomic) IBOutlet UITextField *seconds01;
@property (weak, nonatomic) IBOutlet UITextField *anDate01;

@end
