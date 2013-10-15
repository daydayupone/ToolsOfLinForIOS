//
//  AppDelegate.m
//  UI-Test-图书管理
//
//  Created by ibokan on 13-5-30.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "FavoriteViewController.h"
#import "SearchViewController.h"
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
    
    //控制器初始化
    HomeViewController *home=[[HomeViewController alloc]init];
    FavoriteViewController *fa=[[FavoriteViewController alloc]init];
    SearchViewController *se=[[SearchViewController alloc]init];
    
    //导航条初始化
    UINavigationController *homeNv=[[UINavigationController alloc]initWithRootViewController:home];
    UINavigationController *faNv=[[UINavigationController alloc]initWithRootViewController:fa];
   
    home.navigationItem.title=@"图书管理";//导航条赋名字
    fa.navigationItem.title=@"收藏夹";
    /*
     UIBarStyleDefault          = 0,
     UIBarStyleBlack            = 1,
     
     UIBarStyleBlackOpaque      = 1,
     UIBarStyleBlackTranslucent = 2
     */
    //黑色导航条
    homeNv.navigationBar.barStyle= UIBarStyleBlack;
    faNv.navigationBar.barStyle=UIBarStyleBlack;
    
    //初始化页签控制器
    NSArray *tbArr=[NSArray arrayWithObjects:homeNv,faNv,se, nil];
    UITabBarController *tbController=[[UITabBarController alloc]init];
    tbController.viewControllers =tbArr;
    //页签赋名字和图片
    homeNv.tabBarItem.title=@"主页";
    homeNv.tabBarItem.image=[UIImage imageNamed:@"icon_home" ];
    faNv.tabBarItem.title=@"收藏夹";
    faNv.tabBarItem.image=[UIImage imageNamed:@"icon_fav" ];
    se.tabBarItem.title=@"搜索";
    se.tabBarItem.image=[UIImage imageNamed:@"icon_search" ];
    self.window.rootViewController = tbController;
    [self.window makeKeyAndVisible];
    return YES;
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
