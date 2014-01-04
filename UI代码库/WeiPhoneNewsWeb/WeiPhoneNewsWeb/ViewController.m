//
//  ViewController.m
//  WeiPhoneNewsWeb
//
//  Created by 颜振洋 on 13-6-16.
//  Copyright (c) 2013年 颜振洋. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"
#import "MyCell.h"
#import "News.h"
#import "MyHeaderCell.h"
#import "WebViewController.h"
#import "JSON.h"
//#import "SVProgressHUD.h"

@interface ViewController ()
@end
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"爱疯新闻";
    self.newsTitleArrayN=[[NSMutableArray alloc]init];
    self.lookNoArrayN=[[NSMutableArray alloc]init];
    self.dateArrayN=[[NSMutableArray alloc]init];
    self.webArrayN=[[NSMutableArray alloc]init];
    self.imgWebArrayN=[[NSMutableArray alloc]init];
    self.newsArrayN=[[NSMutableArray alloc]init];
    self.sortedDateArray=[[NSArray alloc]init];
    
    self.page=0;
    [self getData:self.page];
    
    //创建一个表格
    self.table=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    self.table.delegate=self;
    self.table.dataSource=self;
  
    //创建下拉刷新视图
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
	self.refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.view.bounds.size.height,self.view.bounds.size.width, self.view.bounds.size.height)];
    _refreshHeaderView.delegate = self;
	[self.table addSubview:_refreshHeaderView];
    [_refreshHeaderView refreshLastUpdatedDate];

}
-(void)getData:(int)page{
    NSArray* webArray=[NSArray arrayWithObjects:@"iPhone",@"iPad",@"apple",nil];
    for (int i=0; i<3; i++) {
        NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.weiphone.com/%@/news/index_%@.shtml",[webArray objectAtIndex:i],[NSString stringWithFormat:@"%d",page]]];
        ASIHTTPRequest *req=[ASIHTTPRequest requestWithURL:url];
        req.delegate=self;
        [req startAsynchronous];
        //[SVProgressHUD showWithStatus:@"抓取新闻…"];
    }
}

#pragma mark ASIHTTPRequestDelegate Methods
- (void)requestFinished:(ASIHTTPRequest *)request{
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:[request responseData]];//创建基于xpath解析html的类对象
    //获取新闻标题
    self.newsTitleArray=[xpathParser searchWithXPathQuery:@"//div[@id='news']//div//div[2]//h3//a"];
    @synchronized(self){
        for(int i=0;i<self.newsTitleArray.count;i++){
            TFHppleElement *element = [self.newsTitleArray objectAtIndex:i];
            NSString *myTitle = [element content];
            [self.newsTitleArrayN addObject:myTitle];
        }
    }
    //获取点击次数
    self.lookNoArray=[xpathParser searchWithXPathQuery:@"//div[@id='news']//div//div[2]//div//div//span[1]"];
    @synchronized(self){
        for(int i=0; i<self.lookNoArray.count; i++){
            NSString *myTitle = [[self.lookNoArray objectAtIndex:i] content];
            [self.lookNoArrayN addObject:myTitle];
        }
    }
    //获取发表时间
    self.dateArray=[xpathParser searchWithXPathQuery:@"//html//body[contains(concat(' ', @class, ' '), '  ')]//div[contains(concat(' ', @class, ' '), ' list_shell ')]//div[2]//div[contains(concat(' ', @class, ' '), ' list_main ')]//div[@id='news']//div//div[2]//div//span[1]"];
    @synchronized(self){
        for(int i=0; i<self.dateArray.count; i++){
            NSString *myTitle = [[self.dateArray objectAtIndex:i] content];
            [self.dateArrayN addObject:myTitle];
        }
    }
    //获取详细页网页地址
    self.webArray=[xpathParser searchWithXPathQuery:@"//div[@id='news']//div//div[2]//h3//a//@href"];
    @synchronized(self){
        for(int i=0; i<self.webArray.count; i++){
            NSString *myTitle = [[self.webArray objectAtIndex:i] content];
            [self.webArrayN addObject:myTitle];
        }
    }
//    //获取详细页网页地址
//    self.imgWebArray=[xpathParser searchWithXPathQuery:@"//div[@id='news']//div[1]//div[1]//a//@src"];
//    @synchronized(self){
//        for(int i=0; i<self.imgWebArray.count; i++){
//            NSString *myTitle = [[self.imgWebArray objectAtIndex:i] content];
//            [self.imgWebArrayN addObject:myTitle];
//        }
//    }
    //排序
    if (self.page==0&&self.newsTitleArrayN.count==75) {
        for(int i=0; i<self.newsTitleArrayN.count; i++){
            News*news=[[News alloc]init];
            news.newsTitle = [self.newsTitleArrayN objectAtIndex:i];
            news.lookNo = [self.lookNoArrayN objectAtIndex:i];
            news.date = [self.dateArrayN objectAtIndex:i*2];
            news.web = [self.webArrayN objectAtIndex:i];
//            news.imgWeb = [self.imgWebArrayN objectAtIndex:i];
            [self.newsArrayN addObject:news];
        }
        self.sortedDateArray=[self sortedDate];

    }else if(self.page>=1&&self.newsTitleArrayN.count>75&&self.newsTitleArrayN.count%75==0) {
        [self.newsArrayN removeAllObjects];
        for(int i=0; i<self.newsTitleArrayN.count; i++){
            News*news=[[News alloc]init];
            news.newsTitle = [self.newsTitleArrayN objectAtIndex:i];
            news.lookNo = [self.lookNoArrayN objectAtIndex:i];
            news.date = [self.dateArrayN objectAtIndex:i*2];
            news.web = [self.webArrayN objectAtIndex:i];
//            news.imgWeb = [self.imgWebArrayN objectAtIndex:i];
            [self.newsArrayN addObject:news];
        }
        self.sortedDateArray=[self sortedDate];
    }
    //[SVProgressHUD showSuccessWithStatus:@"获取成功"];
    [self.table reloadData];
    //创建上拉刷新视图
    [self createFooter];
}
//排序方法
-(NSArray*)sortedDate{
    NSArray*array=[[NSArray alloc]init];
    array=[self.newsArrayN sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[obj2 date] compare:[obj1 date]];
    }];
    return array;
}


