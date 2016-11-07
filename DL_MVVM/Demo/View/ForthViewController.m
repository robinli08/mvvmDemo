//
//  ForthViewController.m
//  DL_MVVM
//
//  Created by Daniel.Li on 26/10/2016.
//  Copyright © 2016 Daniel.Li. All rights reserved.
//

#import "ForthViewController.h"

@interface ForthViewController ()

@end

@implementation ForthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 500)];
    label.numberOfLines = 0;//设置段落paragraphStyle，numberOfLines必须为0
    label.lineBreakMode = NSLineBreakByWordWrapping;
//    label.backgroundColor = [UIColor redColor];
    
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
