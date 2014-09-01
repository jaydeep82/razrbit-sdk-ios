//
//  RazrbitWalletServiceFacade.h
//  RazrbitHarness
//
//  Created by Derek Lee on 8/13/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RazrbitBaseServiceFacade.h"

@interface RazrbitWalletServiceFacade : RazrbitBaseServiceFacade

// WALLET

/**
 Creates a new address that can be used for transactions through Razrbit.
 @param completionBlock
 Callback executed when the asyncronous call completes. Contains two parameters: an NSDictionary of return data values for a successful call or an NSError object containing information regarding the error that was encountered.
 */
- (void)createNewAddressWithCompletion:(RazrbitCompletionBlock)completionBlock;

/**
 Sends the specified amount of satoshi from the address provided to the address provided.
 @param fromPrivateKey
 Private key of the from address; must be a valid bitcoin private key.
 @param toAddress
 To address; must be a valid bitcoin address.
 @param amount
 Amount to send in satoshi.
 @param completionBlock
 Callback executed when the asyncronous call completes. Contains two parameters: an NSDictionary of return data values for a successful call or an NSError object containing information regarding the error that was encountered.
 */
- (void)sendAmountFromPrivateKey:(NSString *)fromPrivateKey toAddress:(NSString *)toAddress amount:(long)amount completion:(RazrbitCompletionBlock)completionBlock;

/**
 Retrieves the balance of the given address in satoshi.
 @param address
 A valid bitcoin address.
 @param completionBlock
 Callback executed when the asyncronous call completes. Contains two parameters: an NSDictionary of return data values for a successful call or an NSError object containing information regarding the error that was encountered.
 */
- (void)getBalanceFromAddress:(NSString *)address completion:(RazrbitCompletionBlock)completionBlock;


@end
