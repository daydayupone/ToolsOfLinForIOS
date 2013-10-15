#import "ViewController.h"
#import "JSON.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tv=[[UITableView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.tv];
    self.tv.delegate=self;
    self.tv.dataSource=self;
    //获得stu.json的地址
    NSString *filePath=[[NSBundle mainBundle] pathForResource:@"stu" ofType:@"json"];
    //获得具体地址
    NSString *jsonStr=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //转换数据类型
    self.stuDic=[jsonStr JSONValue];
    NSLog(@"%@",self.stuDic);
    self.keyArray=[[self.stuDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
//设置区的头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.keyArray objectAtIndex:section];
}

//说明表格分区数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return self.keyArray.count;
}
//每个分区中的单元格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSString *k=[self.keyArray objectAtIndex:section];
    NSArray *ta=[self.stuDic objectForKey:k];
    return ta.count;
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
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSString *k=[self.keyArray objectAtIndex:indexPath.section];
    NSArray *ta=[self.stuDic objectForKey:k];
    NSString *name=[ta objectAtIndex:indexPath.row];
    cell.textLabel.text=name;
    // Configure the cell...
    
    return cell;
}


// Override to support conditional editing of the table view.
////允许表格视图编辑
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}



// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        //获取到了单元格对应的学生对象
//        Student *s=[self.stuArray objectAtIndex:indexPath.row];
//        //删除
//        [Student deleteStudentWithId:s.stuid];
//        self.stuArray=[Student findall];
//        [self.tv reloadData];
//        // Delete the row from the data source
//        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}


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
////单元格单击事件处理函数
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    Student *s=[self.stuArray objectAtIndex:indexPath.row];
//    UpdateViewController *detailViewController = [[UpdateViewController alloc] init];
//    // Pass the selected object to the new view controller.
//    [self.navigationController pushViewController:detailViewController animated:YES];
//    [detailViewController release];
//    detailViewController.txt1.text=s.stuname;
//    detailViewController.txt2.text=s.stuphone;
//    detailViewController.sid=s.stuid;
//}

@end
