//
//  RazrbitBaseServiceFacade.m
//  RazrbitHarness
//
//  Created by Derek Lee on 8/13/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import "RazrbitBaseServiceFacade.h"

@implementation RazrbitBaseServiceFacade

@synthesize apiRootName = _apiRootName;
@synthesize delegate = _delegate;

- (id)initWithAPIRooteName:(NSString *)apiRoot delegate:(id<RazrbitDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.apiRootName = apiRoot;
        self.delegate = delegate;
    }
    
    return self;
}

- (NSString *)buildAPIRouteForService:(NSString *)serviceName
{
    return [NSString stringWithFormat:@"%@/%@/%@", kRazrbitBaseServiceURL, self.apiRootName, serviceName];
}

- (NSString *)generateInvocationKeyForApiRoute:(NSString *)apiRoute
{
    return [NSString stringWithFormat:@"%@%@_%@", [self.delegate appSecret:self], apiRoute, [self randomStringWithLength:12]];
}

#pragma mark Private Methods
static NSString *const availableCharacters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

- (NSString *)randomStringWithLength:(int)len
{
    NSMutableString *randomString = [NSMutableString stringWithCapacity:len];
    
    for (int i = 0; i < len; i++) {
        [randomString appendFormat: @"%C", [availableCharacters characterAtIndex:arc4random_uniform((int)[availableCharacters length]) % (int)[availableCharacters length]]];
    }
    
    return randomString;
}

@end
