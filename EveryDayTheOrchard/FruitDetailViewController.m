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

@property(nonatomic,strong)UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation FruitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    //    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:[UIImage imageNamed:self.fruitModel.imageName] forSize:CGSizeMake(kScrollWidth, kScroll_Height)];
    self.headerView = [ParallaxHeaderView parallaxHeaderViewWithImages:@[_fruitModel.imageName,@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg"] forSize:CGSizeMake(kScrollWidth, kScroll_Height)];
    self.headerView.headerTitleLabel.text = @"";
    self.currentShowView = self.headerView.imageView;
    [self.tableView setTableHeaderView:self.headerView];
    
    UIScreenEdgePanGestureRecognizer *screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    screenEdgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:screenEdgePan];
}

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    //计算手指滑的物理距离（滑了多远，与起始位置无关）
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));//把这个百分比限制在0~1之间
    
    NSLog(@"%f",progress);
    
    //当手势刚刚开始，我们创建一个 UIPercentDrivenInteractiveTransition 对象
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        //当手慢慢划入时，我们把总体手势划入的进度告诉 UIPercentDrivenInteractiveTransition 对象。
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    }else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded){
        //当手势结束，我们根据用户的手势进度来判断过渡是应该完成还是取消并相应的调用 finishInteractiveTransition 或者 cancelInteractiveTransition 方法.
        self.percentDrivenTransition.completionSpeed = progress;
        if (progress > 0.2) {
            [self.percentDrivenTransition finishInteractiveTransition];
        }else{
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        self.percentDrivenTransition = nil;
    }
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

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if ([animationController isKindOfClass:[HJSMoveInverseTransition class]]) {
        return self.percentDrivenTransition;
    }else{
        return nil;
    }
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
