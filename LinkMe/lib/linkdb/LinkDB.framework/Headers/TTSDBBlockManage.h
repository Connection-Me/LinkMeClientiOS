//
//  TTSDBBlockManage.h
//  ttsdb
//
//  Created by Summer Wu on 14-5-15.
//  Copyright (c) 2014年 phoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HANDLE_DATA_BLOCK)(NSString * data);

@protocol TTSDBBlockManage <NSObject>

-(HANDLE_DATA_BLOCK )getHandleDataBlockByName:(NSString *)name andType:(NSString*)type andFormat:(NSString *)format;

@end
