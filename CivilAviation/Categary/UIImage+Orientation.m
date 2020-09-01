//
//  UIImage+Orientation.m
//  SchoolChat_Parent_iOS
//
//  Created by easyto on 2019/11/11.
//  Copyright © 2019 liuyang. All rights reserved.
//

#import "UIImage+Orientation.h"

@implementation UIImage (Orientation)

+ (UIImage*)fixOrientation:(UIImage*)image

{
    
    if (image.imageOrientation == UIImageOrientationUp) return image;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform =CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform =CGAffineTransformRotate(transform,M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform =CGAffineTransformTranslate(transform, image.size.width,0);
            transform =CGAffineTransformRotate(transform,M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform =CGAffineTransformTranslate(transform,0, image.size.height);
            transform =CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform =CGAffineTransformTranslate(transform, image.size.width,0);
            transform =CGAffineTransformScale(transform, -1,1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform =CGAffineTransformTranslate(transform, image.size.height,0);
            transform =CGAffineTransformScale(transform, -1,1);
            break;
        default:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(
                                             NULL,
                                             image.size.width,
                                             image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage),
                                             0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage)
                                             );
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx,CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
        default:
            CGContextDrawImage(ctx,CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage*img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
