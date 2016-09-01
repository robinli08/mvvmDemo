//
//  NSArray+Safe.h
//  DL_MVVM
//
//  Created by Daniel.Li on 8/31/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Safe)

/**
 *  创建并返回含有anOject对象的数组
 *
 *  @param anObject anObject
 *
 *  @return 返回含有anObject的数组
 */
+ (instancetype)arrayWithObjectForDL:(id)anObject;

/**
 *  根据你index返回对应的对象,如果index越界，返回空对象，不会导致crash
 *
 *  @param index 对象的index
 *
 *  @return 返回数组中index对应的对象
 */
- (id)objectAtIndexForDL:(NSUInteger)index;


/**
 *  返回一个新数组是原有数组添加了anObject之后的拷贝
 *
 *  @param anObject 需要添加到数组的Object
 *
 *  @return 返回一个新的数组是原有数组的添加anObject只有的拷贝
 */
- (NSArray *)arrayByAddingObjectForDL:(id)anObject;

/**
 *  返回一个新的数组包含在所给的range范围内
 *
 *  @param range range
 *
 *  @return 返回一个新的数组包含原有数组的range范围之内
 */
- (NSArray *)subarrayWithRangeForDL:(NSRange)range;

/**
 *  Copies the objects contained in the array that fall within the specified range to aBuffer.
 *
 *  @param objects A C array of objects of size at least the length of the range specified by aRange.
 *  @param range   A range within the bounds of the array.
 */
- (void)getObjectsForDL:(id __unsafe_unretained[])objects range:(NSRange)range;

/**
 *  Returns an array containing the objects in the array at the indexes specified by a given index set.
 *
 *  @param indexes An array containing the objects in the array at the indexes specified by indexes.
 *
 *  @return An array containing the objects in the array at the indexes specified by indexes.
 */
- (NSArray *)objectsAtIndexesForDL:(NSIndexSet *)indexes;

/**
 *  Creates and returns an array containing the objects in another given array.
 *
 *  @param array An array.
 *
 *  @return An array containing the objects in anArray.
 */
+ (NSArray *)arrayWithArrayForDL:(NSArray *)array;


@end
