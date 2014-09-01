//
//  RazrbitAsyncCallHandler.m
//  RazrbitHarness
//
//  Created by Derek Lee on 2014/08/12.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import "RazrbitAsyncCallHandler.h"

@interface RazrbitAsyncCallHandler()

@property (weak, nonatomic) IBOutlet id <RazrbitDelegate> delegate;

@property (nonatomic, strong) NSString *invocationKey;
@property (nonatomic, strong) NSMutableData *jsonData;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, copy) void (^completionBlock)(id obj, NSError *err);
@property (nonatomic, strong) NSHTTPURLResponse *httpResponse;

@end

@implementation RazrbitAsyncCallHandler

@synthesize delegate = _delegate;

@synthesize invocationKey = _invocationKey;
@synthesize jsonData = _jsonData;
@synthesize connection = _connection;
@synthesize completionBlock = _completionBlock;
@synthesize httpResponse = _httpResponse;

- (NSMutableData *)jsonData
{
    if (!_jsonData) {
        _jsonData = [NSMutableData dataWithCapacity:0];
    }
    
    return _jsonData;
}

- (id)initWithDelegate:(id)delegate invocationKey:(NSString *)key
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.invocationKey = key;
    }
    
    return self;
}

- (void)invokeServiceWithApiRoute:(NSString *)apiRoute parameters:(NSDictionary *)parameters completionCallBack:(RazrbitCompletionBlock)completionBlock
{
    NSLog(@"API Route: %@", apiRoute);
    
    if (![self verifyAppIdAndAppSecret]) {
        NSError *error = [[NSError alloc] initWithDomain:kRazrbitErrorDomain
                                                    code:kRazrbitErrorCodeInvalidAppIdOrAppSecret
                                                userInfo:@{ NSLocalizedDescriptionKey : kRazrbitErrorMsgInvalidAppIdOrAppSecret }];
        completionBlock(nil, error);
        return;
    }
    
    NSMutableURLRequest *request = [self createURLRequestWithAPIRoute:apiRoute parameters:parameters];
    
    self.completionBlock = completionBlock;
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
    if (!self.connection) {
        // TODO: Add new error for this condition.
        NSLog(@"Connection could not be made.");
        NSError *error = [[NSError alloc] initWithDomain:kRazrbitErrorDomain
                                                    code:-1
                                                userInfo:@{ NSLocalizedDescriptionKey : @"TODO" }];
        completionBlock(nil, error);
        return;
    }

}

#pragma mark Overridden Methods
- (NSString *)description
{
    return [NSString stringWithFormat:@"RazrbitAsyncCallHandler - invocationKey: %@", self.invocationKey];
}

#pragma mark NSURLConnectionDataDelegate Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it has enough information to create the NSURLResponse object.
    // It can be called multiple times, for example in the case of a redirect, so each time we reset the data.
    if ([response expectedContentLength] < 0)
    {
        NSLog(@"Connection error");
        //here cancel your connection.
        [connection cancel];
        return;
    } else {
        self.httpResponse = (NSHTTPURLResponse *)response;
        [self.jsonData setLength:0];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Add the incoming chunk of data to the container
    [self.jsonData appendData:data];
}

