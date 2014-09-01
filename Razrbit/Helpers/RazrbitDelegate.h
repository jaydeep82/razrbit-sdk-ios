//
//  RazrbitDataSource.h
//  RazrbitHarness
//
//  Created by Derek Lee on 2014/08/12.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RazrbitAsyncCallHandler;

@protocol RazrbitDelegate <NSObject>

@required
- (NSString *)appId:(id)sender;
- (NSString *)appSecret:(id)sender;

- (void)serviceInvocationStarted:(id)sender asyncCallHandler:(id)razrbitCall key:(NSString *)key;
- (void)serviceInvocationCompleted:(id)sender key:(NSString *)key;

@end
