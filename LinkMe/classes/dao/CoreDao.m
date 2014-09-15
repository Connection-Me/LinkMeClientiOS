//
//  CoreDao.m
//  LinkMe
//
//  Created by Summer Wu on 14-9-10.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "CoreDao.h"
#import "summer_extend.h"
#import "HomeDaoImpl.h"

@implementation CoreDao{
    TTSDBSqliteOperations *_db;
    NSConditionLock * _transLock;
}
DEF_SINGLETON(CoreDao)
@synthesize db=_db;
-(NSString*) dbPath
{
    _transLock = [[NSConditionLock alloc] init];
    NSString *pathDB;
    pathDB = [LINK_APP_DOCUMENT_PATH stringByAppendingPathComponent:TTSDB_DEFAULT_DATABASE_NAME];
    return pathDB;
}

-(NSBundle *)bundle
{
    return nil;
}

-(void) initDatabase
{
    NSString *pathDB = [self dbPath];
    _db = [[TTSDBSqliteOperations alloc] initWithDBFilePath:pathDB];
    [_db open];
#ifdef DEBUG
    _db.traceON = YES;
#endif
    [[TTSDBManager defaultManager] database:_db initializeWithBundle:self.bundle];
}

-(void)initDaos
{
    _homeDao = [[HomeDaoImpl alloc] initWithDBHandler:self];
}

-(id)init{
    if(self = [super init]){
        [self initDatabase];
        [self initDaos];
    }
    return self;
}

-(void)dealloc{
    [_db close];
}

-(id<TTSDBOperations>)db{
    return self;
}

-(void) open{
    //nothing to do
}

-(void) close{
    //nothing to do
}

-(NSInteger) update:(NSString *)sql withArgument:(id) argument{
    @synchronized(_db){
        return [_db update:sql withArgument:argument];
    }
}

-(NSArray *) queryDictionaries:(NSString *)sql withArgument:(id)argument{
    @synchronized(_db){
        return [_db queryDictionaries:sql withArgument:argument];
    }
}

-(NSArray *) queryEntities:(NSString *)sql withArgument:(id)argument forClass:(Class) clazz{
    @synchronized(_db){
        return [_db queryEntities:sql withArgument:argument forClass:clazz];
    }
}

-(NSArray *) queryObjects:(NSString *)sql withArgument:(id)argument forMapper:(id<TTSDBRowMapper>) mapper{
    @synchronized(_db){
        return [_db queryObjects:sql withArgument:argument forMapper:mapper];
    }
}

-(NSDictionary *) queryDictionary:(NSString *)sql withArgument:(id)argument{
    @synchronized(_db){
        return [_db queryDictionary:sql withArgument:argument];
    }
}

-(id) queryEntity:(NSString *)sql withArgument:(id)argument forClass:(Class) clazz{
    @synchronized(_db){
        return [_db queryEntity:sql withArgument:argument forClass:clazz];
    }
}

-(id) queryObject:(NSString *)sql withArgument:(id)argument forMapper:(id<TTSDBRowMapper>) mapper{
    @synchronized(_db){
        return [_db queryObject:sql withArgument:argument forMapper:mapper];
    }
}

-(void) begin{
    //[_transLock lockWhenCondition:YES];
    @synchronized(_db){
        return [_db begin];
    }
}

-(void) commit{
    //[_transLock unlockWithCondition:YES];
    @synchronized(_db){
        [_db commit];
    }
}

-(void) rollback{
    //[_transLock unlockWithCondition:YES];
    @synchronized(_db){
        [_db rollback];
    }
}




#pragma mark==== deprecated
-(NSArray *)query:(NSString *)sql withArgument:(id)argument forClass:(Class)clazz{
    @synchronized(_db){
        return [_db query:sql withArgument:argument forClass:clazz];
    }
}

-(id)queryEntity:(NSString *)sql withArgument:(id)argument forMapper:(id<TTSDBRowMapper>)mapper{
    @synchronized(_db){
        return [_db queryEntity:sql withArgument:argument forMapper:mapper];
    }
}

#pragma mark 可执行xml，模拟存储过程
-(id)executeSPXML:(NSString *)spXMLName withDictionary:(id)dictionary inDBBM:(id<TTSDBBlockManage>)dbbm {
    @synchronized(_db){
        return [_db executeSPXML:spXMLName withDictionary:dictionary inDBBM:dbbm];
    }
}

-(id)executeStorageSPXML:(NSString *)xmlPath withDictionary:(id)dictionary inDBBM:(id<TTSDBBlockManage>)dbbm {
    @synchronized(_db){
        return [_db executeStorageSPXML:xmlPath withDictionary:dictionary inDBBM:dbbm];
    }
}

@end
