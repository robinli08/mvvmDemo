//
//  SecondViewController.m
//  DL_MVVM
//
//  Created by Daniel.Li on 8/15/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "SecondViewController.h"
#import "NSString+DL_StringUtil.h"
#import "DLTagView.h"
#import "DLAutoScrollLabel.h"
#import "ThirdViewController.h"
#import "UIViewController+Popup.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DL_SegmentedControl.h"
#import "DLRainbowSegmentControl.h"
#import "ForthViewController.h"
#import "FifthViewController.h"
#import "SixthViewController.h"


@interface SecondViewController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (weak, nonatomic) IBOutlet DLAutoScrollLabel *scrollLabelView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DLRainbowSegmentControl *seg;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    RACMulticastConnection *connection = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
//            [subscriber sendNext:@1];
//        }];
//        
//        [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
//            [subscriber sendNext:@2];
//        }];
//        
//        [[RACScheduler mainThreadScheduler] afterDelay:3 schedule:^{
//            [subscriber sendNext:@3];
//        }];
//        
//        [[RACScheduler mainThreadScheduler] afterDelay:4 schedule:^{
//            [subscriber sendCompleted];
//        }];
//        return nil;
//    }] publish];
//    [connection connect];
//    RACSignal *signal = connection.signal;
//    
//    NSLog(@"Signal was created.");
//    [[RACScheduler mainThreadScheduler] afterDelay:1.1 schedule:^{
//        [signal subscribeNext:^(id x) {
//            NSLog(@"Subscriber 1 recveive: %@", x);
//        }];
//    }];
//    
//    [[RACScheduler mainThreadScheduler] afterDelay:2.1 schedule:^{
//        [signal subscribeNext:^(id x) {
//            NSLog(@"Subscriber 2 recveive: %@", x);
//        }];
//    }];
    
    
//    NSString *str = @"我是label1234567890";
//    
////    CGSize size = [str dl_sizeWithFont:[UIFont systemFontOfSize:12.f]];
//    CGSize textSize = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f]}];
//    CGFloat textWidth = ceilf(textSize.width);
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, textWidth, textSize.height)];
//    label.font = [UIFont systemFontOfSize:16.0f];
// //   label.layer.borderWidth = 0.5f;
//   // label.layer.borderColor = [UIColor blueColor].CGColor;
//    label.text = str;
//    [self.view addSubview:label];
//    
//    
//    DLTagView *tagLable = [[DLTagView alloc] initWithFrame:CGRectMake(100, 200, 50, 40)];
//    
//    tagLable.textColor = [UIColor redColor];
//    
//    tagLable.textFont = [UIFont systemFontOfSize:16.f];
//    tagLable.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 20);
//    
////    tagLable.layer.borderWidth = 0.5f;
//    tagLable.layer.borderColor = [UIColor blueColor].CGColor;
//    
//    tagLable.text = str;
//    
//    [self.view addSubview:tagLable];
//    
//    DLAutoScrollLabel *scrollLabel = [[DLAutoScrollLabel alloc] initWithFrame:CGRectMake(100, 400, 115, 40)];
//    
//    scrollLabel.text = str;
//    
//    NSLog(@"%@",scrollLabel.text);
//
//    self.scrollLabelView.text = str;
//    
//    UITapGestureRecognizer *tapReg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
//    [self.view addGestureRecognizer:tapReg];
//    
//    [self.view addSubview:self.scrollLabelView];
//    [self.view addSubview:scrollLabel];
//    
//    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"热门",@"高端",@"基金",@"定期"]];
//    seg.frame = CGRectMake(0, 100, 200, 40);
//    [self.view addSubview:seg];
    
    
    
