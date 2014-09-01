//
//  RazrbitExplorerServiceFacade.h
//  RazrbitHarness
//
//  Created by Derek Lee on 8/13/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RazrbitBaseServiceFacade.h"

@interface RazrbitExplorerServiceFacade : RazrbitBaseServiceFacade

// EXPLORER

/**
 Retrieves blocki information from a valid block hash.
 @param blockHash
 Valid block hash value.
 @param completionBlock
 Callback executed when the asyncronous call completes. Contains two parameters: an NSDictionary of return data values for a successful call or an NSError object containing information regarding the error that was encountered.
 */
- (void)blockUsingBlockHash:(NSString *)blockHash completion:(RazrbitCompletionBlock)completionBlock;

/**
 Retrieves transaction information frmo a valid transaction hash.
 @param transactionHash
 Valid transaction hash value.
 @param completionBlock
 Callback executed when the asyncronous call completes. Contains two parameters: an NSDictionary of return data values for a successful call or an NSError object containing information regarding the error that was encountered.
 */
- (void)transactionUsingTransactionHash:(NSString *)transactionHash completion:(RazrbitCompletionBlock)completionBlock;

/**
 Retrieves address information from a valid address.
 @param address
 Valid address value.
 @param completionBlock
 Callback executed when the asyncronous call completes. Contains two parameters: an NSDictionary of return data values for a successful call or an NSError object containing information regarding the error that was encountered.
 */
- (void)addressFromAddress:(NSString *)address completion:(RazrbitCompletionBlock)completionBlock;

/**
 addressUnspentOutputs
 @param address
 Valid address value.
 @param completionBlock
 Callback executed when the asyncronous call completes. Contains two parameters: an NSDictionary of return data values for a successful call or an NSError object containing information regarding the error that was encountered.
 */
- (void)addressUnspentOutputs:(NSString *)address completion:(RazrbitCompletionBlock)completionBlock;

@end
