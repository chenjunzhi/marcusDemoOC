
//  MSStarRateViewDemoVC.m
//  marcusDemoOC
//
//  Created by marcus on 15/8/10.
//  Copyright (c) 2015年 marcus. All rights reserved.
//

#import "MSStarRateViewDemoVC.h"
#import "MSStarRateView.h"

@interface MSStarRateViewDemoVC ()<MSStarRateViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (strong, nonatomic) MSStarRateView *starRateView;
@property (weak, nonatomic) IBOutlet UISwitch *switchAnimate;
@property (weak, nonatomic) IBOutlet UISwitch *switchIncompleteStar;

@end

@implementation MSStarRateViewDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论星星DEMO";
    _starRateView = [[MSStarRateView alloc]initWithFrame:CGRectMake(0, 0, _starView.bounds.size.width, _starView.bounds.size.height) numberOfStars:5 foregroundImageName:@"icon_star_yellow.png" backgroundImageName:@"icon_star_gray.png"];
//    _starRateView = [[MSStarRateView alloc]initWithFrame:CGRectMake(0, 0, _starView.bounds.size.width, _starView.bounds.size.height) numberOfStars:5 ];
    _starRateView.scorePercent = 0.6;
    _gradeLabel.text = [NSString stringWithFormat:@"%.2f",0.6*5];
    [_starView addSubview:_starRateView];
    _starRateView.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)starRateView:(MSStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent{
    _gradeLabel.text = [NSString stringWithFormat:@"%.2f",newScorePercent*5];
}

- (IBAction)animateSwitchChange:(UISwitch *)sender {
    _starRateView.hasAnimation = sender.on;
}

- (IBAction)IncompleteStarChange:(UISwitch *)sender {
    _starRateView.allowIncompleteStar = !sender.on;
    
}

@end
