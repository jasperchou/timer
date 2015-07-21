//
//  Header.h
//
//
//  Created by Jasper on 14-9-24.
//  Copyright (c) 2014年 youmi. All rights reserved.
//

#ifndef JP_Header_h
#define JP_Header_h

#ifdef DEBUG
#define JPLOG(xx, ...) NSLog(@"JP<INFO>: " xx, ##__VA_ARGS__)
#define JPWarning(xx, ...) NSLog(@"JP<Warning>:" xx, ##__VA_ARGS__)
#define JPLOGData(data) JPLOG(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding])
#else
#define JPLOG(xx, ...) ((void)0)
#define JPWarning(xx, ...) ((void)0)
#define JPLOGData(data) ((void)0)
#endif

#define JPAssignSafely(value) (((value) == nil) ? @"" : value)

#define JPTimeIntervalPerMin    60.0f
#define JPTimeIntervalPerHour   (60 * JPTimeIntervalPerMin)
#define JPTimeIntervalPerDay    (24 * JPTimeIntervalPerHour)


#endif  //


