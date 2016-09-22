//
//  YHXItemView.m
//  DadishuDemo
//
//  Created by 于慧霞 on 16/9/17.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import "YHXItemView.h"
#import "WBGameItem.h"
#import "UIImage+YHXPartImg.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHidth [UIScreen mainScreen].bounds.size.height

// 6
#define kAutoWDiv2(a) (a) * 1.0 / 2 / 375 * kScreenWidth
#define kAutoHDiv2(a) (a) * 1.0 / 2 / 667 * kScreenHidth


#define kAutoWDiv3(a) (a) * 1.0 / 3 / 414 * kScreenWidth
#define kAutoHDiv3(a) (a) * 1.0 / 3 / 736 * kScreenHidth

#define WeakType(type) __weak typeof(type) weak##type = type;

#define kCount 10 // 从无到有需要多少帧, 总共的动画需要乘以2

@interface YHXItemView ()
@property (nonatomic,weak)UIImageView* chuiZi;
@property (nonatomic,strong) CABasicAnimation* animation; //锤子动画
@property (nonatomic, strong) UIImageView *imageV_daishu;
@property (nonatomic, strong) UIImageView *imageV_dong;
@property (nonatomic, strong) UIImageView *bgImageV; // 消失之前的图 imgV

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) double itemH; // 每次变化的高度
@property (nonatomic, assign) double itemFloat; // 截取图片的单位比例

@property (nonatomic, assign) NSInteger totalCount; // 定时器走了多少次
@property (nonatomic, assign) double totalFloat; // 截取图片比例的多少

// 记录过程结束未点击的 block
@property (nonatomic, copy) void(^complish)(BOOL animate);
//// 记录点击到的方法
//@property (nonatomic, copy) void(^complishClick)(BOOL animate);

@end

@implementation YHXItemView


- (instancetype)initWithFrame:(CGRect)frame Params:(id)parameters
{
    self = [super initWithFrame:frame Params:parameters];
    if (self) {
        
        CGFloat w = self.frame.size.width;
        CGFloat h = self.frame.size.height;
        
       
        [self setBeginAnimation:^(WBGameItem *sv, void (^complish)(BOOL)) {
            
            YHXItemView *itemV = (YHXItemView *)sv;
            
            // 添加顺序跟图层有关, 很重要
            
            // 2.添加洞的 View
            UIImageView *dongView = [UIImageView new];
            dongView.frame = CGRectMake((w - itemV.dongSize.width) / 2, (h - itemV.dongSize.height) / 2+10, itemV.dongSize.width, itemV.dongSize.height);
            dongView.image = itemV.dongImg;
            itemV.imageV_dong = dongView;
            [itemV addSubview:dongView];
            
            // 1.添加消失之前的图, 开始不要给图片, 自己给他大小去
            itemV.bgImageV = [[UIImageView alloc] init];
            [itemV addSubview:itemV.bgImageV];
            
            // 3.添加袋鼠 imageV
            UIImageView *daishuImgV = [UIImageView new];
            itemV.imageV_daishu = daishuImgV;
            daishuImgV.frame = CGRectMake((w - itemV.daishuSize.width) / 2, h / 2, itemV.daishuSize.width, 0);
            [itemV addSubview:daishuImgV];
            
            complish(YES);
        }];
        
        // 动画过程
        [self setLifecircleMotion:^(WBGameItem *sv, NSInteger time, void (^complish)(BOOL)) {
            YHXItemView *itemV = (YHXItemView *)sv;
            
            double itemTime = (time * 1.0) / (kCount * 2);
            itemV.itemH = itemV.daishuSize.height / kCount;
            itemV.itemFloat = 1.0 / kCount;
            itemV.totalCount = 0;
            itemV.totalFloat = 0;
            
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:itemTime target:itemV selector:@selector(timerAction:) userInfo:nil repeats:YES];
            [timer fire];
            [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            itemV.timer = timer;
            itemV.complish = complish; // 记录一下 过程结束未点击的 block
        }];
        
        // 点击方法
        [self setTriggerAnimation:^(WBGameItem *sv, void (^complish)(BOOL)) {
    
            YHXItemView *itemV = (YHXItemView *)sv;
            [itemV.timer invalidate];
            itemV.imageV_daishu.image = nil;
//            itemV.imageV_dong.image = nil; // 洞在不在
           
            itemV.bgImageV.image = itemV.clickImg;
            itemV.userInteractionEnabled = NO;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                complish(YES);
            });
            
            // 绘制哭了的袋鼠
            UIImage *image = [itemV.clickImg getPartWithheaderFloat:itemV.totalFloat];
            CGFloat x = itemV.imageV_daishu.frame.origin.x;
            CGFloat w = itemV.imageV_daishu.frame.size.width;
            CGFloat h = itemV.daishuSize.height * self.totalFloat;
            CGFloat y = itemV.bounds.size.height / 2 - h;
            itemV.bgImageV.frame = CGRectMake(x, y, w, h);
            itemV.bgImageV.image = image;
            if (itemV.clickBlock) {
                itemV.clickBlock(itemV.tag);
            }
            
            UIImageView *imageV = [[UIImageView alloc] init];
            imageV.frame = CGRectMake(0, 0, kAutoWDiv3(170), kAutoWDiv3(160));
            imageV.center = CGPointMake(x + w / 2, y + 13);
            [itemV addSubview:imageV];
            imageV.image = [UIImage imageNamed:@"点击特效-改"];
        }];
        __weak typeof(self)weakSelf = self;
        // 动画结束
        [self setEndAnimation:^(WBGameItem *sv, void (^complish)(BOOL)) {
//            if (weakSelf.clickBlock) {
//                weakSelf.clickBlock(-1);
//            }
            // 结束
            complish(YES);
        }];
        
    }
    return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
       

    [self triggerAction];
    
    
}

- (void)timerAction:(NSTimer *)timer
{
    self.totalCount++;
    if (self.totalCount < kCount + 1) { // 袋鼠往上跑
        self.totalFloat = self.totalCount * self.itemFloat;
        [self changeDaiShuFrame];
    } else if (self.totalCount < kCount * 2 + 1) { // 袋鼠往瞎跑
        self.totalFloat = 1 - (self.totalCount - kCount) * self.itemFloat;
        [self changeDaiShuFrame];
    } else { // 定时器应该结束啦, 正常走完, 没有点击
//        if (self.clickBlock) {
//            self.clickBlock(-1);
//        }

        self.complish(YES);
    }
}
// 根据比例, 调整袋鼠 frame, 根据self.totalFloat
- (void)changeDaiShuFrame
{
    UIImage *image = [self.daiShuImg getPartWithheaderFloat:self.totalFloat];
    
    CGFloat x = self.imageV_daishu.frame.origin.x;
    CGFloat w = self.imageV_daishu.frame.size.width;
    CGFloat h = self.daishuSize.height * self.totalFloat;
    CGFloat y = self.bounds.size.height / 2 - h;
    self.imageV_daishu.frame = CGRectMake(x, y, w, h);
    self.imageV_daishu.image = image;
}

// 结束啦
- (void)destory
{
    [self.timer invalidate];
    [self removeFromSuperview];
}

- (void)dealloc
{
    [self.timer invalidate];
}

@end
