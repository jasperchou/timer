//
//  JPTimeTickManager+Util.h
//  duobao
//
//  Created by Jasper on 15/5/6.
//  Copyright (c) 2015年 youmi. All rights reserved.
//

#import "JPTimeTickManager.h"
#import "JPTimeLabelObj.h"
@interface JPTimeTickManager (Util)

- (JPTimeLabelObj*)addTimeTickLabel:(UILabel*)label withExpiresTime:(NSTimeInterval)interval;
- (JPTimeLabelObj*)addTimeTickLabel:(UILabel *)label withExpiresTime:(NSTimeInterval)interval  prefix:(NSString*)prefix withExpiresHandler:(TimeExpiresHandler)handler;
- (JPTimeLabelObj*)removeTimeTickLabel:(UILabel*)label;

@end
