//
//  UIViewController+Popup.m
//  DL_MVVM
//
//  Created by Daniel.Li on 9/7/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "UIViewController+Popup.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import "UIView+HXUtility.h"
#import "DLBlurBackgroundView.h"

#define ANIMATION_TIME 0.5f

NSString const *DLPopupKey = @"DLPopupkey";
NSString const *DLMaskViewKey = @"DLMaskViewKey";
NSString const *DLPopupViewOffset = @"DLPopupViewOffset";
NSString const *DLPopDirection = @"DLPopDirection";


@implementation UIViewController (Popup)

- (void)presentPopupViewController:(UIViewController *)viewControllerToPresent
                          animated:(BOOL)flag
                   useBlurForPopup:(BOOL)userBlurForPopup
                        completion:(void (^)(void))completion
{
    [self presentPopupViewController:viewControllerToPresent
                            animated:YES
                     useBlurForPopup:YES
                        popDirection:DLPopupDirectionBottomToTop
                          completion:completion];
}

- (void)presentPopupViewController:(UIViewController *)viewControllerToPresent
                          animated:(BOOL)flag
                   useBlurForPopup:(BOOL)userBlurForPopup
                      popDirection:(DLPopupDirection)popDirection
                        completion:(void (^)(void))completion
{
    [self presentPopupViewController:viewControllerToPresent
                            animated:flag
                     useBlurForPopup:userBlurForPopup
                           maskColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.2]
                        popDirection:popDirection
                          completion:completion];
}

- (void)presentPopupViewController:(UIViewController *)viewControllerToPresent
                          animated:(BOOL)flag
                   useBlurForPopup:(BOOL)userBlurForPopup
                         maskColor:(UIColor *)maskColor
                      popDirection:(DLPopupDirection)popDirection
                        completion:(void (^)(void))completion;
{
    if (self.popupViewController == nil) {
        self.popupViewController = viewControllerToPresent;
        self.popDirection = popDirection;
        [self addChildViewController:viewControllerToPresent];
        
        [viewControllerToPresent beginAppearanceTransition:YES
                                                  animated:flag];
        
        CGRect maskFrame = CGRectMake(0.f, 0.f, self.view.width, self.view.height);
        self.maskView = [[UIControl alloc] initWithFrame:maskFrame];//创建一个maskView 用来显示呈现弹出的viewcontroller然后承载点击
        self.maskView.backgroundColor = maskColor;
        
        [self.view addSubview:self.maskView];
        
        [self.maskView addTarget:self
                          action:@selector(handleMask:)
                forControlEvents:UIControlEventTouchUpInside];
        
        if (userBlurForPopup) {
            DLBlurBackgroundView *backGroundView =
            [[DLBlurBackgroundView alloc] initWithBackgroundColor:viewControllerToPresent.view.backgroundColor
                                                  blurEffectStyle:DLBLurEffectStyleDark];
            backGroundView.frame = viewControllerToPresent.view.bounds;
            backGroundView.autoresizingMask =
            UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [viewControllerToPresent.view insertSubview:backGroundView atIndex:0];
        }
        
        CGRect parentFrame = self.view.frame;
        CGRect presentFrame = viewControllerToPresent.view.frame;
        
        CGRect initialFrame = CGRectZero;
        CGRect finalFrame = CGRectZero;
        switch (popDirection) {
            case DLPopupDirectionLeftToRight: {
                initialFrame = CGRectMake(CGRectGetMinX(parentFrame) - CGRectGetWidth(presentFrame),
                                          CGRectGetMinY(presentFrame),
                                          CGRectGetWidth(presentFrame),
                                          CGRectGetHeight(presentFrame));
                finalFrame = CGRectMake(CGRectGetMinX(parentFrame),
                                        CGRectGetMinY(presentFrame),
                                        CGRectGetWidth(presentFrame),
                                        CGRectGetHeight(presentFrame));
                break;
            }
            case DLPopupDirectionTopToBottom: {
                initialFrame = CGRectMake(CGRectGetMinX(presentFrame),
                                          CGRectGetMinY(parentFrame) - CGRectGetHeight(presentFrame),
                                          CGRectGetWidth(presentFrame),
                                          CGRectGetHeight(presentFrame));
                finalFrame = CGRectMake(CGRectGetMinX(presentFrame),
                                        CGRectGetMinY(parentFrame),
                                        CGRectGetWidth(presentFrame),
                                        CGRectGetHeight(presentFrame));
                break;
            }
            case DLPopupDirectionRightToLeft: {
                initialFrame = CGRectMake(CGRectGetWidth(parentFrame) + CGRectGetWidth(presentFrame) / 2,
                                          CGRectGetMinY(presentFrame),
                                          CGRectGetWidth(presentFrame),
                                          CGRectGetHeight(presentFrame));
                finalFrame = CGRectMake(CGRectGetWidth(parentFrame) - CGRectGetWidth(presentFrame),
                                        CGRectGetMinY(presentFrame),
                                        CGRectGetWidth(presentFrame),
                                        CGRectGetHeight(presentFrame));
                break;
            }
            case DLPopupDirectionBottomToTop: {
                initialFrame = CGRectMake(CGRectGetMinX(presentFrame),
                                          CGRectGetHeight(parentFrame) + CGRectGetHeight(presentFrame) / 2,
                                          CGRectGetWidth(presentFrame),
                                          CGRectGetHeight(presentFrame));
                finalFrame = CGRectMake(CGRectGetMinX(presentFrame),
                                        CGRectGetHeight(parentFrame) - CGRectGetHeight(presentFrame),
                                        CGRectGetWidth(presentFrame),
                                        CGRectGetHeight(presentFrame));
                break;
            }
        }
        
        if (flag) {
            // animate
            viewControllerToPresent.view.frame = initialFrame;
            [self.view addSubview:viewControllerToPresent.view];
            [UIView animateWithDuration:ANIMATION_TIME
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 viewControllerToPresent.view.frame = finalFrame;
                             } completion:^(BOOL finished) {
                                 [self.popupViewController didMoveToParentViewController:self];
                                 [self.popupViewController endAppearanceTransition];
                                 [completion invoke];
                             }];
        } else {
            viewControllerToPresent.view.frame = finalFrame;
            [self.view addSubview:viewControllerToPresent.view];
            [self.popupViewController didMoveToParentViewController:self];
            [self.popupViewController endAppearanceTransition];
            [completion invoke];
        }
    }
}

