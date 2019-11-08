//
//  CYCircleView.m
//  GPS
//
//  Created by CY on 2017/8/15.
//  Copyright © 2017年 CY. All rights reserved.
//

#import "CYCircleView.h"

@implementation CYCircleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.width/2];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = rect;
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
}


@end
