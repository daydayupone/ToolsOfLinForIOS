#import "ViewController.h"
#import "ASIHttpRequest/ASIHTTPRequest.h"
@interface ViewController ()
@end
@implementation ViewController
@synthesize imgview;

//异步代理函数
-(void)requestFinished:(ASIHTTPRequest*) request{
    //异常信息
    NSError *error=[request error];
    //判断是否异常
    if (error) {
        NSLog(@"错误信息是:%@",error);
    }else{
        UIImage *img=[UIImage imageWithData:[request responseData]];
        self.imgview.image=img;
    }
}

-(void) testASIHttprequest{
    NSURL *url=[NSURL URLWithString:@"http://www.apple.com.cn/home/images/billboard_iphone_hero.jpg"];
    ASIHTTPRequest *req=[ASIHTTPRequest requestWithURL:url];
    req.delegate=self;
    //同步请求
//    [req startSynchronous];
    //异步请求
    [req startAsynchronous];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self testASIHttprequest];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setImgview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [imgview release];
    [super dealloc];
}
@end
