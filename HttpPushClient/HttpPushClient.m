//
//  HttpPushClient.m
//  HttpPushDemo
//
//  Created by Ray Yamamoto on 5/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HttpPushClient.h"

@interface HttpPushClient ()
@property (nonatomic, retain) NSURLConnection *currentConnection;
@property (nonatomic, copy) HttpPushClientBlock block;
@property (nonatomic, retain) NSURL *url;
- (void)beginPersistentHttpConnection;
@end


@implementation HttpPushClient
@synthesize url=url_;
@synthesize currentConnection=currentConnection_;
@synthesize block=block_;

- (id)initWithURL:(NSURL*)url callback:(HttpPushClientBlock)block 
{
    if((self == [super init])) 
    {
        self.url = url;
        self.block = block;
    }
    return self;
}

- (void)start
{
    isActive_ = YES;
    [self beginPersistentHttpConnection];
}

- (void)stop
{
    isActive_ = NO;
    if(self.currentConnection) 
    {
        [self.currentConnection cancel];
    }
}

- (void)reconnectIfRequired
{
    if(!isActive_) return;
    [self performSelector:@selector(beginPersistentHttpConnection) withObject:nil afterDelay:1.];
}

- (void)beginPersistentHttpConnection 
{
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:self.url
                                              cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                          timeoutInterval:3600.0];
    [theRequest setNetworkServiceType:NSURLNetworkServiceTypeVoIP];
    
//    NSInputStream *requestStream = [[NSInputStream alloc] init];
//    [requestStream pu]
//    [theRequest setHTTPBodyStream:];
    
    // create the connection with the request
    // and start loading the data
    self.currentConnection=[[[NSURLConnection alloc] initWithRequest:theRequest 
                                                            delegate:self] autorelease];
    if (self.currentConnection) {
        // yay, we wait for data
    } else {
        NSLog(@"Failed to connect to %@", self.url);
        [self reconnectIfRequired];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self reconnectIfRequired];
    NSLog(@"Connection to %@ completed, reconnecting", self.url);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self reconnectIfRequired];
    NSLog(@"Connection to %@ failed, reconnecting: %@", self.url, [error localizedDescription]);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    self.block(data);
}

@end
