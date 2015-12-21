//
//  THSpecificationVC.m
//  Tuhu
//
//  Created by marcus on 15/12/1.
//  Copyright © 2015年 marcus. All rights reserved.
//

#import "THSpecificationVC.h"
#import "THSpecificationCell.h"
#import "THSpecificationModel.h"
#import "MSTools.h"
#import "THSpecificationHeaderView.h"
#import "THSpecificationFooterView.h"
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height


@interface THSpecificationVC ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintConfirmWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintAddCartWidth;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *selectSpecificationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;


@end

@implementation THSpecificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBottomButtonWidth];
    [self initView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView{
    [_image.layer setCornerRadius:5];
    [_image.layer setMasksToBounds:YES];

    UINib *cellNib = [UINib nibWithNibName:@"THSpecificationCell" bundle:[NSBundle mainBundle]];
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:@"THSpecificationCell"];
    UINib *headerNib = [UINib nibWithNibName:@"THSpecificationHeaderView" bundle:[NSBundle mainBundle]];
    [_collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"THSpecificationHeaderView"];
    UINib *footerNib = [UINib nibWithNibName:@"THSpecificationFooterView" bundle:[NSBundle mainBundle]];
    [_collectionView registerNib:footerNib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"THSpecificationFooterView"];
}

//根据 specificationType 显示底部的按钮
- (void)setBottomButtonWidth{
    if (_specificationType == THSpecificationTypeDefault) {
        _constraintConfirmWidth.constant = 0;
        _constraintAddCartWidth.constant = ScreenWidth/2.0;
    }else{
        _constraintConfirmWidth.constant = ScreenWidth;
        _constraintAddCartWidth.constant = 0;
    }
}

//根据indexPath 取对应的Model
-(THSpecificationModel*)modelWithIndexPath:(NSIndexPath*)indexPath{
    if (indexPath.section < _specificationArray.count) {
        NSMutableDictionary * dic = _specificationArray[indexPath.section];
        NSMutableArray  *specificationsItemArray = [dic objectForKey:@"specificationsItem"];
        if (indexPath.row < specificationsItemArray.count) {
            THSpecificationModel * model = specificationsItemArray[indexPath.row];
            return model;
        }
    }
    return nil;
}

#pragma mark collectionView Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _specificationArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section < _specificationArray.count) {
        NSMutableDictionary * dic = _specificationArray[section];
        NSMutableArray * array = [dic objectForKey:@"specificationsItem"];
        return array.count;
    }else
        return 0;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"THSpecificationCell";
    THSpecificationCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    THSpecificationModel * model = [self modelWithIndexPath:indexPath];
    if (model) {
        [cell.button setTitle:model.specificationsValue forState:UIControlStateNormal];
        [cell.button setNormalColor:model.bSelected?[UIColor redColor]:[UIColor grayColor]];
        [cell.button setTitleColor:model.bSelected?[UIColor whiteColor]:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return cell;
}

//当选中某个规格时
- (void)selectSpecificationWithModel:(THSpecificationModel*)model AndIndexPath:(NSIndexPath*)indexPath{
    if (indexPath.section < _specificationArray.count) {
        NSMutableDictionary * dic = _specificationArray[indexPath.section];
        NSMutableArray * array = [dic objectForKey:@"specificationsItem"];
        for (int i = 0; i<array.count; i++) {
            THSpecificationModel *tempModel = array[i];
            //将当前点击的item 和 相同section里其他选中的item反选
            if (i == indexPath.row || tempModel.bSelected) {
                tempModel.bSelected = !tempModel.bSelected;
                NSIndexPath *tempIndexPath = [NSIndexPath indexPathForItem:i inSection:indexPath.section];
                THSpecificationCell * tempCell = (THSpecificationCell*)[_collectionView cellForItemAtIndexPath:tempIndexPath];
                if (tempCell) {
                    [tempCell.button setNormalColor:tempModel.bSelected?[UIColor redColor]:[UIColor grayColor]];
                    [tempCell.button setTitleColor:tempModel.bSelected?[UIColor whiteColor]:[UIColor blackColor] forState:UIControlStateNormal];
                }
            }
        }
    }
}

//刷新已选内容Label
- (void)refreshSelectSpecificationLabel{
    _selectSpecificationLabel.text = @"";
    for (NSDictionary * dic in _specificationArray) {
        NSMutableArray * array = [dic objectForKey:@"specificationsItem"];
        for (THSpecificationModel * model in array) {
            if (model.bSelected) {
                _selectSpecificationLabel.text = [_selectSpecificationLabel.text stringByAppendingString:[NSString stringWithFormat:@"“%@” ",model.specificationsValue]];
            }
        }
    }
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    THSpecificationModel * model = [self modelWithIndexPath:indexPath];
    if (model) {
        CGFloat width = [MSTools iStringLength:model.specificationsValue font:[UIFont systemFontOfSize:14]] + 10;
        width = MIN(width, ScreenWidth-30);
        return CGSizeMake(width, 28);
    }
    return CGSizeMake(0, 28);
}

//////定义每个Section 的 margin  //定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 15, 10, 15);//分别为上、左、下、右
}

//每个section中不同的行之间的行间距  //定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
   return 10;
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth-30, 1);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth-30, 40);
}

// collectionView header
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        THSpecificationHeaderView * headerView = (THSpecificationHeaderView*)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                                  withReuseIdentifier:@"THSpecificationHeaderView"
                                                                                                         forIndexPath:indexPath];
        NSDictionary * dic = _specificationArray[indexPath.section];
        headerView.titleLabel.text = [dic objectForKey:@"specificationsName"];
        return headerView;
    }else{
        THSpecificationFooterView * footerView = (THSpecificationFooterView*)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                                  withReuseIdentifier:@"THSpecificationFooterView"
                                                                                                    forIndexPath:indexPath];
        return footerView;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    THSpecificationModel * model = [self modelWithIndexPath:indexPath];
    if (!model.bSelected) {  //当前item没有选中时，才需要刷新数据
        [self selectSpecificationWithModel:model AndIndexPath:indexPath];
        [self refreshSelectSpecificationLabel];
    }
}



@end
