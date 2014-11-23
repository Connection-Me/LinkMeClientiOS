//
//  HobbyModel.m
//  LinkMe
//
//  Created by Summer Wu on 14-11-21.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "HobbyModel.h"

@implementation HobbyModel

-(NSSet *)propertiesForJson
{
    return [NSSet setWithObjects:
            @"hid",
            @"name",
            @"desc",
            nil];
}

-(NSDictionary *)propertiesMap
{
    return @{@"desc":@"description"
             };
}

@end
