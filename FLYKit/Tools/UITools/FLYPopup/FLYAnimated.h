//
//  FLYAnimated.h
//  FLYPopup
//
//  Created by fly on 2022/3/3.
//

#import <Foundation/Foundation.h>
#import "FLYPopup.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLYAnimated : NSObject < UIViewControllerAnimatedTransitioning >

/** YES是show动画，NO是dismiss动画 */
@property (nonatomic, assign) BOOL isShow;

/** 动画类型 */
@property (nonatomic, assign) FLYPopupAnimationType animationType;

/** 自定义show动画block (动画类型设置为自定义时才会执行) (duration：推荐外界使用的动画时间) */
@property (nonatomic, copy) void(^customShowAnimationBlock)(UIView * view);

/** 自定义dissmiss动画block (动画类型设置为自定义时才会执行) (duration：推荐外界使用的动画时间) */
@property (nonatomic, copy) void(^customDissmissAnimationBlock)(UIView * view);

@end

NS_ASSUME_NONNULL_END
