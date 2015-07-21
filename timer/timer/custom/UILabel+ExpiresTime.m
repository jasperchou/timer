//
//  UILabel+ExpiresTime.m
//  TryGood
//
//  Created by Jasper on 14-9-24.
//  Copyright (c) 2014年 youmi. All rights reserved.
//

#import "UILabel+ExpiresTime.h"
#import "JPTimeTickManager.h"
#import "JPMacro.h"
@implementation UILabel (ExpiresTime)

- (void)setTextWithExpiresTime:(NSTimeInterval)interval {
    [self setTextWithExpiresTime:interval withPrefixe:@"剩余"];
}

- (void)setTextWithExpiresTime:(NSTimeInterval)interval withPrefixe:(NSString*)prefix {
    NSTimeInterval nowInterval = [JPTimeTickManager shareTickManager].customLocalTime;
    NSTimeInterval remainInterval = interval - nowInterval;
    if (interval == 0) {
        self.text = @"";
        return;
    }
    
    if (remainInterval < 0) {
        self.text = @"超时";
        return;
    }
    
    NSString *time = [UILabel stringWithRemainTime:remainInterval withPrefix:prefix];
    if (prefix.length == 0) {
        time = [time stringByReplacingOccurrencesOfString:@"分" withString:@":"];
        time = [time stringByReplacingOccurrencesOfString:@"秒" withString:@":"];
    }
    if ([self.text isEqualToString:time]) {
        return;
    } else {
        self.text = time;
    }
}

+ (NSString*)stringWithRemainTime:(NSTimeInterval)interval{
    if (interval > JPTimeIntervalPerDay) {
        int day = (int)(interval / JPTimeIntervalPerDay);
        return [NSString stringWithFormat:@"%d天", day];
    } else if (interval > JPTimeIntervalPerHour) {
        int hour = (int)(interval / JPTimeIntervalPerHour);
        return [NSString stringWithFormat:@"%d小时", hour];
    } else {
        int min = (int)(interval / JPTimeIntervalPerMin);
        int second = (int)(interval - min * JPTimeIntervalPerMin);
        int mill = (int)((interval - (int)interval) * 100);
        return [NSString stringWithFormat:@"%.2d分%.2d秒%0.2d", min, second, mill];
    }
    return nil;
}

+ (NSString*)stringWithRemainTime:(NSTimeInterval)interval withPrefix:(NSString*)prefix {
    return [prefix stringByAppendingString:[UILabel stringWithRemainTime:interval]];
}
@end
