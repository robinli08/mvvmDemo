//
//  UIPageContainerViewController.m
//  DL_MVVM
//
//  Created by Daniel.Li on 26/10/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "UIPageContainerViewController.h"
#import "ThirdViewController.h"
#import "ForthViewController.h"
#import "FifthViewController.h"
#import "SixthViewController.h"
#import "DLRainbowSegmentControl.h"
#import "ViewController.h"
#import "FouthViewController.h"

@interface UIPageContainerViewController () <UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *viewControllersArray;
@property (nonatomic, strong) DLRainbowSegmentControl *seg;
@property (nonatomic, assign) NSUInteger selectedPageIndex;

@end

@implementation UIPageContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //添加title的segmentControl
    DLRainbowSegmentControl *rainSeg = [[DLRainbowSegmentControl alloc] initWithTitles:@[@"热门",@"高端",@"基金",@"定期"]];
    rainSeg.frame = CGRectMake(0, 0, 200, 40);
    rainSeg.backgroundColor = [UIColor grayColor];
    self.seg = rainSeg;
    self.navigationItem.titleView = self.seg;
    
    [self setPageViewController:[[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                              options:nil]];
    
    for (UIView *view in [[[self pageViewController] view] subviews]) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)view setCanCancelContentTouches:YES];
            [(UIScrollView *)view setDelaysContentTouches:NO];
        }
    }
    
    [[self pageViewController] setDataSource:self];
    [[self pageViewController] setDelegate:self];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    [self reloadPageViewData];
    
}
- (void)reloadPageViewData {
    self.viewControllersArray = [NSMutableArray array];
    
    ViewController *sixthVC = [[ViewController alloc] init];
    [self.viewControllersArray addObject:sixthVC];
    ForthViewController *forthVC = [[ForthViewController alloc] init];
    [self.viewControllersArray addObject:forthVC];
    FifthViewController *fifVC = [[FifthViewController alloc] init];
    [self.viewControllersArray addObject:fifVC];
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    [self.viewControllersArray addObject:thirdVC];
    
    self.pageViewController.view.frame = self.view.frame;
    self.pageViewController.view.backgroundColor = [UIColor whiteColor];
    
    [self.pageViewController setViewControllers:@[self.viewControllersArray[0]]
                                      direction:UIPageViewControllerNavigationDirectionReverse
                                       animated:NO
                                     completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.viewControllersArray count] == 0) || (index >= [self.viewControllersArray count])) {
        return nil;
    }
    
    return self.viewControllersArray[index];
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController {
    return [self.viewControllersArray indexOfObject:viewController];
}

#pragma mark ------------------ UIPageViewControllerDataSource --------------------

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSUInteger index = [self indexOfViewController:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
    
    
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSUInteger index = [self indexOfViewController:(UIViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.viewControllersArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
}

#pragma mark ------------------ UIPageViewControllerDelegate --------------------

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
//    NSInteger index = [self.viewControllersArray indexOfObject:pendingViewControllers[0]];
//    [self.seg setSelectedIndex:index animated:YES];

    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    [self setSelectedPageIndex:[self.viewControllersArray indexOfObject:[self.pageViewController viewControllers][0]]];
    
    [self.seg setSelectedIndex:self.selectedPageIndex animated:YES];
    

}

@end
