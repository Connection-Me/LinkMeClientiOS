//
//  BaseDao.h
//  LinkMe
//
//  Created by Summer Wu on 14-9-10.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <linkdb/ttsdb.h>

@interface BaseDao : NSObject
-(id) initWithDBHandler:(id<TTSDBOperations>)db;
@property (nonatomic, readonly) id<TTSDBOperations> db;

@end
