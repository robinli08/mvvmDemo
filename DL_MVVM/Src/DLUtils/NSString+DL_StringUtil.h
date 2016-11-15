//
//  NSString+DL_StringUtil.h
//  DL_MVVM
//
//  Created by Daniel.Li on 8/15/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (DL_StringUtil)

- (CGSize)dl_sizeWithFont:(UIFont *)font;
- (CGSize)dl_sizewithfont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)dl_sizeWithAttributes:(NSDictionary *)attributes constrainedToSize:(CGSize)size;
@end
