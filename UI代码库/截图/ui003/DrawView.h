//
//  DrawView.h
//  ui003
//
//  Created by 颜振洋 on 13-5-10.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView
@property(retain,nonatomic)NSMutableArray*lineArray;//创建线数组存储点数组，点数组在触摸开始时创建。
@end
