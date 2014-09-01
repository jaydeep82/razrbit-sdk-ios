//
//  Razrbit.m
//  RazrbitHarness
//
//  Created by Derek Lee on 2014/08/12.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import "Razrbit.h"
#import "RazrbitAsyncCallHandler.h"
#import "RazrbitDelegate.h"

@interface Razrbit() <RazrbitDelegate>

// AppId and AppSecret are expected to be passed into the initializer as these are required inputs for all service calls.
@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *appSecret;

// Holds a list of API Requests while they are being processed.
@property (nonatomic, strong) NSMutableDictionary *apiRequests;

@end

@implementation Razrbit

static Razrbit *_sharedInstance;

@synthesize wallet = _wallet;
@synthesize explorer = _explorer;
@synthesize network = _network;
@synthesize markets = _markets;
@synthesize notifications = _notifications;

@synthesize appId = _appId;
@synthesize appSecret = _appSecret;
@synthesize apiRequests = _apiRequests;

// Singleton instance used to ensure only one way of accessing this class.
+ (Razrbit *)sharedInstance
{
    if (!_sharedInstance) {
        _sharedInstance = [[Razrbit alloc] init];
    }
    
    return _sharedInstance;
}

- (RazrbitWalletServiceFacade *)wallet
{
    if (!_wallet) {
        _wallet = [[RazrbitWalletServiceFacade alloc] initWithAPIRooteName:@"wallet" delegate:self];
    }
    
    return _wallet;
}

- (RazrbitExplorerServiceFacade *)explorer
{
    if (!_explorer) {
        _explorer = [[RazrbitExplorerServiceFacade alloc] initWithAPIRooteName:@"explorer" delegate:self];
    }
    
    return _explorer;
}

- (RazrbitNetworkServiceFacade *)network
{
    if (!_network) {
        _network = [[RazrbitNetworkServiceFacade alloc] initWithAPIRooteName:@"network" delegate:self];
    }
    
    return _network;
}

- (RazrbitMarketsServiceFacade *)markets
{
    if (!_markets) {
        _markets = [[RazrbitMarketsServiceFacade alloc] initWithAPIRooteName:@"markets" delegate:self];
    }
    
    return _markets;
}

- (RazrbitNotificationsServiceFacade *)notifications
{
    if (!_notifications) {
        _notifications = [[RazrbitNotificationsServiceFacade alloc] initWithAPIRooteName:@"notification" delegate:self];
    }
    
    return _notifications;
}

- (NSMutableDictionary *)apiRequests
{
    if (!_apiRequests) {
        _apiRequests = [[NSMutableDictionary alloc] init];
    }
    
    return _apiRequests;
}

- (void)initWithAppID:(NSString *)appId appSecret:(NSString *)appSecret
{
    self.appId = appId;
    self.appSecret = appSecret;
}


#pragma mark RazrbitDelegate
- (NSString *)appId:(id)sender
{
    return self.appId;
}

- (NSString *)appSecret:(id)sender
{
    return self.appSecret;
}

- (void)serviceInvocationStarted:(id)sender asyncCallHandler:(id)razrbitCall key:(NSString *)key
{
    [self.apiRequests setObject:razrbitCall forKey:key];
}

- (void)serviceInvocationCompleted:(id)sender key:(NSString *)key
{
    if ([self.apiRequests objectForKey:key] != nil) {
        [self.apiRequests removeObjectForKey:key];
    }
}

@end
