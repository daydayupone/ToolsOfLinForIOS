#import "ViewController.h"
#import "DrawView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    DrawView*dv=[[DrawView alloc]initWithFrame:self.view.frame];//创建一个DrawView*dv跟系统默认创建的UIview一样大
    [self.view addSubview:dv];//将DrawView*dv添加到view上
    dv.backgroundColor=[UIColor yellowColor];
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
