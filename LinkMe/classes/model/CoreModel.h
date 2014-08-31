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

AS_SINGLETON(CoreModel)
AS_STATIC_PROPERTY(serverURL)

@end
