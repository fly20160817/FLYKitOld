//
//  UIImage+FLYExtension.m
//  FLYKit
//
//  Created by fly on 2021/8/27.
//

#import "UIImage+FLYExtension.h"

@implementation UIImage (FLYExtension)

/** 返回一个渲染模式为原始模式的image */
- (UIImage *)imageWithRenderingOriginal;
{
    //返回一个渲染模式为不渲染的图片
    UIImage * image = [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return image;
}


/// 拉伸image
/// @param capInsets 设置拉伸的范围
- (UIImage *)resizableImageStretchWithCapInsets:(UIEdgeInsets)capInsets
{
    UIImage * image = [self resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    
    return image;
}


@end
