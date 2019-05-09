//
//  CYTabBarControllerConfig.h
//  iWOWNfit
//
//  Created by CY on 2016/12/21.
//  Copyright © 2016年 chenyuan. All rights reserved.
//

FOUNDATION_EXTERN NSString *const CYL_TabBarItemTitle;
FOUNDATION_EXTERN NSString *const CYL_TabBarItemImage;
FOUNDATION_EXTERN NSString *const CYL_TabBarItemSelectedImage;

#import <UIKit/UIKit.h>

@protocol CYTabBarControllerConfigDataSource <NSObject>

@optional
/**! Default is 0x081024<##>*/
- (int)tabbarTintColor;
/**!Default UIImageRenderingModeAutomatic*/
- (UIImageRenderingMode)tabbarItemNormalImageRenderingMode;
- (UIImageRenderingMode)tabbarItemSelectImageRenderingMode;
/**! Default is null, Determined by the iOS system<##>*/
- (int)tabbarTitleSelectColor;
- (int)tabbarTitleUnSelectColor;
@end

@interface CYTabBarControllerConfig : NSObject

@property (nonatomic, readonly, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) NSArray<UIViewController *>* subViewControllers;
/**! See the Key @{CYLTabBarItemTitle:@"",CYLTabBarItemImage:@"",CYLTabBarItemSelectedImage:@""};

 - (NSArray *)tabBarItemsAttributesForController {
 
     NSDictionary *firstTabBarItemsAttributes = @{
     CYLTabBarItemTitle : LocalString(homePage),
     CYLTabBarItemImage : @"data-off.png",
     CYLTabBarItemSelectedImage : @"data-on.png",
     };
     NSDictionary *secondTabBarItemsAttributes = @{
     CYLTabBarItemTitle : LocalString(device),
     CYLTabBarItemImage : @"device-off.png",
     CYLTabBarItemSelectedImage : @"device-on.png",
     };
     NSDictionary *thirdTabBarItemsAttributes = @{
     CYLTabBarItemTitle : LocalString(profile),
     CYLTabBarItemImage : @"profile-off.png",
     CYLTabBarItemSelectedImage : @"profile-on.png",
     };
     NSArray *tabBarItemsAttributes = @[
     firstTabBarItemsAttributes,
     secondTabBarItemsAttributes,
     thirdTabBarItemsAttributes,
     ];
     return tabBarItemsAttributes;
 }
 */
@property (nonatomic, strong) NSArray<NSDictionary *>* subVCItemsAttributes;

@property (nonatomic, weak) id<CYTabBarControllerConfigDataSource> dataSource;

- (void)selectedTabBarIndex:(NSInteger)index;

@end
