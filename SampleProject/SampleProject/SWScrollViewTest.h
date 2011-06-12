//
//  SWScrollViewTest.h
//  SampleProject
//
//  Created by Sangwoo Im on 6/12/11.
//  Copyright 2011 Sangwoo Im. All rights reserved.
//

#import "CCLayer.h"

@class SWScrollView;

@interface SWScrollViewTest : CCLayer {
    SWScrollView   *scrollView;
	NSMutableArray *contents;
}

+ (id)scene;

@end
