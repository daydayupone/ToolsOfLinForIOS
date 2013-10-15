#import "EgoTestViewController.h"
@interface EgoTestViewController ()
@end

@implementation EgoTestViewController

//初始化
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //准备好的本地数据
        self.array=[[NSMutableArray alloc]initWithObjects:@"王清平",@"豹子",@"颜振洋",@"魏裕群", nil];
        // Custom initialization
    }
    return self;
}

#pragma mark 单元格代理方法
//确定列表的分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//根据数组内容确定单元格行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;
}
//单元格的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置单元格的复用
    static NSString *cellStr=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    //获取数组里的元素
    NSString *name=[self.array objectAtIndex:indexPath.row];
    cell.textLabel.text=name;
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tbl=[[UITableView alloc]initWithFrame:self.view.frame];
    //单元格列表的代理方法
    self.tbl.delegate=self;
    self.tbl.dataSource=self;
    [self.view addSubview:self.tbl];
    
    ///----------//判断下拉刷新视图是否空
    if (tblHeader==nil) {
        tblHeader= [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f,-self.tbl.bounds.size.height,self.tbl.frame.size.width, self.view.bounds.size.height)];
        tblHeader.delegate = self;
        [self.tbl addSubview:tblHeader];
    }
    if (tblFooter==nil) {//判断下拉刷新视图是否空
        tblFooter= [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0.0f,10.0-self.tbl.bounds.size.height,self.tbl.frame.size.width, self.view.bounds.size.height)];
        tblHeader.delegate = self;
        [self.tbl addSubview:tblHeader];
    }
    [tblHeader refreshLastUpdatedDate];
    //------------
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark –
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    NSLog(@"==开始加载数据");
    //数据重新加载
    [self.array addObject:@"孙气质"];
    _reloading = YES;
}

- (void)doneLoadingTableViewData{
    NSLog(@"===加载完数据");
    //界面重新加载
    [self.tbl reloadData];
    _reloading = NO;
    [tblHeader egoRefreshScrollViewDataSourceDidFinishedLoading:self.tbl];
}
#pragma mark –
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [tblHeader egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [tblHeader egoRefreshScrollViewDidEndDragging:scrollView];
}
#pragma mark –
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos{
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
    return _reloading;
}

- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view{
    
    return [NSDate date];

}
@end