#pragma mark -
#pragma mark -UITableViewDataSource,UITableViewDelegate Methods
#pragma mark 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //改变第一行单元格的行高
    if (indexPath.row==0) {
        return 156;
    }
    return 65;
}
#pragma mark 表格中有多少分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark 每个分区中的单元格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsTitleArrayN.count+1;
}

#pragma mark 定义每个单元格的具体内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *cellStr1=@"cell";
        static NSString *cellStr2=@"cell2";
        if (indexPath.row==0) {
            MyHeaderCell *cell2=[tableView dequeueReusableCellWithIdentifier:cellStr2];
            if (cell2==nil) {
                cell2=[[MyHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr2];
            }
            return cell2;
        }else{
            MyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr1];
            if (cell==nil) {//判断这个名称的单元格是不是可以重用
                cell=[[MyCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr1];//创建一个带子标题的样式的单元格
            }
            if (self.newsTitleArrayN!=nil&&self.newsTitleArrayN.count%75==0) {
                News*objectNews=[self.sortedDateArray objectAtIndex:indexPath.row-1];//从已经按时间排序的新闻数组中取出一个对象
                cell.newsLab.text=objectNews.newsTitle;//设置新闻标题
                NSString *title=[[objectNews.web componentsSeparatedByString:@"/"] objectAtIndex:3];//切割网页
                cell.titleFromLab.text=[NSString stringWithFormat:@"%@新闻(%@次浏览)",title,objectNews.lookNo];//设置新闻种类和浏览次数
                cell.dateLab.text=objectNews.date;//设置时间
            }
            return cell;
        }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;//允许视图表格做编辑
}
#pragma mark 点击单元格能够触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController *detailViewController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    
    //通过属性传参，将单元格所对应的网站地址传给webViewController页面
    News*objectNews=[self.sortedDateArray objectAtIndex:indexPath.row-1];
    detailViewController.willToUrl = objectNews.web;
    detailViewController.sortedDateArray=self.sortedDateArray;
    detailViewController.inde=indexPath.row-1;
    //进入下一个页面
    [self.navigationController pushViewController:detailViewController animated:YES];
    NSLog(@"传送的网址%@",detailViewController.willToUrl);
    
    [detailViewController release];
}
#pragma mark －下拉刷新调用的关键方法
-(void)callHeaderMethod{
    //修改数据模型
//    NSLog(@"下拉刷新调用关键");
    [self.newsTitleArrayN removeAllObjects];
    [self.lookNoArrayN removeAllObjects];
    [self.dateArrayN removeAllObjects];
    [self.webArrayN removeAllObjects];
    [self.newsArrayN removeAllObjects];
    self.page=0;
    [self getData:self.page];
    [self.table reloadData];
    [self finishReloadingData];
}
#pragma mark －上拉刷新调用的关键方法
-(void)callFooterMethod{
    //修改数据模型
//    NSLog(@"上拉刷新调用关键");
    self.page+=1;
    [self getData:self.page];
    [self.table reloadData];
    //修改下部分视图的位置
    [self finishReloadingData];
}
#pragma mark －－创建上拉刷新视图
-(void)createFooter{
    
//    CGFloat height=MAX(self.table.contentSize.height, self.table.frame.size.height);
    NSLog(@"%d",self.newsTitleArrayN.count);
    CGFloat height=MAX(self.newsTitleArrayN.count*65+156-65, self.table.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview]) {
        _refreshFooterView.frame = CGRectMake(0.0f,height,self.view.frame.size.width,self.view.bounds.size.height);
    }else {
        self.refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0.0f, height,self.view.frame.size.width, self.view.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [self.table addSubview:_refreshFooterView];
    }
    if (_refreshFooterView) {
        [_refreshFooterView refreshLastUpdatedDate];
    }
}
//删除下拉刷新视图
-(void) removeFooter{
    if (self.refreshFooterView&&[self.refreshHeaderView superview]) {
        [self.refreshFooterView removeFromSuperview];
        self.refreshFooterView=nil;
    }
}
#pragma mark EGORefreshTableDelegate Methods
-(void) beginToReloadData:(EGORefreshPos)aRefreshPos{
    _reloading = YES;
    if (aRefreshPos == EGORefreshHeader) {
        [self performSelector:@selector(callHeaderMethod) withObject:nil afterDelay:2.0];
    }else if(aRefreshPos == EGORefreshFooter){
        [self performSelector:@selector(callFooterMethod) withObject:nil afterDelay:2.0];
    }
}
//协议代理方法（触发刷新）
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos{
	[self beginToReloadData:aRefreshPos];//调用自己创建的beginToReloadData:方法
}
//协议代理方法（判断是不是在更新数据资源）
- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
	return _reloading;
}
//协议代理方法重写
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view{
	return [NSDate date];
}
//这个类创建的方法
//当滚动视图时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
	if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    }
}
//滚动结束时调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
	if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}
- (void)reloadTableViewDataSource{
	_reloading = YES;
}
- (void)doneLoadingTableViewData{
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.table];
}
- (void)finishReloadingData{
	_reloading = NO;
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.table];
    }
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.table];
        [self createFooter];
    }
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
