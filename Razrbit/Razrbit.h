//
//  Razrbit.h
//  RazrbitHarness
//
//  Created by Derek Lee on 2014/08/12.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RazrbitConstants.h"
#import "RazrbitWalletServiceFacade.h"
#import "RazrbitExplorerServiceFacade.h"
#import "RazrbitNetworkServiceFacade.h"
#import "RazrbitMarketsServiceFacade.h"
#import "RazrbitNotificationsServiceFacade.h"

@interface Razrbit : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) RazrbitWalletServiceFacade *wallet;
@property (nonatomic, strong) RazrbitExplorerServiceFacade *explorer;
@property (nonatomic, strong) RazrbitNetworkServiceFacade *network;
@property (nonatomic, strong) RazrbitMarketsServiceFacade *markets;
@property (nonatomic, strong) RazrbitNotificationsServiceFacade *notifications;

+ (Razrbit *)sharedInstance;

- (void)initWithAppID:(NSString *)appId appSecret:(NSString *)appSecret;

@end
