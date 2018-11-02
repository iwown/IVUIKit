//
//  KeyboardToolbar.h
//  Kawayi
//
//  Created by A$CE on 2018/5/21.
//  Copyright © 2018年 A$CE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyboardToolbar;

/** 输入类型 */
typedef enum{
    /** 确定输入 */
    BTN_TYPE_DONE = 0,
    /** 取消输入 */
    BTN_TYPE_CANCEL,
}BTN_TYPE;

/** 协议 */
@protocol KeyboardToolBarDelegate <NSObject>

@optional
//可选代理方法
-(void)keyboardToolbar:(KeyboardToolbar *)toolbar btnClickType:(BTN_TYPE)btnType;

@end


@interface KeyboardToolbar : UIView

/** 工厂方法初始化Toolbar 从xib*/
+(instancetype)keyboardToolbar;

/** 代理方法 */
@property (nonatomic, weak) id<KeyboardToolBarDelegate> keyboardDelegate;


@end
