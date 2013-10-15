//
//  ViewController.m
//  UI动画
//
//  Created by ibokan on 13-5-16.
//  Copyright (c) 2013年 ibokan. All rights reserved.
//
/*动画效果的实现方法可以分为：UIView动画、CA动画（Core Animation）
 *其实UIView动画化的底层也是CA，它是封装好的CA动画
 *一般的应用开发使用UIView就足够了
 *
 */




#import "ViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)move:(id)sender {
    UIImageView *bird = [[UIImageView alloc]initWithFrame:CGRectMake(30, 80, 45, 36)];
    bird.image = [UIImage imageNamed:@"Default.png"];
    [self.view addSubview:bird];
    
    /*
    //开始动画
    [UIView beginAnimations:@"hello" context:bird];//此处的context：可传的参数可以是任何OC对象
    [UIView setAnimationDuration:1];
    //设置代理对象
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];//设置动画代理，在动画结束时的方法。改方法可以随意些，但IOS有推荐方法：animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context 。它可以传多参数
    
    bird.center = CGPointMake(180, 80);//动画移动的方向
    
    [UIView commitAnimations];
    */
    
    //代码块：有些类似C中的函数指针 int (*number)(int)。是多线程运行的。
    
    //————————————UIView动画代码块:使用了块代码可以简化上方的代码量。要进行连续的动作时候
    [UIView animateWithDuration:2 animations:^{
        bird.center = CGPointMake(180, 80);//图片移向的方向，横线移动
    } completion:^(BOOL finished) {
        //前一个动画完成后再执行另一个动画代码块，代码块的嵌套
        [UIView animateWithDuration:2 animations:^{
            bird.center = CGPointMake(180, 280);//图片横线移动后实现竖向移动
        } completion:^(BOOL finished) {
            [bird removeFromSuperview];//移除tm的父视图
        }];
    }];
    
}

/*
//实现推荐的方法
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context//改方法最好点击进入setAnimationDidStopSelector复制过来
{
    NSLog(@"%@,%@,%@",animationID,finished,context);
    UIImageView *tm = (UIImageView *)context;
    [tm removeFromSuperview];//移除tm的父视图
    
}
*/

- (IBAction)trans:(id)sender {
    int idx = [self.seg selectedSegmentIndex];
    
    CGAffineTransform tf;
    if (idx == 0) {
        tf = CGAffineTransformMakeTranslation(20, 20);//相对初始时的位移
    }
    else if (idx == 1)
    {
        tf = CGAffineTransformTranslate(self.imgView.transform, 20, 20);//可以进行叠加位移（不止位移一次）
    }
    [UIView animateWithDuration:2 animations:^{
        self.imgView.transform = tf;
    } completion:^(BOOL finished) {
        nil;
    }];
    
}

- (IBAction)roation:(id)sender {
    int idx = [self.seg selectedSegmentIndex];
    
    CGAffineTransform tf;
    if (idx == 0) {
        tf = CGAffineTransformMakeRotation(M_PI_2);//旋转
    }
    else if (idx == 1)
    {
        tf = CGAffineTransformRotate(self.imgView.transform, M_PI_2);//可以进行叠加旋转
    }
    
    [UIView animateWithDuration:2 animations:^{//使用动画块
        self.imgView.transform = tf;//根据上面的判断结果运行效果
    } completion:^(BOOL finished) {
        nil;
    }];
    
    
}

- (IBAction)scal:(id)sender {
    int idx = [self.seg selectedSegmentIndex];
    
    CGAffineTransform tf;
    if (idx == 0) {
        tf = CGAffineTransformMakeScale(2, 2);//缩放
    }
    else if (idx == 1)
    {
        tf = CGAffineTransformScale(self.imgView.transform, 2, 2);//可以进行叠加缩放
    }
    [UIView animateWithDuration:2 animations:^{
        self.imgView.transform = tf;
    } completion:^(BOOL finished) {
        nil;
    }];
    
    
}

- (IBAction)invert:(id)sender {
    
    CGAffineTransform tf = CGAffineTransformInvert(self.imgView.transform);//实例化一个反转效果
    self.imgView.transform = tf;//通过transform将反转效果赋给imgView
}

