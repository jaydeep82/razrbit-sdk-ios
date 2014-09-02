//
//  RazrbitAuthenticator.h
//  RazrbitHarness
//
//  Created by Tha Leang on 8/23/14.
//  Copyright (c) 2014 LUXSTACK KK. All rights reserved.
//


#import <Availability.h>
#import <Foundation/Foundation.h>
#import "RazrbitConstants.h"

#if defined(__IPHONE_8_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
@interface RazrbitAuthenticator : NSObject

+ (RazrbitAuthenticator *)sharedInstance;
+ (BOOL) canUseAuthenticator;

- (void)addItemForKey:(NSString *) key andValue: (NSString *) value;
- (void)deleteItemForKey:(NSString *) key;
- (void)fetchItemForKey:(NSString *) key options:(NSDictionary *) options onSuccess:(void (^)(NSString *value))success onFailure:(void (^)(NSString *errorLocalizedString))failure;

- (void)addItemToUserDefaultsForKey:(NSString *) key andValue: (NSString *) value;
- (id)getUserDefaultsItemFromKey: (NSString *) key;

@end
#endif
