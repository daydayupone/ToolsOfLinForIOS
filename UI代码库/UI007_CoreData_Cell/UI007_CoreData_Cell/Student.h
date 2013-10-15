//
//  Student.h
//  UI007_CoreData_Cell
//
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Student : NSManagedObject

@property (nonatomic, retain) NSNumber * stuid;
@property (nonatomic, retain) NSString * stuname;
@property (nonatomic, retain) NSString * stuphone;
@property (nonatomic, retain) NSData * stuhead;

@end
