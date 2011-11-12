//
//  MCModelController.m
//  My Ditzy Imagination
//
//  Created by Mike Schwab on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MCModelController.h"

#import "MCDataViewController.h"

//#import "UIImageView.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@interface MCModelController()
@property (readonly, strong, nonatomic) NSArray *pageData;
@end

@implementation MCModelController

@synthesize pageData = _pageData;

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        _pageData = [[dateFormatter monthSymbols] copy];
    }
    return self;
}

- (MCDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{   
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    UIImage *image = [UIImage imageNamed:@"roses.jpg"];
    NSLog(@"image: %@", image);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 20, 768, 1004);
//    imageView.backgroundColor = [UIColor colorWithRed:25.0 green:30.0 blue:40.0 alpha:100.0];
    
    // Create a new view controller and pass suitable data.
    MCDataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"MCDataViewController"];
    NSLog(@"view: %@", dataViewController.view);
    NSLog(@"imageView: %@", imageView);
    NSLog(@"image: %@", imageView.image);
    dataViewController.dataObject = [self.pageData objectAtIndex:index];
    [dataViewController.view addSubview:imageView];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(MCDataViewController *)viewController
{   
    /*
     Return the index of the given data view controller.
     For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
     */
    return [self.pageData indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(MCDataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(MCDataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
