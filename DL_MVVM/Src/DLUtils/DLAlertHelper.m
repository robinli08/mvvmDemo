//
//  HXAlertHelper.m
//  alertDemo
//
//  Created by Daniel.Li on 7/26/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "DLAlertHelper.h"
#import <objc/runtime.h>
#import "UIView+HXUtility.h"

typedef void(^onTouch)(UIView *);
@interface HXMaskView : UIView

@property (nonatomic, copy) onTouch action;

@end

@implementation HXMaskView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor blackColor];
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.action(self);
}

- (void)dealloc {
    self.action = nil;
}

@end

#pragma mark ------------------ alertHelper --------------------

BOOL isStringNull(id value) {
    return (!value || [value isKindOfClass:[NSNull class]]);
}
BOOL isEmptyString(id value) {
    return (isStringNull(value) || [value isEqual:@""] || [value isEqual:@"(null)"]);
}

static char COMPLETE_ALERT_BLOCK;
static char COMPLETE_ALERT_TEXT_BLOCK;
static char COMPLETE_ALERT_SELECT_BLOCK;
static char VIEW_ALERT_BLOCK;
static int viewCount;
BOOL buttonSelected;


HXMaskView *actionSheetMaskView;
NSMutableArray<UIView *> *showViewMutableArray;
UIView *actionSheetView1;
UIView *inView;
NSString *putInText;
UILabel *upNumLabel;
NSInteger inputMaxLength;


@interface DLAlertHelper ()


@end

@implementation DLAlertHelper

+ (void)showWithView:(UIView *)view cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle block:(void(^)(NSInteger buttonIndex,UIView *view))block {
    
    inView = view;
    [[self class] selfInitView];
    actionSheetMaskView.action = ^(UIView *mask){
        
    };
    
    showViewMutableArray[viewCount] = [[UIView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2, 0, 0)];
    showViewMutableArray[viewCount].backgroundColor = [UIColor grayColor];
    [actionSheetMaskView addSubview:showViewMutableArray[viewCount]];
    actionSheetMaskView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.06f];
    
    if (isEmptyString(otherButtonTitle)) {
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, view.frame.size.height + 5, 280, 30)];
        cancelButton.backgroundColor = [UIColor clearColor];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cancelButton addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(cancelButton, &VIEW_ALERT_BLOCK, block, OBJC_ASSOCIATION_COPY);
        [showViewMutableArray[viewCount] addSubview:cancelButton];
        [showViewMutableArray[viewCount] addSubview:view];

    } else {
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, view.frame.size.height + 5, 140, 30)];
        cancelButton.backgroundColor = [UIColor clearColor];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cancelButton addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(cancelButton, &VIEW_ALERT_BLOCK, block, OBJC_ASSOCIATION_COPY);
        
        UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(140, view.frame.size.height + 5, 140, 30)];
        confirmButton.backgroundColor = [UIColor clearColor];
        [confirmButton setTitle:otherButtonTitle forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
        confirmButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [confirmButton addTarget:self action:@selector(onConfirm:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(confirmButton, &VIEW_ALERT_BLOCK, block, OBJC_ASSOCIATION_COPY);
        
        UIView *sepeLineVertical = [[UIView alloc] initWithFrame:CGRectMake(140, view.frame.size.height, 0.5, 45)];
        sepeLineVertical.backgroundColor = [UIColor grayColor];
        
        [showViewMutableArray[viewCount] addSubview:sepeLineVertical];
        [showViewMutableArray[viewCount] addSubview:cancelButton];
        [showViewMutableArray[viewCount] addSubview:confirmButton];
        [showViewMutableArray[viewCount] addSubview:view];

    }
    UIView *sepeLineHorizontal = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height, 280, 0.5)];
    sepeLineHorizontal.backgroundColor = [UIColor redColor];
    [showViewMutableArray[viewCount] addSubview:sepeLineHorizontal];
    
    showViewMutableArray[viewCount].frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 280)/2 ,([[UIScreen mainScreen] bounds].size.height - (40 + view.frame.size.height))/2, 280, 40 + view.frame.size.height);
    showViewMutableArray[viewCount].backgroundColor = [UIColor greenColor];
    showViewMutableArray[viewCount].layer.masksToBounds = YES;
    showViewMutableArray[viewCount].layer.cornerRadius = 8;
    
    [[self class] forIOS7Landscape];
    [DLAlertHelper exChangeOut:showViewMutableArray[viewCount] dur:0.2];

}

