//
//  FLYTextField.h
//  FLYKit
//
//  Created by fly on 2021/9/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLYTextField : UITextField


#pragma mark - leftView & rightView

/// 左边的图片
@property (nonatomic, strong) UIImage * leftImage;

/// 左边图片的frame
@property (nonatomic) CGRect leftImagFrame;

/// 光标距离左边的宽度 (默认0，设置左边图片后必须设置这个属性，不然光标会被图片挡住)
@property (nonatomic, assign) CGFloat leftWidth;

/// 右侧不能输入的宽度 (默认0，如果往TextField上添加东西，比如发送验证码的按钮，如果输入的太多，就会被按钮挡住，设置了这个属性就不会被挡住了)
@property (nonatomic, assign) CGFloat rightWidth;



#pragma mark - 线

/// 是否显示线 (默认NO)
@property (nonatomic, assign) BOOL showLine;

/// 线颜色 (默认黑色)
@property (nonatomic, strong) UIColor * lineColor;

/// 线高度 (默认1)
@property (nonatomic, assign) CGFloat lineHeight;

/// 线的左边距 (默认0)
@property (nonatomic, assign) CGFloat lineLeftMargin;

/// 线的右边距 (默认0)
@property (nonatomic, assign) CGFloat lineRightMargin;


@end

NS_ASSUME_NONNULL_END
