//
//  WeekSelectController.h
//  ZLYIwown
//
//  Created by caike on 15/12/16.
//  Copyright © 2015年 Iwown. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WeekSelectForSedentary = 101,
    WeekSelectForSleepMonitor,
    WeekSelectForRemind
} WeekSelectFor; // for week select notify

#import "IVBaseViewController.h"

@interface WeekSelectController : IVBaseViewController

@property (nonatomic ,strong) UIColor *separatorColor;
@property (nonatomic ,strong) UIColor *textColor;
@property (nonatomic ,strong) UIColor *cellColor;

@property (nonatomic,assign)NSInteger week_repeat;

@property (nonatomic, unsafe_unretained)WeekSelectFor type;
@property (nonatomic,copy) void (^weekSelectBlock)(NSInteger week_repeat);

@end
