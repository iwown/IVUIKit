//
//  KitManager.m
//  IVUIKit
//
//  Created by west on 2018/3/2.
//  Copyright © 2018年 c123. All rights reserved.
//
#define THEME_KIT_MANAGER @"THEME_KIT_MANAGER"
#import "KitManager.h"
#import "UIColor+Util.h"

@implementation KitManager

static float statusBarHeight = 0;
static int __theme = 0;
+ (void)initinal {
    [KitManager statusBarHeight];
    __theme = (int)[KitManager initTheme];
}

+ (CGFloat)statusBarHeight {
    if (statusBarHeight == 0) {
        statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    }
    return statusBarHeight;
}

+ (void)setTheme:(KitManagerTheme)type {
    __theme = type;
    [[NSUserDefaults standardUserDefaults] setInteger:type forKey:THEME_KIT_MANAGER];
}

+ (KitManagerTheme)theme {
    return __theme;
}

+ (KitManagerTheme)initTheme {
    int themeType = (int)[[NSUserDefaults standardUserDefaults] integerForKey:THEME_KIT_MANAGER];
    if (themeType == 0) {
        themeType = KitManagerTheme_classics;
    }
    [[NSUserDefaults standardUserDefaults] setInteger:themeType forKey:THEME_KIT_MANAGER];
    return themeType;
}

struct ColorTheme {
    int bgColorD ;
    int bgColorL ;
    int bgColorND ;
    int bgColorNL ;
    int bgColorS ;
    
    int bgColorB ;
    int textColorM ;
    int textColorS ;
    int textColorD ;
    int lineColorS ;
    
    int lineColorOn ;
    int lineColorOFF ;
    int selectColorR ;
};

struct ColorTheme Color(int theme) {
    struct ColorTheme A = {1,2,3,4,5,6,7,8,9,10,11,12,13};
    struct ColorTheme a = {0x081024,0x0A1636,0x0937B5,0x186EDC,0x0A1636,
                           0x122B6E,0xFFFFFF,0xB5B7BD,0x4A4B4D,0x24304B,
                           0x00296F,0x1669D7,0xE0584A};
    struct ColorTheme b = {0x989898,0xFFFFFF,0x0937B5,0x186EDC,0x0A1636,
                           0x122B6E,0xFFFFFF,0xB5B7BD,0x4A4B4D,0x24304B,
                           0x00296F,0x1669D7,0xE0584A};
    struct ColorTheme arr[] = {A, a, b};
    return arr[theme];
}
#define COLOR Color(__theme)
+ (UIColor *)bgColorD {
    return [UIColor colorFromCode:COLOR.bgColorD inAlpha:1.0];
}
+ (UIColor *)bgColorL {
    return [UIColor colorFromCode:COLOR.bgColorL inAlpha:1.0];
}
+ (UIColor *)bgColorND {
    return [UIColor colorFromCode:COLOR.bgColorND inAlpha:1.0];
}
+ (UIColor *)bgColorNL {
    return [UIColor colorFromCode:COLOR.bgColorNL inAlpha:1.0];
}
+ (UIColor *)bgColorS {
    return [UIColor colorFromCode:COLOR.bgColorS inAlpha:1.0];
}
+ (UIColor *)bgColorB {
    return [UIColor colorFromCode:COLOR.bgColorB inAlpha:1.0];
}
+ (UIColor *)textColorM {
    return [UIColor colorFromCode:COLOR.textColorM inAlpha:1.0];
}
+ (UIColor *)textColorS {
    return [UIColor colorFromCode:COLOR.textColorS inAlpha:1.0];
}
+ (UIColor *)textColorD {
    return [UIColor colorFromCode:COLOR.textColorD inAlpha:1.0];
}
+ (UIColor *)lineColorS {
    return [UIColor colorFromCode:COLOR.lineColorS inAlpha:1.0];
}
+ (UIColor *)lineColorOn {
    return [UIColor colorFromCode:COLOR.lineColorOn inAlpha:1.0];
}
+ (UIColor *)lineColorOff {
    return [UIColor colorFromCode:COLOR.lineColorOFF inAlpha:1.0];
}
+ (UIColor *)selectColorR {
    return [UIColor colorFromCode:COLOR.selectColorR inAlpha:1.0];
}

+ (BOOL)isIphoneX {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    
    return iPhoneXSeries;
}

@end
