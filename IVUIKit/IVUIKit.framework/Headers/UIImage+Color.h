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
+ (UIImage *)gradientImage:(CGRect)frame andStartColor:(UIColor *)color andEndColor:(UIColor *)eColor;
@end
