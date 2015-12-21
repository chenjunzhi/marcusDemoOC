//
//  THSpecificationCell.h
//  marcusDemoOC
//
//  Created by marcus on 15/12/2.
//  Copyright © 2015年 marcus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THSpecificationModel.h"
#import "marcusDemoOC-Swift.h"

typedef void(^selectSpecificationBlock)(id,id);

@interface THSpecificationCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet MMColorButton *button;
//@property (strong, nonatomic) THSpecificationModel *specificationModel;
//@property (strong, nonatomic) NSIndexPath *indexPath;
//@property (copy, nonatomic) selectSpecificationBlock specificationBlock;
@end
