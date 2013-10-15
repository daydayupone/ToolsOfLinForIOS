//
//  refreshViewController.m
//  UI0013框架
//
//  Created by ibokan on 13-6-9.
//  Copyright (c) 2013年 Miguel. All rights reserved.
//

#import "refreshViewController.h"

@interface refreshViewController ()

@end

@implementation refreshViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.ary=[[NSMutableArray alloc]initWithObjects:@"清平",@"豹子",@"鱼群",@"真阳",nil];
    }
    return self;
}
//分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ary.count;
}
//行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStr=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
    NSString *name=[self.ary objectAtIndex:indexPath.row];
    cell.textLabel.text=name;
    return cell;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tbl=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.tbl.delegate=self;
    self.tbl.dataSource=self;
    [self.view addSubview:self.tbl];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
