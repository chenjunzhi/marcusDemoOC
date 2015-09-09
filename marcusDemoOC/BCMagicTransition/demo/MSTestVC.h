//
//  MSTestVC.h
//  marcusDemoOC
//
//  Created by marcus on 15/8/26.
//  Copyright (c) 2015年 marcus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+BCMagicTransition.h"

@interface MSTestVC : UIViewController<BCMagicTransitionProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
