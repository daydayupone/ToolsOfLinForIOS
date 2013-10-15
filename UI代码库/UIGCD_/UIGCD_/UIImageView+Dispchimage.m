//
//  UIImageView+Dispchimage.m
//  UIGCD_
//
//  Created by ibokan on 13-7-2.
//  Copyright (c) 2013年 zzl. All rights reserved.
//

#import "UIImageView+Dispchimage.h"

@implementation UIImageView (Dispchimage)

- (void) setimgURL:(NSString *)url
{
    //子线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //子线程获得相关的数据
        NSURL *urla = [NSURL URLWithString:url];
        NSData *aData = [NSData dataWithContentsOfURL:urla];
        
        //获得数据后，进入主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            //主线程负责UI界面的更新
            self.image = [UIImage imageWithData:aData];

        });
    });
    
}

@end
