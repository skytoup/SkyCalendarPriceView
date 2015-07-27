//
//  SkyCalendarPriceModel.m
//  SkyCalendarPriceTest
//
//  Created by skytoup on 15/7/23.
//  Copyright (c) 2015年 skytoup. All rights reserved.
//

#import "SkyCalendarPriceModel.h"

@implementation SkyCalendarPriceModel
+ (SkyCalendarPriceModel*)calendarPriceModelWithYear:(NSNumber*)year withMonth:(NSNumber*)month withDay:(NSNumber*)day withPrice:(NSNumber*)price withCount:(NSNumber*)count {
    SkyCalendarPriceModel * __autoreleasing m = [self new];
    m.year = year;
    m.month = month;
    m.day = day;
    m.price = price;
    m.count = count;
    return m;
}

@end
