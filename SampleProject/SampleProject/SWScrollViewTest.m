//
//  SWScrollViewTest.m
//  SampleProject
//
//  Created by Sangwoo Im on 6/12/11.
//  Copyright 2011 Sangwoo Im. All rights reserved.
//

#import "SWScrollViewTest.h"
#import "CCNode+Autolayout.h"
#import "SWScrollView.h"


@implementation SWScrollViewTest

#pragma mark - 
#pragma mark Object Lifecycle

+ (id)scene {
	CCScene *scene = [CCScene node];
	
	[scene addChild:[self node]];
	
	return scene;
}

- (id)init {
	if ((self = [super init])) {
		CCLayerColor *layer = [CCLayerColor layerWithColor:ccc4(55, 55, 55, 255)];
		scrollView = [SWScrollView viewWithViewSize:CGSizeZero];
		contents   = [NSMutableArray new];
		
		backgroundLayer = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255)];
		
		scrollView.maxZoomScale  = 2.0f;
		scrollView.minZoomScale  = 0.5f;
		scrollView.anchorPoint   = ccp(0.5f, 0.5f);
		scrollView.contentSize   = CGSizeMake(1000.0f, 1000.0f); // You need to set contentSize to enable scrolling.
		layer.contentSize		 = scrollView.contentSize;
		
		[scrollView addChild:layer];
		// prepare contents
		for (int i=0; i<100; i++) {
			CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Test Item: %i", i]
												   fontName:@"Marker Felt" 
												   fontSize:10.0f];
			
			[contents addObject:label];
			[scrollView addChild:label];
		}
		
		[self addChild:backgroundLayer];
		[self addChild:scrollView];
	}
	return self;
}
- (void)dealloc {
	[contents release];
	[super dealloc];
}

#pragma mark -
#pragma mark Layout Contents

- (void)layoutChildren {
	// for every layout changes let's distribute labels randomly
	for (CCLabelTTF *label in contents) {
		label.position = ccp(1000.0f * CCRANDOM_0_1(), 1000.0f * CCRANDOM_0_1());
	}
	self.contentSize    = self.parent.contentSize; // make sure this layer covers its parent contentSize.
	
	backgroundLayer.contentSize = self.contentSize;
	scrollView.viewSize = CGSizeMake(self.contentSize.width * 0.9f, self.contentSize.height * 0.9f); // show only 90% of this layer.
	scrollView.position = ccp((self.contentSize.width - scrollView.viewSize.width) * 0.5f,
							  (self.contentSize.height - scrollView.viewSize.height) * 0.5f); // position scroll at the center.
}

@end
