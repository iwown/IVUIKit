//
//  AlertTool.m
//  ZLYIwown
//
//  Created by CY on 15/10/28.
//  Copyright © 2015年 Iwown. All rights reserved.
//
#import "AlertTool.h"
#define TEXT_ALTER_TAG 10098
#define TEXT_FIELD_TAG 10099

typedef void (^confirm)(void);
typedef void (^cancel)(void);
typedef void (^Action1)(void);
typedef void (^Action2)(void);
typedef void (^Action3)(void);
typedef void (^confirmText)(NSString *);

@interface AlertTool()<UIActionSheetDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    
}
@end



@implementation AlertTool

+ (void)defalutAlertInController:(UIViewController *)controller title:(NSString *)title message:(NSString *)message confirm:(NSString *)confirm  action:(void (^)(void))actionBlock
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:confirm style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        actionBlock();
    }];
    [alertC addAction:alertA];
    [controller presentViewController:alertC animated:YES completion:nil];
}

+ (void)alertInController:(UIViewController *)controller title:(NSString *)title message:(NSString *)message left:(NSString *)confirm  leftAction:(void (^)(void))leftBlock right:(NSString *)cancle  rightAction:(void (^)(void))rightBlock
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:confirm style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        leftBlock();
    }];
    UIAlertAction *alertB = [UIAlertAction actionWithTitle:cancle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        rightBlock();
    }];
    [alertC addAction:alertA];
    [alertC addAction:alertB];
    [controller presentViewController:alertC animated:YES completion:nil];
}


@end
