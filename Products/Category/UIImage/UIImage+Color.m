//
//  UIImage+Color.m
//  ZeronerHealthPro
//
//  Created by CY on 2017/4/25.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)gradientImage:(CGRect)frame andStartColor:(UIColor *)color andEndColor:(UIColor *)eColor {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, frame.size.width, 0);
    CGPathAddLineToPoint(path, NULL, frame.size.width, frame.size.height);
    CGPathAddLineToPoint(path, NULL, 0, frame.size.height);
    CGPathCloseSubpath(path);
    
    NSArray *colors = @[(id)color.CGColor,(id)eColor.CGColor]; // 渐变色数组
    //创建CGContextRef
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();   // 上下文文本
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, NULL);    // 渐变颜色效果设置
    //起止点设置
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);    // 添加路径
    CGContextClip(context);
    // 绘制线性渐变
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
    CGContextRestoreGState(context);
    // 需要手动释放
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGPathRelease(path);
    
    // 从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark -Color
+ (UIColor *)patternImageWithText:(NSString *)text {
    return [[UIColor alloc] initWithPatternImage:[self imageWithText:text]];
}

+ (UIImage *)imageWithText:(NSString *)text {
    return [self imageWithText:text andBGColor:[UIColor clearColor] andTextColor:[UIColor colorWithRed:0.23 green:0.87 blue:0.34 alpha:0.5]];
}

+ (UIImage *)imageWithText:(NSString *)text andBGColor:(UIColor *)bgColor andTextColor:(UIColor *)textColor {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 100)];
    view.backgroundColor = bgColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:14.0];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.transform = CGAffineTransformMakeRotation(-M_PI/4.0);
    [view addSubview:label];
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
