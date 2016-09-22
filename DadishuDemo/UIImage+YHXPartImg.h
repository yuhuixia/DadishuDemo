//
//  UIImage+YHXPartImg.h
//  DadishuDemo
//
//  Created by 于慧霞 on 16/9/17.
//  Copyright © 2016年 yuhuixia. All rights reserved.
// 截取部分图片的类目

#import <UIKit/UIKit.h>

@interface UIImage (YHXPartImg)

// 根据 rect 截取部分图片
- (UIImage *)getPartWithrect:(CGRect)partRect;

// 根据比例 截取图片头部部分, 0 - 1
- (UIImage *)getPartWithheaderFloat:(CGFloat)headerFloat;

@end
