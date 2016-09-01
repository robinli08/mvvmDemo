//
//  DLCollectionViewSectionProtocol.h
//  DL_MVVM
//
//  Created by Daniel.Li on 9/1/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#ifndef DLCollectionViewSectionProtocol_h
#define DLCollectionViewSectionProtocol_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DLCollectionViewSectionProtocol <NSObject>

@required
/**
 Section index in UICollectionView.
 */
@property (assign, nonatomic) NSUInteger index;

@optional

@property (nonatomic, assign) UIEdgeInsets sectionInset;
@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
@property (nonatomic, assign) CGSize referenceSizeForHeader;
@property (nonatomic, assign) CGSize referenceSizeForFooter;


@end

#endif /* DLCollectionViewSectionProtocol_h */
