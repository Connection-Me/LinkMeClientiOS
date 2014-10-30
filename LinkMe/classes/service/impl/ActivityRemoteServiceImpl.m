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
-(void)queryHomeActivity
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
//        NSString *urlString = [[CoreModel sharedInstance].serverURL stringByAppendingString:@""];//拼接请求路径
        
        NSString *urlString = TEST_URL;
        NSURL *url = [NSURL URLWithString:urlString];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        NSMutableDictionary * postParams = [[NSMutableDictionary alloc] init];
        //请求的json
//        [postParams setObject:username forKey:@"userName"];
//        [postParams setObject:c forKey:@"controller"];
//        [postParams setObject:methodName forKey:@"methodName"];
        NSString * jsonString = [postParams JSONString];
        NSLog(@"the request jsonString == %@",jsonString);
        
        [request appendPostData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
        request.requestMethod = RequestMethod.POST;
        __block ASIHTTPRequest * blockRequest = request;
        request.delegate = self;
        [request setCompletionBlock:^{
            //tips:use [request responseString] and [request responseData] to fetch the responseString/responseData
            NSInteger code = blockRequest.responseStatusCode;
            //responseString 是服务器返回的数据
            NSString * responseString = blockRequest.responseString;
            NSLog(@"<HomeRemoteServiceImpl> responeString is %@",responseString);
            
            NSDictionary *responseDic = [responseString objectFromJSONString];
            if (code == 200) {
                NSArray * activityList = [responseDic objectForKey:@"resultList"];
                FOREGROUND_BEGIN
                NSArray * activityArray = [ActivityModel modelWithJsonArray:activityList];
                [self postNotification:ActivityEvent.LOAD_ACTIVITY_SUCCESS withObject:activityArray];
                for(ActivityModel *activity in activityArray)
                {
                    activity.activityId = activity.imageURL;
                    [[CoreDao sharedInstance].homeDao insertActivity:activity];
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
        
        request.timeOutSeconds = 60.0;
        
        [request setPostValue:[CoreModel sharedInstance].token forKey:@"sessionId"];
        [request setPostValue:activityModel.name forKey:@"name"];
        [request setPostValue:activityModel.type forKey:@"type"];
        [request setPostValue:activityModel.desc forKey:@"description"];
        [request setPostValue:activityModel.imageURL forKey:@"picture"];
        [request setPostValue:[NSNumber numberWithInt: activityModel.lowerLimit]forKey:@"lowerLimit"];
        [request setPostValue:[NSNumber numberWithInt: activityModel.upperLimit] forKey:@"upperLimit"];
        [request setPostValue:activityModel.openTime forKey:@"openTime"];
        [request setPostValue:activityModel.closeTime forKey:@"closeTime"];
        [request setPostValue:activityModel.startTime forKey:@"startTime"];
        [request setPostValue:activityModel.endTime forKey:@"endTime"];
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
                    [self postNotification:ActivityEvent.ADD_ACTIVITY_SUCCESS];
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
