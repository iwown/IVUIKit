//
//  PageControl.m
//  linyi
//
//  Created by caike on 16/12/26.
//  Copyright © 2016年 com.kunekt.healthy. All rights reserved.
//

#import "PageControl.h"
#import <Masonry/Masonry.h>



@interface PageControl ()
{
    NSInteger _index;
    NSMutableArray *arr;
}
@end
@implementation PageControl

#define DIOT_MARGIN 14
#define DIOT_SIZE  7
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    arr = [NSMutableArray array];
    
    if (_pageNumbers == 0) {
        return;
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initView];
    }
    return self;
}

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    [self initView];
//
//}


- (void)setPageNumbers:(NSInteger)pageNumbers
{
    _pageNumbers = pageNumbers;
    [self drawDiots];
}


- (void)drawDiots
{
    for (CALayer *d in arr) {
        [d removeFromSuperlayer];
    }
    [arr removeAllObjects];

    CGFloat originX = self.frame.size.width*[UIScreen mainScreen].bounds.size.width/375.0/2 - (_pageNumbers-1)*DIOT_MARGIN/2 - _pageNumbers*DIOT_SIZE/2;
    if (!([UIScreen mainScreen].bounds.size.width>320)) {
        originX = self.frame.size.width/2 - (_pageNumbers-1)*DIOT_MARGIN/2 - _pageNumbers*DIOT_SIZE/2;
    }
    for (int i = 0; i < _pageNumbers; i ++) {
        CALayer *layer = [self diotLayer];
        layer.frame = CGRectMake(originX+i*(DIOT_SIZE+DIOT_MARGIN), (self.frame.size.height - DIOT_SIZE)/2, DIOT_SIZE, DIOT_SIZE);
        [self.layer addSublayer:layer];
        [arr addObject:layer];
    }
}


- (void)setPageIndex:(NSInteger)index
{
    _index = index;
    for (CALayer *l in arr) {
        if (l.frame.size.width == DIOT_SIZE*2) {
            l.frame = CGRectMake(l.frame.origin.x + DIOT_SIZE/2, l.frame.origin.y, DIOT_SIZE , DIOT_SIZE);
        }
    }
    CALayer *layer = arr[index];
    layer.frame = CGRectMake(layer.frame.origin.x-DIOT_SIZE/2, layer.frame.origin.y, DIOT_SIZE*2, DIOT_SIZE);
}


- (CALayer *)diotLayer
{
    CALayer *layer = [[CALayer alloc]init];
    layer.cornerRadius = DIOT_SIZE/2;
    if (self.dotColor) {
        layer.backgroundColor = self.dotColor.CGColor;

    }else {
        layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0].CGColor;
    }
    return layer;
}

- (void)setDotColor:(UIColor *)dotColor {
    _dotColor = dotColor;
    if (dotColor) {
        [self drawDiots];
    }
}

@end
