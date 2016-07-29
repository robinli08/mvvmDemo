//
//  ViewController.m
//  DL_MVVM
//
//  Created by Daniel.Li on 7/25/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "ViewController.h"
#import "ProductDataModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error: nil];
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: nil];
    
    ProductDataModel *dataModel = [[ProductDataModel alloc] initWithDictionary:dictionary error:nil];
    
    NSLog (@"%@",dataModel.modules);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
