//
//  CommendRemoteServiceImpl.m
//  LinkMe
//
//  Created by Summer Wu on 14-11-22.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "CommendRemoteServiceImpl.h"
#import "NetWorkEvent.h"
#import "RequestMethod.h"
#import "CommendEvent.h"
#import "HobbyModel.h"
#import "UserModel.h"
#import "ActivityModel.h"

@implementation CommendRemoteServiceImpl
DEF_SINGLETON(CommendRemoteServiceImpl)

-(void)queryCommendUsersBy:(HobbyModel *)hobbyModel andOffset:(NSInteger)offset andLimit:(NSInteger)limit
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
        [self postNotification:CommendEvent.LOAD_APP_COMMEND_START withObject:nil];
        FOREGROUND_COMMIT
        //TODO
        //        NSString *urlString = [[CoreModel sharedInstance].serverURL stringByAppendingString:@""];//拼接请求路径
        
        NSString *urlString = [[CoreModel sharedInstance].serverURL stringByAppendingString:@""];
        NSURL *url = [NSURL URLWithString:urlString];
        
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        request.timeOutSeconds = 30.0;
        request.shouldAttemptPersistentConnection   = NO;
        [request setPostValue:[CoreModel sharedInstance].token forKey:@"sessionId"];
        [request setPostValue:@"user" forKey:@"c"];
        [request setPostValue:@"recommend" forKey:@"a"];
        [request setPostValue:[NSNumber numberWithInteger: hobbyModel.hid] forKey:@"hobby"];
        [request setPostValue:[NSNumber numberWithInteger: offset] forKey:@"offset"];
        [request setPostValue:[NSNumber numberWithInteger: limit] forKey:@"limit"];
        
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
                FOREGROUND_BEGIN
                if ([[responseDic objectForKey:@"result_code"] longValue] == 0) {
                    NSArray *dataDic = [[responseDic objectForKey:@"data"] objectFromJSONString];
                    NSArray  *dataArray = [UserModel modelWithJsonArray:dataDic];
                    [self postNotification:CommendEvent.LOAD_APP_COMMEND_SUCCESS withObject:dataArray];
                }
                else
                {
                    [self postNotification:CommendEvent.LOAD_APP_COMMEND_FAILED];
                }
                FOREGROUND_COMMIT
            }
            else
            {
                FOREGROUND_BEGIN
                [self postNotification:CommendEvent.LOAD_APP_COMMEND_FAILED];
                FOREGROUND_COMMIT
            }
            
        }];
        [request setFailedBlock:^{
            NSError *error = [blockRequest error];
            FOREGROUND_BEGIN
            [self postNotification:CommendEvent.LOAD_APP_COMMEND_FAILED];
            FOREGROUND_COMMIT
            NSLog(@"error = %@",error);
        }];
        [request startAsynchronous];
    }
}

-(void)sendInviteToFriendsByUsers:(NSArray *)users andActivity:(ActivityModel *)activity andWay:(NSString *)way
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
        [self postNotification:CommendEvent.SEND_INVITE_START withObject:nil];
        FOREGROUND_COMMIT
        //TODO
        //        NSString *urlString = [[CoreModel sharedInstance].serverURL stringByAppendingString:@""];//拼接请求路径
        
        NSString *urlString = [[CoreModel sharedInstance].serverURL stringByAppendingString:@""];
        NSURL *url = [NSURL URLWithString:urlString];
        
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        request.timeOutSeconds = 30.0;
        request.shouldAttemptPersistentConnection   = NO;
        [request setPostValue:[CoreModel sharedInstance].token forKey:@"sessionId"];
        [request setPostValue:@"activity" forKey:@"c"];
        [request setPostValue:@"invite" forKey:@"a"];
        [request setPostValue:[self parseUsers:users] forKey:@"inviteUser"];
        [request setPostValue:way forKey:@"way"];
        [request setPostValue:activity.activityId forKey:@"aid"];
        
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
            NSString *result_msg = [responseDic objectForKey:@"result_msg"];
            if (code == 200) {
                FOREGROUND_BEGIN
                if ([[responseDic objectForKey:@"result_code"] longValue] == 0) {
                    [self postNotification:CommendEvent.SEND_INVITE_SUCCESS withObject:result_msg];
                }
                else
                {
                    [self postNotification:CommendEvent.SEND_INVITE_FAILED];
                }
                FOREGROUND_COMMIT
            }
            else
            {
                FOREGROUND_BEGIN
                [self postNotification:CommendEvent.SEND_INVITE_FAILED];
                FOREGROUND_COMMIT
            }
            
        }];
        [request setFailedBlock:^{
            NSError *error = [blockRequest error];
            FOREGROUND_BEGIN
            [self postNotification:CommendEvent.SEND_INVITE_FAILED];
            FOREGROUND_COMMIT
            NSLog(@"error = %@",error);
        }];
        [request startAsynchronous];
    }
}
-(NSString*)parseUsers:(NSArray*)users
{
    NSString *returnUsers = @"";
    int i;
    for (i=0; i<users.count-1;i++) {
        UserModel *userModel =(UserModel*)[users objectAtIndex:i];
        [returnUsers stringByAppendingString:userModel.uid];
        [returnUsers stringByAppendingString:@","];
    }
    UserModel *userModel =(UserModel*)[users objectAtIndex:i];
    [returnUsers stringByAppendingString:userModel.uid];
    return returnUsers;
}

@end
