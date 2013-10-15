//
//  CommentCell.h
//  WeiPhoneNews_Lin
//
//  Created by ibokan on 13-6-17.
//  Copyright (c) 2013年 林建裕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *headImage;//头像
@property (retain, nonatomic) UIImageView *sayImage;//顶、踩
@property (retain, nonatomic) IBOutlet UILabel *name;//用户名
@property (retain, nonatomic) IBOutlet UILabel *from;//来源
@property (retain, nonatomic) IBOutlet UILabel *time;//时间
@property (retain, nonatomic) IBOutlet UILabel *comment;//讨论
@property (retain, nonatomic) IBOutlet UILabel *other;//其它

@property (copy,nonatomic) NSString *commentStr;//评论内容

@end
