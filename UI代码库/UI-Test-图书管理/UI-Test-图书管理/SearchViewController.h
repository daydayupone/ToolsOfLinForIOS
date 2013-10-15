//
//  SearchViewController.h
//  UI-Test-图书管理
//
//  Created by ibokan on 13-5-30.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController< NSURLConnectionDataDelegate >

@property (retain, nonatomic) IBOutlet UITextField *textField;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property(retain,nonatomic)NSMutableData  *finalData;
@end
