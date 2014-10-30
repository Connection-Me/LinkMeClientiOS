//
//  HomeRemoteServiceImpl.h
//  LinkMe
//
//  Created by Summer Wu on 14-9-1.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IActivityRemoteService.h"
#import "BaseService.h"
#import "Bee.h"

@interface ActivityRemoteServiceImpl : BaseService<IActivityRemoteService>
AS_SINGLETON(ActivityRemoteServiceImpl)

@end
