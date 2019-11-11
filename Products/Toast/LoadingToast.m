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
static NSMutableArray *__cacheArr = nil;

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

+ (void)timeoutWithBlock:(TimeoutBlock)block second:(double)second {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LoadingToast hideToastActivity];
        block();
    });
}

/**通过__cacheArr机制管理超时问题
 超时问题： 程序多个地方交叉调用timeout方法，上一个方法的超时返回会导致本次Loading。比如说在程序A处调用timeout=30，此时line为0，
          在10s后程序A主动结束了Loading，在25s的位置程序B也调用timeout=20；但是在程序B的5秒后，也就是整个line30s的位置，程序A
          的timeout会被调用，会提前结束程序B处开启的Loading，引起程序B处的显示问题
 __cacheArr机制：0. 创建全局数组__cacheArr，因为Loading的UI操作程序猿会保证它在主线程执行，否则苹果会报warning，
                    一般程序员不会这么刚，所以这里忽略多线程问题
                1. 利用unix时间戳和delay值做唯一id，因为UI操作少有并行，所以秒级的唯一id应该问题不大，复杂id会增加计算量，比如说hash
                2. 清空__cacheArr，然后将唯一id加入__cacheArr，并加唯一id加入方法的参数
                3. 在timeout被fired的时候，检查__cacheArr的是否为空，不为空的时候判读__cacheArr的第一个值和方法参数是否相等。
                    判断有效时执行hiden，否则轮空返回，不执行具体操作
 附带Block的方法内部不处理
 */
+ (void)launchTimerNow:(NSTimeInterval)interval {
    if (!__cacheArr) {
        __cacheArr = [[NSMutableArray alloc] initWithCapacity:2];
    }
    [__cacheArr removeAllObjects];
    
    long long dateValue = (long long)([[NSDate date] timeIntervalSince1970] * 1000 + interval);
    [self performSelector:@selector(timeout:) withObject:@(dateValue) afterDelay:interval];
    [__cacheArr addObject:@(dateValue)];
}

+ (void)timeout:(id)obj {
    long long dateValue = [obj longLongValue];
    if (__cacheArr.count == 0 ||
        [__cacheArr.firstObject longLongValue] != dateValue) {
        //该事件已失效，不再处理
        return;
    }
    [__cacheArr removeObjectAtIndex:0];
    [self hideToastActivity];
}

+ (void)hideToastActivity {
    LOTAnimationView *existingGifView = (LOTAnimationView *)objc_getAssociatedObject(self, &IVLoadingGifViewKey);
    [existingGifView stop];
}

@end

