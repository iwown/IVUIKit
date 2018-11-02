//
//  KitManager.h
//  IVUIKit
//
//  Created by west on 2018/3/2.
//  Copyright © 2018年 c123. All rights reserved.
//
typedef enum {
    KitManagerTheme_null = 0,
    KitManagerTheme_classics = 1,
    KitManagerTheme_blueSky = 2,
} KitManagerTheme;
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KitManager : NSObject

+ (void)initinal;
+ (CGFloat)statusBarHeight;

+ (void)setTheme:(KitManagerTheme)type;
+ (KitManagerTheme)theme;
/**! Main bg color*/
+ (UIColor *)bgColorD;
/**! Graditional color*/
+ (UIColor *)bgColorL;
/**! Navigation Bar color deep*/
+ (UIColor *)bgColorND;
/**! Navigation Bar color light*/
+ (UIColor *)bgColorNL;
/**! Section color*/
+ (UIColor *)bgColorS;
/**! Button color*/
+ (UIColor *)bgColorB;
/**! Main text color*/
+ (UIColor *)textColorM;
/**! Detail text color*/
+ (UIColor *)textColorS;
/**! Deep text color<##>*/
+ (UIColor *)textColorD;
/**! Segment line color*/
+ (UIColor *)lineColorS;
/**! NewProfile_ON_LINE_COLOR*/
+ (UIColor *)lineColorOn;
/**! NewProfile_OFF_LINE_COLOR*/
+ (UIColor *)lineColorOff;
/**! SelectedDateCircleColor*/
+ (UIColor *)selectColorR;


+ (BOOL)isIphoneX;

@end
