//
//  Jietu.h
//  ui003
//
//  Created by 颜振洋 on 13-5-10.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Jietu : UIView
@property(assign,nonatomic)CGPoint pt1,pt2;//创建线数组存储点数组，点数组在触摸开始时创建。
@property(retain,nonatomic)UIImage*img1;
@property(retain,nonatomic)UIImageView*vimg;
@end
