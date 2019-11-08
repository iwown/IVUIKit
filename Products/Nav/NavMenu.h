//
//  NavMenu.h
//  linyi
//
//  Created by caike on 16/12/19.
//  Copyright © 2016年 com.kunekt.healthy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MenuItemClickBock)(void);

@class MenuItem;

@interface NavMenu : UIView

@property(nonatomic,strong)UIView *backgroundView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)MenuItem *leftButton;
@property(nonatomic,strong)MenuItem *leftSecondButton;
@property(nonatomic,strong)MenuItem *rightButton;
@property(nonatomic,strong)CALayer *line;
@property(nonatomic,strong)MenuItem *subLeftButton;

@property (nonatomic,assign)BOOL showLine;
@property (nonatomic,strong)UIColor *iconColor;

+ (instancetype)menuWithTitle:(NSString *)title;

+ (instancetype)menuWithTitle:(NSString *)title textColor:(UIColor*)color;

- (void)setLeftItem:(NSString *)title icon:(NSString *)icon clicked:(MenuItemClickBock)block;
- (void)setLeftSecondItem:(NSString *)title icon:(NSString *)icon clicked:(MenuItemClickBock)block;
- (void)setRightItem:(NSString *)title icon:(NSString *)icon clicked:(MenuItemClickBock)block;

- (void)setGraduallyBGColor:(UIColor *)start andEndColor:(UIColor *)end;

- (void)setSubLeftItem:(NSString *)title icon:(NSString *)icon clicked:(MenuItemClickBock)block;

@end


@interface MenuItem : UIButton

@property (nonatomic,assign)UIControlContentHorizontalAlignment alignment;

@end
