//
//  UIResponder+FirstResponder.h
//  DL_MVVM
//
//  Created by Daniel.Li on 07/11/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (FirstResponder)

+ (id)currentFirstResponder;

@end
