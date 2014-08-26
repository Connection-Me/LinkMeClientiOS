//
//  CoreService.h
//  LinkMe
//
//  Created by Summer Wu on 14-8-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IUserRemoteService.h"
#import "Bee.h"

@interface CoreService : NSObject

AS_SINGLETON(CoreService)

@property(nonatomic,readonly) id<IUserRemoteService> userRemoteService;

@end

