//
//  DetailRemoteServiceImpl.m
//  LinkMe
//
//  Created by Summer Wu on 14-10-11.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "DetailRemoteServiceImpl.h"
#import "DetailEvent.h"
#import "NetWorkEvent.h"
#import "RequestMethod.h"
#import "ActivityModel.h"

#define TEST_URL @"http://love-petpet.u.qiniudn.com/linkMetest5.json"

@implementation DetailRemoteServiceImpl
DEF_SINGLETON(DetailRemoteServiceImpl)

-(void)queryDetailActivityByActivityId:(NSString *)activityId
{
    BOOL isConnectAvailable = [self isConnectionAvailable];
    if (!isConnectAvailable)
    {
        FOREGROUND_BEGIN
        [self postNotification:NetWorkEvent.NEWWORK_UNREACHABLE];
        FOREGROUND_COMMIT
    }else
    {
        FOREGROUND_BEGIN
        [self postNotification:DetailEvent.LOAD_DETAIL_ACTIVITY_START withObject:nil];
        FOREGROUND_COMMIT
        //TODO
        //        NSString *urlString = [[CoreModel sharedInstance].serverURL stringByAppendingString:@""];//拼接请求路径
        
        NSString *urlString = [[CoreModel sharedInstance].serverURL stringByAppendingString:@""];
        NSURL *url = [NSURL URLWithString:urlString];
        
//        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//        NSMutableDictionary * postParams = [[NSMutableDictionary alloc] init];
//        //请求的json
//        [postParams setObject:@"showDetail" forKey:@"a"];
//        [postParams setObject:@"activity" forKey:@"c"];
//        [postParams setObject:activityId forKey:@"aid"];
//        [postParams setObject:[CoreModel sharedInstance].token forKey:@"sessionId"];
//        NSString * jsonString = [postParams JSONString];
//        NSLog(@"the request jsonString == %@",jsonString);
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        request.timeOutSeconds = 30.0;
        
        [request setPostValue:[CoreModel sharedInstance].token forKey:@"sessionId"];
        [request setPostValue:@"activity" forKey:@"c"];
        [request setPostValue:@"showDetail" forKey:@"a"];
        [request setPostValue:activityId forKey:@"aid"];
        
//        [request appendPostData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
        request.requestMethod = RequestMethod.POST;
        __block ASIHTTPRequest * blockRequest = request;
        request.delegate = self;
        [request setCompletionBlock:^{
            //tips:use [request responseString] and [request responseData] to fetch the responseString/responseData
            NSInteger code = blockRequest.responseStatusCode;
            //responseString 是服务器返回的数据
            NSString * responseString = blockRequest.responseString;
            NSLog(@"<DetailRemoteServiceImpl> responeString is %@",responseString);
            
            NSDictionary *responseDic = [responseString objectFromJSONString];
            if (code == 200) {
                NSDictionary  * result = [responseDic objectForKey:@"result"];
                ActivityModel *activityModel = [ActivityModel modelWithJson:result];
                FOREGROUND_BEGIN
                [self postNotification:DetailEvent.LOAD_DETAIL_ACTIVITY_SUCCESS withObject:activityModel];
                FOREGROUND_COMMIT
            }
            else
            {
                FOREGROUND_BEGIN
                [self postNotification:DetailEvent.LOAD_DETAIL_ACTIVITY_FAILED];
                FOREGROUND_COMMIT
            }
            
        }];
        [request setFailedBlock:^{
            NSError *error = [blockRequest error];
            FOREGROUND_BEGIN
            [self postNotification:DetailEvent.LOAD_DETAIL_ACTIVITY_FAILED];
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
