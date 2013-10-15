//
//  ViewController.m
//  UI_weibo
//
//  Created by ibokan on 13-6-4.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import "ViewController.h"
#import "WeiBo.h"
#import "myCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize cell;
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //创建微博对象
    //调用WeiBo之中声明、实现的便利方法
    WeiBo *wb1 = [WeiBo weiboCreate:@"豹子1" andTitle:@"吃草的包装" andResponseTitle:@"吃肉的豹子" andHead:[UIImage imageNamed:@"1004.jpg"] andPic:[UIImage imageNamed:@"1003.jpg"]];
    
    WeiBo *wb2 = [WeiBo weiboCreate:@"豹子2" andTitle:@"很久很久很久很久很久很久以前，有一只爱吃醋、吃草2的包装有一只爱吃醋吃肉的豹子很久很久很久很久很久很久以前有一只爱吃醋吃肉的豹子很久很久很久很久很久很久以前，一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋,可贷款贷款贷款贷款贷款的贷款的可靠的的空间放空间诶佛我就饿哦去了快乐学聪明v有一只爱吃醋吃肉的豹子很久很久很久很久很久很久以前，一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋,可贷款贷款贷款贷款贷款的贷款的可靠的的空间放空间诶佛我就饿哦去了快乐学聪明v" andResponseTitle:@"有一只爱吃醋吃肉的豹子很久很久很久很久很久很久以前，一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋一只爱吃醋,可贷款贷款贷款贷款贷款的贷款的可靠的的空间放空间诶佛我就饿哦去了快乐学聪明爱吃醋一只爱吃醋一只爱吃爱吃醋一只爱吃醋一只爱吃爱吃醋一只爱吃醋一只爱吃爱吃醋一只爱吃醋一只爱吃爱吃醋一只爱吃醋一只爱吃" andHead:[UIImage imageNamed:@"1001.jpg"] andPic:[UIImage imageNamed:@"1004.jpg"]];
    
    WeiBo *wb3 = [WeiBo weiboCreate:@"豹子3" andTitle:@"吃草3的包装" andResponseTitle:@"吃肉的豹子" andHead:[UIImage imageNamed:@"1008.jpg"] andPic:[UIImage imageNamed:@"1007.jpg"]];
    
    //将实例的三个对象添加进数组，以备创建列表时候使用
    self.weiboArray = [[NSMutableArray alloc]initWithObjects:wb1,wb2,wb3, nil];

    //创建单元格列表
    //self.tbl = [[UITableView alloc]initWithFrame:CGRectMake(0,0,320, 460)];
    self.tbl = [[UITableView alloc]initWithFrame:CGRectMake(0,0,320, 460) style:UITableViewStyleGrouped];
    //导入代理方法
    self.tbl.delegate = self;
    self.tbl.dataSource = self;
    //将创建好的单元格列表添加进当前视图
    [self.view addSubview:self.tbl];
    
}

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //通含有微博内容的数组确定单元格行数
    return self.weiboArray.count;
}

//设置单元格内容的代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //确定一个静态的变量
    static NSString *cellStr = @"cell";
    //实例一个myCell类的对象cell。
    //dequeueReusableCellWithIdentifier是从队列中根据标示符取出一个暂时不用的cell
    cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    //判断单元格是否为空，为空，创建；不为空，跳过，不创建。这样就不会出现多次创建单元格的情况，有助于程序的性能
    if (cell == nil) {
        cell = [[myCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    //获取存储微博信息数组的内容，赋值给WeiBo的对象w
    WeiBo *w = [self.weiboArray objectAtIndex:indexPath.row];
    
    //输入单元格的内容：
    cell.head.image = w.head;
    cell.title.text = w.title;

    //cell.responseTitle.text = w.responseTitle;
    //cell.responsePic.image = w.responsePic;

    //设置文本框圆角:导入QuartzCore框架、头文件
    [cell.responseTitle.layer setMasksToBounds:YES];
    cell.responseTitle.layer.cornerRadius = 15;
   //----------------设置自动换行
    //无行数限制
    cell.responseTitle.numberOfLines = 0;
    //cell.responseTitle.lineBreakMode = UILineBreakModeWordWrap; 这是旧的表达方式
    cell.responseTitle.lineBreakMode = NSLineBreakByWordWrapping;
    
    //设置字体
    UIFont *font = [UIFont fontWithName:@"Arial"size:12];
    //设置一个行高上限
    //CGSize size = CGSizeMake(100 /*nameLabel.frame.size.width*/, 2000);
    CGSize size = CGSizeMake(250,3000); // 250是定制宽度，3000决定了可显示的字符串数量
    //得到文本框中的文字
    NSString *labelText = w.responseTitle;
    
    //根据之前的字体、行宽高、文字计算实际frame大小，并将label的frame变成实际大小
    labelsize = [labelText sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];

    NSLog(@"labelsize(width, height) = (%f, %f)", labelsize.width, labelsize.height);

    cell.responseTitle.frame = CGRectMake(cell.responseTitle.frame.origin.x, cell.responseTitle.frame.origin.y, labelsize.width, labelsize.height);
    
     cell.responseTitle.text = w.responseTitle;
    
    //获得发布框的高度
    cell.authorLable.numberOfLines = 0;
    cell.authorLable.lineBreakMode = NSLineBreakByCharWrapping;
    NSString *authorText = w.authorLable;
    CGSize labelsize2 = [authorText sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    cell.authorLable.frame = CGRectMake(cell.authorLable.frame.origin.x, cell.authorLable.frame.origin.y, labelsize2.width, labelsize2.height);
    cell.authorLable.text = w.authorLable;
    
    return cell;
    
}

- (float )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取存储微博信息数组的内容，赋值给WeiBo的对象w
    WeiBo *w = [self.weiboArray objectAtIndex:indexPath.row];
    
    //获得回复框高度
    
    //无行数限制
    cell.responseTitle.numberOfLines = 0;
    //cell.responseTitle.lineBreakMode = UILineBreakModeWordWrap; 这是旧的表达方式
    cell.responseTitle.lineBreakMode = NSLineBreakByWordWrapping;
    
    //设置字体
    UIFont *font = [UIFont fontWithName:@"Arial"size:12];
    //设置一个行高上限
    //CGSize size = CGSizeMake(100 /*nameLabel.frame.size.width*/, 2000);
    CGSize size = CGSizeMake(250,3000); // 250是定制宽度，3000决定了可显示的字符串数量
    //得到文本框中的文字
    NSString *labelText = w.responseTitle;
    
    //根据之前的字体、行宽高、文字计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize1 = [labelText sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    //获得发布框的高度
    cell.authorLable.numberOfLines = 0;
    cell.authorLable.lineBreakMode = NSLineBreakByCharWrapping;
    NSString *authorText = w.authorLable;
    CGSize labelsize2 = [authorText sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    
    
    // 這裏返回需要的高度
    return 100+labelsize1.height+labelsize2.height;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
