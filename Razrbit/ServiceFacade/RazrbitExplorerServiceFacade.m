//
//  RazrbitExplorerServiceFacade.m
//  RazrbitHarness
//
//  Created by Derek Lee on 8/13/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import "RazrbitExplorerServiceFacade.h"
#import "RazrbitAsyncCallHandler.h"

@implementation RazrbitExplorerServiceFacade

// ************************************************************************************************
//  >>>>>> EXPLORER
// ************************************************************************************************

- (void)blockUsingBlockHash:(NSString *)blockHash completion:(RazrbitCompletionBlock)completionBlock
{
    NSString *apiRoute = [self buildAPIRouteForService:@"block"];
    NSString *invocationKey = [self generateInvocationKeyForApiRoute:apiRoute];
    
    if (blockHash == nil || [blockHash isEqualToString:@""]) {
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
                               parameters:@{ @"blockHash" : blockHash }
                       completionCallBack:completionBlock];
}

- (void)transactionUsingTransactionHash:(NSString *)transactionHash completion:(RazrbitCompletionBlock)completionBlock
{
    NSString *apiRoute = [self buildAPIRouteForService:@"transaction"];
    NSString *invocationKey = [self generateInvocationKeyForApiRoute:apiRoute];
    
    if (transactionHash == nil || [transactionHash isEqualToString:@""]) {
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
                               parameters:@{ @"transactionHash" : transactionHash }
                       completionCallBack:completionBlock];
}

- (void)addressFromAddress:(NSString *)address completion:(RazrbitCompletionBlock)completionBlock
{
    NSString *apiRoute = [self buildAPIRouteForService:@"address"];
    NSString *invocationKey = [self generateInvocationKeyForApiRoute:apiRoute];
    
    if (address == nil || [address isEqualToString:@""]) {
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
                               parameters:@{ @"address" : address }
                       completionCallBack:completionBlock];
}

- (void)addressUnspentOutputs:(NSString *)address completion:(RazrbitCompletionBlock)completionBlock
{
    NSString *apiRoute = [self buildAPIRouteForService:@"addressUnspentOutputs"];
    NSString *invocationKey = [self generateInvocationKeyForApiRoute:apiRoute];
    
    if (address == nil || [address isEqualToString:@""]) {
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
                               parameters:@{ @"address" : address }
                       completionCallBack:completionBlock];
}

@end
