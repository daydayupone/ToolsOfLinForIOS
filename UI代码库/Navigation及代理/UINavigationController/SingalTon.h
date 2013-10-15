//
//  SingalTon.h
//  UINavigationController
//
//  Created by ibokan on 13-5-20.
//  Copyright (c) 2013年 Name. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingalTon : NSObject
//——————————建立了一个单例对像

@property (retain,nonatomic) NSString *wenBen;

+ (SingalTon *) getInstance;

@end
