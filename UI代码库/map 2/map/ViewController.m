//
//  ViewController.m
//  map
//
//  Created by ibokan on 13-6-7.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    self.flag = NO;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //如果定位器可用
    if ([CLLocationManager locationServicesEnabled]) {
        //实例一个定位器
        self.lm = [[CLLocationManager alloc]init];
        self.lm.delegate = self;
        //设置定位器的样式
        self.lm.desiredAccuracy = kCLLocationAccuracyBest;
        //定位显示的范围
        self.lm.distanceFilter = 100;
        //开始更新定位，跟着设备的移动更新坐标
        [self.lm startUpdatingLocation];
    }
    //实例一个地图
    self.mv = [[MKMapView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.mv];
    //self.mv.mapType = MKMapTypeHybrid;
    //显示设备的位置
    self.mv.showsUserLocation = YES;
    
    //创建一个单元格，用于显示附近的建筑物
    self.tview = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44)];
    self.tview.center = CGPointMake(self.tview.center.x, self.tview.center.y+self.tview.frame.size.height);
    self.tview.delegate = self;
    self.tview.dataSource = self;
    [self.view addSubview:self.tview];
    
    //放搜索栏的视图
    UIView *uv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    uv.backgroundColor = [UIColor whiteColor];
    [uv.layer setShadowColor:[UIColor blackColor].CGColor];//设置阴影效果，注意：要导入QuartzCore框架才能使用阴影效果
    [uv.layer setShadowOffset:CGSizeMake(5, 5)];
    [uv.layer setShadowOpacity:.7];
    [self.view addSubview:uv];
    self.key = [[UITextField alloc]initWithFrame:CGRectMake(70, 8, 180, 28)];
    self.key.borderStyle = UITextBorderStyleRoundedRect;
    [uv addSubview:self.key];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(260, 8, 50, 28);
    [btn setTitle:@"查询" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(seach:) forControlEvents:UIControlEventTouchUpInside];
    [uv addSubview:btn];
    
    self.ret = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.ret.frame = CGRectMake(4, 8, 50, 28);
    [self.ret setTitle:@"返回" forState:UIControlStateNormal];
    [self.ret addTarget:self action:@selector(ret:) forControlEvents:UIControlEventTouchUpInside];
    self.ret.hidden = YES;
    [uv addSubview:self.ret];
}

-(void)seach:(id)sender{
    NSLog(@"%@",self.key.text);
    self.flag = YES;
    //异步解析
    //将网站转换为字符串
    NSString *urlString= [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?address=%@&sensor=true&hl=zh-CN",self.key.text];
    //中文转码
    NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)urlString, NULL, NULL,  kCFStringEncodingUTF8 );
    //获得网络下载路径
    NSURL *url = [NSURL URLWithString:encodedString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    //异步代理，注意：导入协议：NSURLConnectionDelegate
    [NSURLConnection connectionWithRequest:req delegate:self];
}

//中心点移动动画效果的方法
-(void)ret:(UIButton *)sender{
    [UIView beginAnimations:@"ret" context:nil];
    self.tview.center = CGPointMake(self.tview.center.x, self.tview.center.y+self.tview.frame.size.height);
    [UIView commitAnimations];
    self.ret.hidden = YES;
}

//刷新坐标的方法：清楚旧坐标，出现新坐标
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    //停止坐标的更新
    [manager stopUpdatingLocation];
    NSLog(@"经度:%lf,纬度:%lf",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    //地图的中心点与新坐标的点相等，保证了当前坐标处于屏幕的中央
    self.mv.centerCoordinate = newLocation.coordinate;
    
    self.mv.region = MKCoordinateRegionMake(newLocation.coordinate, MKCoordinateSpanMake(0.01, 0.01));
    
    MyAnnotation * ma = [[MyAnnotation alloc]init];
    ma.coordinate = newLocation.coordinate;
    ma.title = @"现在我在哪里";
    ma.subtitle = @"呵呵";
    //设置 MKMapViewDelegate的代理
    self.mv.delegate = self;
    [self.mv addAnnotation:ma];
}

- (void)setRegion:(MKCoordinateRegion)region animated:(BOOL)animated
{
    
}


