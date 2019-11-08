//
//  UILabel+NumberOfLine.m
//  ZeronerHealthPro
//
//  Created by CY on 2017/6/26.
//  Copyright © 2017年 iwown. All rights reserved.
//
#import "UKMacro.h"
#import "UILabel+NumberOfLine.h"

@implementation UILabel (NumberOfLine)
- (CGFloat)numberOfText{
    // 获取单行时候的内容的size
    CGSize singleSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    // 获取多行时候,文字的size
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(BK_SCREEN_WIDTH*0.8, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    // 返回计算的行数
    return textSize.height*1.0 / singleSize.height*1.0;
}
@end
