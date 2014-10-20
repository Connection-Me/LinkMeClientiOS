//
//  LoginEvent.h
//  LinkMe
//
//  Created by Summer Wu on 14-8-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"

@interface UserEvent : NSObject

AS_NOTIFICATION(LOGIN)
AS_NOTIFICATION(LOGIN_SUCCESS)
AS_NOTIFICATION(LOGIN_FAILED)
AS_NOTIFICATION(LOGIN_FAILED_USER_NOT_EXISTED)
AS_NOTIFICATION(LOGIN_FAILED_PASS_ERROR)

AS_NOTIFICATION(REGISTER)
AS_NOTIFICATION(REGISTER_SUCCESS)
AS_NOTIFICATION(REGISTER_FAILED)
AS_NOTIFICATION(REGISTER_FAILED_EXISTED)
AS_NOTIFICATION(REGISTER_FAILED_INFO_ERROR)

@end
