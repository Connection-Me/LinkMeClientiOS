//
//  TTSDBException.h
//  ttsdb
//
//  Created by Jerry on 25/4/13.
//  Copyright (c) 2013 Jerry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <tts_msg/tts_msg.h>

#undef __TTS_MSG_HEAD_TITLE
#define __TTS_MSG_HEAD_TITLE "TTSDB"

///\file

/**
 An exception that is raised when an error occurs during access database.
 */
@interface TTSDBConnectionException : NSException
@end


/**
 An exception that is raised when an error occurs on the connection to the database.
 */
@interface TTSDBSQLException : NSException
@end


/**
 An exception that is raised when an error occurs on the process of DB Changes to the database.
 */
@interface TTSDBChangeException : NSException
@end


/**
 An exception that is raised when an error occurs becuase of concurrency issue.
 */
@interface TTSDBConcurrencyException : NSException
@end

/**
 An exception that is raised when an error occurs becuase of xml sp.
 */
@interface TTSDBXmlSpException : NSException
@end


