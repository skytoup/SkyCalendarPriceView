//
//  SkyCalendarPriceLayout.m
//  SkyCalendarPriceTest
//
//  Created by skytoup on 15/7/23.
//  Copyright (c) 2015年 skytoup. All rights reserved.
//

#import "SkyCalendarPriceLayout.h"

@implementation SkyCalendarPriceLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *marr = (id)[super layoutAttributesForElementsInRect:rect];
    
    NSMutableIndexSet *hasSectionSet = [NSMutableIndexSet new];
    NSMutableArray *headerAtts = [NSMutableArray new];

    [marr enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *att, NSUInteger idx, BOOL *stop) {
        [hasSectionSet addIndex:att.indexPath.section];
        if([att.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            att.zIndex = 1024+att.indexPath.section;
            [headerAtts addObject:att];
            [hasSectionSet removeIndex:att.indexPath.section];
        } else {
            att.zIndex = att.indexPath.section*32+att.indexPath.row;
        }
    }];
    [hasSectionSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *headerAtt = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:idx] ];
        headerAtt.zIndex = 1024+headerAtt.indexPath.section;
        [headerAtts insertObject:headerAtt atIndex:0];
        [marr addObject:headerAtt];
    }];

    CGFloat cy = self.collectionView.contentOffset.y;

    [headerAtts enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *att, NSUInteger idx, BOOL *stop) {
        NSInteger c = [self.collectionView numberOfItemsInSection:att.indexPath.section];
        CGRect lf = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:c inSection:att.indexPath.section] ].frame;
        
        CGFloat s = att.frame.origin.y;
        CGFloat e = lf.origin.y + CGRectGetHeight(lf);
        if(cy>s && cy<e) {
            *stop = YES;
            CGFloat y = e-CGRectGetHeight(att.frame);
            att.frame = (CGRect){ {att.frame.origin.x, cy<y?cy:y}, att.frame.size}; 
        }
    }];
    
    return marr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
