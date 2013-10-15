//
//  CommentCell.m
//  WeiPhoneNews_Lin
//
//  Created by ibokan on 13-6-17.
//  Copyright (c) 2013年 林建裕. All rights reserved.
//

#import "CommentCell.h"
#import "GetLabelHight.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //头像
        //UIImage *image = [UIImage imageNamed:@"head.png"];
        self.headImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"head1.png"]];
        self.headImage.frame = CGRectMake(0, 11, 42, 42);
        //self.headImage.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:self.headImage];
        
        //用户名
        self.name = [[UILabel alloc]initWithFrame:CGRectMake(42+11, 11, 50, 12)];
        self.name.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.name];
        
        
        //来源
        self.from = [[UILabel alloc]initWithFrame:CGRectMake(self.headImage.frame.size.width+self.name.frame.size.width, 11, 100, 12)];
        self.from.text = @"（来自 牛排）";
        self.from.textColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1];
        self.from.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.from];
        
        //讨论
        
        //讨论内容
        self.commentStr = [[NSString alloc]init];
        
        //显示讨论内容
        self.comment = [[UILabel alloc]initWithFrame:CGRectMake(self.headImage.frame.size.width+11,11+25/2+self.name.frame.size.height, 200, 12)];
        self.comment.text = self.commentStr;
        self.comment.font = [UIFont systemFontOfSize:12];
        self.comment.textColor = [UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1];
        [self.contentView addSubview:self.comment];
        
        //时间
        self.time = [[UILabel alloc]initWithFrame:CGRectMake(220, 11, 78, 12)];
        self.time.font = [UIFont systemFontOfSize:12];
        self.time.textColor = [UIColor colorWithRed:189/255.0 green:189/255.0 blue:189/255.0 alpha:1];
        [self.contentView addSubview:self.time];
        
        //顶、踩
        self.sayImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.comment.frame.origin.x, 25+self.name.frame.size.height+self.comment.frame.size.height+11, 120, 40)];
        self.sayImage.image = [UIImage imageNamed:@"comment.png"];
        [self.contentView addSubview:self.sayImage];
        
        //其它
        self.other = [[UILabel alloc]initWithFrame:CGRectMake(0,0, 120, 40)];
        self.other.backgroundColor = [UIColor clearColor];
        [self.sayImage addSubview:self.other];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_headImage release];
    [_name release];
    [_from release];
    [_time release];
    [_comment release];
    [_other release];
    [super dealloc];
}
@end
