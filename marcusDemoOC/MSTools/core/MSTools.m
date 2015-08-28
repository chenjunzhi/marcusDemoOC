//
//  MSTools.m
//  marcusDemoOC
//
//  Created by marcus on 15/8/11.
//  Copyright (c) 2015年 marcus. All rights reserved.
//

#import "MSTools.h"

#import <Accelerate/Accelerate.h>

@implementation MSTools

CGRect  CGRectWithScale(CGRect rect, CGFloat scale)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = scale*rect.origin.x;
    newrect.origin.y = scale*rect.origin.y;
    newrect.size.width = scale*rect.size.width;
    newrect.size.height = scale*rect.size.height;
    return newrect;
}

//截取某个位置的图片
+ (UIImage*)getImageFromInsideRect:(CGRect)rect WithImage:(UIImage*)image
{
    CGFloat scale = image.scale;
    CGImageRef cgImage = image.CGImage;
    rect = CGRectWithScale(rect, scale);
    CGImageRef subImageRef = CGImageCreateWithImageInRect(cgImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, smallBounds.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CFRelease(subImageRef);
    return [UIImage imageWithCGImage:smallImage.CGImage scale:scale orientation:UIImageOrientationUp];
}

//将图片做高斯模糊
+ (UIImage *)applyBlurOnImage: (UIImage *)imageToBlur
                   withRadius:(CGFloat)blurRadius {
    if ((blurRadius <= 0.0f) || (blurRadius > 1.0f)) {
        blurRadius = 0.5f;
    }
    
    int boxSize = (int)(blurRadius * 100);
    boxSize -= (boxSize % 2) + 1;
    
    CGImageRef rawImage = imageToBlur.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(rawImage);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(rawImage);
    inBuffer.height = CGImageGetHeight(rawImage);
    inBuffer.rowBytes = CGImageGetBytesPerRow(rawImage);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(rawImage) * CGImageGetHeight(rawImage));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(rawImage);
    outBuffer.height = CGImageGetHeight(rawImage);
    outBuffer.rowBytes = CGImageGetBytesPerRow(rawImage);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                                       0, 0, boxSize, boxSize, NULL,
                                       kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(imageToBlur.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
}
@end
