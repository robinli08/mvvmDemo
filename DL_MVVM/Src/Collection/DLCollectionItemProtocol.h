//
//  Header.h
//  DL_MVVM
//
//  Created by Daniel.Li on 8/3/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DLCollectionItemProtocol <NSObject>

@required
@property (nonatomic, strong) NSIndexPath *indexPath;


@optional

@property (nonatomic, assign) CGSize itmeSize;
@property (nonatomic, assign) BOOL canMove;
@property (nonatomic, strong) NSString *itemIdentifier;


@end


