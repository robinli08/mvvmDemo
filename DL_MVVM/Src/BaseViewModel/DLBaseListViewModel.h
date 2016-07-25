//
//  DLBaseListViewModel.h
//  DL_MVVM
//
//  Created by Daniel.Li on 7/25/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DLBaseViewModel.h"

typedef NS_ENUM(NSUInteger, DLListViewModelUpdateType) {
    DLListViewModelInsert = 0,
    DLListViewModelReplace,
    DLListViewModelRemove,
    DLListViewModelResetAll
};

@interface DLListViewModelUpdateInfo : NSObject

@property (nonatomic, assign) DLListViewModelUpdateType type;
@property (nonatomic, strong) NSIndexSet *indexSet;

@end

@interface DLBaseListViewModel : JSONModel

@property (nonatomic, assign) BOOL enableUpdateSignal;
@property (nonatomic, strong) RACSignal<Ignore> *rac_ListUpdateSignal;

- (instancetype)initWithViweModels:(NSArray *)viewModels;
- (NSUInteger)countOfViewModels;
- (id)viewModelAtIndex:(NSInteger)index;
- (NSUInteger)indexOfViewModel:(id)anObject;

- (void)beginUpdates;
- (void)endUpdates;

- (void)addViewModel:(id)viewModel;
- (void)insertViewModel:(id)viewModel atIndex:(NSUInteger)index;
- (void)removeLastViewModel;
- (void)removeViewModelAtIndex:(NSUInteger)index;
- (void)replaceViewModelAtIndex:(NSUInteger)index withViewModel:(id)anObject;

- (void)addViewModelsFromArray:(NSArray *)otherArray;
- (void)exchangeViewModelAtIndex:(NSUInteger)idx1 withViewModelAtIndex:(NSUInteger)idx2;
- (void)removeAllViewModels;
- (void)removeViewModel:(id)anObject inRange:(NSRange)range;
- (void)removeViewModel:(id)anObject;
- (void)removeViewModelsInArray:(NSArray *)otherArray;
- (void)removeViewModelsInRange:(NSRange)range;
- (void)setViewModelsWithArray:(NSArray *)viewModels;

@end
