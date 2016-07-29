//
//  DL_ThreadSafeMutableDictionary.m
//  DL_MVVM
//
//  Created by Daniel.Li on 7/29/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DL_ThreadSafeMutableDictionary.h"

@interface DL_ThreadSafeMutableDictionary ()

@property (nonatomic, strong) NSMutableDictionary *backupStoreDictionary;
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation DL_ThreadSafeMutableDictionary

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    [self setupCapacity:0];
    
    return self;
}

- (instancetype)initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {
    
    self = [super initWithObjects:objects forKeys:keys count:cnt];
    
    if (!self) {
        return nil;
    }
    
    for (NSUInteger i = 0; i < cnt; ++i) {
        _backupStoreDictionary[keys[i]] = objects[i];
    }
    
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)numItems {
    self = [super initWithCapacity:numItems];
    if (!self) {
        return nil;
    }
    
    [self setupCapacity:numItems];
    return self;
}

- (void)setupCapacity:(NSUInteger)capacity {
    _backupStoreDictionary = [[NSMutableDictionary alloc] initWithCapacity:capacity];
    _queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
}

- (NSUInteger)count {
    
    __block NSUInteger count;
    dispatch_sync(_queue, ^{
        count = _backupStoreDictionary.count;
    });
    return count;
}

- (id)objectForKey:(id)aKey {
    
    __block id obj;
    dispatch_sync(_queue, ^{
        obj = [_backupStoreDictionary objectForKey:aKey];
    });
    
    return obj;
}

- (id)objectForKeyedSubscript:(id)key {
    
    __block id obj;
    dispatch_sync(_queue, ^{
        obj = [_backupStoreDictionary objectForKeyedSubscript:key];
    });
    
    return obj;
}

- (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    dispatch_barrier_sync(_queue, ^{
        [_backupStoreDictionary setObject:anObject forKey:aKey];
    });
}

- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    
    dispatch_barrier_sync(_queue, ^{
        [_backupStoreDictionary setObject:obj forKeyedSubscript:key];
    });
    
}

- (void)removeObjectForKey:(id)aKey {
    
    dispatch_barrier_sync(_queue, ^{
        [_backupStoreDictionary removeObjectForKey:aKey];
    });
}

- (void)removeAllObjects {
    
    dispatch_barrier_sync(_queue, ^{
        [_backupStoreDictionary removeAllObjects];
    });
}

- (NSEnumerator *)keyEnumerator {
    
    __block NSEnumerator *enumerator;
    dispatch_sync(_queue, ^{
        enumerator = _backupStoreDictionary.keyEnumerator;
    });
    return enumerator;
}

@end
