//
//  CommendEvent.h
//  LinkMe
//
//  Created by Summer Wu on 14-11-22.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"

@interface CommendEvent : NSObject

AS_NOTIFICATION(LOAD_APP_COMMEND_START)
AS_NOTIFICATION(LOAD_APP_COMMEND_SUCCESS)
AS_NOTIFICATION(LOAD_APP_COMMEND_FAILED)

@end
