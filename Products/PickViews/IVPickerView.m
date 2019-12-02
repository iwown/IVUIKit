//
//  IVPickerView.m
//  ZLYIwown
//
//  Created by caike on 16/8/15.
//  Copyright © 2016年 Iwown. All rights reserved.
//
#import "UKMacro.h"
#import "UIColor+Util.h"
#import <Masonry/Masonry.h>
#import "IVPickerView.h"

@interface IVPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UIPickerView *countPicker;
@property (nonatomic,strong)UIDatePicker *datePicker;

@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,assign)NSInteger end;
@property (nonatomic,assign)NSInteger step;

@property (nonatomic,strong)NSArray *dataSource;

@property (nonatomic,assign)PickerViewType type;

@property (nonatomic,copy)void (^leftClick)(void);
@property (nonatomic,copy)void (^rightClick)(NSInteger count,NSInteger count2, NSDate *date);

@property (nonatomic ,strong) UIColor *antitheticColor;

@end


@implementation IVPickerView

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    [self setCountTextColor:[backgroundColor antitheticColor]];
}

- (void)setCountTextColor:(UIColor *)color {
    _antitheticColor = color;
    if (self.countPicker) {
        [self.countPicker reloadAllComponents];
    }
}

+ (instancetype)countPickerStart:(NSInteger)start
                             end:(NSInteger)end
                     selectIndex:(NSInteger)select {
    return [self countPickerStart:start end:end selectIndex:select step:1];
}

+ (instancetype)countPickerStart:(NSInteger)start
                             end:(NSInteger)end
                     selectIndex:(NSInteger)select
                            step:(NSInteger)step {
    IVPickerView *countPicker = [[IVPickerView alloc]initWithFrame:CGRectMake(0, 0, BK_SCREEN_WIDTH, BK_SCREEN_HEIGHT*0.4) andType:PickerTypeCount];
    countPicker.start = start;
    countPicker.end = end;
    countPicker.selectIndex = select;
    countPicker.step = step;
    return countPicker;
}

+ (instancetype)timePickerLeft:(NSInteger)left
                         right:(NSInteger)right {
    IVPickerView *timePicker = [[IVPickerView alloc]initWithFrame:CGRectMake(0, 0, BK_SCREEN_WIDTH, BK_SCREEN_HEIGHT*0.4) andType:PickerTypeHour];
    UIPickerView *start = [timePicker viewWithTag:HOUR_PICKER1];
    UIPickerView *end = [timePicker viewWithTag:HOUR_PICKER2];
    [start selectRow:left inComponent:0 animated:NO];
    [end selectRow:right inComponent:0 animated:NO];
    return timePicker;
}

+ (instancetype)timeMinPicker {
    IVPickerView *countPicker = [[IVPickerView alloc]initWithFrame:CGRectMake(0, 0, BK_SCREEN_WIDTH, BK_SCREEN_HEIGHT*0.4) andType:PickerTypeCount];
    return countPicker;
}

+ (instancetype)timePickerHour:(NSInteger)hour
                     andMinute:(NSInteger)minute {
    IVPickerView *timePicker = [[IVPickerView alloc]initWithFrame:CGRectMake(0, 0, BK_SCREEN_WIDTH, BK_SCREEN_HEIGHT*0.4) andType:PickerTypeH_M];
    UIPickerView *start = [timePicker viewWithTag:H_M_PICKER1];
    UIPickerView *end = [timePicker viewWithTag:H_M_PICKER2];
    [start selectRow:hour inComponent:0 animated:NO];
    [end selectRow:minute inComponent:0 animated:NO];
    return timePicker;
}

+ (instancetype)datePickerWithDate:(NSDate *)date {
    IVPickerView *picker = [[IVPickerView alloc]initWithFrame:CGRectMake(0, 0, BK_SCREEN_WIDTH, BK_SCREEN_HEIGHT*0.4) andType:PickerTypeDate];
    if (!date) {
        NSDateFormatter *formate = [[NSDateFormatter alloc] init];
        [formate setDateFormat:@"yyyy-MM-dd"];
        date = [formate dateFromString:@"1990-01-01"];
    }
    [picker.datePicker setDate:date];
    return picker;
}

+ (instancetype)pickerWithDataSource:(NSArray *)dataSource
                         selectIndex:(NSInteger)select {
    IVPickerView *picker = [[IVPickerView alloc] initWithFrame:CGRectMake(0, 0, BK_SCREEN_WIDTH, BK_SCREEN_HEIGHT*0.4) andType:PickerTypeWeightUnit];
    picker.dataSource = dataSource;
    [picker.countPicker selectRow:select inComponent:0 animated:NO];
    return picker;
}

