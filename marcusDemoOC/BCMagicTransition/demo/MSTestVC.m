//
//  MSTestVC.m
//  marcusDemoOC
//
//  Created by marcus on 15/8/26.
//  Copyright (c) 2015年 marcus. All rights reserved.
//

#import "MSTestVC.h"

@interface MSTestVC ()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

@implementation MSTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _leftLabel.text = @"In";
    _centerLabel.text = @"Do any additional setup after loading the view from its nib";
    _rightLabel.text = @"Passd any additional setup";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
