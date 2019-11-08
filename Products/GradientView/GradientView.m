//
//  GradientView.m
//  TT
//
//  Created by 曹凯 on 16/5/25.
//  Copyright © 2016年 leopard. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView
{
    GradientDirection _cgd;
}

+ (UIImageView *)gradientImageView:(CGRect)frame
                     andStartColor:(UIColor *)color
                       andEndColor:(UIColor *)eColor {
    
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
    //   CGFloat locations[] = { 0.0, 0.3, 1.0 }; // 颜色位置设置,要跟颜色数量相等，否则无效
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
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    return imgView;
}

+ (CAGradientLayer *)createGradientLayerWithFrame:(CGRect)frame
                                GradientDirection:(GradientDirection)direction
                                       StartColor:(UIColor *)startColor
                                         EndColor:(UIColor *)endColor {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    
    switch (direction) {
        case GradientDirectionFromTop:
        {
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1);
        }
            break;
        case GradientDirectionFromLeft:
        {
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1, 0);
        }
            break;
        case GradientDirectionFromLeftAndTop:
        {
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1, 1);
        }
            break;
        case GradientDirectionFromLeftAndBottom:
        {
            gradientLayer.startPoint = CGPointMake(0, 1);
            gradientLayer.endPoint = CGPointMake(1, 0);
        }
            break;
        default:
        {
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(0, 1);
        }
            break;
    }
    gradientLayer.colors = [NSArray arrayWithObjects:(id)startColor.CGColor, (id)endColor.CGColor, nil];
    return gradientLayer;
}

+ (void)drawDashLine:(UIView *)lineView
          lineLength:(int)lineLength
         lineSpacing:(int)lineSpacing
           lineColor:(UIColor *)lineColor
           direction:(NSInteger)direction {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame) / 2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (direction == 0) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {
        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    if (direction == 0) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL,0, CGRectGetHeight(lineView.frame));
    }
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end
