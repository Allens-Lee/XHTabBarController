//
//  XHFiveViewController.m
//  TabBarController
//
//  Created by 李鑫浩 on 16/6/1.
//  Copyright © 2016年 李鑫浩. All rights reserved.
//

#import "XHFiveViewController.h"
#import "XHPickerViewController.h"

@interface XHFiveViewController ()

@end

@implementation XHFiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Fivth";
    
    UIButton *alert = [UIButton buttonWithType:UIButtonTypeCustom];
    alert.frame = CGRectMake((self.view.frame.size.width - 200) / 2.0f, 180, 200, 40);
    [alert setTitle:@"选择内容" forState:UIControlStateNormal];
    [alert setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alert addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alert];
}

- (void)showAlert
{
    XHPickerViewController *picker = [[XHPickerViewController alloc]init];
    [picker showIn:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
