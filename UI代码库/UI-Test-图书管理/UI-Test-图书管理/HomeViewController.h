//
//  HomeViewController.h
//  UI-Test-图书管理
//
//  Created by ibokan on 13-5-30.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(retain,nonatomic)UITableView *tableView;
@property(retain,nonatomic)NSMutableArray *bookArray;


@end
