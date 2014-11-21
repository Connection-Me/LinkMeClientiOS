//
//  ActivityModel.h
//  LinkMe
//
//  Created by Summer Wu on 14-9-1.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LibModel.h"

@interface ActivityModel :LibModel

//@property (nonatomic,strong) NSString* token;
@property (nonatomic,strong) NSString * activityId;
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSString* type;
@property (nonatomic,strong) NSString* desc;
@property (nonatomic,strong) NSString* imageURL;
@property (nonatomic,strong) NSDate * activityInitTime; 
@property double openTime;
@property double closeTime;
@property double startTime;
@property double stopTime;
@property NSInteger lowerLimit;
@property NSInteger upperLimit;
@property NSInteger approveCount;
@property NSInteger rejectCount;

@property (nonatomic,strong) NSArray    *approveList;


@end
