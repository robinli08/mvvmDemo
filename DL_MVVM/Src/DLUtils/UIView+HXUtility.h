//
//  UIView+HXUtility.h
//  alertDemo
//
//  Created by Daniel.Li on 7/26/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HXUtility)

@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, assign) CGSize size;


@end
