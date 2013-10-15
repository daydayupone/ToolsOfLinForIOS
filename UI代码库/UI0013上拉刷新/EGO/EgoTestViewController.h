#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
@interface EgoTestViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,EGORefreshTableDelegate>
{
    EGORefreshTableHeaderView *tblHeader;
    EGORefreshTableFooterView *tblFooter;
    BOOL _reloading; 
}
@property (retain,nonatomic) UITableView *tbl;
@property (retain,nonatomic) NSMutableArray *array;
@end
