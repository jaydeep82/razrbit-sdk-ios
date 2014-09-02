//
//  RazrbitAuthenticator.h
//  RazrbitHarness
//
//  Created by Tha Leang on 8/23/14.
//  Copyright (c) 2014 LUXSTACK KK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RazrbitConstants.h"

@interface RazrbitAuthenticator : NSObject

+ (RazrbitAuthenticator *)sharedInstance;
+ (BOOL) canUseAuthenticator;

- (void)addItemForKey:(NSString *) key andValue: (NSString *) value;
- (void)deleteItemForKey:(NSString *) key;
- (void)fetchItemForKey:(NSString *) key options:(NSDictionary *) options onSuccess:(void (^)(NSString *value))success onFailure:(void (^)(NSString *errorLocalizedString))failure;

- (void)addItemToUserDefaultsForKey:(NSString *) key andValue: (NSString *) value;
- (id)getUserDefaultsItemFromKey: (NSString *) key;

@end
