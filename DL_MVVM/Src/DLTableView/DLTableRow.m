//
//  DLTableRow.m
//  DL_MVVM
//
//  Created by Daniel.Li on 7/25/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLTableRow.h"

@implementation DLTableRow

- (void)dealloc{
    NSLog(@"dealloc");
}

- (NSString*)cellIdentifier{
    if (!_cellIdentifier) {
        _cellIdentifier = NSStringFromClass([self class]);
    }
    return _cellIdentifier;
}


@end
