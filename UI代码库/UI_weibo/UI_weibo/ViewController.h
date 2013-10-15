//
//  ViewController.h
//  UI_weibo
//
//  Created by ibokan on 13-6-4.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myCell.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CGSize labelsize;//responseLabel的高
}
//数组属性
@property (retain,nonatomic) NSMutableArray *weiboArray;
//单元格属性
@property (retain,nonatomic) UITableView *tbl;
@property (retain,nonatomic) myCell *cell;

@end
