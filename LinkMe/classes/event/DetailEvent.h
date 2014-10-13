//
//  DetailEvent.h
//  LinkMe
//
//  Created by Summer Wu on 14-10-11.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"

@interface DetailEvent : NSObject

AS_NOTIFICATION(LOAD_DETAIL_ACTIVITY_START)
AS_NOTIFICATION(LOAD_DETAIL_ACTIVITY_SUCCESS)
AS_NOTIFICATION(LOAD_DETAIL_ACTIVITY_FAILED)

@end
