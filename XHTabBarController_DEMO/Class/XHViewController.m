//
//  XHViewController.m
//  XHTabBarController_DEMO
//
//  Created by 李鑫浩 on 2017/10/25.
//  Copyright © 2017年 allens. All rights reserved.
//

#import "XHViewController.h"

@interface XHViewController ()

@end

@implementation XHViewController

- (void)loadView
{
    [super loadView];

    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
