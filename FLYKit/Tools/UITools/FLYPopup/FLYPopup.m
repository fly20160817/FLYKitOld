//
//  FLYPopup.m
//  FLYPopup
//
//  Created by fly on 2022/3/2.
//

#import "FLYPopup.h"
#import "FLYPresentationController.h"
#import "FLYAnimated.h"
#import "FLYTools.h"

NSNotificationName const FLYPopupWillShowNotification = @"FLYPopupWillShowNotification";
NSNotificationName const FLYPopupWillDismissNotification = @"FLYPopupWillDismissNotification";

@interface FLYPopup () < UIViewControllerTransitioningDelegate >

@property (nonatomic, strong) FLYAnimated * animated;

@end

@implementation FLYPopup

/// 创建popupView
/// @param view 需要显示的view
+ (instancetype)popupView:(UIView *)view
{
    return [self popupView:view animationType:FLYPopupAnimationTypeNone maskType:FLYPopupMaskTypeBlack];
}

/// 创建popupView
/// @param view 需要显示的view
/// @param animationType 动画类型
/// @param maskType 遮罩类型
+ (instancetype)popupView:(UIView *)view animationType:(FLYPopupAnimationType)animationType maskType:(FLYPopupMaskType)maskType
{
    FLYPopup * popup = [[self alloc] init];
    popup.popupView = view;
    popup.animationType = animationType;
    popup.maskType = maskType;
    return popup;
}

/// 创建popupViewController
/// @param viewController 需要显示的viewController
+ (instancetype)popupViewController:(UIViewController *)viewController
{
    return [self popupViewController:viewController animationType:FLYPopupAnimationTypeNone maskType:FLYPopupMaskTypeBlack];
}

/// 创建popupViewController
/// @param viewController 需要显示的viewController
/// @param animationType 动画类型
/// @param maskType 遮罩类型
+ (instancetype)popupViewController:(UIViewController *)viewController animationType:(FLYPopupAnimationType)animationType maskType:(FLYPopupMaskType)maskType
{
    FLYPopup * popup = [[self alloc] init];
    popup.popupViewController = viewController;
    popup.animationType = animationType;
    popup.maskType = maskType;
    return popup;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.animationType = FLYPopupAnimationTypeNone;
        self.maskType = FLYPopupMaskTypeBlack;
        self.interactionEnabled = YES;
    }
    return self;
}



#pragma mark - UIViewControllerTransitioningDelegate

//该方法用于返回一个负责展示的Controller
-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    FLYPresentationController * pc = [[FLYPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    pc.presentFrame = self.popupFrame;
    pc.maskType = self.maskType;
    pc.interactionEnabled = self.interactionEnabled;

    return pc;
}

//用于返回一个负责转场如何出现的对象 (遵守UIViewControllerAnimatedTransitioning协议的对象就行)
//可以在该对象中控制弹出视图的尺寸等
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:FLYPopupWillShowNotification object:nil];
    
    self.animated.isShow = YES;
    
    return self.animated;
}

//用于返回一个负责转场如何消失的对象
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:FLYPopupWillDismissNotification object:nil];
    
    self.animated.isShow = NO;
    
    return self.animated;
}



#pragma mark - public methods

- (void)show
{
    [[FLYTools currentViewController] presentViewController:self.popupViewController animated:YES completion:nil];
}

- (void)dissmiss
{
    [[FLYTools currentViewController] dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - setters and getters

-(void)setPopupView:(UIView *)popupView
{
    _popupView = popupView;
    
    self.popupViewController = [[UIViewController alloc] init];
    self.popupViewController.view = popupView;
}

-(void)setPopupViewController:(UIViewController *)popupViewController
{
    _popupViewController = popupViewController;

    // 设置转场代理
    popupViewController.transitioningDelegate = self;
    // 设置转场动画样式
    popupViewController.modalPresentationStyle = UIModalPresentationCustom;
}

-(FLYAnimated *)animated
{
    if ( _animated == nil )
    {
        _animated = [[FLYAnimated alloc] init];
        _animated.animationType = self.animationType;
        _animated.customShowAnimationBlock = self.customShowAnimationBlock;
        _animated.customDissmissAnimationBlock = self.customDissmissAnimationBlock;
    }
    return _animated;
}


@end
