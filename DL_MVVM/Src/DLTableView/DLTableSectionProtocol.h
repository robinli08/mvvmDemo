//
//  DLTableSectionProtocol.h
//  DL_MVVM
//
//  Created by Daniel.Li on 7/25/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#ifndef DLTableSectionProtocol_h
#define DLTableSectionProtocol_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DLTableSectionProtocol <NSObject>

@required

@property (assign, nonatomic) NSUInteger index;

@optional

@property (copy, readwrite, nonatomic) NSString *headerTitle;
@property (copy, readwrite, nonatomic) NSString *footerTitle;
@property (assign, readwrite, nonatomic) CGFloat headerHeight;
@property (assign, readwrite, nonatomic) CGFloat footerHeight;
@property (copy, readwrite, nonatomic) NSString *indexTitle;

@end


#endif /* DLTableSectionProtocol_h */
