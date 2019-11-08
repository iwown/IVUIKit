//
//  CYBaseNavigationController.m
//  ZeronerHealthPro
//
//  Created by ChenWu on 2017/7/27.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import "CYBaseNavigationController.h"

@interface CYBaseNavigationController ()

@end

@implementation CYBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
