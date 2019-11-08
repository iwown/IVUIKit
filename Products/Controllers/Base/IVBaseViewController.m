//
//  IVBaseViewController.m
//  ZeronerHealthPro
//
//  Created by CY on 2017/4/24.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import "UIColor+Util.h"
#import "UKMacro.h"
#import "IVBaseViewController.h"

@interface IVBaseViewController ()

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation IVBaseViewController
static bool _hiddenStatusBar = false;
static int _sbStatusBarStyle = 1;//UIStatusBarStyleLightContent

+ (void)setGlobalStatusBarStyle:(UIStatusBarStyle)sbStyle {
    _sbStatusBarStyle = (int)sbStyle;
}

+ (void)setGlobalHiddenStatusBar:(BOOL)hidden {
    _hiddenStatusBar = hidden;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObserver];
    [self initData];
    [self initUI];
    [self setViewLayouts];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)addObserver {}

- (void)initData {}

- (void)initUI {
    self.view.backgroundColor = self.backgroundColor;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)drawNavMenu {}

- (void)drawBgView {
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BK_SCREEN_WIDTH, BK_SCREEN_HEIGHT)];
    self.bgView.backgroundColor = self.backgroundColor;
    [self.view addSubview:self.bgView];
}

- (void)drawTableView {}

- (void)setViewLayouts {}

- (void)setBgColorChange {
    //实现背景渐变
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.view.layer addSublayer:gradientLayer];
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)[UIColor colorFromCode:0x050405].CGColor,
                             (__bridge id)[UIColor colorFromCode:0x0F2C6D].CGColor];
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.2f),@(1.0f)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Color
- (UIColor *)backgroundColor {
    if (!_backgroundColor) {
        _backgroundColor = [KitManager bgColorD];
    }
    return _backgroundColor;
}

- (UIColor *)navColorTop {
    if (!_navColorTop) {
        _navColorTop = [KitManager bgColorNL];
    }
    return _navColorTop;
}

- (UIColor *)navColorBottom {
    if (!_navColorBottom) {
        _navColorBottom = [KitManager bgColorND];
    }
    return _navColorBottom;
}

- (BOOL)prefersStatusBarHidden {
    return _hiddenStatusBar;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return (UIStatusBarStyle)_sbStatusBarStyle;
}

- (void)setStatusBarStyle:(UIStatusBarStyle)sbStyle {
    _sbStatusBarStyle = (int)sbStyle;
}

- (void)setHiddenStatusBar:(BOOL)showing {
    _hiddenStatusBar = showing;
    [self setNeedsStatusBarAppearanceUpdate];
}

// 支持设备自动旋转
- (BOOL)shouldAutorotate {
    return YES;
}

// 支持竖屏显示
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