- (instancetype)initWithFrame:(CGRect)frame
                      andType:(PickerViewType)type {
    if (self = [super initWithFrame:frame]) {
        self.type = type;
        self.backgroundColor = [UIColor whiteColor];
        self.step = 1;
        [self setupSubviews];
        [self setupLayouts];
        
        switch (self.type) {
            case PickerTypeCount:
                [self drawCountPicker];
                break;
            case PickerTypeHour:
                [self drawHourPicker];
                break;
            case PickerTypeTimeMin:
                [self drawDatePicker];
                break;
            case PickerTypeDate:
                [self drawDatePicker];
                break;
            case PickerTypeH_M:
                [self drawH_MPicker];
                break;
            case PickerTypeWeightUnit:
                [self drawCountPicker];
                break;
            default:
                break;
        }
        
        [self.layer setCornerRadius:4.0];
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    NSInteger row = (selectIndex - self.start);
    row = row > 0 ? row : 0;
    [self.countPicker selectRow:row inComponent:0 animated:NO];
}

- (void)setupSubviews {
    self.topView = [UIView new];
    [self addSubview:self.topView];
    self.topView.backgroundColor =  [UIColor colorFromCode:0x2ec990 inAlpha:1];
    
    self.leftBtn = [UIButton new];
    [self addSubview:self.leftBtn];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    self.rightBtn = [UIButton new];
    [self addSubview:self.rightBtn];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    self.titleL = [UILabel new];
    [self addSubview:self.titleL];
    self.titleL.textAlignment = NSTextAlignmentCenter;
    self.titleL.font = [UIFont systemFontOfSize:15];
    self.titleL.textColor = [UIColor whiteColor];
    
    [self.leftBtn setTitle:NSLocalizedString(@"Cancel",@"取消") forState:UIControlStateNormal];
    [self.rightBtn setTitle:NSLocalizedString(@"Save", @"确定") forState:UIControlStateNormal];
    
    [self.leftBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupLayouts {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.height.equalTo(self.topView);
        make.width.equalTo(self.mas_width).multipliedBy(0.2);
        make.top.equalTo(self);
    }];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftBtn.mas_right);
        make.height.equalTo(self.topView);
        make.width.equalTo(self.mas_width).multipliedBy(0.6);
        make.top.equalTo(self);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.height.equalTo(self.topView);
        make.width.equalTo(self.mas_width).multipliedBy(0.2);
        make.top.equalTo(self);
    }];
}

- (void)drawCountPicker {
    _antitheticColor = [UIColor blackColor];
    self.countPicker = [UIPickerView new];
    self.countPicker.delegate = self;
    self.countPicker.dataSource = self;
    [self addSubview:self.countPicker];
    [self.countPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.top.equalTo(self.topView.mas_bottom);
        make.bottom.equalTo(self);
    }];
}

- (void)drawHourPicker {
    UIPickerView *pickerView1 = [UIPickerView new];
    pickerView1.delegate = self;
    pickerView1.dataSource = self;
    pickerView1.tag = HOUR_PICKER1;
    [self addSubview:pickerView1];
    
    UIPickerView *pickerView2 = [UIPickerView new];
    pickerView2.delegate = self;
    pickerView2.dataSource = self;
    pickerView2.tag = HOUR_PICKER2;
    [self addSubview:pickerView2];

    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    CALayer *line = [[CALayer alloc]init];
    line.frame = CGRectMake(0.45*w, 0.6*h-1, 0.1*w, 2);
    line.backgroundColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:line];

    [pickerView1 setFrame:CGRectMake(w*0.1, h*0.2, w*0.3, h*0.8)];
    [pickerView2 setFrame:CGRectMake(w*0.6, h*0.2, w*0.3, h*0.8)];
}

- (void)drawH_MPicker {
    UIPickerView *pickerView1 = [UIPickerView new];
    pickerView1.delegate = self;
    pickerView1.dataSource = self;
    pickerView1.tag = H_M_PICKER1;
    [self addSubview:pickerView1];
    
    UIPickerView *pickerView2 = [UIPickerView new];
    pickerView2.delegate = self;
    pickerView2.dataSource = self;
    pickerView2.tag = H_M_PICKER2;
    [self addSubview:pickerView2];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    CALayer *line = [[CALayer alloc]init];
    line.frame = CGRectMake(0.45*w, 0.6*h-1, 0.1*w, 2);
    line.backgroundColor = [UIColor blackColor].CGColor;
    [self.layer addSublayer:line];
    
    [pickerView1 setFrame:CGRectMake(w*0.1, h*0.2, w*0.3, h*0.8)];
    [pickerView2 setFrame:CGRectMake(w*0.6, h*0.2, w*0.3, h*0.8)];
}

