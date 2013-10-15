//
//  TableViewController.h
//  Safari
//
//  Created by ibokan on 13-6-6.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain,nonatomic) NSMutableArray *urlData;//存储数据库的内容

@property (retain, nonatomic) IBOutlet UITableView *table;

@end
