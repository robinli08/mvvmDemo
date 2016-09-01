//
//  DLAutoScrollLabel.m
//  DL_MVVM
//
//  Created by Daniel.Li on 8/23/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLAutoScrollLabel.h"
#import <CAAnimationBlocks/CAAnimation+Blocks.h>
#import "UIView+HXUtility.h"

#define kMaxLabelCount 2
#define kDefaultScrollSpeed 30.f
#define kDefaultPauseInterval 1.5f
#define kDefaultLabelSpacing 20
#define kDefaultFadeLength 7.f

#define GENERATE_SETTER(PROPERTY, TYPE, SETTER, UPDATER) \
- (void)SETTER:(TYPE)PROPERTY { \
if (_##PROPERTY != PROPERTY) { \
_##PROPERTY = PROPERTY; \
UPDATER \
[self setNeedsLayout]; \
} \
}


@interface DLAutoScrollLabel ()

@property (nonatomic, strong) NSArray *labelsArray;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, readwrite) BOOL scrolling;
@property (nonatomic, strong) NSTimer *animationTimer;

@property (nonatomic, assign,readonly) BOOL shouldAutoScroll;

@end

@implementation DLAutoScrollLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _scrollSpeed = kDefaultScrollSpeed;
    _pauseInterval = kDefaultPauseInterval;
    _labelSpacing = kDefaultLabelSpacing;
    _fadeLength = kDefaultFadeLength;
    
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    
    UILabel *mainLabel = [UILabel new];
    mainLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:mainLabel];
    UILabel *shadowLabel = [UILabel new];
    shadowLabel.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:shadowLabel];
    self.labelsArray = @[mainLabel, shadowLabel];
    
    _scrollEnabled = YES;
}

#pragma mark - Overridden properties

#define APPLY_TO_LABELS(property, value) \
[self.labelsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) { \
UILabel *label = obj; \
label.property = value; \
}];

#define MAIN_LABEL  ((UILabel *)self.labelsArray[0])

- (BOOL)shouldAutoScroll {
    return self.scrollEnabled && self.superview;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.scrollEnabled = NO;
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (void)setFrame:(CGRect)frame {
    if (CGRectEqualToRect(self.frame, frame)) {
        return;
    }
    
    [super setFrame:frame];
    [self updateLabels];
}

- (void)setScrollSpeed:(CGFloat)scrollSpeed {
    if (_scrollSpeed == scrollSpeed) {
        return;
    }
    
    _scrollSpeed = scrollSpeed;
    [self scrollLabelIfNeeded];
}

- (void)setPauseInterval:(NSTimeInterval)pauseInterval {
    if (_pauseInterval == pauseInterval) {
        return;
    }
    
    _pauseInterval = pauseInterval;
    [self scrollLabelIfNeeded];
}

- (void)setLabelSpacing:(NSInteger)labelSpacing {
    if (_labelSpacing == labelSpacing) {
        return;
    }
    
    _labelSpacing = labelSpacing;
    [self updateLabels];
}

- (void)setFadeLength:(CGFloat)fadeLength {
    if (_fadeLength == fadeLength) {
        return;
    }
    
    _fadeLength = fadeLength;
    [self updateMaskLayerWithFade:NO];
}

- (NSString *)text {
    return MAIN_LABEL.text;
}

- (void)setText:(NSString *)text {
    if ([MAIN_LABEL.text isEqualToString:text]) {
        return;
    }
    
    APPLY_TO_LABELS(text, text);
    [self updateLabels];
}

- (UIFont *)font {
    return MAIN_LABEL.font;
}

- (void)setFont:(UIFont *)font {
    if ([MAIN_LABEL.font isEqual:font]) {
        return;
    }
    
    APPLY_TO_LABELS(font, font);
    [self updateLabels];
}

- (UIColor *)textColor {
    return MAIN_LABEL.textColor;
}

- (void)setTextColor:(UIColor *)textColor {
    APPLY_TO_LABELS(textColor, textColor);
}

- (UIColor *)shadowColor {
    return MAIN_LABEL.shadowColor;
}

- (void)setShadowColor:(UIColor *)shadowColor {
    APPLY_TO_LABELS(shadowColor, shadowColor);
}

- (CGSize)shadowOffset {
    return MAIN_LABEL.shadowOffset;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    APPLY_TO_LABELS(shadowOffset, shadowOffset);
}

- (DLTextAligment)textAlignment {
    return (DLTextAligment)MAIN_LABEL.textAlignment;
}

- (void)setTextAlignment:(DLTextAligment)textAlignment {
    if (textAlignment > 2 &&
        [UIDevice currentDevice].systemVersion.floatValue < 6.0) {
        textAlignment = DLTextAligmentLeft;
    }
    APPLY_TO_LABELS(textAlignment, (NSInteger)textAlignment);
}

- (NSAttributedString *)attributedText {
    return MAIN_LABEL.attributedText;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    if ([MAIN_LABEL.attributedText isEqualToAttributedString:attributedText]) {
        return;
    }
    
    APPLY_TO_LABELS(attributedText, attributedText);
    [self updateLabels];
}

- (UIColor *)highlightedTextColor {
    return MAIN_LABEL.highlightedTextColor;
}

- (void)setHighlightedTextColor:(UIColor *)highlightedTextColor {
    APPLY_TO_LABELS(highlightedTextColor, highlightedTextColor);
}

- (BOOL)isHighlighted {
    return [MAIN_LABEL isHighlighted];
}

- (void)setHighlighted:(BOOL)highlighted {
    if (MAIN_LABEL.highlighted == highlighted) {
        return;
    }
    
    APPLY_TO_LABELS(highlighted, highlighted);
    [self updateLabels];
    
    if (self.highlightedDidChangeCallBlock)
    {
        self.highlightedDidChangeCallBlock();
    }
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    if (_scrollEnabled != scrollEnabled) {
        _scrollEnabled = scrollEnabled;
        if (_scrollEnabled) {
            [self scrollLabelIfNeeded];
        }
        else {
            [self disableTimer];
        }
    }
}

#pragma mark - Notifications

- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollLabelIfNeeded)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(scrollLabelIfNeeded)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(disableTimer)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

