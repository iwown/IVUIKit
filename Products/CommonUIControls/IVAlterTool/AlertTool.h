//
//  AlertTool.h
//  ZLYIwown
//
//  Created by CY on 15/10/28.
//  Copyright © 2015年 Iwown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertTool : NSObject


+ (void)defalutAlertInController:(UIViewController *)controller title:(NSString *)title message:(NSString *)message confirm:(NSString *)confirm  action:(void (^)(void))actionBlock;

+ (void)alertInController:(UIViewController *)controller title:(NSString *)title message:(NSString *)message left:(NSString *)confirm  leftAction:(void (^)(void))leftBlock right:(NSString *)cancle  rightAction:(void (^)(void))rightBlock;
@end