//            _segmentControl = [[TTTSegmentControl alloc]
//                               initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kSegmentControlHeight)];
//            self.tableview.frame = CGRectMake(0, _segmentControl.bottom, self.view.frame.size.width,
//                                              self.view.frame.size.height - self.segmentControl.bottom);
//            _segmentControl.showIndicator = YES;
//            _segmentControl.backgroundColor = theUIStyle.itemViewColor;
//            _segmentControl.selectedColor = theUIStyle.c0;
//            _segmentControl.titleColor = theUIStyle.c2_a80;
//            _segmentControl.font = theUIStyle.f3;
//            _segmentControl.selectedFont = theUIStyle.f3;
//            [_segmentControl addSegmentWithTitles:@[@"我要退货", @"我要退款"]];
//            //绑定segment绑定事件
//            [_segmentControl addTarget:self
//                                action:@selector(segmentValueChanged:)
//                      forControlEvents:UIControlEventValueChanged]

    
    
    DLRainbowSegmentControl *rainSeg = [[DLRainbowSegmentControl alloc] initWithTitles:@[@"热门",@"高端",@"基金",@"定期"]];
    rainSeg.frame = CGRectMake(0, 0, 200, 40);
    rainSeg.backgroundColor = [UIColor grayColor];
    self.seg = rainSeg;
    self.navigationItem.titleView = self.seg;
    
    
    
//    CGFloat viewWidth = self.view.frame.size.width;
//    CGFloat viewHeight = self.view.frame.size.height;
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
//    self.scrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
//    self.scrollView.pagingEnabled = YES;
//    self.scrollView.showsHorizontalScrollIndicator = NO;
//    self.scrollView.showsVerticalScrollIndicator = NO;
//    self.scrollView.contentSize = CGSizeMake(viewWidth * 4, 1);  //这里不能设置为0
//    self.scrollView.delegate = self;
//    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, viewWidth, viewHeight) animated:NO];
//    [self.view addSubview:self.scrollView];
//    
//    //添加视图控制器到scrollView
//    
//    ThirdViewController *third = [[ThirdViewController alloc] init];
//    ForthViewController *forth = [[ForthViewController alloc] init];
//    FifthViewController *fifth = [[FifthViewController alloc] init];
//    SixthViewController *sixth = [[SixthViewController alloc] init];
//
//    [self addChildViewController:third];
//    [self addChildViewController:forth];
//    [self addChildViewController:fifth];
//    [self addChildViewController:sixth];
//    
//    NSArray *arrView = @[third,forth,fifth,sixth];
//    for (int i = 0; i<arrView.count; i++) {
//        UIViewController *temp = arrView[i];
//        temp.view.frame = CGRectMake(i *viewWidth, 0, viewWidth, viewHeight);
//        [self.scrollView addSubview:temp.view];
//    }
//
//    @weakify(self);
//    [self.seg setIndexChangedBloc:^(NSInteger index) {
//        @strongify(self);
//        CGFloat width =  self.view.frame.size.width;
//        CGFloat height = self.view.frame.size.height;
//        [self.scrollView scrollRectToVisible:CGRectMake( width* index, 0, width, height) animated:YES];
//    }];
    
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
    
}

- (void)tapGesture {
    
}

- (IBAction)popButtonAction:(id)sender {
    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ThirdViewController alloc] init]];
//    
//    nav.view.frame = CGRectMake(0, 400, self.view.bounds.size.width, 400);
    
    UIViewController *vc = [UIViewController new];
    
    vc.view.frame = CGRectMake(0, 400, self.view.bounds.size.width, 400);
    
    [self presentPopupViewController:vc
                            animated:YES
                     useBlurForPopup:YES
                        popDirection:DLPopupDirectionBottomToTop
                          completion:^{
                              
                          }];
    
}

#pragma mark ------------------ uipageviewcontrollerdatasource --------------------

//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
//    
//    
//}
//
//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
//    
//}


#pragma mark ------------------ uipageviwecontrollerDelegate --------------------

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    
}


- (UIInterfaceOrientationMask)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController {
    
    return UIInterfaceOrientationMaskPortrait;
    
}
- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController {
    
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
