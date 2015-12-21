//
//  THSpecificationModel.h
//  marcusDemoOC
//
//  Created by marcus on 15/12/1.
//  Copyright © 2015年 marcus. All rights reserved.
//

#import "MMBaseModel.h"

@interface THSpecificationModel : MMBaseModel
@property (strong, nonatomic) NSString *productId;
@property (strong, nonatomic) NSString *variantId;
@property (strong, nonatomic) NSString *specificationsValue;  //规格值
@property (assign, nonatomic) BOOL bSelected;                 //是否选中

@end
