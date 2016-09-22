//
//  ViewController.m
//  DadishuDemo
//
//  Created by 于慧霞 on 16/9/17.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+YHXPartImg.h"
#import "YHXItemView.h"
#import "DishuPlayView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}
- (IBAction)clickbutton:(id)sender {
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            continue;
        }
        [view removeFromSuperview];
    }
    
    UIImageView *imag = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imag.image = [UIImage imageNamed:@"背景.jpg"];
    imag.userInteractionEnabled = YES;
    [self.view addSubview:imag];
    NSArray *array = @[@"",@"",@"",@"",@""];
    
    DishuPlayView *gameView = [[DishuPlayView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    
    gameView.dataArr = array;
    //    self.gameView.gameBackString =  dataDict[@"back_img"];
    //    self.gameView.over_type = overtype;
    //    self.gameView.durSpeed = self.durSpeed;
    [gameView animationBegin];
    [imag addSubview:gameView];
    
    [gameView setClickCountBlock:^(NSInteger cout) {
        NSLog(@"-------%ld", (long)cout);
    }];
    
#warning ----这里不会进
    [gameView setSucessEndBlock:^(NSArray *seleArr) {
         NSLog(@"eeeeeeeeeee");
    }];
    
    
    //    NSDictionary *param = @{
    //                            @"duration":@3
    //                            };
    //
    //    YHXItemView *itemV = [[YHXItemView alloc] initWithFrame:CGRectMake(100, 100, 100, 100) Params:param];
    //    [self.view addSubview:itemV];
    ////    itemV.backgroundColor = [UIColor greenColor];
    //
    //    // 初始化属性
    //    itemV.dongImg = [UIImage imageNamed:@"dong"];
    //    itemV.daiShuImg = [UIImage imageNamed:@"dishu.jpg"];
    //    itemV.bgImg = [UIImage imageNamed:@"xiaoshi"];
    //    itemV.daishuSize = CGSizeMake(50, 100);
    //    itemV.dongSize = CGSizeMake(100, 30);
    //    [itemV startShow]; // 这条之前必须初始化属性
    UIButton *button = (UIButton *)sender;
    [self.view addSubview:sender];
    NSLog(@"%@", NSStringFromCGRect(button.frame));
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
