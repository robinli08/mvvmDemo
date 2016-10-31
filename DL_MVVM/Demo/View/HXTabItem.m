//
//  HXTabItem.m
//  DL_MVVM
//
//  Created by Daniel.Li on 31/10/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "HXTabItem.h"

@interface HXTabItem ()

@property (nonatomic, readwrite) SEL selector;
@property (nonatomic, assign) id target;
@property (nonatomic, strong) UIImage *imageEnabled;
@property (nonatomic, strong) UIImage *imageDisabled;
@property (nonatomic, readwrite) TabType tabType;

@end

@implementation HXTabItem

+ (instancetype)createUsualItemWithImageEnabled:(UIImage *)imageEnabled
                                  imageDisabled:(UIImage *)imageDisabled {
    HXTabItem *tabItem = [[HXTabItem alloc] init];
    if (tabItem) {
        tabItem.imageEnabled = imageEnabled;
        tabItem.imageDisabled = imageDisabled;
        tabItem.tabState = TabStateDisabled;
        tabItem.tabType = TabTypeUsual;
    }
    return tabItem;
}

+ (instancetype)createUnexcludableItemWithImageEnabled:(UIImage *)imageEnabled
                                         imageDisabled:(UIImage *)imageDisabled {
    HXTabItem *tabItem = [[HXTabItem alloc] init];
    if (tabItem) {
        tabItem.imageEnabled = imageEnabled;
        tabItem.imageDisabled = imageDisabled;
        tabItem.tabState = TabStateDisabled;
        tabItem.tabType = TabTypeUnexcludable;
    }
    return tabItem;
}

+ (instancetype)createButtonItemWithImage:(UIImage *)image
                                   target:(id)target
                                 selector:(SEL)selector {
    HXTabItem *tabItem = [[HXTabItem alloc] init];
    if (tabItem) {
        tabItem.imageEnabled = image;
        tabItem.tabType = TabTypeButton;
        tabItem.target = target;
        tabItem.selector = selector;
    }
    return tabItem;
}

- (UIImage *)imageEnabled {
    if (!_imageEnabled) {
        _imageEnabled = self.imageDisabled;
    }
    return _imageEnabled;
}

- (UIImage *)imageForCurrentState {
    switch (self.tabState) {
        case TabStateEnabled:
            return self.imageEnabled;
            break;
        case TabStateDisabled:
            return self.imageDisabled;
            break;
        default:
            return nil;
            break;
    }
}

- (void)switchState {
    switch (self.tabState) {
        case TabStateEnabled:
            self.tabState = TabStateDisabled;
            break;
        case TabStateDisabled:
            self.tabState = TabStateEnabled;
            break;
        default:
            return;
            break;
    }
}
@end
