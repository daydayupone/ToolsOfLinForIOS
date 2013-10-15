//
//  AppDelegate.m
//  CoreData
//
//  Created by ibokan on 13-6-3.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import "AppDelegate.h"

#import "Book.h"

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
    [self.window makeKeyAndVisible];
    
    //-----------使用coreData进行数据的存储
    //调用存储方法
    [self saveBook:nil];
    //（AppDelegate *)[[UIApplication ]]
    
    //-----------使用 CoreData 查询数据库(该方法也能封装成方法)
    //创建查询对象
    NSFetchRequest *req = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:self.managedObjectContext];
    req.entity = entity1;//指定查询book实体的内容
    
    //使用谓词查询，进行模糊查询
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(self.btitle LIKE[cd] '*%@*')",@"白"]];
//    req.predicate = predicate;
//    NSLog(@"%@",req.predicate);
    
    
    //符号条件的数据将显示在界面上
    
    //执行查询返回数组
    //错误对象
    NSError *error = nil;
    NSArray *bookArray = [self.managedObjectContext executeFetchRequest:req error:&error];
    
    NSLog(@"error = %@",error);
    
    if (bookArray.count >0) {
        Book *b = [bookArray objectAtIndex:0];
        UIImage *img = [UIImage imageWithData:b.bface];
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 40, 50)];
        imgV.image = img;
        [self.window addSubview:imgV];
    }
    
    //-----------?????使用 CoreData 更新数据库??????????
    if (bookArray.count >0) {
        Book *b = [bookArray objectAtIndex:0];//查找出要更新的对象
        b.btitle = @"白云";//更新对象的属性
        b.bauthor = @"王维";
        //NSSet *updataSet = [self.managedObjectContext updatedObjects];//该方法会返回更新对象的个数，用于测试更新是否成功
        NSLog(@"更新后的结果：%@",b.btitle);
        
        NSError *error = nil;
        if ([self.managedObjectContext save:&error]) {//存储book1对象
            NSLog(@"更新成功");
        }else
        {
            NSLog(@"更新失败");
        }
        
    }
    
    /*
    //------------删除功能的使用
    if (bookArray.count>0) {
        Book *deleteBook = [bookArray objectAtIndex:2];
        [self.managedObjectContext deleteObject:deleteBook];
        if ([deleteBook isDeleted]) {
            NSLog(@"成功删除%@",deleteBook);
            
            NSError *savingError = nil;
            if ([self.managedObjectContext save:&savingError]) {
                NSLog(@"成存储上下文");
            }
            else
            {
                NSLog(@"上下文存储失败");
            }
        }
        
        else
            {
                NSLog(@"删除%@失败",deleteBook);
            }
        
    }
    */

    //-----------使用 NSManagedObjectID 管理 CoreData 主键的关键字
    
    
    
    return YES;
}

//存储方法
- (void) saveBook :(Book *)temp
{
    //创建要添加的受管对象
    Book *book1 = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:self.managedObjectContext];
    
    //book1 = temp;
    
    if (book1 != nil) {
        //给对象属性赋值
        book1.bid = [NSNumber numberWithInt:1];//给书编号
        book1.btitle = @"史记";
        book1.bpublish = @"清华大学出版社";
        book1.bpdate = @"20120601";
        book1.bface = UIImagePNGRepresentation([UIImage imageNamed:@"shiji.jpg"]);
        book1.bauthor = @"司马迁";
        book1.binfo = @"这是本好书";
        book1.bflag1 = [NSNumber numberWithInt:1];//首页内容删除标记
        book1.bflag2 = [NSNumber numberWithInt:1];//收藏内容删除标记
        
        //错误的对象
        NSError *error = nil;
        if ([self.managedObjectContext save:&error]) {//存储book1对象
            NSLog(@"存储成功");
        }
        else{
            NSLog(@"存储error=%@",error);
          }
        }
    
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
//获取对象的受管对象上下文的方法
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
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreData" withExtension:@"momd"];
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
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreData.sqlite"];
    
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
