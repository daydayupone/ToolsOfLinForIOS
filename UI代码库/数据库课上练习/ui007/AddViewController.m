//
//  AddViewController.m
//  ui007
//
//  Created by 颜振洋 on 13-5-23.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import "AddViewController.h"
#import "Student.h"
@interface AddViewController ()

@end

@implementation AddViewController
#pragma mark - 打开相册
- (IBAction)xuanZeimg:(id)sender {
    self.xianshiimgView.hidden = NO;
    //相册是可以用模拟器打开的
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //picker.allowsEditing = YES; //是否可编辑
        //打开相册选择照片
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:picker animated:YES];
        [picker release];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil];
        [alert show];
    }
}
//选中图片进入的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    self.xianshiimgView.image = image;
    [self dismissModalViewControllerAnimated:YES];
}
//- (IBAction)xuanZeimg:(id)sender {
////    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
////        <#statements#>
////    }
////    
//}

- (IBAction)addBtn:(id)sender {
    
    [Student insertStuName:self.txt1.text andStuphone:self.txt2.text andStuhead:UIImagePNGRepresentation/*转换数据类型*/(self.xianshiimgView.image)];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_txt1 release];
    [_txt2 release];
    [_xianshiimgView release];
    [super dealloc];
}
@end
