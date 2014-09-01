//
//  RazrbitHarnessTests.m
//  RazrbitHarnessTests
//
//  Created by Derek Lee on 2014/08/12.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Razrbit.h"
#import "RazrbitHarnessTestConstants.h"

@interface RazrbitHarnessTests : XCTestCase


@end

@implementation RazrbitHarnessTests

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

- (void)testAppIDAndAppSecretRequired
{
    __block BOOL hasCalledBack = NO;
    __block NSString *errorMessage;

    [[Razrbit sharedInstance].wallet getBalanceFromAddress:@"1K8ZCd8xpbKZXj2QotFSzPGrgb1YNQV1yT"
                                    completion:^(NSDictionary *responseValues, NSError *err) {
                                        // Callback code here
                                        if (!err) {
                                            NSLog(@"From the completion callback");
                                        } else {
                                            errorMessage = err.localizedDescription;
                                            NSLog(@"Error: %@", errorMessage);
                                        }

                                        hasCalledBack = YES;
                                    }];

    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:kInvocationTimeoutInSeconds];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    XCTAssertTrue([errorMessage isEqualToString:kRazrbitErrorMsgInvalidAppIdOrAppSecret], @"Invalid App ID or App Secret error message was not returned");
    
    if (!hasCalledBack) {
        XCTFail(@"Timout.");
    }
}

- (void)testAppIDRequired
{
    __block BOOL hasCalledBack = NO;
    __block NSString *errorMessage;
    
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:nil appSecret:kRazrbitTestAppSecret];

    [[Razrbit sharedInstance].wallet getBalanceFromAddress:@"1K8ZCd8xpbKZXj2QotFSzPGrgb1YNQV1yT"
                                    completion:^(NSDictionary *responseValues, NSError *err) {
                                        // Callback code here
                                        if (!err) {
                                            NSLog(@"From the completion callback");
                                        } else {
                                            errorMessage = err.localizedDescription;
                                            NSLog(@"Error: %@", errorMessage);
                                        }
                                        
                                        hasCalledBack = YES;
                                    }];
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:kInvocationTimeoutInSeconds];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    XCTAssertTrue([errorMessage isEqualToString:kRazrbitErrorMsgInvalidAppIdOrAppSecret], @"Invalid App ID or App Secret error message was not returned");
    
    if (!hasCalledBack) {
        XCTFail(@"Timout.");
    }
}

- (void)testAppSecretRequired
{
    __block BOOL hasCalledBack = NO;
    __block NSString *errorMessage;
    
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:nil];

    [[Razrbit sharedInstance].wallet getBalanceFromAddress:@"1K8ZCd8xpbKZXj2QotFSzPGrgb1YNQV1yT"
                                    completion:^(NSDictionary *responseValues, NSError *err) {
                                        // Callback code here
                                        if (!err) {
                                            NSLog(@"From the completion callback");
                                        } else {
                                            errorMessage = err.localizedDescription;
                                            NSLog(@"Error: %@", errorMessage);
                                        }
                                        
                                        hasCalledBack = YES;
                                    }];
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:kInvocationTimeoutInSeconds];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    XCTAssertTrue([errorMessage isEqualToString:kRazrbitErrorMsgInvalidAppIdOrAppSecret], @"Invalid App ID or App Secret error message was not returned");
    
    if (!hasCalledBack) {
        XCTFail(@"Timout.");
    }
}

@end
