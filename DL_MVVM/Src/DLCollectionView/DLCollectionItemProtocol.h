//
//  DLCollectionItemProtocol.h
//  DL_MVVM
//
//  Created by Daniel.Li on 9/1/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#ifndef DLCollectionItemProtocol_h
#define DLCollectionItemProtocol_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DLCollectionItemProtocol <NSObject>

@required
@property (nonatomic, strong) NSIndexPath *indexPath;

@optional
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) BOOL canMove;
@property (nonatomic, strong) NSString *itemIdentifier;


@end


#endif /* DLCollectionItemProtocol_h */
