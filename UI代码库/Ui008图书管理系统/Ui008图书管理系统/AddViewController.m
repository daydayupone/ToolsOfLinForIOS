//
//  AddViewController.m
//  Ui008图书管理系统
//
//  Created by ibokan on 13-5-24.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import "AddViewController.h"
#import "Book.h"
@interface AddViewController ()

@end

@implementation AddViewController
#pragma mark -  按钮响应
- (IBAction)addbtn:(id)sender {
    [Book insertIntoSqlWithName:self.txt1.text andPrice:[self.txt2.text floatValue] andImage:self.imageView.image];
}
- (IBAction)addPic:(id)sender {
    self.imageView.hidden=NO;
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

#pragma mark -  选中图片进入的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    self.imageView.image = image;
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -  取消第一响应
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark -  系统
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
    self.imageView.backgroundColor=[UIColor grayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_txt1 release];
    [_txt2 release];
    [_imageView release];
    [super dealloc];
}
@end
