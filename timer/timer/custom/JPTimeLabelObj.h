//
//  JPTimeLabelObj.h
//  TryGood
//
//  Created by Jasper on 14-9-24.
//  Copyright (c) 2014年 youmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPTimeTickObj.h"
#import <UIKit/UIKit.h>

@interface JPTimeLabelObj : JPTimeTickObj

@property (nonatomic, weak)UILabel  *label;
@property (nonatomic, strong)NSString *prefix;

@end
