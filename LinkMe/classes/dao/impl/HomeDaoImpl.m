//
//  HomeDaoImpl.m
//  LinkMe
//
//  Created by Summer Wu on 14-9-11.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "HomeDaoImpl.h"

@implementation HomeDaoImpl
static NSString * SQL_FIND_ACTIVITY = @"SELECT activity_id,name,type,desc,image_u_r_l,open_time,close_time,lower_limit,upper_limit,approve_count,reject_count FROM activity";
-(ActivityModel *)findActivityByActivityId:(NSString *)activityId
{
    static NSString * sql;
    if(sql==nil)
    {
        sql =[NSString stringWithFormat:@"%@ WHERE activity_id = ?",SQL_FIND_ACTIVITY];
    }
    return [self.db queryEntity:sql withArgument:@[activityId] forClass:[ActivityModel class]];
}

-(NSArray *)findActivities
{
    static NSString * sql;
    if(sql==nil)
    {
        //这里要order by activity_init_time 发起时间来排序，查询前20个
        sql =[NSString stringWithFormat:@"%@ LIMIT 20",SQL_FIND_ACTIVITY];
    }
    return [self.db queryEntities:sql withArgument:nil forClass:[ActivityModel class]];
}

-(NSInteger)insertActivity:(ActivityModel *)activity
{
    if([self findActivityByActivityId:activity.activityId]!=nil)
    {
        return 0;
    }
    static NSString * sql;
    if(sql==nil)
    {
        sql =@"INSERT INTO activity(activity_id, name, type, desc, image_u_r_l, open_time, close_time, lower_limit, upper_limit, approve_count, reject_count) VALUES(:activityId, :name, :type, :desc, :imageURL, :openTime, :closeTime, :lowerLimit, :upperLimit, :approveCount, :rejectCount)";
    }
    return [self.db update:sql withArgument:activity];
}
@end
