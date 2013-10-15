//
//  MyAnnotation.h
//  UI011
//
//  Created by ibokan on 13-6-8.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>//导入map框架


@interface MyAnnotation : NSObject<MKAnnotation>//导入协议


/*
 @property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
 @property (nonatomic, readonly, copy) NSString *title;
 @property (nonatomic, readonly, copy) NSString *subtitle;
 */
//以下是从<MKAnnotation>//导入协议的API中复制过来的，只是将他们的readonly都删除了
//这是重定义：
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
