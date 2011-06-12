//
//  AppDelegate.m
//  SampleProject
//
//  Created by Sangwoo Im on 6/12/11.
//  Copyright Sangwoo Im 2011. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"

@implementation AppDelegate
@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	RootViewController     *rootCon;
	window  = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	rootCon = [[[RootViewController alloc] initWithNibName:nil bundle:nil] autorelease];
	navCon  = [[UINavigationController alloc] initWithRootViewController:rootCon];
	
	navCon.navigationBarHidden = YES;
	
	[window addSubview:navCon.view];
	[window makeKeyAndVisible];
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
}

- (void)dealloc {
	[navCon release];
	[window release];
	[super dealloc];
}

@end
