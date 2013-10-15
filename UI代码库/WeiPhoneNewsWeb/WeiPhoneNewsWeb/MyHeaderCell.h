//
//  MyHeaderCell.h
//  Weiphone
//
//  Created by 颜振洋 on 13-6-13.
//  Copyright (c) 2013年 颜振洋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "Header.h"
@interface MyHeaderCell : UITableViewCell<ASIHTTPRequestDelegate,UIScrollViewDelegate>
@property(retain,nonatomic)UIScrollView *scrollView;
@property(retain,nonatomic)UIPageControl*page;
@property(retain,nonatomic)UIImageView*imgView;
@property(retain,nonatomic)NSArray*imgArray,*imgWebArray,*wordArray;
@property(retain,nonatomic)NSMutableArray*imgArrayN,*imgWebArrayN,*wordArrayN;
@property(assign,nonatomic)int index;
@property (retain,nonatomic) UILabel *underLabel,*underLabel1;
@property(retain,nonatomic)Header*head;
@end
