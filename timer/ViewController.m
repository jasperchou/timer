//
//  ViewController.m
//  timer
//
//  Created by Jasper on 15/7/21.
//  Copyright (c) 2015年 jasper. All rights reserved.
//

#import "ViewController.h"
#import "JPTimeTickManager+Util.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeL;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
     *可以网络获取服务器时间对manager进行设置先。
     *当有设置服务器时间的时候会按照10秒一次的时间进行时钟，避免不必要的执行
     */
    NSTimeInterval delayInterval = [[NSDate date] timeIntervalSince1970] + 20;
    [[JPTimeTickManager shareTickManager]addTimeTickLabel:self.timeL withExpiresTime:delayInterval prefix:@"我在倒计时: " withExpiresHandler:^(JPTimeTickObj *obj) {
        NSLog(@"我是handler, obj:%@", obj);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
