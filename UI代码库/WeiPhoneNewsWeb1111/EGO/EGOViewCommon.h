//
//  EGOViewCommon.h
//  TableViewRefresh
//
//  Created by  Abby Lin on 12-5-2.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef TableViewRefresh_EGOViewCommon_h//如果没有定义这个宏
#define TableViewRefresh_EGOViewCommon_h

#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]//字体颜色
#define FLIP_ANIMATION_DURATION 0.18f//反转动画角度

#define  REFRESH_REGION_HEIGHT 65.0f//更新区域的高

typedef enum{
	EGOOPullRefreshPulling = 0,//拉伸
	EGOOPullRefreshNormal,//常规模式
	EGOOPullRefreshLoading,	//下载模式
} EGOPullRefreshState;

typedef enum{
	EGORefreshHeader = 0,
	EGORefreshFooter	
} EGORefreshPos;

@protocol EGORefreshTableDelegate
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos;//更新触发
- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view;//是否下载数据
@optional
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view;//数据更新
@end

#endif
