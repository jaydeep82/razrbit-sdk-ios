//
//  RazrbitNetworkServiceFacade.h
//  RazrbitHarness
//
//  Created by Derek Lee on 8/15/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RazrbitBaseServiceFacade.h"

@interface RazrbitNetworkServiceFacade : RazrbitBaseServiceFacade

// NETWORK

/**
 Retrieves the current difficulty level.
 @param completionBlock
 Callback executed when the asyncronous call completes. Contains two parameters: an NSDictionary of return data values for a successful call or an NSError object containing information regarding the error that was encountered.
 */
- (void)getDifficultyWithCompletion:(RazrbitCompletionBlock)completionBlock;

/**
 Pushes a transaction through to completion for a transaction that has not yet been executed.
 @param transaction
 Valid transaction ID.
 @param completionBlock
 Callback executed when the asyncronous call completes. Contains two parameters: an NSDictionary of return data values for a successful call or an NSError object containing information regarding the error that was encountered.
 */
- (void)pushTransaction:(NSString *)transaction completion:(RazrbitCompletionBlock)completionBlock;

@end
