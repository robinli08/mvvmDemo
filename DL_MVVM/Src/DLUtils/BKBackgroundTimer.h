//
//  BKBackgroundTimer.h
//  backgroundTimer
//
//  Created by Daniel.Li on 4/3/16.
//  Copyright © 2016 com.Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <_types/_uint64_t.h>

/**
 *  不同与传统的NSTimer，不依赖于线程和Runloop
 */

@class BKBackgroundTimer;

typedef void(^FireBlock)(BKBackgroundTimer *backgroundTimer);

@interface BKBackgroundTimer : NSObject

/**
 *  生成一个不依赖于Runloop和线程的Timer
 *
 *  @param interval  Timer 间隔
 *  @param repeats   是否重复
 *  @param fireBlock fireBlock
 *
 *  @return BKBackgroundTimer
 */

- (instancetype)initWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats fireBlock:(FireBlock)fireBlock;
- (BOOL)start;
- (BOOL)resume;
- (BOOL)pause;
- (BOOL)stop;

@end
