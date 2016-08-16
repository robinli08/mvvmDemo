//
//  DLTagView.h
//  DL_MVVM
//
//  Created by Daniel.Li on 8/15/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLTagView : UIView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@end
