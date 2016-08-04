//
//  ModulesDataModel.h
//  DL_MVVM
//
//  Created by robin on 7/27/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "BaseDataModel.h"
#import "DataInModulsDataModel.h"

@protocol ModulesDataModel <NSObject>

@end


@interface ModulesDataModel : BaseDataModel

@property (nonatomic, strong) NSString *mid;
@property (nonatomic, strong) NSString *tid;
@property (nonatomic, strong) DataInModulsDataModel *data;

@end
