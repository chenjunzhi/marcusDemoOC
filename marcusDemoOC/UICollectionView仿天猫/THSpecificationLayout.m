//
//  THSpecificationLayout.m
//  marcusDemoOC
//
//  Created by marcus on 15/12/2.
//  Copyright © 2015年 marcus. All rights reserved.
//

#import "THSpecificationLayout.h"

@implementation THSpecificationLayout

- (NSArray *) layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *answer = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    //从第一个开始
    for(int i = 1; i < [answer count]; ++i) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = answer[i];
        //每个分区的第一个不做处理
        if (currentLayoutAttributes.indexPath.row != 0) {
            UICollectionViewLayoutAttributes *prevLayoutAttributes = answer[i - 1];
            NSInteger maximumSpacing = 10;
            NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
            if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
                CGRect frame = currentLayoutAttributes.frame;
                frame.origin.x = origin + maximumSpacing;
                currentLayoutAttributes.frame = frame;
            }
        }
    }
    return answer;
}

@end
