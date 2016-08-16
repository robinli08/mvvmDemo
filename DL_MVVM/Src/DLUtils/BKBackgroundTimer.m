//
//  BKBackgroundTimer.m
//  backgroundTimer
//
//  Created by Daniel.Li on 4/3/16.
//  Copyright © 2016 com.Daniel. All rights reserved.
//

#import "BKBackgroundTimer.h"
#import <libkern/OSAtomic.h>

typedef NS_ENUM(NSInteger,BKBackgroundTimerState) {
    BKBackgroundTimerStateReady,
    BKBackgroundTimerStateRunning,
    BKBackgroundTimerStatePaused,
    BKBackgroundTimerStateStopped
};

@interface BKBackgroundTimer ()

@property (nonatomic, assign) OSSpinLock lock;
@property (nonatomic, strong) dispatch_queue_t timerFireQueue;
@property (nonatomic, strong) dispatch_source_t timerSource;
@property (nonatomic, assign) BKBackgroundTimerState timerState;

@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, assign) BOOL repeats;
@property (nonatomic, strong) FireBlock fireBlock;

@end

@implementation BKBackgroundTimer

- (instancetype)initWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats fireBlock:(FireBlock)fireBlock {
    if (self = [super init]) {
        _interval = interval;
        _repeats = repeats;
        _fireBlock = fireBlock;
        
        _lock = OS_SPINLOCK_INIT;
        _timerFireQueue = dispatch_queue_create("BKBackgroundTimerFire", DISPATCH_QUEUE_SERIAL);
        self.timerState = BKBackgroundTimerStateReady;
    }
    
    return self;
}

- (void)setupTimerSource {
    _timerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, self.timerFireQueue);
    dispatch_source_set_timer(self.timerSource, DISPATCH_TIME_NOW, self.interval * NSEC_PER_SEC, 0.01*NSEC_PER_SEC);
    __weak __typeof__(self) weakSelf = self;
    dispatch_source_set_event_handler(self.timerSource, ^{
        __strong __typeof__(self) strongSelf = weakSelf;
        if (strongSelf.timerState == BKBackgroundTimerStateRunning) {
            strongSelf.fireBlock(self);
            if (!strongSelf.repeats) {
                [strongSelf stop];
            }
        }
    });
    
}

- (BOOL)start {
    OSSpinLockLock(&_lock);
    BOOL success = YES;
    if (self.timerState != BKBackgroundTimerStateReady && self.timerState != BKBackgroundTimerStateStopped) {
        success = NO;
    } else {
        [self setupTimerSource];
        dispatch_resume(self.timerSource);
        self.timerState = BKBackgroundTimerStateRunning;
    }
    OSSpinLockUnlock(&_lock);
    
    return success;
}

- (BOOL)pause {
    OSSpinLockLock(&_lock);
    
    BOOL success = YES;
    if (self.timerState != BKBackgroundTimerStateRunning) {
        success = NO;
    } else {
        dispatch_suspend(self.timerSource);
        self.timerState = BKBackgroundTimerStatePaused;
    }
    OSSpinLockUnlock(&_lock);
    
    return success;
}

- (BOOL)stop {
    OSSpinLockLock(&_lock);
    BOOL success = YES;
    
    switch (self.timerState) {
        case BKBackgroundTimerStatePaused: {
            dispatch_resume(self.timerSource);
        }
            break;
        case BKBackgroundTimerStateRunning: {
            self.timerSource = nil;
            self.timerState = BKBackgroundTimerStateStopped;
        }
            break;
        default: {
            success = NO;
        }
            break;
    }
    
    OSSpinLockUnlock(&_lock);
    
    return success;
}

- (BOOL)resume {
    OSSpinLockLock(&_lock);
    BOOL success = YES;
    if (self.timerState != BKBackgroundTimerStatePaused) {
        success = NO;
    } else {
        dispatch_resume(self.timerSource);
        self.timerState = BKBackgroundTimerStateRunning;
    }
    OSSpinLockUnlock(&_lock);
    return success;
}

@end