+ (void)showWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle block:(void(^)(NSInteger buttonIndex))block {
    [[self class] selfInitView];
    actionSheetMaskView.action = ^(UIView* mask){
        
    };
    
    showViewMutableArray[viewCount] = [[UIView alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2, 0, 0)];
    showViewMutableArray[viewCount].backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.06f];
    
    [actionSheetMaskView addSubview:showViewMutableArray[viewCount]];
    
    actionSheetMaskView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
    //add bottomView
    if (isEmptyString(title)) {
        
    }
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 280, 16)];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(42, titleLabel.frame.origin.y + titleLabel.frame.size.height + 10, 196, 20)];
    messageLabel.text = message;
    [messageLabel setNumberOfLines:0];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageLabel.font = [UIFont systemFontOfSize:14];
    messageLabel.textColor = [UIColor blackColor];
    
    CGSize size = CGSizeMake(196,2000);
    CGSize labelSize = [message boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    messageLabel.frame = CGRectMake(42, titleLabel.frame.origin.y + titleLabel.frame.size.height + 10, 196, labelSize.height);
    messageLabel.backgroundColor = [UIColor greenColor];
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, messageLabel.bottom + 20 + 5, 280, 30)];
    cancelButton.backgroundColor = [UIColor redColor];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [cancelButton addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(cancelButton, &COMPLETE_ALERT_BLOCK, block, OBJC_ASSOCIATION_COPY);
    
    [showViewMutableArray[viewCount] addSubview:titleLabel];
    [showViewMutableArray[viewCount] addSubview:messageLabel];
    [showViewMutableArray[viewCount] addSubview:cancelButton];
    
    UIView *sepeLineHorizontal = [[UIView alloc] initWithFrame:CGRectMake(0, cancelButton.frame.origin.y - 5, 280, 0.5)];
    sepeLineHorizontal.backgroundColor = [UIColor lightGrayColor];
    [showViewMutableArray[viewCount] addSubview:sepeLineHorizontal];
    
    showViewMutableArray[viewCount].frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 280)/2 ,([[UIScreen mainScreen] bounds].size.height - (40 + cancelButton.bottom + 20))/2, 280, cancelButton.bottom + 5);
    showViewMutableArray[viewCount].backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    showViewMutableArray[viewCount].layer.masksToBounds = YES;
    showViewMutableArray[viewCount].layer.cornerRadius = 8;
    
    [[self class] forIOS7Landscape];
    [DLAlertHelper exChangeOut:showViewMutableArray[viewCount] dur:0.2];
    
}


/**
 *  弹出一个alertView
 *
 *  @param title             alertView的标题
 *  @param message           alert的中间的提示信息
 *  @param cancelButtonTitle 左边的取消按钮，切index的值为-1
 *  @param otherButtonTitle  右边的button的Index
 *  @param block             点击按钮之后的回调的block
 */

