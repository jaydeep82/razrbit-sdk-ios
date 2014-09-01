//
//  RazrbitBaseServiceFacade.h
//  RazrbitHarness
//
//  Created by Derek Lee on 8/13/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RazrbitConstants.h"
#import "RazrbitDelegate.h"

static NSString *const kRazrbitBaseServiceURL = @"/api/v1";

@interface RazrbitBaseServiceFacade : NSObject

@property (strong, nonatomic) NSString *apiRootName;
@property (weak, nonatomic) IBOutlet id <RazrbitDelegate> delegate;

- (id)initWithAPIRooteName:(NSString *)apiRoot delegate:(id<RazrbitDelegate>)delegate;

- (NSString *)buildAPIRouteForService:(NSString *)serviceName;
- (NSString *)generateInvocationKeyForApiRoute:(NSString *)apiRoute;

@end
