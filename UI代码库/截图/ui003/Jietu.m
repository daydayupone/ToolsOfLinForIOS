//
//  Jietu.m
//  ui003
//
//  Created by 颜振洋 on 13-5-10.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import "Jietu.h"
#import <QuartzCore/QuartzCore.h>
@implementation Jietu
@synthesize pt1,pt2;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.img1=[[UIImage alloc]init];
        self.vimg=[[UIImageView alloc]init];
    }
    return self;
}
//----------------------触摸开始时创建起始点-------------------------
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch*touch=[touches anyObject];//获取的触摸对象，起始点
    self.pt1=[touch locationInView:self];//获取触摸对应视图的位置
}
//---------------触摸移动时创建终止点,并画出虚线矩形-------------------
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch*touch=[touches anyObject];//获取的触摸对象
    self.pt2=[touch locationInView:self];//获取触摸对应视图的位置
    [self setNeedsDisplay];//要求一移动就重绘界面,调用(void)drawRect:(CGRect)rect方法
}
//---------触摸结束时创建一个图相框架，并将图片按矩形框架大小截取---------
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //--------用截图方法截取一个图形，并创建一个相框装，让他显示出来------
    self.img1=[self captureView:self frame: CGRectMake(self.pt1.x,self.pt1.y,self.pt2.x-self.pt1.x,self.pt2.y-self.pt1.y)];//截图
    self.vimg.frame=CGRectMake(self.pt1.x,self.pt1.y,self.pt2.x-self.pt1.x,self.pt2.y-self.pt1.y);//创建相框
    self.vimg.image=self.img1;//图片属性
    [self addSubview:self.vimg];//显示出来
    //------------------创建一个动画效果----------------------------
    [UIView beginAnimations:nil context:nil];//开启动画
    [UIView setAnimationDuration:0.5];//动画时长
    self.vimg.frame=CGRectMake(0, 0, self.pt2.x-self.pt1.x,self.pt2.y-self.pt1.y);//将图片移到原点位置
    [UIView commitAnimations];//动画提交，开始执行动画
}
//----------------------自定义绘图---------------------------------
- (void)drawRect:(CGRect)rect
{
    CGContextRef ref=UIGraphicsGetCurrentContext();//拿到一个上下文
    CGContextSetStrokeColorWithColor(ref, [[UIColor redColor]CGColor]);//在指定上下文中设置画笔的颜色
    CGContextSetLineWidth(ref, 1.2f);//在指定上下文中设置线宽
    CGFloat dashPattern[10]={10.0,10.0};
    CGContextSetLineDash(ref, 10.0, dashPattern, 2);//画虚线
    CGContextAddRect(ref, CGRectMake(self.pt1.x,self.pt1.y,self.pt2.x-self.pt1.x,self.pt2.y-self.pt1.y));//画矩形
    CGContextStrokePath(ref);
}
//---------------------截图方法-----------------------------
-(UIImage*)captureView:(UIView *)theView frame:(CGRect)fra{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, fra);
    UIImage *i = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);
    return i;
}
@end
