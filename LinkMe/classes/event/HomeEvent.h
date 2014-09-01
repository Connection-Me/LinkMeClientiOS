//
//  HomeEvent.h
//  LinkMe
//
//  Created by Summer Wu on 14-9-1.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"
@interface HomeEvent : NSObject

AS_NOTIFICATION(LOAD_ACTIVITY_START)
AS_NOTIFICATION(LOAD_ACTIVITY_SUCCESS)
AS_NOTIFICATION(LOAD_ACTIVITY_FAILED)

@end
