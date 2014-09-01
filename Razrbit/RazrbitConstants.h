//
//  RazrbitConstants.h
//  RazrbitHarness
//
//  Created by Derek Lee on 8/13/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

// Base Razrbit Address (http requests)
static NSString *const kBaseRazrbitAddressHttp = @"https://api.razrbit.com";

// Base Razrbit Address (Websocket requests)
static NSString *const kBaseRazrbitAddressWebSocket = @"ws://api.razrbit.com";

// Internal error codes & messages
static NSString *const kRazrbitErrorDomain = @"Razrbit";

static int const kRazrbitErrorCodeInvalidAppIdOrAppSecret = 1001;
static NSString *const kRazrbitErrorMsgInvalidAppIdOrAppSecret = @"App Id and App Secret are required for all API calls.";

static int const kRazrbitErrorCodeMissingInputParameter = 1002;
static NSString *const kRazrbitErrorMsgMissingInputParameter = @"A required input parameter is missing or invalid.";

static int const kRazrbitErrorCodeHttpStatus400 = 1003;
static NSString *const kRazrbitErrorMsgHttpStatus400 = @"The server did not understand the request. Please verify the data that is being passed to the server.";

static int const kRazrbitErrorCodeHttpStatus500 = 1004;
static NSString *const kRazrbitErrorMsgHttpStatus500 = @"The server threw an error trying to process the request.";

static int const kRazrbitErrorCodeUnknownError = 1005;
static NSString *const kRazrbitErrorMsgUnknownError = @"An unknown error occurred.";

//static int const kRazrbitErrorCode = 1001;
//static NSString *const kRazrbitErrorMsg = @"App Id and App Secret are required for all API calls.";

// Server error messages
static NSString *const kRazrbitServerErrorInvalidParameters = @"Invalid parameters";
static NSString *const kRazrbitServerErrorInsufficientBalance = @"Insufficient balance";

// Common block definition used for all Razrbit calls
typedef void (^RazrbitCompletionBlock)(id responseValues, NSError *err);

@interface RazrbitConstants : NSObject

@end
