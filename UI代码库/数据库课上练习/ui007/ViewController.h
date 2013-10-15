//
//  ViewController.h
//  ui007
//
//  Created by 颜振洋 on 13-5-22.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(retain,nonatomic)UITableView*tv;
@property(retain,nonatomic)NSArray*stuArray;//用于存储显示表格内的内容




@property(retain,nonatomic)UIRefreshControl*vc;
@property (nonatomic) NSInteger count;
@end
