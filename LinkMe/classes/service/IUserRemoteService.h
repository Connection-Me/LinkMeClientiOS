//
//  ILoginRemoteService.h
//  LinkMe
//
//  Created by Summer Wu on 14-8-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"

@protocol IUserRemoteService <NSObject>

-(void)queryLogin:(SuccessFunction) success failure:(FailFunction) fail params:(NSDictionary*)params;
-(void)queryLoginByUsername:(NSString*)username andPassWord:(NSString*)passWord andController:(NSString*)c andMethodName:(NSString*)
methodName;

@end
