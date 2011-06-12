//
//  CCNode+Autolayout.h
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

#import "CCNode.h"
#import "CCScene.h"

/**
 * CCNode layout extension.
 *
 * To take advantage of this class, implement layoutChildren method in your CCNode subclasses.
 *
 * CCScene class's contentSize property automatically set to a proper view size in account of orientation changes. 
 * Hence, use parent node's contentSize property instead of [CCDirector winsize] method.
 *
 * In your layoutChildren subclass, make sure you set proper contentSize for your subclasses so that descendant nodes
 * can retrieve that value for their layout.
 *
 * You must call setNeedsLayout to trigger layoutChidren method.
 */
@interface CCNode (Autolayout)
/**
 * The default implementation does nothing.
 *
 * Override this to layout the children of your subclass. Make sure to update contentSize so that the children can
 * layout their children depending on the contentSize.
 */
- (void)layoutChildren;
/**
 * For device orientation changes and updates required by CCNode's property changes, this will be automatically set.
 *
 * You will have to call this only when you want to update layout manually.
 */
- (void)setNeedsLayout;
@end


@interface CCScene (Autolayout)

@end