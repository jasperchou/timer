//
//  JPTimeTickManager.h
//  TryGood
//
//  Created by Jasper on 14-9-24.
//  Copyright (c) 2014年 youmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPTimeTickObj.h"

/*
 *有需要定时的obj则使用快时钟
 *无，则使用慢时钟，避免不必要的执行消耗
 */
#define JPSlowTimePerTick   10
#define JPQuickTimePerTick  0.033

typedef enum {
    JPLocalTimeTickTypeNormal   = 0,    ///自定义本地时间(即服务器时间)按照定时器时间差来加
    JPLocalTimeTickTypeAccurate,        ///自定义本地时间(即服务器时间)按照本机时间差来加
} JPLocalTimeTickType;

/**
 *自动根据有没有倒计时的obj，选择快慢模式
 */
@interface JPTimeTickManager : NSObject

/*@customLocalTime
 *default -1 , getter返回的是本地时间
 *可以设置服务器时间，会自动进行时钟计算，可以定时进行校正
 */
@property (nonatomic, readonly) NSTimeInterval customLocalTime;
@property (nonatomic, readonly) NSMutableArray *tickObjs;

@property (nonatomic, assign) JPLocalTimeTickType   tickType;

+ (JPTimeTickManager*)shareTickManager;

/*
 *@localTime -1(本地时间)或者服务器时间
 *Notice: NSTimeInterval is double type.
 */
- (void)resetCustomLocalTime:(NSTimeInterval)localTime;

/*更改为大于1时自动触发*/
//- (void)startTimeTick;
//- (void)stopTimeTick;

- (void)addTimeTickObj:(JPTimeTickObj*)obj;
- (void)removeTimeTickObj:(JPTimeTickObj*)obj;

@end
