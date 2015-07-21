//
//  JPTimeTickObj.h
//  duobao
//
//  Created by Jasper on 15/5/6.
//  Copyright (c) 2015年 youmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JPTimeTickObj;
typedef void(^TimeExpiresHandler)(JPTimeTickObj*obj);

@interface JPTimeTickObj : NSObject

@property (nonatomic, assign)NSTimeInterval expiresInterval;
@property (nonatomic, copy)TimeExpiresHandler   handler;
@property (nonatomic, assign)BOOL   autoRemoveWhenExpires;
@property (nonatomic, assign)BOOL   isTicking;

- (BOOL)checkExpires;
///need override
- (void)timeTick;
@end
