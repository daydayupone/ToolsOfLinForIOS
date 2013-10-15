//
//  ViewController.m
//  UI011
//
//  Created by ibokan on 13-6-7.
//  Copyright (c) 2013年 赵明强. All rights reserved.
//

#import "ViewController.h"
#import "MyAnnotation.h"//导入注解类
#import "JSON.h"//导入json解析的第三方库，用于解析来自网络的数据


@interface ViewController ()
@end
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //判断设备是否开启地图定位功能（设置），开启就能进行以下操作
    if ([CLLocationManager locationServicesEnabled])
    {
        //创建定位管理器
        self.lm = [[CLLocationManager alloc]init];
        //设置代理
        self.lm.delegate = self;
        //设置定位的精度
        self.lm.desiredAccuracy = kCLLocationAccuracyBest;
        //设置距离筛选器
        self.lm.distanceFilter = 5;
        //开始更新定位信息
        [self.lm startUpdatingLocation];
    }

    //设置地图属性
    self.mv = [[MKMapView alloc]initWithFrame:self.view.frame];
    //将地图贴在当前视图上
    [self.view addSubview:self.mv];
    //设置地图样式
    self.mv.mapType = MKMapTypeStandard/*地图样式，标准地图*/;
    //self.mv.mapType = MKMapTypeSatellite/*卫星地图*/;
    //self.mv.mapType = MKMapTypeHybrid/*交通地图*/;
    //current location标示点
   
    //显示设备当前的坐标
    self.mv.showsUserLocation = YES;//注释掉该行代码，蓝色的坐标定位将消失
   
    //给地图添加代理
    self.mv.delegate = self;
    
    //用于显示附近信息的列表
    self.show = [[UITableView alloc]initWithFrame:CGRectMake(0, 460, 320, 120) style:UITableViewStyleGrouped];
    //设置代理
    self.show.delegate = self;
    self.show.dataSource = self;
    [self.view addSubview:self.show];

    //搜索框和它的按钮
    self.addSome = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 44)];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav.png"]];
    [self.mv addSubview:self.addSome];
    
    self.search = [[UITextField alloc]initWithFrame:CGRectMake(5, 2, 140, 40)];
    [self.addSome addSubview:self.search];
    
    self.searchButton = [UIButton buttonWithType:1];
    self.searchButton.frame = CGRectMake(145, 2, 75, 40);
    [self.searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [self.addSome addSubview:self.searchButton];
    
    
    [self.addSome release];
    [self.search release];
}





//定位协议的代理方法，当位置更新时调用代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //位置信息
    NSLog(@"经度=%lf,纬度=%lf",newLocation.coordinate.longitude,newLocation.coordinate.latitude);
    x = newLocation.coordinate.longitude;
    y = newLocation.coordinate.latitude;
    
    
    //设置地图的中心点
    self.mv.region = MKCoordinateRegionMake(newLocation.coordinate, MKCoordinateSpanMake(0.01, 0.01));//0.01大概是一个市，0.1大概是一个省
    //定位成功，停止定位更新 (防止不必要的重复更新)
    [manager stopUpdatingLocation];
    
    //添加注解(大头针)
    MyAnnotation *ann = [[MyAnnotation alloc]init];
    //注解的坐标
    
    ann.coordinate = newLocation.coordinate;
    
    ann.title = @"哥斯达黎加";
    ann.subtitle = @"小国家";
    //将注解添加进当前的地图页面
    [self.mv addAnnotation:ann];
    
}

//地图代理方法,定义注解视图
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    for (MKPinAnnotationView *view in views) {
        //判断大头针的信息是否等于CurrentLocation，是的话继续
        if ([view.annotation.title isEqualToString:@"Current Location"]) {
            continue;
        }
        
        //如何使注解内容自动显示
        [mapView selectAnnotation:view.annotation animated:YES];
        //设置大头针的颜色
        view.pinColor = MKPinAnnotationColorGreen;

        //为大头针显示的详细内容设置一些按钮
        //创建按钮1
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        view.rightCalloutAccessoryView = btn1;
        
        //创建按钮2
        UIButton *btn2 = [UIButton buttonWithType:0];
        btn2.frame = CGRectMake(0, 0, 40, 30);
        [btn2 setBackgroundImage:[UIImage imageNamed:@"附近.png"] forState:UIControlStateNormal];
        //按钮触发事件
        [btn2 addTarget:self action:@selector(jsonButton) forControlEvents:UIControlEventTouchUpInside];
        view.leftCalloutAccessoryView = btn2;
        
        
        
        
    }
}

//解析按钮的方法
- (void)jsonButton
{
    //坐标解析接口：http://api.jiepang.com/v1/locations/search?lat=39.916&lon=116.393&count=2&source=100000
    
    NSLog(@"开始解析");
    
    //同步下载
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.jiepang.com/v1/locations/search?lat=%f&lon=%f&count=2&source=100000",y,x]];
    NSLog(@"%@",url);
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
                  
    NSData *getData = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];
    
    NSLog(@"%@",getData);
    
    //对获得的网络数据进行json解析
    //开始解析
    //IOS5自带解析类NSJSONSserialization从getData解析出数据放到字典里
    NSDictionary *dataJeson = [NSJSONSerialization JSONObjectWithData:getData options:NSJSONReadingMutableLeaves error:nil];
    //NSDictionary *jeson = [dataJeson objectForKey:@"items"];
    self.jeson1 = [dataJeson objectForKey:@"items"];
    NSDictionary *jeson2 = [self.jeson1 objectAtIndex:0];
    NSString *city = [jeson2 objectForKey:@"name"];
    
    NSLog(@"使用IOS自带的JSON的解析结果 -> %@",city);

    //注意：要重新加载数据，否则数据无法显示在单元格上
    [self.show reloadData];
    [self up];
   

    
}

//--------单元格的代理方法

//说明表格分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}
//每个分区中的单元格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //判断数组是否可用，
    //return self.jeson1?self.jeson1.count:0;
    return self.jeson1.count;
    NSLog(@"%lu",(unsigned long)self.jeson1.count);
}

//定义每个单元格的具体内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";//重用标示
    //重用方式获取单元格对象
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //判断是否能获取重用单元个
    if (cell==nil) {
        //创建单元个，单元格样式是子标题样式
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //获得数组之中的数据内容
    NSDictionary *dic1 = [self.jeson1 objectAtIndex:indexPath.row];
    NSString *name = [dic1 objectForKey:@"name"];
    cell.textLabel.text = name;
    
    return cell;
}

//设置单元格
- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

//单元格弹出动画
bool flag = YES;
- (void)up
{
    if (flag == YES) {
        [UIView animateWithDuration:1 animations:^{
            self.show.center = CGPointMake(320/2, 400);
        }];
        flag = NO;
    }
    else
    {
        [UIView animateWithDuration:1 animations:^{
            self.show.center = CGPointMake(320/2, 520);
        }];
        flag = YES;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
