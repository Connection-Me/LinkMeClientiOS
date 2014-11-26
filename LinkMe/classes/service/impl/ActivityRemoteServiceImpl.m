//
//  HomeRemoteServiceImpl.m
//  LinkMe
//
//  Created by Summer Wu on 14-9-1.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "ActivityRemoteServiceImpl.h"
#import "NetWorkEvent.h"
#import "RequestMethod.h"
#import "ActivityEvent.h"
#import "ActivityModel.h"
#import "CoreDao.h"
#import "UserEvent.h"

@implementation ActivityRemoteServiceImpl
DEF_SINGLETON(ActivityRemoteServiceImpl)
#define TEST_URL @"http://love-petpet.u.qiniudn.com/linkMetest5.json"

-(void)loadLocalActivity
{
    NSArray *localActivities = [[CoreDao sharedInstance].homeDao findActivities];
    [self postNotification:ActivityEvent.LOAD_LOCAL_ACTIVITY withObject:localActivities];
}
-(void)queryHomeActivity:(NSInteger)offset andLimit:(NSInteger)limit andWay:(NSString *)way andWhen:(NSString *)when
{
    BOOL isConnectAvailable = [self isConnectionAvailable];
    if (!isConnectAvailable)
    {
        FOREGROUND_BEGIN
        [self postNotification:NetWorkEvent.NEWWORK_UNREACHABLE];
        [self loadLocalActivity];
        FOREGROUND_COMMIT
    }else
   {
       FOREGROUND_BEGIN
       [self postNotification:ActivityEvent.LOAD_ACTIVITY_START withObject:nil];
       FOREGROUND_COMMIT
        //TODO
        NSString *urlString = [[CoreModel sharedInstance].serverURL stringByAppendingString:@""];//拼接请求路径
        
       // NSString *urlString = TEST_URL;
        NSURL *url = [NSURL URLWithString:urlString];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
       request.timeOutSeconds = 10.0;
       request.shouldAttemptPersistentConnection   = NO;
       [request setPostValue:[CoreModel sharedInstance].token forKey:@"sessionId"];
       [request setPostValue:[NSNumber numberWithInt:offset] forKey:@"offset"];
       [request setPostValue:[NSNumber numberWithInt:limit] forKey:@"limit"];
       [request setPostValue:way forKey:@"way"];
       [request setPostValue:when forKey:@"when"];
       [request setPostValue:@"activity" forKey:@"c"];
       [request setPostValue:@"showList" forKey:@"a"];
       
        request.requestMethod = RequestMethod.POST;
        __block ASIFormDataRequest * blockRequest = request;
        request.delegate = self;
        [request setCompletionBlock:^{
            //tips:use [request responseString] and [request responseData] to fetch the responseString/responseData
            NSInteger code = blockRequest.responseStatusCode;
            //responseString 是服务器返回的数据
            NSString * responseString = blockRequest.responseString;
            NSLog(@"<HomeRemoteServiceImpl> responeString is %@",responseString);
            
            NSDictionary *dic = [responseString objectFromJSONString];
            if (code == 200) {
                FOREGROUND_BEGIN
                if ([[dic objectForKey:@"result_code"] longValue] == 10005) {
                    [self postNotification:UserEvent.USER_NOT_FOUND];
                }
                else if([[dic objectForKey:@"result_code"] longValue] == 0)
                {
                    NSDictionary *data = [[dic objectForKey:@"data"] objectFromJSONString];
                    NSArray * activityList = [data objectForKey:@"activityList"];
                    NSArray * activityArray = [ActivityModel modelWithJsonArray:activityList];
                    for(ActivityModel *activity in activityArray)
                    {
                        [[CoreDao sharedInstance].homeDao insertActivity:activity];
                    }
                    [self postNotification:ActivityEvent.LOAD_ACTIVITY_SUCCESS withObject:activityArray];
                }
                FOREGROUND_COMMIT
            }
            else
            {
                FOREGROUND_BEGIN
                [self postNotification:ActivityEvent.LOAD_ACTIVITY_FAILED];
                FOREGROUND_COMMIT
            }
            
        }];
        [request setFailedBlock:^{
            NSError *error = [blockRequest error];
            FOREGROUND_BEGIN
            [self postNotification:ActivityEvent.LOAD_ACTIVITY_FAILED];
            FOREGROUND_COMMIT
            NSLog(@"error = %@",error);
        }];
        [request setBytesSentBlock:^(unsigned long long size, unsigned long long total)
         {
             if(total>0 && size>0)
             {
                 NSNumber * progress = @(0);
                 unsigned long long sentBytes = [blockRequest totalBytesSent];
                 progress = [NSNumber numberWithFloat: ((double)sentBytes)/ total];
             }
         }];
        [request setBytesReceivedBlock:^(unsigned long long size, unsigned long long total) {
            if(total>0 && size>0)
            {
                NSNumber * progress = @(0);
                unsigned long long sentBytes = [blockRequest totalBytesSent];
                progress = [NSNumber numberWithFloat: ((double)sentBytes)/ total];
            }
            
        }];
        [request startAsynchronous];
    }
}

