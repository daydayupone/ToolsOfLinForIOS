//
//  ViewController.h
//  map
//
//  Created by ibokan on 13-6-7.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>//定位坐标
#import <MapKit/MapKit.h>//地图
#import "MyAnnotation.h"
#import "JSON.h"

@interface ViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate,NSURLConnectionDelegate,UITableViewDataSource,UITableViewDelegate>
@property(retain,nonatomic) CLLocationManager* lm;
@property(retain,nonatomic) MKMapView * mv;
@property (retain, nonatomic) NSMutableData * data;
@property(retain,nonatomic) UITableView * tview;
@property(retain,nonatomic) NSArray * tdata;
@property(retain,nonatomic) UITextField * key;
@property(assign,nonatomic) BOOL flag;
@property(retain,nonatomic) UIButton *ret;
@end
