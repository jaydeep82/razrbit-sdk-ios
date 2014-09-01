//
//  RazrbitHarnessNotificationTests.m
//  RazrbitHarness
//
//  Created by Derek Lee on 8/13/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Razrbit.h"
#import "RazrbitHarnessTestConstants.h"

@interface RazrbitHarnessNotificationTests : XCTestCase

@end

@implementation RazrbitHarnessNotificationTests

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
//  >>>>>> NOTIFICATION TESTS
// ************************************************************************************************

- (void)testNotificationAddress
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].notifications address:@"1K8ZCd8xpbKZXj2QotFSzPGrgb1YNQV1yT"
                                      email:@"email@address.com"
                                 completion:^(NSDictionary *responseValues, NSError *err) {
                                     // Callback code here
                                     if (!err) {
                                         output = [responseValues objectForKey:@"result"];
                                         NSLog(@"output >> %@", output);
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
    
    XCTAssertTrue(output != nil, @"Unexpected return value for output: %@", output);
    
    if (!hasCalledBack) {
        XCTFail(@"Timed out.");
    }
}

- (void)testNotificationBlock
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].notifications block:@"315692"
                                      email:@"email@address.com"
                                 completion:^(NSDictionary *responseValues, NSError *err) {
                                     // Callback code here
                                     if (!err) {
                                         output = [responseValues objectForKey:@"result"];
                                         NSLog(@"output >> %@", output);
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
    
    XCTAssertTrue(output != nil, @"Unexpected return value for output: %@", output);
    
    if (!hasCalledBack) {
        XCTFail(@"Timed out.");
    }
}

- (void)testNotificationTransaction
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].notifications transaction:@"7697a507f6084863482e7c072f8b097a78988d1812df814937ac04585c0baafd"
                                            email:@"email@address.com"
                                       completion:^(NSDictionary *responseValues, NSError *err) {
                                           // Callback code here
                                           if (!err) {
                                               output = [responseValues objectForKey:@"result"];
                                               NSLog(@"output >> %@", output);
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
    
    XCTAssertTrue(output != nil, @"Unexpected return value for output: %@", output);
    
    if (!hasCalledBack) {
        XCTFail(@"Timed out.");
    }
}

@end
