//
//  DLOptionsView.h
//  DL_MVVM
//
//  Created by Daniel.Li on 23/11/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DLOptionsViewDelegate;
@interface DLOptionsView : UIScrollView {
    BOOL _horizontal;
}

@property (nonatomic, strong) NSArray *options; // 按钮的标题.
@property (nonatomic, strong) NSArray *optionButtons; // 按钮列表
@property (nonatomic, assign) CGSize buttonSize; // 按钮的大小
@property (nonatomic, strong) UIFont *font;     // 按钮字体
@property (nonatomic, strong) UIFont *selectedFont; // 选中之后的字体
@property (nonatomic, assign) CGFloat space; // 两个按钮水平间距
@property (nonatomic, assign) BOOL evenlyDistributed; // 分散布局按钮, 填满options view, 忽略space。

@property (nonatomic, assign) UIEdgeInsets edgeInsets; // 四周留出的空白, 如果实现了
@property (nonatomic, strong) UIImage *buttonBgImage; // 按钮Normal状态下的background image
@property (nonatomic, strong) UIImage *buttonSelectedBgImage; // 按钮选择状态下的Image

@property (nonatomic, strong) UIImage *buttonPaddingImage;  // button之间的分割图片

@property (nonatomic, strong) UIColor *buttonTitleNormalColor;
@property (nonatomic, strong) UIColor *buttonTitleHighlightedColor;
@property (nonatomic, strong) UIColor *buttonTitleSelectedColor;

@property (nonatomic, assign) UIEdgeInsets buttonContentEdgeInsets;

@property (nonatomic, strong) UIImageView *selectedBgView; // 选中后按钮的背景视图
@property (nonatomic, strong) UIImage *selectedOptionsBgImage;  // 选中后按钮的背景视图图片, 切换选中时有动画
@property (nonatomic, assign) UIEdgeInsets selectedBgViewEdgeInsets;
@property (nonatomic, assign) BOOL enableBgViewMoveAnimation; // 是否开启按钮背景图移动动画

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong, getter = selectedOption) NSString *selectedOption;

@property (nonatomic, weak) IBOutlet id<DLOptionsViewDelegate> optionsViewDelegate;

@property (nonatomic, readonly, getter = isHorizontal) BOOL horizontal;

@property (nonatomic, assign) BOOL btnFrameFromDelegate;                // 控制按钮的frame是否从delegate获取，若为NO，frame根据buttonSize，space，horizontal计算。默认为NO
@property (nonatomic, assign) BOOL adjustsBtnWidthToFitTitle;           // 根据Title 大小自动调节按钮大小，并以buttonSize.width为最小width。当btnFrameFromDelegate时无效。默认为NO

@property (nonatomic, assign) BOOL isShowUnderline;    //选中按钮的下划线

@property (nonatomic, assign) BOOL isShowBottomLine;
@property (nonatomic, strong) UIColor *bottonLineColor;

@property (nonatomic, assign) BOOL isShowSeparateLine; //分割线
@property (nonatomic, strong) UIColor *separateLineColor;

@property (nonatomic, strong) UIView *underline;

/*
 如果underlineWidth外部设置为0 就默认自动改变宽度
 */
@property (nonatomic, assign) CGFloat underlineWidth;

- (id)initWithFrame:(CGRect)frame horizontal:(BOOL)horizontal;

// 摆放Option Buttons.
- (void)reloadOptionButtons;

// 让Option Button显示出来.
- (void)setOptionButtonVisibleAtIndex:(NSInteger)index animated:(BOOL)animated;

@end


@protocol DLOptionsViewDelegate <UIScrollViewDelegate>

@optional

- (CGRect)optionsView:(DLOptionsView *)optionsView frameOfButtonAtIndex:(NSUInteger)index;

- (void)optionsView:(DLOptionsView *)optionsView drawItemAtIndex:(NSUInteger)index;

/**
 *  button选中且和上次选中不同时才被调用
 */
- (void)optionsView:(DLOptionsView *)optionsView optionDeselectedFromIndex:(NSUInteger)index;

/**
 *  button选中且和上次选中不同时才被调用
 */
- (void)optionsView:(DLOptionsView *)optionsView optionSelectedAtIndex:(NSUInteger)index;

/**
 *  button选中时都调用
 */
- (void)optionsView:(DLOptionsView *)optionsView
optionSelectedFromIndex:(NSUInteger)fromIndex
            toIndex:(NSUInteger)toIndex;


@end
