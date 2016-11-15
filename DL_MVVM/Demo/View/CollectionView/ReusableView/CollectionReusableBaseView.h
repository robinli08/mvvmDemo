//
//  CollectionReusableBaseView.h
//  DL_MVVM
//
//  Created by Daniel.Li on 09/11/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionReusableBaseView : UICollectionReusableView

+ (NSString *)reusableViewIdentifier;
+ (UINib *)reusableViewNib;

@end
