//
//  AppDelegate.h
//  BKTest
//
//  Created by CY on 2018/1/16.
//  Copyright © 2018年 c123. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTabBarControllerConfig;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/** Monitor tabbar viewController*/
@property (strong, nonatomic) CYTabBarControllerConfig *cytbcc;

@end

