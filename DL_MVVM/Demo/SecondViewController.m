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

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = @"我是label ，我是label";
    
//    CGSize size = [str dl_sizeWithFont:[UIFont systemFontOfSize:12.f]];
    CGSize textSize = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0f]}];
    CGFloat textWidth = ceilf(textSize.width);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, textWidth, textSize.height)];
    label.font = [UIFont systemFontOfSize:16.0f];
 //   label.layer.borderWidth = 0.5f;
   // label.layer.borderColor = [UIColor blueColor].CGColor;
    label.text = str;
    [self.view addSubview:label];
    
    
    DLTagView *tagLable = [[DLTagView alloc] initWithFrame:CGRectMake(100, 200, 50, 40)];
    
    tagLable.textColor = [UIColor redColor];
    
    tagLable.textFont = [UIFont systemFontOfSize:16.f];
    tagLable.edgeInsets = UIEdgeInsetsMake(5, 5, 5, 20);
    
//    tagLable.layer.borderWidth = 0.5f;
    tagLable.layer.borderColor = [UIColor blueColor].CGColor;
    
    tagLable.text = str;
    
    [self.view addSubview:tagLable];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
