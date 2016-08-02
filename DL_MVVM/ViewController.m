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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel countOfViewModels];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MainTableViewCell cellReuseIdentifier]];
    
    HomepageRowViewModel *rowViewModel = [self.viewModel viewModelAtIndex:indexPath.row];
    cell.textLabel.text = rowViewModel.title;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
