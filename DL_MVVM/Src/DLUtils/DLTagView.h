//
//  DLTagView.h
//  DL_MVVM
//
//  Created by Daniel.Li on 8/15/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLTagView : UIView

/**
 *  label字体，默认是系统14字体
 */
@property (nonatomic, strong) UIFont *textFont;

/**
 *  字体颜色
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 *  文字距离边框的距离
 */
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

/**
 *  文字
 */
@property (nonatomic, copy) NSString *text;

/**
 *  表框的颜色，默认是黑色
 */
@property (nonatomic, strong) UIColor *boardColor;

@end
