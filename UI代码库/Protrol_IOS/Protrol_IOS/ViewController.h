//
//  ViewController.h
//  Protrol_IOS
//
//  Created by ibokan on 13-6-21.
//  Copyright (c) 2013年 zzl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetImageView.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SetImageView>

@property (retain,nonatomic) UITableView *table;
@property (retain,nonatomic) UIImageView *imgView;

@end
