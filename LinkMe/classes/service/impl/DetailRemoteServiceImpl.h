//
//  DetailRemoteServiceImpl.h
//  LinkMe
//
//  Created by Summer Wu on 14-10-11.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"
#import "IDetailRemoteService.h"
#import "Bee.h"

@interface DetailRemoteServiceImpl : BaseService<IDetailRemoteService>

AS_SINGLETON(DetailRemoteServiceImpl)
@end
