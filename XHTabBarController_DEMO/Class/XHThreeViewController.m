//
//  XHThreeViewController.m
//  TabBarController
//
//  Created by 李鑫浩 on 16/6/1.
//  Copyright © 2016年 李鑫浩. All rights reserved.
//

#import "XHThreeViewController.h"
#import "XHSecondViewController.h"
#import "XHTabBarController.h"

@interface XHThreeViewController ()

@end

@implementation XHThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Third";
    
    UIButton *next = [UIButton buttonWithType:UIButtonTypeCustom];
    next.frame = CGRectMake((self.view.frame.size.width - 200) / 2.0f, 180, 200, 40);
    [next setTitle:@"下一页" forState:UIControlStateNormal];
    [next setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [next addTarget:self action:@selector(pushToNextPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next];
    
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    close.frame = CGRectMake((self.view.frame.size.width - 200) / 2.0f, 280, 200, 40);
    [close setTitle:@"关闭" forState:UIControlStateNormal];
    [close setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:close];
}

- (void)pushToNextPage
{
    XHSecondViewController *vc = [[XHSecondViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)closeSelf
{
    XHTabBarController *tabBarC = (XHTabBarController *)self.tabBarController;
    [tabBarC selectControllerWithIndex:tabBarC.lastSelectedIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
