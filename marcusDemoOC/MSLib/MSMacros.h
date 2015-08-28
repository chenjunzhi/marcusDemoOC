//
//  MSMacros.h
//  marcusDemoOC
//
//  Created by marcus on 15/8/10.
//  Copyright (c) 2015年 marcus. All rights reserved.
// ******* 常用宏 *********

#ifndef MSMacros_h
#define MSMacros_h

// UIColor 根据16进制颜色值 转成 UIColor
#define UIColorWithCode(_code_)    [UIColor colorWithRed:((float)((_code_ & 0xFF0000) >> 16))/255.0 \
green:((float)((_code_ & 0x00FF00) >> 8))/255.0 \
blue:((float)(_code_ & 0x0000FF))/255.0 \
alpha:1]

// UIColor 根据16进制颜色值和Alpha值 转成 UIColor
#define UIColorWithCodeAlpha(_code_,al)    [UIColor colorWithRed:((float)((_code_ & 0xFF0000) >> 16))/255.0 \
green:((float)((_code_ & 0x00FF00) >> 8))/255.0 \
blue:((float)(_code_ & 0x0000FF))/255.0 \
alpha:al]

// UIColor 根据RGB值 转成 UIColor
#define UIColorWithRGB(_red_, _green_, _blue_)                      UIColorWithRGBA(_red_, _green_, _blue_, 1)

// UIColor 根据RGB值和Alpha值 转成 UIColor
#define UIColorWithRGBA(_red_, _green_, _blue_, _alpha_)        [UIColor colorWithRed:_red_/255.f green:_green_/255.f blue:_blue_/255.f alpha:_alpha_]

// UIColor 没有颜色的时候 转成 UIColor
#define UIColor_Clear  [UIColor clearColor]

// LogRect/Size/Point  打印位置信息
#define NSLogRect(rect)            NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size)             NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point)          NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

// Log
#ifdef DEBUG
#define MMLog(fmt, ...)   do { \
fprintf(stderr, "-------------------------- MMLOG --------------------------\n"); \
static NSDateFormatter* formatter; \
static dispatch_once_t predicate; \
dispatch_once(&predicate, ^{ \
formatter = [[NSDateFormatter alloc] init]; \
formatter.dateFormat = @"YYYY-MM-dd hh:mm:ss.SSS"; \
}); \
fprintf(stderr, "[%s] <%s:%s inLine:%d>\n ", [formatter stringFromDate:[NSDate date]].UTF8String, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __FUNCTION__, __LINE__); \
fprintf(stderr, "%s\n", [NSString stringWithFormat:(fmt), ##__VA_ARGS__].UTF8String); \
} while (0)
#define Mark              MMLog(@"- MARK -");
#else
#define MMLog(fmt, ...)
#define Mark
#endif

//Utils
#define MMCheckNumberInRange(__index_, __first_, __end_) (__index_ >= __first_ && __index_ < __end_)
#define MMCheckUsignNumberUnder(__index_, __limit_) MMCheckNumberInRange(__index_, 0, __limit_)
#define MMCheckArrayInRange(__index_, __container_) MMCheckUsignNumberUnder(__index_, __container_.count)

//屏幕尺寸 相关值
#define ScreenBounds   [UIScreen mainScreen].bounds
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define ScreenScale     [UIScreen mainScreen].scale

//屏幕尺寸高度
#define ScreenHeight4    [UIScreen mainScreen].bounds.size.height == 480
#define ScreenHeight6    [UIScreen mainScreen].bounds.size.height == 667
#define ScreenHeight6p    [UIScreen mainScreen].bounds.size.height >=736

#endif