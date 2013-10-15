//
//  FevoreViewController.h
//  Safari
//
//  Created by ibokan on 13-6-5.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FevoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain,nonatomic) NSMutableArray *urlData;//存储数据库的内容
@property (retain,nonatomic) UITableView *urlTable;//存放网站的列表

@end
