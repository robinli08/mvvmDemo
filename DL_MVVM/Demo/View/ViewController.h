//
//  ViewController.h
//  DL_MVVM
//
//  Created by Daniel.Li on 7/25/16.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageViewModel.h"

@interface ViewController : UIViewController


@property (nonatomic, strong) HomePageViewModel *viewModel;

@end

