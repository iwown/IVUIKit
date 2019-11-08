//
//  UIImage+Util.h
//  linyi
//
//  Created by caike on 16/12/21.
//  Copyright © 2016年 com.kunekt.healthy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)
+ (UIImage *)imageWithNameNotCache:(NSString *)imageName;

- (UIImage *)imageMaskedWithColor:(UIColor *)maskColor;
- (UIImage *)cropToRect:(CGRect)rect;
- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;

+ (UIImage *)imageScale:(UIImage *)sourceImage
                 toSize:(CGSize)dsize;

+ (UIImage *)createImage:(UIImage *)srcImage WithText:(NSString *)text;

#pragma mark- Screen shot
+ (UIImage *)screenShotWithView:(UIView *)view ;
+ (UIImage *)screenShotWithScrollView:(UIScrollView *)scrollView ;
+ (UIImage *)addSlaveImage:(UIImage *)slaveImage toMasterImage:(UIImage *)masterImage ;

#pragma mark- gif image
+ (UIImage *)gifImageNamed:(NSString *)name;
+ (UIImage *)getGitImageFromBundle:(NSBundle *)bundle
                       andFileName:(NSString *)name;
@end
