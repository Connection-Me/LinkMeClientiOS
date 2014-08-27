//
//  CoreModel.m
//  LinkMe
//
//  Created by Summer Wu on 14-8-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "CoreModel.h"

static NSString *url = @"http://";//根路径

@implementation CoreModel

DEF_SINGLETON(CoreModel)
DEF_STATIC_PROPERTY_STRING(serverURL,url);



@end
