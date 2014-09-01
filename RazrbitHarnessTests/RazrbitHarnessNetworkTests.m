//
//  RazrbitHarnessNetworkTests.m
//  RazrbitHarness
//
//  Created by Derek Lee on 8/13/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Razrbit.h"
#import "RazrbitHarnessTestConstants.h"

@interface RazrbitHarnessNetworkTests : XCTestCase

@end

@implementation RazrbitHarnessNetworkTests

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
//  >>>>>> NETWORK TESTS
// ************************************************************************************************

- (void)testGetDifficulty
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].network getDifficultyWithCompletion:^(NSDictionary *responseValues, NSError *err) {
        // Callback code here
        if (!err) {
            output = [responseValues objectForKey:@"difficulty"];
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

- (void)testPushTransaction
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].network pushTransaction:@"01000000010debc86da40173e5e77212e948dc820cf95cf1393e7db4f398d7ba3a427f780d010000006b483045022100d862f4002f52dcdcf0e6a40c2c2b950710138dd9e3163a9657e49fb7205716b2022055337d282f3bda17285509741595e95724afc52e0334a297d6211aa4288099d5012102e99a42d2739ad6e4f0b2d28d1dff36c83951ca24394a1c2afec211376dd23f50ffffffff0230750000000000001976a9141d46c398418cc0e88fc21e2b257a41ff02dabe2688ac00000000000000001976a9140699f547b36380245d9da068ff8aaca74c0b6a6588ac00000000"
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
    
    XCTAssertTrue([output isEqualToString:@"OK"], @"Unexpected return value for output: %@", output);
    
    if (!hasCalledBack) {
        XCTFail(@"Timed out.");
    }
}

@end
