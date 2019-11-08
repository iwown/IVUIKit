//
//  UpdateCircle.m
//  ZLingyi
//
//  Created by Jackie on 15/1/15.
//  Copyright (c) 2015年 Jackie. All rights reserved.
//
#import "UIColor+Util.h"
#import "UKMacro.h"
#import "UpdateCircle.h"
@interface UpdateCircle()
{
    CAShapeLayer *layer2;
    UIBezierPath *path;
    UIImageView *_viImage;
    NSMutableArray *_layerArray;
}
@property (nonatomic,strong)NSTimer  *timer;
@property (nonatomic,assign)NSInteger flickerCount;

@end

@implementation UpdateCircle


- (id)initWithFrame:(CGRect)frame baseColor:(UIColor *)bColor coverColor:(UIColor *)cColor withPercent:(CGFloat)per
{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor clearColor];//app.bgColor;
    
    _percent = per;
    _baseColor   = bColor;
    _coverColor = cColor;
    _layerArray = [NSMutableArray arrayWithCapacity:0];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(flickerAnimation) userInfo:nil repeats:YES];

    return self;
}

- (void)setBaseColor:(UIColor *)baseColor
{
    _baseColor = baseColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [self setClearsContextBeforeDrawing: YES];
    
    //remove subviews
    NSArray *views = [self subviews];
    for(UIView* view in views)
    {
        [view removeFromSuperview];
    }
    
    // 贝塞尔曲线(创建一个圆)
    path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(BK_SCREEN_WIDTH*0.5, self.bounds.size.height*0.45)
                                                        radius:FONT(37.0)
                                                    startAngle:M_PI*(-0.5)
                                                      endAngle:M_PI*1.5
                                                     clockwise:YES];
    
    // 创建一个shapeLayer
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame         = self.bounds;                      // 与showView的frame一致
    layer.strokeColor   = [_baseColor CGColor];   // 边缘线的颜色
    layer.fillColor     = [UIColor clearColor].CGColor;     // 闭环填充的颜色
    layer.lineCap       = kCALineCapRound;                  // 边缘线的类型
    layer.path          = path.CGPath;                      // 从贝塞尔曲线获取到形状
    layer.lineWidth     = 1.0f;                            // 线条宽度
    layer.strokeStart   = 0.0f;
    layer.strokeEnd     = 1.0f;
    
    // 贝塞尔曲线(创建一个半径更大的圆)
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(BK_SCREEN_WIDTH*0.5, self.bounds.size.height*0.45)
                                          radius:FONT(37.0+25)
                                      startAngle:M_PI*(-0.5)
                                        endAngle:M_PI*1.5
                                       clockwise:YES];
    
    CAShapeLayer *layer1 = [CAShapeLayer layer];
    layer1.frame         = self.bounds;                     // 与showView的frame一致
    layer1.strokeColor   = [_baseColor CGColor];               // 边缘线的颜色
    layer1.fillColor     = [UIColor clearColor].CGColor;    // 闭环填充的颜色
    layer1.lineCap       = kCALineCapRound;                 // 边缘线的类型
    layer1.path          = path1.CGPath;                     // 从贝塞尔曲线获取到形状
    layer1.lineWidth     = 1.0f;                           // 线条宽度
    layer1.strokeStart   = 0.0f;
    layer1.strokeEnd     = 1.0f;
    
    // 贝塞尔曲线(创建一个半径更大的圆)
    UIBezierPath *path3 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(BK_SCREEN_WIDTH*0.5, self.bounds.size.height*0.45)
                                                         radius:FONT(37.0+50)
                                                     startAngle:M_PI*(-0.5)
                                                       endAngle:M_PI*1.5
                                                      clockwise:YES];
    
    CAShapeLayer *layer3 = [CAShapeLayer layer];
    layer3.frame         = self.bounds;                     // 与showView的frame一致
    layer3.strokeColor   = [_baseColor CGColor];               // 边缘线的颜色
    layer3.fillColor     = [UIColor clearColor].CGColor;    // 闭环填充的颜色
    layer3.lineCap       = kCALineCapRound;                 // 边缘线的类型
    layer3.path          = path3.CGPath;                     // 从贝塞尔曲线获取到形状
    layer3.lineWidth     = 1.0f;                           // 线条宽度
    layer3.strokeStart   = 0.0f;
    layer3.strokeEnd     = 1.0f;
    
    // 将layer添加进图层
    [self.layer addSublayer:layer];
    [self.layer addSublayer:layer1];
    [self.layer addSublayer:layer3];
    
    for (int i = 0; i < 24; i ++) {
        CGFloat radius = FONT(96);
        CGFloat x0 = BK_SCREEN_WIDTH*0.5;
        CGFloat y0 = self.bounds.size.height*0.45;
        CGFloat angel = M_PI *2*(i/24.0);
        CGFloat x = x0 + cosf(M_PI*(-0.5) + angel)*radius;
        CGFloat y = y0 + sinf(M_PI*(-0.5) + angel)*radius;
        UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(x, y)
                                                             radius:FONT(3.5)
                                                         startAngle:M_PI*(-0.5)
                                                           endAngle:M_PI*1.5
                                                          clockwise:YES];
        
        UIColor *fillColor = [UIColor colorFromCode:0xffffff inAlpha:0.5];
        if (i%3==0) {
            fillColor = [UIColor whiteColor];
        }
        CAShapeLayer *layerS = [CAShapeLayer layer];
        layerS.frame         = self.bounds;
        layerS.strokeColor   = [[UIColor clearColor] CGColor];
        layerS.fillColor     = fillColor.CGColor;
        layerS.lineCap       = kCALineCapRound;
        layerS.path          = path1.CGPath;
        layerS.lineWidth     = 1.0f;
        layerS.strokeStart   = 0.0f;
        layerS.strokeEnd     = 1.0f;
        [self.layer addSublayer:layerS];
        [_layerArray addObject:layerS];
    }

    _viImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"upgrade_smile"]];
    _viImage.hidden = YES;
    [self addSubview:_viImage];
