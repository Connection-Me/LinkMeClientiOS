//
//  LinkMeStartupService.m
//  LinkMe
//
//  Created by Summer Wu on 14-9-10.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "LinkMeStartupService.h"
#import "CoreDao.h"

@implementation LinkMeStartupService
DEF_SINGLETON(LinkMeStartupService)

-(void)preStartup
{
    [self initDB];
}

-(void)initDB
{
    [CoreDao sharedInstance];
}
@end
