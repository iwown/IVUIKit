//
//  CYCircleButton.m
//  GPS
//
//  Created by CY on 2017/8/15.
//  Copyright © 2017年 CY. All rights reserved.
//

#import "CYCircleButton.h"

@implementation CYCircleButton

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.width/2];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = rect;
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
}


@end
