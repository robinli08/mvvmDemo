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
#import "DLAutoScrollLabel.h"
#import "ThirdViewController.h"
#import "UIViewController+Popup.h"


@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet DLAutoScrollLabel *scrollLabelView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = @"我是label1234567890";
    
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
    
    DLAutoScrollLabel *scrollLabel = [[DLAutoScrollLabel alloc] initWithFrame:CGRectMake(100, 400, 115, 40)];
    
    scrollLabel.text = str;
    
    NSLog(@"%@",scrollLabel.text);

    self.scrollLabelView.text = str;
    
    UITapGestureRecognizer *tapReg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self.view addGestureRecognizer:tapReg];
    
    [self.view addSubview:self.scrollLabelView];
    [self.view addSubview:scrollLabel];
    
}

- (void)tapGesture {
    
}

- (IBAction)popButtonAction:(id)sender {
    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ThirdViewController alloc] init]];
//    
//    nav.view.frame = CGRectMake(0, 400, self.view.bounds.size.width, 400);
    
    UIViewController *vc = [UIViewController new];
    
    vc.view.frame = CGRectMake(0, 400, self.view.bounds.size.width, 400);
    
    [self presentPopupViewController:vc
                            animated:YES
                     useBlurForPopup:YES
                        popDirection:DLPopupDirectionBottomToTop
                          completion:^{
                              
                          }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
