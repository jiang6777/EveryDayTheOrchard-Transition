//
//  HJSMoveTransition.m
//  EveryDayTheOrchard
//
//  Created by hejiangshan on 16/4/18.
//  Copyright © 2016年 飞兽科技. All rights reserved.
//

#import "HJSMoveTransition.h"
#import "FruitDetailViewController.h"
#import "FruitListTableViewController.h"
#import "FruitCell.h"

@implementation HJSMoveTransition

- (CGFloat)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [self toView:transitionContext];
    FruitListTableViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    FruitCell *cell = (FruitCell *)[fromVC.tableView cellForRowAtIndexPath:fromVC.currentIndexPath];
    
    
//    UIView *tempView = [cell.headerImageView snapshotViewAfterScreenUpdates:false];
    /*刚开始我使用的snapshotViewAfterScreenUpdates方法截取屏幕快照的方式做的，
     但是设置了contentMode之后，动画之后会有闪动的情况，
     所以使用自定义的UIImageView，实现了平滑过渡*/
    UIImageView *tempView = [[UIImageView alloc] initWithImage:cell.headerImageView.image];
    tempView.contentMode = UIViewContentModeScaleAspectFill;
    tempView.clipsToBounds = true;
    /*
     坐标系转换，将tempView的坐标统一转换为containerView的坐标
     */
    tempView.frame = [cell.headerImageView convertRect:cell.headerImageView.frame toView:containerView];
    
    [containerView addSubview:toView];
    [containerView addSubview:tempView];
    toView.alpha = 0.0;
    cell.headerImageView.hidden = true;
    
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *targetTranistionView = [self targetTransitionView:toVC];
    targetTranistionView.hidden = true;
    /*
     坐标系转换，将tempView的坐标统一转换为containerView的坐标
     */
    CGRect targetRect = [targetTranistionView convertRect:targetTranistionView.bounds toView:containerView];
    targetRect.size.height = targetRect.size.height;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:0 animations:^{
        toView.alpha = 1.0;
        [containerView layoutIfNeeded];
        tempView.frame = targetRect;
    } completion:^(BOOL finished) {
        [tempView removeFromSuperview];
        targetTranistionView.hidden = NO;
        cell.headerImageView.hidden = NO;
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];

}

- (UIView *)toView:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *toView = nil;
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        toView = toVC.view;
    }
    toView.frame = [transitionContext finalFrameForViewController:toVC];
    return toView;
}

- (UIView *)fromView:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = nil;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    } else {
        fromView = fromVC.view;
    }
    return fromView;
}

- (UIView *)targetTransitionView:(UIViewController *)VC
{
    FruitDetailViewController *fruitDetial = (FruitDetailViewController *)VC;
    return fruitDetial.currentShowView;
}

@end
