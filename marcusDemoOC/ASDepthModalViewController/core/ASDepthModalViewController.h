//
//  ASDepthModalViewController.h
//  ASDepthModal
//
//  Created by Philippe Converset on 03/10/12.
//  Copyright (c) 2012 AutreSphere.
//

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//***** 让底部controller 获得景深效果 *****

#import <UIKit/UIKit.h>

typedef enum
{
    ASDepthModalAnimationGrow = 0, //从中间扩展动画  最后居中
    ASDepthModalAnimationShrink, //从中间收缩动画  最后居中
    ASDepthModalAnimationNone,  //没有动画  最后居中
    ASDepthModalAnimationRightPopue, //从右侧弹出  最后靠右
    ASDepthModalAnimationLeftPopue, //从左侧弹出  最后靠左
    ASDepthModalAnimationBottomPopue, //从底部弹出 最后靠下
    ASDepthModalAnimationDefault = ASDepthModalAnimationGrow,
} ASDepthModalAnimationStyle;

/*
Mostly inspired by http://lab.hakim.se/avgrund/
*/
@interface ASDepthModalViewController : UIViewController

+ (void)presentView:(UIView *)view withBackgroundColor:(UIColor *)color popupAnimationStyle:(ASDepthModalAnimationStyle)popupAnimationStyle;
+ (void)presentView:(UIView *)view;
+ (void)dismiss;

@end
