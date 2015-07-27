//
//  SkyCalendarPriceDataModel.h
//  SkyCalendarPriceTest
//
//  Created by skytoup on 15/7/23.
//  Copyright (c) 2015年 skytoup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkyCalendarPriceDataSubModel.h"

@interface SkyCalendarPriceDataModel : NSObject
@property (strong, nonatomic) NSNumber *year;
@property (strong, nonatomic) NSNumber *month;
@property (strong, nonatomic) NSNumber *startWeek;
@property (strong, nonatomic) NSNumber *dayCount;
@property (strong, nonatomic) NSDictionary *models;

+ (NSArray*)calendarPriceDataModelsWithCalendarPriceModels:(NSArray*)models;

- (SkyCalendarPriceDataSubModel*)modelFromDay:(NSInteger)day;
@end
