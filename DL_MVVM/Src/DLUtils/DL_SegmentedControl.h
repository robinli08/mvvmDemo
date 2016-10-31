//
//  DL_SegmentedControl.h
//  DL_MVVM
//
//  Created by Daniel.Li on 25/10/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _DLSegmentControlStyle {
    DLSegmentControlStyleGrouped,
    DLSegmentControlStylePlain,
    DLSegmentControlStyleMusicLibrary,
    DLSegmentControlStyleSelectCategory,  //乐馆新筛选--MV、专辑、艺人
    DLSegmentControlStyleArtistCategory,   //艺人列表页
    DLSegmentControlStyleOrderList
    
} DLSegmentControlStyle;

typedef enum {
    eIndicatorPositionBottom,
    eIndicatorPositionTop,
} eIndicatorPosition;


@interface DL_SegmentedControl : UIControl {
    NSMutableArray *segmentArray;
    NSUInteger numberOfSegments;
    NSUInteger selectedSegmentIndex;
    
    UIImage *normalImageLeft;
    UIImage *normalImageMiddle;
    UIImage *normalImageRight;  //没被选中的情况下图片的样式
    UIImage *selectedImageLeft;
    UIImage *selectedImageMiddle;
    UIImage *selectedImageRight;
    UIFont *font;
    UIFont *selectedFont;
    UIColor *titleColor;
    UIColor *selectedColor;
}
@property (nonatomic, assign) DLSegmentControlStyle style;

- (void)addSegmentButton:(UIButton *)button;
- (void)addSegmentButtons:(NSArray *)btnArray;  // uibutton array
- (void)insertSegmentButton:(UIButton *)button atIndex:(NSUInteger)index;
- (void)replaceSegmentButton:(UIButton *)button atIndex:(NSUInteger)index;

- (void)addSegmentWithTitle:(NSString *)title;
- (void)addSegmentWithTitles:(NSArray *)titleArray;
- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)index;
- (void)replaceSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)index;

- (void)removeSegmentAtIndex:(NSUInteger)index;
- (void)removeSegmentWithButton:(UIButton *)button;
- (void)removeAllSegments;

- (void)updateUI;

@property (nonatomic, strong) NSMutableArray *segmentArray;
@property (nonatomic, assign) NSUInteger numberOfSegments;
@property (nonatomic, assign) NSUInteger selectedSegmentIndex;
@property (nonatomic) CGFloat gapValue;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic, strong) UIImage *normalImageLeft;
@property (nonatomic, strong) UIImage *normalImageMiddle;
@property (nonatomic, strong) UIImage *normalImageRight;
@property (nonatomic, strong) UIImage *selectedImageLeft;
@property (nonatomic, strong) UIImage *selectedImageMiddle;
@property (nonatomic, strong) UIImage *selectedImageRight;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIFont *selectedFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, assign) BOOL showIndicator;  // 是否显示选中的横线
@property (nonatomic, assign) eIndicatorPosition indicatorPosition;
// 选中横线的位置，默认为eIndicatorPositionBottom

@property (nonatomic, strong) NSMutableArray *dotArray;

@property (nonatomic, assign) BOOL isFromMain;

@property (nonatomic, assign) BOOL isClicking;

@property (nonatomic, assign) CGFloat totalWidth;
@property (nonatomic, assign) NSInteger numberOfColumns;
/**
 *  设置segment选择进度，主要是实现scrollview的联动
 *
 *  @param progress progress description
 */
- (void)setProgress:(float)progress andIndex:(NSInteger)index;
- (void)setSelectedSegmentIndex:(NSUInteger)index andScorll:(BOOL)isScroll;

/**
 *  显示小红点
 *
 *  @param array 要显示的index数组
 *  @param numArray 显示的数字array
 */
- (void)setDotDisPlay:(NSMutableArray *)array numArray:(NSMutableArray *)numArray;


@end
