//
//  DLTableSection.h
//  DL_MVVM
//
//  Created by Daniel.Li on 7/25/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLBaseListViewModel.h"
#import "DLTableSectionProtocol.h"

@interface DLTableSection : DLBaseListViewModel

@property (assign, nonatomic) NSUInteger index;
@property (copy, readwrite, nonatomic) NSString *headerTitle;
@property (copy, readwrite, nonatomic) NSString *footerTitle;
@property (assign, readwrite, nonatomic) CGFloat headerHeight;
@property (assign, readwrite, nonatomic) CGFloat footerHeight;
@property (copy, readwrite, nonatomic) NSString *indexTitle;


@end
