//
//  LoadingToast.h
//  Kawayi
//
//  Created by A$CE on 2018/4/13.
//  Copyright © 2018年 A$CE. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TimeoutBlock)(void);

@interface LoadingToast : UIView

/**Equal makeToastActivityWithTimeOut:10*/
+ (void)makeToastActivity;
/** TimeOut 内部实现一套机制以避免多处调用的问题，但是带Block的方法内部不处理*/
+ (void)makeToastActivityWithTimeOut:(double)second;
+ (void)makeToastActivityWithTimeOut:(double)second block:(TimeoutBlock)block;
+ (void)makeToastActivityNoTimeOut;

+ (void)hideToastActivity;

@end
