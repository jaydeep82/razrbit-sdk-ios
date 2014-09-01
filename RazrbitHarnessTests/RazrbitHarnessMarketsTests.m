//
//  RazrbitHarnessMarketsTests.m
//  RazrbitHarness
//
//  Created by Derek Lee on 8/13/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Razrbit.h"
#import "RazrbitHarnessTestConstants.h"

@interface RazrbitHarnessMarketsTests : XCTestCase

@end

@implementation RazrbitHarnessMarketsTests

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
//  >>>>>> MARKETS TESTS
// ************************************************************************************************

- (void)testPriceNullCurrency
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].markets priceInCurrency:nil
                                  completion:^(NSDictionary *responseValues, NSError *err) {
                                      // Callback code here
                                      
                                      NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);

                                      if (!err) {
                                          output = [responseValues objectForKey:@""];
                                          NSLog(@"output >> %@", output);
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
    
    XCTAssertTrue([output isEqualToString:kRazrbitErrorMsgMissingInputParameter], @"Invalid input parameter error message was not returned.");
    
    if (!hasCalledBack) {
        XCTFail(@"Timed out.");
    }
}

- (void)testPriceEmptyCurrency
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].markets priceInCurrency:@""
                                  completion:^(NSDictionary *responseValues, NSError *err) {
                                      // Callback code here
                                      
                                      NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);
                                      
                                      if (!err) {
                                          output = [responseValues objectForKey:@""];
                                          NSLog(@"output >> %@", output);
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
    
    XCTAssertTrue([output isEqualToString:kRazrbitErrorMsgMissingInputParameter], @"Invalid input parameter error message was not returned.");
    
    if (!hasCalledBack) {
        XCTFail(@"Timed out.");
    }
}

- (void)testPriceValidCurrency
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].markets priceInCurrency:@"USD"
                                  completion:^(NSDictionary *responseValues, NSError *err) {
                                      // Callback code here
                                      
                                      NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);
                                      
                                      if (!err) {
                                          output = [responseValues objectForKey:@"price"];
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

- (void)testPriceInvalidCurrency
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].markets priceInCurrency:@"XXX"
                                  completion:^(NSDictionary *responseValues, NSError *err) {
                                      // Callback code here
                                      
                                      NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);
                                      
                                      if (!err) {
                                          output = [responseValues objectForKey:@"message"];
                                          NSLog(@"output >> %@", output);
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
        XCTFail(@"Timed out.");
    }
}

- (void)testDayPriceNullCurrency
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].markets dayPriceInCurrency:nil
                                     completion:^(NSDictionary *responseValues, NSError *err) {
                                         // Callback code here
                                         
                                         NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);

                                         if (!err) {
                                             output = [responseValues objectForKey:@""];
                                             NSLog(@"output >> %@", output);
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
    
    XCTAssertTrue([output isEqualToString:kRazrbitErrorMsgMissingInputParameter], @"Invalid input parameter error message was not returned.");
    
    if (!hasCalledBack) {
        XCTFail(@"Timed out.");
    }
}

- (void)testDayPriceEmptyCurrency
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].markets dayPriceInCurrency:@""
                                     completion:^(NSDictionary *responseValues, NSError *err) {
                                         // Callback code here
                                         
                                         NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);
                                         
                                         if (!err) {
                                             output = [responseValues objectForKey:@""];
                                             NSLog(@"output >> %@", output);
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
    
    XCTAssertTrue([output isEqualToString:kRazrbitErrorMsgMissingInputParameter], @"Invalid input parameter error message was not returned.");
    
    if (!hasCalledBack) {
        XCTFail(@"Timed out.");
    }
}

- (void)testDayPriceValidCurrency
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].markets dayPriceInCurrency:@"USD"
                                     completion:^(NSDictionary *responseValues, NSError *err) {
                                         // Callback code here
                                         
                                         NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);
                                         
                                         if (!err) {
                                             output = [responseValues objectForKey:@"dayPrice"];
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

- (void)testDayPriceInvalidCurrency
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].markets dayPriceInCurrency:@"XXX"
                                     completion:^(NSDictionary *responseValues, NSError *err) {
                                         // Callback code here
                                         
                                         NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);
                                         
                                         if (!err) {
                                             output = [responseValues objectForKey:@"message"];
                                             NSLog(@"output >> %@", output);
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
        XCTFail(@"Timed out.");
    }
}

- (void)testHistoricalPriceNullCurrency
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].markets historicalPriceInCurrency:nil
                                                onDate:[NSDate date]
                                            completion:^(NSDictionary *responseValues, NSError *err) {
                                                // Callback code here
                                                
                                                NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);
                                                
                                                if (!err) {
                                                    output = [responseValues objectForKey:@""];
                                                    NSLog(@"output >> %@", output);
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
    
    XCTAssertTrue([output isEqualToString:kRazrbitErrorMsgMissingInputParameter], @"Invalid input parameter error message was not returned.");
    
    if (!hasCalledBack) {
        XCTFail(@"Timed out.");
    }
}

- (void)testHistoricalPriceEmptyCurrency
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].markets historicalPriceInCurrency:@""
                                                onDate:[NSDate date]
                                            completion:^(NSDictionary *responseValues, NSError *err) {
                                                // Callback code here
                                                
                                                NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);
                                                
                                                if (!err) {
                                                    output = [responseValues objectForKey:@""];
                                                    NSLog(@"output >> %@", output);
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
    
    XCTAssertTrue([output isEqualToString:kRazrbitErrorMsgMissingInputParameter], @"Invalid input parameter error message was not returned.");
    
    if (!hasCalledBack) {
        XCTFail(@"Timed out.");
    }
}

- (void)testHistoricalPriceNullDate
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].markets historicalPriceInCurrency:@"USD"
                                                onDate:nil
                                            completion:^(NSDictionary *responseValues, NSError *err) {
                                                // Callback code here
                                                
                                                NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);
                                                
                                                if (!err) {
                                                    output = [responseValues objectForKey:@""];
                                                    NSLog(@"output >> %@", output);
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
    
    XCTAssertTrue([output isEqualToString:kRazrbitErrorMsgMissingInputParameter], @"Invalid input parameter error message was not returned.");
    
    if (!hasCalledBack) {
        XCTFail(@"Timed out.");
    }
}

/*
 
 // The following three tests are successfully invoking the appropriate service on the server and getting the response.
 // However, after it comes back, for some reason even though the test method reaches the end of the method execution,
 //     Xcode is holding onto something, ramping up to 100%+ CPU usage and hanging. Not sure what is happening here.
 
- (void)testHistoricalPriceForToday
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance] historicalPriceInCurrency:@"USD"
                                                onDate:[NSDate date]
                                            completion:^(NSDictionary *responseValues, NSError *err) {
                                                // Callback code here
                                                
                                                NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);

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

- (void)testHistoricalPriceForTomorrow
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance] historicalPriceInCurrency:@"USD"
                                                onDate:[[NSDate date] dateByAddingTimeInterval:24*60*60]
                                            completion:^(NSDictionary *responseValues, NSError *err) {
                                                // Callback code here
                                                
                                                NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);
                                                
                                                if (!err) {
                                                    output = [responseValues objectForKey:@""];
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

- (void)testHistoricalPriceForYesterday
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance] historicalPriceInCurrency:@"USD"
                                                onDate:[[NSDate date] dateByAddingTimeInterval:-24*60*60]
                                            completion:^(NSDictionary *responseValues, NSError *err) {
                                                // Callback code here
                                                
                                                NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);
                                                
                                                if (!err) {
                                                    output = [responseValues objectForKey:@""];
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
 */

@end
