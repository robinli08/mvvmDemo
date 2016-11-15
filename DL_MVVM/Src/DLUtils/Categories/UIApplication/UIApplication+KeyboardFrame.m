//
//  UIApplication+KeyboardFrame.m
//  DL_MVVM
//
//  Created by Daniel.Li on 08/11/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "UIApplication+KeyboardFrame.h"

@implementation UIApplication (KeyboardFrame)

static CGRect keyboardFrame = (CGRect){ (CGPoint){ 0.0f, 0.0f }, (CGSize){ 0.0f, 0.0f } };

- (CGRect)keyboardFrame
{
    return keyboardFrame;
}

+ (void)load
{
    [NSNotificationCenter.defaultCenter addObserverForName:UIKeyboardDidShowNotification object:nil queue:nil usingBlock:^(NSNotification *note)
     {
         keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
     }];
    
    [NSNotificationCenter.defaultCenter addObserverForName:UIKeyboardDidChangeFrameNotification object:nil queue:nil usingBlock:^(NSNotification *note)
     {
         keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
     }];
    
    [NSNotificationCenter.defaultCenter addObserverForName:UIKeyboardDidHideNotification object:nil queue:nil usingBlock:^(NSNotification *note)
     {
         keyboardFrame = CGRectZero;
     }];
}


@end
