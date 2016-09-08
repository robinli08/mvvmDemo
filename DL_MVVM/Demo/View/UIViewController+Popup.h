//
//  UIViewController+Popup.h
//  DL_MVVM
//
//  Created by Daniel.Li on 9/7/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DLPopupDirection) {
    
    DLPopupDirectionLeftToRight = 0,
    DLPopupDirectionTopToBottom,
    DLPopupDirectionRightToLeft,
    DLPopupDirectionBottomToTop
};

@interface UIViewController (Popup)

@property (nonatomic, readwrite) UIViewController *popupViewController;
@property (nonatomic, readwrite) CGPoint popupViewOffset;
@property (nonatomic, readwrite) UIControl *maskView;
@property (nonatomic, readwrite) DLPopupDirection popDirection;

- (void)presentPopupViewController:(UIViewController *)viewControllerToPresent
                          animated:(BOOL)flag
                   useBlurForPopup:(BOOL)userBlurForPopup
                        completion:(void (^)(void))completion;

- (void)presentPopupViewController:(UIViewController *)viewControllerToPresent
                          animated:(BOOL)flag
                   useBlurForPopup:(BOOL)userBlurForPopup
                      popDirection:(DLPopupDirection)popDirection
                        completion:(void (^)(void))completion;

- (void)presentPopupViewController:(UIViewController *)viewControllerToPresent
                          animated:(BOOL)flag
                   useBlurForPopup:(BOOL)userBlurForPopup
                         maskColor:(UIColor *)maskColor
                      popDirection:(DLPopupDirection)popDirection
                        completion:(void (^)(void))completion;


- (void)dismissPopupViewControllerAnimated:(BOOL)flag
                                completion:(void (^)(void))completion;


@end
