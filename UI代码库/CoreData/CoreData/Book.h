//
//  Book.h
//  CoreData
//
//  Created by ibokan on 13-6-3.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Book : NSManagedObject

@property (nonatomic, retain) NSNumber * bid;
@property (nonatomic, retain) NSString * btitle;
@property (nonatomic, retain) NSString * bpublish;
@property (nonatomic, retain) NSString * bpdate;
@property (nonatomic, retain) NSString * bauthor;
@property (nonatomic, retain) NSData * bface;
@property (nonatomic, retain) NSString * binfo;
@property (nonatomic, retain) NSNumber * bflag1;
@property (nonatomic, retain) NSNumber * bflag2;

@end
