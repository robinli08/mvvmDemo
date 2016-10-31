//
//  DL_SegmentedControl.m
//  DL_MVVM
//
//  Created by Daniel.Li on 25/10/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DL_SegmentedControl.h"
#import "UIView+HXUtility.h"
#import "NSString+DL_StringUtil.h"

@interface DL_SegmentedControl (Private) {
}

- (void)insertSegmentWithObject:(NSObject *)object atIndex:(NSUInteger)index;  //插入segment底层的接口
- (void)resetSegments;                                                         //重置segments的视图
//对UI的进一步的更新
- (void)replaceSegmentObject:(NSObject *)object atIndex:(NSUInteger)index;     //替换segment的定制的底层接口

@end

@implementation DL_SegmentedControl
@synthesize gapValue;
@synthesize segmentArray;
@synthesize numberOfSegments;
@synthesize selectedSegmentIndex;
@synthesize normalImageLeft;
@synthesize normalImageMiddle;
@synthesize normalImageRight;
@synthesize selectedImageLeft;
@synthesize selectedImageMiddle;
@synthesize selectedImageRight;
@synthesize font;
@synthesize selectedFont;
@synthesize titleColor;
@synthesize selectedColor;

@synthesize showIndicator;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:14.0f];
        self.selectedColor = [UIColor colorWithRed:15/255.f green:167/255.f blue:130/255.f alpha:1.f];
        self.titleColor = [UIColor colorWithRed:5/255.f green:4/255.f blue:132/255.f alpha:1.f];
        self.backgroundColor = [UIColor colorWithRed:15/255.f green:143/255.f blue:143/255.f alpha:1.0f];
        self.segmentArray = [[NSMutableArray alloc] initWithCapacity:50];
        self.normalImageLeft = [UIImage imageNamed:@""];
        self.normalImageMiddle = [UIImage imageNamed:@""];
        self.normalImageRight = [UIImage imageNamed:@""];
        self.selectedImageLeft = [UIImage imageNamed:@""];
        self.selectedImageMiddle = [UIImage imageNamed:@""];
        self.selectedImageRight = [UIImage imageNamed:@""];
        self.selectedSegmentIndex = 0;
        self.indicatorPosition = eIndicatorPositionBottom;
    }
    return self;
}

#pragma mark-- 开发者接口(传入Button)
- (void)addSegmentButton:(UIButton *)button {
    [segmentArray addObject:button];
    [self updateUI];
}

- (void)addSegmentButtons:(NSArray *)btnArray {
    self.segmentArray = [NSMutableArray arrayWithArray:btnArray];
    [self updateUI];
}

- (void)insertSegmentButton:(UIButton *)button atIndex:(NSUInteger)index {
    [self insertSegmentWithObject:button atIndex:index];
}

- (void)replaceSegmentButton:(UIButton *)button atIndex:(NSUInteger)index {
    [self replaceSegmentObject:button atIndex:index];
}

- (void)removeSegmentWithButton:(UIButton *)button {
    if ([segmentArray count] > 0) {
        [segmentArray removeObject:button];
        
    } else {
        return;
    }
    [self updateUI];
}

#pragma mark-- 开发者接口 （传入NSString）

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self updateUI];
    [self setSelectedSegmentIndex:self.selectedSegmentIndex];
}

- (void)addSegmentWithTitle:(NSString *)title {
    [segmentArray addObject:title];
    [self updateUI];
}

- (void)addSegmentWithTitles:(NSArray *)titleArray {
    self.segmentArray = [NSMutableArray arrayWithArray:titleArray];
    [self updateUI];
}

- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)index {
    [self insertSegmentWithObject:title atIndex:index];
    [self updateUI];
}

- (void)replaceSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)index {
    [self replaceSegmentObject:title atIndex:index];
    [self updateUI];
}

- (void)removeSegmentAtIndex:(NSUInteger)index {
    if (index < [segmentArray count]) {
        [segmentArray removeObjectAtIndex:index];
        
    } else {
        return;
    }
}

- (void)removeAllSegments {
    [segmentArray removeAllObjects];
}

