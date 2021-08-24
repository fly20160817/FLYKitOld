//
//  UIButton+FLYExtension.m
//  FLYKit
//
//  Created by fly on 2021/8/13.
//

#import "UIButton+FLYExtension.h"

@implementation UIButton (FLYExtension)

/** 快速创建(文字) */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font;
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}

/** 快速创建(文字 + 图片) */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor image:(UIImage *)image font:(UIFont *)font
{
    UIButton * button = [UIButton buttonWithTitle:title titleColor:titleColor font:font];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

@end