+ (void) showWithTitle:(NSString*) title
               message:(NSString*) message
     cancelButtonTitle:(NSString*) cancelButtonTitle
      otherButtonTitle:(NSString*) otherButtonTitle
                 block:(void(^)(NSInteger buttonIndex))block {
    [[self class] selfInitView];
    
    actionSheetMaskView.action = ^(UIView* mask){
        
    };
    
    showViewMutableArray[viewCount] = [[UIView alloc] initWithFrame:CGRectZero];
    showViewMutableArray[viewCount].backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    [actionSheetMaskView addSubview:showViewMutableArray[viewCount]];
    
    actionSheetMaskView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 280, 16)];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(42, titleLabel.frame.origin.y + titleLabel.frame.size.height + 10, 196, 20)];
    messageLabel.text = message;
    [messageLabel setNumberOfLines:0];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageLabel.font = [UIFont systemFontOfSize:14];
    messageLabel.textColor = [UIColor darkGrayColor];
    
    CGSize size = CGSizeMake(196,2000);
    CGSize labelSize = [message boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    messageLabel.frame = CGRectMake(42, titleLabel.frame.origin.y + titleLabel.frame.size.height + 10, 196, labelSize.height);
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, messageLabel.frame.origin.y + messageLabel.frame.size.height + 20 + 5, 280, 30)];
    if (isEmptyString(message)) {
        messageLabel.bottom = titleLabel.frame.origin.y + titleLabel.frame.size.height;
    }
    if (isEmptyString(otherButtonTitle)) {
        cancelButton.frame = CGRectMake(0, messageLabel.frame.origin.y + messageLabel.frame.size.height + 20 + 5, 280, 30);
        cancelButton.backgroundColor = [UIColor clearColor];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cancelButton addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(cancelButton, &COMPLETE_ALERT_BLOCK, block, OBJC_ASSOCIATION_COPY);
        
    } else {
        cancelButton.frame =  CGRectMake(0, messageLabel.frame.origin.y + messageLabel.frame.size.height + 20 + 5, 140, 30);
        cancelButton.backgroundColor = [UIColor clearColor];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [cancelButton addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(cancelButton, &COMPLETE_ALERT_BLOCK, block, OBJC_ASSOCIATION_COPY);
        
        UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(140, messageLabel.frame.origin.y + messageLabel.frame.size.height + 20 + 5, 140, 30)];
        confirmButton.backgroundColor = [UIColor clearColor];
        [confirmButton setTitle:otherButtonTitle forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
        confirmButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [confirmButton addTarget:self action:@selector(onConfirm:) forControlEvents:UIControlEventTouchUpInside];
        objc_setAssociatedObject(confirmButton, &COMPLETE_ALERT_BLOCK, block, OBJC_ASSOCIATION_COPY);
        
        UIView *sepeLineVertical = [[UIView alloc] initWithFrame:CGRectMake(140, messageLabel.frame.origin.y + messageLabel.frame.size.height + 20, 0.5, 45)];
        sepeLineVertical.backgroundColor = [UIColor lightGrayColor];
        
        [showViewMutableArray[viewCount] addSubview:sepeLineVertical];
        [showViewMutableArray[viewCount] addSubview:confirmButton];
    }
    [showViewMutableArray[viewCount] addSubview:titleLabel];
    if (!isEmptyString(message)) {
        [showViewMutableArray[viewCount] addSubview:messageLabel];
    }
    [showViewMutableArray[viewCount] addSubview:cancelButton];
    UIView *sepeLineHorizontal = [[UIView alloc] initWithFrame:CGRectMake(0, cancelButton.frame.origin.y - 5, 280, 0.5)];
    sepeLineHorizontal.backgroundColor = [UIColor lightGrayColor];
    [showViewMutableArray[viewCount] addSubview:sepeLineHorizontal];
    
    showViewMutableArray[viewCount].frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 280)/2 ,([[UIScreen mainScreen] bounds].size.height - (40 + cancelButton.frame.origin.y + cancelButton.frame.size.height + 20))/2, 280, cancelButton.frame.origin.y + cancelButton.frame.size.height + 10);
    showViewMutableArray[viewCount].backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
    showViewMutableArray[viewCount].layer.masksToBounds = YES;
    showViewMutableArray[viewCount].layer.cornerRadius = 8;
    
    [[self class] forIOS7Landscape];
    [DLAlertHelper exChangeOut:showViewMutableArray[viewCount] dur:0.2];
    
}



+ (void)forIOS7Landscape {
    if (([[[UIDevice currentDevice]systemVersion] floatValue] <= 8.0) && (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft)|([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight))) {
        CGAffineTransform transform = CGAffineTransformIdentity;
        if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) {
            transform = CGAffineTransformRotate(transform, M_PI * 3/2);
        }else if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
            transform = CGAffineTransformRotate(transform, M_PI / 2);
        }
        
        actionSheetView1 = [[UIView alloc] initWithFrame:actionSheetMaskView.bounds];
        [showViewMutableArray[viewCount] removeFromSuperview];
        [actionSheetMaskView addSubview:actionSheetView1];
        [actionSheetView1 addSubview:showViewMutableArray[viewCount]];
        actionSheetView1.transform = transform;
    }
}


