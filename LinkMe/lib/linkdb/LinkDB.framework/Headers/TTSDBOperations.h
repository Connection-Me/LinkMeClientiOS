//
//  TTSDBOperations.h
//  ttsdb
//
//  Created by phoenix on 6/3/13.
//  Copyright (c) 2013 phoenix. All rights reserved.
//

///\file

#import <Foundation/Foundation.h>
#import "TTSDBBlockManage.h"
/**
 \brief
 The protocol declares a set of operations used in accessing database. 
 
 TTSDBOperations declares that database operations should at less provides the following three features:
 - Be able to execute SQLs, and returning the affected row or Result Set from the execution.
 - Provides approaches to handle the Result Set returned from an execution of a SQL. The term 'handle' here mainly means instantiation from data to Objects.
 - Provides a minimum set of operations to handle database transactions.
 
 The most important feature declared by TTSDBOperations is to instantiate data to objects and put objects into database. That is to handle relationship between application objects (or data) and database data. To achieve this, TTSDBOperations does the following.
 
 - Object to Data process. TTSDBOperations takes ObjC Objects as arguments and invoke them in SQL execution appropriately.
 - Data to Object process, TTSDBOperations creates TTSDBRowMapper in queries, which provides routines to instantiate data to Object.
 
 According to the aim of the operations, we could group the operations into three:
 - Operations for querying data. \n
 A query operation is particularly a 'SELECT' statement.
 Related functions are:
 \ref queryDictionaries:withArgument:
 \ref queryEntities:withArgument:forClass:
 \ref queryObjects:withArgument:forMapper:
 \ref queryDictionary:withArgument:
 \ref queryEntity:withArgument:forClass:
 \ref queryObject:withArgument:forMapper:
 
 - Operations for updating data. \n
 A update operation in a SQL that has one of statements 'UPDATE', 'INSERT' and 'DELETE', which would change the data in database. An update operation could also be operations that do not return any result set from their executions, examples could be begin, commit rollback and so on. However, it suggests to use the transaction control operations to handle this type of operations.
 Related function: \ref update:withArgument:
 
 - Operations for controlling transaction. \n
 A transaction control operation is a SQL that has one of the statements: 'BEGIN', 'COMMIT' or 'ROLLBACK' or some other operations that related to controlling the database transactions.
 Related functions are:
 \ref begin
 \ref commit
 \ref rollback
 
 According to the number of rows returned result set, we could group the query operations into two:
 - Multiple rows query \n
 A multiple rows query will instantiate the data of each row to objects and store them into a NSArray.
 Relatived functions are:
 \ref queryDictionaries:withArgument:
 \ref queryEntities:withArgument:forClass:
 \ref queryObjects:withArgument:forMapper:
 
 - Single row query \n
 A single row query will returned only one row. Usually an implementation of TTSDBOperations could do better than calling a multiple rows query function and return its first element to the user. For example, TTSDBSqliteOperations deals with single row query specially and could provides much better performance than multiple rows query. 
 However, it is still very likely to be an impact to efficiency, if user use a single row query function to handle a query, which actually returns more than one row. In such case users should confirm if they really want to handle such query by a single row query function or they could try to optimize the performance by adding 'LIMIT 0, 1' to the end of the query.
 Related functions are:
 \ref queryDictionary:withArgument:
 \ref queryEntity:withArgument:forClass:
 \ref queryObject:withArgument:forMapper:
 
 
 \note
 - TTSDBOperations dose not declare any thread handling. That mainly because of some databases (eg. SQLite) does not encourage performing thread control directly on database. TTSDBOperations suggests that to handle the threads on application level.
 - There are several optional methods in this protocol are deprecated. Deprecate protocol methods is not common, but is necessary to TTSDBOperations. That is because a concern of backward compatibility (The backward usage of this protocol even before the first completed version of ttsdb release).
 */
@protocol TTSDBOperations <NSObject>

/**
 \brief opens connection to a database
 
 \throws TTSDBConnectionException if open database fail.
 */
-(void) open;

/**
 \brief closes the connection to a database
 
 \throws TTSDBConnectionException close database fail.
 */
-(void) close;

/**
 \brief Executes a update operation to the database with the specified SQL and argument.
 
 \param sql the SQL that goin to execute.
 \param argument the argument that used in the update operation.
 \throws TTSDBException
 \throws TTSDBConnectionException if the receiver has not yet opened
 */
-(NSInteger) update:(NSString *)sql withArgument:(id) argument;


/**
 \brief Executes a qurey operation to the database with the specified SQL and argument. The Returned Result Set will be stored in to an array of NSDictionaries.
 
 \param sql the SQL that goin to execute.
 \param argument the argument that used in the update operation.
 \throws TTSDBException
 \throws TTSDBConnectionException if the receiver has not yet opened
 */
-(NSArray *) queryDictionaries:(NSString *)sql withArgument:(id)argument;

/**
 \brief Executes a qurey operation to the database with the specified SQL and argument. The Returned Result Set will be stored in to an array of objects that belone to the specified class.
 
 \param sql the SQL that goin to execute.
 \param argument the argument that used in the update operation.
 \param clazz the class that will be used when instantiate the data.
 \throws TTSDBException
 \throws TTSDBConnectionException if the receiver has not yet opened
 */
-(NSArray *) queryEntities:(NSString *)sql withArgument:(id)argument forClass:(Class) clazz;

