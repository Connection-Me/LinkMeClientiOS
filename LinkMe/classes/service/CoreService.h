//
//  CoreService.h
//  LinkMe
//
//  Created by Summer Wu on 14-8-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IUserRemoteService.h"
#import "IActivityRemoteService.h"
#import "IDetailRemoteService.h"
#import "ICommendRemoteService.h"
#import "Bee.h"

@interface CoreService : NSObject

AS_SINGLETON(CoreService)

@property(nonatomic,readonly) id<IUserRemoteService> userRemoteService;
@property(nonatomic,readonly) id<IActivityRemoteService> activityRemoteService;
@property(nonatomic,readonly) id<IDetailRemoteService> detailRemoteService;
@property(nonatomic,readonly) id<ICommendRemoteService> commendRemoteService;
@end

