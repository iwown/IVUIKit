//
//  PageControl.h
//  linyi
//
//  Created by caike on 16/12/26.
//  Copyright © 2016年 com.kunekt.healthy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageControl : UIView
@property (nonatomic,assign)NSInteger   index;
@property (nonatomic,assign)NSInteger   pageNumbers;
@property (nonatomic,strong)UIColor     *dotColor;

- (void)setPageIndex:(NSInteger)index;
@end
