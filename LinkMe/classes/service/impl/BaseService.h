//
//  BaseService.h
//  LinkMe
//
//  Created by Summer Wu on 14-8-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"
#import "CoreModel.h"

typedef void (^SuccessFunction)(id data);
typedef void (^FailFunction)(id data);
#define CHECK_NETWORK_AND_SEND_START_BEE(event) \
FOREGROUND_BEGIN \
[self postNotification:event withObject:nil];\
FOREGROUND_COMMIT \
BOOL isConnectAvailable = [self isConnectionAvailable];\
if (!isConnectAvailable) \
{\
    FOREGROUND_BEGIN \
    [self postNotification:NetWorkEvent.NEWWORK_UNREACHABLE];\
    FOREGROUND_COMMIT \
}else\




@interface BaseService : NSObject

//检测网络是否可用
-(BOOL)isConnectionAvailable;
@end
