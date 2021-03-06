//
//  ViewController.m
//  marcusDemoOC
//
//  Created by marcus on 15/8/10.
//  Copyright (c) 2015年 marcus. All rights reserved.
//

#import "ViewController.h"
#import "MSStarRateViewDemoVC.h"
#import "ASDepthModalDemoVC.h"
#import "MSToolsDemoVC.h"
#import "MJNIndexDemoVC.h"
#import "MSTestVC.h"
#import "MSBarCodeViewController.h"
#import "SCRootViewController.h"
#import "MMLib.h"
#import "MSCycelScrollViewVC.h"
#import "ASDepthModalViewController.h"
#import "THSpecificationVC.h"
#import "THSpecificationModel.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *jumpArray;
@property (strong, nonatomic) THSpecificationVC * spectificationVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeBottom;
    self.title = @"功能集合";
    [self initData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark initData
-(void)initData{
    _jumpArray = [[NSMutableArray alloc]init];
    
//    评论星星
    NSDictionary * starDic = @{@"dispalyName":@"评论星星功能",@"controllerName":@"MSStarRateViewDemoVC"};
    [_jumpArray addObject:starDic];
    
//    景深 效果
    NSDictionary * depthDic = @{@"dispalyName":@"景深效果",@"controllerName":@"ASDepthModalDemoVC"};
    [_jumpArray addObject:depthDic];
    
//    高斯 模糊
    NSDictionary * toolsDic = @{@"dispalyName":@"高斯模糊效果",@"controllerName":@"MSToolsDemoVC"};
    [_jumpArray addObject:toolsDic];
    
//******  实现多种特殊动画效果的列表目录 ******
    NSDictionary *indexDic = @{@"dispalyName":@"特殊效果列表目录",@"controllerName":@"MJNIndexDemoVC"};
    [_jumpArray addObject:indexDic];

//******* 特殊动画跳转界面
    NSDictionary *msTestVCDic = @{@"dispalyName":@"特殊动画跳转界面",@"controllerName":@"MSTestVC"};
    [_jumpArray addObject:msTestVCDic];
    
//******* 扫描二维码条形码
    NSDictionary *barCodeDic = @{@"dispalyName":@"扫描二维码条形码",@"controllerName":@"MSBarCodeViewController"};
    [_jumpArray addObject:barCodeDic];
    
//******* 多标签显示特效
    NSDictionary *pageControllerCodeDic = @{@"dispalyName":@"多标签显示特效",@"controllerName":@"SCRootViewController"};
    [_jumpArray addObject:pageControllerCodeDic];
    
//****** 循环滚动视图
    NSDictionary *scrollViewDic = @{@"dispalyName":@"循环滚动视图",@"controllerName":@"MSCycelScrollViewVC"};
    [_jumpArray addObject:scrollViewDic];
    
//****** 测试UICollectionView
    NSDictionary *collectionDic = @{@"dispalyName":@"UICollectionView视图",@"controllerName":@"UICollectionViewVC"};
    [_jumpArray addObject:collectionDic];
    _spectificationVC = [[THSpecificationVC alloc]init];
    _spectificationVC.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight*2.0/3.0);
    _spectificationVC.specificationType = THSpecificationTypeDefault;
    NSMutableArray * array = [[NSMutableArray alloc]init];
    for (int i = 0; i<4; i++) {
        NSMutableArray * specificationsItemArray = [[NSMutableArray alloc]init];
        for (int j = 0; j<(i+1)*3 ; j++) {
            THSpecificationModel * model = [[THSpecificationModel alloc]init];
            model.bSelected = NO;
            model.productId = [NSString stringWithFormat:@"%d---%d",i,j];
            if (j%2 == 0) {
                model.specificationsValue = [NSString stringWithFormat:@"test测试数据%d---%d",i*j*j*10,j];
            }else{
                model.specificationsValue = [NSString stringWithFormat:@"test%d",i*j];
            }
            [specificationsItemArray addObject:model];
        }
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithDictionary:@{@"specificationsName":[NSString stringWithFormat:@"测试%d",i*i],@"specificationsItem":specificationsItemArray}];
        [array addObject:dic];
    }
    _spectificationVC.specificationArray = array;
    
    [self.tableView reloadData];
    self.tableView.tableFooterView = [[UIView alloc]init];
}


#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _jumpArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary * dic = _jumpArray[indexPath.row];
    if ([[dic objectForKey:@"controllerName"] isEqualToString:@"MSTestVC"]) {
        cell.imageView.image = [UIImage imageNamed:@"Image"];
    }else{
        cell.imageView.image = nil;
    }
    cell.textLabel.text = [dic objectForKey:@"dispalyName"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = _jumpArray[indexPath.row];
    NSString * vcName = [dic objectForKey:@"controllerName"];
    UIViewController * vc;
    if ([vcName isEqualToString:@"MSStarRateViewDemoVC"]) {
        vc = [[MSStarRateViewDemoVC alloc]init];
    }else if ([vcName isEqualToString:@"ASDepthModalDemoVC"]) {
        vc = [[ASDepthModalDemoVC alloc]init];
    }else if ([vcName isEqualToString:@"MSToolsDemoVC"]){
        vc = [[MSToolsDemoVC alloc]init];
    }else if ([vcName isEqualToString:@"MJNIndexDemoVC"]){
        vc = [[MJNIndexDemoVC alloc]init];
    }else if ([vcName isEqualToString:@"MSTestVC"]){
        MSTestVC *secondVC = [[MSTestVC alloc] initWithNibName:@"MSTestVC" bundle:nil];
        // preload views to the memory
        [secondVC view];
        // setup fromviews array and toviews array
        UITableViewCell * cell = [_tableView cellForRowAtIndexPath:indexPath];
        NSArray *fromViews = [NSArray arrayWithObjects:cell.imageView, nil];
        NSArray *toViews = [NSArray arrayWithObjects:secondVC.imageView, nil];
        
        [self pushViewController:secondVC fromViews:fromViews toViews:toViews duration:1.0];
        return;
    }else if ([vcName isEqualToString:@"MSBarCodeViewController"]){
        vc = [[MSBarCodeViewController alloc]init];
    }else if ([vcName isEqualToString:@"SCRootViewController"]){
        vc = [[SCRootViewController alloc]init];
    }else if ([vcName isEqualToString:@"MSCycelScrollViewVC"]){
        vc = [[MSCycelScrollViewVC alloc]init];
    }else if ([vcName isEqualToString:@"UICollectionViewVC"]){
        
        [ASDepthModalViewController presentView:_spectificationVC.view withBackgroundColor:nil popupAnimationStyle:ASDepthModalAnimationBottomPopue];
        return;
    }
//    CATransition* transition = [CATransition animation];
//    transition.duration = 0.3;
//    transition.type = kCATransitionFade;//可更改为其他方式
//    transition.subtype = kCATransitionReveal;//可更改为其他方式
//    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    [self.navigationController pushViewController:vc animated:YES];

}

@end
