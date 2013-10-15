//
//  AddViewController.h
//  ui007
//
//  Created by 颜振洋 on 13-5-23.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (retain, nonatomic) IBOutlet UITextField *txt1;
@property (retain, nonatomic) IBOutlet UITextField *txt2;
@property (retain, nonatomic) IBOutlet UIImageView *xianshiimgView;



@end
