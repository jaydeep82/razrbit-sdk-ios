//
//  RazrbitWalletServiceFacade.m
//  RazrbitHarness
//
//  Created by Derek Lee on 8/13/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import "RazrbitWalletServiceFacade.h"

@implementation RazrbitWalletServiceFacade

// ************************************************************************************************
//  >>>>>> WALLET
// ************************************************************************************************

- (void)createNewAddressWithCompletion:(RazrbitCompletionBlock)completionBlock
{
    NSString *apiRoute = [self buildAPIRouteForService:@"createNewAddress"];
    NSString *invocationKey = [self generateInvocationKeyForApiRoute:apiRoute];
    
    RazrbitAsyncCallHandler *razrbitCall = [[RazrbitAsyncCallHandler alloc] initWithDelegate:self.delegate
                                                                            invocationKey:invocationKey];
    razrbitCall.saveResponseToKeychain = YES;
    
    // Hold onto the object until the invocation is completed.
    [self.delegate serviceInvocationStarted:self asyncCallHandler:razrbitCall key:invocationKey];

    [razrbitCall invokeServiceWithApiRoute:apiRoute
                               parameters:nil
                       completionCallBack:completionBlock];
}

#if defined(__IPHONE_8_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
- (void)sendAmountFromPrivateKeyInKeychainToAddress:(NSString *)toAddress amount:(long)amount completion:(RazrbitCompletionBlock)completionBlock {
    
    if (![RazrbitAuthenticator canUseAuthenticator]) {
        NSLog(@"device doesn't support keychain access");
        return;
    }
    
    NSArray *addresses = [[RazrbitAuthenticator sharedInstance] getUserDefaultsItemFromKey:@"address"];
    NSString *privateKey = addresses[0];
    
    NSLog(@"private key %@",privateKey);
    
    if (privateKey) {
        [[RazrbitAuthenticator sharedInstance] fetchItemForKey:privateKey options:NULL onSuccess:^(NSString *value) {
            [self sendAmountFromPrivateKey:privateKey toAddress:value amount:amount completion:completionBlock];
        } onFailure:NULL];
    }
    else {
        NSLog(@"No addresses stored");
    }
}
#endif

- (void)sendAmountFromPrivateKey:(NSString *)fromPrivateKey toAddress:(NSString *)toAddress amount:(long)amount completion:(RazrbitCompletionBlock)completionBlock
{
    NSString *apiRoute = [self buildAPIRouteForService:@"sendAmount"];
    NSString *invocationKey = [self generateInvocationKeyForApiRoute:apiRoute];
    
    if (fromPrivateKey == nil || [fromPrivateKey isEqualToString:@""] ||
        toAddress == nil || [toAddress isEqualToString:@""] ||
        amount <= 0) {
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
                               parameters:@{ @"fromAddressPrivateKey" : fromPrivateKey,
                                             @"toAddress" : toAddress,
                                             @"amount" : [NSNumber numberWithLong:amount] }
                       completionCallBack:completionBlock];
}

- (void)getBalanceFromAddress:(NSString *)address completion:(RazrbitCompletionBlock)completionBlock
{
    NSString *apiRoute = [self buildAPIRouteForService:@"getBalanceFromAddress"];
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
