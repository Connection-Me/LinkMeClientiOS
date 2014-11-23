//
//  CommendRemoteServiceImpl.h
//  LinkMe
//
//  Created by Summer Wu on 14-11-22.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"
#import "ICommendRemoteService.h"
#import "Bee.h"

@interface CommendRemoteServiceImpl : BaseService<ICommendRemoteService>
AS_SINGLETON(CommendRemoteServiceImpl)
@end
