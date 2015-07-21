//
//  JPTimeTickObj.m
//  duobao
//
//  Created by Jasper on 15/5/6.
//  Copyright (c) 2015年 youmi. All rights reserved.
//

#import "JPTimeTickObj.h"
#import "JPTimeTickManager.h"

@implementation JPTimeTickObj

- (instancetype)init {
    self = [super init];
    if (self) {
        self.autoRemoveWhenExpires = YES;
        self.isTicking = NO;
    }
    return self;
}

- (BOOL)checkExpires {
    return [JPTimeTickManager shareTickManager].customLocalTime >= self.expiresInterval;
}

- (void)dealloc {
    self.handler = nil;
}

- (void)timeTick {
    NSLog(@"%s Need Override", __FUNCTION__);
}
@end
