//
//  MyAnnotation.h
//  map
//
//  Created by ibokan on 13-6-8.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MyAnnotation : NSObject<MKAnnotation>
@property(nonatomic)CLLocationCoordinate2D coordinate;
@property(nonatomic,copy)NSString *title,*subtitle;
@end
