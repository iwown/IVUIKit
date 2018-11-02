//
//  IVPickerView.h
//  ZLYIwown
//
//  Created by caike on 16/8/15.
//  Copyright © 2016年 Iwown. All rights reserved.
//

#define H_M_PICKER1          10011
#define H_M_PICKER2          10012
#define HOUR_PICKER1         10001
#define HOUR_PICKER2         10002

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,PickerViewType) {
    PickerTypeCount = 1,
    PickerTypeHour = 2,                     
    PickerTypeTimeMin = 3,
    PickerTypeDate = 4,
    PickerTypeH_M = 5,
    PickerTypeWeightUnit,
};

@protocol IVPickerDelegate <NSObject>

- (NSString *)textForRow:(NSInteger)row forComponent:(NSInteger)component;

@end

@interface IVPickerView : UIView

@property (nonatomic,assign)id<IVPickerDelegate> delegate;

@property (nonatomic,strong)UIView          *topView;
@property (nonatomic,strong)UILabel         *titleL;
@property (nonatomic,strong)UIButton        *leftBtn;
@property (nonatomic,strong)UIButton        *rightBtn;

- (instancetype)initWithFrame:(CGRect)frame andType:(PickerViewType)type;

+ (instancetype)countPickerStart:(NSInteger)start end:(NSInteger)end selectIndex:(NSInteger)select;

+ (instancetype)countPickerStart:(NSInteger)start end:(NSInteger)end selectIndex:(NSInteger)select step:(NSInteger)step;

+ (instancetype)timePickerLeft:(NSInteger)left right:(NSInteger)right;

+ (instancetype)datePickerWithDate:(NSDate *)date;

+ (instancetype)timeMinPicker;

+ (instancetype)timePickerHour:(NSInteger)hour andMinute:(NSInteger)minute;

+ (instancetype)pickerWithDataSource:(NSArray *)dataSource selectIndex:(NSInteger)select;

- (void)setCenterTitle:(NSString *)title;
- (void)setLeftClicked:(void (^)(void))leftClick
       andRightClicked:(void (^)(NSInteger count1,NSInteger count2,NSDate *date))rightClick;

- (void)show;
- (void)hide;

@end
