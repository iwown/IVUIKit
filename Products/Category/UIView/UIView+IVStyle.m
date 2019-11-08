//
//  UIView+IVStyle.m
//  ZLYIwown
//
//  Created by 曹凯 on 16/5/13.
//  Copyright © 2016年 Iwown. All rights reserved.
//

#define MENU_SUBVIEW_TAG_TITLE 981
#import "UKMacro.h"
#import "UIColor+Util.h"
#import "UIView+IVStyle.h"

@implementation UIView (IVStyle)

+ (UIView *)drawMenuBarTitle:(NSString *)title delegate:(UIViewController *)vc leftIcon:(NSString *)lefticon leftText:(NSString *)lefttext leftAction:(SEL)leftAction rightIcon:(NSString *)righticon rightText:(NSString *)righttext rightAction:(SEL)rightAction
{
    return  [self drawMenuBarTitle:title delegate:vc leftIcon:lefticon leftText:lefttext leftAction:leftAction rightIcon:righticon rightText:righttext rightAction:rightAction andBgStyle:IVNavigationBarStyleNone];
}

+ (UIView *)drawMenuBarTitle:(NSString *)title delegate:(UIViewController *)vc leftIcon:(NSString *)lefticon leftText:(NSString *)lefttext leftAction:(SEL)leftAction rightIcon:(NSString *)righticon rightText:(NSString *)righttext rightAction:(SEL)rightAction andBgStyle:(IVNavigationBarStyle)ivStyle {
    
    UIView *menu = nil;
    CGRect menuFrame = CGRectMake(0, 0, BK_SCREEN_WIDTH, BK_NavigationBarHeight);
    switch (ivStyle) {
        case IVNavigationBarStyleNone:
            menu = [[UIView alloc] initWithFrame:menuFrame];
            menu.backgroundColor = [UIColor clearColor];
            break;
        case IVNavigationBarStyleBlueSky:
            menu = [[UIView alloc] initWithFrame:menuFrame];
            menu.backgroundColor = [UIColor colorFromCode:0x4AB5ED inAlpha:1.0];
            break;
        case IVNavigationBarStyleLiveGreen:
            menu = [[UIView alloc] initWithFrame:menuFrame];
            break;
        default:
            break;
    }
    ;
    [[menu layer] setShadowColor:[[UIColor grayColor] CGColor]];
    [[menu layer] setShadowOffset:CGSizeMake(0, 1.5)];
    [menu layer].shadowOpacity = 0.5;//阴影透明度，默认0
    [menu layer].shadowRadius = 1;//阴影半径，默认3
    
    CGFloat menuHeight = 30.0f;
    CGFloat topTap = BK_NavigationBarHeight - menuHeight;
    
    UILabel *menuLabel = [UIView labelWithFrame:CGRectMake(BK_SCREEN_WIDTH*0.15, topTap, BK_SCREEN_WIDTH*0.7, menuHeight) withTitle:title titleFontSize:[UIFont systemFontOfSize:FONT(18)] textColor:[UIColor whiteColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    [menuLabel setTag:MENU_SUBVIEW_TAG_TITLE];
    [menu addSubview:menuLabel];
   
    BOOL isLeftIcon = lefticon ? YES:NO;
    BOOL isLeftText = lefttext ? YES:NO;
    if (isLeftIcon || isLeftText) {
        
        UIImage *imageNormal = nil;
        UIImage *imageDown = nil;
        if (isLeftIcon) {
            imageNormal = [UIImage imageNamed:lefticon];
            if (!imageNormal) {
                imageNormal = [UIImage imageNamed:[lefticon stringByAppendingString:@"_nor"]];
                imageDown = [UIImage imageNamed:[lefticon stringByAppendingString:@"_down"]];
            }
        }
        
        UIButton *leftBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setFrame:CGRectMake(0, menuHeight, BK_SCREEN_WIDTH*0.2, menuHeight)];
        [leftBtn addTarget:vc action:leftAction forControlEvents:UIControlEventTouchUpInside];
        [leftBtn setImage:imageNormal forState:UIControlStateNormal];
        [leftBtn setImage:imageDown forState:UIControlStateSelected];
        [leftBtn setTitle:lefttext forState:UIControlStateNormal];
        [leftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [leftBtn setTag:982];
        [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:FONT(14)]];
        [menu addSubview:leftBtn];
    }
    
    BOOL isRightIcon = righticon ? YES:NO;
    BOOL isRightText = righttext ? YES:NO;
    if (isRightIcon || isRightText) {
        
        UIImage *imageNormal = nil;
        UIImage *imageDown = nil;
        if (isRightIcon) {
            imageNormal = [UIImage imageNamed:righticon];
            if (!imageNormal) {
                imageNormal = [UIImage imageNamed:[righticon stringByAppendingString:@"_nor"]];
                imageDown = [UIImage imageNamed:[righticon stringByAppendingString:@"_down"]];
            }
        }
        
        UIButton *rightBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setFrame:CGRectMake(BK_SCREEN_WIDTH*0.8, menuHeight, BK_SCREEN_WIDTH*0.2, menuHeight)];
        [rightBtn addTarget:vc action:rightAction forControlEvents:UIControlEventTouchUpInside];
        [rightBtn setImage:imageNormal forState:UIControlStateNormal];
        [rightBtn setImage:imageDown forState:UIControlStateSelected];
        [rightBtn setTitle:righttext forState:UIControlStateNormal];
        [rightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [rightBtn setTag:9999];
        [[rightBtn titleLabel] setFont:[UIFont systemFontOfSize:14]];
        [menu addSubview:rightBtn];
    }

    [[vc view] addSubview:menu];
    [[vc view] bringSubviewToFront:menu];
    return menu;
}

- (void)resetMenuTitle:(NSString *)title {
    UILabel *titleLab = [self viewWithTag:MENU_SUBVIEW_TAG_TITLE];
    if (title == nil) {
        return;
    }
    [titleLab setText:title];
}

+ (UILabel *)labelWithFrame:(CGRect)frame withTitle:(NSString *)title titleFontSize:(UIFont *)font textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor alignment:(NSTextAlignment)textAlignment{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.font = font;
    label.textColor = color;
    label.backgroundColor = bgColor;
    label.textAlignment = textAlignment;
    return label;
}

- (void)gradientColor:(UIColor *)topC andEndColor:(UIColor *)bottomC {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)topC.CGColor, (id)bottomC.CGColor, nil];
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)gradientColor:(UIColor *)topC andEndColor:(UIColor *)bottomC frame:(CGRect)frame {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.colors = [NSArray arrayWithObjects:(id)topC.CGColor, (id)bottomC.CGColor, nil];
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

@end
