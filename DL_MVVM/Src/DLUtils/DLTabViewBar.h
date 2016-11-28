//
//  DLTabViewBar.h
//  DL_MVVM
//
//  Created by Daniel.Li on 19/11/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLTabViewBar;

@protocol DLTabViewBarDelegate <NSObject>

@required

- (NSInteger)numberOfTabForTabViewBar:(DLTabViewBar *)TTTabViewBar;

- (id)tabViewBar:(DLTabViewBar *)tabViewBar titleForIndex:(NSInteger)index;

@optional

- (void)tabViewBar:(DLTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index;

@end



@interface DLTabViewBar : UIView

@property (nonatomic, weak) id<DLTabViewBarDelegate> delegate;

@property (nonatomic, strong) UIFont  *font;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *highlightedColor;

- (void)reloadTabBar;
- (void)reloadTabIndex:(NSInteger)index;

- (void)tabScrollXPercent:(CGFloat)percent;
- (void)tabDidScrollToIndex:(NSInteger)index;

- (UIButton*)buttonAtIndex:(NSInteger)index;


@end
