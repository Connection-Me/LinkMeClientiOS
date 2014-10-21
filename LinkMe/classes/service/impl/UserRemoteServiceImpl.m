//
//  LoginRemoteServiceImpl.m
//  LinkMe
//
//  Created by Summer Wu on 14-8-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "UserRemoteServiceImpl.h"
#import "UserEvent.h"
#import "NetWorkEvent.h"
#import "RequestMethod.h"
#import "StaticVar.h"

@implementation UserRemoteServiceImpl
DEF_SINGLETON(UserRemoteServiceImpl)

-(void)queryLogin:(SuccessFunction)success failure:(FailFunction)fail params:(NSDictionary *)params
{
    
}

//登陆
#define LOGIN_PASS 0
#define LOGIN_UNREGISTER 10002
#define LOGIN_WRONG_PASSWORD 10001
-(void)queryLoginByUsername:(NSString*)username andPassWord:(NSString*)passWord andController:(NSString*)c andMethodName:(NSString*)methodName
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
       [self postNotification:UserEvent.LOGIN withObject:nil];
       FOREGROUND_COMMIT
        NSString *urlString = [[CoreModel sharedInstance].serverURL stringByAppendingString:@""];
       //拼接请求路径
        NSURL *url = [NSURL URLWithString:urlString];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
       request.showAccurateProgress = YES;
       request.timeOutSeconds = 60.0;
       [request setPostValue:username forKey:@"userName"];
       [request setPostValue:passWord forKey:@"userPass"];
       [request setPostValue:c forKey:@"c"];
       [request setPostValue:methodName forKey:@"a"];
        //请求的json
        request.requestMethod = RequestMethod.POST;
     //  [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
        __block ASIFormDataRequest * blockRequest = request;
        request.delegate = self;
        [request setCompletionBlock:^{
            //tips:use [request responseString] and [request responseData] to fetch the responseString/responseData
            NSInteger code = blockRequest.responseStatusCode;
            //responseString 是服务器s返回的数据
            NSString * responseString = blockRequest.responseString;
            NSMutableDictionary * dic = [responseString objectFromJSONString];
            NSLog(@"%@",[dic objectForKey:@"result_code"]);
            if (code == 200) {
                FOREGROUND_BEGIN
                
                if([[dic objectForKey:@"result_code"] longValue] == LOGIN_UNREGISTER){
                    [self postNotification:UserEvent.LOGIN_FAILED_USER_NOT_EXISTED];
                }
                else if([[dic objectForKey:@"result_code"] longValue] == LOGIN_WRONG_PASSWORD){
                    [self postNotification:UserEvent.LOGIN_FAILED_PASS_ERROR];
                }else if([[dic objectForKey:@"result_code"] longValue] == LOGIN_PASS){
                    
                    [self setTokenToModel:dic];
                    [self postNotification:UserEvent.LOGIN_SUCCESS];
                    
                    
                    
                }
                FOREGROUND_COMMIT
            }
            else
            {
                FOREGROUND_BEGIN
                [self postNotification:UserEvent.LOGIN_FAILED];
                FOREGROUND_COMMIT
            }
            
        }];
        [request setFailedBlock:^{
            NSError *error = [blockRequest error];
            FOREGROUND_BEGIN
           [self postNotification:UserEvent.LOGIN_FAILED];
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
//注册
-(void)queryRegisterByUserName:(NSString*)username andPassWord:(NSString*)passWord andController:(NSString*)c andMethodName:(NSString*)methodName {
    
    FOREGROUND_BEGIN
    [self postNotification:UserEvent.REGISTER withObject:nil];
    FOREGROUND_COMMIT
    BOOL isConnectAvailable = [self isConnectionAvailable];
    if (!isConnectAvailable)
    {
        FOREGROUND_BEGIN
        [self postNotification:NetWorkEvent.NEWWORK_UNREACHABLE];
        FOREGROUND_COMMIT
    }else{
        NSString *urlString = [[CoreModel sharedInstance].serverURL stringByAppendingString:@""];//拼接请求路径
        NSURL *url = [NSURL URLWithString:urlString];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
       
        request.showAccurateProgress = YES;
        request.timeOutSeconds = 60.0;
        [request setPostValue:username forKey:@"userName"];
        [request setPostValue:passWord forKey:@"userPass"];
        [request setPostValue:c forKey:@"c"];
        [request setPostValue:methodName forKey:@"a"];
        //请求的json
        request.requestMethod = RequestMethod.POST;
        __block ASIFormDataRequest * blockRequest = request;
        request.delegate = self;
        [request setCompletionBlock:^{
            //tips:use [request responseString] and [request responseData] to fetch the responseString/responseData
            NSInteger code = blockRequest.responseStatusCode;
            //responseString 是服务器返回的数据
            NSString * responseString = blockRequest.responseString;
            NSMutableDictionary * dic = [responseString objectFromJSONString];
            if (code == 200) {
                FOREGROUND_BEGIN
                if ([[dic objectForKey:@"result_code"] longValue] == 10003) {
                    
                    [self postNotification: UserEvent.REGISTER_FAILED_INFO_ERROR];
                }
                else if([[dic objectForKey:@"result_code"] longValue] == 10004){
                    
                    [self postNotification: UserEvent.REGISTER_FAILED_EXISTED];
                }
                else if([[dic objectForKey:@"result_code"] longValue] == 0){
            
                    [self postNotification:UserEvent.REGISTER_SUCCESS];
                }
                FOREGROUND_COMMIT
            }
            else
            {
                FOREGROUND_BEGIN
                [self postNotification:UserEvent.REGISTER_FAILED];
                FOREGROUND_COMMIT
            }
            
        }];
        [request setFailedBlock:^{
            NSError *error = [blockRequest error];
            FOREGROUND_BEGIN
            [self postNotification:UserEvent.REGISTER_FAILED];
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

-(void)setTokenToModel:(NSDictionary *)dic{
    
    
    if([dic objectForKey:@"data"]==nil){
        NSLog(@"the dic has not the data key");
        return ;
    }
    NSDictionary *data = [[dic objectForKey:@"data"] objectFromJSONString];
    //存储token
    CoreModel *coreModel = [CoreModel sharedInstance];
    [coreModel setToken:[data objectForKey:@"session_id"]];
}

@end
