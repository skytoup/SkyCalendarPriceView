//
//  ViewControllerTest2.m
//  SkyCalendarPriceViewTest
//
//  Created by skytoup on 15/7/24.
//  Copyright (c) 2015年 skytoup. All rights reserved.
//

#import "ViewControllerTest2.h"
#import "SkyCalendarPriceView.h"

@interface ViewControllerTest2 () <SkyCalendarPriceViewDelegate>
@property (weak, nonatomic) SkyCalendarPriceView *v;
@end

@implementation ViewControllerTest2

- (void)viewDidLoad {
    [super viewDidLoad];
    _v = [SkyCalendarPriceView calendarPriceViewWithToday:[NSDate date] ];
//    _v = [SkyCalendarPriceView calendarPriceViewWithTodayOfYear:1 ofMonth:1 ofDay:1];
    _v.today = [NSDate date];
    _v.calendarDelegate = self;
    _v.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64);
    [self.view addSubview:_v];
    
//    _v.collectionViewLayout = [UICollectionViewFlowLayout new]; // 取消顶部停靠
    SkyCalendarPriceLayout* layout = (id)_v.collectionViewLayout;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    SkyCalendarPriceModel *model = [SkyCalendarPriceModel calendarPriceModelWithYear:@(2015) withMonth:@(3) withDay:@(22) withPrice:@(30) withCount:@(10)];
    SkyCalendarPriceModel *model2 = [SkyCalendarPriceModel calendarPriceModelWithYear:@(2015) withMonth:@(9) withDay:@(22) withPrice:@(10) withCount:@(10)];
    SkyCalendarPriceModel *model3 = [SkyCalendarPriceModel calendarPriceModelWithYear:@(2015) withMonth:@(7) withDay:@(24) withPrice:@(20) withCount:@(10)];
    _v.datas = @[model, model2, model3];
    _v.today = [NSDate date];
    
    NSArray *cs = @[ [UIColor redColor], [UIColor orangeColor], [UIColor blueColor], [UIColor yellowColor], [UIColor whiteColor], [UIColor brownColor], [UIColor greenColor] ];
    [SkyCalendarHeader SkyCalendarPriceViewInitHeaderViewOfWeekLabelsStyleWithBlock:^(NSArray *labels) {
        [labels enumerateObjectsUsingBlock:^(UILabel *lb, NSUInteger idx, BOOL *stop) {
            lb.backgroundColor = cs[idx];
            lb.layer.borderWidth = 1.f;
            lb.layer.borderColor = [UIColor blackColor].CGColor;
        }];
    }];
    
    [SkyCalendarHeader SkyCalendarPriceViewInitHeaderViewOfYearMonthViewStyleWithBlock:^(UIView *view) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [btn sizeToFit];
        btn.layer.position = CGPointMake(30, 13);
        [view addSubview:btn];
        
        view.layer.borderColor = [UIColor redColor].CGColor;
        view.layer.borderWidth = 1.f;
        view.layer.cornerRadius = 3.f;
    }];
    

    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    [SkyCalendarCell SkyCalendarPriceViewInitCellStyleWithBlock:^(UICollectionViewCell *cell) {
        cell.layer.borderColor = [UIColor blackColor].CGColor;
        cell.layer.borderWidth = 1.f;
    }];
    
}

#pragma mark - SkyCalendarPriceViewDelegate
- (BOOL)skyCalendarPriceView:(SkyCalendarPriceView*)cview shouldSelectIndexWithPriceModel:(SkyCalendarPriceModel*)model {
    NSLog(@"选中：%@-%@-%@ $%@ 剩%@", model.year.stringValue, model.month.stringValue, model.day.stringValue, model.price.stringValue, model.count.stringValue);
    return YES;
}

- (void)skyCalendarPriceView:(SkyCalendarPriceView*)cview didUnselectIndexWithPriceModel:(SkyCalendarPriceModel*)model {
    NSLog(@"取消选择选中：%@-%@-%@ $%@ 剩%@", model.year.stringValue, model.month.stringValue, model.day.stringValue, model.price.stringValue, model.count.stringValue);
}

- (NSDictionary*)skyCalendarPriceView:(SkyCalendarPriceView*)cview cellDataStringDictionaryWithIndexPath:(NSIndexPath*)indexPath withYear:(NSString*)year withMonth:(NSString*)month withDay:(NSString*)day withPrice:(NSString*)price withCount:(NSString*)count withIsToday:(BOOL)isToady {
    // 也可以这样
//    NSMutableDictionary *dic = [NSMutableDictionary new];
//    dic.dayStr = [NSString stringWithFormat:@"%@号", day];
//    dic.priceStr = [NSString stringWithFormat:@"%@元", price];
//    dic.countStr = nil;
    
    return @{kSkyCalendarPriceViewCellDataKeyDay:[NSString stringWithFormat:@"%@号", day],
             kSkyCalendarPriceViewCellDataKeyPrice:[NSString stringWithFormat:@"%@元", price]
//             kSkyCalendarPriceViewCellDataKeyCount:[NSString stringWithFormat:@"还有%@", count]
             };
}

- (NSString*)skyCalendarPriceView:(SkyCalendarPriceView*)cview cellDayStringWithYear:(NSString*)year withMonth:(NSString*)month withDay:(NSString *)day withIsToday:(BOOL)isToday {
    if(isToday) {
        return @"今天哦";
    }
    return nil;
}

- (NSString*)skyCalendarPriceView:(SkyCalendarPriceView *)cview headerLabelStringWithYear:(NSString*)year withMonth:(NSString*)month {
    return [NSString stringWithFormat:@"这是%@月%@年，呵呵", month, year];
}

- (void)dealloc {
    [SkyCalendarHeader SkyCalendarPriceViewInitHeaderViewOfYearMonthViewStyleWithBlock:nil];
    [SkyCalendarHeader SkyCalendarPriceViewInitHeaderViewOfWeekLabelsStyleWithBlock:nil];
    [SkyCalendarCell SkyCalendarPriceViewInitCellStyleWithBlock:nil];
}

@end
