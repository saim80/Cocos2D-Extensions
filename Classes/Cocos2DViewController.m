//
//  This class is based on the following classes in Cocos2D template project:
//  AppDelegate, RootViewController
//
//  Copyright 2010 cocos2d-iphone.org. All rights reserved.
//

//
//  Cocos2DViewController.m
//  SWGameLib
//
//
//  Copyright (c) 2010 Sangwoo Im
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//  
//  Created by Sangwoo Im on 4/14/10.
//  Copyright 2010 Sangwoo Im. All rights reserved.
//

//
// RootViewController + iAd
// If you want to support iAd, use this class as the controller of your iAd
//

#import "cocos2d.h"
#import "Cocos2DViewController.h"
#import "GameConfig.h"
#import "CCNode+Autolayout.h"


@interface Cocos2DViewController (Cocos2DUtility)
- (void)removeStartupFlicker;
@end

@implementation Cocos2DViewController (Cocos2DUtility)

- (void)removeStartupFlicker
{
	//
	// THIS CODE REMOVES THE STARTUP FLICKER
	//
	// Uncomment the following code if you Application only supports landscape mode
	//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
	
	//	CC_ENABLE_DEFAULT_GL_STATES();
	//	CCDirector *director = [CCDirector sharedDirector];
	//	CGSize size = [director winSize];
	//	CCSprite *sprite = [CCSprite spriteWithFile:@"Default.png"];
	//	sprite.position = ccp(size.width/2, size.height/2);
	//	sprite.rotation = -90;
	//	[sprite visit];
	//	[[director openGLView] swapBuffers];
	//	CC_ENABLE_DEFAULT_GL_STATES();
	
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController	
}

@end

@implementation Cocos2DViewController


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		// Try to use CADisplayLink director
		// if it fails (SDK < 3.1) use the default director
		if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
			[CCDirector setDirectorType:kCCDirectorTypeDefault];
		
		
	}
	return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[[CCDirector sharedDirector] end];
    [super dealloc];
}

// IMPORTANT: uncomment this only when you don't want to use view nib loading.

//- (void)loadView {
//	//
//	// Create the EAGLView manually
//	//  1. Create a RGB565 format. Alternative: RGBA8
//	//	2. depth format of 0 bit. Use 16 or 24 bit for 3d effects, like CCPageTurnTransition
//	//
//	//
//	EAGLView *glView = [EAGLView viewWithFrame:CGRectZero
//								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
//								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
//						];
//	
//	[self setView:glView];
//}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	if (!self.parentViewController) {
		self.wantsFullScreenLayout = YES;
	}
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// attach the openglView to the director
	[director setOpenGLView:(EAGLView *)self.view];
	
	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");
	
	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:YES];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	// Removes the startup flicker
	[self removeStartupFlicker];
	[director startAnimation];
	[director resume];
	
	NSNotificationCenter *center;
	UIApplication		 *app;
	
	app    = [UIApplication sharedApplication];
	center = [NSNotificationCenter defaultCenter];
	
	[center addObserver:self selector:@selector(applicationWillResignActive:) name:@"UIApplicationWillResignActiveNotification" object:app];
	[center addObserver:self selector:@selector(applicationDidBecomeActive:) name:@"UIApplicationDidBecomeActiveNotification" object:app];
	[center addObserver:self selector:@selector(applicationWillTerminate:) name:@"UIApplicationWillTerminateNotification" object:app];
	[center addObserver:self selector:@selector(applicationDidEnterBackground:) name:@"UIApplicationDidEnterBackgroundNotification" object:app];
	[center addObserver:self selector:@selector(applicationWillEnterForeground:) name:@"UIApplicationWillEnterForegroundNotification" object:app];
	[center addObserver:self selector:@selector(applicationSignificantTimeChange:) name:@"UIApplicationSignificantTimeChangeNotification" object:app];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	[[CCDirector sharedDirector] pause];
	[[CCDirector sharedDirector] stopAnimation];
	[[CCDirector sharedDirector] setOpenGLView:nil];
	[[CCDirector sharedDirector] end];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	//
	// There are 2 ways to support auto-rotation:
	//  - The OpenGL / cocos2d way
	//     - Faster, but doesn't rotate the UIKit objects
	//  - The ViewController way
	//    - A bit slower, but the UiKit objects are placed in the right place
	//
	
