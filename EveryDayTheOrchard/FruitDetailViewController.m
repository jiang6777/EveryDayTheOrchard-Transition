//
//  FruitDetailViewController.m
//  EveryDayTheOrchard
//
//  Created by hejiangshan on 16/4/19.
//  Copyright © 2016年 飞兽科技. All rights reserved.
//

#import "FruitDetailViewController.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"
#import "HJSMoveInverseTransition.h"

#define SPANISH_WHITE [UIColor colorWithRed:0.996 green:0.992 blue:0.941 alpha:1] /*#fefdf0*/

static const CGFloat kScroll_Height = 300;

#define kScrollWidth [UIScreen mainScreen].bounds.size.width
#define kScrollHeight [UIScreen mainScreen].bounds.size.height


@interface FruitDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation FruitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));

//    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:[UIImage imageNamed:self.fruitModel.imageName] forSize:CGSizeMake(kScrollWidth, kScroll_Height)];
    self.headerView = [ParallaxHeaderView parallaxHeaderViewWithImages:@[_fruitModel.imageName,@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"] forSize:CGSizeMake(kScrollWidth, kScroll_Height)];
    self.headerView.headerTitleLabel.text = @"";
    self.currentShowView = self.headerView.imageView;
    [self.tableView setTableHeaderView:self.headerView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [(ParallaxHeaderView *)self.tableView.tableHeaderView refreshBlurViewForNewImage];
    [super viewDidAppear:animated];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource  = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView)
    {
        // pass the current offset of the UITableView so that the ParallaxHeaderView layouts the subViews.
        ParallaxHeaderView *headerView = (ParallaxHeaderView *)self.tableView.tableHeaderView;
        [headerView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark <UINavigationControllerDelegate>
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    HJSMoveInverseTransition *inverseTransition = [[HJSMoveInverseTransition alloc]init];
    return inverseTransition;
}

#pragma mark - Table view data source
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Row %ld", (long)indexPath.row];
    cell.backgroundColor = SPANISH_WHITE;
    
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
