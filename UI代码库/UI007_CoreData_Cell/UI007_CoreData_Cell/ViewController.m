//
//  ViewController.m
//  UI007_SQList
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "AddViewController.h"
#import "UpdateViewController.h"
//#import "AppDelegate.h"



@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    //获取当前应用程序的委托（UIApplication sharedApplication为整个应用程序上下文） 
     self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    //创建组件
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.tableView];
    //设置该组件将要用到的代理
    //
    self.tableView.delegate = self;//
    self.tableView.dataSource = self;
    
    //CoreDate----使用AppDelegate的对象调用AppDelegate里什么和实现的方法findall
    self.stuArray = [self.myDelegate findall];
    
      //创建一个用于添加信息的代码
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushToAdd:)];//创建UIBarButtonItem对象，并附带方法
    self.navigationItem.rightBarButtonItem = bar;//将按钮设置在导航栏的右侧
    
    //创建一个编辑按钮
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

}

//self.editButtonItem调用的删除动画
- (void) setEditing:(BOOL)editing animated:(BOOL)animated
{
    if ([self.tableView isEditing])//判断是否处于编辑状态
    {
        [super setEditing:NO animated:YES];//关闭编辑状态，保持动画效果
        [self.tableView setEditing:NO animated:YES];
    }
    else
    {
        [super setEditing:YES animated:YES];
        [self.tableView setEditing:YES animated:YES];
    }
}

//转向进添加页
- (void)pushToAdd:(id)sender
{
    AddViewController *addV = [[AddViewController alloc]init];
    [self.navigationController pushViewController:addV animated:YES];
    
}

//当视图将要显示的时候，重新加载一遍数据
- (void)viewWillAppear:(BOOL)animated
{
    //self.stuArray = [Student findAll];//查询数据，重新将所有用的上的数据存储进stuArray数组中
    self.stuArray = [self.myDelegate findall];
    [self.tableView reloadData];//重新加载数据
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//以下的代码由于太多可以通过在创建好的继承自UITableViewController复制：

#pragma mark - Table view data source
//说明表格分区输入
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;//返回多少，表格就分几个区
}

//每个分区之中的单元格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.stuArray.count;//单元格的行与数组大小一致
}


//定义每个单元格的具体内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath/*表示单元格所在的行   */
{
    //——————————————该代码写法基本都这样写的，未来开发时可以照以下写
    
    static NSString *CellIdentifier = @"Cell";//为单元格命名-重用标识
    
    //重用方式获取一个单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];//删除forIndexPath:indexPath，否则要自定义一个indexPath
    
    //判断是否能获取重用单元格
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier/*重用标识*/];
    }
    //根据单元格的行取得数据
    Student *stu = [self.stuArray objectAtIndex:indexPath.row];//indexPath 表示 [分区，行]
    
    cell.textLabel.text = stu.stuname;//将数据库里学生名字显示在列表textLabel中
    cell.detailTextLabel.text = stu.stuphone;//将数据库里学生名字显示在列表detailTextLabel中
    
    //cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"spider1.png"/*,indexPath.row+1*/]];//为列表添加图片
    
   // NSData *imgData = [Student loadImage:1];
    UIImage *img = [UIImage imageWithData:stu.stuhead];
    cell.imageView.image = img;
    //[cell.imageView initWithImage:img];
    // Configure the cell...
    
    return cell;
}

//开启此行代码，允许编辑效果的实现
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 

//表格编辑
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
     //获取到了单元格对应的学生对象
     Student *stu = [self.stuArray objectAtIndex:indexPath.row];
     [self.myDelegate deleteACellFromDbWithId:stu.stuid];
     self.stuArray = [self.myDelegate findall];
     [self.tableView reloadData];
 
 }
// else if (editingStyle == UITableViewCellEditingStyleInsert) {
// // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
// }
 }
 

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate
//单元格单击事件函数处理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    //
    //点击单元格时推送到UpdateViewController（更新）页面
     UpdateViewController *detailViewController = [[UpdateViewController alloc] init];
    
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     NSLog(@"%@",indexPath  );
     [detailViewController release];
    
    //获取数组之中数组的数据
    Student *stu = [self.stuArray objectAtIndex:indexPath.row];//获取数据的数组
    detailViewController.stuName.text = stu.stuname;
    detailViewController.stuPhone.text = stu.stuphone;
    
    //NSNumber转换为NSString类型
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    detailViewController.stuNumber.text = [numberFormatter stringFromNumber:stu.stuid];
    [numberFormatter release];
    //detailViewController.sid = stu.stuid;//对UpdateViewController里的编号赋值
}
@end



