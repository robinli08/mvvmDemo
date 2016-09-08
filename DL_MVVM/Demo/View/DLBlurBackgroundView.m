//
//  DLBlurBackgroundView.m
//  DL_MVVM
//
//  Created by Daniel.Li on 9/7/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLBlurBackgroundView.h"

@interface DLBlurBackgroundView ()

@property (nonatomic, assign) DLBlurEffectStyle effectStyle;
@property (nonatomic, strong) UIColor *defaultColor;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
@property (nonatomic, strong) UIVisualEffectView *effectView;
#endif
@end

@implementation DLBlurBackgroundView

- (instancetype)initWithBackgroundColor:(UIColor *)backgroundColor
                        blurEffectStyle:(DLBlurEffectStyle)effectStyle
{
    self = [self initWithFrame:CGRectZero];
    if (!self) {
        return nil;
    }
    
    self.defaultColor = backgroundColor;
    self.effectStyle = effectStyle;
    
    [self themeDidChange];
    
    return self;
}

- (void)themeDidChange
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        if (self.effectView) {
            [self.effectView removeFromSuperview];
            self.effectView = nil;
        }
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:[self blurEffectStyle]];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurView.clipsToBounds = YES;
        blurView.frame = self.bounds;
        blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self insertSubview:blurView atIndex:0];
        
        self.effectView = blurView;
        
    } else {
        self.backgroundColor = self.defaultColor;
    }
    
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
- (UIBlurEffectStyle)blurEffectStyle
{
    switch (self.effectStyle) {
        case DLBLurEffectStyleExtraLight: {
            return UIBlurEffectStyleExtraLight;
        }
        case DLBlurEffectStyleLight: {
            return UIBlurEffectStyleLight;
        }
        case DLBLurEffectStyleDark: {
            return UIBlurEffectStyleDark;
        }
    }
}
#endif


@end
