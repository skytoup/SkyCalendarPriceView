//
//  SkyCalendarPriceView.m
//  SkyCalendarPriceTest
//
//  Created by skytoup on 15/7/22.
//  Copyright (c) 2015年 skytoup. All rights reserved.
//

#import "SkyCalendarPriceView.h"
#import "SkyCalendarPriceDataModel.h"

#define SKY_CALENDAR_PRICE_INDETIFIER_HEADER @"__SkyCalendarHeader__"
#define SKY_CALENDAR_PRICE_INDETIFIER_CELL @"__SkyCalendarCell__"

@interface SkyCalendarPriceView ()
@property (strong, nonatomic) NSArray *dataModels;
@property (strong, nonatomic) NSDateFormatter *df;
@property (copy, nonatomic) NSString *todayStr;
@end

@implementation SkyCalendarPriceView
@synthesize datas = _datas, today = _today;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

+ (instancetype)calendarPriceView {
    SkyCalendarPriceLayout *layout = [SkyCalendarPriceLayout new];
    layout.minimumInteritemSpacing = SkyCalendarPriceView_CELL_INTER_SPACE;
    layout.minimumLineSpacing = SkyCalendarPriceView_CELL_LINE_SPACE;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    SkyCalendarPriceView * __autoreleasing v = [[SkyCalendarPriceView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [v setup];
    return v;
}

+ (instancetype)calendarPriceViewWithToday:(NSDate*)today {
    SkyCalendarPriceView * __autoreleasing v = [self calendarPriceView];
    v.today = today;
    return v;
}

+ (instancetype)calendarPriceViewWithTodayOfYear:(int)year ofMonth:(int)month ofDay:(int)day {
    SkyCalendarPriceView * __autoreleasing v = [self calendarPriceView];
    [v setTodayWithYear:year withMonth:month withDay:day];
    return v;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)setup {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    _df = [NSDateFormatter new];
    _df.dateFormat = @"yyyy-MM-dd";
    self.allowsMultipleSelection = NO;
    self.allowsSelection = YES;
    self.backgroundColor = SkyCalendarPriceView_BACKGROUND_COLOR;
    [self registerClass:[SkyCalendarHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SKY_CALENDAR_PRICE_INDETIFIER_HEADER];
    [self registerClass:[SkyCalendarCell class] forCellWithReuseIdentifier:SKY_CALENDAR_PRICE_INDETIFIER_CELL];
    self.delegate = self;
    self.dataSource = self;
}

- (void)orientationChange:(NSNotification *)ntf {
    NSArray *sels = [self indexPathsForSelectedItems];
    [self reloadData];
    [sels enumerateObjectsUsingBlock:^(NSIndexPath *obj, NSUInteger idx, BOOL *stop) {
        [self selectItemAtIndexPath:obj animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }];
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self updateCalendarDatas];
}

- (void)setToday:(NSDate *)today {
    _today = today;
    _todayStr = [_df stringFromDate:_today];
}

- (void)setTodayWithYear:(int)year withMonth:(int)month withDay:(int)day {
    self.today = [self formDateWithYear:year withMonth:month withDay:day];
}

- (NSDate*)formDateWithYear:(int)year withMonth:(int)month withDay:(int)day {
    return [_df dateFromString:[NSString stringWithFormat:@"%4d-%2d-%2d", year, month, day] ];
}

- (void)updateCalendarDatas {
    _dataModels = [SkyCalendarPriceDataModel calendarPriceDataModelsWithCalendarPriceModels:_datas];
    [self reloadData];
}

- (BOOL)isTodayWithYear:(int)year withMonth:(int)month withDay:(int)day {
    BOOL is = NO;
    if(_todayStr) {
        NSDate *date = [self formDateWithYear:year withMonth:month withDay:day];
        if([_todayStr isEqualToString:[_df stringFromDate:date] ]) {
            is = YES;
        }
    }
    return is;
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SkyCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SKY_CALENDAR_PRICE_INDETIFIER_CELL forIndexPath:indexPath];
    SkyCalendarPriceDataModel* dm = _dataModels[indexPath.section];
    NSInteger sw = dm.startWeek.integerValue;
    NSInteger day = indexPath.row - sw + 1;
    if(indexPath.row<sw) {
        [cell setContentEmpty];
    } else {
        SkyCalendarPriceDataSubModel *sdm = [dm modelFromDay:day];
        BOOL isToday = [self isTodayWithYear:dm.year.intValue withMonth:dm.month.intValue withDay:(int)day];
        if(sdm) {
            NSString *dayStr = nil;
            NSString *priceStr = nil;
            NSString *countStr = nil;
            if(_calendarDelegate && [_calendarDelegate respondsToSelector:@selector(skyCalendarPriceView:cellDataStringDictionaryWithIndexPath:withYear:withMonth:withDay:withPrice:withCount:withIsToday:)] ) {
                NSMutableDictionary *dic = [[_calendarDelegate skyCalendarPriceView:self cellDataStringDictionaryWithIndexPath:[NSIndexPath indexPathForItem:indexPath.row inSection:indexPath.section] withYear:dm.year.stringValue withMonth:dm.month.stringValue withDay:sdm.day.stringValue withPrice:sdm.price.stringValue withCount:sdm.count.stringValue withIsToday:isToday] mutableCopy];
                if(dic) {
                    dayStr = dic.dayStr;
                    priceStr = dic.priceStr;
                    countStr = dic.countStr;
                }
            }
            [cell setContentWithDay:dayStr?dayStr:(isToday?@"今天":sdm.day.stringValue) withPrice:priceStr?priceStr:sdm.price.stringValue withCount:countStr?countStr:sdm.count.stringValue];
        } else {
            NSString *dayStr = nil;
            if(_calendarDelegate && [_calendarDelegate respondsToSelector:@selector(skyCalendarPriceView:cellDayStringWithYear:withMonth:withDay:withIsToday:)] ) {
                dayStr = [_calendarDelegate skyCalendarPriceView:self cellDayStringWithYear:dm.year.stringValue withMonth:dm.month.stringValue withDay:[NSNumber numberWithInteger:day].stringValue withIsToday:isToday];
            }
            [cell setContentWithDay:dayStr?dayStr:(isToday?@"今天":[NSNumber numberWithInteger:day].stringValue)];
        }
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataModels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    SkyCalendarPriceDataModel* dm = _dataModels[section];
    return dm.dayCount.integerValue+dm.startWeek.integerValue;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SkyCalendarHeader *h = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SKY_CALENDAR_PRICE_INDETIFIER_HEADER forIndexPath:indexPath];
        CGFloat w = CGRectGetWidth(self.frame);
        UICollectionViewFlowLayout *layout = (id)self.collectionViewLayout;
        SkyCalendarPriceDataModel *m = _dataModels[indexPath.section];
        NSString *ymStr = nil;
        if([_calendarDelegate respondsToSelector:@selector(skyCalendarPriceView:headerLabelStringWithYear:withMonth:)] ) {
            ymStr = [_calendarDelegate skyCalendarPriceView:self headerLabelStringWithYear:m.year.stringValue withMonth:m.month.stringValue];
        }
        [h setTitle:ymStr?ymStr:[NSString stringWithFormat:@"%@年%@月", m.year.stringValue, m.month.stringValue] ];
        [h adjustWeekLbsWithWidth:w withCellSpace:layout.minimumInteritemSpacing withSectionInset:layout.sectionInset];
        return h;
    } else {
        return nil;
    }
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat w = CGRectGetWidth(self.frame);
    UICollectionViewFlowLayout *layout = (id)self.collectionViewLayout;
    CGFloat s = (w - layout.sectionInset.left - layout.sectionInset.right - 6.f*layout.minimumInteritemSpacing) / 7.f;
    return CGSizeMake(s, [SkyCalendarCell hegith]);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    CGFloat w = CGRectGetWidth(self.frame);
    UICollectionViewFlowLayout *layout = (id)self.collectionViewLayout;
    w -= (layout.sectionInset.left + layout.sectionInset.right);
    return CGSizeMake(w, [SkyCalendarHeader height]);
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SkyCalendarPriceDataModel* dm = _dataModels[indexPath.section];
    NSInteger sw = dm.startWeek.integerValue;
    if(!dm.models.count || indexPath.row < sw) {
        return NO;
    }

    BOOL isSel = YES;
    NSInteger day = indexPath.row - sw + 1;
    SkyCalendarPriceModel *model = (id)[dm modelFromDay:day];
    NSArray *selsIdx = [self indexPathsForSelectedItems];
    if(selsIdx.count) {
        NSIndexPath* selIdx = selsIdx.firstObject;
        if (indexPath.section==selIdx.section && indexPath.row==selIdx.row) {
            isSel = NO;
            if([_calendarDelegate respondsToSelector:@selector(skyCalendarPriceView:didUnselectIndexWithPriceModel:)] ) {
                [_calendarDelegate skyCalendarPriceView:self didUnselectIndexWithPriceModel:model];
            }
        }
    }
    
    if(isSel) {
        if(model) {
            if([_calendarDelegate respondsToSelector:@selector(skyCalendarPriceView:shouldSelectIndexWithPriceModel:)] ) {
                isSel = [_calendarDelegate skyCalendarPriceView:self shouldSelectIndexWithPriceModel:model];
            }
        } else {
            isSel = NO;
        }
        if(!isSel) {
            return NO;
        }
    }
    
    [collectionView reloadData];
    return isSel;
}

@end
