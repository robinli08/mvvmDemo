//
//  DLCollectionViewSection.h
//  DL_MVVM
//
//  Created by Daniel.Li on 9/1/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLBaseListViewModel.h"
#import "DLCollectionSectionProtocol.h"


@interface DLCollectionViewSection : DLBaseListViewModel

/**
 Section index in UICollectionView.
 */
@property (assign, nonatomic) NSUInteger index;

@property (nonatomic, assign) UIEdgeInsets sectionInset;
@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
@property (nonatomic, assign) CGSize referenceSizeForHeader;
@property (nonatomic, assign) CGSize referenceSizeForFooter;

@end
