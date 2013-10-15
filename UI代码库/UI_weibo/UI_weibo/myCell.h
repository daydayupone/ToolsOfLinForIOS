//
//  myCell.h
//  UI_weibo
//
//  Created by ibokan on 13-6-4.
//  Copyright (c) 2013年 LJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myCell : UITableViewCell

//该类的属性是为 单元格 提供表格外观 的
//分别将视图将要使用的组件设置为属性
//头像、回复头像
@property (retain,nonatomic) UIImageView *head,*responsePic;
//作者信息
@property (retain,nonatomic) UILabel *authorLable,*title,*responseTitle;





@end
