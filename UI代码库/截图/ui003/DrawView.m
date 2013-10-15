#import "DrawView.h"

@implementation DrawView
@synthesize lineArray;
-(void)chexiao:(id)sender{//单击按钮触发事件
    [self.lineArray removeLastObject];//撤销最后一笔
    [self setNeedsDisplay];//调用强制重画
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.lineArray=[[NSMutableArray alloc]init];//初始化线数组
        //创建一个按钮
        UIButton*btn=[UIButton buttonWithType:1];
        btn.frame=CGRectMake(100, 350, 100, 50);
        [btn setTitle:@"撤销" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(chexiao:) forControlEvents:UIControlEventTouchUpInside];//
        [self addSubview:btn];
        
    }
    return self;
}
//触摸开始方法---集合对象(NSSet *)touches---以后接触复杂编程时用(UIEvent *)event---
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSMutableArray*pointArray=[[NSMutableArray alloc]init];//创建点数组
    [self.lineArray addObject:pointArray];//将点数组放入线数组中
    
    UITouch*touch=[touches anyObject];//获取的触摸对象
    CGPoint pt=[touch locationInView:self];//获取触摸对应视图的位置
    [pointArray addObject:[NSValue valueWithCGPoint:pt]];//用[NSValue valueWithCGPoint:pt]将c结构体CGPoint pt转化为OC的NSValue对象类型，触点放入数组pointArray
    NSLog(@"%@",[[self.lineArray lastObject]lastObject]);
}
//---------------------------触摸移动方法-------------------------
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch*touch=[touches anyObject];//获取的触摸对象
    CGPoint pt=[touch locationInView:self];//获取触摸对应视图的位置
    [[self.lineArray lastObject] addObject:[NSValue valueWithCGPoint:pt]];//用[NSValue valueWithCGPoint:pt]将c结构体CGPoint pt转化为OC的NSValue对象类型，触点放入数组pointArray
    NSLog(@"%@",[[self.lineArray lastObject]lastObject]);
    [self setNeedsDisplay];//要求一移动就重绘界面,调用(void)drawRect:(CGRect)rect方法
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect//自定义绘图
{
    CGContextRef ref=UIGraphicsGetCurrentContext();//拿到一个上下文
    CGContextSetStrokeColorWithColor(ref, [[UIColor redColor]CGColor]);//在指定上下文中设置壁画的颜色
    CGContextSetLineWidth(ref, 1.2f);//在指定上下文中设置线宽
    for (int i=0; i<self.lineArray.count; i++) {//
        NSMutableArray*ptArray=[self.lineArray objectAtIndex:i];//
        for (int j=0; j<ptArray.count-1; j++) {//
            NSValue*p1=[ptArray objectAtIndex:j];//
            CGPoint pt1=[p1 CGPointValue];//
            NSValue*p2=[ptArray objectAtIndex:j+1];//
            CGPoint pt2=[p2 CGPointValue];//
            CGContextMoveToPoint(ref, pt1.x, pt1.y);//指定绘图的起始点
            CGContextAddLineToPoint(ref, pt2.x, pt2.y);//指定绘图的终点
        }
    }
     CGContextStrokePath(ref);
}


- (void)doubleTap //双击翻转方法
{
    [UIView beginAnimations:@"turn" context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];//设置动画效果 向右侧翻转
    [UIView commitAnimations];
}
/*
 判断点击的次数使用     int tapCount = touch.tapCount;
 判断触点的数量        int  touchCount=[touches count]
*/
/*动画
 [UIView beginAnimations:nil context:nil];
 [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
 [UIView setAnimationDuration:1];
 [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self cache:NO];//上翻
 [UIView commitAnimations];
*/
/*
 [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self cache:NO]; 下翻页
 */
@end
