//
//  RazrbitSocketCallHandler.h
//  RazrbitHarness
//
//  Created by Derek Lee on 8/15/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RazrbitConstants.h"
#import "RazrbitDelegate.h"
#import "PSWebSocket.h"

@interface RazrbitSocketCallHandler : NSObject

- (id)initWithInvocationKey:(NSString *)key;
- (void)openWebsocketAtAddress:(NSString *)url psWebsocketDelegate:(id<PSWebSocketDelegate>)delegate;
- (void)closeWebsocket;

@end
