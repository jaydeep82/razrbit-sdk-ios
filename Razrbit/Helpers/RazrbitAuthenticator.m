//
//  RazrbitAuthenticator.m
//  RazrbitHarness
//
//  Created by Tha Leang on 8/23/14.
//  Copyright (c) 2014 LUXSTACK KK. All rights reserved.
//

#import "RazrbitAuthenticator.h"

#if defined(__IPHONE_8_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0

@interface RazrbitAuthenticator()

@end

@implementation RazrbitAuthenticator

static RazrbitAuthenticator *_sharedInstance;

+ (RazrbitAuthenticator *)sharedInstance
{
    if (!_sharedInstance) {
        _sharedInstance = [[RazrbitAuthenticator alloc] init];
    }
    return _sharedInstance;
}

+(BOOL) canUseAuthenticator {
    return (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) ? YES : NO;
}

- (void)addItemForKey:(NSString *) key andValue: (NSString *) value {

    CFErrorRef error = NULL;
    SecAccessControlRef sacObject;

    sacObject = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly,
                                                kSecAccessControlUserPresence, &error);
    if(sacObject == NULL || error != NULL)
    {
        NSLog(@"can't create sacObject: %@", error);
    }

    NSDictionary *attributes = @{
                                 (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                                 (__bridge id)kSecAttrService: kRazrbitAuthKeychainService,
                                 (__bridge id)kSecAttrAccount: key,
                                 (__bridge id)kSecValueData: [value dataUsingEncoding:NSUTF8StringEncoding],
                                 (__bridge id)kSecUseNoAuthenticationUI: @YES,
                                 (__bridge id)kSecAttrAccessControl: (__bridge id)sacObject
                                 };
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        SecItemAdd((__bridge CFDictionaryRef)attributes, nil);
    });
}

- (void)deleteItemForKey:(NSString *) key {

    NSDictionary *query = @{
                            (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService: kRazrbitAuthKeychainService,
                            (__bridge id)kSecAttrAccount: key
                            };

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        SecItemDelete((__bridge CFDictionaryRef)(query));
    });
}

- (void)fetchItemForKey:(NSString *) key options:(NSDictionary *) options onSuccess:(void (^)(NSString *value))success onFailure:(void (^)(NSString * errorLocalizedString))failure {

    NSString *localizedPrompt = @"";

    if ([options valueForKey:kRazrbitAuthOptionsPrompt] != nil) {
        localizedPrompt = [options objectForKey:kRazrbitAuthOptionsPrompt];
    }

    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSMutableDictionary * query = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       (__bridge id)(kSecClassGenericPassword), kSecClass,
                                       key, kSecAttrAccount,
                                       kRazrbitAuthKeychainService, kSecAttrService,
                                       localizedPrompt, kSecUseOperationPrompt,
                                       @YES, kSecReturnData,
                                       nil];

        dispatch_async(dispatch_get_main_queue(), ^{
            CFTypeRef dataTypeRef = nil;
            OSStatus userPresenceStatus = SecItemCopyMatching((__bridge CFDictionaryRef)query, &dataTypeRef);
            
            NSData *resultData = (__bridge NSData *)dataTypeRef;
            NSString *value = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
            userPresenceStatus == noErr ? success(value) : failure([self keychainErrorToString:userPresenceStatus]);
            ;
        });
    });
}

- (void)addItemToUserDefaultsForKey:(NSString *) key andValue: (NSString *) value {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *addresses = [defaults objectForKey:key];
    
    if (!addresses) {
        addresses = [[NSMutableArray alloc] init];
    }
    
    [addresses addObject:value];
    [defaults setObject:addresses forKey:key];
    [defaults synchronize];
}

- (id)getUserDefaultsItemFromKey: (NSString *) key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

#pragma mark private methods

- (NSString *)keychainErrorToString: (NSInteger)error
{
    NSString *msg = [NSString stringWithFormat:@"%ld",(long)error];
    switch (error) {
        case errSecSuccess:
            msg = NSLocalizedString(@"SUCCESS", nil);
            break;
        case errSecDuplicateItem:
            msg = NSLocalizedString(@"ERROR_ITEM_ALREADY_EXISTS", nil);
            break;
        case errSecItemNotFound :
            msg = NSLocalizedString(@"ERROR_ITEM_NOT_FOUND", nil);
            break;
        case -26276: // this error will be replaced by errSecAuthFailed
            msg = NSLocalizedString(@"ERROR_ITEM_AUTHENTICATION_FAILED", nil);
        default:
            break;
    }
    
    return msg;
}

@end
#endif