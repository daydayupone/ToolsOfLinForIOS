//
//  ViewController.m
//  UI_04手势
//
//  Created by ibokan on 13-5-14.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize imgV,imgV2,gr;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //——————————————————————————UI常用组件测试
    
    //UISegmentedControl组件
    //创建数组存储常用数组的标题
    NSArray *ary = [NSArray arrayWithObjects:@"轻拍",@"双击",@"长按",@"轻扫",@"旋转",@"捏合",@"拖拽", nil];
    UISegmentedControl *sc = [[UISegmentedControl alloc]initWithItems:ary];
    sc.frame = CGRectMake(0, 480-40-20, 320, 40);//在ViewController加入常用组件的时候y轴为480-40-20，20为状态栏的高，40为组件的高，这样我们绘制的组件才会出现在寂寞的底部
    [self.view addSubview:sc];
    
    [sc addTarget:self action:@selector(shoushi:) forControlEvents:UIControlEventValueChanged];//注意：此处为值改变事件
    
    //UISlider组件
    UISlider *sl = [[UISlider alloc]initWithFrame:CGRectMake(100, 5, 100, 10)];
    sl.maximumValue = 10;//设置组件拖动条形时的最大值
    sl.minimumValue = 0 ;//设置组件的最小值
    [sl addTarget:self action:@selector(changevalue:) forControlEvents:UIControlEventValueChanged];//注意：此处也为值改变事件
    [self.view addSubview:sl];
    
  
    //UIImageView制作动画（帧动画）
    
    NSMutableArray *imgArry = [[NSMutableArray alloc]initWithCapacity:7];//用于存储图片截图的数组
    for (int i=1; i<7; i++) {//遍历6次
        UIImage *img1 = [UIImage imageNamed:[NSString stringWithFormat:@"run%d.tiff",i]];//获得不同名字的图片
        [imgArry addObject:img1];//将图片遍历进数组
    }
    imgV = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 260, 300)];
    imgV.animationImages = imgArry;//将存图片的数组放入动画图片
    imgV.animationDuration = 10.0f;//动作执行时间的长度
    [imgV startAnimating];//开始动画
    
    [self.view addSubview:imgV];
    
    //创建图片
    imgV2 = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 260, 300)];
    imgV2.image = [UIImage imageNamed:@"h1.jpeg"];
    imgV2.userInteractionEnabled = YES;//图形的交互默认情况下是NO
    [self.view addSubview:imgV2];
    
}

