//
//  AppDelegate.m
//  BKTest
//
//  Created by CY on 2018/1/16.
//  Copyright © 2018年 c123. All rights reserved.
//
#import "IVUIKit.h"
#import "AppDelegate.h"
#import "TestViewController.h"
#import "ViewController.h"

@interface AppDelegate ()<CYTabBarControllerConfigDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.cytbcc = [[CYTabBarControllerConfig alloc] init];
    self.cytbcc.dataSource = self;
    [self.cytbcc setSubViewControllers:[self tabBarViewControllers]];
    [self.cytbcc setSubVCItemsAttributes:[self tabBarItemsAttributesForController]];
    [self.cytbcc.tabBarController setSelectedIndex:0];
    self.window.rootViewController = self.cytbcc.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (int)tabbarTintColor {
    return 0XFFFFFF;
}

- (UIImageRenderingMode)tabbarItemSelectImageRenderingMode {
    NSLog(@"%s",__func__);
    return UIImageRenderingModeAlwaysOriginal;
}
- (int)tabbarTitleSelectColor {
    return 0X989898;
}
- (int)tabbarTitleUnSelectColor {
    return 0X121212;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYL_TabBarItemTitle : @"Data",
                                                 CYL_TabBarItemImage : @"Data_icon.png",
                                                 CYL_TabBarItemSelectedImage : @"Data_icon Copy.png",
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYL_TabBarItemTitle : @"Device",
                                                  CYL_TabBarItemImage : @"Store_icon.png",
                                                  CYL_TabBarItemSelectedImage : @"Store_icon Copy.png",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYL_TabBarItemTitle : @"Profile",
                                                 CYL_TabBarItemImage : @"Profile_icon.png",
                                                 CYL_TabBarItemSelectedImage : @"Profile_icon Copy.png",
                                                 };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       ];
    return tabBarItemsAttributes;
}

- (NSArray<UIViewController *> *)tabBarViewControllers {
    UIViewController *mvc = [ViewController new];
    UIViewController *dvc = [TestViewController new];
    UIViewController *ivc = [UIViewController new];
    return @[mvc,dvc,ivc];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
