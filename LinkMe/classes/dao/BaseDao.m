//
//  BaseDao.m
//  LinkMe
//
//  Created by Summer Wu on 14-9-10.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "BaseDao.h"

@implementation BaseDao{
    id<TTSDBOperations> _db;
}

-(id)initWithDBHandler:(id<TTSDBOperations>)db
{
    self = [super init];
    if (self) {
        _db = db;
    }
    return self;
}

@end
