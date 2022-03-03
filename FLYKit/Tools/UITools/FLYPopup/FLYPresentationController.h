//
//  FLYPresentationController.h
//  FLYKit
//
//  Created by fly on 2022/3/1.
//

#import <UIKit/UIKit.h>
#import "FLYPopup.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLYPresentationController : UIPresentationController

/** 弹出view的frame */
@property (nonatomic, assign) CGRect presentFrame;

/** 是否允许点击背景后消失 (默认YES) */
@property (nonatomic, assign) BOOL interactionEnabled;

/** 遮罩的类型 */
@property (nonatomic, assign) FLYPopupMaskType maskType;

@end

NS_ASSUME_NONNULL_END
