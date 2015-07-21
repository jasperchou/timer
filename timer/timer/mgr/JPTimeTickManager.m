//
//  JPTimeTickManager.m
//
//  Created by Jasper on 14-9-24.
//  Copyright (c) 2014年 youmi. All rights reserved.
//

#import "JPTimeTickManager.h"
#import <UIKit/UIKit.h>
#import "JPMacro.h"
@interface JPTimeTickManager()

@property (nonatomic, assign)   CGFloat timePerTick;
@property (nonatomic, readwrite)    NSMutableArray *tickObjs;
@property (nonatomic, strong)   NSTimer *tickTimer;
@property (nonatomic, readwrite)    NSTimeInterval  customLocalTime;

@end

@implementation JPTimeTickManager

#pragma mark -
#pragma mark - accessor
- (void)setTimePerTick:(CGFloat)timePerTick {
    ///不相同 || 定时器无效
    if (_timePerTick != timePerTick
        || self.tickTimer == nil
        || !self.tickTimer.valid) {
        ///不是本地时间 && 之前定时器有效
        if (_customLocalTime != -1
            && self.tickTimer
            && self.tickTimer.valid) {
            ///补回定时器定时一半的时间
            _customLocalTime += _timePerTick - [self.tickTimer.fireDate timeIntervalSinceNow];
        }
        _timePerTick = timePerTick;
        [self stopTimeTick];
        [self startTimeTick];
    }
}

- (NSTimeInterval)customLocalTime {
    if (_customLocalTime == -1) {
        return [[NSDate date] timeIntervalSince1970];
    } else {
        return _customLocalTime;
    }
}

#pragma mark -
+ (JPTimeTickManager*)shareTickManager {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)resetCustomLocalTime:(NSTimeInterval)localTime {
    @synchronized(self) {
        if (localTime == -1 || localTime > _customLocalTime) {
            [self stopTimeTick];
            _customLocalTime = localTime;
        } else {
            ///时间无法倒退
            return;
        }
    }
    if (_customLocalTime == -1 && [self.tickObjs count] == 0) {
        [self stopTimeTick];
    } else {
        [self startTimeTick];
    }
}

- (id)init {
    self = [super init];
    if (self) {
        self.tickObjs = [NSMutableArray new];
        self.customLocalTime = -1;
        _timePerTick = JPSlowTimePerTick;
        _tickType = JPLocalTimeTickTypeNormal;
    }
    return self;
}

- (void)startTimeTick {
    if (self.tickTimer && self.tickTimer.valid) {
        return;
    } else {
        self.tickTimer = [NSTimer timerWithTimeInterval:self.timePerTick target:self selector:@selector(tickHandler:) userInfo:nil repeats:YES];
        self.tickTimer.tolerance = 0;
        [[NSRunLoop currentRunLoop] addTimer:self.tickTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimeTick {
    [self.tickTimer invalidate];
}

- (void)addTimeTickObj:(JPTimeTickObj*)obj {
    JPLOG(@"AddTimTickObj:%@",obj);
    [self.tickObjs addObject:obj];
    obj.isTicking = YES;
    ///改为 JPQuickTimePerTick
    if ([self.tickObjs count] == 1) {
        self.timePerTick = JPQuickTimePerTick;
    }
}

- (void)removeTimeTickObj:(JPTimeTickObj*)obj {
    JPLOG(@"RemoveTimTickObj:%@",obj);
    [self.tickObjs removeObject:obj];
    obj.isTicking = NO;
    ///个数为零，且localtime为-1时可以停
    if ([self.tickObjs count] == 0 && _customLocalTime == -1) {
        [self stopTimeTick];
    } else {
        ///改为时间间隔较大的定时器
        if ([self.tickObjs count] == 0) {
            self.timePerTick = JPSlowTimePerTick;
        }
    }
}

- (void)tickHandler:(NSTimer*)timer {
    // 更新本地服务器时间
    if (_customLocalTime != -1) {
        if (self.tickType == JPLocalTimeTickTypeAccurate) {
            ///更精准模式,但是依赖本地时间差
            static NSTimeInterval localTime = -1;
            NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];
            NSTimeInterval accurateTimePerTick = nowInterval - localTime;
            localTime = nowInterval;
            ///timer只会延时不会提前
            if (accurateTimePerTick < _timePerTick) {
                _customLocalTime += _timePerTick;
            } else {
                _customLocalTime += accurateTimePerTick;
            }
        } else {
            ///按照定时器规定时间模式，但是定时器有偏差
            _customLocalTime += _timePerTick;
        }
    }

    /// 倒计时处理
    NSMutableArray *expriesObjs = [NSMutableArray array];
    for (JPTimeTickObj *obj in self.tickObjs) {
        [obj timeTick];
        ///不能直接处理expiresobj， 有可能在遍历中移除
        if ([obj checkExpires]) {
            [expriesObjs addObject:obj];
        }
    }
    
    ///过期obj处理
    for (JPTimeTickObj *obj in expriesObjs) {
        if (obj.handler) {
            obj.handler(obj);
        }
        if (obj.autoRemoveWhenExpires) {
            [self removeTimeTickObj:obj];
        }
    }
}

- (void)dealloc {
    if (self.tickTimer && self.tickTimer.valid) {
        [self.tickTimer invalidate];
        self.tickTimer = nil;
    }
}
@end
