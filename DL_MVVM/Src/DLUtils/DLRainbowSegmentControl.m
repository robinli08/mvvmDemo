//
//  DLRainbowSegmentControl.m
//  DL_MVVM
//
//  Created by Daniel.Li on 25/10/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLRainbowSegmentControl.h"
#import "DLRainbowView.h"

@interface DLRoundedBorderedLayer: CALayer

@end

@implementation DLRoundedBorderedLayer

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.borderColor = [UIColor colorWithWhite:1 alpha:1].CGColor;
    self.borderWidth = 1;
    self.masksToBounds = YES;
    
    return self;
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
//    self.cornerRadius = bounds.size.height / 2;
    self.cornerRadius = 5;
}

@end

#pragma mark - TTSegmentControlTitlesView

@interface DLSegmentControlTitlesView : UIView

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;

@end

@interface DLSegmentControlTitlesView ()

@property (nonatomic, copy) NSArray<UILabel *> *labelsArray;

@end

@implementation DLSegmentControlTitlesView

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles {
    self = [super initWithFrame:CGRectZero];
    if (!self) {
        return nil;
    }
    
    NSMutableArray *labels = [NSMutableArray new];
    for (NSString *title in titles) {
        UILabel *label = [UILabel new];
        label.text = title;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        [labels addObject:label];
        [self addSubview:label];
    }
    self.labelsArray = labels;
    
    self.backgroundColor = [UIColor clearColor];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat width = CGRectGetWidth(self.bounds) / self.labelsArray.count;
    CGFloat x = 0;
    for (UILabel *label in self.labelsArray) {
        label.frame = CGRectMake(x, 0, width, height);
        x += width;
    }
}

- (void)setTextColor:(UIColor *)textColor {
    if ([_textColor isEqual:textColor]) {
        return;
    }
    
    _textColor = textColor;
    
    for (UILabel *label in self.labelsArray) {
        label.textColor = _textColor;
    }
}

- (void)setFont:(UIFont *)font {
    if ([_font isEqual:font]) {
        return;
    }
    
    _font = font;
    
    for (UILabel *label in self.labelsArray) {
        label.font = _font;
    }
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    if (_textAlignment == textAlignment) {
        return;
    }
    
    _textAlignment = textAlignment;
    
    for (UILabel *label in self.labelsArray) {
        label.textAlignment = _textAlignment;
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self layoutIfNeeded];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    [self layoutIfNeeded];
}

@end

#pragma mark - TTSegmentControlKnobView

@interface DLSegmentControlKnobView : UIView

@property (nonatomic, strong) DLRainbowView *rainbowView;

@end

@implementation DLSegmentControlKnobView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    [self finishInit];
    
    return self;
}

- (void)finishInit {
    self.rainbowView = [[DLRainbowView alloc] initWithFrame:self.bounds];
    self.rainbowView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.rainbowView];
    
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    self.layer.masksToBounds = YES;
}

@end

#pragma mark - TTRainbowSegmentControl

@interface DLRainbowSegmentControl ()

@property (nonatomic, copy) NSArray<NSString *> *titles;
@property (nonatomic, copy) NSArray<UIView *> *separators;

@property (nonatomic, strong) DLSegmentControlTitlesView *normalTitlesView;
@property (nonatomic, strong) DLSegmentControlTitlesView *maskedTitlesView;
@property (nonatomic, strong) DLSegmentControlKnobView *knobView;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation DLRainbowSegmentControl

+ (Class)layerClass {
    return [DLRoundedBorderedLayer class];
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"frame"];
    [self removeObserver:self forKeyPath:@"knobView.frame"];
}

#pragma mark - Public methods

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    [self setSelectedIndex:selectedIndex animated:YES];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated {
    if (_selectedIndex == selectedIndex) {
        return;
    }
    
    if (selectedIndex < 0 || selectedIndex >= self.titles.count) {
        return;
    }
    
    _selectedIndex = selectedIndex;
    
    if (animated) {
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [self updateKnobViewAppearanceForIndex:_selectedIndex];
                         } completion:^(BOOL finished) {
                             if (finished) {
                                 [self sendActionsForControlEvents:UIControlEventValueChanged];
                             }
                         }];
    } else {
        [self updateKnobViewAppearanceForIndex:_selectedIndex];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    if (self.indexChangedBloc) {
        self.indexChangedBloc(_selectedIndex);
    }
}

- (void)updateTitle:(NSString *)title atIndex:(NSInteger)index {
    if (index < 0 || index >= self.titles.count) {
        return;
    }
    
    NSMutableArray *newTitles = [NSMutableArray arrayWithArray:self.titles];
    newTitles[index] = title;
    self.titles = newTitles;
    
    self.normalTitlesView.labelsArray[index].text = title;
    self.maskedTitlesView.labelsArray[index].text = title;
}

#pragma mark - Initializers

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles {
    self = [super initWithFrame:CGRectZero];
    if (!self) {
        return nil;
    }
    
    self.titles = titles;
    [self finishInit];
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    
    self.titles = [self.allTitles componentsSeparatedByString:@" "];
    [self finishInit];
    
    return self;
}

#pragma mark - Configurations

- (void)finishInit {
    // Layout
    self.normalTitlesView = [[DLSegmentControlTitlesView alloc] initWithTitles:self.titles];
    self.normalTitlesView.frame = self.bounds;
    self.normalTitlesView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.normalTitlesView];
    
    self.knobView = [DLSegmentControlKnobView new];
    self.knobView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.knobView.layer.borderWidth = 1;
    [self addSubview:self.knobView];
    
    self.maskedTitlesView = [[DLSegmentControlTitlesView alloc] initWithTitles:self.titles];
    self.knobView.rainbowView.layer.mask = self.maskedTitlesView.layer;
    
    NSMutableArray *separators = [NSMutableArray new];
    for (NSInteger index = 0; index < self.titles.count - 1; index++) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        [separators addObject:view];
    }
    self.separators = separators;
    
    // Gestures
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:self.tapGesture];
    
    // Observing
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"knobView.frame" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - Layout

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"frame"]) {
        self.maskedTitlesView.frame = self.bounds;
        [self updateKnobViewAppearanceForIndex:self.selectedIndex];
    } else if ([keyPath isEqualToString:@"knobView.frame"]) {
        CGRect frame = self.maskedTitlesView.frame;
        frame.origin.x = -self.knobView.frame.origin.x;
        self.maskedTitlesView.frame = frame;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)updateKnobViewAppearanceForIndex:(NSInteger)index {
    CGFloat width = CGRectGetWidth(self.bounds) / self.titles.count;
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat x = width * index;
    self.knobView.frame = CGRectMake(x, 0, width, height);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat width = CGRectGetWidth(self.bounds) / self.titles.count;
    CGFloat x = width - 0.5;
    for (UIView *separator in self.separators) {
        separator.frame = CGRectMake(x, 0, 1, height);
        x += width;
    }
}

#pragma mark - Gestures

- (void)handleTap:(UITapGestureRecognizer *)gesture {
    CGPoint location = [gesture locationInView:self];
    CGFloat width = CGRectGetWidth(self.bounds) / self.titles.count;
    NSInteger index = location.x / width;
    [self setSelectedIndex:index animated:YES];
}

@end
