//
//  CJLabelScroll.m
//  LetsFit
//
//  Created by Camus on 19/08/13.
//  Copyright (c) 2013 SumacApps. All rights reserved.
//

#import "CJLabelScroll.h"

@implementation CJLabelScroll

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        self.animationDuration = 0.3;
        self.fadeLength = 20;
    }
    return self;
}

-(void)setLabel:(UILabel *)label
{
    _label = label;
    self.scrollView.contentSize = CGSizeMake(_label.frame.size.width, self.frame.size.height);
    [self.scrollView addSubview:_label];
    
    if (self.scrollView.contentSize.width > self.frame.size.width)
    {
        [self applyRightGradientMaskForFadeLength:self.fadeLength enableFade:YES];
    }
    else
    {
        [self applyBothGradientMaskForFadeLength:0 enableFade:YES];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self applyLeftGradientMaskForFadeLength:self.fadeLength enableFade:YES];
}

/*-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if ((*targetContentOffset).x == 0)
    {
        //[self animateOutLeftGradient:20];
        //[self performSelector:@selector(showRightGradient) withObject:nil afterDelay:0.5];
    }
    
    else if ((*targetContentOffset).x == (scrollView.contentSize.width-self.frame.size.width))
    {
        [self applyLeftGradientMaskForFadeLength:20 enableFade:YES];
    }
    else
    {
        [self applyBothGradientMaskForFadeLength:20 enableFade:YES];
    }
}*/

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 0)
    {
        [self animateOutLeftGradient:self.fadeLength];
        [self performSelector:@selector(showRightGradient) withObject:nil afterDelay:self.animationDuration];
    }
    else if (scrollView.contentOffset.x == (scrollView.contentSize.width-self.frame.size.width))
    {
        [self animateOutRightGradient:self.fadeLength];
        [self performSelector:@selector(showLeftGradient) withObject:nil afterDelay:self.animationDuration];
    }
    else
    {
        [self applyBothGradientMaskForFadeLength:20 enableFade:YES];
    }
}

#pragma animation helper methods

-(void)showRightGradient
{
    [self applyRightGradientMaskForFadeLength:2*self.fadeLength enableFade:YES];
}

-(void)showLeftGradient
{
    [self applyLeftGradientMaskForFadeLength:2*self.fadeLength enableFade:YES];
}

#pragma mark animations

-(void)animateOutLeftGradient:(CGFloat)fadeLength
{
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    
    gradientMask.bounds = self.layer.bounds;
    gradientMask.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    gradientMask.shouldRasterize = YES;
    gradientMask.rasterizationScale = [UIScreen mainScreen].scale;
    
    gradientMask.startPoint = CGPointMake(0, CGRectGetMidY(self.frame));
    gradientMask.endPoint = CGPointMake(1.0, CGRectGetMidY(self.frame));
    
    // setup fade mask colors and location
    id transparent = (id)[UIColor clearColor].CGColor;
    id opaque = (id)[UIColor blackColor].CGColor;
    gradientMask.colors = @[transparent, opaque, opaque, transparent];
    
    // calculate fade
    CGFloat fadePoint = fadeLength / CGRectGetWidth(self.bounds);
    NSNumber *leftFadePoint = @(fadePoint);
    NSNumber *rightFadePoint = @(1 - fadePoint);
    
    // apply calculations to mask
    gradientMask.locations = @[@0, leftFadePoint, rightFadePoint, @1];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.layer.mask = gradientMask;
    [CATransaction commit];
    
    
    CABasicAnimation *removeLeftFade = [CABasicAnimation animationWithKeyPath:@"locations"];
    removeLeftFade.fromValue = @[@0, leftFadePoint, rightFadePoint, @1];
    removeLeftFade.toValue = @[@0, @0, rightFadePoint, @1];
    removeLeftFade.duration = self.animationDuration;
    
    [self.layer.mask addAnimation:removeLeftFade forKey:@"removeLeftFade"];
    
}

-(void)animateOutRightGradient:(CGFloat)fadeLength
{
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    
    gradientMask.bounds = self.layer.bounds;
    gradientMask.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    gradientMask.shouldRasterize = YES;
    gradientMask.rasterizationScale = [UIScreen mainScreen].scale;
    
    gradientMask.startPoint = CGPointMake(0, CGRectGetMidY(self.frame));
    gradientMask.endPoint = CGPointMake(1.0, CGRectGetMidY(self.frame));
    
    // setup fade mask colors and location
    id transparent = (id)[UIColor clearColor].CGColor;
    id opaque = (id)[UIColor blackColor].CGColor;
    gradientMask.colors = @[transparent, opaque, opaque, transparent];
    
    // calculate fade
    CGFloat fadePoint = fadeLength / CGRectGetWidth(self.bounds);
    NSNumber *leftFadePoint = @(fadePoint);
    NSNumber *rightFadePoint = @(1 - fadePoint);
    
    // apply calculations to mask
    gradientMask.locations = @[@0, leftFadePoint, rightFadePoint, @1];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.layer.mask = gradientMask;
    [CATransaction commit];
    
    
    CABasicAnimation *removeRightFade = [CABasicAnimation animationWithKeyPath:@"locations"];
    removeRightFade.fromValue = @[@0, leftFadePoint, rightFadePoint, @1];
    removeRightFade.toValue = @[@0, leftFadePoint, @1, @1];
    removeRightFade.duration = self.animationDuration;
    
    [self.layer.mask addAnimation:removeRightFade forKey:@"removeRighttFade"];
}

