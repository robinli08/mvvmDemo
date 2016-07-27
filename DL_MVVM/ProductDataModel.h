//
//  ProductDataModel.h
//  DL_MVVM
//
//  Created by robin on 7/27/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "BaseDataModel.h"
#import "DataInModulsDataModel.h"

@interface ProductDataModel : BaseDataModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray<DataInModulsDataModel*> *modules;

@end
