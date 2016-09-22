//
//  YHXItemView.h
//  DadishuDemo
//
//  Created by 于慧霞 on 16/9/17.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBGameItem.h"

// 每一个的点击回调
typedef void(^ClickBlcok)(NSInteger tag);
@interface YHXItemView : WBGameItem

// 在调用开始动画方法的时候, 以下属性必须都有值

/** 袋鼠 image  */
@property (nonatomic, strong) UIImage *daiShuImg;

/** 洞 imge */
@property (nonatomic, strong) UIImage *dongImg;

/** 打完地鼠消失的图片 */
@property (nonatomic, strong) UIImage *clickImg;

// 袋鼠imageView尺寸 / 和被打完之后的属性一样大
@property (nonatomic, assign) CGSize daishuSize;

// 洞imageView尺寸
@property (nonatomic, assign) CGSize dongSize;



@property (nonatomic, copy) ClickBlcok clickBlock;
- (void)setClickBlock:(ClickBlcok)clickBlock;






@end
