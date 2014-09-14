//
//  IHomeDao.h
//  LinkMe
//
//  Created by Summer Wu on 14-9-11.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityModel.h"

@protocol IHomeDao <NSObject>

-(ActivityModel*)findActivityByActivityId:(NSString*)activityId;
-(NSArray*)findActivities;
-(NSInteger)insertActivity:(ActivityModel*)activity;
@end
