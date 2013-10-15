//
//  WebNewsCell.m
//  WeiPhoneNews_Lin
//
//  Created by ibokan on 13-6-15.
//  Copyright (c) 2013年 林建裕. All rights reserved.
//

#import "WebNewsCell.h"

@implementation WebNewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //标题
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(11, 10, 320-22, 34)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        UIFont *font1 = [UIFont fontWithName:nil size:50];
        self.titleLabel.font =font1;
        [self.contentView addSubview:self.titleLabel];
        
        //来源等
        self.otherLabel = [[UILabel alloc]initWithFrame:CGRectMake(22, 10+self.titleLabel.frame.size.height*2+25, 320-22, 34/2)];
        self.otherLabel.backgroundColor = [UIColor clearColor];
        UIFont *font2 = [UIFont fontWithName:nil size:20];
        self.otherLabel.font =font2;
        [self.contentView addSubview:self.otherLabel];
        
        //正文
        self.headEasay = [[UILabel alloc]initWithFrame:CGRectMake(11, 10+self.titleLabel.frame.size.height*2+25+38, 320-22, 34/2)];
        self.otherLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.headEasay];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
