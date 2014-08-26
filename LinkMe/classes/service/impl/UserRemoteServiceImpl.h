//
//  LoginRemoteServiceImpl.h
//  LinkMe
//
//  Created by Summer Wu on 14-8-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"
#import "BaseService.h"
#import "IUserRemoteService.h"

@interface UserRemoteServiceImpl : BaseService<IUserRemoteService>
AS_SINGLETON(UserRemoteServiceImpl)

@end