//新建活动
-(void)addActivityByActivityModel:(ActivityModel *)activityModel{
    
    CHECK_NETWORK_AND_SEND_START_BEE(ActivityEvent.ADD_ACTIVITY_START){
        //TODO
        NSString *urlString = [[CoreModel sharedInstance].serverURL stringByAppendingString:@""];//拼接请求路径
        NSURL *url = [NSURL URLWithString:urlString];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        request.shouldAttemptPersistentConnection   = NO;
        request.showAccurateProgress = YES;
        request.timeOutSeconds = 10.0;
        
        [request setPostValue:[CoreModel sharedInstance].token forKey:@"sessionId"];
        [request setPostValue:activityModel.name forKey:@"name"];
        [request setPostValue:@"" forKey:@"type"];
        [request setPostValue:activityModel.desc forKey:@"description"];
        [request setPostValue:activityModel.imageURL forKey:@"picture"];
        [request setPostValue:[NSNumber numberWithInt: activityModel.lowerLimit]forKey:@"lowerLimit"];
        [request setPostValue:[NSNumber numberWithInt: activityModel.upperLimit] forKey:@"upperLimit"];
        [request setPostValue:[NSNumber numberWithDouble:activityModel.openTime] forKey:@"openTime"];
        [request setPostValue:[NSNumber numberWithDouble:activityModel.closeTime] forKey:@"closeTime"];
        [request setPostValue:[NSNumber numberWithDouble:activityModel.startTime] forKey:@"startTime"];
        [request setPostValue:[NSNumber numberWithDouble:activityModel.stopTime] forKey:@"endTime"];
        [request setPostValue:@"activity" forKey:@"c"];
        [request setPostValue:@"create" forKey:@"a"];
        request.requestMethod = RequestMethod.POST;
        __block ASIFormDataRequest * blockRequest = request;
        request.delegate = self;
        [request setCompletionBlock:^{
            //tips:use [request responseString] and [request responseData] to fetch the responseString/responseData
            NSInteger code = blockRequest.responseStatusCode;
            //responseString 是服务器返回的数据
            NSString * responseString = blockRequest.responseString;
            NSMutableDictionary * dic = [responseString objectFromJSONString];
            //成功
            if (code == 200) {
                FOREGROUND_BEGIN
                if ([[dic objectForKey:@"result_code"] longValue] == 10005) {
                    [self postNotification:UserEvent.USER_NOT_FOUND];
                }
                else if([[dic objectForKey:@"result_code"] longValue] == 0)
                {
                    NSDictionary *aidDic = [[dic objectForKey:@"data"] objectFromJSONString];
                    NSNumber *aid = [aidDic objectForKey:@"aid"];
                    activityModel.activityId = [NSString stringWithFormat:@"%d",[aid integerValue]];
                    [self postNotification:ActivityEvent.ADD_ACTIVITY_SUCCESS withObject:activityModel];
                }
                FOREGROUND_COMMIT
            }
            else
            {
                FOREGROUND_BEGIN
                [self postNotification:ActivityEvent.ADD_ACTIVITY_FAILED];
                FOREGROUND_COMMIT
            }
            
        }];
        //请求失败
        [request setFailedBlock:^{
            NSError *error = [blockRequest error];
            FOREGROUND_BEGIN
            [self postNotification:ActivityEvent.ADD_ACTIVITY_FAILED];
            FOREGROUND_COMMIT
            NSLog(@"error = %@",error);
        }];
        [request startAsynchronous];
    }
    
}

@end
