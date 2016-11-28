//
//  TestCollectionViewCell.h
//  DL_MVVM
//
//  Created by Daniel.Li on 15/11/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestCollectionViewCell : UICollectionViewCell

+ (UINib *)cellNib;

+ (NSString *)cellReuseIdentifier;

@end