- (IBAction)curlup:(id)sender {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    if (self.seg.selectedSegmentIndex == 0) {
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.imgView cache:YES];
    }
    else if (self.seg.selectedSegmentIndex == 1)
    {
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.imgView cache:YES];
    }
    [UIView commitAnimations];
}

- (IBAction)filp:(id)sender {
    /*//以下为ui动画执行透明效果的代码
    if (self.seg.selectedSegmentIndex == 0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:2];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.imgView cache:YES];
        [UIView commitAnimations];
    }
    else if (self.seg.selectedSegmentIndex == 1)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:2];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.imgView cache:YES];
        [UIView commitAnimations];
    }
     */
    //使用动画代码块
    [UIView animateWithDuration:2 animations:^{
        if (self.seg.selectedSegmentIndex == 0) {//判断segmentedControl组件的下标值,0时，向左边翻转
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.imgView cache:YES];
        }
        else if (self.seg.selectedSegmentIndex == 1){
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.imgView cache:YES];
        }
    } completion:^(BOOL finished) {
        nil;
    }];
    
    
}

- (IBAction)fly:(id)sender {
    //把关键的坐标存入数组，提供给ca动画的调用
    NSArray *pointArray = [NSArray arrayWithObjects:
                           [NSValue valueWithCGPoint:CGPointMake(50, 50)],
                           [NSValue valueWithCGPoint:CGPointMake(250, 50)],
                           [NSValue valueWithCGPoint:CGPointMake(250, 250)],
                           [NSValue valueWithCGPoint:CGPointMake(50, 250)],
                           nil];
    //ca关键点定义动画
    CAKeyframeAnimation *animtion = [CAKeyframeAnimation animationWithKeyPath:@"position"];//这里的关键字是根据提供的点进行移动
    animtion.values = pointArray;//获得数组中的坐标点
    animtion.duration  =2;
    [self.imgView.layer addAnimation:animtion forKey:nil];//此处的forkey是自己定义的
    
}

- (IBAction)espond:(id)sender {
    //CA动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    animation.fromValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];//将结构体CG类型的数值转换为NSValue
    animation.toValue = [NSValue valueWithCGSize:self.imgView.frame.size];
    animation.duration = 2;
    animation.repeatCount = 2;
    [self.imgView.layer addAnimation:animation forKey:nil];//将动画效果加入imgView的层，实现效果。ac动画只能对层layer进行操作
}

- (IBAction)opiction:(id)sender {
    
    /*//以下为ui动画执行透明效果的代码
        [UIView animateWithDuration:2 animations:^{
        [UIView setAnimationRepeatAutoreverses:YES];
        [UIView setAnimationRepeatCount:3];
        self.imgView.alpha = 0;
    } completion:^(BOOL finished) {
        self.imgView.alpha = 1;
    }];
     */
    //使用ca动画进行透明效果
    //创建ca动画对象,
    //ca动画的关键字是以形如 @"opacity" 的方法取出
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithInt:1];
    animation.toValue = [NSNumber numberWithInt:0];//动画@"opacity"重1变化到0
    animation.repeatCount = 3; 
    animation.duration = 3;
    [self.imgView.layer addAnimation:animation forKey:@"op"];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //创建图片
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 150, 200)];
    _imgView.image = [UIImage imageNamed:@"Icon.png"];
    [self.view addSubview:_imgView];
    
    //用layer为图片添加加阴影效果，注意要导入框架QuartzCore.framework才能使用
    [_imgView.layer setShadowColor:[UIColor blackColor].CGColor];//设置黑色阴影
    [_imgView.layer setShadowOffset:CGSizeMake(20, 20)];//设置阴影的偏移(20,20)
    [_imgView.layer setShadowOpacity:0.8];//设置阴影的透明度.透明度默认是完全透明的0
    [_imgView.layer setShadowRadius:5];
    
    _imgView.layer.borderWidth = 5;//设置图片的边框粗细
    _imgView.layer.borderColor =[UIColor redColor].CGColor;//设置边框颜色
//    [_imgView.layer setCornerRadius:20];//设置边角为圆，注意设置边角不能与设置阴影同时使用
//    [self.imgView.layer setMasksToBounds:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_seg release];
    [super dealloc];
}
@end
