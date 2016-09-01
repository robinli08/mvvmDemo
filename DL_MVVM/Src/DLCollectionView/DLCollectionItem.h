//
//  DLCollectionItem.h
//  DL_MVVM
//
//  Created by Daniel.Li on 9/1/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLBaseViewModel.h"
#import "DLCollectionItemProtocol.h"
#import "DLCollectionSectionProtocol.h"


@interface DLCollectionItem : DLBaseViewModel

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) BOOL canMove;
@property (nonatomic, strong) NSString *itemIdentifier;

@end
