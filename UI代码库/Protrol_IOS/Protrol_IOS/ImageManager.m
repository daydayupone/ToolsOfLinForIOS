//
//  ImageManager.m
//  Protrol_IOS
//
//  Created by ibokan on 13-6-21.
//  Copyright (c) 2013年 zzl. All rights reserved.
//

#import "ImageManager.h"

@implementation ImageManager


- (id) initWithUrlString:(NSString *)urlStr
{
    if (self=[super init]) {
        NSURL *url = [NSURL URLWithString:urlStr];
//        ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:url];
//        req.delegate = self;
//        [req startAsynchronous];
        
//        [req setCompletionBlock:^{
//            NSLog(@"downLoad image");
//            NSData *getImgData = [req responseData];
//            _img = [UIImage imageWithData:getImgData];
//            if (self.imgDelegaet !=nil && [self.imgDelegaet respondsToSelector:@selector(SetCellImageView:)]) {
//                [self.imgDelegaet SetCellImageView:self.img];
//            }
//        }];
        
        NSURLRequest *req = [NSURLRequest requestWithURL:url];
        [NSURLConnection connectionWithRequest:req delegate:self];
        
        
    }
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.getData = [[[NSMutableData alloc]init]autorelease];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.getData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.img = [UIImage imageWithData:self.getData];
    if (self.imgDelegaet !=nil && [self.imgDelegaet respondsToSelector:@selector(SetCellImageView:)]) {
        [self.imgDelegaet SetCellImageView:self.img];
    }
}

//- (void) requestFinished:(ASIHTTPRequest *)request
//{
//    NSLog(@"downLoad image");
//    NSData *getImgData = [request responseData];
//    _img = [UIImage imageWithData:getImgData];
//    if (self.imgDelegaet !=nil && [self.imgDelegaet respondsToSelector:@selector(SetCellImageView:)]) {
//        [self.imgDelegaet SetCellImageView:self.img];
//    }
//
//}

@end
