//
//  HomePageViewModel.h
//  DL_MVVM
//
//  Created by robin on 7/27/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLBaseModel.h"
#import <AFNetworking/AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface HomePageViewModel : DLBaseModel

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) RACSignal *requestSignal;

- (RACSignal *)loadData;

@end
