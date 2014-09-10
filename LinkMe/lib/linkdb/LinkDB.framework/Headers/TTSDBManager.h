//
//  TTSDBManager.h
//  ttsdb
//
//  Created by Jerry on 3/6/13.
//  Copyright (c) 2013 phoenix. All rights reserved.
//

///\file

extern NSString *const TTSDB_DEFAULT_DATABASE_NAME;

/**
 \brief TTSDBManager will apply actions defined in dbchange file.
 
 A dbchange file is a xml file, which holds the actions that going to perform in to the database. Following is an example of content of a dbchange file:
 \code
 <?xml version="1.0" encoding="UTF-8"?>
 <sql>
     <statement>
     CREATE TABLE employee
     (
         employee_id TEXT,
         primary_manager_id TEXT,
         dob DATETIME,
         first_name TEXT,
         last_name TEXT,
         salary NUMERIC,
         is_manager INTEGER NOT NULL DEFAULT 0,
         phone_number INTEGER,
         image BLOB,
         CONSTRAINT PK_eval_perform PRIMARY KEY (employee_id),
         CONSTRAINT FK_eval_perform_user_access FOREIGN KEY (primary_manager_id)
         REFERENCES employee(employee_id)
     )
     </statement>
     <statement>INSERT INTO "employee" VALUES ("e0001","e0001",strftime('%s', '1988-02-05'),"john","lennon","10000","1","98765432", null)</statement>
     <statement>INSERT INTO "employee" VALUES ("e0002","e0001",strftime('%s', '1976-11-03'),"god","hevean","8877.66","0","0", null)</statement>
     <statement>INSERT INTO "employee" VALUES ("e0003",null, strftime('%s', '1967-04-21'),"bob","sky",125.23,1,"55555555", null);</statement>
     <statement>INSERT INTO "employee" VALUES ("e0004",null, strftime('%s', '1967-04-21'),"candy","love",null, 0,"55555555", null);</statement>
 </sql>
 \endcode
 */
@interface TTSDBManager : NSObject
/**
 \brief Returns defaultManager. User should always use this method to get the shared TTSDBManager instance.
 */
+(TTSDBManager *)defaultManager;

/**
 \brief Initializes the given db by the given array of dbchange paths.
 
 \param db the database, which going to process.
 \param dbchanges an array of dbchange files
 */
-(void)database:(id<TTSDBOperations>)db initializeWithDBChanges:(NSArray *)dbchanges;

/**
 \brief Initialize the given db by dbchange files in the given bundle.
 
 \param db the database, which going to process.
 \param bundleOrNil a bundle, which containing the dbchange files. If this argument is nil, then main bundle is used.
 */
-(void)database:(id<TTSDBOperations>)db initializeWithBundle:(NSBundle *)bundleOrNil;

//deprecated method
/**
 \brief initializes the database by default settings.
 
 \deprecated This method looks general, compatible to be used. However, it is very specific.
 There is no hint to the method what type of db operations it need to use; how
 to initial the db operation; how to connect the operations to the db and so on.
 Therefore, the implementation of this method actually had to use a particular
 type of db operations and use particular procedure to connect it to the db.
 
 Although this could save a lot of code, it reduce the compatibility.
 */
+(id<TTSDBOperations>)initializeDB TTSDB_AVAILABLE_BUT_DEPRECATED;
@end
