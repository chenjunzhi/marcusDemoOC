//
//  THSpecificationVC.h
//  Tuhu
//
//  Created by marcus on 15/12/1.
//  Copyright © 2015年 marcus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    THSpecificationTypeDefault = 0,  //从 已选规格 进入该界面    本界面下方显示：加入购物车 或 立即购买
    THSpecificationTypeBuy = 1,      //从 立即购买  进入该界面   本界面下方显示：确定
    THSpecificationTypeAddCart = 2,  //从 加入购物车 进入该界面   本界面下方显示：确定
} THSpecificationType;

@interface THSpecificationVC : UIViewController
@property (assign, nonatomic) THSpecificationType specificationType;
@property (strong, nonatomic) NSMutableArray *specificationArray;    //规格数组  存储字典 specificationsName :   specificationsItem

@end
