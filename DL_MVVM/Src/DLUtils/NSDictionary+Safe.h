//
//  NSDictionary+Safe.h
//  DL_MVVM
//
//  Created by Daniel.Li on 8/31/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Safe)

- (id)safeObjectForKey:(id)key;
- (int)intValueForKey:(id)key;
- (double)doubleValueForKey:(id)key;
- (NSString *)stringValueForKey:(id)key;

@end

@interface NSMutableDictionary (Safe)

- (void)safeSetObject:(id)anObject forKey:(id)aKey;
- (void)setIntValue:(int)value forKey:(id)aKey;
- (void)setDoubleValue:(double)value forKey:(id)aKey;
- (void)setStringValueForKey:(NSString *)string forKey:(id)aKey;

@end
