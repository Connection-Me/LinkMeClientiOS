//
//  TTSDBSqliteOperations.h
//  ttsdb
//
//  Created by Jerry on 3/6/13.
//  Copyright (c) 2013 phoenix. All rights reserved.
//

///\file

#import <Foundation/Foundation.h>

/**
 TTSDBSqliteOperations is a SQLite implemtation of TTSDBOperations. 
 */
@interface TTSDBSqliteOperations : NSObject<TTSDBOperations>

/**
  \brief Retrieves the SQLite file path that this operations connected to.
 */
@property (nonatomic, readonly) NSString *dbPath;

/**
  \brief Retrieves the flags that this operations used at the time it connected a SQLite.
 */
@property (nonatomic, readonly) int flags;

/**
 \brief Gets or sets the trace switch.
 
 Gets or sets the trace switch. If trace is on, TTSDBSqliteOperations will print information about its communication between the database. That generally including but not limit to:
 - The SQL used in the comunication.
 - The parameter used in the comunication.
 */
@property (nonatomic) BOOL traceON;

/**
 \brief Initializes a TTSDBSqliteOperations instance by the specified SQLite file path and by other default settings.
 
 This initializer initializes the instance by using the \ref initWithDBFilePath:flags:traceON: function. The default settings are as following:
 - flags SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE
 - traceON NO
 
 \param dbPath the path to the SQLite file that latter on will connect to.
 \see initWithDBFilePath:flags:traceON:
 */
-(id)initWithDBFilePath:(NSString *)dbPath;

/**
 \brief Initializes a TTSDBSqliteOperations instance by the specified SQLite file path, the flag and the trace setting.
 
 \param dbPath the path to the SQLite file that latter on will connect to.
 \param flags the open flags will be used while connect to the database. Please refer to the definition of SQLite open flags: http://www.sqlite.org/c3ref/open.html
 */
-(id)initWithDBFilePath:(NSString *)dbPath flags:(int)flags traceON:(BOOL)traceNO;


/**
 \brief Default initializer
 
 \deprecated WILL throws TTSDBException. In order to avoid change of the setting of connection after already connected to a database. Most of the setting of connection is done at initialization. Therefore, default initializer is meaningless.
 \throws TTSDBException
 \see initWithDBFilePath:
 \see initWithDBFilePath:flags:traceON:
 */
-(id)init __attribute__((deprecated));  //avoid to use
@end

