//
//  XHTabBarController.m
//  GaiLvLun
//
//  Created by 李鑫浩 on 2017/10/24.
//  Copyright © 2017年 见寻文化. All rights reserved.
//

#import "XHTabBarController.h"
#import <objc/runtime.h>

NSInteger const kItemBaseTag = 1000;

@implementation UINavigationController (XH)

+ (void)load
{
    method_exchangeImplementations(class_getInstanceMethod(self.class, @selector(pushViewController:animated:)),
                                   class_getInstanceMethod(self.class, @selector(xh_pushViewController:animated:)));
}

- (void)xh_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [(XHTabBarController *)self.tabBarController hideTabBar];
    [self xh_pushViewController:viewController animated:animated];
}

@end

@interface XHTabBarController ()
{
    NSMutableArray *_viewControllers;                                    ///控制器数组
    NSMutableArray *_tabBarItems;                                         ///分栏单元项
    UIImageView *_tabBarSeparator;                                       ///分栏条分隔线
    XHTabBarItem *_selectedTabBarItem;                               ///选中的分栏项
    NSInteger _lastSelectedIndex;                                            ///上次选择的视图控制器的index
}

@end

@implementation XHTabBarController

@synthesize lastSelectedIndex = _lastSelectedIndex;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBar.hidden = YES;
    self.tabBar.backgroundColor = [UIColor clearColor];
    _viewControllers = [NSMutableArray arrayWithCapacity:5];
    _tabBarItems = [NSMutableArray arrayWithCapacity:5];
    [self initSomeSetting];
    [self createTabBarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Intiailize method
- (void)initSomeSetting
{
    self.isHiddenNavigationBar = YES;
    if (!self.itemTitleNormalColor)
    {
        self.itemTitleNormalColor = UIColorFromHex(0x999999);
    }
    if (!self.itemTitleSelectedColor)
    {
        self.itemTitleSelectedColor = UIColorFromHex(0x4ba634);
    }
    if (!self.tabBarSeparatorColor)
    {
        self.tabBarSeparatorColor = UIColorFromHex(0xdedede);
    }
    if (!self.itemTitleFont)
    {
        self.itemTitleFont = [UIFont systemFontOfSize:11.0f];
    }
    if (self.itemImageHeightScale <= 0.0)
    {
        self.itemImageHeightScale = 0.65;
    }
    if ([NSStringFromUIEdgeInsets(self.contentEdge) isEqualToString:NSStringFromUIEdgeInsets(UIEdgeInsetsZero)])
    {
        self.contentEdge = UIEdgeInsetsMake(5, 0, 5, 0);
    }
}

#pragma mark -- AddSubviews method
- (void)createTabBarView
{
    self.tabBarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - self.tabBar.frame.size.height, self.view.frame.size.width, self.tabBar.frame.size.height)];
    self.tabBarView.autoresizingMask =  UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    self.tabBarView.backgroundColor = [UIColor whiteColor];
    self.tabBarView.userInteractionEnabled = YES;
    self.tabBarView.clipsToBounds = YES;
    [self.view addSubview:self.tabBarView];
    
    _tabBarSeparator = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.tabBarView.frame.size.width, 1.0f)];
    _tabBarSeparator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _tabBarSeparator.backgroundColor = self.tabBarSeparatorColor;
    [self.tabBarView addSubview:_tabBarSeparator];
}

#pragma mark -- Public method
- (void)addViewController:(Class)viewControllerClass itemTitle:(NSString *)itemTitle itemNormalImage:(UIImage *)itemNormalImage itemSelectedImage:(UIImage *)itemSelectedImage
{
    if ([[viewControllerClass class] isSubclassOfClass:[UIViewController class]])
    {
        UIViewController *viewController = [[viewControllerClass alloc]init];
        UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:viewController];
        navigationController.navigationBarHidden = self.isHiddenNavigationBar;
        navigationController.delegate = self;
        [_viewControllers addObject:navigationController];
        self.viewControllers = _viewControllers;
        
        XHTabBarItem *tabBarItem = [[XHTabBarItem alloc] init];
        tabBarItem.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        [tabBarItem setTitleColor:self.itemTitleNormalColor forState:UIControlStateNormal];
        [tabBarItem setTitleColor:self.itemTitleSelectedColor forState:UIControlStateSelected];
        tabBarItem.titleLabel.font = self.itemTitleFont;
        tabBarItem.tag = kItemBaseTag + _tabBarItems.count;
        [tabBarItem setTitle:itemTitle forState:UIControlStateNormal];
        [tabBarItem setImage:itemNormalImage forState:UIControlStateNormal];
        [tabBarItem setImage:itemSelectedImage forState:UIControlStateSelected];
        tabBarItem.itemImageHeightScale = self.itemImageHeightScale;
        tabBarItem.contentEdge = self.contentEdge;
        tabBarItem.isShowTabBar = YES;
        [tabBarItem addTarget:self action:@selector(selectViewControllerWithItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBarView addSubview:tabBarItem];
        [_tabBarItems addObject:tabBarItem];
        [self resetTabBarItem];
    }
}

- (void)setItemFullOfImageWithIndex:(NSInteger)index whetherShowTabBar:(BOOL)show
{
    if (_tabBarItems.count > index)
    {
        XHTabBarItem *tabBarItem = [_tabBarItems objectAtIndex:index];
        tabBarItem.itemImageHeightScale = 1.0;
        tabBarItem.isShowTabBar = show;
    }
}

