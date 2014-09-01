//
//  BaseService.h
//  LinkMe
//
//  Created by Summer Wu on 14-8-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"

typedef void (^SuccessFunction)(id data);
typedef void (^FailFunction)(id data);

@interface BaseService : NSObject

//检测网络是否可用
-(BOOL)isConnectionAvailable;
@end
