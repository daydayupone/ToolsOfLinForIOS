//
//  ViewController.h
//  IOS_MVC
//
//  Created by ibokan on 13-6-21.
//  Copyright (c) 2013年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain,nonatomic) NSArray *stuArray;

@end