#pragma mark -

- (void)resetTimer {
    CGFloat labelWidth = CGRectGetWidth(MAIN_LABEL.bounds);
    NSTimeInterval duration = (labelWidth + self.labelSpacing) / self.scrollSpeed + self.pauseInterval;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self disableTimer];
        
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:duration
                                                               target:self
                                                             selector:@selector(animateLabels)
                                                             userInfo:nil repeats:YES];
        [self.animationTimer fire];
    });
}

- (void)disableTimer {
    [self.scrollView.layer removeAllAnimations];
    self.layer.mask = nil;
    [self.animationTimer invalidate];
    self.animationTimer = nil;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        [self addNotifications];
        [self scrollLabelIfNeeded];
    } else {
        [self disableTimer];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void)enableShadow {
    self.scrolling = YES;
    [self updateMaskLayerWithFade:YES];
}

- (void)scrollLabelIfNeeded {
    if (!self.shouldAutoScroll || !self.text.length) {
        [self disableTimer];
        return;
    }
    
    CGFloat labelWidth = CGRectGetWidth(MAIN_LABEL.bounds);
    if (labelWidth <= CGRectGetWidth(self.bounds)) {
        _scrollEnabled = NO;
        [self disableTimer];
        return;
    }
    
    [self resetTimer];
}

- (void)animateLabels {
    CGFloat labelWidth = CGRectGetWidth(MAIN_LABEL.bounds);
    if (labelWidth <= CGRectGetWidth(self.bounds)) {
        _scrollEnabled = NO;
        [self disableTimer];
        return;
    }
    
    // Add the left shadow after delay
    [self performSelector:@selector(enableShadow) withObject:nil afterDelay:self.pauseInterval];
    
    // animate the scrolling
    NSTimeInterval duration = (labelWidth + self.labelSpacing) / self.scrollSpeed;
    
    CABasicAnimation *positionXAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    positionXAnimation.fromValue = @(self.scrollView.layer.position.x);
    positionXAnimation.toValue = @(self.scrollView.layer.position.x - (labelWidth + self.labelSpacing));
    positionXAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    positionXAnimation.duration = duration;
    positionXAnimation.beginTime = [self.scrollView.layer convertTime:CACurrentMediaTime() fromLayer:nil] + self.pauseInterval;
    positionXAnimation.completion = ^(BOOL finish) {
        _scrolling = NO;
        [self updateMaskLayerWithFade:NO];
    };
    [self.scrollView.layer addAnimation:positionXAnimation forKey:positionXAnimation.keyPath];
}

