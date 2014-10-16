//
//  TimeUtil.h
//  LinkMe
//
//  Created by ChaoSo on 14-10-14.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUtil : NSObject
+(NSDate*) convertDateFromString:(NSString*)uiDate;
+ (NSString *)stringFromDate:(NSDate *)date;
+(NSString *) compareCurrentTime:(NSDate*) compareDate;
@end
