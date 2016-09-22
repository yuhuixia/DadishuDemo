//
//  DishuPlayView.m
//  DadishuDemo
//
//  Created by 于慧霞 on 16/9/17.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import "DishuPlayView.h"
#import "YHXItemView.h"
//#
//#define kScreenWidth [UIScreen mainScreen].bounds.size.width
//#define kScreenHidth [UIScreen mainScreen].bounds.size.height

// 6
#define kAutoWDiv2(a) (a) * 1.0 / 2 / 375 * KSCReenWidth
#define kAutoHDiv2(a) (a) * 1.0 / 2 / 667 * KSCReenHeight


#define kAutoWDiv3(a) (a) * 1.0 / 3 / 414 * KSCReenWidth
#define kAutoHDiv3(a) (a) * 1.0 / 3 / 736 * KSCReenHeight

#define KSCReenWidth  [UIScreen mainScreen].bounds.size.width
#define KSCReenHeight  [UIScreen mainScreen].bounds.size.height

@interface DishuPlayView  ()
@property (nonatomic, assign) BOOL canRemove;// 是否能移除,默认不能移除 当所有动画结束的时候点击 view 就移除

@end

@implementation DishuPlayView


- (void)animationBegin
{
    
    if (!self.dataArr || self.dataArr.count == 0) {
        return;
    }
    _canRemove = NO;
    // 总时间
    CGFloat totalTime = self.duration ? self.duration : 3;
    // 飘下来多少个
    NSInteger count = self.dataArr.count;
    // 几秒钟飘下来一个
    CGFloat itemTime = totalTime * 1.0 / count;
    
    // 每个小 view 下落的时间
//    CGFloat itemDur = self.itemDuration ? self.itemDuration : 1.5;
    // 宽高等属性
    CGFloat itemW = 80;
    CGFloat itemH = 80;
    CGFloat y = 0 - itemH;
    CGFloat x;
    __block NSInteger theCount  = 0;//记录走过了多少个红包.当 theCount =self.dataArr.count时,证明动画完成
    NSMutableArray *array = [NSMutableArray array];// 点中 && 中奖
    for (int i = 0; i < count; i++) {
        
        // 取出 i 对应的 model
//        GameModel *iModel = self.dataArr[i];
        // x 从 一半宽度 到 (屏幕宽度 - 宽度 - 一半宽度)
        //        NSInteger fromX = (NSInteger)itemW / 2;
        //        NSInteger toX = (NSInteger)(KSCReenWidth - itemW * 1.5);
        NSInteger fromX = 40;
        NSInteger toX = (NSInteger)(KSCReenWidth - itemW);
        NSInteger fromY = 130;
        NSInteger toY = (NSInteger)(KSCReenHeight - itemH);
        // 随机出来的 x
        x = arc4random() % (toX - fromX) + fromX;
        y = arc4random() % (toY - fromY) + fromY;
        
        
        // 如果给宽高了, 就用 model 里的宽高赋值, 如果没有给, 用默认的
//        itemW = [iModel.width floatValue] /2? [iModel.width floatValue] /2: itemW;
//        itemH = [iModel.height floatValue] /2? [iModel.height floatValue] /2: itemH;
        
        
        
        
        YHXItemView *snowView = [[YHXItemView alloc] initWithFrame:CGRectMake(x, y, itemW, itemH) Params:@{@"duration":@3}];
        
        snowView.backgroundColor = [UIColor redColor];
        [snowView setClickBlock:^(NSInteger tag) {
            
            //  如果传过来的 tag=-1, 证明不是点击消失, 是未点击自己就消失啦,则不调用
            if (self.clickAllNumBlock && tag >= 0) {
                self.clickAllNumBlock(tag);
            }
        
            
            if (tag >= 0) { // 判断是否点击了 , 没点击自动消失的是不会进到判断力的
                [array addObject:@(tag)];
                
                if (self.clickCountBlock) {
                    self.clickCountBlock(tag);
                }
                
            }
            
            theCount ++;
            if (theCount == count) {
                if (self.sucessEndBlock) {
                    self.sucessEndBlock(array);
                    _canRemove = YES;
                    
                }
            }
        }];
        snowView.tag = i;
        
        
        
        snowView.daiShuImg = [UIImage imageNamed:@"稻草人1"];
        snowView.dongImg = [UIImage imageNamed:@"洞-改"];
        snowView.clickImg = [UIImage imageNamed:@"地鼠2"];
        snowView.daishuSize = CGSizeMake(150, 150);
        snowView.dongSize = CGSizeMake(100, 50);
        
        if (i == 0) {//第一个不延迟
            [self addSubview:snowView];
            [snowView startShow];
        }else{// 否则每个 view 有一定的间隔飘下来
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(itemTime *i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self addSubview:snowView];
                [snowView startShow];
            });
        }
        
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_canRemove == YES) {
        
        [self removeFromSuperview];
    }
}

@end
