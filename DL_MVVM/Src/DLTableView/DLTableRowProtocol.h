//
//  DLTableRowProtocol.h
//  DL_MVVM
//
//  Created by Daniel.Li on 7/25/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#ifndef DLTableRowProtocol_h
#define DLTableRowProtocol_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol DLTableRowProtocol <NSObject>

@required
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, assign) NSInteger rowHeight;

@optional
@property (copy, readwrite, nonatomic) NSString *title;
@property (strong, readwrite, nonatomic) UIImage *image;
@property (copy, readwrite, nonatomic) NSString *detailLabelText;
@property (nonatomic, assign) BOOL canMove;
@property (nonatomic, strong) NSString *cellIdentifier;

@end


#endif /* DLTableRowProtocol_h */
