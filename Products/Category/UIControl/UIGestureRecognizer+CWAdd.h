//
//  UIGestureRecognizer+CWAdd.h
//  ZeronerHealthPro
//
//  Created by ChenWu on 2017/5/11.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (CWAdd)

- (instancetype)initWithActionBlock:(void (^)(id sender))block;
- (void)addActionBlock:(void (^)(id sender))block;
@end
