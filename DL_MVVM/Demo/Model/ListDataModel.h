//
//  ListDataModel.h
//  DL_MVVM
//
//  Created by Daniel.Li on 8/4/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "BaseDataModel.h"
#import "ProductDataModel.h"

@interface ListDataModel : BaseDataModel

@property (nonatomic, strong) NSArray<ProductDataModel> *lists;

@end
