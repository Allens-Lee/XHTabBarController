//
//  XHFourViewController.m
//  TabBarController
//
//  Created by 李鑫浩 on 16/6/1.
//  Copyright © 2016年 李鑫浩. All rights reserved.
//

#import "XHFourViewController.h"
#import "XHTabBarController.h"

@interface XHFourViewController ()

@end

@implementation XHFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Fourth";
    
    UIButton *next = [UIButton buttonWithType:UIButtonTypeCustom];
    next.frame = CGRectMake((self.view.frame.size.width - 200) / 2.0f, 180, 200, 40);
    [next setTitle:@"显示point型Badge" forState:UIControlStateNormal];
    [next setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [next addTarget:self action:@selector(showBadge) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next];
    
    UIButton *next2 = [UIButton buttonWithType:UIButtonTypeCustom];
    next2.frame = CGRectMake((self.view.frame.size.width - 200) / 2.0f, 280, 200, 40);
    [next2 setTitle:@"隐藏point型Badge" forState:UIControlStateNormal];
    [next2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [next2 addTarget:self action:@selector(hideBadge) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showBadge
{
    [(XHTabBarController *)self.tabBarController setBadgeNum:12 withBadgeType:XHBadgeTypePoint withIndex:3];
}

- (void)hideBadge
{
    [(XHTabBarController *)self.tabBarController setBadgeNum:0 withBadgeType:XHBadgeTypePoint withIndex:3];
}

@end
