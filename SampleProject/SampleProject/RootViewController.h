//
//  RootViewController.h
//  SampleProject
//
//  Created by Sangwoo Im on 6/12/11.
//  Copyright 2011 Sangwoo Im. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cocos2DViewController.h"

@interface RootViewController : Cocos2DViewController {
    CCScene *mostRecentScene;
}

- (IBAction)showScrollViewScene:(id)sender;
- (IBAction)showTableViewScene:(id)sender;
- (IBAction)showMultiColumnTableViewScene:(id)sender;
- (IBAction)toggleScene:(id)sender;
@end
