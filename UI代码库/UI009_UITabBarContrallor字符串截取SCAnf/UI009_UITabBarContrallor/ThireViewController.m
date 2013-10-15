//
//  ThireViewController.m
//  UI009_UITabBarContrallor
//
//  Created by ibokan on 13-5-27.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "ThireViewController.h"

@interface ThireViewController ()

@end

@implementation ThireViewController

@synthesize strArray,searchBar,filteredArray;

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
    self.view.backgroundColor = [UIColor redColor];
    /*
            实现区分分符号，将字符串存入一个数组
     思路：
     1、获取文件路径
     2、将文字内容转换成字符串
     3、将字符串分割，使用NSString里面的一个函数- componentsSeparatedByString:
     */
    //获取
    NSString *path = [[NSBundle mainBundle]pathForResource:@"crayons" ofType:@"txt"];
    //转换成字符串类型的文件
    NSString *shiftStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"%@",shiftStr);
    //分割字符串
    //[shiftStr componentsSeparatedByString:@"\n"];
    
    //创建数组,将处理好分割的字符串存储进去
    self.strArray = [shiftStr componentsSeparatedByString:@"\n"]/*componentsSeparatedByString:是属于数组类型的，所以可以直接将自己转换的数据赋值给数组*/;
    NSLog(@"%@",strArray);
    //NSScanner用于转换16进制的类型
    
    //创建列表
    self.tabelView = [[UITableView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:_tabelView];
    //.h中设置代理，委托
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    
    //-------------创建搜索栏对象，UISearchBar
    //实例化一个搜索栏对象
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    //将搜索栏添加到列表 tabelView 顶上
    _tabelView.tableHeaderView = searchBar;
    //为搜索栏添加动画效果
    UISearchDisplayController *searchDisplayC = [[UISearchDisplayController alloc]initWithSearchBar:searchBar contentsController:self];
    
    //-------------实现搜索栏的搜索功能
    //设置搜索的代理,不需要导入协议，它的协议与<UITableViewDataSource,UITableViewDelegate>是公用的
    searchDisplayC.searchResultsDelegate = self;
    searchDisplayC.searchResultsDataSource = self;
    
    
    
    // Do any additional setup after loading the view from its nib.
    
    //释放内存
    [_tabelView release];
    [searchBar release];
}


//--------------------列表代理方法的设置
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置单元格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tabelView == tableView) {
        return self.strArray.count;
    }
    else{
        //Cocoa提供了一个类NSPredicate类，该类主要用于指定过滤器的条件，该对象可以准确的描述所需条件，对每个对象通过谓词进行筛选，判断是否与条件相匹配。谓词表示计算真值或假值的函数。
        //用predicateWithFormat创建一个谓词，条件是搜索的信息
        //self关键字 字符串运算符CONTAINS[c][d][cd] CONTAINS：检查某个字符串是否以另一个字符串内部。[c]不区分大小写[d]不区分发音符号即没有重音符号[cd]既不区分大小写，又不区分发音符号。
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", self.searchBar.text];
        //filteredArrayUsingPredicate方法它将循环过滤数组内容，根据谓词计算每个对象的值，并将值为YES的对象累计到将被返回的新数组filteredArray中。
        self.filteredArray = [self.strArray filteredArrayUsingPredicate:predicate];
        //符合搜索条件的新数组的长度
        return [self.filteredArray count];
    }
   
}

//设置单元格的内容
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //重用引用字符
    static NSString * cellStr = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    NSString *col = nil;
    //NSString *str = [self.sctrArray objectAtIndex:indexPath.row];
    
    //判断是否是我们自己创建的表格视图对象
    //如果是//通过下标，获取数组的元素
    if (tableView  == self.tabelView) {
        col = [self.strArray objectAtIndex:indexPath.row];
    }
    else//如果不是,就用搜索的结果的数组元素
    {
        col = [self.filteredArray objectAtIndex:indexPath.row];
    }
    
    
    
   /* //将从数组中获得的字符串赋值给单元格，显示
    cell.textLabel.text = str ;
     */
    
    //-------获得数组 self.strArray 中 # 号后面位置的代表颜色的16进制数
    //使用componentsSeparatedByString: 去除字符串之中的"#"
    //通过下标获得去除"#"的字符串数组（componentsSeparatedByString后的结果是数组类型）
    NSString *cstr = [[col componentsSeparatedByString:@"#"]objectAtIndex:1];
    cell.textLabel.textColor = [self crayonesColor:cstr];

    //只显示 # 前面的
    cell.textLabel.text = [[col componentsSeparatedByString:@"#"]objectAtIndex:0];
    
    return cell;


    

}

//单元格点选代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取当前点击的单元格
    UITableViewCell *cc = [_tabelView cellForRowAtIndexPath:indexPath];
    //给单元格染色
    self.searchBar.tintColor = cc.textLabel.textColor;
}


#pragma mark 将16进制字符串 EED9C4 创建 R G B 的方法
- (UIColor *)crayonesColor:(NSString *)colorStr
{
    //确定取值范围
    NSRange rang = {0,2};//从首位开始取2位值
    
    NSString *red = [colorStr substringWithRange:rang];//EE
    //确定,从第二个元素开始取值
    rang.location = 2;
    NSString *green = [colorStr substringWithRange:rang];//D9
    //确定,从第4个元素开始取值
    rang.location = 4;
    NSString *blue = [colorStr substringWithRange:rang];//C4
    
    unsigned int r,g,b;
    //[NSScanner scannerWithString:red]将取得的字符型的数据存为十六进制字符串
    //scanHexInt:&r 将十六进制字符串转换为整数
    [[NSScanner scannerWithString:red] scanHexInt:&r];//回头看看c语言的SCANf函数,java的Scanner函数 ——> 写法：Integer i = s.nextInt();
    [[NSScanner scannerWithString:green] scanHexInt:&g];
    [[NSScanner scannerWithString:blue] scanHexInt:&b];
    
    //使用转换出的整数获得相应的颜色
    UIColor *cl = [UIColor  colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
    //返回转换好的结果
    return cl;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
