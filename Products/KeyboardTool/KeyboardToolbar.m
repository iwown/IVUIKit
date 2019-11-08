//
//  KeyboardToolbar.m
//  Kawayi
//
//  Created by A$CE on 2018/5/21.
//  Copyright © 2018年 A$CE. All rights reserved.
//
#import "UKMacro.h"
#import "UIView+Extension.h"
#import "KeyboardToolbar.h"

@implementation KeyboardToolbar

//初始化
+ (instancetype)keyboardToolbar {
    return [[KeyboardToolbar alloc] initWithFrame:CGRectMake(0, 0, BK_SCREEN_WIDTH, FONT(50))];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self removeAllSubviews];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
    [[btn titleLabel] setFont:[UIFont boldSystemFontOfSize:FONT(17)]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(barButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(BK_SCREEN_WIDTH - FONT(60), 0, FONT(50), FONT(50));
    [self addSubview:btn];
    
    UILabel *textField = [[UILabel alloc] initWithFrame:CGRectMake(20, FONT(5), BK_SCREEN_WIDTH - 100, FONT(40))];
    [self addSubview:textField];
}

- (void)barButtonItemClick:(UIButton *)btn {
    //默认确定
    BTN_TYPE btnType = BTN_TYPE_DONE;
    //如果没有实现代理
    if ([self.keyboardDelegate respondsToSelector:@selector(keyboardToolbar:btnClickType:)]) {
        
        if (btn.tag == 100) {
            //如果点击的tag为100的"取消"
            btnType = BTN_TYPE_CANCEL;
        }
        //实现代理方法
        [self.keyboardDelegate keyboardToolbar:self btnClickType:btnType];
    }
}

@end
