# EveryDayTheOrchard
高仿天天果园，点击水果列表，将列表中的图片，从原位置动画过渡到详情页，从详情页返回到列表页，从banner过渡回到列表。
高仿天天果园，点击水果列表，将列表中的图片，从原位置动画过渡到详情页，从详情页返回到列表页，从banner过渡回到列表。
在Demo中，使用了SDAutolayout工具进行布局，确实方便，实现了类似于天天果园或者淘宝商品详情页的头视图往上滑动产生视觉差，网下滑动图
片放大的效果。
实现转场的动画的核心代码：
//    UIView *tempView = [cell.headerImageView
snapshotViewAfterScreenUpdates:false];
/*刚开始我使用的snapshotViewAfterScreenUpdates方法截取屏幕快照的方式做的，
但是设置了contentMode之后，动画之后会有闪动的情况，
所以使用自定义的UIImageView，实现了平滑过渡*/
UIImageView *tempView = [[UIImageView alloc]
initWithImage:cell.headerImageView.image];
tempView.contentMode = UIViewContentModeScaleAspectFill;
tempView.clipsToBounds = true;
/*
坐标系转换，将tempView的坐标统一转换为containerView的坐标
*/
tempView.frame = [cell.headerImageView
convertRect:cell.headerImageView.frame toView:containerView];

[containerView addSubview:toView];
[containerView addSubview:tempView];
toView.alpha = 0.0;
cell.headerImageView.hidden = true;

UIViewController *toVC = [transitionContext
viewControllerForKey:UITransitionContextToViewControllerKey];
UIView *targetTranistionView = [self targetTransitionView:toVC];
targetTranistionView.hidden = true;
/*
坐标系转换，将tempView的坐标统一转换为containerView的坐标
*/
CGRect targetRect = [targetTranistionView
convertRect:targetTranistionView.bounds toView:containerView];
targetRect.size.height = targetRect.size.height;
[UIView animateWithDuration:[self
transitionDuration:transitionContext] delay:0
usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:0
animations:^{
toView.alpha = 1.0;
[containerView layoutIfNeeded];
tempView.frame = targetRect;
} completion:^(BOOL finished) {
[tempView removeFromSuperview];
targetTranistionView.hidden = NO;
cell.headerImageView.hidden = NO;

[transitionContext completeTransition:![transitionContext
transitionWasCancelled]];
}];
如果有任何意见或建议，可以发送到我邮箱，大家一起探讨jiang677@yeah.net
