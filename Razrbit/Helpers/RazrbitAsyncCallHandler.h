//
//  RazrbitAsyncCallHandler.h
//  RazrbitHarness
//
//  Created by Derek Lee on 2014/08/12.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <Availability.h>
#import <Foundation/Foundation.h>
#import "RazrbitConstants.h"
#import "RazrbitDelegate.h"

@interface RazrbitAsyncCallHandler : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property BOOL saveResponseToKeychain;

- (id)initWithDelegate:(id<RazrbitDelegate>)delegate invocationKey:(NSString *)key;
- (void)invokeServiceWithApiRoute:(NSString *)apiRoute parameters:(NSDictionary *)parameters completionCallBack:(RazrbitCompletionBlock)completionBlock;

@end
