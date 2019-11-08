//
//  LoadingToast.m
//  Kawayi
//
//  Created by A$CE on 2018/4/13.
//  Copyright © 2018年 A$CE. All rights reserved.
//
#import <objc/runtime.h>
#import <Lottie/Lottie.h>
#import "LoadingToast.h"
#import "UIColor+Util.h"

static NSString *IVLoadingGifViewKey = @"IVLoadingGifView";
static dispatch_source_t __loadingTimer;

@implementation LoadingToast

+ (void)makeToastActivity {
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *loadView = [[UIView alloc] initWithFrame:window.bounds];
    loadView.backgroundColor = [UIColor colorWithHex:0x333333 alpha:0.3];
    [window addSubview:loadView];

    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[LoadingToast class]] pathForResource:@"IVUIKit" ofType:@"bundle"]];
    LOTAnimationView *gifView = [LOTAnimationView animationNamed:@"loading/data_load" inBundle:bundle]; //[LOTAnimationView animationNamed:@"data_load"];
    gifView.frame = CGRectMake(0, 0, 60, 20);
    gifView.center = loadView.center;
    [loadView addSubview:gifView];
    [gifView playWithCompletion:^(BOOL animationFinished) {
        [gifView removeFromSuperview];
        [loadView removeFromSuperview];
    }];
    [gifView setLoopAnimation:YES];
    [self performSelector:@selector(timeout) withObject:nil afterDelay:10];
    
    objc_setAssociatedObject (self, &IVLoadingGifViewKey, gifView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)makeToastActivityNoTimeOut {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *loadView = [[UIView alloc] initWithFrame:window.bounds];
    loadView.backgroundColor = [UIColor colorWithHex:0x333333 alpha:0.3];
    [window addSubview:loadView];
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[LoadingToast class]] pathForResource:@"IVUIKit" ofType:@"bundle"]];
    LOTAnimationView *gifView = [LOTAnimationView animationNamed:@"loading/data_load" inBundle:bundle]; //[LOTAnimationView animationNamed:@"data_load"];
    gifView.frame = CGRectMake(0, 0, 60, 20);
    gifView.center = loadView.center;
    [loadView addSubview:gifView];
    [gifView playWithCompletion:^(BOOL animationFinished) {
        [gifView removeFromSuperview];
        [loadView removeFromSuperview];
    }];
    [gifView setLoopAnimation:YES];
    objc_setAssociatedObject (self, &IVLoadingGifViewKey, gifView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (void)makeToastActivityWithTimeOut:(double)second{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *loadView = [[UIView alloc] initWithFrame:window.bounds];
    loadView.backgroundColor = [UIColor colorWithHex:0x333333 alpha:0.3];
    [window addSubview:loadView];
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[LoadingToast class]] pathForResource:@"IVUIKit" ofType:@"bundle"]];
    LOTAnimationView *gifView = [LOTAnimationView animationNamed:@"loading/data_load" inBundle:bundle]; //[LOTAnimationView animationNamed:@"data_load"];
    gifView.frame = CGRectMake(0, 0, 60, 20);
    gifView.center = loadView.center;
    [loadView addSubview:gifView];
    [gifView playWithCompletion:^(BOOL animationFinished) {
        [gifView removeFromSuperview];
        [loadView removeFromSuperview];
    }];
    [gifView setLoopAnimation:YES];
    [self launchTimerNow:second];
    
    objc_setAssociatedObject (self, &IVLoadingGifViewKey, gifView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)makeToastActivityWithTimeOut:(double)second block:(TimeoutBlock)block {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *loadView = [[UIView alloc] initWithFrame:window.bounds];
    loadView.backgroundColor = [UIColor colorWithHex:0x333333 alpha:0.3];
    [window addSubview:loadView];
    
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[LoadingToast class]] pathForResource:@"IVUIKit" ofType:@"bundle"]];
    LOTAnimationView *gifView = [LOTAnimationView animationNamed:@"loading/data_load" inBundle:bundle]; //[LOTAnimationView animationNamed:@"data_load"];
    gifView.frame = CGRectMake(0, 0, 60, 20);
    gifView.center = loadView.center;
    [loadView addSubview:gifView];
    [gifView playWithCompletion:^(BOOL animationFinished) {
        [gifView removeFromSuperview];
        [loadView removeFromSuperview];
    }];
    [gifView setLoopAnimation:YES];
    if (block) {
        [self timeoutWithBlock:block second:second];
    }else {
        [self launchTimerNow:second];
    }
    
    objc_setAssociatedObject (self, &IVLoadingGifViewKey, gifView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)timeoutWithBlock:(TimeoutBlock)block second:(double)second{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LoadingToast timeout];
        block();
    });
}


+ (void)launchTimerNow:(NSTimeInterval)interval {
    [self cancelTimer];
    __block int stateIndex = 0;
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __loadingTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(__loadingTimer,dispatch_walltime(NULL, 0),interval*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(__loadingTimer, ^{
        stateIndex ++;
        if (stateIndex > 1) {
            [weakSelf cancelTimer];
            stateIndex = 0;
        }
    });
    dispatch_resume(__loadingTimer);
}

+ (void)cancelTimer {
    if (__loadingTimer) {
        dispatch_source_cancel(__loadingTimer);
        __loadingTimer = nil;
    }
}

+ (void)timeout {
    [self hideToastActivity];
}

+ (void)hideToastActivity {
    [self cancelTimer];
    NSLog(@"%s : %@",__func__,[NSThread callStackSymbols]);
    LOTAnimationView *existingGifView = (LOTAnimationView *)objc_getAssociatedObject(self, &IVLoadingGifViewKey);
    [existingGifView stop];
}
@end
