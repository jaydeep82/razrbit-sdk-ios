//
//  RazrbitNotificationsServiceFacade.h
//  RazrbitHarness
//
//  Created by Derek Lee on 8/15/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RazrbitBaseServiceFacade.h"

@interface RazrbitNotificationsServiceFacade : RazrbitBaseServiceFacade

// NOTIFICATION

/**
 notificationAddress
 @param address
 Valid address value.
 @param email
 Email address to which the data should be sent.
 @param completionBlock
 Callback executed when the asyncronous call completes. Contains two parameters: an NSDictionary of return data values for a successful call or an NSError object containing information regarding the error that was encountered.
 */
- (void)address:(NSString *)address email:(NSString *)email completion:(RazrbitCompletionBlock)completionBlock;

/**
 notificationBlocks
 @param blockHash
 Valid block hash value.
 @param email
 Email address to which the data should be sent.
 @param completionBlock
 Callback executed when the asyncronous call completes. Contains two parameters: an NSDictionary of return data values for a successful call or an NSError object containing information regarding the error that was encountered.
 */
- (void)block:(NSString *)blockHash email:(NSString *)email completion:(RazrbitCompletionBlock)completionBlock;

/**
 notificationTransactions
 @param transactionHash
 Valid transaction hash value.
 @param email
 Email address to which the data should be sent.
 @param completionBlock
 Callback executed when the asyncronous call completes. Contains two parameters: an NSDictionary of return data values for a successful call or an NSError object containing information regarding the error that was encountered.
 */
- (void)transaction:(NSString *)transactionHash email:(NSString *)email completion:(RazrbitCompletionBlock)completionBlock;

@end
