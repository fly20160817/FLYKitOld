//
//  FLYPresentationController.m
//  FLYKit
//
//  Created by fly on 2022/3/1.
//

#import "FLYPresentationController.h"
#import "FLYPopup.h"

@interface FLYPresentationController ()

//铺满整个背景的按钮，点击按钮执行dissmiss
@property (nonatomic, strong) UIButton * coverButton;

@end

@implementation FLYPresentationController

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    
    if ( self )
    {
        
    }
    
    return self;
}

//用于布局转场动画弹出的控件
-(void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    
    //容器view
    //self.containerView
    
    //弹出的view
    //self.presentedView
        
        
    //设置弹出视图的大小
    self.presentedView.frame = self.presentFrame;
    
    //添加蒙版 (插入到最底层)
    [self.containerView insertSubview:self.coverButton atIndex:0];
    self.coverButton.frame = self.containerView.bounds;
}

- (void)presentationTransitionWillBegin
{
    [super presentationTransitionWillBegin];
    
    
    self.coverButton.alpha = 0;
    
    [UIView animateWithDuration:k_Duration animations:^{
        
        self.coverButton.alpha = 1;
        
    }];
}

- (void)dismissalTransitionWillBegin
{
    [super dismissalTransitionWillBegin];
    
    
    [UIView animateWithDuration:k_Duration animations:^{
        
        self.coverButton.alpha = 0;
        
    }];
}



#pragma mark - event handler

- (void)coverClick:(UIButton *)button
{
    if ( self.interactionEnabled == NO )
    {
        return;
    }
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark -setters and getters

-(void)setMaskType:(FLYPopupMaskType)maskType
{
    _maskType = maskType;
    
    if ( maskType == FLYPopupMaskTypeBlack )
    {
        self.coverButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    else if ( maskType == FLYPopupMaskTypeClear )
    {
        self.coverButton.backgroundColor = [UIColor clearColor];
    }
}

-(UIButton *)coverButton
{
    if ( _coverButton == nil )
    {
        _coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_coverButton addTarget:self action:@selector(coverClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _coverButton;
}

@end
