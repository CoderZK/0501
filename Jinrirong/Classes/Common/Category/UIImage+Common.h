//
//  UIImage+Common.h
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-4.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "SDWebImageManager.h"
#import "SDWebImageManager.h"

@interface UIImage (Common)

+(UIImage *)imageWithColor:(UIColor *)aColor;
+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius;
- (UIImage *) imageWithMinimumSize:(CGSize)size;
+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;
-(UIImage*)scaledToSize:(CGSize)targetSize;
-(UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;
-(UIImage*)scaledToMaxSize:(CGSize )size;
+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset;
+ (UIImage *)fullScreenImageALAsset:(ALAsset *)asset;

+ (UIImage *)imageWithFileType:(NSString *)fileType;

+ (UIImage *)imageWithSDWebImageURLString:(NSString *)urlString;

- (UIImage *)rotatedByDegrees:(CGFloat)degrees;
- (UIImage *)fixOrientation:(UIImage *)aImage;

+ (UIImage *)createQRCodeImage:(NSString *)url Width:(CGFloat)width;
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;

/**
 传入需要的占位图尺寸 获取占位图
 */
+ (UIImage *)placeholderImageWithSize:(CGSize)size;
@end
