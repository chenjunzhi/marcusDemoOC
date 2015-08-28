//
//  MSToolsDemoVC.m
//  marcusDemoOC
//
//  Created by marcus on 15/8/11.
//  Copyright (c) 2015年 marcus. All rights reserved.
//

#import "MSToolsDemoVC.h"
#import "MSTools.h"

@interface MSToolsDemoVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFirst;

@end

@implementation MSToolsDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(UIButton *)sender {
    //   转换高斯模糊图片
    UIImage * tempImage  = [MSTools getImageFromInsideRect:_imageView.frame WithImage:_imageViewFirst.image];
    _imageView.image = [MSTools applyBlurOnImage:tempImage withRadius:0.5];
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
