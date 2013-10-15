//
//  DrawView.m
//  UI003
//
//  Created by ibokan on 13-5-10.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView


//初始化方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化属性
        self.lineArray = [[NSMutableArray alloc] init];
        
        //创建Button
        UIButton *btn = [UIButton buttonWithType:1];
        btn.frame = CGRectMake(100, 350, 100, 50);
        [btn setTitle:@"撤销" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(chexiao:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

//创建撤销方法
- (void)chexiao:(id)sender
{
    //移除线数组中的每一画
    [self.lineArray removeLastObject];
    //调用重绘
    [self setNeedsDisplay];
}

//——————————————————————提供触摸开始、移动的方法

//触摸开始触发该函数
//集合对象touches代表触摸时候的触点
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //点数组
    NSMutableArray *pointArray = [[NSMutableArray alloc] init];
    //将点数组放入线数组
    [self.lineArray addObject:pointArray];
    
    //获取容器中任意一个值（点）
    UITouch *touch = [touches anyObject];
    //获得触摸对应视图的位置
    CGPoint pt = [touch locationInView:self];
    
    //触点放入数组前，使用 NSValue valueWithCGPoint： 将结构体的CGPoint对象转化为OC语言的NSValue对象
    [pointArray addObject:[NSValue valueWithCGPoint:pt]];
    //在控制台打印出点击的坐标
    NSLog(@"%@",[[self.lineArray lastObject]lastObject]);
}

//触摸移动触发该函数
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    //获得触摸对应视图的位置
    CGPoint pt = [touch locationInView:self];
    
    //触点放入数组前，使用 NSValue valueWithCGPoint： 将结构体的CGPoint对象转化为OC语言的NSValue对象
    [[self.lineArray lastObject] addObject:[NSValue valueWithCGPoint:pt]];
    
    NSLog(@"%@",[[self.lineArray lastObject]lastObject]);
    
    //强制重绘界面,由系统调用 drawRect: 绘图方法。只有这样运行后才能有绘图效果
    [self setNeedsDisplay];
    
}

//绘图的方法
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    //CGContextRef是C中的函数库默认情况下，该库CoreGraphics.framework已经是导入的
    
    //检索当前的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置笔画的颜色
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    //设置笔画的粗细
    CGContextSetLineWidth(context,2);
    //循环线数组拿到内不的点数组
    for (int i=0; i<self.lineArray.count; i++) {
        //取到线中的点数组
        NSMutableArray *ptArray = [self.lineArray objectAtIndex:i];
        //循环遍历数组取出其中的点
        for (int j=0; j<ptArray.count-1; j++) {//为了防止循环的溢出-1
            //获得点数组中的所有点元素
            NSValue *p1 = [ptArray objectAtIndex:j];
            //将之前转换为NSValue对象的值，转换回CGPoint类型的值
            CGPoint pt1 = [p1 CGPointValue];
            
            NSValue *p2 = [ptArray objectAtIndex:j+1];
            CGPoint pt2 = [p2 CGPointValue];
            
            //指定绘制的起点
            CGContextMoveToPoint(context, pt1.x, pt1.y);//这个是c中的数据结构，它用“（ ）” 来写入参数可以看出。
            //指定绘制的起点
            CGContextAddLineToPoint(context, pt2.x, pt2.y);
            //绘制图片
        }
        CGContextStrokePath(context);
    }
}


@end
