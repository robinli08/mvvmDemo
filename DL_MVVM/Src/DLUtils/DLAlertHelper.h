//
//  HXAlertHelper.h
//  alertDemo
//
//  Created by Daniel.Li on 7/26/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface DLAlertHelper : NSObject

/**
 *  传入自定义的view 弹出alertView
 *
 *  @param view              传入自定义view
 *  @param cancelButtonTitle 取消按钮标题
 *  @param otherButtonTitle  确定按钮标题
 *  @param block             点击确定按钮后的回调 buttionIndex从-1开始，暂不建议使用
 */
+ (void)showWithView:(UIView *)view
   cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitle:(NSString *)otherButtonTitle
               block:(void(^)(NSInteger buttonIndex,UIView *view))block;

/**
 *  仅仅提示，只有一个选择
 *
 *  @param title             弹框标题
 *  @param message           弹框消息
 *  @param cancelButtonTitle 确定按钮标题
 *  @param block             点击确定按钮后的回调;buttonIndex从-1开始
 */
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
    cancelButtonTitle:(NSString *)cancelButtonTitle
                block:(void(^)(NSInteger buttonIndex))block;

/**
 *  弹出一个alertView
 *
 *  @param title             alertView的标题
 *  @param message           alert的中间的提示信息
 *  @param cancelButtonTitle 最左边的按钮，且index的值为-1
 *  @param otherButtonTitle  右边的button的Index
 *  @param block             点击按钮之后的回调的block
 */
+ (void) showWithTitle:(NSString*)title
               message:(NSString*)message
     cancelButtonTitle:(NSString*)cancelButtonTitle
      otherButtonTitle:(NSString*)otherButtonTitle
                 block:(void(^)(NSInteger buttonIndex))block;


@end
