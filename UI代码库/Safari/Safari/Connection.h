//
//  Connection.h
//  Safari
//
//  Created by ibokan on 13-6-5.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface Connection : NSObject

+(sqlite3 *) shareConnect;


@end
