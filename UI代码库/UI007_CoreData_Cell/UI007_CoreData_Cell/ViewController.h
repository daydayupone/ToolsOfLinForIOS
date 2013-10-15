//
//  ViewController.h
//  UI007_SQList
//
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>//UITable的两协议，之后的代理将会用到

//声明UITableView
@property (retain,nonatomic) UITableView *tableView;
//用于展示学生信息的数组
@property (retain,nonatomic) NSArray *stuArray;
//代理对象
@property (retain,nonatomic) AppDelegate *myDelegate;



@end
