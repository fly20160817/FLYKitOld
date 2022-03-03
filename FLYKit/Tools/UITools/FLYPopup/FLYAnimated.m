//
//  FLYAnimated.m
//  FLYPopup
//
//  Created by fly on 2022/3/3.
//

#import "FLYAnimated.h"

@implementation FLYAnimated



#pragma mark - UIViewControllerAnimatedTransitioning

// 展示和消失动画的时长
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //在执行动画的时候，我们调用这个方法获取时长，就可以做到统一管理动画时长
    return k_Duration;
}

//专门用于管理model如何展示和消失
//只有实现了这个代理，就不会在有默认动画了，包括需要展示的视图也需要我们自己添加到容器视图上
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //判断当前是展示还是消失
    if( self.isShow )
    {
        [self showPresentController:transitionContext];
    }
    else
    {
        [self dismissPresentController:transitionContext];
    }
}



#pragma mark - private methods

- (void)showPresentController:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //1.获取需要弹出的视图
    
    //UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //通过ToViewKey取出的就是toVC的view
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    
    //2.将需要弹出的视图添加到containerView上
    [transitionContext.containerView addSubview:toView];
    
    
    //3.执行动画
    [self showAnimation:transitionContext view:toView];
    
    
    //动画时间 k_Duration 结束后，告诉系统动画执行完毕
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(k_Duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //自定义转场动画执行完之后，一定要告诉系统动画执行完毕。
        [transitionContext completeTransition:YES];
    });
    
}

- (void)showAnimation:(id<UIViewControllerContextTransitioning>)transitionContext view:(UIView *)view
{
    switch (self.animationType)
    {
        case FLYPopupAnimationTypeTop:
        {
            //宽度不变，高度设置成0 （锚点的默认值是(0.5, 0.5)，以锚点为中心来变化的）
            view.transform= CGAffineTransformMakeScale(1.0, 0.0);
            //设置锚点
            view.layer.anchorPoint = CGPointMake(0.5, 0.0);
            
            //获取动画时间
            NSTimeInterval duration = [self transitionDuration:transitionContext];
            
            [UIView animateWithDuration:duration animations:^{
                //还原
                view.transform = CGAffineTransformIdentity;
            }];
        }
            break;
            
        case FLYPopupAnimationTypeBottom:
        {
            view.transform= CGAffineTransformMakeScale(1.0, 0.0);
            view.layer.anchorPoint = CGPointMake(0.5, 1);
            
            NSTimeInterval duration = [self transitionDuration:transitionContext];
            [UIView animateWithDuration:duration animations:^{
                view.transform = CGAffineTransformIdentity;
            }];
        }
            break;
            
        case FLYPopupAnimationTypeLeft:
        {
            view.transform= CGAffineTransformMakeScale(0, 1);
            view.layer.anchorPoint = CGPointMake(0, 0.5);
            
            NSTimeInterval duration = [self transitionDuration:transitionContext];
            [UIView animateWithDuration:duration animations:^{
                view.transform = CGAffineTransformIdentity;
            }];
        }
            break;
            
        case FLYPopupAnimationTypeRight:
        {
            view.transform= CGAffineTransformMakeScale(0, 1);
            view.layer.anchorPoint = CGPointMake(1, 0.5);
            
            NSTimeInterval duration = [self transitionDuration:transitionContext];
            [UIView animateWithDuration:duration animations:^{
                view.transform = CGAffineTransformIdentity;
            }];
        }
            break;
            
        case FLYPopupAnimationTypeMiddle:
        {
            view.transform= CGAffineTransformMakeScale(0, 0);
            view.layer.anchorPoint = CGPointMake(0.5, 0.5);
            
            NSTimeInterval duration = [self transitionDuration:transitionContext];
            [UIView animateWithDuration:duration animations:^{
                view.transform = CGAffineTransformIdentity;
            }];
        }
            break;
            
        case FLYPopupAnimationTypeCustom:
        {
            !self.customShowAnimationBlock ?: self.customShowAnimationBlock(view);
        }
            break;
            
        default:
            break;
    }
}

- (void)dismissPresentController:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //1.拿到需要消失的视图
    
    //UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    
    //2.执行动画让视图消失
    [self dismissAnimation:transitionContext view:fromView];
    
    
    //动画时间 k_Duration 结束后，告诉系统动画执行完毕
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(k_Duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //3.将需要弹出的视图移除 (外界可能会更换显示的view)
        [transitionContext.containerView addSubview:fromView];
        
        //自定义转场动画执行完之后，一定要告诉系统动画执行完毕。
        [transitionContext completeTransition:YES];
    });
 
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext view:(UIView *)view
{
    switch (self.animationType)
    {
        case FLYPopupAnimationTypeTop:
        case FLYPopupAnimationTypeBottom:
        {
            //获取动画时间
            NSTimeInterval duration = [self transitionDuration:transitionContext];
            
            [UIView animateWithDuration:duration animations:^{
                
                //宽度不变，高度设置为0 (高度设置不能为0，不然会没有动画突然消失，设置一个很小的值就可以了)
                view.transform= CGAffineTransformMakeScale(1.0, 0.0001);
                
            }];
        }
            break;
            
        case FLYPopupAnimationTypeLeft:
        case FLYPopupAnimationTypeRight:
        {
            NSTimeInterval duration = [self transitionDuration:transitionContext];
            [UIView animateWithDuration:duration animations:^{
                view.transform= CGAffineTransformMakeScale(0.0001, 1.0);
            }];
        }
            break;
            
        case FLYPopupAnimationTypeMiddle:
        {
            NSTimeInterval duration = [self transitionDuration:transitionContext];
            [UIView animateWithDuration:duration animations:^{
                view.transform= CGAffineTransformMakeScale(0.0001, 0.0001);
            }];
        }
            break;
            
        case FLYPopupAnimationTypeCustom:
        {
            !self.customDissmissAnimationBlock ?: self.customDissmissAnimationBlock(view);
        }
            break;
            
        default:
            break;
    }
}

@end
