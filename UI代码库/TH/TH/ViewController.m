#import "ViewController.h"
#import "TFHpple.h"
@interface ViewController ()
@end
@implementation ViewController
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSError *error=[request error];
    if (error) {
        NSLog(@"%@",error);
    }else{
//        NSString *respStr=[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding];
        /*
        NSLog(@"返回内容：%@",respStr);
        TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:[request responseData]];//创建基于xpath解析html的类对象
        NSArray *ary=[xpathParser searchWithXPathQuery:@"/html/body[contains(concat(' ', @class, ' '), '  ')]/div[contains(concat(' ', @class, ' '), ' column3 ')]/div/div/div[contains(concat(' ', @class, ' '), ' left_2c ')]/div[contains(concat(' ', @class, ' '), ' column3_sub_left ')]/div[@id='top_a_week']/div/div[2]/ul/li"];
        
        NSLog(@"one=%@",[ary objectAtIndex:0]);
        
        for(int i=0;i<[ary count];i++)
        {
            NSArray *ary2=[xpathParser searchWithXPathQuery:[NSString stringWithFormat:@"/html/body[contains(concat(' ', @class, ' '), '  ')]/div[contains(concat(' ', @class, ' '), ' column3 ')]/div/div/div[contains(concat(' ', @class, ' '), ' left_2c ')]/div[contains(concat(' ', @class, ' '), ' column3_sub_left ')]/div[@id='top_a_week']/div/div[2]/ul/li[%d]/a[2]",i+1]];
            for (TFHppleElement *element in ary2) {
                NSString *myTitle = [element content];
                NSLog(@"myTitle=%@", myTitle);
            }
        }
        */
        TFHpple *tfHpple = [[TFHpple alloc]initWithHTMLData:[request responseData]];
        self.elements = [tfHpple searchWithXPathQuery:@"//div[@id='top_a_week']//div//div[2]//ul//li//a[2] "];
        for(int i=0;i<[self.elements count];i++)
        {
            TFHppleElement *element = [self.elements objectAtIndex:i];
            NSString *myTitle = [element content];
            //self.showToMan.text = myTitle;
            NSLog(@"%@", myTitle);
            if ( 0==i )
            {
                // self.showToMan.text = myTitle;
            }
        }
        
        
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url=[NSURL URLWithString:@"http://www.weiphone.com/"];
    ASIHTTPRequest *req=[ASIHTTPRequest requestWithURL:url];
    req.delegate=self;
    [req startAsynchronous];
    [req setCompletionBlock:^{
        nil;
    }];
    [req setFailedBlock:^{
        nil;
    }];
    self.myTableView = [[UITableView alloc]initWithFrame:self.view.frame];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.view addSubview:self.myTableView];
    
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.elements.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //NSString *text1 = [self.dataArray objectAtIndex:indexPath.row];
    TFHppleElement *element = [self.elements objectAtIndex:indexPath.row];
    NSString *myTitle = [element content];
    cell.textLabel.text = myTitle;
    //cell.textLabel.text = @"dd" ;
    NSLog(@"单元格");
    return cell;
}


//- (void) viewWillAppear:(BOOL)animated
//{
////    [self viewWillAppear:animated];
//    [self.myTableView reloadData];
//}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
