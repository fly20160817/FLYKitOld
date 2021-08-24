//
//  UIButton+FLYExtension.h
//  FLYKit
//
//  Created by fly on 2021/8/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (FLYExtension)

/** 快速创建(文字) */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font;

/** 快速创建(文字 + 图片) */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor image:(UIImage *)image font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
