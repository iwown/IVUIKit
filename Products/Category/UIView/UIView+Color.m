//
//  UIView+Color.m
//  YCGPSFramework
//
//  Created by CY on 2018/2/7.
//  Copyright © 2018年 c123. All rights reserved.
//

#import "UIView+Color.h"

#define YCGPS_WIDTH_SCALE     ([UIScreen mainScreen].bounds.size.width/375.0)
#define YCGPS_HEIGHT_SCALE    ([UIScreen mainScreen].bounds.size.height/667.0)
#define iPhone5Screen ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@implementation UIView (Color)

- (void)jianbianColor:(UIColor *)topC andEndColor:(UIColor *)bottomC {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    if (iPhone5Screen) {
        gradientLayer.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y, self.frame.size.width, self.frame.size.height);

    }else {
    gradientLayer.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y, self.frame.size.width*YCGPS_WIDTH_SCALE, self.frame.size.height*YCGPS_HEIGHT_SCALE);
    }
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)topC.CGColor, (id)bottomC.CGColor, nil];
    if ([self.layer.sublayers[0] isKindOfClass:[CAGradientLayer class]]) {
        [self.layer.sublayers[0] removeFromSuperlayer];
    }
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

@end
