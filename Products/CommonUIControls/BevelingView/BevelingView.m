//
//  BevelingView.m
//  GPS
//
//  Created by CY on 2017/8/14.
//  Copyright © 2017年 CY. All rights reserved.
//

#import "BevelingView.h"

@implementation BevelingView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGSize size = self.frame.size;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    [shapeLayer setFillColor:[[UIColor redColor] CGColor]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, .0f,0.0f);
    CGPathAddLineToPoint(path, NULL, size.width, 0);
    CGPathAddLineToPoint(path, NULL, size.width, size.height);
    CGPathAddLineToPoint(path, NULL, 0.0, size.height - 70);
    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CFRelease(path);
    self.layer.mask = shapeLayer;
}


@end
