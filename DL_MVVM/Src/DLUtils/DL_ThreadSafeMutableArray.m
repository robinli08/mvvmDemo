//
//  DL_ThreadSafeMutableArray.m
//  DL_MVVM
//
//  Created by Daniel.Li on 7/29/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DL_ThreadSafeMutableArray.h"

@interface DL_ThreadSafeMutableArray ()

@property (nonatomic,strong) NSMutableArray *backupStoreArray;
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation DL_ThreadSafeMutableArray


- (instancetype)init{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    [self setUpCapacity:0];
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)numItems {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    [self setUpCapacity:numItems];
    return self;
}

- (instancetype)initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    
    self = [super initWithCapacity:cnt];
    
    if (!self) {
        return nil;
    }
    
    for (NSUInteger i = 0; i < cnt; ++i) {
        [_backupStoreArray addObject:objects[i]];
    }
    return self;
}

- (NSUInteger)count {
    
    __block NSUInteger count;
    
    dispatch_sync(self.queue, ^{
        count = _backupStoreArray.count;
    });
    return count;
}

- (id)objectAtIndex:(NSUInteger)index {
    
    __block id obj;
    dispatch_sync(_queue, ^{
        obj = [_backupStoreArray objectAtIndex:index];
    });
    
    return obj;
    
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    
    __block id obj;
    
    dispatch_sync(_queue, ^{
        obj = [_backupStoreArray objectAtIndexedSubscript:idx];
    });
    
    return obj;
    
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    
    dispatch_barrier_sync(_queue, ^{
        [_backupStoreArray insertObject:anObject atIndex:index];
    });
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    dispatch_barrier_sync(_queue, ^{
        [_backupStoreArray setObject:obj atIndexedSubscript:idx];
    });
}

- (void)removeObject:(id)anObject {
    
    dispatch_barrier_sync(_queue, ^{
        [_backupStoreArray removeObject:anObject];
    });
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    dispatch_barrier_sync(_queue, ^{
        [_backupStoreArray removeObjectAtIndex:index];
    });
}

- (void)removeAllObjects {
    dispatch_barrier_sync(_queue, ^{
        [_backupStoreArray removeAllObjects];
    });
}

- (void)setUpCapacity:(NSUInteger)capcity {
    
    _backupStoreArray = [[NSMutableArray alloc] initWithCapacity:capcity];
    _queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
}

@end
