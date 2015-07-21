//
//  UILabel+ExpiresTime.h
//  TryGood
//
//  Created by Jasper on 14-9-24.
//  Copyright (c) 2014年 youmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ExpiresTime)

- (void)setTextWithExpiresTime:(NSTimeInterval)interval;
- (void)setTextWithExpiresTime:(NSTimeInterval)interval withPrefixe:(NSString*)prefix;


+ (NSString*)stringWithRemainTime:(NSTimeInterval)interval;
+ (NSString*)stringWithRemainTime:(NSTimeInterval)interval withPrefix:(NSString*)prefix;
@end
