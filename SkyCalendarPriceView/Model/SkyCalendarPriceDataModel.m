//
//  SkyCalendarPriceDataModel.m
//  SkyCalendarPriceTest
//
//  Created by skytoup on 15/7/23.
//  Copyright (c) 2015年 skytoup. All rights reserved.
//

#import "SkyCalendarPriceDataModel.h"
#import "SkyCalendarPriceModel.h"

@implementation SkyCalendarPriceDataModel

+ (NSArray*)calendarPriceDataModelsWithCalendarPriceModels:(NSArray*)models {
    models = [models sortedArrayUsingComparator:^NSComparisonResult(SkyCalendarPriceModel *obj1, SkyCalendarPriceModel *obj2) {
        BOOL great = NO;
        if(obj1.year.integerValue>obj2.year.integerValue) {
            great = YES;
        } else if(obj1.year.integerValue == obj2.year.integerValue) {
            if(obj1.month.integerValue>obj2.month.integerValue) {
                great = YES;
            } else if(obj1.month.integerValue==obj2.month.integerValue) {
                great = obj1.day.integerValue>obj2.day.integerValue;
            }
        }
        return great;
    }];
    
    NSMutableArray * __autoreleasing dms = [NSMutableArray new];
    SkyCalendarPriceModel *modelFirst = models.firstObject;
    SkyCalendarPriceModel *modelLast = models.lastObject;
    NSInteger fy = modelFirst.year.integerValue;
    NSInteger fm = modelFirst.month.integerValue;
    NSInteger ly = modelLast.year.integerValue;
    NSInteger lm = modelLast.month.integerValue;
    
    NSUInteger msIdx = 0;
    NSInteger msCount = models.count;
    NSCalendar *cd = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    dc.day = 1;
    for(NSInteger year=fy; year<=ly; year++) {
        dc.year = year;
        for(NSInteger month=fm; month<=lm; month++) {
            SkyCalendarPriceDataModel *dm = [SkyCalendarPriceDataModel new];
            dm.year = @(year);
            dm.month = @(month);
            
            dc.month = month;
            NSDate *d = [cd dateFromComponents:dc];
            NSDateComponents *resDc = [cd components:NSCalendarUnitWeekday fromDate:d];
            NSUInteger ds = [cd rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:d].length;
            dm.startWeek = @(resDc.weekday-1);
            dm.dayCount = @(ds);
            NSMutableDictionary *dsms = [NSMutableDictionary new];
            while(msIdx<msCount) {
                SkyCalendarPriceModel *model = models[msIdx];
                if(model.year.integerValue==year && model.month.integerValue==month) {
                    ++msIdx;
                    [dsms setObject:model forKey:model.day];
                } else {
                    break;
                }
            }
            dm.models = dsms;
            [dms addObject:dm];
        }
    }
    
    return dms;
}

- (SkyCalendarPriceDataSubModel*)modelFromDay:(NSInteger)day {
    return _models.count?_models[@(day)]:nil;
}

@end
