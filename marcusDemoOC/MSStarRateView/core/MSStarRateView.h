//
//  MSStarRateVIew.h
//  marcusDemoOC
//
//  Created by marcus on 15/8/10.
//  Copyright (c) 2015年 marcus. All rights reserved.
//
// *********** 评论星星 控件 **************
// *** 支持滑动评分，支持分数为小数
// *** 星星图片可自定义
// ***

#import <UIKit/UIKit.h>

@class MSStarRateView;
@protocol MSStarRateViewDelegate <NSObject>
@optional
- (void)starRateView:(MSStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;
@end
@interface MSStarRateView : UIView
@property (nonatomic, assign) CGFloat scorePercent;          //得分值，范围为0--1，默认为1
@property (nonatomic, assign) BOOL hasAnimation;             //是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;      //评分时是否允许不是整星，默认为NO
@property (nonatomic, assign) BOOL isAllowChange;            //是否允许改变评分， 默认为 YES
@property (strong, nonatomic) NSString * foregroundImageName;
@property (strong, nonatomic) NSString * backgroundImageName; //星星背景图片，默认为 star-off


@property (nonatomic, weak) id<MSStarRateViewDelegate>delegate;

//*** 参数 *****
//*** numberOfStars: 星星的数量
//*** foregroundImageName: 星星前景图片，默认为 star-on
//*** backgroundImageName: 星星背景图片，默认为 star-off
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;
- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars foregroundImageName:(NSString*)foregroundImageName backgroundImageName:(NSString*)backgroundImageName;

@end
