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
+ (void)makeToastActivity;
+ (void)hideToastActivity;
+ (void)makeToastActivityWithTimeOut:(double)second;
+ (void)makeToastActivityWithTimeOut:(double)second block:(TimeoutBlock)block;
+ (void)makeToastActivityNoTimeOut;
@end
