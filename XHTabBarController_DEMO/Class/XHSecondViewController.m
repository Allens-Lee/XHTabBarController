//
//  XHSecondViewController.m
//  TabBarController
//
//  Created by 李鑫浩 on 16/6/1.
//  Copyright © 2016年 李鑫浩. All rights reserved.
//

#import "XHSecondViewController.h"
#import "XHTabBarController.h"

@interface XHSecondViewController ()

@end

@implementation XHSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Second";

    UIButton *skip = [UIButton buttonWithType:UIButtonTypeCustom];
    skip.frame = CGRectMake((self.view.frame.size.width - 200) / 2.0f, 180, 200, 40);
    [skip setTitle:@"跳转到第三页" forState:UIControlStateNormal];
    [skip setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [skip addTarget:self action:@selector(skipToThreePage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skip];
}

- (void)skipToThreePage
{
    [(XHTabBarController *)self.tabBarController selectControllerWithIndex:2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
