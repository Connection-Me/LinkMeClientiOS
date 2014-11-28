//
//  ICommendRemoteService.h
//  LinkMe
//
//  Created by Summer Wu on 14-11-22.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HobbyModel;
@class UserModel;
@class ActivityModel;

@protocol ICommendRemoteService <NSObject>

-(void)queryCommendUsersBy:(HobbyModel*)hobbyModel andOffset:(NSInteger)offset andLimit:(NSInteger)limit;

-(void)sendInviteToFriendsByUsers:(NSArray*)users andActivity:(ActivityModel*)activity andWay:(NSString*)way;

-(void)checkIsHaveBeInvite;

-(void)receiveInviteByActivity:(ActivityModel*)activityModel;

@end
