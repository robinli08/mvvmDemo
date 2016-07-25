//
//  DLTableRow.h
//  DL_MVVM
//
//  Created by Daniel.Li on 7/25/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLBaseViewModel.h"
#import "DLTableRowProtocol.h"

@interface DLTableRow : DLBaseViewModel

@property (copy, readwrite, nonatomic) NSString *title;
@property (strong, readwrite, nonatomic) UIImage<Ignore> *image;
@property (copy, readwrite, nonatomic) NSString *detailLabelText;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) NSInteger rowHeight;
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, assign) BOOL canMove;
@property (nonatomic, strong) NSString *cellIdentifier;

@end
