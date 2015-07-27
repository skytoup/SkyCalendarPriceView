//
//  SkyCalendarCell.h
//  SkyCalendarPriceTest
//
//  Created by skytoup on 15/7/23.
//  Copyright (c) 2015年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkyCalendarPriceModel.h"

/**
 *  日历价格的日期Cell
 */
@interface SkyCalendarCell : UICollectionViewCell

/**
 *  初始化cell样式
 *
 *  @param block
 */
+ (void)SkyCalendarPriceViewInitCellStyleWithBlock:(void(^)(UICollectionViewCell *cell))block;

+ (CGFloat)hegith;

- (void)setContentWithDay:(NSString*)day withPrice:(NSString*)price withCount:(NSString*)count;

- (void)setContentWithDay:(NSString*)day;

- (void)setContentEmpty;

//- (void)setContentWithModel:(SkyCalendarPriceModel*)model;

@end
