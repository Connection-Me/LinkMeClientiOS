//
//  TTSDBSingleColumnMapper.h
//  ttsdb
//
//  Created by Jerry on 3/6/13.
//  Copyright (c) 2013 phoenix. All rights reserved.
//

///\file

/**
 TTSDBSingleColumnMapper is an implementation of TTSDBRowMapper, which tries to map the first column of Returned Result Set to an object. The Mapper convert the data according to the type of the column defined in database. The rules the mapper used in covertion addressed as following:
 - if column's decltype is defined as 'DATETIME' in database, then the data will convert to NSDate
 - if column's decltype is defined as 'BLOB' in database, then the data will convert to NSData
 - if column's decltype is defined as 'TEXT' in database, then the data will convert to NSString
 - if column's decltype is defined as any numeric types (such 'INTEGER', 'NUMBER') in database, then the data will convert to NSNumber
 
 \see TTSDBRowMapper
 \see TTSDBOperations::queryObject:withArgument:forMapper:
 \see TTSDBOperations::queryObjects:withArgument:forMapper:
 */
@interface TTSDBSingleColumnMapper : NSObject<TTSDBRowMapper>
+(TTSDBSingleColumnMapper *)mapper;
@end
