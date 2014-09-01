//
//  RazrbitMarketsServiceFacade.m
//  RazrbitHarness
//
//  Created by Derek Lee on 8/15/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import "RazrbitMarketsServiceFacade.h"
#import "RazrbitAsyncCallHandler.h"

@implementation RazrbitMarketsServiceFacade

// *************************************************************************************************
//  >>>>>> MARKETS
// *************************************************************************************************

- (void)priceInCurrency:(NSString *)currencyCode completion:(RazrbitCompletionBlock)completionBlock
{
    NSString *apiRoute = [self buildAPIRouteForService:@"price"];
    NSString *invocationKey = [self generateInvocationKeyForApiRoute:apiRoute];
    
    if (currencyCode == nil || [currencyCode isEqualToString:@""]) {
        NSError *error = [[NSError alloc] initWithDomain:kRazrbitErrorDomain
                                                    code:kRazrbitErrorCodeMissingInputParameter
                                                userInfo:@{ NSLocalizedDescriptionKey : kRazrbitErrorMsgMissingInputParameter }];
        completionBlock(nil, error);
        return;
    }
    
    RazrbitAsyncCallHandler *razrbitCall = [[RazrbitAsyncCallHandler alloc] initWithDelegate:self.delegate
                                                                            invocationKey:invocationKey];
    
    // Hold onto the object until the invocation is completed.
    [self.delegate serviceInvocationStarted:self asyncCallHandler:razrbitCall key:invocationKey];
    
    [razrbitCall invokeServiceWithApiRoute:apiRoute
                               parameters:@{ @"currencyCode" : currencyCode }
                       completionCallBack:completionBlock];
}

- (void)dayPriceInCurrency:(NSString *)currencyCode completion:(RazrbitCompletionBlock)completionBlock
{
    NSString *apiRoute = [self buildAPIRouteForService:@"dayPrice"];
    NSString *invocationKey = [self generateInvocationKeyForApiRoute:apiRoute];
    
    if (currencyCode == nil || [currencyCode isEqualToString:@""]) {
        NSError *error = [[NSError alloc] initWithDomain:kRazrbitErrorDomain
                                                    code:kRazrbitErrorCodeMissingInputParameter
                                                userInfo:@{ NSLocalizedDescriptionKey : kRazrbitErrorMsgMissingInputParameter }];
        completionBlock(nil, error);
        return;
    }
    
    RazrbitAsyncCallHandler *razrbitCall = [[RazrbitAsyncCallHandler alloc] initWithDelegate:self.delegate
                                                                            invocationKey:invocationKey];
    
    // Hold onto the object until the invocation is completed.
    [self.delegate serviceInvocationStarted:self asyncCallHandler:razrbitCall key:invocationKey];
    
    [razrbitCall invokeServiceWithApiRoute:apiRoute
                               parameters:@{ @"currencyCode" : currencyCode }
                       completionCallBack:completionBlock];
}

- (void)historicalPriceInCurrency:(NSString *)currencyCode onDate:(NSDate *)date completion:(RazrbitCompletionBlock)completionBlock
{
    NSString *apiRoute = [self buildAPIRouteForService:@"historicalPrice"];
    NSString *invocationKey = [self generateInvocationKeyForApiRoute:apiRoute];
    
    if (currencyCode == nil || [currencyCode isEqualToString:@""] ||
        date == nil) {
        NSError *error = [[NSError alloc] initWithDomain:kRazrbitErrorDomain
                                                    code:kRazrbitErrorCodeMissingInputParameter
                                                userInfo:@{ NSLocalizedDescriptionKey : kRazrbitErrorMsgMissingInputParameter }];
        completionBlock(nil, error);
        return;
    }
    
    // Take the date that was passed in and specifically format it in the way that the service is expecting.
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    
    RazrbitAsyncCallHandler *razrbitCall = [[RazrbitAsyncCallHandler alloc] initWithDelegate:self.delegate
                                                                            invocationKey:invocationKey];
    
    // Hold onto the object until the invocation is completed.
    [self.delegate serviceInvocationStarted:self asyncCallHandler:razrbitCall key:invocationKey];
    
    [razrbitCall invokeServiceWithApiRoute:apiRoute
                               parameters:@{ @"currencyCode" : currencyCode,
                                             @"date" : formattedDateString }
                       completionCallBack:completionBlock];
}

@end
