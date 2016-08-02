//
//  HomePageViewModel.m
//  DL_MVVM
//
//  Created by robin on 7/27/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "HomePageViewModel.h"
#import "ProductDataModel.h"
#import <Funcussion/NSArray+Funcussion.h>
#import "ModulesDataModel.h"
#import "HomepageRowViewModel.h"

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
    
//    @weakify(self);
        _requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
//        @strongify(self);
            NSString *path = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
            NSData *data = [NSData dataWithContentsOfFile:path options:0 error: nil];
            
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: nil];
            
            NSError *error = nil;
            
            ProductDataModel *dataModel = [[ProductDataModel alloc] initWithDictionary:dictionary error:&error];
            
            NSLog(@"%@",error);
            
            NSArray *viewModelArray = [dataModel.modules map:^id(ModulesDataModel *obj) {
                
                HomepageRowViewModel *rowViewModel = [[HomepageRowViewModel alloc] init];
                rowViewModel.title = obj.mid;
                rowViewModel.detailLabelText = obj.tid;
                return rowViewModel;
            }];
            
            [self addViewModelsFromArray:viewModelArray];
            
            [subscriber sendNext:dataModel];
            [subscriber sendCompleted];
            
            
             return [RACDisposable disposableWithBlock:^{
                
            }];

        }];
    
    return _requestSignal;
}

@end