#pragma mark-- 私有接口
- (void)insertSegmentWithObject:(NSObject *)object atIndex:(NSUInteger)index {
    
    if (index <= numberOfSegments) {
        [segmentArray insertObject:object atIndex:index];
        [self resetSegments];
    }
}

- (void)replaceSegmentObject:(NSObject *)object atIndex:(NSUInteger)index {
    if (index <= numberOfSegments) {
        [segmentArray replaceObjectAtIndex:index withObject:object];
        [self resetSegments];
    }
}

- (void)resetSegments {
    selectedSegmentIndex = 0;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    [self updateUI];
}

- (void)updateUI {
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.dotArray = [NSMutableArray array];
    if ([segmentArray count] > 0) {
        numberOfSegments = [segmentArray count];
        int indexOfObject = 0;
        float segmentWidth = (float)self.frame.size.width / numberOfSegments;
        float lastX = 0.0;
        if (self.style == DLSegmentControlStyleSelectCategory || self.style == DLSegmentControlStyleArtistCategory) {
            lastX = 6;
        }
        
        for (NSObject *object in segmentArray) {
            if ([object isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)object;
                int currentSegmentWidth;
                
                if (indexOfObject < numberOfSegments - 1)
                    currentSegmentWidth = round(lastX + segmentWidth) - round(lastX) - self.gapValue + 1;
                else
                    currentSegmentWidth = round(lastX + segmentWidth) - round(lastX) - self.gapValue;
                
                CGRect segmentFrame = CGRectMake(round(lastX), 0, currentSegmentWidth, self.frame.size.height);
                lastX += segmentWidth;
                
                button.frame = segmentFrame;
                // button.tag = indexOfObject +1;
                [self addSubview:button];
                
                ++indexOfObject;
            } else if (self.style == DLSegmentControlStyleSelectCategory ||
                       self.style == DLSegmentControlStyleArtistCategory ){
                int currentSegmentWidth;
                if ([object isKindOfClass:[NSString class]])
                    segmentWidth = [(NSString *)object sizeWithFont:self.font].width + 18;
                
                
                if (indexOfObject < numberOfSegments - 1)
                    currentSegmentWidth = round(lastX + segmentWidth) - round(lastX) - self.gapValue + 1;
                else {
                    currentSegmentWidth = round(lastX + segmentWidth) - round(lastX) - self.gapValue;
                    self.totalWidth = round(lastX) + currentSegmentWidth;
                }
                
                CGRect segmentFrame = CGRectMake(round(lastX), 0, currentSegmentWidth, self.frame.size.height);
                lastX += segmentWidth;
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = segmentFrame;
                button.tag = indexOfObject + 1;
                button.adjustsImageWhenHighlighted = NO;
                [button setTitleColor:self.titleColor forState:UIControlStateNormal];
                if ([object isKindOfClass:[NSString class]]) {
                    [button setTitle:(NSString *)object forState:UIControlStateNormal];
                    button.titleLabel.font = self.font;
                    [self addSubview:button];
                    [button addTarget:self
                               action:@selector(segmentTapped:)
                     forControlEvents:UIControlEventTouchUpInside];
                }
                if (self.style == DLSegmentControlStyleArtistCategory) {
                    if (indexOfObject != numberOfSegments - 1) {
                        UIView *lineView = [[UIView alloc] init];
                        lineView.backgroundColor = [UIColor blackColor];
                        lineView.alpha = 0.1;
                        lineView.bounds = CGRectMake(0, 0, 1, 8);
                        lineView.center = CGPointMake(round(lastX), self.bounds.size.height / 2.0);
                        [self addSubview:lineView];
                    }
                }
                [self bringSubviewToFront:[self viewWithTag:selectedSegmentIndex + 1]];
                ++indexOfObject;
            } else {
                int currentSegmentWidth;
                
                if (indexOfObject < numberOfSegments - 1)
                    currentSegmentWidth = round(lastX + segmentWidth) - round(lastX) - self.gapValue + 1;
                else
                    currentSegmentWidth = round(lastX + segmentWidth) - round(lastX) - self.gapValue;
                
                CGRect segmentFrame = CGRectMake(round(lastX), 0, currentSegmentWidth, self.frame.size.height);
                lastX += segmentWidth;
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                if (indexOfObject == 0) {
                    if (selectedSegmentIndex == indexOfObject)
                        [button setBackgroundImage:selectedImageLeft forState:UIControlStateNormal];
                    else
                        [button setBackgroundImage:normalImageLeft forState:UIControlStateNormal];
                } else if (indexOfObject == numberOfSegments - 1) {
                    if (selectedSegmentIndex == indexOfObject)
                        [button setBackgroundImage:selectedImageRight forState:UIControlStateNormal];
                    else
                        [button setBackgroundImage:normalImageRight forState:UIControlStateNormal];
                } else {
                    if (selectedSegmentIndex == indexOfObject)
                        [button setBackgroundImage:selectedImageMiddle forState:UIControlStateNormal];
                    else
                        [button setBackgroundImage:normalImageMiddle forState:UIControlStateNormal];
                }
                
                button.frame = segmentFrame;
                UIView *view = [[UIView alloc] init];
                view.frame = CGRectMake(round(lastX) - 59, 10, 6, 6);
                view.tag = 100 + indexOfObject + 1;
                view.backgroundColor = [UIColor redColor];
                view.layer.cornerRadius = 3.0f;
                view.hidden = YES;
                //                UILabel * numLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 0, 12, 16)];
                //                numLabel.tag = 69;
                //                numLabel.text = @"1";
                //                numLabel.textColor = [UIColor whiteColor];
                //                [numLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
                //                numLabel.textAlignment = NSTextAlignmentCenter;
                //
                //                [view addSubview:numLabel];
                [self addSubview:view];
                [self.dotArray addObject:view];
                
                // button.titleLabel.font = [UIFont systemFontOfSize:30.0f];
                // [button setFont: [UIFont systemFontOfSize: 30.0]];
                button.tag = indexOfObject + 1;
                button.adjustsImageWhenHighlighted = NO;
                [button setTitleColor:self.titleColor forState:UIControlStateNormal];
                if ([object isKindOfClass:[NSString class]]) {
                    [button setTitle:(NSString *)object forState:UIControlStateNormal];
                    button.titleLabel.font = self.font;
                    [self addSubview:button];
                    [button addTarget:self
                               action:@selector(segmentTapped:)
                     forControlEvents:UIControlEventTouchUpInside];
                }
                [self bringSubviewToFront:[self viewWithTag:selectedSegmentIndex + 1]];
                
                if (self.style == DLSegmentControlStyleMusicLibrary) {
                    if (indexOfObject != numberOfSegments - 1) {
                        UIView *lineView = [[UIView alloc] init];
                        lineView.backgroundColor = [UIColor blackColor];
                        lineView.alpha = 0.1;
                        lineView.bounds = CGRectMake(0, 0, 1, 8);
                        lineView.center = CGPointMake(round(lastX), self.bounds.size.height / 2.0);
                        [self addSubview:lineView];
                    }
                }
                ++indexOfObject;
            }
        }
    }
}

