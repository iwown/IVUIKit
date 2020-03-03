//
//  CustomWebViewController.h
//  Kawayi
//
//  Created by scow on 2018/2/23.
//  Copyright © 2018年 A$CE. All rights reserved.
//

#import "IVBaseViewController.h"
#import <WebKit/WebKit.h>

@interface CustomWebViewController : IVBaseViewController

@property(nonatomic,copy)NSString *navTitle;
@property(nonatomic,copy)NSString *remoteUrl;
@property(nonatomic,strong)WKWebView *webView;

@end
