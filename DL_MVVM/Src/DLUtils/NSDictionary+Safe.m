//
//  NSDictionary+Safe.m
//  DL_MVVM
//
//  Created by Daniel.Li on 8/31/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "NSDictionary+Safe.h"

#define isValidKey(key) ((key) != nil && ![key isKindOfClass:[NSNull class]])
#define isValidValue(value) (((value) != nil) && ![value isKindOfClass:[NSNull class]])


@implementation NSDictionary (Safe)

- (id)safeObjectForKey:(id)key {
    if (!isValidKey(key)) {
        return nil;
    }
    id obj = [self objectForKey:key];
    if (!isValidValue(obj)){
        return nil;
    }
    return obj;
}
- (int)intValueForKey:(id)key {
    id obj = [self safeObjectForKey:key];
    return [obj intValue];
}
- (double)doubleValueForKey:(id)key {
    id obj = [self safeObjectForKey:key];
    return [obj doubleValue];
}
- (NSString *)stringValueForKey:(id)key {
    id obj = [self safeObjectForKey:key];
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    if ([obj respondsToSelector:@selector(stringValue)]) {
        return [obj stringValue];
    }
    return nil;
}


@end

@implementation NSMutableDictionary (Safe)


- (void)safeSetObject:(id)anObject forKey:(id)aKey {
    if (!isValidKey(aKey)) {
        return;
    }
    if ([aKey isKindOfClass:[NSString class]]) {
        [self setValue:anObject forKey:aKey];
    } else {
        if (anObject != nil) {
            [self setObject:anObject forKey:aKey];
        } else {
            [self removeObjectForKey:aKey];
        }
    }
}
- (void)setIntValue:(int)value forKey:(id)aKey {
    [self safeSetObject:[[NSNumber numberWithInt:value] stringValue] forKey:aKey];
}
- (void)setDoubleValue:(double)value forKey:(id)aKey {
    [self safeSetObject:[[NSNumber numberWithDouble:value] stringValue] forKey:aKey];
}
- (void)setStringValueForKey:(NSString *)string forKey:(id)aKey {
    [self safeSetObject:string forKey:aKey];
}


@end

