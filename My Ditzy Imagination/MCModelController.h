//
//  MCModelController.h
//  My Ditzy Imagination
//
//  Created by Mike Schwab on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MCDataViewController;

@interface MCModelController : NSObject <UIPageViewControllerDataSource>
- (MCDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(MCDataViewController *)viewController;
@end
