//
//  UIControl+CWAdd.h
//  ZeronerHealthPro
//
//  Created by ChenWu on 2017/5/11.
//  Copyright © 2017年 iwown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (CWAdd)
- (void)addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id sender))block;
@end
