//
//  ViewController.m
//  IOS_MVC
//
//  Created by ibokan on 13-6-21.
//  Copyright (c) 2013年 zzl. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "StudentManager.h"

@interface ViewController ()

@end


@implementation ViewController

#pragma mark 列表代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellStr = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
    
    if (cellStr==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellStr];
    }
    
    Student *stu = [self.stuArray objectAtIndex:indexPath.row];
    cell.textLabel.text = stu.name;
    cell.detailTextLabel.text = stu.age;
    return cell;
    
    /*
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:<#(id)#> selector:<#(SEL)#> name:<#(NSString *)#> object:<#(id)#>];
    //发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:<#(NSString *)#> object:<#(id)#> userInfo:<#(NSDictionary *)#>];
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObject:<#(id)#>];
     */
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //实例化一个学生管理类的对象
    StudentManager *mag = [[StudentManager alloc]init];
    //调用
    self.stuArray = [mag getAllStudent];//模型传送到控制器
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
