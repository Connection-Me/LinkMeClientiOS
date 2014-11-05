//
//  IHomeRemoteService.h
//  LinkMe
//
//  Created by Summer Wu on 14-9-1.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ActivityModel;
@protocol IActivityRemoteService <NSObject>

//way:all,host,guest;
//when:todo,doing,done;
-(void)queryHomeActivity:(NSInteger)offset andLimit:(NSInteger)limit andWay:(NSString*)way andWhen:(NSString*)when;
-(void)addActivityByActivityModel:(ActivityModel *)activityModel;
@end
