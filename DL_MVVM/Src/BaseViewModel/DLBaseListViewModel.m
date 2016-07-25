//
//  DLBaseListViewModel.m
//  DL_MVVM
//
//  Created by Daniel.Li on 7/25/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLBaseListViewModel.h"
#import <ReactiveCocoa/NSObject+RACDescription.h>

@implementation DLListViewModelUpdateInfo

@end

@interface DLSubcriberWrap : NSObject

@property (nonatomic, weak) id<RACSubscriber> subscriber;

@end

@implementation DLSubcriberWrap

@end

@interface DLBaseListViewModel ()

@property (nonatomic, strong) NSMutableArray *subscriberList;
@property (nonatomic, assign) BOOL isBegin;
@property (nonatomic, strong) NSMutableArray *updateInfos;
@property (nonatomic, strong) NSMutableArray *viewModels;
@property (nonatomic, assign) NSInteger updateValue;

@end

@implementation DLBaseListViewModel

+ (BOOL)propertyIsIgnored:(NSString *)propertyName {
    
    if ([propertyName isEqualToString:@"subscriberList"] ||
        [propertyName isEqualToString:@"isBegin"] ||
        [propertyName isEqualToString:@"updateInfos"] ||
        [propertyName isEqualToString:@"updateValue"] ||
        [propertyName isEqualToString:@"enableUpdateSignal"] ||
        [propertyName isEqualToString:@"rac_ListUpdateSignal"]) {
        return YES;
    }
    return NO;
    
}

- (void)beginUpdates {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self beginUpdates];
        });
        return;
    }
    
    self.isBegin = YES;
    self.updateValue++;
}

- (void)endUpdates {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self endUpdates];
        });
        return;
    }
    
    if (self.isBegin) {
        self.updateValue--;
        if (self.updateValue <= 0) {
            self.updateValue = 0;
            self.isBegin = NO;
            if (self.updateInfos.count > 0) {
                [self notifyUpdate];
            }
        }
    }
}

- (void)notifyUpdate {
    NSArray *infos = [self.updateInfos copy];
    for (DLSubcriberWrap *wrap in [self.subscriberList copy]) {
        if (wrap.subscriber) {
            [wrap.subscriber sendNext:infos];
        }
    }
    [self.updateInfos removeAllObjects];
}

- (void)enqueueUpdateInfo:(DLListViewModelUpdateInfo *)info {
    if (self.enableUpdateSignal) {
        return;
    }
    if (!self.isBegin) {
        [self.updateInfos addObject:info];
        [self notifyUpdate];
    } else {
        [self.updateInfos addObject:info];
    }
}

- (DLSubcriberWrap *)addSubcriber:(id<RACSubscriber>)subscriber {
    if (subscriber) {
        DLSubcriberWrap *wrap = [[DLSubcriberWrap alloc] init];
        wrap.subscriber = subscriber;
        [self.subscriberList addObject:wrap];
        return wrap;
    }
    return nil;
}

- (void)removeSubscriber:(DLSubcriberWrap *)wrap {
    if (wrap) {
        [self.subscriberList removeObject:wrap];
    }
}

- (RACSignal *)rac_ListUpdateSignal {
    @weakify(self);
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        DLSubcriberWrap *wrap = [self addSubcriber:subscriber];
        [self.rac_deallocDisposable addDisposable:[RACDisposable disposableWithBlock:^{
            [subscriber sendCompleted];
        }]];
        
        return [RACDisposable disposableWithBlock:^{
            @strongify(self);
            [self removeSubscriber:wrap];
        }];
    }] setNameWithFormat:@"%@ rac_ListUpdateSignal",self.rac_description];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.viewModels = [[NSMutableArray alloc] init];
        self.subscriberList = [[NSMutableArray alloc] init];
        self.updateInfos = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithViweModels:(NSArray *)viewModels {
    self = [self init];
    
    if (self) {
        if (viewModels) {
            [self.viewModels addObjectsFromArray:viewModels];
        }
    }
    return self;
}

- (NSUInteger)countOfViewModels {
    return [self.viewModels count];
}

