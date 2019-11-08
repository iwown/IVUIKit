//
//  UIImage+Color.h
//  ZeronerHealthPro
//
//  Created by CY on 2017/4/25.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)gradientImage:(CGRect)frame andStartColor:(UIColor *)color andEndColor:(UIColor *)eColor;

/**! 文字背景图
 [[UIColor alloc] initWithPatternImage:[Toast imageWithText:@"Firmware Upgrade"]]
 */
+ (UIColor *)patternImageWithText:(NSString *)text;
+ (UIImage *)imageWithText:(NSString *)text;

@end
