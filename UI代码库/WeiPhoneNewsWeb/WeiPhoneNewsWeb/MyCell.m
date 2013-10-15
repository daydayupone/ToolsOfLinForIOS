//
//  MyCell.m
//  Weiphone
//
//  Created by 颜振洋 on 13-6-13.
//  Copyright (c) 2013年 颜振洋. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //标题
        self.newsLab=[[UILabel alloc]initWithFrame:CGRectMake(28, 13, 260, 15)];
        self.newsLab.numberOfLines=0;
        [self.contentView addSubview:self.newsLab];
        [self.newsLab setBackgroundColor:[UIColor clearColor]];
        [self.newsLab setHighlightedTextColor:[UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1]];
        self.newsLab.font=[UIFont systemFontOfSize:15];//设置字体大小
        
        //新闻种类和浏览次数
        self.titleFromLab=[[UILabel alloc]initWithFrame:CGRectMake(28, 41, 140, 15)];
        [self.contentView addSubview:self.titleFromLab];
        [self.titleFromLab setBackgroundColor:[UIColor clearColor]];
        [self.titleFromLab setHighlightedTextColor:[UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1]];
        self.titleFromLab.font=[UIFont systemFontOfSize:11];//设置字体大小

        //时间
        self.dateLab=[[UILabel alloc]initWithFrame:CGRectMake(180, 41,140, 15)];
        [self.contentView addSubview:self.dateLab];
        [self.dateLab setBackgroundColor:[UIColor clearColor]];
        [self.dateLab setHighlightedTextColor:[UIColor colorWithRed:164/255.0 green:164/255.0 blue:164/255.0 alpha:1]];
        self.dateLab.font=[UIFont systemFontOfSize:11];//设置字体大小
        
        self.jinru=[[UIImageView alloc]initWithFrame:CGRectMake(288, 15, 20, 30)];
        self.jinru.image=[UIImage imageNamed:@"cell_accessory@2x.png"];
        [self.contentView addSubview:self.jinru];
        
        //未选中时的背景颜色
        [self.contentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_bg.png"]]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
