//
//  CustomWebViewController.m
//  Kawayi
//
//  Created by scow on 2018/2/23.
//  Copyright © 2018年 A$CE. All rights reserved.
//
#import "UKMacro.h"
#import "CustomWebViewController.h"

@interface CustomWebViewController () <WKNavigationDelegate>

@property(nonatomic,strong)UIActivityIndicatorView *indicatorView;

@end

@implementation CustomWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dealloc{
    
}

- (void)initUI {
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, BK_NavigationBarHeight, BK_SCREEN_WIDTH, BK_SCREEN_HEIGHT-BK_NavigationBarHeight)];
    self.webView.navigationDelegate = self;
    NSURL *url = [NSURL URLWithString:_remoteUrl];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:self.webView];
    self.webView.backgroundColor = [UIColor whiteColor];
    
    self.indicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.indicatorView.center = self.view.center;
    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
}

#pragma mark Action
- (void) returnBtnClicked:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

//开始加载网页
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.indicatorView stopAnimating];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"network error occur when load web page");
}

@end
