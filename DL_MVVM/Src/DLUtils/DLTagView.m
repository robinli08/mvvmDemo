//
//  DLTagView.m
//  DL_MVVM
//
//  Created by Daniel.Li on 8/15/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLTagView.h"
#import "NSString+DL_StringUtil.h"
#import "UIView+HXUtility.h"

@interface DLTagView ()

@property (nonatomic, assign) BOOL isSetup;
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation DLTagView

#pragma mark ------------------ 初始化方法 --------------------

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.isSetup = NO;
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.isSetup = NO;
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    
    if (self.isSetup) {
        return;
    }
    
    self.isSetup = YES;
    
    self.backgroundColor = [UIColor clearColor];
    self.textFont = [UIFont systemFontOfSize:16.f];
    self.textColor = [UIColor blackColor];
    
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.numberOfLines = 1;
    [self addSubview:self.textLabel];
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 2;
}

- (void)setText:(NSString *)text {
    
    self.textLabel.text = text;
    self.textLabel.textColor = self.textColor;
    self.textLabel.font = self.textFont;
    CGSize textSize = [text dl_sizeWithFont:self.textLabel.font];
    self.textLabel.frame = CGRectMake(self.edgeInsets.left, self.edgeInsets.top, textSize.width, textSize.height);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, textSize.width + self.edgeInsets.right + self.edgeInsets.left, textSize.height + self.edgeInsets.bottom + self.edgeInsets.top);
}

- (void)setBoardColor:(UIColor *)boardColor {
    
    self.layer.borderColor = self.borderColor.CGColor;
    
}

@end
