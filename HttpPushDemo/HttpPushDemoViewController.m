//
//  HttpPushDemoViewController.m
//  HttpPushDemo
//
//  Created by Ray Yamamoto on 5/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HttpPushDemoViewController.h"
#import "HttpPushClient.h"

@implementation HttpPushDemoViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:4567"];
    HttpPushClient *client = [[HttpPushClient alloc] initWithURL:url callback:^(NSData *chunk) {
        NSLog(@"Received: %@", [[[NSString alloc] initWithData:chunk encoding:NSUTF8StringEncoding] autorelease]);
    }];
    
    [client start];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
