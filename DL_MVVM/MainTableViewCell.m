//
//  MainTableViewCell.m
//  DL_MVVM
//
//  Created by Daniel.Li on 8/2/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)cellReuseIdentifier {
    return NSStringFromClass([self class]);
}

+ (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle bundleForClass:[self class]]];
}

@end
