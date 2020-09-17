//
//  NavMenu.m
//  linyi
//
//  Created by caike on 16/12/19.
//  Copyright © 2016年 com.kunekt.healthy. All rights reserved.
//
#import "GradientView.h"
#import "NavMenu.h"
#import "UKMacro.h"
#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif
#import "UIColor+Util.h"

#define menuHeight  30.0
#define YC_SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define YC_SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height

@interface NavMenu ()
@property(nonatomic,copy)MenuItemClickBock leftClicked;
@property(nonatomic,copy)MenuItemClickBock rightClicked;
@property(nonatomic,copy)MenuItemClickBock subLeftClicked;
@property(nonatomic,copy)MenuItemClickBock middleClicked;
@property(nonatomic,copy)MenuItemClickBock subRightClicked;

@property(nonatomic,strong)UIColor  *textColor;
@end

@implementation NavMenu

+ (instancetype)menuWithTitle:(NSString *)title textColor:(UIColor *)color {
    return [[NavMenu alloc]initWithTitle:title textColor:color];
}

+ (instancetype)menuWithTitle:(NSString *)title {
    return [[NavMenu alloc]initWithTitle:title textColor:[UIColor whiteColor]];
}

- (instancetype)initWithTitle:(NSString *)title textColor:(UIColor *)color {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, YC_SCREEN_WIDTH, BK_NavigationBarHeight);
        self.textColor = color;
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.text = title;
        self.titleLabel.textColor = color;
        if (@available(iOS 8.2, *)) {
            self.titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
        } else {
            self.titleLabel.font = [UIFont systemFontOfSize:17];
        }
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 0;
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.mas_equalTo(YC_SCREEN_WIDTH * 0.6);
            make.top.mas_lessThanOrEqualTo(BK_NavigationBarHeight - menuHeight-4);
            make.bottom.equalTo(self);
        }];
        
        self.line = [[CALayer alloc]init];
        [self.line setFrame:CGRectMake(0, BK_NavigationBarHeight-0.3, YC_SCREEN_WIDTH, 0.3)];
        
        self.line.backgroundColor = [UIColor colorWithHex:0x0E4BBD].CGColor;
        self.backgroundView = [[UIView alloc]initWithFrame:self.frame];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        [self.backgroundView.layer addSublayer:self.line];
        [self addSubview:self.backgroundView];
        
        [self sendSubviewToBack:self.backgroundView];
    }
    return self;
}

- (void)setLeftItem:(NSString *)title icon:(NSString *)icon clicked:(MenuItemClickBock)block {
    
    self.leftButton = [self setButton:title img:icon];
    self.leftButton.alignment = UIControlContentHorizontalAlignmentLeft;
    self.leftClicked = block;
    [self.leftButton setFrame:CGRectMake(0, BK_NavigationBarHeight - menuHeight-4, YC_SCREEN_WIDTH*0.2, menuHeight + 4)];
    [self.leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftButton];
}

