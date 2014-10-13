//
//  GroupModel.m
//  LinkMe
//
//  Created by Summer Wu on 14-10-11.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "GroupModel.h"

@implementation GroupModel

-(NSSet *)propertiesForJson
{
    return [NSSet setWithObjects:
     @"gid",
     @"type",
     @"description",
     @"pictures",
     @"memberNumber",
     @"memberList",
     @"foundTime",
     @"activityId",
     nil];
}

-(NSDictionary *)propertyClassMap
{
    return @{@"memberList":@"UserModel",
             @"pictures":@"ImageModel"};
}

@end