- (id)viewModelAtIndex:(NSInteger)index {
    
    if (index >= 0 && index < [self countOfViewModels]) {
       return self.viewModels[index];
    }
    return nil;
    
}

- (NSUInteger)indexOfViewModel:(id)anObject {
    
    if (anObject) {
        return [self.viewModels indexOfObject:anObject];
    }
    return NSNotFound;
}

- (void)addViewModel:(id)viewModel {
    
    if (viewModel) {
        if (![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addViewModel:viewModel];
            });
            return;
        }
        
        NSInteger index = [_viewModels count];
        [_viewModels addObject:viewModel];
        DLListViewModelUpdateInfo *info = [[DLListViewModelUpdateInfo alloc] init];
        info.type = DLListViewModelInsert;
        info.indexSet = [NSIndexSet indexSetWithIndex:index];
        [self enqueueUpdateInfo:info];
    }
}

- (void)insertViewModel:(id)viewModel atIndex:(NSUInteger)index {
    
    if (viewModel) {
        if (![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self insertViewModel:viewModel atIndex:index];
            });
            
            return ;
        }
        
        [_viewModels insertObject:viewModel atIndex:index];
        DLListViewModelUpdateInfo *info = [[DLListViewModelUpdateInfo alloc] init];
        info.type = DLListViewModelInsert;
        info.indexSet = [NSIndexSet indexSetWithIndex:index];
        [self enqueueUpdateInfo:info];
    }
    
}

- (void)removeLastViewModel {
    
    if ([_viewModels count] > 0) {
        if (![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self removeLastViewModel];
            });
            return;
        }
        NSUInteger count = [_viewModels count];
        [_viewModels removeLastObject];
        DLListViewModelUpdateInfo *info = [[DLListViewModelUpdateInfo alloc] init];
        info.type = DLListViewModelRemove;
        info.indexSet = [NSIndexSet indexSetWithIndex:count - 1];
        [self enqueueUpdateInfo:info];
    }
}

- (void)removeViewModelAtIndex:(NSUInteger)index {
    if (index < [_viewModels count]) {
        if (![NSThread isMainThread]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self removeViewModelAtIndex:index];
            });
            return;
        }
        
        [_viewModels removeObjectAtIndex:index];
        DLListViewModelUpdateInfo *info = [[DLListViewModelUpdateInfo alloc] init];
        info.type = DLListViewModelRemove;
        info.indexSet = [NSIndexSet indexSetWithIndex:index];
        [self enqueueUpdateInfo:info];
    }
}

- (void)replaceViewModelAtIndex:(NSUInteger)index withViewModel:(id)anObject {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self replaceViewModelAtIndex:index withViewModel:anObject];
        });
        return;
    }
    
    if (index < [_viewModels count] && anObject) {
        [_viewModels replaceObjectAtIndex:index withObject:anObject];
        DLListViewModelUpdateInfo *info = [[DLListViewModelUpdateInfo alloc] init];
        info.type = DLListViewModelReplace;
        info.indexSet = [NSIndexSet indexSetWithIndex:index];
        [self enqueueUpdateInfo:info];
    }
}

- (void)addViewModelsFromArray:(NSArray *)otherArray {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addViewModelsFromArray:otherArray];
        });
        return;
    }
    
    if (otherArray.count > 0) {
        NSUInteger index = [_viewModels count];
        [_viewModels addObjectsFromArray:otherArray];
        DLListViewModelUpdateInfo *info = [[DLListViewModelUpdateInfo alloc] init];
        if (index == 0) {
            info.type = DLListViewModelResetAll;
        } else {
            info.type = DLListViewModelInsert;
            
            NSMutableIndexSet *mutableIndexSet = [[NSMutableIndexSet alloc] initWithIndexesInRange:NSMakeRange(index, otherArray.count)];
            info.indexSet = mutableIndexSet;
        }
        [self enqueueUpdateInfo:info];
    }
}

