//
//  TestFooterViewController.m
//  DL_MVVM
//
//  Created by Daniel.Li on 15/11/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "TestFooterViewController.h"
#import "TestCollectionViewCell.h"

@interface TestFooterViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@end

@implementation TestFooterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupCollectionView {
    
    self.collectionView.collectionViewLayout = [self collectionLayout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
//    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[TestCollectionViewCell cellNib]
             forCellWithReuseIdentifier:[TestCollectionViewCell cellReuseIdentifier]];
    
}

- (void)refreshSubViews {
    
    [self.collectionView reloadData];
}

- (UICollectionViewFlowLayout *)collectionLayout {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10.f;
    layout.sectionInset = UIEdgeInsetsMake(0.f, 15.f, 15.f, 15.f);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return layout;
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(160, 145);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TestCollectionViewCell cellReuseIdentifier] forIndexPath:indexPath];
    return  cell;
    
}


@end
