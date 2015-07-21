//
//  JPTimeLabelObj.m
//  TryGood
//
//  Created by Jasper on 14-9-24.
//  Copyright (c) 2014年 youmi. All rights reserved.
//

#import "JPTimeLabelObj.h"
#import "UILabel+ExpiresTime.h"
@implementation JPTimeLabelObj

- (NSString*)description {
    NSString *superDesc = [super description];
    return [superDesc stringByAppendingFormat:@"\n {\nLabel:\n  %@ \n\n Interval:\n   %f \n}\n", self.label,self.expiresInterval];
}

- (void)timeTick {
    [self.label setTextWithExpiresTime:self.expiresInterval withPrefixe:self.prefix];
    [self.label performSelector:@selector(needsDisplay)];
}
@end
