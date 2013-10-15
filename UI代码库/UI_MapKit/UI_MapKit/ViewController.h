//
//  ViewController.h
//  UI011
//
//  Created by ibokan on 13-6-7.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>//导入定位框架头文件
#import <MapKit/MapKit.h>//导入地图框架头文件
#import "MyAnnotation.h"

@interface ViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>//导入定位协议、地图协议
{
    float x;//经度
    float y;//纬度
    //搜索结果
    float x1;//
    float y1;//
       
}

//实现地图定位的管理
@property (retain,nonatomic) CLLocationManager * lm;
//地图的属性
@property (retain,nonatomic) MKMapView * mv;
@property (retain,nonatomic) UITableView *show;
@property (retain,nonatomic) NSArray *jeson1;
//
//搜索框
@property (retain,nonatomic) UITextField *search;
//按键
@property (retain,nonatomic) UIButton *searchButton;
//视图
@property (retain,nonatomic) UIView *addSome;

@property (retain,nonatomic) MyAnnotation *ann;

@end
