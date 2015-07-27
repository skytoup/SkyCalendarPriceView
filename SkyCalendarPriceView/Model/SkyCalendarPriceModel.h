//
//  SkyCalendarPriceModel.h
//  SkyCalendarPriceTest
//
//  Created by skytoup on 15/7/23.
//  Copyright (c) 2015年 skytoup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkyCalendarPriceDataSubModel.h"

/**
 *  价格日历的数据模型
 */
@interface SkyCalendarPriceModel : SkyCalendarPriceDataSubModel
@property (copy, nonatomic) NSNumber *year; // 年
@property (copy, nonatomic) NSNumber *month; // 月

+ (SkyCalendarPriceModel*)calendarPriceModelWithYear:(NSNumber*)year withMonth:(NSNumber*)month withDay:(NSNumber*)day withPrice:(NSNumber*)price withCount:(NSNumber*)count;
@end
