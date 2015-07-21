//
//  JPTimeTickManager+Util.m
//  duobao
//
//  Created by Jasper on 15/5/6.
//  Copyright (c) 2015年 youmi. All rights reserved.
//

#import "JPTimeTickManager+Util.h"

@implementation JPTimeTickManager (Util)

- (JPTimeLabelObj*)addTimeTickLabel:(UILabel*)label withExpiresTime:(NSTimeInterval)interval {
    JPTimeLabelObj *obj = [JPTimeLabelObj new];
    obj.label = label;
    obj.expiresInterval = interval;
    [self addTimeTickObj:obj];
    
    return obj;
}

- (JPTimeLabelObj*)addTimeTickLabel:(UILabel *)label withExpiresTime:(NSTimeInterval)interval  prefix:(NSString*)prefix withExpiresHandler:(TimeExpiresHandler)handler{
    JPTimeLabelObj *obj = [JPTimeLabelObj new];
    obj.label = label;
    obj.expiresInterval = interval;
    obj.handler = handler;
    obj.prefix = prefix;
    [self addTimeTickObj:obj];
    [obj timeTick];
    
    return obj;
}

- (JPTimeLabelObj*)removeTimeTickLabel:(UILabel*)label {
    for (JPTimeTickObj *obj in self.tickObjs) {
        if ([obj isKindOfClass:[JPTimeLabelObj class]]) {
            JPTimeLabelObj *tlObj = (JPTimeLabelObj*)obj;
            if ([tlObj.label isEqual:label]) {
                [self removeTimeTickObj:obj];
                return tlObj;
            }
        }
    }
    return nil;
}

@end
