//
//  LibModel.h
//  LinkMe
//
//  Created by Summer Wu on 14-9-1.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bee.h"

@interface LibModel : NSObject

+ (id)modelWithJson:(NSDictionary *)json;
+ (NSArray *)modelWithJsonArray:(NSArray *)array;

- (NSSet *)propertiesForJson;

- (NSDictionary *)propertiesMap;

- (NSDictionary *)propertyClassMap;

- (void)loadFromJson:(NSDictionary *)json;

- (void)writeToJson:(NSMutableDictionary *)json;

- (void)writeProperty:(NSString *)prop toJson:(NSMutableDictionary *)json;

- (void)beforeWrite;

- (void)afterLoaded;

- (void)setup;

- (NSDictionary *) json;

@end

@interface NSArray(LibModel)

-(NSString *) libJSON;

@end
