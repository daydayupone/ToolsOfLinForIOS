//
//  XpathViewController.m
//  UI0013框架
//
//  Created by ibokan on 13-6-9.
//  Copyright (c) 2013年 Miguel. All rights reserved.
//

#import "XpathViewController.h"
#import "TFHpple.h"

@interface XpathViewController ()

@end

@implementation XpathViewController

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
    NSURL *url=[NSURL URLWithString:@"http://news.baidu.com/"];
    ASIHTTPRequest *req=[ASIHTTPRequest requestWithURL:url];
    req.delegate=self;
    [req startAsynchronous];
    self.tbl=[[UITableView alloc]initWithFrame:self.view.frame];
    self.tbl.delegate=self;
    self.tbl.dataSource=self;
    [self.view addSubview:self.tbl];
    self.namearr=[[NSMutableArray alloc]init];
	// Do any additional setup after loading the view.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.namearr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStr=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
    NSString *name=[self.namearr objectAtIndex:indexPath.row];
    NSLog(@"name=%@",name);
    cell.textLabel.text=name;
    return cell;
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    NSError *error=[request error];
    if (error) {
        NSLog(@"error=%@",error);
    }else{
        NSString *repStr=[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding];
        NSLog(@"返回内容：%@",repStr);
        TFHpple *xpath=[[TFHpple alloc]initWithHTMLData:[request responseData]];//创建基于xpath解析html的类对象
        NSArray *ary=[xpath searchWithXPathQuery:@"/html/body/div[@id='body']/div[@id='focus-top']/div[1]/ul[1]/li[4]/a"];
        NSLog(@"%@",ary);
//        for(int i=0;i<[ary count];i++)
//        {
//            TFHppleElement *element = [ary objectAtIndex:i];
//            NSString *myTitle = [element content];
//            NSLog(@"myTitle=%@,i=%d,count=%d", myTitle,i,[ary count]);
//            [self.namearr addObject:myTitle];
//        }
//        NSLog(@"namearr=%@",[self.namearr objectAtIndex:0]);
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
