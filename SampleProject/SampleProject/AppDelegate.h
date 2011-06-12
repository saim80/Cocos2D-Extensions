//
//  AppDelegate.h
//  SampleProject
//
//  Created by Sangwoo Im on 6/12/11.
//  Copyright Sangwoo Im 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow 			   *window;
	UINavigationController *navCon;
}

@property (nonatomic, retain) UIWindow *window;

@end
