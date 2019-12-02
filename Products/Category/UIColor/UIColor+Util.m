//
//  UIColor+Util.m
//  Linyi
//
//  Created by caike on 16/11/18.
//  Copyright © 2016年 iwown. All rights reserved.
//

#import "UIColor+Util.h"

@implementation UIColor (Util)

#pragma mark - Hex
+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithRGBAHex:(int)hexValue {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF000000) >> 24))/255.0
                           green:((float)((hexValue & 0xFF0000) >> 16))/255.0
                            blue:((float)((hexValue & 0xFF00) >> 8))/255.0
                           alpha:((float)(hexValue & 0xFF))/255.0];
}

+ (UIColor *)colorWithHex:(int)hexValue {
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (UIColor *)colorFromCode:(int)hexCode inAlpha:(float)alpha {
    return [self colorWithHex:hexCode alpha:alpha];
}

+ (UIColor *)colorFromCode:(int)hexCode {
    return [self colorFromCode:hexCode inAlpha:1.0];
}

#pragma mark - Instance Methods
- (UIColor *)antitheticColor {
    CGFloat red, green, blue, alpha;
    BOOL got = [self getRed:&red green:&green blue:&blue alpha:&alpha];
    if (!got) {
        return [UIColor whiteColor];
    }
    UIColor *antitheticColor = [UIColor colorWithRed:1-red green:1-green blue:1-blue alpha:alpha];
    return antitheticColor;
}

- (BOOL)isSameColor:(UIColor *)color {
    if (CGColorEqualToColor(self.CGColor, color.CGColor)) {
        return YES;
    }
    return NO;
}

@end
