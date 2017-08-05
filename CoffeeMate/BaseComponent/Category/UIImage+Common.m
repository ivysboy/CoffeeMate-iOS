//
//  UIImage+Common.m
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/6.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)
//对图片尺寸进行压缩--
-(UIImage*)scaledToSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat scaleFactor = 0.0;
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetSize.width / imageSize.width;
        CGFloat heightFactor = targetSize.height / imageSize.height;
        if (widthFactor < heightFactor)
            scaleFactor = heightFactor; // scale to fit height
        else
            scaleFactor = widthFactor; // scale to fit width
    }
    scaleFactor = MIN(scaleFactor, 1.0);
    CGFloat targetWidth = imageSize.width* scaleFactor;
    CGFloat targetHeight = imageSize.height* scaleFactor;
    
    targetSize = CGSizeMake(floorf(targetWidth), floorf(targetHeight));
    UIGraphicsBeginImageContext(targetSize); // this will crop
    [sourceImage drawInRect:CGRectMake(0, 0, ceilf(targetWidth), ceilf(targetHeight))];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"could not scale image");
        newImage = sourceImage;
    }
    UIGraphicsEndImageContext();
    return newImage;
}
-(UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality{
    if (highQuality) {
        targetSize = CGSizeMake(2*targetSize.width, 2*targetSize.height);
    }
    return [self scaledToSize:targetSize];
}

-(UIImage *)scaledToMaxSize:(CGSize)size{
    
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    CGFloat oldWidth = self.size.width;
    CGFloat oldHeight = self.size.height;
    
    CGFloat scaleFactor = (oldWidth > oldHeight) ? width / oldWidth : height / oldHeight;
    
    // 如果不需要缩放
    if (scaleFactor > 1.0) {
        return self;
    }
    
    CGFloat newHeight = oldHeight * scaleFactor;
    CGFloat newWidth = oldWidth * scaleFactor;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset{
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullResolutionImage];
    UIImage *img = [UIImage imageWithCGImage:imgRef scale:assetRep.scale orientation:(UIImageOrientation)assetRep.orientation];
    return img;
}

+ (UIImage *)fullScreenImageALAsset:(ALAsset *)asset{
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullScreenImage];//fullScreenImage已经调整过方向了
    UIImage *img = [UIImage imageWithCGImage:imgRef];
    return img;
}

- (UIImage *)scaledToKB:(CGFloat)size {
    NSData *imgData = UIImageJPEGRepresentation(self, 1.0);
    // 原始图片
    UIImage *result = [UIImage imageWithData:imgData];
    
    while (imgData.length > size) {
        imgData = UIImageJPEGRepresentation(result, 0.5);
        result = [UIImage imageWithData:imgData];
    }
    return result;
}

@end
