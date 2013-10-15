//
//  myCell.m
//  UI_weibo
//
//  Created by ibokan on 13-6-4.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import "myCell.h"

@implementation myCell




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    //自定义单元格
        //头像
        self.head = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
        [self.contentView addSubview:self.head];//将存储头像的head贴在当前的页面
        
        //作者
        self.authorLable = [[UILabel alloc]initWithFrame:CGRectMake(45, 10, 100, 30)];
        [self.authorLable setNumberOfLines:2];
        [self.contentView addSubview:self.authorLable];
        
        //文字
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(45, 50, 250, 30)];
        //设置文本的行数，
        [self.contentView addSubview:self.title];
        
        //回复中的文字
        self.responseTitle = [[UILabel alloc]initWithFrame:CGRectMake(45, 90, 250, 30)];
        
        [self.contentView addSubview:self.responseTitle];//将lable加入单元格
        
        
        //回复头像
        self.responsePic = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/6, 160,100 , 100)]
         ;
         
        [self.contentView addSubview:self.responsePic];
    
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
