//
//  DLBaseViewModel.h
//  DL_MVVM
//
//  Created by Daniel.Li on 7/25/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "DLBaseModel.h"

@interface DLBaseViewModel : JSONModel

@property (nonatomic, strong) DLBaseModel *dataMode;

- (instancetype)initWithDataModel:(DLBaseModel *)dataModel;

- (NSString *)identifierString;

@end
