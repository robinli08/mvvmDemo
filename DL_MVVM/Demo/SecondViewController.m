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
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DL_SegmentedControl.h"
#import "DLRainbowSegmentControl.h"
#import "ForthViewController.h"
#import "FifthViewController.h"
#import "SixthViewController.h"
#import "DLOptionsView.h"

@interface SecondViewController ()

@property (weak, nonatomic) IBOutlet DLOptionsView *optionsView;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DLRainbowSegmentControl *seg;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) UIImageView *headerImageView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 80, 80)];
    self.headerImageView.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:self.headerImageView];
    
    float viewWidth = 80;
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 2;
    
    [[UIColor whiteColor] setStroke];
    
    [path moveToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (viewWidth / 2), (viewWidth / 4))];
    
    [path addLineToPoint:CGPointMake((viewWidth / 2), 0)];
    
    [path addLineToPoint:CGPointMake(viewWidth - ((sin(M_1_PI / 180 * 60)) * (viewWidth / 2)), (viewWidth / 4))];
    
    [path addLineToPoint:CGPointMake(viewWidth - ((sin(M_1_PI / 180 * 60)) * (viewWidth / 2)), (viewWidth / 2) + (viewWidth / 4))];
    
    [path addLineToPoint:CGPointMake((viewWidth / 2), viewWidth)];
    
    [path addLineToPoint:CGPointMake((sin(M_1_PI / 180 * 60)) * (viewWidth / 2), (viewWidth / 2) + (viewWidth / 4))];
    
    [path closePath];
    
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.lineWidth = 2;
    shapLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapLayer.path = path.CGPath;
    
//    self.headerImageView.layer.mask = shapLayer;
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 400, 1000, 500)];
    label.numberOfLines = 0;//设置段落paragraphStyle，numberOfLines必须为0
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.backgroundColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    NSString *str1 = @"全球开发者大会（WWDC）";
    NSString *str2 = @"美国在旧金山芳草地";
    NSString *str5 = @"太平洋时间";
    NSString *str3 = @"开始：2016-03-10";
    NSString *str4 = @"结束：2016-03-20";
    NSString *string = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@",str1,str2,str5,str3,str4];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 20.0;
    NSDictionary *attrsDictionary1 = @{NSFontAttributeName:[UIFont systemFontOfSize:30],
                                       NSParagraphStyleAttributeName:paragraphStyle};
    NSDictionary *attrsDictionary2 = @{NSParagraphStyleAttributeName:paragraphStyle};
    //给str1添加属性，字体加粗，并且设置段落间隙
    [attributedString addAttributes:attrsDictionary1 range:NSMakeRange(0, str1.length)];
    //给str2设置段落间隙
    [attributedString addAttributes:attrsDictionary2 range:NSMakeRange(str1.length, str2.length)];
    //attributedString如果还有别的样式需要添加可以这样依次加属性
    label.attributedText = attributedString;
    [self.view addSubview:label];
    
    self.optionsView.backgroundColor = [UIColor redColor];
    self.optionsView.options = @[@"我的积分",@"现金宝",@"我的余额",@"我的定期",@"我的积分",@"现金宝",@"我的余额",@"我的定期",@"我的积分",@"现金宝",@"我的余额",@"我的定期",@"我的积分",@"现金宝",@"我的余额",@"我的定期"];
    [self.optionsView reloadOptionButtons];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