- (void)exchangeViewModelAtIndex:(NSUInteger)idx1 withViewModelAtIndex:(NSUInteger)idx2 {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self exchangeViewModelAtIndex:idx1 withViewModelAtIndex:idx2];
        });
        return;
    }
    
    if (idx1 < [_viewModels count] && idx2 < [_viewModels count]) {
        [_viewModels exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
        DLListViewModelUpdateInfo *info = [[DLListViewModelUpdateInfo alloc] init];
        info.type = DLListViewModelReplace;
        NSMutableIndexSet *mutableIndexSet = [[NSMutableIndexSet alloc] initWithIndex:idx1];
        [mutableIndexSet addIndex:idx2];
        info.indexSet = mutableIndexSet;
        
        [self enqueueUpdateInfo:info];
    }
}

- (void)removeAllViewModels {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeAllViewModels];
        });
        return ;
    }
    
    if ([_viewModels count] > 0) {
        NSUInteger count = _viewModels.count;
        [_viewModels removeAllObjects];
        DLListViewModelUpdateInfo *info = [[DLListViewModelUpdateInfo alloc] init];
        info.type = DLListViewModelRemove;
        NSMutableIndexSet *mutalbeIndexSet = [[NSMutableIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, count)];
        info.indexSet = mutalbeIndexSet;
        [self enqueueUpdateInfo:info];
    }
}

- (void)removeViewModel:(id)anObject inRange:(NSRange)range {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeViewModel:anObject inRange:range];
        });
        return;
    }
    
    if (_viewModels.count > 0) {
        NSUInteger index = [_viewModels indexOfObject:anObject inRange:range];
        
        if (index != NSNotFound) {
            [_viewModels removeObject:anObject inRange:range];
            DLListViewModelUpdateInfo *info = [[DLListViewModelUpdateInfo alloc] init];
            info.type = DLListViewModelRemove;
            info.indexSet = [NSIndexSet indexSetWithIndex:index];
            [self enqueueUpdateInfo:info];
        }
    }
}

- (void)removeViewModel:(id)anObject {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeViewModel:anObject];
        });
        return;
    }
    
    if ([_viewModels count] > 0) {
        NSUInteger index = [_viewModels indexOfObject:anObject];
        if (index != NSNotFound) {
            [_viewModels removeObject:anObject];
            DLListViewModelUpdateInfo *info = [[DLListViewModelUpdateInfo alloc] init];
            info.type = DLListViewModelRemove;
            info.indexSet = [NSIndexSet indexSetWithIndex:index];
            [self enqueueUpdateInfo:info];
        }
    }
}

- (void)removeViewModelsInArray:(NSArray *)otherArray {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeViewModelsInArray:otherArray];
        });
        return;
    }
    
    if (_viewModels.count > 0 && otherArray.count > 0) {
        NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
        for (id obj in otherArray) {
            NSUInteger index = [_viewModels indexOfObject:obj];
            if (index != NSNotFound) {
                [indexSet addIndex:index];
            }
        }
        
        [_viewModels removeObjectsInArray:otherArray];
        DLListViewModelUpdateInfo *info = [[DLListViewModelUpdateInfo alloc] init];
        info.type = DLListViewModelRemove;
        info.indexSet = indexSet;
        [self enqueueUpdateInfo:info];
    }
}

- (void)removeViewModelsInRange:(NSRange)range{
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeViewModelsInRange:range];
        });
        return;
    }
    if (_viewModels.count > 0) {
        [_viewModels removeObjectsInRange:range];
        DLListViewModelUpdateInfo *info = [[DLListViewModelUpdateInfo alloc] init];
        info.type = DLListViewModelRemove;
        info.indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self enqueueUpdateInfo:info];
    }
}

- (void)setViewModelsWithArray:(NSArray*)viewModels{
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setViewModelsWithArray:viewModels];
        });
        return;
    }
    if (viewModels) {
        self.viewModels = [[NSMutableArray alloc] initWithArray:viewModels];
    }
    else{
        self.viewModels = [[NSMutableArray alloc] init];
    }
    DLListViewModelUpdateInfo *info = [[DLListViewModelUpdateInfo alloc] init];
    info.type = DLListViewModelResetAll;
    [self enqueueUpdateInfo:info];
}


@end
