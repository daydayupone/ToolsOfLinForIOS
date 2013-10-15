/*
    1、增加搜索栏：修改 行数，cell，选择行，三个方法的判断是tableView 的方法还是UISearchDisplayController 的方法
    
 */

#import "ViewController.h"
#import "Book.h"
#import "UpdateViewController.h"
#import "AddViewController.h"
#import "ASIHTTPRequest.h"//测试网络下载

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //-------准备好要存储进沙盒的文件
    //得到文件szj.png的路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"szj" ofType:@"png"];
    
    
    //-------开始将文件存储进沙盒
    //获得沙盒的Document路径
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileInDcoument = [documentPath stringByAppendingPathComponent:@"img.png"];
    NSError *error = nil;
    //通过路径，将文件szj.png复制到沙盒的Document之中,命名为img.png
    [[NSFileManager defaultManager] copyItemAtPath:path toPath:fileInDcoument error:&error];
    //通过路径，将文件szj.png移动到沙盒的Document之中,命名为img.png
    [[NSFileManager defaultManager] moveItemAtPath:path toPath:fileInDcoument error:&error];
    //将命名为img.png的文件从沙盒的Document中移除
    [[NSFileManager defaultManager] removeItemAtPath:fileInDcoument error:&error];
    
    
   //--------网络数据下载
    NSString *urlInDcoument = [documentPath stringByAppendingPathComponent:@"urlImg.png1"];
    NSURL *url = [NSURL URLWithString:@"http://img1.51cto.com/image/upload/group/default.gif"];
    ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:url];
    [req startSynchronous];
    NSData *urlData = [req responseData];
    
    //创建文件
    [[NSFileManager defaultManager] createFileAtPath:urlInDcoument contents:urlData attributes:nil];
    
    NSLog(@"+++%@",fileInDcoument);
    
	// Do any additional setup after loading the view, typically from a nib.
    //插入
//    [Book insertIntoSqlWithName:@"haoshu" andPrice:12];
    //删除
//    [Book deleteACellFromDbWithId:5];
    //插入图片
//    [Book insertImage:[UIImage imageNamed:@"bj"] WithId:4];
    //更新
//    [Book updateName:@"genshui" andPrice:20 withId:4];
//    [Book updateName:@"yecao" andPrice:30 andImage:[UIImage imageNamed:@"bj"] withId:3];
 
    //插入
//    [Book insertIntoSqlWithName:@"好书" andPrice:123 andImage:[UIImage imageNamed:@"szj"]];
    
//
//    //查找
//    int i=0;
//    for (Book *b in [Book findAll]) {
//        NSLog(@"书id=%d 书名：%@ 书价：%.2f",b.bookId,b.bookName,b.bookPrice);
//        UIImage *image=b.faceImage;
//        UIImageView *imgeView=[[UIImageView alloc]initWithFrame:CGRectMake(10+(i++)%4*80, 100+i/4*100, 80, 100)];
//        imgeView.image=image;
//        [self.view addSubview:imgeView];
//    }
    
   
    
//    self.tableView=[[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];

    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
   
    self.bookArray=[Book findAll];
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushToAdd:)];
    
    self.navigationItem.rightBarButtonItem=right;
    
    self.navigationItem.leftBarButtonItem=self.editButtonItem;
    
    //搜索框
    self.sb=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.tableView.tableHeaderView=self.sb;
    //进入搜索框到一个灰色页面
    UISearchDisplayController *sdc=[[UISearchDisplayController alloc]initWithSearchBar:self.sb contentsController:self];
    sdc.searchResultsDelegate=self;
    sdc.searchResultsDataSource=self;
    
    
}

-(void)pushToAdd:(id)sender{
    AddViewController *ac=[[AddViewController alloc]init];
    [self.navigationController pushViewController:ac animated:YES];
}

