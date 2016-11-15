//
//  UIResponder+FirstResponder.m
//  DL_MVVM
//
//  Created by Daniel.Li on 07/11/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "UIResponder+FirstResponder.h"

static __weak id currentResponder;

@implementation UIResponder (FirstResponder)

+ (id)currentFirstResponder {
    currentResponder = nil;
    
    [[UIApplication sharedApplication] sendAction:@selector(findCurrentFirstResponder:) to:nil from:nil forEvent:nil];
    
    return currentResponder;
}

- (void)findCurrentFirstResponder:(id)sender {
    currentResponder = self;
}


@end
