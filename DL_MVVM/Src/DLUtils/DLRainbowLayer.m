//
//  DLRainbowLayer.m
//  DL_MVVM
//
//  Created by Daniel.Li on 25/10/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLRainbowLayer.h"
#import <UIKit/UIKit.h>

@implementation DLRainbowLayer

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.startPoint = CGPointMake(0, 0.5);
    self.endPoint = CGPointMake(1, 0.5);
    self.locations = @[@0, @0.8, @1];
    self.colors = @[
//                    (id)[UIColor colorWithRed:59.0/255.0 green:134.0/255.0 blue:235.0/255.0 alpha:1].CGColor,
//                    (id)[UIColor colorWithRed:170.0/255.0 green:68.0/255.0 blue:214.0/255.0 alpha:1].CGColor,
//                    (id)[UIColor colorWithRed:193.0/255.0 green:54.0/255.0 blue:210.0/255.0 alpha:1].CGColor,
                     (id)[UIColor redColor].CGColor,
                     (id)[UIColor redColor].CGColor,
                     (id)[UIColor redColor].CGColor
                    ];
    
    return self;
}


@end
