//
//  HttpPushClient.h
//  HttpPushDemo
//
//  Created by Ray Yamamoto on 5/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HttpPushClientBlock)(NSData *chunk);


@interface HttpPushClient : NSObject {
    NSURL *url_;
    NSURLConnection *currentConnection_;
    BOOL isActive_;
}


- (id)initWithURL:(NSURL*)url callback:(HttpPushClientBlock)block;
- (void)start;
- (void)stop;

@end
