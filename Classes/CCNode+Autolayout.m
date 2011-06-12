//
//  CCNode+Autolayout.m
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

#import "CCNode+Autolayout.h"
#import "CCActionManager.h"
#import "CCDirector.h"
#import "CCGrid.h"

@implementation CCNode (Autolayout)
- (void) visit
{
	// quick return if not visible
	if (!visible_)
		return;
	
	[self performSelector:@selector(layout)];
	
	glPushMatrix();
	
	if ( grid_ && grid_.active) {
		[grid_ beforeDraw];
		[self transformAncestors];
	}
	
	[self transform];
	if ([self respondsToSelector:@selector(beforeDraw)]) {
		[self performSelector:@selector(beforeDraw)];
	}
	
	if(children_) {
		ccArray *arrayData = children_->data;
		NSUInteger i = 0;
		
		// draw children zOrder < 0
		for( ; i < arrayData->num; i++ ) {
			CCNode *child = arrayData->arr[i];
			if ( [child zOrder] < 0 )
				[child visit];
			else
				break;
		}
		
		// self draw
		[self draw];
		
		// draw children zOrder >= 0
		for( ; i < arrayData->num; i++ ) {
			CCNode *child =  arrayData->arr[i];
			[child visit];
		}
		
	} else
		[self draw];
		 
	if ([self respondsToSelector:@selector(afterDraw)]) {
		[self performSelector:@selector(afterDraw)];
	}
	if ( grid_ && grid_.active)
		[grid_ afterDraw:self];
	
	glPopMatrix();
}
- (void)layoutChildren {}
- (void)layout {
	if (isTransformDirty_ && isTransformGLDirty_ && isInverseDirty_) {
		[self layoutChildren];
		if (grid_ && grid_.active) {
			self.grid = [[grid_ class] gridWithSize:grid_.gridSize];
			self.grid.active = YES;
		}
	}
}
- (void)setNeedsLayout {
	isTransformDirty_ = isTransformGLDirty_ = isInverseDirty_ = YES;
}
@end


@implementation CCScene (Autolayout)

- (void)setNeedsLayout {
	self.contentSize = [[[CCDirector sharedDirector] openGLView] frame].size;
	CCNode *child;
	CCARRAY_FOREACH(children_, child) {
		[child setNeedsLayout];
	}
}
@end