+ (void) onConfirm:(id)sender {
    typedef void(^CompleteBlock) (NSInteger buttonIndex);
    CompleteBlock block = objc_getAssociatedObject(sender, &COMPLETE_ALERT_BLOCK);
    typedef void(^CompleteViewBlock) (NSInteger buttonIndex,UIView *view);
    CompleteViewBlock viewBlock = objc_getAssociatedObject(sender, &VIEW_ALERT_BLOCK);
    typedef void(^CompleteTextBlock) (NSInteger buttonIndex,NSString *string);
    CompleteTextBlock textblock = objc_getAssociatedObject(sender, &COMPLETE_ALERT_TEXT_BLOCK);
    typedef void(^CompleteSelectBlock) (NSInteger buttonIndex,BOOL yn);
    CompleteSelectBlock selectblock = objc_getAssociatedObject(sender, &COMPLETE_ALERT_SELECT_BLOCK);
    if (viewBlock) {
        objc_setAssociatedObject(self, &VIEW_ALERT_BLOCK, nil, OBJC_ASSOCIATION_COPY);
        viewBlock(0,inView);
        [self dismissWindow];
    }
    if (block) {
        objc_setAssociatedObject(self, &COMPLETE_ALERT_BLOCK, nil, OBJC_ASSOCIATION_COPY);
        block(0);
        [self dismissWindow];
    }
    if (textblock) {
        objc_setAssociatedObject(self, &COMPLETE_ALERT_TEXT_BLOCK, nil, OBJC_ASSOCIATION_COPY);
        textblock(0,putInText);
        [self dismissWindow];
    }
    if (selectblock) {
        objc_setAssociatedObject(self, &COMPLETE_ALERT_SELECT_BLOCK, nil, OBJC_ASSOCIATION_COPY);
        selectblock(0,buttonSelected);
        [self dismissWindow];
    }
}


+ (void) onCancel:(id)sender {
    typedef void(^CompleteBlock) (NSInteger buttonIndex);
    CompleteBlock block = objc_getAssociatedObject(sender, &COMPLETE_ALERT_BLOCK);
    typedef void(^CompleteViewBlock) (NSInteger buttonIndex,UIView *view);
    CompleteViewBlock viewBlock = objc_getAssociatedObject(sender, &VIEW_ALERT_BLOCK);
    if (viewBlock) {
        objc_setAssociatedObject(self, &VIEW_ALERT_BLOCK, nil, OBJC_ASSOCIATION_COPY);
        viewBlock(-1,inView);
        [self dismissWindow];
    }
    if (block) {
        objc_setAssociatedObject(self, &COMPLETE_ALERT_BLOCK, nil, OBJC_ASSOCIATION_COPY);
        block(-1);
        [self dismissWindow];
    }
    [self dismissWindow];
}

+ (void)dismissWindow {
    if ([showViewMutableArray count] > 1) {
        [[showViewMutableArray lastObject] removeFromSuperview];
        [showViewMutableArray removeLastObject];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            
        } completion:^(BOOL finished) {
            
        }];
        actionSheetMaskView.alpha = 0;
        [[showViewMutableArray lastObject] removeFromSuperview];
        [showViewMutableArray removeLastObject];
        [actionSheetMaskView removeFromSuperview];
        actionSheetMaskView = nil;
        actionSheetView1 = nil;
        inView = nil;
        putInText = nil;
        upNumLabel = nil;
    }
}

+(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:nil];
}


+ (void)selfInitView {
    viewCount = (int)[showViewMutableArray count];
    if (viewCount == 0) {
        showViewMutableArray = [[NSMutableArray alloc] initWithCapacity:20];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window endEditing:YES];
        actionSheetMaskView = [[HXMaskView alloc] initWithFrame:window.bounds];
        [window addSubview:actionSheetMaskView];
        actionSheetMaskView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.3f];
    }
}


@end
