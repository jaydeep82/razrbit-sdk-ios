//
//  RazrbitNotificationsServiceFacade.m
//  RazrbitHarness
//
//  Created by Derek Lee on 8/15/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import "RazrbitNotificationsServiceFacade.h"
#import "RazrbitAsyncCallHandler.h"

@implementation RazrbitNotificationsServiceFacade

// *************************************************************************************************
//  >>>>>> NOTIFICATION
// *************************************************************************************************

- (void)address:(NSString *)address email:(NSString *)email completion:(RazrbitCompletionBlock)completionBlock
{
    NSString *apiRoute = [self buildAPIRouteForService:@"address"];
    NSString *invocationKey = [self generateInvocationKeyForApiRoute:apiRoute];
    
    if (address == nil || [address isEqualToString:@""] ||
        email == nil || [email isEqualToString:@""]) {
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
                               parameters:@{ @"address" : address,
                                             @"email" : email }
                       completionCallBack:completionBlock];
}

- (void)block:(NSString *)blockHash email:(NSString *)email completion:(RazrbitCompletionBlock)completionBlock
{
    NSString *apiRoute = [self buildAPIRouteForService:@"block"];
    NSString *invocationKey = [self generateInvocationKeyForApiRoute:apiRoute];
    
    if (blockHash == nil || [blockHash isEqualToString:@""] ||
        email == nil || [email isEqualToString:@""]) {
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
                               parameters:@{ @"blockHash" : blockHash,
                                             @"email" : email }
                       completionCallBack:completionBlock];
}

- (void)transaction:(NSString *)transactionHash email:(NSString *)email completion:(RazrbitCompletionBlock)completionBlock
{
    NSString *apiRoute = [self buildAPIRouteForService:@"transaction"];
    NSString *invocationKey = [self generateInvocationKeyForApiRoute:apiRoute];
    
    if (transactionHash == nil || [transactionHash isEqualToString:@""] ||
        email == nil || [email isEqualToString:@""]) {
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
                               parameters:@{ @"transactionHash" : transactionHash,
                                             @"email" : email }
                       completionCallBack:completionBlock];
}

@end
