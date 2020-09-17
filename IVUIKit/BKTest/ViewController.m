//
//  ViewController.m
//  BKTest
//
//  Created by CY on 2018/1/16.
//  Copyright © 2018年 c123. All rights reserved.
//
#import "TestViewController.h"
#import "ViewController.h"
#import "IVUIKit.h"

@interface ViewController ()

@property (nonatomic, strong) NavMenu *navbar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self drawNavMenu];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)drawNavMenu {
    __weak typeof(self) weakSelf = self;
    self.navbar = [NavMenu menuWithTitle:NSLocalizedString(@"Aktualizacja oprogramowania", @"Bind S1") textColor:[UIColor blackColor]];

    [self.navbar setLeftItem:@"你好" icon:nil clicked:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        WeekSelectController *weekSelVc = [[WeekSelectController alloc] init];
        weekSelVc.backgroundColor = [UIColor whiteColor];
        weekSelVc.cellColor = [UIColor whiteColor];
        weekSelVc.textColor = [UIColor redColor];
        weekSelVc.separatorColor = [UIColor greenColor];
        weekSelVc.navColorTop = [UIColor colorFromCode:0x186EDC];
        weekSelVc.navColorBottom = [UIColor colorFromCode:0x0E4BBD];
        [strongSelf.navigationController pushViewController:weekSelVc  animated:YES];
    }];
    [self.navbar setRightItem:nil icon:@"share" clicked:^{
        TestViewController *testVC = [[TestViewController alloc] init];
        [weakSelf presentViewController:testVC animated:YES completion:nil];
    }];
    [self.navbar setSubRightItem:nil icon:@"data_feedback" clicked:^{
        
    }];
    self.navbar.rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.navbar];
    
    UITextField *textFD = [[UITextField alloc] init];
    [textFD setFrame:CGRectMake(20, 100, 300, 50)];
    textFD.inputAccessoryView = [KeyboardToolbar keyboardToolbar];
    [self.view addSubview:textFD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
