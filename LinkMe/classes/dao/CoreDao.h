//
//  CoreDao.h
//  LinkMe
//
//  Created by Summer Wu on 14-9-10.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <linkdb/ttsdb.h>
#import "Bee.h"
#import "IHomeDao.h"

@interface CoreDao : NSObject<TTSDBOperations>
AS_SINGLETON(CoreDao)

-(NSString *) dbPath;
-(NSBundle *) bundle;
-(void) initDatabase;
-(void) initDaos;
@property (nonatomic, readonly) id<TTSDBOperations> db;

@property (nonatomic, readonly) id<IHomeDao> homeDao;


@end
