//
//  GradientView.h
//  TT
//
//  Created by 曹凯 on 16/5/25.
//  Copyright © 2016年 leopard. All rights reserved.
//
typedef enum{
    GradientDirectionFromTop = 0,
    GradientDirectionFromLeft ,
    GradientDirectionFromLeftAndTop ,
    GradientDirectionFromLeftAndBottom
}GradientDirection;
#import <UIKit/UIKit.h>

@interface GradientView : UIView
+ (UIImageView *)gradientImageView:(CGRect)frame
                     andStartColor:(UIColor *)color
                       andEndColor:(UIColor *)eColor;

+ (CAGradientLayer *)createGradientLayerWithFrame:(CGRect)frame
                                GradientDirection:(GradientDirection)direction
                                       StartColor:(UIColor *)startColor
                                         EndColor:(UIColor *)endColor;

+ (void)drawDashLine:(UIView *)lineView
          lineLength:(int)lineLength
         lineSpacing:(int)lineSpacing
           lineColor:(UIColor *)lineColor
           direction:(NSInteger)direction;

@end
