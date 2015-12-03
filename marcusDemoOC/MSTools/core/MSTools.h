//
//  MSTools.h
//  marcusDemoOC
//
//  Created by marcus on 15/8/11.
//  Copyright (c) 2015年 marcus. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MSTools : NSObject

//****** 图片处理
//截取某个位置的图片
+ (UIImage*)getImageFromInsideRect:(CGRect)rect WithImage:(UIImage*)image;
//将图片做高斯模糊
+ (UIImage *)applyBlurOnImage: (UIImage *)imageToBlur
                   withRadius:(CGFloat)blurRadius;


/****** 计算字符串的像素长度 ******/
+(CGFloat)iStringLength:(NSString *)str font:(UIFont *)font;

@end
