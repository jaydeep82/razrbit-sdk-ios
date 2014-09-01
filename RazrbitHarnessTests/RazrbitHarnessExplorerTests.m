//
//  RazrbitHarnessExplorerTests.m
//  RazrbitHarness
//
//  Created by Derek Lee on 8/13/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Razrbit.h"
#import "RazrbitHarnessTestConstants.h"

@interface RazrbitHarnessExplorerTests : XCTestCase

@end

@implementation RazrbitHarnessExplorerTests

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
//  >>>>>> EXPLORER TESTS
// ************************************************************************************************

- (void)testBlockWithNullBlockHash
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;

    // Razrbit Testing Code
    [[Razrbit sharedInstance].explorer blockUsingBlockHash:nil
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

- (void)testBlockWithEmptyBlockHash
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].explorer blockUsingBlockHash:@""
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

- (void)testBlockWithValidBlockHash
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].explorer blockUsingBlockHash:@"000000000000000021c40d35f9c317d2e8c9ead4dec3e24b8d1919862bd8f89d"
                                      completion:^(NSDictionary *responseValues, NSError *err) {
                                          // Callback code here
                                          
                                          NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);
                                          
                                          if (!err) {
                                              output = [responseValues objectForKey:@"hash"];
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

- (void)testBlockWithInvalidBlockHash
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].explorer blockUsingBlockHash:@"asdfasdf"
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

- (void)testTransactionWithNullTransactionHash
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].explorer transactionUsingTransactionHash:nil
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

- (void)testTransactionWithEmptyTransactionHash
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].explorer transactionUsingTransactionHash:@""
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

- (void)testTransactionWithValidTransactionHash
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].explorer transactionUsingTransactionHash:@"cd02255d491dfa1ff0a530c63a20f57e7fd829b2053ad15680390208d6552582"
                                                  completion:^(NSDictionary *responseValues, NSError *err) {
                                                      // Callback code here
                                                      
                                                      NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);
                                                      
                                                      if (!err) {
                                                          output = [responseValues objectForKey:@"blockhash"];
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

- (void)testTransactionWithInvalidTransactionHash
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].explorer transactionUsingTransactionHash:@"asdfasdf"
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

- (void)testAddressWithNullAddress
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].explorer addressFromAddress:nil
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

- (void)testAddressWithEmptyAddress
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].explorer addressFromAddress:@""
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

- (void)testAddressWithValidAddress
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].explorer addressFromAddress:@"1K8ZCd8xpbKZXj2QotFSzPGrgb1YNQV1yT"
                                     completion:^(NSDictionary *responseValues, NSError *err) {
                                         // Callback code here
                                         
                                         NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);
                                         
                                         if (!err) {
                                             output = [responseValues objectForKey:@"balance"];
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

- (void)testAddressWithInvalidAddress
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].explorer addressFromAddress:@"asdfasdf"
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

- (void)testAddressUnspentOutputsWithNullAddress
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].explorer addressUnspentOutputs:nil
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

- (void)testAddressUnspentOutputsWithEmptyAddress
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].explorer addressUnspentOutputs:@""
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

- (void)testAddressUnspentOutputsWithValidAddress
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].explorer addressUnspentOutputs:@"1K8ZCd8xpbKZXj2QotFSzPGrgb1YNQV1yT"
                                        completion:^(NSArray *responseValues, NSError *err) {
                                            // Callback code here
                                            
                                            NSLog(@"\n\nOUTPUT:%@\n\n", responseValues);
                                            
                                            if (!err) {
                                                if (responseValues.count > 0) {
                                                    NSDictionary *addressData = responseValues[0];
                                                    output = [addressData objectForKey:@"address"];
                                                    NSLog(@"output >> %@", output);
                                                }
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

- (void)testAddressUnspentOutputsWithInvalidAddress
{
    // Require that users first invoke this method and pass in their AppID and AppSecret
    [[Razrbit sharedInstance] initWithAppID:kRazrbitTestAppID appSecret:kRazrbitTestAppSecret];
    
    __block BOOL hasCalledBack = NO;
    __block NSString *output;
    
    // Razrbit Testing Code
    [[Razrbit sharedInstance].explorer addressUnspentOutputs:@"asdfasdf"
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
    
    XCTAssertTrue([output isEqualToString:@"Invalid parameters"], @"Unexpected return value for output: %@", output);
    
    if (!hasCalledBack) {
        XCTFail(@"Timed out.");
    }
}

@end
