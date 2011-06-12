//
//  RootViewController.m
//  SampleProject
//
//  Created by Sangwoo Im on 6/12/11.
//  Copyright 2011 Sangwoo Im. All rights reserved.
//

#import "RootViewController.h"
#import "SWScrollViewTest.h"
#import "SWTableViewTest.h"
#import "SWMultiColumnTableViewTest.h"

@interface RootViewController ()
@property (nonatomic, retain) CCScene *mostRecentScene;

@end

@implementation RootViewController
@synthesize mostRecentScene;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.wantsFullScreenLayout = YES;
    }
    return self;
}

- (void)dealloc
{
	[mostRecentScene release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	CCDirector *director = [CCDirector sharedDirector];
	
	if (!mostRecentScene) { // this is the first launch, start with scroll view test
		self.mostRecentScene = [SWScrollViewTest scene];
	}
	
	[director runWithScene:mostRecentScene];
}

- (void)viewDidUnload
{
	// save the current scene for now so that it can continue running when the view gets loaded again.
	self.mostRecentScene = [[CCDirector sharedDirector] runningScene];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark IBAction

- (IBAction)showScrollViewScene:(id)sender {
	[[CCDirector sharedDirector] replaceScene:[SWScrollViewTest scene]];
}
- (IBAction)showTableViewScene:(id)sender {
	[[CCDirector sharedDirector] replaceScene:[SWTableViewTest scene]];
}
- (IBAction)showMultiColumnTableViewScene:(id)sender {
	[[CCDirector sharedDirector] replaceScene:[SWMultiColumnTableViewTest scene]];
}
- (IBAction)toggleScene:(id)sender {
	CCDirector *director = [CCDirector sharedDirector];
	CCScene    *scene    = [director runningScene];
	Class      currentSceneClass = [[[scene children] lastObject] class];
	
	if (currentSceneClass == [SWScrollViewTest class]) {
		[self showTableViewScene:sender];
	} else if (currentSceneClass == [SWTableViewTest class]) {
		[self showMultiColumnTableViewScene:sender];
	} else if (currentSceneClass == [SWMultiColumnTableViewTest class]) {
		[self showScrollViewScene:sender];
	} 
}
@end