//UISlider组件的方法
- (void)changevalue:(UISlider *)sender
{
    NSLog(@"%f",sender.value/*获得滑动条变化的数值*/);
    if (self.imgV.isAnimating) {//对slider进行操作时
        [self.imgV stopAnimating];//帧动画停止
    }
    self.imgV.animationDuration = sender.value;//UISlider对象转化成具体数值，赋值给帧动画的执行时间
    [self.imgV startAnimating];//帧动画开启
}
//添加UISegmentedControl组件调用的方法
- (void)shoushi:(UISegmentedControl *)sender
{
    NSLog(@"%d",sender.selectedSegmentIndex/*获得组件中被选中按钮的下标*/);
    
    //通过UISegmentedControl的下标判断执行的手势
    int idx = sender.selectedSegmentIndex;//将点击下标存入整型的idx中
    
    /*
     UITapGestureRecognizer       轻拍
     UIPinchGestureRecognizer     捏合
     UIRotationGestureRecognizer  旋转
     UISwipeGestureRecognizer     清扫
     UIPanGestureRecognizer       托拽
     UILongPressGestureRecognizer 长按
     */
    
    //为了不令手势效果叠加，移除其他判断时实现的手势
    [imgV2 removeGestureRecognizer:gr];
    switch (idx) {
            //创建单击手势
        case 0:
        {
            gr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];//创建手势控制器
            [self.imgV2 addGestureRecognizer:gr];//手势添加进imgV2
            break;
        }
            //创建双击手势
        case 1:
        {
            gr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2:)];//创建手势控制器
            //gr的父类UIGestureRecognizer没有点击的属性，要进行强转（涉及到父子类继承关系简化代码）
            UITapGestureRecognizer *tm = (UITapGestureRecognizer *)self.gr;
            tm.numberOfTapsRequired = 2;
            break;
        }
        case 2://长按
        {
            gr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
            break;
        }
        case 3://轻扫
        {
            gr = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
            //因为gr在定义成属性的时候是所有手势的父类UIGestureRecognizer，需要得到清扫的用法就要强制转换成UISwipeGestureRecognizer
            UISwipeGestureRecognizer *tm = (UISwipeGestureRecognizer *)self.gr;
            tm.direction = UISwipeGestureRecognizerDirectionLeft;//设定接受清扫的方向：向左扫
            break;
        }
        case 4://旋转
        {
            gr = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotatinon:)];
            break;
        }
        case 5://粘合
        {
            gr = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
            break;
        }
        case 6://拖拽
        {
            gr = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
            break;
        }
        default:
            break;
    }
    
    [self.imgV2 addGestureRecognizer:gr];//手势添加进imgV2
    
    
}
//手势控制器调用的方法单击
- (void)tap:(UITapGestureRecognizer *)sender
{
    //对触点和点击进行逻辑判断
    if (sender.numberOfTouches==1/*一个触摸点*/ && sender.numberOfTapsRequired==1/*单击*/) {
        NSLog(@"单击");
        imgV2.image = [UIImage imageNamed:@"h2.jpeg"];//单击事件发生时，换图片
    }
}
//手势控制器调用的方法双击
- (void)tap2:(UITapGestureRecognizer *)sender
{
    if (sender.numberOfTouches==1/*一个触摸点*/ && sender.numberOfTapsRequired==2/*双击*/) {//
        NSLog(@"双击");
        [UIView beginAnimations:nil context:nil];
        [UIView animateWithDuration:1 animations:nil];
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.imgV2 cache:YES];//翻转的效果
        imgV2.image = [UIImage imageNamed:@"h3.jpeg"];
        [UIView commitAnimations];//开启动画
        
        
    }
}
- (void)longPress:(UILongPressGestureRecognizer *)sender
{
    NSLog(@"长按");
    //动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    imgV2.image = [UIImage imageNamed:@"h4.jpeg"];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.imgV2 cache:YES];
    [UIView commitAnimations];//提交动画
    
    
}
- (void)swipe:(UISwipeGestureRecognizer *)sender
{
    NSLog(@"轻扫");
//if (sender.direction==UIViewAnimationTransitionFlipFromRight) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:2];
        imgV2.image = [UIImage imageNamed:@"h5.jpeg"];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.imgV2 cache:YES];
        [UIView commitAnimations];
//    }
//    else if (sender.direction==UIViewAnimationTransitionFlipFromLeft) {
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:2];
//        imgV2.image = [UIImage imageNamed:@"h4.jpeg"];
//        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:   self.imgV2 cache:YES];
//        [UIView commitAnimations];
//    }

}
- (void)rotatinon:(UIRotationGestureRecognizer *)sender
{
    NSLog(@"旋转");
    imgV2.transform = CGAffineTransformMakeRotation(sender.rotation);//涉及线性代数，不过记住就行了
    
}
- (void)pinch:(UIPinchGestureRecognizer *)sender
{
    NSLog(@"捻合");
    imgV2.transform = CGAffineTransformMakeScale(sender.scale, sender.scale);//使用transform进行放大缩小
}

CGPoint startPoint;//直接定义全局变量，整个类中都能用
- (void)pan:(UIPanGestureRecognizer *)pan
{
    NSLog(@"拖拽");
    //有BUG的代码1：
//    startPoint = self.imgV2.center;//起始点
//    CGPoint endPoint = [pan locationInView:self.view];
//    self.imgV2.transform = CGAffineTransformMakeTranslation(endPoint.x-startPoint.x, endPoint.y-startPoint.y);//使用巨震移动图片
    //有BUG的代码2：
//    CGPoint location = [pan locationInView:self.view];
//    pan.view.center = location;

    CGPoint translation = [pan translationInView:self.view];//获得父视图上手势的点
    imgV2.center = CGPointMake(pan.view.center.x + translation.x, pan.view.center.y + translation.y);//图片的中心重置，以达到移动的效果
    [pan setTranslation:CGPointMake(0, 0) inView:self.view];//  注意一旦你完成上述的移动，将translation重置为0十分重要。否则translation每次都会叠加，很快你的view就会移除屏幕！
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
