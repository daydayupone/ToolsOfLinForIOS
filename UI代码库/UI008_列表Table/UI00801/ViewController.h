#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain,nonatomic) UITableView *tv;

@property (retain,nonatomic) NSArray *stuArray,*keyArray;//keyArray存储用于显示的区头内容

@property (retain,nonatomic) NSDictionary *stuDic;//用于存放JSON解析出来的数据
@end
