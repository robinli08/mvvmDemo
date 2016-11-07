//
//  FifthViewController.m
//  DL_MVVM
//
//  Created by Daniel.Li on 26/10/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "FifthViewController.h"

@interface FifthViewController ()

@end

@implementation FifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableAttributedString *str0  = [[NSMutableAttributedString alloc] initWithString:@"Using NSAttributed String"];
    
    [str0 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,5)];
    
    [str0 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6,12)];
    
    [str0 addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(19,6)];
    
    [str0 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30.0] range:NSMakeRange(0, 5)];
    
    [str0 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0] range:NSMakeRange(6, 12)];
    
    [str0 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:30.0] range:NSMakeRange(19, 6)];
    
//    lbtext.attributedText = str;
    
    
    UILabel *lbtext = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 500)];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"+19.01%"];
    
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,str.length)];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,str.length)];
    
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(2,4)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16] range:NSMakeRange(0, 1)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0] range:NSMakeRange(1, 2)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:12.0] range:NSMakeRange(3, 4)];
    
    lbtext.attributedText = str;
    [self.view addSubview:lbtext];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
