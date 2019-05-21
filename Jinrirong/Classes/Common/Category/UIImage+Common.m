//
//  UIImage+Common.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-4.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (Common)
+(UIImage *)imageWithColor:(UIColor *)aColor{
    return [UIImage imageWithColor:aColor withFrame:CGRectMake(0, 0, 1, 1)];
}
static CGFloat edgeSizeFromCornerRadius(CGFloat cornerRadius) {
    return cornerRadius * 2 + 1;
}
- (UIImage *) imageWithMinimumSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0.0f);
    [self drawInRect:rect];
    UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
    return [resized resizableImageWithCapInsets:UIEdgeInsetsMake(size.height/2, size.width/2, size.height/2, size.width/2)];
}
+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius {
    CGFloat minEdgeSize = edgeSizeFromCornerRadius(cornerRadius);
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame{
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aFrame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
static inline CGFloat DegreesToRadians(CGFloat degrees)
{
    return M_PI * (degrees / 180.0);
}

- (UIImage *)rotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    //    UIGraphicsBeginImageContext(rotatedSize);
    UIGraphicsBeginImageContextWithOptions(rotatedSize, NO, [UIScreen mainScreen].scale);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
    
}

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
//        MYLog(@"could not scale image");
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

+ (UIImage *)imageWithFileType:(NSString *)fileType{
    fileType = [fileType lowercaseString];
    NSString *iconName;
    //XXX(s)
    if ([fileType hasPrefix:@"doc"]) {
        iconName = @"icon_file_doc";
    }else if ([fileType hasPrefix:@"ppt"]) {
        iconName = @"icon_file_ppt";
    }else if ([fileType hasPrefix:@"pdf"]) {
        iconName = @"icon_file_pdf";
    }else if ([fileType hasPrefix:@"xls"]) {
        iconName = @"icon_file_xls";
    }
    //XXX
    else if ([fileType isEqualToString:@"txt"]) {
        iconName = @"icon_file_txt";
    }else if ([fileType isEqualToString:@"ai"]) {
        iconName = @"icon_file_ai";
    }else if ([fileType isEqualToString:@"apk"]) {
        iconName = @"icon_file_apk";
    }else if ([fileType isEqualToString:@"md"]) {
        iconName = @"icon_file_md";
    }else if ([fileType isEqualToString:@"psd"]) {
        iconName = @"icon_file_psd";
    }
    //XXX||YYY
    else if ([fileType isEqualToString:@"zip"] || [fileType isEqualToString:@"rar"] || [fileType isEqualToString:@"arj"]) {
        iconName = @"icon_file_zip";
    }else if ([fileType isEqualToString:@"html"]
              || [fileType isEqualToString:@"xml"]
              || [fileType isEqualToString:@"java"]
              || [fileType isEqualToString:@"h"]
              || [fileType isEqualToString:@"m"]
              || [fileType isEqualToString:@"cpp"]
              || [fileType isEqualToString:@"json"]
              || [fileType isEqualToString:@"cs"]
              || [fileType isEqualToString:@"go"]) {
        iconName = @"icon_file_code";
    }else if ([fileType isEqualToString:@"avi"]
              || [fileType isEqualToString:@"rmvb"]
              || [fileType isEqualToString:@"rm"]
              || [fileType isEqualToString:@"asf"]
              || [fileType isEqualToString:@"divx"]
              || [fileType isEqualToString:@"mpeg"]
              || [fileType isEqualToString:@"mpe"]
              || [fileType isEqualToString:@"wmv"]
              || [fileType isEqualToString:@"mp4"]
              || [fileType isEqualToString:@"mkv"]
              || [fileType isEqualToString:@"vob"]) {
        iconName = @"icon_file_movie";
    }else if ([fileType isEqualToString:@"mp3"]
              || [fileType isEqualToString:@"wav"]
              || [fileType isEqualToString:@"mid"]
              || [fileType isEqualToString:@"asf"]
              || [fileType isEqualToString:@"mpg"]
              || [fileType isEqualToString:@"tti"]) {
        iconName = @"icon_file_music";
    }
    //unknown
    else{
        iconName = @"icon_file_unknown";
    }
    return [UIImage imageNamed:iconName];
}

+ (UIImage *)imageWithSDWebImageURLString:(NSString *)urlString{
    __block NSData *imageData = nil;
    [[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:urlString] completion:^(BOOL isInCache) {
        if (isInCache) {
            NSString *cacheImageKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:urlString]];
            if (cacheImageKey.length) {
                NSString *cacheImagePath = [[SDImageCache sharedImageCache] defaultCachePathForKey:cacheImageKey];
                if (cacheImagePath.length) {
                    imageData = [NSData dataWithContentsOfFile:cacheImagePath];
                }
                if (!imageData) {
                    imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                }
               
            }
        }
    }];
    return [UIImage imageWithData:imageData];
//    BOOL isExit = [[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:urlString]];
//    if (isExit) {
//        NSString *cacheImageKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:urlString]];
//        if (cacheImageKey.length) {
//            NSString *cacheImagePath = [[SDImageCache sharedImageCache] defaultCachePathForKey:cacheImageKey];
//            if (cacheImagePath.length) {
//                imageData = [NSData dataWithContentsOfFile:cacheImagePath];
//            }
//        }
//    }
//    if (!imageData) {
//        imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
//    }
//    return [UIImage imageWithData:imageData];
}


- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage *)createQRCodeImage:(NSString *)url Width:(CGFloat)width;
{
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认
    [filter setDefaults];
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSString *dataString = url;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4.获取输出的二维码
    CIImage *outputImage = [filter outputImage];
    return [UIImage createNonInterpolatedUIImageFormCIImage:outputImage withSize:width];
}
/**
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 * @param size 图片宽度
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

/**
 传入需要的占位图尺寸 获取占位图
 
 @param size 需要的站位图尺寸
 @return 占位图
 */
+ (UIImage *)placeholderImageWithSize:(CGSize)size {
    
    // 占位图的背景色
    UIColor *backgroundColor = RGB(238, 238, 238);
    // 中间LOGO图片
    UIImage *image = [UIImage imageNamed:@"placeholdimage"];
    // 根据占位图需要的尺寸 计算 中间LOGO的宽高
    CGFloat logoWH = (size.width > size.height ? size.height : size.width) * 0.5;
    CGSize logoSize = CGSizeMake(logoWH, logoWH);
    // 打开上下文
    UIGraphicsBeginImageContextWithOptions(size,0, [UIScreen mainScreen].scale);
    // 绘图
    [backgroundColor set];
    UIRectFill(CGRectMake(0,0, size.width, size.height));
    CGFloat imageX = (size.width / 2) - (logoSize.width / 2);
    CGFloat imageY = (size.height / 2) - (logoSize.height / 2);
    [image drawInRect:CGRectMake(imageX, imageY, logoSize.width, logoSize.height)];
    UIImage *resImage =UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return resImage;
    
}


@end