- (void)dismissPopupViewControllerAnimated:(BOOL)flag
                                completion:(void (^)(void))completion
{
    if (nil == self.popupViewController) {
        [completion invoke];
        return;
    }
    [self.popupViewController willMoveToParentViewController:nil];
    
    [self.popupViewController beginAppearanceTransition:NO
                                               animated:flag];
    
    CGRect parentFrame = self.view.frame;
    CGRect presentFrame = self.popupViewController.view.frame;
    
    CGRect finalFrame = CGRectZero;
    switch (self.popDirection) {
        case DLPopupDirectionLeftToRight: {
            finalFrame = CGRectMake(CGRectGetMinX(parentFrame) - CGRectGetWidth(presentFrame),
                                    CGRectGetMinY(presentFrame),
                                    CGRectGetWidth(presentFrame),
                                    CGRectGetHeight(presentFrame));
            break;
        }
        case DLPopupDirectionTopToBottom: {
            finalFrame = CGRectMake(CGRectGetMinX(presentFrame),
                                    CGRectGetMinY(parentFrame) - CGRectGetHeight(presentFrame),
                                    CGRectGetWidth(presentFrame),
                                    CGRectGetHeight(presentFrame));
            break;
        }
        case DLPopupDirectionRightToLeft: {
            finalFrame = CGRectMake(CGRectGetWidth(parentFrame) + CGRectGetWidth(presentFrame) / 2,
                                    CGRectGetMinY(presentFrame),
                                    CGRectGetWidth(presentFrame),
                                    CGRectGetHeight(presentFrame));
            break;
        }
        case DLPopupDirectionBottomToTop: {
            finalFrame = CGRectMake(CGRectGetMinX(presentFrame),
                                    CGRectGetHeight(parentFrame) + CGRectGetHeight(presentFrame) / 2,
                                    CGRectGetWidth(presentFrame),
                                    CGRectGetHeight(presentFrame));
            break;
        }
    }
    
    if (flag) {
        [UIView animateWithDuration:ANIMATION_TIME
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.popupViewController.view.frame = finalFrame;
                         } completion:^(BOOL finished) {
                             [self.popupViewController removeFromParentViewController];
                             [self.popupViewController endAppearanceTransition];
                             [self.popupViewController.view removeFromSuperview];
                             [self.maskView removeFromSuperview];
                             self.popupViewController = nil;
                             [completion invoke];
                         }];
    } else {
        [self.popupViewController removeFromParentViewController];
        [self.popupViewController endAppearanceTransition];
        [self.popupViewController.view removeFromSuperview];
        [self.maskView removeFromSuperview];
        self.popupViewController = nil;
        [completion invoke];
    }
}

- (void)handleMask:(id)sender
{
    [self dismissPopupViewControllerAnimated:YES
                                  completion:nil];
}

#pragma mark ------------------ Getter&&Setters --------------------

- (void)setPopupViewController:(UIViewController *)popupViewController
{
    objc_setAssociatedObject(self, &DLPopupKey, popupViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)popupViewController
{
    return objc_getAssociatedObject(self, &DLPopupKey);
}

- (void)setMaskView:(UIControl *)maskView
{
    objc_setAssociatedObject(self, &DLMaskViewKey, maskView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIControl *)maskView
{
    return objc_getAssociatedObject(self, &DLMaskViewKey);
}

- (void)setPopupViewOffset:(CGPoint)popupViewOffset
{
    NSValue *value = [NSValue valueWithCGPoint:popupViewOffset];
    objc_setAssociatedObject(self, &DLPopupViewOffset, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGPoint)popupViewOffset
{
    NSValue *offset = objc_getAssociatedObject(self, &DLPopupViewOffset);
    return [offset CGPointValue];
}

- (void)setPopDirection:(DLPopupDirection)popDirection
{
    NSNumber *number = [NSNumber numberWithInteger:popDirection];
    objc_setAssociatedObject(self, &DLPopupViewOffset, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DLPopupDirection)popDirection
{
    NSNumber *popDirection = objc_getAssociatedObject(self, &DLPopupViewOffset);
    return (DLPopupDirection)[popDirection integerValue];
}


@end