#if GAME_AUTOROTATION==kGameAutorotationNone
	//
	// EAGLView won't be autorotated.
	// Since this method should return YES in at least 1 orientation, 
	// we return YES only in the Portrait orientation
	//
	return ( interfaceOrientation == UIInterfaceOrientationPortrait );
	
#elif GAME_AUTOROTATION==kGameAutorotationCCDirector
	//
	// EAGLView will be rotated by cocos2d
	//
	// Sample: Autorotate only in landscape mode
	//
	if( interfaceOrientation == UIInterfaceOrientationLandscapeLeft ) {
		[[CCDirector sharedDirector] setDeviceOrientation: kCCDeviceOrientationLandscapeRight];
	} else if( interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		[[CCDirector sharedDirector] setDeviceOrientation: kCCDeviceOrientationLandscapeLeft];
	}
	
	// Since this method should return YES in at least 1 orientation, 
	// we return YES only in the Portrait orientation
	return ( interfaceOrientation == UIInterfaceOrientationPortrait );
	
#elif GAME_AUTOROTATION == kGameAutorotationUIViewController
	//
	// EAGLView will be rotated by the UIViewController
	//
	// Sample: Autorotate only in landscpe mode
	//
	// return YES for the supported orientations
	
	return YES;
	
#else
#error Unknown value in GAME_AUTOROTATION
	
#endif // GAME_AUTOROTATION
	
	
	// Shold not happen
	return NO;
}

//
// This callback only will be called when GAME_AUTOROTATION == kGameAutorotationUIViewController
//
#if GAME_AUTOROTATION == kGameAutorotationUIViewController
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	CGRect rect = CGRectZero;
	CCDirector *director = [CCDirector sharedDirector];
	EAGLView *glView = [director openGLView];
	float contentScaleFactor = [director contentScaleFactor];
	CCScene *scene;
	CGRect screenRect;
	
	if (!self.parentViewController) { //root view controller
		screenRect = [[UIScreen mainScreen] bounds];
	} else {
		screenRect = self.parentViewController.view.bounds;
	}
	
	if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
		rect.size.width  = MAX(CGRectGetWidth(screenRect), CGRectGetHeight(screenRect));
		rect.size.height = MIN(CGRectGetWidth(screenRect), CGRectGetHeight(screenRect));
	} else {
		rect.size.width  = MIN(CGRectGetWidth(screenRect), CGRectGetHeight(screenRect));
		rect.size.height = MAX(CGRectGetWidth(screenRect), CGRectGetHeight(screenRect));
	}
	
	if( contentScaleFactor != 1 ) {
		rect.size.width *= contentScaleFactor;
		rect.size.height *= contentScaleFactor;
	}
	
	glView.frame = rect;
	
	scene = [director runningScene];
	
	[scene setNeedsLayout];
}
#endif // GAME_AUTOROTATION == kGameAutorotationUIViewController

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
	[[CCDirector sharedDirector] purgeCachedData];
}



#pragma mark - 
#pragma mark UIApplication Notifications

- (void)applicationWillResignActive:(NSNotification *)notification {
	[[CCDirector sharedDirector] pause];
}
- (void)applicationDidBecomeActive:(NSNotification *)notification {
	[[CCDirector sharedDirector] resume];
}
- (void)applicationDidEnterBackground:(NSNotification *)notification {
	[[CCDirector sharedDirector] stopAnimation];
}
- (void)applicationWillEnterForeground:(NSNotification *)notification {
	[[CCDirector sharedDirector] startAnimation];
}
- (void)applicationWillTerminate:(NSNotification *)notification {
	[[CCDirector sharedDirector] end];	
}
- (void)applicationSignificantTimeChange:(NSNotification *)notification {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}


@end

