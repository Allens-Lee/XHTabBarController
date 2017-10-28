//
//  XHSixViewController.m
//  XHTabBarController_DEMO
//
//  Created by 李鑫浩 on 2017/10/25.
//  Copyright © 2017年 allens. All rights reserved.
//

#import "XHSixViewController.h"

@interface XHSixViewController ()

@end

@implementation XHSixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake((self.view.frame.size.width - 200) / 2.0f, 180, 200, 40);
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    close.frame = CGRectMake((self.view.frame.size.width - 200) / 2.0f, 280, 200, 40);
    [close setTitle:@"关闭" forState:UIControlStateNormal];
    [close setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(closeSelf) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:close];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)closeSelf
{
    !self.callBack ?: self.callBack ();
    [self back];
}

@end
