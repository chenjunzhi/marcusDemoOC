//
//  ASDepthModalDemoVC.m
//  marcusDemoOC
//
//  Created by marcus on 15/8/11.
//  Copyright (c) 2015年 marcus. All rights reserved.
//

#define kHight ([[UIScreen mainScreen] bounds].size.height)
#define kWidth ([[UIScreen mainScreen] bounds].size.width)

#import "ASDepthModalDemoVC.h"
#import "ASDepthModalViewController.h"
#import "MSStarRateViewDemoVC.h"


@interface danli : NSObject

@property (strong, nonatomic) UIViewController * vc;

+ (instancetype)shared;
@end

@implementation danli

+ (instancetype)shared
{
    static danli * d;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        d = [[danli alloc] init];
    });
    return d;
}

@end



@interface ASDepthModalDemoVC ()

@end

@implementation ASDepthModalDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showViewLeft:(UIButton *)sender {
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 220, kHight)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 100, 21)];
    label.text = @"左侧弹出";
    [view addSubview:label];
    [ASDepthModalViewController presentView:view withBackgroundColor:nil popupAnimationStyle:ASDepthModalAnimationLeftPopue];
    
}
- (IBAction)showViewBottom:(UIButton *)sender {
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 400)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 100, 21)];
    label.text = @"底部弹出";
    [view addSubview:label];
    MSStarRateViewDemoVC * vc = [[MSStarRateViewDemoVC alloc]init];
    vc.view.frame = CGRectMake(0, 0, kWidth, 400);
    danli * d = [danli shared];
    d.vc = vc;
    
    [ASDepthModalViewController presentView:vc.view withBackgroundColor:nil popupAnimationStyle:ASDepthModalAnimationBottomPopue];
}

- (IBAction)showViewRight:(UIButton *)sender {
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 220, kHight)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 100, 21)];
    label.text = @"右侧弹出";
    [view addSubview:label];
    [ASDepthModalViewController presentView:view withBackgroundColor:nil popupAnimationStyle:ASDepthModalAnimationRightPopue];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
