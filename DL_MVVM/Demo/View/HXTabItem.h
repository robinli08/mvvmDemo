//
//  HXTabItem.h
//  DL_MVVM
//
//  Created by Daniel.Li on 31/10/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, TabState) {
    TabStateEnabled,
    TabStateDisabled
};

typedef NS_ENUM(NSInteger, TabType) {
    TabTypeUsual,
    TabTypeButton,
    TabTypeUnexcludable
};

@interface HXTabItem : NSObject

@property (readwrite) TabState tabState;
@property (readonly) TabType tabType;
@property (nonatomic, assign, readonly) id target;
@property (readonly) SEL selector;
@property (nonatomic, strong) UIColor *enabledBackgroundColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleFontColor;
@property (nonatomic, strong, readonly) UIImage *imageForCurrentState;

+ (instancetype)createUsualItemWithImageEnabled:(UIImage *)imageEnabled
                                  imageDisabled:(UIImage *)imageDisabled;

+ (instancetype)createUnexcludableItemWithImageEnabled:(UIImage *)imageEnabled
                                         imageDisabled:(UIImage *)imageDisabled;

+ (instancetype)createButtonItemWithImage:(UIImage *)image
                                   target:(id)target
                                 selector:(SEL)selector;

- (void)switchState;
@end
