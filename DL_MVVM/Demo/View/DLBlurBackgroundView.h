//
//  DLBlurBackgroundView.h
//  DL_MVVM
//
//  Created by Daniel.Li on 9/7/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DLBlurEffectStyle) {
    
    DLBLurEffectStyleExtraLight,
    DLBlurEffectStyleLight,
    DLBLurEffectStyleDark
};

@interface DLBlurBackgroundView : UIView

- (instancetype)initWithBackgroundColor:(UIColor *)backgroundColor blurEffectStyle:(DLBlurEffectStyle)effectStyle;

@end
