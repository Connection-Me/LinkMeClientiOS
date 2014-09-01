//
//  LoginRemoteServiceImpl.m
//  LinkMe
//
//  Created by Summer Wu on 14-8-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "UserRemoteServiceImpl.h"
#import "LoginEvent.h"
#import "NetWorkEvent.h"
#import "CoreModel.h"
#import "RequestMethod.h"

@implementation UserRemoteServiceImpl
DEF_SINGLETON(UserRemoteServiceImpl)

-(void)queryLogin:(SuccessFunction)success failure:(FailFunction)fail params:(NSDictionary *)params
{
    
}
//登陆
-(void)queryLoginByUsername:(NSString*)username andPassWord:(NSString*)passWord andController:(NSString*)c andMethodName:(NSString*)methodName
{
    FOREGROUND_BEGIN
    [self postNotification:LoginEvent.LOGIN withObject:nil];
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
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        NSMutableDictionary * postParams = [[NSMutableDictionary alloc] init];
        //请求的json
        [postParams setObject:username forKey:@"userName"];
        [postParams setObject:passWord forKey:@"passWord"];
        [postParams setObject:c forKey:@"controller"];
        [postParams setObject:methodName forKey:@"methodName"];
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
            if (code == 200) {
                FOREGROUND_BEGIN
                [self postNotification:LoginEvent.LOGIN_SUCCESS];
                FOREGROUND_COMMIT
            }
            else
            {
                FOREGROUND_BEGIN
                [self postNotification:LoginEvent.LOGIN_FAILED];
                FOREGROUND_COMMIT
            }
            
        }];
        [request setFailedBlock:^{
            NSError *error = [blockRequest error];
            FOREGROUND_BEGIN
            [self postNotification:LoginEvent.LOGIN_FAILED];
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
    [self postNotification:LoginEvent.LOGIN withObject:nil];
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
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        NSMutableDictionary * postParams = [[NSMutableDictionary alloc] init];
        [postParams setObject:username forKey:@"userName"];
        [postParams setObject:passWord forKey:@"passWord"];
        [postParams setObject:c forKey:@"controller"];
        [postParams setObject:methodName forKey:@"methodName"];
        //请求的json
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
            if (code == 200) {
                FOREGROUND_BEGIN
                [self postNotification:LoginEvent.REGISTER_SUCCESS];
                FOREGROUND_COMMIT
            }
            else
            {
                FOREGROUND_BEGIN
                [self postNotification:LoginEvent.REGISTER_FAILED];
                FOREGROUND_COMMIT
            }
            
        }];
        [request setFailedBlock:^{
            NSError *error = [blockRequest error];
            FOREGROUND_BEGIN
            [self postNotification:LoginEvent.REGISTER_FAILED];
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
        [request setCompletionBlock:^{
           //TODO 接收服务端返回的json
            
            
            
        }];
        [request startAsynchronous];
    }
    
    
    
}

@end
