//
//  DLOptionsView.m
//  DL_MVVM
//
//  Created by Daniel.Li on 23/11/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLOptionsView.h"
#import "NSArray+Safe.h"
#import "NSString+DL_StringUtil.h"

#define IS_RETINA ([UIScreen mainScreen].scale >= 2.0)

@interface DLOptionsView ()

@property (nonatomic, strong) NSMutableArray *buttonPaddingImageViews;

@end

@implementation DLOptionsView

@synthesize options = _options;

@synthesize optionButtons = _optionButtons;
@synthesize buttonSize = _buttonSize;
@synthesize font = _font;
@synthesize space = _space;
@synthesize edgeInsets = _edgeInsets;
@synthesize buttonBgImage = _buttonBgImage;
@synthesize buttonSelectedBgImage = _buttonSelectedBgImage;

@synthesize buttonPaddingImage = _buttonPaddingImage;
@synthesize buttonPaddingImageViews = _buttonPaddingImageViews;

@synthesize buttonTitleNormalColor = _buttonTitleNormalColor;
@synthesize buttonTitleHighlightedColor = _buttonTitleHighlightedColor;
@synthesize buttonTitleSelectedColor = _buttonTitleSelectedColor;

@synthesize buttonContentEdgeInsets = _buttonContentEdgeInsets;

@synthesize selectedBgView = _selectedBgView;
@synthesize selectedOptionsBgImage = _selectedOptionsBgImage;
@synthesize selectedIndex = _selectedIndex;

@synthesize optionsViewDelegate = _optionsViewDelegate;

@synthesize btnFrameFromDelegate = _btnFrameFromDelegate;
@synthesize adjustsBtnWidthToFitTitle = _adjustsBtnWidthToFitTitle;

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame horizontal:YES];
}

- (id)initWithFrame:(CGRect)frame horizontal:(BOOL)horizontal
{
    self = [super initWithFrame:frame];
    if (self) {
        _horizontal = horizontal;
        
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _horizontal = YES;
        
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.selectedBgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.selectedBgView.hidden = YES;
    
    [self addSubview:self.selectedBgView];
    _selectedIndex = 0;
    self.enableBgViewMoveAnimation = YES;
    
    self.buttonContentEdgeInsets = UIEdgeInsetsZero;
    self.selectedBgViewEdgeInsets = UIEdgeInsetsZero;
    
    self.btnFrameFromDelegate = NO;
    self.adjustsBtnWidthToFitTitle = YES;
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.buttonTitleNormalColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:15.f];
    self.selectedFont = self.font;
    
    if (_horizontal) {
        self.scrollsToTop = NO;
    }
}

- (void)setFont:(UIFont *)font
{
    if (_font != font) {
        _font = font;
        
        for (UIButton *button in self.optionButtons) {
            if (self.selectedFont && [self.optionButtons indexOfObject:button] == self.selectedIndex) {
                button.titleLabel.font = self.selectedFont;
            } else {
                button.titleLabel.font = _font;
            }
        }
    }
}

- (void)setSelectedFont:(UIFont *)selectedFont
{
    if (_selectedFont != selectedFont) {
        _selectedFont = selectedFont;
        if (self.selectedIndex >= 0 && self.selectedIndex < [self.optionButtons count]) {
            UIButton *selectedBtn = self.optionButtons[self.selectedIndex];
            selectedBtn.titleLabel.font = self.selectedFont;
        }
    }
}

- (void)setButtonTitleNormalColor:(UIColor *)buttonTitleNormalColor
{
    if (_buttonTitleNormalColor != buttonTitleNormalColor) {
        _buttonTitleNormalColor = buttonTitleNormalColor;
        
        for (UIButton *button in self.optionButtons) {
            if (self.selectedFont && [self.optionButtons indexOfObject:button] == self.selectedIndex) {
                [button setTitleColor:self.buttonTitleSelectedColor forState:UIControlStateNormal];
            } else {
                [button setTitleColor:buttonTitleNormalColor forState:UIControlStateNormal];
            }
        }
    }
}

- (void)setButtonTitleHighlightedColor:(UIColor *)buttonTitleHighlightedColor
{
    if (_buttonTitleHighlightedColor != buttonTitleHighlightedColor) {
        _buttonTitleHighlightedColor = buttonTitleHighlightedColor;
        
        for (UIButton *button in self.optionButtons) {
            [button setTitleColor:buttonTitleHighlightedColor forState:UIControlStateHighlighted];
        }
    }
}