- (void)setStyle:(DLSegmentControlStyle)style {
    _style = style;
    [self updateUI];
}

- (void)segmentTapped:(id)sender {
    
    [self deselectAllSegments];
    UIButton *button = sender;
    [self bringSubviewToFront:button];
    self.isClicking = YES;
    if (selectedSegmentIndex != button.tag - 1) {
        selectedSegmentIndex = button.tag - 1;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    } else {
        selectedSegmentIndex = button.tag - 1;
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    //显示底部表示选中的横线
    UIView *indicator = [self viewWithTag:9999];
    if (indicator == nil) {
        indicator = [[UIView alloc] initWithFrame:button.frame];
        UIView *colorView;
        if (self.indicatorPosition == eIndicatorPositionBottom) {
            if (self.isFromMain == YES) {
                if (selectedSegmentIndex == 0) {
                    colorView = [[UIView alloc]
                                 initWithFrame:CGRectMake(0, indicator.bounds.size.height - 3, indicator.bounds.size.width, 2)];
                } else {
                    colorView = [[UIView alloc]
                                 initWithFrame:CGRectMake(0, indicator.bounds.size.height - 3, indicator.bounds.size.width, 2)];
                }
            } else {
                if (selectedSegmentIndex == 0) {
                    colorView = [[UIView alloc] initWithFrame:CGRectMake(16, indicator.bounds.size.height - 2,
                                                                         indicator.bounds.size.width - 32, 2)];
                } else {
                    colorView = [[UIView alloc] initWithFrame:CGRectMake(16, indicator.bounds.size.height - 2,
                                                                         indicator.bounds.size.width - 32, 2)];
                }
            }
        }
        
        colorView.backgroundColor = self.selectedColor;
        colorView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        colorView.tag = 9998;
        [indicator addSubview:colorView];
        indicator.tag = 9999;
        [self addSubview:indicator];
        [self sendSubviewToBack:indicator];
    }
    indicator.hidden = !showIndicator;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         indicator.frame = button.frame;
                         
                         if(self.style == DLSegmentControlStyleOrderList) {
                             UIView *colorView = [indicator viewWithTag:9998];
                             colorView.width = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.font}].width;
                             colorView.centerX = indicator.width/2;
                         }
                     }
                     completion:^(BOOL finished) {
                         
                         [self performSelector:@selector(changisClicking) withObject:nil afterDelay:0.1];
                     }];
    
    if (button.tag == 1) {
        [button setTitleColor:self.selectedColor forState:UIControlStateNormal];
        button.titleLabel.font = self.selectedFont ? self.selectedFont : self.font;
        [button setBackgroundImage:[selectedImageLeft stretchableImageWithLeftCapWidth:6 topCapHeight:0]
                          forState:UIControlStateNormal];
        
    } else if (button.tag == numberOfSegments) {
        [button setTitleColor:self.selectedColor forState:UIControlStateNormal];
        button.titleLabel.font = self.selectedFont ? self.selectedFont : self.font;
        [button setBackgroundImage:[selectedImageRight stretchableImageWithLeftCapWidth:1 topCapHeight:0]
                          forState:UIControlStateNormal];
    } else {
        [button setTitleColor:self.selectedColor forState:UIControlStateNormal];
        button.titleLabel.font = self.selectedFont ? self.selectedFont : self.font;
        [button setBackgroundImage:[selectedImageMiddle stretchableImageWithLeftCapWidth:1 topCapHeight:0]
                          forState:UIControlStateNormal];
    }
    UIView *view = (UIView *)[self viewWithTag:button.tag + 100];
    view.hidden = YES;
}

