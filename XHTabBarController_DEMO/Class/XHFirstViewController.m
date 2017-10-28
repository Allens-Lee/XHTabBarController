//
//  FirstViewController.m
//  TabBarController
//
//  Created by 李鑫浩 on 16/6/1.
//  Copyright © 2016年 李鑫浩. All rights reserved.
//

#import "XHFirstViewController.h"
#import "XHSecondViewController.h"
#import "XHTabBarController.h"

@interface XHFirstViewController ()

@end

@implementation XHFirstViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"First";
    
    UIButton *next = [UIButton buttonWithType:UIButtonTypeCustom];
    next.frame = CGRectMake((self.view.frame.size.width - 200) / 2.0f, 180, 200, 40);
    [next setTitle:@"下一页" forState:UIControlStateNormal];
    [next setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [next addTarget:self action:@selector(pushToNextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next];
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
    add.frame = CGRectMake((self.view.frame.size.width - 200) / 2.0f, 280, 200, 40);
    [add setTitle:@"递增" forState:UIControlStateNormal];
    [add setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [add addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add];
    
    UIButton *subtract = [UIButton buttonWithType:UIButtonTypeCustom];
    subtract.frame = CGRectMake((self.view.frame.size.width - 200) / 2.0f, 380, 200, 40);
    [subtract setTitle:@"递减" forState:UIControlStateNormal];
    [subtract setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [subtract addTarget:self action:@selector(subtract) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:subtract];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)pushToNextPage
{
    XHSecondViewController *vc = [[XHSecondViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)add
{
    static NSInteger i = 98;
    [(XHTabBarController *)self.tabBarController setBadgeNum:i ++ withBadgeType:XHBadgeTypeNum withIndex:0];
}

- (void)subtract
{
    static NSInteger j = 2;
    [(XHTabBarController *)self.tabBarController setBadgeNum:j -- withBadgeType:XHBadgeTypeNum withIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
