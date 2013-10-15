//
//  XpathViewController.h
//  UI0013框架
//
//  Created by ibokan on 13-6-9.
//  Copyright (c) 2013年 Miguel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface XpathViewController : UIViewController<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate>
@property(retain,nonatomic)UITableView *tbl;
@property(retain,nonatomic)NSMutableArray *namearr;

@end
