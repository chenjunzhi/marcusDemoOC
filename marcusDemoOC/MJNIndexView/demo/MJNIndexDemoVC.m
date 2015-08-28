//
//  MJNIndexDemoVC.m
//  marcusDemoOC
//
//  Created by marcus on 15/8/11.
//  Copyright (c) 2015年 marcus. All rights reserved.
//

#define kHight ([[UIScreen mainScreen] bounds].size.height)
#define kWidth ([[UIScreen mainScreen] bounds].size.width)
#import "MJNIndexDemoVC.h"
#import "MJNIndexView.h"

@interface MJNIndexDemoVC ()<UITableViewDelegate,UITableViewDataSource,MJNIndexViewDataSource>
// MJNIndexView
@property (nonatomic, strong) MJNIndexView *indexView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString * alphaString;
@property (strong, nonatomic) NSMutableArray * array; //字典 数组
@end

@implementation MJNIndexDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeBottom;
    
    [self initData];
    
    CGRect rect = CGRectMake(0, 70, kWidth, kHight-70);
    self.indexView = [[MJNIndexView alloc]initWithFrame:rect];
    self.indexView.dataSource = self;
    
    self.indexView.font = [UIFont systemFontOfSize:13                                                                                                                              ];
    self.indexView.selectedItemFont = [UIFont systemFontOfSize:35];
    self.indexView.fontColor = [UIColor grayColor];
    [self.view addSubview:self.indexView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData{
    _array = [[NSMutableArray alloc]init];
    for (int i = 0 ; i<=20; i++) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        NSMutableArray * array1 = [[NSMutableArray alloc]init];
        if (!_alphaString) {
            _alphaString = @"0";
        }else{
           _alphaString = [NSString stringWithFormat:@"%@-%d",_alphaString,i];
        }
        [dic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"name"];
        for (int j = 0; j<=i; j++) {
            [array1 addObject:[NSString stringWithFormat:@"%d_%d",i,j]];
        }
        [dic setObject:array1 forKey:@"array"];
        [_array addObject:dic];
    }
    [self.tableView reloadData];
}

#pragma mark MJNIndexView Delegate

- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView{
    NSArray *alphaArray = [self.alphaString componentsSeparatedByString:@"-"];
    NSMutableArray *results = [NSMutableArray array];
    for (NSString * subStr in alphaArray) {
        [results addObject:subStr];
    }
    return results;
}

- (void)sectionForSectionMJNIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index] atScrollPosition: UITableViewScrollPositionTop animated:YES];
}

#pragma mark tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _array.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString * title;
    NSMutableDictionary *dic = _array[section];
    title = [dic objectForKey:@"name"];
    return title;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableDictionary *dic = _array[section];
    NSMutableArray * array1 = [dic objectForKey:@"array"];
    return array1.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSMutableDictionary *dic = _array[indexPath.section];
    NSMutableArray * array1 = [dic objectForKey:@"array"];
    cell.textLabel.text = array1[indexPath.row];
    return cell;
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
