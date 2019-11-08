//
//  UILabel+FontNumber.h
//  Kawayi
//
//  Created by CY on 2018/2/5.
//  Copyright © 2018年 A$CE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FontNumber)
/*
 ** 将UIlabel中的text的数组和非数字的字体大小改为不一样的；数字是big，非数字是samll;
 * 请注意-->  : 冒号和' 分 ''秒，都会被视为数字，会以大字体显示
 */
- (void)updateLabelStyleWithSmallFont:(NSInteger)samll bigFont:(NSInteger)big;

/*
 ** 将UIlabel中的text的数组和非数字的字体大小改为不一样的；数字是big，非数字是samll;
 * smallFontName == sys 表示为系统字体
 * 请注意-->  : 冒号和' 分 ''秒，都会被视为数字，会以大字体显示
 */
- (void)updateLabelStyleWithSmallFont:(NSInteger)samll bigFont:(NSInteger)big smallFontName:(NSString *)smallFontName bigFontName:(NSString *)bigFontName;

- (void)updateLabelStyleWithSmallFont:(NSInteger)samll bigFont:(NSInteger)big smallFontName:(NSString *)smallFontName bigFontName:(NSString *)bigFontName smallColor:(UIColor *)smallColor bigColor:(UIColor *)bigColor;


@end
