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
        NSString *respStr=[[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding];
        NSLog(@"返回内容：%@",respStr);
        TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:[request responseData]];//创建基于xpath解析html的类对象
        NSArray *ary=[xpathParser searchWithXPathQuery:@"/html/body/div[@id='body']/div[@id='focus-top']/div[1]/div[contains(concat(' ', @class, ' '), ' hotnews ')]/ul/li[1]/strong/a  "];
        
        //NSLog(@"one=%@",[ary objectAtIndex:0]);
        NSLog(@"two=%@",ary);
        /*
        for(int i=0;i<[ary count];i++)
        {
            NSArray *ary2=[xpathParser searchWithXPathQuery:[NSString stringWithFormat:@"/html/body[contains(concat(' ', @class, ' '), '  ')]/div[contains(concat(' ', @class, ' '), ' column3 ')]/div/div/div[contains(concat(' ', @class, ' '), ' left_2c ')]/div[contains(concat(' ', @class, ' '), ' column3_sub_left ')]/div[@id='top_a_week']/div/div[2]/ul/li[%d]/a[2]",i+1]];
            for (TFHppleElement *element in ary2) {
                NSString *myTitle = [element content];
                NSLog(@"myTitle=%@", myTitle);
            }
        }
        */
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url=[NSURL URLWithString:@"http://www.weiphone.com/"];
    ASIHTTPRequest *req=[ASIHTTPRequest requestWithURL:url];
    req.delegate=self;
    [req startAsynchronous];
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

@end
