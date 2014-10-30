//
//  CoreService.m
//  LinkMe
//
//  Created by Summer Wu on 14-8-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "CoreService.h"
#import "UserRemoteServiceImpl.h"
#import "ActivityRemoteServiceImpl.h"
#import "DetailRemoteServiceImpl.h"


@implementation CoreService
DEF_SINGLETON(CoreService)

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        _userRemoteService = [UserRemoteServiceImpl sharedInstance];
        _activityRemoteService = [ActivityRemoteServiceImpl sharedInstance];
        _detailRemoteService = [DetailRemoteServiceImpl sharedInstance];
    }
    return self;
}


@end
