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
            @"joinPeople",
            @"imagePath",
            @"startTime",
            nil];
}

@end
