//
//  DataInModulsDataModel.h
//  DL_MVVM
//
//  Created by robin on 7/27/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "BaseDataModel.h"

@interface DataInModulsDataModel : BaseDataModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *target;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSArray *dlist;

@end
