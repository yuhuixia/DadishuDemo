//
//  UIImage+YHXPartImg.m
//  DadishuDemo
//
//  Created by 于慧霞 on 16/9/17.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import "UIImage+YHXPartImg.h"

@implementation UIImage (YHXPartImg)

- (UIImage *)getPartWithrect:(CGRect)partRect
{
    CGImageRef imageRef = self.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, partRect);
    UIImage *resImg = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    return resImg;
}

// 根据比例 截取图片头部部分, 0 - 1
- (UIImage *)getPartWithheaderFloat:(CGFloat)headerFloat
{
    
    UIImageView *imageV = [UIImageView new];
    imageV.image = self;
    [imageV sizeToFit];
    CGFloat orgW = imageV.frame.size.width;
    CGFloat orgH = imageV.frame.size.height;
    
    CGFloat imgW = orgW;
    CGFloat imgH = orgH * headerFloat;
    
    CGImageRef imageRef = self.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 0, imgW, imgH));
    UIImage *image = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    return image;
}

@end
