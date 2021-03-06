//
//  LPPopup.m
//
//  Created by Jakub Dolecki on 4/9/13.
//  Refactored by Jesse Squires on 5/20/13.
//
//  Copyright (c) 2013 Jakub Dolecki, Jesse Squires. All rights reserved.
//
//  The MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
//  following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <QuartzCore/QuartzCore.h>
#import "LPPopup.h"
#import "UIFont+BBX.h"

CGFloat const kLPPopupDefaultWaitDuration = 2.0f;

static NSString * const kLPAnimationKeyPopup = @"kLPAnimationKeyPopup";

@interface LPPopup ()<CAAnimationDelegate>
@property (copy, nonatomic) void (^animationCompletion)(LPPopup * popLab);
@end


@implementation LPPopup

@synthesize popupColor;
@synthesize forwardAnimationDuration;
@synthesize backwardAnimationDuration;
@synthesize textInsets;
@synthesize maxWidth;

#pragma mark - Initialization
+ (LPPopup *)popupWithText:(NSString *)txt
{
    return [[LPPopup alloc] initWithText:txt];
}

- (id)initWithText:(NSString *)txt
{
    self = [self initWithFrame:CGRectZero];
    if(self) {
        self.text = txt;
        [self sizeToFit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        popupColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        forwardAnimationDuration = 0.3f;
        backwardAnimationDuration = 0.2f;
        textInsets = UIEdgeInsetsMake(14.0f, 20.0f, 14.0f, 20.0f);
        maxWidth = [[[UIApplication sharedApplication] keyWindow] bounds].size.width*0.9;
        
        self.backgroundColor = [UIColor clearColor];        
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentCenter;
        
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont bbxSystemFont:14];
    }
    return self;
}

#pragma mark - Showing popup
- (void)showInView:(UIView *)parentView
     centerAtPoint:(CGPoint)pos
          duration:(CGFloat)waitDuration
        completion:(void (^)(LPPopup *))block
{
    self.center = pos;
    self.animationCompletion = block;
    
    CABasicAnimation *forwardAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    forwardAnimation.duration = self.forwardAnimationDuration;
    forwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5f :1.7f :0.6f :0.85f];
    forwardAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    forwardAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    CABasicAnimation *reverseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    reverseAnimation.duration = self.backwardAnimationDuration;
    reverseAnimation.beginTime = forwardAnimation.duration + waitDuration;
    reverseAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4f :0.15f :0.5f :-0.7f];
    reverseAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    reverseAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:forwardAnimation, reverseAnimation, nil];
    animationGroup.delegate = self;
    animationGroup.duration = forwardAnimation.duration + reverseAnimation.duration + waitDuration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    
    [parentView addSubview:self];
    [UIView animateWithDuration:animationGroup.duration
                          delay:0.0
                        options:0
                     animations:^{
                         [self.layer addAnimation:animationGroup
                                           forKey:kLPAnimationKeyPopup];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark - Core animation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(flag) {
        
        if(self.animationCompletion)
        {
            self.animationCompletion(self);
        }
        
        [self.layer removeAllAnimations];
        [self removeFromSuperview];
    }
}

#pragma mark - UILabel
- (void)sizeToFit
{
    [super sizeToFit];
    
    CGRect newFrame = self.frame;
    newFrame.size = CGSizeMake(self.frame.size.width + self.textInsets.left + self.textInsets.right,
                               self.frame.size.height + self.textInsets.bottom + self.textInsets.top);
    
    self.frame = newFrame;
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
//    bounds.size = [self.text sizeWithFont:self.font
//                        constrainedToSize:CGSizeMake(self.maxWidth - self.textInsets.left - self.textInsets.right,
//                                                     CGFLOAT_MAX)];
    
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    bounds.size = [self.text boundingRectWithSize:CGSizeMake(self.maxWidth - self.textInsets.left - self.textInsets.right,
                                               CGFLOAT_MAX) options:options attributes:@{NSFontAttributeName:self.font} context:NULL].size;
    
    return bounds;
}

- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textInsets)];
}

#pragma mark - Drawing
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 5.0f, 5.0f)
                                                           cornerRadius:4.0f];
    
    CGContextSetFillColorWithColor(context, self.popupColor.CGColor);
    CGContextFillPath(context);
    
    CGContextSetShadowWithColor(context,
                                CGSizeMake(0.0f, 0.5f),
                                3.0f,
                                [UIColor colorWithWhite:0.0f alpha:0.45f].CGColor);
    
    CGContextAddPath(context, roundedRect.CGPath);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextRestoreGState(context);
    [super drawRect:rect];
}

@end
