//
//  AddViewController.m
//  UI-Test-图书管理
//
//  Created by ibokan on 13-5-30.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import "AddViewController.h"
#import "Book.h"
@interface AddViewController ()

@end

@implementation AddViewController
- (IBAction)btnPush:(id)sender {
    
    self.bookFaceImage.hidden=NO;
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
    self.bookFaceImage.image = image;
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -  取消第一响应
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}



-(void)pushToSave:(UIBarButtonItem *)sender{
    UIImage *image=self.bookFaceImage.image;
    [Book insertWithName:self.bookName.text andPublisher:self.bookAuthor.text andDate:self.bookdate.text andAuthor:self.bookAuthor.text andfaceImage:image andIntro:self.bookIntro.text];
    
    [self dismissModalViewControllerAnimated:YES];
}
-(void)quit:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //方法一：使用导航栏 的从右往左切换
//    self.bookFaceImage.backgroundColor=[UIColor grayColor];
//    self.navigationItem.title=@"New Book";
//    
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(pushToSave:)];
    
    //方法二 使用从下往上切换  自己加上UINavigationBar
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
	bar.barStyle = UIBarStyleBlackOpaque;
    [self.view addSubview:bar];
    //加UINavigationItem 并写title
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"New Book"];
    [bar pushNavigationItem:item animated:NO];
    //在UINavigationItem 上 加保存按钮
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(pushToSave:)];
    item.rightBarButtonItem = saveButton;
    
    UIBarButtonItem *quitButton = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(quit:)];
    item.leftBarButtonItem = quitButton;
    
     NSLog(@"add viewDidLoad");
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_bookName release];
    [_bookPublisher release];
    [_bookdate release];
    [_bookAuthor release];
    [_bookIntro release];
    [_bookFaceImage release];
    [_bookAuthor release];
    [_bookIntro release];
    [super dealloc];
}
@end
