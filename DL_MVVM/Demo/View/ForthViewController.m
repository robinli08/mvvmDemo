//
//  ForthViewController.m
//  DL_MVVM
//
//  Created by Daniel.Li on 26/10/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "ForthViewController.h"

@interface ForthViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation ForthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 25)];
    self.textField = textField;
    self.textField.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.textField];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    
    
}

@end
