//
//  ThireViewController.h
//  UI009_UITabBarContrallor
//
//  Created by ibokan on 13-5-27.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThireViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>//导入表格的两个代理

@property (retain,nonatomic) NSArray *strArray,*filteredArray;
@property (retain,nonatomic) UITableView *tabelView;
@property (retain,nonatomic) UISearchBar *searchBar;
@end
