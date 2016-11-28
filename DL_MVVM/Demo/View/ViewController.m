//
//  ViewController.m
//  DL_MVVM
//
//  Created by Daniel.Li on 7/25/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "ViewController.h"
#import "MainTableViewCell.h"
#import "HomepageRowViewModel.h"
#import "SecondViewController.h"
#import "UIPageContainerViewController.h"
#import "UIResponder+FirstResponder.h"
#import "TestFooterViewController.h"
#import "UIView+HXUtility.h"
#import <NAModalSheet/NAModalSheet.h>



@interface ViewController () <UITableViewDelegate,UITableViewDataSource,NAModalSheetDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) TestFooterViewController *footerVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabelView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self bindViewModel];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

- (void)setupTabelView {
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.mainTableView registerNib:[MainTableViewCell cellNib] forCellReuseIdentifier:[MainTableViewCell cellReuseIdentifier]];
    [self setupTableViewFooter];
    

}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)bindViewModel {
    
    self.viewModel = [[HomePageViewModel alloc] init];
    
    [[self.viewModel loadData] subscribeNext:^(id x) {
        [self.mainTableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    return [self.viewModel countOfViewModels];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     NSLog(@"%@",NSStringFromSelector(_cmd));
    return [[self.viewModel viewModelAtIndex:section] countOfViewModels];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSLog(@"%@",NSStringFromSelector(_cmd));
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
     NSLog(@"%@",NSStringFromSelector(_cmd));
    return 15.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSLog(@"%@",NSStringFromSelector(_cmd));
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MainTableViewCell cellReuseIdentifier]];
    
    HomepageRowViewModel *rowViewModel = [[self.viewModel viewModelAtIndex:indexPath.section] viewModelAtIndex:indexPath.row];
    cell.textLabel.text = rowViewModel.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     
    if (indexPath.section == 0) {
//        SecondViewController *testLoadVC = [[SecondViewController alloc] init];
//        [self.navigationController pushViewController:testLoadVC animated:YES];
        [self show];
    } else {
        UIPageContainerViewController *vc = [[UIPageContainerViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)setupTableViewFooter {
    
    TestFooterViewController *vc = [[TestFooterViewController alloc] init];
    
    vc.view.frame = CGRectMake(0, 0, AUTO_ADAPT_SIZE_VALUE(320, 375, 414), 215);
    self.footerVC = vc;
//    self.mainTableView.frame = CGRectMake(0, 0, AUTO_ADAPT_SIZE_VALUE(320, 375, 414), 215);
    
//    [self.mainTableView.tableFooterView addSubview:vc.view];
    self.mainTableView.tableFooterView = self.footerVC.view;
    self.mainTableView.tableFooterView.frame = CGRectMake(0, 0, AUTO_ADAPT_SIZE_VALUE(320, 375, 414), 215);
    [vc refreshSubViews];
}

- (void)show {
    
    SecondViewController *secondVc = [[SecondViewController alloc] init];
    
    secondVc.view.frame = CGRectMake(0, 0, 300, 400);
    secondVc.view.layer.cornerRadius = 10.f;
    NAModalSheet *sheet = [[NAModalSheet alloc] initWithViewController:secondVc presentationStyle:NAModalSheetPresentationStyleFadeInCentered];
    sheet.cornerRadiusWhenCentered = 10;
    sheet.delegate = self;
    [sheet presentWithCompletion:nil];
    
}

- (void)modalSheetTouchedOutsideContent:(NAModalSheet *)sheet
{
    [sheet dismissWithCompletion:nil];
}

- (BOOL)modalSheetShouldAutorotate:(NAModalSheet *)sheet
{
    return NO;
}

- (NSUInteger)modalSheetSupportedInterfaceOrientations:(NAModalSheet *)sheet
{
    return UIInterfaceOrientationMaskPortrait;
}


@end