- (void)setButtonTitleSelectedColor:(UIColor *)buttonTitleSelectedColor
{
    if (_buttonTitleSelectedColor != buttonTitleSelectedColor) {
        _buttonTitleSelectedColor = buttonTitleSelectedColor;
        if (self.selectedIndex >= 0 && self.selectedIndex < [self.optionButtons count]) {
            UIButton *selectedBtn = self.optionButtons[self.selectedIndex];
            [selectedBtn setTitleColor:buttonTitleSelectedColor forState:UIControlStateNormal];
        }
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex < [self.optionButtons count] && _selectedIndex >= 0) {
        UIButton *button = (UIButton *)[self.optionButtons objectAtIndexForDL:_selectedIndex];
        [button setBackgroundImage:self.buttonBgImage forState:UIControlStateNormal];
        
        if (self.buttonTitleNormalColor) {
            [button setTitleColor:self.buttonTitleNormalColor forState:UIControlStateNormal];
            [button setTitleColor:self.buttonTitleNormalColor forState:UIControlStateHighlighted];
            
            if ([self.optionsViewDelegate respondsToSelector:@selector(optionsView:drawItemAtIndex:)]) {
                [self.optionsViewDelegate optionsView:self drawItemAtIndex:_selectedIndex];
            }
        }
        
        if (self.buttonTitleHighlightedColor) {
            [button setTitleColor:self.buttonTitleHighlightedColor forState:UIControlStateHighlighted];
        }
        
        button.titleLabel.font = self.font;
    }
    
    _selectedIndex = selectedIndex;
    
    if (_selectedIndex < [self.optionButtons count] && _selectedIndex >= 0) {
        self.selectedBgView.hidden = ([self.options count] == 0);
        UIButton *button = (UIButton *)[self.optionButtons objectAtIndexForDL:_selectedIndex];
        
        CGPoint buttonCenter = button.center;
        
        CGSize selectedBgViewSize = self.buttonSize;
        if (self.adjustsBtnWidthToFitTitle) {
            if (button.frame.size.width > selectedBgViewSize.width) {
                selectedBgViewSize.width = button.frame.size.width;
            }
        }
        
        self.selectedBgView.frame = UIEdgeInsetsInsetRect(CGRectMake(floorf(buttonCenter.x - selectedBgViewSize.width / 2),
                                                                     floorf(buttonCenter.y - selectedBgViewSize.height / 2),
                                                                     selectedBgViewSize.width,
                                                                     selectedBgViewSize.height),
                                                          self.selectedBgViewEdgeInsets);
        
        [button setBackgroundImage:self.buttonSelectedBgImage forState:UIControlStateNormal];
        
        if (self.buttonTitleSelectedColor) {
            [button setTitleColor:self.buttonTitleSelectedColor forState:UIControlStateNormal];
            [button setTitleColor:self.buttonTitleSelectedColor forState:UIControlStateHighlighted];
        }
        
        if (self.selectedFont) {
            button.titleLabel.font = self.selectedFont;
        }
        
        if (self.isShowUnderline) {
            CGFloat underlineWidth = 0.0f;
            if (self.underlineWidth == 0) {
                underlineWidth = button.frame.size.width;
            } else {
                underlineWidth = self.underlineWidth;
            }
            
            self.underline.frame = CGRectMake(button.frame.origin.x + button.frame.size.width / 2 - (underlineWidth / 2), self.contentSize.height - 2, underlineWidth, 2);
        }
    } else {
        self.selectedBgView.hidden = YES;
    }
}

- (void)setSelectedOptionsBgImage:(UIImage *)selectedOptionsBgImage
{
    if (_selectedOptionsBgImage != selectedOptionsBgImage) {
        _selectedOptionsBgImage = selectedOptionsBgImage;
        
        self.selectedBgView.image = _selectedOptionsBgImage;
        self.selectedBgView.frame = CGRectMake(0.0, 0.0, _selectedOptionsBgImage.size.width, _selectedOptionsBgImage.size.height);
        
        if (self.selectedIndex < [self.optionButtons count] && self.selectedIndex >= 0) {
            self.selectedBgView.hidden = ([self.options count] == 0);
            UIButton *button = [self.optionButtons objectAtIndexForDL:self.selectedIndex];
            
            CGPoint buttonCenter = button.center;
            
            CGSize selectedBgViewSize = self.selectedBgView.frame.size;
            self.selectedBgView.frame = CGRectMake(floorf(buttonCenter.x - selectedBgViewSize.width / 2), floorf(buttonCenter.y - selectedBgViewSize.height / 2), selectedBgViewSize.width, selectedBgViewSize.height);
        } else {
            self.selectedBgView.hidden = YES;
        }
    }
}

