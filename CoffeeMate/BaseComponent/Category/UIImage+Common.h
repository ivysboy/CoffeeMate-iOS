//
//  UIImage+Common.h
//  CoffeeMate
//
//  Created by 徐悟源 on 2017/8/6.
//  Copyright © 2017年 wuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface UIImage (Common)

-(UIImage*)scaledToSize:(CGSize)targetSize;
-(UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;
-(UIImage*)scaledToMaxSize:(CGSize )size;
+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset;
+ (UIImage *)fullScreenImageALAsset:(ALAsset *)asset;
/**
 *  图片压缩到指定大小以内 单位  k  压缩效率很低，图片压缩还是交给服务器比较好
 */
- (UIImage *)scaledToKB:(CGFloat)size;

@end
