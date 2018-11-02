//
//  IVBaseViewController.h
//  ZeronerHealthPro
//
//  Created by CY on 2017/4/24.
//  Copyright © 2017年 iwown. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface IVBaseViewController : UIViewController

@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic ,strong) UIColor *backgroundColor;

@property (nonatomic ,strong) UIColor *navColorTop;
@property (nonatomic ,strong) UIColor *navColorBottom;

/*注册观察者*/
- (void)addObserver;
/*初始化参数*/
- (void)initData;
/*UI入口*/
- (void)initUI;
/*@property (nonatomic ,strong) UIView *bgView;*/
- (void)drawBgView;
/*SubView布局适配*/
- (void)setViewLayouts;
/*简易NavigationBar*/
- (void)drawNavMenu;
/*简易tableView*/
- (void)drawTableView;

/*设置渐变背景色*/
- (void)setBgColorChange;
/**! Default is UIStatusBarStyleLightContent*/
- (void)setStatusBarStyle:(UIStatusBarStyle)sbStyle;
- (void)setHiddenStatusBar:(BOOL)hidden;

@end