- (BOOL)isHorizontal
{
    return _horizontal;
}

- (NSString *)selectedOption
{
    NSString *option = nil;
    if (self.selectedIndex < [self.options count] && self.selectedIndex >= 0) {
        option = self.options[self.selectedIndex];
    }
    
    return option;
}

- (void)reloadOptionButtons
{
    self.contentOffset = CGPointZero;
    // Create buttons
    self.selectedBgView.hidden = ([self.options count] == 0);
    
    for (UIButton *button in self.optionButtons) {
        [button removeFromSuperview];
    }
    
    NSMutableArray *buttonArray = [NSMutableArray arrayWithCapacity:20];
    for (NSUInteger index = 0; index < [self.options count]; index++) {
        NSString *optionTitle = [self.options objectAtIndexForDL:index];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (self.font) {
            button.titleLabel.font = self.font;
        }
        
        [button setTitle:optionTitle forState:UIControlStateNormal];
        button.contentEdgeInsets = self.buttonContentEdgeInsets;
        
        if (self.buttonTitleNormalColor) {
            [button setTitleColor:self.buttonTitleNormalColor forState:UIControlStateNormal];
            [button setTitleColor:self.buttonTitleNormalColor forState:UIControlStateHighlighted];
        }
        
        if (self.buttonTitleHighlightedColor) {
            [button setTitleColor:self.buttonTitleHighlightedColor forState:UIControlStateHighlighted];
        }
        
        //        if (self.buttonTitleSelectedColor) {
        //            [button setTitleColor:self.buttonTitleSelectedColor forState:UIControlStateSelected];
        //        }
        
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArray addObject:button];
        [self addSubview:button];
    }
    
    if (self.selectedIndex >= [buttonArray count]) {
        self.selectedIndex = 0;
    }
    
    self.optionButtons = buttonArray;
    
    
    // Layout buttons
    CGFloat btnStartPosition = 0.;
    CGFloat btnEndPosition = 0.;
    
    if (_horizontal) {
        btnEndPosition = self.edgeInsets.left;
    } else {
        btnEndPosition = self.edgeInsets.top;
    }
    
    
    CGFloat centerX = self.bounds.size.width / 2;
    CGFloat centerY = self.bounds.size.height / 2;
    
    CGFloat space = self.space;
    
    UIFont *maxFont = self.font;
    if (self.selectedFont.pointSize > self.font.pointSize) {
        maxFont = self.selectedFont;
    }
    
    if (self.evenlyDistributed) {
        // 分散布局, 重新计算space
        CGFloat buttonWidthSum = 0.f;
        
        for (NSString *title in self.options) {
            CGFloat btnWidth = self.buttonSize.width;
            if (self.adjustsBtnWidthToFitTitle) {
                CGSize fullTitleSize = [title dl_sizeWithFont:maxFont];
                CGFloat fullContentWidth = fullTitleSize.width + self.buttonContentEdgeInsets.left + self.buttonContentEdgeInsets.right;
                if (fullContentWidth > btnWidth) {
                    btnWidth = fullContentWidth;
                }
            }
            
            buttonWidthSum += btnWidth;
        }
        
        CGFloat totalWidth = CGRectGetWidth(self.bounds);
        
        if ([self.options count] > 1) {
            space = (totalWidth - self.edgeInsets.left - self.edgeInsets.right - buttonWidthSum) / ([self.options count] - 1);
        }
    }
    
    UIButton *selectedButton = nil;
    for (NSUInteger index = 0; index < [self.optionButtons count]; index++) {
        UIButton *button = [self.optionButtons objectAtIndexForDL:index];
        
        if (!self.btnFrameFromDelegate) {
            if (index == 0) {
                btnStartPosition = btnEndPosition;
            } else {
                btnStartPosition = btnEndPosition + space;
            }
            
            CGRect buttonFrame = CGRectZero;
            
            CGFloat btnWidth = self.buttonSize.width;
            if (self.adjustsBtnWidthToFitTitle) {
                NSString *title = [self.options objectAtIndexForDL:index];
                CGSize fullTitleSize = [title dl_sizeWithFont:maxFont];
                CGFloat fullContentWidth = fullTitleSize.width + self.buttonContentEdgeInsets.left + self.buttonContentEdgeInsets.right;
                if (fullContentWidth > btnWidth) {
                    btnWidth = fullContentWidth;
                }
            }
            
            if (_horizontal) {
                buttonFrame = CGRectMake(btnStartPosition, floorf(centerY - self.buttonSize.height / 2), btnWidth, self.buttonSize.height);
            } else {
                buttonFrame = CGRectMake(floorf(centerX - self.buttonSize.width / 2), btnStartPosition, btnWidth, self.buttonSize.height);
            }
            button.frame = buttonFrame;
            
            if ([self.optionsViewDelegate respondsToSelector:@selector(optionsView:drawItemAtIndex:)]) {
                [self.optionsViewDelegate optionsView:self drawItemAtIndex:index];
            }
            
            if (_horizontal) {
                btnEndPosition = btnStartPosition + button.frame.size.width;
            } else {
                btnEndPosition = btnStartPosition + self.buttonSize.height;
            }
        } else {
            button.frame = [self.optionsViewDelegate optionsView:self frameOfButtonAtIndex:index];
            
            if (_horizontal) {
                btnEndPosition = CGRectGetMaxX(button.frame);
            } else {
                btnEndPosition = CGRectGetMaxY(button.frame);
            }
        }
        
        if (index == self.selectedIndex) {
            CGSize selectedBgViewSize = button.frame.size;
            self.selectedBgView.frame = UIEdgeInsetsInsetRect(CGRectMake(floorf(button.center.x - selectedBgViewSize.width / 2), floorf(button.center.y - selectedBgViewSize.height / 2), selectedBgViewSize.width, selectedBgViewSize.height), self.selectedBgViewEdgeInsets);
            [button setBackgroundImage:self.buttonSelectedBgImage forState:UIControlStateNormal];
            //            button.selected = YES;
            if (self.buttonTitleSelectedColor) {
                [button setTitleColor:self.buttonTitleSelectedColor forState:UIControlStateNormal];
                [button setTitleColor:self.buttonTitleSelectedColor forState:UIControlStateHighlighted];
            }
            
            if (self.isShowUnderline && !self.underline) {
                CGFloat underlineWidth = 0.0f;
                if (self.underlineWidth == 0) {
                    underlineWidth = button.frame.size.width;
                } else {
                    underlineWidth = self.underlineWidth;
                }
                self.underline = [[UIView alloc] initWithFrame:CGRectMake(button.frame.origin.x + button.frame.size.width / 2 - (underlineWidth / 2), self.frame.size.height - 2, underlineWidth, 2)];
//                self.underline.backgroundColor = UIColorRGBA(24.f, 135.f, 220.f, 1);
                self.underline.backgroundColor = [UIColor colorWithRed:24/255.f green:135/255.f blue:220/255.f alpha:1.f];
                [self addSubview:self.underline];
            }
            
            selectedButton = button;
        } else {
            [button setBackgroundImage:self.buttonBgImage forState:UIControlStateNormal];
        }
    }
    
    CGSize sizeOfContent = CGSizeZero;
    if ([self.optionButtons count] > 0) {
        if (_horizontal) {
            CGFloat width = btnEndPosition + self.edgeInsets.right;
            if (width < self.bounds.size.width) {
                width = self.bounds.size.width;
            }
            sizeOfContent = CGSizeMake(width, self.bounds.size.height);
        } else {
            sizeOfContent =  CGSizeMake(self.bounds.size.width, btnEndPosition + self.edgeInsets.bottom);
        }
    }
    
    self.contentSize = sizeOfContent;
    if (self.isShowBottomLine) {
        UIView *lineView = [[UIView alloc] init];
        [lineView.layer setFrame:CGRectMake(0, self.frame.size.height - 0.5, self.contentSize.width, 0.5)];
        lineView.backgroundColor = self.bottonLineColor;
        [self insertSubview:lineView atIndex:0];
    }
    [self scrollRectToVisible:selectedButton.frame animated:NO];
    
    // button padding image
    
    if (!self.buttonPaddingImageViews) {
        self.buttonPaddingImageViews = [NSMutableArray array];
    }
    
    for (UIImageView *imageView in self.buttonPaddingImageViews) {
        [imageView removeFromSuperview];
    }
    
    [self.buttonPaddingImageViews removeAllObjects];
    
    if ([self.optionButtons count] > 1 && self.buttonPaddingImage) {
        for (NSInteger buttonIndex = 1; buttonIndex < [self.optionButtons count]; buttonIndex++) {
            UIButton *preButton = [self.optionButtons objectAtIndexForDL:buttonIndex - 1];
            UIButton *curButton = [self.optionButtons objectAtIndexForDL:buttonIndex];
            
            CGRect imageViewFrame = CGRectMake(0, 0, self.buttonPaddingImage.size.width, self.buttonPaddingImage.size.height);
            
            if (_horizontal) {
                imageViewFrame.origin.x = (CGRectGetMaxX(preButton.frame) + CGRectGetMinX(curButton.frame) - self.buttonPaddingImage.size.width) / 2;
                imageViewFrame.size.height = CGRectGetHeight(self.frame);
            } else {
                imageViewFrame.origin.y = (CGRectGetMaxY(preButton.frame) + CGRectGetMinY(curButton.frame) - self.buttonPaddingImage.size.height) / 2;
                imageViewFrame.size.width = CGRectGetWidth(self.frame);
            }
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:self.buttonPaddingImage];
            
            imageView.frame = imageViewFrame;
            
            [self addSubview:imageView];
            [self.buttonPaddingImageViews addObject:imageView];
        }
    }
    
    if ([self.optionButtons count] > 1 && self.isShowSeparateLine) {
        for (NSInteger buttonIndex = 1; buttonIndex < [self.optionButtons count]; buttonIndex++) {
            UIButton *preButton = [self.optionButtons objectAtIndexForDL:buttonIndex - 1];
            UIButton *curButton = [self.optionButtons objectAtIndexForDL:buttonIndex];
            
            CGRect rect = CGRectMake(0, self.frame.size.height / 2 - 6, IS_RETINA ? 0.5 : 1.0, 12);
            
            if (_horizontal) {
                rect.origin.x = (CGRectGetMaxX(preButton.frame) + CGRectGetMinX(curButton.frame) - rect.size.width) / 2;
            } else {
                rect.origin.y = (CGRectGetMaxY(preButton.frame) + CGRectGetMinY(curButton.frame) - rect.size.height) / 2;
            }
            
            UIView *separateLine = [[UIView alloc] init];
            [separateLine.layer setFrame:rect];
            separateLine.backgroundColor = self.separateLineColor;
            [self addSubview:separateLine];
        }
    }
}

