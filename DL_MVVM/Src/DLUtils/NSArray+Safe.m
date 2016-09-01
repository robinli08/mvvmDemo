//
//  NSArray+Safe.m
//  DL_MVVM
//
//  Created by Daniel.Li on 8/31/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

+ (instancetype)arrayWithObjectForDL:(id)anObject {
    
    if (anObject != nil) {
        return [self arrayWithObject:anObject];
    } else {
        return nil;
    }
}

- (id)objectAtIndexForDL:(NSUInteger)index {
    
    if (index < self.count) {
        return [self objectAtIndex:index];
    } else {
        return nil;
    }
}

- (NSArray *)arrayByAddingObjectForDL:(id)anObject {
    
    if (anObject != nil) {
        return [self arrayByAddingObject:anObject];
    } else {
        return nil;
    }
}

- (NSArray *)subarrayWithRangeForDL:(NSRange)range {
    
    if ((range.location + range.length) <= self.count) {
        return [self subarrayWithRange:range];
    } else {
        return nil;
    }
}

- (void)getObjectsForDL:(__unsafe_unretained id [])objects range:(NSRange)range {
    
    if ((range.location + range.length) <= self.count) {
        return [self getObjects:objects range:range];
    } else {
        return;
    }
}

- (NSArray *)objectsAtIndexesForDL:(NSIndexSet *)indexes {
    
    if (indexes.firstIndex < self.count && indexes.lastIndex < self.count) {
        return [self objectsAtIndexes:indexes];
    } else {
        return nil;
    }
}

+ (NSArray *)arrayWithArrayForDL:(NSArray *)array {
    
    @try {
        if (nil != array && [array count] > 0) {
            return [self arrayWithArray:array];
        } else {
            return nil;
        }
    } @catch (NSException *exception) {
        NSAssert(nil, exception.description);
        return nil;
    }

    
}

@end
