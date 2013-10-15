//
//  EGOViewController.h
//  UI_ASIHTTPREquest
//
//  Created by ibokan on 13-6-9.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface EGOViewController : UIViewController<EGORefreshTableDelegate,UITableViewDataSource,UITableViewDelegate>//导入协议
{
    EGORefreshTableHeaderView *refreshHeaderView;
    BOOL _reloading;//用来判断是否进行数据刷新
}

@property (retain,nonatomic) UITableView *myTableView;//单元格
@property (retain,nonatomic) NSMutableArray *dataArray;


@end
