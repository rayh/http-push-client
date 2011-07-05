//
//  HttpPushDemoAppDelegate.h
//  HttpPushDemo
//
//  Created by Ray Yamamoto on 5/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HttpPushDemoViewController;

@interface HttpPushDemoAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet HttpPushDemoViewController *viewController;

@end
