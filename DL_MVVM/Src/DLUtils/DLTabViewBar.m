//
//  DLTabViewBar.m
//  DL_MVVM
//
//  Created by Daniel.Li on 19/11/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLTabViewBar.h"

@interface DLTabViewBar () {
    UIView      *_backMaskView;
    UIImageView *_backImageView;
    UIView      *_indicatorView;
    UIView      *_seperatorView;
    NSInteger   _curIndex;
}

@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, strong) NSMutableDictionary *widths;

@end

@implementation DLTabViewBar

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:14.f];
        self.clipsToBounds = YES;
        
        self.widths = [NSMutableDictionary dictionary];
        
        _backMaskView = [[UIView alloc] initWithFrame:self.bounds];
        _backMaskView.backgroundColor = [UIColor clearColor];
        _backMaskView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_backMaskView];
        
        CGSize size = [UIScreen mainScreen].bounds.size;
        CGRect rect = CGRectMake(0, - 64, MIN(size.width, size.height), MAX(size.width, size.height));
        _backImageView = [[UIImageView alloc] initWithFrame:rect];
        _backImageView.image = [UIImage imageNamed:@"view-background.jpg"];
        [self addSubview:_backImageView];
        
        _indicatorView = [[UIView alloc] initWithFrame:CGRectZero];
        _indicatorView.backgroundColor = [UIColor redColor];
        [self addSubview:_indicatorView];
        
        _seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 0.5, CGRectGetWidth(self.bounds), 0.5)];
        _seperatorView.backgroundColor = [UIColor greenColor];
        [self addSubview:_seperatorView];
        
        return self;
    }
    return nil;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backMaskView.backgroundColor = backgroundColor;
    _backImageView.hidden = YES;
}

#pragma mark -
- (void)tabScrollXPercent:(CGFloat)percent {
    percent = MAX(0, percent);
    percent = MIN(1, percent);
    [self updateIndicatorFrameWithPercent:percent];
}

- (void)tabDidScrollToIndex:(NSInteger)index {
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        btn.enabled = YES;
    }];
    _curIndex = index;
    UIButton *curBtn = [self buttonAtIndex:_curIndex];
    curBtn.enabled = NO;
    
    CGFloat percent = (CGFloat)index / MAX(1, self.buttons.count - 1);
    [self updateIndicatorFrameWithPercent:percent];
}

- (void)updateIndicatorFrameWithPercent:(CGFloat)percent {
    NSInteger index = (NSInteger)((self.buttons.count - 1) * percent);
    
    CGFloat averageWidth = CGRectGetWidth(self.frame) / self.buttons.count;
    CGFloat preWidth = [self.widths[@(index)] floatValue];
    if (preWidth == 0) {
        preWidth = averageWidth;
    }
    
    if (index == self.buttons.count - 1) {
        CGRect rect = _indicatorView.frame;
        rect.size.width = preWidth;
        rect.origin.x = CGRectGetWidth(self.bounds) - averageWidth / 2.0f - preWidth / 2.0f;
        _indicatorView.frame = rect;
        return;
    }
    
    CGFloat nextWidth = [self.widths[@(index+1)] floatValue];
    if (nextWidth == 0) {
        nextWidth = averageWidth;
    }
    
    CGFloat prePercent = (CGFloat)index / MAX(1, self.buttons.count - 1);
    CGFloat nextPercent = (CGFloat)(index + 1) / MAX(1, self.buttons.count - 1);
    
    CGFloat width = preWidth + (percent - prePercent) / (nextPercent - prePercent) * (nextWidth - preWidth);
    CGFloat centerX = averageWidth * (0.5 + (self.buttons.count - 1) * percent);
    
    CGRect rect = _indicatorView.frame;
    rect.origin.x = centerX - width / 2.0f;
    rect.size.width = width;
    _indicatorView.frame = rect;
}