- (void)buttonTapped:(UIButton *)sender
{
    NSUInteger oldIndex = self.selectedIndex;
    NSUInteger newIndex = [self.optionButtons indexOfObject:sender];
    CGFloat underlineWidth = 0.0;
    if (self.underlineWidth) {
        underlineWidth = self.underlineWidth;
    } else {
        underlineWidth = sender.frame.size.width;
    }
    
    if (newIndex != self.selectedIndex) {
        if (self.isShowUnderline) {
            //被选中按钮动画过程
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.underline.frame = CGRectMake(sender.frame.origin.x + sender.frame.size.width / 2 - (underlineWidth / 2), self.contentSize.height - 2, underlineWidth, 2);
            } completion:^(BOOL finished) {
                [self setOptionButtonVisibleAtIndex:newIndex animated:YES];
                [self finishSwitch:newIndex];
            }];
        } else {
            [self finishSwitch:newIndex];
        }
    }
    
    if ([self.optionsViewDelegate respondsToSelector:@selector(optionsView:optionSelectedFromIndex:toIndex:)]) {
        [self.optionsViewDelegate optionsView:self optionSelectedFromIndex:oldIndex toIndex:newIndex];
    }
}

- (void)finishSwitch:(NSUInteger)newIndex
{
    if ([self.optionsViewDelegate respondsToSelector:@selector(optionsView:optionDeselectedFromIndex:)]) {
        [self.optionsViewDelegate optionsView:self optionDeselectedFromIndex:self.selectedIndex];
    }
    
    if (self.enableBgViewMoveAnimation) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
    }
    
    self.selectedIndex = newIndex;
    
    if (self.enableBgViewMoveAnimation) {
        [UIView commitAnimations];
    }
    
    if ([self.optionsViewDelegate respondsToSelector:@selector(optionsView:optionSelectedAtIndex:)]) {
        [self.optionsViewDelegate optionsView:self optionSelectedAtIndex:newIndex];
    }
}

- (void)setOptionButtonVisibleAtIndex:(NSInteger)index animated:(BOOL)animated
{
    if (index >= 0 && index < [self.optionButtons count]) {
        if (index == 0) {
            [self setContentOffset:CGPointZero animated:animated];
        } else if (index == [self.optionButtons count] - 1) {
            if (self.contentSize.width > self.frame.size.width) {
                [self setContentOffset:CGPointMake(self.contentSize.width - CGRectGetWidth(self.frame), 0.f) animated:animated];
            }
        } else {
            UIButton *btn = self.optionButtons[index];
            CGRect btnFrame = btn.frame;
            btnFrame.size.width += 10;
            [self scrollRectToVisible:btnFrame animated:animated];
        }
    } else {
        [self setContentOffset:CGPointZero animated:animated];
    }
}

@end
