//
//  IHomeRemoteService.h
//  LinkMe
//
//  Created by Summer Wu on 14-9-1.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ActivityModel;
@protocol IHomeRemoteService <NSObject>

-(void)queryActivityByUserName:(NSString*)username andController:(NSString*)c andMethodName:(NSString*)methodName;
-(void)addActivityByActivityModel:(ActivityModel *)activityModel;
@end
