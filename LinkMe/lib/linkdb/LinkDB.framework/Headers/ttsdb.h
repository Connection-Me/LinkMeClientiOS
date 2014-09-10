//
//  ttsdb.h
//  ttsdb
//
//  Created by Jerry on 24/4/13.
//  Copyright (c) 2013 Jerry. All rights reserved.
//

///\file


/**
 \mainpage 
 The ttsdb framework provides functionalities on accessing database. In specific the framework provides the following features:
 1. Declare TTSDBOperations, which is a set of operations for accessing database and a solution to handle the relationship between data and objects.
 2. TTSDBSqliteOperations, which is an implementation of TTSDBOperations to SQLite.
 3. TTSDBManager, which is a set of utilities for processing DB-Changes.

 <h1> Usage </h1>
 ttsdb helps user on using it for process database change files or do normal database routines. Following gives a brief introduction on how to use ttsdb. Although the framework defined a general purpose protocol, there is only one implementation to the protocol and it works with SQLite database, which is the only embedded database available in iOS devices.
 <h3> Create DB operation </h3>
 In order to use ttsdb, you first need to create a database operation instance. The following code demonstrates how to create a SQLite DB operation instance.
 \code
 NSArray *paths;
 NSString *dbPath;
 TTSDBSqliteOperations *db;
 
 if ((paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)).count > 0) {
     dbPath = [((NSString *)[paths objectAtIndex:0]) stringByAppendingPathComponent:fileName];  //create a path the dababase.
     db = [[TTSDBSqliteOperations alloc] initWithDBFilePath:dbPath];
     [db open];
 }
 \endcode
 
 TTSDBSqliteOperations provides you TTSDBSqliteOperations::initWithDBFilePath: and TTSDBSqliteOperations::initWithDBFilePath:flags:traceON: methods to create its instance. The only thing that you MUST provide is the path to the database and an open flag. However, the returned instance is one that has not yet connectted to the database. The instance will not connect to the database unless the user invokes the TTSDBOperations::open method. Use an operation instance not yet connected to query or update database will raise an TTSDBConnectionException.
 
 The TTSDBSqliteOperations::initWithDBFilePath: method use a default open flag SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE. The flag argument not only used for specify the open mode but also controls the threading strategy. (More information in the section of 'DB thread programming' below). To understand the open flag please refer to the official document on opening SQLite data: http://www.sqlite.org/c3ref/open.html .
 
 TTSDBSqliteOperations also allows you to trace the process of the execution. To do the trace, you could either set the traceNO parameter at initial or configure the property TTSDBSqliteOperations::traceON at runtime.
 
 <h3> End DB operation </h3>
 A robust MUST close any opened database connection before it terminates. The database operations, which not going to use any more should also be closed. An operation could be close by simply call the TTSDBOperations::close method.
 
 \note Both TTSDBOperations::open and TTSDBOperations::close may raise TTSDBConnectionException in case of failure.
 
 <h3> Statement binding </h3>
 Just like many other rational database, SQLite provides statement binding mechanism. With this technique user is allowed to prepare statement like following, and later substitute the desired value to the '?' marking at runtime:
 \code 
 SELECT * FROM t1 WHERE clm > ? AND clm < ?
 \endcode
 The API of tts_db concerns about this statement binding. Query and Update methods are has a parameter named 'argument' with type of ObjC id. This argument is used for statement binding. The TTSDBOperations update and query functions could perform three types of binding.
 - Ordered binding from NSArray. If user provides a NSArray, then the operations will try to bind the items from the array to the statement in order. The statement MUST in template of '?' or sth equivalent.
 - Named binding by dictionary. If user provides a NSDictionary, then the operations will try to bind the value from the dictionary to the statement according to their key. The statement MUST in template of ':' or sth equivalent.
 - Named binding by value object. If user provides a Objective-C object, then the operations will try to bind the properties from the object to the statement according to their name. The statement MUST in template of ':' or sth equivalent.
 
 \code
 //a piece of code to show how statement binding works
 <id>TTSDBOperations db;
 
 //array binding:
 [db update:@"SELECT * FROM t1 WHERE clm > ? AND clm < ?" withArgument:@[@(0), @(10)];
 
 //dictionary binding:
 [db update:@"SELECT * FROM t1 WHERE clm > :lowerBound AND clm < :upperBound" withArgument:@{@"lowerBound" : @(0), @"upperBound" : @(10)}];
 
 //value object binding:
 id obj;    // suppose has properties 'lowerBound' and 'upperBound'
 obj.lowerBound = 0;
 obj.upperBound = 10;
 [db update:@"SELECT * FROM t1 WHERE clm > :lowerBound AND clm < :upperBound" withArgument:obj];
 \endcode
 
 For more information about the native statement binding technique of SQLite, please refer to: http://www.sqlite.org/c3ref/bind_blob.html .
 
 To understand statement binding, you also need know about the conversion between data types of application and the data types of database. For more information about type handling, please refer to section 'Data Type of SQLite' at below of this document.
 \note Database column namings MUST be underline-naming, and application naming (either dictionary keys or properties of object) MUST be camel-naming. TTSDBSqliteOperations did conversion of the namings.
 
 <h3> Update database </h3>
 To make change to the data in the database, you will need to use the method TTSDBOperations::update:withArgument:. You make use the function to insert, update or delete data in database. The method will try to execute the SQL and return nothing exception the number of rows affected by the execution of the SQL. If there is anything goes wrong, an exception will raise. Sample code could be found in the above section.
 
 <h3> Query database </h3>
 To query a database, you may use one of the following:  \n
 \ref queryDictionaries:withArgument: \n
 \ref queryEntities:withArgument:forClass: \n
 \ref queryObjects:withArgument:forMapper: \n
 \ref queryDictionary:withArgument: \n
 \ref queryEntity:withArgument:forClass: \n
 \ref queryObject:withArgument:forMapper: \n
 
 All these methods are for query data form database and store/convert them to some kind of ObjC object or ObjC collections. For detail of the usage please refer to documentation of the TTSDBOperations protocol.
 
 <h3> Transactions </h3>
 TTSDBOperations::begin follows a TTSDBOperations::commit or TTSDBOperations::rollback is a transaction enclosures. Invoke TTSDBOperations::update:withArgument: outside of transaction enclosures will force the effect be automatically committed to the database. In contrast, the effect will not be automatically committed if do the update inside of an enclosure. The total effect will either committed or rollback when the enclosure end. \n
 Transaction is  data is a very expensive process. SQLite could do up to thousands of INSERT per second. However it could only do some dozens of transaction (addressed by http://www.sqlite.org/faq.html#q19 ). Therefore frequently and continuously updates should be enclosed in transaction.
 
 <h3> DBManager </h3>
 DB-Change file is a xml file that containing a set of SQL statements, which is formed in certain format. The DBManager is a utility to execute the SQLs in side of a set of DB-Change files. To use DBManager, you could do either of the following:
 <b> Excecute an array of DB-Change files </b>\n
 Provide an array, which stores the paths to the DB-Change files. The files will be executed one by one according to the array index.
 \code
 id<TTSDBOperation> db;
 NSString *path1, *path2;
 
 //execute the DB-Change files of an array.
 [[TTSDBManager defaultManager] database:db initializeWithDBChanges:@[path1, path2]];
 \endcode
 <b> Excecute a bundle that contains DB-Change files </b>\n
 Provide a bundle, which contains the DB-Change files and confirm to the following execution rule.
 - The routine first tries to execute the SQL statement: "SELECT param_value FROM conf_general WHERE param_name='DB_VERSION'", which may returns an integer as used 'version number'.
 - The routine considers a xml file named in a pattern of 'DBCHG_#.xml' is a DB-Change file, where '#' marking represents pattern of positive integer number and used as the order number of the DB-Change file. 
 - The files will be sorted by their order number and be filtered according to the condition "whether the order number is greatter than the version number". If the condition is true, then the DB-Change file is remained, otherwise it will be filtered.
 - The remaining list will than form an array and is invoked by TTSDBManager::database:initializeWithDBChanges: method.
 
 \code
 id<TTSDBOperation> db;
 NSBundle *bundle;
 
 [[TTSDBManager defaultManager] database:db initializeWithBundle:bundle];
 \endcode
 <h1> DB thread programming </h1>
 SQLite 3 supports multiple thread access and so does ttsdb. This section only gives a brief idea on how to do multi-thread programming with ttsdb. To do real thread safe programming with SQLite, you MUST understand the mechanism of its threading strategies:\n
 <i>
 Lock technique used by SQLite: http://sqlite.org/lockingv3.html \n
 Thread safe issue about SQLite: http://www.sqlite.org/threadsafe.html \n
 Thread strategy used by SQLite: http://www.sqlite.org/cvstrac/wiki?p=MultiThreading \n
 Transaction technique used by SQLite: http://www.sqlite.org/lang_transaction.html \n
 Overall description on SQLite-Muti-Threading: http://www.keakon.net/2011/10/25/SQLite%E5%9C%A8%E5%A4%9A%E7%BA%BF%E7%A8%8B%E7%8E%AF%E5%A2%83%E4%B8%8B%E7%9A%84%E5%BA%94%E7%94%A8 \n
 </i>
 
 <h3> Thread safe? </h3>
 SQLite 3 is generally thread-safe. Actually it seems there are some features not in the case, but very limited and ttsdb does not use any of those.
 
 <h3> How to do parallel access SQLite? </h3>
 Each TTSDBSqliteOperations instance maintains a sqlite3 object (SQLite DB object). TTSDBSqliteOperations::initWithDBFilePath: initialize itself to willing to open a connection in 'Multi-thread' mode. You could choose 'Serialized' mode if you provid 'SQLITE_OPEN_FULLMUTEX' flag to TTSDBSqliteOperations::initWithDBFilePath:flags:traceON:. However, 'Single-thread' is not possible, since iOS's sqlite library compiled in thread mode of 'Multi-thread'. \n
 Serialized mode as addressed in official document is fully thread safe by enable all database lock. Therefore, parallel access of database will result in one blocks the later ones. Execution will be one by one. Therefore, this will not allow parallel access. \n
 Multi-thread mode allows parallel access database. However, each connection could be accessed by one thread at a time. If connection Accessed by multiple threads at the same time, a database error will raise (raise EXC_BAD_ACCESS error). To be specific, an error will occurs when bind or step a statement, if the execute before previous transaction completes or before all previous statements are finalized (or reset). \n
 Parallel access is not possible in single database object, but possible when create multiple database objects. Therefore, to do parallel access, you just need to create multiple TTSDBSqliteOperations objects and use them parallel.
 \code
 id db1, db2;
 id dbPath;

 db1 = [[TTSDBSqliteOperations alloc] initWithDBFilePath:dbPath];
 db2 = [[TTSDBSqliteOperations alloc] initWithDBFilePath:dbPath];
 
 //you could then use them in parallel.
 ...
 \endcode
 
 <h3> When to do parallel access? </h3>
 The official documentation addressed that: <i>"If your application has a need for a lot of concurrency, then you should consider using a client/server database. But experience suggests that most applications need much less concurrency than their designers imagine"</i>. And this is very true for iOS development. Actually the efficiency of current ttsdb is sufficient good. It could execute 24 DB-Changes, which contains more than 5000 SQLs and some are 'INSERT INTO x (BY) SELECT * FROM y' SQLs (each of they create about 1000 INSERTs in the test) in about 4 seconds with real iPad2 machine. The only case in practice (the iOS projects done by my Phoenix before July, 2013) may require database concurrency is an app has a background service, which needs to access database (the Churchs' OER project). However, the best solution for this kind of background service may be to allow the database be blocked for a while, if the service does not take long (and usually not long), but not try to do concurrency. Here I strongly suggest to block rather then parallel access.
 
 <h3> Limited supported? </h3>
 Unlike SQLite native interface, the current version of ttsdb provides very limited support to parallel access. The thing ttsdb will do is to raise TTSDBConcurrencyException when database is blocked. User could choose retry or other strategy to handle this problem. Later version of ttsdb may need to support timeout or other handling strategy.
 
 <h1> Compatibility Issues </h1>
 ttsdb has many versions and many of them are not version controlled. For those version-controlled ttsdb (since 1.0.1) may introduce several compatibility issues to the older projects depend on ttsdb. The issues mainly presented at the time creating TTSDBSqliteOperations objects, process DB-Changes and execute query statements.
 
 <h3>Construction of TTSDBSqliteOperations </h3>
 The previous ttsdb (before 1.0.0) construct TTSDBSqliteOperations object by method \ref TTSDBOperations::open:, which is now deprecated and removed. In order to construct TTSDBSqliteOperations object, you need to use \ref TTSDBSqliteOperations::open as addressed in the 'Usage' section

 <h3> Process DB-Change </h3>
 The previous ttsdb (before 1.0.0) Process DB-Changes by:
 \code
 [TTSDBManager initializeDB];
 \endcode
 
 However, although ttsdb still allow user to use \ref initializeDB to process DB-Changes, it is now deprecated. New versions of ttsdb suggest user to use TTSDBManager::database:initializeWithDBChanges: or TTSDBManager::database:initializeWithBundle: to process DB-Change files.
 \code
 id<TTSDBOperations> myDB;
 NSString *pathChange1, *pathChange2;
 
 [[TTSDBManager defaultManager] database:myDB initializeWithBundle:[NSBundle mainBundle]];
 //or
 [[TTSDBManager defaultManager] database:myDB initializeWithDBChanges:@[pathChange1, pathChange2]];
 \endcode
 
 <h3> The deprecated query functions </h3>
 New ttsdb versions deprecate those query methods with ambiguous naming and introduce new query method. The deprecated query methods are still available, but not encouraged.
 
 <h1> Data Type of SQLite </h1>
 <h3> SQLite types </h3>
 SQLite is strong typing and dynamic typing database. To achieve this two feature, SQLite introduce two important concepts about typing, which are the declared type and the cell data type. SQLite allow its users to declare the type of column just the same as most of the rational databases do. However, the declared type is likely to be usedd as a hint for storing data. SQLite try its best to store data in the declared type, but the data stored into the database need not confirm to declared type and every cell has its cell data type. This is sum-up as follow by the official document (http://www.sqlite.org/c3ref/column_decltype.html):\n
 <i> SQLite uses dynamic run-time typing. So just because a column is declared to contain a particular type does not mean that the data stored in that column is of the declared type. SQLite is strongly typed, but the typing is dynamic not static. Type is associated with individual values, not with the containers used to hold those values.</i>
 To be specific, suppose we have the following table:
 \code
 CREATE TABLE t1
 (
     clmn    TEXT
 )
 \endcode
 There is nothing wrong to the following statement (try insert number to a column declared in TEXT type)
 \code
 INSERT INTO t1 (clmn) VALUES (1)
 \endcode
 
 There are 5 basic cell data type, which are: INTEGER, FLOAT, TEXT, BLOB and NULL. On the other hand, there is no specific restriction to the declared type of columns. However, SQLite would analyze the declared type and try to guess what basic type it should be if there is no explicit hint during the operation storing data (if there is a hint, SQLite will use it instead).
 
 <h3> Data binding and instantiation of data </h3>
 <b><i> Data binding </i></b>
 Data binding is about binding object to SQL statements. TTSDBSqliteOperations do the data binding according to the following rules:
 - Bind text. If the type of target object is NSString, then bind the object as TEXT
 - Bind integer. If the type of the target is NSNumber, then bind the object as INTEGER or FLOAT
 - Bind null. If the target is nil, then bind the object as NULL
 - Bind date. If the type of the target is NSDate, then bind the object as FLOAT (number that represent the seconds from the reference date, 1 January 1970)
 - Bind data. If the type of the target is NSData, then bind the object as BLOB.
 - Bind others. If the type of the target is in any of the above, then the object is bind as TEXT by calling the -description method of the object.
 
 <b><i> Instantiation </i></b>
 Five basic types is enough for database purpose but may not sufficient to application purpose. Therefore, TTSDBSqliteOperations provide a bit more effort on data instantiation.
 The decl-types (declared types) understood by TTSDBSqliteOperations are: 
 \code
 TEXT, INTEGER, NUMERIC, DATETIME, BLOB and REAL
 \endcode. This types will be convert to
 \code
 NSString, NSNumber, NSNumber, NSDate, NSData and NSNumber
 \endcode
 respectively. Columns declared in other type-names will not be understood by TTSDBSqliteOperations and will process them by their basic type.
 
 \note
 According to the SQLite's time function 'strftime(...)' the basic type of DATETIME could be TEXT, INTEGER, FLOAT and NULL. A NULL-DATETIME is just a null value; a TEXT-DATETIME must be a string in format of 'yyyy-MM-dd hh:mm:ss'; a INTEGER-DATETIME is a whole number that represent the seconds from the reference date, 1 January 1970, GMT. However, the case FLOAT-DATETIME is a float point represent the Julian Day, which is the number of days since noon in Greenwich on November 24, 4714 B.C.. The Default process of FLOAT-DATETIME is not common and TTSDBSqliteOperations handle the FLOAT-DATETIME the same as INTEGER-DATETIME, which is more common in recent datetime processing. Detail about strftime(...): http://www.sqlite.org/lang_datefunc.html 
 
 <b><i> Conversion between scalars and NSNumber </i></b>
 TTSDBSqliteOperations allow binding objects other from NSString, NSNumber, NSDate and NSData, and allow instantiate data to types other than those object. This is done by the Objective-C KVC technic. TTSDBSqliteOperations could automatically convert the SQLite basic types and corresponding ObjC types and bind them to or read them out by look into the properties of the object. However, the ObjC types are not include the scalar types. A scalar types is type in bool, char, short, int, long, float double and any convertible to NSNumber. TTSDBSqliteOperations will do the scalar-NSNumber conversion automatically when it is needed.
 \note
 However, TTSDBSqliteOperations DOES NOT directly support types other from ObjC objects and scalar types. If these types is required, the coversion process must be handle by the user themsleve. For example, you may store a c-struct by first cover it into NSData.
 More detail about data types in SQLite, please refer to http://www.sqlite.org/datatype3.html
 
 
 <h1> Dependence </h1>
 ttsdb depends on tts_msg version 0.0.4 or higher.
 
 <h1> Version History </h1>
 <b>1.0.0</b>
 - Initial version.
 
 <b>1.0.1</b>
 - Document the framework.
 - Remove class TTSDBStatementInfo and introduce TTSDBResultSet.
 The original TTSDBRowMapper make use of TTSDBStatementInfo and the newer versions will use of TTSDBResultSet instead.
 - Introduce dependence to tts_msg (first version of tts_msg 0.0.3). Defined \ref TTSDBConnectionException \ref TTSDBSQLException and \ref TTSDBChangeException.
 - Changed and optimized the mapping routine. 
 The previous version caches the part of statement information by the mapper. In this version ttsdb try to cache as much information as possible at the time preparing statement and so fewer work for row mappers to handle.
 
 <b>1.1.1</b>
 - Remove dependence on TTSThrow and TTSThrowA macros. Use @@throw TTSException and @@throw TTSExceptionA instead.
 - Change upgrade dependence from tts_msg_0.0.3 to tts_msg_0.0.4
 - Introduce \ref TTSDBConcurrencyException to TTSDBSqliteOperations
 
 
 \version 1.1.1
 
 \author Jiaming HUANG
*/


#import <Foundation/Foundation.h>
#import <sqlite3.h>

/**
 Mark ttsdb methods that may available but deprecated.
 */
#define TTSDB_AVAILABLE_BUT_DEPRECATED __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA, __MAC_NA, __IPHONE_2_0, __IPHONE_2_0)


#import "TTSDBResultSet.h"
#import "TTSDBRowMapper.h"
#import "TTSDBOperations.h"
#import "TTSDBSqliteOperations.h"
#import "TTSDBManager.h"
#import "TTSDBSingleColumnMapper.h"
#import "TTSDBException.h"
#import "TTSDBBlockManage.h"





