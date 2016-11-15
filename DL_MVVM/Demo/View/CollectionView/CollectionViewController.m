//
//  CollectionViewController.m
//  DL_MVVM
//
//  Created by Daniel.Li on 09/11/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupCollectionView {
    
    UICollectionViewLayout *flowLayout = [[UICollectionViewLayout alloc] init];
    
}

- (UICollectionViewLayout *) flowLayout {
    
    if (_flowLayout) {
        UICollectionViewLayout *flowLayout = [[UICollectionViewLayout alloc] init];
    }
    return _flowLayout;
}

- (UICollectionView *) collectionView {
    
    if (_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
    [self.view addSubview:_collectionView];
    return _collectionView;
}

@end
