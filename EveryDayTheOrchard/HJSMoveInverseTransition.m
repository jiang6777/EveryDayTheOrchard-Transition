//
//  HJSMoveInverseTransition.m
//  EveryDayTheOrchard
//
//  Created by hejiangshan on 16/4/19.
//  Copyright © 2016年 飞兽科技. All rights reserved.
//

#import "HJSMoveInverseTransition.h"
#import "FruitDetailViewController.h"
#import "FruitListTableViewController.h"
#import "FruitCell.h"

@implementation HJSMoveInverseTransition

- (CGFloat)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    FruitDetailViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    FruitListTableViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    FruitCell *cell = (FruitCell *)[toVC.tableView cellForRowAtIndexPath:toVC.currentIndexPath];
    UIView *targetTranistionView = [self targetTransitionView:fromVC];
    UIView *fromView = [self fromView:transitionContext];
    
    UIImageView *tempView = [[UIImageView alloc] initWithImage:cell.headerImageView.image];
    tempView.contentMode = UIViewContentModeScaleAspectFill;
    tempView.frame = [targetTranistionView convertRect:targetTranistionView.bounds toView:containerView];
    tempView.layer.cornerRadius = 5;
    tempView.layer.masksToBounds = true;

    targetTranistionView.hidden = true;
    cell.headerImageView.hidden = true;
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:tempView];
    
    CGRect originalRect = [cell.headerImageView convertRect:cell.headerImageView.bounds toView:containerView];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:0 animations:^{
        [containerView layoutIfNeeded];
        tempView.frame = originalRect;
        fromView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [tempView removeFromSuperview];
        targetTranistionView.hidden = false;
        cell.headerImageView.hidden = false;
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
    return fruitDetial.headerView.currentShowImageView;
}

@end
