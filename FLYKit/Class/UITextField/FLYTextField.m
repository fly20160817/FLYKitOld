//
//  FLYTextField.m
//  FLYKit
//
//  Created by fly on 2021/9/23.
//

#import "FLYTextField.h"

@interface FLYTextField ()

@property (nonatomic, strong) UIView * lineView;

@end

@implementation FLYTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

-(CGRect)leftViewRectForBounds:(CGRect)bounds
{
    return self.leftViewRect;
}

-(CGRect)rightViewRectForBounds:(CGRect)bounds
{
    CGFloat x = bounds.size.width - self.rightViewRect.size.width - self.rightViewRect.origin.x;
    
    CGRect rect = CGRectMake(x, self.rightViewRect.origin.y, self.rightViewRect.size.width, self.rightViewRect.size.height);
        
    return rect;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = CGRectMake(self.textLeftMargin, 0, bounds.size.width - self.textLeftMargin - self.textRightMargin, bounds.size.height);
    
    return rect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect rect = CGRectMake(self.textLeftMargin, 0, bounds.size.width - self.textLeftMargin - self.textRightMargin, bounds.size.height);
    
    return rect;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height = self.lineHeight > 0 ? self.lineHeight : 1;
    self.lineView.frame = CGRectMake(self.lineLeftMargin, self.height - height, self.width - self.lineLeftMargin - self.lineRightMargin, height);    
}



#pragma mark - UI

- (void)initUI
{
    //关闭首字母大写
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //关闭自动纠错
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    self.leftViewMode = UITextFieldViewModeAlways;
    self.rightViewMode = UITextFieldViewModeAlways;
    

    [self addSubview:self.lineView];
}



#pragma mark - setters

-(void)setLeftImage:(UIImage *)leftImage
{
    _leftImage = leftImage;
    
    UIImageView * leftImageView = [[UIImageView alloc] initWithImage:leftImage];
    leftImageView.backgroundColor = [UIColor redColor];
    self.leftView = leftImageView;
}

-(void)setRightImage:(UIImage *)rightImage
{
    _rightImage = rightImage;
    
    UIImageView * rightImageView = [[UIImageView alloc] initWithImage:rightImage];
    rightImageView.backgroundColor = [UIColor orangeColor];
    self.rightView = rightImageView;
}

-(void)setShowLine:(BOOL)showLine
{
    _showLine = showLine;
    
    self.lineView.hidden = !showLine;
}

-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    
    self.lineView.backgroundColor = lineColor;
}

-(void)setLineHeight:(CGFloat)lineHeight
{
    _lineHeight = lineHeight;
    
    [self setNeedsLayout];
}

-(void)setLineLeftMargin:(CGFloat)lineLeftMargin
{
    _lineLeftMargin = lineLeftMargin;
    
    [self setNeedsLayout];
}

-(void)setLineRightMargin:(CGFloat)lineRightMargin
{
    _lineRightMargin = lineRightMargin;
    
    [self setNeedsLayout];
}



#pragma mark - getters

-(UIView *)lineView
{
    if ( _lineView == nil )
    {
        _lineView = [[UIView alloc] init];
        _lineView.hidden = YES;
        _lineView.backgroundColor = [UIColor blackColor];
    }
    return _lineView;
}

@end
