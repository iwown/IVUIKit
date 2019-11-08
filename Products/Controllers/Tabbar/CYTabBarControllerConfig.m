//
//  CYTabBarControllerConfig.m
//  iWOWNfit
//
//  Created by CY on 2016/12/21.
//  Copyright © 2016年 chenyuan. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "CYTabBarControllerConfig.h"
#import "CYBaseNavigationController.h"
#import "UIColor+Util.h"

NSString *const CYL_TabBarItemTitle = @"CY-TabBarItemTitle";
NSString *const CYL_TabBarItemImage = @"CY-TabBarItemImage";
NSString *const CYL_TabBarItemSelectedImage = @"CY-TabBarItemSelectedImage";

@interface CYTabBarControllerConfig ()

@property (nonatomic, readwrite, strong) UITabBarController *tabBarController;

@end

@implementation CYTabBarControllerConfig

- (UITabBarController *)tabBarController {
    
    if (_tabBarController == nil) {
        _tabBarController = [[UITabBarController alloc]init];
        NSMutableArray *vcs = [[NSMutableArray alloc]initWithCapacity:10];
        for (int i = 0; i<self.subViewControllers.count; i++) {
            UIViewController *c1=self.subViewControllers[i];
            NSDictionary *dic = self.subVCItemsAttributes[i];
            NSString *title = dic[CYL_TabBarItemTitle];
            NSString *img0 = dic[CYL_TabBarItemImage];
            NSString *img1 = dic[CYL_TabBarItemSelectedImage];
            if (title) {
                c1.tabBarItem.title=title;
            }
            if (img0) {
                UIImage *imgN = [UIImage imageNamed:img0];
                if ([self.dataSource respondsToSelector:@selector(tabbarItemNormalImageRenderingMode)]) {
                    UIImageRenderingMode rMode = [self.dataSource tabbarItemNormalImageRenderingMode];
                    imgN = [[UIImage imageNamed:img0] imageWithRenderingMode:rMode];
                }
                [c1.tabBarItem setImage:imgN];
            }
            if (img1) {
                UIImage *imgS = [UIImage imageNamed:img1];
                if ([self.dataSource respondsToSelector:@selector(tabbarItemSelectImageRenderingMode)]) {
                    UIImageRenderingMode rMode = [self.dataSource tabbarItemSelectImageRenderingMode];
                    imgS = [[UIImage imageNamed:img1] imageWithRenderingMode:rMode];
                }
                [c1.tabBarItem setSelectedImage:imgS];
            }
            if ([self.dataSource respondsToSelector:@selector(tabbarTitleSelectColor)]) {
                UIColor *stColor = [UIColor colorFromCode:[self.dataSource tabbarTitleSelectColor]];
                [c1.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:stColor} forState:UIControlStateSelected];
            }
            if ([self.dataSource respondsToSelector:@selector(tabbarTitleUnSelectColor)]) {
                UIColor *stColor = [UIColor colorFromCode:[self.dataSource tabbarTitleUnSelectColor]];
                [c1.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:stColor} forState:UIControlStateNormal];
            }
            CYBaseNavigationController *navVC = [[CYBaseNavigationController alloc]initWithRootViewController:c1];
            navVC.navigationBar.hidden = YES;
            [vcs addObject:navVC];
        }
        UIColor *tintColor = [UIColor colorFromCode:0x081024];
        if ([self.dataSource respondsToSelector:@selector(tabbarTintColor)]) {
            tintColor = [UIColor colorFromCode:[self.dataSource tabbarTintColor]];
        }
        _tabBarController.viewControllers = vcs;
        _tabBarController.tabBar.barTintColor = tintColor;
        _tabBarController.tabBar.translucent = NO;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    if (_subViewControllers) {
        return _subViewControllers;
    }
    UIViewController *dvc = [[UIViewController alloc] init];
    return @[dvc];
}

- (void)selectedTabBarIndex:(NSInteger)index {
    _tabBarController.selectedIndex=index;
}

@end
