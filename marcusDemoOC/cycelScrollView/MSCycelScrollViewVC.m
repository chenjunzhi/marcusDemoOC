//
//  MSCycelScrollViewVC.m
//  marcusDemoOC
//
//  Created by marcus on 15/9/14.
//  Copyright (c) 2015年 marcus. All rights reserved.
//

#import "MSCycelScrollViewVC.h"
#import "marcusDemoOC-Swift.h"
#import "MMLib.h"

@interface MSCycelScrollViewVC ()
@property (strong, nonatomic) MMCycelScrollView *mmCycelScrollView;

@end

@implementation MSCycelScrollViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _mmCycelScrollView = [[MMCycelScrollView alloc]init];
    _mmCycelScrollView.isUseLayoutConstraints = NO;
    _mmCycelScrollView.frame = CGRectMake(0, 100, ScreenWidth, 100);
    _mmCycelScrollView.pageNumbers = 5;
//    _mmCycelScrollView.scrollAnimation = YES;
    [self.view addSubview:_mmCycelScrollView];
    _mmCycelScrollView.viewOfPageBlock = ^UIView*(NSInteger index) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 100)];
        view.backgroundColor = (index%2)?[UIColor redColor]:[UIColor blackColor];
        return view;
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
