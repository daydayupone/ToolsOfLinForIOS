//
//  MyHeaderCell.m
//  Weiphone
//
//  Created by 颜振洋 on 13-6-13.
//  Copyright (c) 2013年 颜振洋. All rights reserved.
//

#import "MyHeaderCell.h"
#import "TFHpple.h"
#import "XPathQuery.h"

@implementation MyHeaderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.imgArrayN=[[NSMutableArray alloc]init];
        self.imgWebArrayN=[[NSMutableArray alloc]init];
        self.wordArrayN=[[NSMutableArray alloc]init];
        self.head=[[Header alloc]init];
        //网络异步下载
        NSURL*url=[NSURL URLWithString:@"http://www.weiphone.com/"];
        ASIHTTPRequest *req=[ASIHTTPRequest requestWithURL:url];
        req.delegate=self;
        [req startAsynchronous];
        //显示滚动视图
        self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 156)];
        self.scrollView.backgroundColor=[UIColor blackColor];
        self.scrollView.contentSize=CGSizeMake(320*3, 156);
        self.scrollView.pagingEnabled=YES;
        self.scrollView.delegate=self;
        [self.contentView addSubview:self.scrollView];
        //显示UIPageControl控件
        self.page=[[UIPageControl alloc]initWithFrame:CGRectMake(278,130, 10,10)];
        self.page.numberOfPages=3;
        [self.contentView addSubview:self.page];
        //底部透明条
        self.underLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, 320, 35)];
        self.underLabel1.backgroundColor = [UIColor blackColor];
        self.underLabel1.textColor= [UIColor whiteColor];
        self.underLabel1.alpha = 0.4;
        [self.contentView addSubview:self.underLabel1];
        //白色字体条目
        self.underLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, 270, 35)];
        self.underLabel.backgroundColor = [UIColor clearColor];
        self.underLabel.textColor= [UIColor whiteColor];
        self.underLabel.font=[UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:self.underLabel];
    }
    return self;
}
int flag=0;
- (void)requestFinished:(ASIHTTPRequest *)request{
     if (flag==0) {
         TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:[request responseData]];//创建基于xpath解析html的类对象
         //获取图片地址
         self.imgArray=[xpathParser searchWithXPathQuery:@"//div[@id='hot5_big']//div//a//@src"];
         @synchronized(self){
             for(int i=0;i<self.imgArray.count;i++){
                NSString *myTitle = [[self.imgArray objectAtIndex:i] content];
                 [self.imgWebArrayN addObject:myTitle];
                if (myTitle!=nil) {
                    flag=1;
                    NSURL*url=[NSURL URLWithString:myTitle];
                    ASIHTTPRequest *req=[ASIHTTPRequest requestWithURL:url];
                    req.delegate=self;
                    [req startAsynchronous];
                 }
             }
         }
         self.wordArray=[xpathParser searchWithXPathQuery:@"//div[@id='hot5_big']//div//h3//a/text()"];
         @synchronized(self){
             for(int i=0;i<self.wordArray.count;i++){
                 NSString *myTitle = [[self.wordArray objectAtIndex:i] content];
                 [self.wordArrayN addObject:myTitle];
//                 NSLog(@"%@",myTitle);
             }
         }
    }else if(flag==1&&self.imgArrayN.count<4){
//        Header*header=[[Header alloc]init];
   
        @synchronized(self){
            self.imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0+320, 0, 320, 480-20-44)];
            self.imgView.image=[UIImage imageWithData:[request responseData]];
            [self.imgArrayN addObject:self.imgView.image];
        }
        if (self.imgArrayN.count==3) {
            for (int i=0; i<3; i++) {
                self.imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0+320*i, 0, 320, 480-20-44)];
                self.imgView.image=[self.imgArrayN objectAtIndex:i];
                [self.scrollView addSubview:self.imgView];
            }
            flag=2;
            self.underLabel.text=[self.wordArrayN objectAtIndex:0];
            [NSTimer scheduledTimerWithTimeInterval:3 target: self selector: @selector(handleTimer:) userInfo: nil repeats: YES];
        }
    }
//    NSLog(@"%@",self.wordArrayN);
}
-(void)handleTimer:(id)sender{
    [UIView animateWithDuration:1 animations:^{
        self.page.currentPage=(self.page.currentPage+1)%3;
        self.scrollView.contentOffset=CGPointMake(320*self.page.currentPage, 0);
        self.underLabel.text=[self.wordArrayN objectAtIndex:self.page.currentPage];
    }];
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.index=fabs(scrollView.contentOffset.x)/scrollView.frame.size.width;//相对位置的偏移值，contentOffset相对于原点的偏移值
    self.page.currentPage=self.index;
}








- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
