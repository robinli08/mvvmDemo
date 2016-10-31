//
//  HXTabView.h
//  DL_MVVM
//
//  Created by Daniel.Li on 31/10/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct HorizontalEdgeInsets {
    CGFloat left, right;
} HorizontalEdgeInsets;

static inline HorizontalEdgeInsets HorizontalEdgeInsetsMake (CGFloat left, CGFloat right) {
    HorizontalEdgeInsets insets = {left, right};
    return insets;
}

@class HXTabItem;
@class HXTabView;

@protocol HXTabViewDelelgate <NSObject>

//Called for all types except TabTypeButton
- (void)tabView:(HXTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(HXTabItem *)tabItem;
//Called Only for unexcludable items. (TabTypeUnexcludable)
- (void)tabView:(HXTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(HXTabItem *)tabItem;

@end

@interface HXTabView : UIView

@property (nonatomic, assign) IBOutlet id<HXTabViewDelelgate> delegate;
@property (readwrite) BOOL darkensBackgroundForEnabledTabs;
@property (readwrite) BOOL drawSeparators;
@property (nonatomic, strong) UIColor *enabledTabBackgrondColor;
@property (nonatomic, strong) UIFont *titlesFont;
@property (nonatomic, strong) UIColor *titlesFontColor;
@property (nonatomic, strong) NSArray *tabItems;
@property (nonatomic, readwrite) HorizontalEdgeInsets horizontalInsets;

- (instancetype)initWithFrame:(CGRect)frame andTabItems:(NSArray *)tabItems;



@end
