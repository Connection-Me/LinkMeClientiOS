//
//  ActivityModel.m
//  LinkMe
//
//  Created by Summer Wu on 14-9-1.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

-(NSSet *)propertiesForJson
{
    return [NSSet setWithObjects:
            @"activityId",
            @"name",
            @"type",
            @"desc",
            @"imageURL",
            @"activityInitTime",
            @"openTime",
            @"closeTime",
            @"startTime",
            @"stopTime",
            @"lowerLimit",
            @"upperLimit",
            @"approveCount",
            @"rejectCount",
            @"approveList",
            nil];
}

-(NSDictionary *)propertiesMap
{
    return @{
      @"activityId":@"aid"
      };
}

-(NSDictionary *)propertyClassMap
{
    return @{@"approveList":@"UserModel"};
}

@end
