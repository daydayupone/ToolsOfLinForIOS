//
//  refreshViewController.h
//  UI0013框架
//
//  Created by ibokan on 13-6-9.
//  Copyright (c) 2013年 Miguel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface refreshViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableDelegate>
{
    EGORefreshTableHeaderView *tblHeader;
    BOOL _reloading;
}
@property(retain,nonatomic)UITableView *tbl;
@property(retain,nonatomic)NSMutableArray *ary;
@end
