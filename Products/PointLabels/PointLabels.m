//
//  PointLabels.m
//  TestLabel
//
//  Created by A$CE on 2018/3/21.
//  Copyright © 2018年 A$CE. All rights reserved.
//
#import "PointLabels.h"

@implementation PointLabels

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)layoutSubviews {
    
    CGFloat width = self.bounds.size.width;
    
    NSArray *arr = _texts;
    UIFont *font = (_font == nil)?[UIFont systemFontOfSize:16]:_font;
    UIColor *textColor = (_textColor == nil)?[UIColor lightGrayColor]:_textColor;
    UIColor *pointColor = (_pointColor == nil)?textColor:_pointColor;
   
    CGFloat topH = 5;
    for (int i = 0; i < arr.count; i ++) {
        UILabel *labelA = [[UILabel alloc] initWithFrame:CGRectMake(5, topH, 20, 20)];
        labelA.textAlignment = NSTextAlignmentCenter;
        labelA.text = @"•";
        labelA.font = font;
        labelA.textColor = pointColor;
        [self addSubview:labelA];
        [labelA sizeToFit];
        
        UILabel *labelAA = [[UILabel alloc] initWithFrame:CGRectMake(25, topH, width-30, 100)];
        labelAA.textAlignment = NSTextAlignmentLeft;
        labelAA.numberOfLines = 0;
        labelAA.font = font;
        labelAA.text = arr[i];
        labelAA.textColor = textColor;
        [self addSubview:labelAA];
        [labelAA sizeToFit];
        
        topH += (labelAA.bounds.size.height+5);
    }
}
@end