//    [self.layer addSublayer:layer2];
}

- (void)setSmileImage:(CGFloat)per {
    
    CGFloat radius = FONT(37.0);
    CGFloat x0 = BK_SCREEN_WIDTH*0.5;
    CGFloat y0 = self.bounds.size.height*0.45;
    CGFloat angel = M_PI *2*per;
    CGFloat x = x0 + cosf(M_PI*(-0.5) + angel)*radius;
    CGFloat y = y0 + sinf(M_PI*(-0.5) + angel)*radius;
    [_viImage setCenter:CGPointMake(x, y)];
    _viImage.hidden = NO;
}

- (void)updateProgress:(CGFloat)per color:(UIColor *)color
{
    _coverColor = color;
    _percent = per;

    if (layer2) {
        [layer2 removeFromSuperlayer];
    }
    layer2 = [CAShapeLayer layer];
    layer2.frame         = self.bounds;                     // 与showView的frame一致
    layer2.strokeColor   = [_coverColor CGColor];              // 边缘线的颜色
    layer2.fillColor     = [UIColor clearColor].CGColor;    // 闭环填充的颜色
    layer2.lineCap       = kCALineCapRound;                 // 边缘线的类型
    layer2.path          = path.CGPath;                     // 从贝塞尔曲线获取到形状
    layer2.lineWidth     = 4.0f;                           // 线条宽度
    layer2.strokeStart   = 0.0f;
    layer2.strokeEnd     = _percent;
    
    [self.layer addSublayer:layer2];
    [self setSmileImage:_percent];
}

- (void)flickerAnimation {
    
    _flickerCount--;
    if (_flickerCount <= 0) {
        _flickerCount = 3000;
    }
    for (int i = 0; i < 24; i ++) {
        UIColor *fillColor = [UIColor colorFromCode:0xffffff inAlpha:0.5];
        if ((i+_flickerCount)%3==0) {
            fillColor = [UIColor whiteColor];
        }
        
        if (_layerArray.count <= i) {
            continue;
        }
        CAShapeLayer *layerS = _layerArray[i];
        [layerS setFillColor:fillColor.CGColor];
    }
}

- (void)startAnimation {
    [self.timer setFireDate:[NSDate date]];
}

- (void)stopAnimation {
    [self.timer setFireDate:[NSDate distantFuture]];
}

@end
