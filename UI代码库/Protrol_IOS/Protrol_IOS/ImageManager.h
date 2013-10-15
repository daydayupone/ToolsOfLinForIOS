//
//  ImageManager.h
//  Protrol_IOS
//
//  Created by ibokan on 13-6-21.
//  Copyright (c) 2013年 zzl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
//C

#import "SetImageView.h"


@interface ImageManager : NSObject<NSURLConnectionDataDelegate>

@property (retain,nonatomic) NSMutableData *getData;

@property (retain,nonatomic) UIImage *img ;

@property (assign,nonatomic) id<SetImageView>imgDelegaet;

- (id) initWithUrlString:(NSString *)urlStr;

@end
