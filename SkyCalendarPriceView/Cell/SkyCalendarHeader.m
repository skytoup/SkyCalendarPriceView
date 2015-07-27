//
//  SkyCalendarHeader.m
//  SkyCalendarPriceTest
//
//  Created by skytoup on 15/7/23.
//  Copyright (c) 2015年 skytoup. All rights reserved.
//

#import "SkyCalendarHeader.h"

@interface SkyCalendarHeader ()
@property (strong, nonatomic) UILabel *yearAndMonthLb;
@property (strong, nonatomic) NSMutableArray *weekLbs;
@end

@implementation SkyCalendarHeader

static void(^InitHeaderStyleBlock)(UIView*);
+ (void)SkyCalendarPriceViewInitHeaderViewOfYearMonthViewStyleWithBlock:(void(^)(UIView *view))block {
    if(InitHeaderStyleBlock) {
        Block_release((__bridge void*)block);
    }
    InitHeaderStyleBlock = (__bridge id)Block_copy((__bridge void*)block);
}

static void(^InitWeekLablesStyleBlock)(NSArray*);
+ (void)SkyCalendarPriceViewInitHeaderViewOfWeekLabelsStyleWithBlock:(void(^)(NSArray *labels))block {
    if(InitWeekLablesStyleBlock) {
        Block_release((__bridge void*)block);
    }
    InitWeekLablesStyleBlock = (__bridge id)Block_copy((__bridge void*)block);
}

+ (CGFloat)height {
    return SkyCalendarHeader_TOP_PADDING+SkyCalendarHeader_WEEK_LB_HEIGHT+SkyCalendarHeader_YEAR_MONTH_LB_HEIGHT;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = SkyCalendarHeader_BACKGROUND_COLOR;
        
        UILabel *yearAndMonthLb = [UILabel new];
        _yearAndMonthLb = yearAndMonthLb;
        yearAndMonthLb.textAlignment = NSTextAlignmentCenter;
        yearAndMonthLb.translatesAutoresizingMaskIntoConstraints = NO;
        yearAndMonthLb.font = [UIFont systemFontOfSize:SkyCalendarHeader_YEAR_MONTH_LB_FONE_SIZE];
        yearAndMonthLb.textColor = SkyCalendarHeader_YEAR_MONTH_LB_FONE_COLOR;
        
        UIView *weekView = [UIView new];
        weekView.translatesAutoresizingMaskIntoConstraints = NO;
        weekView.backgroundColor = SkyCalendarHeader_WEEK_VIEW_BACKGROUND_COLOR;
        
        [self addSubview:yearAndMonthLb];
        [self addSubview:weekView];
        
        id vs = NSDictionaryOfVariableBindings(yearAndMonthLb, weekView);
        id ms = @{@"topPadding":@(SkyCalendarHeader_TOP_PADDING), @"weekLbHeight":@(SkyCalendarHeader_WEEK_LB_HEIGHT), @"YearMonthLbHeight":@(SkyCalendarHeader_YEAR_MONTH_LB_HEIGHT)};
        id cs1 = [NSLayoutConstraint constraintsWithVisualFormat:@"|[yearAndMonthLb]|" options:0 metrics:nil views:vs];
        id cs2 = [NSLayoutConstraint constraintsWithVisualFormat:@"|[weekView]|" options:0 metrics:nil views:vs];
        id cs3 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-topPadding-[yearAndMonthLb(YearMonthLbHeight)][weekView(weekLbHeight)]" options:0 metrics:ms views:vs];
        [self addConstraints:cs1];
        [self addConstraints:cs2];
        [self addConstraints:cs3];
        
        _weekLbs = [NSMutableArray new];
        id weeks = @[SkyCalendarHeader_SYMBOL_SUNDAY, SkyCalendarHeader_SYMBOL_MONDAY, SkyCalendarHeader_SYMBOL_TUESDAY, SkyCalendarHeader_SYMBOL_WEDNESDAY, SkyCalendarHeader_SYMBOL_THURSDAY, SkyCalendarHeader_SYMBOL_FRIDAY, SkyCalendarHeader_SYMBOL_SATURDAY];
        for(int i=0; i<7 ; i++) {
            UILabel *lb = [UILabel new];
            lb.font = [UIFont systemFontOfSize:SkyCalendarHeader_WEEK_LB_FONE_SIZE];
            lb.textColor = SkyCalendarHeader_WEEK_LB_FONE_COLOR;
            lb.textAlignment = NSTextAlignmentCenter;
            lb.text = weeks[i];
            [weekView addSubview:lb];
            [_weekLbs addObject:lb];
        }
        [self adjustWeekLbsWithWidth:CGRectGetWidth(frame) withCellSpace:1.f withSectionInset:UIEdgeInsetsZero];
        
        if(InitHeaderStyleBlock) {
            InitHeaderStyleBlock(yearAndMonthLb);
        }
        if(InitWeekLablesStyleBlock) {
            InitWeekLablesStyleBlock(_weekLbs);
        }
    }
    return self;
}

- (void)adjustWeekLbsWithWidth:(CGFloat)width withCellSpace:(CGFloat)space withSectionInset:(UIEdgeInsets)inset {
    CGFloat w = (width-space*6.f-inset.left-inset.right)/7.f;
    CGFloat x = w+space;
    [_weekLbs enumerateObjectsUsingBlock:^(UILabel *lb, NSUInteger idx, BOOL *stop) {
        lb.frame = CGRectMake(inset.left+x*idx, 0.f, w, SkyCalendarHeader_WEEK_LB_HEIGHT);
    }];
}

- (void)setTitle:(NSString*)title {
    _yearAndMonthLb.text = title;
}

@end