#pragma mark NSURLConnectionDelegate
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Guaranteed to have the complete response at this point
    NSDictionary *serializedJSONObject = nil;
    NSError *error;
    
    NSLog(@"HTTP Response Status: %ld", (long)self.httpResponse.statusCode);

    if (self.httpResponse.statusCode == 200) {
        // If data is null this will thrown a nasty exception, so only try to serialize the object if we get some data back.
        // If the file does not exist, data will be nil.
        if (self.jsonData) {
            // Serialize the JSON to pass back to the caller.
            serializedJSONObject = [NSJSONSerialization JSONObjectWithData:self.jsonData options:NSJSONReadingMutableContainers error:&error];
            
            //NSString *responseStringWithEncoded = [[NSString alloc] initWithData:self.jsonData encoding:NSUTF8StringEncoding];
            //NSLog(@"Response Json: %@", responseStringWithEncoded);
            /*
            if ([serializedJSONObject isKindOfClass:[NSDictionary class]]) {
                for (NSString *key in serializedJSONObject) {
                    id obj = [serializedJSONObject objectForKey:key];
                    NSLog(@"Key/Obj: %@/%@", key, obj);
                }
            }
            // */
        }
        
        // Notify our parent that our invocation has completed.
        [self.delegate serviceInvocationCompleted:self key:self.invocationKey];
        
        // Execute the completion block passed in by the caller.
        [self completionBlock](serializedJSONObject, nil);
    } else if (self.httpResponse.statusCode == 400) {

        //NSString *responseStringWithEncoding = [[NSString alloc] initWithData:self.jsonData encoding:NSUTF8StringEncoding];
        //NSLog(@"400 Status Response: %@", responseStringWithEncoding);

        NSString *errorMessage = @"Unknown Error";
        serializedJSONObject = [NSJSONSerialization JSONObjectWithData:self.jsonData options:NSJSONReadingMutableContainers error:&error];
        if ([serializedJSONObject objectForKey:@"message"] != nil) {
            errorMessage = [serializedJSONObject objectForKey:@"message"];
        }
        
        NSError *error = [[NSError alloc] initWithDomain:kRazrbitErrorDomain
                                                    code:kRazrbitErrorCodeHttpStatus400
                                                userInfo:@{ NSLocalizedDescriptionKey : errorMessage }];
        [self completionBlock](nil, error);
    } else if (self.httpResponse.statusCode == 500) {
        NSError *error = [[NSError alloc] initWithDomain:kRazrbitErrorDomain
                                                    code:kRazrbitErrorCodeHttpStatus500
                                                userInfo:@{ NSLocalizedDescriptionKey : kRazrbitErrorMsgHttpStatus500 }];
        [self completionBlock](nil, error);
    } else {
        NSError *error = [[NSError alloc] initWithDomain:kRazrbitErrorDomain
                                                    code:kRazrbitErrorCodeUnknownError
                                                userInfo:@{ NSLocalizedDescriptionKey : kRazrbitErrorMsgUnknownError }];
        [self completionBlock](nil, error);
    }

    // Cleanup post-processing
    self.invocationKey = nil;
    self.connection = nil;
    self.jsonData = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // Connection errors only
    self.invocationKey = nil;
    self.connection = nil;
    self.jsonData = nil;
    
    // Error handling
    NSString *errorString = [NSString stringWithFormat:@"%@", [error localizedDescription]];
    NSLog(@"Error: %@", errorString);
    
    // Notify our parent that our invocation has completed.
    [self.delegate serviceInvocationCompleted:self key:self.invocationKey];

    // Invoke the callback and send the error.
    [self completionBlock](nil, error);
}

#pragma mark Private Methods
- (BOOL)verifyAppIdAndAppSecret
{
    if (![self.delegate appId:self] || ![self.delegate appSecret:self]) {
        return NO;
    }
    
    return YES;
}

- (NSString *)createBasePostRequest
{
    NSString *basePostRequest = [NSString stringWithFormat:@"appId=%@&appSecret=%@", [self.delegate appId:self], [self.delegate appSecret:self]];
    
    return basePostRequest;
}

- (NSMutableURLRequest *)createURLRequestWithAPIRoute:(NSString *)apiRoute parameters:(NSDictionary *)parameters
{
    // Generates an HTTP address similar to: https://api.razrbit.com/api/1/wallet/getBalanceFromAddress
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kBaseRazrbitAddressHttp, apiRoute]];
    
    NSString *postBody = [self createBasePostRequest];
    
    // Add the parameter keys and values that have been passed in.
    for (NSString *key in parameters) {
        NSString *value = [parameters objectForKey:key];
        NSLog(@"Key/Value: %@/%@", key, value);
        postBody = [postBody stringByAppendingString:[NSString stringWithFormat:@"&%@=%@", key, value]];
    }
    
    NSLog(@"Constructed postBody: %@", postBody);
    
    NSData *postData = [postBody dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    return request;
}

@end
