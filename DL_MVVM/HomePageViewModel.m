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


//{
//    
//    @weakify(self);
//    _requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        
//        @strongify(self);
//        
//        // 配置网络请求参数
//        NSDictionary *parameters = @{@"page": @(self.currentPage)};
//        
//        // 发起请求
//        NSURLSessionDataTask *task = [self.sessionManager POST:@"http://www.brighttj.com/api/index.php/api/article/articleList" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//            
//            // 将请求下来的字典->模型
//            NSArray *articleArray = responseObject[@"data"][@"articleList"];
//            for (NSDictionary *articleDictionary in articleArray) {
//                ArticleModel *articleModel = [ArticleModel objectWithKeyValues:articleDictionary];
//                // 根据模型，初始化cell的vm
//                HomePageCellViewModel *cellViewModel = [[HomePageCellViewModel alloc] initWithArticleModel:articleModel];
//                // 将cell的vm存入数组
//                [self.articleViewModels addObject:cellViewModel];
//            }
//            // 完成数据处理后，赋值给dataSource
//            self.dataSource = [self.articleViewModels copy];
//            
//            // 如果是刷新操作，则删除数据库中的旧数据
//            // 这里也可以采用存入部分新数据的方式，全部删除可能在效率方面不是很好
//            if (self.isRefresh) {
//                [self deleteData];
//            }
//            // 存入新数据
//            [self saveData];
//            
//            [subscriber sendNext:self.dataSource];
//            [subscriber sendCompleted];
//        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
//            
//            [subscriber sendError:error];
//            // 如果网络请求出错，则加载数据库中的旧数据
//            [self loadData];
//        }];
//        
//        // 在信号量作废时，取消网络氢气
//        return [RACDisposable disposableWithBlock:^{
//            
//            [task cancel];
//        }];
//    }];
//}


//if (!self.typesPOModel) {
//    if (!self.getReportTypesApi) {
//        self.getReportTypesApi = [[TTLiveRoomViolationServiceGetReportTypesApi alloc] init];
//    }
//    @weakify(self)
//    return [[[self.getReportTypesApi rac_request] map:^id(id value) {
//        @strongify(self)
//        self.typesPOModel = (TTLiveRoomReportTypesPOModel *)value;
//        NSArray *viewModelArray = [self.typesPOModel.types map:^id(TTLiveRoomReportTypePOModel *model) {
//            TTLReportRowViewModel *rowViewModel = [[TTLReportRowViewModel alloc] init];
//            rowViewModel.titleString = model.name;
//            rowViewModel.reportCodeType = model.code;
//            return rowViewModel;
//        }];
//        
//        [self removeAllViewModels];
//        [self addViewModelsFromArray:viewModelArray];
//        
//        return @(YES);
//    }] catch:^RACSignal *(NSError *error) {
//        return [RACSignal error:error];
//    }];
//} else {
//    NSArray *viewModelArray = [self.typesPOModel.types map:^id(TTLiveRoomReportTypePOModel *model) {
//        TTLReportRowViewModel *rowViewModel = [[TTLReportRowViewModel alloc] init];
//        rowViewModel.titleString = model.name;
//        rowViewModel.reportCodeType = model.code;
//        return rowViewModel;
//    }];
//    
//    [self removeAllViewModels];
//    [self addViewModelsFromArray:viewModelArray];
//    
//    return [RACSignal return:@(YES)];
//}


- (RACSignal *)loadData {
    
//    @weakify(self);
    if (_requestSignal) {
//        _requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//
//        }];
    }
    return _requestSignal;
}

@end
