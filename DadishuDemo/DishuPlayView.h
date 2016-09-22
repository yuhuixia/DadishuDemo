//
//  DishuPlayView.h
//  DadishuDemo
//
//  Created by 于慧霞 on 16/9/17.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YHXClickAllNumBlock)(NSInteger allCount);
// 每次点击返回中奖的
typedef void(^YHXclickCountBlock)(NSInteger cout);
// 结束的回调
typedef void(^SucessEndBlock)(NSArray *seleArr);
@interface DishuPlayView : UIView


@property (nonatomic, strong) NSArray *dataArr;// 存放红包的数组 存的是 model 必须提前设定值

@property (nonatomic, assign) CGFloat duration;// 总时间 可选

@property (nonatomic, assign) CGFloat itemDuration;// 每个的时间 可选

@property (nonatomic, strong) NSArray *zhongjianArr;// 存有奖品的数组 存的是 index



- (void)animationBegin;// 开始  这条语句执行之前必须先设置之前的属性

@property (nonatomic, copy) SucessEndBlock sucessEndBlock;
- (void)setSucessEndBlock:(SucessEndBlock)sucessEndBlock;

@property (nonatomic,copy) YHXclickCountBlock clickCountBlock;
- (void)setClickCountBlock:(YHXclickCountBlock)clickCountBlock;

/**
 *  这是点击小红包会调用的方法, 也就是说, 当index=-1时, 不应调用此方法
 */
@property (nonatomic, copy) YHXClickAllNumBlock clickAllNumBlock;
- (void)setClickAllNumBlock:(YHXClickAllNumBlock)clickAllNumBlock;


@end
