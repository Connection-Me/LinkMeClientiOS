//
//  ImageModel.m
//  LinkMe
//
//  Created by Summer Wu on 14-10-11.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel

-(NSSet *)propertiesForJson
{
    return [NSSet setWithObjects:
            @"imageId",
            @"imageUrl",
            nil];
}

@end
