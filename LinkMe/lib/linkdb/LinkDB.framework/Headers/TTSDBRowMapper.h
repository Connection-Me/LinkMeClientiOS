//
//  TTSDBRowMapper.h
//  ttsdb
//
//  Created by phoenix on 6/3/13.
//  Copyright (c) 2013 phoenix. All rights reserved.
//

///\file

#import <Foundation/Foundation.h>
/**
 TTSDBRowMapper processes database a row of the Result Set and instantiate the data to produce Objective-C obejct.
 */
@protocol TTSDBRowMapper <NSObject>

/**
 Maps a row to a object (instantiation) according to the given resultSet.
 \param resultSet holds the qurey information of the current processing row and some information about the query. TTSDBResultSet contains a collection of infomation that may need to be used for instantiation.
 */
-(id) mapRow:(id<TTSDBResultSet>)resultSet;
@end
