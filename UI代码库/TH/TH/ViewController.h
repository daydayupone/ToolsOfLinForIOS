#import <UIKit/UIKit.h>
#import "ASIHttpRequest/ASIHTTPRequest.h"
@interface ViewController : UIViewController<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) UITableView *myTableView;
@property (retain, nonatomic) NSArray * elements;
@end
