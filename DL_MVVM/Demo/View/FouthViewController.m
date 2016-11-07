//
//  FouthViewController.m
//  DL_MVVM
//
//  Created by Daniel.Li on 9/7/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "FouthViewController.h"
#import "HXTabItem.h"
#import "HXTabView.h"
#import "UIView+HXUtility.h"

@interface FouthViewController () <HXTabViewDelelgate>

@property (nonatomic, strong) HXTabView *tabView;

@end

@implementation FouthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    HXTabItem *rankItem = [HXTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"allFund"]];
    rankItem.titleString = @"全部基金";
    HXTabItem *categoryItem = [HXTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"hotTopic"]];
    categoryItem.titleString = @"热门主题";
    HXTabItem *infoItem = [HXTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"customize"]];
    infoItem.titleString = @"自选基金";
    
    self.tabView = [[HXTabView alloc] initWithFrame:CGRectMake(0, 64, 375, 85) andTabItems:@[rankItem, categoryItem, infoItem]];
    self.tabView.darkensBackgroundForEnabledTabs = NO;
    self.tabView.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.tabView.titlesFontColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.f];
    self.tabView.delegate = self;
    self.tabView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tabView];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabView:(HXTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(HXTabItem *)tabItem {

}

//Called Only for unexcludable items. (TabTypeUnexcludable)
- (void)tabView:(HXTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(HXTabItem *)tabItem {
    
    
}


@end
