//
//  DLRainbowSegmentControl.h
//  DL_MVVM
//
//  Created by Daniel.Li on 25/10/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^IndexChangedBlock)(NSInteger index);


IB_DESIGNABLE

@interface DLRainbowSegmentControl : UIControl

/**
 支持IB拖动 ,segment上面的titles

 @param nonatomic 非原子操作
 @param copy      字符串标识符

 @return    所有的titles
 */
IBInspectable @property (nonatomic, copy) NSString *allTitles;

/**
 提供一个block，标识selecteIndex 变化，也可以通过addtarget方式来通知变化
 */
@property (nonatomic, copy) IndexChangedBlock indexChangedBloc;

/**
 选中的segment Item 的index
 */
@property (nonatomic, assign) NSInteger selectedIndex;

/**
 初始化方法

 @param titles 包含所有segmentItem的title

 @return 返回类实例
 */
- (instancetype)initWithTitles:(NSArray<NSString *> *)titles;

/**
 设置选中的index

 @param selectedIndex segment选中的index
 @param animated      是否显示动画
 */
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;

/**
 更新index的的title

 @param title title
 @param index index
 */
- (void)updateTitle:(NSString *)title atIndex:(NSInteger)index;

/**
 blocksetter方法

 @param indexChangedBloc 
 */
- (void)setIndexChangedBloc:(IndexChangedBlock)indexChangedBloc;

@end
