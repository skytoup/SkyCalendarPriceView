//
//  SkyCalendarHeader.h
//  SkyCalendarPriceTest
//
//  Created by skytoup on 15/7/23.
//  Copyright (c) 2015年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkyCalendarPriceViewConfig.h"

/**
 *  价格日历的头部View，显示年份和月份
 */
@interface SkyCalendarHeader : UICollectionReusableView

/**
 *  初始化显示年月的view样式
 *
 *  @param block 
 */
+ (void)SkyCalendarPriceViewInitHeaderViewOfYearMonthViewStyleWithBlock:(void(^)(UIView *view))block;

/**
 *  初始化显示星期的label样式，从周日开始到周六
 *
 *  @param block
 */
+ (void)SkyCalendarPriceViewInitHeaderViewOfWeekLabelsStyleWithBlock:(void(^)(NSArray *labels))block;

+ (CGFloat)height;

- (void)adjustWeekLbsWithWidth:(CGFloat)width withCellSpace:(CGFloat)space withSectionInset:(UIEdgeInsets)inset;

- (void)setTitle:(NSString*)title;
@end