- (void)changisClicking {
    self.isClicking = NO;
}

- (void)segmentTapped:(id)sender andScroll:(BOOL)isSroll {
    
    [self deselectAllSegments];
    UIButton *button = sender;
    [self bringSubviewToFront:button];
    if (selectedSegmentIndex != button.tag - 1) {
        selectedSegmentIndex = button.tag - 1;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    } else {
        if (isSroll == NO) {
            [self sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }
    //显示底部表示选中的横线
    UIView *indicator = [self viewWithTag:9999];
    if (indicator == nil) {
        indicator = [[UIView alloc] initWithFrame:button.frame];
        UIView *colorView;
        if (self.indicatorPosition == eIndicatorPositionBottom) {
            colorView = [[UIView alloc]
                         initWithFrame:CGRectMake(16, indicator.bounds.size.height - 3, indicator.bounds.size.width - 32, 3)];
        }
        
        colorView.backgroundColor = self.selectedColor;
        colorView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        colorView.tag = 9998;
        [indicator addSubview:colorView];
        indicator.tag = 9999;
        [self addSubview:indicator];
        [self sendSubviewToBack:indicator];
    }
    indicator.hidden = !showIndicator;
    [UIView animateWithDuration:0.2
                     animations:^{
                         indicator.frame = button.frame;
                     }];
    
    if (button.tag == 1) {
        [button setTitleColor:self.selectedColor forState:UIControlStateNormal];
        button.titleLabel.font = self.selectedFont ? self.selectedFont : self.font;
        [button setBackgroundImage:[selectedImageLeft stretchableImageWithLeftCapWidth:6 topCapHeight:0]
                          forState:UIControlStateNormal];
        
    } else if (button.tag == numberOfSegments) {
        [button setTitleColor:self.selectedColor forState:UIControlStateNormal];
        button.titleLabel.font = self.selectedFont ? self.selectedFont : self.font;
        [button setBackgroundImage:[selectedImageRight stretchableImageWithLeftCapWidth:1 topCapHeight:0]
                          forState:UIControlStateNormal];
    } else {
        [button setTitleColor:self.selectedColor forState:UIControlStateNormal];
        button.titleLabel.font = self.selectedFont ? self.selectedFont : self.font;
        [button setBackgroundImage:[selectedImageMiddle stretchableImageWithLeftCapWidth:1 topCapHeight:0]
                          forState:UIControlStateNormal];
    }
}

- (void)deselectAllSegments {
    
    for (id subview in self.subviews) {
        if (![subview isKindOfClass:[UIButton class]]) {
            continue;
        }
        UIButton *button = subview;
        if (button.tag == 1) {
            [button setTitleColor:self.titleColor forState:UIControlStateNormal];
            button.titleLabel.font = self.font;
            [button setTitleShadowColor:[UIColor colorWithWhite:1.0 alpha:1.2] forState:UIControlStateNormal];
            [button setBackgroundImage:normalImageLeft forState:UIControlStateNormal];
        } else if (button.tag == numberOfSegments) {
            [button setTitleColor:self.titleColor forState:UIControlStateNormal];
            button.titleLabel.font = self.font;
            [button setBackgroundImage:normalImageRight forState:UIControlStateNormal];
        } else {
            [button setTitleColor:self.titleColor forState:UIControlStateNormal];
            button.titleLabel.font = self.font;
            [button setBackgroundImage:normalImageMiddle forState:UIControlStateNormal];
        }
    }
}

- (void)setSelectedSegmentIndex:(NSUInteger)index {
    if (numberOfSegments < 2)
        numberOfSegments = 2;
    //    if(index != selectedSegmentIndex)
    //    {
    selectedSegmentIndex = index;
    
    if (index < numberOfSegments) {
        UIButton *button = (UIButton *)[self viewWithTag:index + 1];
        [self segmentTapped:button];
    }
    //    }
}

- (void)setSelectedSegmentIndex:(NSUInteger)index andScorll:(BOOL)isScroll {
    if (numberOfSegments < 2)
        numberOfSegments = 2;
    selectedSegmentIndex = index;
    
    if (index < numberOfSegments) {
        UIButton *button = (UIButton *)[self viewWithTag:index + 1];
        [self segmentTapped:button andScroll:isScroll];
    }
}

- (void)setShowIndicator:(BOOL)value {
    showIndicator = value;
    self.selectedSegmentIndex = self.selectedSegmentIndex;
}

- (void)setDotDisPlay:(NSMutableArray *)array numArray:(NSMutableArray *)numArray {
    for (int i = 0; i < array.count; i++) {
        NSNumber *number = [array objectAtIndex:i];
        UIView *view = (UIView *)[self viewWithTag:number.intValue + 100];
        //        for (UILabel * lable in view.subviews) {
        //            if (lable.tag == 69) {
        //                lable.text = [numArray objectAtIndexForALM:i];
        //            }
        //        }
        view.hidden = NO;
    }
}

- (void)setProgress:(float)progress andIndex:(NSInteger)index {
    [self deselectAllSegments];
    UIButton *button = (UIButton *)[self viewWithTag:index + 1];
    [button setTitleColor:self.selectedColor forState:UIControlStateNormal];
    UIView *indicator = [self viewWithTag:9999];
    indicator.frame = CGRectMake(self.bounds.size.width * progress, indicator.frame.origin.y,
                                 indicator.bounds.size.width, indicator.bounds.size.height);
    selectedSegmentIndex = index;
}

@end
