//
//  NSString+DL_StringUtil.m
//  DL_MVVM
//
//  Created by Daniel.Li on 8/15/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "NSString+DL_StringUtil.h"

@implementation NSString (DL_StringUtil)

- (CGSize)dl_sizeWithFont:(UIFont *)font {
    
    CGSize size;
    if ([self respondsToSelector:@selector(sizeWithAttributes:)]) {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(sizeWithAttributes:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(sizeWithAttributes:)];
        NSDictionary *attributesDic = @{NSFontAttributeName:font};
        [invocation setArgument:&attributesDic atIndex:2];
        [invocation invoke];
        [invocation getReturnValue:&size];
    } else {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(sizeWithFont:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(sizeWithFont:)];
        [invocation setArgument:&font atIndex:2];
        [invocation invoke];
        [invocation getReturnValue:&size];
    }
    return size;
}

- (CGSize)dl_sizewithfont:(UIFont *)font constrainedToSize:(CGSize)size {
    
    CGSize resultSize;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:context:)]) {
        NSMethodSignature *sinature = [[self class] instanceMethodSignatureForSelector:@selector(boundingRectWithSize:options:context:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sinature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(boundingRectWithSize:options:context:)];
        NSDictionary *attributesDic = @{NSFontAttributeName:font};
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
        NSStringDrawingContext *context;
        [invocation setArgument:&size atIndex:2];
        [invocation setArgument:&options atIndex:3];
        [invocation setArgument:&attributesDic atIndex:4];
        [invocation setArgument:&context atIndex:5];
        [invocation invoke];
        CGRect rect;
        [invocation getReturnValue:&rect];
        resultSize = rect.size;
    } else {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:@selector(sizeWithFont:constrainedToSize:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(sizeWithFont:constrainedToSize:)];
        [invocation setArgument:&font atIndex:2];
        [invocation setArgument:&size atIndex:3];
        [invocation invoke];
        [invocation getReturnValue:&resultSize];
    }
    return resultSize;
}

- (CGSize)dl_sizeWithAttributes:(NSDictionary *)attributes constrainedToSize:(CGSize)size {
    
    CGSize resultSize;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:context:)]) {
        NSMethodSignature *sinature = [[self class] instanceMethodSignatureForSelector:@selector(boundingRectWithSize:options:context:)];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sinature];
        [invocation setTarget:self];
        [invocation setSelector:@selector(boundingRectWithSize:options:context:)];
        NSDictionary *attributesDic = attributes;
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
        NSStringDrawingContext *context;
        [invocation setArgument:&size atIndex:2];
        [invocation setArgument:&options atIndex:3];
        [invocation setArgument:&attributesDic atIndex:4];
        [invocation setArgument:&context atIndex:5];
        [invocation invoke];
        CGRect rect;
        [invocation getReturnValue:&rect];
        resultSize = rect.size;
    }
    return resultSize;
}

@end
