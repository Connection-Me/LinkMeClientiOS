//
//  CoreModel.h
//  LinkMe
//
//  Created by Summer Wu on 14-8-26.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"

@interface CoreModel : NSObject

@property(strong,nonatomic) NSString * token;

//为了load主界面数据时区分todo,doing,done,定义一个全局变量来标记此刻要load的类型；这里是暂时的解决办法；
@property(strong,nonatomic) NSString * whenActivities;

AS_SINGLETON(CoreModel)
AS_STATIC_PROPERTY(serverURL)

@end
