//
//  IVDialogView.h
//  ZLYIwown
//
//  Created by caike on 16/6/24.
//  Copyright © 2016年 Iwown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IVDialogView : UIView

@property (nonatomic ,strong)UIButton    *leftBtn;
@property (nonatomic ,strong)UIButton    *rightBtn;
@property (nonatomic ,strong)UILabel     *titleL;
@property (nonatomic ,strong)UIView      *topView;

- (void)setLeftClicked:(void (^)(void))leftClick
       andRightClicked:(void (^)(void))rightClick;

@end
