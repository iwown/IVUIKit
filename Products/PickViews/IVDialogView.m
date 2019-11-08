//
//  IVDialogView.m
//  ZLYIwown
//
//  Created by caike on 16/6/24.
//  Copyright © 2016年 Iwown. All rights reserved.
//
#import "UIColor+Util.h"
#import <Masonry/Masonry.h>
#import "IVDialogView.h"

@interface IVDialogView ()

@property (nonatomic,copy)void (^leftClick)(void);
@property (nonatomic,copy)void (^rightClick)(void);

@end
@implementation IVDialogView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
        [self setupLayouts];
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setupSubviews {
    
    self.topView = [UIView new];
    [self addSubview:self.topView];
    self.topView.backgroundColor =  [UIColor colorFromCode:0x2ec990 inAlpha:1];
    
    self.leftBtn = [UIButton new];
    [self addSubview:self.leftBtn];
    
    self.rightBtn = [UIButton new];
    [self addSubview:self.rightBtn];
    
    self.titleL = [UILabel new];
    [self addSubview:self.titleL];
    self.titleL.textAlignment = NSTextAlignmentCenter;
    self.titleL.textColor = [UIColor whiteColor];
    
    [self.leftBtn setTitle:NSLocalizedString(@"Cancel", @"取消") forState:UIControlStateNormal];
    [self.rightBtn setTitle:NSLocalizedString(@"Save", @"确定") forState:UIControlStateNormal];
    
    [self.leftBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupLayouts {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.height.equalTo(self.topView);
        make.width.equalTo(self.mas_width).multipliedBy(0.2);
        make.top.equalTo(self);
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftBtn.mas_right);
        make.height.equalTo(self.topView);
        make.width.equalTo(self.mas_width).multipliedBy(0.6);
        make.top.equalTo(self);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.height.equalTo(self.topView);
        make.width.equalTo(self.mas_width).multipliedBy(0.2);
        make.top.equalTo(self);
    }];
}

- (void)leftAction:(UIButton *)button {
    if (self.leftClick) {
        self.leftClick();
    }
}

- (void)rightAction:(UIButton *)button {
    if (self.rightClick) {
        self.rightClick();
    }
}

- (void)setLeftClicked:(void (^)(void))leftClick
       andRightClicked:(void (^)(void))rightClick {
    self.leftClick = leftClick;
    self.rightClick = rightClick;
}


@end