- (void)updateLabels {
    [self disableTimer];
    
    __block float offset = 0;
    
    // calculate the label size
    CGSize labelSize = CGSizeZero;
    UILabel *label = MAIN_LABEL;
    if (label) {
        
        NSString *text = label.text;
        UIFont *font = label.font;
        if (text && font) {
            
            CGRect rect = [MAIN_LABEL.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(self.bounds))
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:@{NSFontAttributeName:MAIN_LABEL.font}
                                                        context:nil];
            
            labelSize = rect.size;
        }
    }
    
    for (UILabel *label in self.labelsArray) {
        CGRect frame = label.frame;
        frame.origin.x = offset;
        frame.size.height = CGRectGetHeight(self.bounds);
        frame.size.width = labelSize.width + 2.f /*Magic number*/;
        label.frame = CGRectIntegral(frame);
        
        // Recenter label vertically within the scroll view
        label.center = CGPointMake(label.center.x, roundf(self.center.y - CGRectGetMinY(self.frame)));
        
        offset += CGRectGetWidth(label.bounds) + self.labelSpacing;
    }
    
    // if the label is bigger than the space allocated, then it should scroll
    if (CGRectGetWidth(MAIN_LABEL.bounds) > CGRectGetWidth(self.bounds)) {
        CGSize size;
        size.width = CGRectGetWidth(MAIN_LABEL.bounds) + CGRectGetWidth(self.bounds) + self.labelSpacing;
        size.height = CGRectGetHeight(self.bounds);
        self.scrollView.frame = CGRectIntegral(CGRectMake(0, 0, size.width, size.height));
        self.scrollView.contentSize = self.scrollView.frame.size;
        
        APPLY_TO_LABELS(hidden, NO);
        
        [self updateMaskLayerWithFade:self.scrolling];
        
        [self scrollLabelIfNeeded];
    } else {
        // Hide the other labels
        APPLY_TO_LABELS(hidden, (MAIN_LABEL != label));
        
        // adjust the scroll view and main label
        self.scrollView.frame = CGRectIntegral(CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)));
        self.scrollView.contentSize = self.scrollView.bounds.size;
        MAIN_LABEL.frame = self.bounds;
        MAIN_LABEL.hidden = NO;
        MAIN_LABEL.textAlignment = (NSInteger)self.textAlignment;
        
        self.layer.mask = nil;
    }
}

- (void)updateMaskLayerWithFade:(BOOL)fade {
    CGFloat fadeLength = self.fadeLength;
    CGFloat labelWidth = CGRectGetWidth(MAIN_LABEL.bounds);
    if (labelWidth <= CGRectGetWidth(self.bounds)) {
        fadeLength = 0;
    }
    
    if (fadeLength) {
        // Recreate gradient mask with new fade length
        CAGradientLayer *gradientMask = [CAGradientLayer layer];
        
        gradientMask.bounds = self.layer.bounds;
        gradientMask.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        
        gradientMask.shouldRasterize = YES;
        gradientMask.rasterizationScale = [UIScreen mainScreen].scale;
        
        gradientMask.startPoint = CGPointMake(0, CGRectGetMidY(self.frame));
        gradientMask.endPoint = CGPointMake(1, CGRectGetMidY(self.frame));
        
        // setup fade mask colors and location
        id transparent = (id)[UIColor clearColor].CGColor;
        id opaque = (id)[UIColor blackColor].CGColor;
        gradientMask.colors = @[transparent, opaque, opaque, transparent];
        
        // calcluate fade
        CGFloat fadePoint = fadeLength / CGRectGetWidth(self.bounds);
        NSNumber *leftFadePoint = @(fadePoint);
        NSNumber *rightFadePoint = @(1 - fadePoint);
        if (!fade) {
            leftFadePoint = @0;
        }
        
        // apply calculations to mask
        gradientMask.locations = @[@0, leftFadePoint, rightFadePoint, @1];
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.layer.mask = gradientMask;
        [CATransaction commit];
    } else {
        // Remove gradient mask for 0.0f lenth fade length
        self.layer.mask = nil;
    }
}

#pragma mark - Accessibility

- (BOOL)isAccessibilityElement {
    return YES;
}

- (NSString *)accessibilityLabel {
    return [MAIN_LABEL accessibilityLabel];
}

- (UIAccessibilityTraits)accessibilityTraits {
    return [MAIN_LABEL accessibilityTraits];
}

- (NSString *)accessibilityHint
{
    return [MAIN_LABEL accessibilityHint];
}

@end
