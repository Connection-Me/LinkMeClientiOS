//
//  LibModel.m
//  LinkMe
//
//  Created by Summer Wu on 14-9-1.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "LibModel.h"

static NSString const *CLASS_KEY = @"__class";


@implementation LibModel

+ (id)modelWithJson:(NSDictionary *)json {
    LibModel *model = [[self alloc] init];
    [model loadFromJson:json];
#if !__has_feature(objc_arc)
    return [model autorelease];
#else
    return model;
#endif
}

+(NSArray *)modelWithJsonArray:(NSArray *)array {
    NSMutableArray *list = [NSMutableArray array];
    if ([array isKindOfClass:[NSArray class]]&&array.count){
        for (NSDictionary *dict in array){
            [list addObject:[self modelWithJson:dict]];
        }
    }
    return [NSArray arrayWithArray:list];
}

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    [self setup];
    return self;
}

- (void)setup {
    
}

- (NSSet *)propertiesForJson {
    return [NSSet set];
}

-(NSDictionary *) propertiesMap{
    return nil;
}

-(NSDictionary *) propertyClassMap{
    return nil;
}


- (void)loadProperty:(NSString *)prop with:(NSString *)p fromJson:(NSDictionary *)json {
    if (![json.allKeys containsObject:p]) {
        return;
    }
    id value = [json objectForKey:p];
    if ([value isKindOfClass:[NSArray class]]) {
        BOOL flag = NO;
        NSMutableArray *list = [NSMutableArray array];
        for (id v in value) {
            if ([v isKindOfClass:[NSDictionary class]]) {
                NSString *c = [v objectForKey:CLASS_KEY];
                if (!c){
                    c = [[self propertyClassMap] objectForKey:prop];
                }
                if (c){
                    Class clazz = NSClassFromString(c);
                    if (clazz) {
                        LibModel *obj = [[clazz alloc] init];
                        [obj loadFromJson:v];
                        [list addObject:obj];
#if !__has_feature(objc_arc)
                        [obj release];
#endif
                    }
                } else {
                    [list addObject:v];
                }
            } else {
                flag = YES;
                break;
            }
        }
        if (flag) {
            [self setValue:value forKey:prop];
        } else {
            [self setValue:list forKey:prop];
        }
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        NSString *c = [value objectForKey:CLASS_KEY];
        if (!c){
            c = [[self propertyClassMap] objectForKey:prop];
        }
        Class clazz = NSClassFromString(c);
        if (clazz) {
            LibModel *obj = [[clazz alloc] init];
            [obj loadFromJson:value];
            [self setValue:obj forKey:prop];
#if !__has_feature(objc_arc)
            [obj release];
#endif
        }
    } else {
        if (![value isKindOfClass:[NSNull class]]) {
            [self setValue:value forKey:prop];
        }
    }
}

- (void)writeProperty:(NSString *)prop toJson:(NSMutableDictionary *)json {
    id value = [self valueForKey:prop];
    if (!value)
        return;
    NSString *key = prop;
    NSDictionary *map = self.propertiesMap;
    if ([map.allKeys containsObject:prop]){
        NSString *s = [map objectForKey:prop];
        if (s.length){
            key = s;
        }
    }
    if ([value isKindOfClass:[NSArray class]]) {
        BOOL flag = NO;
        NSMutableArray *list = [NSMutableArray array];
        for (id v in value) {
            if (![v isKindOfClass:[LibModel class]]) {
                flag = YES;
                break;
            }
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            LibModel *model = v;
            [model writeToJson:dict];
            [list addObject:dict];
        }
        if (flag) {
            [json setObject:value forKey:key];
        } else {
            [json setObject:list forKey:key];
        }
    } else if ([value isKindOfClass:[LibModel class]]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        LibModel *model = value;
        [model writeToJson:dict];
        [json setObject:dict forKey:key];
    } else {
        [json setObject:value forKey:key];
    }
}

- (void)loadFromJson:(NSDictionary *)json {
    NSSet *set = [self propertiesForJson];
    NSDictionary *map = [self propertiesMap];
    NSString *prop = nil;
    for (prop in set) {
        NSString *p = [map objectForKey:prop];
        if (!p){
            p = prop;
        }
        [self loadProperty:prop with:p fromJson:json];
    }
    [self afterLoaded];
}

- (void)writeToJson:(NSMutableDictionary *)json {
    [self beforeWrite];
    NSSet *set = [self propertiesForJson];
    NSString *prop = nil;
    for (prop in set) {
        [self writeProperty:prop toJson:json];
    }
    //    [json setObject:NSStringFromClass([self class]) forKey:CLASS_KEY];
}

- (void)beforeWrite {
    
}

- (void)afterLoaded {
    
}

-(NSDictionary*) json{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [self writeToJson:dict];
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end

@implementation NSArray (LibModel)

//-(NSString*) libJSON{
//    NSMutableArray *list = [NSMutableArray array];
//    for (id obj in self) {
//        if ([obj isKindOfClass:[LibModel class]]) {
//            LibModel *model = obj;
//            [list addObject:[model json]];
//        }
//    }
//    return [list JSONString];
//}
@end
