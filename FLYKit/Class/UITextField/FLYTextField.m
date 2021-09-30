//
//  FLYTextField.m
//  FLYKit
//
//  Created by fly on 2021/9/23.
//

#import "FLYTextField.h"

@interface FLYTextField ()

@property (nonatomic, strong) UIView * leftBaseView;
@property (nonatomic, strong) UIView * rightBaseView;

@property (nonatomic, strong) UIImageView * leftImageView;


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
    bounds.size.width = self.leftWidth;
    
    return bounds;
}

-(CGRect)rightViewRectForBounds:(CGRect)bounds
{
    bounds.size.width = self.rightWidth;
    
    return bounds;
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
    self.leftViewMode = UITextFieldViewModeAlways;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    self.leftView = self.leftBaseView;
    self.rightView = self.rightBaseView;
    
    [self.leftBaseView addSubview:self.leftImageView];
    
    [self addSubview:self.lineView];
}



#pragma mark - setters

-(void)setLeftImagFrame:(CGRect)leftImagFrame
{
    _leftImagFrame = leftImagFrame;
    
    self.leftImageView.frame = leftImagFrame;
}

-(void)setLeftImage:(UIImage *)leftImage
{
    _leftImage = leftImage;
    
    self.leftImageView.image = leftImage;
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

-(UIView *)leftBaseView
{
    if ( _leftBaseView == nil )
    {
        _leftBaseView = [[UIView alloc] init];
    }
    return _leftBaseView;
}

- (UIImageView *)leftImageView
{
    if ( _leftImageView == nil )
    {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}

-(UIView *)rightBaseView
{
    if ( _rightBaseView == nil )
    {
        _rightBaseView = [[UIView alloc] init];
    }
    return _rightBaseView;
}

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
