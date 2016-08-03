//
//  DLCollectionItem.h
//  DL_MVVM
//
//  Created by Daniel.Li on 8/3/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLBaseViewModel.h"
#import "DLCollectionItemProtocol.h"

@interface DLCollectionItem : DLBaseViewModel <DLCollectionItemProtocol>

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) BOOL canMove;
@property (nonatomic, strong) NSString *itemIdentifier;


@end
