//
//  DetailViewController.h
//  UI-Test-图书管理
//
//  Created by ibokan on 13-5-30.
//  Copyright (c) 2013年 孙启智. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Book;
@interface DetailViewController : UIViewController
/*
@property (retain, nonatomic) UITextField *bookName;
@property (retain, nonatomic) UITextField *bookPublisher;
@property (retain, nonatomic) UITextField *bookdate;
@property (retain, nonatomic) UITextField *bookAuthor;
@property (retain, nonatomic) UITextField *bookIntro;

@property (retain, nonatomic) UIImageView *bookFaceImage;
 */
@property (retain, nonatomic) IBOutlet UITextField *bookAuthor;
@property (retain, nonatomic) IBOutlet UITextField *bookPublisher;
@property (retain, nonatomic) IBOutlet UITextField *bookdate;
@property (retain, nonatomic) IBOutlet UIImageView *bookFaceImage;
@property (retain, nonatomic) IBOutlet UITextView *bookIntro;
@property(retain, nonatomic)Book *book;
@property(assign,nonatomic)int favoriteflag;
@end
