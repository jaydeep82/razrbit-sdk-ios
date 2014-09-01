//
//  RazrbitSocketCallHandler.m
//  RazrbitHarness
//
//  Created by Derek Lee on 8/15/14.
//  Copyright (c) 2014 LUXSTACK Inc. All rights reserved.
//

#import "RazrbitSocketCallHandler.h"

@interface RazrbitSocketCallHandler()

@property (nonatomic, strong) PSWebSocket *socket;
@property (nonatomic, strong) NSString *invocationKey;

@end

@implementation RazrbitSocketCallHandler

@synthesize socket = _socket;
@synthesize invocationKey = _invocationKey;

- (id)initWithInvocationKey:(NSString *)key
{
    self = [super init];
    if (self) {
        self.invocationKey = key;
    }
    
    return self;
}

- (void)openWebsocketAtAddress:(NSString *)url psWebsocketDelegate:(id<PSWebSocketDelegate>)delegate
{
    // Create the NSURLRequest that will be sent as the handshake
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];

    // create the socket and assign delegate
    self.socket = [PSWebSocket clientSocketWithRequest:request];
    self.socket.delegate = delegate;
    
    // open socket
    [self.socket open];
}

- (void)closeWebsocket
{
    [self.socket close];
}

@end
