//
//  CollectionReusableBaseView.m
//  DL_MVVM
//
//  Created by Daniel.Li on 09/11/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "CollectionReusableBaseView.h"

@implementation CollectionReusableBaseView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+ (NSString *)reusableViewIdentifier {
    
    return NSStringFromClass([self class]);
}

+ (UINib *)reusableViewNib {
    
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle bundleForClass:[self class]]];
    
}

@end
