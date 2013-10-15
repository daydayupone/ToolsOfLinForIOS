//
//  ViewController.m
//  ui007
//
//  Created by 颜振洋 on 13-5-22.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import "ViewController.h"
#import "ConnectionDB.h"
#import "Student.h"
#import "AddViewController.h"
#import "UpateViewController.h"
#import "pinyin.h"
@interface ViewController ()

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{//当视图将要显示的时候将数据快速的再加载显示
    self.stuArray=[Student findall];//重新查询
    [self.tv reloadData];//重新加载数据
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tv=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];//创建一个表格,Grouped标示分组样式
    self.tv.separatorColor=[UIColor yellowColor];//设置表格的分割线的颜色
    UIImageView*imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    imgView.image=[UIImage imageNamed:@"baidu13.jpg"];
    self.tv.tableHeaderView=imgView;//设置表格上头图像
    [self.view addSubview:self.tv];
    self.tv.delegate=self;//第一个代理
    self.tv.dataSource=self;//第二个代理
    self.stuArray=[Student findall];//将数据库的查询数据存入显示数组
    UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushToAdd:)];
    self.navigationItem.rightBarButtonItem=right;
    self.navigationItem.leftBarButtonItem=self.editButtonItem;//编辑左边按钮
    
    self.count = 0;
//    char a=pinyinFirstLetter("林");
//    NSLog(@"%c",a);
    
//    for (Student *s in [Student findall]) {
//        NSLog(@"学生编号：%d,学生姓名：%@,学生电话：%@",s.stuid,s.stuname,s.stuphone);
//    }
////    Student*st1=[Student findid:1];
////    NSLog(@"学生编号：%d,学生姓名：%@,学生电话：%@",st1.stuid,st1.stuname,st1.stuphone);
//   
//    [Student deleteStudentWithId:1];
//    [Student insertStuName:@"小洞" andStuphone:@"010-658794235"];
//    [Student updateStuName:@"向东" andStuphone:@"010-69854725" andid:12];
//    
    for (Student *s in [Student findall]) {
        NSLog(@"学生编号：%d,学生姓名：%@,学生电话：%@,学生头像：%@",s.stuid,s.stuname,s.stuphone,s.stuhead);
    }
////    [ConnectionDB createDB];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{//删除按钮
    //可重用的代码
    if ([self.tv isEditing]) {//判断是否处于编辑状态
        [self.tv setEditing:NO animated:YES];
        [super setEditing:NO animated:YES];
    }else{
        [self.tv setEditing:YES animated:YES];
        [super setEditing:YES animated:YES];
    }
}
-(void)pushToAdd:(id)sender{
    AddViewController*add=[[AddViewController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source
//表格中有多少分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    return 1;//有1个分区
}
//每个分区中的单元格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    return self.stuArray.count;
}
//定义每个单元格的具体内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";//重用标示，，，单元格的名称。索引机制
    //重用方式获取单元格对象
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {//判断这个名称的单元格是不是可以重用
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];//创建一个带子标题的样式的单元格
    }
    Student*s=[self.stuArray objectAtIndex:indexPath.row];//
    cell.textLabel.text=s.stuname;
    cell.detailTextLabel.text=s.stuphone;//设置电话内容
    cell.imageView.image=[UIImage imageWithData:s.stuhead];//设置头像
    return cell;
}
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
     return YES;//允许视图表格做编辑
 }
//当可以做表格编辑时
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) { // Delete the row from the data source
     Student *s=[self.stuArray objectAtIndex:indexPath.row];//获取到单元格对象信息
     [Student deleteStudentWithId:s.stuid];//删除
     self.stuArray=[Student findall];
     [self.tv reloadData];
//     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }

#pragma mark - Table view delegate
//单元格单击事件处理函数
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    Student*s=[self.stuArray objectAtIndex:indexPath.row];
     UpateViewController *detailViewController = [[UpateViewController alloc] init];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
    detailViewController.txt1.text=s.stuname;
    detailViewController.txt2.text=s.stuphone;
    detailViewController.sid=s.stuid;
}

@end
