//
//  FruitListTableViewController.m
//  EveryDayTheOrchard
//
//  Created by hejiangshan on 16/4/18.
//  Copyright © 2016年 飞兽科技. All rights reserved.
//

#import "FruitListTableViewController.h"
#import "FruitDetailViewController.h"
#import "HJSMoveTransition.h"
#import "HJSMoveInverseTransition.h"
#import "FruitModel.h"
#import "FruitCell.h"

@interface FruitListTableViewController ()<UINavigationControllerDelegate>

@property(nonatomic,strong)NSMutableArray *datas;

@end

@implementation FruitListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 120;
    self.navigationController.navigationBar.translucent = NO;
    self.datas = [NSMutableArray array];
    [self configData];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)configData
{
    NSArray *fruitNames = @[@"海南网纹瓜口口密",@"新西兰皇家苹果",@"荷兰青皮梨",@"澳大利亚无籽红提",@"墨西哥树莓"];
    NSArray *fruitDescs = @[@"美味无限新",@"甜而不腻",@"香脆，好吃",@"甜，太甜",@"小，但是好吃"];
    NSArray *fruitWeights = @[@"1斤",@"500g",@"612g",@"2斤",@"1斤"];
    NSArray *fruitPrices = @[@"￥78.8",@"￥50",@"￥28",@"￥38",@"￥50"];
    
    for (int i = 1; i < 21; i++) {
        NSInteger index = i%4+1;
        FruitModel *fruitModel = [[FruitModel alloc] init];
        fruitModel.imageName = [NSString stringWithFormat:@"%ld.jpg",index];
        fruitModel.fruitName = fruitNames[index];
        fruitModel.fruitDesc = fruitDescs[index];
        fruitModel.fruitWeight = fruitWeights[index];
        fruitModel.fruitPrice = fruitPrices[index];
        [self.datas addObject:fruitModel];
    }
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    HJSMoveTransition *transition = [[HJSMoveTransition alloc] init];
    
    return transition;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"fruit";
    FruitCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FruitCell" owner:self options:nil].lastObject;
    }
    FruitModel *fruitModel = [self.datas objectAtIndex:indexPath.row];
    [cell fillDataToCell:fruitModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndexPath = indexPath;
    FruitDetailViewController *fruitDetail = [[FruitDetailViewController alloc] init];
    fruitDetail.fruitModel = self.datas[indexPath.row];
    
    [self.navigationController pushViewController:fruitDetail animated:true];
}
@end
