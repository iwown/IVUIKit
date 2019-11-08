//
//  WeekSelectController.m
//  ZLYIwown
//
//  Created by caike on 15/12/16.
//  Copyright © 2015年 Iwown. All rights reserved.
//

#define BK_WEEKDAY_ARR_FROM_MON @[NSLocalizedString(@"MON",@"一"), NSLocalizedString(@"TUE",@"二"), NSLocalizedString(@"WED",@"三"), NSLocalizedString(@"THU",@"四"), NSLocalizedString(@"FRI",@"五"), NSLocalizedString(@"SAT",@"六"),NSLocalizedString(@"SUN",@"日")]

#import "NavMenu.h"
#import "UKMacro.h"
#import "UIView+IVStyle.h"
#import <Masonry/Masonry.h>
#import "WeekSelectController.h"

@interface WeekSelectController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_selectArr;
    NSMutableArray *_weekSelects;
    NSArray *_titleArr;
}
@end

@implementation WeekSelectController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (UIColor *)cellColor {
    
    if (!_cellColor) {
        _cellColor = [KitManager bgColorD];
    }
    return _cellColor;
}

- (UIColor *)separatorColor {
    if (!_separatorColor) {
        _separatorColor = [KitManager lineColorS];
    }
    return _separatorColor;
}

- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = [KitManager textColorM];
    }
    return _textColor;
}

- (void)initData {
   
    _titleArr = @[NSLocalizedString(@"Everyday", nil),
                  NSLocalizedString(@"Weekdays", nil),
                  NSLocalizedString(@"Weekend", nil)];
    _selectArr = [NSMutableArray arrayWithCapacity:8];
    _weekSelects = [[NSMutableArray alloc] initWithCapacity:3];
    [self updateSelectArr];
    [self updateWeekSelects];
}

- (void)updateWeekSelects {
    
    [_weekSelects removeAllObjects];
    [_weekSelects addObjectsFromArray:@[@0,@0,@0]];
    if (self.week_repeat == 0xFF) {
        _weekSelects[0] = @1;
    }else if (self.week_repeat == 0xFC) {
        _weekSelects[1] = @1;
    }else if (self.week_repeat == 0x83) {
        _weekSelects[2] = @1;
    }
}

- (void)updateSelectArr {
    
    [_selectArr removeAllObjects];
    NSInteger week_repeat = self.week_repeat;
    Byte a = week_repeat;
    for (int i = 0; i < 8; i++) {
        NSInteger c = (NSInteger)((a >> (7-i)) & 0x1);
        [_selectArr addObject:[NSNumber numberWithInteger:c]];
    }
}

- (void)updateWeekRepeatByWeekSelects {
    
    NSInteger week_repeat = 0;
    if ([_weekSelects[0] boolValue]) {
        week_repeat = 0xFF;
    }else if ([_weekSelects[1] boolValue]){
        week_repeat = 0xFC;
    }else if ([_weekSelects[2] boolValue]){
        week_repeat = 0x83;
    }else {
        return;
    }
    self.week_repeat = week_repeat;
}

- (void)updateWeekRepeatBySelectArr {
    
    NSInteger week_repeat = 0;
    for (int i = 1; i <_selectArr.count; i++) {
        NSInteger a = [_selectArr[i] integerValue] << (7-i);
        week_repeat += a;
    }
    week_repeat += 128;
    self.week_repeat = week_repeat;
}

- (void)initUI {
    
    [super initUI];
    [self drawNavMenu];
    [self drawTableView];
}

- (void)drawNavMenu {
    
    __weak typeof(self) weakself = self;
    NavMenu *menu = [NavMenu menuWithTitle:NSLocalizedString(@"Everyday", nil)];
    [menu setLeftItem:nil icon:@"back" clicked:^{
        [weakself leftButtonAction];
    }];
    [menu setRightItem:nil icon:@"tick_menu" clicked:^{
        [weakself rightButtonAction];
    }];
    NSLog(@"navColorTop === >>>> %@ : %@",self.navColorTop,self.navColorBottom);
    [menu.backgroundView gradientColor:self.navColorTop andEndColor:self.navColorBottom];
    [self.view addSubview:menu];
}

- (void)drawTableView {
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, BK_SCREEN_WIDTH,  BK_SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = self.separatorColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return 7;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        UIImageView *ig = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tick"]];
        [cell addSubview:ig];
        cell.backgroundColor = self.cellColor;
        [ig mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell);
            make.size.mas_equalTo(CGSizeMake(FONT(18), FONT(14)));
            make.right.equalTo(cell).with.offset(-10);
        }];
        ig.tag = 1000;
    }
    cell.textLabel.textColor = self.textColor;
    UIImageView *ig = [cell viewWithTag:1000];
    if (indexPath.section == 0) {
        cell.textLabel.text = _titleArr[indexPath.row];
        ig.hidden = ![_weekSelects[indexPath.row] boolValue];
    }else if (indexPath.section == 1) {
        cell.textLabel.text = BK_WEEKDAY_ARR_FROM_MON[indexPath.row];
        ig.hidden = ![_selectArr[indexPath.row+1] boolValue];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView *ig = [cell viewWithTag:1000];
    if (indexPath.section == 0) {
        BOOL value = [_weekSelects[indexPath.row] boolValue];
        if (value) {
            return;
        }
        [_weekSelects removeAllObjects];
        [_weekSelects addObjectsFromArray:@[@0,@0,@0]];
        _weekSelects[indexPath.row] = @(!value);
        [self updateWeekRepeatByWeekSelects];
        [self updateSelectArr];
    }else if (indexPath.section == 1){
        if (ig.hidden) {
            ig.hidden = NO;
        }else {
            ig.hidden = YES;
        }
        [_selectArr replaceObjectAtIndex:(indexPath.row+1) withObject:[NSNumber numberWithBool:!ig.hidden]];
        [self updateWeekRepeatBySelectArr];
        [self updateWeekSelects];
    }
    [_tableView reloadData];
}

- (void)leftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonAction {
    
    NSInteger week_repeat = self.week_repeat;
    if (week_repeat == 128) {
        NSString *message = NSLocalizedString(@"Message", nil);
        NSString *pleaseSelectAtLeastOne = NSLocalizedString(@"Please select at least one", nil);
        NSString *ok = NSLocalizedString(@"OK", nil);

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:pleaseSelectAtLeastOne preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:ok style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self  presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if (self.weekSelectBlock) {
        self.weekSelectBlock(week_repeat);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