- (void)selectControllerWithIndex:(NSInteger)index
{
    XHTabBarItem *tabBarItem = [_tabBarItems objectAtIndex:index];
    [self selectViewControllerWithItem:tabBarItem];
}

- (void)setBadgeNum:(NSInteger)num withBadgeType:(XHBadgeType)type withIndex:(NSInteger)index
{
    XHTabBarItem *tabBarItem = [_tabBarItems objectAtIndex:index];
    [tabBarItem setBadgeNum:num withBandgeType:type];
}

- (void)hideTabBar
{
    UINavigationController *selectedViewController = self.selectedViewController;
    UIViewController *viewController = [selectedViewController.viewControllers firstObject];
    if (![self.tabBarView.superview isEqual:viewController.view])
    {
        [viewController.view addSubview:self.tabBarView];
    }
}

- (void)showTabBar
{
    [self.view addSubview:self.tabBarView];
}

#pragma mark -- Private method
- (void)resetTabBarItem
{
    CGFloat itemWidth = self.view.frame.size.width / _tabBarItems.count;
    for (NSInteger i = 0; i < _tabBarItems.count; i ++)
    {
        XHTabBarItem *tabBarItem = [_tabBarItems objectAtIndex:i];
        tabBarItem.frame = CGRectMake(itemWidth * i, 1.0f, itemWidth, self.tabBar.frame.size.height - 1.0f);
        i != 0 ?: [self selectViewControllerWithItem:tabBarItem];
    }
}

- (void)selectViewControllerWithItem:(XHTabBarItem *)item
{
    if (self.willSkipToSelectViewController && !self.willSkipToSelectViewController(item.tag - kItemBaseTag))
    {
        return;
    }
    else
    {
        if (_selectedTabBarItem == item)
        {
            !self.didSelectOnceAgain ?: self.didSelectOnceAgain (item.tag - kItemBaseTag);
        }
        else
        {
            _lastSelectedIndex = _selectedTabBarItem.tag - kItemBaseTag;
            _selectedTabBarItem.selected = NO;
            _selectedTabBarItem = item;
            _selectedTabBarItem.selected = YES;
            _tabBarView.hidden = !_selectedTabBarItem.isShowTabBar;
            [self setSelectedIndex:_selectedTabBarItem.tag - kItemBaseTag];
            !self.didSelectOnceAgain ?: self.didSelectOnceAgain (_selectedTabBarItem.tag - kItemBaseTag);
            UINavigationController *selectedViewController = self.selectedViewController;
            if ([selectedViewController.viewControllers firstObject] != [selectedViewController topViewController])
            {
                [self hideTabBar];
            }
            else
            {
                [self showTabBar];
            }
        }
    }
}

#pragma mark -- UINavigationControllerDelegate method
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed=YES;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed=YES;
    if (navigationController.viewControllers.count == 1)
    {
        [self showTabBar];
    }
}

@end

@implementation XHTabBarItem

- (void)setHighlighted:(BOOL)highlighted
{
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat width = contentRect.size.width;
    CGFloat height = contentRect.size.height;
    if (self.itemImageHeightScale == 1.0f)
    {
        return CGRectMake(0, 0, width, height);
    }
    else
    {
        return CGRectMake(0, self.contentEdge.top, width, (height - self.contentEdge.top - self.contentEdge.bottom) * self.itemImageHeightScale);
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat width = contentRect.size.width;
    CGFloat height = (contentRect.size.height - self.contentEdge.top - self.contentEdge.bottom) * (1 - self.itemImageHeightScale);
    CGFloat y = contentRect.size.height - height;
    if (self.itemImageHeightScale == 1.0f)
    {
        return CGRectMake(0, 0, width, 0);
    }
    else
    {
        return CGRectMake(0, y + (height - 11) - self.contentEdge.bottom, width, 11);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    _badgeTitle.center = CGPointMake(self.frame.size.width / 2.0 + self.frame.size.height / 4.0f, self.frame.size.height / 4.0f);
    _badgeTitle.layer.cornerRadius = _badgeTitle.frame.size.height / 2.0f;
    _badgeTitle.layer.masksToBounds = YES;
}

#pragma mark -- Private method
- (UILabel *)badgeTitle
{
    if (!_badgeTitle)
    {
        _badgeTitle = [[UILabel alloc]init];
        _badgeTitle.backgroundColor = [UIColor redColor];
        _badgeTitle.textColor = [UIColor whiteColor];
        _badgeTitle.font = [UIFont systemFontOfSize:11.0f];
        _badgeTitle.textAlignment = NSTextAlignmentCenter;
        _badgeTitle.hidden = YES;
        [self addSubview:_badgeTitle];
    }
    return _badgeTitle;
}

#pragma mark -- Public method
- (void)setBadgeNum:(NSInteger)num withBandgeType:(XHBadgeType)type
{
    if (num <= 0)
    {
        self.badgeTitle.hidden = YES;
        return;
    }
    if (type == XHBadgeTypeNum)
    {
        if (num > 99)
        {
            self.badgeTitle.frame = CGRectMake(0, 0, 25, 15);
            self.badgeTitle.text = @"99+";
        }
        else
        {
            self.badgeTitle.frame = CGRectMake(0, 0, 15, 15);
            self.badgeTitle.text = [NSString stringWithFormat:@"%li",(NSInteger)num];
        }
    }
    else
    {
        self.badgeTitle.frame = CGRectMake(0, 0, 8.0f, 8.0f);
        self.badgeTitle.text = @"";
    }
    self.badgeTitle.hidden = NO;
    [self setNeedsLayout];
}

@end
