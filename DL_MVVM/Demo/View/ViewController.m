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


@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupTabelView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self bindViewModel];
}

- (void)setupTabelView {
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.mainTableView registerNib:[MainTableViewCell cellNib] forCellReuseIdentifier:[MainTableViewCell cellReuseIdentifier]];
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
    
    SecondViewController *vc = [[SecondViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