/**
 \brief Executes a qurey operation to the database with the specified SQL and argument. The Returned Result Set will be stored in to an array of objects handle by the specified mapper.
 
 \param sql the SQL that goin to execute.
 \param argument the argument that used in the update operation.
 \param mapper the TTSDBRowMapper that will be used when instantiate the data.
 \throws TTSDBException
 \throws TTSDBConnectionException if the receiver has not yet opened
 */
-(NSArray *) queryObjects:(NSString *)sql withArgument:(id)argument forMapper:(id<TTSDBRowMapper>) mapper;

/**
 \brief Executes a qurey operation to the database with the specified SQL and argument. The first row from Returned Result Set will be instantiate to a NSDictionary.
 
 \param sql the SQL that goin to execute.
 \param argument the argument that used in the update operation.
 \throws TTSDBException
 \throws TTSDBConnectionException if the receiver has not yet opened
 \see queryDictionaries:withArgument:
 */
-(NSDictionary *) queryDictionary:(NSString *)sql withArgument:(id)argument;

/**
 \brief Executes a qurey operation to the database with the specified SQL and argument. The first row from Returned Result Set will be instansiate to an object that belones to the specified class.
 
 \param sql the SQL that goin to execute.
 \param argument the argument that used in the update operation.
 \param clazz the class that will be used when instantiate the data.
 \throws TTSDBException
 \throws TTSDBConnectionException if the receiver has not yet opened
 \see queryEntities:withArgument:forClass:
 */
-(id) queryEntity:(NSString *)sql withArgument:(id)argument forClass:(Class) clazz;

/**
 \brief Executes a qurey operation to the database with the specified SQL and argument. The first row from Returned Result Set will be instansiate to an object that handle by the specified mapper.
 
 \param sql the SQL that goin to execute.
 \param argument the argument that used in the update operation.
 \param mapper the TTSDBRowMapper that will be used when instantiate the data.
 \throws TTSDBException
 \throws TTSDBConnectionException if the receiver has not yet opened
 \see queryObjects:withArgument:forMapper:
 */
-(id) queryObject:(NSString *)sql withArgument:(id)argument forMapper:(id<TTSDBRowMapper>) mapper;


/**
 \brief Executes batch qurey/update operations to the database with the specified sql xml and argument. The xml sql return will be instansiate to an NSObject
 
 \param xmlName an specifiy xml format contain one ore more query/update sqls, it will find xml in bundle folder
 \param arguments the argument that used to run the sqls
 \throws TTSDBException
 \throws TTSDBConnectionException if the receiver has not yet opened
 \see queryObjects:withArgument:forMapper:
 */

-(NSObject *) executeSPXML:(NSString *)xmlName withDictionary:(NSDictionary*)arguments inDBBM:(id<TTSDBBlockManage>) dbbm;

/**
 \brief Executes batch qurey/update operations to the database with the specified sql xml and argument. The xml sql return will be instansiate to an NSObject
 
 \param xmlName an specifiy xml format contain one ore more query/update sqls, it will find the xml in tmp folder
 \param arguments the argument that used to run the sqls
 \throws TTSDBException
 \throws TTSDBConnectionException if the receiver has not yet opened
 \see queryObjects:withArgument:forMapper:
 */
-(NSObject *) executeStorageSPXML:(NSString *)xmlPath withDictionary:(NSDictionary*)arguments inDBBM:(id<TTSDBBlockManage>) dbbm;

/**
 \brief Begin a transation
 
 \throws TTSDBException
 \throws TTSDBConnectionException if the receiver has not yet opened
 */
-(void) begin;

/**
 \brief Commit a transation
 
 \throws TTSDBException
 \throws TTSDBConnectionException if the receiver has not yet opened
 */
-(void) commit;

/**
 \brief Rollback a transation
 
 \throws TTSDBException
 \throws TTSDBConnectionException if the receiver has not yet opened
 */
-(void) rollback;


#pragma mark ----deprecated methods

@optional
/**
 \brief open a connection to a database with the specified filePath.
 \deprecated This method is too specific. It is only be able to adapt the situation that a database, which is identify by a physical file. Use \ref TTSDBOperations::open instead
 \sa TTSDBOperations::open
 */
-(void) open:(NSString *)filePath TTSDB_AVAILABLE_BUT_DEPRECATED;

/**
 \brief Executes a qurey operation to the database with the specified SQL and argument. The Returned Result Set will be stored in to an array of objects that belone to the specified class.
 
 \deprecated The signature is ambiguous. Use \ref queryEntities:withArgument:forClass: instead.
 */
-(NSArray*) query:(NSString *)sql withArgument:(id)argument forClass:(Class) clazz TTSDB_AVAILABLE_BUT_DEPRECATED;

/**
 \brief Executes a qurey operation to the database with the specified SQL and argument. The Returned Result Set will be stored in to an array of objects handle by the specified mapper.
 
 \deprecated The signature is ambiguous. Use \ref queryObjects:withArgument:forMapper: instead.
 */
-(NSArray*) query:(NSString *)sql withArgument:(id)argument forMapper:(id<TTSDBRowMapper>) mapper TTSDB_AVAILABLE_BUT_DEPRECATED;


/**
 \brief Executes a qurey operation to the database with the specified SQL and argument. The first row from Returned Result Set will be instansiate to an object that handle by the specified mapper.
 
 \deprecated The signature is ambiguous. Use \ref queryObject:withArgument:forMapper: instead.
 */
-(id) queryEntity:(NSString *)sql withArgument:(id)argument forMapper:(id<TTSDBRowMapper>) mapper TTSDB_AVAILABLE_BUT_DEPRECATED;
@end






