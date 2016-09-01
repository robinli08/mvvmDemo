//
//  DLCollectionItem.m
//  DL_MVVM
//
//  Created by Daniel.Li on 9/1/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLCollectionItem.h"

@implementation DLCollectionItem

- (NSString*)itemIdentifier{
    if (!_itemIdentifier) {
        _itemIdentifier = NSStringFromClass([self class]);
    }
    return _itemIdentifier;
}


@end
