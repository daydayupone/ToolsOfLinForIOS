//
//  GetDataFromHTML.h
//  WeiPhoneNews_Lin
//
//  Created by ibokan on 13-6-15.
//  Copyright (c) 2013年 林建裕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"


@interface GetDataFromHTML : NSObject//<AnalysisHTMLProtocol>

//@property (retain,nonatomic) id<AnalysisHTMLProtocol> delegate;

- (NSString *) startAnalysisTF:(TFHpple *)weiTf andXpath:(NSString *)aXpath;

@end
