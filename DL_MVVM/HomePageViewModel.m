//
//  HomePageViewModel.m
//  DL_MVVM
//
//  Created by robin on 7/27/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "HomePageViewModel.h"

@implementation HomePageViewModel

- (AFHTTPSessionManager *)sessionManager {
    if (_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return  _sessionManager;
}

- (void)dealloc {
    [self.sessionManager invalidateSessionCancelingTasks:YES];
}

- (RACSignal *)loadData {
    
    if (_requestSignal) {
        _requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
        }];
    }
    return _requestSignal;
}

@end
