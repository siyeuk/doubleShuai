//
//  ElastTransiton.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/1/26.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "ElastTransiton.h"

@interface ElastTransiton ()

@property (nonatomic,assign) LSSPresentOneTransitionType type;

@end
@implementation ElastTransiton

+ (instancetype)transitionWithTransitionType:(LSSPresentOneTransitionType)type{
    return  [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(LSSPresentOneTransitionType)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case LSSPresentOneTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
        case LSSPresentOneTransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
        default:
            break;
    }
}
///实现present的动画逻辑代码
- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    ////取出两个控制器
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ////snapshotViewAfterScreenUpdates可以对某个视图截图，我们采用对这个截图做动画代替直接对vc1做动画，因为在手势过渡中直接使用vc1动画会和手势有冲突，    如果不需要实现手势的话，就可以不是用截图视图了，大家可以自行尝试一下
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    ///因为已经截图 fromVC可以隐藏
    fromVC.view.hidden = YES;
    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
    UIView *containerView = [transitionContext containerView];
    ///添加视图
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    
    ///设置toVC的frame，因为不是全屏  并且初始时候在底部，不设置的话默认整个屏幕，containerView默认就是整个屏幕
    toVC.view.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, 400);
    ///开始动画,产生弹簧效果
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0/0.55 options:0 animations:^{
        ///tovc向上移动
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
        ///截图变小
        tempView.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
        ///使用如下代码标记整个转场过程是否完成
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        ///转场失败的处理
        if ([transitionContext transitionWasCancelled]) {
            ///失败后fromvc显现出来
            fromVC.view.hidden = NO;
            ///移除截图,因为下次出发present会重新截图
            [tempView removeFromSuperview];
        }
    }];
    
    
}
///实现dismiss的动画逻辑代码
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    ////dismiss的时候from和to发生了转变
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ///参照present动画的逻辑。present之后，containerViewcontroller的最后一个子视图就是截图视图，需要将其取出准备动画
    UIView *tempView = [transitionContext containerView].subviews[0];
    ///律动吧 小伙儿
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
       ///因为present的时候使用的是transform，这里只需要将transform回复就可以个
        fromVC.view.transform = CGAffineTransformIdentity;
        tempView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            ////失败了标记失败
            [transitionContext completeTransition:NO];
        }else{
            ///成功了标记成功，同时显现之前的视图。并且移除截图视图
            [transitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            [tempView removeFromSuperview];
        }
    }];
    
    
}










@end