- (void)setLeftSecondItem:(NSString *)title icon:(NSString *)icon clicked:(MenuItemClickBock)block {
    
    self.leftSecondButton = [self setButton:title img:icon];
    self.leftSecondButton.alignment = UIControlContentHorizontalAlignmentLeft;
    self.middleClicked = block;
    [self.leftSecondButton setFrame:CGRectMake(YC_SCREEN_WIDTH*0.2, BK_NavigationBarHeight - menuHeight-4, YC_SCREEN_WIDTH*0.25, menuHeight + 4)];
    [self.leftSecondButton addTarget:self action:@selector(middleAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftSecondButton];
    [self.leftSecondButton.titleLabel sizeToFit];
}

- (void)setRightItem:(NSString *)title icon:(NSString *)icon clicked:(MenuItemClickBock)block {
 
    self.rightButton = [self setButton:title img:icon];
    self.rightButton.alignment = UIControlContentHorizontalAlignmentRight;
    self.rightClicked = block;
    [self.rightButton setFrame:CGRectMake(YC_SCREEN_WIDTH*0.8, BK_NavigationBarHeight - menuHeight-4, YC_SCREEN_WIDTH*0.2, menuHeight)];
    [self.rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightButton];
}

- (void)setSubLeftItem:(NSString *)title icon:(NSString *)icon clicked:(MenuItemClickBock)block {
    
    self.subLeftButton = [self setButton:title img:icon];
    self.subLeftButton.titleLabel.font = [UIFont systemFontOfSize:20];
    self.subLeftButton.alignment = UIControlContentHorizontalAlignmentLeft;
    self.subLeftClicked = block;
    [self.subLeftButton setFrame:CGRectMake(YC_SCREEN_WIDTH*0.1, BK_NavigationBarHeight - menuHeight-4, YC_SCREEN_WIDTH*0.2, menuHeight)];
    [self.subLeftButton addTarget:self action:@selector(subLeftAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.subLeftButton];
}

- (void)setSubRightItem:(NSString *)title icon:(NSString *)icon clicked:(MenuItemClickBock)block {
    
    self.subRightButton = [self setButton:title img:icon];
    self.subRightButton.titleLabel.font = [UIFont systemFontOfSize:20];
    self.subRightButton.alignment = UIControlContentHorizontalAlignmentRight;
    self.subRightClicked = block;
    [self.subRightButton setFrame:CGRectMake(YC_SCREEN_WIDTH*0.7, BK_NavigationBarHeight - menuHeight-4, YC_SCREEN_WIDTH*0.2, menuHeight)];
    [self.subRightButton addTarget:self action:@selector(subRightAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.subRightButton];
}

- (MenuItem *)setButton:(NSString *)title img:(NSString *)imgName {

    MenuItem *button = [MenuItem buttonWithType:UIButtonTypeCustom];
    if (imgName) {
       
         UIImage *imageNormal = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        if ([UIImage imageNamed:imgName] == nil) {
            NSString *path = [imgName componentsSeparatedByString:@"/"].firstObject;
            NSString *image_Name = [imgName componentsSeparatedByString:@"/"].lastObject;
            NSBundle *bundle = [NSBundle bundleWithPath:path];
            imageNormal = [[UIImage imageNamed:image_Name inBundle:bundle  compatibleWithTraitCollection:nil]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

        }
        [button setImage:imageNormal forState:UIControlStateNormal];
        button.tintColor = self.iconColor ? self.iconColor : self.textColor;
    }
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:self.textColor forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:0 alpha:0.6] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    return button;
}

- (void)leftAction {
    if (self.leftClicked) {
        self.leftClicked();
    }
}

- (void)rightAction {
    if (self.rightClicked) {
        self.rightClicked();
    }
}

- (void)subLeftAction {
    if (self.subLeftClicked) {
        self.subLeftClicked();
    }
}

- (void)subRightAction {
    if (self.subRightClicked) {
        self.subRightClicked();
    }
}

- (void)setShowLine:(BOOL)showLine {
    self.line.hidden = !showLine;
}


- (void)setIconColor:(UIColor *)iconColor {
    if (_iconColor == iconColor) {
        return;
    }
    _iconColor = iconColor;
    if (self.leftButton) {
        self.leftButton.tintColor = self.iconColor ? self.iconColor : self.textColor;
    }
    if (self.rightButton) {
        self.rightButton.tintColor = self.iconColor ? self.iconColor : self.textColor;
    }
}

- (void)middleAction {
    if (self.middleClicked) {
        self.middleClicked();
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.backgroundView.backgroundColor = backgroundColor;
}

- (void)setGraduallyBGColor:(UIColor *)start andEndColor:(UIColor *)end {
    CAGradientLayer *gradientLayer  = [GradientView createGradientLayerWithFrame:self.bounds GradientDirection:GradientDirectionFromTop StartColor:start EndColor:end];
    [self.backgroundView.layer addSublayer:gradientLayer];
}

@end

@implementation MenuItem

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect iframe = self.imageView.frame;
    CGRect tframe = self.titleLabel.frame;
    
    if (self.alignment == UIControlContentHorizontalAlignmentLeft) {
        [self.imageView setCenter:CGPointMake(10+iframe.size.width/2, self.imageView.center.y)];
        [self.titleLabel setCenter:CGPointMake(CGRectGetMaxX(self.imageView.frame)+tframe.size.width/2, self.titleLabel.center.y)];
    }
    else if (self.alignment == UIControlContentHorizontalAlignmentRight){
        [self.titleLabel setCenter:CGPointMake(self.frame.size.width - 10 - tframe.size.width/2, self.titleLabel.center.y)];
        [self.imageView setCenter:CGPointMake(CGRectGetMinX(self.titleLabel.frame)-iframe.size.width/2, self.imageView.center.y)];
    }
}

@end

