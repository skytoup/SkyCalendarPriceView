//
//  SkyCalendarPriceDataSubModel.h
//  SkyCalendarPriceTest
//
//  Created by skytoup on 15/7/23.
//  Copyright (c) 2015年 skytoup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SkyCalendarPriceViewConfig.h"

/**
 *  价格日历的基本数据模型
 */
@interface SkyCalendarPriceDataSubModel : NSObject
@property (strong, nonatomic) NSNumber *day; // 天
@property (strong, nonatomic) NSNumber *price; // 价格
@property (strong, nonatomic) NSNumber *count; // 剩余数量
@end
