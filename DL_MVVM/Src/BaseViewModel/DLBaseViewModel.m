//
//  DLBaseViewModel.m
//  DL_MVVM
//
//  Created by Daniel.Li on 7/25/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLBaseViewModel.h"
#import <libkern/OSAtomic.h>

static int64_t g_UniqueID = 0;

@interface DLBaseViewModel ()

@property (nonatomic, assign) int64_t uniqueID;

@end

@implementation DLBaseViewModel

+ (BOOL)propertyIsIgnored:(NSString *)propertyName {
    return YES;
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    
    if ([propertyName isEqualToString:@"uniqueID"]) {
        return YES;
    }
    return NO;
}

- (instancetype)initWithDataModel:(DLBaseModel *)dataModel {
    self = [super initWithDictionary:[dataModel toDictionary] error:nil];
    
    if (self) {
        _dataMode = dataModel;
    }
    
    return self;
}

- (int64_t)uniqueID {
    if (_uniqueID) {
        _uniqueID = [DLBaseViewModel uniqueKey];
    }
    
    return _uniqueID;
}

+ (int64_t)uniqueKey {
    int64_t val = OSAtomicIncrement64Barrier(&g_UniqueID);
    
    return val;
}

- (NSString *)identifierString {
    
    return [NSString stringWithFormat:@"%@", @(self.uniqueID)];
}

@end