-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    //如果大头针是在视图里，进入以下循环体
    for (MKPinAnnotationView *view in views) {
        
        //如果大头针的题目和Current Location一样，那么进入下一步
        if ([view.annotation.title isEqualToString:@"Current Location"]) {
            continue;
        }
        
        //大头针的颜色
        view.pinColor = MKPinAnnotationColorGreen;
        
        //大头针的弹出的提示框的内容
        //显示详情连接的按钮，在提示框的右边
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        view.rightCalloutAccessoryView = btn;
        
        //显示附近建筑物的按键，添加在提示框的左边
        UIButton *btn1 = [UIButton buttonWithType:0];
        btn1.frame = CGRectMake(0, 0, 50, 30);
        [btn1 setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
        view.leftCalloutAccessoryView = btn1;//将按钮加入到被招呼出的地图附近的左边
        
        //提示框自动弹出
        [self.mv selectAnnotation:view.annotation animated:YES];
    }
}

//异步连接NSURLConnectionDelegate协议的3个代理方法
-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"start download");
    //初始化_data对象
    self.data = [[NSMutableData alloc]init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)d{
    //下载图片
    [self.data appendData:d];
}

//数据下载完，进行解析
-(void)connectionDidFinishLoading:(NSURLConnection*)connection{
    NSLog(@"end download");
    //将下载好的数据转换为字符串类型，以备json 解析
    NSString *str = [[NSString alloc]initWithData:self.data encoding:NSUTF8StringEncoding];
    //将字符串转换成json类型的数据，准备开始异步连接
    NSDictionary * nd =  [str JSONValue];
    
    //本程序有两个异步连接，考虑到异步连接是公用一套异步代理方法，为了防止两个异步连接的相互冲突，我们可以通过标记的方法将他们区分开：此处使用BOOL实例对象flag的YES、NO来进行区分的。
    
    if (self.flag) {//self.flag=YES时候，进行搜索框输入的地名的解析
        NSLog(@"异步解析-----");
        NSArray * nsa = [nd objectForKey:@"results"];
        if (nsa.count>0) {
            NSDictionary * addr = [nsa objectAtIndex:0];
            //解析json
          
            //获得全称
            NSString * name = [[[addr objectForKey:@"address_components"]objectAtIndex:0]objectForKey:@"long_name"];
            //获得简称
            NSString * sname = [[[addr objectForKey:@"address_components"]objectAtIndex:0]objectForKey:@"short_name"];
            //获得坐标
            NSDictionary * location = [[addr objectForKey:@"geometry"]objectForKey:@"location"];
            //分别获得经、纬坐标
            NSNumber * lat = [location objectForKey:@"lat"];
            NSNumber * lng = [location objectForKey:@"lng"];
            
            //将坐标转换成大头针可用的坐标类型
            CLLocationCoordinate2D coor;//数据结构的声明是不需要allox、init的
            coor.latitude = [lat floatValue];
            coor.longitude = [lng floatValue];
            
            //大头针移动的动画
            [UIView animateWithDuration:1.0 animations:^{
                self.mv.centerCoordinate = coor;//地图的中点与大头针的坐标一致
            }];
            
            //实例化一个继承大头针的类
            MyAnnotation * ma = [[MyAnnotation alloc]init];
            //使用之前转换好的坐标，为大头针的坐标赋值
            ma.coordinate = coor;
            ma.title = name;
            ma.subtitle = sname;
            //将大头针添加进当前地图的视图上
            [self.mv addAnnotation:ma];
            
            //点击搜索按钮后，键盘收回
            [self.key resignFirstResponder];
        }
        //将flag置为NO，默认的是YES
        self.flag = NO;
        return;
    }
    
    NSLog(@"异步解析-");
    //self.flag非YES的情况，进行附近建筑物名的解析
    self.tdata =  [nd objectForKey:@"items"];
    //重新加载数据内容，实时刷新，保证用来显示附近建筑物名能在单元格里显示
    [self.tview reloadData];
    
    [UIView beginAnimations:@"tview" context:nil];
    self.tview.center = CGPointMake(self.tview.center.x, self.tview.center.y-self.tview.frame.size.height);
    [UIView commitAnimations];
    
    self.ret.hidden = NO;
}

-(void)right:(id)sender{
    //异步解析
    NSURL *url = [NSURL URLWithString:@"http://api.jiepang.com/v1/locations/search?lat=39.916&lon=116.393&count=2&source=100100"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:req delegate:self];
}

#pragma mark 单元格的代理方法
//设置单元格的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //使用三元运算符进行单元格行数的计算
    return self.tdata?self.tdata.count:0;//self.tdata是否有数据，有，返回数据的数量；没，返回0——单元格行数为0
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}
//显示单元格的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //对单元格进行标计
    static NSString * cell_ = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_];
    }
    
    NSDictionary * nd = [self.tdata objectAtIndex:indexPath.row];
    cell.textLabel.text = [nd objectForKey:@"name"];
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
