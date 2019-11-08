//
//  UITableViewCell+Separator.m
//  Kawayi
//
//  Created by A$CE on 2018/4/30.
//  Copyright © 2018年 A$CE. All rights reserved.
//
#import "UKMacro.h"
#import "KitManager.h"
#import <Masonry/Masonry.h>
#import "UIColor+Util.h"
#import "UITableViewCell+Separator.h"

static int line_tag = 27163;
@implementation UITableViewCell (Separator)

- (void)addselectColorBy:(UIColor *)sColor {
    
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = sColor;
}

- (void)addselectBg {
    [self addselectColorBy:[UIColor colorFromCode:0x0A183B]];
}

- (void)addSeparatorLine:(UIColor *)color byLeftGap:(CGFloat)leftGap {
    
    UIView *line  = [[UIView alloc] init];
    line.backgroundColor = color;
    line.tag = line_tag;
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(BK_SCREEN_WIDTH - leftGap, 1));
        make.left.equalTo(self).offset(leftGap);
    }];
}

- (void)addSeparatorLineByLeftGap:(CGFloat)leftGap {
    [self addSeparatorLine:[KitManager lineColorS] byLeftGap:leftGap];
}

- (void)addSeparatorLine {
    [self addSeparatorLineByLeftGap:15];
}

- (UIView *)separatorLine {
    return [self viewWithTag:line_tag];
}

@end
