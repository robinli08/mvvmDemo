//
//  DLAPIRequestProtocol.h
//  DL_MVVM
//
//  Created by Daniel.Li on 9/22/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger,DLAPIENCodePostType){
    
};

@protocol DLAPIRequestProtocol <NSObject>

- (void)request:(NSURL*)url
         method:(NSString*)method
         header:(NSDictionary*)headers
     parameters:(NSDictionary*)parameters
 fileParameters:(NSDictionary*)fileParameters
    isMultipart:(BOOL)isMultipart
           type:()format
    cachePolicy:()policy
      cacheTime:(NSTimeInterval)cacheTime
            log:(BOOL)log
       callback:(void(^)(id JSON, NSError *error))callback;

- (void)cancel;

@end
