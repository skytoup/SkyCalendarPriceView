//
//  SkyCalendarPriceViewConfig.h
//  SkyCalendarPriceTest
//
//  Created by skytoup on 15/7/24.
//  Copyright (c) 2015年 skytoup. All rights reserved.
//


#ifndef SkyCalendarPriceTest_SkyCalendarPriceViewConfig_h
#define SkyCalendarPriceTest_SkyCalendarPriceViewConfig_h

/**
 *  配置SkyCalendarPriceView默认样式
 */

// SkyCalendarPriceView
#define SkyCalendarPriceView_BACKGROUND_COLOR ([UIColor whiteColor]) // 背景色
#define SkyCalendarPriceView_CELL_INTER_SPACE (1.f) // 默认的cell水平间隔，代码创建有效
#define SkyCalendarPriceView_CELL_LINE_SPACE (1.f) // 默认的cell垂直间隔，代码创建有效

// SkyCalendarHeader
#define SkyCalendarHeader_BACKGROUND_COLOR ([[UIColor whiteColor] colorWithAlphaComponent:.85f]) // 背景色
#define SkyCalendarHeader_TOP_PADDING (10.f) // 显示年份和月份lb与顶部的距离
#define SkyCalendarHeader_YEAR_MONTH_LB_HEIGHT (30.f) // 显示年份和月份lb的高度
#define SkyCalendarHeader_YEAR_MONTH_LB_FONE_SIZE (17.f) // 显示年份和月份lb的字号
#define SkyCalendarHeader_YEAR_MONTH_LB_FONE_COLOR ([UIColor blackColor]) // 显示年份和月份lb的字体颜色
#define SkyCalendarHeader_YEAR_MONTH_LB_BACKGROUND_COLOR  ([UIColor clearColor]) // 显示年份和月份lb的背景色
#define SkyCalendarHeader_WEEK_LB_HEIGHT (30.f) // 显示星期lb的高度
#define SkyCalendarHeader_WEEK_LB_FONE_SIZE (17.f) // 显示星期lb的字号
#define SkyCalendarHeader_WEEK_LB_FONE_COLOR ([UIColor blackColor]) // 显示星期lb的字体颜色
#define SkyCalendarHeader_WEEK_VIEW_BACKGROUND_COLOR ([UIColor clearColor]) // 显示星期view的背景色
#define SkyCalendarHeader_SYMBOL_SUNDAY (@"日") // 星期日的符号
#define SkyCalendarHeader_SYMBOL_MONDAY (@"一") // 星期一的符号
#define SkyCalendarHeader_SYMBOL_TUESDAY (@"二") // 星期二的符号
#define SkyCalendarHeader_SYMBOL_WEDNESDAY (@"三") // 星期三的符号
#define SkyCalendarHeader_SYMBOL_THURSDAY (@"四") // 星期四的符号
#define SkyCalendarHeader_SYMBOL_FRIDAY (@"五") // 星期五的符号
#define SkyCalendarHeader_SYMBOL_SATURDAY (@"六") // 星期六的符号

// SkyCalendarCell
#define SkyCalendarCell_LB_HEIGHT (16.f) // cell内lb的默认高度
#define SkyCalendarCell_PADDING (5.f) // cell内部与顶部和底部的距离
#define SkyCalendarCell_LB_PADDING (0.f) // lb间的间隙
#define SkyCalendarCell_LB_FONT_SIZE (15.f) // lb的默认字号
#define SkyCalendarCell_LB_FONE_SIZE_ONLY_DAY (18.f) // 只显示日期时的lb字号
#define SkyCalendarCell_DARE_COLOR_ONLY_DAY ([UIColor grayColor]) //只显示日期时的字体颜色
#define SkyCalendarCell_DAY_COLOR ([UIColor blackColor]) // 日期有价格数据时的字体颜色
#define SkyCalendarCell_PRICE_COLOR ([UIColor orangeColor]) // 价格的字体颜色
#define SkyCalendarCell_COUNT_COLOR ([UIColor grayColor]) // 剩余数量的字体颜色
#define SkyCalendarCell_DATA_CELL_SELECT_BACKGROUND_COLOR ([[UIColor greenColor] colorWithAlphaComponent:.8f]) // 有价格数据的cell的选中背景颜色
#define SkyCalendarCell_DATA_CELL_UNSELECT_BACKGROUND_COLOR ([[UIColor greenColor] colorWithAlphaComponent:.3f]) // 有价格数据的cell的未选中背景颜色
#define SkyCalendarCell_DATE_CELL_BACKGROUND_COLOR ([[UIColor greenColor] colorWithAlphaComponent:.3f]) // 只有日期的cell的背景颜色
#define SkyCalendarCell_EMPTY_CELL_BACKGROUND_COLOR ([UIColor whiteColor]) // 空白cell背景颜色

#endif
