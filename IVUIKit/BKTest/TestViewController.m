//
//  TestViewController.m
//  BKTest
//
//  Created by A$CE on 2018/9/7.
//  Copyright © 2018年 c123. All rights reserved.
//

#import "TestViewController.h"
#import "IVUIKit.h"

@interface TestViewController ()
@property (nonatomic ,strong) LandScapePicker *lsPicker;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self drawlsPicker];
    // Do any additional setup after loading the view.
}

- (void)drawlsPicker {
    self.lsPicker = [[LandScapePicker alloc] initWithFrame:CGRectMake(0, 200 - 50, 375, 50)];
    self.lsPicker.backgroundColor = [UIColor clearColor];
    self.lsPicker.titleColor = [UIColor whiteColor];
    self.lsPicker.pTitles = @[@"123",@"456"];
    [self.lsPicker selectRow:0];
    [self.view addSubview:self.lsPicker];
    
    self.lsPicker.lspSelected = ^(NSInteger row, NSString *title) {
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.lsPicker.pTitles = @[@"123"];
    [self.lsPicker reload];
    [self.lsPicker selectRow:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
