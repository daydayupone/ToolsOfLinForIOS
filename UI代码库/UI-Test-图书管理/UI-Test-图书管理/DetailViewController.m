//
//  DetailViewController.m
//  UI-Test-图书管理
//
//  Created by ibokan on 13-5-30.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import "DetailViewController.h"
#import "Book.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

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
    self.bookFaceImage.backgroundColor=[UIColor grayColor];
   
    
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(pushToCollect:)];

     NSLog(@"detail viewDidLoad");
}


-(void)pushToCollect:(UIBarButtonItem *)sender{
    [Book putIntoFavoriteWithBook:self.book];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_bookAuthor release];
    [_bookPublisher release];
    [_bookdate release];
    [_bookFaceImage release];
    [_bookIntro release];
    [super dealloc];
}
@end
