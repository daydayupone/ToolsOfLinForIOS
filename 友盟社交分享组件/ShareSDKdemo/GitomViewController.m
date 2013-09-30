//
//  GitomViewController.m
//  ShareSDKdemo
//
//  Created by jiawei on 13-9-27.
//  Copyright (c) 2013年 GitomLJYU. All rights reserved.
//

#import "GitomViewController.h"
#import "UMSocial.h"

@interface GitomViewController ()

@end

@implementation GitomViewController
- (IBAction)shareAction:(id)sender {
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    //分享图文样式到微信朋友圈显示字数比较少，只显示分享标题
    [UMSocialData defaultData].extConfig.title = @"朋友圈分享内容";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"507fcab25270157b37000010"
                                      shareText:@"正在使用网即通移动版http://app.gitom.com/mobileapp/list/12"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,UMShareToWechatSession,UMShareToQzone,UMShareToWechatTimeline,UMShareToEmail, nil]
                                       delegate:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
