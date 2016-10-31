//
//  DLRainbowView.m
//  DL_MVVM
//
//  Created by Daniel.Li on 25/10/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLRainbowView.h"
#import "DLRainbowLayer.h"

@implementation DLRainbowView

+(Class)layerClass {
    
    return [DLRainbowLayer class];
}

@end
