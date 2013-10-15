//
//  ViewController.h
//  WeiPhoneNewsWeb
//
//  Created by 颜振洋 on 13-6-16.
//  Copyright (c) 2013年 颜振洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "EGORefreshTableHeaderView.h"//下拉刷新
#import "EGORefreshTableFooterView.h"//上拉刷新
@interface ViewController : UIViewController<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate,EGORefreshTableDelegate>
{
    //    EGORefreshTableHeaderView*_refreshHeaderView;
    //    EGORefreshTableFooterView*_refreshFooterView;
    BOOL _reloading;
}
@property (retain,nonatomic) EGORefreshTableHeaderView *refreshHeaderView;
@property (retain,nonatomic) EGORefreshTableFooterView *refreshFooterView;

@property(retain,nonatomic)UITableView*table;
@property(assign,nonatomic)int page;
@property(retain,nonatomic)NSArray*newsTitleArray,*lookNoArray,*dateArray,*webArray,*imgWebArray,*wordArray;
@property(retain,nonatomic)NSMutableArray*newsTitleArrayN,*lookNoArrayN,*dateArrayN,*webArrayN,*imgWebArrayN;

//排序
@property(retain,nonatomic)NSMutableArray*newsArrayN;
@property(retain,nonatomic)NSArray*sortedDateArray;


-(void)getData:(int)page;
-(NSArray*)sortedDate;
@end
