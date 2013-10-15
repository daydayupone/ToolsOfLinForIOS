//
//  AppDelegate.m
//  UI007_CoreData_Cell

//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"
#import "ViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    [super dealloc];
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    //添加导航栏
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    //将导航栏设置为根控制
    self.window.rootViewController = nav ;
    
    [self.window makeKeyAndVisible];
    //调用存储数据的方法，注意：如果代码写在这里将会出现每运行一次添加一行一样的数据
    /*
    NSNumber *two = [NSNumber numberWithInt:2];
    [self saveStudentName:@"GOU" andNumber:two andPhone:@"123-456" andHead:nil];
    NSLog(@"代理中实现数据的存储");
    */
    [self.window makeKeyAndVisible];
    return YES;
}

//增加数据
- (void) saveStudentName:(NSString *) aName andNumber:(NSNumber *) anId andPhone:(NSString *)aPhone andHead:(NSData *)aHead{
    
    //创建受托管对象
    Student *stu1 = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    
    //给stu1对象赋值
    if (stu1 != nil) {//如果对象的属性不为空
        //进行赋值
        stu1.stuname = aName;
        stu1.stuid = anId;
        stu1.stuphone = aPhone;
        stu1.stuhead = aHead;
        
        NSError *error = nil;
        if ([self.managedObjectContext save:&error]) {//存储数据
            NSLog(@"存储成功");
        }else{
            NSLog(@"存储失败error=%@",error);
        }
        
    }
    
    
}
//删除数据的方法
-(void) deleteACellFromDbWithId:(NSNumber*) tempid{
    //获得数据库
    NSFetchRequest *req=[[NSFetchRequest alloc]init];
    NSEntityDescription *eny=[NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    req.entity=eny;
    
    NSPredicate *pd=[NSPredicate predicateWithFormat:@"stuid == %@",tempid];
    req.predicate=pd;
    NSArray *stA=[self.managedObjectContext executeFetchRequest:req error:nil];
    
    if (stA.count>0) {
        Student *b =[stA lastObject];
//        Student *b =[stA objectAtIndex:[tempid intValue]];
        [self.managedObjectContext deleteObject:b];
        NSError *error=nil;
        if ([ self.managedObjectContext save:&error]) {
            NSLog(@"删除成功");
        }else{
            NSLog(@"删除失败");
        }
    }
}

//找出所有存储好的数据内容
-(NSArray*) findall{
    //获得数据库里的数据
    NSFetchRequest *req=[[NSFetchRequest alloc]init];
    NSEntityDescription *eny=[NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    req.entity=eny;
    //将数据库的数据取出，存储进数组之中
    NSArray *stA=[self.managedObjectContext executeFetchRequest:req error:nil];
    //返回存储有数据库内容的数组
    return stA;
}
//更新数据

- (void) upDataName:(NSString *)aName andNumber:(NSNumber *) anId andPhone:(NSString *)aPhone andHead:(NSData *)aHead{
    NSLog(@"更新");
    //获取数据库数据
    NSFetchRequest *req = [[NSFetchRequest alloc]init];
    NSEntityDescription *eny = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    req.entity = eny;
    
    //使用oc的关键字NSPredicate，进行谓词查询：找到对应学生id的数据
    NSPredicate *pd=[NSPredicate predicateWithFormat:@"stuid == %@",anId];
    req.predicate=pd;//谓词的内容
    
    //将经过谓词查询的数据存储进一个数组。因为学号是单一的，不会重复，因此数组里只有一个满足条件的数据，
    NSArray *stA=[self.managedObjectContext executeFetchRequest:req error:nil];
    
    if (stA.count>0) {
    
        //将对应学号的数据删除
        Student *b =[stA lastObject];//因为数组中的数据其实只有一个，我们取最后一个就好了。
        [self.managedObjectContext deleteObject:b];
        
        //创建受托管对象，重新创建一个数据。
        b = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
        b.stuhead = nil;
        b.stuname = aName;
        b.stuid = anId;
        b.stuphone = aPhone;
        
        NSError *error=nil;
        if ([ self.managedObjectContext save:&error]) {
            NSLog(@"更新成功");
        }else{
            NSLog(@"更新失败");
        }
    }

}
/*
 更新的思路：其实就是将满足条件的数据删除，然后重新创建一行数据
 */


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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"UI007_CoreData_Cell" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"UI007_CoreData_Cell.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