#pragma mark Gradient Mask

- (void)applyBothGradientMaskForFadeLength:(CGFloat)fadeLength enableFade:(BOOL)fade
{
    // Recreate gradient mask with new fade length
    if (fadeLength)
    {
        CAGradientLayer *gradientMask = [CAGradientLayer layer];
        
        gradientMask.bounds = self.layer.bounds;
        gradientMask.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        
        gradientMask.shouldRasterize = YES;
        gradientMask.rasterizationScale = [UIScreen mainScreen].scale;
        
        gradientMask.startPoint = CGPointMake(0, CGRectGetMidY(self.frame));
        gradientMask.endPoint = CGPointMake(1.0, CGRectGetMidY(self.frame));
        
        // setup fade mask colors and location
        id transparent = (id)[UIColor clearColor].CGColor;
        id opaque = (id)[UIColor blackColor].CGColor;
        gradientMask.colors = @[transparent, opaque, opaque, transparent];
        
        // calculate fade
        CGFloat fadePoint = fadeLength / CGRectGetWidth(self.bounds);
        NSNumber *leftFadePoint = @(fadePoint);
        NSNumber *rightFadePoint = @(1 - fadePoint);
        
        // apply calculations to mask
        gradientMask.locations = @[@0, leftFadePoint, rightFadePoint, @1];
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.layer.mask = gradientMask;
        [CATransaction commit];
    }
    else
    {
        // Remove gradient mask for 0.0f lenth fade length
        self.layer.mask = nil;
    }
}

- (void)applyLeftGradientMaskForFadeLength:(CGFloat)fadeLength enableFade:(BOOL)fade
{
    // Recreate gradient mask with new fade length
    if (fadeLength)
    {
        CAGradientLayer *gradientMask = [CAGradientLayer layer];
        
        gradientMask.bounds = self.layer.bounds;
        gradientMask.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        
        gradientMask.shouldRasterize = YES;
        gradientMask.rasterizationScale = [UIScreen mainScreen].scale;
        
        gradientMask.startPoint = CGPointMake(0, CGRectGetMidY(self.frame));
        gradientMask.endPoint = CGPointMake(0.5, CGRectGetMidY(self.frame));
        
        // setup fade mask colors and location
        id transparent = (id)[UIColor clearColor].CGColor;
        id opaque = (id)[UIColor blackColor].CGColor;
        gradientMask.colors = @[transparent, opaque];
        
        // calculate fade
        CGFloat fadePoint = fadeLength / CGRectGetWidth(self.bounds);
        NSNumber *leftFadePoint = @(fadePoint);
    
        // apply calculations to mask
        gradientMask.locations = @[@0, leftFadePoint];
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.layer.mask = gradientMask;
        [CATransaction commit];
    }
    else
    {
        // Remove gradient mask for 0.0f lenth fade length
        self.layer.mask = nil;
    }
}

- (void)applyRightGradientMaskForFadeLength:(CGFloat)fadeLength enableFade:(BOOL)fade
{
    // Recreate gradient mask with new fade length
    if (fadeLength)
    {
        CAGradientLayer *gradientMask = [CAGradientLayer layer];
        
        gradientMask.bounds = self.layer.bounds;
        gradientMask.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        
        gradientMask.shouldRasterize = YES;
        gradientMask.rasterizationScale = [UIScreen mainScreen].scale;
        
        gradientMask.startPoint = CGPointMake(0.5, CGRectGetMidY(self.frame));
        gradientMask.endPoint = CGPointMake(1.0, CGRectGetMidY(self.frame));
        
        // setup fade mask colors and location
        id transparent = (id)[UIColor clearColor].CGColor;
        id opaque = (id)[UIColor blackColor].CGColor;
        gradientMask.colors = @[opaque, transparent];
        
        // calcluate fade
        CGFloat fadePoint = fadeLength / CGRectGetWidth(self.bounds);
        NSNumber *rightFadePoint = @(1 - fadePoint);
        // apply calculations to mask
        gradientMask.locations = @[rightFadePoint, @1];
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.layer.mask = gradientMask;
        [CATransaction commit];
    }
    else
    {
        // Remove gradient mask for 0.0f lenth fade length
        self.layer.mask = nil;
    }
}

@end