- (void)drawDatePicker {
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(w*0.1, h*0.25, w*0.8, h*0.7)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self addSubview:self.datePicker];

    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    
    self.datePicker.minimumDate = [formatter dateFromString:@"19160101"];
    self.datePicker.maximumDate = [formatter dateFromString:@"20201231"];
}

- (void)setLeftClicked:(void (^)(void))leftClick
       andRightClicked:(void (^)(NSInteger count1, NSInteger count2, NSDate *date))rightClick {
    self.leftClick = leftClick;
    self.rightClick = rightClick;
}

- (void)setCenterTitle:(NSString *)title {
    self.titleL.text = title;
}

#pragma mark pickerDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    if (self.type == PickerTypeCount) {
        return (self.end - self.start);
    }else if (self.type == PickerTypeH_M) {
        if (pickerView.tag == H_M_PICKER1) {
            return 24;
        }else{
            return 60;
        }
    } else if (self.type == PickerTypeWeightUnit) {
        return [self.dataSource count];
    }
    if (component == 0) {
        return 24;
    }else {
        return 24;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view {
    if (!view) {
        CGFloat width = pickerView.bounds.size.width;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, FONT(40))];
        label.font = [UIFont systemFontOfSize:FONT(26)];
        label.textColor = _antitheticColor;
        label.textAlignment = NSTextAlignmentCenter;
        if (self.type == PickerTypeHour) {
            label.frame = CGRectMake(0, 0, pickerView.frame.size.width, FONT(40));
            label.text =  [NSString stringWithFormat:@"%02ld:00",(long)row];
        } else if (self.type == PickerTypeWeightUnit) {
            label.text = [NSString stringWithFormat:@"%@", self.dataSource[row]];
        } else {
            label.text = [NSString stringWithFormat:@"%02ld",(long)((row+self.start)*self.step)];
        }
        return label;
    }
    return view;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView
rowHeightForComponent:(NSInteger)component {
    return FONT(45);
}

- (CGFloat)pickerView:(UIPickerView *)pickerView
    widthForComponent:(NSInteger)component {
    return pickerView.frame.size.width;
}

#pragma mark pickerView delegate
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {}

#pragma mark Actions
- (void)leftAction:(UIButton *)button {
    if (self.leftClick) {
        self.leftClick();
    }
    [self hide];
}

- (void)rightAction:(UIButton *)button {
    if (self.rightClick) {
        if (self.type == PickerTypeCount) {
            NSInteger count = [self.countPicker selectedRowInComponent:0]+self.start;
            self.rightClick(count*self.step,0,nil);
        }
        else if (self.type == PickerTypeHour) {
            UIPickerView *picker1 = [self viewWithTag:HOUR_PICKER1];
            UIPickerView *picker2 = [self viewWithTag:HOUR_PICKER2];
            NSInteger hour1 = [picker1 selectedRowInComponent:0];
            NSInteger hour2 = [picker2 selectedRowInComponent:0];
            self.rightClick(hour1,hour2,nil);
        }else if (self.type == PickerTypeH_M){
            UIPickerView *picker1 = [self viewWithTag:H_M_PICKER1];
            UIPickerView *picker2 = [self viewWithTag:H_M_PICKER2];
            NSInteger hour = [picker1 selectedRowInComponent:0];
            NSInteger minute = [picker2 selectedRowInComponent:0];
            self.rightClick(hour,minute,nil);
        }else if (self.type == PickerTypeWeightUnit) {
            NSInteger count = [self.countPicker selectedRowInComponent:0];
            self.rightClick(count,0,nil);
        }else {
            self.rightClick(0,0,self.datePicker.date);
        }
    }
}

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BK_SCREEN_WIDTH, BK_SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [window addSubview:view];
    [view addSubview:self];
    [self setFrame:CGRectMake(0, BK_SCREEN_HEIGHT, self.frame.size.width, self.frame.size.height)];
    
    [UIView animateWithDuration:0.3f animations:^{
        [self setCenter:CGPointMake(self.center.x, self.center.y-self.frame.size.height)];
    } completion:^(BOOL finished) {}];
}

- (void)hide {
    [UIView animateWithDuration:0.3f animations:^{
        [self setCenter:CGPointMake(self.center.x, self.center.y+self.frame.size.height)];
    } completion:^(BOOL finished) {
        self.countPicker.delegate = nil;
        [self.superview removeFromSuperview];
    }];
}

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

@end
