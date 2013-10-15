//
//  HomeViewController.m
//  UI-Test-图书管理
//
//  Created by ibokan on 13-5-30.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import "HomeViewController.h"
#import "AddViewController.h"
#import "Book.h"
#import "DetailViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
     //    UIImage *image=[UIImage imageNamed:@"alien"];
     //    [Book insertWithName:@"五行缺水" andPublisher:@"根水出版社" andDate:@"1991年1月1日" andAuthor:@"根水" andfaceImage:image andIntro:@"金木水火土"];
     //
     //     [Book deleteWithId:5];
     int i=0;
     for (Book *book in [Book findAll]) {
     NSLog(@"bookId=%d,bookName=%@,bookPublisher=%@,bookPublishDate=%@,bookAuthor=%@,bookIntro=%@",book.bookId,book.bookName,book.bookPublisher,book.bookPublishDate,book.bookAuthor,book.bookIntro);
     UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i%4*80, 100+i/4*80, 80, 80)];
     UIImage *image=book.bookFaceImage;
     imageView.image=image;
     [self.view addSubview:imageView];
     i++;
     }
     */
    // Do any additional setup after loading the view from its nib.
    //增加导航条左右按钮
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushToAdd:)];
    self.navigationItem.leftBarButtonItem=left;
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(pushToEdit:)];
    self.navigationItem.rightBarButtonItem=right;
    
    //初始化tableView
    self.tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.view addSubview:self.tableView];
    
    //用于显示的数组
    self.bookArray=[Book findAll];
    NSLog(@"home viewDidLoad");
    
}
-(void)pushToAdd:(UIBarButtonItem *)sender{
    AddViewController *ac=[[AddViewController alloc]init];
    //使用导航栏 的从右往左切换
//    [self.navigationController pushViewController:ac animated:YES];
    
    
    [self presentModalViewController:ac animated:YES];
    
}
-(void)pushToEdit:(UIBarButtonItem *)sender{
    if (self.tableView.isEditing) {//判断是否处于可编辑属性
        [super setEditing:NO animated:YES];
        [self.tableView setEditing:NO animated:YES];
        sender.title=@"删除";
    }else{
        [super setEditing:YES animated:YES];
        [self.tableView setEditing:YES animated:YES];
        sender.title=@"完成";
    }
}


#pragma mark - Table view data source

#pragma mark - 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.bookArray.count;
        
}

#pragma mark - 单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";//重用标识
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if (cell==nil) {//如果没有重用单元格 自己创建带有标识的单元格
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    Book *b=[self.bookArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text=b.bookName;
    cell.detailTextLabel.text=b.bookAuthor;
    
    cell.imageView.image=b.bookFaceImage;
    
    return cell;
}

#pragma mark - 提交编辑指令后调用
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        Book *b=[self.bookArray objectAtIndex:indexPath.row];//获取学生对象
        
        [Book deleteWithId:b.bookId];
        //刷新 数组和界面
        self.bookArray =[Book findAll];
        [self.tableView reloadData];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

#pragma mark - Table view delegate
#pragma mark - 单元格 单击 事件处理函数
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    Book *b;
    b=[self.bookArray objectAtIndex:indexPath.row];
   
    DetailViewController *detailView = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailView animated:YES];
    
    detailView.navigationItem.title=b.bookName;
    detailView.bookAuthor.text=b.bookAuthor;
    detailView.bookPublisher.text=b.bookPublisher;
    detailView.bookdate.text=b.bookPublishDate;
    detailView.bookFaceImage.image=b.bookFaceImage;
    detailView.bookIntro.text=b.bookIntro;
    
    detailView.book=b;
   
    [detailView release];
    
    
    //让被选中的行 慢慢消失选中标志  （默认选中变蓝色）
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark -  刷新
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.bookArray=[Book findAll];//数据查询
    [self.tableView reloadData];//重新加载
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
