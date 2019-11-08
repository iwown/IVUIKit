//
//  UIImage+Util.m
//  iosapp
//
//  Created by ChanAetern on 2/13/15.
//  Copyright (c) 2015 oschina. All rights reserved.
//

#import "UIImage+Util.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (Util)
- (UIImage *)imageMaskedWithColor:(UIColor *)maskColor
{
    NSParameterAssert(maskColor != nil);
    
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextScaleCTM(context, 1.0f, -1.0f);
        CGContextTranslateCTM(context, 0.0f, -(imageRect.size.height));
        
        CGContextClipToMask(context, imageRect, self.CGImage);
        CGContextSetFillColorWithColor(context, maskColor.CGColor);
        CGContextFillRect(context, imageRect);
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)cropToRect:(CGRect)rect {
    CGImageRef imageRef   = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return croppedImage;
}

- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor {
    //image must be nonzero size
    
    if (floorf(self.size.width) * floorf(self.size.height) <= 0.0f) return self;
    
    //boxsize must be an odd integer
    
    uint32_t boxSize = (uint32_t)(radius * self.scale);
    
    if (boxSize % 2 == 0) boxSize ++;
    
    //create image buffers
    
    CGImageRef imageRef = self.CGImage;
    
    vImage_Buffer buffer1, buffer2;
    
    buffer1.width = buffer2.width = CGImageGetWidth(imageRef);
    
    buffer1.height = buffer2.height = CGImageGetHeight(imageRef);
    
    buffer1.rowBytes = buffer2.rowBytes = CGImageGetBytesPerRow(imageRef);
    
    size_t bytes = buffer1.rowBytes * buffer1.height;
    
    buffer1.data = malloc(bytes);
    
    buffer2.data = malloc(bytes);
    
    //create temp buffer
    
    void *tempBuffer = malloc((size_t)vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, NULL, 0, 0, boxSize, boxSize,
                                                                 
                                                                 NULL, kvImageEdgeExtend + kvImageGetTempBufferSize));
    
    //copy image data
    CFDataRef dataSource = CGDataProviderCopyData(CGImageGetDataProvider(imageRef));
    memcpy(buffer1.data, CFDataGetBytePtr(dataSource), bytes);
    CFRelease(dataSource);
    
    for (NSUInteger i = 0; i < iterations; i++) {
        
        //perform blur
        vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, tempBuffer, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        
        //swap buffers
        
        void *temp = buffer1.data;
        buffer1.data = buffer2.data;
        buffer2.data = temp;
    }
    
    //free buffers
    free(buffer2.data);
    free(tempBuffer);
    
    //create image context from buffer
    CGContextRef ctx = CGBitmapContextCreate(buffer1.data, buffer1.width, buffer1.height,
                                             
                                             8, buffer1.rowBytes, CGImageGetColorSpace(imageRef),
                                             
                                             CGImageGetBitmapInfo(imageRef));
    
    //apply tint
    
    if (tintColor && CGColorGetAlpha(tintColor.CGColor) > 0.0f){
        CGContextSetFillColorWithColor(ctx, [tintColor colorWithAlphaComponent:0.25].CGColor);
        CGContextSetBlendMode(ctx, kCGBlendModePlusLighter);
        CGContextFillRect(ctx, CGRectMake(0, 0, buffer1.width, buffer1.height));
    }
    
    //create image from context
    
    imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    CGContextRelease(ctx);
    free(buffer1.data);
    return image;
}

+ (UIImage *)imageWithNameNotCache:(NSString *)imageName {
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    return [UIImage imageWithContentsOfFile:path];
}

+ (UIImage *)imageScale:(UIImage *)sourceImage
                  toSize:(CGSize)dsize {
    UIGraphicsBeginImageContextWithOptions(dsize, YES, 1.0);
    [sourceImage drawInRect:CGRectMake(0, 0, dsize.width, dsize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

+ (UIImage *)createImage:(UIImage *)srcImage WithText:(NSString *)text {
    
    UIImage *sourceImage = srcImage;
    CGSize imageSize; //画的背景 大小
    imageSize = [sourceImage size];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    //获得 图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextDrawPath(context, kCGPathStroke);
    CGFloat nameFont = 14.0f;
    //画 自己想要画的内容
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:nameFont]};
    CGRect sizeToFit = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, nameFont) options:NSStringDrawingUsesDeviceMetrics attributes:attributes context:nil];
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    [text drawAtPoint:CGPointMake((imageSize.width-sizeToFit.size.width)/2,(imageSize.height-sizeToFit.size.height)/2) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //返回绘制的新图形
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}


#pragma mark- Screen shot

+ (UIImage *)screenShotWithView:(UIView *)view {
    UIImage* image = nil;
    CGSize size = view.frame.size;
    /*
     *UIGraphicsBeginImageContextWithOptions有三个参数
     *size    bitmap上下文的大小，就是生成图片的size
     *opaque  是否不透明，当指定为YES的时候图片的质量会比较好
     *scale   缩放比例，指定为0.0表示使用手机主屏幕的缩放比例
     */
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    //此处我截取的是TableView的header.
    [view.layer renderInContext: UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    if (image != nil) {
        return image;
    }else {
        return nil;
    }
}


+ (UIImage *)screenShotWithScrollView:(UIScrollView *)scrollView {
    UIImage* image = nil;
    CGSize size = scrollView.contentSize;
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    
    //保存collectionView当前的偏移量
    CGPoint savedContentOffset = scrollView.contentOffset;
    CGRect saveFrame = scrollView.frame;
    //将collectionView的偏移量设置为(0,0)
    scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
    scrollView.contentOffset = CGPointZero;
    //在当前上下文中渲染出collectionView
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [scrollView.layer renderInContext:ctx];
    //截取当前上下文生成Image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    //恢复collectionView的偏移量
    scrollView.contentOffset = savedContentOffset;
    scrollView.frame = saveFrame;
    
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }else {
        return nil;
    }
}

+ (UIImage *)addSlaveImage:(UIImage *)slaveImage toMasterImage:(UIImage *)masterImage {
    CGSize size;
    size.width = masterImage.size.width;
    size.height = masterImage.size.height + slaveImage.size.height;
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    
    //Draw masterImage
    [masterImage drawInRect:CGRectMake(0, 0, masterImage.size.width, masterImage.size.height)];
    
    //Draw slaveImage
    [slaveImage drawInRect:CGRectMake(0, masterImage.size.height, masterImage.size.width, slaveImage.size.height)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return resultImage;
}

#pragma mark- gif image
+ (UIImage *)gifImageNamed:(NSString *)name {
    return [UIImage getGitImageFromBundle:[NSBundle mainBundle] andFileName:name];
}

+ (UIImage *)getGitImageFromBundle:(NSBundle *)bundle
                       andFileName:(NSString *)name {
    if (bundle == nil) {
        bundle = [NSBundle mainBundle];
    }
    NSString *filePath = [[NSBundle bundleWithPath:[bundle bundlePath]] pathForResource:name ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (!data){
        return nil;
    }
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    UIImage *animatedImage;
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }else {
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval duration = 3.0f;
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if (!image){
                continue;
            }
            duration += [UIImage frameDurationAtIndex:i source:source];
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            CGImageRelease(image);
        }
        if (!duration){
            duration = (1.0f / 10.0f) * count;
        }
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    CFRelease(source);
    return animatedImage;
}

+ (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }else {
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    CFRelease(cfFrameProperties);
    return frameDuration;
}

@end
