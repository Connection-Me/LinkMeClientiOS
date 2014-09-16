//
//  HomeRemoteServiceImpl.m
//  LinkMe
//
//  Created by Summer Wu on 14-9-1.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "HomeRemoteServiceImpl.h"
#import "NetWorkEvent.h"
#import "RequestMethod.h"
#import "HomeEvent.h"
#import "CoreModel.h"
#import "ActivityModel.h"
#import "CoreDao.h"

@implementation HomeRemoteServiceImpl
DEF_SINGLETON(HomeRemoteServiceImpl)
#define TEST_URL @"http://love-petpet.u.qiniudn.com/linkMetest5.json"

-(void)loadLocalActivity
{
    NSArray *localActivities = [[CoreDao sharedInstance].homeDao findActivities];
    [self postNotification:HomeEvent.LOAD_LOCAL_ACTIVITY withObject:localActivities];
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
       [self postNotification:HomeEvent.LOAD_ACTIVITY_START withObject:nil];
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
                [self postNotification:HomeEvent.LOAD_ACTIVITY_SUCCESS withObject:activityArray];
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
                [self postNotification:HomeEvent.LOAD_ACTIVITY_FAILED];
                FOREGROUND_COMMIT
            }
            
        }];
        [request setFailedBlock:^{
            NSError *error = [blockRequest error];
            FOREGROUND_BEGIN
            [self postNotification:HomeEvent.LOAD_ACTIVITY_FAILED];
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
    
    CHECK_NETWORK_AND_SEND_START_BEE(HomeEvent.ADD_ACTIVITY_START){
        //TODO
        NSString *urlString = [[CoreModel sharedInstance].serverURL stringByAppendingString:@""];//拼接请求路径
        NSURL *url = [NSURL URLWithString:urlString];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        NSSet *jsonSet = [activityModel propertiesForJson];
        NSString *jsonString = [NSString stringWithFormat:@"%@",jsonSet];
        NSLog(@"jsonString == %@",jsonString);
        
        [request appendPostData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
        request.requestMethod = RequestMethod.POST;
        __block ASIHTTPRequest * blockRequest = request;
        request.delegate = self;
        [request setCompletionBlock:^{
            //tips:use [request responseString] and [request responseData] to fetch the responseString/responseData
            NSInteger code = blockRequest.responseStatusCode;
            //responseString 是服务器返回的数据
            NSString * responseString = blockRequest.responseString;
            
            //成功
            if (code == 200) {
                FOREGROUND_BEGIN
                [self postNotification:HomeEvent.ADD_ACTIVITY_SUCCESS];
                FOREGROUND_COMMIT
            }
            else
            {
                FOREGROUND_BEGIN
                [self postNotification:HomeEvent.ADD_ACTIVITY_FAILED];
                FOREGROUND_COMMIT
            }
            
        }];
        //请求失败
        [request setFailedBlock:^{
            NSError *error = [blockRequest error];
            FOREGROUND_BEGIN
            [self postNotification:HomeEvent.ADD_ACTIVITY_FAILED];
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

@end
