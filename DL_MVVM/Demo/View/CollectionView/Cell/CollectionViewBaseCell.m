//
//  CollectionViewBaseCell.m
//  DL_MVVM
//
//  Created by Daniel.Li on 09/11/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "CollectionViewBaseCell.h"

@implementation CollectionViewBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+ (UINib *)collectionCellNib {
    
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle bundleForClass:[self class]]];
    
}

+ (NSString *)collectionReuseIdentifier {
    
    return NSStringFromClass([self class]);
}

@end
