//
//  RazrbitMarketsServiceFacade.h
//  RazrbitHarness
//
//  Created by Derek Lee on 8/15/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RazrbitBaseServiceFacade.h"

@interface RazrbitMarketsServiceFacade : RazrbitBaseServiceFacade

// MARKETS

/**
 Retrieves the current price for the given currency.
 @param currencyCode
 Valid three-character currency code.
 @param completionBlock
 Callback executed when the asyncronous call completes. Contains two parameters: an NSDictionary of return data values for a successful call or an NSError object containing information regarding the error that was encountered.
 */
- (void)priceInCurrency:(NSString *)currencyCode completion:(RazrbitCompletionBlock)completionBlock;

/**
 Retrieves the day price for the given currency.
 @param currencyCode
 Valid three-character currency code.
 @param completionBlock
 Callback executed when the asyncronous call completes. Contains two parameters: an NSDictionary of return data values for a successful call or an NSError object containing information regarding the error that was encountered.
 */
- (void)dayPriceInCurrency:(NSString *)currencyCode completion:(RazrbitCompletionBlock)completionBlock;

/**
 Retrieves the price for the given currency for a specific day in the past.
 @param currencyCode
 Valid three-character currency code.
 @param date
 Valid historical date value. NSDate is expected.
 @param completionBlock
 Callback executed when the asyncronous call completes. Contains two parameters: an NSDictionary of return data values for a successful call or an NSError object containing information regarding the error that was encountered.
 */
- (void)historicalPriceInCurrency:(NSString *)currencyCode onDate:(NSDate *)date completion:(RazrbitCompletionBlock)completionBlock;

@end
