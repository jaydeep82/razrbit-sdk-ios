//
//  RazrbitNetworkServiceFacade.m
//  RazrbitHarness
//
//  Created by Derek Lee on 8/15/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import "RazrbitNetworkServiceFacade.h"
#import "RazrbitAsyncCallHandler.h"

@implementation RazrbitNetworkServiceFacade

// **********************************************************************************************
//  >>>>>> NETWORK
// **********************************************************************************************

- (void)getDifficultyWithCompletion:(RazrbitCompletionBlock)completionBlock
{
    NSString *apiRoute = [self buildAPIRouteForService:@"getDifficulty"];
    NSString *invocationKey = [self generateInvocationKeyForApiRoute:apiRoute];
    
    RazrbitAsyncCallHandler *razrbitCall = [[RazrbitAsyncCallHandler alloc] initWithDelegate:self.delegate
                                                                            invocationKey:invocationKey];
    
    // Hold onto the object until the invocation is completed.
    [self.delegate serviceInvocationStarted:self asyncCallHandler:razrbitCall key:invocationKey];
    
    [razrbitCall invokeServiceWithApiRoute:apiRoute
                               parameters:nil
                       completionCallBack:completionBlock];
}

- (void)pushTransaction:(NSString *)transaction completion:(RazrbitCompletionBlock)completionBlock
{
    NSString *apiRoute = [self buildAPIRouteForService:@"pushTransaction"];
    NSString *invocationKey = [self generateInvocationKeyForApiRoute:apiRoute];
    
    if (transaction == nil || [transaction isEqualToString:@""]) {
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
                               parameters:@{ @"transaction" : transaction }
                       completionCallBack:completionBlock];
}

@end
