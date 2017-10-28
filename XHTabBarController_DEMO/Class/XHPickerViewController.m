//
//  XHAlertViewController.m
//  XHTabBarController_DEMO
//
//  Created by 李鑫浩 on 2017/10/25.
//  Copyright © 2017年 allens. All rights reserved.
//

#import "XHPickerViewController.h"

@interface XHPickerViewController ()
{
    UIView *_pickerView;
}

@end

@implementation XHPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *rootView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    rootView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:rootView];
    
    _pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 250)];
    _pickerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pickerView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            _pickerView.transform = CGAffineTransformTranslate(self.view.transform, 0, -250);
        }];
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    if (CGRectContainsPoint(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 250), touchPoint))
    {
        [self dismissSelf];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissSelf
{
    [UIView animateWithDuration:0.3 animations:^{
        _pickerView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

-(void)showIn:(UIViewController *)viewController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.view.backgroundColor = [UIColor clearColor];
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [viewController presentViewController:self animated:NO completion:^{
            
        }];
    });
}

@end
