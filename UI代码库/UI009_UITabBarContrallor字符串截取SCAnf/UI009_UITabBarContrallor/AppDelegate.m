//
//  AppDelegate.m
//  UI009_UITabBarContrallor
//
//  Created by ibokan on 13-5-27.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThireViewController.h"
#import "FourViewController.h"
#import "FireViewController.h"
#import "SixViewController.h"



@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    //创建要加入TabBar之中的几个ViewController
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    //创建默认的item效果，可以加入
    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:1];
    self.viewController.tabBarItem = item1;
    
    //self.viewController.tabBarItem.title = @"主页1";
//    self.viewController.tabBarItem.image = 
    OneViewController *one = [[[OneViewController alloc]init]autorelease];
    one.tabBarItem.title = @"主页";
    //设置图标
    one.tabBarItem.image = [UIImage imageNamed:@"icon_home.png"];
    //设置小字符
    one.tabBarItem.badgeValue = @"H";
    
    //
    TwoViewController *two = [[[TwoViewController alloc]init]autorelease];
    two.tabBarItem.title = @"信息";
    two.tabBarItem.image = [UIImage imageNamed: @"icon_meassage.png"];
    
    //
    ThireViewController *thire = [[[ThireViewController alloc]init]autorelease];
    thire.tabBarItem.title = @"主页4";
    thire.tabBarItem = item1;
    
    //
    FourViewController *four = [[[FourViewController alloc]init]autorelease];
    four.tabBarItem.title = @"联系人";
    four.tabBarItem.image = [UIImage imageNamed: @"icon_selfinfo"];
    
    //
    FireViewController *fire = [[[FireViewController alloc]init]autorelease];
    fire.tabBarItem.title = @"地图";
    
    //在TabBarController之中加入一个导航控制器
    SixViewController *six = [[[SixViewController alloc]init]autorelease];
    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:six];//initWithRootViewController:是将SixViewController 的对象six加入导航
    UITextView
    nv.title = @"一个导航控制器";
    
    //创建存放ControlView的数组
    NSArray *barArray = [NSArray arrayWithObjects:one,two,thire,four,fire,self.viewController,nv,nil];
    
    //创建一个TabBarController
    UITabBarController *tbc = [[UITabBarController alloc]init];
    //
    tbc.viewControllers = barArray;
    //设置UITabBarControllerDelegate协议的代理
    tbc.delegate = self;
    
    //将tab设置为根视图
    self.window.rootViewController = tbc;
    [self.window makeKeyAndVisible];
    
    //释放内存
    [tbc release];
    
    
    return YES;
}

//UITabBarControllerDelegate协议的方法
int flag = 0;
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    /*
     ------------用于逻辑判断的常用代码
     
     //判断viewController是否属于OneViewController类的类或子类
     [viewController isKindOfClass:[OneViewController class]
    
     //判断对象是否遵循了协议
     [viewController conformsToProtocol:@protocol(<#protocol-name#>)];
     
     //判断释放遵循了某方法
     [viewController respondsToSelector:<#(SEL)#>];
     
     */
    
    //判断viewController是否属于OneViewController类的对象，如果是，每点击一次， badgeValue值 加 1
    if ([viewController isMemberOfClass:[OneViewController class]]) {
        
         viewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",++flag];
    }
    
    
//    if (tabBarController.selectedIndex == 1) {//判断选项卡的索引
//        viewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",++flag];
//    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
