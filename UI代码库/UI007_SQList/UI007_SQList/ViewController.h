//
//  ViewController.h
//  UI007_SQList
//
//  Created by ibokan on 13-5-22.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>//UITable的两协议，之后的代理将会用到

//声明UITableView
@property (retain,nonatomic) UITableView *tableView;

//用于展示学生信息的数组
@property (retain,nonatomic) NSArray *stuArray;

@end
