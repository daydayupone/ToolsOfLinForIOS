//
//  GetLabelHight.h
//  WeiPhoneNews_Lin
//
//  Created by ibokan on 13-6-16.
//  Copyright (c) 2013年 林建裕. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "HightOfLabelProtocol.h"

@interface GetLabelHight : NSObject//<HightOfLabelProtocol>

//@property (retain,nonatomic) id<HightOfLabelProtocol> delegate;

- (CGFloat) highOfLabel:(UILabel *) label numberTextOfLabel:(NSString *) text andFontSize:(CGFloat) fontSize;

@end
