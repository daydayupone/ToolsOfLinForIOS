//
//  AppDelegate.h
//  UI007_CoreData_Cell
//
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <UIKit/UIKit.h>
//引入CoreData的框架
#import <CoreData/CoreData.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//ViewController的属性
@property (retain,nonatomic) ViewController *viewController;


//上下文对象
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//数据模型对象
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//持久性存储区
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//进行存储数据的方法
- (void) saveStudentName:(NSString *) aName andNumber:(NSNumber *) anId andPhone:(NSString *)aPhone andHead:(NSData *)aHead;
//查询数据库的内容
-(NSArray*) findall;
//删除数据方法
-(void) deleteACellFromDbWithId:(NSNumber*) tempid;
//更新数据
- (void) upDataName:(NSString *)aName andNumber:(NSNumber *) anId andPhone:(NSString *)aPhone andHead:(NSData *)aHead;

@end
