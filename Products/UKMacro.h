//
//  UKMacro.h
//  IVBaseKit
//
//  Created by A$CE on 2017/9/19.
//  Copyright © 2017年 A$CE. All rights reserved.
//

#ifndef UKMacro_h
#define UKMacro_h

#import "KitManager.h"

#pragma mark- IPHONE_SIZE

#define iPhoneX [KitManager isIphoneX]
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#pragma mark- Macro
/*Macro*/
//字体size适配
#define FONT(no) ((iPhone4S||iPhone5)?(no*0.85):((iPhone6)?no:(no*1.1)))
//屏幕宽度
#define BK_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
//屏幕高度
#define BK_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define BK_StatusBarHeight [KitManager statusBarHeight]
#define BK_NavBarHeight 44.0
//导航栏高度
#define BK_NavigationBarHeight  (BK_StatusBarHeight + BK_NavBarHeight)
//TabBar高度
#define BK_TabBarHeight (BK_StatusBarHeight>20?83:49)

#endif /* UKMacro_h */
