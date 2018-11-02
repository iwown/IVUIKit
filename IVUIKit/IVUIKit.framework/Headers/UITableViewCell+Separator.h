//
//  UITableViewCell+Separator.h
//  Kawayi
//
//  Created by A$CE on 2018/4/30.
//  Copyright © 2018年 A$CE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Separator)

- (void)addselectColorBy:(UIColor *)sColor;
/**! 0x0A183B*/
- (void)addselectBg;

- (void)addSeparatorLine:(UIColor *)color byLeftGap:(CGFloat)leftGap;
- (void)addSeparatorLineByLeftGap:(CGFloat)leftGap;
- (void)addSeparatorLine;

- (UIView *)separatorLine;
@end