#pragma mark - Table view data source
#pragma mark - 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
#pragma mark - 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tableView) {
         return self.bookArray.count;//以显示数组大小为单元格的行数
    }else{
        //Cocoa提供了一个类NSPredicate类，该类主要用于指定过滤器的条件，该对象可以准确的描述所需条件，对每个对象通过谓词进行筛选，判断是否与条件相匹配。谓词表示计算真值或假值的函数。
        //用predicateWithFormat创建一个谓词，条件是搜索的信息
        //self关键字 字符串运算符CONTAINS[c][d][cd] CONTAINS：检查某个字符串是否以另一个字符串内部。[c]不区分大小写[d]不区分发音符号即没有重音符号[cd]既不区分大小写，又不区分发音符号。
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.bookName contains[cd] %@", self.sb.text];
        //filteredArrayUsingPredicate方法它将循环过滤数组内容，根据谓词计算每个对象的值，并将值为YES的对象累计到将被返回的新数组filteredArray中。
        self.filteredArray = [self.bookArray filteredArrayUsingPredicate:predicate];
        //符合搜索条件的新数组的长度
        return [self.filteredArray count];
    }
    
}
#pragma mark - 单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";//重用标识
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];//重用某种标识的单元格  如果没有可重用则为nil
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];//重用某种标识的单元格  如果没有可重用则为nil
    if (cell==nil) {//如果没有重用单元格 自己创建带有标识的单元格
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    Book *b;
    if (tableView==self.tableView) {
           b =[self.bookArray objectAtIndex:indexPath.row];
    }else{
        b =[self.filteredArray objectAtIndex:indexPath.row];
    }

    
    cell.textLabel.text=b.bookName;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"书价：%.2f元",b.bookPrice];
 
    cell.imageView.image=b.faceImage;
  
    
    
    return cell;
}
#pragma mark - 设置编辑
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    if (self.tableView.isEditing) {//判断是否处于可编辑属性
        [super setEditing:NO animated:YES];
        [self.tableView setEditing:NO animated:YES];
    }else{
        [super setEditing:YES animated:YES];
        [self.tableView setEditing:YES animated:YES];
    }
    
}

// Override to support conditional editing of the table view.
#pragma mark - 允许表格被编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
#pragma mark - 提交编辑指令后调用
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        Book *b=[self.bookArray objectAtIndex:indexPath.row];//获取学生对象
        
        [Book deleteACellFromDbWithId:b.bookId];
        
        //刷新 数组和界面后面调用了刷新方法- (void)viewWillAppear:(BOOL)animated，此处就不需要再刷新了
        self.bookArray =[Book findAll];
        [self.tableView reloadData];
     
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
#pragma mark - 换行

//只需要加一个此方法 即可以换行 （不写内容 也能拖 但数据没有改变）
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    Book *book1=[self.bookArray objectAtIndex:sourceIndexPath.row];
    Book *book2=[self.bookArray objectAtIndex:destinationIndexPath.row];
    //此处进行了数据内容的交换
    [Book updateName:book1.bookName andPrice:book1.bookPrice andImage:book1.faceImage withId:book2.bookId];
    [Book updateName:book2.bookName andPrice:book2.bookPrice andImage:book2.faceImage withId:book1.bookId];
    
    //交换了数据库不交换此数组 未刷新时 点开编辑内容还是原来的
//    [self.bookArray exchangeObjectAtIndex:destinationIndexPath.row withObjectAtIndex:sourceIndexPath.row];
//    self.bookArray=[Book findAll];//数据查询
//    [self.tableView reloadData];//重新加载
}



#pragma mark - Table view delegate
#pragma mark - 单元格 单击 事件处理函数
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    Book *b;
    if (tableView==self.tableView) {
       b=[self.bookArray objectAtIndex:indexPath.row];
    }else{
       b=[self.filteredArray objectAtIndex:indexPath.row];
    }
   
    
    UpdateViewController *up = [[UpdateViewController alloc] init];
    [self.navigationController pushViewController:up animated:YES];

    up.txt1.text=b.bookName;
    up.txt2.text=[NSString stringWithFormat:@"%.2f",b.bookPrice];
    up.imageView.image=b.faceImage;
    up.bookId=b.bookId;
    [up release];
    
  
    
    
    
    
    //让被选中的行 慢慢消失选中标志  （默认选中变蓝色）
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}



#pragma mark -  刷新
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    self.bookArray=[Book findAll];//数据查询
//    [self.tableView reloadData];//重新加载
//    
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.bookArray = [Book findAll];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
    
    // Dispose of any resources that can be recreated.
}

@end
