//
//  ViewController.h
//  Ui008图书管理系统
//
//  Created by ibokan on 13-5-24.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(retain,nonatomic)UITableView *tableView;
@property(retain,nonatomic)NSMutableArray *bookArray;

@property(retain,nonatomic)UISearchBar *sb;
@property(retain,nonatomic)NSArray *filteredArray;
@end
