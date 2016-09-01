//
//  DLAutoScrollLabel.h
//  DL_MVVM
//
//  Created by Daniel.Li on 8/23/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,DLTextAligment){
    
    DLTextAligmentLeft       = 0,
#if TARGET_OS_IPHONE
    DLTextAligmentCenter     = 1,
    DLTextAligmentRight      = 2,
#else 
    DLTextAligmentRight      = 1,
    DLTextAligmentCenter     = 2,
#endif
    DLTextAligmentJustified  = 3,
    DLTextAligmentNatural    = 4,
    
};

typedef void (^HighlightedDidChangeBlock)(void);

@interface DLAutoScrollLabel : UIView

@property (nonatomic) CGFloat scrollSpeed;
@property (nonatomic) NSTimeInterval pauseInterval;
@property (nonatomic) NSInteger labelSpacing;
@property (nonatomic) CGFloat fadeLength;
@property (nonatomic, readonly) BOOL scrolling;
@property (nonatomic) BOOL scrollEnabled;// default is YES

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic) CGSize shadowOffset;
@property (nonatomic) DLTextAligment textAligment;

@property (nonatomic, copy) NSAttributedString *attributedText;
@property (nonatomic, strong) UIColor *highlightedTextColor;
@property (nonatomic, getter=isHighlight) BOOL highlighted;

@property (nonatomic, copy) HighlightedDidChangeBlock highlightedDidChangeCallBlock;

@end
