//
//  SkyCalendarPriceView.h
//  SkyCalendarPriceTest
//
//  Created by skytoup on 15/7/22.
//  Copyright (c) 2015年 skytoup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SkyCalendarHeader.h"
#import "SkyCalendarCell.h"
#import "SkyCalendarPriceModel.h"
#import "SkyCalendarPriceLayout.h"

#define kSkyCalendarPriceViewCellDataKeyDay (@"kSkyCalendarPriceViewCellDataKeyDay") // 日期
#define kSkyCalendarPriceViewCellDataKeyPrice (@"kSkyCalendarPriceViewCellDataKeyPrice") // 价格
#define kSkyCalendarPriceViewCellDataKeyCount (@"kSkyCalendarPriceViewCellDataKeyCount") // 数量

@class SkyCalendarPriceView;

@protocol SkyCalendarPriceViewDelegate <NSObject>
@optional

/**
 *  是否应该选中某项
 *
 *  @param cview
 *  @param model 应该选中项上的数据
 *
 *  @return 是否选中
 */
- (BOOL)skyCalendarPriceView:(SkyCalendarPriceView*)cview shouldSelectIndexWithPriceModel:(SkyCalendarPriceModel*)model;

/**
 *  取消选中某项
 *
 *  @param cview
 *  @param model 取消选中项上的数据
 */
- (void)skyCalendarPriceView:(SkyCalendarPriceView*)cview didUnselectIndexWithPriceModel:(SkyCalendarPriceModel*)model;

/**
 *  获取用于直接显示在cell中lb的string，dictionary的key为上面kSkyCalendarPriceViewCellDataKey
 *
 *  @param cview
 *  @param indexPath
 *  @param year      年
 *  @param month     月
 *  @param day       日
 *  @param price     价格
 *  @param count     数量
 *  @param isToady   是否为今天
 *
 *  @return 需要显示string数据，返回nil为使用默认，可以其中几个数据返回nil
 */
- (NSDictionary*)skyCalendarPriceView:(SkyCalendarPriceView*)cview cellDataStringDictionaryWithIndexPath:(NSIndexPath*)indexPath withYear:(NSString*)year withMonth:(NSString*)month withDay:(NSString*)day withPrice:(NSString*)price withCount:(NSString*)count withIsToday:(BOOL)isToady;

/**
 *  获取用于直接显示在只显示日期的cell中lb的string
 *
 *  @param cview
 *  @param year    年
 *  @param month   月
 *  @param day     日
 *  @param isToday 是否为今天
 *
 *  @return 需要显示的日期string，返回nil为使用默认
 */
- (NSString*)skyCalendarPriceView:(SkyCalendarPriceView*)cview cellDayStringWithYear:(NSString*)year withMonth:(NSString*)month withDay:(NSString*)day withIsToday:(BOOL)isToday;

/**
 *  获取用于直接显示在只显示年月的header中lb的string
 *
 *  @param cview
 *  @param year  年
 *  @param month 月
 *
 *  @return 需要显示的年月string，返回nil为使用默认
 */
- (NSString*)skyCalendarPriceView:(SkyCalendarPriceView *)cview headerLabelStringWithYear:(NSString*)year withMonth:(NSString*)month;
@end


/**
 *  价格日历
 */
@interface SkyCalendarPriceView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) id<SkyCalendarPriceViewDelegate> calendarDelegate;
@property (copy, nonatomic) NSArray *datas; // SkyCalendarPriceModel
@property (copy, nonatomic) NSDate *today; // 今天的日期，用于今天的日期内显示别的string

/**
 *  创建一个价格日历
 *
 *  @return 价格日历
 */
+ (instancetype)calendarPriceView;

+ (instancetype)calendarPriceViewWithToday:(NSDate*)today;

+ (instancetype)calendarPriceViewWithTodayOfYear:(int)year ofMonth:(int)month ofDay:(int)day;

- (void)setTodayWithYear:(int)year withMonth:(int)month withDay:(int)day;

@end



@interface NSMutableDictionary (SkyCalendarPriceViewCellData)
@property (copy, nonatomic) NSString *dayStr;
@property (copy, nonatomic) NSString *priceStr;
@property (copy, nonatomic) NSString *countStr;
@end

@implementation NSMutableDictionary (SkyCalendarPriceViewCellData)
- (void)setDayStr:(NSString *)dayStr {
    if(dayStr) {
        self[kSkyCalendarPriceViewCellDataKeyDay] = [dayStr copy];
    } else {
        [self removeObjectForKey:kSkyCalendarPriceViewCellDataKeyDay];
    }
}
-(NSString *)dayStr {
    return self[kSkyCalendarPriceViewCellDataKeyDay];
}

- (void)setPriceStr:(NSString *)priceStr {
    if(priceStr) {
        self[kSkyCalendarPriceViewCellDataKeyPrice] = [priceStr copy];
    } else {
        [self removeObjectForKey:kSkyCalendarPriceViewCellDataKeyPrice];
    }
}
- (NSString *)priceStr {
    return self[kSkyCalendarPriceViewCellDataKeyPrice];
}

- (void)setCountStr:(NSString *)countStr {
    if(countStr) {
        self[kSkyCalendarPriceViewCellDataKeyCount] = [countStr copy];
    } else {
        [self removeObjectForKey:kSkyCalendarPriceViewCellDataKeyCount];
    }
}
- (NSString *)countStr {
    return self[kSkyCalendarPriceViewCellDataKeyCount];
}
@end