//
//  RazrbitHarnessWalletTests.m
//  RazrbitHarness
//
//  Created by Derek Lee on 8/13/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Razrbit.h"
#import "RazrbitHarnessTestConstants.h"

@interface RazrbitHarnessWalletTests : XCTestCase

@end

@implementation RazrbitHarnessWalletTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// ************************************************************************************************
//  >>>>>> WALLET TESTS
// ************************************************************************************************

- (void)testCreateNewAddress
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *address;
    __block NSString *privateKey;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].wallet createNewAddressWithCompletion:^(NSDictionary *responseValues, NSError *err) {
        if (!err) {
            address = [responseValues objectForKey:@"address"];
            privateKey = [responseValues objectForKey:@"privateKey"];
            NSLog(@" address >> %@", address);
            NSLog(@" publicKey >> %@", privateKey);
        } else {
            NSLog(@"Error: %@", err.localizedDescription);
        }
        
        hasCalledBack = YES;
    }];

    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:kInvocationTimeoutInSeconds];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    XCTAssertTrue(address != nil, @"Unexpected return value for address: %@", address);
    XCTAssertTrue(privateKey != nil, @"Unexpected return value for publicKey: %@", privateKey);

    if (!hasCalledBack) {
        XCTFail(@"Timout.");
    }
}

- (void)testSendAmountWithTestDataAndResponse
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    __block NSString *dummy;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].wallet sendAmountFromPrivateKey:@"5exampleFromAddressPrivateKey"
                                                    toAddress:@"1exampleToAddress"
                                                   amount:123456
                                               completion:^(NSDictionary *responseValues, NSError *err) {
                                                   // Callback code here
                                                   if (!err) {
                                                       output = [responseValues objectForKey:@"result"];
                                                       dummy = [responseValues objectForKey:@"dummy"];
                                                       NSLog(@"output/dummy >> %@/%@", output, dummy);
                                                   } else {
                                                       NSLog(@"Error: %@", err.localizedDescription);
                                                   }
                                                   
                                                   hasCalledBack = YES;
                                               }];

    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:kInvocationTimeoutInSeconds];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    XCTAssertTrue([output isEqualToString:@"OK"], @"Unexpected return value for output: %@", output);
    XCTAssertTrue([dummy isEqualToString:@"yes"], @"Unexpected return value for dummy: %@", dummy);
    
    if (!hasCalledBack) {
        XCTFail(@"Timed out.");
    }
}

- (void)testSendAmountFromAddressWithInsufficientBalance
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    __block NSString *dummy;
    
    // Razrbit Testing Code - Send half of the amount first
    [[Razrbit sharedInstance].wallet sendAmountFromPrivateKey:@""
                                                    toAddress:@"13foNLRfFsBwjTv7UY5ux7cVTt1MrWfy2j"
                                                   amount:50000
                                               completion:^(NSDictionary *responseValues, NSError *err) {
                                                   // Callback code here
                                                   if (!err) {
                                                       output = [responseValues objectForKey:@"result"];
                                                       NSLog(@"output/dummy >> %@/%@", output, dummy);
                                                   } else {
                                                       output = err.localizedDescription;
                                                       NSLog(@"Error: %@", err.localizedDescription);
                                                   }
                                                   
                                                   hasCalledBack = YES;
                                               }];
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:kInvocationTimeoutInSeconds];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    XCTAssertTrue([output isEqualToString:kRazrbitServerErrorInsufficientBalance], @"Unexpected return value for output: %@", output);
    
    if (!hasCalledBack) {
        XCTFail(@"Timed out.");
    }
}

- (void)testGetBalanceFromAddress
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *balance;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].wallet getBalanceFromAddress:@"1EP2BdsBSRLCp8cd8L9Hmh1rGs89eaFcXw"
                                               completion:^(NSDictionary *responseValues, NSError *err) {
                                                   if (!err) {
                                                       balance = [responseValues objectForKey:@"satoshiAmount"];
                                                       NSLog(@"satoshiAmount >> %@", balance);
                                                   } else {
                                                       NSLog(@"Error: %@", err.localizedDescription);
                                                   }
                                                   
                                                   hasCalledBack = YES;
                                               }];

    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:kInvocationTimeoutInSeconds];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    XCTAssertTrue(balance != nil, @"Unexpected return value for balance: %@", balance);
    
    if (!hasCalledBack) {
        XCTFail(@"Timout.");
    }
}

- (void)testGetBalanceFromInvalidAddress
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].wallet getBalanceFromAddress:@"asdfasdf"
                                               completion:^(NSDictionary *responseValues, NSError *err) {
                                                   if (!err) {
                                                       output = [responseValues objectForKey:@"satoshiAmount"];
                                                       NSLog(@"satoshiAmount >> %@", output);
                                                   } else {
                                                       output = err.localizedDescription;
                                                       NSLog(@"Error: %@", err.localizedDescription);
                                                   }
                                                   
                                                   hasCalledBack = YES;
                                               }];
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:kInvocationTimeoutInSeconds];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    XCTAssertTrue([output isEqualToString:kRazrbitServerErrorInvalidParameters], @"Unexpected return value for output: %@", output);
    
    if (!hasCalledBack) {
        XCTFail(@"Timout.");
    }
}

@end
