//
//  UserModel.m
//  LinkMe
//
//  Created by Summer Wu on 14-10-11.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(NSSet *)propertiesForJson
{
    return [NSSet setWithObjects:
            @"uid",
            @"userName",
            @"registerTime",
            @"weibo",
            @"wechat",
            @"profile",
            @"nickName",
            @"lastLoginTime",
            @"lastLogoutTime",
            @"groupList",
            @"activityList",
            nil];
}

-(NSDictionary *)propertyClassMap
{
    return @{@"groupList":@"GroupModel",
             @"activityList":@"ActivityModel"};
}

@end
