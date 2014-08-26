//
//  LoginEvent.h
//  LinkMe
//
//  Created by Summer Wu on 14-8-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"

@interface LoginEvent : NSObject

AS_NOTIFICATION(LOGIN)
AS_NOTIFICATION(LOGIN_SUCCESS)
AS_NOTIFICATION(LOGIN_FAILED)

@end
