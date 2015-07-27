//
//  SkyCalendarCell.m
//  SkyCalendarPriceTest
//
//  Created by skytoup on 15/7/23.
//  Copyright (c) 2015年 skytoup. All rights reserved.
//

#import "SkyCalendarCell.h"

@interface SkyCalendarCell ()
@property (strong, nonatomic) UILabel *lb1;
@property (strong, nonatomic) UILabel *lb2;
@property (strong, nonatomic) UILabel *lb3;
@end

@implementation SkyCalendarCell

static void(^InitCellStyleBlock)(UIView*);
+ (void)SkyCalendarPriceViewInitCellStyleWithBlock:(void(^)(UICollectionViewCell *cell))block {
    if(InitCellStyleBlock) {
        Block_release((__bridge void*)block);
    }
    InitCellStyleBlock = (__bridge id)Block_copy((__bridge void*)block);
}

+ (CGFloat)hegith {
    return (SkyCalendarCell_LB_HEIGHT)*3.f+SkyCalendarCell_LB_PADDING*2.f+SkyCalendarCell_PADDING*2.f;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *lb1 = [self createLb];
        UILabel *lb2 = [self createLb];
        UILabel *lb3 = [self createLb];
        
        _lb1 = lb1;
        _lb2 = lb2;
        _lb3 = lb3;
        
        _lb1.textColor = SkyCalendarCell_DAY_COLOR;
        _lb3.textColor = SkyCalendarCell_COUNT_COLOR;
        
        id vs = NSDictionaryOfVariableBindings(lb1, lb2, lb3);
        id ms = @{@"lbHeight":@(SkyCalendarCell_LB_HEIGHT), @"lbPadding":@(SkyCalendarCell_LB_PADDING)};
        id cs1 = [NSLayoutConstraint constraintsWithVisualFormat:@"|[lb1]|" options:0 metrics:nil views:vs];
        id cs2 = [NSLayoutConstraint constraintsWithVisualFormat:@"|[lb2]|" options:0 metrics:nil views:vs];
        id cs3 = [NSLayoutConstraint constraintsWithVisualFormat:@"|[lb3]|" options:0 metrics:nil views:vs];
        id cs4 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lb1(lbHeight)]-lbPadding-[lb2(lbHeight)]-lbPadding-[lb3(lbHeight)]" options:0 metrics:ms views:vs];
        id c = [NSLayoutConstraint constraintWithItem:lb2 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:lb2.superview attribute:NSLayoutAttributeCenterY multiplier:1.f constant:1.f];
        
        [self.contentView addConstraint:c];
        [self.contentView addConstraints:cs1];
        [self.contentView addConstraints:cs2];
        [self.contentView addConstraints:cs3];
        [self.contentView addConstraints:cs4];
        
        if(InitCellStyleBlock) {
            InitCellStyleBlock(self);
        }
    }
    return self;
}

- (UILabel*)createLb {
    UILabel *lb = [UILabel new];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.font = [UIFont systemFontOfSize:SkyCalendarCell_LB_FONT_SIZE];
    lb.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:lb];
    return lb;
}

- (void)setContentWithDay:(NSString*)day withPrice:(NSString*)price withCount:(NSString*)count {
    self.backgroundColor = self.isSelected?SkyCalendarCell_DATA_CELL_SELECT_BACKGROUND_COLOR:SkyCalendarCell_DATA_CELL_UNSELECT_BACKGROUND_COLOR;
    _lb1.text = day;
    _lb2.text = price;
    _lb3.text = count;

    _lb2.textColor = SkyCalendarCell_PRICE_COLOR;
    _lb2.font = [UIFont systemFontOfSize:SkyCalendarCell_LB_FONT_SIZE];
}

- (void)setContentWithDay:(NSString*)day {
    self.backgroundColor = SkyCalendarCell_DATE_CELL_BACKGROUND_COLOR;
    _lb1.text = @"";
    _lb2.text = day;
    _lb3.text = @"";
    
    _lb2.textColor = SkyCalendarCell_DARE_COLOR_ONLY_DAY;
    _lb2.font = [UIFont systemFontOfSize:SkyCalendarCell_LB_FONE_SIZE_ONLY_DAY];
}

- (void)setContentEmpty {
    self.backgroundColor = SkyCalendarCell_EMPTY_CELL_BACKGROUND_COLOR;
    _lb1.text = @"";
    _lb2.text = @"";
    _lb3.text = @"";
}

// 暂时用不上
//- (void)setContentWithModel:(SkyCalendarPriceModel*)model {
//    if(model.price) {
//        [self setContentWithDay:model.day withPrice:model.price withCount:model.count];
//    } else if(model.day) {
//        [self setContentWithDay:model.day];
//    } else {
//        [self setContentEmpty];
//    }
//}

@end