#pragma mark -
- (void)reloadTabIndex:(NSInteger)index {
    if (index >= self.buttons.count) {
        return;
    }
    
    UIButton *btn = [self.buttons objectAtIndex:index];
    id title = [self.delegate tabViewBar:self titleForIndex:index];
    if ([title isKindOfClass:[NSString class]]) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateDisabled];
    } else {
        NSMutableAttributedString *normalAttString = [[NSMutableAttributedString alloc] initWithAttributedString:title];
        NSRange range = NSMakeRange(0, normalAttString.string.length);
        [normalAttString addAttribute:NSForegroundColorAttributeName value:self.normalColor range:range];
        [btn setAttributedTitle:normalAttString forState:UIControlStateNormal];
        
        NSMutableAttributedString *highlightedAttString = [[NSMutableAttributedString alloc] initWithAttributedString:title];
        range = NSMakeRange(0, highlightedAttString.string.length);
        [highlightedAttString addAttribute:NSForegroundColorAttributeName value:self.highlightedColor range:range];
        [btn setAttributedTitle:highlightedAttString forState:UIControlStateDisabled];
    }
    
    NSInteger width = [btn.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, self.frame.size.width)].width;
    [self.widths setObject:@(width) forKey:@(index)];
    CGFloat percent = (CGFloat)_curIndex / MAX(1.0, self.buttons.count - 1);
    [self updateIndicatorFrameWithPercent:percent];
}

- (void)reloadTabBar {
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        [btn removeFromSuperview];
    }];
    NSInteger count = [self.delegate numberOfTabForTabViewBar:self];
    CGFloat cellWidth = CGRectGetWidth(self.bounds) / count;
    _indicatorView.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-2, cellWidth, 2);
    NSMutableArray *newBtns = [NSMutableArray arrayWithCapacity:count];
    for (u_int8_t index = 0; index < count; index++) {
        UIButton *btn = [self createButton];
        btn.tag = index;
        id title = [self.delegate tabViewBar:self titleForIndex:index];
        if ([title isKindOfClass:[NSString class]]) {
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitle:title forState:UIControlStateDisabled];
        } else {
            NSMutableAttributedString *normalAttString = [[NSMutableAttributedString alloc] initWithAttributedString:title];
            NSRange range = NSMakeRange(0, normalAttString.string.length);
            [normalAttString addAttribute:NSForegroundColorAttributeName value:self.normalColor range:range];
            [btn setAttributedTitle:normalAttString forState:UIControlStateNormal];
            
            NSMutableAttributedString *highlightedAttString = [[NSMutableAttributedString alloc] initWithAttributedString:title];
            range = NSMakeRange(0, highlightedAttString.string.length);
            [highlightedAttString addAttribute:NSForegroundColorAttributeName value:self.highlightedColor range:range];
            [btn setAttributedTitle:highlightedAttString forState:UIControlStateDisabled];
        }
        btn.frame = CGRectMake(cellWidth * index, 0, cellWidth, CGRectGetHeight(self.bounds));
        [self addSubview:btn];
        [newBtns addObject:btn];
        
        NSInteger width = [btn.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, self.frame.size.width)].width;
        [self.widths setObject:@(width) forKey:@(index)];
    }
    self.buttons = newBtns;
    if (self.buttons.count < 1) {
        return;
    }
    [self tabDidScrollToIndex:_curIndex];
}

- (UIButton *)createButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = self.font;
    [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
    [btn setTitleColor:self.highlightedColor forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (IBAction)onBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tabViewBar:didSelectIndex:)]) {
        [self.delegate tabViewBar:self didSelectIndex:sender.tag];
    }
}

- (UIColor *)normalColor {
    if (!_normalColor) {
        _normalColor = [UIColor grayColor];
    }
    return _normalColor;
}

- (UIColor *)highlightedColor {
    if (!_highlightedColor) {
        _highlightedColor = [UIColor yellowColor];
    }
    return _highlightedColor;
}

- (UIButton *)buttonAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.buttons.count) {
        return nil;
    }
    return self.buttons[index];
}


@end
