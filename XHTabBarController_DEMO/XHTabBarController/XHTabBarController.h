//
//  XHTabBarController.h
//  GaiLvLun
//
//  Created by 李鑫浩 on 2017/10/24.
//  Copyright © 2017年 见寻文化. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromHex(hexValue)         UIColorFromHexWithAlpha(hexValue,1.0)
#define UIColorFromHexWithAlpha(hexValue,a)  [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF)) /255.0 \
alpha:a]

typedef NS_ENUM(NSUInteger, XHBadgeType) {
    XHBadgeTypeNum,                 //显示出数字
    XHBadgeTypePoint,                //显示为一个小红点
};


@interface UINavigationController (XH)

@end

@interface XHTabBarController : UITabBarController  <UINavigationControllerDelegate>

/**
 分栏条  默认背景色为白色
 */
@property (nonatomic, strong) UIImageView *tabBarView;

/**
 是否隐藏导航条    默认：YES
 */
@property (nonatomic, assign) BOOL isHiddenNavigationBar;

/**
 分栏项标题普通状态下的颜色    默认：0x999999
 */
@property (nonatomic, strong) UIColor *itemTitleNormalColor;

/**
 分栏项标题选中状态下的颜色    默认：0x4ba634
 */
@property (nonatomic, strong) UIColor *itemTitleSelectedColor;

/**
 分栏项标题的字体大小    默认：[UIFont systemFontOfSize:11.0f]
 */
@property (nonatomic, strong) UIFont *itemTitleFont;

/**
 分栏条顶部分隔线颜色    默认：0xdedede
 */
@property (nonatomic, strong) UIColor *tabBarSeparatorColor;

/**
 分栏项图片高度占比      默认：0.65
 */
@property (nonatomic, assign) CGFloat itemImageHeightScale;

/**
 设置内容区域的边距
 */
@property (nonatomic) UIEdgeInsets contentEdge;

/**
 上次选择的视图控制器的index
 */
@property (nonatomic, assign, readonly) NSInteger lastSelectedIndex;

/**
 将要跳转到选定的控制器
 */
@property (nonatomic, copy) BOOL (^willSkipToSelectViewController) (NSInteger selectIndex);

/**
 已经选中未选中的分栏项
 */
@property (nonatomic, copy) void (^didSelected) (NSInteger selectIndex);

/**
 再一次选中已经选中的分栏项
 */
@property (nonatomic, copy) void (^didSelectOnceAgain) (NSInteger selectIndex);

/**
 添加分栏项

 @param viewControllerClass 分栏控制器
 @param itemTitle 分栏项标题
 @param itemNormalImage 分栏项图片的普通状态
 @param itemSelectedImage 分栏项图片的选中状态
 */
- (void)addViewController:(Class)viewControllerClass
                itemTitle:(NSString *)itemTitle
           itemNormalImage:(UIImage *)itemNormalImage
         itemSelectedImage:(UIImage *)itemSelectedImage;

/**
 设置单元格被图片充满，并且设置当点击该单元格的时候，是否需要显示分栏条，默认是需要显示的

 @param index 单元格序号
 @param show 是否显示分栏条
 */
- (void)setItemFullOfImageWithIndex:(NSInteger)index whetherShowTabBar:(BOOL)show;

/**
 选择要显示的分栏控制器

 @param argIndex 分栏控制器序号
 */
- (void)selectControllerWithIndex:(NSInteger)argIndex;

/**
 根据徽标类型给指定的item赋徽标值

 @param num 徽标值
 @param type 徽标类型
 @param index 分栏项序号
 */
- (void)setBadgeNum:(NSInteger)num withBadgeType:(XHBadgeType)type withIndex:(NSInteger)index;

/**
 *  显示分栏项
 */
- (void)showTabBar;

/**
 *  隐藏分栏项
 */
- (void)hideTabBar;

@end


@interface XHTabBarItem : UIButton

/**
 徽标
 */
@property (nonatomic, strong) UILabel *badgeTitle;

/**
 是否显示分栏条 
 */
@property (nonatomic, assign) BOOL isShowTabBar;

/**
 图片的高度所占的比例
 */
@property (nonatomic, assign) CGFloat itemImageHeightScale;

/**
 设置内容区域的边距
 */
@property (nonatomic) UIEdgeInsets contentEdge;

/**
 设置徽标值

 @param num 徽标值
 @param type 徽标类型
 */
- (void)setBadgeNum:(NSInteger)num withBandgeType:(XHBadgeType)type;

@end
