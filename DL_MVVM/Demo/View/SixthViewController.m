//
//  SixthViewController.m
//  DL_MVVM
//
//  Created by Daniel.Li on 26/10/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "SixthViewController.h"
#import "HomePageViewModel.h"
#import "MainTableViewCell.h"
#import "UIPageContainerViewController.h"
#import "SecondViewController.h"
#import "HomepageRowViewModel.h"
#import "TestFooterViewController.h"
#import "UIView+HXUtility.h"

@interface SixthViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) HomePageViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic, strong) TestFooterViewController *footerVC;

@end

@implementation SixthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabelView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self bindViewModel];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupTableViewFooter];
}

- (void)setupTabelView {
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.mainTableView registerNib:[MainTableViewCell cellNib] forCellReuseIdentifier:[MainTableViewCell cellReuseIdentifier]];
//    [self setupTableViewFooter];
    
    
}


- (void)bindViewModel {
    
    self.viewModel = [[HomePageViewModel alloc] init];
    
    [[self.viewModel loadData] subscribeNext:^(id x) {

        [self.mainTableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel countOfViewModels];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.viewModel viewModelAtIndex:section] countOfViewModels];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MainTableViewCell cellReuseIdentifier]];
    
    HomepageRowViewModel *rowViewModel = [[self.viewModel viewModelAtIndex:indexPath.section] viewModelAtIndex:indexPath.row];
    cell.textLabel.text = rowViewModel.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        SecondViewController *testLoadVC = [[SecondViewController alloc] init];
        [self.navigationController pushViewController:testLoadVC animated:YES];
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
//    self.mainTableView.tableFooterView.frame = CGRectMake(0, 0, AUTO_ADAPT_SIZE_VALUE(320, 375, 414), 215);
    self.mainTableView.tableFooterView.height = 215;
    [vc refreshSubViews];
    
}


@end
